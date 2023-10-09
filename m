Return-Path: <netdev+bounces-39189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6073A7BE485
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE4281DC0
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACAA36B09;
	Mon,  9 Oct 2023 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h454TGTo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB35336B14
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:19:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D42B4;
	Mon,  9 Oct 2023 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864775; x=1728400775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fFES1GkBrBzqVubm3S/5mHwMoi+w0FRdRrRP4AqJ6+I=;
  b=h454TGTofxNnxigY4ztmP1KEcLOOLm4JL4ScizeszlVnidNLc57O845v
   aKZOx2myLme+8pNtzn7D+DgRNGAxe/Qf7kIlAfhQPOC0zea9ZCgPQB77A
   oOJ73Xd4YTvOucEaeSTz634gcGGAAwG0wm4qgz8kJFkau1oU130MXiwwd
   58yPsU3TQwsHfMzqQj8bLQ8D9+nsc0vpehnixwybe6AV62xsKfICZA3wK
   DmK+ToSeMhJdDenIr1+FSIcRpCqv5O0VwkSawdLCft4V1WxbgpcrxVIJr
   M1Hh3fDocIOMNGwmPsfZ3tzGr8JJ833t4KpTb6KA5ZxoHf97hbUV0TgaO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374495406"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="374495406"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="782524745"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="782524745"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 08:18:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 08:18:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 08:18:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 08:18:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 08:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHNsMKzAsO8t54QR1vYWDN0mEgSy3ZLiVfaJ9N9kJmXWpgdAFJ63349rM5cEhyfb67sTZx3ul4jaRo4g7kNSCL2gzVWicOjZ47irGVajTBFOelFyL6PVKqMU8RCzq+I6S7tyetBayYxc5rcGk0WFmTkOu6cQWREpvX67Pa5IFQ3Yy5T5MT960jlNzQD7L6XbwPWjWMqhDSYHVDD2S2Q1SDYNtD1sUj+BNco0Zi4eNQtwdq9SEbfUJPmOUIM9oi3WicBf5ZLe9JKsIW7wol6KaCnrYk6iAYUaG0s0v+iLsztaA5MshfLKUQlThmxp1FJzjCFRT0b+0UwkI8eEV7zPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnjCM9ej24ePRTJwCkRVik+mjNWXFVG0vhZlLWHHGhY=;
 b=OBjncg/P95R/AomgwMFPMkS7O44g3Xn2neMIq+ymf+RoQ/rFJDrXBQkOyMR42aIvwunomvpQujMgb+dsPoOcxFZlu02c7p75o34J7cHZqxmtmv8fkTXVf7wRyprciOLBP2GaU2aVcXR5mJxKvIPU0d4uUEyMXp6ONgGI7aMbAMNT+uR5ct1AYLrySn3OA7y/P6ZXqlLAcZ5bUgUgWhmemFTnfZbPfqNSTLEFh7vhEK8UzeZdaDGxdj/DE7bd/1kOWsGlQO7rLvRW+P5eqhy7XgWsfMPazzHksqR2ilbUfkG2y6tmNjB4Rcmay2XUoOBM4YvW6dDzcjwyTzmv/MZ9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 15:18:32 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 15:18:32 +0000
Message-ID: <45de79fd-5763-bb55-22b2-0bfd64873c4f@intel.com>
Date: Mon, 9 Oct 2023 08:18:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [Intel-wired-lan] [PATCH net-next 2/2] ixgbe: fix end of loop
 test in ixgbe_set_vf_macvlan()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Jinjie Ruan
	<ruanjinjie@huawei.com>
CC: <intel-wired-lan@lists.osuosl.org>, <kernel-janitors@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <34603f41-1d51-48df-9bca-a28fd5b27a53@moroto.mountain>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <34603f41-1d51-48df-9bca-a28fd5b27a53@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|CY8PR11MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 06800390-1d05-425b-7a8e-08dbc8daff85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkyaA3lQp5ozCFbY6tVkEAGwM7oMGoHabmN300zWhflMCf/QZRhR38MRF7Bfa5Ldm7/MxKeXJjXM+l3UUgPTRo2+C73KJeGYfw+bwly3OslO93dqlH9Qg6R6ENkht9B9Xa10vqeqxRPuwz5UjvBGfSd2at11Vo47qN8NMoOzyumU6htVvpvaPpRYFwqf0hx8JF8do+b/uGBt1MJjjP1UrPM24xhOBXz/mcPpR9MR1PBRT7CbrhDuSNfdL4c4eyDfnGF+D47dyef5AHmMkxi4hmFUo171VnpcWCf2UjjDfmud7K1+g+dDT6hjskleWko2G3B1X0oMIZUMoL8d4Uqv75sAC7DIYDiwIHKGmX4cXyxjwdpXclNvU/DiMQH7igq2PqXqJNIil7+BhLZU9hxSIRe5FRuntB/voAp2uKCx4Afur4ns/+EOo/jEnFkjSMf9ihCziP/QDEJfIgqa80W2aeWDc4WT0aBSIZdO67GbPPJmyer1bThGCGGYixvQJnmUFjoCvgPVt+o2tOq9Ma8UvL2+XsicZYvcOJunhdzTwEus67YKfFXKK9mbZwKH5t8fSOD1lcj+GKHJnHHZQxs0I00v3qPEoqZgefPsmJa92xqYR86f/VZ6Ii6oFR7/H0E+7ydhx7neDyxM6zmxyi0mVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31696002)(38100700002)(86362001)(82960400001)(36756003)(31686004)(2906002)(6512007)(6486002)(478600001)(4744005)(5660300002)(41300700001)(8936002)(8676002)(4326008)(6666004)(44832011)(6506007)(83380400001)(2616005)(53546011)(54906003)(66476007)(7416002)(66556008)(66946007)(110136005)(316002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ZlUC94eDlEZFJKbVVmN3BUSU94K0g0dlhGbnBFRzJNeFl6Z1RXTFhCZkVG?=
 =?utf-8?B?bXpyRS9IbEpKMXd2d3VHVGRPYkx2eC9PWUd1RWhSNDM3OXZKMThZbXdmMXQv?=
 =?utf-8?B?MExnWi85YmR6RExKWkJKMGpSMnJyRDRrMUl1OHFPNkJLMlo0WTRkb1pUcEZR?=
 =?utf-8?B?eHYvVi9NdHVIbW1LYWRJV2dTQ01hdUtiRjZnRTNnL0g0ZFNmMEZUZ2E0S21k?=
 =?utf-8?B?TTRBVGRNK1ovZDhsOVRLS0krTDdpeXZvUk51YlBYenZLWk1WeEVWVVJWajEv?=
 =?utf-8?B?K0UxTmRyeG5lTElycXdud3NjSlliZmtLWFJiYW9lY3AwK3VqRUVPSHp4cWE3?=
 =?utf-8?B?aGhROWd5R0M2YXRMVUdLNGlQRmdISlg0V0N4U3lDcmdJamFQbkJSbFdxRmVj?=
 =?utf-8?B?TTArb0o3NTBWZWNackZ4cjcvM3Awc0dWRVZGNUhsV25FZldwWjYxNDBnb0VJ?=
 =?utf-8?B?UGRHeVpDZmZxVXFyQUsxZ0dPV1NucTRXWVhJemMxdUFaMkd4cDBmNFY0Vy96?=
 =?utf-8?B?dGd0TTMrVU5rT2phd3R6LzhRRHk2ajRwVXlCOTBkT0FHTHRWY2FkNWhSWWgz?=
 =?utf-8?B?dnkzZWkzZURybjgwclFkSTFpS1NnWm5rNmtmUVFRZW4raXdBdERhako0UmNV?=
 =?utf-8?B?MEw4dVZjd1I1emNyYXNxSlhDeUIyaUJYLzBEWDlDMDk1MW5MTUdXeXlTL2I4?=
 =?utf-8?B?R0dqcWRnOGdVTnIzc3FwOW9mblQ1R1U2NFlUeWdEYVk3SVlIblkvV2hYcThV?=
 =?utf-8?B?dnIxVFhlc3FuSURZa3JiRmZiZDh1U3c0VzY2MFFydG1PRVUwbnllVkV3N3Mv?=
 =?utf-8?B?UERiUXJTSjNidklsTFZlcGh3RncxWG5DWllpb0d0Y3ZUdE9zeGo4aUlwVTI5?=
 =?utf-8?B?NThpZzU2eFdwU3FKaDJFNWpwV2ZML1lObDhxNkRKVVg1YURjWEMwcHNZQ0s5?=
 =?utf-8?B?ditYNmlyT01qalRGYUZSbU43bFZ1QytydktaS0N0WW1PSE0rOUZFeEFjbTFm?=
 =?utf-8?B?MUdTWFlmenc3dzlFeE5EcGp3MVpYTUlwZ00zamJuUmNJV1lDckMzK1RwM3hD?=
 =?utf-8?B?aGxNNEZxWHIzTWcyUXdtLzE5MUEvQVZrbUpvbkYxTyt2SCsxaVZUcWhkRUE1?=
 =?utf-8?B?dExOYStrN2ErSHdJUXAxN3I3bUwrSlFyZStGTDdieTd4U3hlRWVwQ0V0MGRz?=
 =?utf-8?B?OW5kQXlTQVJLNEk2K3lvOTQxejJNMVo0MVNiRHlHRlhiVE1CVEtZUnhGZ3FT?=
 =?utf-8?B?V1BxZGY0R3JKSmxpdDkxbG82bnBuQVRYMDdaV2ZTUGx6SWJtV2JLMkVkOVRH?=
 =?utf-8?B?MVRJUHJWbXMvWnVLYUxxSGFpUkZocmlXSmx2UFU2b0oyc3cyL1lpVXRkRnMw?=
 =?utf-8?B?azNYVmpkY1Y4cjllWFk2em01WkFUYkhxcHltb0hydExZTjJCNDlZUTNOdFJ1?=
 =?utf-8?B?LzBkWEtqVGZYRE9IQUtoR2FEaVJxWThqRyt6L3VMbVVVWXR2K2lyWlN3QWxt?=
 =?utf-8?B?azVlYXAxZEJLTUlwK2daUTI5T1ZHZXVPekl5OUw3NTNQckpmSjVHeDJxQWcx?=
 =?utf-8?B?WU9ZMkdtSHM0eDJHMFNyQXhTa3BvSEdXNE52cmFwcFgvUlpmM0xGWEFRa0kw?=
 =?utf-8?B?NDRTVjF3WGUzbVBHTWJuUjVXN25Ld0p6dGVnYm45ZXZuazNGVmh5S1lEMzhK?=
 =?utf-8?B?TWllTXBTb3dJK2t5bDFGTmlpN21yc2U1MFAzU0xDdUVRUFc0RUVjRUhRV3pD?=
 =?utf-8?B?Y29MOHpQQVJ5SVZoTW1FS1FxRU1SMklkOW1DbFhLUy9KNDkzYmZNbDZISUZk?=
 =?utf-8?B?Vy9xRDh1S1FSWksvV0c4NFE3NnZIMTJEVzd2dytFN09CaVR0WFRxREFrVVhj?=
 =?utf-8?B?S25WNmpTb2lJUko1UEg1VTVZUzFodFE3RktyRkQzdjJvYUNKOSsweVhtem1l?=
 =?utf-8?B?RE5qbDZ6bE93VVpZdUdOVXF4WS9KK09jQWNNblpScm5CSFNKV2dNRlQzdGo1?=
 =?utf-8?B?WFo5Z2g2WTFxOHFoMHlwelhwdzFGcVFMTnp6WDNDSkUzNU1pWmE2SDA4QjdH?=
 =?utf-8?B?cTc4TlRZV2xpdng2dENvcFJ0eWNhUy9tcXdjVGFUQlJYWmFoV093RWVhaTRB?=
 =?utf-8?B?YzdQYXZiZlhlQ3NxdWp0U1hFZ1hEMDZvQXRnY0hLZXd1T1RpN2RHUjI1OTJx?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06800390-1d05-425b-7a8e-08dbc8daff85
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:18:31.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvkL1vV/Fw0oLA0BUogULWkrYmSMVCBIilVQePSuDpWGnLWMBtso5EzmIRy34z9ceZJaqo+zhj/zV4wXkyOwBqmTeDYI8/N0Z0u1PRSK/8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/5/2023 6:58 AM, Dan Carpenter wrote:
> The list iterator in a list_for_each_entry() loop can never be NULL.
> If the loop exits without hitting a break then the iterator points
> to an offset off the list head and dereferencing it is an out of
> bounds access.
> 
> Before we transitioned to using list_for_each_entry() loops, then
> it was possible for "entry" to be NULL and the comments mention
> this.  I have updated the comments to match the new code.
> 
> Fixes: c1fec890458a ("ethernet/intel: Use list_for_each_entry() helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>



