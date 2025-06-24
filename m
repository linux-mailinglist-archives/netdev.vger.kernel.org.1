Return-Path: <netdev+bounces-200868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E23AE7253
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905ED17C2E8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126C1258CF5;
	Tue, 24 Jun 2025 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYT9+y0v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350332586FE
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804444; cv=fail; b=Yk8ugNuQWh7E6K1KzDSJV1vSPFOOlIFW7soG3uSweqB7Cyqh57cDClsbW05hhcqDoB3HAEO1Uo4wAxICxAJbDGr1WnLOgQkoNVaE01frPDlMmDWxmu7kfvlFfCwMVVEc8FJcHkKHg4b206C61Bblx58MYPl1a8a/WuSxT4EH5WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804444; c=relaxed/simple;
	bh=wa0wcGHwkri8/lfPFQRDiSbHKNPHgEMDhF1G3uRY8bQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lGHCczNuPo1hMRRgGdUbGZxDsa61H9AXvZnwaEtRwDXFLOlrQL010mwUB4I/hKtsoGjNwTZ6TLIyVZvxKRyvNQxQ1aK8O7jec18DI5pr0Nm5UJpt8x/xK13cmyqEJslRGmQuwRoFTfvV6e/b+csulAxZEsgNFMJoekQWbJUSdRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYT9+y0v; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750804442; x=1782340442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wa0wcGHwkri8/lfPFQRDiSbHKNPHgEMDhF1G3uRY8bQ=;
  b=ZYT9+y0vFwcBgVhxW9cq9OTI+zUI+pSqrwFuoKJNvnc0VZdqI2SmXjNv
   SpykmlZG4QR/pHqmxONC2hjpxOJfbpxZFAph9w1Z5Ca4xjhYdAwLIV1pn
   aSr4BMemd6vFDJvwH6tIxXXN4p8blEnAuXMAglgebYcFeZrYKHvlYF+84
   jjjrqjX3r2AnXQmafBCG7cLK554so/pta+iqRPwmz3F/sDnymwSYn5i1m
   kfhNc8CU5YwtB/+0/eSj4o0Jam+HmCnwpNdLBXRHSrHt8PoVcx05ZwHUV
   eQF7mP0/4/BUcoz9ihY+S5hQ8mss9HElXeNFCa26M8IvVa9LANqofmcI7
   Q==;
X-CSE-ConnectionGUID: jwBdp3aSS3ygHEQwdjClog==
X-CSE-MsgGUID: ypT3zuEgSVOQybZNc0qiOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="78483744"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="78483744"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 15:34:01 -0700
X-CSE-ConnectionGUID: 2jg6/9CXT1OgqbPue/gTGQ==
X-CSE-MsgGUID: rwAXDCibS4yiiuSkfPnK+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="152563680"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 15:34:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 15:33:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 15:33:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.75)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 15:33:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGicKD6UOxZj4waHMTCy37i+dgXyOZuhWFQzsi0pBOZwmn/SiiXgDKezBst7UkUJM8Nz1ZngU60c6+JCQpPi4mS4RNVPLgplGhTX9vrXWe6Jb5LHcxLBI+7ghi3nClf3cPiK6MLiSSjwLvY9IuDvQPA3dHvWlxYrTvC893Vrq4WFyYacf4DmY8/7clcisvcyDT6vUmuxwhBphbzBW/zkMarkkjTh4b33o0LUVO3uuw762jYZqasuWqnwi5B0DmS0U06A8X+OD4oxJo6gOkyjun7jESpi3oB9Vk2UP/+/sZ1s9zu7CdVGTWvbDsRYZ7YSJpVXORnb4cL4NbmQQ96iGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if6JbehROmMqOF16bqzLt9GhiulYWV8v1hzvuM4VBTk=;
 b=MLJ36YVJShk4yt8Amw/Ypzcpe8W0Gaz5fWn49y3oFIG9gTUjU9mYEe2OwKQsxVpek6f6Ma+w+xx5dYS5Afql4OJNlwpctD9QY+puzzKTWmtjEOVziJTafidHjsJUNJg/bcXRqaxd1NhCSFR2TX0TfSjgQu0FTwa+DUvoA2bM3iwl/ji8sfOn2SFNCItu64Er2RoIFLCRX9ORrUEU+6MmvqtVCP5TS9t1soAxpsyvpecP0XypPKsZOKgtGMe3Dp2KG8xdVcx+izC4SMEi0D5XknXsje3vmTU4QVdq57RFaImNna19sxK7wJUw/3PvErSkrqx4TVvA9usGUNNBjRpa2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 22:33:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 22:33:52 +0000
Message-ID: <5eca05e7-59e3-4b23-8be3-aaf796c856a3@intel.com>
Date: Tue, 24 Jun 2025 15:33:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 08/10] netlink: specs: rt-link: replace underscores
 with dashes in names
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<donald.hunter@gmail.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
 <20250624211002.3475021-9-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250624211002.3475021-9-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:302:1::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de1cd39-1a9c-4a24-306d-08ddb36f3274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGNWbTFGeWJVa0NkbzBBUGUzbEc1NXNGWVY2YmRNcXFaeTI3ZnJ2MlpaaXF3?=
 =?utf-8?B?aVNEVkRCb1Q2MkZpNFFkY3VxeDdYR24yV1ZSemhzWGxzTmRMeCsyTWVHSjFu?=
 =?utf-8?B?QmNybE9Ed0lRbnlNVlk3OFFld293RkwvaENXdjYvejJUTGY5QXE1OS9hRzR1?=
 =?utf-8?B?UENLUDdGQXNrM1BITERMLzJtUFU1WVhQUmd5bFErc3EzN2pGQ2NpY0ZQYzhC?=
 =?utf-8?B?eDExM2NNckNCL2U1ZGxNTUNNdWhpaXQwaVVxOU82dVZpc3pZdVg4bEVmeFlS?=
 =?utf-8?B?TENKTFNUdEVib1U0WUFEdFFCWHJNTVYxUUwxeW1lZDRVSDNYRFViMkFWZTl1?=
 =?utf-8?B?aVh4OVJ2d09JVkswTHIxSTdic0NxUG1aUnUxaWl5ejRGYXdmWWNIcHRTUmpN?=
 =?utf-8?B?ZHh6MVlyaGFvWUkvd2daZk5aWlBsTzRaRko4QlJGMGZCUzVnK21vUUFCSnJ0?=
 =?utf-8?B?OFRJWGE4Z2ZQd1lkNkZMS1g3elhNaHByUmZGVitaeGZ4Slpzd0RWN0luZGdM?=
 =?utf-8?B?ME5mMFprNzR3VVVLbWZhMU8wcVBGd1lnamRUeTBBM0tUUGsrMGx0eFl3bFlt?=
 =?utf-8?B?ZURNbWwxdWc1YW9xZzg0VjJnV1VBM2k4T0g2bFdqY1grbklqazA3RWd3YWVO?=
 =?utf-8?B?em1veHZGRllUbXZqWlk0UDBvTmhRb2NHd3VOK09QNXR4VWlhYTBGaUY0dXRD?=
 =?utf-8?B?QisrTGF0ZzdJU3dIeTRoTE1oYUdId29yUzZzWlN4Y2lIOGxWZmMrZDBXRndu?=
 =?utf-8?B?NDFyTUhma25ZN08rMktvdGxYUGFLL3pYdEZVRFN3Wkd1a3hDMFZuaEx2dGZi?=
 =?utf-8?B?T2J1WFVCZ0l0Q0kyamtvNTFBTTMvckdJaVhPYktKUFBkOUt1RGVhcEtwQkN0?=
 =?utf-8?B?S1FXNWJ5ZHNSNVo5N2R2MFNCSlM0ZTg2ZnFWaU1OVUVGV1hnM0tLYWxKRmg0?=
 =?utf-8?B?N3luRVNDVVpRMzdwbkUrZ05tZm5QczlhV1FoSzdmTlRwZ0c4N2UvSVlQUkJI?=
 =?utf-8?B?bFNyZWdBcU5sWG9pNWZ3enNVdVN2QVhxKzZwWVJLOXU4Y3NaZ2ljYTRnRHJh?=
 =?utf-8?B?RlFWS3NOK0J4VVIxOFJ2V08zQk5QdEVNQ1BjaWJvdWlwNUk2OUp0ZVJSbUhs?=
 =?utf-8?B?QzkybE1INDB4dEtkMlo2VlA5WERQdjdIb2Y5RlFkd21kak1tSHErR0hXd0F3?=
 =?utf-8?B?czVLRjRjVFM2TTRaNXdjb3dISmtma2tZaG1UT2lUM1EwV0JrazFDYzhuOFZ6?=
 =?utf-8?B?eWtlVXN3cjhNQWtKMW5UOU5NUnVsQXE2ZjdHOUxWWmlSeEpDVERUeXE0Smlw?=
 =?utf-8?B?SVFzZ3BCRVlWYm8vZytzUWF4RkFrZ0Jyb29HYTE5alFVanc0Ynd0NGpHVnI1?=
 =?utf-8?B?aDYxTFZTQzRwZURaWXUzQjcxVkxFUEtVTVV4ZVBucjNZZzFPN0NxODdjbXVy?=
 =?utf-8?B?QVIyK1Z5L1liblVOVzBYRjdsdlFrMm5IbWF1Um1kYjZBY0N0NlQ1SFNwL2Rs?=
 =?utf-8?B?TGhrWi9qSmNKMElGajVTSmNuRnFGay95RWtiVGI0ejAxWHNBRjBYdnkwNkN4?=
 =?utf-8?B?em9PVW42R2VxZE5rWC9wajVtOHc5eWhEQmtaWFVsaGVOc1ZmNXBNQTVQL3dt?=
 =?utf-8?B?eUc3WDZ5eXFaNU1UbkliMDdUWjlobklLcXFtdko5Tms5dUJTbi9zNkZzWXV0?=
 =?utf-8?B?KzZHOWc4OUxmTXlsenkyQmpDdWtFRU4vSWM1MW4ybGgwQnhkaFVpak15dTNl?=
 =?utf-8?B?dE9RNFNmcHdyQ0M5OG1iN3lqb3NpR0kwdmxYM0EzNURQWWQ3NlVSMmJzWTN6?=
 =?utf-8?B?UTdhYTZ1QUtWMGdLaCtBV0dMVlpOa0tZeWY5TDZiMGdqYTdzYjFxREJiZVdG?=
 =?utf-8?B?NG41dzNBNjRKVUVSTVdPZS9mdVBYVE9Od2V1RmZRQ1Nvek9ULzdNZFVXTnc2?=
 =?utf-8?Q?+iqh1BeBtgQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWZTTFlBSnA5aGZHQ3Erc05lZXVSMVVzM1RoTnFCWUNhTE40enBvR21od3Fl?=
 =?utf-8?B?VG5DS0h6Q01BUUlLWFE5NHRGYW1kSXlGeVBBWGE1VWJlbzdZZTg2QktkaDdv?=
 =?utf-8?B?UnMzOVhMeE1PNld0OU5tbk5oRVRSTUx2RG1pMkI2TUczWVJCTzdieDZQN1FZ?=
 =?utf-8?B?L0VZTXJkcUs2VFR5L2tMT3ZvQWVCQ0srRW9SMW1kK3cxcWhuZitONnBCYlhY?=
 =?utf-8?B?THduakh2RVRBNTBMWFB4ay9jSlhENlhVUGZsMDlpY3hPclJXL2ZQbENJNENl?=
 =?utf-8?B?bEVJWWpsSWdCalZETU5wU01yUEZDQWUxOFd5MzNZNzBaMmNpdzJqVHZaUG4w?=
 =?utf-8?B?U05QS09pWTBPNDVENVpxQVpIOUxGTHEvYURnc1QydkJ3T3hSZWJ3ZmFWdzdF?=
 =?utf-8?B?b2g5QXNST2dWeXR5ZkFPUlp4NGFqTU1QTXczTzk0akV2dTVCM1VGNExRVUtM?=
 =?utf-8?B?UmxFeU1MV3Y3ODdUUkd2Vkx6YSthUkdDdURJRHg3SlkxcVIzK3lmbzFXWmNw?=
 =?utf-8?B?QXpJbWJsa2srYWFseEhXY1pNY05OQmxVT1A1anN6Y2JsUHFlUllZTS80OHpM?=
 =?utf-8?B?Y0VyUmYxb1h6T1JNSFFnY0N0Q0xEYWM5K1NOSlBic3EraEVuQnYvTFgrR0c4?=
 =?utf-8?B?TS8waFlBZ0NtTTlOY0QrN0V4bUVwQVVwT1BQZS9FaDdtK3haZ1E5K2RDZXdK?=
 =?utf-8?B?Qi9uMGkzTnAxYjl3UkdPcG9lNU9ySUNCbHlzdzRQb3FDZVo2U1RrMzA1ZXZQ?=
 =?utf-8?B?Zkx3VVJ6NGtycEphWjg1K1lnbTBvNTFUamhGdkNrK2J4NjdXck1qckJOWWVF?=
 =?utf-8?B?QW40dFRDcDZDbHFkS2sxZGt6RUFYcDhzUHVJK0NMaFNxaGFNQ1hQekgvOCs1?=
 =?utf-8?B?TzNDUU9FaFRwT0FJOTFhUFlsdVM2UzNuNlM4K25RdERFZE5zNi9IcUdVZTEr?=
 =?utf-8?B?dUVERlozdklBbDVLdnlyTndwWWY5SUdmaHFTcFZlT2U0WGVPd1pDUVZJWmJX?=
 =?utf-8?B?c0lhOU5iTlM1T0NlTUxBdy9JYXdwalFNblhrWGNCT3o1YXdCVTJCMkNRdE4r?=
 =?utf-8?B?TGRTazlTbjcyZ2tJb2o4Zk5Cd1NKWEJ1S2o5UUVpVzhMaE9XNEpqZTlaYWUr?=
 =?utf-8?B?NjYwWm94dmRmRllMUzQ3N0g4Nytrb2xRenpJbmFKVGg2UC9SL3NJRmNiT0Zp?=
 =?utf-8?B?WTllbmRLcFdmYWR6VXFuWVhOSXphV3lrM0pSR1BybGxXVGVPMHhEV1hFWHdK?=
 =?utf-8?B?aHZVREdORGVNRGhUSTdKV1hhRGVLMVZ3L0FKRGJITDlaTXJNNVpBZmFLY2Y5?=
 =?utf-8?B?R0grbWZZU3pST3FITFRIRTFDSkZOKzNadEZQN3NhVHlPMVVua05BSm82STFk?=
 =?utf-8?B?cGFNUUk1ZGI2ZXYwVFNVaEdkWlJnWnRwTTQvWmIzNTdZWUNjS1hKY2JzcmlG?=
 =?utf-8?B?akE3M2N2MytFbUVldjlKUW5PMDBtOFFUMzZyQWp4bGRxMEUwa1R2d1dOUmI1?=
 =?utf-8?B?MXJYRCt5Q09oQkN3ckdaRS9maEJLTDlmd3lKY2FQbmpXS21Ja1Q1QmxtSG9a?=
 =?utf-8?B?d1NXSjFQOVZOTHNGRGRuSWVUU2VQeUwxYnJuQkVaUUYySUg3OEVIbUNGdFFh?=
 =?utf-8?B?enJiZEg2NDdMV2tiMWlUVEtzdFNDcUNTbEJTUm1USVh6MUtkMmVBMzJMR2dC?=
 =?utf-8?B?L05lRXQvek1hSTlmSTNoWmp3cFNpMW9LcjB3UzlrcWlLbWJ1UTQ3ZDBZQzdO?=
 =?utf-8?B?eVdlZ1F2QitmcnpjbmdUVXYvOFVMckQ4T3RzUTlOQXVPRDg0QVE3NGcvU1Q4?=
 =?utf-8?B?K3B4ejlYYlRMUE1rWmRsL0phZjdQaUczSFVrbzlmaW5uQmxVN2hsUTlnblFE?=
 =?utf-8?B?bUg4M3ZqeGhOVFpHNnREU0hOeW9QOWRyQ2prcHRnQnJJV0M0emh5VEgxMFNS?=
 =?utf-8?B?dnNkTjRKSTR4b0ZmUHpVNllZN3d2TUg4RkVRNCtjYy9nWDRkbk92Y3F2dUlB?=
 =?utf-8?B?b01kNVZJZlRCNFhvVVpobVN2U3FtN3gzRFI4L0R1Q1J4S2lyS2hVSEozS05R?=
 =?utf-8?B?K2FZR21MaTFRdkxYMlYwTmZGam1peWtucENDVjhIOCtLZXBMcjVBdVNCQURO?=
 =?utf-8?B?L3E5RG5yQmc3UjFQZlR2cThFTElUdGQ5d2hYMEc4dXRqd1N1NFdKRTRKOTNU?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de1cd39-1a9c-4a24-306d-08ddb36f3274
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 22:33:52.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GiljrB8f7AQsDlJwvqtv+WwslGOvq8GDh0LTnQ5mfno2rvk+ShlwGiGy8h/aUuUMtmnV63WsU/6bhurDCCLZ4Eqa7dxCniwgRPoJcOIU94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com



On 6/24/2025 2:10 PM, Jakub Kicinski wrote:
> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
> 
> Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jacob.e.keller@intel.com
> ---
>  Documentation/netlink/specs/rt-link.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index b41b31eebcae..28c4cf66517c 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -603,7 +603,7 @@ protonum: 0
>          name: optmask
>          type: u32
>    -
> -    name: if_stats_msg
> +    name: if-stats-msg
>      type: struct
>      members:
>        -
> @@ -2486,7 +2486,7 @@ protonum: 0
>        name: getstats
>        doc: Get / dump link stats.
>        attribute-set: stats-attrs
> -      fixed-header: if_stats_msg
> +      fixed-header: if-stats-msg
>        do:
>          request:
>            value: 94

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

