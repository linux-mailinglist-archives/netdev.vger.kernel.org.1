Return-Path: <netdev+bounces-224298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49A4B83956
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82519622C78
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360792F532E;
	Thu, 18 Sep 2025 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KuZIIZom"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD22F068E;
	Thu, 18 Sep 2025 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185332; cv=fail; b=jjLZ8IKPhi+HwcfWJlasgOvQvudC/Mb0hFa7/dEtCZh5rZTaqHV7RMhu+ufDcGRqPyTYk6oKWsc+3jbf56Lz6GYcAiOXTQIQ+WX894ny02t3/t0urGjIIY+Bal69daGrUiHs6zYxjUkMDJSDyln8/0luiL2awoIS6fgaIs511co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185332; c=relaxed/simple;
	bh=eIiM5A1KWARHIdjG6sc8BZ6v/aDDD6aljyd4Yuc1tM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZpDca4v2YlcNc4H9CRRhGhqigian45SOFIINHkiHgBTUwdvof6Ed6bs5FNvX4D7+3+l6D/ClQVHzzwIGp0LQdo0O/lF6gXnsG6r+OTDcwHLeLjF1ftu/DPtltdT3ZW/AeVi1g9REgg/zTQ+G2mhsfj0LfFY8g9Ntd4BcF7lxXcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KuZIIZom; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4JyqUZ4NEGR2VqtWGlQEZaVZiiAldmlXsxDthMWEUxPXpWPtE+6LocxRsp6DIPXU6d3WwhE6+h/b+MdlkV8uY8oCJsKJ12eAtQaBaSChMRB5TXsYppb2zYQki0GYo6/ZQrf66OSC55fM5qEKO9rhAifsz3SQCyNCfwJUGzHDb3cgPrN3VTsUZVQp2y69WyXBe/dv80BJLGa7qfUF2+B3x/BMW7k9ibnsCRehP5Pcx3YHkWR8voUaMVwcGTqegZJNavfF5qnPVUbu8UVRt6bLOOcXStPZOS1FhMkf/M+0KAuiFUmyk+QpMVywimtWONRDTGss1AaOddjvShN6l1dLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crtRxZErWm0Z5v3iE48VKm4VdbMl2/vmaGPzY3uaY8Y=;
 b=lAhNkUysjJIEMnVpdTfupaT/sd1181ZwIZgmBFK3v6qAXKar33uW57h526bvZcto57kTz7Y7xFu8ovv6lcR2Yx3opQkwuEcDCu7cVZtFAthWPmPyKa6xPrds9zS0UF6jjX+bCjX1yxf0g7g2PwhRdH3gTvOwqkSi2gYEwCsmLt7wk5HJ5kcA/q0qTGza4u0d/8nf3KDLLKcztrPeG0b1tDrTJFyNQEI90NOGXh0SL6x42+9r1DUqV4L3NLs5T1nUBuI6Dde39BZXqsOhZgRINXlqablVYFFVFacWU/b8kYfR/8N8S0Xmfu0Fs8n+aCwapDqm+3NYCix9WQtFm29j3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crtRxZErWm0Z5v3iE48VKm4VdbMl2/vmaGPzY3uaY8Y=;
 b=KuZIIZomXhMCwZjfrii/9IPeZlmUC69fpiY75Ymo1p3duYgZdsOQlkDYxB1V9+BLMT/uujRvpSrRhfbfBldiJLzO1iDGIHZ2PdTM0NARBKeeypQTGhGn0pDF3USM8xztBFLb15G4JYBBNoPk2mgEPOrkN47QcfPdgu22xevzmfwGZBbbLK4uih7CXHwUd+lb/UiWgt14ZBnpgF8iFIcrjQJVBFlisb/t7QY+zc6od3MOnCwRsm3DpLnPPzw2QOEVp0QqCq1ypLUE1THtemBBX7xmsaJ3BMMHXDQ4xK8iJtC+3swvpDhB9xEQsTUB9S5RjqSRWQJfyV8P3k9eTH9kEQ==
Received: from BN9PR03CA0125.namprd03.prod.outlook.com (2603:10b6:408:fe::10)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 08:48:45 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::69) by BN9PR03CA0125.outlook.office365.com
 (2603:10b6:408:fe::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Thu,
 18 Sep 2025 08:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:48:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 01:48:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 01:48:28 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Thu, 18 Sep 2025 01:48:25 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <netdev@vger.kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
Subject: [PATCH net-next] page_pool: add debug for release to cache from wrong CPU
Date: Thu, 18 Sep 2025 11:48:21 +0300
Message-ID: <20250918084823.372000-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b3f813-7cee-4607-7a57-08ddf6902d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JMHFI1X6x9VNVAgfZh+qFL0Svhug+y2FmtZbdx+MdC9xRLeUOJxOapUduoCu?=
 =?us-ascii?Q?Pc71siQjXpTD95A+xLE3hfVIKYb3Ey21e/7H8O0S0yG/x9dqDDtgprR4umm3?=
 =?us-ascii?Q?01vLKjhHQk1sOdhYjQIkC0fuQ+SawE3fcki1gtCE5EGVXsRx0nwn02XaVj8e?=
 =?us-ascii?Q?kPGYou7BrOoVukhr+oiHLRtfVyJmAMcTvBOkZveYvw6qQYpMCIze2vV2m6OM?=
 =?us-ascii?Q?TAtHHrgDUEmZeWSj3dfh+GjLffF6+Ycn3mvQwHAjuiMCfoeFt89+KNZADCv/?=
 =?us-ascii?Q?YfATamBm1FkUI62vhm1x8lAxp9BKjuhggsBJp5+HqW1RmPmCk5MFKZ9WCNBd?=
 =?us-ascii?Q?OUiDaVihLL5sph4Mzwj3lgjmEsu8ycOF0Luba5pOSc+99uqjPN/ilRDV9oQA?=
 =?us-ascii?Q?9xSWERRzpsGzb318pT5NnEgPZWGLu7l3Y88m2Mu+CzXgFm3IZgjnTxfbUkd4?=
 =?us-ascii?Q?eXiIGkbgltfqkichtCtj4Ybb/6aBP8a9vFDHYoZJEfGYiO7aDzOjnk53MeFI?=
 =?us-ascii?Q?AnV8Wz/jS7U5MicXE/g8HoUwz9c/6EFDAILrBlXu/1iwCWRjdZ29VoV3fUdw?=
 =?us-ascii?Q?tye3480EbgT5RgbdrxHM9kcvFMx/viy8VxQrQrhO1Dz6v0+HzDTuYnH4+Ago?=
 =?us-ascii?Q?8FawdFnWD+dVatE6MO3A6Rl3Ob5FAS1wHAKt/XNQojyyFN0bIhQqsKheBLVg?=
 =?us-ascii?Q?mhsbXYusA1Leug1B2XUb3AdNPQzKT7alObbSZHeVNQ00M1/GnzM4fc2vjqfg?=
 =?us-ascii?Q?Z9pDGzSJOHLZbtTRb+AvCi17qQ/6sSC9wEX5LJ4SqxcJdm2XR+ROljN3X3Qq?=
 =?us-ascii?Q?B3GuoSWV7jK1SkMLq4ktQLLCh3nQd9sO1eXN0KEQ0WqzIR6ZIX9oKxPKD0Fk?=
 =?us-ascii?Q?SIa9uJdVggUBlxCaYNsMWZFm7/AEnwW8vY+o3QswwFJM/YCsAt7u4VSgd0xL?=
 =?us-ascii?Q?UEl5ChSNSj+8JquVNOy80JJ0RrK1y0hJPvXj7Kk0dvFZQHZdskEWmUF56opn?=
 =?us-ascii?Q?CgMmmq0bt/n5Jn9DobYGqG8Qna4huYCXLCn7/poZTvlZUavjst99Q3emqPwv?=
 =?us-ascii?Q?numo8fYmoxmMVSs0CRqJmJSgI17bgBFloJduBZoIwznkh2b0Irj+dG3f2EJo?=
 =?us-ascii?Q?TkPOtFUmQ4+QXYxUWab7EsewLFgmTkQ1PV6tlZY/MfqXMcNd0IxP6lwtZcTD?=
 =?us-ascii?Q?5Hfq0eU+SmG94jkQbQq3X8Rsug97t3+ANJVlYFxzrzYK3nG1BkvK3yXcfYcx?=
 =?us-ascii?Q?BfplYA2hFZ72ivU6/DKvuqbUoxQdItBBPbdz8Pm9nNzd21vJzlZE+wizYPv4?=
 =?us-ascii?Q?9EecDORNOvBDVRANybnMK44S733jAuN7SjmXFSH4SaFQ6RD7sbEfXxl1r2HE?=
 =?us-ascii?Q?A2ul4AkirC2XxtJysf0UXJvNZMC8shphtt1jLyEuVIW84KxFwt03doWQMLZo?=
 =?us-ascii?Q?hK3mJJNIheJWGeFDW5Wc7+BH9B7aHp2iy0IpiBxNuaVghVPhhr29SEx8z3fJ?=
 =?us-ascii?Q?fO6hyqgdOUKzn0hywM7z/cql21qjpTl/3SnsUsxqJDi2qSBpgvD2JeXcnQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:48:45.5333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b3f813-7cee-4607-7a57-08ddf6902d99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

Direct page releases to cache must be done on the same CPU as where NAPI
is running. Not doing so results in races that are quite difficult to
debug.

This change adds a debug configuration which issues a warning when
such buggy behaviour is encountered.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/Kconfig.debug    | 10 +++++++
 net/core/page_pool.c | 66 ++++++++++++++++++++++++++------------------
 2 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/net/Kconfig.debug b/net/Kconfig.debug
index 277fab8c4d77..7cd417fabbdc 100644
--- a/net/Kconfig.debug
+++ b/net/Kconfig.debug
@@ -39,3 +39,13 @@ config DEBUG_NET_SMALL_RTNL
 
 	  Once the conversion completes, rtnl_lock() will be removed
 	  and rtnetlink will gain per-netns scalability.
+
+config DEBUG_PAGE_POOL_CACHE_RELEASE
+	bool "Debug page releases into page_pool cache"
+	depends on DEBUG_KERNEL && NET && PAGE_POOL
+	help
+	  Enable debugging feature to track page releases to the
+	  page_pool cache from incorrect CPUs.
+
+	  This makes it easier to track races related to this incorrect
+	  usage of the page_pool API.
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ba70569bd4b0..404064d893d6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -755,6 +755,33 @@ static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
 	return ret;
 }
 
+static bool page_pool_napi_local(const struct page_pool *pool)
+{
+	const struct napi_struct *napi;
+	u32 cpuid;
+
+	/* On PREEMPT_RT the softirq can be preempted by the consumer */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return false;
+
+	if (unlikely(!in_softirq()))
+		return false;
+
+	/* Allow direct recycle if we have reasons to believe that we are
+	 * in the same context as the consumer would run, so there's
+	 * no possible race.
+	 * __page_pool_put_page() makes sure we're not in hardirq context
+	 * and interrupts are enabled prior to accessing the cache.
+	 */
+	cpuid = smp_processor_id();
+	if (READ_ONCE(pool->cpuid) == cpuid)
+		return true;
+
+	napi = READ_ONCE(pool->p.napi);
+
+	return napi && READ_ONCE(napi->list_owner) == cpuid;
+}
+
 /* Only allow direct recycling in special circumstances, into the
  * alloc side cache.  E.g. during RX-NAPI processing for XDP_DROP use-case.
  *
@@ -768,6 +795,18 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
 		return false;
 	}
 
+#ifdef CONFIG_DEBUG_PAGE_POOL_CACHE_RELEASE
+	if (unlikely(!page_pool_napi_local(pool))) {
+		u32 pp_cpuid = READ_ONCE(pool->cpuid);
+		u32 cpuid = smp_processor_id();
+
+		WARN_RATELIMIT(1, "page_pool %d: direct page release from wrong CPU %d, expected CPU %d",
+			       pool->user.id, cpuid, pp_cpuid);
+
+		return false;
+	}
+#endif
+
 	/* Caller MUST have verified/know (page_ref_count(page) == 1) */
 	pool->alloc.cache[pool->alloc.count++] = netmem;
 	recycle_stat_inc(pool, cached);
@@ -833,33 +872,6 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	return 0;
 }
 
-static bool page_pool_napi_local(const struct page_pool *pool)
-{
-	const struct napi_struct *napi;
-	u32 cpuid;
-
-	/* On PREEMPT_RT the softirq can be preempted by the consumer */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		return false;
-
-	if (unlikely(!in_softirq()))
-		return false;
-
-	/* Allow direct recycle if we have reasons to believe that we are
-	 * in the same context as the consumer would run, so there's
-	 * no possible race.
-	 * __page_pool_put_page() makes sure we're not in hardirq context
-	 * and interrupts are enabled prior to accessing the cache.
-	 */
-	cpuid = smp_processor_id();
-	if (READ_ONCE(pool->cpuid) == cpuid)
-		return true;
-
-	napi = READ_ONCE(pool->p.napi);
-
-	return napi && READ_ONCE(napi->list_owner) == cpuid;
-}
-
 void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 				  unsigned int dma_sync_size, bool allow_direct)
 {
-- 
2.48.1


