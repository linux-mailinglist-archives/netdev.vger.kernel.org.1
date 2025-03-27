Return-Path: <netdev+bounces-177905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29CA72CA6
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01103B3E3A
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E020CCD7;
	Thu, 27 Mar 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OSXflsOk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3A20CCC4;
	Thu, 27 Mar 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068480; cv=none; b=URyaUKZixvTs9GALoI00VEyRlyv97f26ez/VYSAmBjKWsEn/TEKvVYVktYGWvH1KGlpjDk8CxnhN+4OEvpj7GXzUcMtDPPgrYIbFGk8Xhddq2qpgYb3Tl/1ac7V0/DvV+rqBLRjnzh+L7vtiLzrXObQ1T7bw+3ZGMJiwlsLq5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068480; c=relaxed/simple;
	bh=glMrtPRMwCf/hTpSOg9es/RCOrRO2mA/9DknAIORiEk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NohBBC7bIQ28Fu6zg5vtWY6GLky3S8ymDanSYYcJHElwIz5qKxtopvVPy7dJE7wNE9inke93rMhS1g2VY2Wg5ZPrHlIfvR76IS7BJ8vkPvB4kilZnnUr7HY6z0UsVVtXg+jKdLmq7kr0uiSfkzmSHV2J3ZkYaTJcqURaGa26ksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OSXflsOk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R75SFE012762;
	Thu, 27 Mar 2025 02:40:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=Ei2z18ex06t1MQHQoeuQQd5olVFTcCe9I9eJdiosu0w=; b=OSX
	flsOkEMG/ruUFHOrfPAnaJL4dNn/7286kE5YlozUodOfHNaY6lYGGoBz39ofL1Th
	1vHnC1WMm6Jtv0ONjCC6k/bowl8JwODbSDKVU4WcusHNFFyzHPf1MP44bzegqE6a
	+SGNo0u3Ua9wkNSPj1QRNtc3/6fgrCJpKMhW3K9GwSJG3UQYiqbSqdwSIuADtJwm
	BX7lClax2vy/u27lNbaxqHIbU1aggCuhfMaexpN0YRCKetaIa2/Y6SCIXBCbKZuW
	R916uBsIZz308J2HRRojBhLk4S0pPE2dwijZqQAm53olKIEW3MCvVEJuB7qyfA4g
	tcatW0YxibwMzgpYUqQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45n1yv89kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:40:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Mar 2025 02:40:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Mar 2025 02:40:58 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 562C65E6869;
	Thu, 27 Mar 2025 02:40:55 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <tduszynski@marvell.com>
Subject: [net PATCH] octeontx2-af: Free NIX_AF_INT_VEC_GEN irq
Date: Thu, 27 Mar 2025 15:10:54 +0530
Message-ID: <20250327094054.2312-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: O9ga0dYAkM2jHIK0rodNJKKbROtFkzQu
X-Authority-Analysis: v=2.4 cv=dKCmmPZb c=1 sm=1 tr=0 ts=67e51d2b cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=x9ZtOMo8CBIAi1-txUEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: O9ga0dYAkM2jHIK0rodNJKKbROtFkzQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01

Due to the incorrect initial vector number in 
rvu_nix_unregister_interrupts(), NIX_AF_INT_VEC_GEN is not
geeting free. Fix the vector number to include NIX_AF_INT_VEC_GEN
irq.

Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index dab4deca893f..27c3a2daaaa9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -207,7 +207,7 @@ static void rvu_nix_unregister_interrupts(struct rvu *rvu)
 		rvu->irq_allocated[offs + NIX_AF_INT_VEC_RVU] = false;
 	}
 
-	for (i = NIX_AF_INT_VEC_AF_ERR; i < NIX_AF_INT_VEC_CNT; i++)
+	for (i = NIX_AF_INT_VEC_GEN; i < NIX_AF_INT_VEC_CNT; i++)
 		if (rvu->irq_allocated[offs + i]) {
 			free_irq(pci_irq_vector(rvu->pdev, offs + i), rvu_dl);
 			rvu->irq_allocated[offs + i] = false;
-- 
2.25.1


