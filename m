Return-Path: <netdev+bounces-74035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC8685FB5D
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3CEB27A5B
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2562A1468F7;
	Thu, 22 Feb 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKzQfbUO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F93E498
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612534; cv=fail; b=NY4My4YIUPUIiBzBWtMQ9VrE6q+1TWdHrdqNu6lpVuQFGPeJzpJWUDG0u9CHRGGBk2eSC9imSa3hDW7pJkqEb5KXOlKH45J+tuLMwuVM5vmEBpP1YavSPKtVCFXwlC8l24afEMpTSVV2Xu7NuHG9ImvSVJVT7kYdrGYphmXoGm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612534; c=relaxed/simple;
	bh=Z4dIlPmnjDTEYV6Db24sKKQYkTtptjg7d/SO/6rjNo4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCXrabGiswOrzrptKAesWrwMZ9MkOgz0DXPre947xWlznVaNPj+iELFhosgH5zTzsnq84uQHcpx1pr3HFA4JrvgAR4aooQ67qNbRMKOPfi2Ll3/lOKu2eNUlwT1M+Nsr7b7qKktJ52JytIuWoXLFbJ3qkvt/GmW55ZjytgNbOE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKzQfbUO; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708612532; x=1740148532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z4dIlPmnjDTEYV6Db24sKKQYkTtptjg7d/SO/6rjNo4=;
  b=YKzQfbUOQgtiZZDdWGkE1iYPMXa3CfdFOGxhxm+dOK8ZMKSOsqj+5bB0
   I+1jy/Ym52hHvbiAa5oWyshjFLLl1jGjeABLzri36Bn+o+PTjFkhiGHWz
   huUgXx+05RgXa1OmrjUXlSkC9b/xS9a5KiT2vfbc3cdyLsFd0Z/KPI+60
   B/DkFAsJLJI4dKamudEaoGWtwRmh44FPJ+l7ST3fP2aPwpQyaOCgcZKUM
   bbq7Zx7VkeVSV1UI8StGHlkmfPs/wAvTA43u3o5p3muwJkIFGBD13QzWl
   vRFwLokpviZEKSI+evAO4g6qG2B82arcUKyG2b84/T4SH1lzqBE3u1Y3r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2712742"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2712742"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5665223"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 06:35:31 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 06:35:30 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 06:35:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 06:35:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 06:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThVcgzo3NaB7I0P6cLb1IWOjmKVIC4z1K/DD9+tm2qFKzQ8PJyp46USIN/FscKttgB+KCeSNpQXdmCHqySO4el+/mpMPUf5JSXfLmF8mRsKLfu2ZWAFN3wdoxfJLC8ZtwpHsdEM2n2kvFCleJYryrPc1RqNezS8ldUDp+AyX8FRT+gy8lgv0zw3WJI1hVvUqDY60O//2Azh1EgXQRLAqnSJXsuyCQWktSsxDy44iFVFv6vuiSOKhhdH+uUNTMXCoJAcOe8Lh5pCL0Wxrzl2DUqDFUL3845MuMrXo0Zl1cd72Jv90uvgrgwopkFkToTMJ57BqGHf3WJXnaeX7+bGbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLEwsYpMKzH7bj0D0xneWf3gul32QJ126a+N9EedmDg=;
 b=X9EoozEMpJO6+sZoHlEhDFEle1wckYKxE1SPk+bb4G+5nJBBjkioVJCGVzMl6rtN6BQYNaC0VO5zaeqgsN8pIbweLtt29AkvJMKfpy1l4PNKYg7ieZH3WwywUI+8K/t/M0dlnX3lsT552JYISzbgX4OYXq6rUW7pjKiSrsbz9nuiEDicVXxm5QjmPq5/v46rXyASlx16/chtx7Sw1h5qG4qg1zKvjwTjdvY10xJrj2EoV0Bg6NoaDCWHVVO27shbEM7KEgUZsLp6gQFojA2jM99KFfpWPBsArsZgYW+vX/BF3Y+WHlxmISi7e2IwMF/OamrUlAgKkUauy99KCxxQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24)
 by SA3PR11MB7609.namprd11.prod.outlook.com (2603:10b6:806:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.44; Thu, 22 Feb
 2024 14:35:27 +0000
Received: from CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::a8a4:121e:2b2c:7037]) by CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::a8a4:121e:2b2c:7037%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 14:35:27 +0000
Message-ID: <39ab0807-468c-438a-bf56-7dd1298fecc4@intel.com>
Date: Thu, 22 Feb 2024 06:35:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10 iwl-next] idpf: implement virtchnl transaction
 manager
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Igor Bagnucki
	<igor.bagnucki@intel.com>, Joshua Hay <joshua.a.hay@intel.com>
References: <20240221004949.2561972-1-alan.brady@intel.com>
 <20240221004949.2561972-2-alan.brady@intel.com>
 <369a78cd-a8ed-49ea-9f89-20fea77cc922@intel.com>
 <52fa2a08-b39d-4ffe-80da-c9a71009a652@intel.com>
 <7baaefa1-cd27-4dc7-aa2d-946aa4d225e7@intel.com>
 <9f4d0449-9995-4bb0-bd95-f12d9bc0b234@intel.com>
Content-Language: en-US
From: Alan Brady <alan.brady@intel.com>
In-Reply-To: <9f4d0449-9995-4bb0-bd95-f12d9bc0b234@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To CO1PR11MB5186.namprd11.prod.outlook.com
 (2603:10b6:303:9b::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5186:EE_|SA3PR11MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5a1485-1013-4be6-e05a-08dc33b38357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCt6NLWVaTYw4Gh+FKnYrTi2pytF3UeLAFOquwFCDjolaQAGEIM2U0Zj095X4qN6nzZovmBLGHgNUnxwuM5GaTwbeg6hvGOBukF/c1Lw+r6alAtq2t/rsAlgo7NHfkstn5T3Vgpf0JKFLtqEsAf5/lXlkPV0/QLftzaJPV+m2ND6SklW/jPfyexl6cr2k0gT+2MOVF1eoAWcnql62+3pbNhLsknqpq+4V/XbGg9W8w0opB9RXxPbjWm5G5zfwqKMnCwJJR3RmNGxRtRHQMoQuoVNP453SwneFqPp9n1e/a5LAq0lPUUWf+YDvEwLTazFqoGvVzhi8sf3OFazPCEovhkJbWuTqp2XPQoY3ZPSK3KTll5O43Raekd+ogKc/IrimIxD5umlZFIG2eZ8VWBKy5bUBnF0eidBJMPv4lyxzWiI1BIAt/eTwa1nstIBPvcfq/oR+0P2IOMHtK/q9IeWHOpE0LZlua92YsIvkl/c6z3G5roSZm6F4nWetWOhRZMMVfC9rF02DWXQO45cMQ91Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5186.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZ3WCtpYmZITnpyVEhkTjREZjRPYzJmOWc4TGZhUDYrak1yWG93SkkrS2lG?=
 =?utf-8?B?VUlnRVZ2Q1hreE9mZUZBZldrVWpJOVpvRDZxUjJhVCs4R25uYzVOa1Q0R09H?=
 =?utf-8?B?WDAxb1U5dEQ1MGE3dEdXYXEydkxlQXpwaUhXd1JUWlZyTjZDQmswdUZIak41?=
 =?utf-8?B?ajNsWmJveFE3UGxMWFdtZ0JnalNjaEJBcmI5TU8yRytCSDFzckpVbXZvVlRu?=
 =?utf-8?B?SXRGYUEyK2FnVmFUK3ZLd1pqOHpNeFZPSVNjNkRSQzRBY2tGbVRkSXhtMHYz?=
 =?utf-8?B?VUNZUkZWYUdmeHdBMnQxSXpVQ0pUVGs1UjBwNFpocDNlTVY0T2NkVlRNZUp4?=
 =?utf-8?B?Zjcvc25TVDFobzE3VnpyRnZLcCtpdDFaeXFBSXBEQTRxYVJENm1QZ2FvQTYz?=
 =?utf-8?B?TW5TSWRBU2I3Y3diZDYzYjJXaGJtc0FpNlFGYUFvZ1lOZnp3L1Q2WDEzNGZ0?=
 =?utf-8?B?ZWlsaUhNdGpSOHZrTnhPam5lWm02dUdZK3JXQ3VhcUl1dE16cVV3R1dza0dQ?=
 =?utf-8?B?OTlGdEp5bllEK1QvMnhVN0s5eS8relFQdk9jL3RoLzE3TlU3eTJvblJ1dEk5?=
 =?utf-8?B?anllL2t5aTNZVTM4UFl6K2JRdXBPSk9xSGJzNllLQ3VCU2lHL1AxNzRKZktB?=
 =?utf-8?B?L2MzYUV5My9EanE3ZTRDOVVXdjNWVGo1cUQyUHpnV3FSb2ZXOUtWTmpoQjI4?=
 =?utf-8?B?VjVXOTVtQmd2RTVxYThiYzhyUUNzSkUyS2cxODBQaHJ1cEVuTXhLV1pJY3d2?=
 =?utf-8?B?b1ZPNVBLVmdXM0FjZ3V4YmxROS9waHNOKzBQK3BSTVBYUXFHemhlZC9OTm9M?=
 =?utf-8?B?TGtVb3RwSnpmZVJlYmFlWnhUeko1Q3crZEN5SGREMGdGZWxJQnppN29xMkVj?=
 =?utf-8?B?U3cvOGpQalVzdDdXWkw4YVByb0RHemJNMGNTdmozU3IzYXdrdlk1aHFCdjBL?=
 =?utf-8?B?NUVmSEZrVEUxd3psZWNSdkduQlZiWkFLV1lsd1Y1cXpjbGNMaDZBVmhEZ2pv?=
 =?utf-8?B?SlhQSjhJTjNkUU16YWlKTjhISFVCV21BS2RheElNOTVMb3dVSzh4eXFSbTl6?=
 =?utf-8?B?Sjh6ekNJY3c2UlRUSmNITHY3UWJDRStrTlZBTmJhT2JSVE9sQkJiMG9oQ0du?=
 =?utf-8?B?YTFpcno4aDlPZXgzUUxVc1FGaEdRWEcxaTIrVGl1NWNSamRMeWlqTHR6R28x?=
 =?utf-8?B?enJKejVta0hpNEVnNlg4blpvcGIweHNaU3YrTmpRR1UydXRVdFViNnh2cC9h?=
 =?utf-8?B?SmlodjR6Y2JObmFETkpHWVRUN0Jrcml1VVNKdHo0M1ppRW5ZQWNBQlVUclBq?=
 =?utf-8?B?QXlqZHJoOUZJeHFoSk5xcU5mcDRyb1hLeUIxWjZ4aml2RUc0YmpYR2JUQTdq?=
 =?utf-8?B?akdjaHF1ditObC9taUJmcFM0R093ajRpaEt0ems2QXd1N1dpOG5TYmhvNmRX?=
 =?utf-8?B?bjdsb3NoQkxpQjdVYzhwSDAwSnZDZ3RUVUF2MDBpOStwVDRtcXBFRFRhWUZU?=
 =?utf-8?B?Y281UUV1ZTlmbnpXcit6L0drb29mYVJ5YURhOVZyQVV3bHdrbnhuVVUya21E?=
 =?utf-8?B?WCtjRHRhTWNTTUptVnNDOWxjVEJEbS9tMDRpTG8yWmtrR09KTGg2d1BtMUdr?=
 =?utf-8?B?RlBRZVhKMU8wSTdLeS9BNGQyeGdmMk9ocXFGNURDcGgvSldYbEJLdjIxWjFQ?=
 =?utf-8?B?b00wYUozajdLV2IzcDBlV3Y1WlI3OGhHbW1NL1pqeEJvNlM3eDBNdTlSdk1n?=
 =?utf-8?B?K01yQXVMVy81QmxCMFgvK1pKWW4yNy9kcFB0NjFVa042d3JzQ2JNUnhUWmlP?=
 =?utf-8?B?UG9VVE9MZXRmUVAvNU54cWJyd05YR0dhODFySm1sN1VWYWM0TFU3TmxIZE9t?=
 =?utf-8?B?Z3lnZENSeEk1VDgySkxvYVF2dnM1UGJHdUtxTXc3cEUwNm85aWttUUpkVlk4?=
 =?utf-8?B?WUp1MjZhTDFVT04yRGkvTWJXbi9uRGZ4aWVLNzlTeThTcStERTFNdGdRQU1N?=
 =?utf-8?B?anRvdW1IOHBiMGRPOEtjQVlUZXMzU2ZmVDJvUm9CcUt0Q2VXKzA5YXY3a21P?=
 =?utf-8?B?b3RmaXB6S2NlbnF6VSs4dmVsWnZzQ1ZZK0FVODE3djhYZ3ArN3R5NWtxS29V?=
 =?utf-8?Q?A7Ou+Sq84kkDP/8gDYf1BrHlN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5a1485-1013-4be6-e05a-08dc33b38357
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5186.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 14:35:27.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2Z7TwFBAE62eeKdUyZKIYMBaMbzHO7ALRMgjKs09TtiXK4pRdPV3MPjLAL69D93B98QdKhmx4Qj6ZnIKp5iTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7609
X-OriginatorOrg: intel.com

On 2/22/2024 5:04 AM, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Thu, 22 Feb 2024 13:53:25 +0100
> 
>> From: Alan Brady <alan.brady@intel.com>
>> Date: Wed, 21 Feb 2024 12:16:37 -0800
>>
>>> On 2/21/2024 4:15 AM, Alexander Lobakin wrote:
>>>> From: Alan Brady <alan.brady@intel.com>
>>>> Date: Tue, 20 Feb 2024 16:49:40 -0800
>>>>
>>>>> This starts refactoring how virtchnl messages are handled by adding a
>>>>> transaction manager (idpf_vc_xn_manager).
>>
>> [...]
>>
>>>>
>>>> Sorry for not noticing this before, but this struct can be local to
>>>> idpf_virtchnl.c.
>>>>
>>>
>>> Nice catch, I can definitely move this. I'm also considering though, all
>>> of these structs I'm adding here are better suited in idpf_virtchnl.c
>>> all together. I think the main thing preventing that is the
>>> idpf_vc_xn_manager field in idpf_adapter. Would it be overkill to make
>>> the field in idpf_adapter a pointer so I can forward declare and kalloc
>>> it? I think I can then move everything to idpf_virtchnl.c. Or do you see
>>> a better alternative? Or is it not worth the effort? Thanks!
>>
>> Since it's not hotpath, you can make it a pointer and move everything to
>> virtchnl.c, sounds nice.
> 
> Since you're sending v6 anyway, could you maybe move virtchnl function
> declarations to new idpf_virtchnl.h to make idpf.h a bit less heavy?
> Something like I did in this commit[0].
>

I can certainly do that as well, makes sense to me. I agree idpf.h is 
overloaded. Thanks!

>>
>>>
>>>>> +
>>>>> +/**
>>>>> + * struct idpf_vc_xn_manager - Manager for tracking transactions
>>>>> + * @ring: backing and lookup for transactions
>>>>> + * @free_xn_bm: bitmap for free transactions
>>>>> + * @xn_bm_lock: make bitmap access synchronous where necessary
>>>>> + * @salt: used to make cookie unique every message
>>>>> + */
>>>>
>>>> [...]
> 
> [0]
> https://github.com/alobakin/linux/commit/0c8fae557f4e6ec1ae4353a68c9c5c9c2b70c5e9
> 
> Thanks,
> Olek


