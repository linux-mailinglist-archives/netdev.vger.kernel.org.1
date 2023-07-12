Return-Path: <netdev+bounces-17298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5AE7511AD
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEAD1C2104E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBCD24192;
	Wed, 12 Jul 2023 20:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772C24176
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 20:10:54 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63140E8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689192653; x=1720728653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=14xdAdlWzWd+GtjnzIAW4x/ELrbPWxCLBWSG7hPUWh4=;
  b=bDxd4h+xMbz5j3k02kwZHi7wU0UkBI4D+HN5nkTn2D7w1vo9S55s/G3y
   eGkw8LOfSIBTaVkJNpxXxMvkL4q2b4b/0c/r+q46uSgRNGlhsXL4MmwrL
   UmpKl4FJt2fOXHFSbNfbxAlL/6Bk/LkbFZ12K06TtK/SnKLh+KUQznc2U
   CBiuDisUm2Ih7HJbOeOPSs1APxU9s6XqzAcQMaiYqyEobecJ4sZDv6kGZ
   65Ziwr383nATc0n+oL8/J0wfFWG9TqiI8mLl9fm4we234kIZgVhii4/pG
   4PqfzrR5tgJ90hgFPMgSsrW1l9SV06V6dsH09xHaPBtYGpthmHIjQxbWE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="395793561"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="395793561"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 13:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="756902292"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="756902292"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2023 13:10:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 13:10:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 13:10:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 13:10:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 13:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvhApMaix37W1Pc1CuqO+sUKjPRxm0N0t2L6BPD1vqE/9qOv1oz77sE17w/BnpZs4OP3b+BJMW/7eozPr3s2w0WKaoPQzmek6QFSGqlmxzA4oxwmIMN38d3XCH8/I7M9b6K8yfgfgKL6xiWmeGPsAI0vSQaxSbRLDiGmtM6zNG0O3nM4amABG+x0ghgq+38ip3Spmf4UnCLN/d4NIQu7/B5xMKK+/Hn1DO3R12VgAfTN4wvYQPHA6UiaLQg8qGLkMG6BBr4sBe72U67aA+W/vlqe/K9ZpcJiqDSANM6JKh+ghBAO5bi8x2nHnwHJRCZk7mk+vcpZmIpl75HLi/lyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pwo0zndp+YmE1THIx0CLhBI6Imm7AP63XTxXukGT5+E=;
 b=KQrdyLTVsrN/NrWEJcEZumdVdq3DtAg02RbkANgAtfuR2nnj6925lQOIecor78szYu9qTfiToh1G8Krm73/hehNA38Lyqnd1NSmY4XTKFGW60mO174oWtWQ6FxAesrnuPopD1Osin/cI54LjCVOwx+tfq3sOl9VyBrkqrua6N4f0rD1xlZtEbP9/fvwhnKbTyoxE+hrVaZej4qpolXehljjorgcNbddeHlVEp+L9OTrn33iQOBo5Om3idR2tRcc1prMx+g2lD/a4t2s/TseSmZzFA5BtwEBFjbHGUb9E/vHXgOjSh/HZD+JhTkvczjEa/x1G7oS04fuwiiI4905QUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Wed, 12 Jul 2023 20:10:49 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011%5]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 20:10:49 +0000
Message-ID: <3ee3105f-a2f9-8da1-b7b1-92ddfc6156f6@intel.com>
Date: Wed, 12 Jul 2023 13:10:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 4/4] netdev-genl: Add support for exposing
 napi info from netdev
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <168564136118.7284.18138054610456895287.stgit@anambiarhost.jf.intel.com>
 <20230602231753.37ec92b9@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230602231753.37ec92b9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM8PR11MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 484ed02c-792e-4b38-2622-08db831415e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIYQb5cnHFqmfCdtdin30oGHoQMTMXOA9gfCxLWxKucM1ixXgfx72E5lPQB3nwtBmtnxTws96HHcAVe1JORmKeVPqjwUkqbz3zN5PLcoDp8IE1Grl5A6fM6fFguUmGaoBcENjke1Tb+G7e3Xbj4oC9gGujO30qQv+sBQgzf7kmtar0bmXW+83CIByl43rzbINEyXD5UNNtWhqWOD/YRD6rf9euxp2/MofoUqIygF68rV9Oj8vFnsq/raidHd2iSaboLZjel/nKcjn0/ATa7hQzy9b4Yrof3CmknNwlkViPKKLZBN38xeaTHkxfjDK5bWE5GeICqyV9I1/07V+lK7VzIEV4Cldu4VOjdSj1LFAFknpPPDAMfTfEy889DnI39Tlry9ptifOt/DgozKF5Pjm+ck70NcbUp40cFFxZ83j7Gkvb7/KrhqejPegtkQLSpesNmK1nwYJgYGYo/7NrmqTIq8hmwX4DWzj1YGtEb/T+r+ObNVS12op7lZSZNOkPUjpf8TpqGbTeeZXbf72Bo/tZFBygBJjHk5P4G8pb3CvZYOka1+kN1ql/MoLzUOrRSR6V1o1TDcJf+lwF74+iQR5eoPgu69BLn22PUyve5ZG3pXXEr5GM6BooSeonYf8W6LI0CU/v8izTqAk3YkAnObxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(26005)(6506007)(186003)(53546011)(6512007)(107886003)(36756003)(316002)(2906002)(38100700002)(41300700001)(82960400001)(4326008)(66476007)(66556008)(66946007)(6916009)(8936002)(86362001)(31696002)(8676002)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3o2a2JvVEtrbDJMZVJWYlcrczcyR3hGM1lRaitqTEd6b0ttN2FKZGt6VkNj?=
 =?utf-8?B?dGNUNEVIbnZGMXlQSmcvaWpMNWxwNlZ3dUR6OERGTTVFcHE5RHhFYi9RUWhD?=
 =?utf-8?B?M2FQMjgwVGZKT2F5djViV1NuREdYK3luYVlOQjllVWdvcmZJbnVlem9VRE0r?=
 =?utf-8?B?LzQ4NElwdEo4bnNWS2ovQWxvdUYyRW1VMTdXWnE1NGhsN2VFVStYVStHQ1JY?=
 =?utf-8?B?bFhiVTA2VjdsQXVja2d6cVR5cTExZGVSTVNxUmtuVnBhQ2NiTkJDT0RheDhp?=
 =?utf-8?B?aFBMMjVrVGF0d3RCNStBaGU0Zmh2Lzk1QkwyUzFwNzZOU1RzaFo5RytZdU8v?=
 =?utf-8?B?U0Nhd3h5a3dzUDB5aXF5Z1JZUHVBMy8wcGZaNEJkRTl1cTVLQ2Q5Nm5HNGJv?=
 =?utf-8?B?NkNkVTlIdUtxMkVHdDlscFdYSEpQRUdhQi9CWlExZUZMVHhGL3RDeHdZb1ox?=
 =?utf-8?B?WkIydmtZVlZ5Z3lFbjR6SGNFeDZrR1NpdEZpemdCZlJvQkhjZldlWmZWMjBP?=
 =?utf-8?B?aGtGNFNmTndiUVFwajJQTzZZMkw0aXhvZmRZKzBvWmV1ZG5iNi9zdzVmTnk5?=
 =?utf-8?B?d05DYmJrc3lPSVBOUjI5MVY1Y3k3aVF6eHVwdi9mMkdFLy91UlcvQTQ1Q3hk?=
 =?utf-8?B?R05QeE9Idzd0ejRxUUZmUFNlL3NpSHdSam5ER0FseXU1U3k1NVJ0OS9aM2N4?=
 =?utf-8?B?VEtsbEgxYXNxQTFKancyYVBPcjBJMmQ4a3V0WE42YjRRWjJEMnhXMk9xR3NS?=
 =?utf-8?B?TlNyRm93WXI0VmU4TE5tYkFVR1lKZlFmR2RsTjB1ajRQQjFDQkFwK21YeFBa?=
 =?utf-8?B?eE1BZFF1ckNpVzhuY0t3cDNnZ1Q2bEpyTmNpVEw5VXl4M3VYb3B1Y01PSmlt?=
 =?utf-8?B?WUtyUERaZW5xVTN4ZXVhSGpoR2VoaEpaVHI1MWJYc1RDOW1lVEhidDg3MUNH?=
 =?utf-8?B?T25BMzkxd0ZPYTdwR1B0cnN5eVl1dkY2U0RZVlJidDlxS2pxVDNlSmhYMmZO?=
 =?utf-8?B?UnJwWWYrOXdpQU5NRUs1Y0VLbnFyL3V3bUVxT2JmclFqY1M2emU4WGxkUm92?=
 =?utf-8?B?TEZVakRJdVZJaFlZSmlXazRIY2VLdVkvMnRPMDIzYjg4UTcyTlRSRWdZZkww?=
 =?utf-8?B?Qy9DK3VWYWp3N2Q0dTU2V0o5Q3AyVUY1VE13a0pNT1VZM0w4TXo1M0Z1dDBG?=
 =?utf-8?B?d0llRlhhM3JmUFR6OUJ0YU9TZjF3V3FGb3pEZTRSanhISnhrQkYwVFNjN3I1?=
 =?utf-8?B?aXlWazQ0dDNYSVZmSzR5MnZyRlQ3Tm93TWl0QjVSRGdsTGhMU29hWks1ZDhF?=
 =?utf-8?B?QXRXWHZ2cmhGMisyb1hFSysrY1ZWeklUTElBODRoM0d4RjBKOC9TYXVpUkJT?=
 =?utf-8?B?WEJ4dTRVR3RFdVJyQTNoUjE4L2NqZldwazIxbjVOWkRJZDhDK1R2Tlo5U0pr?=
 =?utf-8?B?SEtBR3BvT2YwaHJCTDB3WW8ya3ZxTCtBRGpmTUl3VVdpaEp5TjhRclFqTmdo?=
 =?utf-8?B?VFpsS0FSRHFTQy9zZ0xWOVcrckJCQWpmV1BiaEdvNUVlZmwwV0lsUERVVnpG?=
 =?utf-8?B?aVR1djIzUlZaTTdGOTFaZDd4dDY0dWhOUWlvaUNCWGFKbTBERElBSzFtUVhw?=
 =?utf-8?B?V0RFakxsTTJWcnlGbEY2UmJLdUovU2xZbFloQk96MXVpWUs4bHBHRjhQeVFW?=
 =?utf-8?B?UzJ4Rk50Q1NCaXdqajRlL3ZLUTVWblZPM3FERnJNRTZkcmhBb0hVbzBLN1BN?=
 =?utf-8?B?ZXFHcmdvcnNYSzd4VDUyUStBR1BWRXIvWTZ0WjdSWE50WVNzd1VxVVJZRExU?=
 =?utf-8?B?b3FBb2xFM2dyZDBQMCtyMVpicU1mWEJTYWE1NTlYaFBMa214VnI5cDlpeEU2?=
 =?utf-8?B?dFNMRzJxRlVjQ0FUbzdaQTlWOW1oU042TmFWNmY4VmRLZVFxcDVXbmg0Wmhj?=
 =?utf-8?B?M29uR1RFVmhJdE5xQmxQSXZ0NWlPdmo5eFdqQXBLazhwTVZFZmFzbUVUbi9x?=
 =?utf-8?B?T3RSQzYzY2ZSSFUwNWR5YjUrL1JjYWQrZkRzZmxhTEhPbHk4SDQvalNLVElm?=
 =?utf-8?B?VTZEZy9JMkpkeVNUYVVuS2UxTVpBTDBrN3pTQi8zcGtaU0NXNm9WMDNGSVRO?=
 =?utf-8?B?VE5Hd0ZzcEtVV3VzMnNRR2dXSGRaQkJac05mb1VyakI1R1VUeDJzMC9CMWpP?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 484ed02c-792e-4b38-2622-08db831415e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 20:10:49.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4HRzJh3nypC67CftjbvCYIuml77wR1QGznVst456n1aoGqy5+sZrPoVsSX2otUZbuaAdSrDy/cF44jOBawOH0wSJkJntD7FgkzSGg3TGLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/2023 11:17 PM, Jakub Kicinski wrote:
> On Thu, 01 Jun 2023 10:42:41 -0700 Amritha Nambiar wrote:
>> Add support in ynl/netdev.yaml for napi related information. The
>> netdev structure tracks all the napi instances and napi fields.
>> The napi instances and associated queue[s] can be retrieved this way.
>>
>> Refactored netdev-genl to support exposing napi<->queue[s] mapping
>> that is retained in a netdev.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> ---
>>   Documentation/netlink/specs/netdev.yaml |   39 +++++
>>   include/uapi/linux/netdev.h             |    4 +
>>   net/core/netdev-genl.c                  |  239 ++++++++++++++++++++++++++-----
>>   tools/include/uapi/linux/netdev.h       |    4 +
>>   4 files changed, 247 insertions(+), 39 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
>> index b99e7ffef7a1..8d0edb529563 100644
>> --- a/Documentation/netlink/specs/netdev.yaml
>> +++ b/Documentation/netlink/specs/netdev.yaml
>> @@ -62,6 +62,44 @@ attribute-sets:
>>           type: u64
>>           enum: xdp-act
>>           enum-as-flags: true
>> +      -
>> +        name: napi-info
>> +        doc: napi information such as napi-id, napi queues etc.
>> +        type: nest
>> +        multi-attr: true
> 
> Let's make a new attr space for the napi info command.
> We don't reuse much of the attributes, and as the commands
> grow stuffing all attrs into one space makes finding stuff
> harder.
> 

Agree. I should not have overloaded the 'dev' command to begin with.

>> +        nested-attributes: dev-napi-info
> 
> And what's inside this nest should also be a separate attr space.
> 

So, I think we could have two new commands for napi data. Would this be 
acceptable, a 'napi-queue-get' command for napi-queue specific 
information (set of TX and RX queues, IRQ number etc.), and another 
'napi-info-get' for other information,  such as PID for the napi thread, 
CPU etc.

Example:
  $ ./cli.py --spec netdev.yaml  --do napi-queue-get --json='{"ifindex": 
12}'

[{'napi-info': [{'napi-id': 600, 'rx-queues': [7], 'tx-queues': [7], 
'irq': 298},
                 {'napi-id': 599, 'rx-queues': [6], 'tx-queues': [6], 
'irq': 297},
                 {'napi-id': 598, 'rx-queues': [5], 'tx-queues': [5], 
'irq': 296},
                 {'napi-id': 597, 'rx-queues': [4], 'tx-queues': [4], 
'irq': 295},
                 {'napi-id': 596, 'rx-queues': [3], 'tx-queues': [3], 
'irq': 294},
                 {'napi-id': 595, 'rx-queues': [2], 'tx-queues': [2], 
'irq': 293},
                 {'napi-id': 594, 'rx-queues': [1], 'tx-queues': [1], 
'irq': 292},
                 {'napi-id': 593, 'rx-queues': [0], 'tx-queues': [0], 
'irq': 291}]}]
				

$ ./cli.py --spec netdev.yaml  --do napi-info-get --json='{"ifindex": 12}'

[{'napi-info': [{'napi-id': 600, 'pid': 68114},
                 {'napi-id': 599, 'pid': 68113},
                 {'napi-id': 598, 'pid': 68112},
                 {'napi-id': 597, 'pid': 68111},
                 {'napi-id': 596, 'pid': 68110},
                 {'napi-id': 595, 'pid': 68109},
                 {'napi-id': 594, 'pid': 68108},
                 {'napi-id': 593, 'pid': 68107}]}]
> 
>> +      -
>> +        name: napi-id
>> +        doc: napi id
>> +        type: u32
>> +      -
>> +        name: rx-queues
>> +        doc: list of rx queues associated with a napi
>> +        type: u16
> 
> Make it u32, at the uAPI level we're tried to the width of fields, and
> u16 ends up being the same size as u32 "on the wire" due to padding.
> 

Makes sense. Will fix.

>> +        multi-attr: true
>> +      -
>> +        name: tx-queues
>> +        doc: list of tx queues associated with a napi
>> +        type: u16
>> +        multi-attr: true
> 
> 
>> +  -
>> +    name: dev-napi-info
>> +    subset-of: dev
> 
> Yeah, this shouldn't be a subset just a full-on separate attr space.
> The handshake family may be a good example to look at, it's the biggest
> so far written with the new rules in mind.
> 

Okay.

>> +    attributes:
>> +      -
>> +        name: napi-id
>> +        doc: napi id
>> +        type: u32
>> +      -
>> +        name: rx-queues
>> +        doc: list rx of queues associated with a napi
>> +        type: u16
>> +        multi-attr: true
>> +      -
>> +        name: tx-queues
>> +        doc: list tx of queues associated with a napi
>> +        type: u16
>> +        multi-attr: true
>>   
>>   operations:
>>     list:
>> @@ -77,6 +115,7 @@ operations:
>>             attributes:
>>               - ifindex
>>               - xdp-features
>> +            - napi-info
> 
> Aaah, separate command, please. Let's not stuff all the information
> into a single command like we did for rtnl.
> 

Okay.

>>         dump:
>>           reply: *dev-all
>>       -

