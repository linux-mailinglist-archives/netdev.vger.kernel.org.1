Return-Path: <netdev+bounces-127923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2FA9770F5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611CCB22079
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57171BC9F1;
	Thu, 12 Sep 2024 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxwMU36k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056F188925
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167245; cv=fail; b=QfwDvJBvlgd9Qhp7+oyulQGu22/4uzuP6xFnzTJ6JHU3UAAElK2UAEPEhOBMsYsPjp7WIVdZ73vMffbtPOmbJov7AqnTWyNTp+IgGP0JjCjMVAUTJmLT52mUOemJ66Glpaage4Uv9Es9933Bsi18AqePyMOSkCeTVz84XI10/Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167245; c=relaxed/simple;
	bh=Lh9vi7i1v06hwHXZOyLrO2f+2+Dg5BtLgR909ljKnMI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KrM64BJUSh1hXkEJRzEBQwhICSQiq4k6yzoeMb8OTInfJ07uENIu8yPgy3v/2nWKgkzpHhUi5gK5Msp+MN8Wwi6x62eOSyibuvpoq6KDoDCkVIx+pyLL8csbL3H1JRDQCaaYZLsvvkPoNwzzqeZbcat9rhU5glwYLFawsJU0Q1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxwMU36k; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726167245; x=1757703245;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lh9vi7i1v06hwHXZOyLrO2f+2+Dg5BtLgR909ljKnMI=;
  b=HxwMU36kQgyxl/dWAkUob0F9FsgUZqyKV3mO5wJb/mzpTWkS4iUn2gaZ
   YtVQWxfVS1NN3QQz8BdtSCppR5vmAQVwmC5M9wU95bvG6zUOLyeVOXsUY
   2IdUoCLXLOsUi6gykwgcWymrzfYL4NM/t7AnK54RpG0ySYdFyenfHWJPT
   pOk8tex/cxr3GYNcvyw33UmB2hRUYolnUM1Fj8JnUd8yGDvey+VIknZZi
   00uFii3FjIGfkoS4MgrAWNcRRqxC5Gr+vazcnEsZvCKwfWv0pVfPyKA+A
   wsaqNTXsROkQX8uMua6HGPbGViiZJwU/0a8XqpF4v6VeL/Jzk2mdasTrz
   Q==;
X-CSE-ConnectionGUID: tltyaLvgQs6XzxJuKuX2Mw==
X-CSE-MsgGUID: mPFDN7SnRiG5u1WkaabWWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="28787591"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="28787591"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:54:04 -0700
X-CSE-ConnectionGUID: y2RmvFljR0WckHCnYCtssg==
X-CSE-MsgGUID: 8xpAM6vrR6OdJqlq+XHe6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67511696"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 11:54:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 11:54:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 11:54:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 11:54:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 11:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ4PYkHrFcxyd/zQOpN9p9eVliMdRmB/hgLMM3VYVgSXkgoHV+BdWpI0iM+Sa2NvABQYqKofADZBLUzsMd4Rp+rPrV16SseqewEFdLLHE09LGzbLT9NS/4gv3WltqMcHJm3THZRzwsT+ECR1vnR/cd0Juk+D+UzuuJhWJHWMVjqwsSQi0OSNfWnis4Mrafs8dd+j5M6lMXvhj9sG8u1wTNCMJbXO5apUjvI6h9K/Mecdx2ypeOqz9jfcxPRXwsdl2EttVC72nRabR3QdkQ1bbHvBerl8HUZLpphsFNwdR8/1rAYBrow2Zunc0Xc/MowBTo/LvtFQRWnPs3N3RXtccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV7y5ZITJah/YzOpUtMpUgJcd3Wr1mX38925h70NCAE=;
 b=r6zuJisbw+ool9LrDsUSH7bkg7jCMC1eIFTFUCSPy4xcETDpmGOiAv7zucRm0whUtjgP6VSC15JExlFWiDZ5vcmy3kTWsHInJg0L6JrEhEnRdhkIcRzFwTKdWWfwU5tWgHe/xjcyMTvch+bjjZbpTfpeDlMaKDkzvHb7WW4upQ9ihsuNzLQXFUjUM61fboyZ9obK68EE5IC1vxMFg0FeorxYI8CHuHfgepQUEWZUQdw4wDz04J+LtttWR98xsIoBDl8mexs3I0HpPa0p5ssJFP3fcimhl3GzjoW41w3v02tS8HlqCRtfS4iuzoN/A5QzixM/+O1zI4lRAWtfYjeViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6808.namprd11.prod.outlook.com (2603:10b6:806:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 18:53:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 18:53:54 +0000
Message-ID: <dc4bd117-4a4a-4871-b968-1d35ed5d8e1c@intel.com>
Date: Thu, 12 Sep 2024 11:53:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 03/15] net/mlx5: fs, move steering common function to
 fs_cmd.h
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-4-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-4-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aaf66ad-856c-44c3-3d8d-08dcd35c3ff6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFVXNTVpOUg2UUFyOVV2NVhZQ3RpSnB1RFpLU1h4cHR6MzNLRUZFc2JGVDAv?=
 =?utf-8?B?ZTQwTWxvK1RCdnAyZ2JnQjh3bFRvQjFyK3lpM3RlS1g2aXRpVEJrVW9Sd0lr?=
 =?utf-8?B?ZHp4MDRTZ0YzOXFBU3RHcDhBMTlyS3NvVDdVaXlVdnNkUVlEVlUvbUlLUGFi?=
 =?utf-8?B?YndPRjdWUlcxVE5WTjVkYkYzbGRpejZvekFCV0xLd2ZhUll4WEJlbUN4TlNT?=
 =?utf-8?B?RlcwcHpNK2RjcFpJYmFJNG01aTVOdmxyZ1NySU5kRGd2Q0JmNjBiT0crNWt2?=
 =?utf-8?B?R3plNjREdXRNcGhCNU9EMkl0dnlGeFF0MGttdGJwRzlINlRVRVE3M0MzWWtu?=
 =?utf-8?B?dFN5SXBtWmZkazFGZ0F6NFRDM0phbjExRXMzZGhIZGJHTzlJNHp0UHlTYVVS?=
 =?utf-8?B?aFNJWW5Dd3cxSjdYNmtsb0w0RGI4SFo5a1RzVEx1ZlJYcXIxYlQydzVYbGI4?=
 =?utf-8?B?Y284TDFNUWZ0ODRBQ3QzcTJ1RzgvcXIwamdEZlZYeDVMTWh4MFZoS3M2dTVG?=
 =?utf-8?B?UnZudnJJUHg3UEU4MUdrWHo2M2dyZUtaT0t2b1ZSd2plOGIzWmh3dFRUL0k1?=
 =?utf-8?B?VzZ6M0J4Q2N5ZVl4ZkJIVm4xaDdSTCtoaEdSOWdnODJLS3RPeVNzWHdCVUlD?=
 =?utf-8?B?M2kwUVJkdTFhbjJzTllvNjlPMHJBSnRDM01LR2dPQ21TRE5sMGhOMmkybnNO?=
 =?utf-8?B?OXJYLzM2UnBxM2p3cmRPaGZHRC80OHB1MFJpM29zQ2pYOEVaR00wYnl6YzB6?=
 =?utf-8?B?ckJJalJ4WFRNYm1qbUZwclRDVG5OdUNCRGtBUGZIQ3hNR0ZSTWlLT3FrR2Ev?=
 =?utf-8?B?Nmh6aGlLdytFL3pSTnM3dFcyMFBxY3drZnhEbitaUzZET3Z5dXI3YWM3RC83?=
 =?utf-8?B?Sk1wZ0pnUWhheVRzbWtCZGV3ZEsvREVYWkRuV2w3RUYza296MnlCd2RrUUJj?=
 =?utf-8?B?MFJyS0sxM3JhOVd2UGJqbXl2eUFLOVdUTmxpaDdudXo2bk9sYzBna0tXRUpW?=
 =?utf-8?B?eVRsKzRuVi9OYmdXYnVtcGlqTDE2YlJBckZZeUczalM0cEMxVkxmV1RQMS9w?=
 =?utf-8?B?SUpuOGs3NFNLVmRCcjgvcVpwTmFmV3kzdVFTLzlIOTc2WHdZREdieUtNRWww?=
 =?utf-8?B?L1NlanEwRWFHSTA3Z1JCYjgybFdNdkRjTlpVeXE4aks4eUt0dk1MTGgvT2g2?=
 =?utf-8?B?QlFvOVZHcG54Zm5qYldLMTNyTVhCZjF6SnhHdUtLa2MreVdlL0tsS0o2clBV?=
 =?utf-8?B?cTVnckZBRS93cVlwRWpONy9uQjQ1T050Yll1ajBYT2o2YzdMVWlVQUIrQzVp?=
 =?utf-8?B?ZmZDRm1hZjJxTitnOG1DNVA4NDNyQ3R2RHIvclYzSEZYTjdOMHJjSHcxT09O?=
 =?utf-8?B?N3BBZ0xhb0ZXZkc4MmErVlg3WEcvR0dibkFIUmFMSHhFdFo5MHErcWkrTkdi?=
 =?utf-8?B?SVdnckRqZTlDVW5EWktVQ1dHRExtM2UrSW9vL1BpQ3Y1Y1QvTlZoL09hdTNX?=
 =?utf-8?B?ZXZXdzZjQlRuRlFIL0NnYnpqMFdzb3JneS9UUEJRNE9yN3VNOHl2QVFkNTR6?=
 =?utf-8?B?Mlh1L2I2UC82NFB0ek5iNHJ2b0NMUDNueDhUSGQwN2ZCUm83TVRFZVdkVkNz?=
 =?utf-8?B?VWIvanpHbjNVS255bEJmMGIyVEFXWDdwVlVPR0FsamZVRVAyRU9Qa2FvanJI?=
 =?utf-8?B?bGFHa2ZvRzNJVHg2OE5haWVvSk9DQTNodU5na1Z4ZHRzcTQ1cTZ5QVgxTmY0?=
 =?utf-8?B?cjI1c2g2bURIOHpUL0tQZFVCakNod28rK3ErQ1JxRDRYSzk3ZHhWN3JHdzNV?=
 =?utf-8?B?THJZa2k1K29mUWF4SzNLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUgwNmhmbDJoTnM4d1FCeHFPVXhTM01JUXl2Z1Z5VDdsSkR4Yld6anNvQWhS?=
 =?utf-8?B?ZkwyMCtTVVVObDJCUTlOUDgrOEZ1RDIzR2tiVUJnWWdSZEpTVUxpK2FhaXdK?=
 =?utf-8?B?L2taYVNXOGc3ODcyVkNCUnB2b01HeU5qYUt1Q1hQV3RGZE41b1UvbVJkQ1k4?=
 =?utf-8?B?SEpQMWcxRUVsV0VrNnpubWFycFErcDBYbTgyRzZyRk5zSGJ4M24zYnFyZ1du?=
 =?utf-8?B?RVFJTWxlUVNsM2pjNy8rTjZHamZsczBEZzFwL1RXeElsS1U2ak5OUG5EVE1N?=
 =?utf-8?B?VGFKM0tBK3BrN0J3UHNsZ1lqTGJHK3dnSU1UdzBkUGt2U1FIdHo5MWF2TWZq?=
 =?utf-8?B?UlhmQmlKb3NpZGY2MlVqN0tZdmdBcnpoK0xiSWx0K2FuV3ExbGxyUndocjA3?=
 =?utf-8?B?aHc1Mm9pdEFSalhYa1RFVHFDNFdlQ0lBZnFRQm5mcWN6cjBZWXBRODhrSUZW?=
 =?utf-8?B?bW51RENtS24zQzFYWHIrQ1pXdGg4dGF0TWYzTk16NUdMZnhKdStiMkdEWjF1?=
 =?utf-8?B?TTQ0dUZ1RUt2dmRwRk5YRldZUUhPWXBlTlZhMk5UUnZpWjh6TlRYV1lwTmZ5?=
 =?utf-8?B?ZEk2V0psbFp6UWczcG1nb3JrejNXdkRTUXZ2Q29VSWJOdFkydk5TTkh3WklJ?=
 =?utf-8?B?c05PeEQ4a2tKdE5xcHRFSzd0L2lPTVVTQU5uajkyai9QUEszaDdwNjdxS0pm?=
 =?utf-8?B?QnBlZDJkUW56R2FpZFgyRVI4T2llU3dqVUJiR0ZqWWpHYnVXVkFNbXlKQWww?=
 =?utf-8?B?aFN4RE5wN1Z3ZkJkckhabzQxcnFnQUNEOWY0WHpPMVZaYU9FY2FlQ3o0RHJ5?=
 =?utf-8?B?aVZ2VEI0VldFZzlYNXJaUGM2Ry9zT1F2VzdJYm04b0VRRVZqZ1I2ZWxzTlJq?=
 =?utf-8?B?bUZxYlYwOEMxZ2JzL3pJcVhsS0p1WFBZQWg2SzNuVzBzaGxzK0JCZTFxVjFJ?=
 =?utf-8?B?QlREK1ZjUmkrZHNucDk1TlRhSDM5Q0tOVUh6Z1VCQ0l3Q3lCU1UvbXZ0Z1F3?=
 =?utf-8?B?c2sxVkhrM0g5WFJ0U3pOY2pBTytaOHphZE54Tk45T2x4b1hOMmhaeDkvZ1Zn?=
 =?utf-8?B?aGlhZjA4VzFNSjE0MEtzOVMxSmxCWFBKZlN3MCsybGJlZ1hhY0Y3ekptVU5E?=
 =?utf-8?B?TXQ0M1Z4Y0NPMVQwYk9SZ1pyMjVSbDFVTDFJMVRYL0tkUFd3eG1pT1d4bUkz?=
 =?utf-8?B?MS83U2lFYzdhSzlITVNmWlZqTEFUd2ZtbnZCNjBLOExpYlZ2Zkx1bXJ3bm51?=
 =?utf-8?B?alp0UHZoRkloL29HempjVHpJamFKeTJFR1JFWS9JcWRnaEhmaXQxNmJOM1pS?=
 =?utf-8?B?Smx2Rkd3ajVUQnB6dmcxdnhWaWFzUkdwOVJRemM0RlV1QTdra3JQeUt1U3U1?=
 =?utf-8?B?UmFLVzNHU3VQVlQyeldLamdQU1FoYjJBRVZWYTZjSkxzTFAwajlMajhjSHRV?=
 =?utf-8?B?citnTDljaTFvazQycjIxOFhzUUVpQjNpc3dzSG9pbXlOSEs4R0hHYm1DQ2ZL?=
 =?utf-8?B?a0laTGM2b0grWENTNHZFcWRkQ3h3MkxmeDNxdWZmN1VrcFZhZDQwazRkNzdk?=
 =?utf-8?B?L2N3SFJ5c1R1MW95K0JFSXd2K3NUUUdkeHBxUVN4MG51ZWcvVUhaZnNyaml1?=
 =?utf-8?B?Z0FQZ2IwTksxNTdBbDZvM0NVcWdrS2hrMUxrV2ZYU2czbXNreGY5YmNVaG9o?=
 =?utf-8?B?VUwwWjVQNERTU1NqSEJPOWJaQUgvdDlOTWFGbmNSTnhjVDNLV3NhNGdrUWdq?=
 =?utf-8?B?RGNZL3JZZ1hHcFJ2VGNHWUQ0L2gybG1uSk9icEdxaUJlRk96aWhTRWErbDJP?=
 =?utf-8?B?SE5NMHNjUUJTeUxDclptL2NCMWJmSkQ1K1A3ZnVoTXBGY3ladUJHRk9pa0kw?=
 =?utf-8?B?T0o4QVNOV3MzRFRHK2ZJRFlaQW5GM1pGakhLQ2FTRUVWWEVtVjQ3M0J0SmFy?=
 =?utf-8?B?aXlPcEIvcW9SMXJBZ24vYjRLYWdCc1hsYytEb0VvamU5UnloK0JjTWh0dVpj?=
 =?utf-8?B?S1pVU2taeGNiNUxlNVVzUThnbUk3ayszM1NiU0JNbm9CWWRNYmxQM3Noa1Vx?=
 =?utf-8?B?Smc5cVRZTUpodDY1VFVVY2hPUWVkN1ExQ2pWOUlwRXY3YXZSS2xuVmppMGNU?=
 =?utf-8?B?TjhIV3pSN1pPNzhQZm8yK3V0WlVVUjlvQWI5UEViSTdHd1F0WlYyWTRaTVkz?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaf66ad-856c-44c3-3d8d-08dcd35c3ff6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 18:53:54.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGBYOexN/wY2J3Y1btYYDijSHLira/ZTXfqDdS5oOZgLu7i9sYHxVzDOomGouGtrjt/Qc0c2iyXQIfgMjO+VK5qPqmLGnE8VUfG66/fdtWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6808
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> As preparation for HW steering support in fs core level, move SW
> steering helper function that can be reused by HW steering to fs_cmd.h.
> The function mlx5_fs_cmd_is_fw_term_table() checks if a flow table is a
> flow steering termination table and so should be handled by FW steering.
> 
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

