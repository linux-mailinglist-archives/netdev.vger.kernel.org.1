Return-Path: <netdev+bounces-86967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B838A130B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBA2282674
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24C1474AA;
	Thu, 11 Apr 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9MQ1eO7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCA145B08
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835141; cv=fail; b=pGisCtpblOYWJOS6WI+F/QObxjN+6sRUC5+VwD67IEPT0FOmXZzt43aj2uVxkm4hdIrLOqi+nn45Xs47YQxotqFrdprQQ8dKscuggYB8l5PAOQQgRNtFEkNgT4Z0pW+h9hXkKKS+oX7TWukmoMdV1tn+q14m5E+PjoFN39A7Upg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835141; c=relaxed/simple;
	bh=oV49X0x5DrIpYkH9umbvFLPiHWGDT+j3aB1dxQHpxOw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BhRc5cmB67s3U3AG5m3BoIBSg1JpJk0GhLiLQ4G+DHmGVz0XDkMm8vgiiJf5/c2If7V1lKPTweuvTs3eh0Vfm44FiwAK8UHcrd0TMj1uj2ezpZom36efvHNPj6qwFXgzlK9zHWcZONmcMrQbLvcvFblOgaLkaPGvysegLY2nLZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9MQ1eO7; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712835139; x=1744371139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oV49X0x5DrIpYkH9umbvFLPiHWGDT+j3aB1dxQHpxOw=;
  b=X9MQ1eO7sxeyDbPUO1E2AJ/WLQ55ohJCgx7ejH+feH/P3WR7jUyo7wxi
   PRaYpyIM5L8q6j4Np1IBIAJSKBrapGnFfsr8rGu/zQaAYaHf5Mc+dt6TE
   bVsdsrJLM7kdWMEL5oQjz54Je4K8aEEEjse85h57SJq4xjn11XimYBkRD
   ke1kGwZZZSO60Oy8dyWJ2TvV3TuUtTa4PvnsVtEAX3ZFPtq/ghdvyJ7DG
   QsThizmL4kDe3IcWqrOrjGisMbMIi/pE39IPLWl6KRBXH6Z7QyHfCKy20
   zK87YeNj75TWa4Hx/Oh82LjHlqd6GrIDPjFVhIJjzrvkGEDal0nx5Ygc8
   w==;
X-CSE-ConnectionGUID: E5A5xdvMQnGpyuySBnrUJw==
X-CSE-MsgGUID: Fa38RPvXRAC35sibvFcbAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18947061"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18947061"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:32:18 -0700
X-CSE-ConnectionGUID: iHMvCnxHQqCNuKmVnGzBhw==
X-CSE-MsgGUID: X6MvUuBpS1aW0m303li6iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20878326"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 04:32:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 04:32:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 04:32:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 04:32:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 04:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP69RROYS7avrxfcLy6HabE2iESFQneipYmwJ9zQZBgRLD7Na3Ofy/WFfhMO71cskzPgpibQu9L3++Nq+QrbShJaHJ802pelBRECtrcS/lR3V02XOsWQnHvCizz9VKTaL1ykPRjjfkAP8gbpBR6GlkAL/zdFm8SaPXHv+3JEQj9lvzf8r9kWhpgy+RYSYGOLY0O0lvLgEWTWofiIXbtITj4/rxHz/oxE6n/7nVIkWehAjeYPPDtAdxir/d6Omgj5oJ5ZMeUa1bmtzLJ94Pww+kdQL1UeEN5fSgs4h8+im0j6ph6i8VX+DBqL61n7knigv5kyLIrC12WaDrdBybLhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qzPBvCfXnxfthGWmEP85uYXZAcv0vqzvgjSnTpbRYw=;
 b=Y2QfCQU3oxzDDzSdyCN1oq/weS+B+7pR6KrwG/ovGSBEikF25rFAKJdL+szaMKUhwz/ZVIK7fPXXiMY679ljiyowYVOBRHxt240ohOXojlea4SF9vzVWHg1P7TVhBDFd2uVF76krzHxYxkNxj8A6jzdH6EtQ4qK+xRFdYwBUu0gb3GzyafAkpCxwf0UhEGFctiSKI+WcdsscDIecJuJ0piVDKpotINBi+8UP1AqvWPI3rXfdT3iqZ5bezNxEUS94qieS4DBAgpwGg1+HG28B86VdKzyJwTf/P6/yCkaVWT2IF1JlJKVStnezJ9ZVn/N2S4jVVVotYTJ9xKXfEtC9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CH3PR11MB7893.namprd11.prod.outlook.com (2603:10b6:610:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Thu, 11 Apr
 2024 11:32:15 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665%4]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 11:32:15 +0000
Message-ID: <94297026-c760-450c-aaee-ad0034c1431d@intel.com>
Date: Thu, 11 Apr 2024 13:32:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/2] f_flower: implement pfcp opts
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, <dsahern@gmail.com>
References: <20240410101440.9885-1-wojciech.drewek@intel.com>
 <20240410101440.9885-3-wojciech.drewek@intel.com>
 <20240410085319.2cc6a94a@hermes.local>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240410085319.2cc6a94a@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CH3PR11MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 19364ca5-5833-40cf-2c8e-08dc5a1b099a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uogyIzTzL0dzeNxxWww6VBHVWue8Suuv5IaidjdTTdAfvvJQfLETIMg9LnTtjnfh0SNScycVm9kHXmfW6Sa+W2g6MIJ4hX1PrnJIluojftr1xxRlPBHyQm7qSsWWRAdmpVHtN1Aw2EEK5JlgcD2nrc/RKFZmJrU33yGUmVFO4N3eC+4ZrodgO2nLuo5S1HkzWqw3Xu28xeCuRIH2QePvhUh6DGoZhubzJ8PCJw2pwdaFKzhiTEg5U2DkRQlWFmSDWN2u6OGSdkVqOQtAaHaFumT77xEOVmiNe9AtCT7/EjCuGWm1oEEec/fzBy9YD3NbKXyFMEub4xH+NCkfLaxD5GENQaCAjJQQRJr/tgsK6Ad2eMTuZAX6s0y7TxXLgM4A8ZW0kGwGak5dGI/MS/lHmm1VAzjv61gJhfPeTdbO5UEZGiaB4f6P3qiGokRixf2U4rYvwOXnSvIWTKFXluCSSI+6tIv8x0/MCx8tLmYD7++sL0/VOvGyeaiXWta8GY1w2HtX9rSp5t3lnIv8ClyZ5HgSP/+eg/S164sb6SjYL3Q3kVoUQI+kv00Lze6RZhwkaFCmlyE7FAuITdoH75m557JiyXuqr12apHzf8Z/XHXrnyi20mUej9v1y/BaQjpaH5sNPiexV2Nxuttx9GAmsn0sgC5ukgUWHhRAkLbEkdc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmE3czVFeE5UUTZwVWhsWCtINWQ1amk2UnR0aGdFTk5WdmozcUpQNW15aVhS?=
 =?utf-8?B?Q05zNmZpeStxN2p2NkRrMzdreVdJYnlLZVlwUk92MUFhVGxXZWV5dkdNUzM1?=
 =?utf-8?B?eXRtUHg4V3NuK1NGQitkSmxzQnp3Ly84SHRZQjJhNkNOQVNJblBiUnJMQ1Z6?=
 =?utf-8?B?RGhGemIwZERkOVNNTy9FdVQzS2J5SHNtSXIxWS9SWHdhMzQvbEkrR25SVkhw?=
 =?utf-8?B?VUV6TU51TVFxYlgvWW51VVBEMWZETDU3dU9TTTRGWHBTYm96UmtldTBIVXVS?=
 =?utf-8?B?aFNLTGQvNmtKKzh2djhYd1ZlVDdVQ294NVMrdGNqTUZRMlIyU0V0MXFNRnly?=
 =?utf-8?B?azNvemNPdXp0TWZZN0VzV1VIQmZmbkhmMkgwMC9aMVJ3Yld6dHJ6VTlNMmtG?=
 =?utf-8?B?dGlCZE9ET1NjbFBlLzZ2bnRZWk9SZi9PcDE1YnhGaTN6TnppdzVwRDBEdld4?=
 =?utf-8?B?M0hOMkVHNFY4dFNRdVAvWHI5L0lNdWdtMWs2d0pnWWVTdkpOTUE3dUhTVFdY?=
 =?utf-8?B?eVhhMFdtWUhtLzVpd1AvMS9Pb0IxMThqNlkvZUp2V3ZWdnhwQ0svZmx3ZEtq?=
 =?utf-8?B?YUtmTWk4SmUyRjhZdVNHejR1d3JaZ0FRTnByZTVFNUJRREhtK1ZQS1ZvYVcy?=
 =?utf-8?B?bUR5L1k0eU0yNDVSb2RFVjhWcXBQSmZuRE9GTlpQeExrTTdFZE0zaVBPUGFL?=
 =?utf-8?B?TExOYk1MVGN3Yk85TDZMTHZ3VXVXR2pZK2ZEUHlDb3F1dWxra0w0UlhNTDhW?=
 =?utf-8?B?dHpzS2FtNXBYMjJFdWx6aXlmRkFPYUtLb0xtUUlNdC9jKytua2FoNHk5UHFa?=
 =?utf-8?B?eU9Wait4a0lHZmlCUHdtcFVNZUc1STY2RExLd29sYUlLd2Uzc1BVckVXNjF3?=
 =?utf-8?B?NXdPSXRPbmUwUjBiV0daNmVYdVViMmxVdzR2L3ZRaDZjRzNOaGIveGwwUzJL?=
 =?utf-8?B?MVM1cXptNnA4SE9qMlgxUFhRUmI1RUtWOGNUVXRoMTIya2xkdlZIb1czZ3E5?=
 =?utf-8?B?elZZOE94MEpBVjNxdDNyU3pFYmtVWE5PUU5ReFRPdVllc1B5NVJrMGM0V0di?=
 =?utf-8?B?eTRHejZBcVl3emRvRVlzQlN3MDNyQi9OTU1UV05EWTdzT2s3Ly8rWng2TEJP?=
 =?utf-8?B?VDBzaThYdzQ5M3VWSzNlblJwUE9vYUowYjV5UEtMZ1djR3ExZHphYjA2Tlkw?=
 =?utf-8?B?N09ObG5FbzkvRXlHRnFsT0NmaFpYcFRGc1FaeUNUeC83bHVBaUt3cUlocHJs?=
 =?utf-8?B?MDl4d2hzbFhHZ3hUd0l4S01jbHFvL2Z2MnNBU1FXbjJ6Q09VclBsTjhHajZC?=
 =?utf-8?B?S1ZmTm1Pd3J4cGdCYmxRaElVOExyUUZxNlM4SVRDemw3V0h1bU05eVdyUE5r?=
 =?utf-8?B?bmJXMEZqOUp2ajdUUG81WmMzLy9GVlFSUVk0cjBYeG5FUWxuVTVYVy9MK24r?=
 =?utf-8?B?aVFmbVF4SU9mSnVZdThkd3Y2dXQ5Z0xxbG9DSjRjbUh0cTkrU2pwaHQ5eXc0?=
 =?utf-8?B?ZXM0N2ZhRWRxWnNpRTZmenFTdHVNZWVRYW5vKzY0azBqQVUvSWRJRmlxUEtK?=
 =?utf-8?B?S01zcUh1TjhRcEFpUVZVbjN5ZFNLRUJUL0FaaWxQNSs4Um85bFc4UXM1S1Z4?=
 =?utf-8?B?aUYvdjNlNTRiWGdEeFBjaW1XNWl1dU1FY282Y1FQeE1FTTAxclkyZ0ZjL0pj?=
 =?utf-8?B?M0cyQVlESTBuVU1YZUE3RFdZbVlJTkhRaTd2REIyaDFRSjNTalFocmtjYjR6?=
 =?utf-8?B?T24xcXUxVWo3eDRBditpcWNOWDdDWnVyQjRrVno4dTQ2WUpJbXJtMTZzLzc0?=
 =?utf-8?B?Ly9KY3B0WVRvRXZmdVA4VGJ5NTk1d0ZsZ3lKYlF4amROSlg1TjlFNEFnUUZ3?=
 =?utf-8?B?L3plVWxMNUYxM3RmaW43eFN3Zkg0di9KM2Z3SDhyZ3RwanNCeGdIWUFwSTRZ?=
 =?utf-8?B?ZmFTTGlUZXlWRE9mQTZXQjRZUzVtaTJ6OXNmbjJYemtONVM0SGNWOGVTNXlv?=
 =?utf-8?B?WFhQamg5cWRMMGkrYUV5QnRTYW1WL0RkaXNCd2NJTEV5TUdQN0MzZEs3Q2dr?=
 =?utf-8?B?dmdFcElQcUN6TWQ3bDRUc2wvM2tPczBCSnhLa0xIWk5CZm9DK2JacmFzTmlj?=
 =?utf-8?B?cHBOS0pzTjBOM1ZlSWJTU2JIbWJ6dUVNNDAvOGZhZUcxZllGM2dVV1ZPUlp1?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19364ca5-5833-40cf-2c8e-08dc5a1b099a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:32:15.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79OidNsiOBkZVexooD/fPPS1ZtA4/lrF0YNmkrdC3HjEfWg3ES5Jy0O/DCm1DLFZHNLob876bjtnQ3B5pwY5GP8FmQM9waSsO3HETZ6Sru4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7893
X-OriginatorOrg: intel.com



On 10.04.2024 17:53, Stephen Hemminger wrote:
> On Wed, 10 Apr 2024 12:14:40 +0200
> Wojciech Drewek <wojciech.drewek@intel.com> wrote:
> 
>> +pfcp_opts
>> +.I OPTIONS
>> +doesn't support multiple options, and it consists of a key followed by a slash
>> +and corresponding mask. If the mask is missing, \fBtc\fR assumes a full-length
>> +match. The option can be described in the form TYPE:SEID/TYPE_MASK:SEID_MASK
>> +where TYPE is represented as a 8bit number, SEID is represented by 64bit, both
>> +of them are in hex.
> 
> Best practices in English writing style is to make all clauses have similar
> starting phrase.

pfcp_opts
.I OPTIONS
doesn't support multiple options. It consists of a key followed by a slash
and corresponding mask. If the mask is missing, \fBtc\fR assumes a full-length
match. The option can be described in the form TYPE:SEID/TYPE_MASK:SEID_MASK
where TYPE is represented as a 8bit number, SEID is represented by 64bit. Both
TYPE and SEID are provided in hex.

Does it look better?

> 
> Existing paragraph here is a mess already, so not unique to this.
> That part of tc-flower man page needs some grammar fixes, as well
> as being broken up.

