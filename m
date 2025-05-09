Return-Path: <netdev+bounces-189286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680EAB1767
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECC2A20288
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A357221540;
	Fri,  9 May 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FF3W8Oax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B49620DD72
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800873; cv=none; b=o/UydFZwLSi67mGf96GKi0U4VL8twIJDvcuSbfwqiJas1mB62/Gra+rgxy20PxNI+r/rvveBiEKZ99d36AMt7oHZGb5y00b2PfAM47d9bbtFt2geKrG4iUnVl9E74epRe0hxUrR8qCuwTShvu3GEtDxyxXI0TqIfvsMhl8mD/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800873; c=relaxed/simple;
	bh=ker0ZCrsULp4DbzQUJtD7dsek2sFjgY7qw780T6E1nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSQ43cU7V651gkNAhQjg+COrvxcokxWCUmH3dIP2P5R6XF5xfjXfyDoyfdgmz8mP+bxmYNylMO9mtDHyzr30fR+HyaoPIywD0vGRhIbQbeM5OKMzOVmHKUTUx6cckfrCRllJrL4cpj2eoOS/cRUUJU3/f5rtUWQmEPqKBFEdrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FF3W8Oax; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso20358955e9.1
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800869; x=1747405669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GPwxQflXGDdwZQt+YF5SsBg1AMQG2qErnDLNr3K4u0=;
        b=FF3W8OaxXgT36DmWJdpS1Hvp9n01jFWFAskGgWFZJpEIHn/G1jpUVj33ebBHb5/d58
         bRJMT5IfkE2x3BXsXzkRWuWDvkKGakXa7JtbEb1mAttvb69rFix6hIJJFb798PEYXVaR
         PZrSMfyMntUM3h5gSFo+H+RcwO4MW7SXLgbW82kHunGgWMDe1G9ao5ZpFyi9gI76IAVT
         6dpKCpkDljzwDS6dVE3iuUiREyuBM4vnx96CXh7Szcz+uzYggIFvH9kuRZyCWjcuwSGV
         f51Ot56MC6PXbcBunWjibn8LCCe5iZYgMuSslvwP74X5hK9RlO1yw0kWh38pSGxNkh5m
         Yrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800869; x=1747405669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GPwxQflXGDdwZQt+YF5SsBg1AMQG2qErnDLNr3K4u0=;
        b=lajjtt/94FLDzH7zQFqW56pievPUl/SvAl6hOfIB5IlaKp0ehP6BaPT717IosIg2yS
         J7x68G7KmeRMotE8fbQFKtt8qFb5N98Kb9RP8mkzXQdY7to7k7x7ZUhzFLuEwHufmJo6
         hO+zwaODyr6iO4HGQKbc+K+FLeHqsPsHmdsiYMuFSWJzWC/6sbOR02IeRVs4jlrjkQoo
         prUZedBRpShOnElG4mSGlWsQgbgrU8ZJWTe/ss+dc71Z3mbawDYitTbiw4ri5SUKv10O
         0NOmidHFHZTI4ngStDvLLjwwU8r+jc0K+mgeurqA/p66blGP92h5dkEn7oJzsVlw/N9F
         QQFA==
X-Gm-Message-State: AOJu0YysDPWVsSyjOvicacGmdsM09R7zZKV9f8TRlwLTW9Kd2xVuHm2W
	DjpyocZYgqLR1eeKSwrlK4SjiFdP6sjawK5PqbxSiYZhH8Q2/9sA2Qhi2FOdyH5pMbZI9dusXZC
	LIS1qAB8hJrSd4oTEnZls5OBgaaHbiDrh/iBJamSbvzOcm5YAgrRICwQCViin
X-Gm-Gg: ASbGncueIDl8Om9hQSigQay8XTr2Wkh5xlpTXvvS/e2IltZ4e9vlIOMonV9rboP603q
	4dgmGkALNoH9qwgwLBXouS/w8GqWNRrzz7ytLYI/Hisdaf8SsBpl6fQtv4loyNvMtpgZgR2fYkK
	4buQpbv7Y5BfzN6QyjtP30jfC1tR5Zxk5N5UaWMxEkGSXXNh1CJmMYKxOAyA8N2Vos16Hxkr7w8
	/5kE8gWLC/pLfKCSa1SuhzocPZKpe7gE0SVwQPKzD6jPv3Nip/8JPefSvdAbOS7J5tmixr7Njqb
	3/8yQ8dHOdrkCfcjM54BVKshwEsrNvjCw6H0HLuYn15xAHZX7S/p6ryTNTd+JPA=
X-Google-Smtp-Source: AGHT+IFJHAM6cvRv2vjZEemx3nx8yocu4vdcyj+srEumdthuXTA5kB4GdA19BrB579ciUZrJFaQzTA==
X-Received: by 2002:a05:600c:1d8c:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-442d6d64aefmr32904415e9.15.1746800869103;
        Fri, 09 May 2025 07:27:49 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:48 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Gert Doering <gert@greenie.muc.de>
Subject: [PATCH net-next 10/10] ovpn: ensure sk is still valid during cleanup
Date: Fri,  9 May 2025 16:26:20 +0200
Message-ID: <20250509142630.6947-11-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of UDP peer timeout, an openvpn client (userspace)
performs the following actions:
1. receives the peer deletion notification (reason=timeout)
2. closes the socket

Upon 1. we have the following:
- ovpn_peer_keepalive_work()
 - ovpn_socket_release()
  - synchronize_rcu()
At this point, 2. gets a chance to complete and ovpn_sock->sock->sk
becomes NULL. ovpn_socket_release() will then attempt dereferencing it,
resulting in the following crash log:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000077: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000003b8-0x00000000000003bf]
CPU: 12 UID: 0 PID: 162 Comm: kworker/12:1 Tainted: G           O        6.15.0-rc2-00635-g521139ac3840 #272 PREEMPT(full)
Tainted: [O]=OOT_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
Workqueue: events ovpn_peer_keepalive_work [ovpn]
RIP: 0010:ovpn_socket_release+0x23c/0x500 [ovpn]
Code: ea 03 80 3c 02 00 0f 85 71 02 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 64 24 18 49 8d bc 24 be 03 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 30
RSP: 0018:ffffc90000c9fb18 EFLAGS: 00010217
RAX: dffffc0000000000 RBX: ffff8881148d7940 RCX: ffffffff817787bb
RDX: 0000000000000077 RSI: 0000000000000008 RDI: 00000000000003be
RBP: ffffc90000c9fb30 R08: 0000000000000000 R09: fffffbfff0d3e840
R10: ffffffff869f4207 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888115eb9300 R14: ffffc90000c9fbc8 R15: 000000000000000c
FS:  0000000000000000(0000) GS:ffff8882b0151000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37266b6114 CR3: 00000000054a8000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 unlock_ovpn+0x8b/0xe0 [ovpn]
 ovpn_peer_keepalive_work+0xe3/0x540 [ovpn]
 ? ovpn_peers_free+0x780/0x780 [ovpn]
 ? lock_acquire+0x56/0x70
 ? process_one_work+0x888/0x1740
 process_one_work+0x933/0x1740
 ? pwq_dec_nr_in_flight+0x10b0/0x10b0
 ? move_linked_works+0x12d/0x2c0
 ? assign_work+0x163/0x270
 worker_thread+0x4d6/0xd90
 ? preempt_count_sub+0x4c/0x70
 ? process_one_work+0x1740/0x1740
 kthread+0x36c/0x710
 ? trace_preempt_on+0x8c/0x1e0
 ? kthread_is_per_cpu+0xc0/0xc0
 ? preempt_count_sub+0x4c/0x70
 ? _raw_spin_unlock_irq+0x36/0x60
 ? calculate_sigpending+0x7b/0xa0
 ? kthread_is_per_cpu+0xc0/0xc0
 ret_from_fork+0x3a/0x80
 ? kthread_is_per_cpu+0xc0/0xc0
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in: ovpn(O)

Reason for accessing sk is ithat we need to retrieve its
protocol and continue the cleanup routine accordingly.

Fix the crash by grabbing a reference to sk before proceeding
with the cleanup. If the refcounter has reached zero, we
know that the socket is being destroyed and thus we skip
the cleanup in ovpn_socket_release().

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Dumazet <edumazet@google.com>
Reported-by: Qingfang Deng <dqfext@gmail.com>
Tested-By: Gert Doering <gert@greenie.muc.de>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/socket.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index a83cbab72591..66a2ecbc483b 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -66,6 +66,7 @@ static bool ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
 void ovpn_socket_release(struct ovpn_peer *peer)
 {
 	struct ovpn_socket *sock;
+	struct sock *sk;
 	bool released;
 
 	might_sleep();
@@ -75,13 +76,14 @@ void ovpn_socket_release(struct ovpn_peer *peer)
 	if (!sock)
 		return;
 
-	/* sanity check: we should not end up here if the socket
-	 * was already closed
+	/* sock->sk may be released concurrently, therefore we
+	 * first attempt grabbing a reference.
+	 * if sock->sk is NULL it means it is already being
+	 * destroyed and we don't need any further cleanup
 	 */
-	if (!sock->sock->sk) {
-		DEBUG_NET_WARN_ON_ONCE(1);
+	sk = sock->sock->sk;
+	if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))
 		return;
-	}
 
 	/* Drop the reference while holding the sock lock to avoid
 	 * concurrent ovpn_socket_new call to mess up with a partially
@@ -90,18 +92,18 @@ void ovpn_socket_release(struct ovpn_peer *peer)
 	 * Holding the lock ensures that a socket with refcnt 0 is fully
 	 * detached before it can be picked by a concurrent reader.
 	 */
-	lock_sock(sock->sock->sk);
+	lock_sock(sk);
 	released = ovpn_socket_put(peer, sock);
-	release_sock(sock->sock->sk);
+	release_sock(sk);
 
 	/* align all readers with sk_user_data being NULL */
 	synchronize_rcu();
 
 	/* following cleanup should happen with lock released */
 	if (released) {
-		if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
+		if (sk->sk_protocol == IPPROTO_UDP) {
 			netdev_put(sock->ovpn->dev, &sock->dev_tracker);
-		} else if (sock->sock->sk->sk_protocol == IPPROTO_TCP) {
+		} else if (sk->sk_protocol == IPPROTO_TCP) {
 			/* wait for TCP jobs to terminate */
 			ovpn_tcp_socket_wait_finish(sock);
 			ovpn_peer_put(sock->peer);
@@ -111,6 +113,7 @@ void ovpn_socket_release(struct ovpn_peer *peer)
 		 */
 		kfree(sock);
 	}
+	sock_put(sk);
 }
 
 static bool ovpn_socket_hold(struct ovpn_socket *sock)
-- 
2.49.0


