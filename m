Return-Path: <netdev+bounces-113040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B993C766
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 18:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F8F1F23B47
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486419DF94;
	Thu, 25 Jul 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqSmmo+I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2319DF75
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926146; cv=fail; b=pj/c8UG2G/YW3EN5bG9B7ggWfFRNopwif8h/LRz9OJE7bC4r+Hfjl6sFkxBFmUuZAVGm8CdrT0zY3Z/NwtgRqjrwxAT/gvJfB3OlS0FerCiBl5jwSgeYMUUhzod9sSOaRE3gJMq+Pwx+gRPZdk+pEhySXc6JTFQDdURcoCaqnQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926146; c=relaxed/simple;
	bh=FpecZYGtY5V9DTsnKi2xuuRC1Mv3dF9gDU7LLyqXZhE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JwKgNlaMQh8+pSo78xjC19EsXISCI9jZ2gUFo81Fo3s6nK6i3CedJ+5DtXlG/0fKwtYjVs4sVQwURrLssVoBQh3ZPbXabdQTU44h+FkwhgL0ge9p+rp+Em247rksz+b7NiWgHZyY2VKs0/pC3ArFF/48n8j2pfLNi/llhdJT4Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqSmmo+I; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721926144; x=1753462144;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FpecZYGtY5V9DTsnKi2xuuRC1Mv3dF9gDU7LLyqXZhE=;
  b=EqSmmo+IU0DUCPgh1TRmRXvR4vL69rrvodXUO+qcfywJ9uMhBl03B0XV
   mf+MKyPiygFru+IDUaN+PBpDRBmOwt4gtBEzSDMtdI0SxyCPSOT3YyGNX
   AT//LnpJEB2sbn5phDOH8xoizkggYvUO9ep0m/qo/JsWtfLwY/DmiNdFB
   nbpWWRAD4eLo56ScxlIpQrnph8ujKqGZ+q7ndEzxT8Q9b+xJ4Q0qjOZs+
   ddd5t6NOx/DfVCQpoMbbwHUOQNpseyPV+Lok5myG+pYgsjsaF6Ukxwtm3
   6hZjuXyb/2ImmpKszEDFeMVye29K//HuGPT9rZG6D0ib1BzfgFTb9OTJh
   A==;
X-CSE-ConnectionGUID: uJIKLaJ/Rs2W230ZfAlZCw==
X-CSE-MsgGUID: dBX2zXbVQ6289AU6/hXPJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19867217"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19867217"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 09:49:04 -0700
X-CSE-ConnectionGUID: FJHGVPWCSsmkoi7+WsJnBA==
X-CSE-MsgGUID: AnA0UwmRTlGb1KO0cZt5+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="57278424"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 09:49:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 09:49:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 09:49:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 09:49:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaIs6e6ybBZAA9qO/SaDrq87WvTk/X6aooQ0r8oXwJbqWvnoXIYGO7sa9SJYXs058x+0l99fYaTD9+xnJqyaaAADoLvphScVwo77EUioep68YiyycNi6FUySwlQJny3tCf75t+TmFpcPY2Ezt0bMCxSTjHpwW74A8DPGpdpwCjMK7Pw62Q9Xf7mfGGo/7dVx0J748Z46DjNex2dV1kZUlD6Makf3rDZ5K66DEqcQIZWM5aRiPRToVkpXRE9o5OQOk76J5+4k3W6ET2dCqyZTuefXtKyEzEvQV3KBaRb1N3X2Xte7NK9ccLYcgJkwJwk5l42w/WMTYWvgh8Ox04oJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWsEL/+ToUTr1kgMX3Mo1VsiMGVKA7d1nnCj4FiVLmw=;
 b=RnDbmOr1/gKKzOoCJhOorU9kOKbG9zRYyN2JNXx50rtksbKUMkRgIPPvxvXl3I7TZoAjuOgkNfIYbgY+opyJX+BqNalBENHtaotm3nkJiz75EjEyYmbGceK9H9AmkReehP8QWQqcAtf18WAO6bQEclm2fDA+y9QRdOwRTMp6s/NFXw0/4YfrSUIB+Q1C/DzkGNuxMRnG4S5uluqhQ2p7cVDqAgi3dQ36Tc3sZQ0LOHDgeuh+znntOo8wuOghjWgw0gQklu8BJl68CIarTDkURurvUriPDc+Gm+64iweP9zvq80Q1MnF2rZLDovZtyY2JQkkW5/gezlRYdezBRtFw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by LV8PR11MB8534.namprd11.prod.outlook.com (2603:10b6:408:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 16:48:54 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 16:48:54 +0000
Message-ID: <6e375979-45e2-1dbf-1857-a3565f9f67ca@intel.com>
Date: Thu, 25 Jul 2024 09:48:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Introduce
 netif_device_attach/detach into reset flow
Content-Language: en-US
To: Michal Schmidt <mschmidt@redhat.com>, Dawid Osuchowski
	<dawid.osuchowski@linux.intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	<pmenzel@molgen.mpg.de>
References: <20240722122839.51342-1-dawid.osuchowski@linux.intel.com>
 <CADEbmW2ANTgihP6rjS9Wmu6+7TYii37K+NH-opw=8eCLqnPH5A@mail.gmail.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CADEbmW2ANTgihP6rjS9Wmu6+7TYii37K+NH-opw=8eCLqnPH5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:303:dd::11) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|LV8PR11MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcc4181-52f3-4bac-a20a-08dcacc9ab80
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFRxOFdyMDIrZnBHcWdCb1AyL0N3R2p3R1dwaVljd3RWSTA2Ly9YY3ZQSy91?=
 =?utf-8?B?QmFDbGw5dWJ0RXcveGZaNDF1ZUw3bGgrdmZxaE5tRzFzWlBMZVQrNmJEeE80?=
 =?utf-8?B?QmFSQzFTcFllTFNwR0JKVmEvZWtXVlYybmswcXhHS1RHSXJRRElETklNRGg2?=
 =?utf-8?B?OEsxdjJRdjE1UzVDcTMydDU3SXowT2todWVWeDgxNWFOekNSZFdMUVZWUFps?=
 =?utf-8?B?dDg3QkZ5ZnhyM1dvd2VEM0k5OHNEakJEV25rSi9kSU1DWkliUGs4ZUdjNGFL?=
 =?utf-8?B?MjJBREo1UUkxdzNvRzExb0pMWUNGRGs1a0RXSnZGdXBVaGNrNSt6ZlhPNzZu?=
 =?utf-8?B?bkhCL0VRNS9BNlZNaE1NNERRekE2QnpkNGtWdWtMckVjeW9yUmx2Z2xkdEhI?=
 =?utf-8?B?WjQ2bjQxWnhhKy9jamNiVHlIVlB6c3hmanh6TmhyamtIUG1XWDJlak0wUk45?=
 =?utf-8?B?eHdqRDRMMHRHQ0UvTVFNdlIrTTRyYUd0MGIwSGVuTUsxbzY0MS9kVm41NDhm?=
 =?utf-8?B?UVNVNGpaNkFyb2FjTUJubithUElmVUFnOEZNNlBxdFBhQjJLdXJVZHF2eTN6?=
 =?utf-8?B?RmFyMUN6YTNSbENGenZ6V2UvU2Uvd1pNbWNpMUZqV2dvNGdIYmFZZnl0LzRI?=
 =?utf-8?B?c1BEcjRBQ0ZhOTJGOFJOKzRPYmpVVU50NFdKVFo2SkIrOUpPdXh0dzE1bkM4?=
 =?utf-8?B?bE1aK1F2QVM3MDRLQTZBL3MydW9RUDNnM1kzdTZaTkVLZE5KYmdXOG1DRGEx?=
 =?utf-8?B?VFRJbXdYVlNuMHpYS3cxZ2ttN0pUeDF6amVQKzdVTHY1elBlR2p0cjZKcTl4?=
 =?utf-8?B?R1BuU1VMeTV3bmdJcmo4K0lvWmM1dkFjSFlBcDIvV3R3ejlVWDNybTdycW9k?=
 =?utf-8?B?dTJ5QVlqNkFUWVhqc2htUDg5RUVROWpEZU5MQWpmamswNEJIbXVHV1FjYmww?=
 =?utf-8?B?a2JFSnp3cm1EZGgvcnhRN1c1bkFIT1VvbU1KbkhGRy9FZkNtOWZ2bGFaZWNt?=
 =?utf-8?B?S1VuMHcxYWNQWmVBTG1CTXhiVEdEbVlzQ1VqeDYwTEIxWUZxRnl4RU9nRTYr?=
 =?utf-8?B?aFdzS283L1BsYTJkbDdjRXg1SnR6YTMrWWt1eC9VTnJXd2Y3Q0x2OGNxZGhR?=
 =?utf-8?B?emVVbVFZdDFFWFFlcGx4ZTRubjJSS3VPTm4yaWZLbEJ2SzhuWEhMZFdSYWd4?=
 =?utf-8?B?c2l0aEQ2Yi83QStkTS8wUzIwN0oxK2dScDlkaU5OMGxBTlVvWGN0SkI3UE1O?=
 =?utf-8?B?dksrdGF5SVpKTkcxN3JBYjlHRm9mSUpyRHNCMzh4Z2JOVEM1YWN0MHdNalZh?=
 =?utf-8?B?dHNOODNENlVNbDNKb1JGMlVVbCtPcUFERit1dUdtZEJIVFdhZWhFTjNwT0Fn?=
 =?utf-8?B?YjU3VUZYT3ZTZlNDbHhoSDlSM3FVTjVvUExBQ2IyQ2JRTFUzTy9kYUFHWTlR?=
 =?utf-8?B?VERmNW5OSHZjaFJGVlZDLytOWUpTMGpMUjMySVlURXd1Skd6L2J1V251QmtL?=
 =?utf-8?B?WFdUQjFxd3BKeHplOEg3ZXBRRjJNVmtHSmlDblo0V2FLZmdxZmEvL3I1V05t?=
 =?utf-8?B?dHNGcVVJZTJlZGkxdHdydW1iQVNhbE5iTzcrY2diMHNXNGtxczNmemRCa3RK?=
 =?utf-8?B?dEt2OEF3bWZINkdSV1JoTlllOEZqSkRQaE1sMzUyb01RYmJUTWxaQ2tNMDBS?=
 =?utf-8?B?WUl6amsycEJEU0dkYThIb1p1c09hVjIvMTJRTDdyZlB3N2RFTXVmbUttdWFi?=
 =?utf-8?B?eENBNjZhQ2szYmtmQ09MSkRFbjRrcW1JY3dQelA1NE1KVFo0MkRjVHkyVVBr?=
 =?utf-8?B?aGVpMUs0eHQ2RTl1SjRjUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUFQc01KOEVoY1FXMEp1aEN3YUs0bHYxUXRIYmJpOXlxNjJnd1k0NmtGSzZL?=
 =?utf-8?B?TnpFSUpCNnp2dldoektuMTEwZVpzVnBHMmRCdCs1dks1NFRzMDJIRU1QMUph?=
 =?utf-8?B?WnZWd1VOQ1QvSEVGUTU2OTc2Z09mMExVZG1YbWZsYy9ISzAxczVlZm1RSXl3?=
 =?utf-8?B?Y3pmeUpBVVVBbEdjenhqWnN6bFltcHNNVSt4MmpOS25yZUlLdFRpMjBwZFhL?=
 =?utf-8?B?SnJ1dWNEQjF2aEVqUXFxY0JlQ3IwWWNFWERSbXo3MHluYmZuRXdoVGkwTDJL?=
 =?utf-8?B?SVUvclJDM0lGYWc3WVMxWFYwMUhMa1R3eEhEVGVZRjJBb1hONzBoeTU2eWJ4?=
 =?utf-8?B?RndOUERTTWhRVWE3YzVvYW5ZSTNEYzdBdlFGVjM2VUJ6L0RUYXZvQ2FRZG9l?=
 =?utf-8?B?SnMrbG9wbVMwRXRCVDFJQWJUTDl1eE1RdFNOSkNMOGxWOVpPSTBCVEJzMzQ1?=
 =?utf-8?B?aE5mNUtPU25hMzlqUzUza1JjT05qbEJGWTNicjdIKytyTVRPM0ZyYkVhdm5T?=
 =?utf-8?B?d2tjMVcwRXp0alFSbitvVlJ2YlBaaEQwZmJoLzEyQTBTaklDT2YzM1NJczV5?=
 =?utf-8?B?TmRkOUdsQ2N4VzJCVWpnaC8vOXhiaU5RSmFObmJSdFhDb3NiY1NvVjRFZSsv?=
 =?utf-8?B?THJaKy9ZS1F1TlJHVmtwWit1TzF6bWkxSlpPTVR1Q0l1bmtGNjhLOEFqU2Nm?=
 =?utf-8?B?ZUZKbXc4UGRtRkhNRXJMaksrZ3RuKy9YWVllSXArc2l1L1piMUlkdUdGaVpH?=
 =?utf-8?B?WnZzOCtWbktKT1BrR1Yvcmk5ZzhMbGJNcmRQMUhXMjVGd0dZZTZDWkpWZnF1?=
 =?utf-8?B?ZEt4ODR6OVEwUDUvNzlZNG9sdGZ2Y3dURkdUWlBET2NPV0YrRVM0STE1eDF5?=
 =?utf-8?B?TU1NT0M2L0xzSXpJMFdmck1kNDJ3dEh5VU5FdHFCeUsweDlONTl2dkVvYTk5?=
 =?utf-8?B?V09ZeWdsWjQrWjA0eVdjV3NGU2VWRU9XQU9XT3BLaHFlTnpaRUc2ZXZnWkt2?=
 =?utf-8?B?YkREcXNEdjMvSkluSVZPajFlbm9rS09ZZkNCanRpSnpseXVkK2hoK2x1RGNV?=
 =?utf-8?B?ZXU0aWQ3QnJSMDhEM0VGcmduYjdQZmFYMmtMK0h1QmlwRG0rSGtIQ092dXAy?=
 =?utf-8?B?c0gxTXZlbnpHZlZwcHlvOFpOdXdxcEFOblh1ZUI5YnpDNWZSWUtlVEFlWmky?=
 =?utf-8?B?RGVtQ3pDZXNJTDE2bi96U2t2Yk1PRHdkUzFBRytVN25UYWtJcWlZcWZ1Rmsz?=
 =?utf-8?B?bXVvS2hzMWZnZEhBYWg5S2g1ZmNDZ1lYTXh0ZDN1akFLRnhBY2UzQU9iNjF6?=
 =?utf-8?B?SHdoVzBaQ2t4OXdEL3ZZS1oxa1d5a3hmTU9PdTA1QVFsUTVGTHdvaXJQcTFI?=
 =?utf-8?B?OUQ1L1V5N3lNb2VEcWNTd0FScy9Iakxhc0w0clN6clRpWjVnN1J1amxIZkJO?=
 =?utf-8?B?RzVmck1aSFJXVWN1czNRVHd2OGhBOFNqaXZ5WmkwNzJzY2szOUhnOGczdlVG?=
 =?utf-8?B?NHlZTmdqVXN0SFFKWjZoemZhTmFhODVkYytsS1hFQkFBN0ZFUU1PVW1Gam5t?=
 =?utf-8?B?UXRPWmNZOXN2QVVBNXM5bDNIYXM5VWlEWnp4L3FLSkh6eUdwbDdHdUtEalJY?=
 =?utf-8?B?N2tkOUlUaWN2TENrMEdyYkE0cE15dVBKRFFhZHVvTmJyQnV1citvOHVZRjdZ?=
 =?utf-8?B?RFU0dU44akRtMng4ZU1XandNMy9xZlllbDVTYk5NTTUremIySStIZFZXM2pl?=
 =?utf-8?B?MmpJVTJiRjJ6RXRLb2ZGc1pvT1JJeDlHN3ZodndhMllSaUpyT0I4b0Ivdnk2?=
 =?utf-8?B?d3JLZ0V1am4vSTVETGlSRDJDR2pQM3RWbWJsT0IyVkpHVmwvc1huRjNZK2lx?=
 =?utf-8?B?Z1l6U0o5NFlmZnZpVVhLMjFmVlRmN3JsUTUrWjBkMGRHREFTcHdOT2V3Y3VW?=
 =?utf-8?B?ZGJFcjhYWTd5SXFBdGQwOWorUS9uZTVWRU5oMFdMRHpVYWdSRUZ2SnA4ZmNM?=
 =?utf-8?B?VmtaRXg4azJQWld1NkpEMXJsbmxOVDU1ZE9CV1QrajI4SUREVVg5MUp1Qnl1?=
 =?utf-8?B?SG8yVTJQWXdjOElNc2s2UjExaWNteHlMTlNDRzFlRlJEWERBZzkyd1pwTE5k?=
 =?utf-8?B?QnljbmxkQmNNTTFxVEdhcnQvb2x6THFRQjJHclJRR2JOV3RpMVJMeHRzUDZ6?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcc4181-52f3-4bac-a20a-08dcacc9ab80
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 16:48:54.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XF2p8WOJ+/mv/Rw9398uT6vSDKGQ+Ag1KViMol8qpiypV93+hh3qp9jaaTCCtnFPcGAKkok0KwLbrGssoaf2x6I0EQkL2u39VRVKblbfTT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8534
X-OriginatorOrg: intel.com



On 7/25/2024 3:30 AM, Michal Schmidt wrote:
> On Mon, Jul 22, 2024 at 2:30 PM Dawid Osuchowski
> <dawid.osuchowski@linux.intel.com> wrote:
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index ec636be4d17d..eb199fd3c989 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -6744,6 +6744,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
>>              (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
>>              vsi->netdev && vsi->type == ICE_VSI_PF) {
>>                  ice_print_link_msg(vsi, true);
>> +               netif_device_attach(vsi->netdev);
>>                  netif_tx_start_all_queues(vsi->netdev);
>>                  netif_carrier_on(vsi->netdev);
>>                  ice_ptp_link_change(pf, pf->hw.pf_id, true);
>> @@ -7220,6 +7221,7 @@ int ice_down(struct ice_vsi *vsi)
>>                  ice_ptp_link_change(vsi->back, vsi->back->hw.pf_id, false);
>>                  netif_carrier_off(vsi->netdev);
>>                  netif_tx_disable(vsi->netdev);
>> +               netif_device_detach(vsi->netdev);
>>          }
>>
>>          ice_vsi_dis_irq(vsi);
> 
> This is broken. ice_down leaves the device in the detached state and
> you can't bring it up anymore (over netif_device_present check
> in__dev_open).
> 
> This is with tnguy/net-queue.git:dev-queue from today (commit 80ede7622969):
> [root@cnb-04 ~]# modprobe ice
> [root@cnb-04 ~]# ip link set enp65s0f0np0 up
> [root@cnb-04 ~]# ip link set enp65s0f0np0 down
> [root@cnb-04 ~]# ip link set enp65s0f0np0 up
> RTNETLINK answers: No such device
> 
> Tony,
> the patch is both net-queue and next-queue. Please drop it from both.

Thanks for testing Michal. I'll get this dropped this from the trees.

Thanks,
Tony

