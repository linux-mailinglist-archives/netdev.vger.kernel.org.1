Return-Path: <netdev+bounces-174644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB19A5FA65
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC8E7A8606
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028AD267F71;
	Thu, 13 Mar 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JB6F5TSI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA5145A11;
	Thu, 13 Mar 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880953; cv=fail; b=C8Xm78FZW2rhAwmQ2jWHYcYbzfK2C5UQeMyUON5xL7fUTIzNNWRC1MNph2q8ytS0bM8JylfnsoHExskRTwvZWB2dQ60CHKr7PDLi/5956JJaFIENrVuxtuyYuA9V5Pg7EtB73Q3VT6AKd1i22P42Pds4wo3IsinjWaT8V2+G23E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880953; c=relaxed/simple;
	bh=xXQVUi4mhntqEysWCRheTrPQ9tQwM2VHUEGkQ6Wxz+E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OUO+va2QniDWLCA2itM11YIJjQZ6yQNx0zlDLA1ufspDxZU6pd4+6TC3EfGuMkFwrt/QjF7JE7fc5Hb/z0BJDeV4DowNV2DEXYiBuoyvjLkzkCU6YNgryxgcII1WBRn9qP4NJxk6bB2pR/3VDsD1kr9r1aenXR3pfP1VDQlMGTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JB6F5TSI; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741880952; x=1773416952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xXQVUi4mhntqEysWCRheTrPQ9tQwM2VHUEGkQ6Wxz+E=;
  b=JB6F5TSI+JyTj0FZQRDewZ6uXVedw4yZCueGLbjhfeAuvaxIzsgeRpv4
   OU0P6IqaEn9/hPJep4Yl3fzx+ChdGtXbaDidsqZgHzpKcyb7VlXRsQHEi
   wpVa7JwvaaUut9Gq4G8Wrfh4q+kIX/hhOgbVlN26e2rk0663ni+sqgszK
   0TeUtb/Ak7UbJUQThhUSTVnfoYwjI5DqnngcEFlrCCKxAuQGMIBiAyKP1
   c1OKd6SnBA+TAqfArxIE3geMxOhm2LDMrAYVIzuBWoDPuWGY4pPPmh7aV
   IZ8z59JoIAGSvWwx2tMPVsIm7rjJdjp2ENtZYVkvpZMe/oKWw2AeLCY9w
   Q==;
X-CSE-ConnectionGUID: pkmY0mpBQ4ed8LlNoFFq3g==
X-CSE-MsgGUID: +oBVxv1ETJ2p9N74A4nj6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43185195"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="43185195"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 08:49:11 -0700
X-CSE-ConnectionGUID: xOR8q7MRRQuJxsu7eYX8TQ==
X-CSE-MsgGUID: WP7qtgYvTLmcG02oM4Qf2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="120779528"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 08:49:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 08:49:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 08:49:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 08:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+SK1U7UpYciZegWf2dMKr6WWRcze+dHhNhq7Eh1phb638BShD1s/Aq4H2xGgYSzIr9kr7xaxDVHMxaOEonbH+7vem0A/mInYQAnNX2sLr2f81jsvgJfMmFG5LyhME0M997O74ZXbR84h7L3n4QaRsuIlGRLFARfPeYTnneDxtxvIPQnJXeqLVPVejM4eTFSqRwKwgvJl1VtG2LxRCyN5XCmHn3UMaYkREEeSclrIkUh19mifKj8Bj6x28Q4QwNdC1FxLFlXBI7ev3bAOUyx5hlxgBJdF18arlMZbQrobrb0Dq2JAlnZMAA0o6GiCrTUME9j3P88gbpdCTv2M26lTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLj9vWZhDhQqHrn7NNlAoETE55ldxCZJQbqn4xbnLnQ=;
 b=kdKbF2I5RDM0PeI5psYGNmPH3VOheKXXbwhP4Pjqq3M3ZaBL3hhiN9ToCAxSMnQIlAJCvs0ThW+qLAXh75j+c27E6I6zaby1ePMejSa40meYKyJjIhPWLkEglpo/tdtJuZHtdoox/OEAITv7E6OAfRo52RPw7vOaPImYZjLYei0oxZkcUDX2bXs4/aGxcdC8lTbYdh8aNZG1ozaL1hKk72GTDQFrd0apqQ7Wj9fbdD4Bo/t1Er/wGpGmEK2KXXweRMZmtH4J5wuymHqKHor6JqmL0Ez4vexrhI49Ju+3sncvbGtLrPkpal0z2Pj49yu1rg33FcNznA8ONy8WUklZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 13 Mar
 2025 15:49:05 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:49:05 +0000
Message-ID: <3b83936d-10cf-4e32-a7a7-f16bc50e7e57@intel.com>
Date: Thu, 13 Mar 2025 08:49:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] igc: enable HW VLAN insertion/stripping by default
To: Rui Salvaterra <rsalvaterra@gmail.com>
CC: Simon Horman <horms@kernel.org>, <muhammad.husaini.zulkifli@intel.com>,
	<przemyslaw.kitszel@intel.com>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250307110339.13788-1-rsalvaterra@gmail.com>
 <20250311135236.GO4159220@kernel.org>
 <CALjTZvaknxOK4SmyC3_rN5eaCPqd7uvx52ODmDuAp=OeG0wxAA@mail.gmail.com>
 <fe021b67-94f6-43e4-9130-7b9a58919b40@intel.com>
 <CALjTZvb_=NaNE=DS10G=61WK2xXQO35d2sYOd9L=qJ+TtpeeXg@mail.gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CALjTZvb_=NaNE=DS10G=61WK2xXQO35d2sYOd9L=qJ+TtpeeXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a6e7e3-b0db-497e-786c-08dd6246958a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFVpWGRleWZ3WWZxTTFLVHRNVGRZUVZraXA1b25xbUluRjd0d25vMDQ1bVB4?=
 =?utf-8?B?UDF2MkFBLzhzVGxCM0tGRzYzN3ZnekoyNXROYTZrYURNbkVHRUFMRWZmdTU2?=
 =?utf-8?B?R1ZnY1drM1VCenJYN3l0N0lHTSs2QklyRDN5WlVoSjRZMi9xWVQxNVNQTDRu?=
 =?utf-8?B?TzRMUmI0N0dnSEtNQktvZXcxQk1RWlRydVBvTHJvUVdxcjBBU1VFQTYrMCs3?=
 =?utf-8?B?ckg0RlIvbkhFbTBqdEtac1VScmR4a1J5VVR6OFdUUlU0emI2K1BmeHpUM1Er?=
 =?utf-8?B?OVlZMGRLYTJ4Rk80QlFMbDRkWlRIRXMrTmIxMnU0cTh6UEp5OXpFaWlvUG9G?=
 =?utf-8?B?RUErT1ZhcE53dlNPOTh5ekdmODNIY0JYalU3K2tCSFg0VE8yQWZ6K2YvSXdj?=
 =?utf-8?B?bTR6SHVyZjVmNDg1L2Frai9Xb21PbDhDek0yd2xyODNhbUtDMG93YkhIa2tR?=
 =?utf-8?B?SmRLMXBBaVNiTG11Q1krQ01LcmRyMXRJUEluZS9Tbm1SUURlSi81eTlKeHVt?=
 =?utf-8?B?K05uR2N3OUhjaEQvakRtV2l1VWN2bkloaUlaNmZ5VXB4VWZOL01EWGdyVjdK?=
 =?utf-8?B?WDJBYW1vWWowbm9UZ2x2bFlwdG5kaUFNUWZHalp4ckFQdG1NWTF1azdaMzcr?=
 =?utf-8?B?RnlpNFNNOCsvK2VkTkphbW5obEpZSjNremhtblZTRnNCTkhIZlNTUHZ4TVlO?=
 =?utf-8?B?SUVKUUtHa1JUQjR2L05xRnBWZzNFeVJUUkJodEdpZFJ4bTNMdlVqcWpaS1B6?=
 =?utf-8?B?WXZ0V0RnUm54VDFlWjZNYkJ5OVBBOWloakNvVnNXci9iQ2ZWTUFNVFIwMkE5?=
 =?utf-8?B?VVVIa2x1RDIzY2hYNEFJZUV3U1hlc3lpM2p2czlhQXN6Kzk1YkNWWWRnVkta?=
 =?utf-8?B?UHl6L29kMFcrbjZzWDNjcDdOV2daMmNwOGhTaDNvRUpJdnNyemdGaGVQVjRN?=
 =?utf-8?B?SEZUUVJLUzczWVdxZElzTE1ubHJ5SjdrbForS3hQSG1NYWZ1OVBiU2VJZDM1?=
 =?utf-8?B?cVYrRFMrZ3R4dXRkRmtWc2xiaGExWHRsSVN0ZU81NWtDdFFJaWxkTVBsUitH?=
 =?utf-8?B?TzhtOURpYlM5RjVRRm93bllVOHo1dkx5c2wxQjZUaitIemJkRWZucTJWVmMy?=
 =?utf-8?B?Z0lud1ZFSjdDQ1NzOHp5bHJ6c2ZxQVBZWE9ZbUVNQm9KbVE0ZjJmT01ZSzNo?=
 =?utf-8?B?Y3d3K3hwSTdFTW53c1dxSHB6YjluMDNpZ2NUWFZOanZwaFVlRVN0NERqRGtz?=
 =?utf-8?B?NDQwVlNUZXVCejVuc1k0VkM4c2JxdlE1YmJmTHNQbzZnWFFTSm5VTHh3aXI2?=
 =?utf-8?B?NzhtMUdCMWdyb2tYR0p3SGp6TEpFVmsySjl2NldVR3JzZW9acm9IZU81TXVY?=
 =?utf-8?B?ZWlZOFFiMEZ6dmw0R04xanYxb0R6bnV1T1IrTG94TmtkTXFOTjFRbllNalFX?=
 =?utf-8?B?Q1FwWUtka2N5bHVreXI1OTE2ckZ1R0V3ZGRLRkt1eDU1eXFZcDhrZHMxeU8y?=
 =?utf-8?B?d1hLN1ROUWtPS1JvSkVxd1c3WTRKTUF5eXRhWUdoSzU4aGQxNHJoLzExcWpj?=
 =?utf-8?B?eUZVS05XVnhTYkI5M1lkWk9CelNpaU1jbG85ZzZYN1JMZnRQUGFQL3lTL1Ux?=
 =?utf-8?B?MjZXWlVTQ20rdUtRTVVJYkNBbU0zSGFJQmN5djVFbDRIaDZYakZ5NFpyTEtR?=
 =?utf-8?B?SHZkMzlmQnRZdmR3N2dCL3JoRjBHOVlrSnZwZmFsbmd4WTNaV0krV0tWN2NV?=
 =?utf-8?B?TlllY1cyZXFkSllmTW9NcnM2VGU4WE5Ya0tEMCtmbVJDS214eTZjOWtLYytX?=
 =?utf-8?B?N1BGQW8yVzYrWnFPSU54cGphejgzRjlNNDBZaHpEV2xJbmVMak1rbXNlTVRW?=
 =?utf-8?Q?nwol5uSpJ9Vzq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGF4d0RKSEhEcGJpU1k4WmVNVzB5d0l6b0p6dmlnOWduK3U0bEFHMHZhZWZo?=
 =?utf-8?B?bGhDNGluT2w5akRtRTF5NkpPMTdvcGlXYWpYOWg1VkRZUGZjdU1JZGtlSW42?=
 =?utf-8?B?ZWh2c0VGU08rV1gzYUd1VTdockdTSE9jTlcyMlU0enB3dG1PdnRaTlk5R2Jr?=
 =?utf-8?B?TlkyWDdYbTB4TjB1RHQwL3NIOTdQTlpQZ1paMk1ZM3E3dEs3VGJKc3VoN1Fy?=
 =?utf-8?B?SDRjMWc2S1VNRUxoSzBzSzBYTENWUEI5Mk4yak9QenRaZ1E3T21xeHdaa1J4?=
 =?utf-8?B?SVVIWWRWNFhtS2pnS1VieHpoRHdUKzZsUmlYQWdKTHFIOVBzWjVBMmc3cHhC?=
 =?utf-8?B?WHB4WEZMY1dFZS9GMUJNL3E4cnVZRFM3ZmJjQkVQWFpSK1pxcldlTE5YdVJi?=
 =?utf-8?B?bmF5ek5BQW5xLytqbVNmdE43ajEvUGdEWlpNbkpTMU5OWTFtR3d5STFsaWt2?=
 =?utf-8?B?WlNNZEdYZEROcE9HaEdGSnpkY3lDZG5MTFRlakFwbEFlcFVkVlErcGhnTGhu?=
 =?utf-8?B?cVZPSkR1NVVXSXZyQTdaZG95a3FCS1ZMVlVXbnVyeDNXSnA1MHpOZ0dNYTRQ?=
 =?utf-8?B?em8rRXZKM0Zvc3ZoMXJQdmV1ZHBEMXhmWmt6UmMvdENvSkZqYVVodGRYbnRJ?=
 =?utf-8?B?Vk5wUjVJTjgxZ3d4Yi85U0NoVnE0ZXJGYkY1aVZaYjJBaGIvVFArTFY1RExU?=
 =?utf-8?B?Y1Q1bjU1SVBQbmNJZFNqc2dxb2hNSkJUQytndmRBcEVpT3h0eWlWR2FVU3dq?=
 =?utf-8?B?Zk5oa0NJbXhxTmFST2N2T1JhNit3aTlQampBZS9MUk1FOFhjWXppUHlxSURN?=
 =?utf-8?B?Zm8wMWhBRldHUXVTcnBWTStmVEFrSmpUWlliRHpZa0RuMUJQWE1qZnZWTWdY?=
 =?utf-8?B?ZU5sTU1jajkyeitCeDgrR3NuNElaeDZ2VGxHcE5zNSsrUjM2aUh1NkE4eXFP?=
 =?utf-8?B?UmJhWjZCQm5oQ3owcDRmcTQ3VEtQV0dGbG9UcXpBaW5BV3hVL2NGR0VITFoy?=
 =?utf-8?B?VkdTOW1JRzQzbWhEMDNSb3ZCdHRKaUE5THRtTXlNTzlrL3J4eHNSSDM3cFk0?=
 =?utf-8?B?U0xLWm9NakVRTXo1d2pMd3pLTzlYZXhqcVhneGlWOTBYUmRPS0IyR1hISlFo?=
 =?utf-8?B?RXYydDF3MjlyNlF6TnA3aWs5dG5EKzVqTTRpTmpYZDRyL3kwYi9IZkdXVE9v?=
 =?utf-8?B?eWEvY2JhME04R0JsQzVrc2JlMDVKblB2aFZXaFdZN3BrTkZSb2Vvc0tXcUda?=
 =?utf-8?B?RjlKMlpFNWpxR2c1MGZsaWtzQ3BXcGd3Z1hDbHQrK1NiK3FwM3ZlbnhaTDRl?=
 =?utf-8?B?c3RhYmk3TWZ4NE1rUXVIQ25zekV1aXVnMFVZbFRES25ZWEJ2dk9UbWhHSHNk?=
 =?utf-8?B?cVRxcVNBTFhhK014SEgyZFZUelpRTUUxMHU0TkhRVmI3VEZUN3FwdFlsZFNm?=
 =?utf-8?B?S3lwNlRKM2pIQUpPbTRHQmNMak1jb21FLy9BcHZZVG0wTitMK21pUjlvQnQ3?=
 =?utf-8?B?Z3VVS3RCOXBoSlFhZktyTW9PQjExNFlGc2ltSzc3SjVZQXRJcmRaOHpHYlZN?=
 =?utf-8?B?UGZ0V3BhZDl1T1BFTXJJckdPTE5TUDN2TTRBZ1NOcUdabStGaDRIYUpORGoy?=
 =?utf-8?B?cDZ6N24zb1BlWkFSdC83bHpLdCtrVFhSdnJrbldXNVM5ekk1THNTRU5MTlZt?=
 =?utf-8?B?WEdJMEEvWHF3TVFjQVhTbHFlMmtJM2tzcFpDM3ZBK1l4KzVFNVRCMFZuWkhK?=
 =?utf-8?B?TUh1WHdaOTBIWDI0clhrZVBjNzVDWlZnbWNmQUdITFdKM1BLWEpreG9leTZW?=
 =?utf-8?B?ZTlnVmNiWlNjUUVQT0JFcDY0UVdNM1VZNldmY2NnTVBib21KNTRSVlB1OWtn?=
 =?utf-8?B?WU9BeVNJQ01hWlJqaEJqbzVQUnVJSll5Z1lxbUsvZWtxQlBSMllUZk9TeW5Z?=
 =?utf-8?B?SGgxMTFtbFhXcUs2T3VMb2hiRjNzOVFDRnYwZ0gvNkh6NXlrNVZzVFRETTdt?=
 =?utf-8?B?MmIxd21ISmJVTVFGSkxrYVY1WHpOR1FKNnJUZHFiL3pmbDJLNU1jbXFvTXdy?=
 =?utf-8?B?c1ZNOGRNbHVYd245YzV3VFI2ZGh3Nml5U2EvdDNLekZWYlNvQWFZOVpzSkow?=
 =?utf-8?B?NXhRSTIyaGp0Vml0WTRLYTlYVy9nWkdXdmFkb29rUjdrQXZjMVZFL2F1QzRx?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a6e7e3-b0db-497e-786c-08dd6246958a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:49:05.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUyiQpjZd7v5u8PP6sGs9aEA22pjZBxwIwp4IWg8NhCF2d3+JeTQ7u51ZbW+lCcpVyj8yaTNB6cK4X+fdUskeES298IXPsvxugIHngepIUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4869
X-OriginatorOrg: intel.com



On 3/13/2025 2:23 AM, Rui Salvaterra wrote:
> Hi, Tony,
> 
> On Wed, 12 Mar 2025 at 21:43, Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>>
>> Unfortunately, I'm unable check with the original author or those
>> involved at the time. From asking around it sounds like there may have
>> been some initial issues when implementing this; my theory is this was
>> off by default so that it would minimize the affects if additional
>> issues were discovered.
> 
> I thought about that possibility, but in the end it didn't seem
> logical to me. If the feature was WIP and/or broken in some way, why
> would the user be allowed to enable it via ethtool, ever since it was
> first implemented, in commit 8d7449630e3450bc0546dc0cb692fbb57d1852c0
> (almost four years ago)?

It would allow users to opt-in and use the feature; if an adverse 
problem was later found, it could be easily mitigated by not turning the 
feature on. If it were on by default, and a problem found, there would a 
larger impact. As you mentioned, since the feature has now been in 
existence for many years, it's probably safe to have on by default.

>> I see that you missed Intel Wired LAN (intel-wired-lan@lists.osuosl.org)
>> on the patch. Could you resend with the list included? Also, if you
>> could make it 'PATCH iwl-next' to target the Intel -next tree as that
>> seems the appropriate tree.
> 
> Oh. That list is marked as moderated, I (wrongly, for sure) assumed
> there would be restrictions when mailing to it. I'll resend correctly
> soon.

Thank you.

- Tony


