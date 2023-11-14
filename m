Return-Path: <netdev+bounces-47711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220857EB015
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E891C20AB1
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881AB3FB14;
	Tue, 14 Nov 2023 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uDrb+0ox"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAF3FB12
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:44:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E90F134
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:44:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3yqT2bOaLzMJ6Uk2e3VsS7tjj3UY4VKGoLfPz6idut+tQAn3TvtZFljdoTJVC0S5zUMc//I2jqRNcyvQFB8KjpkWVAL0AfauXrcWHBsyphPd0xvsUldr+uM0EujgLog/Ct5UPk1a4NZqrgPJs0qDOKogaP7COJ2paCE9rcB4Aaq1iRyWuIBJk/RER1lrz3Gi3KSLZpZW5IDODCgjN7wAv+E4ErNFNmBCpEJOtixYs9ZIdm5APWQwamP9gjpMBEqh+bqP9SBX74lHQJQUkrY3yTYtyZ44z18SXjdarlctqcEH3prl5TYf7sxBgE+jkKqVQjvXl21WNJYq4q7gZ9IFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXTjpij+TfNkLmXVlksOEIvIrpZF5dUViLD5ofAKtLY=;
 b=Qt/RW9mEU6dK7Yq2Gp5IrZNA9BHQH6yVaQfRn64qX2ZX5CTQWuC0Pk0M4JLwKlx+G3l7XdMgosEGwZpefTPkhimg0p5Do3+shLcgZ3piXexYVrMRCVNmcnRp48kBMhFZ9qvMxM6N2JeaTwPBAZ/oubIN7UUldLkIi3P+HkDOC9dsIPnTOibXmhwMxRXIPnivPKuSvb/Asqv9RC0aEoAONF0D057kFQ+sMu8iLcwTpt/vSSgzib+HDNDfKJpXcWspyhmx3X2eJwsToyVb1OCMefkG9CCc/+OnKNVkbfKKqSpujMMsM8wC34N5/U1PP03X3ctXxg8YVecZZl5P9JXY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXTjpij+TfNkLmXVlksOEIvIrpZF5dUViLD5ofAKtLY=;
 b=uDrb+0oxGrGWIxC9vGsXelqfzSv5Wu3t/f/OCmVF1dU8GVn+tXkmcSH0oiidcC7gTHwl2u6aU2jM1DZGX6kCgJSTmXr8oRzT4MGV2lsXBK2CpA8pXNyvRYIrIo7J43Z7H8CSlWQvRq+N95a/5x5Z7SOQ0UeIeuT/JMEVK9R/f3cxkczd02k03VvuSvuc3d5tw8cTHd+NA3GUumqPUbR7rN2lSyzuK5n9wvqF3Y1sKT7K0MNIa8DvUATBk8VDaf17WAhhXwHFbVVcmiQb8E0jHOoUu01N4xWN60xw34/G3Qu9YcRK2H6vm+2ofF0mBMXNTnZDOBI+lKdqWUf9U52rzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:44:11 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:44:11 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v19 13/20] net/mlx5e: NVMEoTCP, offload initialization
Date: Tue, 14 Nov 2023 12:42:47 +0000
Message-Id: <20231114124255.765473-14-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0295.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d69ae2f-a865-4db9-9237-08dbe50f668a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6bsXLmubjAMuQSi2qAjfWIOzBWyh2aMDNxcXV0scLqHyjM7sindRXT9sWMyN3yHK+Ynk3vvbx+OcVb+JAviPH1Xo+GEu8+4lAda35LADj/QpDktwyy3yscmFsUwXaEuaLmF+6CAZ9IZMZePWT1gH3lhbxw4RliC7ZLMXY8hmtOQyXuwCcOB0UtTrvcmQJ8kg7+NwBVr5Ev8UxwRlI9umxVwRw3sMYJEv8V4ADaDb1yzCuRoUTw677Zwsww07WX9B9WMj2opj73IklG5uP7KEPP8jAWTCDHAO0quMk0JQFuhxkx+Gzl9zYresIXf3H9ZtxSPMH/WF3gi2st2Z+z8+3RCYPA2ZZBnxINBmPlkzE0rFC910fOIvowVftUxP8uelE3U1YxmZwJSWJ6gN8F6FyKindfZWoqbzpQXUOR8bijZKl9ziBvq4BIlrZeteAUF2Th8Zx5SUD2jIL5OYnsfvrBU4ypC9rni+UY+BVFUH2Dn2fQMBTRUSGOy8NMqKLzKzASoiiycvP9xpExBxpxX8NtWvsi7KuH+dH0sXsae2rkQcT95JuZzx18/egaBJiP0k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(1076003)(107886003)(6506007)(6666004)(2616005)(6512007)(83380400001)(8936002)(4326008)(5660300002)(7416002)(41300700001)(8676002)(30864003)(2906002)(6486002)(478600001)(316002)(66556008)(66946007)(66476007)(86362001)(38100700002)(36756003)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O2r1nCkWgLn5u41C9Q2fiibyKEM45gBo+RNLw2IAKO1ecn5DmsAn9C7VNOZ8?=
 =?us-ascii?Q?REsnohmQreQA3+RqrK5yu7uML3k479Tg8GC+JEKM4SycD9d7C+OTfUlgwvKo?=
 =?us-ascii?Q?8xnaN3KGNUKR1K2pKnppvewtJifXQf/xDvebSQCqP8rX6F6pZqWfg3JcP0p4?=
 =?us-ascii?Q?UcQWT32JCdgVTDJxQYBj7iQvxG5ILPIG/FVd1/ItlZe95EprSigZz2z7arNA?=
 =?us-ascii?Q?IbJ8gmLzxujVfmrHqQc9PT1iblN0hNH2ta5hQaMzpkOmsSCisrcF6fe8PlfL?=
 =?us-ascii?Q?Gfeu+3WNW7MQbxwL2zJ1mxsKp/ZC6pYzSiBZLNj4J+/ckUYolY26L1GrR/i1?=
 =?us-ascii?Q?tBBfT5oSHGSoHVH/K/FyVoIxiZFxYOZbhSa9UbuZP4eZlSzL1xEndJEk04pq?=
 =?us-ascii?Q?yT8+BxpV8tltyFBnUwNOBdMSH2td67PO6TJ1Qq51xukE35MaOJVicxFglfx/?=
 =?us-ascii?Q?nLvnZUPjkyPuHDu9NrAFILWUO9xKBeIewm3BZjJ0fcFBA92wSQWAxkXK2IPw?=
 =?us-ascii?Q?G0mCfLkcG0NezuACPAI78CLD4LGRoRPfEDhUCXnY5gY3S0rxk6kXIS2NOHEd?=
 =?us-ascii?Q?vIEChTj8n89u3lKUZReKKLn1A615HjgqOhShyBM4cWLi751P/yWxbXmmvcmf?=
 =?us-ascii?Q?zICDGdXOq1Juj77Cf5+nqDO9QGTGatWRRpT8ocwyvSjO4S2w4DHmyJVqDEL4?=
 =?us-ascii?Q?Crr5BO3mmm0XkwgMXznh+O0BfzMNhS0bopPm8TXIYK6wc50iZp2SAh81hzry?=
 =?us-ascii?Q?F0ZIPEXvkyMOvT3/3dBZZre7FcfccGGEUoRr5OuugwpyNQZffyoZy84xa0yG?=
 =?us-ascii?Q?T0mhSISA1orn+BrlpafDcEXbS86IAPuN/sTMrgAS5/2fc5XKsypfm8VcjL/i?=
 =?us-ascii?Q?D8ehdEVgpZpeV4oylSAPh71B/eimgUOG63D25dgZOpcO0ATDCmbNniJxc/Hl?=
 =?us-ascii?Q?6J36/EXycO7/Nflb1XYY1Uk/OFTK6q3NKdsVqkzllEybh6UVfioYNeMEO5Nw?=
 =?us-ascii?Q?RfohR3Xj6ahqLAuV0EF/GkolPa+bPYOhpJY32dI+jRMV2TYBh7XvsZVUzqkY?=
 =?us-ascii?Q?iixyXgSr1fXgz3atuuNHmaX3Yf1zBfFom0TNYalm9a+msf2dc2DwCdr+hbvK?=
 =?us-ascii?Q?1vJORkgBeKkpFaR2xWDVkSkJj/ZgsCooj1mpnCp+XBgYwk89tJh7lhGdNRSx?=
 =?us-ascii?Q?yXQM49RUzcwGiLBUQOItbLGl581LL4wqoSHL21+raELkxBQ+x+bvLeSPC/KX?=
 =?us-ascii?Q?gEFYlePxXrdYiZiRoiFeT+Dm4A6p3Uvwmez8l4K4pacXqw6l6p9XfMK2ab3F?=
 =?us-ascii?Q?aW5T6g3sUP8GEE6lEQf79f0m2BVYirYjs7/OhT3jG2kmXoGgZNp6yYl0o7MH?=
 =?us-ascii?Q?9QpXJUQoL4dxbUKulwMSwgb/yPTCs+fxITq7mnj5T0amtdBMmXPXAW3LLvQh?=
 =?us-ascii?Q?bYJ557WclqqUj+603OggksL1weGLwozx3y9k7nnNAicC8a47FqgGS4GncFyE?=
 =?us-ascii?Q?tq/MufJcgoa16m2Di/gdV8B1CL3wjilrIB/j9Z8Yz376qz+Q4dmIJSpmHEkW?=
 =?us-ascii?Q?DZmFLJvE+2raR/SDC8y7Y/5op4jpi/PRZC2sd1q7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d69ae2f-a865-4db9-9237-08dbe50f668a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:44:11.3359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9gaEyZqiEAs9t8hFGpWcEjeqSuhUnDJ0EJH8LAVuY8hOEfF1n1teegR+aj+gOugzu1Bi5JOD7UGtFthJhgQwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463

From: Ben Ben-Ishay <benishay@nvidia.com>

This commit introduces the driver structures and initialization blocks
for NVMEoTCP offload. The mlx5 nvmeotcp structures are:

- queue (mlx5e_nvmeotcp_queue) - pairs 1:1 with nvmeotcp driver queues and
  deals with the offloading parts. The mlx5e queue is accessed in the ddp
  ops: initialized on sk_add, used in ddp setup,teardown,resync and in the
  fast path when dealing with packets, destroyed in the sk_del op.

- queue entry (nvmeotcp_queue_entry) - pairs 1:1 with offloaded IO from
  that queue. Keeps pointers to the SG elements describing the buffers
  used for the IO and the ddp context of it.

- queue handler (mlx5e_nvmeotcp_queue_handler) - we use icosq per NVME-TCP
  queue for UMR mapping as part of the ddp offload. Those dedicated SQs are
  unique in the sense that they are driven directly by the NVME-TCP layer
  to submit and invalidate ddp requests.
  Since the life-cycle of these icosqs is not tied to the channels, we
  create dedicated napi contexts for polling them such that channels can be
  re-created during offloading. The queue handler has pointer to the cq
  associated with the queue's sq and napi context.

- main offload context (mlx5e_nvmeotcp) - has ida and hash table instances.
  Each offloaded queue gets an ID from the ida instance and the <id, queue>
  pairs are kept in the hash table. The id is programmed as flow tag to be
  set by HW on the completion (cqe) of all packets related to this queue
  (by 5-tuple steering). The fast path which deals with packets uses the
  flow tag to access the hash table and retrieve the queue for the
  processing.

We query nvmeotcp capabilities to see if the offload can be supported and
use 128B CQEs when this happens. By default, the offload is off but can
be enabled with `ethtool --ulp-ddp <device> nvme-tcp-ddp on`.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   4 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  12 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |   3 +
 .../mellanox/mlx5/core/en_accel/en_accel.h    |   3 +
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |   2 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 217 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 120 ++++++++++
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  16 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
 14 files changed, 396 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 685335832a93..5935c2cdefec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -164,6 +164,17 @@ config MLX5_EN_TLS
 	help
 	Build support for TLS cryptography-offload acceleration in the NIC.
 
+config MLX5_EN_NVMEOTCP
+	bool "NVMEoTCP acceleration"
+	depends on ULP_DDP
+	depends on MLX5_CORE_EN
+	default y
+	help
+	Build support for NVMEoTCP acceleration in the NIC.
+	This includes Direct Data Placement and CRC offload.
+	Note: Support for hardware with this capability needs to be selected
+	for this option to become available.
+
 config MLX5_SW_STEERING
 	bool "Mellanox Technologies software-managed steering"
 	depends on MLX5_CORE_EN && MLX5_ESWITCH
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index c44870b175f9..f397e2eb0cdc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -109,6 +109,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o
+
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
 					steering/dr_icm_pool.o steering/dr_buddy.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 1e1d8f3d2b24..d8aa2bb24437 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -327,6 +327,7 @@ struct mlx5e_params {
 	int hard_mtu;
 	bool ptp_rx;
 	__be32 terminate_lkey_be;
+	bool nvmeotcp;
 };
 
 static inline u8 mlx5e_get_dcb_num_tc(struct mlx5e_params *params)
@@ -934,6 +935,9 @@ struct mlx5e_priv {
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	struct mlx5e_tls          *tls;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	struct mlx5e_nvmeotcp      *nvmeotcp;
 #endif
 	struct devlink_health_reporter *tx_reporter;
 	struct devlink_health_reporter *rx_reporter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index 4d6225e0eec7..780e8b5ae8e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -77,7 +77,7 @@ enum {
 	MLX5E_INNER_TTC_FT_LEVEL,
 	MLX5E_FS_TT_UDP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 	MLX5E_FS_TT_ANY_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	MLX5E_ACCEL_FS_TCP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 #endif
 #ifdef CONFIG_MLX5_EN_ARFS
@@ -169,7 +169,7 @@ struct mlx5e_fs_any *mlx5e_fs_get_any(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_any(struct mlx5e_flow_steering *fs, struct mlx5e_fs_any *any);
 struct mlx5e_fs_udp *mlx5e_fs_get_udp(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_udp(struct mlx5e_flow_steering *fs, struct mlx5e_fs_udp *udp);
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 struct mlx5e_accel_fs_tcp *mlx5e_fs_get_accel_tcp(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_accel_tcp(struct mlx5e_flow_steering *fs, struct mlx5e_accel_fs_tcp *accel_tcp);
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index e097f336e1c4..21b7d8628dd3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -873,7 +873,8 @@ static void mlx5e_build_common_cq_param(struct mlx5_core_dev *mdev,
 	void *cqc = param->cqc;
 
 	MLX5_SET(cqc, cqc, uar_page, mdev->priv.uar->index);
-	if (MLX5_CAP_GEN(mdev, cqe_128_always) && cache_line_size() >= 128)
+	if (MLX5_CAP_GEN(mdev, cqe_128_always) &&
+	    (cache_line_size() >= 128 || param->force_cqe128))
 		MLX5_SET(cqc, cqc, cqe_sz, CQE_STRIDE_128_PAD);
 }
 
@@ -903,6 +904,9 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 	void *cqc = param->cqc;
 	u8 log_cq_size;
 
+	/* nvme-tcp offload mandates 128 byte cqes */
+	param->force_cqe128 |= IS_ENABLED(CONFIG_MLX5_EN_NVMEOTCP) && params->nvmeotcp;
+
 	switch (params->rq_wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		hw_stridx = MLX5_CAP_GEN(mdev, mini_cqe_resp_stride_index);
@@ -1242,9 +1246,9 @@ static u8 mlx5e_build_async_icosq_log_wq_sz(struct mlx5_core_dev *mdev)
 	return MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE;
 }
 
-static void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
-				    u8 log_wq_size,
-				    struct mlx5e_sq_param *param)
+void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
+			     u8 log_wq_size,
+			     struct mlx5e_sq_param *param)
 {
 	void *sqc = param->sqc;
 	void *wq = MLX5_ADDR_OF(sqc, sqc, wq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 6800949dafbc..f5a4d6f5d5bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -17,6 +17,7 @@ struct mlx5e_cq_param {
 	struct mlx5_wq_param       wq;
 	u16                        eq_ix;
 	u8                         cq_period_mode;
+	bool                       force_cqe128;
 };
 
 struct mlx5e_rq_param {
@@ -147,6 +148,8 @@ void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 			     struct mlx5e_params *params,
 			     struct mlx5e_xsk_param *xsk,
 			     struct mlx5e_sq_param *param);
+void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
+			     u8 log_wq_size, struct mlx5e_sq_param *param);
 int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 			      struct mlx5e_params *params,
 			      u16 q_counter,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index caa34b9c161e..070dabb03bd4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -40,6 +40,7 @@
 #include "en_accel/ktls.h"
 #include "en_accel/ktls_txrx.h"
 #include <en_accel/macsec.h>
+#include "en_accel/nvmeotcp.h"
 #include "en.h"
 #include "en/txrx.h"
 
@@ -202,11 +203,13 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
 
 static inline int mlx5e_accel_init_rx(struct mlx5e_priv *priv)
 {
+	mlx5e_nvmeotcp_init_rx(priv);
 	return mlx5e_ktls_init_rx(priv);
 }
 
 static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
 {
+	mlx5e_nvmeotcp_cleanup_rx(priv);
 	mlx5e_ktls_cleanup_rx(priv);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
index a032bff482a6..d907e352ffae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
@@ -6,7 +6,7 @@
 
 #include "en/fs.h"
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs);
 void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs);
 struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
new file mode 100644
index 000000000000..8f99534430f0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include <linux/netdevice.h>
+#include <linux/idr.h>
+#include "en_accel/nvmeotcp.h"
+#include "en_accel/fs_tcp.h"
+#include "en/txrx.h"
+
+#define MAX_NUM_NVMEOTCP_QUEUES	(4000)
+#define MIN_NUM_NVMEOTCP_QUEUES	(1)
+
+static const struct rhashtable_params rhash_queues = {
+	.key_len = sizeof(int),
+	.key_offset = offsetof(struct mlx5e_nvmeotcp_queue, id),
+	.head_offset = offsetof(struct mlx5e_nvmeotcp_queue, hash),
+	.automatic_shrinking = true,
+	.min_size = MIN_NUM_NVMEOTCP_QUEUES,
+	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
+};
+
+static int
+mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
+			      struct ulp_ddp_limits *limits)
+{
+	return 0;
+}
+
+static int
+mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
+			  struct sock *sk,
+			  struct ulp_ddp_config *tconfig)
+{
+	return 0;
+}
+
+static void
+mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
+			      struct sock *sk)
+{
+}
+
+static int
+mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *ddp)
+{
+	return 0;
+}
+
+static void
+mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
+			    struct sock *sk,
+			    struct ulp_ddp_io *ddp,
+			    void *ddp_ctx)
+{
+}
+
+static void
+mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
+			  struct sock *sk, u32 seq)
+{
+}
+
+int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_params new_params;
+	int err = 0;
+
+	/* There may be offloaded queues when an netlink callback to disable the feature is made.
+	 * Hence, we can't destroy the tcp flow-table since it may be referenced by the offload
+	 * related flows and we'll keep the 128B CQEs on the channel RQs. Also, since we don't
+	 * deref/destroy the fs tcp table when the feature is disabled, we don't ref it again
+	 * if the feature is enabled multiple times.
+	 */
+	if (!enable || priv->nvmeotcp->enabled)
+		return 0;
+
+	err = mlx5e_accel_fs_tcp_create(priv->fs);
+	if (err)
+		return err;
+
+	new_params = priv->channels.params;
+	new_params.nvmeotcp = enable;
+	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	if (err)
+		goto fs_tcp_destroy;
+
+	priv->nvmeotcp->enabled = true;
+	return 0;
+
+fs_tcp_destroy:
+	mlx5e_accel_fs_tcp_destroy(priv->fs);
+	return err;
+}
+
+static int mlx5e_ulp_ddp_set_caps(struct net_device *netdev, unsigned long *new_caps,
+				  struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	DECLARE_BITMAP(old_caps, ULP_DDP_CAP_COUNT);
+	struct mlx5e_params *params;
+	int ret = 0;
+	int nvme = -1;
+
+	mutex_lock(&priv->state_lock);
+	params = &priv->channels.params;
+	bitmap_copy(old_caps, priv->nvmeotcp->ddp_caps.active, ULP_DDP_CAP_COUNT);
+
+	/* always handle nvme-tcp-ddp and nvme-tcp-ddgst-rx together (all or nothing) */
+
+	if (ulp_ddp_cap_turned_on(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP) &&
+	    ulp_ddp_cap_turned_on(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP_DDGST_RX)) {
+		if (MLX5E_GET_PFLAG(params, MLX5E_PFLAG_RX_CQE_COMPRESS)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NVMe-TCP offload not supported when CQE compress is active. Disable rx_cqe_compress ethtool private flag first\n");
+			goto out;
+		}
+
+		if (netdev->features & (NETIF_F_LRO | NETIF_F_GRO_HW)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NVMe-TCP offload not supported when HW_GRO/LRO is active. Disable rx-gro-hw ethtool feature first\n");
+			goto out;
+		}
+		nvme = 1;
+	} else if (ulp_ddp_cap_turned_off(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP) &&
+		   ulp_ddp_cap_turned_off(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP_DDGST_RX)) {
+		nvme = 0;
+	}
+
+	if (nvme >= 0) {
+		ret = set_ulp_ddp_nvme_tcp(netdev, nvme);
+		if (ret)
+			goto out;
+		change_bit(ULP_DDP_CAP_NVME_TCP, priv->nvmeotcp->ddp_caps.active);
+		change_bit(ULP_DDP_CAP_NVME_TCP_DDGST_RX, priv->nvmeotcp->ddp_caps.active);
+	}
+
+out:
+	mutex_unlock(&priv->state_lock);
+	return ret;
+}
+
+static void mlx5e_ulp_ddp_get_caps(struct net_device *dev,
+				   struct ulp_ddp_dev_caps *caps)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	mutex_lock(&priv->state_lock);
+	memcpy(caps, &priv->nvmeotcp->ddp_caps, sizeof(*caps));
+	mutex_unlock(&priv->state_lock);
+}
+
+const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
+	.limits = mlx5e_nvmeotcp_offload_limits,
+	.sk_add = mlx5e_nvmeotcp_queue_init,
+	.sk_del = mlx5e_nvmeotcp_queue_teardown,
+	.setup = mlx5e_nvmeotcp_ddp_setup,
+	.teardown = mlx5e_nvmeotcp_ddp_teardown,
+	.resync = mlx5e_nvmeotcp_ddp_resync,
+	.set_caps = mlx5e_ulp_ddp_set_caps,
+	.get_caps = mlx5e_ulp_ddp_get_caps,
+};
+
+void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv)
+{
+	if (priv->nvmeotcp && priv->nvmeotcp->enabled)
+		mlx5e_accel_fs_tcp_destroy(priv->fs);
+}
+
+int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nvmeotcp *nvmeotcp = NULL;
+	int ret = 0;
+
+	if (!(MLX5_CAP_GEN(priv->mdev, nvmeotcp) &&
+	      MLX5_CAP_DEV_NVMEOTCP(priv->mdev, zerocopy) &&
+	      MLX5_CAP_DEV_NVMEOTCP(priv->mdev, crc_rx) &&
+	      MLX5_CAP_GEN(priv->mdev, cqe_128_always)))
+		return 0;
+
+	nvmeotcp = kzalloc(sizeof(*nvmeotcp), GFP_KERNEL);
+
+	if (!nvmeotcp)
+		return -ENOMEM;
+
+	ida_init(&nvmeotcp->queue_ids);
+	ret = rhashtable_init(&nvmeotcp->queue_hash, &rhash_queues);
+	if (ret)
+		goto err_ida;
+
+	/* report ULP DPP as supported, but don't enable it by default */
+	set_bit(ULP_DDP_CAP_NVME_TCP, nvmeotcp->ddp_caps.hw);
+	set_bit(ULP_DDP_CAP_NVME_TCP_DDGST_RX, nvmeotcp->ddp_caps.hw);
+	nvmeotcp->enabled = false;
+	priv->nvmeotcp = nvmeotcp;
+	return 0;
+
+err_ida:
+	ida_destroy(&nvmeotcp->queue_ids);
+	kfree(nvmeotcp);
+	return ret;
+}
+
+void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nvmeotcp *nvmeotcp = priv->nvmeotcp;
+
+	if (!nvmeotcp)
+		return;
+
+	rhashtable_destroy(&nvmeotcp->queue_hash);
+	ida_destroy(&nvmeotcp->queue_ids);
+	kfree(nvmeotcp);
+	priv->nvmeotcp = NULL;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
new file mode 100644
index 000000000000..29546992791f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_H__
+#define __MLX5E_NVMEOTCP_H__
+
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+
+#include <net/ulp_ddp.h>
+#include "en.h"
+#include "en/params.h"
+
+struct mlx5e_nvmeotcp_queue_entry {
+	struct mlx5e_nvmeotcp_queue *queue;
+	u32 sgl_length;
+	u32 klm_mkey;
+	struct scatterlist *sgl;
+	u32 ccid_gen;
+	u64 size;
+
+	/* for the ddp invalidate done callback */
+	void *ddp_ctx;
+	struct ulp_ddp_io *ddp;
+};
+
+struct mlx5e_nvmeotcp_queue_handler {
+	struct napi_struct napi;
+	struct mlx5e_cq *cq;
+};
+
+/**
+ *	struct mlx5e_nvmeotcp_queue - mlx5 metadata for NVMEoTCP queue
+ *	@ulp_ddp_ctx: Generic ulp ddp context
+ *	@tir: Destination TIR created for NVMEoTCP offload
+ *	@fh: Flow handle representing the 5-tuple steering for this flow
+ *	@id: Flow tag ID used to identify this queue
+ *	@size: NVMEoTCP queue depth
+ *	@ccid_gen: Generation ID for the CCID, used to avoid conflicts in DDP
+ *	@max_klms_per_wqe: Number of KLMs per DDP operation
+ *	@hash: Hash table of queues mapped by @id
+ *	@pda: Padding alignment
+ *	@tag_buf_table_id: Tag buffer table for CCIDs
+ *	@dgst: Digest supported (header and/or data)
+ *	@sq: Send queue used for posting umrs
+ *	@ref_count: Reference count for this structure
+ *	@after_resync_cqe: Indicate if resync occurred
+ *	@ccid_table: Table holding metadata for each CC (Command Capsule)
+ *	@ccid: ID of the current CC
+ *	@ccsglidx: Index within the scatter-gather list (SGL) of the current CC
+ *	@ccoff: Offset within the current CC
+ *	@ccoff_inner: Current offset within the @ccsglidx element
+ *	@channel_ix: Channel IX for this nvmeotcp_queue
+ *	@sk: The socket used by the NVMe-TCP queue
+ *	@crc_rx: CRC Rx offload indication for this queue
+ *	@priv: mlx5e netdev priv
+ *	@static_params_done: Async completion structure for the initial umr mapping
+ *	synchronization
+ *	@sq_lock: Spin lock for the icosq
+ *	@qh: Completion queue handler for processing umr completions
+ */
+struct mlx5e_nvmeotcp_queue {
+	struct ulp_ddp_ctx ulp_ddp_ctx;
+	struct mlx5e_tir tir;
+	struct mlx5_flow_handle *fh;
+	int id;
+	u32 size;
+	/* needed when the upper layer immediately reuses CCID + some packet loss happens */
+	u32 ccid_gen;
+	u32 max_klms_per_wqe;
+	struct rhash_head hash;
+	int pda;
+	u32 tag_buf_table_id;
+	u8 dgst;
+	struct mlx5e_icosq sq;
+
+	/* data-path section cache aligned */
+	refcount_t ref_count;
+	/* for MASK HW resync cqe */
+	bool after_resync_cqe;
+	struct mlx5e_nvmeotcp_queue_entry *ccid_table;
+	/* current ccid fields */
+	int ccid;
+	int ccsglidx;
+	off_t ccoff;
+	int ccoff_inner;
+
+	u32 channel_ix;
+	struct sock *sk;
+	u8 crc_rx:1;
+	/* for ddp invalidate flow */
+	struct mlx5e_priv *priv;
+	/* end of data-path section */
+
+	struct completion static_params_done;
+	/* spin lock for the ico sq, ULP can issue requests from multiple contexts */
+	spinlock_t sq_lock;
+	struct mlx5e_nvmeotcp_queue_handler qh;
+};
+
+struct mlx5e_nvmeotcp {
+	struct ida queue_ids;
+	struct rhashtable queue_hash;
+	struct ulp_ddp_dev_caps ddp_caps;
+	bool enabled;
+};
+
+int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv);
+int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable);
+void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
+#else
+
+static inline int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv) { return 0; }
+static inline void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv) {}
+static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en) { return -EOPNOTSUPP; }
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+#endif
+#endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 215261a69255..bd66639c3caf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -38,6 +38,7 @@
 #include "en/ptp.h"
 #include "lib/clock.h"
 #include "en/fs_ethtool.h"
+#include "en_accel/nvmeotcp.h"
 
 void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo)
@@ -1929,6 +1930,11 @@ int mlx5e_modify_rx_cqe_compression_locked(struct mlx5e_priv *priv, bool new_val
 		return -EINVAL;
 	}
 
+	if (priv->channels.params.nvmeotcp) {
+		netdev_warn(priv->netdev, "Can't set CQE compression after ULP DDP NVMe-TCP offload\n");
+		return -EINVAL;
+	}
+
 	new_params = priv->channels.params;
 	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_COMPRESS, new_val);
 	if (rx_filter)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 777d311d44ef..853e30f221c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -62,7 +62,7 @@ struct mlx5e_flow_steering {
 #ifdef CONFIG_MLX5_EN_ARFS
 	struct mlx5e_arfs_tables       *arfs;
 #endif
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	struct mlx5e_accel_fs_tcp      *accel_tcp;
 #endif
 	struct mlx5e_fs_udp            *udp;
@@ -1557,7 +1557,7 @@ void mlx5e_fs_set_any(struct mlx5e_flow_steering *fs, struct mlx5e_fs_any *any)
 	fs->any = any;
 }
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 struct mlx5e_accel_fs_tcp *mlx5e_fs_get_accel_tcp(struct mlx5e_flow_steering *fs)
 {
 	return fs->accel_tcp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9ae4c4213db7..3fc9f23ff3e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -50,6 +50,7 @@
 #include "en_accel/macsec.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ktls.h"
+#include "en_accel/nvmeotcp.h"
 #include "lib/vxlan.h"
 #include "lib/clock.h"
 #include "en/port.h"
@@ -4267,6 +4268,13 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 		features &= ~NETIF_F_NETNS_LOCAL;
 	}
 
+	if (features & (NETIF_F_LRO | NETIF_F_GRO_HW)) {
+		if (params->nvmeotcp) {
+			netdev_warn(netdev, "Disabling HW-GRO/LRO, not supported after ULP DDP NVMe-TCP offload\n");
+			features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
+		}
+	}
+
 	mutex_unlock(&priv->state_lock);
 
 	return features;
@@ -5020,6 +5028,9 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_has_offload_stats   = mlx5e_has_offload_stats,
 	.ndo_get_offload_stats   = mlx5e_get_offload_stats,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	.ulp_ddp_ops             = &mlx5e_nvmeotcp_ops,
+#endif
 };
 
 static u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout)
@@ -5360,6 +5371,10 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (err)
 		mlx5_core_err(mdev, "TLS initialization failed, %d\n", err);
 
+	err = mlx5e_nvmeotcp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "NVMEoTCP initialization failed, %d\n", err);
+
 	mlx5e_health_create_reporters(priv);
 
 	/* If netdev is already registered (e.g. move from uplink to nic profile),
@@ -5380,6 +5395,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
+	mlx5e_nvmeotcp_cleanup(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index a17152c1cbb2..cf84d48d38b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1758,6 +1758,7 @@ static const int types[] = {
 	MLX5_CAP_MACSEC,
 	MLX5_CAP_ADV_VIRTUALIZATION,
 	MLX5_CAP_CRYPTO,
+	MLX5_CAP_DEV_NVMEOTCP,
 };
 
 static void mlx5_hca_caps_free(struct mlx5_core_dev *dev)
-- 
2.34.1


