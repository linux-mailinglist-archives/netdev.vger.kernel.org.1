Return-Path: <netdev+bounces-144377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB99C6D90
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F381F26E94
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B8520103E;
	Wed, 13 Nov 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TsyGJGcY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53945201007;
	Wed, 13 Nov 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496430; cv=none; b=Ap1484bbuGEs3s+QSUK08n2OdkosSS+axqj6RW1CETn9Derr1BzOSfL7rmIFXsQ93x6UMyLz780MLiGNkFZwSTcRdARldW1z+9Kjxk+GGksNP7BOVW4IKFwkVSDkVAWDGVEdjUzhif8OisuJTYOmizIqoZLl1JhARMh1CD6An+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496430; c=relaxed/simple;
	bh=WbTzFStCX8oPnpzOiNOrdD9gK7rgoe1InOSFbEBB6eI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoStyBhLueMbuGMTpG24Z/R27BX+aI86gJDNxjsZaiL4ND+NJIS5+FzDNHjD0keXMjFDZbFhD8W+eAyWiO9U0tG10BTPoXzk4YYHBrLLbEFaC0nvrvzS5ARfGhe6afEl2ENIOURqWho52lgVYkvBVCtckmvHatg5nAkt6LBFhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TsyGJGcY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD6X0Zd016637;
	Wed, 13 Nov 2024 03:13:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	hbF4K2Kwyhx+BtI3fHlj2W8yCDcrWUeKdZbLjKj5vQ=; b=TsyGJGcYBWcYTcShW
	fcpTJo4OQuHIw5o/bvIXi/QbnnPFWjN0AxGAwsllaxivu/P6PyEHzSE7MUSaw3dG
	/TgL8WLuCHFObbhi59aiEPZdGy7y+CGrZdAlVBwdqr40ZPhJtkT7EdYrfOQBrGh/
	kjeLyUFKYTDjf7eye99ICBziSCEG3VedN+tAHEYJrTvt2fO4V/PvlKeKSX8HgC9z
	zne6o/dY36nWRCrSn9iJBkAl7IOcVcoZBplIR++iRZxHTJyDv+dHFALt+q2WhlAm
	EBY+qgETpQ+WmOvKcq3e/MpLH85dPbBF+CBRtv+3xaV0zHA7RuV2i1wboyh8ADv7
	3R/5A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42vpxp0ftp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:13:28 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 03:13:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 03:13:27 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 1CF8D3F7040;
	Wed, 13 Nov 2024 03:13:27 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Satananda Burla <sburla@marvell.com>,
        "Abhijit
 Ayarekar" <aayarekar@marvell.com>
Subject: [PATCH net v4 3/7] octeon_ep: add protective null checks in napi callbacks for cn9k cards
Date: Wed, 13 Nov 2024 03:13:15 -0800
Message-ID: <20241113111319.1156507-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113111319.1156507-1-srasheed@marvell.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Qx8SQPnIqJdlODiIuBOk6G1KfkmRTqFr
X-Proofpoint-ORIG-GUID: Qx8SQPnIqJdlODiIuBOk6G1KfkmRTqFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cn9k cards.

Fixes: 1f2c2d0cee02 ("octeon_ep: add hardware configuration APIs")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - No changes

V3: https://lore.kernel.org/all/20241108074543.1123036-4-srasheed@marvell.com/
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-4-srasheed@marvell.com/
  - Split into a separate patch
  - Added more context

V1: https://lore.kernel.org/all/20241101103416.1064930-3-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

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
-- 
2.25.1


