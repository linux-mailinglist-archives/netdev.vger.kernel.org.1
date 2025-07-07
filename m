Return-Path: <netdev+bounces-204708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4DAFBD91
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E504A3FEA
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E10728751C;
	Mon,  7 Jul 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QPs2spe1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA821B9CE;
	Mon,  7 Jul 2025 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924157; cv=fail; b=EdNtU01TIbHgPHOd1m/3JRjLqSTU23IyNkfs0Ous8/kT9nwn31Rreo4IeUMHr4taLUfb5+346iTazKyZ9MyvvfKR2PWGlfPLsu44yBFw/AQ69K94niyRpfrKH+PNOfSPYBYQqoYbMuY3rLzmUt/4ltmB8L96+CpVkT+2+PxUqTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924157; c=relaxed/simple;
	bh=3d3XDFhg7+a1bs1R4wUJZA6OrH5GtjBlgwriRv15/wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MjRG/9CZRkI2N5cOvlj1jodtu75BCGOOps9MSmqChoGixB5/06/AjcrCGpdpq4yc9vLLSEdw7J4i3gyfK3siD0fwQXW/iL2tL7N06YqFQb4xAQpsqEL6pXw7FjZSod3QXD67x6c6JTdHm3ay/LTLBNqpWSNrknyznRbM3tyIFbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QPs2spe1; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlurf0SzV0b+xeLIDayI7YLl1ATlOMixRwPcfhFrzjTi3rKNfylw8o8Y//YK+yoAaLL81rKC9HjPkaqVTMG1lWT3mjrBlCE8fGlT1rJoQ4HUmQyiqs1S7MsEOAlMj9iM2jCi/JhjWGPzRfdXSZOz+AdU4hd1pZvMc9l5lj9ndvHKrTg6mNavCOr3ln2FwgINj7RVQrDOYW50rM6vm8PYZiAdS6m6xyJma1HsaikeVjPEs0vLr/WlGpaVkm3wmIjR57GlBBhlNqb6J1gZigA3QFFQqmAZM4JGpGwiOFH9WN215hX7CMJ2gaD6PNTYyJmJOi5RJSiix2AwZqi9+6v+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRh7OG9iIcrdiSO042ezMuZmCDdtZVH45tPlebE2O5M=;
 b=TjJd+jKmnsCdYfxsK9pi30jYVj2ux5TG+0wTqlXKIR4xbqVtqlt9V/7GMl3yyxXSLvjNJ8Gr/nJVcR+5p9cW4mwPpvhCR0/5qdaGDtsIDytg5XCgzbkHp//1KuCCZtdKrsq+QS/z2WE60BuK8LiD7W2xnDOSTiBXdpncizC0al4i9hq+JHVn8FTbS04CXdZOfs142sPuXOrNoZCAlOI1l2SVF4wzdAlFoBUwjIAb+HFtg2TGffeBSH7UrNidP5K5GjiINMirF+M5mEnBY/c3Ubdn8/3lhccyvqfw84Dlk1761df3tiwC5E0CKbTpJLF29r8r899qv2V/ifjzBLfl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRh7OG9iIcrdiSO042ezMuZmCDdtZVH45tPlebE2O5M=;
 b=QPs2spe1OBy3MZT4Gnw0TC5Cmw5GUEagF6oGDHOuGsmPsmEe7jRdo2Fm5nK2F1Gvb9qLQTO8QpHicEfnqP4zeGWrrfEyqQJXvecKQhW2mNUHU+oKDoWWd0uyLl617xdZef6jNI2sy2PDiPuoL3q3YeyrtWSbkDBFCuT0bBlCaBespYAhmtBzMyKFRlT37UUuVpcZh6fd9SJpbHKlleMdZxqnrxeuxPrAwWqRaytfPX2Sv+bY0VBoOYdCqlnvbWC15HQS4B8nrlV1kmkJ8IPzvLWEdLNOiHN2HVkOlNQvaHjk8Fyt0pZj1Dlm4OK9M6jaXwssRmrPjEqfpY2K29rtGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 21:35:52 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 21:35:52 +0000
Date: Mon, 7 Jul 2025 21:35:24 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	"asml.silence@gmail.com" <asml.silence@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Message-ID: <sdy27zexcqivv4bfccu36koe4feswl5panavq3t2k6nndugve3@bcbbjxiciaow>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org>
 <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org>
 <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
 <CAHS8izN-yJ1tm0uUvQxq327-bU1Vzj8JVc6bqns0CwNnWhc_XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izN-yJ1tm0uUvQxq327-bU1Vzj8JVc6bqns0CwNnWhc_XQ@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 93248704-295b-48f4-ce3f-08ddbd9e3f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1FJb3JZK3MyTXloN3lDZmlTNklHMWw0MTJUVy9YbWFoemxxQlBRUTZvUEZp?=
 =?utf-8?B?RUZTOUNJWmhWNWtNY2FadmxKSWNqK2V6WXIrQzFjSG9jR2kyTmdRb0xWOTd1?=
 =?utf-8?B?SUY3Z2RTUHFoZG91dzFZMjczK0VVSzVkTVBITllhVlZESGJzR01sSy9Rd1NT?=
 =?utf-8?B?ZEsyb3Y0b1Mvd0xVZ1k3ZnREM1E1YTQvWXNHcE1lRnEvK3ZNZmpTOEdjbTdz?=
 =?utf-8?B?dHNSSGNXYUdWUHhGSTM0UnZkczdnWFhucHhqRzJaclNWanlqZFJxSWZrMlhO?=
 =?utf-8?B?clRMNlJCenhTRndLa0J6WkZGSFJaQzg2TGdEWE1FcmthN1JnZ1hyQzNJbGlt?=
 =?utf-8?B?OThCbjZzTElHcThFbXVJWituSWVaV25ObTFQYUwyU0djSnBJQXBDbnhyeDN0?=
 =?utf-8?B?TXNhZ25QUGJjZzFZcHpEa0ZNVVNUK1lVR2pHZkhBMVdNMDVmN2QrdnNWS2Yy?=
 =?utf-8?B?MndGa3lEd29MOTY4ZDJMR0VaVU1ncnJuVEJHeFJqZnY1Tmk5OG5TQjQyRUc2?=
 =?utf-8?B?ckc0ZWVDTWNjRVpnTnBOdTNnWUluM3RpTDljTGsvV3NSNWFjY1FaMi9oZmdi?=
 =?utf-8?B?YXpDYTJuN0t3SDJmZkw4RTZaeUp3TnJvamU4MXhITVlnczhEckZkeGVQNHRz?=
 =?utf-8?B?RGppRXU1WTc2cDVKSzRVOW4rTy9Qdkx1ZEtsS2FtV084R0dHbkk0eTlGdnli?=
 =?utf-8?B?WWFYZklHRFB1UUZXUHRtTVJSSkdNcE1wQVZWUzBpV2R3SW4wUWloUDIraGJk?=
 =?utf-8?B?TU9WWjJudmpQS2g2c1pGYWxSRHh0WUMrVzQ3WkVVN0ZLNlF3aEtyVHRPVTNr?=
 =?utf-8?B?cG1qL3N1TVBpN1hIR0RGOGdzK1BWcEY4QlJJUU15dzN2RE5pREdjcVlnZE9j?=
 =?utf-8?B?bzNSSjVrQkVQbnNNZDIrZ3UrU3VNQWxCTjdoQkx3VStjQnRXc1gzV2R5VERG?=
 =?utf-8?B?Ukg1RGE2aytKcm5TUkVBQWZkK29PVmdsVEFJTUFCRDdMdmUxdTFPUjhmQVBS?=
 =?utf-8?B?Rlh1bFhyYnhJZjllZmdIVzJGNkI3UW9lYm9YMW1sY2lSd2VBZUc0aEJUQy8x?=
 =?utf-8?B?a1BVNmpBZHNDdnE0M1lMdHRtNUdzN3kxYXVSK1pEQThzNmZMTU04eE40TE1q?=
 =?utf-8?B?RXpBNlVDVWVmNUpYeUVrT2E4bWV0MElNRXowekwwSkUyWUhjRXB1N0dkQ2Jh?=
 =?utf-8?B?dU5EaE1YWmZEV1V6OWJxZjdYN2tqd0RETDYrYXZVbytYN2xUUTFSTlVDSHdJ?=
 =?utf-8?B?MlhqVGpIVmM3Rm80TUpFUnlnMHVERTcvQldLSGt5NWVkcDJHUlZXelVoek42?=
 =?utf-8?B?UlRhTWdRRncwZFRSanNyU1R0cmZjRDBtYS81RHVkUyt2SHNHYkVVVVV5dFdy?=
 =?utf-8?B?d2VVNk5QU2J5Q2dzQjU5Y1ZPUnFaNUNVRnpGMmIvbnVFd0MwOFBURE42andp?=
 =?utf-8?B?YzE5RERjelBzN0lUVDNhNCtzbUdhWUordldDRXBNNzJYNkNVenhadnR1Tjhm?=
 =?utf-8?B?K0l3RWs1NFB4aTYrSTFDSGV5dk1ROVpzL0piVVBITjlKVTk4cDBjV2QxK1hu?=
 =?utf-8?B?R1ZuUE4ycXpQWGJQUGtGRUZRc28zdWFNUVhaVkI3UFJUK2pmSnJFc0dGdGJM?=
 =?utf-8?B?RkJPd0xrU3FScFZLVFh5RnhVV1JEZCtDN2pJd3VZWmdiemJLektTcFdCVmxJ?=
 =?utf-8?B?N0JDbVdpTUQvQ25jcEl5eGRhYWF2ZEFmWHZXanVXclhTalJuQ05yUnllZmM2?=
 =?utf-8?B?cTc1RVlGR3ZJNnZTTWRZSW5Fci9kdk93YVoraThGUXNqb0VCUno0b01KSFRn?=
 =?utf-8?B?c0ZaVWpzSncvYUNrTEFwdzNmMGZ5bENZZmh5SUF6SzVQUGluVHY3VnRYaXF5?=
 =?utf-8?B?OWRUeUczVENnbmVrMVg4VnpyR3pFK0dSeGpSZWVodU9SR3VMM1lobFRtYm1N?=
 =?utf-8?B?VkNCZ1FHb01MVTlDM29NK1hCOElWanBjVGozTHN1ODRmVkUvanhsVlQ5Q2Zm?=
 =?utf-8?B?QVhlMWxaQVJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzJXNnQ5Unp2Q1h5UVNTY0NnYlFweVZUMDJQR1NpVFVjem9nclZMek9yb1Fj?=
 =?utf-8?B?UXRIeVIyTTlpVGY4ZkdmTnUvU0hiT0pVd1FNNDZaMmxZVFM3N0YwTTJxMGpO?=
 =?utf-8?B?NFlwKzJZdjI4SEF2c3N6T1JySmt0NWk0cmNRU2kzUTdLOWhUQk91SVVTVVdi?=
 =?utf-8?B?bW8zOTNmUVhqMHpXTURaM0hLL1k3dFQyalErL1hvV09oTGt1LzZzZmphTjJ0?=
 =?utf-8?B?NkNqdWNTZTlIaWpLYVhkSHJHZUpHUjdJdFpmbDJodlBkVVFDeE1SUktTQTZy?=
 =?utf-8?B?enYya284NXp2Ny93SXlGbnBCZHpkK0M0c1c3MnI5clNDeUVKdmVmdHNoYlFT?=
 =?utf-8?B?cko2b2ZlZFkxNC9FUGtnWURZVldaNXA0R0twdTZpSlJIN0hpdU1YNk1mSStR?=
 =?utf-8?B?eVNVZ2l6aFJ4N0RXMkdSQ2ppYkZDbG5MNldMZXgrUWtoL1BHcmNVN2tRbE5V?=
 =?utf-8?B?UTdvbG53aFdCK3Jyb29PZnNHTnBEeHJ2bHdpV1BsMzRwNy9tbGFXRUFRZlha?=
 =?utf-8?B?Wkh6blVvV0szSkZTTm13dUFGUEk1ZjIrdm1ucHlGN1REZUFOUUhJdzNpV2pN?=
 =?utf-8?B?UW1JdC80dWlDZUp3c1YydEtEV0hHMmE5WXhQbjVLV21xcE5EUzI4cTFQR3hY?=
 =?utf-8?B?Ny95WDBzMFJ3b096YzJyR2MvdlRxUVZsbEV4d1NjVkNuQTg1eU9GUWJXWFJY?=
 =?utf-8?B?Y3lKQWFwWGZmN0MxRGNONWs2aVROem1RTk4zdElwcFpmaEI0ME8weDE1bjY0?=
 =?utf-8?B?alBYUnplakdzTGc5LzVUTTFOd1ZHUFVtRVh0ZVg3RWJnNnE2VEYxY1hNVVRQ?=
 =?utf-8?B?cm5rS0tNOVFuTzNSRm5CeVJ1MnllaDE5UmE0TldRa3o2aEtRc3MwYkx0NWhx?=
 =?utf-8?B?ZGYxZjRINDVRc1BOQnpybUZZK3lWSFhicWhMeUJhc2pZOWV0L2puQkJ2MStM?=
 =?utf-8?B?U2VCaUJpOHVqTjZuV0ZYNHlQSzFGNTJIQ0lEdncxZG5GR285K2ZpTWkwWTZN?=
 =?utf-8?B?UGU2bXNweWtKVjhvWGhpQWFkSXZxODdZSG05azByZ1diMG4zMThDajNLOGRw?=
 =?utf-8?B?ZGRhelVMU3o2WHExSG1OcmxVQ0dnc0lYb01TbFBIc01OanJQbTlWYkRncmZB?=
 =?utf-8?B?aDhCR2w5bmZjUW9RSzhsK2FoOWdWSnY1V2JpNENqZU1EK0VJQTlrQ053SFVp?=
 =?utf-8?B?Vk9wcnkwN2ZKczRTY0k5emdVaHdidFp2SUo1a3kveDd3MkMyNjhqd1k4MzRp?=
 =?utf-8?B?bW0vU1V5Y2JjWkRMenFtM21LcVZRdHVsVGVqWGsrajM3aW9kbUZ3UkdTS2hm?=
 =?utf-8?B?ampFZWx5VWRNdm40ZmJzOFJuSENyNVlIbXNqV1BQVnVjNG5PUE5uTTNsYmdL?=
 =?utf-8?B?blZwQk4yd0ppZXhpMEp0bk50WUJsMkE5TzNWMVE2Q3JGSTJBNlgrNE5KNVVM?=
 =?utf-8?B?TlE0VE1FMG9ZSDY2clBybldpRlYyQUhBV2VwbjdhN3p3Ym5vSmdHZUxveTI2?=
 =?utf-8?B?VXFQb0o3Vk5OUHpLaTNRcFNsVmMwTGR1V0g0MDA2TkUxV3VmNG5TYkJ5ZjhR?=
 =?utf-8?B?Q3FVcTNTKzNsVW1jZ0xueXpNcHRDZHQ2MjZsdUNtRjFhZW5TUGN5WGhweDJz?=
 =?utf-8?B?VWRwTkFydVNzbWV4Q1gvVDU1NjhMYjhKUkd6SjRMZmFZcE5HaW9hN2xpYUN5?=
 =?utf-8?B?V0lsZnlET1hMWFJMdEowdjJlOE1HT3FwOHFERElLR2wwTFIrZHYyZW1XQk1P?=
 =?utf-8?B?Yi90dXZMdEhGdmFsTkZBU2ErRXJ0VWdnbmttbVFiS3ZQU0Nrcm5zTUVjTHRt?=
 =?utf-8?B?UUZuK3JJNXRvRnFIeWgrQ0JDYXNVMitSVEJ0QVphZzJXWEpwc29DRlN2QnA3?=
 =?utf-8?B?b2dzR0V6SmVVaGQrZlVZQTNaRlhZVVU1c3dNbDlGQUxXb2ZsQzRqTXY2T25S?=
 =?utf-8?B?cnk4Sm1tMFM1YTR2WHdqaDlrTi9zVkVWbXhpY1l2Z2hBemhSQ1l6UWM0U09z?=
 =?utf-8?B?QytNRmpJOVA2VEplcXJJVXM5bW9PYjBsTzdEblFyYzJpUFM1OG9laE91b0t4?=
 =?utf-8?B?MC9wRzR5eUFLQlp5aCs0bVVKREZueUllYjlEMnFsa0tPQWNRbGVzc2wvNGQx?=
 =?utf-8?Q?nT9PuHc70qlMGSa4Tmhn82qp1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93248704-295b-48f4-ce3f-08ddbd9e3f95
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 21:35:52.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20HHHsQkuHQd2KmA/Spp//DstzJZ/3R7zRDSgCtZfznvX98+OmCgzpU5n73Wq73zM7Rrc9YqHHkjDtsh3k8O8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

On Mon, Jul 07, 2025 at 11:44:19AM -0700, Mina Almasry wrote:
> On Fri, Jul 4, 2025 at 6:11 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Thu, Jul 03, 2025 at 01:58:50PM +0200, Parav Pandit wrote:
> > >
> > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > Sent: 03 July 2025 02:23 AM
> > > >
> > [...]
> > > > Maybe someone with closer understanding can chime in. If the kind of
> > > > subfunctions you describe are expected, and there's a generic way of
> > > > recognizing them -- automatically going to parent of parent would indeed be
> > > > cleaner and less error prone, as you suggest.
> > >
> > > I am not sure when the parent of parent assumption would fail, but can be
> > > a good start.
> > >
> > > If netdev 8 bytes extension to store dma_dev is concern,
> > > probably a netdev IFF_DMA_DEV_PARENT can be elegant to refer parent->parent?
> > > So that there is no guess work in devmem layer.
> > >
> > > That said, my understanding of devmem is limited, so I could be mistaken here.
> > >
> > > In the long term, the devmem infrastructure likely needs to be
> > > modernized to support queue-level DMA mapping.
> > > This is useful because drivers like mlx5 already support
> > > socket-direct netdev that span across two PCI devices.
> > >
> > > Currently, devmem is limited to a single PCI device per netdev.
> > > While the buffer pool could be per device, the actual DMA
> > > mapping might need to be deferred until buffer posting
> > > time to support such multi-device scenarios.
> > >
> > > In an offline discussion, Dragos mentioned that io_uring already
> > > operates at the queue level, may be some ideas can be picked up
> > > from io_uring?
> > The problem for devmem is that the device based API is already set in
> > stone so not sure how we can change this. Maybe Mina can chime in.
> >
> 
> I think what's being discussed here is pretty straight forward and
> doesn't need UAPI changes, right? Or were you referring to another
> API?
>
I was referring to the fact that devmem takes one big buffer, maps it
for a single device (in net_devmem_bind_dmabuf()) and then assigns it to
queues in net_devmem_bind_dmabuf_to_queue(). As the single buffer is
part of the API, I don't see how the mapping could be done in a per
queue way.

> > To sum the conversation up, there are 2 imperfect and overlapping
> > solutions:
> >
> > 1) For the common case of having a single PCI device per netdev, going one
> >    parent up if the parent device is not DMA capable would be a good
> >    starting point.
> >
> > 2) For multi-PF netdev [0], a per-queue get_dma_dev() op would be ideal
> >    as it provides the right PF device for the given queue.
> 
> Agreed these are the 2 options.
> 
> > io_uring
> >    could use this but devmem can't. Devmem could use 1. but the
> >    driver has to detect and block the multi PF case.
> >
> 
> Why? AFAICT both io_uring and devmem are in the exact same boat right
> now, and your patchset seems to show that? Both use dev->dev.parent as
> the mapping device, and AFAIU you want to use dev->dev.parent.parent
> or something like that?
> 
Right. My patches show that. But the issue raised by Parav is different:
different queues can belong to different DMA devices from different
PFs in the case of Multi PF netdev.

io_uring can do it because it maps individual buffers to individual
queues. So it would be trivial to get the DMA device of each queue through
a new queue op.

> Also AFAIU the driver won't need to block the multi PF case, it's
> actually core that would need to handle that. For example, if devmem
> wants to bind a dmabuf to 4 queues, but queues 0 & 1 use 1 dma device,
> but queues 2 & 3 use another dma-device, then core doesn't know what
> to do, because it can't map the dmabuf to both devices at once. The
> restriction would be at bind time that all the queues being bound to
> have the same dma device. Core would need to check that and return an
> error if the devices diverge. I imagine all of this is the same for
> io_uring, unless I'm missing something.
>
Agreed. Currently I didn't see an API for Multi PF netdev to expose
this information so my thinking defaulted to "let's block it from the
driver side".

> > I think we need both. Either that or a netdev op with an optional queue
> > parameter. Any thoughts?
> >
> 
> At the moment, from your description of the problem, I would lean to
> going with Jakub's approach and handling the common case via #1. If
> more use cases that require a very custom dma device to be passed we
> can always move to #2 later, but FWIW I don't see a reason to come up
> with a super future proof complicated solution right now, but I'm
> happy to hear disagreements.
But we also don't want to start off on the left foot when we know of
both issues right now. And I think we can wrap it up nicely in a single
function similary to how the current patch does it.

Thanks,
Dragos

