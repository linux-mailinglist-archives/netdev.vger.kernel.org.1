Return-Path: <netdev+bounces-78141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A087436C
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2736282153
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09A1C6A3;
	Wed,  6 Mar 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lLw4k91n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142F1C69C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766297; cv=fail; b=SgUNRoF5xOuINiXUmNwBAWVtyVDhpcN9hQhzB7IgZh9qYwH91UeCyKgWBi1wW69kxLjZdT6s8+irBG1mKwLjnXLQt/RIa44hNyNLZRxQ/+Sk2/VTEx/JTo86yTCvSJ4bpn23gig/pk6irhTF5kLcgeMLWAMzel8YPidrqUBf7EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766297; c=relaxed/simple;
	bh=EcpoU4UQOalx8XPWx41qUYVePYJkb9acIIbnsIeKBXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amOKbbjlog+XG8oxe990gU+W7Hn3tU+SGqEB7TlRh+BiiCKEX2VIfRCCV9buRKvpNvSWsASvzWWWbVF/g0Nf3FxNmFxarp445FHeqJsetoXvWm0KA8SYm2vIhpZsWxTpbZbpdUkleT79e7oxx9uDfkLd2GSyru/icfXfl8ho628=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lLw4k91n; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4jwL2TA0X4gn3p1f32xarKgJFSO8BEHU9B1A3evHqS9ScdQfo1A1GiqZX5ryRfF68u1lbsW0TonnGSSPEQmeyFampnN2h7YeeLWBhKFL4HLGOm4imGlP7H1PnBzYWdcbBSPQY49HX/A+4MZtXYYtqFJ+q51p8fRvMLLj9No0IWB6DTL1KXzmVkt2jVGgApfwQxP9hNpdTPlYS7S5WXXr+ITdIppSYSywmi1AuVyOmpxB3g02l9HF50nvoOXtHi8ISn5tA6Fgz8ZUtmIeabs74q6uUYH8hgT8GxhWCc6q21m8P6XIfDUiOd3BNMIE9ZaVhw2jwhKs+gndNhRcWUUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ke+oUbTVLPVQNNvHhB7EDOWx5Mr9CWNIeTDdBPUtYI=;
 b=hcLdK5DX2M/k1iMtgLFg4C2ZRbb5juNyrmF6JlszXfXJBss2Vam63sy3+VHXQvCWIJPjH0soWtChumvPYvCZlCXuOIMy5tqmxKLT5axGA5ikzgQpR4EdQrgmSuKU+HxxkOpzd1NicyD0AsfeAGaKUb4KLwKF22+znzk5SrwvJjRVL4c7v6QuzhMWGtasT6L8uoFTCgOLC8S3leMWAI3tuInaHTsP2OI5L+pFbQKkwWVOaKS+jaC6H0P54Yb0AfberKM15kaZpAqhrVXBbIuMQlXy+2j8vEDrB6lbQM9X67cc3SteTAEnH3OPk+ZhLF7Qo7db/O0XdyaybQ7alDUrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ke+oUbTVLPVQNNvHhB7EDOWx5Mr9CWNIeTDdBPUtYI=;
 b=lLw4k91nyFhRLshvOGS1JhhMf7aOG3ABCcPsTZl6xCniPDDeWnoBnbKbtoCsVZ7F/Ca3oLvHn935iIr1hMF7nDJTxNmMO5b5Cz8zhdiP+L00OtseWUnq2lkPX+bBXmwtMZ7x/UtzN5LnJDFCBfN39rZCXE2T9TAqe+jSQ0WeX+9NtlOBf8W/JraAy77g/8DRXtjLK9luFkfmYAVhqK+h4mmQbnO07bajYExbDCN0fe7kE9lnsF1Yky8KSs/5h1g6QSXit3LXz8XfJLVaMHy3NEze7fiI+igAIaF0h8pCCnyxrJXh5/T6QKppRzPcaHS2zs0YafUSC3gVb4DX96za/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 23:04:48 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:04:48 +0000
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
Subject: [PATCH RFC 2/6] net/mlx5e: Use DIM constants for CQ period mode parameter
Date: Wed,  6 Mar 2024 15:04:18 -0800
Message-ID: <20240306230439.647123-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306230439.647123-1-rrameshbabu@nvidia.com>
References: <20240306230439.647123-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::24) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 4779d495-8ff4-4858-e2e3-08dc3e31d0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0yBemWc/aj0oOccelz6hNiSJtZzc+pn8sDFb2lZO+CzizXzofU3BOATDpMbMYziJnEFf/HMyZfVxqQcIz9pOrFBAzfxb4ItHKEEzhAZOwcV4TwQsvlHDbZd3hHlIZqJE/TwHu8xbeLDytszyjnaXT63FKT7orOg7VtcRMxx+AhFSycVwrBMLbGvuEhGNlSx0fXwsUcY0b6eyzzqqLLSq8WlgK0OKxVmsj8v+nN14Yb82VPIkbf4wUUltEvsq5pdStwOekmZ8IejsQPK+K3qksdTDr+MGvfNNu8MUcEQT9vhEXYm6norTjXmZr0tT82R9Oie0rqYLOZ8I98JsovkwL2g694PHMQ027pkefTazFlQbQ+Yu3FqiRnDfVyAXXTUG5ue+0reYpeio8hop8GdJHq2VokkG4HYpKA4Ekef6Y5rWkbL070rW3TT3Gv9YDzlzdXwW96yVUVA5DZuvzQGHnkkiztQnKt6UjzyRDz+QBPXPH/YI3XQ91VQRhcuzSPNvMR4yupiNOFJfyaArr5TdCUG/uywuN8Ee3sXVHtqu/P6iHsX04Xvb8QcK7VXi+ZVCXZLwwHdglgc+Pmi14gZ2cKHJLry3e+GsnTxHK7WOlN+3UJtMO8PfgVqBv6NOsTtuRdaVJbhqg3JeBNBNTPtzCS4dtoOwywnTYgg2wC03sKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZUadknHMDItd3sb/r8dW0N5DLr/TetiNix/iBvfVdcPJ7UMC/jn3jUvygDGM?=
 =?us-ascii?Q?uwWWHdAzPhRi4GOmYjvY+941Yq/j65plUKMdT83styQu7GtiuwF17H4KqB20?=
 =?us-ascii?Q?LsGM5sV6dWY9ayzpP9l0PLcOTL2qSHPmhxnNMyQvtPH1OcUg7ASZcOX1bB51?=
 =?us-ascii?Q?JNLnn0Vp5CQhwn2Hh87+oy+xwfHYMhR6u27R15GpGSQik35VHAMa2Kctj6TO?=
 =?us-ascii?Q?cAB5ubvf2RUgU86QXlfiz8VAZ04//5nDXY6OnwDSNAsuOLQw768//GYr+UKH?=
 =?us-ascii?Q?eLPlD6q1SYXz3qXBpxaq7cxaiFRIYRgubHfccrV5U0OU91zOwtoaKY4+vqZA?=
 =?us-ascii?Q?orGaymcr60wcSR7FdBu1N/BbZHDJdKJVqeAFN5f8PXigdcW3g5eYt8wYtqmz?=
 =?us-ascii?Q?4lwJ9LA3jIp625e6EhpJb6hXHVnPeQjU3A/9Uz5NXALJa7KxWFHzJhKObvmj?=
 =?us-ascii?Q?j6EZZVsR8o4CyreDFxgQEdNkzJkQs8gvMqb5+hBkF8iJlw/NDE1F6p+bH6IN?=
 =?us-ascii?Q?QmvKUZBzvL67lnill9YKxtnHcSdprE72pK4+DILFlZ7wbvtNxLdQytGG0XaE?=
 =?us-ascii?Q?+c+AjgcPn8JMtEoOcn9PwLFE9yQCFS49K+DapTWCKwWxNVRhmRBiH+xqpQYm?=
 =?us-ascii?Q?gng3bZgjDz0mBMc21fZK1UfdH8wSimr1SPx2u8kSWeadb2dYDtOsBm2XOs4R?=
 =?us-ascii?Q?ahSQoIhy/X1UJ6AYA62S9XGynaaDjfcfSw00v6oPLvxi7FATyv+/gbHmRJ7E?=
 =?us-ascii?Q?mX2UQQXp9WUN5oxf9Bt1TqS+UelkcTzmHOCqg0xR1tRyxAjaGXiXw+pNvlES?=
 =?us-ascii?Q?yU2GtjzL54+oCb2ZV3VHkuLHucL1407lNbTWWae2JUdU6Bxtat+H0yfWAxXV?=
 =?us-ascii?Q?OTT0i34SUri//S1nOB+9RVmfExQFekr8Uk9x3aL2bOBiVMLuq3cPmCRgd8ii?=
 =?us-ascii?Q?KXRpEAYrwfWAnETbRlMjPftUxB/SpUqxdCcPF5OxiXWNrOxSqFb+HsZmSAYi?=
 =?us-ascii?Q?xO7j1Foo+WMTealUv3HSyyrpdiCetp4BWiB2UgT7mmnP0Ibw4UhHxnHFV9dn?=
 =?us-ascii?Q?MFJuKOwaWiS002YbSueMaO5ZK7QQapiA0sqbyTNiD6pOger5TEhckBhrDxK3?=
 =?us-ascii?Q?vLj4a0xc8WoTaXB05DoGMRPmO+2F4VMAGuUjoXNu0hFH1bxN9KFQ5LLFlfw6?=
 =?us-ascii?Q?mxWmupK6U8jSPaaCbPmsdP6mLkYa/2MxvPwV3EPMyvIc+0Nsi/HDTvSj0Vsp?=
 =?us-ascii?Q?qfdUYqE9p6pl6OixLYDr1Gx9FlxlQkQepkOPhyYkhmKCyL6vlDp+bYypV4Dd?=
 =?us-ascii?Q?02YQvIpLBIkwxps31EYWIMfDxdsawt2R57YKpZHt4xSOU0l8hH7qpa+0TVia?=
 =?us-ascii?Q?s5XziEmpF1lvTnqtCFHhY9CEJW2bLZdq5eF6i1nKXVX5h6BksXeW/OZB7m8s?=
 =?us-ascii?Q?s8/qqzVVaTDrhHIBlGD/VBF7083pkrbcMbo5Zo77N2D6NYQ2MI7gxcy0ElZN?=
 =?us-ascii?Q?KdLpqxPUBzZ5T9dru1MLBgIoQSgNJ6p7vFTK1wvtF9HFCTCrPfmBudPYi1P+?=
 =?us-ascii?Q?OPCP9BXNvHa+eaVko9Q03Sow+qLGECx2voS9x4ZS9Qa7ifqkH6XUTD6Mu+8w?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4779d495-8ff4-4858-e2e3-08dc3e31d0ec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:04:46.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDR6vevF0tw2fpoDy/2tvgyvTPeBLxVXrZy4524CY6nQcaoc/llV/UDVTvNiw0KzdVJc0jMVh/U4pIA+s0gCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

Use core DIM CQ period mode enum values for the CQ parameter for the period
mode. Translate the value to the specific mlx5 device constant for the
selected period mode when creating a CQ. Avoid needing to translate mlx5
device constants to DIM constants for core DIM functionality.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/dim.h  | 26 ++++++++++++++
 .../ethernet/mellanox/mlx5/core/en/params.c   | 34 ++++++-------------
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 16 +++------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 20 ++++-------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  7 ++--
 include/linux/mlx5/mlx5_ifc.h                 |  4 +--
 6 files changed, 53 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
index cd2cf647c85a..6411ae4c6b94 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
@@ -4,11 +4,37 @@
 #ifndef __MLX5_EN_DIM_H__
 #define __MLX5_EN_DIM_H__
 
+#include <linux/dim.h>
 #include <linux/types.h>
+#include <linux/mlx5/mlx5_ifc.h>
 
 /* Forward declarations */
 struct work_struct;
 
+/* convert a boolean value for cqe mode to appropriate dim constant
+ * true  : DIM_CQ_PERIOD_MODE_START_FROM_CQE
+ * false : DIM_CQ_PERIOD_MODE_START_FROM_EQE
+ */
+static inline int mlx5e_dim_cq_period_mode(bool start_from_cqe)
+{
+	return start_from_cqe ? DIM_CQ_PERIOD_MODE_START_FROM_CQE :
+		DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+}
+
+static inline enum mlx5_cq_period_mode
+mlx5e_cq_period_mode(enum dim_cq_period_mode cq_period_mode)
+{
+	switch (cq_period_mode) {
+	case DIM_CQ_PERIOD_MODE_START_FROM_EQE:
+		return MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
+	case DIM_CQ_PERIOD_MODE_START_FROM_CQE:
+		return MLX5_CQ_PERIOD_MODE_START_FROM_CQE;
+	default:
+		WARN_ON_ONCE(true);
+		return MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
+	}
+}
+
 void mlx5e_rx_dim_work(struct work_struct *work);
 void mlx5e_tx_dim_work(struct work_struct *work);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 5757f4f10c12..35ad76e486b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -6,6 +6,7 @@
 #include "en/port.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ipsec.h"
+#include <linux/dim.h>
 #include <net/page_pool/types.h>
 #include <net/xdp_sock_drv.h>
 
@@ -520,7 +521,7 @@ static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
 	moder.cq_period_mode = cq_period_mode;
 	moder.pkts = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_PKTS;
 	moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC;
-	if (cq_period_mode == MLX5_CQ_PERIOD_MODE_START_FROM_CQE)
+	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
 		moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC_FROM_CQE;
 
 	return moder;
@@ -533,39 +534,26 @@ static struct dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
 	moder.cq_period_mode = cq_period_mode;
 	moder.pkts = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_PKTS;
 	moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC;
-	if (cq_period_mode == MLX5_CQ_PERIOD_MODE_START_FROM_CQE)
+	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
 		moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC_FROM_CQE;
 
 	return moder;
 }
 
-static u8 mlx5_to_net_dim_cq_period_mode(u8 cq_period_mode)
-{
-	return cq_period_mode == MLX5_CQ_PERIOD_MODE_START_FROM_CQE ?
-		DIM_CQ_PERIOD_MODE_START_FROM_CQE :
-		DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-}
-
 void mlx5e_reset_tx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
 {
-	if (params->tx_dim_enabled) {
-		u8 dim_period_mode = mlx5_to_net_dim_cq_period_mode(cq_period_mode);
-
-		params->tx_cq_moderation = net_dim_get_def_tx_moderation(dim_period_mode);
-	} else {
+	if (params->tx_dim_enabled)
+		params->tx_cq_moderation = net_dim_get_def_tx_moderation(cq_period_mode);
+	else
 		params->tx_cq_moderation = mlx5e_get_def_tx_moderation(cq_period_mode);
-	}
 }
 
 void mlx5e_reset_rx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
 {
-	if (params->rx_dim_enabled) {
-		u8 dim_period_mode = mlx5_to_net_dim_cq_period_mode(cq_period_mode);
-
-		params->rx_cq_moderation = net_dim_get_def_rx_moderation(dim_period_mode);
-	} else {
+	if (params->rx_dim_enabled)
+		params->rx_cq_moderation = net_dim_get_def_rx_moderation(cq_period_mode);
+	else
 		params->rx_cq_moderation = mlx5e_get_def_rx_moderation(cq_period_mode);
-	}
 }
 
 void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
@@ -573,7 +561,7 @@ void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
 	mlx5e_reset_tx_moderation(params, cq_period_mode);
 	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_TX_CQE_BASED_MODER,
 			params->tx_cq_moderation.cq_period_mode ==
-				MLX5_CQ_PERIOD_MODE_START_FROM_CQE);
+				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
 }
 
 void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
@@ -581,7 +569,7 @@ void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
 	mlx5e_reset_rx_moderation(params, cq_period_mode);
 	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_RX_CQE_BASED_MODER,
 			params->rx_cq_moderation.cq_period_mode ==
-				MLX5_CQ_PERIOD_MODE_START_FROM_CQE);
+				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
 }
 
 bool slow_pci_heuristic(struct mlx5_core_dev *mdev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 9b3bfa643fd1..616bfab5b186 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/dim.h>
 #include <linux/ethtool_netlink.h>
 
 #include "en.h"
@@ -593,15 +594,6 @@ mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct ethtool_coal
 	}
 }
 
-/* convert a boolean value of cq_mode to mlx5 period mode
- * true  : MLX5_CQ_PERIOD_MODE_START_FROM_CQE
- * false : MLX5_CQ_PERIOD_MODE_START_FROM_EQE
- */
-static int cqe_mode_to_period_mode(bool val)
-{
-	return val ? MLX5_CQ_PERIOD_MODE_START_FROM_CQE : MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
-}
-
 int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
 			       struct kernel_ethtool_coalesce *kernel_coal,
@@ -654,13 +646,13 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 	reset_rx = !!coal->use_adaptive_rx_coalesce != priv->channels.params.rx_dim_enabled;
 	reset_tx = !!coal->use_adaptive_tx_coalesce != priv->channels.params.tx_dim_enabled;
 
-	cq_period_mode = cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_rx);
+	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_rx);
 	if (cq_period_mode != rx_moder->cq_period_mode) {
 		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
 		reset_rx = true;
 	}
 
-	cq_period_mode = cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_tx);
+	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_tx);
 	if (cq_period_mode != tx_moder->cq_period_mode) {
 		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
 		reset_tx = true;
@@ -1868,7 +1860,7 @@ static int set_pflag_cqe_based_moder(struct net_device *netdev, bool enable,
 	if (enable && !MLX5_CAP_GEN(priv->mdev, cq_period_start_from_cqe))
 		return -EOPNOTSUPP;
 
-	cq_period_mode = cqe_mode_to_period_mode(enable);
+	cq_period_mode = mlx5e_dim_cq_period_mode(enable);
 
 	current_cq_period_mode = is_rx_cq ?
 		priv->channels.params.rx_cq_moderation.cq_period_mode :
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 7721d7656aee..f871498a1427 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/dim.h>
 #include <net/tc_act/tc_gact.h>
 #include <linux/mlx5/fs.h>
 #include <net/vxlan.h>
@@ -961,15 +962,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 	}
 
 	INIT_WORK(&rq->dim.work, mlx5e_rx_dim_work);
-
-	switch (params->rx_cq_moderation.cq_period_mode) {
-	case MLX5_CQ_PERIOD_MODE_START_FROM_CQE:
-		rq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
-		break;
-	case MLX5_CQ_PERIOD_MODE_START_FROM_EQE:
-	default:
-		rq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-	}
+	rq->dim.mode = params->rx_cq_moderation.cq_period_mode;
 
 	return 0;
 
@@ -2088,7 +2081,7 @@ static int mlx5e_create_cq(struct mlx5e_cq *cq, struct mlx5e_cq_param *param)
 	mlx5_fill_page_frag_array(&cq->wq_ctrl.buf,
 				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
 
-	MLX5_SET(cqc,   cqc, cq_period_mode, param->cq_period_mode);
+	MLX5_SET(cqc,   cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
 	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
 	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
 	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
@@ -5048,13 +5041,12 @@ void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16
 	params->packet_merge.timeout = mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_LRO_TIMEOUT);
 
 	/* CQ moderation params */
-	rx_cq_period_mode = MLX5_CAP_GEN(mdev, cq_period_start_from_cqe) ?
-			MLX5_CQ_PERIOD_MODE_START_FROM_CQE :
-			MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
+	rx_cq_period_mode =
+		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
 	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
 	params->tx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
 	mlx5e_set_rx_cq_mode_params(params, rx_cq_period_mode);
-	mlx5e_set_tx_cq_mode_params(params, MLX5_CQ_PERIOD_MODE_START_FROM_EQE);
+	mlx5e_set_tx_cq_mode_params(params, DIM_CQ_PERIOD_MODE_START_FROM_EQE);
 
 	/* TX inline */
 	mlx5_query_min_inline(mdev, &params->tx_min_inline_mode);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 05527418fa64..d38ae33440fc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/dim.h>
 #include <linux/debugfs.h>
 #include <linux/mlx5/fs.h>
 #include <net/switchdev.h>
@@ -40,6 +41,7 @@
 
 #include "eswitch.h"
 #include "en.h"
+#include "en/dim.h"
 #include "en_rep.h"
 #include "en/params.h"
 #include "en/txrx.h"
@@ -804,9 +806,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_params *params;
 
-	u8 cq_period_mode = MLX5_CAP_GEN(mdev, cq_period_start_from_cqe) ?
-					 MLX5_CQ_PERIOD_MODE_START_FROM_CQE :
-					 MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
+	u8 cq_period_mode =
+		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
 
 	params = &priv->channels.params;
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 7f5e846eb46d..f7f1f058491f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -4361,10 +4361,10 @@ enum {
 	MLX5_CQC_ST_FIRED                                 = 0xa,
 };
 
-enum {
+enum mlx5_cq_period_mode {
 	MLX5_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
 	MLX5_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
-	MLX5_CQ_PERIOD_NUM_MODES
+	MLX5_CQ_PERIOD_NUM_MODES,
 };
 
 struct mlx5_ifc_cqc_bits {
-- 
2.42.0


