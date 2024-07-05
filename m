Return-Path: <netdev+bounces-109466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A4D928919
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2275AB2249A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAD714AD29;
	Fri,  5 Jul 2024 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUfoXyfu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC313C8F9;
	Fri,  5 Jul 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184153; cv=fail; b=t+c7p0/yr2knfZ4neucHey6REWCQi/12Eh+alSR8X99CJRT63HgDNpj96vLPZq0LbQR6+pUEUeuTZlEONPnSmTUB5qAvAYBTGhNILjFdyCKZJ8R1CinsMF8QRVguhpq1GPrCqZ9KNcKGUl9qF+w1Eu8yj2W2ohjTEJsIMzR1uRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184153; c=relaxed/simple;
	bh=pVtAovohtVT6IQH3XBj9n4ApNLMf2WNs8qNfLr4TQvk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NlX+3a5Tf5YAVpsfDMyw5KYg9x77DZm76WbqeHcRTMApSGvHY3hqBRCl0EKA1Kc4vIia+GlpJQswAIwKzIEXrIGR4u0mx2h8o0CvzMb6iNGF9lEyINeQNzMoXYVesMgTEJZ0okRuE+Sx3UApAZ7JM7v1/ydrlN9XTZH+Vs2JlTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUfoXyfu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720184152; x=1751720152;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pVtAovohtVT6IQH3XBj9n4ApNLMf2WNs8qNfLr4TQvk=;
  b=FUfoXyfugJxxUbu6LpOnc29KPger0gVjhNi0MiakzzIdG7B6rwrIIIta
   JtnIs07sxperOLgxiuPEbfX2UjiZxH2wWkBENqiDT/lR96gXnOtXEZ+Qc
   7MPMp73lBghZ/yjBDbESQ82nxlL79Gi5hQyZdkIyjxx9WKosxuexXOErN
   CrtIozqSHDrF+VP7KOinbv8INGbbq92kqum2svu6YZRB0YuxqxXYLVu8b
   dXmCc1Pv78QKq+4cHQORkepchhOdXeA3+J8CrGobZ5/M24afxAx8xhNHn
   oVX4Wtng8tbVReVf+IYA17GLXqrY5lWUYbmP2zuHu6W43LajsEUVXsXon
   A==;
X-CSE-ConnectionGUID: kuLH0/kPQPqrOqYVWqImYg==
X-CSE-MsgGUID: t7HbFh3uSrqF7pfUU7Cwjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28630840"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="28630840"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:55:51 -0700
X-CSE-ConnectionGUID: 3LAM6rAPS9yqgXzYQgqg5g==
X-CSE-MsgGUID: sncYOCVuTWi8GsCDYkz1eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51722880"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 05:55:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 05:55:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 05:55:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 05:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ytggp1lfs3EfwgNT9Zt57L28maYuw0aJnuVmwmMU+SI24n4kOfrqUEQGswrKeVrKlL5Qe0JwaiVebQ+JN381KFw3j9N46mp6oisL4epxOXN6E32VqNNmgZMO/+fwi6IS+BdfO5kTKrzUNZXgHlYucVMO82QaEwb9k+NTHaD6WwQ4Xw3dgPYxd30TWlDSLhjwVqCBhtJ8t3YwahgYcjvMuh36/AxISrdYhpGbYF5N4vNMiSVMi+Ai7Lii7RRitsX2Uai6Q43Ip8lalpNhO/rZq/Vi2t6S7fJR3CCkTOWpP9i4FY4BYoxRWRHbXObXPD3cvsQWxFWCyHuKEpHCPc041w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJw9OhB/9ue+T6SdZAJSNJtoWA2Ac1figmekbxyX+wA=;
 b=FhkgQQE3ue1AuRH/d7GbT0fJ/sb9qubEyL/ey4LR7I25HpicAb2MTLylSaEt+AylukDT4COByp7S/mpqPwPcmjwbLiYKUh/8l6vXVaDcPr6Uaf+0u0nBe9eLClAdWU133DdkcS+Lg08UFR1iPo675pZ9Xgwj6EiHbYnId13mz6ma5wyO/dppwSOpZ62TDDcT9+UKdNmt5pOJggEMZuLK3TgIW3ZDD03IC2VNbwldRZd7E9B+XtvynSvMP57Glirqau/opv0ISL854HPKQIZed+DwUwHHIWJJrlY4gwMMhe1FA7aIFw/qlaMcdZZ9WdR6OtRd+sjXmVr2t3Mcb5H4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Fri, 5 Jul
 2024 12:55:42 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 12:55:42 +0000
Message-ID: <2e441889-cb53-4004-aeed-1268d20b54b7@intel.com>
Date: Fri, 5 Jul 2024 14:55:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: mediatek: Allow gaps in MAC
 allocation
To: Daniel Golle <daniel@makrotopia.org>, Elad Yifee <eladwf@gmail.com>
CC: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
	<Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
References: <379ae584cea112db60f4ada79c7e5ba4f3364a64.1719862038.git.daniel@makrotopia.org>
 <3bda121b-f11d-44d1-a761-15195f8a418c@intel.com>
 <C24C4687-1C00-434D-8C37-BDB85E39456C@makrotopia.org>
 <ZofX4qfGf93Q8jys@makrotopia.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <ZofX4qfGf93Q8jys@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::41) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 2233f32c-2e04-49ed-fbd6-08dc9cf1c73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXpVQ2drWllHUnJpL2UrRU1zR3JLV0dQcW14d1o3VG45Ly9LcEtRNWFPVFMw?=
 =?utf-8?B?TU1uc3V0N2pIcGJGOVVpNHhzWVh4OU9TS3ZXYzNPZ3VhVXc2aEh1S3BtOFlm?=
 =?utf-8?B?U0ErWHBWZmU4SXk1SDcxYWlCT0RVYmtUb3Z1U2FEZyt5ZzMrQURjMGtnTDJy?=
 =?utf-8?B?VGFFVXpLSDdwaUFucmc2UTBvd1gvU01tYnB5V3dTYVQxd1paeGdZbkE4TjE2?=
 =?utf-8?B?ZmFhOVdrdlI4aHp6ZmZ6QWlxZTQ2ZG1VeVB3bHdaQ2xtbUhFb1Awb0RTQStQ?=
 =?utf-8?B?K3hRUXN6NmtLMVNPR1Z1L2NENDQ0c29rckhlZVdqam1BbEhYaHdKQ1R5VXRl?=
 =?utf-8?B?anZYMUd4eExlTEYvUUhMRFlyR2c4azE0WFFDUHFRTEtKUjNBQ2E1Z2Y3S1dI?=
 =?utf-8?B?WHRtQlZYR2JyR0F5aStZVlF4Ry9zSEpaYVU2OWpmeU9UcmQ3a29COG9Qa21T?=
 =?utf-8?B?ZWRlaGNPU24xSThlU1Nsa1p3MW1qQURsVTkxeEZVOGRsYlp1ekhkTW9aUWxQ?=
 =?utf-8?B?NWRzcU9lMmdTOTlEby9BRzM3bEgxa1Jsa1MrOGRGdmRqYmI0ZGpINzlvTVFx?=
 =?utf-8?B?Y2xveWRLc05Gd3hmK1NLQXVGL1VrMnZlZ1NjN3lSUVF6MEdSVS9vUGRLOE91?=
 =?utf-8?B?Nk5xSzV6SFJuS3R0bDZqT2FWMjh2M2pFNjZ5dk53RURDTTFxbGEzOGZQS3Fh?=
 =?utf-8?B?elRRZUhkR3M2WUFEL3NvNmVELytva3B6MHloMGp6WWJObXJOZG90OGR6c3dS?=
 =?utf-8?B?aFoxYklLTkdLTE5KcUlqQ1c1akRFUHlLODVKZVdEd0p0dWlvSWZoOFNtMEY2?=
 =?utf-8?B?WTdvQmRZV1Z2TXhZcU9xcUI4cElqVEZsUHAzeEliZllDL3VaZmZCR3hMZ0hT?=
 =?utf-8?B?LzVMaTRoSHIzMzUyL1N1WDJZMEVSZVRaUGlQM0NrQ2RwWmlIUUlibmg3K2tK?=
 =?utf-8?B?bkp0TCs4eEJxbm11TVJtdDdXQnNQL1Z0bktrR1NUOU9neFNKQmw1Qlk5VVBi?=
 =?utf-8?B?RWZaQ2xlTFdNdWhpSi9kRGxiWHNEaFhzQ1pSbVEwNFdCS0xUTUZWZWJ6R1RU?=
 =?utf-8?B?VVhnOUZ4djRNbzF1NHJ4VnJFa1U0NVk2aUhhQ3h2WGt4ZmxrOWJaRWdMS1RM?=
 =?utf-8?B?VGczY1pVTXc1di91aWdjNFU5V21xM2ROeUhKU3B1T0x5WGRmT0JyK2UvT0NR?=
 =?utf-8?B?SXNGdE92YTVLUEY1eVNLWVRlWkp4aWVmc1F3bFdaMW9oYllCLzJOd2QvOXR2?=
 =?utf-8?B?em9NZmw1Wjc1Sng1Sm9LVkl1Q2dlSFpReGJIL3hmRmhSendHZ3hMOC94RE5P?=
 =?utf-8?B?RnZJbHQ1cUI4M2VaMVg0V2lwanhHQkpudFI4WXlWT2dpTlFLcUhjc0NYOUZr?=
 =?utf-8?B?QmVUSk1LVHhncStyYW9xTWhZZEZ5akpRUGszdDBIem1lTGxjczUrZGVONVcw?=
 =?utf-8?B?d2hOYkFxU0VvdlJEbjBkbStoaXMyUWpNVFlxUzNmT1VNcDh1aDhMaDZQejU2?=
 =?utf-8?B?ckErQldVdUxEdURCaWJ1aGtXMjM0N0E5Tzg0SEQwTzFEbHluZnQ1TWlJVzVQ?=
 =?utf-8?B?bUQ2SlNaUGlaUkVITjlLUFN6UUQ2NkZBRlJxem9wZENhUlBHelMyYVJ3MnRO?=
 =?utf-8?B?MVloSEgweEdUNXg1R2VJVCt6clhxQm44cUd4YXJyeWNtWFVKZ25nUENBdGx3?=
 =?utf-8?B?OXVwNjBSNmNQTHpMNkFXYmFvZ1dmL2wySXZYVC9mSFBkZU9iOGt1L01GTWhR?=
 =?utf-8?Q?AlDz+Ov3Q7EFTJW6mQVtSXpsWn4FvWl6cMyQHrl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGR5ellJd09XcFhSTlhBS2VpTGk1TXA2TWgwY2hIMGlCQ1hFZ2JIYURvanp3?=
 =?utf-8?B?RlgyTm9RVXY2RGNsanJEK2NaZ3ByU1h1ZVVoME0xUmUwMXZ1NlBBam5TbFVk?=
 =?utf-8?B?VHoybnFmeW5PeEVrdEdyVkFZek1vRDZrd0tLTStkK2JuTlRYYndMaE5XRHM3?=
 =?utf-8?B?NDhLVXFUVWk2V1Rhb21NM0Nnb0FtVG4vMzBFSVBUdnV1eHcwNjQ5dDNkaXlW?=
 =?utf-8?B?SjQycENEYTREODhSeE45M2RwQmxkSm55Skh2R3ZUMWdLa3pUMy9JblIvbVpI?=
 =?utf-8?B?UURPQXRiK0plcWNqSWtKMlE3dktGb3c5bVc4aHV1Ri9hckF4MnJieTNMV2Zo?=
 =?utf-8?B?M0gvSXZJTWg3ZE04d2c0MWtzcnhzYURwNmdLWkJoWHE4Sm16eHk4U2hsRUxQ?=
 =?utf-8?B?OFB0Wlc5cmhnamVvTGxUKy90WnMzb2FmWE1mQnU0NldReW5Cb2ZDaFBQQ1Bj?=
 =?utf-8?B?SzBmc21vVW5FRkoycytVb3dMTkFjcnRPeG9SUFpzb2dkeStyK1NGVGNlUTk0?=
 =?utf-8?B?Q0RWTzBpRFlkLzFPdmVvNnAvUTFWamhIMmYweGVmYWJlNFNRQlp2Uk9OekYy?=
 =?utf-8?B?dEVCUldCR25zRVdvOWszbnE0LzBnSmNhL21RV2ZFRUwrQ2diblVGOGNlbzVL?=
 =?utf-8?B?VFI1M0RweU9XUjJDZkd6dENZREloVVVlVWlqbEwvYlY3SDhzQ0N5Q2lneTE4?=
 =?utf-8?B?T2IzU0JxOUw1RE1pOCtTZ3JqbmNzcDZvRGdGYTc5dW9vdndnWUhYcHhnZ2dy?=
 =?utf-8?B?eHMyNURjTHp5NmNHajNvNjFueHpCSUttN2JsMzRSZ3VSejh4NTgxQ2ZLTktD?=
 =?utf-8?B?dWZML0R4UHR4bERQM0NBS1N0dFdRK1BVWHFKVWxaNStzb210dzV5Wnp6cDgr?=
 =?utf-8?B?dEljN3dvV0VPZGRzUXFaYmFFYUpCcnB0cEhaeStncUNVL0FFKy8rbStJMnJm?=
 =?utf-8?B?UXRmdytEZjZOaHBURnFhaWc3a0RVSGY1OU5TSUpabWhiaSsrMzN4VkhOdFpw?=
 =?utf-8?B?dVVwSHJLMVIxN3JTMzNzQ3JFM1duVDRDWVc2Tnd4VEZQajQ1cnhNNk5QUGp4?=
 =?utf-8?B?aHNjUnRyU2M1WWMxR3IxQ2EwcnNlZzVQOWNXUklWNVl2R0luKytXTTVOSVlO?=
 =?utf-8?B?VU5zT2xIQlh3aEtVaE5oS2NOYUFSRktiYlQyaldyU216cHQ4RTlPUFZhQnNN?=
 =?utf-8?B?TldEQUlONHVPeVJEQzI2Qk1ITWNWTGlXdEhCL1JTMzNWZ3BqbmVXOTUyODEz?=
 =?utf-8?B?UW8zU0JkV1BLdDNwV1FmSGgyb1cwWWtSa0toZ0dHSm5Wd1lpNS9sU3VpT1lz?=
 =?utf-8?B?TWwxRXZLeUpFZk1WRE9mSVg3S1ZhVXVIMDFPcEVvcVRXbHpMNlV5NTNoSUhD?=
 =?utf-8?B?V2NJTEJsZ2dzRFU1OC9sRzVlR3VsZ3U0V3Y2UmtpUEVKU2tnZ2F4WHIwR0h3?=
 =?utf-8?B?RFNEMVpCVjgrV2JnNWczbmdHTVRQd3FNUE5Ucnd2aW5aRjRLejl3U3R0TWNt?=
 =?utf-8?B?dkNDdFJNcWNSWmc5cFA3WVd0cGJ6dVFJc0pwUkcrdW9tVjhDZGlQRC94TlBa?=
 =?utf-8?B?dVN2YmpLL3IzYXZSQ2h3V09mSjRYd0tVUGtPOWtOYUc3N0UrU2RzdXpvQ1FY?=
 =?utf-8?B?alNFWmpncElmRW1WaFpXaW9vWE1manU0WVNER2l5N1YwZWxYRzB6NjY3cXlM?=
 =?utf-8?B?Z1R5S1M4elFFLzY2R0Z6RFRpR280dFVzaTBHTEw1SitYUG80c0hQelFPTStx?=
 =?utf-8?B?YTRUM2d0bjNvL0phRCtzL3haYThGUE0vN1FMOTA1dkxKTTl6V3A2MklvSWVO?=
 =?utf-8?B?M1cwNjZ0SWxHdmRnU0xNRUtEaHNJS3I2TmRhSHhVaElaeVVCRHQrQ3VqYmFY?=
 =?utf-8?B?YXJocDNSTkdjd09sTEE5eGZYUlhlTGVaQ0RhM1NrblAwSWJaUDhyVnhsZmpC?=
 =?utf-8?B?MlI2ZkttMmYvRW5wdlJLY25JNDd2ak80TUdwZmVYZXZZVTMzYVVWcFM3U1dy?=
 =?utf-8?B?SzY5cldUTkQ1KzNaSGJoanZTNmt4U3NhRk1nZktpMFU5ZGNjeXdvM21oa0lz?=
 =?utf-8?B?dTI3SDNBVXNUUUVQU1RsWVFiMkZvN0VxZHlRbDZ3VDhVa2JrUGFpVjdGeXhQ?=
 =?utf-8?B?Z3Q4MTBNZkcvRzNtdXhiSUd5cmY5b0NTNDVTSkxrbGc4TllpQ3FUY2RyZnlG?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2233f32c-2e04-49ed-fbd6-08dc9cf1c73d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:55:42.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PccFh954wu7IINhIQEzS3PF5qYS6WbhOp0KVF+QgjA3Pc8MSGW9zHpkxsBryqAWofGe4hmGD1/+j1Qqt9vmNjUWSLOQQDA8gN2Uq7DSLrOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
X-OriginatorOrg: intel.com

On 7/5/24 13:24, Daniel Golle wrote:
> Hi netdev maintainers,
> 

TL;DR
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

and no-one provided feedback against merging this patch so far

> On Tue, Jul 02, 2024 at 09:05:19AM +0000, Daniel Golle wrote:
>>> what about:
>>> 4733│ static int mtk_sgmii_init(struct mtk_eth *eth)
>>> 4734│ {
>>> 4735│         struct device_node *np;
>>> 4736│         struct regmap *regmap;
>>> 4737│         u32 flags;
>>> 4738│         int i;
>>> 4739│
>>> 4740│         for (i = 0; i < MTK_MAX_DEVS; i++) {
>>> 4741│                 np = of_parse_phandle(eth->dev->of_node, "mediatek,sgmiisys", i);
>>> 4742│                 if (!np)
>>> 4743│                         break;
>>>
>>> should we also continue here?
>>
>> Good point. As sgmiisys is defined in dtsi it's not so relevant in
>> practise though, as the SoC components are of course always present even
>> if we don't use them. Probably it is still better to not be overly
>> strict on the presence of things we may not even use, not even emit an
>> error message and silently break something else, so yes, worth fixing
>> imho.
>>
> 
> I've noticed that this patch was marked as "Changes Requested" on patchwork
> despite having received a positive review.
> 
> I'm afraid this is possibly due to a misunderstanding:
> 
> The (unrelated and rather exotic) similar issue pointed to by Przemek
> Kitszel should not be fixed in the same commit. It is unrelated, and if
> at all, should be sent to 'net' tree rather than 'net-next'.
> 
> Looking at it more closely I would not consider it an issue as we
> currently in the bindings we **require** the correct number of sgmiisys phandles to be
> present for each SoC supporting SGMII:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n200
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n245
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n287
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n325
> 
> Hence there aren't ever any gaps, also because the sgmiisys phandles are
> defined in the SoC-specific DTSI **even for boards not making any use of
> them**.
> 
> I hence would like this very patch to be merged (or at least discussed)
> as-is, and if there is really a need to address the issue mentioned by
> Przemek Kitszel, then deal with it in a separate commit.
> 
> 
> Cheers
> 
> 
> Daniel

you are right, I have even marked this specifically as Reviewed-by: $me,
so I think is just a mistake to mark it as CR
(without the RB tag, it will be wise to mark such comments as no-issue
or similar, and I typically do so)

