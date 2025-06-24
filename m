Return-Path: <netdev+bounces-200674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDADAE6834
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7498A4C4508
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3942D663A;
	Tue, 24 Jun 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d3f7QbME"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990822D321D;
	Tue, 24 Jun 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774475; cv=fail; b=FF0AtQfONWvPgPJf0NXRRLdjbV6CdAhq6AEwcMUk4Ckz6ZDW0BxQLwkcXI4CVaqLsysSRZX9oPipEVzaXdXRjQ2NauF1SSsCQU1acK/1Dvb7Fa9ZlzPPXXFYJktbSLddbpwETagOwuzX7mDwFCFfZZo18BuG/Wfo6UzOKympCGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774475; c=relaxed/simple;
	bh=AXvyymKYwpfeA6JT9qkqRJkukQNiYABK7lxS6b308cQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLtr4inLC+2O/2vYIx8Gf/TSqCl1k3BdlJOCSsCJZBQrRtp6UcYxKk8xLQpfaMaDtqIZFCYgANtEm/NvY7xM2asfAO9VoXKVXfgqzgOvL0mu7OO/iT4rliDh7ax0NHuzixnHoKaExaxnn0pFQYSCjs5Y7S9FMzTiFJDyom8at1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d3f7QbME; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5qYRN9xr0dyCfeljpbrJvkRm6s4Y5UhGmm9VeN+70pTf6QxX6JCh9uu21X1yv7LoO/oZMQhTpYR1zG+pv4A7Gle8B8TItaBoABV4EiBCD7MBL4rjXpJJTEilWliNneK7n+vVTHfPoWV0VhbM8P5j2AcSGgNqxMgGgFIcweLD7mr5fZRPfWqEXpefks7bqLuExKcWCLWDymc9lGsrWTJxZ76QhsH2r+nTlUn9vjyiWIgYnAumJCcNgK3pa2kuFypQEZ/aJraIKLiiK4q1v5CgRQQTdc9WA+ocZ7+V/2xKcE/iWrfVH+UU8SyLJnYZc/Ap4H4kiexP2WxhFun8lrBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlFka9IJZSlMppqOMSTL+godW+WQH2gcs+I2gYfzCjU=;
 b=iNTafptF1D2eU2THFVxHus+hnyy8x283Fgk8Epb9lgj1Dc8XG9jM05/FXc2J++yi1mmzSA8i0qbxavlrdOiBBcQX9QIH5P+xI9h8Vrr0cmxU42ZiVUojVYsk5jevI/z9keB+KrnCevbby9Hb9jM5HsvE/KBs4iQfrqEocUfChEODxJYlUuYeVDrFvaOMm27h427ejhH8oayexSbpJPGND9k11NNibvkf+QFPC4gz3DV1oYZ0Nx99SATdQ0AOwmjHBhC4ti2ixOkSVLkRLukVIl1aNFAv3l99tzy6q6nMQs7QDyr8YBdE4txZEd8efS29zFw8IrL8YLJy156heF/21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlFka9IJZSlMppqOMSTL+godW+WQH2gcs+I2gYfzCjU=;
 b=d3f7QbMEltNbZVxBqhHf7rBbEqjINuoTR6VO/OjcUZjLerxsz4fAGqSVx3ZRBYs8bhVy6VkSJAP25KvYN8wfQ2mlZEmUdm6iFh+z0Alf13b8+g5nUBKcGphVg3X5gkB7rhQQ+sD8V3jdqj7SjMxQy8na63NfV8YH9i/aOlRtic4=
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 24 Jun
 2025 14:14:28 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::6f) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 14:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:26 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:25 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v17 09/22] sfc: create type2 cxl memdev
Date: Tue, 24 Jun 2025 15:13:42 +0100
Message-ID: <20250624141355.269056-10-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 327ccbc8-367f-4616-8f32-08ddb3296e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SJYfRJKGOCRdl7NoNe1CRDnYFxvIJd+JNs3tzq24Fy/Z9BcPy/8iFRXGrUzL?=
 =?us-ascii?Q?Bp12uW5rz/l7S73toln9nP5cTj13+jeH92gOC8KadqyGg/mVk7+D1DZV9g2g?=
 =?us-ascii?Q?JafYKC1ffiVy/Q/T5Ajkf22rZ9FR/bEjnLgtX8aOTiWj2mGF0ypdwB/NgmxI?=
 =?us-ascii?Q?NaOOmVm9xo10eWL+jEVzbTa0t3QcjU/LlbefCRQYnK3D2aYK6cXxyIfoRFLH?=
 =?us-ascii?Q?EI8NcoysF2NPXMvqOPT68KqK4VfwofA3Skg+Sde/NleBuf6TYTYtaLWDtJ5T?=
 =?us-ascii?Q?FGwdGH5bIsm2teBUPmR6IYWBBOlRmXpSYuq5TQ8WNcj7ri72WRKpZWXQTu16?=
 =?us-ascii?Q?j+WASX4P4eAvHFjcjonMnkxmB7hRgsSJJLAR8M6BK2Yqty9vlyNVrotEv5vR?=
 =?us-ascii?Q?2UZ9Q4+FiX8u+FOCQ7Ura9Q0czpufzMUSUSkxf7geij8TSlvYnkVBModK1+t?=
 =?us-ascii?Q?FwOIliYYgGJSRQTG91msQajcJYwDlDQt4VOM//Z8P9Ga2bQx0je3sI9zZVA8?=
 =?us-ascii?Q?EqOn/dlFYt2thlry+lO/sxHFArUCGAsAYAnq2b4yGfhoyOtTAhJ1BA+tm2Rb?=
 =?us-ascii?Q?I16wVvMi0zma+6tVLlvYxPM91qA/Nl1g2xPZM1fURXVl0Yom9JWZ39eUrYDy?=
 =?us-ascii?Q?j9oFU58NtRQ6KIqXoTfQnajlG2QV3lp3firoBC1qTCXA5IlGSUcIxjIytPSf?=
 =?us-ascii?Q?4JhiQGTat7WYdyIg2b/l5pnrdv3wKkxbcSNrQv2KVbhQBPQkyvvLJNt8H7LK?=
 =?us-ascii?Q?tHhBVPRd84aIGWfRHdiWDnApW+PpTrqJzEOJEfUQWd9UE9hduh8AUFu02JWf?=
 =?us-ascii?Q?MbbFkPS6u3Zi2DT4kIM6itbNddFh0H80zizuM1q5LKuK4m235YtnKvOLPqbF?=
 =?us-ascii?Q?zMkxw1pMI0t4NtgyxeV/3C6NFM2wNii1RZJOrQO+2c+82DnDQRFMnbzo9AVS?=
 =?us-ascii?Q?JATbM16eNtbTylxfnYKqJ3V8pCukmmAM8ASN6Z1ksDxRZ/zCINwkbw7tB0xL?=
 =?us-ascii?Q?HMfXw9pY+/BNdc/x8Z1GHrkBdk1iD+YVU10KvKYNmLDlGfbMh+M9nyYnaLYF?=
 =?us-ascii?Q?EhJV3q7R4fs0SpK1bDfPMjAptd9ah31OZMRajtY093aKku6n7F3mHfvtMEgD?=
 =?us-ascii?Q?KR87t7Qp80LiWOCHsLjw3OZ0rHRRLFZuaLZZtv0IkIgW+IcM1PQYXHCgl8rV?=
 =?us-ascii?Q?jqStuWpTJgC8ny67KVNtrtWGJVVEE1vSqWT6XaKFIwggHHap65LOMlmGUj/r?=
 =?us-ascii?Q?WbI5RLyQOP2xakVpArIBu/1emVkAxG7xvRcWOBzsdtFITQAuhV3nH1sDqX70?=
 =?us-ascii?Q?kZvEIuy8wlPWtK4PgwfxH47D/65/lkGGUzd5VmkTqAvugBo5iVju27Mk2Dni?=
 =?us-ascii?Q?3XBLiYI4zCmqvvdM+YD9rMlMNE4xJwfhCc9oAZ1rMIOvTQNbAb0DM80jeC1y?=
 =?us-ascii?Q?VFtC2UZIBcgJOLo5m9HiZtCUR12CNgcapOJbtlac9v48c1qZi5cG4yIUw9ER?=
 =?us-ascii?Q?dF8nEW9ZCRVDI0RXba8iAsqV0SeR0d+EidEr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:27.6578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327ccbc8-367f-4616-8f32-08ddb3296e0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 5d68ee4e818d..e2d52ed49535 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -79,6 +79,13 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 	cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE);
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds);
+
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


