Return-Path: <netdev+bounces-73989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A781185F8E1
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA92D1C24BDE
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FBB133296;
	Thu, 22 Feb 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OucXf9rF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3512FF60
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606418; cv=fail; b=VnFc2avLF7BXuoHJBMDiV95/EGHolE8EGT7AB8kFbUIyPPXls6xaJ2YR0h8jaNisPafX2bNDx3qklkIQ7oqsquBV8iJn7uQrG3QzbT8GkWwn0zqFrtm15amUQCHVaDkxTq1cOiSKk067bCmJe35VHH68MqnnpiyB11S6M+udmuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606418; c=relaxed/simple;
	bh=ZiqE9J1k535QUGU7WNMFbLuTblFnMmJ94tHHUbLTpK8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKVqOJ47TtYWa4s5OHc6maWoKlT2mHgMrkPa75ZBvtkmSHO9B0d7am0dAyn+eotnhLL8FzULaGVoweVaoku3fvzsEAaoBjNrVIkEQH1h0RXD9R2qZ9pTOmY4qvnaHC7hoZWa6D8zl5x7vNkIrSSEbJI1H/veIlehzm/7n3HsGC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OucXf9rF; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708606417; x=1740142417;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZiqE9J1k535QUGU7WNMFbLuTblFnMmJ94tHHUbLTpK8=;
  b=OucXf9rFVuSJG5gbt9E7Js0OMQQNTSgtRXeoUtOOrlnGPx95CwiVeMLD
   DSO9TNIQMgEhcYlgLa/SIK3wXXJAiwQSbxQx+0zMyo05Xz+uHsAIxnmRd
   1fWnNBUUP4LFkyZ+xWNyNXdgnx137kxRzQJjud/fr7JdDmVkkhUBO62zM
   YYSkERDLIYs+5o1VLWolt8/b3rinBi1pjYvTGLcfA/qSouS7F60A6Vrfc
   rcfR95zbaU+IilZj5yWN1XObgwbm+yQpLSHFIoQV4LyXqySkN8zYUTxac
   ZzapOdzjGjeo9doSTXTR5vhY1sh6S3wYwTqdM7CGEPgebo4CZNzaScuW1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13449231"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13449231"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:53:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10176942"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 04:53:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 04:53:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 04:53:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 04:53:32 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 04:53:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U11eSki9XYvjqJZPDKyDokx7na/DFRR1blji4Tdo2VJHzgFtZ2rABPbD93jqNQxT7ovBnR/GOsmMuVusa+NPa5qTaTvgqHCExgHhwJHwS3HE2CLtTofMZbPkznY7m3g+jEXqQ475SGbmg9EPVQOEv8Qc2xoE7s2Xgi3AXev3dfcdvkNg/pNSATzAfSpsMh0/DuGs7T4ygJ/a4Ajzms369zPGVNIQAMQLoatZ8t0SVlUywSLlGxi0EVMPezrj57iiwPYeFUuHP381WuLlVvkq6rr771GfhjAuIBiLX2TVJke4fOeu3SEpxJdUVKBj4jSiaXevMyDMm621NUtEnXf+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3buo8J41DSx7ievSuuT1RmN/i738gRox/knXOZlAIc=;
 b=HrUdcGUiI4aBB6FSBnx4FNZoV4Se4V2ipWG4RtSey0zUPn0ZgG78Kc1MYG6nK2z8UdiWbkIEXXR02OjMXHLGOfq0Ab8Rr/nvz6DW6Y8qvXkX4Nl6g9zGA2a6Ubykyn8B1tIV1hRoTbOGPUBLZl5DIeFnc0yPIrE5CveKSmJXYTm/cidTbqi7hKi6gPvHLTzgbnqxb9+GW1hgHMYfQ/m6Qa/b4io/e3Mn7x7L62MooKfws2VCo2bjQMwVEd9qSSfZ1LLt4Y3MD3UTf635JgV0wtDD7l/STubNFnnJ7EVMDvB9stfypO2gMZskNgwa78rkIJt6O52QuVrNGYnaVxSSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB6352.namprd11.prod.outlook.com (2603:10b6:8:cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.21; Thu, 22 Feb 2024 12:53:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2%5]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 12:53:29 +0000
Message-ID: <7baaefa1-cd27-4dc7-aa2d-946aa4d225e7@intel.com>
Date: Thu, 22 Feb 2024 13:53:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10 iwl-next] idpf: implement virtchnl transaction
 manager
Content-Language: en-US
To: Alan Brady <alan.brady@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Igor Bagnucki
	<igor.bagnucki@intel.com>, Joshua Hay <joshua.a.hay@intel.com>
References: <20240221004949.2561972-1-alan.brady@intel.com>
 <20240221004949.2561972-2-alan.brady@intel.com>
 <369a78cd-a8ed-49ea-9f89-20fea77cc922@intel.com>
 <52fa2a08-b39d-4ffe-80da-c9a71009a652@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <52fa2a08-b39d-4ffe-80da-c9a71009a652@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cee4d6-5fd8-43e3-31ef-08dc33a54497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6Yr39hYq2s1nfc/gGU18Qi4O9QKZiDJY/wHpOm5eubjZtO5ispt0RmDQfG0HiMe9g2qrAVve3tmq6vpTyLSPHrpSRbo2LW+DKWF5nM5uycOvfZSJ9NIIQeyGhwYJRP4V+rlSxct70LPHekaPz5k0VMhI4zota8rrOgqUAQ7X3dTMf/uPByzB5FEvebp53+UJC1vo59vnN2DBQFUuNq+3/SxFqewHcMlC1u6tH6x5HV1TN0oMde+ZPFDOUOvQ8HE98pBPrQ4Hb2oQr4Lb90reYQ3Wizayu226qEol4d/XdOjeXhvqUJ37PAob5axlx2Brq0cZEewNgVnB4PKToLPIMTp+EdAs6ydUXJS/MhbzwWvHXRKAhU6HjDY2851gtmRCLozMPfSdf6hP2Nuzae9EtbvmO399ydKDNUHGsbKyAajrFIIW2xwYZsjRk0eOe/GqIo276TDOTidc0OWsnZT7fQvLC+jI+2UmYwqiwbuo25igwOkY3fGekSxbfB2I61738u5mUyAzpTeC6ceTFTThGGN9N6/OQZTVBcB/QNjiSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUlsQ3QyaTJZYUZITzFHR1QyVXp2Vkl5dStBSyt2ZDRWYms5YlRLeTNzTnFs?=
 =?utf-8?B?WUhkN3BQdXcwNHZwNVBmdDcxZkhjRGpMWDB0OVBCc3lYbFVUNUw2TVlwallN?=
 =?utf-8?B?c2lENjJLZTBDd1dGbStuN1RoM3hDZDFGNW8wNXU1L1F0RGRlRUNkL0E1QjQ3?=
 =?utf-8?B?YXd0dFd0ZGhTbVBhK08zVGpBVFpIc003V002M1htRUhDc05XSVYyTnZkdjdy?=
 =?utf-8?B?V0ZWbDFsaGhiY1BuYzlSOTExZlVCQ1lISlBPOWRBdFA2c1pPYjdzRGcrTTJB?=
 =?utf-8?B?WTJSMmg5NXc0a0gwd0JyVEFZdkVienN3Qkd2TENHVTZ1RE52WkpmdGlseGNN?=
 =?utf-8?B?Uk01QjQ2SWlqT2U5VWdma0p5ZUhFajVUTG43UVpaZlkwNDZGUzB0TkxQdVV3?=
 =?utf-8?B?REhGcC9MNW9UdzgzSWpLTTFiU21iZ0NyS1B5Skt4UnY4bXR3bkorRWx3OHdt?=
 =?utf-8?B?SlVwNERhSXZXK2I2VFR6d05EOU9TSXpUeTZsTG8ybXRuOEVEeEtOSGNDTFQ0?=
 =?utf-8?B?Y3ZRdXBnZXZaL0lwSytvMkRIOEpwVXNLTWQ5QlBVWFo4NHNGaENjM3hqNmVZ?=
 =?utf-8?B?RWZ5bFhnNHMycGVvZXdYV0lCbnA0Qi9VSUNXVy81M21NNENrbm8wZGpKL0ZQ?=
 =?utf-8?B?QzVveERuZzU4REN3MXVVUmpHR3FSVUlqazJKWlkvL3NqdHBWbGp0RnF5VkFt?=
 =?utf-8?B?ajVFbDdWMW1CTWlwR0ZFU04wc2ZPUFAyaEJiME96Rk45Y2tPVk1SMWtEUkRQ?=
 =?utf-8?B?U2x6aStJOXc5K1lHUTNURU9kWW05SDJnNWdQVWZkZVJYcS9lcm1OQXVrTVlF?=
 =?utf-8?B?RGZ0V2JVN0J0cnpXVWtPQys4bDlYL3phRnp2NW5YZnZoM2lQQU5LalNUL3ov?=
 =?utf-8?B?eUtDRkJGVzhrNzFDN0xLdit3bnFMR0o3YWczcFNSS25rNG1iTmEvcFpGdUlI?=
 =?utf-8?B?amoza1MvREFRdmhpaXREZ3JpbXptNklnQTFMbEEraGgzTnIyU09CeWdHanUv?=
 =?utf-8?B?YjZlVzNQQk9jWk5UWGhreFhmTlo1bVRMcjBvM0FkWWRQS0g0UDRFS0dQeXdj?=
 =?utf-8?B?a2tIczc4Wno2WmdyKzMzMnk3QUEwZWVoNXJYSGJ3ZWhKWnB6bE82R0ZRdWha?=
 =?utf-8?B?NSt2cUhZbWkwVmF2R1IzZitSL1RnWDNGRGl0d3ArM3VjK0JWR21YaWlZVG85?=
 =?utf-8?B?MDJ5aTdFd2xBRUI4TXFyNUxQVUpKY1hnekV2b0dwM3ZaWkFnM0R0K2tvS3o2?=
 =?utf-8?B?VUhBMFc2Rkp6Q1Z0ZTg5b042QkhuVmNpVCsyZ0hrcHdCY1N2czA0TkNIeC91?=
 =?utf-8?B?eUFqWXB1Qy9DTm40RzJDY2dmWFpCS3FTWTNhY3FFR3pKVlNZN3VGdk91VjVH?=
 =?utf-8?B?Z0hjd2MzVk8va3pCNVZzeUViNXdjeWV0OTR4eG9keUN5aEExdTJlaXFoc2Nn?=
 =?utf-8?B?SmZtaDhaaWpXZHpsTnppSWdhSE5IMzZxUUdxdm9mUCtXYlpqTWVhb21wdzVh?=
 =?utf-8?B?S0g4NWFMbHp1R0Y5Y2xtV0xaaDdYMW8rQ01MWTA2VHlMcFFwWlNUMXZ2TU5N?=
 =?utf-8?B?ZHg2OVUwR2dGYkkzdWxoYkE5UXF1RjkrK1g1QXlMN2NHVlRJdW1UcFhIUmZP?=
 =?utf-8?B?YVVkUlRmME5saEFZcWhDMHNKenpvOEprS1hRQ0NNZnVDNWxjSzF6NXM1MDRM?=
 =?utf-8?B?UjdQeXJJUkVIYWxiaFFwYzRva2pMUVBkdm5aOGw2TVVneWJZaGRxWFVjK1Bo?=
 =?utf-8?B?c0F6QS9jeFpxOTlQREg0NHRpbjFWNG9xNGIxaHFwOWVaWWVWMGpoMTE1UEFZ?=
 =?utf-8?B?ZWVjaVFMZURQWjhtSEZMNnZRcEpnWUNjeUNsRHhqamhIanZsdzBjOE9Jdngw?=
 =?utf-8?B?UkFLR2c0eDJaaG42NkFWeFFOSmtMMndDZFdkL0xLUzEzaUhqcVpFYVJnK3dp?=
 =?utf-8?B?QnJqOHlUcFFzR2RMRURIWHpkWk9DWWk1d2tnTkdySTBMc2U3OE40aGwwV1ow?=
 =?utf-8?B?Sk9ndzNVLy9UczA4Qkt6OVVORlYxajRLS3V2d1kyaGRzS0p2ZVc5UDFEaTBU?=
 =?utf-8?B?S3RIU3J0V2lkcWdoemQrK3c0VFM1K0VzaUF1cTJ3YXh2OTJUMjhBUGU0Yzcv?=
 =?utf-8?B?TUhuQTBhanFyeEhJN0xwNTM5Wmh3ZXNQYndYR083RGQ0NnJNSG42ZjNkQXJE?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cee4d6-5fd8-43e3-31ef-08dc33a54497
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 12:53:29.5524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KtxdIYvhFAUrAqHo5a8L4bIztUngfpeu05mbTY7hdH1ONU2Yv1FQ3PvGIV7TFyvXPhfnLxq//aFBzb+Ot3VyVbjuh+75QL4oVONipr/PkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6352
X-OriginatorOrg: intel.com

From: Alan Brady <alan.brady@intel.com>
Date: Wed, 21 Feb 2024 12:16:37 -0800

> On 2/21/2024 4:15 AM, Alexander Lobakin wrote:
>> From: Alan Brady <alan.brady@intel.com>
>> Date: Tue, 20 Feb 2024 16:49:40 -0800
>>
>>> This starts refactoring how virtchnl messages are handled by adding a
>>> transaction manager (idpf_vc_xn_manager).

[...]

>>
>> Sorry for not noticing this before, but this struct can be local to
>> idpf_virtchnl.c.
>>
> 
> Nice catch, I can definitely move this. I'm also considering though, all
> of these structs I'm adding here are better suited in idpf_virtchnl.c
> all together. I think the main thing preventing that is the
> idpf_vc_xn_manager field in idpf_adapter. Would it be overkill to make
> the field in idpf_adapter a pointer so I can forward declare and kalloc
> it? I think I can then move everything to idpf_virtchnl.c. Or do you see
> a better alternative? Or is it not worth the effort? Thanks!

Since it's not hotpath, you can make it a pointer and move everything to
virtchnl.c, sounds nice.

> 
>>> +
>>> +/**
>>> + * struct idpf_vc_xn_manager - Manager for tracking transactions
>>> + * @ring: backing and lookup for transactions
>>> + * @free_xn_bm: bitmap for free transactions
>>> + * @xn_bm_lock: make bitmap access synchronous where necessary
>>> + * @salt: used to make cookie unique every message
>>> + */
>>
>> [...]

Thanks,
Olek
 

