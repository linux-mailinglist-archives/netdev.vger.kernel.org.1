Return-Path: <netdev+bounces-27423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD177BECA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F4428114F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43853C8E5;
	Mon, 14 Aug 2023 17:18:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339DFBE79
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 17:18:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BEE6E;
	Mon, 14 Aug 2023 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692033509; x=1723569509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CJXicBQZH8JDl6fB1L4zrhCXERuM4bbOoFQwORRLr/Q=;
  b=l4uOttndB01JwurQ3muebbIYJE6Elg769Be6IFKWqSdI42qV5V9hF5kh
   qVNgHhkg5QTYFYD2gFun3z2bsAd7Obt+12BxFTh7pyvsXR5DYcFOAL4H2
   lGfzvJf7NCTzRHcWgkQlwXGzztc1xa3i3SiLD7NJIkbBVybDDfNI3YW4q
   VfdE68kmGOMRbj7wcKEFDTPzy5fco3Qh9ZDfY13xdGR8MPbTa2mPCX7SD
   e9XtxJhMoNKqnlLdRkmilSbxiSYsaBh1hTfE9y3d2XlGbIH6BUlsgCbDX
   v2pVN23ZljFE1WoamrGsSPGTgzJKOBl/ZPM7W0DRKkTQCQt2w87rxvi59
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="370994973"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="370994973"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803521083"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="803521083"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 10:18:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:18:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:18:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:18:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:18:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXcCsA1qDzX5X8hjc6H2irfie5LZzO8GunXWHX3bv+A5+YsZ1MnOoM+Kkgq6FLGOuo77Ul0DYxmg//EnKcqlitle4wAWM6qZQ8DkBteZcvW+gW+wRYU5ny7HBlKfo08LwEtgXpOJGVd6dGiw6fmNxSO1nc6FRcInL4hElfFJXfahhmmCW/0O6RldpELdCBfg2Agw/fCYY6DkEeM3jA9fRcducFa0EddiLvppS3Mz6MkZwqC9S0x7veRwu3/5sTtZTCnTmaw0hxTqWZhQvjFilRGO5mIoQT+35oKmSajIohDnebtyvQG4ssu084mU2qc+TzqGkQb2gK5ilh7C1pJAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFUJ8DSOzyh2Q+lCNTdr1IqL0yYvynpTMP+B6EJvbrs=;
 b=cd1nZ/rSox5BS/mSY8MUBJJcDz+ZKqRurziwcKTHdxaT+qCVZzaXOH85w12eCtsKPosuXzrnqrPVHHGykKjnmbx8dnc1DQa1aDnTBJMUoxZguEO/AOc3TByPMvdidbgOjaNAY00pbACRBZGc8zNnRlrKMS+PeTc+1W5tMPEFyiojSxS+mZXYCt8FbdrxsoQjD6VTK+5yMSyUkzeGkRfVP5+No8keCs21lgtq6Suv++bRsQb3o3XLTYDPhAW+nQEogMOFr9BNWS0tz30Mv2QWRoKEeLbE3RAZOjEFS209BGOyvl/nZh/3rGIWEIC8tApQw/fWfLDRKar+RMfxpzFsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2593.namprd11.prod.outlook.com (2603:10b6:406:ab::27)
 by DM8PR11MB5623.namprd11.prod.outlook.com (2603:10b6:8:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:18:19 +0000
Received: from BN7PR11MB2593.namprd11.prod.outlook.com
 ([fe80::f195:972c:b2bd:e542]) by BN7PR11MB2593.namprd11.prod.outlook.com
 ([fe80::f195:972c:b2bd:e542%5]) with mapi id 15.20.6652.026; Mon, 14 Aug 2023
 17:18:19 +0000
Message-ID: <093c2cf1-812e-94f7-165b-c075752dc732@intel.com>
Date: Mon, 14 Aug 2023 10:18:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/2] scripts: kernel-doc: parse
 DEFINE_DMA_UNMAP_[ADDR|LEN]
To: Randy Dunlap <rdunlap@infradead.org>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>
CC: <linux-doc@vger.kernel.org>, <corbet@lwn.net>,
	<emil.s.tantilov@intel.com>, <joshua.a.hay@intel.com>,
	<sridhar.samudrala@intel.com>, <alan.brady@intel.com>,
	<madhu.chittim@intel.com>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <willemb@google.com>, <decot@google.com>
References: <20230812002549.36286-1-pavan.kumar.linga@intel.com>
 <20230812002549.36286-2-pavan.kumar.linga@intel.com>
 <9efeeb6a-a2d4-9b56-c127-119c1ac378b6@infradead.org>
Content-Language: en-US
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <9efeeb6a-a2d4-9b56-c127-119c1ac378b6@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:303:8c::27) To BN7PR11MB2593.namprd11.prod.outlook.com
 (2603:10b6:406:ab::27)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2593:EE_|DM8PR11MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b257ad-9829-4efd-32f7-08db9cea7477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiNTt/3D/xYNFnHM4z0TVY0uvJirtmovI2JD6CMsN43Uzj+D42VWsb+srE7blq1MOIf/P19mRHT56KfS11FMtxHRdIV4trsCfXrLuopQt0/3dgMKgCAdZymlA9dNS+xTIL2LuzKvij0ize0AcpeG4S526+NfmLm6IUXa13Vx5Fe9m04UBLV/iNg6vR3m5+W356/yV/VsTi8m4bJumn7crTpnwWS5ryCxDLJL8zOQ8JAXTVroSkrcg1GVwj1yEgr7dXwI+5VvgUZF1M7z8IIGKnF8XkCtEnqpTZKTsEOZ2yZAWcA9+f/ACEviYHuTF98jFH+2Bw0oeNnx8cUDMGogtW4jP0Fvhxyk3EB0T1Pi+OeXJ1mJyVOLkr6pxAEE2l2KzviHu+5xuCfNPjDN4YoLvfFwJgQ6jwOr6lwfz+QnFV+K9gXGfkYCDoW2EvT3GsKlDoEuk6GdeICL6FhRbrkJX3Uiyryggs64A/9VWgc1cC+B6HbVjNke0ooxJ4e5WO4oApXCWC8y5YXp5h8SumWd1iEN+znb2diCCvsuVUnVAnEJKJ247Ry7yQ9Mcfto/8Jgy6OXA14R4icucNe84EdBMbCg2jzArw8NsP0KX73exInX4pHnKi3OgJCFkOR3QT9DoAcWrUFgZvgqY4ehrZRmjiZ86KIoF4jjg1gcmTuNXHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2593.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39860400002)(1800799006)(186006)(451199021)(53546011)(26005)(6506007)(41300700001)(8936002)(66476007)(66556008)(66946007)(316002)(8676002)(6512007)(31686004)(2616005)(83380400001)(6666004)(6486002)(478600001)(38100700002)(31696002)(36756003)(86362001)(4326008)(82960400001)(5660300002)(2906002)(83133001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9OYzdhK2R1V1hkeGQxYnhoM0FQSExHOVdMdzYzaE04QThkZEhuWURkTEhi?=
 =?utf-8?B?dFprS2dJV1JLMGpxVE5wTnRYWHNPSzVqUWxFSlB0UFpBdXpmL3BjcS9nN21v?=
 =?utf-8?B?TnJ1QlZyeERMUGROMlhKQU01NWEyQ21iZmRxRWxTc0VVOVNjMURnNk5XN01X?=
 =?utf-8?B?RjVERGE0Sm9jOEU0UTl4VVRoNUZOOUdvMUtRMGRTZERJOTQyeWpnZUwyWExO?=
 =?utf-8?B?ZDdWUGt1RzVZVkRpeWJoUjUxR3pVcUd6R1JOTnpleCtQWHZMWUlSeFkwdmJu?=
 =?utf-8?B?OGFlTFVxMnFvUHUyQUxmdGdzaGovdW9xcWkwVEdGcEVKREx6NUhTaUh4T3ps?=
 =?utf-8?B?d1FabWUvak9nVTlpVWNRMFE1UmRtaWRtU3l1bDVSL0FLR0UvTWFhL2xNMW10?=
 =?utf-8?B?Vm1zZ3ZmUUI4NllCRDRqY21iL0c1MUMvZC9zdkZiTEczeDZ1RkF3aDFLbGVt?=
 =?utf-8?B?Rm9KQVdwMWJCOUpPUFJNODAwR3JXTjhzRUJFQ1ppc0QxMFhUcUFNVzFKdk9j?=
 =?utf-8?B?dUt1cXdFVDh5dUtERFZ1TjVrZUxtRWNvalQ3ckJIRzJyTWRLQndIeS9iaDBD?=
 =?utf-8?B?OHZWb2lBdkluWEN5V0NXekoydHhWYXl5ejFRUEJIczFnUGhqUXFaNUR4N2U1?=
 =?utf-8?B?TzlhTENHbmlUdFdGNGtIcDJPVlQxazI1YUMwTm9sdVpySUZUVFVhRm5pb2Y0?=
 =?utf-8?B?cEJEOE1HUEtSZlpsWWk0dlZ1UlErcHRwRC9UNkpUQ3dVMlJ3MDVUT1NHcWox?=
 =?utf-8?B?NFZGWXFTRkw1WDdKcndnUDdHZTJua3llQnNwa0lEcjU0QS82SjRNTlFPRjAz?=
 =?utf-8?B?SUQwVW0ycHB3RVZQRW95YWpiNzJiaVFCWHdYWGkxVVdvOE9XS3JybXc0RU5x?=
 =?utf-8?B?bXBNL3kwVitPeTBBWktjZGkwbHRkUkZ1cEQvLy9tc0UwSzd2SFRRK0JLaGlI?=
 =?utf-8?B?MVhLU2FVSjgxTVZZSFZ2VjNSOGpDRTBoY2g3bmFQL2wrUzc1VWFvdG0rR1J2?=
 =?utf-8?B?bmtuVlh6NnFPNDlUTlNBcXR2UzlFOFJ1eDBFME4rcWlMdnExT3dLcHZ5QTFQ?=
 =?utf-8?B?UGhUNWNveWFraDB1RDFWMkZVYW5TbFpGbXFDQTBpM09qWUpLQ21NbGxyVnZq?=
 =?utf-8?B?RGo1aXJPc2FHSTNReC9rMG1wUE9va3l1UTZ3dVkrSkFMbGh0Y1V0VkpGQUM1?=
 =?utf-8?B?WWdzbGgyUGhZRklMZ09GdzZLTUdjb2dxUENQT3l6TXJQNHpYMitXeHlxZ3pl?=
 =?utf-8?B?VUs5Mk5VRWJNV2ZtMFRoaGJnTEVrbnpUTDgrZVN4RnFuY3diSDdKMjdvZTR3?=
 =?utf-8?B?TC9aMUFDYTNEUWtsUU5JdktYeTlLZEo1UHlQeDBXRUgzM21VcHFtdXh1blY1?=
 =?utf-8?B?cFh5cmlhT0NUcVZ6bkZ6OXpiLzc0dGlXSURWTGZmT1NqWVdjWUExVWNiaWk5?=
 =?utf-8?B?V2RONGJGMllwOTV2V2dBSDBPLzZyY2g5MWc2YnFjTzlBQlRHTnhXS0E0QVNw?=
 =?utf-8?B?TGNGWmZPYktvckJUU3pDZG5jY29TS0RJdlB6bXF3THVqYnRNbFNxNHl5TjB4?=
 =?utf-8?B?RmJTZTBVUCt1azJvcUlUcHE4bjlxWlZCSEpBbXR4cHRuV0FHK29mS25ENFF4?=
 =?utf-8?B?MlpvNnlZdTlCSnNhNVk2SUk3Q3RkMUdDRW82ZHk3Y2Y2TU9PdEtZOEtmQjFa?=
 =?utf-8?B?OGRCd1VIRFNFTzhwQU1tMmRWNlVORk42dTU5c21OR05XSjZiRkJ5REkvQTFh?=
 =?utf-8?B?KzBqQVdHSmw0MWdYRTNwQWVZbWl2SnlxWngxZ1ZvUGFpQThQcjNwUlhtbElv?=
 =?utf-8?B?azdyTGJUVmdLT1huenArQ0Q2disyS1p6Y1AwRlg1RmtXMTZZZUdLdXBzTTJl?=
 =?utf-8?B?VHU3RGdnS1JnYTUwUDBpTjYzZWZmM3czZ0dZWlFRS0pvZnBJMGxxSU5OeDE3?=
 =?utf-8?B?SDcvaXJubDBwTm5lL20vRzdramlGZlEyZVp5b08zUXYxVnBzUm54czdxOFEr?=
 =?utf-8?B?bmRQc1N6ei9uVkhNdjFkeU02NXl3VmQ4WjV0QWdxd1F4ZFNoTHBKODRQNjZq?=
 =?utf-8?B?RVk0T2VyZFJhN1NHV2doc1VtQUJha1pQRm5YeGJWUW9aajdqb2ZLOXZCT2ZC?=
 =?utf-8?B?YUZ2aHZzZ1htNEhKNnpPS2hybFZnR0szVWVOSUNBTzE4dndDRzY1b3luME5Q?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b257ad-9829-4efd-32f7-08db9cea7477
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:18:19.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inQyPGY6blDuexWh/nErwJYGYSBnaTemfckRwCMY2nkkWWaVxro3tsSWWyjkpl3ENgyyzlLtkfuG3miEqhP6gmEkoV2ztDDS1f5991HV49s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5623
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/2023 9:47 PM, Randy Dunlap wrote:
> 
> 
> On 8/11/23 17:25, Pavan Kumar Linga wrote:
>> At present, if the marcos DEFINE_DMA_UNMAP_ADDR() and
> 
>                       macros
> 
>> DEFINE_DMA_UNMAP_LEN() are used in the structures as shown
>> below, instead of parsing the parameter in the parenthesis,
> 
>                                                   parentheses
> 
>> kernel-doc parses 'DEFINE_DMA_UNMAP_ADDR(' and
>> 'DEFINE_DMA_UNMAP_LEN(' which results in the following
>> warnings:
>>
>> drivers/net/ethernet/intel/idpf/idpf_txrx.h:201: warning: Function
>> parameter or member 'DEFINE_DMA_UNMAP_ADDR(dma' not described in
>> 'idpf_tx_buf'
>> drivers/net/ethernet/intel/idpf/idpf_txrx.h:201: warning: Function
>> parameter or member 'DEFINE_DMA_UNMAP_LEN(len' not described in
>> 'idpf_tx_buf'
>>
>> struct idpf_tx_buf {
>> 	DEFINE_DMA_UNMAP_ADDR(dma);
>> 	DEFINE_DMA_UNMAP_LEN(len);
>> };
>>
>> Fix the warnings by parsing DEFINE_DMA_UNMAP_ADDR() and
>> DEFINE_DMA_UNMAP_LEN().
>>
>> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> Looks good. Thanks.
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 

Thanks for the review. Fixed the typos in the v2 revision.

>> ---
>>   scripts/kernel-doc | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index d0116c6939dc..cfb1cb223508 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -1168,6 +1168,10 @@ sub dump_struct($$) {
>>   	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
>>   	# replace DECLARE_FLEX_ARRAY
>>   	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
>> +	#replace DEFINE_DMA_UNMAP_ADDR
>> +	$members =~ s/DEFINE_DMA_UNMAP_ADDR\s*\($args\)/dma_addr_t $1/gos;
>> +	#replace DEFINE_DMA_UNMAP_LEN
>> +	$members =~ s/DEFINE_DMA_UNMAP_LEN\s*\($args\)/__u32 $1/gos;
>>   	my $declaration = $members;
>>   
>>   	# Split nested struct/union elements as newer ones
> 

Regards,
Pavan

