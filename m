Return-Path: <netdev+bounces-43865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409157D5070
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E835B281C70
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CC82773A;
	Tue, 24 Oct 2023 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="REmJU54N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318ECC8EA
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:56:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10940DD
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE9bClYaGgZjVBMyZAGNadmsHGpNqxsj5qfZIFyeSOFEutd9PNXH1TR5N8y2LunGC0KeT9GxMKvIbOBLOdnTAphtaI86z9Ot4C3Et4V4bWUZp5raSzVu3Y7N+DP2dXM2ZrGq3/P+tZldPIHa31dTxd8PiOZ+0KWjsCrGU63eYLVvPfox8TjMURBPEo46PE9nvWjGrGJIFrnZHlmSMK5bywSo3tdfRqYwI+5sEVuxtut8jBE3aahw5kj6/MfNl1vsrJ0sWNhsPEzWdRb+K6LttpSdaedtejZL1HT/K9XYio8KVxmpJ6PgzQUYAm6G/MbCoL0OchYu73WwTMP4VzPG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7Q8CxWOyVaJjWFz5HSpLU+DiSVUzXdmyFq5NQ8Lios=;
 b=D8LJabllIW00M9tPMPoP26O/eOnK0wFWLEOrCDHzFA/uS2Qe2H9OuoXQ8A/s11Cj7aXc+t0+MPe6IWEKOD9qY5Qryeq5ENH+4JWhqRE3fsGkoXSbD/c4sMKUDvkSSevGLH3zw4Px3ZFCqn/KNIbi4diBmqei1hgE8Zn+pfWq6ALVta9NaXk7j/PG0kprEPHF34INmKcW8cGmuJolGMbSiCkvT0ys5gG38yFSkEQl4PYK7NSB0DAOdstXe6kZpfXU7j+G7sHXNLIXvw0bYWWVGj0G15lDzRCmpASH7D8o+u9g1kOCmYap708OP3OmOtU7FRcLtWkWymKSNIIDTVsFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7Q8CxWOyVaJjWFz5HSpLU+DiSVUzXdmyFq5NQ8Lios=;
 b=REmJU54NQ/isiAajSY+qHxMGcUssdsTW7z6BmH3+crksPoVFtvQkT22BW/4usBBUpbq8ZP66zx9k0BSOLqstPxPx/0VZVT2vcUZVwt6KZxc1RhRJ5s6HwP4ZbsTiB/ovahnbhMHG9bV+TFBx8rYyPQC6UnFX/AIdJHjAbxJRYnpeacz8kGaIkPE3dKjzk6FRk/Dxw766/QIxjfGPLw4dCp6rOk9HycohNTgiKRzfrmUzj6WuiKj0Alb46S8CDqp2X1FQY1l9oCKmVlMU5ODp0FMFDi1yyFycCRgkCCuGkdJVeqMMSzeiRgUAAV/gcyITo58iPIGUEobCfmO7ygefhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:56:24 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:56:24 +0000
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
Subject: [PATCH v17 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Tue, 24 Oct 2023 12:54:42 +0000
Message-Id: <20231024125445.2632-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0424.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: f33eb021-4d12-4808-71a2-08dbd490a0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CL9PpsK5VdS05kaC5T9vutAybWzVT/dalfGrHaWT16PQQIee/+P6P0Af4KobTWHeVwYqFFmeC4nr13N7V7TTWAsrKCuqS7G9TlyBCFB4yxi9o4AlYpA5+v9wFbxp+QdKGTcxMP37NkpqO3Wzn4WxIrysBfAK6mAjTOhQr4WjfzP16nD+3OUvu6UiWrmERxkUYelQaqTLZXstBTxaMBrfg2CUdJEPKPnzQEbckoJeff8AgHqtCkixyuQngEzQbGBUMuKtLvTt0lR5mDoxQm17+MNIbfV8ahpk7SOo1OKl8+VQNAhkUoEkhqGV86IvFBkgpy3EJQtxJryFtYq/7LgrWPMDA5w3pI+UhxuHf37HyKSS+Muml3SlZtiWj0U8OcPpXnoeVsIgIj6Jbm83ctzeZw93CQUa9mqgCYl+gYuP4O9EAsA2+KuAOKCubuQmb/glxi5VtZ8lMEF8BOfv/6+5VycvXebzlWCvhPeeTX1hF75ExmUPch4FVALyxTQcFgrnBic8OOTc0la97fKkhB02bCdcXwfV1u7pvwqV04SAovnw3riFhZRKey6kCfEeg8Xe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(107886003)(2616005)(6512007)(6666004)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x6sNlCF8i8x4Q9wwEM6o3lZ15HqhRaw/x5Lk222WaAGpahqLSqD1gwmaru3A?=
 =?us-ascii?Q?3LWUve4w96jvFKmq1xgosmXMVBYo2t9m8tblAl5uBSzg0EJYnl/zFBDE/dze?=
 =?us-ascii?Q?Iafb3ULSgAWXXv3X1/MEJpwTfHGp/RRmUa6M4SmFsGkgAE2SEHZOVR/61xtw?=
 =?us-ascii?Q?Koc8WtdpPNOVPnihT8dw7qhZVZ4BNcET9Dw24VAAmvbSAoVPJIyNhERMbChH?=
 =?us-ascii?Q?7Io6YBgcIwItv7QwIVeFW/xVW+7J6JkGIFkuXPe4ys8nVIW9dYykfFGthTdj?=
 =?us-ascii?Q?+nqejgZETw9MhToD+fZ+3I9wXoTl8QKi+4jGyaM70Pd8rOf/Mflgr947Q6Rn?=
 =?us-ascii?Q?iQsEe3SNDVmgaQt3fh+YboSBSOsQmouQ/vqkq+59dh9ZI/ie52H+4mqdqyit?=
 =?us-ascii?Q?x0dTOYPMAKuViMqk5VhuYCCM/uKF85ObxzghQgyooM+tytkziANCsQnBrtOA?=
 =?us-ascii?Q?GanzNEulw9o5dR193yK77VUBcYsr2NRZYRDvWGqmpqfxP5bLIfOKUUkv+Q9g?=
 =?us-ascii?Q?69XaAENQWxrFg7BrI+zTeawvv4/BDSKAGzJoXsDqd1O3M8KM9AkSk7B7gW0t?=
 =?us-ascii?Q?BxY41r/heIG5y4XxfOiFzZ0srTx3TKw19C1s+0uXG5OHEcDc21cDLUHbsixu?=
 =?us-ascii?Q?SnGq69Oakh/5CNNvQqZLiGRJKfvrLVr7GqHv+q6DKggGBEH+HIm+ocL+dzdr?=
 =?us-ascii?Q?3XOKEf/M2SLeZU/9EsWXkVfHGK7wMeGMv/VvWa8HAyt/I0DY9DtcXcngO316?=
 =?us-ascii?Q?J4vusemZ0G65aBqasHd8eyfqQmhQ/EWeQaDa3rELz9HqjxJb8oHdVDaSbeFC?=
 =?us-ascii?Q?8eNZf/pOqJX/6V7J9QfVZz4It4GkJjf/QTSII9yGYXbd08bNGHy5bIfJbQYA?=
 =?us-ascii?Q?FItjC5pH0IKx4a2fIPc+XYMLF/jqbPX3gP7w6VXokGf60+e2B8xZxk1zn06R?=
 =?us-ascii?Q?NU8Rhd+zPsjLEmkhpukryX3IxI0qayH2yaRFxikhFzARPb2uH39jueO2VcWl?=
 =?us-ascii?Q?jrbIkJRkpQ0onZLkNkB9gOboM7ioCxzhtzXpDZgpU0YJgSkXDLVCugubwOKE?=
 =?us-ascii?Q?bgiPJOXI69fqvVxgqBBa7BuQcxlrgRixn0nWqUdi8zYa8wOoZSrRtXbkMtzd?=
 =?us-ascii?Q?YGgcK7nBZplc7SIBuB6wAZ9TbKhxgU15ja/qRr0f3dSL56c+71AgFQohZDbf?=
 =?us-ascii?Q?pbTyXFvYlI2dFRZKr3MmGXogUGu0t/pOVxMsrsGFiqzkbYNUzEbygGGVD+V+?=
 =?us-ascii?Q?Ry2XqZYJ0WZn5/+ozf8qTzYKU39bQEcZLasBthPKaAsdg2OW4ABYKsOFqqpE?=
 =?us-ascii?Q?GKYE1EPF7kGO5eBOLJzJ5+p6Na7k88tv3tuXfZU5YH9xVRfgfIVENOh9PRCs?=
 =?us-ascii?Q?uGXPIWax43JQ2k2cbYemY5DHx/pURwGy/MJ3GXo4ZkWSn1iCxWNJ3L9IzUW/?=
 =?us-ascii?Q?nvLREr9ErOhIVwWKBj+LFOtuJ1BdRKYsBBM+zszcSN2+G4fwZlacpQGW3OOW?=
 =?us-ascii?Q?eSj4OqsFGvaP71pdrHntdp6CxqIOfSH6tvWe9LK/mYwejy4T8jPbkqIvNMJj?=
 =?us-ascii?Q?NPt8YYrzaSKb8VYlRFSj1kA+rC6vHiCj6/titq5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33eb021-4d12-4808-71a2-08dbd490a0e1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:56:24.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +slDoOWcNueesDubss24kNeekP6xHbSZgsUrxtmdlqZyH7nJ2Dmbxt+Iuoj4OfhNthr61bYJ34ciXPpVvePM0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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
index f419ec6ae3aa..ea7e4cc1bbed 100644
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


