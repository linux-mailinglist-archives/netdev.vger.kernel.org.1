Return-Path: <netdev+bounces-122964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C59634A8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F0F2866AF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935491AD40C;
	Wed, 28 Aug 2024 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bk6xirJe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6B1AC8B8
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883920; cv=fail; b=LI+yNsxyH5bCNPqBBb7hpfRRkHJWPu7mGTgjRiWKiKYQ8A4NMjViuqJM4QLneLdzXpqfsRa6SLHmqD/Bfnlh/Wnt9usIJQtdQSnu4C91Fjj14fbtSKwdLThIwJCNYBc2yZT4STlu5y9rbuhoTWTgnmm3mPzkpNZyYkf0JcuuOyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883920; c=relaxed/simple;
	bh=CMIm3mis6WL1eJUZrpjY7yyDxJRY7n8cAkffUzNNutE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oczKrB54dSS0t5U/UqVZHfX8M23ih9SjBfmezJEyYhY0F+ssq2LrdqI2U46qtvRhclAexMy/NDyddUnOPMODKmlGX94BWESvvz7wmhy4OoSz2pSTrm4scApEFJ42JMFWfP6Xnwh3HN+A78tTAGm62YW5uQs+kqoZFXUOzXm+8RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bk6xirJe; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724883918; x=1756419918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CMIm3mis6WL1eJUZrpjY7yyDxJRY7n8cAkffUzNNutE=;
  b=bk6xirJeVsWLyqEaTRyMunZLdez3y9FiAEMUxKKAzdGc6s5ROC+IZhhC
   NSI/BKiQTsBpmz6gSlnd7+DAj9I6l96UujNiL3pb+fFq48GOMk/ROUTx3
   8E7+Be0bGSfIHjYNImAh4xsCkL12BMRCAiKu+Gr1QghWIdcuqhBv0Hq+2
   HkXhk3MbiFjzdT8Js1nuHI21GTOCkJwLdo8OzgwfJjpBGqfNe1qyFvm5H
   zjSYycVViqAahgq1B1HoGrKeJYxTHp+WXLYBklI0g7EUKhakKolChUyuf
   u94odeBRS53EtwGoIT2/toka4CgcTV3xpUx7WxUp8HKrREF0llf009mnZ
   w==;
X-CSE-ConnectionGUID: oqD3UfM0SQmDRxuRgHUz5A==
X-CSE-MsgGUID: d27hVNLxS3KOl9aYEEaCcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23589572"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23589572"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:25:17 -0700
X-CSE-ConnectionGUID: wrnTc7DLSsCS9DNKGxvYKw==
X-CSE-MsgGUID: xGESDP/FRqC9d5tHo1S0NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68198883"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:25:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:25:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:25:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:25:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKM/KrYVWbfoWg18v1iRmTlnbYoXkRqfpk49d+bjxKxmdS+RaTM/SIs27mrwANwoy18uaslDWznZwiD0CahL+XMbaJTDbOThngINoaLuLf6hg0TukZPc/jjw3bIFhuclE53p3risPrbIs6h1FyoInfVbx1sOBgVEXlqlunpQ/nuoLMIqw3L74AQnIeS2YrMOY5lQtoY/B28Xnt3Hgu0HZP+jtO75HnINMAYBjd81Kqv7DcJj6D+1XbODjmfCVHhs43Y481pnKZTs48OZ0T0riLGpIh/BdiXdPR3+z7B+UN0310K/yKD5K/WFiHNtGB7NR6PldszfDw2xwlpNBjvzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZBCJTV70vmQOO8D5RGONzR9OUr2i/dhr3PhK5yucgk=;
 b=V2uyT4uq8cpNdChuuGCPzSQZsE6hRowb7ODuItJ+utkCE6R0lcXv7CmqeQQQyzfyOe4S2qno1lLJlOEx038PyivOo6YqxSo1ggQ80Oli14gEihYMX5maeY9nTuzvb2D7P2fS9bM+NlAcToOEz/B/pQbLfSJmkEXpXFNSEF3F6YmLcJ2ddo7uRXWf9Bxh3li9ZuCa3hynfmmK5ta9ECQ7KPV4voEl3YxI6ZOs7GhYy8Bmt7NIxTll3A9aBwajenaEicnee6c6WwzQ4dvni1ksHY7IhYkFS6BWmqpsTl9OqfyJia2orS/GyjxI85wh0EZJoYcGgPW3O3MbZhExaxWhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 22:25:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:25:10 +0000
Message-ID: <d24bc833-e407-4323-9bb7-7149de35748a@intel.com>
Date: Wed, 28 Aug 2024 15:25:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] sfc: implement per-queue TSO (hw_gso) stats
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
 <35782d70ad89c72d5dc819f9a12b2e5b4e742141.1724852597.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <35782d70ad89c72d5dc819f9a12b2e5b4e742141.1724852597.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7893937f-cd73-433b-3a18-08dcc7b04689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGJDaDZkTy9QV0JlanJjaVZiOEl3c0FTNmNSems0NHVzYjNrNzkxajdobnFF?=
 =?utf-8?B?dmNWQmtrSFJGWDI1WTJrc0kyQ2VnbFRlQVFKTWY0OUswVFkzN1NLR2tvdGJ4?=
 =?utf-8?B?Y1RSMnQrcXNOZlJWWmpSWVltSWRoNmRqZ3NFNG9CNzg5TmlpemljUGMwV1hI?=
 =?utf-8?B?QnFwdDhwanQxWG92YXVoNURhb0hXa2JrWHBoelFrT2xNaHM0U3FDcDc5c3hw?=
 =?utf-8?B?UzhxQ0hMUE1mbGlubGV6ZnBxZit2WTJtYW5ZZHl0SjBrWVpxNm9wQnlxMFVY?=
 =?utf-8?B?ekJ3bjdTRGFQaDM3aVJhek1kNjAvVTZlQ0tya3IvZ2tRUysxR0I0V2xUUWw5?=
 =?utf-8?B?SXptdGc2dXVYS3pXNTRCenZxVUg1TFpJSzlNWmJJZmdDVTIxZHZXYWF0OVhS?=
 =?utf-8?B?ZmpxamxRUmRJVllselJGdXpCQjZ6cUFwc3l5SDYxM1pSUzg1cm9EV2hnUmI2?=
 =?utf-8?B?NEhJS3J6SlltSERFU25lUXBWK0haMHR2LzRWbmQxY1E5bytMdkFSc3BtcnFv?=
 =?utf-8?B?UUI3bWp3SmcvWUp5MnlqRm1zUGUwK3Q1N2FLMXRYeXFaV214ZEZmQ1VMMzQy?=
 =?utf-8?B?UFJ2VndzaGFsV3BDVFF3RWNtUUp2ZURhT09MSDJ1dmJaVTdzeWNWV3F5YmNB?=
 =?utf-8?B?Q2ptNnB0K2ZCN0tsZ00wZTJPL1dWeUZ2Y0ZLcW5DVW0rZkQ1TWhETjJ2UGMx?=
 =?utf-8?B?SHlEcitwbktOa1kxUWhrWGlmTlRDNmpReXlNTHAzOEZ5V1ZlczdrcDVVZUdj?=
 =?utf-8?B?SE5FaVZLVFVPTjh1a2ZsU3E1RGdGZC9ocHNYU1VZa0FrTjdGV3VMdmttcGtW?=
 =?utf-8?B?bnU1dVRwL29RdWpwMSt5aXloOVV6Z0N1N0dORXRqeUJ4NURwVFdkYk1MYTM1?=
 =?utf-8?B?RnA5dzUxNmJWSDlTOTdzcTVYZTV5Z2VYSEFERWNndEdjeWdpbTlWdXAreXpL?=
 =?utf-8?B?VkVWTFpoeFlLZGxUYjlWeGpRRGtKdGNTOTYxQWhoczloekZMTjZ2b2p1bTg3?=
 =?utf-8?B?a09vbm1uV1lsOUIyNFFTSnltOExPbzRDMGIyeG1qU1hXWEtSNnJjRElsMWVq?=
 =?utf-8?B?eHdEcFI3UUJlSW5HNGxJdG0vS2hHdGJuekpLdzEyTWFSNGNmRzR0d3JrWnZm?=
 =?utf-8?B?US9xS3VTejFpZXRVN2loOVR5bUUrU1hwb2tnSWZyZHRaOWd4NlZvVjlML1Ry?=
 =?utf-8?B?MWV5am1nR3o0STZSeHkyenVoUDg2MzRvUDFkeGU5ZVQ0cFlCMlplSTlKYVNx?=
 =?utf-8?B?QTM4RlM2M0RDWFNBRDE0UXJOcDhhYk42VHNGQTZ1eGF0OXhPeVFSU3RFUGNx?=
 =?utf-8?B?UHYzNWRIcDRHeVhEZkp2QjBvUUltd1pVY0NiYnNMenFIS1dzZk5uYUpoc2ZS?=
 =?utf-8?B?MWU0WE0vdGpuTE92UjBGMCtLRXNoTzhlVW0venU4d3FlUU9VY3RBbEd2L212?=
 =?utf-8?B?VXl3ZHRZbmI1ckJmMk9sdUlGcVp0azA3Ti9HYTZrNDVBV2NmWkM1RnVrTnhN?=
 =?utf-8?B?OUdWQm5BU29Wd1lVNG90MHgvWUk3V2FrVisxQ05MTDl3amdFZVUwakpBU1VY?=
 =?utf-8?B?LzNCbEdjNDJsT3lBTi83QmhxNndwYUNYemx1eEMwc1lFQlluZHpSYkNoQzZv?=
 =?utf-8?B?OG9EYWRlOGNWWXZiZUVMbkxXSHJERkpqUFRXZ25wY3plOEdFenBUNGRqNzVD?=
 =?utf-8?B?WVRPM1NRQXFZTTl4Q2NZY0NuQkZXRExndVhKMVdmbkVLeDVEZEVCSmVFRlcv?=
 =?utf-8?B?ckxsM1NBR0JZSzBmb1JIUmx1SzZVRGVNa2tBejZsL2NrUmNEeUgrQ1NBQ2dE?=
 =?utf-8?B?L25OdWZtMDdLZTVmVUEyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1dwZnhCR2xXeFM5bkp0YjVLeHhqcTdHMmxPdmJxWDlRNW82ZS9uNmhnNk92?=
 =?utf-8?B?N2RacG9mYXdLdVlCNWthV1laWkp1V3pHa3l0REcyalZWcEQ0ZksxVWVVL1Vw?=
 =?utf-8?B?NkFlS3NaVTNhWjdxd0k2TzZoMGdDdlkvcUR5ZjY3R2tnL0Y4UWVaN20zcmRU?=
 =?utf-8?B?UkpORytiTUFtMGM4bklMdlVLYzN0SHN2YTlVQ09kejhBbmpjRTV1c3RjQXlu?=
 =?utf-8?B?LzB0c01Gejl2Nk5KTm9EMVl0Z1ZLVEFYTXl4anlPZ1BHVVlQbTFzTHBuV3Zw?=
 =?utf-8?B?c3pnT05hT3pncDZHck1ZTGp0QjJaWmg4ZkRReFRLMmhwYjJhSTVHNmh5bkpC?=
 =?utf-8?B?QnVCSmw2cnJhMW1zNVhnMGovTWpPeDZST2hkblFKQVJyeXNOUWdTWFdScFNU?=
 =?utf-8?B?UGprWVJSb0dpSGtZKzNVV2lxNmZRTWMrNXlsVC9kUlAxbkpSYlZrc0h3TXo1?=
 =?utf-8?B?NHIvNkszMWJtb0t5bThzWGIyUEtjaGFsSGl3WDljS0hHOERiS0plM29pSEhk?=
 =?utf-8?B?c3pnSElOcXJSRkFvd1daQmxMU0gxbTl1TDhwMWlBYjhWTmxaQnZTVEtROE1t?=
 =?utf-8?B?TGVmRmRJMnc4Zk55SFB6cW9zVStndWM3M2drWkJ2SjgvTjJuR0J1UEFPT1Zo?=
 =?utf-8?B?VzVjT2pCLzRUUlNTNkhvM295anFQdGgrYU1WVlp5VmxocXpFaXZtd3FYWkw4?=
 =?utf-8?B?VVJYOU54VTEya2tiY3EzMG9mRXJvcU50RFFMeWNsQTJPMkVjd05RWU5PemF0?=
 =?utf-8?B?dHZXdDFPKzhCUUpHa2wzdW1SMXFNUDBTUzNxR2trL2VHbEZON2toMSsxUDQ1?=
 =?utf-8?B?bCtIYWgyK2g2RXBMeTh4amN3Z2lqY3pYbnpONzNrZFUyVC9SZTQ3NU1JR2ox?=
 =?utf-8?B?QnJGVlhseTBxb293SFRPOW1WTWNEWVBnZDJpUC9zQ2ZvRUdnUC84VDB1b2RB?=
 =?utf-8?B?N2xTTnRzT3dsVEpNLzloUnd5OVFLRTNWODQvK2R6a05UdVZ4ZWFXNG1rZy82?=
 =?utf-8?B?K1ZXemtWcXVBYnVyejZsc3pQYkV6TnVoRmVPQW91ejUzMEV1Q3IxbEF1Zk4v?=
 =?utf-8?B?bUdzRmVyS3ZqMWVTN1FLSHl3VDF6Q2c1bldTc0laL1VoRTlMd0RoQndncmVW?=
 =?utf-8?B?WnhWRDFnT2kzWG1ZQ3JjWk5TcmRDUG12L0xZWit3QzdWNVR6Q2MwWG9Sdzls?=
 =?utf-8?B?OUFPTXEwWFZTamRZUUcyT0dsK1JzVWZTTEJEYUo2WGlXalM5a292cHVSd2x0?=
 =?utf-8?B?TzFvcE8zckRWVnBPMm9TNFhvQiswb3FWQURmUUlVUEk4eUd3cEFGb1F1K0tM?=
 =?utf-8?B?eGpUbmlNQ3U0bWlzRlAxekdXSStGQU0ydWE2MU1XM0xEbVNJNlJvRG5ydjNz?=
 =?utf-8?B?S0FEczF1dkQ3OS9XdU9YRVpiUzdFWVhhdWFzNk5NdGFsbzNDU2JGcUtSTUJG?=
 =?utf-8?B?V0Z2aTVObzUyb1JZVnQ0TE91Ync1SzlCLytsZ2FEbVhQdFFtMlRodk9BYkcz?=
 =?utf-8?B?N2FqcUc0ZHVkZzdIM3pEK3BPY2RuWUFhTk1vMlJZc0pLYTJ6VlVOYjRHcHBi?=
 =?utf-8?B?ZlJiNXBnQWlTUWNFc0R1dXhXbUVoMGE4SkZ4TFhxaWlYc1NXcHAwUXlUTGFP?=
 =?utf-8?B?TGxBVlMvOWpHdG12TTlRdWdPdVREQlowKzVZVkt0SHArUnpqbTd1enoxRGNu?=
 =?utf-8?B?YUJ2ZXM5QXV3QS9YRlpRSkg3N0RjRkJRWXVRK1pYUHc2cWZUREhPQVorNVp2?=
 =?utf-8?B?c2R4ZTB1VURDZkdTRXBiak1oYVlTK0ZueTBRdXNaVmJHR2dBT2k3T3gyTDhF?=
 =?utf-8?B?ZW1rTlJBYjRCSHZwSHRhZ3prWmtCTDIrRHZFaFF4VWpyS21LSmxBazRIaWpJ?=
 =?utf-8?B?enkzL1hpcVN6Lzdya0FRcWdlRTZPV2tsdFQrVVI4U3pKNVN0MUV6MG5VT2Jq?=
 =?utf-8?B?cUNmMWM0UkZBWGVVRVd5UHNBcDhGUnlHbHdaWmJEcitGSURjeFEvWFRLc1Y4?=
 =?utf-8?B?a3VNYjU4U1hIK3hXelJ2T01yRHJJNEphY1lTbjBUcGJTbnlHbnlyQmxYbUxP?=
 =?utf-8?B?REFRQkpVYjl1TGwyN3lEdkx6cE4xRzJwMGRLZTBIeVRGTk5iTEt4dEhxMklS?=
 =?utf-8?B?R3dIMVRKSFpBVjBpdHJiL3JSK3luTW9PWSt3Tkc4a3JVUGZUdmx2TVFmS2s4?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7893937f-cd73-433b-3a18-08dcc7b04689
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:25:09.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKFuYZ+d3+QaPy+7rrI0j3JsV36iJHquZAGQ+z/uS1pL8NtEl3bl/cCrkKUrQVVj3QIdq9bODRmgCDOB9hD8A9nxoWZpWbq85yvBsd/UCYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com



On 8/28/2024 6:45 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/sfc/efx.c        | 20 +++++++++++++++++---
>  drivers/net/ethernet/sfc/net_driver.h |  4 ++++
>  drivers/net/ethernet/sfc/tx_common.c  |  2 ++
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 8b46d143b6c7..bf06fbcdcbff 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -653,14 +653,21 @@ static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
>  
>  	channel = efx_get_tx_channel(efx, idx);
>  	stats->packets = 0;
> +	stats->hw_gso_packets = 0;
> +	stats->hw_gso_wire_packets = 0;
>  	/* If a TX channel has XDP TXQs, the stats for these will be counted
>  	 * under the channel rather than in base stats.  Unclear whether this
>  	 * is correct behaviour, but we can't reliably exclude XDP TXes from
>  	 * these stats anyway because in EFX_XDP_TX_QUEUES_BORROWED we use
>  	 * the same TXQ as the core.
>  	 */
> -	efx_for_each_channel_tx_queue(tx_queue, channel)
> +	efx_for_each_channel_tx_queue(tx_queue, channel) {
>  		stats->packets += tx_queue->tx_packets - tx_queue->old_tx_packets;
> +		stats->hw_gso_packets += tx_queue->tso_bursts -
> +					 tx_queue->old_tso_bursts;
> +		stats->hw_gso_wire_packets += tx_queue->tso_packets -
> +					      tx_queue->old_tso_packets;
> +	}
>  }
>  
>  static void efx_get_base_stats(struct net_device *net_dev,
> @@ -676,6 +683,8 @@ static void efx_get_base_stats(struct net_device *net_dev,
>  	rx->hw_drops = 0;
>  	rx->hw_drop_overruns = 0;
>  	tx->packets = 0;
> +	tx->hw_gso_packets = 0;
> +	tx->hw_gso_wire_packets = 0;
>  
>  	/* Count all packets on non-core queues, and packets before last
>  	 * datapath start on core queues.
> @@ -694,10 +703,15 @@ static void efx_get_base_stats(struct net_device *net_dev,
>  		efx_for_each_channel_tx_queue(tx_queue, channel) {
>  			if (channel->channel < efx->tx_channel_offset ||
>  			    channel->channel >= efx->tx_channel_offset +
> -						net_dev->real_num_tx_queues)
> +						net_dev->real_num_tx_queues) {
>  				tx->packets += tx_queue->tx_packets;
> -			else
> +				tx->hw_gso_packets += tx_queue->tso_bursts;
> +				tx->hw_gso_wire_packets += tx_queue->tso_packets;
> +			} else {
>  				tx->packets += tx_queue->old_tx_packets;
> +				tx->hw_gso_packets += tx_queue->old_tso_bursts;
> +				tx->hw_gso_wire_packets += tx_queue->old_tso_packets;
> +			}
>  		}
>  	}
>  }
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 25701f37aa40..2cf2935a713c 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -234,6 +234,8 @@ struct efx_tx_buffer {
>   * @notify_count: Count of notified descriptors to the NIC
>   * @tx_packets: Number of packets sent since this struct was created
>   * @old_tx_packets: Value of @tx_packets as of last efx_init_tx_queue()
> + * @old_tso_bursts: Value of @tso_bursts as of last efx_init_tx_queue()
> + * @old_tso_packets: Value of @tso_packets as of last efx_init_tx_queue()
>   * @empty_read_count: If the completion path has seen the queue as empty
>   *	and the transmission path has not yet checked this, the value of
>   *	@read_count bitwise-added to %EFX_EMPTY_COUNT_VALID; otherwise 0.
> @@ -284,6 +286,8 @@ struct efx_tx_queue {
>  	/* Statistics to supplement MAC stats */
>  	unsigned long tx_packets;
>  	unsigned long old_tx_packets;
> +	unsigned int old_tso_bursts;
> +	unsigned int old_tso_packets;
>  
>  	/* Members shared between paths and sometimes updated */
>  	unsigned int empty_read_count ____cacheline_aligned_in_smp;
> diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
> index f1694900e0f0..cd0857131aa8 100644
> --- a/drivers/net/ethernet/sfc/tx_common.c
> +++ b/drivers/net/ethernet/sfc/tx_common.c
> @@ -87,6 +87,8 @@ void efx_init_tx_queue(struct efx_tx_queue *tx_queue)
>  	tx_queue->completed_timestamp_minor = 0;
>  
>  	tx_queue->old_tx_packets = tx_queue->tx_packets;
> +	tx_queue->old_tso_bursts = tx_queue->tso_bursts;
> +	tx_queue->old_tso_packets = tx_queue->tso_packets;
>  
>  	tx_queue->xdp_tx = efx_channel_is_xdp_tx(tx_queue->channel);
>  	tx_queue->tso_version = 0;
> 

