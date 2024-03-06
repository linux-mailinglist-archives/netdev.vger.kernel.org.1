Return-Path: <netdev+bounces-77985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE0873B2D
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CE21C214AB
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2B1135418;
	Wed,  6 Mar 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+wAwPv5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131581353F2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740312; cv=none; b=Iw7ra+9PulYXZZlDJRiok/2J06fKQYNWo7ugSrA9r3p2V7Zm/7ltgvoBR0g/vU1MfWSPP1pDF0c4SkJbh54UnlCXSzxgwiHtznwI7/WRQfbq7Sd71TNMLX1tHSzXgrTisiLHMorID1/4oAeVWlpCaw5SD3eF+VjiF6cCqIVOZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740312; c=relaxed/simple;
	bh=QFviBCwTdGRWMdR6Q+xSjnHDS1Y26oh3bLkFh80uLVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XVrg5u0lyAkIh9D83udyzTNlrg1jzm6gLI18BW+z0X95+Sv1NGD4p/ltI1102/nb12W19z3rb6mIIcjb0pdT7zWFuSiOAXurgxBgT5fSoEz2kA9qRaYi9xdVpcxNhw41WsdANmz9sldX5IocOhR9PhLCTRSSjlnvWwi52YMPp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+wAwPv5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso10635281276.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740310; x=1710345110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVP64IBeM1VaaMu2g21hHAgyqyOij3r2jk6pCcQqVPE=;
        b=Y+wAwPv5M4STUZrvemcAJje1tae5M5nGN/EiGObDS5xk707T9Bnk8IsSaWUB1XhiUS
         IaLuZdZp79nmoRAanA1nxt7zVLR4rualAOfjF7uwZM8PR6JC75HwTkriDKl49h0WOxj2
         0SH82NeX46LT0EQz4WmIE0wLneI5hlcAgBF5UjCoa8ybZYgbJToL5moqR/zAF/sjkQY8
         6MKB2W+kNdvGZqq1rVn6Qe6lapL5xxnPCGWnRX8JQpf5hflvZ6VLNOrsT3S69ThggshK
         PcL3m5XqzUvt+2C1sxJdinCVe/M0LnH9R0Q8gOEenifIHx/KQXtf4eYt5GtGMpvIJdz6
         kzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740310; x=1710345110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVP64IBeM1VaaMu2g21hHAgyqyOij3r2jk6pCcQqVPE=;
        b=X0Sw5FFQsqXJLHMPgane//usGay5+/1egFoohbXstQWWRcZueZAef6CXHAP9Lcof0U
         O21g29XeCejUJT9plSrURLIT0LPvd39NNsO0JsYH3mLAvN+HplWEo5+fp7yQMB6IOl4D
         vLqHStLpZuQxm3I3GHHTkFJ5BwuixzmYuCrKx0nrHFpNb2Jmpjjh7irElt2J0c7wtFVf
         qZ54fY+7mWQ0rV7y40MgyU/loVlJjGcmGUkCtd5p3t+RbxMjD+ltwz7tHlIVPVA/uX/R
         K/5uIRKYVVZ3g1KtzOHchgs1UhuorHwYiUR7w1KZjG5gKmZ0XyCv3r9MAwNqOXl2mjkI
         S3/w==
X-Forwarded-Encrypted: i=1; AJvYcCUofeE2yG+95Nz1PjQIHg0+LaDf5SuNCkOfVplUGDyDSRwSr1vjQnja2P4bcUB4hEJ8RCECFA2lEnJWav2RBrIg87luT3YO
X-Gm-Message-State: AOJu0YxQSOB1yWLd5Be43BEGKMOjGBrc59iwjG9oFB5m9KVoD1rmV9KB
	UjGqwHcDLqghIc28osAJRs3heNq+adKpW7QUz9vzHxD6lPMCq9oLIYh844NH55juCbt1DXwKoV3
	ttSKDKC68Xg==
X-Google-Smtp-Source: AGHT+IFZPRATpWxdApYO5ESFKLCFN6UE4wD8NrL/IsFWejRVHfldXU9EgAIrTi+nwhEb2em1DvYYtj3yUoP98A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with SMTP
 id w4-20020a056902100400b00dc23441897fmr3740370ybt.6.1709740310125; Wed, 06
 Mar 2024 07:51:50 -0800 (PST)
Date: Wed,  6 Mar 2024 15:51:41 +0000
In-Reply-To: <20240306155144.870421-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306155144.870421-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306155144.870421-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] ipv6: make inet6_fill_ifaddr() lockless
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make inet6_fill_ifaddr() lockless, and add approriate annotations
on ifa->tstamp, ifa->valid_lft, ifa->preferred_lft, ifa->ifa_proto
and ifa->rt_priority.

Also constify 2nd argument of inet6_fill_ifaddr(), inet6_fill_ifmcaddr()
and inet6_fill_ifacaddr().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 66 +++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 2f84e6ecf19f48602cadb47bc378c9b5a1cdbf65..480a1f9492b590bb13008cede5ea7dc9c422af67 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2730,7 +2730,7 @@ int addrconf_prefix_rcv_add_addr(struct net *net, struct net_device *dev,
 		if (update_lft) {
 			ifp->valid_lft = valid_lft;
 			ifp->prefered_lft = prefered_lft;
-			ifp->tstamp = now;
+			WRITE_ONCE(ifp->tstamp, now);
 			flags = ifp->flags;
 			ifp->flags &= ~IFA_F_DEPRECATED;
 			spin_unlock_bh(&ifp->lock);
@@ -4898,13 +4898,13 @@ static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
 			IFA_F_HOMEADDRESS | IFA_F_MANAGETEMPADDR |
 			IFA_F_NOPREFIXROUTE);
 	ifp->flags |= cfg->ifa_flags;
-	ifp->tstamp = jiffies;
-	ifp->valid_lft = cfg->valid_lft;
-	ifp->prefered_lft = cfg->preferred_lft;
-	ifp->ifa_proto = cfg->ifa_proto;
+	WRITE_ONCE(ifp->tstamp, jiffies);
+	WRITE_ONCE(ifp->valid_lft, cfg->valid_lft);
+	WRITE_ONCE(ifp->prefered_lft, cfg->preferred_lft);
+	WRITE_ONCE(ifp->ifa_proto, cfg->ifa_proto);
 
 	if (cfg->rt_priority && cfg->rt_priority != ifp->rt_priority)
-		ifp->rt_priority = cfg->rt_priority;
+		WRITE_ONCE(ifp->rt_priority, cfg->rt_priority);
 
 	if (new_peer)
 		ifp->peer_addr = *cfg->peer_pfx;
@@ -5125,17 +5125,21 @@ struct inet6_fill_args {
 	enum addr_type_t type;
 };
 
-static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
+static int inet6_fill_ifaddr(struct sk_buff *skb,
+			     const struct inet6_ifaddr *ifa,
 			     struct inet6_fill_args *args)
 {
-	struct nlmsghdr  *nlh;
+	struct nlmsghdr *nlh;
 	u32 preferred, valid;
+	u32 flags, priority;
+	u8 proto;
 
 	nlh = nlmsg_put(skb, args->portid, args->seq, args->event,
 			sizeof(struct ifaddrmsg), args->flags);
 	if (!nlh)
 		return -EMSGSIZE;
 
+	flags = READ_ONCE(ifa->flags);
 	put_ifaddrmsg(nlh, ifa->prefix_len, ifa->flags, rt_scope(ifa->scope),
 		      ifa->idev->dev->ifindex);
 
@@ -5143,13 +5147,14 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
 	    nla_put_s32(skb, IFA_TARGET_NETNSID, args->netnsid))
 		goto error;
 
-	spin_lock_bh(&ifa->lock);
-	if (!((ifa->flags&IFA_F_PERMANENT) &&
-	      (ifa->prefered_lft == INFINITY_LIFE_TIME))) {
-		preferred = ifa->prefered_lft;
-		valid = ifa->valid_lft;
+	preferred = READ_ONCE(ifa->prefered_lft);
+	valid = READ_ONCE(ifa->valid_lft);
+
+	if (!((flags & IFA_F_PERMANENT) &&
+	      (preferred == INFINITY_LIFE_TIME))) {
 		if (preferred != INFINITY_LIFE_TIME) {
-			long tval = (jiffies - ifa->tstamp)/HZ;
+			long tval = (jiffies - READ_ONCE(ifa->tstamp)) / HZ;
+
 			if (preferred > tval)
 				preferred -= tval;
 			else
@@ -5165,28 +5170,29 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
 		preferred = INFINITY_LIFE_TIME;
 		valid = INFINITY_LIFE_TIME;
 	}
-	spin_unlock_bh(&ifa->lock);
 
 	if (!ipv6_addr_any(&ifa->peer_addr)) {
 		if (nla_put_in6_addr(skb, IFA_LOCAL, &ifa->addr) < 0 ||
 		    nla_put_in6_addr(skb, IFA_ADDRESS, &ifa->peer_addr) < 0)
 			goto error;
-	} else
+	} else {
 		if (nla_put_in6_addr(skb, IFA_ADDRESS, &ifa->addr) < 0)
 			goto error;
+	}
 
-	if (ifa->rt_priority &&
-	    nla_put_u32(skb, IFA_RT_PRIORITY, ifa->rt_priority))
+	priority = READ_ONCE(ifa->rt_priority);
+	if (priority && nla_put_u32(skb, IFA_RT_PRIORITY, priority))
 		goto error;
 
-	if (put_cacheinfo(skb, ifa->cstamp, ifa->tstamp, preferred, valid) < 0)
+	if (put_cacheinfo(skb, ifa->cstamp, READ_ONCE(ifa->tstamp),
+			  preferred, valid) < 0)
 		goto error;
 
-	if (nla_put_u32(skb, IFA_FLAGS, ifa->flags) < 0)
+	if (nla_put_u32(skb, IFA_FLAGS, flags) < 0)
 		goto error;
 
-	if (ifa->ifa_proto &&
-	    nla_put_u8(skb, IFA_PROTO, ifa->ifa_proto))
+	proto = READ_ONCE(ifa->ifa_proto);
+	if (proto && nla_put_u8(skb, IFA_PROTO, proto))
 		goto error;
 
 	nlmsg_end(skb, nlh);
@@ -5197,12 +5203,13 @@ static int inet6_fill_ifaddr(struct sk_buff *skb, struct inet6_ifaddr *ifa,
 	return -EMSGSIZE;
 }
 
-static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
+static int inet6_fill_ifmcaddr(struct sk_buff *skb,
+			       const struct ifmcaddr6 *ifmca,
 			       struct inet6_fill_args *args)
 {
-	struct nlmsghdr  *nlh;
-	u8 scope = RT_SCOPE_UNIVERSE;
 	int ifindex = ifmca->idev->dev->ifindex;
+	u8 scope = RT_SCOPE_UNIVERSE;
+	struct nlmsghdr *nlh;
 
 	if (ipv6_addr_scope(&ifmca->mca_addr) & IFA_SITE)
 		scope = RT_SCOPE_SITE;
@@ -5220,7 +5227,7 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
 
 	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
 	if (nla_put_in6_addr(skb, IFA_MULTICAST, &ifmca->mca_addr) < 0 ||
-	    put_cacheinfo(skb, ifmca->mca_cstamp, ifmca->mca_tstamp,
+	    put_cacheinfo(skb, ifmca->mca_cstamp, READ_ONCE(ifmca->mca_tstamp),
 			  INFINITY_LIFE_TIME, INFINITY_LIFE_TIME) < 0) {
 		nlmsg_cancel(skb, nlh);
 		return -EMSGSIZE;
@@ -5230,13 +5237,14 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct ifmcaddr6 *ifmca,
 	return 0;
 }
 
-static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
+static int inet6_fill_ifacaddr(struct sk_buff *skb,
+			       const struct ifacaddr6 *ifaca,
 			       struct inet6_fill_args *args)
 {
 	struct net_device *dev = fib6_info_nh_dev(ifaca->aca_rt);
 	int ifindex = dev ? dev->ifindex : 1;
-	struct nlmsghdr  *nlh;
 	u8 scope = RT_SCOPE_UNIVERSE;
+	struct nlmsghdr *nlh;
 
 	if (ipv6_addr_scope(&ifaca->aca_addr) & IFA_SITE)
 		scope = RT_SCOPE_SITE;
@@ -5254,7 +5262,7 @@ static int inet6_fill_ifacaddr(struct sk_buff *skb, struct ifacaddr6 *ifaca,
 
 	put_ifaddrmsg(nlh, 128, IFA_F_PERMANENT, scope, ifindex);
 	if (nla_put_in6_addr(skb, IFA_ANYCAST, &ifaca->aca_addr) < 0 ||
-	    put_cacheinfo(skb, ifaca->aca_cstamp, ifaca->aca_tstamp,
+	    put_cacheinfo(skb, ifaca->aca_cstamp, READ_ONCE(ifaca->aca_tstamp),
 			  INFINITY_LIFE_TIME, INFINITY_LIFE_TIME) < 0) {
 		nlmsg_cancel(skb, nlh);
 		return -EMSGSIZE;
-- 
2.44.0.278.ge034bb2e1d-goog


