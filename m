Return-Path: <netdev+bounces-44072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D055A7D5FD2
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 04:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECC41F224E4
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C61C0F;
	Wed, 25 Oct 2023 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVHIqGCs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A185185F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:19:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139839C
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698200377; x=1729736377;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=95ITumGr7leAEErkL6sI8Cv8exQh6+Rha85uv5YpvAE=;
  b=jVHIqGCsbeeMlenlL45qktEVqmtqASUUwLEwsczkIzlVHB67vOza4px7
   OeRpKGt54N17XtC3M0kgAKQ+3gaYJ9PEMrCDCs42xBab8haNwtDFsBZd/
   zr+6bNE0xztAEi7J0N4z/q2gKNMJHVGZ/kOXbm7u4ChhhNeLPXk1G7sBk
   KfFI9dDdQYRNmg2Ucln6nG8JcNxkluZtzXfB4MsUbzXYsIlX+Q3AxBujY
   LEJBkAFn7su2qgmkucw1w4KUIXPC/z3rOOdkGkijRLGw2QKugffvfQDLB
   riTvtYIes1FqcJcZK2tlN4VzIkESv9pgX7m9GlzlYs8mH9FQtVBWQfCZG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="367434829"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="367434829"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 19:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005843958"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="1005843958"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 19:19:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:19:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:19:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 19:19:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 19:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndZ8uiF+ao+fHfv3pP/vRZvfb2S0+FWIzjrBOIocZeHjV8WmCAyxBkOMMAnK7mcKRYCJZ+1X6DFcSJD40wTD8u2vSod80P0myR5/hoDRsW5x3PZT6K2qJmoGRYX7U1QPDCF9n5DdA4AXtS+IDMO9z99mQy+uzIfxZhLHN2BpPnS5tMU7G08nnnWpntiOtsOv9nKhYvnXJopnUG50PJtCdgjdI4fdLuwRO/t1JaY8cbF9wk2lKMwtBWRfuvH8Y3CLpRgyhx5ajjT/KFR4LlDAH/kYfvAtybCnmPuPf8fBPuHCd71VczgkMaE9L2k42xQq7r6+w6rDAZbdu3xpekmx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJRmh7g9ivXF1bhG5jF9AU+uKeZvOELBf5IhWCaNdBw=;
 b=ipFlx/+0ELc29WRyg41lpVrK/3pUfn1DhadLHkmaO6q4I6F3+pXdUyEmCxoWa8OfLRCRuga2J0fXj6Ug5jYzO6jkKEMLbJtomC0Dym5mgmEXw+PWUH0vy4smfXZFCbswsuYod75keNyUROuV+bP1pV9hPAlaBel6PR3yE9Plqu35WE7mI3dciglWGS102GGR1XR3nprygbV+60atNf/9shLFb0ywLsLvrVoLeVm2Vp37Jr7gfITBHzAx1+fzkbyzxx1TSWTDOaNNqxhovMOT8eAv2dJl9McYxFd2oVUea9op5KXP8qIDtmu54fJu9Hr4F92Kd4EhPkMPZKfajdmFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 25 Oct
 2023 02:19:27 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:19:27 +0000
Message-ID: <d975471a-9eda-4ba6-bd5a-7cd76ca9bb09@intel.com>
Date: Tue, 24 Oct 2023 19:19:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sridhar.samudrala@intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
 <169811120427.59034.37426094846142386.stgit@anambiarhost.jf.intel.com>
 <20231024154548.5baa1dfc@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231024154548.5baa1dfc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|IA1PR11MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 90175b16-17dd-47b3-843a-08dbd500d00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y74lv5lTOZhkkvGsch3nxnsa5vQcQ5Tspj2t7SZGctL45C2pTFSiJdkVQHJfoXayghbiQtUxp1JRzdthxe1BcK6TVi5t4RyDO6p++aihBQ74Y4Rnz4qX4T/RZmtTkgaY9HIc364SazrkGTOBMIRy8qXt+PYgkAvdZmQpKO1GP9HivRmjgURv+NcSArVyK/bIp+onBb2572HsZYtd0Y23QK+ALxwpH8JWMLcY3M619DbQZpglOOiqyWT19MMWzo6qd9B+F+IrRHR41bgWki8LjtEOnEpDqGH9zkTPDPdEHrXOpl1AP6OGOdZfthM6AMHHnFvsM0XfJJ6BuH3s3TkM01NX1ifDu4f1qymed5D+g7jwbtJAWbQdkcGj3b8Z28ORaXT5UUHNwM2hd6b/S2hF6rww+45HDqdL/uqkQfejoKvU746zK/IxfawxFwkMgR60zGsTDrgY9ObgNsRfGQH2s9TW2IQ2rZIz/tHjpCoGs89fx9UlfIMJEiyf9+ZtPx9cPa2QPluOQ2+eVsriJiGPkg8HNe3w5sTq6Bol0/pdBEsI8htHQT5ndVYq4yoXPtcrpZrZ0iVYOPQibZrVCxYYbJi1JpR46lV+WeYO+G1CfcM36Z3CX7fdF29Xm3rAAWaweDFZtL5g2id0rr5E7lqPEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(478600001)(6916009)(107886003)(66946007)(38100700002)(31686004)(316002)(82960400001)(53546011)(66556008)(2616005)(83380400001)(26005)(6506007)(6512007)(4326008)(8676002)(2906002)(86362001)(66476007)(5660300002)(36756003)(31696002)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2l5T0dFSlBGWVZMLzk2OTI5OWE2dDg1R2Izc0N3R0N4TXlBZHBkWmYwZkZG?=
 =?utf-8?B?NnlwSWVnSmp6dUhkeDlKWkRreUcrYkxiSTB6c0VhVmxiemplekw4ZUV1WTJU?=
 =?utf-8?B?Q0lYVVZLTjJvSCtqL29sM0xhdzR3bTVzVElOQ0dTMHJFbFBVVWh1TWtpSWhD?=
 =?utf-8?B?ODZRVWNiS1lzdjRSM0Zyd3pDSUcwTlI0RUdFVlVrK1ZzYXhXOUk1Z1JVVGdM?=
 =?utf-8?B?Q2x4eWpjTzJiYVdaRjYyamJRSDI2bGwybFRsWjRDODFQK2ZjRk92YzdoNnNF?=
 =?utf-8?B?N1h4c0EyL2xlRW93c3BwOU5kYnVDa1ZrNEtNem0zQS82NUFhWlpIaVR0VE9I?=
 =?utf-8?B?NUJ6Lzh2T0ZQaEVSaWhJSEhGakE3dHlDNkY5cGpIaXd3NkdZRFBwc1R2ZlNC?=
 =?utf-8?B?TUNHcW1OdmZXU0NROVhmc1NILzBlY3RUa1k0eldTM1pGZFYwZkN0VURQMHJo?=
 =?utf-8?B?Z3RUbmltaWg0Znoya2tmRDVoekpHeTNhcW1mbXowNGhlbi83alNNODQrZkFm?=
 =?utf-8?B?dnRlKzlCM0QwNlhzRVBLTGJ6WnBiSFFrbE1TOHFOcmMyQ2RTVlNQWEdyajZk?=
 =?utf-8?B?c05zakFsU0NQUWhoZThjN3JPSUdzMXdOZ3dZTVQzNjJJOXRiQ3dCSzVqVDI5?=
 =?utf-8?B?OHVNSGc3SWwwbFJGRXRzUVp6QlJmcWxMS1RRandRenEydS96VW55TVNzYmly?=
 =?utf-8?B?Z2llTkI5ZE4rc2R5OW5TK0RUVHpNekJ4OCtGdDFzMUsvMjBmdEMzUEdFeGI0?=
 =?utf-8?B?b1MvaXpkMmw3Tk9teWtwVEVydFQ3b0ZsUEVVVmVFT0ZuQ0lJdnZYNS9zNW1p?=
 =?utf-8?B?aFd0cVA0TFd5VHJCNkFEQUg2Nm5qVGhKVlNoMm5oRy9TRFpsVGgxTE5mTUpy?=
 =?utf-8?B?d1lNT0tSbW1HdStzODZFQ2FuRk9zMy93dGtHNFdrMVo1amRrYmNUM2R4Vmwx?=
 =?utf-8?B?NDVnbG4rOHRwTnl5bUVvTnJITUg4bjBabVEzVEsxQm4vSEpYRGN0TS9hU2I4?=
 =?utf-8?B?TFdzU1JxK3IvRWZXVHFHYXJ5d0U1N29VVzJJRFZuWUtSSnhKVzE2NHZ3eGN0?=
 =?utf-8?B?T2FRakxqdGFSNGxmdWVjeE1pQmFpV052b2tBQ3JYVFpRUTFNdFM1b1p3b1VO?=
 =?utf-8?B?cXRCZFZsWFpuSGpNeGFvdFZ1ZGNBdUZ6TkxoTWFMZStQZThyL1BHTkphbThr?=
 =?utf-8?B?RHcrZUZheTliZjg1UHlsUXFmbk5IRnFEU2ZoeTlwYkNUbXUycmFsQnFmaWc0?=
 =?utf-8?B?TU9QUlpuTG9oTmJ5NGNOMkVFWWgwcDZhK3dLRTZtRW53Z2RDSURpUjRZWmlj?=
 =?utf-8?B?Z0hSakxQSHNGUDdLRzBhSEpXcjBZNVVpT0JRMWpVQ0xzeGx0Ni8xcGhtb2FV?=
 =?utf-8?B?YVA5aVhxZTZPRmg1RDFZZUY1ZlFhbDRMTnFiUUg5dGxXSVJSK08zb3dQYUM5?=
 =?utf-8?B?MEVJNjhQejljOVhKaUUwYTQycFROWmtoZlR3S1RNeWI4Nnd6NGg2SlpMYTdF?=
 =?utf-8?B?Q2Vja1g4MFVta2xUZEJlZnRVMEFVQ0k5MHpTb01jbTNCRjB2aldPSS9GZmNH?=
 =?utf-8?B?RVlWaXp6MHRodTBoelBRbHMvejlrdTdBczJCMU9tV0M3WkRmWUZ1WmU1ZUND?=
 =?utf-8?B?Wm9zQlJJWkFEMVcrZVM3Qk80K3NjVE5lWVp2R0JPQllXUkgxbUpUOVZqTkQr?=
 =?utf-8?B?QlN0U0Y0YWZ0eTJxRlkrN1libjJXOTNGbXJUMm1XcFNWRXpZNGhpVTFiaWZL?=
 =?utf-8?B?cXhCUkdOUyswenB3b2tIYVhab05yN2FJUHg4ODVaRmZOVzB0RThRZTRvYVo4?=
 =?utf-8?B?NmxHaVNzcVhLNVRiaCtsU01yQWl6eCtsR3E0RWV0bFdWN2x5N2JiQ0ZQVTJr?=
 =?utf-8?B?L0l6TEliajJiRGg0KzVsaGVHMkduOE1zV2FvY3FsVnJ2OHlNOGM5UE95VTlq?=
 =?utf-8?B?ZWw5V205NWlnMEZEMTd0SHZyby80SXY5K2x3bWQ4V1BOcDJrNDFaN21pUTVh?=
 =?utf-8?B?Y01jcnh1OTM1TGpFdENaRkQvT3NlTWNYcTlUSWFtZG8wSUh5MHd5WWhnak9Y?=
 =?utf-8?B?TUJ6azRnaWZnOGZEZ1FNRmF1MFk2c210ZWwva0QrejNZWXkvVmNRTmZ0L3pY?=
 =?utf-8?B?b0JpSmpqMFBsT3JYUnhCelNyRDg1cXpsV2pZVmNFSG5COThZY294SGtoYjZS?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90175b16-17dd-47b3-843a-08dbd500d00a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:19:27.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA+nChQ31fGgA1eDNsAgFnJG8bSrS0DSYk02187jG282nBhpPbj76JUM0lndgBS7BDoYTeFTDonC+7+Bns9RBJKV5ANC8Yq/RjUr4HkqeWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6076
X-OriginatorOrg: intel.com


On 10/24/2023 3:45 PM, Jakub Kicinski wrote:
> Let's beef up the docs here.

Okay, will fix in v7.

> 
> On Mon, 23 Oct 2023 18:33:24 -0700 Amritha Nambiar wrote:
>> +  -
>> +    name: queue
>> +    attributes:
>> +      -
>> +        name: queue-id
>> +        doc: queue index
> 
> Queue index, most queue types are indexed like a C array,
> with indexes starting at 0 and ending at queue count - 1.
> Queue indexes are scoped to an interface and queue type.
> 
>> +        type: u32
>> +      -
>> +        name: ifindex
>> +        doc: netdev ifindex
> 
> ifindex of the netdevice to which the queue belongs.
> 
>> +        type: u32
>> +        checks:
>> +          min: 1
>> +      -
>> +        name: queue-type
>> +        doc: queue type as rx, tx
>> +        type: u32
>> +        enum: queue-type
>> +      -
>> +        name: napi-id
>> +        doc: napi id
> 
> ID of the NAPI instance which services this queue.
> 
>> +        type: u32
>> +
>>   operations:
>>     list:
>>       -
>> @@ -120,6 +147,27 @@ operations:
>>         doc: Notification about device configuration being changed.
>>         notify: dev-get
>>         mcgrp: mgmt
>> +    -
>> +      name: queue-get
>> +      doc: queue information
> 
> Get queue information from the kernel. Only configured queues will
> be reported (as opposed to all available queues).
> 
>> +      attribute-set: queue
> 

