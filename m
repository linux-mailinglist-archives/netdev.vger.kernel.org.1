Return-Path: <netdev+bounces-195419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CFBAD0160
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831F71894039
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447B22874E1;
	Fri,  6 Jun 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bp5xa6WJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9061E47B3
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210399; cv=none; b=gRvij1lNzwAbLg/R96zzUBZZD/LoWC8j3ciSeKSRKXx2Y9jxsN1Gk2NQXmo4I9R7SDkqYw3iFs+acWcihGZchwyNV3zYS4yNBOw2qXY+SBfPni+VMN1LNOBDKqk9nTEqMGtqETjrHICLHFPJx80f4ZnVGCOyAHepkEpaCSsgjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210399; c=relaxed/simple;
	bh=gVEHa+E30YWGYP6jlpCuDoOGP6uH4GCxrVCf8/7C6u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn4fr8gI/tEJHx+Xf/y8+187XpHAzhG0IJPvWkCacqlJRsbuqasRWilqXI6dUttHVnuAZtHYFo74k/ofPbeX44+fktZP8efyVyXB1j96Bi+3DR9bUnfOUOYx47eSeWRlUso6RVhvOWLxlIoqTuF1Lvsoegl/1SPJHbrKWwyHpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bp5xa6WJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvlI2wFC/fczTeAQwB95cXS0alql6ReeuwvoXcIc6KM=;
	b=Bp5xa6WJUXQtL6SpDjmhqknmilfvqstzEsg1H+6L+odCjy+kSxaizBuE4tRMcBHE+jYr9V
	7EBrEeE0K+6E8Sdzzjsg1q81zIGx06RAgj3ndEdxsmYmE9IgRctXX2vE/5aXn7BIAwXXn5
	crG9Fomkyl21xPtNmHxxLzHbqEMR8vg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-wCPdMdeKOD6hXu47sDSRtA-1; Fri,
 06 Jun 2025 07:46:32 -0400
X-MC-Unique: wCPdMdeKOD6hXu47sDSRtA-1
X-Mimecast-MFC-AGG-ID: wCPdMdeKOD6hXu47sDSRtA_1749210389
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A73C11955EE2;
	Fri,  6 Jun 2025 11:46:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.1])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D954218003FD;
	Fri,  6 Jun 2025 11:46:24 +0000 (UTC)
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
Subject: [PATCH RFC v3 2/8] virtio_pci_modern: allow configuring extended features
Date: Fri,  6 Jun 2025 13:45:39 +0200
Message-ID: <19ee74a1a46e9eb302fc742fb7c9913bcc6b7d86.1749210083.git.pabeni@redhat.com>
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

Extend the virtio pci modern driver to support configuring the full
virtio features range, replacing the unrolled loops reading and
writing the features space with explicit one bounded to the actual
features space size in word and implementing the get_extended_features
callback.

Note that in vp_finalize_features() we only need to cache the lower
64 features bits, to process the transport features.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - virtio_features_t -> u64 *

v1 -> v2:
  - use get_extended_features
---
 drivers/virtio/virtio_pci_modern.c     | 10 ++--
 drivers/virtio/virtio_pci_modern_dev.c | 69 +++++++++++++++-----------
 include/linux/virtio_pci_modern.h      | 46 +++++++++++++++--
 3 files changed, 87 insertions(+), 38 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index d50fe030d825..255203441201 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -22,11 +22,11 @@
 
 #define VIRTIO_AVQ_SGS_MAX	4
 
-static u64 vp_get_features(struct virtio_device *vdev)
+static void vp_get_features(struct virtio_device *vdev, u64 *features)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	return vp_modern_get_features(&vp_dev->mdev);
+	vp_modern_get_extended_features(&vp_dev->mdev, features);
 }
 
 static int vp_avq_index(struct virtio_device *vdev, u16 *index, u16 *num)
@@ -426,7 +426,7 @@ static int vp_finalize_features(struct virtio_device *vdev)
 	if (vp_check_common_size(vdev))
 		return -EINVAL;
 
-	vp_modern_set_features(&vp_dev->mdev, vdev->features);
+	vp_modern_set_extended_features(&vp_dev->mdev, vdev->features_array);
 
 	return 0;
 }
@@ -1223,7 +1223,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
-	.get_features	= vp_get_features,
+	.get_extended_features = vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
@@ -1243,7 +1243,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
-	.get_features	= vp_get_features,
+	.get_extended_features = vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 0d3dbfaf4b23..d665f8f73ea8 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -388,63 +388,74 @@ void vp_modern_remove(struct virtio_pci_modern_device *mdev)
 EXPORT_SYMBOL_GPL(vp_modern_remove);
 
 /*
- * vp_modern_get_features - get features from device
+ * vp_modern_get_extended_features - get features from device
  * @mdev: the modern virtio-pci device
+ * @features: the features array to be filled
  *
- * Returns the features read from the device
+ * Fill the specified features array with the features read from the device
  */
-u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
+void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
+				     u64 *features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	int i;
 
-	u64 features;
+	virtio_features_zero(features);
+	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+		u64 cur;
 
-	vp_iowrite32(0, &cfg->device_feature_select);
-	features = vp_ioread32(&cfg->device_feature);
-	vp_iowrite32(1, &cfg->device_feature_select);
-	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
-
-	return features;
+		vp_iowrite32(i, &cfg->device_feature_select);
+		cur = vp_ioread32(&cfg->device_feature);
+		features[i >> 1] |= cur << (32 * (i & 1));
+	}
 }
-EXPORT_SYMBOL_GPL(vp_modern_get_features);
+EXPORT_SYMBOL_GPL(vp_modern_get_extended_features);
 
 /*
  * vp_modern_get_driver_features - get driver features from device
  * @mdev: the modern virtio-pci device
+ * @features: the features array to be filled
  *
- * Returns the driver features read from the device
+ * Fill the specified features array with the driver features read from the
+ * device
  */
-u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
+void
+vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
+				       u64 *features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	int i;
 
-	u64 features;
-
-	vp_iowrite32(0, &cfg->guest_feature_select);
-	features = vp_ioread32(&cfg->guest_feature);
-	vp_iowrite32(1, &cfg->guest_feature_select);
-	features |= ((u64)vp_ioread32(&cfg->guest_feature) << 32);
+	virtio_features_zero(features);
+	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+		u64 cur;
 
-	return features;
+		vp_iowrite32(i, &cfg->guest_feature_select);
+		cur = vp_ioread32(&cfg->guest_feature);
+		features[i >> 1] |= cur << (32 * (i & 1));
+	}
 }
-EXPORT_SYMBOL_GPL(vp_modern_get_driver_features);
+EXPORT_SYMBOL_GPL(vp_modern_get_driver_extended_features);
 
 /*
- * vp_modern_set_features - set features to device
+ * vp_modern_set_extended_features - set features to device
  * @mdev: the modern virtio-pci device
  * @features: the features set to device
  */
-void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
-			    u64 features)
+void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
+				     const u64 *features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	int i;
+
+	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+		u32 cur = features[i >> 1] >> (32 * (i & 1));
 
-	vp_iowrite32(0, &cfg->guest_feature_select);
-	vp_iowrite32((u32)features, &cfg->guest_feature);
-	vp_iowrite32(1, &cfg->guest_feature_select);
-	vp_iowrite32(features >> 32, &cfg->guest_feature);
+		vp_iowrite32(i, &cfg->guest_feature_select);
+		vp_iowrite32(cur, &cfg->guest_feature);
+	}
 }
-EXPORT_SYMBOL_GPL(vp_modern_set_features);
+EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
 
 /*
  * vp_modern_generation - get the device genreation
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index c0b1b1ca1163..0764802a50ea 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -3,6 +3,7 @@
 #define _LINUX_VIRTIO_PCI_MODERN_H
 
 #include <linux/pci.h>
+#include <linux/virtio_config.h>
 #include <linux/virtio_pci.h>
 
 /**
@@ -95,10 +96,47 @@ static inline void vp_iowrite64_twopart(u64 val,
 	vp_iowrite32(val >> 32, hi);
 }
 
-u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev);
-u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev);
-void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
-		     u64 features);
+void
+vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
+				       u64 *features);
+void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
+				     u64 *features);
+void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
+				     const u64 *features);
+
+static inline u64
+vp_modern_get_features(struct virtio_pci_modern_device *mdev)
+{
+	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	int i;
+
+	vp_modern_get_extended_features(mdev, features_array);
+	for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i)
+		WARN_ON_ONCE(features_array[i]);
+	return features_array[0];
+}
+
+static inline u64
+vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
+{
+	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	int i;
+
+	vp_modern_get_driver_extended_features(mdev, features_array);
+	for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i)
+		WARN_ON_ONCE(features_array[i]);
+	return features_array[0];
+}
+
+static inline void
+vp_modern_set_features(struct virtio_pci_modern_device *mdev, u64 features)
+{
+	u64 features_array[VIRTIO_FEATURES_DWORDS];
+
+	virtio_features_from_u64(features_array, features);
+	vp_modern_set_extended_features(mdev, features_array);
+}
+
 u32 vp_modern_generation(struct virtio_pci_modern_device *mdev);
 u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev);
 void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
-- 
2.49.0


