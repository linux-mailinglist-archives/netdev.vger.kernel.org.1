Return-Path: <netdev+bounces-70638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0F884FDB0
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB6B296EB
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EBE16416;
	Fri,  9 Feb 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHdktv2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C01096F
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510909; cv=none; b=Tb94rYLA8y0/I2QhvfeM5MUOBkyng+bX1JMQr70cgnmoasDqapIyH5zwLDj7j8hzPtyNXKjwyu2WbzgHebHMw29W0CvFzUmgFUzQK8jJazcjeJadvQUaUFtSYFyPq/OBfEIoFBs0ZltAp2TueLoJCsRyb5yZCskmgNEHi4e5On4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510909; c=relaxed/simple;
	bh=O7Q1ifIr9LVOjN/1C4DO0UMAMlP/AszPfuAJ+EgOUKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mgt4XoSN/tuWYA9OJcK2kkdTi5cmrs4R8mLJwcQ8WStaH+jowX+rjwRejKR0U4bXEgqYf4vlsHPl85KaH/LmhYQ2MWL8m4T0BYvSwQKfio52aTA67bXqWFh7VZLNlejiAMOia/Kiw8npgLK0CnZOypiqFkzJ/jajRgQSrps9uSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHdktv2Z; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7816e45f957so182320585a.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510906; x=1708115706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vsh/ywkmkYg9TdlOb7nkl/87ahX+0QB2cl54bPcis9o=;
        b=WHdktv2ZVl2tntNMzHU9NbrLxwzcnBpxswZzu9UDP17dDj8/LVOcicyv/9Icr9sOaU
         c9RrTjhxKKWLqQztKcHSGkUMydMEAjz2aoAuPqLIa/p/97QZhK2ApNJq5+Kf0lcGCBP9
         brD+tvHDEXafJlylffYEJdctEJo1Lz7MaoGryLBUFVa1+PixffMXHvNWSDPc62EE9LsQ
         xvgCdICBAXOJhc4X5RG2egioMG4z9Dxvy81FmuaKT3KtfNz2Fo48BPeol5FqKIs15jot
         NXQ0kUzscmQXRFexnwV53cpBbcvRE+LAG1gQh13GHQwbbHDG5RkEdPE0oUn4XbGA5DbU
         BMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510906; x=1708115706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsh/ywkmkYg9TdlOb7nkl/87ahX+0QB2cl54bPcis9o=;
        b=wMHWgOwjozEXdfVObk2g+X/W5ymvfVdZ0TRch5Hg45pJktW9HBVsvy1e+HqaLMs/2y
         UMqzKuwHaWmxSp3vQSyB0dXm4DJAx9b63CtuI0FWcUm5xzJ9Binvy7rFxuIoKpikIz9U
         Z7ZIaMrrDF/A4UmLDRFNjOrG0gsXYGd/Tp+gjS+umsfeCExx5PolrpKsDDdnhUW8mbHl
         zy9utFvIGrMfTEeIka4/mBiL7CqCAh+0fiThbcIH4U/1ln+jsHAvvDgSir74SqRTPCcb
         1ircdo2NsOqW25UYom11kf9e9+4uNT3+DMK77b+s2XGrcKt5GF1rDqFMGpU7bwmOlfz5
         MYpA==
X-Gm-Message-State: AOJu0Ywur2m82/PEStbd5QewKg1NDneo3Q3nrjHP5SVDLrRz3m0II1Bd
	TL+DiUFn/FDvxDTHK0PXKlOqV/PUTex5cpEJdbuN4G6uNKYd5VOfoaDJ1cjKNk5WQJzSDlsyx17
	xOQF4V+hO1A==
X-Google-Smtp-Source: AGHT+IGBTqZlc4I/PrJugDWFXV1gc1VWDnlWL40cBU1uQQc15aEH8y40olji8CfKdIR+Q2rp2Y2gjSTmq2q7Yg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:1d03:b0:785:b9f2:6199 with SMTP
 id dl3-20020a05620a1d0300b00785b9f26199mr1240qkb.2.1707510906414; Fri, 09 Feb
 2024 12:35:06 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:22 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-8-edumazet@google.com>
Subject: [PATCH v3 net-next 07/13] net-sysfs: convert dev->operstate reads to
 lockless ones
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

operstate_show() can omit dev_base_lock acquisition only
to read dev->operstate.

Annotate accesses to dev->operstate.

Writers still acquire dev_base_lock for mutual exclusion.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_netlink.c |  3 ++-
 net/core/link_watch.c   |  4 ++--
 net/core/net-sysfs.c    |  4 +---
 net/core/rtnetlink.c    |  4 ++--
 net/hsr/hsr_device.c    | 10 +++++-----
 net/ipv6/addrconf.c     |  2 +-
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 5ad4abfcb7ba3960bf69613ae7975180ae48854b..2cf4fc756263992eefe6a3580410766fea0c2c1f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -455,7 +455,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			  u32 filter_mask, const struct net_device *dev,
 			  bool getlink)
 {
-	u8 operstate = netif_running(dev) ? dev->operstate : IF_OPER_DOWN;
+	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
+					    IF_OPER_DOWN;
 	struct nlattr *af = NULL;
 	struct net_bridge *br;
 	struct ifinfomsg *hdr;
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 429571c258da7720baf387fef81081a56a655ef5..1b93e054c9a3cfcdd5d1251a9982d88a071abbaa 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -67,7 +67,7 @@ static void rfc2863_policy(struct net_device *dev)
 {
 	unsigned char operstate = default_operstate(dev);
 
-	if (operstate == dev->operstate)
+	if (operstate == READ_ONCE(dev->operstate))
 		return;
 
 	write_lock(&dev_base_lock);
@@ -87,7 +87,7 @@ static void rfc2863_policy(struct net_device *dev)
 		break;
 	}
 
-	dev->operstate = operstate;
+	WRITE_ONCE(dev->operstate, operstate);
 
 	write_unlock(&dev_base_lock);
 }
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 23ef2df549c3036a702f3be1dca1eda14ee5e76f..c5d164b8c6bfb53793f8422063c6281d6339b36e 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -325,11 +325,9 @@ static ssize_t operstate_show(struct device *dev,
 	const struct net_device *netdev = to_net_dev(dev);
 	unsigned char operstate;
 
-	read_lock(&dev_base_lock);
-	operstate = netdev->operstate;
+	operstate = READ_ONCE(netdev->operstate);
 	if (!netif_running(netdev))
 		operstate = IF_OPER_DOWN;
-	read_unlock(&dev_base_lock);
 
 	if (operstate >= ARRAY_SIZE(operstates))
 		return -EINVAL; /* should not happen */
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8d95e0863534f80cecceb2dd4a7b2a16f7f4bca3..4e797326c88fe1e23ca66e82103176767fe5c32e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -866,9 +866,9 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
 		break;
 	}
 
-	if (dev->operstate != operstate) {
+	if (READ_ONCE(dev->operstate) != operstate) {
 		write_lock(&dev_base_lock);
-		dev->operstate = operstate;
+		WRITE_ONCE(dev->operstate, operstate);
 		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	}
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 9d71b66183daf94e19945d75cfb5c33df6ce346c..be0e43f46556e028e675147e63c6b787aa72e894 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -31,8 +31,8 @@ static bool is_slave_up(struct net_device *dev)
 static void __hsr_set_operstate(struct net_device *dev, int transition)
 {
 	write_lock(&dev_base_lock);
-	if (dev->operstate != transition) {
-		dev->operstate = transition;
+	if (READ_ONCE(dev->operstate) != transition) {
+		WRITE_ONCE(dev->operstate, transition);
 		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	} else {
@@ -78,14 +78,14 @@ static void hsr_check_announce(struct net_device *hsr_dev,
 
 	hsr = netdev_priv(hsr_dev);
 
-	if (hsr_dev->operstate == IF_OPER_UP && old_operstate != IF_OPER_UP) {
+	if (READ_ONCE(hsr_dev->operstate) == IF_OPER_UP && old_operstate != IF_OPER_UP) {
 		/* Went up */
 		hsr->announce_count = 0;
 		mod_timer(&hsr->announce_timer,
 			  jiffies + msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
 	}
 
-	if (hsr_dev->operstate != IF_OPER_UP && old_operstate == IF_OPER_UP)
+	if (READ_ONCE(hsr_dev->operstate) != IF_OPER_UP && old_operstate == IF_OPER_UP)
 		/* Went down */
 		del_timer(&hsr->announce_timer);
 }
@@ -100,7 +100,7 @@ void hsr_check_carrier_and_operstate(struct hsr_priv *hsr)
 	/* netif_stacked_transfer_operstate() cannot be used here since
 	 * it doesn't set IF_OPER_LOWERLAYERDOWN (?)
 	 */
-	old_operstate = master->dev->operstate;
+	old_operstate = READ_ONCE(master->dev->operstate);
 	has_carrier = hsr_check_carrier(master);
 	hsr_set_operstate(master, has_carrier);
 	hsr_check_announce(master->dev, old_operstate);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d63f5d063f073cb53f52e187efdbd09b8f78d622..1122c9ef09f6210fc373d9678a9da1ec1a3e78fa 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5998,7 +5998,7 @@ static int inet6_fill_ifinfo(struct sk_buff *skb, struct inet6_dev *idev,
 	    (dev->ifindex != dev_get_iflink(dev) &&
 	     nla_put_u32(skb, IFLA_LINK, dev_get_iflink(dev))) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
-		       netif_running(dev) ? dev->operstate : IF_OPER_DOWN))
+		       netif_running(dev) ? READ_ONCE(dev->operstate) : IF_OPER_DOWN))
 		goto nla_put_failure;
 	protoinfo = nla_nest_start_noflag(skb, IFLA_PROTINFO);
 	if (!protoinfo)
-- 
2.43.0.687.g38aa6559b0-goog


