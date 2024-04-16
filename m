Return-Path: <netdev+bounces-88522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B809A8A7894
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 01:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEF4282E06
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 23:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211413A869;
	Tue, 16 Apr 2024 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia4qK6yu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FC13A3E8
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310133; cv=fail; b=Ue1nkWFelYI/AcCcgx6WjjIaOr5ziQOXV8wl7inZ6k9mHRnQAqY6kWETzNHim1iXsTIxNehSGJgOZKATEx9DMMCiWHlHzkCcLNPOaKthDKitzUk+DNMDQ3O3CtvnNBqLCYgQlpFAn0te8j7keWEpfU/hK56Q6yaXPXY1k2OwqJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310133; c=relaxed/simple;
	bh=Xz5SDW5JsFLRo0YcpAmgm6o5s/OL+upRoF9kAx1XAp0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FWFZ3+YdmD6/DBMi5RxfwChN9Tc73VdAXCDKxogx9fwrVrswObN+xBEICrgPhDHMkzZ7f22Z0bs2jr2O76azdpY/NDQkEfKPCU/A2blQUmAmgyIN1U8jIeDOdOu/R8hJdeGGwTtfTqkf4UPXWMgM9BUMOUB0PjWUPo/6ItUM2pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia4qK6yu; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713310132; x=1744846132;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xz5SDW5JsFLRo0YcpAmgm6o5s/OL+upRoF9kAx1XAp0=;
  b=Ia4qK6yuK+/QI8PPYt9+WlxbOc+LrYZYbi8Q5oARaCYeXgOgCx30ZhdM
   7bKkym9X5bzm321s4kiDczcCI0qAYCFVvG4OnuEa7Xk7fDJJbV8o4NvNz
   +JvIiXtQehgpR0u7F3BHz5/9CxfAv+a5bGj12o+OuW1xYaytMapYDD8Ty
   p9gpdbEWvIPCCESG6WLHVFWVxMoAqZ6cIWUr7G6oonfgC93V6U3WOpiZH
   4NRPbbvorv+Acz7yul4+mHGlZosYAMVGMMzZ3fvxHRtquyeJc+ZCi0fkB
   4Wf9eGwzvJnTNd3RrfHczhp9HhR6K85UoXw0qxnAOd4X5U13hDHkG7r9G
   Q==;
X-CSE-ConnectionGUID: yLQv9GyATE6J4UhFO6wp0g==
X-CSE-MsgGUID: zQUSZnSuSxqu5Sx3vAxwEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9000204"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="9000204"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 16:28:51 -0700
X-CSE-ConnectionGUID: rwi95f1iTsm89Ka+L5JKzw==
X-CSE-MsgGUID: K8jmc0jJTn2kiCNWnaA8gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="45710830"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 16:28:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:28:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 16:28:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 16:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch7NOm3ZwcD3prFy4f9zZgXHHEYxcS6K6gu7Hc1r2neAC7+uKG3FzNt4esN97L/RBfF0o5ECIGHFTyOW+96h0SxF4aKIfYS8xi+WFQlqY3KEhUM7+dxM9Y23oaN9tEI1kVM0rFw0Oka00l37NIQ46vf9twrXJKn5ZoUcD93l1pAIOXklknGfGSgyRKAL5N2KNe4SFOrGjfsP2ddoxi+FxINqg91XP4k2WqoS6H9oFA9xMMbhAIo2E3QFq4qyT2CMU0x7fRJx6T4UVTilRilNF7VxxaY1j5Bt1wbCx7kbxGn4PEN3Fj639qp1EukSA8GkNOKUqaZsqZypxgzDya2TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmS2FFVG/T/GgetG3g92/NumX3waDXraYaVdl+pq9qA=;
 b=lSZHtzkinzz3Uz/cFDJYdW6eDeIUYkTpR9eiSJ7oZibkR6mr/KN2R4pr0puSMCwHoeRShHWPYKwXwDZbVnW+Qo+thVfevjIDtyoLsyi6XICBmJF9FTB4fWac6a3MWRE4ZkagWElb1qyLymvKvCSTRWC6QDBIYmaGXbzHzyFjH0WiL+OrB4GTH3XLKojCpmpWcCS/81ybHwCaK0N0oqH5CtEU4OWJ9PiGPyqdo6+GLrxorlhGVYy/jIohjSnxTlhndR72k0MaJ8fVtpKESa4lfUxh3JZJFTjd07vx9kvq9qSFovHXgY3WMok83PFkgMB7C7j1PmhEZ0D8WrONIfTJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CO1PR11MB5059.namprd11.prod.outlook.com (2603:10b6:303:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Tue, 16 Apr
 2024 23:28:48 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 23:28:48 +0000
Message-ID: <525bc12c-ce69-29f5-6fa9-ff7232d63d7e@intel.com>
Date: Tue, 16 Apr 2024 16:28:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 00/12] Add support for Rx
 timestamping for both ice and iavf drivers.
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <horms@kernel.org>
References: <20240410121706.6223-1-mateusz.polchlopek@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240410121706.6223-1-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:303:b6::35) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CO1PR11MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 07794049-f2cb-4cd7-6b75-08dc5e6cf7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Qv/v5K5YqiLh+M1/sOJlD6Jsbh1hS9w771ENTMRQKeiqjMqMkmZ8cTE5SQBs1FdsE9S5GWNMDw+xSy7r89DBY5dLFLuPU3N5bn2IbwbrZnbVXkj+/4kqf/2GiTRWwHunCNog3I11I0KrRzSn4LCjCZYYet+gMU59B/OrX23N2/59h0qz9pf5zGDkKnvApji+fZMmLJJ4+9k/dvTy9FuTzjZ3ZwYVkc0Xclyd0lhL8StVbcBl9h69r/p7cqK5Z/ZInZ263a2vJEZDhWewwdhgAkuNR0dplSTqy2CQ1DUcG8WP7Z5fUxZXm4p6HzUzygKc8Z4uBQpEP8Fzh7HkN4+K2iUbINsTWZm8APkV46GKjWCLUsUEIRpCZVjGowYgPKBRgjF2qMliv5YsFIj8LX+JZbc1hUahXODl5+aNFzIlSfShuYAUa+1xpMP0q5jfgVpgZb127GtDGqugYi8MsC8Jxw0xtwHHM581ChJXklaw8DGHL/UZ5spqZvhYYrStn0uj0TxlH8/HsgRNLK0Di5wRIXK96yCBvggW6jPu9rUstfAN0AEFU96sPIwAbAY1g8Hi+u2lKWrRG2Q7kiQcamrdQaFR/fmfC4RupxcyqtfjKMVwSTri0jfqcoTQE9oAfQKU2czOrAm0mZn9tNN1SCPbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE85SzVEOE9rdWVPa2J0ZVhKdyt4V0F6cjZ3T0t4Wkp1WEFnUXBBNllla0NQ?=
 =?utf-8?B?TWhMMDdKbzRwc1d4aFZVSFF0ZFMrdW1NMVAvL1dMa0ZwUHN3S0YwZ2UrQnl6?=
 =?utf-8?B?L2FDSjFVbmo1VEJnTTVLdGV3QjZTSDZKbDd2UkZIRFRKenNkMzIzdEVZT1Ny?=
 =?utf-8?B?N2xabVBWTkRTNXlrNExUVmdoV1hKUWpUUVNDMkR6SWJCVjlFQ25CUjRjTzY3?=
 =?utf-8?B?Y1doMTFwOGJacXpEelBHaE5IVGRIaG1ld2tlLzZDVWpEc3lhNUE5aWhXT2xV?=
 =?utf-8?B?OGIxZlVnYzh6clYyTS83NE9pb0lpd2ZkcTFXL2l0NzVCVktKWnJiQVFGTXdS?=
 =?utf-8?B?MGZaaVNTS3BWV09QTWxzdEg5V29acTdweG1GRUNRR2N0b2pULzR1bnVONFJ6?=
 =?utf-8?B?ZktydzlIbG1YKytjNkRhZjU5T1ZiZ0dKRnJkd2l4K0lqdmZOUXlGdEhQM2VJ?=
 =?utf-8?B?aUpDQlhjMjU3Mm1FeUU4UE8yZVJGbzlsN3F6cW1seGF0c3ZTNXcyT1duQ0NY?=
 =?utf-8?B?NHQwR3lWWHlEMXUzbEdiR3B6T0Q4dWhZSmRwZC9DdDlKc01MTzhYQ1NrNFJW?=
 =?utf-8?B?Sk9uVEJ6Qitibm5Ybkl4MFJneXZSUmNVUTgxTEhPRllVSkpVaDZFRWh1L3lo?=
 =?utf-8?B?eUg4VkR4NnRuWmNISjJlYVBjaDRhdFhzbTZXNytzMSsvSUZlRG1zZldYbytQ?=
 =?utf-8?B?YVY0cjdGVUtObWlGOGV3bUExZ1JYQlUwL052VXFCWXZuUEsrc2NwSDZVd1VW?=
 =?utf-8?B?OFl5OTdIT3RTS1U3ZFVZeDd3SjNNd3l0V28vRnpHL1B6KzBZbDVBUjVFMERa?=
 =?utf-8?B?ZWN1RStGNWRDS0h6Yjg0eXdKSENBWTcvL2lJcGhGa3hTVmtMVUFhbVJjcmpy?=
 =?utf-8?B?aVBzcHNBTCtuTWR2aEhZOTdPcUdyM0NlbGhKdDV6blZSeEs0MFhlNXQwdGRR?=
 =?utf-8?B?Qkt4dkVRU0gxSXBsN015ekd4VTlTOXpxeW1RVDMyQzYzRURpbjlpQnhVTkQ0?=
 =?utf-8?B?Y1NlNDllZzY4SFZ4MG82Q0M0RFhpak12TldkajRBa0Y5UkRyaWUya0FkZkxj?=
 =?utf-8?B?dzRsYUFRbVBsbWc3NmxtTnRBWGhmRlRMQzVYRmVhckxyTGh4SS9SYS9UdmR6?=
 =?utf-8?B?MHI5cExxOVV2VW1QS0pzZUxtVkxSSXVxOStLM1BCT1B2NXVuRG9GdWhTdDdE?=
 =?utf-8?B?b0tJMEV1S3hIVFRRT0JhT0RNa0RkYlBYUXBwcnhGQllpUytDaWZOYTFTY0py?=
 =?utf-8?B?Q0JibEhodEVXR3psTmN3L1lyODZ5WjFlWG5VbytLYmU0MnlLOU5PbDNsT0ZP?=
 =?utf-8?B?YWFCd0srZGIyVVV1V1BMbndVQ015SGZQQ2cyMUcvZzRnSjZUSm5MVGs5VkpY?=
 =?utf-8?B?MVg4dE1wZ2Qyd0t3WDVBMythWEgwQ3VpYzVQZ0ZPS0lkVm5ELzh4M3lWaEM4?=
 =?utf-8?B?bk95ZW4vL0lnR0wrSGphdjFVRzBmUHJ5Tm1ET1pkbkZFNUhxRWlIZlE0TFhz?=
 =?utf-8?B?ZUNodW5abUlRQ3ExUEx3NHFjLzQ5TVl1WlBPOGF1RFZYR1pVSkYzR29Hb0Zt?=
 =?utf-8?B?VDVKSGhMV1psb3ZmUE5pVUZIdm5xQXkxaW1QbDZMdlQrTUdiQ3BxTUZONHBm?=
 =?utf-8?B?VTRKYU1haGxhczNvcEM0TzF1SXZmbWczbERLdEFXSFI0Z3BsaEVVRFhXd2pw?=
 =?utf-8?B?cUdTd0R0V2Z5cTJieE5yU0lPRzNiblgrSTA2dkdTeUhsUGxQcEVGb0VOc2xQ?=
 =?utf-8?B?Z0NpSWliUHRPZHJ5RzcwRWhSYXhieUg2aE53YW9vWUpNVXdjcXFvSmNDUTNN?=
 =?utf-8?B?Wk1DVDhrN2t0M2pzaHp3Vkc0S2RIMzJnS2h0RWV5dkw1a0tjcnl1bC9ya3BH?=
 =?utf-8?B?QjVNZXZkSkd0a1AxTWJBODNRME1SQ0xFNHlxQWZ5RFdiY3JLbDFPTXFybCtk?=
 =?utf-8?B?VXI1YW5mV2xGUzRYNjJLbHpnOUp2cXlsUUtnR29pVThOVWEraEdtZjdqbWxH?=
 =?utf-8?B?TndibEdTVithYUFxMDdJUmxUYkMxWkEwZnVETVluOVowcHBWYW9mUlA0ZTFS?=
 =?utf-8?B?Z3JNdjhaKzJ6RnpucVhoKzFNSUdsVElKcDcyRzVPZkVKRHI5UGJjS0FQVVY5?=
 =?utf-8?B?eXorajdlUFJlR1ZXNDBoSHZZY3Vibk1tNllnZ2lhOFRwallZOGs0MFJnMFhH?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07794049-f2cb-4cd7-6b75-08dc5e6cf7b1
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 23:28:48.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /whlcooekwM+bfZ/Mut5Wha4RMfA/SU9I6oTXkO6xAFDqz2UacG797TD2K7gf9636OxafwGWbrcXPHMmM5PLHwpvqxCp5hws7xjXGAIZrdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5059
X-OriginatorOrg: intel.com



On 4/10/2024 5:16 AM, Mateusz Polchlopek wrote:
> Initially, during VF creation it registers the PTP clock in
> the system and negotiates with PF it's capabilities. In the
> meantime the PF enables the Flexible Descriptor for VF.
> Only this type of descriptor allows to receive Rx timestamps.
> 
> Enabling virtual clock would be possible, though it would probably
> perform poorly due to the lack of direct time access.
> 
> Enable timestamping should be done using SIOCSHWTSTAMP ioctl,
> e.g.
> hwstamp_ctl -i $VF -r 14
> 
> In order to report the timestamps to userspace, the VF extends
> timestamp to 40b.
> 
> To support this feature the flexible descriptors and PTP part
> in iavf driver have been introduced.

A majority of these patches are adding new kernel-doc issues (-Wall). 
Could you clean up the ones that are being added by these patches?

Thanks,
Tony

