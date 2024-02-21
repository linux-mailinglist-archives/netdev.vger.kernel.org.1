Return-Path: <netdev+bounces-73618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA85385D63C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84AE1C2200D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4003F9F0;
	Wed, 21 Feb 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDgVZqX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F73FB2E
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513166; cv=none; b=PAjgIW4y2c/Rz/9Xk2KF5+uwEdpLssFbafwy2sJ19kTDLVa/r1EJFJd9csKL/0ujiBEddqHf0CdeL2sCfdK3pEQ5mKy9rpz94449ITNOCpdvS1fZ2mJJuDwrPTvfZJgsjqXmAGW5ozvOatavITIyiVxGCcrauCMXPI27MOPUV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513166; c=relaxed/simple;
	bh=kxixpVy9g3rfNbi/rH9xKv+5DYVP2tUUi/f5eOQqTIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DMbpJZa8vhho4O83fvXp/te2h2C9BJMwcWpBpIUfXnIJq3xvMZd0LHpBCwD8B0WOdT4qUFo2p3oC0hr9/3FlhH0Ee0ig8FcSICpr0WqczJOI26QKuBCeJRZx9sM0rwiJ2jUSL+dDGRCLEJog+mTYIQtVLb/cyKnFEXiiF6XxzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDgVZqX/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6082ad43ca1so51963687b3.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513163; x=1709117963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=95WqcJm1IUOuP4aKRrfPKuRsUA6Ga4VYzJJdcZFNnpg=;
        b=lDgVZqX/o3FXaV1XUDelVLRxyqvzM8UgcsxN93imd7QnLsWi5QhndXTaCsDx66CJal
         qluK+Bx8OGV2S6xvfWkjl2f8GoITvUXZN/XHySQmRmkItLdpMDjSzxUewr4Lpe7/tBRQ
         XPeqqGC3AlytNGGUQpaIKK5HiRzRBW2lMID83ucRLTfzriJBgV2gl8dgEtB2Oqch1R/5
         ftQPM+duHM6Ec1H2BLgW11ZnIs2+p8ei7S/VySRcBwOyprD3COj4ArWPB8oRbgR542Uy
         bjfRhF1svb9+QkB9X09okdqQ+i1qJwG9DRLxM06LY4D6ylkG5zptmjg8Mu1Qo8CwawHW
         PjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513163; x=1709117963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95WqcJm1IUOuP4aKRrfPKuRsUA6Ga4VYzJJdcZFNnpg=;
        b=BA6r2gwd844z4cmzFbiG9dgdKitPyG2az23/9FdahhofikOmA10Uzvl7a4wDLTLbgi
         onHyDWgc885r6vT71bKzV1yKnotGtSStSwwbiwEtDxGd36heXO3lUL/XSwEgthG9KdU7
         9ZcTVS8Os90Gs9sziPUV6hZEcbR2IgLN1S8zdVUhnLdr50Ie3YcjZr8GCRzbb+uVxOl/
         5YpfnBlnsJ9V1gb6Ea896sOiXBgw7/XdzeM4Y8MUROAOGWvFzVVdaesBYDJLP0mlFoXH
         KqDqvThOk7ENU1nvzpZ/0waNe+exXg8Bo9/X8LxjLjpbJ8/mYM3eLXo624+DRUviiDGo
         aJwA==
X-Gm-Message-State: AOJu0YwntpXCVHkFKApw4N91OFeTxPE+1F678uG1JrtyD4g0CHvxRei9
	eGDa6ROCWcyrrS4KbT9CcPUp1OBCjI9wjl+QNaJKAu+Hr1M4i+inaI/X+xuIeJBKRZVaZCy7t2h
	t7w6t//lbNA==
X-Google-Smtp-Source: AGHT+IEi8seY7FETqKwgqWkRThRGCI5bjGUUxwz3plobubGGx9ZajjF64An7CtuJkWlMjRbgBjSLxoN0usc29Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:188f:b0:dc6:b768:2994 with SMTP
 id cj15-20020a056902188f00b00dc6b7682994mr741452ybb.0.1708513162879; Wed, 21
 Feb 2024 02:59:22 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:05 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-4-edumazet@google.com>
Subject: [PATCH net-next 03/13] ipv6: prepare inet6_fill_ifinfo() for RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to use RCU protection instead of RTNL
for inet6_fill_ifinfo().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  6 ++++--
 net/core/dev.c            |  4 ++--
 net/ipv6/addrconf.c       | 11 +++++++----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f07c8374f29cb936fe11236fc63e06e741b1c965..09023e44db4e2c3a2133afc52ba5a335d6030646 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4354,8 +4354,10 @@ static inline bool netif_testing(const struct net_device *dev)
  */
 static inline bool netif_oper_up(const struct net_device *dev)
 {
-	return (dev->operstate == IF_OPER_UP ||
-		dev->operstate == IF_OPER_UNKNOWN /* backward compat */);
+	unsigned int operstate = READ_ONCE(dev->operstate);
+
+	return	operstate == IF_OPER_UP ||
+		operstate == IF_OPER_UNKNOWN /* backward compat */;
 }
 
 /**
diff --git a/net/core/dev.c b/net/core/dev.c
index 0628d8ff1ed932efdd45ab7b79599dcfcca6c4eb..275fd5259a4a92d0bd2e145d66a716248b6c2804 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8632,12 +8632,12 @@ unsigned int dev_get_flags(const struct net_device *dev)
 {
 	unsigned int flags;
 
-	flags = (dev->flags & ~(IFF_PROMISC |
+	flags = (READ_ONCE(dev->flags) & ~(IFF_PROMISC |
 				IFF_ALLMULTI |
 				IFF_RUNNING |
 				IFF_LOWER_UP |
 				IFF_DORMANT)) |
-		(dev->gflags & (IFF_PROMISC |
+		(READ_ONCE(dev->gflags) & (IFF_PROMISC |
 				IFF_ALLMULTI));
 
 	if (netif_running(dev)) {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3c8bdad0105dc9542489b612890ba86de9c44bdc..df3c6feea74e2d95144140eceb6df5cef2dce1f4 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6047,6 +6047,7 @@ static int inet6_fill_ifinfo(struct sk_buff *skb, struct inet6_dev *idev,
 	struct net_device *dev = idev->dev;
 	struct ifinfomsg *hdr;
 	struct nlmsghdr *nlh;
+	int ifindex, iflink;
 	void *protoinfo;
 
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*hdr), flags);
@@ -6057,16 +6058,18 @@ static int inet6_fill_ifinfo(struct sk_buff *skb, struct inet6_dev *idev,
 	hdr->ifi_family = AF_INET6;
 	hdr->__ifi_pad = 0;
 	hdr->ifi_type = dev->type;
-	hdr->ifi_index = dev->ifindex;
+	ifindex = READ_ONCE(dev->ifindex);
+	hdr->ifi_index = ifindex;
 	hdr->ifi_flags = dev_get_flags(dev);
 	hdr->ifi_change = 0;
 
+	iflink = dev_get_iflink(dev);
 	if (nla_put_string(skb, IFLA_IFNAME, dev->name) ||
 	    (dev->addr_len &&
 	     nla_put(skb, IFLA_ADDRESS, dev->addr_len, dev->dev_addr)) ||
-	    nla_put_u32(skb, IFLA_MTU, dev->mtu) ||
-	    (dev->ifindex != dev_get_iflink(dev) &&
-	     nla_put_u32(skb, IFLA_LINK, dev_get_iflink(dev))) ||
+	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
+	    (ifindex != iflink &&
+	     nla_put_u32(skb, IFLA_LINK, iflink)) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
 		       netif_running(dev) ? READ_ONCE(dev->operstate) : IF_OPER_DOWN))
 		goto nla_put_failure;
-- 
2.44.0.rc0.258.g7320e95886-goog


