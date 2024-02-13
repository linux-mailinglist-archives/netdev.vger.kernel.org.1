Return-Path: <netdev+bounces-71123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DCE85269D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0311C24EAA
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E522627;
	Tue, 13 Feb 2024 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX0BVzIS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855CB54773
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785843; cv=fail; b=HwRixjayNx6WcCziXA5/f1TOe5av4AoOjvGU1PgmtjMK/NGWqGkAHs74EkuifxwHyQZyp02Y4rrpygjhnwijWCW9Brn4SnSKy75z6m9SmuPsmgyQaz6UoudUDQkJhKXTH6o3II8OOmldSXRIOWMk/QBZBMwCwAPnEj0LtGO9xpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785843; c=relaxed/simple;
	bh=hJIrWP5WKRrzT3XjyaYgVuxomSyNdePBsBxp4yBjfys=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OFaJkcc31d8NDtrqoRyGjMQimudCFJ75FXxMQX06T15HmHHk2r4T09/rrUmS5BkewH/XHzKSJYrOneDsMVn+HpQIAlf9ozM1uGmJQSvEEZX0TJnBiGiW0LkHHTKHT/3Xm9kyV2O9dyQvkOLshBCaEBv++vN/y0sqIZWC5Sy9krY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cX0BVzIS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707785841; x=1739321841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJIrWP5WKRrzT3XjyaYgVuxomSyNdePBsBxp4yBjfys=;
  b=cX0BVzISFPBDkWX38oSpTMgs19PfrQADO8frpw2KKEPLxi03jfQZXKqH
   okuq0mN+qZLHNF6ye70YD0CV5yPSv7w6u3eZk7xlnqUcZ7N4GxkKnFWr9
   OGrKjzomQ5PmOt6kaLT6v/Nh6pymuEFbeeeTE3PqAh9XIJe0tDOOkDJ2U
   dlFymw9dh3icKIkgjfkPlWOs6FcFNR6J/WJS7SnaHAnfyBNAAjbpFiCLu
   BxykIxsMD3OLuslQqAgHHLor4L0yno/UEUmWahIvMJfyLg/u/LnC+tIYG
   ujSsEK9RAH2J2EBiolO/b1hcFtaCoxuoGhsn3y3G2Ukv61LvKDrLNBS2Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1935899"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1935899"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 16:57:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2705149"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 16:57:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 16:57:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 16:57:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 16:57:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORLXDl/5mXXW8LBDvc3um6y9r9MnuIjvCUiKoIEUP98v+rEvSygt/4CSZ1pPLdh0zlV0EURZjfpRUVHHYephtP4eOCY7xz/EB85gNkbxxydH2UImbV2ozNAsr+vdgP6CuoFkoqUYggCqA92GujCC91bTCen4wNNlGuDrxEqJqevfu4tbvyrzC968+dLud1oGbWQ+0aThlqPac/m8zVHNLgzFgKK5jaCE2R1PLwzcC2n6y0JtrHKvkrIVlhjSyVjz46DAzY8mQK1Qirzb2DZd+j7lDmz4jo6JjblAYR1TSoppBLbRHddJlRyfWyTksO8coUU9R4TesdfeU7VghyWsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQrWxpbwNYTnExPybS5yjXt0MaUUC+TF/JKdfotRo7s=;
 b=Y2QpPDxsVKUD3MVPkztzB6LiJkzNqMpRyxbJN9Ne2x+/ubaISv0ZIcqv/nHfZXlwaaBIFlgOTP3BVnUPwqh8H82vW1jISMyBXPwZ9cEtYuHckHqpWXto9RHl4S10hyLueS839W0vq27ouYO9Naa1zApRt2Mv5ww2HrMnzU014zhb2ZFAx4duRSfzeabzJX5hBcXnEDbObOAxxwLNpj4IxLUcgMKvLKyl7F7JgWUdirlfhsbHnIsCTYrFsWQXrGKC9lB9yBfs4PRdfRHn1QH6rgqBxDrn2xTHYoaPKwrfFw69mXC0dEpVH1b9uCmlT6jfsUGKhqeemvxSZsNiLQyuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Tue, 13 Feb
 2024 00:57:12 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83%7]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 00:57:12 +0000
Message-ID: <4be69e7a-63f3-d920-9b4e-49c3682f6b2e@intel.com>
Date: Mon, 12 Feb 2024 16:57:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net] i40e: Do not allow untrusted VF to remove
 administratively set MAC
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Ivan Vecera <ivecera@redhat.com>, Simon Horman
	<horms@kernel.org>, Rafal Romanowski <rafal.romanowski@intel.com>
References: <20240208180335.1844996-1-anthony.l.nguyen@intel.com>
 <18049617-7098-fee3-5457-7af2e267b0d0@intel.com>
 <20240212163717.14dc15f5@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240212163717.14dc15f5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:303:b5::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM4PR11MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e7df14-0fa2-4e61-5f0c-08dc2c2eb62f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWiBpwQyMZLQvP4fbbKcu5MhXN8jvgrS8fTgvS6uH6JvmTVoD4JNOiar/NuVcUKqExoni8VHts/I8Zs4ZcZmHj9nNaFard8X5YEedaEoum4MgbEJPKGa9CPly5m/r2HNiTdziu9lu7GtX6uVa14E5zo8Dpy11wQEoyOzod/4fsvG3J9XwBHF2+DQAA7go0yfSeMUQv12Z2GpUj8SsWN/5jLvBQIl+h5fLNbnmib4pciMbJyrbupib+U5Kr6NEz06Mh6eqFYQp/CvGyo8guOwChLgjTjEGHxv5iSO3AoYJP9mQHmXKK6sTTZaFSVPaweP7Vbf/zSRQiLElRVL1Zjj2FE82hcHqhFiw3077bW66xylaFCp2oCM28bP98qqO0lbNPnPTdANJgtkqzyDCdOHje4fzGX7YWgxNHzyU7syjCzEGVUTKgSdwrppq3J9B9w0TzNU5t9CR0SEEDDqPaJsW2/9RxRy4zioQ5M6EPCks6/wWBB07peTQzZm0FOPWseIcKNyBETpYr+loUqlYif6400ZlLXsu9VedsJQKoFBYLbmrD3bynvZCLVjXUh9XN/S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8676002)(5660300002)(4326008)(2906002)(4744005)(83380400001)(26005)(2616005)(107886003)(38100700002)(36756003)(82960400001)(86362001)(31696002)(66946007)(6916009)(316002)(54906003)(66476007)(6666004)(6506007)(53546011)(66556008)(6512007)(478600001)(6486002)(8936002)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWh3dXZMU0ZGV3p2RkVvdjVTZlUrdCs3TC9BZU1GUWp5UFVGKy9IUXZ2eno0?=
 =?utf-8?B?RG1UMndnQVd4RHdnOXZXcjhJWDE3MENaemVFYWE0eTdLNGdkVzV6N3ZndUQr?=
 =?utf-8?B?dFdaUmJkQlBmSGNXajJFR1pxZU1odUVFSUhsb1B3V2xyZC9rN2ZmNGpyeGxG?=
 =?utf-8?B?bEovNSttUXhZbUhKZkpmNEh5b25mR1BuUU1hNXEzOFNBaGNBZmRtSnNCZWVs?=
 =?utf-8?B?OExUZEFCTmNicnJ5T2ZmQ2xkakJZUjkrTHp3bHZGdUM1elhTeWxjY01WYUYz?=
 =?utf-8?B?VkwyUC80dm1yNE5RTEdxMTZRRHdzazZ5eWs2cTU2Q0V5bjhhdHhnVXhnWmF0?=
 =?utf-8?B?UmFNR3VNY0JzOWJ2MThQUWNHeG1nbEZuYWo4TmJseWhmSW4raWVFWGJ1UmZO?=
 =?utf-8?B?Z0JIbEduUjBhTThPckVycnNJZlRIWCtpZEhUc0pvQ3FNOUVSdUlYV2tIZnJ4?=
 =?utf-8?B?MGttN2x4dmtxQTNUd1ZlSGRxdXJqQ0tkbWNUTE5HSGNlVEhOcmg1bnZwak5G?=
 =?utf-8?B?SjIrNUVXOHFZSGo4b04velpaMjNBbFQxSm1FYWhoN3dEVmNLRmdWNHN4Um9V?=
 =?utf-8?B?RWIwS1dlNmIyNXM3Ty9zdWpId1FNOUsxMzlqVms0Qi9IV2h6aWY1a3FuRXUz?=
 =?utf-8?B?WVM4NUZrSFlSaURKTW8vdGNkYUZYQlczT2ViUVlFNFlXNDFLQXduTDlXUVN5?=
 =?utf-8?B?eE1FVWZaUmNFSVh2VTFrMU9FaWRRakhEWEVueWZwVlFuOEZtTC9WYUp1RlBq?=
 =?utf-8?B?UElrV2s3WGVKZXBoa3hnbXRqT2ZyNExjdzRoRGw5YmNaeTZVYnVlaVMxcytF?=
 =?utf-8?B?UEZnWHF4b1BQYXdBaktBc1FUNy9LM01FUVRIa3pHZWMweWF0T0gxTy9aRDBk?=
 =?utf-8?B?d3pINnlLdUFSN1c5dWswVGtIT2xVb3ZaSitjeERXeHJCUFJ6by9PbmEvZ1Zr?=
 =?utf-8?B?emdqeStJcXk2TkhaUXc2UVJ3M3M1M0F0T3BhWCtvRHdqU3NZdGwya3Fxa3J1?=
 =?utf-8?B?OUNtRE5Bem9OcGlCSzhFNUVESzFkUisvcjM0aldXZXVIdlhVWGNaL1Vyd0Ry?=
 =?utf-8?B?dTgvVFBSVnNtYUs2WjhPV3RkVkdFVUxyN0NIM3ZGckJvU1dWZHlVS09memZj?=
 =?utf-8?B?UGVxd3dIUUo3S0lOWU9ML1VNMW5TMFpmRm1qVlJEaVdsSkRhbE5USEx1Y1pC?=
 =?utf-8?B?b2FQekhCWlF1TFNlcFF3OXNSUXZvOVVaQ2RITHlrSEU5U1lOQzlSUmJvanpK?=
 =?utf-8?B?c2lEY0tsbC9PMFR0dkZUSjMxaUo2ckI5VThFMHZVNC85N3VrdHV4amZGdEw2?=
 =?utf-8?B?R0VBa21PWkVKWUpOZTk1eGhDbjYrbWQ3ZlR0ajRUSlhMdSsxSCtkcFZxVEcv?=
 =?utf-8?B?K3NIQXhiS1FNU2RLc0ExeDJQYmQ5RXg2dEdFRkkyckpMNEU1emF4aDhLbzI0?=
 =?utf-8?B?bjZDZUcydktVYmRteVBNWng0OEE5dk5ZR1RIOUZURndIU0F3TkMwNXpXc3Bv?=
 =?utf-8?B?Q1N3TWNBeTQ4VUo3M2RPQ3pUMWVnWDJ3dG5UK1VPZnZoekRuaE1helBiK1pp?=
 =?utf-8?B?S0xMcHBqOWloYzE4RGs0M3hRZ0kyN015VTJIUXpNMWs0ZzJ6aXpka21ZTDFs?=
 =?utf-8?B?bmIrSGpRTXRlYTdmVGUwN2ozRTZDdzExQktIT3dnQitUVjcrWUtjYytRSlJo?=
 =?utf-8?B?RkJSNjdhMnF1VVRCU3hReGw3R2NVL2dQWnNsSjk3ZDB5TTJaT1lJNVpobDV3?=
 =?utf-8?B?bFUzb3pKRGxISlFKY1J2WllKWHZ3WUlocmFWQ1NGc0FEVGVaeWJjVUhaYTN2?=
 =?utf-8?B?V2lJNTZHYzZoRXZ5b3hXNWRDTFRwQ29xWDNtOGlyVzVyWXlUVUNhczlULzBw?=
 =?utf-8?B?NWhhVjErR0tycjRoemZYcGpEb1hpUzF0NWdsQlB0RkYyd3NMcHdHSGpCWHZN?=
 =?utf-8?B?c1B6WFMzeXNRODBYMWJuTGRHN0tIOG1yQVdlMnVjQXZCVG5ORXppNHp4WWp4?=
 =?utf-8?B?dlhqMy9ucEJIRVVPMFZid3VmK3FtcEtWanNhOGdTV3ZlbFNjbC9YQmNTTGZy?=
 =?utf-8?B?clQ4NEFNMmN6TnlTQVBTT204a0JCNGIyZnNzZXJqaVZhMnZFd0tUY2RsbHBC?=
 =?utf-8?B?eW9uWEZ2T01FeUVNL3dzMG5PWnIyeWRESXB1VUxIMGdqTVR5WnJqZVBnRFM1?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e7df14-0fa2-4e61-5f0c-08dc2c2eb62f
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 00:57:12.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkV5D0A/Qq1AvhvbuB5hL6AxwOfUzjgmA/O0jvUgYoOGGd3aqkiM1uOmvZIuGtBleBJXIKr/dpWD/n783aJf9HQ+C+BFXd9+93jmi6OAhOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com



On 2/12/2024 4:37 PM, Jakub Kicinski wrote:
> On Mon, 12 Feb 2024 10:11:44 -0800 Tony Nguyen wrote:
>>> Currently when PF administratively sets VF's MAC address and the VF
>>> is put down (VF tries to delete all MACs) then the MAC is removed
>>> from MAC filters and primary VF MAC is zeroed.
>>>
>>> Do not allow untrusted VF to remove primary MAC when it was set
>>> administratively by PF.
>>
>> This is currently marked as "Not Applicable" [1]. Are there changes to
>> be done or, perhaps, it got mismarked? If the latter, I do have an i40e
>> pull request to send so I could also bundle this with that if it's more
>> convenient.
> 
> I'm guessing mismarked.

I see it as Under Review now. I'll go ahead and do the other patches 
without this one included then.

Thanks,
Tony

