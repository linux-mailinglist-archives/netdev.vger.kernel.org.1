Return-Path: <netdev+bounces-299368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VvnaHEG+L2qMFgUAu9opvQ
	(envelope-from <netdev+bounces-299368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:56:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26465684C66
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:56:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=IjgP2mPp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299368-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299368-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ED673000B0E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EEB3BBFDC;
	Mon, 15 Jun 2026 08:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58737F01D
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:56:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513782; cv=fail; b=T1jPEg1EPur8zmxLJ5XHNVcQKUDO4HBDAYC/t921+r/e7UXS4VQ5vpeafRhQ7M2laIkpA0vhGKKMEx1AXsO4jkupBRQ2bNw1clvVsArhYXswjGpdh84cLwuZu28Y06GZw0F3fCNkY7dDCk1Dc8fND5+41pW/bUQ7pyDiFiSkqZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513782; c=relaxed/simple;
	bh=NwsVGBjNMmrAF6rVvW3FG+OTid0ZEcVKDXj3MpzkgjY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oixgu2ubREaVq3L1eqEUmsA27IYWZm98++np989fy2o2n0pKwWfBs4HF0t5fzAmtzqEwSHkRT6xmA0SNxdCfhdC5WF6B1qkEc+CEtgGqjF/u++4OR1GTEQgBVesJHAzHVTS0vQDl3VjloUvHu4uUbilYMdB1JRLlkipNzr2fiRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjgP2mPp; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781513780; x=1813049780;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NwsVGBjNMmrAF6rVvW3FG+OTid0ZEcVKDXj3MpzkgjY=;
  b=IjgP2mPpVMhx9pE0oNDE3mnVvgcmwMVaDlhlzoK54HTC/4tmh7jwrg1Y
   3nGQ3VQjJTXDckUIgVJqDS1MFd3Fncx3mRjzA7FBP+Oedu3pnTyzn8h82
   LrHWOnF6N+Utag5evmBMMbI6d4RuV7B1P9Zj84uZyZV/4n6K1KZ7nco28
   5RUU1ksbSZOEpfTv/KxcnC2XPHYnlUGwA939BDb2ey8qG2F/QiZb7VZTk
   tnRrvYJdnI1wtssAdoMy5rc72PcwLLsZpVHwEfnFh9W3x7u+l8KxnBDCi
   ++uGagbAB0UFG1YJICea6XIRDSla5108J9HEl7UUnRhjHbsNNh4CO0gg4
   Q==;
X-CSE-ConnectionGUID: J4b8AZA3Q+yG+XfFa/qoew==
X-CSE-MsgGUID: PMWm9afjQ1OWOxxPjBNQlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="86146945"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="86146945"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 01:56:19 -0700
X-CSE-ConnectionGUID: YTcIx3WrQtCVlMILa+oh+Q==
X-CSE-MsgGUID: Wdv5jHcqRnuVNSkxC0PXzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="249313728"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 01:56:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 01:56:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 01:56:18 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 01:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1AwvTBeLsE2FHhBhm8K7r+t9eQK66SwB0nX6CoEqXm/EiB/81k5jqlT2qOSxRmVS3qaR7+V8kYkmiXKG90+X7sanVjDjrPfhrbGM1D3lCxq7t/QZpAmxxdpPQ2uEftA3om+EIwyXrkakxFZU0flynk7EoZZ5lLA4eJ2ZF9bWERd1KyCa32q0ZUMOUdLsuQ1etf0oniYAwxMCTWhsNeMa2DNjfkkUQ1WGX5+Ug4P/cLxjj/IzJYfvfc+eKuIKcsBDKRe8GzJTvJcnhBBkUXu4mTYKMbdTVMTBqPsApFdLpY+gIAlIrPZq5iBJwwq/ldQQ7XNqm5kFcUrV7telbKBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp0gO6GiZxv6rbw0k3nDXzrV8H92oEE4QiysY/ZLh0A=;
 b=N7ISjhTFELe+FR8rFLnb8tvgq9ojrnPlqFBvzhMKMP3lJsgjYig0T+P0cvcAz1caRLW4DYolBOoFcK86owOPYUjB/2i2GmRNivX+kEwzo24i6ipTPe2bdzIIZLn52ZGEXs6IfVDdxq6UAKZRyn8jkeIscSTM5Kj7XrdlaHpAx3uBw11wVpffyof743PlPxoewk1J5lM6pI8CrNYX42LSL1d+mcXcvweAqGZTrrebgj0j/9UjdD9HBMePoXH2WstGxMnYmV0nzJbrmg9KrtxaNlOGYNf/LS1f6FU+p+WMF+SRZrVOiUeBUL9xrgAYRXzzGrO0jTZaskIPtUjopNk45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SA3PR11MB7416.namprd11.prod.outlook.com (2603:10b6:806:316::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:56:16 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:56:15 +0000
Message-ID: <57e1f3a9-14b7-4bec-8765-deb70fe6b636@intel.com>
Date: Mon, 15 Jun 2026 14:26:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/ras: Introduce error threshold
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dev@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<mallesh.koujalagi@intel.com>
References: <20260604184849.1011985-1-raag.jadav@intel.com>
 <20260604184849.1011985-2-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260604184849.1011985-2-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::10) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SA3PR11MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e67d91-ebfa-44eb-8c04-08decabbf561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|11063799006|56012099006|3023799007|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oTCn3ChMEAS6BQd7RaToYl64auakloP4Pihu02WYLc251tVtL526dJZJVD3aAA6k0m4CiqNWvil0KW35mqFGLzrvV8HkbxlYfJ+n9GTN1o0d36OOu4bzIC9Dqcq10F6XX/EjCZRhgycicoPS+svpUNzQDQ6fvqbm5ltwZ+b0qfSaKDnu49K/N/flHHAgYawXo2q7c5vxuBtoT80Kqf6gEoMNaRpgX1fnZq24XQDexJz35NnYEGGLcvYD86vEWcDux12ZYr+DH6/8z00i+1PAXamIOAiGz2VukfkuTd49E0Ye1/5JiPj1RgJGHCWIeBU24v49vf4rZqmFjl1mpsR3YMmFGe87W7mmTdjvLnoeKD5w2h98BFFpBEtao0tX8/zlDNlyG9KH08txSSShUo5W4YxfW9tI6O8ZtKOB/crG15Ep2hRCROLG4zKaBe2VSJCD+oB/tjvquTLnL6YdtFPNlvjaJClFxOGoT1/+Kqw24c/cr1LfC5EhK6cyreuybwwCBmCSRqOF76pP5PweYqGWqU7ErOLQEB6jSODWkaiWdON19TazQp4Je1YcCdBgEqtwaWIJQCvaBAf6iPb4Zy6NloMhlec75PQSvcV1K+Bn/3IeBbiihW5pjJvVOtCDZ6Iu1RVLfh2/25HBLBUZyZo3bYEK4J74daE7D52Q3GMlHQXiNYY5sG/UKEH6R7ZeLmTo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(11063799006)(56012099006)(3023799007)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1AvSnExYTRtcmVYTS9xRmpmU2ZxZkdWcUszekhrRCtLRUNkZ3pQOEFyQnJS?=
 =?utf-8?B?blVzN3F0aFZlYjQ4MzkxVHBmWHVic1Zybzh5cWYwOFp2Y1hFNUNIQXFBdURk?=
 =?utf-8?B?cGRTbjhiaW1IdGQxMFIyeGpmb24zTlVUQ1p3ck9UL0ZRTzdxYTNlWFliY3ZG?=
 =?utf-8?B?MmlIYVJMaTcrV2ZDK21HN01mRTBCa3ZnNDBoYnIvSE1oL0xBVHBGZ3l3QUt1?=
 =?utf-8?B?Rm9VRHEyZmtaKzhSL3Z4QmNzVTRHd2ZHQjVNRVFoYjhUVmdHblU3WDRUWFpY?=
 =?utf-8?B?TE56UVBzNzFXQ1YxTFpCWWJ6dDhXeDVGVjRnRVpQcTcwYUs5MThHdFFVVmZ4?=
 =?utf-8?B?MlVwYnJPS1VDb3E1aVlYTFdLeVRqckRuQlJaOVEzQmZUUTROd2dEVllWWE9E?=
 =?utf-8?B?N0xWdEVNc0xVOGplL214WkN6Unc1clpNZVBMcWFjd1lqWFA1b2c4L3EvU250?=
 =?utf-8?B?aFJWUEhvSjFHdW0raFdsTFhMaFJhNy9KeXRYTDNhVXVBMnpreUoydHk4UHIw?=
 =?utf-8?B?SUFJVDRhbTBlb2lSbDZLQ0FWZXMrM0N5QXovcGluMnJaeTJHR0ZLTC9td0py?=
 =?utf-8?B?MnFYakVTSERnRkNaYkZRWDlXZktFSnNhRjdZN2hHQW9ocnEvV2VISkw0bVVj?=
 =?utf-8?B?c3U0MUozQWRLbkVBWUt5QmxNUUhSZ0tuZU15S1RnUytwaEMzeTgvV3ZlQk84?=
 =?utf-8?B?Y1J5NHJHOVFPMCtabnRGNkMyWmswWmpTZ3FBWndONjN5Y3k2R296WTlZbnhu?=
 =?utf-8?B?dk9lMkdqTEhvcFM4bTVmYy9SS1VaTTBEQkt0QkNMYVdIZUtKaTJLTzBJMUxj?=
 =?utf-8?B?WHVoeHVtZGJYUjUxNFExb2Z2KytDdGhrSjBYZStTZnFaZWpSMDc4blgzSE1p?=
 =?utf-8?B?YVNHa0NRRU9kdkZWVEhTTVpnMzVETUtRSE5ITzN2NFhzOWt2U2lNa0NmSW51?=
 =?utf-8?B?Q1lZNDlyb3h4blIwaFVtem1iUzd0MVZHOW1Ua2ZwQisrbmczcndrb2ljclUz?=
 =?utf-8?B?UEJES3RQMU5IbTlrTGRMVXJnSFM3alJRWTljK09abHA5em5KazArS2RITDhY?=
 =?utf-8?B?UGVaVHU1UTZ3MWN5MjcxMTh0UXZNamFPTTR6dVVsbnc4dFhNODZMT0ZvaWls?=
 =?utf-8?B?US9xUWVtZDBlNFJIUkswYXV1bUxWWjl3eUZHYXluNEkzcFdJWjJSMkdlSlcv?=
 =?utf-8?B?VlNNc2Jpc2IrWUlNTEUxRzZIM29EUE81WTJsRWY1WEpIOWxrNzVGcktBeDY1?=
 =?utf-8?B?c1pmUVFQZkkvNk9PT1BSUUp3K3pKOE1UUmkrS3hMUll2UEZjd2s0RDVEeWY0?=
 =?utf-8?B?bWZKb2Q4T05OelYyUmVkb1AyUm1KcmxNekZUcnFsaHRmbnZhT25wTUNMWVJm?=
 =?utf-8?B?WWdiUW9vNzZjcW1ZNG9rUkczUXJ4NS9oUVAvaE1BbnpLZy9WMGdsbFhLZG9a?=
 =?utf-8?B?SmxWU25ySWlUeGxCVkR6NHc4NW42THhLVXhjVERYN3doSTVtbU0wYThGaHVK?=
 =?utf-8?B?Mnpzc0YrT1dzMmljYjJuQzBWZzlza2toZEtjT1dsbVJzUElYenVpQ0RaS3l3?=
 =?utf-8?B?eDZlckw1MWxtNDAvdmJUNjM2b0tVVXFrdWZmV1J4RFA5Q1lQMUVHQUhoV1pP?=
 =?utf-8?B?Z2swaENFM3dsOTlteitQUG02ak9aL0QxS0hJcHNDeFNNcjJEaUpjZ0tPQ09t?=
 =?utf-8?B?MUhVZnorb2ZSS2RyaUZ3VkJWa0JrSEpDK0QwM0tLbmoyWnpoWlQzbk1xRjZ4?=
 =?utf-8?B?a3BkRlFtYUFkUFJ0bGFTTFZBcUhEdFV3SENtMHU0b3ZsN3N6VFNiR3NiQkxC?=
 =?utf-8?B?WExRSVppaTUzR2VvTER0dlNWa1VGNHpWNDdvcUZQdWhlc1NRQ1ZDVHpZK01L?=
 =?utf-8?B?WGM2RFlja2RDYlVlVFJEYUZFbmtqZ3FQY1pNTUZsdWwrZVZQL0F3WTdibEY3?=
 =?utf-8?B?V3R5UUovVktCUnFXRVhBZGZrR2tmcjUyWUFCMWVjUXNLdC9pL0tqNDJGQTdq?=
 =?utf-8?B?UDVVUmN6Qk83d2lpWHNjZzlLb3hhcjNzUTFJZFp2NnJ2aTVGTnQwbnJUbDF0?=
 =?utf-8?B?RHlUZ2VRR2g0Ulh5dHF6YWRFa29kei9hOWFWcm1pWmhKNEFSMEdOcUFBZmox?=
 =?utf-8?B?U2F5YzZsZFBKNVVQRDJyNmVRclowcWRyV0VLcU9mamVqb0pRSG5EU0VKTUg4?=
 =?utf-8?B?OXczTTFyU1Y0NXIrUDloby9uZlpxTmMxR1pwNzdCb3NKN252OTgrUDRrc2lD?=
 =?utf-8?B?SUVoQ0dIVUsxZi8vbTBIb3NoSFIybi9lZVpqTTVDN24xTVBaVHdOR3dhNGM4?=
 =?utf-8?B?ZXNTU3kxZVpMdXFGSmM5RExSUVJkT0UxWVcwRjhZQktIWDZGc3lzdz09?=
X-Exchange-RoutingPolicyChecked: VwwPjK0mZgd4Y5+tul7dp/BM0/XjVtK98zXexw96P3SG8KhWjjUb016N9wpMKjl2vKHEeAy+eiWrtu8t8tPM3m6ho5ILeMR1Q9lR0Q5JY0KEf0aT2SXeQ/qwRi5kpBw3/AVmf+XmnfoBRp3iF05Sqo87vv5/arGsthHeISQ6NdsWvPZkoHCFt+FXp5AHXwQq3VoJtB041r4CUgBE3X/EEKU1FoKjrMLf/Nikz6CpmD8fGHr3KrgtLu0aJ83IlNhSfLQukBn+CoWQpCgcIceX+v6R0gTRFh/cMZc75ivwLgSr21xFwLy/ps9Y35jzRQZnffL+cyba1ey/DcXF5fl1QQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e67d91-ebfa-44eb-8c04-08decabbf561
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:56:15.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsqPPCZ+6cBA95RQhUtueIArfRf8xEQGL9TBL3rTmU+fZA3N8Opkyavbxg33u65+OsLnxZnwVvroopKijmgWVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7416
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299368-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:raag.jadav@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26465684C66


On 05-06-2026 00:16, Raag Jadav wrote:
> Add get-error-threshold and set-error-threshold command support which
> allows querying/setting error threshold of the counter. Threshold in RAS
> context means the number of errors the hardware is expected to accumulate
> before it raises them to software. This is to have a fine grained control
> over error notifications that are raised by the hardware.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> v2: Document threshold definition (Riana)
>      Return -EOPNOTSUPP on threshold callbacks absence (Riana)
>      Cancel and free genlmsg on failure (Riana)
>      Document threshold bounds checking responsibility (Riana)
> v3: Move documentation from yaml to rst file (Riana)
>      s/value/threshold (Riana)
>      Use goto for error handling (Riana)
> ---
>   Documentation/gpu/drm-ras.rst            |  18 +++
>   Documentation/netlink/specs/drm_ras.yaml |  32 +++++
>   drivers/gpu/drm/drm_ras.c                | 167 +++++++++++++++++++++++
>   drivers/gpu/drm/drm_ras_nl.c             |  27 ++++
>   drivers/gpu/drm/drm_ras_nl.h             |   4 +
>   include/drm/drm_ras.h                    |  29 ++++
>   include/uapi/drm/drm_ras.h               |   3 +
>   7 files changed, 280 insertions(+)
>
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 4636e68f5678..178797819d30 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -54,6 +54,10 @@ User space tools can:
>     ``node-id`` and ``error-id`` as parameters.
>   * Clear specific error counters with the ``clear-error-counter`` command, using both
>     ``node-id`` and ``error-id`` as parameters.
> +* Query specific error counter threshold with the ``get-error-threshold`` command, using both
> +  ``node-id`` and ``error-id`` as parameters.
> +* Set specific error counter threshold with the ``set-error-threshold`` command, using
> +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
>   
>   YAML-based Interface
>   --------------------
> @@ -109,3 +113,17 @@ Example: Clear an error counter for a given node
>   
>       sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>       None
> +
> +Example: Query error threshold of a given counter
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> +
> +Example: Set error threshold of a given counter
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
> +    None
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index e113056f8c01..9cf7f9cde242 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -69,6 +69,10 @@ attribute-sets:
>           name: error-value
>           type: u32
>           doc: Current value of the requested error counter.
> +      -
> +        name: error-threshold
> +        type: u32
> +        doc: Error threshold of the counter.
>   
>   operations:
>     list:
> @@ -124,3 +128,31 @@ operations:
>         do:
>           request:
>             attributes: *id-attrs
> +    -
> +      name: get-error-threshold
> +      doc: >-
> +           Retrieve error threshold of a given counter.
> +           The response includes the id, the name, and current threshold
> +           of the counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes: *id-attrs
> +        reply:
> +          attributes:
> +            - error-id
> +            - error-name
> +            - error-threshold
> +    -
> +      name: set-error-threshold
> +      doc: >-
> +           Set error threshold of a given counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
> +            - error-threshold
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 467a169026fc..bcb6e0ef2d67 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -41,6 +41,13 @@
>    *    Userspace must provide Node ID, Error ID.
>    *    Clears specific error counter of a node if supported.
>    *
> + * 4. GET_ERROR_THRESHOLD: Query error threshold of a given counter.
> + *    Userspace must provide Node ID and Error ID.
> + *    Returns the error threshold of a specific counter.
> + *
> + * 5. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
> + *    Userspace must provide Node ID, Error ID and threshold to be set.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -61,6 +68,13 @@
>    *     + The error counters in the driver doesn't need to be contiguous, but the
>    *       driver must return -ENOENT to the query_error_counter as an indication
>    *       that the ID should be skipped and not listed in the netlink API.
> + *     + The driver can optionally implement query_error_threshold() and
> + *       set_error_threshold() callbacks to facilitate getting/setting error
> + *       threshold of the counter. Threshold in RAS context means the number of
> + *       errors the hardware is expected to accumulate before it raises them to
> + *       software. This is to have a fine grained control over error notifications
> + *       that are raised by the hardware.
> + *     + The driver is responsible for error threshold bounds checking.

Can the threshold be set to 0? What should the behaviour be?

>    *
>    * Netlink handlers:
>    *
> @@ -72,6 +86,10 @@
>    *   operation, fetching a counter value from a specific node.
>    * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
>    *   operation, clearing a counter value from a specific node.
> + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> + *   operation, fetching the error threshold of a specific counter.
> + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> + *   operation, setting the error threshold of a specific counter.
>    */
>   
>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -168,6 +186,43 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
>   	return node->query_error_counter(node, error_id, name, value);
>   }
>   
> +static int get_node_error_threshold(u32 node_id, u32 error_id,
> +				    const char **name, u32 *threshold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->query_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first ||
> +	    error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->query_error_threshold(node, error_id, name, threshold);
> +}
> +
> +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->set_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first ||
> +	    error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->set_error_threshold(node, error_id, threshold);
> +}
> +
>   static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>   			   const char *error_name, u32 value)
>   {
> @@ -186,6 +241,24 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>   			   value);
>   }
>   
> +static int msg_reply_threshold(struct sk_buff *msg, u32 error_id,
> +			       const char *error_name, u32 threshold)
> +{
> +	int ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
> +			     error_name);
> +	if (ret)
> +		return ret;

can be in a single line

> +
> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> +			   threshold);

same

> +}
> +
>   static int doit_reply_value(struct genl_info *info, u32 node_id,
>   			    u32 error_id)
>   {
> @@ -225,6 +298,45 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>   	return ret;
>   }
>   
> +static int doit_reply_threshold(struct genl_info *info, u32 node_id,
> +				u32 error_id)
> +{
> +	const char *error_name;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 threshold;
> +	int ret;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		ret = -EMSGSIZE;
> +		goto free_msg;
> +	}
> +
> +	ret = get_node_error_threshold(node_id, error_id,
> +				       &error_name, &threshold);

same

Thanks
Riana

> +	if (ret)
> +		goto cancel_msg;
> +
> +	ret = msg_reply_threshold(msg, error_id, error_name, threshold);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +
>   /**
>    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>    * @skb: Netlink message buffer
> @@ -358,6 +470,61 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   	return node->clear_error_counter(node, error_id);
>   }
>   
> +/**
> + * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID and Error ID from the netlink attributes and retrieves
> + * the error threshold of the corresponding counter. Sends the result back to
> + * the requesting user via the standard Genl reply.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info)
> +{
> +	u32 node_id, error_id;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +
> +	return doit_reply_threshold(info, node_id, error_id);
> +}
> +
> +/**
> + * drm_ras_nl_set_error_threshold_doit() - Set error threshold of a counter
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID, Error ID and threshold from the netlink attributes and
> + * sets the error threshold of the corresponding counter.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info)
> +{
> +	u32 node_id, error_id, threshold;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> +
> +	return set_node_error_threshold(node_id, error_id, threshold);
> +}
> +
>   /**
>    * drm_ras_node_register() - Register a new RAS node
>    * @node: Node structure to register
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index dea1c1b2494e..02e8e5054d05 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -28,6 +28,19 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
>   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>   };
>   
> +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +};
> +
> +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> +};
> +
>   /* Ops table for drm_ras */
>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	{
> @@ -56,6 +69,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_get_error_threshold_doit,
> +		.policy		= drm_ras_get_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_set_error_threshold_doit,
> +		.policy		= drm_ras_set_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>   };
>   
>   struct genl_family drm_ras_nl_family __ro_after_init = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index a398643572a5..57b1e647d833 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   					struct netlink_callback *cb);
>   int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   					struct genl_info *info);
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
>   
>   extern struct genl_family drm_ras_nl_family;
>   
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index f2a787bc4f64..9cda4bbc9749 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -69,6 +69,35 @@ struct drm_ras_node {
>   	 */
>   	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
>   
> +	/**
> +	 * @query_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to query error threshold of a
> +	 * specific counter.
> +	 *
> +	 * Driver should expect query_error_threshold() to be called with
> +	 * error_id from `error_counter_range.first` to
> +	 * `error_counter_range.last`.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
> +				     const char **name, u32 *threshold);
> +	/**
> +	 * @set_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to set error threshold of a specific
> +	 * counter.
> +	 *
> +	 * Driver should expect set_error_threshold() to be called with error_id
> +	 * from `error_counter_range.first` to `error_counter_range.last`.
> +	 * Driver is responsible for error threshold bounds checking.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id,
> +				   u32 threshold);
> +
>   	/** @priv: Driver private data */
>   	void *priv;
>   };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 218a3ee86805..27c68956495f 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -33,6 +33,7 @@ enum {
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
> +	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>   
>   	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> @@ -42,6 +43,8 @@ enum {
>   	DRM_RAS_CMD_LIST_NODES = 1,
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>   	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

