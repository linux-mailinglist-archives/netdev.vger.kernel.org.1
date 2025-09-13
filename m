Return-Path: <netdev+bounces-222802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FE2B56286
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 20:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F76480C05
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B8F212576;
	Sat, 13 Sep 2025 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CFOYhI7s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEA1C54A9;
	Sat, 13 Sep 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757787818; cv=fail; b=Z4lLMrVTQx0r2V/Pl6VjxRwq5nXZyN5DaP2l3wlugmLKygLzsWtElc6rssFSZJG4tWCWfHhxaEugMQpb+FXqB0ylv99iAotA+ESlFiERVt6fstN0LRaCQLdhV1BdRM2stROrXRYejO9FT2KyFbWzeSqvM9JEQPoPw10OivjT8CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757787818; c=relaxed/simple;
	bh=GoMhw6KVN9jiB31VQ31JdtiiK/WQ14QGEFQ+UxbqZU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NZe3DFUWGZj0YqVIACy2dEr1hs+/CzwQQfcDQ3AdWlbvLqYdKR6znmeYtDXJdY6mMnlbtaOePuWTogmB5ZNO239iF6289L25OvwjMQCYmo4cXVxQPUtsRkZTRNnu/mtRsYN+1iAaot5Ih3c6zS/Uv95VzyUBFCBt4qxQ3/rfw6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CFOYhI7s; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QryYSudqxxPbSOc3IPreg7M7flJ4+tkgz/QhQvirSpgpcEndC5NL0seOVJHJhFYZVLqQGHqIU7iH6DS7HgEeXIIBTMYO91/LqEelFpZ8Hl9Nm9R2pdQHgxsXe5pkw0GYjbtMrduCDEnQvJbp1WKwuXWrZMK39pfLuiGT3FmgyxU/SNt1gMn7tedATwKM94kAsCnF5AUNFTo7Ctko6t+k3T/YA+cQyfdxVA316vbqIG2YCrhD1hTx887vkJe7tv0prnvcPVS5gVy4kJVJaP6RT5Yjdqj1TX/siXATi+TPiQCyaHjc62PW/hT3KCbXaHcTCV3RZB7/zjFS/H/njo/R7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lMLNjb0xOcHuYmBPajBfXrlwciIuh+02MJ5LIVt4kM=;
 b=wJRna2eT4OLSD15GF9mXemQ9AJy7c+yeUbLBjImZS0Bv9E8GDLSG/HKvH3/IzCR53oFyb9+1n6TnvzAMg+DwTLe7ghn0B2SEtJIeirPZf32a1KFuEGRDcMvmtyITd+9+6gKd9rGKPVQkphBBOQC40XaMEufU5gArWaZCVCcnK4EuRNihNiGRekd+1oQRPjDDNkPOH3Pw/aVS2kuwiBTXFKBsTtHoBVvWdVE7jhIGyElw9VAMuydSvLgGEMGeK6LSWfxXlW7RibOT2C7uqdrkVk82AC87MAvV/tU/HTOMvg3GGr0xZeApCHVI/JN5yhcFNiLCH0MTBOS5PKhl48XtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lMLNjb0xOcHuYmBPajBfXrlwciIuh+02MJ5LIVt4kM=;
 b=CFOYhI7smbfp+ESYvmBKTAlbkHa0gJNt0B4LJrFhTqYrDURSRu85pHCE/GKVW4bYcbZTSe6sgBg7DaH73Ztr54JDzWV/F5gg8S7jK+MTvczmK2hbIMZc/PpLciofbD6MMnYSh9rfTkFXah6X/NBzrtJc+5eUBafM4P+sTG6X04kh6WMMnCfU4rP+sShRETtY5xKzjAnvwK5jpcGKI42aZVcVrGbIKjuH98xixaELhNG3M5+SoRf1ku6us453YalUJ6BlbIQnyxZSTRTzJAgo7+7hHWHThOQoznK3VWbifI6ztGYO6+Dk2B16+DykbOvNY+7AxwRIGuwcH/975WdnxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sat, 13 Sep
 2025 18:23:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 18:23:32 +0000
Date: Sat, 13 Sep 2025 21:23:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Joseph Huang <joseph.huang.2024@gmail.com>,
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
Message-ID: <aMW2lvRboW_oPyyP@shredder>
References: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
X-ClientProxiedBy: GV2PEPF000045C0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::446) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: c6aed0e6-3d5b-4ff6-7149-08ddf2f2a558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGeIa2myE8IsYoCmN3VPc4ISWUMl7eCitQnIvr89dKEr0NoXm3S7eXWos/Rp?=
 =?us-ascii?Q?34i9sUehb3oWqUGgbc82BtEcDr/iCQ+UnoyUUlcvuES637llKUOPFFXQP0p/?=
 =?us-ascii?Q?91D6TmuGk0CyfiHCIKZCUs19CNT8lrkSDPmN66JYviwomqLjZD6PZqAqjA7h?=
 =?us-ascii?Q?wuMDB4tZcmMd/ZvH9wnGqIc6qbf90OlH+zMlwIHowVcZilIv5+x8BRHg20jK?=
 =?us-ascii?Q?8UltpKobuyxoWtmSEs6LQoqpB/YqOTMQ97jOhR88oeoWQKpve8dzx7K3mD+0?=
 =?us-ascii?Q?bfcrHD8bj5V4xmhgBxZRlshJDWr24UUiRh4nHfNtrTJyxvSHLm9zTNXVKzpl?=
 =?us-ascii?Q?rXenSYlr+C4gHdcKowKlBKsEKgjea3HLXrMWLg4ysTtlwRukvObchwZNJdrT?=
 =?us-ascii?Q?2hFQhmpN+csb2CN0xFw+hENWPM3J2gpN0o9x4MgCSUHeEngS/Qoajfsp9owN?=
 =?us-ascii?Q?ooQ5VpJTcEXq3gdUb9qHhkilh7Fkmx3kvBiach/8rAudsMU8U1WFpfhPlmVH?=
 =?us-ascii?Q?QJRbu2pHP9suf8GELFz8BDmcuWlFaCjNyPwkLUzH8DijnGNHfGn2uwmot10K?=
 =?us-ascii?Q?HD+1i/lteaXerUkkFBHQyUZUDfJpFIVuOVEn9RCkqTjSH/c8FpPRWFPLr4pF?=
 =?us-ascii?Q?Uly3SKkd3AE0GHXL1s088MbZT4L4oDth78lczUUaN45iArYVv+28nMjd7vH6?=
 =?us-ascii?Q?PMzjckW0AAufVGbIk4C4nDLaUT1V20eFgdJuo/QVPuJop2agmOrTq5yvpHDP?=
 =?us-ascii?Q?/OVO1rJZ7jixaROes17my9yeSCnhUgDuH2zobGrF3zjEAqpqZo04pEiszaub?=
 =?us-ascii?Q?EuoxO1pw8gO4p60PW7syG9zuCvJf9Ss+9k9NgVfYYHukz23En4I8ATuEg7n/?=
 =?us-ascii?Q?N7UUaPQ5VSnKW1QFPa24B6sgZ3DWXBBDo/yY2e0rhSvZMYVLjcHxFHPrV64N?=
 =?us-ascii?Q?hrYrk21qf0+tVwPVHXJx+9MkhvAJ+cO3z2/TyByDncgNGljAGYtCaOR4nuXe?=
 =?us-ascii?Q?tH5eNKt9a2mbk2xpAelIFjreWU4rJCjXLO6FvRDpzzQBEggUOEd6nbbQTSiM?=
 =?us-ascii?Q?K8oO97cqzk8PHjXCWG7XDz25+tH1m5KJ3d37mnUJo455DJtQbZnjlVNkLZST?=
 =?us-ascii?Q?Nta1nSYCI2i1IHO/k10/pXSU9Rv99aDBXCqPvIl7x7UDYskqOzHWZ9Md6v6l?=
 =?us-ascii?Q?o+V/xLFuxyyrYIuFoCK2cMMCpGwQbGVUOBwiceCUGN5Mo4By/IWrBWGHuR1d?=
 =?us-ascii?Q?1dbmMxZkI/mLGdOyzI4UxgN8PVIporCyd7o30MKghJu2BldBvNAbJAmXGx4g?=
 =?us-ascii?Q?tISGcrpWrqgeTkm18BxNeDnnVM36ysQG39KNrV4t1ROLFf4dMI42ClGyQvSC?=
 =?us-ascii?Q?cC/n1ON3zYmXFcLQIFqGPf4kQCmoJjOekY2HVib4RKt39DpDDxI9ruqXTlH7?=
 =?us-ascii?Q?N/4sI13I7Sg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?78T46ZjRqv/cOUUWLcE0GEijh+Fo5Nl9BEApvThefa8DegMkJMEVmv7IYYVO?=
 =?us-ascii?Q?CxSqsD7SnvTAODP9XbR23TVdWYQZZENLuSxEnQqFmFzRvfL1/EBvFggeh4wP?=
 =?us-ascii?Q?YXLsbH6RMN0w1YAAEi4P47peQH044S6cdAtH2zd3YIV2W0aNmaieTp/OGT8G?=
 =?us-ascii?Q?xfYErTxXeZ9gcccfJarTE7mJAltt5wUq++WEiiTV5VdzODkS3iYlC9yhv1we?=
 =?us-ascii?Q?PpyzG8bTCPm0u8N1FcZxLMrDwEnq5+O8KVE/rGKfGjTx/DCZJEN2NVL45moG?=
 =?us-ascii?Q?F5hetdMRXXA/c//tQ8KCGlff4rzXOaQpUQBlvyHML5JkhGEsUKaLAQ6FkCB3?=
 =?us-ascii?Q?j1bduw2pusDy3gBsh8o/NeifWCi7XXiHPAuu9v09nDni4BrPjlDQNkea4vTl?=
 =?us-ascii?Q?Dy37bkJu+49qVrTletNeJiAxHYjEE0UREjKewtLmJfawz+F54Z899Cg9iCCs?=
 =?us-ascii?Q?KaZLDMi6HcQL5vpXth2wGr6tb80s9BSbzh9LD4NAV0bYmEPix9mku22uVhLY?=
 =?us-ascii?Q?xBsyEr+UBVYE+Wu4ni0v8cQvhQF9YThxjqNcnh4ISAK2IrDoiOOg8XxN5gQl?=
 =?us-ascii?Q?MdTOYYdP6o6Nz787qTrvajQQ/EB3pngfpUL+7fetUfTetgPlzj4nDS11ae4l?=
 =?us-ascii?Q?4Za6rM5VzI8Aau3La7T6MQytlSfpAcf0q0RyQB10j4+mhDhl4/hS8cAsltK8?=
 =?us-ascii?Q?VZNUB3aYUdCBqFU3P+1+ohbwH50ccECmpl6KJ1AncToJQEBgi/XfTAKZZfxf?=
 =?us-ascii?Q?3SIoUl3YoElm3fOjs6Uz0n0TTzFBlCVsf3dhKRxRmM+ubKJ+n2Ng9B4OLApN?=
 =?us-ascii?Q?wK3/v/iN+RfFc2o4e+j2gMzBrJTuyijpj4KC+mXfIYAAmv9mwGyWNSyZbPWf?=
 =?us-ascii?Q?92XJC17A/EunBPpiCdWb1umBL0Ueuep/oILpHswE2Kq4v4woQPhOC5rA/TVe?=
 =?us-ascii?Q?MSdbZuMwHvach0+8UhoTvfjliJYOcQyxkHM7sZsurYMDKMBeQVkmOegKy6nZ?=
 =?us-ascii?Q?o6SARQNHmmwGX+yjgIcqS74mScTc4/VAVxcxDAv2/+OWvFMFL84IP+uPkjac?=
 =?us-ascii?Q?3pr3KTEFUUHrBG2F72vvpr86GAO7jH7vSSTWSf34/La5xLymMTh2rBYJTL9j?=
 =?us-ascii?Q?r9GhYfB67BktXsitvCoR61Xv+f0MEroW8b2BYoryhIWe1LrgRQY0GG6cha4J?=
 =?us-ascii?Q?uBRgHKOktIV8XYrgFHHVSELa0a7dm4N75zru1XDe72zBC7eGXmPhaphET8Lp?=
 =?us-ascii?Q?f6x2j1rmp8XpV2X9Mmd/58HRgfCY+vGoEycOJF0b8Q+eDnpGrzrxFulqjIus?=
 =?us-ascii?Q?D6cevWU3m4VGbe4+DbntcUea/eP0mUce90LST4ZDHK2rlr88D5W9VCR5PT24?=
 =?us-ascii?Q?AFA5VSXIXYIrvc9zXUuBxnakIaeZceqw2qh/79YRdma8/TiGrlBEBiBmug+k?=
 =?us-ascii?Q?TLyep7M2lf/1KCypa9LnSjj1gByd+1EA14AEa7GOtlGwpc0rb45+9o5UI05M?=
 =?us-ascii?Q?/VEaID9uoOYMVjo5OlKQbmu4WS5oHsY8/HIff7LrpBcHTKwsy0zgZHex29ST?=
 =?us-ascii?Q?usRCRQIkP3wLTYxr+7S4LniMICMUC42suCHp/LC9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aed0e6-3d5b-4ff6-7149-08ddf2f2a558
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 18:23:32.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hb8D010cvm8ZiMdcQpPOMxr9dA5ujJJh5Kd9wwbCCiDc/npM21QCDfedtiaCQNCZZf6EkSleRcwfB+Dk2JVMzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348

On Fri, Sep 12, 2025 at 06:39:30PM -0400, Joseph Huang wrote:
> Trigger the bridge to (re)start sending out Queries to the Host once
> IPv6 address becomes valid.
> 
> In current implementation, once the bridge (interface) is brought up,
> the bridge will start trying to send v4 and v6 Queries to the Host
> immediately. However, at that time most likely the IPv6 address of
> the bridge interface is not valid yet, and thus the send (actually
> the alloc) operation will fail. So the first v6 Startup Query is
> always missed.
> 
> This caused a ripple effect on the timing of Querier Election. In
> current implementation, :: always wins the election. In order for
> the "real" election to take place, the bridge would have to first
> select itself (this happens when a v6 Query is successfully sent
> to the Host), and then do the real address comparison when the next
> Query is received. In worst cast scenario, the bridge would have to
> wait for [Startup Query Interval] seconds (for the second Query to
> be sent to the Host) plus [Query Interval] seconds (for the real
> Querier to send the next Query) before it can recognize the real
> Querier.
> 
> This patch adds a new notification NETDEV_NEWADDR when IPv6 address
> becomes valid. When the bridge receives the notification, it will
> restart the Startup Queries (much like how the bridge handles port
> NETDEV_CHANGE events today).
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/linux/netdevice.h |  1 +
>  net/bridge/br.c           |  5 +++++
>  net/bridge/br_multicast.c | 16 ++++++++++++++++
>  net/bridge/br_private.h   |  1 +
>  net/core/dev.c            | 10 +++++-----
>  net/ipv6/addrconf.c       |  3 +++
>  6 files changed, 31 insertions(+), 5 deletions(-)

A few comments:

1. The confidentiality footer needs to be removed.

2. Patches targeted at net need to have a Fixes tag. If you cannot
identify a commit before which this worked correctly (i.e., it's not a
regression), then target the patch at net-next instead.

3. The commit message needs to describe the user visible changes. My
understanding is as follows: When the bridge is brought administratively
up it will try to send a General Query which requires an IPv6 link-local
address to be configured on the bridge device. Because of DAD, such an
address might not exist right away, which means that the first General
Query will be sent after "mcast_startup_query_interval" seconds.

During this time the bridge will be unaware of multicast listeners that
joined before the creation of the bridge. Therefore, the bridge will
either unnecessarily flood multicast traffic to all the bridge ports or
just to those marked as router ports.

The patch aims to reduce this time period and send a General Query as
soon as the bridge is assigned an IPv6 link-local address.

4. Use imperative mood:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

5. There is already a notification chain that notifies about addition /
deletion of IPv6 addresses. See register_inet6addr_notifier().

6. Please extend bridge_mld.sh with a test case in a separate patch. You
can look at xstats to see if queries were sent or not. See for example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aea45363e29dd16050e6ce333ce0d3696ac3b5a9

Thanks

