Return-Path: <netdev+bounces-40498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21267C789B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BFB1C20B19
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCBB3E48F;
	Thu, 12 Oct 2023 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TelCPzqC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325333AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:29:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52035A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697146190; x=1728682190;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=es/i3Unj+s9tmt5GhiAgcCzP1JQUdIPzGOy+ISkz5hw=;
  b=TelCPzqCtxjBBOniUiCqyRigyG89FeQzdHYLmlhvxsQVambF4S7HhuxC
   r1vxdijEQRZcFfprmBlXiL1sDC8Lhv8fCrA6Yp9/uuK6lO9q+Ys64+DGF
   vtb4zVLs9kGVEs9jb5WLv5orPvr4svOR02WTPbfDTTN7u+FQ+KASZVefW
   TdWtJIglDQMsrxoab9N975C8npsgG6Y44kL/EVrGq+WbbLBdRPHxpm+RE
   eywFzzU3WIIp/j97DBFYYq4v0ARlAFE1OI0hzFW6JbT3EJZxdSEoupVpZ
   bSLlAO6S2YkoDTdPApWLRIu3oZfdbDDu/9uKqGrwewpq4t6mmRZY58NhO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449236939"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="449236939"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:29:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="845145056"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="845145056"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:29:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:29:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:29:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE90P+syJM0EaXmDQhs5hyilT/4nojkFOcIRylKQnuHCA+IiICDP+fvTtsQ9aaisb5gy06rTz5IS4qB0QjSVTVrJKjdGlRmIb0Rf/ljN7+sVVmz/QgnRW/z4iXZdOjAF5atZYnyoDC/t+nN+C/hf6WXQWgcB4almLnRd7TwyUPvis2vJZX+hkSHknNHm1OLeJZXZMVrYm6uoIZLtiQiHb+lktSLSfWtoyFXxok4QkW3c8/pLZFbxtHrM9LwrHjQu2BA6LWIQXXa3xDVD1nMGv1HmFWr2sfscyfnXN7usY2YnsiiWPAkZCQeutzN6g0ITAKsz3egudh7fVPvhyIZibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ud4RrvROrWmUnr3GkjltuWSfZqPug0Jt324SzRpuJI=;
 b=cMtAfOyhhpw3tfmnY8Whb+myEe/WJY6lZSe7SJvC9ijL2SjnH1wT3NE9WSu1s+/9IMaUFTnN1HlGmsy2xuuShMrNMOgsZ0uHOfFk983cVn8YRyNorDdTCM9usSAJ9vhv6c+RB9edRms+ynvKPFk7D+9tfLAf6szwU2Cls7u0tFOCQTYDTq5JG7RaYLJQNv9qAa1K7QjQ62jI50X5RCVxtgbf2NBXPSezszsPgxjsa4Fktz3Kgg0B4nGOCeLx0sJIYbWPPbf6fL7AQF/FPqjUgpY1g3LQbc50fv2cvnES5WWPUjqO9lg+XT89hJm8CdTI+Oaxn7Aks/jXBZlxJ0Oxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:29:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:29:44 +0000
Message-ID: <b2af52b7-b7b3-4c29-9d2b-cedc02673276@intel.com>
Date: Thu, 12 Oct 2023 14:29:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 06/15] net/mlx5: Remove unused declaration
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Yue Haibing <yuehaibing@huawei.com>, Leon Romanovsky
	<leonro@nvidia.com>, Simon Horman <horms@kernel.org>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-7-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-7-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0389.namprd04.prod.outlook.com
 (2603:10b6:303:81::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f2bf85-28dc-4991-6349-08dbcb6a5a54
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSvxz/A6VQYAuNiUHaewtex6gf2SamF4xTQrT8HNn81w0XXHyczicezvgG4C5QvTScBwoW5I5OtcEsbjHYOaahwm4dXcj8gU8SxdMf5nJucxw9V7T7X0/JRDyzsddyQiwTFyXUbcOYDArDLtPQTA7dbxTlUZ+MR5xOgyZH1IRWNI2NqKXUzX87j6CsaOUt8g/ya86DeSsmo3ay/5pkeYJl3hLrrHvI7U842bQ71PzQ765fKGFULfIzo8CU6FafhJtMrLz0ykxz5GB0dTYeHrj80cqzNmkRJD51ZhQBq0M9+pg+V4+doQC7et3tYE1qpMkFpFQpc7KnCFDLOqUx3/maTOjX6Bpmexl7iuzSaaM11UCeRX1pRzOIySirDEjMiuV+1xiKyp+eza+ZPsU6COHEJ72wkjfLNNtkVdR8GCoi/jhT1bl2l95341SlNXRfZ+1ITK/61h9pNZMvSHLWdfm7eXew06Fb1cZ6Yn8IN+Wdq+prSgLG4OTwWGnH4MeUAV6P1WfzfBqCnBkh9Lx4FLujrfG8KSWS4e3VGEUHTtrUcO1wZmSEsqsnp7O6hyrBfBp00svVmbojWxJJvG4tkx68kjl6axGksUGHy1YtczhjpNZw1twEXDmrXqS6DgdNAH3fDXDXlD/wZrKmlyNHDxUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(82960400001)(6506007)(36756003)(316002)(83380400001)(66946007)(66476007)(54906003)(66556008)(110136005)(53546011)(2616005)(86362001)(38100700002)(6512007)(31686004)(6486002)(478600001)(31696002)(2906002)(7416002)(5660300002)(4326008)(8936002)(8676002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBpcFU5WUxmNW1LM2ZHNjZxYkhHdmw3dEtHQ29XVDFIRnJLcmxZbnBiMFJD?=
 =?utf-8?B?REd1ZENtak4rRkUzWHdJVi9RZFltYjRKNndic1dNbmdQQW1temlpU3ZlL2Y1?=
 =?utf-8?B?SjFiVGZWSjgxbmJmOTZ2emJNZmVrdHRSWWR4R1lBaGt6Ukw2UkhlYkZFdHVy?=
 =?utf-8?B?ZkhaR1VzTUVZdmFQZjlCcFRRQlUxdnZ3TC9HUXVHTjFqeUYxQWJxcHZsTSsx?=
 =?utf-8?B?Tk0zOWpyUy8rTEUwVEQ5cHl2VFQyQSt0TXMvcHBSQmZMTWVPU0VqU2J2dHMx?=
 =?utf-8?B?REl3aHVHeWJtbDkyMlpsK1ZVNGJxVlIvVTB5YS9LQS9nbEp2WW9GL01TVTYx?=
 =?utf-8?B?dnFmUUJGMEFjbCtKYUo2OHdPOWVaRk1FTzMzZEpZY0dKd08xZGZkcmlCRjdW?=
 =?utf-8?B?M2Z2K1FqdGNkQjNkZE5QQ20wVHpkTmgwRHltL29Ld05JakU1c1ljU3I1Rmd2?=
 =?utf-8?B?KzhhNU12c2pwUmV1VElXVWZpeFRuT3g5RERQZE52MzQwWkkzQzVoamlTRmg5?=
 =?utf-8?B?ZHJzOWREdWRSMGVidXI4UUdaTUZVOVNRelFtS1lmU0Q0TUthMDdUbks2TDZJ?=
 =?utf-8?B?S0hGWmY3QW9ZclJBZTJybUprRnl1dlRXMGNLQWJ2MHNQcU5lNG81ZHNwZkFn?=
 =?utf-8?B?WS9FNEluTnZKd1pBMEszdGEzVW1tUUJHNndINkZKVThFajE0anNvUmhocFpt?=
 =?utf-8?B?TCtUZ1hsUmFoSnZwWEttUWx1N0dNay9HcUMyS0lLVUcyeWtWYnJJc2dMUktz?=
 =?utf-8?B?Q2VkL2FrRWhLT2t6aitzeUVWT1dyVGd5ODFDWlFLcHpTNUoxRXdrc2dOUmU3?=
 =?utf-8?B?SXlqaUkveVpKTGhVQ29OWkY3YUsvdmlUcG9mKzNzTFlFRDRpOTlmaGM1YnF1?=
 =?utf-8?B?b0l1L2U1MXVHZWVMK1VxV1RDQU5qN1ZackNxRlYrOWNKNkNJTUpGYTF4Q1NF?=
 =?utf-8?B?Vm5rRXVHTkwyVkVtUllZOTlJK09QQlBidjJxVHFnM0VIbGRQVWZXTHRLTmx5?=
 =?utf-8?B?UUIreHdrZVV0UEtYWjdMd0VOeWtXR3kxd2QvS2IvcS9WT3NnTm9BY1NZMGg2?=
 =?utf-8?B?UFcwRFlCTFBvcWhEWnFpYk1zeFNjemJKU1FOZjdZMDlXajZUQS84dXM4UllR?=
 =?utf-8?B?ZlZYZDY3cnlGaUY5K1RpdzBCcW5oNzNVakhJbjQ4RlN2cGI0MHZOd3pMNmJs?=
 =?utf-8?B?MXIwaWx5aVFVZEtQTXZ5QU50SFBUUWlRVmVLb1JQSTIvOEN1WkpIcnIzNzNk?=
 =?utf-8?B?RWFjVWZhNysvLzdNd3hPdEM3WndBa0pFbmhaSG1GdFplV082czM0LzhURHVR?=
 =?utf-8?B?eUMyMDRJNDBzdVZmMyt3a3pvcTl2T3BtQjB0dUgxKzhlMDIrSjdteExwaFN0?=
 =?utf-8?B?VGFmYWFHNG1ad2FPejZ5V3hHamxwRkdsTHFNQTg1cWR6V0s2ZWdyRDdMRzJK?=
 =?utf-8?B?NEtMV2ZqZkoxS3FJVkk4QXlIRGNIZng5dHZJRUVsSWl2M1J3RFppNE1xZW5F?=
 =?utf-8?B?ckFqdEVhQVVmUlJmbWJUOWpwRVdjb3RyWFgwK3RXNHhMbGNlbnpmSVRDeTZu?=
 =?utf-8?B?SmZ1Q1RmejBWVXFsTFZ2eE8wVzRFTjZxK0FXRHFyYmJaUXZadXhleTFPR1ZC?=
 =?utf-8?B?MFBydFViVmYzV0NFbXJvRmVIZnZQYU4yeVA5L0xYa2cxdGpvTXpZNnUxd21N?=
 =?utf-8?B?Rzl2bzhmeXgwSVFLTmhFN0IzS2cvYlhsRU1YZ3NuVEVxMmJHTVIxTUtEc1cw?=
 =?utf-8?B?SjRUM0R4SWRCMHJEQ1dib1JWU2ZZYVNTNGx1Wk52RmhHcVlhMThPeDZFaWFh?=
 =?utf-8?B?RnlWcy9XYmpMRHp0K3A2VmhEL3puSExIUXdGZWxxaTZUSmFXY21RUlpQWWpF?=
 =?utf-8?B?bVlzY1hneGpaMkNvUTh3RktZV25USGZRTkI3TGR6RmpaRmJJU1NtNlI2OWM0?=
 =?utf-8?B?ZUFhV2hRck5Ba0Fxamt6VzVTS2ErQ0NwQ1R1Nit0Ulp0eUczajdJVjRFajlS?=
 =?utf-8?B?dnlkak14NTl3TmdjMUl4SDVyaVBNM1NIU01YSWxOWUxyNGcvSjV4d1RmaFBu?=
 =?utf-8?B?YmV6OEdWVG1tTUhMdk5SZnBreHYwYUt3Uno1b29BN1VCMmxwa2s0UDFwblp1?=
 =?utf-8?B?aU95L05ablk1OWNoNndFbzdIYVUydmc3Z3J0NWZmWjNISVRKeHdtT1kzSksr?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f2bf85-28dc-4991-6349-08dbcb6a5a54
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:29:44.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKIhrqTOFHtYfDJB7TPFJGAZ9aRjmeNrRifu8ULhxwf6lInNowqH4158iFeB1V8h98znELytJFg8icxyFBDlHalj2PM4197cD2C6UrOUrmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> 
> Commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> declared mlx5e_ipsec_inverse_table_init() but never implemented it.
> Commit f52f2faee581 ("net/mlx5e: Introduce flow steering API")
> declared mlx5e_fs_set_tc() but never implemented it.
> Commit f2f3df550139 ("net/mlx5: EQ, Privatize eq_table and friends")
> declared mlx5_eq_comp_cpumask() but never implemented it.
> Commit cac1eb2cf2e3 ("net/mlx5: Lag, properly lock eswitch if needed")
> removed mlx5_lag_update() but not its declaration.
> Commit 35ba005d820b ("net/mlx5: DR, Set flex parser for TNL_MPLS dynamically")
> removed mlx5dr_ste_build_tnl_mpls() but not its declaration.
> 
> Commit e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> declared but never implemented mlx5_alloc_cmd_mailbox_chain() and mlx5_free_cmd_mailbox_chain().
> Commit 0cf53c124756 ("net/mlx5: FWPage, Use async events chain")
> removed mlx5_core_req_pages_handler() but not its declaration.
> Commit 938fe83c8dcb ("net/mlx5_core: New device capabilities handling")
> removed mlx5_query_odp_caps() but not its declaration.
> Commit f6a8a19bb11b ("RDMA/netdev: Hoist alloc_netdev_mqs out of the driver")
> removed mlx5_rdma_netdev_alloc() but not its declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

