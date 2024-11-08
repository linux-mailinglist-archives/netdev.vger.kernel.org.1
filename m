Return-Path: <netdev+bounces-143220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB29C1730
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838F51C22047
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF01CCEC8;
	Fri,  8 Nov 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LZE1XEwz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1C19413C;
	Fri,  8 Nov 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051963; cv=none; b=asSp5UxBdbU5eVcxjWrnwXJXxtSAlNzZ0JTeIDQS1JakCLTMMYU56s/V8Pv1jJ2aaiHwxBZu16dJgsPMbzHJs4J+EcePsq1oSDR9uAl4mEwd0JfDRfm/vuqx6BoL06Zqnt1gZGQTQn/gye388wYtE5o9OWjSTP8ryjZOWGXiY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051963; c=relaxed/simple;
	bh=Zs8gFtkTw+B6KPpY+wmbVRHM3m/7uJgOKkx3TO7v+7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elClHV2XvpstNcMoNnjIhfzWkkGOIa8MDThhD8Yn7OyCBCDi6ivsJOjT+A9jGvAZnWpDD23Ra79kQOFbQ9ECb1f1qOwuYfOCmAfsl3I3yWQvooa1FYXNvnWIfIf7Vsho2Q1J04DynVjPChLPrj8Uk29hnvPUqV6w0KbKI1O8c04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LZE1XEwz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Mbhrb022685;
	Thu, 7 Nov 2024 23:45:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
	srYLFOETu+JgthTNSS2RvNaO0lAW/qGZVqi8P6UMPc=; b=LZE1XEwzlnspAYNqa
	EA+f5Uy5Fa9+PkMYWSJD5Enq3Wm2s/laRg0K2/VPHv6dMIPYNvX1t9Ifs9oAcysS
	RYqd34okq/4sGLZjNyPGh2IPlI2Cyqmw1eTrwO1O14IjxRUYSWq2LTwogsmMad/2
	0qJtZf4nmn3YIdD+NnhPUnh4LZIuTkBJvw/OFXS17Gxon2yri/idLAPxZRbNW5ON
	fBqdteI17j8kA/ovIN1KX1PqS4xaETUmBYUJM1WtgCH3wSgdjH6/IfuUMZplS+rh
	ExTUb2VR9ozjpj+cth+q4nl5dp9rLYKOBMmrAkYH2rh9pRXY6IUyV1IqDqw+l0GX
	7Rxiw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42s6gu90ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 23:45:48 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 23:45:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 23:45:47 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 252673F7082;
	Thu,  7 Nov 2024 23:45:47 -0800 (PST)
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
Subject: [PATCH net v3 1/7] octeon_ep: Add checks to fix double free crashes.
Date: Thu, 7 Nov 2024 23:45:37 -0800
Message-ID: <20241108074543.1123036-2-srasheed@marvell.com>
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
X-Proofpoint-ORIG-GUID: 0f8NN1etRcISq0lXzhN26H_MM1F4OhT9
X-Proofpoint-GUID: 0f8NN1etRcISq0lXzhN26H_MM1F4OhT9
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
V3:
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-2-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20241101103416.1064930-2-srasheed@marvell.com/

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


