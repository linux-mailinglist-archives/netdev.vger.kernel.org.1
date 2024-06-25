Return-Path: <netdev+bounces-106608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB9B916F5C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923E82819EC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E231B17C7BC;
	Tue, 25 Jun 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lOdJ5v3e"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7517C22E;
	Tue, 25 Jun 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336875; cv=none; b=abb+P9/TZq7fZeI2Rf4cdqUyxf9UE8TUyDGp1srP/PLQM5RxpCwNnwjE5BurswGy7izXPRnNC8XZCI3hvkOaTLoOKy9PHBGwGzC9LyNHD64rF4kp7B0LqNAmEbdVt2Emd73IbysgbCDtMzFyFKyX13XqyTywk9ObdfcTGJIlDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336875; c=relaxed/simple;
	bh=hvGT5beqd6zcscaM+wWtmLJHdZpsSAaD+im5Cy6EvUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfiWe2f6giUxzoHqvGK2jg5wGqKudmr/QonoG7U0IqZK/edYaTduOTJUxv1Xp3BbOAa0VHAkxbsNvDprOisjk3oIlhlmPbn+Bs2VhQHY58WUN61VKLzsOpnIRuG1l02fCmVGudXWU58XM4/3DaooYpsHMiNtgzWR74iMNSrJ/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lOdJ5v3e; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBtVrx001297;
	Tue, 25 Jun 2024 10:34:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	bJ56PEwoRp+pBAkCSxAOW4s80RXzc1NpktITW1IilU=; b=lOdJ5v3eJUEY4SVfy
	CK7/MFPlPvGtVp8wOGrsog/+aVt1r8q6OLQcPMZdah/kTERe2qG7XgXYHeJOv33t
	N7clVNVWZj0Ud9pGD2o4tbTHJRzcneIc9KvXWrhQjraD/Y4TCQj8KvoMbDTe7Mzj
	w1VKMc5YIM+vvk+NWmsOVB+aRjEjAnlKFx9MoQuNi5aQk3KWRGmYoHzwaFvjXBLs
	X/6GiWX7ub3XtDJctx5tVe214gnesQ40Sm1QgSmAIF6rfuBetf7kcazCdKjOQMzL
	lkVjijZKt4kf/pV1Zs+Be6VwxRlUvAnzmU4TKvw+EooGYs9yBFN9skF9sA9p2n3T
	uzixA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yywec9kgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:34:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 10:34:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 10:34:08 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 929A23F7063;
	Tue, 25 Jun 2024 10:34:04 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v2 2/7] octeontx2-af: Fix klockwork issue in mcs_rvu_if.c
Date: Tue, 25 Jun 2024 23:03:44 +0530
Message-ID: <20240625173350.1181194-3-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625173350.1181194-1-sumang@marvell.com>
References: <20240625173350.1181194-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m5Uap0-xixyQCkWmF6vtghljrJIZPnGS
X-Proofpoint-GUID: m5Uap0-xixyQCkWmF6vtghljrJIZPnGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_12,2024-06-25_01,2024-05-17_01

There was a missing "default" condtion in a mailbox switch case, which
can lead to wrong response message to the caller. This patch fixes the
same by adding gracefull exit for a "default" switch case scenario.

Fixes: cfc14181d497 ("octeontx2-af: cn10k: mcs: Manage the MCS block hardware resources")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index d39d86e694cc..de4482dee86a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -681,7 +681,7 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	struct mcs_rsrc_map *map;
 	struct mcs *mcs;
-	int rsrc_id, i;
+	int rsrc_id = -EINVAL, i;
 
 	if (req->mcs_id >= rvu->mcs_blk_cnt)
 		return MCS_AF_ERR_INVALID_MCSID;
@@ -742,6 +742,8 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
 			rsp->rsrc_cnt++;
 		}
 		break;
+	default:
+		goto exit;
 	}
 
 	rsp->rsrc_type = req->rsrc_type;
@@ -854,7 +856,7 @@ int rvu_mbox_handler_mcs_ctrl_pkt_rule_write(struct rvu *rvu,
 static void rvu_mcs_set_lmac_bmap(struct rvu *rvu)
 {
 	struct mcs *mcs = mcs_get_pdata(0);
-	unsigned long lmac_bmap;
+	unsigned long lmac_bmap = 0;
 	int cgx, lmac, port;
 
 	for (port = 0; port < mcs->hw->lmac_cnt; port++) {
-- 
2.25.1


