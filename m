Return-Path: <netdev+bounces-148164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DDC9E098A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369FB281800
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF11DD889;
	Mon,  2 Dec 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uWsUteNS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82561DC1B7;
	Mon,  2 Dec 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159572; cv=fail; b=mfz+s6GXyrErqaM8GQPa5XmCJLPm13wnnZkfmwST8aVwoyv4fefNKVAye5ckeCNYBluLnUBp0DjvAtn+S3H1l1Hx5vYNRlf5cAnzpkXX3GX8SyJIHqkPey4xx+nL8GG16sQLJuBPCetT+qs6lFMINHcyPCSOsGUnOHKR9wY0OCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159572; c=relaxed/simple;
	bh=7dJ9SCpR56jPC+onx5S12VipgcO32CPE2cL5ssgk+QQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpfFRTlb8+zr3TTkkekKd/HPfG5YL6Sk2WCTrmsN9aTAfDaGVhrxp3jIQbKGV/ec342EWHJDXjsIODJVKCWA+1DjuVG+nT1epdmmKH3ExTEOYJacSSux4tIvkPSadgX7gNlaqbomCg67CWSlXtBmgnhc7ny+zM8ej3+fFq7t0Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uWsUteNS; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyCinR+lDkSDDnwT/jnnUzpjOFlBjdmI2GDJ/QIm6ETk7WLwk6kLfV+mzmP4zDilIs0QDDJpW1m5jnhf/hoSo5Ba+rOr7Zep8h5eghDM7hz8UNT9/oeEAjr3kOAbkmPLGZ/DGj8mgiDALU26PXAeboGqD9WhjcuVuLwx0zSk172+wbBj/XUx4F6M2w1nnw72KHa9bRu8UMKVkfqZVGHp6A2OnDnE59kV4WjQ0DLm15V3zmZZbqE+2wOHjqCEOngBc9yXjqwiPU0i058T5TPTRvWcf3E1EcFTB6MwW4gTJgAot4S9EfltZ3AdF49u8F6vI8sB0menYa5RyJGGNgz8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkFXJXTF1hKUCjyFZna/mfhOgWf0R4Zmv1ecOKxtj+o=;
 b=AJhsjht7x4n8RF6KD1f8fVhw+hL1gLyfbn7OtTtET0trlVVPXnPxrRkfEePpZe5Fu/GOjw2uP+2x7hwC+ChXetyRN3B7n9hFpA1Qv2/IsJBkQgKNNcIoBi7r1QKHVMyx6tidi/a1inxM60wLEq9vH8Uu/ILOwotU7D0j8h4Gf8ve2jWPY5S/B5ZEG6Tzfvl1wakM1auUdPALpaOy13CHgm9XUbZKj5xDPU12rmjQo37u46O1k2jA2KJrq0aG307n40s/M/a2woEkyTU2MGqT2p1YBevlWlHp/XmQMhmXTiPtaMq0Mfha0p7HNUwXomJmQ4wYktAPeosDphxPGW72GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkFXJXTF1hKUCjyFZna/mfhOgWf0R4Zmv1ecOKxtj+o=;
 b=uWsUteNSOmnV0KAogQ3t6ANiKlBenmQOA+GQj8Ukl2LhYfCXf+UY59Yt2ccK4x0LdbqWfcih4iTaKBl8+Vfit9YLYevx0McdCyi8t2HE5Vz2t586jvJZpwCw51jYTAYzfz4eNICwzT+eTrqa/QoLIv1BV7IspX7AZgAx+X+Hsyk=
Received: from BN8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:ac::39)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:12:47 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::60) by BN8PR07CA0026.outlook.office365.com
 (2603:10b6:408:ac::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 17:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:41 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:40 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 06/28] cxl: add function for type2 cxl regs setup
Date: Mon, 2 Dec 2024 17:12:00 +0000
Message-ID: <20241202171222.62595-7-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5aa547-16a0-44d1-3028-08dd12f48afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ulMpHYZtC89wTTttexH/IMLv7E4u3zVcD4Dm4U1L+X4x6an9/nUVjxAxicPd?=
 =?us-ascii?Q?4j9827sSU9Sxhg8/RxisqxXdY///OvZHG5+19Ez2Z0/mECvoHbSMLdCB4Oqd?=
 =?us-ascii?Q?hlBGEIy+EjQShakfzUjm8Xo79fDgWkUrtojbuVbCdsAbWso8WMtmsiuWjNjC?=
 =?us-ascii?Q?bNRziy6J7YFnDJJb9fIdEPqJBPn0XmOUVSPnOC9LT/LWAWT9vQGg3V205x64?=
 =?us-ascii?Q?rh+vfJqw3AdaM+PNev3qxQ2vEyCJqLUart+zRKZppMR7pQLzG3xhJzF0KCqa?=
 =?us-ascii?Q?YaG3Y5Ttdj1+MQ4nwxVWwgis/os5CZjtNT0gpI5FFxiT3dc+23E6M3EeFpQw?=
 =?us-ascii?Q?+zJQeYRRTRH1COZFG7ujsEFDrYSamjeqVAzD5+z2UiPdeEiEe0ZVSdFkDzHE?=
 =?us-ascii?Q?d/2GRhh8d9rO1kyj6FbXsf5hM1zhf8IpZ+XYm9yEhpHngYz/PNmsj6p14JrJ?=
 =?us-ascii?Q?MRFmFoUy5takXjIB9rJc1k3AsK62l3RIEfzbW8j6TQ98mwaApvcGHCWKm6Pq?=
 =?us-ascii?Q?uE+N3juhiCCyK2EILBejS31nCF0iKGsAQyOQ7xRIMLaEVihZrNuCXRgFTMRJ?=
 =?us-ascii?Q?PoTINkDoaVBT6tyym6MubaYlFRd9CA6TbNg3iX50jnhvHiYNZYYhDRFP/FEM?=
 =?us-ascii?Q?lyNCIB4e8unQyU2o2+pby9BcdTEI8/6+sR+yzlRdg1JUnVu3TFMLy4WSYky6?=
 =?us-ascii?Q?GMfTLrg5WWZgwtxvSGInnKnCdKinBMRor7UD383VrDlZWg9Tre42c3uWb8H3?=
 =?us-ascii?Q?Shbp19/kcgTUXsYVFgeCXRwx8Nq/NjA6r9x8yT+NvUK2yynLzvz01VdKCf7w?=
 =?us-ascii?Q?WeSsptSEjF/xOeCqna5NIuti09z+W4nBbX9o5GuDVpBX0SZid5hvgNvNyXbQ?=
 =?us-ascii?Q?1Fn5/D6wXtkkDnajukox8/Dux+T0ZIMpuYkHzi+FDgNBCwnZCqPk0PGp+fA/?=
 =?us-ascii?Q?SACJaiIpumbmk4h3+u9qA3Lqkhjfp0r4SCzd12FVFUgTqGu7q1pPfu6XMh4W?=
 =?us-ascii?Q?/EFZHI/yD0KR8uDsczZNrQ3Xn1bn8Cr2ahJ5LeHgTXZzRUzxbe0nQWbDrHy4?=
 =?us-ascii?Q?sgcd/u/Xk2FuLtji+uyAOLAH/TILALFVmjMgF12QEu6t9mvcKBn+PdF9WJwL?=
 =?us-ascii?Q?5lYPgukhKl94vfPsA+U6lugGjjE8JvLdKVMCSvddPiNE/I54+xrrCo5keLn1?=
 =?us-ascii?Q?uUQ2An1TOD0MUkvtFu7X1UjVzIxQ9z35N/Y0vpHfRUDYDiAorpolxkTOUBFK?=
 =?us-ascii?Q?81zxXtIxe4NUBMRo1Mzj8hmwXq2+eUVKbUd1ViwhH4nZDsDG1VweTIt3Fzf5?=
 =?us-ascii?Q?fQ1Cr8uOPyY4BAgTweP+gdinqbforma0bAEgv7t5LUlFs4I3NKopBlvV+YtB?=
 =?us-ascii?Q?yKdQF1yPIRenytjnl5i8SIW10ugJ1+FWTSNZUxySjhUkbYlQ2CafWG/YOJJz?=
 =?us-ascii?Q?72uwPZ/IdGr8wK82bvnq7KuYuKgEYjkdyBl7K4n7O/l2iqHhY0kWPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:46.8866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5aa547-16a0-44d1-3028-08dd12f48afd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 378ef2dfb15f..95191dff4dc9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1096,6 +1096,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
 
+static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
+				     struct cxl_dev_state *cxlds)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
+	/*
+	 * This call returning a non-zero value is not considered an error since
+	 * these regs are not mandatory for Type2. If they do exist then mapping
+	 * them should not fail.
+	 */
+	if (rc)
+		return 0;
+
+	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+}
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
+{
+	int rc;
+
+	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, cxlds->capabilities);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+		return rc;
+	}
+
+	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
+		return rc;
+
+	rc = cxl_map_component_regs(&cxlds->reg_map,
+				    &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
-- 
2.17.1


