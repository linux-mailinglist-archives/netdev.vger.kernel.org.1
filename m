Return-Path: <netdev+bounces-173659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1FA5A582
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078FB3ABC86
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D11DF73E;
	Mon, 10 Mar 2025 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xa90Ran0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A31E1A33;
	Mon, 10 Mar 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640645; cv=fail; b=thsQNfrymEsb/5WeCqkvBrwQRqqDtfTYEbcSKoXj/NslcM4X9Eu+N1818Ztsjv0mKNiGDSGaS9/ak68JJ0ilPc+zU+1/EbZ27GKNxemv33ID7NfeJCCfcXMiwqQ8v62p7CIRNbZQVJpsfH7hu8C0ihDRCiBb4YNaUkzzsnawJOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640645; c=relaxed/simple;
	bh=XNMCR6DQPZ8hxTfrRDXzzanzGDrjfBSTOnDQRnhd4hM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvBaZyt0OM67uzww2kCUJJ2pGKCX8VgpaxtWXtIzQWEf2TIOfknpf4pKUUtkwV7DDpZUy3fllRqdiM9HSbq5OvPfSnJEsj7tWmbTQ23o/VDYVgmVXqoLrC6M6ongNOfWLt1LF2rmjPiX5HnTSBH9FSqS7BH8v0BuT3+/RcOFEkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xa90Ran0; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma0XsNKbcIzfjepi5aevA4+LtDxOf9bIFJQeqmePTHewkAI8pv/9b4Mumr+sSK0ZOTS+MXPI9ATGRgVH9NuHNUHj1OQ5Nq5q1qdXxW8zQ1/qCK3fFmXnWm2p4DB/9EzmjTvsIWEe9UWypYCcvNYI8m6L2/4ohcXrsq53gfWhyH73G9p+sxvdG/zijbdp7oCG/GJ0WOzvRsvZstBB8CofjrB6dBGnmJj+Na4fcunub1irjV+t4KidVwce1llVhUdnpbPYRABq3dBeOHeadz8wqp9Z1di5fXmhqLpUlM80l2uZIFgOBRJz/dCl1gkk6g7LRrcujwD8F1riep1Uc548xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsApbEVtJBDNSvf+pD+J1xfV+ZbcZEDYMJDMzEXLRaM=;
 b=e42J9DN0X8peg7jMIHD+Lv6lJ7OixXOB/KP1g/9sP/9+lIDjMcDzLx70CJZ+Jcmkl5M2CKDO9LEX94Ogz2Mliy9kGq5JucgcBm1ok2zux1kRRLUdb5TzrJZ1HBFM78CaKcSIW4dvt034VMlk1zcwNEBIA/pWDY+pdxrzPhWeHPYfoPWizZoJMEC8wENGCi7khMYOqxF1kyHVv/Z9bgK+s3KEp+jQL/3tILub4CuDEhzqmxpRS3828qrxIPf7+Iss7ILP1xbiS2JqbO6Uh5PJDqC/NR1i1fNacPhN7zR0QroGdxvkbPYhUYUsgG024PbNnNFAx1U1uQqU9KGrCLFETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsApbEVtJBDNSvf+pD+J1xfV+ZbcZEDYMJDMzEXLRaM=;
 b=xa90Ran0c21imjEOaBfUiYz6pftmmutYU1ONqny3ihqNa/y+IKuIhx9zYU0nDqRHvnI6ZJzR0EYgvldgzWIaev2jKGKfatqmlFZ6693F7vwpql2uQYJvftMXy6P0yL1ndNrtb54SstT6r6IfLwYXuTp56PE7fRxfDNixCJ/gZRc=
Received: from BYAPR07CA0061.namprd07.prod.outlook.com (2603:10b6:a03:60::38)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:03:59 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::f7) by BYAPR07CA0061.outlook.office365.com
 (2603:10b6:a03:60::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:03:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:03:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:03:58 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:03:57 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 06/23] sfc: make regs setup with checking and set media ready
Date: Mon, 10 Mar 2025 21:03:23 +0000
Message-ID: <20250310210340.3234884-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 1762a1af-248b-4dc1-c1ec-08dd60171459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q2wnv+pJsc7o/gzyaCWVq42Hvfm01epVBAlsovn+pU7BFS8Lq6JTrTNCvpcT?=
 =?us-ascii?Q?EX/T2+hS9xI4odG2s85ztdugFW08SqIxAZYVxjwAxGR/svi6NOZjAXE+QrqQ?=
 =?us-ascii?Q?UH+vHg0F4h/gwI5wBlnWYysrPHd624iD/3BXXuzGXb31PyLXBGB2THDssmj8?=
 =?us-ascii?Q?sk07LtQhUjgc0mCpJQfKi8hdz1fUhMbUha3hftae/IzHfNgPlhSbCB2Hdx1v?=
 =?us-ascii?Q?HR7SIlwdPLFij/+fNhngXWsfv5iaY5Bk3WVtqbf8qZjpZsLQwhMTTzHgmW4L?=
 =?us-ascii?Q?D+4E8ALc6Gux4ICO/u2B2wHz50HWoRRStgkJZsC5gIrkl4ShMRq4sx/CjdBQ?=
 =?us-ascii?Q?e3Wshg2FR9tLbDQIZTlAcWZzbJiXWbKp9nZrxcodXyILlteXdxY3/o/nLDvd?=
 =?us-ascii?Q?nn8Qwn6ckGbfR9J5Ino03t9hLzM8bUR3Z7tzD/eAP5qRPTuEGvae92pSMuT2?=
 =?us-ascii?Q?XvqTAzL5Po9tm0tjJXxURcjLykv2zuEmAtFK5bgis9yKvGtR922KNUEuuFlt?=
 =?us-ascii?Q?P/amegzzuCKFxLY/aoUcKE9YbRHUvE2IG1kzfPGWH9HAtwLo7O+aKg18V8io?=
 =?us-ascii?Q?32xmiZccUxjWe2tNqQSfeYerrKsU1QPsv9Hoxo94k2rBsK/Y4BLY3BuThTXr?=
 =?us-ascii?Q?TAu8FRy2j/qrhG/Rs3xzAK4QCE0g7DtbFCf9JZFRlbzQBmDaUalUnNOdi1N4?=
 =?us-ascii?Q?Bi49ox6UHQ+Ca9MAfoIbya1vFSfP0cQMkOUlDDSVxLjykCe1UsekEvLCmPNb?=
 =?us-ascii?Q?4Ki8K5FC26FbSoGqzKomLxdhYeUJRiDSn7DMqnm9gjRpxyIG5zwitTS7qBfM?=
 =?us-ascii?Q?Od+MYupPZw1NTv1x/p6fzo+vdKznJZhclmM75FF5a4nw0Q95L9jdg20qgfM9?=
 =?us-ascii?Q?0aCLEhTmmn7W7/P6QTn/nQeCasDE5l/rdUOTSo864jTfmQkZG2VET0ti5aMu?=
 =?us-ascii?Q?yqmX0Optm20/fUCYMoZzqYmEwDUsrdGpHfEaLQQUNjN3Wkck0fqGJ0/symaL?=
 =?us-ascii?Q?jPMmb8Zg0EkytXNWs/go4TKHq9AND4Uxab0mfZAjS4IR+2vRaiHV9d2nO93w?=
 =?us-ascii?Q?LxVh6oRd6QCFqJOTkwQ4iQvDlIpCiA2dmYYDjanRhHxtxO1xOWdtCtsYKaS7?=
 =?us-ascii?Q?m40xLo4QVa5JPOzjTaAd0QNdg3Bz91A1SAL1tUWfYODZNJamH+borbwWwXCR?=
 =?us-ascii?Q?xZchq8ZyRa2rIdiHjTTkuWMIiwt4SAck021+rYy97jfqaES77+ALAxuIn1cx?=
 =?us-ascii?Q?hRbUiUHEEw6U8VGNiSpJDhsWymyTrVhEjaONfoMEYTeuSfnKMP8OBNB7vMcR?=
 =?us-ascii?Q?8wlwQzZhgPipvZGJUV9GbXTQnM6E0exeILGLzpQdNNJDHqYIDW6inKwlugRX?=
 =?us-ascii?Q?BBsXH9N3vErd63lYZkwOR+HttnWZGv6wcqWBh8mTfaKwZVZtnETzYFBfX6f+?=
 =?us-ascii?Q?gFRzrn/lQcnHW7T16nQZX/ibGYFYxja9yh9a9QFQYUMToOm+3dHgOq3tPUX3?=
 =?us-ascii?Q?dQJ1f9mq2o5FRdE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:03:59.6700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1762a1af-248b-4dc1-c1ec-08dd60171459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Set media ready explicitly as there is no means for doing so without
a mailbox and without the related cxl register, not mandatory for type2.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 753d5b7d49b6..3b705f34fe1b 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -21,8 +21,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -43,6 +46,35 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_RAS, expected);
+
+	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		return rc;
+	}
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (!bitmap_subset(expected, found, CXL_MAX_CAPS)) {
+		pci_err(pci_dev,
+			"CXL device capabilities found(%*pbl) not as expected(%*pbl)",
+			CXL_MAX_CAPS, found, CXL_MAX_CAPS, expected);
+		return -EIO;
+	}
+
+	/*
+	 * Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both no mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


