Return-Path: <netdev+bounces-94473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB18BF96A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434F21C20290
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1991D73509;
	Wed,  8 May 2024 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0p/UOvj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27D2BB00;
	Wed,  8 May 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159644; cv=fail; b=X6znr/LK6UM+wZSMy/SDXqKyAlQeHIQgHIOVdYtEiyQL+EZa13Dl9KHROfZZjxk3L3nmyCxMtttepbkyfQsUpm6kb1/QiLZWtzH+GWtoPFPmofYsm6FCiP1qszRALe7hCejuOTYjCPwMbfSSojs5yVckx2+es2Fu8RB3lNjzn64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159644; c=relaxed/simple;
	bh=kqIkCEdIJh4FqClADsiUFzR9E7iMgVSVvNUOwlS7f44=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FP0e/Ag0/DE3YFtie3yHvmaZbIRnsdE9vgAmwpaoLVmA62QbqhzTezzC/yiYn9ULOl45PPUf+hcInumHaT8gnh4BdaFhteVn1053buUDc+RN9/6C8nEVogkov0vpOSXHn/ksbIab8WGbLCJUXqKmV1HHtkCFjkg3f6da0nUO+jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0p/UOvj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715159642; x=1746695642;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kqIkCEdIJh4FqClADsiUFzR9E7iMgVSVvNUOwlS7f44=;
  b=Y0p/UOvjXYnDtsWNaQvS6rvMIBDEcFEhA/YUeu5HxrIfdsJjp9GVr0vV
   Zj5BUhEj+mFAjFqMkvlfrawJf7xIsGkyQVzWVqL/BltR99AUAlgoj2hdu
   EK/VvN/5+VTqUHxjpiWIT1W/oh5kjcI64ETyrWaBoeAAdD/+8Zcf9x6W2
   BfSYCDLSkStvU3pbqrAxyadC0Jq49w61cYC/d1ST3T+/J2sOtFqIyrU5h
   sGYMgufnks13KFHKDxg9g6UcVYMXTd/s4bTY2ZsPrvNUTL5xCft28iqQw
   ROyrr4ilNKmCSVd/VK8rw8YkVeifLxsvUfZs5jnsR8F/EwIhXvHZecpTC
   Q==;
X-CSE-ConnectionGUID: n2mVeaneSaqs8+d5D/fc+A==
X-CSE-MsgGUID: wIUoT1BARAe4x674nv8ddQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14811502"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="14811502"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:14:01 -0700
X-CSE-ConnectionGUID: fmS6HtOURwm5BH8j8LNZXg==
X-CSE-MsgGUID: M13kGBOPRCOfuNon8+rhWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="66252598"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 02:14:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:14:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 02:14:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 02:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKVIhklXIMVe79jGg4yohngoW1HwMxpNLopykTSm0TRCZ2HNBCSCI7dYYIz3H9sbxOZ8ZBkUxqaxmqdlU6e6/F4GpHvrKzTQFaS7S0iG9hE4qOm8spAJyNIlAkjGtJkMKc8QvXTqwS5qjXYsXRnL50LM+j0y7ZxneY6JG9fmuNxh8klUQ6yRIAxZpGMs/rHD3MWRhWNxdHuMRij1nAzj5v3K+Ue649ekN+/YY9BzpsmdvUV7n14GEjEEqFW3GZ9UJWtE2VdlEX+qoYnMjfP6lPwoaU1wkrrDDIUP8Uq8VxNL+U2L68ecu6xvY/t5OrILxq3xHhZBaJ1J/5UHF1VvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySSJzdNriXwvbahWP+T+DeFqi+3pXYOg8LMOPfMckWo=;
 b=HgW9FcSd2y31vmE5PyjxDq8lGtr4riKFMBObW7I6AWm4liIujHai52iJmdkfjVawmJeI9ZVY/hxmcvtp8jpVDZD1nJta4Q2XtBcuDfB+3qDIORfRzvVOh0TLKTxTZd3RBBnpB4FylrYyqlZnTnB1ya5r887e3NwFckqkaTpQmjJQn5Z//qIgHMpoAOVqdlh9iEphLA/udcj+9CbfGyb1cKG0jRj7HDUiTuh/1z2h4LGqW1l3wxD0vyhSNzRiVkRw2fYwiSfgeHd4r3iTShZOExqD1TH+agTzh9Eap4DhUaBAPnqWCf/qQWYB4wEnSE9swZ7RY5F0kiYDl4ceTVXCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6904.namprd11.prod.outlook.com (2603:10b6:510:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 09:13:58 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 09:13:57 +0000
Message-ID: <3b08e1d0-62be-4fae-9dbb-9161992ee067@intel.com>
Date: Wed, 8 May 2024 11:13:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netdevice: define and allocate &net_device
 _properly_
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Simon Horman" <horms@kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240507123937.15364-1-aleksander.lobakin@intel.com>
 <20240507111035.5fa9b1eb@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240507111035.5fa9b1eb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To CYXPR11MB8712.namprd11.prod.outlook.com
 (2603:10b6:930:df::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: cac9dca0-78a3-4372-8323-08dc6f3f3036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1VTUmJ1WDFDdTNOUy80Z0ZHbzBuSWRvN0xRZVlsMXIrdTRYTDFYeWY2N1Vh?=
 =?utf-8?B?OFg2cCtDaVlzK0ZCa2xnbW1FWTZsZHRoT1BJd2xmc0FVZGZnUDZvMlZTaHYx?=
 =?utf-8?B?ZHZyQjg5VzVuZzhlTWk3OC8zK2U0ZmZRakJkanhKL0Vzc0U1UWo0ci85cUVz?=
 =?utf-8?B?TWVERXFoK01Cd3ZzSnVpSy9yMUtRSi9QZVRRYkFiS1JjYUhaSHhkSFB6dUt0?=
 =?utf-8?B?NEdUekdxWHNOSjZOYjV5aU5oTzZKU21uemgzd1N3QzJWeUpwVDNranJqQUMr?=
 =?utf-8?B?blYyUkkrSkpPNy8yZXltajNSMzlMVHFsamllS25HWnhuMXp2SklGVUtMVTdl?=
 =?utf-8?B?MFVXN0t3TjIxUzdaZVplSW85ZkZ1YkNTZnFtbUUzYzVvcHU4RGVDNWVqWXIy?=
 =?utf-8?B?WW0wS3VRWGdXdG1UYVh2WmxjTEE3bWNZODA4bzVPdStTdHdadXVpVGJLdkcx?=
 =?utf-8?B?M1hYdllHQzN6SC9JRzdDbXZoZ2oxY0RtQXFJZHBWZVhmNWx2RGxtZ1FxUWV0?=
 =?utf-8?B?dzduTjlrVnBFRHdHanM3VHpoN2I5MzJEQ24zb0dhYk02NjB6cG8zaDM0Uk5C?=
 =?utf-8?B?dTJYKy9EcktrTi9VNXZLcG9pM2ZWSldjT05CYkg2NGNPNVphZFYwdnhiY3NL?=
 =?utf-8?B?WDk1eWZvZEs5aXJxejFVbTVoKzFOUFJZc3U1NFo0N0pVdTJ0U2s1UkR2a1ha?=
 =?utf-8?B?cm9OU0lDclNwTG9nK0JCYlRsN3N2OHF4dmZvNkxTd1c3VzNnVnVCTWNJWXZv?=
 =?utf-8?B?WG1wd0xQdVFVak5zRUVYV2p4QXhJeU9GZk95TlV5R2tya3RkY3piYWpBV2xp?=
 =?utf-8?B?RmRLVWVFdG9Xc2orc1pnaE5mZjR1YXQwS2lNRElsT3JmOVhwTFB3VmdITElz?=
 =?utf-8?B?ZTNiR3lLSWkwKzhDeHk4TXY0cDlXUmYrMSt2MElKZjBCZktwSWg4bGZrVklO?=
 =?utf-8?B?QXJGYjh4WmFqb01sT0VEOGZJMkdLbG1GK2pjTURuRHpOeEFwbnNKOXZyMlBX?=
 =?utf-8?B?T29QcGduYmxJaHk3eXVWZENlWkN5QXlSdHcyQWVNTzRzOUQrcmdYdFJCU2JT?=
 =?utf-8?B?Rm9TWEhnem15MzBvemxKd2JRSnBRSjRFYzFkM1pJYzdlMkpKYTloangxR3VV?=
 =?utf-8?B?a0w4MmNLNnlaNXBRTm53bTQvaW5McTk1OGtGNkc0WThFaytJdnhqVEwrSmVG?=
 =?utf-8?B?a0dtdERCQ0xTTWY1OHZvK0tuYlRaSHUrckEwK0hqaUZ1a0NFTFNXNlVVMW5s?=
 =?utf-8?B?MzBsMEVDWmNvRksvTVF5MFZ3TGRDS3Raa1FXVCtYZVhQaWRKZUduOW0wNGFD?=
 =?utf-8?B?bTRhT0xPVFJ3UFhVQjhLTXRpQitJenJmK0c1NEdsbVh4TE92ZEN2bFFUWnJX?=
 =?utf-8?B?enNzRGpCUWs3YjF3RWREaFFzcERKamUyVnlsaHVxRkJhMjF0eU5acm9Jd1Jp?=
 =?utf-8?B?N2huVzgybFpzWVJpb1dDTnAvRkNJN1JKUVBkajFrRDJyNUVEVUVRUEJseTZq?=
 =?utf-8?B?aGJsNi95Y3dEc1I3RzJWWlJZclpoSXBSWGFSQ0RIMjdjWDFaNVNrbmJxTlFJ?=
 =?utf-8?B?NDQ5cWFuVHZGRXNwclJLVEh1dlByTFBlWVBTNDdoVTl3VXNWMnE3dHJQU3Vs?=
 =?utf-8?B?RG1uRTBEYS9TWHUyWE5sbE9zcktRNmRxUC9XMVVDQkFtblIyeEZiRDZueVdY?=
 =?utf-8?B?V3pmREh2bUlUSWJaa0NUZWhaSUFUV1o2ZXRJSnBQVFgxekE3NnZYRHZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXVsc0U5MVhLcUhxTFlRckg1L1J3TUJWaHVBL3F5ZXlDSTNQMERjMHZUSENs?=
 =?utf-8?B?eks4SWNWcE82K2JNT2pnSmU0Zlo0M0RBUTFjR1lLNFJpMTgzR2RWcWZlOHp5?=
 =?utf-8?B?a1BiNlpzUDJreXhnRlkydUVzUjI3aEhNajNlNDNrZUlkUys4L2d2c3VROEZE?=
 =?utf-8?B?QW9BZUkrTnRtVjlMT2JCdG10V3k5aC9FY0M4M1FIbkNwcE9HZmVoR2NtZXFu?=
 =?utf-8?B?MXFjOXhHOVBKZzMzVVVNTmlYbGNTalVyMEpsdkh2RTJQUTBBb1cwMVBrK1ZE?=
 =?utf-8?B?c1Qyc0RxTzdoTmFlckVqMGE5KzVVdEo1QVFCekkwL3FQNWo3VFgzcDJ5Nk0r?=
 =?utf-8?B?WEdaTG9GT3c2KzhqNi9vR0dXVXV6R3BvQ0xTUUt0bXVlcmhDcjNEV092SnJF?=
 =?utf-8?B?b0ZFN2hhSjdRd20zRDVQYUdNSnNGSFkyK1QvOFRkSURqSk9QSlJYWkZHUVBk?=
 =?utf-8?B?YmhERmN3aFRoVGdxdTN2TDJuRE4reWVMeHJzQURNMTRuRlVRVndKWFhNcWNU?=
 =?utf-8?B?bmMxYWQ0TkpOTEY1cGFFQ2dHMmM0cFEwQlBWUWtHYlJCdEdtd0cxRFg5eEdJ?=
 =?utf-8?B?dlpSVjlRS1NScDhPUHhCU3piNkhJVXBSL2FRdm5EVWJpQndaZmVDU0Q4aWpI?=
 =?utf-8?B?NVdYVGJXcTdsb1BDNXc0K1RldzN6RmhZcVk2alNSZThvNVRndWNkbEtoZTk0?=
 =?utf-8?B?SnNVMDRlNXV6dmZZTmJ5SzNEeElqRnZtcFFYOTZqN3cxcW9nY2dPMG0zTUVM?=
 =?utf-8?B?MHY0RDZ0RGt6ajVQaVFzcWRjcm5BWmJnNVRIQk5BVzVhT3E5bTFOa1JZRzJK?=
 =?utf-8?B?QVNjNzJta3RlVzVmaE5TeGw2M1FVcitrQm1nM0tJSHJnTHZmWGlFcVZCeGYy?=
 =?utf-8?B?SHp0eHQ0Z1lxaWVwMjdDcTJKSFJpM3F2ZC8rTUpxVzhSOFZ2UzRpUi9TRzVy?=
 =?utf-8?B?ZUVRak9tWWEySjg4OTZ6U2NvcTRpRlJYY2lNN1hPcGxTQUorQWpzZDUrQUxT?=
 =?utf-8?B?ZnZaQUxzUm9QMTRMT0Iwc3pDTDBxVTJTeVpNakNCeG9ZaS92bnREWFc1WHhI?=
 =?utf-8?B?S3MzV2FpNWdQMzJoNkxrUktPZ2dtbkMvWmNHcWZodHhqc3Q0cHhac0FxNWQ0?=
 =?utf-8?B?NFdZbXliTzhiTG9IOElCbENnRi9LK0UvbjdzdGRwYU90VkxDNG94YUZFZ0Zs?=
 =?utf-8?B?NHVLdStnRzNWNlBncGhjakdkWU9oVDY1Z1EzNTlIQXd4cFlnZlJad1JzNzBJ?=
 =?utf-8?B?MUJQOG9GZXJiM0lGRm5vc3RHcjRmUnltTTd3Z2hnRmtucCtlWjFQRHkvUnNp?=
 =?utf-8?B?TWpEQ1RnUVd0czFuUllBSCswUndFbGlaRzNvOVlhbGZrTHRtSk5rZ1c4THlQ?=
 =?utf-8?B?TW9kNkRTcmdiNTh2WU0ydEszcjlmZXpDVDF5SzNWem1BOExYSE5YaVFidFk2?=
 =?utf-8?B?ZzZsdnFqbjZkRndKN01ZalFwZi90UE9IZzdyUUs0dVZ1dXhqWnJYdHdmNXdF?=
 =?utf-8?B?VjdQZzR0WmNCOVRDK2ZGOHMzTDBLdEI2bjN4cU9UZFo4c2Q1ejVKM2tPcjc0?=
 =?utf-8?B?WkREbGdkMzNSMCtaMmpXSHl0dzN5c0h5czhSQjFuS0x4RzdMNG5BcWFCdVU5?=
 =?utf-8?B?VTRJcVI0R3FBL0FtYjQ3djZhM1NxS1E0bUsrMFQraUVFNXF4LytsVFdaTFpQ?=
 =?utf-8?B?Rjg5TXcyUXlxRmhvdXQ0K04vbWNjQzdSbGFKVTU3QlRlNDNVYi9wa2swQW9n?=
 =?utf-8?B?aENJMjlYNU1QQTcrNXV3WTZGZ0dBUVBJOHllVFhzdVpHRmZKY29uS1FweXUz?=
 =?utf-8?B?czRjUVFnV0hIbHc3ZlQ2ZjJUKzhJYWFyQ1owc0RtNUlCOG5na1FpMWY1VEVk?=
 =?utf-8?B?ejF5RVI2OXQ4YmxoMUNQMzJJb0NyN1dqc3EvWENKc3NyNXh5ajNnREl0aCth?=
 =?utf-8?B?UXV0ME1pc3RsdDhwd1JNczJtK2lMazNpZzJyaFEwRHpxLzRFMHE5a3B6SWdn?=
 =?utf-8?B?dkZ2TkNidmZ1Vlh4NUVYU09Kc3FISCtDVmdXQjZyZmNRTUJJV3ZScjFPRVBp?=
 =?utf-8?B?ZWZZcmhKSWxZSjFsNHZFMkJCb3E3Tk9CaFlwUU11VnpVOGJDK1ppZEZpUUJ3?=
 =?utf-8?B?dkQ2UXNWeUZCV1NIczU2NG5yV0p2bWZ5ckkwWktyQjNMdzVZRDFyQmE5R3FH?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cac9dca0-78a3-4372-8323-08dc6f3f3036
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8712.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 09:13:56.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROY5jquDCJIQydFJuPpD9J0HJ418odiJsiQFTD4oPQ4FYZspuEkhMk7Y6UppwpEkeRTmnpk+KmbG/QHM6uoczefAvvWEgh7RYmm6Wp0H7zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6904
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 7 May 2024 11:10:35 -0700

> On Tue,  7 May 2024 14:39:37 +0200 Alexander Lobakin wrote:
>> There are several instances of the structure embedded into other
>> structures, but also there's ongoing effort to remove them and we
>> could in the meantime declare &net_device properly.
> 
> Is there a reason you're reposting this before that effort is completed?

To speed up the conversion probably :D

> The warnings this adds come from sparse and you think they should be
> ignored?

For now...

> 
> TBH since Breno is doing the heavy lifting of changing the embedders 
> it'd seem more fair to me if he got to send this at the end. Or at
> least, you know, got a mention or a CC.

I was lazy enough to add tags, sorry. The idea of him sending this at
the end sounds reasonable.

Thanks,
Olek

