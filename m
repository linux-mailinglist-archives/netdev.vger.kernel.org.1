Return-Path: <netdev+bounces-33009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A379C381
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 05:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2249F1C2095F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066114ABE;
	Tue, 12 Sep 2023 03:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EE5247
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:00:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE1162911B
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694487624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hXx0uPfpQ2OseSGqC6KpCXLbCPjx1dHAmP+3Zup+enc=;
	b=hGNb8Q9HV3bR2Ure65hm+YKjk2Z4TkPtrymyZzIVl11sa4dxghPrCmxrve+R5t3kTplOgT
	ZcLjZuXVaisITNZL2voa6BvvWayw75KPhdfUr4RmsXsfDcEPe8xdR5d1UKVdHFW2pHlCBd
	MeRF/VTS0tP44o0hhThhLUu3CgjSY1k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-dX0xmJGyOVWLsQw3fKnJug-1; Mon, 11 Sep 2023 23:00:20 -0400
X-MC-Unique: dX0xmJGyOVWLsQw3fKnJug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 200C13C0D842;
	Tue, 12 Sep 2023 03:00:20 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 044E240C6EA8;
	Tue, 12 Sep 2023 03:00:15 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	maxime.coquelin@redhat.com,
	xieyongji@bytedance.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [RFC v2 0/4] Support reconnection in vduse
Date: Tue, 12 Sep 2023 11:00:04 +0800
Message-Id: <20230912030008.3599514-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2

These patches add the reconnect support in vduse, The steps
is map the pages from kernel to userspace, userspace    
app will sync the reconnection status and vq_info in the pages
Also, add the new IOCTL VDUSE_GET_RECONNECT_INFO
userspace app will use this information to mmap the memory

Will send the patch for DPDK later

Tested in vduse + dpdk test-pmd
 
Signed-off-by: Cindy Lu <lulu@redhat.com>

Cindy Lu (4):
  vduse: Add function to get/free the pages for reconnection
  vduse: Add file operation for mmap
  vduse: update the vq_info in ioctl
  vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO

 drivers/vdpa/vdpa_user/vduse_dev.c | 177 +++++++++++++++++++++++++++++
 include/uapi/linux/vduse.h         |  21 ++++
 2 files changed, 198 insertions(+)

-- 
2.34.3


