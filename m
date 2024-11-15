Return-Path: <netdev+bounces-145362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D719B9CF419
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5755B1F2138D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E17152E1C;
	Fri, 15 Nov 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSVuDJCh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706CE18732E
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695975; cv=fail; b=QSM0WNW4ZFebw3uPmcYE6t7VI/+at8DcJ+ocxEvO6vlGM71mplJyQtXxZ+d1wfDlomMchNeo7E31ohPEQsU6f5+swbk+x81qR4nOIRmab3iDKplVwT6XOM6sJrnh5fJVqEac6YSzycqJm+b5Zi9w72jrFY2CmjBuSY41ADtlajU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695975; c=relaxed/simple;
	bh=15pmX0VRe0e+vD42/y3KBKyHXTDRbNaIP9K1l2wf73g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IdoYJYOOBBQpsQM4/uzijXu+9PeB3nVpZXyehD+vZE0jvXPvXm2pMxtOWkv8NYryo9ybILaKB4ucuOBEIZYqoQKmJ1PuDAZftvO3PP+A7KX0uww0cPRS0ZKwlxkzq6VlujIsdRYaCQGmpZonX0VQhf57cxl8b/r+DfTDu4wW94c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSVuDJCh; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731695973; x=1763231973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=15pmX0VRe0e+vD42/y3KBKyHXTDRbNaIP9K1l2wf73g=;
  b=TSVuDJChZjphoyy1i61LiBAkqFxJq7ZG/7gK/QpxlKzTr0HR73hqB3lx
   QJ9jhtr8y3qJM/92PZB5xMFT2w7xHmaf8i6GG6MyNYqUEk+RIRwTvIwtY
   VKRc9+cyHZRKmHN4/VmJr3CCb/nVe22f/64b/ediHHWg6hhhBEmkSoNds
   0c9btf/BYl+P5RYgA4PVpwDBugHKktd7nnBwinZEUTa94U9z5nQh94pyq
   Z2DHa17Bp4KfZWsbH5u/2yvrIkSZeAkOXzt84CiWCmQ9V5JWnpQ5AjoSL
   G1inC493uqAYqyhlXYZPF5lodH9fHj6rYS2HFX8EbLhTQYkhaXichRDel
   Q==;
X-CSE-ConnectionGUID: 90+unI82Sc21bv37q/zq7w==
X-CSE-MsgGUID: frp9qdPZQNyQgeyTVUd2zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31847454"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31847454"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 10:39:22 -0800
X-CSE-ConnectionGUID: RMkKSyuQRM2KCMNpKNpyew==
X-CSE-MsgGUID: 4sIw39lKTJuWSv9MrR4/0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="88398739"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 10:39:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 10:39:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 10:39:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 10:39:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHNL5m1l8Jle99uN4wCWzESZ2t/0ntV1ZhBsAZYAzc5pjD5Ipcpcg7Je4m5Lqh9zeOaL4BFlMX36qccO/z1BT4wuMWtKJv+eJdfwgh7YFS2kYycquGi1A2CT0jtpEpR0e3KEEHjFu2v7sEz48FussgIP0XeNO5bURPmqcabjbG4nOtO11nYT3O0ApgzbJlmRlKsPglQmLQG2+x1lYPmFFVZKDiA3Y3WoWxnWDFIPoE8CDgtk41PLqdQIlAqmNHcTRrhrW1alaca/Sf8KuIFUXu1lnjL1o/GS1xs6N8I1KeAXUZu1egXSzxUpuk7fl0wcqqaIi++QcXJLouVUv14e4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PROnasHwR8HoxCMTlZ7ouZcY0lzppwAoDAAHiZbTj8=;
 b=B6IqLYIBa49Il7i1hxzFWlmLoil1HjvrXLV/L6hbF9WbbqHYpChYLffOCAjl4pu7ZmeZ2UnKWxv/SPC+BLUSX266ANC60QMAy+rpVXjfqZwf6ikBAlRhlJYx17MDYxwW7/NZ/iFp3I3qrdjHOQ7omclmLGCM6w/Gnujhjl5h07xpNh3X8iGrzTlvJYmeSKAAOZqG2y5PHcSRQL3Sz82rBkTIE2qDRuq38J2GqHmwnkOZFdWLvO8FF3FiKl27oW4HF4RHEiRiBu2HK2tFvluu5BDoMKiZy7ZQc7Gpo164J699jU1cgrTLTOBv0n+Jgv+POA7w2C7hlOfOThmEwLF9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7298.namprd11.prod.outlook.com (2603:10b6:610:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 18:39:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.019; Fri, 15 Nov 2024
 18:39:15 +0000
Message-ID: <ffadc3fd-5f2c-461a-8132-7a9ee89add79@intel.com>
Date: Fri, 15 Nov 2024 10:39:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] bnxt_en: optimize gettimex64
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>
References: <20241114114820.1411660-1-vadfed@meta.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241114114820.1411660-1-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 179ae03e-1c64-4a5e-1fbf-08dd05a4ce93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHdLckcyZlZMQ3orM0k1ZG1LUVVOY2d5N3NOWlgrZlJ2U2R2UTVUaFVzY2tY?=
 =?utf-8?B?TnBUcnhtV25pOFcxcVpZcS9SeGswaUpNZThaMFgvc08vZkZ6QU5XSHpjaDBr?=
 =?utf-8?B?dGNiZEJ1b1o4QlJIa1htdk9QdHdsT3F0NlF2cTV4cU1kUUhTdjFpbXEyWUdq?=
 =?utf-8?B?RmRvODk5Wkwxa1ZXZ3haeFFncVM5bG5wTWpIQitXOGU3RlhrUE4zZ204N3FZ?=
 =?utf-8?B?SGk0UFNueTF5dkZOcXcwTVN6SW9GMnh1UjFDVVB4MG5BcEdtcWN5V01qZVdM?=
 =?utf-8?B?ekh1YTlXZUR4emdhVUVIbktYVDBZSHJDK1ZjWFNUVms1TmdEclJhaThxTGY2?=
 =?utf-8?B?TDk3RWo5cUtWR0ZMOWlWL0RxckVmTU1xdC9EQ2tLOUcvTmpKL1JJaGRkd084?=
 =?utf-8?B?clcvSi84NUNUTzNtR0ZQejFzY0Rud0ZycGZvMjdOQzdoY3U0WjNzNnVTbHJa?=
 =?utf-8?B?TnZmTlVvTy9hQTdWMVhReFFkOFFqV0x1VSsxU3paYlB0dDJ6enVWaVRFOTM5?=
 =?utf-8?B?R0hXNkVjOTUvbklTbmxqRG1KWWdQbytCeE1KRnErMVlmc1l6UzVjS29DSDY3?=
 =?utf-8?B?R2hKbG5hVXA0N1hYWjVjd0Rpb3ZTYjZ4S1k5N1BMclcvYmJ5VklPWFJycVNF?=
 =?utf-8?B?dmJ1eUxMenUzZDJJb04yZEM3aGo5bW5vSmNtbkxURTh4QlBENDJmbFkwU2pS?=
 =?utf-8?B?dEJIZGMrWVRiUzA1Q0U3UWFQVCtRRzNnNWJOVkxWUCtRZE9weThhMUdCbTJB?=
 =?utf-8?B?SmhjR05IU2VBUXZmSzRTS2NPU0NjcU1vbm9xM1JtdTZUSXVYbEoyWTA3ZVVz?=
 =?utf-8?B?alFxV0dOVkowb1FwdkFpVUl3ZmQxT1doSFVmVURTRWRNN2lHcDhjUE9aS0Jy?=
 =?utf-8?B?bzJSZndZeVFSNmJCaFBBMEwwTmFWOXZLejhWU1pYQkEvSWc4cGxBRWEzVDZN?=
 =?utf-8?B?Vzc4cHVNZmVnTFp4LzFyNXlpSjhGa0YvOUZEb0Q4bUJ3dXovQit1U2hGalRm?=
 =?utf-8?B?eVRqM296STdhYXc2OFlvc2JBMktwWEF4eTVYZTcwSnNJQmNYSk9sYUhOb29D?=
 =?utf-8?B?clBaa0dWRmJHUTByclBWQTB3SHJmY3dtVmIwODVSeklQVU5Ya2ZSMC9DeERy?=
 =?utf-8?B?NjdnRWtWMHBFdWgrdUVsYXFkeWxyWGtVcjR5V3QxSmtOLytNKzdWakNUakQ4?=
 =?utf-8?B?NzNKOERnL1hpalhlOTZHNzg3K25tcEtrWFRPMWJ5N3VmRnJpSDIxL2lSREdS?=
 =?utf-8?B?c1JxNCtwaTdoa0k3WGFVdGZzUlA5cktVZzBubS9lVGlvV0dwRG5ZUXNsNnpm?=
 =?utf-8?B?TzRQY1JBMG5qWnBXVUJtVks1SGZteTcvSm1yWFE5VzFFeFhtUVdVb1A4dm04?=
 =?utf-8?B?NFJrUDJCRXJKdnlDRkpPNjlxQlRGbzErdG42ZTAwaWVTazRQUDBpZzBJNWEx?=
 =?utf-8?B?MWRFYm1HYjZFcENRSG5VU2VWMjRJTHphMmZRYW1jNlpHSVF1UGNvRWl6VXM1?=
 =?utf-8?B?aHIvRWc2WE5kSk5panJpUUNKOTJ0b3V0VHFPNE40N1BpU1V5NHZyU0ZnVDlG?=
 =?utf-8?B?Y25mdTFsS0NEaCtXek5UcEU0TUlDZ0hMcUtTWnRsaGpHaEplWmltV2EvTS8z?=
 =?utf-8?B?QnFtVmdNMW1LaDJjVGxFUGlHdmFUM1JsUlRUZGowWkVRZmtxUWYrMEhtRzd3?=
 =?utf-8?B?b0hRSjFxRWo0MUhBUnhXbmxsK0VLcm9vaHY3VGNmNWw2N3BNRHhkRjdLM0sz?=
 =?utf-8?Q?kl91dTaiDGMoO1ka7jwQCe7f/bxJOL9lioX5N0x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0V1Ry9NL2ZsQkZRU2Via0pBaXFsVHRaT2RDQlVlaWhtaXduOUNmSVlNNC9m?=
 =?utf-8?B?RklmTlJlaHRzeklrRnJUdEw0TERlbTI0ZmFQNHhlMUpKS2dwZ1lhWGcrdzdp?=
 =?utf-8?B?SkZyZTVPK1JBZWJpNnprODVKdUNpZG11Sm8zdGNEVEdSSHRkMW9lWHZUYnlI?=
 =?utf-8?B?UC9QOFY2bDVkMUFzU3B0M1daaUdrZVhodFV4TEwzZjdvNjJndTF5V2JSbmFi?=
 =?utf-8?B?aVN3Wk9SL2VTN1NjYXlzc0xmcXFjZWtLU3pqK3ZoY2RSdkpxekVDQ1JWRGkx?=
 =?utf-8?B?UXo1LzU4MmMzQXUrVmp2QXoxRHpDTkV4Q3JCU0x1WFhjdHY5K1paSyt2bU1Q?=
 =?utf-8?B?N3U1b2tEeXpHVUdFQ2EvRWY0djFJbkNtb0trQUNTdCtvbVpReGJDTHB3NlM5?=
 =?utf-8?B?UkxpdEZwR0lXbWdtRFFHRk84T05rNzRzdEZNRzc0cERPWG8rUzJEd3BZTUxZ?=
 =?utf-8?B?VUorYXNvQWxXdjlQMUtmU1Y1UXJVMm5KZXdUbGlXd1g2WUcyUDJvZXY0Y3N4?=
 =?utf-8?B?bWo3YVBkS3FXZU4yUGdDKytHOE56MHh0NVRZZERuZlN1RVh6VW9jOXZ4bTUz?=
 =?utf-8?B?dzB4eWtjcUFuYTFlQnh1S1JObHlNaXpmbG9xMTlXMnQ0MU9iUWJ0T0JGY1dy?=
 =?utf-8?B?S2l0YW9lazREOGJrd1Qxd2xDYVAvcGpqNGdMYmJvRUhRZjh1ZlpZRlpEVlFO?=
 =?utf-8?B?czFqaDd3b3dDNkQvVVFPTXB2aW1vclhCTys4MXBLZmV6eWpCbTV6d2RjcUQ5?=
 =?utf-8?B?NGdKS2xxdkVubHdLdi9DajMwL3QvdkljZ21vY3o0ak5zdW45V1gzalpZWUFm?=
 =?utf-8?B?YzdsVjdXTDA5ZE1ZNkZYZCtJVEhtYVRuWWNEY1BpWlFNOXZ3b0xTUVVBbkg3?=
 =?utf-8?B?eW96dmtJcXhoWHk1ZjNieUZlT2NBVzJJWmg5czRlN281Vm8wdThCUHNZQ0FE?=
 =?utf-8?B?RC9Keno3b3VGZnRPSDhKUUtuUjg2WHdwQTVLaUJBRE13NXdmOVRLRmx1cUY0?=
 =?utf-8?B?VS9jQjJ0TzhpbFFsZ08zWlE5WFRQUVR3MFRYY0M1LzVXUE9oWFhReFNVUUFV?=
 =?utf-8?B?MFY1WW9pb2xFNVFua0R1dy9LdUR5b253QmNKVnZoL1VHbGJZM0pnK2pvRFAv?=
 =?utf-8?B?RjBsQVBtdW1ZcWZQVkdrMzI4T293blVjNkxXd0tWMVZxUEFtbCtNUW1jM1F6?=
 =?utf-8?B?cDd3S0VZS2VlbWxZYU5LTmlEMkNqUDR1WWQyckVsKzRhQ1BGMUZ3TzFyZjVT?=
 =?utf-8?B?blk1L0IxZWE2L0xDNkZCaU55UXh2UHBqQVRsUXVRTVBkNXpRUW1rVkFYbjR3?=
 =?utf-8?B?Q1I0SVBHc0FtSWM2c3BBN0RGa25laWJ6NjFBRHR3MFBsczZQRCtUMU95QVZP?=
 =?utf-8?B?MnlxTzNidUczT1RIOHBUaFFtZ0Y5OVNtdzJKSmF2Q0J0Zk5DOWd3dHBka3VB?=
 =?utf-8?B?aitjdkhXSEEweG9qNlVhQnh3NDFYWENWNjBONDlQYlJOQTc2RG1tYTY0eUpt?=
 =?utf-8?B?QjBKWlh3QUt2Skc4VWpvUWM2VEVXZXVtbkwzWE9CREpLVnNXSWovaVlqcnRx?=
 =?utf-8?B?Vy9BQ0FSQmtPNHNMTWNmUFYrWE1HS0YwOHZjdUpjREhzWTR1bzFZYUw2L1ZF?=
 =?utf-8?B?NlFId0EwY2laYWJlS3NOYjQ2RXRSck5kM1p0d1VZTGRNV1JOWW56YU1OTWNM?=
 =?utf-8?B?bW4xMi83RVR5U3hKRXRhM044Wk5GZ01hTmdWb3VNc3J6OE8vN0tWUzBOd0Vi?=
 =?utf-8?B?LzdXT0dVS2lSajkrZUwrc1YybXRTcm1XbVA0RDcxc0lUbGNPUTQ0RlhsTnhR?=
 =?utf-8?B?cjFEajQvR1llWTBKRUE3UVcyNnNtc2kvdVYzQXVOS0VQSFM1c3JXRmd6dmYx?=
 =?utf-8?B?ZEtNWVdSeDNTeG9xeXgzSFBUQjNucGMyQTl6dy9SWlRCWnR1TUs3Y2FrajFa?=
 =?utf-8?B?YytnQW14NHNNZCtudjdWeHJmZVphbFMwVmVBSmdhRXJOODNYVE1PWVFrMHN1?=
 =?utf-8?B?RjIwd0RNOTB4MXhYdE5naU9nWUI1UHNDNFh2MmY3S3JJVFFkcCs1R21tb2JK?=
 =?utf-8?B?NXRYbENzU1VSbENDbk1EYXFGVDJ1RUxwWUFkT0JjbXZVNzhGMnJLc3FJRWhY?=
 =?utf-8?Q?yXzs71kMBySq7jb0jQAyfglDV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 179ae03e-1c64-4a5e-1fbf-08dd05a4ce93
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 18:39:15.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv1ui2N+7qAZduqLtqsBTkXO/sk6tioSUfaq8haL/IM4inkHkv4vd7QSSr9r3IaPrzHf9eR+VYTIPA+OTojB9L/nem7h7+ETW40dx3P1hyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7298
X-OriginatorOrg: intel.com



On 11/14/2024 3:48 AM, Vadim Fedorenko wrote:
> Current implementation of gettimex64() makes at least 3 PCIe reads to
> get current PHC time. It takes at least 2.2us to get this value back to
> userspace. At the same time there is cached value of upper bits of PHC
> available for packet timestamps already. This patch reuses cached value
> to speed up reading of PHC time.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v1 -> v2:
> * move cycles extension to a helper function and reuse it for both
>   timestamp extension and gettimex64() function
> 
> I did some benchmarks on host with Broadcom Thor NIC trying to build
> histogram of time spent to call clock_gettime() to query PTP device
> over million iterations.
> With current implementation the result is (long tail is cut):
> 
> 2200ns: 902624
> 2300ns: 87404
> 2400ns: 4025
> 2500ns: 1307
> 2600ns: 581
> 2700ns: 261
> 2800ns: 104
> 2900ns: 36
> 3000ns: 32
> 3100ns: 24
> 3200ns: 16
> 3300ns: 29
> 3400ns: 29
> 3500ns: 23
> 
> Optimized version on the very same machine and NIC gives next values:
> 
> 900ns: 865436
> 1000ns: 128630
> 1100ns: 2671
> 1200ns: 727
> 1300ns: 397
> 1400ns: 178
> 1500ns: 92
> 1600ns: 16
> 1700ns: 15
> 1800ns: 11
> 1900ns: 6
> 2000ns: 20
> 2100ns: 11
> 
> That means pct(99) improved from 2300ns to 1000ns.
> ---

The driver already has to read and cache the values, so there's not much
value in repeating that every CLOCK_GETTIME system call. This also
simplifies the system timestamp process, and avoids the duplicate reads.

Clever!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

