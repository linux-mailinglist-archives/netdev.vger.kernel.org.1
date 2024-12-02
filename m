Return-Path: <netdev+bounces-148168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305919E098E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D139C1634BF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A251DE2C2;
	Mon,  2 Dec 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CXgrgvWm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E01DDC20;
	Mon,  2 Dec 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159577; cv=fail; b=F/Dn5GzqA5cO3Ynte/T8Of5n0ikW9O3c2EHfD0Yjn3q/65jpUWYSWn+luAugrSJ2j21JP2iIkg3muqxXEODoomeSjR8/zj9kTHIqiFsfC2fFCprIKjyqx8rxAwEkxKMCTheaVqdHSn29RShT0pew3idZAqYiJPHYLYBygkIqv4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159577; c=relaxed/simple;
	bh=xrufNqP1/WOxMxVcnaehu2mwi6BVR2nn4SUQ/SK9s70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvaSxkYEFaOxhEd4NvvODxM1y210HU4O5QucY9RRyNfDQmNN6vff9QvbHWTK81mliqyOvnREbS2ZNXfLYpqLt1cH4G3fiJMqcY2Wah7G1WQaAx/41jyVs8bRiTny798bLY066dL228xm0tac6B57c1hfk/3WIrBc8ctP694eKaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CXgrgvWm; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQWbpu4OqUBoQx5ZoQW9TPfhWuVI0X/Tu8Cq6MOlAup49mqWv1fxZKp7ijMFo8uNldIoL9m9NG1C5/DBLa+CXiGJ7p5HGQrIv/UAV1bo5G6FP8eeP4fzlsKS1m/obYLn8J+1lh1HncmOWQVgjpO/HvjyuMia2E66jyjkIgEduGHErB7aiV+mfJAW9a675UW+jAeirhUTQxT5+IzZ39zgo2HcHJb57mjJRuwDeBY5WFVrqIFJ/sBjAHQqrA+R7qF5jj7m4VVV06GgkoxFbYfYYeIR1CVcScYdpxaUsiEsgilvw1jV4ELWAdPdmr6I9C9Ot1G6hE7zGG3bBhAYHamAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+/mQcus2RSoqjRAiN7Mg+V4LIMQj0+6PE99f6ukiGk=;
 b=ZYuQhUG3j+JaIlsoX9NXmTaj7NkjvF0AtepVn+wv9xB5DSYklBfv6QhxD1I/2BPg6Bz4dgbgHq3d7cS57h1V8VdOuvVpcPgFX8PKDm6zjAbXPl8ovIwAQKSZSGzUoznaBnbYeZHMfuOCkV6ETmGdU8h0PSBpf1k4Q6tIfu/9+rGa7TyNyjh/RdeZZb8S42r9ixEvISzTctsJUWaemlP2yoNTnaC2I2Es3frCtGUFtOS00Vh8DsLodTwrDmS6U9cNQtxZFqNabbsUv3hi38vBF7J9JI1oOUy45tnBBfjGTEXYvPvr+tVoO+BYsTvibXJQoIVEhOlMR1h1J5vk30oU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+/mQcus2RSoqjRAiN7Mg+V4LIMQj0+6PE99f6ukiGk=;
 b=CXgrgvWm+9/ZDPfKJt/c4ONQWt/xmIA4tEvWl67Sl7Hyf01v7xC1ZtixjjR15M+D4j2WxO6XtRnWxWhvwq2czrYWPVeGj1ipaOVu3Oy60lJPEK0E/eFNEsgKiwQh5gYWkVhf/bP4KE3f0ajuE8LCKGBvP1L4MZJ1zXvAT5/22ow=
Received: from BN8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:408:ac::46)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:12:42 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::1c) by BN8PR07CA0033.outlook.office365.com
 (2603:10b6:408:ac::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 17:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:38 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:37 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 04/28] cxl/pci: add check for validating capabilities
Date: Mon, 2 Dec 2024 17:11:58 +0000
Message-ID: <20241202171222.62595-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: a47bf8e0-e3f3-4d72-9abc-08dd12f48880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Oudf+XdlHXc18NParCUrIAMhGRVrZCHOVD024MUnCIEqY498kREGFkMemnt?=
 =?us-ascii?Q?zgaNHFfI8BvO1JV0SvIVwxO8ttOW7Dl+qc/Su8quXnpBc0ZYqSfoVoekNsO9?=
 =?us-ascii?Q?/sZiz6xXl8sT5/KFGgsnyGUcuxBsXiU/GMZqw2IkzL7vWV1JiPmv5lt5bbr5?=
 =?us-ascii?Q?4+AniZFFwzrGiMBXFxkm9OGW1GLLVLAEy4KPm+4LE9yEO2Zjje0b2PV1xhU0?=
 =?us-ascii?Q?zyBQBNAja6mQfD596EtnneSTuxhlzfCqHWT0mmAQumY2nS+nuDu95nhWCRQp?=
 =?us-ascii?Q?SPcDXTqDGGBZbkEblsw8MYQ9DxtoklrtprxB5fjJjDbIHDt0KM+pSvWS7TNE?=
 =?us-ascii?Q?aPnE+Gc0zrPpr+xg026r0NCuTX66kjuGg7m/LAvmAw50etvYu73g7kVIHyZ9?=
 =?us-ascii?Q?lFgERVT5yqSWeKwZ+0bO0qKWVXQ33bGGrnUK8l6+guCNh8qhMLHY0uBqUd0a?=
 =?us-ascii?Q?K1iz8VkbKtVJ+2FxVqSA//dKnqtBO5sZKJ0/AXAntMrlgicvJ3yHDcF3EAHG?=
 =?us-ascii?Q?UXh9keBf4LNReVI8oWKiXw1zfWZr8M5+MbvC9++3dn3/YwyYK66mciXCQaEZ?=
 =?us-ascii?Q?XDIEVvQlzNLLo2UELuIkhtaOH74BWYVk4faXuBNa4QVo6U0tgQKuylcecpPL?=
 =?us-ascii?Q?tXnhqL5qojO0MoOtrW9j5Rrqi280qS672Fre8HWcNdajt9eKyzN6l3/5Yilm?=
 =?us-ascii?Q?+lw/SD9jGnoOsBnwuow7nPMgRrnYK2IPeOHG4Ds28szanB+sKf2NklYRkmEq?=
 =?us-ascii?Q?f9IAB6OLcl+v61HAy6BSs3/hERuvVbDcvgacuNWwy6M5tt9Nh05nPigy5Ad0?=
 =?us-ascii?Q?qBi5XNj+NI0hTIzC59AopBxja9X0XUkS5SS9j2HuaKA7mdWopbxH5ydRWc33?=
 =?us-ascii?Q?9XQDbCQX4DT/EYTQs9aCXbrMRoBaKf84ZDwKzaqYbNCKzL0bOlb4CKhizKqR?=
 =?us-ascii?Q?ZdB5wsxyGZXDMAkk9Sw0jzUOv3Uu3xkUKsuTQqXtthz09zxAjl+fl2KaEtjO?=
 =?us-ascii?Q?rEbPN6dAsh4m2wE7pMRsLAwgxddbyMI+Kpd0jZFK/VrqIlZ1zoQUPtma+yKy?=
 =?us-ascii?Q?jM4V9F+Bgi3pw5ki1kzZhGnl/EKfgEq3o+Mg5L63wlYpptmndGuSzM6ecB4C?=
 =?us-ascii?Q?HEkuxh6esz783HIWs6MdaradZiSTGxugFbPME947RIumH7VfftL8Ma0Pnh52?=
 =?us-ascii?Q?OBKeDFKuCOUoiUdGY82umepo0RpDSHBDFbzSEv1i2SbErvJruE57LGfZX61E?=
 =?us-ascii?Q?p7CD6Viy8xUJ6OO1XqohFddkiO9sx4j+ro2HHQZK/ryvDpAdSH08Kkt5IaiO?=
 =?us-ascii?Q?lvs9ewsvVIfEjYSae+OuaxB80awIoIoHdoGWqu3FogB9bIz3xii0peIpf60y?=
 =?us-ascii?Q?3NsxyyD1ysC+gPj2Yvub9fZkzrFWRmyPr0s1BNEQOniGubAfh3yzD4VHGpom?=
 =?us-ascii?Q?HcVADZcXdJ4Jw0X9lkcyPFNfKhE2NofC+CrZY32UbiHFAS8lltslHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:42.7303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47bf8e0-e3f3-4d72-9abc-08dd12f48880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561

From: Alejandro Lucero <alucerop@amd.com>

During CXL device initialization supported capabilities by the device
are discovered. Type3 and Type2 devices have different mandatory
capabilities and a Type2 expects a specific set including optional
capabilities.

Add a function for checking expected capabilities against those found
during initialization and allow those mandatory/expected capabilities to
be a subset of the capabilities found.

Rely on this function for validating capabilities instead of when CXL
regs are probed.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c  | 16 ++++++++++++++++
 drivers/cxl/core/regs.c |  9 ---------
 drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
 include/cxl/cxl.h       |  3 +++
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7114d632be04..a85b96eebfd3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxl/cxl.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 
 	return 0;
 }
+
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
+			unsigned long *current_caps)
+{
+
+	if (current_caps)
+		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
+
+	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
+		*cxlds->capabilities, *expected_caps);
+
+	/* Checking a minimum of mandatory/expected capabilities */
+	return bitmap_subset(expected_caps, cxlds->capabilities, CXL_MAX_CAPS);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index fe835f6df866..70378bb80b33 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -444,15 +444,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
 		cxl_probe_device_regs(host, base, dev_map, caps);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
-		    !dev_map->memdev.valid) {
-			dev_err(host, "registers not found: %s%s%s\n",
-				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
-				!dev_map->memdev.valid ? "memdev " : "");
-			return -ENXIO;
-		}
-
 		dev_dbg(host, "Probing device registers...\n");
 		break;
 	default:
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f6071bde437b..822030843b2f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -903,6 +903,8 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+
+	/*
+	 * These are the mandatory capabilities for a Type3 device.
+	 * Only checking capabilities used by current Linux drivers.
+	 */
+	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
+	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
+	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
+	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (!cxl_pci_check_caps(cxlds, expected, found)) {
+		dev_err(&pdev->dev,
+			"Expected mandatory capabilities not found: (%08lx - %08lx)\n",
+			*expected, *found);
+		return -ENXIO;
+	}
+
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f656fcd4945f..05f06bfd2c29 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -37,4 +37,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
 void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
 int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 		     enum cxl_resource);
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
+			unsigned long *expected_caps,
+			unsigned long *current_caps);
 #endif
-- 
2.17.1


