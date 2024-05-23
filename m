Return-Path: <netdev+bounces-97895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7178CDB71
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 22:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CDD28449C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB584DE3;
	Thu, 23 May 2024 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjZUPueX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63741755C
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496517; cv=fail; b=vE7BYFW0SN7rPYWGDx/3QdP7nV69sqO/hMCZMT28DlMC+7n6hkeiJSnzyNFLzqYy/t2Y9PmKtKRFsezBjPQjrstV4C+wA1dk5QttTlzBuhGy+2RXzEEplcloe1NshWEx+zPqvi7Es2d9phg7CLCK1NM+7vljBl+sFb91fKnTRNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496517; c=relaxed/simple;
	bh=Q5R5KY5PssPOMp4i/vJWjUt8TDcog4kVZnznwP2Czxw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BXsUegPwfTo2yhQ0krVZNL+Mwx3VLVWGZraFyd0s70MEsJySh6fpn6cbVPG+47zHNha4PLmhUKq88blO8FOoZSwrypC9Uxcs+EBkSsGF7xo6CCW2qxOaRaiNHUoBj/5rrqT6rctdSxUAvXlxmUCILgZqA5g5VdOHDgcYa1pzZlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjZUPueX; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716496516; x=1748032516;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q5R5KY5PssPOMp4i/vJWjUt8TDcog4kVZnznwP2Czxw=;
  b=kjZUPueX8kD/KYrnJaKQpeGIVpOcDW2470I2gijvjrNsKhY0lFmPPM23
   x1GGGF1DmzpJO7oTFFBV+hS5wTDzka4+vkj2RYJdcfA72RaJUfr8Fpo9L
   G7HqpfBFdQybhs087+oQKTQtvmXGbYP0l04M0HZq6438djqP44Wf0im9P
   PcDU7wtrQ6Io/NhLm6UYpBR8OX7WGKXIwf59OX8lCIJVUqRGNJIDlPR3f
   Kf/PTLWZqx+EosAh+xFsTfSs86RE3gdIPLCi7/2UwkC94yiN1CvKBGAex
   4SVKIvHYkLOZrezwiFyN/Yh/Fr9KvMa0mkwIJyFXhLnCc3LIMrzctxRPY
   Q==;
X-CSE-ConnectionGUID: h4YAkpOER2OfyzBND7B+ow==
X-CSE-MsgGUID: X1l4LMa0TMejHjgBggeCXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23980475"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="23980475"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 13:35:15 -0700
X-CSE-ConnectionGUID: RWQSWGQMSnyAG1D0HjCEYA==
X-CSE-MsgGUID: wdCcD5IiTT+vuX0bLOoshw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33763678"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 13:35:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 13:35:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 13:35:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 13:35:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 13:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOxc4TDUWcMFHUI+4udOWVAh6uFV04/cGHN8Ik6bj8G8ae+oblsiR8XPvQQDox4FInnvp1e81ruRiM5jpQvCTLLgqdDJtlXbIJxE4ESifSf4D2WHhX6SLyyEMMzn1ROUSEG8DugxZ3BjmfCa38ItApmUQULGu6EuIiAGcrQf76Yy8TUVDN6AQoRYyKPe1cFa8QvpNaIJvueJHpC1STZ5nsCMvWN+3STf8SAtCkT2TcFgUy245/7qGj41AfNIgcQtK+OidamHSlqtLHW1V5PxWkieIX7vTppYew+5pgxV1nyYYws4UTsQklSR7bOfgoDOOKun5sjK+LPv9Qju5V2fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odjHgzxOjyaosJCZIeS61ap8l3NLe04lXHmw5FQBfik=;
 b=b/bkiHsTfmcp2kz8K64z/VtBw3tSEPV1kU+1G0yVubj1HvBb1O6HiC77IUBIxrUDBUzyMw3wzYZsGS8Eb56MuoR9cBs+cif1FuGAUqlwvQtlfhyZ1RZ3W7cyYHgoKgIu4VI8SqoWHqYzy+XN0AXh+79bug7t/BN9dreVE+BF8bwUHVZm6x7p2VP8GS6p6IAC12tgSgvom7JOOjeCR6zd6BO2Bc+ocNxLZm2l8xHXyYMpjmK0LdURArzCL4KR34Ga686kik4SAriDbgW1EyJmJDlC67yZ5OI3iSLEbznz1DA2T3hLmzfV1xdjKTw7nSt3fJrtCBo69hd/XKnBkE1qeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7601.namprd11.prod.outlook.com (2603:10b6:806:34a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 20:35:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 20:35:10 +0000
Message-ID: <4fbf4bb9-0700-4f59-965b-a064f853f2c0@intel.com>
Date: Thu, 23 May 2024 13:35:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
To: <kernel.org-fo5k2w@ycharbi.fr>, Jeff Daly <jeffd@silicom-usa.com>, "Simon
 Horman" <horms@kernel.org>
CC: <netdev@vger.kernel.org>
References: <decbaab6-a9ab-4aa3-9285-0ffa98970c59@intel.com>
 <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
 <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
 <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
 <69ac60c954ce47462b177c145622793aa3fbeaeb@ycharbi.fr>
 <3531fc467a80bf02b83b94707fc3039b51ecd4c5@ycharbi.fr>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <3531fc467a80bf02b83b94707fc3039b51ecd4c5@ycharbi.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: f02203eb-5cb0-4324-adcf-08dc7b67d766
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGhzV2NtN0NINE1rQmFVaE1lT1NudTJOZkE2R3pTWHY3NEthMUFwanBVQlB3?=
 =?utf-8?B?Qy82aWtRWk9pRW1TeHlZUUxlVk1TSFNIWWFIUWdjbE16L0NYVElUZDlnNWF5?=
 =?utf-8?B?OFdtaE9GRmNuTWk2ekN2akxMQ29XcGt3RmJzTWcxdVdHaUdkQ0lPMG5PakZZ?=
 =?utf-8?B?VTAvQVo0Z2p4Y0VyalljckhJTDR0Wkd6N1REYlhkTE1hKzRBSkhYdThVSkow?=
 =?utf-8?B?UHNxZXh0VExiWjhZVVhtLzVHcHFvVG5qNG5taGJzT253RUw2SUZ6bkdSdUg1?=
 =?utf-8?B?dWZFV0diWmlVSDltVnU1eUN3dDFyU3dEUDYxMDlicVRzY3EwOWxuS1NET2dZ?=
 =?utf-8?B?OVhBeTI0dUN3Mm9VK3ZncjAvZjNKMkttaEQ1UkViR0VWdngwYVVPTXBCMXpL?=
 =?utf-8?B?amd0Mzg2WTRFU091WTk1RzJGOXhPY3VuWHV3TTkrNDd5bGpvY3U2TWgrR0ty?=
 =?utf-8?B?Z1E0SzNoaUE4U29VdlcxRDRtdE1iUUx1TnZLMkZJbmhUMkE3MTVTcEJoZ2hS?=
 =?utf-8?B?UktpUU9obk9zQ2Q1T1FnWU5BK2Z4Y1E1S1llUjUxS3hseksvNjVaZnl6RWRH?=
 =?utf-8?B?bkcycitvWWUyclBHWDBlZTFrUWhFSW4yR2VkQnFTaElOMEE3OUsyUmRCeEhD?=
 =?utf-8?B?a3dTRnFveDRnV0lvenRiaXh2b2FGZ05QekNzM1JCQkJlWmZ0ZzZHbmpzT0No?=
 =?utf-8?B?YVRLay95OHRXSk5rS3ZUYmJzaWorMllIY0lmay9OWEhiZzFHSVZ0amFSQkdt?=
 =?utf-8?B?dGIxN093RW1UR3o5Z1ZYTzFvbXpXTFA2ZlA2dHMvcjRhTTlvblJqTG9xbGFz?=
 =?utf-8?B?K1FsYXB0N3NpWDgvNmRwbmxZMkFabE8vcXNuN0RFT05ZR1ZFRVZkN3ZSb0hn?=
 =?utf-8?B?Z0hKdVgvVnJmQjhkQ1Bjb3M1RWtpQlRuelJVN0U2REJzcWN6aHFic2lvMkNK?=
 =?utf-8?B?OW5xMjJsYS83OURTTkNnSVJ1bnM0TkErbmtzNW9DNzlURi9RQXBtU0Y3cTAr?=
 =?utf-8?B?UFNrdnBHSzBha2dyYkVXWmk3RU5JN0xHU0ZES1ZEeTlMYnZxaEhlTlNVSzE2?=
 =?utf-8?B?TVVkYytKRFViYjRZT3dlb3VKSUtjVy9sSlYzTGZnSW16TUx4Wk4rdGhiUFMy?=
 =?utf-8?B?Tk84UDFnQ2VrYldIaXZncGZHMWc0R1R4aTVNT3I2NUJWN1lLQ1JZM1FUdEpN?=
 =?utf-8?B?c2Jyb3RtVkxaQ2VWUGZNdGpnT2NKQytLQ3NJOWdiSm1pUExuUmpsV3dMeGFR?=
 =?utf-8?B?N25rN2V5SzdNWGJVMElhSUtCMmVucmJna3hEaGNBdVZOaFNFcmNucG83OHBw?=
 =?utf-8?B?UkwraXFRVE5FUkRPY25PYzh0dUpDcUtKZkt4aTU3RXhORStHVlV1R2hncmxL?=
 =?utf-8?B?MHgwNTlOQ09HYzZ4cUtQYVhIbURsSHJYcHRTWExNRE1WVzltZzJxaUUrTHpO?=
 =?utf-8?B?K3BaeFVQRWJIR0FxNXJjcHdtZEFLQjUrNDFrTUliNy9QMUNVOEVFdFJpQ21E?=
 =?utf-8?B?TVRqcXlHNjNWM1JLYi9MSVJrNGRXTWNKSDlZeVdKdmlXM1RNd2pURW5FSGNy?=
 =?utf-8?B?K2o1dHhOUThZbUxQcW1pRkVZdWlWVlkxMnhJK1VZd3FWTkx5V2VzKzBXQzc1?=
 =?utf-8?Q?zL/UpmqPZQZ3J7kKJJ/DxUz7e/ExVZAThyQ6jzdjmFXA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGN5NEc3dXhaM1B2d0pHNTFleVVJdy9NKzRDR2plQlovUDVBc0lKTFl6MGpH?=
 =?utf-8?B?aE9YQ0lDNUU1Y2k0aDhvSnZYZjhuZGhYSHB5OGdhYVRIWUQ3amE3Slp5L1dH?=
 =?utf-8?B?YjlPTEIwVU1VSjhiZFdPcVZxVDNHRWswWjk3M2lGejVBMzJhcmZDYkVXSWk0?=
 =?utf-8?B?c3ZCU3dDaVhiUS9adEZSMno3WmxnQTdUdzFCRENBWGlydmFod3p4ZGRBNmpF?=
 =?utf-8?B?VEp4Mm9FYkxzS0NHaVFTWTBzWDFPbDZPTkgzYTUwZWlISjJHZDVPR3huNWhG?=
 =?utf-8?B?aVpia2wzNGhwS1pUS3MzN2JWZmV0Mlk0R2JUOGowUjBZQVBFQTN2MjZHUmNI?=
 =?utf-8?B?WFJXOWFVY1o0bm5ITytUWmsrVGJQSGFHb1FpVmNHWGxjQ0NsUS9ZUndiVEJp?=
 =?utf-8?B?Sk96Z1RWb3VEandHU0llWGx4VHRybGhZZFJOMDVtYnNkNmlCOExPdHVobVZp?=
 =?utf-8?B?dm5iam1BWkRTUnpoMDJPdHdhcWlEQXNVNkFrVmphV295U0ZZd01LL1crT25V?=
 =?utf-8?B?UlkrdzNiYmxRcWtSbGV4ZWVPV1JlajJZdWQwaExFSTB3ckZCcmF4TlNQQTgv?=
 =?utf-8?B?R0Y5NlNWNWhjYUFJdEZ6TDNZR2M3cC8wenRIVk5ZSmdTWnBES3hQSHQ4VWMx?=
 =?utf-8?B?YU5ZOXdlcll6N2N2SjVzL0FuQS95YjhoUWtXMDZ2a0p6ZTVpRTA3dEhvZDVN?=
 =?utf-8?B?NnFTQmdxN1duc01KOGVlL25XNlVINTJsWTE3UE9NeG5kYklXZnlOSXR2dGlq?=
 =?utf-8?B?N1owRmRGaW4vUU83U3MzL0RUSGtEM3FqeVB0elFpdTVIN1FWR3RHRVZQOFNh?=
 =?utf-8?B?K0dObW5FOGZGSWFDWU0zUDJpK2dlSVEyVldZcXZuMTBzTW5hRjFVckZ0czEz?=
 =?utf-8?B?bWpncVVDak5JUGNOZ2MySngyeE5BZkZKcWNtdHp3NDQ2WlZpQnhCVUxwNzJC?=
 =?utf-8?B?K2oxdTBEUnpsemZZQ3R1TFFrckhPYm5QOUMyM3lBVDdFU2loS3hBcGFhdnVC?=
 =?utf-8?B?cHUyQlJZVS80RHF5cmdUVWkxVnRzWDVQTGtHNVgreUFpS2h1MGtLeHFZWVB4?=
 =?utf-8?B?Y2R5NEROUFUzcGp0UEtlUkIvejV0L2JpeUpaUXozanQ2eTY5MWhqM1QxbSt6?=
 =?utf-8?B?RlZQaVA5a2pQejI1a080WGhGeW9XLzJxZWM1Q1c0bGM1a2twdHYzMkZoVzZv?=
 =?utf-8?B?cy9BNEk5MkJwaWQ4cWJqLzVXdFRucjJhK0drcXhpdHZwanAweit4Q3JRQ2hj?=
 =?utf-8?B?c1dzNkdRV2JUV1Zia0s5ckFoZEpERlhPWDBXY0dLdHdabitvUEI0VWJ6VW9U?=
 =?utf-8?B?eXhOU0Q1RTg2blNuY3ZEN0grb1VLbVkvUDFERXhPSU1kVVJZdENhRmFodGo5?=
 =?utf-8?B?T3VYbU91Z3BtTnAxN3VNZEZlZ0VoUlI1ZXUvQTBLbnE5TkVTTUNCZ1djS01v?=
 =?utf-8?B?KzZKc2t6NXBHcFJtTW5GMkc0akpGaHI1N25hWmJFRWc4WmdlTWU5cGNOLzN2?=
 =?utf-8?B?SlBCVnV2bzVuOU5NM1RMQ3pRY0UxSnFTTllhalBscDBEdHRKcVVsN3A3VEJh?=
 =?utf-8?B?SGJPNk52TkV1aEwvcjdYYjRxa0VrYmlrYXY2QjZpeEFXUmVycFlzNmw1S1Q4?=
 =?utf-8?B?L0RmTG9lVjNkelZEWE4xcTcxT1BYbHRKUExZaTlWUHcrb25vL0w0K3JaMk0y?=
 =?utf-8?B?SnMvYlVqUEtGbnFNeEFQRzg2a0NSaG5Pa09SK1c3N3U0RzN6bm0wZWJtYUJK?=
 =?utf-8?B?YjN2V0pHSXpycnpPUHB3OStnbnpKR05icVhuVUU5MkRScmNHNjkrVFM0Nllq?=
 =?utf-8?B?QVMwQjRWWGtNdUtsdHZhZVAzZVJ2ZEdBeVVWUzhYakdhRHJPNktGSVEzMDdl?=
 =?utf-8?B?VGVnNTQ3RG9VdHo2MU16WjdVbU1Nblh5YVp6SmNVbFd3ck12TEVIemh1K2RF?=
 =?utf-8?B?RUV4VzNOOHoxMVJoQ3JVSjhuaDh0eEY0TjdPMDREdzVVeStxd0ltYzllSThY?=
 =?utf-8?B?QVF4OGozVmg1clFlV2hTMEp2MmxGRlZEdGxVTGxTbEQwdDFYOWEzWHVYTWk1?=
 =?utf-8?B?YVU4aTNDakUxUFBMUG1zRFQ2dmlpVzZybmJqeUN6NWs2TGJGb0RONXNTb3d3?=
 =?utf-8?B?N1pyVmdPTnAzeGRjbHdra3B6YmpvcTBWVEJiTzMwcml0ZDdCWkdxSkVnVzAr?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f02203eb-5cb0-4324-adcf-08dc7b67d766
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 20:35:10.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQRji8vUJVNW1isr7ZgNWlR6zn4G22CzzSw7ToVuSkJJkcqLhJKso7wFIeqhV6tEVKDFAoU5JkJxpWtaKg4A9ZdpeEdmu4jM5P30Nu1+Dvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7601
X-OriginatorOrg: intel.com



On 5/23/2024 1:19 PM, kernel.org-fo5k2w@ycharbi.fr wrote:
>> One more thing: Could you confirm if this behavior appears in the 5.19.9
>> driver from the Intel website or source forge? I'm curious if this is a
>> case of a fix that never got published to the netdev community.
>>
>> Thanks,
>> Jake
> 
> I can confirm that the result of the “Supported link modes:” section is identical with the Intel ixgbe-5.19.9 driver:
> uname -r
> 5.10.0-29-amd64
> 
> apt install linux-headers-$(uname -r) gcc make
> wget https://downloadmirror.intel.com/812532/ixgbe-5.19.9.tar.gz
> tar xf ixgbe-5.19.9.tar.gz -C /usr/local/src/
> make -j 8
> 
> modinfo ./ixgbe.ko
> rmmod ixgbe
> modprobe dca
> insmod ./ixgbe.ko
> 
> # eno1 is up
> ethtool eno1
> Settings for eno1:
> 	Supported ports: [ FIBRE ]
> 	Supported link modes:   10000baseT/Full
> 	Supported pause frame use: Symmetric
> 	Supports auto-negotiation: No
> 	Supported FEC modes: Not reported
> 	Advertised link modes:  10000baseT/Full
> 	Advertised pause frame use: Symmetric
> 	Advertised auto-negotiation: No
> 	Advertised FEC modes: Not reported
> 	Speed: 10000Mb/s
> 	Duplex: Full
> 	Auto-negotiation: off
> 	Port: Direct Attach Copper
> 	PHYAD: 0
> 	Transceiver: internal
> 	Supports Wake-on: d
> 	Wake-on: d
>         Current message level: 0x00000007 (7)
>                                drv probe link
> 	Link detected: yes

Thanks. At a glance from reviewing code, it looks like ixgbe simply
collapses all non-backplane links into 10000baseT/Full.

