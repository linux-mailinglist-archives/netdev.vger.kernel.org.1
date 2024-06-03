Return-Path: <netdev+bounces-100171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4138D805A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EF6283F0A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B084A23;
	Mon,  3 Jun 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uFyU80cq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAD83CD9;
	Mon,  3 Jun 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412016; cv=fail; b=YEDXid3rhYvTUEdOE8kQcbkImZwaMMIGmesS9jL5mBky1tnFLHJ3XiIVgmdMdW2jUXqoAzY0CQmCNkJCgA5u8N2HIIFV5dcdEqGIXNxJIrza50ZOSanv1eujdFJqUXX0NK/NUIgjzV4rxAHXOyhvfr3gP9ejRyswsPxp6RxL8+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412016; c=relaxed/simple;
	bh=VW1L5P5jfNXCgVWdXdStm/1aqa2Qi8S66CHUaTYBsnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=icD8QwLPg8WTQ3/LbEdQQKJZ1WFzyA57NCaT2sXGIrkAkP5X+mmm7pG0GYZWN93jbRS3qGz6lFaFU8k1Wjm5NB11aYYB1ub24L+D+DaEPqwFNM9PNPC4JN/n8bExnN2XJDVr0bUARBCu+aOPbhBSowH9mEcqzQO3e52R6UDsl6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uFyU80cq; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1kUO7/FpKbMjRGJvVeNaT3N0rMgk9E6+SsvGmHLJjFREYAtojSsDDzRMEKujXBof4+fsyDdjQDYRgi3yzT6PW17l4l75mH8ptPa/zmGJfOoPuWH25fzCaWWo9oo2UDdrX0SYX6/Ev7o3N1Lua41UKepI3bIeVcVBp2W2kJLEXgfLtqsN+xl74LsAhWHKCvPf/hmeDXjzXHGYKvvv7Jpta+fTybT8+dvqmBansU77FLHIUFKId7LEX22rqeGoHVmjT1bvVmqxRCJEKJGlDWv0zyMOf86/0CoTZQkkn9rn2B/OFBqC/ftMotfFqaeVg10IkutKq9F/eli8+Y9rhkMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgDZguA1SSQ3+dqxgRxaJLNCfzySKSQSziGLC5YPJBw=;
 b=lag0/x/DVg+ZE7G/+fwkIZUvy11TwAz7iKNvL//CxY1eB0moTlReWY+DiCoOp8msvcmoPQoBGzQl9Rp81yycRsz5necXLQzoP/ZYi0921vG+6wGH96vbYDMDlLCRh4RfkTHz+FdMCWqIojFLy3olJ14/c5rqZax97YhFUtXNiGysKD0SygZDL2qy3iOJ/3edn2VER2Wm9WJYCNypxI3oFwJJmCEkSuKhkthiAhUqgRzg2qXnZlSyzC7G9rNfhj1W8NC5pAVZQGJaxKmoIeCmPt6iCjHF5+R/sO5FqqwCQosb1w40ZCot0wY8QzA4sXG/wlPiAXoBDtbpcYzQBuBqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgDZguA1SSQ3+dqxgRxaJLNCfzySKSQSziGLC5YPJBw=;
 b=uFyU80cq1zd0dwz35TesIukq/e6zoAV+hudS684k6wVZHlNxnEfC2UcwIIEEl4Edc2brAxSkVQGxn0iOdcNyIQsvI2r4yZVLwrZBnTuFwjJthvj2gjFLr89DAn3RxgpvaPZxYVqBwnQCjQk6CQAHGg6+VKolNLyJj2KoH8i3zBQ03AEfoJW/d9slucQDII/z6W6U+7VcVYYgOWhoGqM14/v7CsAd86/7WzJVs0LnFrYD9HRvGIxrdvy8zFIqYqqR5KtBarvvIDXJkNOVKEachn0URt3AA21xoHot0pHi4BlDExIGSa2w1kB6EwT6aFQle335Kr044lrqd4F+rXMePA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 10:53:27 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%3]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 10:53:27 +0000
Date: Mon, 3 Jun 2024 13:53:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: petrm@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2 net-next] mlxsw: spectrum_router: Constify struct
 devlink_dpipe_table_ops
Message-ID: <Zl2gke-vKr2Ad7xz@shredder>
References: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
 <6d79c82023fd7e3c4b2da6ac92ecf478366e8dca.1717337525.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d79c82023fd7e3c4b2da6ac92ecf478366e8dca.1717337525.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: LO0P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::6) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 016e29f6-cc45-44bd-89d3-08dc83bb65e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49DPq6xFrlmqhjthA4cbJYZsb09O+T4a67zWjR5VLDX2+EUsgO+WYQBnTKeW?=
 =?us-ascii?Q?9fnHuqD+B9h4YetGg2kr3MGSTcoQZKjna4NKjhssyNZN8BmcGutxUYvAHMDJ?=
 =?us-ascii?Q?tDJKJ/5/lEHEFNPVIpDbNTtveWwO+KDZGS2BRPWJBSD6AM/TaSe6CDOHGdja?=
 =?us-ascii?Q?fIuABdxb4eafYt6qtlT35jw14eiCpefm+/rCFSonb0woiy0uZ4iGzobiBue/?=
 =?us-ascii?Q?Og5C0QRm95nAd+1MP0ciWs1tw5FsYGfBPvT91yW3UFO15sax2zBF0v5Ptrod?=
 =?us-ascii?Q?Md/tlnoWw7h6saK5Px+ptbIltKQoprTaGN0lcc7wdC4ZrFApR7SNUgF7/bHw?=
 =?us-ascii?Q?d9bjEcpoGHN9yGU8zS4aB6k4fm3t5hgCRddv2+Vhx2ZbnD+bq/LZS6KnRNlU?=
 =?us-ascii?Q?ZswzMli6IymrkoUk3Yi0E5IzCSxh7WUBbl3v1IwbG1J5BdsNqyQKaDpY2VSe?=
 =?us-ascii?Q?CDYUTvHFSbwpDANVtV0R6fRFn8uDiRm1yfNNhTn9FeJ74+nqsooTctCzsuDg?=
 =?us-ascii?Q?dqGqsU/+e2jYgSZ2wms200S2jyCQITZ79nZhwTAtR3e6BbzOGUuAWTXwPlOI?=
 =?us-ascii?Q?rdhNDPEGRzCSlEPAJ3z0E00/jhb/yaNMEVrbBggARtgnPR9lKrclI8SD18Jp?=
 =?us-ascii?Q?+IfHsj7s9uB/8QiWNncOU/nf4B1Lo0CG9J3cINu25x00lW5gHjMUg5LtYPFw?=
 =?us-ascii?Q?bA7g5Eyi4HwLp1jGB6VCMiNngNsQcCni2+lwDfnsDpc13svejWTzrbNf5Pfa?=
 =?us-ascii?Q?dN0RJMrincV/2uqGVOND1ZRRe569LKHXavnoz2PrblYH3eeIyzpJgTrcqMsG?=
 =?us-ascii?Q?hzYJLCo4nRHuUAm5+AENEk0j6CJdI8EbDF8eRiww/otQYV+exVkABJo5ID4b?=
 =?us-ascii?Q?CLTb+iA317ppBG41XE8S59ZemUkgmDL51rtojIF/G6YpkcWuKGYIuFMU4gv0?=
 =?us-ascii?Q?sNIRdoL6t0JEdU5hqO0AJfEURlTAuW/DuYEEgT/sK9O2Bpc/MK8stzkXc9Mt?=
 =?us-ascii?Q?bqM1ZuqGiEIg4ApafKEWCMZjPZB9vn7IWoEbEgV5jE9BwpmQL8/ck4YE7D7h?=
 =?us-ascii?Q?ZukmPguPJK1OnSrboa71rvxG/hiWZnXJL3fVaClFBan/6aFq6fFgeidIhObo?=
 =?us-ascii?Q?Ruh8pnVxmynig6qvclWHa60A8VAl1TzvHObnbBUoGY5fc6A1m1xpue50c6dq?=
 =?us-ascii?Q?LgoXbadDLtHreeOQ/1kewEoJO3VXUdMzWywcTdpmMcvEvCpx7fxCbqcgZbdd?=
 =?us-ascii?Q?yYYkvXron0JpgNameQXULp4jrMt/pmVdKRvn0W6q9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C2Ojj55tkSDwQvoZD/cLuZ2G/lCgotWAsIvJhyjYn26IRsnA6UsShXmLCoqI?=
 =?us-ascii?Q?GDLPgZyzsfx0KhVx/Y4vdSnFTYhslVKhp/rdKh7o/L7oiRhFoFiBuR69xtwt?=
 =?us-ascii?Q?3IvUq84aTWtDIFUEyWMLCfSFssbgLC4lFJS//3kgKqRBeDIOaIgk1LSj6KCT?=
 =?us-ascii?Q?K864SHIwpY3bxuCJAdO510+Aw7xV2I34xOc0b3WLgIcshDzRDnMLoJdCEdNL?=
 =?us-ascii?Q?N9tfCiZZMR4+V0JyE6xVP2ajtz3xGEzogeRMc9ed6+Fr7xV+HB2ZQ6d11gFl?=
 =?us-ascii?Q?5xnPK+twiU9GUpR5DHqfcduRS0ZOUDRErHTdqJIaEzZzc+WWT+t0V4I7N2Wi?=
 =?us-ascii?Q?U/jrccDzxxx8XFiMqSL8p6ndnlmDdpI2VebQwpXfMWpHPC5rlybFATm/Q0DZ?=
 =?us-ascii?Q?i8vPnoMDSY/Q7uX3tMo0B47/xVB9n+W2xM4aWzwvRv2qjTyTeaLA6FItQlNF?=
 =?us-ascii?Q?syeJusFzC6HSSk9tUXfhmEOoQtRRqjusAv6PqVU6KLJeXGE3P+gxE0IixUmg?=
 =?us-ascii?Q?rkaWWTIU8nbocDymUykswf1163dpQAlXGALu2NR5UCqXbRcdexalKOXYv9js?=
 =?us-ascii?Q?nalD235lm/phc40RQyUmerv1XqZDJEDhA/OpQl0j+Anb5GobWla3++zba8pr?=
 =?us-ascii?Q?PdDFNvZ2U3LCtsJiLFccTa5hBkcvzqAz8Hko/Jlf7WNS4gSZfa1ZmP+HxUvc?=
 =?us-ascii?Q?iXCeIc3Gebg8GzeJCKmMubbBUbkmNKIjTT0E2/fmWjc/JPFQW0tTnY+jKQ81?=
 =?us-ascii?Q?u1cLOwKxRFv2i4JrEe6I8IN2sLwnA7l/t2G11tqm/MesJFUnHFdP8K2QdrWw?=
 =?us-ascii?Q?Wik31r/cHlwu+maT09UBAADsYngj1nu2vEKE4s40g8vifno+/BkXwwAn1adF?=
 =?us-ascii?Q?KcTGDDvoPhLyY1VjyuXxLaCtLpWx1F2tD9PTMDiaYqgL3btOVIXT2v6zKMUH?=
 =?us-ascii?Q?Hk2PgYGSRp6X1rsEEwLvMxh3JtmKYAvGAb9RSz/ORkq6SA3AVruol0YbwEuM?=
 =?us-ascii?Q?MdNIr7GeTWoA2wJ4XNZO09EzZ7FezctmBcLeRIjvew/PmNU5nMW1qG6585KP?=
 =?us-ascii?Q?lm0J78/4KXyi1ThyY2aPWnXW5p06JBdM9veXfnugWU5hqjub6WGmBn0fp2iD?=
 =?us-ascii?Q?VeOGMwmfDnXDgz8gQ/KdMZOOu3rvPHfodzr4opD4hSxQHDxVoZW3evNUCCio?=
 =?us-ascii?Q?JJqrrf8v+pr88upc5s6tqfiXcC36GxkqRI6p86vEnLEsC8JxN6AOSKqQl137?=
 =?us-ascii?Q?ortd8T+hg49quScPxDj/VaTYXF4aH+oj5rn8waBGcY7PzBwtTsGESDYGhA5e?=
 =?us-ascii?Q?tiUGV72HiKWAgTyhuibBL1M6S/KeA0bCDVZ+DpkPL3FEk8fJPm5UCUmO8dcU?=
 =?us-ascii?Q?8Q3YHMzCHwfj9/kVzHn8cfcHSVhianiMqaQomaJjxlgaGButx1yITSMHqRGs?=
 =?us-ascii?Q?gG99Z9wk372Cw2XhbLYMM7arvQ/vwWRPQnjzvcVkqhAxUshdeR4EQWUrB6hg?=
 =?us-ascii?Q?os6MU1dAV4RLnYVAmDg54pfzXO8YSe67TKMnY5MQJeFwhI0R3Y2irAm/au9B?=
 =?us-ascii?Q?DcY6WwGT6uJKSvvCcvBsn8877vwHrX9PhYqihQuH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016e29f6-cc45-44bd-89d3-08dc83bb65e5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 10:53:27.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wO1wrqfvsV1VIxJ1TRODFdDOInAZD68Cq9DTsP6CQuprrJz3zlI7iwzWFFj6WFzTtQ4fuTj27HQrAFObqDdZrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294

On Sun, Jun 02, 2024 at 04:18:53PM +0200, Christophe JAILLET wrote:
> 'struct devlink_dpipe_table_ops' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   15557	    712	      0	  16269	   3f8d	drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   15789	    488	      0	  16277	   3f95	drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

