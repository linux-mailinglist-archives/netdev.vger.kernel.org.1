Return-Path: <netdev+bounces-43860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3BC7D506A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E1B1C20DA0
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A7F26E3A;
	Tue, 24 Oct 2023 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zk7O2+A/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B6C8EA
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:56:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C626186
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6y2cjjUBcVT60YtvCmfqF4v+WAKr4BkaVRH1+wqf7e8xN/dvxVZWjimMdYgNc8UD0+Mp6xFISAc7+H+a59XVbWXCEg6ESa4FmdNs3XeKs8LQHow1pETnWTszpGL5xX80qXTbNO9O7a4UpBsRRaiD9HnC/I5aZJmk2U5lsYcO6M76/97HvLy4di0P5Kf7zmw5BXfJDRpXzT0Q9pv3dY6cIWDSLXGcEPNHnZtRoYaeDubYWUgB30YwAhMLah2ysBAEzDoLi7QMQIYNhxqdIIvNknbpS7m493eAL/Ahwf80iya9P40YZ98XtibQSIj0eAonq1Eo7KKVsD/asUw9YVMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTUkjcuV07Pg3PvgKTqfLmlXN/wv5EJ2zOgiD58rK04=;
 b=QLdIZ9lBzIafdio/B/ojF4sC0M4nBdAzgYVmcKtqXpQbb8YrEhhu3XuMygP9tImCHeyp8NKsINWjOaA8kfwNLllLcPRaHcbwfaztQ6rXeNEgNlnp/mpB9IbaNTjPI76Tvp7aQUN5i7dWCAfCTDNEb3dgqFKIqFPsRuh6rXjCyw9yqYqWnGvsJKq5PFjZkykZcQoomHuwnons9jsYBZtvH+Um7FJn9jhr7Y8luqnhvrJBQUUWEAvGA+KPOIq1Xd9aPGYfRz/5G0JyY1wnZk1p3tupIElbLapOqHrezLFiGMFUwHiXv8xhaA1uc7175zcxnc+S+TIFJYWX4BLja7cSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTUkjcuV07Pg3PvgKTqfLmlXN/wv5EJ2zOgiD58rK04=;
 b=Zk7O2+A/zxVQF9Mn0tLJVzJ3CRsFyA7iHQrXAKvDUH/pNOqwp7BSZip4LtNdMuaUIsQg82QpGQsvm6yb5H/SplpMTwlofS4/9K61de+TCoTRdFZgJ7bJQt/HFKJoVOlAKa2gQh4U2+Aj13rqFoKURUshFPi380xYa2Rt/fNcomu1/NMXjU7INPQCF5eV2+Y32MrmBz1Nd4sgcbigBwQtdeYgGHMRdZNgZfUc4uDGyUgg7dT7IqFu4LKg5vgKYMREsm+kC+NqLabIxeTzxfzEFLRjHChQ3B9tFJcaNA3zeueZoA/4O66jezdY/fa6bUNZpGx3wI9n5pZXAzdOOOOGwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:56:00 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:56:00 +0000
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
Cc: Ben Ben-Ishay <benishay@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v17 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Tue, 24 Oct 2023 12:54:37 +0000
Message-Id: <20231024125445.2632-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0489.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f96eba-2708-424c-9b74-08dbd4909263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7yF85ePJp0QQYjmTCC54FJydaGJTTln/wFffg+PjZI2hVHoVqR7VeJAbS0SRpj9rCTVtoNOxoNK6V2Tz6I95Nv1D5PVh0f1PN3zqTldTFoRioGXciN9/KabcxjZbKo06RVW73HW3B2/sChjvH69bVBNg9ju9rceQ1mw+gwRaBtcdpp9kxv8pmmQhkhrKLOzqYOkEkD4zPdVWeHpaL12c3Qn1+fUBJAOCUTXmLtUJVitac6TTALvv8V4Np3mlj6mqZ3vT3rT9WLZ6EZhRhTnYolq2NdGq6bpFXqSA2FabIvKSG9VvlA5UutAz8yhdps7MXQHGFIBEKRqmALemNDXQZX4Jc/JinPlHSTgYAeZnLxXg4RdEoOn+80JvAJKinRWWZo+qBQ8qQ/Axnb9dhqhUsXQSzqn0pI1aTHj9yxCNypc79wBurQuamRqYtBnxbys49PFns0na4UUIdUx26bVQ9G70F2tFuVygNYwdmjuNnNI2IVcTZ68eH/SyhQzYDYjLw3mu+CuBJFegmLMGNK0RSYOrjxu+avDQWGO2G67z31hlzEyyW7NBOBkJZImBsTVP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(107886003)(2616005)(6512007)(6666004)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rN6zQxQ9x8NnNj3yQxZMvPlrLQSJtev85BW1ksfTFuZZKsSP8fapotg8fbvb?=
 =?us-ascii?Q?s2HT/5KVGYJjbsRxdQTW/1p2hTcymkxzU6ABOAEk899CKGF+ZAPFJMQluYqX?=
 =?us-ascii?Q?B2KSsxW6l4dyiu6u5S9t0p4u/MCPwS0BkyVzVmrV07qxjYti7DU/FBvBU1Bz?=
 =?us-ascii?Q?8yeh5kVxNCTthqNJ+Qi1UCki0NRqkGSNUr1SlKAX7uKXk1IxQ4Epg04/dNZ/?=
 =?us-ascii?Q?MvR2BmmVRH0zbSXigRthdHkCsIFlbErjbuf5883aG4mOtHehXAB7WLLj4s0i?=
 =?us-ascii?Q?zAqFgvZ9qenwphGYpUGbmnaccIFXMecvCAFJytBOUkjERPRKXFy2q+o0WqWV?=
 =?us-ascii?Q?x4INZPVh02rMahqw8rqzmbbz3u6mr4STssczRmdG3dJHIfi7MaJQJdtFaKb3?=
 =?us-ascii?Q?XQMpuSVzILmyD+NzIJ/JLVi0fG0kYDGUN+bL5MvwLJHQ1Eq9KWiMD2Vii4vK?=
 =?us-ascii?Q?AvCkmplPBCp4C28/cOEjswM7ZvzLDp3Lf/hTWJk+tHBZ0BmBWe1/IHxAxWxX?=
 =?us-ascii?Q?G3Y31QXOcQAUN1F1XqpusLnpsSVDpScTDV90EdBqsYeGY49FYZG27Vcyy4dW?=
 =?us-ascii?Q?QstJi/0J9lNmiJQQjkGXArfhb1NSX9yORQMsqDO0mHHAcRq0MUTDnwtAr91i?=
 =?us-ascii?Q?Sw2dHlKIrCgKPkatbA5Xm3L1MG+XDe+VnzwFnFGHonj3yxthRfFQXmmt2DAx?=
 =?us-ascii?Q?fKeF9tqprY+fmuWAtnoJeUq5AhKEOF9yr0xXhQCIFGpftycZzbAwk8dxGt8q?=
 =?us-ascii?Q?xci2qQWdOKmH+fQPB/nBomRkvX3CFhSE/4EsKfFN7mAzYUCmuAl1qZ4DBTf0?=
 =?us-ascii?Q?6ko2XG+p+IpJabsKrjeOESrYzzfcIP/1na7ZLvo/2WRWrhol207bRnB+mKFE?=
 =?us-ascii?Q?a5f2RkvyaKgTETMjDTMUKBqYY4/Q4AWOgfU7pfKlm3790BZ5C0NC5BRTmFqO?=
 =?us-ascii?Q?YdXHXDR/1SPMpOWOFgj0zwkRrLsK1W5F7Ptv9DBxCMQt7ydIbSM4VHMXv+Gz?=
 =?us-ascii?Q?IAsbmcI20kUoZko/+n43EwoAihtfHk19KpW9a+AODQa7MkRQQFGs/EVsEVm8?=
 =?us-ascii?Q?1ILq5fCj3U3Y8aAawfZIaRqGfTz0aXV6mpottd7YAQlolexJJ6sPG55xDhr8?=
 =?us-ascii?Q?ZSuPMGO/sZPJVpLRDi3IS2VZ3vARgEN2W/9DF9oLC8lPNiOTApGg4OKVD3+q?=
 =?us-ascii?Q?VSWz31qX+kuHjTvm8+pHCwVr8R4A64R8qDWoE2r0a1iqVnEMPvbOfidHmsbv?=
 =?us-ascii?Q?z08ZGzw3IGT1oT0VTdD6OIsL8ZA5P59JknLpdrFlioLlSW8n5e2e1zl7nb2W?=
 =?us-ascii?Q?K8QslAU/JcpTUx+P6OkwCdcp3SIyGd75AfR9hdzSZNUqKMNTdf6Lnfpefn9x?=
 =?us-ascii?Q?9pqtJqIcKX5OhMrekk3yPKM4oz6UGOQkpW1FM7RIxKxBhDPkwy1zG8Nu4f0e?=
 =?us-ascii?Q?XJxq1/C3vhyM9gpUsGX3jEk8+Kn/D/IBx622qH4ykWt/+UFCadtSKsaBHRGa?=
 =?us-ascii?Q?fw9IHXBrVNPywnEuN9oJ3gSTizmt11s40FDBZUOMXgkHelyIGNUPu7Ibs+EV?=
 =?us-ascii?Q?XzcSd0KEg58MDNDW3ev30mRPkjL1FA9BbFPG1TVX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f96eba-2708-424c-9b74-08dbd4909263
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:56:00.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCNfbkdak6NGyn60QDW7hNWFb2pB65ER00o+GRNw3fxKIsbQK9KyZy/ttczNWw1MjUnHYbSHnQK9xT4oV8ijOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

From: Ben Ben-Ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:
- Create mlx5_cqe128 structure for NVMEoTCP offload.
  The new structure consist from the regular mlx5_cqe64 +
  NVMEoTCP data information for offloaded packets.
- Add nvmetcp field to mlx5_cqe64, this field define the type
  of the data that the additional NVMEoTCP part represents.
- Add nvmeotcp_zero_copy_en + nvmeotcp_crc_en bit
  to the TIR, for identify NVMEoTCP offload flow
  and tag_buffer_id that will be used by the
  connected nvmeotcp_queues.
- Add new capability to HCA_CAP that represents the
  NVMEoTCP offload ability.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  6 ++
 include/linux/mlx5/device.h                  | 51 ++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 75 ++++++++++++++++++--
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 58f4c0d0fafa..f1745f69337b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -280,6 +280,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, nvmeotcp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_NVMEOTCP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index f1dde3c6a3f3..6416a5e8a8e6 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -264,6 +264,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -798,7 +799,11 @@ struct mlx5_err_cqe {
 
 struct mlx5_cqe64 {
 	u8		tls_outer_l3_tunneled;
-	u8		rsvd0;
+	u8		rsvd16bit:4;
+	u8		nvmeotcp_zc:1;
+	u8		nvmeotcp_ddgst:1;
+	u8		nvmeotcp_resync:1;
+	u8		rsvd23bit:1;
 	__be16		wqe_id;
 	union {
 		struct {
@@ -847,6 +852,19 @@ struct mlx5_cqe64 {
 	u8		op_own;
 };
 
+struct mlx5e_cqe128 {
+	__be16 cclen;
+	__be16 hlen;
+	union {
+		__be32 resync_tcp_sn;
+		__be32 ccoff;
+	};
+	__be16 ccid;
+	__be16 rsvd8;
+	u8 rsvd12[52];
+	struct mlx5_cqe64 cqe64;
+};
+
 struct mlx5_mini_cqe8 {
 	union {
 		__be32 rx_hash_result;
@@ -882,6 +900,28 @@ enum {
 
 #define MLX5_MINI_CQE_ARRAY_SIZE 8
 
+static inline bool cqe_is_nvmeotcp_resync(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_resync;
+}
+
+static inline bool cqe_is_nvmeotcp_crcvalid(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_ddgst;
+}
+
+static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_zc;
+}
+
+/* check if cqe is zc or crc or resync */
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
+{
+	return cqe_is_nvmeotcp_zc(cqe) || cqe_is_nvmeotcp_crcvalid(cqe) ||
+	       cqe_is_nvmeotcp_resync(cqe);
+}
+
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
 {
 	return (cqe->op_own >> 2) & 0x3;
@@ -1222,6 +1262,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1429,6 +1470,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, \
+		 (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
+#define MLX5_CAP64_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, \
+		   (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 9aa81c8c5b14..f67e1b2c3196 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1456,6 +1456,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_7   = 2,
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+	u8    reserved_at_40[0x7c0];
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x10];
 	u8         shared_object_to_user_object_allowed[0x1];
@@ -1480,7 +1494,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         event_cap[0x1];
 	u8         reserved_at_91[0x2];
 	u8         isolate_vl_tc_new[0x1];
-	u8         reserved_at_94[0x4];
+	u8         reserved_at_94[0x2];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3469,6 +3485,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3721,7 +3738,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3752,7 +3771,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11965,6 +11985,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11972,6 +11993,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12338,6 +12360,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    reserved_at_60[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12351,6 +12387,13 @@ enum {
 
 enum {
 	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
 };
 
 struct mlx5_ifc_transport_static_params_bits {
@@ -12373,7 +12416,20 @@ struct mlx5_ifc_transport_static_params_bits {
 	u8         reserved_at_100[0x8];
 	u8         dek_index[0x18];
 
-	u8         reserved_at_120[0xe0];
+	u8         reserved_at_120[0x14];
+
+	u8         cccid_ttag[0x1];
+	u8         ti[0x1];
+	u8         zero_copy_en[0x1];
+	u8         ddgst_offload_en[0x1];
+	u8         hdgst_offload_en[0x1];
+	u8         ddgst_en[0x1];
+	u8         hddgst_en[0x1];
+	u8         pda[0x5];
+
+	u8         nvme_resync_tcp_sn[0x20];
+
+	u8         reserved_at_160[0xa0];
 };
 
 struct mlx5_ifc_tls_progress_params_bits {
@@ -12672,4 +12728,15 @@ struct mlx5_ifc_msees_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_44[0xc];
+	u8    cccid_ttag[0x10];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index bd53cf4be7bd..b72f08efe6de 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -227,6 +227,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


