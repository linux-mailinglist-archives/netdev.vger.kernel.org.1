Return-Path: <netdev+bounces-249136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B2D14B49
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF25D300AFDD
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602DE387370;
	Mon, 12 Jan 2026 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0eS/jvy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD830F931
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241839; cv=none; b=GunN/23owozgifX3H7fdztYDo3txaei9lpj0lWpmyEfxRQgUkWHl6dOSjJawW5yUT78/xDO3tsoYcTsmsUVEa++GIT/4ep66iwK8Fz2BR9egORAlzEvjKHKnmqo4klMshxorSY4KtsydLAG1SyUWWcgM/A+kEm5WQZT/9unLkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241839; c=relaxed/simple;
	bh=YeEECS+9gv6pPb+XI2q4y6WMjTCq42i43DPhJPeCZkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU392o+o3wnf3N75bjSJcMKHhdPmTjtEyrfa6IpT/0/1hGBIEkeweNp1OOUaZ0h81vlRuHmMDXmiEGLvH51S5XRUpSUs057JCiccm6g1Islr48E5FArP2Of7ID5Kaq5+HYnucfGFdvddsFfLp0J8S2MID+nlWgjSm6a/xoLKOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0eS/jvy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c21417781so4488187a91.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241836; x=1768846636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqJBVDW73KCgBwgVWk5qYLsHzLDdObx2o+GjzAsqssQ=;
        b=I0eS/jvyPI9FekZlu2JnGdIDv3F7yFZJKShw0DHRY8mUlZcCAugTVzZAVvJ4WmrgwZ
         6xZ3QjNhq+l70WArUt93927m8N5SIeP7NkAxZKp/LMimLm+0qFEyLvfS3WQ1C4Zi7jKd
         MtucLDD0/5HVsPzUohQR6nkj8toI8grrbI50C+Sz6bSJIlkOW7Lsf2tT52dvUgwy90yB
         GMyKZUL/B3qc+YgKUyUYAodYOV8c4ndYzoYQYpb8ZEdzkxjMJoCj8DnWXLpdZOKrxbau
         vv38LdHPpfa3LjaAhUegvFckPqRmLRhzI0gXkFe/PoKlxv4MCFwyl1KbtunXI0mSfV7o
         IzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241836; x=1768846636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqJBVDW73KCgBwgVWk5qYLsHzLDdObx2o+GjzAsqssQ=;
        b=pFC+GSE4tjingoX1H3uT13L4H3tVqetH5UsFnY1z2ZaIaijIev3LYtAAFCaF1Mr5z5
         mrpDE9p3R/+g7/Vr1a20pR+A0UHfTxRyGCa2ePxJhkMh0haI6pbBp0e0n0P1xdE0qooK
         0o65MZ/Q4Fm6JNyIsk41rl0hu9sDo+N5uo0aPrPbWyZ/TWqEs1UjhJdLYyw3XfWRSfeX
         jbq0Z2yaaLq5fRntx2Al9rfN4ZDKO/YkuRkCKIngV3SaT0cg9bbnf22kkRUdShH2NYe5
         4IR2Te/8kpGH24h9zSuDGPbdLKNCYmTCYcZ9NYsg/bS8WOvqxjbGc7DrVM4QxmuBwAoi
         NOmw==
X-Forwarded-Encrypted: i=1; AJvYcCVkq5f2+PY6w9iLftV1kLX4TTkqoZ6rnSwOR5tUD99uCaCyPULUCr4+pjYlQfUsvWYxqu/gIV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wlEOGvFHWRbCPg8ZPy/uVoPLDrzWrqnN4KnCHhAo1EfmX6mn
	xd7QjxoWjNgUacDIi6PljNooOfFid155Hy4nq/68QdPqo/nIV1aWIr+W
X-Gm-Gg: AY/fxX64kX9V8VWZcflqE0uyGOPlRthf4/vYhT+vxYfxUWWJy7jYMNuvg2lkNGVyhbw
	GeNFofaPWsqX8yVNeeULn1QbSJh9Izydk+cBhuGPqWEbxaDmWjeX6yputo0fhONN0ZXkV29fZN1
	Kajw/Xj0b4WdGTl114wHs5syu2ad5fN8j4REI2YhQnzA/fOR/bSWvna4UYMO/lARSSk13H7vEUX
	X9RszNxKEnH1+r+/QMq3+4IIhb/deL0if+ldDIh2sGT6/jvq4ToZBWdYoQ10dE/TgjCQ+PAEi2Y
	BtRMAXc49lBy5/X4k0iXpEMqQoAQYNn6B6oN0Ax3odGkQjyJ0n2Dll8nZXiRckJMTyHiUJPahU7
	TbsRJsXn69hkRrRcQlI4QkNOF8ajzHxk+FDYbqYZWJmp76bqFSwgnGrmKYBJ/DnJ+BhWKTtkQQn
	0CiiW5ZUYfTXJBy7OJHbUBaUeN557vqzlaCLAH3IsZJfYgX4KafDGz8lvxPNUdau5tkw==
X-Google-Smtp-Source: AGHT+IFz60SshqGbcLnvzcM3MjSw6gKXYr6Y8WSw1HT0006/my+JtsdMnEbYpRT5lPUoqFpp4CsP0A==
X-Received: by 2002:a17:90b:3c45:b0:339:eff5:ef26 with SMTP id 98e67ed59e1d1-34f68cb94f4mr16313803a91.30.1768241836105;
        Mon, 12 Jan 2026 10:17:16 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:15 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	intel-wired-lan@lists.osuosl.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v8 2/6] virtio-net: Implement ndo_write_rx_mode callback
Date: Mon, 12 Jan 2026 23:46:22 +0530
Message-ID: <20260112181626.20117-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
References: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add callback and update the code to use the rx_mode snapshot and
deferred write model

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 drivers/net/virtio_net.c | 61 +++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 22d894101c01..1d0e5f6ceb88 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -460,9 +460,6 @@ struct virtnet_info {
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
-	/* Work struct for setting rx mode */
-	struct work_struct rx_mode_work;
-
 	/* OK to queue work setting RX mode? */
 	bool rx_mode_work_enabled;
 
@@ -3866,33 +3863,30 @@ static int virtnet_close(struct net_device *dev)
 	return 0;
 }
 
-static void virtnet_rx_mode_work(struct work_struct *work)
+static void virtnet_write_rx_mode(struct net_device *dev)
 {
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, rx_mode_work);
+	struct virtnet_info *vi = netdev_priv(dev);
 	u8 *promisc_allmulti  __free(kfree) = NULL;
-	struct net_device *dev = vi->dev;
 	struct scatterlist sg[2];
 	struct virtio_net_ctrl_mac *mac_data;
-	struct netdev_hw_addr *ha;
+	char *ha_addr;
 	int uc_count;
 	int mc_count;
 	void *buf;
-	int i;
+	int i, ni;
 
 	/* We can't dynamically set ndo_set_rx_mode, so return gracefully */
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_KERNEL);
+	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
 	if (!promisc_allmulti) {
 		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
 		return;
 	}
 
-	rtnl_lock();
-
-	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
+	*promisc_allmulti = netif_rx_mode_get_cfg(dev,
+						  NETIF_RX_MODE_CFG_PROMISC);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3900,7 +3894,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_rx_mode_get_cfg(dev,
+						  NETIF_RX_MODE_CFG_ALLMULTI);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3908,27 +3903,22 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	netif_addr_lock_bh(dev);
-
-	uc_count = netdev_uc_count(dev);
-	mc_count = netdev_mc_count(dev);
+	uc_count = netif_rx_mode_uc_count(dev);
+	mc_count = netif_rx_mode_mc_count(dev);
 	/* MAC filter - use one buffer for both lists */
 	buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
 		      (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
 	mac_data = buf;
-	if (!buf) {
-		netif_addr_unlock_bh(dev);
-		rtnl_unlock();
+	if (!buf)
 		return;
-	}
 
 	sg_init_table(sg, 2);
 
 	/* Store the unicast list and count in the front of the buffer */
 	mac_data->entries = cpu_to_virtio32(vi->vdev, uc_count);
 	i = 0;
-	netdev_for_each_uc_addr(ha, dev)
-		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
+	netif_rx_mode_for_each_uc_addr(ha_addr, dev, ni)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[0], mac_data,
 		   sizeof(mac_data->entries) + (uc_count * ETH_ALEN));
@@ -3938,10 +3928,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
 	mac_data->entries = cpu_to_virtio32(vi->vdev, mc_count);
 	i = 0;
-	netdev_for_each_mc_addr(ha, dev)
-		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
-
-	netif_addr_unlock_bh(dev);
+	netif_rx_mode_for_each_mc_addr(ha_addr, dev, ni)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[1], mac_data,
 		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
@@ -3950,17 +3938,20 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
-	rtnl_unlock();
-
 	kfree(buf);
 }
 
 static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	char cfg_disabled = !vi->rx_mode_work_enabled;
+	bool allmulti = !!(dev->flags & IFF_ALLMULTI);
+	bool promisc = !!(dev->flags & IFF_PROMISC);
+
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_SET_SKIP, cfg_disabled);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5776,7 +5767,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_flush_rx_mode_work(vi->dev);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -6279,6 +6270,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_validate_addr   = eth_validate_addr,
 	.ndo_set_mac_address = virtnet_set_mac_address,
 	.ndo_set_rx_mode     = virtnet_set_rx_mode,
+	.ndo_write_rx_mode   = virtnet_write_rx_mode,
 	.ndo_get_stats64     = virtnet_stats,
 	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
@@ -6900,7 +6892,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
-	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
@@ -7205,7 +7196,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_flush_rx_mode_work(vi->dev);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.47.3


