Return-Path: <netdev+bounces-306509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wal/B6TIUGo55AIAu9opvQ
	(envelope-from <netdev+bounces-306509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:25:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A0739A8A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:25:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=UUWnRVEE;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306509-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306509-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA093036749
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116E23E0256;
	Fri, 10 Jul 2026 10:19:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73044499BC
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:19:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678760; cv=fail; b=AMcp5mi59z9E0WRxCqG7qzBuplevO/N6SWZLU6BLqW8NtFkwe+RzPruwJQuzIiRAE31ht3BKXrE058S+HIbdIL+nfN2g/xPFAgRMUcZFCsCLhAGdVai6seAlxztSJTYbpMKylUfmUFUkK9dbWdXsmNxa+xyZRsJkrmmRU2KmY6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678760; c=relaxed/simple;
	bh=bEim1r0Sl8FVuJczp/gTEuwUY6RbcZGAHw9xV35sgfE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqQVyM2dkMWMXm1Iv0bCtZdd+OGFdfaQAoqHuCRpMDHofKYgucuSzAoyXfp5sR5V1MJXEEaviSg8PsY6ZropdMDon0+QDkFiSm/Z5knn76jHfcWfh//pUPvIjpS0d/7b9N0rowqoKXYhbjHLxQhFRGOJp2f6tOhpwemNSjowH4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUWnRVEE; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783678758; x=1815214758;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bEim1r0Sl8FVuJczp/gTEuwUY6RbcZGAHw9xV35sgfE=;
  b=UUWnRVEEr/pcwyWqRen4G/O/kFJ4NCFpCIFZ7YCbuYWqphD0BfAo6FLN
   B5vOwgggCSgodbOyV555yhj/ia8MGiz1WsBZFEysdaTF7yC3B9Ox/MFLN
   yZuHv8wEI2/rMHD3W+1Hn/HKZ1Ast+9i9I22HTmk3FKudI3UDZhda64SN
   FTzX5VqhiHyNDdrKGsMn13Hc6hanQBS6IIlz7WacvvvICcX+OLvS5HPGF
   CyocCZITUEaZQO/5vklSKC7N5iMFWQJ7TyokA/qtBGlL67/BT0vuAlHce
   84lVifX1PcBbTJ0WU2YwIhZqx3Rb4MUPT2gOBX2i5nkl39V+mg4AxH6gM
   Q==;
X-CSE-ConnectionGUID: ZSNKcbEqQe+26I76IQwx0A==
X-CSE-MsgGUID: bahwvN/fSJWpaBJ28PgnwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84568269"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84568269"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:19:17 -0700
X-CSE-ConnectionGUID: iw92xVfzRha/78vq6dJo4Q==
X-CSE-MsgGUID: vpQZUMqaQ4OL1bB/COlYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="284951168"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:19:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:19:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:19:16 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6tJEOgT/iq7jFtC6ilwLGckk1mPTlwx60rqh5vmozNTWxb5oJBYlHLi7fRcGgapsHGeFIowVEIl2eUFf09Tm22ZHuyNSg5wshhzQSYkuD8nL/I+Nfsm6iBSK5uczjngW2cL9e/KsHFjW1mtm8Z1p0ch4DIOSm+4jBJSeYiJEIb76lyi9/htHh/ZRd+LvXDfDX6VWyjAuqwgvRV/vBFoHQlnOVg2AdzZTpHRf5kEXXBak/MqHVUGi/BT6uby2ZdKNG8Oyl6+2aPbZZcOXpqWl0jK/ln8eXPyJBT36vLmjymRHKGM5ytLzyyKULprv6hL/ZC60Ktwplo/bL30XQnLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaYxlUiZ+E2HZoRAggiTeIrn5xl1CEqDXt7jE8Oe7xg=;
 b=U6U8LXGn0KaxMwjqa2nolxi88uZa+TaN2/G36Xu0g9aKti7D0kmmas584aw1dYRKXP4qRck62eRwGmTuzerW0tWRSorAA3CbHW04X1mV3t2+KAj6U45B/JLqpoKT0N8oiFSFXxHmXttqH7OYIBW9U8BdV6VkNkHR1+tlExC6XD55sXhZvIdERcJS4j5DlbHGTWqNCYBVGDoduF932WbUIqudvYZNLH+dncKKLnluGb+robP4BuayafnMjRhGvyYx1IL1Yau5DS6FM74IJzgtdGLQxlAXIcolwToCVkm35SwECYpvRfTPQJqkL0b7iwE5fVgk0kyDnkfW5VsokviaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 10:19:08 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 10:19:08 +0000
Message-ID: <a12bf43b-1cb2-4ca6-b2bb-f4618bc4e8b1@intel.com>
Date: Fri, 10 Jul 2026 12:19:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/2] net: libwx: add support for set_ringparam
 in wx_ethtool_ops_vf
To: Mengyuan Lou <mengyuanlou@net-swift.com>
CC: <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>
References: <20260710015925.34769-1-mengyuanlou@net-swift.com>
 <20260710015925.34769-2-mengyuanlou@net-swift.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260710015925.34769-2-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0007.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::12) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 4317a4c9-8af5-44fe-d8ad-08dede6cad89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LChkle8u/NqvCdh3/xpmmpAYM7GAD6LYac5yvRmMma16Hk7HodtKYYejZ8Lm/mCzHWfpHl6bSxZGGqt4/j/6xGKQpZUcS0q/eupG1tr3II1W7jkTbIn5RqnWVU3IAioB29RwPLoL93OH2NavTQeHb+ksAj8foMdZ+2mQPQtZnWIoTknUjUtX/8+H3oj2285zMLPe5OE1D0HaUQZjqpfCxtmngfOLL9wzhcFs8TpomzQ05/qkVJBUTwmuuMhVnaH7VHsjcSOel9T9+4SNW6N3zTYGKpRtei3YfZsDk9gg9yHYvWCTiHLeMTCO1Lsku9L5h+5wraWo7oaZFnyiHsgGbFSfCdeNlRkBfO1h3t7Yo5ereral8/vY5afF9nCvQp91e1kABLxhHMCIBoSprA9/fHlMOFysChBbd+RwGKyyRhdYhaMqi+m2Xk9st8bp/e0n3hiJhSqF3kfbb6NQgH0wZunmPyaOf/ho1uUdg7lOnVWwEhSdhFWkdunJpoKGIsH55WprhoCYwTNoGzyd+B8Fjy7cYvvG7XTPa0Sfti7W4J2DNJLWiCizIAFVXVNX/1p1aW+NrOPs34GgCQz2SnCH9V2aO5CEf3ZlHb3vuX8dqV0/0BoHsqN4qySR05EGSQ4Tzb9nRBcX41aQwiJJFjTizCB+q6Rx+XWAGzLkdYdFbGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTFWdjF2WFE5T3hveFNmODRrMmRYRUtiNXlDdkhhTHVWU0ZVbzdwK2FmUFFC?=
 =?utf-8?B?TmR3bWdHVDhRNytNUGV5ZTJvMlI5dnVkZVV2QTdYR2puVWhHb2ZGZEUxT2xX?=
 =?utf-8?B?WGVkT1JETjg0ZkFMMlZiYklSazVHa2YyUzBVR2d4aCtGamdIODBVTjROZWlC?=
 =?utf-8?B?VkcxY1lqUWw3TklDbmpYdWxPV3lKd085SitPUzVrYzYyeklqTXBqbFBDK05Z?=
 =?utf-8?B?NFYxV2ZzTDUya1lONkoxMTJocXAvT0NzWHd1K3hGYUVuQWIwZkpHVitKQmw2?=
 =?utf-8?B?dlYvZzRrVHlaeUY3dElnd2NsNnY1bCtOcy9SWmFKUjNYVWIxVDhhT0FkZ1hE?=
 =?utf-8?B?VGFzcEJRK1I4Myt2TW8xK3hqZXpSUTV5ejFEQUdST0w0TjVYZkFRL0VkaDV2?=
 =?utf-8?B?NHNTcDJoZXlxNlJvTm9Mb2Z6Tm5KV0w4WW11WmhwTVQxVmNGWUwvM2dXWlQ0?=
 =?utf-8?B?VG5QOFpuK3lONVNhQXRubGQ4bXNYeVE1RTU1aDcwNkQ5K0tOZXBkTmc3RUxz?=
 =?utf-8?B?NHdlL2pUQlN5RStSQ1NLRnNPbmtybVZVd2d0bEF4NDRUWXpSUThBRzVKOVk5?=
 =?utf-8?B?ekdHMktLL3prZnlxK1hFOU5KNzlhR2k0b0Y4SUtaNTVjN3VKSlFzSTd5QkxD?=
 =?utf-8?B?RVAyZTBWNWJZUUprbWRsV3JMK1hxa3FacjBTV0ZSMEdETG5kOTZWbjJzWU9N?=
 =?utf-8?B?dHUwUU5RRTRXOEx6TlpzWWluekRES3BLTGYrcXB3WHk1M1FRcTFZVGRTeVla?=
 =?utf-8?B?Y2Y2U21uRjM0YkFINnBGZzZMNVJLbGdOTVZjWng0TjVSbXNtL1AwbWJLYXl4?=
 =?utf-8?B?d3g3M2RYbFJ1eEJJMGRHc3U2R2cwcVdzL0t3b0NnT1ArdXVzanhPb0tnaVdR?=
 =?utf-8?B?MjNabWNtR3paMGg5YWt4VHVuOUZTeEJrVXg0QlB6anFJU2RySUFyS1Q3VWtJ?=
 =?utf-8?B?VThrNFF1MHMwWDRocVo2SE53bGxGYlIwcWIwbFk5WDMzaEFrbnE3U0UzMU9N?=
 =?utf-8?B?R0l2bE9NcFFSbmNEcTNEMXdmaHJDSDExVkJlT2RrbVpWNkZSQUpvNE54M1J1?=
 =?utf-8?B?cFFsTTZNL1ZtOHZIZnRSRXNHSEtVM1l0Ykc1SXdKQjcrSzFWc1ovNjVrY2pB?=
 =?utf-8?B?VlNiSkxOdks3bTdlRml1R3U3RmxONW1JeHZxR0pCakJoYTEyUjVrTkJaNUlV?=
 =?utf-8?B?Z0t6U0xESloxSXM1aDdCVE1MVC9wZkh0cHNGeDFveU1rLzArVUhsT3prUEJZ?=
 =?utf-8?B?Q2RrRmorS2U2eENIYjhLSnkzZTkwR3J4ME9tanFFUlM3L0lILzMzM0k3b3JX?=
 =?utf-8?B?TlRPWjdtWjBOclJnOEk1S1hYZllrR3VlWWhWVnRkUy9naW5HU3Eyd3VHWEhK?=
 =?utf-8?B?UEN2cDBrT1BCbFZGY0VZblpmbjZLRkhDcUwrb01xZ1hBNHI4Mjk3aU9XSERy?=
 =?utf-8?B?TjI5TEdRc2tGZXMyRk16dkxwdkJlTkJqZXFNdG9sUU45N1Z5dFVvb3ExVWRE?=
 =?utf-8?B?WDJMVlJjbHlGMkFCNkNTL2FqMUUvUnhrL2xtcXFuKzJEMkd4ZTZCdkNQTllM?=
 =?utf-8?B?S2g1d0xaR3RldTdPditsU0dNWDlraDFnRFc2MStvMXBmenAvY1FjaS9VVGpj?=
 =?utf-8?B?NitrbTJ6b05BZ1owVzdyazFlRWdhZWZmNW9DZGNiRm9nMldxSkVSM0FTNUZR?=
 =?utf-8?B?TGg2dk9KYStISGVpM1FRS2x5R1htdDVFaU1NZ0tneHB1VWxicHkzZGo3V1Jz?=
 =?utf-8?B?R2RmZ2hLaXNPc2VkWHUyMWtGNVQrd3NsN2RzTGtHeFlOK3ZxMmo3VHJkMVdk?=
 =?utf-8?B?WkxjdHpydkxjQ2IxQ0w3eEltdW1oY1l4bVhZc2NmTytrbGJqTVV0c3dJdnBq?=
 =?utf-8?B?bnJnNC8raHkxTkdXMnF4SDMzOXBZODRhSDNGNTNDbFowcTBRWFdUZVpMaC9N?=
 =?utf-8?B?M2FMczdPdzJCcHBZYVd6MFZMTDQrWUN0dHhXZjZ0T2RFN1pVTnAvbHp5MzRZ?=
 =?utf-8?B?K1RUckdyTnIwNXZqUE9YZVhtTXBUTmFxVTlQOTJXanQ2dUU0Z1lpZExwUGVo?=
 =?utf-8?B?VWNOLzRackhyaXZLUUo1dU9va2pwaFdnR2FxOGpEalBQVUZsTHp0MEx4MU1K?=
 =?utf-8?B?MXE5aVZpNTJEaWdUREhkdFJ0V2lCZnpaKzZYbDM2RjRHSlRhYTZLMU5ac0E3?=
 =?utf-8?B?QXRjaDVHN1dXemZVWEd6WVJueXRtcGdnOTFVVmZjMHY4MVg4YjJGdTArWGZj?=
 =?utf-8?B?Nk16UEZvSFRicG5zdXA4eTUvKzlCYk9qWkdmbTVVUFZOaGVIWkYweG1raWF4?=
 =?utf-8?B?N2pmcFRPNWhwRHhad243UnowQmwrU3lkRzB3UzBDeVpWSTI4MmtSMTl3UXl2?=
 =?utf-8?Q?QMpbU8P46EnCrj2k=3D?=
X-Exchange-RoutingPolicyChecked: YwmlPYD6EOU67ZMtke9zw09zr6+cuKnQQ4OZUkrZG0XkSgGIivocTqwUsjSYh/sQZU5B6A3guV/cc3xTVKqYbjZMyRZFFYswtiNV/gpYgwC/dwaO+3n7WtWidSGq1YGzrwuaibfg3MupHsvxVui+tAmApfiaK9ahc1ZcxSV8Kp/rRLekiwoXCC23hGi9imyzH3jzBuRWwHv4So0YIAjiHElkE0HNkxDulrTOpYU+69brYXemvL0y2D1HtHVpg5MmeDtcRlh3cqhDKGsb+409MJEuGGpmL0aQW2iMbd/UdkueYy2SYVVcDa5E+PXjtIqykMy8CgUdziNv8B6RdyYnOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4317a4c9-8af5-44fe-d8ad-08dede6cad89
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:19:08.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muCVuxKY4fjgH5UPhNxX2cA3URdpCtNlhWwmgcc7j5N0xIPhoRm3XEPHzqcN4Sj+AVhiRy1o0ieg4f7639Fz98Fb4ogrpdCJDdWV8Gk4y20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306509-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,intel.com:mid,net-swift.com:email];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 834A0739A8A

On 7/10/26 03:59, Mengyuan Lou wrote:
> Add support for the set_ringparam in wx_ethtool_ops_vf,
> which is used to set ring sizes for ngbevf and txgbevf.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>   .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 61 +++++++++++++++++++
>   drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +--
>   drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  4 +-
>   .../net/ethernet/wangxun/libwx/wx_vf_common.c |  4 +-
>   .../net/ethernet/wangxun/libwx/wx_vf_common.h |  2 +
>   5 files changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 5df971aca9e3..eae038df6875 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -9,6 +9,7 @@
>   #include "wx_ethtool.h"
>   #include "wx_hw.h"
>   #include "wx_lib.h"
> +#include "wx_vf_common.h"
>   
>   struct wx_stats {
>   	char stat_string[ETH_GSTRING_LEN];
> @@ -775,6 +776,65 @@ static int wx_get_link_ksettings_vf(struct net_device *netdev,
>   	return 0;
>   }
>   
> +static int wx_set_ringparam_vf(struct net_device *netdev,
> +			       struct ethtool_ringparam *ring,
> +			       struct kernel_ethtool_ringparam *kernel_ring,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +	u32 new_rx_count, new_tx_count;
> +	struct wx_ring *temp_ring;
> +	int i, err = 0;
> +
> +	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
> +	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
> +
> +	new_rx_count = clamp_t(u32, ring->rx_pending, WX_MIN_RXD, WX_MAX_RXD);
> +	new_rx_count = ALIGN(new_rx_count, WX_REQ_RX_DESCRIPTOR_MULTIPLE);
> +
> +	if (new_tx_count == wx->tx_ring_count &&
> +	    new_rx_count == wx->rx_ring_count)
> +		return 0;
> +
> +	mutex_lock(&wx->reset_lock);
> +	set_bit(WX_STATE_RESETTING, wx->state);
> +
> +	if (!netif_running(wx->netdev)) {
> +		for (i = 0; i < wx->num_tx_queues; i++)
> +			wx->tx_ring[i]->count = new_tx_count;
> +		for (i = 0; i < wx->num_rx_queues; i++)
> +			wx->rx_ring[i]->count = new_rx_count;
> +		wx->tx_ring_count = new_tx_count;
> +		wx->rx_ring_count = new_rx_count;
> +
> +		goto clear_reset;
> +	}
> +
> +	/* allocate temporary buffer to store rings in */
> +	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
> +	temp_ring = kvmalloc_objs(struct wx_ring, i);
> +	if (!temp_ring) {
> +		err = -ENOMEM;
> +		goto clear_reset;
> +	}

would be much better to move tempbuf allocation into the helper,
and just do it at the beginning there

in the unlikely event of -ENOMEM, you will just call the "up"
in the unroll path

> +
> +	wxvf_down(wx);
> +	/* wx_set_ring() may partially apply changes before
> +	 * returning an error. The error indicates that not all
> +	 * requested ring parameters could be configured.
> +	 */
> +	err = wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
> +	if (err)
> +		wx_err(wx, "failed to set ring parameters: %d", err);
> +	wx_configure_vf(wx);
> +	wxvf_up_complete(wx);
> +	kvfree(temp_ring);
> +clear_reset:
> +	clear_bit(WX_STATE_RESETTING, wx->state);
> +	mutex_unlock(&wx->reset_lock);
> +	return err;
> +}


