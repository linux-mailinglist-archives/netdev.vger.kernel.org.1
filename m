Return-Path: <netdev+bounces-57443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C7E813190
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F7428338F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEF256462;
	Thu, 14 Dec 2023 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R2b6BOFE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC99198
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:27:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD/MAeZGlprRmeGxwhhPMp6gI7S7KcEm3PfzcO6iW0nokS+onjH9u6qAnoPvvfZ0YwmxUmOggXXR1OXHQ8u0edVkYxjhPM3dAcXOZNOwDbefnp/efnKV1nHbgxaGrqYuxaNc9y7sn9Ck/4LmxjcSDGRUbDWJZRRZCABHoabhWUpv+dLS55lrY8JVu4kGC9wc1T2HjDx7U7QcQqFiNA9U9+2YEZ9BiHQz/s4CUiurTpq/gvZTMEPY1PLNDQJe4+0Gc0AG+EeS2TW5y9p9Aad4tZ6TnoZsvcJoQ75z9UnsRkeNLtVe7YJoitWZZmi4/+ovxDtM3Y+4XJU2bNOO6uzMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2tSoZ3iT66rNXAP8OdSPtOyu6OiqwlCNJ8UQWUenAc=;
 b=EWC9BArvrcxYUugZy5PK9LNl27gYVLRP/KEuUwLMwcLz0R52IjjN53AMWq9sSYGpKSCVlj2KGfeLAVtvC9pVEben4Xv2S5kFErubD/hFhSXnBevsTPqLcc4ThhWlq81mKpaJ134s8qZwzfKWfI4aPjWLTU6AbDKQmXxWS/WW0EPux4xmQ7jMVoDdu+gaVJhfWzVfnT4MuPMnl6VmdP1GCp+vMwGNjWOffdURDy6/7CxPBEvPjjtECq5YoBJUc5mcUpkKY6N0eR4+HkEf2T1EpAMLxy3n1giKu2T5gIw8T1v9V5oHMHE+S8a8GJZaQzXFFRcts6VmyL8K89bKmBP46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2tSoZ3iT66rNXAP8OdSPtOyu6OiqwlCNJ8UQWUenAc=;
 b=R2b6BOFE3bpf7m4zmhrOZB1w1QvSH8f8QHqDYXlYdZNRI5cFkCxJ0H9zK29bWCbd1pWcDxfjsdudXyBS/WLySQ/B8aGvfQELr4wFP8W1uLuIC78R0LYxCKe+FROQCIdsICCEe3sRNJtLPL+4ZVj7KHH2ZigQNoHJxQbHOcHpwVyp9n66CmVKrI+goRIg0YYVVxQY76KJhMUEt2gpSK9ZWn8beW46NJkZhQK7g1Qm9XOh/1egrQMxplyrakzzeRwFMGsxO24ztzi5KiOqSPMXKVjk/XeJmqUlSzZQMG8d6OEZ/5Gu8pkS4g1U11CD/G2B1fUPIjY/xDK2WmZns2Hc7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:35 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:35 +0000
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
Subject: [PATCH v21 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Thu, 14 Dec 2023 13:26:15 +0000
Message-Id: <20231214132623.119227-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f8eaf3-0ea3-4d16-fb1b-08dbfca86f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H1xRBGGlTfowUtrRRsi6MjqL1O8xqEyzG9bhsVbRX37bqrRHEitfy5ydhzgkO8g/gcRfiTXww0nd65BZOdP68Gy0kEwR9+X9ZEEyj9fkVaOVegUwK+P2uZHktDZwmaZZ4gkiifQpnGqnlMfCNj4kFioVorpRiOIFIzOMHX8gWOd7iaNWElw1FRsPW7JnWenTWfZtTLTMvTV0mi6E8SSqO9Tp3dCk78HfdMZ/17Trbw75MKk5fteAtqgn87ZsC4UiDEax7b4Pz9eYb9qMzSjaHU308DRydKkvYyqPZObb+an9fbATDW9/oNZSuZLZAJb1EYbBgU+ThulzAZDS2JLI3urJajSvCrfUV0hPAbO0Ucj0mDs74qjeVHEjaRz9tICqLSn2OwwXTBBApoqa2UxaIJbatSjffs7fJ2Er08IfnxkfaRsRw7+FrBPrBqfxCBtDHWDhu+fbG90pW4ge6mXneOnE2WlbCecApk0Ad5mEP9FrHRteGTQ+LNjZRvNiz7IKVSfnaOh54YW6TRbL6p4vFzcvuKoCOL3dmln1xqXjrrBHwxnnP/WU88bqcHFdp6N/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(41300700001)(83380400001)(38100700002)(316002)(7416002)(5660300002)(26005)(107886003)(1076003)(86362001)(8936002)(4326008)(2616005)(6512007)(478600001)(6486002)(2906002)(8676002)(6666004)(6506007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gpsSKXwguLdnKvbtjc5VPeRbyBwWsyWP4AWZv3CkavQ9o3dibL/DHQvLt/VU?=
 =?us-ascii?Q?ys7x5yx8t+8yytEU4UPA8gLXvdkRROlCbvet/22TxVwFZD9XeK/jErutWSwz?=
 =?us-ascii?Q?7SHgkcjWPMmzqIns1OQ6XkAKx8eF7IIY41uOuIcp9zI1EVybcwA5v+M+TPu/?=
 =?us-ascii?Q?Uij1mNMZr2xQo/fILAMNvGwVK/QDxM2Ef+jw1QbKSqKnWZ00W6KeB7Xpx6jV?=
 =?us-ascii?Q?DymvTjenbwra2xq6xr2/lxup7OnGFnse+low2+kdvf8LNEBJK2i+Dsa0eSYp?=
 =?us-ascii?Q?f1DJubDoHpbyGG8PjSWY9LwkKC9ApJBPt1qI7A3IgBeEQQfrnlFN8yYeFunS?=
 =?us-ascii?Q?m/7wZ2zsXfvyYso5LGOdAtaOnUU4Gq+RsCkavSGbEXH4VAofWQxaYmeg/Mal?=
 =?us-ascii?Q?tiFQdu/SLPBLE5dqYkuwK+7tfjJFtMZnoA26VNcrzdBHT+/yFzTNUOC50pej?=
 =?us-ascii?Q?Vyz/F5L2jwYQrvYb1pV5uziI7C4AP8p7aus+DIhFbqAzbks9qLKExmc5GJkS?=
 =?us-ascii?Q?Y1Qss0uteX6sASJ2ZvzwIaNJaVMkaK1mnErcdBcssuBKxs9j87W34kJv7vZq?=
 =?us-ascii?Q?sjT/5D/Strvuf/Oep3WY79IDo9oIEqala6nq7rPZiNMqQocMRkFSe4CmCU0+?=
 =?us-ascii?Q?0kbQtt2wXrFdRt/7A0kKdpgrlN7LXwzSzirchf6Cnuv+jdsKRc62Nn90m2Hf?=
 =?us-ascii?Q?0zMXn6WrprLxm4N5SZ/lVp0wLYr76JNiOklsRWsacmJ33vS1sjq1gK75i7tb?=
 =?us-ascii?Q?GRca7IvctNlUAQKiIZfHOmZ5+kiTD7IK29bI+QrlhAui2Eg0Le69LKwqWGHy?=
 =?us-ascii?Q?FSm4klC/EjGZw3yEnsc6dCP1SPcAWGySH2SOzdy7TsEuKIY0IthxKuRjiZ/7?=
 =?us-ascii?Q?IEzb2+ZYa8zQkqpuYiDTsHxS76+Sn4p3VLGFm2sSv7MeOb8O18N+zhznU0nl?=
 =?us-ascii?Q?X9va2lhpJKlPwSww+6WMYHsnivAxkUGZzpwIgNyyUvAtQqHUD2zBaMhJ9woK?=
 =?us-ascii?Q?xyeCyy9phWRxLsefyxxzEWGX996Ep9lQ7IJYwBGnJv9RxeO1VtlBD00pXGoP?=
 =?us-ascii?Q?K1+z8M6neXJtaOfgKPu1FyUEj00QLKWjaJk/+TRtXaPyOCLu0hOYtIFVI1pK?=
 =?us-ascii?Q?mp5uXYtTydYchNhRSz+UP57VYDB5s8hkslzyxF7LdZgxtzcZfQDhf2FOVYhk?=
 =?us-ascii?Q?bDQFL/ncDIloUuyVqX5OKuobJsd9Oz4nPs74NlT0fQoPdcQeUE9+v7UEkMcB?=
 =?us-ascii?Q?inPJsih4/UdasM4ruWxXOBSVJVWwYUQ02oi8zC7zOIChHXgEmGiDR9yTOiYY?=
 =?us-ascii?Q?gdDVkBD7kYAJipwnNX8OfWkJegd7DaBVjd9uSP9c17GOmZ09TWmw9nPyE0wo?=
 =?us-ascii?Q?df3k8DbZma5KxU6qt3XudyBxQbJZiOkz52YV3XJKuywzaoW6LYDwH/cq54Pb?=
 =?us-ascii?Q?rm9gqZNESUDatarrSA8OlILusHxoZ0eb6T0IctpO546/DmKXRb9FkCiVZGtt?=
 =?us-ascii?Q?RJlYUrpuDHGjTv4+FHL4PsJPhK6poISgZfs6X1PCp4uud/0Jda4iSfV5zBRZ?=
 =?us-ascii?Q?ORGXjSp8VkjZS9L/wuDcneLv8IBCLAWFPET9qIaO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f8eaf3-0ea3-4d16-fb1b-08dbfca86f09
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:35.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gy18rpP/HBvZa1Gu6a6kh6+m6ZQnIS2xQI4aXK9e31NHgXf4/P9kZwiUrtyQhP6lEqfW4Dm06Tr4H+g+W83NXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

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
index 7388410292ae..ea321c96c1c2 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1462,6 +1462,20 @@ enum {
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
@@ -1486,7 +1500,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
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
@@ -3475,6 +3491,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3727,7 +3744,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3758,7 +3777,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11974,6 +11994,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11981,6 +12002,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12347,6 +12369,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
@@ -12360,6 +12396,13 @@ enum {
 
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
@@ -12382,7 +12425,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -12681,4 +12737,15 @@ struct mlx5_ifc_msees_reg_bits {
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


