Return-Path: <netdev+bounces-169307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D3A435FA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65390189895D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE80257AFF;
	Tue, 25 Feb 2025 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Orb+6Jfg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890F1624D7
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740467679; cv=fail; b=j+RviBo02SNIHUjZZzyckUDzRUd/mSqmzeVa5+4/P3graEl+bT5dMlztzmJrAlsEu8j076mhngFd0QQLlJgv7iNIJDK+ok4mgZaPLm/mbCNgHaRTFUBHqrXTjvCDPgiumqWcpTFvJaWcWXGX6Zhiu/js2ZES1pjV9+IK9RuHAfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740467679; c=relaxed/simple;
	bh=xyzsIpfmr/jxQOh8cN0/6KLhCfQA0QjyaQG5YWSb7fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P6mNm+4am8THy5AHW6ti4vo5GPGtJDWWrqKQCUKnenZJkb0ZYYIH3gk2IoWQW8knhIW7rVQdsTvpOtt4rsnuMljVj87crjI5sGoRmjOhRcmI7S5cEjIOtbgNh9Nrq+1bm/Ik6l2Y7YK6eacjmDKOS5uKPd7cLX6cyHMWBbxHwPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Orb+6Jfg; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s94eK1r1EwpCWLAFNpjttlPg7DPwPjcxrflZr0yypqeW/cAqVsaadxUH+/Ocmo3sau2tv1r12gby86m+HssbG0C0H6+3dGRv+5sUlASpglWJhB0zidmCJdKViaF8iKlXgCdTycXRkYElAIMNl8dOCxsdBnv5S95pgXPNX7iE1rvShqx9zAxSaDUaR19+6vvqZ9EZqbf4mK5WaaMPyMClxfHE/ytJKMgwURK3ja7b/zozTQ5qwzGdFraQhPdnW+Gfr2d1ynV03bslFKUlXp+riQcxSmXJYQKwCatIPsGczCGVR4AkkkDCsHYdg2nZeJ/Q/Nlvfl21B9+Jd5rkqd7EXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V5FFQyGS4d97Wd65jE/QSo8//vGXU/5lCLYl5X+uVk=;
 b=hnLY0LnCGpRAvVdOXIFgAEHsIxmbRA2Q4yO6+4BsAn4IHV6Zbjl2GxiQfRPLLW89TNzk6QFD5twneyyfoqMppWNIWljfxekHDQvElxqCTKHekpcUaIgWYbVxCnrPTI4LtWQ8fHh9vB0tIpm3CvfExd+BIbHtlNwZSnaA0p9H0jk54GOJhIiPDxfQZ128lkSKAAMGN3V0lRoKFvHrnLdoPEwjnSC75SudBIoUrvKZ5Ldvy/Y9A/L9OLFVYuVP+KpXDPD19Aj24sAo0EFOuMZuPXCIvSCOT3e94j35JMYvwJe/Axbuto/7NksQ7FcPOMWXpAGc7lctKXCF4c+tkV4QyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V5FFQyGS4d97Wd65jE/QSo8//vGXU/5lCLYl5X+uVk=;
 b=Orb+6Jfg/kLbwvBE3gSdUtpiilKrt8rzbQtqPBWchvFaLg9zjuKZJGvJUezUi8UG2D6Mfnsl25P502KwL3YC5i8SYLrpBynxbUCDbXVCXZctr5xnude973btr5IpIQKZs24oRRqeKicDcHU9wpiaYbIDZCYf3CnZLbQn6aBve6ZjkCffCr46dtMSNuyb1TlKSW0gSUgFsvWCexZc8dLaYCq/Ge6u0pPoyPALt0J8FnJ07Gc47N+GPyBhsjSzewYp24SI3/4yeoDfZXLTmq5PhLR8D/zdexhCJ8grVp/5hjfNn6e15MKxZ4QDsdBHlpebIjCQi65V8+MbpEgWgNu3ow==
Received: from CH2PR17CA0019.namprd17.prod.outlook.com (2603:10b6:610:53::29)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 07:14:33 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::20) by CH2PR17CA0019.outlook.office365.com
 (2603:10b6:610:53::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 07:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 07:14:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 23:14:19 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 23:14:19 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 23:14:16 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Joe Damato
	<jdamato@fastly.com>, Gal Pressman <gal@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next] net: ethtool: Don't check if RSS context exists in case of context 0
Date: Tue, 25 Feb 2025 09:13:48 +0200
Message-ID: <20250225071348.509432-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae1f3ab-6a8d-45f2-fb8f-08dd556c0ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KVWh3aeBjhpjMJ/JUfKGNWfRum+592PFaeORSqhsj7UajvDinsF9zDt0bIhS?=
 =?us-ascii?Q?U2BsehgtvA7pDUrtrVQs8U1Gte8KUjZFIhWJvdZpuoN1ElHr5+94IFv3xQ7m?=
 =?us-ascii?Q?elTShDLz96ebjmRerwYlIG6t4XU6Pll4c/NTxHnHL5tS460cP8TcWA6BZfid?=
 =?us-ascii?Q?G4mWi8QF4jiU5c5EdMvBKDAMPy90hpMAQmd4nFOzyX+Qpp5lCMfspyJ+ksPa?=
 =?us-ascii?Q?oVI8gfeJTwb++NnOm2YZ04OYI1qy6+q4+i5d67turP7dcb+38xZF3UbLM61C?=
 =?us-ascii?Q?mDTRXPM3f90dmbaZx8tHclwzs9wfvkrq9JawUPJBB4QtEMG2J/nOH4snCIYP?=
 =?us-ascii?Q?uwOlPPmEH9EM5jvVnxE71J2SFGJgmMyNKS7VKRpvg0hxCxXJ9NbNy7mO6Xl2?=
 =?us-ascii?Q?vdt4GiUwCKqiQnzhCl1mJmEQvmXEURNjE1Qm19rgf3RVTASsPoBgGfyg/dot?=
 =?us-ascii?Q?UoKm95Uf2kodPGtYKDcWat90aH6IXliSCKO7EVmdqMvlxluVWBF7hyEBK34T?=
 =?us-ascii?Q?WJmoWunnJ5F2Tqw84gXLrFxXnZVbvHOTt5yIwztc2JyCeTY1521iDSfGt0mr?=
 =?us-ascii?Q?dXXuOwUzuo7zSY/bRVw4ec8sxwKrixw96ykwCiwdyCInu4U1OSPa4/HQe5Jy?=
 =?us-ascii?Q?KhlYsBalEhDAbhM5Y54oJj0lawH25wgLCskdvWS98oEF34ETeEAI9v9rA366?=
 =?us-ascii?Q?3FXVKQiXfvFc35MLqTx22+AgJV8avKPO5bstG6Pmzt7pa1V3RsI/At9ji6Gs?=
 =?us-ascii?Q?eVYJ+yPiYUhMVpBch2TPOg02v1OM2+0pNnz/buNSpEJ5/2jC/46wi21GTzjI?=
 =?us-ascii?Q?9cCOqh/x5rFX0NpTdsv4B0UPWsrxEHJbejBt0RlaCVFzlf4CQqYI1bZ5qzF6?=
 =?us-ascii?Q?NvWBiGucPmCSqRdWrtuSme6O6UFcGkgt+FgjeGjVz5Cw9PXJkbK18zp2r9YO?=
 =?us-ascii?Q?DGEuZateTre/dGnPSrdqVYvWuURymb7xXL6gfu1huYwszS2FTI5lm/Frta1j?=
 =?us-ascii?Q?Gdos7oF7qEzu7qzE10+5VCQEGEG6EmFZ61BmmrCP0SIrlKwhV/3YJNJUF/ew?=
 =?us-ascii?Q?GhEEgwz6sT2GSvSt67658AKI/SlDymdVJJJYQEpYM1cXxVtmZs/L5tPNCON+?=
 =?us-ascii?Q?nLsWgdHAGhAa9vh5CpvsI3852TDh3CGjfMoo+S/Fa8c9NCfMTCltVxzL4Xyt?=
 =?us-ascii?Q?/lTLkwCSHqoKFeox/ccDMevykLPzRx+k5Q51jvknEMr19phUjkX8berDa8LF?=
 =?us-ascii?Q?x3NExSIwYlFrKKJ+G6Wf82KO+E4YyQ+RSa/ixCsEVXqoW5N6062n1ZdL8ekk?=
 =?us-ascii?Q?v0Q2VtvgUKrozTEO3vRcu8DknfkCEYH786Lm2eGxgF50msG+iJSaI5tc6rwv?=
 =?us-ascii?Q?0i/9x736g/8vfZy67UPi9QG2vx48Bs9VUD+1vNPAR7QITdnXLaqAoLeU9ocw?=
 =?us-ascii?Q?XxqGHkzhMd+ogo56q83kdtF7HEXyDnoHX0IzQnyuFheKdg7dbd/Ee3ZcFqDh?=
 =?us-ascii?Q?Sqzihf559e7VLGo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 07:14:33.3445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae1f3ab-6a8d-45f2-fb8f-08dd556c0ded
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

Context 0 (default context) always exists, there is no need to check
whether it exists or not when adding a flow steering rule.

The existing check fails when creating a flow steering rule for context
0 as it is not stored in the rss_ctx xarray.

For example:
$ ethtool --config-ntuple eth2 flow-type tcp4 dst-ip 194.237.147.23 dst-port 19983 context 0 loc 618
rmgr: Cannot insert RX class rule: Invalid argument
Cannot insert classification rule

Fixes: de7f7582dff2 ("net: ethtool: prevent flow steering to RSS contexts which don't exist")
Cc: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ethtool/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 98b7dcea207a..0be7a622dddf 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -998,7 +998,8 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
 			return -EINVAL;
 
-		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))
+		if (info.rss_context &&
+		    !xa_load(&dev->ethtool->rss_ctx, info.rss_context))
 			return -EINVAL;
 	}
 
-- 
2.40.1


