Return-Path: <netdev+bounces-84861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161E898807
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6911C21EC9
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5D66BB44;
	Thu,  4 Apr 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eWR7V9yC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2138.outbound.protection.outlook.com [40.107.93.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3D8613E
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234306; cv=fail; b=u8vBLC6SDtjXulg5XiC0cJk1mXZ8riL0yWalyzesrv9QGoGfWDOuzd0tidL9NMG3NhLfwrw2rrb/ynAGHQZjS6SNswMz575kqMmTfow4tVIfFeJqXow6r2+emzFuDtyZSrjabicrkf0Hx9WEhz2/ogzh1qzwaQhpPjzIm5hIEIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234306; c=relaxed/simple;
	bh=nx6Zf87wlWQ629FCYTkGvEiVGIV1pik6aiIhhkCyJ2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NPqsm7hOjaGbvsBFNWHRaj2xmXrDKM6uz9ErtEgVK7pX7bysxpHFtpE0JzU8/mlHQbHgxMdV8EqsrtcGtT1J1wYYK8oZ9xxN+giHgki8RjH1XWnH+DVXl1Dojw/20EOv1BvlUl212gXCwrB0bISK5Wwpmi+ugpXGg/klxMoXJTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eWR7V9yC; arc=fail smtp.client-ip=40.107.93.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhOuRxwCEUchVP86xEkUzDyFrP0c35C9mWO5T9Hqd/ARFjOoAugNmU37bPsMK2vLclHoMrKUn/qfMddjAbMF5+nkcLeqijcBOwy4LelMBKXWQKEM7Dr9VvTLTH8XEr+QwXyuDQ9eVAsRtnj3l3HJMwMDuoMwLhOvzOIlB9ALPN0LD/7YNT0/cWOH79hM5eXxC8yXb3uCx+X324+jTbpsy5cs4vvhgj6mq6JCB6Xi1kFE9WcZw3w6J27/ERuN+z0HOvEGmeG0F6vgZLanjaJ4nwb2eM6fU0/8LhyVjGl4I0cxOVLG0Ysu4ZduBJZgtdpz/OUNOdMXZJs3Bcz0TPKnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCqAcGZpPGOq9O7ocZDPvFXywF9RV1vZ9oc4lfnG+zM=;
 b=CIy2Jb7zuEP8WkpZWnZkRqsXUKCUX9Yalmodr68gUk1n8o0MU+aQCywNDq4BbcwiqMGlqRx4121KGacUHnVGqSwdtHf5SHXCguEdYhpInUtyV53G9B336irBKAkO8Z8Lj1ag49aE0//nQbx4G6KglpxM8rCFQ70dOLcQwQJ69llPmVrKEbh/S/RRu6ANYZLGNH1T4IL26+TfeW5LPjaYhleFmfwjcysrgDdjx5BYNiMdc2NLMA/XX6eFKtKAEbNQa5MA/WzP7IoMWJc6XqEcgRtDvbfVtH07AZ/6fbN/TdCoy73LWgqYk+qXDQ7k6pdXLZ3OmGCpAwj53Td9XgIsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCqAcGZpPGOq9O7ocZDPvFXywF9RV1vZ9oc4lfnG+zM=;
 b=eWR7V9yCSWb58I//6u8f3QAyQQ9AtykR8/ur8GKfsH/mlpoB5xXDhXVFHtoDjKmFtM/TbPlZrwjsMlUSY+YkFIc8CygD4hg1WSq7F+CsQUwlyAOOZvzwMrPEbS3+GDO3IfNnqRosH6VgthzSHalSDKSnI1H/kvgDKJjNxaLa8FSfgYsvsLfIIyWOcjQHK5cGCQZU21X7czBmOffgkb5k/d3z0Md4uqZgyKWxpRP0V6FULRPxUiLA3Hag2gG0A0R/9PUa9bi7bBivZQNXR+jFFbNT4jlVKWsc9+VQFqndHEESKCqvhbU9Xo8ZFwuvigWEtWyNk7OT9vqMuQtpfO23Yw==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:38:21 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:38:21 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v24 10/20] net/mlx5e: Rename from tls to transport static params
Date: Thu,  4 Apr 2024 12:37:07 +0000
Message-Id: <20240404123717.11857-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB7104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2y3gxAfqO23PuBCZdnmVGOSw+pK941NahEtr9mViRjHQ5cTdqEXzkCsPscWWrUdLkwO37hGTsrm4lXVf+uYVnZDdSi7pPkHV6cGz3FrtgoTz5kwgJ5B5a/3VIJES/FT8FADSBTJL74wVqNskog1Io4vMkLyiJbAXlyG01EM39woaDLmV5aUgq3zLceJ8tND4jFmS+1xli0t0IAHdGbXKDg62ucqGbVVp6Wy+lxPy7iEIQvdo+gcwa9dOLDl7fndypCS0RbDg417KUFBgA39BHHmSDG9yeswaCzTarRrRz21LwPbzu7k+IGgZlyQoSY/XGCd2jBdA6BkFRFGQ99BKVNKyQ6xVIn8csM7nwegueBe9YKNss+gmtQthC30J/CJjQhn1hqf2uY3b1LbBQWWKYgESx4QBqRVHLWKZOiQYP+2Gpx7jq2JQ3OtMnuTih5+xx1OOlqpZYU/o34jmkRcPYk+5yvQzfkpGK4hXTdh2YDxY6mdMayDY+woD+LHL2nBBerULEuE8cgrCLxdDwWanxapoP3hgcImugP5Bp3ENJHFFsL+LWNBRxsXNmjPxO52TUlXtRf5Bv5TDp8hU/a9ABK2xNp7AXfD88nSGNcVWUQuujPv7dmxnVDdjxf0QqlL24+BWVp2/JvCbT1QmGNyaZ+kiD5PK9kdRcCqQZBadVrM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrJ8wet84AX5lc8DSCQMjNngwVs5KG5a3kF2hezeHUuUF6y40cq83/ZZSbAr?=
 =?us-ascii?Q?62C379kFpXsPgjmGP85PWENKqu9rbwFpjcmdau6n+uctUwDdgyS3X+vM+t4z?=
 =?us-ascii?Q?T3RarCBEg+0uLAhPz2tGKsNN4O6xKLEIx9k3NVQmurSeEbId409do4OcnoSY?=
 =?us-ascii?Q?2iTB3B8rFHeJGl8K18q/VFhKnXDusQiv5wh3TWiNNpdRLKns3stbH0ExeNF8?=
 =?us-ascii?Q?YttGOSSdoHto+2xE1CUaZkaWqFHOYzEvNyOl7ZCAQsec/84oT8kTVpE6Q1+K?=
 =?us-ascii?Q?6h2VOu24x4DLVhYRyRmGmCVehBLqTyNrl+W7baUmH8ONM8Mv5FZr+snXsjmM?=
 =?us-ascii?Q?w4xC3Gwq5Dh6kIAMU46JZUxGR6PsP2MYEbhJzZ6cbnyDRjwDYPvWtcclrsfP?=
 =?us-ascii?Q?v28ExmDEXLg6fHBalfUM35qhjK3HGVYo/yRM5jwBaiRjTGAtThaC3keC9Huw?=
 =?us-ascii?Q?UzcO4u1fRAI6nRqaTAVruTpIGjh8mr1btcHyLuPddM0zyx02MbYZ32uYosn6?=
 =?us-ascii?Q?xldOGOWls4LTEFkKuxJUichPiBdfvfpyD5M9svHyift8+sz2ZjNoIDmuJi1a?=
 =?us-ascii?Q?0cCKTJQKFSVnBzIsvroZ/1Yyint9GM15V2AHvJQWC8+qhqgbAtDeqor0Do6l?=
 =?us-ascii?Q?go+qKNWZZc/tQ0vO16x4pTZSGXSFBQjRK19TYY+Q8527Ao2lzgpf2bcoVll7?=
 =?us-ascii?Q?IYXHI/ehSfF3f5QjLg4AOKsVr4QcfuNMv5tXk1EXvJBU9CFwjdYiMOEt8RQs?=
 =?us-ascii?Q?3bqWY1J0xNN5HNRydXNufges4RU+6Eidv8eiEb3PRkx1T0T2i7EYHDnuT0PJ?=
 =?us-ascii?Q?X2/5PdFvC4rKdbiXjEvEsuu0g4iKuueYqplGDSoEKe0OXcwSUtNtMVvQKKZt?=
 =?us-ascii?Q?28upQs8WTVsjgSbEYWycrUds04dauAf4SDHUZdQQ06yKsFV9TGjOpGQOYIqk?=
 =?us-ascii?Q?Xyti/CVNJ60wrxf5HBC4PCeicEVeAbPLxlPiWXxqprAm2yKz1OYXSDgatpYL?=
 =?us-ascii?Q?LNJJnlzsbcH2x4bg5j7RDqrqUg9Kga0UBB1+H1j+Cx2F77frwhHQ24q8olf0?=
 =?us-ascii?Q?1wLrXIDnBh4i+GwUMhD7KZTYgbqTsTHc6NJ4Zi/VRFUJ9dIDmzq4yH6T9pgP?=
 =?us-ascii?Q?WvjUcLuxe5PaVUQCaEUCMrECWpt2XG0Vt4LaNa63rJtG9wPZMx4DTORnIbW2?=
 =?us-ascii?Q?yOb9WYMCjMZ09Tu9BTSU81ET8KrYO/b0jLGhUdJoWF54uhCy08QZ6drPJ8hS?=
 =?us-ascii?Q?iLKKNIz+ilrs1ZaaXAZfird/DDEzongK3++WbZ0YmCXTJr5vsJoEWpH9K4uY?=
 =?us-ascii?Q?Bh8t5WUkxXdH923FJCPssGwxdWyKw27AK8VnJyKFGx2SGtwH94AGuVAGvUFG?=
 =?us-ascii?Q?XGXFwI9tzlqK+tuSiVgMfHJR07c8n5dohDiDaJiBRY1Fwa1EI1gknivdaEjI?=
 =?us-ascii?Q?D+gR8cT9BSQK5Tg6PquT1PgJ3N/A4A+lXRbT6WAODCuz9C8GN34sL39xMGk8?=
 =?us-ascii?Q?EGluVlVfPnFIevJbYWUpnjkve3pppzjsHn2/YPnxPDcPy3BpcH3zd3TAOyTY?=
 =?us-ascii?Q?MafBVyZL558vM2FWffy2XSpfo+5NtH1wRS86JuIC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e0178f-25f9-4c71-66d8-08dc54a41c86
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:38:21.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qj9OYDQudSsfZLBQHYBCye9Ruc7CoAzzQshkrtJcgXVhf7eJ0qmU2eeqb7+3vjFSefEGm5zIujh/0LdBSzcaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

From: Or Gerlitz <ogerlitz@nvidia.com>

The static params structure is used in TLS but also in other
transports we're offloading like nvmeotcp:

- Rename the relevant structures/fields
- Create common file for appropriate transports
- Apply changes in the TLS code

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/en_accel/common_utils.h         | 32 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/ktls.c        |  2 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  6 ++--
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  8 ++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 36 ++++++++-----------
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  | 17 ++-------
 include/linux/mlx5/device.h                   |  8 ++---
 include/linux/mlx5/mlx5_ifc.h                 |  8 +++--
 8 files changed, 67 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
new file mode 100644
index 000000000000..efdf48125848
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_COMMON_UTILS_H__
+#define __MLX5E_COMMON_UTILS_H__
+
+#include "en.h"
+
+struct mlx5e_set_transport_static_params_wqe {
+	struct mlx5_wqe_ctrl_seg ctrl;
+	struct mlx5_wqe_umr_ctrl_seg uctrl;
+	struct mlx5_mkey_seg mkc;
+	struct mlx5_wqe_transport_static_params_seg params;
+};
+
+/* macros for transport_static_params handling */
+#define MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS \
+	(DIV_ROUND_UP(sizeof(struct mlx5e_set_transport_static_params_wqe), MLX5_SEND_WQE_BB))
+
+#define MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
+	((struct mlx5e_set_transport_static_params_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_transport_static_params_wqe)))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ \
+	(sizeof(struct mlx5e_set_transport_static_params_wqe))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT \
+	(DIV_ROUND_UP(MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ, MLX5_SEND_WQE_DS))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE \
+	(MLX5_ST_SZ_BYTES(transport_static_params) / MLX5_SEND_WQE_DS)
+
+#endif /* __MLX5E_COMMON_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index e3e57c849436..ab7468bddf42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -100,7 +100,7 @@ bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 		return false;
 
 	/* Check the possibility to post the required ICOSQ WQEs. */
-	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS))
+	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS))
 		return false;
 	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS))
 		return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 65ccb33edafb..3c501466634c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -136,16 +136,16 @@ static struct mlx5_wqe_ctrl_seg *
 post_static_params(struct mlx5e_icosq *sq,
 		   struct mlx5e_ktls_offload_context_rx *priv_rx)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	struct mlx5e_icosq_wqe_info wi;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, num_wqebbs)))
 		return ERR_PTR(-ENOSPC);
 
 	pi = mlx5e_icosq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_rx->crypto_info,
 				       mlx5e_tir_get_tirn(&priv_rx->tir),
 				       mlx5_crypto_dek_get_id(priv_rx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index d61be26a4df1..0691995470e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -33,7 +33,7 @@ u16 mlx5e_ktls_get_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 
 	num_dumps = mlx5e_ktls_dumps_num_wqes(params, MAX_SKB_FRAGS, TLS_MAX_PAYLOAD_SIZE);
 
-	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS);
+	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS);
 	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS);
 	stop_room += num_dumps * mlx5e_stop_room_for_wqe(mdev, MLX5E_KTLS_DUMP_WQEBBS);
 	stop_room += 1; /* fence nop */
@@ -550,12 +550,12 @@ post_static_params(struct mlx5e_txqsq *sq,
 		   struct mlx5e_ktls_offload_context_tx *priv_tx,
 		   bool fence)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_txqsq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_tx->crypto_info,
 				       priv_tx->tisn,
 				       mlx5_crypto_dek_get_id(priv_tx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
index 570a912dd6fa..8abea6fe6cd9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
@@ -8,10 +8,6 @@ enum {
 	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
 };
 
-enum {
-	MLX5E_ENCRYPTION_STANDARD_TLS = 0x1,
-};
-
 #define EXTRACT_INFO_FIELDS do { \
 	salt    = info->salt;    \
 	rec_seq = info->rec_seq; \
@@ -20,7 +16,7 @@ enum {
 } while (0)
 
 static void
-fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
+fill_static_params(struct mlx5_wqe_transport_static_params_seg *params,
 		   union mlx5e_crypto_info *crypto_info,
 		   u32 key_id, u32 resync_tcp_sn)
 {
@@ -53,25 +49,25 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		return;
 	}
 
-	gcm_iv      = MLX5_ADDR_OF(tls_static_params, ctx, gcm_iv);
-	initial_rn  = MLX5_ADDR_OF(tls_static_params, ctx, initial_record_number);
+	gcm_iv      = MLX5_ADDR_OF(transport_static_params, ctx, gcm_iv);
+	initial_rn  = MLX5_ADDR_OF(transport_static_params, ctx, initial_record_number);
 
 	memcpy(gcm_iv,      salt,    salt_sz);
 	memcpy(initial_rn,  rec_seq, rec_seq_sz);
 
 	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
 
-	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
-	MLX5_SET(tls_static_params, ctx, const_1, 1);
-	MLX5_SET(tls_static_params, ctx, const_2, 2);
-	MLX5_SET(tls_static_params, ctx, encryption_standard,
-		 MLX5E_ENCRYPTION_STANDARD_TLS);
-	MLX5_SET(tls_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
-	MLX5_SET(tls_static_params, ctx, dek_index, key_id);
+	MLX5_SET(transport_static_params, ctx, tls_version, tls_version);
+	MLX5_SET(transport_static_params, ctx, const_1, 1);
+	MLX5_SET(transport_static_params, ctx, const_2, 2);
+	MLX5_SET(transport_static_params, ctx, acc_type,
+		 MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS);
+	MLX5_SET(transport_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
+	MLX5_SET(transport_static_params, ctx, dek_index, key_id);
 }
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
@@ -80,19 +76,17 @@ mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg     *cseg  = &wqe->ctrl;
 	u8 opmod = direction == TLS_OFFLOAD_CTX_DIR_TX ?
-		MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS :
-		MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS;
-
-#define STATIC_PARAMS_DS_CNT DIV_ROUND_UP(sizeof(*wqe), MLX5_SEND_WQE_DS)
+		MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
 
 	cseg->opmod_idx_opcode = cpu_to_be32((pc << 8) | MLX5_OPCODE_UMR | (opmod << 24));
 	cseg->qpn_ds           = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
-					     STATIC_PARAMS_DS_CNT);
+					     MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT);
 	cseg->fm_ce_se         = fence ? MLX5_FENCE_MODE_INITIATOR_SMALL : 0;
 	cseg->tis_tir_num      = cpu_to_be32(tis_tir_num << 8);
 
 	ucseg->flags = MLX5_UMR_INLINE;
-	ucseg->bsf_octowords = cpu_to_be16(MLX5_ST_SZ_BYTES(tls_static_params) / 16);
+	ucseg->bsf_octowords = cpu_to_be16(MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE);
 
 	fill_static_params(&wqe->params, crypto_info, key_id, resync_tcp_sn);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
index 3d79cd379890..5e2d186778aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
@@ -6,6 +6,7 @@
 
 #include <net/tls.h>
 #include "en.h"
+#include "en_accel/common_utils.h"
 
 enum {
 	MLX5E_TLS_PROGRESS_PARAMS_AUTH_STATE_NO_OFFLOAD     = 0,
@@ -33,13 +34,6 @@ union mlx5e_crypto_info {
 	struct tls12_crypto_info_aes_gcm_256 crypto_info_256;
 };
 
-struct mlx5e_set_tls_static_params_wqe {
-	struct mlx5_wqe_ctrl_seg ctrl;
-	struct mlx5_wqe_umr_ctrl_seg uctrl;
-	struct mlx5_mkey_seg mkc;
-	struct mlx5_wqe_tls_static_params_seg params;
-};
-
 struct mlx5e_set_tls_progress_params_wqe {
 	struct mlx5_wqe_ctrl_seg ctrl;
 	struct mlx5_wqe_tls_progress_params_seg params;
@@ -50,19 +44,12 @@ struct mlx5e_get_tls_progress_params_wqe {
 	struct mlx5_seg_get_psv  psv;
 };
 
-#define MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS \
-	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_static_params_wqe), MLX5_SEND_WQE_BB))
-
 #define MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
 #define MLX5E_KTLS_GET_PROGRESS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_get_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
-#define MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
-	((struct mlx5e_set_tls_static_params_wqe *)\
-	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_static_params_wqe)))
-
 #define MLX5E_TLS_FETCH_SET_PROGRESS_PARAMS_WQE(sq, pi) \
 	((struct mlx5e_set_tls_progress_params_wqe *)\
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_progress_params_wqe)))
@@ -76,7 +63,7 @@ struct mlx5e_get_tls_progress_params_wqe {
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_dump_wqe)))
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 01275c6e8468..66783d63ab97 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -454,8 +454,8 @@ enum {
 };
 
 enum {
-	MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS = 0x1,
-	MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS = 0x2,
+	MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS = 0x1,
+	MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS = 0x2,
 };
 
 enum {
@@ -463,8 +463,8 @@ enum {
 	MLX5_OPC_MOD_TLS_TIR_PROGRESS_PARAMS = 0x2,
 };
 
-struct mlx5_wqe_tls_static_params_seg {
-	u8     ctx[MLX5_ST_SZ_BYTES(tls_static_params)];
+struct mlx5_wqe_transport_static_params_seg {
+	u8     ctx[MLX5_ST_SZ_BYTES(transport_static_params)];
 };
 
 struct mlx5_wqe_tls_progress_params_seg {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c940b329a475..f7784cee832e 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12413,12 +12413,16 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
 };
 
-struct mlx5_ifc_tls_static_params_bits {
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+};
+
+struct mlx5_ifc_transport_static_params_bits {
 	u8         const_2[0x2];
 	u8         tls_version[0x4];
 	u8         const_1[0x2];
 	u8         reserved_at_8[0x14];
-	u8         encryption_standard[0x4];
+	u8         acc_type[0x4];
 
 	u8         reserved_at_20[0x20];
 
-- 
2.34.1


