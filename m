Return-Path: <netdev+bounces-178314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA5A7692A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581013B40AE
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C162521D3EF;
	Mon, 31 Mar 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cKSEKoER"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DC21CC6C;
	Mon, 31 Mar 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432383; cv=fail; b=BzYBdNU+OMf3o5PX5sdlfFgBV3yW03DPS+MsKNIpRIS3+WiK/npQ1TxZy6AQw5fAmF18R7HAL3YCklORo12rao7HtzUp2castAWGfUmteJNPZQAJDtUwvTuxU9B/V2QPOGDNF0cSfXjEotLjCFXdDmOXzqBAcDZN8hUbC8/Us6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432383; c=relaxed/simple;
	bh=nhhK4pUp3in92opHFTBAxxPOorXP0kb4LXyzfW7eeYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1Dh3cX2fcf477553+2kaBCeGa2d9gsYusnUP0naMyRFs3ngN9wUADNzFQzIa+6JpLCKAgBT4bZpkMPBiQ3hVYKNuZN8kvvsrvrOq07DO7pP+12AVnpBxbIuJDaiehfUIfjDF50/npIyVYFa2tIWHl407v7YHZ51qZ1VXxCu+/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cKSEKoER; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAj+Ke+51OkrfhhSUCNOSqNqFsIcndNodMPSSdN6sPvzhT6bYQo/aCavk/n9kOTso77bbV4VeKziL72X7wkROLoxPVFiWj4RCbelDzKrEnPWhe9kB0jlA1aIRbb54hNxJxFqTCQGd6ysbcbc9AytSdpd62i4wi8XhrD6tivsuw2lsGLO1ZFmpCpe4fyy3JrUvGTi24iS78iPyRNska1w2Co2azejyS3SjJC2LAATycMDQ+de6elZkkIMXccW3JOmfPeMtt47GK8bBJPO75WUy4+LzU5ApQ+YPFUlbRBQtlE4iq6uIDkp7enFIzoVl+lw2EL9NbQI1CfX+KNh64m7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWYoJa4OMgCUVZXCH+kF2PxOzuXX0IOxvNSiJd5Z8bE=;
 b=QuHHGn6BJr3062lT3j98CtLISyD4ZwJb0PkulqpxlaozMZ2cdQMpvB3vh8pDUHD0k4Oxhv4uEQ/2GE/Sw98TzMasS1J8/RuJNNT/dfhBmtUR1DuP4y5clszGcfmdeRkxuMBF12zWzozM7wvWnBuUaH+gawWyGMemTwJs7kxyu/zbw64FmiFRX88JeAkjlWBqfNijgD7SHbsw/Yk0kk7et9pKULJ8brlAhXGgCzFcO/S4ObVWSvHRhbldjgjHXW8rlEgclUvuS3FnGhbMJbi8IWpyL6igPJw0QXN3M1l/XvEFWGmzlNpRAkQrY+eQrHUMYo1bEylJoJuAzQXIF1yftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWYoJa4OMgCUVZXCH+kF2PxOzuXX0IOxvNSiJd5Z8bE=;
 b=cKSEKoERkkxHjZQdAxSsACoCBV0a/Z8jJFP6lWVuoKUWxkpVe/ZJ8+vxZfvVZYAcrbD6WE1T66idyM7fNgt/XBFmWPnDzauguezh7x11iNfeopkeJCoMpWHRxFiLOry+9NP3ijllfUWWtOGLJwcxDMRxCm03lSpqoPvkjkrDBWM=
Received: from SJ0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:a03:331::16)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Mon, 31 Mar 2025 14:46:18 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::e5) by SJ0PR03CA0071.outlook.office365.com
 (2603:10b6:a03:331::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.47 via Frontend Transport; Mon,
 31 Mar 2025 14:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:17 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:16 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v12 05/23] cxl: add function for type2 cxl regs setup
Date: Mon, 31 Mar 2025 15:45:37 +0100
Message-ID: <20250331144555.1947819-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 71dcde88-7202-4ecf-fb78-08dd7062cb95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OJILYYOwlx43dpNMtiJVuGL8mygRLvVkq0M91BZ7KqRfW/YYygbgHq9+65O4?=
 =?us-ascii?Q?va7q3I/v2kbireO+8mZCpIChGU87i2/RQf/6EP31Rg5HC/LF7l5ZO959N05z?=
 =?us-ascii?Q?VYKpEZBp70E8nyrvERCGbItHjiN3m27fCvGEFzOS7+W8eiomUEm/DkoyrDoS?=
 =?us-ascii?Q?6O5YB9YifTX/rVyLL5Yn0y0rW7qeoGu0HRhbNSkFBlQN1u/fuu+mJCk6kVbU?=
 =?us-ascii?Q?vs8v7zi1oGOOxMFpnp7TUQ5EYdIwRUyBWa3J5fA1pZJZGaqyBXywPyrULxF1?=
 =?us-ascii?Q?PpdBp7A/xkdA4e7apSPfvmWSu2GsZSLuC2YQHUTBdMXV1hM1JX9YRkuWLUAV?=
 =?us-ascii?Q?nOz6jfUBRnGkzsgut6uMaDrGF+3txws3GlofYQOIflTzxu+ZTpPoDbV3Zx/m?=
 =?us-ascii?Q?4eMQZnGlzypDipQ6fkWwqSYHtdJybgO+bEYA4DDCS6gRJ62t1VD0thbrAKmy?=
 =?us-ascii?Q?zk+VMsBPR003UQrmLCWWI7W5vPqZN+kpK0DuC9DVO8uLf9QXZpuuToFt/Iwe?=
 =?us-ascii?Q?CIdSQlwFSS8AxsAukJgH5VFJg1ryyi6ZK+brjSMBPrukU/e8j9dAeMvJfYEQ?=
 =?us-ascii?Q?4CMfrrWpUxbpY/N8FQq4x9wwTnGMqnAry0FqTPp2DpDT1tDV8zDZj7Nzgxbg?=
 =?us-ascii?Q?R8XvFi8Y4dqX1348K7H7fM1JBPK4OgulFJZpWym/5FemDdalyX8vUVTAGzFj?=
 =?us-ascii?Q?uXMRN59wSl5Zwaa1qwcFq0viuCOt9oyNjIHvMgfCCXwkioj5FudM9WteiTbs?=
 =?us-ascii?Q?JFDuz13VknJz6MrMDBUk5NhQzLyMIBxJ0FHZaj20OGfNNqwaM5I2VkFr5Gam?=
 =?us-ascii?Q?YFxobcXu20Bh4WMG3nORiIiw2syeBsxNAqhoqmJEJa8crcSaWzwSo+siWaLZ?=
 =?us-ascii?Q?k+VCm1GDpIYE/8qZWwwkZ2KBBhPGL3OoNGiCdMPhLjIsDN6+Ku2jdA7ozVxL?=
 =?us-ascii?Q?0aH7yvwZujhDHwdcNrzwx2ppbExRhNDDrmkDnERTUnfGvdcABuNKVPPcSBqb?=
 =?us-ascii?Q?wmKZy//UCLjqdCXyZfnGXZ88b1mFJcfEs6Rb3CVhP5C3joExhPytayUkj4br?=
 =?us-ascii?Q?3sKooZPSGYQDrOy5MiFKPV/ZEWpPeB358RtRfDgD+/bDKKgToA9T0RgNvTN8?=
 =?us-ascii?Q?cj3kkt8k+v08Qb2BZQUYWNgVr0hHgPprF6TmrIEYa9Oe+B0MM9KSGDr/YF53?=
 =?us-ascii?Q?pnec/eu7JuwKMcLc0G5KcGxv5enPcosxlgucTl81mItLhRPvkXNi5pBmebN+?=
 =?us-ascii?Q?8G/Q/6VOQ9WwPA+Uzox0HahwL2xijQZILmk08kiEzkbihRmUvY1b9vAGGF/1?=
 =?us-ascii?Q?WxP39VSptPy+1/xrP/epwoxPAX5xmhk0VpYuTJSEFW8+rDQqrcvXmJijQf67?=
 =?us-ascii?Q?1nTaJN6znRxrWZQkLtPyLdgbRYLYGEXcDoPYCADjDuWOZfFvNJ+CzjKbwnF8?=
 =?us-ascii?Q?0nXGR4tIfuQpobdtD8P0xmxMTGV6JheQPSDLe7BlH5McdwU3Gj63tGk3p3w9?=
 =?us-ascii?Q?A9EgM5AI3I7gwkU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:18.0563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dcde88-7202-4ecf-fb78-08dd7062cb95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Export the capabilities found for checking them against the
expected ones by the driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  5 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 05399292209a..e48320e16a4f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1095,6 +1095,58 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
+static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
+				     struct cxl_dev_state *cxlds,
+				     unsigned long *caps)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
+	/*
+	 * This call can return -ENODEV if regs not found. This is not an error
+	 * for Type2 since these regs are not mandatory. If they do exist then
+	 * mapping them should not fail. If they should exist, it is with driver
+	 * calling cxl_pci_check_caps where the problem should be found.
+	 */
+	if (rc == -ENODEV)
+		return 0;
+
+	if (rc)
+		return rc;
+
+	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+}
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds,
+			      unsigned long *caps)
+{
+	int rc;
+
+	rc = cxl_pci_setup_memdev_regs(pdev, cxlds, caps);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, caps);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+		return rc;
+	}
+
+	if (!caps || !test_bit(CXL_CM_CAP_CAP_ID_RAS, caps))
+		return 0;
+
+	rc = cxl_map_component_regs(&cxlds->reg_map,
+				    &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index b9cd98950a38..a3cbf3a620e4 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -226,4 +226,9 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+struct pci_dev;
+struct cxl_memdev_state;
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
+			     unsigned long *caps);
 #endif
-- 
2.34.1


