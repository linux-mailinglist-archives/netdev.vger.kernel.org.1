Return-Path: <netdev+bounces-15165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F8746006
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE20F1C209B7
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93551100C2;
	Mon,  3 Jul 2023 15:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85502DDC7
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:43:00 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419D3C2;
	Mon,  3 Jul 2023 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688398979; x=1719934979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OkWnL4JAMUPc2eV/bSswykCB8Abyaxlt0KjNaC2Ndxk=;
  b=UIe05znUOKmyFbZKaNYXb1t9qa5JmRcvn3Ge7ctQv+/UvVEfYPSxWldC
   YMShzsbtYBSDzBwkmGS+GyzLIMzvKD6bI1Rj+D8DiIS8RjmvkqnFgv5vN
   cStf9HwKM7tVhYEJnlMNc69e0pmaam1EFSyP6jbh88lhds7KKK3dIchNw
   IGZoQN0JX9fZwVVQW/TN91pcPwofuZcGVXjs0aQOqf6Q/fjleAInSBPip
   hXo28how92jOB7ATJGB/cr53VjxGqop7vPdZYWFA+XFKTWjMB/uWIL4go
   sfGxo7LGNw4mEtaEZ/MeIZ2ei5dgi0e3UW5is/CIcnXU7fsHA44uE0Ma1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347702122"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="347702122"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 08:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="1049124537"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="1049124537"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2023 08:42:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 08:42:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 08:42:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 08:42:55 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 08:42:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzW8UByPaNZENqJFPcC4dDIif7Fo7UkhXYjd+t11uadC+0weAICJxDj2xH9Hsy1eyYS5PcQ3ajiAgwnnwwCyAXHMrvs78Tg3g1uPg2dgqWSEw/Z86XasKaatPP+Uo/Ghs9IfVmHm5Ow30jc23Msrfvj/s+klrNI8hp3Re0tFHQHOTH9qiAPVbuOPRvPPTlUjMhGlmoDTEY+uz7iFdWONRM9BWNj25n9YA3LAP6na74q/snwCUlwB3H9hysduB55ZSnVwcRLzQxmqKLB3uZwp5CbisVyj/zTssahYe78sLF+xZMztp036T9nJkNOnxoRk9MUtv+nn2sweltCFACnLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snxDPeKXlGvMEqDHiS4fj3rBclz2cJYi6kv2y9Ftp4E=;
 b=EZo3vqf5wt+IwFmGmoF26/+HFcr+nsIdgb/OPIP+NDmUI7cGJ6KJ2AB7GGkMPaZLlweTjQdk8MFjepzMcLWARq2DRLR7hd4Ofv4Mv5cmEBIUejgY0gkS0nH4+xW5wkNgOvblXwGZ+oo/LjuGNO28iUOD64Cny1ktT8ohUklvF0Awq/2cxMINVEzwDirRJvE3KC1SpGo9cLfkbalFUj4pVtf1ZrJbHRQZdx5fpJ4A7RgCt4B2AwDXMsgPoYiRhij103qD3yCCWxjP+awjsKbRKXkPIjGcJgfHN+SwhFVps6KL0DjiNCh71Sv9KHj/Vd+nVulYg5Ob+0Szeg3/PH4TOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:42:53 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:42:52 +0000
Message-ID: <2902e638-0d4c-7ca8-6ca0-9d1ba752a20c@intel.com>
Date: Mon, 3 Jul 2023 17:41:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] mlxsw: spectrum_router: Fix an IS_ERR() vs NULL check
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Danielle Ratson
	<danieller@nvidia.com>, <netdev@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <16334acc-dc95-45be-bc12-53b2a60d9a59@moroto.mountain>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <16334acc-dc95-45be-bc12-53b2a60d9a59@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: dc694dfd-39cf-4244-51f7-08db7bdc29a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByBZbNwadiSIWMsCy7iqToZGaGer2UNRfEHAM7VveE0g26KNQDaNNwcRsvp7nhenaeJTehNr09Z79jnVW4V7dlFrJWH0pA5emEYUWCXnDxafi3mCI6O4txIDNp5Ba1toAbAluwRi4U5HT5LBMOMpL+TU4ixfwFSok8HelYDzlzD6CDeg2Bp7Zu/Xva+S3CRuTy8a5vkv/mkaZwN+nK1QbA5TinroRZ206InUJKuGN8ult9zJR2AcrPbFuo+86qIjbsWDtUuJuyDMdsaMYu/2QqAWQM9tWNo+8RkO13oSCHef3+2fjhrP6BVSOjwfKI/4kblSPdNvyXNeLNMRBVpsB6KxWIEySYxk2s6+SobQO39w6avXb/3AMxqe2b9qr1DnMacvnWdt5XXXCUNqChpg3BfDKpWpaT2tfV86MlJNBwSdWZ5yKzV5Dwdwy6TZf+tTa3Nh4hA3miVevAqukQv4Ytp+rcZlfIlmNyn7sKNhGRrLS3tCA5qkVtma4PLR4ur+PbCIP1FvzD8t8XmgCKYV1xtQv81B0NF6cSQy3Ezv6qxt6VxQcSDzShydayZVJbhcjy/6LL0Df+cHy0kdznyMpgZ0th0l52ulJh3KIFWPOTI+MOG5ShvqwTA49RzguBS+XkDGK1jXTnlfKmtVjTKl8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(41300700001)(6486002)(4744005)(38100700002)(82960400001)(83380400001)(2616005)(6506007)(26005)(186003)(66574015)(6512007)(31696002)(86362001)(54906003)(478600001)(316002)(36756003)(2906002)(66476007)(6916009)(4326008)(66946007)(66556008)(8936002)(8676002)(31686004)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJ6a2FkalNUMnlaZFZ4dG5BZTBWOGIrcFhsUFUzbGk1MkVVMG1wQzA1Zlp4?=
 =?utf-8?B?WVJLU05MQkxPbEdkTUtGRXhqZFl1OENNcjRmUHlFc2ZjUGZOdEpkV0VBRFh1?=
 =?utf-8?B?OXNEOS9zWXIzTHVvWlRPdkNuUlF3ZSsvZzVEeElMWGpaMnFxTVRyWFA4N2JQ?=
 =?utf-8?B?dFRESDZYMEdOSUV4ZHEwcU5YYU5GcDdOTUY0RjEwYk1OUmZJYzhXQnBZU1Rr?=
 =?utf-8?B?K1dpMjg3d2RqMW5UZ1BPbGJzZ3dWMnFsOVNkbm9aYnJROVNkK2kvalQ1Qldn?=
 =?utf-8?B?Q1dMcStHTnVPTkxTd3N4blNFQmFkTXB3azAwYlduZ25sWGU4VGhIZ1BEN0JW?=
 =?utf-8?B?UFpwb2U0MWdCTHZ5ckFWVHduVFFubTdCQStKTklnVml2M29Gd1d0NFlrQi9k?=
 =?utf-8?B?ZWdSc1lUS2F6WHlZbVpkZS94djd5MjY0UWxPUDNwVkF3YnF2OVRsdVc3SzI2?=
 =?utf-8?B?WFpBNDhFM0l4K3dRa01JTWtZSytkUlRuUlRuUFQ4MVdJOGppcjE0ejhEK1U2?=
 =?utf-8?B?bmJJMVdaakl5RkdsdEVzSm9hdGxOMXVEMG5hY1BQZDNCekdOUFFoaXNFM3Vz?=
 =?utf-8?B?N29wRVhnMk9MbVp5SGVCaXRoSGpPL1BIMS9JYkJTdkhWTUhkQWZVMTYzY21w?=
 =?utf-8?B?VVlUb2EzSjQ2aHdjVTRTS3E2MXpxKzZDUzJCUU94RVM4eXd4ZERNRmVvQ2p3?=
 =?utf-8?B?QkppRmxXdWxuRFhXYnBLblhYbU5MVW9TdDRqZ2FCaHNrTSs5ZnNzUnlpczhJ?=
 =?utf-8?B?bllUL1NYYk5PMzd0NHFJT0gzcFhuZUFheGFLaDhRTmpWQ0g3Kzlqc1FneWxG?=
 =?utf-8?B?anQ2Snp5U3FvbEI3bmRhZy9LMlV0SjNWd0tmSHcvYzB2bUVrMXFwd0VOUmJD?=
 =?utf-8?B?OEg4SkxPYmt6cFBxeDZWWE9CcG1nbXJtNUcwWkY0Rkw2cTZwa2ZjZDUwYXVO?=
 =?utf-8?B?TmwzMDFwM0Qxem9CZXorMllyajQ0d21zdXg2MWZNQ0RrLzFCRHlsWmNqMG5Y?=
 =?utf-8?B?aHVINStFWk9XdlZYN09INHpzRi94L1o5WDlJcEpwNlJhSHpHR252SjMxTFZl?=
 =?utf-8?B?bHkraDdMMlJZZGg4dkYxRW5YdURnWElzWElldE5ZZVV6SjNWeXRncUQzNklH?=
 =?utf-8?B?Y0tUdmZnUXNzK1A5OUlNY3pUWjBNTGRPZDF6b0VkdHVMUkt4cFZrSWdvL1N0?=
 =?utf-8?B?UWFkRER6UnZ2bExiY1dJd1YzdzBqUnJvY090WlZ1czhjNzVoeDlMM09XcVEw?=
 =?utf-8?B?SlBicCtlUUR3SkFIQmlXT053aUx0NGRFRVE0V1FiUTdCVmhKUC8xL0M2RVJK?=
 =?utf-8?B?YVdlNzlRUTRUdy9URFFFNm5pSEdRNEVHRk9HdXIzVnREQlJPc0dRNjBWYXZ2?=
 =?utf-8?B?SkZaZVVVZnEwMUIzVGtlNTBSZVpVV1AyM2g3WjFnVC9BVEEyU3Y5aytDOCsz?=
 =?utf-8?B?TUFiSHVnUmV1U2tXY2JjUlNkTXJxMVpKOGdheVJUd2RDZUxNMXFlQkFib2Vm?=
 =?utf-8?B?Yk1HZ3A1bWNmWlUyY2hxSUZua0xVUzV1L3g3c2h6dXRqVVNYM1lGdzFOT1NG?=
 =?utf-8?B?WkkySkxXbHgydjlWS0NGOTcySWR3bjU3VUovL0ZCR1JHUHRmWXh5VHlGLzJG?=
 =?utf-8?B?bTRlckNJbzY1V1VoTmNzMW1MT29FTjBjeEhqTDhlMWlNVG9KejQ5aTA0VURD?=
 =?utf-8?B?ak9vSUd5dmZGMkQvUUZIeG10SStZeXFrUTZUQkE5TU0zOUY2TlpYa0RRWmVK?=
 =?utf-8?B?VFppWTR5a0YrMnpwNlByRi8zbE0vYWpxL0lwMXFmMXRseWk1d3F3dm9aSHRZ?=
 =?utf-8?B?RC9QR241TVZPTXBSSTZoTzZqeW8yVWV0bU5veDhJL3dlbGlzTHQzdE9zT3RU?=
 =?utf-8?B?SitIZjh2UCtIcnYxZ3FodjQ1NXBRT0QwUjZuS2xzbGk1UkV3ZHk4WmZLL3Z0?=
 =?utf-8?B?ZTZHZDRycDhxMWM4VWduVU42REF3MjFnN2RGZEg5MVNZZ0lTRWFEUmpBaGtu?=
 =?utf-8?B?K2JNUUhNaEZuN3ZCTnRrWjhpSkhDcjEwOTJ0RytDb0hhdmxXSXZnQVY3MERi?=
 =?utf-8?B?ejF5WWtjVE4wTnN6MlVYcVVYUjRXWmNjK1RVSnpyc0MyNHd1VzlFMEVsUitV?=
 =?utf-8?B?Zk1tYXh0M1pySitFTUtJNmxmNGVDcEZGaTZWTUxhNkpvWWVlSmdQcFErK1NF?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc694dfd-39cf-4244-51f7-08db7bdc29a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:42:52.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hucEqSihVOZYwW6vcqX9h35RMxY5Y0TypcR1YwqK7Us6r1DhKfYZ+jX/aNBQg5vKDpk9utmoXOEUzEQ9y4gE0SWVM7ulKq9Hxq0BPE3ouDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Mon, 3 Jul 2023 18:24:52 +0300

> The mlxsw_sp_crif_alloc() function returns NULL on error.  It doesn't
> return error pointers.  Fix the check.
> 
> Fixes: 78126cfd5dc9 ("mlxsw: spectrum_router: Maintain CRIF for fallback loopback RIF")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> Applies to net.
> 
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

[...]

Thanks,
Olek

