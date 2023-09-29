Return-Path: <netdev+bounces-37082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D23B7B383D
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D28D51C20A9F
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A337F41E2E;
	Fri, 29 Sep 2023 17:00:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AE41749
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 17:00:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE1F1B2
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696006846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DCJeFrp8qYTZeCfmhw+2xGRK1u15QgFzTU3UpWyLFHU=;
	b=Ygsx1X2gfhZsH+rffH+Cucq/CtJTstuAw3bfeKDRtJpPhlKz8aMz9yM0aOSxVq24Jev36M
	kP8O9KLIJzh/lEBCRMxc48GcAIMuWXhPj73ANdvSvnHE0WulKt/1vAf9lwLCcrF7FpH6W6
	KkN+k3/2g6qwytS0WGJHhg7DzFkHsX4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-T6krj4_AO0GgR-xDnZaiLg-1; Fri, 29 Sep 2023 13:00:44 -0400
X-MC-Unique: T6krj4_AO0GgR-xDnZaiLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64E673C025CE;
	Fri, 29 Sep 2023 17:00:41 +0000 (UTC)
Received: from rhel-developer-toolbox.redhat.com (unknown [10.2.16.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9EB3EC15BB8;
	Fri, 29 Sep 2023 17:00:39 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Rasesh Mody <rmody@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Cc: Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
Date: Fri, 29 Sep 2023 10:00:20 -0700
Message-ID: <20230929170023.1020032-1-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

During bnx2i iSCSI testing we ran into page refcounting issues in the
uio mmaps exported from cnic to the iscsiuio process, and bisected back
to the removal of the __GFP_COMP flag from dma_alloc_coherent calls.

In order to fix these drivers to be able to mmap dma coherent memory via
a uio device, without resorting to hacks and working with an iommu
enabled, introduce a new uio mmap type backed by dma_mmap_coherent.

While converting the uio interface, I also noticed that not all of these
allocations were PAGE_SIZE aligned. Particularly the bnx2/bnx2x status
block mapping was much smaller than any architecture page size, and I
was concerned that it could be unintentionally exposing kernel memory.

Chris Leech (3):
  uio: introduce UIO_DMA_COHERENT type
  cnic. bnx2, bnx2x: page align uio mmap allocations
  cnic, bnx2, bnx2x: use UIO_MEM_DMA_COHERENT

 drivers/net/ethernet/broadcom/bnx2.c          |  2 ++
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 10 +++---
 drivers/net/ethernet/broadcom/cnic.c          | 34 ++++++++++++-------
 drivers/net/ethernet/broadcom/cnic.h          |  1 +
 drivers/net/ethernet/broadcom/cnic_if.h       |  1 +
 drivers/uio/uio.c                             | 34 +++++++++++++++++++
 include/linux/uio_driver.h                    | 12 +++++--
 7 files changed, 75 insertions(+), 19 deletions(-)

-- 
2.41.0


