Return-Path: <netdev+bounces-40489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAC7C787B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4475282B5E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925F3E46B;
	Thu, 12 Oct 2023 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTqNehPh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268034CE2
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:18:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFCDA9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697145534; x=1728681534;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9uhoAW8o5bULJnew3n77BKUZsGDFf7VO9eBdHtfPFNE=;
  b=aTqNehPh5gj6xqGLpT8YG/cXt0WR5PkfJzhas/PvjnnTmN0ah+qmJzqI
   Q+ED42of+9S5I3VjT9k7gU65XEdf3MIeo3q6o42xJPHJi1xrcT2CxtixV
   /GZcg4W150ufusVnR/GU1x0La6AAa6v+aPyrYrdT6zX5SIrSUIWfsIaPo
   gObF3POI8Q03xp+QahsbQEyLUrRPXaR75u1Ol6AwpA6+i0vYfdZ4B3UcQ
   qJAxEpdnMMM0egGUy+dbBGLm3o1yoFqGcyi9Mb5O8LNTmJ42Oy41JgX68
   XjBmT9fFvQOhvE48kt9kZv3G8m3fh/GCgN5HbUlpERPAoUSoM0/BO9TLa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3634176"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="3634176"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:18:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="928150871"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="928150871"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:18:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:18:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:18:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoRHX9o7A8bOicpzvPpdT1Q/R4qPAnPeIEouLDCFeWzozmz1Ooo8tgBxMF5kk9Dni5WZgcDS+l+rLcq550SVtPnaSQzopIRXjBiGNPxIZ01fD0SktIU4UVETVxjggX40ZOPVHROLnXhuUwukDXl0lzGCKYBrNdpXa+LOaTHO0i1alJWz1/z4HZZyskriksTh41C7pSbhAoAVEEWfXmBATSYraBguojBwFbO7l0WJ/68wKibwa5V8/35DvZKQvAXk1mx3n2hsjl7HGRL+soCkYDk+KRRLJ5Lv5TMpYlW5rPpqtyBqynI//1IGjljjNnaiBljTs50rOlfUVhHeTqYZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKBJyg+t0c1Eb07yBH7JbXDNRpZ9svJfFl2758el6ns=;
 b=aPfoB78LSLH9/vd2qyUVXidJnWdVWiQVMeFKiNOlizGnkTGHoLmKiGt7CKaPriOe7nYI5NMzq5EQxbucienJ/NsGuqCwxzRmtQHbvHdlgHXroX1PxwUHFR0ujjFz4uyva7drJ2qHST5/NjRmmsBPaklotg4kFnAaGuKEsJuBaeN0xtmKyYOwdmmDBznc8av5x5m72bki8Z4QPouX4jPoQDmEOJXI4iJ/Gf2zsHCLdESSQf8tkDQUrGJ2UtUc0Zwc+GRUFj+MddJCCrh3//rapmtQKEm7OpwuZt8p2plb1LCc4FbmxjPj7t+RwOHmBwPfSqtX4g9HT21y8tWyeXcHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:18:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:18:51 +0000
Message-ID: <acfa1cb3-0d16-46f8-9b18-fbce5c30f101@intel.com>
Date: Thu, 12 Oct 2023 14:18:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 02/15] net/mlx5: Redesign SF active work to remove
 table_lock
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Wei Zhang <weizhang@nvidia.com>, Shay Drory
	<shayd@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-3-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-3-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:303:2b::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a45335d-1308-4c05-c938-08dbcb68d4c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmWqo+JeFOffyd+6HxZJNyzUUzGowXVd6jHhTipookExrfF8iZBPzF/bxtxyIMFCixJ4yj5VVgbAvtW3tnXM/oGXQXFaeocVIaqw2DDVZcvXVO7zINqSih3rKGb4hnrXH4NHX4Q4ztldckPU2dfIstcciH9aqb2AY89s750RaGrUsh7aYB0Hyf/1dzFbPB52GcA7jTjGVqO+bcLaaZQpeFWOzuGYlFzQ5zEf61R1hq16hH6KbQN8fN8XPs5SF85KbVLE1vtIuqY8SWPruqcFFXgpwmOWEZjjbglLMJGnJoSf5Khx4pedOeiM0BfMC5XDQ5W0naBGlPA09ooHSOdQn3S6uBypcrQHSeqKjzpWf/vSVVVkWoolUgrbBt5o4g/eLfGxZx1QV0dtqY05jf3hsMdie8WhwfkxRa61kLD7OrnNtbYjleaFBpHpYKXOu3Qd2lRZ7D/mwnDLdJOFUhOEos44JlXVinHCmYshkMB7yUnqWl7sAxhIfwJ9D8T2OzGUDq6Qx3bFDYuu//8YEW9Q60tswhWLXdi4srr1ZSbx8tA6aEzHZgg5DE6py+WlqkWj6sPQrr8X2/GvFkekph3kuPfaDcyTGjnjZP9IKkKwWkPPGXqSTNNhMC8S1itHzPkR/tM86Y5UPaBHBkmL7vqCsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(31686004)(6506007)(53546011)(83380400001)(26005)(2616005)(66899024)(6512007)(38100700002)(86362001)(7416002)(2906002)(31696002)(30864003)(5660300002)(6486002)(8676002)(4326008)(110136005)(316002)(66946007)(66556008)(54906003)(66476007)(41300700001)(36756003)(8936002)(82960400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJ1RHBxUCtqL2lkZ2p5czd0ZXpyWVJ0L2srY1d4Vld5UEEyM3E2bWhuNmNx?=
 =?utf-8?B?SDBJQ3I1Y1N2bzNmVWovM1hHYmpCK2pFOFRlTzMxbTQ4TllRM1hyWHZ6TEJZ?=
 =?utf-8?B?Qk9PYk4xLzQ4ZjlIZHVYN0FFenBnMGpxUEZRQVF4SHBpWCtjaitYZ0pkNDRm?=
 =?utf-8?B?bmRLS1E3MEZ6WTBHSFoyOW4xRmY1UEZOaFdWTC9XZ3Y0cWI2WUljNDNYYy9S?=
 =?utf-8?B?djZWYVY3YUMxbXpCakFFWTFHeWJTTTkrYi9Cd1k1L3BjU0M2cTNiYllNWnBS?=
 =?utf-8?B?QTFnVXF3YTFkVUNnQkNVSHZwcGRYTk9HREttLzZldjUyQ091bVNTNDVuYTll?=
 =?utf-8?B?ODBWa2JWV1VrajlKczQ1RW9sMnNNdHk3QXFiRFo4VkRJVzd4VU1oaHNWdHZ0?=
 =?utf-8?B?c0RhM3VCZ1BDOUJHckhtWW8xNHlNYXVvbDNYd1JRa0JTYUpldUR5NDU1OU50?=
 =?utf-8?B?OUFmWHppYVRKLzdIZW9qR3prSGlRSWJmdDY5T012VC9MZFppZnpkWUQ0K3JS?=
 =?utf-8?B?OEs1eFdLODZGMVBBUkR5eTg2NWpFUExZTXZSMWdjSVpyQmpLbmxyQWRrb0Yy?=
 =?utf-8?B?Uk1pZVZOUk1rSTkwb1lOWk5lN3ZvU0RqbklqMVIySWhjdm9abnMyRmc3dUF5?=
 =?utf-8?B?STROcytuUkEzdmMzOXhXWDlmOGU3ZkhZTHJqNjZOVHhhTjZlQnhpWnhGbEJk?=
 =?utf-8?B?QWtuZVBUbUo1ZW04Qm9MVU5xZnBxQ0Y4Z3VobVVyeEdwanlWSXU3VFVRcEpx?=
 =?utf-8?B?TVRsTStEUkNveVlYQ25TOEtXQ1R6SGtpam1SYTk2eEdQc09Gc1VaK2x4QkVs?=
 =?utf-8?B?dkdKQUJ2TktMY0drUzJ3YkZlallaclVzQ1ZWVGcyWDBQN1YwMmluYzVGZnZL?=
 =?utf-8?B?aGhzM3ZsYThEUllWVUFkNE5EYW5HNFdhTDl5ckRWeDJCK2g0bTdlam9KT3Q4?=
 =?utf-8?B?amUxenVyRFhqTHVJbDZNbzFDVnN2Wnl4Wk5VUHZ5bXhXREs4MGNMSFN5Vkow?=
 =?utf-8?B?TVBicGtzdlFOb2tETWx5dElsNnk1eFpHZFJ0cElXcUhTOFZKM2toWUxpdFg4?=
 =?utf-8?B?ZFRKVUc0Z1lLQlh0cTMwcG9wemtENDVzaHZ2OHFJR1RhR3pQeSsydlNYajBX?=
 =?utf-8?B?b3JKaEd6VEs0dUcyTy9YZ0FkN3p1RGxHcytsL3pLOWRwNFhSc0dETU1TQVk4?=
 =?utf-8?B?a0tFNDdNNndxd1pKenluL2JrWXpBT2thMEhyUHJRQjNWNUwrSGpWRW1xQVRW?=
 =?utf-8?B?UkVJTUFMUm1yV29Kc2xKL0prbzhnMmF4eFF6aTF6cWpBQUdwVGdzRldndTND?=
 =?utf-8?B?cjIyL2FBWEd2b1ZpV2o3bTdLWUR3M24wL3ZCekFFZUt3TVBRL2dNODM1bDdZ?=
 =?utf-8?B?SWxlY2s5ZDRJV0JOa0Y3WmlGNTB1VGhiSTBGU0M1UGxnRFltN0k4aXM5blk0?=
 =?utf-8?B?b01vTmRabGNSeFdnRTl4YVYreHc1clZYZjJXZmVPQlY2bGxVV2hza2FoZ21Q?=
 =?utf-8?B?TDFud1ZFNmk2VG8wbGJEMS9wUjRJWFQ5bENuR1UyRWRiZEpHWWpSdGEyc2hu?=
 =?utf-8?B?eHFERGNhMlJYN1JMaWcvT0Zza1BPbkYxYWRhbmJBK3Zad054ZytRdlJhMS9J?=
 =?utf-8?B?VmdRVC9Hc0hOaDNtc1dmUmIvK2JYTzl5QjFQYVI4RHlmWEVyT3ZBOHJiZnZF?=
 =?utf-8?B?dlQyWHU0Z200NHhDV2JxOGZYamJnWDNVMkwxdGQ3TDQ1am1rM2ZvaXc1TUpR?=
 =?utf-8?B?QU9wejFmREJIbkg1Q2JNWTZGdWhWZURWN2NCZ05ISFArZzhXOC81KzNaeUlF?=
 =?utf-8?B?Q0dTS1lsNmF5NE90bmx5cnc5R2F2NEdRMjRpTkVmWm9qaGVnbXZHcWNUZllw?=
 =?utf-8?B?ZVhRTXdyb2RtWnZ5MWpoN3lFUm1ST1padG1majFNcmlxUzg3RUpMWDR6UzdR?=
 =?utf-8?B?TnoyWjVoT0U4NFVXajR5SzE3a3lDR2RBUU01aTR4cmR3cm50Y0NySHZvbmVn?=
 =?utf-8?B?SkNuV1V6MGtwK0RoRWN3TktaMVR2b3h0UnlJMjlxZnphVTdtTHpYbzk5VUZm?=
 =?utf-8?B?OS85eVpkS2xQSmV6dU1XeTNiZysvUllFVk5PQXdjekdsVnZSenU0RERnZ3Nk?=
 =?utf-8?B?bHorN1o1M1BGV0xaWFhKWjhvWldxOEttOGtSL0hFd0JTQW5lWW00RzZFZjFr?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a45335d-1308-4c05-c938-08dbcb68d4c1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:18:51.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLFc0FoaMDwVOuX6vPdzUiXF8ZgkTTNVP1NqisT5FO9B7f3fPA2jmRU9EyA0dApBKja3rFD+36dt+xtpgSKgU5HaT/+2GMMuA5QUwIP6zWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Wei Zhang <weizhang@nvidia.com>
> 
> active_work is a work that iterates over all
> possible SF devices which their SF port
> representors are located on different function,
> and in case SF is in active state, probes it.
> Currently, the active_work in active_wq is
> synced with mlx5_vhca_events_work via table_lock
> and this lock causing a bottleneck in performance.
> 
> To remove table_lock, redesign active_wq logic
> so that it now pushes active_work per SF to
> mlx5_vhca_events_workqueues. Since the latter
> workqueues are ordered, active_work and
> mlx5_vhca_events_work with same index will be
> pushed into same workqueue, thus it completely
> eliminates the need for a lock.
> 

Ahh, here's the reason you need single-thread work queues.

Minor nit with using _work instead of keeping work variable, but not a
big deal:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Wei Zhang <weizhang@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  .../ethernet/mellanox/mlx5/core/sf/dev/dev.c  | 86 ++++++++++++-------
>  .../mellanox/mlx5/core/sf/vhca_event.c        | 16 +++-
>  .../mellanox/mlx5/core/sf/vhca_event.h        |  3 +
>  3 files changed, 74 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
> index 0f9b280514b8..c93492b67788 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
> @@ -17,13 +17,19 @@ struct mlx5_sf_dev_table {
>  	phys_addr_t base_address;
>  	u64 sf_bar_length;
>  	struct notifier_block nb;
> -	struct mutex table_lock; /* Serializes sf life cycle and vhca state change handler */
>  	struct workqueue_struct *active_wq;
>  	struct work_struct work;
>  	u8 stop_active_wq:1;
>  	struct mlx5_core_dev *dev;
>  };
>  
> +struct mlx5_sf_dev_active_work_ctx {
> +	struct work_struct work;
> +	struct mlx5_vhca_state_event event;
> +	struct mlx5_sf_dev_table *table;
> +	int sf_index;
> +};
> +
>  static bool mlx5_sf_dev_supported(const struct mlx5_core_dev *dev)
>  {
>  	return MLX5_CAP_GEN(dev, sf) && mlx5_vhca_event_supported(dev);
> @@ -165,7 +171,6 @@ mlx5_sf_dev_state_change_handler(struct notifier_block *nb, unsigned long event_
>  		return 0;
>  
>  	sf_index = event->function_id - base_id;
> -	mutex_lock(&table->table_lock);
>  	sf_dev = xa_load(&table->devices, sf_index);
>  	switch (event->new_vhca_state) {
>  	case MLX5_VHCA_STATE_INVALID:
> @@ -189,7 +194,6 @@ mlx5_sf_dev_state_change_handler(struct notifier_block *nb, unsigned long event_
>  	default:
>  		break;
>  	}
> -	mutex_unlock(&table->table_lock);
>  	return 0;
>  }
>  
> @@ -214,15 +218,44 @@ static int mlx5_sf_dev_vhca_arm_all(struct mlx5_sf_dev_table *table)
>  	return 0;
>  }
>  
> -static void mlx5_sf_dev_add_active_work(struct work_struct *work)
> +static void mlx5_sf_dev_add_active_work(struct work_struct *_work)

Whats with changing this to _work? not sure it helps readability at all.
You don't use work in the function elsewhere except as part of
container_of which was fine before. Either way, not a huge deal to me.

>  {
> -	struct mlx5_sf_dev_table *table = container_of(work, struct mlx5_sf_dev_table, work);
> +	struct mlx5_sf_dev_active_work_ctx *work_ctx;
> +
> +	work_ctx = container_of(_work, struct mlx5_sf_dev_active_work_ctx, work);
> +	if (work_ctx->table->stop_active_wq)
> +		goto out;
> +	/* Don't probe device which is already probe */
> +	if (!xa_load(&work_ctx->table->devices, work_ctx->sf_index))
> +		mlx5_sf_dev_add(work_ctx->table->dev, work_ctx->sf_index,
> +				work_ctx->event.function_id, work_ctx->event.sw_function_id);
> +	/* There is a race where SF got inactive after the query
> +	 * above. e.g.: the query returns that the state of the
> +	 * SF is active, and after that the eswitch manager set it to
> +	 * inactive.
> +	 * This case cannot be managed in SW, since the probing of the
> +	 * SF is on one system, and the inactivation is on a different
> +	 * system.
> +	 * If the inactive is done after the SF perform init_hca(),
> +	 * the SF will fully probe and then removed. If it was
> +	 * done before init_hca(), the SF probe will fail.
> +	 */

This is a scary looking comment. :D

The result seems ok though: if you deactivate the SF before it starts
probing, it fails to probe and is this never activated? Ok.

> +out:
> +	kfree(work_ctx);
> +}
> +
> +/* In case SFs are generated externally, probe active SFs */
> +static void mlx5_sf_dev_queue_active_works(struct work_struct *_work)
> +{
> +	struct mlx5_sf_dev_table *table = container_of(_work, struct mlx5_sf_dev_table, work);
>  	u32 out[MLX5_ST_SZ_DW(query_vhca_state_out)] = {};
> +	struct mlx5_sf_dev_active_work_ctx *work_ctx;
>  	struct mlx5_core_dev *dev = table->dev;
>  	u16 max_functions;
>  	u16 function_id;
>  	u16 sw_func_id;
>  	int err = 0;
> +	int wq_idx;
>  	u8 state;
>  	int i;
>  
> @@ -242,27 +275,22 @@ static void mlx5_sf_dev_add_active_work(struct work_struct *work)
>  			continue;
>  
>  		sw_func_id = MLX5_GET(query_vhca_state_out, out, vhca_state_context.sw_function_id);
> -		mutex_lock(&table->table_lock);
> -		/* Don't probe device which is already probe */
> -		if (!xa_load(&table->devices, i))
> -			mlx5_sf_dev_add(dev, i, function_id, sw_func_id);
> -		/* There is a race where SF got inactive after the query
> -		 * above. e.g.: the query returns that the state of the
> -		 * SF is active, and after that the eswitch manager set it to
> -		 * inactive.
> -		 * This case cannot be managed in SW, since the probing of the
> -		 * SF is on one system, and the inactivation is on a different
> -		 * system.
> -		 * If the inactive is done after the SF perform init_hca(),
> -		 * the SF will fully probe and then removed. If it was
> -		 * done before init_hca(), the SF probe will fail.
> -		 */

Ahh, a pre-existing comment ok!

> -		mutex_unlock(&table->table_lock);
> +		work_ctx = kzalloc(sizeof(*work_ctx), GFP_KERNEL);
> +		if (!work_ctx)
> +			return;
> +
> +		INIT_WORK(&work_ctx->work, &mlx5_sf_dev_add_active_work);
> +		work_ctx->event.function_id = function_id;
> +		work_ctx->event.sw_function_id = sw_func_id;
> +		work_ctx->table = table;
> +		work_ctx->sf_index = i;
> +		wq_idx = work_ctx->event.function_id % MLX5_DEV_MAX_WQS;
> +		mlx5_vhca_events_work_enqueue(dev, wq_idx, &work_ctx->work);
>  	}
>  }
>  
>  /* In case SFs are generated externally, probe active SFs */
> -static int mlx5_sf_dev_queue_active_work(struct mlx5_sf_dev_table *table)
> +static int mlx5_sf_dev_create_active_works(struct mlx5_sf_dev_table *table)
>  {
>  	if (MLX5_CAP_GEN(table->dev, eswitch_manager))
>  		return 0; /* the table is local */
> @@ -273,12 +301,12 @@ static int mlx5_sf_dev_queue_active_work(struct mlx5_sf_dev_table *table)
>  	table->active_wq = create_singlethread_workqueue("mlx5_active_sf");
>  	if (!table->active_wq)
>  		return -ENOMEM;
> -	INIT_WORK(&table->work, &mlx5_sf_dev_add_active_work);
> +	INIT_WORK(&table->work, &mlx5_sf_dev_queue_active_works);
>  	queue_work(table->active_wq, &table->work);
>  	return 0;
>  }
>  
> -static void mlx5_sf_dev_destroy_active_work(struct mlx5_sf_dev_table *table)
> +static void mlx5_sf_dev_destroy_active_works(struct mlx5_sf_dev_table *table)
>  {
>  	if (table->active_wq) {
>  		table->stop_active_wq = true;
> @@ -305,14 +333,13 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
>  	table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
>  	table->base_address = pci_resource_start(dev->pdev, 2);
>  	xa_init(&table->devices);
> -	mutex_init(&table->table_lock);
>  	dev->priv.sf_dev_table = table;
>  
>  	err = mlx5_vhca_event_notifier_register(dev, &table->nb);
>  	if (err)
>  		goto vhca_err;
>  
> -	err = mlx5_sf_dev_queue_active_work(table);
> +	err = mlx5_sf_dev_create_active_works(table);
>  	if (err)
>  		goto add_active_err;
>  
> @@ -322,9 +349,10 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
>  	return;
>  
>  arm_err:
> -	mlx5_sf_dev_destroy_active_work(table);
> +	mlx5_sf_dev_destroy_active_works(table);
>  add_active_err:
>  	mlx5_vhca_event_notifier_unregister(dev, &table->nb);
> +	mlx5_vhca_event_work_queues_flush(dev);
>  vhca_err:
>  	kfree(table);
>  	dev->priv.sf_dev_table = NULL;
> @@ -350,9 +378,9 @@ void mlx5_sf_dev_table_destroy(struct mlx5_core_dev *dev)
>  	if (!table)
>  		return;
>  
> -	mlx5_sf_dev_destroy_active_work(table);
> +	mlx5_sf_dev_destroy_active_works(table);
>  	mlx5_vhca_event_notifier_unregister(dev, &table->nb);
> -	mutex_destroy(&table->table_lock);
> +	mlx5_vhca_event_work_queues_flush(dev);
>  
>  	/* Now that event handler is not running, it is safe to destroy
>  	 * the sf device without race.
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
> index c6fd729de8b2..cda01ba441ae 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
> @@ -108,8 +108,7 @@ static void mlx5_vhca_state_work_handler(struct work_struct *_work)
>  	kfree(work);
>  }
>  
> -static void
> -mlx5_vhca_events_work_enqueue(struct mlx5_core_dev *dev, int idx, struct work_struct *work)
> +void mlx5_vhca_events_work_enqueue(struct mlx5_core_dev *dev, int idx, struct work_struct *work)
>  {
>  	queue_work(dev->priv.vhca_events->handler[idx].wq, work);
>  }
> @@ -191,6 +190,19 @@ int mlx5_vhca_event_init(struct mlx5_core_dev *dev)
>  	return err;
>  }
>  
> +void mlx5_vhca_event_work_queues_flush(struct mlx5_core_dev *dev)
> +{
> +	struct mlx5_vhca_events *vhca_events;
> +	int i;
> +
> +	if (!mlx5_vhca_event_supported(dev))
> +		return;
> +
> +	vhca_events = dev->priv.vhca_events;
> +	for (i = 0; i < MLX5_DEV_MAX_WQS; i++)
> +		flush_workqueue(vhca_events->handler[i].wq);
> +}
> +
>  void mlx5_vhca_event_cleanup(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_vhca_events *vhca_events;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h
> index 013cdfe90616..1725ba64f8af 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h
> @@ -28,6 +28,9 @@ int mlx5_modify_vhca_sw_id(struct mlx5_core_dev *dev, u16 function_id, u32 sw_fn
>  int mlx5_vhca_event_arm(struct mlx5_core_dev *dev, u16 function_id);
>  int mlx5_cmd_query_vhca_state(struct mlx5_core_dev *dev, u16 function_id,
>  			      u32 *out, u32 outlen);
> +void mlx5_vhca_events_work_enqueue(struct mlx5_core_dev *dev, int idx, struct work_struct *work);
> +void mlx5_vhca_event_work_queues_flush(struct mlx5_core_dev *dev);
> +
>  #else
>  
>  static inline void mlx5_vhca_state_cap_handle(struct mlx5_core_dev *dev, void *set_hca_cap)

