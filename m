Return-Path: <netdev+bounces-246609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F8CEF2A4
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 19:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF1E306E8DF
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2392315769;
	Fri,  2 Jan 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISi8jBR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D647309F13
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377168; cv=none; b=XWe9oj25ERYEh0XE89Ve62aX5X8voaEl1jrs9wREe8nnhsKA8YIOpNnkwXBuJyu6kBV6EheW3xmuFD8LJGO8nYgALdkUee/xdGqCH8exRzaHwgNtug0yYyzNVOKpW22StvIH1kxfNu9nMxFIe1bzuo7dwIOAXTV3xuXm+vfHSOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377168; c=relaxed/simple;
	bh=oetQtpSM3DjCX3/aeFuWgTQCahQBkDyO/iqkcjjmuuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFtD33VhNutOXqQYY0c7TMI6J2nAMMnmDQ8Nb4H3SR7qDutgXkytx3ZFDHJMb5JAYZwuNUjORZyU0Apdg5BgTvQIvhAjwf/w2+iZKKLkdhYITyDZM12AG6A9V1RWUTrDdLRY8Dk/9DH4TCVICCQ6WHEkU8Wt4kOKvM/yN1fBBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISi8jBR3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a1388cdac3so113357365ad.0
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767377160; x=1767981960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfcgCbP6RhhVMiMr9Azv6F2aQ7T6/MJccCOzX/54vEE=;
        b=ISi8jBR3puCj3RPUhCjqDezSdK1NmfG1a2nm6j6QUUa/TudJetCSJdhFJLOAIknsrt
         XZpWKgNCJfuRAM8PYDwMhyuXG3huXnx3H5n+VZiggPV6zv/dheod3HId05xLEKCDD5kL
         oYb9IXAMoDTc6+9cQyQQyMYpzUBI4yeGHNBR1hKp4bLyOVeMXuR33sJfUY3vqCTI8Rbt
         jMt3VUV/EbhhusPKArVA69h5WEAWFWlvyc4EkEgMx/pbdHcxn+u4rVzMpSkejSUcf9dl
         3XlPOSdPJ2ppqMeN6nxImGFn0QI7vvuyTP0+cI+b4W5xiChvkNdgap0KYQI2uQI2hDzx
         UYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767377160; x=1767981960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfcgCbP6RhhVMiMr9Azv6F2aQ7T6/MJccCOzX/54vEE=;
        b=AMFXmqCtXDwBwSaaLogrOdmEhKx0RPWqyH4TSg8yPKgUHSIVeMRoaUQ1vyda+NXG74
         UGttCHMrUk4MlrYG0Z/uuc+XiiC6DNiF1EwQKhUOXYmwyCKH/wKAvX+hebyGxa1fAEcf
         sF9QgiRp4YKR5nH/cL+5pR3P+olcmqJ9WgpRbrcU9YAfhsO4i2/5VAG5zCdjMtBbocS4
         3l8Hbpq0rMPCPCK4eag2wFOdahMVyMR1Nts/OEeuOOw42PFRo069qLO3lC6rR+A4ekbB
         i12JN1CQrrPL5BYbHVJdRLsxmZGPnhmIIDC1OrqR7AhXsa0c0bo0dE4a9HdVxamhQziV
         MoQQ==
X-Gm-Message-State: AOJu0YxOk6TrKfrlAJ4MnKLDT1j2+kbD6uYl/FzGN9FMOMqr/8s73bS5
	xMRp5NYW5MLEC9LgtJDTkH2puWuBWtJqEfxWROG+8kL2Guwtbs6Krxsjf6feSQ==
X-Gm-Gg: AY/fxX4JigKhPzkAMZSjEhlpmcUL08ganjzC704ZG52VyFH2lN8XDEkpgD9vhNgIvR6
	qfPpgR83a4BOW2UB066yyMJNNx/12GWofHmzAm7OVQ39YE+jgoLqGhjEfLENPLQOlTZ/wLHuQQh
	Esr1IT7LPUehsFUuSMG6DV0wW+6e8sSAoYBGijsikiOBFLFTzmwxA4SGuS7xpATyq6XfXZyLXYJ
	40qHOXgunHCMb3hPlo2zLmlkVYfqpC35Xi1aFMwzVhhl8+N0L56lwXHchEi/B6PDrExaC9mCphW
	F3QAflyLJXcW0AkUALPSo98pG3y8pMP9jmEwr603fU34j0P7Dkc9PBGrVihbLLDCVl7jJ8P39Mg
	Q4h27qHKn0UhkB4LWLYrHoZ793BJigQUf4wX+vJ+vrgHuqlOp4WHc3d7soNyB8XnkBAbc52bLup
	zaId6Jv9hSPPp3INUguheGCDf+keZQ7jtGD3U9p4adtzpHSnotn+1M+r903tBB2O7EpUI=
X-Google-Smtp-Source: AGHT+IGlPf0sJytEVblRsx7DE7M/l8a4Fbt7aqtuWECHLRxylpFO/PMXbrQ9354tq/9aQ/e2ZEXM+g==
X-Received: by 2002:a17:902:e74b:b0:299:e215:f61e with SMTP id d9443c01a7336-2a2f2a34fadmr407610955ad.36.1767377159960;
        Fri, 02 Jan 2026 10:05:59 -0800 (PST)
Received: from localhost.localdomain ([223.181.108.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77566sm386297585ad.97.2026.01.02.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:05:59 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v7 2/2] virtio-net: Implement ndo_write_rx_mode callback
Date: Fri,  2 Jan 2026 23:35:30 +0530
Message-ID: <20260102180530.1559514-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
References: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ndo_write_rx_mode callback for virtio-net

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 drivers/net/virtio_net.c | 55 +++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..83d543bf6ae2 100644
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
 
@@ -3866,33 +3863,31 @@ static int virtnet_close(struct net_device *dev)
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
+	int idx;
 	int i;
 
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
@@ -3900,7 +3895,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_rx_mode_get_cfg(dev,
+						  NETIF_RX_MODE_CFG_ALLMULTI);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3908,27 +3904,22 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	netif_addr_lock_bh(dev);
-
-	uc_count = netdev_uc_count(dev);
-	mc_count = netdev_mc_count(dev);
+	uc_count = netif_rx_mode_get_uc_count(dev);
+	mc_count = netif_rx_mode_get_mc_count(dev);
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
+	netif_rx_mode_for_each_uc_addr(dev, ha_addr, idx)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[0], mac_data,
 		   sizeof(mac_data->entries) + (uc_count * ETH_ALEN));
@@ -3938,10 +3929,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
 	mac_data->entries = cpu_to_virtio32(vi->vdev, mc_count);
 	i = 0;
-	netdev_for_each_mc_addr(ha, dev)
-		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
-
-	netif_addr_unlock_bh(dev);
+	netif_rx_mode_for_each_mc_addr(dev, ha_addr, idx)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[1], mac_data,
 		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
@@ -3950,17 +3939,15 @@ static void virtnet_rx_mode_work(struct work_struct *work)
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
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_SET_SKIP, cfg_disabled);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5776,7 +5763,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_flush_rx_mode_work(vi->dev);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -6279,6 +6266,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_validate_addr   = eth_validate_addr,
 	.ndo_set_mac_address = virtnet_set_mac_address,
 	.ndo_set_rx_mode     = virtnet_set_rx_mode,
+	.ndo_write_rx_mode   = virtnet_write_rx_mode,
 	.ndo_get_stats64     = virtnet_stats,
 	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
@@ -6900,7 +6888,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
-	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
@@ -7205,7 +7192,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_flush_rx_mode_work(vi->dev);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.47.3


