Return-Path: <netdev+bounces-186986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F1AA4632
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8824C9A752E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F0121C173;
	Wed, 30 Apr 2025 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ig0pSHD3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DC21C17B
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003571; cv=fail; b=BiE2fvNRSGtgFwOVlBAOB79TX6mW7oM9oKVAopeY9ItwQ8DjE8eLgRMtL2/6+FksvUMqhr39bGExAHVJyG5lL5rGldAcT2aWXivVYYWcUjr++2hLFTsGkdrkG8Q6ntPeiAwuctLeyo7MjKhjFddumSDvvw6lwFQJGSiFmm8K59c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003571; c=relaxed/simple;
	bh=byzuBuirCtWZSVmwaDt0e+Fpf/8lN9p1Jv3aDvSsA2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5drlbErDvh4Tgx2/vgSMzzryyCx/uOmzwcmETJleFarFRpmeYT3XGxJP9MKIdfOt6mWjkeLGHtiopGQwLM5Fu5kKuQHlsPBtFyH0/s4vtBcd97FKgL0qHiwK9WuKG+QtCNgh6YRrPTdxfLyACRnCYy8k/2jY+jmgpac+wg061w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ig0pSHD3; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZtcsHFVPfT3/zXsLbZmTfEsRHejljw02XDN5novYSDXoaSYli5Cw1OzaSv94XxAws02lNCC4z2T60qUlw2yVdqUKEsaqBkxrluVsgafAwsD6bQ2Lh+sUQkrdkj4ZLCh6eN9OT4RFE60Tam6p0l3i7qKgeykN7/IGY8MQJrrOSS6uQ3nikKFeFxv9C1E7xcPGbEpvzUorIdmURO1Dx8ewLNvtUVeEdgbLNBov5Rg+0BSH/D5oNdasn+EaBgpvBhAPdvxBgmTbA674CZjdH3Rde0stnLCSMA8SLe+QYQptGA8A2thR+fblDFnWpSXGKL4/wPIV2XNxfIHEPU/Bnd0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcLhsVBgnowy/8RRFGPRZ0m2eHInYlKcsKKPmclk6Wo=;
 b=quazVBD23T3JUCToXbWR2TwP8pxI4TPdNqOdIStI9/JGYWpLmUTvheE1i20rl4tcCWKErX/A9BkdZ/UuLMtjLnaaiH6Lfcf4rOhPRQZKNJSQaYSPvfr78Aeqp1o8MVpg3RCjXc/KtccKKeg8mvOjp7hsBRa3OdCm8NxVv++zWYz1bNN9SBsKYVHCwKpmwBEf3u+ungShkViO6ibJ9DhGaqqzkOoszxbFEmNYc4floyBK6JqlEH9UzLERCq3CK4pCscoAsjMD9rOTcAUGQWD1r4O0oheDS1Mqhfu6+ZyWvNzpavC9xE1ijuj9nBnVtQnFUZQ4A+LatNDVdt6jVvL66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcLhsVBgnowy/8RRFGPRZ0m2eHInYlKcsKKPmclk6Wo=;
 b=Ig0pSHD3pj+zu64yjGGYkV3U3Z4SiyqLM40fpZdhftNZqN7xNcMXAl7kPewtgwhZQ7xHgFDie3JJrLfjmfLr7tDfljW7XGVPs5v+KIRI5/svj6ZcKsY7zpxwl0TQoB1X+FCbqaZmx1Tin5Opln8jvDTHW4x3XXaUjFJt0iSoXjYvjR9ycwwVlMyI/EcX/HnFJ2bo+YYbEKcB02GLr9OyOyPm29kS2ggAKhdJYa6cxGH7PmgqIx9YLLLBy1eh6gGzr/a885Qa5sZp6GvwatN/Q8Y+qDeoZ0QVpIBLkrD7w3QmAekucJ8rTkFBmYBfoF79xuqfvTzA6iGhdKhoWmK/3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:59:23 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:59:23 +0000
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
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v28 19/20] net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload
Date: Wed, 30 Apr 2025 08:57:40 +0000
Message-Id: <20250430085741.5108-20-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee1c25e-be6f-48a3-80bb-08dd87c54d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BCKF692Z1nMkKjyH9QBK8JsOTPsRCm8ES9DSp5FsrHjrC3l6zgtr9AyFe0KQ?=
 =?us-ascii?Q?jEwXu8gcIgV34RzbxIftOwYzBC2EdUWGPZnITSD6efLnW/89eippku83qk5F?=
 =?us-ascii?Q?OzR4YLKbxGGFEW2xlm/sdY1xQT+1to2HbuOZ0o25nprbqKanVcwK6ThMhKLh?=
 =?us-ascii?Q?V7eB4/aDgnMe/OQRI4XF6BCHvwPYXjXP5zJg19ROviGcxDoUDCPNwkK4zRWb?=
 =?us-ascii?Q?t0iXZNbcZ3d1aZWJLx0xWsqS6lw5HFjyi87I9n+qrw8dPt16+/Aw0exagVfY?=
 =?us-ascii?Q?Hlgkge3GNARAXCT+HGANIdR2bJcllNiEo/4u9qyqz+UfwpBC+jFJqIKoWQgO?=
 =?us-ascii?Q?Ms+nHh3aGr8OLhNVaEVmsGJcK5ogS3WrfYvskLylorWrnrj11zLBUf0HJExn?=
 =?us-ascii?Q?18/9JJVtds2fJNBcOk6CjLoYF+7YmfMIrJUPOepPSkgNG3npEGf+o+EBEdfo?=
 =?us-ascii?Q?qsbhtbMuBVCa8LPdI4rmcKWJ+Akg34HEWeM8kHiifDIr6tUIdLHX/2LrThcj?=
 =?us-ascii?Q?dSAnKI1/9L14flmjDOnZkHpXNXYd9dg4mh67DfAyCWVLESmM+kuPk57bvdDM?=
 =?us-ascii?Q?cnyuc1rpGrYOiTFBdh0YjcBBNjO0ALt2Sz0dN5aEYqkTlWXTV9DAyvqtEXB0?=
 =?us-ascii?Q?i2FzcLjsgGCqebY3YnI+SlKMoClr5afocb7RjS3Cwnu4hWcv16u9VbFL5gGE?=
 =?us-ascii?Q?+PwfoW6qZPwVCWGbJYVIkMdm26jELgwSwEmsUrSdrZHolPrIqC85pOntZHJ3?=
 =?us-ascii?Q?hfg0Gejq1jmKcd2ZYWbKRPGbLPRpelXTn8VFao+emGziwR9Wmt774RqqQhy7?=
 =?us-ascii?Q?ua3CCtUqt5yIy4hLHDfnyQ1v86T5JpRrXCLXWz5LZPS6i1unWl+DHzv/BD4i?=
 =?us-ascii?Q?9Wap0WZ8tnXDwC9q2DOpsOtZNhA8Qkm4DWv8Y4ODesM2SDJX6l1eGvt4A+fs?=
 =?us-ascii?Q?GLrz+np5t6DXW5rS4+8Povb4UhdHQA6H9HGRgicBDhxi/1CuPM+YfH2ZvQ0s?=
 =?us-ascii?Q?dZlZks17Liy2JuQnsGIkh6retDs+GYinY0e7HvARj5yJqGX+aUQ3a12GKB6K?=
 =?us-ascii?Q?sXMxXkL+UCWgBWEzbzLxmpCURJWMRqFOgonegJuLQAgKg5Ih9201F0CuRaKB?=
 =?us-ascii?Q?rjGzpkhm3GZmw19hkdjhsM1fgIMtODSvS4ufUjQha6C3fC8IBaFyoputajDI?=
 =?us-ascii?Q?WmgrLy6/zFcGo7r7LGq9JkeTlgS/zwXuWFFD/eFmn5ceupNjOY/WISrgoTIm?=
 =?us-ascii?Q?+Uq6rmw5E2/BssD7cmSdiUoA8amphXlB22ePOasUHnDKGwe/uFicrry5mL+r?=
 =?us-ascii?Q?eX1kbafDri0PIQac/N92bzwqQkKawofrRlnUI9VGv31wdl5zaDE8OVJCN2zq?=
 =?us-ascii?Q?41FKBgJdWwOvu1SuwCfAbUSrbSkSe5O3FMT+YLBebmTo4W8YbHTd6l3hJJL4?=
 =?us-ascii?Q?Q616yXkC8jE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bnN29OB3QY/q5PPoS17DKOb/e7Nj6nNIuYuwjswhdnZUEipzl5OAKyPgYZzH?=
 =?us-ascii?Q?X8UyP6EWTRwpqU3RnMvUtIO8pE03/t2VYJ9EBEKHTWRw/wboNZtfo18a44go?=
 =?us-ascii?Q?DcmXQdVZ8eQqcZ2MIyJf3r9zkD6mmby1SHT7NXlmgmULyVwCrzDrM/immd2j?=
 =?us-ascii?Q?iSeYnX+TtxLOfFA/UxoJrOB3X2vjmNxXPNgyPmGa0ZpVnL8b1ykRTzSKCGhP?=
 =?us-ascii?Q?DJdmywXPeaQkmc77PnVblAr3ZQYUPS/iozRP3rj3EHDTtH8IGF3Y60Xi5lFC?=
 =?us-ascii?Q?7wXloALpZVHHADl/h2NxdOVDaCUnsbCYg64bTjiFHZHg9XiDrAwcMauyArGO?=
 =?us-ascii?Q?mCCDN+9J03lXWFiW/+3nv1pQ67x1FbcciSOeRzzKBBFqUcFBqmE6N3ZGouZs?=
 =?us-ascii?Q?1ipPB+klZOiAhfYhWAYpLQ739WW9NApuhgnc4hEgsTZyeCYVUEw8JdDG+Dwy?=
 =?us-ascii?Q?WTbEuuS+GGtpz8IKvtVh+jQwbaieb3yFGsLVKECJ8GVweTu23STyqT8kY3mx?=
 =?us-ascii?Q?C99HphxpjS2yVM3Cv3BNyz/m4ax6hA+0DgU4Cvj0+5lodL+dqLkgIicH4Wnq?=
 =?us-ascii?Q?vJuZiLTUqmCvwT3HHcbekz9U+Hr3tik6UxT7zQDNvbHUrA5Tput7YqQBN7aP?=
 =?us-ascii?Q?xwhRPPaLJRNRxdtBc/eDjHBd5BL9ddc2O4aYyOFe9d7m0I6qvXboOkiQo9hh?=
 =?us-ascii?Q?aEVxDe7iJEuGERywhQEypMWLaek1Re/JKgRyS+g2BvWOlUeUgNtFcuj84jcP?=
 =?us-ascii?Q?Fh4eCb01B3geWB9gQ1Zn/Y67c4ELX9kboDIO8FOdExxCyelcemWdogT1ICUV?=
 =?us-ascii?Q?glWGAR+C/bp2MaYA9NsSRyD8KrrU1hN/XN+65I7eQknkaqCH22I/ylvb0Bt3?=
 =?us-ascii?Q?S0umYV1HY9wekIjx3XFfk45yVc04Kvr7bzPDr4I/TUUfgVTrvcS9Azq98kZt?=
 =?us-ascii?Q?wiWDeQxus4L19+trNK/2zWkOnnQdpv1Nhifkx9F41MmMNBa/PO5VkUiPZM0l?=
 =?us-ascii?Q?B6jpMYr0B1Ygtb3D4N6IfUsVwrRuj7t6KYLo5yk1RuxgBrcoIhFXTPJgKRYs?=
 =?us-ascii?Q?yRnV8x5SnoyQMnNos98IlslUHyME5VNcLB8yQzQ6qC9jkB6EcpFfUE1kXyxT?=
 =?us-ascii?Q?6gunW6QkUcLKeaRs6eZ3FFQmyv6JswtL2DadE6XGVTk/tDLTFIAjUBqnkdeS?=
 =?us-ascii?Q?fqkTIMR07sJYEbLdA9d1/5wpq5xRqnnMhRMBKiNUoN/9AHn/VjCj1OyHHvw+?=
 =?us-ascii?Q?YLWODnYbsFzlbVKH2jtNd1WKbQiuR/Za8iya2kxOIz+UjE3wl8hCO+/d67xm?=
 =?us-ascii?Q?2UwTtbUhd+HeB6NNCNubweZ80w6TVAy8P83O7mBBGzlZft+hKjJRnpejKc9u?=
 =?us-ascii?Q?KqdSMx+QNkyT/es2YL0JmpjYrgosUZM/CX+qei52WKcNpV7N/+r3Qwd2HISl?=
 =?us-ascii?Q?zZani4EaqXEB/HhuJeiNQFqDzdeoW/6bN+RHJtAnRFZPtTzEc98QWAIJjwPy?=
 =?us-ascii?Q?67/yQ1/9TPUF6HJfmX7naHMKsxw412Yh7wGUbJ3MZgiqs/NFKsc5hwL5acyL?=
 =?us-ascii?Q?zDCwvOEduCYJydjZPNFHNvCxhMdb1hv+R4neGFXg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee1c25e-be6f-48a3-80bb-08dd87c54d96
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:59:23.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYMJrSJl7Np8ScNSLgt+mX5bgknXj6PXwOmHGrKA+U1EKxAYdicGK/u3wQPVlpK/5tzPz7dk6ERywSxuIK7z2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

From: Ben Ben-Ishay <benishay@nvidia.com>

This patch implements the data-path for direct data placement (DDP)
and DDGST offloads. NVMEoTCP DDP constructs an SKB from each CQE, while
pointing at NVME destination buffers. In turn, this enables the offload,
as the NVMe-TCP layer will skip the copy when src == dst.

Additionally, this patch adds support for DDGST (CRC32) offload.
HW will report DDGST offload only if it has not encountered an error
in the received packet. We pass this indication in skb->ulp_crc
up the stack to NVMe-TCP to skip computing the DDGST if all
corresponding SKBs were verified by HW.

This patch also handles context resynchronization requests made by
NIC HW. The resync request is passed to the NVMe-TCP layer
to be handled at a later point in time.

Finally, we also use the skb->no_condense bit to avoid skb_condense.
This is critical as every SKB that uses DDP has a hole that fits
perfectly with skb_condense's policy, but filling this hole is
counter-productive as the data there already resides in its
destination buffer.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   6 +
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 359 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |  39 ++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  46 ++-
 5 files changed, 437 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 7e01096bdde0..c661d46cd520 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,7 +110,7 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
 
 #
 # SW Steering
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index b9264a7fe587..12770cef4560 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -595,4 +595,10 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
 
 	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
 }
+
+static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
+{
+	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
+}
+
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
new file mode 100644
index 000000000000..2b7f0bf7270c
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include <linux/skbuff_ref.h>
+#include "en_accel/nvmeotcp_rxtx.h"
+#include <linux/mlx5/mlx5_ifc.h>
+#include "en/txrx.h"
+
+#define MLX5E_TC_FLOW_ID_MASK  0x00ffffff
+
+static struct mlx5e_frag_page *mlx5e_get_frag(struct mlx5e_rq *rq,
+					      struct mlx5_cqe64 *cqe)
+{
+	struct mlx5e_frag_page *fp;
+
+	if (rq->wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ) {
+		u16 wqe_id         = be16_to_cpu(cqe->wqe_id);
+		u16 stride_ix      = mpwrq_get_cqe_stride_index(cqe);
+		u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
+		u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+		struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, wqe_id);
+		union mlx5e_alloc_units *au = &wi->alloc_units;
+
+		fp = &au->frag_pages[page_idx];
+	} else {
+		/* Legacy */
+		struct mlx5_wq_cyc *wq = &rq->wqe.wq;
+		u16 ci = mlx5_wq_cyc_ctr2ix(wq, be16_to_cpu(cqe->wqe_counter));
+		struct mlx5e_wqe_frag_info *wi = get_frag(rq, ci);
+
+		fp = wi->frag_page;
+	}
+
+	return fp;
+}
+
+static void nvmeotcp_update_resync(struct mlx5e_nvmeotcp_queue *queue,
+				   struct mlx5e_cqe128 *cqe128)
+{
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+	u32 seq;
+
+	seq = be32_to_cpu(cqe128->resync_tcp_sn);
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->resync_request)
+		ulp_ops->resync_request(queue->sk, seq, ULP_DDP_RESYNC_PENDING);
+}
+
+static void mlx5e_nvmeotcp_advance_sgl_iter(struct mlx5e_nvmeotcp_queue *queue)
+{
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+
+	nqe = &queue->ccid_table[queue->ccid];
+	queue->ccoff += nqe->sgl[queue->ccsglidx].length;
+	queue->ccoff_inner = 0;
+	queue->ccsglidx++;
+}
+
+static void
+mlx5e_nvmeotcp_add_skb_frag(struct net_device *netdev, struct sk_buff *skb,
+			    struct mlx5e_nvmeotcp_queue *queue,
+			    struct mlx5e_nvmeotcp_queue_entry *nqe, u32 fragsz)
+{
+	dma_sync_single_for_cpu(&netdev->dev,
+				nqe->sgl[queue->ccsglidx].offset +
+				queue->ccoff_inner,
+				fragsz, DMA_FROM_DEVICE);
+
+	page_ref_inc(compound_head(sg_page(&nqe->sgl[queue->ccsglidx])));
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			sg_page(&nqe->sgl[queue->ccsglidx]),
+			nqe->sgl[queue->ccsglidx].offset + queue->ccoff_inner,
+			fragsz,
+			fragsz);
+}
+
+static void
+mlx5_nvmeotcp_add_tail_nonlinear(struct sk_buff *skb, skb_frag_t *org_frags,
+				 int org_nr_frags, int frag_index)
+{
+	while (org_nr_frags != frag_index) {
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				skb_frag_page(&org_frags[frag_index]),
+				skb_frag_off(&org_frags[frag_index]),
+				skb_frag_size(&org_frags[frag_index]),
+				skb_frag_size(&org_frags[frag_index]));
+		frag_index++;
+	}
+}
+
+static void
+mlx5_nvmeotcp_add_tail(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
+		       struct mlx5e_nvmeotcp_queue *queue, struct sk_buff *skb,
+		       int offset, int len)
+{
+	struct mlx5e_frag_page *frag_page = mlx5e_get_frag(rq, cqe);
+
+	frag_page->frags++;
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			virt_to_page(skb->data), offset, len, len);
+}
+
+static void mlx5_nvmeotcp_trim_nonlinear(struct sk_buff *skb,
+					 skb_frag_t *org_frags,
+					 int *frag_index, int remaining)
+{
+	unsigned int frag_size;
+	int nr_frags;
+
+	/* skip @remaining bytes in frags */
+	*frag_index = 0;
+	while (remaining) {
+		frag_size = skb_frag_size(&skb_shinfo(skb)->frags[*frag_index]);
+		if (frag_size > remaining) {
+			skb_frag_off_add(&skb_shinfo(skb)->frags[*frag_index],
+					 remaining);
+			skb_frag_size_sub(&skb_shinfo(skb)->frags[*frag_index],
+					  remaining);
+			remaining = 0;
+		} else {
+			remaining -= frag_size;
+			skb_frag_unref(skb, *frag_index);
+			*frag_index += 1;
+		}
+	}
+
+	/* save original frags for the tail and unref */
+	nr_frags = skb_shinfo(skb)->nr_frags;
+	memcpy(&org_frags[*frag_index], &skb_shinfo(skb)->frags[*frag_index],
+	       (nr_frags - *frag_index) * sizeof(skb_frag_t));
+
+	/* remove frags from skb */
+	skb_shinfo(skb)->nr_frags = 0;
+	skb->len -= skb->data_len;
+	skb->truesize -= skb->data_len;
+	skb->data_len = 0;
+}
+
+static bool
+mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq,
+					struct sk_buff *skb,
+					struct mlx5_cqe64 *cqe,
+					u32 cqe_bcnt)
+{
+	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
+	struct net_device *netdev = rq->netdev;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+	skb_frag_t org_frags[MAX_SKB_FRAGS];
+	struct mlx5e_nvmeotcp_queue *queue;
+	int org_nr_frags, frag_index;
+	struct mlx5e_cqe128 *cqe128;
+	u32 queue_id;
+
+	queue_id = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
+	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
+	if (unlikely(!queue)) {
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	if (cqe_is_nvmeotcp_resync(cqe)) {
+		nvmeotcp_update_resync(queue, cqe128);
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* If a resync occurred in the previous cqe,
+	 * the current cqe.crcvalid bit may not be valid,
+	 * so we will treat it as 0
+	 */
+	if (unlikely(queue->after_resync_cqe) &&
+	    cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	skb->no_condense = cqe_is_nvmeotcp_zc(cqe);
+	if (!cqe_is_nvmeotcp_zc(cqe)) {
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* cc ddp from cqe */
+	ccid	= be16_to_cpu(cqe128->ccid);
+	ccoff	= be32_to_cpu(cqe128->ccoff);
+	cclen	= be16_to_cpu(cqe128->cclen);
+	hlen	= be16_to_cpu(cqe128->hlen);
+
+	/* carve a hole in the skb for DDP data */
+	org_nr_frags = skb_shinfo(skb)->nr_frags;
+	mlx5_nvmeotcp_trim_nonlinear(skb, org_frags, &frag_index, cclen);
+	nqe = &queue->ccid_table[ccid];
+
+	/* packet starts new ccid? */
+	if (queue->ccid != ccid || queue->ccid_gen != nqe->ccid_gen) {
+		queue->ccid = ccid;
+		queue->ccoff = 0;
+		queue->ccoff_inner = 0;
+		queue->ccsglidx = 0;
+		queue->ccid_gen = nqe->ccid_gen;
+	}
+
+	/* skip inside cc until the ccoff in the cqe */
+	while (queue->ccoff + queue->ccoff_inner < ccoff) {
+		remaining = nqe->sgl[queue->ccsglidx].length -
+			queue->ccoff_inner;
+		fragsz = min_t(off_t, remaining,
+			       ccoff - (queue->ccoff + queue->ccoff_inner));
+
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	/* adjust the skb according to the cqe cc */
+	while (to_copy < cclen) {
+		remaining = nqe->sgl[queue->ccsglidx].length -
+			queue->ccoff_inner;
+		fragsz = min_t(int, remaining, cclen - to_copy);
+
+		mlx5e_nvmeotcp_add_skb_frag(netdev, skb, queue, nqe, fragsz);
+		to_copy += fragsz;
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	if (cqe_bcnt > hlen + cclen) {
+		remaining = cqe_bcnt - hlen - cclen;
+		mlx5_nvmeotcp_add_tail_nonlinear(skb, org_frags,
+						 org_nr_frags,
+						 frag_index);
+	}
+
+	mlx5e_nvmeotcp_put_queue(queue);
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
+				     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
+	struct net_device *netdev = rq->netdev;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5e_cqe128 *cqe128;
+	u32 queue_id;
+
+	queue_id = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
+	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
+	if (unlikely(!queue)) {
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	if (cqe_is_nvmeotcp_resync(cqe)) {
+		nvmeotcp_update_resync(queue, cqe128);
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* If a resync occurred in the previous cqe,
+	 * the current cqe.crcvalid bit may not be valid,
+	 * so we will treat it as 0
+	 */
+	if (unlikely(queue->after_resync_cqe) &&
+	    cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	skb->no_condense = cqe_is_nvmeotcp_zc(cqe);
+	if (!cqe_is_nvmeotcp_zc(cqe)) {
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* cc ddp from cqe */
+	ccid	= be16_to_cpu(cqe128->ccid);
+	ccoff	= be32_to_cpu(cqe128->ccoff);
+	cclen	= be16_to_cpu(cqe128->cclen);
+	hlen	= be16_to_cpu(cqe128->hlen);
+
+	/* carve a hole in the skb for DDP data */
+	skb_trim(skb, hlen);
+	nqe = &queue->ccid_table[ccid];
+
+	/* packet starts new ccid? */
+	if (queue->ccid != ccid || queue->ccid_gen != nqe->ccid_gen) {
+		queue->ccid = ccid;
+		queue->ccoff = 0;
+		queue->ccoff_inner = 0;
+		queue->ccsglidx = 0;
+		queue->ccid_gen = nqe->ccid_gen;
+	}
+
+	/* skip inside cc until the ccoff in the cqe */
+	while (queue->ccoff + queue->ccoff_inner < ccoff) {
+		remaining = nqe->sgl[queue->ccsglidx].length -
+			queue->ccoff_inner;
+		fragsz = min_t(off_t, remaining,
+			       ccoff - (queue->ccoff + queue->ccoff_inner));
+
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	/* adjust the skb according to the cqe cc */
+	while (to_copy < cclen) {
+		remaining = nqe->sgl[queue->ccsglidx].length -
+			queue->ccoff_inner;
+		fragsz = min_t(int, remaining, cclen - to_copy);
+
+		mlx5e_nvmeotcp_add_skb_frag(netdev, skb, queue, nqe, fragsz);
+		to_copy += fragsz;
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	if (cqe_bcnt > hlen + cclen) {
+		remaining = cqe_bcnt - hlen - cclen;
+		mlx5_nvmeotcp_add_tail(rq, cqe, queue, skb,
+				       offset_in_page(skb->data) +
+				       hlen + cclen, remaining);
+	}
+
+	mlx5e_nvmeotcp_put_queue(queue);
+	return true;
+}
+
+bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	if (skb->data_len)
+		return mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(rq, skb, cqe,
+							       cqe_bcnt);
+	else
+		return mlx5e_nvmeotcp_rebuild_rx_skb_linear(rq, skb, cqe,
+							    cqe_bcnt);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
new file mode 100644
index 000000000000..5f208cc10bfa
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_RXTX_H__
+#define __MLX5E_NVMEOTCP_RXTX_H__
+
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+
+#include <linux/skbuff.h>
+#include "en_accel/nvmeotcp.h"
+
+bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt);
+
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe,
+					    u32 cqe_bcnt)
+{
+	struct mlx5e_cqe128 *cqe128;
+
+	if (!cqe_is_nvmeotcp_zc(cqe))
+		return cqe_bcnt;
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	return be16_to_cpu(cqe128->hlen);
+}
+
+#else
+
+static inline bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{ return true; }
+
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe,
+					    u32 cqe_bcnt)
+{ return cqe_bcnt; }
+
+#endif /* CONFIG_MLX5_EN_NVMEOTCP */
+#endif /* __MLX5E_NVMEOTCP_RXTX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8af51d1886bd..95639d845757 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -53,7 +53,7 @@
 #include "en_accel/macsec.h"
 #include "en_accel/ipsec_rxtx.h"
 #include "en_accel/ktls_txrx.h"
-#include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_rxtx.h"
 #include "en/xdp.h"
 #include "en/xsk/rx.h"
 #include "en/health.h"
@@ -336,10 +336,6 @@ static inline void mlx5e_put_rx_frag(struct mlx5e_rq *rq,
 		mlx5e_page_release_fragmented(rq, frag->frag_page);
 }
 
-static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
-{
-	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
-}
 
 static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 			      u16 ix)
@@ -1560,7 +1556,7 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 
 #define MLX5E_CE_BIT_MASK 0x80
 
-static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
+static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      u32 cqe_bcnt,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
@@ -1571,6 +1567,14 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	skb->mac_len = ETH_HLEN;
 
+	if (IS_ENABLED(CONFIG_MLX5_EN_NVMEOTCP) && cqe_is_nvmeotcp(cqe)) {
+		bool ret = mlx5e_nvmeotcp_rebuild_rx_skb(rq, skb, cqe,
+							 cqe_bcnt);
+
+		if (unlikely(!ret))
+			return ret;
+	}
+
 	if (unlikely(get_cqe_tls_offload(cqe)))
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
@@ -1617,6 +1621,8 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	if (unlikely(mlx5e_skb_is_multicast(skb)))
 		stats->mcast_packets++;
+
+	return true;
 }
 
 static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
@@ -1638,7 +1644,7 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 	}
 }
 
-static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
+static inline bool mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 					 struct mlx5_cqe64 *cqe,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
@@ -1647,7 +1653,7 @@ static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 
 	stats->packets++;
 	stats->bytes += cqe_bcnt;
-	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
+	return mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
 }
 
 static inline
@@ -1861,7 +1867,8 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -1908,7 +1915,8 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (rep->vlan && skb_vlan_tag_present(skb))
 		skb_vlan_pop(skb);
@@ -1957,7 +1965,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	mlx5e_rep_tc_receive(cqe, rq, skb);
 
@@ -1997,13 +2006,19 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 	} while (data_bcnt);
 }
 
+static u16 mlx5e_get_headlen_hint(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	return min_t(u32, MLX5E_RX_MAX_HEAD,
+		     mlx5_nvmeotcp_get_headlen(cqe, cqe_bcnt));
+}
+
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
 				   u32 page_idx)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
-	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
+	u16 headlen = mlx5e_get_headlen_hint(cqe, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
@@ -2429,7 +2444,8 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -2762,7 +2778,9 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 	if (!skb)
 		goto wq_cyc_pop;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
+
 	skb_push(skb, ETH_HLEN);
 
 	mlx5_devlink_trap_report(rq->mdev, trap_id, skb,
-- 
2.34.1


