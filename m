Return-Path: <netdev+bounces-37118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D957B3B12
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 78616282884
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283B667260;
	Fri, 29 Sep 2023 20:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779F66DF8
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 20:15:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8867113
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018518; x=1727554518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Znfulbhq/dXHf2vmxq5KizMDoHQYLGxNRtatfmmwjto=;
  b=PztppojGwINSoPouUlb+fRAredtoog9Rki6RYk5221R5lI7d4m1ZxBS5
   a/BXde28Efgy3DWk/TIJhPVXtaDzvRjB99yiZ6sy9zBzxsFWoXL9ntCrg
   +BXEx3lCIiwmJG9d6Mv0ay5qW6sDaHeJe95VNEF2ZX+nEEvJXEGZ323qS
   E1Fl55afn2TQk2mcQyjqhdNx5Sg5rNZ4No2QvduLVmpqqymDWXhTcuZEo
   uac5k2B77n6y3xJdbaZ2PWXs/TV62JE0Pm3Qpiu+VtF0WkAf8d9LcdgCN
   D5XnnkGP/UgYmpIz3hqwbiyJB4bqZ3zWUBDEzKIv+wbkAvWVZLXiHXcF7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="367411726"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="367411726"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="873752424"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="873752424"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 11:20:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:20:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:20:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 11:20:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 11:20:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnoGMbirTNu85i4kREYgVa54kMNtbSk3PitZlThYENMXZpemqQnJZvzBoAwTOOwu8VuOPHXDF88M2oB27+J0bXXFfC5eQJik3FZ9FN+s2m1vm4Yr/yja/1Guh/4gdgQPbrtnAG2RhDSx1krVcL4hx9DtMOefaBDJ1KP/ev58NTd1m91UECJCWfJvsNT/Hf8ZeKNyQ3z5d2tg9YhlIRSPrp4tF7kWD1IlyDJUPGf7ZSW3demIeRIMAE+AOgU9wEapJBE9V9ZKpk1LNN+v5k3ci/EsJeMwSKwowtu8hbjmaxPPIDvGwkp58vwNtwtkf9ElPmpbvu28Me8l64t0eJGxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOFsrcUrjZvbh+OyhYmH5a+GWhtR465qTY57gEkQxrc=;
 b=kCIYHz2RxNCI6ADfYkzeJGlPr/PV8/LRXa4ts4H0WGQBc5BWSm/zHpW4An0uwugQv7gLh6W6kbsO7r5QpnaQFgE0+oAqsFZEHu3n+BTO74+OQgI0hceHxTYOMpOGABGdoJKb+gkGOWhhC6KlL9Yz7S8E9+Qr0cH4EK75BVkutNbKIUfsgJEJMhK/vDNGNrcDijk13gzaZzxmUObQzOJ+ryfPVQaQcmuW29qpY2Ddq03IfZPLCuaKE6rLHGdxSTlWVGgCzvXsbp1eRomqbq5Xs2YuyXfROnSYCXXfi0GxRIQqoQ2ZMHv179RH1OmlbbZS7AVFm+2WwanZOyk67AAidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 18:20:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 18:20:53 +0000
Message-ID: <6dfa1ca9-7067-ca73-ff38-0bf517b5ed7c@intel.com>
Date: Fri, 29 Sep 2023 11:20:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 net-next 3/7] net: ethtool: record custom RSS contexts
 in the XArray
Content-Language: en-US
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <97db46739ad095e0ed50f0dbd90e1b506c2991de.1695838185.git.ecree.xilinx@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <97db46739ad095e0ed50f0dbd90e1b506c2991de.1695838185.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:303:8c::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: dd64485c-c4b9-4a5b-d638-08dbc118d103
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IypRobNlHOOwwvrSp/C9LzYOT6HgMKizMskAS1dKbLvp9q4sR4x63DIylpCyn8eWLyHB08mX6mjPZzwSfg8Z8mcjGkzUuiS0GRHdqSALy48vmwj3/vY3ceurtyC6QTIcAbwM6hL+qLXVRL5E8SsEkUzC2LyvNGgLvlNbBkJAJUch5le0ZKrCyxlBlT8w27ilWvcRe/tvaKUqOA7Aoc7x8zR5yaoxVBYzBcffDMxZM3cguduMv3FGhJUN8KAfSTPpsh2fivfru7xYJztK4hRjqj51FhJ3A2gQXq13l054M0+4ItI3eCcZWE8tYxanTzHZon29roys4kNoBzfTOEhjWQhuIxwFD1coUCJoeJVY3XtEWYDOi1X0lho5fy4yBBZlaVQSZ6pjYwfOayV9zn5OD+WOslT1NktOR5/UI0wYv15EYvtkpAjxzRvP9YFOwe1Pcqpsbz1QE4g8DfcXUix4McM+c11L5qcm9B4ClaZJCw3mDpCqscLYloGslgjK1vKx/fHg6BfHxH7St8oPaH7dgrcRIBNNfOjgcS8ddm8pds98vWGId/2es6kVMjWjpw/xBYdxXWOr1BVnqIdkB5KV6yz1/+Mgl68seTH5AT18USstez3NPz7yPtr+VIkF3tQ+rYrLB7FPDscYs5XD1ytDXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(7416002)(2906002)(5660300002)(31686004)(8936002)(4326008)(66899024)(8676002)(26005)(36756003)(41300700001)(2616005)(66946007)(66556008)(66476007)(316002)(82960400001)(6506007)(83380400001)(478600001)(6486002)(53546011)(38100700002)(31696002)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dTMFhZSkpXTitZRjN6d09HK2hpalNzZXNUSlpQMG9NdHRmb1hWVEtGREpl?=
 =?utf-8?B?Q05TVTNrbXNXZzdKM0JSTndibHNNckpZRmxTbnJnVEhPNFIvZ3E1SFZYZzRw?=
 =?utf-8?B?cFpYVEIxaHpLM044UnpUblY4eUZDZHlqQ2FiN1UxL1VtUDdseDN2TlJMZkM4?=
 =?utf-8?B?Y2J4NCtFeGxhK0tmbUZMUXlZS1J3aElKY29iN0M5V0U1N3Y1V0pncGxtcnZl?=
 =?utf-8?B?eFRrRnZ5N1NNd0sySDVDa29ibjIrNGRFdEovSW5HMlZxdzVvcW9uejNWUlV0?=
 =?utf-8?B?QnNIU1hReTE2MjJOV0w5Ylo3dEVzNW1BaXBneFlCWTR5bHFuU2dtNktaWjlW?=
 =?utf-8?B?K0tJV2Rkc2JHMGxpZDMrdVJyUll3bVRuZ01yR1hOS21QY1RuN3RZbUhQZlVV?=
 =?utf-8?B?QXpyY0l6ZW5yb1NoTTBkZ0dNQUNkS0g0T3AwOFlmdnlrUG1WT1NtaGFDVXF6?=
 =?utf-8?B?U3lJQUs3TXhGZWttTGg3djU5VHV4bEc3akdmMndHYWZmTGt2TTVRQ0NlUTNi?=
 =?utf-8?B?RS9wVllSd1YwbW02aVRHa2Iydkg0Tk51UyttZjYyRGhqZVUvc3BCM2tGTklo?=
 =?utf-8?B?ZHprZ1lHd3VuSWIrNmNRSUlQbWR1RjZtRlhRckdvVFpFVUY4NUZPd242cVJG?=
 =?utf-8?B?SU9xdmlxMDRDTCtaYWN4V2wrSXQ4bG1iZ1l6SlhkbUNvWUtYbEhwSE4wdTJj?=
 =?utf-8?B?Tk5ESU9UbGp4QTRwcEl1OExheEs3Ny9sRzh4ZkhSU25vMVE4QnEwV0dMMUx6?=
 =?utf-8?B?Uk5hTHJPczBJZ2dZMHIrOXNhQTQrQkpLdG4zZ0FSc3VlTUcrc2NCRms5ZCtL?=
 =?utf-8?B?dHV4bmJERUErS1M2Z2xHMGYvNUJ1MFBGbGIzWVp1OEtsMG5jTjYzTnJ2clZk?=
 =?utf-8?B?VzQ5aDU0T0RnQ0NTOTJOL1crbncwMFVEWWlmWVRrSlg2UkJRL283WDdzMi94?=
 =?utf-8?B?M3l6OTZuNHIyQ3hpQ1NaVzEwZkxsU3I2b2NRVzB3ZHVXUVA1RWZjd0NFclNV?=
 =?utf-8?B?SE1teG02MUFRYUtTR2hnUHJudDdFdDRSRmI4OTBMSUZtOS9aSVBseG03M2JE?=
 =?utf-8?B?RHM2cjVFc1o1czdOUE5DOGFLV25naGNDZHJoTUVmbnMyRFJ1T3o0MFpDRjBG?=
 =?utf-8?B?SXRBazNGc1lwS3BVYkpOS0l3N05BaW1TVzMxOHVqVkZYcVRkSEYzai9yRXdU?=
 =?utf-8?B?Yis4YVpvR09RRDBOVDBnN0JKL3JrR0JJeDl6TUovWmVrcWtxdGtrRTc2b0NJ?=
 =?utf-8?B?SHh1eXlaRHVYM2tRT29VRmNacHJIWG10VW85VXl3Q1RneVl2MGRDcWJNcVlh?=
 =?utf-8?B?UUptOFlIU0w3b3ozV3lZYU1nTDVobGkwdkpDYWx3MUxiTWdJVzVrcHlnQmxO?=
 =?utf-8?B?bkkzcWVZWU5XZjZrOGZjeElNRTlFQXkxWEJyVXprejdiQ2l4RHYyUDZTZ1ZG?=
 =?utf-8?B?UXpQcWViQkJ6UTZmeUszQTJGODVyemZtNDBUamRTczVjM3Y5SW9vTXg3Y1Jq?=
 =?utf-8?B?T0RJSTVqakhJaWZpeCt4eHBVOUtGQjJUczAzbVhlUnZSZWVZanJVSXB5RFp3?=
 =?utf-8?B?SEx3aE1XZEp0RnBvcDg2MUZIeVBjMDlyZzBOcElHUTFIcC9vYm9EMEdWTVB6?=
 =?utf-8?B?dExZWnN1MFFkTjZVNGdqUHVxWjdFc01HSmtLeS8wRnU0L0VWck9ScktNTDJa?=
 =?utf-8?B?b0Z4TWFaQXM2OXNsVUZaZjlLMHlOVnFTTWJrVVYxa21YeTJLdEhkcEdxOHVj?=
 =?utf-8?B?aXZheUJYM0VvemVudXRrTjZpd1ZWOWRvVGJHNjlxcVdlaTd1Q3RkclJHOVk4?=
 =?utf-8?B?S3JMdnJ4T1lYR1VXUXZ1ejVFVi9MTVBsZEFyWXBKWU5LbFRHeU1YY05kSjEv?=
 =?utf-8?B?ZFNxMUdvTGtJZHB3NkdBRW9ZcnIxVC9weFJaYllNem9yMlpoQVNZTG9DdU5O?=
 =?utf-8?B?ZVVWMldpRE1VZ0RuZlJiVTJiSFFlZWxSM2FWb2M5QXJOSnJQbHlJODZsVTQv?=
 =?utf-8?B?UzUxOE1UTHlYQzFYcmZGS21CSGw5MWdUdlhWdFlEd1pSYWg5c3Arc081OTRF?=
 =?utf-8?B?TGVMWUhVbU8yM3haM3Yvdk5XZmhpZXNPa2kxcDlLcHlibWJTWHpKT0hoS3h1?=
 =?utf-8?B?RTFDUVlTaGQzb3JqaTc5Mk9UT0cxVXltQVVDUmJqMDM1TnE3UHJLVXdhbDZY?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd64485c-c4b9-4a5b-d638-08dbc118d103
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:20:53.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ih0e/O36Etsyi1vLmNZ2h5vVnUco3mdn+yMuLFtbl4CK3kLV9l+aoKPbJM8OCK2JbkJeMCixrgBiBSdTc6TAj+pkMxV/e/1fA1rkLQCxunU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/27/2023 11:13 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Since drivers are still choosing the context IDs, we have to force the
>  XArray to use the ID they've chosen rather than picking one ourselves,
>  and handle the case where they give us an ID that's already in use.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  include/linux/ethtool.h | 14 ++++++++
>  net/ethtool/ioctl.c     | 73 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index bb11cb2f477d..229a23571008 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -194,6 +194,17 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
>  	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
>  }
>  
> +static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
> +					       u16 priv_size)
> +{
> +	size_t indir_bytes = array_size(indir_size, sizeof(u32));
> +	size_t flex_len;
> +
> +	flex_len = size_add(size_add(indir_bytes, key_size),
> +			    ALIGN(priv_size, sizeof(u32)));
> +	return struct_size((struct ethtool_rxfh_context *)0, data, flex_len);
> +}
> +

Ah, we already have to use a flexible area to handle the indirection
table, and this way the core is the only one responsible for allocating
and freeing the memory.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  /* declare a link mode bitmap */
>  #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
>  	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
> @@ -731,6 +742,8 @@ struct ethtool_mm_stats {
>   *	will remain unchanged.
>   *	Returns a negative error code or zero. An error code must be returned
>   *	if at least one unsupported change was requested.
> + * @rxfh_priv_size: size of the driver private data area the core should
> + *	allocate for an RSS context.
>   * @get_rxfh_context: Get the contents of the RX flow hash indirection table,
>   *	hash key, and/or hash function assiciated to the given rss context.
>   *	Returns a negative error code or zero.
> @@ -824,6 +837,7 @@ struct ethtool_ops {
>  	u32     cap_link_lanes_supported:1;
>  	u32	supported_coalesce_params;
>  	u32	supported_ring_params;
> +	u16	rxfh_priv_size;
>  	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
>  	int	(*get_regs_len)(struct net_device *);
>  	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index de78b24fffc9..1d13bc8fbb75 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1249,6 +1249,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  {
>  	int ret;
>  	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct ethtool_rxfh_context *ctx = NULL;
>  	struct ethtool_rxnfc rx_rings;
>  	struct ethtool_rxfh rxfh;
>  	u32 dev_indir_size = 0, dev_key_size = 0, i;
> @@ -1256,7 +1257,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	u8 *hkey = NULL;
>  	u8 *rss_config;
>  	u32 rss_cfg_offset = offsetof(struct ethtool_rxfh, rss_config[0]);
> -	bool delete = false;
> +	bool create = false, delete = false;
>  
>  	if (!ops->get_rxnfc || !ops->set_rxfh)
>  		return -EOPNOTSUPP;
> @@ -1275,6 +1276,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	/* Most drivers don't handle rss_context, check it's 0 as well */
>  	if (rxfh.rss_context && !ops->set_rxfh_context)
>  		return -EOPNOTSUPP;
> +	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
>  
>  	/* If either indir, hash key or function is valid, proceed further.
>  	 * Must request at least one change: indir size, hash key or function.
> @@ -1332,13 +1334,42 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  	}
>  
> +	if (create) {
> +		if (delete) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		ctx = kzalloc(ethtool_rxfh_context_size(dev_indir_size,
> +							dev_key_size,
> +							ops->rxfh_priv_size),
> +			      GFP_KERNEL_ACCOUNT);
> +		if (!ctx) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		ctx->indir_size = dev_indir_size;
> +		ctx->key_size = dev_key_size;
> +		ctx->hfunc = rxfh.hfunc;
> +		ctx->priv_size = ops->rxfh_priv_size;
> +	} else if (rxfh.rss_context) {
> +		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
> +		if (!ctx) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +	}
> +
>  	if (rxfh.rss_context)
>  		ret = ops->set_rxfh_context(dev, indir, hkey, rxfh.hfunc,
>  					    &rxfh.rss_context, delete);
>  	else
>  		ret = ops->set_rxfh(dev, indir, hkey, rxfh.hfunc);
> -	if (ret)
> +	if (ret) {
> +		if (create)
> +			/* failed to create, free our new tracking entry */
> +			kfree(ctx);
>  		goto out;
> +	}
>  
>  	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, rss_context),
>  			 &rxfh.rss_context, sizeof(rxfh.rss_context)))
> @@ -1351,6 +1382,44 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
>  			dev->priv_flags |= IFF_RXFH_CONFIGURED;
>  	}
> +	/* Update rss_ctx tracking */
> +	if (create) {
> +		/* Ideally this should happen before calling the driver,
> +		 * so that we can fail more cleanly; but we don't have the
> +		 * context ID until the driver picks it, so we have to
> +		 * wait until after.
> +		 */
> +		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
> +			/* context ID reused, our tracking is screwed */
> +			kfree(ctx);
> +			goto out;
> +		}
> +		/* Allocate the exact ID the driver gave us */
> +		if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh.rss_context,
> +				       ctx, GFP_KERNEL))) {
> +			kfree(ctx);
> +			goto out;
> +		}
> +		ctx->indir_no_change = rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE;
> +		ctx->key_no_change = !rxfh.key_size;
> +	}
> +	if (delete) {
> +		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);
> +		kfree(ctx);
> +	} else if (ctx) {
> +		if (indir) {
> +			for (i = 0; i < dev_indir_size; i++)
> +				ethtool_rxfh_context_indir(ctx)[i] = indir[i];
> +			ctx->indir_no_change = 0;
> +		}
> +		if (hkey) {
> +			memcpy(ethtool_rxfh_context_key(ctx), hkey,
> +			       dev_key_size);
> +			ctx->key_no_change = 0;
> +		}
> +		if (rxfh.hfunc != ETH_RSS_HASH_NO_CHANGE)
> +			ctx->hfunc = rxfh.hfunc;
> +	}
>  
>  out:
>  	kfree(rss_config);
> 

