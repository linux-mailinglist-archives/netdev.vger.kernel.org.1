Return-Path: <netdev+bounces-32968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48B79C119
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA4C281285
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B9377;
	Tue, 12 Sep 2023 00:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB226361
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:28:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D251941C6
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694478285; x=1726014285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K6X3b3Lp+T6wU3Mnul22sCB0O4Jqhrga1kc/PyIFBJs=;
  b=YdeO+kUAL62Hy8sVj1D9iLWHHhhTST5U9ZNhQGd/EIhi2C2L1nNROTSz
   5bf/Xqnxg9ZC1Cw8dMrVQCEKs9EAKV0Ddk1l4DrMGy/RD3Xxc/za7IqKp
   Ds9EkkXG+rPEmSvQeMZyU5LpypfaCVSnabGOIFTt8M/mob0bk9J8l4VJS
   3LHTGN0TYRPKjwHpgVjGHh+0388Yo//k68yDsUZ4LrDxokhhAG4+Z9J7G
   OTkKjCpG9wX8loA8LXrdlVx6iCnZ8whzsau9153idBc6AnozeNBocYCtR
   Ae655uYvKe6xGDjWbiqVeDdIC0xJzfwSFWBktYvjssk3Uixojq9EGUTUU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378147678"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378147678"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833693617"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="833693617"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 17:14:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 17:14:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 17:14:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 17:14:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 17:14:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTTDr5M5100YyY3tmOIhrHvNL2H1XAPORKHpPHnyKqos1hr6HRjNa5A5pMiFWU7OJN+QEGNbvU8/5CYK3xQfHF1d1Eb6XNQiA6bzYPqzOyhH61YUX+GBh2YkBDxy02TXdWw2rIf67nBAPdQIgOgT3V/pX8jfVE2jjTba8P5Ao5xPOy6QMQA3LtyiD05fynweYSXr/C1MCrzgD4qhKBtwGkwJmp3vebzOvIrDgal8EdXPN60gBCMwXwcl8yC9jfI51J0eGX/0k1OUPizFC6zspxGlJ06w12cSaJsZvEiUvuUPGTR0S2mif5eCQwGztjTGMMAgo7ernmQA/wJHt00aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpmSnOCFGeBd6Ag0/QJOjVh/oi1rXSp90Ef/o/bVF5A=;
 b=X+fTfJFxfKPyzAVQl59sQMH10ZiO6rQm9YrZEhOTN5cW3MEvJZH49nI4lIyG6FYu2dhLuGw2jEYxa35iwt0/B6Xllpub65wBvCmPPJGFJFS2LZIKFPQvHbY1OG+ia0MDWbl+Kc6Rm5N+YsTnCKmtW5rp9ZlM2UHZPtKwMnUlfNpJTkAKy7NV5FC3zcofk6EBRnNFyZ60mY2DmbahLPZeOPPyxHbRFbm2maimHgBjot5nQmtFrh0rjsikOG7zfp3qOorsHsIYCqF5zO4OaL+RYMabQewVlqsiDeLXhl+a7Et7aBRN3yv9b2LGhk4zHrCsz3/IlEo01vzmEEZkWSkM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 12 Sep
 2023 00:14:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 00:14:43 +0000
Message-ID: <943d2f39-b933-b77e-fb18-4c695c1c4bf8@intel.com>
Date: Mon, 11 Sep 2023 17:14:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
To: David Christensen <drc@linux.vnet.ibm.com>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <drivers@pensando.io>
CC: <netdev@vger.kernel.org>
References: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW5PR11MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7f6cb9-256a-48d9-efbb-08dbb32543d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HV91/AWqEzoRuBPYm6WSuFvMarfdNxgERZWRarSmtYEQz5JQa9ARt1SedBQLxFnH2uh3D497ZjWNspcWwDuF8ueac42yUlAZvvcgrJ5ujbCHVZp0uatbjyNPfGmp+DPHPZj9CuSnrjyvMPfP1Yt6qQsibgr6sr8m16cVZzSXGryIU1utL8Ds9tC3RvuWIRqZ6FQMfLbvL3DYI5r+rJ+U4MPSQkaS0aT3gHSt8cu2vhAO20L9l/TzCfZJ8VSOqWiuIGTsgTRZZ3khfcrRl09w2t4GpPfpy3FyIHSQYb9ZRZehjmgDa0OoLcWE70z+I9PxFFgj6c2RgnUY9ZALhPNWLzF4NjDedAylArtPMjsITvyRhcUWw99vOxPwdefssa5BqcJEmfMYl6ylhCco5WYlUHSETtzXJJTf7UNKOgfpuDJ7ewUL/8uZcXRiV6BCL0OhEYQY/AA5gMO4/rs3TvJpv9OS1arXQBnQ8xyXFK6JBOpzGPsdL8IEmRrpE5cmVmFr7SPbSGcKhEdT6uVplyF5oNly2yvNrsDtJK9nVo5vryPnYCxQD2SnMhr45zeaZVCMJ9W0hjt5VCxe4Vj1WKaA6/TUawy5nFBcKgnYGP+eJ8xpQoxFwbmLky4Jnp60Iqi2S1yI/ug4Vrtc+cEGXW+wJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199024)(1800799009)(186009)(36756003)(86362001)(31686004)(38100700002)(31696002)(4326008)(82960400001)(66556008)(2616005)(316002)(66946007)(6486002)(41300700001)(8676002)(6512007)(53546011)(8936002)(6506007)(478600001)(26005)(83380400001)(66476007)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3BpRkgvTGg5NCtNWEFaYXBXRnpiT1M2Zkl1bWp2ZVNwQ2E0a1FaNmhvR2NG?=
 =?utf-8?B?MEN1c1pRaEE4K3RuRE5hYkRGcHUwaHpUaVh5MWZKU245Rk91Nkk5eStSWGsz?=
 =?utf-8?B?bTNIUlV4WUxVUFF6blkxemxFTXZ6TFAxMmRKbFJiVHR2QlNmUWQzZ0R4Y2Zn?=
 =?utf-8?B?NDJ4WnM3ekM2ODRwZkM1M2RiVElBV0V6Z2p3aXk2dVlLUG42K3RXbmhwa0gw?=
 =?utf-8?B?ZW1pNmswN2lVbERDKy9YTUhxTGVpTW13azU3ZzJBNlJSd2JEQVN3LzNwaVdD?=
 =?utf-8?B?WVR5cGRDeUNIQklRbnJBVVlNSWQvRjUrWGhWT0hjUWdSTVdMMmJYWUpRcmRP?=
 =?utf-8?B?ZjFZK0Q3dmo0bER2NE1sb1BrWlkyUzlFWXRia21PcThsS3VsNEZUajRwcmNo?=
 =?utf-8?B?bWY2MGRzcmtEVVpFK0l5YXY5bzA2d2JrMi9Ka0YvNjBnVXdMKzFVZ1JyZHla?=
 =?utf-8?B?a2pOSDMzZWQ3NmIzdHF4Z1QwczgwcFRtaWVULzd4VGs3UEdGaVhnakl2RGlt?=
 =?utf-8?B?bXErUVE0ZnVVTGdBOFVMT0dyMW9RUm5CTFdvSDFUNFdHTjRKRWlTUXFEbnlI?=
 =?utf-8?B?SjVmU2tPQTBORWZ3ZkZyZkQxMmtpTkhtblAxeGlLYXo4TGc0bGZXWjFOa2Yv?=
 =?utf-8?B?L2J2cDltOXlmcVVZOEV0d0xuejBzc09QelRxbWJlelFvVUZJdDRKL3dRK2dY?=
 =?utf-8?B?MTNUTWRNS2YyRndYOUZPUEFFRVBQRmE0VHRhSFNaRHM4THpwbXRjOHBGeksz?=
 =?utf-8?B?Sno2NitNSTVQeHdiRVNmTCtkNXBvZjFvRXdhUnNMOHN3TjFkaG14ZDV2TGh3?=
 =?utf-8?B?WVlRdDhpYm95Z2RkWURxQ082V2k0N25URG5ja1ZsRTIvQ3RZd0ZDdUY1Vy84?=
 =?utf-8?B?QytFZEtKbEd4cW90Q2VMVThVVytORC9NMGxGNlRiM0tCckx2MW9LcGNoRmoy?=
 =?utf-8?B?ZEEzcjVBaVZNNmtXTHpRYUI2YjI2d1d0WHlqeEtWa0lSQW4xS05QTjdYM3Q2?=
 =?utf-8?B?bmg3dHEyMDlXbHVMbEdmVzJuSzF1UkRqd1F6OFdWV2dLUUN5UzYzMmNPKzQr?=
 =?utf-8?B?cjVoWEltRUZoQnpaYUNWY0MyNFBXd1dYNTN4VG1RTEpvejY4cFFxaTBtRGdQ?=
 =?utf-8?B?aWROdWNXNFlHWStLQlcyUURpc3BFdWtsYzZ3ODB5OXJBYnd5dzdxb2gveG80?=
 =?utf-8?B?TzYxOW56ZHg1SWkrazlGWkFPOUdWcEJhSzJtcWd3M3JBQ3h2R2t0c1BDS0wr?=
 =?utf-8?B?RGNSSWkrYWxIc1ZUTU9CbTg2VU1TWVVkSWZERkFEQ3RkWnV4L20yVFRiYk42?=
 =?utf-8?B?cDQwMWlzTUVVNGEyT0p4WjFLZjRNcWhja3Z0NTNxYUNkMFh0aTQzaWs2YmQ4?=
 =?utf-8?B?SHZPRUtJRW13Uy9YbUZKY3JlNTFwNDVzRFUyNm5VTDFCcnVUanpDYkdOVXdF?=
 =?utf-8?B?c0xKWkg5OERZV2cwb2E5bGd2N1VMTm1ITHBhdVNMWUZLMkhMWUV4N1FTenQw?=
 =?utf-8?B?U0RCcVNaZ0VvNlJlOWs3RXZPMEYzL25wb2JvcHdVRG51a2JBcVJ2M1U1aHdi?=
 =?utf-8?B?SmFYK1VZWTNUZjhoV3ZnUWV6YXVMd3V2L3cxcGtYOHJmWXU4WnVzREZYUnY4?=
 =?utf-8?B?eFkrYUFtUnB4K0U0YXNUSFc1WmcvOEUzMEIrWE5tVGliaTEvd1REQjBpTk5l?=
 =?utf-8?B?MzNHVC91dFZNNEJkc29qbnhIV2JFdFhBWGFxQjVLT2dyYnVSY3RiYm5PWXdu?=
 =?utf-8?B?eGFWMktoVzlmUjFlT256c1I4Q2p1cGVoVTFnc0ptU2VRRXBFU2dqNUJrWTE5?=
 =?utf-8?B?TWhlTHBzaCtVc1hCOW93VkUzZEpUd1VRb01zYWZrOWlDNlpJQXBNYmpNTmhz?=
 =?utf-8?B?SGhlVExUZERWUE5vcXpMdFpnYThOL290bEt5RitydW43bktnc2czU1MyTlUy?=
 =?utf-8?B?YnVKa2hHcE9CVEN4bk1ldVdJcEp0WXM1N285cExIWUo1WlNFc0U2YWwyOWJp?=
 =?utf-8?B?dzNUeDBGYWdBZG9sYUM5QSticnlqd0pKQlJnVWNqYXl1UmlQM08rU2FtVTNZ?=
 =?utf-8?B?QWVlZVFlRXMwUWQ4aTJZc05ESU02ZTNqemJhY0FhSlFTTzc1VDZmekNGbHFX?=
 =?utf-8?B?V2Zia1YzcW5QOXg2eGJCdHZHdkptY2Rmc0lMc012UGErWW9NWGY1eU9PL0Fk?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7f6cb9-256a-48d9-efbb-08dbb32543d2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 00:14:43.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8/SEySHfDLJTvzPH/dRKfttyCoHZICh55fDqEblHp2x3WbCSGFnKRwj0UTLLP7T07jWv1E0npXlUAHjX3Uppr/w2X81fs3tXT+DbHyENas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/11/2023 3:22 PM, David Christensen wrote:
> The function ionic_rx_fill() uses 16bit math when calculating the
> the number of pages required for an RX descriptor given an interface
> MTU setting. If the system PAGE_SIZE >= 64KB, the frag_len and
> remain_len values will always be 0, causing unnecessary scatter-
> gather elements to be assigned to the RX descriptor, up to the
> maximum number of scatter-gather elements per descriptor.
> 
> A similar change in ionic_rx_frags() is implemented for symmetry,
> but has not been observed as an issue since scatter-gather
> elements are not necessary for such larger page sizes.
> 
> Fixes: 4b0a7539a372 ("ionic: implement Rx page reuse")
> Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
> ---

Given this is a bug fix, it should probably have a subject of [PATCH
net] or [net] to indicate its targeting the net tree.

I'm not sure I follow the logic for frag_len and remain_len always being
zero, since typecasting unsigned values truncates the higher bytes
(technically its guaranteed by the standard to result in the smallest
value congruent modulo 2^16 for a 16bit typecast), so if page_offset was
non-zero then the resulting with the typecast should be as well.. but
either way its definitely not going to work as desired.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 26798fc635db..56502bc80e01 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -182,8 +182,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
>  	struct device *dev = q->dev;
>  	struct sk_buff *skb;
>  	unsigned int i;
> -	u16 frag_len;
> -	u16 len;
> +	u32 frag_len;
> +	u32 len;
>  
>  	stats = q_to_rx_stats(q);
>  
> @@ -207,7 +207,7 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
>  			return NULL;
>  		}
>  
> -		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
> +		frag_len = min_t(u32, len, IONIC_PAGE_SIZE - buf_info->page_offset);
>  		len -= frag_len;
>  



>  		dma_sync_single_for_cpu(dev,
> @@ -452,7 +452,7 @@ void ionic_rx_fill(struct ionic_queue *q)
>  
>  		/* fill main descriptor - buf[0] */
>  		desc->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
> -		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
> +		frag_len = min_t(u32, len, IONIC_PAGE_SIZE - buf_info->page_offset);
>  		desc->len = cpu_to_le16(frag_len);
>  		remain_len -= frag_len;
>  		buf_info++;
> @@ -471,7 +471,7 @@ void ionic_rx_fill(struct ionic_queue *q)
>  			}
>  
>  			sg_elem->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
> -			frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
> +			frag_len = min_t(u32, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
>  			sg_elem->len = cpu_to_le16(frag_len);
>  			remain_len -= frag_len;
>  			buf_info++;

