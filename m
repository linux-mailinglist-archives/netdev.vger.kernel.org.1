Return-Path: <netdev+bounces-245645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB14CD4320
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 17:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0F230054AC
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064420A5EA;
	Sun, 21 Dec 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W5wGtHlm"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09951428F4
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766336297; cv=fail; b=St9yNV38/4hj5h5tqJDN74KygiWTZBVa4/lWRd9goQI5jXsCdDGAqA1sC52Wa4Vzf2o/k3pHVvgYjbX+1yWFQm0VcU7eoBipnXTyjofrt/9GTbDleqs7o3+7nkdN+oHvzd5zKihqZxvFJVL6Xx7jFQM51xds6Zii7tg78yp7AOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766336297; c=relaxed/simple;
	bh=LdGFwXnXKtCBvNitYQOKR6cu6kHXYTfws04e1RlZotI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aS8HiFZLDC+8ZlNXdYwF5os4paqweQaYvFdPkgPG8iymqirZOJa5IPFrhbAix9PJuRPJ/Vp6oIMC15X/jNqUbBq1q0YWgk7ut3fXU5vsHeNLgjq98+iTjSGSK2H6alUPGAXyMCj4VF5phv64rG3Aoe41Tmg62AZJlB1QNwAFovM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W5wGtHlm; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM6qLBvsxvnETJse6D/b4hxrD1cqivAbvkJunZiih2m8ZzellPfQbfcm1EaZvcqkkUjwv4M/U/0+elU1quY1v367ZphcTTs3kaNatnC68ibdX4JTzJsajWsqIkhU2YQUuF8ykn9USTS+nKxfDtL7PluQvJAw3zq8oWOK4gjupsrJ2imXH0Le8UsPi0OXnbowpaQ687FLygd0MHpOHbaYvDn4AelpF1YMgzxtDiao2iscMah1sFVlULHujCQ7MD7TPx0rzUSjzzAjXKXYS/xrWm//58c3HNSA3M9MAIVdk+z6PzTpL6V/wzrMmrhUlC1MhMdQ+LtMU61xqNAAGbRbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg7GeERWO0W7xUVhOMzNGSdbS8LDgD1uZtq4DGR6osM=;
 b=Q6MYdzfs+UUhyrxZmwO7gGYA2Qo/2JCJwEOu1+j3/G5lxuDG7l+ROwBmdHJJRdSi7XF8C8gDlB2LzFNGdX7dIyPm4qA6BFnbBrerZv56/+gZlIY4dhuVPDmApgT4JpOl8XUlejTxL/gw548J0Y5mE3GJ8k0847tfN4NvyVVmO+S7ED90GzjupU8F/Eb5RzqNGtU+sMb3vXj6mJ9uFkatO1C6Ex1grb1V3x5QfxHKJQfJVyAqpgblq2WIyouOH7SEmoG+ObJzS5DxwqO6heFXw5qu7DnR8wdQxHZhT8V16ZUj5bcQG3FI72jVIT2lr9H82y8Fpvi+cf8ZgjJlukU3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg7GeERWO0W7xUVhOMzNGSdbS8LDgD1uZtq4DGR6osM=;
 b=W5wGtHlmq2R/4aDqFqad+AegttIWdEschgt7w1MJT1+l0KA0fT78qWaqTkGtozdvTalETR0FOtGaXiUjZMg4q1D582d0vdcDW5ECA/wnL/L8rUqf3dUEZUE4qLJr6HZ/f6hwW4dF0wpwW9Dl8CVL1uZuESEctBe1OsQLvDIBeRuOyokL9SMMprUx8cPnfsjLE6l8INez0G+tY1CdTgx3smke3VLTyTjilvuER8TGXHEBzA+tNauX9Qk8WE5RV89r90MAVAuuyRf3yAoY+G1Vd+8ak7y5vdIEeC2G8Q1fd0RvePrx+OhcJqtoQR6vo7QlL97KwTuBn4xmyOqnGis1Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sun, 21 Dec
 2025 16:58:12 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9434.009; Sun, 21 Dec 2025
 16:58:12 +0000
Date: Sun, 21 Dec 2025 18:58:01 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: fib: restore ECMP balance from loopback
Message-ID: <aUgnGahB9uXbvrbh@shredder>
References: <20251220032335.3517241-1-vadim.fedorenko@linux.dev>
 <willemdebruijn.kernel.25af879fdb851@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.25af879fdb851@gmail.com>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: a217313f-d2ff-44ce-f70a-08de40b22008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9KpOqG4DjV8Vwemmkq9uF0XDhp6eOjh1H4y0d8uLOkBRE4iKA99LoTnFU7YM?=
 =?us-ascii?Q?vVLxT7tiTfTyCmwCYkf9LdFSxT9rG6pLfj7Jh0McYNsvMsoiacgPfMdGeml+?=
 =?us-ascii?Q?ASk0IraW3j9t3NrnFEnStl5J5QlaPz6eBhRtCY3Ybc1JLd43CWE/TBSq7Dxo?=
 =?us-ascii?Q?J7FrwfyZQOrVPOHNRh1+uqqPEpJ7QYVwjTitkxIhl7bhahiYw64GLPzIW4RL?=
 =?us-ascii?Q?1N9erThB1vEyzV5BjGbm8+/RPEGJHt4eHcW1DLFKEFN8XwxqCCfZTP2TwDMk?=
 =?us-ascii?Q?nY32WdcNRjnEgPiEn931zkkywLOwfSvjwVD4/dzYitGdbgFRXgx7eGesBdVO?=
 =?us-ascii?Q?mFWxrspkVBN0flNms2ITb6yhE8GP4d36VaZWj25/DhuUmrn5BVIa4zcscv8J?=
 =?us-ascii?Q?ORBR364xtzCzUoyTp7pYHudtRfHMzDqbv4c62jni+nPVCHCRr/YbIVHkLXyi?=
 =?us-ascii?Q?q/VFF15FGtJb1cDH46nqZWvwhkOnHE3imeAwy39+6yGtoWibmX5ck4f1j0IA?=
 =?us-ascii?Q?v32Ks2TiGP2YVxeCB7RY9cPYOzGLKNHjOp8Gfxb3/IaHPg5beNiAKUiNleup?=
 =?us-ascii?Q?8gN2YputSP18ri++UyHwE96Xug0Wp4u3Zd3DAnjOJoCfcuzJO9rWkpvFdbZc?=
 =?us-ascii?Q?ajE0ADeBeB37GJ3pQDhybuezRgVmGY/0BULdcToLVm/KQtdd0iETbKPL1t1o?=
 =?us-ascii?Q?3c0j4wdF+USK/c3LrgvpDqpoBO8EcEvtdUlYw/kqpg1DcN7RZuFLi9Uq+0VB?=
 =?us-ascii?Q?JIm2BrkeWUb4H0MjlB2NwcsPmTphirwzGBhr3/dif5LeYImaIh4LFNZlhrrL?=
 =?us-ascii?Q?K1zZ+bc1CuLz7FSyaG94D6j2a/4Zjw+uHb9SjQaaWDuX/OowU+Hc5aXFlvp7?=
 =?us-ascii?Q?B+rOGhUbloMxi/NxeAFiDf9ZIwgArrgPo1n05cIqtlBqPP81kvMxrMP1QJ/b?=
 =?us-ascii?Q?52OzjgRyGyWb7poISVQyCzPOQOOHW1qZ6ZfcOAQWWRJ+Lt5DMAZwDxGHEp+I?=
 =?us-ascii?Q?VvsvEXuly2QtbJnT1Kt2HSXkQETShn+yJYrQX5W9U/ktYE/itRtCHEGPk3wb?=
 =?us-ascii?Q?0fm66ZLLHQ4lsW0pmp73KYZV8H20TOmfVwR/csS5jvLZhqzv7gXPR+a63Ide?=
 =?us-ascii?Q?GiOOCMpbgHxBsYJhunLE/gfz7CQJ4PzyDkxH1xY2j9PKpv0PYZ5vt65CIvej?=
 =?us-ascii?Q?7Y91IR7w9mEe0dpXakVTymKK8Gu1W1r8GqdcbrN8f9xJhrz03IWHb4bmIdlT?=
 =?us-ascii?Q?5zEiP/+i4rIOjL58k+iMfecaHPrR6P5XMFnTG/69s/N9c4MmOsIXb+/qkPDm?=
 =?us-ascii?Q?/dKIb7pk1MbMG06w+Rbt+CML6snXpdHR6+GqmAyEL+yD2tNi5a08TaMok8eE?=
 =?us-ascii?Q?nUfD0aAZxzzMDu3S2blPyy0/SxAx3/crxh+eMCKpS2ridN9xIm5WoH1QkIOh?=
 =?us-ascii?Q?xThnBhQKoSr8+ryEIJsQHECneJ8AybhA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9J+/TMYHGoWZItA209Avt/Q4pIkCVZPwoyN23wx4oNwuerck+ogxFWJKr57o?=
 =?us-ascii?Q?88/EwqDl9QucePKw91VlN40t8Q6NtIe3XGrIdZ/3lToa6qm5/3Vz50JQMOoq?=
 =?us-ascii?Q?9z9b+mmj7LDVpydpj94/I984oqQM5xHSOJrQcck2WgrvmMzEVEL3nZUNsaIN?=
 =?us-ascii?Q?riR7ciUqJsnAvfe2LSYpLVeHcBN+1XIaxZjL02/Kn/tyRZOJNN5wKrshvHhz?=
 =?us-ascii?Q?ZXknsOA2JwbV01axHU9XySsKQc0grsm3Q6yH314zpJfj7VOtRrOsuXY8SXk0?=
 =?us-ascii?Q?4idEZwD7DrpqcbU2yCNDphrMy0wVNtPjOooDNW5knjw3cTPyUJvrIOa04tEY?=
 =?us-ascii?Q?W6bV+Z6uOMhrEW5ZBVJ6M/PopH8BeqzkFR7A3w5FjtjIj9zftR1svo3xARCq?=
 =?us-ascii?Q?LisW3/5wqk970E5+vHHAKVvQ4bLx8GoPyJASxBwaosV+x1mXcPpRs/5C1hyM?=
 =?us-ascii?Q?q36TXGpSDk27YS/bVyAYwu29Mh4zaw/escZSuagDQbuZskNU7m+WUqBFt0Am?=
 =?us-ascii?Q?JL90GplKNMHqJi9Tw/Jlkro9J2z2/5tJWpziIatK8FTSPpTaH2yRChiT8h5O?=
 =?us-ascii?Q?jVOZnPjglJ4ovvt1R2HvbnevRXxXoF7AooYW0YFqhd8Iu2bxSGQxsvQxqf0c?=
 =?us-ascii?Q?La2wCebA+SjGwYmqULp9dNom3stB4kFh6mX4IXTOh5EvtTy7RGoZFAe0SCGY?=
 =?us-ascii?Q?FkYfNoe0E+kInmip3FQ4HLzZtwM/FdEBk+zDHqEYG9ZOWCt8gc24kzrVVuQr?=
 =?us-ascii?Q?YZxXEhqeg+FgeyU09WD3uyv3UFPn+TQaSk3id9aUd7BF0VR4FflSxU2hRTpx?=
 =?us-ascii?Q?cWEBOA/+7uctaF9Y4B793CN9TBNjvhLyjySr0janH496glv2P2hPKi4TVRUA?=
 =?us-ascii?Q?fKlwOHJ4bKfQcKjNhXIuLsXNDMDl1P+mC//UMDwgMMex992Z6QcvukhK9bpK?=
 =?us-ascii?Q?ClN44+t5RGZDdqzRtEWcFY66uO2e4fBbqIM0cH3vmh/0XshagtwJrsgz3Eir?=
 =?us-ascii?Q?OvfA5Dn4MBjZzg48QuDoPY4M+lhOv0VqtJ/eemE/G65e/b/zB/qVRD6r7xOk?=
 =?us-ascii?Q?/ykQWOTSmycAMjUPMiIbfjoqgwN/1CsFT2rL+XfWFsMMlRvwIIRoah5kzhOc?=
 =?us-ascii?Q?HQvpmUQ9oIpk8sO6B6qYjibOBA6/GgSQBuML04GHxEclh0HFqhZaZjajFYJw?=
 =?us-ascii?Q?+ljVVrRNW8dPg1OywUhmql7HZm6Cgqn7Ny68CSeytmR2KI5y2br7bAwP44HV?=
 =?us-ascii?Q?JdwyMcsZ7xHESA/vLRovuq7LSaqz0DzPsj4Ti8V0e9K5MnVuN6rc0sX9VWPz?=
 =?us-ascii?Q?NgNaBKJwCy3TYD6eAAQopl8wSEpVdWzBhTH/R/dE4E7MiSM9Z5S1uHVgeGZ5?=
 =?us-ascii?Q?Rk9TSG9GWEplAxjYBrWDRxhWgyM60ua+vqU/HFQFXy/k3pEyLsofuky2LBrX?=
 =?us-ascii?Q?PhPck1UIIiw9w6529YDVMnBoA5abeWJuka03Bcr5x+6tuPFrUvZajuIECGmH?=
 =?us-ascii?Q?mtJXuUe7fslwr3A62vgseneivr2PZ4ih6Q7TPeIz4W93Ds/CH/VIbHb1g+9i?=
 =?us-ascii?Q?Ims0mjEFd/pKLgqgYTjqmg6g+eu2liHw+qTu/KKELbti0h1sgTyTpBX9ka/O?=
 =?us-ascii?Q?y3WTGG3dtxo4ptLSryuFCSbUG/gwUlvv4lXlUfFUa6o28OYYu2P87q6nmlXq?=
 =?us-ascii?Q?NVs5cgO1+4LLWSy07QpwI6+/Ewbbq/3HnGWaUtv8ncokwkCT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a217313f-d2ff-44ce-f70a-08de40b22008
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2025 16:58:12.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQV6RsJnjtvSyO5B+BIMcLJ9faevAthGCMiqOqPiVTrKmFkVKX+ZsK8UACHlhVhGy0QISF1cXtq0iflhtWmpxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510

On Sun, Dec 21, 2025 at 10:55:15AM -0500, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
> > Preference of nexthop with source address broke ECMP for packets with
> > source addresses which are not in the broadcast domain, but rather added
> > to loopback/dummy interfaces. Original behaviour was to balance over
> > nexthops while now it uses the latest nexthop from the group.
> > 
> > For the case with 198.51.100.1/32 assigned to dummy0 and routed using
> > 192.0.2.0/24 and 203.0.113.0/24 networks:
> > 
> > 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
> >     link/ether d6:54:8a:ff:78:f5 brd ff:ff:ff:ff:ff:ff
> >     inet 198.51.100.1/32 scope global dummy0
> >        valid_lft forever preferred_lft forever
> > 7: veth1@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> >     link/ether 06:ed:98:87:6d:8a brd ff:ff:ff:ff:ff:ff link-netnsid 0
> >     inet 192.0.2.2/24 scope global veth1
> >        valid_lft forever preferred_lft forever
> >     inet6 fe80::4ed:98ff:fe87:6d8a/64 scope link proto kernel_ll
> >        valid_lft forever preferred_lft forever
> > 9: veth3@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> >     link/ether ae:75:23:38:a0:d2 brd ff:ff:ff:ff:ff:ff link-netnsid 0
> >     inet 203.0.113.2/24 scope global veth3
> >        valid_lft forever preferred_lft forever
> >     inet6 fe80::ac75:23ff:fe38:a0d2/64 scope link proto kernel_ll
> >        valid_lft forever preferred_lft forever
> > 
> > ~ ip ro list:
> > default
> > 	nexthop via 192.0.2.1 dev veth1 weight 1
> > 	nexthop via 203.0.113.1 dev veth3 weight 1
> > 192.0.2.0/24 dev veth1 proto kernel scope link src 192.0.2.2
> > 203.0.113.0/24 dev veth3 proto kernel scope link src 203.0.113.2
> > 
> > before:
> >    for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
> >     255 veth3
> > 
> > after:
> >    for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
> >     122 veth1
> >     133 veth3

The commit message only explains the problem, but not the solution...

> > 
> > Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
> > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > ---
> > v1 -> v2:
> > 
> > - add score calculation for nexthop to keep original logic
> > - adjust commit message to explain the config
> > - use dummy device instead of loopback
> > ---
> > 
> >  net/ipv4/fib_semantics.c | 24 ++++++++----------------
> >  1 file changed, 8 insertions(+), 16 deletions(-)
> > 
> > diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> > index a5f3c8459758..4d3650d20ff2 100644
> > --- a/net/ipv4/fib_semantics.c
> > +++ b/net/ipv4/fib_semantics.c
> > @@ -2167,8 +2167,8 @@ void fib_select_multipath(struct fib_result *res, int hash,
> >  {
> >  	struct fib_info *fi = res->fi;
> >  	struct net *net = fi->fib_net;
> > -	bool found = false;
> >  	bool use_neigh;
> > +	int score = -1;
> >  	__be32 saddr;
> >  
> >  	if (unlikely(res->fi->nh)) {
> > @@ -2180,7 +2180,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
> >  	saddr = fl4 ? fl4->saddr : 0;
> >  
> >  	change_nexthops(fi) {
> > -		int nh_upper_bound;
> > +		int nh_upper_bound, nh_score = 0;
> >  
> >  		/* Nexthops without a carrier are assigned an upper bound of
> >  		 * minus one when "ignore_routes_with_linkdown" is set.
> > @@ -2190,24 +2190,16 @@ void fib_select_multipath(struct fib_result *res, int hash,
> >  		    (use_neigh && !fib_good_nh(nexthop_nh)))
> >  			continue;
> >  
> > -		if (!found) {
> > +		if (saddr && nexthop_nh->nh_saddr == saddr)
> > +			nh_score += 2;
> > +		if (hash <= nh_upper_bound)
> > +			nh_score++;
> > +		if (score < nh_score) {
> >  			res->nh_sel = nhsel;
> >  			res->nhc = &nexthop_nh->nh_common;
> > -			found = !saddr || nexthop_nh->nh_saddr == saddr;
> 
> if score == 3 return immediately?

We can also return early in the input path (!saddr) when score is 1.
This seems to work:

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4d3650d20ff2..0caf38e44c73 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2197,6 +2197,8 @@ void fib_select_multipath(struct fib_result *res, int hash,
 		if (score < nh_score) {
 			res->nh_sel = nhsel;
 			res->nhc = &nexthop_nh->nh_common;
+			if (nh_score == 3 || (!saddr && nh_score == 1))
+				return;
 			score = nh_score;
 		}

Tested with net/fib_tests.sh and forwarding/router_multipath.sh

> 
> > +			score = nh_score;
> >  		}
> >  
> > -		if (hash > nh_upper_bound)
> > -			continue;
> > -
> > -		if (!saddr || nexthop_nh->nh_saddr == saddr) {
> > -			res->nh_sel = nhsel;
> > -			res->nhc = &nexthop_nh->nh_common;
> > -			return;
> > -		}
> > -
> > -		if (found)
> > -			return;
> > -
> >  	} endfor_nexthops(fi);
> >  }
> >  #endif
> > -- 
> > 2.47.3
> > 
> 
> 

