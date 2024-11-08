Return-Path: <netdev+bounces-143221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AAE9C1732
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B331C2257C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3A1D9A59;
	Fri,  8 Nov 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZbSavk8g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7BC1D1E81;
	Fri,  8 Nov 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051964; cv=none; b=mDGOWySw1MaIcTyimPh4TWZBnnr+PUhrAxZTjWLienIx6bjshKWLx7GOFTH3MFJKStfiUO701g6wdccyUH/ouWgUcqg3Nmig03PIGoax03ovhILmPT0WFB/QmQFwOpto/Kj9+GD/KtsfDWX3/aKzXGJy/5ixbgHEfQ3Xs0Xgl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051964; c=relaxed/simple;
	bh=o2rTndZMtXvHxLMu2eyyajTwKd5p3vII/u985KoNbMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugnsIzDnWm+7ZBoViSpHdN311iqG+i2/K5l+PAPIln1aJa6GcRXVZKdqyc7Z7/sNYJmNeCGC3uhkJ3d/+ID4aklFSwG6oXQogQfvSjJJAYAPctGXygIuEvEJfOrd6lhOchkD+6OIH1OeOcpiYCGtnolReWYH9j+g8gc2GAW12qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZbSavk8g; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A84hDiD012133;
	Thu, 7 Nov 2024 23:45:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	mLSqJqdPGKpseIOw6+sDJt4WFJrVy/h9uWiIGijFAo=; b=ZbSavk8gW7Ixoty7U
	NjRhpdWS9y0sP4TDGzJe8wVrZdWs39sjXuHd8GdpODAzZODAkA0J/ypPOgUYvpvW
	lFDXmdq21dBhAez07yOkiBkEjfe7wAz88kdite71k1Ajagundkwpew+eiTqAbAQc
	zjiG7V0038dYfMQDlMN7RvrpwBy5V8YsoVeDNBJs4Bns/kmmQI2MLo8OJ8+t6t2y
	9Y7+yUCs4Fpcmvbs8EvoT7/LA2a4q0XIb2Smby19BHZp4T4+vwFMSGPtqYF6yK8W
	rzcM4wXB2OFxzXU2FGMbY3jzWWy0foTkUMc9VJtSc87PIsMwi1l69/Ci9KrRPi3O
	PyXjw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42sbv68a4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 23:45:52 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 23:45:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 23:45:51 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 7B0143F7082;
	Thu,  7 Nov 2024 23:45:50 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <frank.feng@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "Satananda
 Burla" <sburla@marvell.com>
Subject: [PATCH net v3 3/7] octeon_ep: add protective null checks in napi callbacks for cn9k cards
Date: Thu, 7 Nov 2024 23:45:39 -0800
Message-ID: <20241108074543.1123036-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108074543.1123036-1-srasheed@marvell.com>
References: <20241108074543.1123036-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fr6vHe3gIT5M2TM4CCc3o_Aavb3xU0ji
X-Proofpoint-ORIG-GUID: fr6vHe3gIT5M2TM4CCc3o_Aavb3xU0ji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cn9k cards.

Fixes: 1f2c2d0cee02 ("octeon_ep: add hardware configuration APIs")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
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


