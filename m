Return-Path: <netdev+bounces-132273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51F991260
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066EDB2216F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE21AE018;
	Fri,  4 Oct 2024 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpCSkg0N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D6D14883B
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081455; cv=fail; b=fdYDx74iJ2CtQh5eq5ylaoiLVo1DrNrGhmJdks7DIvfpSoTrMZK9V83oE5oeLgQWWILEOPTMe+Qf1xnHIQMCBk0TGwoTJF2xgxWwSR3A3eEDk4RahUZr8EHWAdRKqDV9tWLsvbaT3YbzxEf0DTOf++4Nl9DMOtokUu3ZKoo3P0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081455; c=relaxed/simple;
	bh=eDyqnbpP4svhtAtc8c48q4qLzph3JW5bnBNka8VWqIE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GPBG0rJ1uAy0pYMN71InogaK2rTSefXAKptVmssJHVzGsoQicvW1+w9ASoUgVGDfcCfmHwb3aLHVQCHVw7TpADqDncuoYYHFzxEeRxuBAMZTKiVFk0GxpZW1kZziUlcxJ4bRdXpX9qbDzGS4c0EGxzrTpjFnMUzdD13R0b9Kyuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpCSkg0N; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728081454; x=1759617454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eDyqnbpP4svhtAtc8c48q4qLzph3JW5bnBNka8VWqIE=;
  b=PpCSkg0NMuQ7IjeMUQKWJ4bNrltl195oo18hR5C24pFSkxyBPEc07Qzw
   d5bFrnZ/oVgR1GXONOdO/eWylNybFWujTnq9FndWr/EwSsSuqYUoJIjTd
   HO41zyN3ZMgkBnkVJ8oCbb+TTv+aETGlMJ/HJWyEudT0Xg7ANuz68LJV0
   SxNXuZSqXl5pgwX+KIwpcwd/JzWHA+gMXOAjQ0eVkWrLuVpbykCSXCUst
   oS/6zcs1JMFUxKC9mVBKwtkozGkPmQuiYrRO3rQimFruM3xcwume8gg8w
   8joaLHDs+vrsVy214ysFd3T2tr90d4w9zk2rnBhwlYit4uYvSGxBSfELs
   A==;
X-CSE-ConnectionGUID: u9ISeExvRl6VEBp2LEdQhA==
X-CSE-MsgGUID: 53V0jON1TxCPITGCXZibXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="14938310"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="14938310"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:37:31 -0700
X-CSE-ConnectionGUID: M0s5w2izTReSd3St1DNtfg==
X-CSE-MsgGUID: B9T2tQg/Q5K8P4TRi4UKZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74428776"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:37:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:37:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:37:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:37:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:37:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuX7WXOdZHhq+CdOtyy3lEj+9Y10TPdFU/1mFXTeUIdhBpc0+SxHR59shPs+unaYb7hCcd/z/Ili0106C85WRNLrMx6XhzQ/h/GLgSBsC+CVZpB2PfjgkNSy5r5JNF8tBf913pgnqZd7LeBh+Y1noDS50HNXnN2mJRjgetEC6taJweIeB8DsQI9m8/+CTY/+/5fPUlcZ8vHE/g0nXaIzf8vZkP93JaaStvCMnGHCxBvPt5IAofwHk+xHyewE/nhDOb/IK0/OFKeZQ+YEmnOiFQZL5LYvU+s65i12zQSbtUruU6AIponf5lUMbxVfiOFEi6xENoafhY389WmEYFuZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXrLXz1IEEQqitDQgmJ8pCt7CIFRIBShCqnopkao+GE=;
 b=cGBxgvvLhk1jFGtd61CUfg11C6KFw2K+RoGnhEjK+b5xSWbxKAuQTObnEEu/r1tIeitm+F5m0fdixSjJkfMmOzsGJgusLlBjcVnXjOOz8Ifh32JwZPH19F0YVNcirJFyz4MS81o11b840movEM2ed/pA7Ybu3fjCwMX8FFsXgwX8p1g/48D+fhRc5snznNvVV1LjVi7rn79RKE4p8HQ+linwj6+Nv53aLUjQHpaaTE/UlEHoVBdfrto8ZgA3le1LO0dgahz4EgDSBXRAdDLPPialJWCITA2Vri1Uh1vfupeeuIbaJKOqWg4QIFnJOGZREuTXtg+BYnUFsvKNThxRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 22:37:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:37:19 +0000
Message-ID: <568e83fb-ba49-4998-9245-7353ae2cb563@intel.com>
Date: Fri, 4 Oct 2024 15:37:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 0/7] sfc: per-queue stats
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
References: <cover.1727703521.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <cover.1727703521.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::36) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: b78247ac-d30b-48e2-25aa-08dce4c51b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUlncHY1bXRjVGVnM08rZnRWM21ndFFQdUhPNjdZZ3lBNUw2N2NTQjFaY0RT?=
 =?utf-8?B?aHVoUHhBQlVjWGhKMlF4OXdQckZuNkg5eEV6dFo2ZFdUQXFKenhHZXF1YTBR?=
 =?utf-8?B?cStZOUlOZ21Uelh4eHFwNVRVMWUvdGJGbjVMUTJNbDdaSDJObW9hUmdDWHN6?=
 =?utf-8?B?Y0RHWHdaRVF3cUhoQzRhMlBpVWROb0d4bWgvMFhQd0h6TWY2ZFVFRTJHOE1h?=
 =?utf-8?B?azVYeUY3ajdjdjdUYUlvSVp0Ynl2aCs5K1RjQUNXeE85a280WGFFL2RWK29E?=
 =?utf-8?B?M3Z2eEVaMXEwcVlZMFFlZlZJK2tXZENDTVltU2RFWHIvUFM2cEtzeGxxQ0JR?=
 =?utf-8?B?MGJXK1B1ZHVSRTVzZ0E1blQxbWd0VHNpYktNbkJWUGZzbWVxSHcwOWpwME5G?=
 =?utf-8?B?Wk1lMEpLVDdTVmJscjVEMHFtUWVNQW5qOXJjWlJiWVhsQ0xISUYzdDJXd0dO?=
 =?utf-8?B?TzZwR3Y4TDJvUktmaitQa2xHODRmQlJ6eGxkRlR6cHVpTFVuTkRkWGFRNEk3?=
 =?utf-8?B?Z1FWbnUwVFlPdkM0TjV5S1B6aDZWbzJaR1ZacDhFMFdXNGY0eXVLV2NRLzF0?=
 =?utf-8?B?Mk1IeWFxcHBZcDdRSkZFSm1OQ2J3Y0daaWVVSjFZRW8wN0hNNTJ0aUNMb2lN?=
 =?utf-8?B?OWZXV0hvWUpMaWVIakJzNmZib1N5b2IvbC9leUVYb25CWE5GdVZpZ3Z6dXlY?=
 =?utf-8?B?TEJTL2Vjd1JyNWRYc25BTnRpY1AzazdnbWUrV2JYT0xDZmN2a0hIdkdrN3c5?=
 =?utf-8?B?YjFwR1Z5bFJCQzBkNWd0bjFJVjZVL3RpcDZWeHlCeFBraXBGWVpNMmlqRXZo?=
 =?utf-8?B?K1lNV2RpM1lQeGc0QjFTYXZWQ0tNTHk4ZGtMVXB5QVNTRWFHRVRpcUI2Rll0?=
 =?utf-8?B?dnNuMU9CMTY2RVl2Uk9JMlZQK1lSVmlZdUFTQ0NlWnRkODhmVEpodTh4a0E2?=
 =?utf-8?B?bzBocWVIYW5UQkRzTnBrY0YzNEhGT0l1eWRWWWdxYU9DSmhZdlJPZWp4V2kw?=
 =?utf-8?B?aGV0clc1eGh0T25ROTA0emZubDNwUGt4V1dSdGd1TTJnTUxFYTI3aUg1bVpP?=
 =?utf-8?B?emJQSmQ0c3lHMVUvV2NrRC9VZXduWGkwOE1TZ200UmprMm55OVR0U3FIdDNi?=
 =?utf-8?B?YjdaL1NIMjhndnptb0VyN2ZncjVKamZXSnZEaGpvYmJJQ1pWemd0NFNEYlVG?=
 =?utf-8?B?aTBqQk1IYU1nY1JoR0NRSHd3Q0JuZ1VPRGZTenV3ZkJUUUlOeEFJK1U1NWMy?=
 =?utf-8?B?THRxN3JhVHhEb2N5YUp1Sk1WdTQvSGFkSFovVVMxeGRvUk9hZ3NTR212KzJK?=
 =?utf-8?B?KzEzZ0wzQy9teE1xa0Z6VThvUkVhSWE5Z1pGYUdCZWh4eTZpM0loeDFHVThU?=
 =?utf-8?B?b2V4bk0vWmVLMEdOM1VoRFY1cEJDV1hyT2c2dW1oNTdvdWE4TXhpZjM5b2R3?=
 =?utf-8?B?RVNjd05LT1RZY2tmdklpc0Q4azdaRmVPa0p2bUMvMEdPb2hxNWd5c3d4L1V5?=
 =?utf-8?B?Y0Y1ZEt3SmtKa1dFaURianpDYk9oS3pEWm0vM2xtMlkwaFF5ckhmMUhDV2Rp?=
 =?utf-8?B?bnJMeXVRQXpTWTk5eUNSa2t3UytQMUl6aUlpVk03bUdaZjU0dHI2MHZ5ajNx?=
 =?utf-8?B?US9HZ21MSEhZQUMvTHFrU1Y2TVhOaE0vZnZuSUZXK3VhQmtvTWhIUXlHTlN5?=
 =?utf-8?B?dXlveVZTRmtIc25od0VzMVlFOEIxT1pESjdQOU9WbzI0ODVQQzZxZnVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0wyTjYxeU45M2xhOExaSWtBQlRNbzZDMEkvVmdaRWtleW5jM21GR09BMFJK?=
 =?utf-8?B?ZGNySDdqNHhIbUMzUy9haUh3c0xtWDZ6dyt1UGZPYjQ2bE5PNmRCNW5zSG1T?=
 =?utf-8?B?T1NtMHVwUGRLZERUZCs3UjFzS2hoZGdVU1kxKzY3dlM3aXh0NnEyVVBKdFgv?=
 =?utf-8?B?dGJCQWhUcTkvMGp1d0N4Z20xakZxb0VYbG5nbHlUT3hXclJRSThuRUZ4dVJ5?=
 =?utf-8?B?QlQzRmhHUUJLRlVVNWdPaFVLdWpJOWJLdzRobGduTFZ5NkRiNGRmK1ZqdkIy?=
 =?utf-8?B?bFBodXBaK1BJRUhMV05zTjJzZWI4T3VDQmlyOXN0VHkzODVBS1gzMENKa3pR?=
 =?utf-8?B?NHg2ajRTQzBuZWVJK0tzSHozTUZVNTlEZ0pNdmxDc0JGUGtuekc4WjZVWDZ6?=
 =?utf-8?B?ek9QNlZxZmZTNzlsQXF3cEQ4bG1LSXVWa09mVXNEdlVubUpTeXAyQmhIbEVE?=
 =?utf-8?B?ajFkWE0ybTdjL1ovWU1XRm9GOHQ0NEdud0x6RkZhVE51YVVDZTM0REs1UzlN?=
 =?utf-8?B?TE8vdzlRWWRuMGo4WTV0d3BWVE9Kc3JWK0JHZGZiWWhYai9aL1BSb041YjJv?=
 =?utf-8?B?eVdEWW9XL1QxQXcxTnJBRkUrQVFJaStyWkpZaWo5dUdVL3dxZWJ3a0VuTGVN?=
 =?utf-8?B?dWM4V1BaWG5CT2VHNTZSYmttd3ZMc2hmRWRKR0ZiK3ZCRm9kYXFoZ2VmbDRV?=
 =?utf-8?B?emlqSUg2SWZTMWVrVVVVbkRRTDU2dFVHSVM4VlhZRmNoS2FRY3BUTHBIbTJT?=
 =?utf-8?B?ajhJSllRYWlLQ2JoRmV2Ung3UlBQOTYrZjdGUkNnZit5eFR5QVJJMmVKWS9s?=
 =?utf-8?B?SUNkbngwSjUraEJRc3lqd3hQOXNCek04MDlPdHljOEVxeDVvZzNoYnM0M2da?=
 =?utf-8?B?UjBVaTlETWNtWGNob2o3L21Ld1laL3Q5dkRKcGpWMzJHTmpEQlB4Y1NONGdk?=
 =?utf-8?B?WUh2L2w4Tk5vc1U4TzJWTlpmOXU3NS81d3pGR1A1bkgvQWJTYzB3aXhiNTMw?=
 =?utf-8?B?RUMyVEswR3lza2d2VU9WOUxyVm8wY0pDY21lbWpaU0tsTnV2QWM3NGZJYmta?=
 =?utf-8?B?T0dFMXBSWG5lV0lCMnNDbzFnSXArY1VoeERESWJhUVN0TlhJK0QraGE2cDNM?=
 =?utf-8?B?YzJCS082TWV3Y2o1bHM2U3JtdFNRWTlEWkJlRkJHRmxUTHNpdk9BVGlSK1FV?=
 =?utf-8?B?djJwTHI3cjdNb01uWnBQT1d3NjZ6Z0pRcnlPQnFRL3JSSTZTeW40bVdIa01Y?=
 =?utf-8?B?eGZzNk95OE5yOHBUOUJBK2tUdURpaEpyY2prdGhzMGdtSEIwN2w0cGFUSU93?=
 =?utf-8?B?QVlGT3lMTlJPVnVBdXhLdkZqREtqL05tNk11Z2pwRUhiZlhxMDNRZjdOUDVL?=
 =?utf-8?B?bmZCQ0s4NG9MQ3dXeXRFZTJqNjYxT3pUSE5aUU1lOVJaYlQ2VkRJaTQ2MExz?=
 =?utf-8?B?cW9xaGtHWkRzbmh4dGRidWhJSTY0QzAxQmFFb2l3VWtqWWdMT3FQbm5mSjFT?=
 =?utf-8?B?R3pUZU1WejNPZlpmMTduWEdib3U4blJoaURDMEx1SlY1NlloZEZ3Nk5HUnZx?=
 =?utf-8?B?ZGtpanlvUFlYSysyT2lOenBWbG9HbHBETGp3SzNLMFAxaDZCOUZpdWtUcmtz?=
 =?utf-8?B?OEhLWUFzaE9UYU5WSXo4dERTRDRwSFQzaVQ5U3crSmV3d1ZzYzBWaXF1cnFT?=
 =?utf-8?B?em5ULzFZVURMWFFFLzYvN0xIK2NJZjRDOHhLai8yYVVESkpQV0RaWno5Y2ln?=
 =?utf-8?B?UVlJQ21DSW5FN2ppY1ZZWDMrNmlENGY5Y0FNMU9XZ2hGWjR3d3pKZExsWXZS?=
 =?utf-8?B?STA3eUx2b2swRDM1aW4vOFNkQ2RMMnhxSjJyaDFFZWxKemNkR1dXa05ucmJ4?=
 =?utf-8?B?aHVySHVQeTJBVElvcExaYlF1bFFuM1V6c0Y1eHFUT3ZLa0E1aGpVd1hZb1Mw?=
 =?utf-8?B?ZEVOYWplaS84QzJFUE1pWlFnczZnNVpwT25OQkRwTVJ3VFBmTklNbFlDYyt1?=
 =?utf-8?B?cHVsNVpreWVySkgrbk01dXV5ZUQ4eGhKU29Xam5DQkZiVjVzR3BqNkFWdW1Q?=
 =?utf-8?B?WHh2Qk1DdG9iVWtldktjT2tCQkZjSHJOZ0FkUDBTN0FzellPTzFtNTBKRnps?=
 =?utf-8?B?RnA3Y3ZYRno0aXNCTUxyb3hhYjU3aXpzcmhRbjBucEpiZ0U5aEliL2JKQkhF?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b78247ac-d30b-48e2-25aa-08dce4c51b47
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:37:19.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdwztQzAiSncHKmL/93mq3VXvPQBmr/T2qMipt8lSP7KjZLjvtVdCo9UfhS1XbHskRFRgu6EJdHbTb4ItGOGKTG7WrBOasVErx4Fpd+VmDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com



On 9/30/2024 6:52 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> This series implements the netdev_stat_ops interface for per-queue
>  statistics in the sfc driver, partly using existing counters that
>  were originally added for ethtool -S output.
> 
> Changed in v4:
> * remove RFC tags
> 
> Changed in v3:
> * make TX stats count completions rather than enqueues
> * add new patch #4 to account for XDP TX separately from netdev
>   traffic and include it in base_stats
> * move the tx_queue->old_* members out of the fastpath cachelines
> * note on patch #6 that our hw_gso stats still count enqueues
> * RFC since net-next is closed right now
> 
> Changed in v2:
> * exclude (dedicated) XDP TXQ stats from per-queue TX stats
> * explain patch #3 better
> 
> Edward Cree (7):
>   sfc: remove obsolete counters from struct efx_channel
>   sfc: implement basic per-queue stats
>   sfc: add n_rx_overlength to ethtool stats
>   sfc: account XDP TXes in netdev base stats
>   sfc: implement per-queue rx drop and overrun stats
>   sfc: implement per-queue TSO (hw_gso) stats
>   sfc: add per-queue RX bytes stats
> 
The whole series looks good to me, thanks!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

