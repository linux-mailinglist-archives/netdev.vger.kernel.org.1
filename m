Return-Path: <netdev+bounces-84364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65448896B0C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F24F28ED0C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE8A134CC8;
	Wed,  3 Apr 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDNe7pmD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4466154725
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137846; cv=fail; b=tK7kxxrLKHZ1e0W9XVte4RaC6Q8evit/aZm3PXC9VjY2o6S7YUOg71t6W3ERC+j0Jlh4EhC41btwjF+syizjVzqdNm7xc/nvPkDbHUA12U7wQvRbPS17urT6wNxDseEJmTDB1QBLSXAo2Zz4pEpY4oSC+N3IN3KuB0RX4O57Yt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137846; c=relaxed/simple;
	bh=17Nvhs+0hCmprYgn+KAnDCRdrJWJAxmHGHN76u4EksQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KaguaLTf7NLB/eFBZMWS/2AK4snk2zsxvPNmOedZr32mm1k6RZbdROocV5BwfRWRcLWhFVglKFK6WGPNcLq5O9qcS05YLc30Us5FlTk4ES06TOhYmWNm4dEvfndzPaWXHa66pBDKR9nmGSIbsrdQ5Km8k+vZtzR9V+cRuDHKr4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDNe7pmD; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712137846; x=1743673846;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=17Nvhs+0hCmprYgn+KAnDCRdrJWJAxmHGHN76u4EksQ=;
  b=KDNe7pmDSriT4fq3DSd/3ExgmcOYf5zVqAUIYGJP/LGey1vzvnJti8DG
   mHTe4aKMIZIy8hnt6fw6NKG10Ts7/1hE4wintWNPLpt9Q7AN69/pXg3f9
   XqBxF7IsoUrnQEMXvkx42Fq8TPg5puOC0TMcph6GF0LSUbC/kLDquWJZX
   2y1MYXTzZubyBxiEsJ8BWPe2z24he3YSvzSZXlP8HLbWvkiGCj+kGR1tr
   doJMNVZ1XHqTa5eaQurydeLj2wqT3tsvCry00IG2vFZ9AJ7sAKAe22n14
   8i5wXGsRTEObC7pgcbw7qkg72bxHhhyaxVAIZcY8c2Q5AxjQRXOODXV/l
   A==;
X-CSE-ConnectionGUID: SNxRUDxfSdWwl3Ec3Wd40A==
X-CSE-MsgGUID: 886ZykBmRmWNW4tKaGhwzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18516111"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18516111"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:50:45 -0700
X-CSE-ConnectionGUID: XEVDlKzsRrCqjvZNk2TKgw==
X-CSE-MsgGUID: kobBk9TqR2GYjkeoUBbFFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18285424"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 02:50:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 02:50:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 02:50:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 02:50:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+ACCDPJ2iPm8im4pn0Vfu1c5vzkNQSkWyFgdrSWzbzUJlt2lZEVpGL95vGzVEU2R49vmDGqUVRI1ZFuFK+SfftEKdeeLN2sdJIcuORJgkbhEv59eyS4428fc31XZMt0GbpUoRZoMzaPscWPAndnls4aKAVbV7vv/96m2zdHMkIKdctCALtpyrA7BQjRk+UGRXvmQbjIFjuTjEYnVn+chaSDLqPsx9lYGbrq9smojEtYgr1qgcexxpJNO2mf3FoD5kUVZRSUf7iVomvrDc+o9RCMXfSbSEMn0qUtDi5sl0llCjubEApwgt4/OvFZrr8FqCcxeLP6ssBGVs8JhSYqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vT6Afc/QuaTH7Ci5QNR7l+1UZ9VHyPsSOzY34c1N4g=;
 b=C4XYU79ZhttdsRQDprHF0me9cp5ALTiEdlPbxsic4IpjfUK3DSO9FrG1cA3dPXYKyynK2f+2L8Papza//o2gGNDYYXzA0wxL77/xe4sbn/wpgzv4iieKgY/ObpoQgeqBZ6HFA7/RMlUF6mbBXh7aEVFPNfEolW0ky/v9MWVsDtULPx3Ei8IN9XmV0MWPjsQOmLFvqnlV0NvWN2Rb0ChgwWInqtahDAuCx/mFtzg2WlLLb0arVp19o19MdOfyhe8BdgpSSJ7aPz/2LRsQZjyd9+7nVrd9dF/F9vaYhz0q2e8m/SOPY5NIENO79+y29QLm2b4YYdIYJy1jD/IBm468EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 3 Apr
 2024 09:50:40 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 09:50:40 +0000
Message-ID: <0cbbc736-f87c-4e58-a0a7-9c2d04e7b2cf@intel.com>
Date: Wed, 3 Apr 2024 11:50:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] ethtool: Introduce max power support
To: Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<anthony.l.nguyen@intel.com>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <przemyslaw.kitszel@intel.com>,
	<marcin.szycik@linux.intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <20240329092321.16843-3-wojciech.drewek@intel.com>
 <07572365-1c9f-4948-ad2f-4d56c6d4e4ab@lunn.ch>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <07572365-1c9f-4948-ad2f-4d56c6d4e4ab@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB7128:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/4ImJSEewM6wDlpAshp8heVoKem1pssfpnzp4VfXxg9g1jw8tI7E+pDJZSuT1qSeqNLVxKRu1WQWx3V4RTHWGeADt23OMpRVUAiIWWSDgBN/QpY/Yc9LwbTC3mx24o2x3FT+BWDhy0YS6UPNYPlayqL6PqwKnZ48ikkNvhnLIYXqqMXC6lMoucbBBpMCndvAOOEiGRd76rM5wtTqwzZb/5TP8LqasiEE1kRlOAdSLlyoJcVuSvsAu55y7axGV1nREV025SBBg4txgSQMSKxAnPFK7yoloDAxWj0+5GRqLxYhhqhLQh+O7qBiP+P7T3wvfh/ecTKElycuzZm0mkZQlTCbLMBzaldqcoHD9F88Cp33lyS8oxlJ3aECBYZoAUWPZmW1BqM7I1qYaoRb6nLkFJ/7eGaua0DT/OQaj/NZojTl+upLiHoUCNAxFqT2D5V0hLLiOZ9JENCYYqS1uW19V4Y6oROv85N+VN0AeEdkWsRr4JoqsFjIrZQhbVOal/N+8jnPJFObRHMZbPvQ8Z+TL+yUQuZAUHEIcde9WmsL6Tou0PM+wnQGFTc948jX5KaGK95ciHCF/KqGW5Q0BkmclBO1TQGYHBv/egFdkAg1uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZNS21adlBrYkVWYWJ2Q0RBc3BKVkhRaGk1MHh5azJHdXd6V1pLdytUZnZV?=
 =?utf-8?B?OGliekFJWUE0OXQ3NjNRbzVHWmxTZkhUU2xiSUhwTXFMS01wWklwZG9RUjNi?=
 =?utf-8?B?V0JnU0I4VTdrWnJsNTVYdWpFMkl1eU9mR2E3bnNZakVaYlh1TCsxTjFhMU5D?=
 =?utf-8?B?YWpkTW85WWRjS1RpOFBRVlIrQjJhUVEzbmp5SlIvV2UxSFkxV0gydlczakFY?=
 =?utf-8?B?SkYzQWpFQkVHWHM4THJyaXZGVnh0QUV2Rkc5dkRWc2Y0MWt1ZlFOQ0UvM0pn?=
 =?utf-8?B?ODFBNUE4YlRGOHdsMGlpTEt0eVh1dGtaOHVKc3Q4WHVXOTIzOFdKSktKOTNI?=
 =?utf-8?B?amVaYThRL09FbDdTNHdFVmFUbE85ZFJUUGNhdTFaNXp0cHNyYkN2Y2M3Mkpp?=
 =?utf-8?B?dXk3cWhqR2hueWt0ODQ4WFZYSnNzTFZlRHNURE9BM1pYQ3N4WjFRdmdOUERQ?=
 =?utf-8?B?M1ZmdlJOeTluTGx2Q1Roc3B1TDdKK0RKaU5PcU1RSHVJMzl2MVd2RytKd2dx?=
 =?utf-8?B?OGhOY2pHMml6Y0lkNmg5aUxBWXdCNnRJUDd0dTNpTFJLQzd6dnBHVGNNWDlr?=
 =?utf-8?B?S3VPcTc3aEpZOGR6SUp0UlhRREp3bXJTU3F1SkoreWlMTmVSUkFublZQMG43?=
 =?utf-8?B?QVU4MGRlYTUyTzFydnUyVFpZTzFGV3g0OVdkcHhFQ2hEZVF4R3Z5clVEMXV3?=
 =?utf-8?B?Qmlvajg3WG9qK2xjNlpXNUpKS0o0Qy9hN3FYcUhQTjRGNlZ0UkpFK2loUU5p?=
 =?utf-8?B?OFJNYnRDcmh1RHlpcnBENVR3Sm1tZzh0bzFvb1JXRElaczNiZ3lXMFRhN3lm?=
 =?utf-8?B?c3ZyZmhFdndzSWJnTHVTMXlJZExIL3VweXkzNHo3VFRRM3liVFhqYzJHdjZk?=
 =?utf-8?B?N0dIQVB3UXlFNkRoenIvVlVDdi8wMVJDLzhwK3o0UnlzeFpGcHBoUDV1Mkpq?=
 =?utf-8?B?b2ZHYm82ZisvN0lJa2YwVHdXMFRUMTF1Z0ZRM2ZxNjFSTVdjemVzZWMrTWdq?=
 =?utf-8?B?c2dpS2dweDZTdTY4TzZLOCtwNmFlUm9hUTFVNkdTeGxBVEc4Nk41cTZCQXZT?=
 =?utf-8?B?QVU5NjRQN0J5ZFhQRy9BNy83SWxPbWpPUzRzRUU5SytRVEcxL2xkNCtUWUlN?=
 =?utf-8?B?REFHZ21WT3JlU2hjTTF3YVpYbG1nOXZPNjVtYXp6WDc4WFdsUWRLTDI5anJS?=
 =?utf-8?B?MUhxQmw3QnJPTndNMXgwKzI1NTdMSlFlVU5heGlzTU9HUW16RFNDNjRTaFNC?=
 =?utf-8?B?VnBJNUJpdkdlNVZoMG8xdnFTN2trSlVRRVM5UE9MOXc4U25sVG5nN2FEQzR4?=
 =?utf-8?B?RThmSHJvSnhOUlUyd3h6MlpYREplenJDNWhpTzM3TjdzY2ZoV21UZ2ZSQmF0?=
 =?utf-8?B?cEdpYXF4T1VQM3Vza256Y1RLNUxuYys2Y2tLTWRqMm5HZldMd3pRV3Bud3J0?=
 =?utf-8?B?ME5OaFR0NTE2YUJnUHkvK2FHaXhGeDRlbXQvSXBpSkdsdi95LzIrY05aREZW?=
 =?utf-8?B?TGlrNVB5Z0ZZU0JrQ0Qzems2em05aUh5cnl6bjRHSHhsUm9pSktPWGhkZWxW?=
 =?utf-8?B?bVB4dWJaMUZUR0JRTG5TNWZpb2ZxK0ppUDRaeGZKckdFMDNac1VIVHdDVWx4?=
 =?utf-8?B?d0QyQmpmazNIVXByR3RLaVFjOTFUa2Zmb2hYTXFGM3RBRnVIcFhleVZlWjZn?=
 =?utf-8?B?UlEwL1JBQlArT3djWlVxL1l3ejlaMDJ4YUpJQlBtQzU5azdlL1ZaWmhzUmlR?=
 =?utf-8?B?V1JhQ2JaMTJTM3hXZk5vY3dxT1JUTVUwSThWZzJueDQvTmNONXFqdEVyT0Jv?=
 =?utf-8?B?bnZxQXN2eVJHV0ttMy9RVUozQUpmMEY5eHpuTm8wcWRvaXNUb3FxMGZBQ0ds?=
 =?utf-8?B?T1dEYW5ycHk5M1lVaUpndXkxT1VOaGJtTGNsS0tUbWs3S042ZG1BeW51M094?=
 =?utf-8?B?TStyNms1alNnS0N5ZzhwK0lOOUFXYnlIam1SNkZ3MG1ubFdWcDVQaUh6NHZP?=
 =?utf-8?B?TmVxTXpRYkR1UXl0eHZoZHRqMW8zdlRZSTVJREQ4WWtYNnI5dUlxUE02c1pO?=
 =?utf-8?B?a0R1eXkxRUFtejg1VmtTUlRUSjQ4ZnFBY2JxbFpNYVJNZDZ5TnpIdFRiNU5T?=
 =?utf-8?B?TVNZWm54SDVrcmp0RHlOajNBRjNHVFJjRVBVUnJNdUw0TDRLT2o5L1ZUR3J4?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 607d5795-6e5a-4019-5f18-08dc53c385a0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:50:40.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtKYzZtqlQVPCL9tPRU0kWIrbWkF/UuXU6zfyuUWLRsv9STdBHVDC8iYk0aTKwvhhmhkKrEMwCJsh0VMzNaPmEW0IYc85ebrmwAYB/AcKlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-OriginatorOrg: intel.com



On 30.03.2024 23:14, Andrew Lunn wrote:
> On Fri, Mar 29, 2024 at 10:23:20AM +0100, Wojciech Drewek wrote:
>> Some modules use nonstandard power levels. Adjust ethtool
>> module implementation to support new attributes that will allow user
>> to change maximum power.
>>
>> Add three new get attributes:
>> ETHTOOL_A_MODULE_MAX_POWER_SET (used for set as well) - currently set
>>   maximum power in the cage
>> ETHTOOL_A_MODULE_MIN_POWER_ALLOWED - minimum power allowed in the
>>   cage reported by device
>> ETHTOOL_A_MODULE_MAX_POWER_ALLOWED - maximum power allowed in the
>>   cage reported by device
> 
> I'm confused. The cage has two power pins, if you look at the table
> here:
> 
> https://www.embrionix.com/resource/how-to-design-with-video-SFP
> 
> There is VccT and VccR. I would expect there is a power regulator
> supplying these pins. By default, you can draw 1W from that
> regulator. The board however might be designed to support more power,
> so those regulators could supply more power. And the board has also
> been designed to dump the heat if more power is consumed.
> 
> So, ETHTOOL_A_MODULE_MIN_POWER_ALLOWED is about the minimum power that
> regulator can supply? Does that make any sense?
> 
> ETHTOOL_A_MODULE_MAX_POWER_ALLOWED is about the maximum power the
> regulator can supply and the cooling system can dump heat?
> 
> Then what does ETHTOOL_A_MODULE_MAX_POWER_SET mean? power in the cage?
> The cage is passive. It does not consume power. It is the module which
> does. Is this telling the module it can consume up to this amount of
> power?

Right, all of those attributes describe restrictions for modules that
can be plugged into the given cage. ETHTOOL_A_MODULE_MAX_POWER_SET is
currently set maximum. The other two define the range of values that
ETHTOOL_A_MODULE_MAX_POWER_SET can take.

I hope that answers your question.

> 
> 	Andrew
> 

