Return-Path: <netdev+bounces-71836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46A885544A
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543AC28775F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50F613B7B2;
	Wed, 14 Feb 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DM6JlSpC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D913EFE8
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943647; cv=fail; b=UxZ8OuTHLp2hDGNQ6Dc3XMTcqFJskxnn+92Foi7U1WxlRrrx00WwKmNFpy5NVtEgexcaeHdItjhmvzEnH7FP0450Vd5IgUCJWWt4/2d3MG99sFPW+C0W8gcWZmZtoM74Y3o5GjKSaODnOYf/H95aB5yh3Pq+V//jpf3GWOr9w5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943647; c=relaxed/simple;
	bh=AMnVPT3YsaL83SCknAVxDWGrAe08XwSa4DstRoszdeY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YSuruLTZd2SO9uOOBNoOhtk+7Ifi5i/nHAqTvzX5h2vPGtwyIq6x5+lw48sOVE7M5m+tCmpMqg9O2YhtBdCsWVxSqvN7HRdWJJE8va4qoIAlkGfc83DAZ5wd8eE1EMmO1L6dNm9zQh8Hs+jKhI1e02caicSHV/RKBlwmY5+CB8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DM6JlSpC; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707943645; x=1739479645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AMnVPT3YsaL83SCknAVxDWGrAe08XwSa4DstRoszdeY=;
  b=DM6JlSpCtD7VarN6+7QITMtOubgkYyfC3OnQ+rmBZQlAqIhdGA90exoR
   5X672Z9mwAmE4JkZz9TJXawsMi7TEI9eN4Jewuazr/Oi49sA8gTZKHZBB
   bU318fs6anLHqCMCWfc6FVxiiIugUx52V1DxwQXS+TXfxFrmDGQPis0qK
   JJrSieXTHyzEedUKI6hHMr+1Cf67gF7511QQ3ag6zDjsIzLBhWgmTqE7Z
   RMmUrmLyEZraB0Q5bmCuYMS5d7Vc0mzJJd0QQA44OpcIpRX7dz+XIHWAB
   JimZx93f+yl6ywqfCU86YxmiuSrteYm06EeT6w5cl+Qb2Db9QuY3qbnPc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="12728205"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="12728205"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:47:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3675911"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 12:47:24 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:47:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 12:47:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 12:47:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuOsheiRbckL7TQluNXfffPP11gV+nHMNo9/rE9j5zWIav82Hyd5M9q72uECUQ1eoLvWJI2hcgdO8r39dDSZfxdCb7iq2b5UPF/tOWUZGWyjQdApDKIzK8G2ZrmEUsJ7a3vCDDQBluUjRW05TPi9LDHRYFp/10TaXZBh1Uprh8ABQK18Y5lYMjY5PuT2jleLnHXgv81hKUdhi+03qUjh3ZBgHBr+DUXP8btTIzaddJ9E5S3CGQwMgmq+QBqQEIbogYdRcOiWWXlOqxyl4fznfydUiQfo+dauwUFxNGxkKBHbzMlUTsbpt99q1aINnADGnVxw2BshWuHFQbe6MlYwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADpMie1hsGRbhxEhhneyvQmeTMpVVWDL2D7mUOO51ro=;
 b=NNWJqW3x+TuD2LFtUmfL5kx+DJ5CWXCjpwiEnoQ4Ikxn/KGijqEuo2tnRg2LqFEYBu7vsbPFNqjtEjpW8R8RyTKDCpEDo6vpmLsjUXmSBvPbycDBF2bzoHQptyftjssMq1zmbAkoq0BZc+y884pILarkS5TmyeTReHtlExLyPIRv3qrZ7uqsuYI3EhIR3CjjRFFOUFjkcQ+08M4hY1vWOSrgc3nM5mHPum43dnP/7IDxj0gRFDH43f6WZkz1l1NYjj4I2olwMtpdyUtrmBB5NDGi1rgWQNqt6wOtIdXNTsXjdthrcHdDECs/OtIm/sdJ2bkVpaa1Je3yzw/hmEK/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5410.namprd11.prod.outlook.com (2603:10b6:610:d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 20:47:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:47:21 +0000
Message-ID: <e3bdd081-8c81-4c23-b822-091d3f122afa@intel.com>
Date: Wed, 14 Feb 2024 12:47:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] net/bnx2x: Prevent access to a freed page in
 page_pool
Content-Language: en-US
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <manishc@marvell.com>,
	<pabeni@redhat.com>, <skalluru@marvell.com>, <simon.horman@corigine.com>,
	<edumazet@google.com>, <VENKATA.SAI.DUGGI@ibm.com>, <drc@linux.vnet.ibm.com>,
	<abdhalee@in.ibm.com>
References: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
 <f6b3a268be868e9a528f2549392bf2bdf16e285d.1707848297.git.thinhtr@linux.vnet.ibm.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <f6b3a268be868e9a528f2549392bf2bdf16e285d.1707848297.git.thinhtr@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e883a1-bd89-47d2-26fc-08dc2d9e2428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEm/PAVL5egMf6PHxjIHab4OV51yRb4ooVYc7I4qopxrGR0qibkqtzh/iSg9fifwoCXD6CnWtprPQAcdHMv8DaRd9O1USZJ6kvbdBdOpz0N4bkw4ubEjnUlwhgIOW/PN6pFq4uIPJvi+zsTrlguuSOVFwLYSf4wZV6aaH6dALK/Z/hAxLHQ5f0ae/C5KnGk4WFMJxLBKFYhhFISwFaNysGJvjw9R9IJEsuPhcaVAwamqMNmPxM9RdEvVkOXYOkgQQUss203D7EhhIusfaMMXvk/5oPwU6kqNe2Fp0cYMDQ49kH4x7PLWscPoiMKOLbp9ctY7TARqhrYCRy9zuEw/6HksxwFVYvxlBtOON1286tU63ZF0B8YFXzsKoh9WDq8g0B3fLgOQ+jkA69V308s9n5RDv4fb+8M0jQ3KZC5RkqsGbOWNouu1fBOg2c3aY2ELw4ObvbMdeovnFhIhcZIZsyLIV5sDKH1fChBBHQ8gaMAd/W7k8U5iSoDO7WsPl2F1ziZImLJdgHxBWqE5HyBiGO4cXXjPXeIvM7XHuEs1BppbzfKwRNo3VeGHYRDfpjEd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(26005)(2616005)(38100700002)(4326008)(7416002)(8936002)(8676002)(66556008)(66946007)(2906002)(66476007)(6506007)(6512007)(478600001)(6486002)(82960400001)(41300700001)(53546011)(6666004)(316002)(36756003)(5660300002)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUxpU2R3NFNIM1V3dDVUYXA2K0FyVU1vVElVNEFRRFQxMWNDT0F4TngvcEpO?=
 =?utf-8?B?cmxsb1RoNkVJbzJiaXZCSVZrbXhudnB4dEMvbHBVaFYyclFDWFZKWWRlMGhJ?=
 =?utf-8?B?anp5U1kxNmh1QnNTL3R1cy9tNS9iYTBjd3VWR1RtNFZ1MmpiaitKYmNBT0VZ?=
 =?utf-8?B?dUNlK3NiZ1E4Kzh2R2VuaGtRQ1BhZGhsclkwdWNZc281TkM0YmRwVVhJYVNV?=
 =?utf-8?B?QWF6ajB6LzgycGF0RE8xWS9ocEpyU2dGOFQ5dXEzcXNTV0xlOFFrbFBjanVs?=
 =?utf-8?B?d3UrODV5RGVzRXk0QjROTEU2LzN6akRKZVdwNTVENmI0dndCd3BjaDdsYk5T?=
 =?utf-8?B?K1drbzg5TjJyT0VydnloeVJkcWxWOEp2SjM0cnJiL09kcUMweDhaaWQvT2Fv?=
 =?utf-8?B?WVBwNkZiOWJHZEt4OElQbWw3OGttTm9DN2tnZjU1QlhjVmRDWUNsM1B2aFpo?=
 =?utf-8?B?ZUFiNDV4NUFPWmNaeTJyTzcwMXFXdE90S25lT3RQN2pIVDRDcmRRU1pPUzZB?=
 =?utf-8?B?S1dBTEovSE16SDd2MXA0V09Kb2g5T1F2STNpek5tK09FOEVKck1kWitRQ0VY?=
 =?utf-8?B?bVlvQmhkRDE4SmhyQzloZWVCZWFNSXBVbGtiNkQ1MTRYLzVGU09CSm1oV1U3?=
 =?utf-8?B?aXBFWTZ0NE1Zc3IyY3l5aGM2bWV3Y2w5eVhKWDVsejkxZGpNV1R0Rnhsbk9r?=
 =?utf-8?B?RFF1SkRDMXFjQm5RODhuc1J2S0MyaTRNZFpyRmR6MmsxZW92MHhlSERxcTlR?=
 =?utf-8?B?dkZTSnJEWVB6Qng2WXVtRytrckp4MWZML29jMWlodWk0aWJJdEZ1anBNR0J1?=
 =?utf-8?B?d1MzaCtKSC80dDA5U0xNNi9YaW80bHdjcUFmakorQXNFb09aVnU4Y0lQOUNR?=
 =?utf-8?B?bzl4Yll2R0RyOGNFdEJxQ2lpam9DNE5SSi9GTTZXS0VveERvR3NISHJPWGZ2?=
 =?utf-8?B?eHNwelZ3cFhnTkY3ZVd2VzdLMUpSMFpoQ1d1UU5FTFVhaHRtby9TZnljRDFT?=
 =?utf-8?B?ZDdOcmFneHFtZlZwQVpnQ2VIUzNGOGpmM3lhRnZlckJUZmN4d1dGRmViU0pn?=
 =?utf-8?B?bzdmZGo3SzBlV2EraGJ3ZlBaTDdsdXBIclpXb3h6SFA5Y1JqbmFLTGVpSGlW?=
 =?utf-8?B?Z3QxbkVVU2lBalN1aENMMm9DaFFXclFuTWFNUEh3UWVER0JYRUhtRCtvMXhM?=
 =?utf-8?B?K21raFBCdzAxbDZ4RkEyWmdpRkVCR3IvcENMdTZZWDhEQmc5YWdhQW5XeTdW?=
 =?utf-8?B?RGJrL2JKUzJSMms2dHVEZW01YnRDR0kwZ01veDJWLzJRTm9PYWVKUENKa0xS?=
 =?utf-8?B?RWRmTSsxU0hGTDZXNisvdU5aeXB2NGptdHB3K1dacjlKdDRwNktrZ3VCU1kz?=
 =?utf-8?B?dDFyNTR6ZXFDZFFOb09td0dPN1BuOHZhZkppMDhVcVEveHpCSDI3OUVjNzFB?=
 =?utf-8?B?a0dXbjVRdk14WVlHQXVvWElvaDVZTEVzRzVva2RuZVR2WFpmcVZrRUV0em5J?=
 =?utf-8?B?Y05jd2k4R3Y0Nm1Rdjl2NkFGY0VFaXhySDBqU3dtM3UvK1Q2OVkwcjFTWWZZ?=
 =?utf-8?B?eFhxMVJTbWoySlRqSGQ3Qkl4V0pCbS9LeTEwd0RvaVZpQUtRdmlGc0RYTHZi?=
 =?utf-8?B?M0tTUHpJYmhYWE5NTkNtZGVMVFp2dW40dW1EL2dHRUtYenBGK1FOSkQ2Mytx?=
 =?utf-8?B?ZHY3OE5RRGZJcmN3RTUwMjRFd2VWemMwRG9tY2tiREUyMWJ6RzlibmNyMTRU?=
 =?utf-8?B?aVNyWEt5UkNBN2Zmd2x0WEhHZGtVajI1RnZQanRxOGNTQ01aSXMyck9NSFhp?=
 =?utf-8?B?UTl0d3VsZHBkd1M3eXhEOXNDV05oNVl5dzROdlpPdFgrcVlRWW9TYUVxQVA1?=
 =?utf-8?B?QktMNDBHZ2lmL2FvNkdxc0JzVWY5RnNsK211NGNWUnJCOUk0WDlvM2VsZ2t1?=
 =?utf-8?B?c1lPQ0ZkcGV6WEFiVEMrcVFrSGVvMzlGTUZWR2x2ZzZNTS9KSmRGSmN0cVJ1?=
 =?utf-8?B?bzBjRm5RemFlMUpMWkp6eXdUWVlXT1k2STkwQ0tiRVQxUVNUSXVCTUZqTFYy?=
 =?utf-8?B?OHhiTU5qaVBxMlk0OGhxWXVYdTZaL3JCeXdZWGtza21YdU9aRUxLdGVEM21K?=
 =?utf-8?B?RGdaZUNwSHBad1A1M0svejRDZm90TUZyT0VyT2lzZmVGeUVJTkJSeTIwdEc2?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e883a1-bd89-47d2-26fc-08dc2d9e2428
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:47:21.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kLQxHY84BoUub/8+cWcEpah5IG1t5QGtHtj0rq0NA8IOkYtzmeOc6Rcn83Y0sUNBDWdUzgKoiaUO9tmvqvpLLXfdE6y+RF7Ef2GVLJyzYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5410
X-OriginatorOrg: intel.com



On 2/13/2024 10:32 AM, Thinh Tran wrote:
> Fix race condition leading to system crash during EEH error handling
> 
> During EEH error recovery, the bnx2x driver's transmit timeout logic
> could cause a race condition when handling reset tasks. The
> bnx2x_tx_timeout() schedules reset tasks via bnx2x_sp_rtnl_task(),
> which ultimately leads to bnx2x_nic_unload(). In bnx2x_nic_unload()
> SGEs are freed using bnx2x_free_rx_sge_range(). However, this could
> overlap with the EEH driver's attempt to reset the device using
> bnx2x_io_slot_reset(), which also frees SGEs. This race condition can
> result in system crashes due to accessing freed memory locations.
> 
> [  793.003930] EEH: Beginning: 'slot_reset'
> [  793.003937] PCI 0011:01:00.0#10000: EEH: Invoking bnx2x->slot_reset()
> [  793.003939] bnx2x: [bnx2x_io_slot_reset:14228(eth1)]IO slot reset initializing...
> [  793.004037] bnx2x 0011:01:00.0: enabling device (0140 -> 0142)
> [  793.008839] bnx2x: [bnx2x_io_slot_reset:14244(eth1)]IO slot reset --> driver unload
> [  793.122134] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
> [  793.122143] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  793.122147] Faulting instruction address: 0xc0080000025065fc
> [  793.122152] Oops: Kernel access of bad area, sig: 11 [#1]
> .....
> [  793.122315] Call Trace:
> [  793.122318] [c000000003c67a20] [c00800000250658c] bnx2x_io_slot_reset+0x204/0x610 [bnx2x] (unreliable)
> [  793.122331] [c000000003c67af0] [c0000000000518a8] eeh_report_reset+0xb8/0xf0
> [  793.122338] [c000000003c67b60] [c000000000052130] eeh_pe_report+0x180/0x550
> [  793.122342] [c000000003c67c70] [c00000000005318c] eeh_handle_normal_event+0x84c/0xa60
> [  793.122347] [c000000003c67d50] [c000000000053a84] eeh_event_handler+0xf4/0x170
> [  793.122352] [c000000003c67da0] [c000000000194c58] kthread+0x1c8/0x1d0
> [  793.122356] [c000000003c67e10] [c00000000000cf64] ret_from_kernel_thread+0x5c/0x64
> 
> To solve this issue, we need to verify page pool allocations before
> freeing.
> 
> Fixes: 4cace675d687 ("bnx2x: Alloc 4k fragment for each rx ring buffer element")
> 
> Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
> 
> 
> ---
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> index d8b1824c334d..0bc1367fd649 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> @@ -1002,9 +1002,6 @@ static inline void bnx2x_set_fw_mac_addr(__le16 *fw_hi, __le16 *fw_mid,
>  static inline void bnx2x_free_rx_mem_pool(struct bnx2x *bp,
>  					  struct bnx2x_alloc_pool *pool)
>  {
> -	if (!pool->page)
> -		return;
> -
>  	put_page(pool->page);
>  
>  	pool->page = NULL;
> @@ -1015,6 +1012,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
>  {
>  	int i;
>  
> +	if (!fp->page_pool.page)
> +		return;
> +

Doesn't this still leave a race window where put_page was already called
but page hasn't yet been set NULL? I think you either need to assign
NULL first (and possibly WRITE_ONCE or a barrier depending on platform?)
or some other serialization mechanism to ensure only one thread runs here?

I guess the issue you're seeing is that bnx2x_free_rx_sge_range calls
bnx2x_free_rx_sge even if the page was already removed? Does that mean
you already have some other serialization ensuring that you can't have
both threads call put_page simultaneously?

>  	if (fp->mode == TPA_MODE_DISABLED)
>  		return;
>  

