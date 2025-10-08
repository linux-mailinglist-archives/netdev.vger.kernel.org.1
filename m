Return-Path: <netdev+bounces-228211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133DBC4C69
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A7519E1FBF
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920824397A;
	Wed,  8 Oct 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aiuuGMHb"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956624166D;
	Wed,  8 Oct 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926524; cv=fail; b=XtFbSbPS6JanO8AAl5JnmqbuWxle3/tqq+/ghsy/RcbbYV7KZ8dH072rzj/Xx8FO67UhPt7YqM/QZVb/nYX+jSzYfLrDYJenKRdTQDacpMTto9lf0czLoe1pbLB2fTg4ZgU+2lUF2hWj3AR/o8hgW3np1ttMeGSNB9QB5s9OtZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926524; c=relaxed/simple;
	bh=VdqWBu6mQFgeOm1n8yihIW0dyTESfIbt+Z0mKdlY5pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N1U7UGWsG7n6aeEEM1huIJJNmBXnkJY3x1AuZCxH/cCebsD86kRPu3z2T1IErR+Gz1VXqyBiD7SGibafEiVjCmUwsRwk6Y2LOD+OxRZrxym+Om+butN+blKkkjfXYPIlwYok/qCoC1aulgX3eli55mJMh3c7hBQUC8G+3tqHyIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aiuuGMHb reason="signature verification failed"; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOTUYWELzZS3hCkp8XUfOgc8B3W2eKYM/yKR41lbvnXgfJdNd3GjgMDkTsU4LTuytunIqs8BpfMHUeNvbOWCd845m6zOl/BSjqiQpB1YGalPIZngu0nlDJ4nhuzLIxi6lvwp1c1LYO0YbmELEuS4F37N5POgePPtyYaY1wFZ5wmvQgfPE1DjKy50oVb62/NdJ/7gLmpxQJZ8ldxeTbe5Zix9EBrz5KzV4X1UCfFzGnyb1zbqjly2MUGCTEqTvUSX1IkD3MDgsACSqzMysT0KBvT/Lmum+1osV+Maj+v9szmW38Kw9KKlvYTR2p3NG5LBwt5OxATno3WzIfpKx/ACZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upNBhTjAhA53Xu3yAuIXFByRXRZXJfo2DtGmyvTssZY=;
 b=FJFSqt0zUnc5/q6HoyPrMLfno7zM4M4FWABaTkDYKiHi+DM5925cKx2yArZfmAY3axHwVlYnbrnBBN/ZRnW513nfehFiofAZY5LiLLYP09mHRr98PDLcSv3S2nDAFhyebAcZyxQcv+MwtkCEaoqZoQbK4gQPCLkcvn058xpfJzTnOX9DrDVZpzuF9qVFcAau/TUqKVO9euOrXricr9kCVxM3zbp10XEZz3aaqwJ8iBixMHqBd3G3Ngz7JDmCkxL9tDVvJTaf2I7MmysleiFTNLDsnlVvvlpHzPbr3XGDKRkuGNARQnoH8XkiQ5+aoyvyD6kMVpSBCjlGyhu0kQyVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upNBhTjAhA53Xu3yAuIXFByRXRZXJfo2DtGmyvTssZY=;
 b=aiuuGMHbfJKwWm1/imHY8Mycrmvs7/Wn3fqZjSTYSo7jILZd5nIvcX1YmK5auZJqmfobLPmZV3wixQNFPFzkFGtP1ul7PFWyewjKons7+MPSqCXd/0G5LufXaDPfeiYqhw2G9JI+7aQL79RUbK4YWNhQzHvyWK17xrcgQJ6CdA6ml1yPmRYPFHm8oiiNODMl/tbpjAJRCnp0bLxLNDrg5kCWPD+DQcYikZvdMkc33hetRuqzVIVzq0dvVY5CzI+M3+lMBLh8bIqcp5x/z5J790ZqoFnDrj3X8JXXHyz+69doGtX5lbPpelofEDX6Ja+tpgCqz8w0mDSbjwlGyhRW8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 12:28:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 12:28:34 +0000
Date: Wed, 8 Oct 2025 15:28:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Huang, Joseph" <joseph.huang.at.garmin@gmail.com>,
	linus.luessing@c0d3.blue
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net] net: bridge: Trigger host query on v6 addr valid
Message-ID: <aOZY5yYiKtfUrLZr@shredder>
References: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
 <aMW2lvRboW_oPyyP@shredder>
 <be567dd9-fe5d-499d-960d-c7b45f242343@gmail.com>
 <aMqb63dWnYDZANdb@shredder>
 <aOEu6uQ4pP4PJH-y@sellars>
 <9cc66694-6fcd-4460-9bce-cdbcb0153a89@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cc66694-6fcd-4460-9bce-cdbcb0153a89@gmail.com>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 24be0855-6563-4180-fbb1-08de066632f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?+cywiKz2gz/+LBAOusxphyagJ4R29fARWDmQlPJdpe8CatP3CZ3jQJkg2X?=
 =?iso-8859-1?Q?1wjl6JkZrFZ6O3t1VL1+IvnSuYQG3f+TdtSvkel2wLGG8foMlR6KsUllmf?=
 =?iso-8859-1?Q?5UhsW8ZJ9+jmmEWrgah6NzDBPcX0KRx0AkAYE27wHN5KwMtZ0i//+FoR4/?=
 =?iso-8859-1?Q?7bem+M3i3fzFasDuwEP0Ai6njIfQHzxqwb2nk60L2+yIZ8ron96RRExqE+?=
 =?iso-8859-1?Q?3mNC1T4rych7WB69aspiBJGXy4UpiNI6yqYbDOHUbbqzB0mQ4GHLig8nXi?=
 =?iso-8859-1?Q?NIKhrOOlwZObDNe8jV12uEgoKdRox9g8Xxg2XydsdDipt+dQ7WV76arD/w?=
 =?iso-8859-1?Q?aX0MYKjc6SzVsjOCRyJlwaQjrEql5xUSfL1K76QEPnHY2Wmsl+hTElM/c5?=
 =?iso-8859-1?Q?bjr3crNmfdJwQkNm9iVINg7aYWU7rjNdkJ1xifq/23CzW2WlVETpRcLDxd?=
 =?iso-8859-1?Q?VTnH5nvYTye6h77tUr6cclZjgchMri/b7Qq0pnGFw7NggbLFWY753B06la?=
 =?iso-8859-1?Q?XKi8co0RfkqnSW8U3bvjaEwlHTjQXYCPvNxqgDuNKIRvtUaL4gEqMQHB+S?=
 =?iso-8859-1?Q?T06pYOFQEaDVnuig2x0sXFZ/C8cB/2H8C8ve6xkLUNXLDCgh2nc7NBBQwC?=
 =?iso-8859-1?Q?lounNxTAfdMPnieAkvQ+/rnt13Zx7yoFpOmPL/JIgwfWxv/Dluw0lTfyt2?=
 =?iso-8859-1?Q?Qg4KTZg3KnofUyUBbtT/6gNxL/yaGxloVUj3eztEp2aiJ54SSp/5yQsfN2?=
 =?iso-8859-1?Q?2IQrKPIJWzyaWqPDWzgGynhHriuEfl9nJk+WbE78qjmGX19U861WAblBKR?=
 =?iso-8859-1?Q?YgydbxI5K/3+DC491TkCHkmkVMnDdXrdMkDy3CXLpMullzunyMsDCV3QVW?=
 =?iso-8859-1?Q?ZyhQBBvHq04gFW96VfPN/lhvf+lKeXZ8pSh9yu5U70RcppRMrRCE0VNALH?=
 =?iso-8859-1?Q?7pkZrSOY8isG2Xeaz4KIwK/eV8sd5Em83JFCMv0C58R8YB3W4TES4WL6nw?=
 =?iso-8859-1?Q?Ekz9hrEaHSAXWBSxQbnXC/+bRcN8Hko4xT7r24ydmX07ffEEQ8Qf6qfZH2?=
 =?iso-8859-1?Q?J6ObRVjld45O7jxOWUkzaVlRXbP491CGg6/PJDJQHrx0j1f7rFeTNRSMb7?=
 =?iso-8859-1?Q?RKwdvMXcac4LTBxsU7W5UR9S/SNffkJG1t86v7zVJJTR0R9p7h2Q5k2P6X?=
 =?iso-8859-1?Q?UMHJri1Z2vwQG5fV9M9hV9GTBB57lVVTaFbnVRTuatBId4INSJ8vp3H1l+?=
 =?iso-8859-1?Q?fcicANh87A5a+SbgyGqIRT8JshwekA+uPfuiKmbMrRLIJy03Kzv/QBOoxp?=
 =?iso-8859-1?Q?o8HUxWnFsBgw3wb7rUA2buO1B+KypIa9e2KQPKAeTirBMkVmAlJC98UyGN?=
 =?iso-8859-1?Q?3JF+X0ttckGa3qZ0Un53i9yxFMPAr74lk+L8lP7Gtr335Aq9vlXK+dCyEi?=
 =?iso-8859-1?Q?4mawXRpQ/u5pocNAvJbOGqa5hYdL2v6rR0fqzabVkYaQ0Ju8U8kvBTnnyD?=
 =?iso-8859-1?Q?tn6OtrkeXqh/4TF1bWU7OZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Q0XSo/lMxUfG4YJQrbynQ45P7FW+Fu/P60fdAHswxpjbZtFjmQAlMO9ItT?=
 =?iso-8859-1?Q?BohIzoLssqn+wN5o2I/9sX7RO3Gztb6V5F9C51WbU2xsFDxxcizX1dB8sO?=
 =?iso-8859-1?Q?NswwydSIJyjZLShYyZJimI4axQ2Vt3RZP7VBS59V4X+S/0VOd88zg1HzYb?=
 =?iso-8859-1?Q?tUW6Rx2kONqSx9/dQuflqwzYuLmzGgQYSO2I7ibVI7swnC0bTsv2qYxvtw?=
 =?iso-8859-1?Q?u/Y6dVrjGJQqptYnOChB1S4iYzA9V/hzKXmEmcT/Mq/TTHwbSqp22eoJpZ?=
 =?iso-8859-1?Q?V8KXLq5UnGio82NX/p3d5mp1x6eZu5OtDdDVEIV18xspxNXUtKWvpiwl6z?=
 =?iso-8859-1?Q?QipAsRE0CVsweMyMewa5wYRT1P0sZoGU1CR4zM8oXQdpwVgLhfnzzcdbcJ?=
 =?iso-8859-1?Q?6KsxdcpU3i0VbIP9x5pPfzH+FdJaLfodhrEY4cmcXamTUUAiq5620wBgfb?=
 =?iso-8859-1?Q?FfCH0ItITNrLXR2Nv35mzYIR/1qURA5cy74E88V2RIayHQeTocqFRjDfJ+?=
 =?iso-8859-1?Q?X/xE5lPSwePs/7TggSHeoMNNLAYDc3Bi6rmp+SuVRQ2XKiMi9n7CbN5oBY?=
 =?iso-8859-1?Q?dCUerkW/ihfJR7ycG2uyJENn2ItlDgLs7r1qTUT3Rj0fSjTnoBUJyRrIR4?=
 =?iso-8859-1?Q?8JWCSY6xBqxiobDcjwZMqr+MoUtF2u0uPeCQjU+AgS+Un6JJsA0ng7SU4g?=
 =?iso-8859-1?Q?vQyeoThSMOXnrpLRCByB4qxl9gOewAaBFf3QjeCAmCQmJN2+DitiB7wQUl?=
 =?iso-8859-1?Q?HoH7sadB7tQ0m2RlvvRBgTMDnXmsNjiBbOWtZkmnlUX5LdQ6HIKGMxkRlX?=
 =?iso-8859-1?Q?NfruXdImZZ5MUVoWAamtHuU17kS9Z1OOgH1bXo3JEhXezrp36VFzOArAfp?=
 =?iso-8859-1?Q?7LSXiQzue8cuIV6O5j62JSOUU50AAuDEEn0t+lmQ4TJvCTTwz60t9AZMZd?=
 =?iso-8859-1?Q?9kbdS5t20N/M5EZoFF1M92PiMADWkBK7JiQ6bGGH4cElunla8GkhFNZgT1?=
 =?iso-8859-1?Q?Dsz+yD+qTs6nHcMMEFvb/er2UQVN6dVxh5RcC+t/t6PWclFJYDXQLi148N?=
 =?iso-8859-1?Q?tPshiJfXDHSqn6JSgcRz90Enbejy6xm5fG3xis9vAA4dgF3vFaUSPOYLqt?=
 =?iso-8859-1?Q?JTpcL+hfshwVKgCog9gO1+OSVlMpur+HdN9SGVeht3HNxJWF5MH3E8rsB2?=
 =?iso-8859-1?Q?DzoWorcSQ7sAiyb48ura5b4z1ZWrJVnf9FyA+HXhfnTBbFf28dyoMB3aHu?=
 =?iso-8859-1?Q?C80484fvgH3MNdimneCsIbHxkFP2wz/3H0K//cdAh3xWdQJq8Ig1Q7X7OW?=
 =?iso-8859-1?Q?1sB7K1E9IKLVh7sRsZPzGxXo68lz9O9im6ELPHZ2Ud7RQtmd3B5LL5/d6z?=
 =?iso-8859-1?Q?EnVKsFTRUsYAjO7XO2pZLDtsirLzmo48EctG1ROHRlqGw810TrtMsu8gQi?=
 =?iso-8859-1?Q?i5PTTrCIYg8SLTI4X6mSwDu6wggqGDv+Zrswpo7r8bTZ1FCK3ycM01SDKL?=
 =?iso-8859-1?Q?b0lCXVJlFEjwS4bxcVxKI6hbzHNbcjG89fQruUP6b9kwJLn3YySDVvziqv?=
 =?iso-8859-1?Q?JYaX+TYjuh3wGPLBMc9KgOerMYgvbaRnMZ3HXKFLh34/6x1YrS/UHyIQUI?=
 =?iso-8859-1?Q?V5nRU/roXf0oUJVREKHghn8qRwlCSQ+fDP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24be0855-6563-4180-fbb1-08de066632f9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 12:28:34.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT83W4cnc2upfDI+1cbHhz33NbAvX0W4FHfBsoLqECL6So+6nOncKlDhD48j1/CDWO+ZR6MRV/UU8l+loH8g5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693

On Mon, Oct 06, 2025 at 11:43:02AM -0400, Huang, Joseph wrote:
> On 10/4/2025 10:27 AM, Linus Lüssing wrote:
> > However (at least for a non-hardware-offloaded) bridge as far as I
> > recall this shouldn't create any multicast packet loss and should
> > operate as "normal" with flooding multicast data packets first,
> > with multicast snooping activating on multicast data
> > after another IGMP/MLD querier interval has elapsed (default:
> > 125 sec.)?

Isn't this 10 seconds (default mcast_query_response_interval)?

BTW, I see that delay_timer is started in br_multicast_set_querier()
which is called from br_changelink(). Isn't this problematic if querier
is enabled while the bridge is administratively down? It's possible for
this timer to expire by the time the bridge is opened.

> Some systems could not afford to flood multicast traffic. Think of some
> resource-constrained low power sensors connected to a network with high
> volume multicast video traffic for example. The multicast traffic could
> easily choke the sensors and is essentially a DDoS attack.

Note that even with your patch (or optimistic DAD) there will still be a
time period where multicast traffic is flooded to give responses enough
time to arrive.

Can you clarify how you observed the problem? Did you observe packet
loss with hardware offload or did you observe excessive flooding with
the software data path?

> > Which indeed could be optimized and is confusing, this delay could
> > be avoided. Is that that the issue you mean, Joseph?
> > (I'd consider it more an optimization, so for net-next, not
> > net though.)
> > 
> 
> I'm not sure this should be categorized as an optimization. If we never
> intend to send Startup Queries, that's a different story. But if we intend
> to send it but failed, I think that should be a bug.

I would say that the deciding factor should be if it's a regression or
not.

