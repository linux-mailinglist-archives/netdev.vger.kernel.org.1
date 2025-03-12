Return-Path: <netdev+bounces-174426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC4A5E8A4
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 00:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDEB188C5D0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E2E1EEA30;
	Wed, 12 Mar 2025 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TH47BcSP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AB1E98EC;
	Wed, 12 Mar 2025 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823262; cv=fail; b=giX4uvAUg+gA7nZFWFxPbPVznekrOnfPttbuaGQuDkwSWim7ZDqOhTXfWeql7hAGUzcup44eKg4HviK70TjwEy47tOboabPZqk1YDRYValwaoKLI2Yyp2tlod0nqyQ00D+q61eSrpwqPNIMyqEaFwy3yrYjnKUlrTzjdrLLP5pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823262; c=relaxed/simple;
	bh=PKwu3g0UBRUQkq3S//RRTbdIjv2WVC8VTXpWVbz3L/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X9WlnmmDJFym9uIgQkZ4BIcfwfO/m6vXHAdmnXmryxuCQ1piJ49hNFK+Ybv+npQGuhw4FmDma+a+BA0A6vS/+E6bz+Ama8Lronf3eXPu3XaQPVDqr3Sds8srTG3unmiYT2JG/r5jb62w5Jgn/QGEVaS9ikFCwc8pWdibc/YB6Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TH47BcSP; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741823261; x=1773359261;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PKwu3g0UBRUQkq3S//RRTbdIjv2WVC8VTXpWVbz3L/g=;
  b=TH47BcSPWohDr2+RquNzR1UCiL3qTzcTuVfmTXMfJNshGx5zkQvsIJOq
   yG4Vk2bP+HkrynBdEesH28nroYhmMIN/7aJc2i5+uJMwIjB6mu7qfwADM
   D9E/kV67qDD5ua1fHxrtinBeI7p+TcoDTnwQwQZyCYz3XjK4NXtBBWSPq
   8UukhOzk1/NNs/e4OMa3JaXY37o+0mMleb25rYzv7uLNUFduhBhhMf3+4
   sXDBaoz5chQ9VmlMnLc2fWNAD8OOqMoVMOXZKmHfxa4qLvNlz28o3ahAP
   wNHh5drqaBpGDXqIa37lL2bp2jiKyHGuoh5/aRr4aTg0e91W7zM15U+yC
   Q==;
X-CSE-ConnectionGUID: WYzZ0jWsRDihHimYJTCp7A==
X-CSE-MsgGUID: nD7+oAFUSxy2giEhpgsqug==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42801817"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="42801817"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:47:40 -0700
X-CSE-ConnectionGUID: ojUOqlw4TF2HDIw+0k8nVw==
X-CSE-MsgGUID: IDKeE3poRSOmCWxvE1fmSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="157950180"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:47:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 16:47:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 16:47:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 16:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4GKuVAt+OgyaeX5JWu/59ga8CfAKU+DNkD6LXBpPePEOeQ+q9+mY2gxRRvAIo48w+KPsc5x/pHQBokKD0KTKHhl+DVtMqYppiXomZp7RM/lJYBN91yVI4Pl9V+S3wHENa8JjUAn2t1al1zvzBbo6EwGIDFMxb1hO3ql+vGL/yC3BBJuwdsAgCVFuVDdCgGwlE8D0y4DRA3KdxAr/yAhIQ2XPYAw/YMf/9UtvYFiITEkMu6DI40yEhDFQNaVJsFm7Lz0LwtrHgw8v9Y4KqclnibiX3RiBavaWg0oFYMKDeR36CoyHKTIjVA1bDfGJiEPvWc2HCngFjwNRswQcfrNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxbXfhIMJ2MlZBIGTU+5hYU/fMwoLKaQPE6bJuiWNTE=;
 b=iW8j0hAeyMk9ixBx/KDhXU4F0O9xrpTorL8unCgdYFJpnqOGdIDyVZdPFJZuek8J+7v16Ek8gHRIpGp5e9qMEB5iyqEVj6zeVdTTuhjfTm/gBdYYivO686drfpVN8DcPjeAapOMoEtZtS+TtX8jLvitM5kHiFlhUZwJXEqwhlkvKS0JXXVzC5Vn9xs1Rh2MDCMjJNhZnhNP/12JG2/sXTm5tXRvlDJccDgQ9cHfG/NCm7gRyi8lhy6DDGDqUj+Ydet2u/EZelK9xa0TyKFps4sBoYq5PrT8mVGDHLqHQ7n8LFfJSAt6BDiTyDS3l0Q82/2ny0Nf/66BA5bViQzGOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:47:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:47:36 +0000
Message-ID: <468cfeef-3562-4b04-a2c1-e4000472dc85@intel.com>
Date: Wed, 12 Mar 2025 16:47:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac-rk: Provide FIFO
 sizes for DWMAC 1000
To: Chen-Yu Tsai <wens@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Heiko
 Stuebner" <heiko@sntech.de>
CC: Chen-Yu Tsai <wens@csie.org>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-rockchip@lists.infradead.org>
References: <20250312163426.2178314-1-wens@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250312163426.2178314-1-wens@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:302:1::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa276ca-6acf-499f-70d3-08dd61c0441b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REN2bDhrdk9HY2lnZUt5WUpkaEEyZ3ZvdWxBalpjYTVYblB0K0dGeDU0WlFw?=
 =?utf-8?B?aEdwb29mc2Jvck9ocUluKzdnM2dEU0tBOGVCMmt4MUxmbCtNSk1PaWdJd3dH?=
 =?utf-8?B?SDVLZ2xnUlVsazBGNUFwMTFhL0ExNUFjR1JuTXFNcStkTERpTHZPS3FiV0Zq?=
 =?utf-8?B?ZGM5OEp6WGJOLzhEWXVzYjZROEJoMDYxVEZHL2JVakVVYUE1dXhWUUM3S09a?=
 =?utf-8?B?OUtDRGh5cU5POEZhZWxyL0lSdWN3TlZORjRSMHRmQ3pRSlVzZGd1V21xT1BP?=
 =?utf-8?B?UWpaaFJEN3c1ZjVtZnpNNStqZGpZU0hNOHVqMkhJbjdqdXY3cm9FaGo1TUpw?=
 =?utf-8?B?WnB2QUo2VHdpT05qc1Y0Tm1sMzZkZ2QvMktqaFdWZFFqQSs1QmJsKzVBSTBi?=
 =?utf-8?B?OVlXOXZNSkhnb1YvdWlIUFJiek52Vm1MMWd3SzBNNFUwVWN6SXZrWjdSM0c4?=
 =?utf-8?B?Znl3Tys0dXdBbTBScUpBTTVzc1pGWmFVYW92VERRVGFaRHVmaHhuS3lhM1Fh?=
 =?utf-8?B?am5xVXVSam5UMGNtQ0llemZVcmtmNUU5bGFzZEdyMm55cmc1TFZXWUgzSGhL?=
 =?utf-8?B?S3h2YTNCeUhhTUdqT0RIc1RGbmt4YjM0enNjdG53NHZKRE9tN01MSFNmNlB3?=
 =?utf-8?B?cTF4NzFoQ3k1VG9kNlhEQldnWWhzUXp6SnpHVUY5ZklhQjlyZG5INW5vU3Ft?=
 =?utf-8?B?QVFCdmZVNEZ5Mk1ldmpoaUlJUHNaWTZ5Ykg4YlowRW1uVG5lSHdUOXJoc1RJ?=
 =?utf-8?B?b0tYZ2swbFozTFlxSDRxdnF3VUxrdyt6SDU5TlZTMDlKMW4ySDF2OVJPajRt?=
 =?utf-8?B?WXVEZk0zOUVlQUlQSDQxZmdhaGtGQ09MbndnWTVtamJPYVJYMVRoc1NPOEJ0?=
 =?utf-8?B?eStldlVGQU14NllSaGhLZmtEZDFydTZtMWhOaEF3cjhtakNoREk0c3F5NG9a?=
 =?utf-8?B?ME0xRlgzU244TE43OVlTYmViU0pJRDRmVlVvOGVQYUpLK3Uxbm1XWDhjYTFu?=
 =?utf-8?B?eVlXVG8vamRPT2kvU2FIbUl6VnQ1NVJDZE5KTE1JcXFabU1Fd3lrR2pSUHdj?=
 =?utf-8?B?MzdLNEtsdkEwTkFMS0llYlZYVXpJNU5tb2g4elFtdHB2U1NjcnptTG5xYk1P?=
 =?utf-8?B?NzdSY3ByaUlOWVVTSldjVmRPL3p0VHA4MEVxdHFvdDNKTFRJWFNjYkhvYlZE?=
 =?utf-8?B?d3pCTjFMSDd6N3RoNHJZQ2xGYWZ1YlgrVVpORDVBL1hFd3Z3NDg3SVFOR1Ez?=
 =?utf-8?B?R1NNWkhnVndTMEhHZ0ZRU2FNdGJwMVlHYmM1NWIxTVRWbXQrNkl6YnppekVE?=
 =?utf-8?B?VEt2TlE4Y3l6dWp0Sm4wVGl1V01nNEV5TGlSd3BSNDFKODR2Ky96NW9MSWhv?=
 =?utf-8?B?aStYUEJyNFRjeW1seWdWTFZ2NlZuVHNWQnFMY1ZxUGdxVE85NEwzdXhZYm03?=
 =?utf-8?B?blQ3WTNRQkkrWHhhdTlPUEdSb1F3c1JZa3hkN2NlNDBZb1ltRURZYjk4VUQy?=
 =?utf-8?B?THBQcEx0bEhMdVV3QlRveEVjRVIvaEhxL200VlUrYXNQNnh3c3ZmTjkvWHZu?=
 =?utf-8?B?eVBkUm04RmdBakZqMmQyMGpNa0JteDlEMHpsaWdnV1FRSkJFU21lTlhrNFNK?=
 =?utf-8?B?YklEa3l1NHFlODc0cFdQdnBVRDR2eGtJNGJxVng0NlpTRjNYNDIrUDVkUjhl?=
 =?utf-8?B?Wmh3Wml1cmxYbzc2NUN3Mk9DN2ZXdDRxeTF6azkxRXdXMEJvdmlMSXZWWlpX?=
 =?utf-8?B?bUpNOHloeVhzRjRVc0cwdm52NHRKUk9YUDFHeFZ4RmFWRjJ0SUxjaTRtenMy?=
 =?utf-8?B?M29IQmRRU1NPbk44RWVCWkVYM2hEcGtONEdhWlp5TmRrb3doS1M2cXJXNEpG?=
 =?utf-8?Q?ORV5jNglR007F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTVhUmt3M3Q2dHFoNkRSRy9ud2gyVWpEN1pHWmxod3N3T01tT3pOaWpZd3d6?=
 =?utf-8?B?Rzk5dlhCK2JNZWd4WllCR1hkUDdieC9JTUZocW4xN1VFcTNSUEYxV2Y1Q2t3?=
 =?utf-8?B?RWtraVBLWENlMzZqd2YzYWQzVkNMS09IUis3UnROSTVlelRGSjVNSWU5SlFu?=
 =?utf-8?B?aitCTG9SUmFuZC94T0wvQW03dzBvNUhvU0hkTDhlUEpPemJsNEJQOFhFdXJv?=
 =?utf-8?B?MCtJbG9vR0RXbjM1QitjbHMzci91bUdFbVdsTURRc2pJZHI5UisvVi9lN1Qz?=
 =?utf-8?B?RGFsTnNlSlRkakp6VDNFd3dkL25GNXNHSlYySWpWMWZYVFhDcVJLTzNXUE5S?=
 =?utf-8?B?VW4vRVpPUk92end4MGZJSXNyQUJsa2FibHE2YU95eER0MWEvYU9SN1NjYnVU?=
 =?utf-8?B?dDkweEFIcml5K2FpK2VSNG9XT01pM3FFNnZUZ25GNHQvUU1Ncm5pZnhTVEZk?=
 =?utf-8?B?QWFIaU4yc05GUXk3aFZFcmkxNkxzZ1AxeGFLQnVZUE5VeGxPSjM1VHdPWm1D?=
 =?utf-8?B?THJtMjRnS3RkcENBOGI0bzZjT3J1Y1FGZ2luREVHOVFXRlcza2NRMmY0Z3Jk?=
 =?utf-8?B?c2JPUUFYMmV0OFlVTmZTeGxLMGozVzhUMkVXQkZHTnJ1MXRXeDUxamNJTGxy?=
 =?utf-8?B?NUtkWDNsQUF0TURMeFVqVkVpRUFya21JZWFGMzJYcTgzbVQrZ3loRVl4cnVt?=
 =?utf-8?B?Y0QxNHNqbU5yb3NZYUpkTE5MYTRETW1JaFg4amJzWmRHM2RLYXgzc0JycGNS?=
 =?utf-8?B?eTdadERHWCtTa3JON2RQSjdmVnVqc1Bqa3lvK3lQOW1hUDROUlBHZ3FELzRD?=
 =?utf-8?B?MkJTRzF3bWVzV1JTejlZNjRMQlJaa1d5TFZYZTVFeXllSVVvQytieU55WFdl?=
 =?utf-8?B?Qmd5Z0VQYzU1azVVSlQ4MU5aYTJPWmFNWWcvdnB5OG9zUXpoM0huQzdDRDlk?=
 =?utf-8?B?di9ldFVjbW9rc1l1bGFZUnloSDdCMXVYRXNXOUVaZG5EeWNIemdCSWcvR0Er?=
 =?utf-8?B?TDZFSTdhSHlUc2k1SzJvSWhuV2lnNFZZeUY2T0NLRG51RDZTUlRibXJHbTBX?=
 =?utf-8?B?UlFGMjUzazZBeEh0Rm5EeHAvZEZaWlc0MFpjQ0w4ZVhTSHNKaUMrQ2lycFdk?=
 =?utf-8?B?SG92bm1oM3JITmtXTE9IMnE2RWpUZEhFc0VXWFc3RHFDOXBCTmV2RDhtNWtn?=
 =?utf-8?B?QzYrRGl5K2Y1SjlHc2FSSDBkQnkrR0xYOHd4TVg1Z0Y4WktsTlNSbU9NWlJ6?=
 =?utf-8?B?V2ovVTNncTF5Q29BL3h2bmJaTi80dnNjVDUrZGpDSWNNemRYS2RCdnB0aDBq?=
 =?utf-8?B?d0NNcEZuRHhGNi9wSkVKUzZyanVNbzNVN0VDZFJWaStlY201RWVMS2lQLy9L?=
 =?utf-8?B?SFkxSTNXU3pKUnhiMHZyTnNob25HNGZ6cUF4WGIxN1pGaXc0NVNnZ3RtbHhT?=
 =?utf-8?B?TUZrYTRHaUNYMzFTb3JvQXREdTVxeDN3aEVGZFZrZklSMU15WDJ6MFJBM0tP?=
 =?utf-8?B?ejFid29RSm5QQi9xSGk4Z09uWnBCVmd1WW9qOGtVa0h6cWRtY2tldzF2MmxL?=
 =?utf-8?B?SFREeHFtUWNsQ1hObjMwNVdmejEvdjlYVUFsWWVKS3p5QndrczdzOUdTM3BI?=
 =?utf-8?B?N0E3VVUvd0NnWThQNTFBR3lPLzJZUUE1VEVBWWdxTGFTRHNsUFpBYWdoS2dy?=
 =?utf-8?B?TEJyRUNObituMzVseDVWTC8yNjQxOHV3R0l3aDBDdFFGcjBNQmZxaXFFSk95?=
 =?utf-8?B?R0N0bVdiZXV2VUtXYzBZT3ZqcWNkMW92SFladnlDdUVIMUxydFg2aHFnc2x2?=
 =?utf-8?B?dUovQzZGc1RhK1IvZEJvcW04Nm1rQmtXN21sZmZZZlpVN3JiUHpWNjh0ekNU?=
 =?utf-8?B?MjdCWko3Yndqa1hxMnZUb2pQZGI1VWdxWHIrMDZEaDFLcml4NHZWZk9OMEo5?=
 =?utf-8?B?N1BUTHNBc0hyMUxsVjZKL2FRNmJVNnU3ZUduOWYwYVRibk5KVEw3TFhrQlhR?=
 =?utf-8?B?Yk95Uy9YZTdjMVBsVUdBbXlxWGN5SUNGZnlpOVlvcWExcmNQdzlJUXpGclVF?=
 =?utf-8?B?VFdkTklnZmJ3V3FIRTBqQytSM3NCZHRjMGN1aXppK2RxMUFwSDRGWEVxUjBF?=
 =?utf-8?B?Y2s1N1dlNEFWTkxydllXbmU0RE5NWlZqQW1ydG9ITnQ2STAwb0tSQ0NNQ2Qw?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa276ca-6acf-499f-70d3-08dd61c0441b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 23:47:36.1947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fkgpzBGsfbu2bNptAk7rAy6udlgCHv6xNnH/HBMJdiRnKPkp4++AbXSs+K5nGRXW10rJ4Ch6byefALXh/QgZIZqcPbha1jvcUo/bMrYCcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com



On 3/12/2025 9:34 AM, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The DWMAC 1000 DMA capabilities register does not provide actual
> FIFO sizes, nor does the driver really care. If they are not
> provided via some other means, the driver will work fine, only
> disallowing changing the MTU setting.
> 
> Provide the FIFO sizes through the driver's platform data to enable
> MTU changes. The FIFO sizes are confirmed to be the same across RK3288,
> RK3328, RK3399 and PX30, based on their respective manuals. It is
> likely that Rockchip synthesized their DWMAC 1000 with the same
> parameters on all their chips that have it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

