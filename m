Return-Path: <netdev+bounces-99480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB278D5029
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E1F284392
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4C2E859;
	Thu, 30 May 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnUDV8Y8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A60383A5
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087911; cv=fail; b=FGoVZ71hfEFlqlOmjyFVNqnu70O72e5CxcRI0h0hsqJ7+u9PfKEIXXG8M1ABf8aU7QJRy5liOFbPssl1XixYXUmHMl55D32fDWUOX82xYoE4zfg+fdKAHPiD3FgyJWwOArS0Mr7NjQ8ND+LHJSXzYl9aPVWkQJQ5rb7q5vI/+ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087911; c=relaxed/simple;
	bh=jw22mdNnTegzH8iHH0DGjySYEe+WLSf9deTe7/jSFbA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ec9ll+fBrxveoRmr4LdL56rjqZm5sUFZ2vk49yf3NwQIieCx3iO1gXIE0CXunF25lzfj3KDqUp14kSgYspIyLLSSFEvDECPwRkgVFBn6gZmoxgOKZDN9XLN4zVGpArwQ9URHiHaqkAeQa56mmMtuLRv2bO0bHPJcbnEdti03Vog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnUDV8Y8; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717087910; x=1748623910;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jw22mdNnTegzH8iHH0DGjySYEe+WLSf9deTe7/jSFbA=;
  b=hnUDV8Y81kCAdwBtcGq9OepaYD2szFSk5poioVzagEBM0+zxi562XiEd
   T3RTXf6FNE+HL82o/5Jojrsg7N5KYdtsfx/9b19svwp7T32cVWJiDi06N
   SFmtd7u/dj+1pq75tT/7+uBk8tfvpVIzLbM+YetvVowZE9gEDwJaAyX9J
   bhq39Lt8v6DruRo43ye4H2WwjjCy7kqYmb0d7VoBos5J99Eq9U+ZIKqXp
   D5BW3EU047cRjQRW88TpwCfEPTQGXS4Ebs+30jWjCg1GX3z0J6tt09uYL
   LT5MeItHjbUiA8dETJPVnlA8lNfe9BwDGrI3Mi4mEy9wnxLK+DuZzl6yh
   g==;
X-CSE-ConnectionGUID: w/xbqwliTBqcklLs+ipJRA==
X-CSE-MsgGUID: WozpYcBZR02ZPnGAyZKUxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13408778"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13408778"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 09:50:47 -0700
X-CSE-ConnectionGUID: j8KUwxDqTZCdcBulBMQTYQ==
X-CSE-MsgGUID: UqwVitkTS1mXA0hUvGG6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66741822"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 09:50:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 09:50:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 09:50:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 09:50:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 09:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbFpelx1MuxDYWwP7xsoEb9y4Pf2aEJwaRpk4tr90nYFvLocOXnHKXVsRFciQ8DvU+8wdxgALVX7CK3UguDtBXoPJDAPvItM0+yG7K461bGuecGt4b1EB/of1C/YiZhJQBsXoVZHFij1Gr80wlHwiNAKPgeM7TkCLlG5wOdmstebOpcGaS3PKoDzqUlhfcFiOLD+ILAmwRF0KHddOG5Gva8zJOq1vdiHMvNDf8vQsPW0raupi75D0Ny8Bbh4thxbhNuMCzG/CqZhs/lzmyhSMpj5Nm7Hu8+G5X3U5/UVGH9JLb4/oSRBwDmGDp/Tg1T6rfOeabYB90s5MfkTkC4yUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbcRuPrXkREYk6MWep4off4M04HXim9z7RyCg0nWUnY=;
 b=n7leUSiqatkp4rsoKLNgZZ9+fI9W324EFszZKLYCHdDGLgUm1oIXU1zdf93xkBEWuFvyo+wLLeRdKDCtr77VCz35kI5AgkIYOOuh0gZeLeswWlHwTbwF/9/hQXdk4bkpotDzGRBQh2l7d1qNxOUc+VB41xmIwqkL6EK+/8SWHDVHQEV1aa5khhohX9W+MLv51gsr6HhBE+fTlyDmMu3dsVE25S8MUD0NUt1F287if+fx1G0jpzvqT2vEPSWyik0V29ztBrdWLpn0ySmqt4Sj4YoXIlU3WMOL45iJEye+dCply8Hfzh766Q0hqbcnJ9b48bf13bOvM0MN2ukjgfvLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB8284.namprd11.prod.outlook.com (2603:10b6:806:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 30 May
 2024 16:50:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 16:50:42 +0000
Message-ID: <21903032-f845-416b-8be7-646d36c50f59@intel.com>
Date: Thu, 30 May 2024 09:50:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/8] ice: implement AQ download pkg retry
To: Jakub Kicinski <kuba@kernel.org>, Wojciech Drewek
	<wojciech.drewek@intel.com>
CC: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Brett Creeley <brett.creeley@amd.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
 <20240528-net-2024-05-28-intel-net-fixes-v1-6-dc8593d2bbc6@intel.com>
 <20240529185106.3809bf2e@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240529185106.3809bf2e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:303:b6::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 4099093c-1e0f-4548-dc7c-08dc80c8a4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sy84c3JDckdleC9YR1RMLzRCOTBzcm5YcnZDTEJFekRuRHFLZEoyazczdlcx?=
 =?utf-8?B?VjliWmsyeGRMazhJRFNMcTF2MFRTbjBjODdvOWlzWW82RkE0bWJ1RnBrZmFa?=
 =?utf-8?B?blhXZjFGOFVmaUJyak54RkowK0Flb3QrUHV0MnRYanYzOUQ0bFZGKzZpbGJ4?=
 =?utf-8?B?djJ6dWlSQys0ZU5FbmhMMUs0MVE3YUpaMGFZdloxcnpNOVNmSTZHS3RuZmpv?=
 =?utf-8?B?QVhibVZhZTd5RjltMGtqQ0QrMjdXa2xXa2huZENZUnZEd3pBdzNsN2s3MEda?=
 =?utf-8?B?SGZNeEhLZUQyZ0trOWdNcEFYNDNudnVnUUwzUzVEQ3RrK3QwYmIzVzF3QUpq?=
 =?utf-8?B?V2xpN1pnZVNESjFnS3dFbTZVZFpSRkg3b1BpTDY3dmM5dFRiUWxGVGxRaERk?=
 =?utf-8?B?MnZqNUoydDM5UUJhZUpjaHpEeE1lWjVVTmtBd0hzMWR4UVZna2JIWTVlTkxt?=
 =?utf-8?B?MFFrQjlvYmZZUElwZmNPcW9Ha2c3bUpWZFVCYUNnMVV5TlZrMzdtVndvUkRX?=
 =?utf-8?B?bDBnMlRBQUx2RElEUnlrQytpN0lqM3FPbCtzLzE1MXhNN0pPWFhMUzJXVTRo?=
 =?utf-8?B?T1JhSlJnYUltZDN2R1ZqSFNUbjBjMDZ4ZlMyUHZxT2pHNzZqbDYxWDZFMjRy?=
 =?utf-8?B?TEJpSzlzeDRtQ2VtcW1HOGx5emtQNFA2MUJFSHJld09JZUxvcXUycFFkWFNQ?=
 =?utf-8?B?b1hmU1dBQ0lJYnVDeE1MdWhoTFYzYlVyUkNSZUJTUmZhb1pWQi81NUFOVzIx?=
 =?utf-8?B?VFFzZEU1S0FEWHVCUmpKc0dCdHdKTTRtM1RYRThuMlhueThNSzZmNmEvN25U?=
 =?utf-8?B?QzRTek5CM1dLVGEzMkpwOU9zQzg4Q21iUndtcXlBZ3dFY3FkUW9tNHk4a2RW?=
 =?utf-8?B?dHBVanprSkhNSVdFKzhENDE4bGk3czFOWkxsUlN4MTR1NUdPNFJjbElBNUFF?=
 =?utf-8?B?dSs0eHV2Zmh6SzdNemw2Q25qd2RIN1gvTWJPVU9MN0ZZSy9lV3IxZXRmM05m?=
 =?utf-8?B?UC82dGRqZWw3bUpZUmZCWmhRSGRvaEZ1ak9Ta2gwMFVaRFFHVEhXVnFjNDNq?=
 =?utf-8?B?b2JPMm9EVGdBN0lGejJYSkxWYlpCbVFpeFdWdHl1K3R3eFFEWlBYMTBtQVkr?=
 =?utf-8?B?ZkY5QWcwOFhVamxzbitMNUhBa2tsUWxrOWwwM0I0NkFLK2kveWxTVXU0SGdT?=
 =?utf-8?B?ZnlQZEFyb1BaL1c4aHBIVWcyVE4vU1RtcFRrK2wrL1lJNzRXZEJjTG1qbFhS?=
 =?utf-8?B?Y09RdGgxMEp4YnE4Q2g5ejN2ci9Oa2d0QWVDZ0dIc05MZ0w3bThoU0lIdk1K?=
 =?utf-8?B?MFdVU1ZmRDNLMDRKcWx1bS8rcjZDVjdIS1lEZWZPTW41K0k2SGM2Q1ZzVWxB?=
 =?utf-8?B?b1pZMW1NcGZGa1ZnNkllUU4vUzl3alRDcWxHUVZDWm1WN1F5MXd3TmlXbndy?=
 =?utf-8?B?eHNxcTMwS05pd1I0RHJIdWRLUHhKSVdlay9ra3VXUGlPdGFIRzFDS3AyQnd5?=
 =?utf-8?B?Q0JkK3lOeHJIdDlHMkw4ZHhUdWQyVTRQWHN5TFFJd1haMUZpa1lPSGc1aHdo?=
 =?utf-8?B?emx0MFM3c1BISmVKQTNzYktWNDRJY0xvbzk1aXpiZzY4aVk2WVN3N01tYlp4?=
 =?utf-8?B?Q1p6c3A2by8wbU9FN280YVNJc05QNG9IVWlBeDFuYlBpRE9heGpzeVhnMWRh?=
 =?utf-8?B?WktETlpDZmhrWHJTay9XZ0J6MmZ5eURnNTFQK2VkcTUvR3ZPQjExMnZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjFMNkNlc3NwU0JxZTEydE5hOVdmcDlwRTlsV2s2MkxoNVJwMzdRUERzd0ww?=
 =?utf-8?B?MTVSaGdKckF1L2NVSmdOWGorL3JmTGxqSzYxNHJKTkFXdytEZTc3Q0dWeGJ0?=
 =?utf-8?B?V1JDanFIOG5xT00rMGNIT0JhNDhBV3dyZjJTQXRVQ2lpb1A5bUEzdk5OME5N?=
 =?utf-8?B?TWhZT2h3UGVoTldPNFBHOUtEY1AxZmRsSTdzd1Fvbm0rNDBoaDdpeklkc2RO?=
 =?utf-8?B?MEZYZGsrZktaRzdxcUxGeXVOOWZBV3RmOXpzRlg5akRJOFBTbTRFLzBub2Ns?=
 =?utf-8?B?YkpEdjlwT09nSGxQSDk4K0RORWpqamRhVnJmdC82dC9oS1FOSlFydytPbkE2?=
 =?utf-8?B?RFI3dlVyQ1FEc2pobGJmRTRLZWpZbmJ5WGoyajN0Y2RDOGJ2TkM3bTZwRmZJ?=
 =?utf-8?B?bS8zK0U0dzJuT25XRHdjSi9Wc1lwcE9LYWtQdlB3OGMvMk1VdkZWeXBvNmI5?=
 =?utf-8?B?Um14ci80SU5SUEVMa0VxbVYyR2pEVm52WUlPZHl1VThLVXJjZ0RDdDdLZFdM?=
 =?utf-8?B?aHBlYnZhUi9mRi9HUnVuQmoxWDA0VmhNanlNWWtXM1JZL1BMMWU1cWpYTlZn?=
 =?utf-8?B?VHZCZFgwbjVtbnQvT3F1c1BTRklBdEl4cEFEYy9OWkJrYS9FcVZUVnJ4ZHNN?=
 =?utf-8?B?ejFyaXQ2b09Tc0FhK24rZFJqK0l6VTVWWStyOEt2UDBTWWwvdGpXdG9Oazk4?=
 =?utf-8?B?T1E3cEZtSEJrRTBFQUtZM3BVaFBqYkIxL3ZxMG1nVEl6QWZaMFljbTJhcEp6?=
 =?utf-8?B?TEhsazdCVUQzQjZYaUFzbXV1ajEzTDZBTUlURGt3c1VaZFFDdmFYcDZwbnBD?=
 =?utf-8?B?YjFoUFcvY1l5UVgyNUluQ2FIc1pRQVlLcXl3M0VyM085dDJkaWZoSk9Gc2lq?=
 =?utf-8?B?Rmt6bTFSdlhQTjE5c1RQSlh3TXRES2haUkYvejRpbHpoSHVVSTMyWXdWYksv?=
 =?utf-8?B?b0gxU3ZuRWRpRDkxZFpjR2JZem0rYjVaejJxN090SmlxaWZxajhIVDFOVkcw?=
 =?utf-8?B?SzRjc1FKZTJmamZEWXcwUllxRkRkNGVBcnFrM0c0Z3gyWDVaaW5tcDBJMWRT?=
 =?utf-8?B?Nmc1ZmJhd3JtN2h6L2syc3lnYWVRaGZ1S2tRd3prVzRtNGwyWmVLakdOUjlS?=
 =?utf-8?B?TWJ1L25iSG9rUFZlZ05tRUJMU2s1VkgxRHhvelZJU0RzaTZMZkZZWVc2ejAw?=
 =?utf-8?B?dkw5T0VqY1pCeEw0ZUlDWDNFZ0RUb1hCZUU1dFQwVUNndzVoa2JPMFBYRXBG?=
 =?utf-8?B?UzBCcndCYnVVdmkxUXF6Y2w4MDlYTWN6amJEODBSK3RnaTEzQzVTdEoxU3Ev?=
 =?utf-8?B?QXNFWWNVaHFZdkxDcVdkQVZURjZXTmI1eHNOZ0ZUenVrV2liUEpPdmI4NEQ0?=
 =?utf-8?B?VWFMMTZRakx0Rk1abHVXcExZUGtodGs3aXNRcDdHRHdaZTY1a2QwN3crNytO?=
 =?utf-8?B?eDhiSEdLQkRaQ2h3THNkQXJkcXdmYkxaaXdpTjFDNk14d2lxR2NpS2xMVzlI?=
 =?utf-8?B?dDA1RzVlSUJwbmlZc3FydjZDanFVUU1VOHhWdW42eXZGREJZWHUzRDZqVk43?=
 =?utf-8?B?NUNndDRDNExsVENLSmtndjFldWhabEkzVDJHV2FXdmhDWWVJOEV2Slh3MmFB?=
 =?utf-8?B?K1NHbjBaVWgralZxZVY5SG55S0FMUzU5NmwybExTWWt4eW5acUkrMDZpMWQz?=
 =?utf-8?B?dGluWStxWk1TMmd1QlY2VG5TaURSc1pVRWxLRFZydXZySTVMbUlxQml5R1pj?=
 =?utf-8?B?alVxM1h1MWpWdGZoWXJhZ0RWSVBRbFJUMEIza0VrVUdnQXFiU0FVbnFoWDM5?=
 =?utf-8?B?TXhPcVA2L2FxQnhQRWRHbVMxQ0Z1elN6UGJaZXdRVjFZQ1Nib0MvMUJSbmNX?=
 =?utf-8?B?a0lEV2Q1RXExTFJ6YzkwZElHdXZEcG5jNkRSM01LNW9lcVR1QzY5RS9xaWli?=
 =?utf-8?B?ZnRZOXhWeGxna3pSRkRjTTVJSVhudDFETllVdDlTYjlQMDVtaCtmaUlxR1h6?=
 =?utf-8?B?bDVHTWtYK3lQdGFLMEZRS3RXL3gxWkExSSs1ME4zeVNaSUNEV1JEWkNwREVj?=
 =?utf-8?B?cHhHK0laQVBIei9yUjZ0UEVyUldjd0tydTMzMXQ3WTcwUjk5MmdSRkx0MlN2?=
 =?utf-8?B?ZW91b2VjZ29mWTg1K0dwaWRHcDhRSmhqZ3owcjFiWlJsbGJCb09SaGxUNzN2?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4099093c-1e0f-4548-dc7c-08dc80c8a4ea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:50:42.9383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7Z5Pr8+UW4lRbwy/Cl1ySkYQaN/Z+/R0ym5ffOsl/YILlGiUK3jSz+JZF6bJoGkHgI4SZ1AHkUb/MNWX2r9rqFSfKQAJMg15PVODe+30W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8284
X-OriginatorOrg: intel.com



On 5/29/2024 6:51 PM, Jakub Kicinski wrote:
> On Tue, 28 May 2024 15:06:09 -0700 Jacob Keller wrote:
>> +		while (try_cnt < 5) {
>> +			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
>> +						     last, &offset, &info,
>> +						     NULL);
>> +			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
>> +			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
>> +				break;
>> +
>> +			try_cnt++;
>> +			msleep(20);
>> +		}
>> +
>> +		if (try_cnt)
>> +			dev_dbg(ice_hw_to_dev(hw),
>> +				"ice_aq_download_pkg number of retries: %d\n",
>> +				try_cnt);
>>  
> 
> That's not a great wait loop. Last iteration sleeps for 20msec and then
> gives up without checking the condition.

Yea, that seems rather silly.

@Wojciech, would you please look into this?

