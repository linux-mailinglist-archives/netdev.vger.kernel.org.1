Return-Path: <netdev+bounces-119303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34B9551DE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D952285775
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBFA13790B;
	Fri, 16 Aug 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nopvGaPi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C346B664
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840338; cv=fail; b=k/IVHXg7rKzdb2Pq+VRXCRfahKwOqjanOq0zNGL1GwH4TH2pMtLRi+NHw7b+MiYEVB3tQi8UeuIIcHIIEASL9ojD+nuITm8i3IAR1/QEDljJ4qqUZdYEJ9jGaMlPb8SdfnentYtOpT7mXzkalWiv9fqCiCPa+2fuxt8CXTJh1BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840338; c=relaxed/simple;
	bh=Z+ugT2ZWl5j3iExgo7WrhX2Jz3gXOScVyyGp6o8pJRg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PnVH30MZRlGRpsK+cBqFGlzH1ePoTfNGXt71uOGzBOXIDSVZoSLVoQ6pHnZytB6DWQjKaCk5ZDHJ5ZdnxDy1RapXMXzvdd5fVgiyaj4mpdoFPZT+3PK44v/OyT4aH/0Qt+VXNoOVcfUnWT4DxfdPKcV6poqpzxjJy/eStNELOTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nopvGaPi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723840337; x=1755376337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z+ugT2ZWl5j3iExgo7WrhX2Jz3gXOScVyyGp6o8pJRg=;
  b=nopvGaPip0tdAZ/9wJf4VI+P5gSOpDsrTXqJG5vAGsqLYMAth1n9jtEW
   UUwsSC8KjkPUOJlAoRZcwqF+t/xLiYoUh+qlj94Z/pRx7/nnkXUZSMrrV
   4/r5RWUZSL1/jXzx2jsy6FdjgAtst0Ns0G+x5B7xpMkZ74a/svLzHl9Jf
   s7RDkLbzhWgzCheG6TM6c2HpwGpU+6uxzYwxcmURhkOk8u7nE/h/BMdPx
   2i3/sSTcltTKcmQjTCJeETnVdSNVc/Un/q6hMJp6n6gLdNesxYv/E2vaN
   tDXAuNhLV+i7SWOudTGAsuNPGg7WRsu59ts0rhOCnpF+WJY42cqKAK4oA
   A==;
X-CSE-ConnectionGUID: 3ylG0jZxSjy/0wPviwUfHA==
X-CSE-MsgGUID: c54NClGLQh2V1211Oz0b+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25944183"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="25944183"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 13:32:16 -0700
X-CSE-ConnectionGUID: MyKATVA7SJSQn8RKh1/1GQ==
X-CSE-MsgGUID: Y6HgLH0HQLO0+2fcjzvSaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="59787613"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 13:32:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 13:31:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 13:31:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 13:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF0Qhe0garTszHEavukJVwXmrfuvacuXottP2d//999YEYdBSgv3n2OC/p4vvV/cATtzkpFeIkdS/odiUFfJt6WDFJx2TTk/38lK9WqknohIvqU6xQHL42taXc0iU/2xmL3lJOFLa41jNQgSIlLxjDfjPtkN1kBTXXAi9EUsa37X+EtON+/rXAZAiufAKo6ellfCKAIMWn9TR/UVoxUmMLMFVSk+Qn6R7RxMIgFPuRiZc8Pmc+4fTcmO/c5y2s0jlozI5kVheCcBeIXqyM7Qrp53ceLv58CwSrawJ7zX8flKTm2cPvYycAKqFt1U18Z8NTXPMRBRcDCJ3HIQ3nvAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d/7Tt45OXldMk3839ujRZasrOk/waJnht2i5O+aQuQ=;
 b=UsB6C1KHsUTMuPcej/E9UQHfDq5mZMbBvoR+D3/mrH8PIw3VqMOrBhqZpuH2SREtVrkD1gexytq/UqOiOZRlqjnbxqyLQHRfOhbTIA9ngwB3T9dQGLcO6cXY0H9+NzCLkP8zRFMUx+BmK1uQHkkjhOPR4usA9Svk1YS+NBq2G9gJhcYoTwlbg74K1u8AhrmjZxiRbaXNTmVV9KPOe9SFCjXvPNjLQz7aiZN9qSF5oE8OrLUDZqH4O1s1+OJePL6qlt6nGXrPhTZVsQR/PQL4sBlyPYCPLlOMAHGYmhntTIgZsMNYyl3JHnik3gWcWCA++BEx5oF+GtqMVliUivzPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 20:31:57 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 20:31:57 +0000
Message-ID: <987c5606-0cd3-8e76-3a6f-25f2406a1d51@intel.com>
Date: Fri, 16 Aug 2024 13:31:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 0/9][pull request] idpf: XDP chapter II: convert
 Tx completion to libeth
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <aleksander.lobakin@intel.com>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
References: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
 <20240815191859.13a2dfa8@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240815191859.13a2dfa8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::21) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA3PR11MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: efef93ed-13fe-436f-9d31-08dcbe327910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dks4eEMyYUpWSFBYTHFTOHg4M2Q2alh3UElzeDVLYWQxSmx0OUNsay8rWjYx?=
 =?utf-8?B?U292d1l0em03ZFp1Kzl3dzdLRGxDL2JEcUtNc1ppYUdTQU5OY0FPTGNoUmZk?=
 =?utf-8?B?ZS85RUMrOEtZNWpxMmJjUExoRC92UUNadWpDT3B2TVh2M25uVW5oaS9JRkZ4?=
 =?utf-8?B?cWUxQTNKVHRlOEI0akJMRTdDTmo4S0d3RHlQZ21MK1U1N01CeWJHNnU3aER3?=
 =?utf-8?B?MDBtUjVKZ2dyY1AvaXJOVHNia3oyS040TUNYSVlob3ZCNGVpbjZaekNGSjMw?=
 =?utf-8?B?SUQrRzZqdDV6S0RXMCtDUk9kZEZZcmFQeWpaTTNjNXpVRVl4RTRjNkFXcVlY?=
 =?utf-8?B?dFIrNVByUnNUbFcrSU02bEtoR0ZTOTVxcVliQU9tQmZsTkJKaVFWQ1NiN1VD?=
 =?utf-8?B?djdvaS9SMnVZeXhTdHh1Tlh2NTF3YW05WEZwNXQxTFVpdW9BVU9Wbmk4TFAz?=
 =?utf-8?B?b0RPWVZpS1dnMlExWDU0Y3g5UDR1UUhLSnBOS01Zay9JcWQ3ZmkrM3ZIZW5s?=
 =?utf-8?B?UHlYZ3FBRlZycURMbWpuZVR2VE1iQnJlQW9rcStZNXhaZXFvMnN0WW90dExz?=
 =?utf-8?B?YWEwVHkwcmFqR090bWpzVjI3N1ZHTnhIWHhiMUNWSkkvMWkrZHdka0w1WHhy?=
 =?utf-8?B?QmtDZ0V6MTFZa0Noeml0TC9lWTQ3OWp4SEgzcm1mc3FkaDB5YXA4c1VUZFVE?=
 =?utf-8?B?L3dMaGc1VUk3UzZnbW1WK0pETTNUNUhpQXdLcFpVS0dwbFV3ZnVXSGJLeUhi?=
 =?utf-8?B?bzFVY1FzOUlteW1CeVNPeHlnbUZZUkMyRm93NVJlZmRPVUtLdmFnbTE1WGQ1?=
 =?utf-8?B?dVdlS1JJdUFucXRRNEJJZGtnYURpdU9HRnhJdlFuNmV5ejc5K1lYNERUQkdV?=
 =?utf-8?B?QTRXRFlDK29WaDRxVTVZNGp0KzV0anZ4dXpIZHduYnljL0hmeVNTd2VQc24v?=
 =?utf-8?B?cUNMSUhjbFZyeHUrYnd3Vmd6OGZHU1FUeFZ0bnJyc3hNYXR3UnZpNTVwRDdO?=
 =?utf-8?B?eWN3eGpZZ2Y5QXNmeExyOGJzK3JjdXNyMGZ0WkY4YnBwYzRMU0k2dHJkTnRm?=
 =?utf-8?B?SUp0dm14dTlRS3VaL044bkJodlpYSXd0d3Fld2VXZWlqdCtka29naGxYd1F1?=
 =?utf-8?B?YjBzQ2p3V2ora2lvTW1sbGVVaWIvQjFQK2xJR1d4M2t1TWR1Z0pMWmZwdUQ0?=
 =?utf-8?B?RUI4eUF3dU81ZjhjUEJ1azlJU0FWRFAxY1NQaWVaYTBKKzd0ajgvMkNmTFox?=
 =?utf-8?B?b0VuTDV1cG1MWjI0dlRQSjFQTHlWblVtL1JKanpTNzNRWWtUR2xkU0wzcXpY?=
 =?utf-8?B?KzNKeUFVdHFlWllXYTNCa1N6Sk0yNFFLOWkwckRwa2QzVW4rT0ZhQjVrdzVJ?=
 =?utf-8?B?dmlaM3E0ZEQ1a1ZIWG04c1ZwSnFkQS9YaytORTBpQjlrUzVtS3NGb2gzckNT?=
 =?utf-8?B?OFhXT1d4VXpDeUNtemZrVjhTK0FwSWY1dE1qbTdqUmRvM3V6S1VsZTFQVGk5?=
 =?utf-8?B?WUYyeFh0V1V0cDVZRlZLOXlxNTVhTnVxNVlNOGlWUVVrc3I5aFp1SFJFaHFF?=
 =?utf-8?B?cVViYWZlR1RVV25zZWUxb2wrbXRhZjFUY3ZFTENyVEVXZERZMDRHM3NqMTZo?=
 =?utf-8?B?N29PRlVhTlIwa1lwMlVpMWFFSXFoZUhDR24xVWFERDZ3ZWRoOXprb3FHZ3V6?=
 =?utf-8?B?SjJ2ZW0wL1pUSFltUlZFL1VHdEp3SEJIaVM2aUQ5VGt5VUhyblhPNG0zYTBr?=
 =?utf-8?B?a3BUSkNTd3dmdnFFR0VIMTd3Rmg0RnpBcWQvUFNXVllBakV1dytmQWc1NGh2?=
 =?utf-8?B?SkcyT0FaRXRDWXQrQSt4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2gyeWJLYzRGUHI2bTExYmFMaWxRWFlBeHdTMTRBVzd6NUxmeU1DL2oreUhE?=
 =?utf-8?B?NXp4WTlQMHh6bVg1WHBEYlpXLy9iRGsxaVhVYlBYd002TFRibVBxWHlSTlFk?=
 =?utf-8?B?QllwNjE0b0R0cFVBcGxUdW0weFpoaFRQTFg2UHNzMXFPdXgwc2tnQ2UwRmJy?=
 =?utf-8?B?MXJRNUZpekF4djd3QUt1NTRMeXg2Yk9Hbm02M3VockloVEJ4SS8wMFF4V1JF?=
 =?utf-8?B?U2t0SEJwZzlLUlRSZmZVb1ppVmFRMHFlekJKM2FXWng4NnpaWjZZOXFjeG9i?=
 =?utf-8?B?S2J2dTRTaytjbk9uY0xRcndYaTlrU1dnSU5XL2laa2NhOVJkNkoxYURQZzNv?=
 =?utf-8?B?Tlk4VWtIN0FSTUQwMldnUHJDVWFUQStPYzJyRE9sb0xLL2ZqbjZJTWt0U1Rx?=
 =?utf-8?B?WlNnUWlVb3BtNzlPTlRNYndhTUVrN2k5UmhSVUpuMmZPVWFnWC9HRWlMOE50?=
 =?utf-8?B?N1Y1S2gzUXJWOW9JM3ptcFowdlZIMHRHMEduclhhSW9UOE1tYTRzMlVNa2FP?=
 =?utf-8?B?QnJsWEFRWFFSV0t2UDFiTjk5dnNIVjRpYXg4Nmd3aXpudExjTGpBYUFOc05l?=
 =?utf-8?B?WEtGZEQzdk54SkNDbkN1SStqYWxVbnV2TmhJb2xTRFY1eTAxTHRwY3NaY2VD?=
 =?utf-8?B?VER2aHgrcnJUQis5ZGVrTGM1QVJpV0RKL1hsZTgrRnNlckhiSmROcEkweGtG?=
 =?utf-8?B?RlMzQWpZKzdpMjl1c3lKK3AyM293N1U0SFNxcmdqSWErd0d4dkRpRDFOR0U4?=
 =?utf-8?B?U2oxVXEwb1hkQUtsVGF4STJZV2JEYzBqam84a240UzBaNnpkQUpJUXoxc1FR?=
 =?utf-8?B?OHk0aVJYRzQ3ZzRTd1QxZTN1UStKcnE5cTYrL1c1a2d1d1NKM3ZsQUFod0NM?=
 =?utf-8?B?VkdjWFhUR2dPR1poc2NQMFNkbjJBb1c0L1NuQlZ2M21qUXNISUNVcmtFN1hF?=
 =?utf-8?B?ZE9vYkVodm5CeVpPU3FMb0FTQnBrVHRBRTdTNks2UDNnblFqY1VCTVVtWDhD?=
 =?utf-8?B?enhRV1dQQ2xvc0JrelN0Q0d6bDFseWd3TmowVVU1Z3Zvdmo5c0p3K1NXeXNh?=
 =?utf-8?B?N1hzcGNwdElGeUEya3BibVpEazZuSngvRW5OSFk2QTBMMWFlUTVDZi93T2R0?=
 =?utf-8?B?VjRSc1ZIMmJzTEJBZkREanc3VS9PZE91cTZQSE5PbVRiV1FQcDZ1Z0toOTJW?=
 =?utf-8?B?WHI2c1B3L2JnSzFGbjRsUHhlYkZ0TzV3TjhKY3ROT3h4czhmbVNkZk04d3lm?=
 =?utf-8?B?ZjYvUmd0ZG9BSTJUSHFpM0kzT0pHNUJ1ZWVad2lEbDQwSS9lcm9KZ2ttVzh3?=
 =?utf-8?B?dmQ2NkRpODZCdFNBNE9WbElYRUxjZGZWVk1yT1g5ZEtRNTRodG5lZXppakV5?=
 =?utf-8?B?Q1BOQytpeTZwZDMyWEdrWHRTZzh5OHQrSUNTRnF0WnRNMUgyNWJmNVZFWE5i?=
 =?utf-8?B?elRCZ3o3bUNvVk54elJHRnR6Z2gzNVE0RVUvclBCdzlMR0dvSkZjQVhYeXJL?=
 =?utf-8?B?T1RGZlJSclh0ME5wQ05jY1RzL3pscDdMM0JwK0FLK1ZXVWt4SFhXcWMrVWVY?=
 =?utf-8?B?amJHMGFsQTV6ZkNxNVIyZzB2cDNXNUQ3NkJRaUhxZHlSNVM5VnNuK0JNUWdU?=
 =?utf-8?B?MEJXc3FFVXVwZU5LbEdSa0o3M0lkOUN1amlnMGFZUlIzSFJCNWVoNXRwbDNn?=
 =?utf-8?B?cjUzYkpZeEY0OGw4UWJ0WElLQ3ZBRDFVNFZiZ2RLd3ZtMFhSK091M1RMTTBu?=
 =?utf-8?B?M3ptT083ODQ3aDNnck4xTEtnNGRJUVhxQXkwclZLTENEUnNEUTMybnNtcW93?=
 =?utf-8?B?SjY3SXdETTk3WTZ1QUFVUWx1ZmVBUldCR0NvbFZpaTBiYTRPeVhxWEY5SWhN?=
 =?utf-8?B?YVFaMlJuMlB4Wnh2Wk5sSmdURGJ5K3JMb055MktKeEovVG5SWmF1aWM4YXhV?=
 =?utf-8?B?dlNkQ0ZtVGkxUFFvQVpsM0lVbnFEKzlVSXdoOGJUbHVPY3lsU3RheFN0dSt0?=
 =?utf-8?B?MVlBQUpmZlYyL3d2NTAzSmVFY1pXUHNqQk53c0JBelhMUUNnaDcrWE1wZDFS?=
 =?utf-8?B?R244ZUgxc2xnZ0lwa0crUzhVR1IxYUZrWWd1Q254WWhubk9NdmJPcEpZOTc4?=
 =?utf-8?B?UUdtSGVuaUxYMFIwWFd0SVpISU1sbWd5dGtYWXdrOCtNZHcvTEJITUhNN2Vz?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efef93ed-13fe-436f-9d31-08dcbe327910
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:31:57.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmOBr5tiL7NU6eSKn42LyqBDqK8v6XuiGAcJtz+DTPMud1dhOeUbl0qxp4KacpkXXYqh/Aoe/E8L/v1lmoR9yHD/L9WzJ5Yh6s92CHLzaaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com



On 8/15/2024 7:18 PM, Jakub Kicinski wrote:

> Eric and Paolo are mostly AFK this month, I'm struggling to keep up
> and instead of helping review stuff you pile patches. That's not right.

Sorry, I wasn't aware. I'll throttle the patches I send for the rest of 
the month.

Thanks,
Tony

