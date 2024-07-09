Return-Path: <netdev+bounces-110174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06EB92B353
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A5F282E25
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC797152796;
	Tue,  9 Jul 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FySw4aYi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74C146016;
	Tue,  9 Jul 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516306; cv=fail; b=DbfzUhC72XEQxcV/kTEol2cx/pCi8Il6tOoKizzF9KdC4MBQO5Hsy+Q4UMvV1jBKZsZqJHPECO/GYiIgY7tSzKk/3Yf2q8T3D9RJe7mLmNC6RyVIy2dRnotmaKPWRmGq9/mp96m2xsEpyIo4Ca8P9XlsIa9eM8ONNQjAd0KpNho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516306; c=relaxed/simple;
	bh=wHzr5rd6PN/VMcPkB0j9FzybuRYtnnSiSQ8krISy/bs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BuvoQmiAu7SqKDUtqgvBBtEJf9+n4SpzjrLQ2aZ8f+xA7o5N/s52/IFTIzlflIfB48Jh3o5cxrjSIwSry4diTUV/zWNRar5n5ZSpy0PxPDfelIC1n0SU12jAV4C8W/jGelV6YkOnh5LkvGTEsdM7wBdTgS6JV85UBmZtVk7moQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FySw4aYi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720516305; x=1752052305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wHzr5rd6PN/VMcPkB0j9FzybuRYtnnSiSQ8krISy/bs=;
  b=FySw4aYit+gBP+/HEPYmda5e84OStluzI+eWJRuB2CJehxcvnCGJXKvo
   +rU3039U1A0S3L9ihvs6795jksuJcR/K65xrDwL1uxnEompev8yk89IM+
   7iZlFzsRQRrNLJzBnGz6WWN+VhBtIC8bIsqGu04/qpRT6yCrLs+c0VHkC
   sHpqR8bpKe1crg0bHw4dkbcRXzfhT/cjE9KhjzZPNXO4uzVn7NM1syHXy
   9CHT68T2qgfuySRll2a5uVPkOOqbmlewd/U4Tmn+mY55bmEJqjwS5DZCD
   XMJP/vekTfcN/KN0/BgPlWakGq3dOLyS7x3++pD3hE+6viOQvl9tTVaW3
   A==;
X-CSE-ConnectionGUID: 9h59Q0JxRtSDSaIvSU4y9A==
X-CSE-MsgGUID: hlxr2pNOReqSSHDoDLxgLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="35192782"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="35192782"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 02:11:45 -0700
X-CSE-ConnectionGUID: 9enXsxXIS+iZS6Lvv41pnA==
X-CSE-MsgGUID: CMPwO2KxSAGzhPQ3QTgFkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="52599672"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 02:11:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 02:11:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 02:11:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 02:11:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 02:11:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfIZcYN+2OI6ssQbFSzLA7w/85DvQPLLb6Hqo3MqBHvP+cafWpMWLDL4JnWqBQJwezOBcty8bidOCsMgARxrHZlXm7/SJ7LYWvIwa5dURb+28f+gjctQ1M8LVevRlwlO1dWUsqm14VCDe87kEIS/qf2ZRhfFKuAsZla8zXy31PsrIR4zWq5BPUg5rrG6qE5lEcqQNn2QG8Fdd+gC8I843yrStAWrNENNRNAPeJ7rO1uWJhBvnIogheEULspMJxhCVuHMl+Tf1b8e97+pWHfX1df6d2I/qhlRrnpULjSqboCO/Gve6ACz+TfrzwW+vr7ElJkgFzBkWxWWT6u/mJpffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/dIyaekBJcya+/dVyFL95rx0i/xKMV7ErJ/3LrMoIc=;
 b=a1q2lDSLzmP2CMUSqlqDzjz3K24mQXcAxAoVxOil0IZnxGjkOJElyYT+okES5ELKSJpDu9Devh16ISHxOZZor2vffTn52tbgx9BaVuWHxjkwLixuTne+QnnN9RqsHii8sNFfsAZ6Yl+hfGNnRhYcBVdb9/Bk6lT7xU93rwilehNCwQm5hWJdQ6cwrr6fGgL6pd8dK9DDqSFxqxsZQL3BbgIRSQbI/gEV0YTrDGZUB2/OKykDnfJiYvZSTRpRDjcc9uXvaT5g7U6NGN5QMP6cDVgnFa6XOkqjPFoheeKLb1ASg3FTxEREW9h2jGxy1z/jYjjJqEOyP23nf4zf2h5oLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB6321.namprd11.prod.outlook.com (2603:10b6:208:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 09:11:38 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:11:38 +0000
Message-ID: <190d0cdc-d6de-4526-b235-91b25b50c905@intel.com>
Date: Tue, 9 Jul 2024 11:11:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] ice: Adjust over allocation
 of memory in ice_sched_add_root_node() and ice_sched_add_node()
To: Paul Menzel <pmenzel@molgen.mpg.de>, Aleksandr Mishin <amishin@t-argos.ru>
CC: <lvc-project@linuxtesting.org>, Eric Dumazet <edumazet@google.com>,
	<linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20240708182736.8514-1-amishin@t-argos.ru>
 <033111e2-e743-4523-8c4f-7d5f1c801e65@molgen.mpg.de>
 <23d2e91c-4215-4ea5-8b3c-4dd58a1062af@molgen.mpg.de>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <23d2e91c-4215-4ea5-8b3c-4dd58a1062af@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0091.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e34143-82e6-4b37-fed1-08dc9ff72356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlFyNWRodXpIVnlER3hKRHU5Wld0WGJPTWFvMWVjdkNwYldVbGQyL2RyT3ZN?=
 =?utf-8?B?SkkvS3J2L0tIcVFEVWgzSm9VYklxSlBtQzhGaitNK0ZGaUs4bGpmcklFcnM2?=
 =?utf-8?B?K2JvTmI4ZzJWVkYvY1M5ZlMvRVREY0U0Qm82emZTSlc4VkIrNktVYXVRektO?=
 =?utf-8?B?VVRzRWV4ZEkzUGZJRjB2YkJuak56NmR1V2h4cWp1T1ZUemFpdCtIS1dPdjYr?=
 =?utf-8?B?UUxmVXNFS0dWV25zcTFjenhmVFZqZ09sa0dHQm40RVA2UU1ONFM3cU15ZC8r?=
 =?utf-8?B?YTRCbFBSVTI0UkJkU1pOMkJDUkdERTNzUEJZTHE3WEN6WW1HOHhZVnBmMldh?=
 =?utf-8?B?ZnR6UXp6aFFidURCcUg2MDJZLzdUbWJRU2lzUWV2aVBIMWFSM2YvemRFVmVT?=
 =?utf-8?B?VDJaV3NlV3RkaGg1WnlJQ2JGUUcrZ1BRQnBUNzcyUmRiOXRQcmNWZ1kyckVn?=
 =?utf-8?B?OHJhN1I1Y08xS2NPZk5XOVN6RzUrbkdlZnY2SjI1cWVrckdlOGNyNXpIT2J1?=
 =?utf-8?B?S1pzRmYrSWxxZ0ZuM3E1KzhJT2srNUVoK2NlOE43akFKN1h2WXZaM0pzMitC?=
 =?utf-8?B?N0VOSENXcGxQWUdzNm9YcXFPRWhDSFIzMDJLei9HU2RPSG9zSWovVDFlWmpR?=
 =?utf-8?B?VU02aXRGN1dRZFRLOUs5eDhQcVI4MWxDVjZKMWxIaTBZdndPQ1NBUGdlRTN0?=
 =?utf-8?B?TmtvcUFZM041UERERVFCTEVpRUN4V0pNOWJqMW4xZDlma01Hd3U4bDN3eUsr?=
 =?utf-8?B?NHhzblIydUtlYkhyd3FMdjdyc1VwZUFneTdwM0FyTWpmVlRvclRuUndGU2Vq?=
 =?utf-8?B?YmR1U1RSMVdMYnBNUkgwZGpRZ3ltR2ZkVGxVc2tFRE1KZFJrSmFMT1FIemMz?=
 =?utf-8?B?UXo5RE05eEVOcEM3NS8xN0dLVDZtNHVObWEzN0c0T0d1QVJySEdsckttS2M0?=
 =?utf-8?B?WlBRMnMvYUFIeHRGZlZUM0JzWFNzMUs3N1ZqRjEyc0ZlZ2Qyc1MyL01KM3d5?=
 =?utf-8?B?bVpEU204VTRwWGtDc3c2NTBrK29USjczelhKdFlmbktYSTVxNU1rVGxJc0FJ?=
 =?utf-8?B?ek1OUG1VV2tqLzgzZWM2N2VqbG0zS0diSWpTdlZPQ2ZlRktJV1ViZWUrRmtZ?=
 =?utf-8?B?NHpwMjQ0cTVpSnorNEFnbm5zZStFNHNvYWhOSjFaWmxIU1JnWEJ0NCtnbXlm?=
 =?utf-8?B?dGhOOEpZNlZOVStGZWl5dFh5NkttUHpZT1grU1hzMFJSZjZPTFFQMFpERmdj?=
 =?utf-8?B?YmRsM1Boby91TWRsVFUwcCtmc2k1SUlVMEltUjUvS29YQXYzZEVzK0dsdUVx?=
 =?utf-8?B?eXg2UjRkekRneVN1VGp6ay82QW5LQ05RbTFIQzdyL3h4dzNUZFF4dFBYQml3?=
 =?utf-8?B?QnAvT2k4aTBwZFpzdUxsemtLakFNT3RLZU0yd2hCWUR0QlhCamdpM1cwVkF0?=
 =?utf-8?B?bkRLbDE3TFVzMDVGRXFMZnJxUVUwY2o5Q056NWRMWENrSUdRbDl5K1B1UE9I?=
 =?utf-8?B?Q1BRc0NsalovM3VTSUovYXhsanA5SGVsVy9ZOUUzZXlyd1h0QVRsU0MrREt2?=
 =?utf-8?B?eUJHM2hBek5vb0FwaVplL2JzQmpNTGlZRzNSd3NybnJkNnBjaVhBbmswTFhM?=
 =?utf-8?B?MS9NY2FHQWhsbzJGUnZ2bjJEUDVWY2x5MDNWT2RxVTB1TkFKeWtQU3lPQmVr?=
 =?utf-8?B?VDI1aldQbTZ0aFdpaGpLOFpJZkVncDZWZDNpL0FOUUwvSG1wY3RjakdhUzVq?=
 =?utf-8?B?Vm5rYXppUVBZWWhES0JERVpvN0liNTFad0pJeXVtQUlFWnlXc0gvbmxXZjdM?=
 =?utf-8?B?OUpmSDlaRjNkV0llVW41UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVlOaDVWZ1dMY3FkSlp3TjlZcFlQK09UUmhzVmc5RENCcjFVUTQ3SzdKSTRz?=
 =?utf-8?B?bjV0bnlaRjNEc1lVRTd1SVFWOFVSMWhpSU42M2ZRbkEwVWoyb2NTV3RoTjhV?=
 =?utf-8?B?VXFxZnljdXRpTVZISUlqemZ6K2R0cnZzQUdjaUFMb1BVWU1RbzIrZmlZdE04?=
 =?utf-8?B?Nk1tT1lwdGZaT2xWcHorVUcwTEdnVnJ2R1VuYXpjVXZaRVpsVjVHbGlha0s3?=
 =?utf-8?B?N2pNaHBlejA3UWxnbzA4MmV5VEFHSUgxWUxBTEhEaEpGSWZoYkpMUFJEMUlQ?=
 =?utf-8?B?VmIwcDdLc1VYRWFJQ2kzZzlzS2hMWnFyQ0pnQ1lHeXZ5L0xaaGpnblhxVCth?=
 =?utf-8?B?R1dRSDJqeW5JNHhndU5uZHc4RVVxMTJCQUtmRldBeTRIMzZ1Rm1BdmVUTzRE?=
 =?utf-8?B?bEVZVEdpL25oLzBhTjhHOGw4QnVRbndmcFpLRTRkaGtaN29OOExqTzVHMUFm?=
 =?utf-8?B?K1N5OG5lWXhlTUg5TkNPcndsSXkvR096SzJrYnRzV01jdCs0ZEVYN24vcVZG?=
 =?utf-8?B?Y1g1UnZLeVJXYUVIOGEwMEJTVXdFdU84VkpCc3NicUtTRnlWOTR2L292UjZC?=
 =?utf-8?B?NTVPQnZmQTFhR2RwVGU2SnlQdnhEeHoybENEOEF6Y3dmQWxHSFVIbXd2WkUr?=
 =?utf-8?B?OWx3UG9QTkNjajQvNk1hd0lFc1Nrb1hjWlkxVWJJaWE1bm5xWWVhNGZXekNZ?=
 =?utf-8?B?SnhKc2lhTTlhWHIrVVpjZDhOSTNzc0xGRzArOFZOSDZSRWZBS01qc0RpMVdF?=
 =?utf-8?B?eUlFNFdwd1JCdFRSWEcwbStPWDh2Ry9TKzZzNkdzSFd3V0xaSmdyV05UUHZW?=
 =?utf-8?B?aTF4ajBEQU1mSVFOM2FRQTNBK1Y0U2VJSEpOcUtmVzZycnNqb2lKdS9VdkVL?=
 =?utf-8?B?bmxVRjBJV1RnLzVBRFNaTFhyazB2ZFBOV3JWRlRoTVRlODYwRGVWUytiRDZw?=
 =?utf-8?B?THN4TDNhRkE3RHI5cDdpL1FtTUszUmJOTlRSN2tsUkhvaTk1b24wWjYzeDB3?=
 =?utf-8?B?dThCQURURTlDZ2M4WGloLzMrL212bitsSFk1aVJ4cVJ0WWsxbEJkL2cwRmdB?=
 =?utf-8?B?YUhoRG1hby9sUU94WDV5SXVUZzhHQzYxK3NjY2IvZnorOE90MEZSZC82NEhM?=
 =?utf-8?B?Z2hwekwzWXpzTVZJYTVOZjBGVFJiaWRpQ2krekpMVTZZVFNnYkdaZHlzUDBH?=
 =?utf-8?B?MkNDeDFSRVMwSXpEOW1KdDR4RjlrV3RNaUV4THg4WVRFVURQT2lOS2JGTWtK?=
 =?utf-8?B?MEhtRCtpUlpzYTRXa1lGRmJ5aEJYQW5KQTNSM0VFYmZzQVVvWWRuT0kxNTFO?=
 =?utf-8?B?RlZKL1lBU1lxSlhiQmZheGVaNk1IRXpFR3A4SXgyVHRoQzhFRFF6TXAxend6?=
 =?utf-8?B?STVycTVjbWFjYlFaK2N0aTFQQUFKRlFrbnM1OEgzZVczdUs1UnRVbGMyWHRV?=
 =?utf-8?B?OWsvZzBVczJmZGFPSW9GV3RvMTJCVGlIR3ljZXQwZGtRMlorQm1OdmNoSkZ6?=
 =?utf-8?B?UE1yR1JTYTVZS1lKTUs1UDBRcnI5S1lwckFRTFF2ZEh0K2ZNNVNENDRXN1F3?=
 =?utf-8?B?My9sb1VjOEVRV080djBsTERpNUdja2UvbTkrNGZ3WHNkVXIwSmxUY2ZkZ1Vr?=
 =?utf-8?B?VnE3dDVMVkhzS2pLN3ltRVZ3KzdhSGV6ZVU0VjJZcHRyL2plNUprai9memNY?=
 =?utf-8?B?Ymg2NzBXQnNiaGxTUVRYdFVESzltOGJQVjY2R1dwbC9GTUxCV3J0NWk2LzBX?=
 =?utf-8?B?cUVST2h1MllMeUUrOE9hM0hFTTc4WFF3VFNQY05IQkVWSWVCdXJBY2o1RERp?=
 =?utf-8?B?cHlycGpDbzVTRHhjVUJUOTZiUEptaFRpcnVxZGRkNUkwVUIyRjZHWnBZTnlx?=
 =?utf-8?B?VjNBMnltSFVBc0NIUTJPdUo2dnJXcW9IWDVtcTZaaE1xajdLQnFDeXhDUjl1?=
 =?utf-8?B?VnFMREF5Z0IxUC9VTmZCS1NZcDl4ekl3Tnh3QkU5dlpjbWwrTWpmZW56VkFu?=
 =?utf-8?B?cHpFQ2Z5ZlFTZUI2M3hjektvdXA0ZUorZjh2cE9kSEl1VG5wOGlubjNuYUtm?=
 =?utf-8?B?eC9HZkhIdGJCaU5HdXpXYUNiNzEvVVhidHA2ZUxaa2VCMDVQdjVEWVZVelZ3?=
 =?utf-8?B?WVZXWGpXVkthQ0R5N3I5YmhmbzhVaTh0QUthWkZHRTVyNjI2K1FaYnlnNlFR?=
 =?utf-8?Q?eSjLjqyrm0S6+zfHHKzBQRk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e34143-82e6-4b37-fed1-08dc9ff72356
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 09:11:37.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU6JL0/J8PEUFm66y4+WK7A4Srwz3C9xjK/GSKLYYTtVAqqv18etLSZzzsGmrrBgID+ju2u8r8UE15G58aqapNf77xyPnxGbYgTaTa7/g/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6321
X-OriginatorOrg: intel.com

On 7/9/24 10:54, Paul Menzel wrote:
> [Cc: -anirudh.venkataramanan@intel.com (Address rejected)]
> 
> Am 09.07.24 um 10:49 schrieb Paul Menzel:
>> Dear Aleksandr,
>>
>>
>> Thank you for your patch.
>>
>>
>> Am 08.07.24 um 20:27 schrieb Aleksandr Mishin:
>>> In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
>>> devm_kcalloc() in order to allocate memory for array of pointers to
>>> 'ice_sched_node' structure. But incorrect types are used as sizeof()
>>> arguments in these calls (structures instead of pointers) which leads to
>>> over allocation of memory.
>>
>> If you have the explicit size at hand, it’d be great if you added 
>> those to the commit message.
>>
>>> Adjust over allocation of memory by correcting types in devm_kcalloc()
>>> sizeof() arguments.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Maybe mention, that Coverity found that too, and the warning was 
>> disabled, and use that commit in Fixes: tag? That’d be commit 
>> b36c598c999c (ice: Updates to Tx scheduler code), different from the 
>> one you used.

this version does not have any SHA mentioned :)

>>
>> `Documentation/process/submitting-patches.rst` says:
>>
>>> A Fixes: tag indicates that the patch fixes an issue in a previous
>>> commit. It is used to make it easy to determine where a bug
>>> originated, which can help review a bug fix. This tag also assists
>>> the stable kernel team in determining which stable kernel versions
>>> should receive your fix. This is the preferred method for indicating
>>> a bug fixed by the patch.

so, this is not a "fix" per definition of a fix: "your patch changes
observable misbehavior"
If the over-allocation would be counted in megabytes, then it will
be a different case.


