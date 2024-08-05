Return-Path: <netdev+bounces-115613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A29473AD
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA80B212F5
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 03:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D0B145345;
	Mon,  5 Aug 2024 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSYOXu3O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E28C13D504
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722827005; cv=none; b=UF8onPUF10c000nt4Jnbokpy/kE7G7+G5KebbJs1tQzOiuL9EGfK1MVCzkP4kiTfcQ3KO4KrYqp+6VnwNPIb8HlyzMA/smgR0ZBAwBjnAFGcrW8HXv/f7Im9MGynGuk05LTAsm0N7I5ecAnZlsStq5pJCtW04vTvWNKJCQOwQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722827005; c=relaxed/simple;
	bh=K89hFkYoOiNcoJg+0ZYyGQvCv65GHgkuzItUGHZzixg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g13a26+5FHpWXlb1Lu/wdIThQ356D5tuM1Xwp7rtbjjzod3XMlFS4ORe5iCeLKfuNhcJbODBQePzI/b4b6AXrxboe4EoohQR4YN2pP0F+LEXiQ5+hZi0H8IQVLjstwRGMLDYVvU993cFPKvRsck+u+Upa6d+MnrQhPaR3D9xKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSYOXu3O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722827002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAkB5VNbMImzIR2291b/Iqbq49RjZTh1/9HBDSMLYYw=;
	b=fSYOXu3OT1iz1qodWqASRriItuqx8usxCDIIlNOJVGmlRoJlQtr8c0b1Z0JP2WIwhhuRAl
	ybh8YnkzSa2Oi9pC8sv0zHs8DH9wnZ4i/8l4kR+EK/62TXgFtQPMFkBL5lA2XD8JjR8f6K
	TUn5XdLjXtCbpKAq5nKbYLLNy3Fdu40=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-t4qlpP78MH-G_Z9YkJaJAw-1; Sun,
 04 Aug 2024 23:03:18 -0400
X-MC-Unique: t4qlpP78MH-G_Z9YkJaJAw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D51861956088;
	Mon,  5 Aug 2024 03:03:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.218])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A43A1955F40;
	Mon,  5 Aug 2024 03:03:08 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: [PATCH V5 net-next 3/3] virtio-net: synchronize operstate with admin state on up/down
Date: Mon,  5 Aug 2024 11:02:42 +0800
Message-ID: <20240805030242.62390-4-jasowang@redhat.com>
In-Reply-To: <20240805030242.62390-1-jasowang@redhat.com>
References: <20240805030242.62390-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0383a3e136d6..fc5196ca8d51 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2885,6 +2885,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
 	net_dim_work_cancel(dim);
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
@@ -2903,6 +2922,15 @@ static int virtnet_open(struct net_device *dev)
 			goto err_enable_qp;
 	}
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
+		if (vi->status & VIRTIO_NET_S_LINK_UP)
+			netif_carrier_on(vi->dev);
+		virtio_config_driver_enable(vi->vdev);
+	} else {
+		vi->status = VIRTIO_NET_S_LINK_UP;
+		netif_carrier_on(dev);
+	}
+
 	return 0;
 
 err_enable_qp:
@@ -3381,12 +3409,22 @@ static int virtnet_close(struct net_device *dev)
 	disable_delayed_refill(vi);
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
+	/* Prevent the config change callback from changing carrier
+	 * after close
+	 */
+	virtio_config_driver_disable(vi->vdev);
+	/* Stop getting status/speed updates: we don't care until next
+	 * open
+	 */
+	cancel_work_sync(&vi->config_work);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
 
+	netif_carrier_off(dev);
+
 	return 0;
 }
 
@@ -5085,25 +5123,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
@@ -6514,6 +6533,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_failover;
 	}
 
+	/* Disable config change notification until ndo_open. */
+	virtio_config_driver_disable(vi->vdev);
+
 	virtio_device_ready(vdev);
 
 	virtnet_set_queues(vi, vi->curr_queue_pairs);
@@ -6563,25 +6585,25 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->device_stats_cap = le64_to_cpu(v);
 	}
 
-	rtnl_unlock();
-
-	err = virtnet_cpu_notif_add(vi);
-	if (err) {
-		pr_debug("virtio_net: registering cpu notifier failed\n");
-		goto free_unregister_netdev;
-	}
-
 	/* Assume link up if device can't report link status,
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
-		schedule_work(&vi->config_work);
+		virtnet_config_changed_work(&vi->config_work);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;
 		virtnet_update_settings(vi);
 		netif_carrier_on(dev);
 	}
 
+	rtnl_unlock();
+
+	err = virtnet_cpu_notif_add(vi);
+	if (err) {
+		pr_debug("virtio_net: registering cpu notifier failed\n");
+		goto free_unregister_netdev;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
 		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
 			set_bit(guest_offloads[i], &vi->guest_offloads);
-- 
2.31.1


