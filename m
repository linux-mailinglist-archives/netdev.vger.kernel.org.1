Return-Path: <netdev+bounces-78735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2758764A3
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324AD283706
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB1F1BF35;
	Fri,  8 Mar 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2RKCE+E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9F3612C
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902970; cv=fail; b=GAFE9Mr1liUi7m3khDBiI/jJfVQKNgHeuM5lWVyh+YUmqMfT0tC4coilv7wpbnC/wI4KziiDgrgtFD0VIugxA+3HB92k2S3ipsvIPsyy70pBRtzn8qvI4fv11rnA00pPUBwqnjyUu6fpJQzkEL910ttVzUOWYeoOA1LT+U9vVAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902970; c=relaxed/simple;
	bh=Yy0SE5eLrViFgQ9tfi+84Igpfem4F4skyV1OXXIinOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlUyKqJzXnGcKRsxKRzutHasYo0qpHyb5MzXqV9VmPFLW5UMp+4yC7f/ESdQhXxJWS3c/8l0cJtEDF8sTWRHShwe+6vwCBP2bwPbJgBk3o3cb0MSEggLDOsPR/JiPw3ShxaiT4swX+vreFH52oD3ZFI0ivgtJylnFIAXhfGH1Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2RKCE+E; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T23ORuS8UKILTPZknsbGGITHxb24LBwV8A4hLy1ergADMJoZgKTX6IQFJc1mcD7jzWlURSZjKEEVi0r4O5ByI+kGKvdsDPw5/JonjnNvH7pQ158K0BHmTNHQtK1tTTf8dgTu25io2TnSytq2bm5dwdIncNMsNyVB5i8uyskIjbeiQ/2eNScp0y/YEJJmFdW9pcE0qMpFypSAUL6gFtssaTlU7x8bEgQN7leQFjE4ZDN06y1aSwBHmaWHoOg+T+zIfCzmb6Sa1Cc8NKSMe6VSvw5jaVnaEVl1b0sKeUCSmvam4MpPci3Z4f3XLYbN/46EkuW2LvPr7xe8/laduoorYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukZ58s0eVRJRgE5LujwzACj8LcjSHw06uWEYQoS2+T4=;
 b=H6GB7EQRM70+wxWloaBjUNMkuy99ze/NopnYBgqCNKcLKt/S2mVoRdCxmE1zKtaqQgbba+JK6u1yZE1cbnTZEU+jvzYtoOj479MYnCYu/5BOyDpRsyEIKO4bltdB3Y7/516L+RHS2crmtUoqIjI/d/YNZWvF2XqxLIAcYqlhOU2m/liTsvWxA4wrn3N7qnfs4U570nGNm3mvHYxlNoGYcp4l2c8BCK78IxgdF8TSjoYs+aP849QTKg1eJlmdPChOfAA92jF+rbmRvQCD7TmMCUJvuj7XLa4MlJJ5/my+TevJ8QFmGEx1rpZmW7KsbP4dNOWBbF44sEBunsKH6ah91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukZ58s0eVRJRgE5LujwzACj8LcjSHw06uWEYQoS2+T4=;
 b=F2RKCE+ESsLbFbAb1UM5bGWLI9zCFIoEx3hhR2n4zHTlRGbYT2naDxZ2ceY9Jq3Tztpp/gA5mjCDSb+8bm+4SkPrV8ler3lsHgVTUtqBv3ZjvmHL5aMCcxZr99DIIivA3i/xpBixlBqexaqZkvkR7+wKKlRT1GRCfmKEhhS8W7h5mGEUJbuqokokcWHnITtMCG2rgsjFAeC7pxKoKhUSiBx4sDJ93VGo0kKFFPCQ88lKK7Zp6jjriKnMgAOQ8LsJKd1MRVFOkz6GmN7SrMyK0wv8Nm8JoDR5wD+in62NT+cMh+iQvPXdfTT6sZV0KZwaDlRPuIpXEuGwVcbaDIzPWQ==
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 13:02:44 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::ea) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 13:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:02:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:02:27 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:22 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 02/11] net: nexthop: Have all NH notifiers carry NH ID
Date: Fri, 8 Mar 2024 13:59:46 +0100
Message-ID: <8f964cd50b1a56d3606ce7ab4c50354ae019c43b.1709901020.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709901020.git.petrm@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a37a64-23ad-4ab3-375a-08dc3f700b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4mnTlfxzQY+wPQCh2AxXCUrlo8I5xWNbAu6N6I977VRxqqeZg8fq7AR6qBZRU9QfXcAeBCfUJi4UDPYtaCEMkQEnmjCLv8gKPaHnC1E8R1MsePFCXuBabgvALXe5jSNjFGOiZrUPopij4vdvD5GT6rpCboJX7Ppz2LxXhORWo4IHPCy5PZIh3EV3yZoOfjrb2dv6KRhkvhymWN8Opp4hk/ZpsQY0clIMDHoSCju/AhpR0OOgRPRcFsEwu1ErSaoH00C70Kc8WE44o13RoYPbXoQJu0a1PKF6utxhY6lHIR0+gSYpzPDKM7wE30hyikjqKs7x9bUsCIcJ1ayY7bMpK+x+pzgfSW/snJShqwjb5T8gO1LTIuncWyUAInKQ/D0TkG8lOeGSw15mIBXCfoJQTEW+gausFOd6zcUHltiDZQeduxMlychpYOwe9A2ozluPWodk/S4VgUoSi+p3s+dYCNdyMLpPmU1n8h4bGEofksyHKGFkoEZNmKXMp2pB7QqH1D8X4zey9O3l/bpdHzeZqqer9FO01OaPo+7P2vKtRqfdUiebsgARrV2wSHe55rVWbaToDVUN4NqPlITvzi38jbnqzkFHwpTOsyYfDwEmXFePsCTQFg9jnldcCUXxd0UTm92MtukAcCaA9hlXtHzLLJsGgAMGD44mSLeqrMmTncyndkf4y2PBVmHD9qP6wlvWgvAkTyJi/0paJirPXwCjB5EfbnZwM8gRabywW2Kp4MD4LEDpkOT+3EXcgDU/luen
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:02:43.7186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a37a64-23ad-4ab3-375a-08dc3f700b52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973

When sending the notifications to collect NH statistics for resilient
groups, the driver will need to know the nexthop IDs in individual buckets
to look up the right counter. To that end, move the nexthop ID from struct
nh_notifier_grp_entry_info to nh_notifier_single_info.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/nexthop.h | 2 +-
 net/ipv4/nexthop.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 7ec9cc80f11c..7ca315ad500e 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -185,6 +185,7 @@ struct nh_notifier_single_info {
 		__be32 ipv4;
 		struct in6_addr ipv6;
 	};
+	u32 id;
 	u8 is_reject:1,
 	   is_fdb:1,
 	   has_encap:1;
@@ -192,7 +193,6 @@ struct nh_notifier_single_info {
 
 struct nh_notifier_grp_entry_info {
 	u8 weight;
-	u32 id;
 	struct nh_notifier_single_info nh;
 };
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 0548d1b46708..5d09270359b1 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -104,6 +104,7 @@ __nh_notifier_single_info_init(struct nh_notifier_single_info *nh_info,
 	else if (nh_info->gw_family == AF_INET6)
 		nh_info->ipv6 = nhi->fib_nhc.nhc_gw.ipv6;
 
+	nh_info->id = nhi->nh_parent->id;
 	nh_info->is_reject = nhi->reject_nh;
 	nh_info->is_fdb = nhi->fdb_nh;
 	nh_info->has_encap = !!nhi->fib_nhc.nhc_lwtstate;
@@ -150,7 +151,6 @@ static int nh_notifier_mpath_info_init(struct nh_notifier_info *info,
 		struct nh_info *nhi;
 
 		nhi = rtnl_dereference(nhge->nh->nh_info);
-		info->nh_grp->nh_entries[i].id = nhge->nh->id;
 		info->nh_grp->nh_entries[i].weight = nhge->weight;
 		__nh_notifier_single_info_init(&info->nh_grp->nh_entries[i].nh,
 					       nhi);
-- 
2.43.0


