Return-Path: <netdev+bounces-44116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938D7D65AC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06BA28148E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F28D1D52F;
	Wed, 25 Oct 2023 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqmQ81cq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB89749D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 08:47:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E218E
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698223676; x=1729759676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7QQjFE6XVz1LyGkp9iNiaZOhD78W+ni9fOL+xsx3mnA=;
  b=mqmQ81cq0cY/33w1hOFy8pmVuSDlYcXinZaf2tmfPA7NY/AmVRB7Yus4
   X6b6StCwV3RH6E3MDAczaTE515jlqu6Sviwz0ZzvwlkPolidVY516YKLD
   CHN05wMt85J0r9MeBhq/AlO7XbXhZVM8FQqxEaihrLrCAsAiQHXzXOcIk
   auSGgUYOoHP5EYdqFWu0hPA2IzFWO3JsXsXM6s+En8yyNtyr7n1ldu4HK
   yaLKwLphXTdZwX8j/UJJVdxexvTAR3CLmsTMVW8QvHs9ZhOjEOpnwZW39
   nqo+UkuN2QUuRBzGBaZcFfyf/GjSwDPhJ51WrSiXEUAPhNDCJKhzHl7V5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451491477"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="451491477"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 01:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="849465581"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="849465581"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 01:47:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:47:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:47:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 01:47:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 01:47:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmmddsjjmqXYQbLKMngd7ngRuhLWeAmODRCRr2Ht886fAjuAp0dysYe/op4VMty7G7ocCe4sCeUSpSgT+kCqxK4IpmGjCB+Tv9H5u85s8xiOjTzJro1qVyNgGs5PGrIQ8h31Jo0eIsbT2MjVy4pNhVFbaRakyx6be+Nz3X53KgAmlSku9D6Lf7yE6laI68AznId5Dmib+C2cvuzaSuG8CUOdKWD8Ei1yQCb11FdlRUUWOvnn4Bj73tpxCvCUzvH9dTe8LNCQlvjVL+ez/emIT2u2TIsR3E8fdlm0Ee7+UCnMPIb0SgCnroK4UkfWN/MzOVZtuHXx+aS10rrkA5E0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9N4uLGiW8sAB4G4Fsrxa5u7iPZjTuQ+rsMix8PfvUg=;
 b=I3d6SIF7nqHa+f5iem/jcZu0uKnLyGgKFaqD5AWgonlCtB7Ld/LbU1WeAYH531kaOIK3GsRN3J3lnET1075s/hjY3exwj4oIdHNjTFbGpQgBBs/6WRc4cqoJ0fGzWns5idhwC3fgSRlDvoB+e7at1ZDVeRBGiN5ZOSuJldJGfXjtRYbYAB6Gf+qGa1BAr9i2dw952KkVsjqmQjgO0bKyV7yvXZjaQly7NLucJkt6sHppVm25l/s7T1kcFKe5j3QN/R7JM5w/z4f8YVAcUmQNYxuhOl9QEzYNHKKTVUvojLMNFFt/j1qOf6VML1jpjwl1ijy/jl4AJAuEbzmGXYkrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:47:10 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 08:47:10 +0000
Message-ID: <d8de399a-c063-4078-b0f9-068747f27183@intel.com>
Date: Wed, 25 Oct 2023 10:47:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] nfp: using napi_build_skb() to replace
 build_skb()
To: Louis Peens <louis.peens@corigine.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Fei Qin <fei.qin@corigine.com>, <netdev@vger.kernel.org>,
	<oss-drivers@corigine.com>
References: <20231025074146.10692-1-louis.peens@corigine.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231025074146.10692-1-louis.peens@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0041.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::27) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: fe49664e-0d17-4b93-c867-08dbd536fa00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHdi4im/0s+IQdodHUl6cFGtlTqAP6XUbDIUdybmqe/uBgzfbWtxkIL2Qq4xMp1xpJ1BvDtxeVGBWFf+Y0kGfvbLDlPx6TDuk/KWess46VZuPQ9OP2p+C7k2J4TbUc2vTNMxtJO2AbFgZZj1Hl0dCcM+TT7QPU7TYsLgySO6lBSmOmP8meAzEaoyNIyamgykqtBZUZ8GQnL5x7LNM8QRzhiEusdArE0Gs7Q/mtWpgbLDkC9RBcqtJ0vEfuxtjtjpAAjrVLShFcwIOMk1oCAGyf6cQHxcf4OEQrzL8MTCU1G1P7yIa16neWRV7XMkbWIJQ0cUQEW04+aJNLglw07ceHSEqdBf7bAbN/0e1TZ35FKWvQoXi0S1pNhVSwNmF69PSeBrxFuGIwPgdKjEPohcEFnTbQZphxnP6Ft4cEysCaHX2ANR4V6nl9wX4UAlxZBpSxpP5Q2G0J92Ov6eH6vlTpx8cWwv8QHcrS5sBQOQTkbMvR0Nw6f7m0ggcgZErLZjMPLfheAD5ZJJ3jtzfWdgqcV4QmaTYzxELOPysISTKm+e/8MZa5XmgmOoLOPPdIpHg51A5nZBP4lOLfk3bzcspVvknlf2ZQBTMjh4n8Sf5JO7vKsboxmR6B0KgWgs5ItLTUal2AutA8TqTrojd5cdQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(26005)(2616005)(6506007)(6666004)(86362001)(66556008)(66476007)(66946007)(110136005)(478600001)(6512007)(6486002)(82960400001)(38100700002)(83380400001)(316002)(8676002)(5660300002)(36756003)(44832011)(4326008)(31696002)(8936002)(53546011)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk5ibEhyd2Vyb3c4dUxIK2F3TWgyTDRZTFB3UnNVM2ZaNXpTbjBxRXdTSmFi?=
 =?utf-8?B?cGN1Ly9DNDlIM1RDRmk4MEV0Z2grT2xXcUZJVEZjUElJbDVJNmkyMVBEZHBh?=
 =?utf-8?B?U3BlSmJIb3pMdTFZQk8rY2Uvd0FMUGZlWlE2R0pPaFpGRnJ6SzAvRUZEMVB0?=
 =?utf-8?B?OGp5c3VGMmgwN2JFd0FGN1A4SWlRaFZibXlsa0hZV0dDWWhCVy9TTlRSQ3Jq?=
 =?utf-8?B?ZUQ1VjdoR0daY043VDlCTFNxL2MvZlk3RXM2TXlDaDBRWWNUamJsdFhSQy9j?=
 =?utf-8?B?dzhaS1hlZ1lwZVNGdTU4bDJvUU44azk1TXVwRzVUYURJTzM0RmJLek9GaUR5?=
 =?utf-8?B?cDVkSEdDb3ZIcWVGbmlTMnVSNUpKRDdBekNWUGFydGpDUkN6dkM2NG1UZWsz?=
 =?utf-8?B?eVZhN0VhRzFWK3lCN21PYXplM25vUnFtUStJSjBna2pIdWZod2VMZmNhWnZ6?=
 =?utf-8?B?RENwTTNwT0ZRTnpMODdDdG9RaDFqbHRqRDNuUXcrYUZCYWl5aDUwajc5ejdi?=
 =?utf-8?B?S1R3Qy9mWFRzNjlZOEVCMHg1VGZMcmFTeHk5NWtpcld0bXFLSllVNzVxTldp?=
 =?utf-8?B?Sjg2UTBVOEFSSS8zUVFSb3c2ekdmVy9CTHFCOThwbUtTc3lrb0xib0FkM2p5?=
 =?utf-8?B?TDVtSXREaWtXV3VjUE1EeVNNbFJFZXVSVitwM2k2Tm1RaDdkVmdtN2RiYTkx?=
 =?utf-8?B?cHJseDNuOEtGZTEvR0RJenI5MjJGN0c3K1dvNGwzcVJhcDByYzVwSzVtZ2lR?=
 =?utf-8?B?TUJaN2JFRmVTdjkxQWtWa0ppdEExcjhORHZOakNVL0FiaUVlREp4cDUvejRH?=
 =?utf-8?B?cmZpSXJzajVKS2dCb1dhdXp4MXR5emVid1JIOW1MOXM2cnBGamExOEttWjJz?=
 =?utf-8?B?UjIybVBCZjFJZzBva3piSGZGdU5HcmZ2RS9FVGUwVTFmSnk1b1dURDJ4a3hB?=
 =?utf-8?B?bFRRUmI3b0w5dThyelM4MEM4VWFzYWIwSnJ5T3RJWjhveWsyQUtpZDFaTXdP?=
 =?utf-8?B?eVNLN3VNaGh4V2xyNHhudk5FakRmM2hFWTJZZWZ4VWNnOTZ5Y0VsMFRvL05v?=
 =?utf-8?B?cW9BZmRJYXE5ZEJsNERXeDNPenVGRWtUN0ZQczlLNllKdHZBZzg0Wlo5OFJG?=
 =?utf-8?B?UTlCajM0K1VFemRCK3hSMmNub3lZcCt6T09kODV4dDR6aFFkLzcyYU4xWnpk?=
 =?utf-8?B?bGxweVJBTjFkS2RMelN6c0xJUDI0VHVSaWRJVis4YkM3WE8yY0Q0U05jYW5K?=
 =?utf-8?B?MU00RThBVitYcFBWQU56M3czMndkMUhZZE51RzdWMWZrbllOL2FTaFRZU3FG?=
 =?utf-8?B?VG0xSldtN1lBL0Y5ZU1iOVNvd20vOVRKVWZ2d29BK010K01SZkltMEthRnFS?=
 =?utf-8?B?Z1Vjc0VNa3JybWt3bndZUVpzNmYyY2dHWjN6N3BWVk9JMWYxTkJycEZNb0ll?=
 =?utf-8?B?aitXUnlUeDBZbGFMcEtERFR2L3FJY1dqRUFsKzYwNUZsTG51MlV2UU8wa0VQ?=
 =?utf-8?B?ZE5tYW40RXd2Y1FjcWptWUJOOVhOSnB1YTVXNHYxVzNrM1kxc1lNQXY5N3Bm?=
 =?utf-8?B?MGYvMEtLb2JUUSt6NjZsZVpUcU5PSzBmbHA5RjhUMEpFeEhZVjhWSG5oYVQw?=
 =?utf-8?B?WTI0ekxaTVBSQW4zSnZMM3ErWDhscjJEUkJUclVmaGtDeStzVUZCNzJuQ0Vo?=
 =?utf-8?B?N3A0Rk81UGJ0N0RJcittcnNoWk5nbjJUOG4rc0NtTnorOUNVTFM3OFZCVlE0?=
 =?utf-8?B?Qkx0ZHpjNUxlOUQ4amh1SUpIK084cy9NSTVRam4vUE0wRmE3WTlrWFQ3RS9O?=
 =?utf-8?B?c0dNcVNhRmFRekQ0bGRwSFllcmhCRGVPVncvUUZzL3BIYzVMZ0RySTVDZEdB?=
 =?utf-8?B?eTRUR2V4REFjV3FGY3ZFZzZ5T005d3lxNUFWUE55eTNIVm5jSDA5Vi9RbCtN?=
 =?utf-8?B?MGkzTVRCT3E0MC94YWJkQk5kWGcvVjNNb3pkbXBBSVZ5ZXloTkVnRERNb3ho?=
 =?utf-8?B?WlFYWEl3MFVNeHZKd2swUXU4b2UyRno2c1dSekJXeTZUSkhuRHgzSlBZbkdI?=
 =?utf-8?B?OHhGUHE0SjN1bE9DTHhNblB4Zk5yT0ZjZWNxeXlsTlVSQ00yMk5WaW02WUx1?=
 =?utf-8?B?QmY1MC9QUkxTK3JKT1BYWjdPYjU1N0pSMzZRbXF5RkxrU25CcTFPanRLa3hi?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe49664e-0d17-4b93-c867-08dbd536fa00
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:47:10.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71k0tQibO2G/xTKmOy7M9Yt6aTrdRQsZj/LWO3mLzs4yfn00QIdPMF5M99kB6VbNLewXvFAx4+8xLuz5KfJNvAE0KZcz68i757/E3saOmTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7164
X-OriginatorOrg: intel.com



On 25.10.2023 09:41, Louis Peens wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> The napi_build_skb() can reuse the skb in skb cache per CPU or
> can allocate skbs in bulk, which helps improve the performance.
> 
> Signed-off-by: Fei Qin <fei.qin@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfd3/dp.c | 4 ++--
>  drivers/net/ethernet/netronome/nfp/nfdk/dp.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
> index 0cc026b0aefd..68bdeede6472 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
> @@ -1070,7 +1070,7 @@ static int nfp_nfd3_rx(struct nfp_net_rx_ring *rx_ring, int budget)
>  				nfp_repr_inc_rx_stats(netdev, pkt_len);
>  		}
>  
> -		skb = build_skb(rxbuf->frag, true_bufsz);
> +		skb = napi_build_skb(rxbuf->frag, true_bufsz);
>  		if (unlikely(!skb)) {
>  			nfp_nfd3_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
>  			continue;
> @@ -1363,7 +1363,7 @@ nfp_ctrl_rx_one(struct nfp_net *nn, struct nfp_net_dp *dp,

Hi Louis,
I'm not an expert regarding NAPI but I think napi_build_skb should be used in napi context.
From what I see nfp_ctrl_rx_one is used after calling nfp_nfdk_ctrl_poll which is scheduled
using tasklet_setup, not using napi_schedule.
Am I right?

>  		return true;
>  	}
>  
> -	skb = build_skb(rxbuf->frag, dp->fl_bufsz);
> +	skb = napi_build_skb(rxbuf->frag, dp->fl_bufsz);
>  	if (unlikely(!skb)) {
>  		nfp_nfd3_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
>  		return true;
> diff --git a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
> index 33b6d74adb4b..e68888d1a5c2 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
> @@ -1189,7 +1189,7 @@ static int nfp_nfdk_rx(struct nfp_net_rx_ring *rx_ring, int budget)
>  				nfp_repr_inc_rx_stats(netdev, pkt_len);
>  		}
>  
> -		skb = build_skb(rxbuf->frag, true_bufsz);
> +		skb = napi_build_skb(rxbuf->frag, true_bufsz);
>  		if (unlikely(!skb)) {
>  			nfp_nfdk_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
>  			continue;
> @@ -1525,7 +1525,7 @@ nfp_ctrl_rx_one(struct nfp_net *nn, struct nfp_net_dp *dp,
>  		return true;
>  	}
>  
> -	skb = build_skb(rxbuf->frag, dp->fl_bufsz);
> +	skb = napi_build_skb(rxbuf->frag, dp->fl_bufsz);
>  	if (unlikely(!skb)) {
>  		nfp_nfdk_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
>  		return true;

