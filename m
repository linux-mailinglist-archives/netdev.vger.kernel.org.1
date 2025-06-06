Return-Path: <netdev+bounces-195418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357BEAD015F
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B471894251
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754922882CD;
	Fri,  6 Jun 2025 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="febK8f1D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB81E47B3
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210392; cv=none; b=hFqffyfdFzxGfpMjthyYJ2BJWCZAIQec1odgqebN2yOLtilCTszgCsQQnaW6OVaQe4XhBTe+YaXyULeu74f+SGXMqyYuqCVR8Z9IO2j9y6Ygba2NDcME/SafLkPnyPObSTAiizNehIUh04mnh/uqGyR1MDkfyjt7OybWpp23GGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210392; c=relaxed/simple;
	bh=MoQ5yai8ZdfOMeuMrEv4l13qtLircMVbpctKVSm1npc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlX4vV5BhbVKCWBkr8TJSOrFmZvX4H+ALcaeYyy1tTXIBr+M8t5FgKavKfgawkRG1kSSxZt7H5gi6/VCui7okxUc5wzSZ+BSXr9pYI+9keuzC0MVvJXrjNBiqsLnlbRdrLjfvphkh1yQ5mlDjHX5TebH98qBb8R5qjSRPzLsboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=febK8f1D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfRn/fv0dHsBaQfwKEUU9y8FvLJYv9qG+2xl0jMP0Jk=;
	b=febK8f1DqAbniyGzteqsYTvd7bX+5nQXNiETldEc6/phwQtlufPct0+traKgjSOE3p53vb
	irOP4iJxXIqxf/YpjUh4Xs7K3bzd4VhUYyJ3PLfL91i09sw4hz8FM57x9ae4bfVN1D8XH+
	LHndi0PSKXMtP2amE/o39XFsH5YrD6Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-HAK5HESkMHGi4cx3XAvo7A-1; Fri,
 06 Jun 2025 07:46:26 -0400
X-MC-Unique: HAK5HESkMHGi4cx3XAvo7A-1
X-Mimecast-MFC-AGG-ID: HAK5HESkMHGi4cx3XAvo7A_1749210384
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60CEA19560B2;
	Fri,  6 Jun 2025 11:46:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.1])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42FE818002B6;
	Fri,  6 Jun 2025 11:46:20 +0000 (UTC)
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
Subject: [PATCH RFC v3 1/8] virtio: introduce extended features
Date: Fri,  6 Jun 2025 13:45:38 +0200
Message-ID: <47a89c6b568c3ab266ab351711f916d4a683ebdf.1749210083.git.pabeni@redhat.com>
In-Reply-To: <cover.1749210083.git.pabeni@redhat.com>
References: <cover.1749210083.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features (above 64) for the virtio_net driver.

Introduce extended features as a fixed size array of u64. To minimize
the diffstat allows legacy driver to access the low 64 bits via a
transparent union.

Introduce an extended get_extended_features128 configuration callback
that devices supporting the extended features range must implement in
place of the traditional one.

Note that legacy and transport features don't need any change, as
they are always in the low 64 bit range.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - uint128_t -> u64[2];
v1 -> v2:
  - let u64 VIRTIO_BIT() cope with higher bit values
  - add .get_features128 instead of changing .get_features signature
---
 drivers/virtio/virtio.c         | 39 +++++++++++-------
 drivers/virtio/virtio_debug.c   | 27 +++++++------
 include/linux/virtio.h          |  5 ++-
 include/linux/virtio_config.h   | 35 ++++++++++++-----
 include/linux/virtio_features.h | 70 +++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/virtio_features.h

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 95d5d7993e5b..ed1ccedc47b3 100644
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
+		BUG_ON(f >= VIRTIO_FEATURES_MAX);
+		virtio_features_set_bit(driver_features, f);
 	}
 
 	/* Some drivers have a separate feature table for virtio v1.0 */
@@ -299,20 +299,25 @@ static int virtio_dev_probe(struct device *_d)
 			driver_features_legacy |= (1ULL << f);
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
index 95c8fc7705bb..6d066b5e8ec0 100644
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
+	virtio_features_and_not(dev->features_array, dev->features_array,
+				dev->debugfs_filter_features);
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
index 169c7d367fac..83cf25b3028d 100644
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
@@ -149,11 +154,11 @@ static inline bool __virtio_test_bit(const struct virtio_device *vdev,
 {
 	/* Did you forget to fix assumptions on max features? */
 	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 64);
+		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 	else
-		BUG_ON(fbit >= 64);
+		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 
-	return vdev->features & BIT_ULL(fbit);
+	return virtio_features_test_bit(vdev->features_array, fbit);
 }
 
 /**
@@ -166,11 +171,11 @@ static inline void __virtio_set_bit(struct virtio_device *vdev,
 {
 	/* Did you forget to fix assumptions on max features? */
 	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 64);
+		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 	else
-		BUG_ON(fbit >= 64);
+		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 
-	vdev->features |= BIT_ULL(fbit);
+	virtio_features_set_bit(vdev->features_array, fbit);
 }
 
 /**
@@ -183,11 +188,11 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
 {
 	/* Did you forget to fix assumptions on max features? */
 	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 64);
+		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 	else
-		BUG_ON(fbit >= 64);
+		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
 
-	vdev->features &= ~BIT_ULL(fbit);
+	virtio_features_clear_bit(vdev->features_array, fbit);
 }
 
 /**
@@ -204,6 +209,16 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
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
index 000000000000..42c3c7cee500
--- /dev/null
+++ b/include/linux/virtio_features.h
@@ -0,0 +1,70 @@
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
+static inline bool virtio_features_test_bit(const u64 *features,
+					    unsigned int bit)
+{
+	return !!(features[VIRTIO_DWORD(bit)] & VIRTIO_BIT(bit));
+}
+
+static inline void virtio_features_set_bit(u64 *features,
+					   unsigned int bit)
+{
+	features[VIRTIO_DWORD(bit)] |= VIRTIO_BIT(bit);
+}
+
+static inline void virtio_features_clear_bit(u64 *features,
+					     unsigned int bit)
+{
+	features[VIRTIO_DWORD(bit)] &= ~VIRTIO_BIT(bit);
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
+	u64 diff = 0;
+	int i;
+
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+		diff |= f1[i] ^ f2[i];
+	return !!diff;
+}
+
+static inline void virtio_features_copy(u64 *to, const u64 *from)
+{
+	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
+}
+
+static inline void virtio_features_and_not(u64 *to, const u64 *f1, const u64 *f2)
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


