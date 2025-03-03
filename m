Return-Path: <netdev+bounces-171159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CBBA4BB4D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7C41706C9
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120561F236E;
	Mon,  3 Mar 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A1FrC8Et"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77E1F1313
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995677; cv=fail; b=Dl5w96m3r/VbRhYiM2SWvFA98CiaZMhfQVeBzgdX2gm/6qc89b/xgzsPEmFDJeUOWN2p6gZ6c5+bpS4KGo8AoIUBeI4WLjaue0etnfujE2wE3Cuqi4WBMihY2uRxqh3RccCTJP5S1Flwf958wjU7ujW6pZZDjhGM45UeuE18o8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995677; c=relaxed/simple;
	bh=NV1LcYHNvbllkGTYHUd3MVqfHC9jTigOmAudTq+C4Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qx/qXugiKcem3IojmRz97s+EOuR3kkk+tZ1ZyDCp9kGqMn/2tymtuHLoyeaHEouhVM0QV9bJBsTOXMMG9wqWy+VxmYWKYLVDsSb6SA4YCwwFpJsrfkq076i8vfO4wEEMKYhDv7/DCOFDGpjV8rFpN+fitsDZqQy8G4YAI2rCmIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A1FrC8Et; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiW5LacMfDnNjnlOPW/8XAlYssFO2fSrFhmFtshd8UA8tJHa3d8tO9Dz4irjKmnKjGtuQ/lSCWJLWU3VcJ4pWmJZ5wUD23R/uIazXsbjnWnIsmSnC731hFOsaNAlrd0j9Ncwvqoa2jEw3emigTaOdBqVzZqk1xaESyN+3LaDpqAYgGBP/VVaoqZGhEucIre4+GK3f9OyKqTSXueU8vQFbe2BHh72GKl0+1jdJPV3QLqBg2/oqva2g+UEwYQxa0JZDylvpyhRFO8hjmFU5vQK1PHDJ8UVNUFD3c4Kx3iyP4os8cVBA5v3Lu7g5eYnFtyxEmJy9bbZMI0R4jv60LyisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XJIPUiCnTJhLqXwdKt2xcO7RJyvr97kGyVQSLEVIDQ=;
 b=GRmNDM7lJUFP8BK140Ndujqh8+IT1+/xuReMDrwfXv//1LohwlLP7rcDC0vfPy4TnzRCoE8kHYH8LyRWBh+om1LPejQtrqaK7MiRHGlGxoJy3wSjjbUEE5McAlbCNerSn6d4r5akXWbi+sH8T0L/9JQp+sU0Swj2FO8506xDHqRKx9N5cw0Q8VFENrWOiTa5CpipunRzTDPPRQxospavsfaK0gUy0xSTv9FykaZ7DG7Pxs9g7XcpvcSI1g0kqcc34kb2hG724mHL2ReSNcy8Ti3VUfdxx0BHsy76rN0K8QTLLM5ox+VKU3o7nOv8DPdq32Kwt+fObrU/gUQfbj+jsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XJIPUiCnTJhLqXwdKt2xcO7RJyvr97kGyVQSLEVIDQ=;
 b=A1FrC8EtJT24wXC+z02LgxHDin7AeheVip7FBXU7Ql4MA4zzdiWXJKqynSt61YkF5hiLcM0cuEhJD/YLt1410jf4TeA476Ok6PtfEcVGoDLvoBQTtYUjoNdNrm7NXO8/0TDHlSTTNPGqH3COTHmh6BwaBh1nyA5oG9M8WYSeTN7KmsRUh/Ps71cXW7Jtg5v/s9Pm/cgaiNh4vltBfHV7NI0H3ZBcdZH/Ss1CP5cQXuF9LDHS+ss7p9Alqz0GAEAIgiUXw/vJtpXy1GFEkGn4fS/rPShwVwaW6cFXQ5jJZRHbh4Q8VRuDqpVYl8fEzfPHmbb71ZCZDiPl9ncK8Jm3/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:54:31 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:54:31 +0000
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
	tariqt@nvidia.com
Subject: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Mon,  3 Mar 2025 09:52:59 +0000
Message-Id: <20250303095304.1534-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 9423f576-35bb-4262-49c5-08dd5a39652e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/BXmfw3mwNeuy+WUQHuOl4hirlW8mk0Xc8sDLTnsUKp5veH7WPauwD/Uk00f?=
 =?us-ascii?Q?0TEpa/F+OC6FsryMQSsUydS520b8LO7Al7SOe6sbWQ+aNnM9ZbypEF/R1SBK?=
 =?us-ascii?Q?rq+u/J4Nv7Lvvjb14o3Pjl/hUusr3ZJPAJsE92gnWuL7tes8NXc43NyWTtsy?=
 =?us-ascii?Q?a3pg9MsEqhlmTcSZ2WOC11M0dUSDq0iqa/LG01PCzyAlpqw+01wGlPBtNX4V?=
 =?us-ascii?Q?LQBL3q0ho2a+fQj6f71ob8nnU+56fugjCUFPcG72n1B8IM7vf4cMFI7TWgd7?=
 =?us-ascii?Q?+o0UwFnYnIyXkvOzzKrMcZt6PsE0jif7KEs1aD6sZnds8P+9Q6BVb2iUubIg?=
 =?us-ascii?Q?6dHxX6l05OApcWxqHU5EdYn1ChUMJ9Ng3EIcxJ3mBk10/grQiZYlHRG3m0+B?=
 =?us-ascii?Q?dyQ9+m5O9RPFta8E0YWpRx7MT23YmGn4NqBHpeXnsPwzgUxC0wKEbphMXwzi?=
 =?us-ascii?Q?+QGnlynIOXq7/OqfwL3cefvLhbZqGde1hRlmyMgCQqn3G5BdDA7198Fw2Fum?=
 =?us-ascii?Q?udN18QFEOEQiAd70kMVDG1TiT0x4cxa5p0TZlHm6y8rbInOaVs8o7pO2CzVW?=
 =?us-ascii?Q?M3qfQge5ggViBXIOcR3cXNeghC8C/Xdfi8a9Ew5xducqcU+BpkuJ1+Cs6m2y?=
 =?us-ascii?Q?+KSK8SHcBSEelHCpwxVwUdJwBXvvXcMUGBlCV3RZbx3hJDlTQG6I065JLXDd?=
 =?us-ascii?Q?7aPUNHsdjqv5l3DLh4o5dh0VOkBmEsSZ0XTK+bRHOBIpNk0lxnjGMJbX0COt?=
 =?us-ascii?Q?fbsKjLcwUGT9rhkY0+DWBSzUa/wxic54oKyx11DED1Agy4wAuGQ7DqbrWV5J?=
 =?us-ascii?Q?Zn3Sd+SYXRxvgH17l9u8xzqXGvZ2puNl2e6BvqfGQiM/KTrn5QcvfOww7PYR?=
 =?us-ascii?Q?QKE/StkwemwznE73ZFi4a6RgRa33U6sA2mkX8zIBJ3Xaf51U9B/sUwtjlhdF?=
 =?us-ascii?Q?HVlys0cgx5leuWLnGbi8ECP9sNTtXicvaGM7R85Eq7v7en2BRa5QcNE3tsiy?=
 =?us-ascii?Q?iwqOC4JshAURmIRrEPxWouttLoT8CAVkY/AqAlsgdbkB2FsXSSjelOKOXZJy?=
 =?us-ascii?Q?r7nuGrNBo+gN4rFWHclVeUVfhFd9bhcuOB3UV8ZTOqECs2r1yDWHEpJiZjGP?=
 =?us-ascii?Q?+a8aQ296f+8M8+nMMNtKkPoBY6+wjFYpiF28Vh48NY7pKAReBgTMk2D63Oc1?=
 =?us-ascii?Q?Di0Yw/ZzEIbopOGtqYM59qGL9HV4pMwf73+5lc8TY2Fx4apqzeXx1p4NvTz1?=
 =?us-ascii?Q?r4k5OdSyoHBmUOUHfqR/Fdp7mvrLcFGIt/ewgnpzlWORkNwLey1j1dL7sVW5?=
 =?us-ascii?Q?L0aS5z4BHTLZC1DELu1fdOWZA3Sk8I8W6NvLLoynf4GfrvNGpPFEcYtRcxCJ?=
 =?us-ascii?Q?nchbDZB8LFWZHvc4f2N/7uHYn9g3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FhGSO+tAMI77dftUM0mvegQ9QJeMYARTSRY6vLQH0L7YIhgYiuikdPi7FXDN?=
 =?us-ascii?Q?JBRwaSgiiPBhdB5L8eUuA9Z8yC5hkejD+5mYJLoQZPrI+iC5HpGoNIDxr1UH?=
 =?us-ascii?Q?HdMXXfW6bbQp3CV2LcSusMPrXQ3LpTK/ry8FtqkwW1KW+u5/QgO/ktE+xWG2?=
 =?us-ascii?Q?H6ZfqF/NqElYQwmdgUzabdPc9Rz/Mn16HHXhcO2k0u2qPo5P8pYST8piacvM?=
 =?us-ascii?Q?mo0hUVTYSOziI8IOx42OOEEiHL0Zt7BiEMh6gTzCcBSSuPdxOc0mdCC+RYse?=
 =?us-ascii?Q?viRHoimSiIdNnA4HMifLZHXcy9qC6di/UDRqFGFTwZzruCmg4SP6NbM9+dF8?=
 =?us-ascii?Q?f3ktBgiGiWZ00vA8DHtl+qAnQXEnFwYadT9etVGGRV7ZkOEy3/VrKKspDBq1?=
 =?us-ascii?Q?62LFGfXZNhhYQTlK7yprF+LE+LQYdtG85NpqzkM37JcaS2IO9FsUDjJ+YB90?=
 =?us-ascii?Q?8uEPcULmusPJ6XCRikl66PwRwXtBn/lXZ73r6+3/zKUDmE61sxHo/i50j5BD?=
 =?us-ascii?Q?6seZqfUGe/daNXO8rwmQAxYK4PJVGIWP/yoCwWFa5M9SwaCzHs3XLjdbeotx?=
 =?us-ascii?Q?lnINGsOfdaLcy14yyFs9RvNXFRiq4U0Qa3OebabXcazXmkyxu4ekD5zJku4I?=
 =?us-ascii?Q?ltTpadZvYFgEmrGUFZTG1xIe1gt3DC1yhIVO7nfB2epYZhQ1R9opxL6Fcq5e?=
 =?us-ascii?Q?JKaw60FeWgHEm957q/7kcVyzWGSSMDyzxsmPQVyYOQKv4cg9uRdSyi9D+eCJ?=
 =?us-ascii?Q?HLtk8Cbx5xhv2D72F8UckqBecW2euth7YL+VhmGPoTffTSlEFWAyQ076a8kc?=
 =?us-ascii?Q?sMGv5erh0dSX7dYmcPDhzGWFzMwIubbr33xKuk8m9Z/fFPtwIzyC9DR1DiB+?=
 =?us-ascii?Q?gfkYSaYbnrAxVwTLysT/0B/AHV9kNVQXAyt4KM/IF38/XgrcsII/X6EsM+3p?=
 =?us-ascii?Q?YyKJMb6NVHbasYpA3vodZxkgXXfXstONgkMmR6OEFRwEoBW/wsMO1yPRSF2m?=
 =?us-ascii?Q?ZAGH8fkPhM87Iu64GQPbfDycx1lfD9LQ0A277WcNvDzMMRMGH/UrPwQR8J9T?=
 =?us-ascii?Q?xfXYbHgt0SyeA8Lk3JnNRcXG1WxJdbXMbk62K9Qq1LEi4iOgtdu3wqjOj54V?=
 =?us-ascii?Q?25sCbN25fgHT9m3RqHEIpRbJuM5oKjAxxY7TRHOQGaSWf0F+BSJiK6Ap+AKM?=
 =?us-ascii?Q?sO66MCE1S9hKfpuMxcMgsJfqlQgOlE0QyODmqUznpNvX/pSaSQxxZSQynZqR?=
 =?us-ascii?Q?l/RFhtIjJAhzKMKLDB9AHTuZ6cNTbZuYc1NRO1mluIuDP2a7GzIsuXgkn7r5?=
 =?us-ascii?Q?SsJ1gGVY+SMU6qvYhn3vdmbwwy7yn3NjSGZn3LBtgwBep1UA/FCMetpar08f?=
 =?us-ascii?Q?23F9YGyAXBAncTR44g2/Xfo333aKUdWQZkYjoTctQDyG9SdLK9KSA912Dkvh?=
 =?us-ascii?Q?Yo/1pyXHYbxwftje6b0iu+ScvZvxdOpM1uOqcSGvrePcb5L6Vu8311ZqPF4k?=
 =?us-ascii?Q?3KG7p7b33ijlWU8H0aRfjaZPlT9jknnqRqaM+uSCoLUvfKQ86ihN5wrWqscw?=
 =?us-ascii?Q?tDPIcNi0RDX7El9yDjv/TiEM7+TL8vhu+xKeX6iI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9423f576-35bb-4262-49c5-08dd5a39652e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:54:31.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DByOp//xaQi4IiffziNNJR6cgnLN73pgGRnk/WibL7oYcxciwbAVIXInnecy5lNLRxhAKoN3iJi0wFwE8m5kzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

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
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  19 +++
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  16 ++-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 123 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 5 files changed, 184 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 493238d2e8e0..b24209ce65a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -146,6 +146,25 @@ struct page_pool;
 #define MLX5E_TX_XSK_POLL_BUDGET       64
 #define MLX5E_SQ_RECOVER_MIN_INTERVAL  500 /* msecs */
 
+#define MLX5E_KLM_UMR_WQE_SZ(sgl_len)\
+	(sizeof(struct mlx5e_umr_wqe) + \
+	 (sizeof(struct mlx5_klm) * (sgl_len)))
+
+#define MLX5E_KLM_UMR_WQEBBS(klm_entries) \
+	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_BB))
+
+#define MLX5E_KLM_UMR_DS_CNT(klm_entries)\
+	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_DS))
+
+#define MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size)\
+	(((wqe_size) - sizeof(struct mlx5e_umr_wqe)) / sizeof(struct mlx5_klm))
+
+#define MLX5E_KLM_ENTRIES_PER_WQE(wqe_size)\
+	ALIGN_DOWN(MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size), MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT)
+
+#define MLX5E_MAX_KLM_PER_WQE(mdev) \
+	MLX5E_KLM_ENTRIES_PER_WQE(MLX5_SEND_WQE_BB * mlx5e_get_max_sq_aligned_wqebbs(mdev))
+
 #define mlx5e_state_dereference(priv, p) \
 	rcu_dereference_protected((p), lockdep_is_held(&(priv)->state_lock))
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index e710053f41fc..1453195587c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -71,6 +71,9 @@ enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
 	MLX5E_ICOSQ_WQE_GET_PSV_TLS,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+#endif
 };
 
 /* General */
@@ -277,10 +280,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
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
 
@@ -294,6 +297,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
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
index 6512ab90b800..8dda0eee0ab9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1056,6 +1056,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
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


