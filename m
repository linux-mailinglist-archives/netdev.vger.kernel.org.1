Return-Path: <netdev+bounces-186466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C75A9F40E
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D815D1A835CB
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51CC27A11E;
	Mon, 28 Apr 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gXh7tx0K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD127A113;
	Mon, 28 Apr 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852622; cv=fail; b=Rm48kGrtxWlsDddN6BK7+p8p6m1Oy1uaHK5l3uIMePtn7fDp/1jgBx7k4GXKxCfUEXQT2q+BVbZgSV86Aq0YD5KeApsgJP520TjK6k4epEeA+2HIZNBkgjRDwLe/3RfuBsKfPP1C9mMATRhflw64ioO+DQGmr8Id2j+ZoFWdn8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852622; c=relaxed/simple;
	bh=sFTIvvD7hPaiQOzNXnvIltvyXFOXqYuYmYuUTZsDXnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DksKCCbm11cfPE4cyoix+DFlKDWh5L2aB0ADPi+Xbs6CdvZ+wyQSKmP8PZ6cFRf8138x5+rNzUD7LwQA27SLdjDu7K/sXluFYyi916k246oYaVArhPqIuIZZzy4XZ1j0pkTzwplYEt6kIvWme/azmiiJpE7Q3Jc6d9wnwbHpuy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gXh7tx0K; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOGe2nkNUTsQr/nzmaBbUUSuMuRnW6Ai18M0SgEPfdiNTuVFSibk7XNf7SI12brwuLgTTWRv5HMCY42fBzTlLpei5mBxwIUQNVGIoZ3pDI4LWvkGMRvNI5M4+wBpNhaytqN1LhB1Kln2PPk7lxVdFMwt/jvdLm7gyfeI0cnF8DhPJZM3QSL6P/AX4a27SMiYtb3/e0DB2B/4WizP+ihz8DpnFoyoZ6gEyeWaZ3yv8Kh7v2jm1zJOvjVhrpy0/Ql4tp73YIOLl0GjF54xycyZa10mjrQXjo5q1VeDADCdlzW1ABnRNBxPTFi7NERavOIL6y1srpBco8dMqVDNPGI5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+ueYxcZmVBqlw0maIp0d6uESCx80aT3eg59/aDI9Jk=;
 b=uRtUEvzbZiyqpRpxXv+Ep8RZ/LX73EorN9Mxc5ZuuIByfzO4G/0kq7LfbXfS0/6ZrBYS7tyYDtcQaWjT7oQZvjEvfHuPfBHatkq2Fz8HLJ0EfuhtuRCFS49JvHTUIU5rSqSkFdqOL1N9BOxwAu6HwhQcuo/cfVdCIJBTQ8BnFzqIDTVFLP0DO4gwZq+NPLCKhh5y4ydOCi2yV5KNVZFBgjyyQ4KWHpEogl/w8wzeIHAS73wjWAa1AudUSrHKdNas4sB3cDXBROtJK+ZfFygGuXepW8mTbJahRTWZls4HLvplRqfl4lkkGU3s9CqBtnTHzZiTk2Ke/Yl4sWAFvRXWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+ueYxcZmVBqlw0maIp0d6uESCx80aT3eg59/aDI9Jk=;
 b=gXh7tx0KdFm2AjPy3z++mMSPAf4wttIfc1AM06BHC8ql+jGO9yZUhnkJA50VqSDKEwxY28RlAMFS/xRJdrO0SKcONe6EcaYB4EKxxJcXj0zvYraL1n8fkECtUGuw4rLolCZRKsEKorX+yGWVhd29k4er5UzdY0er9EcNdQ6TeHw=
Received: from SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35)
 by SA5PPFF3CB57EDE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 15:03:38 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::6a) by SA0PR11CA0210.outlook.office365.com
 (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 15:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 15:03:38 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 10:03:34 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 5/5] amd-xgbe: add support for new pci device id 0x1641
Date: Mon, 28 Apr 2025 20:32:35 +0530
Message-ID: <20250428150235.2938110-6-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
References: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SA5PPFF3CB57EDE:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f81dc8-ecf5-43fa-2838-08dd8665db18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W/VJhdrPavMtGvBUbnK+WDqUUy57iyjl1F+rUTD7ke1Z33wXjvejSzP8Pn5c?=
 =?us-ascii?Q?neAfAy+l2S8PhPri50cJA6+TKFKUTarmUsdzgQ7MVpd+G1dKKN/KGGVRRLGA?=
 =?us-ascii?Q?o6b7L6caxXXJoZ9Hpd4WrudYTAhLfqLj2E31JHxZOWiaw/K/x+XU8oVgv8Ce?=
 =?us-ascii?Q?NrZWpkSPs5krWxHvqMz/GvELzXEcqIhCFi7Ymz5vIInDFiIKlYcysRDbisaK?=
 =?us-ascii?Q?M8FoKmSQqD/tVeZX9zKaj7oVB77sEetJZH5GSPl3VA7I1RfM19T755Yk5Sc/?=
 =?us-ascii?Q?aqt4FJT5ltaQG1XfglomBSg4oYzl1S92GpPlwp7em3Pb6vJshZq0eblrf+UE?=
 =?us-ascii?Q?i/SXgK9d8RXRQY3/OTtYNTWgFDATBHUzQjjxTWpvJQx6t66W7cK3NEWlZwat?=
 =?us-ascii?Q?9W9zRbs+dBXThvYQHj/LMVoU8vUTD1L4SHBW17DP0tv+7IxyS9GRZWZAIObB?=
 =?us-ascii?Q?Y0b3zQgHh7/dBT6lFXUjiH56Gv361fGONdmDM3yoXHibQsQLuZQxuDVBNyC+?=
 =?us-ascii?Q?HjNab3p8jqjbF/XG/V8vujmJSqA3ml/yt3rDlkAEU4qhJEIDZqLxN5TS2aIu?=
 =?us-ascii?Q?/kOeptqxki5xdyCDZTLG4Sb9qPwG2F0zBr72Oetp/xxdLbUar1kt74Hhb4fh?=
 =?us-ascii?Q?sWpAeXYNnyZKksgMeATqPrwcE9SKKOL++jGA95kmHF6fpIpTmbbJRq1taxKV?=
 =?us-ascii?Q?JvG2g80WxsVmLtrhTCIqC8qjcGnfu/fN6eUWOMvOmMSO0/cPo8ydkJGcgbj9?=
 =?us-ascii?Q?8tV5dI2vKYhMRob4EnauUzj3GZL5p0BjRZePMjgWuJqocyzX3FnmRr730q73?=
 =?us-ascii?Q?dQzYb8B5o5e9CDQAzF8uvbtlpsj4HqKtn44l0m2Y5KfaTvOFx7hg01rsHPRp?=
 =?us-ascii?Q?49k0Dj1tYjOaY/fpN2CJKAjubqE8w15p5eNE6rzb+Zz8KYi9JWQTLx8oRJbk?=
 =?us-ascii?Q?A1x9nCgLlkkQeOaJY5oHB3lsj7n5WT26VP29QS6Vq6Rpo5WYEFK0QxnUzoVW?=
 =?us-ascii?Q?eUgG+83hxylovcynfoX8EYZBEEOi03MZdELkzij5Mx1ksoKwuyPBanQy1TSZ?=
 =?us-ascii?Q?b1tuu6IXv8DYC7mWm8nCT5iX/tuSkXOL6iP3LpOwoyA/dKsI39fxmnyyL18g?=
 =?us-ascii?Q?9Q9zzrLU++UKVvWa7CnHlDahXCKCOk8SqzYx9+rvYYqKMWoKiIRbBXGHNaZJ?=
 =?us-ascii?Q?iB+7to5HEh43FME+iUjL2jpoDbyUtZWgRKgI+fx/6NB79s527lArxeQnU+s1?=
 =?us-ascii?Q?E8vLCG9rOIq7b2mbi4y7xfA1ckCXHb02szQe4xRWy3tbFEbRPuWl8SSQ1DbG?=
 =?us-ascii?Q?OFivneBJUXNkgzsZY6mj5jAilqvoDY908v86vWN+kMyCsTb1tSLbrXzKDxGn?=
 =?us-ascii?Q?g0ysdJX1u44F/fp9qr2dYU+ttjeowgarJOtuUIQaEPxsOTsgh8wGsj8mxHq2?=
 =?us-ascii?Q?JDkjz+7E4P/KZuHzNL0Kjmc7jxi+si3d/la+spA2f5JH2mjKM2+uWXk3iL+x?=
 =?us-ascii?Q?dUqMKBk73iFHhNIot/j2BWTz15ssb/9EeR9b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:03:38.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f81dc8-ecf5-43fa-2838-08dd8665db18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE

Add support for new pci device id 0x1641 to register
Crater device with PCIe.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 718534d30651..097ec5e4f261 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -391,6 +391,22 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
 	return ret;
 }
 
+static struct xgbe_version_data xgbe_v3 = {
+	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
+	.xpcs_access			= XGBE_XPCS_ACCESS_V3,
+	.mmc_64bit			= 1,
+	.tx_max_fifo_size		= 65536,
+	.rx_max_fifo_size		= 65536,
+	.tx_tstamp_workaround		= 1,
+	.ecc_support			= 1,
+	.i2c_support			= 1,
+	.irq_reissue_support		= 1,
+	.tx_desc_prefetch		= 5,
+	.rx_desc_prefetch		= 5,
+	.an_cdr_workaround		= 0,
+	.enable_rrc			= 0,
+};
+
 static struct xgbe_version_data xgbe_v2a = {
 	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
 	.xpcs_access			= XGBE_XPCS_ACCESS_V2,
@@ -428,6 +444,8 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(AMD, 0x1641),
+	  .driver_data = (kernel_ulong_t)&xgbe_v3 },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.34.1


