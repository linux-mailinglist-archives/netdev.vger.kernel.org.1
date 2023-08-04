Return-Path: <netdev+bounces-24525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5FC77076F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62E128279C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0931BEE6;
	Fri,  4 Aug 2023 18:03:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC51AA68
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 18:03:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EB24C0A
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691172180; x=1722708180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1mAmh2rpQFNeVB4vzxLLDSEJMkLygKLAUmkmfw2pQ7Y=;
  b=G9ihgPyIDQsiA3bFunYZNdUoPa5GJI8efL/Galbn0ahZJ5yQsQGeu1or
   Vpu/BD6zEqj6jkdYT8wqLo4CteI9IBc5PllqZyi4xS+XQG8LX0w9PVsKC
   zLl7gy+1XUxMlSDOSMTF+XOmsFq/izBWlDH83td39GWvNwDLdCUPLA07k
   0O3ZusQTEHyotcpvOdgevzKQvAod8lTR6FyD8od5seZUq0dAfzbT/sn1D
   NeHh2uRUDc27hljeJwbID66DwO2P63TsQmPxMwEv+IuJTk8vbSDRQdnTR
   IVLCzWK5UNmR3i9Y7u+K+kDv1VIplL+p9O7my+YcHCMFFOrUYqmJ7IsET
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="350523931"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="350523931"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 11:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="723735132"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="723735132"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 04 Aug 2023 11:02:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 11:02:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 11:02:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 11:02:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 11:02:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfJuxH8ajsm0XTL+bw+CTT1uOxiz4upTDS5tA+1D74OZyPZiPrnJ+C9/4RTqWEimOilXyjVqAx987ru2GHBq3zH6UaDR7b7CewdnA4piStbViT0GgwCptjgMb+PxI0DtusV3wiaVk02Jr/nk3TjaM3SL8lXawcDE76/MSUxuanRWagxMtg1VmPvaaN/qqEndVeNpVw5X5VaRGyJo1AvN+vZ2YVpPf4Am0pDOFiOhhUjgqQKM8GRxCwW0jtPXpH6xoKTKipNXDLu5u1eu+WJzX0IKcXT0dC6TN0xCjwOOzyq34efoH5OdEBu2ePWQ61N9rrNrUo9JugEdyYVabmJ+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mAmh2rpQFNeVB4vzxLLDSEJMkLygKLAUmkmfw2pQ7Y=;
 b=LSDvbbOBVX1HUUd3qU99bO7+4ajq+Q43zuM684qjKZim2CZ/hcBKvW0c/ygkGoE2WsqTpfPoFVVu4MNEa4tCKCDSQIQdE2Ob7A3k0YTDnt0iPshHvIQU89/vp9bVkAplDSk9qEtvL3DygFKIvMIPUSqqkCwi6pf10oR1G6ZCl57OXgbDYr04lJaxa53shp+NFyZYljU3jPx+mcU+jVF3Ve4/57BMu4ha1tXEBovvvHIWzd1tTqXE2Caf9d8LJAWF2zBYh6f6AzSQfH+j04LtEMWNepo2LABRGxpHmJEDHm0ZaJZOzaZVuEQyQ3n6LLoGquFOuWkrbAkAlbuVHTWKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 18:02:30 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 18:02:30 +0000
Message-ID: <cffa2e0b-bd03-7f12-014c-c6830fd43917@intel.com>
Date: Fri, 4 Aug 2023 11:02:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 2/7] ice: Support untagged VLAN traffic in br
 offload
Content-Language: en-US
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@idosch.org>, "Vlad
 Buslov" <vladbu@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Buvaneswaran,
 Sujai" <sujai.buvaneswaran@intel.com>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
 <20230801173112.3625977-3-anthony.l.nguyen@intel.com>
 <20230802193142.59fe5bf3@kernel.org> <20230803155852.glz4rqvrhx55ke3m@skbuf>
 <MW4PR11MB577606B881AAF52B44B76839FD09A@MW4PR11MB5776.namprd11.prod.outlook.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <MW4PR11MB577606B881AAF52B44B76839FD09A@MW4PR11MB5776.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|SJ0PR11MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e8d455-ac5b-4bda-18ce-08db9514f859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mb6dQoULugF+bBYD7O/hhlpwx3Zy1MMNP2DvMwBYF7IUkhU14h/ubOwMTC7BTA9bDb4naOHhDlrJyjnIi/lESnuf/axbbf3IYlTI9nwgOJfLWf9sWyodpVxrN9rZ6xDo60R5sL5Ls20Ne/q4hRLrUciG/HYoYBSN/cfh6+O1Gjad+UoLpFH+F5VUFklNZ7aB7mLoZ3Cm90bDWwKSCGuV4j+N6xcumYyQwoYfvvvgWzC/tlick0QasdxtkW3B1OE3uubA7v2pFXaV461HQdmMQCxZVdBOKoWL6SBf51yOiFersLt1eXR1HKGd8QZwKX14kqnz/j8JZ/N2FQei1OcRltvPu77gMgqJ9KbutVaasmKi25nUi3apHl+TkTq0H/qMwhEcgWNoCqdGOhsexFcowmwTFvxMsrNvDSamTpaA2UCvrWVetu3e/G4o0OvFE7Uzl4GRMx4a13vAFON0YAxUgjGRAw5LnhKF+nKy97wBNu3nsLtQBKlZ7xHEX5i5lGZEPIh2OH2E31t/ZsHt2ZA/Ecood4cQ9sEKV9r6+5/3j4fEkpICFillzx04bDqG76v9RKvQDlegLJay77nYeUSiXeR/VPN78wiOJE7OQl9V/5r4Nu47Uv/562pGoG7hjkvywKf2kgq6wjpo8yTT3JI56A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799003)(186006)(41300700001)(8936002)(8676002)(83380400001)(53546011)(86362001)(107886003)(6506007)(26005)(2616005)(31696002)(38100700002)(82960400001)(316002)(6512007)(478600001)(6666004)(54906003)(6486002)(110136005)(36756003)(4326008)(558084003)(31686004)(2906002)(66476007)(5660300002)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHNkbU5UdWtVc3VSc3FZL3psU1ltdXowRnBCVEFvMmxhcTgwVFF4dDQ5Rmxl?=
 =?utf-8?B?YmU2WjJOMmdkYlk5YkZ5cUVBS09wNHkzRFlnbVIxVEY2aVFaY3F0MXBNSzNj?=
 =?utf-8?B?OUZMNVRvV0FsYSt5VXJkaFMwaDhKQXlVOHJqR3RNVGdRSHpGMDJWU29VSXYw?=
 =?utf-8?B?VG4xb0l1MWZmdlUzUnJONC85V2xhWFROeU1tSnIwVTVSRGhIb09XSVh0Wks0?=
 =?utf-8?B?NzFRbXdsbG8yczZ0Tk9ZYVpheFFNOGJFM1dxKzROSzBZSjJ3SUFYNEswWnFY?=
 =?utf-8?B?ckY4TDFXdFdtV2UyK0VmVlJiNXlpdHBXellSSGdma0p4QTYyZkU1SUR4YVFM?=
 =?utf-8?B?R1pKQ0w4MmE2bm1CeTZqcU03U3VXTG1vLzZaL1pJdUtFSFNZZkJrb0VXelVR?=
 =?utf-8?B?UVRQaG1iUzJZZitOd0xMckRRNjlPZDJYRHhjeWU2M29rOXI4SXdYaWZVNmor?=
 =?utf-8?B?TnZ4UTQ1WGZqZ29BOHRXSHBhbFpLUjBhVG1CbkpMRDBxWXRjb1ZPYm9mTVJQ?=
 =?utf-8?B?SU5EMFFQTE4weldJU1hIY2hqWklqZkdnVXEycnJEVjg1RWFCMTN5eEdWUE9x?=
 =?utf-8?B?RTRQS1RqcFdMN25nR2QvYVBGU3VVaTNvMjN1OVFmUzhWZk9yb0ovbkx2eFZs?=
 =?utf-8?B?V3hycDFaU2tKTE14MVA1NjE3eTJLRkY5R2xKVnVzMWU5QkFqVmF5QzFLRmI2?=
 =?utf-8?B?c2F3VWQzcE1QRTY5bzNPd1RBeTdZNkFEQTEwOFlYZkVoUXNyR2hxUnZIVnE3?=
 =?utf-8?B?Q01Jdkl5bjMxWkQ2U01UdThqcStEWHJKbFlzazBCWTd6TUE0NmpKRjJsSkxa?=
 =?utf-8?B?ajRVcmNCUmErazFLNTREVFRoQU9UVzhKVlVFamtRR0tFTHgvb0k1czRYQWdj?=
 =?utf-8?B?UzRYcnE0bWVtYy9uZDB6aHA2MVM3U1pYcThId2E1a1lFOXZRWkI2UjREeVNm?=
 =?utf-8?B?WGFEUkNNRjFmaWZCV1VaQlh0YmpXcUdpQ01DQ0ViMmJ0OVB0aDJxOWUwM3hx?=
 =?utf-8?B?VDU2ZE5TVm96SDVMMWhYRmFGTFRSekRseHZ0dkpoMVhBbDczaWp6UzZ1ZTBQ?=
 =?utf-8?B?YjNtOEF2czVGTzlSTzQyak03SjZtM1JBZzJtbEhLRUY3NW5aVlY3N3Z1YTgx?=
 =?utf-8?B?UFJZRTVtUXVWaDd0UktRV3RFbVhLTUZsdDdCcHlESEdXQkJ3a2pjeW1WaTJ0?=
 =?utf-8?B?amtmWURuMVNiQ0djN0NHUFA0YjRhTGF5Q1dvdDcxWDBhZmp4YXo2bDFIT3N0?=
 =?utf-8?B?WHhtNGIzdExUL2lNWnltVTB0bkVvR2pVWU9EMjBWZmNNRFkwUTQ2Q09YbGE3?=
 =?utf-8?B?L2xocFR0citQbCtTb0tEVFU3cXp4UzdraUlmR1QrSEJ1K2w1SmtaNlRCTXVB?=
 =?utf-8?B?UUYxUWhWTTJaRTVmRmZsMUtZU2VIM0FWZ2hVY0VxYjIzRDNwWDNJazgvRzlG?=
 =?utf-8?B?WkZCMkMzcFBienFUSXFqcDVkY0lTek5vT2w5OFJPak9IQ2pOZGFoOCtEeE14?=
 =?utf-8?B?ckpxRkg0WHNZU1NCMDFxOVRGWmpNMHNoZnE3akZQaVZrMS9KU0VscER1cFZr?=
 =?utf-8?B?TVdnWDhJYnNqMXhrWTFOUUp4YkNxUkM5SlQzWm45YTFEZWl1TkhXMnhQUUFj?=
 =?utf-8?B?YUhDNUxzTUkwTElSd01zZDdvcHBwQ2FpT25DdTNtQXRCdGpTcG9CZ1doOU95?=
 =?utf-8?B?Mno3MytYOXpIZWE2bzhDVHNzc0IvRnlibk8vMUxiZE10Sk9FODFURmNGa2NN?=
 =?utf-8?B?akd1L3RRM0dQVlJkcVVWcUZUeTdlSFhpUTJyem50clZxbmJHRWVlakpkN091?=
 =?utf-8?B?Nk1MbXNDVXBMVmhJY1hxemNycXVyRXc3a0pnYzJydzluV0xjTVpqbjIyb2FE?=
 =?utf-8?B?QmxYd1NPZ2xrSUk3SUJadVdTWUEvbXMrc0lud2pVSERxcVYwR2xUbkF1aWhW?=
 =?utf-8?B?YjJ0c01tWk1Qdm40clhZSFFkelE5alZvcHJ5cndyL2REQ2oxZkgwR0g0ay9z?=
 =?utf-8?B?bDI4QlFPOTJXditxaDhmTTk2ZXp0TVZwOExVSTJsWE9sRFRTNkxCYklJZlor?=
 =?utf-8?B?cElzamd0N0lkMkJHL0ExWk12YlM2OHJ2V01FZ25vQUFqSVNOVkZiVW5RUGIw?=
 =?utf-8?B?aS9sTXczQUhrZk5lNFB6MXhvb3F6ZVFKdWlXQUlqUlQxZ0F3SUVuQlMzbDdD?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e8d455-ac5b-4bda-18ce-08db9514f859
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:02:30.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTsNmII08ZnYJWvjhl7VfKxA885Os7hcZiepfbp4VlnxoXa2uGgI4Hd95+VRbH+48dazVTPQRnulhSAmaEBFcrNnJR5iRt2JKt0RYwlEvds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/4/2023 2:32 AM, Drewek, Wojciech wrote:

> Thanks for clarification Vladimir, we will change our implementation.
> Tony, you can drop this patch from the pull request.

Will do.

Thanks,
Tony

