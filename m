Return-Path: <netdev+bounces-140980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1A9B8F42
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31516281C45
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218EE199E8D;
	Fri,  1 Nov 2024 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Lb0Tfyel"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3418953D;
	Fri,  1 Nov 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457279; cv=none; b=cKFJptRHBcfio2dV1EKiIj7rRlqIJVY4hOCJccf5XrCZpeJt5ZbW63F9/N/umPm2LXIUEqarC2EwgZ1UUSrDutimG44nsWLFnlWlbPh+/bbDhWoB9w8sTMaJmbVeLKNopOpQp/6MM4RA7GFuZKk3rixucXAB/Ny7u2ytTcjfUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457279; c=relaxed/simple;
	bh=7CEh2pgSVWlTpnqxUxjDRbI8zmDr6/bLH7zkmX+pNnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCOHfL2tIsO662Yjy6EqDDh9Z3N2sXfgoLZ9drp2FPkGGCcv36Zo1iI/tuFrMYA7qLVP0xWZM5dvFKvQ3ohDKDuIl845Xnrg7XJtiBcsJkjw+/D334Xibf27DwGzdmQX+lNY3QwXHavSQ0apa3JoA4qksC99ILZs6b7ikBXvkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Lb0Tfyel; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A16rYv3025517;
	Fri, 1 Nov 2024 03:34:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	lRbPW5YCEDK1yec4ABq8Ou+8EXNk0quIShm9NOr+Qw=; b=Lb0TfyelmFRpfMt2C
	6Ab26Qwx4Miwd1YnUTH2fQzBrsl4MR4DmdAiVM9j1yp4ekxwn0tI+6006okl3Jzl
	dojaX/VVpzgPkWD8ZDy2hdPVAaFl4c5zvQOkoK+KEXL7IAcIMBSMpGiV3ePZrBrU
	foRH/PiJipMDPPylhEXRaaGkmk9Askegel50r5fK4ET21ObGc37jihJdksOIYxEo
	p9vgZ7rIlHZUmiJhxb63EGf+nCnQTjBdMzbJf/8wASjBN9oZfz72oEIrXu/NNxDg
	tiHFxpMJ2iPvfkwSNotxdvBW0g49BtCZ7impM4/T9tYYTBuDKbMRS2qIUbvHi7c4
	ViJhA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42mt440ddh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:34:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Nov 2024 03:34:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Nov 2024 03:34:25 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 9689A3F704C;
	Fri,  1 Nov 2024 03:34:24 -0700 (PDT)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <wizhao@redhat.com>, <horms@kernel.org>, <kongyen@redhat.com>,
        <pabeni@redhat.com>, <kheib@redhat.com>, <mschmidt@redhat.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>
Subject: [PATCH net v1 2/3] octeon_ep: add checks to fix NULL pointer dereferences
Date: Fri, 1 Nov 2024 03:34:14 -0700
Message-ID: <20241101103416.1064930-3-srasheed@marvell.com>
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
X-Proofpoint-GUID: xKpQqWP8Z4NjEe2gl7_zkc2Or2Fo4AJN
X-Proofpoint-ORIG-GUID: xKpQqWP8Z4NjEe2gl7_zkc2Or2Fo4AJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add Checks to avoid NULL pointer references that might
happen in rare and corner cases

Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
Fixes: 1f2c2d0cee02 ("octeon_ep: add hardware configuration APIs")
Fixes: 0807dc76f3bf ("octeon_ep: support Octeon CN10K devices")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c | 9 ++++++++-
 drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c | 9 ++++++++-
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c    | 3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index b5805969404f..b87336b2e4b9 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -617,7 +617,14 @@ static irqreturn_t octep_rsvd_intr_handler_cn93_pf(void *dev)
 static irqreturn_t octep_ioq_intr_handler_cn93_pf(void *data)
 {
 	struct octep_ioq_vector *vector = (struct octep_ioq_vector *)data;
-	struct octep_oq *oq = vector->oq;
+	struct octep_oq *oq;
+
+	if (!vector)
+		return IRQ_HANDLED;
+	oq = vector->oq;
+
+	if (!oq || !(oq->napi))
+		return IRQ_HANDLED;
 
 	napi_schedule_irqoff(oq->napi);
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 5de0b5ecbc5f..65a8dc1d492b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -638,7 +638,14 @@ static irqreturn_t octep_rsvd_intr_handler_cnxk_pf(void *dev)
 static irqreturn_t octep_ioq_intr_handler_cnxk_pf(void *data)
 {
 	struct octep_ioq_vector *vector = (struct octep_ioq_vector *)data;
-	struct octep_oq *oq = vector->oq;
+	struct octep_oq *oq;
+
+	if (!vector)
+		return IRQ_HANDLED;
+	oq = vector->oq;
+
+	if (!oq || !(oq->napi))
+		return IRQ_HANDLED;
 
 	napi_schedule_irqoff(oq->napi);
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index ff72b796bd25..dc783c568e2c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1016,6 +1016,9 @@ static void octep_get_stats64(struct net_device *netdev,
 		struct octep_iq *iq = oct->iq[q];
 		struct octep_oq *oq = oct->oq[q];
 
+		if (!iq || !oq)
+			return;
+
 		tx_packets += iq->stats.instr_completed;
 		tx_bytes += iq->stats.bytes_sent;
 		rx_packets += oq->stats.packets;
-- 
2.25.1


