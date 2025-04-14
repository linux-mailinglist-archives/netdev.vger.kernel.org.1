Return-Path: <netdev+bounces-182290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C42A8872A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7591F562454
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289302750F7;
	Mon, 14 Apr 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SGv/BSEW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4C274FFC;
	Mon, 14 Apr 2025 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643645; cv=fail; b=I+OwEG9Fb0TzrQSHL1BI2FSoi1kAhVjXrNrEfzs8X4kt6kYhkBEneEzTM8+t5h+LoiikG/7q/5HoHa+L0dv35x5lIx1d7nriGYoIHzwdSY4DJtzuMICIfJYGZ4tPFz8Qx5B5031sXXLo0j4dV3k6Eyykq1oJ6hj/tauDruooyhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643645; c=relaxed/simple;
	bh=rVCjVP6UpNM5+qX751rjkpJsLaU96He+0THJyaxRkC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2xtxLi7pndJWeuWYFDX15pzJYn4goOiuwgU+dDWoa966ti3zPuPxwEcSaCxRVk3LrAZiFFtFxSxezWtdYKGwNbFsPI7A7H8E9wL/uSEXlFsK3p4TlfIwaytrp8bR+B5+W5yF9asFn5LnewwC6YRuR2ZkM530P8yGuRdMpBg52I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SGv/BSEW; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNQ2QTrlccxsARGA/HYwvNOVF4rCrKS4vGsDFp3+rYr67BPqluRHfxftwfj7haRktuxce2j+vOvo5Jn+/r4oay7V7Dd7Dgv60/RiXID1pPzRrFx+b13rplgjlHM8e4apZ+W38cVoQMwg3Xc7vvH2uCm/mEolWWXdKMLsCqvDbgE4QifApdDDaYM9TmNpNLC2gJN+qxmegIuwb64Ah1ebt0GhDBS0vKU0AoSoGU2v8dq6IqbObu4UxvaKWa5RIaho+365bcuiYpK7rCRod1Z/Zb5QhYwF/JVPOdxxtcZYOOiDg3SzoLytv6YTpDxZqGntuZiy+Bqqkew3hDdRU3VJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG5twp5nJ4xzol5xpK5bRhex+rzv1guzaFKvmJ/IOVU=;
 b=cZ/JxaBJ/bquIG5VjUZ0z0+eF8N2kc5MM5NMRmn5a/puWCFVp9G7EigV6u/+Kl1HMnMYdR3XYWA8Pgk9byIUSVqlfbJ/bW4n084RsE5iQdoWnlOyd8FzcyUYuk6HS+/ZxnsaFIpHvM4pKL7hDQGs7e4WzzFcbeA7/GfZcd9eL92c/ZTyQZ0NA4g4fONy4acn+6y4Njl/Y34fw83XSHxj9/oeaAJytu440EbgBakW8WJM/VPuwgMnRL5rt+bvPgrnimpWzNMgQKm777g4LsXcZCtliknxeltV/bSKh1OCc8aelwEkmBilwhklqJ9dzPdF2LJ3ooQyXZVJJ9mgdYQaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG5twp5nJ4xzol5xpK5bRhex+rzv1guzaFKvmJ/IOVU=;
 b=SGv/BSEWZAmwnYv1KT2HQA+7aQX2dXUUYnhZc2QOT772ic6hhUhzFgRie+nXn3bOYLnifd47s6bjq9hy1Kg6tr2ocp9l/1DviUCye8qPCeJoWEdAPgDJ4o7XF6s80EPD49K+H037S8F8J3rtTG1ev6E0+NIj3Zg8VZURs63rAeM=
Received: from PH8P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::13)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 15:13:59 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::fe) by PH8P220CA0021.outlook.office365.com
 (2603:10b6:510:345::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 15:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:13:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:57 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:56 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v13 08/22] sfc: initialize dpa
Date: Mon, 14 Apr 2025 16:13:22 +0100
Message-ID: <20250414151336.3852990-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d20f93-22f0-415c-8770-08dd7b66fb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9w7zLe/LgCVxLYC8q93g+41fpQtVNo8/09C3EtqxFZS4ylGC4efaGLbm5pf?=
 =?us-ascii?Q?L7mr0yiw2HWNzZbUQYII2+wYSuz1v9SBcz2STLeI95/pKNWtw+UKnVZmqN9I?=
 =?us-ascii?Q?ZcdK8oxIo2worjTGABZZVkLOzhc7NyN6LckWkxcxlO+oSa8P+N93nYn7zlhv?=
 =?us-ascii?Q?tAgRscp4wgOssIwRh93hzcJYg9j/aevlaH57QQJdL4U+7HdIkHS0iNm65EcK?=
 =?us-ascii?Q?ol9sIfR0koiKuaOZNPLGFn+eM4Uz10ZyXZIwjFniGt7h6R35Loiyk5murFqK?=
 =?us-ascii?Q?MpzwMsePrPHF/Q4QOkF+FB9EHioiXvjrnIffrusfOzsSkAVGOhk0s3ksYi7z?=
 =?us-ascii?Q?h4uykxjt40L3KfEkLkJ/XRcESVq4jPuzy0EduWDwvrk+uaLWFkJK/zkhBYlP?=
 =?us-ascii?Q?REFXVD/dfZfpCXP05Cd72stkw0S53mBE8Hq3LjAPxVx9c5TMZrCFHdXH506q?=
 =?us-ascii?Q?psxmWPwAxumI/k7ye0gb7/KDcuGgstuFXsepkXmEDtAV1gzHYg679GM+r4tn?=
 =?us-ascii?Q?KIz9blLATXcPajVYG+db5wux0sU3eGV4I+A72iCkzBYbQuo/syObyQK6XPcM?=
 =?us-ascii?Q?rrhGL8v/WUva87PVMxbMLCuRtwQxpiVcYok76zGyyKlsb+yUV7mZpzp0g3yc?=
 =?us-ascii?Q?5GoZ+XHpt3/p4965g4QhARULL2ZY+AY4UxSeZ8hLuHaUY2XIuE7XbPe0VVjF?=
 =?us-ascii?Q?NlukwHQxgPofIUFXOtjd+u56A2Dx0MHg9jbtySeV1cP9p5FdXFMNobRWGdf2?=
 =?us-ascii?Q?Z1DOZLpi5/TTNxLXqTRg0E1ToEBhJDNZAGzP2ANuGYI3sg1onO0clDSQ6pqO?=
 =?us-ascii?Q?G3ndq4bqD0+odpEzSYeUSjs4iYyE7xCvicEdNGmkVqwIYZ/ea4pGcHf7nI0j?=
 =?us-ascii?Q?N4ZTUoZ80hS1wQbBGuzp6Vzd0Vv1s++qIaj/uEHsbqIHHlubNPA32LSEsKOd?=
 =?us-ascii?Q?ICK3/DM+5mL/TTtS662G8qJHbzue2XK3o3Rp2lmo1bYHhOM6qrna7qeKEwoT?=
 =?us-ascii?Q?DthJ21kjTvyIwTE+Cy9flR9JHSGsaO45P2OBGmCXKq0o1foqQD1rBxp7kfCK?=
 =?us-ascii?Q?bVc0FC/vI9LJxI8Nbv0OlRwWmU1ibZxqQ67+WUTBSbrTcMPc9xUWtAD+Ozmj?=
 =?us-ascii?Q?NG5yLH+Rk1g6WDlHF4uTBVYpAqzC1XAyAL96voCr0RRd6m4TU6AMY8QGhfBx?=
 =?us-ascii?Q?j/1wet9vEJwvKFU8uUVGGb05r9pIYwcCQmkji6v3QTMGBTyjkqzdep4jPhF0?=
 =?us-ascii?Q?oqyPw19aTxY2I9dJ2argPKA4zwEgVM9Fi7XBXZOrTA40G3lRKsmtcsOi7LBg?=
 =?us-ascii?Q?1WQTDV+0nGyxEel0f6jdkJHbT8mn+sn3OdEUsC6t29CfjsOyZU8lBOHZWPLz?=
 =?us-ascii?Q?T+TBlMA0E+KdnmwhF7kitDCZCd640pMZf6nqJe7+3xJDIN1sqlq315rbLq+s?=
 =?us-ascii?Q?W/ZksH1GrSnpoUb2CtMi+9R+lfFpNILN/QZ4oxEo8ZljzH6cEczHHNUcRAt5?=
 =?us-ascii?Q?xnkgCiGlXNQH5PxICWZug2rlEDzlIxyoAAL7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:13:58.4772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d20f93-22f0-415c-8770-08dd7b66fb1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095

From: Alejandro Lucero <alucerop@amd.com>

Use hardcoded values for defining and initializing dpa as there is no
mbox available.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 885b46c6bd5a..a5d072aa95ab 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -22,6 +22,9 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	struct cxl_dpa_info sfc_dpa_info = {
+		.size = EFX_CTPIO_BUFFER_SIZE
+	};
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct efx_cxl *cxl;
 	u16 dvsec;
@@ -71,6 +74,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	cxl_mem_dpa_init(&sfc_dpa_info, EFX_CTPIO_BUFFER_SIZE, 0);
+	rc = cxl_dpa_setup(&cxl->cxlds, &sfc_dpa_info);
+	if (rc)
+		return rc;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


