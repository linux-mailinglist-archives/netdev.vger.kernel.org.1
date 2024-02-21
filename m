Return-Path: <netdev+bounces-73616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00385D63A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830E02845A7
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F85D3FB20;
	Wed, 21 Feb 2024 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxJks3kr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F53F9CC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513162; cv=none; b=U3PIqLo3ZBjNHYKfWnB01tsc5bS0BgZ3MvCBTJ3BWzbNxP50f5w/gljaGwvPCWFZFGfEEivw6raYCsFuYoXMS5951fpRlgck5ZZQh4MnD4G4TlzrAFmoaxEaOkqK9FoqXnUOSlegSXd+iYpYUV1xggndY7AoWnjFlKswZRZ/qQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513162; c=relaxed/simple;
	bh=NeFVbmavuudK5WH3hO3Vd4g/peWgBlgAXftOWK9hEQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WBNLUsa0eIsNGFfPUnZ7CpP0xiEo6nw3hBd7ChoE37Wkimkx1r66liUwLtE0zgLR0Ear2V/hweIxwv+bov4W7B1qzn7T7dAtUAABLgkiGOIZM5uNF6lFXvdZ4S1nC8QDQVa8sYO8Wyfco3Uov+yHPtKfG2a16IwPoOPe0IDBXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxJks3kr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc15b03287so8995603276.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513159; x=1709117959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb8tiCkd4SNTJACzAgkNmR7P0JA/9dipW8MQsXAno74=;
        b=pxJks3krci/21tKXKW4zeQi5ukKb4d+6/AQC9oF77pNkGYt5MhkdBSoqP2Y4bjwFPf
         EN7bymMo23CvLNe61fotuAe24KjlS4KRQ6BHwjN8Fzs2miBoF1rG4iI0YHBKdgGOxaYj
         D79DHhrzv3gkpuOHVt1BtNjshnrdPHnQ6JcoLtNoVkwT4QHGPEK79UrGvGBJLDRDRIVq
         4MEq78LuTYs7eir0Wty5cbO9Bp5m+REgGtACL34tBMREY+Hw07pBWp40fUX4ih1I4nQd
         EXDrz+DOK/TN9YR9oIq6bS7RFWnIs8fPpx1HIag83iIlINYdqDSXX+J43TZBsTfa30To
         Y/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513159; x=1709117959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb8tiCkd4SNTJACzAgkNmR7P0JA/9dipW8MQsXAno74=;
        b=ioPn5fkaz6nAg41//F9YgHlTVh3Xz6CIHnGbZpqTBziO6V0e6ze2ul4CduytFj5QCp
         7rQZErGE9DT+rug3QNJupCkM4L461qFXwovmVTBP6RzcckCuV9HvqW7VlQg2qzXaCBux
         dP06CvWnb5z2Hi5KkWthKB/VpMEvmL5WRRyTbg/g1bZRChiU/UfVmZgiKSh1Dg5EFvVZ
         hMCwBh6nmI32/tws9rkEU8CaEAFSsdsyPDUsBeZ3giR5aSh6yDlTib5y1TuEWMbHCOWr
         HkIW5ucpc+mwk4MaHuyVF8vJCVK7d7q2RttSWDmhMIDMK28pbPbMQEb+L2r56NC7AVB3
         tAJA==
X-Gm-Message-State: AOJu0Yy9p+qV77XCXebkUgstA2IRg5BWWBlwV+5xzm1P62m9P9GfsBKf
	HhPUMcy0LYT1MsfFINpP1iU6CN8qnpD8YHeGcxA07R30N1cTjY5vcCye6oYveGqIHKqi3N2lJrB
	VnGZnfF7zlg==
X-Google-Smtp-Source: AGHT+IGLeWO2NTVkBzV3guAai5+mOKP70iEXgPEoF+7qOaiqP3fc0QQulVoz9tWSBkdLZ5RHa77XwKDKeOHIPQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1542:b0:dc7:66ec:9038 with SMTP
 id r2-20020a056902154200b00dc766ec9038mr733829ybu.1.1708513159574; Wed, 21
 Feb 2024 02:59:19 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:03 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-2-edumazet@google.com>
Subject: [PATCH net-next 01/13] rtnetlink: prepare nla_put_iflink() to run
 under RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to be able to run rtnl_fill_ifinfo() under RCU protection
instead of RTNL in the future.

This patch prepares dev_get_iflink() and nla_put_iflink()
to run either with RTNL or RCU held.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c       | 4 ++--
 drivers/net/can/vxcan.c                         | 2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c | 2 +-
 drivers/net/ipvlan/ipvlan_main.c                | 2 +-
 drivers/net/macsec.c                            | 2 +-
 drivers/net/macvlan.c                           | 2 +-
 drivers/net/netkit.c                            | 2 +-
 drivers/net/veth.c                              | 2 +-
 drivers/net/wireless/virtual/virt_wifi.c        | 2 +-
 net/8021q/vlan_dev.c                            | 4 ++--
 net/core/dev.c                                  | 2 +-
 net/core/rtnetlink.c                            | 6 +++---
 net/dsa/user.c                                  | 2 +-
 net/ieee802154/6lowpan/core.c                   | 2 +-
 net/ipv6/ip6_tunnel.c                           | 2 +-
 net/xfrm/xfrm_interface_core.c                  | 2 +-
 16 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 7a5be705d71830d5bb3aa26a96a4463df03883a4..6f2a688fccbfb02ae7bdf3d55cca0e77fa9b56b4 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1272,10 +1272,10 @@ static int ipoib_get_iflink(const struct net_device *dev)
 
 	/* parent interface */
 	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags))
-		return dev->ifindex;
+		return READ_ONCE(dev->ifindex);
 
 	/* child/vlan interface */
-	return priv->parent->ifindex;
+	return READ_ONCE(priv->parent->ifindex);
 }
 
 static u32 ipoib_addr_hash(struct ipoib_neigh_hash *htbl, u8 *daddr)
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 98c669ad5141479b509ee924ddba3da6bca554cd..f7fabba707ea640cab8863e63bb19294e333ba2c 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -119,7 +119,7 @@ static int vxcan_get_iflink(const struct net_device *dev)
 
 	rcu_read_lock();
 	peer = rcu_dereference(priv->peer);
-	iflink = peer ? peer->ifindex : 0;
+	iflink = peer ? READ_ONCE(peer->ifindex) : 0;
 	rcu_read_unlock();
 
 	return iflink;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 046b5f7d8e7cab33a9f09079858bac2a972e968a..9d2a9562c96ff4937da7a389c773acce01508ca3 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -98,7 +98,7 @@ static int rmnet_vnd_get_iflink(const struct net_device *dev)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
 
-	return priv->real_dev->ifindex;
+	return READ_ONCE(priv->real_dev->ifindex);
 }
 
 static int rmnet_vnd_init(struct net_device *dev)
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index df7c43a109e1a7376c6ce3216cb3dd4223eac04c..5920f7e6335230cf07a3da528e4ac7a050c2fd41 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -349,7 +349,7 @@ static int ipvlan_get_iflink(const struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 
-	return ipvlan->phy_dev->ifindex;
+	return READ_ONCE(ipvlan->phy_dev->ifindex);
 }
 
 static const struct net_device_ops ipvlan_netdev_ops = {
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7f5426285c61b1e35afd74d4c044f80c77f34e7f..4b5513c9c2befe42e054fee6ecdadc9aabb0ce19 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3753,7 +3753,7 @@ static void macsec_get_stats64(struct net_device *dev,
 
 static int macsec_get_iflink(const struct net_device *dev)
 {
-	return macsec_priv(dev)->real_dev->ifindex;
+	return READ_ONCE(macsec_priv(dev)->real_dev->ifindex);
 }
 
 static const struct net_device_ops macsec_netdev_ops = {
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index a3cc665757e8727d3ffb24d8dbfbcd321fc93ffd..0cec2783a3e712b7769572482bf59aa336b9ca15 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1158,7 +1158,7 @@ static int macvlan_dev_get_iflink(const struct net_device *dev)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
 
-	return vlan->lowerdev->ifindex;
+	return READ_ONCE(vlan->lowerdev->ifindex);
 }
 
 static const struct ethtool_ops macvlan_ethtool_ops = {
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 39171380ccf29e27412bb2b9cee7102acc4a83ab..a4d2e76a8d587cc6ce7ad7f98e382a1c81f76e67 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -145,7 +145,7 @@ static int netkit_get_iflink(const struct net_device *dev)
 	rcu_read_lock();
 	peer = rcu_dereference(nk->peer);
 	if (peer)
-		iflink = peer->ifindex;
+		iflink = READ_ONCE(peer->ifindex);
 	rcu_read_unlock();
 	return iflink;
 }
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 500b9dfccd08ee8f91b22d78e3d8195f3de26088..dd5aa8ab65a865dc9dbaa596861671d189bfe1af 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1461,7 +1461,7 @@ static int veth_get_iflink(const struct net_device *dev)
 
 	rcu_read_lock();
 	peer = rcu_dereference(priv->peer);
-	iflink = peer ? peer->ifindex : 0;
+	iflink = peer ? READ_ONCE(peer->ifindex) : 0;
 	rcu_read_unlock();
 
 	return iflink;
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index ba14d83353a4b226e44d420a16e33460a9dc762d..6a84ec58d618bcbf966dab6e38cfe02b886a712f 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -453,7 +453,7 @@ static int virt_wifi_net_device_get_iflink(const struct net_device *dev)
 {
 	struct virt_wifi_netdev_priv *priv = netdev_priv(dev);
 
-	return priv->lowerdev->ifindex;
+	return READ_ONCE(priv->lowerdev->ifindex);
 }
 
 static const struct net_device_ops virt_wifi_ops = {
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index df55525182517e49b2cfbffe7f102967c66b5952..39876eff51d21f830c3bde1682e07aac698c633e 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -762,9 +762,9 @@ static void vlan_dev_netpoll_cleanup(struct net_device *dev)
 
 static int vlan_dev_get_iflink(const struct net_device *dev)
 {
-	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+	const struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 
-	return real_dev->ifindex;
+	return READ_ONCE(real_dev->ifindex);
 }
 
 static int vlan_dev_fill_forward_path(struct net_device_path_ctx *ctx,
diff --git a/net/core/dev.c b/net/core/dev.c
index c588808be77f563c429eb4a2eaee5c8062d99582..0628d8ff1ed932efdd45ab7b79599dcfcca6c4eb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -641,7 +641,7 @@ int dev_get_iflink(const struct net_device *dev)
 	if (dev->netdev_ops && dev->netdev_ops->ndo_get_iflink)
 		return dev->netdev_ops->ndo_get_iflink(dev);
 
-	return dev->ifindex;
+	return READ_ONCE(dev->ifindex);
 }
 EXPORT_SYMBOL(dev_get_iflink);
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c54dbe05c4c5df126d0b58403049ebc1d272907e..060543fe7919c13c7a5c6cf22f9e7606d0897345 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1611,10 +1611,10 @@ static int put_master_ifindex(struct sk_buff *skb, struct net_device *dev)
 static int nla_put_iflink(struct sk_buff *skb, const struct net_device *dev,
 			  bool force)
 {
-	int ifindex = dev_get_iflink(dev);
+	int iflink = dev_get_iflink(dev);
 
-	if (force || dev->ifindex != ifindex)
-		return nla_put_u32(skb, IFLA_LINK, ifindex);
+	if (force || READ_ONCE(dev->ifindex) != iflink)
+		return nla_put_u32(skb, IFLA_LINK, iflink);
 
 	return 0;
 }
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 4d53c76a9840a789511b9ee0d9a39c70de77f72c..9c42a6edcdc8a8de94241ce4a238f31583b738ec 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -352,7 +352,7 @@ void dsa_user_mii_bus_init(struct dsa_switch *ds)
 /* user device handling ****************************************************/
 static int dsa_user_get_iflink(const struct net_device *dev)
 {
-	return dsa_user_to_conduit(dev)->ifindex;
+	return READ_ONCE(dsa_user_to_conduit(dev)->ifindex);
 }
 
 static int dsa_user_open(struct net_device *dev)
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index e643f52663f9bed8c4707b205a73d0d2bad5bb73..77b4e92027c5dfdadefc3019ca82ee8967a9006e 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -93,7 +93,7 @@ static int lowpan_neigh_construct(struct net_device *dev, struct neighbour *n)
 
 static int lowpan_get_iflink(const struct net_device *dev)
 {
-	return lowpan_802154_dev(dev)->wdev->ifindex;
+	return READ_ONCE(lowpan_802154_dev(dev)->wdev->ifindex);
 }
 
 static const struct net_device_ops lowpan_netdev_ops = {
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 44406c28445dc457fb47a7cdec295778eb30b31f..5fd07581efafe3c57cc8732ddaae9910d6726f30 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1756,7 +1756,7 @@ int ip6_tnl_get_iflink(const struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 
-	return t->parms.link;
+	return READ_ONCE(t->parms.link);
 }
 EXPORT_SYMBOL(ip6_tnl_get_iflink);
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index dafefef3cf51a79fd6701a8b78c3f8fcfd10615d..717855b9acf1c413d506f681aec636af9b075af5 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -727,7 +727,7 @@ static int xfrmi_get_iflink(const struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
 
-	return xi->p.link;
+	return READ_ONCE(xi->p.link);
 }
 
 static const struct net_device_ops xfrmi_netdev_ops = {
-- 
2.44.0.rc0.258.g7320e95886-goog


