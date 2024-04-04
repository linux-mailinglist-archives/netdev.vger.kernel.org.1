Return-Path: <netdev+bounces-84866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F112489880E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B00F1C21467
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C50D12B177;
	Thu,  4 Apr 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nZda4NNp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2104.outbound.protection.outlook.com [40.107.93.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17212837B
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234333; cv=fail; b=c0YficPSBW/QDTuRu8Fzmi6q19+zrhoQ3tYNul2TGtNR8rXqX6jbAqap1MK9jeE1ljAR35xAWBfS9BhwBc1MTi18evoJVeHour7ML8IsEEHelNKLcrP4tT1F4kkHsz8QtjW32oAJScj2ZvE5KiYXW1Xc5a3RFy9Dj8oeJeVg11w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234333; c=relaxed/simple;
	bh=dO+uwCo5yrcZ4Kw6l36lzrjJkk94A/QeJUXICSqFZt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozgWM32Dsz1alVCjXQXxqRs0eNAZ/C0EQpNnkEajNm8WBr6phhh+jHZdxh+vKb13oCG5s5Kx4JEexpra4WqUwblXU3o3WdiVFbfQwPc/Jvzpe5qbbiqA7ncC9mRPw5Oext3gU/w+5n3+Or14rMU+4mAxUEHWxQU2CWtf8xk7cPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nZda4NNp; arc=fail smtp.client-ip=40.107.93.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVAj7HX1BMkybElHSRDVMbKMVh+FD0xxanFDA3c7I603g8iT+v4gi4tX1r9JIFjHpvrx4t/XtjlMJhy1/N3rhQmu2nVDR7bAjk1PxnRFrzhru0mYFLHoXmEOUNeR+Z3Lm6tTJKwrOOkrysatu+/riW/z+c92U1ThApRd+KI+/FL977V8EbacZmeAVNU6LiR2HHQkeHBkCbHiyBqwPInimuKBPUufU6QLHgPu6G77HDag7Aic3Q87nW1CGdFNw4cOMltbOR5LD3VDN4iuGy9r+G03Sz04qhGg4FVvWesaaHkXMz5GTJVWk1sJiQqx30TiTPI3paP9Sw758+up7Kvr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnnajhtuPcZTowrbBYWpcrZlDGYuZNFnwYqIktzA8wY=;
 b=kAtoSc9Y/9f78kd1Bb3mChl+2yW89QNKaAzXCZOpjyIv7hkf5Z8XIe6G4RDFvYnJWQg413vPbEQe7mWfozVoQrQaS/H09lfMDacDVYVx26loI7JDjag9mIBnRrC6JVai6LF/sk4EZDFovEqIGLBVQNJlzcEypmAktj9QkRECGqk8Dl7fe1mBlSEDNfsSxGcuL6+ssm97NJ2MkO2DTadWHy6cYVJP7GW1eqcJi/6dtuL9cJQUafXUQ+Nh3azE0prlBPt85uPH+b3wryOMafAixNESWWzarB/zc1ukVy2pVNxmte3k+VedFNDZ1m+V/wAWHbGE40v8wPIhdtnfNv8UDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnnajhtuPcZTowrbBYWpcrZlDGYuZNFnwYqIktzA8wY=;
 b=nZda4NNpRlPfXzrulPtTbUeLIjaboM6I/18K1H/3QKM3a+UEUWipY0/YaFQmKoAapp/uZ/I0Mewpan4Q/9poQagmfpAlNU82v3Un4Gbq3TrmIu+whzlR4yx+jrdxkEEvnffduXhrVGdFwWQmh82hMfjKi5rtnWfsIoKAa2eJ6bPRo1fn2sMxBUKSt/IxRGf+110n8MEFMOj2E7e6xhrk99vUpl9K4bFzITEyh3gx7R7cvdpobBgRj0v9kUYcIa+ZXgXzBqTtn/v3GIAHSRS3UpxQtHZbM5XyUEKQc+m++yEGKv6gifq7qJneOHkfADeWYk3ZEhpOgLUv2CP3GoNa6g==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:38:47 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:38:45 +0000
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
Subject: [PATCH v24 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Thu,  4 Apr 2024 12:37:12 +0000
Message-Id: <20240404123717.11857-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
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
	UHjxNn5d8rDDk+2FnuGYZha2j0k2i2/WYL6089ky1glA9AgLkKIzpLFOHwqq7tJZNTzLGTOTZk0QwUI7GNqjBWfcz5QnKt0FInltflxdO2Pzbqjp9Z2CZ5+8CDHNIx/IrZzCl6A0jCmYoucLQ5tz82KSUF0aJcKbK7/PyTpj9LFA8/kRS6KMlZHaswLjnFgPdrNjVb+Wg5tc/1yi+1QRFRLTNolmab7anlw58K5SgCHsmo2iOWi7IjxT/LWQe+76WeKWXk6Jsp+7sABvhF/RQ8OmKdo3yu67np2mZ0LyyERhbvcOL5LNA9KcpTf9KdRQ/6gsJcBDS2tRp1mt3s/Y7VbmIrrQSpZUGm91K2UN69vnQIbVKK3qofsPyxio4LGsFvcvl/w07kGtpUU+leJeJUOT9EXB2nOkRowjS0xC/vrv/TeyZOnRZjVcq0v8lYGuKBD6N6xz5wGbq3KUsRzOkp/Ga9uxe7Mr+XH5LeXTB20pB31MDvzXrA3v5ipet97LOcRvQ7aCIRresJUeXaKESlNWqZ3jmsVxGOc8LVYnovXoSbRb3AU9JARprlULssC72R5w1BVYcSr9/S2f9a3z52dYBgUzwCW7nj5Hrx3wAHAOM5mYjrhW6RBni6QVEi/71Tz2kcA5Kpr5kdugGaN2ezKEHbVkn8LekPhHJRbfBbg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1asRC0muAb2UA2iOmvtuaDFaEqRy0K3/YH90b/pGfvKo9kytyIioXnLoMxUr?=
 =?us-ascii?Q?5hRqDZbJpbXS8YdgPfmZOGIwLg/hIR4pBuEv6KRjMkqLDCidMYRDwVI0fd/6?=
 =?us-ascii?Q?bRN/RENvI6b1ixiIqhDNk1vFyzchTgFABjcWPSSpE4MyrnpnG8OAJlr13+Vn?=
 =?us-ascii?Q?densyKoK2FqbS4qhO8sVUxAzKePeT4JNfVba8qGH/ZfCXgsP0bijLljHmEq/?=
 =?us-ascii?Q?OzPdrPsx7Zt0pQ7TJ6aaNsBzFQARVUMWngvc4IPntC4HCZQ9jls1bAC0BlwA?=
 =?us-ascii?Q?Y5emKAXS0+0ei257QoJuC6PVLwhHgy1R/eaY7yBuGc8E4Eh/BxvEdM3WVcUo?=
 =?us-ascii?Q?KAMFNirD/UndMp61uOIFd/9HsXBe7Rl7XSULb2doJWrw/ylsXJMrI54gx9ZS?=
 =?us-ascii?Q?UOrZYwkW86mKmGT24Zg2PpWyG2MgFrysW6akT+eWhRuyiCMRR4HU5UjxSLMV?=
 =?us-ascii?Q?EnHVWuIE4BOpRGYX+1KY7ixWxIy1bvq8mJItOoIsu9Ht3627Bi0UmsaLlwLh?=
 =?us-ascii?Q?no/WqO3XEOZ9mKLueYa1USKa6/FujpjjteAv5KG2xS6WROvqyE1V5DYR8Dku?=
 =?us-ascii?Q?5QgZ+lYwD7wa98PKVg9eqr4vYXNsQXMgE4PCnddaPZSyv9ZeGJde62An3jkC?=
 =?us-ascii?Q?LEdDHpEQ8Nm7iHnJLMRv3PKnQN5iMCe3uK6Q4ssVjM1WenCoafHd4Zq/5Xg2?=
 =?us-ascii?Q?41VgT4Jc5kuil+OuoIq/QYGvFLfY0VWNLqqdptogcItDr9K9dxtWnIpHDFLr?=
 =?us-ascii?Q?RGPvIwQ78EgqiXGW9tO4Nzh8opfquTw84SW/t3KqxEebkR1IbbxiWuu5fREK?=
 =?us-ascii?Q?gVyU398Z6UaFuzp59uSE1/y4+Bjx/LwdgJ7yyrsV/hYkYey2GfIV0MMRSO2c?=
 =?us-ascii?Q?VNKYcIrUvq42x8LpNq4QJkcUUJhGSS+YNfG3FjZrmKm9/3H6vsbDA+MGM0vt?=
 =?us-ascii?Q?vnkHTkMzcaZIfk9tYSxMWUpLPTLDe9STwcFWT9AdgE2RVACMASWq8ARR96I/?=
 =?us-ascii?Q?ZGnwq+5RbOEOuJz/hkX5EhLe0yCExf0hDeG+BcOggdA+P6t1YCvUGWbULhmv?=
 =?us-ascii?Q?WwSpp6JSvwstOriPuyUQACLkdtOcFrneFf9fIzZ6mHoP5XfeDazG0mpMUBXF?=
 =?us-ascii?Q?GR6ii6Oi+Xx0nrDFSJqzbNAWiMoLFafwCTzwa9XlYO8A58jFesdUmMdLVuKm?=
 =?us-ascii?Q?9w7ftdkNkF7vqwTDO8v0+OyWt79Gd6naD3eB1WbPiZQT2kxs8gkoHSoYjSRH?=
 =?us-ascii?Q?hEzuAvE1+CS5hfknbEmo1Ei/PGPXyUGi5J73JuAwJs0mQLKDNK5XwiHoCX1O?=
 =?us-ascii?Q?RjkqLo45hGjK9ngVQCtkTSSwv6Q8BXyEpNiNk46bGF5NuDF8EieLO7PJh4nV?=
 =?us-ascii?Q?+ytCAMM5sPBRAgmbWKveaQwIgapl3LFIvxZ+yXeQq5MikjQ8VMuWa4k6ao+9?=
 =?us-ascii?Q?/tXKF2JqxNShwgeL46Q/uvK9ylSFHPK8TjtgazyftKuOsvcWun1E1Ung/JXI?=
 =?us-ascii?Q?vgw+/J4M6BhzmGtIAY9wJqzBL20WstsRARxbvVvflOe9P+bdFd/sthz33eIF?=
 =?us-ascii?Q?o6bsQLMfGxBzY2l1Q49lVOzqa9d8JMUKKOu4jc1q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da233e11-e985-428c-dc67-08dc54a42b04
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:38:45.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR9vPP/xmvtNsT3ZpnZ1gvLJhV9b9APxyjhJOubn+ilKQE3NX/a9ggnz7zGHgcTpkjmOSLL1madrODPFjE1ekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for ddp operation.
Every request comprises from SG list that might consist from elements
with multiple combination sizes, thus the appropriate way to perform
buffer registration is with KLM UMRs.

UMR stands for user-mode memory registration, it is a mechanism to alter
address translation properties of MKEY by posting WorkQueueElement
aka WQE on send queue.

MKEY stands for memory key, MKEY are used to describe a region in memory
that can be later used by HW.

KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
enables to map multiple memory spaces with different sizes in unified MKEY.
KLM UMR is a UMR that use to update a KLM_MKEY.

Nothing needs to be done on memory registration completion and this
notification is expensive so we add a wrapper to be able to ring the
doorbell without generating any.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  16 ++-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 123 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 4 files changed, 165 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index cdd7fbf218ae..294fdcdb0f6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -50,6 +50,9 @@ enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
 	MLX5E_ICOSQ_WQE_GET_PSV_TLS,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+#endif
 };
 
 /* General */
@@ -256,10 +259,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -273,6 +276,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 9965757873f9..c36bcc230455 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/idr.h>
 #include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_utils.h"
 #include "en_accel/fs_tcp.h"
 #include "en/txrx.h"
 
@@ -19,6 +20,120 @@ static const struct rhashtable_params rhash_queues = {
 	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
 };
 
+static void
+fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe, u16 ccid,
+		      u32 klm_entries, u16 klm_offset)
+{
+	struct scatterlist *sgl_mkey;
+	u32 lkey, i;
+
+	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
+	for (i = 0; i < klm_entries; i++) {
+		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
+		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
+		wqe->inline_klms[i].key = cpu_to_be32(lkey);
+		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
+	}
+
+	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT); i++) {
+		wqe->inline_klms[i].bcount = 0;
+		wqe->inline_klms[i].key = 0;
+		wqe->inline_klms[i].va = 0;
+	}
+}
+
+static void
+build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe,
+		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
+		       enum wqe_type klm_type)
+{
+	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
+	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
+	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
+	struct mlx5_mkey_seg *mkc = &wqe->mkc;
+	u32 sqn = queue->sq.sqn;
+	u16 pc = queue->sq.pc;
+
+	cseg->opmod_idx_opcode = cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
+					     MLX5_OPCODE_UMR | (opc_mod) << 24);
+	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
+	cseg->general_id = cpu_to_be32(id);
+
+	if (klm_type == KLM_UMR && !klm_offset) {
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
+					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
+		mkc->xlt_oct_size = cpu_to_be32(ALIGN(len, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
+	}
+
+	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
+	ucseg->xlt_octowords = cpu_to_be16(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	ucseg->xlt_offset = cpu_to_be16(klm_offset);
+	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
+}
+
+static void
+mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
+{
+	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
+
+	memset(wi, 0, sizeof(*wi));
+
+	wi->num_wqebbs = wqebbs;
+	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
+}
+
+static u32
+post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+	     enum wqe_type wqe_type,
+	     u16 ccid,
+	     u32 klm_length,
+	     u32 klm_offset)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 wqebbs, cur_klm_entries;
+	struct mlx5e_umr_wqe *wqe;
+	u16 pi, wqe_sz;
+
+	cur_klm_entries = min_t(int, queue->max_klms_per_wqe, klm_length - klm_offset);
+	wqe_sz = MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
+	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
+	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
+	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
+	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
+			       klm_length, wqe_type);
+	sq->pc += wqebbs;
+	sq->doorbell_cseg = &wqe->ctrl;
+	return cur_klm_entries;
+}
+
+static void
+mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wqe_type,
+			    u16 ccid, u32 klm_length)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 klm_offset = 0, wqes, i;
+
+	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+
+	spin_lock_bh(&queue->sq_lock);
+
+	for (i = 0; i < wqes; i++)
+		klm_offset += post_klm_wqe(queue, wqe_type, ccid, klm_length, klm_offset);
+
+	if (wqe_type == KLM_UMR) /* not asking for completion on ddp_setup UMRs */
+		__mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg, 0);
+	else
+		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg);
+
+	spin_unlock_bh(&queue->sq_lock);
+}
+
 static int
 mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
 			      struct ulp_ddp_limits *limits)
@@ -45,6 +160,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk),
+			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	/* Placeholder - map_sg and initializing the count */
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
new file mode 100644
index 000000000000..6ef92679c5d0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_UTILS_H__
+#define __MLX5E_NVMEOTCP_UTILS_H__
+
+#include "en.h"
+
+#define MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi) \
+	((struct mlx5e_umr_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_umr_wqe)))
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_NVMEOTCP_TIR_PROGRESS_PARAMS 0x4
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_TIR_PARAMS 0x2
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR 0x0
+
+enum wqe_type {
+	KLM_UMR,
+	BSF_KLM_UMR,
+	SET_PSV_UMR,
+	BSF_UMR,
+	KLM_INV_UMR,
+};
+
+#endif /* __MLX5E_NVMEOTCP_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 780902f63823..ff8b648534db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1061,6 +1061,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 			case MLX5E_ICOSQ_WQE_GET_PSV_TLS:
 				mlx5e_ktls_handle_get_psv_completion(wi, sq);
 				break;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
+				break;
 #endif
 			default:
 				netdev_WARN_ONCE(cq->netdev,
-- 
2.34.1


