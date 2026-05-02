Return-Path: <netdev+bounces-283372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MXVfNQWF9WlfMAIAu9opvQ
	(envelope-from <netdev+bounces-283372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 07:00:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 611334B0FAB
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 07:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DB1B3024515
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 05:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F129E11A;
	Sat,  2 May 2026 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI/tRLa6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3CD1CEAC2
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777698045; cv=none; b=mE+8lu8plhX6TzLrBHr1f+DoG2VVKdsUlkeF7Tm416qdDcAnO7dymm/0Ls/D062RyrYZ1FTYwahka9U5sCXhyHWMlG2ALKHVxd84Jq91YdCoDIeWkQ5cxmBhoVu2QruZ00jaOZj25k0Nvv+Cs6cOgDC+YEhD95paH41vCNCfBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777698045; c=relaxed/simple;
	bh=ver2UoWpS2YcfE27GaQTuIn81K78hKcA2yLnGa8/hiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eTqF+AOoBocEDPxZuthP+TNoiBUcpUhz3s03xgAFeXIBh8nOiNQ6gzDzULB+jXwyySGV1otipLps9UldjxtHESh32LyTCwvPeEq+uVwjSjzHpnGRVf6UI6Ky2g1ee3cbNvM0QSgB+cxZ9Mhj8huKjbn/emFdmdfasMW/TuNklKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI/tRLa6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-364eef1891dso779376a91.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 22:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777698043; x=1778302843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd4mi+oKC8Y6Z2wEWlSkY1p2DPTiyoqQPePQg0Iz5kc=;
        b=XI/tRLa6sYagm2yYw51q9lWcK22L6ZqGnIdLX6qXMUeK8SajyUhORqqcvXzEYcFol5
         Vs2lO6Qr2ImfZ5+rUBtFHlLBCbz4n1sLCqhMdsrB+zuNvbRxV9DgduovYoNf64juSpdM
         EGbgDMQSrLYmRiPo2zASDlhNu2OKpKI9Bss59j4joWwZdphUF8mmTbzJoY0mB4euV6o2
         sVCw0KnKImJHTyDViF/AO0cBkHkhqB8BR/U5YhGy1VjOeiWzft64nsdo5uN1BHur8a46
         fumZy8JoS4byyv+d0BSERdnGzVh5ZSs0FVke8eRXE05rFAnPwfC2tRHQJkANcfH8M92n
         2HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777698043; x=1778302843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd4mi+oKC8Y6Z2wEWlSkY1p2DPTiyoqQPePQg0Iz5kc=;
        b=D4n/7ZX1XMWQwmn6Y0rk4CGvPbd/LEXHaohKtWgy6lB6JfrxJEBsc7dkPbX47467xW
         O3esZLawT5GTec0+QYoEAbuoslcX2I9UcK+AhAJ5ZLOw0sgI07zSx4KXs0lE+KaY3fcw
         NBJUGlH9Kl8RmyBR1RoeKyxcQrDjLSRH3su/3mjUg4Pl5e8hqEALOLxhLfgJw6XkmTEk
         OACSfJVexw6b23LE8ylZL2iUErBqVkpgnpp6DsS2VvQbgexXzISf0LX7PhW3IyLXsOQj
         noEhQYmaL1zf7hkvRJZ5R1KEFigIejt8+kjl06HHTmH7N8aLKl1ZaMyYnZU+2r5rCNLb
         ibVg==
X-Gm-Message-State: AOJu0Yw+OqN/lIbZdl49BbcKCxNXqI+yfIEA1dtwO5WWAUy7c9xZreyh
	i6mVdYEHGvOW1Qirf+9Ecrr2IDOHxfGbii9zxsAJsEJugKaqg+D22DwFCMgmmQ==
X-Gm-Gg: AeBDiev+xagUN4QIE5IVhiaNajTAvdKfSMQJCtpLoeytV7cy+raL1NC5eiZv7HYQDF1
	53S05h6qB7NFJEaUOg9bn0akKmFMQT2IkA/jCf1wVKA3DlQaEy9OO1Pc06r9zv9eW8z5ZG0iDJ+
	Tya44Mwai1KexDjP3VCQUEE41KZ4u4YTlmJ/GLtvOVRzlHUrhuKY7Q4osh3NCFQSdJgLSAkh5Xe
	+9rpe+ouLDz50fTNSp3VW40eI1WnDqmufs05c8Znk4YzQ5hMsRc53z6ZpFaPie2Wnw0KFiaWQ9v
	8tTP79/12XN6RkK9l3qzWlvLz4F0ENLCrdwj1FVs9smcES9LxwW/JYITu307OZfPQrfRBGkIt+Z
	ml9rydkO3cxBRt2HGbkLHJ5PNdSGmcjy7xUp2rcqZzF9yziTE5Z9DDf6x49YbRxZqQGorOqnCt9
	8lr7Wk45TNA1VX9w9lAEreKClzo3qEx7fHdnUGfTvvtLG9RGmHmeJMk63pIM10K112AUo=
X-Received: by 2002:a17:90b:17d0:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-3650ce552camr2070944a91.23.1777698043292;
        Fri, 01 May 2026 22:00:43 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec03c944sm3822498a91.15.2026.05.01.22.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:00:42 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
Date: Sat,  2 May 2026 13:00:37 +0800
Message-Id: <20260502050037.3800122-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 611334B0FAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-283372-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,kernel.org,davemloft.net,ms2.inr.ac.ru,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:mid,ntu.edu.sg:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
scope and shared across netns. mem_check() reads fl_size to decide
whether to deny non-CAP_NET_ADMIN callers; capable() runs against
init_user_ns, so an unprivileged user in any non-init userns can
push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
other unprivileged userns on the host.

Add struct netns_ipv6::flowlabel_count, bumped and decremented next
to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new field
is placed in the existing 4-byte hole after ipmr_seq, so struct
netns_ipv6 stays the same size on 64-bit builds.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the file
was added; machines and connection counts have grown.

mem_check() folds an extra per-netns ceiling into the existing
non-CAP_NET_ADMIN conditional. The ceiling is half of the total
budget that unprivileged callers have ever been able to use, i.e.
(FL_MAX_SIZE - FL_MAX_SIZE/4) / 2 = 3072 entries. With FL_MAX_SIZE
doubled, this preserves the original per-user reach (~3K, what an
unprivileged caller could already obtain before this change) while
forcing an attacker to spread allocations across at least two
netns to exhaust the global non-CAP_NET_ADMIN budget.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
v5 (this submission, addressing v4 review by Willem):
    - Replaced the per-netns ceiling FL_MAX_SIZE/8 with the
      computed unpriv_user_limit = (FL_MAX_SIZE - FL_MAX_SIZE/4)/2,
      which evaluates to 3072. v4's FL_MAX_SIZE/8 = 1024 would have
      reduced the per-user budget below the ~3K an unprivileged
      caller could already obtain before any of this work, defeating
      the reason FL_MAX_SIZE was doubled in the first place. The new
      ceiling preserves the original per-user reach while still
      requiring an attacker to spread across at least two netns to
      drain the global non-CAP_NET_ADMIN budget.
    - Reworded the corresponding paragraph in the commit body.
v4: addressed Willem's v3 review on netdev. Dropped the
    flowlabel_has_excl cacheline argument in favour of "fills the
    existing 4-byte hole after ipmr_seq", and reordered
    atomic_dec(&...flowlabel_count) to sit immediately after
    atomic_dec(&fl_size) in ip6_fl_gc and ip6_fl_purge.
v3: addressed Willem's review on the private security@ thread.
    Merged FL_MAX_SIZE doubling, dropped test data, moved
    flowlabel_count near ipmr_seq, inlined fl->fl_net in ip6_fl_gc.
v2: per-netns counter + cap, sent to security@ as a 2-patch series.
v1: fix-shape sketch in original disclosure.

 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 34bdb1308..329482373 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	unsigned int ipmr_seq; /* protected by rtnl_mutex */
+	atomic_t		flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..758a2fc4d 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -36,7 +36,7 @@
 /* FL hash table */
 
 #define FL_MAX_PER_SOCK	32
-#define FL_MAX_SIZE	4096
+#define FL_MAX_SIZE	8192
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
@@ -162,8 +162,9 @@ static void ip6_fl_gc(struct timer_list *unused)
 				ttd = fl->expires;
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
-					fl_free(fl);
 					atomic_dec(&fl_size);
+					atomic_dec(&fl->fl_net->ipv6.flowlabel_count);
+					fl_free(fl);
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -195,8 +196,9 @@ static void __net_exit ip6_fl_purge(struct net *net)
 			if (net_eq(fl->fl_net, net) &&
 			    atomic_read(&fl->users) == 0) {
 				*flp = fl->next;
-				fl_free(fl);
 				atomic_dec(&fl_size);
+				atomic_dec(&net->ipv6.flowlabel_count);
+				fl_free(fl);
 				continue;
 			}
 			flp = &fl->next;
@@ -245,6 +247,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	atomic_inc(&fl_size);
+	atomic_inc(&net->ipv6.flowlabel_count);
 	spin_unlock_bh(&ip6_fl_lock);
 	rcu_read_unlock();
 	return NULL;
@@ -464,6 +467,9 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
+	const int unpriv_user_limit = unpriv_total_limit / 2;
+	struct net *net = sock_net(sk);
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -478,7 +484,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE/2) ||
+	      room < FL_MAX_SIZE/4 ||
+	      atomic_read(&net->ipv6.flowlabel_count) >= unpriv_user_limit) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
-- 
2.34.1


