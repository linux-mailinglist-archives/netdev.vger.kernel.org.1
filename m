Return-Path: <netdev+bounces-135514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338B99E2D8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BA11F22718
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158241DDC08;
	Tue, 15 Oct 2024 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LA6vtA5C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3B1BF2B
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984792; cv=fail; b=drIy0qWFlsHh4a1Mrg+1BCFdI4rToTpeSmK10bBuQdT8PRlLd5y/aj7VCIlDuLkSTU0Bl2oq7t4Gz/OyKdFjyUoiyZYZs4PvQJV06nHxcufiMcLkcNxJ4YuVvRe2QVpKxb9wxWB7vIF5Xx9nVFCwLmSUVTk7vertTXTj6T+GBaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984792; c=relaxed/simple;
	bh=Klh9tf+RKnq387o+GTRyyqGKQGIqG+vh/hTTw18ugNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiPF0jEG/mFV73zy9KNF7hFbl6eyL1qwsLehKR9hb6O5MQdf574wItMO9RXNHSrYJgf41JemSiqZiQdkWdymJIUFUGASFJ75xkwhWApCOMOP+qcdVEyHeTA3RhYMaNRzMW+JuPNAi3TixPNDDPBfpw8wstBVEWjXewV0ZrvIUNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LA6vtA5C; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbZZVhX7s4XPkm4BQ9cCXgaxLEXcuy4TPnv6drYGRT+/XyF8LL1nj/StecT69TxflEopzHGJ3RhxZIEJax6zGeOy4NG8/RzVv6yJ5Wf+CpeBNWwk4ohzDgc+r3N9IIcT3CFo6ghL8WIAfHk5P/B9iSgZaxDWASLddX+a242QCW5ZT53aprzY7jAg9eEyXCacEJkv4/zx/tCvNkUp7HJJ1C6d5r8uwMd7yBfylkIIDjYchD8se8Xq5Hr7/zZSrcHebEpGzyt11twkMhYLe4IuhXTb7TM1Apx1bQpMTRn0eIDoEoAbnCMEJLAKPjfWgRnnioJuVOdf53yLkKf5nLutAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/oTl0SYpjh8HWUL4ke9Ao1JPwf/fztrGvApNp5g4OA=;
 b=KpiolyRbfWDfNjTt5kibA3bq5tGYQRlYLbS+p5zGokU5OemYuSb5rVPU5pssFR6izsbc6J6R0itLEA/VFb1SExu1m6KIvgPeAyMf70J8AChmthKMpFDP3D4SUWlKboc0L4HVH5x4dW96zkeioVCY3I5rZNliGYGmLfT5M/Q2jOZT1+2dNqf0Y2F9Q6Zmn15LoIxOZNfXU+5WTsaP4pE1dtp6fYIH58ktL5EEOOrCyG2cWreMMSLS8daDtaXUpm+c3Jo+rKtoZaiC/FFyuBMSSGEoS/ZCMqav6UNc/Ta+rXgTVd+mjhVI8Alb76wp1/mxRu7rDxdinwSJE/M9xkj3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/oTl0SYpjh8HWUL4ke9Ao1JPwf/fztrGvApNp5g4OA=;
 b=LA6vtA5CNYawCmrSy63wJucZnl/0AFJpZdEChhS6QlaypVd5fYWyVHsxiFw5zTVTY/PzsOXxXfpknuq7Ehs7DNOlSsHubi3ANn6c9fclJbpeqfYKE01AQK+bjiqy+pPwky7buKPzcVc66oWg5KoHhelib/ANT8wkUDTDRr4V731DkkTfQ/ta4i/uEpMBJZiEDGApcoDvZGrntwDueQPFSOnJMh63ILuEkn+1QTkpzLF1CPmuEeqLTKtD8xScLf2/eZAAE+Blwq0VM6A01p/LFVLZA2snJidjFAdsGtKdIbpCiG4Bu6tOURIFPGRAJ03D2pQcpTFKOeVmF56W+oWmcg==
Received: from SJ0PR13CA0201.namprd13.prod.outlook.com (2603:10b6:a03:2c3::26)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:33:06 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::17) by SJ0PR13CA0201.outlook.office365.com
 (2603:10b6:a03:2c3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 09:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:33:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:32:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:32:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 02:32:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, kernel test robot <lkp@intel.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 1/8] net/mlx5: HWS, removed wrong access to a number of rules variable
Date: Tue, 15 Oct 2024 12:32:01 +0300
Message-ID: <20241015093208.197603-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241015093208.197603-1-tariqt@nvidia.com>
References: <20241015093208.197603-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 527aee9b-b574-4434-f762-08dcecfc5f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7rewwdozX8cmUNuYCZ7g2zLVvtkmX6+oomzuEFLhRn7UKQFw2YV8P/rxBfZv?=
 =?us-ascii?Q?TMe6Rhb6G7muc4yus+94th3q1qU9V5WHq5iNzpXIDOK+/zBQqkXn2jbMN7RX?=
 =?us-ascii?Q?TphJXOsOuK9HJc5cAJ4dLlZRNhiGRHa98OAV0BqURUNEr6v3bzE/B1KOPdIn?=
 =?us-ascii?Q?q5rnOI7ZVrINwq50EvZJfHGtVRG5yUNnDWknZEvPZg6OrlFhCRzdP0vEjm2X?=
 =?us-ascii?Q?JbcG218LnVY9vopw/RiQ2q7grTsVFSMI9RbxDJivujUQykNTPyilo+nHT9Ev?=
 =?us-ascii?Q?HBERJkCVO1IYfQgOWO4OIIlwLDfa+TngCWsq/ueTGy5+aLpyRqwzUfNQZFO7?=
 =?us-ascii?Q?p+L6Wse4bEs0EhXsTOhotnTLA1Pl09h1/Y/4pyhaKX7gP84NPYCbmktjteld?=
 =?us-ascii?Q?qKTJSMjfwBIOj7uSeracEFUURmz4EKqCBqioHbfmdl2raHwAeKVXSfYnRLdl?=
 =?us-ascii?Q?2IybIEd0IIVayUlB2BE09KmxO2w/d7bqkZcASk06+syyqjh+EYFoB2dHIlrY?=
 =?us-ascii?Q?r1VcPu9+qbJ/F6usVVeqj1EbY1UFq2x9+dicEbLylEyWc0tT+QBuY12dK+00?=
 =?us-ascii?Q?BMuOzbOsuAfcR2PkxJpXQLeOqKf0v8R/l3Vu+WSgCCxi3s/LWaqRRf/RNJpx?=
 =?us-ascii?Q?ei+xA0jWYJoAHPzyeIxNjXCBrfjfyNdkP4ZP6EXd14+Oziz3d3mxklA3PTCV?=
 =?us-ascii?Q?HIKnU6WbcdWFAR/7GPgkYuq0ohRmyXYZ+59urEMs1oBV+iIejMZJQ8Xa7zja?=
 =?us-ascii?Q?nU4kYXmvjW3V87Dbs/+u8qSB/FFaa4xAXp/RPnlm9aFydYSuN4d+eyaXDTXp?=
 =?us-ascii?Q?LN9Mdcu5uWWfq8AJSq9wZk1jSOnNzCCw+E3cWI4+ubbm7UY6kRNrYsSLwp5s?=
 =?us-ascii?Q?rq075iwseZf2VUty6mV9yBqy7bE78RytEox86j0SleHZNjbfbKLeq0nu/sPl?=
 =?us-ascii?Q?fu60LR4zx9MnpAwhWMGR/PwMTrzYHQIp8k5jz/tq/eUM9UCfS/Pz7noTCX0k?=
 =?us-ascii?Q?i/oqslgQLfvGJLagzxUKrxeur+Odw9ilUNecd9s9D855flY/h5lXlFa42W7h?=
 =?us-ascii?Q?cRegX5aJkHE/Pp4vtSOnXFjZ9neMC++gjCTmqCd/yTUwfcxELX/T7/e5MP34?=
 =?us-ascii?Q?0DEWqbOCyJwDkIs0DDrzkNCSOaYUA5HKxVtERAST1Ox5NbA6gijwMXGXLWVo?=
 =?us-ascii?Q?9yufrRdngVX7qSl7r90QHsd5Lcu75q6qviIblsH5VGgvxC40Wz4PtvN/Y30d?=
 =?us-ascii?Q?4ltmfYcGE1410l7IQ++7gDVE4n4V0ZlaPgDPw8lL8rC1va8u5VPgm1QoNljL?=
 =?us-ascii?Q?Nvni+XlEFVppbciejn/Up7Up1p0A/NNW3lmm+5fLWUtbpIjJIJbLTnVCF/Yo?=
 =?us-ascii?Q?zMAXH3EHdMA0LNOCcAVcXcQ6G4X8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:33:05.3850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527aee9b-b574-4434-f762-08dcecfc5f59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Removed wrong access to the num_of_rules field of the matcher.
This is a usual u32 variable, but the access was as if it was atomic.

This fixes the following CI warnings:
  mlx5hws_bwc.c:708:17: warning: large atomic operation may incur significant performance penalty;
  the access size (4 bytes) exceeds the max lock-free size (0 bytes) [-Watomic-alignment]

Fixes: 510f9f61a112 ("net/mlx5: HWS, added API and enabled HWS support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409291101.6NdtMFVC-lkp@intel.com/
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c    | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
index bd52b05db367..8f3a6f9d703d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
@@ -691,7 +691,6 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 static int
 hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	u32 num_of_rules;
 	int ret;
 
 	/* If the current matcher size is already at its max size, we can't
@@ -705,8 +704,7 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 	 * Need to check again if we really need rehash.
 	 * If the reason for rehash was size, but not any more - skip rehash.
 	 */
-	num_of_rules = __atomic_load_n(&bwc_matcher->num_of_rules, __ATOMIC_RELAXED);
-	if (!hws_bwc_matcher_rehash_size_needed(bwc_matcher, num_of_rules))
+	if (!hws_bwc_matcher_rehash_size_needed(bwc_matcher, bwc_matcher->num_of_rules))
 		return 0;
 
 	/* Now we're done all the checking - do the rehash:
-- 
2.44.0


