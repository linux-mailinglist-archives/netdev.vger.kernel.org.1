Return-Path: <netdev+bounces-88911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066188A8FDC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EB11F21DE4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFC615D1;
	Thu, 18 Apr 2024 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gI1/6utR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107531A66
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398884; cv=fail; b=lHXTgagS6CEVdmo+LIMBxxZnxv1pWy8tjbcRQHFu4VmO29Qslf3wbzePwhMNrYoV6dArhUmpYR/MzY1yeOsKSuCIcWPPWxvkK6XlZcQLB8Kn4IcktxUXGWmznzMAUmF7tzmVojimRwrhe9Rdr5wlOvyeziOSjH230vAWMXAO+/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398884; c=relaxed/simple;
	bh=VmdBBLOGJt89fTbF/S5M4N1bWI3FD65mIadD1W7lzYE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SpdPvfzeJ70kGYpfRqnE5q6aWOsk5E6PYtpB5HUDmbAXBfcTtS847EFDA9Lk/cd5bRhoaJu6FPvY71rwCVsASgFcn4eCvFI7MC5Ru9Ka2BHwCJThv4hKgRUeQ2v+VRLMGm1PX1mPfloIIGulmmmNO4uylH0uChqdSvvAPpdWGyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gI1/6utR; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713398882; x=1744934882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VmdBBLOGJt89fTbF/S5M4N1bWI3FD65mIadD1W7lzYE=;
  b=gI1/6utRhVPSAL6FNMrdpWZRgPw5lXir0yxNBxss456CoAhEhRFvlWMk
   bcEhe+RjrfSnU2nRJP10b2Hxzgr8dkohqqS1bjP41EliqvNEVHbnEBELF
   3G0E79N9k+4Ay60qLXJNW5qVzNqmTRmKGCbICm8MEjEjW/2yvvsvM4wTi
   u+HRVYA2cMxyG8JZb+DO2bJ8hIfUlFdh9a3saDoy7frmHlhID5/24pBJ/
   9lcxQxxlntvxg3lgN0SOhXXre1SPKy4H7zsP1pijucNdO9A7IWGFLPXoP
   CbLv7TIWS/O+HGJlLScG/Tg2XdsKmjJwMQWlUyJry0qdzgGZoddsUIXqy
   Q==;
X-CSE-ConnectionGUID: gmxS5iWUQQWvR7sUVEKKZw==
X-CSE-MsgGUID: QG+7iSTnSuORh/5u0pgIzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8781423"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="8781423"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 17:08:02 -0700
X-CSE-ConnectionGUID: +Mf6buYOQiOioX+U2UkAKQ==
X-CSE-MsgGUID: d+R5aoLBTZ6n/R396JJ4Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27589950"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 17:08:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 17:08:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 17:08:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 17:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do68UVh8gHuVJShcpkh7cfARanj0dUOhmq4SzfVxLC/cbCShp1+blSnZsILOfiQvcQ3Y+GwAgqJAEy+ZeEawGJ4qF/g/d/gRh7dyzdbASNmSB8opl1ua4854iK1s98kfvm5YDGLqG4GyW5EIqT14TbUIvv64qsHz37hUu8DNGT8Qpz2H0sWzZ04+o7vd9VK53+nJmZ6VNh+QuoJsXEOoZgTJCWufN5efzCZBDeEe09QMpxEcmkrYF63MM2wibHaeMgyiH1QgeU3SFzSCIBHNaWWc9+/fj0gnAHxdOpm6O3V+HkUxpr2nTl89Eba/cRO8JmiuF7gedU2t+jGAWxygOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9U4W6iW8H8NWh3qA2npmCDSTOYDp9wIo3Dtnv5iMsw=;
 b=D/fhljba+RtQvuBfrMhwI972ofWTBgKdPrbY/LGLs2lCIdMsYE9lNvQS+z9G1AtPfvA6MaZOfcMz2HiqlKofWG69hiFJ1WX3qPRnfYkUK3cpm4mb7GykHRX9GvjausNvMKy1yiP66M/R27ut/4n8BPRJUnPoSJydUL9WWMxnklFMeFdcAq0GQcRWgqDd8q3bUsioGHXLMtLgeyrbhYmKaFZrqi90XUU0NzkJBN+nV4iSz/+bt0Rn+Ubgw0CUpVX0HvUHghPh8MLd7YTgy9X0yhuqGt22GvwpDG0Aic5b3jcFbj7fhN9wzqRktQQZab/m/dJN0Xr+HBBjmvde/A/0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SN7PR11MB7668.namprd11.prod.outlook.com (2603:10b6:806:341::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 00:08:00 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7472.025; Thu, 18 Apr 2024
 00:08:00 +0000
Message-ID: <465ca06d-49e3-fe91-c41b-97726c6e6471@intel.com>
Date: Wed, 17 Apr 2024 17:07:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-next v2 5/5] ixgbe: Enable link management in E610
 device
Content-Language: en-US
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <horms@kernel.org>, <vinicius.gomes@intel.com>,
	Carolyn Wyborny <carolyn.wyborny@intel.com>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>, Jan Glaza <jan.glaza@intel.com>
References: <20240415103435.6674-1-piotr.kwapulinski@intel.com>
 <20240415103435.6674-6-piotr.kwapulinski@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240415103435.6674-6-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::40) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SN7PR11MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: f80d34e3-88c1-48a8-f96b-08dc5f3b9bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdcw6lgH+kHbo7u+WAq9p8HzpasV74XGTmHDmOs8S1+lVurB8z8UcytVGCf4/RtYPZdM7FcfoOVc80u5oVrnf6URBwPaExbDI+4qBhYMUiNP3Hz9CxDI2s/rgEqb/iPRrQGegtwXTQGXlHmVkn/WLhesKRWPdHpc4KHVFNLK3fOltC6V1e1AGYA6xwyUdZWxQ1bsB4bH5tDOXstLCS3Bhd+KwlCSNvlF6vqMwyEdUhmXrqr9s9VWY4x+bPTEiqss9X54tLyvUaWmw4pjr1/Gs8duXSTn6CtJxqROQ/zQujVT+NHwVb6iImQcKfQ2XEk6zbBLQfZI6eg4pha3LAkxJ0cTtmyxQnroIrlo8qyJHbpckLpwSYhqogniKUt1msG3wQVDFUne2mY/EC2IMAhzLyJfCcBSy5h9Y9DjZsKguAlYbfyeSFAPfzQtVabKN126clZp9UBv2bJ7JTusy7aQaBPE0DXP8KS6W53y7RpnCpcsn6q09BohM5YzBG3kVxNL+/+EmtPIa8bH/FIXDikTscTv3yIRjAzFC8P8wsW2t7WW5snP9idfmi/SYXDBVPibIUohYtUaNHbNNUFMht1g5Lz98RJsBF0rsruhuySmvOUisGOFhRi/qr6zGYEi2pJ9oAW1a0fzDXdaGMpA0Jicx8Mfh3YwoiYxNenZkUjPWLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUxVSTNzelAvaXhjWTNIN3VWSVFpZHJoN3g5ZUVnR3VuOFdyVzAyWmUrRjRO?=
 =?utf-8?B?c0hNb2FKYlkwZVJFZDVpS09lQmsyUGZNeDVzMGFzTkRKeHhuMzNQODBLSjA4?=
 =?utf-8?B?MjlsZ0RYYlBKRjNPTHI3OThxdFZIU0greUxJeGdCeUlsYVRIVWRueE1mLzdL?=
 =?utf-8?B?RWU5L2FxRTVQeTQ3NVF3ZzJRenBLNURSdlRKdDNzTmhyR1JDSWNaVVBKMjNi?=
 =?utf-8?B?YmVLdktGL1U4SjBFL05GSVc0VmFvZ2dzcG85MFhkWGcxMlg0WDk5cDYzRy9E?=
 =?utf-8?B?bm96MFZpQnkrcG90d3o3UFlHTnNrRVNnRENnTUJFc1Zuc0dhT3RuQUp1aU9i?=
 =?utf-8?B?T2I1b2w4NUczMFYxck0rYWFSazJqbjNpS21qc0xZQjJXay8xa2Z3NFR1T3Rn?=
 =?utf-8?B?R25iVFlvQjZwak5pTTZuSUNvWDN2QlpIc2RySndqWU13RlhLYzM1cVd6VDRE?=
 =?utf-8?B?WG1IR0V0Q3hkNHdnS2dOUnhlUXhQN1RiaEU4TlRwRlE4UzIvTHhJQjc5QlRs?=
 =?utf-8?B?QkpMdnpPRU9zLys1bDA0VmZreEZKRzB3cTlsaDhGOTRvcW01aUp3Wm9ldmh2?=
 =?utf-8?B?NGd0VkdFS0w2WTlBcjgwaGJNVVQvWGdQNXZwOURBTkVnVHFCMnhpUGRzWmVU?=
 =?utf-8?B?Y1k4aUppOUpTaWZFQUpYM25BR1RjeDBCSkF5VCtMUU0zNUlMNFl5NkNBWGl3?=
 =?utf-8?B?OFUxK1NxZFRqazVVTUpqc3l4R1V1U1JIdkYySW51R3M2K3ovdktaVG9TWU8x?=
 =?utf-8?B?V24xVDZEVXFSZDJIRk9LMnlDWXlBZ0dRckZzVHZDWjF0L3RuZUQ3NStMZUtR?=
 =?utf-8?B?Nis3QW1hNndNcmROVk9GMmV2UjFFOHd0STZDZlgrQUJzMVRlTzlaZkFFUEdh?=
 =?utf-8?B?bzRWNFEzRnR2WHh5UmZPTzh6bmhSSWN5OHNOR0xzYWxOTDV1RmRLQ09oREd3?=
 =?utf-8?B?cUlDN3lDTVNmZkxHSGhUaldWN2lybDBsQjRPakQyNmEzbTl1RnlRVUtWUisz?=
 =?utf-8?B?Q3NLcXJ5bzRPTkZjemw0RFhjZXl1aG80MnJ5dTFZOEJFeVdab0JuNno5cER3?=
 =?utf-8?B?YjdBYkg0ZENFTkJPT0FyR1orcXI3R3o3Q3J0bXlHNjVySGQ0WXZxbHVFVEda?=
 =?utf-8?B?NGVzUXZkRU0yeVBiWWdLWFNrRlprVmIrSnZpQVVCcGU5WVlHRUVtUHUyeVJM?=
 =?utf-8?B?NFBDRG4raGlvSU44SGlIM1BwYlQvYXZrdlJ2TUZSZ1Zxd1FnVyt6dVdKVlIx?=
 =?utf-8?B?b1dvUmdEOWxDc2xZWVhpbGZhZnlqZGhEOUhWYWlwVU9nTUJyRXFBQ0xkR2c1?=
 =?utf-8?B?cjU0Q0tVcVl3VUNRQTFrKy8yVE5GZFo5UlVWOWs1QjZ2RHJjak1Mcnc5VTVY?=
 =?utf-8?B?V2dFZERyQ2VWcUdOVG85blMvMlNiYURob2lQdDhMZXp5ZEljdFJtUXQ2Ukln?=
 =?utf-8?B?cXVXZVorUDFqUHA3QzdaMTEyWDc1b2w5d1BSWkRqV3ptckVxaERkdi90RkF5?=
 =?utf-8?B?OHFFVzdMS0xzRVVJNnVxSTEyUngwUm5mbWhTN1JkV1RZUzIrQmpWSjkySnlO?=
 =?utf-8?B?QXovQ01GbkI1cW5qK1U5eDFpT2svTVJPdWhuazRGZGZXSGdTNnZkc2Nqa0dH?=
 =?utf-8?B?Mm5xbXE4MzVKZlUxMTZsRTJFNFdLZktqb1ZiQkJFeStGWS9DUFZpTGk4NUsw?=
 =?utf-8?B?QmZuQVhnRTFyOTZ0VUd6anM1VktlZmhUNVl1akJoZk9RTDRUb1loeFRPcnNF?=
 =?utf-8?B?bG5xbUtHSUtFREFDNEFvcWFESlBoMFlSY01VZE1ENmNSNS9qaWt6cVZoWlIw?=
 =?utf-8?B?WTB0Z1B3S1hTOEZNSTZyK0tmcHNSbzdaeU1MNUJLNnRYdDU0S3dwL0p4UC9H?=
 =?utf-8?B?MzBNUHB1U2dFNTVxNkNZWlJuS1dpRzJyYUdnTm5hUEtXM0t1RFI5S3V0c3Ax?=
 =?utf-8?B?VVlzT3hwcEJya3U4b3IyY3lWMHpjNXZhMWRIK1VhdHQ2eW5GZE5PMTZjZnAr?=
 =?utf-8?B?VlhRbzRWYjZkZVFlZnFXU3gzTFdtSkVmOGxiM3RKTTc1YUJHZGhCcGd4TzVw?=
 =?utf-8?B?YkRrSHExREpDa3hBOElna0hmUmZndFlCOHJKUEVkTUg2dDB6SXBIdnJzeVpH?=
 =?utf-8?B?T3NReWVGb0RrTEhnRm9BM2Q3SlNKekw3dDl0R1UwVWxwVHZtbkVMdjZxUjls?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f80d34e3-88c1-48a8-f96b-08dc5f3b9bbf
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 00:08:00.2191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcSr1bKBkzS6X6Z5+R8BoPs5NYhDEHO7E2i8voVCr7d+NRCxkxsRhI0WoJl8BaNHzytHiMxMoEbq9g8n5yYZXcbDOz2wkMCxM1sNNBOFBFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7668
X-OriginatorOrg: intel.com



On 4/15/2024 3:34 AM, Piotr Kwapulinski wrote:

...

>   /**
>    * ixgbe_set_eee_capable - helper function to determine EEE support on X550
>    * @adapter: board private structure
>    */
> -static void ixgbe_set_eee_capable(struct ixgbe_adapter *adapter)
> +static inline void ixgbe_set_eee_capable(struct ixgbe_adapter *adapter)

no 'inline' for functions in c files please.

>   {
>   	struct ixgbe_hw *hw = &adapter->hw;
>   

Thanks,
Tony

