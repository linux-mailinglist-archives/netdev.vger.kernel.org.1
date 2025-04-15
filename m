Return-Path: <netdev+bounces-182751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE91A89D42
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11353A3BBA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A652951C5;
	Tue, 15 Apr 2025 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZTL0qqk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB552951B2
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719158; cv=fail; b=pk7HT9VQZOS6vVEsXr0Fv+VaPqk+U8dTxbCUSFugZlrJ5N2ECpZFakvp0oVWbOy8FhBuJnGsuj9QxmmAENKeMu0kmWMx/YQugRtOoMWXWJZ+Yt7itRMtcXCrAt4Tls3ys9y+jlmLsqlwh+L295AnfUjPdf7pc8AFKoY6Q9iDFp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719158; c=relaxed/simple;
	bh=cEGMEYyTOsSlnoIK5dIdUERVqKYLkD6ReDGBxtSHRSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7Mt+Q9d2vb/IWEn3trBxV3ZZCeE9opOFmrL/9Gh+VwY5mhNOsSf+HVh3gJk2/gJDwnWNnMMbVmo58qgcXrES1NTtGk+NHoyL1E/xZirbbykJK3ropvrFivYRuAiRuE0HD7WbYngfgc9ZqLTSEhejNpJp1yAGpGHsTSCmmZ/8+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qZTL0qqk; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ86SyjKz5LBOwdLOJOkWfj7kPOImQZZhq01nc7Ih2gyOuWfZseUgajm2/23d5IoEkk+3ZkJTwSU3SC9cSPXMuEN5uM2jSIcPggQHR2IFFS5nQFfhGkz13NIKufdJfjCzGWmXLBpVNWFeGjyiTO7hX7pVdQFAB+QGzojuKpdcJfqZJbV83+dId3hjRg2YTHMRK6TK8prRNSaphnhL7qnFsH4Vwd208NTLUXGNfA5L1AoFY6+8ceuQP/Ms8idNi9btYszNW0CpqAIRj8iyAwvwViXAULsMBjn1oVrSA60v9uU1Z8Q7bMsXbADTjFZ35dGvzqo/zukS/l6YBlN3ofj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtQSPDD6V1JuBuiRxBKRsHwkUr1uJOmEG3fGOTc7YDk=;
 b=duAOS4rxlg3JpoRxVT0aLLHhR5Ek+332PQ6WxQanjyR7DwaTcpvrRwq/1EIG+iGvMhc5NqFsCZ5TnL5oifIk/1TbgBiWBneYrhhubtqVhkbmFxEY/XfSnZb6L8zxRnAxCqtw9tZhpZfEVh+4y2umcLjKIyCIKDsPdvPriaczResPbaGSHqzP0X4oTVjQgHagMO5v0SFMoYEkWWis4VkleWoCa172rDxx2s6KvhRLheu3IIvNBa5+T14bih3WKQnKlTaQwQF3XLKxJS0+Jix4jgJRppInUnKNDy95JhZ9kFXiml2BUvAeomYGkpA2eCrvSz8opmW5Ie6F668E7ldZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtQSPDD6V1JuBuiRxBKRsHwkUr1uJOmEG3fGOTc7YDk=;
 b=qZTL0qqks3EHF3D0abzm46qolp+L9pIb9Td5HMLkAcI0X8ko6fBrisGj9aOkVs5YFGRlSG0kwNGrq1/lDbShyIkShRl6e7pnWjG/vr2z9fTOcCn5syeUG9MWwUwUw0QDNDbM4pGrAM/4fbdBxNIBN0OiWbuA35CNS58SPRj7Lbs1+NBjJadDYrd6YoKPJN67LFmkHbGrfmTobqjcESGYeJlBr50umLyI2nNDrmRVUtd/MITnVLsuA1wFFRZ7QK6r7nQ8TH69IB17c74vZbFxPruYbESV2QwwpZn928Q4MpZ+1Wr0Fn50K+Iaj5qMVdsU9wgdqksVK3H4nKNlOwVc6w==
Received: from BN9PR03CA0211.namprd03.prod.outlook.com (2603:10b6:408:f8::6)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 12:12:34 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::87) by BN9PR03CA0211.outlook.office365.com
 (2603:10b6:408:f8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 12:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:19 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:15 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 05/15] vxlan: Relocate assignment of default remote device
Date: Tue, 15 Apr 2025 15:11:33 +0300
Message-ID: <20250415121143.345227-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7a4b27-3afe-42d2-41ae-08dd7c16cdc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XzgMRU/rL9rtzrwF1xEUYIYlzXwvl5nZl16bqBm8Ef/Hy5gtr+5KDsSMlTCw?=
 =?us-ascii?Q?4bqieNN+KFnrjunGXN+5g6zTb3LbTUCKXIDJw3IIGM0Wf1OyPwJLBXRhnD3l?=
 =?us-ascii?Q?ndNjr2aw2Py1wEtK3pA2nyvv8qTI+gPlyRP+PyYRN40UDR1LcZIBs+ksIohZ?=
 =?us-ascii?Q?5t8JElJdlcDejYG6V3bf1Oup9Bg4/iJoEK3RFXKUq3QLvlUQAKMcpMwTZWuv?=
 =?us-ascii?Q?kz4h90V/AAY9KQbKuk5cdRvX6JFBABQjWRNWcPSpS5jYXjUTq8Yo6DZZLFwL?=
 =?us-ascii?Q?bo0wNC7zvexrYc0zXi5Wen3L3CuTxPJFENsvCPnKEJebLUDKFL7GZGJjdFNv?=
 =?us-ascii?Q?KOr4lpwak4PiHCR01rUx0yjbA6qFMT5Fv6YO5+bGYTmTy0gflxPpsmSslNsC?=
 =?us-ascii?Q?Rzc1gH7tbHoQwKf15RivoYUZ+9AKSy668HfEw0FMSmJDBeY+fUGMCfgpfKpt?=
 =?us-ascii?Q?+RqB9MBznBb7N/xxxMheXeFPb69xLoUNLuevHSpWjvbdqTtKZlN6zei5CEY4?=
 =?us-ascii?Q?JOO5r5AgN58qU+sq8T5MM++9WzPtMj/IijHLmWPjajxJ1N74WixMSJmFDP+g?=
 =?us-ascii?Q?Tz3Ztt7haBMKi2iR/ZlOV7nUeydLvVL0ZTwqmO7mHxNOjyA2SaJ1/u8PKNmC?=
 =?us-ascii?Q?pDh2XI9Pr9uQq3NypWaIz9bjJyPWf3c9bImh706fewaiE0e0xWgcd02rpcdU?=
 =?us-ascii?Q?Em7MvxTd5yOmDu4l2ydf7GASCe12BELeoKmONYNLg/RJ6v6LOnnvWLYGo9JB?=
 =?us-ascii?Q?44ZuKvAMVuPnWFKtoO7sbS5ENmh3JDguoT+GsTBkpbqFlbQly1EN5qR2QFZ5?=
 =?us-ascii?Q?2ErCv4Ohln0yczyY3nBFHom1tkkocqOO1n7jav3rUW0Qa617NtxuI+7rQV5R?=
 =?us-ascii?Q?A5xDx+Zsfy43MJul8sWAyucuajb7Mw+2yyR1HsdafaYBIHUU34+0A3uEOofY?=
 =?us-ascii?Q?oyUvFFY+vxz3xbYaNcQ/oWFTE+Pd+69vsefRsl26NTEhZhZPasyIht+VwlrK?=
 =?us-ascii?Q?Wf50rm2wjyiZZYSpc3KMfOdfHg/mjLJpsTSQIulYBiLjkH+dB7IFXGmE2eho?=
 =?us-ascii?Q?wgNhQ6cQfnO39kaiaoks878fT1YPgIBiWUY6Ngy62WQvMGtyVg4FXNrCCgFq?=
 =?us-ascii?Q?YXHHcK48gW5ajE0WKSVfyJji1Dgj8D/JlG0jKOWaagShpRnewtt0AEEWztJu?=
 =?us-ascii?Q?ORszvuYjtgYBsLbLXksAfLojTqlkp2CN+K98sHPBlqevu32CLVdcZ/TLvgvu?=
 =?us-ascii?Q?JG2DUc5ZvYLBvZWa9k2bZTO3GZZClG12tOrqEidlkSDlD+JRQ/2JE9PZTXIr?=
 =?us-ascii?Q?SS8AE4yyBUD5TQ+rkJXqAyKgS7XnjoYYvHRbd35FBoPBeCpJTCG5K57JFl+k?=
 =?us-ascii?Q?th3u1cfFGIXWzEnhHb0HJbQfjuBf12ZnrOotxAlRWylfIcmo9wYC9YU9MzBD?=
 =?us-ascii?Q?FfQmD3O4lywda0Ff6lnEwM8BCJ5DaD5dBhYcrYFyHU+MIvAiatd/OTb/AH3z?=
 =?us-ascii?Q?fC1L+Iu7GJBOeiuCLHC0B5DNg3YepwrhMgIQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:33.7828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7a4b27-3afe-42d2-41ae-08dd7c16cdc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028

The default FDB entry can be associated with a net device if a physical
device (i.e., 'dev PHYS_DEV') was specified during the creation of the
VXLAN device.

The assignment of the net device pointer to 'dst->remote_dev' logically
belongs in the if block that resolves the pointer from the specified
ifindex, so move it there.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d3dfc4af9556..d45b63180714 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3967,6 +3967,8 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 		err = netdev_upper_dev_link(remote_dev, dev, extack);
 		if (err)
 			goto unregister;
+
+		dst->remote_dev = remote_dev;
 	}
 
 	err = rtnl_configure_link(dev, NULL, 0, NULL);
@@ -3994,8 +3996,7 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	}
 
 	list_add(&vxlan->next, &vn->vxlan_list);
-	if (remote_dev)
-		dst->remote_dev = remote_dev;
+
 	return 0;
 
 unlink:
-- 
2.49.0


