Return-Path: <netdev+bounces-261701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMlSHi4SoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9251B2539
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D475430D2148
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43B03328EA;
	Fri, 27 Feb 2026 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdMjH30C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C33328E7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163555; cv=none; b=mN/Hk+mcBrbbGbseEiFla13KBlL0VVsCK2ArwnIGm8DWlnqs5hPDpsJhlmA5mkSLK8DV/gXynoJAvDW6xYV9JmtA4Rwjbw/iN6oFYZ9ireUvWBhOSWuzXOlSXhXd/7V9DEcXzbgD4erEM/eVSNKPAOsGhuhJrdgXas00TGxycvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163555; c=relaxed/simple;
	bh=cmapmWg66CfPpxARtu1hSFArgASVWG3/bJ1Iy8YpYr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fRfSglGhvymB/blp3BXmxdXTVyWvEVLAYDlXQSKOQGhAYCOKCPJiUSsAbZXWY5Fkvx7Vf0m2/exhrSl9r/QXJk3Pgd8vwQLn7EmvydhhvUZNFFd++nn0S+BmzSuigvRBGFti4MrTStAmZ7fhSbFywIOLpbInK4qDcFBR5QXHaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdMjH30C; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ab0b2e804cso14064175ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163554; x=1772768354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zb2ph83lf1iDC6DoKNVR5PRQWIfnQrB1dDs1u9UahE=;
        b=jdMjH30CL/RNHNwFV5kt+7tiNXetCWDWE/7PI0guvluHJ+7R5EGcJ6st4GE9LY3Cuy
         K1qefMZQdZHw5R1SAhMeXoOzqR97y/Zto2iIGqnDTBdPBT+qcn+ADEf9O3fW+NcrYECz
         nSeahcGCbiRnNEozkZcu3Eu3MHI8fUMGEj/ZUb3SGDdGjfgJHaYNW5K3k/E3NwldDyHf
         /YkBfh1MxhSw/0oLyosLVnjk3dxUyXPTneL2RkpsP8kFwce7q+9I0+R094gYFhzzPvai
         jpa23BMY5N6gYiKyhfqK+4bASRRe8RJHMYHIgso/IAmWuaTHk6yCWMANEsm2075VpGDA
         YBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163554; x=1772768354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zb2ph83lf1iDC6DoKNVR5PRQWIfnQrB1dDs1u9UahE=;
        b=FWLFX4RzKxEnme40/J+lbFCVbkK9FsIOHWWlPml/R3Ngl//OTa3cPhA7RXPZxInI0L
         fJv29xsJUhZ7hzTsmaOU1K7U1WvTRiekaevoe9AYmjTU7qKu5HOuU8lq8PEMeWLHOU0/
         8BpDdMJ/QjvKfhWnHLVUZ+WZ34RbB9zyC2v4MhiUNc9G3Z7z/S+9S5qxHHPsc6qZp9pu
         O5vLNDHvxOP8QkKDGT4eOqAk2H0QUAzI1nZ/0frqSAge6xyFEKXnn4uetSUMnQCfrmLl
         c4vLye8g7ZhFLiJNV2dBP3c4MijZgcyGRgvGfj2bOKCws+fkSFszJSdcPFzjbmL1Jl1W
         NqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7fxib+LjIgJgdC1bpE0yq4NedafIReY3UnU1neiIDTWqrbE9bjcc1qMc8FXDE1BsaCNDJdvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyokvYZIUPqHD+nnkxjbPh89x1iQ5bdFyJvZe5gWmOSKrjeQzm1
	QsN1KSxLovHINoeQZL+mph0iw6bmIxzUsrpTP18f0Blx5zlo0koAS7a1W1fco5TQDFzCK6R6/zh
	4Y6+2XQ==
X-Received: from plte3.prod.google.com ([2002:a17:902:7443:b0:2a9:3273:ef62])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d485:b0:2ad:b5f1:3d3b
 with SMTP id d9443c01a7336-2ae2e4e2383mr9043475ad.51.1772163553625; Thu, 26
 Feb 2026 19:39:13 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:28 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 05/15] ipmr: Convert ipmr_rtm_getroute() to RCU.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261701-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC9251B2539
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
index 37c915568a52..96715e41bcf6 100644
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
index 2d62526406ca..b0fd9ffa01a2 100644
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
2.53.0.473.g4a7958ca14-goog


