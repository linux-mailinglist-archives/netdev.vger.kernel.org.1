Return-Path: <netdev+bounces-88269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AD98A6830
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF5F1F21B7C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC3D127B50;
	Tue, 16 Apr 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLZyUnbE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A91272BA
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262864; cv=fail; b=NR3VKUOK3NjisiOJ7HSxexI0ALPv+zKrAukTjz2U+iTAB7SxWdEE1snAN/txSdPF3iiyTTYPkKWGcxTKxGYGSEMimiTqWr/bi+9lHW52bIojNdKsrEMMMCWBWD+22kYlqnwstFADjIBtzzzYIOQv+hIrsiyRvoGjWlNnwR178Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262864; c=relaxed/simple;
	bh=b2sQWsLQ7ew9Nmm6Om4Ix0gdLuM1cyQpmyU2EWYB+EE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MfUpg3m0FQ4ElFVSkaIu4FjIgqfPUPdI82e+jasB1iXFU331QY0gpyht2b3Fk45bocxK04Y+IS9NuoUR3EO0I79p6UwF7CL73TaOXJdyfHh3s4f209r0/6WEhVX9KT3Kzob9+ILBXo9aAw3f7g4gOPq4RA6NHJAJA1UQYtO0qx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLZyUnbE; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713262863; x=1744798863;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b2sQWsLQ7ew9Nmm6Om4Ix0gdLuM1cyQpmyU2EWYB+EE=;
  b=cLZyUnbEG+V6/RZwbVEjqMYG+0GNKLTjvERCjcz70RQORfp02Xz6grHC
   KIlIznQpRZa/zLcHkaMULZ31sldlbyBF8eqRorMCTJFB2VnaovOdsGlRC
   BzZqG9jQHDcq+yOPSPs8ha2aXwuvZmcLg6Jaqyk7FVb6xp+EqDlsO1MlZ
   hAkiPmCmAVLzmjuluSxJEoaLX8EFN9BcGRTmm5J7IlfoFs5zko0PTlKP0
   KD4cWUkrqjrD1MseNBWsVDu3A43xsIl9kUOmZM5WyoWoz7UKn6txjDLna
   6X0+5w9b6xn8noluA86huYS13kLVAG1At6yUHVjB4D1aUKbw2mfB2Ipz2
   Q==;
X-CSE-ConnectionGUID: tyeaSJUQSQmnt01ylGbQ7Q==
X-CSE-MsgGUID: HACPWdtVQjKQeZHGBRKfsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12468876"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12468876"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:21:02 -0700
X-CSE-ConnectionGUID: 5fqum49/RJKXtocy8W7e7A==
X-CSE-MsgGUID: f2kf1xmnTaa3jc9m94N65Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22696264"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 03:21:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 03:21:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 03:21:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 03:21:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 03:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7XszVnwVq7Sdtv5D7TQqMcF3OPnutWz/UzEkFGY6Ar/7Ug/L80pTFsY43+Edy8o8fm7Tb8fCOTf/xlqFCLz40c8Y0vqif95vaPT2q4Cx6AwKl/5vXEmNn9/PG118yvNDaxjRX0oc6ntajGynY13YN62Y60uTurDWaK/xa2CjEZtG6Tx+GlzvKVlOQRfwrR4UAGbG+My392xTp7505SkI/N8ue32YZxltydQqK/7vvyijZnlDVKTAS/BfvLa4ePAhRKaofAgzwZBGqHjC+qtav5rUxsTl1egz52YGP8R9lZOBV74r2fmIcD/Z/p10oC/Ej6ZxboC6NHOxqkoLKXrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhXCRYPcrae0eHsdvG+doUDclzxPudWlDjgiL11Is9o=;
 b=Hq6YZjL8dZ5ioqOgG/75QdmCrKj0ZG3l070Rh4dr7y44Qa3brqNGDaRpXvG5mTU1OofdlzNPHREedzTHq8K2bIbXOX+VCx+VvKNtMwx0wdXuzUhZV054bHSY7JjiLu9saWwz26zhM6DeDdfllkjS12XCsVdgrBJqs6GIa10ibRWnqMSVSC81d8luS5wJZ7URdA+/1EPw8MHKBr1bZOLKfXKjr3W844XKR5BrH7MIrYB/RaSmQMgIS31CVwKi02yATslUFwxz23NTHQTj3OH+opwgsy1jf8p+IK9vou/2RwjFYsXKEqC6h3gnfzhJ/gMEQvl7gin+8JBUqYxW98uAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Tue, 16 Apr
 2024 10:20:59 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665%4]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 10:20:59 +0000
Message-ID: <7d57d275-b58b-4b88-9436-863b5770cee8@intel.com>
Date: Tue, 16 Apr 2024 12:20:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 2/2] f_flower: implement pfcp opts
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, <dsahern@gmail.com>
References: <20240415125000.12846-1-wojciech.drewek@intel.com>
 <20240415125000.12846-3-wojciech.drewek@intel.com>
 <20240415145238.0f5286a3@hermes.local>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240415145238.0f5286a3@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::17) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|IA0PR11MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c114a4-2e82-4369-32c7-08dc5dfee8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VUfgj2H1VfLhDprm85S0HvMhf866xzvGFWEtFjEKncMwLvGfe/RYEBR1Nxglw8KotQcJKJwO94aHDLwdtdxggQM9L++ZVBsPkiXkhr8xpPf1LRsyBrPpGEDSD2lcn9/JueKip04/NQpZ0xADogh7+CCgTag7tSvUVoUT/SFtLjrmDKdMbj0BvWAXuDucx0240gq7dzh5+Mf5FNjSlLxay60Wv/M1Pr9m1ACMXfVd+yIQsgNs2jlw5mRhfnAmzo6n+E564eiFG3TlXJChCpudL3OXR2SC9rUS9zolFGgw0gEA/ye8hsp10QK0hJ2Xq5grYhYi/Kf9AlWseCeruE5hMtErwCfFZaIyTFUosQQ1twLQZ60obeVa0HNzAxk1xVenghmgwSdngIpGGw9PbOIWDYIwN0RMF54uBxMxQp5SD5yVxtl3AyixccEsEg0dHhYz/LXKwQNLuerLCPXleq4Z1Unr7wLGb2rdTwXWRWkBbU43C7gItTvF4wXrXoTHMW2pyTVvwYhBiL6lIpqlZnlrH5/XCYbR8d35v/hzwU0NMvuawL8HXYjFdKL6RA5oatGY1QbFu0ILqIk9VXtVVkuJ/SaCFW4fqMjkCvPQhdRyuG2zHNEV8/RFArGHVqWYuU2aXesePz80BHal2c73U+6BpvxqD0vjhBzzIADBDkoAeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWp5MlRUamJwYm90UXg1ZHFmdXRTUUVDYU5nbXZZS0pRMUJSbGJaQXdoVEZI?=
 =?utf-8?B?aVRGNC9ENFo3VTB0N0trSDRqQ0tLNm1WUmpBL0Rtc3NVNSsxQmdsMnE5RUk1?=
 =?utf-8?B?S2tSTXVDY1lHNmQ2Y2pkbW9aNEdhNDZYYWVMSUJEWGxSWmVoZGY1TEdaOGl6?=
 =?utf-8?B?VUpMb2JPNW5qc0s4RXYrZkFpREppSHZmRDFnaHcxVklscExvc2pabkF0THBS?=
 =?utf-8?B?dU50WXQvS3NURTkwWmE2Uzk1QkZza3RjcllFYjI2d1ZTN2R1NjJzLzlTQU5B?=
 =?utf-8?B?d01WVzM5WFdoNGhGb2JlVUxmK000Uk1YTmYwSXQvOWVKbjEydjZKUlc0blZ3?=
 =?utf-8?B?WVNtc01kUk91ZjlWZVJBZVZrVE5nT2hNWHJtSVZTRzYrZVpYR1hUc1Z3dmJw?=
 =?utf-8?B?b3FoRGZyOGo4M2dweW5va3RzaTR5eC91d2xUNjVubEd4alJibjk0a2VjTnRX?=
 =?utf-8?B?QVBDZTNJRUdCS3R4LzZlSVlFWGFhVTRZaEd1MmE3QmlSY2duQmRjbXNnQWwz?=
 =?utf-8?B?OGk5Z0tXWE5zQ0F3L2xlWFVYYkNISUxoRG1zTnJYZVI3d3Bxa0Uvb1FVcDc3?=
 =?utf-8?B?YmNUMFBoUzdJMk1iV085ME9WOGNVenBDTEtqK0NkTTNwOU9TS1JPbGhha3pP?=
 =?utf-8?B?aDYvMW81MnpsZEVaNGRRMUJUdFMrL0JXK1dWeGUybG1CUG9vVUpBWDEvcFNt?=
 =?utf-8?B?RUlzaGlSdjJndmFNV0hKM0hWZ2FHL2U4M1FabzNrQ1pqK1JEaU4vSHgvQzdJ?=
 =?utf-8?B?bmQzNVcyZEg2Zi9MWldxREFkSTB2QUFvN1FYY3N3T2JQTEdaWkxpUlAzcG5x?=
 =?utf-8?B?R1JIMy9BeWVQcDZHUXdnTUhTaFl2blZpaUI0bmp2NlJydTZuanRja0FKUmlw?=
 =?utf-8?B?R2NDRlhJcVZNcXl5ZG16QUFmMFJ0eDVJMkczakZlbTJEZVJ6OEFtQ2dSbTJv?=
 =?utf-8?B?Vjk5QUlzTGtibnBDTm41SVlZV2JvZEVPcGJaeXp3L08rWHVyUE5RRVIxS29J?=
 =?utf-8?B?RTFTQjM1cHdDUmZJWVpPcVBCMGRSdUJBN0Z0RWdYai9OK0xxVXYwUTVRSkJJ?=
 =?utf-8?B?UlQ2TEpJVHU2SW9TMUo5a3JTN1dDWXgrdjQ5dEhNY1MxU0tObERod1pjU3Jl?=
 =?utf-8?B?V1MwcnZCdi9rd0tUMm9EZ1FBV0xsL3crOWN3ZGhZcVhKL2FtYUNGRkNkMEFU?=
 =?utf-8?B?eUxFYng2bUsvUzNrUXRKbFN1d0dvRkNrVmo1cit0WUhqdWVqOGVkQ3RYODhV?=
 =?utf-8?B?ZkVNaG1aUWRkaUpSMG9YVDhtclkrNjZHUk94MHZPRjBCNnZlZmlZVHAvTUlX?=
 =?utf-8?B?bEl2MWdyTEF3QUx0MWUzSWlpNjd4TWYwc3ljdFpNaFZYU3A1U2prRHZjMjhB?=
 =?utf-8?B?V2hEd1FacXEwRFFhQm9hVTB6MUxZcitNTlZLUWplbFEwNlZRbjBnem1yMFNI?=
 =?utf-8?B?dElRckI3WldSKzRiRVpmZTQvZUZyM05VNGtkU1I0a2lMTFo5RG03VEtmMEpV?=
 =?utf-8?B?S0g3THRRdHZ2SlgvZXFzYzVIeDVRdTE5bTdrakdEM3VqSTdTV3UwSXUwVkRZ?=
 =?utf-8?B?dzdGSDRRQUZkTmREK1RLeEVqamtvSlZBWkJBdStHOTh4d1N0dW5WTDBYQ1oy?=
 =?utf-8?B?TVlLOWY3M0M4UDd1RmVmWTR2ZE5qbnJ2eGhRblFUcjFsclFZSWpIa0diYjVY?=
 =?utf-8?B?UUZ5bWhvU0c5ODlHa2JFbmFIUXVVaHRHdHB2cmxnQjFtOFRvYnNJNHYwdlFT?=
 =?utf-8?B?Z0FWa3gyR0IzenFCLzVuM3pwL1dTMkVnVjhDQW40bisrMlJnenJUOW1ueUtG?=
 =?utf-8?B?YVg4RWRrcVNIaGlobGVadGlqbVJuNkRKbDVtTVBScnc4S2RTVWxzLzNsNTZ0?=
 =?utf-8?B?c0JVMjVZZnJWQjNsdzhFUm5hOTVLWnA4bUFEdk13WFBGaVBoMlRpbzZoSjVx?=
 =?utf-8?B?Y1ExTnM5SEhzMEgzM29Qd3RpdHBMNDdxWmlCVmlIWHI5TkZVUXFUd1ovT3Ey?=
 =?utf-8?B?c3VkNzlnYUJ4MWpiVW9zSHZ3ZXhZVVZsUWUxbHA0dlV1bXE5eHVXS2pHdzll?=
 =?utf-8?B?WURFSjZzRGRjNXFTTUFPT25HLzFONFlaekRySFN0Sk5nRzk2cEEySjJBblVm?=
 =?utf-8?B?WXduRlBCaTVHQS9rQ0gyU0pQNmVkdW9SaXZXREdrWUhSSjM1S2hFclY5WHY4?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c114a4-2e82-4369-32c7-08dc5dfee8b8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:20:58.9581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfDYNiTTyeSKrlmxWAK0cYT3oanAOJEAQWBvY2MZmiDw6IR8odQX8Xr+ggFhKw85IBOCCEEWDw7oo9uAq3KoQ0Ld6K0ju4Hj/c9XatAASek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com



On 15.04.2024 23:52, Stephen Hemminger wrote:
> On Mon, 15 Apr 2024 14:50:00 +0200
> Wojciech Drewek <wojciech.drewek@intel.com> wrote:
> 
>> 	} else if (key_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP]) {
>> +		flower_print_pfcp_opts("pfcp_opt_key",
>> +				key_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP],
>> +				key, len);
>> +
>> +		if (msk_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP])
>> +			flower_print_pfcp_opts("pfcp_opt_mask",
>> +				msk_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP],
>> +				msk, len);
>> +
>> +		flower_print_enc_parts(name, "  pfcp_opts %s", attr, key,
>> +				       msk);
>>  	}
> 
> I find the output with pfcp_opt_key and pfcp_opt_mask encoded as hex,
> awkward when JSON.

But we don't support JSON output for pfcp_opts.
Do you want me to implement it?

> 
> The JSON output would be more logical as something like:
> 
> 	"pfcp" : {
> 		"mask": {
> 			"type": 0x0000,
> 			"seid": 0x1,
> 		},
> 		"key": {
> 			"type": 0x10,
> 			"seid": 0x11,
> 		}
> 	}
> 
> 

