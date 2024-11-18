Return-Path: <netdev+bounces-145955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D289D15A9
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58439284AC2
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00181C4A08;
	Mon, 18 Nov 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MhTMp6nY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BBC156236;
	Mon, 18 Nov 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948319; cv=fail; b=Nqjr7jegNmPaOhQbvclY3lK8TZwK0kRzKX4UQqN5eBA2lmZGhZjNAk5AjUZAKwCTB8mWOYw0MxOdQrlR/DkmjanQvszVUhjEAl/HiBe/A1ZTzMz8aSuos0XqbxiMfRFiVsQ7LfnGeLGXi2h0xrtcZDFC5vxSv6QphyXQJb747EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948319; c=relaxed/simple;
	bh=fBjYEd1zW/ncp6HVXtbN/73UOggVaflGpOi9EJV/RJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6hL9rKZ4DVxkj3E9ZSYPynZK5hKAhKYc/mgXnrrEURdg+XsF09N5kE154yMYOslSHI1+aImyCmKbH4JyiKosK32TC/YmrGuP7s9sNFjN8KXMTfbIejoRNy27jzKiB5FdVpH4NThYXBAoEvMW6Nn6cIzqzE4aFH2LSspeXnmRck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MhTMp6nY; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myABw3R3gku6X9cyH0Iv3YE6JwEKN2xoBr7NJZYmBHsb1Vro8HG0dhn+wMaI9w5RTMfWXkfFc7nczQDG1PQwXzjbOauOFo9iWd7pbfBGOIj4SDGWJUGvdgxZ7B2GZuPpAev4lP64nFa7S852BKeIJpvCbU878TTBoxnYoCjUu5WmTbMmIN+VRHJiLYy5gsweeAFNVwxeinrnCPH6mHwKaXpgpVFFeko+nzRBzOpM5SUpzYszvmvRgLRX73ubbp8Pz/O+0LXuMhI7td/EMEE1p0megSA8zZGhS0Kt/Ri+95VQwxFFJYsIVMtXlzEAmwS10q/m3kTHtp80oM5Z1dWyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBaGvrLd6LfODsgpTEnM1xVqVHYZeP9cWgbCw5WC4I0=;
 b=YWiI0grRwcstKK+sYLhxWvAmf1fXGYCsdifozMngAEbGN9xafC86KqFT+OOohICTDZwG8D/hgbyceUgdLua8FWz2OmJTclq3opHHqD6AAVZEi8aG9qQ+pG3ABZBHWwqyP265OVOMjOuB1MYfYXaCFCvWqs/cH9aWA4Q1X+KuqwPf/+nOxE7pUkxMA514BhDksowQC8dPpxBwihZtHU0PxdwW1Te95zxs6iS/47ybpmRhC5EqwJx0yz6QtZpi7Mfp2u31iMvwy4yUVqxjNPUcG/fxI6ypililoskO+AP1vtmSsE2w5LnrplAvgb0BLa2a3ZxkwHLTf14G/LpYywg87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBaGvrLd6LfODsgpTEnM1xVqVHYZeP9cWgbCw5WC4I0=;
 b=MhTMp6nYPOCCeAPE3C7jTSnuVwXFVSDpBi9NvppEg25nqPt/8Nn9krytGGQV4Jlpa9IfJRIhi8yHoB9NocUcmDbx+mCeAQ8flJzKycWjnrDJ339bHgN2PFK0a5V9Fh5dRONKht4cNqaSino5Eew4s4mR5OCB96vZ4DlJSXdlXko=
Received: from BL0PR02CA0136.namprd02.prod.outlook.com (2603:10b6:208:35::41)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:45:10 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::e2) by BL0PR02CA0136.outlook.office365.com
 (2603:10b6:208:35::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:09 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:08 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 18/27] sfc: get endpoint decoder
Date: Mon, 18 Nov 2024 16:44:25 +0000
Message-ID: <20241118164434.7551-19-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af5d912-1c9c-4925-d87a-08dd07f05ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5DEnwFmStW84ZhqTDiMNjQYywMRwxa/cXWuWSrwl7OIYBcclZ3STBWqJYpA?=
 =?us-ascii?Q?hr7qDL4eCA2CBPL2sG8VTZWc+mAEG4q9k2DbUczsfJZf0BdaVPMjwDUa1N/2?=
 =?us-ascii?Q?Cw7xxu/gcUbsvJkncA03oKIp+qI7DreJuCR5olHnvPAoxhrnmBJqYkKGIq2s?=
 =?us-ascii?Q?bc5gKDjQJzY72QQ5I9253MwzhfmAVqwsZPF4nsO17lwCqTzWF09wLY9CuHVJ?=
 =?us-ascii?Q?Ew3vzmaXbO+Wm5Mzpn4vt/uocQoPoHiqcinFsIdxT7MdNS0zOGaB7/Kjjbbq?=
 =?us-ascii?Q?Z59EQVmyXUZ+76rjAY/+AgmyG3ZKasWL3LvVvRdoDBWQD7Y1Bcc+7XkBD/zh?=
 =?us-ascii?Q?TPx3d6M4XpyUmHi7zrR0r5IAQCVbhj38qhW4f60+vDCbb48U8jrsmGuDgZFS?=
 =?us-ascii?Q?j9HOO2k29MYTbtMFXzdJduBzfY5oqVbTuN+rygt97cqJCxnf6+UfP3MuQ8Jw?=
 =?us-ascii?Q?SW46/F640mjGKH7/3PCfwaq2EMoTi0UVOQqatRX3JkJvSo8XI2d70aGDnZRo?=
 =?us-ascii?Q?mjsMugEp0BCc5yAjIn5gtaAecg5tCoia9/9IDnUuljem9a8Lc68RfN/nXEhF?=
 =?us-ascii?Q?BcKrrAX374tdRsIH00qHcAm4G2AY9UXNDHvbRdkKfasiDfIQOtasSLhcbvGn?=
 =?us-ascii?Q?gux75iMDWUDk91xhYuOvRNyDKdn344oUoR6LxK7xJ/YJivTKFKcdqRaBmIyZ?=
 =?us-ascii?Q?F9nrgkHqOGtJ8EZWeIBAg3WIY/rSknCJC7sknXfV5wBh7V6Gj5qsYyVi4WMv?=
 =?us-ascii?Q?f3/lpJOe2GIUnyLgyVooU9Dr6U1Qnyus1lX98mzvyRtMpebTv2awDMlglvE2?=
 =?us-ascii?Q?lPgAW/b6vDW3RWXX1bD6HQqK3JtlhV/DEzBY63+p1CH9KDloUXsBduii+vqt?=
 =?us-ascii?Q?afoiYG1vza88zjhM53g2qgWuooowXGLH4dlNKN+8MV4phYDH6KzSwDOvYyzb?=
 =?us-ascii?Q?ye3mG2XcqFCAG2/eN2cr+PDUMQvjhCSpIZKj9Jr4GUDuN6ObybnHpbhxOqPb?=
 =?us-ascii?Q?Tv/jMc6usk5LLUNw3vRtVN+DGtcJz79dnmZpbrxBI+HE+pSebcsxhiDrtU49?=
 =?us-ascii?Q?fpnpVsKx2SdAJdPA/j+539ByptXl1VLYsQNtGYH5N3yLS2Gx11GlqPlaQ60k?=
 =?us-ascii?Q?5KKjaP1l9yyyhQhQBKZseBzb9ZrLB/LdJ4o16ycrOh2Ng94S4Lyzg8s/Ml4d?=
 =?us-ascii?Q?C/5snBYkZH+JJm+rQY522ceOtfHErO9Mr10IHCdz9Gr2Vp5aNMIS9OQhsGYA?=
 =?us-ascii?Q?VjUutOfQArk69Novj5RWwfZbtLZFmbWOAlTjVFtv51h+MpaTcPsf6kxfkHmK?=
 =?us-ascii?Q?hkb7EJKLj98/DQY8MjmIQ5opPYa4+SLiKJ3D0IttAVedmsbrU8Y6vsLivEbR?=
 =?us-ascii?Q?q5BQWl5GRYHk2TrSlJF9T4Y0ra1QXWfjwO7ul4cDaDVZF2vs6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:10.4193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af5d912-1c9c-4925-d87a-08dd07f05ddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 048500492371..85d9632f497a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -120,6 +120,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (!cxl->cxled || IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err3;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -137,6 +145,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
-- 
2.17.1


