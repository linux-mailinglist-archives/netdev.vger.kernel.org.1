Return-Path: <netdev+bounces-267822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOo5OjSptWmw3AAAu9opvQ
	(envelope-from <netdev+bounces-267822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:30:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D7A28E774
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3137E3048EC8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68A336885;
	Sat, 14 Mar 2026 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpm+UR2I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91429334C28
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512951; cv=none; b=ouCHhPObca6pOadaYeUigTzjuUFM81k43wsv3RbGOxaNDQtpcYXYm3g4XrOw2w0GmThsUMJT3wtDdbQ5fPFlDfS/Mo+EK4Iw9AsEKRRJ3m2HKnP7Y3GLNgpfrmSTIAPIiwBh7hjNtpdvxpMh5XLvLKlhitoLmgq/ZauAP1CBlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512951; c=relaxed/simple;
	bh=VSzdK6fFXXfUKXv/QSuO1q2/KGkkuP3m3IoNyvnhahY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdi6zef7k0SeA/p4oTCgtRWZF0B/2soM6AxrJgCX+B1OwMnwLh4fQG2VB9IcTYwyMgYuWLi3QjMonZJ3kz0J8Id63BHkyrfo4ix4WQADrtXyYHL0Fvg//K74ihxj5jpV9Do04uQZAP7Wys41lTebIK0sXSJNxVtp5mRDIYllbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpm+UR2I; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae5636ab04so35729865ad.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512950; x=1774117750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPjyZJZYcHWPj/blRqGZlp+ucpD5kzaKMmjNcDwFvP0=;
        b=Hpm+UR2ISoqTel3g0/QJQAMklk2H8ruIjLxccQ2UanzGSbxtebZP+AKADohef7TKO9
         fOYm0/CY0vPXp5P59c2WxCegyZqtO2xCvLEBhT2GCMv4WfEoAA564Gr3o3gKBZK0GOLh
         w9iyC/3zE/aW2a9rd3Mkc1lc+jl8GBeHQ23KkJf6DLQxnVdDKUSPAueeeayvVceRZQ4E
         7K8BwMM9juEJQkyF0WT1OR0hJYZXwqsgEitezBm6E+fMD4RqmYiBa3kuXowv2FrnQrF1
         CcnbY1Qxk3NdLKwDiqaQIEZou1kQNHNMbF0hqh8P0LdcbZpqEWZyh3bkkXPysF9t4KgR
         MsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512950; x=1774117750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPjyZJZYcHWPj/blRqGZlp+ucpD5kzaKMmjNcDwFvP0=;
        b=CKlT1G4R0k7oVJJbx/BX6j3VOkdSTV++IWt+gNyckTzcxCI10KhUbH/ocdIK/kisLL
         FGbg6z1towXfGVd6cIHjnvmbrN8RTFRiwM7YjHZZjp2FdR2pClaECLGNuZrNDYrjuW25
         3gKt+rH7zFHUk5Z3bUF4NpuRM+NVyMCGSxH5O5NyXrgi2F6rTYAm8j0RPWoTemYbuJCr
         MCFKAeCLIzfug4R9glMvSFZ3O1vf+0g6u2a+xFDVx48entixZ1DuBWubFV3yJ/mMA41S
         ldtVZQvPaeAl5M9CUXwisC34wRTGkZbQnG7wutkZ2P9zt72zLc70fG91GBmXtq9df6PE
         OeSA==
X-Forwarded-Encrypted: i=1; AJvYcCXasqqSsNS6PUWdH/ffOk3gfMKfVQ8BMi8oXgzpSYGq4OUZzzUQXsLnSh1aWLhcm4jSYJSEBvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5c0zJp+mDQUc4KcdWiiN+cleY11ymd9fb/Ao8sC18cZPZp+v
	FMM9pP3FN5F26DDKg/J/T2D3ZXAWylnvhwNUQpfmKTcWmwsIqic0Euwu
X-Gm-Gg: ATEYQzwxIt39jfGnQGl8B57vvNOJ4qRrmLlnNfaMiOhUCB70hXaXf5Y3kQqJeEtWGCu
	Tb6xoPupiv1tJhGrutfo/jl1BCY6HqAxXcRXVZakDSZANtsvqIL41XaKNp5MKIyLn8WC/NzQxU2
	gk39Cd2rD44TsFF7zPnvzSZ8asbypHIa8x4TMjGSp5aX1u9YOWIfIcC1tC2MgLjfcfbveRWifHU
	qsX5cH6UFskE8uxGt8M0gX4y6hhDJvJ4sWsu/jCJtXzbQok7T0XOrwgCQNvLPMGxV7p9FezBbvQ
	QC2yFlM6Bd9P15ds53Fp4zIHYpXRHU+nRJyzm6k+nzaP/xQidc/zx8RCii2EB5C6RafIQmac7k8
	v7ma6zg55Za0b23g+5JYAvfNLqldk/MQGediImt88xppB6jQCnwOd8UCbqHlbys7c/ZImo/JgTH
	+jTVwgVrPyFygOx6ZF5mgoQjXV1S3/Sqg+GQympQ53/vPnHJMskDVMBtAyiHCxqvFdv+0CzE3+6
	+GG2g==
X-Received: by 2002:a17:903:1210:b0:2ae:b9cd:d2df with SMTP id d9443c01a7336-2aecab1f32bmr78786355ad.34.1773512949621;
        Sat, 14 Mar 2026 11:29:09 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:29:09 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: stfomichev@gmail.com,
	horms@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	mst@redhat.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v9 3/7] virtio-net: Implement ndo_set_rx_mode_async callback
Date: Sat, 14 Mar 2026 23:58:05 +0530
Message-ID: <20260314182809.362808-4-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,lists.linux.dev,lists.osuosl.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267822-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viswanathiyyappan@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3D7A28E774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the ndo_set_rx_mode_async callback and update
the driver to use the snapshot/commit model for RX mode update.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 
  There are no calls to netif_set_rx_mode in virtio-net
 
 drivers/net/virtio_net.c | 85 ++++++++++++----------------------------
 1 file changed, 25 insertions(+), 60 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 811b90da15a9..70255d09401c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -448,12 +448,6 @@ struct virtnet_info {
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
-	/* Work struct for setting rx mode */
-	struct work_struct rx_mode_work;
-
-	/* OK to queue work setting RX mode? */
-	bool rx_mode_work_enabled;
-
 	/* Does the affinity hint is set for virtqueues? */
 	bool affinity_hint_set;
 
@@ -717,20 +711,6 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_rx_mode_work(struct virtnet_info *vi)
-{
-	rtnl_lock();
-	vi->rx_mode_work_enabled = true;
-	rtnl_unlock();
-}
-
-static void disable_rx_mode_work(struct virtnet_info *vi)
-{
-	rtnl_lock();
-	vi->rx_mode_work_enabled = false;
-	rtnl_unlock();
-}
-
 static void virtqueue_napi_schedule(struct napi_struct *napi,
 				    struct virtqueue *vq)
 {
@@ -3802,33 +3782,30 @@ static int virtnet_close(struct net_device *dev)
 	return 0;
 }
 
-static void virtnet_rx_mode_work(struct work_struct *work)
+static void virtnet_set_rx_mode_async(struct net_device *dev)
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
 
-	/* We can't dynamically set ndo_set_rx_mode, so return gracefully */
+	/* We can't dynamically set rx_mode, so return gracefully */
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	promisc_allmulti = kzalloc_obj(*promisc_allmulti);
+	promisc_allmulti = kzalloc_obj(*promisc_allmulti, GFP_ATOMIC);
 	if (!promisc_allmulti) {
 		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
 		return;
 	}
 
-	rtnl_lock();
-
-	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
+	*promisc_allmulti = netif_get_rx_mode_cfg(dev,
+						  NETIF_RX_MODE_CFG_PROMISC);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3836,7 +3813,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_get_rx_mode_cfg(dev,
+						  NETIF_RX_MODE_CFG_ALLMULTI);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3844,27 +3822,22 @@ static void virtnet_rx_mode_work(struct work_struct *work)
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
@@ -3874,10 +3847,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
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
@@ -3886,17 +3857,16 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
-	rtnl_unlock();
-
 	kfree(buf);
 }
 
 static void virtnet_set_rx_mode(struct net_device *dev)
 {
-	struct virtnet_info *vi = netdev_priv(dev);
+	bool allmulti = !!(dev->flags & IFF_ALLMULTI);
+	bool promisc = !!(dev->flags & IFF_PROMISC);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5711,8 +5681,6 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
-	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -5738,8 +5706,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_rx_mode_work(vi);
-
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
 		err = virtnet_open(vi->dev);
@@ -6214,6 +6180,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_validate_addr   = eth_validate_addr,
 	.ndo_set_mac_address = virtnet_set_mac_address,
 	.ndo_set_rx_mode     = virtnet_set_rx_mode,
+	.ndo_set_rx_mode_async  = virtnet_set_rx_mode_async,
 	.ndo_get_stats64     = virtnet_stats,
 	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
@@ -6834,7 +6801,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
-	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -6986,8 +6952,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
-	enable_rx_mode_work(vi);
-
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -7136,8 +7100,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
-	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
 
 	virtnet_free_irq_moder(vi);
 
@@ -7158,6 +7120,7 @@ static __maybe_unused int virtnet_freeze(struct virtio_device *vdev)
 	virtnet_freeze_down(vdev);
 	remove_vq_common(vi);
 
+	netif_disable_async_ops(vi->dev);
 	return 0;
 }
 
@@ -7166,6 +7129,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
 	struct virtnet_info *vi = vdev->priv;
 	int err;
 
+	netif_enable_async_ops(vi->dev);
 	err = virtnet_restore_up(vdev);
 	if (err)
 		return err;
@@ -7175,6 +7139,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
 	if (err) {
 		virtnet_freeze_down(vdev);
 		remove_vq_common(vi);
+		netif_disable_async_ops(vi->dev);
 		return err;
 	}
 
-- 
2.47.3


