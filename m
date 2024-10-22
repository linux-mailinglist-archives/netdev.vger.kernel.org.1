Return-Path: <netdev+bounces-137999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6231B9AB68D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8F5281904
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871781CB30C;
	Tue, 22 Oct 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4HgJjNd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5D1C9DC6;
	Tue, 22 Oct 2024 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624491; cv=fail; b=ec9nA7QlbgppWsvN2UTdo9zFuDcXF/lcz8VzZfUXJ3GB7RrC0Fzb7fAipG4cUJeFbCA6A9kAecnq1wbkK9q6Yr76hlHGCp7vNC2d4Teh03gSYWAVvBE6Wc4yWYDMIcGxYYSWnpat28Qyx3zl0brtqB2SYsgdbXxesiMjYOemqDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624491; c=relaxed/simple;
	bh=jHU3TEQe4hyI9/SfrG7Yc58Q7mvJ5ZV1/rAF7H01nUU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jVfRgWbwdjaom555hxHZbt59meyoevfRf5lqgvIeWxWu4nDgUDttnSghYVXKynZkWlxe3WH+2BuDIzMuDsT0ZuFJBrbfroBOd3zvFTPLL0zRhxgNlfzIW4xvwIyQnY2JxNfn8JNmWBRNR0Vph4CZ7kefbq36nVchAo16JjySjKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4HgJjNd; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729624490; x=1761160490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jHU3TEQe4hyI9/SfrG7Yc58Q7mvJ5ZV1/rAF7H01nUU=;
  b=S4HgJjNdvv7Db0qDmLtV6xKsvxsjWM5Jzn6HAwTElC2aUQ9qu16f61dI
   2CW80iHS3hdmRruL/jbGca4G6Md/cpzvb/YLYXNidzd/F2L+r3Fcxk0xj
   ARzIVLXhxs6dJKxDI98IiuqFyRD/SIp4E/vC5YTNL9+aAqCFXTFuFsyRc
   j6wezeZzJOMkQxMtP6LbAOoLoo6/FUNzmQLIv5ra+6mM5/Cr91lREVTmn
   GJeRCBBpS2O8VibYGssS9gMiBnTwnz6hR1dSpB2E7MWe/Bi+VjRUtE0XY
   4oenIXVGACp+mOkPFa434S4m2a/4upL6mpxkfh2O5Tu1zauAauDXYOO4f
   w==;
X-CSE-ConnectionGUID: wGA4ugO3Rr2JD6yktqYeYg==
X-CSE-MsgGUID: LijVxoMjTAm6qvRls4umCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="33108454"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="33108454"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:14:49 -0700
X-CSE-ConnectionGUID: UAvNOw4CS32xD2Og7fqIoQ==
X-CSE-MsgGUID: /10BiXOTRLqNEnxr9YwhYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="103254773"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 12:14:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 12:14:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 12:14:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 12:14:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuRRT7KkMlh74iEMreqKt9hgH7GBbbnCNQA8Tim2aKQ0bJxuiWjfLUDDz78Gpm9lU1rl0AVvUzRT/Q1rNg/ULMHi6BGJ/iB2L/qQmPw8ABT+dycfGfWPlt1Xj590FhnLx601UmkpudpY6/DO6wPfs8u2GM8xvTQa2dJYQgUGrIc6M4gLf2zxCTUFbdv7FaJmY9FJPcA673lpvjyCTH2dx1SPbC/lrdf6ooPUlbnKMDubzqypHo81WvGAAFoutcpGC7p9aUvUJ5dGK9uWZz8AgWBKOLdOlqSBQ88MMNtE5CesV5BIR1bKPyifrAvnef1co1S8UIo/HsWZ9X/R9yP78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfJMfFNWWh4SwkBpeke68Pb/6UnVDoyv00hFAAb5oDg=;
 b=CEnS20BzrK4H5WZDaK5ZFHKmmjZ2X9/Xl5C5C/46AyLvqBpoi+9eDsUdnvRZ2IinFMt7PvSyFaW11mMMAwGGoho9aXoRZ+jmJ7m0eoKU76UcYn6LlUKkM+CYda/onvcFCjvAZuSIbamvxGfJeAhmxtJrPICwL1RY867uUxCNIWVcnzyj4NbObga7KVdXfLaRVUrLQpQ6acTFxijcRlIXcZoq+qZTV06RDRIbUEeUOF4b3FEmwh32O/xqLpFR6T4/4n0CgjRBiyYk0H31q4xD74zDg+Wwirr7cmokoWR0iMP31YW/ALySJS3XcCczhE6APTRKyo1tRLK4+Hcgl8MV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 19:14:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 19:14:39 +0000
Message-ID: <44d29828-dd4a-468a-a229-fd250fb11081@intel.com>
Date: Tue, 22 Oct 2024 12:14:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] ice: use <linux/packing.h> for Tx and Rx
 queue context data
To: Vladimir Oltean <olteanv@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-5-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-5-d9b1f7500740@intel.com>
 <20241019133908.fy46uasva3tdwtmk@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241019133908.fy46uasva3tdwtmk@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8aaa67-6618-4f80-d412-08dcf2cdc677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzFKSVF3TUhlb0RDZmdLVTZpNlJOQ3hSbVhPeStuWFpVdTVjekVVN1BHUENJ?=
 =?utf-8?B?U1ZRN2tpOVVmZ2t1R0I5VlErd1pzcExKWHREazdSQkZNOEk4TWUraDhvRUds?=
 =?utf-8?B?WUd6NTNraG1Makp5TzhRbnRYR1RNQUpWS2hzaTNlcjgxRWl6aTdxcElQM1FU?=
 =?utf-8?B?M0lka2JGbHArdVZtTXUxUGhSbTRkUHk0aWdLcnhHV0QxdUR4eG02M003WHJv?=
 =?utf-8?B?Ny9XL3FhMTAwN0h1U1F5eDRSeDd6akRaWXV1ZXJraW9KQUpFSDI3L3VDZVN1?=
 =?utf-8?B?QlBOaUd1UTVpU2VVbmdkNHp0SmkrVkhRbFR2VnZ5bkRtMDJBQkZ5Y0RPMlVr?=
 =?utf-8?B?bjFBSDFrNWg3RGJuMTkrZkhKbXU2YVhxMGpHak9oMnpob29yR1o5Z1pwU1ZC?=
 =?utf-8?B?eDdFNTJxWGloRmZDZGl6Z05TSUJnVnFjMjFxdzA3Q0NsQlBOdUV6KzMrZXZR?=
 =?utf-8?B?RFhodGszOU5wUUh5cG41K3phNUd4aG5NcmFEbXNNSnREQnBHMmtVNEp0ZDlq?=
 =?utf-8?B?SlVZUmVienphdVd6cmpmeXUxaDE4R0Nod1NHNXhXbzB1Zmk3TFZsVU5ZUXRn?=
 =?utf-8?B?Mm5VNHl6T2VodngrdGQxZms0SW4xWHB5RTNJTXdma3pGdjhDOThTUGh4TWFX?=
 =?utf-8?B?NUtVejBXVWQwVHFrbnh2VVA5dWwxTTllWDZFM2dtRlJYaFFWK2lEL0RiaFZN?=
 =?utf-8?B?MmRHenBaUTh5dmkveXppQldwcys2K05pcUF1MGZDMXN4UHl4TnN4QzFvcGlQ?=
 =?utf-8?B?R0VaY0MzekxDZzJDRE1BbXhodWppQTZ1VmlOMFVJTjVLSmNYaWR5aUtLeldI?=
 =?utf-8?B?V1IzdVovM1YzWmlSVzZmcnZhdXlGbXpDcFdpMStnaElWWllWUnlHRU9KWm93?=
 =?utf-8?B?YVlaSkVMcms2K3ZTMU1ZVTVhWnN5aldiSkgybDJRYXlsTWtxMExrQ0VPaTZO?=
 =?utf-8?B?RVVUQmtib0djdTByYzNjaDdCMEQ2c0ZPSW1xRjZGUHZLVFk4OU9JVUpRQXBP?=
 =?utf-8?B?eHBGYlVBdHZlWllJVndRTTlMdjBhODlQbFBxeDNkL3VBYTRweEMyZzBwdnhh?=
 =?utf-8?B?NHFmZXBrOVYwNEhVeUl1MWRIQ3pTaVp4SmZabTBOODhPSUlKL1o0QnBINE84?=
 =?utf-8?B?WG9CWUtoOFNwTi9zcEFsN1FRcitDMTd6SkhjdVdzRFVzREJZdEZzVmF2aHc4?=
 =?utf-8?B?ZEhYRmxPZVlYQm5meGlvRG13OWVMS1ZvZ21kaExUQUZNMytxa2t2eUNDVmpY?=
 =?utf-8?B?aXVlK2FrSFJPRWpSbk9nS1dIR3JpR09NZU1EbE4va0l6WSt0bUJxUTFaRVBv?=
 =?utf-8?B?TUFjcXRsalNrdm5wUkd5U0t2TlRQN2IvUFpNSFJrUzVaenNFMXA1MUx5Y3VX?=
 =?utf-8?B?emZZYVdrdi84Rk54dFgwcHdiRFRnT3Zkdno2U0ZjTmswaEtiL1VaM3RzV002?=
 =?utf-8?B?OCsrUW9tbHV1RWxSVWNkUDMvT1ZVdTJJRTNESEI4NVJHZ09wZVRQUkxta2dM?=
 =?utf-8?B?Q1IxK29iT3BMUEVRa2I3NkR4cklEdEJOcDZPY1NaZjdqRVZ6SzZkdTJhbnlz?=
 =?utf-8?B?Znhtd0Q1NzJZcE41TE5tY20xTElCbllPQTFobTRvVm5UUjdzMDNrdmVIMGRy?=
 =?utf-8?B?YStwenpSQ2xGRmJwRHB0dDlLME52aEFxaVBZMVlsbjdTR3ppS2RTVG8yUDJO?=
 =?utf-8?B?YXd2U2tMSFZUdjJUeWFHYWEyTi9lOUtzcUtiRU9rKzN3S3E2S2lVYzNGYkda?=
 =?utf-8?Q?lHxs1XxvSUyO64af1vfRyxU1nPClxkgzCi/zHgG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bllVbkQ3Y203TmJnT20wMWNUNG5tZTV2ZndnK0FLdjhuMmRlam56OVBSWEt1?=
 =?utf-8?B?WWNBN1pKUUFobks2SEJicHpBQTB6WFdmbnREZGhMTWJ1VGxlcG5IdVB3cWxt?=
 =?utf-8?B?UGZqaUhwMEtzYW1RYTdmM0YyNFB1LzhJZC9tQWNic1l3NFY3cEdCa2VTQzZr?=
 =?utf-8?B?MjU1aDVOSVduQWxqWVRpSUlYM3F0M3lqYkFGVHp4NkNIazZyV1NpYWQwWm9i?=
 =?utf-8?B?YWJIc2YwTDNScTd1VWNwUFhxMlM1U08yUVBNL3VsZmYzSkRJTmZzUGhoU1lo?=
 =?utf-8?B?NlJwVkJNQ1o1T3pXNzdmckRyMEEwT1Fnekl5dzJTYzFYMCtwVWVUaWZoTHd4?=
 =?utf-8?B?RDVBVnFLQm9rbFhKU0tMVnA1dHUyY3p1bENPUzA4QlVUT0ExOGxwTWYwUS85?=
 =?utf-8?B?cHBHRXpjdCt6ZzhzS0lCRlZqZDkrajFNd1FrUGhubXNOTEFFTTF6VVBLTzc4?=
 =?utf-8?B?blRScTd4YmNZRDIxMHVEMlprR00yYm5hT2hZYWdTSWs1cDJyb0IwYmpocytQ?=
 =?utf-8?B?eWd2SGs3bklaOEZaSC9sc0dUSHEvTWdVSW5SYXJqczM0R1F4OXh4eC9xZTVv?=
 =?utf-8?B?NXRvcnprUFc5cFRiYWprSEtjVGl0Nks3MkNuZngxUEJGWUQralMvZWt4ZHcv?=
 =?utf-8?B?UXEwQ1I1dk04S0t5S0puRWVtdnFNNWs2YXhic1dzaFgraFpzNE82RExuNldo?=
 =?utf-8?B?R1RvMXpPQTVGVTJGa2dCL3BScCtQQjNCejk0aFFuZThETklsSEMwNDk2SXJT?=
 =?utf-8?B?aHlySUswQ1JTN1MzakFDeVhRci9DT1BmeWtXZi95c1RZK2ZGS0ZQWmZlelpI?=
 =?utf-8?B?eFJUYTJjMXgvRytveHZuaUFSb0ZraDYrRHpnNDF1TXlvZjhVUktjM2FaQkQ3?=
 =?utf-8?B?ZUNwYVBqWld6USt2bTZkbW1Fempxalo5S1ZaS0prY0FBenpiN2o5ZUpsV0xZ?=
 =?utf-8?B?ZjZRMFNXVEFBMEhpT0pYRjk3ZnE3b3ltM1ZwV0lEUnN2cEpodkxCQkxkRVBl?=
 =?utf-8?B?amRzV1ptbTI4bEZBVWJHZXNsTjljeFp5QmlNR3hhTUlCdDc0djE2RkgyenVh?=
 =?utf-8?B?WitxZTNKMkhkR2MxN3E4LzZYUyt0THd0bFFJQjQxZ3h6N1FSYWd2dmd1QXNC?=
 =?utf-8?B?UGlHS1JpWjMrSVBYTVpiT2kyK3I2UUx4UlRuR3lmN1FHUWRvSmViV2VVQ3o1?=
 =?utf-8?B?VlhWWW4rWXVUQ1VnaURDK25KVjNIYWVqdnZDMkhZNFc4L0t2R20rYzRxMEoz?=
 =?utf-8?B?Vms3RDFoYWFTMHBJMEZlQitFaGVPbC9mMUU4SkhyQndDbWFLTUxOYTNOdFNK?=
 =?utf-8?B?cVZxM0dkY09USU9CRHdmM0NJM1l5TUZDZkZZWG5Kc2dvWi9NRVl6NFJBZVgz?=
 =?utf-8?B?QisyV1VBUTdXcXVLeWRKR0F3QzlhOHhUcHZ0c2QrdUZKTEl2cWxhVVp1ZDIz?=
 =?utf-8?B?U1crOU1nM1dZTHB3VVVZcEovUmtIbWtyNFN2bUxJREZMenZhTFJ2bTJjaS9q?=
 =?utf-8?B?amNMZTlUa1kzbDRnNmlQcEMvNXl5dnJrbHBiN1M3YlduOGdWd3FVMXM2Rldj?=
 =?utf-8?B?YVpPUTkxbTI3WjJPQmNYWVh4bHRpRm0vejFFa2FDMitUQjlDSWE1aHZIcENm?=
 =?utf-8?B?Q3ZZS3gyRjk1c2cwU0xIcW8rTmdYWldWcVVtdHZnSFNFaFpHVkIvb2NYaFl3?=
 =?utf-8?B?eHJzOXk0ZkF0b3JOSll5N2NwNDBLVVdubHpxMGZnMXJlZjF6UXFzNmQ4SzZm?=
 =?utf-8?B?aUxqdUJSdXorYms2cVBWUlVsY29ISDNrKzlRUDRYWEorUGVsckxxNjRQSDhI?=
 =?utf-8?B?OTJsOXRZS2FadWFxTkVZRFd5N1lIb01VOVZkTHZaREhjUDlHRWoyN0QwOVlK?=
 =?utf-8?B?ZWNpTzFGdWlGaUJna0x3L3ZXdWFPZmN0aDI4Q1pQeGxzdjFHaTM0MCtLR29X?=
 =?utf-8?B?V1RzcTBjejU4M1hVYTh4aEtVUngyMHo1TlEwYUVockhlZjlPVDRsNHRlQVJB?=
 =?utf-8?B?eDRDQ25yVjN2ZGtBNitGaXdneHEwNGZSSllwNkhoajlLclo5TDFrQ21VM09D?=
 =?utf-8?B?TmxZS3AwSVJRak15VTdzazRiYlJWb0RxaTY4NWJhc2laTUlKMUVlZ1FiV3Vi?=
 =?utf-8?Q?VBdb560adjH8E0Vkl967+HeQe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8aaa67-6618-4f80-d412-08dcf2cdc677
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:14:39.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMzYzSE5VVgT6xijCIjYqXJIGOuN759csTBz+9jQezncKiz3s4FuO11bjB+0s3U9hyDMey2VLhaKb1KskSYok+zcDuHbgrifQHap+g2gXpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com



On 10/19/2024 6:39 AM, Vladimir Oltean wrote:
> In fact, I don't know why you don't write the code in a way in which the
> _compiler_ will error out if you mess up something in the way that the
> arguments are passed, rather than introduce code that warns at runtime?
> 
> Something like this:


This is definitely better, thanks!

> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 1f01f3501d6b..a0ec9c97c2d7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -12,6 +12,13 @@
>  #define ICE_AQC_TOPO_MAX_LEVEL_NUM	0x9
>  #define ICE_AQ_SET_MAC_FRAME_SIZE_MAX	9728
>  
> +#define ICE_RXQ_CTX_SIZE_DWORDS		8
> +#define ICE_RXQ_CTX_SZ			(ICE_RXQ_CTX_SIZE_DWORDS * sizeof(u32))
> +#define ICE_TXQ_CTX_SZ			22
> +
> +typedef struct __packed { u8 buf[ICE_RXQ_CTX_SZ]; } ice_rxq_ctx_buf_t;
> +typedef struct __packed { u8 buf[ICE_TXQ_CTX_SZ]; } ice_txq_ctx_buf_t;
> +
>  struct ice_aqc_generic {
>  	__le32 param0;
>  	__le32 param1;
> @@ -2067,10 +2074,10 @@ struct ice_aqc_add_txqs_perq {
>  	__le16 txq_id;
>  	u8 rsvd[2];
>  	__le32 q_teid;
> -	u8 txq_ctx[22];
> +	ice_txq_ctx_buf_t txq_ctx;
>  	u8 rsvd2[2];
>  	struct ice_aqc_txsched_elem info;
> -};
> +} __packed;
>  
>  /* The format of the command buffer for Add Tx LAN Queues (0x0C30)
>   * is an array of the following structs. Please note that the length of
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index c9b2170a3f5c..f1fbba19e4e4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -912,7 +912,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
>  	ice_setup_tx_ctx(ring, &tlan_ctx, pf_q);
>  	/* copy context contents into the qg_buf */
>  	qg_buf->txqs[0].txq_id = cpu_to_le16(pf_q);
> -	ice_pack_txq_ctx(&tlan_ctx, qg_buf->txqs[0].txq_ctx);
> +	ice_pack_txq_ctx(&tlan_ctx, &qg_buf->txqs[0].txq_ctx);
>  
>  	/* init queue specific tail reg. It is referred as
>  	 * transmit comm scheduler queue doorbell.
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index e974290f1801..57a4142a9396 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1363,12 +1363,13 @@ int ice_reset(struct ice_hw *hw, enum ice_reset_req req)
>   * @rxq_ctx: pointer to the packed Rx queue context
>   * @rxq_index: the index of the Rx queue
>   */
> -static void ice_copy_rxq_ctx_to_hw(struct ice_hw *hw, u8 *rxq_ctx,
> +static void ice_copy_rxq_ctx_to_hw(struct ice_hw *hw,
> +				   const ice_rxq_ctx_buf_t *rxq_ctx,
>  				   u32 rxq_index)
>  {
>  	/* Copy each dword separately to HW */
>  	for (int i = 0; i < ICE_RXQ_CTX_SIZE_DWORDS; i++) {
> -		u32 ctx = ((u32 *)rxq_ctx)[i];
> +		u32 ctx = ((const u32 *)rxq_ctx)[i];
>  
>  		wr32(hw, QRX_CONTEXT(i, rxq_index), ctx);
>  
> @@ -1405,20 +1406,20 @@ static const struct packed_field_s ice_rlan_ctx_fields[] = {
>  };
>  
>  /**
> - * __ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
> + * ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
>   * @ctx: the Rx queue context to pack
>   * @buf: the HW buffer to pack into
> - * @len: size of the HW buffer
>   *
>   * Pack the Rx queue context from the CPU-friendly unpacked buffer into its
>   * bit-packed HW layout.
>   */
> -void __ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx, void *buf, size_t len)
> +static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
> +			     ice_rxq_ctx_buf_t *buf)
>  {
>  	CHECK_PACKED_FIELDS_20(ice_rlan_ctx_fields, ICE_RXQ_CTX_SZ);
> -	WARN_ON_ONCE(len < ICE_RXQ_CTX_SZ);
> +	BUILD_BUG_ON(sizeof(*buf) != ICE_RXQ_CTX_SZ);
>  
> -	pack_fields(buf, len, ctx, ice_rlan_ctx_fields,
> +	pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
>  		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
>  }
>  
> @@ -1436,14 +1437,13 @@ void __ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx, void *buf, size_t len)
>  int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
>  		      u32 rxq_index)
>  {
> -	u8 ctx_buf[ICE_RXQ_CTX_SZ] = {};
> +	ice_rxq_ctx_buf_t buf = {};
>  
>  	if (rxq_index > QRX_CTRL_MAX_INDEX)
>  		return -EINVAL;
>  
> -	ice_pack_rxq_ctx(rlan_ctx, ctx_buf);
> -
> -	ice_copy_rxq_ctx_to_hw(hw, ctx_buf, rxq_index);
> +	ice_pack_rxq_ctx(rlan_ctx, &buf);
> +	ice_copy_rxq_ctx_to_hw(hw, &buf, rxq_index);
>  
>  	return 0;
>  }
> @@ -1481,20 +1481,19 @@ static const struct packed_field_s ice_tlan_ctx_fields[] = {
>  };
>  
>  /**
> - * __ice_pack_txq_ctx - Pack Tx queue context into a HW buffer
> + * ice_pack_txq_ctx - Pack Tx queue context into a HW buffer
>   * @ctx: the Tx queue context to pack
>   * @buf: the HW buffer to pack into
> - * @len: size of the HW buffer
>   *
>   * Pack the Tx queue context from the CPU-friendly unpacked buffer into its
>   * bit-packed HW layout.
>   */
> -void __ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, void *buf, size_t len)
> +void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf)
>  {
>  	CHECK_PACKED_FIELDS_27(ice_tlan_ctx_fields, ICE_TXQ_CTX_SZ);
> -	WARN_ON_ONCE(len < ICE_TXQ_CTX_SZ);
> +	BUILD_BUG_ON(sizeof(*buf) != ICE_TXQ_CTX_SZ);
>  
> -	pack_fields(buf, len, ctx, ice_tlan_ctx_fields,
> +	pack_fields(buf, sizeof(*buf), ctx, ice_tlan_ctx_fields,
>  		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
>  }
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
> index 88d1cebcb3dc..a68bea3934e3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.h
> +++ b/drivers/net/ethernet/intel/ice/ice_common.h
> @@ -93,14 +93,7 @@ bool ice_check_sq_alive(struct ice_hw *hw, struct ice_ctl_q_info *cq);
>  int ice_aq_q_shutdown(struct ice_hw *hw, bool unloading);
>  void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode);
>  
> -void __ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx, void *buf, size_t len);
> -void __ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, void *buf, size_t len);
> -
> -#define ice_pack_rxq_ctx(rlan_ctx, buf) \
> -	__ice_pack_rxq_ctx((rlan_ctx), (buf), sizeof(buf))
> -
> -#define ice_pack_txq_ctx(tlan_ctx, buf) \
> -	__ice_pack_txq_ctx((tlan_ctx), (buf), sizeof(buf))
> +void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf);
>  
>  extern struct mutex ice_global_cfg_lock_sw;
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> index 618cc39bd397..1479b45738af 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> @@ -371,8 +371,6 @@ enum ice_rx_flex_desc_status_error_1_bits {
>  	ICE_RX_FLEX_DESC_STATUS1_LAST /* this entry must be last!!! */
>  };
>  
> -#define ICE_RXQ_CTX_SIZE_DWORDS		8
> -#define ICE_RXQ_CTX_SZ			(ICE_RXQ_CTX_SIZE_DWORDS * sizeof(u32))
>  #define ICE_TX_CMPLTNQ_CTX_SIZE_DWORDS	22
>  #define ICE_TX_DRBELL_Q_CTX_SIZE_DWORDS	5
>  #define GLTCLAN_CQ_CNTX(i, CQ)		(GLTCLAN_CQ_CNTX0(CQ) + ((i) * 0x0800))
> @@ -531,8 +529,6 @@ enum ice_tx_ctx_desc_eipt_offload {
>  #define ICE_LAN_TXQ_MAX_QGRPS	127
>  #define ICE_LAN_TXQ_MAX_QDIS	1023
>  
> -#define ICE_TXQ_CTX_SZ		22
> -
>  /* Tx queue context data */
>  struct ice_tlan_ctx {
>  #define ICE_TLAN_CTX_BASE_S	7


