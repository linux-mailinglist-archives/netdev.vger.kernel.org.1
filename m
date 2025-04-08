Return-Path: <netdev+bounces-180090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35807A7F848
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15DF17ED19
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619A2641DC;
	Tue,  8 Apr 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A5Ot7gPf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C12185B8
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101850; cv=fail; b=CopGykDWakQyVb4lWtBd+Iox0YDuKZe5uZtWxtoZyJk5cgs2YP4s5OUGZUt9nkV1Y5N6bx+ZYmH78258kPwCjH0ZCTbLdQA7W5ghMEt5uasGZpf2dmeKhUPY+229zl5w0eF5cqPwTyPBzFxxhIn//dMfyQDwWyKNKTCwhCdzEOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101850; c=relaxed/simple;
	bh=Q914xT5lyLrfUyqL0PuW0XGmC0tgJfJsgzcCyiVLb84=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GThsA7Zfx4rAWyPU7YUdMBKA+0tekCHPBoHPcYf25yMDeLul98WktHx3t03sjadxnl27cbmlt2UIc9vMhhRDOdFbcU/h8+iZJkfbDsOkNSkj6aIoXj0ylokBkoF8JapYCTrP8yJaYKLHrUQjO3PffQMItqHI6lI4tqFk+D1dyJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A5Ot7gPf; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw5NG26tYzFcGmN+R5iEWDt9IolTSvjWAhffAk5LgYMat0d2dQIQv1n3m9gFHA4dc8nLFRttJdEUb207YDRWMBiVGBFYrKYCaWmjq5oGd15f50iKyje3hIh98tJmVmc2yJvyXBaaJzGuLhPUP3UEOGjXHc73xGGgWY4X2M+JdmsleMkqPOF4tSBDBbUh7cjbn2Xrec+YscQEixa5tqmyubWHS99rXbFB8AnHg2FMtU1iZErm3NsSHuLNPh6AwFjC21Tha5mxaQQoxO6sr2GB3etO34JNEWuuaV+2yCxQfMa1wRpcuI16Ad/uGS0SVdgfFhDQFb9f7C4yRL13K/yjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=676xP3eOakWhCjj5C4zOPBNSuo8ra5/uqkqvqzG6nKc=;
 b=AWrajyopTHCjuogEyGukXyIvjdl2uOoh8PQgMMdGYQ5GJhHMeVbLNNVWNM4jNmY6PzzqpFRlSmMFIJZ+qHZNh2FYWtcgJTDLXitScNra4BG7L35nGTlcFY/++CJnIQ7/gRcRmCL6VDEfgPwMedVs9QkDsKOF2yJsbN+e2By4F1XAJyDAwoXPFe9pvCSxCcD42ky7/U9c57tBxUkL5jWbwcsv8eyxjfbR+m7l/6sTN4FTYcPsCiQR98t6TdE9GfKqn0thBngtPwklhjxHLXm1nuAjRLS91ZwIQIWw8i1GBZcBtHJ45LxbSLPyLT6yWMDWXqIZ//J/ItvKBvQZh5WewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=676xP3eOakWhCjj5C4zOPBNSuo8ra5/uqkqvqzG6nKc=;
 b=A5Ot7gPfWVVfWQeqtaWeyBB7NSzj4uFmPdIECrrivbvXBIlZzGzI1MKi/c2FglMvBarFLJhLZ6rKz7xxsM93A6aD9x0VW0i4A0FhH1tepiytdFNVCH7zyWce7tD/gL6j5Q2NHsOUyxL7WySg++bdSDAmhI68ziwq/kfxWY65Ut3mNMlnMJnGXhry80Y9c4bFAeP/WRQwF8C7ccljhom0kiDWp0Pc9D8a3cncXDcgKBjJ+4gH9+Ln9AFQdyQntNrriIA8thI2YcXLfJFFB8Qa26sxCC1yCA2SNQS24DYKIJ5Oe5T88Dtq/II+Z4gFmDJbXFMWqJYmvi5lf62rP3C0Rw==
Received: from PH8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:2cd::18)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Tue, 8 Apr
 2025 08:44:04 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::91) by PH8PR07CA0019.outlook.office365.com
 (2603:10b6:510:2cd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 08:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 08:44:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 01:43:46 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 01:43:43 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] ipv6: Align behavior across nexthops during path selection
Date: Tue, 8 Apr 2025 11:43:16 +0300
Message-ID: <20250408084316.243559-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 691d5538-0bf9-4c0c-25e7-08dd767983c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKHi7xqNsjkIBvQhUpbkzrwZivMzGIgY8YABKNdWUuxuWOfHQC/HNMBNtZqJ?=
 =?us-ascii?Q?10AE9e2LaCoPa+gT5trDNjcjVACSWkmoe7WaAyNJKJ8xgw/Sbwhr8vTRdqpq?=
 =?us-ascii?Q?4v9t5ek6mcD90asIexVfcMHlFMxXVS+bRVTZM4Pw4cy68nxJj0WQ69aVGib2?=
 =?us-ascii?Q?vFeFzYb8UqGSylbpK8sLMiZrW2AmTvIXTfWoxFFKVUDc0vVPYhbmXa7mTZm8?=
 =?us-ascii?Q?CLiMfHyLFmUxIM8ScPVSbfFWFTpM6DZVORNMabDW37/hfWl/izmh837kSfK5?=
 =?us-ascii?Q?Raqjxoc4IWMgRRPk23Y1I4lBmqCvquRsjQPHHqrv3mKP2+IHRYAYc1c0DZpE?=
 =?us-ascii?Q?gWwWOVm20qMV+d6usLRo5FhkP62UjN5jW6bKoURgAfwswEZXSe5pt/a9m6d8?=
 =?us-ascii?Q?fLxJxyGXvrO23e0CVKHtVlFGe6YP+80F+GwkckTnyJmaIcTCWkCACfR50dBl?=
 =?us-ascii?Q?fV0CzfvBZ+4aFnTUpcOn3wFZPy/D42NnPx4osQY2TsXkc1k7R7B181zw1lyH?=
 =?us-ascii?Q?f2zdATGJ61BW3TEE+jsYGzaoaP06RCHHrnnE729AYvkuToHgMS4R3M3kSgJ4?=
 =?us-ascii?Q?S+cXEMWDYo+5mdPdoj1IdoQbsFiyGEMbwNfygoqbAAGn5QTB7q1La3qj9cqX?=
 =?us-ascii?Q?IcMnxkReyKhYMo92bg4d8iOJZgU8YzqRCEZ3LMQWrcbuhX58K9OUeVnWBf42?=
 =?us-ascii?Q?mDUs1f5SNHNZ7dy934XowmO0dxBq+ba209timZm2HBBKKVgDaGgSK2KNpjrp?=
 =?us-ascii?Q?C0LBNxR/CVmLPdfSZt9mQg44AiNCHUbznMvNA++OKgSvrfP2a6i1cXvo9KDM?=
 =?us-ascii?Q?l7H+Gn1VkJdmPeHvEXEEAg7gYovNmMjbV+Yrj4RYDC28y5WLm2i4/beIM0U7?=
 =?us-ascii?Q?MQ+9wkp4d+jizk2YzHe7WQRbEeL86/rcDwFwXF2H9KiuYL1SLINydKWPxkAd?=
 =?us-ascii?Q?Uo32FZEKtFtgzOGubYyY5Vn6LmQ2lnedTAwjBROVxLa53LsdaaXlF424IqRJ?=
 =?us-ascii?Q?sSnVBAZxDUcT3gYVrZTQajuBbXCY2LzScmfg8GCgzT+Bk6qpKNaeQ5/VUFZY?=
 =?us-ascii?Q?eomYT00R0tepcotPBAwNVhIsKa86EDJ+fBJFgdw0l7BW7A0X4AgA+hFUTX/e?=
 =?us-ascii?Q?2r6N4dK2imTLCPm24Yd7Ojk+1cjdPOQJ/1PpBjyIB8lmQxgeCRmziaJCUtei?=
 =?us-ascii?Q?PWY5yyt21A38kG04rqEb4w+PlWAKWaffKOl8A9yXHnqvepKPxHhmDaGKwsz5?=
 =?us-ascii?Q?xcMDPvlufsf/wiV7ckF6seTZtajaFsiSrNGEXTOKawlBr+oUewAiKAuXmm98?=
 =?us-ascii?Q?QD4CAbhpx74XgvmSLa/xwmH/hS9BYxH3pMUFE642BMvJcFrLHXNOItya368q?=
 =?us-ascii?Q?BC3eThKWNhVRofKLNAFhim/SSjJETYO/aXIEmMeq7Jkk8wfpVXTZkBJ8xeDK?=
 =?us-ascii?Q?q7Dw1ZZO6OQMwVfbMT93al7wwzWok5QRApL4DrzNjOWY2fjGvAjilKCAnh2r?=
 =?us-ascii?Q?HjZzRJ4l/Ou+s8s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:44:02.8797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 691d5538-0bf9-4c0c-25e7-08dd767983c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301

A nexthop is only chosen when the calculated multipath hash falls in the
nexthop's hash region (i.e., the hash is smaller than the nexthop's hash
threshold) and when the nexthop is assigned a non-negative score by
rt6_score_route().

Commit 4d0ab3a6885e ("ipv6: Start path selection from the first
nexthop") introduced an unintentional difference between the first
nexthop and the rest when the score is negative.

When the first nexthop matches, but has a negative score, the code will
currently evaluate subsequent nexthops until one is found with a
non-negative score. On the other hand, when a different nexthop matches,
but has a negative score, the code will fallback to the nexthop with
which the selection started ('match').

Align the behavior across all nexthops and fallback to 'match' when the
first nexthop matches, but has a negative score.

Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
Fixes: 4d0ab3a6885e ("ipv6: Start path selection from the first nexthop")
Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Closes: https://lore.kernel.org/netdev/67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ab12b816ab94..210b84cecc24 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -470,10 +470,10 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		goto out;
 
 	hash = fl6->mp_hash;
-	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
-	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
-			    strict) >= 0) {
-		match = first;
+	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound)) {
+		if (rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
+				    strict) >= 0)
+			match = first;
 		goto out;
 	}
 
-- 
2.49.0


