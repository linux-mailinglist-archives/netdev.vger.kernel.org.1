Return-Path: <netdev+bounces-77076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0958700E8
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996A6B21307
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E323B189;
	Mon,  4 Mar 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETszH5Tk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056922097
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553826; cv=fail; b=p1KYDo/WV9pjZJarrM0h4JPjXV6TR0aOD49eE1ycGzNX1r9O9VW5945t0T64JFmy8A23a/97wQENViRjnGbsxFAuPvj25CXB5VMXqob8vEMaBG/Y1Bgd1fjs63bAxE+uOoZ+u1I+lki4fhilX1FzXL7avqsDOloLFujjEa2hGD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553826; c=relaxed/simple;
	bh=UOXnUOOIc+Yxhzetmzs4KvUtUtFxSNZGs081EhAq8zI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YSLLKcW4cRvyJAtgujIWl0nfHequl0ZhFuwdqSJyCsxzofMo7sZwArcMoG+g3W6dJF+/QM5gamjkNcP8ifSjUpiW4AwURrDRkh22qS21wMi6ruzgW08udE1GTriflhRcgfiFQnp80jBLtHJUuk3XM0BAxLIjG/GG++KVutHy9Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETszH5Tk; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709553824; x=1741089824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UOXnUOOIc+Yxhzetmzs4KvUtUtFxSNZGs081EhAq8zI=;
  b=ETszH5TkePMSPYw6OVvtRmDVrck1G9RNmpI+CIuFcZUftRV31jEWec3D
   wYiW4GWZ4CbWOCCX5nlIMdntJjjLqBmLmmkaTIERy8jWmJgmpT+dTrAAE
   JQrr5jsiMnoFRkn/zuialmZ7RWvL26HSXBYbMyIT1EbrdMEoQWsD2AoJG
   tIOPBrUQd/OJhB6mleV52uWBxzSuC782evm90AdxL4aPPz8vQSFHF6dpR
   kgwsVeXfPSNaNwIedA9lO5/fAVn3Cv9MFC24RVsZORgg7nhMMnKW/ce5Y
   mt8Hk2ETuHBg6v6tbtIf5ZEu7z9e9U2H/x5buZBlMmc+rIHVwAlsOKMh6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="15190570"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="15190570"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13640383"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 04:03:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 04:03:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 04:03:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 04:03:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQmPtFMAeJslkB2BIg3O/iIziVzREvNSG12OsslhnLP0rn0Dla2uQnWuTbmHYmXtFYUGpwwSVN10GEt34SulAul1qQzL7cc+ZPCWgL9im/CIKV771solL3YOP55giyGymG39yYWXP/etMUAj6C71hK2nPE9KD3Ue6wTCgQDbxusSDyILfn6krunO+clryXxekUUsFIGi7GdxMTKS53IYLp0Zi39PuKJxXx7J2EylodjPoOymWqHMPuqxW6NwYv9TD2z4pLDjDiTKkF/3SfW3hrwWNGJ42Wm+rcwy4WRawFAlp+v/XrjFPLwltSTEsV2O+B5LtnGBcsgtoG6XaJB2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg65DwQbppNr4ViCqW6DRFdmbjCBYqp9GWYUUk2ndH4=;
 b=BIO2XvV7z1k5XoXIMvVWtqRWBpWEkaFS4KwA1FCdMG77pSkT+vQr8U2TVdgo0sSFr4X6TlZ4qFfNiSTpkF+G+QknOOZf13QXdhfcnUa6TpyY02fzdv9iXpkvtBzxCfPU8l51lb5hFGJ+qN2U4CPUpqQUy0jwXdJwpLF+DCNf2J62JL+w2TqSuWQRGPTbTQmDzNRcokwDBxQuqq951VTcjh4/THB493ok3AkI0yzQWWRWh2qZN5L3YFfJM1ulrPL/qiseco/ZIsCXHWObcVAyfsxPnOzHICkz+Jhoplk7aTr3lQP3omuFn/bDMUlryanf0x9LKuf5el3rlQvdYQymvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Mon, 4 Mar
 2024 12:03:36 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 12:03:36 +0000
Message-ID: <7f749366-193f-480e-8302-fea7566ec57c@intel.com>
Date: Mon, 4 Mar 2024 13:03:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V4 15/15] Documentation: networking: Add description
 for multi-pf netdev
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, <sridhar.samudrala@intel.com>, Jay Vosburgh
	<jay.vosburgh@canonical.com>, Jiri Pirko <jiri@nvidia.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20240302072246.67920-1-saeed@kernel.org>
 <20240302072246.67920-16-saeed@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240302072246.67920-16-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: bf63df68-1818-4840-f295-08dc3c431f1a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMcsFliIfUXEsfzWBi95s68h4U1WhR3Vkr6AhoEDKjQn71RvEc2wVeHNPxXEt+YcxS5xB5cBba9DZVbeP9UOWzh4KHVP7etbuC3entub0OhFDvpOi9zpLMtgpuIbBo/YuAcoIV/Daa6kDFCh1hCTq8X+3aIex11gTUEpI38rTAMyfTz5Al6yjSFvqawZusGanhQHPaqw1E5ZU2jUouuJ76yXR2/Qx30qq55mF0cUHxO38EqwiKOIHJQdSQj1mKYPRJCIMWs83b42j+9/W1W0sFp8XBt/lvxfR52F5DMUFysxWkF14Fmj1Dg9woR5pUPZTl1Ug33ggBNHceLNhSv0F0gQfDVgF+03UP6/uCrHH9W4ibFVyBF6VglMA2sdHXgnDTwZmZy/FRt3+9Fd9f+nXe9JMJIqYIz4mdsahQbblP7hAqYut1VdcK2fQ3R2WlzOkrEEJaKnnwXZbKDDbRiFBweh5tX+DHZAW5a9khf59xR5GJkx3oiELPZ4LsW3P86Q6nWe1Z9IOEzjxEv+QBOfF3rd1vBJ0WiPJjr06PL5L93r6Gxrik637B9XBAHgypPBYDOb3wO0Nay+y3e3s4HY0HeimC9GhFff3ZCq0bNLQxLIqcC0g3Wf8++mr8/fB7fFGKxjDlyMFYZR159cH7tSXRiuyasC37Grpg5qyJa9XNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZtWDBnejM3TWdDZ0xZSnJGTTlLMG9ENDJMK1c5VVhmTU81VWJ0ejQ1Q2Fm?=
 =?utf-8?B?aGhlYktOR0taaytwcUVOSnliOWRTV2ZOVThrdHdJUHRoZCtzRzdaSlFOSnlm?=
 =?utf-8?B?bk5KVlVRUFlzR2RsTllDVDlzdU1xSnpwOFNLdXA4TnFtYkFuelRsRWFudEQz?=
 =?utf-8?B?cmhQb3pSOWI4eDdjbkZUZEltd0NHN0VHT0toWjQrYUt5dWNLNVhrZ0NpT0ZY?=
 =?utf-8?B?MEdEdVF6TENNenJUR3RnUVdHbTlMWnN1SjEydXI1SkZoSmw0elk3SXZjdjhH?=
 =?utf-8?B?eWU2SFdCM29OeitrRThhUWdKdkszWDVaQlNLQmFoYTdWckR2UUFLaWV0WU5G?=
 =?utf-8?B?V3padDlwZGtMRE5jZXJOWHdsWlYreVZ6cWp6UjU5ZFF4YlNwcHQ1a1N3Mmhh?=
 =?utf-8?B?M2dYaGlxZ09oSE93clNjVkRrN1dIamNSSTBRNUpRRUo0eVZzMzhJaElYQzBT?=
 =?utf-8?B?bE5wVndUUHg2ZkM2WWxFbEVqNWFxZ05odmNidUo4QklOOFZxWEduNmQwMkdJ?=
 =?utf-8?B?Vm9seVdhMDQrTDlpSTJtanBvY0RmRCt3UVlMb01yUUt2MGVPa21LdDBPR3hE?=
 =?utf-8?B?bnY3Qm8rSWJIcVExTVRyOWF4cVJjdEo2RWptbHpJM2N0cnhzQTRuR2tKR1NQ?=
 =?utf-8?B?eUF0ckY2NlRyek5SazVVOUptbmg2c2Z0TXQ5RHVWSGJ5M2hmQ3ZMaGJCek1U?=
 =?utf-8?B?TDJUbmpQU1VzZDhJODNwSmdFeUlQSlRqWjNYTmhWZUFPUzNYc1c2SVdvaE9S?=
 =?utf-8?B?WUZJQ0tYbjhjYXBTajVma3lBeEhOdmtMaWUxZ29zQURJNEZsMCtKRGE5bGpE?=
 =?utf-8?B?LzU0MGdNT2IzZUZYaS9jYjJ6Q2Z3bDgrTmxnMUVTbVFKK0thd2ZvU01yYXFH?=
 =?utf-8?B?em5KL2s1b1p6MnZJcEs2TnlZVHpTbU5nOTVyNzNuZDB1R2ZtQTFGd2lvTVRS?=
 =?utf-8?B?SHJrL2cwbnRINjhULzlGVEtoeVdFbTMvOUJOUkxkcCtVY3htTTJaTmdvb0FK?=
 =?utf-8?B?QW9RKzVjY0hEMTY5T3pnZDJ6YlhsRk5qTTBVL0x4T0pwTXUrQmJZSnhHUDdP?=
 =?utf-8?B?OWg5RWpKdnZHNUJBWG9vbHVQWEJkZ2Eyc3ovYkwzeXZQU3NCMU9FYlppQkM2?=
 =?utf-8?B?SmpIUWdwamlqQ20yVEZsZXBSLzhkYWtDNmRWQU0yRXRJWEpKelJvL3V3dkND?=
 =?utf-8?B?U3hRV0FjK1FUUmVyQXVjNkoxTUlzbzltTFpxQnEzRGN1bXJMVTRuVllWMWFo?=
 =?utf-8?B?UEhmSWFkaWNFVWpqTTZiTkRBUWV3d1lzbGJMWVNaaGlhZ09CbkVxaTArRmJP?=
 =?utf-8?B?WEpzZDZoVHBVd0FUUU9zaCszaHdZb011TldGM0pTY0hnWlpkZmNxQzZsbW4v?=
 =?utf-8?B?bXA5clN4TXUyUjlwaW1PMmk2Sm13TmR2RTZaYUQ0d0RlSENTUGJVWFpzdVJO?=
 =?utf-8?B?c1hYM09IUE5Rc29ZQlZaTm9DT1VWUGNNZ1p4MkJsTjcyTyszWUZJMFJOY2Vi?=
 =?utf-8?B?SVdRUDF4andyUHNMc3NjM2w0UCtYcVFoempid29jWkJjdDQ2ZFlNZk5Pb1hE?=
 =?utf-8?B?dElWUHYzL0xzenJCcEtXczFvYlExT0pXSzMyNy9hSHVnNzZOZWtqMjVyb1I2?=
 =?utf-8?B?dzYzMElLL0xCclNpQXg2UmtnQnZzU0VCOHdCZlNvQlhkT0VMRDk5WjcxNzE1?=
 =?utf-8?B?QXZqRkh6akpCTzkxVk1FM3JqSWl2dU92QVY5WTZpSlkvZHA2bk9naVpnT2Ir?=
 =?utf-8?B?NUM1eTdiMmgwdFRYakFYTFkzeHFPNUsvVFA4QU9VdEoxekdqK25sdUM4SWo3?=
 =?utf-8?B?YXZ1UlRXUDY3WnZLMXBLN3VMb1dFYlFoZENBQ0JUVHpnemd3N3ZodGhCcXZx?=
 =?utf-8?B?L2p0MnZXeWVyTUZHMDAzTkR4Q1BiNWRrVjBYbTNKdURrcUhkblRaMEtQbldZ?=
 =?utf-8?B?SlIwWnZlbjYzby9VUUI5VFlCS2lZYWFHUFZKODBOdHJ5VXVRVXQ3UWVMcVEx?=
 =?utf-8?B?ZldJMHAydVE0T2t3bzhjKzl2UmtHcHdEbUg0ZjNyT1JlSnI3a2E4SDZNaVJ0?=
 =?utf-8?B?RTdLZjlyZDhyT2ljaVE5aVR6Zm83V2RKdTFtaGpJSjFXUzhvNjdXdlJQeTNq?=
 =?utf-8?B?MFlDMUlGQk94YUJMTld4SC96QTF2bmE4RVR0Rm5CYzRiTDNOUHhpSjRIY0lv?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf63df68-1818-4840-f295-08dc3c431f1a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 12:03:36.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ky1w+B1t3vDBcpFSQnZlNM3hl5DNhh8czWaV5kLqkSrun3PFg7rpnj/Axp+Hg/kzihYFLScWxCbSgB9JVQF6DnKNcfH1oV0JyfWMKWePzww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
X-OriginatorOrg: intel.com

On 3/2/24 08:22, Saeed Mahameed wrote:
> From: Tariq Toukan <tariqt@nvidia.com>
> 
> Add documentation for the multi-pf netdev feature.
> Describe the mlx5 implementation and design decisions.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>   Documentation/networking/index.rst           |   1 +
>   Documentation/networking/multi-pf-netdev.rst | 177 +++++++++++++++++++
>   2 files changed, 178 insertions(+)
>   create mode 100644 Documentation/networking/multi-pf-netdev.rst
> 
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 69f3d6dcd9fd..473d72c36d61 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -74,6 +74,7 @@ Contents:
>      mpls-sysctl
>      mptcp-sysctl
>      multiqueue
> +   multi-pf-netdev
>      napi
>      net_cachelines/index
>      netconsole
> diff --git a/Documentation/networking/multi-pf-netdev.rst b/Documentation/networking/multi-pf-netdev.rst
> new file mode 100644
> index 000000000000..f6f782374b71
> --- /dev/null
> +++ b/Documentation/networking/multi-pf-netdev.rst
> @@ -0,0 +1,177 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +===============
> +Multi-PF Netdev
> +===============
> +
> +Contents
> +========
> +
> +- `Background`_
> +- `Overview`_
> +- `mlx5 implementation`_
> +- `Channels distribution`_
> +- `Observability`_
> +- `Steering`_
> +- `Mutually exclusive features`_

this document describes mlx5 details mostly, and I would expect to find
them in a mlx5.rst file instead of vendor-agnostic doc

> +
> +Background
> +==========
> +
> +The advanced Multi-PF NIC technology enables several CPUs within a multi-socket server to

please remove the `advanced` word

> +connect directly to the network, each through its own dedicated PCIe interface. Through either a
> +connection harness that splits the PCIe lanes between two cards or by bifurcating a PCIe slot for a
> +single card. This results in eliminating the network traffic traversing over the internal bus
> +between the sockets, significantly reducing overhead and latency, in addition to reducing CPU
> +utilization and increasing network throughput.
> +
> +Overview
> +========
> +
> +The feature adds support for combining multiple PFs of the same port in a Multi-PF environment under
> +one netdev instance. It is implemented in the netdev layer. Lower-layer instances like pci func,
> +sysfs entry, devlink) are kept separate.
> +Passing traffic through different devices belonging to different NUMA sockets saves cross-numa

please consider spelling out NUMA as always capitalized

> +traffic and allows apps running on the same netdev from different numas to still feel a sense of
> +proximity to the device and achieve improved performance.
> +
> +mlx5 implementation
> +===================
> +
> +Multi-PF or Socket-direct in mlx5 is achieved by grouping PFs together which belong to the same
> +NIC and has the socket-direct property enabled, once all PFS are probed, we create a single netdev

s/PFS/PFs/

> +to represent all of them, symmetrically, we destroy the netdev whenever any of the PFs is removed.
> +
> +The netdev network channels are distributed between all devices, a proper configuration would utilize
> +the correct close numa node when working on a certain app/cpu.

CPU

> +
> +We pick one PF to be a primary (leader), and it fills a special role. The other devices
> +(secondaries) are disconnected from the network at the chip level (set to silent mode). In silent
> +mode, no south <-> north traffic flowing directly through a secondary PF. It needs the assistance of
> +the leader PF (east <-> west traffic) to function. All RX/TX traffic is steered through the primary

Rx, Tx (whole document)

> +to/from the secondaries.
> +
> +Currently, we limit the support to PFs only, and up to two PFs (sockets).
> +
> +Channels distribution
> +=====================
> +
> +We distribute the channels between the different PFs to achieve local NUMA node performance
> +on multiple NUMA nodes.
> +
> +Each combined channel works against one specific PF, creating all its datapath queues against it. We
> +distribute channels to PFs in a round-robin policy.
> +
> +::
> +
> +        Example for 2 PFs and 5 channels:
> +        +--------+--------+
> +        | ch idx | PF idx |
> +        +--------+--------+
> +        |    0   |    0   |
> +        |    1   |    1   |
> +        |    2   |    0   |
> +        |    3   |    1   |
> +        |    4   |    0   |
> +        +--------+--------+
> +
> +
> +We prefer this round-robin distribution policy over another suggested intuitive distribution, in
> +which we first distribute one half of the channels to PF0 and then the second half to PF1.

Please rephrase to describe current state (which makes sense over what
was suggested), instead of addressing feedback (that could be kept in
cover letter if you really want).

And again, the wording "we" clearly indicates that this section, as
future ones, is mlx specific.

> +
> +The reason we prefer round-robin is, it is less influenced by changes in the number of channels. The
> +mapping between a channel index and a PF is fixed, no matter how many channels the user configures.
> +As the channel stats are persistent across channel's closure, changing the mapping every single time
> +would turn the accumulative stats less representing of the channel's history.
> +
> +This is achieved by using the correct core device instance (mdev) in each channel, instead of them
> +all using the same instance under "priv->mdev".
> +
> +Observability
> +=============
> +The relation between PF, irq, napi, and queue can be observed via netlink spec:
> +
> +$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml --dump queue-get --json='{"ifindex": 13}'
> +[{'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'rx'},
> + {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'rx'},
> + {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'rx'},
> + {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'rx'},
> + {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'rx'},
> + {'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'tx'},
> + {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'tx'},
> + {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'tx'},
> + {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'tx'},
> + {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'tx'}]
> +
> +$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml --dump napi-get --json='{"ifindex": 13}'
> +[{'id': 543, 'ifindex': 13, 'irq': 42},
> + {'id': 542, 'ifindex': 13, 'irq': 41},
> + {'id': 541, 'ifindex': 13, 'irq': 40},
> + {'id': 540, 'ifindex': 13, 'irq': 39},
> + {'id': 539, 'ifindex': 13, 'irq': 36}]
> +
> +Here you can clearly observe our channels distribution policy:
> +
> +$ ls /proc/irq/{36,39,40,41,42}/mlx5* -d -1
> +/proc/irq/36/mlx5_comp1@pci:0000:08:00.0
> +/proc/irq/39/mlx5_comp1@pci:0000:09:00.0
> +/proc/irq/40/mlx5_comp2@pci:0000:08:00.0
> +/proc/irq/41/mlx5_comp2@pci:0000:09:00.0
> +/proc/irq/42/mlx5_comp3@pci:0000:08:00.0
> +
> +Steering
> +========
> +Secondary PFs are set to "silent" mode, meaning they are disconnected from the network.
> +
> +In RX, the steering tables belong to the primary PF only, and it is its role to distribute incoming
> +traffic to other PFs, via cross-vhca steering capabilities. Nothing special about the RSS table
> +content, except that it needs a capable device to point to the receive queues of a different PF.

I guess you cannot enable the multi-pf for incapable device, so there is
anything noteworthy in last sentence?

> +
> +In TX, the primary PF creates a new TX flow table, which is aliased by the secondaries, so they can
> +go out to the network through it.
> +
> +In addition, we set default XPS configuration that, based on the cpu, selects an SQ belonging to the
> +PF on the same node as the cpu.
> +
> +XPS default config example:
> +
> +NUMA node(s):          2
> +NUMA node0 CPU(s):     0-11
> +NUMA node1 CPU(s):     12-23
> +
> +PF0 on node0, PF1 on node1.
> +
> +- /sys/class/net/eth2/queues/tx-0/xps_cpus:000001
> +- /sys/class/net/eth2/queues/tx-1/xps_cpus:001000
> +- /sys/class/net/eth2/queues/tx-2/xps_cpus:000002
> +- /sys/class/net/eth2/queues/tx-3/xps_cpus:002000
> +- /sys/class/net/eth2/queues/tx-4/xps_cpus:000004
> +- /sys/class/net/eth2/queues/tx-5/xps_cpus:004000
> +- /sys/class/net/eth2/queues/tx-6/xps_cpus:000008
> +- /sys/class/net/eth2/queues/tx-7/xps_cpus:008000
> +- /sys/class/net/eth2/queues/tx-8/xps_cpus:000010
> +- /sys/class/net/eth2/queues/tx-9/xps_cpus:010000
> +- /sys/class/net/eth2/queues/tx-10/xps_cpus:000020
> +- /sys/class/net/eth2/queues/tx-11/xps_cpus:020000
> +- /sys/class/net/eth2/queues/tx-12/xps_cpus:000040
> +- /sys/class/net/eth2/queues/tx-13/xps_cpus:040000
> +- /sys/class/net/eth2/queues/tx-14/xps_cpus:000080
> +- /sys/class/net/eth2/queues/tx-15/xps_cpus:080000
> +- /sys/class/net/eth2/queues/tx-16/xps_cpus:000100
> +- /sys/class/net/eth2/queues/tx-17/xps_cpus:100000
> +- /sys/class/net/eth2/queues/tx-18/xps_cpus:000200
> +- /sys/class/net/eth2/queues/tx-19/xps_cpus:200000
> +- /sys/class/net/eth2/queues/tx-20/xps_cpus:000400
> +- /sys/class/net/eth2/queues/tx-21/xps_cpus:400000
> +- /sys/class/net/eth2/queues/tx-22/xps_cpus:000800
> +- /sys/class/net/eth2/queues/tx-23/xps_cpus:800000
> +
> +Mutually exclusive features
> +===========================
> +
> +The nature of Multi-PF, where different channels work with different PFs, conflicts with
> +stateful features where the state is maintained in one of the PFs.
> +For example, in the TLS device-offload feature, special context objects are created per connection
> +and maintained in the PF.  Transitioning between different RQs/SQs would break the feature. Hence,
> +we disable this combination for now.

 From the reading I will know what the feature is at the user level.

After splitting most of the doc out into mlx5 file, and fixing the minor
typos, feel free to add my:

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

