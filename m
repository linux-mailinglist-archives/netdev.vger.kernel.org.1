Return-Path: <netdev+bounces-200670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8DAE6832
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31407189B94A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D112D542A;
	Tue, 24 Jun 2025 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uvrs8PVb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F52D1F68;
	Tue, 24 Jun 2025 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774471; cv=fail; b=FLBIfQYGwOv2pqtfMJ/jBktCqQya31wQ5tNZQ2fm85nLru9t9jeMBmcnAv/Rpbd1wgWxYmyhvUfXEWe1+120jUCwMjGRVCf35ECf+ODcJRZ26XPHWpm+bPvegsWArhXiL5CB2x8kmJJqNHyPpHgAvZAXhjv84yweKIVIvyg45sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774471; c=relaxed/simple;
	bh=ekZfralKLQb7yvaKD1LEdcBN0u6OV92QKAEb0cWZeMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzsCbAPKIxopGwkkrsR2taPbixw8ARPacVmANthooujH/pE0pvu5mJdodSVY1ouPcMyOXemr3mKFmdJsk/4wncMHCwyzX7vxldUF2Gm2a+7waoRw8p6ITUEH1SysTY5368Ow8eoMhE/+67p8pWvOTVco03sInuVRyXmZAyJfL3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uvrs8PVb; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZnHwxUsMCj7kPUfCNGZlTa7wtTZxfac7IupndWyoM0suy8qWDGR2Rc5QTGbewcmNNoDyHeo2g2EDpnXfD/09jzVvRqjF2qNOTreP+Pg1kyb94pxfAqe+pDENYREPD98OZZn47T/Awrx+JqjVyzX8YChkcWBXbQ5oCkX6Gl8IY8lRnr2ynJYDXG+egNW+JCDIW2ZCiMe9XjzkcGDBCBzbSvbva7FBuUjd5ytz/bsPWHFnkSVXS81S+uSM0cvzgTbQTaADXzKTSy1vjf/qU1w9XVLIr/0ezmBZghDXPQjmeq+B2wYZAOZLdCcg+CXQX24e6+ZBwJF+KoTMafQc+ym/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9sLvc+3DtUtuNL+2yPxPhvmzv4is8QfKr69aJu75eM=;
 b=fmft0Kalo9HHfZIKtcEFS70iNjLPbhj6WPdXStcXHip2qzLs5wGri8Vk3EWH8+B4cmup3q1i1p5CTHNXEfRa8+q5Je/v5WdA+qOPB2snPrPxywwyqWUnxIprEy2xEiYij8JNbwb6l+xrhZzkiNqaYavarBYTAm2y0wSZRwRsWt9Fxmq0mq5X5XAJ8QoyjXWgFvM9qge0fyeIxApLKFehFB3Xq5UK6/CJAbscE7Iyxof/gg2dgtNFXXUYIgLtFwjB8I46pYKZXFXvV2wOi/5UY76RYAOI8l4OHV1o83l4uhKl7VKzbmzGEx7SDfBDLqoMD70rts1ojXqZBv7ax3gSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9sLvc+3DtUtuNL+2yPxPhvmzv4is8QfKr69aJu75eM=;
 b=uvrs8PVbw8HaNOby0OSx59OxBjQj6lBmyG7RuqUNUy16vZGeK5DS1qrMCMCJ+voj4Q0NW/eCtGBkRCb0O6HNOUilDybo2A+YptzZX83KYkCROb+r8mU5+V6A0jbRfqhHu00kL47WgQBhFO2m+y7bNQLhkxPYayVIfsJ8+Y6EyWw=
Received: from SN6PR05CA0005.namprd05.prod.outlook.com (2603:10b6:805:de::18)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 24 Jun
 2025 14:14:27 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::7c) by SN6PR05CA0005.outlook.office365.com
 (2603:10b6:805:de::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:23 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:22 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v17 07/22] sfc: initialize dpa
Date: Tue, 24 Jun 2025 15:13:40 +0100
Message-ID: <20250624141355.269056-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac0b543-89ef-4001-a56f-08ddb3296d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?47PLy+gC3NWBNKbO3+xvr+G6io5wIr0YTtKzhDVwXwDzi7vrQBa8uD0qXds5?=
 =?us-ascii?Q?ws/+vxSA6P9nLMBYVT9CsQGO9MdqKPKgCSCS/WZjAVoOokEb/+HH3yXKJ4WH?=
 =?us-ascii?Q?XY9AZyr4noxnbVSC6T2XRCWwE38EMnOg8Mo1P1PEtubC9m61CPOI63jLMuMi?=
 =?us-ascii?Q?WQs8zJa2CoyPd4dckFKgSszd0espprtvx57yO87Uymk37TnTOY1ptv5jFap4?=
 =?us-ascii?Q?Z/wgpoiJcfYJcjDMaUIO3QkiBru4uqDbcckQytgDZ3taIJik3Up3pOTyPd0c?=
 =?us-ascii?Q?CpWeOisfprxdA6z44SabnOK8fXRDaqBA3WkrYj0WpSc+6Qb8+7tH12x+KPRI?=
 =?us-ascii?Q?Ph5rXdya+L4oCrhCFSS4m+BEF1zh19kAzHEJi0StrYTSAZxAvCmDi5nW2zVA?=
 =?us-ascii?Q?R3Mh4hLI2o0SdtvkGR7f3OvtcZtP0gkppk8OmXsnGyFo74DP+kTaS/aE4t7T?=
 =?us-ascii?Q?Lmc8kav/WRAAveH8VOlrIyv9aXPUJKzu+VFeM/Em9mLlMPkwy0K9cImVSrZS?=
 =?us-ascii?Q?RHdsfiz0l3qVVOxzNbZufshCx/yuYRAZ6VlX7+kJPRvHun/cBNwUWqP49Uqb?=
 =?us-ascii?Q?Wj9mIbW6hlHZGchYLRgK5pWkwdegFakdIiQqB8KlVzumLMZaqO5vJufh9SEO?=
 =?us-ascii?Q?/BHhvqdBTNYuAqk2QFdIol4rwkWXGKTbj5YBIeQwzg799j70Bo33BFyJ9EX9?=
 =?us-ascii?Q?mZbwMtvaZjsoh9rIRANsf+irBOpkRdcMWctYO00VzIiXxtcvf48ZeOnzdvCL?=
 =?us-ascii?Q?TM6XacrzWn2830o1vtsxkifMDqMgt2Dfh8LTxlIsfoubx7WKqkAipy4JiAJP?=
 =?us-ascii?Q?51QVe5uzxQWG4cjmUjFtyrTOK3Mq/zod1vQpKkuz4YXkQfLAo8eUT6M/RJ67?=
 =?us-ascii?Q?ir1PfThKLaY11u9ZPQ10Uk/DEaNIL24t6XCLkQZY+ZYO7nXlRCzfWZ+z4R7z?=
 =?us-ascii?Q?kqjLYyScjazjOM5DhErEisLJtBaCmNrJPgR9yGezjx++6MN9NT1S2uOi4n/X?=
 =?us-ascii?Q?NRue4dgj5Qx4a0grrAm3y90DGYtq8s5eKgr9dM1HumZ40lGuqfMTP68AizxL?=
 =?us-ascii?Q?RBy102DEp9Hfgs2CpOw2HmOdDiP9W0oS8+9qWYGiFtxbbon6qhDswa4JZ1uV?=
 =?us-ascii?Q?qi18Lr0IquhskGQN7f9uOzeirO6XIGcGwosYqAGy+FBs/kTlZNVRw5qSSfnf?=
 =?us-ascii?Q?vW/MCg9b8Hl8GIQxOhu5aFSV7Q6YiJdVkMj+y8KkvGghY41wnz1noneN+Ok6?=
 =?us-ascii?Q?+DoO7gXw5hokuXmlSbRiJnvp6u7BW8apo51C/AEABfEkMUm5A9lm5IQwr5m1?=
 =?us-ascii?Q?pzViJLjBCZulmrR/LpqfslWbDJK+UbWUZTYyWr/NzgvlKhv2Ro8bku48SjKx?=
 =?us-ascii?Q?40rCEdnoaaMQxbFic7+V7ZFanGuXFZTapPFVkb1tookL5tbrDbRoIl6+r52s?=
 =?us-ascii?Q?xlMsxpp9R5eG+Rosa0ONLyZjF1RIIhrw1MEagGyfrHEgo52xbFnEn+l4PcS/?=
 =?us-ascii?Q?iqV1v7PfruJ4pyNTQhufznY16xqKzYeirPEb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:26.8928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac0b543-89ef-4001-a56f-08ddb3296d8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578

From: Alejandro Lucero <alucerop@amd.com>

Use hardcoded values for initializing dpa as there is no mbox available.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index ea02eb82b73c..5d68ee4e818d 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -77,6 +77,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE);
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


