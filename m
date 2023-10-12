Return-Path: <netdev+bounces-40503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23A57C78A8
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C766282CA3
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B243F4BB;
	Thu, 12 Oct 2023 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALS4cT6B"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A33E49E
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:33:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B98DE
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697146414; x=1728682414;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mcxf0rETj3AU2Ipo4+fXfqvZsL+qlTZZCFw2YCWzaRc=;
  b=ALS4cT6BrFicWxFz5UHY9dC4tgqz8NYh/99J0XGmAz0hHSFNW8wL0IaW
   Dp0zOZ9m5dvpQXQgEkif61IcdQxUH0haRGprmXNNBHjc4ueuAngNkYxvo
   JeRs+kinZkrCppM+8p21PpejBRPA9rFJxtpZ64nnhZhEdFJJcCYCPE8aN
   nhdCf0eAe6Ec/G8Em3zzaT9ah9QzCJCUOx0pStbH99Xa9Qp8HuWRRzCYk
   MyVBj1jRY/bOx3MmkaX41HIsYHuvQy3PYM9UzgvcjilSZbWfnjlDai9+Z
   D5uqbRPtVFFjOn9LSU9QV9OyHes7ztbwX//qvz2OY5UF7hOZ5PUqnDpus
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="384886065"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="384886065"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754447092"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="754447092"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:33:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:33:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:33:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:33:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:33:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ywu3951FirfCp4c+ftfWeLKmxA+gjBownx4CU1omyLpCa7ev3vvz8TaRa97Vsu0hgOnne2+5du7IlG/fseO2+85Vn3mzyXiQkD3OlkCy3TpWuws+MX9cpDp0WebHsY1v8sWikVze5RlRVLjQ/hqeoDUgYVuHe75vwOwQwLMKKcPngrP/rnZObsapFVpOI5Do5PTaXEv1PyRbThTt/T1IyaUEbjI6fVJzLHsblY0aycYebpw75TYNytmmqlqBAj3bgc87XgMZWCtpSqIPE9bpMqLsPMyHwe8bqq09sTcIWLlgII2/wDUThkfraBmEDf4kIjsv3nS4G2qY23KC++DZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwtIEdJI7Sh5+I+L0Xz3hNEu9+7BPhaBNKKYG6Xr2qo=;
 b=K394HCJeKya80T27LLjmg7Rm+79uwzzcqYu4nDlw7zTdakFVaNzCJLncobuibjsqAdEcchncfJl1FcabuoHFRAApd6S3mLzwLFeZIxVVAScIAp7eDoX1B5qxYKIA1Y+ToXhJi8iYffDiBVFHa8oJezpxcnIWoFJ5Qvx42hZPiawcPbcIBa1vqlkJSoWyE46yKw1AUWffWabo7BFbh7Vj92SnkseFeulxKZa7ej20he9WeB9hv1Pz6afSkdNiagc7Sx7437+WErW/AI9E5QM29OfxOu6EfOBGqERAtpGfUB7CdTt6F1jHIMiD45lGaIwIgIVzZdb4kJGiXEAylmiE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:33:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:33:16 +0000
Message-ID: <fc52873b-0d9c-4ec7-9f04-5b99c31c8d8f@intel.com>
Date: Thu, 12 Oct 2023 14:33:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 12/15] net/mlx5e: Refactor mlx5e_rss_init() and
 mlx5e_rss_free() API's
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Adham Faris <afaris@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-13-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-13-saeed@kernel.org>
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
X-MS-Office365-Filtering-Correlation-Id: c3d3d0e1-e9fe-4f9e-8ab0-08dbcb6ad8bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aChuNySM9og3EfVyrYD1hRPelm9B1jiD9X/efuYh6UUuKe6aR7Y+a9gwoTDmQju/WaoIHAw1Pw1sY7NaQLFDB4rVOHFOssPdwmuHaX5u0GQe2zSLyCXzwNcGpOdD+QtKTk47UAwe8uP3IZv0t5B+3h2SXkwd/iqBbF4EfNBlsDmVw1gaY9YWURb3qyuQvxKhIjUYuu085zCZocGWcR+5+o/DKijg7H8JSnUCcTeUwQ6q/qkYWprNOvVGGFafZQPpq6GKZosjZz604/EwpU0I0/rDnv7VzKWYaFJUV+UYJwRuL/cLMZmIeWYpfsjRiJ4aqME3Tm8230HhOONpRbgy4zE6VtNVuu19WMd8mquCKvZK1G123rN4/S1AQ6eect2Ht1CHK57MyBjTaEnlP1J0bFP3/E65JM5QiZPYmBs978dOTdlvHnX7/MtTyPzItz4irKvEHOi7+RUWV9oDSbSYbAPfFnE9w+Na6ZfBh7YqyGpYUUaCL4rM8ezHtJwkPMn3sg4eiwK5I8bQuC456vrJXlFysPyCWGPaF63UzaGtiJpNsQM83Y7/TK49GCdVR+eaOd09Tx8Wkkzoyn9LihcJNN3qtd9WSok6eRkYf1ED2FJ9c+jUiGYTNZIYidW6lJ6hZCMrnQ8rOCyn/yM8Qt9YhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(82960400001)(6506007)(36756003)(316002)(83380400001)(66946007)(66476007)(54906003)(66556008)(110136005)(53546011)(2616005)(86362001)(38100700002)(6512007)(31686004)(6486002)(478600001)(31696002)(2906002)(5660300002)(4326008)(8936002)(8676002)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0cva2tiOVFNRWNRRWlGOXpKVUQ5RURLVEE3WG4rTUxrNGM1M0pkWkZDYkdQ?=
 =?utf-8?B?TkQxWjN6SEpOYUcvV0FjbkRNdU1wUS9STzM4aDlMaE5ON0hsM1doaEIvcGE3?=
 =?utf-8?B?dnpDdnVPVW9mdHkzREpkeGVXYjlGQXhkMVlPOXJZQlZzN3dVWGo3aWVFdjE4?=
 =?utf-8?B?SEVRaTJ5SENxUlp4Wi9yV3crSXZVMVc3VWdyRjNwQjU1dW9JU0w2eXBLcmNk?=
 =?utf-8?B?eVNZcEF2K0s3Znlwa05KdHZhRkFCRWlyK3JvSjFjdy9TTU1WL2dFZDFJelcv?=
 =?utf-8?B?OUFTL0pPRzZPcWYyQjJ0ejFNNjkzbEZCcUh3bFlEN29RSGpOVVZ1bkdaR09t?=
 =?utf-8?B?bWZMQ2t3eGV5d0x1bDlFRlBTL2I1N3NxTGJwOUpFZkpRck5Cdk55dG15bWF3?=
 =?utf-8?B?Ui9DblB6R3g5SFZzM1NMcFZ0QUNJS3QxWmxFVDVXUGZKRWxEelRHTkdTamp0?=
 =?utf-8?B?Uk1VcE54N3k4NitZRmJqWmpMSERsT1NZaWs3UnNuUjB4ZTh2K3J1U01welBs?=
 =?utf-8?B?WTZ3cU9UVjFGcENyOFNwNEZvbmlmRGNjbnRhNWlmS2VNN1BTdE1EZDk1UjVj?=
 =?utf-8?B?OERBdklGc0hONVJrTm1NMlVLaCtYbUNOdENQaEtBS01yaGZZMlhQelpsUnhp?=
 =?utf-8?B?MkFxN3N4N3M4NzF5Umg2K2JoWWlHNmxHUU5EeHltOXVXV3V2cUJFVjF4UWxv?=
 =?utf-8?B?NE16bzZNZDJicEJvTTZLeDVGVnBueStaZ09VY2FpejcwVmo3RjFmcmY2Mm1M?=
 =?utf-8?B?aG9IQXo5elJ6WEJmVHFYeHNTcFBhOEwzNSs1dlY3cnFXNkFUZ0RxYTNNRDIr?=
 =?utf-8?B?RDBMaTBvWUx3S0s0ZUtxSkx4eVZVbWNlSmZidGdhbFFOVkdOQUlKeXZZSkly?=
 =?utf-8?B?QkFEYmR6RktDYjBVU0VxRDBaSXQ5ZkQ5Tk5VRjJ1MVRpNGt3OGNjMmdjYTEy?=
 =?utf-8?B?V0U3M0I5WkFaaFRIZjFxR2ZadzBxcEFTTDBWRi9WNEhrUlowWnZrUThTTUht?=
 =?utf-8?B?NzBCYzlSY0lkOGpKVEV5dkFCMEw5bHJDRmpuU0l3bkVMa1lNUFBMZC92M3g2?=
 =?utf-8?B?NlF4dWdMN1FVNldScnhTQnVIVGFKVVhZaW1hUHJEczJ0Z0M4bTg2ZHpJeUJy?=
 =?utf-8?B?Zk5PakxpakNOZllMdFFxWjNpV3hPK0FObkpFa0IzR25MQ09CcjZhcWIvZFF4?=
 =?utf-8?B?SEN6VEFmZ2pwNENibFpxL25lTFhzMmwxWVg3RGRUM0FhL04xSUxDWWVEMzZa?=
 =?utf-8?B?c0dnVlhtZU1DY29jWUQ2SHNGUzNNYlJ0eEY3OVY2RVhsWnZmaDBwSks5OHFH?=
 =?utf-8?B?cGw4MXVPVktEVCt3czA5T0lsQyt1RzNhcEt1bVFvQ2loU3lRZzdWOGxIQnpl?=
 =?utf-8?B?RitETmtPVDcvdjN5dy9CUys1Q0p3Z2hqcmZHbk9WU2xueWY5UXMxQWNaeW1l?=
 =?utf-8?B?aUlhK2xCT091RVl2cTZ1azFnYWVIekMwOS9BcmMybHNwQytiRDhJOTlUU0dk?=
 =?utf-8?B?Ulcwc3VVeUFKcFFZMjR6T3haUEdMS2tkWTJDd2V5VzRtMC9tV2dzSmZ6V0N5?=
 =?utf-8?B?dGI4bHFYL3QvRG5DUDUvODNaQURXK21qVmx0ZDdSbGJFWDR1cE1icXBaSWFp?=
 =?utf-8?B?ZnMyV29KMWNOTGM5VXZoUURUSWkreXM2OXB5TDJlb1pVMVk2N0ZiRHY1NXdx?=
 =?utf-8?B?bjd2ZWllQm81cHJtK2lrUkN4c2pSSGM3cXFiUEdUTUxzcmtaYjJCTHl1VTVB?=
 =?utf-8?B?SDlLT3RIRml4a3Q2aGpwMTcvc0tVY2EyWjJxY1hZRW16TE12TWo1QmdRR2Zk?=
 =?utf-8?B?V2hBSld1UkEzU0VHWkhXc2NSYnJ6UklqbXR0bERUUkpTTmtMM0FTMCtUMXJy?=
 =?utf-8?B?SWo5ZXRTaEpkQUVWTHVoL1c5NzBsN2tWNE90VHNjMHIxaTNJTWR2MzBLeFlk?=
 =?utf-8?B?dmhlMHVVa0tmdmhyR3lTSDNnRXNJbnBBSFZUNk11SXB0cVMvUlNYeCtOUHhn?=
 =?utf-8?B?eGpoVnNGMFdubXphWm81bUZNNisrbUorVndHQ3B6NmJGOEg3YnM3YjBkSmRi?=
 =?utf-8?B?UlFwVEV2bDZPS3gxL1JwNkZFb3cxaGxOM2lya1ZWU2NQNlZieXV4WnR0Uk5O?=
 =?utf-8?B?NW5neDliUG44VlFWWU5GOGtuVWJaTHhCSHdJVldyUG5DbHRWK2lSWVk5YmxX?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d3d0e1-e9fe-4f9e-8ab0-08dbcb6ad8bb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:33:16.6968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqxOg2ZiakVYciC75G6Nt4auM2a3CqyO7l3ApRzKxQkYZDlNgxAsrvH2nYSeC5SbVgF2J2ID5vu731WGgj8fBMhdnMMPKfkK2alIepwKICo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Adham Faris <afaris@nvidia.com>
> 
> Introduce code refactoring below:
> 1) Introduce single API for creating and destroying rss object,
>    mlx5e_rss_create() and mlx5e_rss_destroy() respectively.
> 2) mlx5e_rss_create() constructs and initializes RSS object depends
>    on a function new param enum mlx5e_rss_create_type. Callers (like
>    rx_res.c) will no longer need to allocate RSS object via
>    mlx5e_rss_alloc() and initialize it immediately via
>    mlx5e_rss_init_no_tirs() or mlx5e_rss_init(), this will be done by
>    a single call to mlx5e_rss_create(). Hence, mlx5e_rss_alloc() and
>    mlx5e_rss_init_no_tirs() have been removed from rss.h file and became
>    static functions.
> 
> Signed-off-by: Adham Faris <afaris@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

