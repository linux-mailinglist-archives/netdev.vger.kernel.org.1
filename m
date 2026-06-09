Return-Path: <netdev+bounces-297331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MGRPOGaSKGqnGQMAu9opvQ
	(envelope-from <netdev+bounces-297331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E76648B6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:23:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=BVDvGd3x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297331-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297331-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E223028446
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620D94D8DA7;
	Tue,  9 Jun 2026 22:20:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E33E8346
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043617; cv=none; b=XdHVwnm0fLRQvsPvkuYaIF9cFEBcmHDBWotvowliQvTq2Qyk3k+S6Gbo+TQGm871X7dyv4ThXlpYDh3lz/ENpoMEbaoevPbTlThsi+4GN2LYj2ZqE7FF960loBtER4lDaBlJLpJN7U92nyoI1nBRPyfhMstiwZVwM8xw+VOdo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043617; c=relaxed/simple;
	bh=EqTT5tOiyTBk18B3BNikHp1yob3uWpr9xUkDein6Ufs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EiZe6p+/ZIuYcQ6ncUJOwIZbdvMuS/kVxLp0U7v/WLSMoOSJu//4U/iJ2l4QOzVY5RR3esd8+3xTVz7zHe1ibauiYbHCknCfgAUub4oo/2sGUSb8al7YoOdgo2z490TUN3fzsmnn8cqwkvlVL31gVefcsOULSJhB27Lxxd/hRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVDvGd3x; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf32259e0eso79903075ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781043615; x=1781648415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c0GNldkKOhQ/CboHtYs45Xefq+GkwGHDrlXy7PykbU0=;
        b=BVDvGd3xthRCllPGpIXkIPsMvhsdw4fONCTR3+pCSeHk5BkXiGXdR+diC0kSFt1/Qh
         EmhPvQkzu+Yrff8sFNQv0j1WuAnx/WSymuU+jVXZBP9KLYXNK8HJr1PbxWknLAqv8I4Z
         o3AbzpvcAiLsf6uvDbPT2/NeuQG9gYy0FrLnZMTMYbOS70mtXBCQhoeNTR6AZzJJEi1A
         UJHIhN0halVRYk9SvbTUtw2tzkosZJlR0lGynJ+gLg/XAYYRg5zUrlfF5NeYC/wVuONk
         2f4K5k4XdZ74DikJVdV/X+sWyqiNa7IhRpUDGvxHRYI0j8+2NjWNeMjM5e5MM2zUsmzd
         4n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043615; x=1781648415;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0GNldkKOhQ/CboHtYs45Xefq+GkwGHDrlXy7PykbU0=;
        b=NrBkZclIki4ussxQtDHG7VjbkRfuVpPFFwKZtiM1EdFC8zdYc6H0YlnW82UUvbrSws
         hSJ2f5RN7mN11+t8lBdszHNO0LzoEpdjubuVzNI2sohtiLAI1pYCBe6V3/BFsGb2m4fR
         X4b5NgzABNtns+ldyQ5HCEHv6YsJrOOR7tnmVTLq4rLpeuBZZfe5OFRv3wyjhWhTrXze
         WWQvogZY2zETFrJrqVTUn3OaCHT1R369lkTWrVFy36Je1L+raiJ9KLeOiW1Od37tFE8p
         VqpLOrcOwAV1OAhRZV4PROvA4oT7MR3XmsNKEw8dlb8eYlBRlCn2nza9PCJVSxmqKy2a
         nNYA==
X-Forwarded-Encrypted: i=1; AFNElJ9yMKrE9GGQKM8O9/HA+NCDEwa4T/RXPEmtC2TikP2w3GDdalXgMB4VNmv2YyYl6sAtAy0Bi5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6bjq4xA4Lb4P1E/Ok35L/YcWkZKpzQRAg+cKEdog+86k0ArC
	SmxrZ9DPxAUjYicH+EiJsW1/ntVRaIjA6DCjiuMTxLba4jhESf+KWjkJRXMZr1EdO3NkaxdWUc0
	s0E7x2g==
X-Received: from plby21.prod.google.com ([2002:a17:902:ed55:b0:2bd:a0e6:1a81])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228b:b0:2c0:d4a8:85d0
 with SMTP id d9443c01a7336-2c1e85ac3e2mr263729905ad.32.1781043614881; Tue, 09
 Jun 2026 15:20:14 -0700 (PDT)
Date: Tue,  9 Jun 2026 22:20:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609222013.1550355-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] ipmr: Convert mr_table.cache_resolve_queue_len to u32.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297331-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 706E76648B6

mr_table.cache_resolve_queue_len is always updated under
spin_lock_bh(&mfc_unres_lock).

Let's convert it to u32.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/mroute_base.h |  2 +-
 net/ipv4/ipmr.c             | 18 ++++++++++--------
 net/ipv6/ip6mr.c            | 12 +++++++-----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 5d75cc5b057e..4d55827e9705 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -256,7 +256,7 @@ struct mr_table {
 	struct rhltable		mfc_hash;
 	struct list_head	mfc_cache_list;
 	int			maxvif;
-	atomic_t		cache_resolve_queue_len;
+	u32			cache_resolve_queue_len;
 	bool			mroute_do_assert;
 	bool			mroute_do_pim;
 	bool			mroute_do_wrvifwhole;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 78dbeecf71bb..1d9a4ac14fce 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -761,7 +761,8 @@ static void ipmr_destroy_unres(struct mr_table *mrt, struct mfc_cache *c)
 	struct sk_buff *skb;
 	struct nlmsgerr *e;
 
-	atomic_dec(&mrt->cache_resolve_queue_len);
+	WRITE_ONCE(mrt->cache_resolve_queue_len,
+		   mrt->cache_resolve_queue_len - 1);
 
 	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved))) {
 		if (ip_hdr(skb)->version == 0) {
@@ -1180,11 +1181,12 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 		if (err < 0)
 			goto err;
 
-		atomic_inc(&mrt->cache_resolve_queue_len);
+		WRITE_ONCE(mrt->cache_resolve_queue_len,
+			   mrt->cache_resolve_queue_len + 1);
 		list_add(&c->_c.list, &mrt->mfc_unres_queue);
 		mroute_netlink_event(mrt, c, RTM_NEWROUTE);
 
-		if (atomic_read(&mrt->cache_resolve_queue_len) == 1)
+		if (mrt->cache_resolve_queue_len == 1)
 			mod_timer(&mrt->ipmr_expire_timer,
 				  c->_c.mfc_un.unres.expires);
 	}
@@ -1297,7 +1299,8 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
 		if (uc->mfc_origin == c->mfc_origin &&
 		    uc->mfc_mcastgrp == c->mfc_mcastgrp) {
 			list_del(&_uc->list);
-			atomic_dec(&mrt->cache_resolve_queue_len);
+			WRITE_ONCE(mrt->cache_resolve_queue_len,
+				   mrt->cache_resolve_queue_len - 1);
 			found = true;
 			break;
 		}
@@ -1356,7 +1359,7 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 	}
 
 	if (flags & MRT_FLUSH_MFC) {
-		if (atomic_read(&mrt->cache_resolve_queue_len) != 0 || !check_net(net)) {
+		if (READ_ONCE(mrt->cache_resolve_queue_len) || !check_net(net)) {
 			spin_lock_bh(&mfc_unres_lock);
 			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
 				list_del(&c->list);
@@ -2962,10 +2965,9 @@ static int ipmr_rtm_route(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 static bool ipmr_fill_table(struct mr_table *mrt, struct sk_buff *skb)
 {
-	u32 queue_len = atomic_read(&mrt->cache_resolve_queue_len);
-
 	if (nla_put_u32(skb, IPMRA_TABLE_ID, mrt->id) ||
-	    nla_put_u32(skb, IPMRA_TABLE_CACHE_RES_QUEUE_LEN, queue_len) ||
+	    nla_put_u32(skb, IPMRA_TABLE_CACHE_RES_QUEUE_LEN,
+			READ_ONCE(mrt->cache_resolve_queue_len)) ||
 	    nla_put_s32(skb, IPMRA_TABLE_MROUTE_REG_VIF_NUM,
 			READ_ONCE(mrt->mroute_reg_vif_num)) ||
 	    nla_put_u8(skb, IPMRA_TABLE_MROUTE_DO_ASSERT,
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 5a4816225fb1..604a58838901 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -817,7 +817,8 @@ static void ip6mr_destroy_unres(struct mr_table *mrt, struct mfc6_cache *c)
 	struct net *net = read_pnet(&mrt->net);
 	struct sk_buff *skb;
 
-	atomic_dec(&mrt->cache_resolve_queue_len);
+	WRITE_ONCE(mrt->cache_resolve_queue_len,
+		   mrt->cache_resolve_queue_len - 1);
 
 	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved)) != NULL) {
 		if (ipv6_hdr(skb)->version == 0) {
@@ -1225,7 +1226,8 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 		if (err < 0)
 			goto err;
 
-		atomic_inc(&mrt->cache_resolve_queue_len);
+		WRITE_ONCE(mrt->cache_resolve_queue_len,
+			   mrt->cache_resolve_queue_len + 1);
 		list_add(&c->_c.list, &mrt->mfc_unres_queue);
 		mr6_netlink_event(mrt, c, RTM_NEWROUTE);
 
@@ -1538,7 +1540,8 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 		if (ipv6_addr_equal(&uc->mf6c_origin, &c->mf6c_origin) &&
 		    ipv6_addr_equal(&uc->mf6c_mcastgrp, &c->mf6c_mcastgrp)) {
 			list_del(&_uc->list);
-			atomic_dec(&mrt->cache_resolve_queue_len);
+			WRITE_ONCE(mrt->cache_resolve_queue_len,
+				   mrt->cache_resolve_queue_len - 1);
 			found = true;
 			break;
 		}
@@ -1599,8 +1602,7 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 	}
 
 	if (flags & MRT6_FLUSH_MFC) {
-		if (atomic_read(&mrt->cache_resolve_queue_len) != 0 ||
-		    !check_net(net)) {
+		if (READ_ONCE(mrt->cache_resolve_queue_len) || !check_net(net)) {
 			spin_lock_bh(&mfc_unres_lock);
 			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
 				list_del(&c->list);
-- 
2.54.0.1099.g489fc7bff1-goog


