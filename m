Return-Path: <netdev+bounces-289866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMmYCZiEDWoTygUAu9opvQ
	(envelope-from <netdev+bounces-289866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:53:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4216D58B23F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCAF53047EAA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933643D16EC;
	Wed, 20 May 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9CPWfNU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940F3D16F9
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270723; cv=fail; b=YyOBkpFHljq4HR9FrgCRLPfloEba311OSM41tGG1hXWD9XL7gzlJR8Cfu0yUzvAWnzDZc/ZmOI031xhYl1TAhJJ1DMNCqcdaBJ5mDPe3hlRyjlxIBKA0JU2tB4G8BubK1c2CcMDQhbFOpgExJV43k+nVfM/hTVz4rvEYP0nrqmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270723; c=relaxed/simple;
	bh=+AdlEkOfFhO1RrNiuo78/KgU4H13S9YvQKifuMQZebM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SWXtatuWPS0I5uGfrbdH7CoNmKtMhYiv7Oh7uPl/1k586cRGxSdumkcoupEfFDGNn3Gd1NqMfTWKhlA87cRjgyfOgLQhN3e3WyV9pQyK48kbPOJ4LKyVD0GNFNV6HXxOMSnkALMQ3g5IIKl6oZIALsmTpfFlw+BErjBxvRBQuM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9CPWfNU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779270722; x=1810806722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+AdlEkOfFhO1RrNiuo78/KgU4H13S9YvQKifuMQZebM=;
  b=X9CPWfNUGx0fFTn0Gaa5ul/DHRRzqlVvi6wKKImzqm7ybQMo3EVZLC2A
   frWZ1hl2ocT161xEOSLmHgi1hymCs6aBVIGNrEWjGJdQP6NGp/Dbyb8Pm
   lFoeMEEf6BNypbqfUsg1jkRM8uPLUCFKgJuS3sSnYbHa4dgFd2hzzfmDk
   4rx3BayTaoYomVTtH+BRPj/+Gl6SGhHvZf218lzGKochiqYARUOlqV2Yd
   kFUVBcajAP9uMzg2CJKwTXuI6X1tBLcjzK4JD1H8YtXKFhArA/ff9W1uI
   9jmmMnjv9q9ybUeDzeHDrr/4mcf6TYA0hW2LcBg1tjMVHFTKyL0HsPY55
   Q==;
X-CSE-ConnectionGUID: vtnH9VaoSlemrZY0AbDM+Q==
X-CSE-MsgGUID: lKG5lfl8SDSGlGBiM3j0jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90462112"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="90462112"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 02:52:02 -0700
X-CSE-ConnectionGUID: FoIPoZzkR7W5tVnEXUSnLw==
X-CSE-MsgGUID: hjwLSkdPSEaOt2Gn2ZdrFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="241928112"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 02:52:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 02:52:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 02:52:00 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 02:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaMFlqlE6yqbKJy7FPKD+vUH4o0xzUMH58FY9hItQRqXaVJOGe48Vcb1050zeLZLPKb50HgvbnAS33Dgo0vpMxve8UgS0+CoYkSCOP2W77a0ZujUbs8ni2UIGRBUKraVW1ZbcmotSUGFnd0VpWDVIbkNBd6mO4b0CtBNE0nQi6ENjYZ9zmGgBqPWiFbccKQ8a4wWj0a6ORCANy5aBNQ48xCkwxk3H4H3tBBmUZDEgtlMq+9GOvxOHEw0uhqNLolkIHDvn80uOx3Le59pk19K/6X2uwymyiSKo8VwW11eTCWd1+VTV9Hm9C3KVSJLte6mO/jtZZo1xyBGtaNn/bnMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii4pDwzkFXnVWewUqBnrMnf0MTDTMidfZRg2kZM8dBs=;
 b=itWfM6BznHV5jZT3CJk8cD3eBlSPNBa/F4eRaHR/5PcvMhQUgEpBqW66FHzem/SVKKgPpNaZ0eDGF1iYq3LYNuVhfILEILQ4aw1Ad19G1sg+L/D22Ozduhxn0YmqKTfm4yUar6e88F1cjLduhjfm3BW2KthkcHM1odKsYmwG28WBl4b+ck4UQMXsC0sJwPnDYWKLBcRxluof+yFa/9VZix+WDiwwR9oC0eBvqryPVz2+hFeU5B+VlBS5SZVTiC+tIJkSMeKtuXzQ+y/YTbGK8b5jq4PZ12U+kdvOqkroBWKjPXLrFKxbk/nBj/gf9JDPedBGJ3UEUPnX4qKH3nmYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:51:58 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:51:58 +0000
Message-ID: <ef067007-b928-4130-8e25-1c4f5afb5833@intel.com>
Date: Wed, 20 May 2026 15:21:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] drm/xe/drm_ras: Make counter allocation drm
 managed
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <rodrigo.vivi@intel.com>, <maarten@lankhorst.se>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <kuba@kernel.org>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
 <20260514202839.1888688-3-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260514202839.1888688-3-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0242.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::9) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SJ0PR11MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: e2009b65-a13f-415e-4902-08deb6556ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: wUnnkVUd6+auz66BZA4a2W+ThKKGL4v6Kg0mCqzDBXq1HW218nMGFoEGIWg87uqr5x9J/ByNZ2yZucQcbYdvZpySsjLv5+cpHFJV56Sqd8OVyiZFQRaQdRD74tkRjTgsrRYSp3n9ahdJCeQbNVAR01gASLD+PyW2rEUwhqXQm7pTnsYEEmnODsMG41i+jt5zvKXuLLTzWkEmG+yvoolu+l5a7+SI03CA7MGoKRII31a0HDwqjPQILlN/raKb5cYvjU4vhtkoq0Sx3HrKimJgq0GG12nIWJt+zUbtX4l2RZXFrr0ZCYGuaw4AYLbYMEctUSta0ItcwUy7MlI/sehXuSygFVUMZQ114CeaA37Uko5ZF0lr0TO/9IAv122d9To1HD+EtAJldA5c6D3PQ7+4v2l0S7e0FRRN+E4r68iIvbDfuQNHNdEnokgjEoBZttMm7hn/+36+RP3uHWkyjwvwsVFSqokeJmTZIoA0l+OOacCtbmxdIeCVGjSJINCkKagerj1rgwhzoiedK5CriFgPJV7fJEfvJS8vTqFOgcECqrME9ok9qYEE2PKXQ14TF7Ebsrjg3lQ8rF6UkqKF7aIhB7xIs+4dKOmcf6zuS6Pf0gXG5vjMB688d3w3QW3Vkrw3G0ZX0AhT2ofOvCTOC6TgNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBvdVhlVXVLSEdma2hEcHU4ZkhEYk5GY09GT1BCSHBMMDc2dkdtaGsxZm4y?=
 =?utf-8?B?Y0toTU9rdTJNSFIzY3g2SCtsSzdwL0c0V09NaGkwRFVDNDJBTlNFSUN1cGlu?=
 =?utf-8?B?QkxOQjU3T01CUFIrTVRPVkNRQ0UzSWRVRnNNcC9pZDJ4V3lPUUkxa0I0RUhO?=
 =?utf-8?B?YUNYOW8va0V4dFA5Ly8yQ0xzZFZOanNZbHVTQ2NvM2dJWHIzQmM0MGpGVUFm?=
 =?utf-8?B?TmRhYzNuT2ZrbEpYUVRIQTRrK2tpeEptbnFVR0ozSE5RM0l1bmpSZXlFNWFZ?=
 =?utf-8?B?YmJoNWRiWmZsMmQxUE8veEYzWWE5eXRKQ0x1bDFlMHk4aXd4ajdNSUd1eUR3?=
 =?utf-8?B?d0Iwc242L2thZXRob2pHZWMxbWRIa0s5MDJJVkZUbjJUVkk0WithY2JYUzRD?=
 =?utf-8?B?cXZFMDBOZlRFM0RRa2ZaR2Zzb29zdk5Bang1bFVaZlpMUVlROFhiLzZCd21G?=
 =?utf-8?B?Q2RQR0xCTEZ5UTNPYSs4MmpNZlRSQ0dMdFd0aTV0MEVBMkpTMys0RGRDbDRZ?=
 =?utf-8?B?WVFQbENNRU5hQUd5bnZhTXBQQWpOaDIwMTJ4QWd5bXhmanRIbzJsUnRvK3Bo?=
 =?utf-8?B?T2JsbnBLeU5JVTNLRVp1OWlCY21UalVMVFJ4bGZIaFd1bDEvbEV5WVprQWht?=
 =?utf-8?B?RkRPRnZXeGh4d0haU2Q5NytzUjJRcU1NRmx0VEJocjFteTRGOXkrVmM0NGhE?=
 =?utf-8?B?b2NWK1I2VkZ4Nis3TzRBc0Q2c3ZsZU8yaWwrK25VSkpQYTFvb2RndktieGND?=
 =?utf-8?B?OWNtdDNFSndXMnRxTHFZQlpURXQ5c0RIeVVkNlJGNnlZTUlzUkgrOEpaQUZp?=
 =?utf-8?B?MjZSY1JXb3JFc0huSnZKczc2YmtTT2RWcERBZFp6aDFFT0p4aGlOR3ZwQ2xY?=
 =?utf-8?B?YW9lbHF1M041eng3Q2xNb2tHemtBc3U3NitJdDUxVkdjWDZNMFJNVXdMTDJh?=
 =?utf-8?B?WGRHMkFtaGorUUd5V21vUEZ4aWg1M1o0UllPdXhUaWpnRHdZTEJ3R3Myamwz?=
 =?utf-8?B?OVVJT2d3M3FTdE9wWGR3UWpKOVBIUCtUZ0pwT1I2RHA1R3MyNXhGamdZR3Fh?=
 =?utf-8?B?a1B2WkpUMXY0US90amo5MHh3OStUTXY1a1ZMdEovUU9TSHVRZDJMWjk1dCs4?=
 =?utf-8?B?TzlrVE9zcFJkd1phZklMUmdWM2xjUk81YlpTUlAxQnBlR0QwM1RJUHNML085?=
 =?utf-8?B?SXFKMGs1dVJtdm9LUzFsQ1cvbjZxSEo4SXFpSEUybjNmc21iemQrWnNIQmRF?=
 =?utf-8?B?UzFwZnFKSmwxTis4TTdTTklkak5iSmEwenF1cksrQnQ3REZ2R0FjV29xcWpr?=
 =?utf-8?B?SkoxVkRkc3hkd09td0lEVE5jaWRxSWhqWGdSVFJKYUtEdTZlUUc1ck82MW5v?=
 =?utf-8?B?VnBLSmdhQm52L0VDUExFbVkxcDBFREtxMURWejJ6YlFhelhqbE1wV0tGaHBB?=
 =?utf-8?B?ZHlQcTVaeE83SFBIczh3UEdxY0Z2VE5MbEhsMUZLdFJJZzE2SjZYNjRrSzR2?=
 =?utf-8?B?eVpPdzBQRmdpeUhleFpmR2ZhMzdRZ2lBMVhhWFlOMnhhL3Z0VnQrWGFjTlF1?=
 =?utf-8?B?NTdUOE1BNEszajlQVEFXYm1kN2h5QmFBNUZ1TmdOQzMzeGNSdW5XSEgrT1Bt?=
 =?utf-8?B?ZlRENjd1K2Z4Z3FwRjN5enlPNVNWeFJpb1c2YmpuSElQMXpJR3Y1VytaUjVy?=
 =?utf-8?B?dWhSdStERCtGWW5mQlVKRzIzaythb0U4WFNOb2ZpUVhnZmpVM0VuRDI0RTdq?=
 =?utf-8?B?QnVIRmR1SUluamY2elNEalcwa3laWk9GTk1HbVRvdWFMU3VZT0l0OVNlQitI?=
 =?utf-8?B?bjJpMTUxRzlBRzlsbHFDa0dBTXdBZGpTR2lDNnhPRm5mQ2V1SDNiSGFkZ0Iz?=
 =?utf-8?B?NHJ1amJkVnRKN0dOb2ZVblM2clBQakpEZjNFTWxyKzBsTUEwUGZyb2Ftb1FQ?=
 =?utf-8?B?M1JiSkpnckY4ZmFmMEdia1RYcWRjUnFaMVBJbTBzaHJ1c1laRWFSb2FxMlhh?=
 =?utf-8?B?KzgzMzFFSktHTjBZclJiYkNqcmsxSTVzVXhScU1ORnBDU040eVFuejBQQ2c0?=
 =?utf-8?B?RDQ4L0wzTDVtcDcvSW4xWjdqZFdLT2lUN210ZVJLakxGcVR0U2Fla3Z6eThJ?=
 =?utf-8?B?RFB6cVRESzVmTHVVNUR6Nzkzbk1QYmxGcjM4SEdLaUVVc1BQVjQ1OGJRYzIv?=
 =?utf-8?B?dEI2dHBUQks2RkNyQ2NDWFpHS0Jkc0loRStNc2tzYlZKc0F3WlIycitBSEwy?=
 =?utf-8?B?T2h2ZnFFajlJcDZwV3luRFdSSnErTFVPRS8yQjJQSTVzVlJXTDkwRU5MTE9q?=
 =?utf-8?B?VDNrQXk0b2VsaEpHK2FOZldycWhIMnFJWVdKTEw4REorUFF4NHJSdz09?=
X-Exchange-RoutingPolicyChecked: HJ+ke+5kmvHZtGpP/uNwgjRBA0GimZqSIRFAuxZcCow04xcXIhwT6CTD6jzw3atNYp9Ac/Zn3E29OCY6op2pgNEsCTDWMrUUZWWBy9Lk+EH7FK0i2whSiyi1rTsKw47qMpAiuAbglM6zrYpGyYaEEoqycQnzdvSBTyDJCt8ukRVd/ltc4mFSrDWN2WP2Ryi/M2ruLLBcW3mS5Z969QKsfaUAEcrv1miQBHunOmb/286way8W3hJzYCh+VTYEjtZBxHQU5EkzBihg0ckQcAg/pN2qoKL7aT2v2KWMTaZIZNAOyZWzBFCRTLSEFC144fCn0emawDghosQeakbffJh9sQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2009b65-a13f-415e-4902-08deb6556ed7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:51:58.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zT1hW1RqJS64Okz80lTeCEB5J83OFblbsTAWYnwfMPG3FO4NPEiUbCamC8KLAJapuUXhwp6T/PAm/gHg15cSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	TAGGED_FROM(0.00)[bounces-289866-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,patchwork.freedesktop.org:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4216D58B23F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/15/2026 1:58 AM, Raag Jadav wrote:
> cleanup_node_param() is not registered in case of counter allocation
> failure, which results in stale memory of previous node that isn't
> cleaned up on unwind. Fix this using drm managed allocation, which is
> guaranteed to be cleaned up on unwind.
>
> Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_drm_ras.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index c21c8b428de6..89640ffb1c33 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -80,7 +80,7 @@ static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *x
>   	struct xe_drm_ras_counter *counter;
>   	int i;
>   
> -	counter = kcalloc(DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
> +	counter = drmm_kcalloc(&xe->drm, DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
>   	if (!counter)
>   		return ERR_PTR(-ENOMEM);

The intention was to clean up nodes  if there is a failure, to prevent 
memory
from  persisting throughout the drm device lifecycle. We actually 
discussed this offline  afair.

So there was a change from from v5 to v6 in the initial patch [v6,2/5] 
drm/xe/xe_drm_ras: Add support for XE DRM RAS - Patchwork 
<https://patchwork.freedesktop.org/patch/704873/?series=155188&rev=6>

Thanks
Riana

>   
> @@ -135,9 +135,6 @@ static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_err
>   {
>   	struct drm_ras_node *node = &ras->node[severity];
>   
> -	kfree(ras->info[severity]);
> -	ras->info[severity] = NULL;
> -
>   	kfree(node->device_name);
>   	node->device_name = NULL;
>   }

