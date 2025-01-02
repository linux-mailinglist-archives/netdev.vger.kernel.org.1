Return-Path: <netdev+bounces-154839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1E5A00074
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9B91626A9
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F4185B48;
	Thu,  2 Jan 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xc6PheZx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451A17D346
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735852610; cv=fail; b=Udm2cbqu9iK68qSCfp0fhx0QakD6Iz7qnf95vk97/q6uCnjkzVlyyl8GhGcgcGoPsIa/z8clMa27U1ZiOi78V3OeKmS1QqckgqL8BJZoS5+jm3tS+GUteGeKOv6CNOpNi20kqpBEVx+Yo1dj07EMi8YffdInA/ushquihKPggq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735852610; c=relaxed/simple;
	bh=eQg+zzs6MAivjTXoMs0ti9Ncf0+LYoifxw9yQt3bf1s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AKXDn3w3rnHyFJ5KxnGTubaKWFuz7Lc+b9CjLMcGhD5+CXu02MFQBr/hW2Xed1L14T6u1wwtky0rUVc30p+ezKkVvVZxYUIuRdjPeFnKyBRPCVpWgGy1LLDw/X4Pdy/nABBzXyFaiKcA7/wIbicX8EqAd73ZRWKvfVifYwpbfbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xc6PheZx; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735852609; x=1767388609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eQg+zzs6MAivjTXoMs0ti9Ncf0+LYoifxw9yQt3bf1s=;
  b=Xc6PheZxRx/cnujCsMCr7EZmUxTEfM+U8b5QX3P5dJdT+Wm1KG2Rsecs
   E77fd6x604CR/RuC/12wPxkVjToTcm3WIv8TWTd82DVyiiGCca0UvnaiP
   Inr41hdqE6g/xzpXsyhAvLHzqfETcaWRjxPDgbWPqWqN032c0P2EgBMCB
   b4Uy0llJI5xa9J5d0gddYrybXaDmzybr1QmbKfCCmq2k43ktPu8x4nsx5
   z01TokDsEVLYKNUkLDPH/W9VBPCJdjGLNJP/wTQpWWgGv1eYOZHS+yADQ
   fFpcC68bZ21iEy0UtlXc2f/ID30GLUlka7o32qcfjpSm0nYgojiupIAFY
   A==;
X-CSE-ConnectionGUID: nexT0Hx3RS6BUys4aGsdsA==
X-CSE-MsgGUID: +s+PkI6dTIOdl4JXjVSvmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="35803651"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="35803651"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 13:16:48 -0800
X-CSE-ConnectionGUID: ZjQsedmdT8aLNR0Xx00/NQ==
X-CSE-MsgGUID: jvkzhxdzS1+K3MArNjtuig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="102125374"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2025 13:16:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 2 Jan 2025 13:16:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 2 Jan 2025 13:16:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 2 Jan 2025 13:16:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzjhMlZpzE1Z7cHFkvoY7r2lYECLEt/8k4XMXMARqxF9/C3Vjrv68yt815rxzWKBV9py8Fn7ky6SQ6u+9Rwutgfw5rxY5sHouPChJIVgPGSMP3VaSNynAA5l8JT2Bepjrv9AmaTX28Tcnbna9mYiwpmU6spDrufwXX5ky2lVD1rOM103st6VGDMpX/BDRp+jRMQg7IhS7I89j7c+ks5pWfxXmvJIbUkpgqHRN5ZLcJDflhkxTOrnoJEKylY/yrQ6X9y9nu+MfqEskp850izUJNlLBwf/y6+avn0TdUcMS9K3/J4l9noE0Dlmb7YTLuxl3yOsgWyLqzQg4aVIFj9Glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qus6iiwtfg19b7VZjApvbFvUHcp9KFl28WjESYRZ7yM=;
 b=IVG17nDftY9921IXSNQTM2av08AtudgjOFw5yzgwvFL0B7h3haL8DsH0VoCY+m4aGs2t6HeZxS9N/EPKGOoHJsN18MLb8XtDAGojESwexpsT5Mum0CDziIn5pW+LrR7tiLhjjIxo7WCMD3unwpIuL7kBlAoILQtUziBQwr4+MCFXiCysCQOcAicwT+SDr3PHQkXJE8NSJEgO2RVfGOLMdsH2mjd9bXoytzCMTW2C+vOZ2ZvbeRAXdqwnt1X/z2Y0TLnUuYaPwYKuqhYwxCfOWQiSAOQB+xLihwWpdU053dM9vF3cx2uO0CkQ/780sgrVsavQBijNebl3fTlerOPAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by PH0PR11MB7523.namprd11.prod.outlook.com (2603:10b6:510:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 21:16:26 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%6]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 21:16:26 +0000
Message-ID: <dd41a7d6-892f-47a9-8ac7-80d7ac8b5d7f@intel.com>
Date: Thu, 2 Jan 2025 13:16:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] Extend napi threaded polling to allow
 kthread based busy polling
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>
References: <20250102191227.2084046-1-skhawaja@google.com>
 <20250102191227.2084046-4-skhawaja@google.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20250102191227.2084046-4-skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|PH0PR11MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 08541ca5-ffba-4674-960b-08dd2b72b79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ums1V3VXbGtYUkJXTnVUN3kxZWlXSm1rZUg3aXJpRjVpZzVWMlpvMTlLVTJl?=
 =?utf-8?B?NnRQUVdlc2wwcXlWQUFtU3lBTmNuSmZCUWpUazZzYW9NV3VhZVVWMW1JYTVC?=
 =?utf-8?B?bE1FSjJwUjNVZTBVVmYyU3djREI5cTQ0ak90Tm1aVXc3aUdvSStRYlNlcmRa?=
 =?utf-8?B?S2FtOUtCNnJrdzhuSFhMN2VUMjdYbVN5NGl4TnEyam5HR1NvVlRnTkgwb2c0?=
 =?utf-8?B?QVRVcTE2NU82TXJOS3BnNjR4ZnZLMWpYcVJORHhSVHlFbHMvT2Z2eXp3YnVU?=
 =?utf-8?B?RWJZS0piMWx0V3lUeTZVL2U3aStuRUJNZEwwSWtIbERZUEJkZmpmZkJmSktN?=
 =?utf-8?B?UnFVM2ZCc09ycXc0dHhGT0o3SU5ieXA4TzFBbHFqSytnbld3SUh5ekI5U0g5?=
 =?utf-8?B?QW9CRGNvQ3FDRkthRkMrVWMzQnlxazRoNlpFdjU0MnBoZ2ZHMlczbTl3RXlH?=
 =?utf-8?B?U1JTQ0Y2bW1EV25STEtydVRyN09keFlsYmplWlY2RXJ1SUtXRUgxUWszZlVw?=
 =?utf-8?B?M3oxNHNNT3ArWEhrS3QvelN0d1hvRjRnTnkrQzhkaVB0NDJxSE5UVHhRdGdD?=
 =?utf-8?B?WHhFbE1uSXRMUVFjREYrUzVDYXFORmt0TXBzOStzM3V6RVM3NWswVkloUnA4?=
 =?utf-8?B?bm1XOW5JZVNXMTJwQzZqUVovSDd1Nk9Ud28yQWQ5RlMxVHJBRHFrSXNReTUy?=
 =?utf-8?B?czAzbXpTZlpHYmI1SjlqUEFWU3RuVXJwTHpaeU5oV2JraDlBeDlKUXVTd284?=
 =?utf-8?B?YTVtMmRpaUNPRHBldS8zUWljenNoWVpEQWcvdW8yL0lIUVcrNERKMzBoNk1Q?=
 =?utf-8?B?RHUvYkpDcEhTeFZIZDYvYm5NWmc2YXlIQS9vbDNKNUdqRFVqU2dVVmdJMGVU?=
 =?utf-8?B?VGN5N0VUcEhmcFREek56bW84QTc0cFhiZFFnTDRBYUdOelkyVzFLaGlOSzlk?=
 =?utf-8?B?VllIMHZlWlIyWTN3SzFzYUsrTStCWkRIMmhuQlhXZ0lqVS9qb1YwTC82c21R?=
 =?utf-8?B?OHA1azR2QWN5S2FJUTl6OFk1NnRDaXlMb2xuWTQ1VFhxUDZrWG9IWU56eEhM?=
 =?utf-8?B?SDN1MGhaU05OMWFieldkL280OU5rU1YwZXl1VFR4ekM0QkZYUjdkTG5SRS9T?=
 =?utf-8?B?Z0FQMmNCVndCUERqQ0Q3VWxuTlZzZzkyVXBvUXg2SXNzVytFK3l4a2JPRVpP?=
 =?utf-8?B?cmZxRjhsKzJrYXhoMEpMcUJZMndENWF5OG93ZHpmclc2R0lFcm1heFNiTXJq?=
 =?utf-8?B?aEZnMTAzRUF0b0ROaTJWNzR0blBUREhINHlIS1pqMVVJYzdRYVErRGRlcnJJ?=
 =?utf-8?B?WTRLbElNNERQaCs3RnNNOG44TEdXVVVHMWJncEdBLzVOT2pNK3MrbHNYQnRI?=
 =?utf-8?B?QytaZE1Ya01ELzNJSFBBbDNzWFJFSXZOWkdGOTEzVU9JWUN0MXRWRVJFL0hq?=
 =?utf-8?B?YnVLMnVoQzZKV2tDeVRRNE50Ukt1b1VQSGJVWFV3djZENmxMSEVLZmtTUkNN?=
 =?utf-8?B?Q3Y2VE1NTVpTODJ3NTBUYjIvUGg3RVNmTW9UVjU0L0xkVWN1RWpiVU9jdTdo?=
 =?utf-8?B?cmZJRDdkSHpKc292ZnhRd1dlYzlxbWc2QzhoVUpObWdZeEhOU2hrM1lWQ25v?=
 =?utf-8?B?N2NGcUJ6UENWUUk2bDk1emtRb3R1cWRCdFV1WnV0eEZkRGNQWE81c1BnQk4x?=
 =?utf-8?B?VTBTMjhZU1N2VjgzdnpWdGR4NTY1L3l0OTllVDlRQmRySEEwajZpNERkWlZC?=
 =?utf-8?B?eWdMUzhvRzN1eVBxQm95NDcvRVlRbStseURHL1gzUHNzcnl3cExvK3hVV3Ns?=
 =?utf-8?B?cnVtaUZVQVMvdEI2VVlUWWpZYkNwUTE4SXEyREE5bmJuNm9ldUxsL0NEaCt0?=
 =?utf-8?Q?D3vAbBUeja9oz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dZSmRCNUw2SngxMlFKUmxJSWNsaklZNzFWaXZmOVZ6Vnp1aXhuOEZiMldl?=
 =?utf-8?B?Q1BwejBPYWdRcUI1YmlqWGovOW5Vbmd3UE85bytNazd6RkhEbGxOeFA2NzVK?=
 =?utf-8?B?TzdJZ2FWdTFjVGtKait2S21RWHQ0OGhNQStqTEM0Z05sQkdSRXBtaW1SVUtV?=
 =?utf-8?B?UVlNZDNXdmVRazhrcnNjSHFxNjFTaXMrWlpPcC9ZQitIUlRpTTliVStKZVlE?=
 =?utf-8?B?WXIya0h0YldCVjFEU0VTMzB5NTlReWVUVGhHZWdxVm9vUzIrWUlONzU0Mnd5?=
 =?utf-8?B?cXlHemdieG13VkhUd1JhWjFkTWF2UlBLY29kMEZWSnppZGs3RVZ0Sy9KSmFR?=
 =?utf-8?B?S0RHbU9kbHhRUUlmNDZ4WW9iNWUxU0JCZTcyc3NwazdTY0tqOUMxQkFJVFBz?=
 =?utf-8?B?SkdqZWdvMkI2NTZzcWVrTEZVWW9TUXd2SEVXVHd6U3gzS2lPbmNzZVVudTZ0?=
 =?utf-8?B?Rms0c0ErN2VlUDhSYWNNZFh2TXk2VWtUTnJtNU1NcXgvMkJaNzZSUDFtak5E?=
 =?utf-8?B?dEZnQmxkLzFHWVRUbzVFS01ydHg4eUlUaW1ZN0RDVFU4MWlMZ1BtUFM1WDlE?=
 =?utf-8?B?N0w4N05xLzJacnN6MjNxVXkvQzkxaTE2TXJwZmFzSElRelRYUHlsaXNaMHRm?=
 =?utf-8?B?VlFlblFBR05UK3RuU0F3NjRYYTZSenFOcnhZMzdIMzBNNzFPZlZsc3dkbHUv?=
 =?utf-8?B?cDJkc2RQQVh6YWsrZnp6YXQ0K1ZxcE04V3RtTHBGNlNLL3BGYlh2QkRpck8r?=
 =?utf-8?B?V09IejRFNGc4MDlZUHA2YTgzY2xabXI3alBhQXNvV2FKNE1OV28vdnVaZFR3?=
 =?utf-8?B?M2Z6b3FsbGxZU0Rjamp4c01XSk1yeG16aHNvdllLQmxKZ0d1ald2ZnBYVndQ?=
 =?utf-8?B?K3Z3QjZSQzZ4L2U5L2UyRVFUYkRiMjNBbS9lWk9JM3JUMGQvK2s4dkFwT2lX?=
 =?utf-8?B?SFZuMStadEszRkw2d0V2YTNwQVE3cU9PT082Mys1VzVmbEd5VTJsYzc1MG5u?=
 =?utf-8?B?dmsvcmVBVDdGTEs2cHFSN2RkbmRhdkd0cHZKVFptY2x5UW0ySEF0N1VkdWM5?=
 =?utf-8?B?RHpsY3YxL3NKRDVYNWhieDlhTnU2cjMrRUcydzJ2ZERQU0NGWWh3RWc2cHJP?=
 =?utf-8?B?MDJFMzFtbnJlWmQ1WlVIcGVMVVBkcUU3aDZzRXVNKytNNlIxVVdrWVI4ZWhz?=
 =?utf-8?B?aDh4bWRMQ29semlvWDRDSmVVbHhDWFRKcE5aWldWZlIxZEVzYWtBVXZmQzRY?=
 =?utf-8?B?QWN3Z3I3a1lsRnlBNEY1SkhuMnlOOFVhQ3RnNkxGVHo1ek0rVFg0RDBmTjJI?=
 =?utf-8?B?MWxCbE9iU1ZPUUcxUVNidFI5aVo3cE0yOFJXUHFBN3MramJFUTQrYzFReW5a?=
 =?utf-8?B?UlpWNExEaWM4K2U1WjdmenNwbjE3L1Q5OUg1ZlZPdEl3RzRGSUFNdFY0Tld1?=
 =?utf-8?B?S0Fud0owbUdWWEJ2ZURJNVVETy9aZWVpYWhHaEszZWhGaDlBVnlNZ3FCY0RX?=
 =?utf-8?B?NkIwYU5qUmt0aE5iMlpNY1dHQnV6WUNoZkFxTWpoODN5akM5eHJkajhUYUdn?=
 =?utf-8?B?dVdybEFWVXNPWmRqMEU4T0hkU3hlTnVGMHRIYTJ6TU1FN01pczdVaTNMbHky?=
 =?utf-8?B?ZkNJTGl4R3lHWFRNeEZNZzNCbEdSYWtJcmF2SmliaHJ2WGxveDl4Z0cyNFYz?=
 =?utf-8?B?SWd3cWoyQ045ZDgyTlI4bnNXaFlNRzR5NFUwV0VYdE1sQXRsT0c1UTJwT2Fq?=
 =?utf-8?B?dGNXM2FMUitySlhmUG8rQ0RPWVZFTTRWK2phMm9OZzloaXlMcFFDdldaenZ5?=
 =?utf-8?B?cTlPUEdKMHM5YnE5VUFBRWxQNHBWQUhJUGVTZGthcjgxSDRHSHdJN3dGMU9t?=
 =?utf-8?B?eEd1ZC9RUnkrb2lJOUg1WitGN0xUYllmSWVjZnkyTmFheHRKdFhFaWxrTEFh?=
 =?utf-8?B?MTJEKzZQR3UwR2xyTzVTd2RVcXdNb3VlUDBhaWJuTFAwd2xZdTNaYTRMcUtu?=
 =?utf-8?B?UWZKZFFpTFBjNy94dHRkQ05xUEVoa1dxVmoyZklKSlE4TnF4R2xWRnd3cXhX?=
 =?utf-8?B?ZmVpaE9TNG1nSGp0c2pyODJSOFhPN0pQRlN4b2wvWjBySWR2YjN4QlBoS1lp?=
 =?utf-8?B?ekF5ZW5ickdMbVFrMW85bjZMMEM4ZlhGWUtXSFVQZmhkalZVL0dVUzZLK1g1?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08541ca5-ffba-4674-960b-08dd2b72b79b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 21:16:26.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbAC/CK7rUW60/GbYersliUbfYyG+rTWvl/4jzzYMzPiJ9m8AkjlCS3ue8rnvqwOnLFuN7NOf9BC5W0RRa/ZDkNVPWKZ4yMfPr2/GIg1vTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7523
X-OriginatorOrg: intel.com



On 1/2/2025 11:12 AM, Samiullah Khawaja wrote:
> Add a new state to napi state enum:
> 
> - STATE_THREADED_BUSY_POLL
>    Threaded busy poll is enabled/running for this napi.
> 
> Following changes are introduced in the napi scheduling and state logic:
> 
> - When threaded busy poll is enabled through sysfs it also enables
>    NAPI_STATE_THREADED so a kthread is created per napi. It also sets
>    NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that we are
>    supposed to busy poll for each napi.

Looks like this patch is changing the sysfs 'threaded' field from 
boolean to an integer and value 2 is used to indicate threaded mode with 
busypoll.
So I think the above comment should reflect that instead of just saying 
enabled for both threaded and busypoll.

> 
> - When napi is scheduled with STATE_SCHED_THREADED and associated
>    kthread is woken up, the kthread owns the context. If
>    NAPI_STATE_THREADED_BUSY_POLL and NAPI_SCHED_THREADED both are set
>    then it means that we can busy poll.
> 
> - To keep busy polling and to avoid scheduling of the interrupts, the
>    napi_complete_done returns false when both SCHED_THREADED and
>    THREADED_BUSY_POLL flags are set. Also napi_complete_done returns
>    early to avoid the STATE_SCHED_THREADED being unset.
> 
> - If at any point STATE_THREADED_BUSY_POLL is unset, the
>    napi_complete_done will run and unset the SCHED_THREADED bit also.
>    This will make the associated kthread go to sleep as per existing
>    logic.

When does STATE_THREADED_BUSY_POLL get unset? Don't we need a timeout 
value to come out of busypoll mode if there is no traffic?

> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>   Documentation/ABI/testing/sysfs-class-net     |  3 +-
>   Documentation/netlink/specs/netdev.yaml       |  5 +-
>   .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
>   include/linux/netdevice.h                     | 24 +++++--
>   net/core/dev.c                                | 72 ++++++++++++++++---
>   net/core/net-sysfs.c                          |  2 +-
>   net/core/netdev-genl-gen.c                    |  2 +-
>   7 files changed, 89 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
> index ebf21beba846..15d7d36a8294 100644
> --- a/Documentation/ABI/testing/sysfs-class-net
> +++ b/Documentation/ABI/testing/sysfs-class-net
> @@ -343,7 +343,7 @@ Date:		Jan 2021
>   KernelVersion:	5.12
>   Contact:	netdev@vger.kernel.org
>   Description:
> -		Boolean value to control the threaded mode per device. User could
> +		Integer value to control the threaded mode per device. User could
>   		set this value to enable/disable threaded mode for all napi
>   		belonging to this device, without the need to do device up/down.
>   
> @@ -351,4 +351,5 @@ Description:
>   		== ==================================
>   		0  threaded mode disabled for this dev
>   		1  threaded mode enabled for this dev
> +		2  threaded mode enabled, and busy polling enabled.
>   		== ==================================
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index aac343af7246..9c905243a1cc 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -272,10 +272,11 @@ attribute-sets:
>           name: threaded
>           doc: Whether the napi is configured to operate in threaded polling
>                mode. If this is set to `1` then the NAPI context operates
> -             in threaded polling mode.
> +             in threaded polling mode. If this is set to `2` then the NAPI
> +             kthread also does busypolling.
>           type: u32
>           checks:
> -          max: 1
> +          max: 2
>     -
>       name: queue
>       attributes:
> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index c571614b1d50..a709cddcd292 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	adapter->mii.mdio_write = atl1c_mdio_write;
>   	adapter->mii.phy_id_mask = 0x1f;
>   	adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
> -	dev_set_threaded(netdev, true);
> +	dev_set_threaded(netdev, DEV_NAPI_THREADED);
>   	for (i = 0; i < adapter->rx_queue_count; ++i)
>   		netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
>   			       atl1c_clean_rx);
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 8f531d528869..c384ffe0976e 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -407,6 +407,8 @@ enum {
>   	NAPI_STATE_PREFER_BUSY_POLL,	/* prefer busy-polling over softirq processing*/
>   	NAPI_STATE_THREADED,		/* The poll is performed inside its own thread*/
>   	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
> +	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded napi poller will busy poll */
> +	NAPI_STATE_SCHED_THREADED_BUSY_POLL,  /* The threaded napi poller is busy polling */
>   };
>   
>   enum {
> @@ -420,8 +422,14 @@ enum {
>   	NAPIF_STATE_PREFER_BUSY_POLL	= BIT(NAPI_STATE_PREFER_BUSY_POLL),
>   	NAPIF_STATE_THREADED		= BIT(NAPI_STATE_THREADED),
>   	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
> +	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
> +	NAPIF_STATE_SCHED_THREADED_BUSY_POLL
> +				= BIT(NAPI_STATE_SCHED_THREADED_BUSY_POLL),
>   };
>   
> +#define NAPIF_STATE_THREADED_BUSY_POLL_MASK \
> +	(NAPIF_STATE_THREADED | NAPIF_STATE_THREADED_BUSY_POLL)
> +
>   enum gro_result {
>   	GRO_MERGED,
>   	GRO_MERGED_FREE,
> @@ -568,16 +576,24 @@ static inline bool napi_complete(struct napi_struct *n)
>   	return napi_complete_done(n, 0);
>   }
>   
> -int dev_set_threaded(struct net_device *dev, bool threaded);
> +enum napi_threaded_state {
> +	NAPI_THREADED_OFF = 0,
> +	NAPI_THREADED = 1,
> +	NAPI_THREADED_BUSY_POLL = 2,
> +	NAPI_THREADED_MAX = NAPI_THREADED_BUSY_POLL,
> +};
> +
> +int dev_set_threaded(struct net_device *dev, enum napi_threaded_state threaded);
>   
>   /*
>    * napi_set_threaded - set napi threaded state
>    * @napi: NAPI context
> - * @threaded: whether this napi does threaded polling
> + * @threaded: threading mode
>    *
>    * Return 0 on success and negative errno on failure.
>    */
> -int napi_set_threaded(struct napi_struct *napi, bool threaded);
> +int napi_set_threaded(struct napi_struct *napi,
> +		      enum napi_threaded_state threaded);
>   
>   /**
>    *	napi_disable - prevent NAPI from scheduling
> @@ -2406,7 +2422,7 @@ struct net_device {
>   	struct sfp_bus		*sfp_bus;
>   	struct lock_class_key	*qdisc_tx_busylock;
>   	bool			proto_down;
> -	bool			threaded;
> +	u8			threaded;
>   
>   	/* priv_flags_slow, ungrouped to save space */
>   	unsigned long		see_all_hwtstamp_requests:1;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 762977a62da2..b6cd9474bdd3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -78,6 +78,7 @@
>   #include <linux/slab.h>
>   #include <linux/sched.h>
>   #include <linux/sched/isolation.h>
> +#include <linux/sched/types.h>
>   #include <linux/sched/mm.h>
>   #include <linux/smpboot.h>
>   #include <linux/mutex.h>
> @@ -6231,7 +6232,8 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
>   	 *    the guarantee we will be called later.
>   	 */
>   	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
> -				 NAPIF_STATE_IN_BUSY_POLL)))
> +				 NAPIF_STATE_IN_BUSY_POLL |
> +				 NAPIF_STATE_SCHED_THREADED_BUSY_POLL)))
>   		return false;
>   
>   	if (work_done) {
> @@ -6633,8 +6635,10 @@ static void init_gro_hash(struct napi_struct *napi)
>   	napi->gro_bitmask = 0;
>   }
>   
> -int napi_set_threaded(struct napi_struct *napi, bool threaded)
> +int napi_set_threaded(struct napi_struct *napi,
> +		      enum napi_threaded_state threaded)
>   {
> +	unsigned long val;
>   	if (napi->dev->threaded)
>   		return -EINVAL;
>   
> @@ -6649,30 +6653,41 @@ int napi_set_threaded(struct napi_struct *napi, bool threaded)
>   
>   	/* Make sure kthread is created before THREADED bit is set. */
>   	smp_mb__before_atomic();
> -	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
> +	val = 0;
> +	if (threaded == NAPI_THREADED_BUSY_POLL)
> +		val |= NAPIF_STATE_THREADED_BUSY_POLL;
> +	if (threaded)
> +		val |= NAPIF_STATE_THREADED;
> +	set_mask_bits(&napi->state, NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
>   
>   	return 0;
>   }
>   
> -int dev_set_threaded(struct net_device *dev, bool threaded)
> +int dev_set_threaded(struct net_device *dev, enum napi_threaded_state threaded)
>   {
>   	struct napi_struct *napi;
> +	unsigned long val;
>   	int err = 0;
>   
>   	if (dev->threaded == threaded)
>   		return 0;
>   
> +	val = 0;
>   	if (threaded) {
>   		/* Check if threaded is set at napi level already */
>   		list_for_each_entry(napi, &dev->napi_list, dev_list)
>   			if (test_bit(NAPI_STATE_THREADED, &napi->state))
>   				return -EINVAL;
>   
> +		val |= NAPIF_STATE_THREADED;
> +		if (threaded == NAPI_THREADED_BUSY_POLL)
> +			val |= NAPIF_STATE_THREADED_BUSY_POLL;
> +
>   		list_for_each_entry(napi, &dev->napi_list, dev_list) {
>   			if (!napi->thread) {
>   				err = napi_kthread_create(napi);
>   				if (err) {
> -					threaded = false;
> +					threaded = NAPI_THREADED_OFF;
>   					break;
>   				}
>   			}
> @@ -6691,9 +6706,13 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>   	 * polled. In this case, the switch between threaded mode and
>   	 * softirq mode will happen in the next round of napi_schedule().
>   	 * This should not cause hiccups/stalls to the live traffic.
> +	 *
> +	 * Switch to busy_poll threaded napi will occur after the threaded
> +	 * napi is scheduled.
>   	 */
>   	list_for_each_entry(napi, &dev->napi_list, dev_list)
> -		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
> +		set_mask_bits(&napi->state,
> +			      NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
>   
>   	return err;
>   }
> @@ -7007,7 +7026,7 @@ static int napi_thread_wait(struct napi_struct *napi)
>   	return -1;
>   }
>   
> -static void napi_threaded_poll_loop(struct napi_struct *napi)
> +static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
>   {
>   	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>   	struct softnet_data *sd;
> @@ -7036,22 +7055,53 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
>   		}
>   		skb_defer_free_flush(sd);
>   		bpf_net_ctx_clear(bpf_net_ctx);
> +
> +		/* Push the skbs up the stack if busy polling. */
> +		if (busy_poll)
> +			__napi_gro_flush_helper(napi);
>   		local_bh_enable();
>   
> -		if (!repoll)
> +		/* If busy polling then do not break here because we need to
> +		 * call cond_resched and rcu_softirq_qs_periodic to prevent
> +		 * watchdog warnings.
> +		 */
> +		if (!repoll && !busy_poll)
>   			break;
>   
>   		rcu_softirq_qs_periodic(last_qs);
>   		cond_resched();
> +
> +		if (!repoll)
> +			break;
>   	}
>   }
>   
>   static int napi_threaded_poll(void *data)
>   {
>   	struct napi_struct *napi = data;
> +	bool busy_poll_sched;
> +	unsigned long val;
> +	bool busy_poll;
> +
> +	while (!napi_thread_wait(napi)) {
> +		/* Once woken up, this means that we are scheduled as threaded
> +		 * napi and this thread owns the napi context, if busy poll
> +		 * state is set then we busy poll this napi.
> +		 */
> +		val = READ_ONCE(napi->state);
> +		busy_poll = val & NAPIF_STATE_THREADED_BUSY_POLL;
> +		busy_poll_sched = val & NAPIF_STATE_SCHED_THREADED_BUSY_POLL;
> +
> +		/* Do not busy poll if napi is disabled. */
> +		if (unlikely(val & NAPIF_STATE_DISABLE))
> +			busy_poll = false;
> +
> +		if (busy_poll != busy_poll_sched)
> +			assign_bit(NAPI_STATE_SCHED_THREADED_BUSY_POLL,
> +				   &napi->state, busy_poll);
>   
> -	while (!napi_thread_wait(napi))
> -		napi_threaded_poll_loop(napi);
> +		napi_threaded_poll_loop(napi, busy_poll);
> +	}
>   
>   	return 0;
>   }
> @@ -12205,7 +12255,7 @@ static void run_backlog_napi(unsigned int cpu)
>   {
>   	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
>   
> -	napi_threaded_poll_loop(&sd->backlog);
> +	napi_threaded_poll_loop(&sd->backlog, false);
>   }
>   
>   static void backlog_napi_setup(unsigned int cpu)
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 2d9afc6e2161..36d0a22e341c 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -626,7 +626,7 @@ static int modify_napi_threaded(struct net_device *dev, unsigned long val)
>   	if (list_empty(&dev->napi_list))
>   		return -EOPNOTSUPP;
>   
> -	if (val != 0 && val != 1)
> +	if (val > NAPI_THREADED_MAX)
>   		return -EOPNOTSUPP;
>   
>   	ret = dev_set_threaded(dev, val);
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index 93dc74dad6de..4086d2577dcc 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -102,7 +102,7 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPE
>   /* NETDEV_CMD_NAPI_SET_THREADED - do */
>   static const struct nla_policy netdev_napi_set_threaded_nl_policy[NETDEV_A_NAPI_THREADED + 1] = {
>   	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
> -	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
> +	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 2),
>   };
>   
>   /* Ops table for netdev */


