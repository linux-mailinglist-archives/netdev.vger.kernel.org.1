Return-Path: <netdev+bounces-163050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A4AA294D2
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA05C1892E09
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A7194C61;
	Wed,  5 Feb 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CizMV50l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0C192B95;
	Wed,  5 Feb 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768823; cv=fail; b=Tm2wYvhRXaoQr/DEWrkazwmWR+d6EOjT2i1TpdkgGb8MoO9AdPvJpyL/Wh0rn6nK2ZxiNOpHLI4vou/NJkJOSLTsEgOZ3OfFdeH4S+zgjC3w3hkHE8WVGlxBQRtGYsWt6FwOhwpadHRpzUs31Dfv3FfZ55+xSOsbtPHq18rE7Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768823; c=relaxed/simple;
	bh=tQ/IW1ck+Y04TZQyS/01gZPpverWvPU9oFG2pLVS/nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlrJYg7bhG8RVV6m22h9iVFW7uIYuE/l8NrglAOtVO4dN3Eehj3UKcZJazspLSXtcm+NXEfc6SP8w6tgTdlZfTR2WJ6fI5pr3I0UQ7SpG6yaqWURTTlC3ZM6l6vgoSl3jlcoxc43iPPkndefUYXqpeKi4EmN7V1FsvVmPap403Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CizMV50l; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gClhV9j7LgTZ2vNUUuLC9cV0FwUdNfUl62tYrf+i9mK2t9a8xBvxGM2HFFRh/hBIfETRQSLBWjaNLUHAw7Q/2LilO4mrPtWluuoDjEtP7pO6qkGHfdY9moAmg/i/5VMVAZlp/BroWCfhtXvpWq2pYlVxRwQLWI+PyTtBLTjVoj5GuNI0capioDdjcEQpyRBGe+xCgVrIe9L7PWrkPZjohwOPCO+yp2tpAsdLXKCarhCI4VQ1nvmyKPS2Ux/XaleEOpxbkz4sNj2dn7Ujp1Nk+EoZe4Gt3iA23vAvtXnoOw0XVfsB6YkQrb1uWVKRNwZLXpUiueJm0kNG5MUz3I+UHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfSMd6FMP65C6dEwrhPVmBpVunAnR8pcKnH+gNyb00U=;
 b=lsvD+n4JNtU1LYik4HXuCllQWQmMIWpMHuFYyV0Vs22uePoO4r19mD8fK6O7QH3Up9+xtpkp6zhHdN/7oQ39GOpTRfmzNndfRluUZXZJPSBdIrVlWARbKoLuGMCQw6/mqktPW7x/cJh18eBOu6UuonRL2FAhak9KyYlbwTwUqQ0Qa880e0qcava7CQ0ctQXdMa1vzUiaTE9oOSxKv/Ow8VeimpCcumfhPXIfk2HLuDugZYiZ7W0C+gb/loEAVvya/e2bFV1JogSjxZDjIagwxL9ulBloGZcP4NaV4q76SRqGpNasmKQHLVMmnCmRYYNznWwxpILpymWq7fMv5RKn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfSMd6FMP65C6dEwrhPVmBpVunAnR8pcKnH+gNyb00U=;
 b=CizMV50lQDKvWIaNN8NXw4Qv7JjDxECZBpaxcoptKz+1HtrPT2QSVVPRjlxNsdRFQNO0MQ/ofglaT3VAH5mOjpnZNgqOEZfsTVPDp5DX4B1/YeXvM0QtaXPxhlvFI/JmSi+afwxu2lBtVMd52qYf1SiSNIuOyBDQ9JG36TeiP0k=
Received: from SJ0PR13CA0042.namprd13.prod.outlook.com (2603:10b6:a03:2c2::17)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 15:20:18 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::c5) by SJ0PR13CA0042.outlook.office365.com
 (2603:10b6:a03:2c2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.8 via Frontend Transport; Wed, 5
 Feb 2025 15:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:16 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:15 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 13/26] sfc: create type2 cxl memdev
Date: Wed, 5 Feb 2025 15:19:37 +0000
Message-ID: <20250205151950.25268-14-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: b5eb6cfe-90f3-4be5-597c-08dd45f89960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zP4ZjBvQzq75gb8D11UXKjHSUq+jvR7rkVd/VG+sZviNHO57BqUer/pXpPPV?=
 =?us-ascii?Q?NdmseUQbpPzyZzquzY4Gom78p6WIwN8hCklGuMaFMhzA7j9QxeZpyrzumirg?=
 =?us-ascii?Q?vA3QjFCeStzgNFY3wtoNggUMg3CHBvSV57zPnX3q+bE8SlQsIw7V6XQI9qKJ?=
 =?us-ascii?Q?hvrfPpTkHEECC+viA3PnYN8NMbVI7OcWRTYzFrj2/tYBi8T/5m2wAWG8UBqq?=
 =?us-ascii?Q?BPKfhVbywHZHU64ff+hzBwORq5yEaodbiei7OWSB5+A1Xg21A0SXd+Itu8F0?=
 =?us-ascii?Q?q9aTpohEs1cKRdy5d1odJxyunvoD4tH8+77a4VnQFQaX82L0POpxXo7nXm3Z?=
 =?us-ascii?Q?Vhy6SifktMl2X1LSqj7j9mwZcrexHWjPeKu2MQK19c2IubT5LfNFzKNsGvV9?=
 =?us-ascii?Q?xOGbwClHs+JC9tjimuVJlX17MMMHKuif9xE/wbIcl2Aca7s9yTkPuyTFecuv?=
 =?us-ascii?Q?uYC548Jc4Qh1jFAV3H1RI6qb4kyRHEd5rwHbcmgSuW5NG8jcbxVPe3BAVRTE?=
 =?us-ascii?Q?3JBOC4CkxKqazJ6H8fPQ1TSc1zJxf9FdqJtAE9Bvh5mXRvilLIEhXDmX8E1L?=
 =?us-ascii?Q?SA8QxJd/28uIGuXA9xuDkj0LN43mZCncZJGQpeNqYTLm52Uok6sAEZcYZjYU?=
 =?us-ascii?Q?Yj0JK6uVMca26btUnqRgJp5ynkf7C51+XF9YG1j2QfK9dHmDQNTwe30kHIVy?=
 =?us-ascii?Q?FFwd2YXGaxsnXa2U1saIfU79gP3CxweU/kNKqiCoB0ZTLwKsdr5VoATE0JV+?=
 =?us-ascii?Q?aALTNPcmiJIbQ7HAQURNHtxgfcwCx2hV+jRzkSqMRnSCMiaEJNTz9og5c27K?=
 =?us-ascii?Q?cn3dudp1m5cQqDDqjgAb/3edD/ptWXfwvnclTDAw6eoq/ATLll9UpUFgOcCs?=
 =?us-ascii?Q?HtdqwhZXBJD7Gn3CQ0Bjt6hp5CILFZQDSf7SbkoTZmqsFn2+n3EM2kDSajiZ?=
 =?us-ascii?Q?8pf7C95fvqxYnOqo3odI+vlEiiOj/EGGWlIQdu3AMBXVgW/zf7vzCjPzWxdG?=
 =?us-ascii?Q?8Nb8grJ5D+YjuQiQr8keKiUwAJAANwYyWr0GdcJW8424oRCu4MfayFBhP0Xd?=
 =?us-ascii?Q?eWVEaAVexnt10/FCrDlPDUcbtdv5VzIGH33Yso7ot3ZJ3KsCDsr+y7n4V3II?=
 =?us-ascii?Q?4e04M0fflUbuVJiM+hgaV9Mlo7RcSdQaB4VUEKMyWSxze5MVCXao9ilPwvEH?=
 =?us-ascii?Q?CoiPRUKhV1gQv2MjoFszie2/ssy361LcpybyFgCVp2PpjUV4t5tuf3bCcwN8?=
 =?us-ascii?Q?WDP9wOtfo44nhX9W4iAfy3oon4lTp1YojJILNG3C9Yq3VhjLCqkuKNBMWHyS?=
 =?us-ascii?Q?+CzaeYO9h+qL+6MN7K6SdU5lKhYd3LzLISg0az1TUHkBlx3vLJAFIml0Q1HW?=
 =?us-ascii?Q?PEQotA7ckMM90wl9FrLDl/wEa1z+5MS8j1mWr/MvWQSmDXOXRnjF3igfuqIv?=
 =?us-ascii?Q?GLAfGgwwqWssimy+/q95TLj8gdRx/agPHup8+Cavxn/mLuaKpB3eEa5YHlwu?=
 =?us-ascii?Q?tyaotJLautH1yDA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:18.2975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5eb6cfe-90f3-4be5-597c-08dd45f89960
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d7279f9ca8fc..774e1cb4b1cb 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -94,6 +94,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (rc)
 		goto err_regs;
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlmds);
+
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		rc = PTR_ERR(cxl->cxlmd);
+		goto err_regs;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


