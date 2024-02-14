Return-Path: <netdev+bounces-71848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C185556F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667101F2544F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E2141987;
	Wed, 14 Feb 2024 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUc85JRU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD732141986
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947942; cv=fail; b=YJNVYgw8jVOt6lZdrhXBhFw0gXFkBXIONW9vDfKpctrZsaMaEyUtrHhPreZSRgoAbJpghrBpQzaXITTMGwqxkjwTh4pNiwi4x2kkQGBZwAhWxrrLsBKsC6utxgu9I1m39G2E3xXUmKdyEh+PC349vdTjEV5mzZ2paLQPx05Y1qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947942; c=relaxed/simple;
	bh=KWbDBJFWT51qCks+tT8Tb9lmOf1dMXCPSKmovU48f1Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sUhOk759HMMDWJJYXRbXZ3a3vQvRJjFLzqv9WQyDO+L9n+Sl1fTau8+8I6iDiBWlwxKJTyB+rABFXCru2r1Fy6RItGyUyEJ5Z/m+H0Tls+U8lS1tii+8QsfGf2HTYlXdqB/EBZkD5AjrV/m1Eqej9y4bSc9Z8YGa/K1MYHZgKUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUc85JRU; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707947941; x=1739483941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KWbDBJFWT51qCks+tT8Tb9lmOf1dMXCPSKmovU48f1Y=;
  b=RUc85JRUT6VmpX/cCUrXX/yRp4V4+Ouqu64dyiNbbRZrw8iVYiU9kGAh
   A6dCekzWW8WpX/5jpaWi3g3Pvp2YO7gfA5g9gRY2eEr2Z9Ow096/qFwgY
   MJJ0PPJi/vO0tIvbLkQ4qP8I9NhA5+taxUcMXsxjnsOkv+8fNXTUs1mB5
   e/yRSJF417LTmC2u7rok/xrZ2ZV1A8VZsHb3s0fNnMUEqwvzvOvDUrn6g
   o/gv3naySHUPylgPpwj6czI2yqRd9d8ZET7wc4M1TnzjNm5jlNTsv1eia
   eos/t5Hz7LoX/JKHIiif5t6ZLNoMgVVbg5oPQak+hZjH6Bwz6Fg7qiTBU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1890303"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1890303"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:59:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7937269"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 13:59:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 13:58:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 13:58:59 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 13:58:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVsAaxozOs14gutnWYc4wSvMXm9P4fw8zj8HHuCYUldRe1kqQCCbUHkM6PftADHfDgSlCLdUI840xW6VYugU9d97fMwAzIsSyzSwH0ZI/ia0zy4qVAcOsFuWBkxPRlL2uWUMnj226t00F8M+nSBJL3UCzay92CJp98+JqNnbUxJzbLM0fsEmrXIbu+Qodg+gWd0PuDwuZfZJ+HQXweFTfS6MODLz2De3g/TA46R9gCOWyR4LpDZRcrk/lvdMU1pwBtbPn+b99fYeHDYQHulo/Hpztn9eIcqqecCzbiGn+ZchRfLWbpIC/AETOTWuSZxS/tlb0BLoNEB/8GkgpJO2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftABnO1HbtSqWqIqYeCKuh4X0Ug6+/xJi7fnWO68HJ0=;
 b=JPRU8r5/9dIzIsRbv2/lXIRL6murJ+FsPFfLVHe13/b6dIn59No8lHdSOVWpuXti0XfaZNWtOVdPyY2pSyWAmTNMd92hY+td3hakoRw5ut31cJxIsg3BIfjxyhCYxMRNtCO3YzrdF2mhwVjUvJIcQr1uboAnFrOSOBQH9TWzuA4SnMHBvjyfe0FXJfbi6Lqn0tQgpEezMMwK2PpGD5TySZUNByOVhVxncX4SNBEYq4LDRFNIpNAa/jes7fxMDchkuBkxzp0139kKz3tcVccsaf1bXkNPIZXsBMO3AdIjGcTEkDg2OReYSq6kGUCROxuLlXKEpSdHnKF/z3yIGoy4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 21:58:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 21:58:57 +0000
Message-ID: <8ac16939-62dc-4a27-b06a-8969589a1ede@intel.com>
Date: Wed, 14 Feb 2024 13:58:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/9] ionic: add helpers for accessing buffer
 info
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-3-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214175909.68802-3-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:303:16d::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bdd115-a7d1-4289-ed7d-08dc2da82494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFcAWjN3lEC3EQIbPjPsVWM72NHfx3sxKDWBYm7u9+ek8HEYoSSyEZHRnNDJTmbo+esS3UnHGHvsFWr7itgpISvHFsMB0hc6V2pJHE7UScSGwq4qayQxkyuHE2o0mPoY0NRaNjm+B4s5ECm5RmLUbSmuTx2ZRfvXfdgFhedKFZcoOOVoi1qRnox3hp/XpVaalmBicPJdWykRcIlhqc5RxwPWZbVpHyj5zko2KRAfk5tvexDSozkR70DUfNJSzlq9ZL+2APcfZ5IS86zkNWuJGr0BMBlHUF5I9LeydS+ypOWUOc+Jzk50lw3eglg8/90UMr/MeGBbqTnjhfK8+mJu0MszZWoBCwiQ5PnRbeT2jzL6mLwMy/tPD3oQZYw8PIZgDBZcEsT0tx5PzI8fAQxlkkt00xKq5orbd4xU5+cNjrNvMTrN9vqi9A6EE8KgIKjiAEGy/JDB9yVn0yD85c1cGbTb66gZc7jiB3GuQb27dxf4ftjgAaV88mG6Ua0bSR3vvoGf0dUErU1tZ2z/Ejhmgw3FqIT5KqpNNNr0eMp9otsjEm3hAYzXOXSUvkds4GWW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(38100700002)(26005)(8676002)(8936002)(4326008)(36756003)(41300700001)(86362001)(82960400001)(31696002)(2906002)(4744005)(5660300002)(2616005)(66556008)(66946007)(316002)(6486002)(66476007)(478600001)(53546011)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1VkZlVCZzVuQzFDOFljSkpnWGIyZlphUm9iZWV1aUxZUDF2TU1sTHhHM1NJ?=
 =?utf-8?B?RjlWWmJKZktQRUpZWnk3M1hhQnh1cDREZWpFbzMyU0ZPanpNZDlpYU5qVUNN?=
 =?utf-8?B?K1IwM0lRc3VrakM1RnlkUzNFaTlMRVZEZHp5Q0xsb254Qk12UC94ak0yaEIv?=
 =?utf-8?B?V1ZLb2c5MStwWTBMTVdEdmtTTTQreGFzV1NldFJ2MHU1bkxNc010WlJsK3Nk?=
 =?utf-8?B?VXMvb1FCOHdvYVVBc1VnQytXZTM1WXV3QklMR2lEUmxOVlNSY1p4em5aR0Zq?=
 =?utf-8?B?YTMzT1czd016U2hHZzc0dkN6ZnVBVVZzSUxkTUJOREZpdHptRmkxSDRnZWZ6?=
 =?utf-8?B?QWRZaDJlam5IVDBPcG9yclIxR1RORXNSeEpwSDBNUWJuVEVsQnRHU1hqaFc4?=
 =?utf-8?B?SGliazZha0FsdjhUUzhUVTlCME5rREJiVm9Ia2RNcWtLY2UvMkFZa2FNNFg0?=
 =?utf-8?B?YVZhUjJzbTVQTjBUVzF4eXdDbEdEc1lTb2V1RTNOc2ZpTld1Z205L3NaZVhH?=
 =?utf-8?B?YnE1cG83SlRqTU8rZ0VzUjJRQ1lMUkRlSEpsbHVXWmFBTHp2MWVCZDlpZmVz?=
 =?utf-8?B?S2lBUHpYcXlaQjg1ODhUSTRWMGU0ZzMyRFhaUlhyYzM1Mkw4eEpQTU9kdTIx?=
 =?utf-8?B?NnRHQWF4R1NHU0tTSVpnc2dwWkJHWlU4ejgvNnQ0SUF6UmxMaUFUQ1VnU2pl?=
 =?utf-8?B?cWFUTjZaTEQ1bXJ2bkxtOE8wdkdNdEZyZlcwM0hmNUxFZjhRY1F3ODRIY2xO?=
 =?utf-8?B?TXVSaFI4aWY4T09MS25wZGVjZDVtYUFXM3huU3BwdXZWOXlCb3Y4ejUwWGRU?=
 =?utf-8?B?eTl2UlFiUm5yc2pjNlhicjYvLzJZRlp1Mklmb3h3MmYrcEgzU3ZlS01MR2xK?=
 =?utf-8?B?UXFPQjc2Y0RueXJaSUVwU1dsMElMcTJScW91MlJuWkRxZVZiNGRCQVQvYTdL?=
 =?utf-8?B?ODBjK1Fibmg3aHlCQzEyelhPdE5nL0ZKaVBvbi9pZUlad01uaTBXMlMyc3dJ?=
 =?utf-8?B?YlorUStHZ09VSzdQNWc4dDh0eWV6V0QwbXp1K1UzWW9pdjV1SU5TUlR5aVpj?=
 =?utf-8?B?MVdQZTQrZi9SUWhmdnREOEF0aU8yaEUzb0FPeFRoNktLRWJ6THhpSnp4Yk54?=
 =?utf-8?B?Q2ZHVmFDL1hYcW5IVjdmdS9BSVZnMUJJOGdXekVQQ0F5NkQxbFBmdnVueFJj?=
 =?utf-8?B?QkFic2h1SFhIcFljbitybjlEdHE0OVBkeVlUL3hJSi8zVXdvZSt4TlNLWU1S?=
 =?utf-8?B?d1d5SnQ5RzcrY1crRGd2UzllcEdqOTFkTFp0cHNwaFdlbm9keWQ5RmRsbmsz?=
 =?utf-8?B?eFM3d1JVN2FTUEZDZGovOWpBUysvaEtpeU13NTNpWE44N05OZDZNM0tCdjh6?=
 =?utf-8?B?MmtFdHRobVpaNGxVeDJDMm5mdGpORXR6TEQ4UlE5MFRPYnJ6TzMrVGRrd2x5?=
 =?utf-8?B?Z2twK2FyY2xzRGNPU25KVFpKTnpUczFpK1h1MmNub0tNbWR5dWFuZHZzcmR1?=
 =?utf-8?B?ME1EM211VXZyVEJkSEsvdzRtQ2ZNckM0WjFTNlh5cHVZL2ZqbUZFMWhBVnZP?=
 =?utf-8?B?SWJNNHBwQ0ljZzRuMGlJQ2k4Undlakw0VE9FUFpLNkhqazJXdFBkVzlhQnJZ?=
 =?utf-8?B?ajJ4WnM2ZlZXL1ZNN2IxbGVFcDVqMy9sb2taTzc0RGR4alpEeUVlU29MLzRo?=
 =?utf-8?B?N0plYWZlRnovY2M2REx5dlpmOFdBdkpBSlZaOVVFNGNDdldaREhMb29xUnkz?=
 =?utf-8?B?bWhpMWk3TjlzYjc5SVhaUXh2dC9RcHN4a2hha3Z3SXJoVHpVOWxGWXJBR1Z4?=
 =?utf-8?B?NWFZa2VJUVdLRzhkL3V5cDFWV3YvNlFXRk5wR3RWNXJ2SlIxT3pKaFlLRit3?=
 =?utf-8?B?Ti93UnFxUzRWNnZDODVPd3BFMG5IQ2JmQ0YvZDZ5Rm5KZk1NSzV2VExadWsr?=
 =?utf-8?B?Q0tQUW5uSlg2WmNvdW5MZVJlTTFzQ3pZYU5JdlozbU9rK1piN2FteUxHVWVH?=
 =?utf-8?B?YkJHeDExUnlzQXlRV0ZLT3hWNVlNV0s1bDZCTU5zNjdwWnVPcHg2TW1OK0lM?=
 =?utf-8?B?YjVaby9MRXlQQ0JVQ1BWNEpqcnRHMDBaSm02MmxOU2ZXcUJ0eTN5dURNOVAy?=
 =?utf-8?B?MFkvQnRySnZZM1ltS3RIQ0RvT1VndCtwTkNTVExkREYvZWxNYlVkS2pkQ2s4?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bdd115-a7d1-4289-ed7d-08dc2da82494
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:58:57.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRhj99Jc1dpNPHSes84n11fjmQSZzm34ClsSoOfRUABZQLXVamJX6bmYWrow/j+7RkYLTq72YCSfJGdYd0xrSZ8SoHgVUcJSRV8OPkgcx/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
X-OriginatorOrg: intel.com



On 2/14/2024 9:59 AM, Shannon Nelson wrote:
> These helpers clean up some of the code around DMA mapping
> and other buffer references, and will be used in the next
> few patches for the XDP support.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

