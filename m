Return-Path: <netdev+bounces-300985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UkDmBAnvOGoakQcAu9opvQ
	(envelope-from <netdev+bounces-300985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:15:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 779716AD9A8
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:15:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lCRRZNvq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300985-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300985-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD8E73008D3F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1B38E8C7;
	Mon, 22 Jun 2026 08:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF938E8C9;
	Mon, 22 Jun 2026 08:08:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115720; cv=fail; b=UcSNo/ib/aeKVma9Owb3ncCaIl7XIAzhUetabRvGg30V6UMr32WL5YcFu06+MCOL4+jHuP5x5PVe+vkys7Esl7sO5b0VygaIDu4fHy2hU/42pIlldD7c1/APwIz2rTMRQJv0JvcquVmxnxTM2PKpVdAUrqyb36bkqt8V0Q2fi7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115720; c=relaxed/simple;
	bh=8QoRVtZvDadrXhjsXgWDvC03XYocRGf/rPuHSxsyS/4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iEvBR1HKWFhNdcaGXB5UOqgQN8P/QPr0chcdKT5/6ejXQg0voR9bF/0xLi6KX1GIJMeKC03rLpVKxvndoecnXAfxifbwkhKkwPSHFfwldcKTCugEfHbQ65drT8NspX2rZ8v8gnZD20mbuSuShj6KN6EW+Lg9pgyIrdfa0wIseQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCRRZNvq; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782115719; x=1813651719;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8QoRVtZvDadrXhjsXgWDvC03XYocRGf/rPuHSxsyS/4=;
  b=lCRRZNvqbvcf9SXNkenu/r0fdW5g60W2CZ4Dk03R0owaNByHNiCCiqsz
   CdJ9bCknm9227iYx/7l/0kNQ8nqs3gGaG518gHRCmM5Flx9Rds3caqoeY
   iixyBr1HrOU7GIJqnzMmvSFQvG8j7ANuEUivlLxFKpnWtUWz2xCQeR/F4
   7LvcL/91QGN1yEq29O1OLf2kWpERJAaJXsyb14BZYmm+h3zK3TMSAEdeI
   /aGdlbOorqmP0ok8GxqOH4z2C/vLbVxqwrgat0CFhBJUU7a9btBIFNxPh
   zGYZyMYLOYE1UCTOWeWRBD9sq7AbaQSwyqbE+PoEtpLg1vOSQ5Eh2Ykyy
   Q==;
X-CSE-ConnectionGUID: /DOZM2FHSMCf4FGJaqiT+w==
X-CSE-MsgGUID: UCwUHKhySYeY0WzEGHXv3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82848156"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82848156"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 01:08:39 -0700
X-CSE-ConnectionGUID: im4cyBSYQq6NnhfFLcMOQw==
X-CSE-MsgGUID: Ko/h47gdT4OlCMqnSQ5FOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="287280861"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 01:08:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 01:08:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 01:08:37 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 01:08:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dl1useCYIYyyMBSRpRvO5gZJk+khjGRdkP1k1gzGkgcxPEk31K3b06COigKfFFHP2vH4reFudUqGUIX7pAh4NTV/H5d3yCV82lE/vM79SHTzKmCGyPU6dZ9KAd7S1luCK+NJ8uYKH4Cfvf1Re/zifSSNVRpQWfIRQ05x4aVT5G4CQ4kA72r6qOwiuW2cVdgzrbymdUY+2x/4Xlq/oV+ws+L9eQEOYNOMF/jtktf9ksDWXMfZVw0t10u6Pe1c7pKv1LhwOxoxH/2THWZTOlTGz4EqQ7QdUS8YrJoCDcVWCEbHWTKOibonmPrkHLoYccxwVVCcAdQSf2x+2YJPcraTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4mXmNoYu92lik/0/yVuqzDibaXb/zIp+hGR/I5EBrI=;
 b=gWEkhsaJKH3YuRDhB24sVSGBFri42Lb1rzzRbidAeIArtCOCgeAbGqBrUKMUHSV0B4PeocCboXW84TrC/tMSyG4Z0+/9GPvwa/dPYo83DgbceoSMc+MlMIli4kwfjFjY/ajHvRhj8WAxdh5R1HlsIUQO0f2UTxjcUrDR8Y2u5jM4MYUSKj8aZM+KORW5fVH6I3mxDn0O3ByvwFw7JnqrydheL3QEk/92RCbDqo/jIu5q5RTC9rKCDhMfw0L/fxaLyQ6F+B/0nYFMXkiL+fbKOv5Jhloxh+YCMttD+XFTe44KpKS9CsKu5600WleLgtZi2kCz59nyXgexVps2I/AbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:08:34 +0000
Received: from SA1PR11MB8448.namprd11.prod.outlook.com
 ([fe80::38f:6a4:ce6b:d5b8]) by SA1PR11MB8448.namprd11.prod.outlook.com
 ([fe80::38f:6a4:ce6b:d5b8%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 08:08:34 +0000
Message-ID: <1bd437e4-d1d3-4fd3-8e5a-5e1148ad9686@intel.com>
Date: Mon, 22 Jun 2026 11:08:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 2/4] igc: move
 autoneg-enabled settings into igc_handle_autoneg_enabled()
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, KhaiWenTan
	<khai.wen.tan@linux.intel.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <faizal.abdul.rahim@intel.com>,
	<hong.aun.looi@intel.com>, <hector.blanco.alcaine@intel.com>,
	<khai.wen.tan@intel.com>, Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
 <20260507214706.309984-3-khai.wen.tan@linux.intel.com>
 <4d8d9eaa-d9bb-4589-a37d-31d0da584335@intel.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <4d8d9eaa-d9bb-4589-a37d-31d0da584335@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8448:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fa63b6-8dc7-4786-04cb-08ded0357484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|921020|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: nyTMLfOIlMFNs8uYHisixFiY3QnlPGbf/RXQPtqUmNLZA1+Z1jgfWX5guNzbaByWl6sk6XbsXPcbtZB9EoeBL0jcUPvfJaWDHiKVasSfarAqk8dYabxl90RsbPm4KaJjc2qM73BcPp0mGVIMwXkczDPsjeOqw0IfylpzQN9u0Z8NFhJtqRobrmdPgFSG/+Jz5BB9lIKdg9oozrOTSmc/VtkUdQER1c3NO9+ZMLNC8zqhnyUV4inc1x6Xt7SOqPDunuyNepy6we2QfR661iFcqE0SBS0mI79TM/Vtcgnahfp7DEAxAna9+4wb3pC2rYeXbe+VfIEIQ5CunnEVQR85gYt4A3MRSnf/G321A1KmPThbmhYz/tru942UvacKur93igG3hMroAcwTuTeOA4zCfyHliH3diva8bFNSaQcAXUW/8fep9ifgFuoZfG7D8aVSart1FrWXGrHjZ/CSgC6jN0sjUqTnH54EE3nhLe/cphmS+fCSAEyKJTCr1ftFwAWPp1+9MM5eRAb590F8tl//iwkL5O0xU0v5zqVypUB9rKOU1lymlaSAZSFQ7FQdlC7WOpjj1MB9YVnTLitGm1om6WKc51Fl163pyn8p9ZfdSC1PDgh+yUYIgM4/od2A0UWFsO9z43Az21fAKpZloh7U6gL65vN26ejQxUGnrf26ZVC4Eft+w9CTT0SpNVUzOIixnk9HOw3ZoduYYKbMLNLT0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDdITzlOVGNiVzlTWHY1MmdlNGJOZUozVlN3L1JOUEI5SlE0ZzdlY1NPbUJC?=
 =?utf-8?B?V0xJSWlGcjJkdTZGMStRN1loSk5jdE1CWXl0ZGo5SEs3MGNjL1R6eWJGMmJI?=
 =?utf-8?B?YmE5T3hUK3k5MlNsTERBd1VySElUbEZBclptaFJPWHJCd3cxdFRtWkRPU2Yx?=
 =?utf-8?B?NU02am52ZUR3M1ZPdncwRzJjQzR1OGFyeU1aekZ3L0FMSW5rSW9xZ2tuN09B?=
 =?utf-8?B?eXlvQ0hNS1NIdGtBVlJLbGZubEZGUWhUZlZ6MTNheHZPb0tyYXFpSXhScXg1?=
 =?utf-8?B?MHJOWW9DZGlxWlpITmdDdFFQVHBBcUxjYmZTU3J5dFhQd3IrenRCWU5FU040?=
 =?utf-8?B?SU9nbUdKWEZFOVN5ZS9YM3VZSXRPdnVoZ255SGM3YVdlUEhPU0FNcFFCMndT?=
 =?utf-8?B?UUdvb3ptVnZzQkZ4NElNNERraFlFbVJEOFRVQXlRL0J1L3FCOVhSSFo5UmRE?=
 =?utf-8?B?MEhaaGR6VG44c3UzT3BCSG5yKyt5MVdrVDd1WWVyeisydVJJRjNuVlNscTlq?=
 =?utf-8?B?WjVwNXZhV2E4Q0lmRHd6WEc4ejFPMS9lSlRSa1dhMU44QkJkSEFUU3l3cDB3?=
 =?utf-8?B?UWlEcjI3ZmppVmZ3RDhHQXRZRmFnMGYxL3dCZzNmd0o1c1hBbWRYWjFCdi9l?=
 =?utf-8?B?L2pJTC8yTlV4d1NoU1pqeER2a2FrUktzUDh0Z21JM2dFN3NqNXJtemxhem5W?=
 =?utf-8?B?TlFnU002aW1WU0p2UDNpSUNkUFpyTSsrbmFJNWlpMnQ5Nk1xUDNqT2xJa2VR?=
 =?utf-8?B?L2pwS0ZyQ1J3S1NjcDl2a2w3cjJhSUVKd0d4b1dLZ2c1Uk1Qc2NYYzJhdVZo?=
 =?utf-8?B?R3BvOGIydURneWVRRWpwN1UvblNha1Uyd2o0Z3pIcnJibWcxQnRmdUwxdUFM?=
 =?utf-8?B?NmRqMlVONEIzSUFDTENiTlNPSHlSblZFYTh3YmgxcEdMbENQYWJ5U3RneWsw?=
 =?utf-8?B?TFJ0T2wrRFN4eCtKcFhGc043alc3Y2xPRXV0ckYvd2NvNWNFNmFsRmdQOHVa?=
 =?utf-8?B?Q25vbGNzKzNIUjk4WXBvWkRrbUgvQy9waFByTDJNZGd5dUxzSEVSNWRrVzdj?=
 =?utf-8?B?SjhaaHluSzdpUTkvT2pDY1g1RmVOUnVnQk01Y3JTQ0xFdXYwSk5VWnFVcTRJ?=
 =?utf-8?B?VkxPUjVnbEc5cXk0akRoRHhKOXNuTzd6ODNiSDZvVmNsS2VPQmR2L3ZPLzY0?=
 =?utf-8?B?OVZ6VUNqc200U2tzbUpUWCtKSUJHcW9QNHRKem1ORGJ3ZDhvWGFmc3NkM21T?=
 =?utf-8?B?M01TamJLVXJhTU1UN3BoNTRtdmtqazduWEJ4QlhLM1oyMUVRZnFuS2s4YlAy?=
 =?utf-8?B?VHN1WmRCeWxaOWc3NlFjR2Q5dGxhZ09WV1VRNUJ1RC9LVk1jeHZFcFJVQUIr?=
 =?utf-8?B?NFFQZFZ1Nit0bERrTGVpTEhUYWZYWjVrWkd3MFhwRGZ6bG5Xdzltc2VmT3JD?=
 =?utf-8?B?TzZiSzkrZzJtam00NitLNWg4aUF1TC8veDMzWVYxcExYN3UrL0xXQUkzMUJ1?=
 =?utf-8?B?cXcyMGc3Y2xkRFdReFcvTEw2UGJpNWtiOWhJd2lCUStCZnNtU05CMzZkRVBO?=
 =?utf-8?B?aDRDUVhEZjFnenBhL2hXVUI5TmFGeXZtaVE1eVJIRHk1Q2plZzR5TU5pVGIv?=
 =?utf-8?B?akxDSVNWQU42NWFtTVgvUHFiQkdRUHpmblB1QWxrbUpzWHFqdE5yVHh6cVh2?=
 =?utf-8?B?dXBrN1hYRDRFSFRqNjRwWjFkeHN2ajJQZXVvc0ZCaFVEejVsQ1JNTUZ6TUwz?=
 =?utf-8?B?MFQwWUczSURQMnJvM0lWNXdUVG1JVER3RlpEQUJNNlV2WVE0WElJMlBxR1JN?=
 =?utf-8?B?eEdaR0Z1eDU0NE1iZktIUjNxTy8zWnR0NjM4SDQ4c2dQeG9OUHYya2FkM1RB?=
 =?utf-8?B?N3RhNUsxSEpTZmhMYU1OTUVXeGhlSVBUaGJ5NDdxd3NRSEF0QjZ1emh2d1hw?=
 =?utf-8?B?MGFZRmJ5VnlzcUtscll4ZEc2YktzbEVsRDZQcnR2WHRNRUZKTUliSjluVlV6?=
 =?utf-8?B?a1YxUDZtODVBeUJWcE5FajNGdEhoYmZwbDNHZ01UazBMWVp5Rk5wb3ROcTlp?=
 =?utf-8?B?QUNxQ0VGOEIvSDBYR0tqZU1zZjlVajZvQ3ZWOVdITWh3c1hmM1hjNHpPSGh5?=
 =?utf-8?B?V0pmN09rM3gxSG5CMFF1OVQwWk5QNFdHamR4aFMyZm9rS3VNaUIxZmFxaTAx?=
 =?utf-8?B?eUFwcW5BSE0vOFkxNUdQUFlvNXkybmpLMXFKZHc0dTVMY09nSzJTOTh5QXF2?=
 =?utf-8?B?Z1huMnNZU09RSjIvU04ybnk2RElWdW1jQXpIdVRjdWJPY1oreFByTzl2SnMr?=
 =?utf-8?B?RXB6aVZjaXlQMFFIeUdUR1RsRmM5NUIxUzBjNjB5LzVablFBWWwyRWVpK1lD?=
 =?utf-8?Q?j/i6nMyLlFr6eMWk=3D?=
X-Exchange-RoutingPolicyChecked: b8xh/4dtS9QF8tZRXjRKXk8otHkphzHAO0NapZldFQEAJrMDih7ncyHZ2AAFu/TbHZYtU6UBwW+ZAtpzzFKsfEKDm1LgRwU2hlYNrsmp1wHTML5qBWfnY3maBFqzTsZ7tc50iJ9W6rg1Ozij34uDtkLaV69RAVDVC0qA5H+DZqZxC+EKNVuWFdT+ikWQa+W3BRWi/1jRlxs11D1pptV2tn0g3pARAUObbXlPEs0fmQwI/fyuB2zy/0iv3+odqpfrREBq4OOAlji5YUCgToNha+5RLVzb4HhcCIKGIn6FHi80E4PPIyaNXFIGRRZGCYrRUEWJLFbudkjytHpRKqP6PA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fa63b6-8dc7-4786-04cb-08ded0357484
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:08:34.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KRajQoMTu2hxdACXREhS+RJvGnYggRiJyw5qNiWvZ/H3RdLZ1MI0Zo5jfO3tCgmJ+D/OIGL1gJbK8MvnHm96Ci2MGtSxN/qOvx2BKUpnqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-300985-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dima.ruinskiy@intel.com,m:khai.wen.tan@linux.intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:faizal.abdul.rahim@intel.com,m:hong.aun.looi@intel.com,m:hector.blanco.alcaine@intel.com,m:khai.wen.tan@intel.com,m:faizal.abdul.rahim@linux.intel.com,m:aleksandr.loktionov@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[moriyax.kadosh@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moriyax.kadosh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 779716AD9A8



On 14/06/2026 10:17, Ruinskiy, Dima wrote:
> On 08/05/2026 0:47, KhaiWenTan wrote:
>> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>
>> Move the advertised link modes and flow control configuration from
>> igc_ethtool_set_link_ksettings() into igc_handle_autoneg_enabled().
>>
>> No functional change.
>>
>> Reviewed-by: Looi Hong Aun <hong.aun.looi@intel.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> Signed-off-by: Khai Wen Tan <khai.wen.tan@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 72 ++++++++++++--------
>>   1 file changed, 44 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/ 
>> net/ethernet/intel/igc/igc_ethtool.c
>> index 0122009bedd0..cfcbf2fdad6e 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -2000,6 +2000,49 @@ static int 
>> igc_ethtool_get_link_ksettings(struct net_device *netdev,
>>       return 0;
>>   }
>> +/**
>> + * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
>> + * @adapter: private driver structure
>> + * @cmd: ethtool link ksettings from user
>> + *
>> + * Records advertised speeds and flow control settings when autoneg
>> + * is enabled.
>> + */
>> +static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
>> +                       const struct ethtool_link_ksettings *cmd)
>> +{
>> +    struct igc_hw *hw = &adapter->hw;
>> +    u16 advertised = 0;
>> +
>> +    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> +                          2500baseT_Full))
>> +        advertised |= ADVERTISE_2500_FULL;
>> +
>> +    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> +                          1000baseT_Full))
>> +        advertised |= ADVERTISE_1000_FULL;
>> +
>> +    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> +                          100baseT_Full))
>> +        advertised |= ADVERTISE_100_FULL;
>> +
>> +    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> +                          100baseT_Half))
>> +        advertised |= ADVERTISE_100_HALF;
>> +
>> +    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> +                          10baseT_Full))
>> +        advertised |= ADVERTISE_10_FULL;
>> +
>> +    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> +                          10baseT_Half))
>> +        advertised |= ADVERTISE_10_HALF;
>> +
>> +    hw->phy.autoneg_advertised = advertised;
>> +    if (adapter->fc_autoneg)
>> +        hw->fc.requested_mode = igc_fc_default;
>> +}
>> +
>>   static int
>>   igc_ethtool_set_link_ksettings(struct net_device *netdev,
>>                      const struct ethtool_link_ksettings *cmd)
>> @@ -2007,7 +2050,6 @@ igc_ethtool_set_link_ksettings(struct net_device 
>> *netdev,
>>       struct igc_adapter *adapter = netdev_priv(netdev);
>>       struct net_device *dev = adapter->netdev;
>>       struct igc_hw *hw = &adapter->hw;
>> -    u16 advertised = 0;
>>       /* When adapter in resetting mode, autoneg/speed/duplex
>>        * cannot be changed
>> @@ -2032,34 +2074,8 @@ igc_ethtool_set_link_ksettings(struct 
>> net_device *netdev,
>>       while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>>           usleep_range(1000, 2000);
>> -    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> -                          2500baseT_Full))
>> -        advertised |= ADVERTISE_2500_FULL;
>> -
>> -    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> -                          1000baseT_Full))
>> -        advertised |= ADVERTISE_1000_FULL;
>> -
>> -    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> -                          100baseT_Full))
>> -        advertised |= ADVERTISE_100_FULL;
>> -
>> -    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> -                          100baseT_Half))
>> -        advertised |= ADVERTISE_100_HALF;
>> -
>> -    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> -                          10baseT_Full))
>> -        advertised |= ADVERTISE_10_FULL;
>> -
>> -    if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> -                          10baseT_Half))
>> -        advertised |= ADVERTISE_10_HALF;
>> -
>>       if (cmd->base.autoneg == AUTONEG_ENABLE) {
>> -        hw->phy.autoneg_advertised = advertised;
>> -        if (adapter->fc_autoneg)
>> -            hw->fc.requested_mode = igc_fc_default;
>> +        igc_handle_autoneg_enabled(adapter, cmd);
>>       } else {
>>           netdev_info(dev, "Force mode currently not supported\n");
>>       }
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>

