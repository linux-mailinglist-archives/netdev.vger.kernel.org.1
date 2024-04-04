Return-Path: <netdev+bounces-84868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE5898812
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E431F2489D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94ED762D0;
	Thu,  4 Apr 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VLaQqIHM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2137.outbound.protection.outlook.com [40.107.93.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD37492
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234347; cv=fail; b=C2p+qhfSlkg0vEf6mMrrW5kDIyvM1/ClUhpk2wJ6gtmw7BS5BB33qrjC/d8jmXRu9UYVsExHHkAvqKkfPOmi0IDlIFwG2bzeYwxEff5FoHK2zzhIVDqRdQrSrlHHoPbKuieoWECwsDxyLR6uPty4E6lVeJTTaYqAVM46FuRjLhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234347; c=relaxed/simple;
	bh=FKv7GPKQZsXFgAdp7jYAyJT8Rwt3+/GiNTWPK1BOZhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqMgy7WM6UZxiVKAJM+eOqQZkkwL3JZS/RfTuRP53s/kYaTeQpOcbbUDxqbnveqfL0bmMaPLpOxAr9MgnEqB+tHsmRnm00LMHV79+OrFG1ZxEzN6MTboecd+VMBAELhF38hHab0VKNGszUioEfj4EUVMq24l0SOTCJRvYsK0r1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VLaQqIHM; arc=fail smtp.client-ip=40.107.93.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is4OWXmlBQgwGlvJ1lhfHq6dTuXbY4bnRwRLa4DyeI94SanD5tN0Wn/poaQ1GHZzwY/xg3Jt4zYLnHTV/5fOSlknwB9s+ZJZUK5Sg33V8Kr9vwnLc2t7Iuv29qheBXJn4Q3J364Kr1VykEhp1yJ1+OVaN6RfEg73URXgRFL4NNomn3BazqgnIMOyBdZ8xOk4M+Myb6IB2rPPT0+Ni6Q0k8VwNqbNwp7v9fdPRiHLfrfPqxnRjZ8lR7E9vvNVoereH/Nc8F0UyVe6YNjXvm/sSuCZ+G/WWt402b0qweRZHxfsu3VKNCzCLpLkHz6ttY081Ya/8HCiPnQCwp+3+95SxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOuIvAX0fmh4HJYpI+e+nSxuVTHjgcsv5rjoVERVvsI=;
 b=PhYsfbn+PGfjyX5vbEug34LimqY0qGq9fds+w4SMuEbc+W+qkMOuFBsu/OrzUUuX8mqWkEeTt5DyezJlGBj923COxw5sGW5IoTCamdmcYG07paiM4T5405/UpT+0kzaksunu5+e8bbG76Dizq61j/QD8woO26TvHZgzquU0dfhg+7Rs3jUxxJQOieI+atGFvVZutoycZMfC/uKue21AbSmWlwJXdwgoMVcgfCIQ0gbuU9KXyrHy3QEOjjCqEkL9husg9HhDxBmlYj8ooKd28UnZ9JWtGFgJG6hLebGzXDcpcQDXH6F5gMjALUoVZRdyVF3wgSpk7U8QEfejzs6E0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOuIvAX0fmh4HJYpI+e+nSxuVTHjgcsv5rjoVERVvsI=;
 b=VLaQqIHM+zVwxg4rXucww3hIdqEQduvSNfLq57sH07yRJ+WPBAM1iG4Mfw7JZXqfbsfd8cDjmOQhbiJlil4+dRAyUuLftXQyF1IEvibAl2tShCYrlb4u9MAMkdgw4KykXcjw4lmup6yptx3SfvhLd/X1mpRQNoMsHJaE9mf1rJe5yMKr+VvilN96RDv8t7rbcPRm3vX4nWMMLp5Mcnvgp3nlclvfOkI1hEK73F+8oM4NaySyAToW6he1b4AxUMXkiSd31EfdLTn382ErSEax33xmOFtZOWNTCyFCszDPnS4SWiRrxPqfA7Gerb0TGf4hmjo4Ofqx1cpuZpj2VfkLKg==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:39:00 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:39:00 +0000
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
Subject: [PATCH v24 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Thu,  4 Apr 2024 12:37:14 +0000
Message-Id: <20240404123717.11857-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
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
	CG6rF/jHE+aKZv3gJqV2O1ZtYqrDne4t8CTukQLOGJPztSaxHb5Ol8+TWyvRnykQ89pcvYFKiEphCRFIVI181NU7IddoIt/TRRdZTQFuXRGilJbM8mBnKmghTOwLLwmgPpROjb3kSpYjIrUrXzoDFOpI6HeGH8G37K+gyOnQaObaO+XD6Dut9YNqRlSOOMoLhjrAr+/EPexGkL+fiFEFGtWGmBVm5Gzssa/5aoTokFNmyQYf1Gpe3bVrePf/CKdp/jOw4zx1c7dsfTL9i3Xrt3SmjpDnImUp85XeC764lPCotWoKYHycdXhwg5l8UfubVar6pkHOhUuC1lTrYC0Jn6/ghDVyMeQus5AM58vDKWwPNPamw1g/Nl/E1T+zp/9AlJnUcYHlm/+gX09KCFBMsVDLSO7P8/buKF+8IPILJznDZP6tQJhh2twtXcuAqAoh7qtNUL4w8mhg+Z97OsMdwi9nEkE0YzhykPiEAUYaFC4CVkA1N+ZtheG+xSo+pn1Al0mJ0btFM9+0kUkmuPI51NcW+fNfuPZrDRDB3evaTd7KXsafUnNGBYIe7IhYvTPpSycauEGWC/gSzP75R3GgjVtsZkgXMZE3OZKbNn2zM7yXk+xsHAx9om70zyTF2KW//6gqUyV+tlm1qqTprzqVtBotOqlfyHS2dt18EnhMkg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gq/9uzWx4rBRWKvHsifd/8gPO9Papph6Dc6vrtU/yQIoW8+nvsaJ/kAC7kOu?=
 =?us-ascii?Q?DtYbQFvP0GLuNDg3RaQdDUjmnO+MMoO0FRTboXDC31f7UZLOY+C2uOKHcKqM?=
 =?us-ascii?Q?zAlxJeKw1oLrqc+uCR5a/HrAFb1pvquXRgOsnPbHfJZooDzNjb00OmolfIQP?=
 =?us-ascii?Q?Sbp16IY7OTIS+JW/YQi58nA4L6Mch/J7GKy1x/ZUBBrE2OpCsTsEbRFuNKel?=
 =?us-ascii?Q?V8g+4ewUkXt/xAWe2CHSTsl10r2v7kAHuD0fT0y4RLVItJMuhCk9iLAxa6xQ?=
 =?us-ascii?Q?6vtIlWD8VtavswDxpUaoNfFNVFPeNWN8ULHDZtJueKlTWlY1pcZrz/OYNmjb?=
 =?us-ascii?Q?0Q5RI6CG89NmcGcpjsQKXnlTemIV8cKOdS0xrKMT1kn971bbNr3Y20oGPySC?=
 =?us-ascii?Q?zBfTZjuhQb+jwzt70bGBQo9c927mKgQx5Ynevnt7/TD2WsK23SVFTtLOz1+W?=
 =?us-ascii?Q?8320bPcbLLa3vhIF2TyQQY8bR2QJ2OYYZbVx6w9BAacOEgGyBlnfr4V3rISq?=
 =?us-ascii?Q?ZE9cXAxnuPxLmZVWGRBz9Ydslfs0rJrL5c0qIVddJ+YIMl0U1D4dF/ZcpyF9?=
 =?us-ascii?Q?Sf+f7iMmrkTsEv84MrsOLsY3FoB1XBGa4Ip2Fpo9aHwINIwUACrnB7Wjffga?=
 =?us-ascii?Q?xd9WMd/qlUZcNPiUMWWn/N94FDQL2iqjEb3SHTlhXdT77aqtbR2VWgGF5pOA?=
 =?us-ascii?Q?c05scrIlNsozTeVvGfrGUi+Lz5ldnGMtMDxcEToiUlxWN3DsRzurp4Jf2q6m?=
 =?us-ascii?Q?ihn7nnva7Y/cBipy+RXoVVc1iMORcjX+DXbzrTxGdKPX4G5Z1VLBPIUGsX9t?=
 =?us-ascii?Q?vKofLXJVfXc4qMVfcS8IgaHTrw9RFExaDogJ3LO/0W8i1nZboGNN9DTP/Vqc?=
 =?us-ascii?Q?vbgV8/NOy7NEc/VgOdDTuwSN1UIkCPp7arVW+1zXFeDsM5wbWmwR+qiViSPZ?=
 =?us-ascii?Q?hl7F52qHhGAl5+sDzur4mTTLRSiyC4QY2s4QblOJi6cdemCA67eRXnkMaHEZ?=
 =?us-ascii?Q?dxduwBPEcnw/tcwyjGV0Aupi7n5BcrsrFXh5DmuP2yIjEc6uFSNAqnC7marg?=
 =?us-ascii?Q?+U+J9/3Js7BUo3bq6dagYlvurKIe1vTEyds5/Tzly5CDOJALTq++Rf8ghwiX?=
 =?us-ascii?Q?ed15fTbQdJ/jR2MiLi+tQOaYTlCVYPmF8/CfKZLwFrFgc8beLpWQGVXyy3Ge?=
 =?us-ascii?Q?Sv/YuF2hdqXG9Q1iMtKjIf9QDrpap+hZEAqjiZILSYePZgEWPTi5l3csIXu/?=
 =?us-ascii?Q?AH8EpLQEsyOuSV46axDuUd069dgzhgCGnHse/nYDkxpRZnKZfcf9HPM8I3wv?=
 =?us-ascii?Q?3maJMH6a9qfW2NsDH0/Jey5zNWDGScK7mH57dfy+SqOWvUquHokiJVgJvRUo?=
 =?us-ascii?Q?qoNvvpZOxZFXSv1y5NgayAL0gmxoyQu901W7ACUrHsu3MTeZqFV2QRx6r5MW?=
 =?us-ascii?Q?F5lRH60ltwqyIML+BoeomXvkJVcRILbGL/Z1YwMkC12LV1O/gAZDZlbSuWt5?=
 =?us-ascii?Q?qtpFpbP+PHW/hbhIxiouCR5fygMEPKi8P+dNe7+f8UllXlrXE6kuKw3D9MbI?=
 =?us-ascii?Q?EKHvJ74jkboRqttfhNqfcrHWP2xSv2MFjJfRG1D1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a441eb79-6efe-4941-ddbf-08dc54a4340e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:39:00.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VflvP/cDsWn5OVc20AMAjdJ7viSH+/5UGFyHtNH/+IRwaRz5XctaJArmMb5uwA2UxEdvzqq+YHR3lEBjP2aGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

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
index 2878ac0b7355..d7b416f77c3f 100644
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


