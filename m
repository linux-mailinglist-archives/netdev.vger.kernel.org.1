Return-Path: <netdev+bounces-106456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7629166FE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF381F21E9D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B214D6FB;
	Tue, 25 Jun 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kskLnGBV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DC14D452
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317332; cv=fail; b=nmkdbjhSXgj+8fA4QodMYcbTfMFYmDc7rdwPCksIUcGaBto1YmtJZ9/VZ3fNYpW0uvBDSAFIEt3GvSeirLBnK70zguQPAzMCjjtCs48wdk8HxGsdhfO5C6tQq3+P40+WojECvRX/XWMGCYn6ji+w+NkZ6mYRKxsF2/l4JevgSwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317332; c=relaxed/simple;
	bh=IcUaao8c0GOYSZhUvi6y3/my+wvV9HJBUCVrJ4nNsME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KokvjoZNNWxE9Kr/p6OfJRjsJHOQVdwL2nIXoOA4lXYWebHE1t7qwKZO4gK5UNZq60rW2XVMknGuBjf49ZEOdwF9Ju9Kzzo6kDYbDiS4Ffbte8RO5q8Y7OEDHO9gZ2tgyAcvAwqh2JGvhQQyNIjQqPR/yolrq2GU+yLxsCr+dME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kskLnGBV; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewzn7RxCYBPerYCg9HFO7Bz6Jfe23sqJ63eWIZKgsxd9DTS4fBJuZjo81HzJuTQtIJTAGedO+7S3/wsill0Te332yv4H7riQoxmzjujbUX0u33vm97jWlZ4qXzu+HsnBruEWVmJZfIJf5Z6BgKrPrfdLRSOYXt8DMWJLC8m71BBt6L/W/nMMIAlHyuh/Rby7lPEm2xiAEwVPSTbbyacXrW/aQwsvpwTKsdPQy83NBbxTTy0+OsbBnUunR5jmIMlT3Z9BKihpeb36cLv5d33RaRXZnAm9OHWaT/O4mgWAIcn2WeCySI2yA/WlRTmYxtidqYSdpuOHuKuDm30jrkCzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NABsRTiLqv/rsopKvTad4kU0WMyccy2o3BzsvUGhuE=;
 b=S6Yn4cLel1HABTbrj+pWcFtv9+eSMff/9m872DwvErJxEGOCaBoJrvBuh7H2FLgj80Dt/eTx12XEOKREI3dxBm8gyeOpXCe2rroqCuyrCMl3YmZ9G1laAdHlzlxSOvK8hCXxbrkhyXdPbODoqeFgcsntdYHdylB2Y3t4qAEfutnsv+LgZuISaY75fS5++uU88sHwY3oyirkh8qagxdHmOj+ayevzHmDvI2Y6vqL5vUpaz/zdvtgckfAAQ/CD7avPcVdym5auEPnIm+LJOfx8J1yxizUElciydNSR2pAMPz9TrWJbe5zk+S2efE3WECYublCaVJLmrESzFp+RaQEdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NABsRTiLqv/rsopKvTad4kU0WMyccy2o3BzsvUGhuE=;
 b=kskLnGBVp1G4ynUS0z0ulf3eHLNRoxu1yNgEhB/2CdBs4FMjCE9JQsL0X4rIzzOagNbfjmvLn989yAIoGaUlMVwrZMoSPVwT2KQIN+t8gmBpBQghVZlaUUQRSOsLh/em3s2muzQwFHjZ+ruQOtyco1C9bAGnq3wchaqLvh4Yq7YLfyFtw3KTpKq+3I1XgAzZxPVflPRqWGszZfJCaTXNE0WMjshWj7YkMdnKLibaVqYN/AV7SnqOFKfUPTy8MDImY6V/nbgX2TVYToBUtqLvP+eFm/t78Sl5J/E62yVBclEELrV9KOkpd8MPGc3IhZrsrUUyfgddAEeL8Sl9SeBgCQ==
Received: from BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 12:08:47 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::76) by BN9PR03CA0767.outlook.office365.com
 (2603:10b6:408:13a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 12:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 12:08:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 05:08:28 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 05:08:25 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, <netdev@vger.kernel.org>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH RFC net-next 1/4] net: core: page_pool_user: Allow flexibility of 'ifindex' value
Date: Tue, 25 Jun 2024 15:08:04 +0300
Message-ID: <20240625120807.1165581-2-amcohen@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625120807.1165581-1-amcohen@nvidia.com>
References: <20240625120807.1165581-1-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e7ef6f-7394-47a2-eda2-08dc950f917c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q+XdOqe8cuqFlLuVcsmSnTNDEAlAwK3YBEWKW1IfnokUhXtEz9C/GOSDAfQB?=
 =?us-ascii?Q?Y5IcEwDFWpCTKTMHroDB1RQkd8agJabAizIr43fXFSIors/TS97Pd6KWaQYX?=
 =?us-ascii?Q?xGvtIyi9yQqidb/WyzxBdghmCFqLpnl+Z0eUmleRhhW+XnQd7m6/fj3TVxke?=
 =?us-ascii?Q?yVACj7yZ2tLAKFvmCxQ4Z8U6ycb9kKdfyV2/eKd99vjqd65ZT54yWecd4U9X?=
 =?us-ascii?Q?2BNVT6XpeTUAOS4pCu6i8GDuU6DiWAOZJI7Npp1hIBXB9r4aQrfyC9MqnSXU?=
 =?us-ascii?Q?waJFxsnwjfRVIx9aoiRmvAEiWJ6dxni7VDa9MvsjZY1uRJKC9ybcqO5WACQ1?=
 =?us-ascii?Q?XGjoqHa4n0HcO49MmPrhIeqxikJ36H4AEj2sfCEo01fx1LWp/W0QL0I32ySC?=
 =?us-ascii?Q?VjsBYOm4sSnTptQutZHAHOF52ZKMO6YgRPXlxt9kSw802Lx61TIJVKtFgawo?=
 =?us-ascii?Q?dvtv47bvYtW0IVAKKlRMCOGS07m1t00jDem72mgQ83zrY5zhgDlg5OLmNJo6?=
 =?us-ascii?Q?csRCcDSI65x4oKu/VMG2f2VJD0MrYNY4vkSIUxzc2wC6ZGwvmCagVka9a/12?=
 =?us-ascii?Q?2p9Zf9egfvHr4qLj1nh8jpbb870sgBQd5YY4qV3sUfVUJpHEubKtJLnIq9gz?=
 =?us-ascii?Q?WKL6sulcD7u8Ue5DajlQy5I1TW0S4i288lpzVKqwiGvoYjpBNrT3+32XK9xH?=
 =?us-ascii?Q?qaCKuLwCXKinrXSn2YlNA2K2BPnMuVFnNJt+8w2bSzm3aD8uMOafLw/iXPAc?=
 =?us-ascii?Q?gUQGLUjyZNaii3/q4rDB9xV0GaLLVsLbr5dnbHYWDiLtx07zBp9eAZy0ioY6?=
 =?us-ascii?Q?ESPTTMKPhCDeFkVPube0hvUPa+eSpcq/Ss2HMxuBTnWSQMCQv+VF4depPHDv?=
 =?us-ascii?Q?uku60FGqLzMo3yL1MhkzXs5k7waWIf5grVdQuaItcTT7iZdOZ1sGtWqVP0lE?=
 =?us-ascii?Q?/8Gn/FX+yNIv+miz2SzramzcpP+0qxLhEIXsSLJMqsFI5ZksvgVTeFdU3agn?=
 =?us-ascii?Q?QuFZTsezOq6BVbZ5AWf9vNFQiUkHS+Vl/GBtGA2/XVHAIoXkWQ5XlsfavDDC?=
 =?us-ascii?Q?dBFloPW00WKBw0WuZsV2MaVmWEC2xDn7s2Rp5z7ETTzJXG+fA2dEKzNF8n+I?=
 =?us-ascii?Q?QT3LmTj+6+mcIPwL1cuUyRhc+yD1KTOMI2kLguELdOLex5ChutpG8CmOkjkI?=
 =?us-ascii?Q?bUKL7iikXdqC6uKKcobA+J33FLI+y4FmXKJNuJwzplIm0iqn7U81u1ctf9/3?=
 =?us-ascii?Q?AunANRN1ztTF8KfNviGr+s7Dk2WwBqFW0JGLFwYA3Oz1YQBTANkl1bIMYb/X?=
 =?us-ascii?Q?pPeVfDA4NV6s1tyOPsERH+1M/NBVK22DMt1EO9l58n2gtFv7xLbQ7In/YRFp?=
 =?us-ascii?Q?U3z8Nn3vwEwY7CPnukWwussaWwURPaNW2DrFBFYEUKA3LM/eVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:08:47.5668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e7ef6f-7394-47a2-eda2-08dc950f917c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207

Netlink message of page pool query includes 'ifindex'. Currently, this
value is always set to 'pool->slow.netdev->ifindex'. This allows getting
responses only for page pools which holds pointer to real netdevice.

In case that driver does not have 1:1 mapping between page pool and
netdevice, 'pool->slow.netdev->ifindex' will not point to netdevice. That
means that such drivers cannot query page pools info and statistics.

The functions page_pool_nl_stats_fill()/page_pool_nl_fill() get page
pool structure and use 'ifindex' which is stored in the pool to fill
netlink message. Instead, let the callers decide which 'ifindex' should
be used. For now, all the callers pass 'pool->slow.netdev->ifindex', so
there is no behavior change. The next patch will change dump behavior.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 net/core/page_pool_user.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 3a3277ba167b..44948f7b9d68 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -30,7 +30,7 @@ static DEFINE_MUTEX(page_pools_lock);
  */
 
 typedef int (*pp_nl_fill_cb)(struct sk_buff *rsp, const struct page_pool *pool,
-			     const struct genl_info *info);
+			     const struct genl_info *info, int ifindex);
 
 static int
 netdev_nl_page_pool_get_do(struct genl_info *info, u32 id, pp_nl_fill_cb fill)
@@ -53,7 +53,7 @@ netdev_nl_page_pool_get_do(struct genl_info *info, u32 id, pp_nl_fill_cb fill)
 		goto err_unlock;
 	}
 
-	err = fill(rsp, pool, info);
+	err = fill(rsp, pool, info, pool->slow.netdev->ifindex);
 	if (err)
 		goto err_free_msg;
 
@@ -92,7 +92,7 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				continue;
 
 			state->pp_id = pool->user.id;
-			err = fill(skb, pool, info);
+			err = fill(skb, pool, info, pool->slow.netdev->ifindex);
 			if (err)
 				goto out;
 		}
@@ -108,7 +108,7 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 
 static int
 page_pool_nl_stats_fill(struct sk_buff *rsp, const struct page_pool *pool,
-			const struct genl_info *info)
+			const struct genl_info *info, int ifindex)
 {
 #ifdef CONFIG_PAGE_POOL_STATS
 	struct page_pool_stats stats = {};
@@ -125,9 +125,8 @@ page_pool_nl_stats_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	nest = nla_nest_start(rsp, NETDEV_A_PAGE_POOL_STATS_INFO);
 
 	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id) ||
-	    (pool->slow.netdev->ifindex != LOOPBACK_IFINDEX &&
-	     nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
-			 pool->slow.netdev->ifindex)))
+	    (ifindex != LOOPBACK_IFINDEX &&
+	     nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX, ifindex)))
 		goto err_cancel_nest;
 
 	nla_nest_end(rsp, nest);
@@ -210,7 +209,7 @@ int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
 
 static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
-		  const struct genl_info *info)
+		  const struct genl_info *info, int ifindex)
 {
 	size_t inflight, refsz;
 	void *hdr;
@@ -222,9 +221,8 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id))
 		goto err_cancel;
 
-	if (pool->slow.netdev->ifindex != LOOPBACK_IFINDEX &&
-	    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
-			pool->slow.netdev->ifindex))
+	if (ifindex != LOOPBACK_IFINDEX &&
+	    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX, ifindex))
 		goto err_cancel;
 	if (pool->user.napi_id &&
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, pool->user.napi_id))
@@ -271,7 +269,7 @@ static void netdev_nl_page_pool_event(const struct page_pool *pool, u32 cmd)
 	if (!ntf)
 		return;
 
-	if (page_pool_nl_fill(ntf, pool, &info)) {
+	if (page_pool_nl_fill(ntf, pool, &info, pool->slow.netdev->ifindex)) {
 		nlmsg_free(ntf);
 		return;
 	}
-- 
2.45.1


