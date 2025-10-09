Return-Path: <netdev+bounces-228358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FEEBC8C65
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 13:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B83CC4EC164
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E893C2DFA3A;
	Thu,  9 Oct 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlisNdhQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4DE2DCC04
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009057; cv=none; b=PMDy+qBSsUq2wW8rPE4VC/JzTdtwbSONPBWWRuUojxR6Ii2Ci/rPedXI3/Zg81Awy/z9ltPJ9vEkh5HAQJp2gFhep4KKu3nxOLDEOTSmrlrT7raLxDPk3JnSxFcwAO1ftyV+VxS6JuNIpZc5YJb8nSV4RvNBEejdoxK8aAIJJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009057; c=relaxed/simple;
	bh=Eq8QXdg73gutxXm7AKa3FAAyfzoJFtKs/7zU83MmOtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QILkXcM+bjnVb/61m4GRo5GL7HHAzBRulyczLQAJUVoS+NRfkNSTWKFqedjZCHITvmqbq9o8P8is8tj1a+SzxwisQidYmI+pwpLO9spSFt+9mH8cbw2k5Q9tDX03v/dHa+DtEIjt1PHVgRNWXjyjYDhEOCJgoIYmzMcy134Qpj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlisNdhQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760009054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74oMbyRbXmj4yyNwDNl68MN1PmvAi+6GhTMV//8rC/U=;
	b=BlisNdhQQmt/NHMXm6tYZa3Ma1g8/GJFyN3xj1KA1hopRhJ7lNUJBRP+UgmCNWNFif+vVb
	/zSGCC8iIUwWsDBSflsUmmCgkq4gDYUJZPg8+yHHiiWeakJKJPdwr1MpQpw5+xce7hu2h4
	BME0xJb+7ykso2kW6JhhtSJn6KFXXHQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-oXq6skHyM0msrncQOBe57A-1; Thu, 09 Oct 2025 07:24:13 -0400
X-MC-Unique: oXq6skHyM0msrncQOBe57A-1
X-Mimecast-MFC-AGG-ID: oXq6skHyM0msrncQOBe57A_1760009053
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87a0e9be970so31908216d6.3
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 04:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760009053; x=1760613853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74oMbyRbXmj4yyNwDNl68MN1PmvAi+6GhTMV//8rC/U=;
        b=ZMvR3yWYjPHP8jxP1dl2j5WehAbvdGQSPNov5xH/O569aowj+0xy5pmeZVnzK1tupS
         DVWLp0gKVQhcbi1+JjJi8BWCjRFct8jLjx9tJBZ+kbUlY4UJfCRmpBAuufyZSnQDLX6j
         2lS8EiAtbaUXu9U9mz/2hY9gBFs9YIS7BvJsgtdbbm4COtoqzwJvfz852RVD48uwQZ/V
         O6PQ0F9h+DzgxyHepei/07q2MNsJQBrtftmeDSm9sJfVqRRM4xeNDRqH86ddiczELe3R
         QRK+NaILvIlH1fUKAt8Q91I9oz/695EXOXC/dEIq33UfQaN8/sMP3IGCpKOwhUspMXuw
         fP0w==
X-Gm-Message-State: AOJu0Yx96I77J/puewbBg6YKSQ+eIREQliV1GZKeT6aU4SOgpcFFWRsJ
	PweHf/6prXEGaRl0Bjlz4TjOFMoc/nI+q3V9+vRfHrJvBMp3ZWER7gcxlgGB8u6rQDpuJZQrgND
	ABVAk0VHYtuN1pZmtz2aJ99RSvUDGSPm/ex+NGkXlgLcCKC+YDJWCd0Z9iw==
X-Gm-Gg: ASbGnctVcfwC9iqIhSGGcrizX7S0LZ/csfEOnNc47szbOoPyPMLukDMhdQv4rUHnkUP
	Y3HmCeuLnwhGIC1anHxAC6ZuPHC1upOTlldTAFHQPghuGkQrgsjIIlWO8amqExCvsy/oRCCzZZG
	McwXh97s/CRUaFXpQxMXn5hEBrtRVn8YSnKkOIj+ZYZ68tlzPVfcfsV6SbydQyEMYp5UNqPlcOb
	ubjOFrY73E3SM7VkYYJX1OVqYxjLCwNF5fvCB5WHtkXSUp0ob5BpDXCNuXW1o2JhS/Azi3LqETc
	xi4Oev/75dyQsGJG2wOtnyH7uz0G4QafzCA=
X-Received: by 2002:ad4:5d61:0:b0:78e:c5c7:1209 with SMTP id 6a1803df08f44-87b2ef56229mr83375456d6.56.1760009052904;
        Thu, 09 Oct 2025 04:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhwynXOsSUCuzIIOIZVdF8Z7wPRpFcney3vzw+6KLV7AofNaekm0l75bt/gqMykMI5XPPJow==
X-Received: by 2002:ad4:5d61:0:b0:78e:c5c7:1209 with SMTP id 6a1803df08f44-87b2ef56229mr83375156d6.56.1760009052420;
        Thu, 09 Oct 2025 04:24:12 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm180829526d6.9.2025.10.09.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:24:12 -0700 (PDT)
Date: Thu, 9 Oct 2025 07:24:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org
Subject: [PATCH 1/3] virtio: dwords->qwords
Message-ID: <350d0abfaa2dcdb44678098f9119ba41166f375f.1760008798.git.mst@redhat.com>
References: <cover.1760008797.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760008797.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

A "word" is 16 bit. 64 bit integers like virtio uses are not dwords,
they are actually qwords. Fix up macro names accordingly.

Fixes: e7d4c1c5a546 ("virtio: introduce extended features")
Cc: "Paolo Abeni" <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c               | 10 +++++-----
 drivers/virtio/virtio.c           |  8 ++++----
 drivers/virtio/virtio_debug.c     |  2 +-
 include/linux/virtio.h            |  2 +-
 include/linux/virtio_features.h   | 24 ++++++++++++------------
 include/linux/virtio_pci_modern.h |  8 ++++----
 scripts/lib/kdoc/kdoc_parser.py   |  2 +-
 7 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 35ded4330431..43d51fb1f8ea 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -69,7 +69,7 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 
 #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >= (__force u32)VHOST_DMA_DONE_LEN)
 
-static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
+static const u64 vhost_net_features[VIRTIO_FEATURES_QWORDS] = {
 	VHOST_FEATURES |
 	(1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 	(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
@@ -1720,7 +1720,7 @@ static long vhost_net_set_owner(struct vhost_net *n)
 static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			    unsigned long arg)
 {
-	u64 all_features[VIRTIO_FEATURES_DWORDS];
+	u64 all_features[VIRTIO_FEATURES_QWORDS];
 	struct vhost_net *n = f->private_data;
 	void __user *argp = (void __user *)arg;
 	u64 __user *featurep = argp;
@@ -1752,7 +1752,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 
 		/* Copy the net features, up to the user-provided buffer size */
 		argp += sizeof(u64);
-		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		copied = min(count, VIRTIO_FEATURES_QWORDS);
 		if (copy_to_user(argp, vhost_net_features,
 				 copied * sizeof(u64)))
 			return -EFAULT;
@@ -1767,7 +1767,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 
 		virtio_features_zero(all_features);
 		argp += sizeof(u64);
-		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		copied = min(count, VIRTIO_FEATURES_QWORDS);
 		if (copy_from_user(all_features, argp, copied * sizeof(u64)))
 			return -EFAULT;
 
@@ -1783,7 +1783,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 				return -EOPNOTSUPP;
 		}
 
-		for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+		for (i = 0; i < VIRTIO_FEATURES_QWORDS; i++)
 			if (all_features[i] & ~vhost_net_features[i])
 				return -EOPNOTSUPP;
 
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a09eb4d62f82..08f8357cdd39 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -272,8 +272,8 @@ static int virtio_dev_probe(struct device *_d)
 	int err, i;
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
-	u64 device_features[VIRTIO_FEATURES_DWORDS];
-	u64 driver_features[VIRTIO_FEATURES_DWORDS];
+	u64 device_features[VIRTIO_FEATURES_QWORDS];
+	u64 driver_features[VIRTIO_FEATURES_QWORDS];
 	u64 driver_features_legacy;
 
 	/* We have a driver! */
@@ -303,7 +303,7 @@ static int virtio_dev_probe(struct device *_d)
 	}
 
 	if (virtio_features_test_bit(device_features, VIRTIO_F_VERSION_1)) {
-		for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+		for (i = 0; i < VIRTIO_FEATURES_QWORDS; ++i)
 			dev->features_array[i] = driver_features[i] &
 						 device_features[i];
 	} else {
@@ -325,7 +325,7 @@ static int virtio_dev_probe(struct device *_d)
 		goto err;
 
 	if (drv->validate) {
-		u64 features[VIRTIO_FEATURES_DWORDS];
+		u64 features[VIRTIO_FEATURES_QWORDS];
 
 		virtio_features_copy(features, dev->features_array);
 		err = drv->validate(dev);
diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
index d58713ddf2e5..40f6b815caef 100644
--- a/drivers/virtio/virtio_debug.c
+++ b/drivers/virtio/virtio_debug.c
@@ -8,7 +8,7 @@ static struct dentry *virtio_debugfs_dir;
 
 static int virtio_debug_device_features_show(struct seq_file *s, void *data)
 {
-	u64 device_features[VIRTIO_FEATURES_DWORDS];
+	u64 device_features[VIRTIO_FEATURES_QWORDS];
 	struct virtio_device *dev = s->private;
 	unsigned int i;
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96c66126c074..5b258451dc0e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -177,7 +177,7 @@ struct virtio_device {
 	union virtio_map vmap;
 #ifdef CONFIG_VIRTIO_DEBUG
 	struct dentry *debugfs_dir;
-	u64 debugfs_filter_features[VIRTIO_FEATURES_DWORDS];
+	u64 debugfs_filter_features[VIRTIO_FEATURES_QWORDS];
 #endif
 };
 
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index f748f2f87de8..bf41d8ec50ef 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -4,15 +4,15 @@
 
 #include <linux/bits.h>
 
-#define VIRTIO_FEATURES_DWORDS	2
-#define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_DWORDS * 64)
-#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_DWORDS * 2)
+#define VIRTIO_FEATURES_QWORDS	2
+#define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_QWORDS * 64)
+#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_QWORDS * 2)
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
-#define VIRTIO_DWORD(b)		((b) >> 6)
+#define VIRTIO_QWORD(b)		((b) >> 6)
 #define VIRTIO_DECLARE_FEATURES(name)			\
 	union {						\
 		u64 name;				\
-		u64 name##_array[VIRTIO_FEATURES_DWORDS];\
+		u64 name##_array[VIRTIO_FEATURES_QWORDS];\
 	}
 
 static inline bool virtio_features_chk_bit(unsigned int bit)
@@ -34,26 +34,26 @@ static inline bool virtio_features_test_bit(const u64 *features,
 					    unsigned int bit)
 {
 	return virtio_features_chk_bit(bit) &&
-	       !!(features[VIRTIO_DWORD(bit)] & VIRTIO_BIT(bit));
+	       !!(features[VIRTIO_QWORD(bit)] & VIRTIO_BIT(bit));
 }
 
 static inline void virtio_features_set_bit(u64 *features,
 					   unsigned int bit)
 {
 	if (virtio_features_chk_bit(bit))
-		features[VIRTIO_DWORD(bit)] |= VIRTIO_BIT(bit);
+		features[VIRTIO_QWORD(bit)] |= VIRTIO_BIT(bit);
 }
 
 static inline void virtio_features_clear_bit(u64 *features,
 					     unsigned int bit)
 {
 	if (virtio_features_chk_bit(bit))
-		features[VIRTIO_DWORD(bit)] &= ~VIRTIO_BIT(bit);
+		features[VIRTIO_QWORD(bit)] &= ~VIRTIO_BIT(bit);
 }
 
 static inline void virtio_features_zero(u64 *features)
 {
-	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
+	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_QWORDS);
 }
 
 static inline void virtio_features_from_u64(u64 *features, u64 from)
@@ -66,7 +66,7 @@ static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
 {
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+	for (i = 0; i < VIRTIO_FEATURES_QWORDS; ++i)
 		if (f1[i] != f2[i])
 			return false;
 	return true;
@@ -74,14 +74,14 @@ static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
 
 static inline void virtio_features_copy(u64 *to, const u64 *from)
 {
-	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
+	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_QWORDS);
 }
 
 static inline void virtio_features_andnot(u64 *to, const u64 *f1, const u64 *f2)
 {
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+	for (i = 0; i < VIRTIO_FEATURES_QWORDS; i++)
 		to[i] = f1[i] & ~f2[i];
 }
 
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 48bc12d1045b..15818bd04716 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -107,7 +107,7 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 static inline u64
 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_QWORDS];
 
 	vp_modern_get_extended_features(mdev, features_array);
 	return features_array[0];
@@ -116,11 +116,11 @@ vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 static inline u64
 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_QWORDS];
 	int i;
 
 	vp_modern_get_driver_extended_features(mdev, features_array);
-	for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i)
+	for (i = 1; i < VIRTIO_FEATURES_QWORDS; ++i)
 		WARN_ON_ONCE(features_array[i]);
 	return features_array[0];
 }
@@ -128,7 +128,7 @@ vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 static inline void
 vp_modern_set_features(struct virtio_pci_modern_device *mdev, u64 features)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_QWORDS];
 
 	virtio_features_from_u64(features_array, features);
 	vp_modern_set_extended_features(mdev, features_array);
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index fe730099eca8..5d629aebc8f0 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -638,7 +638,7 @@ class KernelDoc:
             (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\1 \2[]'),
             (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + args_pattern + r'\)', re.S), r'dma_addr_t \1'),
             (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S), r'__u32 \1'),
-            (KernRe(r'VIRTIO_DECLARE_FEATURES\s*\(' + args_pattern + r'\)', re.S), r'u64 \1; u64 \1_array[VIRTIO_FEATURES_DWORDS]'),
+            (KernRe(r'VIRTIO_DECLARE_FEATURES\s*\(' + args_pattern + r'\)', re.S), r'u64 \1; u64 \1_array[VIRTIO_FEATURES_QWORDS]'),
         ]
 
         # Regexes here are guaranteed to have the end limiter matching
-- 
MST


