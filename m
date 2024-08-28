Return-Path: <netdev+bounces-122669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086CC962237
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4041281F88
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A767C15B119;
	Wed, 28 Aug 2024 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djXwM0AR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC813E3EF;
	Wed, 28 Aug 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833256; cv=fail; b=lWhJlARnehf61tIJclQE9veMhvQqxzf3FcSboLc6zW+5ApbS5diyFNv2FBmhV9tRSupMfFuJt+H8DmP1XB+m0s0hLcJUIOWk8TKfkSc5YsOsSkWGLg/94d6KjSsz5BLzzCWgs/GyAEGqfO8/D9/nUnvZlw2sKDzLghlawTgTeLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833256; c=relaxed/simple;
	bh=9IiuAcGGstkILhpU8LHxJXuTbXTkG7QIuNQPGFdEohg=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4pXoc+dAQ08DMeNGdvqh+yymPFMMacuoU0QEB5hqPwcv++CfOBrdSuJG1ke1NBaZRPpS89vV9pi1pF3pR2EmwfZV5lVAX5a3IqQg3oAh52zIO2b+zoEI6XhGMpbAh2vz+3J4fnx4AFecvm/EohI7EPFDQMeYl2p7wopmtoa5rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djXwM0AR; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724833255; x=1756369255;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9IiuAcGGstkILhpU8LHxJXuTbXTkG7QIuNQPGFdEohg=;
  b=djXwM0ARWWcpy2sR0EsimhXMsW6UWbag0ySQKCv7CX/DLhcEaXOv4bmD
   8ave0Gflg5orqk1wJ6nHyhVS+iY0m5Qq+t+NTk09YwdW9L3k+KQa/d367
   2Q0wys49brMPlCZhirvcBWSZNocGaJO0A8hrreWV+aBG9+grwyVeV25Oa
   TvwZlDJO4Bz/BLGKvjtzqrfOJyzeBDSKWMUHROcI9S+kwj20syt3FUa6A
   IddTchIT2XnEdYN7JuC4CwkSjS8DLH1cDnsLOeNR3K7Lt30dgNsWnGfjN
   aiMlW6j7qMJGHJtqM0DjWHBi/dyhIAmpv+LFGvD5hr3imE/5WX6NuE4TV
   Q==;
X-CSE-ConnectionGUID: Tmi8sHFcRUei9cp3seteWw==
X-CSE-MsgGUID: JGTvzPebTsOuP3xlWZT6kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27229500"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="27229500"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:20:50 -0700
X-CSE-ConnectionGUID: pCtmj4XTTBaKr/mwNyWAeQ==
X-CSE-MsgGUID: fXnYM5GWQg6BWTaPqlJ7fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63655443"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 01:20:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 01:20:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 01:20:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 01:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOU6SHZ6fo9k5o5rqpvRbhFLMpo39JA80EPApOtVeSWFRr2/RVJHFnBdkklDM/U1rbSJrwVwDTF/bGDNt1gN7CgHYmkLpEIdiWdjUpslWFoXrQwvVWwjQQlKe+TU3Rc7pHLKOgJwHvY7Ga84tAD9X3n6vHq0HNTWPCgbeofajV1ymqqDMqSeKwa4GjfCZV6xK9DfudM24pUFAoJ62U1p2bQUmcPJ0vCVNL++z+vKB1sJwmen7XNYHOoMshRsyKvZL/icEt0qO1W3FCFbtNFKNdOPxI3ZqTOF0YZHhAXSBYdw4JsbObuxyAXR2eGTkijouhS9Zs8eCcH3fycftgVxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ8HQ8c0+5OVOYv6JAnADfYFjiABWRLxcOxVmXbpXPo=;
 b=aRJIfQSXc8r0DjyJQEkUjo7C8DOqTJTWGB9Js38N3oaqqH1qh+IIOZHln0uQF8l56MIT+zPGGb2nZzR70+fRG80yWl1r85ybg3Wh509LClMu2jZikv6b0SHYU2YnznhvVWOz2WQZJMFoDB8EJkGlDP1zpNF2ortOHoegKSSjJ89w48QcPn77WCrbqsMaEYSNdKAob6hUWt2yLvf722TuV37ubbntOpntBUy02VB5h5zrCJ5d2/1t0utDV/y2gTRGYsWteK8URBXwRkCBQrWIoTJLeDpyCp8kgv66O84d+qgjd7ra6p4jAD833DQ00ZfG2jdMEZ5dQltxmukbY7YfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6473.namprd11.prod.outlook.com (2603:10b6:510:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 08:20:47 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 08:20:47 +0000
Message-ID: <cca70257-b8bf-4d4f-9a0e-b5116536734e@intel.com>
Date: Wed, 28 Aug 2024 10:20:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ice: Fix NULL pointer access, if PF doesn't
 support SRIOV_LAG
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC: "David S. Miller" <davem@davemloft.net>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Dave Ertman <david.m.ertman@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240827071602.66954-1-tbogendoerfer@suse.de>
 <51b220a9-3304-4baf-a2fc-8da8d765aff7@intel.com>
Content-Language: en-US
In-Reply-To: <51b220a9-3304-4baf-a2fc-8da8d765aff7@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0143.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::22) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c2ca01-7290-43e8-2695-08dcc73a518c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?endLbXEzZGM3cUR3RS9lM2daNUw2VXpLdjBWL3VnOUtscW5XUnBUR2I0dVd3?=
 =?utf-8?B?S1Z2OW5GZFNYTmFVYzJnZ2toSUp1UUt4cEsrVmk5N0NJUFlCd1BpdmJjcFhl?=
 =?utf-8?B?UCt5Vzg3ZEc1Y0Zkd1NVSnZDaXk4M01JUWg5YnlHaG5ObFVoL1lrTURBZCtk?=
 =?utf-8?B?VnBjeU82TkJ1TUFhN2ZyMk9Qb1B6RUlXeThOQmhLeFF0MHV5L0N4dFg2MTJL?=
 =?utf-8?B?WjIzd0srMWRJNnhsZjFrQU5uVVZpbG9ySEJZRFloYTdpK2QzbGtlcVIwTXNO?=
 =?utf-8?B?UXZDV1BVV3RRblN3c09RdXZxTjRBNURYMWVGNzNLeTRpMUI1cW4wVWhMTUt3?=
 =?utf-8?B?Q0x5em5oamdUNzNnZENMWXZCbjd1cFgvS3k4TWRuV09UVXdJaEhKNGNQSGdi?=
 =?utf-8?B?VnBVTkwzbzcvZkdJNzREK3RFSzBaZ3VUbEhkR29VY2JGZUhQeDVyQi81Rklv?=
 =?utf-8?B?cmxMSzZZbE00ZjZENHgzeEsxZllBQk1tS1lCdW9XT0xqMkRXakRGREZZTzZq?=
 =?utf-8?B?YjNiZzlQeENlSGJGSGNvb3dBc1YxcmxHTGVSckUrZDNIVC9EemIzYkhGUEky?=
 =?utf-8?B?NXBjSFd1Y3FYYlFOdE93cC9nbkxiemdPRUQ1VWVRbHBQVlU2WHZRMmJVTDZp?=
 =?utf-8?B?Q0hWWTRvOE8vWjNTVXhlUEZVNnp3M3h2WS93M3p3VWR1QVpHTFFLdHpmNmRu?=
 =?utf-8?B?a3UzVG9mb3MydmloQk1FNUlUY0ZGMWZDWjJTdU9kWFhaRzFUbmNUOHh3bzJx?=
 =?utf-8?B?U0xqMHNGbGNKQ3FOa29GUk56VjNOQWFQbDZiWXNGWGUrdi82Rnk5K2FJbmVp?=
 =?utf-8?B?RndwejZqZW1MTkJlYW5mbGQxVWRiaVZob3kramcweXhZY3FyNXpuOGsxOThN?=
 =?utf-8?B?amE0ZzFUZmZwQjNUMjdYSnEvMEllMEVhWnk4NzViaUVxektHSGl1dC9EUUdW?=
 =?utf-8?B?ZU5aVzg5R3lGQTdWZWc1Ym92ODR0azRTbDZuODVybFVDUWF2ZEpya1BrMDBk?=
 =?utf-8?B?T25RVEN1TnorYWlBOWhBQ2VhZnM4MzJ4NVljT3p4VlJZejhMNkNqTmdvWEdt?=
 =?utf-8?B?VHZpVmZIb0Q3cUlNQjVFajRsYnBiOWRORElSN1lDeG5PdGs2akJrTHMvWkVW?=
 =?utf-8?B?QTBaL1dURjBJYnM1Tk9WSkdFOG1HZm9OU2JQTm9SOXU5VFY5K1dlV0dXQkNN?=
 =?utf-8?B?UUhKNGpzS1dUTXFNTm1EbTYyS0UreHFIYWpEeER6VE9rWk9TTmpHb1Y3TStp?=
 =?utf-8?B?MThIdEpkNXFUR1BITVdHVnJUQlE0aEhScVYybWI0QnBvcTRQcjdmTC9vY21s?=
 =?utf-8?B?SnBFcHhicEF4RE1oQVhyS2xpaHdCN3JMeG5BNkZKeVpZdzdTOWwzb2tncEQ2?=
 =?utf-8?B?VGpad3phN004Wmh6ZkxtTHE0OVp6L3ZjYVYwdllyeHZTa1FhQi9wTUF0S1NS?=
 =?utf-8?B?VGprVmZiUjQvYmJMaklZSFpvcDI1cUlSeE83MGxWRGdkck9tWTNzR0o5Z205?=
 =?utf-8?B?bTNtcGpkQWgwcW5GOWd1SVdoTzhvWHd5THNKaHpWQ3dCTFdxMWNWVjZwWnk0?=
 =?utf-8?B?SnVhd3N2MC9EakZ5akJpVzdUMEp0TDdyU1lxaGJ1Ty8vbHhLeTdFYVhHUEg0?=
 =?utf-8?B?UHBkKzZVR1JsY05HNCtqTXh5SVg3TE5ReldJbUUrYWVPM3RmUE9Dc3VSQzBB?=
 =?utf-8?B?cVdWdlpXSXN1aE40eDBsWHkrSWZwSlhhT1JzZDFBN3JIcHJGNEJZMm00TTF6?=
 =?utf-8?B?ZDRyWStXWDJtZEUvQ1IwVFVvY094d2s0Z25ySW12M1RINFZnRHRpU25sY29E?=
 =?utf-8?B?VnYrTy81bWEvTGowdFlmQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTdPbFBIWENQOUtiV2wxNlNycElmVFVaZm9oVDhlNDcxM25Ld0JDNTVaWDZG?=
 =?utf-8?B?SEpUZktKZ1c3RG9Pc1VYUXR4M0tleXVGUjVjMmUwTlVnVGY2UlZNTUVDOEVU?=
 =?utf-8?B?MkowekozUzNTLy9RZ29MLytqMkk0ZWJqNm52TUZ5elhnL2I0OTU4NWwzQlh1?=
 =?utf-8?B?SDNtMWkyN0hQSng0MGJwbnpTdjAzUVIwczIvRGFDbVJKSGVEYVM0c2JhdGtP?=
 =?utf-8?B?Uktud0JuZ09FbU1lakNSeGRSVUgvMEVhZTIzZWlHWnQzYkl2T2xCb0FxKzFp?=
 =?utf-8?B?TWFseVNTOVk1QllBaDBBVld0ejVjdDlZU00vOG12QmRGSDNxZUJsYWF1QkZH?=
 =?utf-8?B?UW0zMUhnWEREZVRmbVYxeVBMTVpmQlRHQksrT3Y0WE5xaUZwQXhwZFBzQTVL?=
 =?utf-8?B?eVBuNmozNmd2N3Q1dlYwL1hRWGRxZUh5RzgwaGZxREpkdFluTEI3aXpBR29o?=
 =?utf-8?B?V1JnbUFjd2JxOEVERzVJZUJYKzFlOUM4WGxmMzA4YzFxazZpOENlZmhrYVVT?=
 =?utf-8?B?cUdnam15REFFWFNOcVQvODB1WndGY2tuQS9wZDJ4YTdIMGV2NERHRzFVcjlr?=
 =?utf-8?B?bzhlN052YVM1ckkrMkJJaGFVMzRSU0d6RS90VjA5YUVUT0N4QzdXaW5aOURZ?=
 =?utf-8?B?ODdRZ3NqOGtLeVRZejdnWTkreXJQY1FqK3ZtVEl5OTBOWmRCQzJBQXVSUUVW?=
 =?utf-8?B?aFpQd1gyY2M0NktnVWpQRVBvSGF5OGVCWS9DaFlFbDU4OTBsM3RqYmFBSkNi?=
 =?utf-8?B?U0c1eEcvT1lmSlVrU3BFSmtXWVRjdVlCWlI1T2QybTZZZE1rTXJPUUllUWts?=
 =?utf-8?B?em9pRHl4VSszcStKbEU1cXFxYW8wVmZOc29YVW0yc1QvS1lKcnN1VElKdFEv?=
 =?utf-8?B?TjVoZEpiSnhhNnZkdS80Q3NXMUVvdlIyTEx1VHlJRWFPQ20vWGplaUsrdlF6?=
 =?utf-8?B?dU03ZkRSZ1NOUGdRdVdadlBqcUdyczU4QkJnUnJnUVlWd2hJWnpnSWdDY1pk?=
 =?utf-8?B?Qkl1Vndlbjl3bGhWVGFsRms0S3lHZ1g3cktPcUl3cmpwSlcwZ1BwYkxiQ3lH?=
 =?utf-8?B?aDRZbzd0OHQ2L1REeUlodFpRYkhGdGM2VEJEUHg0ZkE2UTFkcVVDbVRFSHVF?=
 =?utf-8?B?ZktCSjZuNGIrV09mQ3pvV0ZFZmFJM3VXM09VYnZDQy9HSlZGc0hMWm1xUEtW?=
 =?utf-8?B?V0s1a3o5TXNtUDltV01IdU1rYXA4QmVxeXdZNGp6cGtyRGYrVVJMLzVVL0RN?=
 =?utf-8?B?Vis1bnZSYW53a29EQmpxYkVjZXZWSk8vdUtKWnFYN3NvblBKSTgybnJzQXZr?=
 =?utf-8?B?M0hWdERaaG0xamkrRjN2eFJtSjdhTlZITkdDdlJlY2Q4dFRUMzNGQ2IzTVlM?=
 =?utf-8?B?bVhWdlQxNWVEb0hlZ1k4czQ5d0dJOTZybkkwMEEzb2tFSFVPS0VoS0UvRmhO?=
 =?utf-8?B?alcxMGRBbU91QTdLMnRHUUkzL0ptMmpVcVZrWEVmY0tuUE9vSWV4Y2lBSlAz?=
 =?utf-8?B?K3hCY095SHRBUFVzbHAzVjczZ2dJayt5LzdST3NNeHVucXZCY2FHUjh2Y3RS?=
 =?utf-8?B?NkVJZHY5K3RramtmMlZqZ1J0aDY1cGJ1T1M3TXZvSUE0TG12OHhmM29mM2x5?=
 =?utf-8?B?RUNaaWtFQ2ttMDdxVzlRUnFaNUt6TUxoeC81S1kyUVVuOTAwMGVxZ1BsY1ps?=
 =?utf-8?B?a0gvMzdTbnpTUmtydEdHclJUcnI5MVpBSUlLS3BlT1UvdlpZNWtla3Y1cnJ3?=
 =?utf-8?B?RmNETS82ajZ5eXI5U0FFZTZGcVRCYnlDSzEwYUJHTFBVWXh5cDAyYkV3UmZN?=
 =?utf-8?B?N2RvMzBDL3k5WGVFVU84eUU5aHQ4ZVRueUhncFlNQmlHNDc5YmViMmQ1VURn?=
 =?utf-8?B?SmNDY0lGZSs2M1plVVVIMUJIYTdGZjZQUkpZWXNHZGE2aExZZ2h2QmhlQlIx?=
 =?utf-8?B?K3UwMllCTzg0b2ZQK3NlQXpYOVFvUXJBTXUxNkpnRUF6MGtqY1Q5WkcvTzhj?=
 =?utf-8?B?akp5K2tlNndDemxXSUxMZjBmMDI5Njc3a1BNcldSOHdBNXY4SG5OWG1QSHF3?=
 =?utf-8?B?OXpod3FVaGY1a0xGakgxalZQV2FUcVZKOGM5Tmg4QmRrcitvSHdQMnlweHpE?=
 =?utf-8?B?WVRrZnpzSmk0OGhGbW5pd0c2NXE4SUtkUk1VNUZ4U1NwZlZ5Q1pWZGRNZFhj?=
 =?utf-8?Q?a3ZcFMymUY5jexly91Btm1Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c2ca01-7290-43e8-2695-08dcc73a518c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:20:47.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYhk4cfXZ7KkPyXeymdvoMDHpiiFQ428vQzRoJyKpMFe027VoytGakfBcVpxGrcT+ADYfbmAuW6uU2dP1kSe3X9QVizbSyeJjHMh2SRWJ2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6473
X-OriginatorOrg: intel.com

On 8/27/24 11:52, Przemek Kitszel wrote:
> On 8/27/24 09:16, Thomas Bogendoerfer wrote:
>> For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
>> allocated. So before accessing pf->lag a NULL pointer check is needed.
>>
>> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for 
>> SRIOV on bonded interface")
>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
>> ---
>> v2:
>>   - Added Fixes tag
>> v1: 
>> https://lore.kernel.org/netdev/20240826085830.28136-1-tbogendoerfer@suse.de/
> 
> Please see my reply to v1, unfortunately sent at the same time as your
> v2. The fixes tag should be different. The check that you have
> introduced here repeats the check in the only caller (was not effective
> though).
> 
>>
>>   drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c 
>> b/drivers/net/ethernet/intel/ice/ice_lag.c
>> index 1ccb572ce285..916a16a379a8 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
>> @@ -704,7 +704,7 @@ void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
>>       lag = pf->lag;
>>       mutex_lock(&pf->lag_mutex);
>> -    if (!lag->bonded)
>> +    if (!lag || !lag->bonded)
>>           goto new_vf_unlock;
>>       pri_port = pf->hw.port_info->lport;
> 
> 

thank you,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

