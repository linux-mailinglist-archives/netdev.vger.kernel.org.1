Return-Path: <netdev+bounces-285160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGaUHso3/GmUMwAAu9opvQ
	(envelope-from <netdev+bounces-285160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:57:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1F4E3CA9
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B70BA3029AC0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 06:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102EA33D4FA;
	Thu,  7 May 2026 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a5FRYbvu"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B0134104B;
	Thu,  7 May 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778136902; cv=fail; b=O7xgC4OECLq7qAuZXAJknt4sjOErm98nE+vWh2s2qvfpIulrdvw1dqhJ5qZis7hDtTQ1UGOmJQa3Vqsdiog0Va4cXNkcbgr5fKAkbk9mdCXiuBk7xKzsY3cE2suP6MnrZHejcvmPDjo63AFautJXM8WmxrvYHVI+xQLJcIStaoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778136902; c=relaxed/simple;
	bh=WRZLf4BLH0w7STBzRSOfxkB9QvW53gQdpxap2mm+29c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kb5I6FpLgPNVvTHhrCGudIf1D4Y+nz3RNVof2X28mKyRkNXG50b7YELngKR3Q4oBVJyIbIkQ8l2d8ot8WcKJs/wHOTve3rU2HBEfmj6HpkVnnvAYFk/ZRkUx6eFiG4eLzg1GFXwLzWeryoYt2I70e4DccC/kSOu8w8HAlSbykfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a5FRYbvu; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1NGqUbdHfQtRaKSgRbGTE4EMd+pstymxDPuDDKy/1sSuAdDNgSCGvegiu70kxT0LZ9wWhYdAOLvcFyX6U/lbhfG2A7MhY5RLd4QCXiv/x7e4JCSJZxXTtGWFx3GOlFpZkjjXHcQDVufwuf+dadmbA863ABMMYe0dPdaDZnmdYBBfcThn/W4aBzdr1ZZj0/1gjdIVVt0XKhQtP7X79AomYWM9GpehHTPKXfDcsJq10Ig5ICiuTTJnI+GYq+YinOMr27UEgeLoY2EvfUomZpRpZKVXS1plHq390rItyJfGKePcIsLLmP3Ai73v7+EkS4QxHnnBQa5/uJ7XrblS4F6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flpPY0ChfI3UoWYIspv8MaxGIljScFMnzNPU6ygroww=;
 b=WMzvYaXOPbtez4aKMP26L67OIj8oHVncKurZMx1hdiC+VYsrVDvuevJxeQYliH2NaI/HS1G9D7VslVp2uFabENaumhfdFEN2GZ73XASbgZS6+LcP6fNqDeCkxDSXOCW1ND3v9UL0X2nHz5zl91K7xCzP96tPAW21onu9XGVn/Uviqs2ZwE7FgbH2Y5tA8k/RaR0KEBwf3z8TMEl5+YuEnUAb0GiuNTyYvPrVTQCqGxKqNMgpj3YpWtd+oX+BM8nQQmCZ2bDfuS3WYCNhZxN/MzIU9m78g+UH1701WckH12me3GBg3O0cLxo2VWHNOw9dxBi13gh75tzWHfum6XTy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flpPY0ChfI3UoWYIspv8MaxGIljScFMnzNPU6ygroww=;
 b=a5FRYbvupO2dxk1NRGbXOqcK8VuaIH/ObeGznlqND7Ja6duVms0uEe823vAVqpb18Yai/o7jRyGUJziM7zuHAAY0LvIoQGl2DnZxYBr1oBlq8Myur2IiSB0VTaJzWMHTdrsuq6prURiM8dKzi6LF8ZZpBycqt9TagBNh9T8zodVFDG3VHNxCXwTLUDaoCw24Ba8lpf5NqUQtZ7ybfTiZyV3ZJvpBeAIWjDLUi4GWdrXICbm9HQGLGHjrULZFSnKIR5y3RQf7sEPkTDY8p5ZPPlbvcGgn6mrsMbW+20B1v1vRuN8HyORg0ZfgLXh74C4iEgjEku1/WqJSPtVmFDjtHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:54:57 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 06:54:57 +0000
Date: Thu, 7 May 2026 09:54:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Danielle Ratson <danieller@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Andy Roulin <aroulin@nvidia.com>,
	"fmaurer@redhat.com" <fmaurer@redhat.com>,
	"sdf.kernel@gmail.com" <sdf.kernel@gmail.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"kees@kernel.org" <kees@kernel.org>,
	"nickgarlis@gmail.com" <nickgarlis@gmail.com>,
	"amorenoz@redhat.com" <amorenoz@redhat.com>,
	"alasdair@mcwilliam.dev" <alasdair@mcwilliam.dev>,
	"johannes.wiesboeck@aisec.fraunhofer.de" <johannes.wiesboeck@aisec.fraunhofer.de>,
	Petr Machata <petrm@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] bridge: uapi: Add neigh_forward_grat
 netlink attributes
Message-ID: <20260507065403.GA815358@shredder>
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-2-danieller@nvidia.com>
 <20260505190044.0608dfb1@kernel.org>
 <20260506070334.GA617302@shredder>
 <DM6PR12MB45167562767CFC70DA9AE8D0D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20260506150556.4e540854@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506150556.4e540854@kernel.org>
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abc5bd5-8e1d-42a0-40d6-08deac05848b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SPoeygqzgmp2jUqzpsXTDKGXnCpDi1kfZQwqn8E9H+XiJsUqv7VN7WI/KpiLvfo0dttBDdYnthZ+vadW1W0IFZ7WVsojocvEvc+C2MvkjJn0k69mlzo5Y+Qfwe3Y9T6NMJ9kKVm6ULhO8kAZvrFwmpP0Iq4kh/abMmBCVPFw5nG/Gez+UJw7gZngAiNozVNVSif5Xn6rrmWre1yf9XFVFMD6EoDZdlTO2hLpcCtTsTJu8Z68W0tKJQiL49M61PQdbZp0hwI2dCivT6nRmlb9jrhtuYJ4yCH47HAQm2PTDoD5srqFwbHSLg3uYlh9ueCOt48uh2dkECAtQj7Fwa2lI4a/Jgee4CJOy6WdO3wobnjP/RzqHQtJHHja48CadSZfHN/YzePqj6/YWcRq7ZrOOaRgj2sGLhFvVFrfxdSUle71ETgMR15r18CGqyz8n5HfKvUHL+5PJN8yiYfQR6QG/sTypMvYNeuk1xtRdR8qSZt1PZg7ol3RMFZmoDuN0/mfHMTOqqreWRJeJbLrihSmS+C0mlus+ngFXb0OYxLTesI1I/UhNRsupN7NTQPX5s5JW4K/jPXSfN7s3GeQbloxlxw9bdRP9Z5DKxodiYXBBDvc7AGEq2nmGYIuRTBFZ6L/wEE3sRUplx0r+syPYE9sZrfqjJfF9783kLgG7xBvA06ofB7hwkbEznzLpwRopbfm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vBQ759M2iUAT9p2lOCQm+VjkUh3eZSjE+LNz9dHdRetTKFUnzv/HnBgCni9Z?=
 =?us-ascii?Q?mtRB0zevxDdrIC50sqlc61I5OQi2q3wAZPj1giTaPuR3TL+z1tS40OZd9gJk?=
 =?us-ascii?Q?m5BzAEwCqTI148HwZsClKf7Aj+zKzGPO3hbyylE/r7EsdX49QxXYOBGnNd/c?=
 =?us-ascii?Q?gxDZIYdMdQV2HbK7WAWsz3nn2+RFcbPQou3BtdEeb+t1egmzXpUGA6HOc0YK?=
 =?us-ascii?Q?iCPJeL2a+HLKsBI6V/MFgsbU6tf4ywpCtyoVQWe+gvdGzqqq7MMmrZTFTElN?=
 =?us-ascii?Q?jA9MplOp3Ps1AwipsPe2qXqI2ePzT0gnUAU3EQ2L3pGYRwh9b2y+IVqdL2h3?=
 =?us-ascii?Q?CpHj93T+3k3PVukRUlhZ8GzUUR/rtzt3E7z4K9iB2eXNRqRLIm8ve1Bk1jqw?=
 =?us-ascii?Q?Ytg0DGE2c9Z1d61NveqoRj8DYt54fB1mqlZOBEMeg/aqdhhdnZScYr4cHDp/?=
 =?us-ascii?Q?sY1hoZFTR6evnY0+NPgldIl8QLUHB44exSHoOK5wMhygDDpsLIgCHjywfNFK?=
 =?us-ascii?Q?BgL9d+5vz9BJUzE7o5JMRojEXqz+jVS2eBR/ggAH8tkG//7RDDPnT+gnrddv?=
 =?us-ascii?Q?FcEtUakE8a3jOSaoXQYjbS2D1KgysQ4l7Y7q3ofojh4CpVyLn9iNUm10PBeL?=
 =?us-ascii?Q?uzZX0DgHQEqD767ZhklvWWXOaN6IStO9v2PwC3ZdghSxluQr5k3wNgDPdiL2?=
 =?us-ascii?Q?PKFFnxVHuPH0+lLIdyX+UO/mLuzSb4VDNGn+lryokjhdGl6HrNj3g8vIqMvy?=
 =?us-ascii?Q?Kh3ekTfGHK+Uhpg62grh1YvznoRL9zbPerHDVdOEZkNTGP+REq1rfr35kOR/?=
 =?us-ascii?Q?eqz540Afv01KsFTLcsTItCiIeyfA2ofH3AwQHgbMvB2DH/G4ltoZzXNw+IxZ?=
 =?us-ascii?Q?MpIasB41xwnz4U0AMDMXiYSZtzPs0pdPxMbbCxBPkmV/sbJpo76hMOPMmZtm?=
 =?us-ascii?Q?Mo//ikAwCCh36qG7/Hg2ejSAX67m0RjLkQhbbZWA88QuKbzgQzoem2e90y5u?=
 =?us-ascii?Q?h8M3AlDuuuqVj/WkkcG5Ptt6njGP+rM+mzdi3Uc77KOqX5+gh7uLhYmxXYP+?=
 =?us-ascii?Q?FXoUin2kx4yIyN3VLwtk43hN3B6gM70uygBoJwFsbIpHJGwOxhQe5JWyaeu5?=
 =?us-ascii?Q?h4tCqgvdKOd3K7GwPOAhfZvZTSV42550SGxj8vaDIAjXu0eAcKRdJwnsoo0S?=
 =?us-ascii?Q?i5I38XfIbyXBomsrDugO9oVFWWx3XD6XhrLahz0z21S7OYIKl9uET4WB410U?=
 =?us-ascii?Q?BNjC1I7eQFtTkfW8ssvZJsLFega0Sg20b4hmx1WRuk3xam1iIfMNJv9mcaIK?=
 =?us-ascii?Q?iOHzVnM0Xnd2XDJHPKpjfdzfYcUZ24uPeGaHWvS2qQ6gKV651XLkysG0IYcr?=
 =?us-ascii?Q?7NX1hJ9aiHvIO68H3TcGW/5QmPfVFO8bQ5WszZoM/v7IecPetOHJYgpUScA/?=
 =?us-ascii?Q?fYNsVgCWxOn/bhuDPWpAWVEvoTJb5S+XYh9v2dHMDHnd/OhTVtSZiKf7VyMs?=
 =?us-ascii?Q?F2yWdzh6VnK6kIFxwtGzXof745q3g6wI8E1lRO4IGv44FKexIpEk5lV6Zr/U?=
 =?us-ascii?Q?Eirian4pD6UDo8i4DhzXS7bFikRANwr/cEq0YjTu0qOGn3lnL1lGJz9wvMFz?=
 =?us-ascii?Q?IpeZ1uW6tl0PqzGWMk+3G74+hz6CgpwRQqGlNBoGp+7R4je9tHoj9ekNp/v9?=
 =?us-ascii?Q?uV4UozcU45M1C9yBNwLMerKKva9LuHzDSW1ETYxHjlZWtTJ/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abc5bd5-8e1d-42a0-40d6-08deac05848b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:54:57.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyUkb1/cjjpUWWtxt06XjnH0EHJ5YH/uNImDr7XlK072dSYrGKtTqpxuml0DL4vm3Bfc1xnBouvNly7e+A1k2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
X-Rspamd-Queue-Id: C9B1F4E3CA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,blackwall.org,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-285160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,sashiko.dev:url]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 03:05:56PM -0700, Jakub Kicinski wrote:
> > > Related: The AI also did not catch that the spec was missing (easy
> > > to forget for rtnetlink). Do you think it's worth adding to
> > > review-prompts?  
> 
> I assumed Sashiko missed this because it doesn't spent too much time on
> the series as a whole right now (I was going to tweak that but looks
> like Claude is having another meltdown, crazy inference latency,
> patches backlogging for review..)
> 
> Are you saying that the review prompts-based test is also not catching
> this even if you give it the range of commits that form the series?

Yes. I noticed this during the STP mode review:

https://lore.kernel.org/netdev/20260324200051.GA572287@shredder/

Where the entire code changes are in a single patch.

AI review of this patch:

https://sashiko.dev/#/patchset/20260324184942.2828691-1-aroulin%40nvidia.com
https://netdev-ai.bots.linux.dev/ai-review.html?id=d0cd7a7e-a803-45df-8121-555484a45315#patch-0

We can try to add this to the review-prompts and see if it helps.

