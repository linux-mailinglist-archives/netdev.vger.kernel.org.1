Return-Path: <netdev+bounces-105231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310F910352
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6571F22C6E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146191AC425;
	Thu, 20 Jun 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UfFnqHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F821AAE20
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884043; cv=none; b=TpXUw4tFWbjazJQ+VXG6W1wVsDhrZL03OXXzzDrklPiY8esmWkQYu/HJ2mM3E6dm8tG08s0Yyg9z/Dy5GaKSwsWvuLxtV+bE+ACKRBG2+1JwAGQ/LeK411aof3rnXlgFP4SUueoxIJvp9vpVrx4l9/UA34Rlz7EUMHEx9/VnfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884043; c=relaxed/simple;
	bh=BH7c2k7bxyXt8QCS2LFtIOQ8YLAZtpWrEdG8OuqcR90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m+CmcB/z8z829kQqREXrEX3qeo+VtwncyUNbv9QlYIMnUa/yMTCodiOcsbDFkIbDTEadMQWs6s0nnG7+r/n8k+eaUsSLXac09hCExRZTzCzC7/PBjewIZCpqDPlTdip90UTX/t4PRKIwuwxJj7EbJBc2evRF16MEKtADzHmFHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UfFnqHk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b58759c2so1484217276.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718884040; x=1719488840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=201iyVUIyfZ0rht8gMaTvcbCQRn7se0kCnaq9C0QCtE=;
        b=0UfFnqHkZlcWlWq0DlEKaIi7R8bxjUhQqnyedH+zrLSZCkRrmB7pXPYnRUZcstXtBZ
         8fLVipcgW3MWS8PrxQ9tJKh2fHQGFuQTZq5TFU4/EyesXQNbyIpDHid8FXDXRFxE7jOk
         961M8I9R8GnRBEZdjzcMInLbZqwGvytmlLPnEDUBPJSn04ODXwFSabift1x9wbTsG4aP
         QB7GBZoYZNKhnQx2F7rnwgEp2mWAvoG3P5PUMgTRvZVV5bK4VBvIX9LU8041a+0w8kwa
         L0l4uZzJviDCPFAnMCl2lEX0sQi2bJ7uAS93OnpxlOoxRRDy/MBF6fGCSIPuvHIOmNQQ
         Np6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884040; x=1719488840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=201iyVUIyfZ0rht8gMaTvcbCQRn7se0kCnaq9C0QCtE=;
        b=uHBsgbSlAhr7f8TDGtGKUdyvabY/0q9wDsBiSdoZtP5p9EjGMUuGXu2Sgp2FPb9dMQ
         me2yIqt+fY1GXX/KDDxa5EIej1y87mkP0Gpag4HG88TQlzfjZoDYuZClAtP8gnOTtKYa
         baFmYUfEpTH7lgjFQhDFPQzpyv14+fjbIrN7HPsgs8bqa6D8+Yhg2lYzZdQiJfqOKSX6
         E8QOu5ZlvkKy1WGD1qpmFsK6Tcq4rCOBNQ3qtCVEEP90h3JmVtUUaURgtNNbN/QSy4wp
         xaqD2em7WRWhaeCzJcet+rhUTMHystWfYa9fP46vgzpbirhPPmWG/ojoiUKHjEZom92W
         qEXg==
X-Forwarded-Encrypted: i=1; AJvYcCVlx5E5W7xtl5FEFkieXFCzp7okS8mNMUfbCJOwBlXeOcg1udEFrDG+zoAznFf9YwAkBpIs8c3K4YgK2tjHGqO05M+tP9YK
X-Gm-Message-State: AOJu0YzfJs1/mJt4sqxW9dVhxr6p3zCma9hbNvqRap1mA2ywEZrWpvg3
	OgT4Tp9LBku4BJmiAWPnud9Gm4xTyN2G8DfyOeck1ja18b19snKiXGWo3SCRmAYr5QX8aZNFllG
	FtNkS5BDjwQ==
X-Google-Smtp-Source: AGHT+IFsTqE6kxKtm02oUcRuQFFhIGsnWljMrB3WX00CcdtsaItRAyfMM0jjCODs4Ibpa5BWAJ8XIzVFMzbUaw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1007:b0:e02:ce2f:cf07 with SMTP
 id 3f1490d57ef6-e02ce2fd313mr239560276.5.1718884040506; Thu, 20 Jun 2024
 04:47:20 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:47:09 +0000
In-Reply-To: <20240620114711.777046-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620114711.777046-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240620114711.777046-5-edumazet@google.com>
Subject: [PATCH net-next 4/6] net: ethtool: call ethtool_get_one_feature()
 without RTNL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ethtool_get_one_feature() is used by ETHTOOL_GTXCSUM, ETHTOOL_GRXCSUM,
ETHTOOL_GSG, ETHTOOL_GTSO, ETHTOOL_GGSO and ETHTOOL_GGRO.

Add WRITE_ONCE() and READ_ONCE() annotations on dev->features.

Note that many READ_ONCE() annotations are probably missing in many drivers,
but this is orthogonal to this patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c      | 10 +++++-----
 net/ethtool/ioctl.c | 30 ++++++++++++++++--------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 093d82bf0e2886d4948f4952353c71c92e3586c6..b18223ed269f24bedd02b7c435de0ce2f1f8edf3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3536,7 +3536,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 netdev_features_t netif_skb_features(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
-	netdev_features_t features = dev->features;
+	netdev_features_t features = READ_ONCE(dev->features);
 
 	if (skb_is_gso(skb))
 		features = gso_features_check(skb, dev, features);
@@ -10016,7 +10016,7 @@ int __netdev_update_features(struct net_device *dev)
 			 * but *after* calling udp_tunnel_drop_rx_info.
 			 */
 			if (features & NETIF_F_RX_UDP_TUNNEL_PORT) {
-				dev->features = features;
+				WRITE_ONCE(dev->features, features);
 				udp_tunnel_get_rx_info(dev);
 			} else {
 				udp_tunnel_drop_rx_info(dev);
@@ -10025,7 +10025,7 @@ int __netdev_update_features(struct net_device *dev)
 
 		if (diff & NETIF_F_HW_VLAN_CTAG_FILTER) {
 			if (features & NETIF_F_HW_VLAN_CTAG_FILTER) {
-				dev->features = features;
+				WRITE_ONCE(dev->features, features);
 				err |= vlan_get_rx_ctag_filter_info(dev);
 			} else {
 				vlan_drop_rx_ctag_filter_info(dev);
@@ -10034,14 +10034,14 @@ int __netdev_update_features(struct net_device *dev)
 
 		if (diff & NETIF_F_HW_VLAN_STAG_FILTER) {
 			if (features & NETIF_F_HW_VLAN_STAG_FILTER) {
-				dev->features = features;
+				WRITE_ONCE(dev->features, features);
 				err |= vlan_get_rx_stag_filter_info(dev);
 			} else {
 				vlan_drop_rx_stag_filter_info(dev);
 			}
 		}
 
-		dev->features = features;
+		WRITE_ONCE(dev->features, features);
 	}
 
 	return err < 0 ? 0 : 1;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 70bb0d2fa2ed416fdff3de71a4f752e4a1bba67a..d0c9d2ad9c3d0acb1be00eb4970d3a1ef9da030a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -245,13 +245,13 @@ static netdev_features_t ethtool_get_feature_mask(u32 eth_cmd)
 	}
 }
 
-static int ethtool_get_one_feature(struct net_device *dev,
+static int ethtool_get_one_feature(const struct net_device *dev,
 	char __user *useraddr, u32 ethcmd)
 {
 	netdev_features_t mask = ethtool_get_feature_mask(ethcmd);
 	struct ethtool_value edata = {
 		.cmd = ethcmd,
-		.data = !!(dev->features & mask),
+		.data = !!(READ_ONCE(dev->features) & mask),
 	};
 
 	if (copy_to_user(useraddr, &edata, sizeof(edata)))
@@ -3049,14 +3049,6 @@ __dev_ethtool(struct net_device *dev, struct ifreq *ifr,
 	case ETHTOOL_SFEATURES:
 		rc = ethtool_set_features(dev, useraddr);
 		break;
-	case ETHTOOL_GTXCSUM:
-	case ETHTOOL_GRXCSUM:
-	case ETHTOOL_GSG:
-	case ETHTOOL_GTSO:
-	case ETHTOOL_GGSO:
-	case ETHTOOL_GGRO:
-		rc = ethtool_get_one_feature(dev, useraddr, ethcmd);
-		break;
 	case ETHTOOL_STXCSUM:
 	case ETHTOOL_SRXCSUM:
 	case ETHTOOL_SSG:
@@ -3178,10 +3170,20 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 	if (!netif_device_present(dev))
 		goto out_pm;
 
-	rtnl_lock();
-	rc = __dev_ethtool(dev, ifr, useraddr, ethcmd, sub_cmd, state);
-	rtnl_unlock();
-
+	switch (ethcmd) {
+	case ETHTOOL_GTXCSUM:
+	case ETHTOOL_GRXCSUM:
+	case ETHTOOL_GSG:
+	case ETHTOOL_GTSO:
+	case ETHTOOL_GGSO:
+	case ETHTOOL_GGRO:
+		rc = ethtool_get_one_feature(dev, useraddr, ethcmd);
+		break;
+	default:
+		rtnl_lock();
+		rc = __dev_ethtool(dev, ifr, useraddr, ethcmd, sub_cmd, state);
+		rtnl_unlock();
+	}
 out_pm:
 	if (dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
-- 
2.45.2.627.g7a2c4fd464-goog


