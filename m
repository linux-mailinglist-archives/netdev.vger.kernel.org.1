Return-Path: <netdev+bounces-198734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6559CADD67D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83EF19E1EC8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE72EF650;
	Tue, 17 Jun 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIxQEItK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8122EF2B2
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176772; cv=none; b=azH6uMB5Y6QBRtDzGGCkZKpyMgYjVJZOInSAHaAUYKaM6szyy3Hcg9aILgLZRjuIq6o9bcQJe5qeebO6nEgVNQGBGu5D4LKZ27cLTJZzNQePFnnW35ghoP1o0hZNK0Go/FX4xigDc8cT+dKaaaxWGyj3kPBtXQFKIpRbpqUkM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176772; c=relaxed/simple;
	bh=W2q8jB7wuKseoN75wpJnDYk7PlPBbStlPh/2Ik5NKS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUqRJB0LHkky90JismkgjmYcRtfbqd7AKpi/Yn6ySB23IN5956lqyo6u9ddwETiIAghko2qXbo/IpxTt8ihE0+TWqfj+F0uIVxJtxfwmuw4LtJyKBIDax5q/vhggVesU5sOLVWaq4b0X+ieF/DwxgzYD/zPAso1G396HZFjQbP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIxQEItK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750176769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+C0PTSD2RXQIRMTcxmoaduffMPCL7b9u94naB+Z23o=;
	b=PIxQEItK46j35pDdnlr26+HWflblVT+iJK5+EDzqJTyouaDhBlA2cfv4vPjy5p+vrJ7hwh
	7VUACbedmQXzM3ezXsRbBxcddkvjCFiDSn55SV7SMJMWSXUPyTE3sNw1/zZgbeOVExq0Ya
	hCANd4y7RMO+ZdhazzXoUd05deVMnag=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-uMYKZ_FkM0-03HiSlXp8VQ-1; Tue,
 17 Jun 2025 12:12:45 -0400
X-MC-Unique: uMYKZ_FkM0-03HiSlXp8VQ-1
X-Mimecast-MFC-AGG-ID: uMYKZ_FkM0-03HiSlXp8VQ_1750176764
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 907DC1800368;
	Tue, 17 Jun 2025 16:12:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E0CF195E342;
	Tue, 17 Jun 2025 16:12:38 +0000 (UTC)
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
Subject: [PATCH v4 net-next 1/8] virtio: introduce extended features
Date: Tue, 17 Jun 2025 18:12:08 +0200
Message-ID: <2d17ac04283e0751c6a8e8dbda509dcc1237490f.1750176076.git.pabeni@redhat.com>
In-Reply-To: <cover.1750176076.git.pabeni@redhat.com>
References: <cover.1750176076.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features (above 64) for the virtio_net driver.

Introduce extended features as a fixed size array of u64. To minimize
the diffstat allows legacy driver to access the low 64 bits via a
transparent union.

Introduce an extended get_extended_features configuration callback
that devices supporting the extended features range must implement in
place of the traditional one.

Note that legacy and transport features don't need any change, as
they are always in the low 64 bit range.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - moved bit sanity check in virtio_features_*
  - replaced BUG_ON with WARN_ON_ONCE
  - *_and_not -> _andnot
  - short circuit features comparison
v2 -> v3:
  - uint128_t -> u64[2];
v1 -> v2:
  - let u64 VIRTIO_BIT() cope with higher bit values
  - add .get_features128 instead of changing .get_features signature
---
 drivers/virtio/virtio.c         | 43 +++++++++-------
 drivers/virtio/virtio_debug.c   | 27 +++++-----
 include/linux/virtio.h          |  5 +-
 include/linux/virtio_config.h   | 41 +++++++--------
 include/linux/virtio_features.h | 88 +++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+), 53 deletions(-)
 create mode 100644 include/linux/virtio_features.h

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 95d5d7993e5b..5c48788cdbec 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -53,7 +53,7 @@ static ssize_t features_show(struct device *_d,
 
 	/* We actually represent this as a bitstring, as it could be
 	 * arbitrary length in future. */
-	for (i = 0; i < sizeof(dev->features)*8; i++)
+	for (i = 0; i < VIRTIO_FEATURES_MAX; i++)
 		len += sysfs_emit_at(buf, len, "%c",
 			       __virtio_test_bit(dev, i) ? '1' : '0');
 	len += sysfs_emit_at(buf, len, "\n");
@@ -272,22 +272,22 @@ static int virtio_dev_probe(struct device *_d)
 	int err, i;
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
-	u64 device_features;
-	u64 driver_features;
+	u64 device_features[VIRTIO_FEATURES_DWORDS];
+	u64 driver_features[VIRTIO_FEATURES_DWORDS];
 	u64 driver_features_legacy;
 
 	/* We have a driver! */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
 
 	/* Figure out what features the device supports. */
-	device_features = dev->config->get_features(dev);
+	virtio_get_features(dev, device_features);
 
 	/* Figure out what features the driver supports. */
-	driver_features = 0;
+	virtio_features_zero(driver_features);
 	for (i = 0; i < drv->feature_table_size; i++) {
 		unsigned int f = drv->feature_table[i];
-		BUG_ON(f >= 64);
-		driver_features |= (1ULL << f);
+		if (!WARN_ON_ONCE(f >= VIRTIO_FEATURES_MAX))
+			virtio_features_set_bit(driver_features, f);
 	}
 
 	/* Some drivers have a separate feature table for virtio v1.0 */
@@ -295,24 +295,29 @@ static int virtio_dev_probe(struct device *_d)
 		driver_features_legacy = 0;
 		for (i = 0; i < drv->feature_table_size_legacy; i++) {
 			unsigned int f = drv->feature_table_legacy[i];
-			BUG_ON(f >= 64);
-			driver_features_legacy |= (1ULL << f);
+			if (!WARN_ON_ONCE(f >= 64))
+				driver_features_legacy |= (1ULL << f);
 		}
 	} else {
-		driver_features_legacy = driver_features;
+		driver_features_legacy = driver_features[0];
 	}
 
-	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
-		dev->features = driver_features & device_features;
-	else
-		dev->features = driver_features_legacy & device_features;
+	if (virtio_features_test_bit(device_features, VIRTIO_F_VERSION_1)) {
+		for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+			dev->features_array[i] = driver_features[i] &
+						 device_features[i];
+	} else {
+		virtio_features_from_u64(dev->features_array,
+					 driver_features_legacy &
+					 device_features[0]);
+	}
 
 	/* When debugging, user may filter some features by hand. */
 	virtio_debug_device_filter_features(dev);
 
 	/* Transport features always preserved to pass to finalize_features. */
 	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++)
-		if (device_features & (1ULL << i))
+		if (virtio_features_test_bit(device_features, i))
 			__virtio_set_bit(dev, i);
 
 	err = dev->config->finalize_features(dev);
@@ -320,14 +325,15 @@ static int virtio_dev_probe(struct device *_d)
 		goto err;
 
 	if (drv->validate) {
-		u64 features = dev->features;
+		u64 features[VIRTIO_FEATURES_DWORDS];
 
+		virtio_features_copy(features, dev->features_array);
 		err = drv->validate(dev);
 		if (err)
 			goto err;
 
 		/* Did validation change any features? Then write them again. */
-		if (features != dev->features) {
+		if (!virtio_features_equal(features, dev->features_array)) {
 			err = dev->config->finalize_features(dev);
 			if (err)
 				goto err;
@@ -701,6 +707,9 @@ EXPORT_SYMBOL_GPL(virtio_device_reset_done);
 
 static int virtio_init(void)
 {
+	BUILD_BUG_ON(offsetof(struct virtio_device, features) !=
+		     offsetof(struct virtio_device, features_array[0]));
+
 	if (bus_register(&virtio_bus) != 0)
 		panic("virtio bus registration failed");
 	virtio_debug_init();
diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
index 95c8fc7705bb..d58713ddf2e5 100644
--- a/drivers/virtio/virtio_debug.c
+++ b/drivers/virtio/virtio_debug.c
@@ -8,13 +8,13 @@ static struct dentry *virtio_debugfs_dir;
 
 static int virtio_debug_device_features_show(struct seq_file *s, void *data)
 {
+	u64 device_features[VIRTIO_FEATURES_DWORDS];
 	struct virtio_device *dev = s->private;
-	u64 device_features;
 	unsigned int i;
 
-	device_features = dev->config->get_features(dev);
-	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
-		if (device_features & (1ULL << i))
+	virtio_get_features(dev, device_features);
+	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
+		if (virtio_features_test_bit(device_features, i))
 			seq_printf(s, "%u\n", i);
 	}
 	return 0;
@@ -26,8 +26,8 @@ static int virtio_debug_filter_features_show(struct seq_file *s, void *data)
 	struct virtio_device *dev = s->private;
 	unsigned int i;
 
-	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
-		if (dev->debugfs_filter_features & (1ULL << i))
+	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
+		if (virtio_features_test_bit(dev->debugfs_filter_features, i))
 			seq_printf(s, "%u\n", i);
 	}
 	return 0;
@@ -39,7 +39,7 @@ static int virtio_debug_filter_features_clear(void *data, u64 val)
 	struct virtio_device *dev = data;
 
 	if (val == 1)
-		dev->debugfs_filter_features = 0;
+		virtio_features_zero(dev->debugfs_filter_features);
 	return 0;
 }
 
@@ -50,9 +50,10 @@ static int virtio_debug_filter_feature_add(void *data, u64 val)
 {
 	struct virtio_device *dev = data;
 
-	if (val >= BITS_PER_LONG_LONG)
+	if (val >= VIRTIO_FEATURES_MAX)
 		return -EINVAL;
-	dev->debugfs_filter_features |= BIT_ULL_MASK(val);
+
+	virtio_features_set_bit(dev->debugfs_filter_features, val);
 	return 0;
 }
 
@@ -63,9 +64,10 @@ static int virtio_debug_filter_feature_del(void *data, u64 val)
 {
 	struct virtio_device *dev = data;
 
-	if (val >= BITS_PER_LONG_LONG)
+	if (val >= VIRTIO_FEATURES_MAX)
 		return -EINVAL;
-	dev->debugfs_filter_features &= ~BIT_ULL_MASK(val);
+
+	virtio_features_clear_bit(dev->debugfs_filter_features, val);
 	return 0;
 }
 
@@ -91,7 +93,8 @@ EXPORT_SYMBOL_GPL(virtio_debug_device_init);
 
 void virtio_debug_device_filter_features(struct virtio_device *dev)
 {
-	dev->features &= ~dev->debugfs_filter_features;
+	virtio_features_andnot(dev->features_array, dev->features_array,
+			       dev->debugfs_filter_features);
 }
 EXPORT_SYMBOL_GPL(virtio_debug_device_filter_features);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 64cb4b04be7a..dcd3949572bd 100644
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
+	VIRTIO_DECLARE_FEATURES(features);
 	void *priv;
 #ifdef CONFIG_VIRTIO_DEBUG
 	struct dentry *debugfs_dir;
-	u64 debugfs_filter_features;
+	u64 debugfs_filter_features[VIRTIO_FEATURES_DWORDS];
 #endif
 };
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b3e1d30c765b..2b922dca16b1 100644
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
@@ -121,6 +124,8 @@ struct virtio_config_ops {
 	void (*del_vqs)(struct virtio_device *);
 	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
+	void (*get_extended_features)(struct virtio_device *vdev,
+				      u64 *features);
 	int (*finalize_features)(struct virtio_device *vdev);
 	const char *(*bus_name)(struct virtio_device *vdev);
 	int (*set_vq_affinity)(struct virtqueue *vq,
@@ -147,13 +152,7 @@ void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
 static inline bool __virtio_test_bit(const struct virtio_device *vdev,
 				     unsigned int fbit)
 {
-	/* Did you forget to fix assumptions on max features? */
-	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 64);
-	else
-		BUG_ON(fbit >= 64);
-
-	return vdev->features & BIT_ULL(fbit);
+	return virtio_features_test_bit(vdev->features_array, fbit);
 }
 
 /**
@@ -164,13 +163,7 @@ static inline bool __virtio_test_bit(const struct virtio_device *vdev,
 static inline void __virtio_set_bit(struct virtio_device *vdev,
 				    unsigned int fbit)
 {
-	/* Did you forget to fix assumptions on max features? */
-	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 64);
-	else
-		BUG_ON(fbit >= 64);
-
-	vdev->features |= BIT_ULL(fbit);
+	virtio_features_set_bit(vdev->features_array, fbit);
 }
 
 /**
@@ -181,13 +174,7 @@ static inline void __virtio_set_bit(struct virtio_device *vdev,
 static inline void __virtio_clear_bit(struct virtio_device *vdev,
 				      unsigned int fbit)
 {
-	/* Did you forget to fix assumptions on max features? */
-	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 64);
-	else
-		BUG_ON(fbit >= 64);
-
-	vdev->features &= ~BIT_ULL(fbit);
+	virtio_features_clear_bit(vdev->features_array, fbit);
 }
 
 /**
@@ -204,6 +191,16 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 	return __virtio_test_bit(vdev, fbit);
 }
 
+static inline void virtio_get_features(struct virtio_device *vdev, u64 *features)
+{
+	if (vdev->config->get_extended_features) {
+		vdev->config->get_extended_features(vdev, features);
+		return;
+	}
+
+	virtio_features_from_u64(features, vdev->config->get_features(vdev));
+}
+
 /**
  * virtio_has_dma_quirk - determine whether this device has the DMA quirk
  * @vdev: the device
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
new file mode 100644
index 000000000000..f748f2f87de8
--- /dev/null
+++ b/include/linux/virtio_features.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VIRTIO_FEATURES_H
+#define _LINUX_VIRTIO_FEATURES_H
+
+#include <linux/bits.h>
+
+#define VIRTIO_FEATURES_DWORDS	2
+#define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_DWORDS * 64)
+#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_DWORDS * 2)
+#define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
+#define VIRTIO_DWORD(b)		((b) >> 6)
+#define VIRTIO_DECLARE_FEATURES(name)			\
+	union {						\
+		u64 name;				\
+		u64 name##_array[VIRTIO_FEATURES_DWORDS];\
+	}
+
+static inline bool virtio_features_chk_bit(unsigned int bit)
+{
+	if (__builtin_constant_p(bit)) {
+		/*
+		 * Don't care returning the correct value: the build
+		 * will fail before any bad features access
+		 */
+		BUILD_BUG_ON(bit >= VIRTIO_FEATURES_MAX);
+	} else {
+		if (WARN_ON_ONCE(bit >= VIRTIO_FEATURES_MAX))
+			return false;
+	}
+	return true;
+}
+
+static inline bool virtio_features_test_bit(const u64 *features,
+					    unsigned int bit)
+{
+	return virtio_features_chk_bit(bit) &&
+	       !!(features[VIRTIO_DWORD(bit)] & VIRTIO_BIT(bit));
+}
+
+static inline void virtio_features_set_bit(u64 *features,
+					   unsigned int bit)
+{
+	if (virtio_features_chk_bit(bit))
+		features[VIRTIO_DWORD(bit)] |= VIRTIO_BIT(bit);
+}
+
+static inline void virtio_features_clear_bit(u64 *features,
+					     unsigned int bit)
+{
+	if (virtio_features_chk_bit(bit))
+		features[VIRTIO_DWORD(bit)] &= ~VIRTIO_BIT(bit);
+}
+
+static inline void virtio_features_zero(u64 *features)
+{
+	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
+}
+
+static inline void virtio_features_from_u64(u64 *features, u64 from)
+{
+	virtio_features_zero(features);
+	features[0] = from;
+}
+
+static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
+{
+	int i;
+
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+		if (f1[i] != f2[i])
+			return false;
+	return true;
+}
+
+static inline void virtio_features_copy(u64 *to, const u64 *from)
+{
+	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
+}
+
+static inline void virtio_features_andnot(u64 *to, const u64 *f1, const u64 *f2)
+{
+	int i;
+
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+		to[i] = f1[i] & ~f2[i];
+}
+
+#endif
-- 
2.49.0


