Return-Path: <netdev+bounces-234886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68396C28C50
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 233104E12A4
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C4263F4E;
	Sun,  2 Nov 2025 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAaWNfFW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C101DEFE7
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762073046; cv=fail; b=fD764tZuxiNKtP8o4PGLlZnRmyTJt/WZkyhrs9LTLobx8a3nkTBRZEuJ61yOVJUxtNVzaZJW1Q0oAILkxqBdZCozWCx1LGMGHSuPwJTOpJh1YRBTIiLCp+8o6OWR8+41MDpGmQEwx7gdKWEJX5eb+ZC4VgkKQeAkpcRXobvXbTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762073046; c=relaxed/simple;
	bh=47ExmcfAso2TsYN31F7+3QrYv6/2q3M3ZAYlggNpdMY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qn9sZOngEaArIg6HuVGKJWPRX3CEM8i5KFR+vJwPgeKFu7PHKsQ8hqURZKFEdi0578c+ySB1BMUIS1WgqTuxlyPn6eh9EP6jaH395OkNZbr431CVk+gifPlOQPdwvX46i2vb0bYn+v9p3kNDKgvlUcwegggIV9sD4SdN/9w/Paw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAaWNfFW; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762073045; x=1793609045;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=47ExmcfAso2TsYN31F7+3QrYv6/2q3M3ZAYlggNpdMY=;
  b=CAaWNfFWzPMKxB7l0p0Dc+pt6+Hm9eOSuh4PLCJCuamb75WQH7tL3289
   6/EztyG27ndvVVJu9uOEzAbO+oQwuACHPtS7eViHBfCN9lQiv+GyxN00K
   tlzi1BBGkAuMJJxv2wyRGaLbqdSyMBbnUfxGuIBo9y7/Occ+sQpps3q6u
   g7t0NjoYzlejsjgBoUVagkU22+0CCT+BNPsyVTqJ1qoI2GXLT6qStJOBh
   kdoVOwYiR9y6N05jl9h+8w7vPBaYBNLr1m8qAhym7wY9uUpgkfSefvXLE
   cHbUc37SrncECUv4J272uP/ry8ttpWYm1+gNnDW3OD0idAgbybzewvU9b
   w==;
X-CSE-ConnectionGUID: tEXyDER+S0aLLzy35mdHTQ==
X-CSE-MsgGUID: PKLthR2QTjSHn4G4zQgBcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="74853759"
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="74853759"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 01:44:05 -0700
X-CSE-ConnectionGUID: DrAW9kqETjiDdrQ7K99tgg==
X-CSE-MsgGUID: sB1RPdx8ShmY+RqCpCz1aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="185844943"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 01:44:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 2 Nov 2025 01:44:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 2 Nov 2025 01:44:03 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 2 Nov 2025 01:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFmWVZPcXC3IHAiWiFPHw4lAj+KYHQHysmC8T7cdvqSiCy2WjK6/9ilMR/h9muW31jeYuL7cF85EYOr9HtbEXSX1iK6hUKC8g5AoQerAj7PI+UA7brzDKi/Z0LH63dG8uQSjFJCg6TNSqbQoALGvan0a/u/ZG+7UTfsTkldJ6pfoSSsDOVdJREqMmoAr03+VzdOyYJuDQen/jRkMiEWSwlcy3VTrCwhuIlc8NKtOHkT0PFstYV50v/RvN2isVzIky7AFvP2jiOlPzdr+ho6BnlscuJzoGFKAqr8whvdXYD0cqijNrOd52qbjwZXxDqNbiKjZIe+cRCZDot7gyGTzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xgGkjw6mMRrZnoquaAIcR9CazXIcKedl5GRy2cf3Vs=;
 b=rMjF9To2FZsHuini344L0yhLWcwQVT4/m6iwLHY86lyz0gx4pXU9v3KN8VbwARravIsneY8b0G4pFyaO0vkc/NO3CUFK+jFYL2E5z0vLpCj6Bzo1sGDBNfU9QfLCiOx3yndX5qAXac8FRivvZNKoP6LihFkgYEWqOlrSRknPQnF+3af3D6Hgzi6qEMCiq1ieWPXuuKi3sInctnsT+85yV28NJtijIDHUcq5f8xmJRq759vZpNlDkCsErVoa9H8BSU9dSVmKKok/Fjmj0N5J2+N6AVPRHzltDljkDOb53b4koeDXkN9vmJuOZxsO7Num96NPUPP163boqGGRq/nRYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9013.namprd11.prod.outlook.com (2603:10b6:208:57c::9)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 08:43:56 +0000
Received: from IA3PR11MB9013.namprd11.prod.outlook.com
 ([fe80::112f:20be:82b3:8563]) by IA3PR11MB9013.namprd11.prod.outlook.com
 ([fe80::112f:20be:82b3:8563%5]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 08:43:56 +0000
Message-ID: <44dcb672-8220-48c8-86bb-007da8d2ca5e@intel.com>
Date: Sun, 2 Nov 2025 10:43:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 2/3] igc: expose RSS key via
 ethtool get_rxfh
To: Simon Horman <horms@kernel.org>, Kohei Enju <enjuk@amazon.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <kohei.enju@gmail.com>
References: <20251025150136.47618-1-enjuk@amazon.com>
 <20251025150136.47618-3-enjuk@amazon.com> <aQEHjPudkOSpk248@horms.kernel.org>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <aQEHjPudkOSpk248@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To IA3PR11MB9013.namprd11.prod.outlook.com
 (2603:10b6:208:57c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9013:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: b59d96ae-8745-4e60-f7c3-08de19ebf56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXIxN2dCQmxCRDgxb2FMYWliZ1A2L1oxTzg4ZmxxUEZPaUd5OUpOdUVvMWNh?=
 =?utf-8?B?dWhvUzE0OXNqdXJiZlZFWHlvUDd6bk01ZUZwSVdBbGJlVVUwazhacHFlaUVm?=
 =?utf-8?B?d09OTmkzM0lBdlBrMTM3RUFhU2VBeDBnZ1lqOEQzTXNOOUN4MVVuVnRTOGJx?=
 =?utf-8?B?N0Y4dFZ6cmxEc2V5TEJaTWNlckFEQjRzRkp5YUVBQjgzVVZzQ3RIb0dQRWV2?=
 =?utf-8?B?TGJSUTZCVHByNW9WZnhKZ1pMZ3l2OTJGZ3hYeFMzVkJhQmxPVGhLMlIrbGQ5?=
 =?utf-8?B?cTBDVHRXTVR0QUZySGdyTUhiMUhOZjM4ejNzdnVlUzdGNnhBbkk4WlkxQTZY?=
 =?utf-8?B?SWdkRnVzbGZSWFByYmNGNjFaejBVYld2dVcrR1haWGVYanBFS0ZDdDZ1dWZH?=
 =?utf-8?B?bkRLTjFrZmgzQkpvb3NEV1V5QWdqTUZvdzNlWE9tdFJHZnlkU3N5NUlGY0FG?=
 =?utf-8?B?NGt1Nzk2OUdpeUErdUdCbzZWZ0RyR2FEN1o4cU1FUE9NaTRBWUdSZHM0N1VY?=
 =?utf-8?B?ZDZ5WnREYWUrbUN4c0k2Zy9sZ2NqMGQxSlk0WCtQcDdsSWFwMHpzS1EzQzlh?=
 =?utf-8?B?YmpEVXhyaVZSalEvOGFHYkloQW5VY2RTVGtWUFhwQmFDallQaEtXaC9Ebkha?=
 =?utf-8?B?TWlWVDZyYTVVdlI5MlhuOFlIYytFdWF0b3Iza29QT3FRR2VqdDVtNitobHk1?=
 =?utf-8?B?SDVueUtNOExIdUVHaEdBMVVuV2NmanovdXo1VU9RSzVpNy9pdFE4S2lDTTl0?=
 =?utf-8?B?WDZxLzkza3BNTUw4aGRLYVdXcWlXNVBEU2lkYTV5NFhuWWRaVUpnMXZXRXh5?=
 =?utf-8?B?YWZVU3BRb1ZFR3BNVVVuazh6V0ZtbEpacjUvSzBMT3hjRWlkeXFYYXpDaUxh?=
 =?utf-8?B?ZXVzZkF1UWJPcEdOYThPdW1IRWtONHppQUFJYWtMWlpwYy9TU2ZuWWJVRVc4?=
 =?utf-8?B?UGxSUi8xNGgxVzdYVlhjbTdGZFY2STJFN0pRTmlsb2lYUlpyVTgxM3d2VXpE?=
 =?utf-8?B?THhrK0hpKysrU1R0VEp3TC9NZ1Iyc2F5b3RHa2JRTDdPeTN4RTFZU3RiN3Vw?=
 =?utf-8?B?Tk1PMmZ0d3J1RW5PNThRbTJ0MXlrZlp3VGxpOU04b2Exdi9DSUkyb0NSdE5M?=
 =?utf-8?B?V1M1SFV0d25aU1pGSFVvcFc1UzBWdTk3UEgvQWpZd0NLei9TeFZYT2UvWS9R?=
 =?utf-8?B?Tk1GeWV3QzBNREMyZWZnK0RRWllFbDlUQjdBY0dKUEJjSmtKZm9aSnhWNDM0?=
 =?utf-8?B?MGF4SXM5K0E2UmEyazI4Y3lLbm8xbGFIY1VNMnBZRkJIZ0tDUTN0QVg2MC9D?=
 =?utf-8?B?UkdaU1kva2JWTytOc2xKVm52RUVvRGM1eGVlVlhDYThocTVGUEVKb1RhUGdR?=
 =?utf-8?B?eGwxdE53Y0ZaR0NGMXNpTjdMRnJYWmJTNzdXZW1LVC9SN1JlQ3YwclA1TnJu?=
 =?utf-8?B?S0JBOG5Xa3hsdFVzRHd2MkgvMk0vYjcwelVjVzJieE83dm5SQURyU0REQVR1?=
 =?utf-8?B?SkU5bXk0VS9IN1Jsc0lObnpIYTJtNU14alVQK3E3MXVkcnAxc3Y0SmxUeG5N?=
 =?utf-8?B?STkzMXNWZlhsTEVHeVhsMGpmQVl1RlNyTG1DcGVRaFdzRmFhZjg1RHNHd3Nq?=
 =?utf-8?B?enI5dHJDWmNrbmFyK2Z2bURXT0Y5ZDVUMHZYSEttRm1idzdMMFVFNlFyTSta?=
 =?utf-8?B?eXo0bnZzRDhPY3RCTXFEUWk2TU1aRUxpSkhENDVqdmxDZjNHZ2VhWmt1QjBG?=
 =?utf-8?B?cWYvWVNxZUdkZE84MUlzRHBjZHpFeXlkSDdqd1VxblBHMDBCVnNSZmFtV0Jj?=
 =?utf-8?B?MHlzNEdIQWI3SzZnb2lvK2hnK05WOTNHYTF6TTVQcnphRmpUWnN4T2hoOEZ3?=
 =?utf-8?B?VUVnNFl0TmY3NGJVRU5tNVd3RlZGazJidTNhVFU5ZnZmNVdZMUN2VkVLSEFP?=
 =?utf-8?Q?tXwAbmAld3hT78yEq+N00c5IDMU28BsE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0N6R3ZDZ1BBVkg2WWk2ZmJ3ZUJTaEtldDdPL2VVZVFxb2NZVFBrZFl5c2l0?=
 =?utf-8?B?eW5nbDVvQlVKcHl2ZmpsRUxmN2xNRWVqcU5MUXQrc3Q2bkV5d3VwNlpHalNP?=
 =?utf-8?B?bFlVeVl3bTg0a3BBREpNbjdBbzZmeVhYKzRZOWJsWVp5NnlkbHBDN3A5UFdu?=
 =?utf-8?B?WFc1V2lGS3g3UXgraXMxS2tVcEpNOE1GcDhPRXUxVy93QVNWeWJxU0kyNzFm?=
 =?utf-8?B?TTU2N2VQWml5SFgxc0RiT3NmTTZKdlFhUGJCa3FqY3pUOGdjZGw2YklraVEw?=
 =?utf-8?B?c3Nyb2tUaDc2MUpKYThJdHVGRXV1NHFNQlhhaTZXbVRSbTZuSGZ5RjhxbkE4?=
 =?utf-8?B?SWh4WXNZc0RSZldnS0p4RWlUcEZhaCsxVzdQbFJiNjU3dTVST3BGYnVuWSs1?=
 =?utf-8?B?dVZIWEdHbTcvbEZ0VE9NeVozZldML0dZTHN0TFVNWjE2STNuQXNiVGRrUzB6?=
 =?utf-8?B?cDNyK0V3V1E3QzZwS1BJNG1DZlRXT3l3YWU5Uzc5VGJhYXhFWi9Rb29yMWUw?=
 =?utf-8?B?dFdGSWJPTXcwdHV4ejhNRHZqdTlxdjYySHY0d3dpTEhKMis2bnVDUExjTlk2?=
 =?utf-8?B?dGRqaXp4K2syVGRDZEUzck1qYzR3MG5nZ0U2TWw5dmhzakZGN2IyMitMNTVu?=
 =?utf-8?B?ZnZXWU9sSDJBWkR2VHhmWU5FMlZVT0lRbjllUWcySXUvbGZRbGFGc2NCRUE0?=
 =?utf-8?B?cFlQMmJDY0lUZWlNVGoyeTEwMEZ3SXpyc3Z6eVhKVUxwZkRmOWNjWGp6QWJ0?=
 =?utf-8?B?bnVxdmVHMXliU3NMZ3FWQWlwWG0wVFBYY1AzZU5kVVlFRFBoL0crNnMzcThw?=
 =?utf-8?B?TUszOHBvaXIxa2pzbUVuQUxCNUVvSVZ3bmNkVktoVnlEOWpBbG8xVmtEOUhG?=
 =?utf-8?B?UDJQV0RMWmJqbU9PdWlJZCs3YXIxWUdGVkVORlJrcEkyK1UxaktyOVk3OEp1?=
 =?utf-8?B?Z1IwQm15UGZRRTNZdndJbUR0cjNOd3Y4bks2bEVhOWdHNXhFT2ZROVIrZk9H?=
 =?utf-8?B?OHNld3pnQzl0TUZQbHYwRTJXWmQ2S2FacUcrcm93d1lnditnNVpsZmlxNFdF?=
 =?utf-8?B?UjNvbTl6ZEVaRjAwd2wrZEp3eFN2SVVKSzNBd012TjVaN3NwYzUwU2xQOGNy?=
 =?utf-8?B?UEtXcHJzWnhZR1k0LzJFS0l3YnZQRjVzSlhRNERtZGoxTHJDK3g0VFU4L0pL?=
 =?utf-8?B?WG9vcnRyNDZZZHZiYVhxMW9QNlBNZXZzRlg1Nmp2cjFZL3FhMjY0UmgyV2Vk?=
 =?utf-8?B?VUtBdEx4MHdwR3ZqbnJua3hZZ2kvNHQzZE9HUmp6RTRobVo5Y1NYR1ZFWkxS?=
 =?utf-8?B?dFN3VnFYdXdpTFFSWEZmRFQxS3JHMlpSRlNvNHltcm5BYS9jKzc2VFQwaVRG?=
 =?utf-8?B?aHZBcU91ZzVpcVd3MTFyWHN1Z3B5NDNGaktsanJoN1lUMzBsLzROeVo3cjRk?=
 =?utf-8?B?bnhtRlRqQnF4cVVwMk02ejJQMTE5TlIwVzlWRytGcm5SNEw3TXNGMElnUXhL?=
 =?utf-8?B?Z1Z6eWkvdnBuL0dDdHFOUUlWWUpQNTh5MXNCUnBCdUhiYkk4STVTc1Z4di9j?=
 =?utf-8?B?ajhxT3Q4RmI0M0l3aFF0OVRsTElwY01iQmsveE5kd1pOV3Q5cEkrcUxhNGF1?=
 =?utf-8?B?Tms2SzJTRkxRQWwwckNBdVVYV0hMY0dNMlUvMzJXdUFidE1NQnczVGxnR2VI?=
 =?utf-8?B?Rk9zVUtPL1ZQNE1rVGxjRzB0OVlQZ2swdTR1UnloekQ2a0hmVnhQNHlhV2pi?=
 =?utf-8?B?RFRtZlNDNEpVbGNCTi9UZVQycXNPRFVVNDRPVG5CbkxuSGlkeWdJSXp0NmZZ?=
 =?utf-8?B?OWxXWXliREo0ZEtKeDlzTnlUR2ppUVpMOEw0V1FCQ1FvSjAyT2pkcHBzQVhx?=
 =?utf-8?B?UUJBN1NWRWtIUHJzZXRDVU5FMEM1U09OSkZwVys0OFpKUjdpVkY0R214a3Z3?=
 =?utf-8?B?NVM4OWQ0UStLSFdPbXlRNHlkVzd0cVBFQ3FvbFFCNGxiZTRWYm1jV08rc1BY?=
 =?utf-8?B?aEpqY2pLTDVpRmhNeHlVZ1NyYTBqNWhnQ2kyRXY4NHlDdWFSejRxM0M3NmZZ?=
 =?utf-8?B?eXhETHhpVmgxeFgyOS9rM3lqTDJBN3JEWUxxZnhNUlJvNnNvWWRqMVFGS1RD?=
 =?utf-8?B?dmNtSFR1bGpDM042QnhuZmhteUJ4RTUzL1hYdVM0RHZhUVBnWWVuKzNnaVVq?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b59d96ae-8745-4e60-f7c3-08de19ebf56f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 08:43:56.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRG52eD/VIFc97mBNRQ1rvHhvW8jqlCZPMKgO7kI8R3y9jaA3yYzJpn2lnrkGIkRxxXB/0bD7OIQzlH9gnj8m2PLr2XkQ+AEekO/vEF2iG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com

On 10/28/2025 8:12 PM, Simon Horman wrote:
> On Sun, Oct 26, 2025 at 12:01:31AM +0900, Kohei Enju wrote:
>> Implement igc_ethtool_get_rxfh_key_size() and extend
>> igc_ethtool_get_rxfh() to return the RSS key to userspace.
>>
>> This can be tested using `ethtool -x <dev>`.
>>
>> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

