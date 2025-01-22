Return-Path: <netdev+bounces-160413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B596EA19957
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8753AC744
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42087215768;
	Wed, 22 Jan 2025 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MX+eQNuW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC021518B;
	Wed, 22 Jan 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737575244; cv=fail; b=DDtF8rGE6KzYHC5tCVRoV+Qg52VE33ScReIMG/cBy3dzQPpe8/tj1U36/7kTFp3HcKiTbhIYaUEDz2qaYpiNhZqZtsLWU/WJTBftxbyyQQok0hTZEWJ2mkv9Q70whpS6u7ji1dx3sDg72p6h+E2y05IhpeYAD97gkzbiedJj+AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737575244; c=relaxed/simple;
	bh=Tn7j/13jo+vHL8laQsugX10izlGzawlCGiuc1eG6K24=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A3czUhkgGu9acFVU/GsyTxmVZ2IzIqIea4WOM0XaszhVR/YcEHjGgwLMhZQmHHpgeQHLHH+l/p3HyO9IMK3qKjiyIoWs3RJ0qrMd0WQhpuijTe+oLU2TpuNMEhftsJJ/JVteX7vWLXy4wI/X9hGoe5FYHIpPj3ltB+Gd7ZgJrtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MX+eQNuW; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737575243; x=1769111243;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tn7j/13jo+vHL8laQsugX10izlGzawlCGiuc1eG6K24=;
  b=MX+eQNuWq4OMc0vY25v1xZ22VdKwybWSzUUYqbMb7fxPoN4hbfJeEJf8
   zbYtM1WRIBgNFQe+fXBgQB2ptPULgEM9rDagKvWfik9nzCyFAXBMQ6tbE
   rNM6YaijZ0PFbn5E9xswpn5ud010V+mJKRy06VwZM4m4iyPos7x0PQ6xD
   aWBJT1ARxwz/bP2Ddh1wcB9sJxPvgm+zK4eJQPRgeXyH7AFNeclQ92eR8
   rGVtt+MtOeHmyWQ9vxHdyT88HDFUoC1ogMuqHCz8AWEZNxPiEi3jd4PLN
   REgZuXIRq6o+6XsQ8Fm5E+GKFk9JWYjUt0Ve6zC/KW2ery4xwwxuNpcjc
   A==;
X-CSE-ConnectionGUID: 6rTjPktrRZmAY7g/HE7t/w==
X-CSE-MsgGUID: DkIt7z6vRBeABjxccyAtvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37929472"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="37929472"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 11:47:22 -0800
X-CSE-ConnectionGUID: qHidz4z+Q+GtlRor+Eb0IA==
X-CSE-MsgGUID: gS/HpTe8SZykJ+wpC66x3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112207774"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 11:47:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 11:47:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 11:47:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 11:47:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exegwvwCisd7OeKdrYVuVs719qWUt1L0donff8NPvo0RUWUm4m+hE8+57v2ypKOP+FcZSVjlrmDWapdvmUxmLW55pxV/SagYD0Ae1oKLPt20h9XzRJiRtOxuqCDQXv+Q+POISSvBV6lzb7E5zhjyc5h6kXx3Dml4gazeI16h4bY61l5oDor8FHd4UBDtPrU5tWqTmpuzTcoEwT1v6K2Xyk97Bj5TY5Ra5zq7q79/5LkLxVfhkWFNBfvv1HBaW2ZVTF/oryMTc468iyrjtoBdyzi+e70Ka8q/jDMm/D5njlEAPSJ9HXxN8XQ7lstjrjlmYudef0YL+3AqQSoZnpTENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0wBhpp3AaJ2/SgzKIopYXHHRJvIXFR6kL+mjNntgjI=;
 b=jh+xOAK6BTdZ9cZ1sIVxPqtOqMqi/0th+gJreTIlYRQVUGI7iwuxZf5PcJFkcFamzun4BnFhzGoKm7VtJychsaejjPcIJeqIMZXsvnQra+YnBOH2USe3E5e5dmGXU5IIkmSe2RteSdAFh85xYTN4cjPRjv36KbiUZJ0gA95IUxKq2sDs2i8OZsEgdOJn96sbezQhGkQxpn+CvjdN3OWDOZyaMfgn4LIOT0y0A7qN6dRr/0m5yXxuzIGGTwejdTAmLY1lRz05Ut+1XMdGBK7pj8g/LAcPgeoJ//vZGsT13oCq5ajoxcP4z408cp600VpCjwpNWb9358zYDL+CYHIFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 19:47:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 19:47:18 +0000
Message-ID: <b5a2e211-c3b4-4e50-9093-73165fb4afb7@intel.com>
Date: Wed, 22 Jan 2025 11:47:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>, Laurent Badel
	<laurentbadel@eaton.com>, Jakub Kicinski <kuba@kernel.org>,
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Ahmad Fatoum <a.fatoum@pengutronix.de>, Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>
References: <20250122163935.213313-2-csokas.bence@prolan.hu>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250122163935.213313-2-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: dee62c2e-79b9-41f6-27b0-08dd3b1d93ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVBvRUJyVjJ4REtYREgyYTVya2FrUzZ1MktyVHZjdStjQTl0Qy8yVEd2cHUw?=
 =?utf-8?B?YlhvUEZncjA3azNwa2h1OTZiQ2hOUmRMam5kb2MzUFFjbDZHS0JiaFk1cXhB?=
 =?utf-8?B?Y2NwME5LTExjOW1uZGM0QkJjSHN0SjYxZWFUT0JYZURYSHBFSzEvY092TlJI?=
 =?utf-8?B?dkpqdlhQempDbEF6a2hMNTgzR29JUEdpY3hSTC8rUmlmYTVHU1JnVkFIdUJD?=
 =?utf-8?B?dnV6MXg5ZkJQakpYN0wvbWoxT1JDeWVvL1NQMGRSUi9xaG5JUjFmTTN1VnIr?=
 =?utf-8?B?UkFubjRuRERuaFlXRmxJb0V6WkYzMlV3M01nM2RrZGVrZ1JzV05SeU5OVU1I?=
 =?utf-8?B?UUdEbTZSQ0R4RVF0OUM5UERFc3M4dkR1eTA5cGRhaVU3QnRZMjU0SkNieXor?=
 =?utf-8?B?LzZ5a3JsQTZNVENhaFVDNUJIWGYvd09xY1FUOWJVczBTbllOdU5rNlpDZlFa?=
 =?utf-8?B?RXVWZVp1WjVnV3dYUnFhVXhyQVZNVThaRkpjcVVXelNSSXNpOStzcEwzQkFK?=
 =?utf-8?B?YS9rS2RPRHlWRlgvNkpWZ0UrSHBkMEhVODZxUWJxUGFGNnJjTlVtMTlZUUhw?=
 =?utf-8?B?eUtFUW1SVENzZEZBeExvMkVOVXVFMFpTUC9VS08wWXJYdVVmYVIySkI3U0RG?=
 =?utf-8?B?MWpGOXF3MFovSGJQMDdtWllLR0JzaEpHcU1wNnFscEVsalRDSVhvWnFNZ2FX?=
 =?utf-8?B?MjRFa1lxV1IyeFNVRWkvOHB0K293ZCtzSW5QRDAyK0RqZVNGUnVzcldOMlhQ?=
 =?utf-8?B?OEFIWjJrZXdsQWJMQ25JL2dFeTI5OU5UZHlaS05pUjNOS0d2Uk9ma2pWNFVB?=
 =?utf-8?B?NThwT0x4TlZCM1JHVXR4S1hZdG1JeXhmOWwyN3dyVkV4cndpQ2FYZ3dOUjBG?=
 =?utf-8?B?ZGd5MWt1eG81cDYxcUZWNC8rOHBWaDhKNzBxMnhPK1J4aUxRTlFGMHh0S1BJ?=
 =?utf-8?B?NGZaV0ZjTFZiUkdYT3N2VzQ4RDBPaFRENUZzQ3pZT2E4dGI3alQ5NDNyVUpa?=
 =?utf-8?B?MTZ0UnB3Z1BmQlpUamVvb2pLZEVENFVuNE54ZDIyL1dyUWQyOHliNFRWME1v?=
 =?utf-8?B?bFo5anFQeGRLeWR1c3FKeG5tcEFhZFc4S3lJYmdJMTRDR3JvUUtJOG9lbitu?=
 =?utf-8?B?NUZ6NVdzSm1aTjFNZ2w0OFpNQk5EL2NQRzZTblJUZ1ZMREtKd2swaW43UGw4?=
 =?utf-8?B?cU8wVzVRNCsrYVZGVU52Z25STi9SRTJJcTQ2Ymc4UlVJeW9IMTNuU09BWnZQ?=
 =?utf-8?B?WkhUVU9xYThVWEd4Y0JvdVBQeWN6VThheXBjWkNIcmpjK2xJdlMrRFpqR21y?=
 =?utf-8?B?RGVzU0NmMjVTRTVhWld2aHhUWTRnTXIreDgwb2s5dVF1MTd1Ri9aV01iblNV?=
 =?utf-8?B?ajY4WG96Q1AxaFFrT043MFFEOExUaE50bVBIOW8vN2d1VVlDOUoxOU1pNnR5?=
 =?utf-8?B?MWZIV0VoNms3Y2RWY2FwUU9XL1VqZ3ppQXRESzhlc0s5S0FxYldCL24xc1dK?=
 =?utf-8?B?eEJNZ3BLQTVBY2dpeXZlT2tJeUZrM2ordm9ITGQrRC9xZWVnRU4veWNyb3BQ?=
 =?utf-8?B?MWlISkMwalM4TVRkL0FjazF6SURpSVdMMnlSSHV0Rnk5MStibVFQOU1YZnd3?=
 =?utf-8?B?VUpSL0VHcE9ieDdWT05QSk9ITDBOa3RodzJvaGlpZ0d2OUZlOHVYMzlaVWxk?=
 =?utf-8?B?WFFqL1Q1SnM5U0hjUGZsQW4vZ2hZZElFZy9FRjMya1FoVWhWcTNRUFFmTnAw?=
 =?utf-8?B?MUNxUnZUZ0tCQUJBQVVBVkNIczFPTWdCUGFSeDBaWlIwN0NpS2FwVlJXSWZ0?=
 =?utf-8?B?LzFsM3hId2ZoTjlISStxb1hkYXJDTUtJUVdGZkhhdE5odW1FMmhqT0NnbERv?=
 =?utf-8?Q?SDuSw6NSX74SV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vjc2b2ZZQTBDQjlmays3RlNnRW9tcEg3TVFmOFZPN092NDZYY1pwd2dLMU9h?=
 =?utf-8?B?U3p0MXZuZURKQVc5SlZITG40U0lzeVRQZWs1bmt5NldpNXNmaTBQYmdSZUpz?=
 =?utf-8?B?azM5WUNzY2ZSSzdCbm5CeXo3K3puK3hXTjNVTlVlcnJqYXdWTW1NN3k3TElZ?=
 =?utf-8?B?TmJTSWhXZWJUU1RuNWY1TFhrSzZIT3hMUURmMm8vMnhjQlZUT0lrbnVJNE0y?=
 =?utf-8?B?RUl1dEZoYkFOc2o3dXVUTVVLZ1hFWWpoVHhxTkpQRkhqcmpucm1sSjFZV0sv?=
 =?utf-8?B?TUNjOVRnMW9BeXEzUGVvTGVyZzFiZzFkaHhReExBbCt6c3NJU04yS1cxd3p3?=
 =?utf-8?B?RFZ5cVpjSXdxYWdwdktvT3NiWEhpaVpTODVQeG1PT0JCdlNlYlNvMkd3dFZj?=
 =?utf-8?B?dG9qOEY2c0JWU25PWUFkSHluYVptUCs5ektiV05nNEhMbHVvV0NXdEhma0Y4?=
 =?utf-8?B?NUtVM2E2aG1HTkYyYmFHK1JGenZ5b2JBSmw3NjZWblRVR0hheHRYMkROMXpT?=
 =?utf-8?B?cmppSVdVeS8yMDByNFE4TUJ4NGZCU0JtL2k1UlZ4SGJFWFQ2S3pLUXNEZ1lC?=
 =?utf-8?B?ZFM4Uis5TmRtNk5KOUlMcnlLcERLRVlXZ1lrZ0pscjlVRG1YV0xWVXRZMzRY?=
 =?utf-8?B?UEg4M3FDSkJqdmFGd3ZQVlc3b1FLUnFMOUhTQWJtUzZialZYVWpkcFRKclFj?=
 =?utf-8?B?U2k4NnNobzNMUkRVZFBpVVprNXUwZGJDd24rRjB1NlFvcFlRcnd1K2w3bFRR?=
 =?utf-8?B?MVdHNDZlbFZjcng5emc2MVpmMGRKMzMrM1BHYWIrbDZCOFFwOFJvOGZXLy85?=
 =?utf-8?B?OUdjeFVtUW1MSDk5c0t5cCtYb2hpdDdJY0UwSytGcmM4VkZLdkhNbWNJTTBL?=
 =?utf-8?B?S3JYMk81LzRKV2VhbEt6VHZ0WEZSVWgyNm84YTF5Q2c4a1EzWjhzUjdicXRq?=
 =?utf-8?B?V09GME5jbWpyWFFqajkzKzdzMWFXa2o0Rk9ycXpMaVF4MTlGaWtaTFI5KzhV?=
 =?utf-8?B?L3JHQTJnLzJIY0dHZGN3cENCYzZpSmlwcElkTHZrRXkvQVh6SzErcGV6ak02?=
 =?utf-8?B?OFdyY0xuNmdEN2dKRFBUd0ozMzhVUm83Z0dMS0lFVE1OUFE0RWpPSlBHRVFy?=
 =?utf-8?B?SjZKLzZUNDhvWEVrM1ZyNjR4MzdGMXRRSjN3c0F5VHVXSDh3Y3g5ZlRDd2JZ?=
 =?utf-8?B?SEorNS9vUzhtVGJwcUJ4N0t0c09YM2VXT1ZaWTR4Nk5iR2d1TWp5M1ZlK0sv?=
 =?utf-8?B?NHN0QlV6Vm91cnhzenRrTTNLT0p2akdBYnJUTTlWemRZOGFKL2FPZFFKYjQz?=
 =?utf-8?B?aElGeHJ2RDIyTWJCVFBuanM4akxNcjRiazJWYzVwWHBIRlJxMEFOWWhVMXJm?=
 =?utf-8?B?V0dzVEk3bjVPN0ZmZXFJTEdFZ1Q4c1FhZzQ4UDVJSDZtQ0FaTnpxLzVVM1po?=
 =?utf-8?B?UmNqaHJQUzZaYTNvNFpPMVpNV3FtMlRpZFNkak9GVUw4eWh3cCsrMm9aamtS?=
 =?utf-8?B?TjEyWHM2NzdJNWJzR2xnVlZRV1lGK1Z0dTl1blRXUFpTSnJrWEk2RlVyTWlD?=
 =?utf-8?B?TWxSb3VCdlVlQU5MNHloQjducVBmUGhpTjhONmhGY1hzNlRtVmpEWHhyUUVr?=
 =?utf-8?B?TGZ4MGw2L1BwblpCUGRxMlFhUlMrb25hRnpmMnFRaDNHZE1UUEtWVUVGWHJy?=
 =?utf-8?B?SDVQUjlUUGlQTlE2MUhpQmV1SVVRaGpraDg3L3F3cWg3K0J2QnBzUkpUTW5K?=
 =?utf-8?B?WFM4QUFEUGMvM1hBZVpUeEZrNnFVUlpyRHZOUFArelpsei81NkdYYVZRVGlY?=
 =?utf-8?B?S3dwdXM2MnlMUmdUK1l3VVRwRWw4Zi9zeXp6WDJQSWpqcHpIOFliWE42Zit4?=
 =?utf-8?B?eXUranFmSS8vUVRjeXl2VG42NFFodGVad1UzUVR5S0k4SjduS0xSSkRPMFBV?=
 =?utf-8?B?a1cwdzFzMmgxbUZsQUdoVk1CVmFQdE5IUUl5Ty9RM1N1RFNCZDh2Mk9UWHZF?=
 =?utf-8?B?QzAwWldiNWZxYUhuM0VmVFBVY3lIWnFJYlVIMVRCMEpTaXN4NHg2cWZaWGpN?=
 =?utf-8?B?cURBMFFhOHVnMkZiaS9NZlBsZCtrN2hPMlNBSDBEYmcydDhjeWtuN25INEcy?=
 =?utf-8?Q?1eGVu3OBcGbqvQmx9SIj5P3VR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dee62c2e-79b9-41f6-27b0-08dd3b1d93ec
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:47:17.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0LouZHkCalBMwAqHY6fCIgtsDS0Atzzc6dxWEjkEnAxyZJ+qAFMCNj3lf4GZgNowVMFWkk9WShT1IgVkLvLvSHyx+tthjrXqCQ3MPVD1F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com



On 1/22/2025 8:39 AM, Csókás, Bence wrote:
> The core is reset both in `fec_restart()` (called on link-up) and
> `fec_stop()` (going to sleep, driver remove etc.). These two functions
> had their separate implementations, which was at first only a register
> write and a `udelay()` (and the accompanying block comment). However,
> since then we got soft-reset (MAC disable) and Wake-on-LAN support, which
> meant that these implementations diverged, often causing bugs. For
> instance, as of now, `fec_stop()` does not check for
> `FEC_QUIRK_NO_HARD_RESET`, and `fec_restart()` missed the refactor in
> commit ff049886671c ("net: fec: Refactor: #define magic constants")
> renaming the "magic" constant `1` to `FEC_ECR_RESET`.
> 
> To eliminate this bug-source, refactor implementation to a common function.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
> 

You didn't mention the tree this targets. This is a bug fix, so this
should be targeted to net.

> Notes:
>     Recommended options for this patch:
>     `--color-moved --color-moved-ws=allow-indentation-change`
>     Changes in v2:
>     * collect Michal's tag
>     * reformat message to 75 cols
>     * fix missing `u32 val`
> 
>  drivers/net/ethernet/freescale/fec_main.c | 52 +++++++++++------------
>  1 file changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 68725506a095..520fe638ea00 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1064,6 +1064,29 @@ static void fec_enet_enable_ring(struct net_device *ndev)
>  	}
>  }
>  
> +/* Whack a reset.  We should wait for this.
> + * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> + * instead of reset MAC itself.
> + */
> +static void fec_ctrl_reset(struct fec_enet_private *fep, bool wol)
> +{
> +	u32 val;
> +
> +	if (!wol || !(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
> +		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
> +		    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
> +			writel(0, fep->hwp + FEC_ECNTRL);
> +		} else {
> +			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
> +			udelay(10);
> +		}
> +	} else {
> +		val = readl(fep->hwp + FEC_ECNTRL);
> +		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
> +		writel(val, fep->hwp + FEC_ECNTRL);
> +	}
> +}
> +

Typically this kind of refactor to functions is kept separate from bug
fixes. However, I think in this case, the diff size is small enough it
is easy to review, so I think its worth taking as-is to net.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

