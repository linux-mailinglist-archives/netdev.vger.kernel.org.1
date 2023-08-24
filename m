Return-Path: <netdev+bounces-30354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB91B786FFB
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C4C2812DB
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C68288FB;
	Thu, 24 Aug 2023 13:14:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDE288F6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:14:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF10198A
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692882876; x=1724418876;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H7Mytf1o0tURTpW5brR68qaHusJrcXMQqccz5HmoKjg=;
  b=GjPZTpDKzvg48fcnR6wpdBGBGesdY33JCSawA8jkZcP99Xk3EFdKVbpH
   uYa3WdcovygDKNnIZD8frEXws5pMngY/LLDwJvhDq8nIV/NXFDPjgc/HW
   7WxlNHkG3nSbMjLQ6ltuIg8XiE58PxG5d8rYIhnHHTiClOkSltRuUcLQM
   85eI3VJqHdwrsN9wThWl9ALQfGg+3zufwc6sA9KxDNDAMPjxtdo+4RtCs
   vVmvqBIilRv6qostauPlxefLcwcPDzghPqLJGrk0OOB1WP80mh9WfCsV8
   dJEMlKEj8QJD0yFc/2AM+X95DpQmQ3HwAQUoVnHsF1QguNwwSl/UCMOpo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354765620"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354765620"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="737036029"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="737036029"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2023 06:14:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 06:14:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 06:14:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 06:14:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXFCV9x+4QzbyzxnJNVIqaxKENSp3TNPyHAMDKNAm3QxAYZlakvTAmlznALAqAZ/upEhX2o761WoHUysK7ePvB3AVOyylfXGGxBhs6ze1UsiwZa9RawtxFrEWaJ5S/hbkOx2xKwhJrom5YlWeezPHyaDgGAOredeX4lHS/sAvMwtApznV/lDf42HU3m+KGiPKPH3gIerOqv7F0S8AeZkXj2Y05rLx6vDOpkO05VJdsbn8cH0x4BLFsLDXu/OnYdpyq27WwX5gcjPm9yS2RhJlrWx0vbZ+30w8V6iVSm3yejGt/yyALG9tcJ06rBRg0p/kipwXpbtgYrmUGZ5MghErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQp2QU6gQaZgrlcwnV77eoxfd8wWN3ZTDDKrxWY3gD0=;
 b=VgBJiWGrXm2Y+j1HiTwBC7uXf4a1zzE5YNE4PZZarNWRVxPk7NYgUjg0ONuV147XHcAsO1LFdYR/wQF/+z89sv4EYw6fB7mOni3eIV8EBpJqq369wXLAZ0flCLC57gXTkvSPZWL+mhgjjkvnfMR5F7on0Zi/XrQV8nNpdpTknzu14m07G74bpqULheFx2mzNY8eIKwPoFLn1j8255ErvxSq4nVPyDlTBl81Z5YyuFfoQd4W3N/zbD/8J6MD3sGvAvst4hgw5qqAmphM3OVJhZl+9/FyGOl+uC/BdFlh2/N/a6ls+16gJE8s//ZQlZhbkLaZyNsUOLxtnc4k4jEIvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by PH8PR11MB8260.namprd11.prod.outlook.com (2603:10b6:510:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:14:24 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:14:24 +0000
Message-ID: <94d9c857-2c2b-77f0-9b17-8088068eee6d@intel.com>
Date: Thu, 24 Aug 2023 07:14:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz RSS
 hash function
To: Saeed Mahameed <saeed@kernel.org>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
 <20230823164831.3284341-2-ahmed.zaki@intel.com> <ZOZhzYExHgnSBej4@x130>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <ZOZhzYExHgnSBej4@x130>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|PH8PR11MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecdc841-dd5c-4edb-4166-08dba4a4097f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Qbm4TbsL8TsjmWyu2RhSojxWpb/J47K8I6eOuVE/OMXJQp37fUYtMFYgi4MOzbWjC+BmXNWPmQoPcsYnF+CPTSR2Zcvq/FTxWRwpL1XJjAsLIpCLW77Nqoy/tCRyd49YJyueqUSn95JQkz94KXpb1uhoiVvPpoX3cp3oeg4S2FfelUvp6ANBRbM7IrWVlWSFOtmVRk7OSxPP1O6KHKV4ve7fbUOQOehlqrxk3ENp7qUKZemn8dC7KOYsiOTab7RSkNvcTCgKNTzgmqyG74hF4KaMo98BSLXTFBBjTu8Z+Siy8+yTkDl3chgmW+WmYSDcepbYvV2bT7yabyK8CFtScF5urX8EB3KwoPACp5xrdCnU9cG83ogr2hyBcv4tQvLirRnWBgQf9dyTmSnSTdhXrXPrj7iITLtRKHKaKWcnI++myorKfdJ3o2z89JZKatlUB1YZb8LSe2tHeys6bKv1HLy4dBHzgAGDKAF+tyXAb4oUW7Omi3BZ+hx08T0ORvxXzodIE4vDJpwYP60GT6+dsvVkUwiCjH9CpZbKdEW8aZEXqemwjaBJ93TKnJXtnoOvjQgmRKZJZ9t1tOGS7YCZAlsLz2WwqlGk8KPu0n0p5RRgt/5Py1FP35bOJx+hlBJp1nl5exQC6dHf5+uXqetnbxwuiPyEQlyuam2aOt8VIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(66946007)(26005)(83380400001)(6512007)(53546011)(107886003)(2616005)(41300700001)(66476007)(66556008)(2906002)(6916009)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(6486002)(6506007)(6666004)(966005)(82960400001)(31696002)(86362001)(38100700002)(36756003)(31686004)(369524004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlJXRUpIZk9DTyt1NS9QMmYyNFM3enppY1VCMHhLQjhjVFhodkszV1p3a1FY?=
 =?utf-8?B?eTZKY2pjd0tiQ0d5VkFKN2Z6eDdiUlFEaW5HK2Ntalpzc21aeUZiTUcyVkti?=
 =?utf-8?B?TkkyOXRCM2JzUUl1UTRTbEhTby9qVTRwTW1Kd0xUcldWcVVJWFpGZ2JFeldJ?=
 =?utf-8?B?aWdIUG45eHhKYUVkajdsQjJra1FwQ2NtcFc3WFROWk9JbjZzU1VXUkJnTE5D?=
 =?utf-8?B?Vkx0dkRwbVhRRThQbG1iUW9OUGFvSlRqYi9yYzBpdmtVbTNVa0tsSTd2UHZY?=
 =?utf-8?B?VUxhQXdQdTIvZTgxZkhTWXdQbUMzSUk4dEdVODBmaGQxZm4rVExCd3ZzTDd3?=
 =?utf-8?B?MmxKV2htUTZmeFZnVEw3RDVuMVZFSWIwc1A3UjEvaUpLb09sS2Q2RS8vZjMr?=
 =?utf-8?B?bmxSNmRKK2J4bG9WYWRlRlBYVE1HcS9PYlUxQzNTRklQSEJKZ0tJekJlTDUv?=
 =?utf-8?B?dE5ybmlZeVQzaEFJUFJ2ZEdtU0xxcC9tc29LZHlYUW9FS1R3ZmxpbndjVVlR?=
 =?utf-8?B?MG9GSFJ5ZjNacUxMSkprekp0WGRQWG5tN3pNT2ptbVNLaUhhVzJBNEt3OTMr?=
 =?utf-8?B?azlyU1hBdXB4SUdEeHhZZW9nZy9aR1ZhSW1tYkFaRmNYTzlmaDZ6emdFaGZN?=
 =?utf-8?B?Skl3aFVLUWJPR1kwMXlvZ1VPWDdtVXpYaWNiK1JBQ1hHMU9saHpvWE5Jb2xn?=
 =?utf-8?B?ZkNhbnR2MlNKYkFaTkVQcFNYUDVyNEpKNjV4ZGJiY01Gc2ZYOWtVdEw2MjRU?=
 =?utf-8?B?bFhFU1J2T290Mk45bmFvaGlEOU51d21VdlJqRVJ4UjFJUnA4U2owYmpVRDVz?=
 =?utf-8?B?QW95YmV2SXRncGovYk9WODBUYzYyMGdBYkIrNXNFejdVUFAwNnp0RHVjTzBw?=
 =?utf-8?B?aDc1N2dNcUx3cmV0TkhNeHFYK2x2ZlI2VGdSVjdRM1V6RVdxd0tpemNnUUU4?=
 =?utf-8?B?a08zd3RzVXFVaXQzNlpBSzdoeE42Z09MTExPSm5RYm0yWjhXZzJmeVNKNkIx?=
 =?utf-8?B?T3VKSjZWTmxkcjNXN0J5VFBKd0xrZHYycVQyRXBtRXZzK3JuVjBkcUloTWhm?=
 =?utf-8?B?UFF0b3dXVHJsdk1pYU1TYy9xaXZpUXRYWkh3Uk1TbTVPZmI3eGVBUEVlWEk5?=
 =?utf-8?B?YlZZYkpwdUlLa2tzNTZPa1NrQVhJT2hUaGVFK3VGYVV6c2VrcHlpbUlOZzNa?=
 =?utf-8?B?WWN2SytPMXpUYmxkWWtJdUtLdlpCNG1tMUd6c25OYUxjZzhWUHpXc2s4VmpM?=
 =?utf-8?B?N1lZS1d3aVZFa0ZwU0I0MG9sM21JT2xrVHpRZkRNeTdlOWpDZnQzWXhjUitC?=
 =?utf-8?B?SDJhajNnbE5EVGl2eWxuN2tzWHRmMzVxeTBNWFUvblk2aVVITWNzVUZLREtp?=
 =?utf-8?B?OGJqb2lFdlk3NDJJK0x3eHJxN0p4dmdBN3UwTm1Ic0MyemJhMC9NVW5rTWtI?=
 =?utf-8?B?K204blYxNnh3ME03dEZkVlpUdG5KY1RicU95dTdxMUZJZ3lEYTU4VjFXNGp1?=
 =?utf-8?B?MVdCNXlLWjAvb2J2aEE5dzdleGhEV0YyNUxUYWdwS0U3Y1B4UWVzRnVIWDBM?=
 =?utf-8?B?dm1kYnp0dXRPUnN5RUt2bVR2YmxUUXhpRFRidE1ReE40RkRhbmVLYWZwc2xy?=
 =?utf-8?B?eWVNaWxDeXhyK2JHZ04zWWNaU05HdDVPcjU2dGg5dDViNVo0UUV5eDdqUVpS?=
 =?utf-8?B?cmJ2MkdXSWJFUDBkcDBGUnZ4dWVjTCt6VXVwbDQvQzlBaC9IWVdNVE1Tb3pt?=
 =?utf-8?B?QTYvZ1lKbGZDWGhyOGVveWhkWEo2bC8xbnA2VHJKZzZaY0l4c0ExMWMzdlVk?=
 =?utf-8?B?WmZ0K2o0TERPaDdrUGcxNVQ4Z0haUmFKVWUyLytuYWIrZ1UwTWVKUjhXaG1X?=
 =?utf-8?B?dWxZM1pKSnkwMXl1aElsRkt4Nk50NWtqZzFDTENrb0t0YzVxWnlvV3VLRXhE?=
 =?utf-8?B?OGx0OExZOWxmb1U5RWxIRG55SklNTHp0Rkp3cHBaZWw4ckhvVXNKTWR4NFRy?=
 =?utf-8?B?aG1VODNhQWpqMTRvTFpNUnNCNVZTN24zSTM2K2drc2pTY0pJWU9USi9FQnhs?=
 =?utf-8?B?ZnU1aTFqRnRQc1pJNGt2aW9vd2R6VkNCampPb3lhQkwxdW1IemozU3M4SVlD?=
 =?utf-8?B?Vzd3dXJKNFdkSFI2QVdzNVIxdThibmpXMUtwQ0FQRHhDSTArcW9nZHc1ckVi?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecdc841-dd5c-4edb-4166-08dba4a4097f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:14:24.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +150HdEJje4LpI1k4r6EFgo9006wdhGKBvTDxN6DsRyO534SpSWjW7FrftAf+dcaRGlUbHI4B9c+/z6Z0Bx3ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8260
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023-08-23 13:45, Saeed Mahameed wrote:
> On 23 Aug 10:48, Ahmed Zaki wrote:
>> Symmetric RSS hash functions are beneficial in applications that monitor
>> both Tx and Rx packets of the same flow (IDS, software firewalls, 
>> ..etc).
>> Getting all traffic of the same flow on the same RX queue results in
>> higher CPU cache efficiency.
>>
>
> Can you please shed more light on the use case and configuration? 
> Where do you expect the same flow/connection rx/tx to be received by the
> same rxq in a nic driver?

The use case is usually an application running on a intermediate server 
(not an endpoint of the flow) monitoring and reading both directions of 
the flow. Applications like intrusion detection systems or user-space 
state-full firewalls. For best CPU and cache efficiencies, we would need 
both flows to land on the same rx queue of that intermediate server. The 
paper in [1] gives more background on Symmetric Toeplitz (but imposes 
some restrictions on the LUT keys to get the hash symmetry).

>
>> Allow ethtool to support symmetric Toeplitz algorithm. A user can set 
>> the
>> RSS function of the netdevice via:
>>    # ethtool -X eth0 hfunc symmetric_toeplitz
>>
>
> What is the expectation of the symmetric toeplitz hash, how do you 
> achieve
> that? by sorting packet fields? which fields?
>
> Can you please provide a link to documentation/spec?
> We should make sure all vendors agree on implementation and 
> expectation of
> the symmetric hash function.

The way the Intel NICs are achieving this hash symmetry is by XORing the 
source and destination values of the IP and L4 ports and then feeding 
these values to the regular Toeplitz (in-tree) hash algorithm.

For example, for UDP/IPv4, the input fields for the Toeplitz hash would be:

(SRC_IP, DST_IP, SRC_PORT,  DST_PORT)

If symmetric Toeplitz is set, the NIC XOR the src and dst fields:

(SRC_IP^DST_IP ,  SRC_IP^DST_IP, SRC_PORT^DST_PORT, SRC_PORT^DST_PORT)

This way, the output hash would be the same for both flow directions. 
Same is applicable for IPv6, TCP and SCTP.

Regarding the documentation, the above is available in our public 
datasheets [2]. In the final version, I can add similar explanation in 
the headers (kdoc) and under "Documentation/networking/" so that there 
is a clear understanding of the algorithm.


[1] https://www.ndsl.kaist.edu/~kyoungsoo/papers/TR-symRSS.pdf

[2] E810 datasheet: 7.10.10.2 : Symmetric Hash

https://www.intel.com/content/www/us/en/content-details/613875/intel-ethernet-controller-e810-datasheet.html 



>
>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>> ---
>> include/linux/ethtool.h | 4 +++-
>> net/ethtool/common.c    | 1 +
>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index 62b61527bcc4..9a8e1fb7170d 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -60,10 +60,11 @@ enum {
>>     ETH_RSS_HASH_TOP_BIT, /* Configurable RSS hash function - 
>> Toeplitz */
>>     ETH_RSS_HASH_XOR_BIT, /* Configurable RSS hash function - Xor */
>>     ETH_RSS_HASH_CRC32_BIT, /* Configurable RSS hash function - Crc32 */
>> +    ETH_RSS_HASH_SYM_TOP_BIT, /* Configurable RSS hash function - 
>> Symmetric Toeplitz */
>>
>>     /*
>>      * Add your fresh new hash function bits above and remember to 
>> update
>> -     * rss_hash_func_strings[] in ethtool.c
>> +     * rss_hash_func_strings[] in ethtool/common.c
>>      */
>>     ETH_RSS_HASH_FUNCS_COUNT
>> };
>> @@ -108,6 +109,7 @@ enum ethtool_supported_ring_param {
>> #define __ETH_RSS_HASH(name) 
>> __ETH_RSS_HASH_BIT(ETH_RSS_HASH_##name##_BIT)
>>
>> #define ETH_RSS_HASH_TOP    __ETH_RSS_HASH(TOP)
>> +#define ETH_RSS_HASH_SYM_TOP    __ETH_RSS_HASH(SYM_TOP)
>> #define ETH_RSS_HASH_XOR    __ETH_RSS_HASH(XOR)
>> #define ETH_RSS_HASH_CRC32    __ETH_RSS_HASH(CRC32)
>>
>> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>> index f5598c5f50de..a0e0c6b2980e 100644
>> --- a/net/ethtool/common.c
>> +++ b/net/ethtool/common.c
>> @@ -81,6 +81,7 @@ 
>> rss_hash_func_strings[ETH_RSS_HASH_FUNCS_COUNT][ETH_GSTRING_LEN] = {
>>     [ETH_RSS_HASH_TOP_BIT] =    "toeplitz",
>>     [ETH_RSS_HASH_XOR_BIT] =    "xor",
>>     [ETH_RSS_HASH_CRC32_BIT] =    "crc32",
>> +    [ETH_RSS_HASH_SYM_TOP_BIT] =    "symmetric_toeplitz",
>> };
>>
>> const char
>> -- 
>> 2.39.2
>>
>>

