Return-Path: <netdev+bounces-145946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929359D159A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E651F22EEB
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277341C07CA;
	Mon, 18 Nov 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yFSkdqu0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910051B6CFC;
	Mon, 18 Nov 2024 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948307; cv=fail; b=pUNScqxZczIjv1KCUr4pOgtDGu0IfrI0OQiLtG4xKpW8zX0sRRxukbM1DPlA40iIrxZPgc+3gzCTz2CmNamDYsMqUIqmpLPk3/vzMdtZrJ6uzsvbHSDOTMHZFwNPWxkAqVzbCIv3nxQj1fiXN+VEFJwxwJH4OXNy299jHqRPWzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948307; c=relaxed/simple;
	bh=yw9zdsRjOdY4tPBebfdqBRNZ6E4cs6awh43QcZgTIVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tODuSqqcWNnhgT1RqDPXxJWpThRc+JCYOnIPrqRIBRC5tP6mbnR6JWu3HTMok7pvNji8K0j8MEgeYyq3Hl3nB3bfuXud8LJEL/a+GC6ID45tH4RezMA+wp8JrNXIB39OiLMiEMykVhzmsew1D3loyx6jz5VZ++Z/CYLiEHRrdv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yFSkdqu0; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYMBWCN/fTctIujrlv1J6M7YPgn57NB2R5sw3Wp551ujPr/Wr31mSFx0rwhu+D4bwOfsNjQdMMH9h+Q/zvlKvWtRIUa/HsWkW9lIMegyTkkFx02x9J+czjanHzZ16obNLI3tspz4CRlRfDw9locHVWhrEt1GZP4XLS3QMHP6EvatXrGZy6rzmebiGbbfv5BFumyTTguUB6/G5wUhRAFSzhUaewZLf/n++H4tdKtGvZFuR5jsuzfA0gSNpMptfGhkbrCRPjedMqGURNSJNQojLgZnr9bXXSU8NKwCr4M/vYqfYk1H7/KD8NEHJVRIYIt33Xs2pxuYv4dDZ+NY4m3erQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi+cML+UUaFcteLBcFmy5q3rPcbvNTax3KuG/FaTTUs=;
 b=Ij4oljlRoGxggwsLcAc9iJ7/+s0ZlrAmnVKyFptD3BqHhxdACX0LYIdTTOKflYMUUIKS0Mj4cyLaCvVHu7Jq0drvOMBDoIjrhtNYbMnhPA8KAfDQEfK05FBQmAklDTmXcq0y66Z2oxvc8SlbHsgRkzNkMBifV2XJXB596oNlqhWn9MN8eYMAYuXgeIvI6eL17eU34+X6shLdJCX7dNTXKEkjjpQcYIere1KTxnc3JKZDOQlcdSJ6G+il+92HeYiz11lE6lvKuoVVPr7NiJehn66w35pu9VStT9J93QfKr3pzpS2vzQY9XTVlwwxXDtwZT8e6STTdfHu/ieJiTYElwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi+cML+UUaFcteLBcFmy5q3rPcbvNTax3KuG/FaTTUs=;
 b=yFSkdqu0LTIzl0kjo+jylJUvuFUI/UZA87UAxBrReZYA+bk2IwCd7jF9ij3jDDVINwzXOvpXyg+Xz5FxvlcfYoBNrrS5GRd4zXUzRl48He5HCgb65JmGC4TOc6QriZK+5VaLLmETJ2QPFL+xSCq0FuTeQFpQqbdDTf1vINac6MU=
Received: from BN9P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::31)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 16:45:01 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::4e) by BN9P220CA0026.outlook.office365.com
 (2603:10b6:408:13e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:53 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:52 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 07/27] sfc: use cxl api for regs setup and checking
Date: Mon, 18 Nov 2024 16:44:14 +0000
Message-ID: <20241118164434.7551-8-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: db6165fa-e798-456e-c4c2-08dd07f057e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lR20ZHID1EPSqYUXmEmIX1QeTBNq6YQsHl8xy1jgA6ff1QZm0No6R24R5gVF?=
 =?us-ascii?Q?e0b2EW29cDEKyuKwHIG33fOWQVJ31lyzdNXewxnFbbSQV+ExKh/3NB5LyO+k?=
 =?us-ascii?Q?eAZ3Yl+EV2nMl3liEIAuLZK5XGTy/k4faW3Yd9iheib8r6oUWOVKxsmypJbt?=
 =?us-ascii?Q?fT5svifBOxR7qm3OuhuZjpa288JpXfXEoJRasOQFAToccvgYJncg7puPoOHR?=
 =?us-ascii?Q?mdgWkrI20bpC6uBg9J4moq5XvHqmqrIrXnRYlonvMr+qF+4/LLpsTV7TL4l0?=
 =?us-ascii?Q?HHzopCB/Q6Sv8ZZIPAK4LnKBhJpobYDfi8naQGzrnJf7SMzjDnTDrbAGUzmM?=
 =?us-ascii?Q?UFhD4yeQ0hn1dAszviJc9B36nJfSLEUHYsWhZHkQZqevFQ3V+N6JHATMBi/y?=
 =?us-ascii?Q?H/DgOPQFQ8tCqbgdeSp+9Ix5JLTP2eRGC2NWVJZUmxmeyL56VS665+sQZJ8+?=
 =?us-ascii?Q?nkJQNZRvQxIRR+BPhovw+L0Qv+WX/xC+A3x4+MK470bKaIssVgFE9T55zBM4?=
 =?us-ascii?Q?PuYstQnr7I5tMcM4ehSSIOXEOVeTJJND5ii7B8ma4ABKUfA2KoVvdzyAiYh7?=
 =?us-ascii?Q?VXAX1y/jfljudTrRtg3FzNoQBlmlyhVdF0wPiQs4XxAftsqkFYf1oHX96Hgt?=
 =?us-ascii?Q?VtIFkF0VhSa2Tm9XBDHGNAML1dOusAufBU6WIrM4Qcq/Ln/sAqeFYF4hZVNF?=
 =?us-ascii?Q?F+YY3py61plQISRORM0O8Ivuj/QR7kQ9CHWP88W2FYgark5pluRSJMalMJuw?=
 =?us-ascii?Q?91I4xjwTxeDyOz2MTC26B5vRN8WllGMN1UugfUo8tZHqqDl0kbRN9Ep8v3oR?=
 =?us-ascii?Q?tgiXNCrUkuYdICWxzLf+G1L6UiXpobrbF00I4h/h70lzVNiEpXikkQMXLBtK?=
 =?us-ascii?Q?yOLRgv/Gp/uDDE5S/BW1O2hVdr8+BpoImcq+y3Gb6IsyEa3nIhKQSXNHsXBt?=
 =?us-ascii?Q?3ppGk4EiZ9y8Uid4deD9oSsQCpapOEINNvzVMYO8MyfJcoVaiAtq07jlc1Ww?=
 =?us-ascii?Q?7AviCHKtQZkkNttAzZPn0WZuZbc1g+dVQSaO6Uebe8qo+ksZmgHqyZ6L/Lai?=
 =?us-ascii?Q?qn0rV/+/ltU1E8H/N1fp2xtDuYwHARlEK25JyHh30rscPfEXfVkGDVGZ3ZfX?=
 =?us-ascii?Q?8iyxdX4RIEoxSy2C3SBdzAdXhLdPCptO3hgdmCaoaWEP0rXZjoAJ5JMlkD7f?=
 =?us-ascii?Q?ZtFVh789GIey4NaZC6x02WZsIh7bSYNxN198W9ouK0Ks6BEhG/4fk95c/RNx?=
 =?us-ascii?Q?3svMG0jaNjYOO26/wbO6mTdTpXtG7QAtdmXp9KGphtngWN9o26UUdAy+c3MC?=
 =?us-ascii?Q?Mx6ufDx6yukGX32g09JvNVpDeV/aBq9IW+HWTJf67xq0eJztE2/eF6EEifuT?=
 =?us-ascii?Q?Z0TpN3/zVWYZVy03Z+a+uXBRxERhazmojnqzGvZdRrkWi5YUPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:00.4009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6165fa-e798-456e-c4c2-08dd07f057e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 99f396028639..d6afd1b5499f 100644
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
+	if (!cxl_pci_check_caps(cxl->cxlds, expected, found, false)) {
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


