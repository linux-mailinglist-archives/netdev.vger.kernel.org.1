Return-Path: <netdev+bounces-45934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4247E073E
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633A5281F3F
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24402032F;
	Fri,  3 Nov 2023 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXAglskq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FA20309
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:16:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FCD4C
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699031815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZOkp7RIIlEcdzCc+o8G685sXVkqf9owoeJPzWLLPLs=;
	b=DXAglskqoBjX1zAit+HiPrFFFIgik4spl9dgitQ0t1GFh/BYuLCJYEmlbtN3XOkAyFhcOv
	Z0KHobG2TLP4uJn1XStEOZCduueCjCfcejL1tMvNg/eavO6LA06tl5l1b6xJ1Q3NX26myw
	52l83kD5zM8xotg0oiCfj4DHxaXdsCI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-s4ZotfSOOLO-hga7WjSckw-1; Fri, 03 Nov 2023 13:16:52 -0400
X-MC-Unique: s4ZotfSOOLO-hga7WjSckw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21CC1811E88;
	Fri,  3 Nov 2023 17:16:52 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F145740C6ECE;
	Fri,  3 Nov 2023 17:16:48 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC v1 1/8] vhost/iommufd: Add the functions support iommufd
Date: Sat,  4 Nov 2023 01:16:34 +0800
Message-Id: <20231103171641.1703146-2-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add a new file vhost/iommufd.c to support the function of
iommufd, This file contains iommufd function of emulated device and
the physical device. 

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/iommufd.c | 178 ++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.h   |  21 +++++
 2 files changed, 199 insertions(+)
 create mode 100644 drivers/vhost/iommufd.c

diff --git a/drivers/vhost/iommufd.c b/drivers/vhost/iommufd.c
new file mode 100644
index 000000000000..113dda50a9b6
--- /dev/null
+++ b/drivers/vhost/iommufd.c
@@ -0,0 +1,178 @@
+#include <linux/vdpa.h>
+#include <linux/iommufd.h>
+
+#include "vhost.h"
+
+MODULE_IMPORT_NS(IOMMUFD);
+
+int vdpa_iommufd_bind(struct vdpa_device *vdpa, struct iommufd_ctx *ictx,
+		      u32 *ioas_id, u32 *device_id)
+{
+	int ret;
+
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	/*
+        * If the driver doesn't provide this op then it means the device does
+        * not do DMA at all. So nothing to do.
+        */
+	if (!vdpa->config->bind_iommufd)
+		return 0;
+	ret = vdpa->config->bind_iommufd(vdpa, ictx, device_id);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void vdpa_iommufd_unbind(struct vdpa_device *vdpa)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (vdpa->config->unbind_iommufd)
+		vdpa->config->unbind_iommufd(vdpa);
+}
+
+int vdpa_iommufd_physical_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id)
+{
+	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
+	struct iommufd_device *idev;
+
+	idev = iommufd_device_bind(ictx, dma_dev, out_device_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	vdpa->iommufd_device = idev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_bind);
+
+void vdpa_iommufd_physical_unbind(struct vdpa_device *vdpa)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (vdpa->iommufd_attached) {
+		iommufd_device_detach(vdpa->iommufd_device);
+		vdpa->iommufd_attached = false;
+	}
+	iommufd_device_unbind(vdpa->iommufd_device);
+	vdpa->iommufd_device = NULL;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_unbind);
+
+int vdpa_iommufd_physical_attach_ioas(struct vdpa_device *vdpa,
+				      u32 *iommufd_ioasid)
+{
+	int rc;
+
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (WARN_ON(!vdpa->iommufd_device))
+		return -EINVAL;
+
+	if (vdpa->iommufd_attached)
+		rc = iommufd_device_replace(vdpa->iommufd_device,
+					    iommufd_ioasid);
+	else
+		rc = iommufd_device_attach(vdpa->iommufd_device,
+					   iommufd_ioasid);
+	if (rc)
+		return rc;
+	vdpa->iommufd_attached = true;
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_attach_ioas);
+int vdpa_iommufd_physical_detach_ioas(struct vdpa_device *vdpa)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (WARN_ON(!vdpa->iommufd_device) || !vdpa->iommufd_attached)
+		return -1;
+
+	iommufd_device_detach(vdpa->iommufd_device);
+	vdpa->iommufd_attached = false;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_detach_ioas);
+
+static void vdpa_emulated_unmap(void *data, unsigned long iova,
+				unsigned long length)
+{
+	struct vdpa_device *vdpa = data;
+	/* todo: need to unmap the iova-lenth in all ASID*/
+
+	//	vdpa->config->dma_unmap(vdpa, 0, iova, length);
+}
+
+static const struct iommufd_access_ops vdpa_user_ops = {
+	.needs_pin_pages = 1,
+	.unmap = vdpa_emulated_unmap,
+};
+
+int vdpa_iommufd_emulated_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	struct iommufd_access *user;
+
+	user = iommufd_access_create(ictx, &vdpa_user_ops, vdpa, out_device_id);
+	if (IS_ERR(user))
+		return PTR_ERR(user);
+	vdpa->iommufd_access = user;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_emulated_bind);
+
+void vdpa_iommufd_emulated_unbind(struct vdpa_device *vdpa)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (vdpa->iommufd_access) {
+		iommufd_access_destroy(vdpa->iommufd_access);
+		vdpa->iommufd_attached = false;
+		vdpa->iommufd_access = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_emulated_unbind);
+
+int vdpa_iommufd_emulated_attach_ioas(struct vdpa_device *vdpa,
+				      u32 *iommufd_ioasid)
+{
+	int rc;
+
+	struct iommufd_access *user;
+
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (vdpa->iommufd_attached) {
+		rc = iommufd_access_replace(vdpa->iommufd_access,
+					    *iommufd_ioasid);
+	} else {
+		rc = iommufd_access_attach(vdpa->iommufd_access,
+					   *iommufd_ioasid);
+	}
+	user = vdpa->iommufd_access;
+
+	if (rc)
+		return rc;
+	vdpa->iommufd_attached = true;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_emulated_attach_ioas);
+
+int vdpa_iommufd_emulated_detach_ioas(struct vdpa_device *vdpa)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (WARN_ON(!vdpa->iommufd_access) || !vdpa->iommufd_attached)
+		return -1;
+
+	iommufd_access_detach(vdpa->iommufd_access);
+	vdpa->iommufd_attached = false;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_emulated_detach_ioas);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f60d5f7bef94..179012e350f9 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -310,6 +310,27 @@ static inline bool vhost_is_little_endian(struct vhost_virtqueue *vq)
 }
 #endif
 
+struct iommufd_ctx;
+struct vdpa_device;
+void vhost_vdpa_lockdep_assert_held(struct vdpa_device *vdpa);
+
+#if IS_ENABLED(CONFIG_IOMMUFD)
+int vdpa_iommufd_bind(struct vdpa_device *vdpa, struct iommufd_ctx *ictx,
+		      u32 *ioas_id, u32 *device_id);
+void vdpa_iommufd_unbind(struct vdpa_device *vdpa);
+#else
+static inline int vdpa_iommufd_bind(struct vdpa_device *vdpa,
+				    struct iommufd_ctx *ictx, u32 *ioas_id,
+				    u32 *device_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void vdpa_iommufd_unbind(struct vdpa_device *vdpa)
+{
+}
+#endif
+
 /* Memory accessors */
 static inline u16 vhost16_to_cpu(struct vhost_virtqueue *vq, __virtio16 val)
 {
-- 
2.34.3


