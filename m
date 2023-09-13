Return-Path: <netdev+bounces-33660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F3E79F0F2
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE251C20A44
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752D4200A3;
	Wed, 13 Sep 2023 18:15:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3F1A72C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 18:15:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49DC19BF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694628942; x=1726164942;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z2O0VjRa0umXngimPCLsyM2R36DXjt76ArVCmGkrwYo=;
  b=XRA+DY2752Vuj/HW8Jg29xGLQpTVUGeRrq2j/tqf1J2Zplpj7CS6NMIL
   FMeoE4e+ftytFlWn+rPc83Y6lWyITZc4P3OYeJZO9KB5UaacZ0cT5WdWA
   C9OiCNS9PJELdPO2AN1FOmqJKLF6SuWlzcoXHuU3iRVbfvvqkvtTOHr06
   gADNtvNHOPdQqNPUGgWjpabz2iPgwtM3PlR0dIoOVr3cEEe6CBAHYS+o0
   AVrHITu2ON8NNawA6wznyMCI6J6fNId7YMiBUmwqUk9K6xLQXNYKWFwJ7
   qtawm2PUSk77yeEphIZvnMX0ykBL6NfTr8WvBGjHM79JhX7SluzC5RBZ2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378663311"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378663311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747419453"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="747419453"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 11:15:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 11:15:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 11:15:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 11:15:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 11:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WykpI+srmEoQM6oQlnuM3FHuqfiqCIsCVK0gGmxOg/bFuBmULXRyOxwmYnHo8iTUDwYVR8EPan2Ml9D6/j50ne1T63N8TTI5TnimPUxbY/f8ryEHmRhItIaoomQ9ym+soXZxIQnUeof5zi6D37pIiRwyvH4qt+nFgjHTRGaqzIqTk0vt6Prj8ZC+Z6Lu3yvwoWDYRuCo34HtEVWfk0mQCzgQFhAYp89xgbXzomdzRneEWgtOd7x0UoA9ytCOZ6tMFDysM2QgvLz29VpuiZMixZZUdqkyn1KWEZpDKdo34BkQbQR2e8xdkICLBVR/w7lKJ+qGNnTrooY9drcGJhQeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH8lmlG1fvX1KvQsnR85MAQEFs24MuUWTt+I7kBSDnw=;
 b=XvS0zxQ6L4NRaXPLDHkF1ZPOJNEGxg4gJ0zfUgc8kU1XiTKSHScvD7WzL81pthT2MZdvzddjOWQmzkgnruZ7mjrZ9koHn1ps8w5+9Ceqe751VRBSyCVJCD3vlg6VYsLNPMuN7PlRJfhSXIIdfAh2OyJ1Uadv6Tanf3pMRR5o79IQzTrmZRT7jWaxDut5MP3j5J42UoSzqAxlP3W937lvG89CxBv6FT3ituF0NK9nju9UOePHcLG+UTdkTJAEh3dvacER2bXX1C8a48nzi9rI45JtD47i0hG2SRAkF3j+4UKJ15/pRHLESpryBCVtvObQhrdLOKGh67WJ3R1oLcI7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by MW3PR11MB4699.namprd11.prod.outlook.com (2603:10b6:303:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 18:15:03 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::91f3:3879:b47d:a1c3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::91f3:3879:b47d:a1c3%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 18:15:02 +0000
Message-ID: <13662c6f-7a99-ecde-abc1-2e34f1e51f1e@intel.com>
Date: Wed, 13 Sep 2023 11:14:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver
 Updates 2023-09-11 (ice)
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
CC: <jacob.e.keller@intel.com>, <richardcochran@gmail.com>
References: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|MW3PR11MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: a52202db-6961-48cb-62a9-08dbb4855943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HKPJ22tLNw+XhvtTpoXeLJoY6y64JY/AcixV8DDHQ7ePYtmISC5E9ObRkPjmDV0hKJkZidFUHKfKbKnPsWeen7SrKlp4bq1bWHsPzpm0xLUACb1xGIdfckB05L6Iw3drNE/90Ppd5ji6FpPN37+xcSXLPxKY62V/8dB5/8mzUdDdXdDKJxhCoZWyfIdEgb0NE9OSqcCuBhDEXrciOHJ5OHddE8NwBMedql41jtRlMM2rvGRMfQrR+QRpzSorTsQzVjG8Itx9DtMRMhRIefZjdrSAytrHj6By+gyunmsmAQ5XWfHANr0+OxmAf1TgtESWph/z6SD6lccd2aQ1kaTB7McItgPNSbkkEo16zPgQBF5nGq/nDp0w49XIvNpyyAJeqqjhq7ciFQE87Q1YSF8AEWdtU8YAbn6STJ36Crj7Hee93hInpX3jrGiCkfQaCz4No8JpV0sJGJfZeqEnso8PsjDa2UdFyNRxzZwxQVyaaUst6UC4yQtSZKioPsKmQeR+Ltuj8Lu45GQY30G7AczLSJdZiegVRROWpN2hVJ5F3zD/MHXcxBv2vRdZYZaEbV6qRyCHNUyLZmOO2F5qgXvHpA9CshTyr4bv6nDz+3YVLqoHH0ZGQXx1o9FLdPZ4O4HOodQxcuIQgtgnpkTlfWdCeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(186009)(1800799009)(451199024)(53546011)(6666004)(6506007)(6486002)(6512007)(83380400001)(966005)(478600001)(26005)(2616005)(15650500001)(2906002)(66556008)(66946007)(66476007)(316002)(4326008)(5660300002)(8936002)(8676002)(41300700001)(31696002)(86362001)(36756003)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzMxZG91bnBrZFdJOUFEL2RHaW1yVlhoc2tqNHRRaFluUnFaOGxkMkN3ZkI5?=
 =?utf-8?B?bW80Z2xFL3pEdXphQ0tWbkUrWjdxbk90QnRsK09hd0hJMWNmV3lpaUV3MHNk?=
 =?utf-8?B?ZFB2dVlzOXg3WU1NNWhwSlNCMWtmbkIraks3dVhOY2xWOW9UTGJtWU9FcDNq?=
 =?utf-8?B?OWJhWEFhamVIeVE4WjJyc0JFaDg3dWcvSUNNcUpYMEFLOUFQSmJFK3RKcDNF?=
 =?utf-8?B?aWZNVjkxZWIwYmlyeUVNNDZKKzk0V0ZmYWxETGM0ZStxbnRUUGUvRjhOQWpu?=
 =?utf-8?B?WTV5STd6YVFKb2ZDS05PZnp3WXJZWU9tRzBNYzl1UGFhQ21xaGp6MG1mWWFu?=
 =?utf-8?B?RVFDYkxwU1N6cGZSbHk4M0kwMGYyUVRlNDRmc1lDb1hBSncxb0FDSE9mOG5q?=
 =?utf-8?B?TFRDSHNCZS9pSWloWlVvVzZZN20rSWZCN05UWXQ5VGJOT1kxZlIyWjgzTDVw?=
 =?utf-8?B?VEx0OUVDOGlFWDJQWUd2MC8xellsd1cxOHNobm9YejNib3p4cHJ5eC8zbGtz?=
 =?utf-8?B?bndqK21tK1Q2V2xhZE9UZlJiN0dwVlhTUkdYL0RxNk9tNE5ydWp0MHpOQ0NM?=
 =?utf-8?B?cjJ0U3pxQ2hOWmZPZ0tROFlXQXpXY0dzVXg3R0puY0pybE9jTHhDTGlzRXBl?=
 =?utf-8?B?WVJsdVpETUZFTzArTWZWL3BRVzVtVVpCK0d2TkF5VExISkphQS9sajdrQUZV?=
 =?utf-8?B?eWV6L3FscisrZ1ovV254c0x0MU5FR0srbDF0L2dIVFd0Q0h0RWRkMmdVRUNz?=
 =?utf-8?B?YTZRRHgwVXB2eXJiajRubVFVblhJSWpFbnJZeTVrZlNGcGRmekhOYytDOGZV?=
 =?utf-8?B?Qk9lZmVxTy9nQUxyMHpkZmsvekhzdlg5dndaSEJUczJHclFmNG9HdkxzT25I?=
 =?utf-8?B?Z2piOFRRZThsLzZQMU1ZYmVjb3c5R2U5MFowK1EyczE5VU55UDZKV1FCZUlM?=
 =?utf-8?B?Y3BJQ01UWUt1QWUvdFdmd2ZRcEJvNktBWDZyL1NoRnVWcUg4VEJYaE1zWENR?=
 =?utf-8?B?ZUYvcDJsblVBNmg3bVRLeXB0REE5bXNTQUlEYnRIQjUrbnc0eWJsaHplVVpy?=
 =?utf-8?B?UVh1emJ0VE9qdnpqODVVWENwRkhwcTFqR2xET1hhdVpBMG9KSU4yUDRWS0ZT?=
 =?utf-8?B?MHhoYnFSM1ppVkovazFrVjFPejJWVVh5SVhvL3dqcC90SW9KQmVFWHlCSGdp?=
 =?utf-8?B?WWNjOGJzb2FiOUFTSko4aUpPL0tZNzJMNlEzVkxRZHVaN21QekhzVFFhVWVU?=
 =?utf-8?B?dUJkUG1iRHpVZ1h0VXd2NzY3Rm1LMXFQWUd2NnRpeFJrSHV4WkJiVjFDSEov?=
 =?utf-8?B?RDg2bHFNdGg1RUwyeVRlWFZKOHA4MmxDMnFiZ1Vvdlk1SmZBMDREaWt6SjRY?=
 =?utf-8?B?K2dvTmVUQVFnQWNkb1hzQjZmOGh2T3k1MTQvd3o1aCs0RmZtREtLMkRXaWk1?=
 =?utf-8?B?U3RuQ2Q0TmFsRFlyd0h0ck5wQ2c0b2Y3cElzckN2SFJBWWp4enRhTVJSQWdS?=
 =?utf-8?B?Rkx1aTgxdDVIZUNIOTZtS2lCRlRUSWRUZmJkNDh2amljZGN1QmxIOXBubFdv?=
 =?utf-8?B?RDVyNlpRVFpTRGFtV3dFay90VkM4bEg5bmJ3eHVtN0lHcFdEQ0JGc0wxdDJM?=
 =?utf-8?B?aGRXVUVHNzRGSVpFbGc4U29SVEtpZ2NWb1laNWlBWmlrZy9qTzgyOGRTYWFx?=
 =?utf-8?B?dWJ4cnRLT1ZnWklWUTBITHFvNWlKNUN3RmROZVJGRmVLRmtmemdrL3V6QlQ5?=
 =?utf-8?B?cUlFaGQwN3NCaHRtY01tc2lqWXhQNU5lYVVWRzVlN2RVRkRDaG1SWjVsM29U?=
 =?utf-8?B?WUR3U1hQcEEvZjF2eHk0UGRqZGJEM1NiTTlwMnhPK1dZTXZ0VzJmWHFjdi9J?=
 =?utf-8?B?c0ZVbldBNElUUFdBTmhCYXBEVUVFVTdFcnpONEZwbTkwMjdPSWUwSjZMd2d0?=
 =?utf-8?B?MStOM3hSSjY3N20rYnp3TGdlTmlOa3R2OThIL01obGtZQWUzMkFJMHg0bzhH?=
 =?utf-8?B?ZjEzWDdHSW1SeUV4b0hVQm9sTFd1N0FESGJXMzFoaDA4OC9FOWNCZDROUGxh?=
 =?utf-8?B?MUlubEQySDVDUERzaWU1cE1aYUVmemdqaVJPcEJEUm5NK1hpV25tZ1p0Qmw0?=
 =?utf-8?B?c3A3c1l6cWpTR1ZkV2lzOG5VaUpnSFlFUlRlQVd5d2lZSkZLL3NtaEQveUdH?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a52202db-6961-48cb-62a9-08dbb4855943
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 18:15:02.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXYTN9WuOwdfGQmzC375CQTZJSaRWttXxAVFazuTrWZIfiVX/k1npQg/F0gN9d9NIjin19uYYavteMUKmzVsLEnE+sRnsuhne0EeElHqj50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4699
X-OriginatorOrg: intel.com

On 9/11/2023 11:03 AM, Tony Nguyen wrote:
> This series contains updates to ice driver only.
> 
> Sergey prepends ICE_ to PTP timer commands to clearly convey namespace
> of commands.
> 
> Karol adds retrying to acquire hardware semaphore for cross-timestamping
> and avoids writing to timestamp registers on E822 devices. He also
> renames some defines to be more clear and align with the data sheet.
> Additionally, a range check is moved in order to reduce duplicated code.
> 
> Jake adds cross-timestamping support for E823 devices as well as adds
> checks against netlist to aid in determining support for SMA and GNSS.
> He also corrects improper pin assignment for certain E810-T devices and
> refactors/cleanups PTP related code such as adding PHY model to ease checks
> for different needed implementations, removing unneeded EXTTS flag, and
> adding macro to check for source timer owner.
> 
> The following are changes since commit 73be7fb14e83d24383f840a22f24d3ed222ca319:
>    Merge tag 'net-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

I think this may have been mismarked. I see this as "Accepted" on 
Patchwork [1], but didn't see the bot notification and not seeing the 
patches on net-next.

Thanks,
Tony

[1] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=782984&state=*

> Jacob Keller (8):
>    ice: Support cross-timestamping for E823 devices
>    ice: introduce hw->phy_model for handling PTP PHY differences
>    ice: remove ICE_F_PTP_EXTTS feature flag
>    ice: fix pin assignment for E810-T without SMA control
>    ice: introduce ice_pf_src_tmr_owned
>    ice: don't enable PTP related capabilities on non-owner PFs
>    ice: check the netlist before enabling ICE_F_SMA_CTRL
>    ice: check netlist before enabling ICE_F_GNSS
> 
> Karol Kolacinski (4):
>    ice: retry acquiring hardware semaphore during cross-timestamp request
>    ice: PTP: Clean up timestamp registers correctly
>    ice: PTP: Rename macros used for PHY/QUAD port definitions
>    ice: PTP: move quad value check inside ice_fill_phy_msg_e822
> 
> Sergey Temerkhanov (1):
>    ice: prefix clock timer command enumeration values with ICE_PTP
> 
>   drivers/net/ethernet/intel/ice/ice.h          |   3 +-
>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   8 +-
>   drivers/net/ethernet/intel/ice/ice_common.c   |  77 +++++
>   drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
>   drivers/net/ethernet/intel/ice/ice_gnss.c     |   3 +
>   drivers/net/ethernet/intel/ice/ice_lib.c      |  11 +-
>   drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
>   drivers/net/ethernet/intel/ice/ice_ptp.c      | 101 ++++--
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 294 ++++++++++++------
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  13 +-
>   drivers/net/ethernet/intel/ice/ice_type.h     |  22 +-
>   11 files changed, 380 insertions(+), 156 deletions(-)
> 

