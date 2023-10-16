Return-Path: <netdev+bounces-41214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3A7CA3F3
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F3CB20CA5
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8931C69C;
	Mon, 16 Oct 2023 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hEMUQXG7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2551C689
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:21:05 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25CE6;
	Mon, 16 Oct 2023 02:21:04 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39FMqfbK002130;
	Mon, 16 Oct 2023 02:20:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=aDkqH3qqGAqawjC5yA0b026nEmhgxqApxWhyZtYmvjQ=;
 b=hEMUQXG7QCO2OOVMteR6YPJVDcCIDBymsegwuJzH8g9lpz2ymHbyd7WumyKnyw6mdc7N
 7Z3Bv/ILegqkKbYd8VSsu+kBxMGh5uuHEI21Y3FZV42NO4AnM2PQSLyAyNY2CGmoEdu2
 r2AewTfNlEoU6eZXiGkgNzmi+ihWAjtfnTu+z+i/NoIicCRbULqimGmzR0oX96R7LgFC
 YCvnsovcgx3/DxxfPFf0MoEl/twxSv+V+lWNE3to02p57GNGEUPGYlPcdhNlyj+7q1ED
 SiSFsGCXgfhkcXn38vZApbV/jRf8IH5s3QYK4BU55KpNiVUM9jKIhdO5YbvW+zO5kiUc BA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tqtgkmnww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 16 Oct 2023 02:20:57 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 16 Oct
 2023 02:20:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 16 Oct 2023 02:20:55 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 9A99B3F7068;
	Mon, 16 Oct 2023 02:20:54 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <horms@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <egallen@redhat.com>, <hgani@marvell.com>, <kuba@kernel.org>,
        <mschmidt@redhat.com>, <netdev@vger.kernel.org>,
        <srasheed@marvell.com>, <sedara@marvell.com>, <vburru@marvell.com>,
        <vimleshk@marvell.com>
Subject: [net-next PATCH v3] octeon_ep: pack hardware structure
Date: Mon, 16 Oct 2023 02:20:51 -0700
Message-ID: <20231016092051.2306831-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rQ3Uxx9A4OP0jyJbrrXnlndqvmzoLGGk
X-Proofpoint-ORIG-GUID: rQ3Uxx9A4OP0jyJbrrXnlndqvmzoLGGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_03,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Clean up structure defines related to hardware data to be
attributed 'packed' in the code, as padding is not allowed
by hardware.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Updated changelog to indicate this is a cleanup
V2: https://lore.kernel.org/all/20231010194026.2284786-1-srasheed@marvell.com/
  - Updated changelog to provide more information
V1: https://lore.kernel.org/all/20231006120225.2259533-1-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_rx.h | 6 +++---
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
index 782a24f27f3e..ca42ddb77491 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.h
@@ -19,7 +19,7 @@
 struct octep_oq_desc_hw {
 	dma_addr_t buffer_ptr;
 	u64 info_ptr;
-};
+} __packed;
 
 #define OCTEP_OQ_DESC_SIZE    (sizeof(struct octep_oq_desc_hw))
 
@@ -38,7 +38,7 @@ struct octep_oq_resp_hw_ext {
 
 	/* checksum verified. */
 	u64 csum_verified:2;
-};
+} __packed;
 
 #define  OCTEP_OQ_RESP_HW_EXT_SIZE   (sizeof(struct octep_oq_resp_hw_ext))
 
@@ -49,7 +49,7 @@ struct octep_oq_resp_hw_ext {
 struct octep_oq_resp_hw {
 	/* The Length of the packet. */
 	__be64 length;
-};
+} __packed;
 
 #define OCTEP_OQ_RESP_HW_SIZE   (sizeof(struct octep_oq_resp_hw))
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 21e75ff9f5e7..74189e5a7d33 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -35,7 +35,7 @@
 struct octep_tx_sglist_desc {
 	u16 len[4];
 	dma_addr_t dma_ptr[4];
-};
+} __packed;
 
 /* Each Scatter/Gather entry sent to hardwar hold four pointers.
  * So, number of entries required is (MAX_SKB_FRAGS + 1)/4, where '+1'
@@ -238,7 +238,7 @@ struct octep_instr_hdr {
 
 	/* Reserved3 */
 	u64 reserved3:1;
-};
+} __packed;
 
 /* Hardware Tx completion response header */
 struct octep_instr_resp_hdr {
@@ -262,7 +262,7 @@ struct octep_instr_resp_hdr {
 
 	/* Opcode for the return packet  */
 	u64 opcode:16;
-};
+} __packed;
 
 /* 64-byte Tx instruction format.
  * Format of instruction for a 64-byte mode input queue.
@@ -292,7 +292,7 @@ struct octep_tx_desc_hw {
 
 	/* Additional headers available in a 64-byte instruction. */
 	u64 exhdr[4];
-};
+} __packed;
 
 #define OCTEP_IQ_DESC_SIZE (sizeof(struct octep_tx_desc_hw))
 #endif /* _OCTEP_TX_H_ */
-- 
2.25.1


