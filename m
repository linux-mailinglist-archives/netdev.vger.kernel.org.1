Return-Path: <netdev+bounces-72347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BB4857A55
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4B31F20F0D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B30C4D13F;
	Fri, 16 Feb 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJiWNuqX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2651BDE7
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079556; cv=fail; b=FaLIR0jeAzv7fIacS9q9qw7YFKb1MSCqSZR0GceBSFrDWRPhb6BS/xytkLHbPkFTBMtGb6pEFODB0AsqeNDnnVvLSG5STFg4CnX/j39dNE41ZiFdWNZFYZpgdvdijJUqf11uvyC53xDCJATrU1SWSau5eAk3SCeEhfgvvN4WQOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079556; c=relaxed/simple;
	bh=zelLplT6F+rw2JwYbNSwXveDEfLWO6Puh1agaU2/Xns=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qkt+yDsa/KJ8ou0cKg/TlkpaL7H3Nr2lgKB5lJm7s6Jk5dnG7PbFIKUfdcOcC8Jrq8dSKxXyEH+g15ZcS/FxiQSk9qED96EegE6pv3qLnGyYyaGw4tzLTddHzMi+ziBuwGdIs+oOJ74pag6AiUErnR2D84SBRUTBQFDIxaVq5jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJiWNuqX; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708079554; x=1739615554;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zelLplT6F+rw2JwYbNSwXveDEfLWO6Puh1agaU2/Xns=;
  b=UJiWNuqX1UbSDEYMSFghhwmoeo+0zLCxHq09UWpl56gIWhkQJJRAyzVH
   +H6+1K6yVFxCvjBEyAL68OhDYh2e+JSogU3YUaajWJj70iClYWpj3DtnA
   k1FdZ+94vEA8TAosp8F4Ykcd1rRembCuKumfxtPkKY9UaleRd1OfNoGcy
   aNZbXXunYc+mjMxlM7sqeh/8XXjNbHuryDHMZodRK0cc0x24HSk8AMKdw
   wOa9eREL4bROBClfolj+i9qIU146/FLSQCrQLXhJCKCWSxfIwHqZaYbXK
   IWUxT1pplV7ExYO2dVg9n1zTrFYbveURHnIPtAnA9lUySkR8nr8qObeCw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="13597252"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="13597252"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 02:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3784213"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 02:32:33 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 02:32:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 02:32:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 02:32:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Q8k5XOe0Lmq4IfqfDjRB8q9oT+dc1OPkpxbcgwLJYjmsQskRvRszip0jbDqa1WMOX7w8Zo51qOUnqGIn8ZJkVjwVJj4qyHxDZVMyvjG47xPY7GFupWPhd9KvANcPB8BFHkG7egHUPecWsdaa7N7Up3I5gNqDWbUc03tuAK61Ic1Ue/gxT7iER35fL6cRgQPkQ67P/VMUW9AEsngLAkCsTPCdrsZ6SHJ1f5JsMJGHuOGnWMUjLUVapFrhC1WKdj3R6AbjKn22ZWoBblgCXbdEzdUNXQARGWrTd+w4Yl8lmlyl1R9QtHO4cuc2P4dplgwiWIDVUybm1l6ueTNRyuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1hOQD/qVxkyVnEdsuTKIcqEIMvrtdS7THd5NE74c5A=;
 b=oAEuHjHOrIIy8t4TbgfqztQmi/OUj/K/abFWMooc+FasP9nUfNhF0zEVxgbbM2WjrZxtJnMDh7LltqWeeP4OuPQrfFTVRJnq0KOBUvKuBVu3sNYJXjddK5sqKswamtEhSIcyX7JDAiTm5ao2X72oY4JUViSsJg6L5KbZHOXUG3Jq1QSOH4pvNcb56Uzb4hV1/GfhDh8kgjpr6RVy8k0tnRPOdIC4AA7OazGd7kZynZi+XAsY19otPxq8MefFJAEeVp5zR9+DoVKRKbxyBSskhpaKkfn3n4vet1VhBAPTZMCQtUzW2T0lAAQYngHq4AwHhAl7lZ2vWrDIM98M874pjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6551.namprd11.prod.outlook.com (2603:10b6:8:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Fri, 16 Feb
 2024 10:32:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 10:32:30 +0000
Message-ID: <1e71d334-e2f3-422a-8dc0-a10d3e2f09ac@intel.com>
Date: Fri, 16 Feb 2024 11:32:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: fix recycle stats for system
 page_pool allocator
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: <netdev@vger.kernel.org>, <lorenzo.bianconi@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<linyunsheng@huawei.com>, <toke@redhat.com>
References: <87f572425e98faea3da45f76c3c68815c01a20ee.1708075412.git.lorenzo@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <87f572425e98faea3da45f76c3c68815c01a20ee.1708075412.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: bd81c4c5-f604-4644-3af9-08dc2eda93cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2t9gf97x+2XNiomJvMQkloawvXGRb4nJYV+Zv1kiDhVwkGykLUDRmWUk0gHxI26dT0E2lKJ8H1M5B6bXTHDgE3D+GdB3vMZ8vENUxigbGCaQ1GOQU+aL/o2kwMGMDS4GJeczXQ6dtA1DpbME+ujhl/JVeJW+8j9xln24cSVg7vt74XibgbGvsesVeQQ5+BpdHYMdrsL5Pd+aGdadCJJkazKaBKwCknJSPKwwkYQugQeqnbzML/Euu33pkWbKWeJunaojweU4A/HQbioSx4EQFZbZWgO26IOrkP/fgFFKVVi/aery+zZyku7IY7OM+D3zVB92FBin4IehMxR62DlGVGvucQs8EF93QvtOXGoeLHO+Z4sGHVXrpES29qMqGwsKq/77CpTOOJONCSB39RMkc+6DaPUTegPzb5vBLMOxcTHlpVZ+oRWO2w6ciYIxDlWMokLK3G9dATm3vdB803Uwu2N7LhdAg67wPrqRInaWVbaPlnfs0hLDS999W2/i5PRyNNE2rlNpk3IVxKkIg3RAOQ+c5wj1OfyhjBXNJTAJIap3oUaT6ocZMevVqNJj2+H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(6916009)(66946007)(316002)(66556008)(41300700001)(66476007)(7416002)(4744005)(5660300002)(2906002)(478600001)(8936002)(8676002)(4326008)(31696002)(6486002)(36756003)(83380400001)(2616005)(6666004)(6506007)(6512007)(86362001)(26005)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STNGSnRUbUtQODRobW81NEtYWVF2eDJQcjNvcHVEdXBaalVxM2h5L3FwdUtV?=
 =?utf-8?B?aDJkNTl6SmJFNVJNMndZUS9FZnRXdllCbUJqUDZGUE5xL1lHOXJkczN2aXND?=
 =?utf-8?B?T0NDc2NQOWRNZWZwZzNNRVQ0ZC85MlE0SHZqcDZuRkVkRjc4RHNpYjZBRXpQ?=
 =?utf-8?B?QlJ4MGYxMU5nZUlEdUppMVE4bEg4eE1pK2FDa1JIcHFCME5SaUNVMzdVbGhp?=
 =?utf-8?B?eEFJek5PSnVjc0RiMVdFL0tYZ0NrZmc5a0l5ZzRTV1pCVDQ1SC85dHRFdUF4?=
 =?utf-8?B?b1lzMGxXWUtPOGhtV25MUG9wSTBCZUEwYTB2SDRxdmtxUWJRaHhCTnJrbGo4?=
 =?utf-8?B?T0lHTXViR2VDa1NZVHNSOW1kTHNvUDhLdzI3dWJ3cjU3RkFYZE9PM0NkVDNT?=
 =?utf-8?B?V29vays4WDdVTWFIbThEMG10azJVcnZQOUQyTjJTMGVkZ0lORUhocjcvTEhD?=
 =?utf-8?B?RFJxSTE4cVhNNEIxaUVhZWV5QUVJY1IxQ1R3Sm5mMy8rRjZscXVBMUFRdFFE?=
 =?utf-8?B?RlM0ZkllblFLd3lYcldsQXRKWm8ySHcvc0R3Y01hUUE1UHptMWZLN29ES2Q3?=
 =?utf-8?B?eTlFaXVManc5em1WYnNNdk9HMS9FM0J2OHNBZHdWYjdUN1pBUGthTjBaUy9S?=
 =?utf-8?B?a09HUjd2aVc0UHNjaFRtR3FEeXJvS1djSXR5Y0UvN0lmcitNem1GbDZxTnZp?=
 =?utf-8?B?N3ZTOW1NOXdyTVlVTE9vMkxmZVR1Q0d1eGhGQmgrczZWS2ZYakpXUHc5d0dv?=
 =?utf-8?B?Nzl3Vnd1WEppN3JVRnVmT0MyenY0M2xRaG1KUjROaGo5ODZPY1lOa3RPQ1hx?=
 =?utf-8?B?cXVBVTI0Ly8yUjJTSUxLL2d3ekNvWmFrQ29yd2I4TTl4T2p3cm1lb0VxbEVR?=
 =?utf-8?B?MHFsRmx1Q3FmVWFjQ291MXJmamt5R3phS1d0dnZmV0tCQTVlRUlacDhCR1JH?=
 =?utf-8?B?VVA4MWxOR0MzbS8wRy9OajZYQzlpUWswcjZ4Q0t2V3h2SGovR2xlUnhTU3FI?=
 =?utf-8?B?MDIyR1RUSnZQY2U0VlB1QzhlZ21mbEtzbEFDZmN1a0dQQkxrcFo0YXBSdUth?=
 =?utf-8?B?NDBhdVFaQko0SFpmMmZDdlgwYVZPdXVtbUJBZDJrNFArTktqMlcwQTQzbTFK?=
 =?utf-8?B?eVNPRjBpc2JDZGw3eTJqYm9Za2VReTZTQWUzdXU0ZU1id3RjaHJTK0M0d051?=
 =?utf-8?B?a3JlSll1QlRHSldlY0xkMzRKMk4vQnByK2dVckpOUTh4WE5SQkJ2ckU2blls?=
 =?utf-8?B?Ky9mcGNqU29aOHNvQW9vVGZzeWJGM3U4UXk0RTE1NlVsOFpYMDlFRnJhMGp0?=
 =?utf-8?B?SnFkanlES0ZtOVZ3VEYwMmNQbytyKyszR1lSWDVmeTVXSmJ4WTlPSkpVblZv?=
 =?utf-8?B?VU1vd3VPK2FQVm1BVklIUEVJQ0V6WkFkN2QwMmp1OFRxL1dISW5ySCtTaFZr?=
 =?utf-8?B?RHRJcGZOZW8wM0tlRkVjM3VpQ2tZb0Y3bndpaGRzb1poTlV6VzNhSGpiMnFT?=
 =?utf-8?B?L1hiY1RMWHNHakM2TEJ3QnpoSkNHQWN0VDA0Wm9SVTFFbFlacnc3c1BRRG5v?=
 =?utf-8?B?MUxvay9KUU9BRU8xVnJmeEJBaU1Ja00vc1gwNDdZQzI2eDBNZ3A3QkNubVg5?=
 =?utf-8?B?Q0pyQ3QxSHZhOGdGU2sxaGtabEVnTU8vcmlaSGVtQzU4NG1QSGNnNFh0ZjNO?=
 =?utf-8?B?MDJERXJraWJMY3QwK25FYkQxWmJybFJlRjM2czl6YWZUYm1kdmxXNXRUaTQw?=
 =?utf-8?B?NU92dGRkRTVnbFdqZjV3ekVqNFJTL0hsQmNLSEZqTG1qcTRva0ZHRGNubjhN?=
 =?utf-8?B?ekZBbjZiVlpjL1pDcnRQdUtTcDFlalNaS3dyWmNQejI1anlYMzhFUUczY0wv?=
 =?utf-8?B?TWd6YXZ2d05Tb1JvajQvTjljMEVCNEZjS1FzbTZqWkVoU2c3SFJHYmVMZDF5?=
 =?utf-8?B?eTJLVUxLYnJ3dStUaUIvTGp0NlVIUmJpS3lOdmZXWmV2ZHB0V3o1bmh2cXQ0?=
 =?utf-8?B?MldsZDBpamRHaUhITUhzOG1nY1RkTVpxcUlzYjBFS1NZT0dxSVVyZTJDSm52?=
 =?utf-8?B?Q0VXN0RiRWllb1pZVlVYUG5Tc2FRdnp0WjZUbFZuMUR3NC83ZmhHRlRyQUJK?=
 =?utf-8?B?ZVVwL0F0VS9QY0F2ekNjc3NhU01HYUxSOWY3S3FFTXlnYUoxUEYyYVJDTExp?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd81c4c5-f604-4644-3af9-08dc2eda93cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 10:32:29.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2qPOmekXJ7jyfxQ8I5Bm4Z5EBQWk/oro/Ui05Rb4nL09/xiPYhTdz+s9JvM75IddrO3V5g2HS7uPjxkrsEoxAgakplKMIODQaFERdkHVaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6551
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 16 Feb 2024 10:25:43 +0100

> Use global percpu page_pool_recycle_stats counter for system page_pool
> allocator instead of allocating a separate percpu variable for each
> (also percpu) page pool instance.
> 
> Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/page_pool/types.h |  5 +++--
>  net/core/dev.c                |  1 +
>  net/core/page_pool.c          | 22 +++++++++++++++++-----
>  3 files changed, 21 insertions(+), 7 deletions(-)

Thanks,
Olek

