Return-Path: <netdev+bounces-199857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E3AE2124
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504443AFD13
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC42EB5CB;
	Fri, 20 Jun 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7bbLNlO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1222EA143
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441252; cv=none; b=WiMtfYaqVspZQkh/uzZgWt+jCE8LsY+QtLcAaTB1ZGcHhUA1Oq2nwt2mxo/23BxxQXIuaKm205FWWQEo+iT5vIlrDahRnoDn7VmFZw8A0M/HjsLfds+mm7kdIdCQ2WFoWNoq2UlZ3a11bwMLAgwx/AKQhT7vBAKVCU0XtpdqX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441252; c=relaxed/simple;
	bh=AT46VWcCcQjKPa7oPwdwcSm15i/anwO1ng2vAIZ/X5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/fzoGQbLq8rcGMq2+oaZBNX6AFAu4Qy80f5DEkvTZKsPMsCs6oj86BIgvSn6paapO52K1JBaExElNuPZj3SaZ0nb06om4RwNDXcUdQo+0Z0fEM2myn5Q2WX9qAuP79uD3eAxB+s9KuJiNQH12OTYNm3I2uzS3uS2E8Do5JHZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7bbLNlO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750441249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQWLefsJzTseGxO2p8Tc577UzTWaEVSmF+XfZYqkqVo=;
	b=R7bbLNlOS1WWXPNZbcsVVpznqJ02+Cg08t/OfVsIELFgCrlM//6vSVoc2+fMJJkAaDhd8c
	eGzZTzenuUxU5I5EL3HFOQIEk/wnAEYCgOd0OSyHyrqTbs1QlJnkuceN7kOGI7mVawmpre
	LBJ7kbTSL6Du2Xwlyoax0QL93uMN20c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-Jhyu-Zf0PGqBBNIpS2FNBQ-1; Fri,
 20 Jun 2025 13:40:45 -0400
X-MC-Unique: Jhyu-Zf0PGqBBNIpS2FNBQ-1
X-Mimecast-MFC-AGG-ID: Jhyu-Zf0PGqBBNIpS2FNBQ_1750441244
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25BA71956095;
	Fri, 20 Jun 2025 17:40:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.100])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80C6519560AB;
	Fri, 20 Jun 2025 17:40:39 +0000 (UTC)
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
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>,
	kvm@vger.kernel.org
Subject: [PATCH v5 net-next 4/9] vhost-net: allow configuring extended features
Date: Fri, 20 Jun 2025 19:39:48 +0200
Message-ID: <e195567cf1f705143477f6eee7b528ee15918873.1750436464.git.pabeni@redhat.com>
In-Reply-To: <cover.1750436464.git.pabeni@redhat.com>
References: <cover.1750436464.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Use the extended feature type for 'acked_features' and implement
two new ioctls operation allowing the user-space to set/query an
unbounded amount of features.

The actual number of processed features is limited by VIRTIO_FEATURES_MAX
and attempts to set features above such limit fail with
EOPNOTSUPP.

Note that: the legacy ioctls implicitly truncate the negotiated
features to the lower 64 bits range and the 'acked_backend_features'
field don't need conversion, as the only negotiated feature there
is in the low 64 bit range.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
  - simpler VHOST_GET_FEATURES_ARRAY impl && fix
  - use get_user() when possible

v3 -> v4:
  - use a single static (lower case) constant instead of enum and old def
  - simpler VHOST_GET_FEATURES_ARRAY impl
  - avoid using virtio_features_and_not

v2 -> v3:
  - virtio_features_t -> u64[2]
  - add __counted_by annotation to vhost_features_array

v1 -> v2:
  - change the ioctl to use an extensible API
---
 drivers/vhost/net.c              | 86 ++++++++++++++++++++++++--------
 drivers/vhost/vhost.c            |  2 +-
 drivers/vhost/vhost.h            |  4 +-
 include/uapi/linux/vhost.h       |  7 +++
 include/uapi/linux/vhost_types.h |  5 ++
 5 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 7cbfc7d718b3..b7dd50aa1ba3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -69,12 +69,12 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 
 #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >= (__force u32)VHOST_DMA_DONE_LEN)
 
-enum {
-	VHOST_NET_FEATURES = VHOST_FEATURES |
-			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
-			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-			 (1ULL << VIRTIO_F_RING_RESET)
+static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
+	VHOST_FEATURES |
+	(1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
+	(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+	(1ULL << VIRTIO_F_ACCESS_PLATFORM) |
+	(1ULL << VIRTIO_F_RING_RESET),
 };
 
 enum {
@@ -1614,16 +1614,17 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	return err;
 }
 
-static int vhost_net_set_features(struct vhost_net *n, u64 features)
+static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
 	int i;
 
-	hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			       (1ULL << VIRTIO_F_VERSION_1))) ?
-			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
-			sizeof(struct virtio_net_hdr);
-	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
+	hdr_len = virtio_features_test_bit(features, VIRTIO_NET_F_MRG_RXBUF) ||
+		  virtio_features_test_bit(features, VIRTIO_F_VERSION_1) ?
+		  sizeof(struct virtio_net_hdr_mrg_rxbuf) :
+		  sizeof(struct virtio_net_hdr);
+
+	if (virtio_features_test_bit(features, VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
 		sock_hlen = 0;
@@ -1633,18 +1634,19 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 		sock_hlen = hdr_len;
 	}
 	mutex_lock(&n->dev.mutex);
-	if ((features & (1 << VHOST_F_LOG_ALL)) &&
+	if (virtio_features_test_bit(features, VHOST_F_LOG_ALL) &&
 	    !vhost_log_access_ok(&n->dev))
 		goto out_unlock;
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
 	}
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
 		mutex_lock(&n->vqs[i].vq.mutex);
-		n->vqs[i].vq.acked_features = features;
+		virtio_features_copy(n->vqs[i].vq.acked_features_array,
+				     features);
 		n->vqs[i].vhost_hlen = vhost_hlen;
 		n->vqs[i].sock_hlen = sock_hlen;
 		mutex_unlock(&n->vqs[i].vq.mutex);
@@ -1681,12 +1683,13 @@ static long vhost_net_set_owner(struct vhost_net *n)
 static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			    unsigned long arg)
 {
+	u64 all_features[VIRTIO_FEATURES_DWORDS];
 	struct vhost_net *n = f->private_data;
 	void __user *argp = (void __user *)arg;
 	u64 __user *featurep = argp;
 	struct vhost_vring_file backend;
-	u64 features;
-	int r;
+	u64 features, count, copied;
+	int r, i;
 
 	switch (ioctl) {
 	case VHOST_NET_SET_BACKEND:
@@ -1694,16 +1697,59 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		return vhost_net_set_backend(n, backend.index, backend.fd);
 	case VHOST_GET_FEATURES:
-		features = VHOST_NET_FEATURES;
+		features = vhost_net_features[0];
 		if (copy_to_user(featurep, &features, sizeof features))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES:
 		if (copy_from_user(&features, featurep, sizeof features))
 			return -EFAULT;
-		if (features & ~VHOST_NET_FEATURES)
+		if (features & ~vhost_net_features[0])
 			return -EOPNOTSUPP;
-		return vhost_net_set_features(n, features);
+
+		virtio_features_from_u64(all_features, features);
+		return vhost_net_set_features(n, all_features);
+	case VHOST_GET_FEATURES_ARRAY:
+		if (get_user(count, featurep))
+			return -EFAULT;
+
+		/* Copy the net features, up to the user-provided buffer size */
+		argp += sizeof(u64);
+		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		if (copy_to_user(argp, vhost_net_features,
+				 copied * sizeof(u64)))
+			return -EFAULT;
+
+		/* Zero the trailing space provided by user-space, if any */
+		if (clear_user(argp, (count - copied) * sizeof(u64)))
+			return -EFAULT;
+		return 0;
+	case VHOST_SET_FEATURES_ARRAY:
+		if (get_user(count, featurep))
+			return -EFAULT;
+
+		virtio_features_zero(all_features);
+		argp += sizeof(u64);
+		copied = min(count, VIRTIO_FEATURES_DWORDS);
+		if (copy_from_user(all_features, argp, copied * sizeof(u64)))
+			return -EFAULT;
+
+		/*
+		 * Any feature specified by user-space above
+		 * VIRTIO_FEATURES_MAX is not supported by definition.
+		 */
+		for (i = copied; i < count; ++i) {
+			if (get_user(features, featurep + 1 + i))
+				return -EFAULT;
+			if (features)
+				return -EOPNOTSUPP;
+		}
+
+		for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+			if (all_features[i] & ~vhost_net_features[i])
+				return -EOPNOTSUPP;
+
+		return vhost_net_set_features(n, all_features);
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof(features)))
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3a5ebb973dba..1094256a943c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -372,7 +372,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vq->log_used = false;
 	vq->log_addr = -1ull;
 	vq->private_data = NULL;
-	vq->acked_features = 0;
+	virtio_features_zero(vq->acked_features_array);
 	vq->acked_backend_features = 0;
 	vq->log_base = NULL;
 	vq->error_ctx = NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..d1aed35c4b07 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -133,7 +133,7 @@ struct vhost_virtqueue {
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	void *private_data;
-	u64 acked_features;
+	VIRTIO_DECLARE_FEATURES(acked_features);
 	u64 acked_backend_features;
 	/* Log write descriptors */
 	void __user *log_base;
@@ -291,7 +291,7 @@ static inline void *vhost_vq_get_backend(struct vhost_virtqueue *vq)
 
 static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit)
 {
-	return vq->acked_features & (1ULL << bit);
+	return virtio_features_test_bit(vq->acked_features_array, bit);
 }
 
 static inline bool vhost_backend_has_feature(struct vhost_virtqueue *vq, int bit)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index d4b3e2ae1314..d6ad01fbb8d2 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,11 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/* Extended features manipulation */
+#define VHOST_GET_FEATURES_ARRAY _IOR(VHOST_VIRTIO, 0x83, \
+				       struct vhost_features_array)
+#define VHOST_SET_FEATURES_ARRAY _IOW(VHOST_VIRTIO, 0x83, \
+				       struct vhost_features_array)
+
 #endif
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index d7656908f730..1c39cc5f5a31 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -110,6 +110,11 @@ struct vhost_msg_v2 {
 	};
 };
 
+struct vhost_features_array {
+	__u64 count; /* number of entries present in features array */
+	__u64 features[] __counted_by(count);
+};
+
 struct vhost_memory_region {
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
-- 
2.49.0


