Return-Path: <netdev+bounces-130101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA3988379
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0D6B2118C
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5318A6CF;
	Fri, 27 Sep 2024 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFozqOv8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C71891BB
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727437884; cv=fail; b=fyQkyYYpYgkPkzMrueK0il/XItMsOeCJLZ9Ee2mgeCM3fcfDPc4mQXvaNnO0baTHw5LnMH4NMaz+sOQBMAXaArrXvH0h8OxbFetb446d+eZA/a1Hrajui1cWAIymhZV0ToZ8JyCA4la2ALdGKGjDRu9lmNLPWO0VOtuxwoqpL6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727437884; c=relaxed/simple;
	bh=XaG7370ptZUjM0Tdrer2uHMCy7m2UaSMoT9Ewhizgc4=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=eqMizeMjDDqoC9qshZl8laOQdzI15IC1QOAK4RT+M/0ALtwJcgN8nozUDmmPSiq1qCqnWhh19rW2mwfpP2rTO91gML907e19uVklY0RhhZ9x3g7iPaT9fjr5w1Z/nxE4S0TXjXH22T2rhy+72M8wPIqw7tzaGBELRR1lrpHbb54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFozqOv8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727437883; x=1758973883;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XaG7370ptZUjM0Tdrer2uHMCy7m2UaSMoT9Ewhizgc4=;
  b=HFozqOv8T3UeibOvIAsif3TvYhKCSPnEmhO7lSDW6RQnrlynT2RHxKZd
   F5MMcb8CLA3mwfQ0sF6a60gMOJWPy2p+klYX5nykADFkE3p34prBe1yEJ
   mErfzWkyRc/KU7pIbNp5q6qWbl0rjeA0Gn+soxLBHjH1gYesch1ZZ8mqa
   G/+b7RS/dA1KLEHzJARH9CCnUkQEeoasPn+wi43FSgsV0igqVefNv7YYd
   S3aNUA5xdLo57L4OiOz0N3r1EjKizFPlyc0+74GqMWgkWMqcfcuCu4zjP
   PuytNP0/HKcj7NnLWXcZSAkCxmM3XOXeTZ57AxiGF5WokFLb0a5y9cCgb
   w==;
X-CSE-ConnectionGUID: 26b7w4DnRPm1Sk95MYj9Mg==
X-CSE-MsgGUID: sJBrtzfgSU+UMxPkCf0Y1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="29461187"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="29461187"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 04:51:11 -0700
X-CSE-ConnectionGUID: 850pz/mYSjmJjQ4+vvcYLg==
X-CSE-MsgGUID: k7MwaNSmRJ2p3ZSLFUotHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="72817824"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 04:51:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 04:51:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 04:51:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 04:51:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 04:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOblZMXpT39uZBcQ9w3r+HajSBugudMQst5fG8Gp+kV7CgDdkkQr2TvgI9brvz6C8c+xBYh8O7HrhdMKenD5uEfU0YNu37r5oKh53QeLDtWfUzQlQBBpwOP1kGjfMExI5cQ6gEX4rNAFIXK1IzWsmRmlP05kfZQOQ3yG/lp86YrvSR8IDdzwzxCSruiHoknDoLvpOh4lRbMpl1fg69GA9MbGr9UXUFEbnovTLeaUdmGUniRHKfSIRNvWZTc3t5a9d9fw6wEb7+EYOLFWhZfTW1EZjU4Z/hYqcUSlsn3ZXV/bzwAL4Ww75crw2SjqZeHwBGAJa6DZSd20ym4kfnIbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3liV/vgZR/GcMbdJeQWz0FKBgSoqDibxZxJC7oGScs=;
 b=yOGkxVeABHRm/iFZvx4dqEgFcmLius1fYzJl9KYo7gBIQxH/kpd2SrdXXKBx9PYnyY/1xelX8/vy7RGNglmo6FS+wdglo29e3tnciuSzWm6C+WuKVjI1mvbdhPnOOq0uy30RS39Vfx+KHDQxSn9VFGNrPDoKEgf847p/gtRuj8gR0dMAMVKBbGOIebYmsjd5x4iTxZ6iiirPYT6LgVqCNrRN6moJngicRHcOdOaoxKzB4iH8hrVO8jXfHxGjnMCMet7ACOxmAmWFuAWXw/FNJLVhxiH8PXSzUiO0ECcXP3avLmj3N5F0nETKeet1smfpdlmYLAgUNlv4oB/GDXbn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Fri, 27 Sep
 2024 11:51:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 11:51:05 +0000
Message-ID: <577c1d8b-1437-4ff2-b3d1-1261c4f73fec@intel.com>
Date: Fri, 27 Sep 2024 13:51:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Advice on upstreaming Homa
To: John Ousterhout <ouster@cs.stanford.edu>
References: <CAGXJAmxbJ7tN-8c0sT6WC_OBmJRTvrt-xvAZyQoM0HoNJFYycQ@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: <netdev@vger.kernel.org>
In-Reply-To: <CAGXJAmxbJ7tN-8c0sT6WC_OBmJRTvrt-xvAZyQoM0HoNJFYycQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: a302c76f-04d7-4881-ee46-08dcdeeaab58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekZHVmJQMVQ0cTg2SVY0WC90QlFPblZqNTlhSkhmWDJVaWlZenp6eWtJRUV2?=
 =?utf-8?B?VWZJa0c2dGl5b3gzRzVKUXVOclh3WjV0OFRiN0RFRUFET3VhaTJTY3VoK29M?=
 =?utf-8?B?RWpxTHZ4czZCMHd2SkdVT1Z2ZU5BOEVjQVIwQUlEL0pqMlVPSU1kNDgraW8y?=
 =?utf-8?B?cWZQcHdtb2YrQkx1cjFGMTlRTVU2TUt4bTk5SGQvbDVSdUxCUHMvZTdIRDZB?=
 =?utf-8?B?eWtCZFBMTFJMVGhwSHJNWU05Z1EzK3kwckNZcGFnRHcvR3RQTHg0NmtlYm82?=
 =?utf-8?B?TUlPd29zK2VHaTM3Y0pCRXp2L3lDb2xqdnJOWkZ2SkY0UHcrMllaRXIwSHZj?=
 =?utf-8?B?YlZxbTlYamkxU0pmcjFuekZCNjVESTlPVFE1SDVlMDc0dGFrQlkvYVZ4Y3lL?=
 =?utf-8?B?eWdEc1dQK0tGa1RlaDJ1RFZEWjFtUEVHQ2FnVnYrRkFwQkQ3b2dUbDRyQWVO?=
 =?utf-8?B?VSt0WG9nVTBUc0ttWUpQbzNBTlAzN3h6TUk2QkxPaFVWNFhyTmRhNHZkS2lr?=
 =?utf-8?B?M2pqdHVFTmYrVEZqaWFFRmJoWnlWRUtGcnlLay95VmM3YXdpVTlWS2pMazdB?=
 =?utf-8?B?Vk5BbFF2V21odmJWODJKQTFkSGhKUjNUanh6R3hFUFVvb2lEcjY1cXdHRDVw?=
 =?utf-8?B?SlgyNUtUUFFGNno2cEFQbm5UM3N6QnNOL3JkM1BVcU9SRWlXVmZyWWI4VzAr?=
 =?utf-8?B?cnpVV2RoV2ZiUlhBdFNOL1ZuVXkwS0NrbDFnTlNPdXV6d0NtUW92RmtreUI0?=
 =?utf-8?B?MW50VXZoZ3B4Q09WeWd4bTJmS3hnbWdmZmtOR3JJVjQzSWJ0VTA1Z2IxQXhs?=
 =?utf-8?B?RVBhLzNwVmtuUEdzdVExRzBzV0QrUWJ1Ynl3UWlPYTNXbGdUQWFMWm1GM0JV?=
 =?utf-8?B?QzVmeVpweUQrM09ETm5lZmY5aXIydGN6SDBJaktqUVlRRHI2dUNyQVJ5SGpq?=
 =?utf-8?B?WktuK2U4WTJ4RFpmY0grQkRGQ0hGV2s5c3JvdThMQWJNTDI5SDdNSlJ3cEU4?=
 =?utf-8?B?SnNmbU5ZYitiVTVyb0dVY3NnbjNST2JaaFdUOUhIY2RpTlZCL1NTTUc5UzFo?=
 =?utf-8?B?dkJIaFBRM2s4b0FoRm1RUnI2UmtsQm1TRWhOdVhqUkpFWnNCTzU4bUFmTzFa?=
 =?utf-8?B?dTByT1ZYK3oxOE43WmRxZ2hqb0NYTUlyUTY5RUl4dU5GbnZGTk4rWFBOZ2ZU?=
 =?utf-8?B?cHd3SzNwVloyanNDUUcvU25FZTNidXlWakZPbU53NmdmOGcvMDkyaW0yc3ds?=
 =?utf-8?B?SWxMWDFlVWpjTlNxYUxHWEtVa0FGVThXV3d5TTl6QnBncmVaU0I0UVRCdjF5?=
 =?utf-8?B?WkNFRHowbjQ4cnp3U2cxUGw2THJTVUdBZlpXRkg2alZoM1Y0T2ZrNis3bVRa?=
 =?utf-8?B?aW5LaXlTVE9pNlFxOERWU1NBMFpNaFNiYWtHcVF4OUVHOGRJZHBQWVllQnEv?=
 =?utf-8?B?TDlXdWo1M1Ara2R2b3YweUNUckFib2Zic1orTjFuY2dwdlRtY2c0NENIU0Mw?=
 =?utf-8?B?WStZZ0tQeXRXNHFWV25na0tDSXpXV3ptdVRPYXcxODRlUm1rNnhGT0JLMFZ6?=
 =?utf-8?B?bzNESmxYanJyL0JJdGZKMGJZTEkxMHVKVk5nQkUwK2lxZERZbHZhZndEam05?=
 =?utf-8?B?Nk5HZWZjNThPNGFwbk1McVgyNW9PWlJsMGsrTnBlVlBSQ1NxbStoTU91UmZR?=
 =?utf-8?B?c0FpcjkvbEk0M28reTFxRXRIa2s0MTNpSWo4dGtkamhIWFZyanlRYTZUK3ZR?=
 =?utf-8?B?ai9vYU9pS045Z2ducW9yNUZsck03M1lXa0VkclpQYmtsNTZ0OHZ5dWZMaEJ4?=
 =?utf-8?B?SGhjY1FsY0ttMTFMZ3RFZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek9IWlRNMXQ2N1BUb2ZJVy9FNUFlQi9YblBuSHR3MzJYQ0FESTltMjRhTUwz?=
 =?utf-8?B?bmdwL1dNVDBWOGFFaWlPaXJHL1l0MW85ZXdKbkt5NENDMGZUT0p5RGE0TEtt?=
 =?utf-8?B?eTZiQStkaVlTQjNCM3ZnNGRhL1laT1kreWdEMnNIcDRwbVU3OUJ1M0FGNmhS?=
 =?utf-8?B?Tk1uUHVKeEQ1QzJQQWhrL2NGSk9OcSt0allUL3A1Y3B4VWErUmxxSzhzdEpY?=
 =?utf-8?B?UDdpSzNnV2ZrQmZ3S3VjU0JhYW9wNlJBYThUL2k4Qm54VWJJZkc2b29VQ3I1?=
 =?utf-8?B?WmkySVV4cUtuSnJwbkxMeFV1TWZ5bVNLanJBdlo0d09LNkVNSnVGQkJSVEw2?=
 =?utf-8?B?dEJCcjFmUlQ0NGpFVzJGU2FkYmtSME9BRGErVzVwRERCbjFlNnQxTDRrT2dp?=
 =?utf-8?B?bkk0WFk1cW1qSVFMNVBOQVA0cXlkZmpDcHFqTHZtcldlK29jTHliWThMNGVX?=
 =?utf-8?B?VFJaMkF2NHRMa1dJa25icHZWbEN3V1g0WC8xS3VYd0xMMWxjNnBLRXVnRmRi?=
 =?utf-8?B?RUZ2dHJLVmxzVEhBNUUveUhSZXZLemZMZWg4SmsxcGpnK1pxRmt2anV6MGFv?=
 =?utf-8?B?ZjUyb0Njcm96NVpYdmZLMXJmSUFGMFU3M0d1dXNuMXVqamFKSTF0STEvY1gw?=
 =?utf-8?B?N2tFbERhMTdrUGJWbE02NWl3S1BmaC9sNGUraG1KY3pudG1icFpTUWt4SDRt?=
 =?utf-8?B?SWRuR21rdUR0T09HUm9iakhYWnhmVzA2MmFLanIySno4bW9TZUVoUWI3Q1Iy?=
 =?utf-8?B?cEdkdUdnaTVBWmRrTUI4SUl5OFVRSlYvcGxibDZZeEZMVDJvWkVZc2p5aURv?=
 =?utf-8?B?MDJUOExYaHgzZkMyOFIyZjM1L1c2elByWGd3Tk1KNzdWUFpHQW9ZYXR4Q3dP?=
 =?utf-8?B?VGtDMDdlZHQ0cjFiQTNxbjNIMkRrUlFkbUdoTVZjbWRVNUZ0WU4zWWVWRVJO?=
 =?utf-8?B?N1lSWXkzaitNVEliclIrdlRtNVhzZWpPSjI4SEtNQmQ0YzBNVWpLNXhsMm9y?=
 =?utf-8?B?MElabXpwUmp1aUdhRjBDZmN6RTlpREd3alh4aTZhYVZtZVJaVERIL1h2QTNN?=
 =?utf-8?B?bFQ2TGp5SkhZZWR1VEoyK1NLcGRPUFZSN2RGeGVrUEE0dE9BK05ZeTdVRGR0?=
 =?utf-8?B?c0dLMkt4WlN4ZE9KKzFMand5SWV0SGllSEpyREMzV2ZxRWlSekF0V2lUeDg5?=
 =?utf-8?B?Uit4YVBud2hFK1F2a3Q1QVBZWlFSekJDQTAvT3V4YUNzTEFUYmVqbHlFNHdW?=
 =?utf-8?B?SVBXSFZlK2dVeDFDYmt6MlRQeDhiaXdxTXBXQ3BxUXIvK1VuUEcrWnJlMW51?=
 =?utf-8?B?ejE2cW1VUktGV2F6ZDFSVUZaK3VJdjBtalRMQklTSy93SVAyY3hqNm1NVDhP?=
 =?utf-8?B?NnFCZCs2bnFEWGpjYWxCREVKbTFnbW0rd2JwT1hXQlZuRE1LdjhlS1B4Wisv?=
 =?utf-8?B?ZnQrMjQ4czFIbll4YldzSlNDakFjUEVGdEZYaGorNTJGSS9ockVqSElGR0tS?=
 =?utf-8?B?anl3MGNxM2NnUlFYaytkQjFuam9rMzl4cXBCZU5jbytrTlJrMW9TNUppaDNM?=
 =?utf-8?B?cmNpTWc2QzVEUWlPSWJZWExFWk1vQ3ZGeWZzSXE1UkZ3aXBuNS9MaG5wb3c3?=
 =?utf-8?B?cGI0UGNtOFpyZkNDeFF4QUdjek5hcUw4ZWZWOGZDMlc5ci9EazdBMXpMY3o4?=
 =?utf-8?B?SDdpdEoydEJldWFHWHlZU3F3VS84NC8wZWFwZUVFaWlvU3ZEdWxDR3N0eUdE?=
 =?utf-8?B?ZWNaUWRyWWRtbE42dXRJc2JLeWNyY2Y3RWltdndBSW05d1R3QW5aUGQ5WWNk?=
 =?utf-8?B?cDlXcHNXZXdOTUtZY1JSQzJTL0UyTWlxc3dwb0FjajJsQ0lLL0ptSmFOdS9L?=
 =?utf-8?B?WEdzMFN3QnRiTkFKNWEzb3JwM3l3MUFwTjk3amxaNndOUEJaTWp3aDZza0NN?=
 =?utf-8?B?TGNBbWxHNjR3dnJyNDlpZ2lNV3U3K3F6amw0eXNnV0VMZzNiUWZPTFdHSit6?=
 =?utf-8?B?eElwcEc4ZE9nYTFadmU3Myt3WldRaUlYakxWZlAzUVdzWVRqL1dZaURTUEFS?=
 =?utf-8?B?SDJTSExQem91Zkg0OHNSSGRWVm1aMml6alBhK2Y4N2NSVHk4b01IcjExTW15?=
 =?utf-8?B?ZDAvVk5NK084NmFneWh3ckJRYUVINGlwY0ZtUDNKUzdoYXl2OENBdnFwaVdp?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a302c76f-04d7-4881-ee46-08dcdeeaab58
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 11:51:05.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3dVQPbtosNcwEeVsI2yuiO7kASUJSK1ZGl8OXO/+kUbF/pnRkUuvPHMt9ZmvE8yXOBEzLYu/DnaBIzg1y0Ymu46Fco7G6GFMqQeQDPgIQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-OriginatorOrg: intel.com

On 9/27/24 06:54, John Ousterhout wrote:
> I would like to start the process of upstreaming the Homa transport
> protocol, and I'm writing for some advice.

I would start with a RFC mail stating what Homa is, what it will be used
for in kernel, what are the users, etc.

I saw your github readmes on current OOT module and previous one on DPDK
plugin. Netdev community will certainly ask how it is connected to DPDK,
and how it could be used with assumed value of 0 for DPDK (IOW upstream
does not care about DPDK).

describe what userspace is needed/how existing one is affected

> 
> Homa contains about 15 Klines of code. I have heard conflicting
> suggestions about how much to break it up for the upstreaming process,
> ranging from "just do it all in one patch set" to "it will need to be
> chopped up into chunks of a few hundred lines". The all-at-once
> approach is certainly easiest for me, and if it's broken up, the
> upstreamed code won't be functional until a significant fraction of it
> has been upstreamed. What's the recommended approach here?

the split up into patches is to have it easiest to review, test
incrementally, and so on

if you will have the whole split ready, it's good to link to it,
but you are limited to 15 patches at a time

> 
> I'm still pretty much a newbie when it comes to submitting Linux code.
> Is there anyone with more experience who would be willing to act as my
> guide? This would involve answering occasional questions and pointing
> me to online information that I might otherwise miss, in order to
> minimize the number of stupid things that I do.
> 
> I am happy to serve as maintainer for the code once it is uploaded. Is
> it a prerequisite for there to be at least 2 maintainers?

are you with contact with the original implementers/maintainers of those
15K lines? one thing that needs to be done is proper authorship, and
author is the best first candidate for a maintainer (though they could
be simply unwilling/not working in the topic anymore)

1 maintainer is not a blocker

> 
> Any other thoughts and suggestions are also welcome.

no "inline" functions in .c,
reverse X-mass tree formatting rule
no space after a (cast *)
use a page_pool
avoid variable length arrays
write whole thing in C (or rust, no C++)

> 
> -John-
> 


