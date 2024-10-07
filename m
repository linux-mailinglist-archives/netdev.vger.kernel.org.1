Return-Path: <netdev+bounces-132583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC29923ED
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 07:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB98282ADA
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 05:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D671422A8;
	Mon,  7 Oct 2024 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fVWIMxIQ"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6813B797;
	Mon,  7 Oct 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728279721; cv=none; b=mf5yx7afa+KoxffibooqC39hZnbiJdPnXVxix+B6Vy0y3Jb3pHhFBKQLSl0YX9bN+Ch25c3HvR/4yAgTTm7guHLlRBdX1MonLGje66DHhAuIuBiqfy9pmZ/lXBonddhBpyFTB2DCmp1dsssWtkTqk72GdVkqpOxGxCrNSDo+SNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728279721; c=relaxed/simple;
	bh=P5WpJSFMhe/LxeegZADuRdkunnCVSBG6Td4FAA9WJcQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LoFDGBfNIyIRvIc07v647nMJjLXaCu5oZuI/7QOV7Q1ZaTrhKWWpG3a+/YwYHkbHcsopD4J1/3gHWh/FAq0A1sMf9vC6eRxdXdrZ+78zc1LlV6rf98Oavf+3aW7CaDr/BwCFTd0MMxxBpcabuMpIJ9NEj7i0YdNnHitEAartc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fVWIMxIQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4975fS7K119825;
	Mon, 7 Oct 2024 00:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728279688;
	bh=nP6DdgH29tvlsuXDNcF1Ajyp5JiV1/oAb/SSYPduwc0=;
	h=From:To:CC:Subject:Date;
	b=fVWIMxIQlb3CsUZwKYUQXe3OXGlrYg7j7xoUCNI3kbx9a7k6H6SZCeTDBEWBu2b6H
	 4/dywVxIxjh43oCaCfFVXl6ZanJlh/M7n5S1NsH6f9szhfIT+XpNyuXfzhI8ZRhpuV
	 o3Nyx5mv0UvGeb8q4pdaHcGWbHVpWEg2Wlrm1f4k=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4975fS5o013121
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Oct 2024 00:41:28 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 00:41:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 00:41:27 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4975fSr5082390;
	Mon, 7 Oct 2024 00:41:28 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4975fR05013265;
	Mon, 7 Oct 2024 00:41:27 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <robh@kernel.org>, <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>,
        <andrew@lunn.ch>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2] net: ti: icssg-prueth: Fix race condition for VLAN table access
Date: Mon, 7 Oct 2024 11:11:24 +0530
Message-ID: <20241007054124.832792-1-danishanwar@ti.com>
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
v1 - v2:
*) Fixed kdoc and checkpatch warning by moving kdoc inline for vtbl_lock
as suggested by Jakub Kicinski <kuba@kernel.org>

v1 https://lore.kernel.org/all/20241003105940.533921-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_config.c | 2 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 2 ++
 3 files changed, 5 insertions(+)

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
index bba6da2e6bd8..8722bb4a268a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -296,6 +296,8 @@ struct prueth {
 	bool is_switchmode_supported;
 	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 	int default_vlan;
+	/** @vtbl_lock: Lock for vtbl in shared memory */
+	spinlock_t vtbl_lock;
 };
 
 struct emac_tx_ts_response {

base-commit: 9234a2549cb6ac038bec36cc7c084218e9575513
-- 
2.34.1


