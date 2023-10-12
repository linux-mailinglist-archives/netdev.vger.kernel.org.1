Return-Path: <netdev+bounces-40496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DC7C7897
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA9D1C20DFE
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24FF3E48B;
	Thu, 12 Oct 2023 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkBKvGlZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F13AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:26:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E6FB7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697145997; x=1728681997;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DsQjJvLWDrbZUPAXme0G+lPNkWp6ALNfSbyUbdSXVlQ=;
  b=OkBKvGlZdNheIEhDjHsmxsYdHB6VS9f76gkjQ8lEcZxZ2TFrLsiuJVQ5
   j1n8IIpJO6XbG4x4KtwpjN4N7xeJEdAnZ4zRvQn1SFUIo9bmazjN/8uHc
   lD8Ly19KzDAv4mFXIdH3gkFla61WuKtAoTzWdPznAh0ok6OTivAVpUU0p
   pfFH24ZmwkxWKvCsiw1h7EWoD1EAv2uiqtt+SVZzGfPTBfq6O302Z/xDu
   I57hq12GG7L3j/B5SnHCB/LTeTaZJe49JO8L7sldt1G7DhK/laW0Zsuu7
   nziCfUH2HEP5UjbPUA3tYdycyy58x7jiBHtCOgUh48fgA9Wooi4X0fefC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449236417"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="449236417"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="845144505"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="845144505"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:26:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:26:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:26:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:26:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBDzW0i/bLBerM8kZCt6fsoqFVx4ZAGfbQD63xshl6EzDkqebqQCWe0OVpwRG454Rb3okue2/QD8mOIzxctUc15Yg2G3+JgUmo8n5smIyYWtEqb7ZrW1J7VXElznPox2bd1RGQ15rYsWEsKIVgcvgxMGSGc+AlF9XowdKvVMPywmfGrl/iB50vFwmN7OfrXOH1MPKd10B2DnXOvriEVFu+YVtDpByBm4n7i+xRttC4bz3iVL8iJQOXKemEli+zmYkegQ2WMSAsmAdlOMBpX+DUVenu2f1kUcEsLU8pCs2JVwLYUZ0J32vHNy9UcFJt2Pa89BHAACDCGZwkHhlqo0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmAcDoms4LJj+vvvHa3G6LZxqj7NQyfPvmY9f9UuQVk=;
 b=IDcqokSNsfSkq2Qw1Kdu3gHZp4ESmky3S77X+fjdIKsmbew2mXmXfw/3gkS68OaJ/FnQ4md4jP0OBcNGXpNopkF0QGTmcBpSKDsJL70eVYhVzurn8N+OCt56DkpP2hl+gtsMdr7vVnj4HleYLI7I/1O3cSmX/mpQPYyeJb6Na/g3D7Fs5DuuX1xSKNbA2Un/Um0Q1g8RJOXOlQCH8Ws+CA8a8uj2MpR0kwbcItYaM39kALaoSuAOWU6201bkAKHKsRAnyn5gtgmDiZKRBT/Owv2+HfriRcdJNei/e0BLf8Z2g1hKiQQ/DKbG2pHnUcoQfu7ieQlN+//pNh+qNRZEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:26:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:26:26 +0000
Message-ID: <ff42e84c-0859-4e7f-b8e7-1b4e1f7d1c8f@intel.com>
Date: Thu, 12 Oct 2023 14:26:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 04/15] net/mlx5: Refactor LAG peer device lookout
 bus logic to mlx5 devcom
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-5-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-5-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:303:2b::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: b98ab723-59df-4df7-f9c7-08dbcb69e412
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrP3iAtcrlUqxUAvcjM/y1O2LTAc4c+bOXXZevLO/uqJXlAXPGR6XCFlWP9kh5xZRf5uSRte1RAwCnrlszOBSjhOuUnhdA++/tm6Ms0Z97KI2hUZ8MCzsGkzbrngx2NRaQpkuqNSOplwUiePfHbIPmSd0LuZjTcer0y+UU6Naz6E4qnH+4S65sVGGPt+lsxOGPm0nICMR45QgcrPKmk9MABerZL/kaolDJs4Dek9znshAT4sAR3XE1JGz9SVU36Ytvfgap7ks5cQHXtTJTSEqhdC6AmQS5EJ15I+lFiCE4m+4EFNVKrRAMq3yc4wguGlqVIrmisB8owvyf2Cllt4wNdjH1ik2TttlQ97Z2fFAKaFNJeibLtqJi1sefhNqWuh6J8PE0hOnJ2tqMMnUq4WtwJz4wlZhutMUa3ftd3p0aKXWDgqsIHOfmleefn+FX93T6zmANPT4fiXj1OH//nOg7rp6nPRGD74bqwAcWh8pliwRGIXEgUl1XNRh0D5T8gLnzPovyF2c+EOzuBXjqxJwkcgU7kK8dxcOMxVO8ALVfKU6ut1dmhFPQDsmISk7PiBgCu/smHEWY8zX6ddojMBsDcFk0EQzloXZOpis6UeaWl6PkY+cPj2DpbdnzOjiPxPvT6RdZE01kdv5bGMF1kdCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(7416002)(53546011)(6506007)(41300700001)(2906002)(66476007)(66556008)(66946007)(4326008)(31686004)(26005)(478600001)(5660300002)(6512007)(6486002)(83380400001)(66899024)(316002)(54906003)(36756003)(38100700002)(110136005)(8676002)(82960400001)(86362001)(31696002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZmRmhqQUhvTnRLUldoaEdBTTk1Rk16VkpYNVB0L1VmYmVxaDNXYUpySStF?=
 =?utf-8?B?emFFYys3M1FWRnRGS3MxR3hRelM4UEhSV0VmSmFBOXIySjZQR3J3YU5YeWlu?=
 =?utf-8?B?dFM3aThKTVRJUExFem51K1MvRXNHRzh0RjNMdGhsMXhkaHhQN2tWUkdESE9W?=
 =?utf-8?B?M2VvbFdZWGJHcTlOSVJ1QnVRQ010Sk1USS9LVXptUWVzSHNWK3oxUVdoU3Z6?=
 =?utf-8?B?aGlvNWsvNVpQNlFISCtSOEUrdTlLekJ3ZUIzMlVURmF2WC9LTHdvbVVPVTdp?=
 =?utf-8?B?QkVwL0J1bTBsbU8xOWxqS1pRVy9NMVdrS2JDTWhETFZCc0xRMVF5dENvSXNu?=
 =?utf-8?B?Ujc4QzRjd2E2OXRIa1locHd0c08xSWNNWThCNXNRTlB4VEtZZUE1U25sVEpG?=
 =?utf-8?B?eUtCL3IxcW52a211M3UvcXN6SGh0VWFZdGlKWmZrRFZ3cWRLZCtGd1RnQlNH?=
 =?utf-8?B?VFE1YmJVc1ZCSWZtYUI4V2REbUlBczJLVjVoOHJsaEwvd2YzUmlnbGJvcHFG?=
 =?utf-8?B?UXNvdDhPSXNXTmhFMGVOWW5mRXBIZHNaL2tEeEJDUGF5aFFvWkh0UEQyODhl?=
 =?utf-8?B?c3ZzeWsrZ0orS1ZhS01jQzdkZjRvOWd0VGxzemh5RUhEa3piU2hGNWFPNHFX?=
 =?utf-8?B?Szg0ZmJmR04xNG91NUo5d2tlT0tBV1Y0d1lwWkN2byszVnFGbDdiTk1lZU1H?=
 =?utf-8?B?YTlib1VoWUp1RllWaklFcWw5L2dBZkNOdWJrOW05VjlVMHVUWUQrV0RxanNp?=
 =?utf-8?B?dHVtcGNCclhXbFlXNmhYMEc5UHl5K0ZEM0ZTZzJZdjBDT2xjVjFsalRtNEY3?=
 =?utf-8?B?YjYwR2V6OGNPdGswTXVHV3o1cDM2RUNTcVcxOXFPMjRtSHJScUdYa1dSZmg0?=
 =?utf-8?B?OElubmYvaDdkRkpHQTdTZFJ1OWpCcFIvMzc0Q1IvaDhoSTBlS3U3d3M4SEFy?=
 =?utf-8?B?QU1DSDNrYjM4QWVtMFdlRmFjZXRFRkc4cVh5OWpYOWtlYUJoK2I2SmlhOXlr?=
 =?utf-8?B?Y01IcEM5UEhHL2YydFV5NklhbWJPcDgrVk5TOTR5WG9sS3RsUGJNKzYxRDQr?=
 =?utf-8?B?Z2ticHlnenMrWC93b3NHczBWVDFERGNkTlg4MTgwUm9yM2dtUHJhWmRnbE15?=
 =?utf-8?B?eUFKME04eFRmeEc0VkpjNGFVTDJ2UEpDWEU2OHNvQWhWbHZZUnNOd3VIOHJn?=
 =?utf-8?B?SjRVU0hRNGFMMGFySEJyang3ZHpJYlNMWVZ6UG5qd2IzWWdjSTIyTXNjOW9a?=
 =?utf-8?B?c3p0RWNyL2xOUDhIbTUwQ3JZdmZQZ0JMTkhaTHJqdUJybnJJRzh0akptWmdp?=
 =?utf-8?B?SGZBdVRQMENiV0gvbTlyNTI1STVoSy9kV1pjN3JxbHVHU2hDcHNKdmZLOG9L?=
 =?utf-8?B?S2pKTUxJNVUxc1VrK1paRVpEcXd3TTdCUmVtTG5CSW83bENTMEhrdDdHOUp1?=
 =?utf-8?B?NnFTYks5ZUdicG13VEp3anBkWjhwckZTdlYySzZQdEI1UnRHeU5teXZXNkNu?=
 =?utf-8?B?UkVkV0tITHpRb01Rb2NyRTJuN0JhWXRvWGdCaWdoQlZTVWpsYXp6QVR1UTc0?=
 =?utf-8?B?WXIyTCtHYzFoeE1WcWRvcjZMSUQ2TnYxYU40bG5ISkd0V1lLR0twcWNnbFlM?=
 =?utf-8?B?d29DeFc2L1BmUUVGbjlHUVY2c1VOYzZnQ2o2MXhhT0hZYjNvRnJPMHhOM2Qw?=
 =?utf-8?B?MXpHQzdZZlhWSEcraEZTd2UxOFBzRmw1WmgwcG1Da2g5WjBsNEhtVkVWQU1Z?=
 =?utf-8?B?RkkrOXY1cGhJRVhqcUgvZVVNSW1adVFZVENGTVVsUjVHZmw0OG1PYitmWGVR?=
 =?utf-8?B?UmhnaWpHbWlTUTZjS3dTdkxGZ0NPaGJFTTg1b2F6S2pKNW45Qkk2MkdnUGgz?=
 =?utf-8?B?Y08rYXQ0ZGlpbzdJakU4VGdPNHhVNDJVZUxST3ZPYXZYejJUWHFUdnk4RUVh?=
 =?utf-8?B?YUwzeURlbWRXVk01YlNTRlR0Ylh1enRTRThoTGNocWdKOFhtRVhzTTdGOU5u?=
 =?utf-8?B?dFJmVDBJaUI2UERiaXpBcEp0VHlBb1VKR1MyZVNPSFRCSUthVlNwL1p6NGZS?=
 =?utf-8?B?b0tZeldKeHpHenRta0dzZ2F2eXFPVkQxMkJldURVK0tsWkpGZjJURDFqSTlz?=
 =?utf-8?B?Z3J5UU53UHpmTWw3UzE2UmFpaGNPeTBaeUtncFlSMW52RHdlYXhXZDlNREo1?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b98ab723-59df-4df7-f9c7-08dbcb69e412
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:26:26.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6PmtRu3FPimjIB/ONeCyvuYjLQo7zL/iTG4qOIn7gbcODVuPMx/TdDSqxBfSe8IYNYOsRkwuvo0oVCzOKhpTuZElzlIqGsgLIdqagGoV68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
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
> LAG peer device lookout bus logic required the usage of global lock,
> mlx5_intf_mutex.
> As part of the effort to remove this global lock, refactor LAG peer
> device lookout to use mlx5 devcom layer.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/dev.c | 68 -------------------
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 12 ++--
>  .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 14 ++++
>  .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  4 ++
>  .../net/ethernet/mellanox/mlx5/core/main.c    | 25 +++++++
>  .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  1 -
>  include/linux/mlx5/driver.h                   |  1 +
>  7 files changed, 52 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> index 1fc03480c2ff..6e3a8c22881f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> @@ -566,74 +566,6 @@ bool mlx5_same_hw_devs(struct mlx5_core_dev *dev, struct mlx5_core_dev *peer_dev
>  	return (fsystem_guid && psystem_guid && fsystem_guid == psystem_guid);
>  }
>  
> -static u32 mlx5_gen_pci_id(const struct mlx5_core_dev *dev)
> -{
> -	return (u32)((pci_domain_nr(dev->pdev->bus) << 16) |
> -		     (dev->pdev->bus->number << 8) |
> -		     PCI_SLOT(dev->pdev->devfn));
> -}
> -
> -static int _next_phys_dev(struct mlx5_core_dev *mdev,
> -			  const struct mlx5_core_dev *curr)
> -{
> -	if (!mlx5_core_is_pf(mdev))
> -		return 0;
> -
> -	if (mdev == curr)
> -		return 0;
> -
> -	if (!mlx5_same_hw_devs(mdev, (struct mlx5_core_dev *)curr) &&
> -	    mlx5_gen_pci_id(mdev) != mlx5_gen_pci_id(curr))
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static void *pci_get_other_drvdata(struct device *this, struct device *other)
> -{
> -	if (this->driver != other->driver)
> -		return NULL;
> -
> -	return pci_get_drvdata(to_pci_dev(other));
> -}
> -
> -static int next_phys_dev_lag(struct device *dev, const void *data)
> -{
> -	struct mlx5_core_dev *mdev, *this = (struct mlx5_core_dev *)data;
> -
> -	mdev = pci_get_other_drvdata(this->device, dev);
> -	if (!mdev)
> -		return 0;
> -
> -	if (!mlx5_lag_is_supported(mdev))
> -		return 0;
> -
> -	return _next_phys_dev(mdev, data);
> -}
> -
> -static struct mlx5_core_dev *mlx5_get_next_dev(struct mlx5_core_dev *dev,
> -					       int (*match)(struct device *dev, const void *data))
> -{
> -	struct device *next;
> -
> -	if (!mlx5_core_is_pf(dev))
> -		return NULL;
> -
> -	next = bus_find_device(&pci_bus_type, NULL, dev, match);
> -	if (!next)
> -		return NULL;
> -
> -	put_device(next);
> -	return pci_get_drvdata(to_pci_dev(next));
> -}
> -
> -/* Must be called with intf_mutex held */
> -struct mlx5_core_dev *mlx5_get_next_phys_dev_lag(struct mlx5_core_dev *dev)
> -{
> -	lockdep_assert_held(&mlx5_intf_mutex);

The old flow had a lockdep_assert_held

> -	return mlx5_get_next_dev(dev, &next_phys_dev_lag);
> -}
> -
>  void mlx5_dev_list_lock(void)
>  {
>  	mutex_lock(&mlx5_intf_mutex);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index af3fac090b82..f0b57f97739f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1212,13 +1212,14 @@ static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
>  	dev->priv.lag = NULL;
>  }
>  
> -/* Must be called with intf_mutex held */
> +/* Must be called with HCA devcom component lock held */
>  static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
>  {
> +	struct mlx5_devcom_comp_dev *pos = NULL;
>  	struct mlx5_lag *ldev = NULL;
>  	struct mlx5_core_dev *tmp_dev;
>  
> -	tmp_dev = mlx5_get_next_phys_dev_lag(dev);
> +	tmp_dev = mlx5_devcom_get_next_peer_data(dev->priv.hca_devcom_comp, &pos);
>  	if (tmp_dev)
>  		ldev = mlx5_lag_dev(tmp_dev);
>  

But you didn't bother to add one here? Does
mlx5_devcom_get_next_peer_data already do that?

Not a big deal either way to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

