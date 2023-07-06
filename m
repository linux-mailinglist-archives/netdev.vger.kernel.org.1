Return-Path: <netdev+bounces-15886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 532C374A498
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 21:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830B01C20E1B
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CBDC2C8;
	Thu,  6 Jul 2023 19:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79630A944
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 19:55:45 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2930B1BF3
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688673344; x=1720209344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HkCtJo9m4RAYeUbo08oMfmqQwD8iOTLqbatD+vKp4jM=;
  b=kUvzK01eTh8pbPQKGMojFlSwd/hiPxDw0LmcvfWSlNojnCgA635olcEM
   bQhqcRzZd9GPFsDDdLfoxRaLW8zEqBU+80YvLC9Q+L9KCIY/4xO/j26de
   FPKUJ1+tAkDrPRlu0vVpiCZz70sbY6KklG5qgdo43bdlOXzxJ9Hw6vstx
   J91sAt5Gsbc0Kdx6eQAyp6DWTxAPu57MmVfzA0KkWAWXSC9naisUUAQZR
   Rp05ee8e2sxhviDjfDXXYB/OVUGbMUrBdSUb9Qqnx0I4rUyLkpRYGD7+4
   ZzaBvDQAWCkcBZQ9mtHcHXjeEpsRLzKFmAOx8Mjy2sBfAVE6z4hYuyjCU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="353544707"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="353544707"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 12:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="749277502"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="749277502"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2023 12:55:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 12:55:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 12:55:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 12:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiNp9XTj15EfYtDwcdFEl5pkw1q91vIYVCsYC6CJaOaVNpAWzzPcFB+CbvQa86ceSJKSaoFp7JKaq4LPgG+hvs8IgtoweUr4/k6vO51amAK4R+oDnfLcq7XbDrP+cJsbqnaYRau2ggYSP2A+j9q0/OGv50ydeRr0CtHeJBo6Ffh3ymMt8uzVEO9jMZ3Ik/kn6fMlu+caNDVoYHZd6g3iUYNEp32//owgFd1sbdHUn+J9k/WLRqxIQpzwAUDiEGy0BbMdCktVRNILBphCNwNb2yqB3r5aNnwLQYrgTEgs9/2MgoyCRpJkEoKrHreq57x87pK1lJQS8mHCssZOCq8eeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+loIqTFgKFmYa+QoErc+z0Y3jmkpljioF4kkTOd5WI=;
 b=BAD3F34emIHpOSHEpv0BmqYUWi1ROBMK2xRGtWj1vUAxKtW9o3faSHep5IERyLfUAMa0yu8Tr0HjFi0uYcRUHF8eaCzoVrP9Mvk3JgQ8pbyWKfEwqPMWFoljG3PA6pr3vGzaTJ7D7BVGMFgKp8H1jH0Cx3AL7XnFb6iSuUZkxXH4SfsXjUSeHvRSQ6igBH1jltu5Z3U3/kr3E0Va0Lsrub0W10MiUwpJLpmL47NgEtB65mrXDCfpa/h+GDFcgTqfX+Cp9t9Zf+04m2y7RPxq8EL4TytAy4jkxmmDU47217iqh0a74HO0MnTrraZgzg22dPPjp5wCrqBrXhpZPb9/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB5874.namprd11.prod.outlook.com (2603:10b6:806:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 19:55:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 19:55:41 +0000
Message-ID: <75f89fd0-191e-0248-89d1-aa9f1bad715a@intel.com>
Date: Thu, 6 Jul 2023 12:55:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 net] ionic: remove WARN_ON to prevent panic_on_warn
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, <nitya.sunkad@amd.com>
References: <20230706182006.48745-1-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230706182006.48745-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b0813d-d806-47b8-e1fa-08db7e5afa47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMGPObGyQimr0oJac/XFRW762tRsdleyUn1eadeL4a8Tbz4bVt5KZvoQGsqOXfnANmAgFLpmPprwZV/yYkzIFjn5SXGsRAd2TBw0E4C8qxLJyDIbzuG3iT/MwuJX+H99hJx8QdxOOn5QGYd1p7lXj5976VygvKw48BH8pD+kClPgOACgQglEh8i4BJw0V6o7BZP7tj0feHsKxAV3jqtihQPpIspnLDBSZjUCTEX4w9LVpXMgA6qAaaENUW1BrxnUjg1ps+g5+e/gDQ1J3eWdNTN96kNKCNvNll3AiTuYSYffPvD/ckoF1ZB7iTBeVYCNLsHqU6dAZpc/bPKW20a8fVN3ThitweFhJmYWSxbDF3a+zPU5t2edt7E7pqoLpJvIAbHYVg5NHBJfV4BiE+peEsl3+1BiQYB+GG2Iiae35g4eHyzvx7acZUvyI9o7k70eBTETIMAfJLImUyIZyFbA39RHHM3xQ59tpZ4i+7zQA4ObuxqoCY/lhImWLHW8j+Vl+urrMykKxdhIOAxBtN/qdmrR9kJnKFL006Q11pfzPVhOWlLODq7CIhvuRgY0gYxSoLVTvgdsr0/FcM0j0EW9UgTQ1GrtBfmeDBzzWM7x1Okq+RWo5AskXFZq3w8BmMpRB2SKY8WhrgJHs0s5N2eT7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(38100700002)(82960400001)(36756003)(86362001)(31696002)(6512007)(478600001)(6486002)(186003)(6506007)(53546011)(26005)(8936002)(8676002)(5660300002)(31686004)(66946007)(66476007)(4326008)(41300700001)(66556008)(316002)(2906002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWFrMkcvNHdXWGRIRUVnKzdOU1BPVFI0WThhVGpDejNlMDgwbzFpQUJaV2dq?=
 =?utf-8?B?WGZyTmlIT3MzZmxhdzVGS1VpVzM0UlRWRkZzdk5haisvYjlIOERSNFNiT2tR?=
 =?utf-8?B?dDJBWlVpTG9hUUhNdnRiMm5YN3NYL04yK1IzM1dSNzc1STIrWXpjRUR2eXhM?=
 =?utf-8?B?MGsrUm1hcWRYRGdFc1E4ZzhBMSt2eUMxRmttd3JURnJSMmxNQ3NqKzVDUmRU?=
 =?utf-8?B?S1BJbWhQNll2NzB5ampOOFFZSDNJRkozNklRanFQaWhIQ3FCU0llbnRrVnpi?=
 =?utf-8?B?WDJ0NkdCNFhSdGRJdWpRZ1pycTllZytUM2VOamNhUm5HTzZTRVl0c3ZYQVFw?=
 =?utf-8?B?azlUWnlZdGNYYVRjR0NJYnpCRldhcFdacnVpbDJVUGZJU0xIbVZ5WGw3YUsy?=
 =?utf-8?B?eFh1YkxTTmRVOFhobEV0TnJpU0dqYUR0Y01HckhITzlyVjR4ckZaclBGS0po?=
 =?utf-8?B?WnpUQzVqb1lEQ3R6QVlIbEhXQ0l4cTRNak9RcXNxdVJUZlNtMlY5b0NWamJH?=
 =?utf-8?B?ekMyQUpiUlJCaDczREJlcE1FcEErVkh6bDRoWXlRZGp1aUVXUDBKUDMyeThv?=
 =?utf-8?B?VUcyMWs3M3l2c3BQbXZrVytDOHZ6Nkl6VFZ6aUhnR1Jrb2VpOXFTMklTZ0Zo?=
 =?utf-8?B?TUwxVHhKYnBZR00vbnFLYzd5M2pWOUZLMFZxNTgvZlVyRmJJL2lrR2ZxMkx3?=
 =?utf-8?B?U1FUbGxtREN2bVpYQk5GekJOVXRteFdDdW5MRW9GZ2tycFJXQy9wMllWUE4v?=
 =?utf-8?B?NHJySGdYOVBoRFNNRkpoeEkzaTZuRVpTZHhtRUZIdE9HMXBxRFNySldQV1Mz?=
 =?utf-8?B?R0pQdXFjVmtRMmY4M1I1aTNhSVNJQVB0UWI3TThXWkY0eEpVMEdDMTA3MUNY?=
 =?utf-8?B?eTUzd2IxZGk3RVhZdmlzbUgzU3EyOCtRQlFPM1UrY0daQ2lYV3dmUldVTE01?=
 =?utf-8?B?WExlSncyRUxVSW1qelowS2pWeENKa0xlU2wvalNpcDlYLytMN0dETjhhYlFV?=
 =?utf-8?B?VUo2eDQ2WVl1MlhQQ1F1UjVIV2xxV1JkTGl1NzdFcFNTTnUrK0ZWMkJWMHN1?=
 =?utf-8?B?U3Fxc1ZYRUxacFZLVHg0VkZpS0Q3WXZOa1Z5ellPMUpwdENMSnJTNzBwSFZs?=
 =?utf-8?B?T0E3RURPcHY2L2hxSXRIcWR0V0E3bldXbWl2ZFNpejlhbUp0OVlpTWpOL0xW?=
 =?utf-8?B?OXV1aFpwYXpIWkY0dVI3UEExcDUzRlBudDdPK05aN3E1b1ByY1UzOWtNK2h4?=
 =?utf-8?B?MFRLaksyWWtSaHFtR29FSlE1MWdGSUV6V3JBd1NhSEEybmdGbXVtK0VsTUR3?=
 =?utf-8?B?bklsMVdlUGVpSXBIMlg5WFM1Y0djdzVmU2RjN1loNDF6UGhGNUk2VVRxWk1k?=
 =?utf-8?B?a2FsZlI1Wmtod0d5M1NJWldqV2RoanZVZUQrZGEybXVIbGx6Ykt0ejZUY2Ir?=
 =?utf-8?B?RDNHV2VHcjFta0dwMGQzVG0zdEhubzEvWDB2c05wWDBQRGtjS21NVEJQZzVG?=
 =?utf-8?B?RUdEdFVlYW5WWkFIbyt1bytYV1loSm5oM3JpUFUwdlhta2FwU0JCbUVOMXRM?=
 =?utf-8?B?WVBKMzZKanhlY0VmM0s0UUR5c0wyczhiQzdQQmhjdjlxLytudDkyRGZzOXVa?=
 =?utf-8?B?OStFZXdmWEdiN3E2YXNjY0YzU2xhNWlBMFJOMCtDczQvSU04dDkxcjBLeDk4?=
 =?utf-8?B?NEJxVlVFQVo4RjV1N2xYT053aGxTSTAvQmpRckw2NXQ2cDlTV01BY2x5MGU0?=
 =?utf-8?B?OUl3MHNPaDNwMU8zZ0xvMjA3SGxkNjVDaTlyd252akRFTXQraXcyMDBXQlE4?=
 =?utf-8?B?L3FGR0d5MTY2QmZ0S3RHWkwyNUZENDJCVjBwTEFRNDQwRE16aXJsSmZUVk0x?=
 =?utf-8?B?N1Fjak54dDR4c2J4aUlmV2VqdzQ5dDdLbkFrZ0JUeVhzS0dtTGo1SUh1MmM4?=
 =?utf-8?B?WXBYSHRnRjZBMndBTFJYaTBMUFZOSjNkTHI1K3dueS9Oa1psbVFlWkIrYndi?=
 =?utf-8?B?UUlMYStvdGRUMFVHaHlVZVZwWDNBV3pKeVMva294bDlabm5tdUVCZFdkTElZ?=
 =?utf-8?B?dlkyMGNHNmcvZnh6RXZjTk9oWHdqVHRUWURIOFEvenRQa1JzWGdET1lDVlJN?=
 =?utf-8?B?V3hWQm5aZmU1ek9XbTdiVCtQK2cvMEEvN0VleUNUYm9hcHZzbjJXNmphTE11?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b0813d-d806-47b8-e1fa-08db7e5afa47
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 19:55:41.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GliW1UpcIwCIN/StmCJG2CDyM3oKpMNSjcfhxVYlTEiMysBfk6FxJWIQLBEu0mLdzeQ1k6Perng5SFHU5k1yhpAFmrjv3EkngCWPs7LJ8Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5874
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/6/2023 11:20 AM, Shannon Nelson wrote:
> From: Nitya Sunkad <nitya.sunkad@amd.com>
> 
> Remove unnecessary early code development check and the WARN_ON
> that it uses.  The irq alloc and free paths have long been
> cleaned up and this check shouldn't have stuck around so long.
> 
> Fixes: 77ceb68e29cc ("ionic: Add notifyq support")
> Signed-off-by: Nitya Sunkad <nitya.sunkad@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
> v2:
> - Remove unnecessary n_qcq->flags & IONIC_QCQ_F_INTR check from early
>   development
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/pensando/ionic/ionic_lif.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7c20a44e549b..612b0015dc43 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -475,11 +475,6 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
>  static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
>  				      struct ionic_qcq *n_qcq)
>  {
> -	if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
> -		ionic_intr_free(n_qcq->cq.lif->ionic, n_qcq->intr.index);
> -		n_qcq->flags &= ~IONIC_QCQ_F_INTR;
> -	}
> -
>  	n_qcq->intr.vector = src_qcq->intr.vector;
>  	n_qcq->intr.index = src_qcq->intr.index;
>  	n_qcq->napi_qcq = src_qcq->napi_qcq;

