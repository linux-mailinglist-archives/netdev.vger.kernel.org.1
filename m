Return-Path: <netdev+bounces-192246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD7ABF1B5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D00687B33E1
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758D25B688;
	Wed, 21 May 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2UmX77Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F32405F5
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823637; cv=none; b=GrxNdAiUA4rtQLLdOuAb9umcTu0V3t2mksjSv9GniypZlxBSgQQ3RmfWt+A0pyncmmvo7tc360xH8tSRZQg/Xl2UmFDuLXk6O3gGtieUZ//EuUYnimCah71UhqF2F/23rPffXD0cRC/HNyTIfQJSR4G9eI6pOcaK93GqG4+posU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823637; c=relaxed/simple;
	bh=iBz0vky1KSBi9zx+6ajALo6bD+BsYmnHUEejO5EInj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxRudGqFYuGfivaIBrBpMZpiRufGhOtpsX3fHxWjE7BZVknLziUXnCvd/eZHZFSwbs6wClazGf6pf2UBvL/8/cpN+SsTuAS6Pl70jxciWbKN3PmjSKdBIzzWZZnW3OAJ7FX2Hf+XsdO7lfs6ld0azkPSZziAnHW5gsS3Kn5/AAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2UmX77Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747823633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VF7dh5SSjvnDraKIahrCi4GBLh21vHh02yuNCH6cNuo=;
	b=T2UmX77ZsUHCDr6/XfQO3pflmbOHOAE5Wim51rNEGtdvZ5Si/o1BMABfJfbYz4hiBfjGep
	LO+ciWDkcI4wG9Ug9C3d0u+AZ3dADJC8MwtC97KURLQWCQFoAoVbUdYneRFnKg3eXPAauX
	nrbE4JA2lo0/zak2anBCgeKntsEdOs0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-6lvebxvJMgylDkVRdIb2NA-1; Wed,
 21 May 2025 06:33:50 -0400
X-MC-Unique: 6lvebxvJMgylDkVRdIb2NA-1
X-Mimecast-MFC-AGG-ID: 6lvebxvJMgylDkVRdIb2NA_1747823628
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97F081800570;
	Wed, 21 May 2025 10:33:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 370B4195608F;
	Wed, 21 May 2025 10:33:44 +0000 (UTC)
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
Subject: [PATCH net-next 3/8] vhost-net: allow configuring extended features
Date: Wed, 21 May 2025 12:32:37 +0200
Message-ID: <b1d716304a883a4e93178957defee2c560f5b3d4.1747822866.git.pabeni@redhat.com>
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

Use the extended feature type for 'acked_features' and implement
two new ioctls operation to get and set the extended features.

Note that the legacy ioctls implicitly truncate the negotiated
features to the lower 64 bits range.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/vhost/net.c        | 26 +++++++++++++++++++++++++-
 drivers/vhost/vhost.h      |  2 +-
 include/uapi/linux/vhost.h |  8 ++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 7cbfc7d718b3f..b894685dded3e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -77,6 +77,10 @@ enum {
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
 
+#ifdef VIRTIO_HAS_EXTENDED_FEATURES
+#define VHOST_NET_FEATURES_EX VHOST_NET_FEATURES
+#endif
+
 enum {
 	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
 };
@@ -1614,7 +1618,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	return err;
 }
 
-static int vhost_net_set_features(struct vhost_net *n, u64 features)
+static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
 	int i;
@@ -1704,6 +1708,26 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		if (features & ~VHOST_NET_FEATURES)
 			return -EOPNOTSUPP;
 		return vhost_net_set_features(n, features);
+#ifdef VIRTIO_HAS_EXTENDED_FEATURES
+	case VHOST_GET_FEATURES_EX:
+	{
+		virtio_features_t features_ex = VHOST_NET_FEATURES_EX;
+
+		if (copy_to_user(featurep, &features_ex, sizeof(features_ex)))
+			return -EFAULT;
+		return 0;
+	}
+	case VHOST_SET_FEATURES_EX:
+	{
+		virtio_features_t features_ex;
+
+		if (copy_from_user(&features_ex, featurep, sizeof(features_ex)))
+			return -EFAULT;
+		if (features_ex & ~VHOST_NET_FEATURES_EX)
+			return -EOPNOTSUPP;
+		return vhost_net_set_features(n, features_ex);
+	}
+#endif
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof(features)))
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50cd..ef1c7fd6f4e19 100644
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
index d4b3e2ae1314d..328e81badf1ad 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -235,4 +235,12 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/* Extended features manipulation
+ */
+#ifdef __SIZEOF_INT128__
+#define VHOST_GET_FEATURES_EX  _IOR(VHOST_VIRTIO, 0x83, __u128)
+#define VHOST_SET_FEATURES_EX  _IOW(VHOST_VIRTIO, 0x83, __u128)
+#endif
+
 #endif
-- 
2.49.0


