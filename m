Return-Path: <netdev+bounces-133448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750A6995F0E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE971C23819
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 05:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4427169397;
	Wed,  9 Oct 2024 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tJDUcpzX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF017B439;
	Wed,  9 Oct 2024 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452416; cv=fail; b=IDL6neWunL6ycAAzgmfwpAWF2F6X0l8YsM1+FcEXlXkJEiPdhl4CDH0SvDeH+dDJanXqaYyfGQUb4Pvuy2JiUXf/MIAggphwtDfCDPRm6PTF+pPtTdN0d3whEM/4CL8BIcReHHh31YfUBhbG/QdA4zjyqqp/3XVK+dF6/2lMH2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452416; c=relaxed/simple;
	bh=1hvu3v9Qfka8m9gIWIrEYtfbE1GCJlqPTvNeHXqEs7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZ9ISzkBMK84knGdSStA37omRrj/GEiEZRGXRhrX2lsZ8JDo5nYe7QwwAq0NG8IBanHijcQ4zkhxtJOZI7El0gBs59igzk/ppTcWgZV+pnBNf6TnqS2z3ubgAiAqLXQSocqD/BlyR3rg4KJG+z74s5vne6uR+CBl4qnkp0wZ18s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tJDUcpzX; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+LyJyjy9YU7J7+hRJV66wv0IQ6wYpKyw7cHRUyKMZDwM4lCqHE8sVWm0Pehf3k+XqOv/bpPrO4Bsao++QsCYUazCPah9OCy7GWcy1/F3r6IcCMu8FO9SaNoNVXIk8Opd4LwkIx5Y8BmY/4RMgUE+W61fws7C7I/94X2OqSNA+pjcZphVHCY+Z+sf++t41xKe0EiAwJ+sqhaaseS78aqju+51LtA1hsvlVgp4yX4sjilav+cn4dD1pE826vaeaAlOu5ipNC92bcSTkx/WnK1o0RZWwEVbsda0/L5hPnOtJ1/ZSB+F83ABvkniOxD+++b5tF/4fXtnrbed2gjuRdt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pzf9aDcmR3z6M/HY0FJbU4U8fVqFs6i+hMu1HBmWqtI=;
 b=key+WPeAvZNpZtet0IlwqV9tw97+zLQLhpSE+J9hwMhwSwHLjChGKfPtEgOVWMpWcgOu3bHv6dOaNQi6UnWG2yga7W9o4MOlytw/VxMMVZQ7BC3nnVqkaX/mdE9aQcUofjVCbmHk1XLWPFf+18d1H18HmvvfA31aBFiYWtuGzf/zP7G9fp4eSlXh3feN0CeZV/l4AGC0uVJ2WwZ6Wv7fVK7pJKVmheIna92L2LzfV42FC35kNH9bmZWfnwueomFVy9Upa/hN+Ap06aolipQ5oTxKyysijt3uAYJNtqDx+TYmwBfbtE6jKnUTU4RCu20dK69wkPK+Og62Qkq12eZ3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzf9aDcmR3z6M/HY0FJbU4U8fVqFs6i+hMu1HBmWqtI=;
 b=tJDUcpzX40oWnmj8DdCSrvJt4uVI3mrp3ZQh7e8WqY1etldAeqlSW1ok0FbCwcySbDzG5qBTro35+i68tFV5muScK+AXuqL8yeQpw13Tkl6VtmRkNaMjvs0gQF74sKVREhUYmuccUhsQqzDktM2bmdfr0bjUChRzqqdpSCJexPE=
Received: from BY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:a03:1b8::20)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 05:40:12 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::ff) by BY5PR17CA0007.outlook.office365.com
 (2603:10b6:a03:1b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 05:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 05:40:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:40:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:40:06 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 00:40:02 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [RFC PATCH net-next 3/5] net: macb: Update USX_CONTROL reg's bitfields and constants.
Date: Wed, 9 Oct 2024 11:09:44 +0530
Message-ID: <20241009053946.3198805-4-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: a92a416f-2294-4e76-bcbc-08dce824d829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g6D2Owr1H22YuHkMMFucW0aE8U37st7U5xJYvuPhiD/p+mdTJV/RAscjn+y2?=
 =?us-ascii?Q?cfYxPX0pBi9xAG3Fe5tjLZmzaBAX3gc+B+2nAu5YrF9JD1O8qfSY9MdOQ3Ql?=
 =?us-ascii?Q?r5Ic18vzX0p5BYFI1F9ux3bzWHTxdNFMPh7YNaL5IsuBeUZ5dhuZf2QRChEm?=
 =?us-ascii?Q?3jwmEH2pBXTYOx1M3HTntrnwkBEHHtCkjqy9Xjyk7JO9LwdDx3/dEjCT9TXe?=
 =?us-ascii?Q?XdJ8Td2rAqARMbyNnyHIq1saco7z82Oij4PAjWSO4zP4YJiW/ksc3Eod8gL3?=
 =?us-ascii?Q?R9ufr3nbwRRB07/2mIXDa9sy90mgvn8mREIqAyKqoRf9Mx5AHN0N0Rq6yhG1?=
 =?us-ascii?Q?nKiCRhUpyNnc//btI9cFb7P6bNxE+Vxr8Bw1tRaHn25vY2CNyJnEIKAY1KVy?=
 =?us-ascii?Q?7zaTLUm5q3TUpyOTpVKH5Et18wCCw/KyZ+ZngyIFzBo3bT5hJIgKq+HSPxHf?=
 =?us-ascii?Q?+2LDoYWpMYyHaZ/kXttSrrU7N8olxJM+DzXeZHRTKQMf65iLp3D7PoSOJOBc?=
 =?us-ascii?Q?04FrTpa+BEk3XGbscXv533An6/PDei6ogvFkz6UILGU4wfhLKzc9+EeefU3c?=
 =?us-ascii?Q?Jeu8cMXUm9JGLYqTh7UylppRDUsKPZqqg3wqxfLh7JyU8OqZmOi/2+4A6eS6?=
 =?us-ascii?Q?qNdLku6W8tMR2oDbwuvu+nJGxFCQr9pJLyfhSinBnXsrAM1l/7CohvF6fhOM?=
 =?us-ascii?Q?OYkSQTPg3jmOGHTU94D8aldgmHLHaF40x17t7xEEJOk+QBamBsGqFKN81A9v?=
 =?us-ascii?Q?rrFU5us6WhWbqmrpRX4TV7qsuo5BcwWr0m1lYq7IQE8KWoEnPlZQH+B8V8zj?=
 =?us-ascii?Q?B/TU7wEaDwHfne5v4Y1/3CDa0DAYFoTll87QaPQVqEq8Xiq5iiSNj0epSeND?=
 =?us-ascii?Q?1NeflZYaz4isdcOqlnW0piat3ENzKjmicL1xXwCNGp5R4Sbl83GsbavHNEgS?=
 =?us-ascii?Q?OCGn+AoIjNBiz3NFCdcs+o5hO8XTvazzenDiCs0VEhkc2pkgmocDj0kbK8+e?=
 =?us-ascii?Q?2srzej8T71eoJMYOjo5TbcR0BMapfMg4fwjEvR3TjZJmQSRRzcbBGQtpFX4y?=
 =?us-ascii?Q?c/2DJaXGwcIXalwX7U8SRvnh9w5q2m5N8J/8d77dMM/kaUtkwxY18Lf1Qzq0?=
 =?us-ascii?Q?kQJchNX01CNMtKDr6YDr/BPw2fp9tfOvowumPBEndvvxfywWUUUVuLbaQM2C?=
 =?us-ascii?Q?EdTEh/6A3kSzqBSmydJ0uMOq4LtFfZDVZahyLJ36hGtwFTFgeplhVn+6HJJV?=
 =?us-ascii?Q?+T1K6sOAHYk9qJfKlIeOCZzmK930DFWs40aH5aKARGD3YzDZlhXvDE1Q35Fy?=
 =?us-ascii?Q?8kGl/9vGxCiJGK4QlkxEV8Z6/oXspzWoN9GkBJmnkKSdoPICoz74rQNLcty5?=
 =?us-ascii?Q?/iiskLwZ8xZ6Z7/lo74gUyvZ12rR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 05:40:12.1129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92a416f-2294-4e76-bcbc-08dce824d829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

New bitfeilds of USX_CONTROL register:
- GEM_RX_SYNC: RX Reset: Reset the receive datapath.

Constants of the bitfeilds in USX_CONTROL reg:
- HS_SPEED_*: Multiple speed constants of USX_SPEED bitfeild.
- MACB_SERDES_RATE_*: Multiple serdes rate constants of
  SERDES_RATE bitfeild.

Since MACB_SERDES_RATE_* and HS_SPEED_* are register constants,
move them to the header file.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      | 12 ++++++++++++
 drivers/net/ethernet/cadence/macb_main.c |  3 ---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 5740c98d8c9f..47e80fa72865 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -563,11 +563,23 @@
 #define GEM_RX_SCR_BYPASS_SIZE			1
 #define GEM_TX_SCR_BYPASS_OFFSET		8
 #define GEM_TX_SCR_BYPASS_SIZE			1
+#define GEM_RX_SYNC_RESET_OFFSET		2
+#define GEM_RX_SYNC_RESET_SIZE			1
 #define GEM_TX_EN_OFFSET			1
 #define GEM_TX_EN_SIZE				1
 #define GEM_SIGNAL_OK_OFFSET			0
 #define GEM_SIGNAL_OK_SIZE			1
 
+/* Constants for USX_CONTROL */
+#define HS_SPEED_10000M				4
+#define HS_SPEED_5000M				3
+#define HS_SPEED_2500M				2
+#define HS_SPEED_1000M				1
+#define MACB_SERDES_RATE_10G			1
+#define MACB_SERDES_RATE_5G			0
+#define MACB_SERDES_RATE_2_5G			0
+#define MACB_SERDES_RATE_1G			0
+
 /* Bitfields in USX_STATUS. */
 #define GEM_USX_BLOCK_LOCK_OFFSET		0
 #define GEM_USX_BLOCK_LOCK_SIZE			1
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8f893f035289..3f9dc0b037c0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -87,9 +87,6 @@ struct sifive_fu540_macb_mgmt {
 
 #define MACB_WOL_ENABLED		BIT(0)
 
-#define HS_SPEED_10000M			4
-#define MACB_SERDES_RATE_10G		1
-
 /* Graceful stop timeouts in us. We should allow up to
  * 1 frame time (10 Mbits/s, full-duplex, ignoring collisions)
  */
-- 
2.34.1


