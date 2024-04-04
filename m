Return-Path: <netdev+bounces-84869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D403898813
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DD528F656
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BEE128812;
	Thu,  4 Apr 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWH7krVM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2099.outbound.protection.outlook.com [40.107.93.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AD128811
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234351; cv=fail; b=RMX5TGX4k7E9buF0ikudv+cSGocilnIQHljyLo+J5Hnfn2/eUi2Zcud8bRm3e6rn7hZcEAIIW5xIbDqgCtBudTexktkzRIQKswo7vgMjMramIkcJuvEHzFuyFyNpJ+irWADqrtGm3TY7KCxcT6WETwo47RYnl+RwGYLBtcZ0TPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234351; c=relaxed/simple;
	bh=pLgeqhDzQKCsB/Vm6qHiRawexxVO2YfElh2F/BGvFak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yx6hti0J9Sm1C37YaOTym+sUPdG0yzYnr+IqGshUe9xjzLZ26V4qbH9scqyhd/asaDKhWUAs64PHW8hpvZ0CMK2QJioSuDcbnde0mYooKmLG2l9IohgyVvCBI0saxlv57m14Tzq1FHKxlKlg3NcSTknACXx2ZyoQErGBwRWkFIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AWH7krVM; arc=fail smtp.client-ip=40.107.93.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cm8m4VrylksuTdfiTnvb770WBrH1ur9jcbYLfMlIygtey5xY3YAraAYF44DMhSR2rkIK+kNCZdZSKA5yu43zgU8skzk1/oC+BSbQH376dbPlw8UMfVJi7BkicGMUFnylWCJ+w0v3RoRUggAww8b621X9GosJ/SW9kR5DPGSpJz8nfikf8fDvRrOZtLVK0OaSI1ABkIuNqSDqCjhMn29O1iFiW47vWPvr/vyopXLAzbVQwoWp+ItbjGh+hAG+Hevmmeea1QnIG4WOFzgsw1cRMYPn3heEtxBRN37qmsedd6VoUjYdEYhTpGiFqnxSTrDjFL2yLIBLCZcc/beKyY0RUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4AQqiSyVzue2PNBj/khbLl/UgDPvLexh1Uw+bkIlF8=;
 b=lza7Nn0sQZ72XeRIK1unS28JMykQ+XJNN84yAuMLQ6thN6Ua9fHr5fy/MnnsPptiEo3QGqQVctmva/zQjVjnbK3Ef38WWfbr2hIfXUYoCxi+1B0eK5eiGzR9LbQsB9tDVVEuv2MeQDHL0ubybcaPTOD239BSJ8M3gAdAr/GSewgHu/b7dHLAdvuteYJvH7f2TRjF9ZZZweUPgFfPU2ysx1RZcDdn9qHjKWqRga7BpkjsM7P7FWcbM+MNXKqAI5dVjTluaKsE0WRZiihxYtc/HYrh7eC9CdbdrKxmmh6pQFtv/VyCDddgrCQq9oc5kH4hUAQZkVSHz2BXO6wcEoOlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4AQqiSyVzue2PNBj/khbLl/UgDPvLexh1Uw+bkIlF8=;
 b=AWH7krVMBJoe7SzAXKmTYwgljFVXZJ3efcjI/7Eht/PxAYO4R5YJ2mSLtP/tJt3iR0toU+XvQtLOUr0DiJi+TBzRfQUUUW4LJoQBFCz5vs0lAuhEb1oghqjQYjfd5VAk1hw52SuBSqhYIRHEN2tfKaM3gcC6mSN+huzgEZ6r+UaqDlWzNkBhIw+s/YDukNbLeSoSlBQ889ETX8jvLtpBGxjod246Cqj0UXw++cATRzCpvivesco7Aztdb7gl54gj4tkyycDKXpzayVuveA2KepEHZ0g6QH3LXdlH3dt78lD1AxoN+awSS1Gi6sEcFC8qH+lY+GOPT1yg1dL+3ViUYw==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:39:06 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:39:06 +0000
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
Subject: [PATCH v24 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Thu,  4 Apr 2024 12:37:15 +0000
Message-Id: <20240404123717.11857-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA0PR12MB4384:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZYGnPfYAdTbBUzUdddAuST3gP/lFeu5vnbKKuxjaNvzoexRUty+iz0mrou83u3R4h7RQUojSV9pHmApAKYYUgaWQGOOehDCGZAHpNniTsa+bOZLZ77g5v4CgmCAD3lwRmBJcelmRU7fBHBNY8y1FIQ5GLxWbTVc7i1mcQuljfGpI8wz/LX48gwIDE8/fOhS+00yJDU92VJ613nj0z4IuwT8kQsHLn4L6/fo24k860iWh3m/8uPlI/ilLv6P2oAvfqd7/N+asnQ2mBIt6SR2AlgBE9zyLVX205XWKyEKkptbggKp1zbtJXIlzy9Yn3WHrPqRAUkFzpZQZtU1thJiMIPE/4jnpdHsCiDTyxkgbqXNjmeqUUo5GGlJZtZYOkPkrM7+8KK/LQ6y6+TkF3Ror+ukgKT3QlvtLIr7hr5aIAkF/24jF/rcBximIUbAl6zfS60tudd/r7y9krVSvi59D3xmPAJGo0Ooy7pXEt0UNil15fwwE6KBqRCyEraQ2gKODF2WXX71oToDofLGC33HLjKV8ERP5WkVfJtCfPGoapD+1wSvCdeCMT2lA3gdZmPat5QEu3oERw2Oqejbbiw3+hu/0Us2F/Mb2yBWdYwcSyZrstih17DuBb4dglX/VpvmFYaJR0PImoYVx7kAVlDTJFQ+ilIs8+R8Kj0FMC4F/plw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pc7DjStmSwj1moxutbriP3wEKoEidsF5tPms1Y0BxMCIyfbZhJrD0QRk0hVK?=
 =?us-ascii?Q?3GJznGVifzVYMYrG0NrQgj/XVY7h/RJAlLybm/H/03+KvOXdXJzlg/uxcq5B?=
 =?us-ascii?Q?JUQ2NA+xflhqLA1NpH2TuOIWfJ9wUe20FOVETNyV3R2kJ6kgb9WhgAYg3CNe?=
 =?us-ascii?Q?uJQk6fZMd7EAEUp1ycijxaWpz0z4JqaJXdHlUWS9lpzsGogFSh+17/0tsX+E?=
 =?us-ascii?Q?w430ap7ZccMxn2/szKZ0Rh2GDc+krKK3GtaBxln40CT4i7l54WJsgjp3iFvT?=
 =?us-ascii?Q?52UEoHlXR7QpS6+pexeobYMAOjQPWxM1WazAh1Eq/iwAumxHdR1giVOjxZBY?=
 =?us-ascii?Q?KQ7GuudV00+QPFB8Y93no3tGB2e19242IOZkXX/tEqvoIeETKazC5bDC6Hrt?=
 =?us-ascii?Q?1kqm8gTN1o91MdlEQhcD254wgfa7oQMeftEd3bJfw5AE/3SdyG7gRC5y+fQt?=
 =?us-ascii?Q?9U1xANCVyNNgSfCe5nS1jAhDmT9vWoAbwo86vdSapGsgPGrPWydR5yBd46N7?=
 =?us-ascii?Q?FuXDjZ8511IZiLRKKaYQi/Af12GI4+zoy3kWSBxI7Ue0Mm477Bx3+blLxc1H?=
 =?us-ascii?Q?mYZE5unv8qVtcn3ais6GpC5Oa+qMK1Ae32qVasL/RRFDxLdY48bkgqrmQyls?=
 =?us-ascii?Q?yCcD0VYtbIfdzj0noBfJRXJtA5emR7GHMGusgsapX1B/MjeU5HCZnRgeJDwS?=
 =?us-ascii?Q?b5tDa6ZdQUQNa6/HJvug2JqlqtlxpsbYmDpb6eK95KM6FLZ2FUyzgJaL6vvZ?=
 =?us-ascii?Q?GiaJNSWuniGoGIeCjEWfVlQJpz90+4YhgZpHxIm4VlTwNlIhH4Asea80ho0g?=
 =?us-ascii?Q?56BBCvgR4XB5CtOH7gAxko4TkJzfT9En0c+awzjXKiiqUniA278fMBDHPgG6?=
 =?us-ascii?Q?DQ8k33gAiSYeD5KvX2nwcX0TLSVgOoNEk4elaxFKxyZWQXgyPAUGWab/RcFD?=
 =?us-ascii?Q?YUr9iOluTKz8+KrE/iG7c9qoKHDkITjiW0t1BAUtonACQHzZYir3hF13oPdS?=
 =?us-ascii?Q?Ttv2LwmDm8WcId5Adg5R/C+fCyLP/jEwMEDP/F/CXwHwaANfNStxW8nDrt70?=
 =?us-ascii?Q?GX9+oWBaeU2ssYiMEuzdMeeTHCGo7/ZR0DtNxXPqXO9zTT0E6rIHIV3/aIxK?=
 =?us-ascii?Q?B7yvi4ojhjrobPveoGQZ8BaJyaZUd4+OYyaLrGVKtmhx2US5arVzhxJxn+U7?=
 =?us-ascii?Q?jq/VOwdRi2cumuBY4pPxzdxGsbLaS6jQR3fX/v69FMozczGhLuHvyLpge6fU?=
 =?us-ascii?Q?sgm3y2tfFF7IiptYVo1909CB8dEI036uDiHeuwFmkupRzYhj2E7zSa+A08ai?=
 =?us-ascii?Q?oVBImQ0iFSgSTN4/BIcvYkLGrQayfr5VGguts7SylVHD1+QZxM/ObKdKv7Ve?=
 =?us-ascii?Q?IF9WDknIaNy6oe4AmgBPSjwZESx5/D83836v3DxpNjM9gdt9nRMTolA0pwR5?=
 =?us-ascii?Q?qZQcqcweJ+SWlRRdj5nsfPRO6gObCFrtZkU2QMklNg9F1XHikqHo5+9dWVCb?=
 =?us-ascii?Q?U0eaoT4Qra6gW8bN2nhVUtU5y0LbbRrgeyF8VSkhrahkTlXKWyo80db3kfUK?=
 =?us-ascii?Q?2A2Pz4ldYqvXuWnVHjunIGYgGns74dDlaMIetUt0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9a2266-9d82-48e5-9798-08dc54a43752
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:39:06.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZcmKvtRHX08tt/QE063dpMCDqUFoI2bCvDzNjq+/VNIQUH+O1oGFJ1G0naP7+j+70UdF49TRrn6AFclDMbu8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

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
index d7b416f77c3f..505f4e6d5098 100644
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


