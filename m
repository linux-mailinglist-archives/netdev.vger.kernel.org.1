Return-Path: <netdev+bounces-45933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC477E073D
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57724281E7D
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E297312B80;
	Fri,  3 Nov 2023 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4TzmZlC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE020B01
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:16:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67401BD
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699031811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vRd7f5G8x90QkHchEr3Lu9idWoM8f/Qc/4n6P4JgvYc=;
	b=D4TzmZlChWlmWWHOHCNSn+9Pu8LBzx9tDdHuQ9AorGQ14JNivoX23dphnipyPpnhiJ8zZx
	wnoNk+0YLK30ZP2gNdehEHV3NisyKShEiXqOfez0oFi/uGo3ZVAErWe0Lzj460ZCSesaQZ
	t2NZqP2SL8wrCwN3mcUfx1szF+ncveU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Ae_BpGh3OHuKUFySfTAznw-1; Fri, 03 Nov 2023 13:16:49 -0400
X-MC-Unique: Ae_BpGh3OHuKUFySfTAznw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CD90848A77;
	Fri,  3 Nov 2023 17:16:48 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2CAA440C6EBC;
	Fri,  3 Nov 2023 17:16:44 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Date: Sat,  4 Nov 2023 01:16:33 +0800
Message-Id: <20231103171641.1703146-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


Hi All
This code provides the iommufd support for vdpa device
This code fixes the bugs from the last version and also add the asid support. rebase on kernel
v6,6-rc3
Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 
I will continue working on it

The kernel code is
https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1

Signed-off-by: Cindy Lu <lulu@redhat.com>


Cindy Lu (8):
  vhost/iommufd: Add the functions support iommufd
  Kconfig: Add the new file vhost/iommufd
  vhost: Add 3 new uapi to support iommufd
  vdpa: Add new vdpa_config_ops to support iommufd
  vdpa_sim :Add support for iommufd
  vdpa: change the map/unmap process to support iommufd
  vp_vdpa::Add support for iommufd
  iommu: expose the function iommu_device_use_default_domain

 drivers/iommu/iommu.c             |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c  |   8 ++
 drivers/vdpa/virtio_pci/vp_vdpa.c |   4 +
 drivers/vhost/Kconfig             |   1 +
 drivers/vhost/Makefile            |   1 +
 drivers/vhost/iommufd.c           | 178 +++++++++++++++++++++++++
 drivers/vhost/vdpa.c              | 210 +++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h             |  21 +++
 include/linux/vdpa.h              |  38 +++++-
 include/uapi/linux/vhost.h        |  66 ++++++++++
 10 files changed, 525 insertions(+), 4 deletions(-)
 create mode 100644 drivers/vhost/iommufd.c

-- 
2.34.3


