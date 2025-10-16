Return-Path: <netdev+bounces-230175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48C8BE5036
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324761A67F22
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703AA3346AC;
	Thu, 16 Oct 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oARmhC8q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77973346BA
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638430; cv=fail; b=JM2HXM/YfDdcnkworhDgQEt044EHyM6hzuUwV9Ijp1HCxKjFJRcAoc89jWs/xIv2SHVIozP7BusxkQHeNNGUDZWahK1Kbf1MIzhaFnXviHELwr0LmABgAi3sOi5ULOJIrvwLI1cFc6E3qElC9g1bWpPVnVStis7XFb0bn1Rie9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638430; c=relaxed/simple;
	bh=DpKrjoZXIycl3u41+Gw4Iwfr/VQuRvBLIGh30GhyIAY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f51BAHro02SiLiaA4WXf/o2gY3dvozTs9pFE77EzUnHi8V5iiQrABgjcf8/1AAaO0UjUSjsR4BS0y0lPr0JKCFQmq6sv0Zg1igFXxlHmloYuYuXIoa3emnpuxOs8phFKy+MaeTnqzM4JjpJLWtP4rkrJCdtkPSA3oBeOv1tNjqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oARmhC8q; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760638426; x=1792174426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=DpKrjoZXIycl3u41+Gw4Iwfr/VQuRvBLIGh30GhyIAY=;
  b=oARmhC8qThNm1jdTgqriXTLPGuE1oEYySgtpncS3nj12ipC5wztiViAq
   HC5sLFRBVUZuSic0T5kEWVuw+19M3btNPgqVKsWo3s7QN1NFqNkFLOIBP
   WJ5mokp4obFJgTZrnul8cJ+lIpWHCs093ENTWCiA9vBxUY/t4SHOXR9r4
   f2GNb6P5AUbN7WQbXsEo+WoLInaltVWyX3ZJrbrwJHqNEkY4hhf+imInx
   lqzIz2d+fjfjyqiXallNMu6QX6EZiu1Gr89hbLiW7hnTVy78T+dPCM47w
   Yde5ch9Q9qaKjrkEa7WSX+fcJpq86dASnAt5cd519CdauND7iOOBYMtXB
   g==;
X-CSE-ConnectionGUID: HgakVBQaQVe1N2TGmKEyfw==
X-CSE-MsgGUID: T0tulZ1dQqWm31a/kHUoMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73958620"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="73958620"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 11:13:45 -0700
X-CSE-ConnectionGUID: P8T2F64UQseQ5PBnKYB52A==
X-CSE-MsgGUID: M4SgSL6rSKGeYw4YQZvXlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="186794590"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 11:13:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 11:13:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 11:13:44 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 11:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xf8ambCusGQ7vwOEWIIQRmUppn7v+KIjlF3ZQX0fh2nxwkGZDjMFzbSX0CBkyDt/IoqX1eRUxRh1sy0fX8PojiMosOKIVEkON735fezrJ7fefjQg7ZVm2EEjAWWNMdEiT8lLRkdft+KktZsIiT+N8B3c22sGqqc3XKZGKhPS6ArMo2vQzdeGT1yUW1SdKPBrPYy+MC4hX9MjXw6tLPwvOnxHah+G2FhKd8t/H1QUPxAVW8DSpMNMkrAi2daJ5lwQI6ZBv/jp1sYTEla7j6q+5nsTxGHeUJUDhiOTxRgbAfUqtcQq7c9Q29zaDfVRoBbVud7kgBJJBFlsDUluA3ghrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpKrjoZXIycl3u41+Gw4Iwfr/VQuRvBLIGh30GhyIAY=;
 b=M9rF8k8pgKGhH4n73W6VcI0oV3NzIpeL1qBKEwvv1EXFe72WaVxedG7nII6Ft9hnm1XxWGcWhTKfW3ekXGTlbRJkRUQ/6qxe4ZoicUg4bD+bE6V/kHI2AwPBoHW1KnJGpesbKPFVUKiyHOYAYgPLdsxiyu7Sikv+zsmke5/mDrAQLj7sZwTNDoBxylmg2vLBT7rTTbuS+l9zS+GtAJlxFtP14KD2Asm/O2o6CGJsm06TYwjJcwqjKpq85kubGjmctYFIV6gXmk0RE9TZA3J16niZXkS/bCNOrnxfBIWc1xHDecKWC6KKKrYGnhY/V7fxfjtaluZdQUKB8zY55OgEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB6012.namprd11.prod.outlook.com (2603:10b6:208:373::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 18:13:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 18:13:40 +0000
Message-ID: <c8068fc5-4248-421e-b1dc-288dad494909@intel.com>
Date: Thu, 16 Oct 2025 11:13:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 6/7] tsnep: convert to ndo_hwtstatmp API
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Egor Pomozov
	<epomozov@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Dimitris
 Michailidis" <dmichail@fungible.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Simon
 Horman" <horms@kernel.org>, <netdev@vger.kernel.org>
References: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
 <20251016152515.3510991-7-vadim.fedorenko@linux.dev>
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
In-Reply-To: <20251016152515.3510991-7-vadim.fedorenko@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------h5dztU4b1m5vhN2yhCDo0uCV"
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: fe18de08-7860-490c-d00e-08de0cdfbc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0hJb1Y3VW1XV05Jc3ViRGM2aHZmUnJjcFF5YjdLdVRrYjROc2U5VGIxU2h5?=
 =?utf-8?B?YmxMWlRZdUF4RFU1SHRvWnBCa1NWM0tURlFMUmQ1OGR0REM5dDVOV3pvdkFm?=
 =?utf-8?B?UkJZcFV6M1YyeC9rQjNTTVFWRk5sK3czRHFPTU90YWF4K2ZvYUVSZWtKd01N?=
 =?utf-8?B?SXA5TjNYZk1heTZxTGpjMmZlQ0ExeTBxUmhXazhIL1NYSnNZSEZOUmM1MVZt?=
 =?utf-8?B?UzUyUitsN3UwVURMSlgvYUQzQUZibW9JdGFjQzBnWG5xWURxbThJWmFVRTJI?=
 =?utf-8?B?emh2K0I4Rm5kMnFSUTV3amNUR05mYmxNZ2p3TFN5SVNKVXZNOXZzRWUxRFl1?=
 =?utf-8?B?a1JVMlh0Ry9lbndKeXp1WGZJK2kxMzZOWFlHMUhlMUp2VE5GOWVqUXgxRzZB?=
 =?utf-8?B?SDF1eTgveGpua0hwU0FEbVFURFFoVkt2bHBsamxkSUVXMHhEVnVJOFJpckpa?=
 =?utf-8?B?ZmdYaHoxL05DMlppNGhLRC9XS3dVcTBOUXZJaWpPWWlmRkd2RkgyNnBwV2Nj?=
 =?utf-8?B?K2k2RERZWDh5SXFwZ1NwdWlaY3NaOVVrTUp1cFlvbnFjZEVpMDBibDhvazFk?=
 =?utf-8?B?VitPUXBQWU5YSlJRZFhiMjVGWVlkUDFqNTFnOC9UUjd5VFJrTXc1enVSZzNr?=
 =?utf-8?B?NnNBL0JuOFNjS1RaTE9aRGRGZXM3UElTZk96Rm4wd21vVHZ6ZE12OUlxK2Fh?=
 =?utf-8?B?TWJiUG9jbFRwNy82UktPZm13dzU5ejBiT1lhdy9sQk1ybHZ0aVZXdk15ODRt?=
 =?utf-8?B?SU9RTUJ0WVRQSnVuR0tSbEVRRW9mM3BHWEhDb0JjbFhPbzVCTVpOM2lIenVJ?=
 =?utf-8?B?Z2dmUEpIQVRUZ1NXU0NZOTV1YTJaaHhXMHU2Z0hDaSsxSHVNWkw2dlh5UFBO?=
 =?utf-8?B?VVo1NnJXdWlvUTlyZTJTYUJSM3NBWDNZTVVEbTJXbTlXNGpxRVg1YWNIeWdM?=
 =?utf-8?B?VzB5L3k5dkpjM05kazNUSGpwbGVTVzA0YmdaenNndEdWUElsNktuYS9OWGVu?=
 =?utf-8?B?RURiSHk2Nysza0E0U1ZENDY0VnlHZGNha0tlQ0ZMVEhMN0NpNCtYUlN6ZHBu?=
 =?utf-8?B?Uzd3NGdQS05Wb2RPbExVLzRBV2p6azZGQlAvUXhwcXkrM1QyYVA1WEN3WnB1?=
 =?utf-8?B?S1RmK0hsNDROeDNISlBFY3Fmd0puSHdMeGRWTEZ2VkpJdlZDdWg2SHhHYkNz?=
 =?utf-8?B?S0hWVHhlWnVtcmFlRW1GZUFKbFlHbkgyc2FuL1g5RnYrTE13UWpRdlROMkhW?=
 =?utf-8?B?SFpsdHF4NVF5ZzFiSzUwKzRjSzVPcWNsWU1sY1FrcktjeFdhSVgxOFNGencx?=
 =?utf-8?B?dkxFTTBCWkl1NVdQZndCOFc1Zi9wVlJxWCt4Y1E4RmFCVmpLU2M2eE4yZldY?=
 =?utf-8?B?UWJ4OXViUW9nMjl3MDdCNlVNVjZ6UFJPV1hMdHA4bWhxWWZDL0RzT0dISG1X?=
 =?utf-8?B?eHp0TXNzQlVPZkhsRUF3dVY4U0hiVEF0Yy9jSzlFL09YZlFUeVdXL09weUJT?=
 =?utf-8?B?YVRid2lic2cvSDkvMENmVGdEbXdpVlJYcGl4TDZ4djVqVFFSSGlOY015Q2dy?=
 =?utf-8?B?RDVrTnB4YUNsZ0FLRCt3V0hnZmF3NGhhZTJQazBRL094aGh2QVRsNG1DQ2tr?=
 =?utf-8?B?a09nSk1BTlJYOGdxYTY5WC9QQy9tZDJUNzVoUWVYMzE4Z2VuOHc1Yk4rMDRU?=
 =?utf-8?B?aXpWV0szT0xMTHl0M3RLSk1OY1ZUSVZqS3c5VzJKOWxRSE9pQU8zajZjeTN1?=
 =?utf-8?B?a0p1RGp0VzZRMzAwdmQ5d1lXM0lTZURVRzlOckxlYlVyN2c2d0FyclArM0hZ?=
 =?utf-8?B?NWgwT21NdWhDQkJaeThhU2JaU0lqOXNXeitIUWxBZ0F1RUlxSmJON1ZCT0I0?=
 =?utf-8?B?K21ldzA0eHZaMFZTa3Rtd0NGMTY1RmlyQTJLSGNrWFdGV3huYnQrZkxKdWp2?=
 =?utf-8?B?cVR3SVJXeDFYL0JVakoyU0ZwWnpPRXQ5Z1VqUFFIOEFxOHc4c0NJamRNSVl6?=
 =?utf-8?Q?gmsFDk8Aev0Lj9WdC5MdxYOQAu8z00=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNjNWN6QlVZTnBDMDdUc3Jjemt6ekl3eVFVOW5DV25wOW9JSjlqSGhwUlY2?=
 =?utf-8?B?U1NvTDdkQVM1ZTdkUkF4V2ZDU29YSHZmRmVRNnRQRkd3WEF1OEl5ZzlIWXJy?=
 =?utf-8?B?a2E5bWpib2s5bVR2RjhmRkdaZ3BEblNTUWk0b1dnL1NsRjBxVnppMUNVYWlP?=
 =?utf-8?B?ZlZSNU1zSlpDaFp2a2ljUUNZUG91TGUwUTlIMDVSUzNrMFNpaE8yWWlkQmlU?=
 =?utf-8?B?QlBXQWtoN0FmU0J3eDlTQTd4RnBSa3p4ZU83NWlIR1FRZy82MjhrQUhhL2hH?=
 =?utf-8?B?VUNoa0JlZEFDN3BMcjVaQlBMWmx1YVkzaTFiTmpuZllIZTgvMUpFMHJMR2JZ?=
 =?utf-8?B?eXFnM0ZjWTlDcnNUYys3YytSRno3VU55Q0RLN1ZkaG9PaUd1Y0JUQXRSNFZ5?=
 =?utf-8?B?bkZHRU5IekE0a1ZUeGU5cFZwVTQzTTF6NVhaamVMR05YWmNkR1VmK3k1V0xG?=
 =?utf-8?B?WDRaYThJVmxkZ3JFaHdpQmU1RkJSNzgvWSt0V0dwUVZ4d3Nxa0VKVldTSjNa?=
 =?utf-8?B?TXdXWUVNbFV3emxtT1NHa3F3ek9odU5VWXZEYURjSjNlWjdOT1lxTk1xVVhT?=
 =?utf-8?B?a1dyM1QzK3pQazhOZWV5NmZmRkYzMi9MSGtZL2hvT0ROenBJdDZJNHNXV2xP?=
 =?utf-8?B?RXBWZmU3R0diMThKM1BMWnIxM0I2aDl2ejVUZWxVR0wzRk1uTTN0SUtwM1pt?=
 =?utf-8?B?bFFNenBZY1VoMCtiNDh1TlpKQlNwaUVyOXlxRE54cUZqZG53czc0cWJGeXdW?=
 =?utf-8?B?S1hzNnh1TUtEVlY4dVR1cTNtbG4vSWtUYUM0b1ljTG1uR3ZFRUl5bjRjbkM4?=
 =?utf-8?B?WVNwcjBqclFub01PaXpPaHlVdXZNbnpvRVJwbHErazZEekJBZTVuMENoOHd2?=
 =?utf-8?B?MGZjRUlFdmRyQ0Y4NmtoZDJHNUhPbE80WGlZSGk3NFkwWDNuUlVONC9aNTFJ?=
 =?utf-8?B?WHZHNlkySXBnL0tVY3U3N2dVeEpZS0xlZWQzU2RJaHF1Z0JtWEJEMEl6T2F4?=
 =?utf-8?B?V3BDRG9rdUIyU3B4TS9lcHZQN2JZWFlDRnBweVhzTXdjR3pwbXAzVS91MzNO?=
 =?utf-8?B?WHJEcXBQVURVUFVLMGR6UCt1VE5naFVVU3M5QUxJdFhFQ09iaUhOd0lKSnRo?=
 =?utf-8?B?dUpEc3BnM3BtNFNSbjlCTWdCRVZBOWt6U3NnQUNRMTVvS0VuRmxkQ1NKcUtI?=
 =?utf-8?B?TGZVZ2VoTXZBL0ZmYTlCT3ZsbVJaL3FjbWdWTENxcEk2cTFOTDZTQWNLOFVv?=
 =?utf-8?B?S25YQm9sd3grNjd2SWZGRkVxOHZpU2ptdytXd1llSmUyWjQ4YThiNUFkaDNq?=
 =?utf-8?B?YkdGOGZ5RElpNXpldm04RUR6YmNPVFEwMStzTnFZQTNCUnBlSVF1TmZNaGcy?=
 =?utf-8?B?NzAzNklaRXRpTjBDU2FLWmgzVUMwS1pnVkhQSEZYcThtS0ZVc0JiZWtaQUdB?=
 =?utf-8?B?Q2F5OFVvcFVUSnBZT0ZHd3c1M1pMbHlqTWxvaUo0TFE1b0RFaHJjVnR2WVJQ?=
 =?utf-8?B?S2pDTzZRb2F3a2NmbFhqOUxuWkVMaWZ6M2wvVmRJaGpjcCtWU2dqUnBoaFRO?=
 =?utf-8?B?b0ZUSmJ6S3RPbkJHK1lhTThoWjI3VnlBL0tNTE50bEhZM0RJc3o4Sm5MT3RF?=
 =?utf-8?B?REhxWXRyY3YyQ3Y0ekoyaWl5dUJCZWIvVGxuODVwYlMvTVdvNFBIbDQvTU9Y?=
 =?utf-8?B?enNTZUphZW50TmE4aFd2UUVDRC9LWGlxRyt6QjVMMWtidXVEaXZBVzRiOE1U?=
 =?utf-8?B?ZVN0Z2FzWGFiZ09ET21nbzlYNW9Dd3hGbDI1VG9EYzhUeG0wM2FoUWs3amI4?=
 =?utf-8?B?aU02bXBLcFliVHJuNnlwYVpDWlhJUmNHM1lCdmE0SDM5QS90b2tMVld1dUF4?=
 =?utf-8?B?WDAzNmhuaDBsUkdNZ2R6d0dNMG1xZnpZYmNlVGxjRVpORzZKbXhyUUN6VjV2?=
 =?utf-8?B?RSs4b3lQeVl1OGNiVjFkS09nbllReTdsVEpJNmtydFhieSt2M2F5aW82NThT?=
 =?utf-8?B?Sndrak40dmZaM0RKczV0TVF5VFlsMUM5TEJRdnZhTVRML3Z5VVcvWVNiSlly?=
 =?utf-8?B?S3hhQ2tDaTRhQnpMSDRXdGtMQzdXN08yQzFjNHVDWkMzZ0E2anA1VENQU0JJ?=
 =?utf-8?B?aFNadHl6d2QrbFk0NmdPUnhSa0NHMTQ3UU9ldytqTVV5dlppSjZEMlVkRHda?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe18de08-7860-490c-d00e-08de0cdfbc06
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:13:40.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2afJxQYq5Hl1fxgK/+9uTOfndTje3iK6epOuE1SSAfcnpe8hT9HBtu967GFMBdTMuvq7v+HyI/qXjQTKtG1DfErjauZ4XpygHBMzJGl4g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6012
X-OriginatorOrg: intel.com

--------------h5dztU4b1m5vhN2yhCDo0uCV
Content-Type: multipart/mixed; boundary="------------w9k1IUWmW9c7rkL9GLrX3pVY";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Message-ID: <c8068fc5-4248-421e-b1dc-288dad494909@intel.com>
Subject: Re: [PATCH net-next v3 6/7] tsnep: convert to ndo_hwtstatmp API
References: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
 <20251016152515.3510991-7-vadim.fedorenko@linux.dev>
In-Reply-To: <20251016152515.3510991-7-vadim.fedorenko@linux.dev>

--------------w9k1IUWmW9c7rkL9GLrX3pVY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/16/2025 8:25 AM, Vadim Fedorenko wrote:
> Convert to .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> After conversions the rest of tsnep_netdev_ioctl() becomes pure
> phy_do_ioctl_running(), so remove tsnep_netdev_ioctl() and replace
> it with phy_do_ioctl_running() in .ndo_eth_ioctl.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------w9k1IUWmW9c7rkL9GLrX3pVY--

--------------h5dztU4b1m5vhN2yhCDo0uCV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPE10wUDAAAAAAAKCRBqll0+bw8o6Iwp
AQDtrvrVZdkwoqFsmVi7xm1nyRTx6IweYLyuO7XhZ0DkdgD/fAqFRe17x6H0vxmuGNTdGRX7UghR
fjkJihgpjbzZdQ0=
=ZEqA
-----END PGP SIGNATURE-----

--------------h5dztU4b1m5vhN2yhCDo0uCV--

