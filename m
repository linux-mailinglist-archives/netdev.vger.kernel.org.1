Return-Path: <netdev+bounces-35865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8086E7AB6D4
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5A3CA1C20988
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC241E4E;
	Fri, 22 Sep 2023 17:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75209171D5
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:05:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F59A1
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695402338; x=1726938338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSOiQbcCoz0x+PsweIpKAjpbzUje2+/N/26m6mF1sg4=;
  b=FaB/cLPPt9gB8n+qRwmIv6kKDqiCnQdK+K+l499drNZo+kPG+EsBx/F4
   ekIi7NDif15vI1zdB0vgVhqh4eUD4Eufd+k+RDSme+mKUitG88swTTvie
   eReSTwqClB6vbVbkw/07Q/BnNY5FQfFnzvZiitNCRa8O8WEi5YMzU5GY4
   13Z9Pez/wPKGC/G9JhhlGfE02f1OQZ16FoFtzdj+IPvyK6egiYKJ/CECd
   RlWhKdjtKcZ5ByxmgQYIadEJ8M1vN4aXHOUNksk5viGdfUNdHE7elRRb9
   IiM+BgSQUrXOlUnT/MIiuyMyNnds1hYSSGRJPOtOBG9RioSzyRqLzuQi8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="383638529"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383638529"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 10:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="697265579"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="697265579"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 10:05:31 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 10:05:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 10:05:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 10:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcBZPJL5oCLVEm/nMM6GC8WbEX/o56MIUJ0dIVRDzo500iU1opEekOt+Cef2dTXHQF/8Dk9i+1lus0Re0fhffP0/oEC4Q3KbWH0LEKtzTma3IW3d5tRZX+s+RQ0M7RLqynqmFr2p3N9UmbgbPG5GVfVMUzmTGoUnUOjBTvasMtlxBfc0qIxQUNF1HaqOduzgujMl+ThBSO+EUyFYv3Wdvj1v9OcGLwGy1OXzGPGqVIKGORq3GI9oR2+3N/ZvfP5rlOt1dCK1Y8mypt72afF/mWBLG7YYEdmtHD9aCtz2P5ddP0BGkpB5lX83OdSvDMiWC49TgT4p0eFe9Np5tGZ1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYQBUZVJZQ3SREJqL6EDlfRm+S0AeqUDIeUmMSLszBA=;
 b=Xl0pY6U4/HqWI6I5D8qtpvVIw4mCuZC9QFkoXUS+i7onki1wvtSI9QcsLUC3gUayQT3dWLJ96yjm6bqXyO4+vT7ZPYgEV2osnmqXxrlTx8E+UToP/QzKokSnaoErWt1iZTgP+wQWa+S3VoMXqilzXa2lfMxewMZ8lS7jQtSBURcEdF9vnKVKmx/VKWU+ZG+f+aaC8qJxlBONkb1AamHCmLYnCNy8eK5HdQwvonY4uBfsdMh2pi/CMpiXkWsMvA+uSEeOG/CZte1YrG7rUjnJZXyJmJ5ZzEvojr+HAb3W+tf9Tix8xMUOceORHW8m5tRRLwjMFYFUyaWzPxdvecSRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24)
 by SA1PR11MB8596.namprd11.prod.outlook.com (2603:10b6:806:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 17:05:28 +0000
Received: from CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::a328:2577:ea8e:c5d7]) by CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::a328:2577:ea8e:c5d7%7]) with mapi id 15.20.6813.018; Fri, 22 Sep 2023
 17:05:28 +0000
Message-ID: <3e8aefa7-6770-51bd-ead4-f6adcba4ca1f@intel.com>
Date: Fri, 22 Sep 2023 10:05:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH iwl-next] idpf: set scheduling mode for completion queue
To: Michal Kubiak <michal.kubiak@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <aleksander.lobakin@intel.com>, <larysa.zaremba@intel.com>,
	<joshua.a.hay@intel.com>, <emil.s.tantilov@intel.com>,
	<netdev@vger.kernel.org>
References: <20230922161603.3461104-1-michal.kubiak@intel.com>
Content-Language: en-US
From: Alan Brady <alan.brady@intel.com>
In-Reply-To: <20230922161603.3461104-1-michal.kubiak@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:303:83::14) To CO1PR11MB5186.namprd11.prod.outlook.com
 (2603:10b6:303:9b::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5186:EE_|SA1PR11MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9381a1-86bd-4def-dae9-08dbbb8e1f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LttebKB77qOfT62hQPtE+RJEzle1zPZVOZlqY7/jlPL5/Ep+LB+EgYgq2N3EtmyLviMT7+eHLNuhsFu+4i8ZxW1pSxRKSS6eGidbJmL1u6t/FajbpNGZ5vrJ2KGVM/X+1vdIsFoyEWd5os5jTz+LBxAJtyT/6b8xYVLKJwCm/jEwJcT/DQsHFjlCsrOF7zgIK4XN5foJN9Jll9hBG7VEKi/2/mD27XbIeYj1OJwyX3QfPTJPiJK85bRDxuY9S7reyjqShnZu+h7UkA2yyccpElwO4RyFPOFna44roB7vOheXR1txWxjxYfpJ5B21T7O6K6hEwLYtCViVINb0HX+A9IutiC2/4LPZkBrJFP2wyR4g8zQB87W/V6RXrK4eRUx3pm61aE3DDUVUJbCLpRtQnHf/GKCUSUaAwAJGvngsGICbwT4IDBSDBo9bSof3vnqUNxxXPl+kAiLsBVOQR43ydV5UUnaLrVV7f8pVDFE35nYzs9D5nGYiYz/+PpStb6FG8DjADryCuYrgK0+ov4BTPsUGm7RzICK/Iz1Vs6N4+u1SgdlmAYVNbBCVfhU08C9RfLOXA6Qhq7YvRLBnUT2T+y29s93Rx+64augInxuJRXME50OLhk9pdyW0u5o04DTPJ07pTK6q4ndv22EC/eLVZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5186.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199024)(186009)(1800799009)(478600001)(86362001)(31696002)(6506007)(2616005)(53546011)(6512007)(6486002)(31686004)(82960400001)(38100700002)(66556008)(66476007)(2906002)(316002)(36756003)(66946007)(26005)(83380400001)(4326008)(44832011)(8936002)(8676002)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnQwcGJLelhtZXZnZE9qeEFydlRiSzRCZklkODFpYVMzZk1KYms2ODNZMUI0?=
 =?utf-8?B?WVFabi9jVTZBazVLU0o0dUtucVd5aEFtVUQxWlg4VmEwQjgzV2VTekxHdkdw?=
 =?utf-8?B?OW1LZHFqa2cxZjY5UVVpeDBSVXVEbmIxd0grQ3VBUVIzYWJWV0RtVGVySGho?=
 =?utf-8?B?emVldDRRR0hiVTJOTjhYVHZvR0QrVURRSk9qaThCTDZjelNveXJVeUw5SDM4?=
 =?utf-8?B?amJHNjQzUExZN3RrTTFpYk1MTFdFdDdVdHQvdmlrRktJMVk5V2ozbi9XWklq?=
 =?utf-8?B?aFNkWkRZU3Qxc3hxcHp4SFYvZmtTSnRwQzlaeU1FdkZTSWw0aFh6bjVaQnBu?=
 =?utf-8?B?T1E2VDJpaktNaS96QkliaHhUaXhveGwxdDVzZWFGSFpHY0lsWE8xKy8yZy9T?=
 =?utf-8?B?UDl6b2dPM1Z4U2xvVm02LytmdkJLUm9aUnZqc0QrRFdETy9qQ2E4T3RkVnly?=
 =?utf-8?B?bzFodGdrSDRKRmFnTUZhanVKNnJ4TjYzYjdrNnpQNHEyK3pKbG15UlpYY2Y2?=
 =?utf-8?B?aUxnZy9vM05sbXB5a1phL1YrNHpFL29XdFNodm1JNjhaMEpYSUVGT3FWRm5o?=
 =?utf-8?B?SG5rbmY3eWFOMVZTK3hNSUpmZ1g5eldWeUJVcWxpYTczcFFIRWlDaFZnUWZ5?=
 =?utf-8?B?WE1XeHpaOFM0cE5mRjNLaG41b0tqS3BvaVMvSGQzaXA1NjZzdlhYNW9CTUxM?=
 =?utf-8?B?d0hxYUlHSHJqNm0zZEtlOFNyeVNrTnNMNmh0NldjWXcyRFN4b21tMEtzYlo4?=
 =?utf-8?B?TnFYeTJOazBrZmQ3OFhOaTJEWHJJWk5aeWdiRzdpZUJZOUt0Rjl5UDgxd3dD?=
 =?utf-8?B?cnlWR09XcWxxRjFsSEVzTzRmVDNpRnZQdlZKK0JNdjJRZ0ZxaDJmWkdGd09k?=
 =?utf-8?B?bmhoVWJ2ZmloNmRXVjlqYlhJQytMOG42ZFRtTzhIQVQxaWxxWEgxSDVLeXFv?=
 =?utf-8?B?QkVnOXlubzB0SEt0ZTFIZUJ5T2hxUzc1TitXSDdvcjBoNGM3eno0bDhmZk9Q?=
 =?utf-8?B?Q0tTcFZydGRuY2l5RWdiVWo0K3NETFJnMk5zM0lyNTc2V1U0WVpabnllQmo3?=
 =?utf-8?B?a29KOG94VTB0QUR5NXF2SlNScDYyNlBZQ280Qk5MQkhSbTl6ekJHYVpTallU?=
 =?utf-8?B?aDg2dmUwREtQd3owR2lNck5qY0VEZ2ZHRTBMa2tNR2hZLzVMMW44MWRvVCtq?=
 =?utf-8?B?bUtGb2VCNlVpbWxQaFFYcW9WNTYzbTVVTGEwaDZLWDVVWU1yaDRLOE1Tc0Rp?=
 =?utf-8?B?aktWYlRlNmYxeWFDbno1MmkzdjRRQlpPVERqN0hDdW9TK04wd3FvQUJ0WDJB?=
 =?utf-8?B?NHZCYlVFb25KYWV0V3VGclRLSTdXTmphdnJ5QmEvbTAxejVGVndwL3Myd1Jy?=
 =?utf-8?B?NmpSbStPc2ZKS0xaOVVYUmZFWXdqK3dvV1Z4MVQ2MlluWlBiTlBkbmg2RVdz?=
 =?utf-8?B?VHBiNE5QRkpEVGVZRUxjbGt6dUpTTE5SRFF6ZVNaR3NpNFVzZUpub21TQmlD?=
 =?utf-8?B?QWlIMDJ2K1k3V1FXRXV4UDAwdHpFcm0rZVAzbUVBWDlYSW5NMzBzcGdCSUFN?=
 =?utf-8?B?R3hjOE9XMkZSbWwydkdaWmM4dnlEY2ZZYlhySVZEZklMbWlUVXlORUVKM3Z1?=
 =?utf-8?B?Y09PNEZQV1lsbDdDeHVzQXdtM1VIUmVsNFd0eG0xVEpzWU9TK0k4L2hwRGNC?=
 =?utf-8?B?bTVRM3ZZUXdUQVVJc2Vyc2k3eGU1dXljUjQ0ZG1WeTNzNU0yZ01tWllMZ09I?=
 =?utf-8?B?eVJXa2NCbURBWlR2MjZVSlBuTXEvdEY2eDZndWQ5STlPdWtwL21ycUJlV0lh?=
 =?utf-8?B?RkdYcG4zdVI0YTgxQUtnbUtUMHFwMC94VkVHckJ4SS93aXBrYTNsRFczTnZH?=
 =?utf-8?B?RHZuLzZuck1LTVBFL1h3SGFIblhUWXIrYTE1SlhpZ1dONEdoZ1VSdDRxL3Uv?=
 =?utf-8?B?cjBMbm1mOCs4QjhCQi9Oa0FreGNXUW1RSS9ldmpPWVlMMGNIYWNNRjNBS2N3?=
 =?utf-8?B?aEROb0ZUcHdYMXoyUk50bkNtRG1CQ2dXS05TczZnczc4ZVE2MWd5WjFLdS8y?=
 =?utf-8?B?VitFNTI5L2dVUGw4aHhteTdFbTVoemhhbWlKMERCdEkyRjd2SFl6ckU2OC9u?=
 =?utf-8?Q?ER1HetW3vw3Tp0iF3GQnBOeI3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9381a1-86bd-4def-dae9-08dbbb8e1f40
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5186.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:05:28.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4nyPnh9S2km6xiumr+zqCVEiuS4Zy1cWWQJKnmjwv3huqSUTd/oX7NDp+bDS9TlQ/Nh/EkiDV5cweS81jM4hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/22/2023 9:16 AM, Michal Kubiak wrote:
> The HW must be programmed differently for queue-based scheduling mode.
> To program the completion queue context correctly, the control plane
> must know the scheduling mode not only for the Tx queue, but also for
> the completion queue.
> Unfortunately, currently the driver sets the scheduling mode only for
> the Tx queues.
> 
> Propagate the scheduling mode data for the completion queue as
> well when sending the queue configuration messages.
> 
> Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 10 ++++++++--
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c |  8 +++++++-
>   2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 6fa79898c42c..58c5412d3173 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1160,6 +1160,7 @@ static void idpf_rxq_set_descids(struct idpf_vport *vport, struct idpf_queue *q)
>    */
>   static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
>   {
> +	bool flow_sch_en;
>   	int err, i;
>   
>   	vport->txq_grps = kcalloc(vport->num_txq_grp,
> @@ -1167,6 +1168,9 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
>   	if (!vport->txq_grps)
>   		return -ENOMEM;
>   
> +	flow_sch_en = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
> +				       VIRTCHNL2_CAP_SPLITQ_QSCHED);
> +
>   	for (i = 0; i < vport->num_txq_grp; i++) {
>   		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
>   		struct idpf_adapter *adapter = vport->adapter;
> @@ -1195,8 +1199,7 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
>   			q->txq_grp = tx_qgrp;
>   			hash_init(q->sched_buf_hash);
>   
> -			if (!idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
> -					     VIRTCHNL2_CAP_SPLITQ_QSCHED))
> +			if (flow_sch_en)
>   				set_bit(__IDPF_Q_FLOW_SCH_EN, q->flags);
>   		}
>   
> @@ -1215,6 +1218,9 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
>   		tx_qgrp->complq->desc_count = vport->complq_desc_count;
>   		tx_qgrp->complq->vport = vport;
>   		tx_qgrp->complq->txq_grp = tx_qgrp;
> +
> +		if (flow_sch_en)
> +			__set_bit(__IDPF_Q_FLOW_SCH_EN, tx_qgrp->complq->flags);
>   	}
>   
>   	return 0;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 9bc85b2f1709..e276b5360c2e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -1473,7 +1473,7 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
>   	/* Populate the queue info buffer with all queue context info */
>   	for (i = 0; i < vport->num_txq_grp; i++) {
>   		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
> -		int j;
> +		int j, sched_mode;
>   
>   		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
>   			qi[k].queue_id =
> @@ -1514,6 +1514,12 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
>   		qi[k].ring_len = cpu_to_le16(tx_qgrp->complq->desc_count);
>   		qi[k].dma_ring_addr = cpu_to_le64(tx_qgrp->complq->dma);
>   
> +		if (test_bit(__IDPF_Q_FLOW_SCH_EN, tx_qgrp->complq->flags))
> +			sched_mode = VIRTCHNL2_TXQ_SCHED_MODE_FLOW;
> +		else
> +			sched_mode = VIRTCHNL2_TXQ_SCHED_MODE_QUEUE;
> +		qi[k].sched_mode = cpu_to_le16(sched_mode);
> +
>   		k++;
>   	}
>   


Reviewed-by: Alan Brady <alan.brady@intel.com>

