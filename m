Return-Path: <netdev+bounces-114201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE93194152F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1251F248FE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2F1A2C18;
	Tue, 30 Jul 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMm2EMrT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52181A2540
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352352; cv=fail; b=YGpk5EW9cQ5PuiqwztkROGoVX0firDdSTktbFCx6DBw7NCTjfWIheYJ2t3aNbG87bQrfMpFysjqvs8Qah5piRYA+u9h7uZGE8AdlCh5J0FPKsbR1YzgBUjs7aJn7aIjlYaR1um1DXpxB5A08Xxlej6sOMnInwyNANFoP72mdeTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352352; c=relaxed/simple;
	bh=6AfnUR47kwAOO6LRmoBcxYPu7Ozv5HyiRKKIr7E9dTQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ECfcbMQbV1j8/s+Q/WJtcMIPwnrubgWvLpOHvI7pPDLI8e/hIXqDi1u8Zq9hPwKc3dxtdpLZ1hhP9NldhGfO3NRKT6xVSt04F3FmiD6v2DqE2ekMRUkjYR4kbWCc6ala1QYRbo+3KuXfqS9M0+F3y+lg0bZWxIYVJPRc82uNhrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMm2EMrT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722352349; x=1753888349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6AfnUR47kwAOO6LRmoBcxYPu7Ozv5HyiRKKIr7E9dTQ=;
  b=ZMm2EMrTOL274wjWyRxRH28aIPaIeXhbAOZigpjjKdxQn83O0hX0uwKg
   CpVsq0tOQbqUKzmYbnMkBfZ9DUhA94U0/sxBzzz4Kio86RUffenqJsj1J
   lvxED0JBpDmS1Njz6yQXrHjMU111P8Ztx9N0zqMjuOIDGwGrfUyVUgINi
   uMIcutW1bo9IfTMIQAZhTxwTkb6eaXmkBl7oHHPPqLy+LikWq+1OmCTny
   DStCGpvAXSm0YoMPxyqI0eCDeg2LfIx4/WY6vnG29SvkysQpSQKVOaRSW
   rt2oZg0zCiLmon5GvXY9a7r5JSQHKvlxVVhuRh+gm5rA3l37SAySsJ7Mx
   A==;
X-CSE-ConnectionGUID: ua1MCli0TpeQ9fHXBB0phQ==
X-CSE-MsgGUID: ADHsKLpQSlCQLwPWDMk48A==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="19875218"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="19875218"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 08:12:13 -0700
X-CSE-ConnectionGUID: jO/D++mgRi6H7e+CZ6PaWA==
X-CSE-MsgGUID: Hz3mCT8ZQ4idBEsjyAfEYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85007825"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 08:12:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 08:12:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 08:12:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 08:12:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 08:12:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQp/FyoEud5B1sfafBBRW0xVfuc4nl+CeoKv1b1/ktjKIi2INPQ8lPYvqHjoQs/7sw6jKMpCyq9jBG/GRqq6p7YNKUwZ/BJrg3gHYJnhHeSUkA4j3gEjWK1QnnVKWSuI9FSGSa0NPz+x8bnJgXzT9EPY/Ylof6F1mbpK+03vjWXtxA3XhvdqbZDwETLXPgyezCT1sylHZAvt/lpkzoBv++q+CVUGWb9ovPTx2JLM+11+Z4SFpBft+3Y0fDx5kabanoZt5U8VgvqaWIJe5ZrWFCdc+Y6m+5Rvnbvod3Z9YxXSQ5P/fxIKbsdqbHIdvVKTvJzea4JO7U9YlyPNuh2dJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4enf7vhs6l2AngE5PDXNS9Vwfkklep7twLL53IIwKGg=;
 b=Kl21cvK9C2j7iis2v3nmuPRzx3rtDdHSvIse594R0uWlm1QBXWHIbV1o2kE6RNci/vCO/s1lvpaY6jLfCWlyIBvZhYM0ve7MhcjBhgG1v6HRKemJnRZw0DzZn/f52Eu8HYOlja0TA2QyMeGDHcQRLgCziEchqCQDuMbL4HgHGVYOcztrwqDGHit02oxPAKifyCSXML1AQetI+w5d4WkD40vpxAASIzTDgRYl0RCXRoTcI72ufzzw+OHAyScHjvJUCnKpCUbjUui1gRZtyQ5GrxMmzAB8TrivLWkmLbbkrZ5OkZOVSXJfk+RM084s2tixnE8viUVwtjUWbiuKn1aSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6284.namprd11.prod.outlook.com (2603:10b6:930:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 15:12:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 15:12:08 +0000
Message-ID: <2ab61b07-a3b1-4a33-a3fb-e9c711b0587c@intel.com>
Date: Tue, 30 Jul 2024 17:12:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 13/14] iavf: handle set and
 get timestamps ops
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Simon Horman <horms@kernel.org>
References: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
 <20240730091509.18846-14-mateusz.polchlopek@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240730091509.18846-14-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: e52e4574-b870-4001-d693-08dcb0a9faac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aStZejA2dmU1aDVTUU1vUWtOdFpXeEtuZFk3dUV5MkhsdWxneVRhSi91VUR0?=
 =?utf-8?B?RjV1bDY2SkQrN2lrOVErcXc1emxUeURDdk0vT0s2K3VYUkkwMXBURlo3YmJN?=
 =?utf-8?B?RGF0Z2NPblBjL09YS0F4YUZmbFYxMENjU2NWa3VvU1laZWRwMUMrTi9YSjM1?=
 =?utf-8?B?RXg3bjhORjNJSkw0ZEFUUXFZWDFHY3lKRGdTMSs4Y1dISUc3VkNzeVVVeDc5?=
 =?utf-8?B?NGlkc3hxT2xnZndlZ0tDQWRpTkFOSlBhS0s2dFBNd05qcEthSHltNC9NdlEv?=
 =?utf-8?B?QWlGdWJuOGRJaW54K2V1QUNwdHUzQWNZZTkvR0V5WTdscWdQdWZDNkttZ0hh?=
 =?utf-8?B?bDZ0dGoyZ3hVZXhxWExnaXd4TlBIcjNucmc1cHVISWxoU0FPYWxjdXFLME5H?=
 =?utf-8?B?MDAwK3NZMU1kVW13MGc2V0V5bi9NVFIrMklSUVk4YWtSOGhZMmxLQXJ3R0tq?=
 =?utf-8?B?aWdDRkJMdEQ3TWlvZ3lRWldsTWl4VW5MVC9DZ1pkWEQzRE03NmdnZEZCNHNE?=
 =?utf-8?B?a2ZJNEN0cWw5cStZcUdEZEpJLzBBOW15TGJNbzhqRTU2eHRobVN4YW41MFZa?=
 =?utf-8?B?UThYRnZwTEI5ZDR0RERVMFZDS2FvMkovWVRNTTAweTVZcmUrM1R2bXZOQ1ZD?=
 =?utf-8?B?Y0JWckVua1VyL0RVbDdFWFExSmc3dGdnY0gyZFNpRUxLYmhZcDJobnZvRlIx?=
 =?utf-8?B?dTMvdHJwOVQ0K1JPbll0ZkNKV3RZRU1DS05lYmQxVXQxbm9mU1phTUJ2Qjk0?=
 =?utf-8?B?ekZxZnlzcHpsNDljVVBQaGRPb2UyWFppSVE0ZWt5Skx5ZnhLWWdKT0ZWWXY3?=
 =?utf-8?B?Q0pMNXJJSmV6THhhNUJ2TDVFdW90ZlQ5NksvNjArbmpaclZjRElEcUh3YzJx?=
 =?utf-8?B?alVjVC9HbXlhQkUwc1drb01IbzRRTVllT2R3Z25VaUVuaW9uS2FkK09IVjVa?=
 =?utf-8?B?VU1xSk1BVVM5M3hyTGxKeG5CSDEyMXcwVjZYSXFBMDFSWmVCYWd5YUFOTG5T?=
 =?utf-8?B?b3FMV0UvcXZHYyt1WjVwSHZpZEk0THh0TGszV2NuN3FXdk5RazJYR28vMHpG?=
 =?utf-8?B?eFpjQkxzQVkxLy9jaEZnUlZjTGx1N0wrVVJEWkw3c21KN2V1Ui9GbnJVUFNE?=
 =?utf-8?B?RzdMNGVGcXdaTGJPTmxXNW1VcVo3ZmlMTy9qMGlvV3E1KzJaWmdVMTZOd1Mx?=
 =?utf-8?B?NFdpL2xhdGVXbGRsS3RJYXFSc25sNFNCc3ZlZXZ6dGlWMUg4bStQRGRZMWls?=
 =?utf-8?B?NWdvcGtFOEtpMTRDZUtoeWRLWGxDSDFMUEJJOSsveWx4REMwUjNIWWdKRURT?=
 =?utf-8?B?a0V4UWdIWDJ0dXhKUFV1cEtkcDI4WTdGeFdnU1VBSjMxNkVlQXFNdkFmdW9x?=
 =?utf-8?B?NDZ2RDVORnNObXN0amZWM3REVjkySy8ybWErQzRNeDV1Wmh5TVNNRnBwc3Av?=
 =?utf-8?B?NzE4cFlqNjd3TjdtTEtieHMvSXk0OUVTUVgvcnp4T1VWNk9MMlduRnBpVTM2?=
 =?utf-8?B?eXVUdVdlVFdBZGdkdE1kZit3WG9VSHEwTzAvMHpKOWpjY2RyVm1BNEdKaG5L?=
 =?utf-8?B?RDNpOXlYR0R6Lzdpa3Q3K0hYUVU2KzVFa2k0akMvNlFidEc3SGFQQWxKU0t0?=
 =?utf-8?B?dk0wL3BYaVV2ZmN6ZFlrRXkrZ1dkTDhYdGpvbWZzUy9BdUVVeGhZK2EvVzl4?=
 =?utf-8?B?c3FrV0o2ZGU4VWlWbzhTUkZ6NTNMT3RycHlhbUpqcjRSZVNEZlNZOWtmbEov?=
 =?utf-8?B?SmYweVJwUHZvQzZqVjhnWUdmbk13T0Zlekg2ditTTFNvVjdHWTA0ekZ2Yzl3?=
 =?utf-8?B?ZVAyT2FETHREME1QZys1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZ0aHVJU09ZVUZoOG85YWRYbzFZOHBuc2poRkE0R0ZicE4yYTA5K0ZZYWZt?=
 =?utf-8?B?NXhCQTUwL0hUc052cS95aWR2Z2xYSEpTVUtmd055OURCUUcvR0lmQUtDNGph?=
 =?utf-8?B?SEpmSHNhRW8xb2hZRGtMUWQzRnRkOXNqWXhnSnJ3a2NZcEdRaStHeFRRa0xI?=
 =?utf-8?B?WERNQnRZNXY0bkp6eUNFUitjd0JIWVJvOUxJQks1a3V6S3AxVVY4UVZuelhE?=
 =?utf-8?B?Zi8xOXVLMS9pTlUwdG11VXNkQkZ1MWtQNlUzZkx5R1FvajAxVndNTlhiMEFq?=
 =?utf-8?B?bFBhWU1BUTVmWnhOOGRvcWMyK3hxWVVtcGE2aUZGenhSK0s3WDA2V2tBR2tF?=
 =?utf-8?B?dmE3K3FNQnYvL3plL3grck9UYm9oakFKem5NQ2dwRUtqcTlpT0dTaU43YzZ1?=
 =?utf-8?B?eWpXZ3lwWlJUaGlqWC9lUUkrbkl3TCs3K2dQUW9WOXVLWmU2bTRMOEJnU1cr?=
 =?utf-8?B?eE1IVXE2dHNhdC9JYWxzeTI5ck5iTm9jSC9wNkMxUFk4SDJhTFJPMEMrNXFl?=
 =?utf-8?B?TjQrTHcyeFF3UGUzSStVQVIzMG9xeWdjL1NQblVwWThxR2V2dnI0ZkhHSHlN?=
 =?utf-8?B?bEs1eTlWZWNKdk1xSzd5dy9pczY5NDhvdFNhMittMlc2QS9UWTgxZHY3aUR5?=
 =?utf-8?B?Q0ZYOTlLcUhiK3MwSFpTOGc0QStKOUhVMzVNZFJpdHIyZjh3SHhOSXNHNk02?=
 =?utf-8?B?QmdPMC8zajIrbGZhQ29ZZy95OXRZWDRIdHBaTjFZSkVKMzFIcHRxYVBSMUNo?=
 =?utf-8?B?YVJYOU0vZm1rU0NkazBINFZlMDB5a0cxakhnbnRDM2VGSmdpYjlsVVYxcFJp?=
 =?utf-8?B?c0FYS3U2VmtIZHVTcDBQUm14NUJ3bmNOZlFZTWZVNGpQUmkzNTdvZThnV2VG?=
 =?utf-8?B?OXp0eWhmTmhOUmZCb281YWJUaUxBcGN2bnMrUisvYlhyRStpVzg0VXB6bHFk?=
 =?utf-8?B?akFQM1JLK2lzSm8xcE1XcEpGYWVWeUZYMnQ3emExS2Nyd2ZsZThUQzU3VlIy?=
 =?utf-8?B?Z3h2bVMzd2l2M3laUmkyMFB0OXhYdXRrVEFTUUQ0L0hrVDBjd1drVjMyQ1Uz?=
 =?utf-8?B?VE5EaFFabVJQbDNhTHkrVU1vSG9qVmxkS0FwNmJhVnJnYXQ3b09jUCt0Y0F3?=
 =?utf-8?B?TDB0V0FqZ0hvOE1ZdnNVcmdRUkMvMlJ3Z2cvOFJFdHlxbkU4TGNlOEk4TDNB?=
 =?utf-8?B?RzhpTDJUVDd1emdob051S0d6clRBUG9LYVpYNGRxWUZWQmFIblc1UWFxeFND?=
 =?utf-8?B?dGJoQ052ckFWbitENXZIVjU4dTNVYy9nNm9zb2k1U2pMWlFmQWZsQmNoRTls?=
 =?utf-8?B?MVJHV2I1WlgxUDVSLzY3cUdDdHEwODYzM3huOWJIeVdzUmYrckZKbUhMd0x5?=
 =?utf-8?B?emNUZ3BQME9JTmErSk5rcklNMSs3c3pHUy91VmswS3BmLy85YzR4QVpyMC9y?=
 =?utf-8?B?bHA4QXRmNXpJQjB2SVN1S2tyRUZuSlhyRk5JblVaYW8zYURlOFZFc05BRC9L?=
 =?utf-8?B?b1BFTkx0NW16Y3FaekZKeWhTRGdVaGNERkRyN1FMbXhjODJ2Q1JlUWFWYmRw?=
 =?utf-8?B?RUI5OUNpc3BVK2dHeWxxbGNYQlRQcEs5elFwVkN6UjRNWDZiNnF5QVBLQXc1?=
 =?utf-8?B?enMxTGtBUXFCaUtuL2svQm5MSDdLWkhxUExPbHJCTVpCZTlCczNJVWMyZStZ?=
 =?utf-8?B?NTRsUEkrcmtsOUoybmZYbVZmeXNxeENXZ0pZVjZadlZVY0p1OSs1SXVrNXd2?=
 =?utf-8?B?UTd4QWE3cW51S2NlRGp1N1hjRGZobXZNZk02R1pQQUN5WXBiRHJsRzR5VHEv?=
 =?utf-8?B?NGIvaExDaTNiOFJDTlQwcUxTeCtka3Q3TmdmNjhDSHE5Q082YW1OK1lyemEw?=
 =?utf-8?B?SkNQMTJVcFF4K2EzRjBUb2JQMVJiOExJMlRaQ3hxQmp0V29EQ1RQZUd1bzd2?=
 =?utf-8?B?UWlhV1ZsNVRlTituOHgvZzVkTnRpY0lIM1JGcHhmd2hOWklhL2l4SUxldHBN?=
 =?utf-8?B?TWVGRjVDbGFOVmZ2SXRvcC9oNEowcmV1RytDbnZldWtKZnZpL0ZBQ0ExU211?=
 =?utf-8?B?VkcrVzJMUWFtd0RteVhEaUI1T1A2VXlXcFBoM0Y4RWVVQUZEcVR0c0JBWXVj?=
 =?utf-8?B?WWllcm5pNVlaRmxIaVR6cnZLLzJPaEc1NnV4WmpxenlsWk5uNk1hdFNMUnVG?=
 =?utf-8?Q?7ftZgS8sJ9ImS735242ccHE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e52e4574-b870-4001-d693-08dcb0a9faac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 15:12:08.3695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYfUW9Ojkh9tt1JXHk0+G/CA+/oFU67ORFyPOVWDjYbrXxKtECmRC53W9FqRSzVBFJtMVPoMxvyw4W91ZgQFWJzVrcZ9ydpMmjQoA9BNXBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6284
X-OriginatorOrg: intel.com

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Date: Tue, 30 Jul 2024 05:15:08 -0400

> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add handlers for the .ndo_hwtstamp_get and .ndo_hwtstamp_set ops which allow
> userspace to request timestamp enablement for the device. This support allows
> standard Linux applications to request the timestamping desired.

[...]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> index 9eb3161575d5..7754f4f24052 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> @@ -3,6 +3,136 @@
>  
>  #include "iavf.h"
>  
> +/**
> + * iavf_ptp_disable_rx_tstamp - Disable timestamping in Rx rings
> + * @adapter: private adapter structure
> + *
> + * Disable timestamp reporting for all Rx rings.
> + */
> +static void iavf_ptp_disable_rx_tstamp(struct iavf_adapter *adapter)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < adapter->num_active_queues; i++)

	for (u32 i = 0; ...)

> +		adapter->rx_rings[i].flags &= ~IAVF_TXRX_FLAGS_HW_TSTAMP;
> +}
> +
> +/**
> + * iavf_ptp_enable_rx_tstamp - Enable timestamping in Rx rings
> + * @adapter: private adapter structure
> + *
> + * Enable timestamp reporting for all Rx rings.
> + */
> +static void iavf_ptp_enable_rx_tstamp(struct iavf_adapter *adapter)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < adapter->num_active_queues; i++)

(same)

> +		adapter->rx_rings[i].flags |= IAVF_TXRX_FLAGS_HW_TSTAMP;
> +}
> +
> +/**
> + * iavf_ptp_set_timestamp_mode - Set device timestamping mode
> + * @adapter: private adapter structure
> + * @config: pointer to kernel_hwtstamp_config
> + *
> + * Set the timestamping mode requested from the userspace.
> + *
> + * Note: this function always translates Rx timestamp requests for any packet
> + * category into HWTSTAMP_FILTER_ALL.
> + *
> + * Return: zero.
> + */
> +static int iavf_ptp_set_timestamp_mode(struct iavf_adapter *adapter,
> +				       struct kernel_hwtstamp_config *config)
> +{
> +	/* Reserved for future extensions. */
> +	if (config->flags)
> +		return -EINVAL;
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		iavf_ptp_disable_rx_tstamp(adapter);
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +	case HWTSTAMP_FILTER_ALL:

Since these definitions are uAPI, their values can't change, only new
ones can be added.
So, you can use case range:

	case FILTER_ALL:
	case V1_L4_EVENT ... NTP_ALL:
		

> +		if (!(iavf_ptp_cap_supported(adapter,
> +					     VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)))
> +			return -EOPNOTSUPP;
> +		config->rx_filter = HWTSTAMP_FILTER_ALL;
> +		iavf_ptp_enable_rx_tstamp(adapter);
> +		break;
> +	default:
> +		return -ERANGE;
> +	}

or even simpler:

	if (rx_filter == NONE)
		// disable
		return;

	if (rx_filter == FILTER_SOME || rx_filter > NTP_ALL)
		return -ERANGE;

	// here you will have your 14 supported cases from above,
	// proceed with configuration

> +
> +	return 0;
> +}
> +
> +/**
> + * iavf_ptp_get_ts_config - Get timestamping configuration
> + * @adapter: private adapter structure
> + * @config: pointer to kernel_hwtstamp_config
> + *
> + * Return the current hardware timestamping configuration back to userspace.
> + *
> + * Return: zero.
> + */
> +int iavf_ptp_get_ts_config(struct iavf_adapter *adapter,
> +			   struct kernel_hwtstamp_config *config)
> +{
> +	*config = adapter->ptp.hwtstamp_config;
> +
> +	return 0;

If it always returns 0, void then?

> +}
> +
> +/**
> + * iavf_ptp_set_ts_config - Set timestamping configuration
> + * @adapter: private adapter structure
> + * @config: pointer to kernel_hwtstamp_config structure
> + * @extack: pointer to netlink_ext_ack structure
> + *
> + * Program the requested timestamping configuration to the device.
> + *
> + * Return: zero.

But it can also return @err...

> + */
> +int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
> +			   struct kernel_hwtstamp_config *config,
> +			   struct netlink_ext_ack *extack)
> +{
> +	int err;
> +
> +	err = iavf_ptp_set_timestamp_mode(adapter, config);
> +	if (err)
> +		return err;
> +
> +	/* Save successful settings for future reference */
> +	adapter->ptp.hwtstamp_config = *config;
> +
> +	return 0;
> +}

[...]

Thanks,
Olek

