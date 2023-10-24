Return-Path: <netdev+bounces-43908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2847D5461
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58740281248
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1E19BB2;
	Tue, 24 Oct 2023 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UyDzgSc6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B556FC8
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:51:55 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F01700;
	Tue, 24 Oct 2023 07:51:53 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OBAkUY025366;
	Tue, 24 Oct 2023 07:51:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Ndvh1aB9dthejQfO+oYbkTOouX5yYrdETKaSV5RkMPU=;
 b=UyDzgSc6p0xaVaSCnpvsnz5mOmOovIMsyXUVVGz28+wm0O9IsbIlcEDbvXO8fPNC1dV9
 uS/+JCbfQiMbqX8KjsAZAB4uhhd1onn/mzgwnpw7vALauX/sKIbNaCTq/MkHvaW5sfwn
 2WtyToSdBNCdqfqR3F4zafXVU+LKTCwHbUUii0fCQed6SXFzsjXPl5koaYmHVY4yAeV4
 k3iP6lp8Ar8IcRDmZGneueg7/L4xZ2WkxMfTMFDwMyCjN5rnBsV62M5u2ZBPqJrf4gi9
 oFLydCVQtjO5NFzTOq7PdaByGk8ZY50b54x6Nx3w5RmGtTmI9JF1K6FpeOgd2RJ6tClb wA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3txcsqrucf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 24 Oct 2023 07:51:39 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 24 Oct
 2023 07:51:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 24 Oct 2023 07:51:37 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id E71CA3F704B;
	Tue, 24 Oct 2023 07:51:36 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy
 Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet
	<edumazet@google.com>
Subject: [PATCH net-next v2 2/4] octeon_ep: remove dma sync in trasmit path
Date: Tue, 24 Oct 2023 07:51:17 -0700
Message-ID: <20231024145119.2366588-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231024145119.2366588-1-srasheed@marvell.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x2E5YogpK_8XHeYHQOcOWUwZohY8Zp6t
X-Proofpoint-GUID: x2E5YogpK_8XHeYHQOcOWUwZohY8Zp6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_14,2023-10-24_01,2023-05-22_02

Cleanup dma sync calls for scatter gather
mappings, since they are coherent allocations
and do not need explicit sync to be called.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Provided more details in changelog
V1: https://lore.kernel.org/all/20231023114449.2362147-2-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 2c86b911a380..1c02304677c9 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -872,9 +872,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 		if (dma_mapping_error(iq->dev, dma))
 			goto dma_map_err;
 
-		dma_sync_single_for_cpu(iq->dev, tx_buffer->sglist_dma,
-					OCTEP_SGLIST_SIZE_PER_PKT,
-					DMA_TO_DEVICE);
 		memset(sglist, 0, OCTEP_SGLIST_SIZE_PER_PKT);
 		sglist[0].len[3] = len;
 		sglist[0].dma_ptr[0] = dma;
@@ -894,10 +891,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 			frag++;
 			si++;
 		}
-		dma_sync_single_for_device(iq->dev, tx_buffer->sglist_dma,
-					   OCTEP_SGLIST_SIZE_PER_PKT,
-					   DMA_TO_DEVICE);
-
 		hw_desc->dptr = tx_buffer->sglist_dma;
 	}
 
-- 
2.25.1


