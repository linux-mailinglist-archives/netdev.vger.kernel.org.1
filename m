Return-Path: <netdev+bounces-99265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D58D4403
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF6D286125
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CF1D554;
	Thu, 30 May 2024 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2IBJQ6x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1C1CA9E
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039277; cv=none; b=OacTxrgXz5cvFa87MNcjGZyEMjiBtQ82RTgKJMhM13RyLXKc4orzMZDFFjpX7xzciIxDeXgcfUuvbINbKoQN+k/RPtkLLEsnUyLDnsHEJHVHoTdD7oJz0DbZWiFYXhDexHRSZd40nXkOKM0VtjSWEyLZzKB/r36gruKLP7777qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039277; c=relaxed/simple;
	bh=n1Jdi8oml63cjaemoOBbfL5KLyFp1dEIVePxb+JZCNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=dnvBc9+/Eo2+b0b7E1j95LVvEyK3UmDlNnuVbDp37B8H9l5XYHX4ofuNrcFqQSRUUilNwDdtn3wzRJXZT7eCLImny9FLw7a/p1/J968wiRA2cFiqrzykLfMWKzCSIQ2jxS9sV4mPAVjzXJ+AHqpq7RozQXTvtudTNOkuNGsOhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2IBJQ6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xlxDamz4s7GJC+Y0kcerAZwk3gsEzznwc9ByMiBweRE=;
	b=d2IBJQ6xSyhSF/xtEcpZNNsFEVlvf8R8ErHJla26VJchD79A/rampwn0yY+9H03OpsYnZn
	HvQ2S0dkrVMS73pI9UVkGA4/X5fxeu9z91yw7G/mf/cySz5eTHVK03S9VXIjwhgqam/AZ2
	fITxu+TrlpbmYrYlRqgR27yY0E14YTo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-GJYXdUJkNfWa7HJyIVgX5w-1; Wed,
 29 May 2024 23:21:10 -0400
X-MC-Unique: GJYXdUJkNfWa7HJyIVgX5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BE1229AA381;
	Thu, 30 May 2024 03:21:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B31631C028E0;
	Thu, 30 May 2024 03:21:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: [PATCH net-next V2] virtio-net: synchronize operstate with admin state on up/down
Date: Thu, 30 May 2024 11:20:55 +0800
Message-ID: <20240530032055.8036-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

This patch synchronize operstate with admin state per RFC2863.

This is done by trying to toggle the carrier upon open/close and
synchronize with the config change work. This allows propagate status
correctly to stacked devices like:

ip link add link enp0s3 macvlan0 type macvlan
ip link set link enp0s3 down
ip link show

Before this patch:

3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
......
5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff

After this patch:

3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
...
5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
    link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff

Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- rebase
- add ack/review tags
---
 drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 31 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4a802c0ea2cb..69e4ae353c51 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -433,6 +433,12 @@ struct virtnet_info {
 	/* The lock to synchronize the access to refill_enabled */
 	spinlock_t refill_lock;
 
+	/* Is config change enabled? */
+	bool config_change_enabled;
+
+	/* The lock to synchronize the access to config_change_enabled */
+	spinlock_t config_change_lock;
+
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
@@ -623,6 +629,20 @@ static void disable_delayed_refill(struct virtnet_info *vi)
 	spin_unlock_bh(&vi->refill_lock);
 }
 
+static void enable_config_change(struct virtnet_info *vi)
+{
+	spin_lock_irq(&vi->config_change_lock);
+	vi->config_change_enabled = true;
+	spin_unlock_irq(&vi->config_change_lock);
+}
+
+static void disable_config_change(struct virtnet_info *vi)
+{
+	spin_lock_irq(&vi->config_change_lock);
+	vi->config_change_enabled = false;
+	spin_unlock_irq(&vi->config_change_lock);
+}
+
 static void enable_rx_mode_work(struct virtnet_info *vi)
 {
 	rtnl_lock();
@@ -2421,6 +2441,25 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	return err;
 }
 
+static void virtnet_update_settings(struct virtnet_info *vi)
+{
+	u32 speed;
+	u8 duplex;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
+		return;
+
+	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
+
+	if (ethtool_validate_speed(speed))
+		vi->speed = speed;
+
+	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
+
+	if (ethtool_validate_duplex(duplex))
+		vi->duplex = duplex;
+}
+
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2439,6 +2478,18 @@ static int virtnet_open(struct net_device *dev)
 			goto err_enable_qp;
 	}
 
+	/* Assume link up if device can't report link status,
+	   otherwise get link status from config. */
+	netif_carrier_off(dev);
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
+		enable_config_change(vi);
+		schedule_work(&vi->config_work);
+	} else {
+		vi->status = VIRTIO_NET_S_LINK_UP;
+		virtnet_update_settings(vi);
+		netif_carrier_on(dev);
+	}
+
 	return 0;
 
 err_enable_qp:
@@ -2875,12 +2926,19 @@ static int virtnet_close(struct net_device *dev)
 	disable_delayed_refill(vi);
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
+	/* Make sure config notification doesn't schedule config work */
+	disable_config_change(vi);
+	/* Make sure status updating is cancelled */
+	cancel_work_sync(&vi->config_work);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		virtnet_disable_queue_pair(vi, i);
 		cancel_work_sync(&vi->rq[i].dim.work);
 	}
 
+	vi->status &= ~VIRTIO_NET_S_LINK_UP;
+	netif_carrier_off(dev);
+
 	return 0;
 }
 
@@ -4583,25 +4641,6 @@ static void virtnet_init_settings(struct net_device *dev)
 	vi->duplex = DUPLEX_UNKNOWN;
 }
 
-static void virtnet_update_settings(struct virtnet_info *vi)
-{
-	u32 speed;
-	u8 duplex;
-
-	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
-		return;
-
-	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
-
-	if (ethtool_validate_speed(speed))
-		vi->speed = speed;
-
-	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
-
-	if (ethtool_validate_duplex(duplex))
-		vi->duplex = duplex;
-}
-
 static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
 {
 	return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
@@ -5163,7 +5202,10 @@ static void virtnet_config_changed(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
 
-	schedule_work(&vi->config_work);
+	spin_lock_irq(&vi->config_change_lock);
+	if (vi->config_change_enabled)
+		schedule_work(&vi->config_work);
+	spin_unlock_irq(&vi->config_change_lock);
 }
 
 static void virtnet_free_queues(struct virtnet_info *vi)
@@ -5706,6 +5748,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 	spin_lock_init(&vi->refill_lock);
+	spin_lock_init(&vi->config_change_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -5901,17 +5944,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_unregister_netdev;
 	}
 
-	/* Assume link up if device can't report link status,
-	   otherwise get link status from config. */
-	netif_carrier_off(dev);
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
-		schedule_work(&vi->config_work);
-	} else {
-		vi->status = VIRTIO_NET_S_LINK_UP;
-		virtnet_update_settings(vi);
-		netif_carrier_on(dev);
-	}
-
 	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
 		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
 			set_bit(guest_offloads[i], &vi->guest_offloads);
-- 
2.42.0


