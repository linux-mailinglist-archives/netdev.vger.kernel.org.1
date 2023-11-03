Return-Path: <netdev+bounces-45941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076F17E0749
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36EB281E89
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2F20309;
	Fri,  3 Nov 2023 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+AJRNMW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B901F92C
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:18:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F010CF
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699031887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCTB8Gg9xttEfEVtECz9fqwzez2GQHqNSW6hXp3Vsbk=;
	b=K+AJRNMWUq52CW31BiS0fG8SoJ0LMbani3aUuY2EeVU4lld6UT6sIEUj+2k8CRaz9T5gHQ
	spIrXHgPYxi9TNPCGqt0avgMWHEjojLnqSzZ6TFQ3rB+A9yqbQr2T4Fi/ghYrtKGrRJySd
	06oljP2sEXWCfOiYfi4uxm6lKR12hr4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-HmhpnDUUNMKaWArsODPEXQ-1; Fri,
 03 Nov 2023 13:18:02 -0400
X-MC-Unique: HmhpnDUUNMKaWArsODPEXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 902D33C16DDC;
	Fri,  3 Nov 2023 17:18:01 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63D381121309;
	Fri,  3 Nov 2023 17:17:58 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
Date: Sat,  4 Nov 2023 01:16:41 +0800
Message-Id: <20231103171641.1703146-9-lulu@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Expose the function iommu_device_use_default_domain() and
iommu_device_unuse_default_domain()，
While vdpa bind the iommufd device and detach the iommu device,
vdpa need to call the function
iommu_device_unuse_default_domain() to release the owner

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3bfc56df4f78..987cbf8c9a87 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
 
 /**
  * iommu_device_unuse_default_domain() - Device driver stops handling device
@@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct device *dev)
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 }
+EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
-- 
2.34.3


