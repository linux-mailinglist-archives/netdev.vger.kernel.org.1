Return-Path: <netdev+bounces-45940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247497E0745
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D02281F47
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2724D208D4;
	Fri,  3 Nov 2023 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="du7Vsg27"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B51F92C
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:17:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C0D52
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699031861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpK/Y1O55XislOg5N5jgXt0h6vbPef/n6csAVM8Xygs=;
	b=du7Vsg27mCeJWPwWBDTKsGu2O8ZcEXCnEaKP/jPy33mU8Tn9WyOMrxneRUNUzVRc0Xw6CD
	hYHkbUXXxmOzPZGw8EoQgpKP4njZGf6zniDTB5QToJGV/6cBng8RkpEJ3WQ1/M+hzuCveO
	bxa0iIuOrWlPPOQVpL33Y0KtRu1ZPs0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-44JTi4YMOiuZp0J0ge-3XA-1; Fri,
 03 Nov 2023 13:17:37 -0400
X-MC-Unique: 44JTi4YMOiuZp0J0ge-3XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 775B33826D52;
	Fri,  3 Nov 2023 17:17:32 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54708C15983;
	Fri,  3 Nov 2023 17:17:29 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC v1 6/8] vdpa: change the map/unmap process to support iommufd
Date: Sat,  4 Nov 2023 01:16:39 +0800
Message-Id: <20231103171641.1703146-7-lulu@redhat.com>
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

Add the check for iommufd_ictx,If vdpa don't have the iommufd_ictx
then will use the Legacy iommu domain pathway

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vdpa.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index dfaddd833364..0e2dba59e1ce 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1067,9 +1067,6 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 		/* Legacy iommu domain pathway without IOMMUFD */
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm), GFP_KERNEL);
-	} else {
-		r = iommu_map(v->domain, iova, pa, size,
-			      perm_to_iommu_flags(perm), GFP_KERNEL);
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
@@ -1095,8 +1092,10 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
 	if (ops->set_map) {
 		if (!v->in_batch)
 			ops->set_map(vdpa, asid, iotlb);
+	} else if (!vdpa->iommufd_ictx) {
+		/* Legacy iommu domain pathway without IOMMUFD */
+		iommu_unmap(v->domain, iova, size);
 	}
-
 }
 
 static int vhost_vdpa_va_map(struct vhost_vdpa *v,
@@ -1149,7 +1148,36 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *v,
 
 	return ret;
 }
+#if 0
+int vhost_pin_pages(struct vdpa_device *device, dma_addr_t iova, int npage,
+		    int prot, struct page **pages)
+{
+	if (!pages || !npage)
+		return -EINVAL;
+	//if (!device->config->dma_unmap)
+	//return -EINVAL;
+
+	if (0) { //device->iommufd_access) {
+		int ret;
+
+		if (iova > ULONG_MAX)
+			return -EINVAL;
 
+		ret = iommufd_access_pin_pages(
+			device->iommufd_access, iova, npage * PAGE_SIZE, pages,
+			(prot & IOMMU_WRITE) ? IOMMUFD_ACCESS_RW_WRITE : 0);
+		if (ret) {
+
+			return ret;
+		}
+
+		return npage;
+	} else {
+		return pin_user_pages(iova, npage, prot, pages);
+	}
+	return -EINVAL;
+}
+#endif
 static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			     struct vhost_iotlb *iotlb,
 			     u64 iova, u64 size, u64 uaddr, u32 perm)
@@ -1418,9 +1446,13 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
 	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
 
 	if (v->domain) {
-		iommu_detach_device(v->domain, dma_dev);
+		if (!vdpa->iommufd_ictx) {
+			iommu_detach_device(v->domain, dma_dev);
+		}
 		iommu_domain_free(v->domain);
 	}
+	if (vdpa->iommufd_ictx)
+		vdpa_iommufd_unbind(vdpa);
 
 	v->domain = NULL;
 }
@@ -1645,6 +1677,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	}
 
 	atomic_set(&v->opened, 0);
+	atomic_set(&vdpa->iommufd_users, 0);
 	v->minor = minor;
 	v->vdpa = vdpa;
 	v->nvqs = vdpa->nvqs;
-- 
2.34.3


