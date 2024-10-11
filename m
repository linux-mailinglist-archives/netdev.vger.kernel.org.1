Return-Path: <netdev+bounces-134498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AACE999DDA
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E356B2399F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6E4209F39;
	Fri, 11 Oct 2024 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BydWN7qm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEA209670;
	Fri, 11 Oct 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631533; cv=fail; b=nuEnnQV+emqcgDuVx2MHYP/k397kXS9ZBa00Kk+bKcqq/HciFTgLno3Z2jy9skn5KTanf6pIXrDDDOQ0A3zb+DHKekxs6+0hFvCNVrXcPSvRKJn5gmaMG6MYK/BBYUiibWV+WyZzkqKZA2eSTDcjDf76Ts5gwbQNBqLr33flZpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631533; c=relaxed/simple;
	bh=GJUlJgDNArN+jIqWf3VJt4dfwrfyAE1zSfkS4c0h1vc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UkIQS+a7UwOXYsj80MC8ZSStjEJAAJ7xlYxQtGh5qv92UEdJqxajIQdaiZx857g7G0uIsWlW3Men9JIivTkuRGTHauoVvHaAC0aZRjLzDhG7jyB/FoRAkYJkvQNwBtyYlNn4RmiPlcCuT8nOu6vEmCdkLHcx9FWTwZcXmFOZXzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BydWN7qm; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728631532; x=1760167532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GJUlJgDNArN+jIqWf3VJt4dfwrfyAE1zSfkS4c0h1vc=;
  b=BydWN7qm/xZX5Yy8pQ0WAs0xy0GV+fhgxdX/ZE/ub3dOzsGMu7NUgZ3P
   XV/3OlGLHBbCHu/YWccyxgv7nB9F4AP7wQbVORLrEavIxO1SqoV+rF6kb
   OVcIN2HHJwr51ztpk5OvPJOAlvJUrUifcXJWEndYShZLpyTD/wOMlulYZ
   cvktoFsobzelhGzSJtNR7nktOrLUVvZkShbkoamVLCkMP1/icOwJ9lG5V
   HhANIIxl3joRH7qNaWJZ+skhgsnj5dnm0SM0wx0XIa3OuR4bDeeKrgO0B
   gfs/4XVu5LuUyM+bNXyyPMVLRn0S89ny3e106mmz2GpJWMmt9XtgZzYmM
   A==;
X-CSE-ConnectionGUID: COqwt5aKQ5Sg1pZE+efHNA==
X-CSE-MsgGUID: OR1Yc7S2QWyH/mNcYIPrgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="53424220"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="53424220"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 00:25:29 -0700
X-CSE-ConnectionGUID: CPbIgSe6S2uM5FQt8S2Fyg==
X-CSE-MsgGUID: 7Q6gn8BuR/2JMi4XtfzPwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81351558"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 00:25:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 00:25:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 00:25:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 00:25:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNkpERCgly8WEQ7JppxMWHlk8adW2YKOLrL7hNs+yHhhLKFv7ObAP1UJ39zrjAB/TW1Bi2hQg9U5aiwARCbRVwnNH6OaYwcJgGOOXYnxGS01d0cKHz/dyZp3oersQ3yzqzWvlakXSaOVEyh02YaAbEnn/NOMLcLk0r9ppeAlaMQ1ONW2X6roLAhjySLHQXAIYHccAL36E82cfBPjoxRc+1RWEuplGc9pBE67SUDHQV2tVpus8P001lvWanOFylMlWssyp+poEGupvHXSvjeVeHFkpLMls0vB8qk7wGJ+lCBfe9huFUWa6/kyAcGekjXZGANUNNEG9KlvxkYXNHE9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+HRksRLzOAX2NngYMwVt57ccxWzIwCllOzO+b+DTaI=;
 b=KjO0z82xHMaOMmI8BjPCwnHnlqZ+znbptQvjHpxADq52gZcli4WOti3HnwZslNNn/wKtTg3UTXi07kIu2Oi5VVw9QusE0sErn4iUdh1uCYKL+rz8tkkii1dNuN45EapG6SoX+Lo/xuV3EN2i5uZwpUjH6X5IJrbJ/jBvoTRhaVQEGB+SV+rcDW4Jw3WdYkAdUXl5/psI/v/vCvvOxzMe87yp8Z1KgZi2cK8ZWaL8VegxTmNA1H9etytimd3eAZobRiSdM7TEYtmYzlBqEahL1QfUHQsVtTW519ug6VU4A0mdQNb+UbTtcEbSef187IXWlJiG88WMbozsN5PEd82rxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 11 Oct
 2024 07:25:22 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 07:25:22 +0000
Message-ID: <b3dde971-eed4-4e7f-bb3b-6a761de65009@intel.com>
Date: Fri, 11 Oct 2024 09:25:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cleanup: adjust scoped_guard() to avoid potential
 warning
To: David Lechner <dlechner@baylibre.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: <amadeuszx.slawinski@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Markus Elfring
	<Markus.Elfring@web.de>, Dan Carpenter <dan.carpenter@linaro.org>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
References: <20241009114446.14873-1-przemyslaw.kitszel@intel.com>
 <0f4786e9-d738-435d-afb9-8c0c4a028ddb@baylibre.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <0f4786e9-d738-435d-afb9-8c0c4a028ddb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: a33a68ef-be58-4e5f-702a-08dce9c5ddff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGhoMUtOblFQa1oyMEJLOWVGTDd2NEpzNExaeWgyTmVmMEoyUWVNSHpDc3V2?=
 =?utf-8?B?U0ZOKzNVWGtwSU5RL1FmS2M3OG5TaURUalAvQVhnQWlJUEVlMVN6VTFUK1Rv?=
 =?utf-8?B?U1ZWYmM1M1dhMjhMR1h0aWFDbUNEVlA1QW9jU1NoV1J5Y0ZBNUVHMVl2eTU5?=
 =?utf-8?B?TmxMV2hvWFo4U1Z1WGJOTzdQOG53SFpWMXpZWExQckpUdkQzVHc5a2lxNjhs?=
 =?utf-8?B?YXUzVjhBbDZIWWVFakl6RElSMW53RlZmZkJ3dHRNQlBlZW4wZjR3K2o2dzFv?=
 =?utf-8?B?RVU1cVN2TElrb1JMOTl2RDlDMHFiU2l3SlJONCtFMjFmUHBTMVcwY3VnM2JZ?=
 =?utf-8?B?YUM0SjhZZHFjaENUY1N5YlpxN1d6emtFcStHU1BndGJxN2ljM3llWXlyMG9E?=
 =?utf-8?B?clZvYXVGSm4xZWlwZUFMZW1JREVhZ3VHWFM5T2s5M2NmVEhEVHhXTThBMUUy?=
 =?utf-8?B?U1FzZ1Y4VXNTTlc1eDZPUzlVRU52Um9pTTI4dVdxVnI0cUZoQlBCVXZrWDVq?=
 =?utf-8?B?NTNqUjloZUptNU9nbnpWcERPRmhMNytveFYvakJhT3J5enVQNXJwUmcrMy9Z?=
 =?utf-8?B?VXYwb3dQUWF3OVY1QVpaRlBCamxxbXJ1UjdsUkZhRm9CZWFKWXhtM1poWGo1?=
 =?utf-8?B?OTZ2dWlLbWFoc1N2cFFIcWp3WkNiMkdzVGN1eUV3YmZsaFpvV2RRemU5SGI1?=
 =?utf-8?B?bEhyY3gwVDJsemxVWlNWYVZhcE44a2NxRmYzMGZsb1hBdUZOaGFFSkZoQ2Iz?=
 =?utf-8?B?RWRUc0tjbFZxTTRmNHZyTEZXQVVRaitsQzFyNFg4L25UVXRhSCtWalVlWFhw?=
 =?utf-8?B?cWJzVUV4enpyVE1GVHhGenBBaHJ1dkF6TGg1bUpiRmxuVjVKUGxLOXgvTDNX?=
 =?utf-8?B?eEdVKzgydjA1YW9wcHRaWS9qSlVjNFQrSmZicnR1REFGTmJla1ZzWWtMMDdQ?=
 =?utf-8?B?VlZ2OE1RUWxiOXRKRmFQMVM0SUUrM25Yc1pacGJBRTJnQlVSMnFneXlXSHJ3?=
 =?utf-8?B?dys5MDJndU1Wc0NpV0l2bTNDeUlEN0FNdExIT1pwMmtzSmd3aXB6czdyMENT?=
 =?utf-8?B?WEgyd0hPVEFMVWpzM29GZTFBdkxJSzlSOWZ0a3E5ZW15ZVFJeDVyM1hrbUlP?=
 =?utf-8?B?TUpiOTArZ2YzczZGTWJneVEyazVqSzVHaEFjMkRqSEhDaGNmV2dlOFJLdkpC?=
 =?utf-8?B?RjFtU2Vjd0NqcXFZTFUzaURMM3RmU2x4bjBTZTcrRmhrRXZrbC9COVhOb2Vp?=
 =?utf-8?B?enhULy9DNnhiWWErZEtGYzlLY1lmUzlqb0I4N3BmeWVmUFJoUXJFVytVODRx?=
 =?utf-8?B?VjhuN1BvU0J6azdKaTU4NnN6NmxoTzVrUXMxK251NkxBYkd1TW5VV01NWUk3?=
 =?utf-8?B?NnQ5WHZDWGZvbDdZRktVUk1QYjRFN1BrMldqRXh1ZGdBS2ZiQWpnWlo0enRw?=
 =?utf-8?B?VXlSOEpORm9JNWVNc2JueUtTcnJOVHBGdStBQUJLRDVHNStsQitDMkUyWTV6?=
 =?utf-8?B?cVRoZU1jRmVodWhVL2h0RG1NcS9RMlFRbjR2bWh0MDk1OGZYYzF2d2hGaHdv?=
 =?utf-8?B?UyszRDNFWmJZUFVwa2pkSWRyVE9GNFh5Rzk3L3hDTnFKRVNoYWMrWEltb2JN?=
 =?utf-8?B?cmtJVmJEOUdoR01tbGowbk1EMkExd1Vwd1BFT0U3UWpGQllMZzIzNHFFeS9I?=
 =?utf-8?B?QnF5dlNFQmE0cjBhV3ZXM1Zrc3l3KzRNOS80VE01YytvMnZKMGN5K0lnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2s0di9pU0s4UWwzbGVBNU5GQ2ZmY1U0VDh6L0pOUkFnZkdhNW9aQ1VzdjFw?=
 =?utf-8?B?a2tmTVQ3THNZUWxOV29yb3dxR3hrVXJjQVoyemE5Tndyb3pIeVlPV3RxVnh1?=
 =?utf-8?B?R1FFaVBGSWN0L1RLZUFRTVBhRkRQbEN1eStGUWdsTmRmRnIraENhcExlVVZr?=
 =?utf-8?B?K21qdVZYcitheTFFMEN2SjVHQkRaTXZvNXNGL0p5UFk1K3plNnJQQnhGd1pr?=
 =?utf-8?B?U3Iwd2xRMFBDZGF6N0p1THZIRnljWXRrdTMxc05yMTV3V1prNHZlSEczcHFO?=
 =?utf-8?B?T1k0eVZGTWdDV1A4dGp5YVJmQjkwdDdBU0xkcTZEZTNnbUhaWm5IYTlISlBk?=
 =?utf-8?B?ZlF4VDMwYStNQWdpWW5xNzZpWTVYcDZxV3pUcTkrajBBQlNmYTdxODgxUU5S?=
 =?utf-8?B?M3huYlcydk5iRmNZYUN2MUZTakFNak50K0JjNzRWNktYSW9nSDFBa1BObHVE?=
 =?utf-8?B?VDQvRllqbHNpc3Y5TzJqOGJvZGxjYUZIWTY1VGNOblpFb1ZVcER3Q2QxR0Rr?=
 =?utf-8?B?TkJYMzIwQkhNMStTSHU5OGVIQUtPclVoaGhPUWUxWEpBRCthbmY1RmlXaEtQ?=
 =?utf-8?B?azg0Y3hvYXJjd1k0NVdVb056QkV5NDhaNFhsN1JOcFdRWVlDa3FuS01tNDM4?=
 =?utf-8?B?REtFUjBSaVJvb0FCbEFxVkJpYmszdXJtQnE3WldFdU03NmxDczNXanVsd3Vi?=
 =?utf-8?B?dkhQeUtzQlRaTXpIeUtjNFErUzVwbE4wcGppR0RvRGdZYlB2TlVyODIyQThk?=
 =?utf-8?B?eG5ZVXZlMUNtMUVoQ3gwVmtrMWwzSXhUTlUveFNVeXFod0ZlUFdDUmw5R1RL?=
 =?utf-8?B?SWVGV0U5USswa2RLTkwyd0hGQS82WXBNTHBJNGJhTFd4R0g4TTRPUGFxZFhX?=
 =?utf-8?B?U0p3eDhjdUJuczRpbDhxL0JUUFJRdlp0akNuZWtGWXNVQU5XRUQzMkk4WkFw?=
 =?utf-8?B?a01zS3RzNlZaZTlFMjZqZUFtZ1lzKy9zTUd3YkdaYjhXbG5NdGlwWmFBNVdQ?=
 =?utf-8?B?T0lndVFuY0ZaZTNXelBMck5XRGszcnpEdXdBUWtGbktZYjJGS0pFS1E4dHNZ?=
 =?utf-8?B?N0E1dk44YWR0L3pLRi9TdmVOdlBxSHNEeFhsT0FxVUhoMEhTaVo3NFpWS3lI?=
 =?utf-8?B?aS9oeFdnS3NMMnhCRERndUo0ZFN3MUgycXZscmNpbjUxbXpyK0lBZG9QQng5?=
 =?utf-8?B?ZVl3N25BSitEb3ZEeVhXVVFtUUNhZFZVZW5wVk1HMUs5WlJuQVA3Ni9udUto?=
 =?utf-8?B?d1FlVCszZWVDbFJRWWVoSjhjc2E0bEVub1R3S2Q2ems2V2NMRVFpT2lHSkdr?=
 =?utf-8?B?NXZub3hGRmFBM0hjUUc5MzRMZm90ejVYMVNUWHZ1Tk1RZ3JJNHdpMlQ1UTll?=
 =?utf-8?B?Y00rYTc0Q3d3d1BJamFpc3ZZWjdnY3Roc3pmQWpXS1NHMFZRWWFaUnFFRjVm?=
 =?utf-8?B?bnFicTAyRXBnUTc0R3lVVHVpNkUzNVZDaHRqTkxwMjN4eTlDSDdtM20zSlhX?=
 =?utf-8?B?R0s3MDJpcHhWTVpFbHVTK0VHOHVpblFPeXJUMCtpcVZrRUFqazZCTGc5M095?=
 =?utf-8?B?NHE4NDZCOW5oS0Vwb2F3MG9TdHEvM3ZCcmk1Rkh1MTdVYXlnWEZOZnBBNU90?=
 =?utf-8?B?MEdabUhDbFptc2E4eXp0QW9pWWhrL2JacUcwbUVySHdWb3h1ZTFnK2ZHVHM4?=
 =?utf-8?B?ZEc4QnhZb3ZjOFQ3MGo3UjZrNEhRdzIwUHc2RW5MSEJRb2JnY2V6WEVBWGpU?=
 =?utf-8?B?TG5nTjN0N0dYaW94di9NOHAwUlVEbW5EK1RLNXlmaXR4Tml0aDVqdDVkK3Fk?=
 =?utf-8?B?ajFpVEVUb1lmYnVpbUFsM3A1S0RRTG9BbDlON2JubzNyQmRZVFdGaWwyWEMz?=
 =?utf-8?B?YmYrY3JXTW9GY0YwQzBlUjZMSUVucGZkZEVDY09BNFhWLzZVWHFCZkxwejIx?=
 =?utf-8?B?elRkV25EVUJ4akx0KzdwcFlCMzNOL3lUNXA2UTYvN0xoUCtpSnYvOGhvT3d3?=
 =?utf-8?B?RUpXME1zdTVZMjVxRzNlSGVMWnlOR21lZldpckQ2a2tiTTNHTHNGVTVEb3ps?=
 =?utf-8?B?OUI2VGRJaG4zeFg1RERUR01hQXo2dk9vUm9TQ1c2UUx6THFNeTdreWJjM3NO?=
 =?utf-8?B?S0F3RnZzWm9QWlF3S2UzdXZtZWh1cUdMbVFDQk1sK09hSGVWb25rNXRDaE9O?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a33a68ef-be58-4e5f-702a-08dce9c5ddff
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:25:22.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9u6PWj3isaoC3vktqwyKOU1m7K0I/zEiMJWE0FWtF/hxj0zGKjMt2GlTCM+wF0IebKqMAaur4ebhrfYwYpj9FEQ3d/QPsnDB1FCWWRwX+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com

On 10/10/24 22:13, David Lechner wrote:
> On 10/9/24 6:44 AM, Przemek Kitszel wrote:
>> Change scoped_guard() to make reasoning about it easier for static
>> analysis tools (smatch, compiler diagnostics), especially to enable them
>> to tell if the given scoped_guard() is conditional (interruptible-locks,
>> try-locks) or not (like simple mutex_lock()).
>>
>> Add compile-time error if scoped_cond_guard() is used for non-conditional
>> lock class.
>>
>> Beyond easier tooling and a little shrink reported by bloat-o-meter:
>> add/remove: 3/2 grow/shrink: 45/55 up/down: 1573/-2069 (-496)
>> this patch enables developer to write code like:
>>
>> int foo(struct my_drv *adapter)
>> {
>> 	scoped_guard(spinlock, &adapter->some_spinlock)
>> 		return adapter->spinlock_protected_var;
>> }
>>>
>> Current scoped_guard() implementation does not support that,
>> due to compiler complaining:
>> error: control reaches end of non-void function [-Werror=return-type]
> 
> I was hoping that this would allow us to do the same with
> scoped_cond_guard() so that we could remove a bunch of
> unreachable(); that we had to add in the IIO subsystem. But
> with this patch we still get compile errors if we remove them.
> 
> Is it possible to apply the same if/goto magic to scoped_cond_guard()
> to make it better too?
sure, will do

I will also combine both macros __helper at the same time to reduce
duplication

