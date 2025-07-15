Return-Path: <netdev+bounces-207104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253BB05D30
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474A27BE783
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E02E4244;
	Tue, 15 Jul 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJTS9Q6Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F82D6419
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586097; cv=fail; b=IMk6LovjcX/ADGCUmEHH+0WuP8kfqVGqonC5GdgLISgRCbmv7qKgqXvzyBksPFSe/IyonHkpIoXf2/6RbCCusDylGOAACN51xUp0CcGaK0lbnmokVWb1VaGjJFS1I0j35fl8gUqrevTNQxfP7qKRlJOmxBMSDUzQHnqjz9BkBjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586097; c=relaxed/simple;
	bh=1BAO/fmBmbYrPb6HzWlaOaAWTGavvE6Pskdxb6UdidM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0eqU6B04CohLJ2lDFgs6gQ7Fr/5A6KB7BakYEgywhmh5m2t/qwXQXGj9iPzNNKSQBzH4kRtab9N2/NbIn3rRhKP4SqYFpnrEHmcR1w6C8YVIgmBi9gMuRr1wj2mX1Na821scKkPqCCI8O8GnLO5iijc4kKvp4OYlc947+2WYnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJTS9Q6Q; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K80zU7Z5FitzRje4X8HuwK+B5JgJMq/a8FVivkElMGoaeVWjetBAOem/WGpz/Nide7STUUzOMdt2hJpTa0dQaHLdR8zhtJxxvPddRrN1PGxHcVIoITH4nw5+GXBeDLzDmeOtS2Gzn0brAYM3kA8NPjRZUzukFMY7nbVJ29PQURZhc6JyRbQEi4gsVNjMe6C3M9sDsSdPOEco9swSqpuqdYQHtH+Kff6UhJdM95mrctB7QE5eV0uEa5cULpRGGPYxwLdShpKKLpd4loHzvWSve81skXC9kT16YgHQ3MOQAgkwxcnODBpBe9Bj/l/L3ZfO88BHh+5Y+wD+4p98VUA6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfnJp89iAKlsYnN7YP5O3QSnbtHrGGZvbJMmzJ97RUI=;
 b=LmA6SIOSQ7mhc319jv1oE2i7rr5MZu3sJzffHWb1fhWN1GwrzgEml5DPnZqoSWr0MaFqy8V/Dl0fORP9kR9ieyEXZjRKwUZGHsjncNF91mT6nYgxmCUaaN9ms4C11Tf8KR8GHVzv1sbdRvq6kksFEccB7FPIdB1YKKnrCyXWxjUEwRNhxqhrUypENr0rLRlHQDpaiXBdrSmUUed+HqGmWKLUxe1VEGynpmn43hbmHoJ4OwEK/pCr7wdbHwvWmnKE96QQ3yQPecxqfZHKS/VxkikblH9Il92/GxFm+OY9yz2zDv0CehkrVFv3QiOBGyl3h+d5xEYkLnEBdGjETx6PPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfnJp89iAKlsYnN7YP5O3QSnbtHrGGZvbJMmzJ97RUI=;
 b=bJTS9Q6QWd749QtXuPXG/sm9v05oekOTniV0hPwCo5DYAwhkohAf3uVHWrqWE0xauOrYWOeoyYeek6REsVZvefY11bPgUUAYSETyUNuk2ORa8spPp5WAOKhTr0Tid3CPuyU88COrMTuyAsKJVr+JIjD5TcdNBbcIuO+/f5H0dUA0rkzFYgF7scVWu6VSxc7ZnShkKpkX6Egnh2rnDC77qSthVAZtkOiHogwaIlZKrMLANN6oSrDxLgPu6Zwv2R/10DU0S0l5wIO1t7A5yf7eviHnTFxuePHkKaNFxdrrrpjLQBus6khQa94TxAUyE4cfq2A/POphtA7gzjhyxVjFCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:28:10 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:10 +0000
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
	tariqt@nvidia.com,
	gus@collabora.com,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH v30 01/20] net: Introduce direct data placement tcp offload
Date: Tue, 15 Jul 2025 13:27:30 +0000
Message-Id: <20250715132750.9619-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1ed550-e3d6-47a2-20e5-08ddc3a370c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmU0NBPybDBkA9b3JTcb+aWZLKcHdOciV6TadeXCFgGFSVVW/RbQEd98sX69?=
 =?us-ascii?Q?mG0+SWDQ9X6ybe9tODryoYCwjN1HsiFa81yiF6gTddidv0xz2Vd0HeSqUZ2P?=
 =?us-ascii?Q?7TV8pRysqLDnavvRiFuj3m+2mbyZAw834/3pTkTCX2qxdPOZEXYyG5mytqgN?=
 =?us-ascii?Q?WRPZeGEfiw2pTWfKFJiX9GekQfzczGkXolW2TbL87IOLDTcQLlngKAFSGu/X?=
 =?us-ascii?Q?KQLztaqiBvfpPysSm80A3n0NCV6KEAkXi9XZ7qUzFdor1TWhhlGkxVlzhBo4?=
 =?us-ascii?Q?8Wa0XWPIyTF1L+Wka8p0ETAZzTp1NAbyBvjIrS/LDFYaVI3S635ouNc/Vgu9?=
 =?us-ascii?Q?zY5cUVIeywO9qMV8y41Xh67EKyvTfe3zvnwRQAL6Jq/cPqVZUC84eYd4hf3f?=
 =?us-ascii?Q?WWFopsasYmyaBsgfCjcAqQ+GzpzA9lZZfWY8u+SE5yJzEa2xds00Fc6v2/St?=
 =?us-ascii?Q?jBdxsUBK2KQ3c2YULHFCNziIKKSRFTdAwVUWoJBoi6ppEUOAtoPbekEDOOYu?=
 =?us-ascii?Q?arvtQLRMWEAQhDixM84glB7ICU4j/dlVJlKQRNJwJ9YBfcIVhYKFvsa47Esk?=
 =?us-ascii?Q?RTfkVqOg8h+8LMYXHxG/OSOxIu7NSSsLOQpi4GwMyx6FtDwwo8T+w8FWlpyu?=
 =?us-ascii?Q?0Dg4eEjKzpq4vqqLndK7Ov09kqt2R/glqbe2p/RON9I9c8cy9Wc978Oi9zfl?=
 =?us-ascii?Q?Pknlps+vyHoCU1TJTUewaaiYdfjgka1vkEL2oZzCF8MafTxR4Otq8//oZDUW?=
 =?us-ascii?Q?Xckc6L2jG1+GNcN2Bucp3aLgA7IWsAUmoTqf4D5Nu9Rg/9EcnfiOX50KdJj2?=
 =?us-ascii?Q?pxifZwEWZniULIm+70p1HIx5k6JLbUrM14hPbmCx3cdoZ0JVRHQv5U/x5SUs?=
 =?us-ascii?Q?5sofdFRwONkggTKTeVEKJemhhUk1aRViaf0z8nleVat4tyBOC8BFXocN201i?=
 =?us-ascii?Q?bYhai9UAYq3wLLwfNDDrD+UjaHlgRMNaC7qJbiq6s0dpIm5ITrnCPEkHY/LG?=
 =?us-ascii?Q?oS+NS89qkYGYmxfLWmmK7ZNQHUDmsWUpSSFAgUoJJxHTd/Xyn0FmYt+NNaeh?=
 =?us-ascii?Q?4tNvHcOcATrg3IAucz4FuFELAC5YpWHigTqGxSDVGNFfSOJSdS8QBfdi7f7d?=
 =?us-ascii?Q?ihsADGRKDsg4qy7wE/My4Qs0pOH+Xz0xVkeaM/c2ubESkewvlGCweVDaff1S?=
 =?us-ascii?Q?LawMr0G3TnofMopSQbgKMlMI+ZXLyxytA72USfyoI3bK6NRs0A071NnlbTsg?=
 =?us-ascii?Q?hAZtvf0+rirmypBqSaXDUqcjAKR8cGOSSKmzfn8tutuWPmy07/Abt+939yPh?=
 =?us-ascii?Q?nrdy36RNGYkM/eDU2xB0fGb6vy5sV5suOkoBZ1qc9DDsMu4sO4m5wvsblueG?=
 =?us-ascii?Q?WHAXbbioozDzLq3NyjGTzntosnCqiPd+PVsjTkslUQevJHFkGYAxeO9nFrWg?=
 =?us-ascii?Q?UBuhUpeglso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vz7eOeaSBBnjvDWBJf3dNhr9z6UqS58fqp403L+PjftGp+AGrGc1UL1jLGM4?=
 =?us-ascii?Q?U3br1CezcdmCAQh806XOfhRCEklMJ+wckqpEsKxzPqRIXxqLFTwryAxnhHwZ?=
 =?us-ascii?Q?EdghMYc9el6zw4+JePksRfEowwXLt45biQwoHEIzcr8u+ISU1+GdN+AmrQR6?=
 =?us-ascii?Q?x7gUGqDjBpTT2/7sIij8CvYb71b/jQwzwtTdsWTrwv3akxJE2AkGOpmeczyL?=
 =?us-ascii?Q?sWCUuPYeN+Gu+0N7NUjNbfxHMdkbDGvtGtWuGDmaz0sxVwjGr/iC6E3UbU5W?=
 =?us-ascii?Q?iDgqXbaSXf+r1qKdIkeoDHXgrcWPsUK8whn0s11NZp9jVgx/TvNE9PGubU0l?=
 =?us-ascii?Q?zqQKHUD18fvD87bQ18Zq/3R0eZmnYfYJkjrGcnDS4nEezR4WUEqZbl5jEfWU?=
 =?us-ascii?Q?RlzouJZVGvT1MYi7whaGTNmRFPeIJxIsh8UQpI3Mo6Pzpg8048V5zi/LmLrh?=
 =?us-ascii?Q?CSiviyB7shR8rxcqqbw8QZ4WgVQXlvZYtEdpTVS4O4lyP5LQn3ZTXeECtoZm?=
 =?us-ascii?Q?IICWMRhFDvTJQ9x6YS9OzjQn2+CAOqQyEFQJTTm0Jp/HSCsWX75h1DrEFAcV?=
 =?us-ascii?Q?lNLZN70WU+Uh0tApAfQs7oVP8ERT1ppWPWb2BKBZP8iadDCUDHtLnxUNY6QD?=
 =?us-ascii?Q?1GCAFPkOyD4h6ehwpAd1AGswPLuKwXCfT25+ftusMyXu74plP4DKVD4e3wt0?=
 =?us-ascii?Q?09jx2MpzFQBxVaHdOqGAKHquXe0k+hl3+ppwb4VX/6UrdPrB4fBsM00cqz9Y?=
 =?us-ascii?Q?EN5VxTaxNHyk2n85MdKSVWlvCiclYR6AFruexCQ8H1P1ZdnC+XpLQT4kT+cM?=
 =?us-ascii?Q?7nCdyKdpL8YTzLTxi/Vc4kfSMCvNNIMbvygsm4K1UaJ8R2lhdXh0HzNAtN+W?=
 =?us-ascii?Q?zxE+bQHaxnsghsUPIKKQvu5ZZMkU5gT5HFJUSqsZ+7758yKFJiOk0CWmaDIU?=
 =?us-ascii?Q?j3khLaeJSFUQQtWZm4NZFiVKDvCmegdFtgxjXe8EyB3rACdQwsm+zKJaTrlF?=
 =?us-ascii?Q?+GfSd8JNhQSm8+mcwS8Gea2x1NH99J3eI56t0WcUt2SUELqvZW5raLwEIea+?=
 =?us-ascii?Q?iHq+56BUVcIPf8FgYtA/GehwJSiY3kAzyIooZjKqrACLb2fAPEpToREpyCxy?=
 =?us-ascii?Q?JGbHhBR2n5XPJAcbBGI1N7baFdxcnQV+yTUEYvjQEHj43/QjcuX2LJ5LRwaY?=
 =?us-ascii?Q?Uvb/i8wnXYrDlRCDa7sVD2kHyB7QT1bLDFhIMg10UrrBLx2EslbQR8tVcbFk?=
 =?us-ascii?Q?0Mr+k618mjB+nq3zvp7e+0LpHkwJjlyaVkeed0r2odVdkHk5EDNR7RfZIybv?=
 =?us-ascii?Q?e4Lad8n7OetIu37j1NJe9gNhrZXrfLHSAdnpeRILuLgGfv9GcXN7KGWovY3t?=
 =?us-ascii?Q?pQysJsXRHCl2TR12O5uMn/hL+Ga0ZPgNTvqo/EpOeQE3J44DvxQX5P1pnwJR?=
 =?us-ascii?Q?K4+idof/B7oNL4fAvanYA0eRHlc5I2YMlJlQM2Cn6HTfDklhnkqsV+NAeMo7?=
 =?us-ascii?Q?fUffehRhH3b8+m9D4UU+fRwLVfHneQp0iaRys0wzhUVOZF+vwkxaPDc07y44?=
 =?us-ascii?Q?HUswbutsMPnF2YGbh5keWuR8ZZqOwlXbqbVAuxxi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1ed550-e3d6-47a2-20e5-08ddc3a370c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:10.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZhc5Wi8uifBdnqLe5yTDKdM2bBrMuU86ci5RTyLNQM9N52W8UbWth6TUdSz858fm9WqKgmvzxNkhC6OrESLrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

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
skb_condense, we mark the sk->sk_no_condense bit.
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
 include/linux/skbuff.h             |  31 +++
 include/net/inet_connection_sock.h |   6 +
 include/net/sock.h                 |   5 +-
 include/net/tcp.h                  |   3 +-
 include/net/ulp_ddp.h              | 326 +++++++++++++++++++++++++++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   4 +-
 net/core/ulp_ddp.c                 |  56 +++++
 net/ipv4/tcp_input.c               |   1 +
 net/ipv4/tcp_offload.c             |   1 +
 12 files changed, 456 insertions(+), 3 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e49d8c98d284..9897e974d7cf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1402,6 +1402,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1657,6 +1659,9 @@ struct net_device_ops {
 	 */
 	const struct net_shaper_ops *net_shaper_ops;
 #endif
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops *ulp_ddp_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b8b06e71b73e..264f8babc028 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -847,6 +847,7 @@ enum skb_tstamp_type {
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time clock base of skb->tstamp.
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -1024,6 +1025,9 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+#ifdef CONFIG_ULP_DDP
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5267,5 +5271,32 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize);
 
+static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_cmp_ulp_crc(const struct sk_buff *skb1,
+				   const struct sk_buff *skb2)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb1->ulp_crc != skb2->ulp_crc;
+#else
+	return 0;
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
index 1735db332aab..65cca0d4d6c2 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -63,6 +63,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_af_ops		   Operations which are AF_INET{4,6} specific
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -92,6 +94,10 @@ struct inet_connection_sock {
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
+#ifdef CONFIG_ULP_DDP
+	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
+	void __rcu		  *icsk_ulp_ddp_data;
+#endif
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6f..65ee30a6d058 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -266,6 +266,8 @@ struct sk_filter;
   *	@sk_sndbuf: size of send buffer in bytes
   *	@sk_no_check_tx: %SO_NO_CHECK setting, set checksum in TX packets
   *	@sk_no_check_rx: allow zero checksum in RX packets
+  *	@sk_no_condense: when set, skip condensing skbs from this sock (see
+  *			 skb_condense())
   *	@sk_route_caps: route capabilities (e.g. %NETIF_F_TSO)
   *	@sk_gso_disabled: if set, NETIF_F_GSO_MASK is forbidden.
   *	@sk_gso_type: GSO type (e.g. %SKB_GSO_TCPV4)
@@ -507,7 +509,8 @@ struct sock {
 	u8			sk_gso_disabled : 1,
 				sk_kern_sock : 1,
 				sk_no_check_tx : 1,
-				sk_no_check_rx : 1;
+				sk_no_check_rx : 1,
+				sk_no_condense : 1;
 	u8			sk_shutdown;
 	u16			sk_type;
 	u16			sk_protocol;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index bc08de49805c..7f7bf9668a44 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1147,7 +1147,8 @@ static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
 					   const struct sk_buff *from)
 {
 	return likely(mptcp_skb_can_collapse(to, from) &&
-		      !skb_cmp_decrypted(to, from));
+		      !skb_cmp_decrypted(to, from) &&
+		      !skb_cmp_ulp_crc(to, from));
 }
 
 /* Events passed to congestion control interface */
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
new file mode 100644
index 000000000000..7b32bb9e2a08
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,326 @@
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
+		   netdevice_tracker *tracker,
+		   gfp_t gfp,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    netdevice_tracker *tracker,
+		    struct sock *sk);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
+
+#else
+
+static inline int ulp_ddp_sk_add(struct net_device *netdev,
+				 netdevice_tracker *tracker,
+				 gfp_t gfp,
+				 struct sock *sk,
+				 struct ulp_ddp_config *config,
+				 const struct ulp_ddp_ulp_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ulp_ddp_sk_del(struct net_device *netdev,
+				  netdevice_tracker *tracker,
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
index ebc80a98fc91..803c4bfda43a 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -541,4 +541,24 @@ config NET_TEST
 
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
index b2a76ce33932..6d817870d7c3 100644
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
index ee0274417948..ebeafa42cb35 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -80,6 +80,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6939,7 +6940,8 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb) || !skb_frags_readable(skb))
+		    skb_cloned(skb) || !skb_frags_readable(skb) ||
+		    (skb->sk && skb->sk->sk_no_condense))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..c02786ed5aeb
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,56 @@
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
+		   netdevice_tracker *tracker,
+		   gfp_t gfp,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops)
+{
+	int ret;
+
+	/* put in ulp_ddp_sk_del() */
+	netdev_hold(netdev, tracker, gfp);
+
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
+	sk->sk_no_condense = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    netdevice_tracker *tracker,
+		    struct sock *sk)
+{
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
+	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
+	sk->sk_no_condense = false;
+	netdev_put(netdev, tracker);
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
index 9c5baace4b7b..d69f974a1ee7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5390,6 +5390,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		skb_copy_decrypted(nskb, skb);
+		skb_copy_ulp_crc(nskb, skb);
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
 			__skb_queue_before(list, skb, nskb);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index d293087b426d..77ae71ea25f6 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -353,6 +353,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
+	flush |= skb_cmp_ulp_crc(p, skb);
 
 	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
 		flush |= (__force int)(flags ^ tcp_flag_word(th2));
-- 
2.34.1


