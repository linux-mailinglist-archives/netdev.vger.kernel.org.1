Return-Path: <netdev+bounces-131384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E9E98E5D9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35111F23B2B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 22:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DBD198858;
	Wed,  2 Oct 2024 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKaeqDe4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB302F22
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907146; cv=fail; b=OoYu7ZfSiaOW13xGMj+7q+/JFWUYOrFFwFuo57kW3oAJ8A85FjpiU6QJot3cyGDe/AimGsJE1BvM0cqK8y/lbkdmsl2FaIxJc2t2GDkLtCU9vUdbcJemsH5gMJplU99D6dFeAElM0M8PygBijsmQy8cXTniEx/nkad29efCS1/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907146; c=relaxed/simple;
	bh=mWUHkK1sWsznaog8cHS7vxJ8rIhONX+sFRaJInRysHI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JL3RQi3i3YVOeEJ1VWdP2IEcy2S3s4d5fsRPLDIUU4KMyfnYM+0dgmGAAs9coAEaDRf4k0TnNGfrg0V0+uFZlKp5EBTYdEFSz9RxVwut+bWUtCCqtHyuz1eY6V8RWD/lA6CQqD/zB6NnDTlzByHkRRdj8IaqFH9kihBAgEzoy3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKaeqDe4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727907144; x=1759443144;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mWUHkK1sWsznaog8cHS7vxJ8rIhONX+sFRaJInRysHI=;
  b=KKaeqDe4uLxcmcLSx+xbJmXriShSLVcNBGIMLNl1L+n+O/RKeB8dWOpi
   l7v9R/nXgyql2OHqlrvj1jE1kAiKGBzx7CRoMHrheKiFBEdhfwA9kwBzp
   NZRCAuy6czPgscZUCWx2T14XgxVHnJbF2lAQ6uecPDaONSdFlNDL3/17M
   MxyR/Mu+raUCUOzO+Igw97givz1x0oDpkb/jy6t1+z6I7JGmLWnDIs4R0
   V3hy0IZodCcJjg68ejBO6bEn+AWTVMrhrKevx5EYm1zi3pO3osgIsEhJK
   tJnCo9Ab6HnhSufTxWm8/ZOxGnWiNZSE2Rer0bI+or4TOjobJHn3uJcLj
   A==;
X-CSE-ConnectionGUID: ND6WJxNQRgCwOpuujF7dWw==
X-CSE-MsgGUID: ChzffK74QUeKceyPrc8fyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27265422"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27265422"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:12:19 -0700
X-CSE-ConnectionGUID: RYf4ertRQ9aP9OUXjYv7sw==
X-CSE-MsgGUID: 7DVMKfeqSyqLDM57gjUamQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="79119089"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 15:12:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 15:12:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 15:12:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 15:12:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 15:12:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 15:12:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRAOOfZjBwlhbA4FPwKQbpoaxRw20rH2I5ehrhjX06hKjRGGQpSlqx85rXIXe/mO69GFnyAAVLqAORoyoLKe6UtUVubhjtl3i5gIB6cJ+Q5C5ZwHQ2DB149TyPFFxb0PJQWsJkW2fvCGQKYUF/vMJsREE26wkdFt3qZiV+k1jkuf7bkwmGCgeqgTUWFTYG94gAr30FNEsPxWCu3rvKEJxMYBl0b8BLHtdznbMu43YZ4VnTFnck0tKinwI3sq8SV8YiipJ9y30fN5uJidht0UKRKAKvoCPzjiK9oA3/XHuhOM1YO+kfwY45d48oWPnwxR1u2CuktCw99ayvALwM/c/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBcpbE/Ku00JBS5L2ucaxaIlWxADGJsQR2Dxs1eAev0=;
 b=NR0UerhMgBAV6ZOQ83FJuEEHSxTK6Khln3G2gMi7KGiNb/ZEstNlVOxsFB3hW6+EfWqk75RPJJ4NEZQkVXHh75kAM0KQZarD829+MdryNednkrqVnBOC/tKcfXCNyyvMgFdDtSSKoARbi9mh+xJOd6pNFLLnEKkco2pV7f3lKt0EFqhcX+Opvd1P8fK2rg5xRWcVMy/qLy6cjsfkDSvu/MfydxLrAJnRW0GO951A/6IVTvghFt7ZwBJyHyZ4Y4Nlh6VBXbioscrGwt/Hh9cUqkyWzEFLsGtBFtz1aBMuyhGcJegbC62dknm/ThIwIUgWnTNdUUJ56RpOGIdOHCy+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 22:12:09 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%7]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 22:12:09 +0000
Message-ID: <31ea8ffb-ee35-8595-e66d-ea56001cdd43@intel.com>
Date: Wed, 2 Oct 2024 15:12:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-net 4/5] ice: Remove unnecessary offset calculation
 for PF scoped registers
Content-Language: en-US
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>
References: <20240930121022.671217-1-karol.kolacinski@intel.com>
 <20240930121022.671217-5-karol.kolacinski@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240930121022.671217-5-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 7809908b-2cce-4caf-457b-08dce32f4245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2pKVDVPaEIvU25MbGptckk4Y0I2QmdKVnNkL1BjOGRONGZBZ3hPbW9ZNUVK?=
 =?utf-8?B?M3BHWnRQbHJXZlNUTHdLS1o0VFdGU3o2RDZVb3JxdWh3ZDdzakx6WXZDUkZL?=
 =?utf-8?B?WlZXM3ptWkxxK242UXJuTzVIWGE2MHA0MHQxSjE3ZlByUVNuWjZaRnJLazFa?=
 =?utf-8?B?QnhWdHM3TVNtenlxb1U0TzFxYklMTm12TThQWGhyNTFpb0Q3TCsvQlY1UmhT?=
 =?utf-8?B?RVJsV3dtSTJ2T1dxV1NXVlN1ZklLeEE1MkdxSTQyMDIzQTFEWGtNajQ3N1Bv?=
 =?utf-8?B?VUZCRm1rOXpYcVQxYldlcC83RDBoWnh3b2NYRUduSXlRY0lqbTNEb3U2RWRl?=
 =?utf-8?B?ZndGVEgwMndWaDBFWW5BWXJmTTcwaGlTVVVrRURscm1pSmdmbzB0Q0VzR2Ru?=
 =?utf-8?B?ZWRENkxnVWFNQUhVK1phdUFueXFuajgvSzRZUUtEZ1hFbXZWR01UdGJjY3h5?=
 =?utf-8?B?V2NTOWpYRDRoUDJNVUQwUWx2SzhuZ0V0aHB6WGZjVnBqVHNKMFBsejIrNFBw?=
 =?utf-8?B?bFQvdGQvdUNBMFU4Q1p4OExsK3hjMjlVV2tkeXIvU09ETTQwTnpUQmtaMDUw?=
 =?utf-8?B?V2hrQnhGbThMZ2xjcFhxU3ZyWHdvdmp4UFQxbTd5U0szeXhsWFQrNmFLNVNp?=
 =?utf-8?B?c0traGpGSnpzVDVjbHA1V3V4RGx0Ym9BcXk1czZCcDV1NmhJNk93aDNSTEF6?=
 =?utf-8?B?dU5JUVhyV09qMmtYOEZhUUljdlJjVmxzMVNuTzJmQ1czbUxUS25tWC9SMlRl?=
 =?utf-8?B?THZPc2toQ3o2eG5CcUhBYVhLZWRRVEkvbXZLdUtmRzVYbnR4UXp0cjZPL0h3?=
 =?utf-8?B?Zkxocno2bVkzZlFMUHhRRi9BN3g1L0pXYWd5NHZoL3FQbjV2Y2hnaFJsakc5?=
 =?utf-8?B?RTl6TG52QlJwdEJLMllZbjdrRWp0cEZTYXhBWWZEb3NRKzQzcStpVWxteVVB?=
 =?utf-8?B?aXgrTXhNeWlEYU1TRnk0b1MrM3hadTBZL0Mzek5uR2t1dVFwd1ppY3VSKzVs?=
 =?utf-8?B?eXJGQTJVd1crazNEMFhtNkVyaTRmSmpVaUQyeTRwRURQUk1QaHNaMTI3K3Rq?=
 =?utf-8?B?UU5ETTIxbWxndllaYVMzbkY4b2gvN2QzUUZ1dDdiakJwclMzYnZpWmVVSjJP?=
 =?utf-8?B?TmFXZ01vNUFoSmtxRWRsQVgrdlRkOFA5eWpOZmVVNDNhWktJOE0zY1dXVDNV?=
 =?utf-8?B?c3FXVm9MazZvUjI4a3RSWldsaWxDOHVka0hTYTF0N3ExTXloTWppaG5SbTJO?=
 =?utf-8?B?Q2ZrRXN4T0E1ZVYzRFVseXFnckZBdUl2NEhNTkZSZTRENmUrVU9UL2dDL0dP?=
 =?utf-8?B?TWFXMTlLQTc3VDhhaTBCdmJScDgweXRpSjJEdzZHL2l4SmNGcTFyVkQ5cm1n?=
 =?utf-8?B?aklyc2ljb3JIQU8yYUZhcXZLWHJRWWRwd0lIdDcydDdVeDUzRSt4d3lpSzFW?=
 =?utf-8?B?eTZmM21DRG0zZVJOd0haaEp0dG9WWjlhSFphY2RsZzVZVStHM1VESXRLMmI4?=
 =?utf-8?B?eVpkTVZhcXdLMm5sTWxCS0p3aHVFVkZhOVFFWTdvWW9kMDhseUppL0N6T2xK?=
 =?utf-8?B?M04zS2Z4eEhoRjFhMENRdXEwcUdrc2xXb0Z2V0tMWmY3bGZXRkR4M0dGTkFV?=
 =?utf-8?B?WUJKSnR5dGpkaTBPZlkrRVNOZlBINzhFOE9HczNXdUhRN1h0djVWWFhXMW9L?=
 =?utf-8?B?blJwdEtEdTMrVTJ2MXZWSlVUblo3Y2l3MnV1MnRFajZWM1BueURzM01RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azU0TTFtVzJFMHBVZW9OUHBSL2psYXU0cWZYR1laR1lUNDU5elJCY1hoYllz?=
 =?utf-8?B?UkNIbzQ2NGVad2xtb1p5TU1ORnZSaExBZXVLY0lhV1E5N0RIZ0xkcVVJdzNj?=
 =?utf-8?B?dFkzMzRiRktaSDNzejlkaVc3WmoyYkN5OVcvdThseERCMlhueVhTRHlDaGdR?=
 =?utf-8?B?M0xVdzM0SXp4cldjSGNkN2gxSXdvWGl0YjZRWXBRZVRiTVBHUExMRWhhdTNz?=
 =?utf-8?B?eS9JMnk1cmMyU09SeDk0TEVsWmx6QlJwbW5IeTVWM0QrMWkySkFiY0x0Ung0?=
 =?utf-8?B?SVptTkMzM0FjcVF5VENEK3drMjh2NmQrUUZjSWpzamRJRjVGY2xzZGtad1lF?=
 =?utf-8?B?TjJlTkZyV244VGZudjBPaXZCa1lIVVpzQUNNVmZNTjNxUzZUbzF1VnZuV3N4?=
 =?utf-8?B?dHk2dG16Z09PVHBKa0N5K25mL3pFWmVzQUppVnA4MDZuVmNKUnBhYmZLYnF2?=
 =?utf-8?B?NEVROE4yYThaVytKL0VEOUtYNXdtRUVOaERJVHVuWTdZbGY3YlJic2NqYWVO?=
 =?utf-8?B?bGJqWnR1VU9QT0xiejlzU0k3R0NYblRGVmZwVzRqdUh0VVpXZXJLY1BXRGJq?=
 =?utf-8?B?SlNTOEFmbEIvWlQyb3NZLzNaSkU5TVdEa1JwVUFHK1dZYjI1RXU4bERjd3Br?=
 =?utf-8?B?N3lvQjdYdXlwSFA5MExScCs4Mm5GS0xjMkhZNEFUaDAwektqY0tNbkd0eGlM?=
 =?utf-8?B?YjIyKy9iUjN6ODVmZW9jc2JUVitVbjN3ampBaWJFdnlWdlBXWTJ6aVcyNFc4?=
 =?utf-8?B?WnhTVWxrc3hOMk5JYklFL3hmemU2ZGswd2R3bHZxOWxRWUlSUnU0alhLSlpr?=
 =?utf-8?B?OWZ5L3hsVHd3SjZLZGNKV2pmWW1mSHNOZmpmR0R6UzZLbXZ3MWE4UUJzc3hL?=
 =?utf-8?B?RGovVVFINjNCUnV2VWg0a1dHY3NsQUYrWEtKOUZrZTQwZUhuTGZwY2NTTHho?=
 =?utf-8?B?RnV1eUp4aVFRV29QcEZlTUlaeWlXWXJQb1NrelQ4MEJkNjB6ZXpiVmRwYTZT?=
 =?utf-8?B?cmFMR0wweEpSZDVDWkNkVmpRVG5Mb05wZTA5Qk9VdVJXd2theVlBV0FSZkov?=
 =?utf-8?B?cG5IOERKc2FyUEtWZHVBQmp0RVlnVGRjdVk4N1EwRXdVOXpaSDJDNndidzVR?=
 =?utf-8?B?UW02OUhIL0REcWYxVnJkNnJEVzZMVlRhdHd6TU4wS0UwUEY4dW9RVzZSSUdO?=
 =?utf-8?B?K3A5ZGtTeWpnbEplcUo3UGswSS9RT0wreFZ2V0pJVGlrOWtIWXduMVhUTkhu?=
 =?utf-8?B?SC9PVWIxM0VTeTFVYk8yZGF6elNOZDFZUngrWVFLTE5ZZUQyZ1F1bm5pUitG?=
 =?utf-8?B?dzQwYVRibXdUZjNzNGdQTFJmdk1zSTlrUFBxWkxwamxtbXFIUmloRlpvcFEw?=
 =?utf-8?B?NzFrdXZKWVNSa3lZWVh5aUVlaG1INDIya1h6andNRHRienlZY0xJTHl1Um1S?=
 =?utf-8?B?SXhUazNmL2dTbGU5YVZqOW9jZVN1Q1lLVlVyekF1YzRXcUlaSndpRHRYb0E1?=
 =?utf-8?B?M1IzbkZwZ0RWOXJRQzlyUmpGRTJJZ0VpL2hLblB5SVd0RkJUS3B6S0tQa2xp?=
 =?utf-8?B?bzBrRkpIWGFwLzZRUkkwSUMxak5PQzBmUTU0M1YxNHJMdXgwNFlkY1FRNVBK?=
 =?utf-8?B?dEw2MmkzdWgrYVB3eEhaUi95ZFY2dURUSFFCWW1mZFFjMzNSODFKOUhwV2l3?=
 =?utf-8?B?VjhMcVRaRUxhK0kwMW9laGtmWmEvd1czZHZaRkZBSGxtbzFPTW9RczdsNHYy?=
 =?utf-8?B?ZE9wN29sZVZjWEJJbjM4RnJXdVFPd2E5dVRNR0hvdzkvdUdVOUM0cFBhNlVE?=
 =?utf-8?B?d3B2aW9lcncydklvZFlFdzJOdytXVk16TndyaE5Ub3VXdXA5UXBaSjIwWVN0?=
 =?utf-8?B?aUZUSXFXdTFtT1lXTTk3ZHNWMHgyTVYzSlhweGV1RW1JMGtjcys2YWJwSmhH?=
 =?utf-8?B?MDBmMXdWL0RZdlpRa05NdURtcW1hRHFIU0pmNlpJNFh6cEJCZFVpY3oyem0w?=
 =?utf-8?B?dkxVdUlBNnVvOGdTN3pYUHh0ZitFOHMrcEFweXNzc2szbmMzeVJxUENrN2I5?=
 =?utf-8?B?cDViTXo0bzFmUUxEWTAweitWVExGbDI5dGFFZXdvdmcxd2FHbzM4c3F2K09W?=
 =?utf-8?B?WlJPMnNNMWdwWnZVczVJZ0JSRStvT1FmU3NYMGNLeHdXMHlTN0UvNUNRYklS?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7809908b-2cce-4caf-457b-08dce32f4245
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 22:12:09.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFrEhdc6SeTVqdsyIoW1XKtCSeIINh48HH5S8TC+FU2EDBxwBx/SPFr/fkSIFxKXYvrDa9aRPgR+1JLpFnU3ozkn6E2pmra1RhCSfX/ZbfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com



On 9/30/2024 5:08 AM, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The PFTSYN_SEM, PFINT_TSYN_MSK and PFHH_SEM registers are defined in the
> datasheet as "PF scoped". PF scoped registers appear in the datasheet to
> have a different offset per PF. This is misleading. Each PF has its own
> scope of the register, and accessing any of the offsets on a given PF
> will read the PF-appropriate register. There is no reason to calculate
> different offsets when reading and writing to these registers.
> 
> The original code implementing access to the semaphore registers failed
> to understand this nature of PF-scoped registers and included additional
> offset calculations. Remove these.
> 
> This can be tested with direct access to the registers to show that each
> PF sees its own scoped register:
> 
>    user@system:~ice$ for i in {0..7}; do sudo readpci -q -s 17:00.0 \
>                      -a $((0x88880 + 4*i)); done
>    0x88880 == 0x00000001
>    0x88884 == 0x00000001
>    0x88888 == 0x00000001
>    0x8888c == 0x00000001
>    0x88890 == 0x00000001
>    0x88894 == 0x00000001
>    0x88898 == 0x00000001
>    0x8889c == 0x00000001
>    user@system:~ice$ for i in {0..7}; do sudo readpci -q -s 17:00.0 \
>                      -a $((0x88880 + 4*i)) -w 0 ; done
>    0x88880 == 0x00000000
>    0x88884 == 0x00000000
>    0x88888 == 0x00000000
>    0x8888c == 0x00000000
>    0x88890 == 0x00000000
>    0x88894 == 0x00000000
>    0x88898 == 0x00000000
>    0x8889c == 0x00000000
>    user@system:~ice$ for i in {0..7}; do sudo readpci -q -s 17:00.0 \
>                      -a $((0x88880 + 4*i)); done
>    0x88880 == 0x00000001
>    0x88884 == 0x00000001
>    0x88888 == 0x00000001
>    0x8888c == 0x00000001
>    0x88890 == 0x00000001
>    0x88894 == 0x00000001
>    0x88898 == 0x00000001
>    0x8889c == 0x00000001
> 
> Additionally, you can quickly tell that the PF-offset doesn't matter
> because its not an included parameter of the auto-generated register
> header file. Other parameters which do matter get generated as part of
> the offset macros.
> 
> Fix the uses of PFTSYN_SEM, PFINT_TSYN_MSK and PFHH_SEM to stop doing
> the unnecessary offset calculation.

This also sounds like -next material rather than a bug fix.

Thanks,
Tony

> Fixes: 7d606a1e2d05 ("ice: unify logic for programming PFINT_TSYN_MSK")
> Fixes: 03cb4473be92 ("ice: add low level PTP clock access functions")
> Fixes: 13a64f0b9894 ("ice: support crosstimestamping on E822 devices if supported")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>


