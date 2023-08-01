Return-Path: <netdev+bounces-23236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D83176B62D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5862819C7
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F4222EF3;
	Tue,  1 Aug 2023 13:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C222EEE
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:48:24 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E4DFB
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690897702; x=1722433702;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u9DHVyPqSflOj2vQ+C/8mwwZOqdcuJDK29I6E5p4iqk=;
  b=CVDGFQnbVx+mbAL4v0ohaylrzwjeE4Y8dW0FNihAg5Xp2FR62RuSrpI9
   hSW0FsirdFCEr/wnpu4Pqfb/H7BZtaljlb+m1aysU5BfgLXQGidwEWg90
   B8xGn6hobtUxqvfxf28zyVcXkHSHt9JTTP8Ikd8hQQKJq5yJCnUExXEzm
   aCKA0x5254U1KYSO5TP+N+G4UK61lEyOo0oRaEYKrPWCIEn+0wsygfEYM
   nlGg/+/epPzqs4AYG7ohcmGRuK+1Op10/xQojO4Pu0INlyCeqE2sw0DOA
   7mj1pb5IYsuzhD12gxKxfjOWlJwjO0uVuXUsmtmQSpwgo7uqFRxtF2iin
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455676307"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455676307"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 06:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="842732283"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="842732283"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2023 06:48:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 06:48:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 06:48:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 06:48:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 06:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2OL9QNqQ/5m0MKfo3v09hvUkkacHIGJ8/nfQVV++F9rNPqwCLaIKoyAu8D4yw4eJTXBvoa5Ju4eEB95Ikmz0D2X/1Bi00ZWGa7pOu53hdBfYg+G702mQ8H+P8rVlAte4cAYLS5MFZisSt7ouUM5QStPfUyrofb3wD9aOfRjk7AcpMV5DAl9a+fvgI7R5VjnHpoX5zdfkYL6lgx9xGI40y3rq4A6vZx4/VX1EYSezDQq4M3Twk095NFDs7cEQEaVVJF4ZuJIGsXATzGnyoGBzBJf/8KuayRJiEJEjHVqzfdCjOMeJlJMduemo8MBe8MGM63lIf1hN0ADAwZTQZgubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC9dQFytbP8WWf4lDCJEbcnhYliz9UOAvWbMAyvC4Io=;
 b=IbVWY5jZ0rd1U0q8QXLhis90h8VTvU0nOmQqj7flnQeDR3I9e+x24n/g/SpuaBw02B5WQ4ZMoR/BiVVHSLEwQjSxYhDdmefIHKnoLMmceGE+iN2OQbIvcSCmcIdFA6LBSq3phIET6MegOo/IsOIUQbWdaRdbuMceGM0POeHGVkRV52v6OhkzSnRSBULLZ2yq9Kn1N0jj7LggKnLYvbR9apNWpe91Nm+gQ4yIYBdLcWg7SEXIvUw5LjNa2W0KG7AewxFnFT8glsL5Kp/T40ynLMyEbGkxZk3UPl4Cjffm1/nNK4/9VMBu/VQ4fGvDU3Fl4b1ldwq/9odC7uf6pAuQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 13:48:09 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:48:09 +0000
Message-ID: <217dc739-05f5-a708-d358-ba331325d0cd@intel.com>
Date: Tue, 1 Aug 2023 15:46:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [alobakin:iavf-pp-frag 11/28] net/core/page_pool.c:582:9: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <202307292029.cFz0s8Hh-lkp@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202307292029.cFz0s8Hh-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: aea835c9-5e80-42c2-e5c8-08db9295f08f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vJtJ3djTLVEKGiOhNFZrLecYfsZK0+1AYW3Vo1uEf5PolMuHXmPxVUlgeh3kZuiFn/oqPbI3E7kFkkXAUfA7dLmwZ+iSa5HWPqKU2RZPCnosDvK+1fhGXeuSoVhMSmm5T5ttZ+9AGpS0zQRTyFqIin+VYloVgDiTM5lTVvNgrsRtikCXlsuUSf2reQtAx/E1HX8W10ytKeK9uSUVLs6oIYLhxNM9JJ0W8sCHbsUYcmc17PmoWR79umOA41RZgIjLP8h5UbJOrH4ooq3C4oIgzNsBPygv8CJ5ftas3Ja4Cp1r0hvl6js1q+Fn8tjzXj8OyEUdWxep0VNwDb6lYRxLjEISPKnVLrt/gisPivBgOuNgC8WQU5pf3Bb7gETR51OCccVpDY/TYXTrq3IXKk1ab3v1FrTY5CkPOHC09ieCyUTPCIrA5XGWEkdZGkzvIcW10kFqr5hOPXGcV+o/gudohn7JgsfZzeqz6C6cQ8F9RxFiaF/kXBeX275IFDbH/ZbHN4g1EF24EwoBu4jXPD5qUxmykrwa+uqkghE+m8QYEQeQlheWizWEkC/UZU1i1oaWXWbiyUWRyBhQPBUZ4Jwwem622zKbuIljFc0A3Nvj78YU6apuosNYEGxiY4lW7kyn8tlimVqQhLUwio9gsaPnzmV1V/DX3fMKhx7m3PRYNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(31686004)(2616005)(5660300002)(82960400001)(38100700002)(36756003)(2906002)(31696002)(316002)(26005)(83380400001)(478600001)(4326008)(8676002)(186003)(6506007)(8936002)(41300700001)(966005)(86362001)(6486002)(6666004)(6512007)(66556008)(66946007)(6916009)(66476007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDV2MFU2T1BHTnF0TDdRTXhBR0NLK1J5TTMrOC9lL1dOejJEYmxOWDRFTUpX?=
 =?utf-8?B?RFRNUlVwUTVVRFBWUG4ycEJ3K0lGclBnbHhqc1ZmYVlVMVpjbWRKQnl2NHBk?=
 =?utf-8?B?LzN5YWlQMmF3aHZEMnlNOEY1YkI3TkRMdmRFOHlXOENDc0VuMHB0ZnVGazY4?=
 =?utf-8?B?R0NVT2p2VlBrSXdjZkVVMzM4WCtkMGlQMlczYUZqTFdBbUtwcGdxYkNRTWph?=
 =?utf-8?B?aWZrVnFmOXRTVGJQY3h6Y3lsM1pYa0JvWmdXeXBuLytjL2VyZ1YrbGg4aE9M?=
 =?utf-8?B?RjZzUXFCUmRmZW54K2ovTjE4Tmx6cVEySTZKVVI0NWxsYXBaQmcvQzFXODRO?=
 =?utf-8?B?NytxTjhwUTB0ZzJKZXQyMEVaUzVqeGRLZU93KzlLNGlCdURhdEcwb0o1c3lz?=
 =?utf-8?B?Wm1vaGtUajlBcTlzSkJ4MU9ha21pa3lzTTFLamd5cC84MCtKNlNKTDZJOWtn?=
 =?utf-8?B?RHFTWlExazg4aTlZY0NuMzhPS0w5Y1QybW5ZOWZmQzAwajVvN0FXVVpMZm5w?=
 =?utf-8?B?TVdnWDdGVGVjZ25ZaFdvY0xBZ24rK0s5TTVxOWpMTjNVZCt0d0dQVUwrbGxN?=
 =?utf-8?B?aUdTU0VaaENhQUdrNnBEMlpOU3YyRFJpYkZCQUtLY1B5RE9lUXVqTnF0eEF5?=
 =?utf-8?B?S0FkV3JkeUVVLytndkhtaldoQnFDbS84M3pyZFZMa0ZxVUdlWkZyY3QrbW9l?=
 =?utf-8?B?ZnNOeUdVSEtDaUxRR3pyS3c2Und2NlBtVlJLVFc4T3NMTjlPQU9haXExNzQ1?=
 =?utf-8?B?TnFtUXVpSDlFMmxoVUZOMWc1dlljZkR6SXZMN1hnUGJIM25sYi9pUTl0TzFI?=
 =?utf-8?B?NUpGVVQvdURSUG5Da09DbWdrK2JHbEo1bmhnOW94a0NrMzZRMVRiR3VETVJM?=
 =?utf-8?B?TG9pK3NwcGI2M20xVEdoN01yRUM2Z1hkaXhROGJESms3OTRpdDNqOVJYaXZj?=
 =?utf-8?B?ZEVHbjJwN0M3dW5nbXJ2eitQUDlvZEZkQlJSN3l4WEZROE5Wbk9mNVgrTUY1?=
 =?utf-8?B?czk2WnlGMFZVeDZJUFVCZ1FsbTBHVW9xT3M2SnNMdnNpbU5Uak9QUGV1Qjl4?=
 =?utf-8?B?bkZIa1NKb1REYVRHekY1YkdyS1BjREszWnJ3QnYzYkU5cDFZQkxXekFUcDhj?=
 =?utf-8?B?TVlvTkx5aFBqUVRDUEVoU0JRckQ5ZjJOam9pMER3bXVxamsvWDI0alJqMWh4?=
 =?utf-8?B?empMdWdzb1RQQVd0bDFFTndwZTZOcE1tNkNjeHF4N0ZPMWFKOFp1aDhNMXdi?=
 =?utf-8?B?dEN0bm43MVNLb3JudkRJWkpmQ2JDaGR2dTQ1YWk5S0dGdTRZdVh5L3pMbkZk?=
 =?utf-8?B?T3dqdHhSZGdscURBY0dHV21Tb2RlWDlLcTR6YTV1TVVGWDc0VllRLzh3ZzI0?=
 =?utf-8?B?VXFtVjBvaTZpWUVkTUhKS3kvaUl3ZTc3OG0wMDRpZEgzNU9MalUzN1hja1ow?=
 =?utf-8?B?bExySWdDaEl4cjRJa05ldUU3ZGdVTGs4bjUyU3M4SWVHQjhVNEREeU9vVXFK?=
 =?utf-8?B?dnNGL09IVzNScmpobGNuVmxDcEpvODlxUWFoR0t2ZUUzM3MzaTRGUTdHLzg5?=
 =?utf-8?B?bjhGUVRkNUZoUTFBdGNpbC93QUNXUXA4NVZiaG0vRHNDZUM3Y0Y3bEZGUExz?=
 =?utf-8?B?MUVGWGtKWmlSVkNVU3ZFcTdqVVNCTFdjbHU2cTlIOEJZMytpRlJ1cUlvTDVw?=
 =?utf-8?B?WE4zZUp3eGlFQ3piYzRNMWhPY0xIQi9haWxISzNieWtRT09BSC96eFZCMlNQ?=
 =?utf-8?B?dWtUU1pSMW1teWNSaXRSYWQ3QnRKRGsvenR6bzhucE9nM1I5aHBPTUZUUzlP?=
 =?utf-8?B?RUlzdEI4d2JyN1k5Q0d4YzVRMlQ2ZldWREYvcDgvZjJiYXpBTHgwby9WdXkw?=
 =?utf-8?B?Mkx3ZmdCbGFpclo0VDFWL0tiQkpLQStyNm5PUWRDWkczODJMVFIzajI0b1hx?=
 =?utf-8?B?YjJBLzJUdVZPbHFJRlBTL1d6MUZOQ21tVnNhODErTEpoaDRjNzlnOFJoMS9B?=
 =?utf-8?B?LzZhakluMThVbC9zUFJNVmdNR2ppc1VzMnFNQU1xT1k1V2NBTzE2MXEycW5H?=
 =?utf-8?B?aXQ3RlZiNjAvYkY1QjFOSng0T0MySmFUZEpvZVMwTFJyT1BrZDBIK3ptckVD?=
 =?utf-8?B?RlVOZ29vZWdldTdDOUxadlhUcDZoNDlBYW5hZ3NhVXA2bXV5ZjdETWFwQU44?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aea835c9-5e80-42c2-e5c8-08db9295f08f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:48:08.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGpjz8rowqxr6G8ngHL2friG1jmz/kcWdMDy+CcgfWfdAtL71XtjCcSueWQQw25zyRD1mGMYgyIaaefNSDEFoSClUROlflWWtrG5TNVas5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kernel Test Robot <lkp@intel.com>
Date: Sat, 29 Jul 2023 20:30:10 +0800

> tree:   https://github.com/alobakin/linux iavf-pp-frag
> head:   0eccfd667ed84b425dc0c48eab06b0cb1d5fd8c4
> commit: 67f0169041f76c28d399c2a63947e33a1ae1210d [11/28] page_pool: add a lockdep check for recycling in hardirq
> config: loongarch-randconfig-r072-20230728 (https://download.01.org/0day-ci/archive/20230729/202307292029.cFz0s8Hh-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230729/202307292029.cFz0s8Hh-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307292029.cFz0s8Hh-lkp@intel.com/

Jakub, could you take a look, is this warning reasonable?

> 
> sparse warnings: (new ones prefixed by >>)
>>> net/core/page_pool.c:582:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>    net/core/page_pool.c:582:9: sparse:     expected void *ptr
>    net/core/page_pool.c:582:9: sparse:     got unsigned int [noderef] __percpu *
>>> net/core/page_pool.c:582:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>    net/core/page_pool.c:582:9: sparse:     expected void *ptr
>    net/core/page_pool.c:582:9: sparse:     got unsigned int [noderef] __percpu *
>>> net/core/page_pool.c:582:9: sparse: sparse: incorrect type in argument 1 (different address

[...]

Thanks,
Olek

