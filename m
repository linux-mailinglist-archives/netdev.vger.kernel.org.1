Return-Path: <netdev+bounces-75726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305286AFAD
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA79228937E
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A63149E1D;
	Wed, 28 Feb 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwhVrIhj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666B149E17
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125160; cv=fail; b=Gc/+B+WifHsCT8uGmuvkI7GUYkE7HaOzMUDeKQigpehIBWU+Tf+1VRk36249g7cU3Qvfy8L97JLZegKk4vnsYxa7yuTFyem7H+0C/nc8960TUoiWYb5iBZbkac9AkYQwnHJHSZbonSG7Xnta7lk7x1YwemPBxARCrXG+uYweJzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125160; c=relaxed/simple;
	bh=qZgBFZaJ8lXYfH3s4azqv4srfrt9C8DsTp2lotkhSVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7vC52Nc0WSl85//9oMciss4QMZU/cHpFN2Yibmc6/Rbv5NTP9E8nn5x7qOhaxLp5aLLYo9r5Ppnqu5tfCjSfa1tBnkKbdJVzvZordMnxr7m97sBNtuqxvFdZf3751dYVYKon6N1JcYqxHZLEIc/EU7YulKFsLqAE889qrIYH54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwhVrIhj; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grLwieOyyW9PHQymPGN6zyXBNrWjqFCXVEYrf9E3vYQP0Q1IPXrdtnmV2noNzZ7EIRr4JBDawxNvoEQNhrwdKC9UrR6aR9sIoWrgoop/FivhwnTGa0opKM3VpE84/4Lo4fnOe3NDHBxUiagksrojlTonZnKzqgm5ESUPLLFyws7mtm1042lScTW1NK1HGot8RgytiAmETnujcGXQR/iFzbvNhiwzuwAzklmd75U7VdunL42eRYDPlmT803YMVfNKaxCKpBr2+MXGosAXcvhSyYracRGyEicGnJUuIM/qae4aDm8EzPWtkcWondwUrVuzQRWWxdIHs0n9uQ+fri2u3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu8AqpFXgApXcdBsqxSHt4Z39ZB/TOeP1spLQWTT/Yg=;
 b=GuEBTvqGKNjWTlAqoEqd8GS2ZpcUgYnuH68A288pPRLZ2jkg0YMUFdLm1A6RiDArRo0GJtj1HVt5NXd65ohXPqJqBlIYjBSEERLCV+d+xW28Rey8bm529p4RF0ItinxRUtguz/vAuxX1VWzkx4tLH/+zE95Cqr/P31R8FWn9yxtyOYmTxE9O7vSex/O4145EBBUBQNG9lGlU1HD0HjN4gNvTee08RobHFUeRqJFBGQQRb19+6ktzckNxB1Ys1DGV+RBwpkDtK8qkvL11QIHxbsOh43AZz41184XPnOgW9BWGr6TmSe3a/kCNP9QWYK0DfJGeRhGdcaV8qG0NTDuYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu8AqpFXgApXcdBsqxSHt4Z39ZB/TOeP1spLQWTT/Yg=;
 b=VwhVrIhjdVp3reeLWPq7Ib+LxTZLGkUC70l/NKa4qXNgxhulWjkAQrRcA5mH5IcubRNKnHfw2IR1z/I74m4ZvDy+mzKwfsqwTNb2G/Xk37qWpLqzPIT+//y1vdBuOWTwtXeR9zKMZsE8JKjzPMF1TUf82Nc95NC02l6whyJbgghAnDJNfwc9+w3I4YF5NPRs9xSqx+l5p5Ulnc8XLwhzbQ7X58mFb7CwmhFhqoKIS6ym7vQNADEE71zGTzTjCf6uz6Ein87raZlQkPnpSdYlIvZyFafeXehoj6RtKNSKfQGkyb83z9PRxy+YKdNJKg1UuIjtD1O6ifnSP3lYf2cglg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 12:59:16 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:59:16 +0000
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
Subject: [PATCH v23 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Wed, 28 Feb 2024 12:57:31 +0000
Message-Id: <20240228125733.299384-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: de112f0f-a4dd-47fb-e7e7-08dc385d11d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	obYixjtmpRxFekdHm/0DcA6+abw9HucQwT0JEeuGXBOvfQ8in+UpdgkNxMnF1Gc3miygCbX/7BLzz3swNa3XH9SxTnVhQoKkqkT2jemr60riykeCyzR2Jgj1fxDf+YJqkxyaVFIgBOiV+NqVMwVy7OEV6m21q+DKBvTtQ/i2yHi8iYslI63kTs6v+ZGp8ww6gSlsioRZdf+qgOigLK/SOPB9lBZotaflennyjcVGgKaTmVKH74EsOL/8Mb+b996nuux2cAjj+2qMKGAMmSuIEjq6DyR+6AUsGwZ/qp54+cb1FSZq1HqstnCtTvMXoQSHgTDfE2QjAPCxMKg6KDqjXREFJi6uKG8MbzJktYZnJ9MeHdkC+4Yc/fwCXkxvY8nZI2K0u7oO6JMx30/VxyJYZMhBBcce9rtnksNxUqeG1AA5OhUB9tziydZhYxh+E3SoS01AEtzpJvuWcxfmB4zh2uWrt8YzHGBcwwcZYNVhDV+b/7Gj2axRhepnXfbzZ0j/V0e++3+RovU8YpfMqT4QhR6IjoS2ppE5R3DLzg8xWtL6fR/14gX7fSAh+/mWBn5xt1XwRLyIJNDhE+Q4jfYffniQrh94XDQlAWAFUeI3hkohMIJFMC3Og90OGJ7VXMKdccROWgqZ7yZYI6nuHMhlSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tlxcJ51mo3KvAjyFAj3msIPZaFiS6dioFtTBCcM1tm6FSoSBKPEnoE2gNtoK?=
 =?us-ascii?Q?fnENYTMIix0RNHjlELjxb6d5LDUHeK7w9jZlU2q/yVdhKikuiKPdkVTPJ7Zi?=
 =?us-ascii?Q?5PFJwOUi+e5gY0Ig7MBqUKjkT5nPkPxDLkPLLkhvFdWqfVl0UeFt9f+0P/df?=
 =?us-ascii?Q?zTHLXKtERvq2eM92/DXdFwmSoXMDtjyL4ZMg1LRgk5TJWdAJ2EEr08lOy6xW?=
 =?us-ascii?Q?xlEoCSUjlz7g8en90rLqoaon79HtubHmT0G1Zb2TZCy49ZXITyeYzaDKxWK0?=
 =?us-ascii?Q?9a5PELG78OZEQPTO+y20zZaAoWM5o+rModCdtUXxa+xVMLc81mQSE8qiTm0Q?=
 =?us-ascii?Q?IvP+xuHsbbd/VUbLTMz2bW7qBa55e2ZMKOP7UrSc94YwN7P6xxY9aiy72Sao?=
 =?us-ascii?Q?NZ/kgzdxp//a/Dabq7eklwUNbNj+GAvarljatQ5i1JOKF9B0OVV3zXY/d/wI?=
 =?us-ascii?Q?crTHTgVyHmXUVlHYLzlv/0o3VS5cXE7Gj9gZ/rrdgFVbxwmI1kmgyP0zkUrY?=
 =?us-ascii?Q?u2KwJEIyczbIm1Dg5ydwyxPne0vM1Q4ClVPaNwWaZV1dDN5sxioj37x3LdRN?=
 =?us-ascii?Q?z1qZANkevhBo2xIrIGV1W36sQnHFAElkok1LI5PO/321medbpf8MK9zre7/R?=
 =?us-ascii?Q?GVkMTFidkGgxUCFgUhg8V7lvUFcpCpX5nZeOVjDCcJndIk0eXBjpgAlfWIRa?=
 =?us-ascii?Q?p0ayssvbU8OcbXB0O3dJJEHelLqg7JRjiieDfBGqYSOcQOuTEiC/cir9EccW?=
 =?us-ascii?Q?3n9GkzuQBa05oKf0yEXb0KGXgLV5l6i8Dp7bGrR+J6tkoEMI2YZLwQpMBiSK?=
 =?us-ascii?Q?UGC/r+YRKa6lqxILzWt1Z+uDA09JLju4+vYqWeKKrZzxZwSyUuREKDJsoPKT?=
 =?us-ascii?Q?Z8lOF6mjX7lPs3GPj4sGWVU1X1GtcAXs4x8zH6i7u6cP983DBeVIsVKrqC3c?=
 =?us-ascii?Q?i/olkTFkdJejCWQNVHNpgPIzFtAjDriHJ+Ii6sgMBr5yp+tRi9OgE81/OPaM?=
 =?us-ascii?Q?pmpp4joWP5hSlQd0/MdmRCGIi0JlXbqrM8fnxtIg0wj8MB1WJb4l7GtFHFX9?=
 =?us-ascii?Q?fZYUk6HoxYe2t7hxZLefTOZ7rAUESO+nHV8F93SIUAJRwwHG0QgcxzJfDYxy?=
 =?us-ascii?Q?GDmKpkSkXdN7x6PPsO9Iq5a14C+Xucg2uh01BcL3OpzOq9AB+iDZNHylmiip?=
 =?us-ascii?Q?WnqJly91PmNps2sKmfEkh2PN8LG1dztd8WjloxE5wZrrpghfAsWwkYEn16/w?=
 =?us-ascii?Q?k5uW1E9thnXjqILjanAbWx2gbopkkzE/VqfBkuTsOz4GjaYmxg8d9XDY77IQ?=
 =?us-ascii?Q?PEPh/oBzCHMZ1LeErcJit+awr+n8EjJitZEQDYBxHXtJHyO6fGq6emiiwayB?=
 =?us-ascii?Q?WmMi87TpcrrOAyAuET7fpRbxltItsGdIGVklXVLdbR08HCaj1Yn3qvwuZI3M?=
 =?us-ascii?Q?pmo8hDyq7DQj2od1ox2xWn7CrsRWfgjec4M5n42xmBuUkmpgWujaCwwAfPAv?=
 =?us-ascii?Q?SvLHbwrHzjFTJ/l0FHyih1SA8UuU5pHc1fwq0F/l/+scYyBTly0z3poOVqjF?=
 =?us-ascii?Q?t1XWXYkzYow/hZJrb1BSbmf0W3wlmDDFeq0yZGvr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de112f0f-a4dd-47fb-e7e7-08dc385d11d8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:59:16.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQ2uM8w0U2MgM+md4xKyj7H3zBCEQtc4eUy8uNU6TrVUITXMdT2z9nYJga5nyAYxa1FmfVU6b91zrf7ZrUbuhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

From: Ben Ben-Ishay <benishay@nvidia.com>

After the ULP consumed the buffers of the offloaded request, it calls the
ddp_teardown op to release the NIC mapping for them and allow the NIC to
reuse the HW contexts associated with offloading this IO. We do a
fast/async un-mapping via UMR WQE. In this case, the ULP does holds off
with completing the request towards the upper/application layers until the
HW unmapping is done.

When the corresponding CQE is received, a notification is done via the
the teardown_done ddp callback advertised by the ULP in the ddp context.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 66 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 ++
 4 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index c87dca17d5c8..3c124f708afc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -52,6 +52,7 @@ enum mlx5e_icosq_wqe_type {
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE,
 	MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP,
 #endif
 };
@@ -230,6 +231,9 @@ struct mlx5e_icosq_wqe_info {
 		struct {
 			struct mlx5e_nvmeotcp_queue *queue;
 		} nvmeotcp_q;
+		struct {
+			struct mlx5e_nvmeotcp_queue_entry *entry;
+		} nvmeotcp_qe;
 #endif
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index dd9c28d60fd3..4c49ff9a7999 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -142,10 +142,11 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
 		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
 		       enum wqe_type klm_type)
 {
-	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
-		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
-	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
-		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 id = (klm_type == BSF_KLM_UMR) ?
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT) :
+		 queue->ccid_table[ccid].klm_mkey;
+	u8 opc_mod = (klm_type == BSF_KLM_UMR) ? MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS :
+		     MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR;
 	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
@@ -158,6 +159,13 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
 	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
 	cseg->general_id = cpu_to_be32(id);
 
+	if (!klm_entries) { /* this is invalidate */
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+		ucseg->flags = MLX5_UMR_INLINE;
+		mkc->status = MLX5_MKEY_STATUS_FREE;
+		return;
+	}
+
 	if (klm_type == KLM_UMR && !klm_offset) {
 		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
 					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
@@ -259,8 +267,8 @@ build_nvmeotcp_static_params(struct mlx5e_nvmeotcp_queue *queue,
 
 static void
 mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
-		       struct mlx5e_icosq *sq, u32 wqebbs, u16 pi,
-		       enum wqe_type type)
+		       struct mlx5e_icosq *sq, u32 wqebbs,
+		       u16 pi, u16 ccid, enum wqe_type type)
 {
 	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
 
@@ -272,6 +280,10 @@ mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
 		wi->wqe_type = MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP;
 		wi->nvmeotcp_q.queue = nvmeotcp_queue;
 		break;
+	case KLM_INV_UMR:
+		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE;
+		wi->nvmeotcp_qe.entry = &nvmeotcp_queue->ccid_table[ccid];
+		break;
 	default:
 		/* cases where no further action is required upon completion, such as ddp setup */
 		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
@@ -290,7 +302,7 @@ mlx5e_nvmeotcp_rx_post_static_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u32
 	wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, BSF_UMR);
+	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, 0, BSF_UMR);
 	build_nvmeotcp_static_params(queue, wqe, resync_seq, queue->crc_rx);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -307,7 +319,7 @@ mlx5e_nvmeotcp_rx_post_progress_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u
 	wqebbs = MLX5E_NVMEOTCP_PROGRESS_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_PROGRESS_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, SET_PSV_UMR);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, 0, SET_PSV_UMR);
 	build_nvmeotcp_progress_params(queue, wqe, seq);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -330,7 +342,7 @@ post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, wqe_type);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, ccid, wqe_type);
 	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
 			       klm_length, wqe_type);
 	sq->pc += wqebbs;
@@ -345,7 +357,10 @@ mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wq
 	struct mlx5e_icosq *sq = &queue->sq;
 	u32 klm_offset = 0, wqes, i;
 
-	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+	if (wqe_type == KLM_INV_UMR)
+		wqes = 1;
+	else
+		wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
 
 	spin_lock_bh(&queue->sq_lock);
 
@@ -844,12 +859,43 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
 	complete(&queue->static_params_done);
 }
 
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi)
+{
+	struct mlx5e_nvmeotcp_queue_entry *q_entry = wi->nvmeotcp_qe.entry;
+	struct mlx5e_nvmeotcp_queue *queue = q_entry->queue;
+	struct mlx5_core_dev *mdev = queue->priv->mdev;
+	struct ulp_ddp_io *ddp = q_entry->ddp;
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl,
+		     q_entry->sgl_length, DMA_FROM_DEVICE);
+
+	q_entry->sgl_length = 0;
+
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->ddp_teardown_done)
+		ulp_ops->ddp_teardown_done(q_entry->ddp_ctx);
+}
+
 static void
 mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 			    struct sock *sk,
 			    struct ulp_ddp_io *ddp,
 			    void *ddp_ctx)
 {
+	struct mlx5e_nvmeotcp_queue_entry *q_entry;
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	q_entry  = &queue->ccid_table[ddp->command_id];
+	WARN_ONCE(q_entry->sgl_length == 0,
+		  "Invalidation of empty sgl (CID 0x%x, queue 0x%x)\n",
+		  ddp->command_id, queue->id);
+
+	q_entry->ddp_ctx = ddp_ctx;
+	q_entry->queue = queue;
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
 }
 
 static void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 8b29f3fde7f2..13817d8a0aae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -109,6 +109,7 @@ void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
 struct mlx5e_nvmeotcp_queue *
 mlx5e_nvmeotcp_get_queue(struct mlx5e_nvmeotcp *nvmeotcp, int id);
 void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue);
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index c88c4972f708..89ef317bdd2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -968,6 +968,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 			break;
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
+		case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+			mlx5e_nvmeotcp_ddp_inv_done(wi);
+			break;
 		case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 			mlx5e_nvmeotcp_ctx_complete(wi);
 			break;
@@ -1073,6 +1076,9 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
 				break;
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+				mlx5e_nvmeotcp_ddp_inv_done(wi);
+				break;
 			case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 				mlx5e_nvmeotcp_ctx_complete(wi);
 				break;
-- 
2.34.1


