Return-Path: <netdev+bounces-152623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5729F4E99
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945887AA310
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC01F7562;
	Tue, 17 Dec 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFZBqS4W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971791F755F;
	Tue, 17 Dec 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447382; cv=fail; b=b79pEoUZP2qakOGJnDH0iacw2CY/21k//vtPjIdNl8TDjN19uSl1kAuCLJKdX7yvN/meZkf9AVTA/uQIuyzNdXi4we4bCv/KegIsnk4nqAbfEJAD1AJ4tDOMltyHRYv+2T72A4mvKqGUU7hDAZO2UOcPfYV++u/jIo4/32oHyco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447382; c=relaxed/simple;
	bh=JOc81bzN/qZO/xpr4UShPXn6YScPM+uK6RCS4vDpgzI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bhVe80Y+b0RXJOQm0KLnDofapiBJod7RGmTsPZi7XkIVQbYAzs3tfr0bSa1GBHK2yKo0/6rzE+HcKpFm/zMyZP71/L93rEIZlpv6LefK5YQi32tzwjQdOiAt6VwlojelyZ/nbNH9spPGcf+Fc+jWR526Wt4kLztW5LRsoK/hbBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFZBqS4W; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734447380; x=1765983380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JOc81bzN/qZO/xpr4UShPXn6YScPM+uK6RCS4vDpgzI=;
  b=GFZBqS4WBAs20928YPlTi+r6y/kQv47FWyYTqpzpqnqJn5ifEZuN8Jlk
   7XO6yO7Gj/sIVkzZy59SwJuDlKdtBPRq+papJ8+7YTOUiFT2bkxVC/qmP
   1hp/yuTxu5pU9/uZJr3zO6mHJSgBLzioEWsNk4aXalXdUCb7PGGeCUbM+
   TIvMXN/FnUhrDfFuQ6pnY6ZF2yKJv2T3lENEVOis0mLdODv1AcxBJWjot
   LEkcfSTiiXhpgpwprd9TYc8RApXupfTOUMQvQpebF2ggHiq3XHtONvKDY
   2ckB368oCAqo52uo2xjRBtBNp/vt7ZE82uxKE2sHAT4zPxO6bVXJ9ftjQ
   A==;
X-CSE-ConnectionGUID: nSoPBqa9Rnm/YqL9+mFpYg==
X-CSE-MsgGUID: F/XGpZ+eT6anFL0CsJov4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="46269994"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="46269994"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 06:56:19 -0800
X-CSE-ConnectionGUID: 1U/Hp0WqRTuo6trJ6ca2uw==
X-CSE-MsgGUID: T366W+e5S8KF45Ys4p5DeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102148357"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 06:56:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 06:56:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 06:56:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 06:56:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBdw+XCvr4uM3ydqG5NPoylXilTfYR4kQ+J9Ya3OXRV5kE2e7hCNdKqoNME0N4D1UEKrr/3jfBdkUDBTeg+wi6EItrYBnCS7596sDcmn3G/aJgRRTcYuWZm08pFo+v/QNavV/Kw15D4X5YXGnd7mKR6VEtLzZ3a5RAdKwN5eJy9AWsg9WP2lbEBgZUc8vJZWdLm6LoSlKQ8ituIGgr4TceN2VnoG7L3V2balQZFWgzzAjnJslukfSAW+xA3kwt8T8fQfbbsZxqv3LSwaJAOYhu6qJYkz4LDkM6GAV0UYUwtBE6djK6JjVMyLiIfhgvXubsQr63Acpr+gAG3tzJvI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KjmG/jkRXLm8XxniNa7f/uFOsd/3SujNLwDE2x4cw0=;
 b=WYhuD5TksOpk02pDInmpQVkzxRO4xNAcjrd6mayPx3US4dMeOyAB14qn9aCs1CWU3Sq4qOHo8tNK/j6PQ1x8PydviZlGZzW0PIYF+IKroeuvpCl6QOJl6OPGEMsq2eQlrzmFpqdWWm125gPV7KD+tLpzFMPmpuemWnT9PyR/X7vRoFgxjhL+AnRy86rfbWBjxSw24B8Ew4NKG8uqtk8/G+hZQGHD95gcfPCdofxxh7oaNNacNw3zTH1XgE7+/5hTo0FrC0niLQiKqGUsnnxLpp+uLsvOtpWNBq39daNhe14P0wpNmmtJuE/lNE3A5/CRhfw2ik5XelA2QUZqDnGAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 17 Dec
 2024 14:56:10 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:56:09 +0000
Message-ID: <f4947447-aa66-470c-a48d-06ed77be58da@intel.com>
Date: Tue, 17 Dec 2024 15:55:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] UAPI: net/sched: Open-code __struct_group() in flex
 struct tc_u32_sel
To: Kees Cook <kees@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, <cferris@google.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, <netdev@vger.kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
References: <20241217025950.work.601-kees@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241217025950.work.601-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0254.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bcc191-43f1-4ef4-76d1-08dd1eaaf0f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ellCOWJwNFlJRGtCODlnZEx4MHRvT0NONzhGWmRBYzZJekRScFl5RlBaUitW?=
 =?utf-8?B?SkE1Sm1lZVpGWUFRNjIwR2V0Zmt0c0cweXZseHlJVlRNQmdwdEtMOEJHOEZI?=
 =?utf-8?B?blBvWWErUG1jTGhsdytVU3U5LzgrY0tDWE83emVvTnlNTWVpQjV2UXZJV2JB?=
 =?utf-8?B?UjhuN09FWkROUFp2dDcrL0VsTVdJRWhRNmRZR09iRWJ1dGs4Q1dSVndQMFow?=
 =?utf-8?B?MHBEcllHNHdHRDI0SEhRWURwMXMra2tFRXBCdnF1NnlqVDVEekQrbkJCRTdP?=
 =?utf-8?B?T1A2NmZmUngrbHl1MDdtTFA3dVpFRnZNaE1tcmRIbEFXaVF1K05XdDlZU3Bk?=
 =?utf-8?B?THVXdEJWNlJnN0VYSzVGSEJmVmtpaVdSTTdFUm1vb2lqQnhsYlZWbkJCRWlS?=
 =?utf-8?B?YXYyVFR4aUdGRERHTGN2ZXo3R1VHYUVnR2pRM2NmRHNTNmxGYWJJQmtzeGFJ?=
 =?utf-8?B?MmZsdDR4WDBBb0tGbEo2K0dtQ1A0MUpTR2VuUVZwQm5qdlVnSmI0R0h3NGxq?=
 =?utf-8?B?bjVrOE5vWUlNYXdldUpGeVpmUUhJcUswOXdtMmhrQ0VFT1VSN1hNUEY3d251?=
 =?utf-8?B?TFJ4c3A4VDRuMVJEWmFYd211b0lrNktSVWN5TmdQVnpVQUFKSnd6bDhkTUFH?=
 =?utf-8?B?b3ZKWW1ISUVRWS9uWkxIblc2SnpsdHFleGZPQ2JzRUhnVm9oTGRlYlRib25m?=
 =?utf-8?B?OGJjR1NEdVJDRWt4Nm10SWxkNTZPQUhROWF0czlSdzBVTnRtR0NQVk4zZzFu?=
 =?utf-8?B?N1M2bVJnQkxVbnFOV2lLaTB3anlPelJLSVZ6UU04S2VFL3Bydk5LUDBZOHJo?=
 =?utf-8?B?d09FejdTRDk2dnpYNHgrbzBUOHRONnNYbGw4M1dKUjcvOE1YdXhIV0NsUzFn?=
 =?utf-8?B?Wk51Nit4dzFiNmVxdER4Kzg5ZzBzelYyZHF1R3dOZ3YxbVhYRGY0QkgwSktL?=
 =?utf-8?B?K3I3NDJKZU90UWtKTmdqQkRWZGZwK2ZsTlFKZE01VFN2VlFIMFBYU0N0dk80?=
 =?utf-8?B?VGZ3R2s4aGdrNTV4MGVXazhickZDZ0lvWndnb3ZuSWpHUVluc3V0SlFVSURm?=
 =?utf-8?B?TjRqNmZWcjJrcXhnUXdsUGZsUzNTQkkrcWQvajdrcmlZMVhaSTJENkQzMjNF?=
 =?utf-8?B?OHN5OXNpV3lJdGNSWTNZaHMvbzVYVk14SXl0QlRKMXJlMWlGUkpxWDNLM096?=
 =?utf-8?B?a0RySHJqNW55Q2NUVzBVakd5dFJhWmtES1ZreDJqaVAvQ21sVUFRVTNpTkRa?=
 =?utf-8?B?eG5xeHQ2MkpzOXVQc2tDRVRDU2krTGx1T0JqWmxlSmQ5SmR4VVpIQWoyRU9Z?=
 =?utf-8?B?T0szaEF1SHQ0bzdvdGJESUZXOGdEOEJVSHpBY2ppbFJIKzdweTJwd1Rpd2Y5?=
 =?utf-8?B?amhPVEJJV2ZwR2k1VFU4QTRISVVQZHB5MTNiVCtnaXg0S2tSMXA0blRYRmk2?=
 =?utf-8?B?ZXhURzlEOXZHRmtjOEtYTWtRYWhyR1RVSmZqQ1lxejRhNmc4MGhxZFdkY3hx?=
 =?utf-8?B?cjJwNFUwQ3dEQ0VQNXpFNCs1bHNCRGt5SEQ0ZnZoMmZuZEFiTnJrakxhSlZB?=
 =?utf-8?B?VXROYk5YNk1iV1oyZDFlZGEwc0pZYUdEMVpEbzBhOHQ1TjY3RkdTVS9Ib3lj?=
 =?utf-8?B?b0ppQ0FEMGp3TFkzVXFhOWt3QzRwOFgwWW5mbDU4UkV1SzA0NUIvWnJqbFpl?=
 =?utf-8?B?V3Z1T0lMMitUam5IVEpLN1psYSt3YWp0TWxraHhIQngxeU5Fb0V6blgxbjZv?=
 =?utf-8?B?Z0Zqc290aGNsRlY0MzAxWE9jKy9EVDNvd1JDa2IvcGliNDYvc290YlpLZFZE?=
 =?utf-8?B?OTRZSVc3K1JIUlBHYkJPYzEwSXRwcjRqMjhHdklnem1LdEdBRjBaQkszczJI?=
 =?utf-8?B?MEFGeFg3eElabUlsc2ZSQmJoZzJGQ0x0QktQdTlybFJQb2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3c0QkdTNUR5L2ExRTlGdXdHWEV1a1E0YWE4UmdTUWdqdmxncVh5bkZ2MmNU?=
 =?utf-8?B?clpVYllOUklROEV3OHlUSXlCbm56aC9BRmJLWWl3Q256QWx2ZnFnTUdmRHRY?=
 =?utf-8?B?T1VJZjh1eC9nUkRWNmRqZnl5VldDVEZYWCtjdkJ4bnZPQUZwOWRIRDdIMlho?=
 =?utf-8?B?aHlPVVArMkxJSW5jYzY4djZLY0N0SzNwbmUxRUxzVERCZUlMdGFmdnNCR04r?=
 =?utf-8?B?SFhQRmVnWUtaSFFITm5tQ2ErL09rdHNRQXhRcFd3bldpNnBSVmZQOHZwOHRv?=
 =?utf-8?B?ZHR0Wi90N24raXd1V1ZjQVo3djhlMzZEdk9MRjc0b3J6M1o1L3lGWWpNM0NS?=
 =?utf-8?B?RzJlY3BSZHg2QUJpZlZOc3AyVC85aWgzSWM5VTNTN0N3NEdLUmdVeUY1VEhm?=
 =?utf-8?B?eDltc3NhUlpFZmZHWjJYNS9iTHVuaDJmN1g4UEJaREdaQS8vRzlBR0pkaFBp?=
 =?utf-8?B?Vk4randNVVB3VGpPaTY4TmJkMFE0aHFhcGJaVEd5VWlOYm9qVGxub1V0MnZS?=
 =?utf-8?B?MUZ6OStpWEUzeW9NMVNwaUFFbytkOFpxOXZpNkt5UlNZT3d4RE1JNnMyOHhU?=
 =?utf-8?B?ci9EWVZmemNNSmwvcy9yUlV0OXRpSkV2YUpzNlZtNXRPZzl2QkMySndpQzF5?=
 =?utf-8?B?c3BHUjlwY2tFekIzekptTkhKSk94ZFI5RDZrWjc1aTRRLzk0aUpOdmRNVHEr?=
 =?utf-8?B?SWxnc0xlM3VrdUhaNFczVUI3ZXp2c1hqVFcxeHRLUjREUXlNazNPem1VcFB4?=
 =?utf-8?B?UHN4LytvSk9YWk1pTkRTOXArMlAxbXNFTERDMHpFbGgveCtBeUo3WmNvS3hu?=
 =?utf-8?B?ajZkUUF6aS9uMTZhRkpTWnJYak1mek8zS2hUelBsdTY4OHB4OVpqY2tnck9R?=
 =?utf-8?B?QnJlbDhRNVp5TVc2KzVkUXhsQkVoZ2p5R3cwV1gyUy9xWDVId0lBT0U1S1oy?=
 =?utf-8?B?VVlCU0ozQkpMUFdsY3FNSFU1ajQ0dEp5ZlNSdEFIZWw5Sm1kSS9BSVR6Rlk0?=
 =?utf-8?B?NGZGNjdYeFQwdi9hZWFvVjdzbmM5RzBJRER5NkY5NzI0L0NFQk5zU3h6Wlpp?=
 =?utf-8?B?RTRWdWNLWFppdjhVcWZhSE5LZW5MeFlPUVdBcDMvWlhWVWdERTlkS085N3FV?=
 =?utf-8?B?TEN5S1BwZEsrTG82SytGWUFjZ0F2YVkxRlpydnFuNFJ4Vk5QZ0JHdytSbzJL?=
 =?utf-8?B?T1FuRmFUaHJQVUxZTEk0VCtiVnBnTlMxNmdiUEFHbENGVUxsb0RzcGJISm1X?=
 =?utf-8?B?bkp3MUt3RSt2b0FjaDBZeVhFV05BQ3lCcmFpcEs3R1BWcDlvK3lUQ2s3Mjlp?=
 =?utf-8?B?U3VoNS9CN3luUExzaG9MT09UMWNDdlJDWjJPWDFYZEkySjdvcnFKUDVYZTQv?=
 =?utf-8?B?ZStjdFUxeHM1YXloOFZ6bkNoaVRpeCsvRjJMRlpLSmQzZE1peGdTeWgxcHc5?=
 =?utf-8?B?cHhVcFNGaWlwYXZwWlRKRDE0azRST0hvMm16SHhuRmZBQldIbTlhK1Y1N2JC?=
 =?utf-8?B?aTBNSkZDeFBHZ3ljWm0vdTZtK1cxNkhhaVhnbktvVlc5bFVwYWlIYS84S0F4?=
 =?utf-8?B?b1ZEUGlLY1crcjZQVjhyWFdTN01UazJCa1FCS1pqaEF5YnBiNm1CVUVDSDNS?=
 =?utf-8?B?ZDRtNE16WlJoY0NnK2ZRVW1RdER4dXltUVZzcy9pa2k1OUwvTEZoTEwyVGhu?=
 =?utf-8?B?WEk4ellNNHJrRlpNdlV1ekxFUVFjaXAyck5wRWZkWERaOFppQmFLOXdaSmg5?=
 =?utf-8?B?ckFmWitZUzNsbGNBR091aEphVDNIZWtOYk1zQUlzdzhpK2pHWittL1pyVEV3?=
 =?utf-8?B?VWFjc2ZhaTc4Wk5YQVFtcWdTUXZTTCs1MW1xMDJTWXVZVUFnYWZzaVVhZ0lX?=
 =?utf-8?B?MEFMbzl2aHdjUVdWR1gySVV6ZjFUZ0ZRdGM5N21aMzFTTVFVUWJNUUdQOHN5?=
 =?utf-8?B?MWdlT1hlT2VGQTNvVmJUYm5YaVhqeExlTlFCKzdvVlROVjYvQzhhUllncFVD?=
 =?utf-8?B?bzE0UzZWQzFHMVZTWXhiUlVBYjBZaUlMaWhGVjlXa0FOWnhFYTNjcGU3Z0Y3?=
 =?utf-8?B?YU05NGgzMTZMeVRHWVMySzFhUVpBVXA2UGdaV283a3RhSGowaXJ1Y3RXRFJu?=
 =?utf-8?B?MEl0dkV4RFRqUVlVUldsN3hQdytGZU1veUp2R2JhdEloVTNoS1crWkwyN29S?=
 =?utf-8?Q?wpx/DDNEChiKzrKBYNxWCbM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bcc191-43f1-4ef4-76d1-08dd1eaaf0f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:56:09.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3hCa4rc1JqKTUJXLYO7i9E1Z0W+JxJk7JP+Okze92U8YwrvhhPa4Bzpd7BuLsK1tyTvRbXs06xjDzMDU4pQXB+d0EtFiDBSHyTM8TdPCdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com

From: Kees Cook <kees@kernel.org>
Date: Mon, 16 Dec 2024 18:59:55 -0800

> This switches to using a manually constructed form of struct tagging
> to avoid issues with C++ being unable to parse tagged structs within
> anonymous unions, even under 'extern "C"':
> 
>   ../linux/include/uapi/linux/pkt_cls.h:25124: error: ‘struct tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,’ invalid; an anonymous union may only have public non-static data members [-fpermissive]

I worked around that like this in the past: [0]
As I'm not sure it would be fine to fix every such occurrence manually
by open-coding.
What do you think?

> 
> To avoid having multiple struct member lists, use a define to declare
> them.
> 
> Reported-by: cferris@google.com
> Closes: https://lore.kernel.org/linux-hardening/Z1HZpe3WE5As8UAz@google.com/
> Fixes: 216203bdc228 ("UAPI: net/sched: Use __struct_group() in flex struct tc_u32_sel")
> Link: https://lore.kernel.org/r/202412120927.943DFEDD@keescook
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: netdev@vger.kernel.org
> ---
>  include/uapi/linux/pkt_cls.h | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 2c32080416b5..02aee6ed6bf0 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -245,20 +245,28 @@ struct tc_u32_key {
>  	int		offmask;
>  };
>  
> +#define tc_u32_sel_hdr_members			\
> +	unsigned char		flags;		\
> +	unsigned char		offshift;	\
> +	unsigned char		nkeys;		\
> +	__be16			offmask;	\
> +	__u16			off;		\
> +	short			offoff;		\
> +	short			hoff;		\
> +	__be32			hmask
> +
> +struct tc_u32_sel_hdr {
> +	tc_u32_sel_hdr_members;
> +};
> +
>  struct tc_u32_sel {
> -	/* New members MUST be added within the __struct_group() macro below. */
> -	__struct_group(tc_u32_sel_hdr, hdr, /* no attrs */,
> -		unsigned char		flags;
> -		unsigned char		offshift;
> -		unsigned char		nkeys;
> -
> -		__be16			offmask;
> -		__u16			off;
> -		short			offoff;
> -
> -		short			hoff;
> -		__be32			hmask;
> -	);
> +	/* Open-coded struct_group() to avoid C++ errors. */
> +	union {
> +		struct tc_u32_sel_hdr hdr;
> +		struct {
> +			tc_u32_sel_hdr_members;
> +		};
> +	};
>  	struct tc_u32_key	keys[];
>  };

[0]
https://github.com/alobakin/linux/commit/2a065c7bae821f5fa85fff6f97fbbd460f4aa0f3

Thanks,
Olek

