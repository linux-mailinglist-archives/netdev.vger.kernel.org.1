Return-Path: <netdev+bounces-30533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F47787BC0
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 00:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15B51C20F01
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 22:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60797BE51;
	Thu, 24 Aug 2023 22:56:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E77E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 22:56:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7D01BF7
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692917801; x=1724453801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PGtYGYRcz+D9b/WA+XtsQENcS4ImWYDy+XJ2TwcGpas=;
  b=O/+Yr2s+suSA9YL5aU0zaF7fpskXnLFusMZnCE9uy+8yVOcr0MTc6ct9
   gr8MJw2+bb6F6tRLPwBORXtFMU+3i73gYYjtQRfQi9B1RM5vYhUWhjMLN
   VvWgjUNWHP0gbr/C1lTWvY+IMmPunD25Jc1d3J9ragDlZ0uPRPA1JYCX3
   1Ub2fWnTFfU7oZRQr2PwcCOc2nXM9dolmKIQG+IrRGgRFAvwPBZPmbfpE
   UkTzDxoPYSZ9oJmDyQDwfzeck5T+n0ZjWP7bPAGRpZAeJF5VBjOcm67Mz
   /gfls2vwJJZlMxRemfTRKmC2R4vg/BpKBuSEut+otgvREF/m+cAymcN+V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364769140"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364769140"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 15:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714137545"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="714137545"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 15:56:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 15:56:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 15:56:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 15:56:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 15:56:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilBCpS32ax5Plycb8No9xqqbR19lOtdS1RQ5tAmWLcdo9o1R7xJRajq0pQKM8A0ZXOMsjmBTBFYKcqO0wq87axQTLtDuQ5okTLwaLaEp/33zgCnqZlii2KcHAjEox9N3miut6XuqJCHkLLZL+T6Jx8Y5AO7Pj5dckyOmjzjT9EIotrumj8RbEmXiEK085MYbjBEKnyEVFIWrMMG6ItnSbdRVnH0bxl+aR1rfSK6Co2lJDw2kdTbC95M4tcYkxVi4/UEbxvk9H356M6BcZw0lx7DB9ENBTrOo7S99nbMPmUn5vD5opa3es50sTeI3y+CEh26WDGKZRaxKZjFWsqnP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrcYizFkka/nHubQrQc7ylKlIvNagoMYv3DU62/thqo=;
 b=K31DXuLVicIavwc6raElpLRklqHjw+rGJQQDWfy5aY8Mpcv1MRdEVrUxDAA1S/hiF5Tm5wU9dMM+Q05J01VjpoPr3R118iSnkbXWuQI/ZVhGHYol+JnuJ5mZ883TMz8BFouUkKM/hsLzc8u5aks4V+qc7QUczUm3ZaX5MYNN4UeYCvrxRziTlgf6950J0IHHrLXwIB93GOvqbWKeD56z17akJd9rSAOMy8EpGOdPPJ+RvuaCsUY4LZ1vd7zLDWer03+QaCMAeh8odc4Fx56YJkJSM9PX4e+cnAKRATtM1zlXbfYWTyE/owTHCz6SPR5++SNOwm749wZE19PC30ntpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:56:38 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 22:56:38 +0000
Message-ID: <4f0393fb-7f5a-5e91-ce43-4b2d842dd9b3@intel.com>
Date: Thu, 24 Aug 2023 16:56:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz RSS
 hash function
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
 <20230823164831.3284341-2-ahmed.zaki@intel.com> <ZOZhzYExHgnSBej4@x130>
 <94d9c857-2c2b-77f0-9b17-8088068eee6d@intel.com> <ZOejNYJgR74JGRse@x130>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <ZOejNYJgR74JGRse@x130>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abd0e64-7bf9-4e15-9ddc-08dba4f55f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLEsEfL/7LPXrz04s+vVdlv644b8qIbCd5gypoKijaNTf4YvBzZlrS4rlAKQAtSGDE9VyQAIKqRc4XFXbH7FLsl4cYnUOnf5R+etJqU1sSqeBmwNvlBNnyXOcuf/A8KmrGUjAR5pLl5hJ3vWSsBZFsQjA/Q5PVGz2Mwa2aybqkfYa+54gjqs9WvaO+Ya4Hr3Poj1NTMnkvYo9pGfQ724rx0jNHY+8NKYSIG91RAa/k83PKIKYmh07rko1NN4tsLSp6pSMM6l+g0HB84jkQHlX4IaeRK180zPX4zRbKlvjU+tCYe5xhY/7luCkEc0mjoN36N4iRA4lktLq1Y0VZMaGvL9gnPWpr6Cn5aWhsZ0Ki09uBL2NLzJ0ZbFso10MZMaNqr+Bfttquhyg1/M5KeLLon+Ja16NOj/ebbscH2DKUdKNs/tydYgoEVT847TykVoAQrkpDD/IjvyhvyeCppf9uMjxnUhV6RXYp5Yhy2uL3mU3guDyTbZ6M618zTIVRgybuOSHdZw+DZa935itmcN7Y2+UWiailExy/7inxK8z8DxVcO5/xjBMGSJAhY6sAgLU0pr2H76lqUjP/UL3delq4apJ2Y9n+Nm2DVB4nExTt7/bpdetTWKwuzIgWBXFNIuOt6ftopjlVAstR6hWKrgXdbAHs1txlr1u2wZraWJlCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(86362001)(31696002)(2906002)(36756003)(6666004)(53546011)(4326008)(82960400001)(8676002)(8936002)(26005)(6506007)(478600001)(107886003)(2616005)(5660300002)(31686004)(6512007)(41300700001)(38100700002)(966005)(44832011)(6916009)(66946007)(66476007)(66556008)(6486002)(316002)(369524004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFVDSzNBRXo3Mjl5L1VvQzVISXoydjhjM3VOQyszNWxLbk1BbzJER1dhZXZV?=
 =?utf-8?B?eXF5bTZGS2lkb0dHdDMrUmFZa0NwbDRxS2hyMzZGWWNJNDFLZHJOa2JzeVo3?=
 =?utf-8?B?K3BHWUhwdlFZWXhmenZvSDZNcHRFWGh1djNERzQ0UlFuS1RUekgwZWI3WlJa?=
 =?utf-8?B?YjFQSUxBYzBWK1V6N3N1Y0hlSFNVU29ONzVMSUZVZW9lNXp1V003V04wRGxS?=
 =?utf-8?B?cjNGdEFjbkVnZTFUMmkxQUpzS0o1OTlVdUpwZm52WlB0d3JmSGI5SjJEWTBy?=
 =?utf-8?B?S0djKzU1OXBNN2k4WUdsbTJRNW4vRHpEYThjRTJKTXMyOTlWRDdvWHppd1pY?=
 =?utf-8?B?TW43OFdoMGpBRFdyL1pZZ0VBdFM5cXdDZFQ2TGZjWStxZzZmMUpaMGlKeWRQ?=
 =?utf-8?B?ZkhQejFFTit1QXVTVFc4Nk5qMC9nRHR3a3hQNTVQUUt0VEJyeUtaT3pOaG9K?=
 =?utf-8?B?WmVVVUZDQUNpQ3RsVDVjOEQ1QkJvV085WTNhNGlsUlB2SGU4azdtM1BURGkx?=
 =?utf-8?B?WFd0Y2oyaU1PMjR4N1lzL2pTZHU4cmlXSGFIUDV5S3R4TzM0OFpWMVk2YVJI?=
 =?utf-8?B?L2RXNU5lQzlkbDNYRzVKRmJTUHBHUXhqMFdnVS9ReXhERDMwdzkwMlVRdHcz?=
 =?utf-8?B?d1cwN1ZLZnBnTUZyREVuZVJ5d1lwNkd1QzFZRkxzUlBlaHcxam9wM3hOQ3Yy?=
 =?utf-8?B?SjFza3ZHSnE4d045akQvZjhEWjFmOG9FVGEvby9nNDVLSzNFcS9EQThCa1I2?=
 =?utf-8?B?REpNU1RTY0xrUC95Q1VpWFIyNEZZVVoxd2dCUmlnQno5c1Bwc00rZllVM3FM?=
 =?utf-8?B?QmVSYWtQNS9jUUo1bFZqSXZ6YS9JYzl3TXVWc0RkYzhVbWlrSVJCTFFmUHhk?=
 =?utf-8?B?cEVEN0pjWGl6Z012dFFzYlNhYWZuSGlyYUNwMk9kTlIrSmgrblZIUzd1VDRD?=
 =?utf-8?B?M3dlTm9QL1E2b0JMTlB6TFlocEkxUlI1UndUYmQxU1ZEaElIY1VNTzhIamds?=
 =?utf-8?B?MEJEUE5PbjV0NjZHWWF3YmdCUlFJT1M4MzNtV3lrck9WbG9TU2Z4WDFUOHQ3?=
 =?utf-8?B?c003aFJNbW5JdmdKT28wUFhSbUliL3lrZ05taFpoSEZkVkQySURDSDlCNlE3?=
 =?utf-8?B?RG1Gb3d6Q0NXbVJmOXFVSUc3VXBOOVlLTlEzZXA5WVN2c3JFM3UxRnk1YklH?=
 =?utf-8?B?SVZ3c1ppa2hmaWU3VUJOL0QzUlNwMTlWa3hLNlZYTys3ZXkvNWtsMUxSbTUx?=
 =?utf-8?B?WEJJTTdnWjNqSzlIWmFETFN5VmRmajB3Y1RianlzaTBVV2hHY3hZVkdCUHJE?=
 =?utf-8?B?N2Uzc0FpeDR3QWd5TEx5S2xNVTh4SlRCUFg0UDh3UG5wNThuSGlLZ3V0dDF4?=
 =?utf-8?B?WjF0RDQzTzVBdm94aGRxdldlNzlmNE0vQVVLU3pyR1R3MTBIaXlZeThiUFpy?=
 =?utf-8?B?VU91bnhldzZ2bnVRY3JvNlk5amR4bERUSzJGVFZpeXNlVjhiaUtWQklVcHl3?=
 =?utf-8?B?TDZyQUhrOVBhbVpFTjFncTVTaDFDQkZYSFlOMUlIMXpmOHI5eEJrQ1V4Mkxi?=
 =?utf-8?B?dW12akxMVHo5RUk2eHpaeVYwdGwxTkIzL0EwMDlJN2ozTHFUQjZ5RW9hcGpC?=
 =?utf-8?B?cmltUWZOcitQb1hJc1EwZGQwNkE2cVJLWDlRbStVZG14ZVVnMVRJUmpJM0xB?=
 =?utf-8?B?Ui85bDJVVk9MKzdVdDRkVldNTVFHVklvWDJUa2YyMUloUXN4UnZRODFTRWhl?=
 =?utf-8?B?Qlg4eEtXdE5xVnczRWx3WUFwYWpLditUK0N0TlZTWVQwZXYzaFZrUDlKWTVj?=
 =?utf-8?B?YVJ4ZXh2WU9sajdMemxSUzB6WmVtdWh2V3R5cEMycU1pRTNRUFBERHhMM3pJ?=
 =?utf-8?B?T3g5blNxUWh3dU9VWGhCb3EwalhsWEY0ZCtwK1JRSm1iaWY1dlRnRUhOZmRN?=
 =?utf-8?B?MVcxcjVKaEIzWmI0QUloS3Rqc0Nxb2xGRWhrS3dFQ1pKb3JIWkloWlkwQSto?=
 =?utf-8?B?WEw0UlhISk1VSGoxQzY2bTNCVk5HVUNJSitmMHRvRUZYT01kZjBVNVI1aTNC?=
 =?utf-8?B?d0hGQjd1TkgvbTZoRVpKbTFxQ0Y0Wnpzdy9EZ2pUcGc5WTE3Y0c4eFFGV0RC?=
 =?utf-8?B?bkFOUjhLM2xhSG5oWUhWRU9kcG5ZUGdySGU5VlNZeEVLQnoxSklJN0JFcVAx?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abd0e64-7bf9-4e15-9ddc-08dba4f55f88
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:56:38.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4a4z3oPNdloIgEry+TbSAo2/bMttemoCYyE3P+sjMWzmUy+wECqwUHtjgUuY9ubtZyMLp7XIAAXpTyWc9fMyPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023-08-24 12:36, Saeed Mahameed wrote:
> On 24 Aug 07:14, Ahmed Zaki wrote:
>>
>> On 2023-08-23 13:45, Saeed Mahameed wrote:
>>> On 23 Aug 10:48, Ahmed Zaki wrote:
>>>> Symmetric RSS hash functions are beneficial in applications that 
>>>> monitor
>>>> both Tx and Rx packets of the same flow (IDS, software firewalls, 
>>>> ..etc).
>>>> Getting all traffic of the same flow on the same RX queue results in
>>>> higher CPU cache efficiency.
>>>>
>
> ...
>
>>>
>>> What is the expectation of the symmetric toeplitz hash, how do you 
>>> achieve
>>> that? by sorting packet fields? which fields?
>>>
>>> Can you please provide a link to documentation/spec?
>>> We should make sure all vendors agree on implementation and 
>>> expectation of
>>> the symmetric hash function.
>>
>> The way the Intel NICs are achieving this hash symmetry is by XORing 
>> the source and destination values of the IP and L4 ports and then 
>> feeding these values to the regular Toeplitz (in-tree) hash algorithm.
>>
>> For example, for UDP/IPv4, the input fields for the Toeplitz hash 
>> would be:
>>
>> (SRC_IP, DST_IP, SRC_PORT,  DST_PORT)
>>
>
> So you mangle the input. This is different than the paper you
> referenced below which doesn't change the input but it modifies the RSS
> algorithm and uses a special hash key.
>
>> If symmetric Toeplitz is set, the NIC XOR the src and dst fields:
>>
>> (SRC_IP^DST_IP ,  SRC_IP^DST_IP, SRC_PORT^DST_PORT, SRC_PORT^DST_PORT)
>>
>> This way, the output hash would be the same for both flow directions. 
>> Same is applicable for IPv6, TCP and SCTP.
>>
>
> I understand the motivation, I just want to make sure the 
> interpretation is
> clear, I agree with Jakub, we should use a clear name for the ethtool
> parameter or allow users to select "xor-ed"/"sorted" fields as Jakub
> suggested.
>> Regarding the documentation, the above is available in our public 
>> datasheets [2]. In the final version, I can add similar explanation 
>> in the headers (kdoc) and under "Documentation/networking/" so that 
>> there is a clear understanding of the algorithm.
>>
>>
>> [1] https://www.ndsl.kaist.edu/~kyoungsoo/papers/TR-symRSS.pdf
>>
>> [2] E810 datasheet: 7.10.10.2 : Symmetric Hash
>>
>> https://www.intel.com/content/www/us/en/content-details/613875/intel-ethernet-controller-e810-datasheet.html 
>>
>>
>
> This document doesn't mention anything about implementation.


It has all the info regarding which fields are XOR'd using which 
registers and so on. The hash algorithm itself is the standard Toeplitz, 
also on section 7.10.10.2.


