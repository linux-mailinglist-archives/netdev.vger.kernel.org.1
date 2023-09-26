Return-Path: <netdev+bounces-36212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6B7AE4FE
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 07:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C82961C20403
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 05:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544611C37;
	Tue, 26 Sep 2023 05:23:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEDF186F
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 05:23:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F44E9
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705799; x=1727241799;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xmeY6BnpALLMctYVo9F5uc5Tmv5XZp6x23AzVNd76Uc=;
  b=IDDi2yi3i+GL8zBCtGKOth/WrfCKcGd6vH/Gf4pZchmVfnhXrzN2yr4B
   nVb8qHGJM5cTKphR32xLpdPEy9tzppWoGSfWnHAbW2sItwjBN8K7jBzw+
   RH4+qg+b8da34w5WzxnA1hrHnIpWp/6eRUTHDyidXPQ+LRkeZg3clwutm
   POhUozxt5zYUvYhJGXFUiPIED2XNWI8Pnz3dW5uKNRHobgGnjlpKDEcP4
   iFGWtT0YJ0gXcuW5yhUi0n+uNfWJ8QurvNSwG38oL+UqhMEaKcms4qnD4
   UYjrnKC0WnMOsfyh0YCe1VUOwybCMRoPWdDZxm8UAN9cEjDArqk0jtXaN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360866178"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360866178"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748690283"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="748690283"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:23:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:23:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:23:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:23:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxdxjBB5x94txb3iS4G4o9kg6heVhI9oxbNAIlbCOnwg1sWYVd8JU0UaIUPjkOOT9S3cx3VLORAlV4XiVhBRIfeNf2wYLOHxLgD5RSIcX7lwrzJvCeDgsAmzKGqNAP0ULdtvgSYwVVjXAnmqDvuYylvzI/71uBnKVlDCh/n4fyXj8e2ZLWDrL5gNmsSQZ/paYqGdQtvuDEcU/S2owomVT24zfwUzIckQv4S3y0kVzEZK2NbxrOVRAWtYemkRzGkePP3xGIij11o5HUD5bXQpaTOa4XVYQUFWH5Hs8oK+bReJ4oTlae8m1T0Lu7vg2nvp+vQ1oLrCUVgyZEu8K6UuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSMIbCvBMappkM4N+1Bvcq44RnLZqD3B/uc7WtQy2Mw=;
 b=KB0Jv78VDogSSVv/TAqlWT8AuiJMlmP8aiR/euBu6rWzwW7rDBu71ZgEPGCbh49GtkoU2QFNEvHiow8HCxWo+8dNF7SzjhMiEL527KSSoKLkdynttzrPYIQq3iZL+P8ZEAFhjwj7E56OnWgp3U+Pzdp4GAk330aoKPG/Xjd+8eyE7itBCjrHyKgfuWWmYm8w/0L0FmdJPIIK49cJG8ieh3wFfKW51eqKKhBgkYXZEUPAYAcs8TF9FU6ksmkmRrSIM5K9wpUmJtNnDbYDlE93g81BiwURvid5Dwa7u2iOBkD2Dd4WOMLB4HPipLt6DM4g3AtmE+DPVUVuBbBxX5wdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 26 Sep
 2023 05:23:14 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::b8a7:a98d:5dbf:2bb9]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::b8a7:a98d:5dbf:2bb9%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 05:23:14 +0000
Message-ID: <f59f9386-8c65-4e56-b77a-82366e2d2821@intel.com>
Date: Tue, 26 Sep 2023 08:23:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [iwl-net] Revert "igc: set TP bit in 'supported' and
 'advertising' fields of ethtool_link_ksettings"
Content-Language: en-US
To: Prasad Koya <prasad@arista.com>, Andrew Lunn <andrew@lunn.ch>
CC: <intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, "lifshits, Vitaly"
	<vitaly.lifshits@intel.com>, <edumazet@google.com>, "Ruinskiy, Dima"
	<dima.ruinskiy@intel.com>
References: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>
 <40c11058-5065-41f0-bf09-2784b291c41b@intel.com>
 <04bc5392-24da-49dc-a240-27e8c69c7e06@lunn.ch>
 <CAKh1g55zm4jcwB34Qch=yAdLwLyPcQD0NbgZtUeS=shiRkd_vw@mail.gmail.com>
From: "Neftin, Sasha" <sasha.neftin@intel.com>
In-Reply-To: <CAKh1g55zm4jcwB34Qch=yAdLwLyPcQD0NbgZtUeS=shiRkd_vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|PH0PR11MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: e3626dc4-fe2d-454f-edd8-08dbbe50aeeb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CIFauxDX0fGUiEf07m+rmBfhAKzXCf95JPDWh3GXr9IAr+8wXIQO6WXZVOIKukq5TCZbA0Y8G6wDKkYl4MaVCxr+I6Hv2t9llXzyNEwTXJbvhPDvMT2VR425TFxiE+PgnqKsT8uD9U4xqwh8QNsJr1ItFm5siepUQ/6J6Ui58XX+Bn2kkZBPHpyzRYI5h8hpbAdnKgcQh4eWuYs11h92SWjwfxE/TfbFjbY6KnrhAW7shleBBk7uhEPqcMLrffeT3yRp+yATR1Pnd+R9AA0YXNxeoZxDXcIUdXwfbbWBKx8vN7csmdDMm+1twi19cM9jEJL/n3eK5cafei6jQo9UV3eYPP2GecGUXUGb2MTB83OeCJL6h2lO8sb3xc5Z0LiZjl/4hS04TMUmSq0tQoOt1ZsS+VK+4MExIb2gzyzI6QM0uzOXmUgVc7sNu+ag0VdpuJ/OjzjVcDbVZjMU+wY5QuiGboIlbpHgMwmE074/FjGMDlwSXCD+Ymt83JLJh9UM1r1pzaETSZt34Kuxae2zLZMmNv+M9Uz8MhGhYvtC5a6gtC6InLU9B5UD8ASsb6hrnLfKiRHzYpaIXGqCga4utRRaBYvGcKOHv3yNLenzP5P0keMoH9SV1As+heqVNABGahFK2KFjJ5iSANNLXusJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(83380400001)(41300700001)(53546011)(19627235002)(38100700002)(110136005)(54906003)(66556008)(316002)(2906002)(66476007)(478600001)(66946007)(6486002)(6506007)(8936002)(4326008)(8676002)(6666004)(86362001)(31696002)(82960400001)(6512007)(2616005)(107886003)(26005)(5660300002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpHUXFkSzNraDM4N000Z2hzTFQ2czZSTGtvODdMSStqakUxTkpLcE9WRkhj?=
 =?utf-8?B?ZHJ5VUpzTzF4bDQzNTgvaUw2akhxWEx1cUJZblRaYVdUdFp0MXBUQ3AyV090?=
 =?utf-8?B?VjNZZENLZzZjZndoZ2tNbC9vWEg4UGJKVzI1bEZBbnFhZ0ZGNDNQcWpjU2tY?=
 =?utf-8?B?ZEo0eXQyZHhwYW8wdWZmS1NoRGRDSDhKeVNrWUljUE1TeEExSkNNL3hvZ2lM?=
 =?utf-8?B?ZEhieWEzZXp4RDhudGYxMkhnTGc0ek9QYUVjOHFXTkJ0b0FSWmlOSytpelJ3?=
 =?utf-8?B?aW9KZi9Lek1BR3lBS29sdG9aUFlSSm5FcTdxZ3BkU29qVXk4QTl4b2VoMEY1?=
 =?utf-8?B?eXBHRGxnT2F4bVRLK1lLcUZvK2p6VXMvMjBHUEdqckIzOVl3OFRCTlRnSzNN?=
 =?utf-8?B?OHZObmFGYmp4blRRelFSeFljWVZZRzlzcE81TlNBL1doakQrYlpQOFMvbTEr?=
 =?utf-8?B?VS95YmUxMEJpaThpTEg4eWFIYVFWc0xWb09OQlZMWVQzaTBBay8zeEI5Sklh?=
 =?utf-8?B?bVlIL0NIL2xoZ3haZzFYcG11dHk1WjZINkNteUE1RmorVGk0Z2gxc0s1NEtq?=
 =?utf-8?B?S0lCRG02RTF5alVkSGdxRjdOUklFcTJKa2pqZzVnejNTUTVPdVJTVkx0S08x?=
 =?utf-8?B?WkRSSEFRSHRJY2prUm5Dd3M2M1JWc29xdUpWZ1FzQnF0Q1gwNU00R2owMVNm?=
 =?utf-8?B?eDRFcW5ZVUoxNGJIU2o2MlRXMWVSVS9FS3Fod3NydW5QSVBoaDhTK1QxQXB5?=
 =?utf-8?B?QWRha2h6bzd4WTZ5S0tsM0FXS3dtWVhOMHZhOUdyRkJSTzh1eUZldWtOQ3E1?=
 =?utf-8?B?NU8vR0RoR1Nka3k1OUJ2eTRHUFoyS2FHbzdXeXBmWlVERk1iNGViR3NweFMr?=
 =?utf-8?B?M3JMWHAwMlg2bFlDbXFRam9lSmgzT3dnZlFwdGtseXJEK2dwbWYrWGZQR012?=
 =?utf-8?B?QzdPWUQ1WVRFa1c4MTg5NHB4NDRDcGRJTkdjdkt0eDhpUjBGUWhrRmpDQUZC?=
 =?utf-8?B?ZXhlVmR4RkFPSFA2RGxMeCtxSnkrc1Zsdm9MMUtUcXpkclNodktvWjcxd3Ax?=
 =?utf-8?B?c2xlUWVCSmVucHNDQWxJSW0rVTlwcFhGcTh5WVNrZXNVa2xUdTQ5bTgwUVRy?=
 =?utf-8?B?MHhyTUJ4SVVJK29vaVAxcmFxWk9IS0trNHBvb3RaclBxYk04bk11dUJieFpI?=
 =?utf-8?B?QmtYY2RxTGRhOXBaZXhIcmo5QnBTYU8xRCtsdzhidzBwbDNjWE0xSnp1U2d1?=
 =?utf-8?B?Z0hrSW5DOEFmdXZlWGpPa1J5Q2RETWF6QWcxbnRaaWVJcVhEMFpWTlNIQXhM?=
 =?utf-8?B?OTlpdVIyWXVBSi91a3JPdDFpNkQ4SWR4VHNTR0RjODg5TVNGNGJ2WlRqU0t6?=
 =?utf-8?B?dEo4MEVkUi9tU2YyWHBzNmVJQnhSU01FcFl6UFJ6THg2YThiOC9QQlpGUU9i?=
 =?utf-8?B?RWQyVFZqdWU5VzlWK1pGSTlhUUppcE83Y0tlS1ZCanlFTDh5cmowTmNnOUVP?=
 =?utf-8?B?MHdycy9UZ3RsSDE4ajRia2NySTNGRWtPei80YnV6TldKTVREQ3JvcytIQnFU?=
 =?utf-8?B?VVRwcVpCNHNvVWEzZ2lGTUQyTC9jbFhrNnduVTlJUUF1TUVVVHV1eVhZTnNO?=
 =?utf-8?B?NURVVXV4TDRuWlpQR1ZjUS9RM2FNcUtza0dCZENseXZQdEoxNGN1UTFnR0wz?=
 =?utf-8?B?RXJ1TzF0WEJPTnc1U1NKZy9qVzJzMjRFcThTT2VOSTZ4V2tWaTN5ZmtYdXhW?=
 =?utf-8?B?QUVjVmRuYUczeitpTnZBQk0zN0drYTBJSTFUcTlkR1hvdGxRaDAyaHhPZktV?=
 =?utf-8?B?V0p0YmZxK2RVS2lPVTRYQVR1bEJ0OFNLdnkvWTlrekJsZ2ZvaEdIRFFDTzc3?=
 =?utf-8?B?aHlZZTRsK1RnbzNMc21QWFFEU1ZEdWJxblVBdXJTNjhGZ2UwSHNxM0NKMHox?=
 =?utf-8?B?ZGhxbVA2MmluRE5Dc0lwVjVxUmhiQVhxaUlYR1VWZkl0WWw0Mi96ek1saW50?=
 =?utf-8?B?eUpScHlwZTdqMGdUNDYvRWFxZnJjS25ZRU1FQll2WGVnZ2xYNXBIOWlaa3Nt?=
 =?utf-8?B?dnNTdGdiMzNjS2o1L1luMmxlYUpodW5VQ2pPbTBzK3VveklqeU95ajNWWEta?=
 =?utf-8?Q?O6yI2qo9zCGrWI9JUqxVurQuq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3626dc4-fe2d-454f-edd8-08dbbe50aeeb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 05:23:14.7063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EM2FG6gZljk++0dXR6nvxEaoA9JsSrSOiK7Jlz8ho+m5GR3jXKIobdSo+6byYm8Gelo1nfltsrChpK/YLd23cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/09/2023 22:40, Prasad Koya wrote:
> Hi,
> 
> Here is the ethtool output before and after changing the speed with the 
> commit 9ac3fc2f42e5ffa1e927dcbffb71b15fa81459e2:
> 
> -bash-4.2# ethtool ma1
> Settings for ma1:
>          Supported ports: [ TP ]
>          Supported link modes:   10baseT/Half 10baseT/Full
>                                  100baseT/Half 100baseT/Full
>                                  1000baseT/Full
>                                  2500baseT/Full
>          Supported pause frame use: Symmetric
>          Supports auto-negotiation: Yes
>          Supported FEC modes: Not reported
>          Advertised link modes:  10baseT/Half 10baseT/Full
>                                  100baseT/Half 100baseT/Full
>                                  1000baseT/Full
>                                  2500baseT/Full
>          Advertised pause frame use: Symmetric
>          Advertised auto-negotiation: Yes
>          Advertised FEC modes: Not reported
>          Speed: 1000Mb/s
>          Duplex: Full
>          Auto-negotiation: on
>          Port: Twisted Pair
>          PHYAD: 0
>          Transceiver: internal
>          MDI-X: off (auto)
>          Supports Wake-on: pumbg
>          Wake-on: d
>          Current message level: 0x00000007 (7)
>                                 drv probe link
>          Link detected: yes
> -bash-4.2#
> -bash-4.2# ethtool  -s ma1 speed 100 duplex full autoneg on
> -bash-4.2#
> -bash-4.2# ethtool ma1
> Settings for ma1:
>          Supported ports: [ TP ]
>          Supported link modes:   10baseT/Half 10baseT/Full
>                                  100baseT/Half 100baseT/Full
>                                  1000baseT/Full
>                                  2500baseT/Full
>          Supported pause frame use: Symmetric
>          Supports auto-negotiation: Yes
>          Supported FEC modes: Not reported
>          Advertised link modes:  100baseT/Full
>                                  2500baseT/Full
>          Advertised pause frame use: Symmetric
>          Advertised auto-negotiation: Yes
>          Advertised FEC modes: Not reported
>          Speed: 100Mb/s
>          Duplex: Full
>          Auto-negotiation: on
>          Port: Twisted Pair
>          PHYAD: 0
>          Transceiver: internal
>          MDI-X: off (auto)
>          Supports Wake-on: pumbg
>          Wake-on: d
>          Current message level: 0x00000007 (7)
>                                 drv probe link
>          Link detected: yes
> -bash-4.2#
> 
> With the patch reverted:
> 
> -bash-4.2# ethtool -s ma1 speed 100 duplex full autoneg on
> -bash-4.2#
> -bash-4.2# ethtool ma1
> Settings for ma1:
>          Supported ports: [ TP ]
>          Supported link modes:   10baseT/Half 10baseT/Full
>                                  100baseT/Half 100baseT/Full
>                                  1000baseT/Full
>                                  2500baseT/Full
>          Supported pause frame use: Symmetric
>          Supports auto-negotiation: Yes
>          Supported FEC modes: Not reported
>          Advertised link modes:  100baseT/Full
>          Advertised pause frame use: Symmetric
>          Advertised auto-negotiation: Yes
>          Advertised FEC modes: Not reported
>          Speed: 100Mb/s
>          Duplex: Full
>          Port: Twisted Pair
>          PHYAD: 0
>          Transceiver: internal
>          Auto-negotiation: on
>          MDI-X: off (auto)
>          Supports Wake-on: pumbg
>          Wake-on: d
>          Current message level: 0x00000007 (7)
>                                 drv probe link
>          Link detected: yes
> -bash-4.2#
> 
> with the patch enabled:
> ==================
> 
> Default 'advertising' field is: 0x8000000020ef
> ie., 10Mbps_half, 10Mbps_full, 100Mbps_half, 100Mbps_full, 
> 1000Mbps_full, Autoneg, TP, Pause and 2500Mbps_full bits set.
> 
> and 'hw->phy.autoneg_advertised' is 0xaf
> 
> During "ethtool -s ma1 speed 100 duplex full autoneg on"
> 
> ethtool sends 'advertising' as 0x20c8 ie., 100Mbps_full, Autoneg, TP, 
> Pause bits set which are correct.
> 
> However, to reset the link with new 'advertising' bits, code takes this 
> path:
> 
> [  255.073847]  igc_setup_copper_link+0x73c/0x750
> [  255.073851]  igc_setup_link+0x4a/0x170
> [  255.073852]  igc_init_hw_base+0x98/0x100
> [  255.073855]  igc_reset+0x69/0xe0
> [  255.073857]  igc_down+0x22b/0x230
> [  255.073859]  igc_ethtool_set_link_ksettings+0x25f/0x270
> [  255.073863]  ethtool_set_link_ksettings+0xa9/0x140
> [  255.073866]  dev_ethtool+0x1236/0x2570
> 
> igc_setup_copper_link() calls igc_copper_link_autoneg().  
> igc_copper_link_autoneg() changes phy->autoneg_advertised
> 
>      phy->autoneg_advertised &= phy->autoneg_mask;
> 
> and autoneg_mask is IGC_ALL_SPEED_DUPLEX_2500 which is 0xaf:
> 
> /* 1Gbps and 2.5Gbps half duplex is not supported, nor spec-compliant. */
> #define ADVERTISE_10_HALF       0x0001
> #define ADVERTISE_10_FULL       0x0002
> #define ADVERTISE_100_HALF      0x0004
> #define ADVERTISE_100_FULL      0x0008
> #define ADVERTISE_1000_HALF     0x0010 /* Not used, just FYI */
> #define ADVERTISE_1000_FULL     0x0020
> #define ADVERTISE_2500_HALF     0x0040 /* Not used, just FYI */
> #define ADVERTISE_2500_FULL     0x0080
> 
> #define IGC_ALL_SPEED_DUPLEX_2500 ( \
>      ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
>      ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
> 
> so 0x20c8 & 0xaf becomes 0x88 ie., the TP bit (bit 7 
> of ethtool_link_mode_bit_indices) in 0x20c8 got interpreted as 
> ADVERTISE_2500_FULL. so after igc_reset(), hw->phy.autoneg_advertised is 
> 0x88. Post that, 'ethtool <interface>' reports 2500Mbps can also be 
> advertised.
> 
> @@ -445,9 +451,19 @@ static s32 igc_copper_link_autoneg(struct igc_hw *hw)
>          u16 phy_ctrl;
>          s32 ret_val;
> 
>          /* Perform some bounds checking on the autoneg advertisement
>           * parameter.
>           */
> +       if (!(phy->autoneg_advertised & ADVERTISED_2500baseX_Full))
> +               phy->autoneg_advertised &= ~ADVERTISE_2500_FULL;
> +       if ((phy->autoneg_advertised & ADVERTISED_2500baseX_Full))
> +               phy->autoneg_advertised |= ADVERTISE_2500_FULL;
> +

It will introduce more ambiguity. ADVERTISED_2500baseX_Full (is bit 15), 
2500 Base-X is a different type not supported by i225/6 parts. i225/6 
parts support 2500baseT_Full_BIT (bit 47 in new structure).
Look, ethtool used (same as igb) ethtool_convert_link_mode_to_legacy_u32 
method, but there is no option for 2500baseT_Full_BIT. (since i225 only 
copper mode, the TP advertisement was omitted intentionally in an 
original code, I thought).

>          phy->autoneg_advertised &= phy->autoneg_mask;
> 
> I see phy->autoneg_advertised modified similarly 
> in igc_phy_setup_autoneg() as well.
> 
> Above diff works for:
> 
> ethtool -s <intf> speed 10/100/1000 duplex full autoneg on
> or
> ethtool -s <intf> advertise 0x3f (0x03 or 0x0f etc)
> 
> but I haven't tested on a 2500 Mbps link. ADVERTISE_2500_FULL is there 
> only for igc.
> 
> Thanks
> Prasad
> 
> 
> On Sun, Sep 24, 2023 at 7:51 AM Andrew Lunn <andrew@lunn.ch 
> <mailto:andrew@lunn.ch>> wrote:
> 
>     On Sun, Sep 24, 2023 at 10:09:17AM +0300, Neftin, Sasha wrote:
>      > On 22/09/2023 19:38, Prasad Koya wrote:
>      > > This reverts commit 9ac3fc2f42e5ffa1e927dcbffb71b15fa81459e2.
>      > >
>      > > After the command "ethtool -s enps0 speed 100 duplex full
>     autoneg on",
>      > > i.e., advertise only 100Mbps speed to the peer, "ethtool enps0"
>     shows
>      > > advertised speeds as 100Mbps and 2500Mbps. Same behavior is seen
>      > > when changing the speed to 10Mbps or 1000Mbps.
>      > >
>      > > This applies to I225/226 parts, which only supports copper mode.
>      > > Reverting to original till the ambiguity is resolved.
>      > >
>      > > Fixes: 9ac3fc2f42e5 ("igc: set TP bit in 'supported' and
>      > > 'advertising' fields of ethtool_link_ksettings")
>      > > Signed-off-by: Prasad Koya <prasad@arista.com
>     <mailto:prasad@arista.com>>
>      >
>      > Acked-by: Sasha Neftin <sasha.neftin@intel.com
>     <mailto:sasha.neftin@intel.com>>
>      >
>      > > ---
>      > >   drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 --
>      > >   1 file changed, 2 deletions(-)
>      > >
>      > > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>     b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>      > > index 93bce729be76..0e2cb00622d1 100644
>      > > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>      > > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>      > > @@ -1708,8 +1708,6 @@ static int
>     igc_ethtool_get_link_ksettings(struct net_device *netdev,
>      > >     /* twisted pair */
>      > >     cmd->base.port = PORT_TP;
>      > >     cmd->base.phy_address = hw->phy.addr;
>      > > -   ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
>      > > -   ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
> 
>     This looks very odd. Please can you confirm this revert really does
>     make ethtool report the correct advertisement when it has been limited
>     to 100Mbps. Because looking at this patch, i have no idea how this is
>     going wrong.

Andrew, yes, I can confirm. (revert works).
We need a process fix, but it will be a different patch. Also, I prefer 
not to leave upstream code with a regression.

ethtool_convert_link_mode_to_legacy_u32 have no option to work with 
2500baseT_Full_BIT (47 > 32). Need to use a new structure for 
auto-negotiation advertisement, mask... (not u16). We need to think how 
to fix it right.

> 
>              Andrew
> 


