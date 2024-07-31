Return-Path: <netdev+bounces-114370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5569424AF
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C071F245D4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C8D18E25;
	Wed, 31 Jul 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpfOSTd3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13517BCE
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394832; cv=none; b=QxhrXTfChW/muwsNkvy4ymNRssgkKsynYIc1Al3JeAggsOb1pheGvjEV0gX1Z8+9QNljvTuKbiyq1MJILFgT68EPuD3F0ip60HDAJUh5esbo20XSZ8646VxImhJQc/afh+lBwaCauBIOtJpE29BIG5hK1K8UoOm8C44FDGC671s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394832; c=relaxed/simple;
	bh=uAU0P6+0lDzPFsXIHIEWlh28IqIPyDadZZ7vb89j1jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU1Q28/blaQ661x+Dw2qfyXGdBT1fgN2XPWwKuO97NFKZtiWmtR+5vHpXXn/jhxjM0lmc2KI32i9T7pqfe8TNRXuK/kQvs6dPJpKiCtwdebpLl7AidqSYM6/nLGqMg+PynUBnf1nZ6hMp68vncdFX5CUeXSsiSfJpGvVMKoMwiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpfOSTd3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722394830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xx609ff8H8yeYTarR3YmkLHnsgWN7Wa35yipGuXT/UY=;
	b=DpfOSTd3m+KJxPmKDEFYkIWlDq2Q4C5H6j95OL4AXho8WmaK8jmTBlbThS0XiIdAEGfGn+
	Bw64guRN+kIBTyr6XZ+ffkYatbcFlbDYuehmS5nOxtvq0PypiPewg+93QG8bpe7gnxd0/R
	qTXF50xxdLuzUkqKlPTg2zTDus+WiRQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-6yGsgh5oO-ma_hoPF6Nx1A-1; Tue,
 30 Jul 2024 23:00:26 -0400
X-MC-Unique: 6yGsgh5oO-ma_hoPF6Nx1A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE8D71955D47;
	Wed, 31 Jul 2024 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2BF1195605A;
	Wed, 31 Jul 2024 03:00:16 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: [PATCH V4 net-next 3/3] virtio-net: synchronize operstate with admin state on up/down
Date: Wed, 31 Jul 2024 10:59:47 +0800
Message-ID: <20240731025947.23157-4-jasowang@redhat.com>
In-Reply-To: <20240731025947.23157-1-jasowang@redhat.com>
References: <20240731025947.23157-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
 drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0383a3e136d6..0cb93261eba1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2878,6 +2878,7 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	return err;
 }
 
+
 static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
 {
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
@@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
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
@@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
 			goto err_enable_qp;
 	}
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
+		if (vi->status & VIRTIO_NET_S_LINK_UP)
+			netif_carrier_on(vi->dev);
+		virtio_config_driver_enable(vi->vdev);
+	} else {
+		vi->status = VIRTIO_NET_S_LINK_UP;
+		netif_carrier_on(dev);
+		virtnet_update_settings(vi);
+	}
+
 	return 0;
 
 err_enable_qp:
@@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
 	disable_delayed_refill(vi);
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
+	/* Make sure config notification doesn't schedule config work */
+	virtio_config_driver_disable(vi->vdev);
+	/* Make sure status updating is cancelled */
+	cancel_work_sync(&vi->config_work);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
 
+	netif_carrier_off(dev);
+
 	return 0;
 }
 
@@ -5085,25 +5121,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
@@ -6514,6 +6531,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_failover;
 	}
 
+	/* Forbid config change notification until ndo_open. */
+	virtio_config_driver_disable(vi->vdev);
+	/* Make sure status updating work is done */
+	cancel_work_sync(&vi->config_work);
+
 	virtio_device_ready(vdev);
 
 	virtnet_set_queues(vi, vi->curr_queue_pairs);
@@ -6563,6 +6585,19 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->device_stats_cap = le64_to_cpu(v);
 	}
 
+	/* Assume link up if device can't report link status,
+           otherwise get link status from config. */
+        netif_carrier_off(dev);
+        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
+		/* This is safe as config notification change has been
+		   disabled. */
+                virtnet_config_changed_work(&vi->config_work);
+        } else {
+                vi->status = VIRTIO_NET_S_LINK_UP;
+                virtnet_update_settings(vi);
+                netif_carrier_on(dev);
+        }
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -6571,17 +6606,6 @@ static int virtnet_probe(struct virtio_device *vdev)
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


