Return-Path: <netdev+bounces-32777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72579A6AD
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6AC2812D2
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9C8BE6C;
	Mon, 11 Sep 2023 09:23:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424E259B
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:23:29 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0022CD3;
	Mon, 11 Sep 2023 02:23:28 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B9A8Fm007272;
	Mon, 11 Sep 2023 02:23:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=DHPDEUm30XOqJWHB5bdLqHwYVir51jOInyTOTXKxvrQ=;
 b=GMeiMLGMvZufyVf0KgZdujlhaXalS2BY/BJt8FK5QcWB+maSyJkz5pShgdl46vJWEEeu
 d/zEdKlo8SYazFlfyI5/rH1XuDaGQ2cBSUQf6xMZZIkMVvR8ckSCZAEhBrKQBSebspxo
 d8T7gZpdML72XDH8VwaiiHEUBdcwQG19paotUOffnMgC1Sr3btIVsUAV17VfjzIJEdJR
 bl5B+maLYiY6pnxJYdJpKy0921/d7wM+DyUUVk766dK68/KDBAzchIKaQ1wp46DN8MMl
 LUXQh0BXQaxHZ6DIBZa53Q/BvAQ2J+1E64/n6qQbLPYe1ji3ctcd0PFZKJRGNe6Lmmpt +A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3t200qg142-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 02:23:13 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Sep
 2023 02:23:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 11 Sep 2023 02:23:11 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 2FD763F7050;
	Mon, 11 Sep 2023 02:23:11 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hgani@marvell.com>
CC: <vimleshk@marvell.com>, <mschmidt@redhat.com>, <egallen@redhat.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Satananda Burla
	<sburla@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>
Subject: [net PATCH] octeon_ep: fix tx dma unmap len values in SG
Date: Mon, 11 Sep 2023 02:23:06 -0700
Message-ID: <20230911092306.2132794-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EWVnoHvuB1ZQ-3F42Raf4v2gs9wbkDHL
X-Proofpoint-GUID: EWVnoHvuB1ZQ-3F42Raf4v2gs9wbkDHL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Lengths of SG pointers are in big-endian

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
index 5a520d37bea0..7e99486c274b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
@@ -69,12 +69,12 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
 		compl_sg++;
 
 		dma_unmap_single(iq->dev, tx_buffer->sglist[0].dma_ptr[0],
-				 tx_buffer->sglist[0].len[0], DMA_TO_DEVICE);
+				 tx_buffer->sglist[0].len[3], DMA_TO_DEVICE);
 
 		i = 1; /* entry 0 is main skb, unmapped above */
 		while (frags--) {
 			dma_unmap_page(iq->dev, tx_buffer->sglist[i >> 2].dma_ptr[i & 3],
-				       tx_buffer->sglist[i >> 2].len[i & 3], DMA_TO_DEVICE);
+				       tx_buffer->sglist[i >> 2].len[3 - (i & 3)], DMA_TO_DEVICE);
 			i++;
 		}
 
-- 
2.25.1


