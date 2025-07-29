Return-Path: <netdev+bounces-210757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E899DB14AE2
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26549166A74
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8494285CAD;
	Tue, 29 Jul 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k02rIj9z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35015533F
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780399; cv=fail; b=gsVLiRIFnhBKamLj5v05/Ue7dh7BFlDA/ls8FOU8k20hzqKdMFxg/o2hHHeUc0XlC5tlYKH6vbBS/qnQelhLepr/bVCSJ0zfu74oU3c1gaj0iWHI8PA/Y6A67efXiUpKYx3rI+wxw+vaxYy2J9Iw2Tk5m3gkuvfJeoh3RQ6ApzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780399; c=relaxed/simple;
	bh=YihSRPWU2AxW1NHK+CqG65mD7K7aCJKj9sLfy66StY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZ3+qiApAFbwQnkuRowHy0ZBcaCgUwpDYUfOiL8Q9p62l71rM6qVijnU0tOsdZM83A4ecNcI9xeJJSILr2vLqYoLw5KZJmDPPFEmCDDvWmPJxYxaKcylHseUjtfiWEc3fnjhvNuuMehQngy85W0zxLtzstdsi1fepEMME6URoMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k02rIj9z; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwCPm8+FHuyYFF0N7WMxEvv1uDc59ZlZoiHEC2udVktrj/xece+QxrQOwxwXafASHLBySqBuqcXQdE62ZcX5QBt6G8uFsbrqcUYvid/ww2m902Ah346X3yFuBqz2RFL6yz/S9GvYklj8tXRmgAR5UnXhCsnEHgi5DJppdR+czjPxDYIz3gWRudCE3ubz0MLqWmTZUbJM7D531djyUlIzNvysaKiIxAsgLii9vmUTpVBDJjZbzEuXFP+FPhxnsVUL2lI8sMglCLhr20oGrt8GpY5BdF5DJaMx48yDMuxnBvbQTTVdoi7seU29/X2fGoWNU3EmtqP1N9IH5WadeTkAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaMgq38WqrJYGlpUe57SqosN8GRCT5YI1GaQnjoSeR4=;
 b=QJegaeglNRhdKO/7GeCGA9oscXAL3ki5DufskzmTIv9u4aMwR5YxSnKwlEpIK6+kP8zAtenUkKK6EwCuAvxnCY13miQ6oflTdCNIOeZ4HKvApVdBtdk3N3RlkzHgYNzDRvhHZ7gyidegValZcFdXQxKSQaMa92uGGdpn2twbWondf6WxYpenynqdJdtNkTVdYHlWXd5lb+xtPkfIYxJT4HqXbEc5Zo/opMgP8N8AkFgA8GFABT0kxvdZDTn34fF1Oi3Aj/9Ep/KLuIVO0wxjz9jW9p6TAFALBxRC9dKuKf1T9NpUrla7iDFTCXaKzZ/DVIH0+B1G4eGGsjArVnZNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaMgq38WqrJYGlpUe57SqosN8GRCT5YI1GaQnjoSeR4=;
 b=k02rIj9zUobpoJbjmqDWobAjW8lUiOdUY5k++iW5rPa9V6UkbH1QGEynGXduLLY7TUXRQOtr++WhcZMJcXmgfzmsvQc+ydSErzBxJhfYJIRo6jBVGDPttDpdmKrnB8xpLJDON32PNDGTmS4mAIuAi5YoG7izWNMJG/mFgXY7wgwqTTj3kdRFHB1IWd54V4IpsBp0R3hEo3vDMIHG0mJOccMuTW/YH2fLniMBcE1j5Wtitn+X5uOOETGAgykQ7fZDMEAv5Uc2e7qZcwPYLkyNxQ3USNvWeYt5WCDgwVV4Xqbc789aBanjzOpMDdQb0RWsI1RfAi9/zWY/SeQ+21YdSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 09:13:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 09:13:15 +0000
Date: Tue, 29 Jul 2025 12:13:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, donald.hunter@gmail.com,
	petrm@nvidia.com, razor@blackwall.org, daniel@iogearbox.net
Subject: Re: [PATCH net-next v2 2/2] selftests: net: Add a selftest for
 externally validated neighbor entries
Message-ID: <aIiQos7GRGTPjZgy@shredder>
References: <20250626073111.244534-1-idosch@nvidia.com>
 <20250626073111.244534-3-idosch@nvidia.com>
 <20250728093504.4ebbd73c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728093504.4ebbd73c@kernel.org>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: ab130a4f-09cc-4f14-09a6-08ddce802698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4TzeCW3M6H0RqcQ/4ObDRHjNr24JbN+FSlFGDDshT65RKuTXs09kJUBaCIHL?=
 =?us-ascii?Q?t8Tno1Uc2KrXqUUHn3GCVa68cPgAdfI0F+p5ZkdDH8FriW3qdaRO5zeEdlqS?=
 =?us-ascii?Q?TM9Gtf7IzJIkIEr+Lk2hjSQ16j/6ijxKZkGKYVVULy9LZLt/gwYVQ/3jjXMl?=
 =?us-ascii?Q?8qvqptjQ9/Mh+jeQPidQckjc/u9kHwESvxwOmoh0XoEVQWc2W0aKOHzs9FMl?=
 =?us-ascii?Q?nSnBp/cG18zcE/vXKGm7g5y4XMzS9ElTqxJdHhhEIFwg8EZAJKZ2lpJyuO4F?=
 =?us-ascii?Q?CjK4S6fY2bF6TIxVli4+GPz5fyQweylhFMb3CZr8q4jG80xSlBmMVMieF+SM?=
 =?us-ascii?Q?5k4WsEfqQDwTOr3a69FyrjY5iCDL/gdJwE1M2jghglKTMDEzB7KM5aktqLPZ?=
 =?us-ascii?Q?ijBmLiE1TsIuIsgG3t1yFdlTb6Giln1OtH4IZXDRa0NCu7gW8j4oXqxiqR6/?=
 =?us-ascii?Q?eak+5WsKc6sxNq2dcUKi87EaeOg53VgBjtlybQq+8m3QMZms5swuKw51GVCb?=
 =?us-ascii?Q?vCWobjFmaDRN/9zeJZHm1rcq1akA4fRRtui4t09Q4kTD3q8+KdhHEVR6PIsT?=
 =?us-ascii?Q?zlUu6h30WAaxJ+/nIRFXD0v/j/kI7C0ikcB9s3X0v8aHkDOH12ft69j6243Q?=
 =?us-ascii?Q?6bvA7dVVDCdSQ8rCCN6kx25Bnowb7GalD0SrMC8vNIalY3TmJiFNwbVHCPuO?=
 =?us-ascii?Q?1tyjFvvZ0sz0TLJGuh1X8khnBbO3ogWzWiWIqGfkySZBRKW3GwmJ412zmU+P?=
 =?us-ascii?Q?rrwvPfAuMXEKaMpAr2ognPijTZp0LS/hAwco3LVbW8J9k9M9+mQ0weeUnT18?=
 =?us-ascii?Q?gMFuJMWPOGuYgdk0n30PMCbE13Yk8wvrES6PFxMhi2itloEYnes2zFXSacF+?=
 =?us-ascii?Q?+1bFHMHKexHdULaF+KhZvGHsdU+mBU1D6bKLH98sMj60vquCKbRS7d1toxVL?=
 =?us-ascii?Q?3bQGbApi7tXG9SKrMFguUoWxfBN9eqN5t/v5pvzkPd7ePRgqsvB8PLgHTC0F?=
 =?us-ascii?Q?HFOz8jl9drvGp44IkYvZSK8dt571tlocaR/Snj78ZiJpfiQQqxEnbTF0mZIh?=
 =?us-ascii?Q?QG/O4b5r3X/9KorzTJxp3UR6MK1Y0rifqz9q8AQK0ZzoybuMe1QeT7/jdcnO?=
 =?us-ascii?Q?5jWhpl2H07OAHptCJ8M0+do2j5Hc6diD9ZKJzEsggh1VDETc5fq41o5nG4/z?=
 =?us-ascii?Q?piX1tWM5CR7VLnF+MLExlJsK/mxbDEipj5uKaiKUljh7PWbVjCJggwamjsEv?=
 =?us-ascii?Q?P7FlsJ8VQujwABrs27Rap8MD/pEkphmS86P6IMuEM+qpjtk2DOGAYLiccVB1?=
 =?us-ascii?Q?vrrTh0atD/tYxX/gubidRo3K37uzyCz+uyW8zZ3qq3qG6xiTESKKZptXnIIF?=
 =?us-ascii?Q?ZDClDqPXlLriVpIUlFpv6JEUa/8XGZDCMlg+bAO/jJLXBiZzGEuW6vOGD+DX?=
 =?us-ascii?Q?Vvivj0r4BR0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1KKZacNg1vvzUABcwqizMjpaUzIfq9mxboikhtDrtb3qfj6uzU0HGUQcW0Yd?=
 =?us-ascii?Q?DvD7UOV51Xo/VYV+vN5mkZEW//x8HGZ6iq07fiIZRJfDs5qImezuRnmLQDFn?=
 =?us-ascii?Q?30CrucJBw2oO/BHj+95Yx4ZCc2UkamG+a1Jx3oquUa7Yqnwa5ZGdBviUr+9i?=
 =?us-ascii?Q?/xPJ2JXD+X50Eq5Ydn2Qnc49sa9VsPC7kFku0dd6VQggBzdhVW61V3D7G7AO?=
 =?us-ascii?Q?DL6sJlMsJVc6GnQECSd7lAM1uenGNYkfjMYx9GRqbhJogBCT3tY2ocCyxGZW?=
 =?us-ascii?Q?hGbGguV6tC3ooDhNu+pb0YUSrCYa/UcVaAVSljsR8qZ4PcMWUMosJcypoTXW?=
 =?us-ascii?Q?vz8tKJ85gmTKuBktQVzbezIyR4+o/w7Tq0nMjOsqijSubxsqLp202isC9bgW?=
 =?us-ascii?Q?MSqVKQ95hacrT2zHhTzEjLu0zAt79Uizl6pXdKJAatSWmfF19FLTSJ4ehbzq?=
 =?us-ascii?Q?YDEPf7jvVVWWbqZ+b3h/rOR4yj4VuSGvqYcCgSDg4TcBj7xwjfpiFYumdw3o?=
 =?us-ascii?Q?HVOJd6qfQAwPKS3URunY9Dbal1H0uE8vBuJ9Vn/emXxFZQx5vTRhNGjLcG6P?=
 =?us-ascii?Q?qhXdVFGJW86G/5lzYHS3Zi6gobwz34onex38/BLqFdSJCKoQL6HiCeYMpKct?=
 =?us-ascii?Q?ZcogiyF+YeZSPWUkGkByIudpFLGOZgRELB+cQNzHVeKv1fSqP+DHbdP2TbYl?=
 =?us-ascii?Q?k4MEPEcGVZEiK7+o8+sqP/iJHB2bpA3s8OCY+PeCmvGQcaqE2j7i1FVN2qBf?=
 =?us-ascii?Q?08Uid5DUFcnRAFcWAIOUw+6vi9efEn7a0zNedOOpe4HQglVGzdL/kss2eZZm?=
 =?us-ascii?Q?t7wn1/uXCiC3lxUbdfw2k00ZX0QzF7/mZRwbl9yl5xZPJkqLaRBpqnnvJccn?=
 =?us-ascii?Q?tslNlRtfoH93DhvfOVCrAZJD/FcfGnwr+cyz/PLX+bqCOg6zC4vc5yNfEFbv?=
 =?us-ascii?Q?9PANqupQOPw+vSu4UUDOXYDx9QFcBCbY7cGFIo0mnpKbWsDnDA2UR6I4BzX0?=
 =?us-ascii?Q?kWh0hUg2CBkq5sMRrbvRcu5PEU67dl1eEVQ5pI86VENxIkkldWjQND5YO8zh?=
 =?us-ascii?Q?wYoBkxrFus3moL8vUprh95i+KvNiW+8Kcqnw02vDqilrOWwb6/X1uM9PR5vD?=
 =?us-ascii?Q?L5GpJv5k2zlViuw2RVRgRZ6EksG+7Y8dUpBaixood/30pkDqAD3rnwPZND2q?=
 =?us-ascii?Q?x2G5lb312BdQu+xLceMw85bXTIhD6xlV0sIBuJ/zI0gkjsBs677XcmGNgTsg?=
 =?us-ascii?Q?3PM7ektPQxM7LtulEz/+sCLl8iHKogEAGg6s52KfNPCskVJfCBSdrj34K159?=
 =?us-ascii?Q?7dfiv5kVuiDWhh3XXgkXRMKamWfg4UH/iwVHP2wYvQuQs3cpim1oGx2NVcpV?=
 =?us-ascii?Q?lH/qP/+SIe+q+iCizrAMTrWAeIBalICB2LLfc0LPbee8KPp5JYXmf7Kfi+g1?=
 =?us-ascii?Q?YXD7ksS2wq+6/hAvkAC1k2dCG/yI11JB8yH9kEPYcmU79F3alegKurvF9G2i?=
 =?us-ascii?Q?yHoHax7Scj/gntrgo1FF+5xFxpHeyi+T4BrRALirt+G8CGxY/abaIE8ebtw8?=
 =?us-ascii?Q?bsvXrO65lMQflT4dBq+oH9N+/WUPQLKEl3dyP0u4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab130a4f-09cc-4f14-09a6-08ddce802698
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 09:13:15.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf3tSOsKHQJMkhXjvrBmKobLlaj/xdRstRIdNrdZ1ajbbshtfZrIgCLQHiuGqeFvt+0KumZqdkFBkL/dRGY49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

On Mon, Jul 28, 2025 at 09:35:04AM -0700, Jakub Kicinski wrote:
> On Thu, 26 Jun 2025 10:31:11 +0300 Ido Schimmel wrote:
> > +TEST_PROGS += test_neigh.sh
> 
> Hi Ido!
> 
> This one is a bit flaky running on the normal/"non-debug" kernel:
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-net&test=test-neigh-sh
> Looks like we get a flake for 1 in 10 runs :( Could you TAL?

Yes, will check.

Thanks

