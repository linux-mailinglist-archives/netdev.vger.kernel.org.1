Return-Path: <netdev+bounces-72940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76385A4AE
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 14:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D751C203C0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399B636132;
	Mon, 19 Feb 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk3669/q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FF364A0
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349648; cv=fail; b=qg+DbD6qPeETlRjcWZaG4FnXF4z6ro89uoPJWPkJYJMDeG4qECS+5Vg9zEERvm0iVnc6CPMUUxzDLyM9nifdeEqDmBEaIjsKRHcuK3ESw/3bpeid8TEl5w7rNlnt2h27zMrtFxJPQFiL/wIwK8evGPwUZG2sV5xMxN45RplQuW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349648; c=relaxed/simple;
	bh=XBXL9o7EABWvGk41Ox+G8QqhlMkcRL2/uA796oBTcVI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TzUSSR+Sw+CC7te9fpg/VKIWWFa0bLUigkNFgcgKoXaMp7JSoJMXK8WQ9zWYxgitpOrv3YLmVTJhedd0HO/dElWPdT0ELrtxWzJcL2n6qTbQSFCnAaGYNuPMWYWMdvcdIKSgDNRpStUr+rRH6cbAavs0cfJlTDo6zKr8y/XBGeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk3669/q; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708349647; x=1739885647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XBXL9o7EABWvGk41Ox+G8QqhlMkcRL2/uA796oBTcVI=;
  b=Vk3669/qDbT9cZV3hDpgl9UlwIzU5iZUPSYPKE9NUSnFchUS1upsN67L
   rpONJ8IctWYUstQ3k4w1gS7nUC9lDL/G0AcKnRTPo8Opi6Ik0Dykr8zal
   VRspzFCKxeVH1w+2BjhlJEAjJ8kcb6MvTqaJ8s6snQ8lLdAjco4xlNBAW
   rZEZXZBrpEHtkdxBiyNp0AC/AK9mRsL+LXRYxenT8/6I3cPElq/yg/Ont
   fmwdZFyHdCdmJg+AHXBZ9MzsBE5nCpvar9vLuND+VVJKlmUKMhZ04/s/y
   7zmGyJX5ru9cS4nK0V7FQtfYS4J7GzZdmFXAEEtmQ6KGAgF3UODeqRdtW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2330743"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2330743"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 05:34:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936292076"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936292076"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 05:34:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 05:34:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 05:34:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 05:34:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 05:34:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvWGbPdVE2jii3i+ypNQTOQbBHbPB3XopV5GYj72aHWSzkYYBW+r+UehPSQKmeEtyTSGTQ50iE0uGPd9tiJAdPySR85WWUIme4kwuHFvWQesBeG86DBrTBo66lIQ594JvnK5nIq6XLooL3QeYQqryqr6bcQVyag49z3tuJm8aaQ22HHbEh4nBw82hvA+fRUZqIy7EfcH/1VbnSQGRO2Z4rXxZo5JcNDpkcMk1jLtci3qONSNvpGLp++A+8+nyQ4ym7Hkqr03puIUyJvaaPZ+36pbFg3m2ChMxkg19Kh9qPeu4rvcPRD+RH+UALgoI0ixcLWrjyNEKkwWw1F7VUNPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+VoM6mCw41kw865zX5mDhl9ojIbspcAs4HQue3qgOo=;
 b=h3k551akOLK0aeC37EXGIk8Yd441/DKZGz+JjSTng1dod6PLZ9vC+kPEmNYjf/0b0Gir0MMgjPCt3JNWLNtX2VsH17MMiGUV/beOe5vSkVDn5WTRM3dRaoW2JD+vvFCC4XDqHrtXW+vbCP+qWXghEufGsh5Hw7L1jFoD7g6xTP7INmWuHlFQ6pZzaKTwb5ZU8GBzj/XuFYWNOKMckR9ba6uSoo7ovKUOKhnTGbDnJAxz7b3Ku9GDDOzXKrb5oH0zEDK2JlhtE3jnj2bKZgXjq4Se3+QF9TbZEf03bToX8/R6008JzB5EFV2lGfdpaxFMYsXETPGv5PcXfDpbxwkdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 13:34:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 13:33:59 +0000
Message-ID: <48675853-2971-42a1-9596-73d1c4517085@intel.com>
Date: Mon, 19 Feb 2024 14:33:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
To: Jiri Pirko <jiri@resnulli.us>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, Lukasz Czapnik <lukasz.czapnik@intel.com>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
 <20240219100555.7220-5-mateusz.polchlopek@intel.com>
 <ZdNLkJm2qr1kZCis@nanopsycho>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZdNLkJm2qr1kZCis@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|LV3PR11MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: ee754343-de7b-4f4b-516e-08dc314f6dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5IxzZdn1AfpQwM9DVyEh88fUQX4GsCzl26W8BiVXLye6ef8xySuW4ZsYnNE7lEVYxYvbQTBr3Nk8v1wX4RUwjIHOCI150kA8BX6QiQz8S26RAKFqp5mfAYgctDlBKnThRynqFMiss9iRKyuBVINQ2jCR8B70GTfqqgD/qQ5zC48f0DLVCRgy9N6gFt6LFoUzjO0ONDa20119dLa3SS2nYlMYiuSwcyNqppHZtmA1tWn9qB5HlfRuE3lrCowSFfsFFjhoixkUjA5QBviXY7L71YmW9yVJ9VuEE1frqX5ezhgW+l+TZ6EAB2/BE3n4yP42Pg/Qp/6i1TVjrY34AGEuftdr0mrGUbkgd3YmaSg37gD4xzrAfTgMlvsFklbuKzs7+gbSu0mKph5BHiElfd3i3/LI2CGszEMHRtiBR19tIzW+zXqrivmCah88RGwJhmVxx7qpbRnn9mc31HIhMxtL4AH91ULj4fmy7w7Serc2/IFnxsJc++oKBC1y3wr46f9liPZfTOHEIWLE2f9Sdf6QPsNyhOdarjOUclmwf2KKWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VSNTN1VzJSZ1o2Q25nRXlpUVpsVVBXOE16RWtoaUdpeGtqNVlvMGdHN2o4?=
 =?utf-8?B?WTZjWjlSL3VxcTZXMnRxZ0lrTjhMekRPbXJ5WVB5K2NTWlplbjZHaVpvMUFV?=
 =?utf-8?B?Um55Z2FaZC9iMHFVK2dtUlM0ZzZiMmNZUmgrdFdBYTBKUmIreVczYU5ZMk83?=
 =?utf-8?B?aHpJK2lUQzNyQ1V0MTI3TnpMdjJZTTFPc3N2blozbXR5d1VCdVlHeUhSbVZz?=
 =?utf-8?B?VlhmVURrenBiVndocmludFNwVVVDZzNWMjJiOStpZnJOTnZsMG5GejRTaWoz?=
 =?utf-8?B?aHpIOFRFUE10YzZLQk9IaUZZL3N4aUF2c0htc0VkTG5BdG8rSnFSbjlPTDNx?=
 =?utf-8?B?ekszYjZzNXNCbk0rQUthQ0xkZFVuNGlVb1IxQ2FKN3J4WmhkdWM4MldFRHFT?=
 =?utf-8?B?TlZUOTJxSEJOeGgxRStseTVzT3R6bDZvbVE2Y0k2aHRDWXpsSXNYZEhWNWdK?=
 =?utf-8?B?WjBOZW5qcWViZnZqZHBWbDhmL280MWJKTDJQd09xN21PdDV6TUprU2FIbmxS?=
 =?utf-8?B?YXlLVFA5QmZuWW9JWGhySjlGdDhhWVd3VUxPRkFqTm10Zi9vbkcwc1NnS3pJ?=
 =?utf-8?B?UnRxa1NYSWtCUXpCTnJGUnFlaTRuRmJvVTJEcW1uZkVjeThoWVlWaUtXN1lK?=
 =?utf-8?B?NjlUZ0wxanNqOUhnTGZxV29oVlNuTHA0eHVFdzBhN2loazhlY2x0QnZOMUpJ?=
 =?utf-8?B?Q21HOWFkbjZEajF5c252N2IvN0FGcWQ4K2FGRXFCbG9FZWcyZ01iUlJ3N0NP?=
 =?utf-8?B?Mm9uU3piOGcxS0gyVUVtUXRmRlBmdkdCQVFQbERqajZ3S1orN21nNGNxSDdl?=
 =?utf-8?B?OFNmdGVCYmtWenJ6R2NZNnl1UC8zVWF4dU1oN09hc2EzQUxqQnFleFNaNk50?=
 =?utf-8?B?ZkJNTjlsekY2UVNDVnMrWHRDbCtMakdDa3RSTlVHaXFGck1pUjUzUjNzb1c0?=
 =?utf-8?B?RTVzWlQ1Yzc0dlB0bEFGKzBMYnExcGIxU2d4RmFpdDM3N2JSVk93OFU1VjBF?=
 =?utf-8?B?a25PUElONDJ0aUwrZHFJMjI4Y0VIa0VRcVAzd0ovS08rREZHN1dyRHk4MitX?=
 =?utf-8?B?emhEV0R0OGx5blVpbVF2NE9JbUFUemp0SEtDRTJPU1RRZVUrWVlYa3lpNnow?=
 =?utf-8?B?MlFNbnZYMjM3ck4vdDBlWDRtT2orMmVBUUlLVnZIWnpySzM5WXVnMkhwc1Zr?=
 =?utf-8?B?YmdDM21yWmVxRkI4bDRONkVaZjFBZ2hNT0VzdWZxR28wVmRRMHdBejJzOFZB?=
 =?utf-8?B?QnRFeW9tb1JXbDZ5MmcxT0xNeno3WWNKdENzU0NiRW9DNHYwRGVLOEwrbXdn?=
 =?utf-8?B?dlJERGh2MVNsTmRpL2xqWkVxcTdHMXMwU29mUnhBck9sdGlOb21WaVVCcDhm?=
 =?utf-8?B?QjhIT0Q4VjUyQndNTGd3bmQxdHdON05ETGxObXV0NmU1MkUyMTFlNWpIb2RT?=
 =?utf-8?B?RnVrZXRMWUZ4bzhxWGtMeDZFYU1Jcm5YNmhROEZSUmZRaURIVEhjWS8rU1dM?=
 =?utf-8?B?Zlhvd0pyMUhjNzA0TkxVdHlYQmVuTk5Qa0VJdmpIZEdYQ25qMGVvWElRM3Bv?=
 =?utf-8?B?cE9TRnhCS1lIZjBmTHgrMzcranBUb2FaSEFscVJoQ3NNRTNJZjg3Ti9iZGVS?=
 =?utf-8?B?UE9FSnRjaVVEVnJZSEtzZnhCU3Z6UUNKcSs4eFB4NEpCbDN3dmlEYkxYSzNw?=
 =?utf-8?B?K1dDNGl6V1c1My9Ja0VyNlVSZXVwSGxTdXc5YlgwNVREMDdCZE12d0IzbE50?=
 =?utf-8?B?YXI1RkpJWUFyS0hHeE9UNE5ldER4N3E1VlpzVndtL0V5eXJQZlBidkJxdVlp?=
 =?utf-8?B?NktkN1FDeTN6YWNZaFROREhnNDRrWjhicjJCdkR3VU52Y294Wi9teGVmakRz?=
 =?utf-8?B?TExLZFhkT0I2TkJhSSs1SjVPUGxJYVhoTG5iMFc2QmVmVFZPNXpZZzFGdkh2?=
 =?utf-8?B?NEdkNXVQTFVDelBnNUI2WjNBeDZ3akFIOUUzUXBsMzM2d1U0RUJuRGdKZ040?=
 =?utf-8?B?eHNXbzFGa05jY1RuT0JFSEhVR2NhcEgwakV2aFM2TmkyNFFCbEVsbG1BRHBw?=
 =?utf-8?B?VUJFRjkwMnM1UERsaUxEdERvNzVOdTRNaXJ0NkMyUjRzM0pRTFVFVWhWSWEx?=
 =?utf-8?B?cXk0N0xjcUwwdmVhamtHUGdrUUczWVRiS29PWCtBMnlsb3NuUFlqRG1Qa0hy?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee754343-de7b-4f4b-516e-08dc314f6dfc
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:33:59.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5JAPTj8PjvBYXvUb+EcjGGSqC9af6VZYKnT67nYy9RovJfmkeG/fKQTPIowGjTNEXgm6NyqxYf15/TAtP3GD4bkyBLNScHCGAmcaPEDWJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8768
X-OriginatorOrg: intel.com

On 2/19/24 13:37, Jiri Pirko wrote:
> Mon, Feb 19, 2024 at 11:05:57AM CET, mateusz.polchlopek@intel.com wrote:
>> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>>
>> It was observed that Tx performance was inconsistent across all queues
>> and/or VSIs and that it was directly connected to existing 9-layer
>> topology of the Tx scheduler.
>>
>> Introduce new private devlink param - tx_scheduling_layers. This parameter
>> gives user flexibility to choose the 5-layer transmit scheduler topology
>> which helps to smooth out the transmit performance.
>>
>> Allowed parameter values are 5 and 9.
>>
>> Example usage:
>>
>> Show:
>> devlink dev param show pci/0000:4b:00.0 name tx_scheduling_layers
>> pci/0000:4b:00.0:
>>   name tx_scheduling_layers type driver-specific
>>     values:
>>       cmode permanent value 9
>>
>> Set:
>> devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 5
>> cmode permanent
> 
> This is kind of proprietary param similar to number of which were shot

not sure if this is the same kind of param, but for sure proprietary one

> down for mlx5 in past. Jakub?

I'm not that familiar with the history/ies around mlx5, but this case is
somewhat different, at least for me:
we have a performance fix for the tree inside the FW/HW, while you
(IIRC) were about to introduce some nice and general abstraction layer,
which could be used by other HW vendors too, but instead it was mlx-only

> 
> Also, given this is apparently nvconfig configuration, there could be
> probably more suitable to use some provisioning tool. 

TBH, we will want to add some other NVM related params, but that does
not justify yet another tool to configure PF. (And then there would be
a big debate if FW update should be moved there too for consistency).

> This is related to the mlx5 misc driver.
> 
> Until be figure out the plan, this has my nack:
> 
> NAcked-by: Jiri Pirko <jiri@nvidia.com>

IMO this is an easy case, but would like to hear from netdev maintainers



