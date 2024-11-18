Return-Path: <netdev+bounces-145942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA329D1596
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E27AB26795
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856771C0DFD;
	Mon, 18 Nov 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HI/bq064"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C61BD9F9;
	Mon, 18 Nov 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948298; cv=fail; b=YPj3UMZ44/Wybi/3H0QWJj8e9eMzhrh6EUBOPGHfeNpr6vGlP5gT31VU5yMER7qWD5Dv1r5tg1tTKF0p9jkCueY0rQA/Ur7D+9RzVhs6anz1mPlrSWOccG+22ZXVAkQDhcHD/rbRxExt4GJLwZelo9DABR0eK0W4FPCy8jhTPGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948298; c=relaxed/simple;
	bh=NkjVDGA8AG1gfQQV1yvkZKsqKU67SCRNIk0KuMrNP94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nl6jV/RW0UDf+gnQluSuYylxpkzAhWTgtyp/zflD2qc/1HY43mvQd2U6z9iasJJISFcF31X2jNrb8hAH3hmRBZkwbhP2SfmORWv9KquiXoTnuoW26cLGoVHkjEAteU8PfZMxMYrunDcgPfG8j4Wd7l4fZcw2telKvWQxrfulYsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HI/bq064; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7hDSbTpXYnXbnckkUZTTUBtxMNwK1ZFC3BucPcKpKesZxDK6E0bCfsBXJFIe84IfUO/CyNMF24jYh7Ld++L/M+qJDkBPwt/Q0ior43g5m8YPuSfy/dZxgqUUeaNCJnYnRbWryiHgQE/vuM33UG03pV+FpAGUiVl9feO6643d1/Pb4DfaAd0tbdWPYTA/mu4GVWWVVqQ8rJUOBlQt8gMLLrqXBm0T/YIZOBaF2vcasrm9sg/Xf0lkqLRx1TiLZSpDd1qtqm5eOq+zIgDD5A7ETizei6tJaXHgqSAsm2iU7Z6W24mQ81PSD5+9TQtvw6ssjVnlbiSHXy8yovI6AMjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7+sMZ30Wzm6SufVdNgXk1hx26tcW7DQYESo92gicXA=;
 b=Gcol+V2tOC6fP2j3HBuVPE0s4i1MXpQepScjCD8G6E2JGLvnTdaRoJ+1D9C56YpaKqzWRB1tmjVOWAJ0A1HcHdJ1/ZNL8opXTXcyL9RPCiIDzGe0oEVWSp/4zs2yEbHJoCIoSJkbb/XBvUEKziDRz6TvUlVLWSiMSFlnAGFsQnBp0hyXx5HY/HatbkERUDRh7179DDKNO+2C5MYToBUPbWjXZquSJmjGY5x0J6AGb770LrUCb0dKDMxHy97m6L7SXPzCQc/zLnLil3+RpD8XpQAXZBwZip/rQlplmJw7fMsIcqWUlz+cy3tFuUapIIGiz52v945z+fvK27/Aff+Ksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7+sMZ30Wzm6SufVdNgXk1hx26tcW7DQYESo92gicXA=;
 b=HI/bq064HZSw2S8j8xkRNYsHhGvKHp+42zfTNSrD9oLpizV8zvmOrEuWcTWCYA4MRJbYuZ0/9466TlVEmlnCY5wi60arnQ4y+jijRhfDB3eGsctRm6m9klLcAr7DOabLdSpDCyNomCyy2YKM5itkKBfbm3DHb9x+r3HqAR8ADy0=
Received: from DS7PR03CA0266.namprd03.prod.outlook.com (2603:10b6:5:3b3::31)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:44:53 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::ff) by DS7PR03CA0266.outlook.office365.com
 (2603:10b6:5:3b3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:44:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:51 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:49 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 05/27] cxl: move pci generic code
Date: Mon, 18 Nov 2024 16:44:12 +0000
Message-ID: <20241118164434.7551-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f0ab9d-7b06-4ee4-3897-08dd07f052d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SZynUcsYqdh41UHuG6SjQhYrv9iBKy9cWFep0QDY8/fPXFJtZ5UQXvRw/Gfn?=
 =?us-ascii?Q?V6HKk4mcYGQxy9UKQoibG5Y4sTZTbTsY2ZnhCVcRDA8EV2xqxk8q9fqhFseI?=
 =?us-ascii?Q?3iCVQu8zeeszdxZsL16WI/YLjCD/Ki9OWZeFcIHJHQjZTovnJ8ms6rELTMbd?=
 =?us-ascii?Q?5izzuuR/lYvoJ7RN2DK/IKQZ1Rc35cfG7SmDqq+iM+UsJo95rLWWF7UkY8VP?=
 =?us-ascii?Q?axKuHkbRpcd4bMYm4PH3r6KY6WaU8ZOAcmedgPEqU6BQB+dW4xKgDrw/B0bx?=
 =?us-ascii?Q?W1zFu+wGhtsEDiCCOV0h5OMLuH0mM1a0LiLjnHVy/im23zIk2ocFAV6AiKdM?=
 =?us-ascii?Q?slePp2QcBt43U8LTR+OUryC1hFyIhUwdceVurUt1uasvMF61Qh3AM7YdmnOF?=
 =?us-ascii?Q?Nu5CtMSSu/3i7Zn7jsQ+Ia71gaWIkEfClTEy8OhXfjiUUIhiOeG4MarMZ6qg?=
 =?us-ascii?Q?JvDJgwzLYrBIRFR8Q2ZEozKk9ZLtxr0IZ1CfFe28GFY/B5dbNj3QKU0XFZQm?=
 =?us-ascii?Q?19npT1AmgRd4CyK2QASs5j87eKeX+1O9f37J/yGvmfBPGsA4miX/nL+zACZ0?=
 =?us-ascii?Q?Qk1aQ8mMVS/qyHeTHv4ikYBukYlhx5sBlFKm89HNkWVx9ZgNvmBT8ZcyggDF?=
 =?us-ascii?Q?G3QcP/hrmyn68iDERzEx/RLD4nU4M1K+HUMBL17imHWJXaztWzbRAqcM1Kxs?=
 =?us-ascii?Q?YXnVBBPjQf2dI/mUIt0E2+YRTVejUNf0XAvkZqibFw57TUznaZWi64AWx2fP?=
 =?us-ascii?Q?D/OPxpQVB8PjIO/HxnXmyW08VDeVk1TzhayxCVkXIppHTAFGzFJwM67iyjWF?=
 =?us-ascii?Q?J22zC4dM6s0m9/uL88YHWUN/KXFx2upKDlAc7+qHGgzysnjKqSULJSB0b2x+?=
 =?us-ascii?Q?Y7phObMqhKEhsaX97Ae586paW7iwqROSV540B7Yyr/RWvXs/MAgTPGIp24cG?=
 =?us-ascii?Q?wZfyIVpBowKfW+zfnF2NZd63plyKMngoFfhr2x0ZdE/qeWe51huwkQBHTa2y?=
 =?us-ascii?Q?3eF3Tr7/2Oor7/v3LO+6RglWi49v+ZNTQ0mV70RvhLCJEWXSXFcH+ETJaKxt?=
 =?us-ascii?Q?pOzWFpSlWbCyQnqVg7+5dBBZRcpAQ3me5vb/snX/IqHt+q1UfDoiWHrBP27U?=
 =?us-ascii?Q?YKIVUVCs3QKTVcwkTnDzt6Du8QBIBhPsaXX9WcenWQemWb7cFPpBIBKvIR9a?=
 =?us-ascii?Q?KuZEyMH+TQFI7JLn/qTXeLU9B2vgrFtcdkICmUyUdn7SV+BUvij0PQwYT8vu?=
 =?us-ascii?Q?8Fzq99medkzBaiLOwHwRbA9lDKzR/eQlDgxj03fjv1fkG2Jl0SqymM825NiR?=
 =?us-ascii?Q?53OSjYluebVXh/5Z9ZtGwM1/Z6vP58xDtR4bjSF/yRB3iOoGFojCaHgFnhm8?=
 =?us-ascii?Q?78szhAyQKKp2UhdA9sjCW7ODaRiSxWMQUFPy4kmh0cRMvSvSnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:44:51.7788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f0ab9d-7b06-4ee4-3897-08dd07f052d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
exported and shared with CXL Type2 device initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h   |  3 ++
 drivers/cxl/pci.c      | 58 ---------------------------------------
 3 files changed, 65 insertions(+), 58 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a1942b7be0bc..bfc5e96e3cb9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
 
+/*
+ * Assume that any RCIEP that emits the CXL memory expander class code
+ * is an RCD
+ */
+bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, CXL);
+
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.host = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	port = cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+
+	put_device(&port->dev);
+
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map, unsigned long *caps)
+{
+	int rc;
+
+	rc = cxl_find_regblock(pdev, type, map);
+
+	/*
+	 * If the Register Locator DVSEC does not exist, check if it
+	 * is an RCH and try to extract the Component Registers from
+	 * an RCRB.
+	 */
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
+		rc = cxl_rcrb_get_comp_regs(pdev, map);
+
+	if (rc)
+		return rc;
+
+	return cxl_setup_regs(map, caps);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eb59019fe5f3..985cca3c3350 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+bool is_cxl_restricted(struct pci_dev *pdev);
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map, unsigned long *caps);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5de1473a79da..caa7e101e063 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -467,64 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	return 0;
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
-static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map)
-{
-	struct cxl_dport *dport;
-	resource_size_t component_reg_phys;
-
-	*map = (struct cxl_register_map) {
-		.host = &pdev->dev,
-		.resource = CXL_RESOURCE_NONE,
-	};
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
-	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return -ENXIO;
-
-	map->resource = component_reg_phys;
-	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
-	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
-
-	return 0;
-}
-
-static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map,
-			      unsigned long *caps)
-{
-	int rc;
-
-	rc = cxl_find_regblock(pdev, type, map);
-
-	/*
-	 * If the Register Locator DVSEC does not exist, check if it
-	 * is an RCH and try to extract the Component Registers from
-	 * an RCRB.
-	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
-		rc = cxl_rcrb_get_comp_regs(pdev, map);
-
-	if (rc)
-		return rc;
-
-	return cxl_setup_regs(map, caps);
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-- 
2.17.1


