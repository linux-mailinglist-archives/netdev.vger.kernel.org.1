Return-Path: <netdev+bounces-177834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253DAA72007
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0F93B0541
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFED1A2630;
	Wed, 26 Mar 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhDfk11H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A661F8738
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021140; cv=fail; b=jXjsRjjux3XqgpbMJ6wNKDkLIgMORqbHCFrHbXNTkfJtI/XIYOC2uCuxq7k4kSABE5/CZ+ltz+D17gVnGRM/xPuLvJbX1cZxDwzx3dQu7ZC8vHGEjeBZLfM8g7yIn3K4JiWHFbW8Q09GZP/3hujDzC2ONnqK0bqfp8S/1WGvXTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021140; c=relaxed/simple;
	bh=9s3VQIPaaovtflj5RmEdHD8Ul7EhDv3wkYlKjKe5nQE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qJbTmer+EUvij3qc+B5MWTkOB4xYNdm/YTIStdaMxRuaCnonG3CSXJO2gS7KLU4sDCMHvN2hNm64fZl0/S4bwe0i700owe8EpajwRI7oB289OEpPcA3KyAYYpQkmXkZ3MYX76as+RlruETuehCEseLfokrBVVw/Gq3jBCWQzcxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhDfk11H; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743021137; x=1774557137;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9s3VQIPaaovtflj5RmEdHD8Ul7EhDv3wkYlKjKe5nQE=;
  b=bhDfk11HUNXCE03xF90W7PePQsxpAMv8dP4WOPYxcOJIWiA8axZlojAS
   sc0ISuBTEQgPCFP05COP2M7Z2zjt1BpRFHVz8Td/We61JKjCPOIM/lTQ7
   snT7G7/ecFH64AjLvWYi3lLUkmiU4x0bZpunY3hzY04z2ZPEwYyrXNEfU
   ASG78OhPg42cfivi28wfEr/r1NFDIWJFlLbPtFKM2Ow5UiTa9I/XHae2l
   9pzA8c3fH7ETc/wbV0qtSjiajSdsOdBKmNC2viyCqEP+GAQCiB6CJRIgq
   0x7SvBPxJ5TJn7ZARgcyiEwmUGzicjEpbDeDuuTPLw7dY5UL2Sp2adWo9
   g==;
X-CSE-ConnectionGUID: OqAUG7W1TCiAmC6zMcN4dg==
X-CSE-MsgGUID: eqsLrYpvQBuVjy3/Rd0/nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55708526"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="55708526"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 13:32:17 -0700
X-CSE-ConnectionGUID: wLUe9TxFS82uVPg1Ym9Z6w==
X-CSE-MsgGUID: G8gdMP0xT7afM6WJGvXOeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124710605"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 13:32:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 13:32:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 13:32:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 13:32:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENXChqUI5okLRkOV5tOfXlGanMjLbMmcJKn/lkK4/A8fvu08upmlloL41j829yH6/o80AgJU9/I0nqF7YMM9EefI5B9BUD8tMN0pyR5jwDCL7fSGzmeda0gqkNYvV6NCAo0BUDninpNljcE/ivoKF1Un31E5gDDZO3hIEzGFf4D1DSXsgPmEc6RE8miYe/i7NABrric2Z727F36FfsIWemnLvqyobOxVepsyDt8SjUJjQErNomPYgXbr3gIr5g3OwsAF0ZwBSmWB1AfYQBV4x95YFmt2nD3LnmqIuOiXyFhKJJmI9Wq+exLK5nnY7vFdFIF+lm2U16lZ7gtwnykhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCaJIugpFZ1UYMGS/GTbzs6rT4PSLt2MhCLKIBltOQE=;
 b=dNSmnjkhIS0kWUt4uWvdtUODdIT2Fj4F7kWcs59OnEh5fl2lan4y2ox7ppyhNfkwiuzoeKqs1fcSHD28QctHGTxWdSqa6mkxNNJmXHCQTkqbHMA/SXf2BCQhs7x6jwjBg9V1obZsO0fK+8132zZLv3Qj0iONvBWW+HfLbiGww1grpajBGmI/0KaGJGGKYoBrjvj3SWsPB+GnZQ0a3x5ei5pkuZ7f9Sj3/m0o0w6krcQp4ElvONUuTYO8Jlwjp2dxaRJ2dSvpK9ce2L9a6L+QlNF0+ZIzmiVWYs9mnfFGOj79XCywbj2gTUh4vDszP152xABw6k9Hs0yVEHEi5GWPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by CO1PR11MB4817.namprd11.prod.outlook.com (2603:10b6:303:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 20:32:01 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 20:32:00 +0000
Message-ID: <eda6a7b5-8ac7-4602-ba4d-ab102e2a8005@intel.com>
Date: Wed, 26 Mar 2025 13:31:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Kamil Zaripov <zaripov-kamil@avride.ai>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
CC: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Linux Netdev List <netdev@vger.kernel.org>
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <8f128d86-a39c-4699-800a-67084671e853@intel.com>
 <CAGtf3iaO+Q=He7xyCCfzfPQDH_dHYYG1rHbpaUe-oBo90JBtjA@mail.gmail.com>
 <CACKFLinG2s5HVisa7YoWAZByty0AyCqO-gixAE8FSwVHKK8cjQ@mail.gmail.com>
 <CALs4sv1H=rS96Jq_4i=S0kL57uR6v-sEKbZcqm2VgY6UXbVeMA@mail.gmail.com>
 <9200948E-51F9-45A4-A04C-8AD0C749AD7B@avride.ai>
 <0316a190-6022-4656-bd5e-1a1f544efa2d@linux.dev>
 <CBBDA12F-05B4-4842-97BF-11B392AD21F1@avride.ai>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CBBDA12F-05B4-4842-97BF-11B392AD21F1@avride.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::48) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|CO1PR11MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb00810-7e05-4530-1053-08dd6ca54316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFo4bTByS0RscGJCNThSeitUdHlPRktqMHo0ZnR2Yk9IRW4yanpWYlFNdWdS?=
 =?utf-8?B?MllhdjdMdzlnQjd0bXB5WVhGUjBzcWl1UUVXT3JvRHRsVUpxYU1YZWtOQzYx?=
 =?utf-8?B?RCthUTl2WU9DZDJ0VHQyYWY5dUp1QzdqL3NiYTU0bUpaV0FZRW02VDVvOGFq?=
 =?utf-8?B?Z0xUTnBMbmxSQU16Rkw2K0lGMHpJVTZ5Q0ZtVDkzQVlvb0ZxWkdHb3lxNktT?=
 =?utf-8?B?NWpQNzVpQldXbDZsbVBVcU9OUnRiMGJpRmxUL2gwU3U4dXBucy91VzVXbTdv?=
 =?utf-8?B?Q2VUY0FpSlF3TUZtLzRXMHRoZzJvRE5hWm9qaVQvMjhPNGRtVkYyRGw5YmIy?=
 =?utf-8?B?Q1lGdmtNbHdVQWJWdnpNaDNUSWdRZW9VTmh1bFBLcCtLRU5RQkt4VHhVL1Vw?=
 =?utf-8?B?MjV6WHlVVmorTTIxZ1lROE5DT3pLb0lIV1dSZmJialZVeklFQnVzNjJrK1pH?=
 =?utf-8?B?bmoyblhMaEovMWhWL3l3NythSWZzeE16UXBQNmMxKzVTUEQ0UVdZMllpeHVF?=
 =?utf-8?B?eWJHclp5Z09NbDM4T2hZVUM0VFUxMnRlbDVYRnNXU0VlbGJpRUFoWlJWb3U5?=
 =?utf-8?B?YU9UVVdGRExUUGJvREIzV2VTY1pxNWRvbEhXQitHRVEwaWpxTitaUHJmNUJG?=
 =?utf-8?B?cTVJclpDaERDRE1Tc3BPTEJCZG8zOVQ2YnpvU3VTYnVhbmRvblkvSlAzcEhQ?=
 =?utf-8?B?TW1lWEkydEF1MFQ3UWQyM2RDTE92ZGx0WWNEZnVhM3pYUUVwaFBMSmhQUkg4?=
 =?utf-8?B?dDdmYWVOa3BNUGQ1U3B4SlFnRFlxUEZLU0RRTm5tREJ6VStjdjY1LzdJTDNK?=
 =?utf-8?B?QmFYMkozTWtHQzVKWlFzV29jU1ZtdHRrL0JlNWduZ3hPNndWdXc5NUdJbCtl?=
 =?utf-8?B?MlVhVUJXdThrSUo4NGZGZ2ZWYU5PVkFrVHlMTUxBdlNjWEpzbGkzeDdaSmhx?=
 =?utf-8?B?ZWk4K2gwbW4rRFpJWE85OVl5aHVYTSsvS2U5d1FkYnBvb0s0LzN5SE03NWxh?=
 =?utf-8?B?Y2RtN3RmbWd0ZjE5aGhFQTFMRjNERlphaVlQNlZ1L3pRZzNMVmt4SzZpYWxy?=
 =?utf-8?B?eDk5UXBrTUJXTGlCTk9OZTlxMXpIMWU4Zk9aclArNXl3ejJEYnU2QnRrdGlU?=
 =?utf-8?B?VWVadS9NY1RYaHRxd3U2dHFtSUtnVUFkVUs1Uks4UTQ1eVB6UGQ0V3V1dk14?=
 =?utf-8?B?K3dPRllIU25WN253R0pFNEMwZmRVZUxvS0dBMVF2R256MEZjSmV3aVVWVTNX?=
 =?utf-8?B?NWU4QmdxSXFnb0xKRm43ZkR2d1lZZ3d6aTROOThLemNEVm1RdjZJWjhCWUth?=
 =?utf-8?B?V0dVVzE0RERpK1NQNFAzbkFqM3EyTE9uTEQxT2tBalJreURLNGord1V3azU2?=
 =?utf-8?B?c0cyekNFQnZnc2dUbm5hSkp3YkhvQjFmREpxWEUveVpXb1VncHlWWTVIVjVU?=
 =?utf-8?B?NVhVRk83TnBlUVIzaG5JV2dtRWtYcG92Q2s5azBTT09hNmZUOElqdzNxVWp5?=
 =?utf-8?B?RGF5N01tcGthVzE4ZWlWT2QwRStXS1BBR1hMTUF6b2lKcEdGM2JPTEw2eWdX?=
 =?utf-8?B?Zjl3RzlFUkhuRmxxbTVIcVpRZWFVRXVhbWJLUVNPbm9iYllQNFd1SE5xVGlM?=
 =?utf-8?B?QnNJcXVzUks1Mlk5TFlDRElUcnFuOEM4djNabytDUjFkZTBHQXhKVnh3VjZN?=
 =?utf-8?B?NDUwTDlZdU8xcStJWGp4dW1EMFRkbXNjTEtsVDZGRmJwck13ZU41aENiQWUr?=
 =?utf-8?B?TE9QS2s3VU5oVjZMZVhUNUxuVFlQdUpNcEVzVkxaTE1xcm11ckVTVjJEbVNE?=
 =?utf-8?B?Qjdhc1ZRRzNEVFBUbGd6aHE3a0UrdjQwVnhzam9pQ1JHNVBSYkZSbXE3TFFN?=
 =?utf-8?Q?ZRng+q0Js/rcT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlV0U1RPU090ai9ad0xHR1JBRmlrR0xYekFSOUFwVE05RGs2aG5TQktteTJZ?=
 =?utf-8?B?OU5IRkNrMDlOaVlxQXpMUkFhUWgzOXpSSzBaT1ErRDQySGZ6eXYzUUp0MHAy?=
 =?utf-8?B?Uk5NV1lqQ2JhLzJEbFpqRHdTcUtldzlmbXV1dm9WZXlqTW1mMFBBc3o0cnpj?=
 =?utf-8?B?SDliQ2srU1RWVmlsQVBBWGZNZXVnT3QzL3hocllwMkxSRE02VE5VWGh0NWpP?=
 =?utf-8?B?RXh5WGlsSTZjYk5ySUE2emgySjRkUVVmQmZpbmhjN2dYYU5TaTBXb2tLRThr?=
 =?utf-8?B?ay9NOXQ3TUVCL3QwUFhjSXZYOUJETHphbDlyOVJ2VGZRWlVaU05SNGk5dDVT?=
 =?utf-8?B?dTRPM1ExdkxrRmQ0eDNIWFpSUkhSV0llN3BmSVBNVUppNXFrTzRKZzkvK0Rq?=
 =?utf-8?B?aVJQQ2lLRDNhSHRmMnN4RGMyeVFrZjZDenRNa0JjcVdwMVp2T2lPZndHcjNT?=
 =?utf-8?B?bkhVeVh2R2hsc3BpWjFubmFwa2R2UWxtRFcwZTFRYzl1RlRXdnJaVVBaQkwx?=
 =?utf-8?B?ZUR6VUpSMWp4Y2hWTjU0TTBCL2lKMFFSVFRiNFo2dzltSVZZSk9QOHc0TWtj?=
 =?utf-8?B?SC9kV3U2NnFtQjZKUHBMVkhNMUxjOXcwNkd3RlRZZElTeWhnU3gzcnJnT0ow?=
 =?utf-8?B?aEkwKzd2ZTJIdDdpRm1SZis0MHpzaUZvZm1QNndMZXV3ajFtbThqVTQvcWtz?=
 =?utf-8?B?Rk9CZmhCcnlKeTZOUUFrcm8wVVY0dFQ4STFrM1MyVFNielltMHhmK2NnZWMz?=
 =?utf-8?B?MzBUUlJYUklxQmN5TGJueWxKOEs5R2hqNkNCVkQ3bnBRL3N1SDlMRy9MK2tO?=
 =?utf-8?B?bFk3Z2FRSTduQmlaZ2JiTjFvUVRMOTNJaFhpNVlUaUhpeUlJU2MwdnV0dS90?=
 =?utf-8?B?U3dESEJWa2V6RU9EQWxRM2hDOEpMTExyRGpIUnlCZzlPUFZFZHRHSlhhbnc1?=
 =?utf-8?B?VHU0OU8wT2FLZTR2TzF3VWgrMUgvTGlQR09BKzZFR01zd2JvVCtvS0M5TGhs?=
 =?utf-8?B?ejU1K2M3RjNpcnQ3bTZnb0pZTVNqUXVZU3k3MDA4RDI3RHByYnR2NnZjMDJp?=
 =?utf-8?B?ZDZBMUFqZXBDOWFRYjdKZGhPUHg5UitVbmlCT0lBZ3V1dHdBTFAvT0RUK1lj?=
 =?utf-8?B?dmZ5ZFJlTWE2dE9BU0Y1Z1JSa3lYZUREUUZCSzVjUGU0VnMzN21VZnhmMW9R?=
 =?utf-8?B?Z0ViQ2NVVCtrWWx1c1hyNTZFQUdVZmh5TzZmTW9ENUp3WWFwcjhRS0s4a0Q4?=
 =?utf-8?B?dVVQekt1UUlQSjRsK0JGZUNnV2xHY0lnWElROFNETm5WR09OSnBTbjNTbWs4?=
 =?utf-8?B?eWVPenRnWDBRblcrNnJmRGhneElCTytkWXRiaU8xTHZsb01VSSs3L1ZWMlpw?=
 =?utf-8?B?NWlmajBrRmV4dTRaOVhRaFV1VlYwSm5DTFFUdWUrQTR6ZEpKaVNlZ2Z0U0pJ?=
 =?utf-8?B?aTlpbnNWbEdvTmpsaEs3TDRrcUlBL3doMEhXYUhaUUFKUXA3elJ4SFFJdThr?=
 =?utf-8?B?Zm8xQWhDc1NqOStKbitLb2MwMWx4Zk9HMERqSEFuSGUrRVFBVWw1Y2M4UkMv?=
 =?utf-8?B?SVE3SlgrWGNaVmdiU3VuNmx5NW5RZVp3NDduTldqV0wzZjYyd1dpb1FzNGVx?=
 =?utf-8?B?bUFMN25kY1FrWGNuSy9VS0NTU3dMMngwYmE1ZGZ2eFdPMi9tbEdIbGN4WVBn?=
 =?utf-8?B?WnNMOTNIazFpTmY2NFdXNG9GMDdYMTlxQ3R1dzlXLzdwVXRHemo2YzVVY0JC?=
 =?utf-8?B?RG44dXA1S0JTL0FEL2xScUM4YVo2UE80NFZ0a3duYUZ6b1ZHd2RVOGQ5dU05?=
 =?utf-8?B?ZlNGMmpDR0UvajhFaFJNVUl5cUJDWEpiWDFReWlobTdmYk5wbFVxODJzWGF4?=
 =?utf-8?B?V0gyK210NVY4VE5XUk9HSUVrOGxjREpuUGVGWi9IbDBpQlZ3aWhvdkRSdzJr?=
 =?utf-8?B?Y3lwaC9xZVF0eW9pNy9FcC9hYnRkNmhDS0xmMjZHVEFVbzRUQnBnZHhWUmdo?=
 =?utf-8?B?OXVyTllzSzIvZjhZdkpnQWxrd0pxZzJmY21PRTVkYzJvalo1REczM3B0V1oz?=
 =?utf-8?B?cjVyZjJTRVhUNUVHbWR5WEp6RFduT2QyM05ueVpEanFSV3ZQbUtGdVJzaE5l?=
 =?utf-8?B?eDVwRnJUZVlRWVAxTWJBanFseU1uS3pKUlFKbG92WmdFUzI4aUdhbE0xOWNQ?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb00810-7e05-4530-1053-08dd6ca54316
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 20:32:00.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXmnq/hAGTm3QdQ1l41+TG/1JO8fylXY3F1bvCnVPNjk1KWBtF1jc7yOM/hKgKjKOiJOyuutVgqbAYugQ8WHj4LMOGy+zlj3bVbMN49bn4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
X-OriginatorOrg: intel.com



On 3/26/2025 6:50 AM, Kamil Zaripov wrote:
> 
> 
>> On 25 Mar 2025, at 12:41, Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
>>
>> On 25/03/2025 10:13, Kamil Zaripov wrote:
>>>
>>> I guess I don’t understand how does it work. Am I right that if userspace program changes frequency of PHC devices 0,1,2,3 (one for each port present in NIC) driver will send PHC frequency change 4 times but firmware will drop 3 of these frequency change commands and will pick up only one? How can I understand which PHC will actually represent adjustable clock and which one is phony?
>>
>> It can be any of PHC devices, mostly the first to try to adjust will be used.
> 
> I believe that randomly selecting one of the PHC clock to control actual PHC in NIC and directing commands received on other clocks to the /dev/null is quite unexpected behavior for the userspace applications.
> 

At the very least this should somehow be predictable. Better would be
for software to manage this and report only one PHC to userspace, with
each netdev reporting the PHC associated via get_ts_info

