Return-Path: <netdev+bounces-30769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065C789051
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DAD28188E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E460E193AE;
	Fri, 25 Aug 2023 21:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1A5CAC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:22:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CF92125
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692998531; x=1724534531;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HYV1gXfEW7hDwgL1qxrGasS3ncos4SjlKlsXWRCsYaQ=;
  b=Qd7vZC1jiMoDlLGQQga8UbNcJXNHY3q1gYSwkALg8H9h42v0CieigOGE
   Db+/YW4/gLEh8nnNa3Om8gDKh98b1e+P25CrmxHU/wHVG9njZ5WA/bNre
   acSwMJqR+qmAoybq6oYFZiOh3BKivlg12BrwxiB4eSnqR7m1moTGD5KT6
   2NZmqK1a9dPFRCPovykmigYCMtgWbsux8v0yRPtLqltpHCCMJggNDbosf
   WfOkObZzTHuMhSZNJUwZIGb+q+NGHQ+epFvlZ35MlYfcfcIb0Az1EPh3i
   FMhbol0vgGR/UA1Zf3xa9wZtWnWU/a7nP9dEoJwUJW6O6SRsb+WviU8la
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="405800939"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="405800939"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 14:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="740742523"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="740742523"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2023 14:22:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 14:22:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 14:22:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 14:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDjPTyYuNmNJ6ZVdSpOaPvf+bJRBMMY7IKJ0Y1p7+tdJbNjTiRIZbVNzDt0WKO6YLWdnEwJzSVvH5GIXlIMuh5pXBIW2EPkNWe3KzMkIwCdPuNcFvQPOsRDpvV/m31W4WaEVK5Y5257XteOg6ALNzCbWVQhpixtBcyqrq0VRMYSur5L4/Nar4jdlJE6jhCITrf/GGWTsYYa4r4pEHV1swzwTJozspUGSAlhoZ9zlnAAeHAoJ6OANF65yP0inz/RFP+w9n//U6Odbtg3r8C/VscS9a8HbJn2pqiqKbJ5dKSdqfWJK8vkIY9JARm6nwfxS27R23+D32NVI7u7+tMa3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfrzq3nhMYJFve9U0ZNpcd79k2SWI64YcXaptcFHbJ0=;
 b=nbem6ACfonlNLS+P7ViayNHQT5dUPnMY6ngdY3psfKW6Cddq88xHknS5cvu/VqnhPxz84D+Ej0mNiAETNp7Cqc/tX5O0JTL19E3QTXvoLK6YYXxGf9Xbu0h5BI0vKp4CRHEeYDtX+g2CKQL+yI+XUj+YkrvtXaDSpf6MwMdx2hhYJitDflSOqC+yDFjJSvbBhtCyF0R08Wi/a18iGUuwC9V53qFjb9nHx2jMfjkZk4He8bRuc/DzEiM6OK7c5d6tapqAiaHSUe3VbhyrnooTTEmiOkUoO2i70RZqT3hNSYTdGecho7Y0LDS5tRUh80BvOxu9j84/k2rAAGK/B/icsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by CH3PR11MB7392.namprd11.prod.outlook.com (2603:10b6:610:145::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 21:22:03 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0%6]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 21:22:03 +0000
Message-ID: <ee942349-d8b9-c31d-fa81-a0e82d0f3cda@intel.com>
Date: Fri, 25 Aug 2023 15:21:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz RSS
 hash function
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, Saeed Mahameed <saeed@kernel.org>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
 <20230823164831.3284341-2-ahmed.zaki@intel.com> <ZOZhzYExHgnSBej4@x130>
 <94d9c857-2c2b-77f0-9b17-8088068eee6d@intel.com> <ZOejNYJgR74JGRse@x130>
 <4f0393fb-7f5a-5e91-ce43-4b2d842dd9b3@intel.com>
 <64e7e80c13b60_4b65d29437@willemb.c.googlers.com.notmuch>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <64e7e80c13b60_4b65d29437@willemb.c.googlers.com.notmuch>
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
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|CH3PR11MB7392:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c9e6dc-7221-4215-e805-08dba5b153a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIHJuzNixrVI8QVktRkguEBEI1Uob06PD++/SLWt2EHINvkJa7GbuETmBSzP7+O4JGrJdFIP7npzYIW1q470Yck6CY0nadvDcqzLjdJmgMdCaVIRIcqqzCN2G/fyn4x/JcQ5fACWho4l1wkXQRDRmDyHdSthjUfvPinIQqFpea0JfE3xgXGbYa7R3eG+p7T749fF7ziR1aWjpJ30bKIOq0vuHqcUQTEKolDcSNHHVgjhvDEOPT9KhYS9Kx9B46jQDnUseeq06wtKaHK/tRY5vEIHGomQpr7dEfK+AMD/ULr31ilUwkDhUcTcnjKLZ25VO7kNr6pyHX7AXurW3ENXEs0ZBvgcd5F+NNYz7EKde+LMoSgArh5uagPS7Elke4dltAAlygakYCvApCnh6byprnqA2rI4ouY/LrNxt4nPrvODzrwDOWS4P+XKsOO8g2Knc56AWLIqqsWYIBG7642xH2kHcRzbmkRWhX1/pprhuwEf2RwF60H1fLAgjYAZbaWWLdinqvZP+8PYWl+k1dGdMqcp8MkggEYU1Hr6H1Wb/Z9YYVCQxYhik9B1vaf/ltO18UDVdfEidnrPBS/kdAWvX3JryqomtSogFxf+F4p38DP4IRVeeaMNwbF91ZYPDQSRQhwVnOj/I5BXPcJOyP2FOv36o4bRJeZzfW5M59XKwKbKqbl6P3E7FT8/zfAUf0+7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199024)(186009)(1800799009)(66946007)(66556008)(66476007)(31696002)(86362001)(6512007)(53546011)(2616005)(26005)(6506007)(478600001)(6486002)(6666004)(36756003)(38100700002)(82960400001)(8676002)(4326008)(8936002)(31686004)(5660300002)(44832011)(6916009)(316002)(2906002)(41300700001)(369524004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUxqOExBYTBwclEweFFmY0V6bGxKUUEzQzk2b20yellZMXhaV3dzUnE3L0Qz?=
 =?utf-8?B?d2duWTRTVHNCdmpzRVlVbVFzQjBhR1dlVi9oVjdFN3VPeks1cnBIaG1WS3pJ?=
 =?utf-8?B?MWpueUorRmdqYkFQcVh5NmR0ODNmVUlEOHJiZTZtT2l2aG82RGxBejVhQXk0?=
 =?utf-8?B?K2wvcUlMVWpBaFhja1VPNWUyRmtDNWErU3JacFliMDZvUEdVTEVFYVBJMTlR?=
 =?utf-8?B?bzl0bmM3VGxnYldqMWpwRXpTcjJrdldYbi9GOG45MWQrTFVXVHVlNjZReVIr?=
 =?utf-8?B?TE1qOFBvYUFkODJMcEN3RjVsaG80NVM5bmdyd0RUazVlU28xNW5OWkNUUDJx?=
 =?utf-8?B?bStmb0llTjZXdmV0ZER3NVVqNldYUHRUTzJYVHh6eVpHVXl6MjNWQTZtUkNz?=
 =?utf-8?B?L1VsbVNJRHZEL3FBemwxYXdEN2RiRUQwYkFZdXBKVFRaeGQ4OHUxY1BkMWFp?=
 =?utf-8?B?czFlNmxiNTFLY2ZxQTF3WldxTGkzbUJQNjJqU3J6N3daL3ZNL0YyRkVZOTVE?=
 =?utf-8?B?cVFlaGIrMTZWTlFCUkwwMW9JeUZkRUkwVkQzRmpzZURpR0kwWE1JUkZFV21v?=
 =?utf-8?B?WW9nalJlL1BrdGVMbzVUZWJiK0pqekd0UGdHYkZscTVHUVI4N1VPWXF4aGZq?=
 =?utf-8?B?elB2SWFENm1taDNzajkweU9DMUFwQi82dmplTFVxS0R4ZThxa0Y4N3VCWWVs?=
 =?utf-8?B?R0ozNlNFUk5Kdnk1TmV0clpNWVdhTnFNRCtwYS95KzRYOHVYMWVxOWozT0JJ?=
 =?utf-8?B?Q1BOeEJPS3JEand6UjA5VXN1RmZ0cjhPUm4rTUREdDhYdEl3WjdoS0IwNUo5?=
 =?utf-8?B?QlRxdEduODh5R1lYNmVLQlEyVE04OFR3dk5Za3JFYnBjKzZSZ3JJeDFFcjlM?=
 =?utf-8?B?SUpWQmhESHE3TGRLay8xdUp4SmpiRGdGTW50dW9TcnhVenh3SHR6ZWNTbXNF?=
 =?utf-8?B?eG9WdHc3Vk1wbTZRdHdlVGlRM1I4V1c3djNpUnErYm8rNURKOXpyeUxUU01j?=
 =?utf-8?B?NTlUcXVWSlhwVU5wMU8xdy9pWTBxSmU3Z29TZW55dU51NHU1SURWSURvNCtH?=
 =?utf-8?B?WFVhMGROWHp5cHUrdXZzSlBzL1R5OUR6b25zN1RNYndrL2xWRmhyWUZUTmJZ?=
 =?utf-8?B?SVY2YWMwRU55NGdyZmlMZzVjeHN4M29VU1ExUmRVWU1kNGRCWmF4aUFYcEgr?=
 =?utf-8?B?VmhZQVgzRDhubXFPelFSL0VBLzJGanAxUiswSXo2SFRRYXVMd2RkM0xhdG9a?=
 =?utf-8?B?cWxGb0JTNFhTSWNITnQ4RFhyUC9mY2w5NWVyU0dETXNzSW96bWVIanlrWHNB?=
 =?utf-8?B?RTgxSG9uY0xZSW1pUEM3QXNJNm5lYWVMMlR3T0gyRFlzMlljS2RxV1dha1dV?=
 =?utf-8?B?dWw0dW9WbnlFbmtTUkZiZEJCS1F3cXEzeUt2S1VRYVEzYnVxQThmMENBYkE3?=
 =?utf-8?B?MUdRWXdmWFdMT3NWNTV2MVR1eWZ3Y3pod1hZdDJEdVU4RTRZdGs0OGhCcWpQ?=
 =?utf-8?B?WUlXUGgzclNlWmFUS3hSb1AwR2toRFRUUHAvVUorR3F6N0t2dTg0b2daSnZS?=
 =?utf-8?B?Nzc5SUE2NGRyWkdCeGxzcFFsb0wzcEE5K0pqcVRYdFY2NGwxZnppMmpuVGJy?=
 =?utf-8?B?bmxReG1RYXNWcTBCSHJPMThLWWRWckZLNUNzVk5TaXl3bjk0SGs0RWNqS0sz?=
 =?utf-8?B?RHRleXhvNnMwUGdoVzZtWUVwMzBqc2JWSFlVZTZSMnpYR3p3UE9pRzEyUFNa?=
 =?utf-8?B?TkZJc0xsQWJSSW5FSWZsak04L2hMeTJnSXdMK1FnaG9Db2FxZCtJNHo1YkU2?=
 =?utf-8?B?SkpKdHRjYlFWTVptQTFxZDBLT0tjVWRPMXNHMk50cFVEcFhiT2RKbFhsWmg4?=
 =?utf-8?B?RkpTdHNjY2xrN1ZvSnJ5aXE2SGlxbkl3MXh5R3dTUnRHMm1xY3FhMlE0eTQ4?=
 =?utf-8?B?OUh6Z0FsVy96U3hUQ0VmTkpJZ1Rla1oza2NQamxLNTRJRUNKQmxnMCtlOWR6?=
 =?utf-8?B?TWpPbGp6aTFSbmF3dDJzNzFWVDN1WUFNR0VTSDVORkNBdjRBczcxVERwK1Ja?=
 =?utf-8?B?U3c4UUNWQkpQa2VvcHlYMWxrN0hJeDV5bTBmVGFCUTBIdHloT1hrcGtWampK?=
 =?utf-8?B?aCtsRzl1L0hReFcyeWdGL2lYUlBVMUFLQi9oME1rNVBqeVZOMUtKVWczQkpw?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c9e6dc-7221-4215-e805-08dba5b153a1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 21:22:03.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZSU8oylrY+aPM5TcV74cbmU1q6KrpKT60Nbg/sxWLq37K/Op9ARxAum1RNd9F8qm57xtvjC2G2USHZ6GP6Gvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023-08-24 17:30, Willem de Bruijn wrote:
> Ahmed Zaki wrote:
>> On 2023-08-24 12:36, Saeed Mahameed wrote:
>>> On 24 Aug 07:14, Ahmed Zaki wrote:
>>>> On 2023-08-23 13:45, Saeed Mahameed wrote:
>>>>> On 23 Aug 10:48, Ahmed Zaki wrote:
>>>>>> Symmetric RSS hash functions are beneficial in applications that
>>>>>> monitor
>>>>>> both Tx and Rx packets of the same flow (IDS, software firewalls,
>>>>>> ..etc).
>>>>>> Getting all traffic of the same flow on the same RX queue results in
>>>>>> higher CPU cache efficiency.
>>>>>>
>>> ...
>>>
>>>>> What is the expectation of the symmetric toeplitz hash, how do you
>>>>> achieve
>>>>> that? by sorting packet fields? which fields?
>>>>>
>>>>> Can you please provide a link to documentation/spec?
>>>>> We should make sure all vendors agree on implementation and
>>>>> expectation of
>>>>> the symmetric hash function.
>>>> The way the Intel NICs are achieving this hash symmetry is by XORing
>>>> the source and destination values of the IP and L4 ports and then
>>>> feeding these values to the regular Toeplitz (in-tree) hash algorithm.
>>>>
>>>> For example, for UDP/IPv4, the input fields for the Toeplitz hash
>>>> would be:
>>>>
>>>> (SRC_IP, DST_IP, SRC_PORT,  DST_PORT)
>>>>
>>> So you mangle the input. This is different than the paper you
>>> referenced below which doesn't change the input but it modifies the RSS
>>> algorithm and uses a special hash key.
>>>
>>>> If symmetric Toeplitz is set, the NIC XOR the src and dst fields:
>>>>
>>>> (SRC_IP^DST_IP ,  SRC_IP^DST_IP, SRC_PORT^DST_PORT, SRC_PORT^DST_PORT)
>>>>
>>>> This way, the output hash would be the same for both flow directions.
>>>> Same is applicable for IPv6, TCP and SCTP.
>>>>
>>> I understand the motivation, I just want to make sure the
>>> interpretation is
>>> clear, I agree with Jakub, we should use a clear name for the ethtool
>>> parameter or allow users to select "xor-ed"/"sorted" fields as Jakub
>>> suggested.
>>>> Regarding the documentation, the above is available in our public
>>>> datasheets [2]. In the final version, I can add similar explanation
>>>> in the headers (kdoc) and under "Documentation/networking/" so that
>>>> there is a clear understanding of the algorithm.
> Please do define the behavior.
>
> When I hear symmetric Toeplitz, my initial assumption was also
> sorted fields, as implemented in __flow_hash_consistentify.
>
> If this is something else, agreed that that is good to make
> crystal clear in name and somewhere in the kernel Documentation.
> xor-symmetric hash?


Thanks, I was wondering why everyone was assuming "sorted" fileds.

If we go with an a new algorithm (-X hfunc) I agree we should name it 
"xor-symmetric".

I also just suggested to Jakub to use a flag instead of a new algorithm, 
since the underlying algorithm is really just the regular Toeplitz.


