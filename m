Return-Path: <netdev+bounces-205469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA3EAFEDD0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476933BB849
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF742E8881;
	Wed,  9 Jul 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QWrqoDgA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549317578
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075194; cv=fail; b=PHOyyXnNCCByqrJhnwJPK82WQk4kTxBPdiKeF2K+U1N8lsNZTPmsQAxVCiFtHckJt8wENEaeYuPsW/MP95r0x1Oh6cEdYZtvT2+sEJVYCKRHi3Jj646lQa+WWMzSO3u0zRLHTTQqP8lbDWF4qCCa6yepxOmsqTEhaeltRg61ckw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075194; c=relaxed/simple;
	bh=x2D0mgCpJhYrmUlsG213haUr2M4zsnrv2bCf8Aatvtk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DKcA+0F28BCef2tA4pnRHOmyoitBGIt0RfJO7LgEczVbnv4WqR5HfeFt60h/k1OTc7J3K3qsWOAXhyMSgCJl3YM3DK9t8Ys84lpnuc7X+OSI4M35SwMHSTa2Zt51c+OqJkfZ0dnHwv7ZNqDqYpwEssjNBVQVLp0eQlUtu82ybvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QWrqoDgA; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQbDybNcPzG4lDp4gsiNKhwkiHLdxOeqi1vQKqTBriUFF2TsaTgbICI4hAz2+bj7FDWtLXBHcg98b20cu2X1DZVfHzx5AfNT+xts4C6qaRjnNntl7EPAvVR/GNdP3V7kjRv8W6VvWmiMpF8hU8HfnEPj8fpgfgua5lT58EHlHcUfI1vCw8k8pAVDFAOJ/dDmsqNZL7mlY3PXdKBmDqEDLvBjfBA8wG7AaDjVgXtG3pc40fXnrrGqNYoIEW2xZrK16hT4lKsCWOs5B5HvPTToG5JqUX5/KF7SzRQc2jtwJ8xGVtCKv6LUUkLPUbaIXgZPl+oGc/smg7DOrK2kOHCzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu0yOVKwf6DYlr9J2B04id81pAnFpsjzrR3fAIkNkjE=;
 b=IfRa7ERuWl7kVbYnhwQiWL5vdD0KdvJU+5PBKK7EsHJHLQw/qQvNo4sVhnh+cqwgi5DgIuMQS8p20GWeFt1aDKy/6f+iTvksG2pkHA//shx1QhIhMzZivmHqrpaWcp3z+ASCvX9appp4eMMoUln++5mjxE2FnO9ASzAGlAfZ/gSSgcw1fQTPITpA0glmyktyiXFxHYmOOqx30rHo+Nwx2fN3GauEKud7onomquyykqrqAGPSJVkSOOyK/t3SCeozrLuCks8kIbxewyNmWdK4kfn+LcdGaDh5Kd0kzHxu3QvO+enTlhbuvCiU2LDWS3K8GoUUrjl2SOMzIuQTi0k6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu0yOVKwf6DYlr9J2B04id81pAnFpsjzrR3fAIkNkjE=;
 b=QWrqoDgADmOV4CtPLNGeZXO/uzgXGZsx3iswn5zA2yTksOJ6XqBZCsSVVEClZb30tRGWRaabfs6B4y4/tXurACiiH2zBZC58jRjsJ+vKsVL+ihC/JYqJtTPFwptxNhmCxSzyZm5YYg9KCRDQuX1XzmFmtYuXA6mi31fLJmkbRrydHCNu8uTfULwrxCTkUWvLJarpkB8YT8xPizpUMVaSDcw4bx1tEgRexc8I+UL3MGWV1RLe6Wnk4L4thwR+pjBGFvVkf/xOVLdOlz5WyQStP4hMQAICKTZssZcHKmpalc3A81Ysm1fZNL6bVdoyzroqzREPDC/Nc0khkYQFFGY8HQ==
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 15:33:07 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::20) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 15:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 15:33:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 08:32:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 08:32:48 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 9 Jul
 2025 08:32:45 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next] ethtool: Fix set RXFH for drivers without RXFH fields support
Date: Wed, 9 Jul 2025 18:32:51 +0300
Message-ID: <20250709153251.360291-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: b3741072-ffef-4a33-ac0b-08ddbefde6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAM3Glf8TNACwKVBFxxwu/n2DGMFp3nvftf2a2wnAHIdHr24zAEwWEsXH45j?=
 =?us-ascii?Q?uxbniUIGOBrXJdwz/2njhAo1wzXYyPQOScm+w5ZCu/A2jBUsGXMMr84ZW+2h?=
 =?us-ascii?Q?MjcvDvQv47KPYUiJyfmULxWTwc71fxhkOjmMvLipixYLXGwl0GaFWgCJvd2V?=
 =?us-ascii?Q?uZ1tME5yz4ylxrIoik9ZUnEeb2vOR6+DBpDOEf+Bfo8q6VS381JjjVCBfvz7?=
 =?us-ascii?Q?MOEMf91NUQknIsRQ9eiU52hGDsrZaIfSSNYZ8gqgOjcCfYLDGsVqfzZGajw4?=
 =?us-ascii?Q?MY8yAHSYfqyR2G3iZlsyHU6B/RbJYZcxhEct2ANC0PvJgSHoTb0NuUbsoue3?=
 =?us-ascii?Q?PzzvN2uCF3gMG3U/85jrIFmiqIHjkIy4fvFC2NksWWjtyaAF1FWucFf82LJc?=
 =?us-ascii?Q?oji2rDy4tSemxqpgxMI+2ejxrwSsg6H0PmCHYvGbvW9AbO6f84Phu9uF8FFs?=
 =?us-ascii?Q?ll2FOypcrj16H7Z9Nar7dr4GidhVScC9CLR9DqqcXj92fIIyh8L5I8442Wqz?=
 =?us-ascii?Q?S+kpTxWIwyNppTMGBCdxv3yS7+Z9J6SkddnZhqz1fLz7fdWF+sztqNVzy9bj?=
 =?us-ascii?Q?P+llcec5SIYvhlrHBCeTjKBoFd3ipEzs/4mPO0SCloVdQte7c25E//cOhSjZ?=
 =?us-ascii?Q?jNN3QHvqHNmPKFAA4fZFK7KCurKRVrcuQMXwsSYuRiFdLxk0M6rHNqvYdmMu?=
 =?us-ascii?Q?S9+tCMreAzgyee0TDz6KMcL9tPb6j5tVHS4wPX/2/DvxX+/MbsaymDDROTdP?=
 =?us-ascii?Q?f4lhgv0lzrBH44SHZ4dBJZ/50qz2rBsQ30aA3+Ggu/Jt/RwQFkzYXQk748Go?=
 =?us-ascii?Q?7dVchW3FDBHEBQil8gLjTu8Xk9cLQ0csL306SA2+TZqmFdZ3+ISIc2/3F+gS?=
 =?us-ascii?Q?lcumkKyMETQNGCxw7PR8GdNlIh7BxbZdQOMNQOjy+sZ2klOROC2POL5FQXfm?=
 =?us-ascii?Q?sUUS3WUNEzOk4y1jGVr6QbzztY59+YJSjV1u7HjCW1kuNvPSQAxldGobtheQ?=
 =?us-ascii?Q?o75tW8nM2MYDwlajykGUsbZxdNu+reFoNUZNG4YK0FkeYWUVSgqQuhzwz1Cu?=
 =?us-ascii?Q?ndwmQerW0R9PpfROgEO8q+ahR91djIgZJ5Q2dAeIvKAmSQAmlx7xDhEiI0vR?=
 =?us-ascii?Q?K8c5ilTCNGU/8uED8wm64GzJyFgPuUD1SCla2drkgkQ9yU0DCQnRVVF+c+k/?=
 =?us-ascii?Q?kBwyIc5zySChRy6Z58yC4mVzZvo9jKR29QLx/kVaKNqiwpE8xlySxPrfMj9P?=
 =?us-ascii?Q?dIT3Q8MdW/WI9j04jK2UvzjcBzxc7/agiDdiLLnMUSUv+kU/RBwcjDncjhI3?=
 =?us-ascii?Q?ANNw0sZ/oShh2nXHhVRC6Ta11z2aM+Z1pLR0eJqZ85zEm6uphd+Sj++8Wiqq?=
 =?us-ascii?Q?COVHcFQ11rF9WsrSmMrAg2/+lDGJYHpyZcBSQ+US42Wszbv+9QoahJCOf/qz?=
 =?us-ascii?Q?9rnqItQk3Y5AjHu7+kXXGpCGvfMns8VUwEPd6C+fhGYjf05dYwP+r7auQV1Z?=
 =?us-ascii?Q?JJx+0rnaqlvk0d5VwTMzFsQg6XPxqPfI2uIx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:33:06.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3741072-ffef-4a33-ac0b-08ddbefde6b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

Some drivers (e.g., mlx4_en) support ->set_rxfh() functionality (such as
setting hash function), but not setting the RXFH fields.

The requirement of ->get_rxfh_fields() in ethtool_set_rxfh() is there to
verify that we have no conflict with the RSS fields options, if it
doesn't exist then there is no point in doing the check.
Soften the check in ethtool_set_rxfh() so it doesn't fail when
->get_rxfh_fields() doesn't exist.

This fixes the following error:
$ ethtool --set-rxfh-indir eth2 hfunc xor
Cannot set RX flow hash configuration: Operation not supported

Fixes: 72792461c8e8 ("net: ethtool: don't mux RXFH via rxnfc callbacks")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ethtool/ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index b6d96e562c9a..4bb8bf20a0eb 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1519,7 +1519,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	u8 *rss_config;
 	int ret;
 
-	if (!ops->get_rxnfc || !ops->get_rxfh_fields || !ops->set_rxfh)
+	if (!ops->get_rxnfc || !ops->set_rxfh)
 		return -EOPNOTSUPP;
 
 	if (ops->get_rxfh_indir_size)
@@ -1623,9 +1623,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 
 	mutex_lock(&dev->ethtool->rss_lock);
 
-	ret = ethtool_check_flow_types(dev, rxfh.input_xfrm);
-	if (ret)
-		goto out_unlock;
+	if (ops->get_rxfh_fields) {
+		ret = ethtool_check_flow_types(dev, rxfh.input_xfrm);
+		if (ret)
+			goto out_unlock;
+	}
 
 	if (rxfh.rss_context && rxfh_dev.rss_delete) {
 		ret = ethtool_check_rss_ctx_busy(dev, rxfh.rss_context);
-- 
2.40.1


