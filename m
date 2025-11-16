Return-Path: <netdev+bounces-238923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A7C6116F
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 08:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C733B06D3
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA667287267;
	Sun, 16 Nov 2025 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+TvnYqC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mOxsfcOV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C028640B
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763279131; cv=none; b=ojLJ9+5LLWRqcxgdEApW8W8d10lKz5g98mZGCwpVRixKjhWldfPR7KjqNL8MPfBYYcETIi+2pHlsd8/MUYzgdHhzb7sm3UysWZWJSfxaIau35hcrIQZbudnjjq3KvUR+/Wpvm0JHbNs+q5ccijVmXO0gcCp24iR1SbOgSCd87ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763279131; c=relaxed/simple;
	bh=y8wCZBoR8voYmXOKUgsqLzpqBH63+zG9KD2XjWV0Mfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg9w/OxFK5709Pb9bJXW737lC7LT+Ta/VS6ExQbLYpdR0eCo0WxseYp+jUT4+dVHri+tVw3jklLtg1d8MM3fYw/pRxkAZrLyuiFzrnrYvwVtbpqzr2+2iquTG/LUctp9YAJtcyZv9qwV9u580q1O6MEqVC2p8qPOzUa4rUoSWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+TvnYqC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mOxsfcOV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763279128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=trQJ3e9sH2/7p6hcj43E7jvSF+i5hK8jJlCsMQnk8Kw=;
	b=G+TvnYqCVjRqTV4Oth4aH9EqvDefwIpQZwdkxnfBGz++mM7MS2fB+J71dIrm4V616dyoHk
	bT/vxnAQm8Ugy0LVUINrN9cqy/AYb6yW3P9gQKP70r1HpYcIndKXApPZU9MepGE2ErCNdf
	2aog0evizhGlrm/ZEdYtO8Mx9JYmLvU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-sBBiAxgZOHqGuZNQRCbQig-1; Sun, 16 Nov 2025 02:45:27 -0500
X-MC-Unique: sBBiAxgZOHqGuZNQRCbQig-1
X-Mimecast-MFC-AGG-ID: sBBiAxgZOHqGuZNQRCbQig_1763279126
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cdb0706aso2926050f8f.0
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 23:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763279126; x=1763883926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=trQJ3e9sH2/7p6hcj43E7jvSF+i5hK8jJlCsMQnk8Kw=;
        b=mOxsfcOVN7c1Nmpzw6izHM6CsPcO9/erni1F62AwNw7Ls/ckzf6XVbD3dc5VFiaPZL
         Hy/QTk6Ze5z/y8zPXe8CqBLhwy42tj7c1NORelQ+BtpLSfcUIGECxTNuu0oqVZoh5YRy
         YE60X65iaamZtJUNQ/T112Or5La17ci5I2fqvQwsqSV3eTgtN9qS9hX2rvzFgNaPxZru
         cf79SPbkKzhlJfBOXgonl0vm+U5+GhAI1KDs6qsy4Q4TAdBLcSGq9zak+VP7t/DUd/mn
         zoUPNYxLAANUqYHzePFuwubPpbHX5Gfw//O8qzA7sz/SirhqV7GEf1wIvmDGsr7ApsOi
         aJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763279126; x=1763883926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trQJ3e9sH2/7p6hcj43E7jvSF+i5hK8jJlCsMQnk8Kw=;
        b=d78WVTxF+FPpAMwv5G6c4zT66wub4RMmlnYELgXCGCMCa/9VBJP6KyNqbaODI2AR+f
         kp56iFsHk+uVpipD7m+JQ20D9xdvgBn1bNs5bU2sXcXiMMNx6imnpXW5C+w5jvtMhwVr
         weCtRqvZBjnjXX7dk9dgNzkyA38tgOGqa9A52RgLuAhU8LUknXuN1VfFT/P0MBr177k3
         Y1ZSud+Z07be5LLVUqcYiYjPriGueDKKGDzUT6jX7nXxvi68c5bmD8MCb28oAY8Blk1A
         nsHvnE55rFXSMjqZW+hwjijhc+Wfj/mp98gzgaaoELm2dqVkHdE3Qmbh8TSx8CbldSmH
         RHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7zlwrrUcf9f2Gh32jwE2E3pnHXsxPUpgoLSwKBPgQx2M6tpxFmdWaQl3bFnw3SdOU4R+gKa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4bPKtQqmVLQ2AB+gJhwrF7SRbFdN2tEwbgbv9jZhPYR50hiD
	S9JEU7UWxj3SH5+JDURnZjPCmz9JF4NzSVyunfkTPfQDLIUUesjz3w/Pc5HS3bseeOpBCspnWHd
	yWVl7xyp6kbCbBr9Mv4wiWta7JE01C4phjpVWBzG/nGbObKaR8NX3PIH3SQ==
X-Gm-Gg: ASbGncsf+N2VGGUJIA0VJ1kQoePAhZr5+B0tri5YBUKNfFuMyZXcxiESI22RTaYNIpQ
	MJ0XMR4ZyXqKBMkEECtq6HUV/KwoIcpCjlW1LFszU8QBibRCWNQwJY8tj3cXNEToVHuilHT1VAU
	Ds4Lj+xXG4uBzsZn4O+38r7PUV6/VNnMBYX6IcFkYSoaYqeDYzbfphL7g0tN6uGrA38bK50CAMF
	i5Hw02hV1A/RX1Vf6y1aw9uA6gP1/8wF8xDtYzDivVSdVRzTrCXXEDJF23YRA6oVUwzWjp6LapY
	9ihipvu0NRvYD9GKqhDYrG6gvbdmvPE2Ydne+xpZMsUcq08yW4Zj49Of89TUxgsV9b2tbdC41Pv
	0Gq0Q24fNDshjLzi64lQ=
X-Received: by 2002:a05:6000:61e:b0:429:d6dc:ae1a with SMTP id ffacd0b85a97d-42b59377f5cmr7143992f8f.30.1763279126254;
        Sat, 15 Nov 2025 23:45:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFavbSLEzC3fzGZlFNcbplKoDaGAFf6xm82Dmpuac8kJ0YL87asozxTpPgyhKXE0Otxlq6lXg==
X-Received: by 2002:a05:6000:61e:b0:429:d6dc:ae1a with SMTP id ffacd0b85a97d-42b59377f5cmr7143962f8f.30.1763279125674;
        Sat, 15 Nov 2025 23:45:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f2084dsm20221273f8f.42.2025.11.15.23.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 23:45:24 -0800 (PST)
Date: Sun, 16 Nov 2025 02:45:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 2/2] vhost: switch to arrays of feature bits
Message-ID: <17c98c7304b6d78d2d59893ba7295c2f64ab1224.1763278904.git.mst@redhat.com>
References: <cover.1763278904.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763278904.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

The current interface where caller has to know in which 64 bit chunk
each bit is, is inelegant and fragile.
Let's simply use arrays of bits.
By using unroll macros text size grows only slightly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c   | 34 +++++++++++++++++++---------------
 drivers/vhost/scsi.c  |  9 ++++++---
 drivers/vhost/test.c  | 10 ++++++++--
 drivers/vhost/vhost.h | 42 ++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vsock.c | 10 ++++++----
 5 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index d057ea55f5ad..00d00034a97e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -69,15 +69,15 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 
 #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >= (__force u32)VHOST_DMA_DONE_LEN)
 
-static const u64 vhost_net_features[VIRTIO_FEATURES_U64S] = {
-	VHOST_FEATURES |
-	(1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
-	(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-	(1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-	(1ULL << VIRTIO_F_RING_RESET) |
-	(1ULL << VIRTIO_F_IN_ORDER),
-	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
-	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
+static const int vhost_net_features[] = {
+	VHOST_FEATURES,
+	VHOST_NET_F_VIRTIO_NET_HDR,
+	VIRTIO_NET_F_MRG_RXBUF,
+	VIRTIO_F_ACCESS_PLATFORM,
+	VIRTIO_F_RING_RESET,
+	VIRTIO_F_IN_ORDER,
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
+	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
 };
 
 enum {
@@ -1734,14 +1734,14 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		return vhost_net_set_backend(n, backend.index, backend.fd);
 	case VHOST_GET_FEATURES:
-		features = vhost_net_features[0];
+		features = VHOST_FEATURES_U64(vhost_net_features, 0);
 		if (copy_to_user(featurep, &features, sizeof features))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES:
 		if (copy_from_user(&features, featurep, sizeof features))
 			return -EFAULT;
-		if (features & ~vhost_net_features[0])
+		if (features & ~VHOST_FEATURES_U64(vhost_net_features, 0))
 			return -EOPNOTSUPP;
 
 		virtio_features_from_u64(all_features, features);
@@ -1753,9 +1753,13 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		/* Copy the net features, up to the user-provided buffer size */
 		argp += sizeof(u64);
 		copied = min(count, (u64)VIRTIO_FEATURES_U64S);
-		if (copy_to_user(argp, vhost_net_features,
-				 copied * sizeof(u64)))
-			return -EFAULT;
+
+		{
+			const DEFINE_VHOST_FEATURES_ARRAY(features, vhost_net_features);
+
+			if (copy_to_user(argp, features, copied * sizeof(u64)))
+				return -EFAULT;
+		}
 
 		/* Zero the trailing space provided by user-space, if any */
 		if (clear_user(argp, size_mul(count - copied, sizeof(u64))))
@@ -1784,7 +1788,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		}
 
 		for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
-			if (all_features[i] & ~vhost_net_features[i])
+			if (all_features[i] & ~VHOST_FEATURES_U64(vhost_net_features, i))
 				return -EOPNOTSUPP;
 
 		return vhost_net_set_features(n, all_features);
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 98e4f68f4e3c..04fcbe7efd77 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -197,11 +197,14 @@ enum {
 };
 
 /* Note: can't set VIRTIO_F_VERSION_1 yet, since that implies ANY_LAYOUT. */
-enum {
-	VHOST_SCSI_FEATURES = VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_HOTPLUG) |
-					       (1ULL << VIRTIO_SCSI_F_T10_PI)
+static const int vhost_scsi_features[] = {
+	VHOST_FEATURES,
+	VIRTIO_SCSI_F_HOTPLUG,
+	VIRTIO_SCSI_F_T10_PI
 };
 
+#define VHOST_SCSI_FEATURES VHOST_FEATURES_U64(vhost_scsi_features, 0)
+
 #define VHOST_SCSI_MAX_TARGET	256
 #define VHOST_SCSI_MAX_IO_VQ	1024
 #define VHOST_SCSI_MAX_EVENT	128
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 42c955a5b211..af727fccfe40 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -308,6 +308,12 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 	return r;
 }
 
+static const int vhost_test_features[] = {
+	VHOST_FEATURES
+};
+
+#define VHOST_TEST_FEATURES VHOST_FEATURES_U64(vhost_test_features, 0)
+
 static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
 			     unsigned long arg)
 {
@@ -328,14 +334,14 @@ static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		return vhost_test_set_backend(n, backend.index, backend.fd);
 	case VHOST_GET_FEATURES:
-		features = VHOST_FEATURES;
+		features = VHOST_TEST_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof features))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES:
 		if (copy_from_user(&features, featurep, sizeof features))
 			return -EFAULT;
-		if (features & ~VHOST_FEATURES)
+		if (features & ~VHOST_TEST_FEATURES)
 			return -EOPNOTSUPP;
 		return vhost_test_set_features(n, features);
 	case VHOST_RESET_OWNER:
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 621a6d9a8791..d8f1af9a0ff1 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -14,6 +14,7 @@
 #include <linux/atomic.h>
 #include <linux/vhost_iotlb.h>
 #include <linux/irqbypass.h>
+#include <linux/unroll.h>
 
 struct vhost_work;
 struct vhost_task;
@@ -279,14 +280,39 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
 				eventfd_signal((vq)->error_ctx);\
 	} while (0)
 
-enum {
-	VHOST_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
-			 (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
-			 (1ULL << VIRTIO_RING_F_EVENT_IDX) |
-			 (1ULL << VHOST_F_LOG_ALL) |
-			 (1ULL << VIRTIO_F_ANY_LAYOUT) |
-			 (1ULL << VIRTIO_F_VERSION_1)
-};
+#define VHOST_FEATURES \
+	VIRTIO_F_NOTIFY_ON_EMPTY, \
+	VIRTIO_RING_F_INDIRECT_DESC, \
+	VIRTIO_RING_F_EVENT_IDX, \
+	VHOST_F_LOG_ALL, \
+	VIRTIO_F_ANY_LAYOUT, \
+	VIRTIO_F_VERSION_1
+
+static inline u64 vhost_features_u64(const int *features, int size, int idx)
+{
+	unsigned long res = 0;
+
+	unrolled_count(VIRTIO_FEATURES_BITS)
+	for (int i = 0; i < size; ++i) {
+		int bit = features[i];
+
+		if (virtio_features_chk_bit(bit) && VIRTIO_U64(bit) == idx)
+			res |= VIRTIO_BIT(bit);
+	}
+	return res;
+}
+
+#define VHOST_FEATURES_U64(features, idx) \
+	vhost_features_u64(features, ARRAY_SIZE(features), idx)
+
+#define DEFINE_VHOST_FEATURES_ARRAY_ENTRY(idx, features) \
+	[idx] = VHOST_FEATURES_U64(features, idx),
+
+#define DEFINE_VHOST_FEATURES_ARRAY(array, features) \
+	u64 array[VIRTIO_FEATURES_U64S] = { \
+		UNROLL(VIRTIO_FEATURES_U64S, \
+		       DEFINE_VHOST_FEATURES_ARRAY_ENTRY, features) \
+	}
 
 /**
  * vhost_vq_set_backend - Set backend.
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ae01457ea2cd..16662f2b87c1 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -29,12 +29,14 @@
  */
 #define VHOST_VSOCK_PKT_WEIGHT 256
 
-enum {
-	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
-			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
+static const int vhost_vsock_features[] = {
+	VHOST_FEATURES,
+	VIRTIO_F_ACCESS_PLATFORM,
+	VIRTIO_VSOCK_F_SEQPACKET
 };
 
+#define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_features, 0)
+
 enum {
 	VHOST_VSOCK_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
 };
-- 
MST


