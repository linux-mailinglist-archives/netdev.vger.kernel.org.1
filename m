Return-Path: <netdev+bounces-99517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEBC8D51B2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7E61C22974
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5164C602;
	Thu, 30 May 2024 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXFgIyCG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D147A58;
	Thu, 30 May 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093253; cv=fail; b=KNtSPbSXx7MJ89IYMI2v4JaJhsdeD4EeyJKXO1b+Kql4Hx1xjDmhZvCQLWeLpJaaCL/ScNqU6gm2HU59xFWG6cO5RJ1tPls/oj1H/l1KiKITp6W28vvIrzxH8/ZCzl6xaI9Oa6PjorK7FaZdLSvDunmpGDQPbC3uXPfka8s/2to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093253; c=relaxed/simple;
	bh=znrsfy9K3RB01tUnvvVUT+0ED57mvUhXyKew0q3cfC0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=URf2vzJsO7zdl25fjQY8XezTG5SrMDquOPnnBbZ/mIjqmD3Xwh9mUG9XPPcQJydXvN2PfXgVPxwRX+6xKLObDRonblXlQFBfOrI26draSaAyKjVbHkX9dQsGOFp0C910FouTSoJ1BjqwLjq6gcpuOqvDkb0/jtbLPrv73kaZmng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXFgIyCG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717093253; x=1748629253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=znrsfy9K3RB01tUnvvVUT+0ED57mvUhXyKew0q3cfC0=;
  b=QXFgIyCGxHTwl2QljlaWS/hNHHN57yNGIWOu4Lh4ukyGsagFl7faBMZd
   QybXMd8nQfGtP35f0SzCmmssYVVuxux1lXs14QajSZBvXy4gQW53exUvc
   Xq8REvSqt8TnYuQKTROjd61udGNo+TyAVUWYV9MQOeWFqynxaxlYZWpJf
   ROSgmTfSevF9g3b27e3Ir5ADgveKmFDzivmffIMSaW0Akq4tZ34Qpw9MD
   Szcb5WU0TXy3qvy5hagGEcgyVwY34PIL8UIhHAogcDGlRzaQuS7WIqdG7
   5mJAlnLbhYaai999J8+3oXstqT5dwQw7IsD5dH8Po2iz4S7nKT3r0IQP6
   w==;
X-CSE-ConnectionGUID: XPd1MVDqQs6xM8/bl2OiIA==
X-CSE-MsgGUID: h2Kb1qLpTmCt53FzRPpwNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24164008"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24164008"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:20:42 -0700
X-CSE-ConnectionGUID: SpV+Pl8lT/yn73kuOVQHaw==
X-CSE-MsgGUID: w4sSElEsROKuAvR//x/WeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40471497"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 11:20:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:20:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:20:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 11:20:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKg/R3hej7tcnl8NOzYQl4atNL2jwREWyPA5Y31dwwM3CE0CXvC3wpQXd2XKj64b36ckigNEhiXmrsIsR/aZAwb3Yl0qwBBCl4kDAozDiD4PCNMzpUfzAzJZJ0lzkxt/WTjnpi2yv5PytQgrLj65TbNZAcXm26fGJAcr7OAu6s13Ug+hlOVyVmg5md4+SZGl3sQ8V3KVRSC3MKS30BkYvRi6QaX25vY2gSplUHWspDY1HU7a6o1e0dFVvSLOSRPnlkxPqcbvZdTPjwbdAbO/tGgWT2pfW5LEgXk3uwLHxTRkr4rO70xfoyd/lEdjcUajPZOGYNgT6XeAc8xAx2v8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE2RKnjRHXg6KKXoUVg+HNRrWdoOv1uqgYvl5AGfrx0=;
 b=QWQ++4DMes89hP2ASOg0y4vTe03xyTwRG+UN9AVMXC35GNa3sQdIzoc/Sw3puQ2rTutOQhiFgBKuONedoQoZTkcPCys3kvsMU0h0vPBPXroCK0YRK55fL7PB9lBatrFArMRU8H3jJh+xCTQ1ynzTXFo2N6BVHOnbfIFSQ3VXjeCMl7nq+HR67TKin7UaZ18D9c/erZIBYsoJU8nUVy5DAz050D3TRKj/9K5kbhsLaQmxagJwdfD0M9h5hBV9kSeqTBF1lFFD8zPcW5ioJLKnPzoo8J6wbUSLCrhATmRYf7ha9FHzJcs0vZWUtLwYPjOARKphFD6QGaJCRMj5tGbZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 18:20:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:20:38 +0000
Message-ID: <12ef3572-ba28-4abe-b891-26fa4f6fbe0d@intel.com>
Date: Thu, 30 May 2024 11:20:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] octeontx2-af: Always allocate PF entries from low
 prioriy zone
To: Subbaraya Sundeep <sbhatta@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
References: <1716996584-14470-1-git-send-email-sbhatta@marvell.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1716996584-14470-1-git-send-email-sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:303:6b::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b0bda8-0e5f-4913-a36d-08dc80d534a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0trcmdBbnVYVmtiTlYxdEpzZFhkZlBJNEliR0FMblJpQ0ZudEhrS2pSRHQ0?=
 =?utf-8?B?T04ySjVyWTVvdkZwMUxUODJ6QTAvbUxFNXBUMFFMR0Q3S0wzU2kxZXB4N2lu?=
 =?utf-8?B?TWNkWUVqb3Yyblh0ZkhjdklQSXBGK1F1VmtWWGF0SGF0Zm9qRXRtRDJkVnAw?=
 =?utf-8?B?ZW42ajQwaEVIM3pjVFliWTJwQ1F6MFRGTWVkSFZmOU16OGZId3J1bU1obnl5?=
 =?utf-8?B?T0YxOWpnVW13aFIxRVlzMFlHMWNmL0VZSGZVRzdUSGVXMDhETVp5ZjFabFMv?=
 =?utf-8?B?Y1VqWmloREFCQXNVeVpYbXF4UmhudEtKajdHcmpFc3Bmcm82d2REY2JETWx3?=
 =?utf-8?B?ZG1qc1NFYW1lMHZHdlFZanJ0bmgrbEk4WFVKSWl1Q2tFVmhWZUMzWTJ3TW9s?=
 =?utf-8?B?Qk43SG1HUDRjTjhJcTVRck1qNEdLN3NOMyszTzBSZnNQYnh3UFVtRXhkbEhv?=
 =?utf-8?B?aXNTcTA4aXpDRlV6ZGcvNDZwL3NsV1dBcm9nMXgwanNET0xpdXdpT09iL1ZJ?=
 =?utf-8?B?U2Z1eDlPaWJya0E2OE9xU3IvZW5QTkVhV0Y2RE15OU9ZeWE3clRnY0kxbFNR?=
 =?utf-8?B?SWVGYWhiV2U2VG1mNG9XZWkza01kWC9nYUxsNEZlK3U2NzhobWNneDBDY3RW?=
 =?utf-8?B?R0JRU05TdFJ1bVJ6L09uREFBUDFuRkRSbkFUcDV3YTJmYXN4MFFvU3ZMNjVO?=
 =?utf-8?B?cmxMRmZsWklDUjREbHN0bFV2WUlEZldmTlQxa3ZGditOVlJadk5iQ2h5Sjds?=
 =?utf-8?B?azdnb21WU0V2OThCUlI5SmpPd1phbHY1RUptM3dqak9tQnhhTGovRFo1eG4v?=
 =?utf-8?B?NDNjQ0hCRTlkd2pkczlqU3NyS3ArL1RHVkVXK1AyZzNVemV6dDFoSVg0SzhC?=
 =?utf-8?B?QlhaNTBZak9Mb3NxQ3gyS0ZleWh6QWZ2YW9qUFFMcGw4M1FzUW1kZnJPTjhI?=
 =?utf-8?B?dWFwTU03RU9nQ1JRbm5uaWV6RElyZ21Va2s3aWtZZk5Ua2hlQW5pRWk1Wk55?=
 =?utf-8?B?bDRRVEpYdks3S1BTWkYrM3QzR0E5U2hlVW1TalhEMFdtaUtCUE1sNTQvb3ZH?=
 =?utf-8?B?cytTbGEvY29XV0RZUzlORnV5dWE5WWVoQjJZYkZnVDdRUHk4c2VreUd0ektB?=
 =?utf-8?B?ZWZSdHVieTY1TVdKWUR3N1AwMTdiNmQzdktpS1BBUVFzUm16em8ramUyUHpG?=
 =?utf-8?B?NGJyaEYyVGIwdmNSczRWYml3WlY4NGkrTUtaZXFxMFh2a0tMNHdFVGRTWXAv?=
 =?utf-8?B?L0hTdG5iei9kUDcxMUVDVVNEN1dGRmt0OG5tQ2hiaC9VUDh6dDk3MXZZRHBH?=
 =?utf-8?B?b3RBdmJmRGpxcmRtaUJlTjBVRXZxYWRDVWRydURYTnZTOHUxTEtlUHIrVUpE?=
 =?utf-8?B?TXExb3BaQk1pZFBWT0tuZWtJa1NrWUh6eUltN0RsaUtuRTlsMDF2S0dKT3Yr?=
 =?utf-8?B?bTFCM1J3QS9sTnVYMHBLeVdlbjZZekNUNUlBNGMzcTRlM2NCTVhhamtWNzhi?=
 =?utf-8?B?STZvQXU0VGFvWmE4Q1YrYVRNREtKT0VIS0RzQi95VkxJQlNrdGpLWVBoQVp1?=
 =?utf-8?B?VEU4VW1LOE03MDFyd1NUNUF2RSsvbXUwVzQvTTNYV0syVXZvL0s1Nzl4bkpW?=
 =?utf-8?B?S1FxcUhhODFUYmZkVm1VdzBxemJNKzh3Uk9kZWJQa29zbW9JUXdJcWd0UDdh?=
 =?utf-8?B?emxweVpaVHp6NWdnUDBhd2hPaDI1UmorVlU2K0djMEt3dW9wVWtPaTlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVU3bktVeDlhMlNEZDQwNVB5a21Sc0hPcVI1OURUQ3Zad0k5Vld6OGhRY3Bo?=
 =?utf-8?B?dkM3cXF4OVRPemdoa2lpK2p5KzNhNU8vSGlHdXFQNkVWaW9PS3FiZHBIRzZQ?=
 =?utf-8?B?UEpubitmVTBrV2FrVEpYQ3hBUFpJOHNZYVNiUVhPU0RJalVvdXVBT2RKN21S?=
 =?utf-8?B?bUprSTNEMXRQQ0htbTIxYmRrM0h5Z09LdCtpRkpMUi9uODJodGkrUndRUU8x?=
 =?utf-8?B?cHNlaFBHS2w1bmdDdkE1NmxUMk1GRXY4UDlXR0sxQjFwVUFZUCsyTVVyZFFF?=
 =?utf-8?B?OER2bHBhbVI3ZVltVFUybVZzdWlTNWdEWHIwRUVLOWdRUTF1NHNtYWxmbC9Y?=
 =?utf-8?B?MzNzU21CM2dybTBuWWJHY05xVWM3NnY2SEF0a0YzSWZXWkNzOU11cGQ2Qng0?=
 =?utf-8?B?MFN4UGJrVUlWNDNkRWNGTkNxUDlyVVVRTTVWQmNDNnM0M2h4T0dlZHQzZUhK?=
 =?utf-8?B?Z09yZld0cVA1KzFMN1JsY2RRU0dGS2NQdnNtNmlPc2RCMHNrbXVMUFlnaGc0?=
 =?utf-8?B?K1hGMFhjb1ZjcXA3M2J5OER0Y3V2RUpCN1RObTJyZEtZc2loY1lDYUVTUXFQ?=
 =?utf-8?B?VHNuZGNtM1NzTHQrTVh4SGpvZlhnVXpqeHh3UW41SDU3dVpOM2VIdVpYWDU4?=
 =?utf-8?B?d21UMVkxb2R5bW92TnlwR0w0NTQyNHIxbVJMV3NpVjduYmZ4MWZIUVEyejd4?=
 =?utf-8?B?RFlCa01rc1N5NWtYWm8ramlrT1lBbytmamJ0bER2S1RLZmI1b3NpN2c2ckU5?=
 =?utf-8?B?RCsxUWZRUXFwajR5TnFQYUgzdlNScEtuVk5sMGlRVEJiQ1ptNkVmTFNwRnpr?=
 =?utf-8?B?dllxUFR2VDV5Q0RVSHc2bTgzVkxqcDZWT09XN2FLdmd6aUxreXUxd0NiQW5P?=
 =?utf-8?B?MUNnNVVoWHdTUmhUck9lS2pMSXlIVXBVd3Y1clo5cnRHckwyblhJMFRKa3RC?=
 =?utf-8?B?N3F6MjRvQm0rOFdnTlVzODVYMWR1L3Z2Z3BsSGJrTStyM0F6TDdYSWlvMURT?=
 =?utf-8?B?ZEp5R2JNVFhiUmdhWjNlOTQ5SWVVbEtyMWJyWDdVOWszaE9JcVFoTXlEOG43?=
 =?utf-8?B?NllpYUI3WFBJRDdaTkcvOUJjTlYyRlB6VytMcWFUcDFLd0pLWnh4K0k4R1Fs?=
 =?utf-8?B?Qm84YUpDVVJpd202OTRUVlRFUVZNZ3NlMkZNSGpSdmlRVzVQZ2o4OHdJYzAy?=
 =?utf-8?B?ZE5DNkZJaHZLVkZHVE9FM2pzMi9QL2F3Sy9LZ2NXcWRWM1k5dUlQVDFQN1lF?=
 =?utf-8?B?Nyt4UHhYTCt2b25IZEF3TUp5aUFqSlBYeFV3M0FhaTVMemF6dkdZZkd1emtC?=
 =?utf-8?B?OXVCY1ZkbHVpZmNPT1k1MDkzRk9aeGdEd3BvRFJYazZ1Q2RkMzVMbktFbjdm?=
 =?utf-8?B?SFVrdHQwdWY2ZDg4YlhybU41M25EeVh3SHVZU20vT3hvcFRmK0prUkxFMXRx?=
 =?utf-8?B?eGRKYzVCdk9Qc01ST1VaNjVSWm16amhTZWFmNjR1YnQxSEY5VlhiS3dZMzJN?=
 =?utf-8?B?NGRDOTRud1RBcHhicnNBZWRFS09HaitMclowUDRXTGVSbERhbW1aVVRqSFI3?=
 =?utf-8?B?c1l1WkRzdVRUZXdHV01hb3RIK3BUd1c0aXMvS0Rzc3FvVmw2amJJbUtHOWo3?=
 =?utf-8?B?eDJBYUVja29LZFk0QnNLLzZsVlNKNWU2Q2dsMW8vcExKN1NVVjQ2QksyNVlC?=
 =?utf-8?B?WThZQlo3TXdJR00veXFNZnQvRW1ZQzBWYThYOVlOL0tjOTI2OCtGQUdVRDNI?=
 =?utf-8?B?YXozallpMitzRHZBZFNzSUZxR3paKzFCcVRucnRTUUw2L0dyZXBwK3Q0bHNF?=
 =?utf-8?B?aVpZL29yQTZyNmYzQ2Vsd3V4MjU5dUZodEdrUDN6QVlYUUR6SHloVU5hdy80?=
 =?utf-8?B?Z1BTS3ZUNTM0QTVabWpGcFBGRDhFT0dCMkI2cmtPeksxZERTMjBaTVU2U05h?=
 =?utf-8?B?Z2hpSjJUYVNPYm5pdXZsMjhPWllZKzMxK1BtSnJGZHZiZGFCWkZ2Z2c5VERF?=
 =?utf-8?B?Ukw2L2pMQWpkK2p1c0tuY0RWL3NEV0JGcnJpWmlTRDJXYlN1OGxsYkRpa1l3?=
 =?utf-8?B?VXNEMjFMMnFwclY0QVdQS01oNjExWkIyN3p4eFdnWTlHVFhkN04rNCtVOWVI?=
 =?utf-8?B?N3Y0c2VqOUwrQUkwSDNUdEJjY0dFMVpTaFRUMTgyczNIQU5nOXRMbVNaOEVo?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b0bda8-0e5f-4913-a36d-08dc80d534a1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:20:37.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uLrUWn8NsGvqOpVeYVFLqnOJDz/WP4BO3+CdEvRTVBUWxiacTk47ZaFYHkMtOqfCBNudWozqkoLEASG8kJxYOrCXfGydgkmLSGkxyH9OyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com



On 5/29/2024 8:29 AM, Subbaraya Sundeep wrote:
> PF mcam entries has to be at low priority always so that VF
> can install longest prefix match rules at higher priority.
> This was taken care currently but when priority allocation
> wrt reference entry is requested then entries are allocated
> from mid-zone instead of low priority zone. Fix this and
> always allocate entries from low priority zone for PFs.
> 
> Fixes: 7df5b4b260dd ("octeontx2-af: Allocate low priority entries for PF")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

