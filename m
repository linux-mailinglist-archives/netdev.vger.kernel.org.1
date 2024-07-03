Return-Path: <netdev+bounces-108816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF8925AC5
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E19A1C246C0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532B17C23F;
	Wed,  3 Jul 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFvnGqH4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89F61FE7
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003937; cv=fail; b=F6kC83bTn+lbXLoaBKD/XMYcChfssQ2zqxKV/z5qVTSSr+Fmpc+FBG4WKAOoD7FzMLmcmOgX3Rzpq6fH1hQSPLWbMHw0UPQJVVO4mQYmIxddmojcGXKQgfzj0fbR1A1R6wS9ElYSGfQG6mUtU3ollUX+yR1/1d2GT2bI775WIi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003937; c=relaxed/simple;
	bh=rJEFr4UsX/0/hNPF8kSjoknptT+1jkbQwSrgSS39RAU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ddcl8ymXekLKIdshI0zIa1OmGHfktjT/T7n78f5ngZMwXXMxqMUoujJnksFwn9ByydHdr4Ivu96qsGeaQDOP7KRt2iaB2y7UFQxKXodiFr18tVa6IhqmayPfDM3Q6RAIb/HxroFTui7Tathnfgw+l3xfDlSmMkYttT1+O+KTPHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFvnGqH4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720003935; x=1751539935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJEFr4UsX/0/hNPF8kSjoknptT+1jkbQwSrgSS39RAU=;
  b=AFvnGqH4FI2BK0A0wsC9xPmK7vRpEFJgSR2e3VxTUOjkvY5hagABpk2p
   tcQyD3/bWam8xBZnxN47Xu/lYpmJs95s2HADramOsU43uNCMxWDfi9El5
   XzzCRiyldZBfwzciiz2DHS+bQp51ZY1z3Ovh385Bw34nrrgHLgwHXnbAe
   gCcWu33PPexYbXsBKDW+K2vmMEfojh4+rN9Q7sWnF9ftp8qwlAMIui6ck
   Sj5/2tHGHi5Pa2Bs4pY7Yti6ThTDgM6PJksGG/ylSyTMQbpuc4MDIzqxn
   DdQt67ltaGfzRBNLvYVmyj9zT7YQgdt4hCzAAcYf0Z/q/Qh3fjnTAUYwu
   w==;
X-CSE-ConnectionGUID: 5D6O47AKSu2WUcX8mA9gMg==
X-CSE-MsgGUID: r+qt8+7USaG+0zsHVu8HJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17434879"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17434879"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:52:14 -0700
X-CSE-ConnectionGUID: OyVF3wcaQWSFIQKRO9/8nA==
X-CSE-MsgGUID: fFFTXkWUQbC3pTnW5cktVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="77362779"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 03:52:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 03:52:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 03:52:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 03:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFTliePgVzjhT0DlzE+TwiSCVzZAhOnCPUrw0ba9Pv+T8SSb4kN277lv1Ys13JApePzdeuNdJWWHvq1bqVmPr1UYE7PRHRtL9kLp5CSSKMXoFcG7su8Ec+34uf7Tz91GyZsiS7whjbz4sGVAXElxTJN48yq93byslT0naHDpGVIuU2IzA5YesSXo39j79fzrHVpoApYr4mcuP0mu5cvA63EBbg8N9wQxhrn3snGuru7PyizP7R6RcrfJHm12CRGvp80rGkZ0BnH3SAA6rv5tLx+V5kPSg99JvwM0HEURHq9JyBszZioJHCfgtDZyBIWfJseN7RQ6YdDKYVFqbCF/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIGgLGHJoGD557PWFrjBWL6y4Mkm16grcRviHA5glhw=;
 b=NHi+ys12Gs9PqIq3mI97Y7hCpGJ3hB0fuyeNerF9ox2/tUWgt/Vs6zJqqw8QvmLmfmnAiN6GPH2a2HIGRGqvAFtNaX3r9Io6+56W6CtjnZ8KsUbZiVDEGe51lHt/UI8AzFX+srbmat15fLNDgWS2hBnqGfiCsKiIrOI0rekf7GePdQcd9C4UVTZuNe90+rSVQ4qns1CXSZxu5/emkRwJe4jeP9HgmEtgYyvdn5ERVN0ZhZUiJgiPUnTMI0iPlSFNhtPKU6tuSXem5TcM1MRlUUSK8QpaUv/1p5eOAcTebKAGcIw4aN5zWdRb95tBQZ9rqdI3y5rF0MW0kL18pi0Hdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 10:52:05 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 10:52:05 +0000
Message-ID: <0a790e16-792b-448c-abaa-a4bf8cc9ebb0@intel.com>
Date: Wed, 3 Jul 2024 12:51:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/11] eth: bnxt: bump the entry size in indir
 tables to u32
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <ecree.xilinx@gmail.com>, <michael.chan@broadcom.com>
References: <20240702234757.4188344-1-kuba@kernel.org>
 <20240702234757.4188344-11-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240702234757.4188344-11-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0086.eurprd04.prod.outlook.com
 (2603:10a6:803:64::21) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b35151-cdb9-476b-09c0-08dc9b4e2d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkM2MFdWeXdpdU45TGg5dWhqR2RsVWd5ODlZK3FPZWFSdjJVR1FLMXdjQ2hV?=
 =?utf-8?B?VFNqVlVzVitxZ3MvVFFqQ2tobXdOWkV6S0I5Y3NUb3JvbTk4TDNRSkFqd1NO?=
 =?utf-8?B?aS8rdEhTNG9VdjRUT2VSam1WODd2a1dsRFlOQjV4UHJxY3pMS3dieUVHSno4?=
 =?utf-8?B?Qy96bmhCdDR6Qm9kbThkckp2bXZHR1VaaW5QRHlObng3TzAxTGRvSy85UE1J?=
 =?utf-8?B?bWlveDM3bEQxd2wrY1pLOTdUbTRjMlBHN2lHTjhlV1FuckdGNWVZQ3h0b2NP?=
 =?utf-8?B?cFcrWlZlZ3JKWnJIQjdrMW9iZHZ5NzNIUkN5UERHd2FpNWp2TTEzcDRUei9a?=
 =?utf-8?B?UFhJamdhRHFWK1lSUVZTU0E4N2JMc2JydnVtdUpvZFQ2bDVvRzlyRHZWY08w?=
 =?utf-8?B?MGhjY3VSRnh4RjVmUCt5MzVRNmhNbkJKNXdJb05QTkYrb2VvYkpBdXlSdm1T?=
 =?utf-8?B?R0ZDVnAzUHNEQ094Z21HU0QvbmZ3WEx6a1dvamtyVFdRSVVHYU05bVF0T0tO?=
 =?utf-8?B?L0FHbXBaRDdkU29JTWszTVFabElmd3JaWHI5dThQbGFRN0pXdzZLNmZkK1Vi?=
 =?utf-8?B?djJQUU1jN3FwbGZPRktHd2xnUHV2S2UrZkU2cUkyM0VCYS9KK1FVTGRycHJR?=
 =?utf-8?B?bHdzZ25BRkNYeWRhY0ViaGN1TmQ3U2d0YXgwS3daR1V1WHpQdWUvSWoyd3RZ?=
 =?utf-8?B?ZG9qTGhCMzhMTzFCRUVXbWRwdWpiZUw4YkR6WEk5ZkhuWU9oZ2FIanUyUTZ6?=
 =?utf-8?B?b1dMeVBBaldaT0hCSmgrSFpmS2xSdUVLdjB2OGNaQWFJb1VENDdWNTl0d3dm?=
 =?utf-8?B?Y3owSU1VYytDNEcvWXlXK3VPZmVEV0xiVzI4VHFTaWsrcHNkYzFlV2ZSeisr?=
 =?utf-8?B?ZmEwYlRSdlh5bjRyMlVFL0Mwakc3SG9iVnZ6bDkyeGlNVVVZbjBXN0pwOG1S?=
 =?utf-8?B?UkNNQ3NEaHhPMEMvb3VTWHdmT3k5TWlPVkZsbklZOHFHUUJWZHdhNEtRdmtU?=
 =?utf-8?B?NmtHcjVySURCMXVpTFlUNzRQdXUweUgwYzAyS3FjY1U4cVoxenUzaXBYMWZ0?=
 =?utf-8?B?TUd6SU1PcWExTVY2V2RCUkNsZVFrOUtLUzBVdzdCOVByZXNRK3dtMmkva2Jm?=
 =?utf-8?B?dXQwc2hMeG1ZOExVeDh4cXE0a21PT2tmb3BkYnQ0VHhPYzEvVE0rbGlvSHlj?=
 =?utf-8?B?QjdmVkVZdFFEbzBZbFVYUUVmb1BnQzd1dHJONTNlY1VsV09qcWM2YkE2WDJp?=
 =?utf-8?B?SGJQWjNjRUpiWkpNQS9sRnNvZDNmRUU4WEMrNENuMnhzNTloMFlWSThZVXg5?=
 =?utf-8?B?alBXRWVaUGU5a2ZhNllBRnR0bnZVUVpTRWRMdS85RUtOK2d1VUYzUXIzTzJK?=
 =?utf-8?B?S05PK0ErM0VPdk9XdnA3cFlSVmM5bDNPdWRQTUVzaVdzZU1lMDNLSmpYajVv?=
 =?utf-8?B?d1hIOHVJdmlIT0pVVkh3QmJnblovbjFMOVB2eVlhN2xTUFhhUUtRU1dadXl2?=
 =?utf-8?B?VTd6VFNlcWpjODVoTmpiMjVRb2pNT0dlNm5FL2wwbmtnQTlOZGkyU2dWNHZM?=
 =?utf-8?B?NWlJazFna2gyMWtQckk2eFRJNFFDUGxEZzBvUVdPTGl3RUF5MUhrTmY5MmdH?=
 =?utf-8?B?UXZxYnAyOUgzRFhQSXFPN0tkc3ArZlM2Qk5LWkFIa1BtS2RlMnNjdlhlVVBv?=
 =?utf-8?B?cktXYlBGWE9HTjZKQzBhL2RHaitxcTFqQVFwZEJqTzFaQkJFRnZIbGJVS0E5?=
 =?utf-8?B?a2E5bHRmdU0veG5USXJVRWlGSXR0REd5bXV5OEFuRlluQWJBb0lWRlpEU3g4?=
 =?utf-8?B?SHBjVFBDS2ZXZVpRQ3p3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRxQ3E0dk5kY3dlRWE0ektBM200UmlQRDY1a3dYR2RpV3Q5VEQvSmRaZGpj?=
 =?utf-8?B?bithWWZuOTNQdWlvTysydEJPZmJrOUQ5UWFaZDR6cXVBNFNnMW5mV3FlN0Vs?=
 =?utf-8?B?cEovSWVrSFhDSGNHNXgrdHdRZ0ZaS0k4ODlXT3JGQzVOSjY2OXZPSzBEdENZ?=
 =?utf-8?B?YVkwTmFtVEVzQ2J3b3JNMVJhV2pRTXNNaHU5emFJajRXWkUwekM2SmxZZTFa?=
 =?utf-8?B?QWtuMHJSbk02WEN1QkxQcU5zQWpBM25ZVHpvRTdmL01kRTA3OXZiNFhzOXJn?=
 =?utf-8?B?ZndmR1I4NEtkVzlXVnQ1SWFvQjEzM0l3S0FxRUZVOG5LaDNwOFVVenFjbkln?=
 =?utf-8?B?ZmlPR1VtVE9ic2Q4WURFbDlJdEMvZDEwRG1DZTgxbURhU2lNUThmbFhlWElp?=
 =?utf-8?B?R1pKbThvOVJoOXlqUGxmRk44RkdEeDZtcks1YnY4L2lYeURieUxKNEgyQ1VV?=
 =?utf-8?B?UkxjcEorN3Z5ZDZOcGRYQkwxVWJkY2c4OTdETzQ0Nno5VHVnN2lpRnI3eVh6?=
 =?utf-8?B?T1VmeDJFUDh2Nmc1T2ZrMzlTVGk5N2pCRXQ4TTBwTnNYNVNOcVdXZVNtT20z?=
 =?utf-8?B?QnJBTHoybHZJSVQvTmJ4ODdVeGtLbWIrYzVLemQ0ZFhoM240c1RBT3ovMG5B?=
 =?utf-8?B?TFg0QXQ0OXpYK0Z4TkdoZ2tMZUxSK1FsOU54SHBZVmRta2VoVFgxbzBOQld1?=
 =?utf-8?B?dlByUWEwclJKejBmcURLa3J6bEo1OHYzd3pteEU3ZzdCWFZaSUk1RHA3MFNZ?=
 =?utf-8?B?amU3REZackN4VFAyS3ZKSi9CdHprdmFoTTNrTTJLaHRncUUwa0lyamdIQzVw?=
 =?utf-8?B?Mk12Z2tFdXNDVWxYMTVlNllrQmZxb3lXSFUyZGpSS0FGeHVDVzZmZmZ1TzNO?=
 =?utf-8?B?b0FOTXBudE1VN1lHV053YUdBdW1VUUowdjR5bFgrcW1VYXpURDJZMmZ0S0V0?=
 =?utf-8?B?TUcrWEJpK0dUNTRQKysxbXhTZkV0TkYrS0krc0YvaitDbk1DNGlySjV2eG8w?=
 =?utf-8?B?M04vZ0VxZk10VDBLaThtMEQ4eXlqRTJLenNuakQrc1E1N2dRdGw0Z1A2QnlW?=
 =?utf-8?B?azRqL0VDMVJybDg1S1RhOUJHUDF5dVZnanQrdWhkN3VDb2Ztb1BtVG1xQ2NP?=
 =?utf-8?B?d1JiT0lXOTM0aHZ3SHdQTnlIcGwzcUdlOEtZYk1Rb3JMS1crZUxQSDFKOFU1?=
 =?utf-8?B?aFEzYmhFUVJUajNkT3cyS1FPZVJRc0pKRGxoUlFSSFVCWHpCZFQ4dUVXTDBs?=
 =?utf-8?B?d2EwMCtSV215VkdVbVNVT2l3dEFLSzRveElhN2U4UCtuVWFIMXZtMTFZcm40?=
 =?utf-8?B?UzAwR1cvcitMQWlUWmxvV3kzTGRFL242M2ZIVXkxeXRXdHduUk9TVUxqL1Fy?=
 =?utf-8?B?TE41cU55VjhXajNLYUU2OWc5bDFMK3RudTUrbWFXVC94OENFRllBSi9GYmlS?=
 =?utf-8?B?My9TOTlDckZ6WDBNdzNUTTN3VC9vaWhZTFhwR2QvSUlpeFFQclVXZ0NQWHQ1?=
 =?utf-8?B?Ym9jb1dsRlVXTFdUMDVlQzYvbXRxeDBzVldtU1JXb2NGWUxzVHdhK0VIN3hv?=
 =?utf-8?B?U1hXZGxoSlNXdzFFczluWXJKV1FWUm5TVlBjcVI0bzJTcTdRKzZEMWlmaTA5?=
 =?utf-8?B?b0YvTGttL25lUGJ6V2hoVUdGUkk0WFNDK1Rwajd1LzJ6QTFKek1jSUVOM3pU?=
 =?utf-8?B?QjQzTmNTdUJjWmlFWGZBbXhQNExHSzdaVzkxUXh6bHNHdU5HMDEyOUdKTDd3?=
 =?utf-8?B?Rk8vUldNOWc4SWJiUTgzM1l3VEN1cHNCblFCeDEyckdqTlhGMzNVWmJ5QWZ4?=
 =?utf-8?B?MHUxRFdCamszd1djYTk1a25rQkY4cWl2Q1pDOURuY3hJWkVkeDkwZG9Eb3dM?=
 =?utf-8?B?YjhPY1lhUUN3V2Ntb0hLQnY0T09xMXZtVDlIdDluNXBnRUg4ZUUyNFM1MHZM?=
 =?utf-8?B?UXp5SVBwTkRmUEg1L29SUmdBZUpMQTZCWWFQT1FyRnpqYysxNmlwM0ErOWlN?=
 =?utf-8?B?bXNaWm9sRXRVRHFkdFlLMUViNFRyTmxGNENqekpoSUxxeFhCSVZEV3RpdDZv?=
 =?utf-8?B?ci9HMTN5RGErU2lVckJTSDZsOVI2d1orVnNCZ2R0TW5ENmRyR2tET2g4WDV1?=
 =?utf-8?B?TTJCWnBJZldwL1c3Z3JiQllvRm00RW93SDhGSFUyWFJzN0t3Uk04QWo2aEl1?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b35151-cdb9-476b-09c0-08dc9b4e2d52
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 10:52:05.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0dyhbhOB2fNLN+kBfFXtjYktjvfeR4RT97kzvXP4MGhNVO5qmeLwgBW3un6MgmOuvSaU3kysR0bde/OKCCgaIb3FQxzRmxxh7lgEMHWiDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com

On 7/3/24 01:47, Jakub Kicinski wrote:
> Ethtool core stores indirection table with u32 entries, "just to be safe".
> Switch the type in the driver, so that it's easier to swap local tables
> for the core ones.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 8 ++++----
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 4 ++--
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 6 +++---
>   3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 6b8966d3ecb6..4176459921b5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -6225,7 +6225,7 @@ static u16 bnxt_cp_ring_for_tx(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
>   int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
>   {
>   	int entries;
> -	u16 *tbl;
> +	u32 *tbl;
>   
>   	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
>   		entries = BNXT_MAX_RSS_TABLE_ENTRIES_P5;

it's a shame that default git context is so small, a few lines below we
have tbl alloc:
   tbl = kmalloc_array(entries, sizeof(*bp->rss_indir_tbl), GFP_KERNEL);

> @@ -6248,7 +6248,7 @@ int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
>   void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
>   {
>   	u16 max_rings, max_entries, pad, i;
> -	u16 *rss_indir_tbl;
> +	u32 *rss_indir_tbl;
>   
>   	if (!bp->rx_nr_rings)
>   		return;
> @@ -6269,12 +6269,12 @@ void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx)
>   
>   	pad = bp->rss_indir_tbl_entries - max_entries;
>   	if (pad)
> -		memset(&rss_indir_tbl[i], 0, pad * sizeof(u16));
> +		memset(&rss_indir_tbl[i], 0, pad * sizeof(u32));
>   }

without the above allocation line (perhaps you could mention necessary 
bit of that in commit msg in case of v2) this patch could not be proved 
correct :)

with due diligence done:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

OTOH, I assume we need this in-driver table only to keep it over the
up→down→up cycle. Could we just keep it as inactive in the core?
(And xa_mark() it as inactive to avoid reporting to the user or any
other actions that we want to avoid)

PS. patch2 is duplicated for me

