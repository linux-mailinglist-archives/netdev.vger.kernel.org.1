Return-Path: <netdev+bounces-224744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C6BB891C2
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AC23A306C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6752F8BF4;
	Fri, 19 Sep 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X6ohNuRn"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716592EA47E;
	Fri, 19 Sep 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278293; cv=fail; b=qo69wwEzmspfyknNKeSawKlimqJn8AL0jnEDgWk2K8Dxa31IczMB7q0tQFOwCu6PPCnt/l3EDawKo0u3FjU2pzDauFdqls7qVzTUrUvHluWKBtsD6q2UJGstdcTiQu2eTUIic/KMPAnG/GkScMZtFFSQrJJnBaZhPkF2vDXneik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278293; c=relaxed/simple;
	bh=DrF2pZs4BRNCPUXOJ8cfWKBTMZizjVbM2udTdiVfk/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CNyNIerDSTCyjgogsYhLs6TPpeFkAdpDpOJIwbQOhvQScvJev6aNtguUanLQRvljr8ZxqC1vlEyiGtzM/jRbgtd87DX47kWH0aZRL0UYiPDSSDNxLcgtyIsgqgRZ1Vey19hp+xhuTNYLx3oF4mgw6eFx66b8rbLz5fdAGigZQ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X6ohNuRn; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6/oVYr3SO6tpUR2OonyCL3sIn4VvxGq2qaYLw7dqWlFHVgfYKfZzekBgOpDn+hpLkrD9SRJdLryW5NCup+U1tKkR/81JOd4HpEDZYvs6AkMx+aRnPV76g1GSj4A8DQgtvlId7OI1D4qaN1kaM53kN09pMIE0vKPObgl14Ze5ZtAzNfCj/D5ebdiaDEVD1+t1c437PInvg17IfZipd46F5VgLU2z30gOCLiM7EiWw6GZhGliSFtca4ydPsaPz478fTMTNSdeAoPVTOLAofpS+uEC514yGss75Y1GOQLty0X2+KE/ftUadNMe3ZGfpK9kuMiHxLDe62iq8fHgjb1rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afLm6rwbsT+juiyxM96CmWjNVmk+3TC4ZDiwY+n3t3c=;
 b=OiRXB9KnWwJg5jbYQLNYWheg9MXZFmpGUcol2rlVXUMTfUOOKD54vEx9jxk8XimkYAOA1h66F920V+F4B1Y6Uf8S0YaLSB1yxIg6qXMSaxs1/YUpeGtLHmXZbGJH1Aznx8SKNeKRVEqO7eyyUbbtT3SUL7Kw5GhvAII0P/ihj+IaVgixKVlNMLaMzQSrvNzqgC1+sDlkF5j8Poj+4+gpkwgSpHPC8ZJUW97HxB0G9W5+I1UI3GL13s7G3eLsm0ouhdZr5jD1HkL6tBmta6k17Z7ZlI7aHydxwLEV2qwnzWwjF70+pnX6gd2vdcBWAt4lKtuQ+W14RzjLbeowJil+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afLm6rwbsT+juiyxM96CmWjNVmk+3TC4ZDiwY+n3t3c=;
 b=X6ohNuRn2aaLhVGz4O+Xnc7LV+ua/2mE+pztXakQ0/Qc/bjrPfMnVz2UkkjQH2TCH3Lq2MKwApTvL7K+XWuf9MD0MhEriSPfIp3s8/RYXYHDP/5UEJkHEEz60UCxWIZn6yWWyf3bHCvmypVTtCeI5+B3rAWWFnI+Nwfsfyl5/IQ=
Received: from BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 10:38:01 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::d) by BN9PR03CA0141.outlook.office365.com
 (2603:10b6:408:fe::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Fri,
 19 Sep 2025 10:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 10:38:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 19 Sep
 2025 03:37:59 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Sep
 2025 05:37:59 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 19 Sep 2025 03:37:55 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net-next V3] net: xilinx: axienet: Fix kernel-doc warnings for missing return descriptions
Date: Fri, 19 Sep 2025 16:07:54 +0530
Message-ID: <20250919103754.434711-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: da14623a-3c53-4489-3a06-08ddf7689ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJGLoDu6aE95pTlDWtAsPCMK6TpV2NoxVKbioa3Wx///Kqm8l1y7OMn/0BU4?=
 =?us-ascii?Q?Q7Uc5xq9r0paIGIfXB2lBj5ckWAdVayKZ7Jnk7OGZ8lc4hh7A7Kja5hS5v+f?=
 =?us-ascii?Q?v1B81RUrvx34JROwjVyh0McFiZKfSVEKTmrcg4KyWQBEpQrB2bENukvML00P?=
 =?us-ascii?Q?VFqZwf6cttyX8QQomj+4a77yiQsOPAFaJ4g1Xyg7oB8CZjCCaDpLBO/WGVkA?=
 =?us-ascii?Q?CCeWL6YbjxVK3NjlmHAnfDrC5vnPLjMn+YsGYhGfzMzgx2lXL3G4/n7WvSSm?=
 =?us-ascii?Q?EHzOTut+bhh7ufXNPbS4WwSS472mXHVVT15cynPYVpP6tJB/BNydP+gL6CwC?=
 =?us-ascii?Q?Qr1Dg1jZW7dkNwaHflkkyAgsYP9a6G0s5OcLPVbE2r0KZzG9N5/QfDzN4LMa?=
 =?us-ascii?Q?SRswtl6qM9xnfLeh2MEzq+95LGzzck2TRxtV7vIoxNqykiOyeVdXOFEUX/g3?=
 =?us-ascii?Q?sEl/A7iiw340pebqWxg5E2eDUgEvWoPSmfPCrQoYDWQ3F1a93gwLuoVPFhfF?=
 =?us-ascii?Q?frLBnczMPswj47twscV84biOcWMnSSpcsSfEAD07SU2gRoBugbQRsdE5BVnG?=
 =?us-ascii?Q?ojlj2RrYbextxkpvDfEw72cLi3S/jNKyDYrb6dAlzxN64TwXIidkjl4beZwM?=
 =?us-ascii?Q?/YglX1AoYaxDjdbb4qQwZgq0npaLkb7rtma2f4GPjrstx7CyixYCmgdIUpul?=
 =?us-ascii?Q?AbXN4urvh4si7Iz1Rid6ObabHkZrIcMuwFzNL21OaasAoyDWZ/1FoEAh67qO?=
 =?us-ascii?Q?y6cgYmfweflaoakcTcb2bx3JP84z4Uw/bLIJyfQlNHwzfUxvvPw23skoSolq?=
 =?us-ascii?Q?fHckqNECrtNN1Mi4CtLAUM1AI6ORYdR7UgisJAG5oHQ4MO+sPJHkLuFZhdOJ?=
 =?us-ascii?Q?eO4OHxQzE4ohPXMzvKL4nFOJgIMmxhv6SvuRgCBVD63xwRBQgCu21B7dSpi/?=
 =?us-ascii?Q?wdI8d5DZVm0knO+Paochth1n89JNpQNqHu4OMXBeUCfrpjaF/tNVkViZwgRw?=
 =?us-ascii?Q?r+bh9x0YTs6aiFjZRAdksEiiD/0Y3kY8Wtw3xxZ+MWpVBjA2KWqipd0RtH5G?=
 =?us-ascii?Q?jeHfmRYw7KUMDupkSYejMxhCkfYU+Lhh14GvInAqookYMQAxjpO9oSuKIfOn?=
 =?us-ascii?Q?XREdpnXc59nc5SC+JvC9mrn3pqKx0BSJqBulbPY0qcpyHbhe0fFBPPkyUcAG?=
 =?us-ascii?Q?cQwI8RwiHnU7t00rTyNmw2nJm9By8KoidVh/n6ywHZLBqoulhqBYbIa1DdHD?=
 =?us-ascii?Q?VLj/+B2lnQ6yi0Sj9wg7WimeJunQb2ak+jxOW7xDNarN/PjVcsK27Lfp23T6?=
 =?us-ascii?Q?gmyRwSl2/52Sv6ECNSGPMVbg2gu4v2YyZdE3d3g7l045h8AJFmYjjiESNn+A?=
 =?us-ascii?Q?wI+6PzgjJL0hSn3GRHW6AI2HV61T3wceFAD9/fQdNLR1kGPxIcmsAJfENcdL?=
 =?us-ascii?Q?IsIE0S0GBLGjUWze09HkvllVzwbUxhmSJG182NegA6mqlJbV6guCog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:38:00.2558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da14623a-3c53-4489-3a06-08ddf7689ad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601

Add missing "Return:" sections to kernel-doc comments for four functions:
- axienet_calc_cr()
- axienet_device_reset()
- axienet_free_tx_chain()
- axienet_dim_coalesce_count_rx()

Also standardize the return documentation format by replacing inline
"Returns" text with proper "Return:" tags as per kernel documentation
guidelines.

Fixes below kernel-doc warnings:
- Warning: No description found for return value of 'axienet_calc_cr'
- Warning: No description found for return value of 'axienet_device_reset'
- Warning: No description found for return value of 'axienet_free_tx_chain'
- Warning: No description found for return value of 
'axienet_dim_coalesce_count_rx'

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
V2: https://lore.kernel.org/all/20250917124948.226536-1-suraj.gupta2@amd.com/

Changes in V3:
Fix other similiar kernel-doc warnings.

Changes in V2:                                                             
Drop mutex documentation patch.                                            
Add Reviewed-by tags. 
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index ec6d47dc984a..284031fb2e2c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -238,6 +238,8 @@ static u64 axienet_dma_rate(struct axienet_local *lp)
  *
  * Calculate a control register value based on the coalescing settings. The
  * run/stop bit is not set.
+ *
+ * Return: Control register value with coalescing settings configured.
  */
 static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
 {
@@ -702,7 +704,8 @@ static void axienet_dma_stop(struct axienet_local *lp)
  * are connected to Axi Ethernet reset lines, this in turn resets the Axi
  * Ethernet core. No separate hardware reset is done for the Axi Ethernet
  * core.
- * Returns 0 on success or a negative error number otherwise.
+ *
+ * Return: 0 on success or a negative error number otherwise.
  */
 static int axienet_device_reset(struct net_device *ndev)
 {
@@ -773,7 +776,8 @@ static int axienet_device_reset(struct net_device *ndev)
  *
  * Would either be called after a successful transmit operation, or after
  * there was an error when setting up the chain.
- * Returns the number of packets handled.
+ *
+ * Return: The number of packets handled.
  */
 static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 int nr_bds, bool force, u32 *sizep, int budget)
@@ -2112,6 +2116,8 @@ static void axienet_update_coalesce_rx(struct axienet_local *lp, u32 cr,
 /**
  * axienet_dim_coalesce_count_rx() - RX coalesce count for DIM
  * @lp: Device private data
+ *
+ * Return: RX coalescing frame count value for DIM.
  */
 static u32 axienet_dim_coalesce_count_rx(struct axienet_local *lp)
 {
-- 
2.25.1


