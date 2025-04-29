Return-Path: <netdev+bounces-186864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D1EAA3A05
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2E1985EA6
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51BB24501E;
	Tue, 29 Apr 2025 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2+CqN8C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83032701C4
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962928; cv=fail; b=HAJPpe7ZS1zlZlZpAub8zLptZLD9f8UUok14dYVNyjcAGRa27KloMf1Fggf8WbBHvpAXA5P9yVcc312y2NvtC8QpLn9LqFxjfcpt1DlzauRvWf3hEJNmUTwJ8MIY7m8SCnejw51xGp89XckO6hMj+hBEnY1T3iHbCwiNKdPKInM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962928; c=relaxed/simple;
	bh=tx63ZzbppsufOc/C28pINys1azmYZdp/9Fu1rKpTqSg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aJacIOnXSC3lXBcEA1tAcOZc2zvDuJtgkxkkEQVdv1EeOJoT+pqgl73TYfG5VqDZFWdQ0UCUnsuaKRox0A98I1PtG4d9olODe03r5eJ1YAnxGhvbprgJCuOD6C0YFW2a+FftDrc9F9anfz27cZ0bErx83AE6EgOrmr96oE8ksHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2+CqN8C; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745962927; x=1777498927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tx63ZzbppsufOc/C28pINys1azmYZdp/9Fu1rKpTqSg=;
  b=h2+CqN8CgnJ5LeZ6y7zwlKYxSh2jDxCTLaiNv1UsdMBoFP/hKWpF1iap
   LefnLpzpLqFRFKXnsdyczcMqTxMauRqs2ZvpWVorUm5yplTV3wHUGFRdm
   PIIKHHXG/NGiMMaCZlR6wFWQ506vbh6oQO2TkKLn76MKhv+ylFtZdm+lz
   M/h3u+gGWVIC9Pbghi2IWpwq9HS7Rx4oTsSPsCzNMax9dUzFHcVFh5Dd9
   PEE8TIUr3ze0LT/Qcv4SzVPXGUw2UahRvoETcoBap3VQLNvSEMenTq1Ro
   kkvaaTSmxOh9yeAw3+/2jhq9HRIYwqDdRmDYUlIE3o0MN8soNR90aFGm8
   g==;
X-CSE-ConnectionGUID: 5nCvslyBTGKZw3ro6xP86g==
X-CSE-MsgGUID: kATV/Y1KSk+OBQ3blDU3Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46850511"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46850511"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 14:42:06 -0700
X-CSE-ConnectionGUID: BUr9xf8STDmEIhCWwvEeEg==
X-CSE-MsgGUID: aViy3U0LQbqPiXM0roX7Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="134890002"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 14:42:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 14:42:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 14:42:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 14:42:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tz5IpeMSUNf4oH9kzUSUDdRXLhOmC4XXZQzYhs4Tk49Yfpi4wjqNsqkrkGfv8szZvHzpDEd5zofT98vPjCoVJWsXDUhcsz2qANrI+PurHW9BkxZnHArZ56v1b2undYzymhol7mOWoF/Cq2ZJJZUeviDNqh3Mn0sRIbhVSzf2fmrlM5n5P/Svswb6VfDtVgEMaBvTWuVBZtHyADSHJyoDDd0ooG+I2geJ6G4IsySBhbPHmpXe6XATXS/pKgkmBumGvrgbYTlpwrx9hnsGyF342xj3SyfrqrXNAb80YMfWmGXIm/qIQfKJ2/9mU5xvLoGLxovkedFdFppu0USx5QKwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USp+KuxqwFkk2mHYNjHOWOpLkA2riOc5ij4FMO28X98=;
 b=SnChjVHSC5RJ7T4cRAh97W26SSkKyihDrYfYHRfVSZJTJ+FfA1o1ZX3iaYIyptW4vKv3yN4lCaeDswgR95vGVbr4vItnB9iAxVwKY8vctYjANt1UAgfTJlLrCrva4lWlHaWEeYfvlkjUhpPkwGTtZ6jMhDKJwjtMUrU/U0yAFoaexXWmhuBlAkHdy4mVNeQZOuhA9E6WDbrjVFNkc7KWFSRLxQ7q0l/QPn8h3n4ikMtEiTKlb9QQ2D/gI3h4ORsybmuaJH/kCUSu4JfrwnByImJIKXQ9l3izL1VgZyJ3oMDrlRoxKes7yt4dzoUFr/vgsHFW45E7SIGD518qwNGVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 21:41:34 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%4]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 21:41:34 +0000
Message-ID: <17fe4f5a-d9ad-41bc-b43a-71cbdab53eea@intel.com>
Date: Tue, 29 Apr 2025 14:41:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/11][pull request] idpf: add initial PTP
 support
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <milena.olech@intel.com>,
	<przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>,
	<richardcochran@gmail.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
 <20250428173906.37441022@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250428173906.37441022@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:303:84::7) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: c7483e60-9acb-4df4-309f-08dd87669c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXBMbitsNXdXTENFd2xzY2pEQlllRFo1VDh5aXB6TFZBSmM2VzMxMU9pR0ZB?=
 =?utf-8?B?bEhHeUw3SmdOSHZ6TDRSRW8zU1BGUkZnR0dsVUttV2o0ejlma1RHR3ExY2pS?=
 =?utf-8?B?SC9tT2xMUlp0K1RrRGc0VzlxTHA0RkxqRkg4QmVYaTh2YStRMlFiajY0WFNo?=
 =?utf-8?B?S0U3dXp6cHFVSGw4ZnFlcnN6cHl5b1VlNC82dFF5a1dLNjkrbHZucUtrR0hz?=
 =?utf-8?B?WWhIcm9jc2xQZFZtdGYwZGN1ZTAzREpoUWUyQVYwMVlaUG5TUi9kcWxobEFW?=
 =?utf-8?B?N3lOQmhHMGxlS3ZyVEZvTElEclErWVhiaUhZUjBLSlFvamlUQ21USmxKMHhr?=
 =?utf-8?B?MUxSMW9MWk5WMWIzRXBRL0ROS25LUUhkQTBaWW1yUWRGeTBtNFBCTUxiS25S?=
 =?utf-8?B?a0gzOFcwWGRTVmNIVXdYSHdzTE5HSWZqc3hsMkVLT0hRYVhPMkdoaVp4U3pD?=
 =?utf-8?B?MllzMzM4RmorUE41TnBsNGJTeldKTm1LTWtLR0ZDbDIxRmZOR1UyclFadEQw?=
 =?utf-8?B?Y016Uk16VXo5Zk9Ha09UVzJHbFJpditBdmk1WGJ1aTlGWUN2ZHJxWWNYMGZw?=
 =?utf-8?B?V2lwdDY2UTdWek1IZlVuVzRHOGovb3RreThtK3VuSkwvQmo5OGNNUFBBTmRm?=
 =?utf-8?B?ZXpWdmVJMXdjSHFZaEVXVTRKaXhvdTEreDFlWjljTktiQW5iQWhGeklxNjJN?=
 =?utf-8?B?dXFsMkJvenN1Q2hwS1cvbE5nRE43cG01NWp3OGlOU2pFN1JzcVB1UjUzTmx4?=
 =?utf-8?B?R0JmSXV5b3FlMlVNUlVWL2x3ckRMV1NYTTFDMHVwbzI0M0F5L0dvYWlUN1lr?=
 =?utf-8?B?cVl3a1MxSHp1K0hieHp6K1NkbEJ0V0dPcndBdmVETURabC9VZ203MDJKNXJM?=
 =?utf-8?B?WTlhN2pJY3oxTWo0djBYR2Uwc3VYTlRwd2hidG5GUEZQQ3UvQXBDaUQwYytQ?=
 =?utf-8?B?ZXdUaWVySUR3clB4RURyQ0JFSXlBSThOU3JOcjZVcG5PazVQRmZEQXR0N1VC?=
 =?utf-8?B?YXJmc0JrVkZrdk1ZTTRZTCtPV2g2WUpjMGpYUG5mSWhvUGVQaTBNSkl4cTNo?=
 =?utf-8?B?Tkh0azBVajU1NlZ5VEtCNndaZlZIRUNjV1owTUErYnJ5YWRLUloxVkJlMUcr?=
 =?utf-8?B?NlJWZG9WK0RtU1NiVGJtajVOTFZBVTR4NGluZnkwRWdoQ3RtRTBmQWw0R0sx?=
 =?utf-8?B?RjM5MWF6NzhqY05pZkgxVTJSemd6UEJ3NnJBNmw4OHl2dVU5WFFGOHRXZEZO?=
 =?utf-8?B?ZTFLaStFNytRNjVlWmlTSlY1M3JxYVVpaVVrYWZIdDJMaDhmWHd4dVNKMGJn?=
 =?utf-8?B?MlArbEdvYWtUa3FKWEJFR2U5VTk4U29VSlBYU3F1dm1peExtbkhJSldOQVBj?=
 =?utf-8?B?YnZJK3ZlUUJGUHN4RUdJUjQ4OUpKZVFNN2Zwck1zVlA3U3V2Nno1akhIU1Vm?=
 =?utf-8?B?UHVxZW9mUkZNeGxpOHJza1c3RGZ6R0J6SFRqdDAzeDRBY2VpblV0Z2dKTUxy?=
 =?utf-8?B?OUozcUNzM29Qa0FHaUlnUFk0NnZUdmdXQzgzb1Fsb3A5RmdaMlZXbkVZNnRV?=
 =?utf-8?B?Yk9XNllHMDR4bGF0SGlZQzdlbTlXWU1KS000Nk1rV3hJeEVOZVp2L2lkSmkx?=
 =?utf-8?B?bVFtVzBwYms4VkUrbkxOcUpHSk54d3h6aFp2cmxZUDQyT2tnSkxTVG5VOERp?=
 =?utf-8?B?SVArb3JMOUJ0bjErRFovTFFZS0kySkpVNG1zWEVnYTkreWlRaGpQSUR5RXhu?=
 =?utf-8?B?KzNmQisrMlJmQVNaU0dJd01oUmtVMkJBREZnN2dSZW5hRUQzTVJyZDdsS291?=
 =?utf-8?B?Q3MxMXVpaVBBajdxck5FTnEySWpSQ2s0bVRUM0N2Ym1sT2JUOXcwL2x6bTRa?=
 =?utf-8?B?ZTJucFl3alJ3RzN4aCtjakxKbkMrd2JXK1FPV0pqMzdjZHhuNnhzaUhjbm9z?=
 =?utf-8?Q?tQpn0T2sHOI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzJvUEF5eDBFbGpsUDIrYkR0TEZLTVdVcmlLaGR1VVRleHZyM0RwcVIzOHBF?=
 =?utf-8?B?ZWRsNXF1bEx2MDJjM053UkEvL2dLdzFOL25oZmJCUC9BRmV6aDhGVzR5UnN2?=
 =?utf-8?B?V2xEanJ1ZFZCME5tNVdpVkp0anlPaUVTQTU0bDBFUUJpRUIrN09TRXRjdDlK?=
 =?utf-8?B?ZWhRRjlXSDNUSC9nVzNuZ2VhVzcyQk1NdFBPeTgxVlNHdmJ1MExWNjN3L3di?=
 =?utf-8?B?VTd0VmtXa1J6UHA1cC9iaUdNR3RZTTBQdlkveWhVTW1SRFNoRlBWbmtTOVJi?=
 =?utf-8?B?eHdsNm9GM21KRmxKM3NmNmo1WHB5SG5UZ2pwM293ajZ0ejBNZU9KRm04ZWUw?=
 =?utf-8?B?Um5iY081RlE1R3JWZDhmektGT25mVGtwN1FRUUNBRkZHRjM4SHVSM1ptN2hP?=
 =?utf-8?B?VHM1WVZvS2VWVllYOTRHRDg5dXNvN3h6ZDFHbGQzVE8vYUpYQnA4RnovQWtu?=
 =?utf-8?B?NVQ4b2VmNTF2bUt4T3JCOFlWUGM0VEphLzNmSVcrZzVDb3pNQnhaWmJTS0dF?=
 =?utf-8?B?MWZCbmFRQy9pckkzdkl0Qmcyc1FobkZJVjZPRmFvRmtnOEV3alNJbDNCR1BM?=
 =?utf-8?B?Y3dqTnRIb3Z2UzA4SkVnQnh5bVJRV1o2TjNlTVpBUEs3ekpxVFI3dEd1MTB3?=
 =?utf-8?B?TUh0RnFwZWNlekxSZFE5U2JIWFhHSElGellQTEw3aXg5T1lhL3RUVWd5UTJN?=
 =?utf-8?B?Zk5lc2hKK1NReEhxbUZFc3FvWmUveUVyZkRUdmhybE91Z0lBRWhJUVZYYXR0?=
 =?utf-8?B?c1MrU0lYTVRHOHJrMDZHUlZGdWxINUVHRGJxVlk2N3M2c0U2TXNLRjh5Yk5j?=
 =?utf-8?B?MlY2V1JOSmN6REdHUm1Ub0kyMVNrL1ZnWnhHZExBdUpXaGhTVTh6TXlVNmkw?=
 =?utf-8?B?QmIrMmlGeGZQRXA0bUErRDM2cmtZSm0yUXdNRGpIYXVMRWhMTXRiT2RIRTFQ?=
 =?utf-8?B?V1N4Q2Mwb2UzOWZ3WkJGdHpuT0xrVmV5RUlxdlBjek5HTS9vbFVzNHpnTi9D?=
 =?utf-8?B?WmphQWJOZEhkQitZQjdYWHIvbjFMc3ZHQ0lYRGVBT3ZBamk4ZjY0c1VJRm5W?=
 =?utf-8?B?OGE3ekh5WnNTVFhLcFBrLzExWlE3eG5JS1E5NnRmdlRLcWl3dVc4UDFZVk9i?=
 =?utf-8?B?ME5Ta1NkRjhCL0UyL0owdUVLQUpnNDRTQUJLZXVRcmtyMmdiM3JDdDE1aXpu?=
 =?utf-8?B?TzlQWlNuZGppQ0ErTnFkMExjREY2MDFwSEpoUFZOa0NJamhOODJWVEd2RVZR?=
 =?utf-8?B?WWVRalhNbmVuM1RVdlVoeWFVK214ZWswMnFBWWR0QnhvL0wzMnoyZ0xnaXJR?=
 =?utf-8?B?TTdxUUk5WjBRSmpWNld0TjFSK1JQYXo3ZG93UXpDejFHVzlOY0ZkcEtaSlcy?=
 =?utf-8?B?dEZSd0FGQkcra3B4bVBld21lT09md2ZCSE54SmxNZTlkaG8zWWR4YmhQdXhx?=
 =?utf-8?B?KzBSRGd0UzlYelVrVi92TExCL1VwUTNnZWRlZ2ZQMWtEd1hQL3Z6Sm5Rb3RI?=
 =?utf-8?B?TTVpUm4rSTJ6RXY1SFA3cTNqdWdzMXJNUHdFMW91cWdJWVJJc1pqamVEU1B6?=
 =?utf-8?B?M1d6UU1MWVFoc3dOdmpnU29OcXhzaWV1YXpqU1BKcjVGQmVqNnhjYVUzNkxl?=
 =?utf-8?B?b2l4ZFJkUG5ja1ljN3p3QXJ2bStDT2pNUUszOThZUnAzTGZIQ0ljOHBTdlRD?=
 =?utf-8?B?UDZleE1ncnVDSUlNcEZGZE9VL013Sys4VW03S2xHWUMrRUdvQ0NuNWtQQ0s5?=
 =?utf-8?B?SHRXZFFVTVdaTHZWYnlMMzVMWjkyRUlMMEhmU2R4blpYWVMzT0ZqbVB4ODRJ?=
 =?utf-8?B?TG1keWRSR0ZLZ3ZmQmFJeGVyN05aUGFiQnhlRDVkMzQrU2g1WTRBdm8vOFpH?=
 =?utf-8?B?bzJmcGtOMVNNWUdud01XaFhxbE00cU9lU3BpeFNXZEpUQjZFUjMzYXV0SWRH?=
 =?utf-8?B?Zks0Uk4wZjFic2JGMnFHdlRGR29POHJ1SkpJUnJIRmpOb0NpRjNhUnN3cTRu?=
 =?utf-8?B?RUpCbmNTbGRJWjk3alYxNkZ6ZXU5ek1zam90YmxKT3hpT1UvalRFYkRGWjdY?=
 =?utf-8?B?Mm9ZQzhMdGovVU5ER2t4UHl2cFhjNDI5UFk4SHlxK0dhTUpHN21wNDFKV0Z0?=
 =?utf-8?B?NTVvekdNRHZJWEwrUnZHYUhjZk0vTFpTZXMxWVVOYldCVGxSMXJWeWpETU90?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7483e60-9acb-4df4-309f-08dd87669c9d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:41:34.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzLQf2SJs/SNh1zLHnW2bXV0mxY3xWRkB7oRfC5GfcySTW2siB9V0BF2ubOS3whOkpprIWc1FZcL2yyltrbsTkswp0kujOBaWMHjS05EmSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com



On 4/28/2025 5:39 PM, Jakub Kicinski wrote:
> On Fri, 25 Apr 2025 14:52:14 -0700 Tony Nguyen wrote:
>>   18 files changed, 2933 insertions(+), 103 deletions(-)
> 
> This is still huge. I'd appreciate if you could leave some stuff out
> and make the series smaller.

The obvious stuff that jumps out to me that can be moved out 
easily/logically doesn't save that many lines but, perhaps, Milena has 
some other ideas.

Thanks,
Tony

