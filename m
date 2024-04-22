Return-Path: <netdev+bounces-90300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A68AD92D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 01:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E23D281DC5
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 23:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC64594A;
	Mon, 22 Apr 2024 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeKWqPbk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134A45034
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828397; cv=fail; b=IBDwQ4OLuajb+Md4Boy08cUEg3AwLLjixMhgZJ4HCjPj8VkGb+mtp78OnbUrXMi1vyelLbIRblVSmJL0usQ9q8Xja38IfxujnH/sSTk1FXPrZh2wiXKvcU6iMW2EUrw548rDiyxgbtoQxHbb3qmj2/vdAmsIgFvmEL5f/dWEQ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828397; c=relaxed/simple;
	bh=25gKyy1no9DBDZ+enquX1BCH8TTVxTeNxeydpzcBBw4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S3EzV25XRTto6dqgXSkRZYumerHny5Bbax1qBn76JpuNR92bmauwU7E3zhYGAicaDcitDV62Rr8clOiSq8H6nrFy7E+6pqJlfEl+Ljn6ZYd9NiBQaSx8rwrsZS2RLQQkaHmbTCE7x1zIpKec8ehOj+8FEt7/Xa1ky3D7oLNrVTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeKWqPbk; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713828392; x=1745364392;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=25gKyy1no9DBDZ+enquX1BCH8TTVxTeNxeydpzcBBw4=;
  b=YeKWqPbkjq+LVt81T3nnoNduMwkFcPIRzlB2dCx1MvupaBVsKmZtxUkN
   yi8w+RmzBZnkU3wQvtQXViqGdYzQnPPkJ57uBxKL0PHDdgZihU3DBXt8j
   /XruCkpWLiQd7xwubkxkRPJikYVHKODfMso+xli1smIK8pylej2b8uw2J
   /oNtqyjciw4AvdJMpE+X2GBSVeO5Iab55FBfiasw1UFGSg+9gjgSx3x3U
   goRkeriieEmp23ckQ4InGxUVXwjs5ZYJiOqc1V4qhsv0EU/zCMnk7Gja9
   BPf1a0FR8sMzywPXfFtzOhytZCUXc6TIm7t7TnZ/23iJMrySPdKN8zC5O
   w==;
X-CSE-ConnectionGUID: FTkfTKoRSUm9mq45P4dt+w==
X-CSE-MsgGUID: eK95HAOfSrqhxo4t9H/zlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9267879"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9267879"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:26:31 -0700
X-CSE-ConnectionGUID: hA4PynhtSEmyehvvjPDG1A==
X-CSE-MsgGUID: uPqIOAbPTKyWbFOA2f/w4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24675882"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:26:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:26:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:26:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:26:29 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:26:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOIyNT0AxSYVyWLw+0kdNYeCymx8QZlobPe9insRlqDn3T8jlhC/VzzRr6N8SrcqsXbUkwpxtuG43y1FcW64sk0l0gfLcPTRzvfIll/Umc4R25vqzI+P29jzFeN5+ehPV6/AaGOU+2VBPZ8OcIGXTXsbazLqcIos2pFNTF0qygSPldQBqx1H7d6z/O+6RfVs+6n/YbLkECrm/TApp8uWASbb2y6p/00vdJuV+oPgTK9ft3R9M83KWVyznP/4F70Ill6yTYXTUyUhkE37YrLx0rCW82HEnJhVcHacBJ0A4QusU2le/6wYebzlInQysH46XONVWJFyX6OrJXEN8yyOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8b58Z3emNlhNjK9fMw8phmezzMS8sIFJYF4lZMSRFo=;
 b=nxDr9WkDjV4EcUO8AZVZs5VlR3jMo3lcIDDcwjhycd9e4HE6PQOpujOkVYloCPaJbSpjdoj3tgEqKRrVHT0zzWMXV55tBSIRw/eWebjqDsRggP/LXvr84IA9hEG5HKFk+IY/wrx/kxRI9wyjJd6Zgk0iLQIKNbOrprxyOVul1j+OvVDUHVDNSyP8y9x9R++t3AeB93/A4/ICIoJPgHzxkvnfthRF1S4n7RF02KLdNafb+ajgMOX46sCsKKgTl/APO2VSQ2Eau8Nht2zD2Ixovolv5I00YFHS+4+3KBuCnRm78YSWl4bocvEIyDyRjqFeTDnLh3f/GKebzEDe6AJ8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6613.namprd11.prod.outlook.com (2603:10b6:806:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 23:26:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 23:26:22 +0000
Message-ID: <dc1d4f7b-09ed-4194-9a52-c0c679fdc7ef@intel.com>
Date: Mon, 22 Apr 2024 16:26:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] Revert "net: txgbe: fix i2c dev name cannot match
 clkdev"
To: Duanqiang Wen <duanqiangwen@net-swift.com>, <netdev@vger.kernel.org>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maciej.fijalkowski@intel.com>, <andrew@lunn.ch>
References: <20240422084109.3201-1-duanqiangwen@net-swift.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240422084109.3201-1-duanqiangwen@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d79bc57-8748-4dff-f33a-08dc63239ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE9HRHJSbE5DUzhnTHY3OElFYnUrUjd0MkZwRkQvR2xua1hXL2pWSVdRZnRu?=
 =?utf-8?B?L3ZJczI4d294Qm82QWh4ZU11dzBBSlNEc2NONXE5YlVKTytLUzM4YTlQbFdm?=
 =?utf-8?B?RDVReDVhdEQrMmZFQ0s4MXhTR04wangzSFVQWnR4Q09iOUp2UStVOGVVUFc3?=
 =?utf-8?B?RlBDY3ZxdmJQcHBIQ3FYcHZZSHlreUlkOUdvTU9iZEhjZmZ2SEtidklsejZz?=
 =?utf-8?B?Z0phOXZnN0FFcTNnM2U2VnYxNllqU0g0NVMvTFowWHBYRkhWNUhkb0VpNm1Q?=
 =?utf-8?B?dTZpWDlIS2w1N1dtalVrcWZmMkV6cHBCY3U0SVRRcEJuYW1xRTNCS21yZnBl?=
 =?utf-8?B?YWw2bGVwWFlGZ0pTWGZFMGR5QVdxNjh3NGNiTUIvSGM4aVlMY29CZ3ZaSjYz?=
 =?utf-8?B?STNUN0tNdnYvdksrczVycU1hUmc2Y0s1UUw4Z3QyaUxRWlR1aHh6TklqS3JF?=
 =?utf-8?B?dlltbXRlaFN6clhSQ3I4RjZEazhVSkpiUW03aWZiVWFlY09jR3c1bVJDNVRT?=
 =?utf-8?B?eGhkK2lKazhoWTByN2VBdVlidUlNaGE3MVZXajk0cEtUbDZZdytoMnFJUE5T?=
 =?utf-8?B?aHNaOWlMSXZxaVloVDcvRVVveFpZODRJTkpIUWZGYXNZbDF5SEQwcEgvYkhV?=
 =?utf-8?B?NkgrNUUzL3ZkbDlRT09CU3BJMUZYT2ZJK29qa2NSVjVNUDRWMG5oS3dzb1VU?=
 =?utf-8?B?cTBkZFR3YnJSRjE2SVZSdThqRDRnTGF3VG9xRjNsbDU3VldTSWtiVXRTcTZp?=
 =?utf-8?B?QUg5MytLM0xHOVdRQ1hXUnBWSzM0SzdEaEpTUWo2bDBlSUExa2loVC91OVRs?=
 =?utf-8?B?Nm9ZZzFycmxyNVAyK1lyRkZSRU0zclhCcUkzcmhSL3M2ZlNJOVd0cnpRU3E4?=
 =?utf-8?B?c3VwejVTYVI2UDlscTZSWnVrZW5yUGRqOWpIZ29RM1lSamtlaENjT0w0STZ4?=
 =?utf-8?B?bG5DOGcxaGVUdFZOa1VzZ1hxSVc4U0ZadWRuSEFwZXVvNTVyUjVMWGZvRjZt?=
 =?utf-8?B?T1VyQ1V4cGlWRUltRUpNS1lJK3ZqVjBxZFFmU1dWVnZSREs3UThjcW1aOHdE?=
 =?utf-8?B?SnMxdXdvMW9GcVBpRmEwd0dwQkhHa0VlY0FlZ0xkajlsVTZ6WmVENml6UG9h?=
 =?utf-8?B?TEY5RG83VlhhY09vZHJiaXVhOVJTK09yWWg2aGFiOEZhNU1Ld2g5MlEvRm1I?=
 =?utf-8?B?MXh4Y2V2VUpLMEVpdmtCTk9RemtBeEJzNExLRXNaZWNMRDhvOU5mSjk1dFRi?=
 =?utf-8?B?bEkvNEpXNTFIYVIwTmhqam4zcGQvS0tMNkVhd21semM2eHhSQWp4cDZoTVBX?=
 =?utf-8?B?UksxQll1Y1kvRmlvVHBqWnhZOUtwdnBPZmhud21pSGdJd3FuSVJRbml2YzZL?=
 =?utf-8?B?NUtzZW4wUk82SVlIZC90R0wyL0JzTkliVXhEa2xMdGFDbFdSdlVhUFhZN1Nm?=
 =?utf-8?B?TVd5Nk1ZQjNMTGMreVJZWXNHMkQ0b2NzQnJZdHdHNEF3bkU5aVdhWmd4c29Y?=
 =?utf-8?B?YXgyM01MMXZxNE9RYm1SWEhzaVhJQUVUZzVOSEpUSldYZXBYUyswbHJCdU1X?=
 =?utf-8?B?ZE1oVVoyZHZuRVEwL1oyMjlIYkNXNnJ2eDRNcGxZNEVPNjg0S0c0OEQrVUN0?=
 =?utf-8?B?dWRuMzd0cmRNUytmWWtFSktaZXBJTm1ic0trYUk3MS83UmRlb1ZTcnZzRXBI?=
 =?utf-8?B?ZFIrcVVCYTZJVFhSSEZMVm0wVTJicm5leDF2T0xWMUVRSEI0WEJaaEJacmRH?=
 =?utf-8?Q?FMSuBdCpIJOWHLJ7U47Bv7AwkpgNWq/gCwM8YEO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmMydTZJMVFZOHZuOE8zbmtoa0ZGUnd2cU5XUkE3cVR0ZWZGYjRLa21idkgx?=
 =?utf-8?B?a1BZUG53NFA0OGFtSmp4OTZFbGY5UkltSkRiYVRLVnFmdHBXUWE3NnpmZ0h0?=
 =?utf-8?B?MUFJRWcvcVhRSXdBUDNNTDc2L29PM3NKRnRDWVZzTlJMSlNtZG81NWRiL2hB?=
 =?utf-8?B?UDIvMkRlZ3lmSGZhbHpzYkU1aFhnZ3c1Sm9xQ2pDVVVDd1ZrRzVJSXJBMFJI?=
 =?utf-8?B?L0tzclBQRGhqVjIrRUViODY0OFg0R0U2QWk1dlA0YmNxSFBjOWF2R2liYlpR?=
 =?utf-8?B?REUxdTM4djJ1QWE0bmRSeGFTV0g3d084VHVQZEE4VlNTOHdrWE1HTG1LeUc4?=
 =?utf-8?B?WFVpRnR2TW5EcmZWTUpFU0RlTk1SME43Q3YzV1BWeVhtNEtaNFNpVWtscVlx?=
 =?utf-8?B?YVpQaGFKSXR1b1NOb1EvRDZ3Rks1M21aNGJIMDdPd1paTURFdGNOMUNvQlhM?=
 =?utf-8?B?MC9nbjFaYXpyTDl5NjhqSE9ZcjVoTGJwOTRZZzVwd0IyeTRDMUVEdDAvajNh?=
 =?utf-8?B?MTN3K0JxVlpaNlBXTUJ6MUZzTENlZlhqMVZodzFOa3M1RFQzUnRkNWVEVm1I?=
 =?utf-8?B?WnlydXQvVDJuQUtKellzZUtIRjVxU1F5ZmtrMWJNaFZxSG0rcHV2TFBxcHhp?=
 =?utf-8?B?MTBHNlBERlQ0cmdpNmY4dWQ0Y1J0ZjlZRGFESFFqWmJMZ2YzT2Z6bUVnSnZk?=
 =?utf-8?B?MFluSEFIbWtzN1FUWEg0N0VGWXFORnJKQ3ZMelowbE43bTRvTEg5NUVQeG5j?=
 =?utf-8?B?MmNWNjluZzdmcHVycjdFeCtPQUtVSnhMUk1pT1hBb0RYdDh2VS9TYjlxRGNV?=
 =?utf-8?B?ZEdlY2pnOG5yZ0l6OHRZYlZZUUZsbHJlRUU1bUFEaTRNRE9ONi90VEFmVDNa?=
 =?utf-8?B?V2RVUzgvdGFmdkYySVRmTEM4blc3TktVdzJVb05ZaDlVdEs4cnpmSGxWeCsw?=
 =?utf-8?B?MXFEaU9IS0cyU1kzOEkwbGtwMlZPblFZeklBdUd4QWJZM1lyd3VwZTMxeHJJ?=
 =?utf-8?B?QzBuU3hMY0ptbisrdzk1dDR0blJEdUpHSnJBT2x1U2EyV05oNVRyNzRQdzNT?=
 =?utf-8?B?TGp0M2s5ODF0TGRrb2N6UjdvYTl3M3ZhQitBSkJZSmgwRmUwKzVQZDAzR09t?=
 =?utf-8?B?OGVkaWJBUnpDQXJrK0I1VmQyYVNPTTAxcE1DeTZqdlJWdWRtVGduNXBLMzZL?=
 =?utf-8?B?UFR5WDlzc0NBeWNpZ0JGaGVQVnBRRzRXZzRPNThSWlNiL2t6Mlh5dmhDemgr?=
 =?utf-8?B?aUxKZ2hKM1dIOGNPV3hYeVkrK1RtaVYyNXU1d2hqUTczMmRUaWpURmtkTXJm?=
 =?utf-8?B?c3VFbUplOHFqSkRIUFo2WWVSeE9La2R5VWdUWWNYUzJpOFF3ZjdOVXc1UUh4?=
 =?utf-8?B?TTMraURjMzQrTS9TWHl4SmxpbTZyN0Mzb1VXTmEyKzB6WHlvald1TGdDeFNY?=
 =?utf-8?B?N25tZVJvOGhGMmUrWVc0bzBCVm5tMkZQaWVLSUFJNGpSekQ3cmFldXduV3E4?=
 =?utf-8?B?MktaRnYwVE10RkF4VzhlNHM1NWFiZTBJeTJBSEZaUUZSQjA0Z25IdDZrdTZW?=
 =?utf-8?B?b1o1SjFZSzVxSmE1MWJmS0NRdHEzMm1NYVJ4QWZQLzJQaWJZUmFmb3JlRm5H?=
 =?utf-8?B?L2RpcDY5ZjlVY2hyRXNKUFFXM0tlVkVoKzdpR0tGdHhZanF2WEM3dUhQOUQ3?=
 =?utf-8?B?dEVZL09pR2ZqalJYUStNZlVNSUV2M2ttaTM2a3hTeFA2SHZNb1hpMWRPTzJS?=
 =?utf-8?B?ZFlsWDkzdStHcDVLTlpjUWs0dzNIckNJdUdPQWIwTFlpWFg3ektySjVkOW9Y?=
 =?utf-8?B?NFNhdHFUcG1vNjlENG5rRjFPUm9HYUVrc1JMNC8zYVpjdGZrUE9mMHM3QndM?=
 =?utf-8?B?YVhXY3g2RmlteUhDWi9YTjhWRXpOQXFreVlxcGp0N1dvRS82TW5jTzgyTGNi?=
 =?utf-8?B?NFZCS0dyc3B1T0dMQmpBU2liNkVMTktWU3ZEd0dJTmtKdFNuVGFzZ3QxaHl1?=
 =?utf-8?B?K1VtYUhCMXYwZTk1NHRFSEFrOGs2czcwNkNlYUJOenRVTmJOaGV2UUgvTEVM?=
 =?utf-8?B?OCswaE1ZajJWR2tpYm0xak53RUNjNkY2MFg5NSsvYnA0SFJnNG1JUTlVdWJX?=
 =?utf-8?B?Y2ZhL1N5dExGUnkrNXArVEJGbEFPMUFMcUh6OGpFV0paSDFtbTRNdE43cU9Q?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d79bc57-8748-4dff-f33a-08dc63239ed9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:26:22.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cn9GobHYeAwQf+ObzLu4ZWc7XzfWeBqLrM4Yl2DZ0yUbpEqD+qu/6CiE5FW+w2PQcJffLLOAUpyZfbKbljQh2bUy3/OW4+LP3gza3tct/dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6613
X-OriginatorOrg: intel.com



On 4/22/2024 1:41 AM, Duanqiang Wen wrote:
> This reverts commit c644920ce9220d83e070f575a4df711741c07f07.
> when register i2c dev, txgbe shorten "i2c_designware" to "i2c_dw",
> will cause this i2c dev can't match platfom driver i2c_designware_platform.
> 

Makes sense. This name is used in other places so keeping the original
name is important.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index 2fa511227eac..5b5d5e4310d1 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -20,8 +20,6 @@
>  #include "txgbe_phy.h"
>  #include "txgbe_hw.h"
>  
> -#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
> -
>  static int txgbe_swnodes_register(struct txgbe *txgbe)
>  {
>  	struct txgbe_nodes *nodes = &txgbe->nodes;
> @@ -573,8 +571,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
>  	char clk_name[32];
>  	struct clk *clk;
>  
> -	snprintf(clk_name, sizeof(clk_name), "%s.%d",
> -		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
> +	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
> +		 pci_dev_id(pdev));
>  
>  	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
>  	if (IS_ERR(clk))
> @@ -636,7 +634,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
>  
>  	info.parent = &pdev->dev;
>  	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
> -	info.name = TXGBE_I2C_CLK_DEV_NAME;
> +	info.name = "i2c_designware";
>  	info.id = pci_dev_id(pdev);
>  
>  	info.res = &DEFINE_RES_IRQ(pdev->irq);

