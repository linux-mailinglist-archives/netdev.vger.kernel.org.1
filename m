Return-Path: <netdev+bounces-168439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE4FA3F0FD
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16DF1885B57
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ECC20010A;
	Fri, 21 Feb 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XS++3SeB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F641FF1C3
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131576; cv=fail; b=BYz0ct5Hls7LA7ZQU/c8tbSj/uh+8m8CZ5nw2qRM9mcK3i6X+dQPRSVJn8EAQ2XO0msnI+KpvUjLHbiIWWmLCG3kxUET14IpVaw+KJcXLOdKbcmGv8DA69KXJADfqezhrHbZD/TrBDPcvOhWCBGrxAlN8ByrnwmKH607xTrenLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131576; c=relaxed/simple;
	bh=F2+EgFFnu4E6RnArBgGPjQ9TG4dVMxO6k2cbLAf12Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMpBLZHuxf9nv04roHcooonb5xfCTm+imTphBL+SnjjE2XVpLqudcFiCc/JMLfjWy/IerARWCljtpl6a294DeJnmTMonUkwBcxHZWWN8eIj5+fSkTmUPQ0QnpCYVMFedyYXVabcRrXObsKt+ZBDRWVdsY/IuqGP7Y9Xo486KeIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XS++3SeB; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PORupg0f2o1c6VCGwk8GOzKcRuf3J1GC2AAVB+6jOTydbbDJQamYwUmbu9iEbNsBwmPJmvZ5bqb3JlAsqepsdxzODDbKWoLKXZZlT0hfs9TTZr1EzgsfvRLae894ScnWb2xvnuJ+UUmttGFAIW2RugzepmIs9ycfJam1n2qIeimFZmeOp/7gV63t9x+WS7SgU1IfICK1K6nbgLbtdLMkd/xyM3iNh2PtIF8gf7s0aUu2qwnQbMPSexnCw50db0FoZ1UmziUX1fF7HzZJp4v+R7d/KoB5gos8SVDZJharqG+vTpz7U2VspErHj3v6uq+S16/3v6YtGkzHQcQOW0fqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Szf7HRWp13jss+w35tP7/4U7Kout+4JSr5i5WLMcAEU=;
 b=CC7DqXneWYNfCwDtQeIhbshxIlr7uXQvWrultZ3nnTZKv/MuxbPb1+xxnnyBJe2w1ELV3K357O9KPfGKZTjBoIVbjW/nZs9auMjhLSjHvQXkBenZVdNSAIpYrvjw40BLDVTltP0E/rORGkRcUMdOSTHUhzJxSxRnGN6un0tiPf3TTG+uIXQ1yfXGUReyQblNcHKkaYn4QMOfN++pOsxcfHDZb4C62f8RGTMzI9+hJTDDChCfwO5pfz6Lz8vGlU8RwQKBrbbgYy5Z1M0llcpZ9BA6u0W1Ol2QvzxIlfebkAzzRw5/semFYUnuI0L+6+AzRKN7yDhR4AIMsYQ3U5z7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Szf7HRWp13jss+w35tP7/4U7Kout+4JSr5i5WLMcAEU=;
 b=XS++3SeB4z/xkhM8Uufkg6hXpfTOATcO6K2nY35ladYWtRRvCXhZBxSJAUUsaE2JDFoy55xf869CokK2qPaLJZtOfsiUwGODH2K6uMXvOYthoAiRZQPLBoGfT/PhaZ0x0wMVis6OqtuElIQHcSnkGAouRLMoB56jdreR+qg+M/ELJtUDqpTkl2ZcWfnzbWVbA3d4kJeD9Xb3DkzTunrhiZFg02D1sALtHBYNqWxaogi1y4rk7fet8YJ3Tuiuq1Y5nezGGVqs8VXJPpxRDew41Fl0D3ofnfjd00IVPNuS2pYzBBimCvzzHQ1YLmFvk4xJ6SKiJ21Fj+E8rrqq+Z0qFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 09:52:51 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:52:51 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH v26 01/20] net: Introduce direct data placement tcp offload
Date: Fri, 21 Feb 2025 09:52:06 +0000
Message-Id: <20250221095225.2159-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::6) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 97221fa1-2171-4748-5a2e-08dd525d8172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6C2ftCJ+TzzjcSrOev7YGQ9wa2CzzS2kSfyrDGqAIBMjCFGBnpbXLOolJoNG?=
 =?us-ascii?Q?0j7HCVA2xToX2ymnhf445scy7npM8yKTlVbf9tZWksJw/BNpMm+Y8UyAltgx?=
 =?us-ascii?Q?bqME9mnOg43j0yohBJE5L3a6tufDrXgciSG1/P39PytzqQ1aJ5vkEbYQfRwD?=
 =?us-ascii?Q?B1SC5Dc8KmYcLdZWTkZLlQIb/iAK0IxPgZsn1FHQ3CyYRNK8ILkxuf5ouOAb?=
 =?us-ascii?Q?XsV+rXcQFbArSFdklOBdIr6T46wbiWgK9xzvlvVr+8R3mP9VWS09Z+OdADpm?=
 =?us-ascii?Q?bFqJeeLN5NF247P0lmi9vCF2i1SYwa4yqVTENjpblTcufHqfhGiI9WIyvDC6?=
 =?us-ascii?Q?PLubdfFTBF8aBDdWtkTgDiwDID3CF6iErEFpkOyDUlk6Np9Ttj/BZWaUizEO?=
 =?us-ascii?Q?hGHt18y2StOrHb9VBJZUGb9kTjWpPGINJpqEKV+H7b/d4oLWpoJEQIXe1B7/?=
 =?us-ascii?Q?NbxxRNOnvbx4G90V35ftaMwCtisAY+1GNYoIxdB7rxmPL/bngjeWZORc9BGC?=
 =?us-ascii?Q?xViHJmgh2DOFpb5NFZ/VqnmReojbThs/nBHnD0m5ooAUMWgrwByqBowbUa0W?=
 =?us-ascii?Q?n8wbOZe99p++Cdi21MyHwYO5jvZV7aibOjJccLm4jxZ1br62EkzKcqwuGPNh?=
 =?us-ascii?Q?LHR9SqnhEnqPgP+eWQK1u4NCnuYRgOCt4cz2vMMtF3V8uLHlsbSAw86Jm3zV?=
 =?us-ascii?Q?KTWUS7KcOIDq7EPNI5w8S6j999mi+I0S7Br1841Q1cY0cxvHkDWigAuZaXN9?=
 =?us-ascii?Q?DPA4t4HU7GAG+wiHfLOqJc3/9lVMC4EXXXnkoYoZSGpdrWZryj9rHlKF3Yt0?=
 =?us-ascii?Q?M4UbpmyrKKvfM1w/tmnbAaSdMDbK7itMZzJkLJzvq2EzjYAGbVVkxXKIAyWK?=
 =?us-ascii?Q?llL6wFCzQ5baXRCKJJoHrF48v+oJpqat385miPGsN2Oavsc/GCDg4PulIb73?=
 =?us-ascii?Q?Ua8uEtXMYB3/NSoxcZh1+TQzHZd2cQvRoOXe3V++CQnVl8UFziq8H+kcc25J?=
 =?us-ascii?Q?Y/zpMzSEdiaQGPJm/0MO+mEoG9cLLV7QWlqBLx0HhH9cR6K/kPP6mmRCwi7J?=
 =?us-ascii?Q?N2BxvqN2Tg9Fgfn2bo4FhH2YPUNwcfrISnGDw89KC9NvsQ4zUzn4xrDQi2jv?=
 =?us-ascii?Q?Jl4K1bU+mSkye0fZR56YnicDfAKWCKKrkcsJN9EVLOqgPV2mWckg4UA1a+x9?=
 =?us-ascii?Q?rIlvMJpK6NOmR7zQbDRr0KBZxEFqzcUonLITjVJZEnu9Fbb4L3ggtapfECl1?=
 =?us-ascii?Q?kxC92GrYIxIianh0s3csZDCu4n4sLYcjgfpyb4rfcrPfoxC/T+GAbtqZ/0qN?=
 =?us-ascii?Q?Es8hp3LOAc4nKXh+CQqYQyo47iVTDTUOBF+EzZoyJIXMKeiGJfRStXxzKk47?=
 =?us-ascii?Q?gBqkLtUn21l36n/qQy/AL/a7P/z/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?abTx6RJmiy6O83Bz4Sn+oP3U0L2y1KquOX7a9QSQlPE6Ve/IN0gwtVlO7vWt?=
 =?us-ascii?Q?1R3KqSTLrz4M+kgAC4jNILF7iRksB6HdeUq68OiRcvwnuFaGo/EUDEaOwUMQ?=
 =?us-ascii?Q?SUckjrt5rBC78t4BvWb6VF6URIylEG+Ln52U4QVTLH8xWuuKkMmdsc/Py5a2?=
 =?us-ascii?Q?x6wAsJ1QzV6ctzlttOXNpTTdoxiMQ5sqIGf9b+mBmqkqXTuviLj8gJO4koc6?=
 =?us-ascii?Q?UNDO5E2VG5AL0GI4Jlc6GgcYFsmteAQRCsO0gDxJx3M9wDwb8YIMmz2WJeb+?=
 =?us-ascii?Q?/NpCZn9Q3FX+Ymk49Td9jgXGBRZtJVg+YDrDqLZzYgHD/lQDL+ZM6Z5yOR70?=
 =?us-ascii?Q?V6OpQ/WZVlEjvic2SmzNJePYQDk/jTaaWVft3r4vCncKKnzjUFvfyABiaHmt?=
 =?us-ascii?Q?udQWJYrLvDlw1iIJFoc5VZPtddTtx6AgR5QENUfiUa2I5qs7Fb141TCKBTuJ?=
 =?us-ascii?Q?+rGuzDaRQvSAX/+86LEHCb12SV/s1Bg9JoMAB25QlYTrMU/BxKQkpH2jS/IQ?=
 =?us-ascii?Q?sMgHS2BaLSVv5UfK4f7HONY4eg4zhuFYEUky0BvOrknvgcLX8r9HqoLA60me?=
 =?us-ascii?Q?/jB4lOoezUglSW8NKDYCyKbXCcgnJnn/UJakbyonzce4EpKeLojX/zWp8Lru?=
 =?us-ascii?Q?mls5nbhjx2DTLVxz0gZ84adFFraqkmboSiuWg5dxEt8mnetqhcpnHk27twWO?=
 =?us-ascii?Q?SsUR60DgedUz6heZMQkjN/8Gr19X447ZM/vYdrqWQRAIUMtze13k+oHGgVN0?=
 =?us-ascii?Q?PRtRDRloGJGVV8PUqab1TJnRpmpuTBaZ6o86cQmWFS2AMw33JB0DCyeU2HnG?=
 =?us-ascii?Q?VTxqSKeryUcT2RVX2EKHh1aoU0OX0f8NBTWzG03gJ1aHh5s/pDqDgvmrdKeZ?=
 =?us-ascii?Q?UXSovJoFT3Qq5LaDOW2jnzb18tgXEjDTFbj66G4w7jFYW3xJAZlNCDlRHUDA?=
 =?us-ascii?Q?DlLqvZ469LUbCKRqoerLZqZFslnBAwGybCpi1sso/mkFnnkqX6m5xL/9tsZl?=
 =?us-ascii?Q?cYj3JYqM4altfVMlVEs5gx6/YOh5n+9Mst4UytSI775etg3X8DF7EQJ00AgM?=
 =?us-ascii?Q?nZ2rlYuvve4qVOWW/l7YFKzrpd5xOYXrg//2GK4IEN7GCdxj57+S0csoLDrC?=
 =?us-ascii?Q?UiZTBLlIzMv9srGrVyoWqEDdV+981/VVsyAegEHjoHp7AagnNASH92Ves8nq?=
 =?us-ascii?Q?bOPZRnAt93yTLOZag+LywK4JoJaarm72mLyVuBBsBuULAVbYkmqHzqpqr2jE?=
 =?us-ascii?Q?Q9fQy1mwYD66nDVRVhISgVaqn+t96Ln3dKcfQGENQKsdtMivQsrGC2cDLeuu?=
 =?us-ascii?Q?/idH+/0vKtXW/UmPEwW7Bg1j5KEv3Kqfe6rfLf4WsNZoABfLhklteugCFjq/?=
 =?us-ascii?Q?TZUVwYbCWKST9X9kvjrPlJgcKqARJSPl2U97lFa40X+z4VtQ1alDX/nFNsYy?=
 =?us-ascii?Q?Ru0dGLkBc1LGsPIH3UxFal637My/RWEvUba1+j8H+XlD7TZ2XPtKHOvkD53B?=
 =?us-ascii?Q?L1tMUhjMUjPWK3aGtanK6ZzvLyQQCe9Asn0LVAqoZ11D7ZVSU7H4B3vVdwOH?=
 =?us-ascii?Q?lmHYQqXZSH//M2wF1bp7GFKGJZD96MtIwH5gdAW/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97221fa1-2171-4748-5a2e-08dd525d8172
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:52:51.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAwZGs2WyD+ZLTmsaU6Cg/MJ+1OQUihe88i3c2weBFXL9b9Mz0FafVb1CicJl89F2n83ylRWdLYbX4/B8bMcWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement (DDP) offload for TCP.

The motivation is saving compute resources/cycles that are spent
to copy data from SKBs to the block layer buffers and CRC
calculation/verification for received PDUs (Protocol Data Units).

The DDP capability is accompanied by new net_device operations that
configure hardware contexts.

There is a context per socket, and a context per DDP operation.
Additionally, a resynchronization routine is used to assist
hardware handle TCP OOO, and continue the offload. Furthermore,
we let the offloading driver advertise what is the max hw
sectors/segments.

The interface includes the following net-device ddp operations:

 1. sk_add - add offload for the queue represented by socket+config pair
 2. sk_del - remove the offload for the socket/queue
 3. ddp_setup - request copy offload for buffers associated with an IO
 4. ddp_teardown - release offload resources for that IO
 5. limits - query NIC driver for quirks and limitations (e.g.
             max number of scatter gather entries per IO)
 6. set_caps - request ULP DDP capabilities enablement
 7. get_caps - request current ULP DDP capabilities
 8. get_stats - query NIC driver for ULP DDP stats

Using this interface, the NIC hardware will scatter TCP payload
directly to the BIO pages according to the command_id.

To maintain the correctness of the network stack, the driver is
expected to construct SKBs that point to the BIO pages.

The SKB passed to the network stack from the driver represents
data as it is on the wire, while it is pointing directly to data
in destination buffers.

As a result, data from page frags should not be copied out to
the linear part. To avoid needless copies, such as when using
skb_condense, we mark the skb->no_condense bit.
In addition, the skb->ulp_crc will be used by the upper layers to
determine if CRC re-calculation is required. The two separated skb
indications are needed to avoid false positives GRO flushing events.

Follow-up patches will use this interface for DDP in NVMe-TCP.

Capability bits stored in net_device allow drivers to report which
ULP DDP capabilities a device supports. Control over these
capabilities will be exposed to userspace in later patches.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h          |   5 +
 include/linux/skbuff.h             |  40 ++++
 include/net/inet_connection_sock.h |   6 +
 include/net/tcp.h                  |   3 +-
 include/net/ulp_ddp.h              | 320 +++++++++++++++++++++++++++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   3 +-
 net/core/ulp_ddp.c                 |  51 +++++
 net/ipv4/tcp_input.c               |   2 +
 net/ipv4/tcp_offload.c             |   1 +
 11 files changed, 450 insertions(+), 2 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fccc03cd2164..405229e378ea 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1378,6 +1378,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1633,6 +1635,9 @@ struct net_device_ops {
 	 */
 	const struct net_shaper_ops *net_shaper_ops;
 #endif
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops *ulp_ddp_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..5a612b7edad9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -843,6 +843,8 @@ enum skb_tstamp_type {
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time clock base of skb->tstamp.
+ *	@no_condense: When set, don't condense fragments (DDP offloaded)
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -1020,6 +1022,10 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+#ifdef CONFIG_ULP_DDP
+	__u8                    no_condense:1;
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5274,5 +5280,39 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_no_condense(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->no_condense;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
+static inline void skb_copy_no_condense(struct sk_buff *to,
+					const struct sk_buff *from)
+{
+#ifdef CONFIG_ULP_DDP
+	to->no_condense = from->no_condense;
+#endif
+}
+
+static inline void skb_copy_ulp_crc(struct sk_buff *to,
+				    const struct sk_buff *from)
+{
+#ifdef CONFIG_ULP_DDP
+	to->ulp_crc = from->ulp_crc;
+#endif
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d9978ffacc97..1e88149d88ac 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -67,6 +67,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
  * @icsk_clean_acked	   Clean acked data hook
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -98,6 +100,10 @@ struct inet_connection_sock {
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
 	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
+#ifdef CONFIG_ULP_DDP
+	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
+	void __rcu		  *icsk_ulp_ddp_data;
+#endif
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7fd2d7fa4532..0dd50db2ff6f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1083,7 +1083,8 @@ static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
 					   const struct sk_buff *from)
 {
 	return likely(mptcp_skb_can_collapse(to, from) &&
-		      !skb_cmp_decrypted(to, from));
+		      !skb_cmp_decrypted(to, from) &&
+		      skb_is_ulp_crc(to) == skb_is_ulp_crc(from));
 }
 
 /* Events passed to congestion control interface */
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
new file mode 100644
index 000000000000..9f2d14998cb3
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,320 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *   Author:	Boris Pismenny <borisp@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _ULP_DDP_H
+#define _ULP_DDP_H
+
+#include <linux/netdevice.h>
+#include <net/inet_connection_sock.h>
+#include <net/sock.h>
+
+enum ulp_ddp_type {
+	ULP_DDP_NVME = 1,
+};
+
+/**
+ * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+ *
+ * @full_ccid_range:	true if the driver supports the full CID range
+ */
+struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+};
+
+/**
+ * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+ * protocol limits.
+ * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+ *
+ * @type:		type of this limits struct
+ * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+ * @io_threshold:	minimum payload size required to offload
+ * @tls:		support for ULP over TLS
+ * @nvmeotcp:		NVMe-TCP specific limits
+ */
+struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+};
+
+/**
+ * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+ *
+ * @pfv:	pdu version (e.g., NVME_TCP_PFV_1_0)
+ * @cpda:	controller pdu data alignment (dwords, 0's based)
+ * @dgst:	digest types enabled (header or data, see
+ *		enum nvme_tcp_digest_option).
+ *		The netdev will offload crc if it is supported.
+ * @queue_size: number of nvme-tcp IO queue elements
+ */
+struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+};
+
+/**
+ * struct ulp_ddp_config - Generic ulp ddp configuration
+ * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
+ *
+ * @type:	type of this config struct
+ * @nvmeotcp:	NVMe-TCP specific config
+ * @affinity_hint:	cpu core running the IO thread for this socket
+ */
+struct ulp_ddp_config {
+	enum ulp_ddp_type    type;
+	int		     affinity_hint;
+	union {
+		struct nvme_tcp_ddp_config nvmeotcp;
+	};
+};
+
+/**
+ * struct ulp_ddp_io - ulp ddp configuration for an IO request.
+ *
+ * @command_id: identifier on the wire associated with these buffers
+ * @nents:	number of entries in the sg_table
+ * @sg_table:	describing the buffers for this IO request
+ * @first_sgl:	first SGL in sg_table
+ */
+struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
+/**
+ * struct ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
+ *                           for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
+ *                         Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct ulp_ddp_stats {
+	u64 rx_nvmeotcp_sk_add;
+	u64 rx_nvmeotcp_sk_add_fail;
+	u64 rx_nvmeotcp_sk_del;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_packets;
+	u64 rx_nvmeotcp_bytes;
+
+	/*
+	 * add new stats at the end and keep in sync with
+	 * Documentation/netlink/specs/ulp_ddp.yaml
+	 */
+};
+
+#define ULP_DDP_CAP_COUNT 1
+
+struct ulp_ddp_dev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_CAP_COUNT);
+};
+
+struct netlink_ext_ack;
+
+/**
+ * struct ulp_ddp_dev_ops - operations used by an upper layer protocol
+ *                          to configure ddp offload
+ *
+ * @limits:    query ulp driver limitations and quirks.
+ * @sk_add:    add offload for the queue represented by socket+config
+ *             pair. this function is used to configure either copy, crc
+ *             or both offloads.
+ * @sk_del:    remove offload from the socket, and release any device
+ *             related resources.
+ * @setup:     request copy offload for buffers associated with a
+ *             command_id in ulp_ddp_io.
+ * @teardown:  release offload resources association between buffers
+ *             and command_id in ulp_ddp_io.
+ * @resync:    respond to the driver's resync_request. Called only if
+ *             resync is successful.
+ * @set_caps:  set device ULP DDP capabilities.
+ *	       returns a negative error code or zero.
+ * @get_caps:  get device ULP DDP capabilities.
+ * @get_stats: query ULP DDP statistics.
+ */
+struct ulp_ddp_dev_ops {
+	int (*limits)(struct net_device *netdev,
+		      struct ulp_ddp_limits *limits);
+	int (*sk_add)(struct net_device *netdev,
+		      struct sock *sk,
+		      struct ulp_ddp_config *config);
+	void (*sk_del)(struct net_device *netdev,
+		       struct sock *sk);
+	int (*setup)(struct net_device *netdev,
+		     struct sock *sk,
+		     struct ulp_ddp_io *io);
+	void (*teardown)(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *io,
+			 void *ddp_ctx);
+	void (*resync)(struct net_device *netdev,
+		       struct sock *sk, u32 seq);
+	int (*set_caps)(struct net_device *dev, unsigned long *bits,
+			struct netlink_ext_ack *extack);
+	void (*get_caps)(struct net_device *dev,
+			 struct ulp_ddp_dev_caps *caps);
+	int (*get_stats)(struct net_device *dev,
+			 struct ulp_ddp_stats *stats);
+};
+
+#define ULP_DDP_RESYNC_PENDING BIT(0)
+
+/**
+ * struct ulp_ddp_ulp_ops - Interface to register upper layer
+ *                          Direct Data Placement (DDP) TCP offload.
+ * @resync_request:         NIC requests ulp to indicate if @seq is the start
+ *                          of a message.
+ * @ddp_teardown_done:      NIC driver informs the ulp that teardown is done,
+ *                          used for async completions.
+ */
+struct ulp_ddp_ulp_ops {
+	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+	void (*ddp_teardown_done)(void *ddp_ctx);
+};
+
+/**
+ * struct ulp_ddp_ctx - Generic ulp ddp context
+ *
+ * @type:	type of this context struct
+ * @buf:	protocol-specific context struct
+ */
+struct ulp_ddp_ctx {
+	enum ulp_ddp_type	type;
+	unsigned char		buf[];
+};
+
+static inline struct ulp_ddp_ctx *ulp_ddp_get_ctx(struct sock *sk)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return (__force struct ulp_ddp_ctx *)icsk->icsk_ulp_ddp_data;
+#else
+	return NULL;
+#endif
+}
+
+static inline void ulp_ddp_set_ctx(struct sock *sk, void *ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	rcu_assign_pointer(icsk->icsk_ulp_ddp_data, ctx);
+#endif
+}
+
+static inline int ulp_ddp_setup(struct net_device *netdev,
+				struct sock *sk,
+				struct ulp_ddp_io *io)
+{
+#ifdef CONFIG_ULP_DDP
+	return netdev->netdev_ops->ulp_ddp_ops->setup(netdev, sk, io);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline void ulp_ddp_teardown(struct net_device *netdev,
+				    struct sock *sk,
+				    struct ulp_ddp_io *io,
+				    void *ddp_ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, sk, io, ddp_ctx);
+#endif
+}
+
+static inline void ulp_ddp_resync(struct net_device *netdev,
+				  struct sock *sk,
+				  u32 seq)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->resync(netdev, sk, seq);
+#endif
+}
+
+static inline int ulp_ddp_get_limits(struct net_device *netdev,
+				     struct ulp_ddp_limits *limits,
+				     enum ulp_ddp_type type)
+{
+#ifdef CONFIG_ULP_DDP
+	limits->type = type;
+	return netdev->netdev_ops->ulp_ddp_ops->limits(netdev, limits);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline bool ulp_ddp_cap_turned_on(unsigned long *old,
+					 unsigned long *new,
+					 int bit_nr)
+{
+	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
+}
+
+static inline bool ulp_ddp_cap_turned_off(unsigned long *old,
+					  unsigned long *new,
+					  int bit_nr)
+{
+	return test_bit(bit_nr, old) && !test_bit(bit_nr, new);
+}
+
+#ifdef CONFIG_ULP_DDP
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
+
+#else
+
+static inline int ulp_ddp_sk_add(struct net_device *netdev,
+				 struct sock *sk,
+				 struct ulp_ddp_config *config,
+				 const struct ulp_ddp_ulp_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ulp_ddp_sk_del(struct net_device *netdev,
+				  struct sock *sk)
+{}
+
+static inline bool ulp_ddp_is_cap_active(struct net_device *netdev,
+					 int cap_bit_nr)
+{
+	return false;
+}
+
+#endif
+
+#endif	/* _ULP_DDP_H */
diff --git a/net/Kconfig b/net/Kconfig
index c3fca69a7c83..bf09e302007b 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -538,4 +538,24 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config ULP_DDP
+	bool "ULP direct data placement offload"
+	help
+	  This feature provides a generic infrastructure for Direct
+	  Data Placement (DDP) offload for Upper Layer Protocols (ULP,
+	  such as NVMe-TCP).
+
+	  If the ULP and NIC driver supports it, the ULP code can
+	  request the NIC to place ULP response data directly
+	  into application memory, avoiding a costly copy.
+
+	  This infrastructure also allows for offloading the ULP data
+	  integrity checks (e.g. data digest) that would otherwise
+	  require another costly pass on the data we managed to avoid
+	  copying.
+
+	  For more information, see
+	  <file:Documentation/networking/ulp-ddp-offload.rst>.
+
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index d9326600e289..767ed5186d4d 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 obj-y += net-sysfs.o
 obj-y += hotdata.o
 obj-y += netdev_rx_queue.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..d64a9d933e10 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -78,6 +78,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6887,7 +6888,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb) || !skb_frags_readable(skb))
+		    skb_cloned(skb) || !skb_frags_readable(skb) || skb_is_no_condense(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..d97c530b4f19
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.c
+ *   Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <net/ulp_ddp.h>
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops)
+{
+	int ret;
+
+	/* put in ulp_ddp_sk_del() */
+	dev_hold(netdev);
+
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk)
+{
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
+	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
+	dev_put(netdev);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
+{
+	struct ulp_ddp_dev_caps caps;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops)
+		return false;
+	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
+	return test_bit(cap_bit_nr, caps.active);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fbb67a098543..771720c6e0da 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5474,6 +5474,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		skb_copy_decrypted(nskb, skb);
+		skb_copy_no_condense(nskb, skb);
+		skb_copy_ulp_crc(nskb, skb);
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
 			__skb_queue_before(list, skb, nskb);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..bcb8055bbb0f 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -346,6 +346,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
+	flush |= skb_is_ulp_crc(p) != skb_is_ulp_crc(skb);
 
 	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
 		flush |= (__force int)(flags ^ tcp_flag_word(th2));
-- 
2.34.1


