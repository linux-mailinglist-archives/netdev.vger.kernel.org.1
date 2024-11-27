Return-Path: <netdev+bounces-147594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB7F9DA71D
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 12:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7FF281068
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BFF1F943B;
	Wed, 27 Nov 2024 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fIdBCo/b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480F1917F1;
	Wed, 27 Nov 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708166; cv=none; b=oPsjf4xfndRMSXRDZDqL5rZ4sot8dD9zRM6EeoaEjOUDYZjTpiFOF9fnOCSzRJQC6xkpb6TtllvNGdl1ESK46turQa3sMMKegL7vsdB0IKgaxSjD02mjVlpZIinvWFW1FslCXUEeXRwWQW4vxknlRUsq2Uwnh+OYAgpZaxBuBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708166; c=relaxed/simple;
	bh=brJ4OvMdMNpU0GKx4LwueP2L1Igr9rWjZME02H1ZC0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GjdOPLtjMfAggwvD87vs0yuLNaSf0UtYDivSGC+0d/qjV0V5j32z5ilcmq1ubGRbdpsj2jLsasoY3rmnPEkNnyQOZ5raucTE65NabxmOBFlbkZ1z/0oXroYhJLkwRhWkoVNSZrOMr3WVFnflmPsbekcyAnzSwhUo8JjY9fN70JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fIdBCo/b; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR7Rrgg031606;
	Wed, 27 Nov 2024 03:49:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=7w9PYxRoKxSZecYgNzzy4l3FTSJfjUEz56IOMh1h/uY=; b=fId
	BCo/b6/7H2gQnakoH5VJ86QJYXyeyM58MLRsan4a0VTlb71WmXHVV7iKcuaF01mU
	OtHK4iyyqmpPfP31GCDgiZioayycITY2BgTzhcJsTIVCRzmx1RruuDKfb6wr6dZX
	+aS2RkaTeBxja7m1FPaXm7b0rRJ1MC346ZDpKVHoTL63rIPosvQ/er7tll6ENHde
	WcZnBdztW5IGekCT6GVe8Bt6SzzsPPAe7+IckyQDZYULNT16mRfHb0YwTdK2Z3CZ
	YyMLjaoKyecguNcv2YqbLPzDCbf6UhXtB2cfrZhWmgZMqw86X4i1GWNRo4t++Cjh
	2A8g+k/y3ZiegIn1aWg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 435y238ge4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 03:49:03 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 27 Nov 2024 03:49:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 27 Nov 2024 03:49:02 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id CEE223F7062;
	Wed, 27 Nov 2024 03:48:58 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <horms@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>
Subject: [net PATCH] octeontx2-af: Fix installation of PF multicast rules
Date: Wed, 27 Nov 2024 17:18:57 +0530
Message-ID: <20241127114857.11279-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g8INKQ0bgxY8Kj1_c8ga1pg_diBM3Pdg
X-Proofpoint-GUID: g8INKQ0bgxY8Kj1_c8ga1pg_diBM3Pdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Due to target variable is being reassigned in npc_install_flow()
function, PF multicast rules are not getting installed.
This patch addresses the issue by fixing the "IF" condition
checks when rules are installed by AF.

Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index da69e454662a..8a2444a8b7d3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1457,14 +1457,14 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 		target = req->vf;
 
 	/* PF installing for its VF */
-	if (!from_vf && req->vf && !from_rep_dev) {
+	else if (!from_vf && req->vf && !from_rep_dev) {
 		target = (req->hdr.pcifunc & ~RVU_PFVF_FUNC_MASK) | req->vf;
 		pf_set_vfs_mac = req->default_rule &&
 				(req->features & BIT_ULL(NPC_DMAC));
 	}
 
 	/* Representor device installing for a representee */
-	if (from_rep_dev && req->vf)
+	else if (from_rep_dev && req->vf)
 		target = req->vf;
 	else
 		/* msg received from PF/VF */
-- 
2.25.1


