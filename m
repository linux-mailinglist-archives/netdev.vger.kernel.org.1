Return-Path: <netdev+bounces-73934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE40785F614
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037021C23E42
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691544C77;
	Thu, 22 Feb 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yUZcwo4m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421F4439E
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599030; cv=none; b=kU3un4Eo4a64iigSo7spVwux6+vscDPL+4oGvTNW3fgZd0MR3cLZmjR3mBO8aAkQo3Qe1/S9RB4rzFHtQayuF5D8PVAbGlL7q0ibpG34d7Q7f2y2mWFLKVQU4Tro+xYt20Uyq0Dvj10jXFMyujEvLo2jTgJ0infJSRKiycPK/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599030; c=relaxed/simple;
	bh=RcqcDErl6lA4sLqE3Cw2HX80Icq/aN5kj3hhDH8zqyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k0koeq9qsDBXowzKJT73EtUjBz3qjPRPwwJGtFhFfdECikD+vejFbSabvsYtsWxu8nx2oe56j9U4ZC7kbG9j7zZX30d71FfdB26S2miv4OxwVSB81GHKAmimfhZ0Wj+Q2bY58FKP4oSAL7io+mzop2UZW4V8ggFDDjUTODvJTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yUZcwo4m; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso13762716276.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599028; x=1709203828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XoepgBYSf5d/A/v4bXmQgwvkojurMRkB/JCaRlBwAT8=;
        b=yUZcwo4mp6dB2BPjIMInTo7Ls6mzWP61TGyJh3HfGT8xcUMvfPfn470uqRItMBhdZL
         gE3kdwPc4IkbWc4maK7AwTNxiPEcT4T3in4mtQxUfc6JoUi9UmaXVCaYzuvpRcUjR5M8
         7ANwn3POqHZK/+sF0f+IUrTXu8Sgl+K0F9RMtHxo2oQIbzAQvUo/y6bqdL1YuNx0jFeQ
         SFRqEL5fimMMY613/pb99mNJgJD6NmXn9qF+vfUwtN7gw6X24idG0AeYXfnFsmTrr6//
         Hsmj1NYJnk4AJO+dzl5ds7Z+yZW1On/ubwu9Zu3WmNyM3W2BuPOCtFfW11URLKoUdEld
         BxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599028; x=1709203828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoepgBYSf5d/A/v4bXmQgwvkojurMRkB/JCaRlBwAT8=;
        b=b0dt8LBWUSLJtgtHMmXqH4cObv+MwEOkPnNvoq5YpZS6mjsRe7PpkK8mGEtTNnwzoT
         1MTHHtUqSs97qfCQVQss//JvJEpQ0dTyBh13YGeX+dUoILOpJLPg/UnL7jIbIgO3kdLW
         XH0v0xlcbTKlemzUrpe1isbozF1d+5tsApY+FOwZ1HAizdfob4JToFR0SMEB4MaDuKxR
         y7U5IKMwRoWgRdnX/LA4k9y7JVnOA4CkVU0sUJPYzxp+3LqMigytl5RobCe3E8mV7sFG
         js+QNQ6M6LnC7e3EDjKa68kvMZeNIx6hjcCiuI/RxIOJWTtJ59hqDCLcw899QWtenqWg
         UUCg==
X-Gm-Message-State: AOJu0YzmIyVQ6qjLIGmG7GA7toV5rN9K2JPUQHLwAcIOqiWGhPfvNpIi
	C7WWaS7Ii+MxTEcZc+Td8SyYfLmKE9XgpOBOR2/kIH1KY/15UUdu+uT0ZI1up2FNsKlptre78Ru
	QigEieVcx5Q==
X-Google-Smtp-Source: AGHT+IE6E/mrOGFsOfEUFDOYGBow8q//YsHBvQZnLxtlfDCukXKEFJVCz93CzhjZN7ew6+Lm4npLj9dtKyRzxw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1109:b0:dc2:4ab7:3d89 with SMTP
 id o9-20020a056902110900b00dc24ab73d89mr508829ybu.1.1708599027861; Thu, 22
 Feb 2024 02:50:27 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:10 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/14] ipv6: prepare inet6_fill_ifinfo() for RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
2.44.0.rc1.240.g4c46232300-goog


