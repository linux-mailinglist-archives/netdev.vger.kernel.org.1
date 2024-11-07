Return-Path: <netdev+bounces-142843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444B9C076D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E251F21987
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E224721313F;
	Thu,  7 Nov 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IsXGrVgU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA47212EE9;
	Thu,  7 Nov 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986158; cv=none; b=Lmc3IZph07MolNfEVf0KHhJdZ2GwDlk5UDoP9/Ykk8/0NK41oI5qdr53MvF7dGa6jhgezhTueNRpoDP2TkylNMHGVrh9vVdu5ATjI1roBcx6cBxvVMaOHbiC5KehmGvZC0SeF/8QCKE4mBkQh87hXq7JXj1R2I3Wi0eVZmQpwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986158; c=relaxed/simple;
	bh=YnnZEG4iqErUeeinyFBCzZGHYcULm1bNkGNeQask9QQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQrGE+I2ZpK0E8kN3Q6WoFMHa9yby566fa7tcl1ED9pbKYIbe+zJy5VfpJMz9MwBViskmkRIa/Rhd1GEs5U1rFuS0WRuVn26CUsQlgps6otUmMTVX5gN4pUvhbtRN0RZW65qXRWCytSo8QaP5TQHf+e6i2RzHArIFo3rb2Q60O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IsXGrVgU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Ca41g018109;
	Thu, 7 Nov 2024 05:29:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
	ibQwkNXpH7ZgvIsTUGJIvdNeUAyRmx4ORvMZVfZ734=; b=IsXGrVgUK0fDiQ6LR
	ZhliDgtvdM3+YHOkVsWWBH7Hu854ZKtzwlR7Hmzjo+PBHx3hK/Ing4ZvLR5iNTJ6
	7/eiRsm8+kOgiWzGoZrX31rQdOqQ7EV1CT0G/lSAPMH5tb8Vo587WfZEysgTBZIw
	FO8Tg/7xqRCxWR6DXUvFNb4orhj3gIO7NqICJWeMGqjGF5YbezdDnQGOQVq0VaGJ
	6zf9ymr79lyCU8DgbAQCFaPFoOGNC5AnnU9kaA64Ba/4V6PJtU8zRaenSj+djJNv
	dYV1OK0wRm0NBgX08fgrFCGSnQRbQCGYej1Xc3qvquwdPEJ04JeYumut9LFAiPxd
	7MLbw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42rwpng3hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 05:29:03 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 05:29:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 05:29:02 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id E31523F708C;
	Thu,  7 Nov 2024 05:29:01 -0800 (PST)
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
	<pabeni@redhat.com>
Subject: [PATCH net v2 4/7] octeon_ep: add protective null checks in napi callbacks for cnxk cards
Date: Thu, 7 Nov 2024 05:28:43 -0800
Message-ID: <20241107132846.1118835-5-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107132846.1118835-1-srasheed@marvell.com>
References: <20241107132846.1118835-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pXpXKMRYR67F_T_4Y9OIMvAL4Kh8csOW
X-Proofpoint-ORIG-GUID: pXpXKMRYR67F_T_4Y9OIMvAL4Kh8csOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cnxk cards.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Split into a separate patch
  - Added more context

V1: https://lore.kernel.org/all/20241101103416.1064930-3-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

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
-- 
2.25.1


