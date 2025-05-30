Return-Path: <netdev+bounces-194375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF0AC91D4
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4155D1BC2B8C
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94322D9F0;
	Fri, 30 May 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJ7QqqB7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F7219A70
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616605; cv=none; b=uxIzFtRQITZF28v9WYSGhZlTQeuOoFC4fHhib4TZAEdw0zdV0hpOosd8Xm66RF1MJSw9T8R+bTWO0tHBBzNvaVSEHiUuvyP3mdCjAKYcdJm/ImgucS2oJ+9T9hZMQu4DvPw2/SKyT/PXPOUSXZTb2w/g7ITYSmcoFRI5YjrhhhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616605; c=relaxed/simple;
	bh=YZvlXq82qrXdSfX5lLndRAewCbs1RRqbfI/xz7C0Klc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2DKp9u4HnVJJ/jWbUy5ZMj7iFWsa1XdiyC342BYyTmPeQ2OKJMPeeLUXXHuZEnd+4AnYXzBGv7SWqCJO6//sdbHQGoTg1FNM9CniOZNCJYQ8j4IWnfIO/sP1HSsx3fxMrrIJxqNLFKZW3WIDRmf0ylfstRDYFaTzn+mP/x9O/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJ7QqqB7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748616601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNulYVbniwgT/+6siysH9K8KbpqGQo1VwgRI2+Sxego=;
	b=BJ7QqqB7vL4MZSp9L4nWRvpjx1Ll33VmTErokKOqCAWUU8I6liDfHhcjPk5CDajqJotyRd
	FFemJMt2XM/57vr8vWA2sfEzl4m+/a4tNbNOwqTds4rxwLjaKBfffMPgIAaT25QHEG2NGp
	45CKyp75kN9bGyt85ja7OVp43pJcV58=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-3hSGZyKmNvSkTBelXX8xlw-1; Fri,
 30 May 2025 10:49:58 -0400
X-MC-Unique: 3hSGZyKmNvSkTBelXX8xlw-1
X-Mimecast-MFC-AGG-ID: 3hSGZyKmNvSkTBelXX8xlw_1748616596
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 622FB18004AD;
	Fri, 30 May 2025 14:49:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.184])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0972919560B7;
	Fri, 30 May 2025 14:49:51 +0000 (UTC)
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
Subject: [RFC PATCH v2 2/8] virtio_pci_modern: allow configuring extended features
Date: Fri, 30 May 2025 16:49:18 +0200
Message-ID: <7c77e81a106142bca5e0621f2a7d592d33f0df5e.1748614223.git.pabeni@redhat.com>
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

Extend the virtio pci modern driver to support configuring the full
virtio features range, replacing the unrolled loops reading and
writing the features space with explicit one bounded to the actual
features space size in word and implementing the get_extended_features
callback.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - use get_extended_features
---
 drivers/virtio/virtio_pci_modern.c     |  6 ++--
 drivers/virtio/virtio_pci_modern_dev.c | 44 ++++++++++++++++----------
 include/linux/virtio_pci_modern.h      | 10 ++++--
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index d50fe030d825..7a66844e84f8 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -22,7 +22,7 @@
 
 #define VIRTIO_AVQ_SGS_MAX	4
 
-static u64 vp_get_features(struct virtio_device *vdev)
+static virtio_features_t vp_get_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
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
index 0d3dbfaf4b23..e3025b6fa854 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -393,16 +393,19 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
  *
  * Returns the features read from the device
  */
-u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
+virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	virtio_features_t features = 0;
+	int i;
 
-	u64 features;
+	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+		virtio_features_t cur;
 
-	vp_iowrite32(0, &cfg->device_feature_select);
-	features = vp_ioread32(&cfg->device_feature);
-	vp_iowrite32(1, &cfg->device_feature_select);
-	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
+		vp_iowrite32(i, &cfg->device_feature_select);
+		cur = vp_ioread32(&cfg->device_feature);
+		features |= cur << (32 * i);
+	}
 
 	return features;
 }
@@ -414,16 +417,20 @@ EXPORT_SYMBOL_GPL(vp_modern_get_features);
  *
  * Returns the driver features read from the device
  */
-u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
+virtio_features_t
+vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	virtio_features_t features = 0;
+	int i;
 
-	u64 features;
+	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+		virtio_features_t cur;
 
-	vp_iowrite32(0, &cfg->guest_feature_select);
-	features = vp_ioread32(&cfg->guest_feature);
-	vp_iowrite32(1, &cfg->guest_feature_select);
-	features |= ((u64)vp_ioread32(&cfg->guest_feature) << 32);
+		vp_iowrite32(i, &cfg->guest_feature_select);
+		cur = vp_ioread32(&cfg->guest_feature);
+		features |= cur << (32 * i);
+	}
 
 	return features;
 }
@@ -435,14 +442,17 @@ EXPORT_SYMBOL_GPL(vp_modern_get_driver_features);
  * @features: the features set to device
  */
 void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
-			    u64 features)
+			    virtio_features_t features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	int i;
 
-	vp_iowrite32(0, &cfg->guest_feature_select);
-	vp_iowrite32((u32)features, &cfg->guest_feature);
-	vp_iowrite32(1, &cfg->guest_feature_select);
-	vp_iowrite32(features >> 32, &cfg->guest_feature);
+	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+		u32 cur = features >> (32 * i);
+
+		vp_iowrite32(i, &cfg->guest_feature_select);
+		vp_iowrite32(cur, &cfg->guest_feature);
+	}
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_features);
 
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index c0b1b1ca1163..77e4ca3a6e2f 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -3,6 +3,7 @@
 #define _LINUX_VIRTIO_PCI_MODERN_H
 
 #include <linux/pci.h>
+#include <linux/virtio_config.h>
 #include <linux/virtio_pci.h>
 
 /**
@@ -95,10 +96,13 @@ static inline void vp_iowrite64_twopart(u64 val,
 	vp_iowrite32(val >> 32, hi);
 }
 
-u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev);
-u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev);
+virtio_features_t
+vp_modern_get_features(struct virtio_pci_modern_device *mdev);
+
+virtio_features_t
+vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev);
 void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
-		     u64 features);
+		     virtio_features_t features);
 u32 vp_modern_generation(struct virtio_pci_modern_device *mdev);
 u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev);
 void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
-- 
2.49.0


