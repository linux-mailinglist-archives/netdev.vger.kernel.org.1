Return-Path: <netdev+bounces-186464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D682FA9F40A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7AE1A83591
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C62797A3;
	Mon, 28 Apr 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E65aspVO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1827979D;
	Mon, 28 Apr 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852610; cv=fail; b=XzCC+rWQrKxH42rc2ajwCCOYuy4+I6tRCH7815u058I7b4gaVfv4xmFYVuI2Y73JtAcGuqUevYVH0HdSiH17S1XmLOamNaH3r0E0dHBYQJDwu7MAjbs9xhHB9KatZei9R4bAo5jLAtDehj7vlGX/SHJ7R1VGGVMSvqlFdOGL8Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852610; c=relaxed/simple;
	bh=a0tYdyfZvuq/BBlaF1KWkW9J1kPFPcsm4LDbQvSpJbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr4GuHxlElQHUfvl89qP7uXgCmSrKV05A2Gw31T5PVd0UfSmB4XFe7dJa7dj9ZykEGBuHWykkLEY/xQRWEoelQtH/y2Rx9eAvm3CtMMzejp0enThKVnAusnwDtlzLe9llVSR+f2FTyxFeFLM4Y0MizoNzN62BqvXeECmD2tJ5SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E65aspVO; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGhg2KJESVC7FlgUgcM/Ue7+P+wXudi4Sz4bePzI97K3WxMeQYHnZXPBQEXkSDZb3ctKWa7VYROTsDALYJgESgiWeKiwSX+W9l49OJ+SEcME3znsBgChgZX9YxTMA7mXSzIIdxSBlVb9w1+N3g4cbvSws2XBCUODjwL6C5UlA89b7q4Cqj4QEKFtBBolZGbUmaiCGQZNpPSpr0Zz+nXIvSNCYRzIeZmDBAgaDPOxvc0/6CVKHnQB2StBECKqnQjR+RmVAXt1x1RBg1J+nJoBR0vH7617ckVtyo8P7XMdxfqyhY1T+tWguAgbGGu/3eUGgrrEYnUlFULyu1ztyz6foA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu4HOaDmvnqn4B8PMt/3KXSjpnIFSBCKTczGLEfMLeA=;
 b=oQyHo42ieLBWUpzVvbyYYhm8CySkyyLT+WU6V7+5Vv7IPtkUujZTQJJQs1UaWvBS05F2yOiNHwK0/9QMzGKM50w/jXCv9EjxU5f/WqcLdwKeUMF1Z3BNBlANKrVt/TnMuOhHODIB8VCUSnf75t8qikrbe3eKs1tLF3sjMkWNb0XoBGkRyr3Uo0xA7rHyQPasB0Fsa+2Hj8DOigufZyx05MygUJPD9bEPVdeiRi2tKcM04RGzJnF3sD2km2evOpTzaexfL4hFxO4tSYyu29VQsAMLlW5tAyxE08R3OX1kdVGp32bKMKiXRtB626+LKv1UU8Cw7kPLbYickyu5RZFPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu4HOaDmvnqn4B8PMt/3KXSjpnIFSBCKTczGLEfMLeA=;
 b=E65aspVOvqIyJ/9tubflyK0X4lo5K/C/o+4RDfq8l7xUlYMZa8t3JgkAw/Qd5Bc/gQv27kwxDVylTRQnkT8mcVgVS2nimgSCEpQcourYaUB/3G3/2Hsn2z13JRza/SzbzA88SaTTHlJniglsRI66Tzm30Lzknd4bzVC883aFxXk=
Received: from SA9PR10CA0010.namprd10.prod.outlook.com (2603:10b6:806:a7::15)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 15:03:25 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::d5) by SA9PR10CA0010.outlook.office365.com
 (2603:10b6:806:a7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 15:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 15:03:24 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 10:03:21 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>, "Sudheesh
 Mavila" <sudheesh.mavila@amd.com>
Subject: [PATCH net-next v2 3/5] amd-xgbe: add support for new XPCS routines
Date: Mon, 28 Apr 2025 20:32:33 +0530
Message-ID: <20250428150235.2938110-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
References: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a26543-284d-40ea-6a52-08dd8665d32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bn1Bjb5t0MWRlAkN0H3DoZSBzdWFSSAaEwzpcUpCWG/AfHIPGOALI2koPHT1?=
 =?us-ascii?Q?VOWwk0TZTPr47YMjg5EbQy6EmYBhztCS8ayj/am4jejNeIyP4nKxJt20rXT3?=
 =?us-ascii?Q?dINe34vp7Mi/Ksk6OxZBh6Xcs3qMQrGDt7a1vKC4DTw6XGWZUBOglAuonDpS?=
 =?us-ascii?Q?95QxbFpWUA8wcYYnPiEY6Td2hja5a5JtpvWziw69nNBd66gbrdto8f/qqH95?=
 =?us-ascii?Q?89PLJxom6rgbiXvPd7kgDxxAPvykK1n/oLH497wfeBPkbhfUo3bbdDIqqwZA?=
 =?us-ascii?Q?t5QiYuh+9LDsWJxhv3xu2F/mM6xPO18288t7grmvmRX517lqtt0722a9I+gP?=
 =?us-ascii?Q?Do9ipLUO8H+DLxs2Y7SiCA4CpcEIDo97ocLSRV3RumzzU8WkffOEsQMc6iaP?=
 =?us-ascii?Q?hxgwdq7T983dT6p1uBhp5oGwPin9U5yILpyHOklDPyhy35BcGCRyC/i5Rg8F?=
 =?us-ascii?Q?G7Q0CiyXR6+06oLHGrC7ff5kBcnz+/rB2dwkad23kO7/tGDxTXyN+sTWloZs?=
 =?us-ascii?Q?GztiBdgKiwBumS1/cnO43NzUO9rSkM9WQqhtYJStThnfvFreX/RWBY/MG4xS?=
 =?us-ascii?Q?v/T6Cui43QDmmB5IOYmEncHShwh/qCLUxXen7ZweqiCIsn1HlUUzrPTxM7ZV?=
 =?us-ascii?Q?y6l7MOjUP/VgoV9hudnGZykzF04CnzQLw9AO1d7c6K4tQjRQooCCwYJ6ggLQ?=
 =?us-ascii?Q?NYL66ZEMAL1oTtHbj6PN6sfp3zjXMWu+vfAavt8jbPSU9LqY1EDd5t5LESN0?=
 =?us-ascii?Q?ORmE0/ie31j6kUfgPk8Ma2UvlnoruUBHYhi+uiasp6xswOYIIagebwq1iJRx?=
 =?us-ascii?Q?mEbVatyc456V8vtjJGfdhyQOnxvqBm3Q6ZtJ2uNgsPow2X2JutNvrcnpwUuL?=
 =?us-ascii?Q?xWobZlvlIEumDc2Qex8/HNcA59Wa2tbbyPpzyMUl5OV0w7D2kpH0/ETdGn0J?=
 =?us-ascii?Q?I6pun9DuODcUyjckOe5/VzOCJH/fbVaeUfVi/cu/P9wk0Z7ZOnPnkGFLH86U?=
 =?us-ascii?Q?zkGj92lZjxHITbQDQnQCvRHnD3oBKiCvvZkS+85c6pCLuP8vJ+UmKDJdNmT2?=
 =?us-ascii?Q?iFSYpO3tPpYXbp93XKvqQiUWNiyjHZq2Lj28p2k9W9rIwez5QMi2aRKP3DGu?=
 =?us-ascii?Q?6nU2z+HRw9SwiVx82D5Jep5ERT6nzXWfndCVPNLw2TMwyAfu6oSvdUWV0Cvm?=
 =?us-ascii?Q?lYLnCIDM9dToSiOapQbEbXlHBq2hB3bBU9XbWS4fNnEVDCtD6gtJnF27pWx/?=
 =?us-ascii?Q?QdGlJUV6qQfUeZON/nZqLzPyP1dOfkBYqAWAJPTQZQL119PEJRyTVeCUzv75?=
 =?us-ascii?Q?HIPsIdmhs0+0tF3ExnmaU+85DjYVOfF0ee10yKbm3KR7xZ3sbk9BunwFlg/8?=
 =?us-ascii?Q?mbLQ4zAUGfE6fXDwCpI2cYvk9PmLYl7rEcFtBgqRDVKGJCHfvYtC384wRO8i?=
 =?us-ascii?Q?Pg07A4MtThmHflCTty9KCUrLmqyq3S5gIPtMn1uQWSaWXwujW95Q1sRIvHae?=
 =?us-ascii?Q?nh0qfXCQPPSvvbAyIWmI9sAnmRGga1pwxgiY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:03:24.8694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a26543-284d-40ea-6a52-08dd8665d32e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968

Add the necessary support to enable Crater ethernet device. Since the
BAR1 address cannot be used to access the XPCS registers on Crater, use
the smn functions.

Some of the ethernet add-in-cards have dual PHY but share a single MDIO
line (between the ports). In such cases, link inconsistencies are
noticed during the heavy traffic and during reboot stress tests. Using
smn calls helps avoid such race conditions.

Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
- PCI config accesses can race with other drivers performing SMN accesses
  so, fall back to AMD SMN API to avoid race.

 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 81 ++++++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h | 30 +++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  6 ++
 3 files changed, 117 insertions(+)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 765f20b24722..5f367922e705 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -14,6 +14,7 @@
 
 #include "xgbe.h"
 #include "xgbe-common.h"
+#include "xgbe-smn.h"
 
 static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data *pdata)
 {
@@ -1066,6 +1067,80 @@ static void xgbe_get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
 	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
 }
 
+static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				 int mmd_reg)
+{
+	unsigned int mmd_address, index, offset;
+	int mmd_data;
+	int ret;
+
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
+
+	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	if (ret)
+		return ret;
+
+	ret = amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
+	if (ret)
+		return ret;
+
+	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
+				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+
+	return mmd_data;
+}
+
+static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				   int mmd_reg, int mmd_data)
+{
+	unsigned int pci_mmd_data, hi_mask, lo_mask;
+	unsigned int mmd_address, index, offset;
+	struct pci_dev *dev;
+	int ret;
+
+	dev = pdata->pcidev;
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
+
+	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	if (ret) {
+		pci_err(dev, "Failed to write data 0x%x\n", index);
+		return;
+	}
+
+	ret = amd_smn_read(0, pdata->smn_base + offset, &pci_mmd_data);
+	if (ret) {
+		pci_err(dev, "Failed to read data\n");
+		return;
+	}
+
+	if (offset % 4) {
+		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
+		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
+	} else {
+		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
+				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
+		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+	}
+
+	pci_mmd_data = hi_mask | lo_mask;
+
+	ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	if (ret) {
+		pci_err(dev, "Failed to write data 0x%x\n", index);
+		return;
+	}
+
+	ret = amd_smn_write(0, (pdata->smn_base + offset), pci_mmd_data);
+	if (ret) {
+		pci_err(dev, "Failed to write data 0x%x\n", pci_mmd_data);
+		return;
+	}
+}
+
 static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 				 int mmd_reg)
 {
@@ -1160,6 +1235,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
+
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
 	}
 }
 
@@ -1170,6 +1248,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V1:
 		return xgbe_write_mmd_regs_v1(pdata, prtad, mmd_reg, mmd_data);
 
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
+
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-smn.h b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
new file mode 100644
index 000000000000..a1763aa648bd
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
+ *
+ * Author: Raju Rangoju <Raju.Rangoju@amd.com>
+ */
+
+#ifndef __SMN_H__
+#define __SMN_H__
+
+#ifdef CONFIG_AMD_NB
+
+#include <asm/amd_nb.h>
+
+#else
+
+static inline int amd_smn_write(u16 node, u32 address, u32 value)
+{
+	return -ENODEV;
+}
+
+static inline int amd_smn_read(u16 node, u32 address, u32 *value)
+{
+	return -ENODEV;
+}
+
+#endif
+#endif
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 2e9b3be44ff8..fab3db036576 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -242,6 +242,10 @@
 #define XGBE_RV_PCI_DEVICE_ID	0x15d0
 #define XGBE_YC_PCI_DEVICE_ID	0x14b5
 
+ /* Generic low and high masks */
+#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
+#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
@@ -460,6 +464,7 @@ enum xgbe_speed {
 enum xgbe_xpcs_access {
 	XGBE_XPCS_ACCESS_V1 = 0,
 	XGBE_XPCS_ACCESS_V2,
+	XGBE_XPCS_ACCESS_V3,
 };
 
 enum xgbe_an_mode {
@@ -951,6 +956,7 @@ struct xgbe_prv_data {
 	struct device *dev;
 	struct platform_device *phy_platdev;
 	struct device *phy_dev;
+	unsigned int smn_base;
 
 	/* Version related data */
 	struct xgbe_version_data *vdata;
-- 
2.34.1


