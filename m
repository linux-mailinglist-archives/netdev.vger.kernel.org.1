Return-Path: <netdev+bounces-35986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365497AC3D2
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 61D33281795
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 17:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F120B0D;
	Sat, 23 Sep 2023 17:06:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B8208D6
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 17:06:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E53F1A7
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695488798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0foaQUJDnKYeTXBZ0CfBrMz9PTwxeVPI+eHRfhl6x0E=;
	b=dGUVrAL5d4NpzoT6GUVK0GkW69itdIgNIqfaCJYB7OGBC/f2oS9QoIfJcDqybwYmidtcym
	7Btp33n+sYI7KXekR2QR+MU0M5OrA+yexkoaaXCVs9rqnM+cTIht/lY2iqKt9ARW+bJfIH
	SSLie/RqvvfXcdhDqAKkMDwkxgaaUh4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-0ElBDspMNB2imCymtZ9AEQ-1; Sat, 23 Sep 2023 13:06:35 -0400
X-MC-Unique: 0ElBDspMNB2imCymtZ9AEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB3111C05135;
	Sat, 23 Sep 2023 17:06:34 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A474F2156701;
	Sat, 23 Sep 2023 17:06:31 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC 7/7] iommufd: Skip the CACHE_COHERENCY and iommu group check
Date: Sun, 24 Sep 2023 01:05:40 +0800
Message-Id: <20230923170540.1447301-8-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is just the work arround for vdpa, I Will
fix these problems in the next version.

Skip these 2 checks:
1.IOMMU_CAP_CACHE_COHERENCY check
2.iommu_group_get check

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/iommu/iommufd/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index f7cb353fd9c7..0224d751f503 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -71,8 +71,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	 * to restore cache coherency.
 	 */
 	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
-		return ERR_PTR(-EINVAL);
-
+		//return ERR_PTR(-EINVAL);
+#if 0
 	group = iommu_group_get(dev);
 	if (!group)
 		return ERR_PTR(-ENODEV);
@@ -80,7 +80,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	rc = iommu_device_claim_dma_owner(dev, ictx);
 	if (rc)
 		goto out_group_put;
-
+#endif
 	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
 	if (IS_ERR(idev)) {
 		rc = PTR_ERR(idev);
-- 
2.34.3


