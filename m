Return-Path: <netdev+bounces-128654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB2497AB8D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 08:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E9B28A6D7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3912661FF2;
	Tue, 17 Sep 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOIszqRd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C949659
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555260; cv=fail; b=nNGXJ+Fhu06kiUfqyEW7fRAp78CDEwONPy973nAMv/Rf4NA++wV0jw/LYlaXGF4ohs81oz38dgq5uvKUmWYbdJ7UG2KkDukyvdwdLJVym9vT0zZNC2a7cJohwmTj7Fq5I2nlPj/pH4TVGpOD4wXPr2XSztg5f/9Y3DfgBEdwWjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555260; c=relaxed/simple;
	bh=kvJxCUa8fT3iCfSYeYX5dUI+3+7Y5UhVWd/kRoPQfgg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HDtXk8slmsKh+9tgEZ5rdXRlMeAHeIGF3dkQHYWB2VSQNcYobTs2DRajnprmFccP0CPyEu33lyQoMDsZELvoHZzPcn1iPaRn790zJOcmbvTyVjUs15AAQcZWIwOemgFeLC5+DcETjTn7tE447/fy1JNhUA7IjKlqZt+VvdZbANc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOIszqRd; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726555259; x=1758091259;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kvJxCUa8fT3iCfSYeYX5dUI+3+7Y5UhVWd/kRoPQfgg=;
  b=LOIszqRdUftVaFgTVWRH7T0I4xDqmzkF/JeINMRoYnuU2Ae5AiklUqqK
   Po2qHURDexNSVacSTIz/imJE/E9TWEUxU01HFd0rNGNs2FQ048ZNMOukW
   qkBPPNk8nDolA63sZ4A6bKOFJTpWa71K8OPoRC57GFm/bVOQVFDERDHIr
   A6+ScD80gLeH0mQNLPXNI/ATEXe1/tYpOj5ScdalSEbA9kPuBVwr1G7mT
   l6WvRUCM6Wn+bhyrINCFXv40JIbpCI3oUYPBnzA2yjGimCfBfjmqgSvRd
   btDalJhiw3Kugs022JC00fHRv3MYW4prwAdVY7gXKajWx3JEvpW1dvtCQ
   Q==;
X-CSE-ConnectionGUID: Gu88+Z/NQHavglv86wEG3Q==
X-CSE-MsgGUID: Oy1vcL1ITaCAD8AU6kStYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="28308849"
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="28308849"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 23:40:57 -0700
X-CSE-ConnectionGUID: pKyN6KXUSWST5GTl0OWohg==
X-CSE-MsgGUID: 7fc0ZceTTeahw9EsLbeK+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="73678895"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 23:40:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 23:40:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 23:40:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 23:40:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 23:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2ZkT1ZdLy6WaEOKwl303LqfhnP8OzhOI4LCSHUA4HR46PWMgB0Bl8pReFUailefLIBm4cwInApOfXC6+3AyntComQJD7Z0cEIHGgwbU7Qbo+gb5QKl8HVQn6o8FsAczjKOK0ezabfSydVd6XaeyScRXpOWmBt+nO3UYz/nknrW9sltgSfmipVtMdg3qT39UIclRlYh2NX+lAynRxa6GH5aquwisBbdEIqeXhUu4dbSRtK5T8Wy+EshETAbYTVaNw8hpHqRx0nHvFgSHIbty40w10MnLOPM6sHLjYLZocki4g5xuvM/M6OHJJtztDLxSZ3KYpBxt2WPfoXfTLcW9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvjZCISeaZDNeXbOLu1sdHeLhvqL8rcyivoQseufhW0=;
 b=ETTH4F7gk+h80JDQGXjNvYvdBYeD3XFV+M3Smr6azPVQKeiuvqahIxebfugM1YfglCLDtKGZOxrIjbLs2/8rfXGBD6kSn0p96wU7IMnG/DoFnIIp6LxiAj5QCnKRw4tFsRiI3ole4+dN0q6iUunddFp/5hk84IfJZqSrqMO6uVZ+84R+jjeWRNg9qcpAaSdKwHchGviPbeKTh8GudCUeOKWR3D17c3liWZHObl94bnzzRIM2+RuaDmnWt3o3rJqj53GpwCVqXV8shXnLNfEf9mJUD8ZUhGu0KFxJJg+ycptnN/Zr0XuQ9bucJ2pukJq4jBcgQg3j6BHbE2SltD35Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB8552.namprd11.prod.outlook.com (2603:10b6:510:2fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 06:40:49 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 06:40:49 +0000
Message-ID: <0df1bf91-7473-4ab4-9a96-8eec4c7fa5c8@intel.com>
Date: Tue, 17 Sep 2024 08:40:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Simon Horman
	<horms@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "Knitter, Konrad" <konrad.knitter@intel.com>
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
 <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 184f6157-6c87-4957-5f87-08dcd6e3aa9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZE93YkdBbFBLZjZEN2E0bCs5VmdkaFV6RVM3WFpmSmxadjhnMU9ZK3FaRlYr?=
 =?utf-8?B?WVJ1bEgvN3BERm5VREpWa21LUm5DalZIaS94Rnl2OGYxcWRmMHR6WHBmRzNC?=
 =?utf-8?B?YUZZd3dMaVN1VXNkenMzd2ZBT09Jak4xQllHVysvV1pKQTY4akMzZnM5enMz?=
 =?utf-8?B?aWNLcFU0a1lpYkRVQ0I4Uy9jOWZFZE9PK0sycHpqR0RjWXk3MVhESlp3aUp1?=
 =?utf-8?B?WGJPU0svTkZ1MGtvdDRUdmVsUGd5MGJUdEtqVStYNk0wYkZTQ2VKZmdEV29I?=
 =?utf-8?B?VFdpamhxcTlxWjN2ay9mRFdzZVBrNlZJMTV3RXUybUlZTzRBUis3cFRrb3lB?=
 =?utf-8?B?c3hTQlNuZFhsaHNNUFFTVWQ5dVpBdCtuODU3MFZJOVAyQWdUZzE0YUI5Z0ZO?=
 =?utf-8?B?ZGZiR1k4Y0NrVGJKZkFQRHRPWHI3VzZtK2xaVmtRZWpTN085RVhLN3pYdlY2?=
 =?utf-8?B?N1kwR0R3MjFCMkxXU3d3VkZDVlRXOFdIYThFQVNnZ2hiM05FcmVZejVlVHNI?=
 =?utf-8?B?TGt4M0ZFK2VEL1hpTjU4TUxESW01azEvUHBIWWFwR0sxWFloT0dLU0RZRWYv?=
 =?utf-8?B?TS9FMktTL0p0cllSTGNERkdVZDlxdnpUU3hKdElveTg3WGtjK0tMN1Y0MVVs?=
 =?utf-8?B?YXlhaUZnaEEvTWRoeUZoS3JxMHQxZjZKclB0aTJMRStKZlNjUXBiU3RNUktF?=
 =?utf-8?B?STNuaDBxNVFsM1NQd0FQV0VkdURHTG9nTlJtNnN4SlJ0UXdhaEVMVjNJeEdN?=
 =?utf-8?B?QW0xc2xRa2xPVE1td2J2Q2NyZFNIOExveG4rVXpDbXRtdk5LVFBNRndMUkM4?=
 =?utf-8?B?TVBzT2pXc1h3K20rQ3BMb1pDd1B1ZlU0VGh1NVpUWW5rNTBwV0lmTXVjbmtM?=
 =?utf-8?B?NGZxL3ZiZkswNFlzWGIvOElFU3dWOGFyNXV6Tnl5OVd6K0tYdUt0cDZuMGhi?=
 =?utf-8?B?NmJOWitSTytJSE5uMitjaWNmK3J0a1NRUWVBZ0tjQkV0YVA0TDdHdmRzZHlF?=
 =?utf-8?B?U0dKL3BCSzNMMmErb1FYaitJajJabEc0RHdtNk9GMEdPYUlNUXF4T2U0OXIv?=
 =?utf-8?B?MUZkd2ZRREU4aDFOQUtMR0JXWHVyM3dpcll2UXlzNmsvcUJXbDNoR2tiNzFD?=
 =?utf-8?B?YmxJMU9IVzlCMG5DMElGMkJmc3pDQyt4b0JPMldjT0xQbDAxVXg5NXhyMFZ6?=
 =?utf-8?B?VUFhcVlHMzZNeUJxOW5jd1V3R21xSitldjF0R2NjUUppR2N1QmxrdzlLM3Mw?=
 =?utf-8?B?WkR4Yk5RQTlxeFMvaUxuRVl3K1kwYnpCbnBNTFZBQmFhOVBzditTZUYyQXVZ?=
 =?utf-8?B?aU93ckp5ZUtQTGV6OHVvemJ6RG9PWTBrcnhWYmhaMTB3dFBzOTZoZUNOcHE5?=
 =?utf-8?B?Rmtud1BTQ3JnRUNMQmpiR29vU3ZLZWF4RkFKNVdOY01QRlVJVU82ck15VU9n?=
 =?utf-8?B?azdZOGFJZEI5MmRPUkVRb3R3UlNtTmUyTWpSajJxQ0tJZHZyS05jVE5uUkc4?=
 =?utf-8?B?SElJSktOSkxBVGdWK0lKTGJlT28xQ3Q0eEE2enBtODdIOGhQdUtZdE8xUUVo?=
 =?utf-8?B?cXVxb3FZUEQxVk9mOE9kZ1NPaHI2LzZvbmdFSFo2WVFtNjN0UTZTL0phcE5I?=
 =?utf-8?B?WWQ5QWJnb0xnQ0VRV01tc0tCZTJIUGdnTGhrWnJMejJ2SkNWdWI4RGRJM0J5?=
 =?utf-8?B?cHF6ZnJBeWgvTXRpemNQbXp2RzEyaEJPUEkwNWZZVGFkeFErRFl2MURZVkt1?=
 =?utf-8?B?aGMwaTExb2hjdDdwQmRLYXMyY094dDE3VFZSZjJJZFRaU3FWL2Z5MGJKQ2Vl?=
 =?utf-8?B?ZHUvdzl2Mm9lUTFwYUVsZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTg1RkdwQWRIa3lzMVdITTlmZXhmTmVOM3EwdnpxL1BpcVZMOG9WUzF4ZkZE?=
 =?utf-8?B?cUpQb21yem9tdXJuZ2lMS3hYSm51ekM3bk5RSEs3eUJuYk02NUNJUWFXZ2x4?=
 =?utf-8?B?M0NFSjQwZHMrRGY2MTQrMVUrZFQrUEM0TTgzQnY2TkRlbmdTQnJabHVBYjh6?=
 =?utf-8?B?aUQ5QUVCa01lejNMS0FlUW5zMC90TU96WFhzdFhrWExCakJUenlNalp2bzF6?=
 =?utf-8?B?NVFTaVM4Rml6MTVQYnhJT2lBb1JoNTVCWTAxMUJBTERCU3FtcG9mN1QvM3lO?=
 =?utf-8?B?M0xseDFZWExycEtrb2U0UElWS2hqbEhERXdPd0tPaVpGcXdQaWN0K3JmZWZ4?=
 =?utf-8?B?M3p5MGcwWGc2Y292R3BMRHRoOHpNckRzdXdzcEhKOUovNk8vVjB1VDJIZ2tp?=
 =?utf-8?B?Q1U4K0tFOFBWMDJMZ0RmRU92QWNYc1VDbWdRNXRXZTU2UVNYdkRpWkkyQzNE?=
 =?utf-8?B?bE5ZYjNuVENCeUJyVXp3VFVpT0lQMEQreUFjaFJFNVp4b0FPU2pFR2s4VlNT?=
 =?utf-8?B?NktHNDB3TnIrd1lWeDFkdnFxN3JwYVgxNjMreW5sVkxqUFlyVXkrQWJYbzlM?=
 =?utf-8?B?a1BlWFVScEJMczc5YUhJMFFjZWM1TmR3aExlZmdtc2pOUEtrci9BTEFpRXZM?=
 =?utf-8?B?aEEzcTA2NzhHdnROTFpDdzVXYzNFZWtKNUdtbmtnUnkxQnc4Wm5JYzRTNGtu?=
 =?utf-8?B?bmVGeUJWRVExM1pZVTNSdFFKNGpUUWhLNG5GKzN1RGxITkhUSkpEaU5teDIw?=
 =?utf-8?B?WnBKa3BVYmdhS0pFLzVUaEVteTZRWk5zUjdOWndjTkRBZkJDMzBnVnF1RVFj?=
 =?utf-8?B?R2xCL3RSZXFuU3d0SnNvUlpmZVJLdk1VbGVWMmw3VDAwY2prN29JM2dydHIv?=
 =?utf-8?B?VVJickQ1ZVBqRmZ0ZExjUjJLV3lzMjBNdmZMUTFqTVBvT3JJUGx3UUlxVXFr?=
 =?utf-8?B?V3NDSFpoa1FheG5UeGVVbjUxSm1tQ3pXdWN6aWFRRXByeEtqb0lWc1JDazNj?=
 =?utf-8?B?Q1pNZzVxa0daUFNIV1pQSU9XbDk5S2VPamJjRjZ4ZzNyUm5QZWR0TmZoK2VG?=
 =?utf-8?B?U0ltcDZMQXBGVFovRFh0TzVLdHNheWVKTVc3ZXF1Snl0M2xqbTRKdVh4dDhK?=
 =?utf-8?B?dnIzZEh6VjRXRGl4eGFaNDQ0MUM4YnNGUDAyaVdrbHU0UmhoQVM4L2Y2QURN?=
 =?utf-8?B?Mi9DUXZ5UDF6WXN6cGwrMFVweXpibjJwdVBoUU55eXZuUlc1aXNKOGF5eWNY?=
 =?utf-8?B?b3NNTHVsdkNHV0trdlVxdkkrTnJya0lsazVTTzJEQzduTnIyY1BtSGZlMlF4?=
 =?utf-8?B?MEhvait6YjRLVDZFR3ZJRzFlL1A3L1hoV2hqam54cUFORTExTlhuUTZMOC9l?=
 =?utf-8?B?TDZBMzVWdVgzdXp0VXpybktURFYzZnNCL0srdVBkNEVJa0t6RE9TWVNsQlpu?=
 =?utf-8?B?ZFhubTIzcVZLRzVxalQ1U1B1cjJsUXJGNXF6akxtQytMS2V5eW1uK1hXV2Ju?=
 =?utf-8?B?NkF3enF2YXZYZUZxME5ubVA1bEErUzkwRTRRaEE1QWVGRnE3aWxtMHpBQ1Nv?=
 =?utf-8?B?ek9TaUlwaFc4aWI1OWYzOWVZbEwxdm81cTIxTjFIU3VpU3JIVWVRc0RlSEJk?=
 =?utf-8?B?N0x0SWNEcUVpM09QRXdkODVQQVh1elpPS0Y3UDVaS1BkSks2UThoNWVhQXdn?=
 =?utf-8?B?ZGttT1Jid2crNHJuYkgyWjdYWTAzLzh6ajRsT1poenpneGxiVUxoY2hpT2pI?=
 =?utf-8?B?Y1ZUUzN0RHhBRkZLdFpiUHd6VjdKQkRDVDVMNjQxblFnZUt3UnhyYVBwV1M1?=
 =?utf-8?B?LzdpMU5BcEoyckQ1UWR2ZXZidFZZNSs3TVVvK0FKV2ZuUVBrYytreFY4ZlVy?=
 =?utf-8?B?QjhaSXoyV3B4NThyNVluU1FvTnhVQndSVzM5Rk94QXpKay8ybis4d2YreEtt?=
 =?utf-8?B?WTc0aWJpK2Y1dmtVTHZHYml6aUJIcklMS2VWakRPaVFOclFDeTY0ZUlSUkVq?=
 =?utf-8?B?T2dkRW9veDU3RjNWUHR2UmpBT3RQTWlhUWVwMnFveS82RTBkZURUMnovMGFs?=
 =?utf-8?B?ZlZRQzFCNnk2T3hldFRKemt6TE5mKzhjNmh2MXRMY29SMWZOVVVsekJEOXZL?=
 =?utf-8?B?VlFTU3RrQ20xc2RHdVVOSU9yUXdJanNSeW42dDlDYXFqTUx1dVFmZjJVWmpk?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 184f6157-6c87-4957-5f87-08dcd6e3aa9a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 06:40:48.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lu30cPWHeZuXYkQNGbhGTq9INXRoBCthjAQTEQ57Wu6ZjUSCKs6638FiMmBDNbushG81YcC8jO7QDav0KlUEvsvtZmJxLZsC5PCf4+0i/ZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8552
X-OriginatorOrg: intel.com

On 9/17/24 00:05, Alexandre Ferrieux wrote:
> On 16/09/2024 16:01, Simon Horman wrote:
>>
>>>> Any insight on the (possibly very good) reasons those two apparent
>>>> warts stand in the way of netns scaling up ?
>>>
>>> I guess that the reason is more pragmatic, net namespaces are decade
>>> older than xarray, thus list-based implementation.
>>
>> Yes, I would also guess that the reason is not that these limitations were
>> part of the design. But just that the implementation scaled sufficiently at
>> the time. And that if further scale is required, then the implementation
>> can be updated.
> 
> Okay, thank you for confirming my fears :}
> Now, what shall we do:
> 
>   1. Ignore this corner case and carve the "few netns" assumption in stone;
> 
>   2. Migrate netns IDs to xarrays (not to mention other leftover uses of IDR).
> 
> Note that this funny workload of mine is a typical situation where the "DPDK
> beats Linux" myth gets reinforced. I find this pretty disappointing, as it
> implies reinventing the whole network stack in userspace. All the more so, as
> the other typical case for DPDK is now moot thanks to XDP.
> 
> What do you think ?

I would describe (here) more what is this typical scenario where users
bother to set up DPDK for perf gains.

With that I think that is a legitimate reason to rewrite parts of netns,
if only to allow companies to shuffle engineers out from DPDK-support
teams into upstream-related ones :) [in the long term ofc]

