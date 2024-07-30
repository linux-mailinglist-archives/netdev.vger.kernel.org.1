Return-Path: <netdev+bounces-113990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE65940836
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CED4B225AE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6A418E758;
	Tue, 30 Jul 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FN99mR3e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5418FDD7
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320332; cv=fail; b=cXIZWAuQ3x6yvVjwuEzJKdqFrXnKPB9DiND0PjtEfKmQB68GEMB0WfAZnzxuxkpmVDPzxGHh0uqtVpp6gMSBy8kUwyQeiwI0vFREVlE3XKNFC7KTX0vfliM81wA8uAQSvuCkBqbUMY4sNKw631Fd1cfSxB0vmVVZJ/PF3QnnR5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320332; c=relaxed/simple;
	bh=QLDjLjkG296gUOBtHYT/cp9YbnwgFYyOCJ+gIq6SuQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRxTdB0VZB9wfvm+/5ii2y0VB+aRoll/Xp1n/9NCj7mvUgv1rfgVWzcwSaG+n3Qf0FrW0QQEgn0rhNQfjbUrE9zZVVP6jl1Rwh7n+eLdW5mQt1oRGv9CY17a4bTx3swBcRtWrh+9OHA6jZqgoTvpR3hjViAQ/XmyATnIAissn3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FN99mR3e; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLW7rI9ALunDQdCBGOgfSv4ZMBq/eRFF5R9STnPQ44Ttypc3wq5abEosMjbNzr4qfY6pDykD/w36e1UT2jf0ip2URDk7Rz678uq/FB4I4I6LCqn0IEIa8cLo0JcA7uEpK4Ufx38iNe///lx88FnzR+YmGBcBcPRRlJ7xBO+Z5nE5ne2xwVf5D12iZdeDLpE2KPncOHRo70r84Qaa9TauYCXL8HWH1CqEtS/q3JIznN1Aqvnx2UPLeK03ADEziAP7heZZyA3kD0J1e9+KOYgYNe+oBS5pJ4k7/Ymgd4WdPmpcyzjoGcPoe1cSSSTV/iSNWkehh63o15ZxINAqER5T0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBDpWM7SytXexeFVouXWa9zWfUg5n6xLV2WFhCVuFEg=;
 b=I+NzNRmGymF0lvWELT1d/lDO7pTVbh6ITVlHQ3nKHqSw6HkDSU+YgnW5/6l2+jMCTUDx4DSrPbsfM+xPHtut3iuYktUj0FhJrzv3Bobs2FLxz9tmBeeNAtH5KqUdl4EaCTqAnSztYqqNzQ5ZEeu2BFN44vnHYkLLSVZyn8flqYDJ2DbxoDnRCfwBKoSJ26iJVhHyT3+A+DCYTV+dzV9xSvBS0qefjpM5/9RuufhReLZeqtXnkg5xMzF5pCQ6l4R+EPTw4FJQ/hz2RobKNPRFOgRxTkYtHN4gsMhA8Cfj38gIDd2xt+RZKTQ4pMijD7sub2aef96ajqrdyKtplyWxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBDpWM7SytXexeFVouXWa9zWfUg5n6xLV2WFhCVuFEg=;
 b=FN99mR3edopk0qIYBqJrt2HtoESNswS/gwo3ffjqlOo21T9U9uYpHuiL87ELPjQrz5k0ys7ekkaXzr1Q7i7AT7SuH9TEDGjH5sbXPLczgtbribaO11lo/1Xjv0/sXYJO83JvubXtBV6/IP8rOICRmWJVwYE+hgNuhXwqUhWrPmCamYJjaDs/9Y16W3PBuEGtZvrV9kEyrvz09ohH/ui7e7vkSjY32KvuVJ8G+fGevtLgLfud6X6W2VngFOq2dg78PU+qKdbKHxNSymXXkiai/GdrsG9X8zbL5WNXgm0z9G0FhcZsj6Ubrz4/M7nora845PdZ7UlmgSPQOgHNHETJRw==
Received: from CH0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:610:74::12)
 by SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 06:18:47 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::5) by CH0PR04CA0067.outlook.office365.com
 (2603:10b6:610:74::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 06:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 06:18:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 23:18:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 7/8] net/mlx5e: Fix CT entry update leaks of modify header context
Date: Tue, 30 Jul 2024 09:16:36 +0300
Message-ID: <20240730061638.1831002-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240730061638.1831002-1-tariqt@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a71b2d-45a0-40bb-098f-08dcb05f7825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDuqbxnSJSn9uqIKNSD15JvgJsPC5h7WR5PPUb2kqvlex5Lzrz1w4lvj16v/?=
 =?us-ascii?Q?HgoeEV93pRnDa7RQ776uwwT3ZCdEhIySLQizD32LZra8rFiMTpuOuuZWdJ8T?=
 =?us-ascii?Q?X7nfNG3pxvLwkSzeN6FQG1PBP2kUQ5PHIMWDR0tNIQG4UrqZdAOProgR3Qej?=
 =?us-ascii?Q?WZimLgseFDY6UhJ6gu5WhqO5AT+rrp33mK1C8N/AsgVk6kPGjKTHVHbe2hb8?=
 =?us-ascii?Q?1+0HVqCVklcR8IWyci0XjUd4nZn9z1SYmmr0M7V+zYnwodNq5DZpOKVyhjTh?=
 =?us-ascii?Q?LIHAOkP9ZYkOVqBrsYSO6BWX9zTquJiqBSLhIJYIcUItFoguTfmxS/p6YtKK?=
 =?us-ascii?Q?4ZuzdHW+gY8GbOOkH8rZpFmAEjg7CtGyrEAndahbPEu3kBPQFXPRQipT79Zr?=
 =?us-ascii?Q?tktEVECQt1FS0WpF3SU0waSB725CVJti8XWJSBfSLL6gBW3U++sLLPkTYASl?=
 =?us-ascii?Q?owKxND3PzH9HwAvggwXa4jSe6Tyf+jnNcvHG94JBZoni/sokjlUDo5GollkI?=
 =?us-ascii?Q?uJXrRHFxXP+qjdlJiF03qA5Eqp3RIcQG+7GkFu8KQUuCSx07DLjUFVCUkgGq?=
 =?us-ascii?Q?m3dRVDDxjhi/50NrSb1KFDeCfLX2SNfMzu7FmDvUMYkP7fZ6yTvXg8i8Ds+x?=
 =?us-ascii?Q?9WVUkqfDsMS3Mp46Gs9a7pbRBCwhT5WAOw3Us1mtA6KX4x3d1RExZaW5wC4A?=
 =?us-ascii?Q?Pp8RFwzR6icXo+AMvi8dP5hHuvH63dWHNZ7tY5KuiVo6fuhaKTrGyV3ltDbp?=
 =?us-ascii?Q?NpzLXtgsdujXjjx1tPlE8/ti7q1lHnOX12hhhLGgSLEABYDozq65E3osA8KF?=
 =?us-ascii?Q?JtCED5MOVp/skiq40SAdLLjWAArfeUOyMtNxY8APIMG8eX+HJ4lm9sIXaE5b?=
 =?us-ascii?Q?1+ga4dUhH3RTJJYnA0ABnEd3/KPa/dIvwkcdSssHqY5wLlv1tm4l8fLkR/WJ?=
 =?us-ascii?Q?mcvJvpaLHJpFKhzt8HgiAR2EJ/0vk/O6OWfQhJ2PlDR8bv96UeEEKHWbPHsW?=
 =?us-ascii?Q?qPflhUqHPemCLhecegWaZ8PVOR069SOap7R+1rOw8nU/ZmsRhwGTm32M4DVD?=
 =?us-ascii?Q?3EncEv1JqIiJgH3JY5wJFjrfVRi9H99Efeb5Ox3mdZxv4iJ3bK3ZhALWmCDN?=
 =?us-ascii?Q?NkjC+3IM/FsuCtoQSSF2mb3yg+FTEmRta+DcI+xlh+KKz+gsz4jA20nqsJxX?=
 =?us-ascii?Q?2FauI2Ii1g3Z9uu6ZWOM1+Uwon1MOHOdtOWqU8hFD5Kdxfxq4ajUkvmAlOZ2?=
 =?us-ascii?Q?M9TrS7KbS/mTrDPxvJU7xHVQifoLSsKV2vauPs5lTNUOluC90ig88Jb3LUp2?=
 =?us-ascii?Q?m+TbtvEp8A+StWopr8fzC7jlhgZLsZN7+yHIX9WLMvbfcgt5/ejRTzBYkRc1?=
 =?us-ascii?Q?0T+BQe6wvmTWUT8EHHObDzZCvZx8cz8jzC3x1AQX7s3VmrgKRpsdOxGEXeZR?=
 =?us-ascii?Q?vL8ZYiAZ30n+901EfeWOq1HuBCImzGfp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:18:46.2280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a71b2d-45a0-40bb-098f-08dcb05f7825
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675

From: Chris Mi <cmi@nvidia.com>

The cited commit allocates a new modify header to replace the old
one when updating CT entry. But if failed to allocate a new one, eg.
exceed the max number firmware can support, modify header will be
an error pointer that will trigger a panic when deallocating it. And
the old modify header point is copied to old attr. When the old
attr is freed, the old modify header is lost.

Fix it by restoring the old attr to attr when failed to allocate a
new modify header context. So when the CT entry is freed, the right
modify header context will be freed. And the panic of accessing
error pointer is also fixed.

Fixes: 94ceffb48eac ("net/mlx5e: Implement CT entry update")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 8cf8ba2622f2..71a168746ebe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -932,6 +932,7 @@ mlx5_tc_ct_entry_replace_rule(struct mlx5_tc_ct_priv *ct_priv,
 	mlx5_tc_ct_entry_destroy_mod_hdr(ct_priv, zone_rule->attr, mh);
 	mlx5_put_label_mapping(ct_priv, attr->ct_attr.ct_labels_id);
 err_mod_hdr:
+	*attr = *old_attr;
 	kfree(old_attr);
 err_attr:
 	kvfree(spec);
-- 
2.44.0


