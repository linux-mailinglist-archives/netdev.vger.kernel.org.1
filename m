Return-Path: <netdev+bounces-30125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E1F78610C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15341C20D0A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23641FB4E;
	Wed, 23 Aug 2023 19:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B01F93E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:54:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE17910C2
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692820478; x=1724356478;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g4tVhfNPEjKJ5bgheMdyGSCJFJ+FoaT+Ux+CL7EYKyY=;
  b=W5clLrcnr0U4vM9RxhXvRr6fDURaurDTMSuJOrC85bFs/yV9/nAZubmY
   KUSajv+XID5mEr1+0qMGWYrWkfUEC01o2fsOGjgj/qsneWA7EYuwd4Ffd
   uTAvDCrBmn8NWDQgnF6wk7nky9Ldg83rtYDXM53/9hYkhBKm4nAy2TeGa
   BKRz0C7WwaWF/32uUSTW+/XmmtCg2j96IBzkr5bLmCv2EexRuSz/FsCnM
   BU2PsK81Fw/HKQZRIEZ2DTk5HQGy4LNa5Ot2ZI2dx3VVs0eV/cvFM66LL
   kgMEsS470HMMDLClAa8jbJDULBu/keHkObPhdyr+krmzOWCJBC+7gMi1I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="364433854"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364433854"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="686579744"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686579744"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2023 12:54:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:54:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:54:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:54:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnNgbWnRgdoWsOSnLSxpLHhihibjIB5zU8+iCNwjKveb0FRulSpmKWF27VsKoEW3fFFOA9Li5Hr0ZHW0+CyKoLI8SV08oGn4u7Yaisi4Taa8U9FotsiGH119Vh74XbxphgvY8sbn1GOO9n/X89FNik+8yzOYp6dl1aVUIBMR8hNV/GKvkyNziCcqu6vCMI4bEDsLR+3BUgRhCr7Kuzn7PrrVn72JuHSOdfHt4YV1Yoz2pjk5t9gAPMgW6Tjhc9WQ1ot6NFWtobI1LRROusYFoACcq0uPUqKlQqgOm+PIDEjE+in9Nux+f4aBGpjW2Fblr+DKR1RT2r4qKjgv/1N0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL9g0m8VnDFCIMaVrRje9qW8LU1L2ttdmNzVxgQt+TY=;
 b=EcoQjT8xy3E9pl58+4ZA4qUy7Axt12N0rgAUf/DnFw9gCKLDxYGIOoFHFvL/nXi+dM/rLRqrIT4rGlRQNG/sHl5vf/oXoqBoLSIZgZoMG4DJX9fs+RbGuYB98pfLIxBr2zkPp0qvuiqQrtgde0bW2X96CBvxa79tLkZTLHke+86bC2JgApTaoEXjoerCD7AKdK5KMiXc5glHnwxLq/zZbSEcYr7osrdI8Fq2jqpFMZYvr/2ZUI55MHu8+sk/sA90ycSkeVa1X0HmxqfOs3CXcPAEOe/LxUx6PSb2np9v2lPUEhT+1aInOCf2jq5c+PghoLthTbFNfZ4U2vH9zD2WXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7724.namprd11.prod.outlook.com (2603:10b6:610:123::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:54:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:54:23 +0000
Message-ID: <82ddc62b-4d2c-cf6f-f5c8-812ce795a494@intel.com>
Date: Wed, 23 Aug 2023 12:54:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net] net/mlx5: Dynamic cyclecounter shift calculation for
 PTP free running clock
Content-Language: en-US
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, <netdev@vger.kernel.org>
CC: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko
	<vadfed@meta.com>, Kenneth Klette Jonassen <kenneth.jonassen@bridgetech.tv>
References: <20230821230554.236210-1-rrameshbabu@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230821230554.236210-1-rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 41436f0b-89f8-4cb2-26f7-08dba412bfbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rVNMp2mNaS0POpOzYsuXx9tYQ8FS6aL+ldTAJ5T7wuKw40M8okYeKcDGq/qu7MNLrbQqce5B5EjevluLIMAZhMcM4UEhdUAMPl6RUppjJs4q7nv+MwRZdzfS+Ue27CVF8c37OG5wnNqo0Kk52jxm16bRMgrNLhF6vjmnNh/MmLf+E1Iq414L/3xkMbV7rJvpIjto9lCcgZeOcqjbymo6OY0rg6g9bIQQ+wk3+ZMPr/gk/KdxZYTtE0J6bInc/AkeKYdwq59pTvQG/SKn7HXFxMDf/3Pq9sd9AFxRHk60oc9CeGS+yFd2C4mhUeVLjAXoO55BUc3GrQpHtTmB4CPbmEslV3i04npiWzbFpKlvTok0K0v3It5pb7s25WfMFY34RDF2BuTW29aO0O7Z7JDxlyvo3+fu9GtlqlgxeUSkAqFA3ZG4vgfDlo7cmcZtx4Wv7xFye1qN9rR7Sm6lciZAFtQg4OmThzw35ScTqFrTIYOEI2IvecbGUyoROywVUopTIGVxJM1mCY8ly7IDq0pZ93wgEWvR1yj9Li+34fjdrbCUJWLulPEI7fHOZuPlAheFIoO3e1m6RZdTRSaPm40TdhXMzcObIp8u8wao35LbpaElK8ueYDGwEm7o94eOHRcyLGTX1PjGfIL8/udrbMWZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(451199024)(1800799009)(2616005)(6506007)(6486002)(316002)(53546011)(8676002)(8936002)(4326008)(54906003)(66556008)(66946007)(66476007)(6512007)(41300700001)(966005)(26005)(5660300002)(478600001)(31686004)(83380400001)(36756003)(31696002)(86362001)(82960400001)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnlHUDR2NndKNzRtbEd3dVp5dDh6cWVVN0lwalJaek1QamcrS0t4TXFONFV3?=
 =?utf-8?B?OXB6bStTQ3MvTHVrVUN2cmd5NVJXcVlOTmMwbmxzTDA0UmFNMkttRzhVZGM1?=
 =?utf-8?B?TUExb1EzSTRveHZJMnVCUWxYdWxmZlVKa2dTa2ZCamVQZE5DbUVJcEJZQVRk?=
 =?utf-8?B?TlptOXExbVZDcWpiRnZWUlVUM2dJYXhRdEpCSWVwcmJNUnlhK2NiQm5RaVU0?=
 =?utf-8?B?K0VYM0FhYVZQYy9lcmxiaHlUaFhCWXI1emVXUmlDeU5uaTdSY1pvNnRhaXB4?=
 =?utf-8?B?aStaZGp3eFVNRktsOS94U0NxNTVtTlQwWXFxNjRkQTc5ZzJqSUM4cExwTm5v?=
 =?utf-8?B?VUdoa1BSdEhCL3Y1SjFOdk8yMTRaVVhOWG8xOGhZeGlDWWtEeHdZczR6THZI?=
 =?utf-8?B?TW9CU0VWY2w0OElFNHhsL3pCMFJWNVBLUFVuVUlCRll0QWR4ZHVPZWJ3US9h?=
 =?utf-8?B?QmFzY2Fzd1F6Q3k0b0o5akk5RGFaOE4xY0pMdTNwNGNTMWQxMks4dGhDTjJw?=
 =?utf-8?B?bFVqWHBZWTN2Y3dmWUJQYmxKS1pyRXRKTm90dkRUYWVmSnU4YUd6NElWVzZE?=
 =?utf-8?B?aTdRYTZMQzFQSTFBUTV4cjA4TTVacnVsVVpzVGZYY2R0dWkzVnN3WDFxZ0Nj?=
 =?utf-8?B?SmFxaTFhdlAxa3gxZ21NbmFkUnB6Z2lzSDRlUlZmdmlMait1Ujd3QzhLNTJK?=
 =?utf-8?B?T2FQWkZCeGRjdjhKSG1MMGk2dlY5TFhKcVhmaHhiN01iQi9ZOEIyZGRhcktG?=
 =?utf-8?B?WU9vVkNWdytmWWtxWkRoTkc5N01sTTVSVnVvOTRkMG9xWDI3ZTdEcVZCL2FC?=
 =?utf-8?B?SnRKUGxLeWRwV0lTZHFoeFpoOTUzUm54SkY3a3hXRHdmU290bjhmcTY5TGQ0?=
 =?utf-8?B?SVQ5SjREa1VmdWd6YkhPYThyUDJNWG0zdDNYMGNzV3liNEg0VHJCK245VEp3?=
 =?utf-8?B?VlJaMmFVR1JFdjg1NWFjM0x5YzhoRC9MY3l5UWVXeTFFdXcyRFpsdXgvVWta?=
 =?utf-8?B?Q3ZmZjJObHpCQjFuS0ZYSWk1Z0trNzI5TU5VZFRQYWMvWEVYR2d0cFJCVEY2?=
 =?utf-8?B?bnNzaGtxdnFZeGxrMjg3alF6SU1mN0IyTWhhM0pIeGZXT2FXSTIzdjg1azZk?=
 =?utf-8?B?WTh6bldyUTJpeWNBRStKRlYvd1BXbUNBbW5GdnM2TStIelBBT05xZ3lPaEkv?=
 =?utf-8?B?ZUV5RUN1U2xqZ2Q1bmFKTWt6N0xtUnJQS3BZZTN4S09XVDlqOE8ybG1wRTZp?=
 =?utf-8?B?Z2JGbjZPT3ZzN2YxMU41Rmc3QlpkY1NBcUhiNlQrVnJuVXBidWdHOUJTMzF4?=
 =?utf-8?B?elIrZVpDQ0dCSllFVnAvK2ZxbS96NDJ2WE9NbjFEcDYxbk9oVFhGSFRBVVo1?=
 =?utf-8?B?akMzWE94Q3JJUStkNExHaFNWaHhzRmhWNEt2YWtWa05lTFdzVnB0c0NnVE1z?=
 =?utf-8?B?VFFLQlR5L3h3RFhLcWltSng3ODcxOUFVNW9nbUM3ZUg3cnFZZjZsd2kxbFFx?=
 =?utf-8?B?cTd2ei9ubG5ZSzNzNG1aeFhibXZCclBnRjAxZ0xUOE5DTnhnRjcrQXJJbloz?=
 =?utf-8?B?TFAzc3FYdEVQUXppUXhFZmQ2dndBUG0rR2JPYmR5T1MxL1dRVCtZTjVkaXVq?=
 =?utf-8?B?eU9UbTRTNm82ZUI0NGU3bm4xZ2t3QlFFZmgyTG5LQ2p6RGgrcHNKeDdCZlRa?=
 =?utf-8?B?aGd3MTdNbmRjZSsxQzFTbGhraWNFR1dubXVJeE01NC8veGFxU0lJOVdIejdD?=
 =?utf-8?B?T1RhTVFEaDBIM1ZUOWZuTlhyOXVlUmJQUEFNbUVBTnpTbytabnJUUW9ROVRC?=
 =?utf-8?B?Q1VjcXlERTliV3I3eExVM2tKZTlxaUhCV2p1eG51N3M5VWtPYU1xeEU1Y1RX?=
 =?utf-8?B?NE8wcEpHWDdmeVBKSVkrWkdXSGFReDRCSTFSRFdQWjZTMWxYMXdvcmx5QVY3?=
 =?utf-8?B?QmFwYVFpUHB1cjRXZjA0UkdIZmExK3l3L245c1RueUZyT2pwMXRFcEtVN0NG?=
 =?utf-8?B?QytqNHFqV1kyYTgyUDJHc2ptZkJGZ2NJcjFjbW9LT2tTOFVUWWZjbHMwQ0JP?=
 =?utf-8?B?SWNBQnJoYmF3QWZnbys4Sm84R3YrTktpMTRCWmV0NnlaMWpoWlFlQU5RK1pq?=
 =?utf-8?B?OThJNTlsVEwxZkx1UGJyejlRRXlQVHFZMFJ6dmx4Mkp0ZFhxVi8vMVphcVR6?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41436f0b-89f8-4cb2-26f7-08dba412bfbf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:54:23.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ywkxux9BG8Kt89oURTxVbZ8oLXKc2CiAecCiH/7vzozvVqxaulYGKqan9nHJZXp60JGmO19R9nliOJpaD2ygjnIdMle0Xov8Ld7k64HgKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7724
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/2023 4:05 PM, Rahul Rameshbabu wrote:
> Use a dynamic calculation to determine the shift value for the internal
> timer cyclecounter that will lead to the highest precision frequency
> adjustments. Previously used a constant for the shift value assuming all
> devices supported by the driver had a nominal frequency of 1GHz. However,
> there are devices that operate at different frequencies. The previous shift
> value constant would break the PHC functionality for those devices.
> 
> Reported-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Closes: https://lore.kernel.org/netdev/20230815151507.3028503-1-vadfed@meta.com/
> Fixes: 6a4010927562 ("net/mlx5: Update cyclecounter shift value to improve ptp free running mode precision")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Tested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Notes:
>     Devices tested on:
>     
>       * ConnectX 4
>       * ConnectX 4-Lx
>       * ConnectX 5
>       * ConnectX 6
>       * ConnectX 6-Dx
>       * ConnectX 7
> 
>  .../ethernet/mellanox/mlx5/core/lib/clock.c   | 32 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index 377372f0578a..aa29f09e8356 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -32,16 +32,13 @@
>  
>  #include <linux/clocksource.h>
>  #include <linux/highmem.h>
> +#include <linux/log2.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <rdma/mlx5-abi.h>
>  #include "lib/eq.h"
>  #include "en.h"
>  #include "clock.h"
>  
> -enum {
> -	MLX5_CYCLES_SHIFT	= 31
> -};
> -
>  enum {
>  	MLX5_PIN_MODE_IN		= 0x0,
>  	MLX5_PIN_MODE_OUT		= 0x1,
> @@ -93,6 +90,31 @@ static bool mlx5_modify_mtutc_allowed(struct mlx5_core_dev *mdev)
>  	return MLX5_CAP_MCAM_FEATURE(mdev, ptpcyc2realtime_modify);
>  }
>  
> +static u32 mlx5_ptp_shift_constant(u32 dev_freq_khz)
> +{
> +	/* Optimal shift constant leads to corrections above just 1 scaled ppm.
> +	 *
> +	 * Two sets of equations are needed to derive the optimal shift
> +	 * constant for the cyclecounter.
> +	 *
> +	 *    dev_freq_khz * 1000 / 2^shift_constant = 1 scaled_ppm
> +	 *    ppb = scaled_ppm * 1000 / 2^16
> +	 *
> +	 * Using the two equations together
> +	 *
> +	 *    dev_freq_khz * 1000 / 1 scaled_ppm = 2^shift_constant
> +	 *    dev_freq_khz * 2^16 / 1 ppb = 2^shift_constant
> +	 *    dev_freq_khz = 2^(shift_constant - 16)
> +	 *
> +	 * then yields
> +	 *
> +	 *    shift_constant = ilog2(dev_freq_khz) + 16
> +	 */
> +

I appreciate the derivation here. It helps understand the calculation
here, and makes it clear why this is the best constant. Deriving it in
terms of the frequency is useful since it makes supporting other
frequencies much simpler in the future if thats ever necessary for the
device family, rather than just adding a table of known frequencies. Nice!

> +	return min(ilog2(dev_freq_khz) + 16,
> +		   ilog2((U32_MAX / NSEC_PER_MSEC) * dev_freq_khz));
> +}
> +
>  static s32 mlx5_ptp_getmaxphase(struct ptp_clock_info *ptp)
>  {
>  	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
> @@ -909,7 +931,7 @@ static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
>  
>  	dev_freq = MLX5_CAP_GEN(mdev, device_frequency_khz);
>  	timer->cycles.read = read_internal_timer;
> -	timer->cycles.shift = MLX5_CYCLES_SHIFT;
> +	timer->cycles.shift = mlx5_ptp_shift_constant(dev_freq);
>  	timer->cycles.mult = clocksource_khz2mult(dev_freq,
>  						  timer->cycles.shift);

And you already derive the multiplier in terms of the frequency and
shift, so the change in shift won't break the multiplier. Good.

>  	timer->nominal_c_mult = timer->cycles.mult;


Not really an issue of this patch, but a few drivers use a nominal
multiplier in calculations with timecounter and cycle counter, I wonder
if this could be baked into the cyclecounter code in the future...

At any rate, this fix looks good to me.

