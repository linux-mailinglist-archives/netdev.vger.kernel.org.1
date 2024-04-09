Return-Path: <netdev+bounces-86081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0EC89D78A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0988B1C20A4A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2BA81AA5;
	Tue,  9 Apr 2024 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ts0QRm/V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBC7C0B0
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660565; cv=fail; b=Z6jJ9QJHCuEOG1s1StK6r/GAxMtdWySK2Nyviw1qClDZhc/MZgP2D4O48xOxE3MDOnEiMEDjinTBzPKaCZRbMRyMjecISN0mh+omOHd7NfT95CUaLReHdwLrESvg+iI6gr5XmyV2hJQxxXlWn/0LSCu6TbvyaobZFLFErWjjtY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660565; c=relaxed/simple;
	bh=nJEOmA9Mn/emRMffT2qcRlERQqMQM5I6XsM8DdlmlWQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Paxtiiwg9f2cLRk7FobQLyeTXUfWYcDRbDyde4xyTRuGy/Jk8/M4cpHx97QrGeHFJsighzyJCOA7cILU6fgxKiUV3ZgIbmfrEldu4c9GspnB9MgyJuFURZvhk1Jo3tjbRE7DBJ99CP+OOo2i+mSqVviha6uVwXJlmf2+aN9a70g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ts0QRm/V; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712660564; x=1744196564;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nJEOmA9Mn/emRMffT2qcRlERQqMQM5I6XsM8DdlmlWQ=;
  b=Ts0QRm/VbtibidQCkzl/QCcfGZACRvHiBMN6rNzSjvQF3XhwM+Ny3jsr
   mBKt+PyaegKuH6BQ+uaBC3x5jXP7yEeEs7JmI58j4U8xReTmHuQZRhvU+
   Rgm9k36MDSc8AE6fJpDIFgb4EnvZPXP9gBRNpG4pdKB2aA8lXvuDAguxB
   IU4UzJ+Y0lPIQDv9eHfECru6JTJoIuC+/rAli6UPB9czVQH0N/WYGgOOg
   K1f940OA+b79/bBFkUmNTf605UVjYq5r++4RX97QCi8fcWZsN3Y7uXm2t
   RnE6E6+JsTcJri1ootpenbFX9NG0yjrLdWRmc34lvUSbNKlqBG63kFWmy
   A==;
X-CSE-ConnectionGUID: m+w0w9DWRc2ULTmgjiF2JA==
X-CSE-MsgGUID: BUhrtfCnQp2k0EQvZbgMzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11764141"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11764141"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 04:02:43 -0700
X-CSE-ConnectionGUID: OjmI7BXkTjue7tBiRNhEfA==
X-CSE-MsgGUID: JGRkvGQoRkKvaTRmpayLjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20083823"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 04:02:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 04:02:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 04:02:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 04:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir7Di//QlFj8H7sQl2m4aq3aDBPrGdnZ8Vp6rCGCVZgEygiEb8Y1GNPbfMqKvZoSZnKzHGBAqzdNX9EskF/d3Lu0OZgr9+btVID38t+TugYhzVwP3mExJrLI2HGecsGsWrBISxKQYMJceJ/QkkhKs8VpzyJ49kwtsMLWkcoIwe2vXNCFhwqYVHzLE1cTX4qEjuLJcIqgrhGyNiF/Zax13d3k/e8vIomUn15gajNTjUl9yERcY8VkEOixZwJ12JImPohindcDP3H3+S1ZiycSzQRDNGfD+/o7YZ0L93kvY/UcQjNoaw9lrK53oHlKGGJuCSM2mo8V/MsKSeKKd5ZfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6NLNZ8Fouc15J5vaQdJtlXJNIIaj+BEqYSha8DNUqM=;
 b=JP0AXFq4kmARdQh4NTGaGrquM3J1k00hNPhBLlgaeC6BTqN1eURDf2rH7QBbz+/v+naWWbKAWocz4IwMvKhVmuvfRxuc5CIA+ylH7IQ1THKSVifA0MWqzqT2A6t+OnTkauqUhrSK76XlITIYSEhKLNcdqG/RKUYhwOshAP5rMoIT8mplAjM94U8BZrUn8nV3NlUxLqEgEmeMAoNNBN8G6oiL4IkGLKzkKOEvYtGU/iPPUCLICjLP5bWmFr6HOCfVTBGoquBitjbpRECyipAjLHaB/Wf6yTcQI0WqZ4KrnMdSg/StFy4QJn/SZQlGaPFNE6l7bA8rnDX+B9Gjyq6ZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7559.namprd11.prod.outlook.com (2603:10b6:8:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 11:02:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 11:02:33 +0000
Message-ID: <f0b22f81-2de1-47f0-8cc9-f89c7a055867@intel.com>
Date: Tue, 9 Apr 2024 13:00:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 02/10] eth: Move IPv4/IPv6 multicast address
 bases to their own symbols
To: Diogo Ivo <diogo.ivo@siemens.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
	<danishanwar@ti.com>, <rogerq@kernel.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
References: <20240403104821.283832-1-diogo.ivo@siemens.com>
 <20240403104821.283832-3-diogo.ivo@siemens.com>
 <03660271-c04c-4872-8483-b3a1bfa568ef@intel.com>
 <e00f2f63-5917-47b4-a84d-075843af21a2@siemens.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <e00f2f63-5917-47b4-a84d-075843af21a2@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7559:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2paKqNc3dAGSQLTt493dHHmp1kUI7Rh3H3rIENG1Zg7/PeP7du7nSVNqjTzY4lV6E3eZ34udx+B60z0oxGD20S16o14cECSpO8qHpTif1LAuS+a/jcm0QegYT3nbv6GxeYYHpMwFwgR/JwftXePgQJnKor+McXpG577ks6sfvDqI76zOu84mnm8BvPD3O0E6JfzqttKzcJMKlOwJ454/ve/VUB0oVmWdgkIXhQxjTHGQzvhMf7l0GGar/65HuirSwz3kpmTz/Cmx/vl7cP8tkIl7PbHuncgRF5DCy8DzLeEGwZAnK6W3T3f9oMcmNoF11HP8lWXkwQrnlfsnJigU+uLpA7z/jWfNZQdg1V3HfSGpIsm7EdpunLpsuHWxag/1177aVroncd1T6rQ1vJeBZ/Eincbb8AwYaheS+6WknAZR6fz7opXEkzRsqGprwLFq/GGKtVMRZ59nKGYIxxntxDPvJeXEQiMvv90tqrnuhmAZtdSzV12a8RdSZ7MO0mogi4LrAE5e7WFCDskHTCvWGxsCWHkq20w5J5RjyLn+bivYDKTrLAJsVpezomWxYl2xcFm7cG8H0ejuUwlW53oemVdR0WqVcs361UKhbPsZJ2aNhL1XJ3Xk/4j8QIoqKGxGBO9iWrxZTKk1xdz2wf+uUf3qOUFINeAdz0aX0TSkBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk5mQngvdGptM3pNSlJxNUx6Mnd1VDdpZmdWZ0Z5MnU4WThnaU5MTDFGbGxi?=
 =?utf-8?B?WkJhZUNhczhiNkJTWU1JcUxVdE1LQ3d5RCsvUzh4UzZkR1drRk1GN1FFWTZK?=
 =?utf-8?B?NE9kWklKcXJ1VDEwRDFHbnQ5WnRHUlZTNEQyQWFuWUpzUTlFbCt2Y1NoM3BV?=
 =?utf-8?B?aTFiMGdGK3Bta2MxWTBrNFVHaE51RUlpZUNzY3FqeVN5SVMyRUUvSUNnd3lz?=
 =?utf-8?B?bDhkWkNZMkRZUnlnYm9CZ0ZEMkhBODNGOGlaVTgvN3BJb0tvazgyd0RHV0Z6?=
 =?utf-8?B?UnpNWjFWOG44SE15d3luUmlnWTBZY0lnMFlWNFBRdk95c0diUC94eG16aUw0?=
 =?utf-8?B?R2NiQ1RTaVE4Q0dUc3UzSE04czFvejh1cm1KUDljUCs4VW9lbWdubWU5NXp6?=
 =?utf-8?B?NFpSUTFqTGRQeS85RWJUclJvT053OWEyNHdxMWx3bG1NTCszblJrcnFNNTRr?=
 =?utf-8?B?Y0RHQUt3dFJrVlBhZkZTeFpFeGlXdlR4K0xZemRKSkw1T09zbVRGTmtkZ3VN?=
 =?utf-8?B?aUtibG1yMEVEMzVxeUpFY0Y1TFhhRTJCUlFvTzZ5ejZWYU9ab3p2MU0rcXo5?=
 =?utf-8?B?WW5kSkVOS04vdUEyTlBWUksrVVg5Z0JNaG1rSnlWTStzMGg5Y0w3U2ZRazBh?=
 =?utf-8?B?ZDdLQXhCOWhUem9DOEpSSm5EWm02MENlV3FFajlhSk1QMG41WDd2Ump4cVE0?=
 =?utf-8?B?WFEvTXdBZTk2VE1mdnc5VzNUNnI1d09Dcnh4a2xPek5FZXFVejFnVkdzYW0w?=
 =?utf-8?B?a2NlTmNSeWZmV2xCdzBMTVV2eWNXT25MS2MwMUtXTThLT3VCN2RETXR1S1h2?=
 =?utf-8?B?V2lRbWZISGo4enBSdjUvbHg4a2lCOFcydHV0c2RXeHRXeXZ0ZWNaam4yR09R?=
 =?utf-8?B?c0VpSERHdlp3ay9uVW05elVtNFhXOTVaa1VzRkJ3NGdzT0dxM0d2cGppNzFS?=
 =?utf-8?B?N1o2K0lPakRvakJVTnlrbzFXS2tEV2Ywb1EvNkFPeEF3bmt5NlprTVloRXlV?=
 =?utf-8?B?WmlsalBRMHlTdjZwMGJmaSt6MlRITmVvcHhSK1l0ekw3QVlyT0tuN0Fndlp3?=
 =?utf-8?B?ZkFCSlNUTmdJcVpZSjRpdm0ybGtOTXJ1NWdXbGNxaHIvanVWVzc4U1lYcTdt?=
 =?utf-8?B?SDRhZU1LZk8yenRiYUVyalVwdVpDYTJHSTZSMDlITHQ4SGVPbThNRFNDMUt4?=
 =?utf-8?B?ODN2WS9sNnM2cDRWL21yZlUrdnMvREJPeVQrWlk4eStkTzU5UzRIVHMzR0Fx?=
 =?utf-8?B?TTBib3Y1ZHo0ZVY1Y2FKWnJwVVVNOVJsYTl1R1pFcXRESVJsM243ek00U0Nh?=
 =?utf-8?B?M0FoZjIwb3BFTDR2TlR5dlNpMGsvbFJsZW9yV0NOanZOU1ZWVklwOHU5OEti?=
 =?utf-8?B?WWF3Uk5BOGtFNTJmOVFIemJBZ2s1L0NVRGpMemhCMmVZWnQ5NngyR1Z2allJ?=
 =?utf-8?B?WVZOM1Byd2tjTHcwTlVCa29PdUlXVG1FM2RiZThGVmJFTHgycUtwcFhvUFdI?=
 =?utf-8?B?R09PS3VMOXp1Z3k3QzlTRVdBL0RkYkRqc2xLNFN6cVN6aFFDWjVUWDJ5b2tm?=
 =?utf-8?B?NzZ0Vmh2aEQrV290b3pRUGtPcjgxeFpnQmJPRDV0bEVVWVRPVmlkV3l5dytB?=
 =?utf-8?B?dWlWN2RxUUdpOUgySGZoaEEzR1YrSElUUmdtTmhsRGJBdGh4ZzB2dkRqbW1N?=
 =?utf-8?B?ZHVBVi90OTdONTYra2gwQ29qN2NBaFpDbEtKUU9PZzJib0ZrNkJlQlFYMmxq?=
 =?utf-8?B?SitDNkJqU1k5UWdMUWVrYUR2M3ZmeTY4QmR5VmRJYTVNSmhaelQxVFBWM0hj?=
 =?utf-8?B?OTRZSGE2c2ZBamkvNWJwVXZUU1NZb3BobUZ2ck40YXYreHA1OW5OakxBdEtO?=
 =?utf-8?B?dS9wZ1hNS3J1YlNtMjdtd3BMMmdqSVFkK2k0YXZtT1hGMUVRTkZqSVVEZXlX?=
 =?utf-8?B?TnJiZlBJUGpnN0piUDhHeXZDUzh4YngyL2FJczFLZUlicld6b0VMN3NDU1lz?=
 =?utf-8?B?WkkweS9nd0VTUENkbDhPaEN5OElxK0g4eXdqU2w3T2ZPczA4Nis3aWdYQyt4?=
 =?utf-8?B?dDBjVDQzT050d0Rybm1RWkgwRm9rOVZZT3FMVkpCdkpRYlpPNG04UE1uU3NK?=
 =?utf-8?B?dTZZdkxzanUxMi9wSGh0K0luaGZGVWZCd3lhb3FTZE42MFphSEhKK0JxVE9i?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb62990-f76d-4c20-5ac9-08dc58848e73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 11:02:32.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO9MmmMLNHT9/mzNFwizQQln85tjLNNvyo4ShvHW3PFtnDDG5nbreqPwXEI9bT96shR38fyPmTKXV5XiDJdtWyei99t0DNl+lrSnSHdUByY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7559
X-OriginatorOrg: intel.com

From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Tue, 9 Apr 2024 11:20:21 +0100

> On 4/9/24 10:07 AM, Alexander Lobakin wrote:
>> From: Diogo Ivo <diogo.ivo@siemens.com>
>> Date: Wed,  3 Apr 2024 11:48:12 +0100
>>
>>> As these addresses can be useful outside of checking if an address
>>> is a multicast address (for example in device drivers) make them
>>> accessible to users of etherdevice.h to avoid code duplication.
>>>
>>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>>> Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>> Changes in v5:
>>>   - Added Reviewed-by tag from Danish
>>>
>>>   include/linux/etherdevice.h | 12 ++++++++----
>>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
>>> index 224645f17c33..8d6daf828427 100644
>>> --- a/include/linux/etherdevice.h
>>> +++ b/include/linux/etherdevice.h
>>> @@ -71,6 +71,12 @@ static const u8 eth_reserved_addr_base[ETH_ALEN]
>>> __aligned(2) =
>>>   { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
>>>   #define eth_stp_addr eth_reserved_addr_base
>>>   +static const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligned(2) =
>>> +{ 0x01, 0x00, 0x5e, 0x00, 0x00, 0x00 };
>>> +
>>> +static const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) =
>>> +{ 0x33, 0x33, 0x00, 0x00, 0x00, 0x00 };
>>
>> I see this is applied already, but I don't like static symbols in header
>> files. This will make a local copy of every used symbol each time it's
>> referenced.
>> We usually make such symbols global consts and export them. Could you
>> please send a follow-up?
> 
> I forgot to ask, should this exporting happen in
> include/linux/etherdevice.h?

In etherdevice.h, you do

const u8 eth_ipv4_mcast_addr_base[ETH_ALEN];
const u8 eth_ipv6_mcast_addr_base[ETH_ALEN];

Then, somewhere in, I guess, net/ethernet/eth.c, you do

const u8 eth_ipv4_mcast_addr_base[ETH_ALEN] __aligned(2) = {
	0x01, 0x00, 0x5e, 0x00, 0x00, 0x00
};
EXPORT_SYMBOL(eth_ipv4_mcast_addr_base);

const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) = {
	0x33, 0x33, 0x00, 0x00, 0x00, 0x00
};
EXPORT_SYMBOL(eth_ipv6_mcast_addr_base);

> 
> Best regards,
> Diogo
> 

Thanks,
Olek

