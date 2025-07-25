Return-Path: <netdev+bounces-210115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878F0B121E1
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC775163FC7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD331C5D44;
	Fri, 25 Jul 2025 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tnD5fpSe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497F2EE98B
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460576; cv=fail; b=MU9ZgG1b2vAqj2Sp2sNHW3Hh+gRKLbI//SqMYyXc1f8aMC63g/rpOBw5a5CQFJErtGl4dhfD69NeoWI/UeO+5vCHc3wSmnpMx/tjg1J0k9Zn6X1P7AWjEzeK+ZxgiiLiLgBTiLEdkInUdcmrw0sd3KByyQplGwfWxWB+hnC5EVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460576; c=relaxed/simple;
	bh=y0uVt7AVY+vVoM2QYs0091vJ2NRDDcYdXlhjtDpTlWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=DvoIeoSkk2+KFH7q9pLWKxGIgqfwwd51i9oDY4r1ybKKrJxm+Crt3wJ16MHqN4PoC5LYYi6HLLLRe8EeYpFTxjj93t3TykPjLRG/eGWB8kJ6sRQBB9WJbS9lCYxMhqOgbR6bBVCjcf0Ot6LUHhZyyCxPB+oVoLTFudn+GYiQX0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tnD5fpSe; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8Lnc5KKWm0Jah08TL1kOt+h5Em+ghmvauwe4WLHeL4xz26NvvZTm+6mAUpP9AIqA9Mc54FtamARUItSkC0aZhykQga0a+zwDxj5fttpTmMKUR4IsXyw3NSHDv1aJCPpA0xyhXL15DVsiE81QjA3dWnvJ7I5szDP1UoGf6nuU5G53eCKkUjrBnlrHyjShxtrgbMY8fcGbBr6STbCw1SuBf0Yc0HGACTtCB5eiO2KRHagL8ky4i7cWVHMIUwPAhKP7xXMJ3rwv4fs5JtoVqocoI6WdwUMyyURM0AekxsNuOJNgs9J3ytZg89U80uDRMczyQczlP5OdowM2QUbSIAHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq7/AbZFXyvLd51tWcSOqJ6zH9zLYoZ+0kvfOY5eN9M=;
 b=tPgwSPuSzL1/UnvHJOYIUXkPZbh3dB5+S+DXkgO3weLnSPKZkS5jNsfmkkVUMxuB+k5A+TJpLMkY/Nr/D3fzF67Zf8drvLOk6hq4Se5EG2nKx81dpHG8hm5p9vQh0WR0SutsXlfHmpCimezBwMwNa3BYDkpAfdNI1N1uZLJSJVOaVnlDcML4XT61fO0MExl7Oh+1FXAEBic494ldRgTQCTT7v32TxfuqQ9mJ9Jldvw7rdY2SfwvdT9HXmlc/X/9nLK3a63dbdIwi02E8Wr6Z1NvN/JvYVmlxZbXkCUNuz7l6vmXfAiXCq/ziluLhWTd1UG/ht2wjwvG79lq/7lhg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq7/AbZFXyvLd51tWcSOqJ6zH9zLYoZ+0kvfOY5eN9M=;
 b=tnD5fpSeSS2QEK8ilYAZYZGrZ2kcwRmb9ZdeQJ+tIT8hChZ4BxNaCgEuyHo1UwSzCGet8UpIHZdtlOOCZ75OifwG0SPRE8HAsGIZVRQQipED319cuVLbiP3oG0T4egJNOwyl0lktVX4wpIWZE85EH3PODOr52i/Pnc1Fa5qXWqGWcoDB8OjR/j7OQO7f6dQyzvqsQaSVQb8iuMxPT9/i61odb/VE73etusD/s6BS5X7dhDS7EFAe0Z7xYNawLY1Tv13zuFlg4vSJE7nfftxdYASKTZr7GTkkl0ekMugqxA9hNteMKCMjg9BPgxzHQuZY06cvJN092+Uyh/SOijUcnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 25 Jul
 2025 16:22:52 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 16:22:52 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: Re: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct
 data placement
In-Reply-To: <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk>
References: <20250715132750.9619-1-aaptel@nvidia.com>
 <20250715132750.9619-4-aaptel@nvidia.com>
 <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk>
Date: Fri, 25 Jul 2025 19:22:47 +0300
Message-ID: <253zfcs2qaw.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6f9877-f5eb-49d7-c6ee-08ddcb9780db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSANndAsSi+dqVc2sfQXbVUsgA8oAhf792XfgIOQeW1qp1KTn5l+Lj9MirZ/?=
 =?us-ascii?Q?QCD4jTbR5q8Aw0uG9sJqFKw390CQtKrSpywGX0NNaHOvSk+9NP+OJjWwGL+h?=
 =?us-ascii?Q?EiF46FKkysSUwsRFPYXqwZoU+6XAyb55wAqdVbDa1KxfVgqKofMbmr6pUUtr?=
 =?us-ascii?Q?X1eUtzDc2i+uLfWy8UYn1a0rQ4zs18rhoJ7Q5ZmzSGcwWlrWsoYYFztDnfvQ?=
 =?us-ascii?Q?dHtkFA5SPNhgiM3lbZ0/tE4A9EirJooqr5n3YnSPPGc0FUUVykROOs0FMj3M?=
 =?us-ascii?Q?EjtQ/r5nauLHsdOXQfp9fNIvpVgtrjhWdBdGD+Z/KQw7eT0QFIHpkwu43sB9?=
 =?us-ascii?Q?lY9CrGYSm5a5TXfVQJ4x7RkUfMMivvs0Ba7BrlUn7D+ZiV2Qpj6v5ub8eVfm?=
 =?us-ascii?Q?SfEhQd+Kqy2c+IMuqV0n0OUJbOODqjC9mOYFtAkYeIlpva8WEhMYRBjJ5lDd?=
 =?us-ascii?Q?tgKQ51WWJFoPfMluq+OxZ+a8EsvbvmyCxTUGpsLpn4Zh8164Sjfp0tGOgJAq?=
 =?us-ascii?Q?Ul+QzKyGmdwvRnXNZJUUJth+6WU3yF6UdL/48Tij52RGXGiXhkdWJi6Tzc2q?=
 =?us-ascii?Q?/2nl/QOaC3Stmqgg8AWWmywxckofZytVDRDA36227FEN85Furvr3cmfquP/T?=
 =?us-ascii?Q?10VjwINEs8mKof81wXuXIdlSvaTU7IeG7dtk5hQEKyr+ArX0PDAKquPkMAyl?=
 =?us-ascii?Q?bzU/7S+2eu3+izcS8nQM75PqSdmb0UcdT5PJGQa1ppuzxRpx8D3Wchhgf58i?=
 =?us-ascii?Q?yAz7c4PN98dldlp5cZd3myDXkb3k5WSY3gy4o2WCt12U+cGDNFqK+9venbeb?=
 =?us-ascii?Q?hRFP2slXsHYpsxy0dXuRhVJ/H5/dCHaMNupoNZZbTA7UIfsqSwtNMvVgC3qg?=
 =?us-ascii?Q?XVUsuJ0O3EWcHG6Ijt+j36eY+7c0K4c8+cCowkuoL3zPj2wbs/3VJMVzsXYA?=
 =?us-ascii?Q?lGhbENdowPaCTFimMyhz1wuF5iT5R+MIx7UPl1bx8HS3NE9nO8p3efzcwzcl?=
 =?us-ascii?Q?VFALt9XxgYj/DdEdQhD0DoV9LSRDHPdahzQFcpie1Y+HXmiqg3zui1ldN3tG?=
 =?us-ascii?Q?6dD9FY+IvAwwISv8aB6Qly4OOC79tZEXCRW4wHKKOBK4vTsjV726F6CoPPam?=
 =?us-ascii?Q?lJFixAqejFrRHNom/BVJISrKc1kGSp4oOjLvoEQtur+KGiNGdYf7uOj0eyfC?=
 =?us-ascii?Q?xEpvCANwCjWyCIm6/G61gxmA6KxGzkn6KV2IvDG0KpaYMap9l+nvQeZ7F6YE?=
 =?us-ascii?Q?l42+PrDaLIjAfyMmCKPgfNX9eh4M09OULBVyf5AN+N4MoXijPcEgyV6w8YvM?=
 =?us-ascii?Q?C8iQ//Zf6nooDlI/rvyFfBqVrEho0LAkTx1CeWjc9B/+k3iH1UbF3LlA5PFc?=
 =?us-ascii?Q?wPkBCcuxcAACu8dy3g8hWpgZcYZJSgmJcDPM48d5/srDW4xAX+6kLE1qZjEE?=
 =?us-ascii?Q?z1rd5kOK4RJ0c83zv2QmcPCUoo9py7cLvnxNJR0nlVkme9bZqyFqMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bf8nVLjv2Y0KTEyu1HvHTvoM/SyVBx3Pz17eyZFGGAshA07RK91OGp/s2Bur?=
 =?us-ascii?Q?BVkl8xvcAZoAEC75QwHOCYO4R1Vq/U9vxjiOE6rx2EN+7AWE6OPOxiLuQtu9?=
 =?us-ascii?Q?zI4a8H2J46+EVcV/q6mNH/7QjdHUIYP8+fIOHp6dHaS4aUumNvO6JphiclwL?=
 =?us-ascii?Q?vE4Jgd41ydtoEDBKZMMT7oz0s9UJ0kUM9aTDz8KYm0z1dGJt9/8ccv9nbjs7?=
 =?us-ascii?Q?Bw833ATepqnmX4eDNFbfJnv4SuE6KOvSc+qriSP7J7dxaB0DwwvzlqexvoG5?=
 =?us-ascii?Q?o1USGslcZ1GfTtdsJt7hxyqkdH2BDsQu2RLD/lZEi82W61cMY08yB6qnDA6n?=
 =?us-ascii?Q?gzdIOfybknADF94nWTVuChF0Rxd5F9ihMMAcsSpryAUjkHBcxm0Da35YBCI8?=
 =?us-ascii?Q?q40T1pk2/TgfX2nzsyI3ZUjy+RmD3ungMGxyz+DvzEQ/LZSv43eAkFgK9cfS?=
 =?us-ascii?Q?a0BJt9Gfiipv9oXr/2qtx7sKYS1pgb84zbfXK0rPAGq6pCr28efSUzLYyGag?=
 =?us-ascii?Q?XJ5G23Ke14zUrWfJPUF+MfqPC3EMiihNwDghFVEQiAUmaVGl5GnV6HWO0Rpt?=
 =?us-ascii?Q?7yrpC54CppO16qV4dNE8XnMREcywRQJur0OSrL+nf2vAYYxkyPy+z+FBlvDz?=
 =?us-ascii?Q?76ppDI/aaezILWBTCP644taO/J10sywT4De96emPpGCYPh9VN0fzMRo98R0D?=
 =?us-ascii?Q?l0SPshgVQso/bwniBVmY7SZaIVwS6e7abq4EZIIr90exHuIrdt9ic7oTFwNO?=
 =?us-ascii?Q?pMvsEaNI4bv94iFkjJ0SgkJ44MTsKoN1HhZY3ktlBUVIqKQpWx8lnHwuEJrR?=
 =?us-ascii?Q?/DM7+XcJCQkgl3IiYAMPgnKka5hCb/RlA8MaeDoEK8fkWrnCXGAJA1kK3Jdx?=
 =?us-ascii?Q?tsNSVnpQGIEjFlJPcO8VpHuqEnqRkiAZisVVjFIDkF4Mod6/FuVOB7EMCz4Q?=
 =?us-ascii?Q?duzehRq2owioPzIhR2OvXcCbz0JqS4oRwPX5shKHNcB5YcZYHdGZasndhMgI?=
 =?us-ascii?Q?l4QoZRZCs+IYK4HC3Xan3ubRmtXeh3W+6pXZ5o4m1+QhNaM6VYuLAIte6KnD?=
 =?us-ascii?Q?PA/MigGkWkAgnjgTgK9VVGP/d0S4CfA7hf7pjxqjJCI3OzRcwyBvNNPxt1b7?=
 =?us-ascii?Q?tUgw5/YAV+0cRoP/3wDbz6FVzjO1sGHsP8ZLZORKMy8RQ4eVB6G3+aUsJXxK?=
 =?us-ascii?Q?tG5KnxzzkajGMyXOjtIpU130cZysdGiQ7gXZNEVYLlARvGuSU1QQf8LE4DIy?=
 =?us-ascii?Q?YFl3ym0GchcuTLutk8JCIeJm616BFyQIfL9tFbMC+2DhWg9FmHaih254Hx7B?=
 =?us-ascii?Q?VVngbgxNPF49C0iszcHaFCe6Q1nL36rREsXk1QbFBoxXqt2HzZ2woCIJsMkG?=
 =?us-ascii?Q?H3VpVcE05w1Ja0BWCCIjYmgW7/uTKHnqdLUlSdMCqrbvtT41cgMzcgST+X7B?=
 =?us-ascii?Q?mAzWfVaQu1uaP4kvVyZvgIjxB5FUgGehmG6cIIXYW8JOCVrc75/R1vFyWCMK?=
 =?us-ascii?Q?1L5NOSOLB+YcIaqOcCtUKvKNy2uasm6vn6nxQm9LRj3kI30yPusvWLdV/wFv?=
 =?us-ascii?Q?GoxEKPvNf/W0Vpc0QEfpPsct427s/tsLdJdYECD2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6f9877-f5eb-49d7-c6ee-08ddcb9780db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:22:52.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hl0AP6zI1yyL6+56I1FfyFctwGeaOHJV/c4ixDJD+3dXhPSHMCvS7/ctECA3MAI70dJrJE9TGWU/FUyNdHexzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322

Jens Axboe <axboe@kernel.dk> writes:
> This seems like entirely the wrong place to apply this logic...

I understand it might look strange on first sight to have the check
implemented in this low level iterator copy function.

But it is actually where it makes the most sense.

Let's assume we move it to the caller, nvme-tcp. We now need read our
packets from the socket but somehow when we reach the offloaded payload,
skip ahead. There is no function for that in the socket API. We can walk
the SKB fragments but a single SKB can contain a combination of
offloaded and non-offloaded chunks. You now need to re-implement
skb_copy_datagram() to know what to copy to and where at the socket
layer. Even if you reuse the callback API you have to take care of the
destination bvec iterator. You end up duplicating that iterator
map/step/advance logic.

Our design is transparent to applications. The application does not need
to handle the skipping logic, and the skipping is done in a generic way
in the underlying copy function. It also will work for other protocol
with no extra code. All the work will happen in the driver, which needs
to construct SKBs using the application buffers.  Making drivers
communicate information to the upper layer is already a common
practice. The SKBs are already assembled by drivers today according to
how the data is received from the network.

We have covered some of the design decisions in previous discussion,
more recently on v25. I suggest you can take a look [1].

Regarding performances, we were not able to see any measurable
differences between fio runs with the CONFIG disabled and enabled.

Thanks

1: https://lore.kernel.org/netdev/20240529160053.111531-1-aaptel@nvidia.com/

