Return-Path: <netdev+bounces-283884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI0yLu+y+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:53:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBCB4C0274
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20A59307D52D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09513E3C45;
	Mon,  4 May 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CetqyqCd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3963E317A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904863; cv=none; b=QFyhrY2DVXrkKFEkVvCQHqm+Pbv0lZBfyVaSsVMDlyROM3oWsXJTyMe10paJyfTUq7Us2ZrogInR9tFkJkyGPwcjU3/JUJJ7VXkTKf32EZg3IeGp8m7sK94g8mQRu6UBp6ixu1U+C8a1d3GRJXF7PwdgHeyy0DZLI3+crVObPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904863; c=relaxed/simple;
	bh=vvEh2bcJjDHTEu49dfPKRZ5OIW+CAt6wUr8DC1l33J8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lOwUWZN5L1S+vcI0eVt4sji+Kmo1vWRnoFMb/zVdMUNsmPRfXbjM+g1zCvaHtT7wHc4fCmEiGDqU3ohVXXABy1Wthhi//NHRIc1lhv8E9s2V5gaicyApJw8EM8dbgiA+2YeJc4MO62vXIW8gURxPF+yNInA0QNd/g9CgVqgo2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CetqyqCd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-834f1075805so2771308b3a.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777904862; x=1778509662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y14fsCh2hvBLp5LgfY7vOJDAXfPr7uBAgs7IcUtTCWQ=;
        b=CetqyqCdIyuPHcO6ZRKCTX2uOO6A6oWWo/X2dnpQDer4EgNxgYel3idMhtjZGE0NX7
         ipN8CRXUPgAGfF1qdiQ/wnI7f9rx0f+bJL5wlLdvBldPggUGZGjufHE7CNOKq2jclhuV
         Ap1XWtqHGWI6iPVu6BsBDZLsmG6d9AaZj9sH3Up52MsV4lRxeDnFzc53tk2GSTaxZ19o
         iAIN2SanULeKl+3d/yHdQVTf/Z9yykGZn7qze8JNZqKArDtA3E2oivBbeUj2he9iiAKQ
         i/cJW02G54YY2rYEJOGnnyAKUpLXyl9xgif3m1uhvOaKOp41Fg+6AalVYe3QA2Kkd1im
         DcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904862; x=1778509662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y14fsCh2hvBLp5LgfY7vOJDAXfPr7uBAgs7IcUtTCWQ=;
        b=AgShu90QPD5lHBBw18ntQDZ56t/u3aJoeZZOFDRtHIil7Jdu98sJ7iJRJ1PZyTWrr6
         KpI3oh5rY418EerMtjH1cQROHnmprXH/e3l3OSbTsclBsL03pmauocaKFBq7ZxBnL/jE
         dBOWapLmog3IZxlApd+pidfNnAQ+RkNqjnFwDa5qCnlMMp6Ulu9I3JZkIRy1nMWPdqxU
         xofQgZ03ahmyNb0W5P4KoUoG96R7k3M2OqYtu79K7OAQf0xW9KFy9UoXkyfj8k7h2kys
         zfandDJaR76BdgBVWEhex0OljF8V5CQgzA/qMZopKHQr6Yr4kWTjGFfvLiaB8rCMlkMI
         MU8A==
X-Forwarded-Encrypted: i=1; AFNElJ8p6DuUJN5m+mm7MrTNw/wQZ6xLjTD+QV/M4GXZ6gWOEKJS8+QFzzXvfHNnHwOP9kJkIJa98ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9HvBrUGftH4y7cRCEH1OShUeyV8OBpBx2NOLGzAA2HaTnJCk
	hoMxbciEMZQdgBOFt0+Uc1szQfWDFTgRs+dgZHE3a8BvpX3lqakAEaEG
X-Gm-Gg: AeBDievlg7OE/YtEQnnC3gARN9kGT16bISVh4K00clD8Q6rvB4uiGRdqMwT9fSz3i8h
	5PGqQFxBVcmBiFxLBEUJSEoTMb8sBWJihBBxmTtVsDHt2P4RVzqqPCCIb8Q86ThAxmAfR2OhcfG
	xFdKtr9gBYUBQ3z2zSi0nPY95db5jh1xNzXhxqo9IO6Cv7JD2XGrxDXP1QiD5pkCMcb8s/UiVL1
	40tbi9Hl6WfeeYqncCmrNiEdJ+hUyV7NYu5gCxVbqfvRBbtYAE1SjnMZhvOox29z4LFVZqMIuwT
	PnMDIxSyvtdXeDIXh3OD0dhIYktE6gwO2rV3yeNmjJTh4RidrQd9reGVCqs/D1SiGX/GPsuE/gs
	6oxTB7f5/DbKAi/rXWy4v3VQBFddip0r/xxetkxYOwFBQyKQ8tEZiIBWoZg6RiLPyd+cwfpEWrn
	CS4Tm3vKpsFfBf1sPC6RB/ehNpi0bgTrg1SP4VyG3XRYEmgPdNwaAEuHn6
X-Received: by 2002:a05:6a00:1748:b0:832:e65:ddcd with SMTP id d2e1a72fcca58-8352d2ac0a2mr9386999b3a.45.1777904861465;
        Mon, 04 May 2026 07:27:41 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835293f022asm9111662b3a.45.2026.05.04.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:27:40 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	antony.antony@secunet.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] xfrm: route MIGRATE notifications to caller's netns
Date: Mon,  4 May 2026 22:27:36 +0800
Message-Id: <20260504142736.1228425-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BDBCB4C0274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-283884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ntu.edu.sg:mid,ntu.edu.sg:email]

xfrm_send_migrate() in net/xfrm/xfrm_user.c and pfkey_send_migrate()
in net/key/af_key.c both hardcode &init_net for the multicast that
announces a successful XFRM_MSG_MIGRATE / SADB_X_MIGRATE.

XFRM_MSG_MIGRATE arrives on a per-netns NETLINK_XFRM socket, and the
rest of the xfrm/af_key netlink path was made netns-aware in 2008.
The other 14 multicast paths in xfrm_user.c route their event using
xs_net(x), xp_net(xp) or sock_net(skb->sk); only the migrate path
was missed.

Two consequences of the init_net hardcoding:

  1. The notification (selector, old/new endpoint addresses, and the
     km_address) is delivered to listeners on init_net's
     XFRMNLGRP_MIGRATE / pfkey BROADCAST_ALL groups rather than on
     the issuing netns. An IKE daemon running in init_net therefore
     receives migration notifications originating from any other
     netns on the host.

  2. An IKE daemon running inside a non-init netns and subscribed
     to its own XFRMNLGRP_MIGRATE / pfkey groups never receives the
     notification of its own migration. IKEv2 MOBIKE / address-update
     handling inside a netns is silently broken.

Thread struct net through km_migrate() and the xfrm_mgr.migrate
function pointer, drop the &init_net override in xfrm_send_migrate()
and pfkey_send_migrate(), and pass the caller's net (already in
scope in xfrm_migrate() via sock_net(skb->sk)) all the way down.
struct xfrm_mgr is in-tree only and not exported as a stable API,
so the function-pointer signature change is internal.

pfkey_broadcast() is already netns-aware via net_generic(net,
pfkey_net_id) since the pernet conversion. The five other
pfkey_broadcast() callers in af_key.c already pass xs_net(x),
sock_net(sk) or a per-netns net, so this only removes the
&init_net outlier.

Fixes: 5c79de6e79cd ("[XFRM]: User interface for handling XFRM_MSG_MIGRATE")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 include/net/xfrm.h     | 3 ++-
 net/key/af_key.c       | 6 +++---
 net/xfrm/xfrm_policy.c | 2 +-
 net/xfrm/xfrm_state.c  | 4 ++--
 net/xfrm/xfrm_user.c   | 5 ++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 10d3edde6..874409127 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -715,6 +715,7 @@ struct xfrm_mgr {
 					   const struct xfrm_migrate *m,
 					   int num_bundles,
 					   const struct xfrm_kmaddress *k,
+					   struct net *net,
 					   const struct xfrm_encap_tmpl *encap);
 	bool			(*is_alive)(const struct km_event *c);
 };
@@ -1891,7 +1892,7 @@ int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
 #ifdef CONFIG_XFRM_MIGRATE
 int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_migrate *m, int num_bundles,
-	       const struct xfrm_kmaddress *k,
+	       const struct xfrm_kmaddress *k, struct net *net,
 	       const struct xfrm_encap_tmpl *encap);
 struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *net,
 						u32 if_id);
diff --git a/net/key/af_key.c b/net/key/af_key.c
index a166a88d8..9cffeef18 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3564,7 +3564,7 @@ static int set_ipsecrequest(struct sk_buff *skb,
 #ifdef CONFIG_NET_KEY_MIGRATE
 static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			      const struct xfrm_migrate *m, int num_bundles,
-			      const struct xfrm_kmaddress *k,
+			      const struct xfrm_kmaddress *k, struct net *net,
 			      const struct xfrm_encap_tmpl *encap)
 {
 	int i;
@@ -3669,7 +3669,7 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	}
 
 	/* broadcast migrate message to sockets */
-	pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_ALL, NULL, &init_net);
+	pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_ALL, NULL, net);
 
 	return 0;
 
@@ -3680,7 +3680,7 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 #else
 static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			      const struct xfrm_migrate *m, int num_bundles,
-			      const struct xfrm_kmaddress *k,
+			      const struct xfrm_kmaddress *k, struct net *net,
 			      const struct xfrm_encap_tmpl *encap)
 {
 	return -ENOPROTOOPT;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c944327ce..59968dcba 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4703,7 +4703,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	}
 
 	/* Stage 5 - announce */
-	km_migrate(sel, dir, type, m, num_migrate, k, encap);
+	km_migrate(sel, dir, type, m, num_migrate, k, net, encap);
 
 	xfrm_pol_put(pol);
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374a..8f1379681 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2837,7 +2837,7 @@ EXPORT_SYMBOL(km_policy_expired);
 #ifdef CONFIG_XFRM_MIGRATE
 int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_migrate *m, int num_migrate,
-	       const struct xfrm_kmaddress *k,
+	       const struct xfrm_kmaddress *k, struct net *net,
 	       const struct xfrm_encap_tmpl *encap)
 {
 	int err = -EINVAL;
@@ -2848,7 +2848,7 @@ int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	list_for_each_entry_rcu(km, &xfrm_km_list, list) {
 		if (km->migrate) {
 			ret = km->migrate(sel, dir, type, m, num_migrate, k,
-					  encap);
+					  net, encap);
 			if (!ret)
 				err = ret;
 		}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d56450f61..b39c33276 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3271,10 +3271,9 @@ static int build_migrate(struct sk_buff *skb, const struct xfrm_migrate *m,
 
 static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			     const struct xfrm_migrate *m, int num_migrate,
-			     const struct xfrm_kmaddress *k,
+			     const struct xfrm_kmaddress *k, struct net *net,
 			     const struct xfrm_encap_tmpl *encap)
 {
-	struct net *net = &init_net;
 	struct sk_buff *skb;
 	int err;
 
@@ -3292,7 +3291,7 @@ static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 #else
 static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			     const struct xfrm_migrate *m, int num_migrate,
-			     const struct xfrm_kmaddress *k,
+			     const struct xfrm_kmaddress *k, struct net *net,
 			     const struct xfrm_encap_tmpl *encap)
 {
 	return -ENOPROTOOPT;

base-commit: bd3a4795d5744f59a1f485379f1303e5e606f377
-- 
2.34.1


