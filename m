Return-Path: <netdev+bounces-47355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF57E9CAA
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D8A1C20954
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB41DDDC;
	Mon, 13 Nov 2023 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D831DA53
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:00:46 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C624C172D;
	Mon, 13 Nov 2023 05:00:44 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4STTvD12YMzMmpm;
	Mon, 13 Nov 2023 20:56:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 21:00:41 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>, Eric Dumazet <edumazet@google.com>
Subject: [PATCH RFC 7/8] net: hns3: temp hack for hns3 to use dmabuf memory provider
Date: Mon, 13 Nov 2023 21:00:39 +0800
Message-ID: <20231113130041.58124-8-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231113130041.58124-1-linyunsheng@huawei.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 06117502001f..43454aa6a279 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3371,6 +3371,8 @@ static int hns3_alloc_buffer(struct hns3_enet_ring *ring,
 	struct page *p;
 
 	if (ring->page_pool) {
+		struct page_pool_iov *ppiov;
+
 		p = page_pool_dev_alloc_frag(ring->page_pool,
 					     &cb->page_offset,
 					     hns3_buf_size(ring));
@@ -3378,7 +3380,8 @@ static int hns3_alloc_buffer(struct hns3_enet_ring *ring,
 			return -ENOMEM;
 
 		cb->priv = p;
-		cb->buf = page_address(p);
+		ppiov = cb->priv;
+		cb->buf = page_address(ppiov->page);
 		cb->dma = page_pool_get_dma_addr(p);
 		cb->type = DESC_TYPE_PP_FRAG;
 		cb->reuse_flag = 0;
@@ -4940,7 +4943,7 @@ static void hns3_put_ring_config(struct hns3_nic_priv *priv)
 static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
 {
 	struct page_pool_params pp_params = {
-		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.flags = 0,//PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order = hns3_page_order(ring),
 		.pool_size = ring->desc_num * hns3_buf_size(ring) /
 				(PAGE_SIZE << hns3_page_order(ring)),
@@ -4949,6 +4952,8 @@ static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
 		.dma_dir = DMA_FROM_DEVICE,
 		.offset = 0,
 		.max_len = PAGE_SIZE << hns3_page_order(ring),
+		.memory_provider = PP_MP_DMABUF_DEVMEM,
+		.mp_priv = &dmabuf_devmem_ops,
 	};
 
 	ring->page_pool = page_pool_create(&pp_params);
-- 
2.33.0


