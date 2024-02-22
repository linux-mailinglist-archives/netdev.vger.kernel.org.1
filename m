Return-Path: <netdev+bounces-73932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBBC85F612
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED921F25243
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E74207B;
	Thu, 22 Feb 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IM9SKYLE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03845405F4
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599027; cv=none; b=NXp43nRdGruxdPPvh05STg/OUG5dz4bNyKqb/oZOJD/PuswWduvYJG6Ocl75bNoc1LBakEVQayX1ByI7gg4OC2nxcHd08gw0QB6c67z1BB6dSF/VLY4Kp6Frvoq6DPNaGalhphb7IxWEs5Z6sCv423KmpatknSYJXI0VTXxxqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599027; c=relaxed/simple;
	bh=24FW6iElS06uKgiA5Pl0q5efeDqn37dMPZJXKTFbSgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iRKBZywm3fIHG4P+5lGWCmF6cFxh3bb+GsDfZSrcRo805s05gfw6NJdwvI7PaEHN2vMyLnGmSErRn5RA6XEoZhnvBpsth7h6jwP3LBf4ot3/q8fGS5R5UGnD2kNScCul/xtpttdVaS128F8h+I7Fib77bEuGyc2iLMUgjAstNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IM9SKYLE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so9607093276.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599025; x=1709203825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIr9rYGLsaCc7qNWGLVCtVkmvuSVIbaWAGNMNlJV7qc=;
        b=IM9SKYLEvspNlxHoKQy00iHwSVy4sbeFDbwt+YBuu5yvxmbFF09F6UbbWd8/VtM15d
         1yI7qCu/9yVQ1XAxqaf5rcX1HxrHvITBcy/e8OKlxhhQqafwZ7GpmMNgcRZ5nGt3Md/G
         8RiVbhsDd6WpVnVX/jxPyQrYWXT56pn4UIiZnbdAaHBSFDgr5F5UOLhtIErhNbmrTgM4
         rKlDvovEVRLsC6iUPH0hQhMG6EfbFDEPlTW1ii52ObfSsPFZyQeEBz98d9vdZTCEXLP8
         chxVWd0SxE8zO8kfbMLTXHl/Sky7+k32z20Tfzu7MER08AuSbz7DGWyOAcaxkDodJT5P
         Yihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599025; x=1709203825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIr9rYGLsaCc7qNWGLVCtVkmvuSVIbaWAGNMNlJV7qc=;
        b=KngHlz7IdP7kO8vPWNGiZTN6a3e/GxpO+PblMUaJL7SLf6Q81UepJMAsyxfKsvphhO
         UjGa0+7DOiuFU0e9Qjepp+gPXM7GQqITgI/EXvu1XEttYpcJJFkZMMHZGNS2WTrHsy4n
         J5bcSGWNV4uCxvrlxY0i9dxzXk580bPwOCO34ixydujfTbWzaaKGQeBagIo19sp3V1ce
         Qg8ZiCMKoWYi5SH2sIUBLurw33T6LCOPfqmX7tNCiAuJZBx2UwX8y9pn4HM5Z+8N8sLQ
         mXYPErL6CMxP5TBBJWGjmCPbO5q3lnNT3t2Suzbb993GT4jlD/Bia61aeIjjDctDD4+X
         kjNA==
X-Gm-Message-State: AOJu0Ywq6j9GlK3wjSr/MnFz4fBncT9M4HzZqHPEbPTcVY9iysCaprmb
	AgW9z6KPGFTGKooWjqq8GolLYGjf4/qXn6Te7Kdi3qlKbU+oq5ros2TuM0uvvf+UbLw0cLapI6Q
	pVKuGre+yqg==
X-Google-Smtp-Source: AGHT+IF6NPwUc2EikrViIppg8LQX10oUb+YfaRsEqdceB4uQ/B5pUHbHTNHKyanZr4TBQ9A1/fB6yuvJJPdo7Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1008:b0:dbe:387d:a8ef with SMTP
 id w8-20020a056902100800b00dbe387da8efmr58636ybt.1.1708599025070; Thu, 22 Feb
 2024 02:50:25 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:08 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/14] rtnetlink: prepare nla_put_iflink() to run
 under RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
2.44.0.rc1.240.g4c46232300-goog


