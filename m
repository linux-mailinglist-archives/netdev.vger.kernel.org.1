Return-Path: <netdev+bounces-30765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27E3788FF9
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 22:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2744B1C20FDA
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6EE18052;
	Fri, 25 Aug 2023 20:47:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A25CAC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 20:47:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B52133
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692996418; x=1724532418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KFsODB+DmQ9ZMwIyd2B5mglxmzFJD05EeTnV7HwPme4=;
  b=fJMVN3WEBAwSCCBsLh6gZ6Jzg9AnctsuAdJAqRHvza68PVcMTmXh4wpM
   x5kKzW9/xaYqimdjUR84BuVhkvzXWbN9Bntewmrur7HNXDrybIbIhbxf1
   8/pxkh3zFxd8ZukdUwfhDp4t8pwExd66pd+Yu0Pn/tcD2sAix28nQR/c+
   vGovmaOjf/jMxmq9oQ40sl9FLrcz+GNu8GGUPZoMu4YhpdMDJPZVTsToP
   6Do+AocFC7H2i/1kTLK5M+J6muUT+Yy2wa4o0cptDzKpkQ398VJwvVPLG
   9CnEKZukaohXx26IepT1miGwajxcsq1QeI35aqVKSbhzZ3cK3G7dK2XlN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="438741076"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="438741076"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 13:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="1068353304"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="1068353304"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2023 13:46:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 13:46:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 13:46:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 13:46:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 13:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/hj0loZOSJ9GLJGFdwLrjuwBELN5ZHfHwp01BNFIUrbwGTC9yr6Lts2qnV3MV5TFO3cXPi4qiBa+oXz0ndRiFf6g4++BqcnwBNgX6+Mjl51v9bK/BI7wUkcDqwksMymYyuRbGUUK2cXsuYKz+C/NkMqQhAj3bpEMnV/7IxGNwM6JeVsJie6XzHuXffy7PLRLLYtvr3c9suIfTmhe2YNu9ccgasCZplFae0fQFO7teF2fK8cBRVq3YGy/ZhLrT0Z00EGcum55X/M2ms7F2clqvz4flRKidYNhDIE20b51vl2HvefEmyxhjOXjjo3kpbxoQHbn6aGoWmVvHfQTCVMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULTUKYz7fxuByDZEA9qO3YSzxtfRJCa/4/1HaIruPaw=;
 b=bi3aK+N+pBUgvwnZLA2x0bamzi0Sec9EfJwTMi4xDXHLZCA74bm0Yb8Pzp7ht/MUdEzswXvH2xJ94k1e6ltnQqi4h+wt9FWz0hc4SAdYfOjK7tElSHKKd3OdF7KNCyOgHLZ88Pz9sgbh6aF4beX/5pOWHRkWQne89J2f5AzmThCZoQGzGRZr2DS3FxBsC0jGElqCcrfysHfDW6WWnc0+OEXmp5vPiCP76n96nFFeV82n/CnJRw+PTeMsr5GQCkv1iwHnI9A6aGGNHxKEDA5/5gWqd32eAwCG5DZYzauLrhX8yMZb3aQoiaAxNxwrHN5/Yc0wNK2oTk7/JO9rL4DrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 20:46:55 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0%6]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 20:46:55 +0000
Message-ID: <eed1f254-3ba1-6157-fe51-f9d230a770a9@intel.com>
Date: Fri, 25 Aug 2023 14:46:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz RSS
 hash function
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
 <20230823164831.3284341-2-ahmed.zaki@intel.com>
 <20230824111455.686e98b4@kernel.org>
 <849341ef-b0f4-d93f-1420-19c75ebf82b2@intel.com>
 <20230824174336.6fb801d5@kernel.org>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20230824174336.6fb801d5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SN7PR11MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: d16a5d60-80aa-48ef-dbe4-08dba5ac6acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9p2Pam/EZyzPeicSnNd5VmOaas7XJUhL5pvQlKdkQC2KIYEgddjIv4b+DjvFuHWdxXqj9+TY2e1hGOHHgVfJ2yjRlDsRoOdXayN0Qklfwk/rCNzdrsftCqYzVSHhK5BL1UB+r26pkHrgW2SOIGuX+3RZI1CV3ZGJr+LY5v+qFYnGJ/VByCpJ6peWUnAAqIgQwzo3XiYGO84BGk2Fx3IBqZsZUE3USiCFqQlDAfVfFnkxCGXLnzuAm2zoBg89GajkpR516oJoIx1exXwKgNW3O+Si3SaDDPGr34pGotmRkE2mej6egVm8rW1gk6PUORXi4CM9K5oXBaZtQ01Qf18lNBZV+4tDgoBKrpGdXZbDEj/IEtasrfRpgb85qbTEiDYQxfRzz8Gom7xE+DBjB5QxysMhv6nlbFxaW+dRvEG3YTO6sNw/fi2JPErS9VymbimM0eQgiiD4X45tgYiy/pQZynoh0obt12XMgHdHAm2ZqJh/hm5Pmiv7Egp3G4SIpclA3XdothZMpNG6RBXxFuwObPc5HQiyJ2MGHAbK/SOYeGHtysjLxvnUY4xmG4/NNMcGXZ14pm4VJSeJq9Oj+42k4hoW4fHUo7cCGO+AyHbnKnXtZocgaKjWPNbAQqJ4jQNWtg6AjPx9ITXT4F2DjkwYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(186009)(451199024)(1800799009)(2616005)(8676002)(83380400001)(5660300002)(8936002)(4326008)(36756003)(44832011)(26005)(6666004)(38100700002)(82960400001)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(31686004)(41300700001)(2906002)(6512007)(6506007)(53546011)(31696002)(86362001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhYb0tYUjdGVjk1YVhZaXZJejJsRFc5Qm9PSTZGWnR5TkVFbmJTK2dKak5z?=
 =?utf-8?B?NDRJdVFCdWVzVHUzVmV5a3RCK01aM3kyeDdheGo2RzgrYW1XdzVZaW9lWGNh?=
 =?utf-8?B?bldVTjdVazYvbGtGWi9BQUhTVXZ6NkRsT0hhaFB0d0xrZWltS0V6cDlBaDRx?=
 =?utf-8?B?YVZMSWRoaUo5WFc1YTlvZGR6VTVTb1BNYkJJRkQxNVBpUURQbnNLblQvamMw?=
 =?utf-8?B?ck91V2twdXhJR3pVVnVGdFpCS09wcStNRkd1OE5iQWdsUFpTa05QYW9ZN1Js?=
 =?utf-8?B?Z256WkEzN05TbjZuc1RlTnplNUZmUFAzUU4rdElGVldXbDVON2hmMkVWUHFn?=
 =?utf-8?B?TmNkR1VBY3QzQWFlSzRPU2NKcGNMUW9pb2JTY0hqdEFRRHNFdFljNDV5anhv?=
 =?utf-8?B?VnNMbmFGNGQyRU9oek5xVml4MWx4YnRsd1Q4cG9xb2dFa29NaWVOeW92TEZn?=
 =?utf-8?B?eEYvelBWUFpoeDZVeXlRd0gxNFo1bEl0MFJHbHNjOXVOVEhzR1NhUy9BeU00?=
 =?utf-8?B?REtDMTB0UWtQSHc1QzZGV1hQK21GU3hYNWhUTHQycitOUm5WaFN3QjBaYXZ4?=
 =?utf-8?B?dzFEeGtIRzZPR2VoVFJGclRHdGR2dXpYdXBRYTdjbU1ONHlEQktlNTJuMGtK?=
 =?utf-8?B?QkNZYm9xTVZqckw3ZG9xNno0UWNrR3pMTVp3R2xhY2ZISTJ6UEhTVUtySzJ3?=
 =?utf-8?B?RXJMRnBiZC9yQmRLTFJoNkZIOXk5SVpYUWFBZUZPZExMUlBSODUxRGlncjA1?=
 =?utf-8?B?emd3cHc4cm9uUkVuOGhkZ25vaTBxYkdqN1QrbStTejNJcHBRU3NaY3AyUUk1?=
 =?utf-8?B?MFRUSS96ajFsUXhpOTZWZUhPY2thUjhzYWlHNEE3enlTR3pUQ2hOZUN3Z2Ex?=
 =?utf-8?B?UmorUTBNR2NZc1U1eG1nYzdTV2s3TzVDcUpUWXRLRTZ1c25nZG5wZ05QQi8w?=
 =?utf-8?B?cGxkYjlteGN1NzRKT3NjMmZ0b2VVcXlzTFg2YWdSd1oxRS9TTWZWTmN6ekhp?=
 =?utf-8?B?bXJ4dHZvWVZrSXNSZTQ4elVzYVlsK3RRQTBZN09rRDdYVmZTZXg4cExTMVJo?=
 =?utf-8?B?a0hpRGNJNzczcjZXQWM5aDFLdHZIM0c5YVRtb1Jjb1FZM2dlWDMxQ1c5QnhD?=
 =?utf-8?B?V2NXN1BBeGZmWHhvNlJFREc1TFNTR3FUWDhtWk5qUFhJL2lta0tXeG44MWZh?=
 =?utf-8?B?ZG54TmtONUwySW04WmhaUFd1N0V5RXZobHJQVEphdkNleWN1czM5cEE4Z01D?=
 =?utf-8?B?NTlCZTlXQVUzVmlGQ1ZQa0M4Nis1SFI5RjlKQ2R3VmNRVTlVL3Vvb1lYaEZu?=
 =?utf-8?B?YytMOTdkZlRlcnVKdDZTT3dSbjR6azVHV2hEVUV1c085eGh3VnBaOWZOSlNj?=
 =?utf-8?B?ajg2eEZTdWErbUlrTEpZYjdYckF3Z3l1YS9TdmRFbHo5UzJxQ0JPNTJqVXdn?=
 =?utf-8?B?NlZsZk0vc0xkTS9FTS9qcUhWdUdRVFEzNVVVSVNGeVBpM0tQSWI1WGVrZHp4?=
 =?utf-8?B?eE94dmVRVDhxb1p6UU9lTCs3Q0VQbU9RRjg4Q3BEZ3RQbEp4NElscHlhSzd3?=
 =?utf-8?B?VmZ6QlBaUTFHbTlMeWxzMGJJbFZ6V0V2dGpFdlVmSGR1OUxnRW5KYmE4NXVu?=
 =?utf-8?B?eFIxQXBpcnBPYXFtMVh0VENBcyt1UE9iM1N4c2lpVWtaVVY1UkU0TjNlQlM3?=
 =?utf-8?B?UEhKWVNEcUs0Smp6QmphYVNSS3JCazczRE5pd3hQd3g3VEVCK1piSS9HTmZK?=
 =?utf-8?B?TFl2Q1NMeUJ5RHdrZ1V4TUpJRUhSUnFqYmFTUHo2VVhQTVlPZlZzSjhBQlFt?=
 =?utf-8?B?Q0hNdVAxcjBweHMyR3RadHRPZTZFbWs2T1dpRWtCTkt6RXhDZm1PbTNWZ0hp?=
 =?utf-8?B?VlNkek04MUN0M2pUMjJKeklkNHZRS3hDM2lrU1FMNWIyZVo0OUg4SERkZW53?=
 =?utf-8?B?aE9VZGxWaDZLVTFGMGQ5Q0xaM2hMV0p5eDIrOTJILzA2R1QyemszRDFMSTBU?=
 =?utf-8?B?MFJZN1JQSkpxT0xhaWdsckliYnVsYUFBS3pvNzhjdFh2Y0ZQdXh6akt2Nm1O?=
 =?utf-8?B?bktjRWZlYXl3L3Yyb2FaTWpnY085S3g3djBRR1dXQUVCNEk4aC9aUjluQUFy?=
 =?utf-8?B?T3Y1cFNlWHBqblJReTM3R0ZjQzlEbjUyZ0V0K0xnLzFpZVRhZU1QM3ExM3I4?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d16a5d60-80aa-48ef-dbe4-08dba5ac6acf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 20:46:55.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3q646mIlt7cksF3ZYDHUDpLGjVJ4rGKj+cduCLF2QSe6kZFwAFQypFZdNM88LNTCY93NI9Wa8jRvK0jEkzZfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023-08-24 18:43, Jakub Kicinski wrote:
> On Thu, 24 Aug 2023 16:55:40 -0600 Ahmed Zaki wrote:
>> When "Symmetric Toeplitz" is set in the NIC, the H/W will yield the same
>> hash as the regular Toeplitz for protocol types that do not have such
>> symmetric fields in both directions (i.e. there will be no RSS hash
>> symmetry and the TX/RX traffic will land on different Rx queues).
>>
>> The goal of this series is to enable the "default" behavior of the whole
>> device ("-X hfunc") to be the symmetric hash (again, only for protocols
>> that have symmetric src/dst counterparts). If I understand the first
>> option correctly, the user would need to manually configure all RXH
>> fields for all flow types (tcp4, udp4, sctp4, tcp6, ..etc), to get
>> symmetric RSS on them, instead of the proposed single "-X" command?
>> The second option is closer to what I had in mind. We can re-name and
>> provide any details.
> I'm just trying to help, if you want a single knob you'd need to add
> new fields to the API and the RXFH API is not netlink-ified.
>
> Using hashing algo for configuring fields feels like a dirty hack.

Ok. Another way to add a single knob is to a flag in "struct 
ethtool_rxfh" (there are still some reserved bytes) and then:

ethtool -X eth0 --symmetric hfunc toeplitz

This will also allow drivers/NICs to implement this as they wish (XOR, 
sorted, ..etc). Better ?


>
>> I agree that we will need to take care of some cases like if the user
>> removes only "source IP" or "destination port" from the hash fields,
>> without that field's counterpart (we can prevent this, or show a
>> warning, ..etc). I was planning to address that in a follow-up
>> series; ie. handling the "ethtool -U rx-flow-hash". Do you want that
>> to be included in the same series as well?
> Yes, the validation needs to be part of the same series. But the
> semantics of selecting only src or dst need to be established, too.
> You said you feed dst ^ src into the hashing twice - why?

To maintain the same input length (same as the regular Toeplitz input) 
to the hash H/W block

length(src_ip , dst_ip, src_port, dst_port)  = length(src_ip ^ dst_ip , 
src_ip ^ dst_ip, src_port ^ dst_port, src_port ^ dst_port)




