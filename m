Return-Path: <netdev+bounces-164627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E130DA2E7EA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C113188740A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39641C5D4A;
	Mon, 10 Feb 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VbbdCT/O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44D1D47A2
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180068; cv=fail; b=DAUcR/YOa4fcK1joOk35SDH7w3VQ70W5nd6L7sCw8AYKZMnIlJp6+lidgjwHqGZWPXLF3cPud8xPtlJowGm/Eq6VkTYzNP0fLczchq3TGL2CUbrjBR6CEjYKO3SfDhVx8wQThJ3wwj2ckyxFjh1AmFAOhZW9uhQtzHOyW//4+nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180068; c=relaxed/simple;
	bh=y+gXBFyGHj9CW5mTMClCiyGn63mxO0lzWvYMHrR5uuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgJnYCayVRVi33akrtY+fLFDxRdX0sfXheB/vRtBQSc+2NQyKBrPVv2QCMqnkM4yKvBdlB8SLLK+F7PMXJ1uYe6A4aUKAQAuovk+LSdKc7/6RwUuuCOWGV/p/+y9ysjltYnMj2VVd1o0mCGK7e1woPeZRqW/Zvn/0JdK/oveMXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VbbdCT/O; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx5DETM5tzQQfffriMmcNNaNPElJBwezSF2y5FNrLiJSkiQkWwZsm/i2DvYxqWXgWHUF0ynBU+rU7+Mc/NM7vrxFRoUzOBs1pC6t5URlzgGWnC49EFzaeA23z5cudWDqlQbebCzduOPQ/G1qLSlwK7Ty44GPVsrDPSvBuFD04OrmpiYUBdK4WHZQ/w2FHRLX8y8llNkuALhwEGEfsQiwAAJSpYZVE+NzUy6LAT2i2ksT4ZH3FB+7ms7We8nLwDsKrSDKhwBKjeSfvIe/b1q8W69QBxNlOdBBavAdLPWDCAzHpV90ianGZwjT44ukzN9clSh6mx1qAD+A6hFM+017VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16aqgjJnzbXPsltju/p3sJDKjH/lx97tyJ4I9kbsrgE=;
 b=X2Pf25YMCJg0/5rj1rzwM15M/EzEQJh3ojAdLD9tExZaHCA+tUEGPsVFkgzKPHCv7YCQO1N39M6f5xn3RmdOYH9b3wA5Q2tsXyCSUhW4tKpGS032OzOUeDku8eXoqGkmvyHRU3s61BDpJjJp48uVd+6DmnYajOW5sGRlXrsi0z8dWWZKUFewcnTPlSez0h/1FGBLnzcsUryC2FVU2/IgtLeC1DikCEyAXUZ3jQZ2vS3Am6/9C8OksNYj14vRwLEXQRVBJUDQA0J4Pq+aGNgtQ53wq4sm8trq7/kEzUzRWb7il4T8Qv0Jy/r2KAR6zvW53SkIgGqgCIbF2BbAngysPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16aqgjJnzbXPsltju/p3sJDKjH/lx97tyJ4I9kbsrgE=;
 b=VbbdCT/Or1imihzbgFVAodAITwU/5Uk3Ny9S7EdyI29uuH1oPWL2j0Upy55T21QveKxGziql7figYNQ51d9zMEG/irf2zYVvTLIl+1qVTXkQclyqkhiCwFQ9oyDAPp1nzJuRYXnsk3w8XbmiQWNWqjSXv9jL0SuOBJ3ap4gDjoPL57E/0L8XqV0YSJQYX+hz1k4cowRPZs7xaZi8E4UC7u5MAW0QLYy81YiXO2eZbAXGzKvrWqBRkFJIUiKkE3ArPy8Bs3BoR6h0oqKgI2JgxYgl/d05Z1J6pafAZirOQMq6tQ5eLTqcsR+XLmxGF0Vt6gRaCIsFX3WPtu/O76Z5Ag==
Received: from DS7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::6) by
 CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.16; Mon, 10 Feb 2025 09:34:21 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::36) by DS7P220CA0001.outlook.office365.com
 (2603:10b6:8:1ca::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:34:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:34:08 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:34:06 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 16/16] ethtool: Add '-j' support to ethtool
Date: Mon, 10 Feb 2025 11:33:16 +0200
Message-ID: <20250210093316.1580715-17-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db355eb-7f87-439a-a054-08dd49b6198e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKX03oPKwDsHKz4YvklpCTyBc4p7TSNHBfl2T1feN++u4ytNvpI8MU1qk6qq?=
 =?us-ascii?Q?/1/WZu+RemAUnI5kdbx9eo//aiui9DS1Yihpz3m0kRPOebUls1Kk8aJM1/9o?=
 =?us-ascii?Q?gWxuP4tn+d2wTXeq6rlQa3lhdtPXOOAIk2K9YbR0VRZ9JNy6wn6aUE6bwwKX?=
 =?us-ascii?Q?2ujMdEGyxMNYXTbwENqjoxcY6xfaEcRVX+ID6tg3R8wiEPVxJ0OE/rke9ZFg?=
 =?us-ascii?Q?79Lt5UibnT2OVCdzRmLqSf1Qj73nvP0tsoxTgTfAubHItuWsZTeCrvxQ0SjJ?=
 =?us-ascii?Q?wlL5Jmptc5ozLg7w0gZkAp2KmU3pqvm7QZAyMbpY9UYAscHd+StLx5QyQuTM?=
 =?us-ascii?Q?CR1RneZqsxD/IxUjObTZA9fG3m8rtBjwkI6JV/WXDs1ugRlWNsiyA3nvmOkH?=
 =?us-ascii?Q?VMx9TqIjNVKI2PwHz9YJ/fOv4tCFKmYBPnl5XBYsUO+t6GBzaBBbncm2qapw?=
 =?us-ascii?Q?AxraT2JiHUcUZN/jT6vWnty8QiSMstjoQ2zwpU/+kney4ibFU+2CYBXa6NLJ?=
 =?us-ascii?Q?1xLC2QE9nU5cqsER7Aq8oZCp2P64zqWGedsEvRxxiBkyur0gGao9ZRVORz2U?=
 =?us-ascii?Q?5LvcCEUoEH+axG6gP0ENNaUm4Ov0kLVWJ8/Ij0wGp2tsRVqRgzG/ep9WHV37?=
 =?us-ascii?Q?sZVa6ybQ2hgTh8LEHUx2z5Zl7hF1CdrlCYu/cmCVIjCm1T+8uFl5iBPmiofR?=
 =?us-ascii?Q?FZa6cySAJyAm67ZZcQFojBhFcJsau4ZgEfd/A4er5lJ24YTqVD6OCmpP0iQq?=
 =?us-ascii?Q?NW5kgvHXGonrKnsz5zDw+0oli5bE5QAg4libY/TPIPcbLdBKmBZrvaBSNe2D?=
 =?us-ascii?Q?6RzAV/hdhGLoWAsogyy/UJrxxiDkm+nRjfeBr6toEAA+zN58bL/m1DECIbc0?=
 =?us-ascii?Q?DtXM9wNo16E9NDlZOa8xAy6HEOVzCXHW2CD8u/B9bQwYv1nVF3dnf67zf5J2?=
 =?us-ascii?Q?FbN8OPQiRTGPiJX4/YmPUelwvRXuO+ziHYIxmQ+Wvuix0tybgLu3qpam5Qcs?=
 =?us-ascii?Q?VRLtsxUDH4iQM4E2qGqc5RpIe9dlyY0MVES4Mt0LtlWPiOA1FDkOMy0I95Tu?=
 =?us-ascii?Q?ZFQXjCaPVlcVhAs8vUOL237F0MzwQOJyB7S1Tg+84czbpWFlCW3w5jPFT3Cw?=
 =?us-ascii?Q?n/mJJiEepa5Kl8ad9kHGX7Oo3LFtGalNaXSwKnKZdYLN2PBlNTeodXqUi+3T?=
 =?us-ascii?Q?Br1EbK2+WnZXz+9R9Ci0U+MVspm8gOc8mIxdeuntDMwV1B4AuWb0qLhmiCMq?=
 =?us-ascii?Q?sbnTInmQYElWLLy3gWdPAHk1Ld1vNWtqfNF/8hLI7D1CR/32rTnG2utcWtEr?=
 =?us-ascii?Q?ZtnmmLdfs7WQubVX1UH/FU+LYn7nEwz4Hs1/5M3b+kPOpVPeGXRnCcHM3pHK?=
 =?us-ascii?Q?vkpWmoiwYVVT5AIgGHOR51+Nu7ziqGFJQ1MG3NczAGXJdF4VXqXE0+ncQfdZ?=
 =?us-ascii?Q?P42xapk57emzVG/seU+aGGtuXMVNecL7OQo9Mh6bZpMClv5VdcKuABvQXWSL?=
 =?us-ascii?Q?2WdFyt9fHNkUAnM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:34:21.6569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db355eb-7f87-439a-a054-08dd49b6198e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427

Currently, only '--json' flag is supported for JSON output in the
ethtool commands.

Add support for the shorter '-j' flag also.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 8a81001..453058d 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6303,7 +6303,7 @@ static int show_usage(struct cmd_context *ctx __maybe_unused)
 	fprintf(stdout, "\n");
 	fprintf(stdout, "FLAGS:\n");
 	fprintf(stdout, "	--debug MASK	turn on debugging messages\n");
-	fprintf(stdout, "	--json		enable JSON output format (not supported by all commands)\n");
+	fprintf(stdout, "	-j|--json	enable JSON output format (not supported by all commands)\n");
 	fprintf(stdout, "	-I|--include-statistics		request device statistics related to the command (not supported by all commands)\n");
 
 	return 0;
@@ -6565,7 +6565,8 @@ int main(int argc, char **argp)
 			argc -= 1;
 			continue;
 		}
-		if (*argp && !strcmp(*argp, "--json")) {
+		if (*argp && (!strcmp(*argp, "--json") ||
+			      !strcmp(*argp, "-j"))) {
 			ctx.json = true;
 			argp += 1;
 			argc -= 1;
-- 
2.47.0


