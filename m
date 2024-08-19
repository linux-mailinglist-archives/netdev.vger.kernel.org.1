Return-Path: <netdev+bounces-119662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8D5956830
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80EC280E7F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DDE158DBF;
	Mon, 19 Aug 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWPYtaGw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D922900
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062876; cv=fail; b=RIDu022Ju4Yay5LWv89JCDVRB2/l1M51FKprFBtT4PehN4YgAtgN/Xq6+I7s63mxcLXwBW7jTUiyx4khd35bQbFAngXeF4o28Dzq87co7WG7+fETere8QmdGXaQ5GNwhHDYeK+OUsg/hx/uEg7ifC79HmF50i8mClcPRaegjhLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062876; c=relaxed/simple;
	bh=500cBI692cF9Z9Ho6dIEg9/23pqxfgxwgPImDMdZTfQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IZ3nJIk3UWur7jfypF6hlfd8BzoKp6YkNXPDDHs+BeRns90rQrByq5yNmpnzFiqddcXAeLg8SPjApqS2FVuVKmRW6Q5lclGZiwe7gNWro/o5nnopEgafT6+jpZNpcyaN3fun4U6st+2Sd8as+87Qb99yuJ2AKQc2EG29nzOt6O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWPYtaGw; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062874; x=1755598874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=500cBI692cF9Z9Ho6dIEg9/23pqxfgxwgPImDMdZTfQ=;
  b=dWPYtaGwUhOQ59S/7DMbSPCkkG20W1FkGmaxZqklU+sVGezWGIMuSrDv
   1FmfQzwHVCwgHi82Ckyk9A85XHWiS31FNDnXaV3NKsB8nS5KWGBDLhgg6
   CfbO61E5DQ3+E6+FD7esWQK1MEIyIYWSLpr2gvqZeiQCtxem2WbDoPsWl
   ZKNUBCuO8Aqk7Tnrd8cRwLPJER6OqAWEAs1y7FcwUTSWEVBjsvyiptZQg
   baGf6Irfqj3txLwEitfZHHXkB2cnGpAV+233SxN0azJeu9wNRYF81g/dN
   sYXNyER0gRHT7LUTG9ALLRc8Eq53VCrOFxmb4kw9UciIl/0jZvzQHfDPa
   w==;
X-CSE-ConnectionGUID: xgUcZ8eDQuejJQbs8QDRJA==
X-CSE-MsgGUID: ncWWOzlXQFmi55LXgo8Rcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22460207"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22460207"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:21:13 -0700
X-CSE-ConnectionGUID: Wn1P8ISwTSGv8Itw5gEVuQ==
X-CSE-MsgGUID: Nup1wKudRCOe6AQK0R2uMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60033493"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 03:21:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 03:21:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 03:21:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 03:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBPwhLw+vP3ZAAaTZ3/xWf3yYy5TDjtHZegjwiqcoZuHXzMns7q8NoKP5u48/mN84ijH4ewUgVOgR/nf0HIf8eKWKtUt8N3hsLzIlIH8HmGYwbmN9jxw3g8Hk/3Feh46cYQoGQ03i4LGoG5B+CM5/3FMgClO7ztirjt0MXD9Wz11uoF6K97XaA2wN3ftYwFKrBlGkc3znPKSFao3TxgcP5u/iLZuQg6IIVqysPau7h+RyCVztMiH1Lx4wu+tAkQb6EjWsPt/sAWHnsBpnGoaWAuNF45C5Cdl/rojlLKWn9EmZxuJnqqBEL0Pd8nsw5+8WFQXs/ArEr8aQGMjere++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52XQSM/SceJptlA8Jw87V2A/A0fAjapAJXvOoXJQ8sA=;
 b=EbMzz0o8eL8iIFU1p+05LKaV4UZYbAupxrPK/Ho75+Yxah1Fs482DpSmXTp+ExCmRFolaDGuma4lNP8hkLboU7yXN8xzEmoG9z+Am+TteRSh6hwPMFDzVlrPfJYwUUFIW7cur8V1g1Dh51h2E1xicJIguZQIfQ8FDJ7kxId4mQ/umuHD1PgGXde7kLgGMxFHSleCM5A3T83pwfpDp8GsQc7eey7Dn9mkafUJq7pibDBUnlFLUB08nk+iolK+ZsZcsaRUtKMIq/UbiPzC2WXTPekOsgankSfQYDNhkfmqoZzbXZseug5qagld61rOu0QRKJZA1EyTW7Kvpjo0e9E17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB5000.namprd11.prod.outlook.com (2603:10b6:510:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:21:05 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:21:05 +0000
Message-ID: <aac3392b-523b-4c2e-8084-b5bc80adb76c@intel.com>
Date: Mon, 19 Aug 2024 12:20:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/9] bnxt_en: Replace deprecated PCI MSIX APIs
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <horms@kernel.org>, <helgaas@kernel.org>,
	Somnath Kotur <somnath.kotur@broadcom.com>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
 <20240816212832.185379-8-michael.chan@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240816212832.185379-8-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: bbed8127-fda8-4db3-11c6-08dcc038a21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGJ1ZHU1aXBmaFFaWGtQUWxVNEhNZ2dKZWc0Y1BwUkxCcHVIbHBZa2o2YzVT?=
 =?utf-8?B?UXJ4bHA4T0g4ZExqeGZjWml4YUszVVJPT3pzd2M5b3MrbUc0Y2lpQXV0TkpW?=
 =?utf-8?B?eEdMS25Eenh6aXhTRmNpUjM1SnFIQ09JMEFwTTk0bFNoMGJkUDM3Wm5xTC9O?=
 =?utf-8?B?N0ZTZnlFUmlJU2txd2ozYWs5RzcvcDZvdUJLT2xXUCtoK24wQ21JbEZMbmpN?=
 =?utf-8?B?dzFjeXZRUjZhanVJQW5RMGJxWEVwaVBYSWVidzhLWExjUkJVbGgzL3JHY3k2?=
 =?utf-8?B?YnVsRU9RdVRhSklyY1BJVDA0cUl0UWNTVTN6NzdOMy80YWkyZXJRSnVUNlFr?=
 =?utf-8?B?RUwzazdUOVFpUDRReC9Oc3Z1c2lGQ3BnT3BEcTlNN1RmRkF5Mzl1cnBvZ0hL?=
 =?utf-8?B?THBPZER1VTRuQlR5MVMrdXE5eUw5OHJoQytmYUJZMmVFRm1NZHVPYzRYOTFN?=
 =?utf-8?B?ZWIzNVJUdndZcGNNYUVjZk1BQkQ3eHN3SjZod2RRd3dGVjlNb0FzZkI2Mm5M?=
 =?utf-8?B?c0E4TFhWS0pIQnlxQkFUV3lmTDZxcmU1UHdnWHIrT0hqSzQzdFBnVVN1UHNV?=
 =?utf-8?B?OG05aDBkVkJ1akpwWGNQL2JCTkJZZHZpNk9iWUpXdWtmKzZ2NnQwMEpJN3V5?=
 =?utf-8?B?USt3WFFvVVMyL3lPcHNjcXdHZVhXWkhIM01vdkhhblBwdmxFNEtGZHRGRmlp?=
 =?utf-8?B?UGRuNnE1RmdNOWwzMjZLdU92VWJ1eElzQWtzdGdsTFdaUWU5R21Nc0lRbHht?=
 =?utf-8?B?cHlOZ0VGQTlWSWk5ZUNQNFI1eU5adEIwdkVKSUhVSndMOXVhbncyN1Y4d05M?=
 =?utf-8?B?aEJLWHVUdWNhaG05SnhxQUVySDY0K1JFSU95QW9XL1NVQzNkcDFab29nV3hK?=
 =?utf-8?B?d2xueFpndG9mY1ZGbFRuZXJZWE1ZNTVSS0VXMGNxSjY0RUc1OWkyc2hhQVkz?=
 =?utf-8?B?NGhPWmNDbGZ6TFpOcm1FMWU0Sjd0bmM2UHVFZFhHWmFCcFBYTDkxQXhaZnJR?=
 =?utf-8?B?Wkl5ZjJpT214TVF1UG9PRzB0d0pXTFVMOW1FZHBQelJEalBscDN6Z2hjZjhh?=
 =?utf-8?B?KzFEUzlwbkgvZEJUVm14a0VXU3VxdWJSb1hoRzZoU3F4Ym42R2szOGx2UjlE?=
 =?utf-8?B?QTFLSmYzNVJaZnlzYndyWU5XL3FMdU1ySURSd3V4REYyR2pWeHMwNWF0aVZZ?=
 =?utf-8?B?N0R0cmgxNjl2QVhOaElKQWZ3UGVNVjN6TmtaSlExNCt2a0xoQ1lRZmlyOG1j?=
 =?utf-8?B?Wk5IK2xkTmJOSWo4STdWSXhvK1gvTjg5T2hLY0orVGdQWlhxazZ2MURkUW5C?=
 =?utf-8?B?SS9PTWFEc1FjN0gxclcvLytBZVl3R0ZORTFxZTgvenNnc21hR0RlZHNBL1Zv?=
 =?utf-8?B?Uzh1RjVDcVhXWnJmR0FPUmNyL3plQUQza1Q2R0FGcFlQZ0gwdnRMYWRkdDc1?=
 =?utf-8?B?b0dKaXZnL0NYMjNYN1duZ2REdDVjYjd2c3BqeXpDMjVGT2lySDhsSVJYM25V?=
 =?utf-8?B?bTRkUG1wcnNBRy92bFJIb1FCMUhFTUw1dG9ISVQyeU14WGN2cDZTYXRQV0xy?=
 =?utf-8?B?TnBjVzVUU0M2NzIvZ01DNE9hUDdiVVhoSmRaMnJMWTZURHRPazJxejB5bzhy?=
 =?utf-8?B?elVIajFLUm91Tll5YVd2NzE1dUFielByeHhGdythZFFwNjRSS2xVRDRDTDJJ?=
 =?utf-8?B?amxVTktqd0Y5MTQvOFRJSTlzS0hPL1ZRR2lRRFJhSTVMb0ptemtEKyt4MDVE?=
 =?utf-8?B?UWdzV3dYVnhnZHg4VFBjYTFQVS9pUExxY3hsNXViT2RpcVBqT1Ird3djUGFq?=
 =?utf-8?B?M3F4Mkpvc2gyZUNOVER4UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3RPcnloVjFHUGlLM2dsZGMyR1UzZVluc1dvNG1qMURlMU5uaUdRUWhWV3Zz?=
 =?utf-8?B?MW4reDRIeGhVeENFK2lSZTVldituNXZObE13cnRJY0J1bDJVMittMXBRU2xE?=
 =?utf-8?B?YXU1VHFpeFUzT3hacHlBcE9hQm5lcEZpWmhocitaRkNjWDZobUo2MUQzQU9w?=
 =?utf-8?B?S1pGYUZWdFQ0LzRpL0xNNW1OVURxOTJBY2pBL244ejNlc0pRMkJQdDlGcFBa?=
 =?utf-8?B?d2pxMW1rcnd3Z0RYNlRMMVRnbzhldWNNTU5acGQwRUIwUkdpL0t4azFrQ1NG?=
 =?utf-8?B?bFhYMmJJUkwzeTg0d01EenFXdE9ZYk1YTDdVTE54TGZpSDJkRXNVTXFiS2Z2?=
 =?utf-8?B?MGRyei9XTHE0emp4aFJJQXlNc21UVTVQYnBKbFcrcEI0amxYL096T1NVdk5E?=
 =?utf-8?B?UlNaN25CT0JBS0srOWtnWVJFaVUxd0RodndTUzdKUjJBQnRGRkNpM210aHZr?=
 =?utf-8?B?UFFVU203VnExWGFSTFgvRWwyT1RZNzhDMWs5Q2t0UG1EWFo3Rld0a2tjTkxT?=
 =?utf-8?B?YVMybDUvV0lITFNwcGpMUmw0aWNCS2dmLzY4R0Juai9uTHNRL0Ryak11V3Js?=
 =?utf-8?B?SUw2MmhUTzZSb2JRVFhkRE5kZzJUdGVaZWhST0FUL2Z5NFlEci9DWVcvYWJM?=
 =?utf-8?B?YWVpSm1DUFlocUJQL2V2WEtDcjR4RUpDcWpJSjhrc2NqTUxwcTZoS0pIcjFr?=
 =?utf-8?B?OVJsSE41M1doMDNnU2Jmb3lZQXRwbTZFS003SERjUVI3ekVJczF5am4wd1Zp?=
 =?utf-8?B?TUxzTHJuZDFXYndydnNTSDFQMDB3b0lKVzREWlZDK0plaFBvZGE0eEUyUlJB?=
 =?utf-8?B?Tjl3YU8vRExHYjN5clhmNGNaWjgvVWlVSGVqcGlvOHRTWVFGT1Zla3JXOTZ6?=
 =?utf-8?B?TENvMi9HNkcxYTI3d0hlckdDbGVXU3N3d0FNWUhyRW1GeEkwdk5hcXpnOXR6?=
 =?utf-8?B?TkRsNzh2cUE1N0x5OXlvTXBQcTZlTExCaE9nZEd2TW5SMGtBNjNzRjV0cWNn?=
 =?utf-8?B?cDFLLzdUdkl5V2ZOVFNZbGdMYVZETGhBWWhhaUVQdGhPMDl3YnZzRWVKNEpt?=
 =?utf-8?B?NDBHUExka3BmSjhkK2EyMWVRa25nRFl6VzM2dmdaQnFMOHR3SzZHVGtzbHg3?=
 =?utf-8?B?Yk9ZNjFUMDQrNk5kdFF5bGtNZmMzSnVxNnBDVXZKTWMwdTVoVlVialphcGlO?=
 =?utf-8?B?QVIvblpxc0xtN0lud0VKY0t2cGhsd0VOdnZ4T0NHOU5RNVBxdVFEN0NTYWND?=
 =?utf-8?B?bEpLRHk0SHNvOU9waXo5bUxkQXYvWHE2K0U0Y3ZLTytzYmIra1BXODlNTHZa?=
 =?utf-8?B?ZjFPbVhOd0JWWDJ1dTlPRFhwcXBQSmx6Yk5IWDNWSUQvRkk2aGxCSmpoNGYr?=
 =?utf-8?B?QU5xNHM1OG8zVEZCU1NEeGFuUkgvTHJRa0V0YS96RW9HQ2hyYy9qdjhWSXdR?=
 =?utf-8?B?TkZ3T0RWSjVQY1NwTGdwVWRWZFIwbWZKM1dhaENORVduU2s4NjVONHpUYURu?=
 =?utf-8?B?VHd0c0hBWTVBbU80cDU3TThaNnptaFRYeFhTN3Rma0ZvTTF4MlNxVDRrQ1Y5?=
 =?utf-8?B?emVIYlEzZ0s4azBwRjhCdmh3eWJEWmllTHNURHJnaXFmL0hUWExCZlcrdWR4?=
 =?utf-8?B?cThyY2kvZWlWRUhJODh1OEZPbzlETmpSNlJKdWFpY3BKbHJ5eEp5L0Zuejc0?=
 =?utf-8?B?Ti84cS9nRHQvSzY0NGppRXYvZ0Rock9FWXhZb21hbEc3ZDk2czRLOEVZNWJk?=
 =?utf-8?B?c0dPaVdKUCtPanBOZGRyVTBCTU1INUVpZG1EajVCUW1Ha3gxR01oRmRYaFRE?=
 =?utf-8?B?azMwWnhiVDV4bS9WWmdxWDZsS3NQenlnTUN0NUJYS3BON0lKRjZJTEErNEkz?=
 =?utf-8?B?RUdCN3JheWs0cFlrZWh4eENwUWx4UTNsa2xEVEEyU2tJaFZBak1CRTJnY3ZQ?=
 =?utf-8?B?SlN2RUlZSnN5NVJ1QitTNEF6YzBvcWYvMSt3QTFKTVhHbzNhbzNBMnlYODJZ?=
 =?utf-8?B?amVxcXBWaGVsZzJxS1M3dVdySGk0d3NJdTFhc2JPcmlrRVZQR0dIeDdIek81?=
 =?utf-8?B?QTZaRE5pRjNscWRxMjJJV2F3d2t5SGllUkJUWEdjSVQ4MDI3eHoxeTNSbHRo?=
 =?utf-8?B?UUJhaFZ5Tm55ZEpvWU8vNFZvMDhONS9zNWFDQnZEYU5lZ2p6UFphZjdsYmZl?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbed8127-fda8-4db3-11c6-08dcc038a21d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:21:05.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iODaSEkBvCAt6gO6DFHVnHyOn50EcqoAJNVR3r9qTbZy1i5FHScMDANZiMHTnc+LGQ3FWCzvTdXPorrQ8KzwvJh7ZRkdTtaOQh+U7coysWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5000
X-OriginatorOrg: intel.com

On 8/16/24 23:28, Michael Chan wrote:
> Use the new pci_alloc_irq_vectors() and pci_free_irq_vectors() to
> replace the deprecated pci_enable_msix_range() and pci_disable_msix().
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 +++++----------------
>   1 file changed, 5 insertions(+), 16 deletions(-)
> 

very nice,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

