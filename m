Return-Path: <netdev+bounces-80026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE687C935
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 08:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8988E1F21E4E
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 07:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1045114016;
	Fri, 15 Mar 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgrrZsl/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C8134B6
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487805; cv=fail; b=Y6gR7j2XxulbDR8A/MgCtDm6NIKxwhoFpfJCWsL6O/WygxQmVFKO/MmR4Bj79hoH+LRpT/CVbLAONNmJGKeyHMDZaWnvZgl22gVtINQhFAsCBFpQQrBnEDeLNd7R4DgBdPof5j/ppiorqPMsHJ7Rm0mRHOyPXcWxLTEeEcVJd3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487805; c=relaxed/simple;
	bh=Btagvq4EB59yIbIWR3aJ4fewb9W8I4eF+ERz/xf9ldY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrNfyrmI3zqWmEIhV1oHQIWpcyVdShUpsnfCCj+zjSWwkif7NU1rF4dyXrq6xi3x+4rrQ8RlyZ9wbGLlY/7jB0JuP3aHxMCqlfS1NxpJ1XYOV+WlJtT2zN6wBUhHZs3peSRqAQdHMCNqFbvqH+bHNUO8zFuXqfmNVqRWzcFuFkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgrrZsl/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710487804; x=1742023804;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Btagvq4EB59yIbIWR3aJ4fewb9W8I4eF+ERz/xf9ldY=;
  b=bgrrZsl/PJl1oiku9cvitE+D8krCik7s0uRdGabLzqkElohgRb/sh+hj
   Qme1RA3YPH8Zk/HcW2m28QXlg0Ca7h5bkYberdJXxRDNP7O2xVi4zf/QW
   yZyeXZTshsPsUZIfUGsqJIGzT81Hxr4LmOaC+uWOQ3Rim8RezqSomOgYI
   XfYvLu5Z8nYt8V6UKyx9Qs059iJXSs0K+rOYx8jpV1v4yYKcwA4H2v6Ks
   j8Oq2Q3ZeIQr36+6qK83m3y0z5vZeu+yIR3C+S6JueGuJ7o+U2duvehh2
   czPOQRg1TSt2koiGxw/pHLut3d9jGWIqo/UatxnzLCx5eg4Hdm7BAab+z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5284174"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5284174"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 00:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="35717406"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 00:29:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 00:29:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 00:29:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 00:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoXNX5k1uxcn3Ja9k+D865O7xIWCXZ0l4BpvDgICtgNG6ybZ+y5Ft04Nkz+k/SVw17d3n0ZssPWH6H50WjxuIIruOApQayFDWmwCXvrT1lpvxh4b0xXuv96yDBpueyT+3wLIlZoBzgYYv6x5XuvmjvngVZouGD8ciS3IeLnlYOXatBa4H7CAvxINrRMQNIXBeEpSH2xP04+p9fSSAUHR1FhN1K8p/vgQ8uG9PHFhY9WkmM7GlxQSj2+1tuI5PS2djl/SPyXGQC7GnHov3cIfxleQnz0v9i69jKE0E348kkk78kHiz9TcnYhkeG1USYhT43TG8mxC61KxqSX1ngvwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fX14MwcA589yFY2b0MFTOvLErbJJCLeW5ojm4NPyrA=;
 b=QjARvtcQ8njklDIRxKuWUSSl8oaOVZubnR+WSMJP7i4L5xIx1KDpEdu2UZycG97vGbpzY4ShIyeydOfclhfibYHuvf7Bamsi0KZmlQ/NzE4U5a6+4l9L359tB7A0y8HUTi45KBLLH7nqjPADxXpjaDNp+Rxe9rzc7mzaWwMbOMsegI4+4T3ZWTVwXB5fayR3teYqFNxSFHWAEhDmW4e19voTDacMNHEFImuEuiwT66edcOGYTsJ25Vm553h9+Wxc8pK8W0lZ6rwhnaVJES5X/nXc9QdUZjq5yrdHyLL8ERQj9IKIZis9Lgl2Fm8ywFalOx6ZiPdeMhHgRHM/J6+DSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by LV2PR11MB5973.namprd11.prod.outlook.com (2603:10b6:408:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Fri, 15 Mar
 2024 07:29:46 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 07:29:45 +0000
Message-ID: <2830bf3a-7068-4723-87d2-fab5d0fa2fad@intel.com>
Date: Fri, 15 Mar 2024 08:29:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] ice: lighter locking for PTP time reading
Content-Language: en-US
To: Michal Schmidt <mschmidt@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>
References: <20240307222510.53654-1-mschmidt@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240307222510.53654-1-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|LV2PR11MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d2bc96-b34a-4211-a18e-08dc44c1b02d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzvRF+nDVsnFuR1bHyQqdBmFVJfKJ/X8X1+mDdcluofx1Y39E+31BPXTWTTYHFhKWgcr8KGx0l8Yr9JEZ3di2XsRQ1IOFatg3tkh1I/UkHNpyyEseKArYUFapIo3JuWWiZcRCV7oFcpbmXTCKKPTC6xmRj7wA+PdFBVj90PAH6/G0EQyrfWPb0bZe0AQ2u2NnhJ91tK8920641dibYeyS/So+ZF2lZYbMubIbYCZplKOo+/7Pt/xpgjGtZMH6shblf/VvLrP4IVDSYwl1RPWlYcKgsTAGqrg9UtXCHruKrMAKTv7OvB+ZtYcAKDpvz36oXiUQMlHpbbOHmepHZTEbOP8e/yivmCB4zNiT88tg79bAF0Pgd00WtwFeltMaZ62Ifa+lcEnlCiwTx6nPxbsKt/R0f8jN6a+XjEVGT6RkrCLclPxTHyZCvI3Z3Jo8k0+U4sJqmtyRuFIbEWSw70O0qiXvt/jDF38YAaXIinKxFuUSe1tvnvbvYS+x/Ty7K9aSDqmmeuHgTXk9qUmO+wErvncC1QhK6+VJhT1NysNyKDx/pkuAPxP5BJwap1Y6i0lmCGjBOmnia+NgWmEdARtTFk66YRXmre5FnCRlBpXx1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THBwN1dYVVhMNng5UXd2aFkxY0xEdEZ0eTF3Njg5a1pHdHdQOU1YbEpwaWZP?=
 =?utf-8?B?UGRnZWlRY0Z1dGhUY1p3am82VTFJMUVjMlZHa0ZITjZad0NIZzVjdjJCR1Zr?=
 =?utf-8?B?M0pqaHBYeFNYa0pyRzBIby85UHRDN3lJVkpJL05mUG1nMndyajduM1U1WGJu?=
 =?utf-8?B?QUFrNkhwc0cwMkpTRnUreEY4QkhNdnFuaW5oOFYxUFZmWExUT1BOMy9IZzNp?=
 =?utf-8?B?REZoSlkyN1Y5aFJxWFgvdnlnQ0dwQmpxQVhqTmRkMG0zRzd3eE1lQXNBTmJF?=
 =?utf-8?B?dXUrWTM2SVlheEl3V0JPSDVYWDVWUUpONWNCMlNVMnlBUWV0OU05bGdaMzJk?=
 =?utf-8?B?WTlXNUgzNmtLMjJaN0ZWa1ZDcDNFR0pyc3Nzd0JLYXdITmt2Tit0NS8wcjFt?=
 =?utf-8?B?K0h6elZvMXN2YkNFRE54SzMwYWx0SHNhNURqM1N5TEdrTXU4ak1xa0MyWFVC?=
 =?utf-8?B?ZktTYTJFVlE0YTBraHRwNEc3c0FkZEs1bEs3anhPay90T0NicFd2ZCtKVkZE?=
 =?utf-8?B?a09ZZU02NjdxU1Y5MWJtZ2FxNzF2eGxuMEdFMjZJbEpCZDQ2eHJRSGdFdU52?=
 =?utf-8?B?MGR5RHdXdTE2STlxY1lMK2gyT01pTU9TbjBHNDRqSDBWMzh2eStUMHhBb1Y5?=
 =?utf-8?B?YnVmVEhsakhONnhicW0wellWNVpnanNqaFJGRFp4ZjAxU0M0SVY3aDZEdi8y?=
 =?utf-8?B?OUVkZkwzVlpITHk0OTdhV1JoY2lkTlhaT3FlS1Q2TlVIcGlKZUNka2tPL3c5?=
 =?utf-8?B?eDkybjlEREl0WjB5cWxTTVlLczB3T0FRbnZ3TmdqUXQrNW5FOWZWSWpBZnlX?=
 =?utf-8?B?ZHRGa3lBbVBMaVExRHlUSE9IajJJOTV0cEs1VE0xRDd2bGp3V0VNaDZXak13?=
 =?utf-8?B?TXp4dThjblZ6b3FQTFNMUXpJODA4b01OTmsrWHFXN0JmaDY0YXZrVXd6a3Nq?=
 =?utf-8?B?RmtzQnpacW5xejlwMVJpcTkrd1B1NjN0T0M5cUJrcEIvSWMvbmNoVUZDaVVq?=
 =?utf-8?B?dUdGbnYrNUV4bDVZdHMrWFkwUDhNb3Q5WVpyNXN0ZW16SnFJazJRUTR5Mnk0?=
 =?utf-8?B?d1p2dGRxSWlicjc1K0xOb3BCN3ZGa3N2dGdrSnMxL3hFV0dwV0FhMnpuckND?=
 =?utf-8?B?K0JUd0syelRZRVlGTUx2VDlndmg4UjZCRVRCVTlJK0RiWlpLN3BVa1ZmUzdO?=
 =?utf-8?B?N3FXSHN1OHEzbTJsVGM2dDJkcVJlRlZQN0IvdkhSTTFDV0o0Y3BudWIydlVx?=
 =?utf-8?B?UXc0Rm1naC9QQW1vSXpXUnRXdmxPaDNBRW1KR01TUWRmbzlNRlNSOWFlYXJL?=
 =?utf-8?B?Y0V2RURCN2ZOUGUvSUJ3cVJta3Y2WmpNUU9kRnpIc2lNWW5OU1dlVGFGTmJ2?=
 =?utf-8?B?M2ZWOTVocFJhZDlJcHYxbDhOVFNYcWxuazdNRXFRS29GOFl5ZUxTakcwUXg5?=
 =?utf-8?B?eVJQUHlWTVdRa3VGNC91YWZ1a2tuOTc5dzVEU0o3S3lncEkwUUdNQkREN2Nv?=
 =?utf-8?B?RnAxQ2lYenlSZUo5SU1zeThRTzlFWkMrMVhQd1JXUWtVVGh2ZWIwTmR5ZzBL?=
 =?utf-8?B?bXd0cXREYUJlWlEwMlNaek5xMlcyRWtEZmRoMzFVb3dYcGtnUHIrZUVMWDZw?=
 =?utf-8?B?dks3QW4rR1JLY3lKTy9XVWRBTzJiV2RhVm9sR0h0UmhKTVNLV3JDUzYvVWRI?=
 =?utf-8?B?eW1ISnB1T2dWZnppQ0lCcU93RmJZVUpUYVdsS3hwMTJZd0JGQzZQUDZPNS9I?=
 =?utf-8?B?dll4OVNBSUluRWFmV3k2MHNhNGYyQ2F4T2dUMzdoRGRBYk0wZFhzMU5zRzBU?=
 =?utf-8?B?ZXlnVW9GSFNhV0ZLUVh2MzhaKzhpYkxPUXZvaTErUFFzcFZPQlRlRWQ1NlF1?=
 =?utf-8?B?Vlovd2ZveEtydFQ1RkRPdFRScS9MRkl3SzRKa0pHK3J5ZkdSdGlubTJ1aCtH?=
 =?utf-8?B?N1l2K2N4QmRjd1JuSVl1MzM2WmlndXI1R0NKTEt4eUdTRVZzQXZlKzlvRFV1?=
 =?utf-8?B?OGtCdEVNTHJZNFRBOWxDMWw5bmhHT0wzVlV1TnBYa21xTTUxa01jbzdidVZr?=
 =?utf-8?B?bnhTLzc5YkR0QWZqY25kQW1pVHlTVEZubnlPcGs3U21hTFI0N3VEUFpmTVBz?=
 =?utf-8?B?SXpuZS82akZwZUs2NklUZXFXSm5kcU91TC95UXAvek43L2Q3ampKYnRsdU9S?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d2bc96-b34a-4211-a18e-08dc44c1b02d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:29:45.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ILdLKwGEyMK1A6iTCxEusokoH1J8ZY9w6tGE8lG9pG505TRtb6kPfj5g/vozzAPsECRXbqqcClWHbDNKaXhKE51wndqLhJRowdVO5gxJwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5973
X-OriginatorOrg: intel.com

On 3/7/24 23:25, Michal Schmidt wrote:
> This series removes the use of the heavy-weight PTP hardware semaphore
> in the gettimex64 path. Instead, serialization of access to the time
> register is done using a host-side spinlock. The timer hardware is
> shared between PFs on the PCI adapter, so the spinlock must be shared
> between ice_pf instances too.
> 
> Replacing the PTP hardware semaphore entirely with a mutex is also
> possible and you can see it done in my git branch[1], but I am not
> posting those patches yet to keep the scope of this series limited.
> 
> [1] https://gitlab.com/mschmidt2/linux/-/commits/ice-ptp-host-side-lock-9
> 
> v3:
>   - Longer variable name ("a" -> "adapter").
>   - Propagate xarray error in ice_adapter_get with ERR_PTR.
>   - Added kernel-doc comments for ice_adapter_{get,put}.
> 
> v2:
>   - Patch 1: Rely on xarray's own lock. (Suggested by Jiri Pirko)
>   - Patch 2: Do not use *_irqsave with ptp_gltsyn_time_lock, as it's used
>     only in process contexts.
> 
> Michal Schmidt (3):
>    ice: add ice_adapter for shared data across PFs on the same NIC
>    ice: avoid the PTP hardware semaphore in gettimex64 path
>    ice: fold ice_ptp_read_time into ice_ptp_gettimex64
> 
>   drivers/net/ethernet/intel/ice/Makefile      |   3 +-
>   drivers/net/ethernet/intel/ice/ice.h         |   2 +
>   drivers/net/ethernet/intel/ice/ice_adapter.c | 109 +++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_adapter.h |  28 +++++
>   drivers/net/ethernet/intel/ice/ice_main.c    |   8 ++
>   drivers/net/ethernet/intel/ice/ice_ptp.c     |  33 +-----
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |   3 +
>   7 files changed, 156 insertions(+), 30 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

