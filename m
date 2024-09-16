Return-Path: <netdev+bounces-128509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82067979F08
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D39284CA2
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F91537AC;
	Mon, 16 Sep 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgtlWpWn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B51514FB
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481628; cv=fail; b=ZvZUcFI6RDAuXiH11jwYH73SqA0kWE9MfLlfVSX5ZMuDjaFlKm3/CytdocKz8q6S3MbRfKu00ZheaFvm7+maHRE1CyYA2tq7ut0/GMobmzrXMHlajPmEiJ0s2SH+KxtTiF1UQjLCpBgbrfuH1S0lzfe7na71E3n0pdnZbFdxOR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481628; c=relaxed/simple;
	bh=JCs3/VgiErbS7B/7pk/NyG0rDLxrZrfA7QrCuGEl36A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=idr6riBTkYTFerTqZm8idCNJTKf/GccoLwmYPDHdnPUtXaeDRLdfXHn0oPY4GlwocvquPR3Ukjy0idRW/jdASyP0C/iPqDy6BK+g7GTUBuIt301toHXiIBMDqStHkns25qsx2BbA0f0irtf5avRRyuMLxHkQp3poz2uhJ3oIY7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgtlWpWn; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726481626; x=1758017626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JCs3/VgiErbS7B/7pk/NyG0rDLxrZrfA7QrCuGEl36A=;
  b=YgtlWpWn24+C7Nz0Ts5SdOA+321yKlVtXL0BtAKADizJMevjDrcsBgD6
   WuuOpf+tjrIL/S/pnJeIzm2SgnRF+PJBav8Z/efYMfoR1OoilnZ+7uECr
   wwXjis485mi5giott1i6ia/V9SNZwRq1dj2kZs8ZqYTJredkRD7I9YIZc
   /sZ7BiE5M1kl5XPobU8/1NkHjizKzDf/Qhz7LXdU+bk6sNlBI3SYQCm/A
   NYSpjEja/gR0pf9U7lVErT5pqvHGzlB4dldV235faquPf+YImPeEh+JgU
   7gjYeKwTLI3R3tZY2I4czVmxEoiVjbKrErqW0JtPw7soo8NWV14YUMHhD
   g==;
X-CSE-ConnectionGUID: QZ/UsPJOTGGZvCdRlRMCGg==
X-CSE-MsgGUID: +Muwn8lIQOaZeIYKIPnEKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="29049013"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="29049013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:13:44 -0700
X-CSE-ConnectionGUID: EBLUF1uwR0S7J7F/Ry5ePQ==
X-CSE-MsgGUID: PKSo4+iOTUuWHDN2fVbn7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="99508266"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 03:13:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 03:13:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 03:13:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 03:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qaJ8PFczWayPHDOnZjWspaXoHglXfZ1WYFxvnw+H/RNz9qBJppCn+y+dXy4bipxyUxGYUYl8cEjA2FmXUWUdUt0wgaqr+iHpXM+kwslLMwmu6Hd2vPLDI7AOMTLtuE+mBIx+YAluJmjQZSHlPexfzkAOOy+vPDhM3rumsY/3fgxLn4xXybuzCNmFG91HT6YtY5BHDUhZFFtZ8Vp0HS/xtVIrxA+KczHAqOhx7wuNx/+9RxX5ONR9fuD2ns/MavYZZJxuDwD07k/xFMiiF55qdYwWTe+GOeyE0jH8Mx3mQX6jXNQnHsDGqmD+QpHg/Puhp1yMBltvMvU7d7uRdBolGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oKfNlN0f51+wMQSWeUtqkhQbbLugT5El+Cl2OWs/M0=;
 b=A8Db8aWVpwBA1QnRW+uuW2Xk3cLY0RXhBb63XO7cowTbfkBww57y/LGwtRd1VFyiPX2AU97/4NxhmvEMeExFmuoDhlE92YpviWm6KVXLcgdzIIUPXb7YHSKI2utdjNh84vAKUpUXSyZqqVxiLYGnW8Atb3bsLvvWtRnBMRqkd3gSjgJV1qYOKWMd3F9TBi/f9a3XP6pHlUpANIsg+bKZLLRU0aVR5uCpogWsF76jkno+KHVOeGzA9rVSnjNkWxM7j0bGyo3vsewgNucgDOK6TQpRno9DpY41MUUnc+pNDjYTC5ZRbv6/OrtxFiX4m3pfm7BJCm4hPrXLC7DJteaPIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Mon, 16 Sep
 2024 10:13:41 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 10:13:40 +0000
Message-ID: <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
Date: Mon, 16 Sep 2024 12:13:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
CC: Alexandre Ferrieux <alexandre.ferrieux@orange.com>, <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 687b7c66-2662-43e5-7a89-08dcd6383cd0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejN3NkxYd2NaT3U2M1hyRVBrZXJqV214TnhtSVhxbkdHSnJhQ2JxQTZTbE5Q?=
 =?utf-8?B?K0l5b3N5R2krR3EwTHIvSnByeTFhSUg4UWlFVS8rQzBPdG0yNm1WODI2dE1W?=
 =?utf-8?B?d0ozdkdTbi80MFVmb2JsbDNGRHVFV1QrT3pMWHJ3dDVNZ0tBMkVJV1Yxc010?=
 =?utf-8?B?SXlCRmNYOVprSmk5L2hBMUtuS0dJV294dmx2K29NajhncmszaUR6alFMbCt4?=
 =?utf-8?B?THFMQ2E2WVRJQ2pCMHhLeEk1YVpLNVQ5QUZqUnNJUXdCUTFtaVZOLzZva2hG?=
 =?utf-8?B?bDROSGJ2M3g3QW9DRUVHeDJOWU9PbFcrbkF5aEFZSGc5Q1BkYlF4NmV2bnNp?=
 =?utf-8?B?amNlYm5paXFoalhTRHJDSnlUTTRkSlVmUjVoRTF4OTNleWZjOXFmK0FrMURY?=
 =?utf-8?B?SEh4RTNRSGdjQkZMQTV5UEk3OXJwK3BNaDRiK1gxQm0xTzRNWVAyYnR1TW5t?=
 =?utf-8?B?VGdWNkk1ZU1SbjlocUFIQmRGUy9TZmx0WWhLb1U2SzdMQjNzTWdqWGhMYUE3?=
 =?utf-8?B?REhycmdISlhsN3Zub2FvQnd6UlFQZXc0TFJ5aW92U0dKaVZub0hXM2YrWHhS?=
 =?utf-8?B?Q3pnWEROc295bERpenhjbkFvQ0QrVGpwWTlBSXE4eU5wOFYyZUFhZjJ0WmVQ?=
 =?utf-8?B?clI0OEhWY0EzcS9SblBsWjRZKzV2MEI1cm8zcWhaZk5jcnppSzhXQjJNQ1ZT?=
 =?utf-8?B?a0Jxbk1SZHdxRmhRYjBKNG9kaWM3aFcwdFJKY2VkVzVNUXBBZVdpRWdaaXZX?=
 =?utf-8?B?Yk83YUUrN0lzeGUvNVpmU0hPNGxBSFhXUHhhbGwrKzNIZkltWDZQcGFaMXRG?=
 =?utf-8?B?RkZzeDgxbjlpYjRMNmxGVk56aERqaXpyaEpFczFHWWRSVmtHQlZvMjdmak1j?=
 =?utf-8?B?Y3NMVlVuSE1iRitJcTNRZWJhNHNkaEg4Zld6Y3hCNkFvN0QyWFlKK0lacmp4?=
 =?utf-8?B?Y2xZS1BZdzhnM1BjUWlIaGdTRGN3VUpTY2QzQkpXSUt6cWJSNDhpSXl4M0hT?=
 =?utf-8?B?WGpNMEJtRlZNbzhKNDNlNUNqVWVLNTVTdGEvb0ZJQ20yYStlVTBpTENnNy9R?=
 =?utf-8?B?emNVMGRQV1hVblVUdWdNOWtwL2s2enE0Ums1UzF6cVNFVStuQmxGdCtXZm9m?=
 =?utf-8?B?YW5NZEZ4alB2WGFlT0lsUC9hUmREdkliNmtqZHJaVmNOeTBhZW91UWxDZEVZ?=
 =?utf-8?B?akVCRkUyaENYOFlQY01JMVZ5VG53ZDZFbDdXVkpqVnF0K2RQRkNtRDdVK0th?=
 =?utf-8?B?b0VDQ3Y1K0VHMC9MSzJZSkZoQW1JSVNCanJiQWE4WlNHa0VWTnc5ZTVTc2Ex?=
 =?utf-8?B?NDNlZzdxSlhVODcyMnFmaXF4QlVpUC9WUExQS2c0SG9sM1RmUjMxU0xqVVc2?=
 =?utf-8?B?MXZqdnZqdWx6blQ3WVg4eWpBVWg4ck1YS0RWc1R5VmZzbDNOSU00dmo0SUMy?=
 =?utf-8?B?VkxPQ0F6MzNLQlkwR2dSUTRyV09tWmhVSW9Ib0FqaTJPVXg1N1ZyNFhSYXR6?=
 =?utf-8?B?R1BYR2w4UmpaRGs4MU84K0dYYUNza1FsVUhNTTFwY0VlRktxWEZnT1lTbjYv?=
 =?utf-8?B?akVmTFMrSVpwNVlaTjJmWTEyYjFxYzhmWS9zSXZlYnY2N2pVUVRIVXpIeWVC?=
 =?utf-8?B?dXVPNEx5MFA0VVgvS3B1UnRNcHhXNXM0ZWJHNUhPVjJYd1gwdHBNY3JITldK?=
 =?utf-8?B?Y1hqZDB1bFY0am5qZnB3aEJkcTVrcEpSTS9TWE9VVm5XRGd6cTRZbTZMS2Ey?=
 =?utf-8?B?NEdPNGtERGZqTVk0U21ZNTFqbHFEb0IyUXRkVG9IbzBvT0VrUFoyK3B1S3V3?=
 =?utf-8?B?RVZxbFo1Qk8xVTRGYk9pZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9NOUxoNjhIdFFIZHI2akdCVXBJUUh6QkwvR1AxVjZUNllOYjlrSERkQ3BN?=
 =?utf-8?B?cVY2K0NxcTFXK1NrN1Y3NEhGS1owMy9VMzhyMU1VL0RuWTJvM0x6bHljUUdp?=
 =?utf-8?B?NVpoaVdjT1ZEK3ZtQktDNWpaU0FkRjBrblF5VUdqUWNoYzZLdmtyQnp1S2R5?=
 =?utf-8?B?MFNEM2tabmp6L0htK2lIOExwd3l4NGNUMHNtVWdQeFZhQ1BCajR1UlNoQ2pW?=
 =?utf-8?B?UWpWNW9XQUFRckx4UDRkZ1ZMN2JkcCtzUEt3ZnBJZ1FheDcvRVJnSmIrYU8w?=
 =?utf-8?B?S3NWWVBDZWxTQXV4Q0pYb2dTY0ZkNTBxRTBFYXZrYzRsOW14Q3A4dlpWaEFy?=
 =?utf-8?B?S1dtVHV4RGxJTUZDc0Z0bmhFVlZRZGJEQU5zQkZId3pzQTgrUDBJeXNGNjNQ?=
 =?utf-8?B?NjRZZmMxNkcwRk9EeURmWWJza0p4UW9MZVpaZEVHS2xObEpTd0t5Z0V3c3Fi?=
 =?utf-8?B?TXJrWEZ0eFF6ejJFd3lGUzlpZ0FxQmJTbHBlVys3enhhZ1A3R3lEUGtuUGtP?=
 =?utf-8?B?OXY3a3BNdWVLeVgxNlJFSUFWNVVveWpkeWtrenlDellham9VSnlHQmNpK1cz?=
 =?utf-8?B?ekIrNHBmZ0ExSjd2SXdiYTRYNEZ0K1liZ0VteTlEY2VSelJTcGhoYWRMeDZk?=
 =?utf-8?B?M3VzN0tVUk5BREFTR0REd2V2WXBwb0YxUVMxOHdYNTR5MlA2MkQ5TmNPOFZ5?=
 =?utf-8?B?T0FHWkV2a29JWjFyT2ltcnhERDM1eUpKMmM3M3pMSGdDOXhtNmh0SGJzUWpz?=
 =?utf-8?B?VVk3c2N5RWFvR3duaERQRm5WdTdpdTNxYU5PejUvVndNb3BXNXIrd0JCaXJP?=
 =?utf-8?B?a3ZyQkRtdTRTVVV2Qm9nR1JZS1NUbWw0R0xBQVlscndMNWgwemJKZTdqdGJ0?=
 =?utf-8?B?MEVaNDM3TGVCeU5OYTdZZkt3d2M3QXFYcXNqdkNFKzJBWnJJZm5ERDFGenU3?=
 =?utf-8?B?NFlCT0g0ZStiamF2eklMcVR1d1hVQm1wdTRwNkk1cFc2T2RlWGNTdkZnNngx?=
 =?utf-8?B?SEJiOGhzaTJxS1loOCs4UFZMZEVNa2dhaEtYcXVzTHJwK3ZBd2E0V1g5OCtN?=
 =?utf-8?B?dkxuMlBUYXlpaWZ2SVN0T2V2S2VWeWU5MU1kb1p0bWp3RjV3RG9salg5YWIz?=
 =?utf-8?B?bTlDTC9NVFhvVVhkeit2OWVSa05UTmltUVZqWkVIZVpxMmVyd2tQUlRtUHla?=
 =?utf-8?B?NmV3VUdkL2hZckR3WVNSV1VUcXBTR0w5ZHgrK1Nnc2RtdjVqekdQZXZHbzdu?=
 =?utf-8?B?S1RvMWF3Ry9DcFVaTVJzOVJCT2F0RU1QbnNlNWwyTCtGQmtDNUxwU0tiWElG?=
 =?utf-8?B?Z0R5bnVYMzJPTkZ5bzZxRXhnU2h4K3I2TXRCU0dtN1pnSGpoQnNlUVp5Zlli?=
 =?utf-8?B?Wm9NTVNRWVAzUXBaWFZ2dmYyclhxLzVyd1hPT011aG5GdnV0VlRuTHgwd3FS?=
 =?utf-8?B?UzIxc2NWZ0x3WkEwK2VaM3NsOC82dFp3MzZQV05BUTE2aXNDak5Bb1UzS0lW?=
 =?utf-8?B?K0NKc2d5NWhxc3FOS1piT09ZWEZWVUVEM3locURkMGRIRTZlNG0zWWQ0NWxz?=
 =?utf-8?B?dll1QTl0bjlYR21haDliTlBpM2cyNzRDVDdJVHVDMzRKRDhyTEIzdnErcnBm?=
 =?utf-8?B?bEJZQW1MVE01RjN5YUNwQlltYUwrRloyRVViY29ua0x1OFA4a2ZlQVVOWXZx?=
 =?utf-8?B?VVQyVGNYT1pMUjJQS1VUaXNhLzViOVhVUjJXVnI3ZDVWOW1uSVB6bFlqdUdp?=
 =?utf-8?B?VURQb1RWaGgzQ2NnUSt2UElYOFJ6QzJtd0lQdElWOG1NZnpUbG9CaGxQeDRV?=
 =?utf-8?B?TCtma2xzMUMwbkN6N1RYSzJqWjFwQnBrNmdWaXd6OUdPMjBMZ21FTHo2eHpH?=
 =?utf-8?B?eFFqUDVJOVBaZis3NStxanpxUis2cXN4WlhCTWJod3ltYW1lWlg4UGJ1NWQ1?=
 =?utf-8?B?SUZubVE2anRLVlJrdjBuWU9Qam1hS3hJRjFNT2pJSjV5RnViVWJnWElOaU5H?=
 =?utf-8?B?R0U5bzBCMGFWZjRnOXoyMjdXbmFDbzY3aEQ5TndXWkgvbGhSL3RDMko1MzVO?=
 =?utf-8?B?YjlmSWFJQXdXdWZ0dm5rOHFTYTRRcXpFa0k3Y09uZjhvRVNHenczeTNsUWRF?=
 =?utf-8?B?d3lxNEl0MHZ0NFE5R0tKa090dlF6b0NGYzg4MllyQkgvMGNMOGRZR1pXRTVl?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 687b7c66-2662-43e5-7a89-08dcd6383cd0
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 10:13:40.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M++i3Wo0gysp+2JxpvPWLofP8VpnOpPpNUXtghoOxBCOrA1hTrdcNb3VafxWEYkF+AJse9FQeZtzfnXt61cVHdk0fccZ0ARKx+dH/QNpzb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com

On 9/15/24 22:49, Alexandre Ferrieux wrote:
> (thanks Simon, reposting with another account to avoid the offending disclaimer)
> 
> Hi,
> 
> Currently, netns don't really scale beyond a few thousands, for
> mundane reasons (see below). But should they ? Is there, in the
> design, an assumption that tens of thousands of network namespaces are
> considered "unreasonable" ?
> 
> A typical use case for such ridiculous numbers is a tester for
> firewalls or carrier-grade NATs. In these, you typically want tens of
> thousands of tunnels, each of which is perfectly instantiated as an
> interface. And, to avoid an explosion in source routing rules, you
> want them in separate namespaces.
> 
> Now why don't they scale *today* ? For two independent, seemingly
> accidental, O(N) scans of the netns list.
> 
> 1. The "netdevice notifier" from the Wireless Extensions subsystem
> insists on scanning the whole list regardless of the nature of the
> change, nor wondering whether all these namespaces hold any wireless
> interface, nor even whether the system has _any_ wireless hardware...
> 
>          for_each_net(net) {
>                  while ((skb = skb_dequeue(&net->wext_nlevents)))
>                          rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
>                                      GFP_KERNEL);
>          }
> 
> 2. When moving an interface (eg an IPVLAN slave) to another netns,
> __dev_change_net_namespace() calls peernet2id_alloc() in order to get
> an ID for the target namespace. This again incurs a full scan of the
> netns list:
> 
>          int id = idr_for_each(&net->netns_ids, net_eq_idr, peer);

this piece is inside of __peernet2id(), which is called in for_each_net
loop, making it O(n^2):

  548│         for_each_net(tmp) {
  549│                 int id;
  550│
  551│                 spin_lock_bh(&tmp->nsid_lock);
  552│                 id = __peernet2id(tmp, net);

> 
> Note that, while IDR is very fast when going from ID to pointer, the
> reverse path is awfully slow... But why are IDs needed in the first
> place, instead of the simple netns pointers ?
> 
> Any insight on the (possibly very good) reasons those two apparent
> warts stand in the way of netns scaling up ?
> 
> -Alex
> 

I guess that the reason is more pragmatic, net namespaces are decade
older than xarray, thus list-based implementation.

