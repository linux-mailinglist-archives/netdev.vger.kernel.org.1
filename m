Return-Path: <netdev+bounces-163047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04294A29470
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253A216C4FA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAFA194A44;
	Wed,  5 Feb 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yphnou+P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526C192B95;
	Wed,  5 Feb 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768820; cv=fail; b=KblBWSJ2Byiq2e6m6dK9m3MQwkk0uguB2a/s/ITJQetJjCUBQpM9lJR4/iaViCnI+/GCDrdgy/tW2iX+GHFhEk7guctCWdyRBKTIJ2tmbr6+fNBXnxYZ65Llpr9V0654yiYnxAZtosfeqTdUP2/cSd3K1EIbebzX9axqg4Drt9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768820; c=relaxed/simple;
	bh=aws/f3aO+wQ8QLcSBlAWuRi7o0sWCIGX0S9ADFcJy4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gi9c5b/Xtwic4K0vhFjeoSKks6nyCOWNV6ajDQdYXNS3UU2gGI3+i99Xxjt3l+gZEwFuihvxXY2M+jUFjIqQy9uJ2/FzAtAUjwOVchqeHH/3LdKuYABuusUoh1v7bkSl2SDvjkq49oClUuG648HRn/MbdsLLDRbhHteg1WmY6GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yphnou+P; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkhvHu5o/82ti4v7IQwnDXr9hklju49F8IxGVOok0IRkoBoFgwDdQgNPcGuzboMYQ64pjvzHZiV5wBYYwUVr0D3RsZS0ug8/sLnY+H+LdI7s7O5XEh2hLwWFjMhMcL72DLsitvOborlAbGKsmCZU5HsAuK3N/NjKmTjDQp2JGKAtQVThVlEMKJVsDh3JtVmy5W4c95BtZXrKjR14gh9WsdtzbRh+xew6SxHWh4TRR/G0YE2DpzQxC5njRuVF/DJNAKAOGnPudaiwcPr3CH9upHydy11lwjlSmM+7MsxefOJSw+wzBQBIYwFuqDa3znsou3cfb5wp/8DmM9kfFem6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AqYxMrR8z40o76ZQXXnrPBBXTyhHVR9DLziaA+j7go=;
 b=eqFWG40eHgxG80UbKpJOm8TypuI7HAa8zcPxnkgeK+mMf/ztZXo9Mc4U7hO5B0dQfWBhD9eLCpsn4r6EBQ9GXjiIYPDFtdC1rP3d112Kq583EumkGomFIpPBhgyvNlTI7gwdqc9D7Y05C3hSdJnEQGVRVh8ZEY+8Sf5k3MRixRLSpSZoctUY9igASFPRXPqr/rtUjijm2Q5uNBTP04eomWQqxkh+DuaV/jVKwbsjdaPV0gFnWSG9wAWM8331N2gKsFKzxaspDLTCWkrakSKAaSC4QjThlkhlgFMCHLSIhTsUm2LOD2gqpnObQ1MPWaFuVBFLe/fPymvHzHKhdE2QBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AqYxMrR8z40o76ZQXXnrPBBXTyhHVR9DLziaA+j7go=;
 b=Yphnou+Psje3pJFTfgFHlnP6e8iuZip6Ecby9YpPeDplObDG+EfKSsKQJzgADegIhMPpd6v8WCG1K5VFA+KatKWlSA3rJqheyov6h024jFwjXC4Dx37B89VfE7oNFSYQXEXHdXFZtqbTdM85+CPWb64X1xGyjvCroF3dNaR/OfI=
Received: from CH0P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::27)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 15:20:10 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::2a) by CH0P221CA0001.outlook.office365.com
 (2603:10b6:610:11c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 15:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:09 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:08 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 08/26] sfc: set cxl media ready
Date: Wed, 5 Feb 2025 15:19:32 +0000
Message-ID: <20250205151950.25268-9-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: e2dccd29-404b-4137-a32d-08dd45f894c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?keLYL7fOGyeLM0KK5ltZ5x742LoRvi4nAv9AjcFnds3AbvyMPzL4dRaGUBBw?=
 =?us-ascii?Q?txsarZaztwcy7lJPxNlkJg3z+AWvRAiQsKvkubHv8WpQXUxBjz32SpH9dfN2?=
 =?us-ascii?Q?tbxMCrgsi7VPj/3/4Rm4RWJTdAgI5hqs63f6urHEAFPWQEUDCdCO8FVoix88?=
 =?us-ascii?Q?4eaiU0F/3iLxV0oNnhk/E3LU3PJpzJytXdtDmCi37UcxxFbt6AkGs2hd2rxV?=
 =?us-ascii?Q?CcsTX48R+3heOwiU4t/54M9OUG2/C/bqbxfragKx7k7MZ6bhWwpf9ElCiFvq?=
 =?us-ascii?Q?PhO0VC5V3XKH7OoZpNn+v1A8eRF43t1KsU8cn+Hgw2zU+4bYiWxp8qHgSQoJ?=
 =?us-ascii?Q?UZA8iHhWqTLX8E9AmLfHBQEmk+ZgkCtZssxBdQunarRRsjEXIZy4tAfpWugJ?=
 =?us-ascii?Q?HZYzf5QjgRwz8E94SmGQ8uQb9+ORJlUX/DwShmcxtFIiqeqKLlBIVzq70zyD?=
 =?us-ascii?Q?kEy6xvHQR5I7uAyt4V2ldkOmhsIbuW5+gDo1Y7L3grcqQ64J2wXxOfnQjPKQ?=
 =?us-ascii?Q?JslnZQLTDbOlxaetgbaAbCGZRBuY72J3AN8m1E93t5KBgYeJ/XPWlP+qNUWO?=
 =?us-ascii?Q?Uzj++kRDiLCJ/vJfwCzQz8R7INGl8kUcQvfDzhLaGVEeD/VRc5Y1Sgtx4nCk?=
 =?us-ascii?Q?AD9OdRmr4kKzOTw/7gTHRzDj5GyGL3qoIHL74CA859CYxoyy6TaIR6ILdepo?=
 =?us-ascii?Q?qN17loQrBSZkeX/VrYAHGGTWMAAb8yZsTiW2iKGrxrjJmoUxfLQQzk32k6pv?=
 =?us-ascii?Q?u667SV3HNmd56bxoOkks90St3Bygs7XyePmZZQcW+NS4UXmKJZpcyY8nTAdN?=
 =?us-ascii?Q?B2fvpMxoWWRZAu+WhQeyi31tpKleibQWcz6/0DB4LVQzNLEU50Se6YZ1SFvR?=
 =?us-ascii?Q?5LSu0EyDmLsvHUVMUWxXSOgv4cwH7cHaXiHiJ514INCr7ucuQAEXMTp4y1wk?=
 =?us-ascii?Q?fmGN7IW/JFEYEBiiGMWpzVqPXf4gbc7EsKZg5ZNRWKnz1rXGPJJzW+hyy5Fd?=
 =?us-ascii?Q?7qRcms+VBig0Ys9xtoOHbqson17vt8+PaCIMyGkZkI4B2VfyWQtoFJz90Kqo?=
 =?us-ascii?Q?MUcq7OgXXKgifH9VF1S7oKoWYWpPZ0cZ60kp1pt/gy9xtTGYIUH2Xo1IVjeO?=
 =?us-ascii?Q?M2PhBJZIKGTn2aLUi8FAZkVOk3xvxWm9OCDjeSAF6DTB6wt7YYCnRZexL7Hf?=
 =?us-ascii?Q?vN0oka61ugNEfgVacGL3QIQjTNwqp1xtNLyrjjdM4HL4rRmoOr/MXELqjJZE?=
 =?us-ascii?Q?7UdEh29Jug/XV+Jng4BjRDOinQtTkpK7UovQNS7e4HErZf18vbvoSbME0rQN?=
 =?us-ascii?Q?x2xZCd6QAFvk+lyb7LUIF4ZAG1HzxzF1lf9LmyqcmApLWtTUbr1uJqa3haSd?=
 =?us-ascii?Q?LfN5h325k6d+48T77F9LuP3pIbjlWboLN+Mf9IeYTgFyC9q0oMivby2d6qT8?=
 =?us-ascii?Q?E97hMpvUHksUEahdrWWY4aHo7W5XUxQYEfPopSwbCaw0cPxKUvbpRsJf4ClV?=
 =?us-ascii?Q?h+vN1VXfoNpRPCY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:10.5858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dccd29-404b-4137-a32d-08dd45f894c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api accessor for explicitly set media ready as hardware design
implies it is ready and there is no device register for stating so.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 06d5ac531f34..b44c29efa176 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -73,6 +73,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_regs;
 	}
 
+	/* We do not have the register about media status. Hardware design
+	 * implies it is ready.
+	 */
+	cxl_set_media_ready(cxl->cxlmds);
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


