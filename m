Return-Path: <netdev+bounces-98705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F98D222D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735A4284457
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E64174EE3;
	Tue, 28 May 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PfNO/IvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB19174ED4
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916204; cv=none; b=SRgoGiKxna6vn4qDH+EKGqRKiB3/DSUoammfQP+V5PoR+zxbfgZpVjsILYs4mNmL5Y8i8MKzOHAiblSN7g1jChkBlcnUG/vwpmEtaSGfwS60+L3hDxQW3MdT7hB2w2RZ62sSPanwu6Qp6fRHozCib8tT+9Jq4T2H4XbwWA78i+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916204; c=relaxed/simple;
	bh=mmcsYfrgnmh97KMioSBAuAqqqiB3fq5Qi6gFUD9xAjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TlFcbmMspizrt78KtY69tPKzCTsy5BB7I0jCAPnDJ9MvbXdlJFIqUS3k4THT9QGsTF79vi3cfU7xvVkdkTkkwjfFs3NCkpHhrsdPorCzYK5/sII3OoyRUZPo+HwRJYMnrL7Md29mGDboTBEdch/ubP+yFBd3xoctzYYEcuMc3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PfNO/IvM; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716916203; x=1748452203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=01OgBL+/0F5O8aoD6867YUsppEv2W5xiq/MSiXVmwFU=;
  b=PfNO/IvMxWVavsP5B+aIWIUG8+O5gfT4ELggxjlvwGJGGrLwPCAjkjuO
   HNFsuwfa/S7cLuJhtgQo7swsPOFuWU+qrzE7aLSndgr9VEsd7+hveh2tE
   bafIgUOLfnv0vp2zdT+DHPRPzkDQlzXpSromFGIi+cL9ATE7tuZjw8uI9
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,196,1712620800"; 
   d="scan'208";a="299232992"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 17:09:56 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:8012]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.29.8:2525] with esmtp (Farcaster)
 id 3acf4d31-6dc9-412e-ba66-a19736672019; Tue, 28 May 2024 17:09:55 +0000 (UTC)
X-Farcaster-Flow-ID: 3acf4d31-6dc9-412e-ba66-a19736672019
Received: from EX19D028EUB003.ant.amazon.com (10.252.61.31) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 28 May 2024 17:09:55 +0000
Received: from u95c7fd9b18a35b.ant.amazon.com (10.85.143.174) by
 EX19D028EUB003.ant.amazon.com (10.252.61.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 28 May 2024 17:09:46 +0000
From: Shay Agroskin <shayagr@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Shay Agroskin <shayagr@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Arinzon, David" <darinzon@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v1 net] net: ena: Fix redundant device NUMA node override
Date: Tue, 28 May 2024 20:09:12 +0300
Message-ID: <20240528170912.1204417-1-shayagr@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D028EUB003.ant.amazon.com (10.252.61.31)

The driver overrides the NUMA node id of the device regardless of
whether it knows its correct value (often setting it to -1 even though
the node id is advertised in 'struct device'). This can lead to
suboptimal configurations.

This patch fixes this behavior and makes the shared memory allocation
functions use the NUMA node id advertised by the underlying device.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 2d8a66ea82fa..713a595370bf 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -312,7 +312,6 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 			      struct ena_com_io_sq *io_sq)
 {
 	size_t size;
-	int dev_node = 0;
 
 	memset(&io_sq->desc_addr, 0x0, sizeof(io_sq->desc_addr));
 
@@ -325,12 +324,9 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 	size = io_sq->desc_entry_size * io_sq->q_depth;
 
 	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_HOST) {
-		dev_node = dev_to_node(ena_dev->dmadev);
-		set_dev_node(ena_dev->dmadev, ctx->numa_node);
 		io_sq->desc_addr.virt_addr =
 			dma_alloc_coherent(ena_dev->dmadev, size, &io_sq->desc_addr.phys_addr,
 					   GFP_KERNEL);
-		set_dev_node(ena_dev->dmadev, dev_node);
 		if (!io_sq->desc_addr.virt_addr) {
 			io_sq->desc_addr.virt_addr =
 				dma_alloc_coherent(ena_dev->dmadev, size,
@@ -354,10 +350,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 		size = (size_t)io_sq->bounce_buf_ctrl.buffer_size *
 			io_sq->bounce_buf_ctrl.buffers_num;
 
-		dev_node = dev_to_node(ena_dev->dmadev);
-		set_dev_node(ena_dev->dmadev, ctx->numa_node);
 		io_sq->bounce_buf_ctrl.base_buffer = devm_kzalloc(ena_dev->dmadev, size, GFP_KERNEL);
-		set_dev_node(ena_dev->dmadev, dev_node);
 		if (!io_sq->bounce_buf_ctrl.base_buffer)
 			io_sq->bounce_buf_ctrl.base_buffer =
 				devm_kzalloc(ena_dev->dmadev, size, GFP_KERNEL);
@@ -397,7 +390,6 @@ static int ena_com_init_io_cq(struct ena_com_dev *ena_dev,
 			      struct ena_com_io_cq *io_cq)
 {
 	size_t size;
-	int prev_node = 0;
 
 	memset(&io_cq->cdesc_addr, 0x0, sizeof(io_cq->cdesc_addr));
 
@@ -409,11 +401,8 @@ static int ena_com_init_io_cq(struct ena_com_dev *ena_dev,
 
 	size = io_cq->cdesc_entry_size_in_bytes * io_cq->q_depth;
 
-	prev_node = dev_to_node(ena_dev->dmadev);
-	set_dev_node(ena_dev->dmadev, ctx->numa_node);
 	io_cq->cdesc_addr.virt_addr =
 		dma_alloc_coherent(ena_dev->dmadev, size, &io_cq->cdesc_addr.phys_addr, GFP_KERNEL);
-	set_dev_node(ena_dev->dmadev, prev_node);
 	if (!io_cq->cdesc_addr.virt_addr) {
 		io_cq->cdesc_addr.virt_addr =
 			dma_alloc_coherent(ena_dev->dmadev, size, &io_cq->cdesc_addr.phys_addr,
-- 
2.34.1


