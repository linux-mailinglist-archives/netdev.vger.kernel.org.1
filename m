Return-Path: <netdev+bounces-196626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569EAAD5972
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29EC3A5C17
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A382BEC2E;
	Wed, 11 Jun 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/LA2e8C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D02BEC25;
	Wed, 11 Jun 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653998; cv=none; b=q1H4iW+nOjlPVYUgKQE9FEbEmVCAd59MC0+L7mxDBI380cwIlHcDqdwwKKYzvJyd8IqwaeAmwDTCZn35O6U03bi/DVtXW27sp0MF8xt2tbx1ukBe619FBsPO+ZN72gy01J3XPTJQLpfyztflUWYoUxf1MojkvMOMr9J6GkDBOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653998; c=relaxed/simple;
	bh=h9qmosAz+vAYhkNwkZ+iy8d19OT9uqxy2kBvrYS9AEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOHVCyeKO32s+5dkP039H/hxt0q9iwxRHVSO6V6qPfk95nP6m/gaU7Or9AD7yvDbqbGWVis55rlXiSidNye/Ov0EBmF4WsrR+FiLkEqEBEHOKu1YGTCQG0pu2UVl7blRNwypU7vQ25KCrHww68uV5/y1/EBnyYBO4AB7Fa9Lahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/LA2e8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A33C4CEF4;
	Wed, 11 Jun 2025 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653998;
	bh=h9qmosAz+vAYhkNwkZ+iy8d19OT9uqxy2kBvrYS9AEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/LA2e8Cwaa3ZHvgtF4q/Y1iLKt1oHY6JXY3JEYpgPPxwP6DjmxVGFyji37LB5MoU
	 DrCFwDv6l/DuD/L791oIjZfk7kGNOdA6oBmcj7Cn9S5Uo0syPY7VlWHO7FdVGU6lGn
	 J4CMbXQdU9aM42KzSyDCu15iRaLoMRR3iK+Las/JplbucjAATQ9qyQG8gkM+tCs7Ic
	 y9DquVkz9XX0n1Ux9T1i/qEISYMinsXv27pz3qxIf1cnWkdRtNcwWLdbLv1bgIrru+
	 rkX/hhT1wASyJaLGZnUndGql7hqUvCdjRi25HPq5o6oBZY8FR1QEjsV3x0t5WyI7WO
	 D3TBif0b2b9EA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev
Subject: [PATCH net-next 8/9] net: drv: virtio: migrate to new RXFH callbacks
Date: Wed, 11 Jun 2025 07:59:48 -0700
Message-ID: <20250611145949.2674086-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
References: <20250611145949.2674086-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the new rxfh_fields callbacks, instead of de-muxing
the rxnfc calls. This driver does not support flow filtering so
the set_rxnfc callback is completely removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: mst@redhat.com
CC: jasowang@redhat.com
CC: xuanzhuo@linux.alibaba.com
CC: eperezma@redhat.com
CC: virtualization@lists.linux.dev
---
 drivers/net/virtio_net.c | 47 +++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..07e41dce4203 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4193,8 +4193,11 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
 	netdev_rss_key_fill(vi->rss_hash_key_data, vi->rss_key_size);
 }
 
-static void virtnet_get_hashflow(const struct virtnet_info *vi, struct ethtool_rxnfc *info)
+static int virtnet_get_hashflow(struct net_device *dev,
+				struct ethtool_rxfh_fields *info)
 {
+	struct virtnet_info *vi = netdev_priv(dev);
+
 	info->data = 0;
 	switch (info->flow_type) {
 	case TCP_V4_FLOW:
@@ -4243,17 +4246,22 @@ static void virtnet_get_hashflow(const struct virtnet_info *vi, struct ethtool_r
 		info->data = 0;
 		break;
 	}
+
+	return 0;
 }
 
-static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *info)
+static int virtnet_set_hashflow(struct net_device *dev,
+				const struct ethtool_rxfh_fields *info,
+				struct netlink_ext_ack *extack)
 {
+	struct virtnet_info *vi = netdev_priv(dev);
 	u32 new_hashtypes = vi->rss_hash_types_saved;
 	bool is_disable = info->data & RXH_DISCARD;
 	bool is_l4 = info->data == (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3);
 
 	/* supports only 'sd', 'sdfn' and 'r' */
 	if (!((info->data == (RXH_IP_SRC | RXH_IP_DST)) | is_l4 | is_disable))
-		return false;
+		return -EINVAL;
 
 	switch (info->flow_type) {
 	case TCP_V4_FLOW:
@@ -4292,21 +4300,22 @@ static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *
 		break;
 	default:
 		/* unsupported flow */
-		return false;
+		return -EINVAL;
 	}
 
 	/* if unsupported hashtype was set */
 	if (new_hashtypes != (new_hashtypes & vi->rss_hash_types_supported))
-		return false;
+		return -EINVAL;
 
 	if (new_hashtypes != vi->rss_hash_types_saved) {
 		vi->rss_hash_types_saved = new_hashtypes;
 		vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		if (vi->dev->features & NETIF_F_RXHASH)
-			return virtnet_commit_rss_command(vi);
+			if (!virtnet_commit_rss_command(vi))
+				return -EINVAL;
 	}
 
-	return true;
+	return 0;
 }
 
 static void virtnet_get_drvinfo(struct net_device *dev,
@@ -5539,27 +5548,6 @@ static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	switch (info->cmd) {
 	case ETHTOOL_GRXRINGS:
 		info->data = vi->curr_queue_pairs;
-		break;
-	case ETHTOOL_GRXFH:
-		virtnet_get_hashflow(vi, info);
-		break;
-	default:
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
-}
-
-static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
-{
-	struct virtnet_info *vi = netdev_priv(dev);
-	int rc = 0;
-
-	switch (info->cmd) {
-	case ETHTOOL_SRXFH:
-		if (!virtnet_set_hashflow(vi, info))
-			rc = -EINVAL;
-
 		break;
 	default:
 		rc = -EOPNOTSUPP;
@@ -5591,8 +5579,9 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
 	.get_rxfh = virtnet_get_rxfh,
 	.set_rxfh = virtnet_set_rxfh,
+	.get_rxfh_fields = virtnet_get_hashflow,
+	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rxnfc = virtnet_get_rxnfc,
-	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
-- 
2.49.0


