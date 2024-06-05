Return-Path: <netdev+bounces-100857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9536B8FC492
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445C2281CA3
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93FB1922FE;
	Wed,  5 Jun 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UM/wjUsr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4D138C
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572686; cv=fail; b=a3zwsaRchClictujQce8yb5jzQdi2tD063tnWNubT0vCUKsW6zL2DcWNnk/9c1OQ5M/7chQKXZH2TC/is1H1T0bJVf7dAaQXtFJhhLb3+eocbbNEhju4S2Q7k/fM0TP3F5TAgmXi22jS48Ndg1tIgV3VEcA8zkwm4+++755RWCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572686; c=relaxed/simple;
	bh=rQ0XbXCH/SEfE+v3ghVL4dKMZZmBrvrNek4KpjFTUOU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n/K1UoMPKjDmWeQ6gg15xMwk8aVQvvzjnB7B+MjnEqObu6U8w7d0TBhB5jdkSIVur5dl9HzyZJoi93Ic6RD2GtdvErzCzqBY7seB4njUtKHs0Y8rCghfUaKN8QWIuZjQnjYIbYqk6odUOSInVRMd4hDn2abtf2drr5I09s5ZSIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UM/wjUsr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717572685; x=1749108685;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rQ0XbXCH/SEfE+v3ghVL4dKMZZmBrvrNek4KpjFTUOU=;
  b=UM/wjUsrlyP0H4+xZwyogqWibHEUyxerOHuQMX9/UmbA7eyMSey5H8Pb
   rE7sLkCuriNUsED+IleAEnw3lw2EajtOlIA8oEUEM7OVTkBZNm9lp2yAY
   V7Vw9C09YgMRS4O88gA4NtURZzQ1BSFECLDVyefJIueyq6p/qCmWdG0vc
   3Rycvm3byJAMzZhsMRB8GffOFiNhw1YALWQAxoGW9DrSCAKNdd+qtr9AW
   hibbl/5cRqsPWPxFLvvb3z1ebiQbQyA8S1/I+fs0CWdCaKkAF3jOHtp3C
   bEG4bKkil4bhMz7ZYGEo3f/sLL6OAnbtse6d9vYn+fFmn1iZYmJuBIKRv
   Q==;
X-CSE-ConnectionGUID: DOWt2tcHR9KO9R4X5dODLQ==
X-CSE-MsgGUID: kW5AYpsITPuSogsxhNN0FQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25567417"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="25567417"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 00:31:24 -0700
X-CSE-ConnectionGUID: GlwePAAfQ1KFV4TPlTuHAQ==
X-CSE-MsgGUID: FGoWGw0OQqezbOKOYL9EXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="60686250"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 00:31:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 00:31:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 00:31:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 00:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFJATFe9KJ2FZHR4GLbMpSfTrmE3AXeP7v2Y3DcI23NBzs0x3iMxmEm7r8JaXc5J9IJw/j7Q87OarvgsLTVczlatiEkeT1K8DxRDDTXiXiQjtkLs+S6qUUVA+E7f01DQjGv/bwL3w/2tbsDT4yx+5yPS5J3MPSzwt5M/m9nE7vOfVVJFTaIFS+NCg4NFbIs1WtsO7KHnJoFstQj+zzy8+J5gnQ389LhGnofmUfi4tnKVlMEVou9XgHwKnyvCbiZRTbem7Ng+g0drfyBP2Xn/b7xSharqyhCpJ3RDX+0ggoZlBciWNEiVHUVAnbcqANt6yAPVLaVDOV0F+/9UA+k74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znx+sby2An3rR1fJXp+JCLK/W74s+Ns0PcccizKqdG4=;
 b=B8tI3E66FIJjuQnqsj3FU//MX3BMbPc0KNqPRgxGEL7J2KNj/d/s1q0I4F6hZEutGMQIoyQsLIqpt/2sd74FnfqoDAjL4OOj0s5DSmS5cCrORZHL5w8gN2TyG5N6HaNhTRTXR+mQ7Jw4+52A1hRH334Nd6O17lzf5MNwALTfZR6L4zibvZE77e+REW19w88hP1c0UHboWwm+TkuRDhpgEjt7m458UY/bX3W28d+t77itPUO7dU5i0rrrOjs/N0Bo+O+BSUsgWaV+jomX1vE1sVGnTamcnuvTbaqr8rIyfcHx449afyuTXwoOl3ciSZ6fzQG/Ia4EH2KyWx/B9d25AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 07:31:21 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:31:20 +0000
Message-ID: <354d80c7-6255-455f-a295-70de64f7953c@intel.com>
Date: Wed, 5 Jun 2024 09:31:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/6] net: libwx: Add malibox api for wangxun
 pf drivers
To: Mengyuan Lou <mengyuanlou@net-swift.com>, <netdev@vger.kernel.org>
CC: <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>
References: <20240604155850.51983-1-mengyuanlou@net-swift.com>
 <F7B60244A9D27356+20240604155850.51983-2-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <F7B60244A9D27356+20240604155850.51983-2-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::6) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: d524e5b3-ca7c-4f9a-0955-08dc85317eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3JvZFFJNGRqMkVaenV3RG9pRVd2UHBVRTN6ZWJ4eVoxNk02YlkzNzlFelky?=
 =?utf-8?B?ek9QWm41K3liQTAzUTh1UlNwckI4b29nVGhXQ1E1M2tWQVJPOFBIcFlNYlNO?=
 =?utf-8?B?bWtNVlptc2dXSU9zd1M4MUlEUEFYdU0wenFkTmJMTldBelQ4NXRON2FxS2FK?=
 =?utf-8?B?Z1hyRmRyWXYxY2JXVzA1M3FVTzVVNnFGUlZrL1FoSjZ5dlpKVGs3RFByK05H?=
 =?utf-8?B?RTRDV0ZlL0VkS1ZmaWVodUJud3RYNVlGV2JiaGlhUFY1V2grZGNWSzM0dW9o?=
 =?utf-8?B?ZDh2dUJ6VWVSL2Yra3pMUGFlSDNtU1RQQ3Q2U2lCcVAwNVFWdGlBVkVHbU0x?=
 =?utf-8?B?TUVVZTg4aHlUOWdQVXg0Smo3RUlOb3pHWTlQSHowdXBWSjhhZDd1WEdVQUFX?=
 =?utf-8?B?SHNGY3ZGK2dWQ0VveHB3djJucXpjZVBOVjZoYWwwZnd2WTl1RHNDbzg5bFRv?=
 =?utf-8?B?TnF4eU9QZ01nWTU4amVyV1l4WmxjZXJJQ3hhN3oyWmZLanlpOER5VGx0QTk1?=
 =?utf-8?B?ZmhoWlZxMnhvazhldlhnOVliQlhwcXliUDl1UFROeG9YT2taeGJVYjl2Mmpr?=
 =?utf-8?B?YmovMjU0NlZxTTIxQ1FMa1RzS1BTRFNGNVVHaVF2MG8veXYrd0lVeWRtcE01?=
 =?utf-8?B?VFplN3VLQTByTjFHVGNyMGVNaW9QUFVWR0tqR0FWdWVnZVByL1hRK24xeCtw?=
 =?utf-8?B?cTNrcjhIVDd3U0I3dGY5MEF1c1B4bXVQNk56L09YV1R2a0paNVlBRWhvOThs?=
 =?utf-8?B?V2VTTUdRYnNNcHppL3ZxRWwzL01mYVBxRkxNdks5VWpRNHlRRkJTdEI5bEVw?=
 =?utf-8?B?TEowTjBDS0dKbUZPRTdaVnVqUDVKMFI0bmZKM0RJRyt2ZWxubkIwL1QwdzhU?=
 =?utf-8?B?V1laWFBqZmU4YzN6WDl2aU4vRXNvcUgzODBra3JnRVRhQjFJaEE0TW5BRU5W?=
 =?utf-8?B?clVxTDRiT29NUHg0ZVR6aURzTy9CbmVhTnlOYzZRVElxNUU1czBwRHhhcmlK?=
 =?utf-8?B?NjQ0cjlwYml0ZUtWaWxPeUxWU2dydUs0L1pES1NrZjB4NWdLdlFNaVFFNEpS?=
 =?utf-8?B?UTVrbVQ4eUxzTUtOMVpIeEQ4MklmcVVydGJPRGw2eW0yVnIwK3pDVG50WFp3?=
 =?utf-8?B?VHBKVE1DYXJyZjVtM2x3dytST0xHWGhoaTkyWVRWY1hHeHMxRHNzVGdBMU5H?=
 =?utf-8?B?SHFNbkhVbkRWd3E2SnRIMnRldWFqYm5WZnVEcXNkODZWOEIwK1gzVmQ2OFRO?=
 =?utf-8?B?SnpGS3o1WDhqREp2NWtqOVFMOWJ0RjR6cCtPL3VHYXY2eVRRa2U2bE4wRWtl?=
 =?utf-8?B?d0lqSUxzUW4zREQ4SUkyZjlIbVNNM3Byc2FGbWF2NkNBVSs4aDAzdVg0SnEr?=
 =?utf-8?B?L0JDQzFHaTB5WlBja3ZkR3lMVUdTZlNEODhsME9qSlY0bVJPOHRIc3BGT1BR?=
 =?utf-8?B?cjBBdnRLT2ljNzZtUG8yQTZqMFhCUW9JSWhjLzQ2R09hWThyV0oyTG1KRGQ0?=
 =?utf-8?B?WXN1dyswbEYzOFZ5TDhES0o5cE5lR0hXRHNsSlZKRmZndklrN1BReWtjblkr?=
 =?utf-8?B?YnZjb1J3cm1sa1A2aVplVWRLbWFza0wxYUN5TFVnMWxvVmUwMzY4Yk9BZys5?=
 =?utf-8?B?QlpLU05qT21HMG9DUHVCbyttZnAyY3NtQjZqQ1I4VWY3NjJlNTAxbisxcWZz?=
 =?utf-8?B?WUFrYytMZ3QyUmZwTkdZWDhEMDkybmZJSWZGdzlsWjJmOStTNmxTYnNqa0g3?=
 =?utf-8?Q?Jt0kldgy5aNPns7Rt8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZuaEVqc0RnS2c2cVFtQmpra1pzK1JJUXhvRXVObzkxUU1IeFpzd3JER1gr?=
 =?utf-8?B?TjRTM3VTMWN3VnIzNk4wZGp5RnBsNng3UnBkdHA0Zk45azY5cXNGeVJ6V2dy?=
 =?utf-8?B?ekFjWG1wOGpVaEp6NHhWaHBSYWdhTE10SnlacURTa2dORmhzb0oyeS9YVE9u?=
 =?utf-8?B?S3NUKzFLK0dwdGtZMThlMXNjVFZjb0hxZmRDWUZtamV4YkNnYUFPbjVnL3da?=
 =?utf-8?B?NHZvZnBBRGhLaWxIRmdrem9GdndwNUlqY2l1a3NqbnFsTnlDWDBjRlVEMk1O?=
 =?utf-8?B?d1lzcUZaWW1hVE5uT2RUYjk1UDhNSTRKNUtURXJsM1ZXZVdWVU0rVnNmNFpw?=
 =?utf-8?B?NzFIVERXZkw2dVFJOUt6MzBNZG5MVWRFdWkrc3RyWWZsNDkvSmExdVlsbWFt?=
 =?utf-8?B?VlhsdUpZNllzNTd3QVRPY3BlaEZrd25BamkrcXdDbGdlZGZnSXpDWlc5Sks0?=
 =?utf-8?B?dVJ0WSsreldzWG1CVit5andpdFFoQW91L3djUHA5K05wU0xMd004YkZQM3Zv?=
 =?utf-8?B?TzZYK05wTmwvdjRyR0Nud3FmUmJWNTh6bkdTRG16R1I1Yy9mcEJJNXhxY2lU?=
 =?utf-8?B?VkpUd1V6aWNzN0Vxa0ZsTWJwSndCSTMrQTNwNHRTT1hXRGtBa3FKZkdiTGRL?=
 =?utf-8?B?eVBkWllBZ1lBZVpqOUlXMDZQSGFjazNCc2crTTM5d1hISFVaTkt6RzN2NU82?=
 =?utf-8?B?bjVtWm10OFlueHBDNk1WNmJRNER3WGdzWnRPT2lkQWFnSUxJV1dveHhGUVBF?=
 =?utf-8?B?TmJIY3V3VnlFQmVXbzJoYXpMa0IreE91SmVOeUVSNTZKdityMFZ6OWNGdVU2?=
 =?utf-8?B?YVhpQ0Vqa2g0VSthLytqcktRdnIvSUo5dEFwUlI4NExDc3NOMWNkZmdpNXQv?=
 =?utf-8?B?WU4yVUw5YWFTbmxxRVBNbUlTZld4RHZVOUFZNjNPV1hIK3ZzaDd1UnUvMUZm?=
 =?utf-8?B?c0JoT1VKQ0R6dHBDam9tQno4elRjWHo3d0Jud1ZYU0dyVndVMVhZVE5Xc25y?=
 =?utf-8?B?Vmg0RnZGL1NzUDdsNXNCbVdLcFpheTV1LzhQTEYvQWhUdW9xRnpLd2pFQ0JI?=
 =?utf-8?B?K2FmNmFYSitLWEZHeUl3N0FabmUyNXdSbWllUFAxc3BYOS9yWXdCMExFWTB2?=
 =?utf-8?B?TWJCQjZINUVjSFRFRmQwVTIwakFRL0J6T2l4WnY5dllZbU9MSFgyTjhweVAx?=
 =?utf-8?B?NVZxMURVV2t1cDZBWXN0YmtvVG5Gb3RDaENYYkdhRkprVlpJeExVbGtnRzJC?=
 =?utf-8?B?VVc3S0JxczIvQU1EVERpdFl0YVloaGZoSFhDeXlrY01lTlhBN2dBaWJlam9Z?=
 =?utf-8?B?NGhVSEdTeGRMaS9Rem9WY2VyR29kOEFacHc4c0t4N2hjeU1qeE13ZXJDbnVJ?=
 =?utf-8?B?R1VhcTVKTU85bWFKdk11YmxNUEZuUzFNZGxqbTBGNWFaR1FTNUN4TnhsbGI2?=
 =?utf-8?B?cXFLbENhakhRSXpuVzZaYVpUQlJRNWdtU0JJc015QXZoTnFYdS9WWmpXM0xm?=
 =?utf-8?B?WU1tSHRiRWZHMEZWWlBrSm55V3I1V3pHc3FwMDZ1dTZnOTcwQkJ5eXArZXpF?=
 =?utf-8?B?aXRyOTRaVkxSN09qTFpqR1F5VWtZRmtQU3lHMm45TURmbkNZTFNzZlFZVEFo?=
 =?utf-8?B?aFFaVGE0NHR5YS9VVUdJNVVncWU3VU43aHBReEdFK1NZL21EcWZwRUE3cXB3?=
 =?utf-8?B?aldCQTBJNjI1bFd6TlVjbHJiVmlkdDJWRlE3UU1UZk5ZbFNSMlNzN3Y4cnJK?=
 =?utf-8?B?bG04djdjR2E1Um5aVytzbEZmWXZiVU9ZZERkc2hYTkM4N2NrR2s2UEZVTzJp?=
 =?utf-8?B?S2ovelpnWUJlbERsQ1NaVjJWanJKU05paURjY3VLaGN3KzVYUm02U2pLUWRt?=
 =?utf-8?B?Q2QvTmE4OUoydWNrWUh6b0d0K3FaSkVKR1pBYlNKVmd4ZEk4SkFxQ0hhZzBo?=
 =?utf-8?B?UTU4NVJhQVMxK0hzbHhaN3J5dmR1M1FpTUVGMmYyTDdrS1hOSjJhUUVaQjZj?=
 =?utf-8?B?MW01cDF5N293ZDVIQkU0TC95cXBCYnR5TUlpMEQ0L1R2RjdUczNlOVlvVVJO?=
 =?utf-8?B?ODJVT0JWbFZrSnJwTU1zSWxjZ2JvOHdGNGdGS1NuZDZ2RU9jTUI3dld2Ykxq?=
 =?utf-8?Q?HrL7euYHjqc5eZyxJUBBI51hY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d524e5b3-ca7c-4f9a-0955-08dc85317eb4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 07:31:20.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkNfLYXOk20ebflEzHAX1zkYwpzUpKNOk/PgEJC+aT/GdKC2iZd1J7UG8clWIlLFi5H/sa65vxgvu7K8V1/fVbXlkO47zeRdCsdVPZ8dtG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com



On 04.06.2024 17:57, Mengyuan Lou wrote:
> Implements the mailbox interfaces for wangxun pf drivers
> ngbe and txgbe.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/Makefile  |   2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 189 +++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  32 ++++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h |   5 +
>  4 files changed, 227 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index 42ccd6e4052e..913a978c9032 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,4 +4,4 @@
>  
>  obj-$(CONFIG_LIBWX) += libwx.o
>  
> -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o
> +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> new file mode 100644
> index 000000000000..e7d7178a1f13
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
> +#include <linux/pci.h>
> +#include "wx_type.h"
> +#include "wx_mbx.h"
> +
> +/**
> + *  wx_obtain_mbx_lock_pf - obtain mailbox lock
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if we obtained the mailbox lock
> + **/
> +static int wx_obtain_mbx_lock_pf(struct wx *wx, u16 vf)
> +{
> +	int ret = -EBUSY;
> +	int count = 5;
> +	u32 mailbox;
> +
> +	while (count--) {
> +		/* Take ownership of the buffer */
> +		wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_PFU);
> +
> +		/* reserve mailbox for vf use */
> +		mailbox = rd32(wx, WX_PXMAILBOX(vf));
> +		if (mailbox & WX_PXMAILBOX_PFU) {
> +			ret = 0;
> +			break;
> +		}
> +		udelay(10);
> +	}
> +
> +	if (ret)
> +		wx_err(wx, "Failed to obtain mailbox lock for PF%d", vf);
> +
> +	return ret;
> +}
> +
> +static int wx_check_for_bit_pf(struct wx *wx, u32 mask, int index)
> +{
> +	u32 mbvficr = rd32(wx, WX_MBVFICR(index));
> +	int ret = -EBUSY;

@ret is unnecessary...

> +
> +	if (mbvficr & mask) {
> +		ret = 0;
> +		wr32(wx, WX_MBVFICR(index), mask);

return 0 here...

> +	}
> +
> +	return ret;

and return -EBUSY here

> +}
> +
> +/**
> + *  wx_check_for_ack_pf - checks to see if the VF has ACKed
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if the VF has set the Status bit or else -EBUSY
> + **/
> +int wx_check_for_ack_pf(struct wx *wx, u16 vf)
> +{
> +	u32 index = vf / 16, vf_bit = vf % 16;
> +
> +	return wx_check_for_bit_pf(wx,
> +				   FIELD_PREP(WX_MBVFICR_VFACK_MASK, BIT(vf_bit)),
> +				   index);
> +}
> +EXPORT_SYMBOL(wx_check_for_ack_pf);
> +
> +/**
> + *  wx_check_for_msg_pf - checks to see if the VF has sent mail
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if the VF has set the Status bit or else -EBUSY
> + **/
> +int wx_check_for_msg_pf(struct wx *wx, u16 vf)
> +{
> +	u32 index = vf / 16, vf_bit = vf % 16;
> +
> +	return wx_check_for_bit_pf(wx,
> +				   FIELD_PREP(WX_MBVFICR_VFREQ_MASK, BIT(vf_bit)),
> +				   index);
> +}
> +EXPORT_SYMBOL(wx_check_for_msg_pf);
> +
> +/**
> + *  wx_write_mbx_pf - Places a message in the mailbox
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if it successfully copied message into the buffer
> + **/
> +int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int ret, i;
> +
> +	if (size > mbx->size) {
> +		wx_err(wx, "Invalid mailbox message size %d", size);
> +		ret = -EINVAL;
> +		goto out_no_write;

you don't need goto. just return -EINVAL here...

> +	}
> +
> +	/* lock the mailbox to prevent pf/vf race condition */
> +	ret = wx_obtain_mbx_lock_pf(wx, vf);
> +	if (ret)
> +		goto out_no_write;

return @ret here...

> +
> +	/* flush msg and acks as we are overwriting the message buffer */
> +	wx_check_for_msg_pf(wx, vf);
> +	wx_check_for_ack_pf(wx, vf);
> +
> +	/* copy the caller specified message to the mailbox memory buffer */
> +	for (i = 0; i < size; i++)
> +		wr32a(wx, WX_PXMBMEM(vf), i, msg[i]);
> +
> +	/* Interrupt VF to tell it a message has been sent and release buffer*/
> +	/* set mirrored mailbox flags */
> +	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_STS);
> +	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_STS);
> +
> +out_no_write:
> +	return ret;

and return 0 here

> +}
> +EXPORT_SYMBOL(wx_write_mbx_pf);
> +
> +/**
> + *  wx_read_mbx_pf - Read a message from the mailbox
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if VF copy a message from the mailbox buffer.
> + **/
> +int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int ret;
> +	u16 i;
> +
> +	/* limit read to size of mailbox */
> +	if (size > mbx->size)
> +		size = mbx->size;
> +
> +	/* lock the mailbox to prevent pf/vf race condition */
> +	ret = wx_obtain_mbx_lock_pf(wx, vf);
> +	if (ret)
> +		goto out_no_read;

just return @ret...

> +
> +	/* copy the message to the mailbox memory buffer */
> +	for (i = 0; i < size; i++)
> +		msg[i] = rd32a(wx, WX_PXMBMEM(vf), i);
> +
> +	/* Acknowledge the message and release buffer */
> +	/* set mirrored mailbox flags */
> +	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_ACK);
> +	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_ACK);
> +out_no_read:
> +	return ret;

and return 0

> +}
> +EXPORT_SYMBOL(wx_read_mbx_pf);
> +
> +/**
> + *  wx_check_for_rst_pf - checks to see if the VF has reset
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if the VF has set the Status bit or else -EBUSY
> + **/
> +int wx_check_for_rst_pf(struct wx *wx, u16 vf)
> +{
> +	u32 reg_offset = vf / 32;
> +	u32 vf_shift = vf % 32;
> +	int ret = -EBUSY;

Again @ret is not needed

> +	u32 vflre = 0;
> +
> +	vflre = rd32(wx, WX_VFLRE(reg_offset));
> +
> +	if (vflre & BIT(vf_shift)) {
> +		ret = 0;
> +		wr32(wx, WX_VFLREC(reg_offset), BIT(vf_shift));
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(wx_check_for_rst_pf);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> new file mode 100644
> index 000000000000..1579096fb6ad
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
> +#ifndef _WX_MBX_H_
> +#define _WX_MBX_H_
> +
> +#define WX_VXMAILBOX_SIZE    15
> +
> +/* PF Registers */
> +#define WX_PXMAILBOX(i)      (0x600 + (4 * (i))) /* i=[0,63] */
> +#define WX_PXMAILBOX_STS     BIT(0) /* Initiate message send to VF */
> +#define WX_PXMAILBOX_ACK     BIT(1) /* Ack message recv'd from VF */
> +#define WX_PXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
> +
> +#define WX_PXMBMEM(i)        (0x5000 + (64 * (i))) /* i=[0,63] */
> +
> +#define WX_VFLRE(i)          (0x4A0 + (4 * (i))) /* i=[0,1] */
> +#define WX_VFLREC(i)         (0x4A8 + (4 * (i))) /* i=[0,1] */
> +
> +/* SR-IOV specific macros */
> +#define WX_MBVFICR(i)         (0x480 + (4 * (i))) /* i=[0,3] */
> +#define WX_MBVFICR_VFREQ_MASK GENMASK(15, 0)
> +#define WX_MBVFICR_VFACK_MASK GENMASK(31, 16)
> +
> +#define WX_VT_MSGINFO_MASK    GENMASK(23, 16)
> +
> +int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
> +int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
> +int wx_check_for_rst_pf(struct wx *wx, u16 mbx_id);
> +int wx_check_for_msg_pf(struct wx *wx, u16 mbx_id);
> +int wx_check_for_ack_pf(struct wx *wx, u16 mbx_id);
> +
> +#endif /* _WX_MBX_H_ */
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 5aaf7b1fa2db..caa2f4157834 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -674,6 +674,10 @@ struct wx_bus_info {
>  	u16 device;
>  };
>  
> +struct wx_mbx_info {
> +	u16 size;
> +};
> +
>  struct wx_thermal_sensor_data {
>  	s16 temp;
>  	s16 alarm_thresh;
> @@ -995,6 +999,7 @@ struct wx {
>  	struct pci_dev *pdev;
>  	struct net_device *netdev;
>  	struct wx_bus_info bus;
> +	struct wx_mbx_info mbx;
>  	struct wx_mac_info mac;
>  	enum em_mac_type mac_type;
>  	enum sp_media_type media_type;

