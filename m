Return-Path: <netdev+bounces-207158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCDBB06138
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA7F5A2DE6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468F28BA82;
	Tue, 15 Jul 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hPS3cxHe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45FF28B7DA
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588503; cv=fail; b=GW7HvSD2NECVcfCrn1eXw6WIiN1//lbOmP/qUsNZZA+54DE7iIAQTmPCIgWm5EPR2Mvz6BaLp6JhPp77RQ+/o30yvYWSKdscARXU63lWly9BhJhU9BHPcvdE86rFl3XyKvdYED49N/3k78g4hUf4w4iifH2pAr4RqzOFP6yZSYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588503; c=relaxed/simple;
	bh=bBJIUiaGsoeV3I40EtHnj53qc4CH567dB5mD2SBSH18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m44riQzs4emq0WQDW/OFB5/hgE+UFYJGRuhq18FE6tGr+6okZk6vIZMcWrSrHFqF+OYqr9MOEbFiTEXpDMHZwxP5xNiPbgD4vLFSH3NNNoxpe87bvrYolKkrdwFikszPYH8zE7KC+mYJmykFD2anweDM8Yq9wENZHcwlt448bHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hPS3cxHe; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTHzxmPicTVzEbGtitErhbKKjKfR80dRqnQLwu1bloPAA8FZQDNpzLM3JI87ujP0qaJ2eFnP+DOmkCJbwGsG4k2IiidHRORFjJvS3lEv/J+SpLtBiI3mYPs7LbeJgBRNCyLClNWfxXeGvKREaqOVZUEne18Emd2kh9zXl3JUw0upfgI4lWgAj8HOJryrS/i4DdTzd2QsC3Ec6cf3ZLQWruzK4S1+uDuXmjAQmdLra4iokdy1VpxY3piU4LEsPSrvSLsHIsjtEkIq3vWOmuGyRXvJkjcsB35EVvSEH3WRyGpfdr/47pn7jQ1TBllvda6mUhpBXkoMpWXFOV+A5Jj4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+M05RZfMSXiM3PKrha4hLDS3M6bRg48i2uKRr32GVsA=;
 b=EXr9aCJPlYVobay3YW7/Y7JPTRRaEppO+cPtSGtJnJNnUZMD8YMNDOjR+VdlLxz+2L6N+qi291oCIFK8zA2Iu20BBtzpajiqIBh65DPK5qfqdW6OanVIaVKzj69Dcj1OwmSMhdJuiyQpUIbLFxskKLHXOE9AlKNnsHqeragKffNT+a3F6/+MAVSXVE8GMoYcNccozHzsFkqa3oIi0vBIgUUDZ8/fNL1p8jjA8NEPyRAYS+tmKyGkyaz05vDcXqu/2r2IZz1ynLvwCIwG9XteDyHsTblnkFCPNYz6eNOcIbaSLPeet+g97Kz7Y53bHkXQ+J9/cYjN+tFArb4+1bxKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M05RZfMSXiM3PKrha4hLDS3M6bRg48i2uKRr32GVsA=;
 b=hPS3cxHempKJJmxGe9LcOJPgktgsJydNAJnbjs8z+aGm4lW9r17IOX3cpzmT5VE7QtwY/B1SWiqqSQGEWYm+g8+sbuWvsr6blgRsYGmn7qxLW6ExYh2mcuvPj/+OzlbKSLz0ik6uiPzBZJdRP6TAnotsE+0WC2wvoGk8oLdE0tEeifztuyltGktRMmurerY2+twglaKOvrdsqWmV3WH3kd/p2K1UkPJ7BIzs0blqpaRQ5ohklyTn7oftKlAI07vqbpzz8ziYXZgccsmIqyVFU3wJjrTqnh+h9Mn3ELlbgX7xnaugRlyennBFnBdMBtLfZMrylIh9VzcXV1wqv9XZ9Q==
Received: from DM5PR07CA0110.namprd07.prod.outlook.com (2603:10b6:4:ae::39) by
 DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.33; Tue, 15 Jul 2025 14:08:17 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::fc) by DM5PR07CA0110.outlook.office365.com
 (2603:10b6:4:ae::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 14:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 14:08:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 07:07:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 07:07:56 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 15
 Jul 2025 07:07:54 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v2] ethtool: Don't check for RXFH fields conflict when no input_xfrm is requested
Date: Tue, 15 Jul 2025 17:07:54 +0300
Message-ID: <20250715140754.489677-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cbe508-c70c-48fe-5133-08ddc3a90b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wp3DK4C8KOsnjVltdySkG6LGGEDMhSXRIxymTAC9CHPy9xu+V0B7UZzDZos1?=
 =?us-ascii?Q?+O/LvJMtDKJBOyb9pc5G2z7+dOu61SmWHEVCXRJtD1GOoOws99IKxUkf2S+2?=
 =?us-ascii?Q?EW+2NP/Lxdq6TJT+ei2sN0+WOcHczUSz0EuZZaRO1K/PuTcTGUVMwYCbUwCn?=
 =?us-ascii?Q?toZrHkecg0bg9CGTpTk1+YGbXPTpoAdqhztYR+RlpIQNwsrqJFm8gGN3aOJm?=
 =?us-ascii?Q?Fut4/qbrb3FzIWiDZx1gkg6R7kGSZATtIMOkI5Sw/Ubpacoo/lD94aUf5swV?=
 =?us-ascii?Q?uLa0maHt+diD5uvMCTpEik5txr5o2fOLI4DzaR1vu5rQKEtZWLnQUjePE66f?=
 =?us-ascii?Q?7H9ODmKb+lU9IEADiE+62wvAQtavJAJIo5iw9suWgdqPJL4VE0QUbqPXC3oK?=
 =?us-ascii?Q?ZK8VncBCvEKHE7L3jau8tlT2M5CRoIoKe38GlzG/JxR47qZ5bbZ+GozrlC9m?=
 =?us-ascii?Q?zFbfF9n7BZ3NoplTfro4u8mndcm2GhbpNCL2xbUhn7QG6dQL1L2U2Qc9rncz?=
 =?us-ascii?Q?b84pUmJ+75IEZehS2waE9Gdy5kBVqm52zdeMnatNxgkqaoNVF5d7MPFaKoGs?=
 =?us-ascii?Q?qI34lFuEm9ssS0D28VxOEOPCL4dgATL/Xba3G9ZjU8T+rGOaays/rThIoRk9?=
 =?us-ascii?Q?L3FgSajtRlQ5Y8E8OjgixpTpRZDX8u0w/g8gfOJ3HlWvrBgImSuNZW/v2QNr?=
 =?us-ascii?Q?MZlNhmq5YhbxgI66h6FNMhRuZ1v3xihQQl/3m9tSjYIEwsDmya+kOef7SiIO?=
 =?us-ascii?Q?LoydMexKJbtLJyzuKN5PEykWx3gfpCKtHgtossl2S6Od/q1KpzL4ooi6lMz4?=
 =?us-ascii?Q?+QzsHcuSKBRPI14YsVkpBvqmvxhEQ0khYoQODYPozNN8pbsbP5hKqfj6OM8J?=
 =?us-ascii?Q?SYlnthDH5xCx5L6Nm92O9EB3jlVubEW0242CXnZRFwAdhBcq7w7mLrwW03ls?=
 =?us-ascii?Q?DPvnKMS0oMY+3unCq3uxcy7sjpUOcdloychj7r11WKvBn7IfSs4ju9FY/d2I?=
 =?us-ascii?Q?bBjAaDiS4+Ift+5CbBGSNsBU1O96HhFdydTpRkMoIU161AAPevqFdmD+EvJJ?=
 =?us-ascii?Q?rGYLR3Sya/vvlqebDEbkPeqEBMYgLma7MLd7G9Pj4+huTcc/+CwMu2hGkgJC?=
 =?us-ascii?Q?Se2gKG2D3uiKIznugx5aN/0IrDH9qvtXevYMHdKL8Lv4IKH5O9JZQzalxkl5?=
 =?us-ascii?Q?A35pSEyXl2pTg0NfEzVv7rQ8awwOIi7qKeJ9i/kBlb2r2bwEHpTKGRMJf61q?=
 =?us-ascii?Q?vKEqYP7XrTanEJscQdP8Zp1tu2F3qJqaJF/6+kObPtwPZD+MUyP1LF4tjsj+?=
 =?us-ascii?Q?Gb1RmlA391DlYeXuqei7ph2puiaw5kKFNNnH+3a9V1VuoH1WCAjvf0fuU3YC?=
 =?us-ascii?Q?pmG5dWgna74+4lbovERK00qVHVPeeWDToDxH8Ioe1xBrPH7LTPvLNHdTrw9p?=
 =?us-ascii?Q?IS/IPaGpzDJuXlzzBSlNIOOW+/NGJJfg/yWAZgNk7uZAyPTv/4WMC1C2GABG?=
 =?us-ascii?Q?Ie7h2sOtvvT4ay8wWGeAAHmSVPSJRv57QJEPU+LczPFwBJJ9YyDGgAfZMQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:08:16.3670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cbe508-c70c-48fe-5133-08ddc3a90b6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724

The requirement of ->get_rxfh_fields() in ethtool_set_rxfh() is there to
verify that we have no conflict of input_xfrm with the RSS fields
options, there is no point in doing it if input_xfrm is not
supported/requested.

This is under the assumption that a driver that supports input_xfrm will
also support ->get_rxfh_fields(), so add a WARN_ON() to
ethtool_check_ops() to verify it, and remove the op NULL check.

This fixes the following error in mlx4_en, which doesn't support
getting/setting RXFH fields.
$ ethtool --set-rxfh-indir eth2 hfunc xor
Cannot set RX flow hash configuration: Operation not supported

Fixes: 72792461c8e8 ("net: ethtool: don't mux RXFH via rxnfc callbacks")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
Changelog -
v1->v2: https://lore.kernel.org/all/20250709153251.360291-1-gal@nvidia.com/
* Assume that input_xfrm support must be accompanied by ->get_rxfh_fields()
  and remove the op NULL check completely.
---
 net/ethtool/common.c | 2 ++
 net/ethtool/ioctl.c  | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index d62dc56f2f5b..459cf25e763e 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -812,6 +812,8 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
 		return -EINVAL;
 	if (WARN_ON(ops->rxfh_max_num_contexts == 1))
 		return -EINVAL;
+	if (WARN_ON(ops->supported_input_xfrm && !ops->get_rxfh_fields))
+		return -EINVAL;
 	/* NOTE: sufficiently insane drivers may swap ethtool_ops at runtime,
 	 * the fact that ops are checked at registration time does not
 	 * mean the ops attached to a netdev later on are sane.
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index cccb4694f5e1..830623678cb3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1041,6 +1041,9 @@ static int ethtool_check_flow_types(struct net_device *dev, u32 input_xfrm)
 	int err;
 	u32 i;
 
+	if (!input_xfrm || input_xfrm == RXH_XFRM_NO_CHANGE)
+		return 0;
+
 	for (i = 0; i < __FLOW_TYPE_COUNT; i++) {
 		struct ethtool_rxfh_fields fields = {
 			.flow_type	= i,
@@ -1523,7 +1526,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	u8 *rss_config;
 	int ret;
 
-	if (!ops->get_rxnfc || !ops->get_rxfh_fields || !ops->set_rxfh)
+	if (!ops->get_rxnfc || !ops->set_rxfh)
 		return -EOPNOTSUPP;
 
 	if (ops->get_rxfh_indir_size)
-- 
2.40.1


