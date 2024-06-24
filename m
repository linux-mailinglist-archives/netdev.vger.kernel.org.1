Return-Path: <netdev+bounces-105981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2365A9140A5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 04:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AE41C21223
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 02:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8751D26D;
	Mon, 24 Jun 2024 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TywgmhgR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9D16426
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197166; cv=none; b=NYX90bcKohDOe0nUvEq3RMJEVbfli0KbzIxKqDMoXoJzp5+O+V/9s7+LK6o7sRshw2iFQaKQPQ3/tZ1wuLAuIZdOOgFhlvum1FQCR6tlYawnuekB4PTFbUS0jJqxOInrDmPSqxH4YqNQHEd4cdV+k7+5nrYimgUACG2ALPrDYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197166; c=relaxed/simple;
	bh=xrnTznWO0t6fEyDXXfVGGUJTLL7JhYCWJzYpH5RdVmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cb3FqWpQ6ymXLtxVzue9NZeVB/96diuBKhK0R3pzE49vYrJvduOejElAZ7UYYlcajE9Ph6sh5aon5avOaxlWFU638FGQNWx9wahhbXuEjPZ0pe105fDqMiQ68DV/WIwxZuyiSkFmrLFUAhJ8kr6h5fUDjjIVZeNPxFh9+JANEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TywgmhgR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719197163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JoTg8PDCE098Q5EAv+T5FMI5uH/Qj7gpqddOfjwaaw=;
	b=TywgmhgRNGqFXKQ27oHEUuXcaUes+6bsle/Z8wHUEWQ4jme7+EH/il0PUkEfmJ6HDTlao2
	5iBJBLYCIPxdY6GaqcricaoaFQplWihdRL+f4cv3biE0EwUGOc+puc2KU8qDBPntht7kJH
	VWr/cIoVGAUDmcon0dj5MZuSRWcpeMM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-0dUcFOo-NV23UWJsShl5tg-1; Sun,
 23 Jun 2024 22:46:00 -0400
X-MC-Unique: 0dUcFOo-NV23UWJsShl5tg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4666419560B6;
	Mon, 24 Jun 2024 02:45:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C1A93000219;
	Mon, 24 Jun 2024 02:45:50 +0000 (UTC)
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
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH V2 3/3] virtio-net: synchronize operstate with admin state on up/down
Date: Mon, 24 Jun 2024 10:45:23 +0800
Message-ID: <20240624024523.34272-4-jasowang@redhat.com>
In-Reply-To: <20240624024523.34272-1-jasowang@redhat.com>
References: <20240624024523.34272-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 drivers/net/virtio_net.c | 72 +++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b1f8b720733e..eff3ad3d6bcc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2468,6 +2468,25 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
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
@@ -2486,6 +2505,22 @@ static int virtnet_open(struct net_device *dev)
 			goto err_enable_qp;
 	}
 
+	/* Assume link up if device can't report link status,
+	   otherwise get link status from config. */
+	netif_carrier_off(dev);
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
+		virtio_config_enable(vi->vdev);
+		/* We are not sure if config interrupt is disabled by
+		 * core or not, so we can't schedule config_work by
+		 * ourselves.
+		 */
+		virtio_config_changed(vi->vdev);
+	} else {
+		vi->status = VIRTIO_NET_S_LINK_UP;
+		virtnet_update_settings(vi);
+		netif_carrier_on(dev);
+	}
+
 	return 0;
 
 err_enable_qp:
@@ -2928,12 +2963,19 @@ static int virtnet_close(struct net_device *dev)
 	disable_delayed_refill(vi);
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
+	/* Make sure config notification doesn't schedule config work */
+	virtio_config_disable(vi->vdev);
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
 
@@ -4632,25 +4674,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
@@ -5958,17 +5981,6 @@ static int virtnet_probe(struct virtio_device *vdev)
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
2.31.1


