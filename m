Return-Path: <netdev+bounces-142839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45FB9C0763
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8725D282B0B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC9210197;
	Thu,  7 Nov 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YW5i7ypk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E220F5A5;
	Thu,  7 Nov 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986154; cv=none; b=BvMpMTbOl63ThBkDR4vVFoEVVxSRG0SgSYxEoZqQUcTs7xJVaxUakEZM022AOgoiPu1L0amjQc++r1fPUSBXfsTOQnrR1FRVccY9WueI/FNv2Kmzw74aGPRYFm9FkH9px4ADu0xz9We7eR1XdAoLYTxt0dberXdlWTRKwTYNj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986154; c=relaxed/simple;
	bh=/IrWnmOwo9gIA0TRD6u7nsOjh113GsC4TAyK4EThEIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THv243kaawpEsHgMFjC0do8H3JT19kqBfPAmFnHfegBTb1KXMpWaFTgSbxDNJn1JQTAyKetc2334By2OdlOOv2h0ngDmn50heoEIFa9IEOIy4mFudO8/AdZKjBQOw0l68sg3ie+0UkEAO6wnXJiIn26N3cSrG2joW16xUnx3hic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YW5i7ypk; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7B6b54010781;
	Thu, 7 Nov 2024 05:28:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	jE+HKIwCXE95MzNqYyE5e7AkrFb9SDdDSuMm2NswYc=; b=YW5i7ypk+3sy2RqOw
	vrQQHJO4wM9F1jLy/qg110kZwSGTJBwTh3ToOEc4n4JxhvQz4f+3/By/b8brEknW
	NyaHtX2xnYtWPjnwbv3hGg8dcmzvpQMAVDCSFe7Gq2hwonS2x0nlLRYJBAD7Hzxy
	WfPKgZ5RhZNuDsnG+F3nQZN0MYXJ9a8Rd/PDtKdfGdAvoFwg/V42IdRmG+gleXJU
	prp6plFX0ZcLBsw8C9lY44ySXBg067PzOktxNW71r/RQOaQJX1xQhYcfaYIaUWFh
	hrY5JbwrBHGzgteoJKsrRPkNTvZLWOhCG7d0AiTX8aJSUC4PEXWauM+e6qSkF4tO
	9J/VQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42rvcw0961-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 05:28:59 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 05:28:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 05:28:57 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 131FD3F708C;
	Thu,  7 Nov 2024 05:28:57 -0800 (PST)
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
Subject: [PATCH net v2 1/7] octeon_ep: Add checks to fix double free crashes.
Date: Thu, 7 Nov 2024 05:28:40 -0800
Message-ID: <20241107132846.1118835-2-srasheed@marvell.com>
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
X-Proofpoint-ORIG-GUID: vXNR5pH4jkOuF_O4_aIGicqHD6ubBqwn
X-Proofpoint-GUID: vXNR5pH4jkOuF_O4_aIGicqHD6ubBqwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

From: Vimlesh Kumar <vimleshk@marvell.com>

Add required checks to avoid double free. Crashes were
observed due to the same on reset scenarios

Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
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


