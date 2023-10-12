Return-Path: <netdev+bounces-40494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2937C7893
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B82282B47
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67653E485;
	Thu, 12 Oct 2023 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0iLkeyi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40F3AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:23:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAC69D
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697145825; x=1728681825;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Enu26dKmyHXEl5jkxDtbXNTW+OZOirVnYCsGrC8I3IQ=;
  b=Q0iLkeyiqwfznrMcgKd8Wi170/T9LKPbRCTVN+Vxp/pR4e4e/PqT7n+d
   97UWe1HrhmmfueQLwV4zuRb9Nq+AoRM2bcFtINVDs8x/IJrpmg0SAb3PR
   CmAwERs5SPPd0lg99JyhgJvNG5Gt1w2Vug7X91sp5rF+ZIYhSDqY1b1az
   ItnXzRUWGXfijHAGp0vND3mumpJczEm3YR+nddEglky64LjI6OqVrLAWA
   cbd8RDq6O/PyXGPfRYdM0dWqCZVkW7FsVXdBnojr/WWHDO4pB1YnLwJ8+
   0zOY5soYVtkA9rNmwGztawj3Q34vvZ9yTVXS5pla8VeMtIUNGbiKQZ08c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365302310"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365302310"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="878244494"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="878244494"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:23:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:23:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:23:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwlrHqLG99yDOU/ChmlBZg1xkggfesCKZNQysKcdrbJlZBLnmrz5PM+2xOX2I1fnjOfEGsTNr6m3E3IpbtRQHQdielJwM2lABbwoOZwYxnRXQwtsewca+ZikQekorWZQPSjKIooatYWQqcE8KPIj4tqY1P2s3xu2aUU26dvdcU1Uu+ezFeLuuSXQ5A6lcucT2oQx9kpUPbkir1jdxuGGTRqDkiceCubHKltvA4Ns/72AsAEjQuKc2l6HWXSjtY49GU3fe2wEX9tCDc2JKLC4k4QhjsFXuF3vvYIy0nSzkaZhf6atOply0Y56+ZOnckfucMHoCRevXXd2zxk1VYJ78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIPuxIXRpcut7+i7On4meSGHQgbtGP4y4DmuGE04MXE=;
 b=TZL+jcWLHDyg7qVuFHg/WH3utJ6CUrdOk9C2GM7siZX46cApjNI+kpwk9Hy9b5xE23hhCe9kNtDkFL/MUHjYclpSV6hAose5K7X1QYb8MY9dZxe8SxBLwBGFbI0NCybWUht3r/WZ3vMXbtJxxPM2h1w4hfGuDgAu+BqlNrjomNjMdmhREFV7yA0ho88dID/QtIZHVs3EX72ObEJhnZXDObshD6RkQXrE3dgo0YzAiRnGtPV/sMw4RQK0x0md19e7J91Iu7vwrXjkDI+5BI6B0PndEpBQSnexIg715zpwUxS3/r1XgaBthgT/DwL3LemPA1qLBDlHam1gTwHR/8Z05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:23:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:23:28 +0000
Message-ID: <a8c46806-3c2a-42cd-8adc-654c8902692d@intel.com>
Date: Thu, 12 Oct 2023 14:23:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 03/15] net/mlx5: Avoid false positive lockdep
 warning by adding lock_class_key
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-4-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-4-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:303:b9::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b79b14c-9246-42d3-17a1-08dbcb697a1c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwrSLHOvdC9p0Kupp+b7jBAVWUaP46DUBmogVu2GI0H7ks2FhMCV9zy2UvpC7JjbtMmDMzDZl92XrhogOtJSIBSlT+ZHm4kBDyJbTG4zYUIHZbttOz+genIH+8sL63L8w71TotRefSroZyYLz3wCVPIzLGZAV63CZIVLeo27alZCIOxgL3U6ULgjg9lrqEAAYvxzmnI5ri05isT0ZbNoe5n7TtnOoMP+HwmMK6mnWPScKwkX/cMwt9U7emTIa0HdtaVdKOU+S7wBDGVa69dJ3P+uIDroMTfauWZe72mJFezjard2wJ3sBP4mm/2HBxRq/O0Z0NQcQpqeEwzDEGmfyOM8dFEp/asLk9ZBwRXjFvjOHgbyfQO66y7tsgw6q9ZUNfGTj3ZC+PR4wOIR5iNE9yZogRY4vKCt1p7lTmWk6cX5PC3DwDQpakQ5+fgf7sqfBrIDMODu3tBCcqgt+q22WVpJqb9jQdLOskSzMq3HEX4E3Dsd7aQ6+BfIEdut1lXSsZKEfcQm7E3iih4u8eIH3XNLgUh1qhpn/pxpJDiQ+ipsu+8nUWkYDGtl0grB0Exv9s2qKyrY67z9ZQ1C40mmDYZSThL6KER52klwMbQ/yYm9ZKnOV9ticEV1DiFJLjP9dXFZuOx94/vSpWhorzb5Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(66476007)(6486002)(66946007)(110136005)(66556008)(82960400001)(54906003)(6512007)(26005)(2616005)(36756003)(316002)(53546011)(4326008)(8676002)(8936002)(41300700001)(7416002)(2906002)(5660300002)(38100700002)(86362001)(6506007)(31696002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFR6eFdRanVReXFVREpFRFNvMGJSb2EzZnBHK1ljODZxenJHbkN2R0JIYnF3?=
 =?utf-8?B?OERVUGVjSkJGN0JhMFQva25ld1JydThCalVmUGxvclVMMTZCTnVFRlFqWk5o?=
 =?utf-8?B?SGdtT0xJZllKZG5TUXJWVzdzNW45SjdWWXRva0x0Z3N0V0lzT3VHK3VWRFhI?=
 =?utf-8?B?dCtEYUtNelVHVlZKTldkN2RwM0hxZzFVczRPVGlYd2d6Q1NLNHRCS1YwTHEz?=
 =?utf-8?B?cWJKbEJYcWc4TVRpYzd5Y3V6bE95VVRIeEdqcGg0Q2JyNG1oM3pUUmxoRjZn?=
 =?utf-8?B?ZkxLdnIzdVNhcW5OQUdlSldGbzRUOUQ3R2hxOWZwVEFBYjc4bEFGcGhacnIw?=
 =?utf-8?B?MXY0T1FTS2FTWWR6ZFVDYUZ6eERvcUNycmYvbmV2Tkw5Q2FJOXFoMEd5N1Vt?=
 =?utf-8?B?TGFKZENIQkE1TXY5VUlZWktoTC81NTlTY24yT2ZWOGJRWGV0NFowRkNJRmo5?=
 =?utf-8?B?ZG9tdERZNGUvdDNXY3d4a29qMTlnWmZpNHp2cWNWSHdEU1BMWlJiMjAveThl?=
 =?utf-8?B?ODFJc29yK2lhWWlJV1hTaTRhTVVMb3ZyNTdiRENZUzloMkRINlRHaW53K2FC?=
 =?utf-8?B?enZwaVJUUVFGWXVlOHlNM2RPNGgxVE9DL2dSU1ZXd0tXdGI5dUpQa3Brakpt?=
 =?utf-8?B?ZGhUY2swZk9JZmw5R1A5OWR3NW9Ed0RJenJFSXVkTlpHRHpJQ1RMaTZ3a2xM?=
 =?utf-8?B?OHFwSy9kT2FMekpURjhIaWlmSHU1TUtQenZvaWZ2VGdwNVlUVkVBTVFOOUpq?=
 =?utf-8?B?cGZRcGZtSmV1azBKcFhGVGxTYXhMN2pBcTRweWFhcjJEWDdJVS9zV2VrZGZS?=
 =?utf-8?B?QXhuSm5RKzhiaHVJZ3pHWGt1MEp0ZFVITlRHM0hDTjNqNkdvZEhzM0xrNVp3?=
 =?utf-8?B?ZjJzTjdxNTQrTEkrNGoyRjdFc2RyTjY3R01zdTlhU3k1bmlzamNPZDJwQUNV?=
 =?utf-8?B?R1RsdUxGOUxDOS9TWmhKMGpYWTZib1ljTEpod1B6WEp5YWwwQnlrRjVmTHhN?=
 =?utf-8?B?Z2ljYm55SXVUOUIwb3VYbTRBeVhBcnhYeFpTQlZsTXR1eDI1OURrZlVjVWdL?=
 =?utf-8?B?MmZnWkN4R3FsRkpRa1VTNmZGUlZxcVNxM1JFK3QrTXBzVWZDSFFnemI5Skc2?=
 =?utf-8?B?Mm9LTmNCYUhIQzFodzNsMTYvcVdRK3ZLWGdDWksxZjNxREFjZngxNmF1WmlW?=
 =?utf-8?B?VE1DWCszU2lpcVpMQVRiOUN3dTVwTmd0Z0NqRzZiS0liNkF6MFdSeHUyUms5?=
 =?utf-8?B?ZTRFZG1YR3NMUEs1dU5sTERMcjZYNitueGZPbEcvaEtlTDZQNW5QcDA2OERn?=
 =?utf-8?B?SnhmUnpsMGJtWmVkelJvdjlEbFBlOE9FUzBqWVA2ZFlzcEMzS0J5ajRRMlg5?=
 =?utf-8?B?dnZVSE5SanpYa3RHWHBFbkRrNUdxem12OWpNYnIvL1JvazlqWjhWbi9rZDRB?=
 =?utf-8?B?eVBGbUEvWktHVDhGVlh5bnBqK3hBcXlJWHZJRDh1ci8rQVFpOGxjWTUxNFB5?=
 =?utf-8?B?M3dnTWppVENzYTN2dTQrYktsMGVzL0VXUnFVcjcxQlZtRnZGdHVWSlNIRGtR?=
 =?utf-8?B?V3F2RUJYT2FqdDJ0SFhvRWpZeDhsZFVmNkpNcEMwcHo3VEorUExQMHJkR1FR?=
 =?utf-8?B?UHRlSjdYWSt1ZHpDWndGU3ljcWVmU2x5bGVUQ0cySWJvVGJjNTl1TXZvS2lr?=
 =?utf-8?B?ZmUvNDI4QWY4OFpERGhiNmxyZlJKQUN5SWRQNTRQb0J0OWtVUzhiSGVxR0ND?=
 =?utf-8?B?ZFZOWDV2S2JaNDdVOHAyeWN4WVQwenNENW5pR210U3A3M0NuaDFjVzd6YWdm?=
 =?utf-8?B?UXB4VVRpQU12RXpSR24vbG1VQzFaL3F0UUg5UGd0NnR5MjdxclB6Q0p2bTdU?=
 =?utf-8?B?eFpjaTRQRU0wVlB0dWdqRWliNUJ6VXNsdWNjZTBETkdvYTIrd3phcFBIdGVz?=
 =?utf-8?B?V1JwczEzbFA2N1BnT0VyRTBLdVVtQ2lQYnhwaGtLdWJIbWRVSHIzTDN0bDN6?=
 =?utf-8?B?OXhnNU9lc2xHWWtNRXhjdjFzbWpTSWV5VDN1Tkc1WW12WUpVMlNxYUpHMzhw?=
 =?utf-8?B?MGlmTmFQdHVsS0R2YysrYU92cElvYnoyWlJrQ2l0dnZjQlM5VHFDM0IwejQ1?=
 =?utf-8?B?ejRzT1Q1cGY1Vkkxd0hleDFxQ1pCMnQ3V3BTM3BJOC9INldaSzkrR3d0WGZS?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b79b14c-9246-42d3-17a1-08dbcb697a1c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:23:28.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3t1pzhI/PKaggV3x/1BDKRiGF7rSPWBhKfTzZwyzH/dFgmD4vEIgLGrNTbps0elIr//nY0evNfLJYGs9BzWoycf2jl6WM7oTTpUbYnuxX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Downstream patch will add devcom component which will be locked in
> many places. This can lead to a false positive "possible circular
> locking dependency" warning by lockdep, on flows which lock more than
> one mlx5 devcom component, such as probing ETH aux device.
> Hence, add a lock_class_key per mlx5 device.
> 

Right, because the default init_rwsem creates a static key that would
then be re-used for each time. Makes sense.

I wondered if there was an init function that also handles registering
and initializing the key too, but doesn't appear to be something that
already exists, and plenty of examples doing it this way.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> index 00e67910e3ee..89ac3209277e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> @@ -31,6 +31,7 @@ struct mlx5_devcom_comp {
>  	struct kref ref;
>  	bool ready;
>  	struct rw_semaphore sem;
> +	struct lock_class_key lock_key;
>  };
>  
>  struct mlx5_devcom_comp_dev {
> @@ -119,6 +120,8 @@ mlx5_devcom_comp_alloc(u64 id, u64 key, mlx5_devcom_event_handler_t handler)
>  	comp->key = key;
>  	comp->handler = handler;
>  	init_rwsem(&comp->sem);
> +	lockdep_register_key(&comp->lock_key);
> +	lockdep_set_class(&comp->sem, &comp->lock_key);
>  	kref_init(&comp->ref);
>  	INIT_LIST_HEAD(&comp->comp_dev_list_head);
>  
> @@ -133,6 +136,7 @@ mlx5_devcom_comp_release(struct kref *ref)
>  	mutex_lock(&comp_list_lock);
>  	list_del(&comp->comp_list);
>  	mutex_unlock(&comp_list_lock);
> +	lockdep_unregister_key(&comp->lock_key);
>  	kfree(comp);
>  }
>  

