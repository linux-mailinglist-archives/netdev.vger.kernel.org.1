Return-Path: <netdev+bounces-77958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F178739E9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F591F21C47
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D16134404;
	Wed,  6 Mar 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJGq8Ykr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8850133981
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737014; cv=fail; b=Mk8CYjcyWQ1Q859fHqBqXkX/hjqX7Pn/jlA5QnObd0f+2xc8IoNLCWzb4KUf7OnRQt3zrlYaHz3wUYqhZLjs15qHatHR2P/z2ORQjeBfT+aMrTowbAjaNh1nN0Oi10nHzBqhBU2V+ss338R/p+QWxl4X3ToGnSzOlW3JbVTrCgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737014; c=relaxed/simple;
	bh=xwn8fTcOW3GwujOPLqCJTe/KxWLeu91ayKyu8bgFsGk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AxhyCmXgwre3Qt1r9rOvCtqvkExla6aUScoGdkelHZJsUf4l1i3ZUYNvlTZGxIwKRcZBxNaE0A9sszsnb/0YkP3ETCGeyZU4nCPYraDX+oOI8wjm8YyVHz0jOtlKaTrf95oq+Q7WKz1CqTUYP00qBOMvt1/JRcl4iaS/mK9bWRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJGq8Ykr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709737009; x=1741273009;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xwn8fTcOW3GwujOPLqCJTe/KxWLeu91ayKyu8bgFsGk=;
  b=mJGq8Ykr6xi47m22B5wyfxq77FL0wfGsXA+zlcAgvJu42qVcuZo6HyNf
   zRYTjdHwFLXZMZc4c3y7ZdtF/sVSin7shqaV3egdHsfW7AxgG6C2yUpd0
   Z2c8p4kEAjiuJefCuKEGcevyRMrZaz30Z18HogVKh4Q7+OHDVdnPqEVJZ
   oBFmbyyOR5O0es+CgMClPbbdQ1jE4PwbUXPPlV9StTQZDwcUxVRtGFcEw
   JxkThcjwwYKCSG5+3Wgl9Fzefx9ZUxA/gbZHZPS+BL89xbO7tOLe/l/Gx
   VARfpcquIKBNcc8J1DmFnqTx/sk0ItQHixoM2vblhrAK7365NVdRqCcIN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4282856"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4282856"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 06:56:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="32927197"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 06:56:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 06:56:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 06:56:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 06:55:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnlbtYJ0+SWkRc19AQmN19GlmXXAVmR76MDah48QVZ8tMjIo6a95WngZI7L8BypHCUaQ1XyzMHd9RH64q+E/W61QXKXeWQUN5vUfiTJikc87RJbwmmynqmXCIO0JytRaHa1szMTE/ywh00Heh9hmiRPXqnUDVBfj4AiXN+ydqckPXb8bWbWUuTyeYolEz3EnBXL5Rq+567ByYvcbN7jbUOndeNHZuPXrfMEEWNuIrrehwVjodSuteZq6/pTPx1VcmYxUj6gMKoLRV0l97L0bzQh2OBWpT35bQAaDdMZpKnp8JAJ8hXpv5X3Vg22LFPZKI5WSbpfhlIvdEwadNOitOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeEevyx5t1kKgd1Oggrtuh7cr3OHB7iSb5CT2mr+4vA=;
 b=KgKvlbEDlHl27wlTau53KfYhxYaYEfR8SKkTx5rRvcsB61izgNxZLEqP0w8ENPC5rrqPxJf6D9NV1CD7tbNC/c/NjfTfhrqXI1chbw5bPvKbutmju9yeoMENyPabTxkVgcUhPKPbovWRZaMVD0AIJRDOItFzpACG07rWRWPcAtji6bsQlyuR0JdiKEvxfeQOacXv7n+a4+fmSEwRSpGEV89PU5PBmvUfuXFv/n9LdL/Jxnb7PMCnAtLeKkou08WTZRNTbXIUlYl2oaE9RSKYZEjacu8prRcyR4vysXjzK6KqmtXDG9NnJ143iEBt/uuPHXTHQC8X/nuiPHKftsl31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6801.namprd11.prod.outlook.com (2603:10b6:510:1c9::8)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6; Wed, 6 Mar
 2024 14:55:56 +0000
Received: from PH8PR11MB6801.namprd11.prod.outlook.com
 ([fe80::f86d:342c:4802:148e]) by PH8PR11MB6801.namprd11.prod.outlook.com
 ([fe80::f86d:342c:4802:148e%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 14:55:56 +0000
Message-ID: <0056a010-4fd6-4300-9790-649d820a5a01@intel.com>
Date: Wed, 6 Mar 2024 22:55:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Add switch recipe reusing
 feature
To: "Sharma, Mayank" <mayank.sharma@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Staikov, Andrii"
	<andrii.staikov@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
References: <20240208031837.11919-1-steven.zou@intel.com>
 <PH0PR11MB5013D1C2AD784512CA70173396212@PH0PR11MB5013.namprd11.prod.outlook.com>
 <IA1PR11MB79422EFDCA5CDD7EC60125C0F4212@IA1PR11MB7942.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Zou, Steven" <steven.zou@intel.com>
In-Reply-To: <IA1PR11MB79422EFDCA5CDD7EC60125C0F4212@IA1PR11MB7942.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To PH8PR11MB6801.namprd11.prod.outlook.com
 (2603:10b6:510:1c9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6801:EE_|DM4PR11MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 20018908-5784-4229-3f6d-08dc3ded86b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woIkADbuVSauyUkLG7VN06NSKoCAF1pQ+Lap0/q1XaetW5Bprd+YCoCsKiiSrs/NaHgmSmIa/0IEt+GgaDya+O5V0oOcYBsiYWMj+5yEDxhac8H8LdFlSBkpEqFkytTLOTz0r3arZnk01l1mSCnIs6Gstdjevi2W2L3PQ5ZbRMM9q+VLKKABJIGuS8bXVNOONuhCyHVm32BsvislR7hYb67OaO0shmJwUQvn/wE7ZPpZACOFmahh3kx4lyhnEGmYuFOmEFexX6/QRasXDQaCf2j+D1U6BALdbF0OPIL3IoCWmJWGaicxS4EDAP7SxKcZnPrdk7fbrMHnTJUGvO3fOfRILzSqWerGNTxGj4NfVqQOpIkKTvkCvwA16kMJ0AFUz2im9bfQX2GeReqbLrOxFCIEz9ziduh/avdI9rcuojJUCK7bbviFPcxScHhYlqia7mNiJPHu3PQ+KV+u4JrXuJ7Td3pjlLHDE4dW3AgkR8iCJiAHTTb4pWXb5v12zXpdqQTf1ppdUl7AHcNJfhUpEZiqBB1vfrWKeW8dBoEZhjaMAFEc9S8agfkgQmeVyrQWvuEdMVz0W0MQNVbpXlpVTWfrGzAiGas/JbR8IhNwz1XpW7Xb2iwYZeH5xOqKy0Q/ryxbCL7Hq98FpnHGNEXUoc+d2KrjcEoQjMkdbH0hv/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6801.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVZRYU1pY1FCdlB1dkVPU3ozYUliRW1yZFFWa09USDZlOTQveUdleFJqeFBU?=
 =?utf-8?B?dHVrd3ZYa2ZVc253eW1TeXdFSWxtS2d4dnB5SnRBR3A1OFZndmdlL0Ftblp2?=
 =?utf-8?B?ZDlRVTVtVXlLSFJnd2JyVmxOeVM3R1BOQWRNeFcxUXdnZm1PRTZiZjRxdW1C?=
 =?utf-8?B?dHFNYy9BK0FBSER3bVErYmpuSjV3RG9NQnNhWll1NXFrdFd1OGpTNWxKZlND?=
 =?utf-8?B?dmt2Zm5mbnk5MXY5L0t2RGo0Y21NL1FkbVlwa2lQeVB2SHkyL1ZsN2dqQTg5?=
 =?utf-8?B?ZnU1NkQ3R0l5WXlPL0V2WTBoMHVxb1ExSDVQS014QURtd0lyeEZpU0NXcnAr?=
 =?utf-8?B?b3V3VFVXcmhMeCtmdFZBMU1yNWhZbUJFek9GK1E4NjhpSFRqRVlTcDllZ0VU?=
 =?utf-8?B?ZHVVallOU0NncUR0YUpJeHd3VkJGVGRwYWhEZlhZcmlKQkdTbnlqSU9LRE43?=
 =?utf-8?B?bUxpczNFa3hnV3pjS3ZXM1V3eS96NDNKcFZzS3dMeWM2TW1Scmw4M1p4Mits?=
 =?utf-8?B?SnQzYkwrTFJvQUpDM0p6NGdkSzh2R2ZZc211YUM0bmRBNjFlMHlkTGRjOVhk?=
 =?utf-8?B?SGczQk5hdmxYMWcyalNQK3hjUngxd1VuTnZibms5SVFJZzVmaDBVS0NwQmd6?=
 =?utf-8?B?bkxNNDFDbjJPWTZ6aWFFaTRlQnBkWmVDVXNFUnM0emtVOWtpWUZ0RFdpS1pE?=
 =?utf-8?B?a0dVNkUyTGdXRDlRZkFPL1lwOEs5c1B3TlE0aXJMZ2N1dzN3MTVKMUpXZHNC?=
 =?utf-8?B?cWZBbFdSMGdKcHdxYjNUSmQ0Y01uSVk0M1psZTlteGNMY0NZTDBFR2tXT2pu?=
 =?utf-8?B?MndLZnZNL0lleThHZUUyazJVNnpCVm83OWhodzBCeThPN1pqaGRWUldVbklR?=
 =?utf-8?B?enVhUStIVkNlWGJPYWhISU5rekVaVWNTcXRrT1lTMklIS1lqZ3Zpd1BacnlD?=
 =?utf-8?B?OE01MXhKc0FhMTh3WkJMd1E1TUVLQnEyRE9uRUxWaFZmcEpDbWZjRE1tYXdv?=
 =?utf-8?B?YkNnSG5PcFhaNUZjajlRNkpSbHVvS1dGVkRFdWxIeUcyTXVHeWRybmQvRnR2?=
 =?utf-8?B?bHMyUlhScG94bWJaSThvY2ZNTXVOa0pLalRad0p0OS9tTTJVQ29GU3p5bFpo?=
 =?utf-8?B?YUppZ0hTYzFVSzA0Y2VjVDZHYVBVWGRTZUxXV3FUWlZUY1ZUSTdReHBOeWw3?=
 =?utf-8?B?U1FZTzlRR0ZiVWVFZEJWeldudDlzWmVCM1hjMVBVL1VmVWFMd2JUVkF4L3lB?=
 =?utf-8?B?YmM4c29hMzltdG0rM01EbDMza212Q2MrSnlZWHA1MUE5UFkxc0ZrRTA3R0Nw?=
 =?utf-8?B?enR0dkdGTFZnU21sQ040VFMxamQ0Vm00TFRtVUJSZFpPYmF5QUdKNFYyMnhP?=
 =?utf-8?B?UXdnRGh0eGNwVm5MR2dvS2RrYldZL1cyd3BMY3lWbmIwOEVvTjZxV1RJVjBK?=
 =?utf-8?B?citFYldvdHZ1WE9IZG5LUUZ5Z0Z4MEJJbnVJVXBTbDBaQlJJbVBLT1BjbHNN?=
 =?utf-8?B?QzA0S290YXlDL1dkUXVLZ2RWQ0xUekxoelB1amtOeDUzaGoybVVxbW54ekYx?=
 =?utf-8?B?eFhibGE3dytxTWJHZjVaK2oxRzJHbmNwODdmYW1zZ3hUOENKczRLN1hCNnMw?=
 =?utf-8?B?c0E2SEREQW9IY2hKMkZZQ0pBZUZkaFJWS1FWVWJOMXFBS0k5L09MbjM1UlBK?=
 =?utf-8?B?MzFZQ0cxOUZSZU9OQWFFTUpPVWp0dW5PK3N3dWxRRGMxR1Jvd3B3Q29CQ1Jt?=
 =?utf-8?B?SGlQbTlURUpuU2x1K29ldHVXYlpRYzEyRjh2bXkwbVd5UEJ3Mm5wS2xHeE5Y?=
 =?utf-8?B?NHJNckUrNnlzOFBiaFRWbmdscGtIN2lwQ2Z0NzFha2FRaG5meWJKN0NNVWVs?=
 =?utf-8?B?UlZaTWlhTmlPN2lqTlUvVVZUN1dGNnZnckdGTGJUOEM2OWRUVjFRSGkwWGNt?=
 =?utf-8?B?eXA4aVhCcGcxUVBGMWxQa0krVVB6T3dPbXBlUC8xNGh0RUpGdnNUTW9LWXRI?=
 =?utf-8?B?N1RkR2ZwZ3VCc01HSmYydnN4UmwyNFI5Q1BVM09GdnFEUnpuMCtsdDZaZGdG?=
 =?utf-8?B?cTBFNjQ0SHFDRTJNL2NKMkp1SVZKVFZjYm9ZZUxlSEU0RXpnOUN6YUdEYk1T?=
 =?utf-8?Q?+K1HRRXX30v0298w+K4VwUj2y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20018908-5784-4229-3f6d-08dc3ded86b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6801.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 14:55:55.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpifvv/O+qcirAbWFBwuJVr5olbXtGQkASc59L8vFfkP7KiI16DU1w8hbqy1XDkpo1A64gOEvezaUSLgXLwhQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-OriginatorOrg: intel.com


On 3/6/2024 9:48 PM, Sharma, Mayank wrote:
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Steven
>> Zou
>> Sent: Thursday, February 8, 2024 8:49 AM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org; Zou, Steven <steven.zou@intel.com>; Staikov, Andrii
>> <andrii.staikov@intel.com>; Lobakin, Aleksander
>> <aleksander.lobakin@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>
>> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: Add switch recipe reusing feature
>>
>> New E810 firmware supports the corresponding functionality, so the driver allows
>> PFs to subscribe the same switch recipes. Then when the PF is done with a switch
>> recipes, the PF can ask firmware to free that switch recipe.
>>
>> When users configure a rule to PFn into E810 switch component, if there is no
>> existing recipe matching this rule's pattern, the driver will request firmware to
>> allocate and return a new recipe resource for the rule by calling
>> ice_add_sw_recipe() and ice_alloc_recipe(). If there is an existing recipe
>> matching this rule's pattern with different key value, or this is a same second rule
>> to PFm into switch component, the driver checks out this recipe by calling
>> ice_find_recp(), the driver will tell firmware to share using this same recipe
>> resource by calling ice_subscribable_recp_shared() and ice_subscribe_recipe().
>>
>> When firmware detects that all subscribing PFs have freed the switch recipe,
>> firmware will free the switch recipe so that it can be reused.
>>
>> This feature also fixes a problem where all switch recipes would eventually be
>> exhausted because switch recipes could not be freed, as freeing a shared recipe
>> could potentially break other PFs that were using it.
>>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> Signed-off-by: Steven Zou <steven.zou@intel.com>
>> ---
>>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
>>   drivers/net/ethernet/intel/ice/ice_common.c   |   2 +
>>   drivers/net/ethernet/intel/ice/ice_switch.c   | 187 ++++++++++++++++--
>>   drivers/net/ethernet/intel/ice/ice_switch.h   |   1 +
>>   drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
>>   5 files changed, 177 insertions(+), 17 deletions(-)
>>
> We are seeing following kernel compilation error while compiling next kernel:
>
> "error: dereferencing pointer to incomplete type 'struct dpll_pin'"

Thanks Mayank!
The patch does not touch 'stuct dpll_pin', I do not think this is caused 
by the patch changes.
And the patch is based on the base-commit: 
ce1833c065c8c9aec8b147dd682b0ddca8c30071 that I built and loaded the 
ice.ko successfully before I submitted the patch.

Hi Tony,
Do you have any suggestion about this compilation issue?

> Regards,
> Mayank Sharma
>
>
Best Regards,
Steven


