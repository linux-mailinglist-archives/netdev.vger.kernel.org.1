Return-Path: <netdev+bounces-261128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD5wM9Sxn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE11A0240
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4FE1300CA3F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2123783CB;
	Thu, 26 Feb 2026 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLXNsinJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B537757E
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073410; cv=none; b=fjg6mftXTqo4tBpYxz1WgluLORbsmfj8LeV7vPxFFeRbxa8hVhccbP3qdFidYWKiPpeqgCmTiRQaI+WffLoS358Z4tCk6xnHZNFpO5x9BVV/02m0FDcpcSxKvVnN6qA/1/IsbwaOS4orcqNbGrWanYUzxz8C06EoXCOlW8l8z4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073410; c=relaxed/simple;
	bh=UhPLy2NdZEVNTnwgphV1eOTjlcuC1B2FZlMSrWbJCMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vFQY3H9LaYCP5ZRTxthaM2d6lmHIReKQ7TeLJ4f1PNPum+hPRLf6DldJIz4NEdqTDjDTkl1J5FxfRUCcGyBcxrt0D421jyOSSeoQ6e87QG/U/OC+lHIXKLuZGz0LbfBhDMMw6bnMV/Ru/rOPUiaHjb8UDiLTWfTlAxiGkUyahbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLXNsinJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aae146bab0so4338165ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073408; x=1772678208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b80yeffNDkKe/EV21ALS5NroshAoSRH0GlnLHngz3vg=;
        b=CLXNsinJ0AfbUQtCXL7AhWAfSxm/qPcszxGv+AIeDIfONUPqj+MOWcxAbvV1hdfpAd
         GH057HiHMELXgpdrlx1a9ICFPeEkR4YACFUGr8FH+vQdeoICL6eA/S8Vaep7lol1P0h5
         HOmC1Qy3/F5a1Jj2NavIjLBz0iyXCOb7x2c3vJqQMmH2zT1YL607+xAlU0B+g67VfpQx
         1eYlbDCrP2IMp0UrnsVKmiP8e7Z6Qd3PYkiZTuc7p/gfpvyhA0lijpyBbuKMMuvbOWbZ
         tNlVWSDIhkB6bFyKpp5cB0OTJ7fYMgcqJaliamEx7oqX4L5Vp65FDQ4HwWlnlCsJxcHo
         IBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073408; x=1772678208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b80yeffNDkKe/EV21ALS5NroshAoSRH0GlnLHngz3vg=;
        b=BtB69iW7rXQrhPceezt1SFEjvx3Z/V81zPTK/njtsr8C8NGYFcM6Sb/q7D/FkvP7l6
         DSR9MsGGA+LZ+5DlrB6zzM7mrZXShEI2PPpStVyhSQDgiduR0OOY3clZq1XcibzpLdbg
         fdnWnuaReBcAhtsqiCLZb36cbMR4X8L1Xva8cDj+s8PVP632VtAFLXTnBOTWv6I/sK84
         a+O397ZkO5Ynf7VbtlUya9kT859AYumB87RKmSoqXWY7T0rw6sZHc34nYFkSN85+lOxz
         9u9MQ4n5MUz6X6+BQUYHQLl3bRQE/RRdPHUpjnN/AjXjPwYNGjivbvWTZLebINFla0lG
         vU1w==
X-Forwarded-Encrypted: i=1; AJvYcCVPXrsQj3mo7P1Ki5gIavzfqJOZsuE7M54xa8E0NomEk20v4pL7Nv02uS7vPZ+IkYds5m9j5RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFj6wBpV7pDIk8SJvK5PXlBb5XVxioy75S63qxUU/pI2BezqFq
	cJXaz2ricaN9JahxRc++ayLq1wFSIUr0JEldGZZXdD0kUCfT0G+EGZZgidi6q614KgpKHe6xq87
	7fuq4Qg==
X-Received: from plgz12.prod.google.com ([2002:a17:903:18c:b0:2ad:bd51:34cb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d504:b0:2ad:ad0f:bbbe
 with SMTP id d9443c01a7336-2adad0fbdf7mr84867865ad.29.1772073408273; Wed, 25
 Feb 2026 18:36:48 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:17 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/15] ipmr: Convert ipmr_rtm_getroute() to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261128-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FDE11A0240
X-Rspamd-Action: no action

ipmr_rtm_getroute() calls __ipmr_get_table(), ipmr_cache_find(),
and ipmr_fill_mroute().

The table is not removed until netns dismantle, and net->ipv4.mr_tables
is managed with RCU list API, so __ipmr_get_table() is safe under RCU.

struct mfc_cache is freed by mr_cache_put() after RCU grace period,
so we can use ipmr_cache_find() under RCU.  rcu_read_lock() around
it was just to avoid lockdep splat for rhl_for_each_entry_rcu().

ipmr_fill_mroute() calls mr_fill_mroute(), which properly uses RCU.

Let's drop RTNL for ipmr_rtm_getroute() and use RCU instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c      | 34 ++++++++++++++++++----------------
 net/ipv4/ipmr_base.c |  4 ++--
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 7b5177b673d3..53dda438ba32 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2680,9 +2680,9 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 {
 	struct net *net = sock_net(in_skb->sk);
 	struct nlattr *tb[RTA_MAX + 1];
-	struct sk_buff *skb = NULL;
 	struct mfc_cache *cache;
 	struct mr_table *mrt;
+	struct sk_buff *skb;
 	__be32 src, grp;
 	u32 tableid;
 	int err;
@@ -2695,39 +2695,40 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	grp = nla_get_in_addr_default(tb[RTA_DST], 0);
 	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
+	skb = nlmsg_new(mroute_msgsize(false), GFP_KERNEL);
+	if (!skb) {
+		err = -ENOBUFS;
+		goto errout;
+	}
+
+	rcu_read_lock();
+
 	mrt = __ipmr_get_table(net, tableid ? tableid : RT_TABLE_DEFAULT);
 	if (!mrt) {
 		err = -ENOENT;
-		goto errout_free;
+		goto errout_unlock;
 	}
 
-	/* entries are added/deleted only under RTNL */
-	rcu_read_lock();
 	cache = ipmr_cache_find(mrt, src, grp);
-	rcu_read_unlock();
 	if (!cache) {
 		err = -ENOENT;
-		goto errout_free;
-	}
-
-	skb = nlmsg_new(mroute_msgsize(false), GFP_KERNEL);
-	if (!skb) {
-		err = -ENOBUFS;
-		goto errout_free;
+		goto errout_unlock;
 	}
 
 	err = ipmr_fill_mroute(mrt, skb, NETLINK_CB(in_skb).portid,
 			       nlh->nlmsg_seq, cache,
 			       RTM_NEWROUTE, 0);
 	if (err < 0)
-		goto errout_free;
+		goto errout_unlock;
 
-	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+	rcu_read_unlock();
 
+	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
 errout:
 	return err;
 
-errout_free:
+errout_unlock:
+	rcu_read_unlock();
 	kfree_skb(skb);
 	goto errout;
 }
@@ -3297,7 +3298,8 @@ static const struct rtnl_msg_handler ipmr_rtnl_msg_handlers[] __initconst = {
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_DELROUTE,
 	 .doit = ipmr_rtm_route},
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_GETROUTE,
-	 .doit = ipmr_rtm_getroute, .dumpit = ipmr_rtm_dumproute},
+	 .doit = ipmr_rtm_getroute, .dumpit = ipmr_rtm_dumproute,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
 };
 
 int __init ip_mr_init(void)
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 28d77d454d44..9a38419e0f26 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -223,7 +223,7 @@ int mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 
 	rcu_read_lock();
 	vif_dev = rcu_dereference(mrt->vif_table[c->mfc_parent].dev);
-	if (vif_dev && nla_put_u32(skb, RTA_IIF, vif_dev->ifindex) < 0) {
+	if (vif_dev && nla_put_u32(skb, RTA_IIF, READ_ONCE(vif_dev->ifindex)) < 0) {
 		rcu_read_unlock();
 		return -EMSGSIZE;
 	}
@@ -252,7 +252,7 @@ int mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 
 			nhp->rtnh_flags = 0;
 			nhp->rtnh_hops = c->mfc_un.res.ttls[ct];
-			nhp->rtnh_ifindex = vif_dev->ifindex;
+			nhp->rtnh_ifindex = READ_ONCE(vif_dev->ifindex);
 			nhp->rtnh_len = sizeof(*nhp);
 		}
 	}
-- 
2.53.0.414.gf7e9f6c205-goog


