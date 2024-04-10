Return-Path: <netdev+bounces-86337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89989E694
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C4328240B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB38170;
	Wed, 10 Apr 2024 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQ4/Xugt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0257F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707525; cv=fail; b=VMvH/rMO/BBhYuq036HWr5rQD4ujaaJUZMN+ncqJ+UB4GM2hlEFLjmNp4SCek8iAYFDWlIferUtpqLJQZmSxvehAgXbiw8ArQx45wvZWtRR1PJIl1D7EaaQ8jKiS6ZWX1J44b2jrbui5AVtYN/XKGfFTE1anBdNjwBNIm6YaEc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707525; c=relaxed/simple;
	bh=K397ANOPw3s958lsTXm7vQuEGlAIouuREzXWsKucDXA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r0X6J1+dmqcueCHpLzqcKesjwaB+aL2NFGRHZ6B1RoA+jyyh2rZL/FIHd1k95iDotnsVWoghkKe4rkDOGy4s8nRfNygms/310xbp4PY4SC+PshjPa4Bg8mFcsg5+xR4jJeHcT8453oX8c5Qr+kctyi5Vd40lNnnvVhbyR+ABqeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQ4/Xugt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712707524; x=1744243524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K397ANOPw3s958lsTXm7vQuEGlAIouuREzXWsKucDXA=;
  b=eQ4/XugtXEzGqKWmMe1jnHVGs1bXW7dsFfaSFJSAxUiEwKN+Y86R/epB
   LDzD7HVIcDwslVhTz0l57loU8NmgDDyhfNGnZuW6ppbWTJXYoUX/hSYik
   abwzkR5bpUSsvgyUY8XBa0mVsaMLxAfHhBT5kJtMQFcaTSXxSoLtL/Dy2
   r+2wo5Dplet3ieMy6OwtetVtqjg3XkvoBvEn9lLmkY/bQqSXF58MdFCvM
   Eplg559JSLSvHrHQnAMJexwtEg3gzLOUckkqxINicR3u9w1q0xlQfL1da
   IPLnptM9v1kjVlH/8z/27AQNMciKc4DaKT5QS8uSF4a/vqNzKgucwXXP8
   g==;
X-CSE-ConnectionGUID: CfhB0rJHSWWPGY7pdguR4Q==
X-CSE-MsgGUID: CGXG2EF7TLqsahOVyYfJRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25554006"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25554006"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:05:24 -0700
X-CSE-ConnectionGUID: R97bwYHdRk2EvodMjVuBug==
X-CSE-MsgGUID: DdEvTR5KRFeJFnTxcEX5sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20453509"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 17:05:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:05:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 17:05:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 17:05:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBxNZ7fkvMtiH6bYDM3EF7OXQjg/fEuOqGBfyREx9dEo3s3aGQuD/FYFuCAiRYc3LjiDb3bu0Ns9s1bfJmS6aW45OT4Qyj4YNBaIrWt9iR/vpbYDrSPfp3TM0mMdklXDrWYbkRNL7IQ/Z8Z3xczRA+5cw3xVNWrAetM5txqalv9GIq1WmUDvIBURRYfTjlR1RA0CmYZtBp/soY+w0CviMQ8ytSKSe2f8pvEsZ3vPDBaDNuf8ZSGv9GIG/oRmCjCWs2AWfgoQbsXWxIFVlAMFcZ4kzzp3OjSK47GRT1nSA7t8eM24Q4bybBG4OXg3kDLURZCbVArfYOIBhhyRGd8frA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1klWSjnxooiserpU/SvPYRmETXzgQ8Mv1EfnKE/Jln8=;
 b=PLYW69fAOlbd09w8Z1HfqCwRnJAduc4upEl5IQlbv3T5NtfQ24bNTnTKuxT9M6j47ASWCHT3C1elAeaef1l6Hj+clx1vtyxuyc/bOq47YgYHeIUKoEGBr8hmpq2pjSSKOjCnEVMzvmuFuLctSsfKnjCDUSDwwZmI78XEGxpQoKMZRC1k8SBdV5GDoldBMYiwyrqbddnJnzw9bNYpRGz6c5jVzyhwdyd4UHmnRLGJu31Kzf4GbCnkm5RG7E4TbB+15l59JlXELNX8y4uon15brqZeuwvc7pzNx2KbiN5qgf8Z8uYz1HvhH8ZKS6DfqovvDzBcpUevlaysqZYkRQ9Jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 00:05:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 00:05:21 +0000
Message-ID: <f3ea9bd1-8f92-4c23-bd24-3415e40bf066@intel.com>
Date: Tue, 9 Apr 2024 17:05:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: Fix checking for unsupported keys on
 non-tunnel device
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
References: <20240409154543.8181-2-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409154543.8181-2-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:303:b6::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6860:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MolKX2/EbxIsZLI84jwt8l8tm5C57EmT9kMVMDEi9fpZn3moD8iUNzZLTafzaeQSGWjl1n3DlUqJCZcnk3yljXZildZx/2STm7Uors/Jgifa8j6N0omdxDcfz0bJDm2H5vqX4WbKU+6SaeyiqAEsze6cip+E3YKjUhm2cHEqq/wht8odl/HSL0Y183geM263TGwZlHdByUfIdZ77XGZVTaBKD0T3xYCat4qpknZOZlkjUqNQI+upiuiyU6lkL9hmYx/ZTuiOd2N4Ha/dgQXzHDUyG69Wncx73BKEDNm6DXT7R/iXAVByK3rqSAyCBVaAET9fOYhflWzKJj6d84mJtZUu99MOgAt/PWAlv2Mt9s8POg8fOurqZKIzxTlTZHacrKcpm0p2k0bHtxyoWERJyS56+KwodyQkGaogwZQ/REOGyAfgRdWP6d802mcz+Uxsf2sLRAU2BapN7iNwyboj81iQSDqgHLu7364FMY1FI/jodatCbgV9QM6eI5REg5VEBFLv0Sw04VrtYCC2j/OpABoNTRPhsWsOH/ZiIvewEoJ+Hn4Cj3ZV+tLzlD3ZoUsXCuXQ5mDcxQBTfVMPMFnNRWTaC9n7CB023r8OXfSL8bFYVxYkh8QE52Yk/xhyafCyqMZ7+lwd1H30Vc/DN3Gn77eVuV9H8SwMwmUqpYyHLMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZZKzZ6SVl2WVQwSHBmd3Rnb0ZpQVBiMHF1MHE2Zm1XRjhwUUx4NlV0bkI4?=
 =?utf-8?B?ODNnbUpkUWZmekRsRFZlcTIvV1VicmVZSk0wUUJ5SHljcXJaODVSME1ENFFV?=
 =?utf-8?B?MFB5eTNYT1FXVXpmU2tSSms2U1BVOEJ6YUlOZ2hJMDBoR0NpK2RoeWF6b0Fs?=
 =?utf-8?B?VWNYcXhtVVlyYTZZVFA2c3oyQWUvTnlWWUVOd25BODVjK0FqU0pSWXNIQXk0?=
 =?utf-8?B?OVJ3YWJqWjAxNFVGc29FbU5YWkM3S2dZVUhvUXc0QkxvbCtWZFBnVlRWZ1dq?=
 =?utf-8?B?YmZaNE9WSEpzSFMzamFCODNVcTRWMStUSUpCbmJkVEZ2bHF6NDI0VHk4UkI4?=
 =?utf-8?B?VFZ1QUpwc0ZkeUFyS0htQ2VCT0I4a05aMDJnbDFNWkdDQnNnekhIRGk4WUlU?=
 =?utf-8?B?YnFaMzFxeUxqMzFCUEZkakFiZ1NIYlhiMEp0V01sZ2orK3cyTWRkVVd2WEdB?=
 =?utf-8?B?V2RGRklpTk9QL1JqSFpwQkFrbE9rY1lNNlFMWjdLRGlpQUp4dkdrTzZEUkVp?=
 =?utf-8?B?TWc4TVd3TzMxTkdHd3kzV3VHWjV2VVhDcjY0cTJsWmR5b25ZQytvSjFKcTBx?=
 =?utf-8?B?di9VSkt3MW44dDlULytTZmFPYWprOVpjUXJOTXFpMHp5Qm1wTU01Q200L3g0?=
 =?utf-8?B?dnJsNzhubjc2VnZiQ0d0Q041Wlg1OEtzb0VuV2crL09PZnNxck4zWXBTalJs?=
 =?utf-8?B?ZUorcksxMTQwZU9qaDRGS0RveHRYazlXQ0NwRXhoY2NuU0R5dHFjYUlLL05K?=
 =?utf-8?B?bnIrUTV0QlcxM0FpSElpUDQrVkhaa055djBMR1Y2QjlFTjFXc2RMU29GaGNa?=
 =?utf-8?B?Y2NnT2NWYmtWbXBhb2pMMUdOQ053cy9LdGhmK2Zvb2FEOXNHMTFlNWt4dFQ0?=
 =?utf-8?B?QUp4MHB6clhFM2cxcTFRWW1TUFFpS0Y3NHN4VkxIQlIrU01Xc1VGcGxBZnls?=
 =?utf-8?B?b1RhZW9MUWpvMEp0Z3drY2t5SytabmI4akVUTityOC9VcEVLZ1hFcjhReVlO?=
 =?utf-8?B?QWxBWHFObHJkcUsyN1ZpaTJORmxzN25qYXRSMVNnSTZVenJYb3FIWTN5WEpZ?=
 =?utf-8?B?U1R2L3pjVzBNdkhJNHFyTUtjZVBscHdBWGhTeVIzUXJma2tZbEV3UjJ1UkNK?=
 =?utf-8?B?SHMxWHlGNWlSaVlrckxDaEJMZHExQlRqaU9maThFOWNScVBUcllHbytiaDV3?=
 =?utf-8?B?dHYvNVFTVkthbG95aExNVjFkallvUlRNN1hacXhOTnJsRGhDM3NjcW1iTCtG?=
 =?utf-8?B?VnB0bW1GNDhiNCtmeGhxeGNBUEltbkNvTHNWeEhWb3BZa1lpVzROL3FiT1I5?=
 =?utf-8?B?TGFrMjB4SFNqWmlYT0h2RXhpSi8waUpVaWhLV3p0R3ZUVVp2UUVLdHNQUkFR?=
 =?utf-8?B?UDUxY3pkS1BoWEhXMW1xMUJ2RkwzbHp5N0JkQ3FCcHdUaytkYnRSRDRidkxI?=
 =?utf-8?B?SU10TG9HYnRFV01VRXVLUTgrMjRqMjA0bkdVaVRFWTYxTTRTVThMSFJmcFhR?=
 =?utf-8?B?N1AvVWZpLzhSZDVuemRXY3Z4cnBYOG9ZMmx0S09KVGY2Ym1pUk9jRGp5bHRG?=
 =?utf-8?B?THVBNVVGUVF1d2RWU3gzeDNJOVRlVktyRGxnamhKck9ISDdNeXNxdEYrNU1V?=
 =?utf-8?B?TGFidEZOem5XV1UyWGV5c0Q5ZGxFVVlyMFRiTElkdHJtNitQVTVSS1htRld5?=
 =?utf-8?B?NVRNYUd1OGxKM1hMRGYwVHFmamdXMndsZS9WMi9MN1pERHRMVWZlUEg0VDNU?=
 =?utf-8?B?UzN6azJtbHc0N2UrS29Md21NQ1NleWxhejk1NzZSc09ka1R3VDEyL0FNM1ZS?=
 =?utf-8?B?MnlWazNGNDdZNXA2d0t0azdZSkF3TFVraHdjaHB4cDE4RU9XMjBIcEpSeUlj?=
 =?utf-8?B?YTByaklkY3ZRelFMbWRkNzZNaVNRN2hldkpMOTJKdTRMR2N4SVMweE11dEhU?=
 =?utf-8?B?VkpoMzlpYnFYOE0vaDk2VWNEbmxYVzgyaE5VMEZDZWVTV00za2QvNnBkQmk3?=
 =?utf-8?B?d2Z2OHUvdjE2RU14dk55SSt1bXZtcTVkZ1FTUHRiQjJBcFkwb2VmK2tvZmpJ?=
 =?utf-8?B?RlpRZnRvSjNML3pKV2FQSTVxNmJtRWhuamU4Y0JZa2l2c2g1WFM5VGZrT2sr?=
 =?utf-8?B?T3hScGJIUVhPQUNYeFh3cldHWGFhRzlHZ1RjbVU3d01Ha0RUNzZTaXhmUDYx?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 415e015b-8769-42ea-bcec-08dc58f1e9a7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:05:21.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kqZrJzPxP+JVCnvVxSQb8JKEyoyoSbACT16OLtQqxwsCLL6wikD7GtzfbdcPkE2nzn5/E6/cjDOI6GghrOERGIAw3E9AEXzqvs/8DX1AJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-OriginatorOrg: intel.com



On 4/9/2024 8:45 AM, Marcin Szycik wrote:
> Add missing FLOW_DISSECTOR_KEY_ENC_* checks to TC flower filter parsing.
> Without these checks, it would be possible to add filters with tunnel
> options on non-tunnel devices. enc_* options are only valid for tunnel
> devices.
> 
> Example:
>   devlink dev eswitch set $PF1_PCI mode switchdev
>   echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
>   tc qdisc add dev $VF1_PR ingress
>   ethtool -K $PF1 hw-tc-offload on
>   tc filter add dev $VF1_PR ingress flower enc_ttl 12 skip_sw action drop
> 
> Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index f8df93e1a9de..b49aa6554024 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -1489,7 +1489,10 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
>  		  (BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
>  		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
>  		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
> -		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS))) {
> +		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS) |
> +		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) |
> +		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS) |
> +		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL))) {
>  		NL_SET_ERR_MSG_MOD(fltr->extack, "Tunnel key used, but device isn't a tunnel");
>  		return -EOPNOTSUPP;
>  	} else {

