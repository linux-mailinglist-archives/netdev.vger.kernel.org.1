Return-Path: <netdev+bounces-139973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D2D9B4D67
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 281C5B24982
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED1F192B73;
	Tue, 29 Oct 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZm7C7Ea"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B510957
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215022; cv=fail; b=BTu4ElujqLPSAHCN2QOHpiGLn37F1a7S4FRHqe5rBCudWVB4JWTBbJKTEwdDjhjNh9PR2jIhmHaOr9Jwi56RUcQ982C+3OjZdAvRYeM1UDOZTaJcFSFsxnFjtTsKmXXGboKe1Yu/jWL+rqO9ZOiS0Kyi0ubn7Nh2Vos3qelTQy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215022; c=relaxed/simple;
	bh=+3ob5tpSypmsWL99wtTPDlbZ42fqnofBHXiJS+RQBpw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evdNupnaUxK3O7TASzLC7+x+INIyTPBMBPQijiy2AQIJ764NEY8Tadrk+zMYQzRYRN1YR0ezeQLqlzJ8FM/ixTKGYG/HStYyPhQNl+TcfnRTlnzHTLIYosRe40O6/s+v4SO/5aYBF7ao80Br0VFisP5rUYRm9FZkeITwQTx7IXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZm7C7Ea; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730215021; x=1761751021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+3ob5tpSypmsWL99wtTPDlbZ42fqnofBHXiJS+RQBpw=;
  b=CZm7C7Eawzd2+HjKQ41SCx3hB9Ga+WS3no3gSCNQ3kxGFiugPutBtA+g
   1maQsIIC+QtPbpUxXqP61YvDCDFF8g6P+63rKa+dCkQGqZeNyHsmR6ENu
   i4p/nXn8Jb3rlBZvjb3KKK7bbDStrI/uHlSnUlanwxKkAIKdQqueLH4pz
   1ZqjFb715IBfUZ2SEvQywhexA8p0PJmt/ICBpyFjIpipu3Z1dlOd/ckdh
   R5/Xp44Ym0po8jl2Osc15x5lDs3np2dxChHFV3bDnwH4ahhF53wwbKO5c
   1lqZg+/jQg1bdevWXNS1vUGXOhan0jwpJW/wnL0+hFHgUzm4TKvZ5QQ15
   w==;
X-CSE-ConnectionGUID: UFQnTvBKRhqQhGfGNRpTlA==
X-CSE-MsgGUID: CSDpdsoDQnyK+zLxXqIw/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="47344143"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="47344143"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:16:46 -0700
X-CSE-ConnectionGUID: tV9PRDIiRMi/mLUTE5Ikeg==
X-CSE-MsgGUID: QNRmRExkQXCrKvU300yddw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="86753326"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 08:16:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 08:16:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 08:16:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 08:16:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCjHThanUmm4yfmqyoxLvKMedKq1+BohJvM0aYD91caL8ZFmlSkVo1m7Ds8nunTLG6Gfiu0G81Wbe8SkOb/MFVZjV1ZRxuWKJ5qJgPXOVBSRRMlwSeNPxmdl7y5OtnSZwS1Xo6ZvcUKH1vHCkFF1LyYzHcoMXGtDsHGUd6l9Sllc3kEi64lxJF3eq4z25AmMTHJXQ/4hX0LzgzsIysoCKvp7vqaHR6z1RPxp0Z0Ex0Uh3Bi+TWIQzYmyrpU6LP6hAv49kkOhc8kY69uvO8iWW2C9mihUkGNVEPXwvbwajcQtq4DlZcn2B9CXk5DFbjUvgNO+Z6HglmiMMwmXXoKH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyeZEBFmvUtguHE728eh3yw3QoPvLk8DnJzo9g8mloE=;
 b=sBK5p7SADHm7PpG/3cuvfbFFWa0OB3W/62sbKqe61Y2UWDsdmCEblZSo+93trXRhkna7AeG7U5mR7D5H8AN9Dtj2JBHKFEurMI7cVh/N2MO84VLEChhsrCCupNLX2+cY096neHyyZd1/+5I5dQQ9BH/6vQcVrTFgb63dZxmvdgEanr4yjM3n1LTF46cc9p+0nzhvZwZirxyGyX4d2M5zt0E1UEIWlOdEfLHI2aNhw+Ery7Yfmnmp5kEI7k9AsoMWsDH2oVlwWvlLUcrP+dTmIH+LeD+uAabp++hcN9iHZifpU6NHP86mpXqtLjQS+59eMl5DrOVzf2KLqDV8V5rUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by IA0PR11MB7912.namprd11.prod.outlook.com (2603:10b6:208:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 15:16:40 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%6]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 15:16:40 +0000
Message-ID: <61611603-4dd0-4d75-a0b7-d21299d4610c@intel.com>
Date: Tue, 29 Oct 2024 16:15:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qed/qed_sriov: avoid null-ptr-deref
To: Chen Ridong <chenridong@huaweicloud.com>
CC: <manishc@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <wangweiyang2@huawei.com>
References: <20241025093135.1053121-1-chenridong@huaweicloud.com>
 <116b608e-1ef5-4cc8-95ac-a0a90a8f485f@intel.com>
 <43c68803-89c4-431f-b016-62a6ad68313f@huaweicloud.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <43c68803-89c4-431f-b016-62a6ad68313f@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::6) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|IA0PR11MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: aad8e2c2-1c72-4a8f-bbaf-08dcf82cb053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEJTUlF2V3l1NC9IMTdVKzZsV09JWXl4VW1IdStENVdMaHFVVlZENkJ4eG1N?=
 =?utf-8?B?YVkvRUdqMmlvTFJGRFo2eDlxeVlwcDJJL1JsWGZZb0gvdHdjWklZdmN5OHdR?=
 =?utf-8?B?UVh2M2ZPQVlYOFgzRmIzcGxnN0RGUzRGaktxQytwQlhzUGUwa05aTEV2OXlw?=
 =?utf-8?B?RFdHNCtnT3R4aVNiWkVFcE1zZ3hza25lM3FqVCtHYTFUR295Slh0bzgrWk9V?=
 =?utf-8?B?VnR6aG43N2NWNGpKTWQxYWxTekZYb1JpTFhwcGpjRGo0T0kzT3pjNXpiS3hn?=
 =?utf-8?B?YUpiNFEyUkM4UEo1bVJwUEZhazNlSksvdGxGdWxyS2hkMHlJd002NXlTWFNn?=
 =?utf-8?B?a2U2bzRIaDM3QzQyU3pSYlhodENZbWl0dDB0STk3Yyt0TE5zaTVDY0haZ205?=
 =?utf-8?B?UDBjYTFJK21NZlpyREQ5d0tZVENNRVNiZWlPVGF3bWx2M3dUOFM2TTdsVzBJ?=
 =?utf-8?B?VldWUXNMd0oyQzVvd25TZUk1MS9adE0wYkZhdjZLaVZRRDV4bVl0SjhwM0Y3?=
 =?utf-8?B?WXVva2J6T0IzQjhwQy9XTzBSSkV2YnVuVmp3RVNQWUl5VGptN1hudWlwVHBD?=
 =?utf-8?B?dFliSW9LVmt2elB1dUh1NXVNMnh3emZWU0ZNeXpBRUFuWU50RkU5S1l5SE5V?=
 =?utf-8?B?ZVMwWTluSmVxZEg3VWFBTVBSV2ZLWm0rTFgvNWx4WnozR2RXNXVPcTlyMDF5?=
 =?utf-8?B?Y3ZjYnJrUmI1SEY2b2FTYXhsZitkaHpLQ2ZXYXpabnh3TUdrNUhnQmNnWTVu?=
 =?utf-8?B?TjB5R2lOR1BxN0l3eXlHbk01bHhQaEs3MDFOaUthcThJMFZpVHVkRXcxTElX?=
 =?utf-8?B?NVJYV1VZZlZaa3JpT1JVSDZIemw2QlA5Rk5EMkhzS2Zib2N6M25KNW1EK2F3?=
 =?utf-8?B?SDRDRWl0WFpsTE5vSDdZeXIvaXlHQ3hDWlFMNmN6K2ZBdGEvWHBtRkR3YVcz?=
 =?utf-8?B?OXlueFVNQTdzUGFHV0RZbzduMXVnS29sdlRnd1BLODMxZWNMSjFtQ0hiMWNM?=
 =?utf-8?B?VGxhU3Q1STNzOVZKYkJRWkUvYnpCUG8xSENFY3ZRVU5EK3EzcmQ5d0RWYWpj?=
 =?utf-8?B?QjBTZ1drN25kL1FrMnIvUmt3emxxbzZ3NnNGWk9RVlRaYUNtTUhXNWFrSGpB?=
 =?utf-8?B?RnpOVVd5ZFpnUU10UjAyTEFsamRZU1ZCTmVBeDliVU5RWElaVzBFWEgyTnRm?=
 =?utf-8?B?cjNLeTZ5QVRaNnhUU3NQT05Pa1RrU1RRZmd1K2ExQ0tocnppU1JodnQ0LzVm?=
 =?utf-8?B?Rk1ua2dKMmE2dkRnaTFCeWVsdkZtelZCdG5QRzdMdFJac3VlaVc5ZXI5Q014?=
 =?utf-8?B?L2FINlYxN1RvR0xBR2ZBVHJxOWpHQ3h3cnYvcThLSVNPbmZoc3pSMGxNR3dk?=
 =?utf-8?B?QXh5SWN2cnh4UDNrRVlEUkk3Tk1SNGFBc05UWUFub3FtdlVzN3VINDl0ckVH?=
 =?utf-8?B?Y2N4S21tekRXaENNazdSZFBYOFdsNkhSZTBLNUxWYmRhcEtNMkU2dmpIdEV6?=
 =?utf-8?B?Y2ZUVFU4TWJuaVFWb2c0YTZOU2gzR0Y0VTJhVUZmV1IzUHBOVDRHdW4rRi9M?=
 =?utf-8?B?YiszWElmWTRpQVlnYVN1a1FzYVF3UUR6eTEvbWl3ZHFiZmpJMDk1aWQwV2ND?=
 =?utf-8?B?SWUyVEdNSGp3RU9zR2ZEZ0ozNy9TakpHejJabU1aUy9IM1NwdUJlZlJ1aG9z?=
 =?utf-8?B?NlQ1WEw5MHVBYThkcUFZdjBkOFBWZ3pCNzJqWHY4NFJTamVMNWV6Y01pZHNu?=
 =?utf-8?Q?NYBTVBYiZYpEX/BqRn18EyEjlAwdUNFFPgk0FWx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFZqT3lHT2xoTzI2OGpXUlBsMHFHd2RvSDgrcmhzL0V5ejREejJPdi9vMEkz?=
 =?utf-8?B?bzBQQTBiS0ZxVW9CNG1vL1BQZk82eEpKc2ZjNjN5NUNvNU1LS0ZleWErNHh0?=
 =?utf-8?B?V3FWbUU5UDJ6b2ZXM0tGTUVMWFBtemh4aTF2VTRIbTJaaWdOWXlaekp0Skhz?=
 =?utf-8?B?QzllMTZBRnJHTlVlUDlvc0M1QmJEMGt4R2N3c1d4dTByaFBCTGtFZVBJZFpv?=
 =?utf-8?B?cE5CdXNQWVhhR1dIVXM2Ly9NbXU0U0ZkTVJ5QnZNVW1uR0cyV3FpV2ZyVm1V?=
 =?utf-8?B?UUdHL0liNy9mVzM4T0tUVW9HSTZUY3NqTzVMQ296Wld5MUdoR1BIdWRVejln?=
 =?utf-8?B?WFNhTHNyaTJybnJsa3pFTUpQWUV0MlNUek10QTlpWnphSG9ES3YySWNaTTFh?=
 =?utf-8?B?bzdNOEFCTFdGSXpjWWpUYjNLVFNraHNvZmZUdDVwMjgrY2ZkTllXd2R0Y05I?=
 =?utf-8?B?S2FZeTM1RW5HeEVxL3N4VTMxV2FzejNycW5XenV3c0grNXowc2Jmenc0ZG9P?=
 =?utf-8?B?NExmcjRMc2JnSmtzdUNPdTJVMDZYc1JmcHdPOUhSanZMeFp2TExleWxZSXUx?=
 =?utf-8?B?eEhmMzhKeXNPUzM1a09wbWVMbnJqYlYzQkdGU2dzVW1xaUJkVS9VUHVnekZB?=
 =?utf-8?B?M05SZlNkR09FeHk4ZU1RR1FlZG1TMWd4d0R3WnFyQ1pCaHNBSjdDWTFkOFR0?=
 =?utf-8?B?VmNxTktNMllKaFhlVW5hazhEbjVsdDNXQys4NzZ5RG9PNnBvMkNBM0h2dXVV?=
 =?utf-8?B?TlU0Y3QrWlBrcjkzWUhqTDFWWXRKUXlvTXhabStzZ0UyL3NNNkNBcmMzdW1k?=
 =?utf-8?B?SHE4bHE2eWQrbzFBUExocEZJWnF2M1lPL0tUTjV0MldQbzZNMklWT0hDdWRp?=
 =?utf-8?B?ZGw1NlpQSWNTTi9oZk9XdEx1amg3cWhaMVNaL0pYb2I3a3dIYmY4bjVvVnNq?=
 =?utf-8?B?a3Y5OCthWitUQjhtQTFVZEhIV1FHWXJIS2tFQjYxSzZYOHlqUEwxeHNsbmo0?=
 =?utf-8?B?TFJPL2JMbUc2NlBoNU94bEgwTkN6bkt2UFIrWEVtUm9qZzZNWGNIU25wNUNK?=
 =?utf-8?B?c2VtODJuQjlGM2RQWWc3VENKZHk2NGxRVis0cHlPaWozaUFMWDZCQTZSbm5m?=
 =?utf-8?B?bGxHWjM2K2Zmcm4vd0pnUEJEaXNTRkZwVVMwVjd5dVFyYlh2NjRXWUFiMjZm?=
 =?utf-8?B?RWo0VUY2ZGdSZUJqZVhSUDZHZlc1anlOYWVxZDJsWExtTFA3TjMvbjErNkRM?=
 =?utf-8?B?TktqTEswem1aK1gzK09hU2l0SUdrakcrRngxbU1JN1ZiK0kxMExudEIvS2tu?=
 =?utf-8?B?S3F5RXdOam9hMmVwdEpvSGVmU0taaUlMZWowQ2daY1RReXZya1M2bDRYbjNB?=
 =?utf-8?B?YmJVY2xYdWN2Ry9pMWFibVZqYXJ2b1Y4Q2I2eEJmVHcyVHB0c0dxQ3V4VHE0?=
 =?utf-8?B?WnRReUNqNWxVTXlWSFRIY0dnRkN1MWlGckUzR3g5Z0xwdko2TVB6ZEsyYklm?=
 =?utf-8?B?bmVKRjY4SklHajFVeFlZT2V4TzFKSnFSbVBpYnpNaHM4ai81OS9iS3AvaEFv?=
 =?utf-8?B?dDhUNnJSMHlpUHJYenlramhyQi91K3haclowa2xLa25Eb1JNRkF5MDVVNHMx?=
 =?utf-8?B?OGEzRUlqWmNqM3RHR25CVHBBL25hRkdVN2g3ZkV6N1JQMEJFZURYakdldFlk?=
 =?utf-8?B?QWNTTGZ6U2N6MFl6WExSSHVYMGhETWdQK0lJaWlRRkxFcUVLbDF2V0l6c1Ux?=
 =?utf-8?B?RC93ejBhRFdUQzlOb0ZhQ21RTjBwUGhkai9GUkxQczNsVG42MDJPYnVabUho?=
 =?utf-8?B?NStxcDloYTU4SFd6Tk8zb09lUmRCVUVta3BCRlB5VTZyM2VGRUpYQ0pSSkZT?=
 =?utf-8?B?RFlpcWVXVmRZQTNITHNhZGpaZEFGcElCcUpWbWs4YjdweHZIcDdxU0xqcjNC?=
 =?utf-8?B?eDE2dm1TNzFjSVo2Q3ByVWNlajk0T0N4SzJoLzI2K1oxZlV5Zk5PaTd3WVQ5?=
 =?utf-8?B?djlHSGlNRG5UT29GYXVhZzRwdkpvemFuU3J3UUhRbWoxTEJsb213S0ZZMWFN?=
 =?utf-8?B?OW55S1lPTy9iYWtLZnRDcDBFOVQ5MlVRUFlQemxyZlhXT09QMmVMTHZ6OGI1?=
 =?utf-8?B?VmthZXIxZ3RCTnBEcGRraEozYXdvczA2bVNtb0Y1Y25RcElsRDllWUxKd2hH?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aad8e2c2-1c72-4a8f-bbaf-08dcf82cb053
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:16:40.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQBk2jzL+Ydum0nhdQr5BlYbOH0+WUFKjA+d9Xn0KWeHmMuby7lpYxJStGUToTa2gaw7dmd4V6biVV/96YZExUIjjiOMBgOR1fH0PaHOwS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7912
X-OriginatorOrg: intel.com

From: Chen Ridong <chenridong@huaweicloud.com>
Date: Tue, 29 Oct 2024 09:42:11 +0800

> 
> 
> On 2024/10/25 23:28, Alexander Lobakin wrote:
>> From: Chen Ridong <chenridong@huaweicloud.com>
>> Date: Fri, 25 Oct 2024 09:31:35 +0000
>>
>>> [PATCH] qed/qed_sriov: avoid null-ptr-deref
>>
>> Use the correct tree prefix, [PATCH net] in your case.
>>
> 
> Thanks, will update
> 
>>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Why do you commit from @huawei.com, but send from @huaweicloud.com?
>>
> The @huawei.com is the email I am actually using. But if I use it to
> send email, my patches may not appear in maintainers's inbox list. This
> won't be happened when I use 'huaweicloud.com' to send emails. So I am
> using 'huaweicloud.com' to communicate with community. However, I would
> like to maintain the same author identity.
> 
>>>
>>> The qed_iov_get_public_vf_info may return NULL, which may lead to
>>> null-ptr-deref. To avoid possible null-ptr-deref, check vf_info
>>
>> Do you have a repro for this or it's purely hypothetical?
>>
> 
> I read the code and found that calling qed_iov_get_public_vf_info
> without checking whether the 'vfid' is valid  may result in a null
> pointer, which may lead to a null pointer dereference.

If you want to submit a fix, you need to have a step-by-step manual how
to reproduce the bug you're fixing.

> 
>>> before accessing its member.
>>>
>>
>> Here you should have a "Fixes:" tag if you believe this is a fix.

Thanks,
Olek

