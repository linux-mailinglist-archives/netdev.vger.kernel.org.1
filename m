Return-Path: <netdev+bounces-210719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A4B14805
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16B01650E1
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 06:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F30256C9C;
	Tue, 29 Jul 2025 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aM9Fmoaw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDC1D516F;
	Tue, 29 Jul 2025 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769445; cv=fail; b=HVgDy8TLz0bVfsUY4WyItOxzw4IBMqCQkIFXXCWkprwY5qwelHaIJvjPL9TBwbmqPQki4Z+K/WvMWdT2gjaEEI4YOa8wrvBh2yq4fHnzVmOjoZneiCi+pbItKOxUrM0vERh+6csZnRAPMyTyxauhNcNHRl5LZb/TCtFQhNxP0S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769445; c=relaxed/simple;
	bh=N/GrxoUKJiu091f5NciCsYEb/Ll/wfKkrTlCnGaTGmo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d053N83sAIwLNO23e5LtX2ESfcHQS91vxxlYbYdz0xk8V54AN10elnMnGktEaCYfFg55JLCXvQ0p+H3+GG1EtY1pbfztC4U6uYVfWzPku5HvJD5fhtpnw8/kXsYuNThfj6IM7ViWnrUMK0UbetF1+xWz1aNjXQ/fhteTLPZRhyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aM9Fmoaw; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkxIuWUXR9ZUaDDlLfclix7Wn8+1u16oagyVAPO0KzmqO5xKk7oI/ctS9XPH+Zgjcn26kxj5u2QQQLWaL1XUUmcWyCZB26uN+rxuXY3Jh2xbafRrk41eLnkNWS3U9aUVpKhpzpxsqoPR9FBxQKFJz27C4tZwoh4oDxLUdWc5X6A8Um/5PPt7cUeX7htpbsNVGuqQfbsp+CHCoCNnMcMJxdR0si8dvTLXPAt3JnX3Nuyp/PA9qY8YvZMtIaOxAAEzSIGsKgA2HWHcIwXN52mwed9HvnVFE0Oh1qf1c5koP2xt5MM9Zz6bFBBSl1InNeZU6CLAL/sQhL34LzJnkc8RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fv1hA/qsjeEkI/16JLSZ1ClD5tjCyrnjtRqHeZDVWs=;
 b=YGOiiCHBH4Q0pHyDjUKh1TJ3GDZrtRbLRmjz1fbcQvb1lz3OckAH9zBYFqyXbo9UW/paHpdASShbOzB03WUEk96cJ0+DR5jzTJd+dPUHHXynoceS+pFssv/UBMuGbk3SKThy7n4LsP3xND+elcLlSvplvyJFLhyV/rFW3gbQKl2ZTRuynkVIBlCwe5T0qgdba/E+P70XxDCFZVezX4j49NlcfdPvNj0AZQAq6beEdB3z+qbRKqFEPUf0R6F/p2jrC+kq5cOqUIfStwKVRF/iEvkMpxQt/+sUZHu4nRqCxZiP1ztdLzp15mo7ZBDx2Fx0EnYGS25xnBpzL3y8Nr0L+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fv1hA/qsjeEkI/16JLSZ1ClD5tjCyrnjtRqHeZDVWs=;
 b=aM9FmoawsCm73BQofwnYJYQ3V80rv9/H6PM44K6xaq3TGzJnxUwTlWAr4u3HOIAeYLp0N/EhbpFXJMpROJR9Lf1+fvFHv2BnNiW2k2p1QypPBBWiBgUkVlwodH/qFskSm4u7zp8m+n56hPr+oKQKviZ7P7lFyg11pTGH+VIQems=
Received: from CH5P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::25)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 29 Jul
 2025 06:10:40 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::48) by CH5P221CA0023.outlook.office365.com
 (2603:10b6:610:1f2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.33 via Frontend Transport; Tue,
 29 Jul 2025 06:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 06:10:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 01:10:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 01:10:38 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Jul 2025 01:10:35 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <vinicius.gomes@intel.com>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vineeth.karumanchi@amd.com>
Subject: [RFC PATCH net] net: taprio: Validate offload support using NETIF_F_HW_TC in hw_features
Date: Tue, 29 Jul 2025 11:40:34 +0530
Message-ID: <20250729061034.3400624-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: 069bd1c9-d608-4b13-b1cb-08ddce66a50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q7tEpM+VDRb2vXFLbammzYs6boqSk//gvxZhvZDvcYSAvV61JiRfdJxAKf4T?=
 =?us-ascii?Q?GWoHNm3Dl1eEchbd8DkP0ft1ozAnvVF4V1yCnbupgoP3ikYbxzadN05gwmxD?=
 =?us-ascii?Q?x6K8DeP/QaFEvmWEGDd0sZnwoZin/FMRZF3lDRJ74ZqRLxGCvwfYoXskAgb+?=
 =?us-ascii?Q?JpMamhzq4lE2oMtz/yWcHorkvhy2fiv8OM9kALrrhevqNSpXpsEkCiXSTPWR?=
 =?us-ascii?Q?dyO/+rs9dEpiCXel3dekXjdrKNQcG3XbvT7ddoNUuqZd+1pn2TPq2H/mLPoq?=
 =?us-ascii?Q?x452+R/OhFLvJ5EHU51DND8y5kb7j5zL8oG2T7mI2WkSHm5HURtC6jEkriwx?=
 =?us-ascii?Q?Tns97Ltuiwa32FwIxUXB66EBZsz0d3rAGbrvOCrEJg+Z1+c0eg+SlESXvh7y?=
 =?us-ascii?Q?DTWnVnkxm84EIEx0AQfcLWb8/ArUySwjGglB7YOQDzXXV0IK7TWY7QclIOxd?=
 =?us-ascii?Q?JZkBSGZzv9oj1yCFBsrfFosG5tUBFJ6iwMpIrt83Two3I9wVNtMCE4LTj0Z/?=
 =?us-ascii?Q?ZSyv4FmwPlhVpGuNv0drrgngWfq7FpV+BcjXE47l0UPRohYy8zvLaG4CtSbm?=
 =?us-ascii?Q?niP2OAyJKKj5bKrSRAn2EZ4pK+P0mxkW6kg8+s7ndJ2Na9lci5gJRnGCcQTf?=
 =?us-ascii?Q?rIqRxkkVSM6KlCDvYXYBHjBuh/7Qn4D0e6E6orsxTu/9n9H5wayOm8NKlwGG?=
 =?us-ascii?Q?O6F8ZeQKdBfeZClTVf4FgIYFk1PoUL+Egd/d76q3FKjK2Z7E0ope9LQoChZM?=
 =?us-ascii?Q?ggQCl7RT953Oe6LBAJec6tlzuGrsXFQmHp0cgDqzoF0gMCk65PCMvI8mIqNV?=
 =?us-ascii?Q?5IPOP/Ue8OmfWUVNLrdiy7rwmiMcWN2thh3iFoQNgQkrEXiaDEBx/WZIVuSG?=
 =?us-ascii?Q?/hH86ea3rBLo3Y65QuclBW7xKw1Z7jtJJwmiIBwVI598ue+W4fCrrE4SdXtl?=
 =?us-ascii?Q?7f8DmTz4lQ3VyStVz4tF44qeVnWWegH84lsaegcTE2VUQCIFMAn+nC7rEm8w?=
 =?us-ascii?Q?72Odo90O5CA1OPycuvNFo2fyLwQhIxLP0lRn+DHrr19B96PpQy4nK5cYlGda?=
 =?us-ascii?Q?bIEcHZJL5PpqrxjOmL6JM1M4H15P4B80+tDZO2LeF6q4xhuL1VBgCevRBf9/?=
 =?us-ascii?Q?FzSsEauG1SUSIT2ZUqm4pWJZHX7A4lWNpb3xKPmiWatq7qdo+3gJKzo0KoAm?=
 =?us-ascii?Q?3MCXGR05fKKZKic0WbZNCOXkTMqAC+vGO8wpYiv24HxiYjHd9G10ipyNqCLV?=
 =?us-ascii?Q?VrTCyoDKZUYiqb7zFgkpoPY9BX+x/V1VxURS7vwNBje3/ABY5vOcLj32uamh?=
 =?us-ascii?Q?4dxZE9jPV4SqdmuvSm98mPn9gDtEQMQfrHhivzy2uiW8I/tLvgyHMBPYg/Fu?=
 =?us-ascii?Q?wKo7Q3OQDZ/RRqIWqGPjU7HuQO5Br3GQyB6S/diSbA2tF1zPEkRauH6ARUnN?=
 =?us-ascii?Q?+129KiYx3yz2TJ9EFb7yxzdbDvdcz0E6925hfq6oUiLbK0A7VWGXZMWRgkPO?=
 =?us-ascii?Q?AMLNL7MQz2IYokpcZfMoKhfKj7C0/QXG6MwTllwyouyweXlbPY5R6x1wkg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 06:10:40.6925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069bd1c9-d608-4b13-b1cb-08ddce66a50b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D

The current taprio offload validation relies solely on the presence of
.ndo_setup_tc, which is insufficient. Some IP versions of a driver expose
.ndo_setup_tc but lack actual hardware offload support for taprio.

To address this, add a check for NETIF_F_HW_TC in netdev->hw_features.
This ensures that taprio offload is only enabled on devices that
explicitly advertise hardware traffic control capabilities.

Note: Some drivers already set NETIF_F_HW_TC alongside .ndo_setup_tc.
Follow-up patches will be submitted to update remaining drivers if this
approach is accepted.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 net/sched/sch_taprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 2b14c81a87e5..a797995bdc8d 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1506,7 +1506,7 @@ static int taprio_enable_offload(struct net_device *dev,
 	struct tc_taprio_caps caps;
 	int tc, err = 0;
 
-	if (!ops->ndo_setup_tc) {
+	if (!ops->ndo_setup_tc || !(dev->hw_features & NETIF_F_HW_TC)) {
 		NL_SET_ERR_MSG(extack,
 			       "Device does not support taprio offload");
 		return -EOPNOTSUPP;
-- 
2.34.1


