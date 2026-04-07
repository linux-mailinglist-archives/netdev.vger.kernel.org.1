Return-Path: <netdev+bounces-276165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOB2HQF21WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:24:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCBF3B5011
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DED9630C4A31
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3515037C90C;
	Tue,  7 Apr 2026 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZbtFDxM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592C228CB8
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596809; cv=none; b=bmsvkrq5KLyoTFQ7YtOB1I1ohWTuypuftm4La0UJziqG2OzXgov6mrQn24NbVSH/rKjLStzBxsDPaGeG+OkKZ0DxJN69cl8Lu3hHnbGWmk+AiZc8OMrJG8ae9nOS41CbXmJoXwihRhyQPSwnSjPyjUL2xvrTPRB9NpcwdsoV/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596809; c=relaxed/simple;
	bh=QPAVgILUjRRGDOG7GMlNiQNmgHUj6lSeoi656rZCTbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O5r4rEQpb7XG+jis5KapXOKSSE+/h7XDAdfgRDo6Spz9wcqBsOlxGjcTipGXjafygPXBi3afwAwAAp2cyQ+jBP21IBB3EMr62+/7kPfGIpB76Ie83vZvxKu1paGsWDXcgKEuDFlflmB2V4h84Yg1+uAPh/amAODLyslUv8RpVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZZbtFDxM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c7ec40f92so7245213b3a.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596807; x=1776201607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcVKv0sQ44FyUo4I68FZifCBpScEWMQjoICDyHB7V4E=;
        b=ZZbtFDxMElOAVLtgkfvUqSBQNqotbTcaku229UXriMU/yp0x+Kko6t0/z2XYtEqMBc
         uHdlyQm8jgLf+WuhwBtYXeJvwLtBe+gU92/DRe992baC+ue1NMQJVroT9WvPPUCc2h1z
         J9ZpzKJ9Zt3BWKSlc86LtO0Nz2k9yM7ATLtyXC+VOMRvGAsaqwc2l+CbU5jPjtWTiSAE
         biACQSZE11n9vghXqr4uSqJpFNaV6YvEAodqH36OGGrvekabOfxiaLgybku0DTR+CVz6
         z7ZEN8dT8NpC6JOX4iyxeQdaRvaHj0csoxf+hiJk31RMGnsSj/zCcqNekIpu8Urd0zEp
         TK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596807; x=1776201607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcVKv0sQ44FyUo4I68FZifCBpScEWMQjoICDyHB7V4E=;
        b=bNunGmq+csjI/y4H4jkd13H5MfQNkJ0NX1tBKT0pWlEOkTDCis8bMP2lfpK9Ri0sAp
         yLhhSQjNspzI4EZRwDMPGS9s9Dj8nYuIJ6XNu9AGTIhbo6k1L8gSP0mOpjOQrYphT5Fi
         A50QqBpU2MNsv4XyXmBZbY4gDrYTNFkY0LlDnUlK4RsUzjGk+3W6K2A+Odvef2FChtmT
         NwmvxL32RXeBnITIHvb+AbiO3e8STGd1CELwz/Y+NxIeUSBL9pBYP1yxoyKtPPhYcwxz
         SPdJH/fai6eo2mmgvxIk0njebKiufdgK45dqTWq1DzWbrY+5Kqge/dC/9+0dmrp+IeaV
         jblw==
X-Forwarded-Encrypted: i=1; AJvYcCWnDtTR/Ri8KxeuM/gcNwsOlN3zZUyo12950HaF7EvTCGxhVGYypVcTOIWZsD/GkCiMNsdKuZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpb4H8q8gz5HH9Cmo/wlw+B9otg5iQg96LvvXe0uyYTHjmACa
	zfQvGHL91AnuxSB1+lDLCyE1vgKJdLHBzJR8EItx4OZlCJcS+ZQnAPzcONAbZ6IIvZHH5i+QUva
	xbKKKKA==
X-Received: from pfbjs10.prod.google.com ([2002:a05:6a00:918a:b0:829:7493:545c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f88:b0:82a:955:50d3
 with SMTP id d2e1a72fcca58-82d0dbab605mr17482544b3a.45.1775596807003; Tue, 07
 Apr 2026 14:20:07 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:35 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 02/15] ipmr: Convert mr_table.cache_resolve_queue_len
 to u32.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276165-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DCBF3B5011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mr_table.cache_resolve_queue_len is always updated under
spin_lock_bh(&mfc_unres_lock).

Let's convert it to u32.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/mroute_base.h |  2 +-
 net/ipv4/ipmr.c             | 18 ++++++++++--------
 net/ipv6/ip6mr.c            | 11 +++++++----
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index cf3374580f74..3341acca002f 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -254,7 +254,7 @@ struct mr_table {
 	struct rhltable		mfc_hash;
 	struct list_head	mfc_cache_list;
 	int			maxvif;
-	atomic_t		cache_resolve_queue_len;
+	u32			cache_resolve_queue_len;
 	bool			mroute_do_assert;
 	bool			mroute_do_pim;
 	bool			mroute_do_wrvifwhole;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 8a08d09b4c30..2566b4a1f80b 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -756,7 +756,8 @@ static void ipmr_destroy_unres(struct mr_table *mrt, struct mfc_cache *c)
 	struct sk_buff *skb;
 	struct nlmsgerr *e;
 
-	atomic_dec(&mrt->cache_resolve_queue_len);
+	WRITE_ONCE(mrt->cache_resolve_queue_len,
+		   mrt->cache_resolve_queue_len - 1);
 
 	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved))) {
 		if (ip_hdr(skb)->version == 0) {
@@ -1178,11 +1179,12 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 			return err;
 		}
 
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
@@ -1287,7 +1289,8 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
 		if (uc->mfc_origin == c->mfc_origin &&
 		    uc->mfc_mcastgrp == c->mfc_mcastgrp) {
 			list_del(&_uc->list);
-			atomic_dec(&mrt->cache_resolve_queue_len);
+			WRITE_ONCE(mrt->cache_resolve_queue_len,
+				   mrt->cache_resolve_queue_len - 1);
 			found = true;
 			break;
 		}
@@ -1346,7 +1349,7 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 	}
 
 	if (flags & MRT_FLUSH_MFC) {
-		if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
+		if (READ_ONCE(mrt->cache_resolve_queue_len)) {
 			spin_lock_bh(&mfc_unres_lock);
 			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
 				list_del(&c->list);
@@ -2954,10 +2957,9 @@ static int ipmr_rtm_route(struct sk_buff *skb, struct nlmsghdr *nlh,
 
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
index 85010ff21c98..5755244e226c 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -792,7 +792,8 @@ static void ip6mr_destroy_unres(struct mr_table *mrt, struct mfc6_cache *c)
 	struct net *net = read_pnet(&mrt->net);
 	struct sk_buff *skb;
 
-	atomic_dec(&mrt->cache_resolve_queue_len);
+	WRITE_ONCE(mrt->cache_resolve_queue_len,
+		   mrt->cache_resolve_queue_len - 1);
 
 	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved)) != NULL) {
 		if (ipv6_hdr(skb)->version == 0) {
@@ -1205,7 +1206,8 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 			return err;
 		}
 
-		atomic_inc(&mrt->cache_resolve_queue_len);
+		WRITE_ONCE(mrt->cache_resolve_queue_len,
+			   mrt->cache_resolve_queue_len + 1);
 		list_add(&c->_c.list, &mrt->mfc_unres_queue);
 		mr6_netlink_event(mrt, c, RTM_NEWROUTE);
 
@@ -1510,7 +1512,8 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 		if (ipv6_addr_equal(&uc->mf6c_origin, &c->mf6c_origin) &&
 		    ipv6_addr_equal(&uc->mf6c_mcastgrp, &c->mf6c_mcastgrp)) {
 			list_del(&_uc->list);
-			atomic_dec(&mrt->cache_resolve_queue_len);
+			WRITE_ONCE(mrt->cache_resolve_queue_len,
+				   mrt->cache_resolve_queue_len - 1);
 			found = true;
 			break;
 		}
@@ -1568,7 +1571,7 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags)
 	}
 
 	if (flags & MRT6_FLUSH_MFC) {
-		if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
+		if (READ_ONCE(mrt->cache_resolve_queue_len)) {
 			spin_lock_bh(&mfc_unres_lock);
 			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
 				list_del(&c->list);
-- 
2.53.0.1213.gd9a14994de-goog


