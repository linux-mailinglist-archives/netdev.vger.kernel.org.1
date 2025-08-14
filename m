Return-Path: <netdev+bounces-213602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F6B25CCB
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208419E6546
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9504263F5F;
	Thu, 14 Aug 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dZ1yuY0/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2B2580D7;
	Thu, 14 Aug 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155478; cv=fail; b=I+eTDZTQwRFWgCAvl5tvUhf2jNIm3c6iuZ0jF8XrSCvp47cCRmt8vPXSm4A3kPJf7U+yapD2BiRPL9/SPTFf3yYUCw7TXOB3f9ffvrQIldgVqmwbZ8RfUX0Qc2bxlL1Yl390cXxILzOCrWxloqtxrl1kfK+lfPujy3KrMeW9NZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155478; c=relaxed/simple;
	bh=OEp0Nzyof4aXif5jToKXgDAX2sYVIIYNsViUvoHrL2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEunWYfLCZrwvlM+CSZF/tDcNIeaX/u0vfeZUtfGia2BGqhf/OCLzLxp5xuVH0V9pOAbIgvwRQpmHRMQg8UMcJctxxpfKV71z8MCn7ocSw/MVjeQMCo1GkXyvrr0D6dRP9a85i+ZZJ196r1Sg2TRTjz7jwYgUr4VNnUE+Sf4aaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dZ1yuY0/; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3zrIrIdqdbHKfcdpHAhBDnib80p+9ApH53NOsCb6O47RKlrI2qkya9P8lg2CuTyd3cQdL+QYybI+kaRB/s7TSQ496Ogxq4xO46RTGtjnv1J/3ziw7x93PDFOKaeKXxAvHnTEUF5bRQQLcaoGSBk38ZFiKucSz+sgjEQx6LyO4I9PAVAP0cdkd9XmtoQmlW4QUDzqJmh/8c8MLKt3ts54cna/weevqVqOcULdxJTsJntospQv6suiC65am/stZsa0JiIXa8GSb5hbSL08a/xLesv3ncJbTtWwwVJGagvT9TVX8qPJU0mYcmYZjavXcfwDJbJeo7NNV8kNGg4pqehkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUCgz/GWDzYxA/Pj4pGcO83QmG9pA/sWHrzPYFoxuNM=;
 b=mQJLf01GBfUDlBKgFL457qsdgsL8p4kDQeRfXolZpvxVn3mSsn4DHLFvDE+yj1ddui7V4nsqOeJ2+bxBNbhL+oSD2eIGn/IBslsna19YD/G/cbtlcj+E9O+UDt3ijR64oNBpXrW6xVcQh8IPX0Sgp5d40HVY+yitgCwdJQ+8Lt1uw2I8Ofdu07aQIcUtwDTnh5IJpfatSClfOK6jDbspFsix0KZJ+8olDS1dfNvTvw+YNHXMXdWR9cejNyXQZcrjsIPOuAY0AMgNGVeM7lXgq5eeTyxOQy4/qoX/aMD1UexMO8eE28enYDNjYzjSooxhw7QtE5G8vFyg4nZCB5A0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUCgz/GWDzYxA/Pj4pGcO83QmG9pA/sWHrzPYFoxuNM=;
 b=dZ1yuY0/5kqLmOIEgfamcS9GNnDEC44fH9rmOjLblgdQyxsIfnQbiDimFcLwdn/ws9nJW0zzu5egi7wHFFocMHELi82K/DXvgNt5oRkFIP4O3RMEj4SGOqw/5/6fGqlwoZK/w5Uw9JDSmekq/sO48b4lrEfBnbGSTlQatLYb4A8=
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 07:11:12 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::46) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 07:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 07:11:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 02:11:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 14 Aug
 2025 00:11:10 -0700
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 02:11:07 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 1/2] net: macb: Add TAPRIO traffic scheduling support
Date: Thu, 14 Aug 2025 12:40:57 +0530
Message-ID: <20250814071058.3062453-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814071058.3062453-1-vineeth.karumanchi@amd.com>
References: <20250814071058.3062453-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d098fa1-f762-4e19-a691-08dddb01c063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?deTY6/QokJMe7Q/gzKcaxpxk4cnXB7VTQTJ2JtQqswgrDNEdDWkz1bskVDvi?=
 =?us-ascii?Q?24wYwQSk7k4d80oJa4SxXYXp+0NdfDKkp+3Ni51upEb+H86SLPGdmxtub5pK?=
 =?us-ascii?Q?1t6S/N/b3i7LjpD0rOM5tgUUv0SnXVb6Nm8LFLPk1AEuy2VUaW39JYqNWvoS?=
 =?us-ascii?Q?8O2j+JP2ZgRlH+9T5ylfQ52vJBLrxZNSbgTb5IxPYCwFTYejBvdBUOcgDEVg?=
 =?us-ascii?Q?grUYuDBI6cPTLXrhoM005YdFWfBtKzez05H/3ShksbWy4uJq370R0wFa/64m?=
 =?us-ascii?Q?fCEqjCFTpnYr4Iif3KLBPsqmYPIvkx02z6TM4ZHMMLcPOD/hkGzAOZLRkTvq?=
 =?us-ascii?Q?fcHE5iuS9IkdYnIKiWaUO98dSKv6SsXQQrArjGBPpISPTtGmT1rgilw9q6E+?=
 =?us-ascii?Q?Q+KlAP2RUW5pfTqd7yGKRlivk3WZ4xuM4WMHAY18jtouUPk9ankGyiAP9Vv+?=
 =?us-ascii?Q?iBmwr/OVmlaMZ9yNrePLntjysFMC9m8j6617q5wwsqMvgH/ZJD12J0hNYUpz?=
 =?us-ascii?Q?B33wHEuYFq5aKqxBzbdcI6KH0xP0fucN6DfRkFtraxOe+GZIH3yZoh3Z+SIs?=
 =?us-ascii?Q?ObNISAbTvlqWhGPTPRFCJiTIoFMxjqDGm4YXxktt5hd9CtVgeB8Q+3zsI9QH?=
 =?us-ascii?Q?NwhlA9pdxSLFS7aoisdK59RA8kCpnwAqyGHUcbMbdt1HlxWuB1B1kfcPIknz?=
 =?us-ascii?Q?MKfTA6ZXWEwmUlVIBq0WzthH7/g2+hy0aVxGH6IFV/7WMtYF2U8QpjhyLRNF?=
 =?us-ascii?Q?wHR15OZdCaXQbK4Bp5RnGeqwYyz5hNQe+FV8EywBZvthrp7uPL7CdD56GXAC?=
 =?us-ascii?Q?tEX2dWY52pZuKVWbIS00vpACDQ5StXAe6VNx8ths/5OVq/QNelbRC9cksrHP?=
 =?us-ascii?Q?LRT5Emm+25pw0ff+iI4jEZtRlOhYCA7ftTWEhdQR1CG9/H1p9cQQg2kgRM5g?=
 =?us-ascii?Q?A8taqNVlJ8LHe+2GrwpqjCnsL2L9Miz1LhlQLf5usdn0eAC9sCmz7i9Bsj9E?=
 =?us-ascii?Q?VFc8R5lWZzhltRevYTDFq7e0cVSPVet/GF2Ikn7r6YmM/NzPbh1mb+5w6BeD?=
 =?us-ascii?Q?L5ct/zFL54P1p5hNQyRpfRfbDPbh9Cn6VnU5uDkTYzGEscKefVvFRwhBG+nz?=
 =?us-ascii?Q?nNG3I94iF8SJSeF+Fkp3nmm/jdFiBc5do+WikSgEwgJXMt6FZ616geV7+MY6?=
 =?us-ascii?Q?5VJPexfQpNBWFwWSFKzu9agS8QDjDhDZSdX5DpW13ZdhR5bq0ZnX4lkjRpeW?=
 =?us-ascii?Q?DnkhioV1MnE37P9O5y/V9evEpN6hGcMnVZhXzCSH9KlJRS7JkOf7+hBNVpK+?=
 =?us-ascii?Q?Y65XOAgASDjSpF/sN94q+b66tngoJDOdDqb2QGf3+MGVbpl1IdOn/Ci9Ccly?=
 =?us-ascii?Q?st0/KG9UW9i9aTcVJVB4NC0o4QyVY6f+fKKSgqQHDotTy6w/e5BMXFxLBOKj?=
 =?us-ascii?Q?B3MmR05RWHFVMAhsPFZ42bYC5HVHd6AqP7MvX8dZhQh/wIxKpUTCXtisBQGm?=
 =?us-ascii?Q?zTaO9N12I8XFtOwZzD8MUCspoIoag2bMar0dw2NQhKEbwL5J8o7zou6HvQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 07:11:12.4341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d098fa1-f762-4e19-a691-08dddb01c063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

Implement Time-Aware Traffic Scheduling (TAPRIO) offload support
for Cadence MACB/GEM ethernet controllers to enable IEEE 802.1Qbv
compliant time-sensitive networking (TSN) capabilities.

Key Features:

1. Enhanced Scheduled Traffic (ENST) Register Management
   - Per-queue ENST registers: ENST_START_TIME, ENST_ON_TIME, ENST_OFF_TIME
   - Centralized control via ENST_CONTROL for gate enable/disable
   - Infrastructure enhancements:
     * Extended macb_queue structure with ENST timing control registers
     * Mapped ENST register offsets into queue management framework
     * Introduced macb_queue_enst_config for per-entry TC configuration
   - Timing conversion utility:
     * enst_ns_to_hw_units(): Converts nanoseconds to hardware units
     * Timing values are programmed as hardware units based on link speed
     * Conversion formula: time_bytes = time_ns / divisor
     * Speed-specific divisors: 1Gbps=8, 100Mbps=80, 10Mbps=800
   - Hardware limit utility:
     * enst_max_hw_interval(): Returns max interval for given speed

2. TAPRIO Configuration via "tc qdisc replace"
   - macb_taprio_setup_replace(): Configures TAPRIO hardware offload
   - Parameter validation checks performed:
     * TC entry limit validation against available hardware queues
     * Base time non-negativity enforcement
     * Speed-adaptive timing constraint verification
     * Cycle time vs. total gate time consistency checks
     * Single-queue gate mask enforcement per scheduling entry
   - Programming sequence:
     * GEM doesn't support changing ENST registers if ENST is enabled,
       hence disable ENST before programming
     * Atomic timing register configuration (START_TIME, ON_TIME, OFF_TIME)
     * Enable queues via ENST_CONTROL

3. TAPRIO Cleanup via "tc qdisc destroy"
   - macb_taprio_destroy(): Safely removes TAPRIO configuration
   - Restores default queue behavior
   - Cleanup steps:
     * Reset TC state
     * Disable ENST
     * Clear timing registers
     * Ensure atomic updates with locking

4. Traffic Control Offload Infrastructure
   - macb_setup_taprio(): TAPRIO command dispatcher
     * Verifies hardware support
     * Handles runtime suspend state
   - macb_setup_tc(): TC_SETUP_QDISC_TAPRIO entry point
   - Supports REPLACE and DESTROY operations

Tested on Xilinx Versal platforms with QBV-capable MACB controllers.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
v2:
  - Merged patches as per the suggestion
  - Removed GEM_ENST_DISABLE_QUEUE() and GEM_ENST_ENABLE_QUEUE()
  - Renamed queue_enst_config/macb_queue_enst_config, reordered elements to reduce padding
  - Moved queue->ENST_* params outside of if (hw_q) block for clarity
  - Cleaned up extra spaces and fixed indentation
  - Removed redundant num_queues check in macb_taprio_setup_replace()
  - leveraged scope_guard as per netdev coding style
  - Eliminated redundant ENST_CONTROL register read for ENST state
  - Used bp->queue_mask to generate ENST control mask
  - Applied standard queue iteration logic in macb_taprio_destroy()
  - Added HW offload support check in macb_taprio_setup()
  - Added runtime state check in macb_taprio_setup()
v1: https://lore.kernel.org/netdev/20250722154111.1871292-1-vineeth.karumanchi@amd.com/
---
 drivers/net/ethernet/cadence/macb.h      |  66 +++++++
 drivers/net/ethernet/cadence/macb_main.c | 223 +++++++++++++++++++++++
 2 files changed, 289 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index c9a5c8beb2fa..d1a98b45c92c 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -184,6 +184,13 @@
 #define GEM_DCFG8		0x029C /* Design Config 8 */
 #define GEM_DCFG10		0x02A4 /* Design Config 10 */
 #define GEM_DCFG12		0x02AC /* Design Config 12 */
+#define GEM_ENST_START_TIME_Q0	0x0800 /* ENST Q0 start time */
+#define GEM_ENST_START_TIME_Q1	0x0804 /* ENST Q1 start time */
+#define GEM_ENST_ON_TIME_Q0	0x0820 /* ENST Q0 on time */
+#define GEM_ENST_ON_TIME_Q1	0x0824 /* ENST Q1 on time */
+#define GEM_ENST_OFF_TIME_Q0	0x0840 /* ENST Q0 off time */
+#define GEM_ENST_OFF_TIME_Q1	0x0844 /* ENST Q1 off time */
+#define GEM_ENST_CONTROL	0x0880 /* ENST control register */
 #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
 #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */
 
@@ -221,6 +228,13 @@
 #define GEM_IDR(hw_q)		(0x0620 + ((hw_q) << 2))
 #define GEM_IMR(hw_q)		(0x0640 + ((hw_q) << 2))
 
+#define GEM_ENST_START_TIME(hw_q)	(0x0800 + ((hw_q) << 2))
+#define GEM_ENST_ON_TIME(hw_q)		(0x0820 + ((hw_q) << 2))
+#define GEM_ENST_OFF_TIME(hw_q)		(0x0840 + ((hw_q) << 2))
+
+/* Bitfields in ENST_CONTROL */
+#define GEM_ENST_DISABLE_QUEUE_OFFSET	16
+
 /* Bitfields in NCR */
 #define MACB_LB_OFFSET		0 /* reserved */
 #define MACB_LB_SIZE		1
@@ -554,6 +568,23 @@
 #define GEM_HIGH_SPEED_OFFSET			26
 #define GEM_HIGH_SPEED_SIZE			1
 
+/* Bitfields in ENST_START_TIME_Qx. */
+#define GEM_START_TIME_SEC_OFFSET		30
+#define GEM_START_TIME_SEC_SIZE			2
+#define GEM_START_TIME_NSEC_OFFSET		0
+#define GEM_START_TIME_NSEC_SIZE		30
+
+/* Bitfields in ENST_ON_TIME_Qx. */
+#define GEM_ON_TIME_OFFSET			0
+#define GEM_ON_TIME_SIZE			17
+
+/* Bitfields in ENST_OFF_TIME_Qx. */
+#define GEM_OFF_TIME_OFFSET			0
+#define GEM_OFF_TIME_SIZE			17
+
+/* Hardware ENST timing registers granularity */
+#define ENST_TIME_GRANULARITY_NS		8
+
 /* Bitfields in USX_CONTROL. */
 #define GEM_USX_CTRL_SPEED_OFFSET		14
 #define GEM_USX_CTRL_SPEED_SIZE			3
@@ -1219,6 +1250,11 @@ struct macb_queue {
 	unsigned int		RBQP;
 	unsigned int		RBQPH;
 
+	/* ENST register offsets for this queue */
+	unsigned int		ENST_START_TIME;
+	unsigned int		ENST_ON_TIME;
+	unsigned int		ENST_OFF_TIME;
+
 	/* Lock to protect tx_head and tx_tail */
 	spinlock_t		tx_ptr_lock;
 	unsigned int		tx_head, tx_tail;
@@ -1397,6 +1433,19 @@ static inline bool gem_has_ptp(struct macb *bp)
 	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) && (bp->caps & MACB_CAPS_GEM_HAS_PTP);
 }
 
+/* ENST Helper functions */
+static inline u64 enst_ns_to_hw_units(size_t ns, u32 speed_mbps)
+{
+	return DIV_ROUND_UP((ns) * (speed_mbps),
+			    (ENST_TIME_GRANULARITY_NS * 1000));
+}
+
+static inline u64 enst_max_hw_interval(u32 speed_mbps)
+{
+	return DIV_ROUND_UP(GENMASK(GEM_ON_TIME_SIZE - 1, 0) *
+			    ENST_TIME_GRANULARITY_NS * 1000, (speed_mbps));
+}
+
 /**
  * struct macb_platform_data - platform data for MACB Ethernet used for PCI registration
  * @pclk:		platform clock
@@ -1407,4 +1456,21 @@ struct macb_platform_data {
 	struct clk	*hclk;
 };
 
+/**
+ * struct macb_queue_enst_config - Configuration for Enhanced Scheduled Traffic
+ * @start_time_mask:  Bitmask representing the start time for the queue
+ * @on_time_bytes:    "on" time nsec expressed in bytes
+ * @off_time_bytes:   "off" time nsec expressed in bytes
+ * @queue_id:         Identifier for the queue
+ *
+ * This structure holds the configuration parameters for an ENST queue,
+ * used to control time-based transmission scheduling in the MACB driver.
+ */
+struct macb_queue_enst_config {
+	u32 start_time_mask;
+	u32 on_time_bytes;
+	u32 off_time_bytes;
+	u8 queue_id;
+};
+
 #endif /* _MACB_H */
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ce95fad8cedd..d4b9737f83eb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -36,6 +36,7 @@
 #include <linux/reset.h>
 #include <linux/firmware/xlnx-zynqmp.h>
 #include <linux/inetdevice.h>
+#include <net/pkt_sched.h>
 #include "macb.h"
 
 /* This structure is only used for MACB on SiFive FU540 devices */
@@ -4084,6 +4085,223 @@ static void macb_restore_features(struct macb *bp)
 	macb_set_rxflow_feature(bp, features);
 }
 
+static int macb_taprio_setup_replace(struct net_device *ndev,
+				     struct tc_taprio_qopt_offload *conf)
+{
+	u64 total_on_time = 0, start_time_sec = 0, start_time = conf->base_time;
+	u32 configured_queues = 0, speed = 0, start_time_nsec;
+	struct macb_queue_enst_config *enst_queue;
+	struct tc_taprio_sched_entry *entry;
+	struct macb *bp = netdev_priv(ndev);
+	struct ethtool_link_ksettings kset;
+	struct macb_queue *queue;
+	size_t i;
+	int err;
+
+	if (conf->num_entries > bp->num_queues) {
+		netdev_err(ndev, "Too many TAPRIO entries: %zu > %d queues\n",
+			   conf->num_entries, bp->num_queues);
+		return -EINVAL;
+	}
+
+	if (start_time < 0) {
+		netdev_err(ndev, "Invalid base_time: must be 0 or positive, got %lld\n",
+			   conf->base_time);
+		return -ERANGE;
+	}
+
+	/* Get the current link speed */
+	err = phylink_ethtool_ksettings_get(bp->phylink, &kset);
+	if (unlikely(err)) {
+		netdev_err(ndev, "Failed to get link settings: %d\n", err);
+		return err;
+	}
+
+	speed = kset.base.speed;
+	if (unlikely(speed <= 0)) {
+		netdev_err(ndev, "Invalid speed: %d\n", speed);
+		return -EINVAL;
+	}
+
+	enst_queue = kcalloc(conf->num_entries, sizeof(*enst_queue), GFP_KERNEL);
+	if (unlikely(!enst_queue))
+		return -ENOMEM;
+
+	/* Pre-validate all entries before making any hardware changes */
+	for (i = 0; i < conf->num_entries; i++) {
+		entry = &conf->entries[i];
+
+		if (entry->command != TC_TAPRIO_CMD_SET_GATES) {
+			netdev_err(ndev, "Entry %zu: unsupported command %d\n",
+				   i, entry->command);
+			err = -EOPNOTSUPP;
+			goto cleanup;
+		}
+
+		/* Validate gate_mask: must be nonzero, single queue, and within range */
+		if (!is_power_of_2(entry->gate_mask)) {
+			netdev_err(ndev, "Entry %zu: gate_mask 0x%x is not a power of 2 (only one queue per entry allowed)\n",
+				   i, entry->gate_mask);
+			err = -EINVAL;
+			goto cleanup;
+		}
+
+		/* gate_mask must not select queues outside the valid queue_mask */
+		if (entry->gate_mask & ~bp->queue_mask) {
+			netdev_err(ndev, "Entry %zu: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
+				   i, entry->gate_mask, bp->num_queues);
+			err = -EINVAL;
+			goto cleanup;
+		}
+
+		/* Check for start time limits */
+		start_time_sec = start_time;
+		start_time_nsec = do_div(start_time_sec, NSEC_PER_SEC);
+		if (start_time_sec > GENMASK(GEM_START_TIME_SEC_SIZE - 1, 0)) {
+			netdev_err(ndev, "Entry %zu: Start time %llu s exceeds hardware limit\n",
+				   i, start_time_sec);
+			err = -ERANGE;
+			goto cleanup;
+		}
+
+		/* Check for on time limit */
+		if (entry->interval > enst_max_hw_interval(speed)) {
+			netdev_err(ndev, "Entry %zu: interval %u ns exceeds hardware limit %llu ns\n",
+				   i, entry->interval, enst_max_hw_interval(speed));
+			err = -ERANGE;
+			goto cleanup;
+		}
+
+		/* Check for off time limit*/
+		if ((conf->cycle_time - entry->interval) > enst_max_hw_interval(speed)) {
+			netdev_err(ndev, "Entry %zu: off_time %llu ns exceeds hardware limit %llu ns\n",
+				   i, conf->cycle_time - entry->interval,
+				   enst_max_hw_interval(speed));
+			err = -ERANGE;
+			goto cleanup;
+		}
+
+		enst_queue[i].queue_id = order_base_2(entry->gate_mask);
+		enst_queue[i].start_time_mask =
+			(start_time_sec << GEM_START_TIME_SEC_OFFSET) |
+			start_time_nsec;
+		enst_queue[i].on_time_bytes =
+			enst_ns_to_hw_units(entry->interval, speed);
+		enst_queue[i].off_time_bytes =
+			enst_ns_to_hw_units(conf->cycle_time - entry->interval, speed);
+
+		configured_queues |= entry->gate_mask;
+		total_on_time += entry->interval;
+		start_time += entry->interval;
+	}
+
+	/* Check total interval doesn't exceed cycle time */
+	if (total_on_time > conf->cycle_time) {
+		netdev_err(ndev, "Total ON %llu ns exceeds cycle time %llu ns\n",
+			   total_on_time, conf->cycle_time);
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	netdev_dbg(ndev, "TAPRIO setup: %zu entries, base_time=%lld ns, cycle_time=%llu ns\n",
+		   conf->num_entries, conf->base_time, conf->cycle_time);
+
+	/* All validations passed - proceed with hardware configuration */
+	scoped_guard(spinlock_irqsave, &bp->lock) {
+		/* Disable ENST queues if running before configuring */
+		gem_writel(bp, ENST_CONTROL,
+			   bp->queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
+
+		for (i = 0; i < conf->num_entries; i++) {
+			queue = &bp->queues[enst_queue[i].queue_id];
+			/* Configure queue timing registers */
+			queue_writel(queue, ENST_START_TIME,
+				     enst_queue[i].start_time_mask);
+			queue_writel(queue, ENST_ON_TIME,
+				     enst_queue[i].on_time_bytes);
+			queue_writel(queue, ENST_OFF_TIME,
+				     enst_queue[i].off_time_bytes);
+		}
+
+		/* Enable ENST for all configured queues in one write */
+		gem_writel(bp, ENST_CONTROL, configured_queues);
+	}
+
+	netdev_info(ndev, "TAPRIO configuration completed successfully: %zu entries, %d queues configured\n",
+		    conf->num_entries, hweight32(configured_queues));
+
+cleanup:
+	kfree(enst_queue);
+	return err;
+}
+
+static void macb_taprio_destroy(struct net_device *ndev)
+{
+	struct macb *bp = netdev_priv(ndev);
+	struct macb_queue *queue;
+	u32 enst_disable_mask;
+	unsigned int q;
+
+	netdev_reset_tc(ndev);
+	enst_disable_mask = bp->queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET;
+
+	scoped_guard(spinlock_irqsave, &bp->lock) {
+		/* Single disable command for all queues */
+		gem_writel(bp, ENST_CONTROL, enst_disable_mask);
+
+		/* Clear all queue ENST registers in batch */
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+			queue_writel(queue, ENST_START_TIME, 0);
+			queue_writel(queue, ENST_ON_TIME, 0);
+			queue_writel(queue, ENST_OFF_TIME, 0);
+		}
+	}
+	netdev_info(ndev, "TAPRIO destroy: All gates disabled\n");
+}
+
+static int macb_setup_taprio(struct net_device *ndev,
+			     struct tc_taprio_qopt_offload *taprio)
+{
+	struct macb *bp = netdev_priv(ndev);
+	int err = 0;
+
+	if (unlikely(!(ndev->hw_features & NETIF_F_HW_TC)))
+		return -EOPNOTSUPP;
+
+	/* Check if Device is in runtime suspend */
+	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
+		netdev_err(ndev, "Device is in runtime suspend\n");
+		return -EOPNOTSUPP;
+	}
+
+	switch (taprio->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		err = macb_taprio_setup_replace(ndev, taprio);
+		break;
+	case TAPRIO_CMD_DESTROY:
+		macb_taprio_destroy(ndev);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
+			 void *type_data)
+{
+	if (!dev || !type_data)
+		return -EINVAL;
+
+	switch (type) {
+	case TC_SETUP_QDISC_TAPRIO:
+		return macb_setup_taprio(dev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops macb_netdev_ops = {
 	.ndo_open		= macb_open,
 	.ndo_stop		= macb_close,
@@ -4101,6 +4319,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_features_check	= macb_features_check,
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
+	.ndo_setup_tc		= macb_setup_tc,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -4327,6 +4546,10 @@ static int macb_init(struct platform_device *pdev)
 #endif
 		}
 
+		queue->ENST_START_TIME = GEM_ENST_START_TIME(hw_q);
+		queue->ENST_ON_TIME = GEM_ENST_ON_TIME(hw_q);
+		queue->ENST_OFF_TIME = GEM_ENST_OFF_TIME(hw_q);
+
 		/* get irq: here we use the linux queue index, not the hardware
 		 * queue index. the queue irq definitions in the device tree
 		 * must remove the optional gaps that could exist in the
-- 
2.34.1


