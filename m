Return-Path: <netdev+bounces-148167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3399E098D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098101636A1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0121DDC32;
	Mon,  2 Dec 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZiH9r2E+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA71B6D0A;
	Mon,  2 Dec 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159576; cv=fail; b=jZBXeKvN55UT40a/l3Pce4SETuG3UQh3gzSwjmHooT4Rk4RepzIlHZACac0jdq+Sx2GJ7RCLr1Cy2Rafk9qmF0LoAv/N+72Fws1Hg0AWVgo2WJTXSgPu8MjiOyFSS2TwaDoLzCB7GFEXtyp1o+USZ3Q3kzog0N7D1Nddnpxf0+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159576; c=relaxed/simple;
	bh=8MIy4mhS9InT4qDaJJBoe5oxJ7kQoR8odQLTfvRu9Qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YitJ3RiHr0tD+7L0QURE6Sb+HuMDQ48dKFxxpocIGss1olNf+qXsMWfRgYWX+qcWD4P75287gYIWCi7vTh457GotkDkkLKVvYXpzLMcH7xNhFGU6/8PMP+bhCGnC0Efgh6RziwiTU/x68OpzKlihwZhXLNx8jSptRNSgbQ3W7ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZiH9r2E+; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9BBoa7IDClesJxFyJdBFcJ5Ev45CVYJaYIPSmJTaFMZqYyY/Bu9M0+nRLsH2B46jfzlhJEuxnWKiimH4JQyUOkGF4tGWotmhwNhf9HBZRYvaj6cx6mHP6JjDw1lhlVepFQ0vm9W9YryxkFakRqepKmrQw6i7F7Czg4nDkhc5XQICz+berrIbuqQYYmxQ4yVM9DMVmNhK04g10t/SOxwhZO1UiwVJ/48+ZYYDqX5WTVrERPdfqRTYY5pQ+ed1Zq3+Euh7pyccbJoFolKslo4NtePxZz91TLdC0pH9G6xfr3aUHP+C0R9LXsZMaXCuawjSqBLp8I4W63ZpPsBwDoYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDqiyOkYzOZw2HTaMKuN+wpL8mBGD6I6C1rH4H+psjA=;
 b=wjLcmAVo/R33C4VuGls6TEMiuxLOBxzySGetkVH1fCyHc5wFJUyuofMbcPdwv5VKrU43Ob2NcBZcZiH7Rt2taMQZ8l8KK97iLZc3TUNOSra6vOLLekBJrh84ChvOAbfNK1+IrRNPJAOV/5YvOmHEQb14kBLS8a2kDfX+iykdP9rwzXZOzjVs0o5j+5ce07f5rAHI5VPFSpAO+IVWXRfHrslfd9cw8Fo8n2Be/7y6+arskdaZl7euDze33NetkjlTIl3SCPg54j6EGPOQX4G3sBYWUvElVFMi1cfa5LqiXVYOWUL6sZr5hh4G1LU0oKEGAoDAFwd0/umScYw5/9w1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDqiyOkYzOZw2HTaMKuN+wpL8mBGD6I6C1rH4H+psjA=;
 b=ZiH9r2E+GJs05iQvrxqz2PhfJRct4cXSZ/AL1YU+2DMZsOFOkjyaZIiPBWOymA5Ro2JYOBhs1UIHypwYVHGtjQrkT8rz3aeL/Hwk2WzmdgEcxKhsCyQ7RHezrZorEPDBLL2zcNmbJprMYUsLb1zLf9DEpCfwsG1zIqpKFDOX+TM=
Received: from BN8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:408:ac::44)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:12:47 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::55) by BN8PR07CA0031.outlook.office365.com
 (2603:10b6:408:ac::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 17:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:42 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:41 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 07/28] sfc: use cxl api for regs setup and checking
Date: Mon, 2 Dec 2024 17:12:01 +0000
Message-ID: <20241202171222.62595-8-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: d44ca879-0649-416c-c9d0-08dd12f48b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2EMAFOAW3xNyH+EspVU2s8SvvWEqFg2u4GStoERoh2C+moKN9yydu2vOIfKe?=
 =?us-ascii?Q?1S5mPCkxt5r4GRhESJQISBE3Dmtw6fTluets5PlhLHiNDMI74JAIu99/IaTI?=
 =?us-ascii?Q?PoCBN3N5iZzkhBhHcowlVOra5CW6ArY1fd9FH6rGFPqemKGtbavaRfB8c29h?=
 =?us-ascii?Q?WGoezwtz1RoViVQM6MVKJgBgYFqZrjpaUGc/eJRffWrXInYYnuOhICyPhnd/?=
 =?us-ascii?Q?1eehIMihTLwxfAIJu39Cp+HKq61dO48MluCgYYMHmHmWj37ozcO4uVKO0rXv?=
 =?us-ascii?Q?PgVKBSzHJBFDSBJ4RC6zGtCqBVq6981HdqOikeiMhJQHnJ/gcpXHRSP6/0XB?=
 =?us-ascii?Q?yAGvnSIrNZJIodHCKM/yGrPHT5qWGyiJFgRPqR0sjg+8XCwtfw2fJsxAP5Rx?=
 =?us-ascii?Q?Shzl8Jl77TlW2Q275bcNYe6f2jY7z3deUGL8QF8EXuDXr0dmcPhyqhJn0bW9?=
 =?us-ascii?Q?FiqyayyJkOkvvwdmwYl/PBT4JNehpGhYRlA0Jh23P+uklGCJIl4sLsxlz4w4?=
 =?us-ascii?Q?Rx0uyenJ029X5CdpRTi3RcXDLDU+dnbH7GVjFB7XzJffHSHF/R7iMiS7R9N5?=
 =?us-ascii?Q?VSmtfH4YryMeROpBe/dkIGhdjQJxtrapU9DdJDyzFbE9dRRDXuT5kxZ/Arkp?=
 =?us-ascii?Q?7tLn0T2glR+RVQI/4sLxiAFvPIKodkGtgPAky5KTOXcU/nxnV/qrG5JuwfEC?=
 =?us-ascii?Q?3TGkc+/8lk63VoxwEp1Wzjwurboe0Zz3ffYIGNlZzshoy5gJI8gfQ4k+Vt+u?=
 =?us-ascii?Q?tgAV/jf1AlMafQV/yPSFH8lZs2ev6XU6fkufyH978Y5XbqXyW3BU+nBK5qFV?=
 =?us-ascii?Q?l2Big5bzLyQobCpM1OltxuV8601OE5N0XpNUdNVgLVvyCUYz17P1P4Ddo2x4?=
 =?us-ascii?Q?oS+yd3ANdXA64C97p8RZH/QPIbqOX3rNGBTxBaEdYP6ORO5CPUMpmCGJbdh7?=
 =?us-ascii?Q?1buJdApQAZRCWf3NF8vfhMxpP2Wdcn8BSedlcTZmLsNsNG/7C2WIxqeE6tDf?=
 =?us-ascii?Q?uzWRAIf2QBeTSaPNDRHAnkxIn4FnnYcxZ6brt13hdW2vC7YDZ4YIEqmGCTpF?=
 =?us-ascii?Q?MsykfLUFK/4QRHjIxHVxQM5pF6WX1MvarR8WEPd+WWdHq0UBWMKtdzwzQr8m?=
 =?us-ascii?Q?b5X8nMR3fnUgEF2Yv7lXMolZ+wguvdYot5VpVMIDdgDtmFhySenyJNmfU23o?=
 =?us-ascii?Q?kvfkpH7DRNlLB8SQuZL9rtARmMbZnCOmQII3xT9WCDThXncy/g4blPOp5o3e?=
 =?us-ascii?Q?BO1Te8k9ac9R1cUW+Y4KHH9w93BRIfyolJJ0tL80JQzydQpP7zlCX/68i3xk?=
 =?us-ascii?Q?GzjWYrAONgcBGohJs9ellvXmzGjSHrPnIdS2uQBgk0k6N81cuxMqj3VhdBaV?=
 =?us-ascii?Q?Oz+rk77wvqINDGWaPu8D0MxS/GCVcKO1VgamjgYlkpNGhvlHys1P9wG+Ts0l?=
 =?us-ascii?Q?IZ57Tdq0qhqqvokc23DuikOByilnrIltBggJTJitKOPL0q25GCEz7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:47.4803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44ca879-0649-416c-c9d0-08dd12f48b57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
 include/cxl/cxl.h                  |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 9cfb519e569f..44e1061feba1 100644
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
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 05f06bfd2c29..18fb01adcf19 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -5,6 +5,7 @@
 #define __CXL_H
 
 #include <linux/ioport.h>
+#include <linux/pci.h>
 
 enum cxl_resource {
 	CXL_RES_DPA,
@@ -40,4 +41,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *expected_caps,
 			unsigned long *current_caps);
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


