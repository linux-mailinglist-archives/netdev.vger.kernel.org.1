Return-Path: <netdev+bounces-153687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02439F938D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB77164640
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCEE215F68;
	Fri, 20 Dec 2024 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iyn9Ixu8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B31E50B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702554; cv=fail; b=sllRL8Bu+FimGVPHS/5hngchvcwG1NFVgY1h11ziUvUUcUwkQRID5stuIa5U0zAIctNRSPaqpvXm6ykonyhKuC7rwo58aGtC9lbq8MfZxqKA7qwb5NsTkpIfYYNubmDkg9W4FpXNj/PGhnY9q1yjHJ1S823KB7BoT/G05sntpnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702554; c=relaxed/simple;
	bh=hIVpjyuRMeR9SJW4wxj41sHh+vNU+LDdGi7styRdr5g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p5b+KP4qvr+AMsTXFtvlXSiLXQSdvjNBR0VlhiEf+YQgtnsUsp9xQOz13PLFzUH+1LMiL8DPzqkOFRowRWBPp3bvbW1geSYnRlN29ZghYBwBPLzMuP67G8i6lCoAjFrK127Z1gIbQYsdomFSMMh+ISGkOikZjmvvyVUVXY7HlUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iyn9Ixu8; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734702550; x=1766238550;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hIVpjyuRMeR9SJW4wxj41sHh+vNU+LDdGi7styRdr5g=;
  b=Iyn9Ixu8VPb55+Ku9OH4PKiiidayiXgD5FAUJt0OpIl1yM2tOyKSqWGN
   6kRq8eAxvIIl8yE7L1TtJsQdEprkbG5YyXpIYV5fGwZSjklnRCYUu9zg+
   4j4pR3ulOBhKQEzdKZzZNq6rEvZ8SbPNdA3ESVR/BCnX7g0l8qxJolZIx
   zjo84Fc/ppXNQlZhPRov/iYNLx+eiyfJ9rAg4cC4RytT5RTsg8JOF/mPg
   XvCc0rgBUas9wCbPfqThNVApKH8BUTTSQ8qX6WvndSo4zexob3o4HoYaK
   oAKiBozPfrA4uQx2WDh+GG0/wN/+Qx6Bf8C1qqcq99gWdaj+4zQ3egg6+
   Q==;
X-CSE-ConnectionGUID: l1nVBq9fTLqX4swUNKeBkA==
X-CSE-MsgGUID: Q47a9mZQR3O+HB2k+QUatg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39035801"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="39035801"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 05:49:10 -0800
X-CSE-ConnectionGUID: a19ZxeO6TRuyomLlMWmzVA==
X-CSE-MsgGUID: SdSNGh4iQniO6y3NkLTGzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98991257"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 05:49:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 05:49:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 05:49:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 05:49:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7J7Kd47WaKq1tEXjOatIT25RnKEuJ/HjExScIu0NSit3z1jj8Ol7A5Mu0/DiuWKMSaOk7gJqMmYBjr0QFkky/9drIyUUvl4z9+P8nMT0pPYiiD7jcjp+ZfwfvAx1qZaXFZwXvXX0u+caeUrudKxvspQJMOZcdBcPfXklnAXwqMnKRxjlWd/fiR0EZvmGmbOOYbyH71plPRxzff4OYOkQb5vtUcFjb4cAiNX1Y+i9SHDdFGFbGp/oqR5yOfRr/cxHHZbIaIzgPj8Hgz8ePvCqdH4ceIsh08U6RlBBWAaEnfZ7rAvnJ1sT9DfcGpMvvK0EMZzbmhv8sPyD26O9IYEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RryhsvOZ/6xaG2OYDf+scspZpQ5+lgJaek0zc/eRWT8=;
 b=edpgzOPvzsw6S2IQXo0+wxezvcslebcRTLeYQAGkZVwZtifEY5bQpKW1tdjdRfTyVhtVVkHqj02EHfQO5P8e4W7OLyB6dYYn60EKA2LWthtj69678IgGHTpUo8O8LY8ktNQlNDOh5okDCzxjlihWhoo1eS3xU+X4hHTtFgOrfpgCSo6Br8OmeWgrr81Qnlxha5NkJ5VvndhojgiE9pk4Hga3u6ca1MdH24uLrk+rHG47shVjinq/6JXoCYW+bPz/lZPVEOaq8XapiZC7tP7bHZ/eP9O3sWxWUVpm4/VpHhHpbeSLNQs0R2mKz8Ct8xn/YAUWT6UIakbnC19QiOXQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Fri, 20 Dec 2024 13:49:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 13:49:06 +0000
Message-ID: <6c788136-514a-429b-8a0c-db37849601a1@intel.com>
Date: Fri, 20 Dec 2024 14:49:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] eth: fbnic: support ring channel set while
 up
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<davem@davemloft.net>
References: <20241220025241.1522781-1-kuba@kernel.org>
 <20241220025241.1522781-11-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241220025241.1522781-11-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0066.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS7PR11MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: d134ab88-08ac-47cf-7751-08dd20fd1259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVJOOTZRalgxZmtHRmlKMkpyMVBESzVYQW1XR3FMc2xjSkVJMXdoeWZiQ2N1?=
 =?utf-8?B?d3Q0WUdSemFxbVI4M1ZJMXZDVmFKNnZlVHMraUZiRTNzN1ZrakRKMVhBMVZ2?=
 =?utf-8?B?RHd1WU9kSlBvcTRNRXk2dW11QlZYcFVHQWd4dlRDL3orZDlPMjRWb2Q4SkJS?=
 =?utf-8?B?SzVFSkg1QVRjVzZHdXhaQ2QxUVJyNEZFNnJGR1VvQ2VoYmYyZTl5U252c3ZN?=
 =?utf-8?B?WGdRVXNBNEZSS1ZXaEhGcW5WSXN6RkpGUFFUU1NZMHZXV2dyWUgxdngvS2Va?=
 =?utf-8?B?MVBpWGFBL29DbWZ6Y0V2cHJ2TVk5anJvZFFUME1oYzN4WWNrL0l1MHYwNTdG?=
 =?utf-8?B?SGxXRGFjdnRVS3FXemVyQU5SUmNPVkFYbTFid3BtVlBvT1o5WTRsUkZ5M1Bv?=
 =?utf-8?B?a0lXSEF4ZmMvcUxrYkQ2Uzk2d1lnRTFraVhiMmtwbUoxZEI2NXVsTUsrQkRC?=
 =?utf-8?B?SXM5Rk5TZHlXa2ZMWmtDRjhKTmJrekFEdW5TOFZaVDZua1VUMDh3VCtuVTJI?=
 =?utf-8?B?QVd5YndGb2hMR3AzNTVTZTRPNFZ0bE1XVXFaUUhOUG5nOGtCa3lKZXJNeDJz?=
 =?utf-8?B?WFNUU2tGQXlUZitpVWtQbUx5OUxzWmJlNUlaWXFEb3A1azZ1MnBJOE9qaEgz?=
 =?utf-8?B?NXJ5eGRxMjRYVTdvSjBUMmg2VjdQU1RQYnRPaW1YSG9FekVnTW1DMWlPMUJZ?=
 =?utf-8?B?ZUJTMzN0YWtQQWhPT3l6cWo2Q3pUVUMrdW5FWWF5Ym5Yck5kZ0g1Y0pzS1U3?=
 =?utf-8?B?bHNhSHFHYU5LcC9ESEMxTkllVmJGN2xvTXBWK1dOVFkzYVlvRjlWYTlrK1pp?=
 =?utf-8?B?aVpMbHhuTlYyN3M5a1k3SmlCWWJBWnpCUGd0QlYxTlh3a2c1TzRyUFovMWt1?=
 =?utf-8?B?TEI1NGZTTktQbmhJVFQ5SDE0RVpuTGZQbXBLamxVdGo0UVhKVEhYYVFnSmNo?=
 =?utf-8?B?M21xdTFBQW5ZazdRRUIxNTF3ZmsycXk3RFVCeW82MDRVQ1o1WUw4OUZLZm41?=
 =?utf-8?B?VDN4QkVKMXNqZ1BvQlVPQWo4RVpwWSs3TzFCTWkzcmFyVEV4dkpuRXFtQmxL?=
 =?utf-8?B?b3kxRGFpMTQyNk1wTjV2SnVzL1kwRHFNWUJYVkRjdEdpdlU0QlJyN2xoRXh1?=
 =?utf-8?B?L3JPTHJIUll1Q0c0dDR6TmlPYVBWZnVTSmg3ak1sNC9CbERDTzc5WUp4NHJP?=
 =?utf-8?B?QzFyY0Y3QVpqRjV1SXVsSXdqNkdqTkRmQjJnZVVSaWQvaFRqak54VlA5OXFz?=
 =?utf-8?B?ZFVUNHdyaGVRM0xoS1J4WEtRM05kUzc5WGFwYVNOWmQ0SkMwbDBmMlpxSjg5?=
 =?utf-8?B?Mmszbm9lRjlEZHhDU3Z0ckFBeUd0cG9HM0RZRkwzMEtVbFZac3NuQWpTb2Jl?=
 =?utf-8?B?SmRFcE9HRi8rS2hVeE45U2VZTU9teXh6UmIzbnRTeEozRkZJT0l0SzMzU20y?=
 =?utf-8?B?RmZERkVXNENmdUtNTmh1S3NDRWVndUFnUGUyaG9pdFRFYytEdjd1b0gzL0Y2?=
 =?utf-8?B?RzBpMHhxaElqRnZLZzdLUEozTnQrQWkrVks3OGZpUHBSUWN2S2FHZE0ycVVI?=
 =?utf-8?B?RnBaYlRTdnhMNWZzbzg3czRobG04SXU0Y2pVeXVmZ09taFRRZlFlK1ZWNTVE?=
 =?utf-8?B?bW5YT0g0MFJxQkZjekpXREVFR0IwU0YwLzVyM1F4N1NKbjNvNkwrT1M4Y0du?=
 =?utf-8?B?RmtDMjFPV3c3OUNTRVJOMU5DdmI4KytZNys3T1B4NElCc3R5WCtEY0hmYnlJ?=
 =?utf-8?B?aHVERlJsditYQldrRGFUc0ZmamFkaU8vWjFaYkd1Y1V4bG96bnpLMnIxL2Ux?=
 =?utf-8?B?eVh6a21sdTROa2FZcEg2amU3MkxjU2hteXhXSS91ZTBxaXpSZ0ZnamhDejIr?=
 =?utf-8?Q?J6wMzxe0crHhc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHcyS2hhSDdWVS9yREU1SDZUMzgxeUZzcStiL1Z4NHQzMm95RmdJRUhhdGhu?=
 =?utf-8?B?SlJaKzQwWmNSVGF5WHNoeUtQc3VyN0tSRzREOWl4cENNL0xpZDJIaTJlZWpx?=
 =?utf-8?B?QURuYk5PVVBLTHVmaXRHVFJjK3Zyd1hhMmRXZllYeFdnb24zQkkzUHVta0Jm?=
 =?utf-8?B?VGV0L1h6YVIxRTBpUnY4Vm4rTFZWanBOVHA5MWdjQzByTmhYclczV0tWaGd1?=
 =?utf-8?B?dklhczByZmhpZWkrUnZoekE0cFh2anB5NE05eWdXRkZwUmJITlNRMHEzYUdN?=
 =?utf-8?B?WmZWV2dMRlVIbXFtaVZIQ2JsaUhGTTJrOGJReUkzazV0WTVJV1F0Z2FybnhI?=
 =?utf-8?B?cmRTWllzWVhkWVhuZC9YaUJJU1FZNkZXN3VCaklQa1NGQkRtZ21jYm1yM2VW?=
 =?utf-8?B?ZSszc3dHQ2xlU3VqY3Jad0lOUGlOd1Rod1VxN2IwTWF3RXlBUDNSdGxIWUNn?=
 =?utf-8?B?cFpNaytvams1WC9qejBucGdMWmExdTBxeXVrMDVmWDROcEJJUzVJWlRzNjBN?=
 =?utf-8?B?dkx3UGdwOTZYejlDek42Nm5aSzV2TVZGUVZFeThMZGlEYzNhVElLNy96emlu?=
 =?utf-8?B?ZXBVa2ozQXJQc3Y2RVZUTkNVM2hRcklydlpCSk5pVEdHL1NXeXVtbGRyS1lw?=
 =?utf-8?B?ZVR4SUFRRCtFUGtRcktKWnVVc3p4ZjB5T2d4NzdLb1YyMWlhMjRKRVpaamx1?=
 =?utf-8?B?MTd5RWE2V2pQOHRBNytsdlBnZGtEOVZVSFZvVGFsZ0JhRGk0L3NNRWtwZVl2?=
 =?utf-8?B?Wi85RFZESE9KUlRURHhHek41cGNnS3E3dXJsRVI2eWZ3d2RVUWhreHBLdCtQ?=
 =?utf-8?B?SXBqcjFsRVFRZG1jZms0clRUQk9XM0Y5ODJ5RXBnTjh0MlZZcnVkSjArMUFo?=
 =?utf-8?B?Rk5iQzNkWHhlbEQyc1d0VDRoRlY1Tjg5RVFRcVlZbEtEbi9la1NkT1lQQ2hk?=
 =?utf-8?B?T2hKdWdHbjk0bnpXT29kWnExQkRTdy9KaVZBWkMxaGNlWXZndGcyVDA0TVpx?=
 =?utf-8?B?ZTJKQVJJMC9SOWo2a2g0VWl6ZHV2dWEwaXcydkxHY3ljdklQclN1ZUZJcUJw?=
 =?utf-8?B?c1VRY3BYQVRpaUViSi9EQitGWnkzQ2VmSHB1dmF3WWRjRXJtWTJ1cEJnN01x?=
 =?utf-8?B?dmlwRDBKMnVVOW9ubHM2aThTN3dPUGlsQjZnamxhZXJQSldtdWY1ZjNGY216?=
 =?utf-8?B?N2VTTlFrMktzaFFLcmdXM3VqTDRvTmo2K3IwejZRaHVCTGFtQ3Ftci9FQjQ4?=
 =?utf-8?B?Z0JuZGcyYktnNGFINFhYcnVyYUlKTThXbXh4VGVwRjZmOStTamh5VkVBbWVV?=
 =?utf-8?B?Ny9Mc2djZnc3NEJtdzIremlmckFaZWpUdW9vMHNRNmUxb2w1aytIMzhsa2s5?=
 =?utf-8?B?eUFMY01OeTl5NkgyMVh5UmxoL21rUkpPMXpSak5LbC9zSWRYa2szYlF2ejFp?=
 =?utf-8?B?Z0FtNlFBWTkzaklNaXJKVHlvNmF0Yy9BVGZBZjMvNGVPVWIzSWx1R08zUXhX?=
 =?utf-8?B?Nzd4TWJxbGlOc3J6SXplVHBoQkMrdWFRblpwZmlGMXBtTEtBazZodVY2bmRn?=
 =?utf-8?B?T24yS0IrMW1Xek96SU1OcFgrSFVXaHlrTVV2b3pzODd1VXAxS2Z0ZXZjclhT?=
 =?utf-8?B?d3ZYakFOODNyN0lpb0VGMDlaRnB3SmtCR2FFb3NXUUUzRll1ZVRLd2RmazNB?=
 =?utf-8?B?cjIyS2s1ZHZ0U2FqMnk0M21PSlY5MjdObHNtVUtIdTh0eDhvWm1EcFc4Wmk2?=
 =?utf-8?B?SUVuS1VUZmx1NHp5UzNta2NZQU56dE1WQno2UTFTbUJiV3BuVU5jVHhlbW9G?=
 =?utf-8?B?TVc1ZWxpbGZWTU5JUTFzZVRwc3pyTGorRi8zSHplQVpZWGJZSFNDaFVJblNz?=
 =?utf-8?B?U1IxR3hOVm1yUWpHUFlPYmllU2FnaDlyeFhtRElXM3MzSW1ObzFQVTVFajRr?=
 =?utf-8?B?SmthamlYQ2V6Q1h3c21ZVTBERHNnYU9qRlNMeVRLL3BYUXJPYmxKWCs0Zmoy?=
 =?utf-8?B?Sy96bC80ZTdqVEplY2hoNzZHNEduRisybkN5RFBKZGlSOE9sWnpzWERjaXpO?=
 =?utf-8?B?b2pFVmxUU1VjT2VPdFo3Tm5saG5OQ2Y0WW8xSklCWUFjM2lCMW83VS9yVzR0?=
 =?utf-8?B?SXVwU0VvUjkwZFl2WnUrcGFoVFMvS2NzMXZsVkpTcHBJR1lZTWp6ZW9EQlRO?=
 =?utf-8?Q?QgFdG25oFkwAPJKtgJwnI1w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d134ab88-08ac-47cf-7751-08dd20fd1259
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 13:49:06.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUcFU1Yw/LoKptEGo8JnZh6yoAq1sQuXiMZ/GJA5rzGmWThZlyK5N9h6qHUXFKOdUwfiPw+oVDXjgeLXLBUKXwGoqpZADVTaXw3uGRc1oJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176
X-OriginatorOrg: intel.com

On 12/20/24 03:52, Jakub Kicinski wrote:
> Implement the channel count changes. Copy the netdev priv,
> allocate new channels using it. Stop, swap, start.
> Then free the copy of the priv along with the channels it
> holds, which are now the channels that used to be on the
> real priv.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
>   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 121 +++++++++++++++++-
>   drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  11 ++
>   .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   1 +
>   drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +-
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |   8 +-
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   5 +
>   7 files changed, 143 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

very nice, refreshing and inspirational design

> +static struct fbnic_net *fbnic_clone_create(struct fbnic_net *orig)
> +{
> +	struct fbnic_net *clone;
> +
> +	clone = kmemdup(orig, sizeof(*orig), GFP_KERNEL);
> +	if (!clone)
> +		return NULL;
> +
> +	memset(clone->tx, 0, sizeof(clone->tx));
> +	memset(clone->rx, 0, sizeof(clone->rx));
> +	memset(clone->napi, 0, sizeof(clone->napi));
> +	return clone;
> +}
> +
> +static void fbnic_clone_swap_cfg(struct fbnic_net *orig,
> +				 struct fbnic_net *clone)
> +{
> +	swap(clone->rcq_size, orig->rcq_size);
> +	swap(clone->hpq_size, orig->hpq_size);
> +	swap(clone->ppq_size, orig->ppq_size);
> +	swap(clone->txq_size, orig->txq_size);
> +	swap(clone->num_rx_queues, orig->num_rx_queues);
> +	swap(clone->num_tx_queues, orig->num_tx_queues);
> +	swap(clone->num_napi, orig->num_napi);
> +}


> +static void fbnic_clone_swap(struct fbnic_net *orig,
> +			     struct fbnic_net *clone)
> +{
> +	struct fbnic_dev *fbd = orig->fbd;
> +	unsigned int i;
> +
> +	for (i = 0; i < max(clone->num_napi, orig->num_napi); i++)
> +		fbnic_synchronize_irq(fbd, FBNIC_NON_NAPI_VECTORS + i);
> +	for (i = 0; i < orig->num_napi; i++)
> +		fbnic_aggregate_vector_counters(orig, orig->napi[i]);
> +
> +	fbnic_clone_swap_cfg(orig, clone);
> +
> +	for (i = 0; i < ARRAY_SIZE(orig->napi); i++)
> +		swap(clone->napi[i], orig->napi[i]);
> +	for (i = 0; i < ARRAY_SIZE(orig->tx); i++)
> +		swap(clone->tx[i], orig->tx[i]);
> +	for (i = 0; i < ARRAY_SIZE(orig->rx); i++)
> +		swap(clone->rx[i], orig->rx[i]);

I would perhaps move the above 6 lines to fbnic_clone_swap_cfg()

> +}
> +

