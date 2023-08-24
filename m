Return-Path: <netdev+bounces-30254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4277869C5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760592814E2
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CB5699;
	Thu, 24 Aug 2023 08:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD32455E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:11:57 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122992126;
	Thu, 24 Aug 2023 01:11:27 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NJp2KN006892;
	Thu, 24 Aug 2023 01:10:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=9Y4Kfj2q2Akq1LHUrF83CVtB9vCk1LhweLSCZqGDNUk=;
 b=AQh+5visWV/9fDk07e0aR0gf46KzGwMW33OJQ7/UT3eBnoVIZUbgE1p5tnK6p/ySMWkC
 updVZcujpBdd5eL7cL3DZArAT4aFd77KzACG5jIwe57OAo5pfnhLLjB3VCNrZIC5CVRY
 3UbaXAKP4Bp+ttobIGrNR47Kr3sZZh13whJsPiVni3ISKOempZOjcPHBKTFZg1/f0SGI
 gGmNv9xMJ3Osyy25/Cq5ocJeVmuNTS0n2imttyDSWKP7/6CiSxxM9Aclk52uRTe+DIJR
 zjH/fTZ+Wn2Eukcdg8yJX+UvZk5LznbOkJHjWLO70JarUrI/JYAV6kYh1b7VEPzgOKaI Sg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3snrmcsv8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 24 Aug 2023 01:10:47 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 24 Aug
 2023 01:10:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 24 Aug 2023 01:10:45 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 623F23F7060;
	Thu, 24 Aug 2023 01:10:41 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V4 1/3] octeontx2-pf: Fix PFC TX scheduler free
Date: Thu, 24 Aug 2023 13:40:30 +0530
Message-ID: <20230824081032.436432-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230824081032.436432-1-sumang@marvell.com>
References: <20230824081032.436432-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jtbzRgp97mzRibJffaAGpAn-i_2VTn5z
X-Proofpoint-ORIG-GUID: jtbzRgp97mzRibJffaAGpAn-i_2VTn5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_05,2023-08-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

During PFC TX schedulers free, flag TXSCHQ_FREE_ALL was being set
which caused free up all schedulers other than the PFC schedulers.
This patch fixes that to free only the PFC Tx schedulers.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c  |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 15 ++++-----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 77c8f650f7ac..289371b8ce4f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -804,6 +804,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq)
 
 	mutex_unlock(&pfvf->mbox.lock);
 }
+EXPORT_SYMBOL(otx2_txschq_free_one);
 
 void otx2_txschq_stop(struct otx2_nic *pfvf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index ccaf97bb1ce0..6492749dd7c8 100644
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


