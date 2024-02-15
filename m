Return-Path: <netdev+bounces-72144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D572C856B5A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38705B24998
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95B13667A;
	Thu, 15 Feb 2024 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4C5+CQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560E136674
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018903; cv=fail; b=amKBpuZILIDvQFS73zTRiV0E74A2sihofaE2VqfU+QWLlrvt+Hp5icFNyu0qKBzGlzXcf7nARcyEgEfA+Tofd3y5tbn1neFVQnUrENGcSFBYm0lk4V8UImzR22wiSs8flWP/rZXVC6v5HaOGEUxdYLvH/JasCmnQ8JrmqEhKqI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018903; c=relaxed/simple;
	bh=DrNwYI/Wm4ShGwdynAc/T5GzLG7MBLUw5QgqFFqLW5Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r75NaFB1UbogpRH+QPiScnMLADx7cy5PL9Z/C5g4iZYuCTvh0Bnct2sA8ki2fUN4Ga909TiQ6JSa3RmUhaFV1YJpKGSScW48iRbKrJF8DIMVcJGr3fvup4BgMDaT7nwk0CCXUGyBcNtx2hWJ31OgZpD3oTn6L2jhncUWtiVls/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4C5+CQ9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708018902; x=1739554902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DrNwYI/Wm4ShGwdynAc/T5GzLG7MBLUw5QgqFFqLW5Y=;
  b=k4C5+CQ9ffRJ4yjsMSgyA2BCoXpilziOtlXvLx8fPHF6scUdoPTQoJm8
   jqr0FS8FIaINs0Rt4p3CHRhy3DlsO12Y7AKqnRfUmVNx20GiiEhgfS7M0
   aIfJXg7iP7YIDxrQIQ7zXYoxY+GepgM3SFlvrVX+oczROHSBBwwuRN1Tr
   MRdO59CadxQ4uq4YN2iXOTLmUsoux46F2Eu8IzdFhb0JlPb61Vsslj6Dt
   XHpZGfH1fWyoqhhdGAdEniSmUv1Hir+dAWtXyEP7jpHIdMMw3hZRz1Pd3
   MHY0iMIqq1CVhYdImOA4FaQ6+++KUoGS6x5C8EdG4QJSwPt/VOF2XeRPl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="27576802"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="27576802"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:41:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="8257142"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 09:41:41 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 09:41:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 09:41:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 09:41:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWZCWRDHy/P2hCaBBp4D341sPcd2IY3O4eB3BIfxHSZA2v+bokz++QKDE6IPtgU7+/D9G8r36vRX/NLR0lPd3LLOGST7xLggfUbnHiW3TRqxCgBSHYyMqPkDJeg2EPkb2cZPQ+wCrsMbE16Tf5O1hDjMSiRK5DWBt8mAFrtaUtiym0TfE4xZ3UQRl2/KojTxMFoBn+1Pch2x+3eSVJp8q/r5FZZPrbUltaT1JmbjaNuSSbvk2lQMdn1/L+YlNANAWNKXrHYu7htyE8Y6oVYnabMVkzyxF8u2wkP9OgsyynvS38NfN1+VNumv5/fxFijnXQOgoyBIX4E6GEgFjW0qaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDtz2Pbg+O/SNR+ln9/QYtJNblrx3+1YioQTAbeRhSU=;
 b=BkQ8VlBgEg1VCyS0/NoAmLC6xT7pr6vUP5C7wzu/urvJM5jHiPPmbhXLC9u1KgVaZBQOm+uPfZtlyUw73unvr6UHmKekiApC266wcgGNdV2gXpjW7kqjYV3ENy6rOuqAtRCTvheU1Emyx1al6cdeHbH6KRB9/GOzrM3uAeEjXy9G+UFt4gK50GvJ6t/tOUo65BhyMr/S5E1sa/UzKAAEkN6t9T3VhEcSiAw/Ru42Nskn1/bi3ZoUgv1LbCF0qya3G3Y2A3idLXo6Nyvf0t/70O15JkL4TIkQ5mc4fp1exFIBsVL2AE41ajhaqdgBlXI0pQjrq+bkzOMI08YczNyV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 17:41:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 17:41:33 +0000
Message-ID: <aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>
Date: Thu, 15 Feb 2024 09:41:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
CC: William Tu <witu@nvidia.com>, <bodong@nvidia.com>, <jiri@nvidia.com>,
	<netdev@vger.kernel.org>, <saeedm@nvidia.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>
References: <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org> <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org> <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org> <Zc4Pa4QWGQegN4mI@nanopsycho>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <Zc4Pa4QWGQegN4mI@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:907::46)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4760:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ee2d51-de3f-4440-faf0-08dc2e4d59b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dfZf3ZUIuVe4ORQzC1qaIZ+M0+aPkxlbMAjnN+EjKl1YAwg8+7VZ4sWIIRA1rZFQnARLE+axIEtqDrM7bl7Y2jUh+/lUsbPZ2U5dqm4c3G2QHfHrLcZ+XPjG5SzgB1EfLjh2xOfFH/4VBfypc1BVB0Tojdg0+a5Becq1yKuiLg6nfnuMlM82adLoNK//6lctPk0CJ5kiDy1qWmMOOqc++xVRAgP9bmIVSVmt3tPvdmdH+nO76urowTBKQzV39YtE12sYfzVoE3E7npK7RPx7b3W856BDP2z4J0Zf0EB6GulPTwhvThuc9DyB/7lCFHB4yVfvhOv1IF6RhmaZ21PBrT58RuDOZxUjDnPFxRT+qBd8pFlIwrERiwnINAN62T5ggeZ4bnnwqKs/gEHDV1pSBwhUiXdWUqSto/vPZQ5P2WyOHQQYM3OMXBA7OgfJb0+0/kGjUBaA3DzpeuFxz8Vv5NyXtH6bl6DiY0aErEgd08rWSrsD2RO0TIMC10az10bdqZNffTnlwls1U5igbz9PgHhiOjEywOh7EBtMlpyBQW7USYA8KQoPPdDhkes3R+8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(6486002)(53546011)(6512007)(6506007)(478600001)(2616005)(66899024)(5660300002)(2906002)(4326008)(8936002)(8676002)(66946007)(66556008)(66476007)(54906003)(110136005)(316002)(41300700001)(107886003)(26005)(83380400001)(36756003)(31696002)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWg3bmRkaFpNY25SZjhacFBxeVlIakV3dmZocW1OSGVmTkRhZ0pJVFlDT0Vx?=
 =?utf-8?B?a3V3cGwyK0NPVzNzMEJuV3ErejBHRzErY09aTWdyUDlHRUZyU1JTSXRObUlW?=
 =?utf-8?B?VXBZeWlySml5dHBITXZkYUVkTTlYVEVvaUE5VG5YN09KVFZHMng4TllCeFhN?=
 =?utf-8?B?emIvL2tKKytJeloxYjA3dXJqaVlyTUs1RkJ1YVJJK0tnQ09rK1Bvd1UwQnd4?=
 =?utf-8?B?bURwaWpQVWhwYm9ZKzlMQ2x5L1hTWjFscS9mTTdiMHhtK09RYm04RmJ5eGx4?=
 =?utf-8?B?cGJJUE5XcVNabnErR3JXclRNcjdrQ3p2Y1dRZmZXYWhkVWJQdWlEam42R21S?=
 =?utf-8?B?VnNuYXJuZ08rQUpqUE81UmlnUHlXRzFYWHovRmZZUVgzbjVwRWZMNE1lQStr?=
 =?utf-8?B?VHl6MGZ0b1dKMWVWU0Z5Zk4xbWFyV2dKVlM1QkJ2b1hCR3IzZW4wSjJtQ0t5?=
 =?utf-8?B?Ui81Z2RHS1MremJITVo5WkRsUFN6WHNRN1lsdUJwQU9ETlJMelI4cEdLUVFW?=
 =?utf-8?B?eUlKSVd2eTZrVXNYcE9ESk5FUUYyT0NuMjI3SCtUc25tM0tLZmUvakhrRVdX?=
 =?utf-8?B?QjBoMldCTlJMK2pPaUhvSlpmTkR5ckFaZVMwRWxBUXZMV0ViVm1QRkJkK1BW?=
 =?utf-8?B?VHRNRkY3cG4razFhQmtPZkFxWjVTRVZNVU1NWEN1VVNXMDhqd3J1cFoxUUht?=
 =?utf-8?B?TktrdUNBU3l0cUpNMkFRUDgzTU5zeUlBcVJ1VFJDYXpBMEpZczR0Nm1mTC9G?=
 =?utf-8?B?aHF2ZlZRMFVTanlBd0ExZ1VnQ2IwdUNrbnRTTlREUGNHM0UwTnczbXpsakhv?=
 =?utf-8?B?QUhCWm9nQzdYamtSZGNqY0FQTHlOeWFuaSs4VXFhN2tvVkZ1S1MraFdMaEdo?=
 =?utf-8?B?TGsyeXIvTm9GcTBDZTZJRTA0c3ZiZEQ2UjRnT1htaUgyZDJmNkdIVnRHNVhG?=
 =?utf-8?B?OFl3UFZSamJjMkthM2VtQjRHamt1YVN6Vld0NjBtRGRyVHdrMHNZR2pERGxp?=
 =?utf-8?B?dVluaGYxaHpRbCt4UEdhQjRaRGIxSU9lNW5TZDdmL3ZzUFBTQ3JuZVM5NzNp?=
 =?utf-8?B?YzZzQ3NMWVIrZHlaY0RVR0QrZFcvTW5BS3VycWFFTkxBRk55a1VsWXlLRWxG?=
 =?utf-8?B?QTNVM2tkcVZ5eGJvMHY0WENndjBxUkN5THJzNzQ0OXVFTGV1ZHZTcnlaSWdF?=
 =?utf-8?B?WWZWa1ZBM094QW90NGJHUENDTW1BVStrQWN1bVpGUDlUV0J3Rm1sU0xIM3Rq?=
 =?utf-8?B?QlVyaC9MQTlCWlB5bU9PSUZLVFpnNXp5clJ6Y1BMRHVrNXVWMVNUVmd1aVI5?=
 =?utf-8?B?QTVXd0x6NlhrZmN1NVRqSlVkRVNGK1psRzhnTkJCNThKYzhhMTQ4UVFrNDUr?=
 =?utf-8?B?MGZ2VlgzTjhpMDJ1V21jUGVRSGNjSVRvdDFQQWlpQ0s1djJtUkU2cGwxUysx?=
 =?utf-8?B?MmRUREl0QzlEWENYbjgzQWljb0MzTG0wa0laWlZHY2JOR0lkcWFWbnZiYjIy?=
 =?utf-8?B?TkN1UXUyQ3ZTbkFwVW43N21jeUxGL3Q1OXB5SFFQdzVhSDdmU2EzMUlNK1BO?=
 =?utf-8?B?dE5kUEhVbVhScWppdnRuY3dSZzIwSXIxeTJxeGpGOTM5OWoraGo5MkUxczBM?=
 =?utf-8?B?aWt6dWFocU0rMW9uMEhQVExrSkhUR2xuUVpnM0dnYlh1SnZPUGZHUDd5ZFgw?=
 =?utf-8?B?NHN5TXNXV08wdEZhd0ZEaWlrS05mUzF1b2dBVzJnazdmd25SZlV0Vzc3c2Fl?=
 =?utf-8?B?Q01HRjRKd2NaSWdtOGNhMnlhNFRiUko1eGozTnZzYnpyNVpVRS9xSkJwYkFY?=
 =?utf-8?B?ZGNSVnZjTVM5Ty8rMEhTdmVnUEI4NGg0b0o2UTJiY3kxWEE0SC9wMkhlakpC?=
 =?utf-8?B?RGUvWm14elV1NDJYRldNUlBWcjlNNGNONWdtS2RXRzNxWXdYZXJpV3hZU3lu?=
 =?utf-8?B?VjVzZC85dHovV0x0WitIQTBMclpjNGRyejhSVG1vN2dBZnp2anJHLzZNMm5M?=
 =?utf-8?B?ZStvamQrSHgrREZ2V0NaOXFUNVNtcUlwRSsvQ0U4a1Y0cEpjRkE4MndtaEtj?=
 =?utf-8?B?NHRjQTQ5ZTJZMWRhcUtwRlJ5M3pyYjBnNEtuRE9OS0FLU3ZpenoyQ1JBUWVh?=
 =?utf-8?B?VUdBYWozUVp0SGk2bmNUNERNQ3h4RmRkR1BwS2tiV1ZBY2tHcFRjSWJZYURm?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ee2d51-de3f-4440-faf0-08dc2e4d59b5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:41:33.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTVqQxPXA0wekgJT39nvOBzE0EOrVLWEwLzmC9BQdN3rDRKSGCM7aOfC8lQyPV57c+OEgiYeF5cCabe1agSa8G49Psot6M6kmkZPkZI2wTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
X-OriginatorOrg: intel.com



On 2/15/2024 5:19 AM, Jiri Pirko wrote:
> Fri, Feb 09, 2024 at 02:26:33AM CET, kuba@kernel.org wrote:
>> On Fri, 2 Feb 2024 08:46:56 +0100 Jiri Pirko wrote:
>>> Fri, Feb 02, 2024 at 05:00:41AM CET, kuba@kernel.org wrote:
>>>> On Thu, 1 Feb 2024 11:13:57 +0100 Jiri Pirko wrote:  
>>>>> Wait a sec.  
>>>>
>>>> No, you wait a sec ;) Why do you think this belongs to devlink?
>>>> Two months ago you were complaining bitterly when people were
>>>> considering using devlink rate to control per-queue shapers.
>>>> And now it's fine to add queues as a concept to devlink?  
>>>
>>> Do you have a better suggestion how to model common pool object for
>>> multiple netdevices? This is the reason why devlink was introduced to
>>> provide a platform for common/shared things for a device that contains
>>> multiple netdevs/ports/whatever. But I may be missing something here,
>>> for sure.
>>
>> devlink just seems like the lowest common denominator, but the moment
>> we start talking about multi-PF devices it also gets wobbly :(
> 
> You mean you see real to have a multi-PF device that allows to share the
> pools between the PFs? If, in theory, that exists, could this just be a
> limitation perhaps?
> 
> 

I don't know offhand if we have a device which can share pools
specifically, but we do have multi-PF devices which have a lot of shared
resources. However, due to the multi-PF PCIe design. I looked into ways
to get a single devlink across the devices.. but ultimately got stymied
and gave up.

This left us with accepting the limitation that each PF gets its own
devlink and can't really communicate with other PFs.

The existing solution has just been to partition the shared resources
evenly across PFs, typically via firmware. No flexibility.

I do think the best solution here would be to figure out a generic way
to tie multiple functions into a single devlink representing the device.
Then each function gets the set of devlink_port objects associated to
it. I'm not entirely sure how that would work. We could hack something
together with auxbus.. but thats pretty ugly. Some sort of orchestration
in the PCI layer that could identify when a device wants to have some
sort of "parent" driver which loads once and has ties to each of the
function drivers would be ideal.

Then this parent driver could register devlink, and each function driver
could connect to it and allocate ports and function-specific resources.

Alternatively a design which loads a single driver that maintains
references to each function could work but that requires a significant
change to the entire driver design and is unlikely to be done for
existing drivers...

This is obviously a bit more of a tangential problem to this series.

