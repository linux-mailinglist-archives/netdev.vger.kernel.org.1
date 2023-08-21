Return-Path: <netdev+bounces-29225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A6782328
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 07:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92740280DF0
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 05:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF14186F;
	Mon, 21 Aug 2023 05:25:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310511841
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 05:25:52 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D2A3;
	Sun, 20 Aug 2023 22:25:51 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KMF7fs017878;
	Sun, 20 Aug 2023 22:25:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=bzBEdiFZRb0jxcT/TEECbiAx7DDEP3WAKgANQVDaT9g=;
 b=BCeC1i6ZhpNmg+Gq6E4j3ovQ2+kSMI3KFpqe7eP9rnXTzcvcwrOBzC1QWRDBOp7CHkXM
 IIehiUslc5nLe4n77+eVF/tQUYJuLQ1njU1y7+B+ED33WrNu3TypeCvVvRjPjpXqRa7J
 5kionLbJ8wnGROplhZOY5V9RVd8mpkzchnw2HUK/FmBg07eVNUS9UsnfHLSD2ZtIYTTX
 QKEz/GXYMTBJaz9fIu9NbpU5Hdh39ZMa9J6AaLoT6X2PwJdzqs+FbUMdypQiXEBh2FE5
 v/CPI3YuMZXk+hPCTrKBSZrTTwGDaDkQOaMTpyc/3N5iuHszb3Q8swqqwncQAcHmIAWm 9w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sju3qksb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 20 Aug 2023 22:25:41 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 20 Aug
 2023 22:25:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 20 Aug 2023 22:25:40 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 084F53F7081;
	Sun, 20 Aug 2023 22:25:35 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V3 3/3] cteonxt2-pf: Fix backpressure config for multiple PFC priorities to work simultaneously
Date: Mon, 21 Aug 2023 10:55:16 +0530
Message-ID: <20230821052516.398572-4-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821052516.398572-1-sumang@marvell.com>
References: <20230821052516.398572-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: trVEEjHcVrjMIWPkC4mXcjuVbO50Xq1x
X-Proofpoint-ORIG-GUID: trVEEjHcVrjMIWPkC4mXcjuVbO50Xq1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

MAC (CGX or RPM) asserts backpressure at TL3 or TL2 node of the egress
hierarchical scheduler tree depending on link level config done. If
there are multiple PFC priorities enabled at a time and for all such
flows to backoff, each priority will have to assert backpressure at
different TL3/TL2 scheduler nodes and these flows will need to submit
egress pkts to these nodes.

Current PFC configuration has an issue where in only one backpressure
scheduler node is being allocated which is resulting in only one PFC
priority to work. This patch fixes this issue.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index 6492749dd7c8..bfddbff7bcdf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -70,7 +70,7 @@ static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 	 * link config level. These rest of the scheduler can be
 	 * same as hw.txschq_list.
 	 */
-	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
+	for (lvl = 0; lvl <= pfvf->hw.txschq_link_cfg_lvl; lvl++)
 		req->schq[lvl] = 1;
 
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
@@ -83,7 +83,7 @@ static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 		return PTR_ERR(rsp);
 
 	/* Setup transmit scheduler list */
-	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++) {
+	for (lvl = 0; lvl <= pfvf->hw.txschq_link_cfg_lvl; lvl++) {
 		if (!rsp->schq[lvl])
 			return -ENOSPC;
 
@@ -128,7 +128,7 @@ static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 	int lvl;
 
 	/* free PFC TLx nodes */
-	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
+	for (lvl = 0; lvl <= pfvf->hw.txschq_link_cfg_lvl; lvl++)
 		otx2_txschq_free_one(pfvf, lvl,
 				     pfvf->pfc_schq_list[lvl][prio]);
 
-- 
2.25.1


