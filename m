Return-Path: <netdev+bounces-220312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA92AB45615
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB455A0367E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AC34DCE3;
	Fri,  5 Sep 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RD5tuIsv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548B346A12
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070864; cv=fail; b=h55CgCYAeM83hIueUbgi0vcXQFXPVoDpojTIGplcBxBX1YmkoeWM/O3L0MhBfCg57hZnzXxQklW2hfyMZsIVvNXSx5rWtLURC/Fc/yseC1er3ywSiWeZcjLI00cauIJ/2jCMdYrdlyi00evz1hFG4SWudJHAaUep02CTH+Kd21I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070864; c=relaxed/simple;
	bh=pJW0Ps5oDxZv2lZV/HrQK66AtQJe+d+xv0ylwC1YMlk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M2c9S2aU9yPLHT09e+NOXrJMeIgFNAObVtT9c8FE5VFqQa604NgZDVKmLsWgiJ8vEv0yxOi4nrl6J3zVd4DtgPnAXMtDNMu4IIVrPxkSXR3Qz6cORDIeBR5SyzTeIDactw+Gt8nGMtG1Gb6wVMw/VaRiZU5Y1nWTTqnG6rr1B3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RD5tuIsv; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOmShPIVRS2nZq6okWxn3zxqUiNPSFRl/j7Mo84ZHTApSw/G+Qjb2JNFPBTTsgme4ybh9Rl3143rpxNhYiD1KY+6QdMRAjZuTX6xJX+nYrI9SqMMs7fwGke9Usz5rX2lZ6CH4GIkgCnfReFCBZr/8mkVJQZT1XjWX2YwBgCCyk2N9rO48YPGU0G0fGbZD+Df/iHUo7pvmXPBzoN/Lmfxe2Sf6iFFpH8FGX8lSopn5rQVeimSBmR5U5r64RnPXPA/G3aJ+s28brcP4lnQlfrLc4arPOhAjN/+ooYbgWxeaEKiyUxQDXVRTAzxPWig/qlLlMvDAtSWiOte6ewQP9suFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADss53qSwhjgsi/juYaNn6aLcf6WHyhnZGvJW9l7hwk=;
 b=sVgUMQKIKhudyO2SSRKEWHRKgQ2NsTDd6/XVQ5dWCeDTqkybC1Mpk5SJ2zlUTtgmJS2wBlrVGWTPOQ00svw9QIeZCO+eRyAX7H3bDTowGthVE58Ga5BO6TGH1Mx0xOsWMKgLiD8OdprtLEs568eT58QyqBt7cC5as5PDo75lerUTGw02KdP6Gnw+43sbtAOhuY5YGHAf9fhm4w0JUXCMW5LBw2kkd+Uv5EXJbL9oRwXCyoP3qKuqFqt7YhQQD5gdlJA+m86jY67LExn0vFXbkrxRvH0W0RPiXJhFPOh4STpuResWqLweeHK3I0rO8VJGYo4redIHSiIOBmxTHgTfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADss53qSwhjgsi/juYaNn6aLcf6WHyhnZGvJW9l7hwk=;
 b=RD5tuIsvFM5zgLGvmtb71uzGtNyiSdrKp7kH4ZjWnHZcw3cGdk5fWCFTOsZhbeLmFlDzvHs9dZSstRhzmPXFg20wbB4ANOhym5uUP8XwIfKwGJY+PfBNW94AP7qFosqRpkrl64kT8q86oCQiVcltNsj/1x1FekHpAOhq1whrQTPLoMkhYdhjX3wiYeMcnXu3ZuScf683kyaH+8sCdkempxuOHMUrCuDtvOzixjhA29qZr1MQdgOND84Kt+9W2PHa9PDJKfoQ8LzAkja+2nMg9RTnaO0bvVYPUqtOCK5XVi8fovvUFRU2UYPSpcI3OyX5A+Ewdg6rzcVlBzACeUwHcg==
Received: from CY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:930:1e::27)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 11:14:19 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::31) by CY5PR04CA0007.outlook.office365.com
 (2603:10b6:930:1e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Fri,
 5 Sep 2025 11:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 11:14:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 5 Sep
 2025 04:13:59 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 5 Sep
 2025 04:13:51 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net] net: bridge: Bounce invalid boolopts
Date: Fri, 5 Sep 2025 13:12:33 +0200
Message-ID: <e6fdca3b5a8d54183fbda075daffef38bdd7ddce.1757070067.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: df6478d5-5867-46f1-b649-08ddec6d5b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dmwp8OAGlq8xrXLuUuMM87lm9P3V50S0SnWS9BICinSoCLS6DquPeRg3lq3T?=
 =?us-ascii?Q?wuEb6WnmbIAKJsCHlhzGfIUZ16pkxQw4zbr0TVqCfS4k2vf7/hjIYUelcRph?=
 =?us-ascii?Q?MmLHtPPT9gl85mGVT++tKdQ+tG41pp71PHfr2zt//vxIz99vuwMOdVaA4mz2?=
 =?us-ascii?Q?JofRFOx+C7rVpqEsDqgWb6hcCd94+ZVcm0izr7jpUed0OJVVN2IpSw9UiMPR?=
 =?us-ascii?Q?tA2jorYwXgoHrZAag8K2NYwN9O0DqB4tX1o1fglYhxBt5O+VExZ3pCuDbZgR?=
 =?us-ascii?Q?TNxR0JL2xqU/rD5ZB12LCawPqke9psEAZXtL34jHtfHxYd0+zkP8eFvKOTuU?=
 =?us-ascii?Q?bvXslIKXddqlcNtoU1eK7i148vg2Hy8Up7LJ9YpB5B7WHkgK0hzIXXeV7fcW?=
 =?us-ascii?Q?ejkPVFB09YkvQRR2F5S649oZcE8YRYlT7WIxndeQZSm+tLFawebrCSZrWNKh?=
 =?us-ascii?Q?X+BwLWbpd4Ujl2+swEUtAmfoWEvDfpWqz4sdRK0xJB4OGnU3Itd/zlADp6Ck?=
 =?us-ascii?Q?MC2lKxmk8xJKg5hAiXH8Nsy2+hYDSYMtFvNlc9A/AQZTlY6iUVdWQ3Liz5Rb?=
 =?us-ascii?Q?lxn54Juifv2Aw3fcR6/8mMhudCmRI1hebgXnKdaPW7o4nXA6Sc6H0MJ+mZ37?=
 =?us-ascii?Q?HvN6h61tetkCyTV39e/Zbxj1FquMxjugflzFa0SbP8M3x8LHwte3plkGVjYq?=
 =?us-ascii?Q?9gr0K8CrZiuqSdim71y7Hdua1AMKiJDGQRa+Ufwh/cwSSduAtdC/vp/fRgym?=
 =?us-ascii?Q?wvc30vqQqpYANNXzHUEh8hQ7J3iqZ6JO4qg8OwDH2cvsHvb9IgcdCJXt/4xy?=
 =?us-ascii?Q?uNrRdfL5PR09wbFxv25oUqDjvloywpNZdLBdAUmA40vprUKzq5LYtYhGzaE/?=
 =?us-ascii?Q?8COI6/kpBmrLO0BS83xM2wZCu61gDHP3zPvPZ7/l8Q1EKhQborENuwf+mmpN?=
 =?us-ascii?Q?HwmkEKrxhV1dwzycgrhIhicfrjRdQpPB+IEdAW/lF9myMUIPrvpcF+PqD/XR?=
 =?us-ascii?Q?Wu9pRJqcwB+johUfDyynQlum1HIInIJI4fGUpYwXA7p2Mz5HZJoV11gd3ZS5?=
 =?us-ascii?Q?7Ca3vNwMFTp0kLF4kwpYITVqMW26/nEpC9trzXeDA3NSbh+WOYdO/vslGd1t?=
 =?us-ascii?Q?DrmPpweXZjWH6Al+H+XCLtJEnbtJkTxZdhx3rrXJCnFIKvKGOAwzHdLaQ6sJ?=
 =?us-ascii?Q?Q8habzLGre48cW4/UGYmx32vXys3wQUoqE4gDUSOPHC0/EeqVZUy7u7yD1W6?=
 =?us-ascii?Q?pZPMnilr0rcEETDqiHAwALb4zemR9/T/4QqlzWfbleziTscXsUWTW9WYSiay?=
 =?us-ascii?Q?75gsxmfdQTzJOnvry1q6zJLw3dauX3kVir8++AsWoBdXJjmQq2PYF2XQ/bes?=
 =?us-ascii?Q?lcGGJQNix6RfCsOYLLkkTdYBkf6sd2WG38Rv4hZ3o5sRLQg8d+HinGc/sQFJ?=
 =?us-ascii?Q?7aaEedeeV+cifBRRuYkomdg369nKOakUh7KbwiBTFdOAmxSJTipjUneM5GXk?=
 =?us-ascii?Q?eMOBJ/1KsC1EOfTliQlaKzNSpu/7i+fDdcVr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 11:14:18.0565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df6478d5-5867-46f1-b649-08ddec6d5b2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069

The bridge driver currently tolerates options that it does not recognize.
Instead, it should bounce them.

Fixes: a428afe82f98 ("net: bridge: add support for user-controlled bool options")
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 4bfaf543835a..512872a2ef81 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -346,6 +346,13 @@ int br_boolopt_multi_toggle(struct net_bridge *br,
 	int err = 0;
 	int opt_id;
 
+	opt_id = find_next_bit(&bitmap, BITS_PER_LONG, BR_BOOLOPT_MAX);
+	if (opt_id != BITS_PER_LONG) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Unknown boolean option %d",
+				       opt_id);
+		return -EINVAL;
+	}
+
 	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
 		bool on = !!(bm->optval & BIT(opt_id));
 
-- 
2.49.0


