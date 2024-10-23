Return-Path: <netdev+bounces-138253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E49ACB80
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E3B1C20308
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4783B1B4F1C;
	Wed, 23 Oct 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyqO2E8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342081AAE02;
	Wed, 23 Oct 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691019; cv=fail; b=cYbbt9v5fXZyp/0yyNi/kTfx4H/hGdGk481BA9gW1bjwO1n/GxxOFvU48KgtSHfmte8q7wOAjrIY1bwiXz1XojFkBunet0ep+o0I5KRmke8rnBUSTMZ+16ZvWX34pkP/G8vDUn+7O9qAZpO3pg7xzv93Or1ly14C8RRrIQDvmCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691019; c=relaxed/simple;
	bh=n99cYmTgEm6ZMJapNRWqy3H0ZDzF28hoxLSX3kUlmHU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jbcwcJYlI9x1vRmh5F7NOkoUwirSCfl6s3rEHHHhcjuMbIwIXyQXBiABbcEGjW27ZVoUgW0dxCHroCFlhMvxsHkhN7klNUPXvuSiVi3sNa3ZnT9+gCQjFZE45WrquPnO++X8qZbfR1tZ2RMsr/i0F9vNIQ8grHv83arxmwT4A8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyqO2E8Y; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729691017; x=1761227017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n99cYmTgEm6ZMJapNRWqy3H0ZDzF28hoxLSX3kUlmHU=;
  b=jyqO2E8Ydfl5LAAHScMKGNP2Mhi8x8lJmiP29bCbZNVOvLn8yYEQTzlK
   3re9CZSSuXyhOxuWFeXaEPX0fTSeTwdT1BsBVTM935+lUVyRt1VqqTqq/
   NNY4dbDzWjx8HmgkDlh/A1RN6VKI+ysTNZxFaHV6lz+UfZrN0JyKBPawj
   s2oY6/b0mNGY/KCs600O7G2rIcIXJJYRtCJQ6lKe4+X+ytS/5PNIhnBZ0
   FYWupV3jxpAoetmIRmH8GKdaGNOr0WfgYoK7jlnfhhM0f/2unp3HLlhL7
   A56KbQMV874tj4Yi5hh3wYBqj9oE1BRfZ2q/N4iilONvTz0V+iEcyH4Ru
   g==;
X-CSE-ConnectionGUID: fVXg4esTTYe6Js/rYyIw9w==
X-CSE-MsgGUID: O3rgNyObSOuBsYo4ERdf3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28716431"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="28716431"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:43:36 -0700
X-CSE-ConnectionGUID: kxfT62m7RIStIvNCCYSRJg==
X-CSE-MsgGUID: YbWEUth4R76c9XrJS2CT6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="79779096"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 06:43:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 06:43:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 06:43:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 06:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi6np0aUfDCvMMHDm9CU0/sYfk+KWZlu48lhg2mNKc0Ap4pBvcEac78+DO1riWIQVmYhp3p0GbiOb6RticJh2fAOb9WtXtRHxftY11G5H127pUCdH8CFoNn0ALu65ToCBj4exM0fney1JPJbppVZrPZKRpDERmsZLls9o//lvzKWBq6O2zJps7al70AM6eFe9Td6euQRjijQhku69eZGupkXNZ7AfwbPxdXF7u14oug9JC/L9VIAY0+e7cp0veTBHde/ZbO1s81wRRzw8bEiyO7fHSQRKsaNfjXx+gdmIUfkY4Q6tefIzg8wTVvnbyJM/2Om6i8SmkEbU4EoRaNvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI8jZnS4XIaLjeojsJKNI0oKYLcTDXuMJXN7yZ66vVQ=;
 b=BHbmwLTSIa7mm0oWuEEuSS/X/egKa57iEswlQ2HxCN+P81BZNfd/loiORMijoey20aw4uNGScCZTn6t+t3wqIgAPtxdogXtMh2+KzIsVbZC5OHEj4Cp+2u93//yEO1PZt2Oj+/UMfSSZUjdYBKdt8zXFxXB9dH0gq+hlzY4oIIb1O7mKPEeM//DXXDJa1Vlq86IAaGDqvD3fVmKAEUsaFz/83P50VjjuaGvAxfyv/SsjASyInLIDbtWG6+3Arr6hDAkArIF+9xizAvyy8UcZMObnv9h276JCXiFjRBzgvCrRkZapsUBTXb+H6Tv+L7bpoZyG+uT+NvLS6emHZHoNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 13:43:30 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 13:43:30 +0000
Message-ID: <a7eec76f-1fbc-4fef-9b6d-15b588eacecb@intel.com>
Date: Wed, 23 Oct 2024 15:43:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cleanup: adjust scoped_guard() macros to avoid
 potential warning
To: Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <amadeuszx.slawinski@linux.intel.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <keescook@chromium.org>,
	David Lechner <dlechner@baylibre.com>, Dan Carpenter <error27@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, kernel test robot <lkp@intel.com>
References: <20241011121535.28049-1-przemyslaw.kitszel@intel.com>
 <202410131151.SBnGQot0-lkp@intel.com>
 <20241018105054.GB36494@noisy.programming.kicks-ass.net>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241018105054.GB36494@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0102.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f5ae46-3673-42e6-6d42-08dcf368add7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eENXRnoyS084SmNvSjNnRnVRTjZLNkVDQmxEWVU0a1Y4Vk1Cb2R2dzdrbmhM?=
 =?utf-8?B?VVJwdTRqTnNQUkx2Sy82T0F3a0duK21YeERnamRBZUovc3ZkZzY3TTJFaGVv?=
 =?utf-8?B?Y0NFMnBtY3pTQnVJM0ppTmdXUHV4ZEhxWGVOM2FtaER4UElNSVd0REVibzZZ?=
 =?utf-8?B?VGp5ZE1xMFAxeHo1WXpLc0ZyOGpaR3JXZ0N1NnNlT1BlSHE0Z2FxZ2pORzBY?=
 =?utf-8?B?LzZDZUF1THZMcFFGQ2NMRGFVTkRENFl0R0F3VmUvOHU3NGdibkFvN25renRn?=
 =?utf-8?B?ME1TRmZYZjN2b1Z0a3IrNGs3Y0dIMkJMVkJwTkR3WEhUdmRPdGVnMnpacDNi?=
 =?utf-8?B?SG1VQ3cxckoyV3NzK2ZJVnVDa3RTd2lZQkVqNVhSRUorVFU2ZkpXbjN1YkNS?=
 =?utf-8?B?dU9PaWExcHlUYS9wUUJCTHVOMXRQTWhLcFpSU3NFZjZOQkhOMjNqSHRzRndl?=
 =?utf-8?B?NURuNHpmQzJKdTRxUGVtOHZ5UTUvNTBJUkxpUC9kNHg2WVdveVcrVFd1bkFh?=
 =?utf-8?B?L1lTTnBSY1ZvSTNHT0Vva08rZWt6aHRtNmNCd3VIZTh6ZWkrNGI4ekZ1U3c1?=
 =?utf-8?B?aUJIQmdqa0dWdlY2MUJGZXcwWEtOVTFFUUI5NXpJSFlTZUx0YkVubjhjdjBz?=
 =?utf-8?B?QnZoayt5MDdKRjI1OVRZREtDMVNOM2JjY0dZUERtL3lUTWdFc0N0aGo5cVQv?=
 =?utf-8?B?YXA4UnFEQW1GN1hPWm1DUUhkWHJYUzNZb3U4VDBjM3VQRC9GNHIyKy81dFJj?=
 =?utf-8?B?YmQwRElDL1RyZVJYK0N6cXB0ZUdIY0xrMDhTOFhtQUZYSU5hT01ySEtKZHhI?=
 =?utf-8?B?eW5KY2xOZVFqR3g3RkFpM0NZRzFiSm56NGZ0VDNxKzltcnNCOFB1QjVqeDVM?=
 =?utf-8?B?SzRLUEtUaFVndEw0Vm5wVXJMN1ZlU1FJMlBodWQwUk9wSm41UExxenZldmhY?=
 =?utf-8?B?ZG9EVTN4VUs3UDJYWnVTY05DUnhNRE1Ga2txbXZzZ1R3UTJ2RWNFazBPaDdq?=
 =?utf-8?B?UUNkSm5NdFh0WitPM2poazJrbWxVcHJLOTdCU3hNWDVRbzhKZGwweWJsTnhT?=
 =?utf-8?B?NzNWbGRMRlpwMkhXSUZnTzRYQVNsSXdKWlFRS0k3SDJqZ1FvNXNJa3hLMENE?=
 =?utf-8?B?d0pMY21BOGw4d3dia1VTZytudjFCLzVpYThjdGEza1BMdmROVWN6YngxbWxl?=
 =?utf-8?B?VDlweGdGL3djcngraEF1Q0dSTU5LRGNwcmY0WjMyc3NDOTVSc0FjL1paOEx0?=
 =?utf-8?B?Ry96OHVua29DQUpYL055Y2ZLeUpZVHpWeENVeDZQZkw5VWdDZDRSYkhWbW9D?=
 =?utf-8?B?aU9mTTNKSUl3cHBGbFZpTi91WG85QzA3NXZwRFNHcHZpTWZXYmsrOFFPckxN?=
 =?utf-8?B?RDR4Q0ZXb0Z5TEpNUUw1OU1adEt0Wms4QW53WTBuTWZpb2ZzeVFOQWh1R21F?=
 =?utf-8?B?M0JndUZiZ2ZoVFE0TFN5SmNMcCtqY0FkcUpyK0Q0MENoMUM1ekVOVlNaRHA0?=
 =?utf-8?B?WmNOQUdkS2RyQjF0SnJraG9TUVMzdlZ3dWF5NUZlWEZGZHVCNzdrUGFxbDUv?=
 =?utf-8?B?Y1BSNy81cmZqc1lBR3d5dytKRjNYOXFCMExmT0lpZ3planlmL25Kd2ZaTG03?=
 =?utf-8?B?N3ROUE1US0I2V1M4Z201ODdBdGRsSUVGbXQ0aEE4VmRNZDc0ZmNwaCtGQ3pW?=
 =?utf-8?B?OU5qY0Q0SmF0TzF0K3YrSkcwSVJtSXVidmdOZzA0R3M5T3VuamF6ZmFBL2lF?=
 =?utf-8?Q?HHdQvcU8GaQbRSJRHIyfymOkmP9KyanLDs1tBb0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRlTWlUVEI4RUY4Wk1wa2FWUTVRdTd2Y3FKVnM4TGYrZzU4OGRSSWVCZ0xO?=
 =?utf-8?B?U0U4eUZ5aXRTZEJONmF5N1FFREV2eWNDSmxoL1FjRGR2a0FCM0h0Z1NJTjBh?=
 =?utf-8?B?c25wejRNcFluOENLcThZSHU3VDBTRnZEcDJYd0xwUGxvNHdXSk0wUy95aE1V?=
 =?utf-8?B?SzA3TmZDRC9INDIzWm5hWGt0Tys4UlNBL1dqaTUyek8ycWZWWlJZTWhRVTg4?=
 =?utf-8?B?MHF6TW1xTm9Ja1NNakFzMjlPMzVqME1ZZkFYYjVUSitxYUNtdGdZSEkrL3Zv?=
 =?utf-8?B?K0NtK0tIVG83ckRsUm5nUXJrbDB1dHJFNWdvbVk1c0NkQXRzelJVOXZ2QS9M?=
 =?utf-8?B?VFZNTjdvcFE1emdKRjhLbkE3bm5zYjFmOU5GUVZDOW9xR0craFZmM1dubzQ5?=
 =?utf-8?B?WmRDTjNjL3ZwMFAyMG5Xb2t1cll0dTk2N3l1alhBSXpqU1h2Tkc5OVU1c3hB?=
 =?utf-8?B?UjMwNFpRNkEzY2x6UDlIRTJlazBLNW5hWFc5dlY1czB3cHltL2tVRlNHWGZk?=
 =?utf-8?B?eVI0bUFjRHVLMFh3T1dCZlBncXN5M0VkdzNGYWtrU1ZCbnZsTmRPYm5ySjBE?=
 =?utf-8?B?OUdobjBNU3RrK2lwY0RTWEpjeTVxVE9QczRya3dBeVowcTRaV1NFSzcybUdy?=
 =?utf-8?B?eFR5QXpOaXQ4ZVVOY1F2NjQ5RTUxMzcxNkNzMTNFNDh5RVpmRE15c3VmKzZF?=
 =?utf-8?B?VU50TXRhS1FxK2tWZmRrUzRmQ3UvQVoyVTk0bnUycE1NWllYd2JZWVlrUVpX?=
 =?utf-8?B?OGlRVTJ0MUhnOWRZMDcxeTZNZ2oxV21hLzdObGN4Vm1SZktlUVdKZUowMHlx?=
 =?utf-8?B?NUFLbDZTVFNzZG9NbGhReXVtNGw2eVBGNUdJUEhnNHBqUld1U0ZVSzRYY0dy?=
 =?utf-8?B?eEFiSDFiamJ5NmxJOEw3ckExdjZvNWZDU3hZM0lKR2FxMlNkMi9EeVZzQjR1?=
 =?utf-8?B?UkJFalJSaitBUkF5SmFVby94VzIvZGkwbTI3dHAyU25qMDNrdVZDQThHV2JH?=
 =?utf-8?B?QXlIVHF2VkV6M3E1WEFRTEMyNWQ2NE51Y3JSVHozTFU5cjdPMkRJOGpkc1Ri?=
 =?utf-8?B?Z1VxNGRoak80TGRUcUE0Q0JGMHVaalRlT2Y5blFlblR1VExwYVVyNWw4d01x?=
 =?utf-8?B?SlZxZTcxUUJKZW93L3BiNVZNMWpFU0JGMjFXaldYdkRlTU03a0VCSTBIaTcy?=
 =?utf-8?B?TW9aaWNHb2JBcVhVM3VGbU9mYkFJcU14ZHpNaEZuTUswS2FNVGc4cm4rR1lY?=
 =?utf-8?B?NjNIQStLZFkvSVhEWDRnZTRCejg0aDVFS3ZXaUxhdktYTzVCOEVqeWVMN0R5?=
 =?utf-8?B?NkIrL2cycEkrbFNZUktDU1A1TVQyL3o3WUJNSEczUG9vWUpuOHJkcldGL3Iy?=
 =?utf-8?B?TzRMTHcxTE5ZLy9kWEJib0lMK3pvblB3Nk85MzN1R29rNHBIWXBvTVZidmtJ?=
 =?utf-8?B?ZEpVVit2dGxTQ0Q3c3BuUTZMTVJZTG9FNllaVjJ5aTdXUzd1VlhBU2Y0QjlI?=
 =?utf-8?B?YjhxS1U0MmQxRktiQjVGaFVCS25zNUdFYXFmaXBiN3prcUpXYW5WcXkzQ0RV?=
 =?utf-8?B?U3VWeHNya1Q3WUxBOCtWL3NBTW1mNVd1bE5odTdBUmNneXRuME8vazc3eGxm?=
 =?utf-8?B?MDZ2amp2Rm9oNGZ4WUV5MElHSWJDY0ZlbDFxR1pmQVN6bTFCakMwckNOVUNv?=
 =?utf-8?B?dzZIR2c0TTdzamxVdTNTVitGZFFmbUtwaDB1N1NoOWdRemRiVXkyQVpzWXI1?=
 =?utf-8?B?VTRpQ0UwZ0ZFWVU5bzhSK3E2elZKZm5pY3lUMFN3NFcxTTVGZTlYaWF3cklB?=
 =?utf-8?B?aEpTV09mYm85bTBGZkZXZ0piOXhJMEZxOFRtTHQybTN3Uk5nQk81VytzZ0h6?=
 =?utf-8?B?VkhDOGcyMGR2RTRoYks2SGh4aTBqK3dEWUR0Y2p0WmNlM1BWaVZKUk43WERX?=
 =?utf-8?B?eVZ0MC8rSEpXTXlOdmM4VG5lMlNCb3Z0M1dVNVBFdXpYdXB4Mjh1aUdESFQ1?=
 =?utf-8?B?UVdCUFVoUnVyMXVrSHYyTitOSHlhbE0zalZTQ1BWWUVvR2UvanZXazdJUFcz?=
 =?utf-8?B?c0dCZ2JpOG5jQW5UdDVCSEV6QVN3QThMeTdFOGFET292eVY2UWdCeHVNWXlO?=
 =?utf-8?B?S0hiWE51QUowbENEN2w4Y2tFSUZXQ2NhYm9pTU1UU0psb2R1MGVXcHlxTHpq?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f5ae46-3673-42e6-6d42-08dcf368add7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:43:29.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGp3CMjEE4+1aEjPk73BckMBQg7lGIgddhvP+3zcAffkARpQ5bP3Z6z3A7R5yCaVy5+k0sGpzvhyWULqfsuhkpHe25/+vrvzz8F7mQ1v3L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-OriginatorOrg: intel.com

On 10/18/24 12:50, Peter Zijlstra wrote:
> On Sun, Oct 13, 2024 at 12:01:24PM +0800, kernel test robot wrote:
>>>> drivers/firewire/core-transaction.c:912:2: warning: variable 'handler' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>>       912 |         scoped_guard(rcu) {
>>           |         ^~~~~~~~~~~~~~~~~
>>     include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
>>       197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
>>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
>>       190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
>>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     include/linux/compiler.h:55:28: note: expanded from macro 'if'
>>        55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>>           |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
>>        57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>>           |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     drivers/firewire/core-transaction.c:921:7: note: uninitialized use occurs here
>>       921 |         if (!handler)
>>           |              ^~~~~~~
>>     include/linux/compiler.h:55:47: note: expanded from macro 'if'
>>        55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>>           |                                               ^~~~
>>     include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
>>        57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>>           |                                                    ^~~~
>>     drivers/firewire/core-transaction.c:912:2: note: remove the 'if' if its condition is always false
>>       912 |         scoped_guard(rcu) {
>>           |         ^
>>     include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
>>       197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
>>           |         ^
>>     include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
>>       190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
>>           |                 ^
>>     include/linux/compiler.h:55:23: note: expanded from macro 'if'
>>        55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>>           |                       ^
>>     drivers/firewire/core-transaction.c:903:36: note: initialize the variable 'handler' to silence this warning
>>       903 |         struct fw_address_handler *handler;
>>           |                                           ^
>>           |                                            = NULL
>>     1 warning generated.
> 
> So this goes away when we do:
> 
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -323,7 +323,7 @@ static __maybe_unused const bool class_#
>    */
>   #define __scoped_guard(_name, _fail, _label, args...)				\
>   	for (CLASS(_name, scope)(args);	true; ({ goto _label; }))		\
> -		if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {	\
> +		if (__is_cond_ptr(_name) && !__guard_ptr(_name)(&scope)) {	\

but this will purge the attempt to call __guard_ptr(), and thus newer
lock ;) good that there is at least some comment above

FTR, I have resolved this via v4
https://lore.kernel.org/netdev/20241018113823.171256-1-przemyslaw.kitszel@intel.com/T/

>   			_fail;							\
>   _label:										\
>   			break;							\


