Return-Path: <netdev+bounces-300044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4cnkGfs+MmqyxQUAu9opvQ
	(envelope-from <netdev+bounces-300044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:30:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4607696DB3
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:30:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="CIQa/xQD";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300044-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300044-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F1A73021E65
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE083B27E8;
	Wed, 17 Jun 2026 06:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAB39934D
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:30:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677816; cv=fail; b=dnDN5CG/0TOgTxuZLnP2JHfSK+0aU3AszJH75w0lQFEM4XVk324jSywnXzBfj6LNBpdO6eGWm3gNIZgGqQvPDLeQH74qCk/jnHwOB5EWOwEoxSw272BqlX6EIOL6P4tUDYSxhrR5YWFWkO8REeoDdRV5QGHqsuvoSdiKKPQieHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677816; c=relaxed/simple;
	bh=LBT8g8VKXgGdB003mKdDzKO8zto+Lv4IRDWeZ5a0qx8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hxKTNWJ07PCecqpbQMpA1/ZJxpqMDhwhxoMumRze6CUsdH/J9HF67lchmnZRo2rloYctNqPU96Cmtw4FirGa6gYKthNKRA2mY2AMW8ey0zUZL+6fcsXLrgvPzCbH9OiXKvRSvVrRTcfeMGeBddltIxQrvG/j3P/AVUg1G+kXkXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIQa/xQD; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781677815; x=1813213815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LBT8g8VKXgGdB003mKdDzKO8zto+Lv4IRDWeZ5a0qx8=;
  b=CIQa/xQDnrwqxSjbKWRSlS0oimOHZHw8/RC2HfXkh06Q+ycg3Agh+jfy
   RJAzmb21iLmYimIpx27otTGpHK9q+5DBLLbxXciAyXDiuwyqetXclrIxp
   31Wu+15Y9TNW9B6RkJG3LTHpQoLIvswuXlXfFtR3pZVV3iMrmzT0hzIaf
   vBTiuFBnss3gTDBk4jFtUCiMzShPe/Gyyzs1OH87YxWp7/R44KL6MSIpb
   c8mT2iVHykO7q+nSTmli9smECVA5vToc+unpUHra8ZoX5GR2ZFrQFyHJH
   MpmzT06q0mghkrgjWmoVAUiKScbGoUDXeyjloo+6abt2HPS485+ZM1/Ie
   Q==;
X-CSE-ConnectionGUID: pY/5qNbCT72SEwGC902E8Q==
X-CSE-MsgGUID: RUIDw6P9RdKbdjnONLVw1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93128479"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93128479"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:30:13 -0700
X-CSE-ConnectionGUID: uQoW8tOCTzGNFnyZxHiKJA==
X-CSE-MsgGUID: LMFmUTOxQ2CGzMvZT+mrOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="272047102"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:30:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 23:30:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 23:30:12 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 23:30:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHuzoSb9iWPzhOWXotBEuM9Xx7zCOMw7ShK32aiw0mNtxfiI0uo5Z9TYmbpZzf0ik/oUBEZ3BakbAaLvJyg5uCIl3HL8TigMTWtjtbccysDWg3B+/I7GQQj85DS/xjkSACj7G3Syt28YwbEtoKN4CTcftK9NyXN5CgWgB2XgGaDuaserLVVrUd5zJCstqDGP0QtpKT3pz0S0B6ggIWjn9BPdoRY6cGo+fcZPotu4FQZIC/QqSg3gNMC0DQxrlTVxMfTDCFDlMDGVZQjSMbPwhuc/AXVBsbTugnIA73eKMIbplEyOJKlQoxYhH2Zvvvkz54ga5R0HQWZpMuUu/h42iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3tszyEjHwB9VEUU8UbHMJ/BTlZcJudtpHG2mpCQnBU=;
 b=sPX1KRN92yxsX9Ul23Y6AONS7zkweHlKAW9wTws/dZoflynub7zyXg7HX+XXBDwm6CjXpsCv8P/y7hgg1pFg7xiZ9JXKD/ZSJCsA1vpd3pRW5pz8o8mWRb5FVitf/IIfd6kBBYqeX9u6qoV9JawZbbfBPPlWXTuu7t7b9Scm0RS84a9v+mfqsHRFOy3qRcXDR+NGLXVr/xwfWDGwiRasRJomljFxUY5FN0NXIKuWJWqb3miKVGARlKaHxpjl8hLYeRdbebQR4nxhbFAqwc529DBtdiYTBgASzVaT0MjBt7wKwlrs0/hwUoE+0dKcvdNj5XYxtzJqhDGNAKp/9W3mKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 PH0PR11MB7660.namprd11.prod.outlook.com (2603:10b6:510:26f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 06:30:01 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 06:30:01 +0000
Message-ID: <aeeeae06-e6d4-46e2-a188-38d1c09f1c51@intel.com>
Date: Wed, 17 Jun 2026 11:59:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/xe/ras: Add support for error threshold
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
	<kuba@kernel.org>, <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dev@lankhorst.se>, <zachary.mckevitt@oss.qualcomm.com>,
	<rodrigo.vivi@intel.com>, <michal.wajdeczko@intel.com>,
	<matthew.d.roper@intel.com>, <mallesh.koujalagi@intel.com>
References: <20260604184849.1011985-1-raag.jadav@intel.com>
 <20260604184849.1011985-4-raag.jadav@intel.com>
 <4d3720e1-1268-4a17-a8f8-f03e82aa1c5b@intel.com>
 <ajI-JwsLcVWoUiqj@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <ajI-JwsLcVWoUiqj@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::23) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|PH0PR11MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 4040962a-cc65-47c2-d950-08decc39dc42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: S98mgDcj6u1g5jUc73dFMZHu/X0dD1rdYo2hwQ2rHezZw1ACyynsKzTmf3moTZo/SVbaxsFQvePY75JnwTjKtl/glOo4eSKGX4H7DZ9wJzyuR0j0Lbwm4sn8c5RhZP4kF7BQ0z0zrhnkp+cIkYgZvVN2vlWCOMsW3R8CtOcCFuQpukBxsbyscVt9Tw23+qRtY2IozjXCZTBxhxJy/i9Zm6MTyTKPiN6M2bX/qLti/+wlf73urvWcW9LQmFE+OistjTz3sg7BKQ5ZYs3VLOC8APqqN7GV0O9GJUxpoIsnTyeS4rwHc2DQUyvjGOPHXR0T/ugk65UYFslwT+AhbdWoLos3sik+jh7uQMWf5MBQvYdOlE2Mu4L2siatm98iC+tHwl/n3VlpyoDqakTcOBdpu4pKcGxa9o+YmTMyrbagQLN3HMbbmSN8KBkLrfVOTOKjd8R7Pygc8MZ0sYPWLtjsepd86eXpQdRhKfclKFqOS2eY6IwQn0InD0nE3z1ENHkiy+R6q5NtfSREzltckgl/ioYsspU3g9sxJDZwvcy/j41lxxvXiXW7CQnh+HMyf39g2CN21jIVnrae1SQaZs4bJKHb5jqq1ml1ppu8o7JPRJkwPZvMWXxhwEnQBIbtp1CflZNu7dlI4bEpzQlJ+zjFTjkTrVFdkgLLey0hwZcHObHq89rHphtzTni1by8HblKsa8fUIbG/Al44R+ywDe+haQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1JNOVh3QXNtbEhwUzFMMWxZUzBRT01NYVRlMEo0My9BY2U3Umx6SUFGSis2?=
 =?utf-8?B?QzRNN0VRb2VPK0VrOVNESU5xTVMxSnEzWVg3QVFXdksvRjVDbTZrdFRZWHYz?=
 =?utf-8?B?T3NzbXJyMmtPY1JJTkk3eU0yN0NzekNXaXVwQ2YxR3piSkZHSkF4d1BQaWVZ?=
 =?utf-8?B?R1ZFZXZHd1VCUG9KZ2UyejZhbU1vME4weUczMDBsZ1VEYmlMZDlEYkJZZUw4?=
 =?utf-8?B?UnRRYi94SUIxWkUrUHN5RXhIMmFJOVZnWnA0aFl4bUt3T0VHYnlLS2ZiUFRv?=
 =?utf-8?B?aldVUUU0bUtiSU16Z0puWS90a2tvU1pKOGdGSkVxVVBsY1pVaTZ1K0U2RTQ3?=
 =?utf-8?B?eERYTjlIZzk4enFQQ2w2bUhDaFJpVG5RTGxKTE5icEwybXFqby9RQ3dCNWM0?=
 =?utf-8?B?LzhWTjVIRHAzaHNIQ3VSanBsclVXWGE0ZURnTG14TlVBRlpPbmQ1MHYxaXhS?=
 =?utf-8?B?a29jZ01MaFZidkw1MWR6anppSlBtTlU2aDdBek9uSFZCYXliQU9pb2RGajNm?=
 =?utf-8?B?QnMvOHpaMk4vYXNZL0VLZ20rV3gwWjhOSHBNTzBkS0pRWjh4QTJ0SHdjRjUz?=
 =?utf-8?B?bnlYSSsrRmV1VTJORWFqOW0xUEtzZHMrVVFsSVhQS1FrdElnS0RvRWFPVG9Z?=
 =?utf-8?B?UkhSZjVaVHhzQy8wU00vWjQ5dVpaUUgwUVdNMEZpeThmeXBEb3NDeHhvMXJV?=
 =?utf-8?B?UGlJODVVZWxEMHNianQzSkpwOXdiWjJ3b01oMXVrakUrWkVqbXh0bnJVR25S?=
 =?utf-8?B?ZVYvRGJkNmN4Qnk3Nnlrck1ZRWpJZXdZWmFuWUlmWS96UUdTZUx1bWFGUm9q?=
 =?utf-8?B?T0d5L0Y1aUYzZDZqeVN3NTE0RzdMN3JDMk91d2gwbXhwU1NxZXFmbVFEVHp1?=
 =?utf-8?B?dW1Tc0prVmJoMktyaFJsNnJVcUx1NVhOQVYxN0xZV2FFQnFpWTc3a2Mybkg5?=
 =?utf-8?B?T3dHd2FSb205V3J0THIvUFR2UWJvTTZ6L2prSjZRellNdTFkV3JBTWJVNEFB?=
 =?utf-8?B?dlNBaWYwdWNQVERFdFBCNUEwREgwTmQxNlFmbG1vSVhJeitiU25tQ0JwZzFX?=
 =?utf-8?B?SmF5ZzZRT2tROFNWRlE3WllDVkFidjVJOGtLbGsyQ2Fvd1c0YmxIQmU4bTFC?=
 =?utf-8?B?THhWRGkvY2NwNGxmOUcxVEJoaDRLeGV2SXM0RjhRU2F0Y0dDS1RBYzgvVEYz?=
 =?utf-8?B?S1dwMWMrZWZadWVRUHdIV2IzNEtTcy9PcVE2WGcxTUhhT2pEOC80TzE0S05y?=
 =?utf-8?B?M3QySXZlSUorUXhGdEo5QVJINi84bmJhY3BpdEFYQVBzRnNuSWQ0d1l4enVS?=
 =?utf-8?B?ZjkxL09HZlYwUExKaDJkbVppTGZlS2g5MlowZDRuWEZUR3lJOHltVk1PdHA4?=
 =?utf-8?B?T1hPTGp2TzkxcXlsOWFlWkR0algzVTBwZWJhNDMrV3lvV0ZiRjJnTWlzMFN1?=
 =?utf-8?B?NUFjdzJRNGxtM3ZSb01DYzdyUTUvWXhkWS9KY0lwcVV5Y1QyLzEyUlhVdGJD?=
 =?utf-8?B?UUk0RmZuRmlqMEFhb1grTXBJSWRUTWRXTDZ5RjlmQTVaUUZhQ0MzaVlpZjdk?=
 =?utf-8?B?ODBmMmxxNmpHaU1scUZkZEwwK1daZzZTeGlvQmxpWE1zdnNpcjFVamFoK3pW?=
 =?utf-8?B?Nkk2WUI4UmhvZUVLWlJ2OG0xMlRTdTdDUHlMc3AvZUc1WjRuTWxSbGMzWEY3?=
 =?utf-8?B?UWllUjFuR3dOUThpeDJ5SVZma1VPOTNuNENnWE5RSVJ4Y3dzNEVRTzJhRk91?=
 =?utf-8?B?aFdadmZZT0tNc3ZheEI5TUg5WWV2MEx6a1RkVTYwWTJGTlp2d0Rsc0Fpa0Fu?=
 =?utf-8?B?anJweEh6R09jVmNiK05EN1RoZ0dDUjEzU0RpWDRpZkljUGMvZUh3VExhaFRG?=
 =?utf-8?B?Ymw5VHp0dmk0REwvTUhQajFwL1dvWkN1M00xbjZHdmZ5cDZCVHh1U2FkVEsz?=
 =?utf-8?B?d3V4SHRwQ0NkRURObjFtVXVBaU5qcE1vS21ra3pzZlVTM29HTmp6YWxNNHRL?=
 =?utf-8?B?QWJBNjVBbUpxcUozck9aRmdHcVloMll0R0lqbVR2dGNTdGowdG1wMHhURVFi?=
 =?utf-8?B?UTFlMnZJR01RRUM0REtNOUxLTjlpbDVmNUVuMUpvc0JUbnF1SnlCL3gwVEdH?=
 =?utf-8?B?b3VGKzBjVmpoUDZrRXVnL254ZnlNb1d0MlhVTy9NaDNSVG5HazVCaXd2L0tx?=
 =?utf-8?B?amdwNTB5WktOQk9wVjgxSm9oazdVdlVWSFpMQU5jSDZyYm1aeDFUSTkvVjFI?=
 =?utf-8?B?Rk56M2dBNVZiRU5lU01aWkVDZkxNdFBYcnBSNWVNcjhZUEdXY2t2bmFjL1dR?=
 =?utf-8?B?VkFkWEFEU1Y1bWZTeVNVVjhNV253VUdTTDVzb1dsZCtoSUJCUklodz09?=
X-Exchange-RoutingPolicyChecked: ThQGJVodknnBfMq4UiVZnaeX8CiPpEG92AnhMo8H5Ax3JSd/+jddJGHGWr9Y+RjxOGpk3Nlhn/kNudnas1TB1cNK+wusPTZT6ty3vu1DpUjI6oqXI4kdEscX1ldtbFIqGaXWNT3HWCJMYXLZrABCJycXXPO1Sr5EqmY2yQNHU5/vfZbrMtUdlyiY12kdSy1r5GuaLXH37x/IlK1EZKDDh1uzzZBQDbm55qPQxNPUEpSs7YSZamjoT4QTRqurZGJ4/erjcNm/Xwik4eXyx1ybo4Fv7uFRtd0EjMqkVPCWaFpIWU6I9Tn+0D0R1QuK5Wp2W01VZqR1hyzy14U/QOFe7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4040962a-cc65-47c2-d950-08decc39dc42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:30:01.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uxOjkNm+MBoRJ5OB5bfMUWTPwI50NPdNMaYu+ojJU72pedqajiFMuyyCD88zV9HiitX/7TubhDpaS7xhNkkpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7660
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300044-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:raag.jadav@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4607696DB3


On 17-06-2026 11:56, Raag Jadav wrote:
> On Mon, Jun 15, 2026 at 01:47:02PM +0530, Tauro, Riana wrote:
>> On 05-06-2026 00:16, Raag Jadav wrote:
>>> System controller allows getting/setting per counter threshold, which it
>>> uses to raise error events to the driver. Get/set it using the respective
>>> mailbox command.
> ...
>
>>> +	xe_dbg(xe, "[RAS]: get counter threshold %u for %s %s\n", *threshold,
>>> +	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
>> "get threshold" to be consistent with <operation> <value> <component>
>> <severity>
>> and other prints
> I thought "counter threshold" was the correct[1] terminology?
>
> Raag
>
> [1] https://lore.kernel.org/intel-xe/ahgNW0Z9eQmQzGzY@black.igk.intel.com/
>

That should be fine. But keep all logs consistent.
The previous logs have get threshold

Thanks
Riana



