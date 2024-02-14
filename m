Return-Path: <netdev+bounces-71838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C492855455
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C6828B4C2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89D12882A;
	Wed, 14 Feb 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcvX2OYL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4501B7E2
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943871; cv=fail; b=sXwYx5fq++HrayBHp3FPTF3/xIepSZBbO8fyKTy2ykwSmIkSMJVY2+PERkhk4X7HKtq6rMJJHcilk4oSRgNOfzivD8pIGEkBBkSc9+pC+wdYxbuGvxNAb2RvWE/aLIDoo0NMgkyatga3dJdy7o6Rwk2tqneC7A/f5GPKif/9ALM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943871; c=relaxed/simple;
	bh=HFF9k0+h2UCIJEceWTdtbas1ASj3Dl1F/12LzHkQ/Vk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wdt87h6VkDU7DFVUHzjfkJTOW6CfrY2fuvogL99C75E9jAKk3yLlEcZWamkoTKWE4y7DpMTYtPk2j225hQ18iZHFrtGWvBDZJ1TY6nRZv3sUzUw2gFtj7equk1cpLTNp9Uo8FuKFlMGy6W5fiSq+N/sIdT6mxXtjkqrwy2NeExE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcvX2OYL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707943867; x=1739479867;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFF9k0+h2UCIJEceWTdtbas1ASj3Dl1F/12LzHkQ/Vk=;
  b=mcvX2OYLc96KeuAfOvt4nhlkQsqALpzcPaemqMfqombRVEvNBM4YCfKI
   gOQcPsoavsyA2jnqHPElMpRXsfy+IFO3HCJCjtPLfVQYwlJ3isXvn/wty
   XzZrPOkRbsxBmJJx4KGDTvPU6uDAJ6HWxhACJWEcgIA8BMeeozRXxGFjZ
   /Tni2EbRwgMrDVmhTt5mn6Bdl1iWlPzqvGStUVXqHtGP10ug7WRPrqwd2
   gbAi6R9JS9ytHOf3YaETYtz47K5lkZ0L0aFUFnP0rXNB8jAZTuNIEnLGg
   1NgAjqwGi+Uydeg4u1cyBCRvDkJw37pV60rYAo0srg3hFO3k24wMN+1YB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1922597"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1922597"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:50:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="8061696"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 12:51:00 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:50:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:50:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 12:50:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 12:50:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW9hqB14v+9rS04F0AJ6wLKCnhVAOMHipj54yoTNChH8c1V3My10FaRJ8s6BLqsZlx2GvDAAscWMmjdyVD4nFugjM2WyFTHebJoHgUsdGAzPBuSd37cVxnbFcH1rTs6kGmnBjM5PTPqwN052IY65uUwEODHEplLokMOPY804K54z4rG8kQSa/7jFQyGOdFRIu12jvMlaj5N1MXOUZUyXxLlUweCrUB59gRI6wKY4Bw1UutpxwjbakHs3I0rpdYuoeEoLnIpCLaXC7PgXHTw8vX0ujPtEJpNjk1gQ4R5Adjfy9nP+NYT9hAGKTu6rwMi79EZWMpyT6K/EJ4npWtXDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLB1U6zwXYwS0XlHHy6n6wV6e5ZLQFw3tGMneqKUV/U=;
 b=nfmdBtzYExNLivIIgPEWOXmRAPcIs+psF/KKjkFTmMJj9eyjFRRwIcw9s1UqiBGu8gXymPlZ4+Tu2Wyyng929Tx3H3RO5iQTksSwKM3Twq6qAvwfDvOYW5ZRjWotbWFnRiuXcPilH0rLkZEAvHmyh9xq0L3L/JZyEuz9aHw0FhkRxNcruoFS7dLYRRgzgvlhmH9JCwZ756RKs/FbeJWYUFKAvlutdaAsxdDyETHJ2EZgG/r1Hd8K1AyEMods3Zvo3KahYEbE7S1AqE/S81rRM4aP1zZvFz4pM0WZh/lvulPsXDb4dew/e29s40kZLugjW655NGV5+vOGS4e4G+HyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 20:50:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:50:51 +0000
Message-ID: <680bd25a-8bf1-4af6-b2bb-e5a11daf287d@intel.com>
Date: Wed, 14 Feb 2024 12:50:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] net/bnx2x: refactor common code to
 bnx2x_stop_nic()
Content-Language: en-US
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <manishc@marvell.com>,
	<pabeni@redhat.com>, <skalluru@marvell.com>, <simon.horman@corigine.com>,
	<edumazet@google.com>, <VENKATA.SAI.DUGGI@ibm.com>, <drc@linux.vnet.ibm.com>,
	<abdhalee@in.ibm.com>
References: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
 <14a696d7a05fa0f738281db459d1862a756ea15c.1707848297.git.thinhtr@linux.vnet.ibm.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <14a696d7a05fa0f738281db459d1862a756ea15c.1707848297.git.thinhtr@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:303:8e::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d81140f-0007-478e-d815-08dc2d9ea111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8qDXHtNpruuO9JPqr73pWZOWFMflPgh4bDnF8WpuJyObVcRwIObPB+YA9mpBniglzzrtIag6I2ERT5+W16pBh152uwcS8HB7m6iAPT8GxtfZ2K1f47QeCQM5wAZQxMrDTGPORLZvM/Xi51Q1emLM+OTNRbqXo7v/+CtBIPBBUTMWdb4DNxDWRv2rbOpBCJQUtA2fu0aHWShH0RrdAYEJHosSwSk9OwPFJoUcOk3f6YJ8CYo404Q8N8sfidDuT95DHEDIMeN6xrAtost334eam2aqagiFJM30ocdLtgBlqcnQZW+U4X+iNEcE+mAMaaIF2rGMkeYhwMG+IKQHZbdewB7xM5f6uEQsPNfpufYmBkUVGAxVpsUQ+uNmRQvHBPgdkTh1dYwCdI3ELBmJMU0+4MpgzURsNnqj9Is9N4qhlvmUObdpVr8XW2mDr88t8JKLjEHPmRcWA2WINq44Sfit5DjI6EdPJumLpkTDVsIfbm1tYnv7QOJ+qu5qdUPHDiW5yLwJzXNi6NXk/Sc7kqpVT5cYJjxgnrHirmVRMiVTYXZORb/79JV/E7i+NIFC7o8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(2616005)(82960400001)(83380400001)(41300700001)(38100700002)(4326008)(7416002)(4744005)(8676002)(5660300002)(8936002)(66556008)(66476007)(66946007)(2906002)(6512007)(6486002)(478600001)(6506007)(6666004)(316002)(53546011)(36756003)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVlGUjV4UWthQzJwdDJtQWp0RlFVd3E5bjZFellnUnNXeVV3dUR0TVR2MytP?=
 =?utf-8?B?Sit1ckQzSzA3SWhEMGt0M0YyTE5pOUlxeWVSWWRaMndIdVgwVVhzNVhvd0wx?=
 =?utf-8?B?OUVFYnB4b0JPUEs3cjhMNzRNOVFsZ0tBYitXQktFeXZoNlV0dGVwZFd1a3Fp?=
 =?utf-8?B?MFVITWZnbmEyZ21DMXZGcFZoUUlleEZUMXZBcVNDVWZrUjVqMFlXSHgyNTM3?=
 =?utf-8?B?V2o0dlZuWWVndVZMcnBDRVRuM1orTFhNOEhsTDU1aG9Mb1E3T01HRGpDQ3lN?=
 =?utf-8?B?dUlxeWwxOU43ZFhJMUVMQzNSRmozYUZ2MXM5WitwZXNtUldWMGl3VzVYTzJB?=
 =?utf-8?B?S3hva0Vyak4zTHlOK2NYdXVKd3JLWVZDZ0lNSW43NUNyeWpFb0d5d1BXdmRI?=
 =?utf-8?B?MFlsT2NkSlV5djhxdC9GUndFeWtKeDk4OS91SjJFbnZxekdpZHpLTzZ5a1VN?=
 =?utf-8?B?Rk45SldtNGJEMFhFL2hYU3hSMXhDS3RIQnpUVnhnQWV1RkRwQWp1djJrZzha?=
 =?utf-8?B?ZVgrRmxrT2hFcFgyUU5wQisyRFZwMjhGZHBNN25mdlBBTWloQkZEczdkaDlW?=
 =?utf-8?B?NkpVODlDeEtWYUtaYllDQmdCRWE5SWRibDJTay9JbHVkeXpQYStTK2JOcko1?=
 =?utf-8?B?RC9mNTRiVjNLb1JtRkJPY2s0bW1hMGUyeVVYSG1DUzdMaHBnRXF0MlJYQVAr?=
 =?utf-8?B?R3dleFNPb3Q0c01iUGJYYkgwMW5jS2lzRTlMdzBXT2haOG9FZG5TMHJNeXpl?=
 =?utf-8?B?OS9qbThTNFIvQTdIRHR2SnVpMmYxVVJ4U0xodkZWZmlkMnJxZEQ2Rk1oRys4?=
 =?utf-8?B?dWZ1Zm0zS1RMb0dJK3NUQzhVNjU3TmJqT1FkNi9VbVZTbXpUUDJrTFhNOEJS?=
 =?utf-8?B?OGNHZEM2RkpFb05rZkx5L0hnY0RpMXFSYWNMUUpocFJRc2tPVGR3dmN3ckpx?=
 =?utf-8?B?S2ZHY2lrOGRaVG1UZmtCY2pFTnNiUHB0d1VzaGtMNzlTVGtUSnJocGp3dlpY?=
 =?utf-8?B?SjZlNGJqNTZCbXFkTkZUdjZXdkkzN0VBZzVtWFRDVkh4WUl6MDBseFpQait1?=
 =?utf-8?B?aE9pK3lsa3ZyY3ZiSnVMK3RMSVEvbjBKaERNMDZMOWx4c2J0c0FvVzNqL0t4?=
 =?utf-8?B?SXl6Ry9uSC80b3lOSWZBMDJsa0dSUWRmWnhSUHJDdTVjYXViaytyYlhjY1FH?=
 =?utf-8?B?bVlLZHlINUgyTFRxOWZjWGV0blhIUElhbk5JNjk2ZkRTWlFVYWhGeCtHdHNt?=
 =?utf-8?B?cWI1VGpnZ0dNNWozQzRyTnB6R0dXTU80T0xCRllZNzNwY2tqZDlXMmt6UzhF?=
 =?utf-8?B?MW9hcnYvTzB5SkdSZmYvRWFvQ1NKb0J1MXNSZUc5UWFsaDFwTUovQUdVK3Ro?=
 =?utf-8?B?YVdiaE5OY1hGeVVuc2xUMm9jbisxS05qUmp2bXdyeXlOT2hNb21xTXJuTk5C?=
 =?utf-8?B?RTlycWpVM2RTSkRuSlBBc1d4RGtXNXZQa0poK3B0eFU1MGllbkJncFhCVzBl?=
 =?utf-8?B?eGlpUXo0eld6WERlTS9TeFpTU0l1Ti8wVndTYTBvd1RoM3diZlRRbFE1cEVn?=
 =?utf-8?B?UEczSy9HVHByY0w0anlxMTQ4VDZKMExpU2toYU1IcWxxbmZZYlVmUEIyVDdp?=
 =?utf-8?B?TnBKOEF1c2lmZXBaM0V2SjhNbzJkU2ZRUXB4a1BOMnMyQmwwUGJQakprVUk2?=
 =?utf-8?B?S0ZxN21CNm16c3RnUGt4Z3dDbDlQcU5UMzFvek5adkF5Rm9Ia1RQbTYxTjhs?=
 =?utf-8?B?Q1k0UmdiaDFkbUUzN3luTFZvY21FbnJGV0NZanRBYzF4TWxxTU1CTlNQSlM3?=
 =?utf-8?B?U2gwdUpSZXMxclYzamw2MjgwOHBZeWhPTVVGNmNrK0dyQ3kwdlRUaHNzaFJG?=
 =?utf-8?B?Y1dkaGtmMGIvaVhWcG5rMWtXMXZGRlZYdFRXdkdTdTcrOVJDcTB3UTAyV2xZ?=
 =?utf-8?B?TGFSQTNmSlhPTTZoQXdYNitVTmZoRGZBVndpcXl2amdzY3Y2VXJ3S0pNZHJD?=
 =?utf-8?B?SXZZTE9USHJpc25ZYWlBWFlKcjRpdUpxT2srUUh6WnZnY0Y2VXB6MDQyYXdk?=
 =?utf-8?B?YVdYVHRpZTFNWXVySGRkY29kbmo4dmtybVowUDYwS3lEVXQ1TytyWDUrcXNk?=
 =?utf-8?B?OWRpZ2hzY3U3bzVoMU9nak9pQ2tFQmZZOGd4dWVnMVhtUUk3bmJJMk4vOXlC?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d81140f-0007-478e-d815-08dc2d9ea111
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:50:51.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwxtaMgZAsHMoN5mkUOi7FkjnhOXEGBlsG43bPXFsgqwY33Z/Q1mJBmYTtdBcaEiDiMfg4C2YQL+bYE9BC4rtV1AQ1me6ArZ7iyAVTslvO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com



On 2/13/2024 10:32 AM, Thinh Tran wrote:
> Refactor common code which disables and releases HW interrupts, deletes
> NAPI objects, into a new bnx2x_stop_nic() function.
> 
> Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
> 

Good cleanup.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> +void bnx2x_stop_nic(struct bnx2x *bp, int disable_hw)
> +{
> +	if (!bp->nic_stopped) {
> +		/* Disable HW interrupts, NAPI */
> +		bnx2x_netif_stop(bp, disable_hw);
> +		/* Delete all NAPI objects */
> +		bnx2x_del_all_napi(bp);
> +		if (CNIC_LOADED(bp))
> +			bnx2x_del_all_napi_cnic(bp);
> +		/* Release IRQs */
> +		bnx2x_free_irq(bp);
> +		bp->nic_stopped = true;
> +	}
> +}

IMHO this could be an early return:

if (bp->nic_stopped)
    return;

That is a bit of a nitpick and the existing code (by necessity of not
being a function) used this style.

