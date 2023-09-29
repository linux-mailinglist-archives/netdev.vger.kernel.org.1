Return-Path: <netdev+bounces-36985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5967B2CEE
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 09:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 06270283489
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98BC152;
	Fri, 29 Sep 2023 07:16:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B7C134
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:16:50 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4C1A5;
	Fri, 29 Sep 2023 00:16:49 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T273h4031713;
	Fri, 29 Sep 2023 00:16:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=94RtpFu51Ce5agGkfbtbnsnDmNdp9psxf+FTLCufXXY=;
 b=h6keprQb3WE56XxTFf55Q563E5lBPCmj/N4hihsZKRFVnagS2LtTbyq9mwX8mxiKnEht
 A1rUWYfPe+6ef6sWQ3xY+LkgKJ2K4s5gKECAuCjBm7fb4mME15edacpIKVIYAW/3o84X
 bAPuLPijcT7/L+O3prVS0UAOCyWvNkuJrKLTnAKf2i8MjTewEaib3p7u2EcBl4Q8qDGi
 PuD2S7+6gGeC3zPqu86SjBpnYJbeLmkMQAWP5hAbj2Y65D3dE3K6b9hyzX4aG993SJxq
 JVCtcVs+8eADN315gmSq8/WRlR/lmEnQDRqNFZJibG2ievX3Sp6fk0n8ow9FXZAgxAEJ jg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3td7y6v6gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 29 Sep 2023 00:16:34 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Sep
 2023 00:16:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 29 Sep 2023 00:16:32 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
	by maili.marvell.com (Postfix) with ESMTP id 231A65B6924;
	Fri, 29 Sep 2023 00:16:27 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <richardcochran@gmail.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net PATCH] octeontx2-af: Enable hardware timestamping for VFs
Date: Fri, 29 Sep 2023 12:46:21 +0530
Message-ID: <20230929071621.853570-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IkEsf7q0yY4W_9T_Gnb3yaF683iI2_ke
X-Proofpoint-GUID: IkEsf7q0yY4W_9T_Gnb3yaF683iI2_ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_05,2023-09-28_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently for VFs, mailbox returns error when hardware timestamping enable
is requested. This patch fixes this issue.

Fixes: 421572175ba5 ("octeontx2-af: Support to enable/disable HW timestamping")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index f2b1edf1bb43..aba0c530160c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -756,12 +756,11 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
 	if (!is_mac_feature_supported(rvu, pf, RVU_LMAC_FEAT_PTP))
 		return 0;
 
-	/* This msg is expected only from PFs that are mapped to CGX LMACs,
+	/* This msg is expected only from PFs that are mapped to CGX/RPM LMACs,
 	 * if received from other PF/VF simply ACK, nothing to do.
 	 */
-	if ((pcifunc & RVU_PFVF_FUNC_MASK) ||
-	    !is_pf_cgxmapped(rvu, pf))
-		return -ENODEV;
+	if (!is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc)))
+		return -EPERM;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 	cgxd = rvu_cgx_pdata(cgx_id, rvu);
-- 
2.25.1


