Return-Path: <netdev+bounces-49811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27EA7F3854
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A313B2161D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289C1584E1;
	Tue, 21 Nov 2023 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tbdj2EiT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818AED49
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 13:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700602274; x=1732138274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yBU8hUGbQttJDBGVTAW4sZbkx+CxLS12V+qWOsNcNZg=;
  b=Tbdj2EiTDJeXZRYJ0+UowLMqB13e/fUTMU2jdii6GudkCWzNknaS5A5Y
   4ow/wTflHEarsU9n73E68hRMA1MqWWAaSMoj6N+CgEk8abi20PHBlax8n
   l2HjAs7RowvLcJNGAgvZLKyk+QUxzxT8iA5gwLjkVbwYphc4m4v4rt/FU
   54tDKEs8zTqHHgj/MlNmn8Rgzqzy8zIz7FwhCcOfFDN7EAC+Olni++we2
   CCPfVtF+YqOupdMjhnnrxSjIQ5xuJF6kNjkGCUgVY2dvWRptMBd0WDrZk
   Svm1ipRAe3/WHwdmJadFe7PqWYZXY4Ut8URHKHTftzxG8o65Ifq5neqL+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="390788807"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="390788807"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:31:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="832794343"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="832794343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 13:31:14 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 13:31:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 13:31:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 13:31:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTJWF6r/Apsr1NEfXeQWbEzeDzpq8D4/0HnvPpNljxioFMcMaJ63DsolYZlZxFL77ZFI9paoXxIHlQBk3wTjl/ufM3kRIl42O9TSkJVLF2+BsDeLAARF6P5T6w99sxZf0Csb4Q0Orguw5bzxBPvps54F3N0brnEFXkg89gg2GUR+DoBx3dNc8eH840bqecIo670VpnWRlW6TrWDcbAzco85YV5niWSajoc1qTDrYfwqGO88bPCrD0arcjIxXhNX9CBc5DKKIPNf/7c3ZAXlvnccyZk7pQIuuwoblwfMHikxiwJow5hrARSn/Ar4b7CdNR2nXINrBYahsz4OSnyKTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGQocWwSe1QY0PRHos32EiBgnf4xG6xTGSHHPqs7Qxk=;
 b=CZ/aX8YBnxKGtWv01WUBioNbmvkiv+Lnl1Ahr/97TZ6xSPv0dws1WyINISQ9bbH1dKu+OxM1RnSnnjsVnBbsZvg6kHwcl2O0GW9WTFvsLFZQWp/b2PaEj9Ic4NBOUzVvoLvX6yVzJXtrGCVwwTxfAcfKuUXnGJR/AmeXuN4mtUofOOTJ21/c04oylfMHPA+B9P8uW7wQaOVepDwuE/3YD42wXUE3OP/49+MFCTaFKRfL5nqjeX6HEmslfsen/6WToHL/2TC8rd1fvbYM7b4lSZIeOdd2YZwwIyVDEgS7YSx6G0wzu6tTwd7pWYu4vFQWUKFcry+TC6eXdHRoLZ788g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM8PR11MB5654.namprd11.prod.outlook.com (2603:10b6:8:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 21:31:11 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 21:31:11 +0000
Message-ID: <416f1dfd-c1db-428a-a8b3-4cb3ceac8505@intel.com>
Date: Tue, 21 Nov 2023 13:31:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/10] eth: bnxt: link NAPI instances to queues and IRQs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <michael.chan@broadcom.com>, <netdev@vger.kernel.org>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
 <20231120235611.788520-1-kuba@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231120235611.788520-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM8PR11MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0a67b3-df3a-45ab-e9eb-08dbead92e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuuZHlSsenz8LR/MIMZL7qXBaHBRrCQ6Xl6kia1ccvMsm9xieFYfZIsEPE9HzMEp1Q3LCc5i/ItAQRfPLYdeugRN3DKcwnKsO4PJTXxV+mJE2KwuS83lFB2azutBzRl/P/A9TJnlsNUn5LMASuMbjzyoc+kGCG+chl7l0kw5m54TM3KTZkAd5eSzaoPHpjWPg4h0OpiK+7zCjLAvdA9LrCMCEAEE3fJzQnHNGwoq6SwVfTURbLLMMVuIK1TnaQThghPiuST9bP8DzxU+S9Cz8VRhPU0tllF7wNEoxeUsbpQpYlishV3EWKRIk2NH9VXQUMXfhDN6WOw++j/DL/Zk+M8eHgd25fci3reIKfSKw+gdt2TsiFqr+rdSq2O++OzlMA8F9C64b+H0bxTMSyfXc+O14mhN+md1eZY8nKpKYBLBAl1L6sThVZgjae636eGzi1yDCRrzZQAajYTpecdhSgYzXBEQ1HQc/Z3njIMbQ/B4ai0FiwuyTQeVCp3a7pkRE52v5F3FM8jbTUXTi3qDpLhxa/1lr9xIQsUOJjiJgN1cODzCCFxgoj+N10eI8rmSw1lOv3fAHWJTlBGBaF/OR+1App3eJ2itVuQ+sCMNjUWpq0fxgQ3TIYU1iHepa+yASRSE1rHisz4HoBC2QBG1uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(36756003)(31696002)(5660300002)(86362001)(2906002)(53546011)(6512007)(31686004)(83380400001)(6486002)(478600001)(6666004)(6506007)(8936002)(8676002)(2616005)(26005)(38100700002)(6916009)(316002)(66556008)(66946007)(66476007)(4326008)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEVtR3piSGVjODRuSFlxQUt4TDlLMm94Y0p4YWcwYnY5V0hZVEhqNjZLaU9Z?=
 =?utf-8?B?UXBZVkhkTWZkZ3phUWF5RFZEeWdDaVZtWEdIZmd4SG1uVnBFSzdlZmNXa3h1?=
 =?utf-8?B?c1I4ZFhRNC9ZcE9ycnlITnpXWk5NR0U2dW5zSjM5ZHhKMmFXWTlad1ZhVHYw?=
 =?utf-8?B?NzJXKzBkYWF1VEl2ZEM1eDZnLzZ1alVOS3FxRTFxYm1SSGZkenRZZmVUMTFM?=
 =?utf-8?B?UHRpVGdnaFlXSzdYcnJ2aW5rRXhqVytscmVnYmhpZ1hMQ2QrSmt5a29Vd0Fo?=
 =?utf-8?B?YmpWVUozMFNuVVJqbUxaRzVDNlNpSVZSNWVpZmkwMUx2MjJvSkp4L1ZCV2R0?=
 =?utf-8?B?YXdvMzJsQjQxdHArenNmQTFlVVFwZHRLVWtWVHVzVHVDWlFjQ1lEQXpoN204?=
 =?utf-8?B?Q0Jja0h1SFg4ZmdidTdHbmprdWNocWZ6S1M3K0dQNDV3NnpmaTBBTkRlMjlJ?=
 =?utf-8?B?czFobGwydkk2a25FZ1VPVDF2eTA4dDNmVnlCRFlYK3JsNXd2OW5JcTJvUGhl?=
 =?utf-8?B?dVI1QldZTGlhQWFzaTNLdVZQYjZZNy83ZHQrUW53dEJ4Nk1mcTZ3ZStkNUM4?=
 =?utf-8?B?RkpBTHU5Unk1c1A0UlJrZDZUNER6dVB3dTdyNWRGTzc2UFBwajQwWGR3YnZ6?=
 =?utf-8?B?WkpDd1lHbHFaNXgvcXdhRXVveFNBU1BldytiLy82NzljVUgrbmY2c2VlMXZ5?=
 =?utf-8?B?NEFkcU1sbksvdkRFR0IzQUdtSnh6VmlmU252NFd3aG42Unh6MWpiWi9zeUxa?=
 =?utf-8?B?U1BDdTFMKzJHWlduQVRBZnd1VW82QkdzTFl0OVg1KzdYa3k2bTZuRXBvY1ND?=
 =?utf-8?B?ZXlDeFBiMU5jSzg1RmZncGFxSDViWmNKaHhLTmJRMDV1ZGwvSVhyZTg4U2dR?=
 =?utf-8?B?SS9LZTFOQzIxOHNRRm1lMVVXdmppNnVqc1RIWVhUVCtYWHhtVlVjUFhCZ2dh?=
 =?utf-8?B?eFpjcll5U21TWlEzRWFQbm9CcHQrYTR1YU5nbTFwUG5zU2hpVFNRZFZlbWNt?=
 =?utf-8?B?UjZXRzNVdEJrQ1lWNXBMT0lRYzRDQ2YrZzRBd3R0TVNjWHNGbG1iS2Izemh3?=
 =?utf-8?B?N1RDdDJqcndjNjhlSklnL0xxZkcvbWpjUkloRlNCOEJPTVlaVUx5ZTJIdFJt?=
 =?utf-8?B?VExGOUpUNENxVG50N1g2VGRRNmZKQVVQaTViUFQ0cm43dFNLLzF6RHBaQ0pJ?=
 =?utf-8?B?VVBiTytKbE9paUljRmkyUmVSaEJPTEtmVXJSejVPVi80NW4wOHpCMTJMWmFj?=
 =?utf-8?B?bzZleG5Xc2c4dmRkTWdzVHhlUVRlWGtvVE1ubUNWdTgxVzdvdU9XL2EyN1pX?=
 =?utf-8?B?ZVVEcUh1MlJ4dmowU0grbVBUMW4zQVNtR3JvNFF0MlpUUlVwbCtpemdYdEEz?=
 =?utf-8?B?R3ZyOU1wdGtRNGtyUG5oc3FFdzJERzNhQVQ2MGtkQlI2NFllYzhPZEZ6WjBl?=
 =?utf-8?B?dmozQ0Y3WUZkSE9WUUNQaEhneUkyZEhFdmxPQ1NBVG52QU5QclRmSEREb1l6?=
 =?utf-8?B?Mm90bWNCMUI4RFkxeS9LMW8wOWNYL3FGNFJoOC9OT3R0ODNIUkRnYzRnVHla?=
 =?utf-8?B?YzRvNXRXcExOelh1blF3UWRRMjByOTh6bGp3OWNDREs1RUMvNU1yVFFkcGFr?=
 =?utf-8?B?ZWVVRkRyQ2F4Y3JkRlRMa0w2SHQ5dlZzNzNDcFZLclV1eDZ0d05Ec1VnZ1BR?=
 =?utf-8?B?WDlzQ2ErdktHdjgxVWJjL0JjZERoWFlSQmg4T1A3THNiS29EeXZYQzQ2b0Ji?=
 =?utf-8?B?bVhvZjZieXkzZjZRZzg5RUxabFp6bXRWQVU1NmV0ajBxeWdKYS9NZW00UDk5?=
 =?utf-8?B?cXo0SkFTVVl3VzkvbTNSQU91N0dqaDY3dHFpZ2VlTWdDN1dBbHFWSUN1bHZM?=
 =?utf-8?B?ZTdXMWpPSERST29XVnRsalZuS3hjVHl2MFVNdWRCMHpzcnBEcjRhVGRjdTg0?=
 =?utf-8?B?NFBBekh5c0F2OXBobEphWTM2TUM0ZllkdXpaa05nWjArUDdUVmVxZFVjK3Vz?=
 =?utf-8?B?TzJtdFBaczNheFN0TkszNzVwYXc3dFBYbGUyeHpQck9nb1J5SDI1bUg3L3cv?=
 =?utf-8?B?dTlnZ1FhQmN3Y1liTEwybFVNOEdodkthYklpUEZRZHg0VjZKdUZNMTA0d0JP?=
 =?utf-8?B?c3dMby94TlJVL3JYd242dWxocVNVRjc5b0hiNWsrNEpUbERyeEczL1N0U3hT?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0a67b3-df3a-45ab-e9eb-08dbead92e57
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 21:31:11.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfZL2uxAMCkWXYVkKkhp3lJ7+WTJKj/3RhUU6hoOVlXVqdITpA9UMNYBcsKQdphzClUh4ggERDTVhTZID1+emwgXSDWECIHgfhSEGQjFqPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5654
X-OriginatorOrg: intel.com

On 11/20/2023 3:56 PM, Jakub Kicinski wrote:
> Make bnxt compatible with the newly added netlink queue GET APIs.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks. Will add this as patch-11 to v9 of my series
(Introduce queue and NAPI support in netdev-genl).

> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index e6ac1bd21bb3..ee4f4fc38bb5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3835,6 +3835,9 @@ static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
>   	ring = &rxr->rx_ring_struct;
>   	bnxt_init_rxbd_pages(ring, type);
>   
> +	netif_queue_set_napi(bp->dev, ring_nr, NETDEV_QUEUE_TYPE_RX,
> +			     &rxr->bnapi->napi);
> +
>   	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
>   		bpf_prog_add(bp->xdp_prog, 1);
>   		rxr->xdp_prog = bp->xdp_prog;
> @@ -3911,6 +3914,9 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
>   		struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
>   
>   		ring->fw_ring_id = INVALID_HW_RING_ID;
> +
> +		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX,
> +				     &txr->bnapi->napi);
>   	}
>   
>   	return 0;
> @@ -9536,6 +9542,7 @@ static int bnxt_request_irq(struct bnxt *bp)
>   		if (rc)
>   			break;
>   
> +		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
>   		irq->requested = 1;
>   
>   		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
> @@ -9563,6 +9570,11 @@ static void bnxt_del_napi(struct bnxt *bp)
>   	if (!bp->bnapi)
>   		return;
>   
> +	for (i = 0; i < bp->rx_nr_rings; i++)
> +		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
> +	for (i = 0; i < bp->tx_nr_rings; i++)
> +		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> +
>   	for (i = 0; i < bp->cp_nr_rings; i++) {
>   		struct bnxt_napi *bnapi = bp->bnapi[i];
>   

