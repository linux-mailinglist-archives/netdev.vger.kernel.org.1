Return-Path: <netdev+bounces-178321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E382A768D5
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348427A349B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE7220687;
	Mon, 31 Mar 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DgiSsT+w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E72153F7;
	Mon, 31 Mar 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432395; cv=fail; b=e1eTPLzrLhjvBbI7ApiqoRVw5KNw0rZ8yA7Nl13VR2EaJl4qSH8hUmTeDCtjQQkvsbMO6HNNuqw0T7gOp3LGGg37J5H9uoUwrRCd/DwrNfp7rULFDYCUsYzctIrEjyKdX7Ps/9GFviDgHEqY6R6fRME3yeHQiTNLPSry17GZE3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432395; c=relaxed/simple;
	bh=JVso1V6n7UofyyIxlHRu3NMK5P6DKIAWtMhKHDuvsLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EK++Y1ooA7OTpT1hdwCQV6mi80nHy70bBHCJ9tPXdxtrrlsDQMKDqDesUGGt3Rbqmw4EyjqhEuvmYjUIfjc63kI6NHlgsweYROQt+FNG1hTORAEPoWI7OnNSCINNJSbcEguWijD2GRkjDgFwRtQpdkm/zI8o6bHghsCnHBRU0uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DgiSsT+w; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q37hNo9WceGQbHccym1Zsp2kJ2Q5ICstHhnJdUpK8tVethL6MuRJDCDzEd1BCWr5trNBcmDVxZjLniALmaHlyM7T+1lo9kBr/kIGUEo+PlhZYBNr/kr69fmM3p8fHg4fD8qIBPCwJIuiZAK8OGUNeho/JhXG/R/LJTYDy+WudptnChjz2qeo437GGsa+LdQJLjN4/Om/MLvzRoymFSoyjtDLqEywqPeRXTKQGswCKfpVVaGxqSckTcF/Qk6uVGYyNs87YzJUHMu/Z5cTfqoMczHOJMns1zt29tRHolENB5t1u3TuLOqKIaPpn7czfIDGbRzB5VVPeSIzGeG8f/1TxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAkCp9O1oS37axpzpj2aSR7diNheK8mZYdnKNhM+u+c=;
 b=F/DPor3qPFuGuG3JcVCXAhbEOzMT1mSHvVmlswBi/L6rWDrtfJso4Y/o15FyFj2N2/G1UlW8TuTxnH8Y4Wlc7uRhg/QHZdiM+f3EuQE0AQG8hSN1ygeOBHjvyKb7DZqERU43gTJid2aQr16shdMrd8MCmNR64R4YAERYOPHLP6BZ8z3c5jtGVamTec3+DDSRgBbfmjccwGZjPkmKa3vkVRcX+/LRwJrYr6D1O4q2wTwIbJZ7fa7IPJXlSxbeLlBIvx6oKzdHz55qBsJ4yiODAWYOLuMtCWrIR2T4iYobEmxaQzi4OQfXgK/T5JbJC6wmtOmX0knEMkkCpBMCjP99VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAkCp9O1oS37axpzpj2aSR7diNheK8mZYdnKNhM+u+c=;
 b=DgiSsT+wC3XNDbSCljDe5ARXeXKXP1LgcHCft1oTNK/0lFIujIbw4xzZusWaEPL2/b9zXXtouWbGzJYw0Ya0dCtlGXhLcHqhIcZ5w9PaDxaB2mcZWUg2qpGo0ClQqh/GWm7etYitcFc3iblcR+H9YGx/kVRrEb4v2dhAvyGl6Vw=
Received: from SJ0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:a03:331::21)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:28 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::ed) by SJ0PR03CA0076.outlook.office365.com
 (2603:10b6:a03:331::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.46 via Frontend Transport; Mon,
 31 Mar 2025 14:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:21 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:20 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v12 08/23] sfc: initialize dpa
Date: Mon, 31 Mar 2025 15:45:40 +0100
Message-ID: <20250331144555.1947819-9-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ded494d-b0bd-484c-67b7-08dd7062d195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0fZTvFGmPtf7d739deEDQdvWLYgvMosRStOfP8J1Iqz9W99sRvPFmdEH1B2?=
 =?us-ascii?Q?HmP0klSxpsyynj5/Tm5Xhhvg9wi/ySzRKiA5z86lC4f2idt9lDATVQVMRZd/?=
 =?us-ascii?Q?FC2TeQ9+vU+5i6Rw3zKTnMPlQxmiZKbtkC1HUlhbFlOO+lnbnmaICSFkz1si?=
 =?us-ascii?Q?4gjjYlEDBdNTvL9E5n5LSZSJEuyLVfoMnT9IFJ2o4bABiLK1G0VP8uzifGaZ?=
 =?us-ascii?Q?MnOSvkfaJ4fe+u4+UgONkGT1GrKje2YBwLy1qK3G+CmbPwwFmouwIxznKU+y?=
 =?us-ascii?Q?74yXbAaLyVPLAi2vKrtDLyCo95Xp7fWz5bkQT0oTKFx/huTB3fOH1VfhC7JS?=
 =?us-ascii?Q?F2eGLyqj6d5Dn4XxNRvt0/DNykCjwOf6L81NeR5QwTxz7Z6oIuQmRtrKmerQ?=
 =?us-ascii?Q?pSWJkkEe1kgZMjepj3TxlS5VWrw6dknzcWp2LcWhaGQdKAk3voVZL8XaQSUn?=
 =?us-ascii?Q?DNJVJDh5ZzUBHy8ISik+RqRDJoz52jBpSX00/MOEAhsv/Zg0pCvt2KntbFDw?=
 =?us-ascii?Q?LkMg7GvNjfzmw68oFlo1C+R+qelkT75ANyKYHUiXwsyQVXeheAZIorh30AWb?=
 =?us-ascii?Q?oXIZBweFzgzfpKFii+vaMDp/es/+aZzv42O8gmc3E1jNH4qKvRYJedS6AFjf?=
 =?us-ascii?Q?jPj+Sks28zxeKh5UIHYAqZKs5DAv5x9b5soctYFwrBmgQlcn/TCCetZHFk7l?=
 =?us-ascii?Q?/4nAymN71m9B+WXewpBNqOYY9TNhTcN7iKxrn4Z0NKNVHctoaGU3JAk/FIUo?=
 =?us-ascii?Q?NFipKI/d2pUkWU+ElukboD4rusurr3PKGQR8g+3sax2uUkE9TrguVPUpr3u/?=
 =?us-ascii?Q?fziB9JCx1NE4YKW8C207UEVjlnw14TRShVg/Xfij9sKcT2p/dFv4X7eev45F?=
 =?us-ascii?Q?jItlxPOg4NrH9/b5AasKQV9vByZcodNovw1S4CeGnINRPKtWwsQe4HhqcxuQ?=
 =?us-ascii?Q?L+FoqRS4WxGAhuol5Pq5p8weoZ0JOzMj3xm97zQC87OuQ1cm1OnMLfE97Dxp?=
 =?us-ascii?Q?Kqu49tirVLLGgUFmZ2+55XIaOQhmLTFCNae2qc0b/ba1WQDJi1XZljDPd7Q3?=
 =?us-ascii?Q?IU/ODfymJxoV2/K6s0128zS21IJvgaRsQSsPxWkdVU3g7zWPlPJVSq4GSdbY?=
 =?us-ascii?Q?I1BZoFbKoTqhkqxNSQLt45jHLhX28X09lwuGEjNQ9bdUMlNjj5MCQ+MAS4Cz?=
 =?us-ascii?Q?hR3ZG+a/aCitXnJriY3QnVRKd9rbzLaiQglg/kGunJeakaA9mQhH4dKb3cZW?=
 =?us-ascii?Q?JwMyb83e1CjadIfd+phvewVy2EMP0w8KDiLYXrtFVfk/mMDGeFP3SuidkAPC?=
 =?us-ascii?Q?f3D09J+NZM4lqayZu/+4EYfh5LGDsKFg4HaJLcQ73bcKHxVO9k2o+xhznDr8?=
 =?us-ascii?Q?/ORsTIGV4hPl3e04BdIv+rUSYdltUqq9M2HwjwzVn52borVb/kXioUa57uhz?=
 =?us-ascii?Q?b//uUh2SugjcA+7VIUEtw/W1uNxAmt669/FtfnXtr8+MtrWoaC2LK+uiFswl?=
 =?us-ascii?Q?0OKE18dZNgxfkPc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:28.1188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ded494d-b0bd-484c-67b7-08dd7062d195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255

From: Alejandro Lucero <alucerop@amd.com>

Use hardcoded values for defining and initializing dpa as there is no
mbox available.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 3b705f34fe1b..2c942802b63c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -19,6 +19,7 @@
 
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
+	struct cxl_dpa_info sfc_dpa_info = { 0 };
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
@@ -75,6 +76,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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


