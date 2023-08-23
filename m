Return-Path: <netdev+bounces-30106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E078609D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104121C20CBD
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A141FB27;
	Wed, 23 Aug 2023 19:29:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4E156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:29:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308BCE6E;
	Wed, 23 Aug 2023 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692818974; x=1724354974;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6LF0tAFrB/YveAnxWIlu7f4GfHYvM1EWDUNZG1MNHAs=;
  b=PCKAgPMV6tYmXNWSzDEZiROJJQTez51Kv8tr/uCdltq2ZNCsLoLTBn2I
   s/XKa+5eNjgkv2OA65LMY75YnZ7BoSWb+QFuwZy7WswdGkGlZKZHEM+Zp
   Wk3RhF+1kB2i7J7ise8VwVbmOr7kyuR1niKU4oIgMrpzVvA5A3sbdH42u
   Ezucf7AxMPILVpFKoGn3HnyZlUWe6RyEBOTZo0azOGBRPkbMKmfn1aJtd
   XofoBHxZBJwHy9bA5lOXz0EjGmPzpc9GP1QDi+I8oP0+NmPX2Wj1oLiuO
   Ts/ZKqIXJVLZDuME80NFY4zV7NW3R1AfraSOuIHTreA+KDehgCL6t3AGB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405255364"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405255364"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851162924"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="851162924"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2023 12:29:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:29:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:29:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:29:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nntFa2LXmNodaZGyxxs9K/Cu9lQ6tgSKS8qF+cEf0YhxXmmBD+PaNIugbohXScbs3wUcDbg7CjhIOf/O2D1U6WfgoAiPnqgwiZ79nn51tP+64tPmiDXaFb6DrPcZha6jECtnOV98WNHRhNHI2Y9l/zbcAq/baNhUYF2zUGNe9taKxwW00wCQg291M4u859iCBVnvUwK/BLHsg/NKmvmX6oGvMITs8alcAN90pxe1xAt095XnCVH1/drrC5CLBanRt0h2eKZKMJWm/pXfdIxiIfVcaw6a+OPoUmbYoI7RYLZPDEbG+QEHjKaZOxedzFqPgciiLwxe9J5oh21hqah9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzZZnhG2IGEGAkqqCbDTj8EyG5RTDxhApEZm/Dxjnjg=;
 b=drHCndbHZRYdRanfJJ5SFLMQURRUzc/0OZX0+lOOJgGG45jNYkkrRkdQzE/kbzVCeWOia7V+hq0gnGKrNgHgNUKTCkXzsQxat1hPKjr+ccEbzNRq2+HfMSqodat2ep98U6OSmC8nM8Crf0uQAybPKfldhdRPpFpAHDBjxbyrCA5yg6nPFunsJKoaQW9jscnuCVJu/bclDaKwlmZMOzBpMdmba7eNCMiOwNKwSfGvPyVQaYf2z4+w5yzNYLO0Fvsj+zQqIUFmT/141Ijdy/SX+fxQg2Hg02M2BwMKUXsHwJlG+PrD63GHfLwPBMrT56J/umzNYsHi+Nb1V9m4hxDnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:29:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:29:30 +0000
Message-ID: <4da4b150-4138-4885-58cf-d3493695bbba@intel.com>
Date: Wed, 23 Aug 2023 12:29:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 01/12] doc/netlink: Fix typo in genetlink-*
 schemas
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-2-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-2-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea7c7da-b889-428d-7cd5-08dba40f455b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwuSMozWb92bRw7HOH6njI4TyglrjgVtFff2pWBIXHUYcbHEqq0yv1bV5ra+Y2TG4u9zVDJciaRVfa67a6r57XzUvJX+Ez9SNqUtuASmv3s45X1Oof1QkUvtCGe83NBywatpWeu1jAvXO6RRo9pGkVaKB1GONxn8EF0DLx4dneSa7hyRH9fuCNHp5tbS4SpTg1b43cFlneRE1FAunzIKpavzb03mGog/nhVkb9644XWbZspWuyqbARYhWgwSTflu1knjbZeTORJtAQUbQZtgXJlPfn4x+x6gzaTpRIoqUg01AiNU+dyi5dpU76sfJUVRH1FEghVr6PNvdnUfCFheaArJ7kokeGCf5hazXaY1Il0OKFtBoUncjBrF0zf+P8yiKum4vBfp0dLBF9yXK3dM7DjO2D1GIH6tQO0lq/aVUQMDRIjTN88KGb9m/u+ovthGzX6YwzhS2f0AZGUAMRxbYo/vTPaTNVjlPCtazLsc3Ipn34dTQc0fZFbFq/1KqmgtI2p5kvnl9n/5XwvdOg+FlhNPyAUnFvLa9jct/6Lu0t5qkswZJggZ9DjXSfjFnk1o3GqI8Ml3xo11FKTUMbNIBb3sBwuv+C/bT6mT6dKVUPeghuP3mEjoch/+15mPcw7AC6ZqFBOwwmSrFXoR1bYlBW5lYQL3IkwHDYuArGViIFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(186009)(1800799009)(451199024)(6506007)(6486002)(6666004)(53546011)(6512007)(83380400001)(921005)(86362001)(31696002)(38100700002)(82960400001)(36756003)(26005)(2616005)(2906002)(316002)(66946007)(66556008)(6636002)(41300700001)(110136005)(66476007)(5660300002)(8676002)(7416002)(4326008)(31686004)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFwSXloWkY1NDM0QWZKNkRXUXA2ZnVXNUQ5R2ZFcE83eTA4M3Zkak95NTBa?=
 =?utf-8?B?UFpUZ3N4REZLeFQzTlZnVXF5dm8rK3hTQ0gwMmlzM1RrVFpYa2I2RWFtSlYz?=
 =?utf-8?B?OEVhMm1ubURFbWx0cm1iOURWTUJRSzhoeXNuUDhyQnpEYzBQOGtKVlA0T1hy?=
 =?utf-8?B?bG1pN3RScTNHN29odTYyYnplMWtIUXo4WHlKVW5aUm94a1MrK29hbC8wdVJ3?=
 =?utf-8?B?QlBHRS9jWVNmZ1djd3hZR2QrRGUva2gxZ01XemVEQitOT29pSEZHWDlvQlBD?=
 =?utf-8?B?WnQyR3JKZmxNVmFKelFDQWVaM0ZtL0I0dVNTK0pHdCtmVWZDSk9BKzMvUmVh?=
 =?utf-8?B?L2IxeEdOWlhRd2w0YU4wT0FHZHJKR3Bjak1aQUxGWEUzcHMvVHhWL0NDaEpW?=
 =?utf-8?B?TlM5V24ya083UHYyME1PcUpRaHZ1c3U0NmVOTWVic053ejJjZWpyNUMyaUlt?=
 =?utf-8?B?RjNFYllzeERMbncvK3JSbW82aXR2dkFpdS9jS3llazA2T2hZM0pyRWErL29t?=
 =?utf-8?B?M3JSelFhWXVFc0J1bFc1ZHpKRVlNbWQyUDRyNFE0UjQrcjFwT2RaQzhlUC94?=
 =?utf-8?B?SStoS0RzLzFLQUZHeWRMRzNwMythc3dTelBvVFlSTnhtYjZVMWdSYzJSMkh6?=
 =?utf-8?B?QVhCTEdCTlpTenlEVG4vREoyNzF0ZllFZldDdHI5YVV3bFduTE11bGdneHc0?=
 =?utf-8?B?NXdrUUxTTmtPalNLYU9LK3JiQzhuNjVYL0ZXV3UyUXBtQ3NTNlJFcFFibWU4?=
 =?utf-8?B?SjhOcGpQN1lDd1FWVVltWUdjNklSZUkwdkRhSmI5MXBBenNoV1dBRmZuUmw3?=
 =?utf-8?B?Z21LU1UvV29XVVVWUW8wd0tNSkR1L09sb1BZVjlXL2hsL2VTOW1HSW9EYVhU?=
 =?utf-8?B?ZldSMWJzR0FieThpbUsyREc0enlyUWJMcUFnTzZ1V2FZSTNmUGFWTGR4eVpL?=
 =?utf-8?B?WDhYd1d2eW1TQ2FIU2lzNlZIaG5INUl2TE02cnlrbFV5UWh6Y1hwVFZGcGZM?=
 =?utf-8?B?N0Y0eTI5azRLdkczN0lzUWt1NFIzWERTMXBaRTYvTEVteWoyL2NQNTlNdGpz?=
 =?utf-8?B?Y1NRU2YxT0ZXM3c3T2JXaDVBd3RBOGd0RGhReUlDeEJ1NnhQYnRTQUtrMjZa?=
 =?utf-8?B?VUVuUEs0ODFjdUVWQzkrdndhT3lxZVVpMWZON1N6YUtMNVNuTEFzbzBJcGpn?=
 =?utf-8?B?RHZzd2ZQZlQ3RlVxNC9tc2FrMmltTjE5Q2YwaFdyZTFNRDFiOFRsd3JoZlQ2?=
 =?utf-8?B?Q2JzTERFMFJvWU14SHdvT3VTODRPNEx5UERmNjJLQmZFWXNkd0lhTm84dmlS?=
 =?utf-8?B?V1grVjNSaGZVTzhDOUJXNzVBY2MvZDlHWEplMW9yeEJ5Rm9EeCtLK0pIdUJn?=
 =?utf-8?B?L1ZWQnd6bVRRRm52SXpjZUFYT21EbTYzak5tY0pJTDkwSUFrcDkvVkFxZi9W?=
 =?utf-8?B?OUplRmhOSmVmUjFIZ3FJQXErN052UG1nazNxSlN4dGIxMis3TlZtdERMVldU?=
 =?utf-8?B?Und3L2pCUzZVNTdkQ3ZhVExjK2dpS3psNlM3WHRObzcvdUtDOGVTM1pETjBw?=
 =?utf-8?B?TkF1Tk82RmNUaTFGajFPcXV4QWY0YjRHdGVQRjZlMnY3TG54dmNkVHpkQ1Zv?=
 =?utf-8?B?Z0w3N3Job0o2WEd5MmxFY0VxUU1iMGZxdWh0MnY5NVFjY0xBeVh6cWU0aTJB?=
 =?utf-8?B?L0RCY3gzRTV0cDFGK3RpSnNMQ1FpTWRPVWJrQVNVNnNLVzUxQ1VGNnIvZXhN?=
 =?utf-8?B?K1dxUXZhT0VOZUR0WjVuRkxKMnNuU3dlM2NPNnAwQnExWGdBSXI2OXVpNFZP?=
 =?utf-8?B?MGV6Si9ETWlNSzFxQzZ2OXVTZG9HZmJSbkZsL001RXlMYkhTNHlVOEwvSmJL?=
 =?utf-8?B?bGNkWEFuMWxLTnh3VzJ6TjY1cmZjdmFPZStJUC9HZW1xYy90cGxqNFFDWHd5?=
 =?utf-8?B?R2syUGJGVlg3dEtTWGJxL2p2M2ZQaWEwMmc3OUpVYW5TckxWVi84c0lSNnp5?=
 =?utf-8?B?TUxTVk1vOFd5djdta1V5KzFwV1pZQ3VRRVpCRkRXeHI3WXN3dllSbnE3bGFt?=
 =?utf-8?B?MzAzQ2luOW9OU0kwSCtoR0M3RlRSZWpBcms5YXhpek44Z0tySk90eGJUZW5V?=
 =?utf-8?B?blIxT21TRkJYWHFGVDJMOFU1NmNDc3ZzazhTYUxnbjlHK1pTaFNSOXhkSDZY?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea7c7da-b889-428d-7cd5-08dba40f455b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:29:30.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osWsRRzUstAdAZQ9LfCYgBPWWKMtxP0vc+dPrejcO6KbLRh6We4uIZvzWB4pWen/okYHEWUWndVP3th1lMLVsnJWn581N/IuLqmT7QPaTj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> Fix typo verion -> version in genetlink-c and genetlink-legacy.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  Documentation/netlink/genetlink-c.yaml      | 2 +-
>  Documentation/netlink/genetlink-legacy.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
> index 4c1f8c22627b..9806c44f604c 100644
> --- a/Documentation/netlink/genetlink-c.yaml
> +++ b/Documentation/netlink/genetlink-c.yaml
> @@ -41,7 +41,7 @@ properties:
>      description: Name of the define for the family name.
>      type: string
>    c-version-name:
> -    description: Name of the define for the verion of the family.
> +    description: Name of the define for the version of the family.
>      type: string
>    max-by-define:
>      description: Makes the number of attributes and commands be specified by a define, not an enum value.
> diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
> index 196076dfa309..12a0a045605d 100644
> --- a/Documentation/netlink/genetlink-legacy.yaml
> +++ b/Documentation/netlink/genetlink-legacy.yaml
> @@ -41,7 +41,7 @@ properties:
>      description: Name of the define for the family name.
>      type: string
>    c-version-name:
> -    description: Name of the define for the verion of the family.
> +    description: Name of the define for the version of the family.
>      type: string
>    max-by-define:
>      description: Makes the number of attributes and commands be specified by a define, not an enum value.

