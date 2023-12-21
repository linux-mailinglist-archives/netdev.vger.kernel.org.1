Return-Path: <netdev+bounces-59779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FC81C047
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5F31C24C81
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E74877638;
	Thu, 21 Dec 2023 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MfKkDqu6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14D76DD6
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRTq9+MFgLgdDCFclVjrmnYTVaFoT94o2co9uH1GCUD3wJsms5/8JctQMSuHl852uh66/kTeM0RBTs96AVwciNdcPO8RZQ0nXGe+JcDG1ZGsPTdW+Swwols6NyLjo2vrMTX80CG8+STpm658R2EL7n6fA1ID08HDVbkeN8ryc9AM255msk+xUtTXOSS6sfTEGF2e/Wp+usBa5kN0BzsWfjaoDfB1ZKtvVl7Zi2918beYjzYvVFeL4ykwpbsvUIDwtF7UUPlnQbtgIWkxC9N1AaBCZeFvYw9qDJPEv1S3kGBtxyEmB5ztLbYo7Tv9szG5jXnAp5TlGNIMp02nMPSnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvb7MfjxhflAFlTyS3xrsn3CQoP0HBbIVNA+ozK2lQ8=;
 b=k/3aER4GmN2uEAsx7D3C9tirRxlZLv87m/xxL3se50YpI1BAtggow811OvwEa40Jy5zrfjcy0EpNvYDoda3ju6YuZnBS+mfvh0hhZA3HpZ425Ey5BmXx+raxfbfczyAzbzy5Yh0lPZbOYPJwhYiTnSMmOSszPqUhCAcmSB5ATy3vewPphIRwcsGJM3FT4FjICHv7ZuVKGuQLtfPjvIxmss3v1JX/sf2lnQAKel7MTO4DD3AdxjZLW3jk8p54RK16hqIybZoUtOb335PfynoqcPP2bXq9pLkZo0Ssd8K1rQtlFK2xHTAztLxo4lysv6WjfIUWhMCm6gfQYVR6G3wW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvb7MfjxhflAFlTyS3xrsn3CQoP0HBbIVNA+ozK2lQ8=;
 b=MfKkDqu6LEQdhxnXMpr5MmSM1BseM/v/HRY7K0NVfOA4w9Tn428wntI3aaQmmVJ7Jm1wInjPKI4lQUp36a0P8OkP+WnDkOZSkysRXOV/Wh6Ub33s7n+s3m2WvQm1syaTdUp9ENi/e57/CLm4vbxbDVf9Fz8KKgAGyTCgq5F2YKyf4kVskXtjczEUvo/MYVLrgcF/X6vvIzoLFK2J3ZHOkhWN3QrhErEkan36mtKdfi8VxLu4x0ytcEPkMXM1C2kc8WP2EoZDsJqJc7oBjimXERyyru9R3veNrgQqa+w5T3NCRcjNxFXYwy8HrgcNBX0hDYK3W9o08a32VDYqqQK7oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:35:28 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:35:28 +0000
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
Subject: [PATCH v22 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Thu, 21 Dec 2023 21:33:55 +0000
Message-Id: <20231221213358.105704-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0436.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 618b3db9-b024-4e03-b99c-08dc026cc020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2qhqM64FksVde2EQfUP0zC0N+8POCrXmORVi83Fbl3UyqktIBTN9TXq1vbuyghvtDkRgILZM+oGi0O0yMarDCf5ZNNf1xmg/Xg3yKeRfPdKXx4z9tquY/ZumO2WcvhbaAI0ZiwfBY4pGe/qk49jsPOrwWKDx+85rYAcpJ5fR99y85MNEuLHoYcNbBB2ssp9KRn659tZxcNR8jktvNq53frbMXWKolM/Sc6VxFwFWJNTI2kD7TAjjcTxcz9xxuVpnvmaCsedbC0U9uRT8288SB043rV2CWHxqG5DcsKEPc3B9OqW95pA35SDFIBRCoKvujE/QtpvZ3LCZGS3h7aGw4VoVj4e2XMnC8r8zs9wfSUPMmAvMSlRIHwe5JGvkjdv87gNCb3Yj4/exql65jLel9Ld2yXKtU6kzQmb5knIzNUfFacJ6G52LpXX2d9EbA2Eq70hotChFuOl+S7GJ3tbxJ4Y6r9OuLHI6Rol13LCyqIKcGhV721g8vNyEtAlcZmrFmQcayMMZxg3AmnpEQnDHzdq5bAMkr7Yy7wqJg3/lunnlFSCAaNSiV1fQO1wUeu6rE35NhnGSWrg/MmZoEbsVfgeAGDKBgZzVQcBY7CbYnOM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(6666004)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(107886003)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/sMPbQPzEs1xGgMwfDUgwCekpMgvlU3YEHy+wQvgX28/73efokqeZFc/lW/S?=
 =?us-ascii?Q?eimU36fbKPpTElREHOBSXWFYqXyTwpXa3KGqQ0LrGioYvIIe0OIS0GoX5KGk?=
 =?us-ascii?Q?a/qIgOaKXr23DI1QxRZFH9eDMUxNsdGwBh8r1jBNIBp83Ww78dDs28yni/cm?=
 =?us-ascii?Q?5PgAQwd3SjSdOpN9D4mqx4iKRdkN5l0NOdq1DfSU1WjuECtKMkHExjQNeIaq?=
 =?us-ascii?Q?yz2r5cpg2DHiWk+oRhqMOixb7ymHRWgdi41nihR8SN7coKwyAcxP+82Ru6tw?=
 =?us-ascii?Q?CNxe15gveCPwg8x9DmSaPTJ06AoR230EDKTZu8uMxJfRlaBc4oaqNGflHdpK?=
 =?us-ascii?Q?MnlxlS81UyBkg50V22MMYsELsHFtnsAh+tfy2y9h3i+EI8RVCabz9jS4rb3l?=
 =?us-ascii?Q?+f+Tc2mo+q4Z55tm0Fn74jiiC/7kBzYVMvUyentfLVAWOYDKlbTtJH356hZo?=
 =?us-ascii?Q?pC8tOw+Sa11crr4Acwuzqfky2BuHEas8aGUxFnHwaag7g3kRInzzBWc9OCGy?=
 =?us-ascii?Q?8Iyo05dRzbUSNbwYY1kqsc19rch4atITs/lMHYyVsO6bb8O16aExrq6LuFUo?=
 =?us-ascii?Q?8qMisQCYk5imXaKThblxV+cj+H2/M7PcLmT805VyaVEc/nmkKD36odxg75FM?=
 =?us-ascii?Q?BpK9Unhb4HlPcl/dRtuWK0TrpWNrT+3xoNyqPrPHOO0i0uTYvqq5t8H85ZlL?=
 =?us-ascii?Q?2KdfLdUk7HfALZU7RrwDmx92DzyhM7hR39CFKe2iXa+WYK3gbnpbg6wJVQTN?=
 =?us-ascii?Q?l7fZWI1tg5Zffk5nJrAH7FJeDAAH+yMg60Z1kTgzHbSCEXvUNb45OqQPkUiL?=
 =?us-ascii?Q?iMI78wbXVtcnLmeGFPNzWcqohlJtEblsDgv2WI+b4CoU4NZB7i8l+Eu/nzhd?=
 =?us-ascii?Q?W5KmdWv7Qld2UwVVbIqCkAbZPC34ZrsZFPVAHejspTqbZbe0Wu1nruhDdtMD?=
 =?us-ascii?Q?TDbeebivjp2qLnTVZsyIDTn0d6DVJndE/isVKVPcifp+kYRLbAVZa4lueypv?=
 =?us-ascii?Q?cV4blL0/BhmE6+z0Mbf2Joa2R2OkUjFkFUDzpMOxQivhEzk8Jtm3g7Btm2Sm?=
 =?us-ascii?Q?jrDMXlS/uiC/+64f/P3RiJIxQ/IZ2jOkbRvQeubvB8pxDAnUiEr0YKG/I97I?=
 =?us-ascii?Q?7KxBIJUTNdn/0prjsRU+3x8xs9mMqIOW18Y91UyrMe/zdGuUObXtfs5z+Y9c?=
 =?us-ascii?Q?KoXbDRS+ksQFYzHJlGNdY3fOjHbPMErPwuA6M6Z2x8X2YL5ThEqbYzF0oB/K?=
 =?us-ascii?Q?T0nMA/+C3c6h6Ti2FUsxshX0u6pATKlB7oNWeAAttSpbbG+wib91BlmxL4jM?=
 =?us-ascii?Q?vID4qq8DFL9jRd7As88glKpIHwnflcCbwW9XxjYqkDJYf4H6yXY4CZ2CneY5?=
 =?us-ascii?Q?XYZG9Dgs++iDNGfnXUHcRPU+6cXf8LKoasU9wcVXfOPPtYSTDZ0a9tgScKB5?=
 =?us-ascii?Q?3g461pDGqtOzWjtTSMvkompdaKn2bceM+S8hbQ5d46MBXY1wBfHPKfBKVezM?=
 =?us-ascii?Q?wn0MV2WcqSPQpJn6BEvIqqK3N6Vr8xtbAIWQ6i6+cTvDc67sqJkWmN9Hb1kl?=
 =?us-ascii?Q?swE/f3mpOxuZ3v4agxNRwJIDUYCg7dSBDgulQrex?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618b3db9-b024-4e03-b99c-08dc026cc020
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:35:28.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wit0tarhBKq9onkCt37zVnvS5G9OaDdQQ8EnBKsp1Arbv7218ClAuQG8uFChuoifk/UvbnlWOfuw9S9F8t3gjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to perform
direct data placement. This is achieved by creating a NIC HW mapping
between the CCID (command capsule ID) to the set of buffers that compose
the request. The registration is implemented via MKEY for which we do
fast/async mapping using KLM UMR WQE.

The buffer registration takes place when the ULP calls the ddp_setup op
which is done before they send their corresponding request to the other
side (e.g nvmf target). We don't wait for the completion of the
registration before returning back to the ulp. The reason being that
the HW mapping should be in place fast enough vs the RTT it would take
for the request to be responded. If this doesn't happen, some IO may not
be ddp-offloaded, but that doesn't stop the overall offloading session.

When the offloading HW gets out of sync with the protocol session, a
hardware/software handshake takes place to resync. The ddp_resync op is the
part of the handshake where the SW confirms to the HW that a indeed they
identified correctly a PDU header at a certain TCP sequence number. This
allows the HW to resume the offload.

The 1st part of the handshake is when the HW identifies such sequence
number in an arriving packet. A special mark is made on the completion
(cqe) and then the mlx5 driver invokes the ddp resync_request callback
advertised by the ULP in the ddp context - this is in downstream patch.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 146 +++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 56969fe337e7..8644021b8996 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -684,19 +684,156 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	mlx5e_nvmeotcp_put_queue(queue);
 }
 
+static bool
+mlx5e_nvmeotcp_validate_small_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, chunk_size = 0;
+
+	for (i = 1; i < sg_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size - 1;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (sg_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_big_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, j, last_elem, window_idx, window_size = MAX_SKB_FRAGS - 1;
+	int chunk_size = 0;
+
+	last_elem = sg_len - window_size;
+	window_idx = window_size;
+
+	for (j = 1; j < window_size; j++)
+		chunk_size += sg_dma_len(&sg[j]);
+
+	for (i = 1; i <= last_elem; i++, window_idx++) {
+		chunk_size += sg_dma_len(&sg[window_idx]);
+		if (chunk_size < mtu - 1)
+			return false;
+
+		chunk_size -= sg_dma_len(&sg[i]);
+	}
+
+	return true;
+}
+
+/* This function makes sure that the middle/suffix of a PDU SGL meets the
+ * restriction of MAX_SKB_FRAGS. There are two cases here:
+ * 1. sg_len < MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from the first SG element + the rest of the SGL and the remaining
+ * space of the packet will be scattered to the WQE and will be pointed by
+ * SKB frags.
+ * 2. sg_len => MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from middle SG element + 15 continuous SG elements + one byte
+ * from a sequential SG element or the rest of the packet.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int ret;
+
+	if (sg_len < MAX_SKB_FRAGS)
+		ret = mlx5e_nvmeotcp_validate_small_sgl_suffix(sg, sg_len, mtu);
+	else
+		ret = mlx5e_nvmeotcp_validate_big_sgl_suffix(sg, sg_len, mtu);
+
+	return ret;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_sgl_prefix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, tmp_len, chunk_size = 0;
+
+	tmp_len = min_t(int, sg_len, MAX_SKB_FRAGS);
+
+	for (i = 0; i < tmp_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (tmp_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+/* This function is responsible to ensure that a PDU could be offloaded.
+ * PDU is offloaded by building a non-linear SKB such that each SGL element is
+ * placed in frag, thus this function should ensure that all packets that
+ * represent part of the PDU won't exaggerate from MAX_SKB_FRAGS SGL.
+ * In addition NVMEoTCP offload has one PDU offload for packet restriction.
+ * Packet could start with a new PDU and then we should check that the prefix
+ * of the PDU meets the requirement or a packet can start in the middle of SG
+ * element and then we should check that the suffix of PDU meets the requirement.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int max_hole_frags;
+
+	max_hole_frags = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	if (sg_len + max_hole_frags <= MAX_SKB_FRAGS)
+		return true;
+
+	if (!mlx5e_nvmeotcp_validate_sgl_prefix(sg, sg_len, mtu) ||
+	    !mlx5e_nvmeotcp_validate_sgl_suffix(sg, sg_len, mtu))
+		return false;
+
+	return true;
+}
+
 static int
 mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (count <= 0)
+		return -EINVAL;
 
-	/* Placeholder - map_sg and initializing the count */
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < count; i++)
+		size += sg_dma_len(&sg[i]);
+
+	nvqt = &queue->ccid_table[ddp->command_id];
+	nvqt->size = size;
+	nvqt->ddp = ddp;
+	nvqt->sgl = sg;
+	nvqt->ccid_gen++;
+	nvqt->sgl_length = count;
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
 
-	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
@@ -719,6 +856,11 @@ static void
 mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 struct mlx5e_nvmeotcp_queue *
-- 
2.34.1


