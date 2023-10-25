Return-Path: <netdev+bounces-44071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E697D5FCB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 04:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8FFB210A5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB26C1C0F;
	Wed, 25 Oct 2023 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/vOUcTA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B96185F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:18:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52A10D7
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698200302; x=1729736302;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7QZeTAHqNO/PhuB1rWFtjBpO6mSscGDpxtTTlmqXF/Q=;
  b=f/vOUcTAvaErcT8CyYwe7CMe43Er3JAptGmFLqq56nIlR7Gc1wwlTPFQ
   jKWTyBNAbjeTxcPguYmLUV7nodcHlCqs9HeurU77+I2RFZ99x2GQpKT0c
   852is2KV5tG2c+iq6TQ62FOHNGl1R1LGJw1xOoN+ARd/eDUdeDOZtCnnT
   vqi8Zc/z+3j7Z4XPlxqHvVTYmtTMDCX7RFJ/LCxedvGWGEXPjzj2UVDoe
   zDSAv5bGWhfUw9fRYpwBmW00n3eI9y4VTA5ABzDrhvkMdm9HQD6lLSSWw
   zFqgs08bHmx0naCT98DJfrHjauAD1r8SNDkAEJMvRnDODTF/E/lRXlcYK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="377589128"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="377589128"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 19:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="787986279"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="787986279"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 19:18:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:18:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:18:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 19:18:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 19:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBZToNPtT3ejcselTKichIDY6uX6lKAqGxG22d8DI8h2JUc38oOExzNtXMEgeEtlPoGcjUywDR/+sBUTCopHZIMO6//bvPfeBWxTtbwEAiw9gHCqhH6sf5nv+GynGs+JarfGgpsnhhqXDeH2mLU5X9Oxy0xTxNiD+Iyyz2wVePALzuXhszXwqdzARIwwIE2fSc/lHWCJg2p3nVwwT6nE3t0TgvypGP1t0jMswocChSB/shMM69r+QzPwIeAJ87L9Fg9ZeqkV+kXV2A1CTqmPMtdgfZeZ/J+i8SSRYVOGNs3dkmZHbsHSvmiNeEISePP2B7vL3K1tB/pjJt7k/ZfrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyTcUqWbbEqyNBL3VMQPnZSB55j23+EvaqnukiiqRkw=;
 b=CC0Z6G45hcIyr3sIsXm/p5xs9CHdteO52d5zKbeteqvYUxW3HBLugebAi6FSzDAFh3oHku413gp1NKMb20ReBL/37B8U+QjQphPlieLfA+kK5GE8rz/NJgpsMZYR+G3aIRBnQjI81CIQI16SxflJyaBNHqWQN8BScxjFgcV9Wp9UztgcosYIEuc/XFUtl4moUr4SfxkYTli+FIro9UC18JWkkLUVMLrdhz0AxncbZtSz7fGyLE+3ZVDAIWeET6l1WgkdZ4Hx1nGwJ61DxonH6kYDlLraEh5qON/j83JFg/6s0G0ExE6bKp0xzkDCXVO3EM1dPXitJadnmhgZMnjMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 25 Oct
 2023 02:18:15 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:18:15 +0000
Message-ID: <776c367b-d409-4972-b881-51a1bbbc9898@intel.com>
Date: Tue, 24 Oct 2023 19:18:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 06/10] netdev-genl: Add netlink framework
 functions for napi
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sridhar.samudrala@intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
 <169811123039.59034.9768807608201356902.stgit@anambiarhost.jf.intel.com>
 <20231024153941.4c05da4b@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231024153941.4c05da4b@kernel.org>
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
X-MS-Office365-Filtering-Correlation-Id: 29937846-f09c-4347-fa83-08dbd500a4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nbSwMzfkEQXSI/TGCIqthcUjn6BREuriplb1EvoSkWAUoY35vjJojDOt48tQrdDZ5W+xAyVR7kz05wFmy3CGZaXo19VykGHQK7vX7PIcf7LMRyuvLlC1QUj+ABNWQlGVpnDv1hOIKT+Ocjs3ge7lHm1U0tHE275t6XzvbVbx8svF/jPEjy8t1/HdttjvlZdPm9pBPSlmF2cnHXW0krFl/KlPSUS5q2iN6Lm9aMoULDfxXtwDlDfXREdDj27r58hLnYL/EJk9Vr1Q9e9Uv08vay56fm8wKvB91KaQLZvpbp2o9dcM5Bds/O4QYs9mvSX/AB2z++ZSQSGQ6seqtyHXflBjM/GQZ0lUyUErp3CF+ZKrjyyND4zJGnJtc7JYkCdRw622iRX00HMz00Do/9hSZRDPxCWrc0kF83lWas87UPjGuBJTqZoo1MeYEarwH8RqVWJ7lmWvvckbeB3YB2/y6t3HaWhi/XTvnsY9zOgezp+/3VU8eAetsQMdUZOuyWVqss5+sd1/uFYIl6UjnSjMxrZRyoxhjhWhLMqjyyjg4Dxi7s/GljSvr41214MQtpLreXQsQkOkCQwVHk10CiXUoMDG4MbTH6BNaXOfyLEjTVUYARc3tgIE5xNM/0DX7rzeURZ7kz32VY2/n//GiWf+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(478600001)(6916009)(107886003)(66946007)(38100700002)(31686004)(316002)(82960400001)(53546011)(6666004)(66556008)(2616005)(83380400001)(26005)(6506007)(6512007)(4326008)(8676002)(2906002)(86362001)(66476007)(5660300002)(36756003)(31696002)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akxnWERDQVIveU5kdkpkdHY4Z011dVRaTmIvblF4Q2VxKzIvamJEMEh1SFFt?=
 =?utf-8?B?Nll4elFkVUVrV1YvaS8vNDdiaHBiL0lrMTBzdVB2czZ1WEE1NXpWdGoxMjlB?=
 =?utf-8?B?V3ZTbDdnckc3ZjRZWjBndnoySWhCWThhOERhb1ZXRzU5SlBOK1FHdktlS3dY?=
 =?utf-8?B?TXc4eEM3d2ZDNytJazQ0TWZKc2VOMEkvd2VkV0V3SURoYm5TaFlDeEQ0UkpZ?=
 =?utf-8?B?eHRCSDB6SHhvN0d3TUhRTldNc0trVk5IWTd6dGwxUEE0LzhPRHFEWjc0SUVo?=
 =?utf-8?B?T3RmR0VRMkY4V2hjb2pzdTlwMFU2NlBNLyt3RnR3aFdJVFJRM0VXanlLVnVs?=
 =?utf-8?B?eCtIRWxwTGFwdzF1WEhWaG1ZSWxDZnF5T1lYNmZKNS82YnR3RmhOMGhpTHJR?=
 =?utf-8?B?Ui96OVZCdEZ1NzYvNUFJTGFFOHViVU5iTCtmeDAyRHR0bzJRK0E5ZTF6eHBt?=
 =?utf-8?B?VGZFdEJMc0MvUjVUUVdzK0RtRWpqRmJTQVNlRWNuOGM3a2pxZmhoLzloRkgx?=
 =?utf-8?B?YXBBT2tDbm1GcnIwNUd6MkU4Nkd3ZW5TOVk0NkZtczhYbFdvcTdNR0YrbnIy?=
 =?utf-8?B?YnYxYklBNTZCT1hBSWxiaVdNb2hiNW1DVXYyQ2NFVW9TSHZ6RFh2UmY4Y2ZX?=
 =?utf-8?B?dTRWQnlobzVxQS9YSjVhRnlPTXdmNG1SV29WaEVLcjhaeHA0dG1oYnBLN0wz?=
 =?utf-8?B?eTNtMGl4WTI2YmV2Tk9rQzZpeThTOVU3NG9pa29aRmJPWEFDVzdWdnhyeFl6?=
 =?utf-8?B?SVNvZ1Z1NGxPQkI3NHh6S1pWb2xkMElGQm12TWIwbGRsdFVJRStwOHd1S1Y1?=
 =?utf-8?B?WEE4eEswU1lldjVPbEdEaU9xNS9Yelk5djlsZ0wwMVBMcjhGQzBXYU04TkQx?=
 =?utf-8?B?UkZzTDlaaGFuVzFKdUVjSGgyRE9yKzBDNmo4YlJrOFE4Y0RuYng1aU1xd3Z3?=
 =?utf-8?B?em5TVzF0cGVTUlJzTmZCY2FsZW95RCtRNTduaHp0QWxYaG55b3h5dVRndEJ1?=
 =?utf-8?B?OGg5Vk1oVmNMVkhyR2NPM3YvRWlLQ1M4TUxHNEg1ZHJjQ0prWlZDNjlpQ0lo?=
 =?utf-8?B?RllLRlNlVkxwU1V3SHRIM09NdERGVEdnWXVyLzdobTdZRVVvbFMrS0x6SCtJ?=
 =?utf-8?B?OEUvcFhzeWgyTG9MZUVUL3Y4ZzlUTmxhaGVwME1nc1N5UysvTm83cjc3Tzg5?=
 =?utf-8?B?T3pOc2ZPVHIrUERuQmtzY3RRaFJmeVJZdUU0N1doNWV0YWNWa0ZCbFM0VDBh?=
 =?utf-8?B?UkpkYjkvR2pJbWErRzhvM1hHK2xIL1Z5TzgzQjMyYXNteFVEVytlUkc4dThl?=
 =?utf-8?B?SEpZWXpsM0FDY2IySDNVYnc2aVBSUFNaUk5oYWZVTytQeWFDZ1BmMnRaUGdE?=
 =?utf-8?B?M3hZTi9nVWU4ZnFPZjNMK1NTd1lqT1RIeWRWQ0Y4YkpjR3VMMDJtWlQ4cWlx?=
 =?utf-8?B?Zmg4Z1FYQ3NrK1VIcVNGandXelFEcDc2cFE4Z08yMGVTZmtFQ2JkOVh2TGZH?=
 =?utf-8?B?cldtZ1FnbjBvUHBqcjFVOG9vMWdwTmFSb3VtL29jSnJZT3pydHJ4Mk5sVGVv?=
 =?utf-8?B?RHZ6UlA0UUI0OFZLay9qTEFJd05Tc1BkTFlra1RFL1V4NTlIZUgyd3U0b2pO?=
 =?utf-8?B?Q1NsWGt1bFo5anJtdFhUYlhNWllTZEU0OWFIS2U1bDliNFNGWkl2TnF4UnIw?=
 =?utf-8?B?NEY1UTdnaURzV1hIajVHc1VJU283MmhSK1FEVWpxcnhZdHBoMmh0UVpJcFhZ?=
 =?utf-8?B?T09ZTHFtSm9ycXBxQm01OWxTSEJNdWduOTc3Ni9OeEgzVmFPV0xjZEpPeGZW?=
 =?utf-8?B?eUdXbHRJMkZNQ3hYZjRBY21VMGlmS3hrV2U4a1lndDhvNkhlckR0RWhuSUV1?=
 =?utf-8?B?MS9nSkpzNElJM3NpaUl3Z1I4UXNVOTBzWTkzai95dGlhUzA4WDlPbHdJb2lw?=
 =?utf-8?B?VWhYNnlmSGlZVE1mOXIxeHptRkl2NU9wZ3FkaXVMeXVWQjJiQ3pDWXAvWHBr?=
 =?utf-8?B?cmpibTFraG5EQUNPR0J6K3RSc3Uwdm1UMGkzaVoxbmpFaEJJSWJaUzFGbCtE?=
 =?utf-8?B?N0xZdDVrbGhjcE8yTWpzTFlVS0gyOC9YWkdkelArY1FnbUw3MTcwZUJ6VnF3?=
 =?utf-8?B?aEI1UVo0bUQ1Q1E2Z3lySnBEODYvS1VUd0FRMjllVUpZV1M5bTA1YjVZdXYz?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29937846-f09c-4347-fa83-08dbd500a4d9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:18:14.7175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wbfq5qqcgX+XuLziNOgSVUkRxG5+BwWK80uM2UZ1scDyS2Ipm5lEsD7rxhEfxfejp8c3/GmmxrLZmia/8ynfTRK/iDc05bEFIj0eMht+2CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6076
X-OriginatorOrg: intel.com

On 10/24/2023 3:39 PM, Jakub Kicinski wrote:
> On Mon, 23 Oct 2023 18:33:50 -0700 Amritha Nambiar wrote:
>> +	rcu_read_lock();
>> +
>> +	napi = napi_by_id(napi_id);
>> +	if (napi)
>> +		err = netdev_nl_napi_fill_one(rsp, napi, info);
>> +	else
>> +		err = -EINVAL;
>> +
>> +	rcu_read_unlock();
> 
> Is rcu_read_lock always going to be sufficient here?
> Reading of the thread, for example, without much locking could
> potentially get problematic.

I think I was inspired by the napi_busy_loop code which works on 
napi->state under rcu_read_lock.

WRT napi_get_doit here (just thinking aloud), so if we have a reader 
thread retrieving napi from the global list for a napi_id, and a writer 
thread (maybe ethtool -L sort which is under rtnl_lock) that changes the 
napi list... Now, the reader may be working on a stale napi instance, or 
if the writer still holds lock until freeing memory containing the napi, 
then the reader may cause a crash... okay, all the more reason for the 
reader to hold rtnl_lock instead of rcu_read_lock.


