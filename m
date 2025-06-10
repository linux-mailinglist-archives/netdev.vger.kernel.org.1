Return-Path: <netdev+bounces-195964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E96AD2EA1
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E13A4F76
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCD127FD48;
	Tue, 10 Jun 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rr9Wj1yU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA227FB1F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540396; cv=fail; b=e9qepM17FDkcCcyMSRK5hDGmpZVr5kBCzFD/mg+YW0zsOg2fmh0eUFBNiVCwsz561K4J0RLcU24giiESCm2Rnk/oCh/gz+C2IoPGkX3mogW0DKMoolf58DWOJw++R2NRaJnj7Qy+Vi/vZx02LkFsmUeMFvqwkz2fNMO5ZumFfhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540396; c=relaxed/simple;
	bh=FnyIdMxe41nToXJKaHHWy6DkyL8CtkqKOv2zP8Nl4dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ/AkvobaHAuC+UJMuWPMrYssUIHXBbbmcOZTSD4s8mTBNNp/ssOj0N7RUxhNj3mQhR8mA0Yo48S9kqLwoqMdKjAVUYAlEW8I4ArSnkYOGbqrjWO8cn4Tm2hRz4VxKv+8LSAIIfuW/21xy3KyOi4FHKnfkCLHQz2e5nIt+w8ugE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rr9Wj1yU; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keFf2jgovQRGxwiDC0Xr8k1yBvaP+roXPkBACFAtu3bX+4tdYb2/xIDqrSLQr9A4eSN22nJDGiDI2sbysK5J1IqxJKkkrkli6kKdkGIkxgsIgfug1q/AsQaDzPaTUzmaX25EvLPp2GRD6cj2MaZgXMn1am3IadufN7/eB36RgZOUHVXbE3t7YmXoplnX0kVKcrzqJOx87fVadmSewj+nOOWT2R0iyw/aGxJDaCQazhejuHqCngeor9TEgaSR+QS73D4vWT67ID2ICMYMH6sT4LDl/W7pP4HXgH5EPmcHpBYH8Vj6oaKW9OypJOsX27hppdDCBCvse1PVOPgVVitJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwb4xcO5adyxAnnhy/y1iPi2i2eAxlJYZKdHiAsLMtg=;
 b=uXw0EMIe+0Q4LRcufFpVvjJ9CZXOPF6S7g8xl0dDOJTNfgf6Hfrxgp0OU2Byoi//5YpqL+YmNHbXlV6MWZA7peee07NEzYXow4M9iPSbPZ04xNgpEbLYGpuRkrr3MuhID6CC7LYsDLHmAF1d3R8/bnMDYxm3qpKZwBnQ0wjY0s27wMzjjOq2RAxfXCJ/zrVsG4Hh4i5FhiP7CVDTm0Rucvfr+BHy4H8woKZDoNPTzGPpYUCuI0oTShdGR5nU5LivDm4gqfK8Ld7goTqK/l7dF20QsnGHmcwwpnTz1iYVhCHEho1q0mHr6dgwvZrGmEAutRZoA9cSFjYflmqmnr+eCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwb4xcO5adyxAnnhy/y1iPi2i2eAxlJYZKdHiAsLMtg=;
 b=rr9Wj1yUNoWPg1fAtN5vOUJhm8tC1yvns1D/PJoS3I3RINYygZ7GB629lQCe9S1VU1rK1a4jHB6bXLhuBvgnng0KLBw6UzC++2CvB2wA/En1ho0ezGmTQ/Vq5eWmor9JBCBCqgYmVqWsveU12i9ZxBwzPxC1O5LIan5xim0sxOsuNolVtqsvFTBu7poesDe/VzsX6o/LM1E8acpwf3Bvh5TF1enPpSbBSYX5NdrSsrAVfdXCKragfU5QSYBh535sDAJAN3C2/tVO39tdn3N7BDHKKAwO6EoAKKTqVesVVIDP/7pT0+jlJ7K2cncrCeG5LldFbtuz+gCgMFVAsHoXsg==
Received: from MW4PR04CA0091.namprd04.prod.outlook.com (2603:10b6:303:83::6)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 10 Jun
 2025 07:26:29 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::79) by MW4PR04CA0091.outlook.office365.com
 (2603:10b6:303:83::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Tue,
 10 Jun 2025 07:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 07:26:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 00:26:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 10 Jun 2025 00:26:10 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 10 Jun 2025 00:26:07 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Alex Lazar <alazar@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/2] net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs
Date: Tue, 10 Jun 2025 10:26:10 +0300
Message-ID: <20250610072611.1647593-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250610072611.1647593-1-gal@nvidia.com>
References: <20250610072611.1647593-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e0ffa0-178c-4209-00ad-08dda7f01d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BVNPXCDRGPyFcNFVRfnNFuSnlW1BXh7q+78SZ+qU/tKUBTrJf1n/enJShOVg?=
 =?us-ascii?Q?ENyNEhBp3hO4s0lCK2fvuf2kXPYj0wojJ2uqBHyGhczjliRjiMSqmH2BIHis?=
 =?us-ascii?Q?NyKcDugb6cZCnV+tG0H/xQUGru5V56Gh/ommdFv73+EWhBYAr2drchhzNSoq?=
 =?us-ascii?Q?HZFsi9AoxKv13+ibbmS0CQXAemRDbowo99WlCIJYPlrHgfz48j+vQP6dQPTU?=
 =?us-ascii?Q?yY//TXN7HjyQUU7mZNGyFn1V42CTjHC6+Xcai9CtHcsud2kht9JaQZMzeTXu?=
 =?us-ascii?Q?MtFrnKfSGxNK6REWz4LYA3v8sVScVwBzO37c24FvDiFSc5trvW6izKCCyYdi?=
 =?us-ascii?Q?47EXxbCSlbQyEjyvXtIOGVefpL6iBtC6Pv3/yWy2yNVwC1li0gWlKBOhPfCX?=
 =?us-ascii?Q?Hu1wyY6wh6vKjnRHxy31kosm86RyWTX4Jj7HHGGVGtSp2Hn4G7IOaSR68zVe?=
 =?us-ascii?Q?QFZryTSrCGQECDtYIvcu8gR7vcXl8y+TBFRwEbzVMLiBlpZUELJI9VDQuJFB?=
 =?us-ascii?Q?ncc3EZSm385jrswgLuvdDFo8Rdq5zdydI02IqUACeWRdK+0Xr+e4l7GuVjLV?=
 =?us-ascii?Q?i1WlAd5HUaZr67E2z4urHwpCd0prq1v20JWOthtDPYEdqQaQOz3FR52PdG1a?=
 =?us-ascii?Q?AH43hbFKFd0uZAitwPFY16Omo+/RYAit3iGodI5YeCfWh2dm+qkNg5/ZPp6o?=
 =?us-ascii?Q?HNT/IuDcfPMwSzviB/hA+xuHsZp6tyEyhMjXIBDApoV80XwxeudfRuAFv6Vt?=
 =?us-ascii?Q?V4cv4AQIgHBEyicP6UVbNYFFJQTg0PtEhg9/qcpEH8jxkcLUB7nQnwMZxMUK?=
 =?us-ascii?Q?wNrY3qF058F766yUtte6dp7pnETLWDLYl0/8QYg0uKSfLOSTOYK9nQc4tO8W?=
 =?us-ascii?Q?Yax5HYoL2dXddmJ/WYPbEfotPhdbzrxscSXfD+DQVhpycz26A6vNVoFp8bVK?=
 =?us-ascii?Q?W1hRtYi+zoGRxiKuqXXFzDdJIoeYOIr63FWyAuINSxXrZW1C1WFAOzCh4HAz?=
 =?us-ascii?Q?8+K/BTqcjJ++SH9UQsgn4fUayAcBqh+dk1rwJkjBNfhmLoVRJWGSk9PY4dlk?=
 =?us-ascii?Q?K9BconDRopQjfgVDFdKEkBQiHleEysOHYxQsqjlKYK89H7HAsRtTc5rEg6qA?=
 =?us-ascii?Q?MAIocUHyTGIYKUE5EoA1PGP3KirVez9xzAf9Ti1Whprtt3pbcQXg0vS7r6KW?=
 =?us-ascii?Q?tN9RSs+GDCnH6tgOKFd/yKeOM92pDT0DTWcnPE1djVpWPP0VLGVnyJmpkkW0?=
 =?us-ascii?Q?2+G0egAmGwB5BkQb+Gj9Hg8y6NEryrRn47zpDVvDPRLVqfRLJ4xZqSmiHLTY?=
 =?us-ascii?Q?UmNDQDLs6LMDBG8d7sRPQDaRRqSI1nkFKl2kBgMe7+YNDgNK+LFHobR0gdbN?=
 =?us-ascii?Q?yCmYeodfwaTeQ0/z4mH1S/yCShyvFLrWDETejtqEfXXl7kQHXabuw96LIBhF?=
 =?us-ascii?Q?TQnJoCH4cbZrOGly65zF/s+CReoCGv7ObRKbqGEVSJB1h21LEXOIe5yJ73oa?=
 =?us-ascii?Q?GRFtbps7Nd1A3qaepCTHzMuIWxHFiypDjNWR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:26:28.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e0ffa0-178c-4209-00ad-08dda7f01d53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218

When CONFIG_VLAN_8021Q=n, a set of stub helpers are used, three of these
helpers use BUG() unconditionally.

This code should not be reached, as callers of these functions should
always check for is_vlan_dev() first, but the usage of BUG() is not
recommended, replace it with WARN_ON() instead.

This also resolves the following compilation error when:
* CONFIG_VLAN_8021Q=n
* CONFIG_OBJTOOL=y
* CONFIG_OBJTOOL_WERROR=y

drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.o: error: objtool: parse_mirred.isra.0+0x370: mlx5e_tc_act_vlan_add_push_action() missing __noreturn in .c/.h or NORETURN() in noreturns.h

Which is caused by the call to BUG(), which never returns.

Reviewed-by: Alex Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/linux/if_vlan.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 38456b42cdb5..9135cbe6ae92 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -254,19 +254,19 @@ vlan_for_each(struct net_device *dev,
 
 static inline struct net_device *vlan_dev_real_dev(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return NULL;
 }
 
 static inline u16 vlan_dev_vlan_id(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
 static inline __be16 vlan_dev_vlan_proto(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
-- 
2.40.1


