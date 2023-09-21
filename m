Return-Path: <netdev+bounces-35613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE67AA0A7
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D04A281F96
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D419446;
	Thu, 21 Sep 2023 20:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27A18C2F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:45:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6BB37BC9
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695329104; x=1726865104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pW5g3ro1tU9TcgFsPtrHPupwfUSTIHwLIQVY9aH73uo=;
  b=IuhrpPT0evHDtJ0pq/edCLE3P0yxIsnJEToVWXuyUaeU+PwNFRLbcn8Y
   cW1BnZcIyfzEou+Xm9F/W3xI4xF/AY2t72c/p5FtkimJln9HnilweYwD7
   GM5TiL7eu6q1GG7GyzIhtqsbjbAx48wBL0UXdCsQs2ElZP9UgOLCWMBaj
   eriPOmeFKuf7VQINVSiFS9u9R4RArhLYbH0tjN9aJv9/HLmm+Y0DtUzNo
   nbVPhq9cjS+JaVJqP9bQoPwfxUq0p+3NGlIFI6u5eBiymmlabcynKu6xQ
   yJlYb53BosFjrYH4AVnm6vQYnHG99OK28j55eKbq9L4HlS+xLvhRZkW/i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360902343"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="360902343"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 13:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="862662586"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="862662586"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 13:45:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 13:45:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 13:45:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 13:45:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH+JN5AG7XObuPge6UF8+YVpfFJfMGgJVo1L7xfVx0EVOPBx0t0VKI06GqZt6U1yJhsXlGRYo9C9LicpjGZbj4lbv/DhdLHHjCKHb9cxvUXlKGfkafP/SjWY6iSFNhOq1GXjSszlWHfHkkolHS6cGZQMZkZDw8C9xUqwitcOW3gJ8osLfNs0xlT6XskzzizIffh35ylI1fJcNrKgKmH+J12YtlTfMvZqzbYNiZsyOMAnE5jj55D41MbLfEEpTfrYUkcnsmOU43jgMraL5YqSqHcU4yy0xkDisZ3COic9+cbb5Oq5EcScZ8x7oixd8bQsiVpX4soTir8+U7UM9LjwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wrnr4ILuNZJwava/QMiiXSxxZLwo2teLBiDZCxtkp4s=;
 b=oKD7vXYXeTszrlMK6PB+ZpaqmfD1KyF8UOPQr/5f5IT7Id1lNS8DWIA+t9LmH3M22m1jcS3dwnEh3qFwjdcxz1Ojdjk1/whT8DwiDQS7iBZNRqi+K4RFW2spf8U/HppVDLjR4+36uaiPYbo11GDyEdcIH6oRRXMQaJMf5IObHTVK41qLjb+VQ/HSlTK88zWkrrpNe6l3QSTbvIJfHzsOAdoZ0peNcUUnbBFf0HKgOMTu1x1BXCVhOZK2rKvsGMcWrUKLw6eUwau21rH3rhGKmSw9F3WySS9S0ItQkiZQDQGVf/RC/wOUN++RHssA1e2ce+6nsTE4ZWi/qn5bYBjqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 21 Sep
 2023 20:45:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 20:45:01 +0000
Message-ID: <aba2dcfe-3dd9-07a7-1ff1-f311f1e96395@intel.com>
Date: Thu, 21 Sep 2023 13:44:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 0/3] ionic: better Tx SG handling
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20230918222136.40251-1-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230918222136.40251-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0263.namprd04.prod.outlook.com
 (2603:10b6:303:88::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: efc848af-9e60-43aa-c20a-08dbbae3a012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTdbqUNitDQPMF/d70WlqmvlXU4CtioJ+uBeU62B1KoBt6JjvIaRN5ZYeOmjSNmWZePBXEEA00MFZ9bD0Q55WJnPS0w0wjzPhxXbbpTJKeCwDTMJNGS2rHX8OEDVQc0HGU7/FcSPzbfaFBve3oXhbpoNUe8WMgcUD/cOcZ7XdEETAbkoiOHboB0DQP4wyYVgaXbQ46pL2gN4F3YLdZBRufeimk+FQtFfCSO6iAxewG1AgZS8tkwITdKJiiT9TW6k4qBMpRvgSFDFzLR/2n5CyOuvbohdl19UIUtO39Oo9Shtuz1MtXd4xYWNvpFGiaePRtslyu0iXbYKbP4gkrF+8IuEimZUZDmbpU/Mfftl4KviwaIttZ7DI1rTEiyxfBHXwnd+YspEoGBh/8f40RSPbsImlucvpSxw/tgx66KzEKLJLeavChpK+c6qPiJpCp4b8Uceu62IgnLg4jFL7JBaJgxlwuHsOnk4jqcT3Id7qd1lpd5uYjs47hiYwxr8JjczH91d+TcZyyXRrvKMSHcxUZRsV7sElHkgt3SHI3DU8cuclD6O4h7LB4DkkNwnIzWkwTGyev31tYnZY4sSFDTcay/sO7RQku9Q8Stl3Iqlr8fUDEZpbYFplYBt4Qi8DLDCjxShI5i/+MwT+IyybrvWnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199024)(186009)(1800799009)(6506007)(6512007)(53546011)(82960400001)(2616005)(66946007)(86362001)(478600001)(6666004)(31696002)(6486002)(38100700002)(26005)(66556008)(66476007)(5660300002)(4326008)(8676002)(8936002)(41300700001)(316002)(4744005)(2906002)(36756003)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRLdk8xeU5ub2ZvZWN0WWRUNk4reFFNMzdsT0lYcWQvNXlBdERqMmp5SVU4?=
 =?utf-8?B?OTlGWCtkYzhvdHlQNTRONzlDN1ljMWRMNE94SzBhdXhXWkxuU3A3Q3pxRXNl?=
 =?utf-8?B?SGoxSktoMk9KQmFLWHFqWVRJclpVbXpzZEYzSk9Vc3ljMldCY3RjcjhjRDdX?=
 =?utf-8?B?dkZlSElMMnYyRktZNFNHazlEVm5RczZJMENKZVBJaXFNM3hZQzJaSzlTbDRN?=
 =?utf-8?B?SXZGVzVYaFQrT202OS80RnVPQjQvd21oV0hxbm14QVJrZ0J1U240aWszcXNL?=
 =?utf-8?B?ZitDcGZKWU9SNDh0NXVBMWNLMVYwU2ZuSG83STVlbjBEbGcvN0NJY1I2ajIy?=
 =?utf-8?B?dGtZSS9COWFPcGhjaWgxbmR1Qy9KQWJUQ3hSK2g0TEdPeDBiS2tCTHV4bDdh?=
 =?utf-8?B?OExRTVZtNnNoNzB2UmFoMW10ckNXNU9iTnA0bFEzMlZVMlp1bnNtd281OFZa?=
 =?utf-8?B?SVVTN1JpTGhNQkRtWlB2TVNnSzliQ0c0NTN0bVpNL3dubHRhRFpzamdEZTZy?=
 =?utf-8?B?T29FdWRIeUR4MlJ5WE10cER1c2txUkk5QjFpSDVkcFhrNGd4OW5RVTlSZkFo?=
 =?utf-8?B?RitKL05pT2ZTRjVwWnpWNytvVTBHLzVZbG4xOVNmOUVxYUxNUXU0TEkyVFY5?=
 =?utf-8?B?VDFicE4vbnMrWi90UU9La2pMZmozblBseUMyaXdhQlkxbzVyZ0lBOGY4N1V0?=
 =?utf-8?B?Mk11c0I4eUJ4SVVoV0RzNDR5am4rejYyVk1iclNHYVE0UGFrS2orYjBBRWNz?=
 =?utf-8?B?djJHMHpyYm83UE96WDUyeEtWS0dzTWpSRVRxR0tSTkh0ZDZVTElnQVRmc1Zz?=
 =?utf-8?B?UFVWWDNKc3ZBUklJSDg5YVNOZGwzdU9lRkdjS2R4OE5kQS95dExUOWd0NGNN?=
 =?utf-8?B?OEdOZXdpYnRxdkhNcDJRSml6OEJadHJ1QVoxNHEvRHU1WGM1em52R3lXVkVs?=
 =?utf-8?B?MFhmNWREWTBHdTJTTWtraVp6VWJUeVZ2LzhPZEs1M3YzczJ0VklzdlBFdnJq?=
 =?utf-8?B?RThnYXpLUUgyRFhDTC9LQTFmc0NZRFJjZGdNcmJOdFpHTys0WVBWR2dJaXQ1?=
 =?utf-8?B?MlRHSWJvVmxYdkhKUVZ5alNFRXdmSUlEV3ZHZ2RaUVRzdnFFUkhZbWoybm80?=
 =?utf-8?B?R3VFa1czMXFaNkpOV0wyWlg4YjU0TE14clVtekh2QllPeUcvOG1sQ3RWNlpE?=
 =?utf-8?B?bml4YzBPM3pRVUhDaW1BOTJ6SHhEa2Y5THdBMlRubmJSbUVJdCttREJTMTFH?=
 =?utf-8?B?cTlFUXoycXd2ckIxbDkzQmJnMkNIMHI3NjhJZ1p3L25uOEJxMzhzZUk0OWI5?=
 =?utf-8?B?N1hQQkRBZE9iVndQaTYrRmhwMGxCZDJiTFBLbkVySDNiR056TWFTRTM0ZlFj?=
 =?utf-8?B?bHl0M21oM21SdUtIa3FtRVNVNit1VmIzNmZ1NUI1dGR5VGZ3MmFIbXlBNmJJ?=
 =?utf-8?B?Q05CMXlSUmtYRmpPV1VUYVlOYUNpMzJNdUFwWHBiK3piSGZSYmJpUlRJSHQr?=
 =?utf-8?B?ZWhOZjdjTjNNMU9oQzZpeTkraGxGOGFvWTNvYVRKOW0vMmxDeVZCdVRWSXNL?=
 =?utf-8?B?RFMrWmxxaGdIeHFVS2REdUFIMm5nSGl4aFZDQjVaY0JLUGs3NldNVWc0bjND?=
 =?utf-8?B?aHRhNkp3K29zcjM2bnBmekh5RnliU3RRbWV5ZVBvL25rZWs0NmY2V2Rya3pR?=
 =?utf-8?B?WjhTaUdmbmg2NXdKNGJUSFFJQmJzKzFKVjVPZUc3YTM1V2E0ZE1ESUt4dnFn?=
 =?utf-8?B?SEREcFIybUlPTitrekc0QkhuL3JoWVhPT09EZHo1dHdSWGsrSnhycWRtQVpS?=
 =?utf-8?B?VEVBeXc5UVhiUVBoc0prbFA4eUZyQmVVUVhhMTIyc1RyeW5pbTNhdjJiV05m?=
 =?utf-8?B?WnVDM1ExWFJSNzlOdkpDR0V4cGZuVk1QUTRnK1p4Q1NBV3V6Zm83Rlk2Nnlv?=
 =?utf-8?B?WTFWYS9uQno1cmZIWVphUC9oa3FycG9nLzNiMlBGSFNybW5TdkRIa1lmUFZ5?=
 =?utf-8?B?Y0V1ZUwwcldlYjlGV3NLZ0gvYlNYaExFV1NQZ0JzY2kvc2YwUzEvQ0kyWEJI?=
 =?utf-8?B?clFqaGxtemhEQnJaSDY0cE13eGlyampNbUJVOGhaa0RCNFdOYWIrUWhQaTNu?=
 =?utf-8?B?UjU5SzNlYllmaGR6cHQ4c2FUT3FVb2MxVmJNM0NBWVNSdm5hbGRNK3JuTmdP?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efc848af-9e60-43aa-c20a-08dbbae3a012
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 20:45:00.9776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eGWpD+fZKggUgx8GC/JZss1+gYLuvnvFouT9dh/uQ/eUIDPz9UkV7lzKQE2/Fu4Hn0jhvYW/UK/RQUqVTPBUgfTPBqjsGgcpByB7OfvjB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/18/2023 3:21 PM, Shannon Nelson wrote:
> The primary patch here is to be sure we're not hitting linearize on a Tx
> skb when we don't really need to.  The other two are related details.
> 
> Shannon Nelson (3):
>   ionic: count SGs in packet to minimize linearize
>   ionic: add a check for max SGs and SKB frags
>   ionic: expand the descriptor bufs array
> 


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../net/ethernet/pensando/ionic/ionic_dev.h   |  3 +-
>  .../net/ethernet/pensando/ionic/ionic_lif.c   | 12 +++
>  .../net/ethernet/pensando/ionic/ionic_txrx.c  | 77 ++++++++++++++++---
>  3 files changed, 82 insertions(+), 10 deletions(-)
> 

