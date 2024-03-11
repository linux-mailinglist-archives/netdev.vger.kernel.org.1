Return-Path: <netdev+bounces-79223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819E9878568
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094F42828DF
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26FA4B5CD;
	Mon, 11 Mar 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e9PoV60/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4F4AEEF
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174250; cv=fail; b=giAVSVGG0kEXLjsMtoFwAIx1sZi4Fudc28UquFujPvgwwkzbTCTFaG0O8Cx8sWIsrzmIa2h+gQrEHXIYqBlBQGtLeRw9KNEjuwTQYG3gvuyxAAxE/KPtewyF4IX+6h+uu47dqGgc90C0UKWpXcZbiBdUl127Evds7hnDZzUrWoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174250; c=relaxed/simple;
	bh=E5cexZB0C+YzeTco2vJBtv9SJP1ya/Frzy7g5Nj5v0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seGQdIE/OlwADQPZRtpV952ZQXQZXS7zA7CByddnL1i8W2ncZqHf4wpOlqWic+XVP9HS6pMih4nipONu7uoUgjbxFB+veo66C+elR7MChrgNZLOU4sv/+OQPIxhgHZZcHcUti0DRA9b+cnAkQZLOQ4m877PJWNrdlFzCAIG09Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e9PoV60/; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzSt2rFkeFpjsKaXmZ8m6OaC57Pqw5XzuFFBHtjVvxhdNdaP1QmCxcAYm9MTlpM4DTwJttu8wy34nD2XO7iSf0CGr32adKGc+xJwTbWFjH1OMx/3b/Q9jAmZQiWAal2j8n2LNf3ExXKhsobg5jnIpsX/I2HXBVg/bfuLiQLcy1nbvtJjZVOuVT+9iOqMtn77SAzdkUDwW7xtOi98LXziLhKyI3KQ2uBPVbYOU5tvLeCoK4Q7ssnwKbrqY5q71in9Z2pG9PgMOC08lHDhiqk0ZQYx4uPd3P1mfJp83KTONQ7ZQRn35f4camUS8PCuQFMAGs7Ub/U1CrPMA1Vyhme9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV/4rUU4D/DQ5aoxESjWrg4Zzb0FcJaxidPPhg1kF1c=;
 b=K9Gry+6n1HE0oBF93RinSQPcOnMSzCSTsT30z7PM/XSETnGVrWoUB6e0DMXmG7j20SHjnyYb25mD0HF+balzrrBgmxzPRPNX86WJKFrZrQMJFEGVppzWry2/Y03djGKwYNikXiO22l4VWko2l60EeGk3bbm6h+lv7/QGS2BiDEj5P/py4NrLFeXncCPnX1HQAXCynNS+UGaLdCO6sznxLV6mVm+mioac284fMI5JW9nT3wxSpHNLlTUvw++TFNtKJu6kHptLqr97Woeh9qwW4e2p0csUCYpDzO4nPcN18IAmk8lvDU6tNdWtj/COZzA8tSzg32qnrLQGI65fe7cgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV/4rUU4D/DQ5aoxESjWrg4Zzb0FcJaxidPPhg1kF1c=;
 b=e9PoV60/THl8heXmEopokizcohA9Ck2v2fLvsJORoMN0wupUt2X2jmqdUPMSFaY+TfPJQEz6Qj5Jdx/ON4ldh3g/hEFNQsvO3+G8+hvLgukBTlePbvUWikuHkdnsDJfBiwzqr7po8sWIzv18D8StwvEJzDXhXMqQf5V6uS7RCsiTOsfvSmsnSZhc95UxSMy1xmsO+7PHD6jV7bzUut9hodFnAIRGy/jpKqsdj1sUaVkPdio63bpezL1UZmc46z23MMiDyYYTjF0Cnp2YNpvyFiI1F0UwtAWP82P5IQOLddyiNUrMk53eGsstXGNPZD7FEQrH+MzFmcfLq6GnAJdPhA==
Received: from SJ2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:a03:505::11)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:24:05 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::64) by SJ2PR07CA0001.outlook.office365.com
 (2603:10b6:a03:505::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 16:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 16:24:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 09:23:48 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 09:23:45 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 1/4] nexthop: Only parse NHA_OP_FLAGS for get messages that require it
Date: Mon, 11 Mar 2024 18:23:04 +0200
Message-ID: <20240311162307.545385-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311162307.545385-1-idosch@nvidia.com>
References: <20240311162307.545385-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6c072e-4f48-41cb-7962-08dc41e7ab88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V0VR/c6gjS4/MraursVVsqg49NL5UEtgktet/MgMkYr4I7yAI2PlrlBkzgXpuIqEFobV6vYF6WRkjgdKcrZEo+my02HuDLANv3nWEvTqILLYYaMEMBBw1q+vir/7Vzeaxaff6n+PXXVi+WoOaSLoeZw2qbf0q3OY1g7NhOHMHi6wTZU8xe8Zyo0UxVAeb2fsM79/n78Zwlk4xf9alftRyFbfGfjG9V3HYImg0MBpBnLCikAKqudDVXzha2B5FOHkaS8FgUhk7uLiWiM5ZRLcV9kCyQP0Smx04La6toX5Vdb/NoV4rIZq97723garPn4mYYS7lAcO3yyTSUaXI6LsL/BOJZ+fo/ECRJEw9JqW9Yy6m050TnP84FpMz/nMB+V8Q5TSmmLe6DqqAwzimHcI4etQlPLG8srRTGt2KYq8Rp3HCp+wOdM0BEZ2zfuWxwt5OhPu622gkmNGIq81zEPPHVNYH9aGTb7XkGA2DIlGzU97NBYzNLKKPayrKJoMjiJgVbCSAVMRVx+MduanwXkhATsdDvemPtB3S+CIHGvnAUDUD0x6/WvBaQ5Qe1rDnisnHZ5I9tLWIk6vC/JwjJGKRSBVqU63HRMF/PVGDxE+iWkMCMYvK7T7R4oDKVqU69PfQxVqdexKypoxB6zDwf0Ymwlgmjw0k4CKDk+9XY6HxczLEq6XcC1mz3CVWs8DaSTy9uEbP7MkFkGLcrsfCaRFBrLrjw6J8oIgKC4sXcymr1WdWuEdHYX7XgTGBIUkE75v
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:24:04.9616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6c072e-4f48-41cb-7962-08dc41e7ab88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214

The attribute is parsed into 'op_flags' in nh_valid_get_del_req() which
is called from the handlers of three message types: RTM_DELNEXTHOP,
RTM_GETNEXTHOPBUCKET and RTM_GETNEXTHOP. The attribute is only used by
the latter and rejected by the policies of the other two.

Pass 'op_flags' as NULL from the handlers of the other two and only
parse the attribute when the argument is not NULL.

This is a preparation for a subsequent patch.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * New patch

 net/ipv4/nexthop.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 5eb3ba568f4e..03bacf9c0502 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3229,10 +3229,12 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	if (tb[NHA_OP_FLAGS])
-		*op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
-	else
-		*op_flags = 0;
+	if (op_flags) {
+		if (tb[NHA_OP_FLAGS])
+			*op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
+		else
+			*op_flags = 0;
+	}
 
 	return 0;
 }
@@ -3249,7 +3251,6 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 		.portid = NETLINK_CB(skb).portid,
 	};
 	struct nexthop *nh;
-	u32 op_flags;
 	int err;
 	u32 id;
 
@@ -3258,7 +3259,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	err = nh_valid_get_del_req(nlh, tb, &id, &op_flags, extack);
+	err = nh_valid_get_del_req(nlh, tb, &id, NULL, extack);
 	if (err)
 		return err;
 
@@ -3715,7 +3716,6 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 				   struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[NHA_MAX + 1];
-	u32 op_flags;
 	int err;
 
 	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
@@ -3723,7 +3723,7 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	err = nh_valid_get_del_req(nlh, tb, id, &op_flags, extack);
+	err = nh_valid_get_del_req(nlh, tb, id, NULL, extack);
 	if (err)
 		return err;
 
-- 
2.43.0


