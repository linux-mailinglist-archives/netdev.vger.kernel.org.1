Return-Path: <netdev+bounces-119126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D2954391
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7007E1F211FD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE78C77101;
	Fri, 16 Aug 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Ax3JBvIf"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2776056
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795168; cv=none; b=mazSxrdIpxMF1ar6kRw5wSRQuoclzQpwPsNwxfvxcXJ5hwRp5wzfy6aU5P8exviX2HFr77dPZAoLVpkqcRNGqb7g7ZiKvjHu+9J3E1Wfmr0ds9HyzjY2MZUcNwSvx19Yu8waAqx4Sc9kEDBMzlgKpVPiHzMzZyMrtKCuczeQWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795168; c=relaxed/simple;
	bh=iyYYh8oyeWymlIufsrmZI29zvt3+kspCa0I7L7JnTTo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WGQw7+Lgk0iuWbx38KBebZo/CHMjKp0lGFNygme5A7PX8GtzuneSK6JyG7FSh9TqJhKL+UgZWdA2BvHFIboK2MC9yn4o8aig/eSh6NxxjGWKAE6m+EYTZYUBplGb5Nn1AMFAxcyFR+4qbU6pEBt4qqEGnr3G245fz/ORpr7m71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Ax3JBvIf; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=f/UQx0tNgZIcC8b8mfys/Fd+OlOKSSNYuxJszAUv6+M=; b=Ax3JBvIftzEWnc6SQm1wrw1YmA
	S5a2x8Y2a0EDMHpmRwlnqs1qQGPwnPSLPW3yqhSCIh3GKenVYRM6xEs1G8l9R7Tdak+0WqZR3mkNw
	TXt0xjbFvX3TcHPXD/I1jE0/0UvOL0zll5T6zhbdfO01+FLB/Aq7QtaH7ZYC6X0ujH6E=;
Received: from [2a01:599:100:4e89:dd66:6d46:4e54:e116] (helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1serrg-000BJa-0B
	for netdev@vger.kernel.org;
	Fri, 16 Aug 2024 09:59:16 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org
Subject: [RFC] net: remove NETIF_F_GSO_FRAGLIST from NETIF_F_GSO_SOFTWARE
Date: Fri, 16 Aug 2024 09:59:15 +0200
Message-ID: <20240816075915.6245-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several drivers set NETIF_F_GSO_SOFTWARE, but mangle fraglist GRO packets
in a way that they can't be properly segmented anymore.
In order to properly deal with this, remove fraglist GSO from
NETIF_F_GSO_SOFTWARE and switch to NETIF_F_GSO_SOFTWARE_ALL (which includes
fraglist GSO) in places where it's safe to add.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/dummy.c                  | 2 +-
 drivers/net/loopback.c               | 2 +-
 drivers/net/macvlan.c                | 2 +-
 include/linux/netdev_features.h      | 5 +++--
 net/8021q/vlan.h                     | 2 +-
 net/8021q/vlan_dev.c                 | 4 ++--
 net/core/sock.c                      | 2 +-
 net/mac80211/ieee80211_i.h           | 2 +-
 net/openvswitch/vport-internal_dev.c | 2 +-
 9 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d29b5d7af0d7..e2d0837c953c 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -110,7 +110,7 @@ static void dummy_setup(struct net_device *dev)
 	dev->flags &= ~IFF_MULTICAST;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
 	dev->features	|= NETIF_F_SG | NETIF_F_FRAGLIST;
-	dev->features	|= NETIF_F_GSO_SOFTWARE;
+	dev->features	|= NETIF_F_GSO_SOFTWARE_ALL;
 	dev->features	|= NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_LLTX;
 	dev->features	|= NETIF_F_GSO_ENCAP_ALL;
 	dev->hw_features |= dev->features;
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 2b486e7c749c..50cd6eb93eb7 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -172,7 +172,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
 	netif_keep_dst(dev);
-	dev->hw_features	= NETIF_F_GSO_SOFTWARE;
+	dev->hw_features	= NETIF_F_GSO_SOFTWARE_ALL;
 	dev->features		= NETIF_F_SG | NETIF_F_FRAGLIST
 		| NETIF_F_GSO_SOFTWARE
 		| NETIF_F_HW_CSUM
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 24298a33e0e9..cd0b50199354 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -897,7 +897,7 @@ static int macvlan_hwtstamp_set(struct net_device *dev,
 static struct lock_class_key macvlan_netdev_addr_lock_key;
 
 #define ALWAYS_ON_OFFLOADS \
-	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE | \
+	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE_ALL | \
 	 NETIF_F_GSO_ROBUST | NETIF_F_GSO_ENCAP_ALL)
 
 #define ALWAYS_ON_FEATURES (ALWAYS_ON_OFFLOADS | NETIF_F_LLTX)
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7c2d77d75a88..8b6d7f532065 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -219,13 +219,14 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 
 /* List of features with software fallbacks. */
 #define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
-				 NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST)
+				 NETIF_F_GSO_UDP_L4)
+#define NETIF_F_GSO_SOFTWARE_ALL (NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_FRAGLIST)
 
 /*
  * If one device supports one of these features, then enable them
  * for all in netdev_increment_features.
  */
-#define NETIF_F_ONE_FOR_ALL	(NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ROBUST | \
+#define NETIF_F_ONE_FOR_ALL	(NETIF_F_GSO_SOFTWARE_ALL | NETIF_F_GSO_ROBUST | \
 				 NETIF_F_SG | NETIF_F_HIGHDMA |		\
 				 NETIF_F_FRAGLIST | NETIF_F_VLAN_CHALLENGED)
 
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 5eaf38875554..4ce1e8cf6b2e 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -108,7 +108,7 @@ static inline netdev_features_t vlan_tnl_features(struct net_device *real_dev)
 	netdev_features_t ret;
 
 	ret = real_dev->hw_enc_features &
-	      (NETIF_F_CSUM_MASK | NETIF_F_GSO_SOFTWARE |
+	      (NETIF_F_CSUM_MASK | NETIF_F_GSO_SOFTWARE_ALL |
 	       NETIF_F_GSO_ENCAP_ALL);
 
 	if ((ret & NETIF_F_GSO_ENCAP_ALL) && (ret & NETIF_F_CSUM_MASK))
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 217be32426b5..194fb71e8463 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -561,7 +561,7 @@ static int vlan_dev_init(struct net_device *dev)
 		dev->state |= (1 << __LINK_STATE_NOCARRIER);
 
 	dev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG |
-			   NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE |
+			   NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE_ALL |
 			   NETIF_F_GSO_ENCAP_ALL |
 			   NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
 			   NETIF_F_ALL_FCOE;
@@ -654,7 +654,7 @@ static netdev_features_t vlan_dev_fix_features(struct net_device *dev,
 	if (lower_features & (NETIF_F_IP_CSUM|NETIF_F_IPV6_CSUM))
 		lower_features |= NETIF_F_HW_CSUM;
 	features = netdev_intersect_features(features, lower_features);
-	features |= old_features & (NETIF_F_SOFT_FEATURES | NETIF_F_GSO_SOFTWARE);
+	features |= old_features & (NETIF_F_SOFT_FEATURES | NETIF_F_GSO_SOFTWARE_ALL);
 	features |= NETIF_F_LLTX;
 
 	return features;
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..1973e3092ed8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2451,7 +2451,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 	if (sk_is_tcp(sk))
 		sk->sk_route_caps |= NETIF_F_GSO;
 	if (sk->sk_route_caps & NETIF_F_GSO)
-		sk->sk_route_caps |= NETIF_F_GSO_SOFTWARE;
+		sk->sk_route_caps |= NETIF_F_GSO_SOFTWARE_ALL;
 	if (unlikely(sk->sk_gso_disabled))
 		sk->sk_route_caps &= ~NETIF_F_GSO_MASK;
 	if (sk_can_gso(sk)) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a3485e4c6132..8de4f8cabf3a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2009,7 +2009,7 @@ void ieee80211_color_collision_detection_work(struct work_struct *work);
 /* interface handling */
 #define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
 					 NETIF_F_HW_CSUM | NETIF_F_SG | \
-					 NETIF_F_HIGHDMA | NETIF_F_GSO_SOFTWARE | \
+					 NETIF_F_HIGHDMA | NETIF_F_GSO_SOFTWARE_ALL | \
 					 NETIF_F_HW_TC)
 #define MAC80211_SUPPORTED_FEATURES_RX	(NETIF_F_RXCSUM)
 #define MAC80211_SUPPORTED_FEATURES	(MAC80211_SUPPORTED_FEATURES_TX | \
diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 4b33133cbdff..6c4b231c3957 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -109,7 +109,7 @@ static void do_setup(struct net_device *netdev)
 
 	netdev->features = NETIF_F_LLTX | NETIF_F_SG | NETIF_F_FRAGLIST |
 			   NETIF_F_HIGHDMA | NETIF_F_HW_CSUM |
-			   NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL;
+			   NETIF_F_GSO_SOFTWARE_ALL | NETIF_F_GSO_ENCAP_ALL;
 
 	netdev->vlan_features = netdev->features;
 	netdev->hw_enc_features = netdev->features;
-- 
2.44.0


