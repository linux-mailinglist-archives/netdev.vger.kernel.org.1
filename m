Return-Path: <netdev+bounces-106605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A4916F56
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884811C24E4E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC2216C866;
	Tue, 25 Jun 2024 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DgY0uBRP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB415178399;
	Tue, 25 Jun 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336863; cv=none; b=NyuVsTfvRCJ7Fuu3rcG33RNgCAQx8GPT/yIZ9HpTcv3TGSO621Q3DGLl8/WiOUqEonv3+ZIVWZYtWKRzID25EpRrT8VDejY9GxWg+jc21h+gvTu6zYEUVHMZ5Ix5EONX2PvYgqCA+2dRKZtsZN/c0zAqanb5TyZgwnf70RAea+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336863; c=relaxed/simple;
	bh=MwR2+x33tL23zCDtW1vXkjUKW66d5cZi7iJ5mbn+RTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKtjED/QIXSJzP40mEPwhAkGQS/c/SVTbo5szJxxR8DSytOEUHjdQO7DyJw1jfjpTUibsbOmjwEJ+x1d6jzcZZlO6vzxqFhFvJMRHaL0tpphTpu8ePyyzZFOc1y8vH+2FEFhNAwVMND1RJYP/DOfzapx/knTXKT9OzpAn7Z1ZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DgY0uBRP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBtIf4000832;
	Tue, 25 Jun 2024 10:34:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
	3jdL6UcGGq24YBU3TnKztOmwHWjNtaB4Og6RDixtc4=; b=DgY0uBRPUIfGQiK7Q
	ImQ1ZABotrYDzVls9PVQUIEbpKo0ETk/EdVnQzAFaDgrOPt+INheMPgaCPIdt2AT
	L1EoqQEGPBp7awWY28TcVP4fFCM1jWrE3iW1MNwc/0K7IeUqKv89aVrDR3f/T1pV
	3ESnISF3R+6AoIthyDoQvm8zErDRqNv8gkUo9OGnKr8g+I1ycmwo0L2HoZWHktht
	rjeL7ZAL7YQvoXHGetMA38rEXybL0Ucu6A2bnDkowNgMWASECsUHWMZHWpAHVZqZ
	VKBKexYRSxJhsNQh7lJdpp7BBSGQdXQI+MugDcHZY2N983Z22fVqon791s0jmuD0
	UPO8A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yywec9khc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:34:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 10:34:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 10:34:14 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 2FE1C3F706B;
	Tue, 25 Jun 2024 10:34:09 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 2/7] octeontx2-af: Fix klockwork issues in mcs_rvu_if.c
Date: Tue, 25 Jun 2024 23:03:45 +0530
Message-ID: <20240625173350.1181194-4-sumang@marvell.com>
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
X-Proofpoint-ORIG-GUID: 4-xcnGtU8O9JCrCWuow3GhmRvP2SH1ew
X-Proofpoint-GUID: 4-xcnGtU8O9JCrCWuow3GhmRvP2SH1ew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_12,2024-06-25_01,2024-05-17_01

These are not real issues but sanity checks.

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


