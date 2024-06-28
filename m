Return-Path: <netdev+bounces-107679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90C91BEB2
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06DCB20EB2
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705E156967;
	Fri, 28 Jun 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A57s6h2z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6112E64A
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578122; cv=fail; b=UD6JjwZi4RycwSzt2E+yNOn2PbxpKLiB3x+t3kxGaH2ortAN2qTwnQ5StTK9cX21JP/f6yXa4QFvfrCfXPq7S4bDFU2dWhlQJZ8bDUHqkvG9H8d/Dat7da1j3aAc7VYpugmBAWy8es9nVK/LOL63FLzhzWbEtNNrfqRWWejOC5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578122; c=relaxed/simple;
	bh=h5iJS7jc5thsFSJ7e9URWtl3LymnEERK6bSO+vk8ceg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AMBm4RfTC8kY647tLinzYQJiKhnWxvobm489pEwfbqJXCpSTXqqLunR+2JGn40B/MhNfnJQKUr17rf06+Av/oGfvk54SvwvnnxOC6krxnLMhTewy6dV3s3RHQGKuVyPMohAFgFO+OkBUGzQCpNy5OKyv/vestP91LSSArIFZnuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A57s6h2z; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719578119; x=1751114119;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h5iJS7jc5thsFSJ7e9URWtl3LymnEERK6bSO+vk8ceg=;
  b=A57s6h2zWyTszBNF15FD48JcFM5yyBWzFbdYLulUUXD+q3zOfVqpxmAP
   DJCOlOZM4SfM1e6jzN9ENmHPqxBOrV0ENoUev0teVRxHMpW3R+voRHHQz
   RnlTq01ZNW32j+4v6UiDrS5zQYMVebKSLE2UgOPYgR8ZuHztPAulhE3sR
   GP71NjYfHI55ek2rTEMAuzO8vBgMZ8w188boR5ZssJkYg63aMbc9H8cJJ
   wuaRzXGIj9y+1cS/CLNK3DhjNH+M7EcQHGDNiqvFda9ncNdtfJJToc4mD
   sisHmkMcDuH1Uq9Wm54wPxwdOVTicXX/IGpn0TzB5NemU8xIxdePTw8HR
   Q==;
X-CSE-ConnectionGUID: xs6TtYFgSgOYLoxkYLRk6g==
X-CSE-MsgGUID: fcFfs8+jRPegGIdJgRPzEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27346517"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="27346517"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 05:35:19 -0700
X-CSE-ConnectionGUID: cN3silDURsWjon5xtqpLuw==
X-CSE-MsgGUID: 6YQspeBhRPGQPmyAwSf9qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="67924834"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 05:35:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 05:35:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 05:35:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 05:35:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcwE43ejl+SyvidJGIW8O6f0YoZNU1GoZ/LmwnowOCE9XFnRiweTZWqlgxToKcM+bLaIl0iYhrZR2cx4411GW42X50Fs17kmaZkbQP0aDZ7xgpZJtrSAGjjXXx0LcO095hSrHuCRxouTZuK+R2I1cVmdhX78e7woowMBhmPFKMW07CrMNAkG6tgRjTBvbAXk0AOIP5KOLDWK+3RTYmpaH5JWi4nmXmTIKz6EsexcjZ+UyeYihS/OJbi/MKM5Au6NW5sn92wfnn6eXAvJ6nLRTkvnd9FH9oruNR5dB6L7AvBxDHsJsO9Pkh2MhuGb65v0WseYOUwTdmzwNi3tfCeqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s7oCX/eUE8kxOxoIodwDPOtYfY394zWCRoWpMwzyiA=;
 b=mjiPAjfpyVAvCz9eD2tb9dVWyFbmvyP5gs+sv/5rSu9txMMTBf3I/b4KDYcXnOkxzFXXuBTevNJe2DZRNqNHV464hXfnTwHaqGcjr6WCjThI5d2xmMYkljLTuq+5QNIdGEAv97vRbpVDHMJ3tX2pCWId+f08vCMQy50Nt93/4+L3R+7CHAReQD04JuKr/CF26mAxir26TFh5Bo83R8pyTu5mt9nuYqYiNGqqXsGdt+BI80pzuP3DS7o1rCJXtSTZuoqDmwVcJpEJUG+YRosV54/uVD34Z3MXzoXLcgrcuZsxalVHXtnJnX3vuo0KuUsMX4Ml1f/9IJJbK+ZEC42M0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 12:35:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 12:35:15 +0000
Message-ID: <880ad1de-94a6-4226-861e-fa38f7555261@intel.com>
Date: Fri, 28 Jun 2024 14:35:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] selftests: drv-net: add ability to
 schedule cleanup with defer()
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<petrm@nvidia.com>, <davem@davemloft.net>, <willemdebruijn.kernel@gmail.com>
References: <20240627185502.3069139-1-kuba@kernel.org>
 <20240627185502.3069139-3-kuba@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240627185502.3069139-3-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0094.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::47) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW3PR11MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8c120d-3b71-44f5-bbcc-08dc976ec346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2ErcVd5WGxqeXRHQlVJZUwyUkhKL2EzZmNYRjhGQXRpQVFkZlJlSHpjRm16?=
 =?utf-8?B?bHQreTZZR2JaYkJxTWNJdzNGWU5wKzlINFBHNlRiVjlVczF4dWhLLytmbklu?=
 =?utf-8?B?aTFxVWsrRVZmaU8yY1dGQjc5cmMxT2dGalM3SllsVmlOMExMZUIwOXlsUTl6?=
 =?utf-8?B?Y203VW4xRXowZXNRMk9MSWQ5UzBHNjNFNlFMVU16ZWFMVVFITTdQYnFMbEUv?=
 =?utf-8?B?R0U2dE1uY0gxZi9CdWcwZkFMalZ6ak5kYjZtMzYzTzZNaUdURVFKVzNIUEFx?=
 =?utf-8?B?Zm5rVXpuTDYvSS9zYVJFNWlPNXh0QlVjMldCU3FveFNQazNwSDVkcm1mUVU1?=
 =?utf-8?B?ZWxWaGJuKzFGeUQ4OEU1Z29aaDMwbjV6dFhYOWZibDlnU1VEWDF1U0Y4b3NP?=
 =?utf-8?B?bFZwUFczdWNlcTVLbHhMdm10a3hnTTRvRS95akNwYWV4bUJQTU1pdzZVLzVS?=
 =?utf-8?B?YzEyN1ZsaVI4UmZWTytNZjVyREtCY0duZ2V6THVNUFVHWm90cVk4VmR0WFV4?=
 =?utf-8?B?cFNGbkJ5eURzL1pva1oyb3VEcHFlR0ZFU1IyUTh6V1pZRVJUYTZzdjZPc0JD?=
 =?utf-8?B?Szl0c2d2aE5tSWFPMlp3WWgxaU9odFE1cno3VmRhVCt3ZXl6ZzdkVGdBUHJF?=
 =?utf-8?B?VVI5ckdJSTdtcTJuanJ4d05KVFZLT1FyN1lFdDBjN2JFa0hWRUJBdjV1WmVx?=
 =?utf-8?B?eml5b1U2WGc4akpDNU1mWFdvOCt0am5UYmV0TmJ3WUlFWXIwT1BBN0t1dXVk?=
 =?utf-8?B?dHE0U29GOG1qc2ttK1QxSUpWUHQ2MGZUbnpRcEdBMWZ4eUFKbk1NNWd3a3h5?=
 =?utf-8?B?cFhIRFZzYTc1SmhONDRYL2dkOUE5OFZYWHN3dHJMWjVJd0xBRWh5RjhnWVpJ?=
 =?utf-8?B?MGxpN1Z2Qkp6dE1KWEpyVlc1SjFUMTFDZUczdXcvTHY2R2dreGk1dTNTNEpT?=
 =?utf-8?B?cVIzSXM3VmwrVlRqSDU5eVNxdzhQZDV2TlVMeHhYTXF5MkFybFdGT2dpdXdY?=
 =?utf-8?B?NnQvOENPM0NzaWxMMk5IamVFNDg2SEM0a1FOL0xKVzhsRHJKQVdwdHRDTEMz?=
 =?utf-8?B?ODZkelB1c1dPWk41Wml6NFpkTHNmU1BBSzNCd0tuSElCL0lhNDl0ZjJvVnlQ?=
 =?utf-8?B?Z3pNbjRLRDFvWWFtZHJNdXVjU1AzOVZHa2Q3UGxzd3BsaTI5UVVCS3NOME8z?=
 =?utf-8?B?WFIxT09ZSjNLMGkyOE1WNUxWY3ZFaVpQN1pBU2hzZDdiRUh3Qi8vL1F1NHdr?=
 =?utf-8?B?WGl3enBlWk9QemVMZnJMNFJ1ZE9SdDQ3NllYNm8zYVg0V1NNV29OMDBEOGM0?=
 =?utf-8?B?Z1AwZXF5OWdSV0pzRDFwUGJ4Ty9BL1cvWGIwcW1SY3BzL0srY2IxbXk1RU5Z?=
 =?utf-8?B?YXhTbGlUVWJLTXpCbmtxQ2EwdkpXMyt0VllCOEYvenNTeG9CUE5lS08rdW5s?=
 =?utf-8?B?ODN3eVJzU0NzVDJYZHp6M2p0U3FpNVNGa09hcXZOTzFnMkIvQmVkK3o2anY5?=
 =?utf-8?B?RmQ5VEsweXdRcFpQd1lSOEcyNW5GLzZvZndLY3hCZk9laldxTnlKSzQ2V3RY?=
 =?utf-8?B?ZkxEY0RJUmJzcnNjL25LNzlzT2RVVytaOWNQTVZGNkZ4b3hqUjRrSGRlMXQ0?=
 =?utf-8?B?SGU4Vjh3NmlYbGpVZ3NRRzNoZTREZ1cvYlhvUVpwd1Nkdnc1dzlhS014RnNU?=
 =?utf-8?B?dk9JckM5bGtRKy9Wa0tZTmdWWXVVaTVqZENVMloxODdiYWc3eWpqOW9aazlo?=
 =?utf-8?Q?GvoUG7fkE72+L7+8IA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enMrZnVPeW52bkpoUFFzaWNjNGZvZ053ZVVMeWMxazZsbW9WZU4zcXlZNnlo?=
 =?utf-8?B?SC96RFBwb0xDTUxEanA2Tk9rZkR6eUl2b3BGTEEvWHRhZzgwWFhhOU9IdENo?=
 =?utf-8?B?WUc3UE41K2tyUWQ1WmM5b2owVkVHSDdSTWJMSk1pZGVKUVhqZU56NS9KLzJr?=
 =?utf-8?B?MlVJZzg1R2R3ZHlQS0FyV1lwQjhNTHdSWlppVTVQRWFjOElZU2JTSEZKL2U2?=
 =?utf-8?B?cTFSMTJoZTc0UEZWS3NVakZsTDZZTEUybFlHV3c0WWZEQnpUMUdQYTJIWnNR?=
 =?utf-8?B?Tkt6b3pwVzcxVXFHcGU0ZnlLenMzR3pBZVN6Zmp0RW5EaVRodXJKaFprQUxO?=
 =?utf-8?B?ZDFmMFFtMVVpQW8vUmpXdElYUjZMSkwveE80eDlTQnB1UHBiMys0SzhhLy9C?=
 =?utf-8?B?c2RvTDF3SmRlRXhjLzRiRkV4OVRpN3RxTjJFZlhlRDZlcGRES1k5Wms3a0Jz?=
 =?utf-8?B?eVNkODNVYUNFQ25GOHRwNGdrVk9uQzZQSVVvWkV5TXExQUpuOThHRk9RQmc2?=
 =?utf-8?B?dUNHamxyaFFJL1VrUjh0TW5TVjJDMGl2bkNtLzgrL3NHTU1mZjMxQytzMkdp?=
 =?utf-8?B?TDdiQUp5SlJodzRveE44YmJmNnZkUE1lTUF2Vlh2YS95Q1dDMDF2K09XUlkr?=
 =?utf-8?B?N2d1SStlUTF4WEJqMXFXclpHa0dtcHhvdlJ6V2diaTNacTdlYmdHZDFYdm1q?=
 =?utf-8?B?WmFmRmoxcnJ0UWRzSEtnL0M0RzVrZ1EzTzBkTjlkU3B3TGNXR2pRMkNYZmU1?=
 =?utf-8?B?M2hqMW1OejFvL045ekRlVm9meUhwZjZnV3A3UHkvTzNEaXFPWDI5eWkweldF?=
 =?utf-8?B?NzIrd3RtY1U3czNGRy9rSXFNckVhZDEzQXdtTmwrNStxdUkvdmZsZUZtTXlY?=
 =?utf-8?B?U0J3WVhGYmlQVGNnWDI3ME1LdjFKMEUwSDQzZ3lPdVRVR3lwMDd0QmtwdU9w?=
 =?utf-8?B?aTU1NkdpZlhkZzhlUHZuQUVMWFlIM0dXMU15SnpLWktRRmRtNVE4bEliYVBN?=
 =?utf-8?B?T1l2QVY2Y2lsM1Bzb3lkYUdMUENTbTB5OFplaFY4Q2kwWVBRRVRvNHI5Wjcw?=
 =?utf-8?B?V2xmaGI5TjB4WklQTElOWDhhZE1nU25IaWVUU3dRNXBMSlZUMVU0K2lQK1Bx?=
 =?utf-8?B?YVRrL0ltSnFka2pIRVRGdlJYOFdkYWdKb1pHQVFTVWMzOUw0VXliWmFmdzlu?=
 =?utf-8?B?VVo2aVpZc1lPMEpRRGJ3V2tkTHBCMGdScHRhTGZHdm5sTlhScHVoS2VZMmNz?=
 =?utf-8?B?VGt1MFFrMERyd0JjWFNKbmpub0MrS0hEbG5nOVdGcVpLT29waWVleS9uU0RP?=
 =?utf-8?B?TUhoQWRQdGxHMUpUQVRqdHFHQXpGaTRZVGNBbWxCcmh3Z3BWUWZmcFppbGJr?=
 =?utf-8?B?ajBiK0gyTUdaNXFMUVF6Z0U5QlZ0YXgwZkJtTktuZG1EMWxxWjdKZjU4dzBT?=
 =?utf-8?B?OFNvZDdDYng0Z3BWdWZ5ald2cjAybVl1SXhndEhYOGUvb0t6RGRmYW15blZw?=
 =?utf-8?B?L29DbEdESUtKMUl3bCtnVkVrRlMrcFVleVBrbm5JOERCZnA3TXVsRTliMElS?=
 =?utf-8?B?RnNhN1MxZ0dCeHlGY0FIT1ZaWEdwakdXOVpHTkVvcDgramZwQ1pjcXZjOC8v?=
 =?utf-8?B?bEVteURKYW9DbHVJVHliVFZndUpLODZSTnRBbW81VjdWc29TRFVVbzZWSWVH?=
 =?utf-8?B?bDVCUDRzUFRubjFKZURhcEpxYWZLZDlNWkFYeHdyeEpEMTU1UXJScldGTWVQ?=
 =?utf-8?B?a1hBdU1xU056Vk5RNHoyZ1doNFl1RWE3Sm1ObW9tano1eUR1UWNoQVo1MFE1?=
 =?utf-8?B?Nmc4bG1WWUpWZFpmU1hPYjBHdWlGdkRoeHZPWUZqZUcxekhOenl2aXdmNi8y?=
 =?utf-8?B?OFhXOWhLZEJjYUVlQjE3TENRSEhzeWZBYkRCOUNvd2ttT3Z1V1dNMEtoWE5T?=
 =?utf-8?B?NmIwcDgzam5iZFlPV0dLLzYxUkxqdmE0NDlLcVRoMDJSUllTWkx6ak8wN1ha?=
 =?utf-8?B?K0ZuMDFldVF4YTVDbWpHbXJETHZGV2RkTm1ZK1BZTmNWazB2MjNWaXBEMVhC?=
 =?utf-8?B?RDEwZzY3SUVoM05pUUpQQ2F5TXhzSjF1QWNZelBvSUV3UlF5TjdRemRHL2NY?=
 =?utf-8?B?MHpSem9PcEI2ckhXZ0pGd1R0eWZydW16MzQ3aFFRVmFMUTExNVV6YzhHUGU5?=
 =?utf-8?Q?OyY16QDROBONpqATrDCFd68=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8c120d-3b71-44f5-bbcc-08dc976ec346
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 12:35:15.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkgT+lhKizR5nIy1ksO9f3PUpj9pvx2F307qc2CaxQvaADkiujTaV9oMrT9oTxmjJ7R41QfVCy6q8ZASef5iSoJHKvpYni/pHFgVNG42GVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-OriginatorOrg: intel.com

On 6/27/24 20:55, Jakub Kicinski wrote:
> This implements what I was describing in [1]. When writing a test
> author can schedule cleanup / undo actions right after the creation
> completes, eg:
> 
>    cmd("touch /tmp/file")
>    defer(cmd, "rm /tmp/file")
> 
> defer() takes the function name as first argument, and the rest are
> arguments for that function. defer()red functions are called in
> inverse order after test exits. It's also possible to capture them
> and execute earlier (in which case they get automatically de-queued).
> 
>    undo = defer(cmd, "rm /tmp/file")
>    # ... some unsafe code ...
>    undo.exec()
> 
> As a nice safety all exceptions from defer()ed calls are captured,
> printed, and ignored (they do make the test fail, however).
> This addresses the common problem of exceptions in cleanup paths
> often being unhandled, leading to potential leaks.
> 
> There is a global action queue, flushed by ksft_run(). We could support
> function level defers too, I guess, but there's no immediate need..
> 
> Link: https://lore.kernel.org/all/877cedb2ki.fsf@nvidia.com/ # [1]
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - split refactor to previous patch
>   - user bare except instead of except Exception
>   - rename _exec() -> exec_only() and use in flush
>   - reorder queue removal vs calling callback
>   - add print to indicate ID of failed callback
>   - remove the state flags
> ---
>   tools/testing/selftests/net/lib/py/ksft.py  | 21 +++++++++++++
>   tools/testing/selftests/net/lib/py/utils.py | 34 +++++++++++++++++++++
>   2 files changed, 55 insertions(+)
> 

nice improvement!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

