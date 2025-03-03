Return-Path: <netdev+bounces-171164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C604BA4BB64
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB7F3B4D99
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C31F1908;
	Mon,  3 Mar 2025 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eosdQjGJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC71F1534
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995701; cv=fail; b=O5GLvaCSbTWEIzyneZe7fjiGxQiEeBq0R8FRj0lmcBpid8T0tDCsHA0CaEqvy0zTTrQ1PIDmBQklXLvA/mq8oUEFrT0VIJoPTIdGys1OT0gg84or+6veaUnkJiy0DCkmSBuCIaOyOunvjqQdWhr/1xGgjGK6JUHenZ4XhNEV4EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995701; c=relaxed/simple;
	bh=ReA6A86+2udGmChPsGXAHSaeki3v0kUBGIWcdecZri0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2a7WNjKHOgZpMV8eeR1kVmTTAC96Gxk6nhu/lje/C0jG5w7BkXX/abqaM8LgbZ334XIFaOPhvTV/whDBoeMVT2o+5ncbq/SSIbNOA3ZMX+IZTu3l7zJzcYD45xqnO1i94L/uoeLB+AYD2y5UTNgLZM4ywAFFEusuhyrclXpFf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eosdQjGJ; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bY7C3d2AlbxGFoenpe+Q3ZkM0OSSi5d3o0V08KFl8SdKxdI2pRDLSM6S05buI1bs0eJAbgHI68o801/Y066LqlFjmNLhnDTaHHKoCX4viHAFNEnGJBo5EzcrVdcK+ycaFB3SvqP/4A1oJmaR4Vy7Bakyx0a9YwFvN6Wg5pmd2xYFngyxoKkHLZOCRkUy0cTaDGlv/N5g9ei+QO83xLytc/SUS00NEEurO98lnCXKwO7LWlhxSJsLifNcP1QzeJHS4efKl/Z35uTkV7bMNGLtsSLguSNqv9sIc6Eqia1hXx7BP1zBiPPzcQWFABXFd/deDDdjGjOFFq2wDTuubzQRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2oD0ITQgogUL74KieWOo3bAvyTV3/Ro+2cFOTiiB6A=;
 b=RaaUmaIXwvL9NYvpNVlKnw3U3tK8bliFnxS7R0wNdzILnKMJEwiBYh2e2tVtG4jQSBItFS8msN60TipgZ1uB3vmPPknhHOjKUMDljE2FDV4kF/zoGGgHTmDctUW4y3tS+jAdcqaNA+qpau7bXLQZI1WyYI8fzsLHBm+LajRJGsQ0ubqy6PkjHgQPw+1pizGBBFUG+7kv6Sb2BAoKMs0WzzOxOO3utarRC79mAK5FqKXXnFuov0ydZ/Xqo340p9C25M5BM6lC0Zf6KjEYTBlRLTiDSr1OWu1ub/H6kXZww7hKDLopW4QHc3qjliTiGl4iYCmQu+VlvIWlGcS0hX+iqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2oD0ITQgogUL74KieWOo3bAvyTV3/Ro+2cFOTiiB6A=;
 b=eosdQjGJMpV9OXR7x2lRtgZsKszHNLZKlZsQ8kCEig3bq5TxFGVmcakvLCoMVB+34zxpuMquTW6KESSjC/fdw/CYsCpHIjCSVEcDJI+tsbzUaBdLWhQFDwJXBsFCpQKOnbg9mg2OMKLXlRHbcujjmLUTLsD37tyTSzj0ZS6RbHsUAroo6VwL2LjmOSMnUQXKYBc4tem+H3W0uAxarmCAXWeT/8Y9bWmHnkehkuUjndEuMZpYHj8JG+CJ0js0+NcZBEyoa505+8pS6qE7jXLVu6gdsHNlZ2kAPBgLZY1q8B5kQkVwdRcpZEGaGguRIV0S6LM8/IyWcGqk4ZGSAoD6Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 09:54:57 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:54:56 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v27 20/20] net/mlx5e: NVMEoTCP, statistics
Date: Mon,  3 Mar 2025 09:53:04 +0000
Message-Id: <20250303095304.1534-21-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: a19d8e0c-2cf2-40d1-c9b8-08dd5a397445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQ+IxqyR5YLPuOWRMBBs6Puvm+fJA6UcUjZ4GrkwauLt7m7zmkTO/4cILUyQ?=
 =?us-ascii?Q?QoHVD7JFq+txXLFI8zTtVxWt40NgRTtQn4ZQtd2Yy6R0kI4p6yeNOdcmX5mc?=
 =?us-ascii?Q?N3ybSFN5z7aEms0Nc6cTJ7wb55lelc9oCXBEx6YnnUl4WrfQVWCgQY5VpWCA?=
 =?us-ascii?Q?sRCyicYs/wl2n5a01EfWdtLhNddiFNcW5L+4J3Rp7k7wCW+mApgNX/a0E0Iz?=
 =?us-ascii?Q?yOJ+Da0xDfzNBOKW6OUOOB6YhQm23NidxayYupqvUzWpNKjYAbpLOdEYZs3t?=
 =?us-ascii?Q?1eLwxlirH+wgpbkpdpLp4KR9iz0Uc8bRwwbdDGJUKgS4TGX/rY8i5GYiUvtx?=
 =?us-ascii?Q?fkO/1dAN+sTwO1AkvFB9Cp+nM5mJSB+Qp/QG6Fj4gyA8hT+GSpiS6/B8jkf9?=
 =?us-ascii?Q?FPmQxR769xO+y4jdDPFgsDa13I9XwFsvxlOGnSbQQyP2JJ69sBW8A6MMUVrz?=
 =?us-ascii?Q?0eS8x6tf8l3y2EP0hf04AAgVSll+gH830TJrMukkdmPC+euilojMKF7VphkE?=
 =?us-ascii?Q?G/VxQ8k+/cjR8v+jzk1y15HR6EzhGtiCHwIKpgQVIux1zqe2jeXGbU634Zc6?=
 =?us-ascii?Q?wykW+yaEGjFnadELe3L9SzcJSM/ibmFs+bPL1pamqBrFR36oWti9JHC/OxBP?=
 =?us-ascii?Q?oW9iNqR5/E109XQFZH2cvnNuqjp2lQKTDdGq31KCrHLYZZDpNuoepwo95pWJ?=
 =?us-ascii?Q?JmTAVR1SA3ATqU98q66/b3ww2Q6laG4nKIh534jDa4uChKGGah0ZuFMYETwH?=
 =?us-ascii?Q?BCYztn2Sasiut05YcmNoFYjCzez8cptCH3mBmXvRWNMxAkFSvfN8lmX01bv1?=
 =?us-ascii?Q?P/2bwqBoZEzSHDQGhwtMBO0B2BVpUzEyN2QOAM1bxX5LXEopavlrFDJskxIw?=
 =?us-ascii?Q?afAY/xWNNM3XwO4Tm+buW86aPwmO851CK3nLAJ+qEt2Bvmfi4II+zxwswuBj?=
 =?us-ascii?Q?u+qQYDrACocv8iYZzwy0jVH+9TFk7c0fzOmtDUyA4eZjxpeP0IyToj2baiV9?=
 =?us-ascii?Q?W6GuX17rCbopSDMFFtLxn1xMFPeBmc51DhaxclrsDxt3G0FhQ3D+CRVnrBXs?=
 =?us-ascii?Q?SzpB1YdZoqL/SixnTqQ5lW1FfW2DYJgX/B4GHlbNRUy7Gl/Jq+rcbbKNG/hg?=
 =?us-ascii?Q?K5n24erA9g1nXTM0pTd7wQJxHm+ADvE88EFhuWHiCTfN/19lIWr7cA8uE7zr?=
 =?us-ascii?Q?63UUMhziW02z6/pQaRFeQVl8exgg8JBkTWk2XeXrrWY8wcArbiZDCfoblz86?=
 =?us-ascii?Q?mDNpMOvWM1tNbW/4iYyaNy/pAfvIOkYWMVTjSs/JoTG5IlS66w+nWjVHgiZk?=
 =?us-ascii?Q?EM/oiLqc5eDu9MIKMxx2/mXFlMbxXoOG89Zxf9lx5NLowTmD/STUWChJmuPm?=
 =?us-ascii?Q?nN71MMF9uSu2aCgGxus/S7GYqQsO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bszurpOo7SjHN5rYQ8UXCOaN+7hu7IzNVfDyf6qC2Fv9+8GeWd8CrWvOfyz?=
 =?us-ascii?Q?7wy7aorKTIiRfRhsiyio5pCFlIidIGgVEkkjGidHlVzxRp4P/+4l8MGhGMJ0?=
 =?us-ascii?Q?L3Rk7h0e9juUN+uc9hl6vLnbF5awYPJkOU4SWuX2H3G3oh/2lBcP7FVmofUZ?=
 =?us-ascii?Q?FcVGiGPKYYbpR1EDQLzC1fNg3NA/TI2gJVtfKi0rSObrEIiMVVHPAoYn86R4?=
 =?us-ascii?Q?G2NQ5fUxXdXaI7BpMwCRhWVFOfJtYdiRlqa9W+IqOaYYh6c6ztSijquNOs0z?=
 =?us-ascii?Q?DayBRn8rsKrQYiaZKmH71FDg4YlQ9J1bXxK/VlkwsUttB70ZzJ5ov3IVfvy8?=
 =?us-ascii?Q?80T6IRurixEq20Cl0/CZ9cEgfzkMdYmzLPGNZmtWspEC187y1AuQ9aPUuoSW?=
 =?us-ascii?Q?GPDghELCcBjcGS17PnxSdRYsx9syB5qrjBXn5ozv24xOr7xfUw7Hx02JPTnu?=
 =?us-ascii?Q?Ej0L/cyjeBohCc0mjczam0YyubREfQ1eVgPnKA/F50fts3pArluaOYJeC3zV?=
 =?us-ascii?Q?3vOa21p6beqnaI/bB/r+0sXGDCUvqAsyYxmS8m3WMRgIx39JfEoJJHZNs0wR?=
 =?us-ascii?Q?cAxMQ2Ajg0C3kCF/4ItaM2dabF/Fzc04uSwkBe1guWfFErzCb0Xq6asqcGJR?=
 =?us-ascii?Q?KWezaNBb0jdWHcIX28m/0Fb8mpGjTxCbQdhl1noHmurZZliI0QdYLRNej2PQ?=
 =?us-ascii?Q?lpR/0lIh64FVDtNQwg/lBmFbcW1HZd4g9t9qnQQXhfy/q3giua4+9dp/WZII?=
 =?us-ascii?Q?f/LDuuJy1hXi9FS0FCfbjgXggnpQrm03FfetAFKPWyHOGghG4TNExOcbP8c1?=
 =?us-ascii?Q?qMMrJZVa1d1Jort7Rn6iTxEdpl7d7h4N+kiUmNJBhL3JnzcSe1NeV3F2Hx7x?=
 =?us-ascii?Q?2A+dIr3rItDzWtsQMMgnDTCH0B1a4ASmMBTpNxnnlpWJX5558YswGe6xVe4o?=
 =?us-ascii?Q?ocnLE+oPPEYpTFIT/wZFe2zL1AIrtLksGYSWQK7nkKlUVPLJusXLkc/azfc+?=
 =?us-ascii?Q?XNQ7rHqBtJ83wNbxxBt3EoA/qjgT8n0qUt8Fy1Ds2mVeLt2jUo9Yn6t1qkRP?=
 =?us-ascii?Q?EcSj4Qjg1qy9Gp5dLRlPJlK4woATM7wbwHxN0vOctyoviHmsfHUZj3KYhiW6?=
 =?us-ascii?Q?9QIs2LPmqWqkPGwdcriBjFPqef3vzQmai25RjhDPsazgTy68ESP34QXyMeSZ?=
 =?us-ascii?Q?7BFbP50G5KmD7IWKwNNdPqSmCBbeA0Z/yWXkuWsFHkFUE61xR3XKXuN4kWIN?=
 =?us-ascii?Q?DDIybOT8qyTKlEJrOTi+8Z3L65FNTJVBWZE2xJU+NT/3rNWWOO6ZV40ljtIF?=
 =?us-ascii?Q?/I82cAfRN6OEc3us1QxyWXih39OarCP+Dfi5PB6TSS3iCdUsS93IsGgwbHXM?=
 =?us-ascii?Q?swno5q2N4Xpg02YLXKeL43CBdTbHBKm2k4TUYJUqdRHG4YbQ1r5Aw1OGoGJ+?=
 =?us-ascii?Q?Cs/zdX+Kx0527stdOfHpFc0UyW0Nn4UxX+MeIZQ8nAmh6tyZcfgGIB6oBV82?=
 =?us-ascii?Q?AimhpjND0bLtyGV79HD8DFtS/26jHCyGVCXvZtLtcUNjxrIPN2+h7I2eyk0E?=
 =?us-ascii?Q?HRxqwfw/AlofDOq/ZdW4a/57P1nW/U7a71u+0LF8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19d8e0c-2cf2-40d1-c9b8-08dd5a397445
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:54:56.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfXD3rw05g+ASq6XYIy6HtYeGn+jI1pRN/+OrWwVtjcvgxCKp5EP7CcDQnb8DvFQdgfCuCVm01TGjqTA1sBRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

NVMEoTCP offload statistics include both control and data path
statistic: counters for the netdev ddp ops, offloaded packets/bytes,
resync and dropped packets.

Expose the statistics using ulp_ddp_ops->get_stats()
instead of the regular statistics flow.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  3 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 52 ++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 16 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 11 +++-
 .../mlx5/core/en_accel/nvmeotcp_stats.c       | 66 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  8 +++
 6 files changed, 145 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 9ec405964a6d..5d9a0e73d14a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,7 +110,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o \
+					en_accel/nvmeotcp_rxtx.o en_accel/nvmeotcp_stats.o
 
 #
 # SW Steering
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 5ed60c35faf8..1375181f5684 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -616,9 +616,15 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 {
 	struct nvme_tcp_ddp_config *nvme_config = &config->nvmeotcp;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_nvmeotcp_queue *queue;
 	int queue_id, err;
+	u32 channel_ix;
+
+	channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
+						      config->affinity_hint);
+	sw_stats = &priv->nvmeotcp->sw_stats;
 
 	if (config->type != ULP_DDP_NVME) {
 		err = -EOPNOTSUPP;
@@ -645,11 +651,11 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	queue->id = queue_id;
 	queue->dgst = nvme_config->dgst;
 	queue->pda = nvme_config->cpda;
-	queue->channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
-							     config->affinity_hint);
+	queue->channel_ix = channel_ix;
 	queue->size = nvme_config->queue_size;
 	queue->max_klms_per_wqe = MLX5E_MAX_KLM_PER_WQE(mdev);
 	queue->priv = priv;
+	queue->sw_stats = sw_stats;
 	init_completion(&queue->static_params_done);
 
 	err = mlx5e_nvmeotcp_queue_rx_init(queue, config, netdev);
@@ -661,6 +667,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	if (err)
 		goto destroy_rx;
 
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add);
 	write_lock_bh(&sk->sk_callback_lock);
 	ulp_ddp_set_ctx(sk, queue);
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -674,6 +681,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 free_queue:
 	kfree(queue);
 out:
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add_fail);
 	return err;
 }
 
@@ -687,6 +695,8 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 
 	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
 
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_sk_del);
+
 	WARN_ON(refcount_read(&queue->ref_count) != 1);
 	mlx5e_nvmeotcp_destroy_rx(priv, queue, mdev);
 
@@ -818,25 +828,34 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct ulp_ddp_io *ddp)
 {
 	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5_core_dev *mdev;
 	int i, size = 0, count = 0;
+	int ret = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	sw_stats = queue->sw_stats;
 	mdev = queue->priv->mdev;
 	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
 			   DMA_FROM_DEVICE);
 
-	if (count <= 0)
-		return -EINVAL;
+	if (count <= 0) {
+		ret = -EINVAL;
+		goto ddp_setup_fail;
+	}
 
-	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
-		return -ENOSPC;
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev))) {
+		ret = -ENOSPC;
+		goto ddp_setup_fail;
+	}
 
-	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
-		return -EOPNOTSUPP;
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu))) {
+		ret = -EOPNOTSUPP;
+		goto ddp_setup_fail;
+	}
 
 	for (i = 0; i < count; i++)
 		size += sg_dma_len(&sg[i]);
@@ -848,8 +867,13 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 	nvqt->ccid_gen++;
 	nvqt->sgl_length = count;
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
-
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup);
 	return 0;
+
+ddp_setup_fail:
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl, ddp->nents, DMA_FROM_DEVICE);
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup_fail);
+	return ret;
 }
 
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
@@ -896,6 +920,7 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 	q_entry->queue = queue;
 
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_ddp_teardown);
 }
 
 static void
@@ -929,6 +954,14 @@ void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue)
 	}
 }
 
+static int mlx5e_ulp_ddp_get_stats(struct net_device *dev,
+				   struct ulp_ddp_stats *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_nvmeotcp_get_stats(priv, stats);
+}
+
 int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -1028,6 +1061,7 @@ const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
 	.resync = mlx5e_nvmeotcp_ddp_resync,
 	.set_caps = mlx5e_ulp_ddp_set_caps,
 	.get_caps = mlx5e_ulp_ddp_get_caps,
+	.get_stats = mlx5e_ulp_ddp_get_stats,
 };
 
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 13817d8a0aae..41b5b304e598 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -9,6 +9,15 @@
 #include "en.h"
 #include "en/params.h"
 
+struct mlx5e_nvmeotcp_sw_stats {
+	atomic64_t rx_nvmeotcp_sk_add;
+	atomic64_t rx_nvmeotcp_sk_add_fail;
+	atomic64_t rx_nvmeotcp_sk_del;
+	atomic64_t rx_nvmeotcp_ddp_setup;
+	atomic64_t rx_nvmeotcp_ddp_setup_fail;
+	atomic64_t rx_nvmeotcp_ddp_teardown;
+};
+
 struct mlx5e_nvmeotcp_queue_entry {
 	struct mlx5e_nvmeotcp_queue *queue;
 	u32 sgl_length;
@@ -52,6 +61,7 @@ struct mlx5e_nvmeotcp_queue_handler {
  *	@sk: The socket used by the NVMe-TCP queue
  *	@crc_rx: CRC Rx offload indication for this queue
  *	@priv: mlx5e netdev priv
+ *	@sw_stats: Global software statistics for nvmeotcp offload
  *	@static_params_done: Async completion structure for the initial umr mapping
  *	synchronization
  *	@sq_lock: Spin lock for the icosq
@@ -88,6 +98,7 @@ struct mlx5e_nvmeotcp_queue {
 	u8 crc_rx:1;
 	/* for ddp invalidate flow */
 	struct mlx5e_priv *priv;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	/* end of data-path section */
 
 	struct completion static_params_done;
@@ -97,6 +108,7 @@ struct mlx5e_nvmeotcp_queue {
 };
 
 struct mlx5e_nvmeotcp {
+	struct mlx5e_nvmeotcp_sw_stats sw_stats;
 	struct ida queue_ids;
 	struct rhashtable queue_hash;
 	struct ulp_ddp_dev_caps ddp_caps;
@@ -113,6 +125,7 @@ void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv, struct ulp_ddp_stats *stats);
 extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
 #else
 
@@ -121,5 +134,8 @@ static inline void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv) {}
 static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en) { return -EOPNOTSUPP; }
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+static inline int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+					   struct ulp_ddp_stats *stats)
+{ return 0; }
 #endif
 #endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
index f1f4e4fdfd17..eed0da5588f0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -141,6 +141,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	skb_frag_t org_frags[MAX_SKB_FRAGS];
 	struct mlx5e_nvmeotcp_queue *queue;
@@ -152,12 +153,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -231,7 +234,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 						 org_nr_frags,
 						 frag_index);
 	}
-
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
@@ -243,6 +247,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5e_cqe128 *cqe128;
@@ -252,12 +257,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -331,6 +338,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 				       hlen + cclen, remaining);
 	}
 
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
new file mode 100644
index 000000000000..af1838154bf8
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include "en_accel/nvmeotcp.h"
+
+struct ulp_ddp_counter_map {
+	size_t eth_offset;
+	size_t mlx_offset;
+};
+
+#define DECLARE_ULP_SW_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, fld), \
+	  offsetof(struct mlx5e_nvmeotcp_sw_stats, fld) }
+
+#define DECLARE_ULP_RQ_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, rx_ ## fld), \
+	  offsetof(struct mlx5e_rq_stats, fld) }
+
+#define READ_CTR_ATOMIC64(ptr, dsc, i) \
+	atomic64_read((atomic64_t *)((char *)(ptr) + (dsc)[i].mlx_offset))
+
+#define READ_CTR(ptr, desc, i) \
+	(*((u64 *)((char *)(ptr) + (desc)[i].mlx_offset)))
+
+#define SET_ULP_STAT(ptr, desc, i, val) \
+	(*(u64 *)((char *)(ptr) + (desc)[i].eth_offset) = (val))
+
+/* Global counters */
+static const struct ulp_ddp_counter_map sw_stats_desc[] = {
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_add),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_del),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup_fail),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_teardown),
+};
+
+/* Per-rx-queue counters */
+static const struct ulp_ddp_counter_map rq_stats_desc[] = {
+	DECLARE_ULP_RQ_STAT(nvmeotcp_drop),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_resync),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_packets),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_bytes),
+};
+
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv, struct ulp_ddp_stats *stats)
+{
+	unsigned int i, ch, n = 0;
+
+	if (!priv->nvmeotcp)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(sw_stats_desc); i++, n++)
+		SET_ULP_STAT(stats, sw_stats_desc, i,
+			     READ_CTR_ATOMIC64(&priv->nvmeotcp->sw_stats, sw_stats_desc, i));
+
+	for (i = 0; i < ARRAY_SIZE(rq_stats_desc); i++, n++) {
+		u64 sum = 0;
+
+		for (ch = 0; ch < priv->stats_nch; ch++)
+			sum += READ_CTR(&priv->channel_stats[ch]->rq, rq_stats_desc, i);
+
+		SET_ULP_STAT(stats, rq_stats_desc, i, sum);
+	}
+
+	return n;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 5961c569cfe0..3e94e8c2b0d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -132,6 +132,8 @@ void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
 			struct ethtool_ts_stats *ts_stats);
 void mlx5e_get_link_ext_stats(struct net_device *dev,
 			      struct ethtool_link_ext_stats *stats);
+struct ulp_ddp_stats;
+void mlx5e_stats_ulp_ddp_get(struct mlx5e_priv *priv, struct ulp_ddp_stats *stats);
 
 /* Concrete NIC Stats */
 
@@ -406,6 +408,12 @@ struct mlx5e_rq_stats {
 	u64 tls_resync_res_skip;
 	u64 tls_err;
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	u64 nvmeotcp_drop;
+	u64 nvmeotcp_resync;
+	u64 nvmeotcp_packets;
+	u64 nvmeotcp_bytes;
+#endif
 };
 
 struct mlx5e_sq_stats {
-- 
2.34.1


