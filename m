Return-Path: <netdev+bounces-75067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7CD8680C5
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAB8294D54
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77D12F39B;
	Mon, 26 Feb 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ip4bHEtw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31312E1D5
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975113; cv=fail; b=c14bl1WFjndODIlyyoLZm9ocOX+tcOuVJRttqUlY+jB28i2BtDnZiqmzvG/XXCJyi7SweVIBX7CUu6be7a3tVEYX8rtcJWF/VUMBr0wRF/No5R1cgoksrWa9dSD/TfnaOPEF40n14Grj4xSZix8o6G3DTJe0zxhbQmlijjFadVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975113; c=relaxed/simple;
	bh=7VyTu79WtRu+mRT1Lf3UD46w1i1SvP3Hp9zGIk2xxss=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALEzvaDeh+hFVRH52A9jfkmUaiKjtLSivwi37PEGa+sNKdtCv7cymVJGbjX3wWX/KPpPMgh49ZvlGbItucbcd/RAhCQX/r+PD4WE8XBjZJjndAG697eA7ddfyu3bUuUhO2O6grDv1uTPIyLdXyjZQBMXYtwnTVo1lyMO6wOUvOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ip4bHEtw; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708975111; x=1740511111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7VyTu79WtRu+mRT1Lf3UD46w1i1SvP3Hp9zGIk2xxss=;
  b=Ip4bHEtwfPT18fyT2UoeTeFsAWJNVDOgMQnW7ePVtnVdVAV8+o1PbYao
   m1l1eVpRn321OaKXlX9XwY0UFQhF7UNgjXhlE7tVzKttmpP14PMOj/ZJZ
   V6RT5oYE7QcEgV2Is/jyVE4SUUAZWZyk7ELBm7EEE5aOYAjo2VUpOiapx
   a4W+XKkCaVTDFMQPScn9bdRj5pFKL5gVIKdHQa6mZX9wVkg9CgVzDUBCo
   bEFINEDzKv0VRmlm0OfCUuAbz9Tisy6KxjEhDflwmOq/S/BYarA0O6mNO
   tgHv7yZ/ySUC2aGl1EWGvUsrLPab9jmpSSaIkTq2pAyR2gGSqwkv2BM0o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20827904"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="20827904"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:18:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6981775"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 11:18:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 11:18:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 11:18:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 11:18:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnvbOlgT+Q6DQLiJ3IuRBwQLA/XNzRtNef1u9B16Sx6In14hytDgSTszX5fIIHo4EEZ/ge1rHgDBWPlaYpRw3tnT3FTpj1dbri91lPRkxFGVGJjx2pBlgK9iWGL4KpKLpFDectSTdTm8jr+VPGLuEnyBLzhVhbT9Qnnq00hwC26t06vTwCClsdsBiK9UpstkmVDbxRBBuY0zZ+iMX3aoUJiwAjxK2XkYXrWyMjc/yJhq2aHkDGkzTT2Z5ZoJNDsZJ6tz/hl9mHLS3YiVtGIEwHI4gPhNZAplW0603YRgjSaWoERVzKwvq/CWzpn+4lUxKHl+xfmbQI2IRZXRpwW9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a68i4nFhZhyd8atQt0rMtUT+87M9agsqrvXxq83y6zg=;
 b=MUHWArmf/SdS3JtzGO6SoiF7nQTw33UcS1hDbr4epoWlhK66KI37disex1DA8vakCntoydVmDCgrsdYbBxJ1coRq+OtEjxL/hJ2EkWXGryxTyN+cnSu+3Z2RJvjvzstuvfeppKTPbnVdo4y9PkC4RLuS1x4857zLc3N+Dylk/1eMoZfyxzfT7viPfg6bi4UfRs8yOSKKWXMLImwPiPoB8HR0HQj6iz8eqpQIJn27qbbGyI0J4qvFbB7Q1tUcVlgkMxncrSH86NqTsKN/lh1l1UFo8FPypHil+/EBpca52+Zz45pngkubft/0vhw9H7HXyRGxe08AEIuuMVRUF0s45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Mon, 26 Feb
 2024 19:18:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Mon, 26 Feb 2024
 19:18:26 +0000
Message-ID: <b712a3cf-7033-464a-8a02-3f923cad7fe9@intel.com>
Date: Mon, 26 Feb 2024 11:18:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] ice: add ice_adapter for shared data across
 PFs on the same NIC
Content-Language: en-US
To: Michal Schmidt <mschmidt@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>, <netdev@vger.kernel.org>
References: <20240226151125.45391-1-mschmidt@redhat.com>
 <20240226151125.45391-2-mschmidt@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240226151125.45391-2-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:303:8c::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d0f744-a445-4c98-a4af-08dc36ffb573
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpSc+oqbpFc1qjftO9Y2L2rkKnpOUB7HeOiftrNCQIr04KspNorOQoW3VwM2ba9nxYFgCT6c7nNZDCyPNX2dKcWRNvH93HBq+waSqoiGb3bUUUll9SXU+583NdR8L+LChspZI+SbxRMcDO680dyfiRjRWgtMat1wF0jt3ShsEvwb1WLH0X76iXpmMKXY85qIwNSpJhV1kWw+IMS7uUVqDVO+51K15dvQ4n7eku4WyItqzeTkRu78bIdVVhsOx27mpgZcADYq4jjICEdYU7jSY6Xl419sgW67TiAo+JXyauc511nBLGRRnabrWb7s+ILjrAiw4OKbnpm8ArrgwDxi85T/HrRhu3R0I8ZAz6qlrNIuWUcXF6DUvqltR8ubGkFDJdIAyB6/T3FGk2+/rVLgMnwT2NdWtTcayMbaURmJ6JElKAAhU1pnQg3NZ+bqdplFfvm+jZu5oC1+9jpTn13gYwptrxt8HrtgQ+dNT1n4njq2KrHENwkvR21rxjWUJK5WVl/2DoOENpJIo8ZdMF43uOOcv6aArcgEKXQJDj/3gA4RWlGLjB9XJ8Q7l7tSniCiLZF/BKTV1H47X8fin03Gp3QElnoVwHCCroQfx2xTcgGyuASY7nfRrSJMmB5y3zJn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZoME1jWlYzSUZwYnNqd3RvRlR4WjBTdXFJS2lWc2VhYTRJUEhBT2MyRTVy?=
 =?utf-8?B?L0crZndVREtPT3VhNzBiTFJtRkJYM0RMRHpBa1cwSFdQNGtHcUczTjlPU2Nl?=
 =?utf-8?B?RDFEMFJtUlpDSXhUWjFxL1R2dzJxRjJ4L0xIUGZ1MXp2UHN0UHAyUFVaVjVQ?=
 =?utf-8?B?b0tWWDhqMXBQeW93cjI3c0RMaTVwV2EvcTNiZEo5RmdudGxyMVFlU09LTzYr?=
 =?utf-8?B?R1Z1dFlTckNUaFFRN1YyMGlYZU02eG9LZnVQTDU0bVVvbGNnVGdGdkN6NE0v?=
 =?utf-8?B?OXhuSGkyR0h6d1BEdFl6bDh0TnZiWDF3dFR0Q3dkK0xuamowRENERkNaaW9R?=
 =?utf-8?B?RFB3RHNhbk9NS1VhNzhPV2VmTnR0TTFuZFBRZC9PK1hiMjZ5NVRleHZsUjA4?=
 =?utf-8?B?S2t4TUo1Qkd3bXVGM3dvVkV3a0Z2RlBQdHM5OGtnSVFzWDRGSlhXUzhUU2dL?=
 =?utf-8?B?c3FhZU4xaXlsSWJ0Zng1OENWQkswdlg4RVpmb1l4UVd4aU5aQmJTb3NaamtF?=
 =?utf-8?B?NUVId0xKZ1VlU1lhTnE0OGU1bUZGYWJtM3VmYmpHejV3U0hFd1lyQXhmYjBT?=
 =?utf-8?B?bHM4Um9jQjkwaHR6SnJndUJSVkYzSjJjM05qL3VBaXNTM2R5ejFxcHVYWDlt?=
 =?utf-8?B?R0s0bG5pa3Zzc29zMmJ3UVg1NWdjTVZFOTUzYUx1RVc5ckZDSUdLNzVCdjY1?=
 =?utf-8?B?dDNQS01McGhOV1hyRktsNE1tLzZybXFHYUJ2cFlWTEVucTJZYzBSdUFqMXM4?=
 =?utf-8?B?SWdjOHpXcnFmcmpOS0RSTTVPdDUrWUlVSm8reGJFMFFDMzVDajJneE5PVVZW?=
 =?utf-8?B?NGNHOWJkZlZ0M3JENDU4TWFWakNFaTJDcC9sVkI1WFY3V2RuVXN6ZkhkbGk1?=
 =?utf-8?B?alpZMU05Y0lMVEJnUzlkN3FHNWEwR1JsSFRnaUFjalh5elhDRGZkQ1U4ckQ2?=
 =?utf-8?B?NFJ2bkNYS3NIQkhuNWlTME1FN0tFRDdLVkp5TE9FMnJteWpGM3MvdHFmckRW?=
 =?utf-8?B?Y2J6UTBKOWttZFY2WGZtTDhvL0NWRXIxd09lSnpndzRnY0ZDc0laNTBNT0Rl?=
 =?utf-8?B?OGE5U040UGJ1TGdxU2ViTVd2V1AvOXhUcmlwd3ZSNzFTMGRHTU5DZzVHYndx?=
 =?utf-8?B?V0tKK0Y0elBkVzliMHErS1V4d0hZOGdNcjdGMG5uSDZIa3ZaQ1F3OVQyMXNK?=
 =?utf-8?B?QzYwWXVHd21rSUhJaDV4ZXFmQ2cvNWovVGwxY0U3Q2RxVDF4S2YzTjBXWit5?=
 =?utf-8?B?UXlaMGhyWS9LVWZxMTdnbXd2bWhLYk1HNmRRTlJiTGQ1WmxxZTY0SVVBdXFQ?=
 =?utf-8?B?VDFPcUNuVEZVa08yWUNrajhDRm5VbUEyRWpUUmg1SGw5azZweWRmK3VCS2Jq?=
 =?utf-8?B?bUI4Ykd5aEIyN0FWRVdTVCtCKy8zbk5ETEh1c1JnckFkVDlzR0hNZnM5dUtv?=
 =?utf-8?B?Y0kyeVRzMWdHbTZNTjNZMnJhcWtQYWt6a0VXMlpZOEl3Ym9nR3ptQy9WYzRw?=
 =?utf-8?B?QVo1S0JNWnZQS3VyZUdzMjlqZFVxRmtPeW9HalpybUtLZ1JTSGRnMG4ySXBy?=
 =?utf-8?B?bUpMLzdOcTFENk05T0xwNWNpQ0x1UEs5WGEvaE1FMDRJWW5FeFkwOW5Pdk1X?=
 =?utf-8?B?OUcra05VNlM1T2ZtZnZsSnBxaVVzRmhSN0dreTB0V2dqV202VWIwT1hPVS9W?=
 =?utf-8?B?ODNyS3JkRWlhbGZyZkhHQlRHQkt4VFFvT3BDSngyaGhWRzBTR3liZjlWYnRi?=
 =?utf-8?B?NVNCcnczRVEvTUtMUEpEbEZ5ajAvTnBFTGVwdmF2N25qVlowWGY0ejlWR0hr?=
 =?utf-8?B?aWpEOWJhdUM5STN2eHJRTUxWbmxZdXFFaVdtMENNZjQwbGFjTWxTMWprTVk1?=
 =?utf-8?B?Zmxld1psREE4MkxqaGRzYnJpbkhqMlYzbTZoaUoram1YSHgwYVhBejhVNGJQ?=
 =?utf-8?B?VHhPWlltS28rK3pyY2FrYXpXamdtSkErRW42MW5tNVZrRURiQU54SHZMYzJj?=
 =?utf-8?B?SGYwRGozL1IzdU5JWitieEwvTDhDYmdYR0o5VDRCMTJjUHFJdUlWWFNjUjd2?=
 =?utf-8?B?UWk4Qy9UOWVzeXdvcFFLY2wySEIreXJsRWVKaFVZMW4vSnc2azFYQi9VUDVT?=
 =?utf-8?B?OUNCcU5SaWtUTUdZUTVrVWJieUNWblhXQ0t0UkhVQUIzeWxPcks5K0hEL1J6?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d0f744-a445-4c98-a4af-08dc36ffb573
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 19:18:26.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ke7IJK6VOipO54C3Vn2wlvHAvwNFbU1gMF/S++xpEDvlyhfNNOJlvloGg1l+EhbkL8iuVtUPgLE1yWOQydwCVfBZ7lwAQr9Q5bddeQ4YbEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8066
X-OriginatorOrg: intel.com



On 2/26/2024 7:11 AM, Michal Schmidt wrote:
> There is a need for synchronization between ice PFs on the same physical
> adapter.
> 
> Add a "struct ice_adapter" for holding data shared between PFs of the
> same multifunction PCI device. The struct is refcounted - each ice_pf
> holds a reference to it.
> 
> Its first use will be for PTP. I expect it will be useful also to
> improve the ugliness that is ice_prot_id_tbl.
> 

We could alternatively have this be part of the ice PTP auxiliary bus
interface we added. However, I think a cross-adapter structure has uses
beyond just PTP and this implementation seems a bit more simple than the
auxiliary interface.

