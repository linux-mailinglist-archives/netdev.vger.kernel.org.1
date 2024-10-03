Return-Path: <netdev+bounces-131556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C498ED7F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B1F28414A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7D154458;
	Thu,  3 Oct 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G3SzchAM"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB914F9F7;
	Thu,  3 Oct 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953231; cv=none; b=XANXtze069w7/KkJ5ZWWlPVBQcYIodfWGCOBFE0NBnA4+5fH5V1kCILPZi4nBqMXEd9hU6653Iy2jh4t11ELa6GwLZvofYVHIDWroxesCHU4Ce95pB9mI24e15MLfxyUAUAF7R/xDlrYQM+NLEBjWIwbeecxmuXlCJZe9IuMqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953231; c=relaxed/simple;
	bh=AhT8Jx5J0jBQrUxZDVWjpykIF2lktRmZRdWQ/Ubs03o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HDeuaXDiJiALZyjUIG3zNBWZqBJ2vBIAKP3Fvf3q4cKinZH8AQAIFV7SPG3+xcJ7b+vwm8cVI8N8C+2ygJp7xLqWiaO2xdP7Xd9GDPTP4PKV8+rn8lzyVElQcaZTXrgcXPjZKlPv2AF3wYlpZ9WonYUOg6bXs/M6ZkDoXLIgP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G3SzchAM; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 493Axlb5084747;
	Thu, 3 Oct 2024 05:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727953187;
	bh=0oNlgkGKBB7nqfkE4spydYXDvRPd4v605UN/Gf0JBqQ=;
	h=From:To:CC:Subject:Date;
	b=G3SzchAM4ROodC5IEvPsgWWejwBj3AFE/wBFPBbV3zXILC2SGyOtaPDqkIvRz9eZ3
	 rsD3qPi9dJl7ciTF2rG3AKEexmQbtlButZB4G9aWYqvg5WRgTY3NqnaEOl+vdeP0q2
	 sAiID50CubujmIbAeEFs5SiKyV9veRLDAMXsqjo4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 493AxlNe022449
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Oct 2024 05:59:47 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Oct 2024 05:59:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Oct 2024 05:59:46 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 493Axkld024127;
	Thu, 3 Oct 2024 05:59:46 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 493AxjEJ027649;
	Thu, 3 Oct 2024 05:59:46 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <diogo.ivo@siemens.com>, <andrew@lunn.ch>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix race condition for VLAN table access
Date: Thu, 3 Oct 2024 16:29:40 +0530
Message-ID: <20241003105940.533921-1-danishanwar@ti.com>
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

The VLAN table is a shared memory between the two ports/slices
in a ICSSG cluster and this may lead to race condition when the
common code paths for both ports are executed in different CPUs.

Fix the race condition access by locking the shared memory access

Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.c | 2 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 72ace151d8e9..5d2491c2943a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -735,6 +735,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
 	u8 fid_c1;
 
 	tbl = prueth->vlan_tbl;
+	spin_lock(&prueth->vtbl_lock);
 	fid_c1 = tbl[vid].fid_c1;
 
 	/* FID_C1: bit0..2 port membership mask,
@@ -750,6 +751,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
 	}
 
 	tbl[vid].fid_c1 = fid_c1;
+	spin_unlock(&prueth->vtbl_lock);
 }
 EXPORT_SYMBOL_GPL(icssg_vtbl_modify);
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 5fd9902ab181..5c20ceb164df 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1442,6 +1442,7 @@ static int prueth_probe(struct platform_device *pdev)
 		icss_iep_init_fw(prueth->iep1);
 	}
 
+	spin_lock_init(&prueth->vtbl_lock);
 	/* setup netdev interfaces */
 	if (eth0_node) {
 		ret = prueth_netdev_init(prueth, eth0_node);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index bba6da2e6bd8..9a33e9ed2976 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -296,6 +296,7 @@ struct prueth {
 	bool is_switchmode_supported;
 	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 	int default_vlan;
+	spinlock_t vtbl_lock; /* Lock for vtbl in shared memory */
 };
 
 struct emac_tx_ts_response {

base-commit: 1127c73a8d4f803bb3d9e3d024b0863191d52e03
-- 
2.34.1


