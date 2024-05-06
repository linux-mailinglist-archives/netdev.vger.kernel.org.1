Return-Path: <netdev+bounces-93812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38C8BD432
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6CA1F22A18
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93E0158201;
	Mon,  6 May 2024 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddpmbigV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9D157499;
	Mon,  6 May 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018105; cv=fail; b=t2C5hj/EPUycCpdyuwMm4Vm0pEOyv3TJ7M/Pz0/jGDIbCdVceZx3LiKHpJiVpVfvzCTs0sNIfWRilAZbz6FntjbYZ5hSxyiHhHZjiRrS1fPiQlunZRZFfS2njHCjMWvsrWq7qFWtzSMyXeuvCwA2+NZte+2tMmUgk3AZgOtiTMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018105; c=relaxed/simple;
	bh=fAZOMBWC5d0Mm+9saRVNRdYI57OIrbB9q52vKelPiBw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fOAAYPOSRrJK2f9yo5uxgFKrNsLV0VbSsOVsXO8Qcn9zUv0N8u5I1Or04Cbo9gDNGgLesucJPjs2vSXEFs/d6N/g1W9KtNVNgVVAHv0rWQk+TxcuDMJxFpYDd4mUh/M4LAIe0vubMv10gWCgd3fgmpwbSDL2a0dWw2sBpwx3oL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddpmbigV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715018104; x=1746554104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fAZOMBWC5d0Mm+9saRVNRdYI57OIrbB9q52vKelPiBw=;
  b=ddpmbigVqWn6nauu4uHQNaJWWxh9jBT8lckj5IN0bieP1yPzvK4O/I6I
   T9B9J/fc0Mv2WQegxxNaEUy457Ak2BG7tcCJreynS76tjJWoctWnAoR8b
   hwiGONj3SFKgOxtenmWBEVdILOU4KKKBvFnyLJUjowYSzm0UZ6NazAV9a
   s+zZOEojkYIsyGLNQ0IZtNJgSkKyYGaIq3NzRuwxinYRDph+oxH7kuo3k
   MGJdrkwe1ewTibDC5x0em+CbVPlMV9GmHJQX3P9niDKF4XZ1TpJgXHG/6
   3DL9+92zqexjKTCgEqKA6fBXfnI0zj0UG0acH5NlrF9vb7HX1YcjpwBHK
   A==;
X-CSE-ConnectionGUID: DWoa1APNTQed468LnqBUyw==
X-CSE-MsgGUID: iGVg5QoGTLO+LfiOVSAJDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14561120"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="14561120"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:55:03 -0700
X-CSE-ConnectionGUID: iqFv+n4aQyyGo7oZsy8GHQ==
X-CSE-MsgGUID: 3snV6nO3Toa3+YzP6xhMjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="59096365"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 10:55:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 10:55:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 10:55:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 10:55:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:55:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3CiezVY6xEGMTIbXb65peg2NKVrlWfRJ7HEd2qeufsvI9o4l2ex3gZM7ng81v9c1aMgoctEX3prH602TJu8fYlxsPv3lEe8sYoh2Fd8fAOnSNW5zCOIZKLgjnZuTBEE3tyWV5PLfFEfgBhwGDllzGasdVHtIqnUUfNrLFCyM0OVRTN84rx5K/DD2G1bdB/5+yiXc13aIBQzLmAdDBzg4k59WR2OEz1t1nhO0h2Kc9vw5cKde9p+NIpOM/Ry7CyWylhG/t3551CgYdtCfddNKU3V6VTlBS49vPyK0OyEwMRVNp9v+e/A3ljM/IQ5GxJ1Ax/mp6h4h7lEDs00ZJuPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmQAdXgXfOS9BZrLoYZZJ8DmMx+ZRtjXm/JJQ13tT+M=;
 b=XeMYwSUal755z1/pwOD/S7Bb4zftL7g+azuFhPVsoZ4zL5myehTtQAK7ModNf1TMnoX2vZ/SSO/lg5cqLnb55a1fzH+gd31b8xC9quoHgEaAV62M6ikfuZiIomnma2Nj7ZCoPNWoKbcZOh9GuHQpmxMNbH3ZklS7CdUgKa8EmWtpzAYy15s8ftOBbyHukYd/oJ71MtUvEmuqgdnHB1Yl0a3QO+oaKozxYPuuDPQZTcIwEVtYgK8TzuJ+1L7fmLpWhxonACeU3MXRkr2/fMrRSwcACRAfbHQBXLm1XzGrgNIqCL6YPeenSjQn6E0FWAftWezfC4uzTrSb7jaqnW8ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by DS0PR11MB7830.namprd11.prod.outlook.com (2603:10b6:8:f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 17:54:59 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 17:54:59 +0000
Message-ID: <b63df398-f210-4ec6-8403-f447683e184f@intel.com>
Date: Mon, 6 May 2024 10:54:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: flower: validate control
 flags
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	"Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
References: <20240416144320.15300-1-ast@fiberby.net>
 <PH0PR11MB5013807F66C976477212B27C961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
 <7cf42f1b-d7e2-4957-bee9-e875c61d19e2@fiberby.net>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <7cf42f1b-d7e2-4957-bee9-e875c61d19e2@fiberby.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:303:16d::23) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|DS0PR11MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 578e4c5b-b06e-4579-fc44-08dc6df5a4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWowNG15eG1xYjVxbndGU2w4VVNja1ZBMCtVcU5sRFF6WkpXMHhlNXJPRlZr?=
 =?utf-8?B?UEJGcWFxVkdzZDZ3RTNpT3lxR1VhRDhnS3UxY2NNU3RVajJVN2xzS1FxNGN6?=
 =?utf-8?B?bElwY2xjdzVaRTNkL1FTVFFrc1FQN1A5R1I1QytlWU1CblpCaVNOY1FsRnNS?=
 =?utf-8?B?NHhJNjg3cHFKNEhTUEdGdkpCQkpjRGhsZ3FKOXNBckhDNXpvUFFyU2x1Q3Bl?=
 =?utf-8?B?d1RGUU5PK2YzeVR6ODhJbFdyeVpZdFpCY2VscTI4cmQ2dDRaT3kwQzA0SFll?=
 =?utf-8?B?QnVnV3A3NWZRUC90bSs1U1FmaU5yYWR6b2lyaERHeExkeHVKdzk1WDBHVklF?=
 =?utf-8?B?dDRuSEdvM3VROFBrZC8wTERqeEdoTHc4Y3BTYU52eENMcGVzeEhyaGJRVldi?=
 =?utf-8?B?eW42bzR2VEVpMEl3RFBLbWhVMzJJcGRGeTJhaE8vK2RQQUl0bG1Fc2RWWVFL?=
 =?utf-8?B?MCtsb0tDV21YeWRISkFaR0dBd3pFUlM4bDV2a1NCZzArUmZxZjUrdmhrbkVE?=
 =?utf-8?B?Vm1zaXBpMUpEU29VRW56NVpwaWVNNVpMcXBSS2VvZEZ6eUhIUEh1T2EvdVQ1?=
 =?utf-8?B?M0xpTlN5cnZGaUVNR2xKcG1naWM0MEV3V2dzTnJDL1c1QVZTVzh3NXBQbW5Y?=
 =?utf-8?B?NmdaR2dERjVmRmszakZDQkthaURQalRvK0hXVi9odjNiOXpmSDFGQlJYeDE4?=
 =?utf-8?B?NTJieEVDeXg2R2RGelBsaXMzNEJsbEVHZXZld0NZOEl2bWh2UmdRaXVPTlUz?=
 =?utf-8?B?Uk5rUGVaUWltYit6NklwdmxNVDJDcGdHbm8vZkV2aVVRaHhSeVhadHBCS2R3?=
 =?utf-8?B?MERSU3I0dlRPNkV2SzhHVk04NzBaNjhxUmZPcXFJYnRqRkYrekFTRnRwT2hJ?=
 =?utf-8?B?NVpGaE9tamozcFJNajFHUkN2S0tyeXVneUJkeEtCMnd1Uk1CU1NNVGFnMkUw?=
 =?utf-8?B?NS9hUlB0SjBqaGgrMDNHVzladlB6cCtJNHduK2tmOW10QlFKQ1RENS9Ldnhu?=
 =?utf-8?B?aC8zNFRacU9OYzJlaXFPd0czSUhHcU9wYmVwa1l5aWp6bytFSjNxZ3Y3ZW5M?=
 =?utf-8?B?cGRGSHZ4bE9nejBTUEFQVENGYi9EVlFQUUFFR2YwRXZWZDB1b3UxcWU0b0x2?=
 =?utf-8?B?Wkd0K3g1d3A0Q3BiYVRrclhlaUwxalF0Mi8zdUhSM0xOT3dzaVh2VWVoSjRW?=
 =?utf-8?B?ak14M1l4SzlTd24xUFhJbzNwK1NYSWxPRjhLc0pYNVM3T3dwb2VvQlprUjBF?=
 =?utf-8?B?NTRZYUZmNEVhRU11Q3dkU0lUZFNrQVlxQWZBcWJ5b0RidjRZa3Zjb3hkaEhx?=
 =?utf-8?B?UFBqNjNDMi9lUXJvQlNOdjE4dkVsTGFLV0ZvSmRRdEJGZ2RxN3piN3NvK3dp?=
 =?utf-8?B?aFhzVit5ckQzWHo2RzhWSUF4QjVQZ2J6Sm55V1BsNE1wR2dwbDM4dkxsVXgw?=
 =?utf-8?B?Ri9IR1F5Tks3NDMyRVRCUGMvKzRyTmhqT3ZvcDRsNzIwWTNUaW91eXd1aG1X?=
 =?utf-8?B?N0JOL1F2UnZ3eWVTNGphcU1MODRCdDhYSVpaRFkxNUhCTnVKRFpGcmxPWGVk?=
 =?utf-8?B?VEN1d28rQXZlSXlqbFFpRnVTYkIrK09TOTBGYSs5Tm0wMWRJbXpVOS96QVlh?=
 =?utf-8?Q?Ov+mjqGaSnMoggmkF47MLEB+xeXjNvtx0b/Sw5kgQDBQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTJQZmdReS9ZSHVaSWxXaGtCQWd3Ty9pTjArem03TnJ2SjJ1YUNZckplTGdF?=
 =?utf-8?B?ZmZFaDFnSUl1NFhnOXVRd0lhN1hYbXJvc0tyUENOcXh0K2dUczZ0V2NYbmRj?=
 =?utf-8?B?Zk94TDd3UkNwSW00b2NFMG50cFo4T2w5L2xhZ0ZCUGpRYlAvV0lwc2I4ZlNk?=
 =?utf-8?B?NHRHdG5jQ3Y4Y0JDN09RT2J6b1F4b0lxb1kwZmpQOVV0eEgvT2NPY0QyYU95?=
 =?utf-8?B?Q1VONXhtaVhmK05tbmZXSjNGZTA5NHhFZ21ITXliODFjR3hUVlZ2SnR1V3ox?=
 =?utf-8?B?bm1BMStWMTFCT1IvTCtXc1gwckt0UG1BeHFnb2VZNWxxNDMwYnZ6RmM5dUVK?=
 =?utf-8?B?YTVRZk9XOUxPZVYvTjZ0bk5YQW53eVRhQURNQVdTa201dGwrWStHNFZrR24w?=
 =?utf-8?B?dXp5ZWtuKzN3MkpHL0xFVGFxWEtyd0JqQXNjTFEyclo2MSswQ2tNamthdTVs?=
 =?utf-8?B?OGx0cjZnd2VYRTJPQ2h3ZlZKMURVbHNsQ0JwdzBXblF3ZVZJa094VmhCZXNE?=
 =?utf-8?B?VWIzWmpJKzhEY253WXluTFFPOEVBenFiTDVZSXNHeGFIZG9laGdJSGowRU1i?=
 =?utf-8?B?dlFpbG1KN3BFK2JOcEFITnFHeVEyQnNtWEQ3ZXJVaXZaWGNKd0Vob2tSNjN2?=
 =?utf-8?B?VTBCNVZrNUdZdmlYQmhpZDgvdkdnK3pOeXpicE9VbGV3bGdxVldtREEzbzNl?=
 =?utf-8?B?TlVaa3FJTUdmZkVNWXpvWkF0UEluTDNEZU1INkViVUlDbmRuUmtPQ2VFcmhL?=
 =?utf-8?B?YW1wbk1QNGI3eGkvMXU3VTExeXhkZldxMnhYTEZlUDJiVW9paytGcG1VYUkz?=
 =?utf-8?B?cS9JWWUxcDFrOTRsS2JtVXEzL0JBTkZRMlhhSzRkWFhBbEljV1RoSUNuZG1C?=
 =?utf-8?B?MU1pbzU0VUNpc2ZyckpEZE5TZ3o1eThaaVltRHNmcERYY2NFN04xNW1zTmNJ?=
 =?utf-8?B?L2hyNUh2SkQvL3RlT0pneXpKZXFJWXdqTEZIV3JaRHYreGJHV2VHMk5EQnQv?=
 =?utf-8?B?b1RyZk9FSCtmY2xIbUlValFONHFEZERRSWZkbTNtbUhVa0JJUndCR0lPaXA0?=
 =?utf-8?B?L0FLZWtDS3pZWkhEM25TOFdsV09lMmJlamNOWDhpbEI3aklua1dKWE9rRW1I?=
 =?utf-8?B?VVJoRXE1REZnZlZ1SVJkNmFTUTRpd2h6SjNBazNOeE8vYU1wbkFoM0FpVXNl?=
 =?utf-8?B?UFZib1loODFYTUppM003VFcrNWZzVFNuV2hPeWJOSG9MeHdSbWZLVmJhRzFC?=
 =?utf-8?B?YTBDYVI0VGNDVlcxUUxPL0U4Yzlnd0ZqN1IrbEpWV21WYnBSTXArRDlhdXdr?=
 =?utf-8?B?aS9LTUtzWllXUTU5T2V3Z3FRTEhYekNKT2lIOUJubC9zT2lyam94RnQySzRu?=
 =?utf-8?B?NDVFOElBVGZaL1dQUTF3TE9JWWRsVHZKbnIzMDZiN0FEQS9rcTBGSlZSUmo0?=
 =?utf-8?B?SWRkMEEvdWVnbjBxSGpHZ1lJY0V6Q0pndnI0YzVqNVh0K0hxeitqbHMzZUZY?=
 =?utf-8?B?cjlKOWhpOUNVc0hXM0JTeld6Z1A3Z0UrK3JuL3g1d3NMbG50NTdGS3FWVWVu?=
 =?utf-8?B?YmdONjdMOXE4cXZCclMzWjZ6aHlMMFkvQ1RaTlh2SWxsbnN4dVJPSHZwazl0?=
 =?utf-8?B?aHVab0xlK1l3V0NueGwzWWIzcW9qaUZpdUlQTTRsWEpSQUxqZzlqTDJzOGp4?=
 =?utf-8?B?NmJxMUQ1V25yNVlBeE5nREs5Y21YWCtwc3FlS2pOZkFaZWxYZUtpVFRhWm4v?=
 =?utf-8?B?QlY1YlBLZnV3aXNMRVRMamVrSThMenF0TnY4TFFKbU5OanNpc2NHWGNkYnRr?=
 =?utf-8?B?WW1XZzUwZzZDekhhSG1NRUNQTFFOWHI0V0x0N2FEMkVjSzQ3c25waGRwVDlM?=
 =?utf-8?B?d2JlNGYzSjJwNFZvSU9Ba25zZjZGTnZscDkzV1BsK1JYeENrOGRjeFdUeWYw?=
 =?utf-8?B?emhhUG1QVTFyZ1lSVmYxSGxrQXZHcGROTUpZWlFDWjhKSlJmR2c5dXh5NHZJ?=
 =?utf-8?B?VWl4VGI0WWgwN21UazNuOW95ZmFjb1BzelkwMzFiK1FLTmgxa1V6Y2RPODFu?=
 =?utf-8?B?UDJWQ3hQaFNWcC91T0ZTWWdxWlMzVCsxZGgzZy9FRm1LY3pKTmtiS3V4djJq?=
 =?utf-8?B?SFpOV1FqbG83UU5ZUXJwK3NtaThEK2pmM2hBYTNOTWlvZ3pITDBESFFUakJS?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 578e4c5b-b06e-4579-fc44-08dc6df5a4df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:54:58.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCzvYax8NH4dfv1QnE7eNyAWqLeNwTefRvH5+auBhuxoR70ikC/Q+iGGr9vPiN7VAYhezWd8WZi01S78EQVwOHbc4UewZ5K0zZDJ2gvcj1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7830
X-OriginatorOrg: intel.com



On 5/6/2024 1:44 AM, Asbjørn Sloth Tønnesen wrote:
> Hi Sujai,
> 
> Thank you for testing.
> 
> On 5/6/24 5:32 AM, Buvaneswaran, Sujai wrote:
>> HW offload is not supported on the i40e interface. This patch cannot 
>> be tested on i40e interface.
> 
> To me it looks like it's supported (otherwise there is a lot of dead 
> flower code in i40e_main.c),
> although it's a bit limited in functionality, and is called "cloud 
> filters".
> 
> static const struct net_device_ops i40e_netdev_ops = {
>      [...]
>      .ndo_setup_tc           = __i40e_setup_tc,
>      [...]
> };
> 
> There is a path from __i40e_setup_tc() to i40e_parse_cls_flower(),
> so it should be possible to test this patch.
> 
> Most of the gatekeeping is in i40e_configure_clsflower().
> 
> I think you should be able to get past the gatekeeping with this:
> 
> ethtool -K $iface ntuple off
> ethtool -K $iface hw-tc-offload on
> tc qdisc add dev $iface ingress

One step is missing before adding the filter.
In order to use hw_tc action, queue groups need to be created and can be 
done using

tc qdisc add dev $iface root mqprio num_tc 2 map 0 1 queues 2@0 8@2 hw 1 
mode channel

> tc filter add dev $iface protocol ip parent ffff: prio 1 flower dst_mac 
> 3c:fd:fe:a0:d6:70 ip_flags frag skip_sw hw_tc 1
> 
> The above filter is based on the first example in:
>    [jkirsher/next-queue PATCH v5 6/6] i40e: Enable cloud filters via 
> tc-flower
>    
> https://lore.kernel.org/netdev/150909696126.48377.794676088838721605.stgit@anamdev.jf.intel.com/
> 

