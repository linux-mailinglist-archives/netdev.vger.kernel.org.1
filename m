Return-Path: <netdev+bounces-55296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19EA80A24A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 12:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAB81C209E4
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F981B289;
	Fri,  8 Dec 2023 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Pew3Hjfb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5096811D;
	Fri,  8 Dec 2023 03:34:30 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8AiJQr000790;
	Fri, 8 Dec 2023 03:34:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=J+wu6sWtXxwW8UvaSbwtuliOpTnsUCd5lCG2Il6qgpE=;
 b=Pew3HjfbzpGmkxY4C9iMwGqwFnJydbfFEm13ESccBKpGOC1zLlaxSFpuGSDZ6FguL/3C
 LavNc9PYwbGRb03m8hNpihGjubeFCH2LRfip50wLqFzybj1sJyOqv1+UvLwC9ZCnVt5o
 W5InbqDEytbW6xCr9orVyKdRILhZXXPqcY153QgIbcVLmauYaTzRraY4dZlyZRB705aj
 eYcjWNx203t0dLQNwk8yezYKBh285wmy6AewkPBYl4NOZa1ArCocX4sVlYpKpgSVUlr9
 TmBAPRwKV3i9Gpy2TXLGaV3G/PAACrO1+1tUAYHZ/gqKe/ecilaayYQyzOpuLue3J0s/ 6g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uv1ncg3q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 03:34:21 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 8 Dec
 2023 03:34:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 8 Dec 2023 03:34:20 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 29A623F70B8;
	Fri,  8 Dec 2023 03:34:15 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH] octeontx2-af: Fix multicast/mirror group lock/unlock issue
Date: Fri, 8 Dec 2023 17:04:13 +0530
Message-ID: <20231208113413.4022029-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Z6jsMhhMtuF0_aAkEnpD0pt43MNTcdis
X-Proofpoint-GUID: Z6jsMhhMtuF0_aAkEnpD0pt43MNTcdis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_06,2023-12-07_01,2023-05-22_02

As per the existing implementation, there exists a race between finding
a multicast/mirror group entry and deleting that entry. The group lock
was taken and released independently by rvu_nix_mcast_find_grp_elem()
function. Which is incorrect and group lock should be taken during the
entire operation of group updation/deletion. This patch fixes the same.

Fixes: 51b2804c19cd ("octeontx2-af: Add new mbox to support multicast/mirror offload")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---

Note: This is a follow up of

https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_netdev_net-2Dnext_c_51b2804c19cd&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=7si3Xn9Ly-Se1a655kvEPIYU0nQ9HPeN280sEUv5ROU&m=NjKPoTkYVlL5Dh4aSr3-dVo-AukiIperlvB0S4_Mqzkyl_VcYAAKrWhkGZE5Cx-p&s=AkBf0454Xm-0adqV0Os7ZE8peaCXtYyuNbCS5kit6Jk&e=

and should apply to net-queue tree.

 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 58 +++++++++++++------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index b01503acd520..0ab5626380c5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -6142,14 +6142,12 @@ static struct nix_mcast_grp_elem *rvu_nix_mcast_find_grp_elem(struct nix_mcast_g
 	struct nix_mcast_grp_elem *iter;
 	bool is_found = false;
 
-	mutex_lock(&mcast_grp->mcast_grp_lock);
 	list_for_each_entry(iter, &mcast_grp->mcast_grp_head, list) {
 		if (iter->mcast_grp_idx == mcast_grp_idx) {
 			is_found = true;
 			break;
 		}
 	}
-	mutex_unlock(&mcast_grp->mcast_grp_lock);
 
 	if (is_found)
 		return iter;
@@ -6162,7 +6160,7 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc, u32 mcast_grp_idx)
 	struct nix_mcast_grp_elem *elem;
 	struct nix_mcast_grp *mcast_grp;
 	struct nix_hw *nix_hw;
-	int blkaddr;
+	int blkaddr, ret;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 	nix_hw = get_nix_hw(rvu->hw, blkaddr);
@@ -6170,11 +6168,15 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc, u32 mcast_grp_idx)
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
 	mcast_grp = &nix_hw->mcast_grp;
+	mutex_lock(&mcast_grp->mcast_grp_lock);
 	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, mcast_grp_idx);
 	if (!elem)
-		return NIX_AF_ERR_INVALID_MCAST_GRP;
+		ret = NIX_AF_ERR_INVALID_MCAST_GRP;
+	else
+		ret = elem->mce_start_index;
 
-	return elem->mce_start_index;
+	mutex_unlock(&mcast_grp->mcast_grp_lock);
+	return ret;
 }
 
 void rvu_nix_mcast_flr_free_entries(struct rvu *rvu, u16 pcifunc)
@@ -6238,7 +6240,7 @@ int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 	struct nix_mcast_grp_elem *elem;
 	struct nix_mcast_grp *mcast_grp;
 	struct nix_hw *nix_hw;
-	int blkaddr;
+	int blkaddr, ret = 0;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 	nix_hw = get_nix_hw(rvu->hw, blkaddr);
@@ -6246,13 +6248,15 @@ int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
 	mcast_grp = &nix_hw->mcast_grp;
+	mutex_lock(&mcast_grp->mcast_grp_lock);
 	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, mcast_grp_idx);
 	if (!elem)
-		return NIX_AF_ERR_INVALID_MCAST_GRP;
-
-	elem->mcam_index = mcam_index;
+		ret = NIX_AF_ERR_INVALID_MCAST_GRP;
+	else
+		elem->mcam_index = mcam_index;
 
-	return 0;
+	mutex_unlock(&mcast_grp->mcast_grp_lock);
+	return ret;
 }
 
 int rvu_mbox_handler_nix_mcast_grp_create(struct rvu *rvu,
@@ -6306,6 +6310,13 @@ int rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
 		return err;
 
 	mcast_grp = &nix_hw->mcast_grp;
+
+	/* If AF is requesting for the deletion,
+	 * then AF is already taking the lock
+	 */
+	if (!req->is_af)
+		mutex_lock(&mcast_grp->mcast_grp_lock);
+
 	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
 	if (!elem)
 		return NIX_AF_ERR_INVALID_MCAST_GRP;
@@ -6333,12 +6344,6 @@ int rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
 	mutex_unlock(&mcast->mce_lock);
 
 delete_grp:
-	/* If AF is requesting for the deletion,
-	 * then AF is already taking the lock
-	 */
-	if (!req->is_af)
-		mutex_lock(&mcast_grp->mcast_grp_lock);
-
 	list_del(&elem->list);
 	kfree(elem);
 	mcast_grp->count--;
@@ -6370,9 +6375,20 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 		return err;
 
 	mcast_grp = &nix_hw->mcast_grp;
+
+	/* If AF is requesting for the updation,
+	 * then AF is already taking the lock
+	 */
+	if (!req->is_af)
+		mutex_lock(&mcast_grp->mcast_grp_lock);
+
 	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
-	if (!elem)
+	if (!elem) {
+		if (!req->is_af)
+			mutex_unlock(&mcast_grp->mcast_grp_lock);
+
 		return NIX_AF_ERR_INVALID_MCAST_GRP;
+	}
 
 	/* If any pcifunc matches the group's pcifunc, then we can
 	 * delete the entire group.
@@ -6383,8 +6399,11 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 				/* Delete group */
 				dreq.hdr.pcifunc = elem->pcifunc;
 				dreq.mcast_grp_idx = elem->mcast_grp_idx;
-				dreq.is_af = req->is_af;
+				dreq.is_af = 1;
 				rvu_mbox_handler_nix_mcast_grp_destroy(rvu, &dreq, NULL);
+				if (!req->is_af)
+					mutex_unlock(&mcast_grp->mcast_grp_lock);
+
 				return 0;
 			}
 		}
@@ -6467,5 +6486,8 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 
 done:
 	mutex_unlock(&mcast->mce_lock);
+	if (!req->is_af)
+		mutex_unlock(&mcast_grp->mcast_grp_lock);
+
 	return ret;
 }
-- 
2.25.1


