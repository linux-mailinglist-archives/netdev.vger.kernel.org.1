Return-Path: <netdev+bounces-211768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38736B1B986
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 19:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34CA6252BC
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F292192F4;
	Tue,  5 Aug 2025 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IF/5BKLI"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEFE1514F7;
	Tue,  5 Aug 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415513; cv=none; b=gAuLJ0V3THb1Y7rTk8Qe0Ci7b+ATUDeOqw2EtYi9qD5DOf2lVnC0IRUZkdu7Dm6MaDqmhgcn6FfvGB3Tmt1pg1+ODkydQkU15QOiODpl7hWRi0rRLQvQzzsX8i827+M9ngvTxajNZECRmVPnvHknwUyAB7nenMtaDLMRfGkOdwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415513; c=relaxed/simple;
	bh=ODI52osLq9cBBrg7yKHaYNujTOba9aH9m0mhKntxTNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvDX3G6ovPsLugbWUmf/3QKKf41YoOFV5F88FJd/vLcYTJKUdd2d1Wai2NgsZ6RSi0Hh0+KXnlCUDRJGWoz91iokAWnpXOXgJ+seWhPQIBqFvYfAVlgfpLm1epZgjQH1+bYjnR4haa1ytqyn/1l3Q/lXela6bjl6JhCCx1EOxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IF/5BKLI; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575HcGwF4130069;
	Tue, 5 Aug 2025 12:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754415496;
	bh=s18WFXX2xFpugqPWrdba5WWTH+gIceXYCJkxr6yDshY=;
	h=From:To:CC:Subject:Date;
	b=IF/5BKLIxqUHocK/Eyo1I3g7NMfHDeWgt9GIsAyYzA2z6eOJhQFn5YkgvMLXEH4xz
	 d9fIvB22KouUuxr2IV7ARBf5hiIAmYi0QI/9Ku2+of5GCG/mDEbMf91k8HrMKI6lSH
	 IB0Mi2w5BU0nvW6ppPvkxLNKIuzW5wViUW8CgnvU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575HcGN12467066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 5 Aug 2025 12:38:16 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 12:38:15 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 12:38:15 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575HcFDs4145821;
	Tue, 5 Aug 2025 12:38:15 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 575HcETT003958;
	Tue, 5 Aug 2025 12:38:15 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Meghana Malladi
	<m-malladi@ti.com>,
        Himanshu Mittal <h-mittal1@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v3] net: ti: icssg-prueth: Fix emac link speed handling
Date: Tue, 5 Aug 2025 23:08:12 +0530
Message-ID: <20250805173812.2183161-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When link settings are changed emac->speed is populated by
emac_adjust_link(). The link speed and other settings are then written into
the DRAM. However if both ports are brought down after this and brought up
again or if the operating mode is changed and a firmware reload is needed,
the DRAM is cleared by icssg_config(). As a result the link settings are
lost.

Fix this by calling emac_adjust_link() after icssg_config(). This re
populates the settings in the DRAM after a new firmware load.

Fixes: 9facce84f406 ("net: ti: icssg-prueth: Fix firmware load sequence.")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
v2 - v3: Dropped the if check as it was not needed.
v2: https://lore.kernel.org/all/20250801121948.1492261-1-danishanwar@ti.com/ 

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 2b973d6e2341..6c7d776ae4ee 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -50,6 +50,8 @@
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
 
+static void emac_adjust_link(struct net_device *ndev);
+
 static int emac_get_tx_ts(struct prueth_emac *emac,
 			  struct emac_tx_ts_response *rsp)
 {
@@ -229,6 +231,10 @@ static int prueth_emac_common_start(struct prueth *prueth)
 		ret = icssg_config(prueth, emac, slice);
 		if (ret)
 			goto disable_class;
+
+		mutex_lock(&emac->ndev->phydev->lock);
+		emac_adjust_link(emac->ndev);
+		mutex_unlock(&emac->ndev->phydev->lock);
 	}
 
 	ret = prueth_emac_start(prueth);

base-commit: 4eabe4cc0958e28ceaf592bbb62c234339642e41
-- 
2.34.1


