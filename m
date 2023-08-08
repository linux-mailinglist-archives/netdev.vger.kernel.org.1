Return-Path: <netdev+bounces-25464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE1774364
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2333F28172A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C6154B4;
	Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E5154A2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F9A798;
	Tue,  8 Aug 2023 10:08:42 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378A8kv1028961;
	Tue, 8 Aug 2023 04:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=/KczjdWXBqcacQStwDVxBoq896dhu2pYE9pTKn9oB9U=;
 b=DY4gzrroDMnlyTsCoOg/Y7WFA3OC1YSRZbrUSqBKKMPtPfM4oRtGv2H7ZWa7L/M+CmdL
 2DXOu+XDLqrdT/tKUQYkAMRmW/JsYtvq3fPOsTgdWc5C5YsBYep92BzOgCAyZfutG0X9
 FHN46gm0Uo2IJz1yQleCSqprVQe1YnF5CXGU/Pj1ruR8bSLUa25hxOz4BTiNYGeahLOe
 hmSNG0BMFItvz3GHUOL2wlvGXfdUQ7DtYIxiy6qGADF1PoAgowE5zeyX9qeql79G+GhF
 BVx4DanRZ7udtUZa0XUDx66AC4YdSMKxqxz58GSqsKYc21DfNM9thQTFj/L6imoSrn+6 Hw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntg7mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 04:27:29 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 8 Aug
 2023 04:27:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 8 Aug 2023 04:27:27 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 7B17A3F7045;
	Tue,  8 Aug 2023 04:27:22 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 2/3] octeontx2-pf: Fix PFC TX scheduler free
Date: Tue, 8 Aug 2023 16:57:07 +0530
Message-ID: <20230808112708.3179218-3-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808112708.3179218-1-sumang@marvell.com>
References: <20230808112708.3179218-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eS4NXuSJoSW2m5x_67yFXByO4XI6-D43
X-Proofpoint-ORIG-GUID: eS4NXuSJoSW2m5x_67yFXByO4XI6-D43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_09,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

During PFC TX schedulers free, flag TXSCHQ_FREE_ALL was being set
which caused free up all schedulers other than the PFC schedulers.
This patch fixes that to free only the PFC Tx schedulers.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index d54edfa8fcc9..c75435bab411 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -125,19 +125,12 @@ int otx2_pfc_txschq_alloc(struct otx2_nic *pfvf)
 
 static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 {
-	struct nix_txsch_free_req *free_req;
+	int lvl;
 
-	mutex_lock(&pfvf->mbox.lock);
 	/* free PFC TLx nodes */
-	free_req = otx2_mbox_alloc_msg_nix_txsch_free(&pfvf->mbox);
-	if (!free_req) {
-		mutex_unlock(&pfvf->mbox.lock);
-		return -ENOMEM;
-	}
-
-	free_req->flags = TXSCHQ_FREE_ALL;
-	otx2_sync_mbox_msg(&pfvf->mbox);
-	mutex_unlock(&pfvf->mbox.lock);
+	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
+		otx2_txschq_free_one(pfvf, lvl,
+				     pfvf->pfc_schq_list[lvl][prio]);
 
 	pfvf->pfc_alloc_status[prio] = false;
 	return 0;
-- 
2.25.1


