Return-Path: <netdev+bounces-89449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BE58AA4AF
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F22B281FE7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792CD194C83;
	Thu, 18 Apr 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikSyT73d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3EB194C81
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475394; cv=fail; b=CJdyV/CTEm7F6ENH0Fs4YOBwWrjlnsPVVPdxx3U5TcMRH7G1ykRJiNG5P0XXzROPRDUfMJmVZd2KOkV/qgAgtsED7JLhd/KrzJhHrRHG3sd3c117c/vWFkJp1GGKbw5Nm9AKjH7T/ZTST5Ws1x0nWWt9oEAJtKj6asFv0wTOw+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475394; c=relaxed/simple;
	bh=MNcIeVHTCNBwVTj5XHugeddc19EQeeS3oTIaY+Xlqp8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jg9AaGKYeh/iyD9Ni/krztf9QlPs32PtFbUbZkvR0jtPJdTAxwSN10kxJslx0vJGduiKafhowOzahsr+GrC1LfRS0AxnaAtJdC2j8aRbrVMuVbctuOQAQaSZ+bY3ck3uNKC1S9FfJc6250MezgEL3Y6WqV5Sz9DJREMehmasmWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikSyT73d; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713475393; x=1745011393;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MNcIeVHTCNBwVTj5XHugeddc19EQeeS3oTIaY+Xlqp8=;
  b=ikSyT73dWwhLtJpqmO6AebR6uoYvfwanAX3cwLx2xdumfe65uXT8AUJz
   /oWJebjGI7rxffF59bFUM5Wzr0R9z99u+9H/yza+Jnu8eKWy0P3hCzG55
   sCj0G5Ec5ae7Bf3ULPhAvSOgy7tx/zA13amI1Tb2S1yayEbLsBeCccKWH
   DiDNaKiAagDfpSFJSbrtfm9iViJPQbHPWDFpO20CLWqukMpdF7ldVfvlb
   aa8CMFY08ZOz+p8Wxj2KTpwL3CAHraGzTJxK3QxNY5ZDAOfYuNewH2k+f
   rrf3Aa0wOVN/9nKpUHHoaYQDcHnTYO3H69bSZer2gHpmw0sygAi8pEwyJ
   Q==;
X-CSE-ConnectionGUID: VjU5//SAQDCLrtCzfBpnCg==
X-CSE-MsgGUID: nA0jmVI0RAaw+HVFMqrFMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12834268"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="12834268"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 14:23:12 -0700
X-CSE-ConnectionGUID: D/ygr/fjQ6Sg/LhWhMvbqQ==
X-CSE-MsgGUID: cBJZ+YgfTkOIc4wxI3pYEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23184740"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 14:23:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:23:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 14:23:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:23:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5wJJWIw6LXflVE6VSG9IW7ytFQroc+iJuwk4Zm1P9Oy6HVi72pBcQSZ1l22ox3k1SszVQ7GR+cKQmeGPEG6WFTKufM7hxk3OzCGn+cQZ05j+MViwS6QuVGczeIuf2/tOKcMorKhrX3JlV9ey0ywKn52nktH2XBMKoXsn9VP1Lf73ViBxhL5BbnBfJ3Javw97nCAgInqvA7qHgZl9SWkJhlbV92biZM4t6DGHx3L06XF5MiiQyYfp1EC2rf0etl8pAhlwxeB4pK0duD+7z4kIcNojpz3hI6MkTsW6FUsPj1WRVm3uDH9DyT3+4m1KvvBBNdo0/F5bgxR4EdF0sWNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPeDzP+oX4QPJ2aJnNXcZVnPVzQejrZcISyz5rsowGg=;
 b=hCpaa6IgrGrR9yIV1vJ0WaSc+gP5aFR+sqxGCQCzGvnWHQ1W7057WmB+QdnvaHpagNe4Z7c646o8dEIFWM/zlVxQevnW2ZwZ8sxHX08R0E2+JtNe0zomgU1tn0TglrvB0+kOqGKDdT45tZOah8B6RPc7d4ehQPH55C9p+bD1PRmU9T9U5PzJpkefT+K0y96AtvvrlOUxMy2EAjpX/moAXm7OLI2HeyuEWVN9/YNFikn4Bj/UZqA4ZFGmzfDdu3QAR7N/Ih0BtyPAf1+STuYjt2eBs+rjnlrYXMLypEkl2R+V47dH5MQiaZesoJob9d35ZFwNL3amWojc5vfWi++UEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 21:23:07 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%6]) with mapi id 15.20.7472.025; Thu, 18 Apr 2024
 21:23:07 +0000
Message-ID: <acbe612f-faaa-4c70-802f-87504ee7c274@intel.com>
Date: Thu, 18 Apr 2024 14:23:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,RFC PATCH 0/5] Configuring NAPI instance for a queue
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <ast@kernel.org>, <sdf@google.com>,
	<lorenzo@kernel.org>, <tariqt@nvidia.com>, <daniel@iogearbox.net>,
	<anthony.l.nguyen@intel.com>, <lucien.xin@gmail.com>, <hawk@kernel.org>,
	<sridhar.samudrala@intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
 <20240409162153.5ac9845c@kernel.org>
 <94956064-9935-4ff3-8924-a99beb5adc07@intel.com>
 <20240411184740.782809eb@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240411184740.782809eb@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea1461d-950d-4de5-5394-08dc5fedbd8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFVlhZtcfMUKIq4bDkrTax93sVsSguobgm7etrNcYU+zEPLdGsepiQGAq1BIY2aIk7iWGXRYNGNmzwV14Bg7MI1XcKTspPq3peVFy9RXOhV7/IJr/0Hyq79QlumXAXH/cyDnqw6uw1WuehvNR/+4Jbq0/ihu7N7LUBud0ASkvY8KijgNECMmsrG/3pwXbxe0KWixCJaTHDj1eNRM/sWp+gRA+Ms3Yt4fgCKfePXkR9+Jo+bGMjBoMcc6RMw+54o5I+4Poj+MZEz3b55i+DgHf6ofTpt8ohYPp3WuuQMAmwwNFCZJ3PdyadJGEb2k0sBGmbm396NGIcU//+Zzm76SLNPnf1opAijtK0M0Gne/9BPu5iDBu5jnFUqMV7M0fB/Jyr8tDU7JQayG31om64U9LQGjSHjWvy6q9t0OGMdWNrzE7nqrygsDEcKd4CyjsKJrR9i2funmTb3o8kv9WBm4tFAF+IA8sEwuDIT9ITj6Kkl4L1VNckYaCKmbjcRnp6zBhCmLbNVpVW2K6ytLgnudoYKnSSPbzYYmsXA4EajGVIHWFf/amIjXFyLBqdmHEvM9QpsAHmBT27uySTVBnq0NG3x7jVObeaEg6yF8+Cad41rvYZG5WVREKXFNO73rV0aLzSQOt4FQtCiWX/3L9cIHrxdfZC68mgmy2EZMM7Bg8nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmxKYkZlenl3WmZrUDNITlV0QURMQ0d0YThkNE9Td01vU3lYR2JzSnppdzBr?=
 =?utf-8?B?bGRabmYxaXJvYXBsbGV5cTA5ZXNVdlNnd1dsdHhWc2pZQTltSDJpVkk4TFF3?=
 =?utf-8?B?bGtDQnQrN2lHOTE4KzZmdTd0YUVaMmNEL1ZrQTJxdFJ4UnAveFhIakFROXhP?=
 =?utf-8?B?ZXNqazhQbmFKRzM2YXUvWEhGZlJMUzlFV2hwNzlIaVJsRDBlUHlDUEJ6ckI5?=
 =?utf-8?B?K3lPdDhJM0t0Y1ZaWXJTVG8zdjF0elc1YzdqQVpLRkZreUtTQ2lSOGd2RW1Z?=
 =?utf-8?B?MlV3OUxNWkhRTnRnbnVzSmZGRHFnWlBsTHpuMXJCTmw2U3FJNkh3YkR3Zkpr?=
 =?utf-8?B?cGI4ME1aaWU0ZUdnZTQxaklINWRYVStKbGJxWGJJUDExK1gxQ01UQnRFYmJO?=
 =?utf-8?B?dGx2RGcrUFY0dklQR0x1dG9ENHB0ZHdFMjdxci9PT3g4aDhwRWV5NFVCWTky?=
 =?utf-8?B?OXJyVjA3SG1LQitVV2MrUWFjZ1JlVzltVjVwNlZRTnFGY1NkN1JrSHFNZlFv?=
 =?utf-8?B?dURWQnlzR3hBZGp5SXhQRExFODBDSlZUcGhZQ3B6dUJaYTZ4S2h3bDgvY2k0?=
 =?utf-8?B?NTdjN3R6QTlnRFh3MkE4QWxLSjM4NXNlR3lwVUloRER1TW40QnJ1Nm96S3V2?=
 =?utf-8?B?VlNzREhwRVkzSjgzQ0VNUmg0VzdmQmxscGlYNlJYdXd2ZkF4bkdGdHU5eXpJ?=
 =?utf-8?B?eldQa1RwZ1BxdWxGeHNqVStrMnIrRGI3ODB6VHhEVTI2ekdZSE1LWVZRQmNH?=
 =?utf-8?B?cUltL0RVN3pRK2UrUDRTM0ExbHhTZTJMWEZmMFM1YzNuNmlwdkhNM2Z2bjJo?=
 =?utf-8?B?V0ZkQzRQS3JIaVpOUExRUU9FY0FSUXN4MThkZjJ0WXU0R2FxY2gvU3lIdDMy?=
 =?utf-8?B?WUNCaUVTR2NRVVpNcmdaVGwxZWp4VDhOL1VBNGlSd0NYa2hxVUJ0ZjZYTUpH?=
 =?utf-8?B?ektUREphclRTbkZNcnRNRzVFeGM2RnR6eGcvU0dHQUY3UFR5UHNTbUpSd01P?=
 =?utf-8?B?S1phNVJGeXVOb25jL1pxK1F6anYzSG9Ieit6WVZNYkI0QjQ3eHNHUnZDVThx?=
 =?utf-8?B?VWZJeWowN29BRGZKOVh4cjVMT3VZRitDQ1ZGQldqSmJUWkNnL3F1VUlla3ZX?=
 =?utf-8?B?VzVoa1hHNHVkbDREMTAwQW1lT2ZXbHhoSFp3KzJvNFJoMnBjcUxpaVNCSjRk?=
 =?utf-8?B?U2RpczFkZE52R0E2OHNJWDZPblpIemJpbnExYWJTbXZveFNHS2J4SEZuS1RU?=
 =?utf-8?B?ZUxOUXc5cFlDcDVOWjM1V212eldDRXNMM3N1NWNCdlQraHRROGhwdVdXMEJO?=
 =?utf-8?B?NUpXRFFRYjY0ZmM1Mk1GY3FqVjRLYjgwNmlpVUEwUko3b0srN0pXT3QzTzk4?=
 =?utf-8?B?a0ZQZ3NHNWRSWlVRYnFQVHJtWDVNS3FsNWV6YS96MGlJVTZ6TDBXVjUwSlB4?=
 =?utf-8?B?Qzc5dGNCV2QvUjFFcWRtRGN2R1VkY01hZGNId0RlUnNrTW45VWE3dHBzU2RL?=
 =?utf-8?B?elR6MDZidG81WTVlT1VHTDVqQnoyM0dDeDhPOCtXMGE3MDY5U0dnZWdZZCtp?=
 =?utf-8?B?WEdyR0ZDU3EwYmlNY3BGWVk5Y3VhYXk3RENIc2xUTWhjc3E2aGV3WkJtR1Vy?=
 =?utf-8?B?YVdLa3FoTzVXZ2NWbjU0N25iNGNxVjY3aDVoL3d6MWx1d1M2cjJYaXdycFlP?=
 =?utf-8?B?NGlJcE5RdHhzbUI3bHYreTJkWTNMQUtFWEVLR3B0SmFHRy9VUEJPR1h6R0Np?=
 =?utf-8?B?NUYwdm90ZHUwYVlwR055Z2hFaVExVWRLTjUyU0lIdkJhcmt2QzBhcENYUnVy?=
 =?utf-8?B?K3FoOUUvQVV1TnppYXVqQVc1YnFUdHU3MDl2UEhhM1dhZnE2U2I0OGhxTGpt?=
 =?utf-8?B?NWNGWkdSZk1Db09IeXJpR2QvaDBqbmlYU3RTOUYxL2pmaDJ6NzJhamtBenNw?=
 =?utf-8?B?dDhRYVZ2UStmYWNyYStnZmNsK05TZGFuUUpvMmZJUDFDaXcxZFB1ZEZBNDJU?=
 =?utf-8?B?dk02VzFlMlp0UDIvQW1weUU0a3k0LzJnVHMzVHM0ZkNEZGZpaFpUVWw5TlRU?=
 =?utf-8?B?aWw2K3E0UWNwZDJKbHJvb093L3hyVWhpa2UyV2VYaUkySHJzcHBONXBXVjlM?=
 =?utf-8?B?eElJeUFOd3pXc2lDanRDQmxQRW4xcWJTMFlSTUI0eEo2aFFGZTNWU0tmd3F4?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea1461d-950d-4de5-5394-08dc5fedbd8b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 21:23:07.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXvVr6PECGyyqZ0vXfk1tYNWKLaqedAyi1fb/76hWVpOF+5yXh3Hnr5Iosu+deSIaoK5ikiTrsGNkPBi2/ruAlrA6ED2SdVwiSKwEs4OlNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com

On 4/11/2024 6:47 PM, Jakub Kicinski wrote:
> On Thu, 11 Apr 2024 15:46:45 -0700 Nambiar, Amritha wrote:
>> On 4/9/2024 4:21 PM, Jakub Kicinski wrote:
>>> On Fri, 05 Apr 2024 13:09:28 -0700 Amritha Nambiar wrote:
>>>> $ ./cli.py --spec netdev.yaml --do queue-set  --json='{"ifindex": 12, "id": 0, "type": 0, "napi-id": 595}'
>>>> {'id': 0, 'ifindex': 12, 'napi-id': 595, 'type': 'rx'}
>>>
>>> NAPI ID is not stable. What happens if you set the ID, bring the
>>> device down and up again? I think we need to make NAPI IDs stable.
>>
>> I tried this (device down/up and check NAPIs) on both bnxt and intel/ice.
>> On bnxt: New NAPI IDs are created sequentially once the device is up
>> after turning down.
>> On ice: The NAPI IDs are stable and remains the same once the device is
>> up after turning down.
>>
>> In case of ice, device down/up executes napi_disable/napi_enable. The
>> NAPI IDs are not lost as netif_napi_del is not called at IFF_DOWN. On
>> IFF_DOWN, the IRQs associations with the OS are freed, but the resources
>> allocated for the vectors and hence the NAPIs for the vectors persists
>> (unless unload/reconfig).
> 
> SG! So let's just make sure we cover that in tests.
> 
>>> What happens if you change the channel count? Do we lose the config?
>>> We try never to lose explicit user config. I think for simplicity
>>> we should store the config in the core / common code.
>>
>> Yes, we lose the config in case of re-configuring channels. The reconfig
>> path involves freeing the vectors and reallocating based on the new
>> channel config, so, for the NAPIs associated with the vectors,
>> netif_napi_del and netif_napi_add executes creating new NAPI IDs
>> sequentially.
>>
>> Wouldn't losing the explicit user config make sense in this case? By
>> changing the channel count, the user has updated the queue layout, the
>> queue<>vector mappings etc., so I think, the previous configs from set
>> queue<>NAPI should be overwritten with the new config from set-channel.
> 
> We do prevent indirection table from being reset on channel count
> change. I think same logic applies here..
> 

Okay. I tried this on bnxt (this may be outside scope and secondary, but 
hoping all the additional information helps).
It looks like bnxt differentiates if the indirection table was based on 
driver defaults vs user configuration. If the indirection table was from 
driver defaults, then changing channel count to fewer queues is allowed. 
If it was based on explicit user configuration, changing channel count 
to fewer queues is not allowed as the indirection table might then point 
to inactive queues. So, the rss user configuration is preserved by 
blocking new channel configurations that do not align.
So applying the same logic here would mean, changing the channel count 
to queues < 'default queue for the last user configured NAPI ID' would 
have to be prevented. This becomes difficult to track unless pre-set 
default queue <> NAPI configs are maintained.

>>> How does the user know whether queue <> NAPI association is based
>>> on driver defaults or explicit configuration?
>>
>> I am not sure of this. ethtool shows pre-set defaults and current
>> settings, but in this case, it is tricky :(
> 
> Can you say more about the use case for moving the queues around?
> If you just want to have fewer NAPI vectors and more queues, but
> don't care about exact mapping - we could probably come up with
> a simpler API, no? Are the queues stack queues or also AF_XDP?
> 

I'll try to explain. The goal is to have fewer NAPI pollers. The number 
of NAPI pollers is the same as the number of active NAPIs (kthread per 
NAPI). It is possible to limit the number of pollers by mapping 
multiples queues on an interrupt vector (fewer vectors, more queues) 
implicitly in the driver. But, we are looking for a more granular 
approach, in our case, the queues are grouped into 
queue-groups/rss-contexts. We would like to reduce the number of pollers 
within certain selected queue-groups/rss-contexts (not all the 
queue-groups), hence need the configurability.
This would benefit our hyper-threading use case, where a single physical 
core can be used for both network and application processing. If the 
NAPI to queue association is known, we can pin the NAPI thread to the 
logical core and the application thread to the corresponding sibling 
logical core.

The queues are stack queues, not AF_XDP.

>>> I think I mentioned
>>> this in earlier discussions but the configuration may need to be
>>> detached from the existing objects (for one thing they may not exist
>>> at all when the device is down).
>>
>> Yes, we did have that discussion about detaching queues from NAPI. But,
>> I am not sure how to accomplish that. Any thoughts on what other
>> possible object can be used for the configuration?
> 
> We could stick to the queue as the object perhaps. The "target NAPI"
> would just be part of the config passed to the alloc/start callbacks.
> 

Okay.

>> WRT ice, when the device is down, the queues are listed and exists as
>> inactive queues, NAPI IDs exists, IRQs associations with the OS are freed.
>>
>>> Last but not least your driver patch implements the start/stop steps
>>> of the "queue API" I think we should pull that out into the core.
>>
>> Agree, it would be good to have these steps in the core, but I think the
>> challenge is that we would still end up with a lot of code in the driver
>> as well, due to all the hardware-centric bits in it.
> 
> For one feature I think adding code in the core is not beneficial.
> But we have multiple adjacent needs, so when we add up your work,
> zero copy, page pool config, maybe queue alloc.. hopefully the code
> in the core will be net positive.
> 
>>> Also the tests now exist - take a look at the sample one in
>>> tools/testing/selftests/drivers/net/stats.py
>>> Would be great to have all future netdev family extensions accompanied
>>> by tests which can run both on real HW and netdevsim.
>>
>> Okay, I will write tests for the new extensions here.

