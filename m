Return-Path: <netdev+bounces-165555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24BA327F9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93A91648EC
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760C620E718;
	Wed, 12 Feb 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MbWJqNZl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DF2AD2A;
	Wed, 12 Feb 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369253; cv=fail; b=H6RO1V+gMzgIhk3PNT5gLglrWsyMAjeufF/FiYfHZXbZjDxpxTC731L1KrKzFZf0ygZRYrkB8P3umAVOlZiv+MtPGFS8HRt6hj80dLi7irgZeOqq8qXLeMKj0uYjmZf865uJZTBNhKV9rQiLaDV4BeNJVVCjQOm8YuRGfs08LVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369253; c=relaxed/simple;
	bh=fyBNE22IB466ttLX050co0MlvmvKZvVFevGj08Nhx0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WyZu5d+pbJhrlCRsVs6OlTh6H1qo51MMG3kIajhHqncUNbZZQLLi+GkCdn3/MVNRvgRmJxq3Mi1pKbVX4h6HiLD4Kr1Y/pNNGJpYHRlyaQ2ZnGv9dqgBrdJnPpPop6UPc1MVumizjpbfdXkrRNaJAfapiv/f59PklPnBqjnE4Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MbWJqNZl; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqJmRZR1xaUbDyAsek9rFeapC8lxVj/a2sa8QE0Tf4m4tMlcQwNKOvPdzkkAOMu/QNKqftg26zOgZC2PvzSGRMeuUggiE3iVFBtQVJryNIASa4QhOGyNQn3Eji+xRUUN9RT6zOX30UhADRraENh23e8TiltHIIChPGdwpeZRyU5aF+Ufwe4PdPm3ZjFbxQ6YFudW4n//AtJPbfiwFgsUEUrYg2orE9RlULkgin6kcGwKFdwLzrmL62sUsdpH4/W/XitWytL2Y14QBzltCkypgl9nyeGnIIpbizAazEowOlA6CP/P5YSwXLwIZWnY+sseL93fsJqOikh5Ua19Blfq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtHTHFJGd9vQWYz4qO/RjQyfPF47uj8KBfY84+j9mpk=;
 b=KhlJ0ezgcUdp2egryPmEW2y8d5SgLc8CMAiqCA/imez9VBVLwh7Hs73lxb9gYq7NmsGCGM6RJ8MS8VElrwtOsbSDxdqHWrVNPKRtUSKAhZJkHS5JpaZvfLeOqqO3M5qMa1Lj7q4FgQ0iMJG6HFsvqkwhjNMXLQz/MMk9b8fC+MfOnDZuIIcgZIg9FSYe9HZp4/PeTVA0FvkJQ1hHfmekmFDsnkosRU7Lax5gu1u4WeLXjbbQDt0cTCSgsFN1k9Olz3IHa9oRiJbDU2tyCj21a6fR/IZc/qbj9IL1+PeP18XsmVrfxohaMCNsK3Xnjl4lF8ljVM275fBzjc2pjRYGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtHTHFJGd9vQWYz4qO/RjQyfPF47uj8KBfY84+j9mpk=;
 b=MbWJqNZlnUhq086gVNAdnVNdl/web9qH2yvG9/sc+cDppDIdyIBzhr8STWZ7qe9FrwtU2GFrHGYe/PFYIgrMeZqq/9XvZNWCWgVDJL6+6cCyj/amzHsNWvx8Uh3Q/AXNWnPITUI33rLDtnnDzgcL3At7nYfidsTAtcom/YcD8g8uJKNAU6GmNUfpZuw97dezi7T3hXi1ACVfOVrLFWkOhXF6Ry0e13ZYCw/7o9Y7SFsVKOlQ38CcCYZD3ud+d3to3br7BDo/8JLPxXoazkv8zrsNrEMGoRm4z2/AWLjooGJtSpHsELydi/56Mw1XP0V44fLGmB9ZSh2ldMbrcr4YFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 14:07:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 14:07:24 +0000
Date: Wed, 12 Feb 2025 16:07:12 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, amcohen@nvidia.com
Subject: Re: [RFC PATCH v1 net-next] net: mlxsw_sp: Use
 switchdev_handle_port_obj_add_foreign() for vxlan
Message-ID: <Z6yrEKgtv0xQfMDF@shredder>
References: <20250208141518.191782-1-ericwouds@gmail.com>
 <Z6mhQL-b58L5xkK4@shredder>
 <20250210152246.4ajumdchwhvbarik@skbuf>
 <Z6tfT6r2NjLQJkrw@shredder>
 <20250211152353.5szhbv7kdlf6bca3@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211152353.5szhbv7kdlf6bca3@skbuf>
X-ClientProxiedBy: LO4P123CA0422.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: c7520903-7c50-4206-64c3-08dd4b6e92c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JKr0PAIAVsIG7WJ342t3BXeTR8uekO//Bm9fRTNt3D6e1e5NVfZ6fWfD1XHU?=
 =?us-ascii?Q?RnR4vxCrdc44OWdRxdi4ij1TvSoeZDZOCx6w3B4yY5UcbUlL0cY5ToAPHOei?=
 =?us-ascii?Q?+8oarsR1GL1OlI74jkyztJ+9ZrLnkwoqY/XlcrBf7YBV8KLyFriryTN+qF8m?=
 =?us-ascii?Q?ESAvdA97b63QIu+1N4NXVYZqHPPz/7rpCaDmixqkP5/iOdq4fe87jOZrszq5?=
 =?us-ascii?Q?UgBqRQHcT3q48OJWe6S7iei6a4yp4u76YXdQSrOzqg9tZBx50ZWnD66dIZb7?=
 =?us-ascii?Q?eZeaKZY5YIfmTFC1WEzeAyy4JS95km4pN4P/h/BzlFjTgA1mBHRJW9X+ZGAd?=
 =?us-ascii?Q?k/jArJHLIEkldMGUm7wMz/ElR20MSuXgJUYSukRvA8bIBstho1dAmunxQwwD?=
 =?us-ascii?Q?M8DqhzCUrtzALmAA8mJz2m6P4yQV9bKZfxC/Z7nLHkuJgFO8wTTHReBotd77?=
 =?us-ascii?Q?Se4P5IjmsuWy8veylKbiglvw4gtt7Jssz874HWdUYPVV9N/dlhHMDyE7JQ2S?=
 =?us-ascii?Q?AXzJ9OAA3aIncP4kbQKOKV9dihSEjFW/vPZtimwHcNTAmNmPzTlxLmCXqUL8?=
 =?us-ascii?Q?hDZwr4DjNdz9pKyurm3EFDjKv8sNJcuQHnenZGn2BDN8hsWWaeo7wzJhyECI?=
 =?us-ascii?Q?Ghl4Db1IAQfmk1NocOdngOQAsHqoYme9O7qxAI80DZawODHSQHxNNrXS0mMb?=
 =?us-ascii?Q?rXsW02Aq5vlKr2rVRjK7OsSJYuXFdEP/xIQoxUIUiCh4g1uRf7EGUWkqsWid?=
 =?us-ascii?Q?rQoLP4dp4yyN4NrD5TjGJ4wCoa+UE165tKTP6JjbAQ16OR8RrJh0jATDoNym?=
 =?us-ascii?Q?PqqhFLSL41uPk01EWWFHOGewsXzuVD+yjKhWXsrfSID5kwCZVbxdlxsDszpc?=
 =?us-ascii?Q?hWtpE7HV6+Ulfup1c7+qRC3Tr9PzGLTkqe71M313nGJF8tC9YBWkB11luUuO?=
 =?us-ascii?Q?ztf23myRMGiz3dLJbQDzMuYads9PbiUuX7Hf99NfGFKL+JKx3K714CWKNvwg?=
 =?us-ascii?Q?JUB15UujSaoahJ3MuqKb93PILZ3Ha6Bkp0i0SBsXO+2laYIC0oQY5VIK3He0?=
 =?us-ascii?Q?aw5cjjRWwMHaaGTN7Cy/Uw9YSX5+XnRVV/SV473TPuK9F7rwL/jwPToc9Ba5?=
 =?us-ascii?Q?xiHJtY+jIax2WcGzB8dLY93xly5JyRbJv8nJuunvY8iNZqn/F5a5jEvISOrC?=
 =?us-ascii?Q?/3nzoMwHHunpie90mrxqdcleuIcGxTY3SYMFXlTfPj6B3fJ+hw7dQn/VjtiM?=
 =?us-ascii?Q?dxcR91SK5Ahr4aHuW0SmTfmu9MRDqXw/cePKbzLicHqM/pAx27gWsQM/8pXL?=
 =?us-ascii?Q?j+ukjn8sMT9iZFFze8bJAVtPmcCpZItvCxVvbex+nwsMgHpOnZqMsBoQUiKF?=
 =?us-ascii?Q?pjog3ePuLRBMhJMoazeJy9nofqSi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wuBnDCqs23B6HBsvwPtjMdvb4HB+Z6R6gvD/f5YV8VW4/0WU/OPkXkPsVNFq?=
 =?us-ascii?Q?p6ZdgXnJjVtq4qBPTgbtNuHo90ow7KtZ1PbvYXaTsTiwrbg6I/EFgsq+U0Yi?=
 =?us-ascii?Q?6B0LKZLW08rmELB+lWzXX1k/I50iscAEnPeXcWykRCnMjbQjd2va7WzGzw6n?=
 =?us-ascii?Q?1VuvMpFj2KUpFVV1akKrLwUqKvk17Ow5m70pgo7Otn2R5k7DD4+9VycfI7SX?=
 =?us-ascii?Q?Vh9UtsfOYo5bpdFPOPjBEILx8kdulLD98rrNfA2Jxm6jAu779VMr5yqKU8uK?=
 =?us-ascii?Q?gg97h5kYjZK0DaDYGUEf7ABvOVPf6idjh+ih2sUYAvqD38S6+ngPP5ZEDoRC?=
 =?us-ascii?Q?Qh5DlUjl8zQtuiX2FHIDbwHk2LxPvAMHqzPBQCVNSLu2vaiYv/OfzbilEvVt?=
 =?us-ascii?Q?19AiWIwLiL5Txf9UxsMOHpMjFQbF90fE/++GNvNkxV7GNQNAXeBLtONSzPLf?=
 =?us-ascii?Q?ESj3QQwbdmJNf+rlRCu2xnU6tFssAab5c3clEV0DuzZ6cSHVsWhdC6EbGzAo?=
 =?us-ascii?Q?YvP3p0CN17XSWTM3scGrBKYXyjR5TgGz9KzJupBZNx0qMa41SjkEe2eeXRNR?=
 =?us-ascii?Q?3QM75RhPL1E5QI8D7RpcEfvmxDPOy9JSUvn7y6qRJPCf1ncNsj11Q651O3bq?=
 =?us-ascii?Q?kgkPq9FCDJKaRCOgpfAlPGt01n2mhq7JuwgpytLIcHNEU5ETJdN04IX810CM?=
 =?us-ascii?Q?DOrquCub4vVa68LqR3cvsJH8BmrznmbDXhJyv6Bjna8b0JGOuuTjjdvX677w?=
 =?us-ascii?Q?iVMP1mVPniDKRdQPqVznsBOD2OXdz27Q745d0AumNXmUeC6jVzigIw5V5SES?=
 =?us-ascii?Q?TMUSPTLW4bDPSgt7dmGaNOXn9Hh+S9LnsrTIytpmcu5zLmUIgM9zbVnSlr8L?=
 =?us-ascii?Q?j16amgP6mgCns3+xuJin7a1ic2WG6kGuT0lcXtebGFEevJob58157Ff7Fb+u?=
 =?us-ascii?Q?IfEq097NGtuIB2f9HuVIdbOEbC0RB3MzLGLF3N0mOf5TB5/35pxo/P7A9fFQ?=
 =?us-ascii?Q?5oOrKBcs5xaQc71Wd6Do0jIP/URqubp9PXFG3c6nObWcxwvfHpFgF+5cUjG5?=
 =?us-ascii?Q?Phc1/JZFGrWPH0hWYwtIJ8nEg7bi6Az4F+XKecNAS8d7QPZHC6DXNanvrgE5?=
 =?us-ascii?Q?PR6CNikkr0CDEoUFcW53/zwO5/S3ZrDW947leJ46kF2S3PcDjvIu1KgY4n6Q?=
 =?us-ascii?Q?EhhSrzX7Y5o5hNu2tVD8NMlYPdMgtkrwhki1WA5+mhG2tH7f3Qz+M2gyIYQG?=
 =?us-ascii?Q?cuNENqmtETzKnavMYHF3DHG7xSmO6MrJirzGqIApZmTuEmKw3k/Rg0d9yT1F?=
 =?us-ascii?Q?4eUt7NvH05NIWmWZwH4yp7z6SZfaI6v4Ym8QViAr80ErTU7vvXqPVAvuk/bl?=
 =?us-ascii?Q?4wiPFB2h5pPB+7mpPDgHuzIdMCySgf9EUpjiuSTOraeDWhwDotb1DGceRPB9?=
 =?us-ascii?Q?xXFMtS32KC2GJ8g37grAYvbjoe5l1KpazgP5dJlwzQ6F3Q90rvdUNesNjvvE?=
 =?us-ascii?Q?4u8Wi8m9ou9qTZxxuTRQixsxDc74Qa6SfAKIrRxTLAsFrH8eu3BerY5dM2kF?=
 =?us-ascii?Q?HXss2hKP2N/wOs7MisNtEONeF1H+PKRI2uvHhsFi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7520903-7c50-4206-64c3-08dd4b6e92c9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:07:24.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wf098OOTgVTaZJc0sBWiJ8fgvxmgTxUqNiW7qqSCzEo88NGNtSIePJdGp0pZnWVXpn0dknc7O7kH2VR8HiDYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824

On Tue, Feb 11, 2025 at 05:23:53PM +0200, Vladimir Oltean wrote:
> On Tue, Feb 11, 2025 at 04:31:43PM +0200, Ido Schimmel wrote:
> > On Mon, Feb 10, 2025 at 05:22:46PM +0200, Vladimir Oltean wrote:
> > > On Mon, Feb 10, 2025 at 08:48:32AM +0200, Ido Schimmel wrote:
> > > > On Sat, Feb 08, 2025 at 03:15:18PM +0100, Eric Woudstra wrote:
> > > > > Sending as RFC as I do not own this hardware. This code is not tested.
> > > > > 
> > > > > Vladimir found this part of the spectrum switchdev, while looking at
> > > > > another issue here:
> > > > > 
> > > > > https://lore.kernel.org/all/20250207220408.zipucrmm2yafj4wu@skbuf/
> > > > > 
> > > > > As vxlan seems a foreign port, wouldn't it be better to use
> > > > > switchdev_handle_port_obj_add_foreign() ?
> > > > 
> > > > Thanks for the patch, but the VXLAN port is not foreign to the other
> > > > switch ports. That is, forwarding between these ports and VXLAN happens
> > > > in hardware. And yes, switchdev_bridge_port_offload() does need to be
> > > > called for the VXLAN port so that it's assigned the same hardware domain
> > > > as the other ports.
> > > 
> > > Thanks, this is useful. I'm not providing a patch yet because there are
> > > still things I don't understand.
> > > 
> > > Have you seen any of the typical problems associated with the software
> > > bridge thinking vxlan isn't part of the same hwdom as the ingress
> > > physical port, and, say, flooding packets twice to vxlan, when the
> > > switch had already forwarded a copy of the packet? In almost 4 years
> > > since commit 2f5dc00f7a3e ("net: bridge: switchdev: let drivers inform
> > > which bridge ports are offloaded"), I would have expected such issues
> > > would have been noticed?
> > 
> > I'm aware of one report from QA that is on my list. They configured a
> > VXLAN tunnel that floods packets to two remote VTEPs:
> > 
> > 00:00:00:00:00:00 dev vx100 dst 1.1.1.2
> > 00:00:00:00:00:00 dev vx100 dst 1.1.1.3
> > 
> > The underlay routes used to forward the VXLAN encapsulated traffic are:
> > 
> > 1.1.1.2 via 10.0.0.2 dev swp13
> > 1.1.1.3 via 10.0.0.6 dev swp15
> > 
> > But they made sure not to configure 10.0.0.6 at the other end. What
> > happens is that traffic for 1.1.1.2 is correctly forwarded in hardware,
> > but traffic for 1.1.1.3 encounters a neighbour miss and trapped to
> > the CPU which then forwards it again to 1.1.1.2.
> > 
> > Putting the VXLAN device in the same hardware domain as the other switch
> > ports should solve this "double forwarding" scenario.
> 
> Let me see if I understand what you are saying based on the code (please
> bear with me, VXLAN tunnels are way outside of my area).
> 
> So in this case, the packet hits a neighbor miss in the VXLAN underlay
> and reaches the CPU through the
> MLXSW_SP_TRAP_EXCEPTION(UNRESOLVED_NEIGH, L3_EXCEPTIONS) trap. That is
> defined to call mlxsw_sp_rx_mark_listener(), which sets
> skb->offload_fwd_mark = 1 (aka packet was forwarded in L2) but not
> skb->offload_l3_fwd_mark (aka packet was not forwarded in L3).
> This corresponds to expected reality: neighbor miss packets should not
> re-enter the bridge forwarding path in the overlay towards the VXLAN.
> 
> Yet they still do, because although skb->offload_fwd_mark is correctly
> set, it only skips software forwarding towards other physical (and/or
> LAG) mlxsw bridge ports.
> 
> If my understanding is correct, then yes, I agree that making the hwdomain
> of the vxlan tunnel coincide with that of the other bridge ports should
> suppress this packet.

Yes, the above is correct.

> 
> > > Do we require a Fixes: tag for this?
> > 
> > It's not strictly a regression (never worked) and it's not that critical
> > IMO, so I prefer targeting net-next.
> 
> Yes, I agree. Before that commit, the bridge would look by itself at the
> bridge port, recursively searching for lower interfaces until something
> returned something positively in dev_get_port_parent_id(). Which was a
> limiting model. If anything, solving the "double forwarding of vxlan exception
> packets" issue would have required an alternative switchdev bridge port
> offloading model anyway, like the explicit one that exists now, which is
> more flexible.

Yes.

> 
> > > And then, switchdev_bridge_port_offload() has a brport_dev argument,
> > > which would pretty clearly be passed as vxlan_dev by
> > > mlxsw_sp_bridge_8021d_vxlan_join() and
> > > mlxsw_sp_bridge_vlan_aware_vxlan_join(), but it also has one other
> > > "struct net_device *dev" argument, on which br_switchdev_port_offload()
> > > wants to call dev_get_port_parent_id(), to see what hwdom (what other
> > > bridge ports) to associate it to.
> > 
> > Right.
> > 
> > > Usually we use the mlxsw_sp_port->dev as the second argument, but which
> > > port to use here? Any random port that's under the bridge, or is there a
> > > specific one for the vxlan that should be used?
> > 
> > Any random port is fine as they all share the same parent ID.
> > 
> > BTW, I asked Amit (Cced) to look into this as there might be some issues
> > with ARP suppression that will make it a bit more complicated to patch.
> > Are you OK with that or do you want the authorship? We can put any tag
> > you choose. I am asking so that it won't appear like I am trying to
> > discredit you.
> 
> It is completely fine for Amit to take a look at this, I could really do
> without yet another thing that is completely over my head :)

Great, thanks!

> 
> Just one indication from my side on how I would approach things:
> 
> Because spectrum bridge ports come and go, and the vxlan tunnel bridge
> port may stay, its hwdom may change over time (depending on how many
> cards there are plugged in the system). Also, it probably won't work to
> combine spectrum bridge ports spanning multiple cards in the same
> bridge. For those reasons, br_switchdev_port_offload() supports multiple
> calls made to the same vxlan_dev, and behind the scenes, it will just
> bump the net_bridge_port->offload_count.
> 
> Thinking a bit more, I think you want exactly that: a vxlan bridge port
> needs to have an offload_count equal to the number of other spectrum
> ports in the same bridge. This way, it only stops being offloaded when
> there are no spectrum ports left (and the offload_count drops to 0).
> But this needs handling from both directions: when a vxlan joins a
> bridge with spectrum ports, and when a spectrum port joins a bridge with
> vxlan tunnels. Plus every leave operation having to call
> br_switchdev_port_unoffload(), for things to stay balanced.
> 
> Probably there are tons of other restrictions to be aware of, but I just
> wanted to say this, because in the previous email we talked about "just
> any random port" and it seems like it actually needs to be "all ports".

I think that "any random port" is fine as the second argument of
switchdev_bridge_port_offload() is only used to derive the parent ID
which is the same for all mlxsw ports belonging to the same PCI card.
And yes, it won't work if you combine ports from different cards in the
same bridge, but it's not really a realistic configuration. Packets
entering the bridge via the first card would have to go to the CPU if
they need to egress ports belonging to the second card. I don't know why
anyone would want that. A more realistic way to support multi-ASIC
systems is to reload each devlink instance (i.e., ASIC / card) to a
different namespace via something like "devlink dev reload
pci/0000:01:00.0 netns ns1" or use PCI passthrough to assign each card
to a different VM.

