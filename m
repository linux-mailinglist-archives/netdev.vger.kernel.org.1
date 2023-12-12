Return-Path: <netdev+bounces-56300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA6180E725
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55E8B20F3D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B245812D;
	Tue, 12 Dec 2023 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D6C1v4Mg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B2C7;
	Tue, 12 Dec 2023 01:16:14 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC7jh3u009842;
	Tue, 12 Dec 2023 01:16:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=8Fi6JKQ6
	hzjc5TlTDLGpAytVBONJviRalvFedjkioj0=; b=D6C1v4MgfuQ6il0V41KGiZJh
	jP2GdC/sJC/8OZIMIHZ8LaK0lH4SlvHju6gJ/AF7VufwoPUp5aHIrMEbS6aYRAQD
	s9egYCd3xv89wmMw1rHDXtT84HGXSGGTkgFU0UBphB85sj6U3ItOuFVufYbSiwII
	0tYj59ZHukadgwd6Mmd9S9PQEnKQuFEN+XCCRpAzdqzl6i5y/CX5jUWVo5AIRTnP
	cxvkE4imJzjZQbkYt3vN81d0sFYQMWbrTevU1cBlXvizmtR4Tv0BkQFxUrptg0hl
	rZL4siUpfEmFIyL2RvVQZugSms6AiPkCvpIFyHmPnXRpNn9DZm5Se6gkjAsB3w==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uwyp4m9n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 01:16:06 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 12 Dec
 2023 01:16:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 12 Dec 2023 01:16:05 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 2BD283F7043;
	Tue, 12 Dec 2023 01:16:00 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH] octeontx2-af: Fix multicast/mirror group lock/unlock issue
Date: Tue, 12 Dec 2023 14:45:58 +0530
Message-ID: <20231212091558.49579-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mdvrYMnmTWV766XtHWctnrpE8w_O9Zp1
X-Proofpoint-GUID: mdvrYMnmTWV766XtHWctnrpE8w_O9Zp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

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


