Return-Path: <netdev+bounces-196361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4D0AD4615
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9214D3A6B61
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C7283FD5;
	Tue, 10 Jun 2025 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIQznHhw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1A24676A
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749595073; cv=fail; b=ZQizyN3UCv30kRotjAxDNNMI+BVm45uLOlsF91pBwR82lUyhM/oxJjhE/PwE6Pm9gP6wyezsreoFg3+On96QRb8hEQ57dkNVxoR5yp335P1RehUJ6HLyRpUXfpFa7h/YiTsMAccfLCOu4RjftBjvqOcWh1isizZiRVwn6krLFVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749595073; c=relaxed/simple;
	bh=OV21QLk501X4V64MVGJ3PaONP/BsRaNDH2pFdETdhQM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FwpLNkQ5zMuSrKt2HYx0JOXx5e7hGmmmB/DaYpDG0teqjlPT40QMZHSolow1EaSx3KaLQlnzJrlfOFPP9e/b7+NTlR+7+dgD913dInY7mcEkSNuHKdSEn3V9dc2nIzI9o+PWd/QG3V5T2OwK/uyTuM5cP4Wh0QHUxzt0vKVrlh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIQznHhw; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749595071; x=1781131071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OV21QLk501X4V64MVGJ3PaONP/BsRaNDH2pFdETdhQM=;
  b=gIQznHhw+05ktfyJ1auLaH7OnoXGKjZ3S2c5mvs8VmY30KgZsQU+y8DA
   AnIyexM8Z/U3kHr+gY/9O+DoGTn9/+Au9uAVSe26h0CzNUZs3POH8RqOc
   XLMLVsSv8tR4h2+pS7qd9KeS68E+bphYwqyOdl5zlrIvVY0Kpx8Nn6gZj
   cZiEJMERVea2u6E9fg9apkrGFh+STDVhpJT+5C0Go8VTM63uri2PfMbKt
   1dDOB3HPAqI3thRo+7RJij0x7u3n6qCUnmbOkVSJ11S0fl8n1rXqelGqT
   b8/kAIlIUxlDKWyqpCV8NQbdjDutyaJNtYHREzl/pSzPJdTchVHHMcH6S
   Q==;
X-CSE-ConnectionGUID: V1SFJstIRxeeINyZCTpv+w==
X-CSE-MsgGUID: fZ+zE2kRRbSVKNZqkOqsfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62760690"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62760690"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 15:37:51 -0700
X-CSE-ConnectionGUID: Ik1tWqm6ScuPIV/H1aA4kg==
X-CSE-MsgGUID: 0Mt/Wg3QQhqVIJuf99wUeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="146957134"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 15:37:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 15:37:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 15:37:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.52)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 15:37:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXDuKqwLe+brGU+3bCRG3rvsDacH3F4aCoPL1P3YZLmJf26YFmolN6676uskbVmX9Ae0+WGVnxJHYZj2JsGrAF32w221EBQgkaim5dYvurZ/lYeKfipZyRcfvfx0BMxEH8GMbRNdjQrtc1xqN8qkfj90CDs+izbnCIsgTx+53ZmzaDGshuseYMohOQ98ayVEq0bDfrpCI5xLKSJtxnIdzCEc9n8ZsT//0dmu2B7bpCfhoc7KPN5bbSsevAOKJuG0A4jtX/3xnKhtQ9QKaKWvgmhoOImJvlKxmUayc8gjeDp8nPJdo6ERuBmpP0WqQBhC2PWF5VNPzIM/bwOD2UzGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAwYySG4Lt2UUVj/PcEpFK8r75OrEDEP1coF3EBMBtU=;
 b=YWjZ4mN1rt/9xUXAdD0X86Bp5+5IaoTcWPI7YC9Cde5nuaK4qurx3edt0aJymbiZJc54KBk9T6ooupEzeUTOJ0Z/X9QTnMQgE2mJI3HMWBKI3mpIZw/M2r0b/qj4hASnRy5DapdNKmvCnckHG7EEmuLG64Y/OCjiO4kSRXjp4aKbmFjSF8cU3arKCPBjirF0ebsxqn3T6NJv1oH4EGIGqK1DvtlbXKPbRb1fBdt0HGRWFihM6eWB8jMYJx3gabi1oA2aERrqLZxm9aHEE0TjCswRkeGOP15Zs/E46hjU4DZ+7bBt5HbsMiDJ/ONCH4gsb77xK5tk4qEDxGx2ft8g5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7891.namprd11.prod.outlook.com (2603:10b6:208:3fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 22:37:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8813.032; Tue, 10 Jun 2025
 22:37:43 +0000
Message-ID: <4333d7da-6e03-453e-8dad-44f52131b82e@intel.com>
Date: Tue, 10 Jun 2025 15:37:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] eth: fbnic: Expand coverage of mac stats
To: Mohsin Bashir <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>
CC: <alexanderduyck@fb.com>, <kuba@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <vadim.fedorenko@linux.dev>, <sanman.p211993@gmail.com>,
	<lee@trager.us>, <suhui@nfschina.com>
References: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
 <20250610171109.1481229-3-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250610171109.1481229-3-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: b516985e-f337-4b61-0192-08dda86f6a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVkySzkxclZlNFNUMHo4M0lSeUZIcldKNE5SZXZwb1o0Mlk1VUJkMEY4QzZ6?=
 =?utf-8?B?azZjZHZWVEFkZ3ZVRDdmemk5THZBQ3pxYXV1RUtTNWQyVDl2TFZKUDFybEJx?=
 =?utf-8?B?KzJsN3RUNWpMVVhhRmVoZUJjcnNDZ041RkxUVjcyU2Q4bW1leFdZMVBSUzda?=
 =?utf-8?B?NjlmVkZ1T2ZzTnd2TkJhcmNZU0Y1MkhScFRXdjl4Q3NXODVveEF5bDB5Z3hS?=
 =?utf-8?B?SnorSlN1NnlXWEpFRndiQ2RqL3Z6R3RPWWtqTHk1OUtZVUMvcUxqNURLQjdU?=
 =?utf-8?B?R3JUSFpDcU1pbUR6RUFBbVBvZnFES01RV2xTVGpSWE9hVG1hRENJWmk0Umt6?=
 =?utf-8?B?NDRUc3R6Q3FOTzh1QnpHbWNKb3BYUG5NTUp2c0dYd3RPKzZyUm9QUGY3QWt0?=
 =?utf-8?B?MzZaai9FQ3oyWDlzekw1TFlDMjlxalI3L2t4V3prRWxOV01wT2tuTE85N3lF?=
 =?utf-8?B?dGNXcWNKWDhNWDhMT3JJREwzNER4ejdYVHdiVnpUQXJSYlgzdG1pVGVBSlI1?=
 =?utf-8?B?b2NlckJJT0s5MG1ycDFZNlAwKzgxNndSLzZjNjVCVE0xTUV4RUdFVGppRU5P?=
 =?utf-8?B?cTYzeTNDWkJmTFhPSzBnbG84WlFqRW1nZE5ZMnhwMTVUOC91aCtaaHliWm8x?=
 =?utf-8?B?SElReXNkTW1nYWNHOHVoamZNMHYyU1l2V2hkc3Y2VEx4WmpZK1dQTWlxUmRU?=
 =?utf-8?B?dDFpczhSZ3BzREprV25yQmw5N1NHVzNUNDM5SjVtRitSYWVQNnhaMnZHTkNp?=
 =?utf-8?B?TUpMOGE3cFQ0V0pRcEtoTitTcXZOMkpXUG9lZ1owV2hGSGVpMm5HZGRDZzl6?=
 =?utf-8?B?UlpuQ2JJaGc3NmJjNmg5eTB4SG9jVjk5Wkk1SmZiQitGN0JYcmtmZDlBVkFF?=
 =?utf-8?B?MTlReUdNdDN3L0Ezd1l3aDB2aitjbW5sREtvVmg4RWtDL0dNYWdqU0liQkVl?=
 =?utf-8?B?UVBFWUd1eUdnam1nYmh2SVhLRzg4L25IeXgvRmpyQ1JJaGxWU3lvZTJIamRU?=
 =?utf-8?B?RkI5NzloOW5nSENtRXVCNkdMNERiZ05lMGJlaDVzVzQxVDdOenZ6L25QbDRi?=
 =?utf-8?B?YnpIQXgrT29PaXUwRDJCaEVja1NYUDNGTDE5U1ZvZG83YlJvS3VqUmFBS0gr?=
 =?utf-8?B?NVExb3lJWXpVRGZBbGpVNlJpUlJFUHpQa010dXpETDJHWnAwQUZJaEVYb2Y2?=
 =?utf-8?B?anNrejNZaDhaVkVvR3ZIZDhOaUhxcUthMFdqUVd2K0E4eGhmSjJpNXVRRk8r?=
 =?utf-8?B?M1lZZWlkdGdYU0ZoaDErQXZvUmgvd1AvYklFcEJxbks4UFptY05HUmUyOTBX?=
 =?utf-8?B?WmlNMmYzbXVlR0NCekxrZVhvQXQ5WHhNdEJ5Rzl5NlJ5TW8xMXlFMTdRRFA4?=
 =?utf-8?B?WEpzUmVoazRxY3hDWWpFZzFXWFk3L3o4UDVldzM0MG50VjNKd094UXJlQld5?=
 =?utf-8?B?UnR1czJaUVBJQWhyM3oydG91RjVpa0N5Qk1ka3g5bGhEMERMWDBUNlF5Y1Ri?=
 =?utf-8?B?TVdlOWJ5T0F4NkZUeko0L1hOS2ZEdDJHc0o1OFVDTUw4eENack44czFNY3JI?=
 =?utf-8?B?anN3d0E0NW9Od2poNVNqVklrT1NEcGxhK3hQYThpeXR3eUg4aXZEWDluZkU5?=
 =?utf-8?B?YmZKSmd3Uko4TmprZ1RsdmVWNDV3cGRJa1pIbXpsUCtjbm5YSzlITlBHaHMv?=
 =?utf-8?B?YjBOWENGUnZkMWlBVGl4L3JGNnJqZUlYUmkzdEl2VlZaRzRXWlJpRmVSSytw?=
 =?utf-8?B?VXhuVm5tSUZHZkZyVXpCMmEwOEtQWjR2bjNRSGxkVW5DWGhjaGcyYjh5eW9n?=
 =?utf-8?B?QkR2YlRLeGo5aUk1VlR1Y051UExHUG9tOUp4Mk9CNXZoNnFRUGRrWFkwaS96?=
 =?utf-8?B?VVJWZU9RWmJiR0duQy93TENRZ1lmaklMRkxWN3ZPZS95OHF0Q25ua2RLcGRj?=
 =?utf-8?Q?cVNgJ5XcjDs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGVOQkNUaXdyeFh3RFIxRXhQMVRIZnJUSFRNU0RhZFZpL1kzSzk2MENJWG90?=
 =?utf-8?B?eHhFTDJjTWVWdDg0QTZ5SXJ5Z1BuK3RmUGowUlB1dlpqbnJNc2wrY0hUMXlJ?=
 =?utf-8?B?QmlzQ3FwL0RTd1JjSldEeWl4MGMyTTRHRFNPRGVWZEZyYlBlL1lpSmxOakZW?=
 =?utf-8?B?YVVxUkJIb1RGTjRJbEtkTkQrTVhYL3I4eGI4a2szb1lDcldRcXV5cDVoaW9i?=
 =?utf-8?B?TTFXV2I0UWc4T1lYTkFyaEtQa3hRQ3NjTEZWaGxORzczdXFPUDBRTEtwT2dF?=
 =?utf-8?B?SFpSYmk5ZEFQM0VPa0VTaDhBOWVCVkg4RVN6ZFRFdkYxdk1lVm1wZ1g3RGVV?=
 =?utf-8?B?TVRLeGR1cS9TR1IyYkc4Ly9jMG92d3hEcVdiMUdWVWx1aTJ6MkM4M0tJZDVk?=
 =?utf-8?B?Nmw5RTFoTUx4RmI4S3lzSmsxbjV5dlN6TmIxYmN4QmcvNGt4dTRYR09wQklQ?=
 =?utf-8?B?VE1GV2VtWVhsOXJ1RWVZK0xmMEYvVndCZnhlcGdCYnQ5R3dOU3VrelRzVTdT?=
 =?utf-8?B?WVZNeUJlTi9PUllvNUIzYVZTWm8reEdGKzN4NGx0cFJIZXRiQXBRVDZwbDdh?=
 =?utf-8?B?clRyY2tXSnY1QWRQbWRUVWw4b1FZZHRrUVpkZHVGYXVKcklwY2FJQjF3VUVw?=
 =?utf-8?B?aHV6bnViYmZiZFIwM0pHN213N3RIWE54aHpQS2cvNXY3aHhGdHk5YkpKeEov?=
 =?utf-8?B?c0NHM2x0NVd2OWwxTUxhSGIySlNCZXZsdm1VSHBXbmowWjU1YUNTV3V1WTIv?=
 =?utf-8?B?czk5bm5QcjVmQjE4dllYaTA2NkF5N0xkVmpXc0t4N2dQVzE1NkdYc2hGVnpz?=
 =?utf-8?B?bm1rZXQ2L1V3SEM3dThVYmxwSFR3T3gxMmdaQmpWVlo4VEhUL2dZZHI3V3dl?=
 =?utf-8?B?T0tPQ0dqdVlobmlQN1NOQnpla2MxWVI3ekRNTVlyL0VkK1EybHpURU1xNVh6?=
 =?utf-8?B?cmh5NWJuSTdIM1hxTjlLQkZqOGcweWFqMHJZdExWa245SW4xVjA3N1d0U2Yw?=
 =?utf-8?B?MUFyazNoVS85VUR1b0c0ZjJOWDNyckQwOXQreHBsQVNFSmpXREVGZ3BQL0lO?=
 =?utf-8?B?TnpuQ2RmRGNLUStZbGkybXZITWQzUytWS1JmNWh3K21WcHhvUDhIa3UwNGxD?=
 =?utf-8?B?dmdqTVBRdyt6eHM4L0xrc1hrOEhVNVJMT0ZGZUhCTG1sTHNjWjZzcjVwaWNv?=
 =?utf-8?B?eFRabVhsM2lwczcwbkovQ3NGc3ROczkyMFdjZ24xU1g5WkowMHBiTis5cmFX?=
 =?utf-8?B?Q2hmcG40am8zd2QrU1pZaklyS1R2ZFBzNEJPZFdWWnRTY0gzb2NMSWp3S2s4?=
 =?utf-8?B?c1hDa0xDQ3RxMjBsMWRZRlI1TFVQbEJMU0FYcHBXd1lCRUNpdTlzQWFhc0dw?=
 =?utf-8?B?eDdEczFneVFCNTVHTTh0M3JuQmM4OW1OUVRFT1FZSVlodjk4TGEzTXJwOThX?=
 =?utf-8?B?cm9NOFdkVU9RYk1sWDU0b2hrTlc3UEVuSVRsQlJ6WjNTSEZQVmVuRWZxRXpR?=
 =?utf-8?B?OXNtTjhjdDI2bVQrdW5wRFZLaGJ5dTg0bUwrSHZzRzZ4TURqdXhTRzV5WEl5?=
 =?utf-8?B?anFBOG1zZ3NaRnZ6dzlKYTFIVmUrN2lYQ2tpdHR2eTJwYm0yZ2tVWVFWZlZr?=
 =?utf-8?B?cXFodlEwWnhiTG5Vc3ZCdmZ5cjlkdWVxbWNBL0hhck01dEJwK2pXdWhBWncy?=
 =?utf-8?B?V2swWjNOT08rd040cVN4UTV1RXVkczRiNkV2dEd2cDJzaU5kUXhHdTRYcWZz?=
 =?utf-8?B?VVhhaDNOc3hIYXd0ekpCSy9XQyttbmg3WTRteFBJZHlmU2ZueGV5Y0tFQ2hu?=
 =?utf-8?B?bHBLdkZ4emRETlBRU0hLL0tWVXVCZUNGT3o3OEtRUjAyb1NVbkswRUsyZ05s?=
 =?utf-8?B?WTZxNks2ZU40cHZEdWV5NFVmMlVEVVFiQUh2M2R2RDdLVkNGL21ZUGNjMHZW?=
 =?utf-8?B?b0lRd2pjZW5GMS9NK3FUeVVGSUM1cjJNdWZnaFNCeTN6ZmhjTjl5MFZza3lG?=
 =?utf-8?B?dVFOeXBOYUp6UlBuQVdJWGZXeHJCTkZCNVBsTEx2alJybERwWFFhY3Q3MjE1?=
 =?utf-8?B?U2lNYmMzZFZ3L21uTkwwRTJiMVNEa0xmVjIzMkN0c0lWcXl6bmZEQmw3NnN5?=
 =?utf-8?B?emhBNVhwUlRkTGtoVE1NY2NpR1FjUHYxWTdLTGJJVkY5L21lRlpWNDdjeWEv?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b516985e-f337-4b61-0192-08dda86f6a1e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 22:37:43.4050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4LM6nvaH2Yyi49dpAVRuu/xPKfnHmjsKPI5LHELahGREWE5qbQmijDEVWQowuG5bdbHN/ux/wi2bNKdU+LU14u5/mS1dxqPaEEWoAaIeUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7891
X-OriginatorOrg: intel.com



On 6/10/2025 10:11 AM, Mohsin Bashir wrote:
> Expand coverage of MAC stats via ethtool by adding rmon and eth-ctrl
> stats.
> 
> ethtool -S eth0 --groups eth-ctrl
> Standard stats for eth0:
> eth-ctrl-MACControlFramesTransmitted: 0
> eth-ctrl-MACControlFramesReceived: 0
> 
> ethtool -S eth0 --groups rmon
> Standard stats for eth0:
> rmon-etherStatsUndersizePkts: 0
> rmon-etherStatsOversizePkts: 0
> rmon-etherStatsFragments: 0
> rmon-etherStatsJabbers: 0
> rx-rmon-etherStatsPkts64Octets: 32807689
> rx-rmon-etherStatsPkts65to127Octets: 567512968
> rx-rmon-etherStatsPkts128to255Octets: 64730266
> rx-rmon-etherStatsPkts256to511Octets: 20136039
> rx-rmon-etherStatsPkts512to1023Octets: 28476870
> rx-rmon-etherStatsPkts1024to1518Octets: 6958335
> rx-rmon-etherStatsPkts1519to2047Octets: 164
> rx-rmon-etherStatsPkts2048to4095Octets: 3844
> rx-rmon-etherStatsPkts4096to8191Octets: 21814
> rx-rmon-etherStatsPkts8192to9216Octets: 6540818
> rx-rmon-etherStatsPkts9217to9742Octets: 4180897
> tx-rmon-etherStatsPkts64Octets: 8786
> tx-rmon-etherStatsPkts65to127Octets: 31475804
> tx-rmon-etherStatsPkts128to255Octets: 3581331
> tx-rmon-etherStatsPkts256to511Octets: 2483038
> tx-rmon-etherStatsPkts512to1023Octets: 4500916
> tx-rmon-etherStatsPkts1024to1518Octets: 38741270
> tx-rmon-etherStatsPkts1519to2047Octets: 15521
> tx-rmon-etherStatsPkts2048to4095Octets: 4109
> tx-rmon-etherStatsPkts4096to8191Octets: 20817
> tx-rmon-etherStatsPkts8192to9216Octets: 6904055
> tx-rmon-etherStatsPkts9217to9742Octets: 6757746
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

