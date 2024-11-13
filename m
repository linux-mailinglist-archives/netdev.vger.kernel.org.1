Return-Path: <netdev+bounces-144376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F099C6D8F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F73281F2F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA1E200CBC;
	Wed, 13 Nov 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LHLWmUsr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77419200C95;
	Wed, 13 Nov 2024 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496428; cv=none; b=bD2dL+YNkAp6Ix9r7laY2G++XBrjjr8JHeZEX16zwrpPXhR89L4VavYFt7cU3M8y8cAvFvGPMtr6z56PLyImx5c7LM0YQ0/uTif+ZOgqWffNWi2pUXeeaFcd0Bml9S9EMmHr74voYG/nYIpkIw4yMUd0gUFplNO3VpjL1mKVuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496428; c=relaxed/simple;
	bh=mgeBw3UfjWrFpxqOauct6irHUI45weMx4yTLRTrcxUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQ1s66T9TorBYq3/vj5fQtVBz0RpwxUzqMAx4nUKak2Nq62qmYymxjDavf1u4VYM5L3hjSf6c2sRJXwQHc2SXMoI5RvNoBG5RhBwFml2e1StdTaebsnjFZO9QjvHEEQNL0PbEkQi5CQocnqgBRyXQQ/8CfHs0ZR8rO2y+zGDcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LHLWmUsr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9Avi7004399;
	Wed, 13 Nov 2024 03:13:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
	21x6UKq40vBWyAGfY0XuZoMJ5czzxDqvdLvujUD+CY=; b=LHLWmUsr/zJE/bi38
	Ut/pDACHuU8Wvg2hxZiNGe75CY0wb+ViHWu08lD4Ql/J5fvndglvxLykM+fgj6PP
	91+yH9W+r+n82qeFCSHrBH5XxEhlf9uKtr8/cfBcXrmsjWF0LmWZmVozInBwU3Zx
	2uXqZInSM3dA17qR0V+a0S+4Q1xnfBC26GpTuWzAwbFJhHurr/Z4S7JOdNxZWeCp
	wCHMtxjn5z0Qi6PRnx849E48s9xgUcdefhsvWu4EIVD/Bk0+zbLz2zn36pd7BUfn
	oGFSHGCbGijOFFp0NGZy5kexgzGJ41o4hTt0ObcbLo/YQnvTHKzUVk8NHOwo77cI
	Y7b6g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42vs8g06dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:13:25 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 03:13:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 03:13:24 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id B84443F7040;
	Wed, 13 Nov 2024 03:13:23 -0800 (PST)
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
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: [PATCH net v4 1/7] octeon_ep: Add checks to fix double free crashes
Date: Wed, 13 Nov 2024 03:13:13 -0800
Message-ID: <20241113111319.1156507-2-srasheed@marvell.com>
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
X-Proofpoint-GUID: H-XZc3n7iDDvzsPE4v0m6XqdrQs7gfyk
X-Proofpoint-ORIG-GUID: H-XZc3n7iDDvzsPE4v0m6XqdrQs7gfyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

From: Vimlesh Kumar <vimleshk@marvell.com>

Add required checks to avoid double free. Crashes were
observed due to the same on reset scenarios, when reset
was tried multiple times, and the first reset had torn
down resources already.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - Removed unnecessary protective code. Added fast return from
    octep_free_irqs()
  - Improved commit message

V3: https://lore.kernel.org/all/20241108074543.1123036-2-srasheed@marvell.com/
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-2-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20241101103416.1064930-2-srasheed@marvell.com/

 .../net/ethernet/marvell/octeon_ep/octep_main.c    | 14 ++++++++++----
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c  |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..29796544feb6 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -496,6 +496,9 @@ static void octep_free_irqs(struct octep_device *oct)
 {
 	int i;
 
+	if (!oct->msix_entries)
+		return;
+
 	/* First few MSI-X interrupts are non queue interrupts; free them */
 	for (i = 0; i < CFG_GET_NON_IOQ_MSIX(oct->conf); i++)
 		free_irq(oct->msix_entries[i].vector, oct);
@@ -505,7 +508,7 @@ static void octep_free_irqs(struct octep_device *oct)
 	for (i = CFG_GET_NON_IOQ_MSIX(oct->conf); i < oct->num_irqs; i++) {
 		irq_set_affinity_hint(oct->msix_entries[i].vector, NULL);
 		free_irq(oct->msix_entries[i].vector,
-			 oct->ioq_vector[i - CFG_GET_NON_IOQ_MSIX(oct->conf)]);
+				oct->ioq_vector[i - CFG_GET_NON_IOQ_MSIX(oct->conf)]);
 	}
 	netdev_info(oct->netdev, "IRQs freed\n");
 }
@@ -635,8 +638,10 @@ static void octep_napi_delete(struct octep_device *oct)
 
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
 
@@ -666,7 +671,8 @@ static void octep_napi_disable(struct octep_device *oct)
 
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


