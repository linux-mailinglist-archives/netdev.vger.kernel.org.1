Return-Path: <netdev+bounces-146716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A0E9D5452
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41254283A19
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741DC1C242C;
	Thu, 21 Nov 2024 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUX5vDWv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851A1C07D3
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222382; cv=fail; b=UswwJF021DBncPbGsm1N/ODVnBT4/Hyvn7jIFeJfSClhCkymI19WmMHrp0Abw/I9yA/pHkeSisYmeRnrSXypL4Ju8IFtdC3xbp2RVgIgqXsYtTvw1KDfyV805DYSAJZ4S2YXBylyoMPPlDIyfLVO4P7XTgxy9sgw+OPFivGnA5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222382; c=relaxed/simple;
	bh=pxa5ql76WyZ+NPc2q9w1snxLFMkMC3iFngkQ2o6Uk/M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n10/ksnc34fJFiTcZBNHz6ztGbp/c++02td+mk7fBOQrW5CDVT0XwGtdKLc6NMlDEPiG9PJ0fQZTIgYscjc9PLqwlJckxSFfeTCA1X2MzXZ2D+vZwt81N24o7cqIaBVDcWTQEUPOnMOELS/88vcarzVi1QkhNV/ZP2iRXudgU18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUX5vDWv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732222381; x=1763758381;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pxa5ql76WyZ+NPc2q9w1snxLFMkMC3iFngkQ2o6Uk/M=;
  b=lUX5vDWvvmmJZ2H2xJVfIP3q36k4hje28mOP8FN75R+UOS7Soc1Wx0BA
   R4DjLfqZcK61GdjbZqXCG8wMzIwvXMH9IVYSDeTmve85NYhzpL4QByuDI
   A9lc+Zwjvs2QRlbu4DaBFfEdBSATdc2kHJnrdmeFzxBHuVJC3ghN6GvX+
   ackfvJ9wf/yiv6srbiiAeKd2izl9gptaCBK7QUAbvK4ospF1gorJnH/Op
   POFd2pf8mfGdwUnfTY5b76A2e55HFKVXaFiWHz6I8QRwoexBRvqqSa7F4
   asRYiTM5HZ3PmpDGR7uVCRZH9ILH8HwJlWWzyxWj1bgsSMIH4q/xc2Uag
   g==;
X-CSE-ConnectionGUID: Z1loh0XsR1KXuq6nZPeEIw==
X-CSE-MsgGUID: 8oIlqNG6RtSaK16EtZLJ4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32600908"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32600908"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:53:00 -0800
X-CSE-ConnectionGUID: zZrSLVRUStaaU89hO49OXQ==
X-CSE-MsgGUID: vPeNZF0lTNWrlqgDRpkecg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90172494"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 12:53:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 12:52:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 12:52:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 12:52:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYtdm+FxO3EUV5VqD/HyzomshZ+ZH00/UCcZj6fBiHCONfjDIqVR4Wl7HfbMhr5E0Ljxhb369EXybrniaBdVPiY6cbM77C305Vy2gki5JDL9lr7scl0j8l+tgeiT16N2I5gioUBq4WRMAOM5YYSAHUx3xH1lZsyU/nk6GPK4AFJzadHazSkyD5kSr3nuy1FVSG/sVyHlKFUQyDHIP8lC76rKwHHgSye6WcgAAk6n6yqGooWMa18pwjiSkoEScoTc3N704c4fZaKOVK7P/BX+6Yr7P32rOOtl2UDxkiRasPOxxkO8WI3zNDL5EZIqHTwG1D0eb4LzKsJbiVifSNuu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDQI/XjZbG+EmlsU4c+J0xXipjP4X91tviOpv+eoNrs=;
 b=psdpF9oxKo8zpLJAkEBkNH/L6GKYGZ0sESzUqbtkVOgCHmqgnFI5M9boMnVwJIztEcP6uCE9O56CJAysBpMGEU7tM3iZXM6t9dCrYQZTtZFuhmUWv61z/BbYGjp6E0WeiXMSah3eWsyJCZrnx8qKCTntLZtuhHMlRWtx3rg+L9aK6JnHFUpW9+mTRlAJxBaO3tgvXJBR5f2B4zusJ9lGbzUjLkkzvvjXQpP0500iLSbGbSBCxnlD79jLwogaIafTr1VeoKESSRl0G2j59cVwpMU9qxyPHnmVlT6bmK1P81B6YkWC1OhxsCQq5F4NMU3Nd5g8FWGq5TLneVh/tBiaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8675.namprd11.prod.outlook.com (2603:10b6:408:219::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 20:52:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 20:52:56 +0000
Message-ID: <73ae0a3c-96d2-497a-af64-2d87244dbb53@intel.com>
Date: Thu, 21 Nov 2024 12:52:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] netlink: fix false positive warning in extack
 during dumps
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com>,
	<dsahern@kernel.org>
References: <20241119224432.1713040-1-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241119224432.1713040-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc41783-80ca-4050-d38c-08dd0a6e798f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qks1NlAyVVZMeXQreFRnaklLbDRuMTlIVDlFQmxNKzQyd1RFTk5palhWa0cw?=
 =?utf-8?B?akFQZ1E1THZXMCt5dEt4eisycU1JWjhTN25JWGZmRllLMW0rTnFzYkdJcDh1?=
 =?utf-8?B?UWp4QW44THFhS2RLa3NacnN0SWtFdlc4V1FSenQrbEI0MXdrU1Rlbjdsam42?=
 =?utf-8?B?dE00cnNydjE5VzV5c0dObnMvMHJsT2t4WVN3UmNQVUlYQXZpVTBENzBhYjhQ?=
 =?utf-8?B?SGZIQk1oR0E2K1grY0J2WnEvMm9tY0VSOUFXQU12VEpTSnVPMmUrNHZRbkZs?=
 =?utf-8?B?NEowc2cyMXYvYlBqRDhERnAwWHN0VkU4SThQcDZHdzdGSzdjMGVEenAyanVi?=
 =?utf-8?B?V3REdzdTVVBxTklmMXljMW42aWdna3N0V1FDTldxOGtMYk50V0dFNWxYVHFT?=
 =?utf-8?B?TU1OVVp5cmVMY0Y2c0R2NW5rQ0oyUjFEZE5JbDIyc3RFVGg5dnBic0hjd3FM?=
 =?utf-8?B?aUxtWlA1UVBlMEI4K2xxNnRqZzBnWTRZcXppT1psZER1TkE5eG9pMXl4YytI?=
 =?utf-8?B?WUtZTDJOQTl6RCtTWmZ3VWNVSnBONkFkR2FkTkc3UTN0Tk1YbGE0QzRaV0Qy?=
 =?utf-8?B?Tzc3NnBwTGpPV3lVcDNXMzhTNEYvekJqZHc1Z0pLOU9mdTdud0Z5WW9VVGc3?=
 =?utf-8?B?ZW5QbXJmOG1IV2hWTk1LUStVUGhLdFQ1Z3hBNjhqY0podmQrV3VrVGhjd091?=
 =?utf-8?B?aFpOZTJOKzIrajVQSmM3bjlPUTl4OVM4d2ROQ2RMdkMyUktrbUxvbGVmaktH?=
 =?utf-8?B?VzA0SzJBbnp5c240SDlsTDJGYlpGMFRYVmNIL0RlRk1qTm9mNTNDa0NHd2tV?=
 =?utf-8?B?OVhVemtDb2hGbmtMZFl1Nkd6RHgzWDVhN1paNThxWFBSMUlyWWtkWitydkwx?=
 =?utf-8?B?NklhL2ZMQ01DTE0zMms5Qk9RbUwzRGc4OHVzV3J0Vk96UURqMkJPMHpjaktV?=
 =?utf-8?B?SlNpYXE1QmpPOGo3RkNoTElhT0FMek9pNHlUT2JuUjY4ZTgxNEIxalJvVlhj?=
 =?utf-8?B?VXdaQnRRZzNRTUlhZ3AvZEJhR2hDK3o2K1lEZG1mYmZ3eldEMVA4ZlpkcVJR?=
 =?utf-8?B?UGJicHJ5K1VwN1BzMStMblZZMzBoVElHMk8veEFmelAwWWw0UXZWWjk2OWxL?=
 =?utf-8?B?bUZucEdTVFBGbERxbG0xRmxsc200YWJseWdhZmpKSFRpRUd3REZ2VTE5QVZX?=
 =?utf-8?B?cDRFSkFXUVJvUFRDNXZ4QnA2eDJYc0g5dTFmTS9pVkRIQXBrMndVZ3FIdzNP?=
 =?utf-8?B?UlRITFpuR2V2S2ZzVk5SNlBSaUExd0drUkZxeXRlbk9yeWRrN2kxU0R4WXpX?=
 =?utf-8?B?MEx4aDMvOFVwTGkwbHRiK1FBWE5mclRJNVhRVUdlU2RRVzZIL3p4YXVZQmpP?=
 =?utf-8?B?eDdMWlRjZXlTdzBTMmdEdDhvSm1KK1B5RGFYSVVhNXVTNG5lOFpveDFOTnFT?=
 =?utf-8?B?TTVYeERFbXFMZ3NXVVJpWFh3eXdoM08xNmNGcFkvOU1IOGVVdnZLR1p5UHJv?=
 =?utf-8?B?czVhRzNhbklEZ1AvZnFPZ28rcU00QjJEVU5MODNMeWlNZm1xQnFKOHRJYVNK?=
 =?utf-8?B?ZGw4NzlYWVIzWnZlV3FWZUdKTU1oUnFjSHZndnhIUXFTYXArbTZjWDRSK2NT?=
 =?utf-8?B?dnpKMGZXVmdpbjBiMkY0MS9sODBLVk5xNmZNNFlXc0NVWTBrUGZvTDJmT3F4?=
 =?utf-8?B?UDdFeUgrMjBoVW55ak5pWmw2RDZDVlNLZ2JrWGh3YVFpUzJEemhFVXROZTh4?=
 =?utf-8?Q?CnwfQF8gKcEYTYD0RHrBVCKVx7k4xi21WSKCAXn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9YMkJ6RWlDMzh4RjE0dFpGbk1sN0Y0aTNXb0djUTdCK0F2eGg1NlcrUEtL?=
 =?utf-8?B?dGRlUlJPaFVZN1pZbWhPZ2hHclBkSGlUVUNCdlZaZTJoTUJ0Z2hpMm03S1R3?=
 =?utf-8?B?WmZVM0JqcGRPZDRCTmZ3S3lSenUzdFdiS0pnVnVWYkwyaVhBTDhqbW4zMVFZ?=
 =?utf-8?B?bG8wc3R1bEM1eHQ1UzlaQjZTK1JYdmhpbXU1SW1SRG9TWTZZZHMvWWRUTExx?=
 =?utf-8?B?Y21DRHFQY05QT0IxbG11NkpBMnN4aDJ0ZnE4ckJVSmM1eWVqQkJpeEZUZWk5?=
 =?utf-8?B?cFhJc3BBaDQ0MzNRem8vZUJBc3FZU3dKbURLN1dKYzJqUzJuWmRVWkx2aTB6?=
 =?utf-8?B?SkNPUy9HVVI4UGE3WVZzVUNNelVnRzBOQ3hzZG0rRFl2V1A4MEEzY2ZYcmcw?=
 =?utf-8?B?UWZaUU1UZmt5bGoyNDBJV2R6T0NDVk9uLzUydllUL01CM3hzRVJ0R1Q2S0JT?=
 =?utf-8?B?MnQ0YTNBaGdyWmN1Y21qSy9qcjEvbHQ4TVBqck5XQnMxdlBKK0EyTUxpMzQ4?=
 =?utf-8?B?VCtzWnAwOUFLWC85d3VPUEZyV2RrdzArZmg2SzBRN3BQdStNSXFzV2hyc2kr?=
 =?utf-8?B?ZVpHSTNwRWlFaWtZM0hjeFJlaGdSbzJDcyttU1R1UlArU0VsWGV3YjFkVDFy?=
 =?utf-8?B?TjdUQ3ptbCtJS2d6WmE2bWZ3Szkyc1M2Y0F3YWRXTFN3eVpJN0c3eTBOa2gz?=
 =?utf-8?B?TGZtUGlSK2xVSVUrKzFpby9iQmhNbTJwOGZpWTRKQlE4YTBZd3ZwSzZBZVYx?=
 =?utf-8?B?Ry9aTGpFejQ5MjE0c0phNXRwd2U3WXRWV2d6R3FhOGh4emZtTlVZNjR6cjlF?=
 =?utf-8?B?bnhNZDVFdmIxYWJ6Zmo3WkdsZkpVa3FxL1krSEVmK3lrNTR6aVA0MHhXajJQ?=
 =?utf-8?B?djJrZmo3V2VGeUd2Z0M2MVI0ZXZGb2tjdDNMa2dqYTQ1bGdxY1Z2Yk1nbEZv?=
 =?utf-8?B?U2JJRXpvZTAwL3p5a0JjRW44ZnNsckszNHd0UDNkam9MbU9XbjA5RXhEVkFu?=
 =?utf-8?B?TTBpVEllQVIwbDVNL2gzTVNNY21HOE9xcTVzaGEwWktRTXM4bHB1azhpdElC?=
 =?utf-8?B?djFLT1dXTHdYUlV4aGwwNHpGaDlUTFVlckdYaGFXNGJSOHdiTDBrUElGNHN5?=
 =?utf-8?B?Rks4dnRudkI5S2ptRERrTVA5UHYwekE4c3FKUnBCaUZxNlBVZVZNYnhnRmlS?=
 =?utf-8?B?RzVXQ2x1cGI4eERFL091UDcwbklIMnFOQW12cXVBVWJxZEpmTFBNV2ZQY3dT?=
 =?utf-8?B?cWd0clBwTytYdXp5Rjh0NGx5YkNGZGVtQUNvU1o2WTZ0c0xaeDJFOGlQRy9M?=
 =?utf-8?B?R2pSdXFsUnkzV1BrZ2xXNWxRUXlMTjQyUU5idXFweWZJQlZramhRZy9OOEFI?=
 =?utf-8?B?Q2N2MGl5aWxRMlIvK3dYRXBMQk95ZTkxWUU5WXJad0k2YzUzSkRQUEd4SGx5?=
 =?utf-8?B?UEtEallkT01JcTRPa3ZqQ3c5bkJLQlJNcmkwUHpFek9ZemVSci9NNzBSYVpV?=
 =?utf-8?B?UmUwTUFSM1d3elZyYzN0NXErbmMvMzh6blQ3QmdkamQzYUNMVkxBN2JOWkJG?=
 =?utf-8?B?SDE5Z2x6bmp4VjNSRlBveUI5eUZ2TXhISHpNVmNGN0c0T0t1TnVMR2Z5THM0?=
 =?utf-8?B?YkptbHNJN0I5VW5PeXQyYjVHVWwzZ3d5SWhYbEN6WG1kUjJSbjJiZFlsS2xa?=
 =?utf-8?B?a2ExMWtRWVZjOGNhOUp0S2lYM0ltK3JmZUg0bTBkYWRhbE54RkFDa1hUcE9E?=
 =?utf-8?B?UG9YcjJRMWE3dlFUcEJsMS9VL290bHhPd3lBZWFXOFo4RE5wd25vZGdKdjhI?=
 =?utf-8?B?bE9leGJ1c3QrdGVLc3JXTmRvcEpjK1ljRDR2eTJoeENNOW9pYXE2V2oxbW1N?=
 =?utf-8?B?S3ZWeURNUjJTZkpoa0ptYlpiWU9xMUl5UVdwQlR2ODZPQk41WnRpNVg5ZXFm?=
 =?utf-8?B?ZnZweWY1Qmdka21WYXhrQ2tLQ3dEUlorSHNUcCsxWTcwR21wOTliRHRvc2dr?=
 =?utf-8?B?QjBkOFU2ZlpBTGZFUGZST09WUld2ZnhTR1RpQWFMRm50K3NvS1EwcWJFMXJR?=
 =?utf-8?B?T01mSllzbUQ3a2FMVjN5V0plSXB4RVlZbzJDS2E2ZHYrdHdkTXY1d3NIajlq?=
 =?utf-8?B?ejJzTzBPMmxyVmlHQmhtcmJIWXZJdVJja2NCV2hxTENiWEszWHF0ZjFiNVlm?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc41783-80ca-4050-d38c-08dd0a6e798f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:52:56.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fO/YgzXVvcx7wsKMejwbHxkfRFDlrPOHFj5VFf4ZW+UIBlMw+jsIcPnbjrHR9sGboAhoYyMMsEfFpXYBYMz9kNEewg87wFxpf89tcoHDmrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8675
X-OriginatorOrg: intel.com



On 11/19/2024 2:44 PM, Jakub Kicinski wrote:
> Commit under fixes extended extack reporting to dumps.
> It works under normal conditions, because extack errors are
> usually reported during ->start() or the first ->dump(),
> it's quite rare that the dump starts okay but fails later.
> If the dump does fail later, however, the input skb will
> already have the initiating message pulled, so checking
> if bad attr falls within skb->data will fail.
> 
> Switch the check to using nlh, which is always valid.
> 
> syzbot found a way to hit that scenario by filling up
> the receive queue. In this case we initiate a dump
> but don't call ->dump() until there is read space for
> an skb.
> 
> WARNING: CPU: 1 PID: 5845 at net/netlink/af_netlink.c:2210 netlink_ack_tlv_fill+0x1a8/0x560 net/netlink/af_netlink.c:2209
> RIP: 0010:netlink_ack_tlv_fill+0x1a8/0x560 net/netlink/af_netlink.c:2209
> Call Trace:
>  <TASK>
>  netlink_dump_done+0x513/0x970 net/netlink/af_netlink.c:2250
>  netlink_dump+0x91f/0xe10 net/netlink/af_netlink.c:2351
>  netlink_recvmsg+0x6bb/0x11d0 net/netlink/af_netlink.c:1983
>  sock_recvmsg_nosec net/socket.c:1051 [inline]
>  sock_recvmsg+0x22f/0x280 net/socket.c:1073
>  __sys_recvfrom+0x246/0x3d0 net/socket.c:2267
>  __do_sys_recvfrom net/socket.c:2285 [inline]
>  __se_sys_recvfrom net/socket.c:2281 [inline]
>  __x64_sys_recvfrom+0xde/0x100 net/socket.c:2281
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x7ff37dd17a79
> 
> Reported-by: syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com
> Fixes: 8af4f60472fc ("netlink: support all extack types in dumps")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

