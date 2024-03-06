Return-Path: <netdev+bounces-78143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE087436E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221A5B22915
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925C1CAB5;
	Wed,  6 Mar 2024 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LS8beB40"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A31C6A7
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766301; cv=fail; b=Ec+ZDwvct3Q41QzUUqPuiXMnoU9oG/0qyvmSQjnFHMCjWWjFOyU8K35b00Q4TdjLJUdM+inRjrn/1kwu4SieEplwNKT6Wbnoi1JeKaDAQeScd7j0kA7KecZ59w75snsT1tdMaN+froq2GLTOcMLv9JaCDi2yTPyJPyxSJviXttQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766301; c=relaxed/simple;
	bh=tUvP3JSPJqJWzor2J843VXm51OzYr/Wc462Jh9vG6H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rvd2uMxelJ6Zq3CsyQfP8/Pm0yFT125bsyPdUUBPQSurtyRGRQSHLdJhgmAS8qR2YpTG9uhTCishWHTfmZy+S1uk0lf0PKQ+iJR0PNreHeX+wrm9LNdCj1JW284HMd9+JQWAcNO9T2kqYJZcwNHmPT7mDvHWosvjZdFEs/X4Qro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LS8beB40; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xii02b49dNMC20Srnuxy0UmiXBaoul5OepEWCn1mqLl3Mtg69JD9KzsdE/LaFsQy3Pb2Y2aFOWyEgBilnWVXNdxjnu2kXTnYMKbg//FGbc67v0ktA2ZiUm/YnVJMup4o8J26qFYY0thdlIZgOVXCNnfzM64Z4/w1936ue+hn0i0ZYXCqdE+bcnIoz8nGALtdydHH/VBGW5UCM0zBPHzRiBmtVNJxSZ/aaH3ZLhDnm0VEQAhu/4d4j8wPutaiNIPp0SuEmy/FpMRZEl7MZ6niOmQQEXMKPKcYTlISl03BujLXCLhjDdwS5q/P3JJ1Nzu6zPdUPurYtj1GLn+KdVOxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feIcLzXrI0UrvX/2u/HM7iFaS+px1+JG/qPuNg/c0Mk=;
 b=R0y7yDCSG7qCLecZVa3i+ZlEUMt8BudbcJOnSpEYJUl5e4FkWz+rTV8iRrA6UthfKCb+oxy4Xmc+3isaXL+12bOW5dRvpLbG33KY8WwQtXF7eSsLPjSpnllEHguUaZ6t2nI8iKiIVh4HWYHQ5JLmtVxkw4HwdGgO0j957MEqZrK6MtqPEx89hxP69+t0ve1Kn4wME57q16zgvtQoTVNgVMug6V9zE1KNPWdpg9zqr3isRpRPx3PKRdU1DO/P6Xc7KSrpH69EAxVxJ4liU4Ssu/bTWg5polV7+k7wORmL9yOUp1vMmpFqfmtHEpHbgJK2/vZEF5OdGjb65EY32UInTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feIcLzXrI0UrvX/2u/HM7iFaS+px1+JG/qPuNg/c0Mk=;
 b=LS8beB40alUZd6zKxn15sfXGU9Ruv77mqwFRmsiAmTVyGiR+Z0m/PN4wjm8iEoaPnmTdB94pXrC9YbXTtLSbcMUHb5BmGULzhkuZcEBZcNRylOrpWtWS+LYReZ9X5XRPKWVQBd+/rAcW8vHAemRWnX8NKonEAOXcvHg7QrLqs7PSjSAZ0VxEKoZxHsLZvumB3LCpVskHPYFT7BxA8L67PJaOMBikn0vRiK5nPbcJ4RdN8fyIPCZCTD2++zFQ8eBEEGJPgzEoCgy0197CeacwpwJPu/J0qCdkWCN6vJs8lOWLidKqkOFE0A/JrrIzujJhk5rMqEKIP3d+o7s9bCNHIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 23:04:49 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:04:49 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Nabil S . Alramli" <dev@nalramli.com>,
	Joe Damato <jdamato@fastly.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC 4/6] net/mlx5e: Introduce per-channel coalescing parameters with global coalescing support
Date: Wed,  6 Mar 2024 15:04:20 -0800
Message-ID: <20240306230439.647123-5-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306230439.647123-1-rrameshbabu@nvidia.com>
References: <20240306230439.647123-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 971bf5e8-0ab6-4efa-94cb-08dc3e31d1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6bbs/WmXAALhDUeswqzqPZjiNzAGTMs0hFmntjYQdru2MG7XR9R+ZS1G8oeDCGERhLfs728AApln+3CPOXhwWaN8H/GGbPmO33J4gN8lndxrEVm/mX/ploOZ5lbpQn1lp25SsVHoiaaecBIhtPrC1ZMuig6nAHCU1u0b2OrGQIIt3UboLa2Ou/2Gxl4u7ipQFb6n/GIVIHUK+dAHPfpWXszDq8spGvKvys6cf3Y/Wk1+IfJsNX4GiVi8cc13YWrumQX8O8x+89uqG3FVapVJuw5Bp9R/iE0p4tJzdR7tu1fXeBWIJhILdSw1o3ekgRWea1kRps7wCcIT3k2QHkBRzByKVxaBsRRw2UJ30yFNGwAJqJlhX9Tk8SoAqmwYaK/BVwnqtocTtNZIEkFOa0lJB30XnwubrkqnEF7BiVq1pMmeXo2cg4NpLHDES/jhmvSmDyMugU9KWTlefORjqKcgt1XWUmOXcgTTe1v8k7LkAaGFno3cSjZcDMeshXg6e802zMVsbgoqHknim+weyJqMjY+M0oSEk3p6baZtegZ3KNg2wPjzxXfP1PWMusDmj2/pwzYseey3o5MVWjOjfwgT3QUKOe1UgDymFGn9BTlixe5OKoArN5M0jnB6Q9Scs07/RbK0m0u2x+rAaL0Jrh8F5BD9n1I78WwaYSLb84/BvWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I28dmqEGjX0lPzfsZazCSMKQm6pKMLJ0sXG+hEGUdYhyKbAFhKAkRxw2oet/?=
 =?us-ascii?Q?meqzg3yIrRTJ7wFlmC/naT6oCehByI42S/t/IcwQnSz+L9X1DUfPpR+CpaOo?=
 =?us-ascii?Q?JfAaGv24SCcjeNah8XFDU/MjRXcTHY6vUAi8ptxyJZ+29s9fjApafTyFMbUx?=
 =?us-ascii?Q?9LooW2HyZ1ORFqDdD43KQbKGJHqzc9iXlSpSzS91tYa0P1fwXIXrfbS8571w?=
 =?us-ascii?Q?h0lZDxSuBUM8AQhcqsVgw2RUHrj3KWPnrj2zubyDVUeGCOStf4TcQX3vjmWr?=
 =?us-ascii?Q?Pz2sy3+cREwIgzwp9lPDk2qOUf1/xuASWnI5VtjcZPo+Wu256889fIDJhD8G?=
 =?us-ascii?Q?8tH8ppHCD79881hr0v6YBjWXO3sK4i9be6giaiy962HLeIbGbPmn/ZM6tbaH?=
 =?us-ascii?Q?8jIUOP0iRgeV2KWdFSMcqAsYX9xiS5NkpZHiCxegjIp6n2+YO2N2FSsllNMB?=
 =?us-ascii?Q?A/3fMQkpbAd+VHuWRrzhmuWmiwDi7vdT02Tif+aUnttOzq8l7N2Cx8fxaO33?=
 =?us-ascii?Q?g+mOJFOFbl+MBPKUJ0ZPCh95ypWnJMBLQ6Hq2ZMaP3TyZx9egLDUM47US+iC?=
 =?us-ascii?Q?46oAZxr46pumVmJlTCJAm1lsA/KwYlhcFfIs73mjKKPlWmnpqq0L1+t5G4Kf?=
 =?us-ascii?Q?MF54uIpdP1tcTrwJO18diT2FhyFAzK52l5fEfL5Jty9bPbEDSWRyNAs6K8eo?=
 =?us-ascii?Q?02Bk5zq2Amg9scEcuJAQxe1b8409G4gLvL5BdhLc2kQms0FJkGOM+nRi5dA5?=
 =?us-ascii?Q?k+FyjBK7EsQ8xPt3BSiRfCBsDlbiqilRiYstnZx5O5Mmgs8vjJ4+N5JE55UI?=
 =?us-ascii?Q?bts1HOUkX90pPCsRlcFCVMfUwzrV4UO/lc9U0bLvUPUCxdYWvXlDxNOSpeTI?=
 =?us-ascii?Q?H4YVTvls6mDftSC3EOtFkzH7SRZaay6f7b5vBDcY12ryklwtSTcPQDWZWeIM?=
 =?us-ascii?Q?Gyooy7Z+F9xn/ORohOCmrNeTqbGDnCzfTXmZPwavnaruNKS7b1oUkay/H3YY?=
 =?us-ascii?Q?khhZmUJERxJCvNpwWTxBHWyYrBl0beKNWWaYsSFmZrXIgkrgGxSQYAQ++Gai?=
 =?us-ascii?Q?87k3G9LhxlepbNZ4jDFKwIUtra4rBxUxwwXJMSArjyMsxHJzMgdQLfQ4V4li?=
 =?us-ascii?Q?PcFy3PBMRZWLlhZFhy14qW2Jm/ge1GZBER+TRIeSlaglSFvR6GDogiFY20uW?=
 =?us-ascii?Q?4OETyFHjAMe7EqW2jjzZa0zPuSkB/S53m1mvM47hT+AYC7qcJ5PtYWsz+vjC?=
 =?us-ascii?Q?gmRN3Z4KvodGEgSA13o3EKDlbcoIS+g3qfi9cJdI7G2zveqwKjsg64nEukfJ?=
 =?us-ascii?Q?7yeRhunOqrHv29E8+4D/Vqo5YjliQva2ybxFCzzp45+Ks+NCgu2eeD6d/QJY?=
 =?us-ascii?Q?OVnqmWIsphoEqf5AsCrTdsjuIu5WWR4hhcN8V4YUlbaxZS4PUipuWYMRe8rg?=
 =?us-ascii?Q?VJzSY9f8+tXUFTInmsBjwOSZ27KMDx/Typ4ZnXCz95yfRnMaGUGJEhvr/e78?=
 =?us-ascii?Q?xEu/yXzfrjvkg9FhjjSeAlXycYklq4y7Hc7//3+Cx4vLHiwBkH4zMniW1NJ7?=
 =?us-ascii?Q?r7XIsX+JDehgF494OUsUiH7ImRwfMwfBxuZjfSgmigKR+xutOIpKof7ZFeQW?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971bf5e8-0ab6-4efa-94cb-08dc3e31d1a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:04:47.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vl7R9DTyny7av2yBa1/RpkqtYnby42aFWCA+0CfKryu/iR/yk5XyH6K5ClgMS3ejIWhJ+9Q6/mXrS0RBZM7TQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

Enumerate per-channel coalescing parameters in the global coalescing
reconfiguration path. Add other variables global use_cqe_mode trackers for
Rx and Tx in order to support advertising the global CQE mode set while
also supporting per-channel configuration. The goal is to prepare the
driver to support per-channel coalescing configuration in downstream
patches.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h         | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b6b7e02069b8..1ae0d4635d8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -753,6 +753,12 @@ enum mlx5e_channel_state {
 	MLX5E_CHANNEL_NUM_STATES
 };
 
+struct mlx5e_moder {
+	struct dim_cq_moder dim;
+	/* Consumed when dim is not enabled */
+	struct ethtool_coalesce coal_params;
+};
+
 struct mlx5e_channel {
 	/* data path */
 	struct mlx5e_rq            rq;
@@ -794,6 +800,10 @@ struct mlx5e_channel {
 	int                        cpu;
 	/* Sync between icosq recovery and XSK enable/disable. */
 	struct mutex               icosq_recovery_lock;
+
+	/* coalescing configuration */
+	struct mlx5e_moder         rx_moder;
+	struct mlx5e_moder         tx_moder;
 };
 
 struct mlx5e_ptp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 616bfab5b186..b601a7db9672 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -570,6 +570,7 @@ mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct ethtool_coal
 	for (i = 0; i < priv->channels.num; ++i) {
 		struct mlx5e_channel *c = priv->channels.c[i];
 
+		c->tx_moder.coal_params = *coal;
 		for (tc = 0; tc < c->num_tc; tc++) {
 			mlx5_core_modify_cq_moderation(mdev,
 						&c->sq[tc].cq.mcq,
@@ -588,6 +589,7 @@ mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct ethtool_coal
 	for (i = 0; i < priv->channels.num; ++i) {
 		struct mlx5e_channel *c = priv->channels.c[i];
 
+		c->rx_moder.coal_params = *coal;
 		mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
 					       coal->rx_coalesce_usecs,
 					       coal->rx_max_coalesced_frames);
-- 
2.42.0


