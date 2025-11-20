Return-Path: <netdev+bounces-240411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CC3C74899
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11FD04ED9CF
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8334A78B;
	Thu, 20 Nov 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH8qkKE/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6553451D7
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648181; cv=none; b=EcgS3nEOmQjxRUJAxwwnsmzWrbfJkRb783AB+9r5GvQwiIfRxo7M6cKohlmW6aivcpDJIsqVfCNe3vLlApeVKEPN2aqeC+mvEcUfesnFQBdZgIp+EAKl94DslCn/JWX+vP5t4woT6Ng1jFQFtJ4SMMznM+uTUI/u/K1qUQaotlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648181; c=relaxed/simple;
	bh=4lUxBl35hiX+aOQNkVxqqufLHrFNbtmDbn1ycs8l5GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UaUAtrG9Lg5akw3B8y4TcabGoO0XWu97rThiQHMS/v2nLORV7RcB1U+TM/0VyQMbq5OpU4DrJzbP3wIrwGB2Pl+1CXPQ9WMHSaDBDeYkIlXKGMMznC4xnTI7l5UedabzcJ1ETk3zBS0MG/hrnU2dJgZebdbJID1zYUYr/96q9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IH8qkKE/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-298287a26c3so11077075ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 06:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763648179; x=1764252979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAGq5XcXm/Y4JxXSxKOtW3K0P9eaNPEoSVdhsih2P6s=;
        b=IH8qkKE/qbYzYBslD9p/dE3NYSgkHM2zdCFZW4qkzXjO0WYRUeDd/Vm2V1odt3gXj7
         Eybj48XNBqL4+9tqI9rxkVvUijWCbnANl/CIFJWwdsYGB7EcCyPAuNXKXldxrDcelcbs
         skigjZT+EL4yGML2gZEVusOfW4SgqAl35rcxSvnHYNNrEbrp8gge/T6UsRp+jzbzj9e3
         KiZOo7LnjHbxXgMQcn5KbnMk8usvUx/SO1rMiKz9MOAwFlO0ah4p732VcmkKlyTGN8Dr
         2oCgXEFtfjmH9PURxT4QkWkEPqR8hzwQWuOxl9RcedKZpL0h82ggFrQB9Tr5PlJnl+g8
         dPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648179; x=1764252979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAGq5XcXm/Y4JxXSxKOtW3K0P9eaNPEoSVdhsih2P6s=;
        b=FITKMq2uiGgD/frdjaQqR5C0fruR3VZQ2j1DeSY0QrYdvQZryM9wOw708Wqmwi3Fvt
         PG4a7m7u/eWR8BaUSJTZpfDKtC5o66+WYTiqHwAyAHOW1mROSTSAIHHdlJBE23ZP9H2p
         MIJU3REK47Fhx900MCNIDIZ2IRTSWSK6akgG5bJQ6ZumqDGT9HgsQ2qtVheD+buiqPT7
         isP9kNqlbF5cjMGwO+d3eMMbMwQ1OChR1NsIbYolYNENQ9mFwun1qZ/FjRiM/IUKcvwN
         w8RcGw56rmptZHa5B2vfBggsgah/RTRNxH//N78jfuwvjX+oZZxE9wXRjVkv9ZQjIxAJ
         VHpg==
X-Forwarded-Encrypted: i=1; AJvYcCWip7QPBpHtMtS/Hb3iuxwXMxO38KB21EIsCJlX+rBalTG9BwP89qeKXNZ7WAKRse4YLtVXG70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6OkwIGcchda0DqzqU4bFEEUZbLop4xSLQ4mryUeA0cKYoByP
	Dv0alEpHYYoOQHYVmzsCv1e8cI2HPXCm95ET30OCVPbj/6QCyEpFP9dA
X-Gm-Gg: ASbGncubVFyOCnnQymU47roWg+hqg7ra9nvNv0Tkh4/DGDPhbaufXe1HwWiWtEmXONC
	uKEtGZ0fIfcvVCXqTw3LUTK5bz7NEzYaWRj/qWlHWCCkZTh8Oh2SF5SDtkjjxl0bznb/G9UVVYo
	fn6yOocqZr/RUgL+qoItjG2wAa88o/3xuE70CjRtP3JpBfA3ZiHxdcR2pBz6CGy/KNQFV5iD+1d
	x6zBtEXtJy7dIBqvRuIp+qwx7feKdQngGlS1NJDrSvLlPQKlb88FC8+kC7sl8cCK5oY/iVwBd9B
	ZZ1WSETW9upuFtKhFd3tu+OV9h1YiHxIWdvuRc4kUG3q2FCKANSAoEU4aQx+AM7C/4WLXu+o4l/
	ZhrkkOiQfGT1f8Ox0UcqT72EBXLN72srbh/3gAc74YaWwg086OC+w6P99QcuHbiu2p30eN2FXJD
	0OeqaYs2DkWMHSoCOqcWiWUju8IveC59w=
X-Google-Smtp-Source: AGHT+IFSkh83U/i2V3nJDK19i9ZiBFZsM67zxW6fP6ALH6yW1nwB7efOT9W49MC+dLNf/XtfEJOJTQ==
X-Received: by 2002:a17:902:e787:b0:298:6a79:397b with SMTP id d9443c01a7336-29b5cdcf0a5mr36923155ad.56.1763648178714;
        Thu, 20 Nov 2025 06:16:18 -0800 (PST)
Received: from COB-LTR7HP24-497.. ([223.185.131.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138bcbsm28442915ad.29.2025.11.20.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:16:18 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	skhawaja@google.com,
	aleksander.lobakin@intel.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v5 2/2] virtio-net: Implement ndo_write_rx_mode callback
Date: Thu, 20 Nov 2025 19:43:54 +0530
Message-Id: <20251120141354.355059-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120141354.355059-1-viswanathiyyappan@gmail.com>
References: <20251120141354.355059-1-viswanathiyyappan@gmail.com>
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
 drivers/net/virtio_net.c | 58 +++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cfa006b88688..02bf9bc970a0 100644
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
 
@@ -3857,33 +3854,31 @@ static int virtnet_close(struct net_device *dev)
 	return 0;
 }
 
-static void virtnet_rx_mode_work(struct work_struct *work)
+static void virtnet_write_rx_mode(struct net_device *dev)
 {
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, rx_mode_work);
+	struct virtnet_info *vi = netif_rx_mode_get_priv_ptr(dev);
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
+	*promisc_allmulti = netif_rx_mode_get_bit(dev,
+						  NETIF_RX_MODE_PROM_EN);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3891,7 +3886,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_rx_mode_get_bit(dev,
+						  NETIF_RX_MODE_ALLMULTI_EN);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3899,27 +3895,24 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	netif_addr_lock_bh(dev);
+	uc_count = netif_rx_mode_get_uc_count(dev);
+	mc_count = netif_rx_mode_get_mc_count(dev);
 
-	uc_count = netdev_uc_count(dev);
-	mc_count = netdev_mc_count(dev);
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
+
+	netif_rx_mode_for_each_uc_addr(dev, ha_addr, idx)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[0], mac_data,
 		   sizeof(mac_data->entries) + (uc_count * ETH_ALEN));
@@ -3929,10 +3922,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
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
@@ -3941,17 +3932,18 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
-	rtnl_unlock();
-
 	kfree(buf);
 }
 
 static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	char cfg_disabled;
+
+	cfg_disabled = !vi->rx_mode_work_enabled;
+	netif_rx_mode_set_bit(dev, NETIF_RX_MODE_SET_DIS, cfg_disabled);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	netif_rx_mode_set_priv_ptr(dev, vi);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5767,7 +5759,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_rx_mode_flush_work(vi->dev);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -6270,6 +6262,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_validate_addr   = eth_validate_addr,
 	.ndo_set_mac_address = virtnet_set_mac_address,
 	.ndo_set_rx_mode     = virtnet_set_rx_mode,
+	.ndo_write_rx_mode   = virtnet_write_rx_mode,
 	.ndo_get_stats64     = virtnet_stats,
 	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
@@ -6891,7 +6884,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
-	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
@@ -7196,7 +7188,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_rx_mode_flush_work(vi->dev);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.34.1


