Return-Path: <netdev+bounces-140981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1921D9B8F44
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7094B22B13
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F3B19B3E3;
	Fri,  1 Nov 2024 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PsAV+hAE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A0198A38;
	Fri,  1 Nov 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457279; cv=none; b=S/7vVCmt2qnOOyRvxSeJs07yb4ppquglMYAGRDdYe4ddiHmen6WdCM78V2H2uNdyuTiZLztUhi7fK9AI9joktxXI3EUAUi1wGfrID0Y8GDHD2jOf5lAC1gTd/f9xgcsobJz3dwe0SiTTbyfFnITB0659bwgkcf/ngPgYNaDx0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457279; c=relaxed/simple;
	bh=4gVyFl3aZzu1qejuO+Sxyt3R0RGE2BEjyOzgiP3k/b8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0HiZasyVG/XDGKZYJCbEbrBlDS0Dv2Ca/miW2EDWoV9jKE0+HjzZEGoaVzi5WiO46iz/ApOSM/jeXScpzY8qxsjJKcDqsEK+U2D83jiL8NWrJK6i4WhGikYNjNT5CIK5IfnmvacGkf1DXM9zWpnx4eeZ4cHyvWPMf1JoVDN92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PsAV+hAE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A19DP52009586;
	Fri, 1 Nov 2024 03:34:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
	JVtgcRhOVSaV5xJsgcnaEkB84NlO9i8LlP+KvEcN6E=; b=PsAV+hAEocm7sMuYw
	oGGM0dUNleRqJOaM4sjdbO4FUGTU8NFJdP6xpq845EUakvud0ICRs29LzOS/9xxg
	XPA8vVSIK1ZW85+fqGhz51xsNiptpe/ipAKc/U3rgC30PiGtdx1BhCkw3f70VNJ2
	j1QFWGwpcYVLmlxKxvFNrNRM+QgS4/sHjxX/YofF94+LjcsaBeAxLu/WkKC+E3vD
	+K1yBGNY2vY0BNuZaEwuFyknzTu0IVejYKDoTP/sQ92+YUoCgR18oNnD4F5sMXVw
	uVvykEf66yJxf+6ZtF5wCN8aOPb4EVrI2SxFLWW2AHqwcKVT7QepSJm+TVd6EgX5
	niyUQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42mv5ng4a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:34:29 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Nov 2024 03:34:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Nov 2024 03:34:27 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 1F9B23F704C;
	Fri,  1 Nov 2024 03:34:27 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <wizhao@redhat.com>, <horms@kernel.org>, <kongyen@redhat.com>,
        <pabeni@redhat.com>, <kheib@redhat.com>, <mschmidt@redhat.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v1 3/3] octeon_ep_vf: add checks to fix NULL pointer dereferences
Date: Fri, 1 Nov 2024 03:34:15 -0700
Message-ID: <20241101103416.1064930-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101103416.1064930-1-srasheed@marvell.com>
References: <20241101103416.1064930-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iVv9dbxbxEkmGQNqyZJxTHocx3_7d_GN
X-Proofpoint-GUID: iVv9dbxbxEkmGQNqyZJxTHocx3_7d_GN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Add checks to avoid NULL pointer dereferences that might
happen in rare and corner cases

Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c    |  8 +++++++-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c    | 12 +++++++++++-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.c    |  3 +++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
index 88937fce75f1..f1b7eda3fa42 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
@@ -273,8 +273,14 @@ static irqreturn_t octep_vf_ioq_intr_handler_cn93(void *data)
 	struct octep_vf_oq *oq;
 	u64 reg_val;
 
-	oct = vector->octep_vf_dev;
+	if (!vector)
+		return IRQ_HANDLED;
+
 	oq = vector->oq;
+	if (!oq)
+		return IRQ_HANDLED;
+
+	oct = vector->octep_vf_dev;
 	/* Mailbox interrupt arrives along with interrupt of tx/rx ring pair 0 */
 	if (oq->q_no == 0) {
 		reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0));
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
index 1f79dfad42c6..31c0d7c0492a 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
@@ -284,8 +284,14 @@ static irqreturn_t octep_vf_ioq_intr_handler_cnxk(void *data)
 	struct octep_vf_oq *oq;
 	u64 reg_val;
 
-	oct = vector->octep_vf_dev;
+	if (!vector)
+		return IRQ_HANDLED;
+
 	oq = vector->oq;
+	if (!oq)
+		return IRQ_HANDLED;
+
+	oct = vector->octep_vf_dev;
 	/* Mailbox interrupt arrives along with interrupt of tx/rx ring pair 0 */
 	if (oq->q_no == 0) {
 		reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0));
@@ -294,6 +300,10 @@ static irqreturn_t octep_vf_ioq_intr_handler_cnxk(void *data)
 			octep_vf_write_csr64(oct, CNXK_VF_SDP_R_MBOX_PF_VF_INT(0), reg_val);
 		}
 	}
+
+	if (!(oq->napi))
+		return IRQ_HANDLED;
+
 	napi_schedule_irqoff(oq->napi);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 7e6771c9cdbb..79d9ffd593eb 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -790,6 +790,9 @@ static void octep_vf_get_stats64(struct net_device *netdev,
 		struct octep_vf_iq *iq = oct->iq[q];
 		struct octep_vf_oq *oq = oct->oq[q];
 
+		if (!iq || !oq)
+			return;
+
 		tx_packets += iq->stats.instr_completed;
 		tx_bytes += iq->stats.bytes_sent;
 		rx_packets += oq->stats.packets;
-- 
2.25.1


