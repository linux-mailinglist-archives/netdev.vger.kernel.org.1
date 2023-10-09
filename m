Return-Path: <netdev+bounces-39063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC567BD9F9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF0D2815EE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF44618658;
	Mon,  9 Oct 2023 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqJOaH1N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513708F57
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:33:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DE399
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 04:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696851234; x=1728387234;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eECKTJHncxdTTPFSFVBeEYrFryUUJ5EFL+QDIR67gho=;
  b=CqJOaH1NqrOczFP1hICXtaLOEIlK9BEtb4nnl8HvE6kVhAKUncjiZUvB
   p6apuTvDzMrCQaslpcBXqi8kmtUYEZ4q9CwZvdorYAOVw2mJehdLBh7S6
   cGryH4SWJpKMReYtB+4oU3GQo9Q2GX8qYfYUQAN2t5Uamc0KeUePO2m86
   fopSDs7PX+MYupxvu8QO+wCm0b+RrP7TApPtkHEkQ3Isa/Lh59mQEXxxU
   2EOVQF93309DSoWJEQAaPc3qgy3CUjvrJGbsLlhT2nMFfRBRotp0K5+we
   sB2Xl16fXQMRGuANkgl9TbagiPOnPrEUMrNgQNSvD3t+N0PTQysU74rU1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="374450143"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="374450143"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 04:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818825318"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="818825318"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 04:33:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 04:33:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 04:33:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 04:33:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZdV53wI9nIelMyq1+Zz+Nt/UH+zjcfPdu3UyFCO4DQ8Gr9OWJMzrzlW5N1Ne6tIFtcKmVZCG9Y/PXhfk9Ghw4W93hboxTWXlJgZAzkEGsfIDpT0LiVxEw9sftWXKSVmfdTeLJX/aN6tt+zJIr/wFhwT8qVkEECzPEzSqllnIFRsg6u+5nhH0TQ2wUMp/aQ/D9ETC7EzoEnFSMilaD/+kPJBLwyD6SqaEUhB1tuzuqND9TX+FXkgUyCuOjvfU72uQz1vnhFtgxkXk6KllSwGYdWsYcmgQfNoAvYtTcCcWgtHXPbb1hFms24lu9k69jlLb12ZxM6lnALkL6pj1GD7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDcX9ocVwN9iKudIySe6/8hkfcoMx8r7C0QC7MhN7Jw=;
 b=BuRK7CrqcjRUFlvOTs8gmWK9Z91versllIYvUSlR2cjaeDGkk52ZmqwLYmwTBQA++LlXEXxsF8UJfml3RG/sxTD5bXYzHGWBHwcqu2OAG6MOpmOlzsMf9KUJY/iovpwOz4eF3xhKGTU2cZwgrgHY2fOmb6LqAkBQyEyv38+wjUWyEZb2ff10UiwmvBXzopdD/NYaVEDlGhoMdnz08zCkzgNlbimDDqYRwHgDIjPUE0JRgrPm8WSKA/o7LN2wBBzeRNLxQfKY5Hx7THL60QBP8Y/5yDQNLB0J3S3Oq6DGN9bxdiSJ4h2qiZucLfwTvbylkyqpRbNeBxpwba3LhNdd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 11:33:49 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::2e53:30db:3edf:1f2a]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::2e53:30db:3edf:1f2a%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 11:33:49 +0000
Message-ID: <84bae196-8e32-4c9d-96c0-c3bcc8d50493@intel.com>
Date: Mon, 9 Oct 2023 13:33:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] docs: fix info about representor identification
Content-Language: pl
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231009111544.143609-1-mateusz.polchlopek@intel.com>
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20231009111544.143609-1-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DS0PR11MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc8e07d-5e2c-45d1-ca2e-08dbc8bb9b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9Ya2G49ZzdBsLeUSLbpjplNY+vTUELGbEyH7x1bSbWEQQIyvtLXQJ1eDzcG1YrZzHjTuW/e/+kd/2xZXQE7RB2KSmER72LcAR99nOsAQpf+Qh6Dd+rPQ7FarzYurx4Pd4voKU9O0i4QF04P+3oFzQaDMTXcfbh4f/YYnstgDCOQtTrLpgHC9r2R2k4Ugo7xknV/sFWWrdOnaWiD8Om9H/mOnLqVqORSxsdU9WTASTDeRguIqcClu/q3hgGQHkiLoZ7aKYs2D98pzfUWcFlIMApJsESHMI0yt4Da7PPtzBiTzLDaobZccVKieC/0jHo15QILU+cOdVqSnoNRY+8QrBBGKjmmEFjav5NsQMJm4zB7rPwYPktdGAK8epbKWFGY/j//6ymlDKtIK1VgJv37mfE3ctkFncUVqeWX8OvH+EeaxJGYjwqBTogs+mznQFU8YV5P2/pLtP4GxgkpBtNhstKDZF8FHBzscgXF+Da8RMtXgUCHc9zY1uUtH7gXaybMZiZM416SjVm9Hg2s+V6EfpXURNLUkr2ixsec1ehwY/vHz7iWq70sM+BX3EemXDV7lWXcab2hZXRwQQL7qqznwRBTQcv7euJCXOmY1WtA6H6hu4buoKTjeJqc/f5mrqk8uG8ZF8NzuL12h4CxwrH1gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(107886003)(6512007)(36916002)(53546011)(6486002)(478600001)(6506007)(966005)(2616005)(2906002)(26005)(83380400001)(44832011)(5660300002)(66946007)(66556008)(54906003)(66476007)(8936002)(4326008)(8676002)(41300700001)(316002)(6916009)(38100700002)(82960400001)(36756003)(31696002)(86362001)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllEZGlwUFI4OXl3aE9nQWxtNGxueXFpVTNwa2k2OHdNcjFPc2NHNGsrOG90?=
 =?utf-8?B?UVp3c01ZdlgraDRZbDBINlRtOEpHbThYWnRwUG9XZkM0T2VjZWtFNCtKMjVO?=
 =?utf-8?B?c04vQmw1YXZlemNHMndsNmVsV0tLajB1VmFxODFHUEsxRWRTeGx5NHpwdVp6?=
 =?utf-8?B?Q3BFWnAvK3hGNGpCcUpJdGI5bmVwT04xYzlaYnQrVEdMQ0UvdVlsUTUvek9x?=
 =?utf-8?B?bjhpUWQ0czhRZyt4S3A2QXVMbG40NmFzYlQzT0c3V09LanFTdUdpTTh3Tmp5?=
 =?utf-8?B?VUpYT2J1TVFFeEhnOWwwUmxXTHhBdHhjOEEzbmdQK3RUV1ZqbVAwKzdmem00?=
 =?utf-8?B?TGg4UlcrejZ3ekptVFBKVWU1WEJRbUNHUnpJaWl1anBmREEwaFpVN2hVRUlv?=
 =?utf-8?B?d2kyTjZONVZGVGFhRG85QWRQRVFMT1poSUFzSTgwdXc5TzNNTERnbUkxMnFw?=
 =?utf-8?B?MDhhcmxnT29NbGtGdEVZTTVsK2o4V0RhS0RJQmZiM01SeWZrUytvc0Y4d3Nx?=
 =?utf-8?B?YWxrbU9NeTBEWm5lUi94cGVGWjVoWUdFNHU2SEQ5QzNtVDY5Zm1uYldHY3VS?=
 =?utf-8?B?QUk4ZDArdHZGL0RQWTVxdWJ3dnR5RUpzSU9xcE83M1ZaSTBxUkFvdXVVaVZG?=
 =?utf-8?B?WE1nZjJaSFc5TElMN1pDdnJ1T1ZybVU0RGRYOVlVcFllSFdCS2tMZkNOaTVC?=
 =?utf-8?B?c1lnazN3bE02YVpIZGhYQm5weENHS1gvcjUyeUc4amloY1B0RHBQaUZHMHIr?=
 =?utf-8?B?MFVlR3k1blgzeEllRUpLaWNhUVA0WUh5aVpMUHo5TEhaRVZiYjZBK2xoODJO?=
 =?utf-8?B?UzMxV3hqVFMxbDVnT3NLc05xNGIwOEJWNk1EQ3NQWW5jVHBJN2FlckhKVFlo?=
 =?utf-8?B?ZnBmZmJPK21nT09lU01FeS9NZ0JWWDcrZm9XSThQQ1ZWK3FVbzVRb2FMOW5q?=
 =?utf-8?B?ZlVzWDBaMkN2L2RxUUlmYmd6YStLY2pEY1o5UkVhSmM3Wm5SNGwySlpqOFBL?=
 =?utf-8?B?TXI4UkRzQWcxaFlQc0pZM2NQZGNycjZJd1Z4SFA3cUxNdWxFN2ZmWDVsS0NE?=
 =?utf-8?B?VGRFcVlBNUdnaDkrVFhsRzR0cWhQT1FWRmpjNk5kc1B1eE5Lb0pnT0hPcEMx?=
 =?utf-8?B?VXcwNWhvMUFZYTdlU2UycEY2S0pqQktMUzA2bmVvWmRIL3NYOS9OZU9TVFZk?=
 =?utf-8?B?L21NY0M4U3ZzTXJTRFdpZzJoREUyaWpaR3B5aE5NbW9TUmpnUXhjYksyYitk?=
 =?utf-8?B?cHZOeFFVQnRuN1RRcGNrc1FHUFJId1RzMjJlR1BMTk5tRHJvYk43SG13UVdN?=
 =?utf-8?B?Sm9ET2wwbm9BZjk4cnl4VFJKMXdyajdudUxnU1BmMjAvM2s0b01TdTFoV2wz?=
 =?utf-8?B?WTRabHM2dWpvQlhHbWRBMllDYjI5SjdMa0I4eWNOd1o0VlhVTnZ5OTg3bDRO?=
 =?utf-8?B?cnRJV3p2U3RxZUpta1hRTytQMVprRFBTRHg4RHJWSEFoK0xHUE5KakxFZGRJ?=
 =?utf-8?B?cHUxVFg3dXpBOUpKUUdKaVlKRE9adm1oc25jVlpGS21PQ256VGNLNVo0Skpp?=
 =?utf-8?B?Zzd4eGhyY1ZMQU8zalZ6dkhEZ0NZQzd1RzNZMkpVNDdCbEx4dnU1bDFIZ2hw?=
 =?utf-8?B?MHB1SjhiYXlCNzg5UDJxeStqckU1cVdxa2NHaDlUc3JmOWZMVkdhTFY3ZUFk?=
 =?utf-8?B?WGRta3h3YnptUmFjQUplZWk1NVpyYnl5Y0Y2QktjYW5jUy92ZzdIdW9LWk95?=
 =?utf-8?B?QStKSjF4WjdTY29IOGhGNjVaNHpMeDBLSHd6bXAxQll5OCswbW9pWlA4OVQx?=
 =?utf-8?B?UUpoRlBrVjIvS1p1cCtzVmlVZzF1dXlPZ0NYdk94a0o2U3JxNFAwYnhnQ2U2?=
 =?utf-8?B?WCt3ZGNRWkpQbFI0QWcyZGNQZVg2enhQWkgvSEhqcHEwcHg5dHVKMC9mV28r?=
 =?utf-8?B?ZTFsVDhCTEJrb0J4MzR6elB5K25pMW9pWlVFR0JFc2hGajdSa0JtU3pscDBv?=
 =?utf-8?B?VDY5djl1SFRiQjNDOVdjVTdIaXMzQW51aHBucFFjQ2MvNGpCei9nL3lTUjFV?=
 =?utf-8?B?T1RjTXhBTzRmQU1FK3Z3S2ZJQkp0OHZXMVBYVkFWRXdYR1Q1MCtadVdNcVM1?=
 =?utf-8?B?UmtSYVFZbnJOaER3RktLZHp1OHZxQnNSdC9taTdIRjJOSDdDOWhhZHdWSXE4?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc8e07d-5e2c-45d1-ca2e-08dbc8bb9b08
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:33:49.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS0+LdWpyI/9Q0QVq72FcCEnSjLFIDMGq055r9Ngpou1yTz/Ft7WTN+ocK4Omgzdi3cshRs/ggyIrdek7rCGeY3L7MZxz4FWHy4eAElIPms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8114
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/2023 1:15 PM, Mateusz Polchlopek wrote:
> Update the "How are representors identified?" documentation
> subchapter. For newer kernels driver developers should use
> SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
> callback.
> 
> --
> v1:
> - targeting -net, without IWL
> https://lore.kernel.org/netdev/20231006091412.92156-1-mateusz.polchlopek@intel.com/
> ---
>

There is a typo (two hyphens instead three), so because of that mistake 
tomorrow I will send the v3 patch.

> Fixes: 7712b3e966ea ("Merge branch 'net-fix-netdev-to-devlink_port-linkage-and-expose-to-user'")
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>   Documentation/networking/representors.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/representors.rst b/Documentation/networking/representors.rst
> index ee1f5cd54496..2d6b7b493fa6 100644
> --- a/Documentation/networking/representors.rst
> +++ b/Documentation/networking/representors.rst
> @@ -162,9 +162,9 @@ How are representors identified?
>   The representor netdevice should *not* directly refer to a PCIe device (e.g.
>   through ``net_dev->dev.parent`` / ``SET_NETDEV_DEV()``), either of the
>   representee or of the switchdev function.
> -Instead, it should implement the ``ndo_get_devlink_port()`` netdevice op, which
> -the kernel uses to provide the ``phys_switch_id`` and ``phys_port_name`` sysfs
> -nodes.  (Some legacy drivers implement ``ndo_get_port_parent_id()`` and
> +Instead, driver developers should use ``SET_NETDEV_DEVLINK_PORT`` macro to
> +assign devlink port instance to a netdevice before it registers the netdevice.
> +(Some legacy drivers implement ``ndo_get_port_parent_id()`` and
>   ``ndo_get_phys_port_name()`` directly, but this is deprecated.)  See
>   :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>` for the
>   details of this API.

