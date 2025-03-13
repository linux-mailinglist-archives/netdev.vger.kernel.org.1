Return-Path: <netdev+bounces-174780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5749A604D1
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A6617E142
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75A1F585F;
	Thu, 13 Mar 2025 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVIr6nm+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB81F5608
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906445; cv=fail; b=vEp1k27CQ+LggC1UyfTcnyPMQZktq3cexKWrhwJNo7NZ7rSa4BCxJGx5a2ybm94vEvJBLdP6xoZCzIZkn9LXFbJWwV84/lnp2fnnr7TJGMwGPrjBYzqWWS1/PVb6ZZlSKGwAnreDxfaodcbqqnADQGjusW/moyDYcxpQVLH6BkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906445; c=relaxed/simple;
	bh=6R9FDIHfx0+pIol/xWIb8sJBrboVkbBzh7ACnUwm0O0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h9K/21HUT+2DQio16QTHwD5Qt3qfcS7YaEHIrejutT9cg+gOS2uPysvgdklrksiaIhm4J8cpMXDdFSF5f6XdzvOuoI2Gr+QwgaA+QjtOx/F4QwuGQOB0cksIv3Fy/j4RdTq1kRhypeHxG3nA90ex8AWObaU4CanGihPA5etL1P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVIr6nm+; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741906444; x=1773442444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6R9FDIHfx0+pIol/xWIb8sJBrboVkbBzh7ACnUwm0O0=;
  b=lVIr6nm+B3sUPxOziWD2jewI7Tml1DDs5Cxf9SeZu8z9bC5Rc53oQ9xU
   P/UR7rkltioPpWh4Co1pf7ePXdhnYKSEnNYr6RozOF8PkTpu6riOO4rwr
   sRwVGBLCQtSMBOx1hpKiPC65+MgS8Sc8eH9yxFyBctnUMuuVduf5KWgZ8
   BT7xYgA9hViZoklqmap/vWIrHp0eKtYb0So+Pw2/Sx6DYbPFJOQO451Hj
   HicPiUy8L1/8tzzc/qgOfHE7yJYoVHXBGpuWqCtcHmMuQ9HMs/qo6JbXU
   i1EW/HhvMgEqTMMisQ5h3hCLAUse+q/ZRZHufpQWme1NMy3/xp5k1n2sf
   w==;
X-CSE-ConnectionGUID: JwJGmfLOQUmjKvIn8CSJAA==
X-CSE-MsgGUID: 0YJyN0IaQXCuR/kNXFOVuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46837766"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="46837766"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:54:03 -0700
X-CSE-ConnectionGUID: mj7PwBhaSSy0Nkk2r3kx9g==
X-CSE-MsgGUID: MMe1Asj1TqiHaMZ4/2tZmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="144294078"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:54:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 15:54:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 15:54:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 15:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxq7BbDfrkwv4PeaRsoja3krSflTdlVYz6kpN0ZPEciNI1gs3J7cT8SGd9Q3pDTMTM2DLg2OpLqgNQLS8dhY4LNYfVd4QK0tCAeuYldov7gX+KZ08nIgkfDO8MGOe3ZJIC9COyXP+2pCsN79zD8GfofYGAPp4mf2oebvcSgd+TypbZQlpkiMxf4u+dwptW1JH638jyj8nLYDm1z/QRrvNqDx5+HYMsCPnOhj1Yj7yxTKJBA4WpgbuNFjRko3d+gh9NIWVNpo7X5Wh1nVJWCivg58O4QstY2q+J13HLAMHbaDctQfna7bWWLu42N5Uk5z0Z0FrgeVIqaie4lGgQG1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSBuzxTx6owA9xmNcdlTjnEiBOct55U0eFj73zMq4ig=;
 b=fs4UBul061vzShzyhT+XP5wzVbt2D0qLxg6pALmiTNct2x32CnhfBPk65Mkag5+OFUE3BFmRzy4zsDCK+aUKmr5nq0VFHUsTyCy2Nsc6fdBjbMlH5kWGj+/3k+p7nePB4QMU2B5ZoIs0p2f0/6dda0hU9/9ATvVn+DN4yb1wQRfJnIo6goDFd6Mq9ESaA304FdpUcVPRhzDALadhK9uE3KBkKvzIBq+TAhYOh8LlDsTmeKDoOeV4QgYnfO8//TANjQISNy6s5hRVxQoWXQuLVSenDNz5fgS2nUlgVzd3msP0KueLVxT+oKpgkCsZMJTKqZVR4Q5F7g6X1nP7pVIVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 22:53:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 22:53:25 +0000
Message-ID: <a4210935-7dc3-42fd-b8bd-68ea8151058e@intel.com>
Date: Thu, 13 Mar 2025 15:53:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/4] inet: frags: save a pair of atomic
 operations in reassembly
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20250312082250.1803501-1-edumazet@google.com>
 <20250312082250.1803501-5-edumazet@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250312082250.1803501-5-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0338.namprd04.prod.outlook.com
 (2603:10b6:303:8a::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6c0b76-886e-45a9-92f7-08dd6281dce0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L094dnV5TGxFdHg3SXc3R1VXL2JjSTRWSVJObHBPVVNPRmh1YXRmRHJsY2cv?=
 =?utf-8?B?NlY1cHFLNWFLdjRSN05pYm1sMXJSWml2bHRFQkMyL1daZ1p4VWx3TnpMZlZI?=
 =?utf-8?B?cXFjT09hSEd0anFGRGF6ZUhXcGlHRTJUQzU2RnhyYzhGdHIxNVdtT1RJUWlI?=
 =?utf-8?B?U3hjcUoyNFlEcDJYSnlpN3JabUNLbnB0cUd1SG9CVExmU29OVEM3YnpWYitB?=
 =?utf-8?B?dUgxRFBGTUtKeitYVy9iQkJaZDlQTVZXQ2pxbnpsWCtjN3hlSlNSY0hJRFVV?=
 =?utf-8?B?YUlzTXlYbStGQm1xVXZXcnQvS052T2xscTNqWlRGNE9haHkzS01ZRzlqVlFU?=
 =?utf-8?B?MTR3L3MzTnVDdGxpQm16dFpqMkJ6R0RFMURSc1crQmxlS2NYdmZBTFZweGlM?=
 =?utf-8?B?UXViYW5GbGREaWpPVm1ORU9aT2lQMlpQcDNLM0V1MXZJaER6bHgzMkg3NXUz?=
 =?utf-8?B?UnRNd3FHM0x2Z0lUVFRsd25MZ3NQb0Z0bVhhT1JJblFTT01CUjFLVzNTcGtM?=
 =?utf-8?B?eUVacnNUeXZ3aThzTVFZMURiNDVoVlN2cHNhUnJKNGx6dnpNb2EvVzlVRkdo?=
 =?utf-8?B?S0JZK1Z0WS9FRmI0bCtXNWJyRjdXSmhrYk1sUXBMcStLSmIwNmxIczBjZ2Fx?=
 =?utf-8?B?Q2tSVGtrcTY2RjVhSjBYQ1NLSHNoanp6U0gyQllrbFliU2NSNjk5aEFPOWR3?=
 =?utf-8?B?NGl4QVREV1d1WDh3bmVjdmxrQ1VwdkhnK01jQldJVDA2S1NoRnljV1pmWEpo?=
 =?utf-8?B?SkdCNzJ5dW9RcVluSnpINTE2bW1DQ2dBNmVZY051SytRa1huWVpGUXZlRVM0?=
 =?utf-8?B?U1NWMmlKMENNU3FKaXlxWWx0SkU0d1dmNlVBRUFpK0pTcHNJOFpyK3lVSEFz?=
 =?utf-8?B?QmtGclgxS1owYWM0c3VWR1BQOTFMYjlZMFNtN1dGUytHYmhIYXVZUWRoN1ht?=
 =?utf-8?B?bXRsR21qOVFacldCa1VXekZkemJXT2tET1o5SmcxcHVLOUdVNnJudVhBWHpU?=
 =?utf-8?B?TmFaeDJ4TE9CdEMyb29JTVRaZFBIeXRTY0RjMDd0OVF6aFpGM1VMaG5IbVRH?=
 =?utf-8?B?dUxmZysxUC9ONXg4elhWUjY5bjlFeWY5c2lZaFl6M3lUbFV2dUlOOEM5aXd0?=
 =?utf-8?B?c1NoZHVYNnJvK1pmbXFYOXhSZFE0RVZ4aVFRZTQyaW1uc1A1QnQxMnlBYUdz?=
 =?utf-8?B?N0ZVQURKSkUxbTVDNkpkdUpTbVhqWk5FVUdFRFFKMHNUL1FVVlFkMzVwU1cr?=
 =?utf-8?B?cVpWUXdsakU2VDBTMWM2cXZaempQL0hpT3ZTUElBMTBoaFBvRU5DY0VxVTly?=
 =?utf-8?B?ck9GaktYM3B3VmduNmtnQnBOaFJIYXZxUFIrMnBpZ2hyeEF4Y3l3MkhUTGZO?=
 =?utf-8?B?azFOdWJmNldiV0NIdHE2bTNJeWJIenNKWUlLalUxNG5RVm9PWk15ZXV1VkZl?=
 =?utf-8?B?cm41MXVoRE1TWnFoWldQQjRodDVjYnI5ZmgyWjU2V3lwcitWdFZKZlNVT2Vj?=
 =?utf-8?B?RTBlMGdsQnBUTGNMclhKQitDbm1oMlA3M084L2ZNeXJPeEc0RkpKRVFuVWhn?=
 =?utf-8?B?UXYvTU1TdHdHVmxoWTE0ZXFOUE9aUG13TytyV0d0VDRLWUxCcmwycG1DQkF5?=
 =?utf-8?B?RlprLzdnNEY2WEdESDBpZ00zL0RuNkdIUlkzcjBmVC9oaWNQSzFrcVhVTm9N?=
 =?utf-8?B?L1JkYmxFeHhrL0hrVlJTKzhFUzZXS1QwU05aNG11MmIyRmp1bkZrMmFrS05R?=
 =?utf-8?B?MkJNZDVXdlU1ZnZ2Q09QNmFacW1ZaERJYkE4RjM4REtQOXdoREhMQUdyWHlm?=
 =?utf-8?B?QlNuWjd6dkloTUUzbkdBN1JQOE1rM0RLeGdhOExoUXBCWlZpWnBrb1RndG5o?=
 =?utf-8?Q?8z0suysLBcfER?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0V5UFh6MjlabjY0Y01IUC82UXpjbCtSQUErdEZoNGZNTXFlN2xrNU1hUDVK?=
 =?utf-8?B?bER4NHdDbDI0dTNCa21QTytjdnBpczV2YUR5dTlGY3VlVDFnMExJZElUK2dn?=
 =?utf-8?B?M0ZDQW5EZnlrUmFWM1BFVmhjVkFOa2JEc1lTWllUaXBWdGFaaS95eStMVWJE?=
 =?utf-8?B?WkhZVklkdmtsR2ZsUlpNdkFsQnF0VWg0a1VwMUdmOWVlLzN1WnN3Y3A4SXJJ?=
 =?utf-8?B?eDk5SkZpbUxQcVpjRERUZzNucHpyNFdZK3doUzhGQmFzRWd2czlMQjF4V1oz?=
 =?utf-8?B?ZEl5Wjc2T0xDd0ZZUlp2d3lVS0p1S3IxcGlJQkIwUkRYa2RCRytRR0RBUDBh?=
 =?utf-8?B?K1dSVjROZGh1cjlsTWtlYWc5NlZQSlQ3SG1LdHRKQW5oTHY4aGlPQ0E0SEpj?=
 =?utf-8?B?dGV1bFpVRjJjeXdJc3dMYWJyaS9xL0NOZEUzRkljWGdTVmxoL1JmdlRHOHRL?=
 =?utf-8?B?QjFtSTlWc1NqSlJkSmR5N0VPalIramhLWHdacDEvTWY5eEJVRjdhSS9wMGs5?=
 =?utf-8?B?VVdVWG5JcnZ6UDRheFljNDcyVUR0bVY1eUx1Ni9ZMUQ1UzkrTHMvdjhmWXcz?=
 =?utf-8?B?bUF5SmJKZHhlM0NZcjJ4N2Z6QmR1clh4VmZhbDNoZXE5WUw4czBVdEpyRTYy?=
 =?utf-8?B?RDNUSktOYjYxZmkya1VsenlJRTcvVU5nUDVsU3c3bDVSK3praE16Y3I1Y0Nw?=
 =?utf-8?B?bGFBOFo5cldwUU5KLzREV01WU29GTDQwcnpaK3dYTzJZbWNGdnczZTVZSDlD?=
 =?utf-8?B?OUc5dE8rcXIvNkdqTGV2bThYMDRtMTJTcEo1aEhuZWlHamQ4Sjkzd2NKSVpt?=
 =?utf-8?B?TnZxM1cyazdRUnBGY0JhSnhOYnE2dXJpWTVPZWk1OGNNeGNnNWVvdkp5alpQ?=
 =?utf-8?B?bUhhbWZqbVFiYS9CYUppY3hEanhPdG1wSXRLNUFlRnM0YTV5TFRzc0FjYlpa?=
 =?utf-8?B?RDFmUGtXaFMvTCszVnNhU2RHMmt1ZFFUcUxmOWZscStSVVRKS1JwdVhxRFVz?=
 =?utf-8?B?RS9XUS81U3Z5TVp0Z2R5b2I1and0SlFQM1IzenorQnBGU2pscXltc3cyaXFx?=
 =?utf-8?B?UW1wTk9NVWtjZmxaNjN0a0k2eVdIdUhxdUg2WGh0V3ZUaitONFo4TXgxenor?=
 =?utf-8?B?cEJ0MmFPbm1yVWRkVFpyVVk3Q2VkMk00NWRBRHVqcVNSMTkyWHp0ZnVtR2ts?=
 =?utf-8?B?S0hBVmZSbUFLMnVmK1JiV21TV0NhRWh2WWl0U29LVFdsUnVmblprZXJoTERl?=
 =?utf-8?B?THRMT2p3cEVvTHZQT3BtcjhNNkRlK1g2ZmFWdDdDMjVQZkZySnV2VUFCRlhj?=
 =?utf-8?B?NlB5L0xGbm96eTZHdHplSnlqWjgwUEN0azg5d0FRazVEcVI4c21tNjdIZW5H?=
 =?utf-8?B?d3FBSlptS21BRlQzRnhibEhJbDVrVG5hZU9xMjB0c2ROeW5CR0ZXNGhDZThB?=
 =?utf-8?B?SVRTUFBMYkVrR3dNN2RRNXY5VDhJR1dFS0VWM2xQVHlnNCtQS3c3UXA3QWZp?=
 =?utf-8?B?ZEFNRHprNFhGOWh1TEY0Tkt3TmhkQTdmSml0bStybVYvajFUUE55dVIvNDQ4?=
 =?utf-8?B?OVZNd3NaRE8yT2R5NjZXUjI0NjdHZEJzTDJBZy9tY2JQOXZudTRaWHV3NDA1?=
 =?utf-8?B?dElxQUNzKzNuNkRTQTJ0ekdFWHVYcW1rdVNVRmpNMjd1anQ5UHZrLzl6T2R4?=
 =?utf-8?B?YmUrTEhuYmJzWTVwSHZrKy9LMDdFYUZ4MGkzQ3AyS2JXVGt5RWxUd2tkWFJY?=
 =?utf-8?B?WHVGcHU5a25COXBheEJVYjY1UlNXSW40MTFQK3lTa0lobEhLVnl1clJ0SW5j?=
 =?utf-8?B?KzZaWk41cGNhdlZDeWdoN2Jwa1NkTFQ3aUlVTG5tNDlkR3NmQ3c1WEwyV0sy?=
 =?utf-8?B?L0VhU0NNWjNkYUREeGRhVlh1eDZmNUI3Ty9JaDB0MDFhTVpBV1l3aFljMVM1?=
 =?utf-8?B?Y09ldVN6MFV4SDdPMkJ6ZHdCZk5OcDNnVXhaTEhjQ0hodGc1Rm51dnFYVnRo?=
 =?utf-8?B?cFBCa21uakdSQnhhUFRHeDU3QmhhcFE3bk9Jbi9nb1hrSGkxd1VPb0w0WGd3?=
 =?utf-8?B?cHp3TllRQ0xRaTJvNkVtYU5LQW1SQ01XTWlGdThVOVZmbUdLbFpOcUhVbmQy?=
 =?utf-8?B?U2ZMdXZHdHNIVnN6T3l6VU80OXYvL2dnSXJsa2o5MDIzMlQ4MjNCN3VweXdX?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6c0b76-886e-45a9-92f7-08dd6281dce0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 22:53:25.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0bn/Dfm1wqnz/5NsDkWDAquJDHhig7DYhfHmHTkTFiTQHSlmJJdLQatGkrhJdm99YQh4rwEMHYBV8CtXslk0cbBpTk8ft3SMxMJWE499B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com



On 3/12/2025 1:22 AM, Eric Dumazet wrote:
> As mentioned in commit 648700f76b03 ("inet: frags:
> use rhashtables for reassembly units"):
> 
>   A followup patch will even remove the refcount hold/release
>   left from prior implementation and save a couple of atomic
>   operations.
> 
> This patch implements this idea, seven years later.
> 

Easy for things to slip through the cracks and get forgotten.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ieee802154/6lowpan/reassembly.c     |  5 ++++-
>  net/ipv4/inet_fragment.c                | 18 ++++++++----------
>  net/ipv4/ip_fragment.c                  |  5 ++++-
>  net/ipv6/netfilter/nf_conntrack_reasm.c |  5 ++++-
>  net/ipv6/reassembly.c                   |  9 ++++-----
>  5 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index c5f86cff06ee7f95556955f994b859c86a315646..d4b983d170382e616ea58821b197da89885a6bb2 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -304,17 +304,20 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
>  		goto err;
>  	}
>  
> +	rcu_read_lock();
>  	fq = fq_find(net, cb, &hdr.source, &hdr.dest);
>  	if (fq != NULL) {
> -		int ret, refs = 1;
> +		int ret, refs = 0;
>  
>  		spin_lock(&fq->q.lock);
>  		ret = lowpan_frag_queue(fq, skb, frag_type, &refs);
>  		spin_unlock(&fq->q.lock);
>  
> +		rcu_read_unlock();
>  		inet_frag_putn(&fq->q, refs);
>  		return ret;
>  	}
> +	rcu_read_unlock();
>  
>  err:
>  	kfree_skb(skb);
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index 5eb18605001387e7f23b8661dc9f24a533ab1600..19fae4811ab2803bed2faa4900869f883cb3073c 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -327,7 +327,8 @@ static struct inet_frag_queue *inet_frag_alloc(struct fqdir *fqdir,
>  
>  	timer_setup(&q->timer, f->frag_expire, 0);
>  	spin_lock_init(&q->lock);
> -	refcount_set(&q->refcnt, 3);
> +	/* One reference for the timer, one for the hash table. */
> +	refcount_set(&q->refcnt, 2);
>  
>  	return q;
>  }
> @@ -349,7 +350,11 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
>  	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
>  						 &q->node, f->rhash_params);
>  	if (*prev) {
> -		int refs = 2;
> +		/* We could not insert in the hash table,
> +		 * we need to cancel what inet_frag_alloc()
> +		 * anticipated.
> +		 */
> +		int refs = 1;
>  
>  		q->flags |= INET_FRAG_COMPLETE;
>  		inet_frag_kill(q, &refs);
> @@ -359,7 +364,6 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
>  	return q;
>  }
>  
> -/* TODO : call from rcu_read_lock() and no longer use refcount_inc_not_zero() */
>  struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key)
>  {
>  	/* This pairs with WRITE_ONCE() in fqdir_pre_exit(). */
> @@ -369,17 +373,11 @@ struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key)
>  	if (!high_thresh || frag_mem_limit(fqdir) > high_thresh)
>  		return NULL;
>  
> -	rcu_read_lock();
> -
>  	prev = rhashtable_lookup(&fqdir->rhashtable, key, fqdir->f->rhash_params);
>  	if (!prev)
>  		fq = inet_frag_create(fqdir, key, &prev);
> -	if (!IS_ERR_OR_NULL(prev)) {
> +	if (!IS_ERR_OR_NULL(prev))
>  		fq = prev;
> -		if (!refcount_inc_not_zero(&fq->refcnt))
> -			fq = NULL;
> -	}
> -	rcu_read_unlock();
>  	return fq;
>  }
>  EXPORT_SYMBOL(inet_frag_find);
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index c5f3c810706fb328c3d8a4d8501424df0dceaa8e..77f395b28ec748bcd85b8dfa0a8c0b8a74684103 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -483,18 +483,21 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
>  	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
>  
>  	/* Lookup (or create) queue header */
> +	rcu_read_lock();
>  	qp = ip_find(net, ip_hdr(skb), user, vif);
>  	if (qp) {
> -		int ret, refs = 1;
> +		int ret, refs = 0;
>  
>  		spin_lock(&qp->q.lock);
>  
>  		ret = ip_frag_queue(qp, skb, &refs);
>  
>  		spin_unlock(&qp->q.lock);
> +		rcu_read_unlock();
>  		inet_frag_putn(&qp->q, refs);
>  		return ret;
>  	}
> +	rcu_read_unlock();
>  
>  	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
>  	kfree_skb(skb);
> diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
> index f33acb730dc5807205811c2675efd27a9ee99222..d6bd8f7079bb74ec99030201163332ed5c6d2eec 100644
> --- a/net/ipv6/netfilter/nf_conntrack_reasm.c
> +++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
> @@ -450,7 +450,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
>  	struct frag_hdr *fhdr;
>  	struct frag_queue *fq;
>  	struct ipv6hdr *hdr;
> -	int refs = 1;
> +	int refs = 0;
>  	u8 prevhdr;
>  
>  	/* Jumbo payload inhibits frag. header */
> @@ -477,9 +477,11 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
>  	hdr = ipv6_hdr(skb);
>  	fhdr = (struct frag_hdr *)skb_transport_header(skb);
>  
> +	rcu_read_lock();
>  	fq = fq_find(net, fhdr->identification, user, hdr,
>  		     skb->dev ? skb->dev->ifindex : 0);
>  	if (fq == NULL) {
> +		rcu_read_unlock();
>  		pr_debug("Can't find and can't create new queue\n");
>  		return -ENOMEM;
>  	}
> @@ -493,6 +495,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
>  	}
>  
>  	spin_unlock_bh(&fq->q.lock);
> +	rcu_read_unlock();
>  	inet_frag_putn(&fq->q, refs);
>  	return ret;
>  }
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index 7560380bd5871217d476f2e0e39332926c458bc1..49740898bc1370ff0ca89928750c6de85a45303f 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -305,9 +305,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
>  	skb_postpush_rcsum(skb, skb_network_header(skb),
>  			   skb_network_header_len(skb));
>  
> -	rcu_read_lock();
>  	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMOKS);
> -	rcu_read_unlock();
>  	fq->q.rb_fragments = RB_ROOT;
>  	fq->q.fragments_tail = NULL;
>  	fq->q.last_run_head = NULL;
> @@ -319,9 +317,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
>  out_oom:
>  	net_dbg_ratelimited("ip6_frag_reasm: no memory for reassembly\n");
>  out_fail:
> -	rcu_read_lock();
>  	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMFAILS);
> -	rcu_read_unlock();
>  	inet_frag_kill(&fq->q, refs);
>  	return -1;
>  }
> @@ -379,10 +375,11 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
>  	}
>  
>  	iif = skb->dev ? skb->dev->ifindex : 0;
> +	rcu_read_lock();
>  	fq = fq_find(net, fhdr->identification, hdr, iif);
>  	if (fq) {
>  		u32 prob_offset = 0;
> -		int ret, refs = 1;
> +		int ret, refs = 0;
>  
>  		spin_lock(&fq->q.lock);
>  
> @@ -391,6 +388,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
>  				     &prob_offset, &refs);
>  
>  		spin_unlock(&fq->q.lock);
> +		rcu_read_unlock();
>  		inet_frag_putn(&fq->q, refs);
>  		if (prob_offset) {
>  			__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
> @@ -400,6 +398,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
>  		}
>  		return ret;
>  	}
> +	rcu_read_unlock();
>  
>  	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_REASMFAILS);
>  	kfree_skb(skb);


