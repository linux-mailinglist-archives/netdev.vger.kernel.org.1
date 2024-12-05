Return-Path: <netdev+bounces-149263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE559E4F7A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2092E167D50
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC985194A66;
	Thu,  5 Dec 2024 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5H79HCk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B92391BC;
	Thu,  5 Dec 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386530; cv=fail; b=hRkaeq4edpiIjpKKn426QL374BSTUFHwJw5PgQiV9TamxYmwUMGxeSizvdQVETAxTIXO7Ccagy7uNwurnN5I65iHjsqYgAkC3fxtFd9EQ77+KKYdKln3eIOZYFxbbK979TEH2W5EKezLiBBJTKgxeR00A7JlhKwYH7j3kZtG1Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386530; c=relaxed/simple;
	bh=EtFM8y9IS2mtUR+84P1wT/Zd8/O+xLK0jKLdZwb2jSw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q0CAWU5hDGQv8oQTDue6SBNEmNVoRu1qneeo7zgDxgu5bvH6kjqPLhh9vLfWkBvh1gBsC4bMncQxZR4Dt1Z5+E25ln/V90ORhHb8x8Dru1zdfDafHRt9AAOd61FN4NYH2nTKHf6/iHI7R5pDJeFsI06Gcz9O3+Jl1GFJdYRAWZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5H79HCk; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733386529; x=1764922529;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EtFM8y9IS2mtUR+84P1wT/Zd8/O+xLK0jKLdZwb2jSw=;
  b=Q5H79HCk7E//SpwsuE8USYzTKT4BpgZZEeCggABbgU2CufUaCYsCNvXI
   zp+lnjjLTda7M2JHs7CqDoXNiy/hpg8JKiCRQysxLnypFbbHdc7IYAnlU
   l4cRRu/Yhmqen6BgUOQedXun4ST2QjhMp+9lCDfYvTkDMheIcGCaQJ8go
   DCw1UAEV+xS+grO73sB/mMDEhdZ3tJWkPF5bn1Dc3nmoaR2TNGJVYHlgg
   ssy3K81P0c2XW46l+IHKeN5wOe5fIg6qlTsx1luzv8G/jEEajJDYV2CMw
   rkE4DRrcIETM2w+/5s5uOjWJiVITP5VQOfTH6QOkKf1l6GxMaivIe4tEk
   Q==;
X-CSE-ConnectionGUID: K2VZOxGbSKK8Xa+sQnKubw==
X-CSE-MsgGUID: CHCXKD0HQryWd4H2jD8LaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="21270547"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="21270547"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:14:16 -0800
X-CSE-ConnectionGUID: quCRSmPoSESWfFQjlOFd6A==
X-CSE-MsgGUID: IuM+mHKZTHeVyEzh0yEAvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="94373131"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 00:14:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 00:14:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 00:14:15 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 00:14:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iqe8xDAO+NbSrmeP8ra/H+1Y0zLUvQ97UpXoY7vFeIFTxXbu++2/wkJklRm+929hsuumhcpMrCqS4Wgm2wyGKC5CIOAFjHnVExIstJycEsGbbHgM/aUEkKwD9eGdwd3wqphxzXSc5OKqTyHhz5DA3dT4IbTe6fYStLAhwUuKqQeXZKyXA6Jf3bBWzE5xzB7erNpv0+0UjsBftmAe0YwE+Ba98QZEYLQqP9CFJlw729tGS4cYNvwXukMSJqszrQce2smrJiNmyELB9KjY6W+wbEXPUM8tyEr2burSlqjLxtKRAiqQbJRiolPQLXgUv/U4ApXc48FQ60th4LttpSS6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWYCku+If/II5pPo78GjHdKsrAXtkm7NLKOuwo28Ip8=;
 b=YDH601ZhrJBlr4hYCq1fv3gWyK1CfCGsEzR0/qjEO7njHkbRtdwR2sAqE3i7zvytRzf5KqcyGzyK5g3+1x5aFBN3bD73m8NzCEFRWJFaJHFl0GpvDBfq+pspsvHVykj+QA9ynIPdalaog/YlpLmgN41kE+KMV+IIz1GGsaYmiq1jQxBIyWuhYPp16QGNVMjimnWkY7t23bPI/pc1H8mhythZu/EB2zBOhNJ6vd1EhkTuFXsOCUZpJhfnVVr88iWQMLN7rVTel9KH1ZAu5WpSThCDJRJ7PJ8rC/ABPIP1rfpXOt5jiybVlhaF9dExL0B92Gm0olX+Cp1594zWStKv/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 08:14:13 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 08:14:13 +0000
Message-ID: <87c2743c-1ee0-4c6c-b20d-e8e4a4141d43@intel.com>
Date: Thu, 5 Dec 2024 09:14:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 4/7] phy: introduce optional polling interface
 for PHY statistics
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	<linux-doc@vger.kernel.org>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-5-o.rempel@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241203075622.2452169-5-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::21) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b92313-f9e7-4fbb-9c64-08dd1504cdb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OThpV3pXU3FXY1NmRmFmZER1aG9zZmk1aTN5TWp5eUdOa3l6M1IrcGg0VmJj?=
 =?utf-8?B?dkptMDUxZHB6dnR4bHV1WWN1Z09XV3RzM2dGOHlTZ3N6eHFjZU96YVA0Y0hl?=
 =?utf-8?B?Y093ZFdUVkNCeDVkRlphRTloWFRhUGpta0ltb3lwWnd0a21VanFVWXJ1RTZY?=
 =?utf-8?B?cUY3N2lBdzZ1Q0hvaEJoWTNETldYTmE3d2ZSNkdtcUhkR2ZTRWxnd1hYMDZF?=
 =?utf-8?B?UG04UHhuNTJEVTlvS3VEN1hLRmpmcHF5TEtyK2dNeE1BRzE0TWhESmttNVEy?=
 =?utf-8?B?OTBkZ25HNE9qbEhmeTNDL2cxRVRrbWs2YjBLSmcwa3cvVk9MZHM0S2pMMlZl?=
 =?utf-8?B?N2Nyak40SnUxenlNYkplV3ZVOTJSemFicm5pM3VyU1UxR2Q3ZENkRUV1bDN3?=
 =?utf-8?B?cnpuUTQ4RkNueEJ1cERNWHQyeTFINER3Q2hLSENCNkw1ZFZGK2NBRDU5bzlx?=
 =?utf-8?B?QUlvS0I2ZDhGL0RsN0p5blkzQ0hFd2J6TjF1R3dMbDJ4VE0vcGsyOGlUWDBN?=
 =?utf-8?B?N29wMVpiazZXUG9iQi9oTGhxYVl1VjUyTDZydW5mZEJxVG1BWEFHOGduTEM2?=
 =?utf-8?B?aDB0M3drNEpXUUpheTUwY241MmJQVEM3bXBuWjg2RUlFWEs5Tmc0azhORkQ2?=
 =?utf-8?B?ZGJsZThwTHNBTVY5dnQrUEp2blpzdWxiM08yb0dud0w5bmdaMzdFL1EzWE1O?=
 =?utf-8?B?ZTNHaG9KNE5iOWpLQ2Mwa1R1RDBZeUtOM0Q4ZVpOeEIxdy8zb0xXSGo0RWYz?=
 =?utf-8?B?U1d0a2xkbFd1aFNvMVVNREMzejJWQi9sY01nNjZyeGlkQ1NXYU9VSG1NUVRj?=
 =?utf-8?B?OWxwY251MTRXdVVWZVFXOU1LSlRqNWtvREJPaTZ2NFRLYkNRMGpkMHp0SWJO?=
 =?utf-8?B?QnU2L05aZ1pHckgvNFg0VlRVZXFFNlBMN3NVNDFZdG40dlVVWGNGUmJjNXEx?=
 =?utf-8?B?a0puSUdxZDVBbGlzWTdLRXJNdGRwSkgzVUV6S1I1QjlMbUxuS3NxWVhOdHVU?=
 =?utf-8?B?YWxoMTNCVEIvaHlGeEtUd3k2MUxmdjdNbjhRQVJYK3gvSlhUdUo5ZGxNUFpp?=
 =?utf-8?B?TjR5TG10cGw5OS9rSjhBcHg2bWJNbTVuOU8rNno3V256YkVhd2lWUkN6NWZK?=
 =?utf-8?B?eThBNDNFZHFuRGEyMTlaQ25zeXNMemt6THNmNVBFTTdJMWVrc0RMUER5TFJv?=
 =?utf-8?B?a3d6eWtDdW4wMVVXSWhkYTd4TFZsZEEvMVJpNTlzanpZVXFlQWpteEZDaWt5?=
 =?utf-8?B?aFZsQ1BxM2lRdVhWdk1hcTZsUjM2b0FNaWlWRllpaDhWenJGVG50MGh5aHE4?=
 =?utf-8?B?TEJhZk1Sb2lkSjRMcTlISXJMYWxsVzdnNW5Xc00vSlYzNHJ0cjBVQ0luSENV?=
 =?utf-8?B?SUovVTRJTmU0UnJRekZkVWxnM0FjRXNnbnRUMUo3NkY0a2xpL3hiZlVkY2U1?=
 =?utf-8?B?Y2R2aTZNaFYxR0pDOHdlcnBxdzBtL28zOUpQNFg0dHRvUXE3M0VWRzNkQnNN?=
 =?utf-8?B?a1hVMlNyS0h1M1VWK3QxZi9OTmtydks4UXlORzNuemF4SkhWeW5ZTnFLdFN3?=
 =?utf-8?B?VmVmdkd3YWQrOXhEbjE0d09tSld0NlBNMCtidlJaNjVJWXo1dWdxQU1KeVZT?=
 =?utf-8?B?RVc4aFBLLzU5WUh1VE01YnFsbG5udVJPWi9nS01DeW9wT3hXNUp6SWErVzBW?=
 =?utf-8?B?YXk0MTN3Vms5NEQyWlJVdTRUOXRYalpkYy9GdDlkN0huTmV6dlQ4cmdKMzdZ?=
 =?utf-8?B?MUNMTGsxbDdlN2k1K2kxVGxMbllpRXNaaDZ3dHRhR0hndHhTMXA2YkxOK1Zh?=
 =?utf-8?Q?7K7jfIGJBv2OKn6EHRf6jfGS0ITRUQIhsPjgA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xMZGNHaDUwMGl2ZEZUYVFYYU5uaXRwdmlGaWFPaDdPT0tvcmpwQStTdU93?=
 =?utf-8?B?aWNYVlBEM1Z3aGNmUDY5S3JRK0E0MFFUS3ZxNjllS012YkpRS3d3WlVsMlNR?=
 =?utf-8?B?M1B1eHVETFlydzl6TFp5djI3UGJEV01oZkY2dVIrK09GOStxWGlkYU5jbWVo?=
 =?utf-8?B?aS9lNHNJNm1nditYVVhTMDU3b1pzckdFSmRjVjBOcWttVGt0U2UzNEluY2Yr?=
 =?utf-8?B?L1p3bkk2TFpOMzE3dVdiUE0zYkVZL09ZbitLdndJYjV2UVpOOEdRSThHK0NC?=
 =?utf-8?B?VXRabkdwdkNuS0lEeHVTZHFEYW52aklIUHY0cG44K0c1NFVtNzMwbU02RHhN?=
 =?utf-8?B?MS9ocjlXbGx5cVhQOXJEb3RuQlVBaVR5bm01eEk3OGZybHk1dnJDd0Q4RzV5?=
 =?utf-8?B?U2VjRzVuMDFPTkEvZUFkM0N2d3lTNmNvMGpsNGJjZXV3NjBJUXlnU3JObGRk?=
 =?utf-8?B?bVVMVkRWT1Bza0VlbGZoeGNHbGNveHVpSDVOTVBhMkJiUWJDL0h5YXQ1eEJD?=
 =?utf-8?B?SVJYd2N6bXl2MW5YdVZoY2k2TEd5Q2l1Nit5TmpkSndPTC9DYU9IZzZQelpS?=
 =?utf-8?B?NXp4QzBYWlNqSnhYZWZtc1hwTitGVkdFcndHb3NLWHpPUW91alBFd3krTFUr?=
 =?utf-8?B?WWQwZXE5VEF3MTlaK3FuSUN6cENOeDBNUUxaOSsva1dUaEZxYU9OZnpNOUZB?=
 =?utf-8?B?MDU1SkRFckhzT2IwbFdFK29XZWthZ2JhTUFFQTVtMUF6R05DYmxkL1FZVUdH?=
 =?utf-8?B?bkw4aUlpZHJDUE5nR1FiOE8wNTVEYW1mc0o1Q3lrZzNtOE84RUllWk1WR2RS?=
 =?utf-8?B?RDNVVG43NGwzMFNxRHYvWkJkTmhvTmhaTVN6bVFsQ2Nlb3FCZjVFZmVKZWtl?=
 =?utf-8?B?NTAwWjlsSmI2TjBDbVAzeE5NNTJSWUZtOEd0UnBxQ2k1RW9nUkIwRDBXaTBB?=
 =?utf-8?B?d2NubGRWV01GQklDZE0vRzZlZVRtOG9yQ3FBNTRTeUpxcWkwQTJsZitwdzdy?=
 =?utf-8?B?NkFqQVpYblpCVUpQeXJ0WUo0NkphTmFxUmZvY09aMWdtZHZacC9YMWpOQUQ5?=
 =?utf-8?B?K2JmdzZVemloOVU1dHA0RkpDeGlPUkM3WEZKLzkwcVFYMXBBTXdtV1ZiM3Bw?=
 =?utf-8?B?SGdrLzRpNnQ4aytVb1NLY2NtL3p4YmJQZXA5L1ByblZZVWxJdVUyTXVMMCtG?=
 =?utf-8?B?NHBWclNzbkVqTWJ5TGJCWjdMYUpVZzJ0WmtzQy9HeHRONExGeVdWVUJGZWNr?=
 =?utf-8?B?bk0wUVJhalZ4bG1HaXVlRitOMjlQYUZpQ2xjTkxXUWhXbmNxTUtsN3VROVd1?=
 =?utf-8?B?L1puZ3djWFlROHJBRWcvank3SUhyeGROV2JVZlovRGM1TThEOEdjRkpHZVhL?=
 =?utf-8?B?VG5VTDQxSjIxMEduTWswTTY5anF4eG9CSzRkM2NQeGF5UW1UckE2VDN1Y3Nt?=
 =?utf-8?B?Q01aNDFqZzEyU25lUDg1L0M2T1JzdnMxdkdaWGhVckh5cjl2M0o3Zkx0TnBG?=
 =?utf-8?B?Q2EvWHdHZ1lyQ1BzUkl2ZFM2VUdvbVBYbTUzTmZUa2JjaVhDMS9oWHFUalJO?=
 =?utf-8?B?MVRGWUhJVFlOR2swbVFqWnpzSWFTRUxFRzZpbWdIVmVDZG1heCtSano1a01n?=
 =?utf-8?B?c3lJVjNNVTArWVZLSXdydkhqdFMyOG92NnVUblgrNDRseHZEd0Y1QlZlWFRH?=
 =?utf-8?B?bzNoK2RVZ3pobWNqRElSNHNKeTNhSGhZWE1xRVA1QjFqckthSmpwOGRlY3Ax?=
 =?utf-8?B?dTdScHd3T2hUbUt4cVFSeUJCeXVJbE5rVHkwNnZlbUUvb1RMcFNkUyszM2FN?=
 =?utf-8?B?Ym5sd3Myb09UWHVPczcxSU03aEUvQzJXaHRPR1R2NGFHQk1VNEo2OGJSTDZt?=
 =?utf-8?B?cDBRRm5wT2FQMVNwQnZWRXVhVmhXek5CUkEweElNRTkxQzJRc1h2N2RtTWJX?=
 =?utf-8?B?cGdCaTNic2sxTitMZlk0aHFBZEV3L0ZMWTY5cnFSZzh0ZlNSZlIwNTR4NDFo?=
 =?utf-8?B?L1RWVDNRd25SeG1OaUtYRjA3dEtTY3JaYXZIbEJkQUZZQWVudi9mOFYrMUZu?=
 =?utf-8?B?YkFDY1k0emxSQUxlVTk4ZUpKdDg5dGtWUnpUeDdNbUw5V1RTaFZoUHBvZWw5?=
 =?utf-8?B?WkZCdURiZ0RGcmlhZmZoRzJqNHZhVU1KejJ3WVhzc09CdnFmTnRHbktUM3li?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b92313-f9e7-4fbb-9c64-08dd1504cdb7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 08:14:13.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWrjbDJa4QaFiAHnopnVX92LX5G3h2HIoTD6xNcszcvbDquMvIGmKB8z/w77nM5EiGcPqJfExSaLcxZGJ33OlgAuBgf61TecjTnYRUoOk28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com



On 12/3/2024 8:56 AM, Oleksij Rempel wrote:
> Add an optional polling interface for PHY statistics to simplify driver
> implementation. Drivers can request the PHYlib to handle the polling task by
> explicitly setting the `PHY_POLL_STATS` flag in their driver configuration.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   drivers/net/phy/phy.c | 15 +++++++++++++++
>   include/linux/phy.h   |  6 ++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 0d20b534122b..b10ee9223fc9 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1346,6 +1346,18 @@ static int phy_enable_interrupts(struct phy_device *phydev)
>   	return phy_config_interrupt(phydev, PHY_INTERRUPT_ENABLED);
>   }
>   
> +/**
> + * phy_update_stats - update the PHY statistics
> + * @phydev: target phy_device struct
> + */

As this is newly intoduced function I would love to see the full
kdoc header, with information what the function returns, like here:

https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

> +static int phy_update_stats(struct phy_device *phydev)
> +{
> +	if (!phydev->drv->update_stats)
> +		return 0;
> +
> +	return phydev->drv->update_stats(phydev);
> +}
> +
>   /**
>    * phy_request_interrupt - request and enable interrupt for a PHY device
>    * @phydev: target phy_device struct
> @@ -1415,6 +1427,9 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
>   	case PHY_RUNNING:
>   		err = phy_check_link_status(phydev);
>   		func = &phy_check_link_status;
> +
> +		if (!err)
> +			err = phy_update_stats(phydev);
>   		break;
>   	case PHY_CABLETEST:
>   		err = phydev->drv->cable_test_get_status(phydev, &finished);
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index a6c47b0675af..21cd44d177d2 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -90,6 +90,7 @@ extern const int phy_10gbit_features_array[1];
>   #define PHY_RST_AFTER_CLK_EN	BIT(1)
>   #define PHY_POLL_CABLE_TEST	BIT(2)
>   #define PHY_ALWAYS_CALL_SUSPEND	BIT(3)
> +#define PHY_POLL_STATS		BIT(4)
>   #define MDIO_DEVICE_IS_PHY	BIT(31)
>   
>   /**
> @@ -1101,6 +1102,8 @@ struct phy_driver {
>   			      struct ethtool_phy_stats *stats);
>   	void (*get_link_stats)(struct phy_device *dev,
>   			       struct ethtool_link_ext_stats *link_stats);
> +	int (*update_stats)(struct phy_device *dev);
> +
>   	/** @get_sset_count: Number of statistic counters */
>   	int (*get_sset_count)(struct phy_device *dev);
>   	/** @get_strings: Names of the statistic counters */
> @@ -1591,6 +1594,9 @@ static inline bool phy_polling_mode(struct phy_device *phydev)
>   		if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
>   			return true;
>   
> +	if (phydev->drv->update_stats && phydev->drv->flags & PHY_POLL_STATS)
> +		return true;
> +
>   	return phydev->irq == PHY_POLL;
>   }
>   


