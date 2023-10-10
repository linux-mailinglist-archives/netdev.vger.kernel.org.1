Return-Path: <netdev+bounces-39756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455307C4530
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C901C20D21
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E2A315B3;
	Tue, 10 Oct 2023 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADBaJzC7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C9354E8;
	Tue, 10 Oct 2023 23:00:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DBF9D;
	Tue, 10 Oct 2023 16:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696978841; x=1728514841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zDyodm8xjd1hWgbH5J3NsjkQgjGoEiJmm7rUciicDFI=;
  b=ADBaJzC70qMxTWxjXRuq8oDITe5kLj6HhPiR1/d2alfoaPjoO86a94uX
   3qtodYhsAvHjCK7/WlgPklqdD/HAZncZ9Fzt/Hg/xozb/2Z1VMqG8nYvw
   CfyypnzSUagCWMXJqexOrnHUzG44sOao/s8T9/B7JVduPdJQLuwhhXkDv
   7Nzss1LZGqTs3U19GN54uM2I2x7b5KCbu1hEneFSZgw8i9fFcLR+b2gp+
   H4kLLDh9PWj9qHIn2cdZU1nyDnYAh4u2A2+ywRsf1zsmKAfVEvUvhaO9y
   reZuDGLq6T8U7bb4ZYNnt52n2TIFVyeG2uHPNUWErB+7Zxy3UcV+Ff0x8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="448729941"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="448729941"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 16:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877437672"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877437672"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 16:00:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 16:00:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 16:00:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 16:00:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 16:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShIVopQvOlStU2MzC2t95s1lTsN5WCYrhNvJND3sbXx3K4Nxso0i6/VkpvSQQHhUeXS5RnkbShhF6UimjYTOYjSIUn5caO3Z/qyybSFa2hEFd+CIgbghtf90GQfT/rpgYZfp1Tmdv0sfFCwOyPyaL1iByOyUrte1iy2XubGvE+PGKPT+KFukVkjUiS9eKjMFhwUWDnxZ7YTi/8BRKoehp8irvqEIZ0FgUumvWjruwP6EoVUzibHd5gu4+sETXX7p5ToNBwpMhVa4/h7cQW0wi52IkjzaG4bobPXmrTOrrXXrmowiqmcgM4gRQjoolLUUH/03amWqsBu6J8+4YTrrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP2bpksB98r+/5B459fMl+WmjnuTQ7Uzyt3e0pW/ZrU=;
 b=cL/wwlOK195X2A/tpHnvy2NlT/w89ltgnATOb0kFkU1vHPDUn+VRLWh89MeM8WUmnH83NdjCXC15bh8sIOvpaoiVKe0rvu9h0F2D7hZ63BwkT9i737yzO2OBONzAbZ/FpjxHxF+Ynq89FpEqxHUyIkKHMSmrCVbejHH+X54eYeH4Ln5dT6Gw/CxR1k7j+REd4+BtVa8z+ZRb1qKZ5TDe/mPot0gSZT78c1h+N5oNqDBnEWHhTFR0hDTwhX1mm1s2O7q2onIiR9JXmS5HZAt8l7skc4pb20eU0eyhsj75cc2D03zQs5SiEjLvJE8l3dAyskp0y90fBAK6AEkt7TDhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by MN0PR11MB6133.namprd11.prod.outlook.com (2603:10b6:208:3cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 23:00:15 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::bf37:874f:313d:b7e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::bf37:874f:313d:b7e2%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 23:00:15 +0000
Message-ID: <bc8fe848-b590-fa4c-cc6b-5ccdf89ce0fa@intel.com>
Date: Tue, 10 Oct 2023 16:00:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 5/5] ice: add documentation for FW logging
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <jacob.e.keller@intel.com>,
	<vaishnavi.tipireddy@intel.com>, <horms@kernel.org>, <leon@kernel.org>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <rdunlap@infradead.org>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
 <20231005170110.3221306-6-anthony.l.nguyen@intel.com>
 <20231006164623.6c09c4e5@kernel.org>
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20231006164623.6c09c4e5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|MN0PR11MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb04b26-0049-435a-7003-08dbc9e4aaa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mud5bOLxkfCsx0nT+eXpl/dQPKJ4n9JsR5LVFx/sq25//5c35C0UQ80TXKsMJCM8Cxpb57uYRVCoBPlZzuwyUXZomnWkBLB180T1m9yX3HCNrM/zMd0kraRxei3qYttQHErDMmfNxdeBcU1ama0kDo0Swle1Y2wTcRjkMa6lJs6EsuzebfrDCiW0oYO6yXtL0M0tAmVxLG4YyXkWqKvyCGogAWxKzf5Dfc1CoDMr6yFmEeRKaqTQ4PLbcFlmU3fWI8Jpn+bo8Nb/u15y8sSuIghM9gNXiN49F3P8pOEbYsfzs2ZUBAj2t4lJgqvv6tm2qleukVRy85HM1Ziy/wiTD26GgGZfQe92L2zDpcYVkUidcjW/jBiFMYcGC2RpwE+FmBRvRWMBC8eak0g2QfMVkYqIai7z+ur7hzi2iDWgJudvgsLBZVv1fNxuGXIOhFbJoOTeIqa4aImUSINadyaszy/4BZlxrxOKH/C8XtNgW9CvInl30leGbcuOU/W49eyen6OH2BcwB5WyUaxg0d2zpZxZUlqY6BN18olu3q6GYq0qra17rxJe1xCz30I+jgns3jCeYqZKPnKD3GxDuU/ysnhfw59ATXwPCFk3WpkOLyss+4N22/SM3uUnvA2eg8ibFHJHTyA6Qzgtro1KiZonqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(31686004)(36756003)(86362001)(31696002)(53546011)(7416002)(2906002)(478600001)(41300700001)(66476007)(66946007)(2616005)(5660300002)(6636002)(316002)(66556008)(6512007)(6506007)(110136005)(6486002)(26005)(8936002)(8676002)(4326008)(38100700002)(83380400001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhscDBhMmVWY2VMYTF3KytiT2hJVk0vcHB1cUFsb0I4dmJOaGdzR0Y0RWU1?=
 =?utf-8?B?cm4xeW5TbHZiM2NoU2V4MXdUM0xDMUxlOXBGUlVrMkRxRDYyV3QzaGtyQW9R?=
 =?utf-8?B?YVJhMGdrQjhGN0FLb2JLUEVYYUpIZkVGUG9Pa3FHWU9uWjdBNksrQjR2OTBQ?=
 =?utf-8?B?U2dUckl5VkcxaDFaNjRwS3A0WTlmQmFaanFrUTRERXFxVFFlbHNKekxXYjdl?=
 =?utf-8?B?SHJsSVJFYWtORXpiU0VmSE9kVXlhRDVQcDZqSmlKa2Q1RU1jOVJYZ3BrWWQ1?=
 =?utf-8?B?NkJ1WHVPdjdxa0x5bVNsTXpuOHExUVMyOCtZTkhiclVRVk1ONC8wdEgySXdX?=
 =?utf-8?B?ZTluNi9oMTZ5NG0wcEFMai9HUzcrbFJiVUJ4STVRTWJ6d0FkR0hGdEc3aGpH?=
 =?utf-8?B?NHUvbWhhRDF5QmoraS9JaVlaYkd4Q3hlNnd0eHlPQWd3aXU4MUtDRmhIUDlz?=
 =?utf-8?B?Tmdya1R2TUdQNGM4czN6Tk12Q2l2aG1IZ2hlSzVTSGk1eVluYlptUFU4dmkw?=
 =?utf-8?B?NW5XVkd3b2NJQzc1NVd4ZjZZeDVXbnFSMEdZV2pxU3RtTkNLSlhlWkQyM2hT?=
 =?utf-8?B?ZXFCaWtWOWhhakVUcDc5eHE1ZGZSeWRuTklkKzZ5Z0l6eCtta25YdzdEcExZ?=
 =?utf-8?B?ZFAxbHluK2tDYjd2TVlncUVqTjFTT3NUdFhTYU8zQWxQRUEvR1l5V3JjaCtO?=
 =?utf-8?B?Sm8xS2tZUmgwWTJxdmdWemVUR2c1eklwNjRJZ2IvZ3VXVzJzbUEvOHRNUWU2?=
 =?utf-8?B?VmU1YUR3OVNpcTk3Vk9rK3pwS2lkbDh2dWFLV2dSdkFwQUJUdE9kbEtkcExt?=
 =?utf-8?B?aE4zNG9EMm5zVFk1cEpvN2NNc0ExQjA2V0RCVXZ4UWtRYlNaaENWYXlLRTZS?=
 =?utf-8?B?TkdqT0xFanEyeVdHVjByNXlJOFg2OVNlYW03a09qQUF6Qzh5WkhpWEtsRHB2?=
 =?utf-8?B?d1dTWDh6N1crbEdBVlBoZGxIQ0E5cjU4SnhlYnJML2JYTHM1S2wzSURhcnF4?=
 =?utf-8?B?bUxkMDFBc2pKUGpjMDk3cWV6ak5GWHNrZWdaVEJCVElRd3FsaUlCekJMQ2ZP?=
 =?utf-8?B?VWdOS1cyb0xiZ1hhTUJ4OUd2UEl1dFU4eXRRM0U4TDdOU2JzRXl0ZFJlT21r?=
 =?utf-8?B?dkM1L1A4UU1uQXZvQm91enFGbC85czQ4ZmMvcjJzTURjZUlGdC9rbGdDaWp4?=
 =?utf-8?B?VHVCa1VOZ0NDeUlhS3RybXI4RDBHcVYyRy9JN2NkTVRrWlNtTzJOK3QvWGpM?=
 =?utf-8?B?VVhHQmtETHVVSDFJRHllNjA5aUpjckRjNGQzcjZKYU9mK3I5cE55TU1DSEEv?=
 =?utf-8?B?dHVGQ2dxcDg1azBtVmwvckQzUHowdnZmckkzMEJtZHZpM2Z0c0NiSXp1L1d0?=
 =?utf-8?B?TVFLYkhQdU1iM1Mwbi94eVNiVHpMOHVMUXpuTytxRGxxOENETU5YSmFlRU1C?=
 =?utf-8?B?VkszaWxxSE1sRGJjakkzdXEwSTJnNlZwSSsxa2dneTFRSkVMSE1wUXJUQm8v?=
 =?utf-8?B?NTJsVkZxM3hNVGpYbzFiZ21TckRFUnMwNDMzWVIxd1BOb2haTE9OWW5DUkFx?=
 =?utf-8?B?ZHdzb2JHaC8xVCtKVkNIRGFIemlmMDhXVUZDR01FSFVYc1lrRzhBN2I3Ynda?=
 =?utf-8?B?dnk3WllsYnVSUHJsZFM4UEtKRi9LT0tyZmFWQWRRVHpUVDBHWFVNL2Jzak1V?=
 =?utf-8?B?cElta2VibHg5cTBwdk1JV1VmL2RhRGlVV0tNU3BwWkJLMExDNmJ6MS9wQnp2?=
 =?utf-8?B?Nkx2L1BOQlQ0ZjBaMmdpVi9ST3dkeG5tRVR1dXVBMlRqcWNYVS8zbGtuejBv?=
 =?utf-8?B?ZWpCclVTSFpWNk1oQ2lXSVM4R1BIV1VtazcyUG80Y243VnN5SlMwcmttYi9L?=
 =?utf-8?B?YkZleDFKWHgwaVVlWDJXVThvZHMzbHdFQkRJa2J4WGJjcGJCcGUyek8yTmFS?=
 =?utf-8?B?RjNSZ3M1THh4aXVMU1N5eXhlbTEydkM2WGpjSmREdVREdnRwdHhMZXRFYm1H?=
 =?utf-8?B?MEVUR2hKbmxxVWd5aFl0bVB5cTBiUWxyOHExRHJFUzBsNGxoMnVMTmVoTzFi?=
 =?utf-8?B?L1FleEpzWHJCMGRzYThaTktTcjFNaTF3aEZnOWlNcjBOZDJSV2o4MEtrTFc3?=
 =?utf-8?B?STJKbFB0TFFSd2VFYlJwZlBmb2swdDllWUtkOGo4TUlVSDhlcXVBWEQ4Y2Jj?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb04b26-0049-435a-7003-08dbc9e4aaa7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:00:15.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1qeXFPWvABn9hHiTDfxRR8+OPKQpZRTBsNKDqQneB4Pm6mGRxtMjsA/tXY7ZNpgrelD93Avpzfr+UC3BvfikB3ScBCH5StjYPTwLeitBQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6133
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/2023 4:46 PM, Jakub Kicinski wrote:
> On Thu,  5 Oct 2023 10:01:10 -0700 Tony Nguyen wrote:
>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>
>> Add documentation for FW logging in
>> Documentation/networking/device-drivers/ethernet/intel/ice.rst
> 
> Wrong spelling, I think, because no such file.
> 

Sorry, hyphen vs underscore issue, will fix.

>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
>> +Firmware (FW) logging
>> +---------------------
> 
> I think you need empty lines after the headers.
> Did you try to build this documentation and checked the warnings?
> 

I believe this to be correct. It is the same as the section above it for 
GNSS and it looks correct when complete. I did run 'make htmldocs' on 
this and I don't get any errors or warnings and the page looks correct.

>> +The driver supports FW logging via the debugfs interface on PF 0 only. In order
>> +for FW logging to work, the NVM must support it. The 'fwlog' file will only get
>> +created in the ice debugfs directory if the NVM supports FW logging.
> 
> Odd phrasing - "in order to work it needs to be supported"
> 
> also NVM == non-volatile memory, you mean the logging goes into NVM
> or NVM as in FW in the NVM needs to support it?
> 

Yeah, I can see it as oddly phrased. What I'm trying to say is that the 
NVM image on the NIC has to support FW logging and if it doesn't then 
the 'fwlog' directory will not be created. I'll take another run at it 
to try to make it less confusing.

>> +Module configuration
>> +~~~~~~~~~~~~~~~~~~~~
>> +To see the status of FW logging, read the 'fwlog/modules' file like this::
>> +
>> +  # cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>> +
>> +To configure FW logging, write to the 'fwlog/modules' file like this::
>> +
>> +  # echo <fwlog_event> <fwlog_level> > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>> +
>> +where
>> +
>> +* fwlog_level is a name as described below. Each level includes the
>> +  messages from the previous/lower level
>> +
>> +      *	NONE
>> +      *	ERROR
>> +      *	WARNING
>> +      *	NORMAL
>> +      *	VERBOSE
> 
> Is this going to give us a nice list when we render the docs?
> White space looks odd.
> 

Yes, it does give a nice list

>> +* fwlog_event is a name that represents the module to receive events for. The
>> +  module names are
>> +
>> +      *	GENERAL
>> +      *	CTRL
>> +      *	LINK
>> +      *	LINK_TOPO
>> +      *	DNL
>> +      *	I2C
>> +      *	SDP
>> +      *	MDIO
>> +      *	ADMINQ
>> +      *	HDMA
>> +      *	LLDP
>> +      *	DCBX
>> +      *	DCB
>> +      *	XLR
>> +      *	NVM
>> +      *	AUTH
>> +      *	VPD
>> +      *	IOSF
>> +      *	PARSER
>> +      *	SW
>> +      *	SCHEDULER
>> +      *	TXQ
>> +      *	RSVD
>> +      *	POST
>> +      *	WATCHDOG
>> +      *	TASK_DISPATCH
>> +      *	MNG
>> +      *	SYNCE
>> +      *	HEALTH
>> +      *	TSDRV
>> +      *	PFREG
>> +      *	MDLVER
>> +      *	ALL
>> +
>> +The name ALL is special and specifies setting all of the modules to the
>> +specified fwlog_level.
>> +
>> +Example usage to configure the modules::
>> +
>> +  # echo LINK VERBOSE > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>> +
>> +Enabling FW log
>> +~~~~~~~~~~~~~~~
>> +Once the desired modules are configured the user enables logging. To do
>> +this the user can write a 1 (enable) or 0 (disable) to 'fwlog/enable'. An
>> +example is::
>> +
>> +  # echo 1 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/enable
> 
> Hm, so we "select" the module and then enable / disable?
> 
> It'd feel more natural to steal the +/- thing from dynamic printing.
> To enable:
> 
>   # echo '+LINK VERBOSE' > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/active
> 
> To disable:
> 
>   # echo '-LINK VERBOSE' > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/active
> 
> No?
> 

I like this idea, but not sure if it will work or not for us. What I'm 
trying to do is reduce the number of AQ commands we send to the FW when 
configuring/enabling logging.

What normally happens is the user sets multiple different modules up 
with different log values so my initial thought is to allow the user to 
do all the configuration first and then 'enable' that configuration. 
This way there is only 1 AQ write to the FW instead of a bunch of them 
and we know that once the logging is 'enabled' then the data we get from 
the FW is the data that we expect to see.

If we enable each module individually then we are going to get data 
coming from the FW as each module gets enabled. That can get confusing 
to the FW team as they look at the log data because they may not see all 
the events they expect to see in any given time because the event wasn't 
enabled.

>> +Retrieving FW log data
>> +~~~~~~~~~~~~~~~~~~~~~~
>> +The FW log data can be retrieved by reading from 'fwlog/data'. The user can
>> +write to 'fwlog/data' to clear the data. The data can only be cleared when FW
>> +logging is disabled.
> 
> Oh, now it sounds like only one thing can be enabled at a time.
> Can you clarify?
> 

What I'm trying to describe here is a mechanism to read all the data 
(whatever modules have been enabled) as it's coming in and to also be 
able to clear the data in case the user wants to start fresh (by writing 
0 to the file). Does that make sense? I probably wasn't clear in the 
previous section that the user can enable many modules at the same time.

>> The FW log data is a binary file that is sent to Intel and
>> +used to help debug user issues.
>> +
>> +An example to read the data is::
>> +
>> +  # cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/data > fwlog.bin
>> +
>> +An example to clear the data is::
>> +
>> +  # echo 0 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/data
>> +
>> +Changing how often the log events are sent to the driver
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +The driver receives FW log data from the Admin Receive Queue (ARQ). The
>> +frequency that the FW sends the ARQ events can be configured by writing to
>> +'fwlog/resolution'. The range is 1-128 (1 means push every log message, 128
>> +means push only when the max AQ command buffer is full). The suggested value is
>> +10. The user can see what the value is configured to by reading
>> +'fwlog/resolution'. An example to set the value is::
>> +
>> +  # echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
> 
> Resolution doesn't sound quite right, batch_size maybe?
> 

I agree, resolution is what the FW team uses, but I'll change this to 
some other name

>> +Configuring the number of buffers used to store FW log data
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +The driver stores FW log data in a ring within the driver. The default size of
>> +the ring is 256 4K buffers. Some use cases may require more or less data so
>> +the user can change the number of buffers that are allocated for FW log data.
>> +To change the number of buffers write to 'fwlog/nr_buffs'. The value must be one
>> +of: 64, 128, 256, or 512. FW logging must be disabled to change the value. An
>> +example of changing the value is::
>> +
>> +  # echo 128 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/nr_buffs
> 
> Why 4K? The number of buffers is irrelevant to the user, why not let
> the user configure the size in bytes (which his how much DRAM the
> driver will hold hostage)?

I'm trying to keep the numbers small for the user :). I could say 
1048576 bytes (256 x 4096), but those kinds of numbers get unwieldy to a 
user (IMO).

The FW logs generate a LOT of data depending on what modules are enabled 
so we typically need a lot of buffers to handle them.

In the past we have tried to use the syslog mechanism, but we generate 
SO much data that we overwhelm that and lose data. That's why the idea 
of using static buffers is appealing to us. We could still overrun the 
buffers, but at least we will have contiguous data. The problem then 
becomes one of allocating enough space for what the user is trying to 
catch instead of trying to start/stop logging and hoping you get all the 
events in the log.

I can drop the mention of 4K buffers in the documentation. Or we could 
use terms like 1M, 2M, 512K, et al. That would require string parsing in 
the driver though and I'm trying to avoid that if possible. What do you 
think?

