Return-Path: <netdev+bounces-19428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E075AA5F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8B91C212FD
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68667199FD;
	Thu, 20 Jul 2023 09:08:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264B361
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:08:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA7D2AA58
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689844004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gj694vQxBZgkwxlf1stwKV7KnWklxY0xcReeSVInAHg=;
	b=WIs2nMxlzlDqMRSNut22TO+X21N6E0hXACX2rskxrYeG2QFn2SPiMSDFzpawhQ1TeHJcOU
	tSTv8lXToVlVngItejjVG4mtr8zdwmCBA4opwT7Mdr1+Bcf+F2e6hPrveRAl+Ctv0jwRCg
	IR0AIS6nw6Fh255h8epjt5T/BWfXm+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-1jQJ5vFHNcKkHDMq1WNgrg-1; Thu, 20 Jul 2023 05:06:40 -0400
X-MC-Unique: 1jQJ5vFHNcKkHDMq1WNgrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5859185A792;
	Thu, 20 Jul 2023 09:06:39 +0000 (UTC)
Received: from griffin.upir.cz (unknown [10.45.226.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE146200B41D;
	Thu, 20 Jul 2023 09:06:38 +0000 (UTC)
From: Jiri Benc <jbenc@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH net v2] vxlan: calculate correct header length for GPE
Date: Thu, 20 Jul 2023 11:05:56 +0200
Message-Id: <544e8c6d0f48af2be49809877c05c0445c0b0c0b.1689843872.git.jbenc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

VXLAN-GPE does not add an extra inner Ethernet header. Take that into
account when calculating header length.

This causes problems in skb_tunnel_check_pmtu, where incorrect PMTU is
cached.

In the collect_md mode (which is the only mode that VXLAN-GPE
supports), there's no magic auto-setting of the tunnel interface MTU.
It can't be, since the destination and thus the underlying interface
may be different for each packet.

So, the administrator is responsible for setting the correct tunnel
interface MTU. Apparently, the administrators are capable enough to
calculate that the maximum MTU for VXLAN-GPE is (their_lower_MTU - 36).
They set the tunnel interface MTU to 1464. If you run a TCP stream over
such interface, it's then segmented according to the MTU 1464, i.e.
producing 1514 bytes frames. Which is okay, this still fits the lower
MTU.

However, skb_tunnel_check_pmtu (called from vxlan_xmit_one) uses 50 as
the header size and thus incorrectly calculates the frame size to be
1528. This leads to ICMP too big message being generated (locally),
PMTU of 1450 to be cached and the TCP stream to be resegmented.

The fix is to use the correct actual header size, especially for
skb_tunnel_check_pmtu calculation.

Fixes: e1e5314de08ba ("vxlan: implement GPE")
Signed-off-by: Jiri Benc <jbenc@redhat.com>
---
v2: more verbose patch description
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/vxlan/vxlan_core.c                | 23 ++++++++-----------
 include/net/vxlan.h                           | 13 +++++++----
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1726297f2e0d..8eb9839a3ca6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8479,7 +8479,7 @@ static void ixgbe_atr(struct ixgbe_ring *ring,
 		struct ixgbe_adapter *adapter = q_vector->adapter;
 
 		if (unlikely(skb_tail_pointer(skb) < hdr.network +
-			     VXLAN_HEADROOM))
+			     vxlan_headroom(0)))
 			return;
 
 		/* verify the port is recognized as VXLAN */
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 78744549c1b3..42be8a26c171 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2516,7 +2516,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		ndst = &rt->dst;
-		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN_HEADROOM,
+		err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
 					    netif_is_any_bridge_port(dev));
 		if (err < 0) {
 			goto tx_error;
@@ -2577,7 +2577,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				goto out_unlock;
 		}
 
-		err = skb_tunnel_check_pmtu(skb, ndst, VXLAN6_HEADROOM,
+		err = skb_tunnel_check_pmtu(skb, ndst,
+					    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
 					    netif_is_any_bridge_port(dev));
 		if (err < 0) {
 			goto tx_error;
@@ -2989,14 +2990,12 @@ static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
 							 dst->remote_ifindex);
-	bool use_ipv6 = !!(vxlan->cfg.flags & VXLAN_F_IPV6);
 
 	/* This check is different than dev->max_mtu, because it looks at
 	 * the lowerdev->mtu, rather than the static dev->max_mtu
 	 */
 	if (lowerdev) {
-		int max_mtu = lowerdev->mtu -
-			      (use_ipv6 ? VXLAN6_HEADROOM : VXLAN_HEADROOM);
+		int max_mtu = lowerdev->mtu - vxlan_headroom(vxlan->cfg.flags);
 		if (new_mtu > max_mtu)
 			return -EINVAL;
 	}
@@ -3644,11 +3643,11 @@ static void vxlan_config_apply(struct net_device *dev,
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	unsigned short needed_headroom = ETH_HLEN;
-	bool use_ipv6 = !!(conf->flags & VXLAN_F_IPV6);
 	int max_mtu = ETH_MAX_MTU;
+	u32 flags = conf->flags;
 
 	if (!changelink) {
-		if (conf->flags & VXLAN_F_GPE)
+		if (flags & VXLAN_F_GPE)
 			vxlan_raw_setup(dev);
 		else
 			vxlan_ether_setup(dev);
@@ -3673,8 +3672,7 @@ static void vxlan_config_apply(struct net_device *dev,
 
 		dev->needed_tailroom = lowerdev->needed_tailroom;
 
-		max_mtu = lowerdev->mtu - (use_ipv6 ? VXLAN6_HEADROOM :
-					   VXLAN_HEADROOM);
+		max_mtu = lowerdev->mtu - vxlan_headroom(flags);
 		if (max_mtu < ETH_MIN_MTU)
 			max_mtu = ETH_MIN_MTU;
 
@@ -3685,10 +3683,9 @@ static void vxlan_config_apply(struct net_device *dev,
 	if (dev->mtu > max_mtu)
 		dev->mtu = max_mtu;
 
-	if (use_ipv6 || conf->flags & VXLAN_F_COLLECT_METADATA)
-		needed_headroom += VXLAN6_HEADROOM;
-	else
-		needed_headroom += VXLAN_HEADROOM;
+	if (flags & VXLAN_F_COLLECT_METADATA)
+		flags |= VXLAN_F_IPV6;
+	needed_headroom += vxlan_headroom(flags);
 	dev->needed_headroom = needed_headroom;
 
 	memcpy(&vxlan->cfg, conf, sizeof(*conf));
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 0be91ca78d3a..1648240c9668 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -386,10 +386,15 @@ static inline netdev_features_t vxlan_features_check(struct sk_buff *skb,
 	return features;
 }
 
-/* IP header + UDP + VXLAN + Ethernet header */
-#define VXLAN_HEADROOM (20 + 8 + 8 + 14)
-/* IPv6 header + UDP + VXLAN + Ethernet header */
-#define VXLAN6_HEADROOM (40 + 8 + 8 + 14)
+static inline int vxlan_headroom(u32 flags)
+{
+	/* VXLAN:     IP4/6 header + UDP + VXLAN + Ethernet header */
+	/* VXLAN-GPE: IP4/6 header + UDP + VXLAN */
+	return (flags & VXLAN_F_IPV6 ? sizeof(struct ipv6hdr) :
+				       sizeof(struct iphdr)) +
+	       sizeof(struct udphdr) + sizeof(struct vxlanhdr) +
+	       (flags & VXLAN_F_GPE ? 0 : ETH_HLEN);
+}
 
 static inline struct vxlanhdr *vxlan_hdr(struct sk_buff *skb)
 {
-- 
2.39.2


