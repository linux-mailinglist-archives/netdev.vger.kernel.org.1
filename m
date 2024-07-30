Return-Path: <netdev+bounces-114083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D25940E45
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D293EB28BBA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEFE196C9B;
	Tue, 30 Jul 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eU3zxDOb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E521946DA
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333062; cv=fail; b=OxbOa2Pt7tx5TMbDZwiIpEbpS/xIlKmoC/PxuxcmvrukyykgM0pQF8hSu+rN4erU53JeSlg2G1T6blP2FkHWYT782LjVpKHrmdoPo0k/l9Z5P+HoXf9ZlQabHoSzMA6/78Pa1hPpKv2LyeH8iIyMe9yP/gd33CMGrYchCT5PxRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333062; c=relaxed/simple;
	bh=pQ+9bqUymrreCLCMO/YmtnfN9VkebJRnx5SoTykBYgQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fph7UBxZ4NB8ihtify4OsR9Aq75E+hYmUV2sd6w+glZdURyHyCQ5wIpCkaIyZlvTPmGD2r5tvCrbG9BvoaWdenhfmnJhYy0jiUtq3gSJLDlISvP5MHnxCPcgfHyD5KhJ+xwouudeYs59tVGu8SZ5nDCOJGI0gNpUVMqqvmqWXVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eU3zxDOb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722333061; x=1753869061;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pQ+9bqUymrreCLCMO/YmtnfN9VkebJRnx5SoTykBYgQ=;
  b=eU3zxDObqN+ZvsM9q/AgzvRbx9f4Ip9CpSWar92Dtj0V7HSPxaWRhcjm
   eYRGoTIeMretml0LZ4msdVbaTVyAxUQ4ajziMehUj1Jt8nPhEGxKLYWP8
   e2moDHxu7sVoPXCF/AGfR8Vn0lrOCrC+z9bcwj4NjsYC58kR10IIv0nry
   2KRfxhOCS8rkhPBiB0+u5LGxRXzgi2oxfK1nMbkgq0umWgmk9hGPm9jGp
   qvWrOgj5+EB1DoVe9wn8bqAN+iuyxTLaqV2wT877uEYMQbvra8TfR2+Du
   SJDTrdo2u9ZTsFgIQk69QUzZv6or/FRYGzWS4rYw8o7CfQ6RVqTAUOdwA
   w==;
X-CSE-ConnectionGUID: hvgE69qGRTKhmhCTD1Cbig==
X-CSE-MsgGUID: 8ThYI74bTU+AraqSAfVyqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20294202"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20294202"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:51:00 -0700
X-CSE-ConnectionGUID: /6w+ID6oQgec+OtDwRS8Aw==
X-CSE-MsgGUID: ntcBYHT3S8WNr1ARVBdB2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54336676"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 02:51:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:50:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 02:50:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 02:50:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aByecJc+pS52d54q4qEoL9mwVNtuODgeZE+kTjLWPQU5PDdM8brf1LbbGut1qAQIADA7UZmsL50bmKYhwIxi8IQ1gEdJ7iCU9lmi+mDOI1/zNa6k98fI6vdVNXT4YSwtnxBrO2urMrw2K+uVny/1AhgMllWzn2fq4/1aJh1xksj+ONQuMtC7IFQv7l6eZh1L8AZ7fFJVWlT5MrIQEOEl+PoIXYwjfe+Gv0UjTihAWtdvF3bfMCGK8WzOXpwY+a6PxCn/EF4P6tzagqatf1CNXP3F5iCwYLDoZGO1o/loZSsW+N4ywFCPXBejlOVwKZX+zb8enH3zTz0zhDLMWXKvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFrTaNEPXpBSILb6uR+zee51IeESv8eVPo2WG5dZGz4=;
 b=Q9IqgRPIb7HaS5TPN4VNvohrA/Z+eisPhjMLF4WKxMRAGeOlcFSeD8li0vbJUwimPgpnyTN+uirXF867NiY3yVXVVpW1oqoi+myUZsbXuqrc8AFHgOm6BwWL6ZqW0zGbVSlTeDdqR1p4Cx3Wkc9V+YH3NRnWOtMrHv41M2O5uakW/2+eS47TXSc+ESgZTLSjqA7KJjPpcJF79aDTAlL/8/NK7Khkvp7ed4Fvz6RkP7ReqnDMmVLqPYOkSPsWC7j1NuRfBgtgHXHwRVawtOspOSXfn9s+svVLwmvnlANBC9x64n3cR1mBTDpuU1Wt9OR5egSxASLJaNVJQuhVCLKxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:50:50 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:50:50 +0000
Message-ID: <d3d5d0cb-83a7-4b53-a07f-7b00db3ebada@intel.com>
Date: Tue, 30 Jul 2024 11:50:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 8/8] net/mlx5e: Add a check for the return value from
 mlx5_port_set_eth_ptys
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
 <20240730061638.1831002-9-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730061638.1831002-9-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::14) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bc0961-0a2f-4731-8f29-08dcb07d1856
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bElYSjhYY3gwT0dFS0M0dlNRUStSam1HNTh6Yk9wT0Y2Z05tbnZVTHRhalJk?=
 =?utf-8?B?S1NRZVhmZ0hsZU5pSDc2MXdWZEJKUWlaUnN5N3ZtVDl0NE04eUJ3bTNZQXp3?=
 =?utf-8?B?YnJVT2pMeS9oU0VjSjJyWkZteDRTZXo5dVVJdFFwRDlDSGYzV21zSWhSb1pp?=
 =?utf-8?B?LzR5czJ2dGpyS2RWTXJlTFNTMkJEWWNIclVTdWJ1ZXY4MVM4dVJoQzJ0Vitm?=
 =?utf-8?B?UktDeUlDckt2bitMbmowSXI3Y3RBZU1YbTZMdURlUm1QVkoyblk3SXZSUGNm?=
 =?utf-8?B?Y1JZRmhIM2VQOUpGV3Z2Y3NvRFh2Y3JGamY0RmdqWnhJUmFqSmh5L1Z4eEt5?=
 =?utf-8?B?bmpiWlBsbndaZExDVVdiemVhalhnWjdZVy8xeUFrZVNEN0xWQm12bFFqN3Ex?=
 =?utf-8?B?VDlxdkM5NUZwdEJGQ1cvaTBQb1lMRUtVSm5RM0pDOFlQMlZVdUpzQmFIOC9v?=
 =?utf-8?B?alBxemRRQ2xPTkhIOXg2eHlMTGhxcWc3ck1KK0J4d1pGN2dBY0VscjJSOE44?=
 =?utf-8?B?VzJ6akVzUjUreCtNRUh2VXBWdS9NV3MrTUkxQisxdmJSci9VUVhWcUkzMm81?=
 =?utf-8?B?UURtRFAzRFlkRW9wYVhCQUZwRGdUSGJHMlByRC9IbmxrMTQvbFpkM3MvTnRp?=
 =?utf-8?B?ZThjYjFicVJ5WDh6bm9KcXFOa0NlYURJdnkvM2FYYnJlSE43ZktkdEwwSnVu?=
 =?utf-8?B?MlJCWjhnUm9MNHNHQVdmbWdKbUFRRFhNdm16aUQvenFvRXloWnY1azdZclVo?=
 =?utf-8?B?VklsTXRMZE9rc2NHMzZWcFlRTnFMQnRmNDROTmUvekNVQWIyUzYzd1ZKRFB0?=
 =?utf-8?B?cVpkUWVlaHV2dU1EcTNkWDB2UE9NYW5tVzNHSGJXZWRkbE83VGx0cmVrNUo5?=
 =?utf-8?B?SEVIa2cxT1hyUzNHWThlamNnZy9uY1VQNnBDbzVObXlpKzZTSFcyTHprN2Jy?=
 =?utf-8?B?L3J1YndjV1pMcWZpOG5rS3V4dzNmMlNlRnF4cWV5MHJweGVBTEhYTzc1LzBv?=
 =?utf-8?B?UHFid2Q0ekVzdDMrUnpmNHJiRTluR0hXYXR6R0tPNzk1c1NwdXByZjkwbDNm?=
 =?utf-8?B?SUtLVWllSFFyV0laVmtNUWN4TW9ZbnJWL2dvMW04VDlZRjJ1MC9hcjM4M05k?=
 =?utf-8?B?Q2o0cHo1ZmtEalR3d25TcGJCNWFHcEJReHFJY0plemp0dG1PZnZmcWhWR2Q0?=
 =?utf-8?B?OURMQWtwQlpPWU54OWN2NGIrVTA5bVI1REY4T0lod0I1VEwvZXE4Q1N1WDYr?=
 =?utf-8?B?YkhIQzJjSjZwbURsRFRma3BadzFpblB4VlZSY0lzUW5BUm5DTll6YnVxKy8z?=
 =?utf-8?B?YW9JY056cndIZDNYM2dxOXdxSnBDaU15M0FndzBxRmI5Ym1oZ1ZwOWprYVlW?=
 =?utf-8?B?ZmgyMlE4dmhDNFc4T1d1UVluK0RuMEloN0x6OGp2UEROTEl2MFR4bk42d3Za?=
 =?utf-8?B?WjhhaFpFSTJaeTY0cVZoWWYvdFdzSWowZzV4T3NUcmhvVmRnZWE2b2RBMXNX?=
 =?utf-8?B?Vm11Y1pPNWVJV3V2VCsxOWJnTFUvMmRjelFOS0NDeXVyZ2FjcnRERDQrYXpx?=
 =?utf-8?B?MUpUS2VyUGdjTzE1dHU1Z3p5QkpVbXhMeE5keWdBZDJsTW83S0czMjZ4aENz?=
 =?utf-8?B?eU9Ub0RTemF0WkhWUWJQV2lwYVlDMnhNZmdBTGpzc2tZYlFuNlhvSzV2WFUv?=
 =?utf-8?B?eGJLYUY1cmM5VDZWMmhZaFk3VGJZaHl1dlBPaWI3V3hDeWV2eUgyRnE3UVBq?=
 =?utf-8?B?eWdxNUYxanh0TXJtUzlLUHZMaEQ5bjdVcDU4S1VEU2Nuekg0OWh3SFUwM3ZX?=
 =?utf-8?B?TDBSa0x2bGx5WkVQNzVZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K20xV2lGOC8yTXBjWnhId2lJdy9nZzdqcXI0cWdIemRTTi9TYTJhODFsZ0tr?=
 =?utf-8?B?amFyR1U0c3Vhc01tK21hMzJ6STRUNCtTNXhzWFpZdVFuRzdUOEcySTlWZmd1?=
 =?utf-8?B?ZVRHbkEyNzNqLzRMNUVWM3BFd3AzempNUExlNHZ3ZDNNb3ZrVHA0V1FDNW5M?=
 =?utf-8?B?VXJOaHVxSmJjcElCSXMvUnVSRnk4OTA3ZmU2N25QQlY2ei9MdExRUzNHM0p1?=
 =?utf-8?B?cUk4c1pGdjQ3R1BFZjNxR2dPL0dxdUJvQ1FIV1RaMU5ZZndxaUFnUFVZamNj?=
 =?utf-8?B?cXBkakpabFNYam51VXVBYTZHZ3BRQW82N1kzNlFjM2wzdHJmRy81TDlLdkw2?=
 =?utf-8?B?eXh0UVBBczlRNVVVZENMNTk3dUpyemdLNXU5Q0RlTU9GY3BZcFVHNnFyckJa?=
 =?utf-8?B?YXl1TnErSEp2WmNzTXVJYW96VWRqK29ndHlNS2dQSGI1TG1odUJQRGgwenFO?=
 =?utf-8?B?OU5UR0hzRzN2cVAybU56a2w2ZGlST252b21mWDVGTDZ6VytOWnNPbDN5bEpN?=
 =?utf-8?B?N2YzbE80N0h6cTlSU1UwYVloNURVN3JpWlhHeFV2UGlsTzMwUkladnVpNk4x?=
 =?utf-8?B?Sml6cG5sT01ETlVPOGlmbkxBdHN6U2dEQ05DOElaNWFoU1M2aTl1Z2tsTmRF?=
 =?utf-8?B?K0pTdWNvVFNXRStoNmErcCtEa2tjSjc2VnU4ZmRVU0ZZN1Fha3RhcjJYbmsr?=
 =?utf-8?B?dFNkSXhzc01peHJYRUJqRVFTU285NFJoK1lnZzVWT29hQmFXRUxzZnFHd0lE?=
 =?utf-8?B?WmVWbzV1OG1DQ3RQN3c5eVJ1cVRnSTFpZzE2MjRYZjN5ZmEwZ3FsQWx2WURN?=
 =?utf-8?B?TXpFTnpIeTZZa3JZY24vY3J5Ry9qUVdZek5KN0p2cEIxSjhseExsaVpTMmln?=
 =?utf-8?B?ZWFqLzhTZlNaeUIvSUhGUldkejRsTW1TU0hhTnJuc2xJN2NzNTQ0S0doUDFn?=
 =?utf-8?B?aHdsUS9PSzdkQU1Gb2t4UDhrOWsydElzM1ZtNGh4ZjNMUFdERFlFL2VzMjd5?=
 =?utf-8?B?UlRXMzVNKzV1aVBTVWx4ZFBCeUYzeGM2Nzd1dU5aaXc3R0R4SkU1UXdxNnlY?=
 =?utf-8?B?cVAvUVJ1L2VhbjNzNTVtYzByc3NEbDNJWjlRWitVNFZNUFRoYkVsV3duN2NB?=
 =?utf-8?B?OGlzbHd2Y1lYNUxmQkZyRVJtd1czb1c3UFpIY0tzSEFwdzhvaXp6MGJWUXYz?=
 =?utf-8?B?VXRxWlBKbGRHYlN1bXBML0JLQ09nclBMT1ptQUtQNi9LOU95cGhmcExlSmZ3?=
 =?utf-8?B?eVh6cXN1M29xSzBCWEY1ZkxlelhhVXFVRnlUZVZmZDI3VGFuK2FXbGliVWFV?=
 =?utf-8?B?amtNczBJZG52L29OQ3hHbndQbi9JeEQrY1hTQURHdWZhUHRIR2laZ0plemkz?=
 =?utf-8?B?NlRYajVWRXBIMXZ5UStvZDlaSnhUMjlqS2JkTXZhN1dkcGZ6NHByb1NHS3Jy?=
 =?utf-8?B?dlc5SWdJYkx0VmM0ZWVjNC9OemhkR3hhejlWd1hYSzU1QzNkQkNRRXMzbjBS?=
 =?utf-8?B?dUN3Z2xFNTdSSzk1U2tOSG9uaVkzYVFFeXRnQmdxN3hSMEtIWEYvV28wM3dB?=
 =?utf-8?B?azloS0M4VTgzWnpoeEhycGNkaFpidnE4SXJFTjY3VEU2M1pBTmZraDRnWFIv?=
 =?utf-8?B?cW56RU1tOVFtNXFXVmI1ZGpYZWZSOXhMbnRHZEl4YVhwWEY4dkgwLytQQ1pN?=
 =?utf-8?B?Qk5NQlZjWFIrb3RsZXpCNHNJazlYVXVTVFkrOGxFZ1dWa2ZRMmJoUVNPMVRV?=
 =?utf-8?B?Tk0zc3YxaW9kYk0vaFlxRFFkZDB3NEZURzVMdDFEZFVpZDdYY0hjMTlnWUFa?=
 =?utf-8?B?SnNvaXlHTGRmYUd4eUo3b2pOak5oV0tzdEI3Y1FVTUlvck1YTGUyUzlsZWl5?=
 =?utf-8?B?NDgzWklWcHJBelhMR3lzTVdVRk8zZGRFK29WYzhTYktMZHV5NnZXUnNFM053?=
 =?utf-8?B?WUJTR1AvRzlUeXkwQkVtYnlXYlc3UmFNMkNxaG5iUGE5QzFGV2tNMVFwUGsx?=
 =?utf-8?B?ZllUQTJuN0dWRlY4TEFValRGUHpsbnE0VGNhbFd5czZDMmlQUjVqcUFmNHF4?=
 =?utf-8?B?M2NoT0QrTGFDblI0VnczZW9QeHZjV2dLTEMyeWVBb3gwb1VWSTdvbXEwY0FO?=
 =?utf-8?Q?6TMIEiTMXqGRIdtlAHVD61X8P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bc0961-0a2f-4731-8f29-08dcb07d1856
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:50:50.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Sod2iE6FgrPMkgqL61L+k5GowWLDBXs+eQw2tGq892XqgcIWlwOcsWP7cTiNi5krQepDFEn+tpa86J7ZjVSRjUG+1GaiyPcVfWP8tn07C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com



On 30.07.2024 08:16, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Since the documentation for mlx5_toggle_port_link states that it should
> only be used after setting the port register, we add a check for the
> return value from mlx5_port_set_eth_ptys to ensure the register was
> successfully set before calling it.
> 
> Fixes: 667daedaecd1 ("net/mlx5e: Toggle link only after modifying port parameters")
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 00d5661dc62e..36845872ae94 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -1409,7 +1409,12 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
>  	if (!an_changes && link_modes == eproto.admin)
>  		goto out;
>  
> -	mlx5_port_set_eth_ptys(mdev, an_disable, link_modes, ext);
> +	err = mlx5_port_set_eth_ptys(mdev, an_disable, link_modes, ext);
> +	if (err) {
> +		netdev_err(priv->netdev, "%s: failed to set ptys reg: %d\n", __func__, err);
> +		goto out;
> +	}
> +
>  	mlx5_toggle_port_link(mdev);
>  
>  out:

