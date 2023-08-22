Return-Path: <netdev+bounces-29656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C078449E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADEE280E23
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A531CA05;
	Tue, 22 Aug 2023 14:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2F8F45
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:44:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D585F124
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692715489; x=1724251489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nteqYLE8OVHV638aEcg6/R5kWYgvC+DY0fun3TxJyTE=;
  b=YV3Ty+YhAAaJxs7KZliN2vFnAeU1hjkcpKvWlm6oc3kxtvqedy3bEPOW
   qsPfdtFxgnAo3uhcWL2/18knHk8Eo8rv1YNThq5FwOu8t2gSuYP5WCeX8
   PiasEdF24LLRrBoNj5VrjHUiH3gFlVkYVFjtZ5ZzuxFpAMfpsg1lyuIan
   gHzMJqpmT/38OEYNFYZrtO0uyDGMpQyt+y+3bSaogezvwTxyzAynZpgbR
   XeWoktGuVbokzN8k9we9VYRv0j+5xaH6ZvhxB83QLlLPxqY4T7IKEoEcE
   6qH1ShDn8b5xO5jZSvej0MMjcZhV59p0IVBQdi1ODO5Lx4yCwogv7uGHQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377656245"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="377656245"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 07:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="713184179"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="713184179"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2023 07:44:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 07:44:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 07:44:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 07:44:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 07:44:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaDvM4WqgT0LIJ2FsoKeDdUqloLnhLYZ20vikFjzauhpsR0rifywkaAjZKwLnJNjen3Wz0ctHm2RtQMPdQjxLH+MYULmJToj8tTgufL2zYNtLPoA3lZKioFrWQCTp/+eF42bzYfp2X/Cv1tafVtVquNsA7vuyBhTsvhW7zZps1CzYbfvZT0B1P4Z2tPgB4Chd4FkkwqUZ20kJGKeG2fpVLq/GSJuFEYnq26Z3Fle1QOWn9UQ4kvbqSg0XYb720UB16djhbrAZy13Dw2pWFxAdG3HkJ5T+ApaVGbpddQMdjh100Fw/FDt/5BgaFbTNezY9Fxa0iRsm3B1tQUHHk/+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAesGsxnV+omO1dOzrTVmpAFC+vYNQSHP9u13lJY3kc=;
 b=dz3axw7I5ftiAB5QT1FLgc7okGGDfNsUXk1vSHAB8XbI/GPYuGNprftaWXjkNcVeWC1ouLVz1I7/fjqPw0hFkVNdvb83ozSL2IVul9g/Sf/tuow8uSTccIGFo33SusZLTva0NQwy3ghou7HNQSYDQxXlnwMfy7jDuAG/vAz3rHxMcpjAdH5eqJiXMLmQH4XC8xPRpA1kEU78iGAYRXLjl/pSPvlzx8JXGvZ+Pm7y+ULQhNpSPLcg4MtJi8WIi6TKQkc7hk2K9kvc6TA/VrEAwWFofp45PmLw0ofryNVE+xNALSW+gNvi+yYZkC3iwNadGZVm3LlhFKyouYpvAcUHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by BL1PR11MB5555.namprd11.prod.outlook.com (2603:10b6:208:317::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:44:36 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:44:36 +0000
Message-ID: <f497dc97-76bb-7526-7d19-d6886a3f3a65@intel.com>
Date: Tue, 22 Aug 2023 16:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/9] ice: use
 ice_pf_src_tmr_owned where available
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>, <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
 <20230817141746.18726-2-karol.kolacinski@intel.com>
 <20230819115249.GP22185@unreal> <20230822070211.GH2711035@kernel.org>
 <20230822141348.GH6029@unreal>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230822141348.GH6029@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|BL1PR11MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2aeec7-e6a2-41cd-a853-08dba31e4e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1AFu/J+o99B6AEY6pgK97r/JA4JXGgbUSrGEtgnUU0N7uTbNVapc4tYpo/CJZ8NAReUTyzGGdGTQxV1jp3VsBa2piR37VZa7eoPD+UxOG7FZu768E1ukRPmIYU5UcH40rWP55rI/GV59uxx7P0gI2NalF0VOVxsNeo3JwRnOJ/6yf3cLQ6AqOjG9dijUbZqelElDr49GeaxeCy++SqzF2jBt2slOVqVUKh0V1y3996gY/M+m6AgACTNMugHXtE+3QoX7rBmMUX5i/Fjyr4wbLiPMbIecm6Wv/ckszD3VteunTS9YFSvYbrPGirGV7Vw7PnZro8gOWKYGPie6LYkdq25v4O1CaFk7r4dq1C7AvnYJ5wUHAYe22brzYhHLWGSXe8Wmk0F4ptLKFcHRv/TyqumnBPK4r9bpA0S48V7u4bZ6fO8iYqdnAvSTAK1sVM30hshIugwynODnigopuUNqZGjKn2pWbWKCmwF6GmU5gNxcvLAF9GNPuQ4xMeRKlq9cKkARCtQQeDYBC2AdPeYYn9NfvdsAtzNCff/dQGZGA5Aa0phmLciPMKN+ptczZ9CP+BSBJD2PPIiGbSEWyN7m1hitSOT3eJOge399iJYqZS/5Jao6xapFieaBNmE7IIbBYzFdAO5N+2DmcEkpDqSeE7mqNLlq5/Pidfs8qXhb35ICiw8B80YmvdC14T+Kf1TY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(66899024)(82960400001)(110136005)(8676002)(8936002)(2616005)(4326008)(966005)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(53546011)(6506007)(83380400001)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2M5cGQ2NXB0WisxRGJYNTJOTW5KMlhDeHd1a3ptUFU2b0NuWXViemEvc2Fp?=
 =?utf-8?B?ejBuTzZ3MUh0WmpEUndhSU9MS01Dcm9QVGE0Ri9RTkNrK1p6eEg4MEk5ZXRv?=
 =?utf-8?B?OGdIY1h6M3lEQ05nVjU1RGU4UFRuMlF0VU9lZ3g4MldYbmRVaXVueTJyMW9x?=
 =?utf-8?B?dk1BeUVkNCtGeThBamZSZWVOcWl0cVRnbElMd1FnQVJ1cSt2dHZHd2tVdEpP?=
 =?utf-8?B?WSt5THcrWVFQS25YRU5TNWJ3SDJ3OFovdVRsTHdFQlpHL1ZuQjIxRDk4RW9q?=
 =?utf-8?B?S3RCc3U1d2JYbVl2YUc5TG5XUHhiaWtOS1RuQzRzV3h5b0plckI4YkJrb1FD?=
 =?utf-8?B?NjY2ZDRXRVpkWEZPNjM4QXhNMmNmT0FjQU1NSXFrd2pxemNBUU1yeUtDS012?=
 =?utf-8?B?ckptMDBSMkJFU0pFdWN1RUQrbEhoUmIwcGdMSWdDRlZNVjdjUjV5eE81NlV4?=
 =?utf-8?B?OUpoMXRCRlpHbVZMd0k2dHo1TFZjd3RKOHVEQWl4d1ZlWlUra2o4RDdsaTBW?=
 =?utf-8?B?cTBNZjVQN2t0dVJaeFBlbi9tSm96Nno5eVZDNVU3djRKTmVtV2xONTNqaXN3?=
 =?utf-8?B?TURWdE9yVjE2SU9nL3NvNTJseW9QK3lJb2ZFbzluOXpyWFltK2xxcVJXVmxG?=
 =?utf-8?B?cFVnMkNnMDVKeWx3MEd0SWYvSnJmTXNKMkx6MTVqSlFCZ1cvaWE1bk9jRWlS?=
 =?utf-8?B?bW9HK0x6OG9helFuaGdLcnFwWVNtVDhiNUp3cUxtQnMrZ0tsYUdBUXFoLzEw?=
 =?utf-8?B?bmtJejJYVG41Mlg4SWVFaHZuSzh0OGtnMjAyOGpWVDlnay9WbTRWT3ZZS0tt?=
 =?utf-8?B?UGlRMzhudmtQd3p2Z3Yrb0F4V2RlRGdEQjRHRHo3WmpqQ2RjMElsVDl4Q1d2?=
 =?utf-8?B?N29FZ2tmcGxRNkg5ZEp6RStxL1BmRndCcFgxeHI0K0ZsVWNJOUoyZVpPWUMw?=
 =?utf-8?B?RGJPT0l1QzNwMlZNdVp5WU81YkFSYUl6dWhZM2lYK3FnMm5EeVNJVVBLa2Np?=
 =?utf-8?B?NURBZWFCeUpuaXkwa1Z5RlM2WFVPSmhBUUE2UFg3SUFJUnVDR1VKMWJ5aFZ4?=
 =?utf-8?B?LzdvTExzckN1emN6VjVjWWF6MkZBd29MUGg1YjlpVnlTVHVLMzFqVHlvVEFq?=
 =?utf-8?B?MWptdU13VXdmOUdmdEFYWFVISWo1ZjFQQkFQQmdaNWZkcXoxbXRNNjVYb1Vt?=
 =?utf-8?B?b3FRVUlzVHR1QzFGTUpIUHNFY3ZNeExQQjJ6UjM2WWNFRUlka2ltUlFYUGtV?=
 =?utf-8?B?VWhDeFNuVE1mSUdiOHNsRm9CYmRna1BYa0M2M0l5bG1tbG9nRWRWYXJjNXZR?=
 =?utf-8?B?OStWcUFEVGdpNUQvcGhpT1QzMFplSmRRY3ZHaGRhU3p3eGFHRENMUmptc3RU?=
 =?utf-8?B?MWZhTUVHbkNzNjYwV3N3ZlZEU0J3RllMWFh6U0s2NW1MeVVGc2xxakJlUzB2?=
 =?utf-8?B?SHZkY3ZMRHY3TmR6K09wQ2tKTFE1OVZ4Nll1aWNpeXFCT3NGSGsxaERSTXNi?=
 =?utf-8?B?N3ByNkU2M3d1MFZTOU5SMnZ0UXNZazFSck5CaUtyM3R3eFZQeVdjQXhGVHZp?=
 =?utf-8?B?VzhhcHZMVXBnc0UrZ2Vscmc2SlRBMHRtalphYlNiVURQZjB1SnhmaWRtQWo3?=
 =?utf-8?B?YlJ1WUlZOEVTRGs3UUZWU0R3MExZelFsTUNqV2lpMDYzRmp5T0M5bGdGWkFJ?=
 =?utf-8?B?dzU0ckMzdTRYTFFIYWxMVmd3OU9BZ3pvR2JIZ1lzSm1DZXhTSjdabHQwd3c3?=
 =?utf-8?B?K0dpZ2VHditjUGxSU0duNXZteURGMVk2L2dlM25kb0c4ZkticUtBNVpQRXEw?=
 =?utf-8?B?YmRWWWtXejMxNUxzZ1RHYkt0cWRER2JvM0xLQ0p1Y2thTEVDcVRINGFVcTBk?=
 =?utf-8?B?SHlFMHN2ZHZUVTdqWjFDaTVOR21MVGg4cmZEQmtIMmpjM1gvWksvOU9sbmwv?=
 =?utf-8?B?aXdIN2Z5L0tjRUVvVytVcjZUSkpvZG43U3N4d1AwSjNHZDlwYkFhVUVpNXAr?=
 =?utf-8?B?V2lMM0MyRHh4aHFRYXpkVXlYblIwcGl3aWVzYXdiZGRUVjVBN1JoUllDQlox?=
 =?utf-8?B?RkpPcTkvV00ySnNybDc0OXM1MUxSR0IwS3laVWF6U3ZZNUluL0prQ2lrdnRP?=
 =?utf-8?B?alJMVW96aEJpaVJJWTNDREd3YUhLSFdKeEVIbWhlZnlGV3paWUViMGZYQ3RD?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2aeec7-e6a2-41cd-a853-08dba31e4e9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:44:36.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ekdluDdI8S0wptiRBUnq8dT3g9l3CujxJ2jlE9xEDl/6FlR5V9RAVf6/t7btJswjUE33n7cV1EUpKGsoUjl3BP1I8dStnJGNrUS2Nut39o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5555
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/23 16:13, Leon Romanovsky wrote:
> On Tue, Aug 22, 2023 at 09:02:11AM +0200, Simon Horman wrote:
>> On Sat, Aug 19, 2023 at 02:52:49PM +0300, Leon Romanovsky wrote:
>>> On Thu, Aug 17, 2023 at 04:17:38PM +0200, Karol Kolacinski wrote:
>>>> The ice_pf_src_tmr_owned() macro exists to check the function capability
>>>> bit indicating if the current function owns the PTP hardware clock.
>>>
>>> This is first patch in the series, but I can't find mentioned macro.
>>> My net-next is based on 5b0a1414e0b0 ("Merge branch 'smc-features'")
>>> ➜  kernel git:(net-next) git grep ice_pf_src_tmr_owned
>>> shows nothing.
>>>
>>> On which branch is it based?
>>
>> Hi Leon,
>>
>> My assumption is that it is based on the dev-queue branch of
>> https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
> 
> So should netdev readers review it or wait till Intel folks perform
> first pass on it?

Most of the time Intel folks would be first to review, if only because 
of our pre-IWL processes or pure familiarity/interest in given piece.

For this particular series, it is about right "codewise" since v1, so 
you are welcome for an insightful look at v3
(I didn't provided my RBs so far because of "metadata" issues :),
will take a fresh look, but you don't need to wait).


General idea for CC'ing netdev for IWL-targeted patches is to have open 
develompent process.
Quality should be already as for netdev posting.
Our VAL picks up patches for testing from here when Tony marks them so.

That's what I could say for review process.

"Maintainers stuff", I *guess*, is:
after review&test Tony Requests netdev Maintainers to Pull
(and throttles outgoing stuff by doing so to pace agreed upon).
At that stage is a last moment for (late?) review, welcomed as always.



> 
> Thanks
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


