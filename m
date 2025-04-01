Return-Path: <netdev+bounces-178686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6104A783FE
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DB018844CC
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E066F2139C8;
	Tue,  1 Apr 2025 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOrKAjPA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11CA1C860D;
	Tue,  1 Apr 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542591; cv=fail; b=MVxe35VOqOUonjShmSQ0eKrxXUjL9s1vzJgKQ9LNU7BwTikLAi3Ag1PUvc2Gw+CLOg4VmvQWiz2lhUE6WGxfCQi8sPwa151HplgKVXKNLMMhdYWAjVKShDzNDxRdm8MPN6WWck5gy4kOjUbwu0YV/R0yyTI+QnHsVtDVKXvOALY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542591; c=relaxed/simple;
	bh=mdFSmMUTTIAAvbHkz8rzFgL8+s1nW6OBy728g7TqIlA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BbRpkNJgShsCOh//QPumO/w/y2Vr3ugFsqJmYYLqjXYO5jQzNv+eOXDdk+1CpxYGOUWLUUyrgx0EnD5dXVjW8VSxNzdorXxqoE/WidzmoS4UiNH6Wu1fONFfvQDRIMq0i3dvaOVi+Nxb+DJZ6k1/iAWVw0TJ0w3LeKRjQEGRTTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOrKAjPA; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743542590; x=1775078590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mdFSmMUTTIAAvbHkz8rzFgL8+s1nW6OBy728g7TqIlA=;
  b=jOrKAjPA5La4TJyvFJ13UjpNnQw3MulzeqYwWjCFiKP2CDzJsQ7Khf2Z
   o4mJCvkmHVqbhJJKjPhILayYrEELda4VwLPuX2V96mYeXy3vhrbjASgUe
   knEQ6td4MeALRDD5SBeQ8mEHlAIHcvtcHvsOniwL/JOch4DCuLe1OFe3n
   qXvCnTLotNbqn9ynFIBxbidmPAAnBFs/STI0egGZQrH6QLJ6HbUmtzzU9
   uInDFo1QS/YyzKMIfAPRYNga987ZDd9X9z9EZGVNNLqhDsdIkMnDdEMrI
   cy//If1nuYua+Pfal/17lnRS8lT9oDCmYxmVlru5HgsKUIFV6KR9Ie0/0
   Q==;
X-CSE-ConnectionGUID: fMAezJmoR2KcwEQmuk83jg==
X-CSE-MsgGUID: m4uTkKSQR+KHtdWcwNItfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55520721"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="55520721"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 14:23:09 -0700
X-CSE-ConnectionGUID: hZK6QeJYRWKQgChWpnThYw==
X-CSE-MsgGUID: Dw2HEjuhQ7y5zCECplx17g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="126751646"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2025 14:23:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 14:23:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 1 Apr 2025 14:23:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 14:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0Fxcb1OTPAy+ShbkvXwJvnoaTy8pB3PkLn3a1C7eXlO7oPhEdLGJ4me41annrGjJ4G9W1AfwlzJySq2eeFToEJI5bupTAZKiVExwmtxqbu4zIamqrF6Xn9x3X86f3HcpG7gYacbWTDXw06vsfzvX4AcYaLN3U9Jfq93Owis3iZkYz/R3B0Od7HawPDsbXDfC7b9enKlimLoLjlB4um1N5IoxkcsfTytfhT5IjI2jn2Hhl1KDhld8CljxA6knoLukfv6ZTFBLobKbJuoyTPSjitxEOHGlnAedq00bvMybyaOGYprimLtAZXAoiSk3SrgiB9cwnfEA8K1ubSUEvEH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9ijxP675j2eSCEunXq3u5WREtiGJcFm8CrCtDuX23s=;
 b=itAbGLbvuq4ultfsdDM5B0BJLIH4AmVlTNRSSfbCtszETfFcbt1dQfe1Sl9mun+GCtOT2r9uu/X2YQ0hmPqs7SWEl6mRCf0fvpPYdDsf6BczjFb6jeZBijqHFRnNNZfyRWSfapvOkg/aSdIWFJE+JfExdF7SEAQ5w2FJDYvUSpSMI7XZTMcqjxa5LRimLxirU48c2/0TFM/pFMEz+7PkeSHzKCyZP5GXelWT4ciXGasadg9h7V3TDlcmRS7FRd6BMRHjIDsWLqE96sitAhVYVn4847E0TPQnIHSQ/K8tzQb7gBBhLPwtYROwKKf7gr+cbzZRUgoOKwqarV1xcc/C+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB5950.namprd11.prod.outlook.com (2603:10b6:510:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.53; Tue, 1 Apr
 2025 21:22:33 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 21:22:32 +0000
Message-ID: <c843f075-3738-4a9d-a6d9-b817f650e26c@intel.com>
Date: Tue, 1 Apr 2025 14:22:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: enable HW vlan tag
 insertion/stripping by default
To: Rui Salvaterra <rsalvaterra@gmail.com>
CC: Mor Bar-Gabay <morx.bar.gabay@intel.com>, <przemyslaw.kitszel@intel.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250313093615.8037-1-rsalvaterra@gmail.com>
 <2710245b-5c2d-4c1f-93ef-937788c3c21b@intel.com>
 <CALjTZvZYFEqSGZvSfthsTC5sOkVixAFyPg0Jj7eXZ0tac4QS8w@mail.gmail.com>
 <024fb8ce-adb1-42f8-91f9-ef08868fee01@intel.com>
 <CALjTZvbChDaMACCdmubV9hVXWnih2Rx0NRkcj3K_NbW+O-qrbA@mail.gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CALjTZvbChDaMACCdmubV9hVXWnih2Rx0NRkcj3K_NbW+O-qrbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ba82b5-6cdd-4456-bfab-08dd7163503c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aENLczY5bGV2elZ0akZLK1pFekRhbDJxUWVjT04xTzh6Vmtnbk5haThXQS9D?=
 =?utf-8?B?b3NIM01Dd0xMT3A1RUJZYnFOSDNqZmlXbjZCZnh5azVzMitIWkJtcWxrRjBn?=
 =?utf-8?B?MWladXRhZDF4azVHRnhTZGtiRHpUS0NGZzRQMitMVksyWnFCUHFEZHhVclhS?=
 =?utf-8?B?dDVrdW1vakprKytOaXkwQ0VpQWFjbGh0MkQxREg4c3gyVWI2SG43cWRBUFlF?=
 =?utf-8?B?azg1b05wa3JhY1RJWHgxUzRKajBmSWxqT3c3cm50VnNWOVZWcnRIa3dIS2li?=
 =?utf-8?B?UzRSck5KeWZpK3I4SjhOTS9tcUJMcUE3TWRwbWY5VkROYXQra29ZY2xLZS9K?=
 =?utf-8?B?ZEhBRDZHRFJINWcxSzVMKzlqditmRUtFZXpBaGVqdktoY1lNTUtqTHNEZDNt?=
 =?utf-8?B?ZFc0M2Y1UzBpbHdUcFNVS0xySlFZKzFySXdOcUJmVExKMUQ4SVdIWUpkbFpi?=
 =?utf-8?B?cXJCWjBDUGtOM3VJRktJM1J0WHd5dXRqUk50Vi9JSnI5RzMyZlBYcGZnd2hO?=
 =?utf-8?B?K1JSbTI2Yk91bEIzdnZ1RG56WjNvaXBIa1FjakU4YVJUNkVIYXMyRDF5dVF1?=
 =?utf-8?B?NGtoQ2ZDeldqMWg0UjRoNnFkLzNzV1czWHR4QWJaSGZ1NWU4Sy9qck9ieEpi?=
 =?utf-8?B?eU95WHh2WVUyMUxmR1NwbGRieVpFZFlEMWFLREl3MnJSZWcyLzNSUmRDVHRx?=
 =?utf-8?B?aXZ1TmFuQXhPemo0SU92RVhzVnNnNTYwdDBtd3NEODNMMGZLUnVGakZnQTJM?=
 =?utf-8?B?UlorLzJVUkRoMWQxM21welRWay9vTHliOERRMXVqSncxbHREVWdqVThPaXVh?=
 =?utf-8?B?V0pGUFlGcEdqaE8wMVNvbEQ4c3ZSWVJ5ZEJUY283ZXl6UjJaRmI0UE91Wjlq?=
 =?utf-8?B?N25rUGtRdEpnanphTERXcnBCcTB2SlVuU2cvZDJhaTY3SlJUakRxWWlBN3FJ?=
 =?utf-8?B?UWVIV1hDMHRsN25vTTNUYTlWSE5QY21kS01kenNlZzRDQkFqcjg3MEdRbXBv?=
 =?utf-8?B?MlhCaGtwNzdLU1V1OE1NbURJajVrcHFKZXpic0FMQWdEREFyQXVPdURsWVhk?=
 =?utf-8?B?cFdpQitLWFZFTVMwR2FCVG8zb1NHN3ZVVEZTMmpUNDJraFBzS05MMFNFaSta?=
 =?utf-8?B?bnJpRnJwSWJhQk1XT1U1SzBQcFI4a2dxay9VVkVVaVMxbG83WDhuVEFCeWlu?=
 =?utf-8?B?UzJpT0VCSTBIa2FTTDAreGxGVzl5UXRINm56bjd3T3FnWVhVU1dhU1dGTC9H?=
 =?utf-8?B?MTkxUVVnRkxxUVA1V2ZuUC9DeEl2MDdhdXhyUlcydU1FUENMYXBNS2l0RCtV?=
 =?utf-8?B?SFRIWU5kZEFWWXl4cG5iQUJKeDZLdXArbEVwSzlyV21mU1h5cDdFSWt5U3hi?=
 =?utf-8?B?b3JGWkNRRHJnaUtSNW1iL1NLOUJ4THlENkNWZHp3YVJreXB5MnAra1VDanRy?=
 =?utf-8?B?OGE0SGVaTGhkS0t3OFpydzcvdGN4TXdEZXdHb1llN0lpM1NNWDVuY2d6M1Ir?=
 =?utf-8?B?MkYrZ2ZpelZjVm1Eb3dwN0hHRW9UNVZIellIQWx6NWFWbHpSVU5BbmUzb3Uz?=
 =?utf-8?B?Y2RFMExrTElnYWZ0ai9JbnJ0OFlTVUxhUW9KMEpQcjIvOGUyZ2kyTzlJY01l?=
 =?utf-8?B?cmVWTnJnZlR3RUFnTTJQMDB1YUdGMWVNWm9ZdXlnZE9pMmZjdFFzbGVnbm5O?=
 =?utf-8?B?WWE4RXdlN2NIcGVqYlhkSkliKzZDRlM5Uy9VU0JwTmVxWWxnb2JXcndid3F4?=
 =?utf-8?B?cnBiTDdmZllpaVFVc0VicVd2WUoyc3JJUkpwTjVUSFNNYVJBelVHd2YwSU0v?=
 =?utf-8?B?aXRHRE5heTk4RzdkTS9ucVg4ZDk4WGdMbERaSUVzWU9aWFVxZk1RWTNPTy9z?=
 =?utf-8?Q?Zwd0o7eDmxbOj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWMvS2dsQkRiNGVncWpNdlE3b3JCKzRBbDJ3ZEk5S0hYejd0ejlUWGFDNlVV?=
 =?utf-8?B?UkFEVUJ6eXdkZ00rRDdDdVptUEU0R3E4aVovN1dSNjczKzFZUituek8vTDNS?=
 =?utf-8?B?TGVQbFBiUGtrTkl4VGpEd1VnUFhGMTd4bmc5MFkxUnVhQ1V2QmYrSXVNV29G?=
 =?utf-8?B?cXZsTUZtVXhvbTNDTnZ0dHlPaFRLVXhRVFBHZlZyZ2t5QVBrcDhXQTJzM1lr?=
 =?utf-8?B?U1AyTWZKNVI2ZGY5bFJUZDRYZHdSNG03SEQ4NHlBS09ITWZuM05HajVYN0I4?=
 =?utf-8?B?UzY0VTRaWUVZOXRMYnZBU1VqQ1JCQmRmMWdLTEtiVG54SjgweUplYzBMcmlO?=
 =?utf-8?B?cjdKVkFINVNjSG50cXBuS0pjZEoyTzZ4MUlib1JxVEh2dk9kVzFYZktoRnpw?=
 =?utf-8?B?YkFOajFxZHAxQm1zak1EM21PZ2k0cDZKSjNvM08wbTBSS1BVdlEzUXQwNWJE?=
 =?utf-8?B?MVU5OVJONURrWG1NZTdLZ0ZwaHZWNjdUL2FuMlNuQ3Q4NGk4bWFKbDZ0QXVw?=
 =?utf-8?B?WEZOQ0hmUzlUajlONkpRVFVYRGdaWEIvRi95TUlyVm5CcndZelFyRS8yT1Nw?=
 =?utf-8?B?bzhpc1diRTU5eEZvUmY2WWc3bnk2Q0FZR1MzRldnNDhLMmxVVnZMdGxxc3kx?=
 =?utf-8?B?YnFBalBYcjdGMk92SWFaV2NOc0hUQjFpMzVqMTFiN1JYbWFoc2dWblV5eWVm?=
 =?utf-8?B?b3pSeGJrWXNsMzNaTVdCU0tKYkhDekpReTBDYmd2R2dmc3dTMjMvWW1uQUFW?=
 =?utf-8?B?WGQ5TEdCdWErNjg3MXF4VDFOQktUMTFTUXFhMDBxekVhOWVHQ1BiVGx2VndT?=
 =?utf-8?B?VGJLTVVjNHhNT3R2RC95dE1ZQUNGQjBVdEZPbFFzTUdYOWt3REQyOTdOY2Fo?=
 =?utf-8?B?Q1RCUGMyblViNlR0QWN0eUdtNDdCRCsrU0FHY08wUlRsLzJrYUVTTHYyVDlN?=
 =?utf-8?B?dW03a1V0SGY3RnhsMWdQM2xPRnhDODM0STlMMFBFLzFlUkVUTDFaSmIyWkFB?=
 =?utf-8?B?dVA1RFcwdlBVUWJSWkluVitBTHRBQTk2US9JODZ2bVgwTmlqWHZic3VIT080?=
 =?utf-8?B?dE13WmlISXJRbEd0VEMzZlhFTnNqb253b2dEaFhqUlFZVnFIUVpxNENuUjFC?=
 =?utf-8?B?bk5pa0FFbThpZVZZK3JONEtBSUlaT3Fkc3RHNkZzQTJuVXdzYnMvL3QyS0xU?=
 =?utf-8?B?STNuTjNkVUdONnNydjdQMFpieG8wc2VUaS9ueURXd3VRWEw4VlVLdklGU1dJ?=
 =?utf-8?B?aEc2V3lYbGoxRXBnTVBvb0lPZUtJKytKWTMyRG9meVVqRzlJblRyNXZiQVVt?=
 =?utf-8?B?ZXZlRnowTnJyYklIWE42eUFmY3QvOVd1YXhVUktFenE1TEdNdGYybDdRai9l?=
 =?utf-8?B?K0tQcnpHZGpTNk0vcWJqZHJlMU00SkJYaVJ2azFJamdyb1RxNTJFdnM3SlNo?=
 =?utf-8?B?T2MzRWVwQmxQeEFoMWFQMmxVVjR3ZzNMM3JidGp4bXpSNmlrTTRDQlBvRjlF?=
 =?utf-8?B?WGNwdFZPVTVpSUQ2aUE0L3UwdnRQWjRqa0JvV1hwUU42ZUd6MUpCU3Z4anU4?=
 =?utf-8?B?Qlc5NHBTYUx1aXh0dHd1Nkd3Y2NzamFucytNczhQUUFhcy9WdkZKd1pDRCtr?=
 =?utf-8?B?Z0ZaRGpEenVjb0lDNWhRbzNHVjF1dzFwQjRtWTF4NGlMR2JablI4L3lLazMv?=
 =?utf-8?B?aGN0SE1qVTBzZXhONHd2ODU2WmcwTEtROXQrbmZhcmYwelBZNmVJTVhHanJ5?=
 =?utf-8?B?ZFlOVjFSV0pKT3haMUNBZUpCWTFLTEhDQXB3T251bGlyUzlxeHhGNjNFWkxs?=
 =?utf-8?B?Mk1PVzBKU2VuQlIwTXd1blphbHhWMHd5SmZ3MFJ1Y3BkR1JReEs1VUNtY2Na?=
 =?utf-8?B?M0Fzd3NvZnV1a0I5TUo3UkpmcWpsL2R0QXVoTUNoUHhpU3ZmZStZNXU4dlow?=
 =?utf-8?B?aDN6R3daRnY0R1hmZExId2hSeEZDYU9UQTVsS0VKY0YvdCszZm9lY2tpYVhR?=
 =?utf-8?B?Z0VmMEpzcE5OTnJGY252bkprTW9QajlWb3ltb2VuUW1QNWtCT0dwNFptb211?=
 =?utf-8?B?WDVXWkJlaTNqT1c3ZEMrLzEwbVVBbXR5OGY0R1k0S1dUdFgxSjUzcXpSVk1J?=
 =?utf-8?B?N3F1eFVSYkVaMEdIUExnQW56REU5Y2RKcDc2WnorekhjWS9HcXFHWDJGamxt?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ba82b5-6cdd-4456-bfab-08dd7163503c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 21:22:32.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xama3vV5AGZ6IwmIwqrJzjn2UO7JAo1dM3oP9IkRr+U9e3LE32dMjKySxAWEY5joXCWbu1ruqAEKbz1d6Fth0zk4hsdGLQzLKjI23wP8Plg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5950
X-OriginatorOrg: intel.com



On 3/28/2025 9:17 AM, Rui Salvaterra wrote:
> Would it be too much to ask for this to be backported to stable,
> though? I've tested it on the 6.6 and 6.12 series just fine.

It doesn't seem like a strict bug fix, so I don't think it should go to 
net, but we should be able to request backport to stable afterwards.

Thanks,
Tony

