Return-Path: <netdev+bounces-149361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1D79E540B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1EB1880742
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719FC1F6679;
	Thu,  5 Dec 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="P5BD6y9O"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10621F541C;
	Thu,  5 Dec 2024 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398507; cv=none; b=BRevZJzgy+OhYwGwhSSjkoWpb7Oew7Gnuoi4trXf0ob4UMKZNinpX4w6AcPewhVk7FJUTCyni+7+BH42iFj/CFWUdf0RmOE1rgGljYb23jd+rokxd0RhSYYXfh/sNTlh2d7Nb1CyvHbscWCm3nwbWxbcRWYatVeySbcjvC648nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398507; c=relaxed/simple;
	bh=jx1QpmnWT+BvmW5j+2uyUoTHDLT73WQRHWfndk5Xs18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fDScd3YkJRQJ3QV1OkK/xl4O0Dhq6yTO5cvq/HNPdOs2Mo312RosBF3WNKI/McTInEzWQVDTavdicXr+lofhPhme/Kn8OypYuVikZ5B5LDxMKrHTLeRKJqZbekvn/DvEPRj2ibrKInpidJTiZSfrB/ugC7gxaGD0l4vZ32qMEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=P5BD6y9O; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B597xg0008313;
	Thu, 5 Dec 2024 03:34:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=PyBiDkR+sGkaeC+WPOz41eBAz9Ruk1Y87rRuK8KNfsg=; b=P5B
	D6y9Oea9Tb7g8r9AWBBILA3wY09JVV5qi2UNK/FQx9bvivnTR6zDreqxGFSjMLBg
	H/Fc0uU7HasrodVVxpFndcMhxTPJ9SyvZvp5YsnlInD26qSYPUcDAHgA29TL50J1
	7r4cRxXmVarTZa2FeZD7QL1w1RhafuadxzCMtQd+nHiQXCyeLWXuPnxtClePv36F
	S8zt+tAKo/yrNj1F5duWfa4Jwt6CXzK5XiP4EHoDJcrchsSCfyrXqWzPoJgccU4B
	dZTBK90dskx2VZ5+a+S0rE0bmHq8JW1HpvCl8KJwG7dqFtAkHJBV9SNusX0NeXTi
	kVs2VgpOaBDZ6/Lrf7g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43b995r7uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 03:34:41 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Dec 2024 03:34:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Dec 2024 03:34:40 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id DAA383F704A;
	Thu,  5 Dec 2024 03:34:36 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <horms@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>
Subject: [net v2 PATCH] octeontx2-af: Fix installation of PF multicast rule
Date: Thu, 5 Dec 2024 17:04:35 +0530
Message-ID: <20241205113435.10601-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iAo4c7KlL5sEesirEtwNwcHkjNfaPS3m
X-Proofpoint-GUID: iAo4c7KlL5sEesirEtwNwcHkjNfaPS3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Due to target variable is being reassigned in npc_install_flow()
function, PF multicast rules are not getting installed.
This patch addresses the issue by fixing the "IF" condition
checks when rules are installed by AF.

Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---

v1-v2:
 -Restructured the code.

 .../ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index da69e454662a..1b765045aa63 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1452,23 +1452,21 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	 * hence modify pcifunc accordingly.
 	 */
 
-	/* AF installing for a PF/VF */
-	if (!req->hdr.pcifunc)
+	if (!req->hdr.pcifunc) {
+		/* AF installing for a PF/VF */
 		target = req->vf;
-
-	/* PF installing for its VF */
-	if (!from_vf && req->vf && !from_rep_dev) {
+	} else if (!from_vf && req->vf && !from_rep_dev) {
+		/* PF installing for its VF */
 		target = (req->hdr.pcifunc & ~RVU_PFVF_FUNC_MASK) | req->vf;
 		pf_set_vfs_mac = req->default_rule &&
 				(req->features & BIT_ULL(NPC_DMAC));
-	}
-
-	/* Representor device installing for a representee */
-	if (from_rep_dev && req->vf)
+	} else if (from_rep_dev && req->vf) {
+		/* Representor device installing for a representee */
 		target = req->vf;
-	else
+	} else {
 		/* msg received from PF/VF */
 		target = req->hdr.pcifunc;
+	}
 
 	/* ignore chan_mask in case pf func is not AF, revisit later */
 	if (!is_pffunc_af(req->hdr.pcifunc))
-- 
2.25.1


