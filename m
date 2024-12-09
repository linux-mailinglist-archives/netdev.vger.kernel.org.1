Return-Path: <netdev+bounces-150339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF19E9E8C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC8280DAB
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A8199EB0;
	Mon,  9 Dec 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tVAtmNKG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142B19ABD4;
	Mon,  9 Dec 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770494; cv=fail; b=R2ZQBEqVGrEDbMHNiHmFifOu+aD4BVg33GM2cIRYtej+T8x6w6xR0zxH0KOw8gqjE1+5OUleVVlqko6odQ6yLKWRliRPxGCaNk3/OKk12mQsOUx4thB+DgRmyKv9ZXWsBczaNQD0EmCc0aEzWoHn/sBbfWHx2657Qpb/ZKL7rqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770494; c=relaxed/simple;
	bh=Nl/sK+iRRyVj78GfvmWmTJIMbqjyZB7WnQXrdZICSWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/fXLZZNuCaaok9HFwBfUo/QOOAQHQ+laLL0BXXFnyX9znTaMOQrU/nVELqpTVrNRRyqqppkULYte05FF4whlj71c9wm0GIKMOJbWdjZhxEiwrLaCzT+9VXfKZGS7rLJHBNnPO6te5fYZ01Kls2Nfr6kbDjLaklKtPuh4Mtk1ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tVAtmNKG; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7i7gF2dh+0A2KiHc+q1X9/pqz8P3Vr0JVZez1L2gNxOYa7UzW4lx8p1lsxr5mzR5GvtMLMn1SEGhLqnniJYhd3r5NouFk9pqYRfp66zVB4WgGrdkcZGS8be8uit8lQPPEJdbkGWKojREVWixQ4EYcKpoqJPDzsCU38dbR0NxWHgun0sevQu2DDR/4lArCMDcGnos8Dnc9c3fBkqi1W6EftnI/as/qmBpv45OIriEUJh4KpjgqKfFgjuSgZwFfo2a2oKXLfija4j5+xmtWbuGnLHATnh+I4S9yDV3cuwWQxiKC2s5tQ8RIyWK17VUvpLyEQoBXtD6Pc1gz3CbnuAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjrnvHVvuS49vXmGvXsv5wquaHrXJOFIi0b3IsqXLwI=;
 b=MkZGXtL7doL03Wz754jaT6Yz+BcnNc0fpjGV7H1nglQbxEtSLTggFoh903iWCkJUrf765VsXaV0m6BFPREjER47zxOCF0pwXTCs0qUCGnCn35WOpR/H/ytVvupKmXes3sEB2Dn9c6VMhCUMNbxUKx8D3KNXHf/kMXVlS7POKfe7EeRZcprCrnzT9R8N4S4LXWk30qRx1ODHYh1tyazbzEmPlOr21YCDpy9obsMlBCy84uAJele5AWbzWuG32+67YFkXewP8cRhPS+KG1yH26wKXWjxET8q6hLc66cxN19a6BvTPCZAVCmZ5slxp+FOGe2qeH5+5dBaOOJBV2wwMaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjrnvHVvuS49vXmGvXsv5wquaHrXJOFIi0b3IsqXLwI=;
 b=tVAtmNKGuPthr5Z+cOM5w/7pnKKARzMajfBKrWBj74eR6E/aExCK0X6jB6y9YHGBvVFbxGutAo3Dc/OrjP9LQ39U72/HLI18+Iq8yIyxPURsQWsqO9q6J4YJcAfDe/waKKjHivyg0TqBK1RkAtVvujwTtxwkSt4xWKVMiTdMxfI=
Received: from BLAPR03CA0042.namprd03.prod.outlook.com (2603:10b6:208:32d::17)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.25; Mon, 9 Dec
 2024 18:54:49 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::c3) by BLAPR03CA0042.outlook.office365.com
 (2603:10b6:208:32d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:48 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:47 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 07/28] sfc: use cxl api for regs setup and checking
Date: Mon, 9 Dec 2024 18:54:08 +0000
Message-ID: <20241209185429.54054-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f15ef2-beac-4c3f-9ef9-08dd1882f4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5IyiQR2BBj1HxNejqMuOc+sWVlF0LxeJbmfaoU4O1zCEMuULs72iH45ts4D?=
 =?us-ascii?Q?UmaDM656dr4AhOBbZBm0AbUKZaMzKpE6KHWxRqurfMqRXE22QZeupcJVq0+C?=
 =?us-ascii?Q?EB11ocgIKoMK4ZhI2Hv8+oxQiCtHRxdoPCc8OfbH7T+HX+05xDiaaqA5Zmvw?=
 =?us-ascii?Q?BOgA4mpYN5MXEH82D5iEeHve2KpbjZnvTwQucJy3kg+71a9RRwmESPU8/OCE?=
 =?us-ascii?Q?dSv4ttlpdQ3wNeK6c2QbTd5xSr2H0UR6pUzJrXxjhlGwmu829mFkFKeaPLtD?=
 =?us-ascii?Q?iA3L2jmurmP1ZZQ8HS+tXAw9e6Q9AwGa2OBYvfyhwN4XsLCOD/fhpR5JJXC5?=
 =?us-ascii?Q?Cr9jot/iHs75O5YaAie5m62vlupFDSxr9fZpdna0u683EQa2mNKEa+y2PtVA?=
 =?us-ascii?Q?FAi6/ZY8tgyRhMW+RBf33CoK/p+x59z+swP6b7aOgxjXNsMDUt2HzTosrE0G?=
 =?us-ascii?Q?Bjej3ONwoTpuW9X4YV4atTZ8vDiSKkyYeprJhrG+Gg1L8hQOxqSmjBpcjGC4?=
 =?us-ascii?Q?1RBBIx50Pe5jgoS6alNaI6V/+OolA/za/Uspx5+z3VdL2sONz6qoPK4PKEtC?=
 =?us-ascii?Q?ReTVOngutVva56gNpjKwoFBOx8qoEnzI/UM7BoWDdriCUvYvpoKhXKWwRpq6?=
 =?us-ascii?Q?DTXtNIQgiYkFNkfYx78W7L1LCwySoewUpEIXURyi5AMV0p/6vfk4mM8UeO/f?=
 =?us-ascii?Q?KxRP7HUPx6RH1bHzZD2hWlSzBnNstLihqGRlHHTKYH9xiUnAskhtK2GBeA+F?=
 =?us-ascii?Q?WyZWssGQbnPe821vKAQGWDRCYZVWY+mfE9aRNTb4lLKGjRPPEEMHNTUs8PPi?=
 =?us-ascii?Q?JdgvJPPDp9QnJ92WG5l9TbjJ5IBAELm+yhsgzDdTepCCotHs2hIE7fzOCfYI?=
 =?us-ascii?Q?9k2JIZuBLgRqHNc0gbqtL+v4oBHOzTvP3H85GIS2fQicoGdskEKyZsS4fe+S?=
 =?us-ascii?Q?Z5/dl014KtHq7QxuHGm6pFaUUWt/gCe3Nwk2iU+OLyw6dkFpG15ORsLf0Ji+?=
 =?us-ascii?Q?fg2rlr8cCktCT0gMJvPPslrjDQKBjPX30NIJKmb5J6/y2rFYqRhVpCgEi2hy?=
 =?us-ascii?Q?nE/MFpTg9fyUFPOpybjRDDTZVUJtsqhvfCczvO/CoROVLCC/SM5rzepegUwg?=
 =?us-ascii?Q?kU8uJsal3FycNhDjO3L/wv3PMz+e2TBOcOjiMfSlddwiy+hzEdb3vOimkj7i?=
 =?us-ascii?Q?Eal2pRYeJKvdy4kk49R5LudJTAjnDHRqtRJl0tWysEoY3PPgYhorUihhmcjz?=
 =?us-ascii?Q?AeY0VVsqwqTdTw3pFvQDQO2sPs9bllltds1UzPEVF05Uyvf3LwYoMSu092LK?=
 =?us-ascii?Q?ZbvV41Cx2OlPPnWUeMhfs4nMDgJpqVxVKiSF0e84XtfS9Uiz1W2ZNgDclEtO?=
 =?us-ascii?Q?sN1xppKwt8yEDoWuUWko18550gG4b/2JWGuRKIxXmaIjud9wT5S2y717MjWS?=
 =?us-ascii?Q?t1Xdb2iny0lw54PID6b69/gSTykH9lLfiAfyCdoX2gKSo466md78Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:48.9398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f15ef2-beac-4c3f-9ef9-08dd1882f4e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 58a6f14565ff..3f15486f99e4 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -21,6 +21,8 @@
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct pci_dev *pci_dev;
 	struct efx_cxl *cxl;
 	struct resource res;
@@ -65,6 +67,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err2;
 	}
 
+	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		goto err2;
+	}
+
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
+	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
+
+	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
+		pci_err(pci_dev,
+			"CXL device capabilities found(%08lx) not as expected(%08lx)",
+			*found, *expected);
+		goto err2;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


