Return-Path: <netdev+bounces-192245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B74ABF1B6
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B74A1A10
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E1D25FA0F;
	Wed, 21 May 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MArSIGUC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9725FA00
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823631; cv=none; b=RiuLMb0Aog+m+cplNRw4/3k1ij734Vo+YKAnxKQgWKXrX1rjW2r+scbtElnIRk29NYwCQSdVuufpPFYpy7DbwBcUHPm/Rcbvm8tC5C/deuNj0lq7WKD+eG3WFMcMFNqn5fM0MskIKLrOrTMaluLcSrE3AyIV0z+cO+I+DA58rG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823631; c=relaxed/simple;
	bh=3gyPQRmoEolwgs5nkVHNX6TG0HBtSfS+Ml2OLruOAm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLQXigXbgv6A6QKguGiiv4u2ezvI4k0peT7FmZqis752Rxjs2WKqX3mW8RKIvohLVHPzfBM5bxTff5OtmkTulCBBN6LKKzpaWuZDJymj79OusY9nlzFuHRNc2scmPgSU5rSZc57zLZ2zAjIMGes/SP23vYcQVPY/W69B6SnI8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MArSIGUC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747823629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRZER4nyY3HMxHfHIbrU+M2xmoFLqMsWnvqvxySbQxA=;
	b=MArSIGUCGc6jilIDXKwI9V61jd211gshuIudXjSe99TZNfvkoyi7m6kz23vjHBDVvuRvxe
	eAN8BoNM3SC6Wn5AJ+hlCxR7ESkbuTNiuOB/p4VjuEZ7bf40ZE73JB8IZqOG9WJUOTSiKn
	iRciV4YTRgyG1JUdKqRh3Ig3e8o2Caw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-OeElSHTlM0ajVDUqYxDpbw-1; Wed,
 21 May 2025 06:33:46 -0400
X-MC-Unique: OeElSHTlM0ajVDUqYxDpbw-1
X-Mimecast-MFC-AGG-ID: OeElSHTlM0ajVDUqYxDpbw_1747823624
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADCC5180036E;
	Wed, 21 May 2025 10:33:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AAD8195608F;
	Wed, 21 May 2025 10:33:41 +0000 (UTC)
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
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net-next 2/8] virtio_pci_modern: allow setting configuring extended features
Date: Wed, 21 May 2025 12:32:36 +0200
Message-ID: <f85bc2d08dfd1a686b1cd102977f615aa07b3190.1747822866.git.pabeni@redhat.com>
In-Reply-To: <cover.1747822866.git.pabeni@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features (above 64) for the virtio_net driver.

Extend the virtio pci modern driver to support configuring the full
virtio features range, replacing the unrolled loops reading and
writing the features space with explicit one bounded to the actual
features space size in word.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++---------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 1d34655f6b658..e3025b6fa8540 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
 virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-	virtio_features_t features;
+	virtio_features_t features = 0;
+	int i;
 
-	vp_iowrite32(0, &cfg->device_feature_select);
-	features = vp_ioread32(&cfg->device_feature);
-	vp_iowrite32(1, &cfg->device_feature_select);
-	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
+	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+		virtio_features_t cur;
+
+		vp_iowrite32(i, &cfg->device_feature_select);
+		cur = vp_ioread32(&cfg->device_feature);
+		features |= cur << (32 * i);
+	}
 
 	return features;
 }
@@ -417,12 +421,16 @@ virtio_features_t
 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-	virtio_features_t features;
+	virtio_features_t features = 0;
+	int i;
+
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
@@ -437,11 +445,14 @@ void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
 			    virtio_features_t features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	int i;
+
+	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+		u32 cur = features >> (32 * i);
 
-	vp_iowrite32(0, &cfg->guest_feature_select);
-	vp_iowrite32((u32)features, &cfg->guest_feature);
-	vp_iowrite32(1, &cfg->guest_feature_select);
-	vp_iowrite32(features >> 32, &cfg->guest_feature);
+		vp_iowrite32(i, &cfg->guest_feature_select);
+		vp_iowrite32(cur, &cfg->guest_feature);
+	}
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_features);
 
-- 
2.49.0


