Return-Path: <netdev+bounces-94054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D38BE08C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F29B1C2368B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B279156C76;
	Tue,  7 May 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYdLBzcb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE315699D
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079506; cv=fail; b=PGzk97QpQdaYc4MM9maKQsT4SHMozMcqgTHr+PXlZ/L10bwJhJhQoaG9n/RNn/oWY/7hBga/eKpp3XC4DBn9dMNZonEPDPqpl5wkyxUo4UWOW20/B0ni46JmEOouTBNbFFS1SpZhxcXo5pNZKsg71OwztoEo8CVRRPoMB4+MMLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079506; c=relaxed/simple;
	bh=9qIgAIMDoTGEIlYKKnySHEKaMMGGUkY/jGowguE8mtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XGHOJrlEQwbSlKuGHBbiz11NN8kiuH0MT4I4r5wiMD5V1TGrGOOHLs1kr6PGdIwHwzRlVwB90KM4tY1O3h97AUfSZWYh17I2BlD4GTvA1lNm/av/hLUsgOnMaRxtGvyGf2l0rcH5w2Do5zorto0sZQu3B0FjvOLyXASf6DxpqyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYdLBzcb; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvkYA4xx4Ah1dZKZ2UKXIkTtc9Y2uDrR/s9zJhjKeApCxuepwFhAE32DMTW4gVuIO7GAgns0FKml5Jb5EBDKiTst+Jl/F/bJzvtcXsQVZLJms3CgqBE6lygsoKVlmmjGhi86Nd7eoxIryZqU8A9oIHFmOfA/e2F12pQ/VPWfs8nw/hB2ndXk5EiX8D0itMphcuuesUSXXaRH+R+IxYpuz6594vwGFrGxX60roGo7QNL7rt4YJdiGfmLyv/qYP8j4FqPkd75X9Fcn/ebexro8JMIdIMsgIm52b0HguvPjzN2c/niF6lGj1nonZ0XCrctJhm1XyU2+70WP+nJMsWZXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xETsI8du2dmmFRs1qcJFnxOzch3EIYtRAS1SmVAATLw=;
 b=obb5jAXzUKTeL+LS3eov+SKyXiARa7ZOEHPhP8kc2eWt0ut8dPHHqMyf3jTqQv3TGBMNi14DF7X+LleW8SKBOIrldHL3zH3viB/gdsHK2040yTziaVuLMTPkXbxh6NB7OAvLm75xpi0oy55J1DvBccgUJz6AcHy8TTnqyU8ppTMOXjnJmj7OaaACUmOpLcndIOiMeEtY4R6ElDwN9e4Sa78ROu36+kthJByITcf3QLD6WVXSONeVCt/CK9Pe9oq6pJKpkOST3P6YlrpTzF/aEGWY8Nnf2jjXs/KaPfgnvdUjXsniYgUrDAeYfzauGAcx8gcseLqOqXI/iPFE9pjHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xETsI8du2dmmFRs1qcJFnxOzch3EIYtRAS1SmVAATLw=;
 b=AYdLBzcbxP9R7rpcFAEgAAdXIbb3/VhtTdKEVnXYLRXY0NWPloEqSzpqUqZySsnehjtRFM4Bv6XYz/cdsBP/ag6aLNtWqXDoL8MQI1lCR8N1N5e6E002WiTpWSb4F4zl19WiYq7X8OI/omWrlpbvD2IMMJidIHeR/tRzaoD3gm6mwOhf8t4y1fP0BhhbeoyUkFWBfEVLLotAf00r4MA1TxOtd8GPDrZ8Fp5/rrysR9YbT+6zZ4+EN2bsOT4JJfJd+9xCsiTCjr1Cf1FbK/sSiVOHg8JmiMv99rMx7kZbJWOQCuW9Waaqu2AW4phFVuypbjYamnWdRFNluBCTHiXGgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Tue, 7 May
 2024 10:58:16 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 10:58:16 +0000
Date: Tue, 7 May 2024 13:58:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, razor@blackwall.org
Subject: Re: [PATCH net] selftests: test_bridge_neigh_suppress.sh: Try to
 stabilize test
Message-ID: <ZjoJPxVOThaGKTZO@shredder>
References: <20240505145412.1235257-1-idosch@nvidia.com>
 <20240506063613.15568681@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506063613.15568681@kernel.org>
X-ClientProxiedBy: LO2P265CA0396.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::24) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b092cc9-4956-4395-dd9b-08dc6e849925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QmGUjjyQJ7qYXtPAzDRN6/mL0ku7VjSz2AvOx5PADgQYRLU6otdEQp9+dOMw?=
 =?us-ascii?Q?SWMJVx5jKild7SRbIcIg93C81MkAktBknfK4O4cIaAknW5KMsABTnhWsQJzd?=
 =?us-ascii?Q?YchNp4CYXJFGeD6l82yfewTU2v5uHYvY738QK/IMHE5Gou66cEfnH5I90fGn?=
 =?us-ascii?Q?ttwtJ2JuFF2HMLu/dhuitf4dsZMgKxck7JHwei29IMbfEEfxBniF4O0kF3Kn?=
 =?us-ascii?Q?FUKnqyR70LRIGq6+wtQftHIvWNSOB0O52lYI3EplPYPsvaYpkC3k7JoZGEs+?=
 =?us-ascii?Q?DlvYjxVhOg1O8F2DCu+WPxn4fV6I4WWPL4W8o6aRJC+7E+LyLC0GVYaDttGC?=
 =?us-ascii?Q?MjPTUcL1hGEdp9Iw5b6RJOF3gd1vKGmN2AYOoOT76QQkDE2CJWKLR6gDOPja?=
 =?us-ascii?Q?2uabBSL2witq+ajixiiqhTzVAuisOvxufL6+wHDQW/pPd1DdWHOFQORV4qmJ?=
 =?us-ascii?Q?0hraDvp8oWoRBS5azr16pOLqZkwkdYKMU2ndOdfyWicEvFPHyv9dHoFlucSa?=
 =?us-ascii?Q?KPSoDSvP0P6Bu+T5UeOnGq72sp/R4C+nHK1/uRb1b2vQvkdI6oFAkMcSbbJZ?=
 =?us-ascii?Q?0zpzxL9AavGhdREg1RedZqsH9XJ1xzyBbfBLZug8PhIC9Qvql9f2Ue+I7EHo?=
 =?us-ascii?Q?nVNk19N/aems4kiEU7VIjobVPxvBSfJyWTFXcYrxfxRQFZRTBfkdV9o8jqnm?=
 =?us-ascii?Q?cwoDJUvVGX//mFL7n6JyBzjeJf15yahwkhSq/uw3zb0WwL+gXAee9O6+ddEJ?=
 =?us-ascii?Q?VLMFgreCOeB+G2UUoncsfY6LOOQkxbPQDgivycyr98BUGL8/zZQadqZZFszT?=
 =?us-ascii?Q?0eKPqLBud1cGl+LOjbRGruNVzIQ6VG/QNVbBpnH3iuG3l09FI8HTSj/uWw7a?=
 =?us-ascii?Q?jSTa9BHoWESu2TjE8pIZfnMVzopq8kV1Ego7EygDiWmQ1Tvazvmv4Xc1orwt?=
 =?us-ascii?Q?6wl2pj1gEc3q0T6TjfK9d+bAIMGWz15NJat6ba9lu1YyGvjaNihr829ShE46?=
 =?us-ascii?Q?CrRoRLPu4KZV3If05J0EF94Er0i3siFCkPyb9JJJSsRkCXIlVL9JMndus5y0?=
 =?us-ascii?Q?XddfFKxtO78dFuvLPbjGzSzYjml72bHLdKea5g+ZAEsV/Cn9a48XE7DHV3sz?=
 =?us-ascii?Q?BQbVOyXFVdC+bZ531bM40NmXtMZe7cGVtxKYfn6fihOv7l6jUQ8k8/G9i+qb?=
 =?us-ascii?Q?Isz63futuzW7LYJb0fkG78j1uKnQlUwjtu7SF0xMttoUqEIcS6xoJLGbfUrM?=
 =?us-ascii?Q?JI55fpYQUfO+DkspuYM0EgoQxS//wSRK3RpaT9sC0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ftlWRHGhyL4gjFJuYLk1LKpVzWwY/8z8yyQaYzxHKXgtsPmFu2n63DB/uGrc?=
 =?us-ascii?Q?7JFoLGfkTiNFbItY7ArOVskpGlLvzQfhhxPee3bBfyeo+eNiBx0Jt8gyC5LM?=
 =?us-ascii?Q?uKsXnwLPQdkXndviqGRDU2oX8Nr8zyN3/9Whr3whApmFJrXO1kxXFTycjmoU?=
 =?us-ascii?Q?qYMQHi2Kx5KrPCdgkc/4qtxtZPk7xkI03lW6F2Ud6nv2j2mE+Tgw4p1EEwVj?=
 =?us-ascii?Q?ssjXMQY2F4wJ8DNsXR8JEWnwThQwtbExXbmun0m3TMUOPvDV+MkXU+Xa8y0p?=
 =?us-ascii?Q?qSBlJo7IIcixvtdH50auWfl+WDLKfD70dW8jQesvCmW7VHXq1QcUJS7H9osJ?=
 =?us-ascii?Q?xK9F5uwNJkStUTiget6ToONBFp5aC0jfCBowfiUSg9863rCn69c4IlsPakQj?=
 =?us-ascii?Q?RHrM90v6T0Y0ZX8nrS5vfqFD7uw+ZIj8iIclwzW/MRzgjDgoXL5b3JLUVf4o?=
 =?us-ascii?Q?6g0Y25il1p/teOSa+iJzHJruhqEwbb0NsT8ZUL7Nfr78Rhed9MT1INbS4XOd?=
 =?us-ascii?Q?CWv3ozWgx5osTHAHToSojxESgT/2bSr9RAZ+3MnymOp8A8L1ThCBGK0vFDFA?=
 =?us-ascii?Q?tDI46y5uwUB2a2ow0+jo4aJt7Wm4yR5LMFT2A+KHjfUkgjW7dWPWpJiDWfUK?=
 =?us-ascii?Q?1GX47MPx6pjHDSx721zLJFOryhyhf3U3tS7Czy53jdd3vqn97wgnY4Zz6AxY?=
 =?us-ascii?Q?Kz+dHeeuUYXsONpF9R+brE2GxOBC/P54/1q8oiBGm1zVNlrSe/74e/KoJjXE?=
 =?us-ascii?Q?bMVoPt/u9HqhM0pg5Pb/lFGTiPkjD71K2FARTnEPxR4QrGAzcVY6LJhQNmSc?=
 =?us-ascii?Q?0UXKeMaF9ldlCBGpGkBI9MUWhV37jY9H4Oa/XFTYpM8hetnXiflcZepCb81s?=
 =?us-ascii?Q?LNpHitNhy+0cvlvWpjvyX1/RnPK2Wi1zs5U/xOILqCcFFVzxzM6F8eUxypfX?=
 =?us-ascii?Q?+SARsSoiooZ6jExqaROr2Mz6yPfYPWg+bvUodVwjCce1B7JnYj3w6dpe5DDM?=
 =?us-ascii?Q?f4qSPatEt1W0iw3ds9Qn6k/7hi00kR4a9oDisY7SaQ0I59IHOu+I2h5tHWUV?=
 =?us-ascii?Q?TWPqO6tdiXyiN0/Liu8ryRh9aYqhB4ABB5Qlj/MFk4tZZl7N2qIYo1zM3Q8X?=
 =?us-ascii?Q?zXcG0QcgMFlc2F2c/N8CsFglOVpi8Nwp46i8/+Bru40jKdxV6AeLpuCx8ZUC?=
 =?us-ascii?Q?IUT8jubwjfn2/p5QgvHMFHSHa9q0xgM5bQMaicFaRU7TO2zot2calVTXCd9e?=
 =?us-ascii?Q?HmTM7mHO/4heoZrOqDqfQV+PIdsFljo4f4jItPRBySWL+cQfiQTSYdH4p5Em?=
 =?us-ascii?Q?gJeYS6l653hWs+2P5CpHlFZ3Dn/yeoMcs5PoF0rl7OlX0qSTn28DkFp611ie?=
 =?us-ascii?Q?6kLUYVWBxNrGxwruRf2edCeo9ovEV7WgAKr4XSxE1N7oBnzMdIfWBlPMKlrn?=
 =?us-ascii?Q?Nk8VIyURZUWYNYNCPVmHZY6TH80fL7qRFHqTPpQ8Ed/byCasrIzvQdpYBMjf?=
 =?us-ascii?Q?Pp8jeqcuwlr/heFAt9DrjnWx2IeTz0e+MguQW3CgRAhkwCNdoon30wtjZ4gA?=
 =?us-ascii?Q?WSfOnnK3C1lbB04L4KgYj/LaHiDC3mcmJrF1e4Sm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b092cc9-4956-4395-dd9b-08dc6e849925
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 10:58:16.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuGEgJCmPbCLvHIq0VWCQV9juwF0jKF2g/fvMPrFgiMmvAEOLssL0YR4xgNqm7MQzm7fAHNo54OfWAYbsq9g6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635

On Mon, May 06, 2024 at 06:36:13AM -0700, Jakub Kicinski wrote:
> On Sun, 5 May 2024 17:54:12 +0300 Ido Schimmel wrote:
> > I'm unable to reproduce these failures locally. 
> 
> :(

tl;dr - I was able to reproduce the issue (hopefully the same one as in
the CI) and will post a fix soon.

I woke in the middle of the night and for some reason it occurred to me
that the problem might be related to the MACAddressPolicy=persistent
nonsense that systemd made the default since version 242 [1].

The test creates the veth pairs in the initial network namespace before
moving them to one of the namespaces created by the test. Since they are
created in the same namespace and with the same name, udev will assign
them the same MAC address which breaks bridging.

The reason I couldn't initially reproduce the issue is that long ago I
added the following snippet [2] to the kickstart file with which we
install Fedora on our machines.

[1] https://lore.kernel.org/netdev/20200416095314.0a1dff38@strong.id.au/

[2]
# Prevent systemd from changing MAC addresses
%post
cat > /etc/systemd/network/10-ignore.link << EOL
[Match]
OriginalName=*

[Link]
MACAddressPolicy=none
EOL
%end

