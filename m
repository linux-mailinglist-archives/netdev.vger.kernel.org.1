Return-Path: <netdev+bounces-189824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75488AB3D37
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87079864CDB
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0762A2571D0;
	Mon, 12 May 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LefgCc3P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD7C250C14;
	Mon, 12 May 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066291; cv=fail; b=ua33RTUsz8O9WssiT7eMvUXVFgn1QZ20Q6ci5DzzOWtt4zflthCECMcrX6qSMl3wgGM1lpyjEeqJgMdpbGMvtFdW9BQUE0Z5jCPu6Q7ko/nD4d8suC83Pok2YPL+951/d7gfgUJICXhjSmsTHGlsXpfAZbQ6/7iMbTsQ1KFwGwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066291; c=relaxed/simple;
	bh=ILHwymVoBX9B5A5uyhWMFhm35sl0uEDQgNtrFiINjVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8yJDJ+gyHaFw8JcYWLtt/vhBop5cmoccEP4t+mZgQ58jqkUItZxGl/RVAVPZyGTWmdele+LwEvFIFelp7jOz/QvzBWF34OAWs19yWViIqnCBafqIpOe/ewQvvFD+HZE5leBPoiGJWxchFd7nbuOtFNQwQwtEpwupDWoTR9HpDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LefgCc3P; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5ekkzPHSvx9eJkMEzgEIVHiZVAuvDKB31RUnfhXw1QKF8kGLzRudJdgv0YhzwCyiFP6sBRbDOyU8MdqezTiZTRDgQfiocc8WVR+ekEbskQWpeHQfMihrU4nxfxdYU7zUoLGg44gMElLTyDnwM/dEgff2my/JvvqQnDNYd8WWUNYqK79qPNmY3L2rsXJgTUZo9QEwwgA1+7mBiYsS/oimYc3F6Lc1a1YFtGNekRBDAtqJ8KSK7kUBfTv/QrT/fm0hnUacwakRbxgVZ15ybXp++FZXQuAXPQM1hQoGCg1Rf9po/OKwakuboN+vhCT7IlDOwUstqKsVDx84TWbZDzqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb7qsC3HwWYzhtKb8cc3p5K5nXl3qVBZ0HevteEjVlU=;
 b=Rpoz6HYqNH3G+F0/qsmUikXRQQt2YjVJA5LUqE2ywVTbZSKCZPvi8ea3vEI3o49iUOi3MPBZ4+F+C+aC+66gjigEKtWEEwOTh2Z+j1ug+PCQ9AJYv+IMT/LsBzegv9gjHFITRGaRoUYY8aD0NksdWEqtWuEZK1hFjQq+VLoR7YjkaVF3WNGm3WW822bvnLxpM5f30owMOY3l1UMTQwcxiji+/4KzG8nu2+ARyXEZgFNfLq+7Ot7pBhKzYHXglMxbOe1q7HOLFjKIMNHZ3VwmjO6G+cirsL+I7ZLsva8vFFaI8uiCNng83ZdEwiZIBC6eFqvuUnn+5Ehp9QamS6j17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb7qsC3HwWYzhtKb8cc3p5K5nXl3qVBZ0HevteEjVlU=;
 b=LefgCc3PO073L5Rrhhp+P7aYU6xEXrVGCJRx14CveoZvGQtTpp48hRhSmzUyw7xrv2rxC6F8KE0xLAIIC+f5KyqCaO4AJeOWDXgRwpVDqdM3bQXkSCwjp3/pG2tmLXuFwlpo7Fur8F/3URWZbsn0JKIBsPUU5+g++Ysq2IrIpfQ=
Received: from CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.30; Mon, 12 May 2025 16:11:28 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::4e) by CH2PR07CA0063.outlook.office365.com
 (2603:10b6:610:5b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 12 May 2025 16:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:26 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:25 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 14/22] sfc: get endpoint decoder
Date: Mon, 12 May 2025 17:10:47 +0100
Message-ID: <20250512161055.4100442-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d0f6df-6238-4c84-511a-08dd916fa68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NpXJLsOnStbt7jLcbSePm5n1En4XwGti+/pM9/6OGcjLbjgnA4LcZwfxnY4l?=
 =?us-ascii?Q?04RiqX+W8Y8Df15ZMpaZiolDK2xe4W7jMojH6VSDCEGX0vRwcr39nY6ZxatC?=
 =?us-ascii?Q?rNPkeq178qUoSpYuOuUSGF0quYloOtQ8FHlavdDBRI6AfE4WB9tOQUBySwBJ?=
 =?us-ascii?Q?AU2vrR4jQrusgEvqx95nE67qUUd4zRJDHhrKKAdFI0OLYZWBefFXcA+Uv/xQ?=
 =?us-ascii?Q?+how+8gIGb0DxKri4As8M60zIEJSRbib3USxGVfAlj7RhML9yrZn8VoVUyLf?=
 =?us-ascii?Q?q5eBEdycVt+dUzl3Y2oieZIcKmeh29IM1VuP6iMcIANi6bcMYP0Xk009cZej?=
 =?us-ascii?Q?8xO70mgt2nCIFf636LguBAbbvn2xjaDd04yjG+yrgiu22Ch42W5yiz/zNltO?=
 =?us-ascii?Q?lKoKOyZQHRZQ5VqOEabgaYGLTxHkZ+5YG/pp1tAAHUT1ZgqACe3Jk9cSl8dV?=
 =?us-ascii?Q?GbeBSJWBKSE0aY1pOfM8Q0br49eU5U4+B8o2WAXnRvCMHQH5qF+rTLn5oxtQ?=
 =?us-ascii?Q?PIQFhTrBPkvOgCtqdsY3FKaBK5ypPqfoDj+49jAVa990gTml1XFHx4rdkQ+o?=
 =?us-ascii?Q?C0lq9bGGUPoMMNS0xkOApHpMVV6kCIwWELaxZnbAtTML2f5aoAwszQRN74l8?=
 =?us-ascii?Q?HQ+iGbRue9VbS+7Tou9t98oDPT0I6HLKnMVjLw3AA0N6CwyneAtnY98J4Ka6?=
 =?us-ascii?Q?/mIAgFVSNC7q2HfSO3cspdE8NjcU4TtafHkENyXoTnfTDawL1PiXgGawSAoP?=
 =?us-ascii?Q?LmxIo6nDg3fZF4rSDPcL9+m1rbsq5yf4FZjj26DouxvRVM37cWAa/Iz2FymC?=
 =?us-ascii?Q?TAbt52mwAtUYp7658BX5WIPCVjx+Yg7BxYzj2nkuLdszxV0d3GGOpVc03JgA?=
 =?us-ascii?Q?j2YEaCUflog8hrlsibB3yzQFsMkRtRX/dQXE+m0FoajByNBZBLOMTD93ZU1Q?=
 =?us-ascii?Q?cLfZDQ7BijKVaapJIJZ4gYBst5dFQ61p1CxSs7ffeS6YuX+cGQYEPDa2TKNp?=
 =?us-ascii?Q?1AemgUCRKExH0qQIfDD3Xmo/MPez3SlzCtrlBAszDHYT/OKSeD4xL4X88trK?=
 =?us-ascii?Q?AGFB0xHAI7uWzapoRgmR5XYReD81FcnrZgoKDs8hxK2T0X4lA7y9ETdm6IBw?=
 =?us-ascii?Q?69hcs8azC+gscXNsUf2ajD7K5AeP8C0W0wPh8QYP7iTFjq/YfSSXC9co3AR+?=
 =?us-ascii?Q?u2wOL4/znHcFtTzrnT/WFWvTaiigGdRA483jVPYVBJXzhZnpRbFG+jJsiAv8?=
 =?us-ascii?Q?/Py+OCESai8gYEGzSM8s23sfbHqt5n34kH+JJYVZGvU9CegBDZvx6JdQL6fu?=
 =?us-ascii?Q?UDhBT4q3avt3acSVD5rPP5GOjcEoVuxprcMtScgH0bD5CgXJrJfV8gC1P55W?=
 =?us-ascii?Q?+OXzTQBTiRiq04Uu58j4Px8qLg6rTL1v8UXXNlXE9iFm1Y52b/s9HgU1iUhh?=
 =?us-ascii?Q?ngmY5aYbaOBYNnWQCvBpRXZhYvoJ0CPLr077XMUr8/p/4b6Rmsj8PNLaVb/w?=
 =?us-ascii?Q?VJGKZn7L8Ud+hagxSYZYuBNce/mxU4VhLpZr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:27.7384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d0f6df-6238-4c84-511a-08dd916fa68d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f08a9f43bd38..21c94391f687 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -99,18 +99,33 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
 			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
 		cxl_put_root_decoder(cxl->cxlrd);
-		return -ENOSPC;
+		rc = -ENOSPC;
+		goto sfc_put_decoder;
+	}
+
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxled);
+		goto sfc_put_decoder;
 	}
 
 	probe_data->cxl = cxl;
 
 	return 0;
+
+sfc_put_decoder:
+	cxl_put_root_decoder(cxl->cxlrd);
+	return rc;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


