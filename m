Return-Path: <netdev+bounces-75069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD27868120
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE02A1C21F14
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDAC12FB03;
	Mon, 26 Feb 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlCiSmWU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3312F586
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976189; cv=fail; b=o8bjgqueNnwyFmzQSswIOvUXtUlXTrAX90EFUQmGAfT6Gsfo86Lgu9PH38RvQx3r9LfZbyrvzf4aMQZSsnJURETCGfLls5QUrELoGQR23pTKcZAI1VXfsRTiEelcTlvhm37jU1iRU48U9qzOE2+p9tX99FlK0jSPrfa0yiWUq0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976189; c=relaxed/simple;
	bh=pawuDWp8oZJCd2YHu+YDW4JrYOOaGPGX6gSj7QwCF48=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=An+MaGBOdvrhn0G6T1Mu9W7spGVxN/jKISsVTOWBBCEVmk9L95Oh9qr9cJrHz2S3Zm8OIP6X++rNts2GI8Q9vHw9WfhPNgQnnvF+g2rkb4Ob+XMi8BYHAXp7/W49us0Hm3speO6KA9NkVz5K1RP6Bx6l+TgsDEdbcgzKDiZjw58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlCiSmWU; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708976188; x=1740512188;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pawuDWp8oZJCd2YHu+YDW4JrYOOaGPGX6gSj7QwCF48=;
  b=RlCiSmWUBJU9wqUxcwbgLUcxCQkG5APogmkpKun0AdWMxw9XrIXZEVfV
   tr6E/w1hq+nGfEtDXuYNkqyOgmd1D3a5okxx27kyAMSzu4Vs6bAkvlFym
   U5IKdpoqUwEtJFzIhSNrnsPZZsWAc3ubY3NOBsdOVpWbPdz3gNLODAZal
   MYRQm6JEHFsEhDPTVGZjyBuQd8P5X/7Wqpr18I0maRzwq5/GYbghPtpJ9
   AHb7cYs4z7iFFJizCvuvb/LvOR+gEBKDbTWZ2pi/baIi6rHmi5C/17jNX
   ewT5Wq6DV1y6TSRjytv3NbqA3duhyPje486uxoI58XrJsLXW7mfWvBs2x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3401002"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3401002"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:36:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6763921"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 11:36:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 11:36:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 11:36:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 11:36:25 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 11:36:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW/Spm+D9LFN0mPf2AAMf4aur4t58bwr/Bdm9QsXRKYO3kV8AODMPUd1OawKau7OXr9i4+KLpl1IiSbMVY3PvnQcXYNUYhuA82eOKXaFaxiW1kVjucgtjyed4SP2NgfzezID8SRdyaLOGbHa2mwW4dZRdE4v5fdK83tPGE0YaMHEDDZAnXGlLmo94VKE72Geru8ICwg2SWCXnGe6boDgP5Bck/QPJx4xAjy6/LROeoddShfD1+8WkL2jpfK8QTtM3V3RIBQJ4Z0EGgbKKvsfE2nT8BtxYT9h9LXfpAZnwiSvnEG+5bwNpPN5E7wxbHsqEvgO2XPAbm/butitFuw2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka1ncK1I8FqBem1LDdGRrS67kUW/7sqaCVi4TwC75mw=;
 b=cTHVxJL2rkNrmX77j+Vfv2HR0d8Sm6578JD493VM0nHsd/qcVoMSUP9Y9s2sZw5X0LaJgxg5PkfqJHSZihwwNA0+9o2ERp8py2x4F0woql+rXbpGbyUcspkysdC3tSx4jSxDyt9mCxc8JQjREvUoBpYphaKHtcBknVh++DmzygmNj0NeWvkTWqaK340dXf7hRqPgrn8NvODOAwI0sr2hnrhHI1EVRRO5Y3KUDit67SyJQ9frsX+NNHtenVr1dr+6HXuhf9i0DDivCsV+4j/QyxO7jc/qrlFL5+6T+E6KozKRKC/CueECBezYgKpIH9DNO9TxDtWhCK/9R3fz5uJrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7011.namprd11.prod.outlook.com (2603:10b6:930:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.8; Mon, 26 Feb
 2024 19:36:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Mon, 26 Feb 2024
 19:36:22 +0000
Message-ID: <e03aabf2-2a97-4395-9060-909d3651bcf7@intel.com>
Date: Mon, 26 Feb 2024 11:36:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] ice: avoid the PTP hardware semaphore in
 gettimex64 path
Content-Language: en-US
To: Michal Schmidt <mschmidt@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>, <netdev@vger.kernel.org>
References: <20240226151125.45391-1-mschmidt@redhat.com>
 <20240226151125.45391-3-mschmidt@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240226151125.45391-3-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:303:b6::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: a12d51e1-7347-4544-dc5a-08dc370236b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kitSPQ3Xo4W2juCoRP3GK8Re5XnrMv4uzITd5qNJzqrgNjQJDzR0xRgsW/V52WzTQnLNkdUBT0dx0oc1cVwfrTYFp0uQx4XwP5PM7AqjEy4bZRi8kpUfJVdN9PuaMcUUveXNJK3vZGgUJBOMzQ7mpBncWayQJiQEspis44+POKkNpcJja5ylNnhFDwXkLd7qrp67RaOanARRJP1OlAElXm8myJQWaFxXll/boW+KGUP4+tTGniMUb4imebtAsTksNXlVSsqugL+FocVshi1oEoY7wvR4rQWY5FHb7gjRFDRWJgqRrwyZGfXq5BCTZRnUeU0kJjkmUK9dL3T/gNKbdMBQe0fCvC/Vt+K3wAc5YRN7DF9tj5ZuXoF9RmiATaanBEJcDp2p56MblSiorpgcvVcaobGzOrMeBxneCLVqQ/whykhdy4agk0DKUVvqpFON430r0DCdQhurYN9eBZucMeh4d0ZTE/1RxGATutR4KbTcUoQwZE0VnutnO366hOPZKqo08hfnPcGxT5d6H3vJOofCS2b/PmUtVrxw/rekfz5xP+2rzwNWclfjjvykA6eUdXD7ZjhChawV7BYiXZ+u6bq1GvSJXx+d0gF7Hl5RLmwdWrE/H2E1OmSxb86aJ2h/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdwYW5GVHdma3NUMjdUUE5FaStQOGIwZkY0bUJFTURpWGNMVVZkUWdFdG1F?=
 =?utf-8?B?Q2FPYXNLVUs1QlpDV0dCRWhtaksrclhZRHVuLzMrOTlVQXZDNHY4YWJiT1Zr?=
 =?utf-8?B?R2VlT0ZSWTVZSFpnT3l0L3FmRDNQQjVPaXpoQ0tuNUorenRUZXpVT2lPWDgw?=
 =?utf-8?B?SWlzRHArRmhlcGhaakptaXRLaS8vT2pONHNPNEFDWVdRTm5naDNzRDBDYkJO?=
 =?utf-8?B?akR2SUN4SGNkT1A1d3p2REtreFRuQlJxVTZvdDZGK1RHY1NxdEM5OHUrOFZ3?=
 =?utf-8?B?NUgrRFkyZTVPK1JUcmhuNjhHTDRHME9reEhtRERQb0NIazZjdCsrbmN3enpk?=
 =?utf-8?B?amZrbVZtRk5vejk5OTAyZGxGWDFTSU9DUDgrRWY4VEJ6WkVhU1gxeENhOUdJ?=
 =?utf-8?B?Y2h2U2xqNzNBMlVqTDM4UmtlcWc1YUgxMGdXMFd6Ulh0OWoyWWtuK1c4bXZy?=
 =?utf-8?B?ZnZ4UFhrZENmNmxGUGF0YTc5ZlJqWlU1REs4RFFBa0NYQU1OMzV5VVNrT2NE?=
 =?utf-8?B?aWVzakZwOStDNlQ2UWhNcDhkVndvTzZFMElHZUNSMnNBWWJBbGtkZTZqQXN4?=
 =?utf-8?B?Ukk3UHpRZjdIczhseVZlZVByU0VySXZkMXBHVDNNT3Q3eDViMHhISGlYWnl0?=
 =?utf-8?B?MDU3MDUxdXo4QmpwWlM0MUZJVkRWcnNoRlVwVFIzcXI2R08xRUYzQnJRWDRu?=
 =?utf-8?B?UEhwNExBS1lNdzAvWW84RWlNYkNHRlhnUEFua1BFc2ZFTnZsODZZbWlIVE1s?=
 =?utf-8?B?VGp6T1BQUEVIZ21KUGdWSlkrZVljQmFReWlJSlpQbWU0T2daUVJEbmliQjFx?=
 =?utf-8?B?QzFxRjdDN3VGcWdvZkY5a2plVmMwSjViVSt1YnYybnlFQVpXMmFZTnpaZlAy?=
 =?utf-8?B?MndlK2NtU21icElRRWVGMXhIRTluNjRuMEdwSnhVcEU2M2dPL01IZEE1b0xV?=
 =?utf-8?B?NHRmdXdpZ0IzakI0QzRVVGR0UFQzQXhqUkFoMlE4NmJraXY3TjRvT0pMT2ZR?=
 =?utf-8?B?a0lrWnFHZGlQdzFKd0FDMDI1QWlwUHpmWUYrdmlaV2g4L1NjN0pCckQ0Qk0r?=
 =?utf-8?B?T3NaeGovWStoTGxyazVhK0hXbXZJd0pFYm9jblI1Q2IrdkRLUllRMVQ0QlBC?=
 =?utf-8?B?THM3cVB1MUplaERwZHROVFhvT0ppaXZOY2tka29ueU83cm1EcGorSVZDYVJk?=
 =?utf-8?B?TWsyWXljNFVCQ2pjUTVPekZsaFllL3BOd3hqQjVyTmdRQlZsaXhzRVNQS2Qr?=
 =?utf-8?B?SDh4emdudTJEMDl1a1ZrSEE0anBrZnBYOXhTa2M2ZE52K2dPdTNQZUdIT2R2?=
 =?utf-8?B?QzgrUldTNEt2WG5CWHI4WGV6U0JXN0JrMVRNYnNjeGJUQTVjQ0t6dnVRV1My?=
 =?utf-8?B?N1M0NGtNU3RyUkltTmp0SktPL0VwL1JtMXQ2RmkwOVFOQzRUazVXRUFWbjF4?=
 =?utf-8?B?RmZTSmx5OWFhMVhSOWFLWU5EcThsalVyQnExUE5VemVTczJWZlh3WU85QTM3?=
 =?utf-8?B?R25GcGl0WDRZbDdwSmc5MmZBc0pwMjJORXZSS1k2ekJQazl6bFNaL3poV1BT?=
 =?utf-8?B?ckNGYnJtd0RuaktSUU1LVXI4QmVNdk5Hd25mUWMrUWR5SW1hZXVzSGV2N0Nh?=
 =?utf-8?B?dkdQcFFUYW9pL0ZxT1M2dVlVTHZ1Z2VCL2NUb3hTYjFnL01VQ2gvQTh5VEtO?=
 =?utf-8?B?NGszSnJXZlRVR1E5dExIR2pGeDFLMXpDR1pZZTFxWVhPTHhHVFBKYXBKT2Z4?=
 =?utf-8?B?QkFTZzNZZHZhb2dMNDl5d2M5a2NlNFhwdTh2U1lrQnBHejJHdE4xNjRWc0M2?=
 =?utf-8?B?Y0RSVmhEZ2M3bnU4bHZia3pLNGUwOElZN1lVYjdlVG1mZVEwaEFKMlh0aWx5?=
 =?utf-8?B?RFJ6VjNMcGRQQmsyMnQzdWRNTkh2OXErcHdOcGhxMmN0WTVXOWQyWTR5b1FN?=
 =?utf-8?B?WE0xc3hTL0ZpMXZyLzJwcWdxTW9CRVlpZ21ONmloYXdNRXRTajg3YTdRQTJ6?=
 =?utf-8?B?cE15UnNheUQrQnM4eFR0ZllybWwyc1l2dk9iM2U5enFockpZTXo3RmtHdTl6?=
 =?utf-8?B?bmNuSnJIZDd0cmsrVFVKVjhuTmRSaDJzSkEwdVlzcFUyNTBkM29RWElNM29l?=
 =?utf-8?B?Tm5QbHFHLzNnVm9HS3RGb3pYNy92VUZ2cGRLVDZKUzc0c2N4UzN2WldwWldH?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a12d51e1-7347-4544-dc5a-08dc370236b7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 19:36:22.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fbfm1rIhLV9j12JANHuhYu+coOEQYm1Bo+Fc2mLQe4wnXRU/N9ku2/cW7DoD8zjpesMdhRM6rswwyVRZIMuz1iPE6ISxXjbwZa7ZcO4tJNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7011
X-OriginatorOrg: intel.com



On 2/26/2024 7:11 AM, Michal Schmidt wrote:
> The PTP hardware semaphore (PFTSYN_SEM) is used to synchronize
> operations that program the PTP timers. The operations involve issuing
> commands to the sideband queue. The E810 does not have a hardware
> sideband queue, so the admin queue is used. The admin queue is slow.
> I have observed delays in hundreds of milliseconds waiting for
> ice_sq_done.

Yep, this can happen. We've worked to try and improve this, but
fundamentally the firmware was never originally intended to be involved
in these flows.

> 
> When phc2sys reads the time from the ice PTP clock and PFTSYN_SEM is
> held by a task performing one of the slow operations, ice_ptp_lock can
> easily time out. phc2sys gets -EBUSY and the kernel prints:
>   ice 0000:XX:YY.0: PTP failed to get time
> These messages appear once every few seconds, causing log spam.
> 

Yea, this is something we wanted to fix.

> The E810 datasheet recommends an algorithm for reading the upper 64 bits
> of the GLTSYN_TIME register. It matches what's implemented in
> ice_ptp_read_src_clk_reg. It is robust against wrap-around, but not
> necessarily against the concurrent setting of the register (with
> GLTSYN_CMD_{INIT,ADJ}_TIME commands). Perhaps that's why
> ice_ptp_gettimex64 also takes PFTSYN_SEM.
> 

Yes. We tried removing this as well. However, as you point out later,
doing so would result in tearing and incorrect clock reads.

> The race with time setters can be prevented without relying on the PTP
> hardware semaphore. Using the "ice_adapter" from the previous patch,
> we can have a common spinlock for the PFs that share the clock hardware.
> It will protect the reading and writing to the GLTSYN_TIME register.
> The writing is performed indirectly, by the hardware, as a result of
> the driver writing GLTSYN_CMD_SYNC in ice_ptp_exec_tmr_cmd. I wasn't
> sure if the ice_flush there is enough to make sure GLTSYN_TIME has been
> updated, but it works well in my testing.
> 

I believe this is good enough. I don't know the exact timing involved
here, but the hardware synchronizes the update to all the PHYs and the
MAC and it is supposed to be on the order of nanoseconds.

> My test code can be seen here:
> https://gitlab.com/mschmidt2/linux/-/commits/ice-ptp-host-side-lock
> It consists of:
>  - kernel threads reading the time in a busy loop and looking at the
>    deltas between consecutive values, reporting new maxima.
>    in the consecutive values;
>  - a shell script that sets the time repeatedly;
>  - a bpftrace probe to produce a histogram of the measured deltas.
> Without the spinlock ptp_gltsyn_time_lock, it is easy to see tearing.
> Deltas in the [2G, 4G) range appear in the histograms.
> With the spinlock added, there is no tearing and the biggest delta I saw
> was in the range [1M, 2M), that is under 2 ms.
> 

Nice.


At first, I wasn't convinced we actually need cross-adapter spinlock
here. I thought all the flows that took hardware semaphore were on the
clock owner. Only the clock owner PF will access the GLTSYN_TIME
registers, (gettimex is only exposed through the ptp device, which hooks
into the clock owner). Similarly, only the clock owner does adjtime,
settime, etc.

However... It turns out that at least a couple of flows use the
semaphore on non-clock owners. Specifically E822 hardware has to
initialize the PHY after a link restart, which includes re-doing Vernier
calibration. Each PF handles this itself, but does require use of the
timer synchronization commands to do it. In this flow, the main timer is
not modified but we still use the semaphore and sync registers.

I don't think that impacts the E810 card, but we use the same code flow
here. The E822 series hardware doesn't use the AdminQ for the PHY
messages, so its faster but I think the locking improvement would still
be relevant for them as well.

Given all this, I think it makes sense to go this route.

I'd like to follow-up with possibly replacing the entire HW semaphore
with a mutex initialized here. That would remove a bunch of PCIe posted
transactions required to acquire the HW semaphore which would be a
further improvement here.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.c | 2 ++
>  drivers/net/ethernet/intel/ice/ice_adapter.h | 6 ++++++
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 8 +-------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 3 +++
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index deb063401238..4b9f5d29811c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -5,6 +5,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/xarray.h>
>  #include "ice_adapter.h"
>  
> @@ -38,6 +39,7 @@ struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>  	if (!a)
>  		return NULL;
>  
> +	spin_lock_init(&a->ptp_gltsyn_time_lock);
>  	refcount_set(&a->refcount, 1);
>  
>  	if (xa_is_err(xa_store(&ice_adapters, index, a, GFP_KERNEL))) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index cb5a02eb24c1..9d11014ec02f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -4,15 +4,21 @@
>  #ifndef _ICE_ADAPTER_H_
>  #define _ICE_ADAPTER_H_
>  
> +#include <linux/spinlock_types.h>
>  #include <linux/refcount_types.h>
>  
>  struct pci_dev;
>  
>  /**
>   * struct ice_adapter - PCI adapter resources shared across PFs
> + * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
> + *                        register of the PTP clock.
>   * @refcount: Reference count. struct ice_pf objects hold the references.
>   */
>  struct ice_adapter {
> +	/* For access to the GLTSYN_TIME register */
> +	spinlock_t ptp_gltsyn_time_lock;
> +
>  	refcount_t refcount;
>  };
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index c11eba07283c..b6c7246245c6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -374,6 +374,7 @@ ice_ptp_read_src_clk_reg(struct ice_pf *pf, struct ptp_system_timestamp *sts)
>  	u8 tmr_idx;
>  
>  	tmr_idx = ice_get_ptp_src_clock_index(hw);
> +	guard(spinlock_irqsave)(&pf->adapter->ptp_gltsyn_time_lock);
>  	/* Read the system timestamp pre PHC read */
>  	ptp_read_system_prets(sts);
>  
> @@ -1925,15 +1926,8 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
>  		   struct ptp_system_timestamp *sts)
>  {
>  	struct ice_pf *pf = ptp_info_to_pf(info);
> -	struct ice_hw *hw = &pf->hw;
> -
> -	if (!ice_ptp_lock(hw)) {
> -		dev_err(ice_pf_to_dev(pf), "PTP failed to get time\n");
> -		return -EBUSY;
> -	}
>  
>  	ice_ptp_read_time(pf, ts, sts);
> -	ice_ptp_unlock(hw);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 187ce9b54e1a..a47dbbfadb74 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -274,6 +274,9 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
>   */
>  static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
>  {
> +	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
> +
> +	guard(spinlock_irqsave)(&pf->adapter->ptp_gltsyn_time_lock);
>  	wr32(hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
>  	ice_flush(hw);
>  }

