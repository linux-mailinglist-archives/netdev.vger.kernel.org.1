Return-Path: <netdev+bounces-183922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73056A92CA6
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681E0446C7B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F686217F36;
	Thu, 17 Apr 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e4hboSZH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877132153CB;
	Thu, 17 Apr 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925393; cv=fail; b=SZLXB3Nf97ADF9LtAnoUWdcWPxO53qiL2LtSysh70dzgCyzOAttRlimefF1CAcqH8/csGeXGwmRLbTdQacJIvGl3+s5tJE1MF42lKSiN2fIkcWNbvdfCOV8Ml8eWSBUCi9skXsg6qvaya+t0ONBsblH986Hh00niGbIB30/wANQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925393; c=relaxed/simple;
	bh=egIgHHMZRyONTZdQGE9iDAaTVbbusGr5XYQWihwvr7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnaCLI1iHmzmqCcdYFGQWU9EFjwUVz+nH0kzawHwnq7wtZZhm0mKk4bnqYWlfAYM74fmNP6s8LyV/637Io3pej6YdS2hkN7dDgciGRv62Sbk7YoE2zl/P+vN9EOhUhwfcK9Wuar8pPcagkkRguASaiGB3T9kzWorq5whD2rUsmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e4hboSZH; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBQm2519OvivOKa5whJBzwb6pvoy923OpQOj9nR0jhc90pdT8YPinObZ4GhuMNrYEqWjOUEypGlovBJ/rMs2C/frKadL/mkcTwH6J/Tz3J7YVrdYWcZrDGzy/wL5t7aqRHXsETqEEfCOimrn9C0sAjVvlNdbKiPmzkI8rmVNem4jkSthgkuIJtVot1JsaZMwWrTspum2nLl+cbdkxpFKO4ORHz6GD+6F5ohQ3oKUyiDZkCetlKhl/j7qNZE16E9+x2KdFBp1uL4z2oyt4VApdIaiz2jKq60UUGxh1d90wX1vzFDq+0i6lm0LQoPZTTQmch+GAdjBlYVv9w2+JWjsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxQ4pMGM9NbQ+++ODJc9KITIhHESpkUsY7+cD9ww1gA=;
 b=bxV9dAGtVNKf3fInuSd8bf4hcpPk08m5dBzTQgDkLIowGFCiV4z5iUlDxKkFu+2mxL7bQIrxXCV4kY8NTyC6dZb9ujXswovv3duM4GkxrjQvS9CBW3jMwb+lBOnhl2FmFe/XTc1eWDjNnLEQyHHdP6a2YhuVc27es2yTwvwfgJhvMbVq9DZdIW1BXyE94zeLAkZAqTROerMFwZ4/ZqsjAguTUmKsUYjQD0GBv+OTk19GJIUNhw4JfQ0D7TbiXwd0alaXkhrbdB22djuvwPPE4CkHqb4W9+93GZoH75sWJEQ+jQM8K3jncVz6wM6MosLwsK7pIWRs78prW3USu6a56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxQ4pMGM9NbQ+++ODJc9KITIhHESpkUsY7+cD9ww1gA=;
 b=e4hboSZHU9zG3JwWE8gzWApwijYkfMDaJ1HBnDgUGfK/pVBiHoURjB2wULTkI1GKFdMggWV+MfONwIq+rBExT8+k2krIWpfLwgzbkQODTCRkpDglPCbJVij6eDoJTRQDzCMLggE4EnJmiCETi9SSVpHDn4op0Jum+j4SnZfLPu0=
Received: from MN2PR10CA0025.namprd10.prod.outlook.com (2603:10b6:208:120::38)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 21:29:47 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::fd) by MN2PR10CA0025.outlook.office365.com
 (2603:10b6:208:120::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 21:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:47 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:45 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 08/22] sfc: initialize dpa
Date: Thu, 17 Apr 2025 22:29:11 +0100
Message-ID: <20250417212926.1343268-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8bc770-ec83-429a-6eff-08dd7df6faa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R6odQN1D7bo7LjAjPDI8obbNGGbGAO5bJTa5ZNhpiM9z+bkl3tgH+0DHg6Jn?=
 =?us-ascii?Q?AiLu2JGgMIjSiS2flD2JLZIZ5kugQnE/5ZkKPQ+ms3RCjqugb9GCutJ8IqFi?=
 =?us-ascii?Q?woYNaf6G8ztsR/loDtttP44e9SIwOO4Ea0CbZ4CRv1wD0lirGmvND59gxlqD?=
 =?us-ascii?Q?RL0ONQk9OaHeOGgdLXRZu5mCZic2M8oOfiKWC3mLZYZgOlA7RfbYO49gY6nA?=
 =?us-ascii?Q?Kfdx+SjJ4H5fMFGpK/Zqz6qyUFOLPQPnBFMnZBNajcxj/WzgTuIubYv87WP+?=
 =?us-ascii?Q?6IspHXqT4jPeT6v4e0hacQbIfseNwqnXMScFmjIzbwyC0cioeU6rhTtOI6iC?=
 =?us-ascii?Q?asECbUnkskg9P76Rbh77EAfMZ2oJ/NZzHWvmdewuTovDYweOWGxErZoMwSHf?=
 =?us-ascii?Q?mziQYo0Hn+14qsIHPdLs6SeZb5Bxm7pTKzDDhN6a+92LyI4s52emRpc6eiS+?=
 =?us-ascii?Q?iJ/uDtsJyuGxqugC6aW2FD/qZa36Z7h8Zoerzf/h5aKGGOIAaaV8ofeFX39L?=
 =?us-ascii?Q?Cdm2BR3I4qbuRS9hbNF77pPQdckSfhc2z4zjIW4NJjx4UFmuYJxTS75kmrmS?=
 =?us-ascii?Q?5sLxtLHgcmvjWaeyPNvUW5byN787cwLpOAxUA+xNIyOB6fqV3wDUcN7of+3O?=
 =?us-ascii?Q?uLgvTKGbV9pM1600gCNyFoj5l/pZkmMAgbyijm+Ql+TxmbdJ7K6Dy3azayMV?=
 =?us-ascii?Q?eM0DfyNMhaO0bJR8ie6kjQnlWxfsFbmSbsMZ7SiH26R9YGUG5T0Z8LwO+02Y?=
 =?us-ascii?Q?0k5XlCcw8l7oV911BnWmpebM4/gMfApReVs7Y1BKFuSQLjDxCIrAh3dtJM9y?=
 =?us-ascii?Q?1VfaFdUL3gyAL4foUgdnfXwNWCzZHXluw4OhfTafHNSltcMOc8npDyTFMjBF?=
 =?us-ascii?Q?QhexnXd+/vi370dX9LAOBysq5+3cRaTbp0Z6DOO0JHc0+fDqetlpo/EBVzAm?=
 =?us-ascii?Q?l7PQTVH9n2sZr+g8S1tCRRIu73L1V1zJY3lrcOog7AIOwqG4zvtaJNpcdlji?=
 =?us-ascii?Q?MWBpPdi8kAO7tAhAB8xfSXiK7FbEFsFgiwplMbyrHBTGVLOv/3RC03lxiVCh?=
 =?us-ascii?Q?REwjmq03nkc1fbiNhqNjMMq6RJSOLEfCJCJzk1b41DBKcLBSSBCeM7gatc47?=
 =?us-ascii?Q?N3z5oxagP4PMuol+0cc23Cu77pYVZyzbktTCACeU+p0zaImwYslnL0Mn1FVT?=
 =?us-ascii?Q?xrMXX6CcR+u6umE5SerXSVwJyehv9TAviVxbx8xzuDG5X5UJXf2DaI8brXid?=
 =?us-ascii?Q?t21eIIGDnVA3YspKc0g/8NoYzzvzKhWFJVma21UYEctmgg++rX1hvfaoNh9e?=
 =?us-ascii?Q?6oqZHoatwiv0/VCkfHT7sJOdbeT08C18lydiTxChFYo/u7BWr60poo6+4bDJ?=
 =?us-ascii?Q?bzRmnH+7SZfc75lerpP414W/bmTtiL/asPs7sEKEALDYhVu3BtT5jrxCpsfA?=
 =?us-ascii?Q?Fdj63bT5my0VuaVm8U5fYST5ATNsMiuFFuBggWfJwyPSHMY1aR+nNXcEnK6j?=
 =?us-ascii?Q?Rdp9ykXvtqZrMj9DNu8N+VKGBHq31UaVPPqb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:47.6744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8bc770-ec83-429a-6eff-08dd7df6faa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354

From: Alejandro Lucero <alucerop@amd.com>

Use hardcoded values for defining and initializing dpa as there is no
mbox available.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 79427a85a1b7..e8bfaf7641e4 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -23,6 +23,9 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	struct cxl_dpa_info sfc_dpa_info = {
+		.size = EFX_CTPIO_BUFFER_SIZE
+	};
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -70,6 +73,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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


