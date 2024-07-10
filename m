Return-Path: <netdev+bounces-110630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DBF92D9E9
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04041F20E8F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB05196C6C;
	Wed, 10 Jul 2024 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gET9Au9+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB24196C9C
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642448; cv=fail; b=E6Btsuw/bp7Jfsx8JoYf8LSm25CnPnUr60ODOyWHqRaf2XaKZFFC38AcjB8d6m5oE2urOTY7AFhsVMR1VeNbq+Km6ss2jAgZATYc4dgVvHILmh0jtW66zmi6kGLGX1xA8GrbjiXBKuLjdTLiXzKAhBUpStSJun6hYaokK+B9SsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642448; c=relaxed/simple;
	bh=55V/WZYkYVKYNXf2EWxuErr5JP7EfkECFN84LXXivnA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IaYIJxNMQSFJNKYhFxnWag4Kw0fk+GH12Qej5LSx4YleK4BTvRBiDmmYdLK8Jp6tXXbHGGeNTUj0lkS7MTJS3lXohHzhgMLbSRx6RQx/k6LZFgLstcsHF6QUh1gQ7px3hm3v6wcDY92cidEsgpaCX8v5dH3ATPkzxUlSTVOz+gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gET9Au9+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720642447; x=1752178447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=55V/WZYkYVKYNXf2EWxuErr5JP7EfkECFN84LXXivnA=;
  b=gET9Au9+3A3ObL732vkHEAoLBNBWG3bjzOzVsJcQNX9i1hIARHsbjj7a
   khbTeDLstCMczdx0v0MFvDQGqbOWJhQKJwhD89OwZD0MAbVob9vjVDwAW
   t94oY9EuK+KPJPND4QvqYhDnIPMnTVJjNkPimf+q1XrfpULaHi8Ir5Fq4
   s1VyZBQrDh++i2GM5bKmqexHcoCyOUSHQIjmGbVyzLCv4oemYV/UzEQ3I
   lZ5oUemN3DTuX58RclMyKxxIcvcsbOD2HW196egit78onhEVI/3uj5EdQ
   D3U9ccenjr8JXwJ+7wvgMdYo30pGnkozXvioFpMZD7/wpEff9Repx264F
   A==;
X-CSE-ConnectionGUID: 9tnxdMebQFScdoUUKW+hig==
X-CSE-MsgGUID: LacNf3YRQyyOkkon3MOvXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35425201"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="35425201"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:14:06 -0700
X-CSE-ConnectionGUID: 7FVoYeo5TCST5NamYRCDPg==
X-CSE-MsgGUID: RdGodLHVTkCk3Y3EG28V2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53274040"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 13:14:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 13:14:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 13:14:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 13:14:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDsbA1siFwJWGvNH3JydQh9Lji594g01rZH6T/lSvCXY8VxCw2FsgNEmdt1RA56gXPCrSFnPGVCgat2HKmWzSN+ntOFdCU4Jtx0YUjheJTtM3wqKvQNSOpDXPMyQh0Pb09AWoy8/bNNGKgigG9GVj030dj5x9NTuh7/3Q1U3HXCFkzqyd0sqiYZJVxSAZEDxgMXQE78X3cJGslLhH7JPh+7EP8AOCloKzvC5ZpY4G9yoYO9JnXAh6BX6K3Mr4tLQmcF3bR/8CK0f1nrs5A28MgN/0IlG6DXeVPF0JLZGPrN2YFPNrVKWLf15d0R21vyjpRbpJXxAAu1qsnJ8DI7dVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkAC7PfJiW+ucZw8BMZG0rlDVvGqeGh7FU1eKCVjAX4=;
 b=Vx3LlfuI0nISzZHI+85b3hN8KICwlt/Qm8QYXW8Khhg8VGNc9JH/OgituyueqsjUJYaKtCWPSycuod2L7xL0bYEaphyv4MGVvxJPoBiSPWVX8Mu60LNUmXwERrRbkKxpM/CHUouvdkkD+zSB4deXrtsViEsbAY8lyWJsEF8lnDswxauNZR+Cjvn4xegciLv31qx4EYWABHR1KWiYxKpRjf6+mwsz+q2v0Gz1xrFRiAre8ZRqHrtQMOee8QfraiomiRRMt8z/PoDDu69ngLN0YPZgq22XC4UDDZbQuetcwFAagM0BmG1gdKvBkAej4uwrGBruJ2ZmjhYLdX8oQ20ChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5894.namprd11.prod.outlook.com (2603:10b6:a03:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 20:13:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 20:13:57 +0000
Message-ID: <a646f996-c1b3-4145-83dd-835aa5e29b16@intel.com>
Date: Wed, 10 Jul 2024 13:13:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ethtool: fail closed if we can't get max
 channel used in indirection tables
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <ecree.xilinx@gmail.com>
References: <20240710174043.754664-1-kuba@kernel.org>
 <20240710174043.754664-2-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240710174043.754664-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: fa790bf6-1835-4c9b-f175-08dca11cd45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUQ4T1kyUG5DdmMxcVdOMzQvZDJ3L05PbnVoRmh5SHc4QUlicGN6NVJJU1pv?=
 =?utf-8?B?cStyc1N0eXhhS0J5d1ZUVDBJUUFoMnlBdWZDb2pxa2RSWjlEbWpibmZSc3ZY?=
 =?utf-8?B?SkNCRm1JbWE5MnE5OXNGRzVxMU44ZkwrSlJmUndNRG5CODJISDByb2dNaGM0?=
 =?utf-8?B?N21zQkI1V21nc3I0MkMwWDZpdDFLY29wSCtJSDg3RlJBRmFxRjJzdzZVT3Ey?=
 =?utf-8?B?NVZCd09SZmhrNSt6K3Jrb0NSbDZ1S29TYm0xcFA3ZlV2SzZJY0dXalZSY1Jj?=
 =?utf-8?B?SnRMa1VjTU5GRkhxTk1OeEYzM0xuaURxOElmdTJFV2Yxcy9FQjRkZy9saDkz?=
 =?utf-8?B?TGN1RHV3b3RrOHY0UzQ1bTFOek9vSWk0STQvbzRKVitLUVM4cjJoNlhLY0NK?=
 =?utf-8?B?QXNMVExUTTZadlhWS0FQTkVzNHcxNVJORXF3N0VUbHJxOUNMSThPZlMvTmJa?=
 =?utf-8?B?STdXbDAwUy9HVnV5QTBYNjIweENzU1FveWs1NCtWajY4dGdBaTZiNTBoVHBX?=
 =?utf-8?B?RXhTWXdEVW9oQkdRV2QvbXRJWURYQ3g3UFZtRG9uVmIzUzZ5ZnZ3VWNXcG5Q?=
 =?utf-8?B?djUvNDc2TUFlM0FNRTVjcEVXWUxuUSsrRUZjTGtHdWUvQ0Mwdi9Va0w1djF4?=
 =?utf-8?B?UDJZb3hrV2FnS2I4dnAyUUJBMzlEQnFyUG9Hekk0dGd0RTRJaWJMUDNpdE9N?=
 =?utf-8?B?VFU2amNEWVkxQ0FkajZ3aTB3VEplblNUS21yNTY0dVBML1FPYXpJdlFyaVFo?=
 =?utf-8?B?a2J6RmFzTmRrN2pvcWdsOG4xeUYrUmFMYzVaMmxTdG52WUZFME9mQXprTUt3?=
 =?utf-8?B?akZPZjZQTnVud3ZYeExFcFMxYlZRSTNrcFlPa3kwRno4bmFXZWJBbG92NXpr?=
 =?utf-8?B?WGtwSHRIQlBXcW5TRENFVmQ2eUdqWlVGWit6RjNTNUhzdGhyVTd2d3RTMDBV?=
 =?utf-8?B?RUpob2MwTzM0WHR5c2UySEs2Y25CazRNWVZSNjc4L3NlWWFjWWpwRzhhTEkr?=
 =?utf-8?B?V1Z1c0JmeFdsK1R5VC9FUW8rN3FXRHkwMlpYMnVSOE04Q2tObVVIWEErY2Nr?=
 =?utf-8?B?ZnBVMmVDWVhiWGdKMncrSmF2WWFocWEwK0Z0NU1wdXkwNUUwYmVHQk1ZSmN3?=
 =?utf-8?B?S2ZsN2FNL0RjUkh6NHI1Mi9SZHJqUDF2UDhsMXdoWnB0WjFhaStTSUNIdDZ2?=
 =?utf-8?B?cExMUHh6dS9SWWNOa1NmaWtnekFmQk5xbitrVFV4WnFBWGoyODBmZW1KY2kv?=
 =?utf-8?B?RVBscXo2QnhlSE80UUV1TE4xUXUyTXJGb2t2VTloNTNJdTZwVTJVcUNoR1FX?=
 =?utf-8?B?eFlnWEVtaXJGd1c2YW84bU5tdEVkOGZmaUpwMytwcXg3Q2FUZUVTTldzUzY4?=
 =?utf-8?B?VkdmVUpidlkzMlNNOTJwQUZMdU0wazVuVVZzekd2bVJwVVlXODBDRmZSR2Er?=
 =?utf-8?B?bG1lcmJ5a3BaUTVCeTk4RlIyOWZ6eHYvdGh5QkEyTE96a3Fhem9zSEJNZDJ2?=
 =?utf-8?B?QjRaaWtBSG91OTlIMXRMVmVlOEljZmRDaXRFS01rMStIbXU3U05lWlJqVm9o?=
 =?utf-8?B?ZkE4eGM4aU1vQklRc2tvZWFDdjEwSk5qeFI0RSsvZ1c2NXRoaUhQNnBMbHJm?=
 =?utf-8?B?eHdtc0ZIMk1LTlNOaUt5WFF2S3R5aXJRYmsxSHFwZXF0b3VkcTFDZk4yNUp1?=
 =?utf-8?B?dHlkR01DSGVMSlVxZzFoOG9Eek1UdFhaM0VpNWJlUTUxQkt1SHliQnd2NUFP?=
 =?utf-8?B?SXVsODVjcktBbW9JL1NSWW9RSjMrOURGcGNSeC9LY1drTkV3S2VyS0ZHK3pU?=
 =?utf-8?B?UVdmUkUrb3R5cHFwS0tVdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVsRkljbGFFV0Rwcmt2Q1NTb3RYeG1yMlBlQVgxOUtMQ0hPUnVVbnhFTlJr?=
 =?utf-8?B?Z1BKcG16cVlYNzZxTkZKMWUvS3BRNUpvSHJnUjRoQUtGeWUwbGpweU9LOFhr?=
 =?utf-8?B?THNiL1dybUhFL0g2MkxxWkpDMHE3R1gvb1pvWXo5ZWVGcCsrbkxTUFEvRThp?=
 =?utf-8?B?UVc5SjRydlQwcDJPRG1Ma2VpK3Vvc1FEb2FqMThGYXJ1cXR2OFlzYzVVU0Rn?=
 =?utf-8?B?QXdQdGJyN0hrWVZvbXBmSFdkQVA0eHk2YXlJeVpLQ1dYUzlYekcrb0JTNTNu?=
 =?utf-8?B?WHI2YTlURlhWam4yRDI5Z2c2VGFXQXlRZEVoa0dxRUIySkZKS2Y5ZzYyZSsv?=
 =?utf-8?B?Q0l5VzF3Y1IrMlVVV05Ua0VTcTg5WU9mNjVPd24rOUl3MjUzei8zSXo5YVZh?=
 =?utf-8?B?R1V1MS9Kb0pmTXdLcWlqSFY5MFFDZVRzRHhkT1cvajFLaU1zTVZUWHhtVFVw?=
 =?utf-8?B?bDJ2MkRWc1UvZDF5T2p6cDNUb1pNNEtBNGdZNG5QYkNQTWpWdXU3bDV3RVVv?=
 =?utf-8?B?bVZITFNGaFJtMmlpREZOWkJuT3JDZjZLQ0VxVTRwd3pXeEJhWFdqbTR1RUtz?=
 =?utf-8?B?OWh5R2IrT0E0ZFR4azR2VUw2TldheW1WSE1xbDFoVFcxUXk4d2hzWE5yNWFU?=
 =?utf-8?B?UVdzOU9WUDVQazZxbnh5T1ZJMGhQSTdFZnVZOUpIcmQwN1hHSjdhb3B0QzF0?=
 =?utf-8?B?QW5ZNHdRdkdzRy9EWVV6N1RrZkovVklocXB6WjcvZm83WmFUMnRzN1NxNWky?=
 =?utf-8?B?bXRTTU4rRThSbHBwa2pFQm1OZkxxL0NwTGd4UEJlNStJTVgxbU1iRmdpNXJI?=
 =?utf-8?B?aEMyTmJSOEdqWFMvNWx1UGI2VEp4NzRtZVdodXJKYXVEaGN2SHF6TVowTW1T?=
 =?utf-8?B?WmNjT2tpYzh2L3d2NTEzOWFraGVVM3FET25rYnRtdjkreVgwc1hINm0yaXpo?=
 =?utf-8?B?WmJDeTZjMHl3K0cyamdCMkhaeThtd3NkSHcwdkFYL1RkWjg5S0JUZlh4SHVv?=
 =?utf-8?B?b0RiNWUrVHlmTXg1SjFvZVkwL2FFV1l2M3VGdFE2dTRNdjBGbnV6L21GRlBY?=
 =?utf-8?B?ZXphZWZnRHl0ellDVW1HWkI0SzhrMjcvby82TE1zWGUzOU5oWFF2UmV5dnR3?=
 =?utf-8?B?aStXZ2hqVlc0enZFZnJaMlVmeWRqUXJYOHBpa2wyQnhFblk0ZXRMeHNwbGU0?=
 =?utf-8?B?OVFzeVFVQzRZbEs0TW05djhQbm5mVlNHSElsd2RjSmZFQzNIWG9RTkpTekpC?=
 =?utf-8?B?T2NJUUhyamtIWXFwZzR2KzdJaFFVeEJTQUlXbnZRdytMMDhwMS9qM3dGaG9j?=
 =?utf-8?B?K0dKT28rTzRnZGgyZ2xUQ2d5ZFJ5SUl1T2YzNis2ck12dlBhSlRkMlJsTVBE?=
 =?utf-8?B?WVBhM212SldCb3VScmRlbDBaaWtwdnMxT202VnhVc25OTndYZ1pmNzNLNlZL?=
 =?utf-8?B?MUpIc2V5QnZqMkdTS1NNc2tybHhqQWlvV3FJd1NhWnIzalNxUWl0cE9ndERq?=
 =?utf-8?B?WmEzWWtwaUE3NmNLQzJUMEt6UXhQekNKTXArTTN1ZEdMbHVPKzIyZ1FJYkE0?=
 =?utf-8?B?SHlRWnNhNjFWbXhmS2Z5ZzYrcUZMQkFhNWhMYWczSk00L1RGaTVtazUydDdo?=
 =?utf-8?B?UVorWjFpVVoycWM0UnZYNlNRMnQvd1ZhcU05VjdVczl6ZERlL2c0dzJ2T2ZZ?=
 =?utf-8?B?WUNRWEw4UDFHMlAzRGorb0J2ZUd4Vko0WldKcHN2dU44RHU4Rk5BVzJUVnRR?=
 =?utf-8?B?aUltMnc1VFNRSWNuUVJsKzlFZGFuR2VnSnlhekNIc3J6YnkzUytRSDArNmRm?=
 =?utf-8?B?ZWV3UElVNlIzRE5KTUVvZDFUSjRHV1kyQml5eGxTQnVhL2ZUWjFiZGZQTUlL?=
 =?utf-8?B?cHJtVWNDVXozM0ttZ1ByQ09raG94Rkl3cU9lTFZ4MkZPRkNMekJGemxubFFO?=
 =?utf-8?B?WlluczJtMkFtaHhTSkxnOUdtaHRwU2piRGZiUU9nQ2ZFWDZwbjV2Y2ZlLzlY?=
 =?utf-8?B?bHY4NEMxZERvQ0VvUk5IbWhkZnB1M2Yzdm81b0FwQ0FhNWRPeGVodG5jWjhQ?=
 =?utf-8?B?empyQnZuRzFiczNDd0cvdkxXWk5mV1lnT2xWNGlmc1NINzZNVDI3UldjeG81?=
 =?utf-8?B?VjI3RHlQdTM1eDk1OXN0d2FqMmI5TXlDTkljKzk0RllQWmQ0anZvZHRQUU9i?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa790bf6-1835-4c9b-f175-08dca11cd45a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:13:57.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZWFq6V1phbdo54T7nUBIIUz9g7P/u11mcUqXOdoWBnDifgFjn9Eyn6ILNUTCXz/vPSrHfF+mrj9QhuORxmlyz3rSK49vvMLzZFwPNctR9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5894
X-OriginatorOrg: intel.com



On 7/10/2024 10:40 AM, Jakub Kicinski wrote:
> Commit 0d1b7d6c9274 ("bnxt: fix crashes when reducing ring count with
> active RSS contexts") proves that allowing indirection table to contain
> channels with out of bounds IDs may lead to crashes. Currently the
> max channel check in the core gets skipped if driver can't fetch
> the indirection table or when we can't allocate memory.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Nice. Fixing this in the core for all drivers is better than having to
patch each driver to avoid crashing. Reducing ring counts with active
RSS has caused issues on Intel drivers in the past too.

> Both of those conditions should be extremely rare but if they do
> happen we should try to be safe and fail the channel change.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/ethtool/channels.c |  6 ++----
>  net/ethtool/common.c   | 26 +++++++++++++++-----------
>  net/ethtool/common.h   |  2 +-
>  net/ethtool/ioctl.c    |  4 +---
>  4 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
> index 7b4bbd674bae..cee188da54f8 100644
> --- a/net/ethtool/channels.c
> +++ b/net/ethtool/channels.c
> @@ -171,11 +171,9 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
>  	 */
>  	if (ethtool_get_max_rxnfc_channel(dev, &max_rxnfc_in_use))
>  		max_rxnfc_in_use = 0;
> -	if (!netif_is_rxfh_configured(dev) ||
> -	    ethtool_get_max_rxfh_channel(dev, &max_rxfh_in_use))
> -		max_rxfh_in_use = 0;
> +	max_rxfh_in_use = ethtool_get_max_rxfh_channel(dev);

We explicitly call ethtool_get_max_rxfh_channel here now.

>  	if (channels.combined_count + channels.rx_count <= max_rxfh_in_use) {
> -		GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing indirection table settings");
> +		GENL_SET_ERR_MSG_FMT(info, "requested channel counts are too low for existing indirection table (%d)", max_rxfh_in_use);
>  		return -EINVAL;
>  	}
>  	if (channels.combined_count + channels.rx_count <= max_rxnfc_in_use) {
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 6b2a360dcdf0..8a62375ebd1f 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -587,35 +587,39 @@ int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
>  	return err;
>  }
>  
> -int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max)
> +u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
>  {
>  	struct ethtool_rxfh_param rxfh = {};
> -	u32 dev_size, current_max = 0;
> +	u32 dev_size, current_max;
>  	int ret;
>  
> +	if (!netif_is_rxfh_configured(dev))
> +		return 0;
> +

Because now it will return something sensible.

>  	if (!dev->ethtool_ops->get_rxfh_indir_size ||
>  	    !dev->ethtool_ops->get_rxfh)
> -		return -EOPNOTSUPP;
> +		return 0;
>  	dev_size = dev->ethtool_ops->get_rxfh_indir_size(dev);
>  	if (dev_size == 0)
> -		return -EOPNOTSUPP;
> +		return 0;
>  
>  	rxfh.indir = kcalloc(dev_size, sizeof(rxfh.indir[0]), GFP_USER);
>  	if (!rxfh.indir)
> -		return -ENOMEM;
> +		return U32_MAX;
>  

And we return U32_MAX to indicate catastrophic errors such as no table,
or a failure from the driver. This forces it to fail the configuration
change.

Nice.

>  	ret = dev->ethtool_ops->get_rxfh(dev, &rxfh);
> -	if (ret)
> -		goto out;
> +	if (ret) {
> +		current_max = U32_MAX;
> +		goto out_free;
> +	}
>  
> +	current_max = 0;
>  	while (dev_size--)
>  		current_max = max(current_max, rxfh.indir[dev_size]);
>  
> -	*max = current_max;
> -
> -out:
> +out_free:
>  	kfree(rxfh.indir);
> -	return ret;
> +	return current_max;
>  }
>  
>  int ethtool_check_ops(const struct ethtool_ops *ops)
> diff --git a/net/ethtool/common.h b/net/ethtool/common.h
> index 28b8aaaf9bcb..b55705a9ad5a 100644
> --- a/net/ethtool/common.h
> +++ b/net/ethtool/common.h
> @@ -42,7 +42,7 @@ int __ethtool_get_link(struct net_device *dev);
>  bool convert_legacy_settings_to_link_ksettings(
>  	struct ethtool_link_ksettings *link_ksettings,
>  	const struct ethtool_cmd *legacy_settings);
> -int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max);
> +u32 ethtool_get_max_rxfh_channel(struct net_device *dev);
>  int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max);
>  int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info);
>  
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index d72b0fec89af..615812ff8974 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -2049,9 +2049,7 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
>  	 * indirection table/rxnfc settings */
>  	if (ethtool_get_max_rxnfc_channel(dev, &max_rxnfc_in_use))
>  		max_rxnfc_in_use = 0;
> -	if (!netif_is_rxfh_configured(dev) ||
> -	    ethtool_get_max_rxfh_channel(dev, &max_rxfh_in_use))
> -		max_rxfh_in_use = 0;
> +	max_rxfh_in_use = ethtool_get_max_rxfh_channel(dev);
>  	if (channels.combined_count + channels.rx_count <=
>  	    max_t(u64, max_rxnfc_in_use, max_rxfh_in_use))
>  		return -EINVAL;

