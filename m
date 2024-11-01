Return-Path: <netdev+bounces-140978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C779B8F3C
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAE41C221D2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F618A93E;
	Fri,  1 Nov 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VUXzr+Yc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C41684B0;
	Fri,  1 Nov 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457277; cv=none; b=FnAErZOj1Np7yHWe4RJcKeS2RzCn6HrrPIWrVWDP0EUjfv91/2aWz2J0UfVDR/sD2LACraOP+tfqaoGK9cszUn60SB20s/O7B8/4zlse3E4ouL5ad1SnMsX4Cyhs2wyDaN/SNlIJZXJbJMHYFgoCtuVxL7ObquafgTVBO9CGJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457277; c=relaxed/simple;
	bh=QjqhTr6xGprLYFtR5iTHjjkzJHwlEBt6FOAhfwylLn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqSmEtfxKwdn93pgw7dfLe6ENdDRfmbfsi1LHdmFYxygn2GYztTcj0Ns9Hjp0Z9iyGL/hDLSeNQUljmU42NOUm2gsTywdqoaANf19xGlojc/Of3UYWHVF+6PPXKps2Wvcyx6TrG6hfEYP7uCBAaT2ByWHWHFMZOpItSjd1fxnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VUXzr+Yc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A16a0WQ015129;
	Fri, 1 Nov 2024 03:34:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
	6psovTSE4eKOOM72cSkFxeniylPnh/+fjbT5hozeNc=; b=VUXzr+Ycip3Lf3qYw
	t5C8yI5Hfx3F0c5La4kxVK2+I0m+TGoraB1j6NggM2gcuo/B0cV+Lh/6SkZBHMif
	AiIuRxK9C1vDDceN/JCaFMAVqb6D/jczKpx6wAIpxp/y3FFb01b/AtvTW8de+SiW
	l+ZRrpMAwDbTXErSk1ihRoveK1byL3dae6ZzWUh/bvCdrq+73fE+Mb42x6CxELeH
	bVDHdypL1G10Uf3l6MWLNn2AgRozSbZA3+5smek9SzoO5HVJHz1eLZYtUvoDvCC7
	ag28QyxVIqm7kN6kLZHfuoOCFU9+Mn2/r4qdtf/oGMtiHKL1r8tbeUIUIugfZKZY
	E+zWA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42msuk0fn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:34:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Nov 2024 03:34:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Nov 2024 03:34:22 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 36B3F3F704C;
	Fri,  1 Nov 2024 03:34:22 -0700 (PDT)
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
        "Abhijit Ayarekar" <aayarekar@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>
Subject: [PATCH net v1 1/3] octeon_ep: Add checks to fix double free crashes.
Date: Fri, 1 Nov 2024 03:34:13 -0700
Message-ID: <20241101103416.1064930-2-srasheed@marvell.com>
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
X-Proofpoint-GUID: gy_uOJfeCAfpcie5eXqPb7QJUOBdNnhl
X-Proofpoint-ORIG-GUID: gy_uOJfeCAfpcie5eXqPb7QJUOBdNnhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

From: Vimlesh Kumar <vimleshk@marvell.com>

Add required checks to avoid double free. Crashes were
observed due to the same on reset scenarios

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../ethernet/marvell/octeon_ep/octep_main.c   | 39 +++++++++++--------
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  2 +
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..ff72b796bd25 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -154,9 +154,11 @@ static int octep_enable_msix_range(struct octep_device *oct)
  */
 static void octep_disable_msix(struct octep_device *oct)
 {
-	pci_disable_msix(oct->pdev);
-	kfree(oct->msix_entries);
-	oct->msix_entries = NULL;
+	if (oct->msix_entries) {
+		pci_disable_msix(oct->pdev);
+		kfree(oct->msix_entries);
+		oct->msix_entries = NULL;
+	}
 	dev_info(&oct->pdev->dev, "Disabled MSI-X\n");
 }
 
@@ -496,16 +498,18 @@ static void octep_free_irqs(struct octep_device *oct)
 {
 	int i;
 
-	/* First few MSI-X interrupts are non queue interrupts; free them */
-	for (i = 0; i < CFG_GET_NON_IOQ_MSIX(oct->conf); i++)
-		free_irq(oct->msix_entries[i].vector, oct);
-	kfree(oct->non_ioq_irq_names);
-
-	/* Free IRQs for Input/Output (Tx/Rx) queues */
-	for (i = CFG_GET_NON_IOQ_MSIX(oct->conf); i < oct->num_irqs; i++) {
-		irq_set_affinity_hint(oct->msix_entries[i].vector, NULL);
-		free_irq(oct->msix_entries[i].vector,
-			 oct->ioq_vector[i - CFG_GET_NON_IOQ_MSIX(oct->conf)]);
+	if (oct->msix_entries) {
+		/* First few MSI-X interrupts are non queue interrupts; free them */
+		for (i = 0; i < CFG_GET_NON_IOQ_MSIX(oct->conf); i++)
+			free_irq(oct->msix_entries[i].vector, oct);
+		kfree(oct->non_ioq_irq_names);
+
+		/* Free IRQs for Input/Output (Tx/Rx) queues */
+		for (i = CFG_GET_NON_IOQ_MSIX(oct->conf); i < oct->num_irqs; i++) {
+			irq_set_affinity_hint(oct->msix_entries[i].vector, NULL);
+			free_irq(oct->msix_entries[i].vector,
+				 oct->ioq_vector[i - CFG_GET_NON_IOQ_MSIX(oct->conf)]);
+		}
 	}
 	netdev_info(oct->netdev, "IRQs freed\n");
 }
@@ -635,8 +639,10 @@ static void octep_napi_delete(struct octep_device *oct)
 
 	for (i = 0; i < oct->num_oqs; i++) {
 		netdev_dbg(oct->netdev, "Deleting NAPI on Q-%d\n", i);
-		netif_napi_del(&oct->ioq_vector[i]->napi);
-		oct->oq[i]->napi = NULL;
+		if (oct->oq[i]->napi) {
+			netif_napi_del(&oct->ioq_vector[i]->napi);
+			oct->oq[i]->napi = NULL;
+		}
 	}
 }
 
@@ -666,7 +672,8 @@ static void octep_napi_disable(struct octep_device *oct)
 
 	for (i = 0; i < oct->num_oqs; i++) {
 		netdev_dbg(oct->netdev, "Disabling NAPI on Q-%d\n", i);
-		napi_disable(&oct->ioq_vector[i]->napi);
+		if (oct->oq[i]->napi)
+			napi_disable(&oct->ioq_vector[i]->napi);
 	}
 }
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
index 06851b78aa28..157bf489ae19 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
@@ -323,6 +323,8 @@ void octep_free_iqs(struct octep_device *oct)
 	int i;
 
 	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++) {
+		if (!oct->iq[i])
+			continue;
 		octep_free_iq(oct->iq[i]);
 		dev_dbg(&oct->pdev->dev,
 			"Successfully destroyed IQ(TxQ)-%d.\n", i);
-- 
2.25.1


