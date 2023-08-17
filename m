Return-Path: <netdev+bounces-28392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AADE77F50D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9111280F7E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F1134C6;
	Thu, 17 Aug 2023 11:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D8134A2
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:24:46 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13B30C7;
	Thu, 17 Aug 2023 04:24:45 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H40ZA4017037;
	Thu, 17 Aug 2023 04:24:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=hJBmswclP3HZ5pVllMgW77V8gDB0CnjxxNPnLF0WEVQ=;
 b=CMJn0Lb6UH0wb5pZCzjBPQjHn52oAXehms46zgxHrG30iEXLExf2vzCjx+d34g1AiH1z
 v73cO/V03vv0iHSQaY6Q+okZCVo/GYar5YrdjMmqOIYTWqaw7g4wUmr2o5m7wIzHA70s
 Vm9HprhyMCOQnGyth4eye3AlHDZYlwQTRyP2hFZ95M8K1cjnKWJZSWey3lsGExyH7e8F
 /w2HKyH9VV8k+0xk6ImrROMRQ6Rnh7eHWaNMRx+Oi1TKGBrRMmyuC9Lu7W/kezEINBMh
 Tt65YCiqDUfbJAfIx+GL/atQHV1oIDK2Y+0cxyjpAgPXKJWwocbzJ4KKefUiGcrySBXj cQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sgptkwmg9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 17 Aug 2023 04:24:39 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 04:24:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 17 Aug 2023 04:24:29 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 785E13F705A;
	Thu, 17 Aug 2023 04:24:24 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next Patch 4/5] octeontx2-af: replace generic error codes
Date: Thu, 17 Aug 2023 16:53:56 +0530
Message-ID: <20230817112357.25874-5-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817112357.25874-1-hkelam@marvell.com>
References: <20230817112357.25874-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: usHcW3RgvXgU18efzwl2RUaxtdDWQsxd
X-Proofpoint-GUID: usHcW3RgvXgU18efzwl2RUaxtdDWQsxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-17_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

currently, if any netdev is not mapped to the MAC block(cgx/rpm)
requests MAC feature, AF driver returns a generic error like -EPERM.
This patch replaces generic error codes with driver-specific error
codes for better debugging

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4e3aec7bdbee..c96a94303a54 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -600,7 +600,7 @@ int rvu_mbox_handler_cgx_mac_addr_set(struct rvu *rvu,
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	if (rvu_npc_exact_has_match_table(rvu))
 		return rvu_npc_exact_mac_addr_set(rvu, req, rsp);
@@ -621,7 +621,7 @@ int rvu_mbox_handler_cgx_mac_addr_add(struct rvu *rvu,
 	int rc = 0;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	if (rvu_npc_exact_has_match_table(rvu))
 		return rvu_npc_exact_mac_addr_add(rvu, req, rsp);
@@ -644,7 +644,7 @@ int rvu_mbox_handler_cgx_mac_addr_del(struct rvu *rvu,
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	if (rvu_npc_exact_has_match_table(rvu))
 		return rvu_npc_exact_mac_addr_del(rvu, req, rsp);
@@ -690,7 +690,7 @@ int rvu_mbox_handler_cgx_mac_addr_get(struct rvu *rvu,
 	u64 cfg;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
@@ -709,7 +709,7 @@ int rvu_mbox_handler_cgx_promisc_enable(struct rvu *rvu, struct msg_req *req,
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	/* Disable drop on non hit rule */
 	if (rvu_npc_exact_has_match_table(rvu))
@@ -728,7 +728,7 @@ int rvu_mbox_handler_cgx_promisc_disable(struct rvu *rvu, struct msg_req *req,
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	/* Disable drop on non hit rule */
 	if (rvu_npc_exact_has_match_table(rvu))
@@ -798,7 +798,7 @@ static int rvu_cgx_config_linkevents(struct rvu *rvu, u16 pcifunc, bool en)
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
@@ -836,7 +836,7 @@ int rvu_mbox_handler_cgx_get_linkinfo(struct rvu *rvu, struct msg_req *req,
 	pf = rvu_get_pf(req->hdr.pcifunc);
 
 	if (!is_pf_cgxmapped(rvu, pf))
-		return -ENODEV;
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
@@ -897,7 +897,7 @@ static int rvu_cgx_config_intlbk(struct rvu *rvu, u16 pcifunc, bool en)
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 	mac_ops = get_mac_ops(rvu_cgx_pdata(cgx_id, rvu));
@@ -1100,7 +1100,7 @@ int rvu_mbox_handler_cgx_set_fec_param(struct rvu *rvu,
 	u8 cgx_id, lmac_id;
 
 	if (!is_pf_cgxmapped(rvu, pf))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	if (req->fec == OTX2_FEC_OFF)
 		req->fec = OTX2_FEC_NONE;
@@ -1119,7 +1119,7 @@ int rvu_mbox_handler_cgx_get_aux_link_info(struct rvu *rvu, struct msg_req *req,
 		return LMAC_AF_ERR_FIRMWARE_DATA_NOT_MAPPED;
 
 	if (!is_pf_cgxmapped(rvu, pf))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
@@ -1144,7 +1144,7 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 	void *cgxd;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
 	cgxd = rvu_cgx_pdata(cgx_idx, rvu);
-- 
2.17.1


