Return-Path: <netdev+bounces-45937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268607E0741
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6A8B2133E
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709571F608;
	Fri,  3 Nov 2023 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB08SaEW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71E1D6AA
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:17:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DF913E
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699031849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuqvr5RWRiWU1vecaSpLFCcLTpJ+4Yg7zkI2ypzhUqw=;
	b=cB08SaEWhkrRma2eKY9izcfqogqRUfX50J8A7zBrRmkNLUZ45Ql6ABZVsljAXD1+mmtHnS
	OHLArpBYZWRhr8YSoyhYkfLDwtmqwx0U4NW807pn0oli9bX/MfEET2WOY2iI63NnkQlUrS
	qyLVecc+NaQPPdA+mEmMp8ZLgjCIGRE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-9U5j9LuUPY-QMBSo0Y4PAQ-1; Fri, 03 Nov 2023 13:17:25 -0400
X-MC-Unique: 9U5j9LuUPY-QMBSo0Y4PAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7CE285D536;
	Fri,  3 Nov 2023 17:17:24 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C264EC1290F;
	Fri,  3 Nov 2023 17:17:21 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC v1 4/8] vdpa: Add new vdpa_config_ops to support iommufd
Date: Sat,  4 Nov 2023 01:16:37 +0800
Message-Id: <20231103171641.1703146-5-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Add 4 new vdpa_config_ops function to support iommufd

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/linux/vdpa.h | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 0e652026b776..233d80f9d910 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/iommufd.h>
 #include <linux/vhost_iotlb.h>
 #include <linux/virtio_net.h>
 #include <linux/if_ether.h>
@@ -97,6 +98,12 @@ struct vdpa_device {
 	struct vdpa_mgmt_dev *mdev;
 	unsigned int ngroups;
 	unsigned int nas;
+	struct iommufd_access *iommufd_access;
+	struct iommufd_device *iommufd_device;
+	struct iommufd_ctx *iommufd_ictx;
+	unsigned long *vq_bitmap;
+	atomic_t iommufd_users;
+	bool iommufd_attached;
 };
 
 /**
@@ -332,6 +339,17 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
+ * @bind_iommufd:              use vdpa_iommufd_physical_bind for an IOMMU
+ *                             backed device.
+ *                             otherwise use vdpa_iommufd_emulated_bind
+ * @unbind_iommufd:            use vdpa_iommufd_physical_unbind for an IOMMU
+ *                             backed device.
+ *                             otherwise, use vdpa_iommufd_emulated_unbind
+ * @attach_ioas:               use vdpa_iommufd_physical_attach_ioas for an
+ *                             IOMMU backed device.
+ * @detach_ioas:               Opposite of attach_ioas
+ * @free:			Free resources that belongs to vDPA (optional)
+ *				@vdev: vdpa device
  */
 struct vdpa_config_ops {
 	/* Virtqueue ops */
@@ -402,6 +420,13 @@ struct vdpa_config_ops {
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
+	/* IOMMUFD ops */
+	int (*bind_iommufd)(struct vdpa_device *vdev, struct iommufd_ctx *ictx,
+			    u32 *out_device_id);
+	void (*unbind_iommufd)(struct vdpa_device *vdev);
+	int (*attach_ioas)(struct vdpa_device *vdev, u32 *pt_id);
+	int (*detach_ioas)(struct vdpa_device *vdev);
+
 };
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
@@ -570,4 +595,15 @@ struct vdpa_mgmt_dev {
 int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
 void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
 
-#endif /* _LINUX_VDPA_H */
+int vdpa_iommufd_physical_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id);
+void vdpa_iommufd_physical_unbind(struct vdpa_device *vdpa);
+int vdpa_iommufd_physical_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id);
+int vdpa_iommufd_physical_detach_ioas(struct vdpa_device *vdpa);
+int vdpa_iommufd_emulated_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id);
+void vdpa_iommufd_emulated_unbind(struct vdpa_device *vdpa);
+int vdpa_iommufd_emulated_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id);
+int vdpa_iommufd_emulated_detach_ioas(struct vdpa_device *vdpa);
+
+#endif
-- 
2.34.3


