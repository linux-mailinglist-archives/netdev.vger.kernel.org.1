Return-Path: <netdev+bounces-218001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27B7B3ACCB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 23:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86BA583BED
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E10285C96;
	Thu, 28 Aug 2025 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJUL5HqP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1E265CAD
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417003; cv=fail; b=twADxYFMdypoyuF/u4Fn5XRuvmQMrxy+TK9i/AhKec5DpeeQbrY5tMFsAyihNN9PbIyVkwZ+PDcnmo78SEKxxHzZ/fLCjCvlM9vGXvq3jmZ+chM2Zn6mV5VqDQjI3hQrkQUW/wFNVPucAuEwFp7jLVDg/OXKV1UMdfOjOSuf3w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417003; c=relaxed/simple;
	bh=v1n0kbVb4vZnQHZupIZSNmpcuNk054eEbGi0JnE/4jU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NcwN5MvmOnMzfc5nOwiz9VviUnFrp9iAMdayc5f2nRoqO2gLIal2Ce6nQmpftp8D+WMwMRvIugF2AdkGqZ2MRukHtBBk9RdL9qCK2tQne4de2TeTyG8LKoS5kGiqaVfX4PP/nX+6f45qpb6jC1RGU/pfAzp9x0BfewP5oyMb+RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJUL5HqP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756417002; x=1787953002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=v1n0kbVb4vZnQHZupIZSNmpcuNk054eEbGi0JnE/4jU=;
  b=UJUL5HqPCH7ceF5Q9+CyEn6z8fmvuwHxDUx/pt8zj9eMdUVQntiv2wgJ
   00OnnKDr0fO6dJDvPU0g24XJlAH57uDs6WUsBAvOsitTqK7xaDTVUvK+q
   aVIPnjDLA4ckKkg/6A8FxQb6iuzRrsuhWb7Ua/NU9I721rI4V0vacjVJP
   RiqzD2+uxBM3O+RK9c1kH9OB10cQdR9tDn/AB5wNYyaGs0+eQmGoNuyox
   cfIYtdjK6OnBLctsgZwqGHUF59C7ui7PtZEyPcju5efOSp6z2bHBGahki
   XaatZPJhS58+akwC8ksVaDOykpXm1r8WVL0w1z5zWq8C00CrUfTuI4h83
   Q==;
X-CSE-ConnectionGUID: sxEjE2FUQ2i6PFiKJWxnpA==
X-CSE-MsgGUID: hUDBAmvxRZidi/ayTzj7Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="46273248"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="46273248"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:36:41 -0700
X-CSE-ConnectionGUID: mVFrPHAwSYqFVOQv7pqXiA==
X-CSE-MsgGUID: jbTTxWghQWCLdbMoK9TAfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="193883762"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:36:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:36:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 14:36:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.89) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:36:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol7Jvg1SzVbRfViIhKsZzz48Qjyy1kRVu9BXY0j4SzzSkBvgNS/DAZr78a6Lk/rf966I+N/wbs3F1c/gdmt15y0T9regZiHzehW/EZnKLeRb5tzU9xgW+RImaam0YU7fUGJk2DpOi50e67JzZdlo5z2/fr+AxiPPQ6DAaD2QowOh6P+w26qGuo7jZtGcnjMZJpfkEQ5+VD5KyeZ7syIM/HayARW8K9eUwud0S1jDVuy4RQkNgSA0NDwzPs5s/I+FmcGZocaQMMC894FXvZrNSDsWzkYkY0hAYlhLjUFtiwvytVrCeVSalIuvBk00+Eo2G4DJSU/jWomcNoPGAKmmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1n0kbVb4vZnQHZupIZSNmpcuNk054eEbGi0JnE/4jU=;
 b=xS9d9nTQngQAqtmuCuzTUKtoEF+RrmsmisKdTqQlRgSPIMrD+aE+qFyoCIlDVFCxglmdZSRYha173nOmiiwc8eh0lJuo/AKMJ9rHsYWe02jTkZ0ddGDseRIeiDWOuQgZTb/ZJD45nLtdG0iZSxMxMn+hxRW6I2oZeNR9/SvhXgP0Gw+oW9BsMCWj0708FTN2d3OJ28TjnJwsrql2Gghq8Yu2nuTwEnbFi8grNF35xhjwL5EYAHZPW02ONAjs9DJjyjCQGB1muMcTpHOi8Yh9VyNt+vq8OzLJ0x8Albz2eWi+cwrzkCvYbri6bbXFgJccelD5mnndO5+l3f9IpelP5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 21:36:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 21:36:26 +0000
Message-ID: <b93a3655-0bfb-417a-9ee9-2308eb8e8d69@intel.com>
Date: Thu, 28 Aug 2025 14:36:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH net] xirc2ps_cs: fix register access when
 enabling FullDuplex
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20250827192645.658496-1-alok.a.tiwari@oracle.com>
 <20250828172123.GD31759@horms.kernel.org>
 <3651704d-fdf8-4181-88a3-0c88fea7f66f@oracle.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <3651704d-fdf8-4181-88a3-0c88fea7f66f@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------tkkI3zmyDw6rMMo7TadSemIL"
X-ClientProxiedBy: MW4PR04CA0343.namprd04.prod.outlook.com
 (2603:10b6:303:8a::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH3PPF9E162731D:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8059f7-62d4-4231-a5a6-08dde67af086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEJwTWJpdXBZMnhrUks2MlhScWdFQUszWE9jb2ZhL3psZFBsQXU0OTRuOVFC?=
 =?utf-8?B?NjRCNkxsTDBjd0RzWEZFWklKbXE4RFdpYkxQMlFTVE5UNzNQU2I1Wml5aFZt?=
 =?utf-8?B?dFY5RVJiU1BmblJiT3RpVFBCT0NuRi9lcEdkSkZLOWJwckhQKzlmd2VRbXc0?=
 =?utf-8?B?WURTQ0piS2ZUdGxOSVdJWk5tN3V5VWtVYjhoWk04MERqNWEyTTFFUGFSa2hK?=
 =?utf-8?B?bHdhRFl6cm53KzN6N2Rlc25PaDdRWDZBemcwUThEaWNGdjFhVENYVFpSOU51?=
 =?utf-8?B?Qi9OaW1odTA4bmJvbmY5cHFwanZmT2IvQTJ5MmNZbWloNTJzdW95ZTJQcVor?=
 =?utf-8?B?cmZJcGZmRlpiYzdrSnhsd0tISnNsQTRSWW5wUTY5OFFsQjNXVEwyTEl1SE9D?=
 =?utf-8?B?bXhQNyt1NUs0S3dqV0ZLSmR2Vm1MOElyTUF6cFo3Q0hWYkExQmRlZ1owcTMr?=
 =?utf-8?B?aWFOMFhiZjlkNUZWbDhCZ3RBeXgvTGZFQ2w3azEzRXh3NjIxK1o1WG9HRzJF?=
 =?utf-8?B?anVXbXYybHFoUVIxRy9OWk4xM0tEbUdBMDc0UHFKLzdybDlxM3dYQlEyR1dN?=
 =?utf-8?B?aDdhOWJLWHdDRE9iYjloUGZNZGpONWMxM3EzSlZpZ09jZDRJUXA4UFFzVDhB?=
 =?utf-8?B?UENKTFYxTDRXZkw0azB5MCs0S0Y5Sm5oTlBlMndHdWk2Wmpiem9KVWRuVkdl?=
 =?utf-8?B?L09MZGFoSzRWbnpPUGRMVDFkd2dtT203eWRaeUI3Y2RpOHp4MmNCbEZNRUZo?=
 =?utf-8?B?R09lMzk0ZWlWemh0WG9lUERnamZqSDd6b3VWNjhOdlZFa1JzRlVSY3VKVXNZ?=
 =?utf-8?B?cmtFVUpQTmFEbXRtK0oraEFCcXo1cndwc1dBOXpKdnNrbUVQdlNaWkU0ejNp?=
 =?utf-8?B?dzhRUG9CYUlIaTNaeXlVeWdmR3NpQVFTa3lCTTVPRDVwOVA4NDRiVE5GeDBi?=
 =?utf-8?B?ZEZuWUNYWUI1UWYxR21ZRzVFb1BHbUVUZ3BuOHBubTc5YlhHUW9HSFFnRVdF?=
 =?utf-8?B?RUdnYm5lMkFxSUpPZmhtSmIrTXVZYS9PS3NwU2M1U0lrZCsvbDMvbDRGa2hY?=
 =?utf-8?B?S0VBNzZmQ3loRUgyTGdDOWdqalF5bVlRaHRGSEFFemVvS2l1K0ZaUlJzcXZW?=
 =?utf-8?B?MlpIVjVLT29XSEk5NzhxbkhiNjdYNnJpOFdiZEhXNGtHa0lSc0ZHVFQ3MVFl?=
 =?utf-8?B?Zm96NXF5K3pIQjFjWmxuOGo4UVMzb1ZpY3dPZDVTNGVGNDJIOWtGNEJON0dq?=
 =?utf-8?B?MDlzN08vYTRLdjBoUXdCT1BMNGFiNlU3M3laSFVzRWxkVDM3TC8wcnBaTXIz?=
 =?utf-8?B?UVBTU2xveE5qZnIwWVVXT002Sk5uSndoK2FjUC9lYXNxdzRQVWkvMGJtUnVT?=
 =?utf-8?B?MVZYbnJtSE5ieWhCK2dQcEhDNXpVU2tsVlBLdTZhODVaQUZjZGRFSlBiTjZI?=
 =?utf-8?B?MW56YllLaW9nSkRTZzhPQTdtQjFKampZRHEzRVhBbHdwTVVndXcyNHN6ZjNX?=
 =?utf-8?B?dGlkWWRPMlg1ZzhCTll5NDhxeFFnWTZGaUd1WG5GZkdvSXI4R2p3ZG9FTWxx?=
 =?utf-8?B?UWMxTjNvS0tqODFEM0pkRkh5MkVuNWdSNGJWcktaNjBubjBYWlpNekN2THEy?=
 =?utf-8?B?QlZlMk9nN2k4ZllKbTBFZDdFVXlQdUorTlg2QlFHaEZsaVRPQUY5RENjU3Mz?=
 =?utf-8?B?bVNIR0RHWVdDQmJ0ek8vdVJvaCtiWHdBVy9xTGtoeFpqeUJ6eG0yd3NkVTVD?=
 =?utf-8?B?OVN3SFJlTEp6Q1FzR0Fkb0lsU3R0ZzdTK1ZSZkpnR200cE9uaDNlTXFNRlU3?=
 =?utf-8?B?SnRIQnNRSUsvWExQSVJZWVpqcHFMRjRKTHRxelNuMnBUWHRFVE80ZzJZaHVw?=
 =?utf-8?B?Z3VkazZSRi91UXMzbkFHeXdlVEJXTUZTVmlKWlFiYW9iU2dmZUp5VHl4SUYv?=
 =?utf-8?Q?LS9++f4cLUA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1c2UUZGUG04dm10YXI3Rkd6SDZtM2Q0VzllRllPUjNTSnVQYTZTcHErbjVo?=
 =?utf-8?B?bnE3cHU4cnAxNWRJQ3oxMVhYNmRUNTJoc1hKQjl4NzRoWUN0S1FLU1VXWDN6?=
 =?utf-8?B?T2NMMnlGL2V6MDlIRTFiY2huWlBKK05tRi84UGdKbnJMWExrSHErZStwUDY1?=
 =?utf-8?B?VFNNaVlCa1U3WGgzN2pFYXpSY3pmTlJKbXI0SjhoYWU4eHdXM2JwNWJuU2Jn?=
 =?utf-8?B?b0V4UHNKWFB2R0FHVm9OS09LRHhyTTdXeTU5Ujg1dE42YmNaUC9GWEdTYnMy?=
 =?utf-8?B?QjVYS0RjTDl0eTI5STB4OWgvU3JLd0ZBL0pkaVlDQjYwRnRycUIvdU04SXBs?=
 =?utf-8?B?MWFvcXprUWNkaDlTaHlZbXpFcTlGRlhsSTJUMFlZbldoRTFPNTBjbjZNTE55?=
 =?utf-8?B?RkVPSG1qcVpNSS9yZGlwdGpRNCt5ems1SjAwVzRXSjRaZ0VOOC9rVmRMYUta?=
 =?utf-8?B?R0VUWnpLaHV2TngrTHZKT0h1MlFrWlFTZTFBRHY1U2pRUzVvQVFaNFR5NFVB?=
 =?utf-8?B?cDBWdm92cnM5VkVHSmppNkhNQyszYXhWUW1wTFFOMVRudTB0NlJ2blE1akNi?=
 =?utf-8?B?dndPTXVVbzlPcEhxRzdPTi9CZ1lFWjA2RmpYaU5xUUdNWjVnYW1vU3MvYWRm?=
 =?utf-8?B?TldHaGozdTlxTW1tRUpQTVFvZTBmbHlQRmtRMkZJaDczMDdkeFpGQTU5akNG?=
 =?utf-8?B?NktiemxXV2pVZFVzQzlyZUo0K3JwQkpoS1laQW5ZanNhZ0dzdHUzeDhtaTh1?=
 =?utf-8?B?SFVLbm90bm53RFlEMThWa1FzUEx0RUJQaFl2WW15bUVxOEJwa2xqK2R1bTky?=
 =?utf-8?B?VmtqRGR3TVY3dUpPbzRRR2ZiN1dGY0E2Zi9sNHdTSEY0NWVlby83aHRjOVRh?=
 =?utf-8?B?cU5tL2k4cTRmYUxrZGZ0Sm9kS0pxSnBGUDY2Tm1TZDNEUTk2VzBQNzFGQ2Ny?=
 =?utf-8?B?QzBlTk96clJ2SktrNC9Bc3Z1dWlaQjVSVDlxYjRRT1JtRmRGanZESjNFSVRp?=
 =?utf-8?B?NWE2VThIenJydEFCQXA2M3ZEbUhTelVnTTQvbENBZStYSTBzbGFvV1lPb2cr?=
 =?utf-8?B?YjFXVXBYYVE3dEJrekNWNzNBeXNaWUttY2tuNkVqSjZURGVOYjQwUk15cXh1?=
 =?utf-8?B?MmV0TjNBUGN4UmRoWkNaZkNEU1lnb29pYklpMldGS0NKSjdKSzN5QTZqNFpO?=
 =?utf-8?B?S1oxOUxsbUQ0eFBmWFZmWVVwbkJmcUZqN2RFZU5pNG5BbXNvYjdBazNOL1Ez?=
 =?utf-8?B?bENYTDlISkZaTS82NU5aQWhaSmJLSUlrYTgwaFNlWDlqcEx2ZG5DSHJBOW80?=
 =?utf-8?B?S1p0bEhTQ3p5Z093QVl3dFpxazhnbzZjdFJVcmVxV1c3cWdheEMrWWlYNHpv?=
 =?utf-8?B?L0FVZHhVNXVjbU5CYkcwK01aRk0wdWVUZ29lcHVhKzFpRFhBVzRBTUt5dng1?=
 =?utf-8?B?TGE5Y0ZPMlZtYlJ0Nkg1K1J3QzBFOWlFeWkwYzV0azhuSWFEKytBNGZjT2lp?=
 =?utf-8?B?Uzh6VTIya3hsbGlMUFhVWWhZYm5mR2toOTQ5OGQyVU1pT211azFNWUhCZjJK?=
 =?utf-8?B?RmhoSEJMU2ZlYUZlMnZDWWhHaXNoeWo1VmtFcWFNRG1ZWVJPeFE2Q3c4dmd5?=
 =?utf-8?B?S1V1eEFNTUwyUnljVm5yRGNXM3JXUU1PcnFwNEdYekEybHVscTFUbXNXM0JE?=
 =?utf-8?B?Q21NTW1ZOHF5ZmpvR2Y0VUF2eGYwZVVrOVFKcllBV3Fxa2JTaHozb1VTblhu?=
 =?utf-8?B?Nkl1KzA5dzloZ2FqOU91cVJTNGNrSXpNQS9ZZEt3RGtOaHlnR0NCZTYwZlZo?=
 =?utf-8?B?bk9UYTFvSWxDK3FlSG94Z3AxdnpQRi9iNUxlODlaWnhYalUvOG5BR2Q0U2Va?=
 =?utf-8?B?eFBnZGo5QlB6a1pHMExLRy9Sa1hqa254cDJyVy9TSkw2eC9tMlJwTTN1TnFv?=
 =?utf-8?B?amVBbkRhMjFrWFcvZW41b28vK2dNc21Bb01pdUwrWURJb3RhakVxSmdrSVFV?=
 =?utf-8?B?ajhTb0M2QTJkM1NJbGN2ME90Zm1Qa2U2Y3FLQk5wTlA4VnM4Y0QxN2htLzB5?=
 =?utf-8?B?UzRyYlNmazBGUDhZQUtKTWQ4UnIySFgvVXJLVDc4WnRwbCttOWlxQnRSQk1Y?=
 =?utf-8?B?bnBHWHA2bWh6UVVGb0REeTcxUG4wNUI0d0VqR3lFejJ5TnNYSC92SkE5WG1U?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8059f7-62d4-4231-a5a6-08dde67af086
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 21:36:26.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SWmlG/XoJ0t3hp/3yPFyKYQhzlPJsuM8hDpkh4cneut33ssBzfqQ7cLOvH0tJB+I2bR2SeInJutWmDQnBqVc5dsxNZUrDRqp9fybGoRUM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9E162731D
X-OriginatorOrg: intel.com

--------------tkkI3zmyDw6rMMo7TadSemIL
Content-Type: multipart/mixed; boundary="------------zcx4O1u071D968Fa0WEwJlW2";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Message-ID: <b93a3655-0bfb-417a-9ee9-2308eb8e8d69@intel.com>
Subject: Re: [External] : Re: [PATCH net] xirc2ps_cs: fix register access when
 enabling FullDuplex
References: <20250827192645.658496-1-alok.a.tiwari@oracle.com>
 <20250828172123.GD31759@horms.kernel.org>
 <3651704d-fdf8-4181-88a3-0c88fea7f66f@oracle.com>
In-Reply-To: <3651704d-fdf8-4181-88a3-0c88fea7f66f@oracle.com>

--------------zcx4O1u071D968Fa0WEwJlW2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/28/2025 11:49 AM, ALOK TIWARI wrote:
>=20
>=20
> On 8/28/2025 10:51 PM, Simon Horman wrote:
>> Interesting.
>>
>> It seems that XIRCREG1_ECR is 14, and FullDuplex is 0x4.
>> And 14 | 0x4 =3D 14. So the right register is read. But
>> clearly the bit isn't set as intended when the register is written
>> (unless, somehow it's already set in the value read from the register)=
=2E
>>
>> So I guess this never worked as intended.
>> But I guess so long as the code exists it should
>> do what it intended to do.
>>
>> Reviewed-by: Simon Horman<horms@kernel.org>
>=20
> Thanks, Simon. your analysis is spot on.
> It seems this never worked as intended.
>=20
> Thanks for the review.
>=20
> Thanks
> Alok
>=20

That analysis also explains why there haven't been complaints about any
issues with invalid access to HW registers, since the address read is
"correct".

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------zcx4O1u071D968Fa0WEwJlW2--

--------------tkkI3zmyDw6rMMo7TadSemIL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLDL2AUDAAAAAAAKCRBqll0+bw8o6MyV
AP9NT+cykpr3t7wD2592YS8WfsHmOl2enXmmsz5CfVvn1AEA5cyWFucSVy30o62ylXS3E6elaENE
7ueN9t1X9cgcyAk=
=mnjr
-----END PGP SIGNATURE-----

--------------tkkI3zmyDw6rMMo7TadSemIL--

