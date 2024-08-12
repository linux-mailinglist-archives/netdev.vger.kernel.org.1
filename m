Return-Path: <netdev+bounces-117870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF6394FA22
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457E01F2655E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF719ADA3;
	Mon, 12 Aug 2024 23:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0573C199EB0
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503844; cv=none; b=HYtQWWCbayvksGqya/tt22OffkOdtiIymSCgpRy+//BZQM2YSVtPGopLI1FxJxlFwtKyLEG/VaS0UaYn7+xon/kknmtSofBcYdg4v5RAZuL0Flsg4n4whs3H30AAD0jKJdvBd7995EoTj4oTLuFvNec8NSefKIE2OkqhErBOaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503844; c=relaxed/simple;
	bh=CyU+hxzdcwPR469j6Uc+0jebeFeHl5UcJgnEKUdSkPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3qrGsg0tYa/WCAjwyde9TENGOTHAg3I8Zk/FCCwQRO8jDnsLXLgHB6kSoyH4YY5RlUla5N37XhqslWeU+gh1ijg70/OEQa3qA1k9pc1tzd9YOiQLxVP13Qr/Wg3kmpreIox7vJRd6ld/skNLxQgay0EPnmNREcv0XlOMK2uqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sde4z-0002AI-Kd; Tue, 13 Aug 2024 01:03:57 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
Subject: [PATCH net] tcp: prevent concurrent execution of tcp_sk_exit_batch
Date: Tue, 13 Aug 2024 00:28:25 +0200
Message-ID: <20240812222857.29837-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240812200039.69366-1-kuniyu@amazon.com>
References: <20240812200039.69366-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its possible that two threads call tcp_sk_exit_batch() concurrently,
once from the cleanup_net workqueue, once from a task that failed to clone
a new netns.  In the latter case, error unwinding calls the exit handlers
in reverse order for the 'failed' netns.

tcp_sk_exit_batch() calls tcp_twsk_purge().
Problem is that since commit b099ce2602d8 ("net: Batch inet_twsk_purge"),
this function picks up twsk in any dying netns, not just the one passed
in via exit_batch list.

This means that the error unwind of setup_net() can "steal" and destroy
timewait sockets belonging to the exiting netns.

This allows the netns exit worker to proceed to call

WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));

without the expected 1 -> 0 transition, which then splats.

At same time, error unwind path that is also running inet_twsk_purge()
will splat as well:

WARNING: .. at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210
...
 refcount_dec include/linux/refcount.h:351 [inline]
 inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
 inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221
 inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
 tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
 setup_net+0x714/0xb40 net/core/net_namespace.c:375
 copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
 create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110

... because refcount_dec() of tw_refcount unexpectedly dropped to 0.

This doesn't seem like an actual bug (no tw sockets got lost and I don't
see a use-after-free) but as erroneous trigger of debug check.

Add a mutex to force strict ordering: the task that calls tcp_twsk_purge()
blocks other task from doing final _dec_and_test before mutex-owner has
removed all tw sockets of dying netns.

Fixes: e9bd0cca09d1 ("tcp: Don't allocate tcp_death_row outside of struct netns_ipv4.")
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>
Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000003a5292061f5e4e19@google.com/
Link: https://lore.kernel.org/netdev/20240812140104.GA21559@breakpoint.cc/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv4/tcp_ipv4.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd17f25ff288..a4e510846905 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -97,6 +97,8 @@ static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) = {
 	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
 };
 
+static DEFINE_MUTEX(tcp_exit_batch_mutex);
+
 static u32 tcp_v4_init_seq(const struct sk_buff *skb)
 {
 	return secure_tcp_seq(ip_hdr(skb)->daddr,
@@ -3514,6 +3516,16 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
 {
 	struct net *net;
 
+	/* make sure concurrent calls to tcp_sk_exit_batch from net_cleanup_work
+	 * and failed setup_net error unwinding path are serialized.
+	 *
+	 * tcp_twsk_purge() handles twsk in any dead netns, not just those in
+	 * net_exit_list, the thread that dismantles a particular twsk must
+	 * do so without other thread progressing to refcount_dec_and_test() of
+	 * tcp_death_row.tw_refcount.
+	 */
+	mutex_lock(&tcp_exit_batch_mutex);
+
 	tcp_twsk_purge(net_exit_list);
 
 	list_for_each_entry(net, net_exit_list, exit_list) {
@@ -3521,6 +3533,8 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
 		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
 		tcp_fastopen_ctx_destroy(net);
 	}
+
+	mutex_unlock(&tcp_exit_batch_mutex);
 }
 
 static struct pernet_operations __net_initdata tcp_sk_ops = {
-- 
2.44.2


