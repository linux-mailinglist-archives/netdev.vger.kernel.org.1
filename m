Return-Path: <netdev+bounces-194374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D9AC91D0
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F6C9E4B51
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC020219A70;
	Fri, 30 May 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI2S6MQn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F99235042
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616597; cv=none; b=jykL9VoKwEbLcdRb2bBKEKx/CSjKH2EqCVoB/h7DNPfHTyCFZt+Dgh/gZRgieyKdDoXKMGpfov3Bd3psnydFLb3ad8T7LtlcVQnfgbFnt7t0Et2jJpKs80lZ5hSZYRKZD5SarVJtLNWeuVUQWO8oYsrvwOiPxE5ldgkias5x/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616597; c=relaxed/simple;
	bh=FcEJ+0O0ToqBP82s+Slow/CP+BPprLxC042Q6netQqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeEQvMuz30l+OcodiM4GHrd3rFNy+PVrb7prsAN4C6D1T6022wpBlMjqrk4qPD6yYzgudfXaSRg0PuLTGaSJmUCZG/zF0YzVX0vBSe6JPC716nMpWNsqvdPaVgLBuK/V9scLw+mudwYzrLge/NbaseF1ZgMEJKYEvSy8elCv4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TI2S6MQn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748616594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYIli/z3Ts4QdiCP66JcfgUCtFLrU73s6EKuXdj/xcs=;
	b=TI2S6MQnROZQ9kZnaJUf/8ipGWeHlrP63lomlVXSiF+x0frDCG86dO6RuBzSYc2KDGYoh4
	yv/VKiKtlnDuxM9TaRJpabJZrscqHYL6yoJsDJV+lxO15D396OZZZuCb2Awfzp4+PkhpN3
	lNayNNO35Bl83mdI5NUBj8fKeffYVl8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-P7eKD-FgPkqJ30TivMICiQ-1; Fri,
 30 May 2025 10:49:53 -0400
X-MC-Unique: P7eKD-FgPkqJ30TivMICiQ-1
X-Mimecast-MFC-AGG-ID: P7eKD-FgPkqJ30TivMICiQ_1748616592
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C56F19560AE;
	Fri, 30 May 2025 14:49:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.184])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8E4019560B7;
	Fri, 30 May 2025 14:49:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 1/8] virtio: introduce virtio_features_t
Date: Fri, 30 May 2025 16:49:17 +0200
Message-ID: <5be304a8d0e2fffa6bd13cfa9ff848b2e5842171.1748614223.git.pabeni@redhat.com>
In-Reply-To: <cover.1748614223.git.pabeni@redhat.com>
References: <cover.1748614223.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features (above 64) for the virtio_net driver.

Introduce an specific type to represent the virtio features bitmask.

On platform where 128 bits integer are available use such wide int
for the features bitmask, otherwise maintain the current u64.

Introduce an extended get_features128() configuration callback that
devices supporting the extended features range must implement in
place of the traditional one.

Note that legacy and transport features don't need any change, as
they are always in the low 64 bit range.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - let u64 VIRTIO_BIT() cope with higher bit values
  - add .get_extended_features instead of changing .get_features signature
---
 drivers/virtio/virtio.c         | 14 +++++++-------
 drivers/virtio/virtio_debug.c   |  2 +-
 include/linux/virtio.h          |  5 +++--
 include/linux/virtio_config.h   | 32 ++++++++++++++++++++++----------
 include/linux/virtio_features.h | 27 +++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/virtio_features.h

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 95d5d7993e5b..206ae8fa0654 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -272,22 +272,22 @@ static int virtio_dev_probe(struct device *_d)
 	int err, i;
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
-	u64 device_features;
-	u64 driver_features;
-	u64 driver_features_legacy;
+	virtio_features_t device_features;
+	virtio_features_t driver_features;
+	virtio_features_t driver_features_legacy;
 
 	/* We have a driver! */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
 
 	/* Figure out what features the device supports. */
-	device_features = dev->config->get_features(dev);
+	device_features = virtio_get_features(dev);
 
 	/* Figure out what features the driver supports. */
 	driver_features = 0;
 	for (i = 0; i < drv->feature_table_size; i++) {
 		unsigned int f = drv->feature_table[i];
-		BUG_ON(f >= 64);
-		driver_features |= (1ULL << f);
+		BUG_ON(f >= VIRTIO_FEATURES_MAX);
+		driver_features |= VIRTIO_BIT(f);
 	}
 
 	/* Some drivers have a separate feature table for virtio v1.0 */
@@ -320,7 +320,7 @@ static int virtio_dev_probe(struct device *_d)
 		goto err;
 
 	if (drv->validate) {
-		u64 features = dev->features;
+		virtio_features_t features = dev->features;
 
 		err = drv->validate(dev);
 		if (err)
diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
index 95c8fc7705bb..5ca95422d3ca 100644
--- a/drivers/virtio/virtio_debug.c
+++ b/drivers/virtio/virtio_debug.c
@@ -12,7 +12,7 @@ static int virtio_debug_device_features_show(struct seq_file *s, void *data)
 	u64 device_features;
 	unsigned int i;
 
-	device_features = dev->config->get_features(dev);
+	device_features = virtio_get_features(dev);
 	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
 		if (device_features & (1ULL << i))
 			seq_printf(s, "%u\n", i);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 64cb4b04be7a..6e51400d0463 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -11,6 +11,7 @@
 #include <linux/gfp.h>
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
+#include <linux/virtio_features.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -159,11 +160,11 @@ struct virtio_device {
 	const struct virtio_config_ops *config;
 	const struct vringh_config_ops *vringh_config;
 	struct list_head vqs;
-	u64 features;
+	virtio_features_t features;
 	void *priv;
 #ifdef CONFIG_VIRTIO_DEBUG
 	struct dentry *debugfs_dir;
-	u64 debugfs_filter_features;
+	virtio_features_t debugfs_filter_features;
 #endif
 };
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 169c7d367fac..1cc43d9cf6e8 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -77,7 +77,10 @@ struct virtqueue_info {
  *      vdev: the virtio_device
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
- *	Returns the first 64 feature bits (all we currently need).
+ *	Returns the first 64 feature bits.
+ * @get_extended_features:
+ *      vdev: the virtio_device
+ *      Returns the first VIRTIO_FEATURES_MAX feature bits (all we currently need).
  * @finalize_features: confirm what device features we'll be using.
  *	vdev: the virtio_device
  *	This sends the driver feature bits to the device: it can change
@@ -121,6 +124,7 @@ struct virtio_config_ops {
 	void (*del_vqs)(struct virtio_device *);
 	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
+	virtio_features_t (*get_extended_features)(struct virtio_device *vdev);
 	int (*finalize_features)(struct virtio_device *vdev);
 	const char *(*bus_name)(struct virtio_device *vdev);
 	int (*set_vq_affinity)(struct virtqueue *vq,
@@ -149,11 +153,11 @@ static inline bool __virtio_test_bit(const struct virtio_device *vdev,
 {
 	/* Did you forget to fix assumptions on max features? */
 	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 64);
+		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 	else
-		BUG_ON(fbit >= 64);
+		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 
-	return vdev->features & BIT_ULL(fbit);
+	return vdev->features & VIRTIO_BIT(fbit);
 }
 
 /**
@@ -166,11 +170,11 @@ static inline void __virtio_set_bit(struct virtio_device *vdev,
 {
 	/* Did you forget to fix assumptions on max features? */
 	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 64);
+		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 	else
-		BUG_ON(fbit >= 64);
+		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 
-	vdev->features |= BIT_ULL(fbit);
+	vdev->features |= VIRTIO_BIT(fbit);
 }
 
 /**
@@ -183,11 +187,11 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
 {
 	/* Did you forget to fix assumptions on max features? */
 	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 64);
+		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 	else
-		BUG_ON(fbit >= 64);
+		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 
-	vdev->features &= ~BIT_ULL(fbit);
+	vdev->features &= ~VIRTIO_BIT(fbit);
 }
 
 /**
@@ -204,6 +208,14 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 	return __virtio_test_bit(vdev, fbit);
 }
 
+static inline virtio_features_t virtio_get_features(struct virtio_device *vdev)
+{
+	if (vdev->config->get_extended_features)
+		return vdev->config->get_extended_features(vdev);
+
+	return vdev->config->get_features(vdev);
+}
+
 /**
  * virtio_has_dma_quirk - determine whether this device has the DMA quirk
  * @vdev: the device
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
new file mode 100644
index 000000000000..0a7e2265f8b4
--- /dev/null
+++ b/include/linux/virtio_features.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VIRTIO_FEATURES_H
+#define _LINUX_VIRTIO_FEATURES_H
+
+#include <linux/bits.h>
+
+#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
+#define VIRTIO_HAS_EXTENDED_FEATURES
+#define VIRTIO_FEATURES_MAX	128
+#define VIRTIO_FEATURES_WORDS	4
+#define VIRTIO_BIT(b)		_BIT128(b)
+
+typedef __uint128_t virtio_features_t;
+
+#else
+#define VIRTIO_FEATURES_MAX	64
+#define VIRTIO_FEATURES_WORDS	2
+
+static inline u64 VIRTIO_BIT(int bit)
+{
+	return bit >= 64 ? 0 : BIT_ULL(b);
+}
+
+typedef u64 virtio_features_t;
+#endif
+
+#endif
-- 
2.49.0


