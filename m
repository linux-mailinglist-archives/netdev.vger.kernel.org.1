Return-Path: <netdev+bounces-74174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6886059D
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4621C24218
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 22:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E8413791F;
	Thu, 22 Feb 2024 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naoM6va7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636613792A
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640717; cv=fail; b=pZzNaS6C0GRwbRuDsC8HJWQPpuyLbtF5TQdORuaGjPKAlNt5MYfP+2LYStU3Kz+lT/Y4omO+1KKrOqoJqIAoAlgeKBRq5XF1X32rwefr7VWsU5pCdeurIbIn2EliVZ43x7uX+wzv9xdKEaD5YE4TNL/wUhXoaErooEstRiCG7D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640717; c=relaxed/simple;
	bh=TBpsI1CIZ9OYhk+19fyvvEHc3BMRyEygiOCWydmtwIo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1MJoYSeyy0ZunG3jAKlkj96uYD+5+mqbpTpliYfbE9pN0f/bFVhhXwfoAANh+65cvLbZoGMnt7GcX8uGstegbZ/uC666TLt1swg1oMo/2ZhfoqKn31Q+Eiodw5PHPIw86FhukvID/FMyWK3q/dfeErARYscmGMSgqTW3NKHvK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naoM6va7; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708640716; x=1740176716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TBpsI1CIZ9OYhk+19fyvvEHc3BMRyEygiOCWydmtwIo=;
  b=naoM6va7RRWKUBBAJmb9Zf6c2aLGQgYF341HgSr0BEB+KS4EPmYySxlr
   dfy89LDPC315DRae3LtJqBVxLHd3G2XpMq2JI+myBy8vtoMJtn9Mvh260
   nSlf0bbIOGZ5CYOo94RkLp9gFayWPUYDP85nnpsyzIFrzmUR4I0PQiGWf
   D8PtWM+bN04OKjXRMDvgJ51HZBlNeTlBkRFkKFyGllua597rL5bOrS7PE
   hz6MLMEkepcZet1utzDiHHwvUjMvFnZK34cDYD6tQQew3IVp6fIZQa+Ot
   lR38HA8RZ+f/nZTdcxxml6Sg6WZkUjn1e+N14LC/SwuNxqAZiW5rwp/Mk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="14040406"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="14040406"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 14:25:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="36451953"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 14:25:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 14:25:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 14:25:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 14:25:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6fL2z8GTewyJOktawReun71H+kR3srpsajVi2nrGqSzIuEHlbVLB3wBfzPhnkuU+5cKGA9gpQvvLmSttotaF/Xv6I5G64XW3UuWkKv1N3xoFF4DYZlJgjc0P2meyHvrdYTrtqR2h9+LmPeOXGd2KMRxI4Bw7+bV5EZCslloI4aFfAXQUedy3rbOUSX0dosEyz+ec2+QxuSYm3CwdXnDyJ5Da4pl8/jrps3rMudBA5yDUBG6I7oGq3G0vHYi1Wrp5CH/2Y1RRMLoxnfOhFnDqoAgQnSVoph6lW02InCfIoSL0tnT3M3+8fK4DumLAxyz8vPToSGAwh7xvhcVzlE6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNJlYs0BLvvINE40yX6v0xgfRvgpzXKdqjkTEGZv82Q=;
 b=JYujpUi+Q5H/b7oU9IIHcbNFJCQS69lMqoW4wzd5tZyIttyOc7v77KEAQHvw9+87qO7dQ0qEVyLp8goQVxslZorAWFEIQ1B3WF468xPD4AbOq0NuswkH17yGv58KYiPdocqCUy3gCYaltzYSEPHvv7qtIUHZvjJvmwI9/RAFqWJHeAfn9zaEEmLzjAdNOPnDRpjX82qQglhOtIkR1mu1r678WsD+5iO65yyTB8o0/KSiF545M51gKT8d2cL6ffP03wJZicoHcKdRUBzIdWBKalYmrF8OHXfJ26UrBl9Sn7h5HreVi8KnRcEdH2qrUr/iIG22+FyOEUk46F6oz1BOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by BL1PR11MB5464.namprd11.prod.outlook.com (2603:10b6:208:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Thu, 22 Feb
 2024 22:25:11 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7339.009; Thu, 22 Feb 2024
 22:25:11 +0000
Message-ID: <cd289ca9-0689-5cbc-a088-72f8efa8cb8e@intel.com>
Date: Thu, 22 Feb 2024 14:25:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-net v1] ice: fix NULL pointer access during resume
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Elliott, Rob"
	<elliott@hpe.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20240220231720.14836-1-jesse.brandeburg@intel.com>
 <481ea432-154a-b3c3-73ad-4a5ab6fe25ba@intel.com>
 <CO1PR11MB5089BAE82D6B60BACF3AF94FD6562@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CO1PR11MB5089BAE82D6B60BACF3AF94FD6562@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|BL1PR11MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: e08e9111-26a4-4568-41f4-08dc33f521f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwgxtW826kOOhCqN+zvyZ+6ExMFQv5HKsnG1Y0cYH2V0s658nOKNEVJ4sOpaJ9mI0sC/Iud6yDUGiwfY+bgGatyGgsx1r420YU1h690qwBYuSS2WqAHCGrjmLrZZJv8WHqfSIKi2oVUfDCshxtF3Npqawt7JTshcvv/FysvSxQ11S76shqJYyWTkAggYhG6QxAaDzw6FYAqzdse+GhAjYe7O7UqPFra4r/YtMCnHWM/3QhGEVTd6gQiS3CaqDK1rXB9XlcrcUHECbc+06YKXDfJ0FFs2IfNFa3gyYnxCOaI8wzxHcmYSw3epANnPrdehFx5O0Elsqqo0J212IDYQtjofQSLkweuQVTsVFaEovonGuKBmbna7ljRrgNWOB/2JGgnP+EQwjp+Ar788z3HEOboS3TdtToehflSjcLTLYYn+a+pDZeJhZHYlMS4vZxFXtTLS5QL3/QJWGeFQdZRwl1Iej3ZYB/pdvaxusnmi2bO9CSc2+7v4k5SimW2uJzq6bFRPPZ+Fq0dIIqC/UokTQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBEZXI4WGJwRTNodVNSSTg2elo1QXFGTXN6QlhYVXYyOEtDeTUyeTRIL3A4?=
 =?utf-8?B?akE3K2Z0RzFmMXgzbFR1NDlTbXMvc21aUGF3eFVpdVhZK05FVVVoWm96MXR2?=
 =?utf-8?B?aEZNNFdRVllMU1FTNE4xcHpHS2VvdlB0Nm9jWmpyM3R2enpGTGI2bkFWdEdK?=
 =?utf-8?B?Y0ZMdjY3R1pqQk1PV2NHWHE5QzZEZkJKQlEwWWtwczJwelh3THBOQUg3a0tC?=
 =?utf-8?B?QVpFMkJiWkFqamNubCtnZDU2eXJXNjdVVURGQnZwcVBFbllQR2lXbDBuOFN5?=
 =?utf-8?B?V2h1Ry9weUNtemEzcmtRdElZRklRQmQ4VUJtaU84Tk9TVUVXbGZKeDVwbUpZ?=
 =?utf-8?B?QktrQUpLK0ZtbDM2MU9PSkZwNkhtOEZCUjZYeUJva295T2czdndSckpPUm04?=
 =?utf-8?B?ZTJjMC9qWWtvRWdBSzRkOTcwWFM2REZHRUc3ZmlWVTNTelJtMHhkQk1vSDZ3?=
 =?utf-8?B?MTNPQzN5dnNlWG0xUmNydGUyM1FrK2ZIcDlHMGpPb0p6cEZZNFZkVXlZV2NG?=
 =?utf-8?B?ODQ3LzhmQUxFOS9rcWNmNFdaMHkvb3oyZ3dxTlZsVk1NSjJyM2l4KzZLOThX?=
 =?utf-8?B?aWhHSFpVTnJtNm9uSkRjQ3p5NjlQcWtzNWlBNG82d0tBNm5maDM3SkdzMWVa?=
 =?utf-8?B?Z1V5bFlNMWt5VE1FS3p4V3RHcVpZVi9WTVNka0RxdFZrRVdsWE9xamdiNFBu?=
 =?utf-8?B?NHRSMVVwZU1TeElYRTNPdk0xcnQ1Mm8weUk5TWdNNGRpeHV6Mmdja3pHeXdU?=
 =?utf-8?B?YTZqQlhxNnBiMmlSTW5pRy9jTy9aU0NkVTRWeVRoUmNtUXJpSlhGQlB5RC9x?=
 =?utf-8?B?bXlleVpscEE0Nm50Q0k4YzBRaWVYZ2Y0Z2ozODFwb2pwU2Rub1Uyam02UWVX?=
 =?utf-8?B?dFZjRWd3b0NQNnAwcWV4bEl0UlUxTUc4bFAvdVlXanBFcFZsRytTZDlCTCtM?=
 =?utf-8?B?Y2oyNTJ6d1NLSU92RU9KellLcE80cEpaYXR0TS83L0tUY3VDQ0IzL0lZcGtl?=
 =?utf-8?B?V1BMZGRIKzlMYThNazh6M3ZBWW9NSHV0d21yNEVBNFl1bjduUHBLdEJ4TDVY?=
 =?utf-8?B?RjJHb25KdXhrY0lRcEJDVHBmRWNqT3ZBOVFaaE5YUTBIdi9JNG55SEtrZXkz?=
 =?utf-8?B?RjBVZDlFV25HMlFaNHBXd05tcTBCMmJzS0g5a2pkT1dMaCtxQlZCNGlNTlda?=
 =?utf-8?B?bGhUTUVxd3dVbVhVNFZpOHJ6TW9Ybmt3OFMrNGs1bkdtMWp1L2xtSU8ydkxF?=
 =?utf-8?B?QU11Yi8yVG5DYUtzZGtydUxCVnFhMm90d200MFQrTkJQNDhWbGU3L2pMcitG?=
 =?utf-8?B?d2lUejF6anJqc1l3eFVkZXp6ZkI2UlVSRkllU09hQ0hQMEh4MWExVmovS1l6?=
 =?utf-8?B?aE5maUZTQWNSdWlRcndlb2tRRVczTVRXenVCdnFGSWVFaTZGanIzTDRITzI2?=
 =?utf-8?B?SGtoS2x5blBLS0xhU3N5RWVUZFhxN2NTWWFWalZmRTNqc1ZqaEpSbjAwbGF5?=
 =?utf-8?B?a3l4a3NaZWNBWVp1TXlFcmJ5SHNIMkNJNDh1VzRrTU55enBkeUxmRjZVVEcx?=
 =?utf-8?B?NHZYTlVJK3pYa3Brcjgrb2FSc0QyTmlCbm15bFV2S1N2RmovNXBidElPQkhL?=
 =?utf-8?B?Zk5uQmNtajAyVjd5OVNhT1Mvc1IrS2dSaUd3by82TEhLdldoaXhJSUZLV2F1?=
 =?utf-8?B?bTR6bkprbGl0N1ROMUxaR0RuLzltbExzazFuTFhncnNDZ3haMkM4WXlRTU1H?=
 =?utf-8?B?K3hLOHdQUEM2RHlSSDAxSVpoNG5SUnFlRXNINTgzcmtkeFpYemJmRTNTd0Qy?=
 =?utf-8?B?cC9WQ0lURlV3NHRGZG9sYWN2MlJOVkVlVjZMOFFmWk55R2Q0NFhYYTJCQmln?=
 =?utf-8?B?ay9OYkJMUlVkcmxSL1RHdWNJek5xdWZDL2dmZU56QU9KQWpzNDhnNW1rcW9Q?=
 =?utf-8?B?QlZvTDFPc2RadkdBS2s0NXUydTBLYWtZVkwrelUzeUVTR2dxUnBwNGp3Znpv?=
 =?utf-8?B?RHovVm43d0dCdjg1dytiMFFpM2k0WDk2RHBHbExFRlo1ZVJGQ3RmaUxkcVN4?=
 =?utf-8?B?dXc4NVFTQXN3empwYkdRUHBad2p6U3RxYVYzemZmSjh3c3FUNlF2T3Bzc0cx?=
 =?utf-8?B?NEl6R0VTenZMOEpaTjBNano2dkdNc2xlSGRHbmoxemlWd1o5Q2xjL2RQTVRM?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e9111-26a4-4568-41f4-08dc33f521f6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 22:25:11.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DroYgWCUitgtS7lSPXo3o/kzNqw69IZFa4XM2cbrEN90JYzEXzhNq+D8n5BHLXLp/z98UV08WOPh9LDfe76GgjuoZsRi335Rm/1yzKsPo1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5464
X-OriginatorOrg: intel.com



On 2/22/2024 2:19 PM, Keller, Jacob E wrote:

>> -----Original Message-----
>> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>

...

>>> NOTE:
>>> Requires Amritha's patch:
>>> https://patchwork.ozlabs.org/project/intel-wired-
>> lan/patch/170785373072.3325.9129916579186572531.stgit@anambiarhost.jf.
>> intel.com/
>>> to be applied before this will pass testing cleanly.
>>
>> I think this may be the other way around? It looks to be clean for
>> netdev (doesn't have Amritha's patch), but it's not applying to
>> net-queue (has Amritha's patch).
>>
>>   > base-commit: 23f9c2c066e7e5052406fb8f04a115d3d0260b22
>>
>> Base commit also seems to be a netdev commit.
>>
>> Since Amritha's patch is pending to netdev [1], I think we need a
>> version that will apply with Amritha's changes.
>>
>> Thanks,
>> Tony
>>
>>
>> [1]
>> https://lore.kernel.org/netdev/20240220214444.1039759-7-
>> anthony.l.nguyen@intel.com/
> 
> I think he means that the tests won't pass without Amritha's patch because we'll hit the ASSERT_RTNL in the suspend flow otherwise.

Got it. Anyways, this doesn't apply to net-queue, could we rebase or 
base it off of that tree?

Thanks,
Tony

> Thanks,
> Jake

