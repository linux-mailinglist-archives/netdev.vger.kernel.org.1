Return-Path: <netdev+bounces-40715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB37C8694
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E191C209E0
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3E415E84;
	Fri, 13 Oct 2023 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gYgfB/M5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CF613A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 13:18:49 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D0BD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 06:18:48 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DCrNEW010073;
	Fri, 13 Oct 2023 06:18:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pfpt0220;
 bh=T+FKWK5R07Gk28yMeWRIKSSnTmPYZUsIKg+p/bDJT8w=;
 b=gYgfB/M5vw0P3CwT9dR0F99hZ+8yIYDiRPy3K3sG+Z8hhG5sKIe3jt9O3RH0kfOE6EUF
 vE+Gpx4DNu7pfEUxB5Xdw9JQYS7Vut5frap8oyrPJ0BTC6oDFeHYMMhcI3v+l0Ft8ifX
 PLzpjXcOGHiIxOF5KoAkQQVADOvIpdGw652bHDFQygEzS1CN8lhhm2GLsiX8kGwTju4M
 TFIsI85gOifcgSaEd/CGUExa960OLfTUdcP2qxe0OJQdyFkB/8+qNFBVMmNzk7Z7lFSV
 LO9mc7WvmaJ0iKicFWE+YJkV4aNoFELRcmpwcTG6wNY5xlNjgqxafzyYzGFVnLUrV3UC DA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tpt16jcba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 06:18:25 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 13 Oct
 2023 06:18:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 13 Oct 2023 06:18:23 -0700
Received: from falcon.marvell.com (unknown [10.30.46.95])
	by maili.marvell.com (Postfix) with ESMTP id 3D5763F704F;
	Fri, 13 Oct 2023 06:18:18 -0700 (PDT)
From: Manish Chopra <manishc@marvell.com>
To: <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <aelior@marvell.com>, <palok@marvell.com>,
        <njavali@marvell.com>, <skashyap@marvell.com>, <jmeneghi@redhat.com>,
        <pabeni@redhat.com>, <cleech@redhat.com>, <edumazet@google.com>,
        <horms@kernel.org>, <Yuval.Mintz@caviumnetworks.com>,
        <Ram.Amrani@caviumnetworks.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH net] qed: fix LL2 RX buffer allocation
Date: Fri, 13 Oct 2023 18:48:12 +0530
Message-ID: <20231013131812.873331-1-manishc@marvell.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ttL8H9toQfHwE2gwBK3gJDF_I2j0kH6M
X-Proofpoint-ORIG-GUID: ttL8H9toQfHwE2gwBK3gJDF_I2j0kH6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_04,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Driver allocates the LL2 rx buffers from kmalloc()
area to construct the skb using slab_build_skb()

The required size allocation seems to have overlooked
for accounting both skb_shared_info size and device
placement padding bytes which results into the below
panic when doing skb_put() for a standard MTU sized frame.

skbuff: skb_over_panic: text:ffffffffc0b0225f len:1514 put:1514
head:ff3dabceaf39c000 data:ff3dabceaf39c042 tail:0x62c end:0x566
dev:<NULL>
…
skb_panic+0x48/0x4a
skb_put.cold+0x10/0x10
qed_ll2b_complete_rx_packet+0x14f/0x260 [qed]
qed_ll2_rxq_handle_completion.constprop.0+0x169/0x200 [qed]
qed_ll2_rxq_completion+0xba/0x320 [qed]
qed_int_sp_dpc+0x1a7/0x1e0 [qed]

This patch fixes this by accouting skb_shared_info and device
placement padding size bytes when allocating the buffers.

Cc: David S. Miller <davem@davemloft.net>
Fixes: 0a7fb11c23c0 ("qed: Add Light L2 support")
Signed-off-by: Manish Chopra <manishc@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index 717a0b3f89bd..ab5ef254a748 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -113,7 +113,10 @@ static void qed_ll2b_complete_tx_packet(void *cxt,
 static int qed_ll2_alloc_buffer(struct qed_dev *cdev,
 				u8 **data, dma_addr_t *phys_addr)
 {
-	*data = kmalloc(cdev->ll2->rx_size, GFP_ATOMIC);
+	size_t size = cdev->ll2->rx_size + NET_SKB_PAD +
+		      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	*data = kmalloc(size, GFP_ATOMIC);
 	if (!(*data)) {
 		DP_INFO(cdev, "Failed to allocate LL2 buffer data\n");
 		return -ENOMEM;
@@ -2589,7 +2592,7 @@ static int qed_ll2_start(struct qed_dev *cdev, struct qed_ll2_params *params)
 	INIT_LIST_HEAD(&cdev->ll2->list);
 	spin_lock_init(&cdev->ll2->lock);
 
-	cdev->ll2->rx_size = NET_SKB_PAD + ETH_HLEN +
+	cdev->ll2->rx_size = PRM_DMA_PAD_BYTES_NUM + ETH_HLEN +
 			     L1_CACHE_BYTES + params->mtu;
 
 	/* Allocate memory for LL2.
-- 
2.27.0


