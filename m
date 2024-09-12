Return-Path: <netdev+bounces-127922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB3C9770F4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA2281B32
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF61B4C26;
	Thu, 12 Sep 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dgl0uJ9C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8C188925
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167171; cv=fail; b=A4IgSWGIeXQ4UPzx05TUcWRLoNSx5MM83Kx8LSm45WXqLZZZXB+zBFOdVaZKgpEsEyJo6DammXRX9WLLvwxR/RvZZ+iK5q94q/detQ41fFGlhhay9wszisOMHvTYGTmkDLQOadQrjjB0WZ1m/OieoYfb1Q/LVmYlO/HUIsHV9g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167171; c=relaxed/simple;
	bh=S12vTvGbLhb55kBC/59loP3AYcN/OIs/ZzV5J7PCvDk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lBf9DyiMzpZF+/nhCK+qwE9rtmBsBlwPWW4R0Gtp/RDE2FqF+KS8C7PTo9ZehjVqWRFqe/u+JGUTuKyDRNhWxC9lSPoBfaV0cIvIfyxKp71nRDX32PooBEJB0F81kE2sQByfUgrroVbbFswCT750F9h60tUb7KjtVpksw9m6zCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dgl0uJ9C; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726167170; x=1757703170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S12vTvGbLhb55kBC/59loP3AYcN/OIs/ZzV5J7PCvDk=;
  b=Dgl0uJ9CNIlIzGL8vK9wCqpDq2g8kwPcvfEnyKDw/Uw/6WRrEejc4qMS
   Xtv5oMYaf4OPLgFguDstBb7BVsIUgrV9hYaB0zmTCrMtixuqxnix2GvcR
   if3XgHcog+oOmOrcbOqJd14jw7L2C3Epb/ZAw72sr+vMV77W5W2X8lYqO
   vKMet8rsEhOhSsvcaS1nM9Bq5sQ9/TYQ2we5TnPalu6g9ORhAh6n5TGkM
   wWwRL0kUJ6R5+Yo7WOULwlicJ4HRlPD0qhOtOgTWkFoYvvJ/jRVkeHuRJ
   Z0JcKrkGCW5M7UWcrj5zMPUQT+QnGCmWTdG9rmobCC9A6b7XZn6ed7ZuT
   w==;
X-CSE-ConnectionGUID: dYuvsH9fQr2Evgf8g1WutQ==
X-CSE-MsgGUID: cfPbtcyBQ+yiPl3n2010RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="13500950"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="13500950"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:52:49 -0700
X-CSE-ConnectionGUID: Zdy/+L9vS2yv1FckT9WOtA==
X-CSE-MsgGUID: W1IjY6jFSMON9QZZuEpcZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67735271"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 11:52:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 11:52:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 11:52:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 11:52:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 11:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcwRDHFrswzPUW5OrUTbh7OC56P5xVgZ05VaUcT07zw3LlFWwfI+ZbbidGiS/d9wR+/4KN2UIfHeZR7iz3uSbjWrphPNR5riVQTOuF3Xg/5tN3i+pnXL9fsLQTr0MZ4b+UiIP57orgFclj4ub3w/PKk1v9hb+mHwMom4VUSvI0fnFMyjEQZ6HrP+Qg2XWM3xpommgyZ2jDG3zbfymMaiDzSFOyKqATtzuwyZgaPvomm7cd+6l/PC1Yke67f6/Cs0NEqqWxBHPwXgf9F8Rfuk2nA+S9+bpd7vi3Yr6hYBfWa3OqsEKEzEmVn6ULo8FKTRQDmdAjmds8zWKrDcBhoymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M4zqjesYKwEzbHzjcEHli7F10cRiKQdUoJGHDTfN1c=;
 b=vQ6SeckS+nuMru6ArQ6kYbPgEAXeFNFQP5/M1ZTwfETsPcR9xVCg5PsjLiPNhpBy9Xb7nQf4PgmcGmrVV3FMi74iyAhTFBLPG9V/AYmXh725rtiWZZjFSX1Qibydgj52A95yfMxBjuwirRRQuwlY9mh8MhY5AyUvB1ajpp6n7SFvy31N2TINctskge0cRlwChxV31/fZjPqS0iVho4dHFn5xrAJavOR2R5fPprg6ytnOholRF3iec7zkjn+51peQM0xEgK2aLjdei2WLo3vmjp56aqXOSNUtH261qhZRVwqyGo+TVQLDk2/YbyjRSVTyAPA7Nj8E2hh9P7Na8SEKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6808.namprd11.prod.outlook.com (2603:10b6:806:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 18:52:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 18:52:44 +0000
Message-ID: <0e3ed6dd-d38b-4d62-9247-b9717bc60041@intel.com>
Date: Thu, 12 Sep 2024 11:52:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 02/15] net/mlx5: HWS, fixed error flow return values of
 some functions
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-3-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-3-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0241.namprd04.prod.outlook.com
 (2603:10b6:303:88::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 1149d1df-b8ec-4fdd-3829-08dcd35c161a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHhiTmFFaFBrN2hTNlNWeHl6VUFZSEJzSFY3S3ZPSFo4bG1qMXh3Ylc2OHNu?=
 =?utf-8?B?c2dlbkZWUGpSWThqYjZSdWhqcHFnTnhpdTd1WGFMUDd2NmU0T1hBdzFUeU5M?=
 =?utf-8?B?OFhkUFhpZXZ6eWkwQ3ZCTldSTnBKUWJ6QW05WWxJWDNkcEVua1VhKzNMdysw?=
 =?utf-8?B?M245R2FlSnJNZkw0cEVqcmFUelVLRzc4bmYrWWdIWjBySW9veWE5SzRQejRo?=
 =?utf-8?B?bmdrQnc4UExJVVVzL25idWZkSVhXS2F2QkthWGIxR3J5TTZqdURGeUZCYkVF?=
 =?utf-8?B?dzVoVW9USFFsMEFJT1RYY1QyRk5wOGs3d09DMGt6bi93dGhCN1Z1aDdMSC9P?=
 =?utf-8?B?M1IxdUtIb1paQzZpTkJLZGFpbkdkZjlpSUxTK2lSdHhua0VQVGVkSFNlcTR6?=
 =?utf-8?B?eHJxVWpkR3RzNjBIWGRwWFdmR0pETVcvcWVMcjNoelU3MDZhYW5pb1NGTHBQ?=
 =?utf-8?B?Z2szQyszdzBUVlQvNEh1eUttUjRXenRnTmpnMytTTXRLV3NPNVBrR1lpR3ZY?=
 =?utf-8?B?ZFFkYnBhTUJaK0tRUDJ0K2pySjkrdEh5YWxGamlXeTVWN1owTjdOYnBUSUR3?=
 =?utf-8?B?dUh5cXN2Qk1lb3RNeEJBdkNiTWlYQ3lGdmdUaVJKTGNEUENmcTZaZ3YrRGM2?=
 =?utf-8?B?MnpKdDJJMGM4Z29iUnJRaG9QWlZPYng4V3EzUmx0Sit5dzU5TEU4VWRxNkJv?=
 =?utf-8?B?eS91czNOMTNvcEN3QkpYR2FlUEFLVGJWNDY1bFpYQjFEaDNJSG9mVTlCcCtT?=
 =?utf-8?B?RU9pazlNbFl2MmtIRWl1d01GY0RGK0hvQTVWWWF2RXdEa1Z2T1J1L0JDOVZU?=
 =?utf-8?B?QzFscHpTYUFrdkY0VDU5My85NUoxSWtHMFp0OWk5ckZzb0RtbjdBSzgzdkRk?=
 =?utf-8?B?WVN6amVDVDJvVVBzUzAxVEV2Y3piNDJTVG1aSFNqUTdwdE42M3B1d0xtaHNO?=
 =?utf-8?B?b1RqUVZlcVhVeTZPL21PNVRVa1Z4TUNiKzU0bHVmVlhoMG1RWmc4SWxOVXB6?=
 =?utf-8?B?QXVydWpPWGtMMW9MSkxXZjcxYkJCaGFqRUhnUDdsM0xVcmRjNGEvUDJDQkJF?=
 =?utf-8?B?a3JJOG9QbWhVVEF3blorb0s2NlBOYTJ2OXpvL3ZkOHlqS2lqWGVacmIvSGI4?=
 =?utf-8?B?WUExZUl1WEZVeHUraDZkSHBYdXU2ZVBFUXU1KzZveTQvcE9pcExoWmtQditi?=
 =?utf-8?B?WDc0ZDVVWm1tVEhiT1dHa25IeFZ5R3RiSitUMi83TStTODlVaUYwZHhya1FF?=
 =?utf-8?B?YUJUbHk2RnlUUEZiQXRPcW1SREZPREZOS1NLL0ZJcnB6Z1lERDEzSmxoZXND?=
 =?utf-8?B?eExTQ1VUVTNRVEc1eng5RE41YzVpZG1hRTdwM1BrTjEzR1oxYjl2SklNQTd1?=
 =?utf-8?B?QjhQTHFRZjdNbUY1UVdPYTZqKzNUMkhpcHJmM1hFbnhyQm44em1RQ1ZIY0Mz?=
 =?utf-8?B?T0ZWN0JLTGw5c1hGTlVtZmlxOENDNitEelc2UXhQbVFxNyttTkpOQkJVSnhW?=
 =?utf-8?B?YW1Bd29DTGtrbmlVRDd3ZDBMV1A0Y1ZVVC9yWnQraDA4cUJPLzJNb0hvUU1D?=
 =?utf-8?B?SGt1WlVGSVdmemFiSGxFN0xma05LVTNLSnNSMjlRZWtGRzlCMWhKQ1l3ellU?=
 =?utf-8?B?cTdRZjVrREwra2tVZVQ4OElJaXlLYkhVa1hFQk5oenlPZVllSmw2VG5NNnVk?=
 =?utf-8?B?ZEFuc1VhMTIxcFJyVGUxOGI3WlV3azRVdWxPSGlLMytBZ0RxWDRDQklzNXhu?=
 =?utf-8?B?M2ozSUpDZis1bi81K0RwV1R1cDg1TURwbjFJUGdCWXRUNHdOV0R4V01iYVgy?=
 =?utf-8?B?bkprdWQ2WDBWVTFpblp3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9sYW5ubyt5UnFCZG9Xb0tZMm5reDMxNTNYNDJvK1I0c09vRldPRHk3K0My?=
 =?utf-8?B?RXRkV3MxTEVDaDhlbFpVWDUrZGdVWjRyVDJsc2lYc0hoM0p4VmJudXpSdFNa?=
 =?utf-8?B?eWt3U3BuTXVnbFkxWVJFQTdnaEZBdmFPM2RjUXZ2Mzc4RlFaQyt0MnVrVEd6?=
 =?utf-8?B?eSs2RkN5WGtQZDR2K0lvdU1lN0U1aFJZTHZlWm9iL2YyQkwrc3liZXU1Q21M?=
 =?utf-8?B?TitNVE9LU0lrUmFtUnQ3RnVqMm1UVEcrM3JSMnlCejVSUlk4RDZrSms4VnY2?=
 =?utf-8?B?VnlEK280K1JzNEJzUk9mVllpRTM5Uk03QUs3TnFwQ1BxTFlqWEd2MUN2dERH?=
 =?utf-8?B?WlRvOEtiOFYxR3JnTGpZR3YzWkJvSm1MTTgyK1BqMU5LZGlPMzJyQTgvQU02?=
 =?utf-8?B?bSt1VENVYWJKWExLNFQzQURMZUIxZkU4c3FKaHFuRFFwN2lqcENwZTJpYXZI?=
 =?utf-8?B?V2JCZC9wOE8rZnVsaXZick5UdVFGYUY0dGd1UmtuNEIxT2dZcCtKNmtxbGE1?=
 =?utf-8?B?Qzk1a1NlZjNwWVdKcnJjdlZrLyswU2ZlM0VhdFUwcG9ITS9pNDh3SU13THhC?=
 =?utf-8?B?eFlZeGlEa25hYjdwQkZFSUpLWjRyUVJRemZTdU93QXFZblZTenh5bHFzVzV6?=
 =?utf-8?B?R0VQeWZaUGVablVINExxT2FOMmVuZytDSXdzZzRVMUs5VXZWZExDaHFzZFZF?=
 =?utf-8?B?dGQ3RjlVRjhyUjRjUGZhWFpHRnRjZU56SmRVc0pqTzRIb0wzOVJMWVNubU16?=
 =?utf-8?B?Q3dkY0VJUVYyY2ZEc2p5SWUzNUhIeFY0R1dlRENFR3VrU0JWKzI0bGZHNUVD?=
 =?utf-8?B?UEloQllWT1drWlp4WUxtL1pUcjNhNmRLbTd5QzdKU29aUCtGMVFodE9rYWNP?=
 =?utf-8?B?OGRqUWV0MFNsaWpRclpGL0dGbk56YWlZUlBDK090bGdxUGpSNjhEZElEWVJt?=
 =?utf-8?B?ZDBxOU1LWnIwS1ZicTVtOGw2NGFuWTEycGd5QVZCZFM4RXNQWStlUVRMYlpJ?=
 =?utf-8?B?YkhQMk1kU0hHOHgvYTVPVUcyK2JnNmw2ZTRMUlBYTXQ4dmJSaEthYnhWdU1u?=
 =?utf-8?B?THIwOG4rWkx6Q0hKY3F4SXRMSTRiZWR3U3l2TGRQdnJzYm00eDZmSnQrcnAz?=
 =?utf-8?B?VktQWHN5U1ZVeXN3WHNhZW1PQkhzSXVTaERPd2lXeUt2OFkxcU8zK0VGdk1p?=
 =?utf-8?B?MUZabjFsOFdDS0c2dVJrTlhqL2FKK01GVTg2RnNvM1FFVGFzc1l6VUlBNE95?=
 =?utf-8?B?SlhuOUgwd2JCR1pCdlRNOHFHR1BqZW5hNFpjcWxESWpUSkFQbmFHbXdhQVBT?=
 =?utf-8?B?MVRLMFljbHlZaXpQQ1ZWVCtuVDdLV1o2TUdkSlk2UGl0a1B3TVkvVDJoMFZw?=
 =?utf-8?B?cHJnZXlaTVVFK1JUS1pFemxZQmdmQ3JYS3dpUCtYZmJ6K0xqeTRnN3J0RHlC?=
 =?utf-8?B?NDBRSXhpWGZldTJuYjE5WlVGWFBBdEFQTmZEMUxFTWJMNUxDL2c3S3VmcnZn?=
 =?utf-8?B?TXVVUldkaVZGQ0RkK3JKNjJ4YXBtaEUyR1dQNmpYSG5OTXJVNG9UTjNnTyta?=
 =?utf-8?B?QWJGS3AxRis2KytWTkVmUEl4ZTB6UGJJOE04RjF0b0tmcTU5dU1Yb1hiWjJk?=
 =?utf-8?B?NWhFUWhGdmlTaEhkTDVJSU1UUmJEbzBnMlFEMVhyZUw2c3ROY2VueXl5RmVC?=
 =?utf-8?B?SEthYURHdnhJbld3OTBYRG5uMzlwLy9LQ2o0M21UWGNJTUhJOVExVHFxelpX?=
 =?utf-8?B?dTFuZVFBbEUxWlFOZitORWUrcE5VUUpzcThVS0g1YW16V1ZMSTYxMUFZSG9M?=
 =?utf-8?B?MlVVVE01ZUgwN2hXMTRibE80M1ZlMXNOa3g3azZFUEtpaXYwaFZid3BqK29V?=
 =?utf-8?B?ZGNKdE01ODQrMldWRmlwc0plSUozMWxKd3hmVExBREpuSkpOaVlSQ2Y4TGpO?=
 =?utf-8?B?YmxvWDFBZ1YrUkFPVU93SlN0a0o1b1JOeG41VHhISW1NQW1XUUZaSWdWM2pk?=
 =?utf-8?B?bzNSajVlbjlmOEticHE3bUZob0JTWUFoR0NobTZteXU4bDZnSHJDeHlRbXQ2?=
 =?utf-8?B?dVFyanNabVh3Wk5VVVpqSkp6V0JSNHZLb1kvbDAyeGxEM012M3VwMnlRclha?=
 =?utf-8?B?ZFp4SExFQ3BhWmJGUW1uRVVtVk92S29DUlU5VG9oTkNBV2ZWWURCalF4bjhB?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1149d1df-b8ec-4fdd-3829-08dcd35c161a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 18:52:44.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZp5GhoGyMqadHvbWYej+oPtBIW3zYNvTwG9Yc+FLLs+Y0dHalgPw8qcCdY3YxE5YQpfjbDArZSMNhCC8fDOnUhgnh2h3cugNGPg+Ez+JQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6808
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Fixed all the '-ret' returns in error flow of functions to 'ret',
> as the internal functions are already returning negative error values
> (e.g. -EINVAL)
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

