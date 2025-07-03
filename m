Return-Path: <netdev+bounces-203712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C779BAF6D58
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01064E8888
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ECA2D29C6;
	Thu,  3 Jul 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TcxPbslV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368E2D29C4
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532361; cv=fail; b=i5XgiGSS3sqLBd2fbLvrD9ovai+njs4hYRJd7kxzM4t0lVyJqz4nkFlQ+NzKMm1lNwdNkHl+C8oQv8LrWJHd0A6JT6vy31S+Ki82l8TXlOHtL0fDxnZLRzmhVeeU5HtZlzrCJHFoDoZMGX+pRptUfxF2R2afvRrSH7/y50QLFcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532361; c=relaxed/simple;
	bh=d7Ss1/rXgoZXB2MjDPvU8EbFLuChBPeAOnc+YCgBp50=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dKhvuMpaovNVK85Mj1TxmaGPi9ibNY5zAgF+fhwNYxC0IglqwFQM+ztuDfyU9uGt/ZvPgz+a//xxc5vE8nf6+B2sqJkTGUsQUZyZYcZod1/+0gQjmBWyCd/K0JN/2YPu/MfY8kKUlXLFa6jPgQCu6bOvVuqUGZcQvN21Ek6IBfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TcxPbslV; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZTZsUQA21HcVxK9p8+b69/Bgmjck/qCmIbYOP+l9Ri0hA5jzyOvoGfsV2ar1bvYPbDEBAqReLFVv41xmdB3IhSLsNtX1h/FeMBdbUi9ODf7Rgg4NWJJaw5sqsoanh2HjiPe556LoHA+/dxIaEiAQCguLt/GwBDnfX1KzyoCNKzbNsh544RvxAQJVOPkzCM7I1hyCDPalAXDA85zCB7dT1hAEPEHZZ9hR9LPKFbY5iJqZROCDIUcetGamtpQugheha94zLdM1pHVUKDKS9OueD4hfExTOlaoH0x9C6EHMgrmuA1Xb2rf331zYAoPMDEXmgJ9oxn7roKU6WM4cH9rSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgJMBZ7o7P9aro1CQOulOzlD18FLBtc88EiU3J1uj10=;
 b=wbLx1IjNkcOoOOV1Y+8sBWJBtJU7ZPYQHQVq1138+pW1ymxJIqz3if6Zx0ko9UfZX1E9Ev8+lEoG82gzSqu/512eUY8W4cLV6WN8yA8Y7ZbhHDBX84ro6urmbnHPCq6qo7R3bVGCHMRID5Zm9SF1Walk+/KrBUZKxltRt+7qZ4/P5/OyRV0uNaHtcZU8MBlbn2SKScE9r2MECcTg7BAAFOYOzvp/URWfq8iTYeHszRgcqtDeak8KICJejWdLineBsIhDla6opTmo42/vPYhOtlSulG2DeE0Z7o7/zmRgxz/shj+SqnYHS4Nv2KiN5ta2tN3Sgv08FLDz6Y8zQCKVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgJMBZ7o7P9aro1CQOulOzlD18FLBtc88EiU3J1uj10=;
 b=TcxPbslV1vo508S8RVqCWVqLt6Pvq3T6LT3aZZVBHjvX+7bxFTjPsmIudFwGdTRmpotN3Bvl6cet2aGYPpYuZPlGebpoc+RS4djjHS6fUJOXtDFrop1vKmm8cPj4Ih5uk6Kf4cEFCd9yo7uZzX0G8oViJDI3+LCR9fJWuS9QFLAGtrFo0S3MSPaiRZCXssQOvreVntLlF4zWAv9zZsJv2NcBLmbdFGpQXoGLmtpGsMEteYUPoMubaHFiqOT9z3R+8HcPPHmrLosCYMTxPq4Aa7vJtTRNhNoILT3unmQUXes2wIA2yqmSZCaGsAhQe9V6dEiZsmJs/OfAEeTqcRTSmQ==
Received: from DM6PR06CA0066.namprd06.prod.outlook.com (2603:10b6:5:54::43) by
 DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.22; Thu, 3 Jul 2025 08:45:57 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::b2) by DM6PR06CA0066.outlook.office365.com
 (2603:10b6:5:54::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 08:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 08:45:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 01:45:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 3 Jul 2025 01:45:47 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 3 Jul 2025 01:45:44 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] xfrm: Skip redundant statistics update for crypto offload
Date: Thu, 3 Jul 2025 11:45:27 +0300
Message-ID: <20250703084528.9517-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM4PR12MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: f990752a-252c-4fbd-80ef-08ddba0e0744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BDmQLbXoX2p8iSZjZjtxsqw2Y9Hz31rwNJFUyA20zfqiTjwXP3nZklf1Gwaj?=
 =?us-ascii?Q?G0jddci03l9crIBYOA7KN4jDfaXHGY7FHWA/NmjYpk+fx9iXHSOKGLrUqZOE?=
 =?us-ascii?Q?pPI+SBZjZjom9YiMewRZUM+95OuFZIsh8FG6faSNRTTtqoaQahil6YFfCYr/?=
 =?us-ascii?Q?zX+3mH/JXZek88UNfH4hv/tnd6Aq8CIolb2nCBIULdqEM5w6r2tLVTjy9aT0?=
 =?us-ascii?Q?700oDonySR0LqeVqmys2kMP3ABtAaCtpLlcKJ711XVmWbCmlLLoGt9PuXhQ0?=
 =?us-ascii?Q?4ozjhwW3eCEtAxJmrgLLciy6XwPOgwxhP7dVBE2p1wuytV3DjjLG/1O1Yj9j?=
 =?us-ascii?Q?2XfylZMvb53o1jkxySPszxXKjd/hn2zmtJaBX+5i2Ii0GPJDjUTP7/vR4bxa?=
 =?us-ascii?Q?4pUREG6eMQGZafKxmlDuNsc+vkWWhKsZmH+JAeA4o77pjqvkVzwSEZUQxDEW?=
 =?us-ascii?Q?mHvv6CnDpHwEFU9g9/El6nRsUpu9xBmogY6iUfYKh2ZOMH64TjZiPX0mR+Bl?=
 =?us-ascii?Q?/bHXPqZums64w3i+exnD4xZmVSLr/igxL4OdcO0Aak2T9PdpfbMRgx9CeWCF?=
 =?us-ascii?Q?XzhjJ6NJN+b6BAF7MEX/TojfZAJdekUGBsg/FVHqKdz0c8Ne6+4dD8k4JuXZ?=
 =?us-ascii?Q?CMSwytLgUif5rK+ZCPQqWdJhHjSQsdAmk9qwCZzuPiTez+AIDHpYoEdfHuZ2?=
 =?us-ascii?Q?oh5OcSKq9h6W3g70pNLKrgqK4TNDJF9FxKxhbgH3RHXrc1Z0Vi48ReKhmRjV?=
 =?us-ascii?Q?qLA8g24MIKpDtGWhZMYPrsbSSGN1uiaKKUAoQ6EsdQQ/AJ5fnydobV/xSuI0?=
 =?us-ascii?Q?YHytQSCU8DQxgxJQNPalbJfZ7N7AUzzgJPj7kYtlGMYRKRyEmrtGPtoORjn3?=
 =?us-ascii?Q?PCogh+hzpMJH6hXzPZpNDzVT2+kQFvE3XflO+8XTi3bHSTi3m/uJiZNTGo83?=
 =?us-ascii?Q?x9x7myQpitg77iYtAr54+xAxtzXZMQitczl+Cbf5fMoCFOwq+G1Eh+l+5Kwp?=
 =?us-ascii?Q?QrbpTbchWJ004wiwI/GPpL+hgld8+cXRFS0Wr0EZ9+1K+m17d1F550UpPsNg?=
 =?us-ascii?Q?e2RchmmZNzUhd7mijRLslzj2dm1o98zWdn+n7GFt2ti3BFRxdaz17So1Ek9o?=
 =?us-ascii?Q?0K7kFeeoTqO7PxA9SgYkRfIMpaTX8iLgp/5Nk2AGFjWru7x55GA078u8J9Jp?=
 =?us-ascii?Q?n/jXFhyYTWjtieHvzfpDPmMeV5ki85uw9l1ZHYIsJIoc5damY/PIq86L2p02?=
 =?us-ascii?Q?kH99oejgGHtk4OnITdo5gOB2F4BSa4XPhec4FCNStZzECKLG3ZL1uzCBfTqY?=
 =?us-ascii?Q?t7LNQlN35jMdNJJYekdXVGB+S2UZI9fYTgZFVvtHWpiThccwJS4tMkq45q4N?=
 =?us-ascii?Q?c9Kc+5WcSwQpW4+p6NePoT0oQCD1/Q+uZhTCa4/AbR26ia2qvvoDtMUwwdhy?=
 =?us-ascii?Q?JxmC5+A/AADHLtuI2VNIBWtFtULGjUolpuATr4srxp/xNN9bx0Dti18RS7RA?=
 =?us-ascii?Q?fZdOvjczGsC0men+WMUQgV9B+LbYvBVx07/Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:45:56.9368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f990752a-252c-4fbd-80ef-08ddba0e0744
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9734

In the crypto offload path, every packet is still processed by the
software stack. The state's statistics required for the expiration
check are being updated in software.

However, the code also calls xfrm_dev_state_update_stats(), which
triggers a query to the hardware device to fetch statistics. This
hardware query is redundant and introduces unnecessary performance
overhead.

Skip this call when it's crypto offload (not packet offload) to avoid
the unnecessary hardware access, thereby improving performance.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 203b585c2ae2..b8b97798c504 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2262,7 +2262,12 @@ EXPORT_SYMBOL(xfrm_state_update);
 
 int xfrm_state_check_expire(struct xfrm_state *x)
 {
-	xfrm_dev_state_update_stats(x);
+	/* All counters which are needed to decide if state is expired
+	 * are handled by SW for non-packet offload modes. Simply skip
+	 * the following update and save extra boilerplate in drivers.
+	 */
+	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
+		xfrm_dev_state_update_stats(x);
 
 	if (!READ_ONCE(x->curlft.use_time))
 		WRITE_ONCE(x->curlft.use_time, ktime_get_real_seconds());
-- 
2.38.1


