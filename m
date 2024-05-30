Return-Path: <netdev+bounces-99524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E6A8D51F0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFEB2274C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1994DA1B;
	Thu, 30 May 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfS08WZy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129EC4DA09;
	Thu, 30 May 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094641; cv=fail; b=fd103MdsaLgLk420bzHtUMge0wpLT4ocdW7ZQx2B7FEC7bngYeQVAMnVbhHIf30Pl12ZmYc/qAKQ5e5C39welbs/ooepgkHrfnmNvQuKbAwd3/9oSfuZlzgB2ZjfTThHtIXLxTQ4bl7MI+W330/3at4Itvdr7yflMpUbkbQeUd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094641; c=relaxed/simple;
	bh=kylx1T53d0deV2JEbO2CkREU/5gdaT+DfuRmeq06okE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HSzFMCiaKFL42oJUW9gW7ImbouPsgG3fzIjJgBYTOLP4GXMCFClJC5n+Mz4KSuUYXfenyHub9RIEwRW8yUEgSe+EQLR75RTnFy4Ep2fh9gvps07TrmRPTcqZG8Qpj/ULBzcXN6zVXJiD6eD6bG2z7wUOyVivp2vpQtYXb+Da5Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfS08WZy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717094640; x=1748630640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kylx1T53d0deV2JEbO2CkREU/5gdaT+DfuRmeq06okE=;
  b=UfS08WZy+z47xtfxshmRjh3Ki4/Ao9aAglYqyQGZTKcLI+V+rOE11s5M
   Dii/w2v6gSyeh3EginOOqb86tQY2vnT2DSXkYG8bh/xsvf2Ij09LBld+Q
   85mQ8LzOsuIS0FZ2P1/cu8L4vhoP8TWUPio8uW40Wemg0Yj4ruFb7lkrN
   Pp30vhGAXlOcHOXB7n4TUqwJbu2Odz4+8+jqRolqcgZvbhFi134J5gnte
   hMczztOb0wPVAnT5/7TWOAJw0UWxWSPrZcI2pXX4bVlYPzWuQoxG5PO/r
   qKDpYcLrg4re3XX+2Z5J6pnJwrJ+2PHMa2UnDNwZPc0Q1aVYrL/DzK2XJ
   Q==;
X-CSE-ConnectionGUID: quI22PjHRS6L2mESRAiMJA==
X-CSE-MsgGUID: DiC71C6hR6WIl0OGw5/8dA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13737167"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13737167"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:44:00 -0700
X-CSE-ConnectionGUID: Uue5JLbbRqmwORwxSyzynA==
X-CSE-MsgGUID: HfBxAKYZQpCuTy0f8I4LDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="67098848"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 11:43:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:43:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:43:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 11:43:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:43:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru8cuw4wxMu3P7WbXq0KIR7wHNxmMaq9DOnKwjyh2NcCfWCo2yftPIaRP25mc98EUfJDnNs1Ld2U+1RZBkJIytf2kL9AavAP4K4tF/K6j1I3cc3dtL2rDCXEfwJamR4TsXe1FzyFt+G8sytzgcW0t/Y2+gNaYGjp0OHS1iJoEM1suvn3P/oY5gkXnvOjfw1SOjxJ77GtyG16ELJ7OCcymFbxx1d6rlFoS5f+TDtwcs/x2er5KIyXp282t614KgPQ1+uVu0hxoYSFD0zZ6frYRt0MrFilhKkJJALxIggsGNqvYf0NOSZYwU3DBw7G2KgSjtCQoxllTonFSDxip5CC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcQltVI0f7KBbulZnFrkYXZklKvJURUHr3lUTw0YiSQ=;
 b=TAcGaQzl4nfNE6/GsOGV1RAni6j70kCmalhysyMehW8UuGgsjjDEKdE3n3PIb7WXDLGBmF5FDQ5CkoqOirDZ5/vTsVzOUYRtUy1FFHHCO+Bh6w1thnwcopFuD59/JgbP6eMqeDaxJmbAU14k1l3EOJS8XcjnC4igtpAVQz/MVLj47h/DOXRzukW/IMoErGT1NIkIEp3dN8ednilNSMSICmEwhKQD67prGOKlAvwcnItlDACohC0yf5aZBZdYwOz86BTovLzf0XqoDdVxf48q8d6jSaeqIVlKdVJlPqvLoDqF6x19GshjlDKkUgIUPCGjKQ0HxVvs94YGJBNZqqwG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 18:43:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:43:53 +0000
Message-ID: <e85ca965-9f52-4c03-8e9e-09677cb7cddb@intel.com>
Date: Thu, 30 May 2024 11:43:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: ti: icss-iep: Enable compare events
To: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jan
 Kiszka" <jan.kiszka@siemens.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
 <20240529-iep-v1-2-7273c07592d3@siemens.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240529-iep-v1-2-7273c07592d3@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0390.namprd04.prod.outlook.com
 (2603:10b6:303:81::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e6ee7c-2ebb-4dc8-1d6b-08dc80d8742b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1JyMU9QSy9vdEd4cWZrbE41RTRLNDd1WnN6VjBucW1nck4yWEdqSlorK3BD?=
 =?utf-8?B?ZGhLcTdpWEw4N0xmM1FkeDBiWHZONFNURFZtTWZPR24veUtKUHVISm03Sk5y?=
 =?utf-8?B?d3ViOVVkSFhiT1J6T2l1bnNpUVlQR2YrWWV3NXVQSFE1cFBEZDNXWEROSFFh?=
 =?utf-8?B?bU5wRjJ6bldRNDRjMmZsQVFZamxRNXlCeHhoL2l3RktjRkN1ME9vWHBmSERG?=
 =?utf-8?B?QWlscjA1ZEdObmdJaUNlQWpObHdJM0laSW1nY0V5UFNURDV2LzBGL2NQcndR?=
 =?utf-8?B?TWVMeFZTbkVKOUNJc1g4ZGdLOStQTVowcEdrWmlaOFBLeVFjdnpwM1A5ZVFy?=
 =?utf-8?B?cm1lRDB4VHB6WklRQlJ3ckRidmxTVUpRUkczMzRyQkdwdUZWWDBtalRtM2Vz?=
 =?utf-8?B?MHZqL0hzRTRjQmQ2NzVUWWl1cTA5ODNWQ0ZvZTdvVk85dFRqVFZMRDNWK0d0?=
 =?utf-8?B?enZMU3VMY200ditvTWsxR1BvWmtsaTZMaU13ZGR3eHVCRks1Q1dOOFFFYWZy?=
 =?utf-8?B?cmlocWRSdHpIa0RzWjJGZWg3N3ZGNGE5c2k3d2x1VUg2eWxsVEJLd2FwMlFl?=
 =?utf-8?B?UzNhcUFHb0RscWpJcGZtUU9vR2Noci92Q05OcEEyWXlQNm11cUxrMDd3bU5C?=
 =?utf-8?B?Q25oQXF2eDJiZmFwcmJyd1hVWGZmRWhzZFhuU3JHN3h5QWp3SDA0RHJzZXpZ?=
 =?utf-8?B?ajJtbkkxanNMNEZZRHYzKytDZlhEKzcwRy9oM0VSWXVHY0lldjc3QlJZZEpO?=
 =?utf-8?B?d3ZIcWNhc09oMnlicFBlSHFxejM2UHNGK2Rhc0gwaXdvQTNVblJKa3BkTGlO?=
 =?utf-8?B?enVlam05K3RtZXQ2YmxJN3Y4b3FrMTdReVVsZEJCMTc3aHBHcHNYWVpNdUNO?=
 =?utf-8?B?WktLZ1NHODhHK2cyRnZUd3NmbFZDN3R1NEMvK1hLOVFPdmlpVWJHcmI0Q3VO?=
 =?utf-8?B?REhCMVR3ZXhBREwzYVVxZDAyVS9CclZMRzU5ZnNTTmtiVldaVElDOHF5YkU4?=
 =?utf-8?B?cktHR2x3NkxvM2ozbTNPZ3Z2OElzV3o5UHZEb1ljMjQxNHRWN0pFSE5CZi9D?=
 =?utf-8?B?RnlhbHJqMEVRWDhkK3RGdVBwRllsNC9IblZLUWo2WFRtTnJCUVhvSXYvRy9X?=
 =?utf-8?B?dGdlVXU4b3lsSFlyUG9wVEk0VGRESFBRcFRuQzd1elp2Z29RT2JXWXh4ajJZ?=
 =?utf-8?B?SklTWXkvSnhlUktldXUvTGwyMzNmRDc1N21HYTRWdVFzYSt1SE0vNGFROUt2?=
 =?utf-8?B?bkFtQXhrLzBjVWsrVnFyZEJTTW5oa3Bhb21iZHJoRUxIVG94dW9rMGYvRThz?=
 =?utf-8?B?VVpNdEtVSEZDcUNIT3pSQmFJN0RkMlp6T0RuNS9TZ2ZrczM4REgvbHhCSmQy?=
 =?utf-8?B?U1BHL0kyMXFMWlcvcnRDeTQrRnRtTXRjSTZXRUplV2FuZnA0YlJ0ZHgrQmM3?=
 =?utf-8?B?UUxGTXphdGFDZ1Y4eGNsZlFPY1RTUlA5ZnhmejZkRzJReXVvOVZyaDRqVTQ4?=
 =?utf-8?B?cXhyWmNQaVlkblBtTnJJMW9FZGtVSityRlpBTXJldGlnMWE0ZEJvbDF3OXZo?=
 =?utf-8?B?M0prMGpSMnNJUmVJbXE0WDE4RExGUnpRRFFYWWFQWEpTRTBEYmx4K2VqRkND?=
 =?utf-8?B?ZW1WUXpFZVRtYnRUcjJmUHp0S1lkMUpXZlhvUmFzYkgxVEZlRGpLbmR3WERv?=
 =?utf-8?B?U2lWVkdBSWRxdWlyWVd6eDNBMGpRQ0RjcGtBRWg2cjBqWnUxblMxYjhsSHNR?=
 =?utf-8?Q?I5SwkrtgMehZd2fgMLNPwxLmu1VoYi+Ipf3ai5X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW9ITElNdThlQVVKSmRmL2xZWnlEWW1FL20wdDFna3Rhb1BaYXNBNTRvdGxq?=
 =?utf-8?B?K3Ixc0dkcHlpY0s2VzZ5cG5tZmVXdVhhNnI5VmdPMlFMbEJWd0UyY1hMTFQ4?=
 =?utf-8?B?RmRWSTZoR3cxQlRsMGdpY1dzUndLaDMrR2FNUnc0NThHZDZTeEd5QkJETFpX?=
 =?utf-8?B?MERVWm10dFIrN2dQaWNDd2tLZy9iZDlLSXhIUzFmQXFaNXM0UUo1VWtUNWxu?=
 =?utf-8?B?NkNocW0wd0RObCtObjFLRndpTG9lN3NNekhXR3V3MXFaQ3RIaUFaVTZzUzdk?=
 =?utf-8?B?WUhBY3EzbDBNNStzNDgwN2hQaktOYkNFZ0NWV2pwRmwyNW54M2V4aTk4aDFX?=
 =?utf-8?B?aG1rVmoyaUNZSzBKKzFHVE9FM0lPbFFLeHUwZC9TNXNUVFlJbGMzMU1vNU9t?=
 =?utf-8?B?YmdLU0c1Wm1hSFJNem0rbkl0ZTZudkExcytSSWJjb09kc3Rrd2tKdHJhTnFk?=
 =?utf-8?B?b3lRRzFxejNDSmdDUTluTEQvaVBRWmZwdzgyWExyWGVCbi84Y01xQjY1blgy?=
 =?utf-8?B?aE13ck5qNXZmZmlFWExFVG1zNnRZcFBCUlIrUjFnY3BObG5TdVYvcmMrcVJ6?=
 =?utf-8?B?eitxKzdlN1lDUUNyNHRuWjkya2t2WDM2TzAwMndTcDVzU2pHZXF1M3RteW00?=
 =?utf-8?B?YldDTmpWYUR1YU4ydU5vQkkwVjRHcHRsYnl0L2JZaFNJRUVsU2FNSGNYWmVj?=
 =?utf-8?B?aU9TT2V4ZUs0SGFoaWFMcGtZdjVEdG1EYXByYzhlNCtuTjNhQUF2aWVSbnl0?=
 =?utf-8?B?YVgzSTAzT3dsSU1iQ2ZzelBNMWpYQnpKOURUQzZST21xZmJwTWlGeThZbEJN?=
 =?utf-8?B?ZFZ4V3pGdEVMRmx0NWQvY1U0SUMxRnBTOFNOWWtiOUZnc1FGZVMwU1Z2L1Zl?=
 =?utf-8?B?UDJNVUhCaUE1S1R3RGNZMTNwOWxVV3M0djZTZjlSZGlJWkJkT09UVG9sUmQ2?=
 =?utf-8?B?OE9CckFYdjIrZkFSZXdDS2RpcG53U0tuRHdsZTBlaGdxNUl2eUx2K3JoTG9S?=
 =?utf-8?B?bmN5SytPb0F2dGNpSzBZSU92R2t0ZVVmQUx5K2N3bmlCbVAyMVRuK1JWSnUv?=
 =?utf-8?B?eWl0S2R5QVovVzJQdk9nRTFadkNtZkVxTnNtV1pucVYxdm40MmM4MXVqZVRT?=
 =?utf-8?B?ZUlqaGdJR2haRTNHNW9YM1NqRU56dTFDMDVjV2E0YlIvUldsNVZxcVliUHBl?=
 =?utf-8?B?MFFwQW5FTWdYV3ZzWUFZRWUweVhoK0lEYXhtQXp6cXhCY0t1bTFkOWJRYjZI?=
 =?utf-8?B?bkNLOENrUG1mRVFnd0s1UWlvRFFmQmVHWXR6NW1zN3phM1gwR1E1NjRsczRG?=
 =?utf-8?B?TXFFOGVDaFF4NDFWYWEwRVl3S2xaK3F5WGZGREQrRXBDaTFiTjUwWHUvbmh3?=
 =?utf-8?B?S3BKa0cyNHhSTVVRaTFOdVFuakJseGhRMU1VVnFoV2EycjFxZm0yN2J0V3A0?=
 =?utf-8?B?MG5UdHFEOS9TNFlORTEwWG5mNWdwbmt1ZWVvN04wWXFkQXo4ZVIrS29VOGF4?=
 =?utf-8?B?N1REcVFTSnFLR1c2RVN3Q3ZpSUpWTTBZQzJNWHJQV0YvbGkra1l0eDUxcXRj?=
 =?utf-8?B?NDRnLytUK25XY09qSDdMMkpaVm5hcWZlYUVvaG45MnNmSzBHdEQxbDBiU282?=
 =?utf-8?B?OU5NMXNkS3EyOTJvRXJxaXRzTVlkNElROXRIa3NVTXkxSEp6aFpvL3cxTzNS?=
 =?utf-8?B?Wnk2NFRSajRpNEMzTE54ZVVaWU83aUdGNGlOL0g5bnFjOHZBS0JmYjFoMU9E?=
 =?utf-8?B?Z3NPdTRJREgvUklDalpUK0ZTZ0kvalhCbFczYmduamNyMEpFOGlHL3A3UW5B?=
 =?utf-8?B?L2hBMUVYYVBTcEE3dldyaVVpc3h4Wm9GSzBuU0k0d1hFMXNrZFRUdmFuanBS?=
 =?utf-8?B?UVFaQlFiVElFemNWNkxweDRraTlTemFWdWQ4NFlzNENDaFdyM3U4ajNQVURX?=
 =?utf-8?B?S0VxeUUzbHBPZm8rZFdEbnFKNHphTFZZRThmbldYUi9IOUVQdW1FbVc0ekF3?=
 =?utf-8?B?VnNOcFNpWkp6Y1NMV3NGRk14cU1PR2dTZXFEL2dHYW8rK1EzSE0rVU9NRDZ2?=
 =?utf-8?B?bHpXWGZ6YnQweXhac0VaeWorT3hMWFF2aVMwZmIwdXpGWFRnUmEwajBOa2Fy?=
 =?utf-8?B?RHBPOG5PU2FOOXdxdVcwN0hGTmJER2FBc0tmR0s1YTR2eDJRcmJndDc1MFh4?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e6ee7c-2ebb-4dc8-1d6b-08dc80d8742b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:43:53.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjJtvEuxrC7y7vo08NKC4/6t9YNKVnmsQwKpTQcGcIvntVWFaXsy1mTXGCuKDBwz1H7JAhbUCQNHkGl5588LHNtCbkFtH6LYnW6MF45e9lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com



On 5/29/2024 9:05 AM, Diogo Ivo wrote:
> The IEP module supports compare events, in which a value is written to a
> hardware register and when the IEP counter reaches the written value an
> interrupt is generated. Add handling for this interrupt in order to
> support PPS events.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

