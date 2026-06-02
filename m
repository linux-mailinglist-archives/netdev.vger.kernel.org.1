Return-Path: <netdev+bounces-294233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /kfVB5biHmrLYQAAu9opvQ
	(envelope-from <netdev+bounces-294233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:03:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7862F1E9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:03:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KhvHqRNx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294233-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294233-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51EDA300868A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B513DB33F;
	Tue,  2 Jun 2026 13:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C13939BF;
	Tue,  2 Jun 2026 13:43:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407797; cv=fail; b=M60EDLi67Bvufo49wSWhCJVRrHiI6RaaikkfFxL/sEueQdNu0ba11tStDrdwTkzKG6iKWZO6AxaxNo1YOLbIZtT27a5mcViSwJtzPWzm13IM3MSnxqln35aaQVsb43VVZ1PqtqLC39TDOcyMIXhrhR40QkkQaDI3EkTgyZXy73A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407797; c=relaxed/simple;
	bh=vgRu9HV9yiuJb2/BU9nLNB8r5gebtn16g9ya6wql8D4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s8+IoCR/ykQKIXfk+vl2aJx25jl2MyT/wiY32gRuuysNh2JXCmjxZ63/Z/0PjF7thmPfDxKwE+tMMNL3yOzdgfeubIsSuV1SdA7blRM6ZIR2ait2BWDyYiGpXwkJATmDTF5Xc6cgoHWSF5Wf6iveoUWj6f3Fa5jUMy9UuH6VZIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhvHqRNx; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780407796; x=1811943796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vgRu9HV9yiuJb2/BU9nLNB8r5gebtn16g9ya6wql8D4=;
  b=KhvHqRNxd+ta2aB1yISB7i1MaJhtH5hr6ZQhdB1QdJNyhfSKlAaGhZRV
   u9XvxrvloTs1+CKW3opAoj/I0jwdjhQRWDgsLq1ib7EuJb2AbNz73iTZ8
   d33amza+DMrdjYJr5gJP2vlS1Ds8eXpgr1yPygEnjyYwgQ8eymGWSXy58
   63oESB8sql5YD0MAaWTy6wu/919b+ScdknkxADJGAhDAaTfLfIrWWHH6P
   vuNRJE+DdPCOBeHQtV8u4pqK+s07/UX8MNjB1d36QBhsIzkl+p9xcjGSF
   2NXM6VV7XjOdC8Ghncqworxm7aZ5PtxSCS1oMgXOL13d9aOntn2aJZV4Q
   A==;
X-CSE-ConnectionGUID: kWWfVY0rRuaa1OcwEy/xtg==
X-CSE-MsgGUID: f2sXQcg/RnO0MoX0r3yroA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81161579"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81161579"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 06:43:15 -0700
X-CSE-ConnectionGUID: muAYffzRSTWaiosCG6OMAw==
X-CSE-MsgGUID: nSBmvaPJQuiPQfbz6SuvrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="267548892"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 06:43:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 06:43:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 06:43:14 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 06:43:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw2+0WCw+pv9zKqYuJmpQDcJBfeG8pi6ULUnKfrnwFRuCL9MO4EKK5j9vtDcdhcqSMNuw9dw217daJlbgsH/SIn6nFwLYq9kt09HBwRqCTKdqPO3Pm2OmX+Gf+GdbCaSyo0HIMbePmk66/7QQFLFsStqTB0Mh9ERzK3FKLpNJVNygODDjpG9rlfPNCqJVOyGpahwektqcZc3tInzFjGpUVRyT+vLV/UsfTmqxFeX5VbpgTh4Rhve1QuGN0NHsZNfu4q3RaND0H7rADPpQxi0j9bGuSP0awKkMU9pDHi5ny0BaFhXw6nhqmYlwD9Vs+RwiTmL0se+Y3imKN8wJnsexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLR3dLX68GBeyXr9JLtfRJ5UzAdCGZbSVrdTZaohsmw=;
 b=VDBcQVt9ORb4FYHDxZo1hIwm/+UPDnexu+67RSKFZVE0zdPSrOgCHGksvUIYWlMuvFE0ljUj1swa+bLm03hQTXkq305WcptHFO5BApP4GUSPbJxdYxnE43EcSPX4+sXUr3lDoBraoNkFRPYQSmGqD9WO+dxmYyB9yKc2MfKTQRZFh6JX03UVQI2YyDMYhUBdSv40K7rjrRlasCg6QaIcaJOGkcAXebiGkCNXBS3myQOn4nSUnW/v86IBlYxFLzwJBZ2AtwMEdiF4rHYZJokb49BO12vIsA9uX5VL3muN0N0LY0ZQBDIRoE9nQGgdaB7s3Qo4m3Ccd5rEihUUYeaGFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL3PR11MB6481.namprd11.prod.outlook.com (2603:10b6:208:3bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 13:43:11 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 13:43:11 +0000
Message-ID: <d84e7de2-d30d-4ec1-bdfd-6d5e25d0271a@intel.com>
Date: Tue, 2 Jun 2026 15:43:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtase: Avoid sleeping in get_stats64()
To: David Laight <david.laight.linux@gmail.com>
CC: Justin Lai <justinlai0215@realtek.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>
References: <20260601062447.64027-1-justinlai0215@realtek.com>
 <f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
 <20260601224203.5d282c21@pumpkin>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260601224203.5d282c21@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0347.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL3PR11MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa77eee-e678-4107-dbcc-08dec0ace2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: jVsq4zRhq1fbPlzgmhF7UERCoDRtggbwwv8w1v/YvClM7+YWnlBgfwPii1MG3w44RrU8wfpEeluOmb3fEPZZjirn9oRsnrWBxf90kzXVYyxECeUrQtObNVhRTQ3oLx47v8XhCEGqLu059tpkron6EPYQ2AYb8tb+Cw9TzhcVpzzgAPYHv8UUX3IU/v3z6dz2Ot1QdqRo5Hyr9Mlq40MeBikLkzpZQQ0K7JdinLSnf760iWlALeCZtRUc1GrXYvlyOBt3Ejp59FPzxn8q2zsyD/11z3PZyUpsDK7sxR4V98HmIOjUbnOeiF0AYEdklAtHhNpF4qDrni1P96qtmYqLcrnqWfUduKRJ9jyap1j2LbVcxip7g9dOerc/T0UXF9PDGWQiysSafn9OAc8Xy0JHCWzdN1+0VNiHcDg+iEk/hxEHnw3/VQqz5CmdS9c44QLQ6WOXLHziEAVTgc7XJ/a7WxglPaouqkLINF0QGYeuKr3OSuVoq/cA9xE/16UjC0cMxcDINXTBUFaVYk7SEm60hlr1yyzuOB9LrsWGxRVZbqvgMoAzx5jqkywgDf+kNDGx/JhLnwlHRiBdl4WWQQXvKs2gh4xK2Ic33c1FS0+OhNR8v3XmGz0ZC2BM3nWD1v5Gj/IVTh0ZttGv5nH1glijBrAdyLM8pvh0zWic0Syr5aT6zCbngLbFrRVHNyokCpF0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME1EM3VIQnI1ayticE1JbG9jdHJWWlRaMkpzYlZ1QnVsMmdBakVZUitNcklh?=
 =?utf-8?B?NnNMemkxSnpFdWNvenBhMUZjMHVxYXRwckR2d2FaSU1GYUJkd3FPaEEzU29w?=
 =?utf-8?B?V3dVTFpDOWQreHZ2eUZuMmlmcHAzOFhxNm9zSlBUMTNQTGpHL3haZitlQU8x?=
 =?utf-8?B?ODNQN3hoWHhQV0huREc4ZkI5cmZmY0tRbDU4K3poTHFpamZtM0tWekdUVnU5?=
 =?utf-8?B?SDNMMXVObUt2dzJBTlJNREpNdDdRaTI0NWRMaEZqMEYwbzdlb2t1VFBpMyti?=
 =?utf-8?B?RTlpNENCdlpMN05lSVE3WndrR3BzRDVzUmJkZVlVS3hzek5wek1CdGExQkJ4?=
 =?utf-8?B?ZDBXUkNLb1ZWMnR4UFNTc1IwT0pFVEtCTlZ0U1NuMERUbXhSWGxDZWlJeHJO?=
 =?utf-8?B?YXZTZlBHT293cTJVTTU3emE1TWZuaUl0azJ5RjJTQ0ZvWi83aWV0alo3Z2Iz?=
 =?utf-8?B?VG4rMW9jYzhmQVZFSS84NHdURlVsK0o1d2xybkxEa2p6OHVlVEFRUHdydFUx?=
 =?utf-8?B?ZUE2K0x0UkhXYkoraUE5QmtGNFNRN1plTnRQUlc2ajR3ZW9KOUd4a0hrYlhY?=
 =?utf-8?B?Q0F6aGwxRm9xY3V0ZXVJbzhnb3hueVNPNmJjWngyVmhIWkhzVHdFUktkRU5y?=
 =?utf-8?B?NUFOdXdhTlJCSlFyRVZTUktRdkxzcnNKMy9lVWUvZHZYdTgvdjRvdmR1S2xU?=
 =?utf-8?B?UlVscmM1VG9xSGtlaHRLVS9nWXp6V3RKL1NNZFZCSjVqYk9hWnEzNXVJMmR3?=
 =?utf-8?B?ZU9XNko2MlJwQmpmWlhkUjkyU3NVZXJZZENQTC8rZWlQYnh4amV3dW43TzUx?=
 =?utf-8?B?WHh3eWJnRHNlaVJBSkJNTVVEUHFQNDUvb0dBQUZVVVRmbVp4RlIvZTdKVFBo?=
 =?utf-8?B?VHpPWVk4V2tpQzNNWFl5QmJDdkMvWjlxNUNiZlkyN2hBUVppaEQ0MlZpTUlr?=
 =?utf-8?B?UCtuZUFJNU8ydVoyZ1pjU0h4bXZldkplc1ZyQmg5OVg4MER3MDNuN3ZVOEtC?=
 =?utf-8?B?TmNGZktLR3BFcDR6UENwK25aeWlIam1NYVFhTForeUZhNytkTis3NU9KQkNp?=
 =?utf-8?B?WnYwbzNqeEh2aGd0SXMwNzFjQTlLaWV2OThLMzBQdmcxVU0vVWhZQlhMb3Fl?=
 =?utf-8?B?anNFVGZWY3F5c0psYUJPOEFRMis3Yk1zNFlnd2YxWHh3NHArY0hvVXZZYXZi?=
 =?utf-8?B?WWJ1MCtaN0NBem9WeVZGdFNzUDJET2NJdlRqOEJCTnBJYjgvampabTBaSk1r?=
 =?utf-8?B?R1gvTGxaaVI2SVJBOEZzZEN3b2RkQThlMGtHLzdWanEyYmNVUVVZbjZKd1k1?=
 =?utf-8?B?SnBacTRYdUJHZUE3Z3dhN3RvMDNuTVd6UU1QSlY4blB3THE4NHpHN0dwK0ds?=
 =?utf-8?B?MS9Cd3ZYcGQ1bkFNWm1hYXRlZER4WFZHK0RPL0ZBM0E1V1U1Q3VuQ3pLMTI4?=
 =?utf-8?B?K21nbE5GVURadlNTTWVSOEtmUTBoK3o4T2R0U2gwbVN0a3dQNGhHTVV3YmpT?=
 =?utf-8?B?STMrbFJqNkEyQ281WEg0dUFxa2Zid3REOVZsQSszS1NWU1U4RC9lVEQyWmF5?=
 =?utf-8?B?dUhCbUZPVTNZL2lQSWw4Rzg5VlZVUGxXZEovV1dUeWlhMkhJUHAzdHVXYTNp?=
 =?utf-8?B?Yk1zRjcyTE5NbDZnSk1xRUdkaHExRnR4VXM1eEpTclVSVnFqSmJ5TnRRMlQx?=
 =?utf-8?B?YUJKMytUOHhRaGJjY1NUUDhzMTJ6OS8xd0xhOXlHUmJnVjg5UjRXakNQVm1E?=
 =?utf-8?B?dlJoeWVRMC9ERXRLZ0RnZkJpQkozQlpBVlpNSERvQVFwQ1V4S1ZyYUxGbklO?=
 =?utf-8?B?N0RsOXpxR3d0N1pROTJRWjg5am1FNGpMZXR5NXQxektEbjkwZkNzOXBzUzl3?=
 =?utf-8?B?Q0xUd1lHaVRTQ3NEZkx4anpiSkIrQVFMMkQwbm5pWlBJYUhHczJ2UXI0dGtu?=
 =?utf-8?B?a2ZVL0hPZkdzY1NaekVyNHJsdzBCa1lMYUROUGRLcEFYc3RDNnJCU29FKzUz?=
 =?utf-8?B?MXl1VHRWRjBhU1M1d0RocFV6dkhyeVZxUzh0QjluUExFL2kwcHVGV1ZCenhC?=
 =?utf-8?B?Q0NYVVpOWHEwbm52WVBnb21yUGNxWDl1WXN4blhnaUJ5Q0FySUx2Q09TVGRt?=
 =?utf-8?B?UElWU2V5M3U3VkVYb2lyVGtpNzBLeTFaT3JUVWwrRitIRmdsRkVoWlVMNjFI?=
 =?utf-8?B?ZjZQeG5GanMrMFZqMm0wRUZYWXN3eDRTOEdDZ1RveWN6aVB2Yzh6TG1NUVNF?=
 =?utf-8?B?aHdjVWNZSXpXN0V6VDl4VFpGU2JCeVhhZ1l2ak1wNnZsbUc1RU5RTGJMM1lU?=
 =?utf-8?B?RjZtKzdXSGtrcE9zSzJ4blhwMWRNTEhWZlNHTVc1VHFwSUVKbERqZU1yMWtj?=
 =?utf-8?Q?Kcdqp7drIe4fB8bk=3D?=
X-Exchange-RoutingPolicyChecked: DGOgJ69JBnmb7ZDUg0LjqzHcBBYUlh44BGq3mZTFCFbc/ucPQnGMfu0bSauCqWSEhAYDyByfFQVCYP6Z04huSkOLle7HX8z057GjHDECoT+Iciea47NmGN2rdWUst/suhxhScfANGlCQ+UPn6qzAVYDjsaZLllsmMSVAn8FlEtGNa/9qpqSQd9EEdlEV8EHCOu5Pmz+VT+vqBG+WBmRYW634w7o6on1G/OP4QkCRVG6rJs1lT8a4hn7zQdrMCPn7cc+9rP9bF79fQiAxWuh4Vutj2xTg5hBO2BkUcu6ySkxdqea/5UJ3dyakMTss/dgQ5aFYfbM24MkIXMZoLXXJCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa77eee-e678-4107-dbcc-08dec0ace2c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 13:43:11.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt4+NMlqhDoeAwomfMHzYYdvVb8VQhpkimMgD3rD8oSMcYq8AyiuJ1xmdarxoZjv0uhHJJtZLiVZl+5yr4SIjra6OXV4oAVFQLz0QwlTJbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6481
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294233-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:justinlai0215@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:email,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83D7862F1E9

From: David Laight <david.laight.linux@gmail.com>
Date: Mon, 1 Jun 2026 22:42:03 +0100

> On Mon, 1 Jun 2026 15:14:50 +0200
> Alexander Lobakin <aleksander.lobakin@intel.com> wrote:
> 
>> From: Justin Lai <justinlai0215@realtek.com>
>> Date: Mon, 1 Jun 2026 14:24:47 +0800
>>
>>> The .ndo_get_stats64 callback must not sleep because it can be
>>> called when reading /proc/net/dev.
>>>
>>> rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
>>> the tally counter dump bit with read_poll_timeout(). This may
>>> sleep while waiting for the hardware counter dump to complete.
>>>
>>> Use read_poll_timeout_atomic() instead to avoid sleeping in the
>>> get_stats64() path.
>>>
>>> Signed-off-by: Justin Lai <justinlai0215@realtek.com>  
>>
>> Looks legit.
>>
>> One question: for how long can this poll for in real life scenarios? Up
>> to ~1 ms is okay-ish for atomic, but if longer, then you'd better to
>> split it into shorter polls and reschedule() time to time.
> 
> Anyone trying to get a thread running at an RT priority won't thank you
> for spinning for anywhere near that long.
> When an RT processes becomes runnable the scheduler will preempt a lower
> priority process that is running on the cpu the RT process last ran on.
> The RT process won't run until the preempt actually happens.
> 
> 1ms is a very long time.

That's why I wrote "okay-ish". Ideally atomic polling should not go past
100 us, I usually used it for no longer than 10-50 us.

The author says that it usually takes around 25 us which is acceptable
I'd say.

Thanks,
Olek

