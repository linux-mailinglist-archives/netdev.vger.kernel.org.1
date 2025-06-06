Return-Path: <netdev+bounces-195420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EABAD0161
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2A917923D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7242874E1;
	Fri,  6 Jun 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9JvG1zf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27E21E25ED
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210405; cv=none; b=COF27I2WtoGzatnhzoHA8dTn3GDacEmvu6+HoWDnDfRsyvOlV0JlTzcNsJpio5XRErvncoFjQ+JU9RsP2vznpqZY8qa/fp2CZ4b3Un0Mz8ONzGIFdfnA6UiHlt2BgRRUdo2NXxSfd3SVgPfwG+TaBovcsncuPL+7F1LFeP06M4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210405; c=relaxed/simple;
	bh=IxgymE1MpMlbjrTBEebPgIwQMEqsdsZ2RIkW7meNaDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fh5d7Yhm2dAd8iYFuBhgFkmRk8cTsdm+0uy+f8FuqAxK1sSZG6aU7tqCWaT+jd563BosI6BRpnNL8HSvKptImVKgZXVnrEZauqXP6wQY0NbhY2yadSuaVRUMuoP9wIoVyiGRscgHgZV+Vf+8ObVo/y7oxn/YumYqLUgvw6Awz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9JvG1zf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gM8t9OXBXj3uq923zDQ2m7k0yCvnY+fzNJLDzdKDUOo=;
	b=T9JvG1zfEKYLk3u6t8fM38EnOMEXw9lnxFMjmzn4DBywizrFOv7+KC0Cbb59brYfT4M6bx
	YyE5cRCOsnMmlW2jVmBe5mvf5fE6PCq2puZJhiNEQYBCY7smMX+SZGExThgEYOYRppwnmA
	BDrQmbyMavd2Txe0iLcV25AZ5wZ6kj0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-AZdcG0MgPOelUiQmJ0CfzQ-1; Fri,
 06 Jun 2025 07:46:37 -0400
X-MC-Unique: AZdcG0MgPOelUiQmJ0CfzQ-1
X-Mimecast-MFC-AGG-ID: AZdcG0MgPOelUiQmJ0CfzQ_1749210396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C580A1955F3A;
	Fri,  6 Jun 2025 11:46:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.1])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D23118003FD;
	Fri,  6 Jun 2025 11:46:29 +0000 (UTC)
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
Subject: [PATCH RFC v3 3/8] vhost-net: allow configuring extended features
Date: Fri,  6 Jun 2025 13:45:40 +0200
Message-ID: <960cefa020e5cfa7afdf52447ee1785bedea75fd.1749210083.git.pabeni@redhat.com>
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

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - virtio_features_t -> u64[2]
  - add __counted_by annotation to vhost_features_array

v1 -> v2:
  - change the ioctl to use an extensible API
---
 drivers/vhost/net.c              | 85 +++++++++++++++++++++++++++-----
 drivers/vhost/vhost.c            |  2 +-
 drivers/vhost/vhost.h            |  4 +-
 include/uapi/linux/vhost.h       |  7 +++
 include/uapi/linux/vhost_types.h |  5 ++
 5 files changed, 88 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 7cbfc7d718b3..0291fce24bbf 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -77,6 +77,8 @@ enum {
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
 
+const u64 VHOST_NET_ALL_FEATURES[VIRTIO_FEATURES_DWORDS] = { VHOST_NET_FEATURES };
+
 enum {
 	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
 };
@@ -1614,16 +1616,17 @@ static long vhost_net_reset_owner(struct vhost_net *n)
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
@@ -1633,18 +1636,19 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
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
@@ -1681,12 +1685,13 @@ static long vhost_net_set_owner(struct vhost_net *n)
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
+	u64 features, count;
+	int r, i;
 
 	switch (ioctl) {
 	case VHOST_NET_SET_BACKEND:
@@ -1703,7 +1708,63 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_FEATURES)
 			return -EOPNOTSUPP;
-		return vhost_net_set_features(n, features);
+
+		virtio_features_from_u64(all_features, features);
+		return vhost_net_set_features(n, all_features);
+	case VHOST_GET_FEATURES_ARRAY:
+	{
+		if (copy_from_user(&count, argp, sizeof(u64)))
+			return -EFAULT;
+
+		/* Copy the net features, up to the user-provided buffer size */
+		virtio_features_copy(all_features, VHOST_NET_ALL_FEATURES);
+		argp += sizeof(u64);
+		for (i = 0; i < min(count, VIRTIO_FEATURES_DWORDS); ++i) {
+			i = array_index_nospec(i, VIRTIO_FEATURES_DWORDS);
+			if (copy_to_user(argp, &all_features[i], sizeof(u64)))
+				return -EFAULT;
+
+			argp += sizeof(u64);
+		}
+
+		/* Zero the trailing space provided by user-space, if any */
+		if (i < count && clear_user(argp, (count - i) * sizeof(u64)))
+			return -EFAULT;
+		return 0;
+	}
+	case VHOST_SET_FEATURES_ARRAY:
+	{
+		u64 tmp[VIRTIO_FEATURES_DWORDS];
+
+		if (copy_from_user(&count, argp, sizeof(u64)))
+			return -EFAULT;
+
+		virtio_features_zero(all_features);
+		for (i = 0; i < min(count, VIRTIO_FEATURES_DWORDS); ++i) {
+			argp += sizeof(u64);
+			if (copy_from_user(&features, argp, sizeof(u64)))
+				return -EFAULT;
+
+			all_features[i] = features;
+		}
+
+		/* Any feature specified by user-space above VIRTIO_FEATURES_MAX is
+		 * not supported by definition.
+		 */
+		for (; i < count; ++i) {
+			if (copy_from_user(&features, argp, sizeof(u64)))
+				return -EFAULT;
+			if (features)
+				return -EOPNOTSUPP;
+		}
+
+		virtio_features_and_not(tmp, all_features, VHOST_NET_ALL_FEATURES);
+		for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
+			if (tmp[i])
+				return -EOPNOTSUPP;
+
+		return vhost_net_set_features(n, all_features);
+	}
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof(features)))
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 63612faeab72..6d3b9f0a9163 100644
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


