Return-Path: <netdev+bounces-238919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAC5C61130
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 08:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2FC3B7D76
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B440284B3B;
	Sun, 16 Nov 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4wFhTZ7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAj1Z920"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38332263F5E
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763278594; cv=none; b=K+PB19v7DzK+MvBDN7Y3S84USssBsJ6+qQqAdfApTMOcO3qB1Ybzm38MOEn5622A6t2xjbctNuzf39sn29H8U8F8wgev5gMI5gxZm1UHyO3Z1/GpkgYT8zr8eBhG/km7AGVW8wjI1wPJTUnt58TVqhTBAxKGKnzB/M+tpcCHJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763278594; c=relaxed/simple;
	bh=f2kJNglJR+lhIK51Qx7RmMGS9CVHLOQpPyBb9NOfgoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBwxSLYloh257iEc3rPmpby0a4Niyrt00KMhBvToTUC09P3Yw4byW/EKdfL2PpsuRfgpjVLx+DJXolp12T1rYvGlJyba6sVnHX1fq/avAMDkSyH16ijTdEBtmXrxhKrsxXqsYMXGoZUuOJi7W6T4vpxdvDPmf+vidA1Mj9uxX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4wFhTZ7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAj1Z920; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763278591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfvjKvTr84+DPxPNgRU8CK+51nhfY69WGkFL3D46kFU=;
	b=f4wFhTZ7W3YpvYYo71mhdVTR68Kb+994/y+wWCAwgLa0Kay0IKMJ/qZlxqMmPYihWdj30I
	moxJVpECHFy9VVfcN70Lt8762bYKKDZ0eqej/y+DoUHcoAGQ0IiZcHAHR0h6GK9WNMKB5R
	kHmnwxNw7y9i0Iea4BhC0B0sNdT45e4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-s-Dbyv-OM3iqFOI_8VonUA-1; Sun, 16 Nov 2025 02:36:27 -0500
X-MC-Unique: s-Dbyv-OM3iqFOI_8VonUA-1
X-Mimecast-MFC-AGG-ID: s-Dbyv-OM3iqFOI_8VonUA_1763278586
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cceeeb96so1262735f8f.1
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763278585; x=1763883385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfvjKvTr84+DPxPNgRU8CK+51nhfY69WGkFL3D46kFU=;
        b=iAj1Z920mxd/1iDUF56Mm3aFi+HSQN/IhJYcJiNwKNgbPzhDYj1QDxDeUuwtgy9nCv
         jiuyZowQenqz7Q7Xdcn3lhc8MyAf0MFAxhVK0RxTAamuHT+aW5aKeudWy2qagGSBEAjh
         oNC7BV1fqFjL07VpQ3DZX33kPlPYRXQVskoyAm9MEhwzeqwlVykdKOLfsYXSJgKNJXti
         bM1VP8+IN1y1hjM8hJZ4QxPmWhsB1RNhYcVse8CBfZmTCvFpiYILnXvi+w46Ur2hz+ka
         4w/J/NCcDaZwIB9RV2NC7C5ZIr3/1X6wQrF6io7gNxsKezTp2yfUvafX18xnLHWWvj5U
         2qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763278585; x=1763883385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfvjKvTr84+DPxPNgRU8CK+51nhfY69WGkFL3D46kFU=;
        b=PQhe8Y7XglMSs2RMAXtt2C5x4OYI7sVNdZ7EX7IUb+/dSz5lbmJDnOoVe2vxITpn9n
         sm8P2UgDVa/EXCE8lt6TdmYER/likaQu6iaUq/M6qH6WvzJQJRC+arSsM9lP6wYft4p9
         6lSK70YC75cMWgDnkNKB4AYblQ8QMttdIMITDkz7MJHDiu7BubhZwyzXRwFYPhOP7PkW
         iqqE2jmMRtVNRzMHnfO3IgcB8AH+c38fXxbyrbs4QpK+0TQT3B/oic7ZYnCJtVXGdB+y
         E9mXlIEUHBgowksdaRJyIvg6g7C0pouoQJYqOm0MvhrslQjGqX7fuySpFTEbD6Q5YM7k
         ggzA==
X-Forwarded-Encrypted: i=1; AJvYcCVqfpeWgQUUjESdQg2RFiG9cIZCBeHpNSqWRCt+SgMWddsxjq6csMQlN8bkJv0WE5q0DToYNbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVMni18FET3zn1mfU5Q4d2xOuTsaCS+9biz2Z3WvlS9Fv1Qou
	aIGhs++yefIWGO7zCWFCzRk7D260nz5Q95O367Q0BYbPCKHNL/2YqAG573+l965okKq+KpnWI2V
	22J3WyJHJZ7+qTI0dyXayQaqK23HvOijCs9wsl9t3BijW8jhopSk+8VCQPrBuNsa19Q==
X-Gm-Gg: ASbGncughxhgTqci2PEglIYdsPncQKCixlgHpNcZebnsarXMfGy1qt3Dwclz/tvPEM2
	Nq/q9LtklphFB9sD1umgmLGYlhT6nDet7gjgyPQ+kgVEJIO0efh78gZT8T+7ldcBPLQyUL1Dh8D
	CGzvOwasFdHEtSS1L4ppZiAxidReqqJL49ufwv5zkQoEmF/waPnzKM6jsyiQSbCRVtPL6W6JuHe
	XmoqAZJGyGikoDqEy6T3ax/uREIRI5eeHQNpNFbg7ylFk7fOA6uJ0jugX5pX4ET4lPYsnsDmvgo
	uL5QJ29gU+j7R/tkD1ADqFWnpPsWZR/8pBY77GPzFgiXDzvnFcNKJ9f3RUyRB08hqbLtTqrjNtN
	2ToFVDeY3YoGs/THTGAE=
X-Received: by 2002:a05:6000:2806:b0:42b:4061:23f3 with SMTP id ffacd0b85a97d-42b5938886amr5547730f8f.44.1763278585469;
        Sat, 15 Nov 2025 23:36:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHecAkzy4WK7HKxlbxQJRhSxQSUWEkQKG9rGExfa5k8AKxXbgHO/j7kSJs/rsWlSfDpHVX+w==
X-Received: by 2002:a05:6000:2806:b0:42b:4061:23f3 with SMTP id ffacd0b85a97d-42b5938886amr5547703f8f.44.1763278584896;
        Sat, 15 Nov 2025 23:36:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b074sm18938164f8f.7.2025.11.15.23.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 23:36:24 -0800 (PST)
Date: Sun, 16 Nov 2025 02:36:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 1/2] virtio: clean up features qword/dword terms
Message-ID: <67ae57499e779aef2c5bd7ee354af5d4af39bf60.1763278093.git.mst@redhat.com>
References: <cover.1763278093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763278093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

virtio pci uses word to mean "16 bits". mmio uses it to mean
"32 bits".

To avoid confusion, let's avoid the term in core virtio
altogether. Just say U64 to mean "64 bit".

Fixes: e7d4c1c5a546 ("virtio: introduce extended features")
Cc: "Paolo Abeni" <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@redhat.com>
---
 drivers/vhost/net.c                    | 12 +++++------
 drivers/virtio/virtio.c                | 12 +++++------
 drivers/virtio/virtio_debug.c          | 10 ++++-----
 drivers/virtio/virtio_pci_modern_dev.c |  6 +++---
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 29 +++++++++++++-------------
 include/linux/virtio_pci_modern.h      |  8 +++----
 scripts/lib/kdoc/kdoc_parser.py        |  2 +-
 9 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 35ded4330431..d057ea55f5ad 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -69,7 +69,7 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 
 #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >= (__force u32)VHOST_DMA_DONE_LEN)
 
-static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
+static const u64 vhost_net_features[VIRTIO_FEATURES_U64S] = {
 	VHOST_FEATURES |
 	(1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 	(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
@@ -1720,7 +1720,7 @@ static long vhost_net_set_owner(struct vhost_net *n)
 static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			    unsigned long arg)
 {
-	u64 all_features[VIRTIO_FEATURES_DWORDS];
+	u64 all_features[VIRTIO_FEATURES_U64S];
 	struct vhost_net *n = f->private_data;
 	void __user *argp = (void __user *)arg;
 	u64 __user *featurep = argp;
@@ -1752,7 +1752,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 
 		/* Copy the net features, up to the user-provided buffer size */
 		argp += sizeof(u64);
-		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
 		if (copy_to_user(argp, vhost_net_features,
 				 copied * sizeof(u64)))
 			return -EFAULT;
@@ -1767,13 +1767,13 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 
 		virtio_features_zero(all_features);
 		argp += sizeof(u64);
-		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
 		if (copy_from_user(all_features, argp, copied * sizeof(u64)))
 			return -EFAULT;
 
 		/*
 		 * Any feature specified by user-space above
-		 * VIRTIO_FEATURES_MAX is not supported by definition.
+		 * VIRTIO_FEATURES_BITS is not supported by definition.
 		 */
 		for (i = copied; i < count; ++i) {
 			if (copy_from_user(&features, featurep + 1 + i,
@@ -1783,7 +1783,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 				return -EOPNOTSUPP;
 		}
 
-		for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+		for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
 			if (all_features[i] & ~vhost_net_features[i])
 				return -EOPNOTSUPP;
 
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a09eb4d62f82..5bdc6b82b30b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -53,7 +53,7 @@ static ssize_t features_show(struct device *_d,
 
 	/* We actually represent this as a bitstring, as it could be
 	 * arbitrary length in future. */
-	for (i = 0; i < VIRTIO_FEATURES_MAX; i++)
+	for (i = 0; i < VIRTIO_FEATURES_BITS; i++)
 		len += sysfs_emit_at(buf, len, "%c",
 			       __virtio_test_bit(dev, i) ? '1' : '0');
 	len += sysfs_emit_at(buf, len, "\n");
@@ -272,8 +272,8 @@ static int virtio_dev_probe(struct device *_d)
 	int err, i;
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
-	u64 device_features[VIRTIO_FEATURES_DWORDS];
-	u64 driver_features[VIRTIO_FEATURES_DWORDS];
+	u64 device_features[VIRTIO_FEATURES_U64S];
+	u64 driver_features[VIRTIO_FEATURES_U64S];
 	u64 driver_features_legacy;
 
 	/* We have a driver! */
@@ -286,7 +286,7 @@ static int virtio_dev_probe(struct device *_d)
 	virtio_features_zero(driver_features);
 	for (i = 0; i < drv->feature_table_size; i++) {
 		unsigned int f = drv->feature_table[i];
-		if (!WARN_ON_ONCE(f >= VIRTIO_FEATURES_MAX))
+		if (!WARN_ON_ONCE(f >= VIRTIO_FEATURES_BITS))
 			virtio_features_set_bit(driver_features, f);
 	}
 
@@ -303,7 +303,7 @@ static int virtio_dev_probe(struct device *_d)
 	}
 
 	if (virtio_features_test_bit(device_features, VIRTIO_F_VERSION_1)) {
-		for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+		for (i = 0; i < VIRTIO_FEATURES_U64S; ++i)
 			dev->features_array[i] = driver_features[i] &
 						 device_features[i];
 	} else {
@@ -325,7 +325,7 @@ static int virtio_dev_probe(struct device *_d)
 		goto err;
 
 	if (drv->validate) {
-		u64 features[VIRTIO_FEATURES_DWORDS];
+		u64 features[VIRTIO_FEATURES_U64S];
 
 		virtio_features_copy(features, dev->features_array);
 		err = drv->validate(dev);
diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
index d58713ddf2e5..ccf1955a1183 100644
--- a/drivers/virtio/virtio_debug.c
+++ b/drivers/virtio/virtio_debug.c
@@ -8,12 +8,12 @@ static struct dentry *virtio_debugfs_dir;
 
 static int virtio_debug_device_features_show(struct seq_file *s, void *data)
 {
-	u64 device_features[VIRTIO_FEATURES_DWORDS];
+	u64 device_features[VIRTIO_FEATURES_U64S];
 	struct virtio_device *dev = s->private;
 	unsigned int i;
 
 	virtio_get_features(dev, device_features);
-	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS; i++) {
 		if (virtio_features_test_bit(device_features, i))
 			seq_printf(s, "%u\n", i);
 	}
@@ -26,7 +26,7 @@ static int virtio_debug_filter_features_show(struct seq_file *s, void *data)
 	struct virtio_device *dev = s->private;
 	unsigned int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS; i++) {
 		if (virtio_features_test_bit(dev->debugfs_filter_features, i))
 			seq_printf(s, "%u\n", i);
 	}
@@ -50,7 +50,7 @@ static int virtio_debug_filter_feature_add(void *data, u64 val)
 {
 	struct virtio_device *dev = data;
 
-	if (val >= VIRTIO_FEATURES_MAX)
+	if (val >= VIRTIO_FEATURES_BITS)
 		return -EINVAL;
 
 	virtio_features_set_bit(dev->debugfs_filter_features, val);
@@ -64,7 +64,7 @@ static int virtio_debug_filter_feature_del(void *data, u64 val)
 {
 	struct virtio_device *dev = data;
 
-	if (val >= VIRTIO_FEATURES_MAX)
+	if (val >= VIRTIO_FEATURES_BITS)
 		return -EINVAL;
 
 	virtio_features_clear_bit(dev->debugfs_filter_features, val);
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 9e503b7a58d8..413a8c353463 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -401,7 +401,7 @@ void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->device_feature_select);
@@ -427,7 +427,7 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
@@ -448,7 +448,7 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
 		u32 cur = features[i >> 1] >> (32 * (i & 1));
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96c66126c074..132a474e5914 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -177,7 +177,7 @@ struct virtio_device {
 	union virtio_map vmap;
 #ifdef CONFIG_VIRTIO_DEBUG
 	struct dentry *debugfs_dir;
-	u64 debugfs_filter_features[VIRTIO_FEATURES_DWORDS];
+	u64 debugfs_filter_features[VIRTIO_FEATURES_U64S];
 #endif
 };
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index a1af2676bbe6..69f84ea85d71 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -80,7 +80,7 @@ struct virtqueue_info {
  *	Returns the first 64 feature bits.
  * @get_extended_features:
  *      vdev: the virtio_device
- *      Returns the first VIRTIO_FEATURES_MAX feature bits (all we currently
+ *      Returns the first VIRTIO_FEATURES_BITS feature bits (all we currently
  *      need).
  * @finalize_features: confirm what device features we'll be using.
  *	vdev: the virtio_device
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index f748f2f87de8..ea2ad8717882 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -4,15 +4,16 @@
 
 #include <linux/bits.h>
 
-#define VIRTIO_FEATURES_DWORDS	2
-#define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_DWORDS * 64)
-#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_DWORDS * 2)
+#define VIRTIO_FEATURES_U64S	2
+#define VIRTIO_FEATURES_BITS	(VIRTIO_FEATURES_U64S * 64)
+
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
-#define VIRTIO_DWORD(b)		((b) >> 6)
+#define VIRTIO_U64(b)		((b) >> 6)
+
 #define VIRTIO_DECLARE_FEATURES(name)			\
 	union {						\
 		u64 name;				\
-		u64 name##_array[VIRTIO_FEATURES_DWORDS];\
+		u64 name##_array[VIRTIO_FEATURES_U64S];\
 	}
 
 static inline bool virtio_features_chk_bit(unsigned int bit)
@@ -22,9 +23,9 @@ static inline bool virtio_features_chk_bit(unsigned int bit)
 		 * Don't care returning the correct value: the build
 		 * will fail before any bad features access
 		 */
-		BUILD_BUG_ON(bit >= VIRTIO_FEATURES_MAX);
+		BUILD_BUG_ON(bit >= VIRTIO_FEATURES_BITS);
 	} else {
-		if (WARN_ON_ONCE(bit >= VIRTIO_FEATURES_MAX))
+		if (WARN_ON_ONCE(bit >= VIRTIO_FEATURES_BITS))
 			return false;
 	}
 	return true;
@@ -34,26 +35,26 @@ static inline bool virtio_features_test_bit(const u64 *features,
 					    unsigned int bit)
 {
 	return virtio_features_chk_bit(bit) &&
-	       !!(features[VIRTIO_DWORD(bit)] & VIRTIO_BIT(bit));
+	       !!(features[VIRTIO_U64(bit)] & VIRTIO_BIT(bit));
 }
 
 static inline void virtio_features_set_bit(u64 *features,
 					   unsigned int bit)
 {
 	if (virtio_features_chk_bit(bit))
-		features[VIRTIO_DWORD(bit)] |= VIRTIO_BIT(bit);
+		features[VIRTIO_U64(bit)] |= VIRTIO_BIT(bit);
 }
 
 static inline void virtio_features_clear_bit(u64 *features,
 					     unsigned int bit)
 {
 	if (virtio_features_chk_bit(bit))
-		features[VIRTIO_DWORD(bit)] &= ~VIRTIO_BIT(bit);
+		features[VIRTIO_U64(bit)] &= ~VIRTIO_BIT(bit);
 }
 
 static inline void virtio_features_zero(u64 *features)
 {
-	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
+	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_U64S);
 }
 
 static inline void virtio_features_from_u64(u64 *features, u64 from)
@@ -66,7 +67,7 @@ static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
 {
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
+	for (i = 0; i < VIRTIO_FEATURES_U64S; ++i)
 		if (f1[i] != f2[i])
 			return false;
 	return true;
@@ -74,14 +75,14 @@ static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
 
 static inline void virtio_features_copy(u64 *to, const u64 *from)
 {
-	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
+	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_U64S);
 }
 
 static inline void virtio_features_andnot(u64 *to, const u64 *f1, const u64 *f2)
 {
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+	for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
 		to[i] = f1[i] & ~f2[i];
 }
 
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 48bc12d1045b..9a3f2fc53bd6 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -107,7 +107,7 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 static inline u64
 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_U64S];
 
 	vp_modern_get_extended_features(mdev, features_array);
 	return features_array[0];
@@ -116,11 +116,11 @@ vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 static inline u64
 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_U64S];
 	int i;
 
 	vp_modern_get_driver_extended_features(mdev, features_array);
-	for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i)
+	for (i = 1; i < VIRTIO_FEATURES_U64S; ++i)
 		WARN_ON_ONCE(features_array[i]);
 	return features_array[0];
 }
@@ -128,7 +128,7 @@ vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
 static inline void
 vp_modern_set_features(struct virtio_pci_modern_device *mdev, u64 features)
 {
-	u64 features_array[VIRTIO_FEATURES_DWORDS];
+	u64 features_array[VIRTIO_FEATURES_U64S];
 
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


