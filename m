Return-Path: <netdev+bounces-194376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D00AC91D1
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F8F9E6537
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7023504B;
	Fri, 30 May 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDPw4qru"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B53219A70
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616609; cv=none; b=i6F6X15G+bUxhAU+iYYl0ML0AqHjsM5mje5ESiGs1Jes+H6tZ+e8VgckNaOBngeT9RU2kwiKf1uYDIibcet+sXiUniOBbEtDJpEz1azZzNKGUa9i65+doA8f5I4yQYOtrpBux8pNSiRIqf+iqBcBT6EGHyafOZMiVYczBWKPbjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616609; c=relaxed/simple;
	bh=cjTWVPzJoPR7rDByvmOljZEek6BegQQkTXYljQmYrhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN6PksQ9rP969Zlem8JpTQJ862K+zgN2/wNCKa0MHlU0ZIHW9JdTNtFyIhWvhS8yjhS84uqzD6TTrHuCGCK49y9rlrDdDe8tcMxlbyWjCz09wdnsbvukxoRIkU9SGkhOXtc/zKPVnkU83997Ulo4I/iijqylpbnAazeghPjSuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDPw4qru; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748616606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmWTWUfgOfl3oXcEtkSsNWXExGWX8luAY0ciUYKpWhQ=;
	b=UDPw4qrugaPDphgkMSCt2s/FCd4BQ081v+wl3VXyY42i6blo4m0dAVG9Z1/Oe+BhUd1FIA
	SSu+fblTM543BCj319whDBeElAF+ioPEeQXenVmnd7XYL3aEDpJy0tFHu2ec4X5xBnWO9C
	5KVYUwbk1LNz0EjOERgitgj+kppeZrA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-G8A36fPMNm-NzhL619h7IA-1; Fri,
 30 May 2025 10:50:02 -0400
X-MC-Unique: G8A36fPMNm-NzhL619h7IA-1
X-Mimecast-MFC-AGG-ID: G8A36fPMNm-NzhL619h7IA_1748616601
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1945419560BC;
	Fri, 30 May 2025 14:50:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.184])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E449519560B7;
	Fri, 30 May 2025 14:49:56 +0000 (UTC)
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
Subject: [RFC PATCH v2 3/8] vhost-net: allow configuring extended features
Date: Fri, 30 May 2025 16:49:19 +0200
Message-ID: <b9b60ed5865958b9d169adc3b0196c21a50f6bca.1748614223.git.pabeni@redhat.com>
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

Use the extended feature type for 'acked_features' and implement
two new ioctls operation allowing the user-space to set/query an
unbounded amount of features.

The actual number of processed features is limited by virtio_features_t
size, and attempts to set features above such limit fail with
EOPNOTSUPP.

Note that the legacy ioctls implicitly truncate the negotiated
features to the lower 64 bits range.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - change the ioctl to use an extensible API
---
 drivers/vhost/net.c              | 61 ++++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h            |  2 +-
 include/uapi/linux/vhost.h       |  7 ++++
 include/uapi/linux/vhost_types.h |  5 +++
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 7cbfc7d718b3..f53294440695 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -77,6 +77,8 @@ enum {
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
 
+#define VHOST_NET_ALL_FEATURES VHOST_NET_FEATURES
+
 enum {
 	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
 };
@@ -1614,7 +1616,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	return err;
 }
 
-static int vhost_net_set_features(struct vhost_net *n, u64 features)
+static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
 	int i;
@@ -1685,8 +1687,9 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 	void __user *argp = (void __user *)arg;
 	u64 __user *featurep = argp;
 	struct vhost_vring_file backend;
-	u64 features;
-	int r;
+	virtio_features_t all_features;
+	u64 features, count;
+	int r, i;
 
 	switch (ioctl) {
 	case VHOST_NET_SET_BACKEND:
@@ -1704,6 +1707,58 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		if (features & ~VHOST_NET_FEATURES)
 			return -EOPNOTSUPP;
 		return vhost_net_set_features(n, features);
+	case VHOST_GET_FEATURES_ARRAY:
+	{
+		if (copy_from_user(&count, argp, sizeof(u64)))
+			return -EFAULT;
+
+		/* Copy the net features, up to the user-provided buffer size */
+		all_features = VHOST_NET_ALL_FEATURES;
+		for (i = 0; i < min(VIRTIO_FEATURES_WORDS / 2, count); ++i) {
+			argp += sizeof(u64);
+			features = all_features >> (64 * i);
+			if (copy_to_user(argp, &features, sizeof(u64)))
+				return -EFAULT;
+		}
+
+		/* Zero the trailing space provided by user-space, if any */
+		features = 0;
+		for (; i < count; ++i) {
+			argp += sizeof(u64);
+			if (copy_to_user(argp, &features, sizeof(u64)))
+				return -EFAULT;
+		}
+		return 0;
+	}
+	case VHOST_SET_FEATURES_ARRAY:
+	{
+		if (copy_from_user(&count, argp, sizeof(u64)))
+			return -EFAULT;
+
+		all_features = 0;
+		for (i = 0; i < min(count, VIRTIO_FEATURES_WORDS / 2); ++i) {
+			argp += sizeof(u64);
+			if (copy_from_user(&features, argp, sizeof(u64)))
+				return -EFAULT;
+
+			all_features |= ((virtio_features_t)features) << (64 * i);
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
+		if (all_features & ~VHOST_NET_ALL_FEATURES)
+			return -EOPNOTSUPP;
+
+		return vhost_net_set_features(n, all_features);
+	}
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof(features)))
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..ef1c7fd6f4e1 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -133,7 +133,7 @@ struct vhost_virtqueue {
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	void *private_data;
-	u64 acked_features;
+	virtio_features_t acked_features;
 	u64 acked_backend_features;
 	/* Log write descriptors */
 	void __user *log_base;
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
index d7656908f730..3f227114c557 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -110,6 +110,11 @@ struct vhost_msg_v2 {
 	};
 };
 
+struct vhost_features_array {
+	__u64 count; /* number of entries present in features array */
+	__u64 features[];
+};
+
 struct vhost_memory_region {
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
-- 
2.49.0


