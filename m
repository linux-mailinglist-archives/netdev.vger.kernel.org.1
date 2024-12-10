Return-Path: <netdev+bounces-150782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD89EB8A0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AF61888C65
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C061DC98C;
	Tue, 10 Dec 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vfwgmjPp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420E126C05
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852932; cv=fail; b=ITjGixEh9iF7zQkgZlqfLxwHX13Zo99E4VLGZq2l5iz0Lv3LJv3AcPupMk0tuieqkjR/MZO64ER+jl9gQTM/6HGr23ACuEO3q/gxs7AcEW2eyvGWhT5+eTvTx/cx3KcF8+Q2r2btpLIRtCRXmYQWTWHJ9hxoxEqazsXiHYHUOww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852932; c=relaxed/simple;
	bh=ymHQV1E2g38HOWCRBTmYk0KymE+Ez6YfFAi+lzlkPwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQofRp0XTBY1RqPrFnNnqQOSgCrN+RbitFlcGrtDO8kh2sKsLF8PwqDMTmdR5fLjsIfJqKtT+Zgq73I2Yy2uRQYy62eVvBHteSam21rTT7hXjlxxOwHx6EJZ1sPlJd+x8shHTICV7VG3H/qUUS6QH5062gx8DgXq5LEmYH+3zCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vfwgmjPp; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2T/btnypkgFI7iXhTWNY/9VxuxjEniOa5G3mdnxWvwbHLAZ5+SEOX1FyIHMICrgyZlr092jGeU/XCG34gF8B/LUoPUr59U2OC9qRMvmNDZHOS4SaP5vBDqJdvJQ+2vWK3TPHEOP+Iv+ZF7342tR0OmfnBRwpjHwYpyTdYCFG4QDF4no9nubtUkNT4zFjWWMWWl5ck7jaKBX7NOSxRI/Fhl49bJ8bATIOTedqFjXlAZ3PIRJtX9REuLEXv3RENLw5t8pp+BoFTRms9bqMQYBhjnCNXu4lVULHfJTbEkf7sk0xyIXhrp3ldmmL2lp8yg+8rzFU3446coQG2raRTva0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZ1l4pxCuXNlz8fvsSk8XAZBCk+wxekSWx5L0mNezGg=;
 b=yjS77pLk66B1NtUh4FaKTs1+ig82HZRtXwEnfvzm9TKVxWMxJpeol8uFpKspRbHEgmCB4T2kF/b/wURsoVH+2j/kOoBFHsoplxUHqIbOxCZJno3iF9mGCuk93fdjZcLZjLhg53+Io4COBtjyRTVX+mK48r8PtTKA87JTjwCFgbcHk3akra3GVIdbGGOJPZkiOGSERvA9yx7XIljaKjhfgiefv40KXtDgnfNeBFydcYgnLgrFr/kQREBQOHW0fSMEfLuYt4ZcftwWmAo/xvSt5i9QoM8M/lZa/8EzU5+G+bebO+0LMX7SXruiDMeY6bAs2jcrj6NZHyCCytQSJKT35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ1l4pxCuXNlz8fvsSk8XAZBCk+wxekSWx5L0mNezGg=;
 b=vfwgmjPpUlS7fQPsiIqd41/SQOY4YTi14UOiwUWkyi8R8wVStBnzxfJzpmk8rSYikiIisAJxl9sAoJsFssIXEHZvwDiHEmqns5IDXGe+1XPIi8ibCjnPGamGiLw980tL+wpKXpEN1ANVsp7K+X9hbAMl6juffcoYzyPX9WjgWDo=
Received: from BN0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:408:141::18)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 17:48:47 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::a1) by BN0PR07CA0020.outlook.office365.com
 (2603:10b6:408:141::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.21 via Frontend Transport; Tue,
 10 Dec 2024 17:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 17:48:47 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 11:48:46 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 3/3] ionic: use ee->offset when returning sprom data
Date: Tue, 10 Dec 2024 09:48:28 -0800
Message-ID: <20241210174828.69525-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241210174828.69525-1-shannon.nelson@amd.com>
References: <20241210174828.69525-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: cb79b5b9-bbbd-4bab-b963-08dd1942e61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X32T0qk2pHY6tVfiCHs6NgFoCm9nDvchVXiBYyWoCfK/oV/1LaZkdBB3zh9J?=
 =?us-ascii?Q?3lAKgplLguQOqlFEiw22Fu9SMxuGlm6kIbIRcjRayS2kCOrn9UJJwot/BB/E?=
 =?us-ascii?Q?b+1SdGZBdiQJLOlMnxfGJBblgAhj/0/kQ1o3U53mzmDz0mftdh4tO+eBj3+L?=
 =?us-ascii?Q?ohX4lw99g+ckfvg7MoNOzJl8PI90/3IBWsNWZXV98siymiyWyOAVc9bMwcNG?=
 =?us-ascii?Q?L+IQVEPcoQnSJaubYM9TW+7rqMNki+pcZAr6PKJDtcveKty0MhhdnHs/pNBU?=
 =?us-ascii?Q?Eb93uG5ehDAgq5yEVeuArEL4GO6NaDhkIeUKNFLpUf6gkotNJWk5WF77PN1m?=
 =?us-ascii?Q?DjScLo7slX5PBSVo8luncJWKm9uMtiV+YiAzbsbnrYLJ/DLJmRSOIhsqigiP?=
 =?us-ascii?Q?xhh2l+ZJc6WMvhCGKMxz6Ucu7fLHmw7394tbeXxJ9GjWdbt4+oC0oItjIavC?=
 =?us-ascii?Q?khu5lD74X0xXLeFnHiOeeyVVg0NeYe6nmA1cZ3W/0dr0LYWPxl4VajbqXxFX?=
 =?us-ascii?Q?7vig2e6qHU3xCNxnrRaOhYTR8f5QdR+FKmVKNYvw7L/Ye43dq1U3HUXsEZsO?=
 =?us-ascii?Q?csEbDXwowtlOqg9wStmyT5qTd93LWAKJyjkOm60bBTCy4MmqKn8H+iNePuo/?=
 =?us-ascii?Q?1TGia85jyVhVp1TmBbTA4VhoI2IXswihRTe0x4vcBfau0apVLZk/szPrhCfX?=
 =?us-ascii?Q?Nz3d7dAjRfZFmUyr/Xm2srvXEA0ww5rpaFnu5PllSbzeLcSuhmk6Cimag6t+?=
 =?us-ascii?Q?jhDz5UiGUEfTLJrHHqaDDw7BJVh6DT3mTrpA1uzjnjQ9gFmz4kvID3Rb5SKv?=
 =?us-ascii?Q?bnPA07gOri/Mkuu4vkFy6P8TTlTZ0Ky0eCY9FuSmXIrIvowSh9feoGsMZxLr?=
 =?us-ascii?Q?SM5SN30evg4lNIBFg5WJe4jSd4FOHEa2XqoD1hKbGP4eNTO6fDxRHGu7VjHc?=
 =?us-ascii?Q?zxJDmX+zEA1/5fN474JKrQ5qRgCeINKLR5XFp7yGv5iqab2hN/1ORCFwIz3U?=
 =?us-ascii?Q?mS5PXd+gPm9Sjard19bpkCNIlseHPh+9EaVqFPgZVKUxZcm6d0btUk/BJo9N?=
 =?us-ascii?Q?wobPhr9XN3z8iWM10a2L6L4cSOiiiXtnlOMcMvsOU0kcvDumu8eMQoHPJb93?=
 =?us-ascii?Q?vJRCyVByguP/E37J31j650Xi7OA03SsuEXrdK7NPl0E9d0Uj1kn/a9KP2ogi?=
 =?us-ascii?Q?7sKDjDij/28G+qWJ4WpeQq0mXnwkyj2MJ+f8yO/YkHvTqYrL18DtWo70qPbG?=
 =?us-ascii?Q?dJL5SvwgvxHnDntPufY37SGaAMP/IfTrziVSDjVVqba12Xy59Eo0N4GGOAAL?=
 =?us-ascii?Q?PulPbYagB5kZlrdrkaNLV5wOCXZxpSYPB9h4CIf54iRNuZ+Phds/FpkUkILj?=
 =?us-ascii?Q?OtcFNH6MhY6J0yxQx6Lt1JL6Ofw8Vt/bujFD1b0xLym4jMsf0RsGGDfeFbMo?=
 =?us-ascii?Q?GH8JTb/xc33omUXhCQk49tZlW8M17jVD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 17:48:47.4900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb79b5b9-bbbd-4bab-b963-08dd1942e61a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656

Some calls into ionic_get_module_eeprom() don't use a single
full buffer size, but instead multiple calls with an offset.
Teach our driver to use the offset correctly so we can
respond appropriately to the caller.

Fixes: 4d03e00a2140 ("ionic: Add initial ethtool support")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index dda22fa4448c..9b7f78b6cdb1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -961,8 +961,8 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
 	len = min_t(u32, sizeof(xcvr->sprom), ee->len);
 
 	do {
-		memcpy(data, xcvr->sprom, len);
-		memcpy(tbuf, xcvr->sprom, len);
+		memcpy(data, &xcvr->sprom[ee->offset], len);
+		memcpy(tbuf, &xcvr->sprom[ee->offset], len);
 
 		/* Let's make sure we got a consistent copy */
 		if (!memcmp(data, tbuf, len))
-- 
2.17.1


