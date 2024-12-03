Return-Path: <netdev+bounces-148626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807709E2A2E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FF2165D55
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D381F75B7;
	Tue,  3 Dec 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeNGi3LB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403021FA16E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248873; cv=fail; b=kAxIDngzmpLtWshq5ruouxq/KzRL9kzvBiA758Q+frhRTf3eFdInbUmskLL4UfWDkivZfGiyFWgVeHCRbYNOjOijdaKqQSwpD+vcspwNUnxioxCzJW4JOoltZx2ySqAwaY1ieBXsJRhQTKCwuBWtB77PgUwSaMSJhO95ipewhF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248873; c=relaxed/simple;
	bh=OvTCusFMvSXPi2u9exQGvtbn2dttVd5OGHm2VYmBow4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGZjWHG2CV+AqYaAteoeNgpADbHWQjFxlROTARj7JhlBtP5PSr2l6WbHgaKQ+ylyX1cN3gxdLK3JXWBk1kkXcMWCeQP9peR1RQfQEmsPRhnoczHnsGZKnk6ekVrmugin1/sBUgRICSFVXBrMxPi4s4TSyb1MKOG8Yz1oAE6Fm2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeNGi3LB; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733248873; x=1764784873;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OvTCusFMvSXPi2u9exQGvtbn2dttVd5OGHm2VYmBow4=;
  b=HeNGi3LBFeZRv3RG0kX2Pvu4hgro+KjsmB2DjJUfyntoB5IPsp7ZW9EL
   lmK00r6X28tL/M7a35wELhBr34zl1g8W9a09FaAGXI2AxSH/LXu6tu+hw
   /3PuLIi0Y1lK7sPdMgkCJob7kKXuGyDLCvMejO0kHiR53glBqxMIRU3oo
   LKSDtE89B3iA3bKtiZlnB7NDi1YiCUNvBW2+C/Se8jHk+DreLtHLikKtA
   Z35S2fS+HmBYIPp2uIxTW226lyiQbq5z73kZUFeX5cB3YfYwid28k5FDZ
   /z1AKhMppJqhG/Fskct6LvWjlEQF4DMrHhCC00H+f3UsYbBnmsxrsMl29
   w==;
X-CSE-ConnectionGUID: ldEcUtCxQnSmg+UwqBesiA==
X-CSE-MsgGUID: LTAgGCb0QmKdAK9pliSCjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33403059"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33403059"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 10:01:12 -0800
X-CSE-ConnectionGUID: WOm+tjzsR7ydzLocOXVtuw==
X-CSE-MsgGUID: AsLpb0WUS0K/yL/H/lFFjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98524468"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 10:01:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 10:01:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 10:01:11 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 10:01:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omdLqzZSVt+pgClaBmp0/ijg69wGy/4FmoSxgDiCOjXtFEeJBA/f6aukYWfkbKwmzQlAZ0BloutfrXvS94X0/Z6fBIIzIz+LzH25qTRhhE2axi5L16Futu9dcVwu/ij6Nf1x/K4I46IeFrhLI/HhrlfJIpk0wnPQU3FL6vfLgnge+Pa29sKjUu0qBP/sJDjyVOk0GSLngeb41UfdIxGAUfgNK4JTYQa2wXfoJqHGrgi+VhKfMy0Ib/7Z6dRJOazicWNoYjZBcKGu7u7raAQoK2wx/KyHyOCtCbsD6t6GiaebNhU8Ok07fUgnJ4I5JIM7vNfjW7LDM4vvT8/imf1OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+55y4YWdsJjjbO19RP2tO7RpeUQedMxwSqQK9v4ndQ=;
 b=ZGDuFa72wbxB+HbUDEhIYVcfaANPWAFoeKSdfBIPEbHbPrEgWR4s+eKQ3OsXibY3mTH4heKxXwTSV/pMQJKcn35FqWWjbpSsdn/wePpSTgCP1TMoVxYHzz94zuSauDbabtLY5cGIq9M+9lzPGREeXfpNh49+imX36RhYyjsGnhqOZzZW1tawwNL+Gbi899LzXTxZwspy3JIHLoWZDeprFpEg1bkYbhKpaWYgv8VrEkrHbDEqQ3KCS31K3/LqfVhfhA+r4ahstGZcuMW263JClid7CTOTY/KEBUmlLxQ9D3EvWDSZ/WY9kXN0O937+LZvYC3vq3EEWELT6owG1aCjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6972.namprd11.prod.outlook.com (2603:10b6:806:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 18:01:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 18:01:07 +0000
Message-ID: <dfdf794b-01f2-4a61-a208-0907e410b9c1@intel.com>
Date: Tue, 3 Dec 2024 10:01:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
To: Vladimir Oltean <olteanv@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-6-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-6-ed22e38e6c65@intel.com>
 <20241203134354.mormzine4gt37xha@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241203134354.mormzine4gt37xha@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:a03:100::39) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9590cf36-7aa3-4b2a-15c7-08dd13c475d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW04akFwTEtQUTEyZXpLVzBuVnhiYW51TXppZE93OUlFajNadE9Ma1h2TnBt?=
 =?utf-8?B?THY0T1hWSGczYnpuQUtEbmYyYUM5Vks5aEhMbE9ON3hqN2YxeWVUMVRUNzdL?=
 =?utf-8?B?QU52RVpyamVWUkNDWkdBRmQ3NkN6ZitBVm16VDFkNUhvL0ZSNnpUVzBFTHli?=
 =?utf-8?B?TTVnNG8yU2QydWJYeFptWlBBK2p2S2hSaW9aUG9mNER0a0c5OWtUUXdtYmRh?=
 =?utf-8?B?WVY1dStGeWZTRnZQSWVoY0hzeDc4eFhCdUxjU2l6MC93SFVSUmZDOGNzRmJz?=
 =?utf-8?B?VjZmT2czdUp5STFTdW5oVS9GWUJjdGVlS3FaTHU1YmE0ZjlYUTVnQWk3OGUz?=
 =?utf-8?B?d0J5TzYvMmJHZ3VJNmkrY2wrOWpFZXNRblBLa291K2ZrVU5UYnk2TlJMRkRD?=
 =?utf-8?B?UUxmYmZsbWJtaTRjeHNjbm13ZTB2T25YUVFSZGVNL2xDeldFcEpnMzNqWlZa?=
 =?utf-8?B?bmxRa2hKZVNJWTlhM1BOVWZYK2V0K013bVZGY1VxSWlPcXZ4NHhKczEzZ1Bu?=
 =?utf-8?B?WkQvY2l4MXZWOTV2ZkoxMWdMRUQ0alBOSUJTQjUzR0NOUlo3TURwZjZpNkdV?=
 =?utf-8?B?dmNWWm01TFRGcEFKdEJnV0FtazBZU1J5bjZMMHR6QmhGNHNBTGFDS0xtK2pN?=
 =?utf-8?B?WHlvcDJHNzN0WU1sVVNDV243Y2U1NTUvZERyaTZ6VTlUOWVDTmRxWGNFcitp?=
 =?utf-8?B?U05YQmFnbnU1dXYwY2NiZ2s1bGhRZHNCQ0VHcVFWR3dHQzl2WmtmWFB1a2Ur?=
 =?utf-8?B?V0NaTjRaSWIySUd6WjdnNTBDL3ErMlVmTDRpWmU4QWNpc09xaHhrMWZvQjdJ?=
 =?utf-8?B?UUt5ZWR1YzY2bWJHYXUzb2hiVHEwbTBBMkRLakN2ZGg1cHE1NUZ1aStKWC82?=
 =?utf-8?B?ZGtWWnJtbVluQ2xTQmZLVVFLUHJkWXJwSERTRWRRZzRwKzlLNTdLYWVFbVRq?=
 =?utf-8?B?aXJHSW5mNjJwU0ZiVjRHcERXaUpRUXVzVFU0TVFoeDFhVDVaeW9EdVJDWTk3?=
 =?utf-8?B?V1JYYjNKWDRhTDB0U2FSdTBmZW5Qcms1S3YvOHphSk1tQ0ZmZWlQdXV4dUpx?=
 =?utf-8?B?TjRUY3FhL2lMaFlKMkFMZmRqN0lvcUZLVUNrK1JTUW9QMHpkc1VTaEZucjBx?=
 =?utf-8?B?OWJIdzAzWWJKVGNKcS9FVWlNaXZhSlZDcmZEU3NYSDVaOXZwZzJqbkI5MW1r?=
 =?utf-8?B?azJwKzZ2Q21aenhGVzU4eEU4WDRQNkRUNFlJaUZleE0waFp0dEdNZVYyZkha?=
 =?utf-8?B?Tmpkb2VTVTkrL1piVG90UTFsTW5ZOWE3Nk5iZTNSazRsYU9MdDY1S09aRTRi?=
 =?utf-8?B?N2ZYYWJCRlFXY3EzdDk3UVJXaVZhcDRmdFVOYlNBSkpXMFBRQk92NmFDQmNE?=
 =?utf-8?B?NllQZXdScXZnQnZWcXQvaWwrTGI4UmZ2Q1c1c3diRTFuc2RjNHNWdE81N0Fs?=
 =?utf-8?B?a0poTVl1cW9QSGU1L0tyLy9rTXRKSkd2N09jMFZ5QThRSHRsN3FhMDMyanlv?=
 =?utf-8?B?WkhnT1VoQW1lSDRlcGp1SVpTVmhMVm5xTHlRcy9NWnpLSnFUL01YTmxWdmV0?=
 =?utf-8?B?MGVCMlhBRnFPL0FGNmdLQ0tZYVloaGFhTDJpajlONVBEYmx5WEYwRkhVNnNM?=
 =?utf-8?B?VUFHZ1AveDVCL3RVT0VHbmtSM2puM1VJYmFXNTJ0cExQNlY1azVnSCtXNFRP?=
 =?utf-8?B?b3lyaS9CNTFWOWVSRjNqUTdpSjgvWUZySUY3K3NEY0o4WWs5OFpEUklQVTRp?=
 =?utf-8?B?MDNHeVVLK2I5Z2RMZlRFc1ZrTWlXZm5MbEduVzd1YVMrdXRFcDFjVGkzOFla?=
 =?utf-8?B?c1ViQkRzR2cybkt5WkZLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdpdjMxNmlEcXFNdEtTdktyMlU4em4zN3k1OENJcFBRNUFSZzRneUlUVUhQ?=
 =?utf-8?B?Znl4ZXNUT0Iwdm8ycFRBTEZqa3N2clZxbzRmN3ZDZ2ZONkIrcGd4ZWNQd3dR?=
 =?utf-8?B?SHFEL2FHV3VXUE5CaXV6Z1dtM05xa0dVdHk3OUVGZkdOaXNxdncwSWgyeG1r?=
 =?utf-8?B?WTE4cFdjUThUV0tEd0k0N0g3cU9RelZuSGhMYmlNaFJLMW9MTXo5M2JvRmRX?=
 =?utf-8?B?RzJ5Mytydm1mVzV6S2FHTndpSTVUc0FMYXA3UkdYcVZINSt4WlhJZU01ejdE?=
 =?utf-8?B?ZG9ZRFJsd0JqSlFIZU10eUFKN01SUDRtYVAwanJpUU5RL3NTcCtldnpuQjhB?=
 =?utf-8?B?SXFvWUcxYTd5Z2FqemgyVlI4K1lDYmdlazJXYnFWaXFEaVV0aDRjQkdKS1Fl?=
 =?utf-8?B?T1J0VUNyNWZkVGIyTjZWWGZ6dXBBUktHeE9CdnF1U0JkZU1yWU5RS01vSlVS?=
 =?utf-8?B?VEhmdWN1ZjlkbUpvUmJQWWUySFB5bjQweGZFWXBNWXhhMnBheHBOSjR2cnAw?=
 =?utf-8?B?RkNyeWpNWmc1bFQ3M3RaVWJMVklDckFUVkJscktUY3ZrOGMvYjZCNkxHcHcr?=
 =?utf-8?B?VEpzbHhTMEdPT0VHS285QTNSbk1HS3BiMTlJYjhyV05leTBRazcxd2RUSFpz?=
 =?utf-8?B?NCtrcWQ2SkJJRnU0OWM2TEVrb2RtMXJLNmNoYm9SQ3RseG02ZTl0QzFIeFRy?=
 =?utf-8?B?aVJaWERpVEk5RU9DZDhZSmdtMzdDTEFFeVFWdG1MZ0prazhKNDEwMFhuaXVq?=
 =?utf-8?B?TFV3NXVMem9lTTQ0eGVWRnNkWGRnNUFxT1BoRGhrby9YOWNnVnhUeUlYcTRT?=
 =?utf-8?B?OVdmTVZFQWFvZTV6dndySkYvSVRVaUJOOUVnSFhNTjdHWFhKTXBaZy82RStm?=
 =?utf-8?B?MnpUU1VqMlpuL3hieTh1ZEd4blpPcVd3cDNsckNUb3pJaXYvaHpzRG01K2RW?=
 =?utf-8?B?M2xNK0RLRlJoS01wUDJkMnhiVExWNk9kZ2p1WmMzN0M3TTBzKzR2bExWNGhh?=
 =?utf-8?B?djhZSUY4NHpEc1FUQmVCTHFmWjNpZlM4TE9tTkdBSHljVithWk1neDV6T3RK?=
 =?utf-8?B?K3hhQ0JocG9mWldzZ2NKd0dVU2YwQ1d2dWREQ3A3SEVnUnlUV1FBWFdxK3Q3?=
 =?utf-8?B?NFdjQWNKeEVnTFJITVorcm1KUzBGMGdGOVg2ejBXZGxUMGN5OU9zYUhnZUJZ?=
 =?utf-8?B?QTdvcnFrQUlFOUFpZXlPVVpSZXp6YWdpbzNZRzZLdkR2dStoMkVsM0hpQmk1?=
 =?utf-8?B?NVlPb1VSRG54ZUlGSWdhTFpUYlBnTFI1NHpYN2JCL291YW5HNklINVQvOUlZ?=
 =?utf-8?B?OTAxTmN3K0d1UnV6MzA4dk56aFluQUNDR3ZwMDZpUE9WbDV0T050YmNBUE54?=
 =?utf-8?B?M1daUk9LMnBwU2N2Vll5cDhDeU1UMXkvN2VRWHJqSlpocDltOEoxQ3RyaHhx?=
 =?utf-8?B?V0c2dWR3NzFZZ0N3Zk5KUFlReHl4L05BS0JhWmUvSGYwU3ArUVhwM2h3RVhK?=
 =?utf-8?B?VjBjUVZvaGNIcDFUbERIMGovT0xWdngzNUZiRTNPNWpzMnFWN2FnKy9ZdGg5?=
 =?utf-8?B?OWRGbmQybFdCUWxMZ1dqdUdwTTMvZEhMYkUxbnpTWjZSTUlqeHY2OCtnTjZ1?=
 =?utf-8?B?Nlh1d1A2OTFVeldVaWhkcUM3ZHc0bFlzNlZvQlVwdVI1STVST0gybXVGYm82?=
 =?utf-8?B?V0Fsa25tTzhxUjZFQnlqV3RMVlRPMWhqWmFuZVFTZGpmcUxFaDdYNENZdFpv?=
 =?utf-8?B?QmxaUi84cksyUVNFRXVmanVKWnAvSHkyMEhWWlFnY0xIYkJrYmFOMDFMcEdy?=
 =?utf-8?B?dWlIeVhhSFduTE5ybVkzUzdvb2t3R1hDRGpIbzJzS09uNVBOUEhDalJFVnJB?=
 =?utf-8?B?K3lUc0VWWDV5Z3cweXZXVTRNeVR4SnBnY21RZDFMbUU1VzRlYVJqZHNoZDdu?=
 =?utf-8?B?YmV5dUpnNnZxbGprWS9BUVlmRVlyOVdzOEsrMW9obGlGN3d5UnVlaExLbEo1?=
 =?utf-8?B?VXpuOGplVG9YK3RuakF2ZFl3UTJVUjV1Tzl5Z1R5QVZhakpGQVhVREMrMW5q?=
 =?utf-8?B?dU9aZHIrVy9iUlhZUGVnUzVnR0RnbFphRDl2ZXpPMFVJZjFqbkJRayszMlgx?=
 =?utf-8?Q?0LkPK99etkIDASLBLTJDAn0WJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9590cf36-7aa3-4b2a-15c7-08dd13c475d7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:01:06.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Tbyu4ODGU6P7I+McL2UM5nRgcOrimRdbwZHQy3T78K6EFxyDz+S75DnlTt5WRGi+fl3B+hz0gOgqIAsZOnA7KT3a5J8jOtBcFNBE9DL8ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-OriginatorOrg: intel.com



On 12/3/2024 5:43 AM, Vladimir Oltean wrote:
> On Mon, Dec 02, 2024 at 04:26:29PM -0800, Jacob Keller wrote:
>> +/**
>> + * ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
>> + * @ctx: the Rx queue context to pack
>> + * @buf: the HW buffer to pack into
>> + *
>> + * Pack the Rx queue context from the CPU-friendly unpacked buffer into its
>> + * bit-packed HW layout.
>> + */
>> +static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
>> +			     ice_rxq_ctx_buf_t *buf)
>> +{
>> +	pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
>> +		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
> 
> An alternative pack_fields() design would enforce that the pbuf argument
> has a sizeof() which reveals the packed buffer size. Pro: one macro
> argument less. Con: too intrusive in forcing authors to write code in a
> certain way maybe?
> 

Yea, I had it that way in an earlier version, but I ultimately felt like
the resulting macro was less friendly, as existing code may not have
structured types with the appropriate sizes.

We still have to enforce that the size value is a constant (to get the
compile time checks) which I guess has its own downsides over forcing it
to be sizeof().

I think I'd prefer to keep the simplicity of the 5 argument style that
does not require forcing your buffers to be structures.

>> +}


