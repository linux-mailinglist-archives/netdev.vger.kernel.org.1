Return-Path: <netdev+bounces-108947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181719264CF
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945CB1F21D54
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC8C17FAB6;
	Wed,  3 Jul 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldUpAO1m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25517E907
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020496; cv=fail; b=kAH+65gKOMmnTjcd1Z4jCBLHGYXcAtHs9Dtl9ek1N8pyKF4rHgd2bDYtSVLIcYSVFfsbS4UB7qCbgP97GOEt5dy9V03px/VK+1Vu5QdsMfXCsSLk0AnDDy+1OKPi6OyVRi0l1FZoFGS0oopZInFn3whLFnodvv47V7U3zU5Q6Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020496; c=relaxed/simple;
	bh=IVrH3zZg/aFihzGblCMeavdBwPnx6bpeJv5DtUm1iqg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uonLTavvFtEBlZou/325dEo3+rjdCWohbw24u40ePrUsLqxBp894G1GGOUVaZZfCGZTD0daIpLa3KhN8LmKVjZY5PJpnagYVwRPSbvvdfA4FfueZ+cABj4xGfpZFhWulEjxYGCv0ivxTzT7X9zlnpe+208/SHTNNHCbkCCJuPHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldUpAO1m; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720020494; x=1751556494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IVrH3zZg/aFihzGblCMeavdBwPnx6bpeJv5DtUm1iqg=;
  b=ldUpAO1mxZVVdcJc60vMfyrgQ1lvO0zs1SaUv9rjUfpC0Q9OG5DJE2go
   mt5dskPNpdCLzdtSWtfmcGHlCx6QA+em75Qpfr/aapHw6zh3s/xngjgyZ
   F5NaZjmsXylzWdEYnB/Y8nFXZSMIX4SJjL+Z8osP4Go8xJ3B7HedeujgV
   KWgssieTNNi3MjhtGyUrFE5SazVBWegsTHMMi96DZsDHGUKS5uRYG1u8e
   xw+3hgbYlz9dyrYMXF9uBIprpcZSEfjXuHQs0cm/2Cmnj3Gx6XoKhaq2d
   UEU5Z/c8/RkLylYDlpa7XrO4taS2B7AoVfjD09WuGViiBz9k/RcQp5+Bd
   Q==;
X-CSE-ConnectionGUID: xITQoRVHQz2DUIDe7g1Vog==
X-CSE-MsgGUID: rF6IgWRRQaKc9f2meWmlLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17095685"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17095685"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 08:28:13 -0700
X-CSE-ConnectionGUID: wsgJhJ7+Q0CWPFSCL7NiRQ==
X-CSE-MsgGUID: 5X3e6t8xQy6dLk0OphfWig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46064203"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 08:28:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 08:28:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 08:28:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 08:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gb1yyN6dxPtElOAMbtidnUH0U0R3wZztfHeecQ6AQz73WKqkQn1jH067lkEBTpp7AoRVV3OxsnUFZbqi5cYWaNG0tX72poZ34fJWQgieGfejqpDPEtP0MoDEvUn6Atw7M3hQJXJ67MyFwZOAEV6lhuQrUEcaapcD1yStNUrr1klWr+ane4JcT3rPPhlWr9Zd3T2sWl6Q7NNp1PQRjl04kRxv33l9GFwYn8FDKnS7eamxOqQTRlyYi+NYS1jtHZgfeKufwaU/l501eOpAtwF7RVm/xqJJAshIjne/ELYWbGEkjD4Xoiip6Eqklc1JtVVG+EC6eqjJZ4q9BJ6fCu19+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCDYHYXhCzlYZ+vBN1l6aInxT5VjIdqcReML8+5pOxk=;
 b=QvUK7yrCqhNVoCcEFXgfc+hMnbRzUs2Upl6TNa7/Ci90xM49nhK5TYDXjGjddt9e/PGCiJTQTsxIh4w+DAFAf1oS33T8h5weQIrqHXlunhZKqdNtxLxCZNSDvSFwGqalvr/yRIoz5NttJbL0znxrBLt8PB7ncCxJ2WJ8BxHFuuQ9AHch2iHxBe1bQQAEKl4jwzIbJVmZuP5Sq6vUkG3PuLEU6hY1b7/dW/Ai8KDIeoC6MpdXSJpS0VboLzi6MZWZWQIYhpUmNzSur85gcmzCDjP7WD6jTJSTFW4iKI02HeeVHGZcPOQJFrix7JYvmLMgj1mx8GJ/6lfodMkbRLQB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 15:28:10 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 15:28:09 +0000
Message-ID: <0fcb6bfc-a5a5-47b8-a0b4-a9b3584ad2fe@intel.com>
Date: Wed, 3 Jul 2024 17:28:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 3/3] Makefile: support building from
 subdirectories
To: Stephen Hemminger <stephen@networkplumber.org>
CC: David Ahern <dsahern@kernel.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
 <20240703131521.60284-4-przemyslaw.kitszel@intel.com>
 <20240703081648.3109da55@hermes.local>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240703081648.3109da55@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0272.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::45) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CO1PR11MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 87486b3e-5514-4c73-6dc5-08dc9b74be97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDZUdlczMElEWFI2eThwbzZsMHVaSzVNamozZ05jSEFKYkFtKzE2QlRuK2R5?=
 =?utf-8?B?aHZWZytlZGZ4eVptTGgyZVozczhRS1hHbXBxL2ZZK01Qa2ZmVjZqaHJ5Mm9i?=
 =?utf-8?B?a0l6eTlrcG56TVhhMWxRNXB4RzBkYWswQmNnMjhzcEdvQW1ZZnBoSFBtK3RZ?=
 =?utf-8?B?S0ZORHRmemNsZlNZOTVoTGZuWkRqYmZJYktWZzZjTWZTK2FLbHRmY244M3cy?=
 =?utf-8?B?TlBnQjFyRVdjazZVeEdjS0VQT29EVFI4czIwZ3U5UVBNMXBDM3dKTjVFamxU?=
 =?utf-8?B?OE1kOW1lQzRSMXVVT09pdE5VZm84R2hDYy9tbTl0RlNWbkRNeDJsZDROWFVo?=
 =?utf-8?B?aXVuRW1qMHZJaEtWTWt1a2p1S1NOVjc4elViWUJpWjBidjBWdml2bGZjOVlU?=
 =?utf-8?B?bHJEQUFRbGlMWUpBRTRmaTRKSUcyVkRHc3ZldjYvSmYzQmVsMmZ4QVBJNk5W?=
 =?utf-8?B?eFFDYUk1aDg3VU9MZDVudkswaFBiaVpGYkhIbWdCSTJpaERVY2YvMkI3UzY0?=
 =?utf-8?B?dmNxWk1wU3pMRmRCcW9DTGpIcDI3Mk4vbHY3cVE1VFNJSGUwVzZMY281WElP?=
 =?utf-8?B?ZWZQdm9YckI0RUtsa0xSZXpVUGFNQzA3Rktram02ZlZ3cmhvaHQ0SzlNeFBB?=
 =?utf-8?B?L2R0ZkxBN1grdWJ2ZUxTVE93L1FtQ3lzTm5aUSthMUVBMDVDc1M4RUkveTkv?=
 =?utf-8?B?VFVQamdqR0RNbnliZ0R0YUlqWm1sODVFd2w0dkZxcVNCSDlLOXk1MlY1NFFq?=
 =?utf-8?B?dFJ5ejYvdVFBcGpvYTZOU2tCZkpUUVozRUN6d1VjbEtYVkRvTTd4NVlXSFRL?=
 =?utf-8?B?d2xrUG9FdEtQa2FvQ1R1L2VQdGhsK0Y1VUFBcDdCZ0tNa1NpTnZWbVNkckpL?=
 =?utf-8?B?RmFTbFVlcWd5VVhRNzdRUHg4UUwyTENadTVKaFh6M29GVFJaMVVKek9KQ1NQ?=
 =?utf-8?B?aEUwSmljaFdZNkxTTFIxVVVkOVoxZ2dNa255Y1piVzBRQkw2aFNPVG5uOGxo?=
 =?utf-8?B?Yzh1QkhUU2lUZWNnRHdlVGhmYzFtVkJlajVReWlZN0JOdlNyOXVldk9EMWxj?=
 =?utf-8?B?UGJyZ0xsRmJmMTBrcnpRWmpOOW03Z25pbU9KR08wQVczaEtJSFBhd3RwUjR0?=
 =?utf-8?B?VWhiREoxWWEzTDNNSU96eWhZczNtWmFHM05VSVRwZCtnQWFoMVJPMmZHQTM5?=
 =?utf-8?B?bjVxMTlPaWJONGNMVmtiUEMzWXFaSXhtUlRwLzZjZURqTGZpakFJbEM4R25H?=
 =?utf-8?B?VmhDcEo0bFJHS3ovSm9MazhYTWhOSmxTcG1lMkJ1bXZ4MEJCdEJTdHNsRUNZ?=
 =?utf-8?B?VjBZRXVSdHRDcnFNWFZtWHp3RngzK1ZEcWdQK3dxUTEvKzNjRjZIMFhKVnJ5?=
 =?utf-8?B?VzhpWTg1dFpaMklhM216QjFwVE1uWUJVOEhqVnFENkhmbGQ4OWhWakhYbC9Z?=
 =?utf-8?B?MlZkK2pCSXNwczdhaUltZEMwWlUzZ1lOc3NXVFZsWmViQ0pseFpkTzBTYTEr?=
 =?utf-8?B?WWU5bnQ5VmNYQjZvTEtucHA1MUMvTERsbjRjL282aXRLQXU1b2RMVWZOTS91?=
 =?utf-8?B?czdoVWswS2JNbjNYdWw1UlB0NUxHWEpmSnBwa2h2TDlVR01VdEcxckVMMGlS?=
 =?utf-8?B?YmI1OHBua0dJdGl0Qk8xT0lmMjNqOGZFUy9qdjF6VllOcnJTMjA3M3ByK1c4?=
 =?utf-8?B?TGp6REJUQUFxNGtlaHIrVTV1bFZxaS9nUjFIRHNBZGlUVytQQXE2RGRrRy9r?=
 =?utf-8?B?c3cxVnQ5MnVIVkRRclRYT0FWMWJaWlRNeTI4SkRra3dFbFlxTDc2ZDJVK2NL?=
 =?utf-8?B?OXAyZ3o5aW5Ja29NdEdjZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q29UWHN4bzQxclhVRE8vTDV3U3lTUUhyODBTV01IZDlVZ0w1dmdWN2h0TlRW?=
 =?utf-8?B?WXJnZzhhYytudlpEdk5PdUJoeXBER25wWEpVcnJFSlZvbjJMdXBLaXA1ZFp5?=
 =?utf-8?B?aW5kSENsVnZXZjRPMFZPOUtRUElHMWxIK2hRNHRRSWtYbE93dmlzS0xtb3JI?=
 =?utf-8?B?aFpsUWMyTGcwSHBQWUx4TFE5V3lUa2NlbjNMRHBORXZ5bFI1U0JQbllEUDhh?=
 =?utf-8?B?TDNSUEtXVHdMdFhNdkdTdjdyU3RlTTNKejQ0eWFoTDJ0NDkrdGJ6NmttUis4?=
 =?utf-8?B?MkpGZzFNdWxNTWZIUzNEbnhZVGNlU0xaSGxTcFlMODlkTGl4aDN4YWVOOTkw?=
 =?utf-8?B?MWtBUGI5cDRDNUtkWnpkWTJUelpNODlYSGI4Tm9YcU4wYzJXSDJkaXg0UUxC?=
 =?utf-8?B?b2VkcDhtSmNNblNuamY4bXdPa2wxUXVSU1RybkJEYjJhQjhQRVA0WXd1cDZk?=
 =?utf-8?B?QStEUDdiOEFYOS9ZbEkyNlNSL1RMVjVIVWpJTkYxSDMrMmExZ0NrOXNvYjBi?=
 =?utf-8?B?TTNCNDJiSXJRV2JybzJWYUhaM1lBMzBoaXc1U1VIM1F6V3pZWEc1ZDZRcDI4?=
 =?utf-8?B?dTRLZmljY0Q2bldnZEoyTTJHbFVMMVljcXJZL1NrNER1aS85L0pBY2Qrc01R?=
 =?utf-8?B?YmRLNXNEVDlFZkc3bmx6UVJhbkk4SkNtaE53VkJ5SWF1UXNQY0I3K2VJVEo2?=
 =?utf-8?B?MnZuVmttRWcwV0NUajBzOU0zZm5jZCtQT1RhVnhYUW9CTFM1YjFEdUc2TE54?=
 =?utf-8?B?RGRMYUxMSkRxdWhmSHdyeTk5Y2piQXE0NGxvcm9TbVFKT1hLdWd1UkltcVFX?=
 =?utf-8?B?RFp6WkFIdEY2azczZjhGQ245QnNmUHlPZVVQV2l2dVZmM0ZGOVVLU0trMDZ1?=
 =?utf-8?B?WnFVZGNsL3BnNUhFNkhPaHdiY3gzenRsTlluM3l5a3FWREh6dzRXQkt5dnBZ?=
 =?utf-8?B?WFJvMHdidnd3TEtBT0Q3MXZKQ0xKd1BvVVhtZ21YRkRCeWhwbTNUb3Aza3FR?=
 =?utf-8?B?UjZQdFVpb3ptREJpY1YwYlBISHlUQ3R1RnErNndOaGROR1ZaSU0vcnpoRE5V?=
 =?utf-8?B?QTdsWkpJUWxwaStla3V0WHpRR2tiK2lya0E1bExZcno0L0RJa29wNWw1NVd5?=
 =?utf-8?B?WDVleEpQOXU0RDBkZ3dOZkZEOUEvS3NqalNGRjliZzl0azlxVmFIcUtWVnJI?=
 =?utf-8?B?Z0RRZ254bzBnTEUwMmp0WmozeUttZFFNODBVNTJwYm91WmVCenJ3TGlnQi9t?=
 =?utf-8?B?c0dDSEkybWlINzdGcm12TU8xcGxWSjRyeDVEQktBUmtMZkdkNGEzaXZhVjE5?=
 =?utf-8?B?NVhKT2lIaGlSY09rQk5IejdIVEM0TnVNZUJEcE4xNXh1YlN2OS83U1hzUUlk?=
 =?utf-8?B?RTdmM0tmNnF0MW5ObEplaDlmekdWdnlleVp0azFJSkNpem0wdjU0dFVvaGN1?=
 =?utf-8?B?NGhEM1lDQUFSdjdGalhIOUtWV1hucTNkTHVQRGRiREI5ZXdWRmdab0tMMVhi?=
 =?utf-8?B?MUhxMkpoc20vLzlzc1BOelI3OUVGMnRDUTNYN29WdG94L0pNZUdxdXZhZXVU?=
 =?utf-8?B?Z2FwaHU5ZDI4TE1QZytvTE9jMWJ0WkVoOHdzQkNoamZnNndoK0cyNHBzUy9a?=
 =?utf-8?B?N3dFbUNQRHJyOXQ3ZStQdFBoN1hpRnFRZnJSWEtnRXhXT3FtSFd3QUloQ3hF?=
 =?utf-8?B?UkZROC9hWXI0VDgwWUpZaC9mMjVSSEtTQnRhcHFjeWdESFB3Tk01aW9TUzZR?=
 =?utf-8?B?bGNER3FVcE42bXduU091bEduYWRybWluN2JSWkQzakEyV2tIWWhEZlg0aFFL?=
 =?utf-8?B?UXd2V0UzM1JldnlsMzZZS0xLWU0wZlVITEpHNzVKQUh6djN5SEF5MzdUSHVC?=
 =?utf-8?B?NXBlNWpLaXRUcW8rN3UxbVREMzFSY3JqR0NaM2NZbjljSFNFSFJHdWs3SmUw?=
 =?utf-8?B?elF3K0VmeGR4YURhbSs4dU1iZitNN29GdHlUYWFvNUV6L3RVMEVhYzQ0NkZO?=
 =?utf-8?B?Zm1PMXVreklnSGNaamQwVE1mRHdKY2tmMksvSGhKR3FBQURqMEN2S2NCQlJl?=
 =?utf-8?B?VUhicWd2a3czVmVlZTkyeFlGdFczWVJkMXlyYjBmQkFScDFQZGhGaEVlRDBD?=
 =?utf-8?B?a1ZuakVvWHE5OXhSSzcvYWYrZ3c0VFROTnBjTDkxSTVMK1JmbHhRUEV2RVV5?=
 =?utf-8?Q?HiCECZKkstBFJYtvLMDCKKs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87486b3e-5514-4c73-6dc5-08dc9b74be97
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 15:28:09.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5NYJ5UFNQrevHMVmtnlPgnNpnD7jlisWxViXSfC3T+mDKYbr/jLHIzw2zCxslgK6tgs8+o6tM5UbfQQiaFVIcdRT41gxABnyu0LI697kHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4914
X-OriginatorOrg: intel.com

On 7/3/24 17:16, Stephen Hemminger wrote:
> On Wed,  3 Jul 2024 15:15:21 +0200
> Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:
> 
>> Support building also from subdirectories, like: `make -C devlink` or
>> `cd devlink; make`.
>>
>> Extract common defines and include flags to a new file (common.mk) which
>> will be included from subdir makefiles via the generated config.mk file.
>>
>> Note that the current, toplevel-issued, `make` still works as before.
>> Note that `./configure && make` is still required once after the fresh
>> checkout.

[1]
This last "Note" could be fixed too to have proper dependencies
(in example of devlink, lib should be build first for example), and it
works now only thanks to serialized builds in terms of SUBDIRS in top
level Makefile.

>>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Not sure if this really needed, it impacts more than devlink.

devlink is just an example here

This patch makes my development easier but it is not fixing [1]
above, so it's just a shortcut. You could drop this patch, let
me know if you will be interested in extending it to have [1] fixed.


