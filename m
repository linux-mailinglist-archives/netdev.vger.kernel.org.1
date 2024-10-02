Return-Path: <netdev+bounces-131365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF098E548
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5354E286F92
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209882178EE;
	Wed,  2 Oct 2024 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou73optK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DC19412A
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904538; cv=fail; b=Y+I9tdEIlqxFi7Gb4/wX4iUss4T965pk275FBzXtC0S1NHYLfMgQmbkoTMqYfGM+bPCJKPjjWQbOEDgKSdWTOLiGNWtIe2zanG+R1knY8RqnUqOhgjSCCBKTA99mVZRtLPI2Uu9lGvoAHQ1QP24ofRXIIwp5vK2OKqrZ49MCFD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904538; c=relaxed/simple;
	bh=A/U818oghmW7UnDIntNlPWPZqz0LcBOoBsDCV/8T6wI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vq1SnTevCfphlhWW7B1sdV7TEiwMKdE+Zfn0e3cOoed/lVvgE/ULYkI2V/2Tpd4mJtDsv0z2vGY9NprLaqV+ToFZd63kHDcDyhYYuvMnRud+9gXymL1Hqo7ftKIBZF7NhMuocIMByih3Zj/warkgcuwg5k77egNIxlMLAhD3hYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou73optK; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727904536; x=1759440536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A/U818oghmW7UnDIntNlPWPZqz0LcBOoBsDCV/8T6wI=;
  b=Ou73optKiZ0l26I7XQIHUPCL4qnbyxY9v8rgdBIX2XCDhOSf4VqXF8R8
   +zVIw8yOXEnz0Hv5sG9hDfX4IbH2cwLYjViD2/dgfk+hWJevMgxcvjvaV
   Yb5+ihwcqjfLmsYk7P7CoXdJKVkJ7GkEtAJe0xJFiij2OTlPM4pEF8NND
   JrT1vpE4/2uo26S9SVkac4uJ9uHESXR9ohxSgIWbFQbcS0P+88DBWYaxz
   +vmNJLgTz+hY2Au7gFXbxB7a0kkjkH4lIJmGGXK1k01aSV+0vVuqk4jg7
   NGT43IgzT1ScwThKFUUnVuSJvnrz/z6h13UL4YkrK2hvF0S8hlwFpO2KL
   A==;
X-CSE-ConnectionGUID: 8bS71F30QPqWOdOXiOjsDA==
X-CSE-MsgGUID: 1UhDsrTXQJqszu2TkEi4Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38445097"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="38445097"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:28:53 -0700
X-CSE-ConnectionGUID: e/gzdq+7T7i+pSaqikF9lA==
X-CSE-MsgGUID: Qll8BwMhTHqAYD3T2bf4uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="111589937"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 14:28:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 14:28:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 14:28:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 14:28:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 14:28:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEUZAdZwT21ZxPFkOsO7/3ZTiUQ+TDNAer05r+9N7uWvcn66fNK5LCrrRXYiXugIV2FR49s2cqpUz9LO8INmaGrkbVKax1eOvBuW3/7khXwWcM1Z+1pEgeRWyomlBE4MMFzne5QThDa0nff8k66XDyINdCrJRDbxOhDIY7gpPAUbvVEQYguGk2iRVHfFqGr3/5oIwtaJMrWXBjnI0XDrIkzRvaM8t+sbDINiqzp00jKKYD7yAORfJUEq7zVt5Y+Vsa1I7FN5hnEPqnYDuiX86Wwm5HVTcZ+oBs30Cnu+y5qvXxgtPOhEStsDxeH1SoeuKtUmUpZk3keIH0wCov5eYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9follSprVUWmnrlIFIEaY5J5oPkMHdhWebMoAM1cOs=;
 b=kYMO8L548D/63ujZdoDMkbaEgUmrOFgtOjM7CB/h39ISd3l8020npaKZrKFEngh3/oh6kCSSn/fAp4sF7sfi9H9pmy4zfNOdtYunHGpkC3O/uBCxCJHxo0Yl/XhKJOuPCFSORadAB4ZLk2LLJDGVeRsOLjC/iV43NPHCCK6+sT0I7XATUBIvVZ29pBrvrLTIWbLcxFHA3EZdTrTeS0XreviHP7XJOGMdrDMVVP7HrOO4l/F8Ne4SOOXtLkLJv5EbF0qCBD5vqPPjEIjco3YmX8wo/P+SrXkFQWn3bGpIl5VF9TdMHigBmAtlIH3oWGF4DCLufxrRjSIakNJ3Oo1LUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7625.namprd11.prod.outlook.com (2603:10b6:806:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 2 Oct
 2024 21:28:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 21:28:49 +0000
Message-ID: <4ab39776-190c-4abf-960a-9eb05dd54fe0@intel.com>
Date: Wed, 2 Oct 2024 14:28:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] lib: packing: refuse operating on bit
 indices which exceed size of buffer
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Vladimir Oltean
	<olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	<netdev@vger.kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
 <20240930-packing-kunit-tests-and-split-pack-unpack-v1-1-94b1f04aca85@intel.com>
 <20241002134406.a5vpk2cli5nqlvfu@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241002134406.a5vpk2cli5nqlvfu@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb9eb96-f529-4e11-c695-08dce3293443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTFaZkVSNDk0VEtWZzRpaGJpVUhjL29EWXdrQURjOXVnZzRjdnVVSVJvSmxX?=
 =?utf-8?B?Z01keFBuOXFQTFNKenlrejRJQ2ZLMnJGQmdZMkREcDBLbURWcithbDB6VC9H?=
 =?utf-8?B?U3k5UzNvK1liZ3ZSWVFkZXpTSWZIOWwrMks3M0JEMmkrbkExZDZLVllLclZt?=
 =?utf-8?B?ZmtuUDhzblBheHlSR1Q2eC94ZjE5QmtOQUZRdlFOdFUxaktEUGtORmpGTzhp?=
 =?utf-8?B?YUROZ1B5Mzl2UHQvRjVXdHZBT1l6Skh1YytLYVA3aE5kNWtGNjdWV3l1cTND?=
 =?utf-8?B?RjZhbkFZc3hpQWNSVnFWWTVoUnFmU0F0L2NJS2pLUXdWL3VPVHlDaUNvOTUy?=
 =?utf-8?B?N0F6T2Q1OTZ6TDh3WDE0QUUvYkt6Mkl6aGU1aGw0emR5cUhmL3hDNGVhbGNn?=
 =?utf-8?B?OStFWkE5Mm40UTI3N3UvUWtkOWp4Ti9VSjg4dWZnSElGVEpyeEZJTkVveWU3?=
 =?utf-8?B?WnFESGNBVVhaUnM0MHpUVWcvZDczMnVVejdVWHFNQnF4TEZFam9rK3p2Kysy?=
 =?utf-8?B?Ly92WTdWN1pYWHViZGlUMGh3ZTRHTCswNTZRRXZkNVl6MUpzTG55VklLUENX?=
 =?utf-8?B?M2pVSU1aY1N5Uzd2T0hFMm9YdlFodHZVSGFPanBtNzIweUdPU1ZaWHViNjI4?=
 =?utf-8?B?MlcxLzREOFlsQWIrcXl0Q3h0MytnR0krT044V0xPb0tEWGhTbnFweDU1S0RR?=
 =?utf-8?B?QlNVR25XQ214WSsvbTBQT3NBQlNFUVNLQUloQ0JhKzVXMXFrbFh2ai9yYUJU?=
 =?utf-8?B?NnJ2aHFvbTRXQkdWWWRVODBqR2krSzh1ZCtINDBQUUFGdk5aTkZHeWdGb29D?=
 =?utf-8?B?K2xiak1mK0dPeTVRQnlVY1FGNjVRenVjK2xSNU5BdmNFMUtpNURKeHdpbk5q?=
 =?utf-8?B?Z1JNWWN4OGpxN1lqa1RtVExCVitscEJvUW00RGx3eEFyemR5dlJlU3gzUFow?=
 =?utf-8?B?Yi94WlQvR0sxQmN2dzRVU0MxYlhqaERtWXVoOFlrMEt4dUFRY3hYMWhKSmRt?=
 =?utf-8?B?RWFObGxITEtlVXVXVDJ3bjROTS9SeDU0R2Z1RTEwTnNoT2ZaaWJxenBwLzg5?=
 =?utf-8?B?a25xRlBCaVNpYWVWbVFxUUY3SGg2ZEsvZUUzRmZuNVVXQjV2YTVvWWUvRkIv?=
 =?utf-8?B?TThPa05JRVNsb1dBalJhOXNERWlKZGw0ak5uOURsd2ZLTzRqOHZFK0VMVk5x?=
 =?utf-8?B?djJsODEvU2FCaHNTdEE3QjVJbFU0bnhTa21SNllNSG1VWHdORVd4a1JuS0Nh?=
 =?utf-8?B?MXRNTUczRWJvVE1NMW5nUHdFdHI3ZE84Y1N0ZHNpZlE5cnpTWk1aZzlVMnRP?=
 =?utf-8?B?YnlhUHBFanlxcXJFQjhldG5DMEU4VGpIVzFvTi9QTklwamcwVkRWdURIeG1j?=
 =?utf-8?B?WHJmVmMvengyQWMvRWUzRG9odjFDdWtlVUtIbGY1V2lZclNhZVI0Y1UvNGJW?=
 =?utf-8?B?SG93a3dUVjVCbFFWdFRHL3F4NWtVT1FxY29oY0dvME0vNkxUYXczQ1l0TnZQ?=
 =?utf-8?B?TXRaQ01ick0yaEMvMXFwcXB3b3BSblU0Vml5SDNPSU53RHI1WVdnUWxuSi8v?=
 =?utf-8?B?SnNpL2R3NG5ndk83SlUzUlBVaHQ5bVE2RStxN2ZSY0VHVlRhNzU1b0FSUktD?=
 =?utf-8?B?bzZ5SW1vdm5xaFhiZEp1TVJtUG44dWUrSU1JZjVXcG1aSzZhcVl5QjJXTEo0?=
 =?utf-8?B?VkFiRU9xSVFZd2svbnRnY0tMUHN0Wmtsa1lobG5FZWtJNFB1M0c5OTVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3V0SklMaDU1U0ZsS3dITXhsU1MvTmQ4Q1N3MHBjaEJiNVlVOTVzTzRrbXdM?=
 =?utf-8?B?R0tYWWlvVS9Td2FsaFNBeW0vUXZudDBYenQ0STJxU1BWSU03WkZzQmQrNlNh?=
 =?utf-8?B?ZWdRbG1vOHBqSGx6RXFZWklYc3plOE1vRE0yTG5jSTNiK0VuY3FRUnBTYW9T?=
 =?utf-8?B?Q05uYU9pSEJTTXJCS0ZVMFZVWjZ2TkJpWlJNY1JVb1hWUldGTjNOUlBwdU41?=
 =?utf-8?B?dk52WVZ3aGVmeGpkY1dpWmZac1h0ckVWM1dUeWROaHp3aElGYXE1cERTVEFw?=
 =?utf-8?B?VDVRMUtmeWk0dG5PV2pxQ2E2MXRuV2t5bGRCVERZN1hLZ25NdVByN2Q1d1dY?=
 =?utf-8?B?YVlLOWQzcVNCU0NNYXV1WVlrSjY4UTZoMDErcTExeVdReWlXanp1RjhaS3RW?=
 =?utf-8?B?NUFNeTNuMmdwdzRzaCtBY29YMUwyUWRwV1JlcktlRGh6NW14d2Z1YThodytK?=
 =?utf-8?B?TGVEZ0xLbU03aHA1dWc2cVY1eTlac0ZBQ0wwRUd6TDlGVlY2Ukt6Mk1UVzhO?=
 =?utf-8?B?STkwUTRCbGxmRStFem1BNmdMdThXQWM0S2JwRUFPbkZ1Mk5CWWdpKzhMa1gr?=
 =?utf-8?B?aFdPckxXK2VlYzhYQmV1NFZiQkx0U3pZcGg2cWwrRml4OXVoSk5senhKWVE4?=
 =?utf-8?B?eDA1WVd3cHRQZmo1SkVrVnc5eTFraStuL09yZWh3UEQ5eE1GWDZjcE1QVlVt?=
 =?utf-8?B?K1RWeUxTMTE3M211N1pxcUV5Z051QVZQa20vMVpDTlArVmtUMU4xMmRxOG5k?=
 =?utf-8?B?S2F4VzhQV2FUTUw1MjJqbksyWm1od1BNdkFpVmhCTWhYbHV0RG9FZ1Rvbk1W?=
 =?utf-8?B?aXh3VUR6Vm9kNDF3V2N5bmYzYVl6dGdQV2dYVmNlT1E3UlJwZVQ1UlZ3dHBj?=
 =?utf-8?B?RzZhMmRBS2xIb2RYOWgveUxDTmFHUFVTZzByUko3dnA1ZmdHb3A2UGU4VXgz?=
 =?utf-8?B?VUxwZ1BxYWFRQ2dnb0x5TXRCL2djZUZNaXRzanA3ajc1cWtyeWZWUExCZlhD?=
 =?utf-8?B?MWF4SzJBY1VtQnN4TUwyUWFQWUdzTm5QWmFEL0FDaitGYVZ3T1NHcGRmYjlH?=
 =?utf-8?B?NkdzUFVzWmdPY29DR2dOVTFNR0RwTVNBY1EvM3FPOXlvMnpzY20zakVENkc1?=
 =?utf-8?B?SC9qTEwyV1VEeE5rcUh2Z1QwSHdjaElVeUpkRXhLakI3YlVlemd5VHJ6dVh1?=
 =?utf-8?B?UEZ1Z1pzWGQwZGMwY0RoZDdoamZtcVNvSkxDdDJxYlZSMld0VEZvRHVVZUln?=
 =?utf-8?B?Y0dNMHpvZ3dMWW94aHJpdlRGRzEvdzY1by9taE1ReHVFVW5jbHJpdU90ZWth?=
 =?utf-8?B?c3RiWEtnQzdtREt6VXlWMU1XVUd3RUlyUHdmdy83czVRSlR1aE5sRzIyMDk2?=
 =?utf-8?B?TzBCNXYxMFJrVFBON0lxaG5xWHBFVG9CYW1STGxORGdoT3MyN2g3Sy9hSWJh?=
 =?utf-8?B?S0ZrWEdrQlY0dVR5SnRtMlpSSWtUenpGdVZrd0JORjBSWTI4R2NLUWNPa3Ji?=
 =?utf-8?B?WCtzc21XeURvb0xMUm1FNCs4TUtmVXRVS0V1a0E3WExmdG9pZC9nYVFSSXRv?=
 =?utf-8?B?SkdCOEZZeGd2ejFXbUdBUnRyRXlVNE9UTlh1czNQSmtxNVc0Ukt5cTNWSTYv?=
 =?utf-8?B?d3ZyRlYxQjVBSEFwWnZHZmM5V21jQXRpRWs5aDhuNWs0VUtVWk91Vzc2WStQ?=
 =?utf-8?B?V0dpUTBrT3B2MnRMcWVkR3hIV2RDaDc1RGRPaWdDU1NycGFBWDYxQTkreGJu?=
 =?utf-8?B?YXFrM0hKbDBZWEkwY1RKeWg0eUkzSmN5d3dla3lNVkFoVTFWaC9GbHNKeHJY?=
 =?utf-8?B?NmdpTXl5M21rZ1VjanY0cEh1ZmtqMTh0cmpMMHh4c1JpaS9jVU5ydnA0Rjgy?=
 =?utf-8?B?S3NMdlNpdWlHRUpsSjdoMnR0NzFzUGFBUU9Jb1hoajU1OGcxUDJxMXdOWVV1?=
 =?utf-8?B?M3lWbjVlT01XU1BQd0VrVFFTUWhYOS9sbTBVa0hQMHJWcWJSMjkwQnhJb3Q5?=
 =?utf-8?B?RGNWMGozUk0rNng0ckZ3MTRiVVc1OE5OdldjRWxZMXlFTW1QQkZudmczaHdu?=
 =?utf-8?B?NDBUUlEvY3hSbFVlemdhdHdZRFIxQlJINHhFcnRFTTZKTDVzMHlwa2prYWFn?=
 =?utf-8?B?MytsTzVKbm50TlAzRkVqMnVxQjFZeFd1MVJNK3kyek1rYUpwYjUwMVA5dlRP?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb9eb96-f529-4e11-c695-08dce3293443
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 21:28:49.0551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2PESXpkji8XqXE6zE+mEWM099grdLsGaC3TpMhJPwd7KqInEW4uKSnYgtE2CgmCLNsc2K6trOUimMUJVAJsbh4IaOA9x2WasMwJKP9bLTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7625
X-OriginatorOrg: intel.com



On 10/2/2024 6:44 AM, Vladimir Oltean wrote:
> On Mon, Sep 30, 2024 at 04:19:34PM -0700, Jacob Keller wrote:
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>>
>> While reworking the implementation, it became apparent that this check
>> does not exist.
>>
>> There is no functional issue yet, because at call sites, "startbit" and
>> "endbit" are always hardcoded to correct values, and never come from the
>> user.
>>
>> Even with the upcoming support of arbitrary buffer lengths, the
>> "startbit >= 8 * pbuflen" check will remain correct. This is because
>> we intend to always interpret the packed buffer in a way that avoids
>> discontinuities in the available bit indices.
>>
>> Fixes: 554aae35007e ("lib: Add support for generic packing operations")
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Tested-by: Jacob Keller <jacob.e.keller@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
> 
> I thought that Fixes: tags are not in order for patches which are not
> intended to be backported, and that is also clear from the commit message?

Ah, yea. I had intended to drop those, but forgot.

Thanks,
Jake

