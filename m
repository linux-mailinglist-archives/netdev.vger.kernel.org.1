Return-Path: <netdev+bounces-236213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE085C39CCE
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 10:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 795213505ED
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27830BF52;
	Thu,  6 Nov 2025 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o4zA0NHy"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C680747F;
	Thu,  6 Nov 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421054; cv=fail; b=rPM3pXw73Wtv4QTUH5L3TDitgCtv1DlLQy+VwYBDzShPv9Ed2zIwvLT4WqvkCUjebx5gk8YbaGk3cUb/kq9kzORZxNnUsdLdSqZIXaJkvXelwi2mUk4IjHqsTRq5bAj1tB5/A1jMTgTz/yDL3BcY20AeqIpu6ADomDa4nYgcRy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421054; c=relaxed/simple;
	bh=pEiBClPig+Z5cHqHkaS8c11x0mgZfgYC4nJgnrYfrA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnOrqLbMwCxDa5BhcrtkJF3pl/f7ltW5mZqZ4vSbyhM3fBQ4yHcWWHCFTMq+Q+BxYX6hEKf49m3I3J7R7UljF+h/Lj7Y26+CGoEt3TyXv6fibW9ioIQrDbIrR0vxT0S2OK3UotP0IZakXFbUia1ZM9c3o91h+6aH3d6vRR0U04Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o4zA0NHy; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRvyizCZ2qrt/cUDWlqFgDZMGD5gJXMCk4zk+RK5RC8TVYt9ABnlIbo0MqQSb5tWB+D8tyWnDcdcYD02NYVsVtSEqRaHnJE8XzkeS2nCB4aF7/GMxbp+ZcUdRjbhKM/h7osusKMjUUdpnYW8gRCA3hxXG/60XiMYhjqs2cCWw80kH1Gb1h8De5q9Kyp6LVBi+CDU5773iLvBo80ySNvpinZExeqpPE8YvTQ2pTFz2z3wQFYiERojH5xAHZ8qSWnDU30VDxtLZ46drEiTMlOki7IlzP9wdVTi1Ils3EUw9jljCUhGCYvL+9moIy5v+sClgrgQ/96ZhFe5vmUFoSHmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flOzYGBbiEXXPzhnUCu0rDyNpC21Ud6gOb5pj+TAPmY=;
 b=mxXhQZONmDuZRkU3hZASzmTB+B9UgchDIGROkza85hCfBX2K/m765BzRP1RjX2oax+bixXZShVLgsGiNNHDGhzJ5/cQrL9FJ1HzxpBE9oGrT/N4yVBqNIcPhzmTEj3Wkc0rnMAImUrcR6+KT2rTACBWnzt/DU1Tw2byZQPZw4Fo32iuaYpNIrBqDz/24RD/2lZvXiiN905tD0IozmeLdK01rRBg7WLJyzebJyRZwF+2XhuzzhsQbZgseBZe5W5YOPITJYAFXNJoidSypE2uLToumHdfB2CvxjikLxeFq6DKa8d8mDwrSSQbj3yj0kVj4NvdRKg9PxK28+jnPcBnehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flOzYGBbiEXXPzhnUCu0rDyNpC21Ud6gOb5pj+TAPmY=;
 b=o4zA0NHyzZPgd0OKuT8+Iydi29q2P6Z8Y6pbuLM3BDyv5fxI6OQ/PynC6iD73FooKZKv4B4NFMBrCZ9cbdvNg7Muazd6wI8wnEzko6z7FDxLa4Hnu13KlnSPuQZ7mRmMLSQhRUg25dXNKYrk9t/JfgxqxK8xn7RhLHloLAOVkF4=
Received: from DSZP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::8) by
 CH3PR10MB7988.namprd10.prod.outlook.com (2603:10b6:610:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 09:24:07 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:280:cafe::82) by DSZP220CA0007.outlook.office365.com
 (2603:10b6:5:280::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 09:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:24:05 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 03:24:01 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 03:24:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 03:24:00 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A69NXmo1034235;
	Thu, 6 Nov 2025 03:23:58 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>
CC: <linux-kernel@vger.kernel.org>, <c-vankar@ti.com>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH net 2/2] net: ethernet: ti: am65-cpsw-qos: fix IET verify retry mechanism
Date: Thu, 6 Nov 2025 14:53:05 +0530
Message-ID: <20251106092305.1437347-3-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106092305.1437347-1-a-garg7@ti.com>
References: <20251106092305.1437347-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CH3PR10MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f33d9ac-e7ab-4086-ce78-08de1d163b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OISbUk8GLIO95zHa0FHI5LEEPAS3bxqqlDm7NW8gY53GDqij1/7PNrkenw4G?=
 =?us-ascii?Q?ncrFZE9pAAQ8cUqKwTsG82r2dkoRzaZAnhZuJa+cVSZnaWUCbk+jvDrJsSFm?=
 =?us-ascii?Q?3tEfocnGA58Psmg856WlP6vF+KHwDS90WPBWADMfBd3gGBjo13Jul/Fmf5Jq?=
 =?us-ascii?Q?kyMeSK36G3dGN81nIxDVs2UG3MQRC0S2tusMD44vhQUIPiUMcdamsRLzrznP?=
 =?us-ascii?Q?vwQf0eK/Z5v8zVOpfAoIbnzsmp0D7cPDHef8teluqcW7+3H1UkB0V1hzk0g2?=
 =?us-ascii?Q?8UfzCAzQz8HSgTrjbeSdhrmxkeu9JdbJIcfl4dr/168ORjXWSM97TIZlkNCV?=
 =?us-ascii?Q?BJxS7hv3ZsOsu2sg2RedZU0bh/+SzvkXrYMPSwDufphLaka4ZBH5ged+P/9H?=
 =?us-ascii?Q?1AnojymEewo+sSYLRj3MAqqC7P3ANqssEneTmQMuwhckLyKERvFVpSsvl6Mj?=
 =?us-ascii?Q?G+dhrgx/hMp/0Trz0K7lgPpbLqX8dobcnQbs5ebzRtY9zk63HQSIOvTJscBY?=
 =?us-ascii?Q?iILgDZ0iuc9hmpl07JgBSLLlqWZK8TZr1AVi89PHSrhQZfuUN3FyPBMqyopk?=
 =?us-ascii?Q?wQvc2rf4NS2A5p1rCRS5LyC/vdzDq/Oev+Kjp0DBRkNsiuTWSzOKZLNv5HkV?=
 =?us-ascii?Q?ujWvU+4AmVbOJ/dNa1j0PW61Rftbgtn1KOYDThpwOWDALKyITdmw/0a9HpS3?=
 =?us-ascii?Q?wqnFfnIro4SxicyNaLbKrm9lQjYhhDlY/K9/7nc85IiAYPvFHzjbA1oHOMI3?=
 =?us-ascii?Q?mLQyJKWduOOFQ+QI+nZxX15aT5DA1l5S+rneWoXYqzYXPQL3RwB/u9dNO+o5?=
 =?us-ascii?Q?meVhVaFtVmlgIuU7Xubl5xRLO2GUoelJdPZEZwCsQta12+y+2VyXRbNIhEf6?=
 =?us-ascii?Q?XIWSkKjZQTkQg751ZFJMNXSo3lMAw2QqMrh5G4eVwYckU7LLEsYqEjww6Fxe?=
 =?us-ascii?Q?AgE0IHWC3DyME9h/0lPnakD14Eu2R0O5gyxZy/zyp7hxo5qvOKXjn1rtT3Ae?=
 =?us-ascii?Q?UfECwKJu+kSh1vapZjiWpqu0m+4lWAm6XIpBWhYlNPaxyEyQufiJ1BBmrhDR?=
 =?us-ascii?Q?GISiJBBhgZvcjkKts8HYPNyoweYKBa/ufhGQIalXp4mURh1nfMWZ7qKWDTFK?=
 =?us-ascii?Q?DSzvY3uh7UvE6qWZ03zPxCa3Up1Zg+rQ/GGd6ATUoI+fjPyu3aV0ppaF2ROV?=
 =?us-ascii?Q?c5p8Ray6/GQDOe7YKlHyCpf50y2LzgW48WmORyl1Oe5/cIg6VbozVUw9RJ4E?=
 =?us-ascii?Q?nbEkahWilTI7cmQMip/XPQkaHoDY4v+If8l2qC7fqsIjTCPBwBxdOy+1FiW1?=
 =?us-ascii?Q?wKTZZmj7gZloKYSIuI+3QSZLmcya5KRgvTlT6yJrrr4R4HCCgj3+EaaRQ7yS?=
 =?us-ascii?Q?JbwgwDIQdlWgGxH2qWwQ3GSKYuH+Crse6nJB3M0gXYm311IIc7WCZUX67Vdd?=
 =?us-ascii?Q?p9V0awb9cd5WH/aK7MXJ86p6+Z+uyM3Q88sIFxfajPmxKAR1AP/vXlgR2WHu?=
 =?us-ascii?Q?shdP1GhCvaEHfQaiHRAFfuJyhqMLvlUKal7IKENKnD0KWpRlRF7tllssbl58?=
 =?us-ascii?Q?R7SWybFrVkiL1uspkhw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:24:05.5032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f33d9ac-e7ab-4086-ce78-08de1d163b5a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7988

The am65_cpsw_iet_verify_wait() function attempts verification 20 times,
toggling the AM65_CPSW_PN_IET_MAC_LINKFAIL bit in each iteration. When
the LINKFAIL bit transitions from 1 to 0, the MAC merge layer initiates
the verification process and waits for the timeout configured in
MAC_VERIFY_CNT before automatically retransmitting. The MAC_VERIFY_CNT
register is configured according to the user-defined verify/response
timeout in am65_cpsw_iet_set_verify_timeout_count(). As per IEEE 802.3
Clause 99, the hardware performs this automatic retry up to 3 times.

Current implementation toggles LINKFAIL after the user-configured
verify/response timeout in each iteration, forcing the hardware to
restart verification instead of respecting the MAC_VERIFY_CNT timeout.
This bypasses the hardware's automatic retry mechanism.

Fix this by moving the LINKFAIL bit toggle outside the retry loop and
reducing the retry count from 20 to 3. The software now only monitors
the status register while the hardware autonomously handles the 3
verification attempts at proper MAC_VERIFY_CNT intervals.

Fixes: 49a2eb9068246 ("net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index ff68a56796a7..22530eec4953 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -317,20 +317,21 @@ static int am65_cpsw_iet_verify_wait(struct am65_cpsw_port *port)
 	u32 ctrl, status;
 	int try;
 
-	try = 20;
-	do {
-		/* Reset the verify state machine by writing 1
-		 * to LINKFAIL
-		 */
-		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
-		ctrl |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
-		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	try = 3;
 
-		/* Clear MAC_LINKFAIL bit to start Verify. */
-		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
-		ctrl &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
-		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	/* Reset the verify state machine by writing 1
+	 * to LINKFAIL
+	 */
+	ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	ctrl |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
+	writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
 
+	/* Clear MAC_LINKFAIL bit to start Verify. */
+	ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	ctrl &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
+	writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+
+	do {
 		msleep(port->qos.iet.verify_time_ms);
 
 		status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
@@ -352,7 +353,7 @@ static int am65_cpsw_iet_verify_wait(struct am65_cpsw_port *port)
 			netdev_dbg(port->ndev, "MAC Merge verify error\n");
 			return -ENODEV;
 		}
-	} while (try-- > 0);
+	} while (--try > 0);
 
 	netdev_dbg(port->ndev, "MAC Merge verify timeout\n");
 	return -ETIMEDOUT;
-- 
2.34.1


