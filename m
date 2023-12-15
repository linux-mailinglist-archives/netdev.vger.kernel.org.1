Return-Path: <netdev+bounces-57853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 159AA814538
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E771B227CC
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B44B18C2F;
	Fri, 15 Dec 2023 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9+jaXVY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E01A700
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702635192; x=1734171192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AbT6YwFLrBJkubdfiGfejYEpQpjD4CzYjpPYeJx4L04=;
  b=U9+jaXVYALv5y4zXZtFEq79VvaaPd79AueFfl4xY3A3uegeN1zU8TIsw
   pDekXz3PfMnymmJtYjy5WMJnMMcnoFiMdH1sZ8p6lXOLwB+7ch9JTXfzn
   WCQzBia5HD0ByQkLoi6ICcbi6YKqVKcwGwpzsGfbcxbpliQNT68Bn+FO3
   D6bsvZ1tdXNgufTgcw1+z+Z6P9+1Zcjtqk6SkAbGPMPrkuZq/lutoZOfY
   8nNifCsl0vhvi+W8hwghsEWAcJS07B63rXPdrSGBv/xd6x5XMHt4CQxMx
   lPL4t14QBxVCZn0RRLY2xMv9MTES00po6eWpvlEnr7UspRDO+dwXGbzhc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461719591"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="461719591"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 02:13:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="774720445"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="774720445"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 02:13:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 02:13:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 02:13:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 02:13:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhcApND5ViePCW2xmPrLExXz16eaTvnQnYKRsEmuCUrFCIxu3dR2OnVqEfQ8UmheGLeE1q/Hm3fjLuJg+hkeEb26FFWbVj3tPA4za3QfKuVbccA5Z8CCWP+D+pG2hL8XBgyxmOZOV8DMhwKcB7dD0vpNtVf3xzL02Znd8lwL6ek4zDkkE3UmgpjtewSt14qSeKQGUEa7UqREMDmnYinQta8M4j5FOPiK79yVUiVRU+rIxtvEBn86ivuXKZKzyi3TdAbVSMxLaqbRb3GykzttYYhDSJBaytOZd7HX3NyIXr8eP+cogT2YODczx0crLRlOwU1iGSn1TGL6TxKvNpAVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmlxaUPJ0UFgl3sGNBT1eZHot/h70ac3V5Z7ZLkm8Ug=;
 b=App6CZd0QxWJ2G4bJoHEt4xmeq3LDUTYaj/WQ2USI2DtC/ubvkAEDGb7NF9eL1cIpDqf9/A0rlQunZjAG07G1HGliMfcVuzZuuW/PxGRXgPECjxVzEG2dqk9zUE/JST3hxzDuAFhNsEnq4QsRvb6I3tnJ0JViIbVs3RhGvEqBd1JDhPxYoVl67hmpW86zfDaDef0GQrk3osiRGMDm1g1bxVU3zWV9d2CyOTIo0ymZbanXs1PqWWW+rU1K6v9O6nPOMZKJujGhLI1hBMHuEVyxh7TGcL4dvPgDhHPf3B5jhIMVjYYHye5gSO8PoUXfJQlEeuIlKBtS0MzCeBVq3dBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW4PR11MB6958.namprd11.prod.outlook.com (2603:10b6:303:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 10:13:10 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 10:13:09 +0000
Message-ID: <67e287f5-b126-4049-9f3b-f05bf216c8b9@intel.com>
Date: Fri, 15 Dec 2023 11:11:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/7] Add PFCP filter support
Content-Language: en-US
To: <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: Marcin Szycik <marcin.szycik@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <andy@kernel.org>,
	<michal.swiatkowski@linux.intel.com>, <wojciech.drewek@intel.com>,
	<idosch@nvidia.com>, <jesse.brandeburg@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<simon.horman@corigine.com>, <jiri@resnulli.us>
References: <20231207164911.14330-1-marcin.szycik@linux.intel.com>
 <b3e5ec09-d01b-0cea-69ea-c7406ea3f8b5@intel.com>
 <13f7d3b4-214c-4987-9adc-1c14ae686946@intel.com>
 <aeb76f91-ab1d-b951-f895-d618622b137b@intel.com>
 <539ae7a3-c769-4cf6-b82f-74e05b01f619@linux.intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <539ae7a3-c769-4cf6-b82f-74e05b01f619@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0427.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW4PR11MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 132d54fb-7b3d-4e66-43ed-08dbfd566fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4XK+h40kqi6OXhGV7M1ptovQx/qRYTZaop81mRfxYOOXY+Q5378XVGlIIXvp3Vmdm8ufPGC586gBPxgdF2kxrLadUdWHKidw1w+4iC4JOOskvB4XX0VsavtKLF3muydXRW2bD9+uUE+aEnGiMYQN1lNPQTHtvWgJNId9CqnsEJXBGF3ZLbYU3ImpSBSQieH5i/HmK1ngxBgpsu0dq7JqK8KfzZQrdC6DNKstt23ok52AFSh8olaG8wlKdu3FGtPp8I9VgBgw2Ioz4GxqESFLO9c0bbyWRiZBD4q+WBY90FlR/QyETsZXllBP76pscow0vzHSulHZOPNN3id7+J88qyb6ExaDcom0G3dWRXvH1bBjWT3LKURIW2WdxAeexdMwnXIHuWgpQ3FSYZX7+eMENj20IA90UFtp1K1U8eppECHWd+OIiOcyhnpxPbiDPWc0DwXzWqKi9if2RbuYbtYpRmGRNl5Ltt2P+RVqoKKZLYtkwkWyOjG3BtcEU/Vjg8Uun4s24Nn82qKQCwQO+NITPS9zqZnVvEX5mwizx55Jtxjrz5NAGY8g6M40i8y2EA7LQFmRjlYr/5tRUDgoae3/p/asO+TjgeccmW4hUtPAvSdo1ZKoyTSmIp/+2vhdgzXLQ9CXU60a+235vQFW7lrzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2616005)(38100700002)(31696002)(53546011)(6512007)(6506007)(6666004)(82960400001)(26005)(36756003)(478600001)(6486002)(966005)(41300700001)(66556008)(66946007)(66476007)(8676002)(8936002)(54906003)(316002)(4326008)(86362001)(2906002)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdKUzBxR09PWTFMQ3J0M3FvcGFQVzN4SjREUmdHaE1mSzAwd2J3NEgwK3pj?=
 =?utf-8?B?U01BSys3SkNDV0RyYkJLSUxmSDQyUHhzUHprSm8vZU56OThCUVJvVHRDOTA0?=
 =?utf-8?B?NHlOZXBJYkFOYzRlQ0UwK09zRWtyWklKelNyQkVaV1YyRmZPYTNjdkx3SzFU?=
 =?utf-8?B?bld4cFZkSFoxTFRsQTZNOHlzVjFqWXZyY1BSNmNIeGJONFNoV3ZQNDZuVGVw?=
 =?utf-8?B?TGlNQ1I2c3FaUEd1MWhyTzU3TG9VNkhuaEMyWmIrbVNrZ3B4M2lIQ1RKUVg2?=
 =?utf-8?B?MTg4bmhhYWZkVG02bDlUQlBxV0lTRVNDNFJnU2VRMU4vYnh4NjlpYm5QalZw?=
 =?utf-8?B?ZEowdXVPS0krYmlWVWppdktiOGJmS0VmdnF1c0xVVks1N2ZjMm9CMkZLSE9s?=
 =?utf-8?B?NnJodjc3V1F4QXU3cmJPUG1haDNVRUQ5dWhaNThqMDZLRm5oTXZ5bk95Nmc1?=
 =?utf-8?B?L3NYVGlvZ0dvQUVQWTdmY2VIVlR5TzVnVitTSWhiL3lJN0Qrbng2OS9BVVRt?=
 =?utf-8?B?RC9iMnVkcTMyRUdwZmZJWE5NVGhZTFVSMERIaFlmN0tPaWZya2pSa004SGhR?=
 =?utf-8?B?MWNpWkJWR3JLUFZ0dHFFRmUzWGV6SExLRmJHaEZ2eTQyWDFFS05lRklyeE1u?=
 =?utf-8?B?ZDBKZi8rMWlYVjdoNTBtMHVNRXdIdEkrRitmY24rSDViSHFTVG50cW45UTNZ?=
 =?utf-8?B?dS9rZnl2NmZMQis0QTY1NFNTWjBjSCtPZ3d4TVN4WnFUSmpSclhJVFFUMytr?=
 =?utf-8?B?L1krSnF2Z1VnNVR6UktXSU9SWTFTaW5qWUVVS3NBaHZiSUJKbk14eUtqcmVN?=
 =?utf-8?B?eG5uMjFza2NIcFhudk5tYW9WV2tnSHFvelF6Y3l1QlBhSWE3TXBmZ1lHelN0?=
 =?utf-8?B?T2JTUC9LeFg5TFp3UjIwTFFFSWxSOUNWSEFwcnhNSDl2aXkyNHJ1YzBjc1FM?=
 =?utf-8?B?OEFWa0hGKzBoQzRnNzEzcHppUkxlRjlmeUxaYjBnOXozaGlSM0RsK0JPWlB5?=
 =?utf-8?B?TWRtRldZWnRyeG5xS3MwSHphbzNFMXJHNFBGbHNacVZHemYvbG1kRmdCVVNS?=
 =?utf-8?B?VEM0Y0RjeUZqZkF4Zlc0UkxYWWdsRjB2T21vSTZxRjlIV2h1cysydUV3ZUdN?=
 =?utf-8?B?UmM0aDJaVXZqWG80SGtTZ2MvQTVkdFIwTHhWYUFGdFlPaDQ3MzcyWWJtejJw?=
 =?utf-8?B?VEkwNmMyTU44bjNqWTcxUTgvVDJkTDMwKzB2ajV4a1ZGOXpzL2MvYnJlaVRE?=
 =?utf-8?B?YWVydUJNUGZPa3VGK0xydVRabGVsdXByTCs1V3FVVzFXSHhtNXhwdTdCWTZs?=
 =?utf-8?B?M254TGROVHY5dCtWQi9kdENPQjRCa2pLdCt2SjVaWmVyMXU0bFhwZkkyWXkr?=
 =?utf-8?B?SFRPejZPaEdxdFk5NkJpWm81VTgvZG84Qms1NWpyZW5NSnM2SWE1TW5vNFJB?=
 =?utf-8?B?NFpoRmJNNGQ0Z3NnMC91Q2ZYcjdGMHZIMXFjL3g4T3VLTFZiWE52UkYvNWU1?=
 =?utf-8?B?YkhFVUxHRFppM0xKK1RKT2lPclNXWEVpNWd4ZVpqS2tMZG1pa3h1RklxS253?=
 =?utf-8?B?eUJPZjdhbWZzS3Z6ek9FcHI0cVhsL2c0UkM2MmNNaHdiYlptTmI4bHlCM01i?=
 =?utf-8?B?SlRTQVJ6Z1QyL2Y3WXk2RXdkK05wcmpxelhQbitoTTZ6ejNReUI1T3NaMEpG?=
 =?utf-8?B?V3Qvb3Z6aDNQaGJyVVRQZkl3TXZEa3gvVVd4SGNCTWZlTDFWRTRraC81Z2JI?=
 =?utf-8?B?aVl5ZXBEZk41WWlTQmE3R3ZaRTBMRTlRZys1bExRZVZXWWJMN0hlL0VPVEM4?=
 =?utf-8?B?UGlQdmlTMm5ZVk5hWUFmMkY3dWRIY3pxT0RpUFJNTWtnYTR5SDdBc2ZKaThO?=
 =?utf-8?B?RStCZVd5U1JRcWRaVWNhM1VYc0FHaFh4OEJyU1ZRaVN6VGNVdXEzelYxNTdK?=
 =?utf-8?B?MVpPK0R5emhFTmgyT0xlSFJSUnEvTEJuZTgzQktIa1dOYjZaL201N2RLNnBz?=
 =?utf-8?B?MDdVVEZYV3QzUm1LUTZqUU1PRU9ERFRvaFdIV0Z0Rit0V3Q3ZXp6MWdYQlZW?=
 =?utf-8?B?czhmQ3E1TWJ0Vzd3akVqMHJOeG5pNCtnOWRFQjBsZnl6ZFd3ejdLaWZUbUxH?=
 =?utf-8?B?bWRJUDVqeXZEbnl5NWpSWWo1cjJYOURLWFdIY2dPaXlVMmlTZlZDRXBmS3Bw?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 132d54fb-7b3d-4e66-43ed-08dbfd566fe4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 10:13:09.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R3EZrT3M0GBs6fLyDx2YrldSF/f47ctngjvM0VM5SCvty01Az6+t1SS3APgKbHEWG+c2byDQtJlGo+GEjORcDEbHjAxw/JJbOBT83DXhPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
X-OriginatorOrg: intel.com

From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Tue, 12 Dec 2023 11:45:24 +0100

> 
> 
> On 11.12.2023 22:23, Tony Nguyen wrote:
>>
>>
>> On 12/11/2023 4:38 AM, Alexander Lobakin wrote:
>>> From: Tony Nguyen <anthony.l.nguyen@intel.com>
>>> Date: Fri, 8 Dec 2023 13:34:10 -0800
>>>
>>>>
>>>>
>>>> On 12/7/2023 8:49 AM, Marcin Szycik wrote:
>>>>> Add support for creating PFCP filters in switchdev mode. Add pfcp module
>>>>> that allows to create a PFCP-type netdev. The netdev then can be
>>>>> passed to
>>>>> tc when creating a filter to indicate that PFCP filter should be created.
>>>>>
>>>>> To add a PFCP filter, a special netdev must be created and passed to tc
>>>>> command:
>>>>>
>>>>>     ip link add pfcp0 type pfcp
>>>>>     tc filter add dev eth0 ingress prio 1 flower pfcp_opts \
>>>>>       1:12ab/ff:fffffffffffffff0 skip_hw action mirred egress redirect \
>>>>>       dev pfcp0
>>>>>
>>>>> Changes in iproute2 [1] are required to use pfcp_opts in tc.
>>>>>
>>>>> ICE COMMS package is required as it contains PFCP profiles.
>>>>>
>>>>> Part of this patchset modifies IP_TUNNEL_*_OPTs, which were previously
>>>>> stored in a __be16. All possible values have already been used, making it
>>>>> impossible to add new ones.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com
>>>>> ---
>>>>> This patchset should be applied on top of the "boys" tree [2], as it
>>>>> depends on recent bitmap changes.
>>>>
>>>> Is this for comment only (RFC)? This doesn't seem to apply to iwl-next
>>>> and if this based on, and has dependencies from, another tree, I can't
>>>> apply them here.
>>>
>>> It's not an RFC.
>>> The series contains generic code changes and must go directly through
>>> net-next. 
>>
>> Should this be marked for 'net-next' rather than 'iwl-next' then?
> 
> My bad, sorry.
> This series should go directly to net-next.
> 
> Thanks,
> Marcin
> 
>>
>> Thanks,
>> Tony
>>
>>> The dependency on the bitmap tree was discussed with Jakub and
>>> Yury and we agreed that the netdev guys will pull it before applying
>>> this one.

Ping? :s
Or should we resubmit?

Thanks,
Olek

