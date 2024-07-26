Return-Path: <netdev+bounces-113315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE3C93DB1E
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 01:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F91C2316C
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35AC14A09F;
	Fri, 26 Jul 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOEs8Axe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5581494DB
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722035793; cv=fail; b=JbMdnos5NBYO1vUgBhCRE7oA6QAFxfiDV77vgCEOQPu+UkfYtwWSUDXLRbnKrVbcQaJqlzX9U/FDz6kcBxZpal4YHf2iaY9ZT1YbvnJZhd/TCDbxyLr2FLBysjO6NlycEjnulBO0XQFn90UplzJm2IZjqKLGu8/ZXkc2aWBzIdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722035793; c=relaxed/simple;
	bh=zPkuCArKGguMPOPR8xFjsQ/h1ZiwHNXADx+EH1c+Cpc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hsH31Pvd8Z1BJtjo0koNUAY1uHrXSjwa4BWYDfKyyAPr/QgBzCOUWLHkFuNg+G2uGXhcA9WuemXHPkEUYdujiC8mzZuMVu7Sp3WP9MzlnfrCIkR9f9VAX+GMGXVbjlezP4yOmgsb/i37roRqFbEVrxrpecanlZc6C2Xuema4vUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOEs8Axe; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722035791; x=1753571791;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zPkuCArKGguMPOPR8xFjsQ/h1ZiwHNXADx+EH1c+Cpc=;
  b=fOEs8Axeljd16jKWSi/nQc5neCktTvHsYXSTrnU/OTFgl+8i1X9ZpY2v
   yxd0cHkvvVZPYi4pU2Ie5FrIWLPE4vGQjwKIRgpTEp+IiTRq2DaNE8a9G
   ynExysF42qC7aYk68ZpJKYYmGNfzqCrxWNilDT/1SMyDfjA1yBtRVzImZ
   AcuFxQZ02wbsh8kkW6pC7LR/P9DLXkT3COpTZJrOqXmYj0k8/5aAoDXX8
   umxEqYdrfH78LZ3ckDS3+dcLmQ1lHQTvqQVHcgagj6R4CPeleJqQignA0
   /KyXNkBN/CZriVo9/reGm6wXvMVwRzKzKGgNpXFD9yTNbuL7zPaiKFJyV
   g==;
X-CSE-ConnectionGUID: KVQCSUTdSlKcVsYm8Yfk1w==
X-CSE-MsgGUID: 6Uj2Zv2cQj6eiGiT0YKPOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="19989618"
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="19989618"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 16:16:31 -0700
X-CSE-ConnectionGUID: ixA3IfOUT4ybGN/PAPHBvQ==
X-CSE-MsgGUID: lwkpJPyBRvitkHDO44BZ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="90859575"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jul 2024 16:16:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 16:16:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 16:16:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 26 Jul 2024 16:16:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 16:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6BQ924vVRaFfNX6QwHQA2+dxLsUDRI2voaUlVSUiDbe8s8WRo/WWbBMxQ54x4ZGmiM6cvu6esUhxIUHMo9pfO72/j2UKEUqy/YKK6O/W1tkkySkZHv/bnybhj/as9/txZl0iNRZWOd5YVSeFMcvTXRsJiySW1iLc/zxg2WKIH0FN3FP4kilqs1rqJeEo1Z9J2tOKLdyOL3kwBzAw68UF/2kcMGsSMxHxvzW+H5KkFIBY24fTSuvMRVBhn+JmgnoOsXt6MZEuNlDvCXPE2/TZGxvzKsXKuPNJcJv2vzgf2D9TDY2DDP6TEtVUQIwMbShH/FmK4pj5MGS7TS2atS4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBA9VM3MVgLwP9tIdurktXfhDKlrejwQUYTh8Zs6vdM=;
 b=LRfnYKFdxD5Ggo/w+F825GD0jgBQIPVCrC+Uvut8WVKn1sN4g43iT/mgXPX/ms268ZhRBT9hFe5LFpgZdavtWxqmThF+rrlc1mpuXLdTZAVe5Pfsxwp6e66/7VWseE9zYhsR5ZIqIPi5SWLd6mixv4rb7Dv2j/7Ca0yjuDGULcCNnoFpHg0kZMBwTmtKxDBUEBlRROWNX0389rvB9nr7mImugbWdGm5tQ34Y4w64GqjLNzdq+ax//Qo09d5YxbpukTsu03ndptbF8bPmCyNL5HhZfbGKOb3Z33zAm2aVTyCnYp/mZYNk7gTmbpJllLDsf59lYF5K5wkKshH8berSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 23:16:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 23:16:23 +0000
Message-ID: <68ddd3e9-e8de-48d8-9d32-7de6a18bf245@intel.com>
Date: Fri, 26 Jul 2024 16:16:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-next 4/4] ice: combine cross
 timestamp functions for E82x and E830
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>
References: <20240725093932.54856-6-karol.kolacinski@intel.com>
 <20240725093932.54856-10-karol.kolacinski@intel.com>
 <ad94e165-ea7f-4216-b43d-b035c443a914@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ad94e165-ea7f-4216-b43d-b035c443a914@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:303:85::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: e49f44c7-0018-4b3d-4222-08dcadc8f701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTZIQmREazI0d3B5N3FOTzlnZHM5cXB5YmtEN05ZRVB4UEJtTWthQlNXY3hK?=
 =?utf-8?B?MTlDaEZBWUNSZWRmemVFM2JyeUQ2VHJ5a25uSFJaR0VKUzlzK1FlaFN1MFZJ?=
 =?utf-8?B?Ti9CUG5FblhCRk5Ed0xJRGp3RG8yWXd0RHVydjFVL2ZaZE9rK0l5aUJNT0Vv?=
 =?utf-8?B?TEZDdVpYU1VjUFhER0RWdlRmY0doNkt3VHgxL0drbHJ2R3lqSGRNTGRUUWVL?=
 =?utf-8?B?Qm9wKzh4eVkveEFwYUV4RU5vM2hkekpFKzc0anUxQUlCWjJJbUN4UDdwWERL?=
 =?utf-8?B?YkhxZjVLL1ZoRkZWRUY5WmhqMmd3Rk1PUTJtZEUybHVKK2ZlQi9qeFIzYzBF?=
 =?utf-8?B?bVduQWtUcTZwMEsvZ0ZoYUpQbVBYQnpkQVllRmYvdGRKNTNQN1dmVzhwTTZ4?=
 =?utf-8?B?eWRTektIbXRxTFcvbVNZNXF2WGJOaVpSOFlkTUpNUTVCOXMveUU0OXNvNytQ?=
 =?utf-8?B?RUJydjMzZENXZzlHaXlpTmxxK0ZtcVNKZFUvU1BxNml5L2Z1NnNkRnI0d01w?=
 =?utf-8?B?cWVjS0MyclljUWltTklpbFEyaFRYKzYwQTNRQTlzRXpVYm5COCtFU3lGd0FQ?=
 =?utf-8?B?Z2k2RVVZUmJiL0R0d0RLTXpiUnM2U3ZlNm1jQ01TZE5IQk9PS3h3cnlpanNN?=
 =?utf-8?B?RjI2Q2VtL3ZUT094RmQ4eDNYRUl0cDVUQVNhSjNyeHRMNms5MmZWTDVCV1JP?=
 =?utf-8?B?V3ZCZjdmOVAya2N5UTAvcVNxL0ZMWG9ZbnpIUkowTEFOTnVhakwxU2VLbWVv?=
 =?utf-8?B?NTJoYzlEdms0VnhheG5aMmdwZFluNWZITW1yd2FvWFNQc2VjL2dWZXRsSnho?=
 =?utf-8?B?ek9QblhkMTJVaUtSM3ZYMDhHdUVMTVAraThJandJREFIY29WUHljdEVPWlZ6?=
 =?utf-8?B?dVhPT2VQWFlaL2RWUUxWcFJqSUpzQ1BUazBoeXhFMlFLM2VGdDdZa0loTDl0?=
 =?utf-8?B?ZWxkRFAydEUzckhEb2NjQnkyeS9hK1UrejBCQ2tiVFNzVW52WXo5c2lPeVhO?=
 =?utf-8?B?dUFPaXZEWWkwdWJRd1pXdU9xUE9WNkhjUm5lbzVFSE9GUUNReHY3WlZqYzd5?=
 =?utf-8?B?djlpa0pHUEgycm1MYzk2UjdabDNLZUtvNGZidzZaSlBoRTdZNVltQURXZkZh?=
 =?utf-8?B?ZWUwdE5lb0hZN0tPL2VkUENhNDZGUE5QTEJVdndjMmVFbXJCYlFlRmwrWkZ3?=
 =?utf-8?B?dW9vRTBnNGZWQ0hqekQzaWJ2Q3RzZThUREdmWFppNUdIZS9LSTVsS1lpKzhO?=
 =?utf-8?B?U25XaW9abFovN0wwcCtSZHp0d3pxbEV2MEVWMWVKSkVxMTYvQk90WUQ3VUhO?=
 =?utf-8?B?RmIyVUtOQ2wvMGRRQUtFSzIvQzYxUWNkSmU2TVlmYitpM3kxdTRnT0tORnJJ?=
 =?utf-8?B?eStOL2tadmNzTHljT1M5aHpYQS9sOFN3THF5NW9pdWI1OW9mbWRmWnp3R2Vl?=
 =?utf-8?B?QlBWY1gzb1ZaSWFMbmQyblpDdWpVT09XUGxtRHd1cHdrK2RjMk5ZNFZ3dm5s?=
 =?utf-8?B?SHV4Z0YvNXVjMVdIbjdYaGJYM0k1NDRxcVkva2p2VW5sNkl2Mm1sQTBjTWRr?=
 =?utf-8?B?UUpjQ1lDNWUxcGNrSytmdzZsbVpIT2trTC9mTzVuZ1EwdG1XNUNHZ2ZoMzc4?=
 =?utf-8?B?R2NkdVlodXN1Wm5XMGNkcjNPczR5dllrdEtwSDc2V2J0bFloWmpabTBYdk01?=
 =?utf-8?B?YmtHSGxjR1pLelN5blhUNUovMnh6a2NwLzBaRThub1RtTU5SRHNCalArMGhi?=
 =?utf-8?B?SVJXaTA2bFprVmtWQXhKa3d2V3M2aEtkNkdRaWg4Z3lXbzUwTlZPOUo0dWxJ?=
 =?utf-8?B?R24zYk1XeFY0djYrL2tzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlwV1FaM1JPeVVBMWVFcElqajlxcS9XUnVta1UwQjhIbmxJZ21rM01lbHo1?=
 =?utf-8?B?OXd3K2hwMXd3TnlNZ1d5YlhIblRiVWNDbzQ3UnlLM3JqVGZ6cFM2NGd2Z01J?=
 =?utf-8?B?VCtpeEU4WGRMbHlrbmJvbGY3dTFWQ1dhSndTUE4rY1VhcFQ2S1haSzRWSEpC?=
 =?utf-8?B?ZjdIMG5jR0p3dEZxOGxTbjVsSzhYbFJIS2JUV2pZbnVsQ0UwZFU5QXU4d25W?=
 =?utf-8?B?VjNIYmx4bWV5NDg1Qjd3SGRnOGMyUi9qZkhWOTdOMkJuSXRiVFdPN3c5OVZv?=
 =?utf-8?B?V2JYcENsdXRkdzI3Si9VOTF6MUFoRGRMWmRsWUFwdEF4dForUXRHRmNRMWZQ?=
 =?utf-8?B?dm9IdkJuMjBISzlUQjAydEdlK1ZwREVSUkNDMDNRQVZaNVVadmIyNzZKZmd3?=
 =?utf-8?B?NHZUYzZpeU5EM09HSUFBNlh4S0x1b0NaVXRNZDR4UENjV3U2UHhNU29wWjMv?=
 =?utf-8?B?VEJRYXo5QnRzQS90WEtCK2ljK2hZbXhiU0loWVV6UEh1L2FnbVQxNWRIVlcy?=
 =?utf-8?B?Y09JZnQ5S3l6WklrZS9iRnZKS1R4alRkVUpkdFlleWU2SHlVVVNkREZnWTZV?=
 =?utf-8?B?eEcxdlRyb2FTR3FDTUhGYWpyTGNkMjVYdHkvck9FK2U0bkhERzVwUnQ2MXkr?=
 =?utf-8?B?TWZ4Q21aR1NZWkY1UjFXd1RHY2tRSU0wZnNDY3B6dEJzTkJRNkswTVJnWlk0?=
 =?utf-8?B?a0EybXlrUFZUUU10TTVhMlRsUFk2ODlGblJjaU5PL3dsRnc3WkticFptajRU?=
 =?utf-8?B?S3JzUlpGZTNMYUhFNG9GWnlmam1JcklzMkNnWGxMTjF0M2xYWUlnVEpTdGFq?=
 =?utf-8?B?NDcrV0JoQ1ZIc2hlRTYyL3pIZGc1SXBNYVZNOTRUL2F1VCttSE1vUnlrTUFx?=
 =?utf-8?B?VHIrb3Y5c1ovcTNKVlZkaFJqMTgxM05oZ3pXR1RNS1htS0FWL3VkWTNQenhv?=
 =?utf-8?B?OUQ3T1QyZmE1ZkJYaTdZU0FUKzVhaVUzdmV3eFRGLzd0SXllNjVxQzdaZE9T?=
 =?utf-8?B?eVdUZjZsbGVkMmcxbjV6czVROGEzYXJEYXRocURwVzMwTExJS0ZjU3dQSVk4?=
 =?utf-8?B?ckZQZXRxUkpxVHVDcHBTTm5DU21JWlpZcGE1TmxSZUkzZ0xSY2srUjhGY0pm?=
 =?utf-8?B?NHMyM0hwZ2RsRWNxSjV3aDlSUlR0anAyOGNObkFwZGRSMDB6eEdqa05UdTZy?=
 =?utf-8?B?bDE1RDI0UDZXL21FMWxQKytOZjdoRFh2Mit0MnkrSlhBZVg4Y0hNc1BCY2NK?=
 =?utf-8?B?VEFUeHZzQ1pkQnhkNjdGMVpscnIzR0Q3U011YXhLWXVlYlFtWWFYVkVxV1dB?=
 =?utf-8?B?ZXFnbTJXcTV3d2ZGZlpCcSsyb0c1Qy9PcGpHZXRLNEFuQjROcHRRcmJwVGky?=
 =?utf-8?B?WUJQTG1zMGRlZCtJMzI4TFhkd2NsSnNqQXVuMm1FUVVkbmtZcXVPOU5vdUp4?=
 =?utf-8?B?MS9Sb2tmai92REVNYTFZUHlDanJKczZWOGh2U0JvVTRtMjRRVFRVZlBuaHR5?=
 =?utf-8?B?VVJmVVhHMTJSS2p6N1Bvc0NnMmYzYytEVzVBNmJkaURYRTJPczdVUjhaRkR3?=
 =?utf-8?B?amUrRUU5aTBGTXl2blZUNmE1Rkt6c0ZSZlJmMXdWd2djUStESU1HNVhJNFg0?=
 =?utf-8?B?ZGtYOTQ1UWUyb21WanZ4TTdxMjZuUGpCL0EyNGhIMGEycWk0dEplNVpOZ3FD?=
 =?utf-8?B?NmFqOTlSSVIxbmM0b2g5TUxIeEY5eldXWU5TSlRyZkZIOHpyOG9GUDg2ZGhx?=
 =?utf-8?B?eGtkUUwwVVRsaSsranZDbWhON3dlc3gyMnNDY1RObkYybGpGZTV5RmplbHhX?=
 =?utf-8?B?Y2Z6MHNDbmVXYmE5S2ZiVlNvVkl1RitrNzN3S3JlL1E5ZEJ4bmtkMW5MaUlF?=
 =?utf-8?B?STFrNVhmT3RFRHdJMVc1Rjh6enY1R2Jrd0RPUkRnMk13a0hkOTVLUFlUVzB3?=
 =?utf-8?B?d1NhVzZTUHBvT0Mra2szMkVtd0tpRm9uS2dsM213bmYrSk4vY0VlTWdQNzhi?=
 =?utf-8?B?TzM4RllCdFdpbC8vVThvRm1qdWxMb0lUR0tTSWFWTHo5OTdBZU9SanFuTnZL?=
 =?utf-8?B?aGlFRXZmVXhTTWw3RWpMV05NVE9XbDZBSnE0N215ai9RZThYY2t1SzBWNllS?=
 =?utf-8?B?SVdJNjRNdnRrS2ZsSm9SVDRLU0NBRUM5K2NEd3FwM2VSM2JwMVZRd2p2RTZo?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e49f44c7-0018-4b3d-4222-08dcadc8f701
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 23:16:23.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: af3QAek+crK0QhS5d6G9T7YIxhI0BTVk1WFz/wBaascn+mpmiF9zzgS2IH0uWGLR7HsG3FjoeeBTVR/qgtkYheil3vyoNWlPPboCG5jA8HI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-OriginatorOrg: intel.com



On 7/26/2024 6:37 AM, Alexander Lobakin wrote:
>> diff --git a/drivers/net/ethernet/intel/ice/ice_osdep.h b/drivers/net/ethernet/intel/ice/ice_osdep.h
>> index a2562f04267f..c03ab0207e0a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_osdep.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
>> @@ -23,6 +23,9 @@
>>  #define wr64(a, reg, value)	writeq((value), ((a)->hw_addr + (reg)))
>>  #define rd64(a, reg)		readq((a)->hw_addr + (reg))
>>  
>> +#define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
>> +	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, addr)
>> +
>>  #define ice_flush(a)		rd32((a), GLGEN_STAT)
>>  #define ICE_M(m, s)		((m ## U) << (s))
>>  
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 9f0eff040a95..ac3944fec2d3 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /* Copyright (C) 2021, Intel Corporation. */
>>  
>> +#include <linux/iopoll.h>
> 
> read_poll_timeout() is used in osdep.h, but you include it here.
> You should either define rd32_poll_timeout() here instead of the header
> or move this include to osdep.h.
> 

Please move the include to ice_osdep.h, as there are some other places
where we will want to use rd32_poll_timeout (such as in ice_controlq.c,
and others).

Thanks,
Jake

