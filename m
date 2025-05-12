Return-Path: <netdev+bounces-189751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BFAB37E0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BFE18835FA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD7A294A12;
	Mon, 12 May 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BSiXhqrB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622A2949F1
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054380; cv=none; b=D0MP+bdxNoLPULNdcGSqe4pAk4pwcq7Wsjg53/jo6Vzm3T5F7/4WDJSLzSyF5iddJBxxHdizXSDjKd2yRXcqg39COLAj4bX25MERQkM47HGsnHg9ua59o+iW1uctgR1MwzVc+VioTteK90hhLQ7+IUtbvTRm9J3wBVdMuCb++ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054380; c=relaxed/simple;
	bh=aNmKo1Oakl3yM94F2in7pHniPeNN+XwX6ZF6pcypzag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wtl2yXz42jedpvK2uwpdAHKDYdd1Aaj8978jVsdx4I4P70JfsxEOYpx5tdp2zMbjk4sw+YzQcYKUmA7dTmG5UMWz8LeYevJKUJFnxLq1UwZzO0FdNMfviGZ4ukCuybsqx43gzhUo+oLjWG/K3jvkxjCXTld6wvUxxzgyw0NjU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BSiXhqrB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0lBSc013830;
	Mon, 12 May 2025 05:52:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=yiAFpChy9Fgi/Ha1tvpLIR5S8O609BoIBfkcdBODBW4=; b=BSi
	XhqrBUP56rn/Nz56ywT+kV5/it6XUbB3GonH3DgbbEna3bcCcqBcX8v0RKllxp4/
	7xsPSry6X+lX5X1biwluka2PdzSdFr/eOBgkTUSl09iz1M330QPVpTPKei+Z3BMr
	tiLRVSOlRXaUmL0qZu5O0FcIC6JifKCNnFKikd/6vKpKAo99fZy+474XiejDsceW
	OOaGtgQrDd8HAPWN7kOI0IF2D5QQDwKmgR+wyB/UInQYQYZ13SSGBPjnptzOBT0N
	Y2KKH7dUX7HEuri5uoshO8GNFb9L+4lYFz1mW7ECi7QMWsK5S+PTxFADqsR/E96f
	RNvanaXL31zAu4crU0A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46k5trs2ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:52:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 05:52:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 05:52:47 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id D32DE3F7097;
	Mon, 12 May 2025 05:52:42 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net v2] octeontx2-pf: Do not reallocate all ntuple filters
Date: Mon, 12 May 2025 18:22:37 +0530
Message-ID: <1747054357-5850-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=6821ef20 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=JJ9OIAJi2aS0bon4u0AA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: eNaAEYOOCAGvNyqtJzEy0PPOatuyL8dv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEzNCBTYWx0ZWRfX/Z5PF3/T6hSc Cr+/t6drbvOPdbGkTdW6kFjvRspMJLtz2zUIIYg3SAWmplFH+A6JLby+Mo95RQKhuFt+qgrEwyQ Qil93UDcTrhGAyk66g5yCK9Z3yKiFoDoyo2u3AqZ0OOkRJqFZDaRB0PtYN2AVuW5AVxV7MmWHrJ
 UGxKC7DDulKT39ALlkc1ObPSY0F2oAM9V39ps9/rss+nQ84c2zci6Gl0kK5eVi7oeBWAfwfoIAp K3XF7ahsag4CKpIFNUvTX5xweB/nCZ8LFH1xC1WY+tlU/wapg6u0j/HB6pJS4DrAzaikOH9Na0r 6+GWsmoxHiFhmtacP45cLmAiIkB9uRdOaKImB1RtLfH4XLUf1GGUCZbLJ1eFr6OBe+x3KGTCo/z
 hGiFcnOJLNs+qAjkQuWKELMeT3i9jqw/WtIBZ8DKYJJFp+GYtrIcHx2L/Ix6imYBTtxkdcFz
X-Proofpoint-ORIG-GUID: eNaAEYOOCAGvNyqtJzEy0PPOatuyL8dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01

If ntuple filters count is modified followed by
unicast filters count using devlink then the ntuple count
set by user is ignored and all the ntuple filters are
being reallocated. Fix this by storing the ntuple count
set by user. Without this patch, say if user tries
to modify ntuple count as 8 followed by ucast filter count as 4
using devlink commands then ntuple count is being reverted to
default value 16 i.e, not retaining user set value 8.

Fixes: 39c469188b6d ("octeontx2-pf: Add ucast filter count configurability via devlink.")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h  | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c   | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 1e88422..d6b4b74 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -356,6 +356,7 @@ struct otx2_flow_config {
 	struct list_head	flow_list_tc;
 	u8			ucast_flt_cnt;
 	bool			ntuple;
+	u16			ntuple_cnt;
 };
 
 struct dev_hw_ops {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 33ec9a7..e13ae548 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -41,6 +41,7 @@ static int otx2_dl_mcam_count_set(struct devlink *devlink, u32 id,
 	if (!pfvf->flow_cfg)
 		return 0;
 
+	pfvf->flow_cfg->ntuple_cnt = ctx->val.vu16;
 	otx2_alloc_mcam_entries(pfvf, ctx->val.vu16);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 47bfd1f..64c6d916 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -247,7 +247,7 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	mutex_unlock(&pfvf->mbox.lock);
 
 	/* Allocate entries for Ntuple filters */
-	count = otx2_alloc_mcam_entries(pfvf, OTX2_DEFAULT_FLOWCOUNT);
+	count = otx2_alloc_mcam_entries(pfvf, flow_cfg->ntuple_cnt);
 	if (count <= 0) {
 		otx2_clear_ntuple_flow_info(pfvf, flow_cfg);
 		return 0;
@@ -307,6 +307,7 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
 	INIT_LIST_HEAD(&pf->flow_cfg->flow_list_tc);
 
 	pf->flow_cfg->ucast_flt_cnt = OTX2_DEFAULT_UNICAST_FLOWS;
+	pf->flow_cfg->ntuple_cnt = OTX2_DEFAULT_FLOWCOUNT;
 
 	/* Allocate bare minimum number of MCAM entries needed for
 	 * unicast and ntuple filters.
-- 
2.7.4


