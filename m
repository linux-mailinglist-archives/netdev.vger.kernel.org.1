Return-Path: <netdev+bounces-134936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E099B98F
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 15:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF74B211FF
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D3143871;
	Sun, 13 Oct 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JK1j0Et5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E031E871;
	Sun, 13 Oct 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728825530; cv=fail; b=uuJfngGjGjm7PNXzNUvc/zxh7v2nK37xaNLjl7z3NdFUmh3vAPW8D//W9sP9F6pV7roeXD4PCB2YvRPJAUO4E+7OJVwbCwWs+AQ8w2wARsojHcH01qPtrSWtRCtceMPe0eNbmRz1UG7UyebUD4/ieWFakWpGX7KesYQgoPfKUaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728825530; c=relaxed/simple;
	bh=WmwD4Z/a9zzLBBeuqku12DaXBjqlIcBr4GaNGaKlFSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=He9sK6Uul0zdUFM7B6ppSotR1llK4yMlbFc0zlEla+aYxqQR+iwT2Ix7gxLkL8Od1Tai41BMeY0qplPZ63HmuXlA/P9iyEy3Dduqdp5yFPp/wb4pGxHwM4wzYROnOlD9J5StS+RpGjpcIH6XhaaFWUeLKO6cYQ/mvVZ99Ox+kzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JK1j0Et5; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxF48Vrit/1fawsN+7s/A+MFv8RbSI1cCAXFkZ3vcb097TcmMx+hFILBZ7Gp/9Gxr6dVKEJL/cbpyOMJqro7fwopPv+7YLuL+m9AtZ6QUQ7OpFVTW93SOaBXdqTSOwN7h3jRpG4kpJBKZ7lFDntsQY2/n4C9NEFBwUSrPJkZFiUkJy3ihZZf2/SvCdNFiRvdpO3i3fCoHT7hjKhxk8k1lfIUXfALETmmmT3ZQZh8EOUunJmt+7SHFihjvRsfCey6+IKEcZvVpYkYatgY57dz3RG3WXwsnCnhLNbulQnXEDM5VNBW1ha48unAGmlHOu2Iezxj+Unb/ihm/NsbXyXnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L5cuDQggwH4Ppb3Ug5qC/HpEm+jrw6p/eC/YcU5OGQ=;
 b=oaSYtNHS1rHwP/6uV6VbVENpIZryuE8Cr2UI//UQVJ8qpujOu4A2M4Mo/6rsVP87JF3nEwoOhO+LcQhSkIZ7+vzBm4o1BN3RMuaJ0ukR63HdfpmKrh+dYc+FTkUMhrG2qICqja7WsD+1B2T0030SQ9mi4D3YQPfFFwTDFF5Zc9e1F+ExCAWn4YQiGgZCVsqOWTGtJw85wWvg+SYi5Pti3zZ9WtA4SlLmttHb2uHIL72joKqbYcGJFR/UPcDNPbEyaONxzkmMh/EPX6AMEGN5ijuy5FebUohk3aCSE1d7jOzD58yu5wStuNk5/N2ciP0tBPEl44CUxrYzkmndWH7sRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L5cuDQggwH4Ppb3Ug5qC/HpEm+jrw6p/eC/YcU5OGQ=;
 b=JK1j0Et5kuunHNsJ1gTS3p0sm0KuoooiopLPoHKtGknHXhXfJq6nUEioU3ViBBPrMixYHv8znyU4sUetGEP+GY/LP0HYP4eLsE1OMZORaMSEd8vNJM0FqsCxbPPmjZjJ/jPr38Ep1WjUl3+yzuFvFyRpcg5XTKZvCZ0Oq596U1qMYfsLrgshE/tI5D0/F7Q8TClVEA8cKBFPjr68DZziGjKK257Wl3i/tVvjJYvZa3xlZdx6/eSx+e7lJ7gOJHd5sJC7XO07CqAkwDCSXszqONWYT7/DeS8OyNmNk5LoJKZBIEuhlmh6g/Wxt6WRUp4IJW2pDQWYrceUX+eYPez7kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 13:18:46 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 13:18:46 +0000
Date: Sun, 13 Oct 2024 16:18:36 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 10/12] net: vxlan: use kfree_skb_reason() in
 vxlan_mdb_xmit()
Message-ID: <ZwvIrIrqnZ0e647Z@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-11-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-11-dongml2@chinatelecom.cn>
X-ClientProxiedBy: FR4P281CA0378.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff619a9-25b1-48eb-f828-08dceb899195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lu20Lntvhe6MYFrWwwJEXRua+2KTq58RciZaToqry9O5BaTSiP5Tnk67ATZv?=
 =?us-ascii?Q?UEpMFJ+mRjXW6XvAqAcSCE1zK4IfC2t9ZNyOHIf5H2KiR1RkRAwVMvBl2JgF?=
 =?us-ascii?Q?eN5IbHevk7jLhusFAX7DhLcp3/c/m3ffyOtNYRJJADwFKDa5g5bjs5SDthN6?=
 =?us-ascii?Q?8Ofpleny/PnHu3dcFEQziR+2xujiNgwBo91f7e6GYswC2x4PnJ2LlX11gico?=
 =?us-ascii?Q?cnRb1JmUz9TKBswus2cJHFPZLQ65GGihUrHNdvZjELhVdpqYkBjDpQetm3/n?=
 =?us-ascii?Q?oKAiJQH4aKEjy2Fu9UKxDLfActkCSUdz2Y4Xc11wwghcVqMPNN94H3XBT12i?=
 =?us-ascii?Q?b32C1Ku33Fvr/S6gQqds5ilZSh3iccPrm1UbFsbdrILp8fHRySHooaoBHkty?=
 =?us-ascii?Q?3LIw4Ux3ajfVRg/BSUaxM+lDw4M8R1vLYD56EQdvs1jQaUTIR+YC0CY8+moQ?=
 =?us-ascii?Q?AypkyfPglClsXjstRws4QL4z5uoclru1e6z9m68xWYbwq9qHT+snkrYlmZPx?=
 =?us-ascii?Q?T9p2P8hDs+/g5SyVOp3w7FCxp4060+HeJuMRKTaLnAvsLCgw7zsQxi9xDm5b?=
 =?us-ascii?Q?DETQDxHel2OlUJksj+xOQ8/qgueV4s9JI2al/iVGrybMh6aHRDEwQbKfGbE/?=
 =?us-ascii?Q?RL5Y8EyKV8iv6WI7xfSE60l+oVJLsM/9k35KK/FSQEL6BU+nS1JIuNIPZ73j?=
 =?us-ascii?Q?IXADTHTq9bsT7nRYPdtyMzwYJPS7OJQSuY1xxW9CDCdkKIKOL7VE8e3gf1qw?=
 =?us-ascii?Q?US14J10BiO0pTZTjYkkDQ8Rtrqa2cCXCtPP6ZW+M0EGSlidkD1R0LkOMycdI?=
 =?us-ascii?Q?9LkSUCRWe3bxzfUU446DixXgVezauwBPxVtAImVFheJI3migbe4qd/NZtUd3?=
 =?us-ascii?Q?wl0vk3gzT2Xh03z82xB0yGf5DHK3I7PwiPpJf69+dkIMsN5rqt49zniZ0M+I?=
 =?us-ascii?Q?csFydVMHScNUuQ0ftyrmDwORO+9zMy5gnrjapkQCxNX9aOOjKFKLKQwC/EZ3?=
 =?us-ascii?Q?DLKhqP6wVOJoDXhQfJbdoA4pFCu6HnH/aCkqva3m+61+nlveI5R6QU847U5Y?=
 =?us-ascii?Q?i50MlO1OAVvrFkDPdd2jjezAHNIhTB7gYjURnaW2GY02VCyUUl7CUAlc+K8D?=
 =?us-ascii?Q?Fz5cWHXndGzd0tYbdAv3QCbZnW94t6o66fY6jAx+3Zk8CxIJjGrciF4AdKSC?=
 =?us-ascii?Q?6IRiOlTzmqQb/g1B+UUaYF1Vx3Buqk3SRydcEeB7hD5rxZPYM4ThrJSr7sMo?=
 =?us-ascii?Q?aYk2i/VepW3m1DNkclL3/LPX2JJGaa7cYQRZKZsGDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MtP+kScVA0dNUYodrhi6AwFSF7XEmPNZOwCx+Z8Mh/c1nTTgT4ZBgM/4/3Ed?=
 =?us-ascii?Q?Tc43Gb299UKrr32ZDkGPWR7g1vVyAxuoljFtJiGSTj9l5Fk/C36V5zdDjqNz?=
 =?us-ascii?Q?Tcnv3872DRDSbQ6RBbxmWpJodtehiIzrW10z6BYZOzqucvrLeEgE9U6zK/ht?=
 =?us-ascii?Q?+5Zvfi0GHlHTh91PPlEkqr/teWlTIlKbecY0ph3jVO4D02NFj3nyApka7Qbo?=
 =?us-ascii?Q?JPnbqK2gobY5ahtlAPyovSJtwpivBu1tb68i6D+qpb5EVhm3R1tqH3p3oGKQ?=
 =?us-ascii?Q?q64yJU0VyFlG2bMY0fTQ7W5IAiLHKRxD+1EwNM5X9H2nR0HajHV6QQvxi9f0?=
 =?us-ascii?Q?/665MZqSiahHt3C1aboZtrLFr0gOA/mOaXTLckN3bIorC0somHtGsJzJdD72?=
 =?us-ascii?Q?R2idSqq9X1Bg75jIVmi7GM5HT2EIS7oRbj9pSHfJYIPudnZjHpMw+Fd0lvV2?=
 =?us-ascii?Q?4RoudJaToPhDsNWA0tmttNkCbA2FJVxXuqelUJTIiIrEDJz/dBPu+EzKrJM5?=
 =?us-ascii?Q?Uzq/U52YJTG48kEjfrZi2yyRQdlt9TynOwvjKjqoHlN+8aphTalTY+tsawq7?=
 =?us-ascii?Q?jH8PVhjgG2nbjalt7Ea7VZvV+CmnTPZUAbqWaJAF9WkwuXIqpaL+Lv1DoXF/?=
 =?us-ascii?Q?nBJpHE2mkISTDObXNS6+bpVEc8TFgumT8jQLQ7iMDLmMdCWVG2tHIZwlyMEK?=
 =?us-ascii?Q?Xb5d7luUQAflsrH6q9FmhqJsXn3IrBwNy8k5HLnMyEtJd+KS+gszYaV89cvW?=
 =?us-ascii?Q?9w8+cnuCEc1wWqEjkSVvSkl6V0QyQ6AC/pdzUwEDKusg+EVWJ/h4UkV49aGU?=
 =?us-ascii?Q?5tFJ6SnFPr+mO2dhjDdzqHYOEVZmwQq6/G0OmNeJcSnPNNTzEasC2BIAwoPg?=
 =?us-ascii?Q?C49WUoNbyUvRU7L7WVZIf3R6sJX7bHOPYzJrcB5V4MXIt1rowDNPMi4SM2hS?=
 =?us-ascii?Q?e8R97WnSaf7jxZO9NjDMQAflaZthBMRMhtgx0NL5CwT08YOSPMwvROFE2yhr?=
 =?us-ascii?Q?K2SytE/Z3MSpdQCMwTH7hjIg09R98e4cPJbW8OP5csnjEvnfT5A0FL6aEnOp?=
 =?us-ascii?Q?N7urQpV6QklhIhcobCmgPAtRGIt7a1nzD0eNGedSJ+noqCL36qwILsrx0/27?=
 =?us-ascii?Q?LvcCSVfZGyJiQUyJDRYzKO5YKV7PnwgG+vaK6kNPd4ILWFzLMY7IUfkr4SGh?=
 =?us-ascii?Q?l61NP8bnMtgboWYIgHt9XzSwsbnwNAo2yNK0PBfxyl02EeCsY0+rl8vupl5q?=
 =?us-ascii?Q?OaO7IFEWpjNN0Iu2qXJ5NlpNlW4QJGIcgI/STpXebvqQgQVlPDH8wkYh438L?=
 =?us-ascii?Q?+3ou6JhTTMI1Htw0b7AfqjxxLx1aAsoUBKYYzjlCG9MoOgf5/6UXe9poK/0U?=
 =?us-ascii?Q?ylO/CNrMZpn2bDYQyEJ7u8OO3xpJEfwS1zNx/DIBGGPHapkABEDMjQNXvebx?=
 =?us-ascii?Q?E5ZtMoq851jUD4HFsMI2eWLQNiLe3HYH/Q82X488+6/inIUwExyQRJf7fOfQ?=
 =?us-ascii?Q?GT5zNXDvp2vUACH1QY2GKcYQR09z1nu+FxqaZFxc682zxWPZuQQ9lpIreAYI?=
 =?us-ascii?Q?ISt/SYA8yeynxKAmpmyy8nje9RZ5CNP1DCOwHp1B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff619a9-25b1-48eb-f828-08dceb899195
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 13:18:46.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm+yFAIISxjnoHh/8UTeh/6Put5Q4SLxqYdor9t/Dot7DixvHuxSe1UY7sw8Yetg6Uac06sNgp5YPvGUHUXr+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

On Wed, Oct 09, 2024 at 10:28:28AM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
> reasons are introduced in this commit.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

