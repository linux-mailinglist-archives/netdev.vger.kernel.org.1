Return-Path: <netdev+bounces-22985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250176A4A0
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC95281653
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BDF1EA73;
	Mon, 31 Jul 2023 23:13:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649D1DDC1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:13:14 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA91999
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690845179; x=1722381179;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2fbeDuTEW1zPTvWovk4j/4h+6c6GmhNewCiIVihIp8A=;
  b=D4l+BRLuoXyJjQLFwbNo2rqHnQHH9EP7/06IdOtEnRdD3ln6kzXbDSBJ
   K6L84+HyDmSvuRIKvnsst0hAKXJQ7ZXFgSU4ObHM7wQjRj8pVxSl584P/
   C6mOrO6b39b6SVLXzrHmRiq4ExB7rRb4iND1jdeZE4AO4mqh/eEo97Bep
   T4EjnPXwxLIwzKw27XFo5NW4h8rzmA7e/9UZfee2RA2t8CpWT6LceBVx9
   iZVc+txsSfF/LMrdc/zmCdH0SfFhfRtStOKpTm+mf2R22dBJaamKLvjse
   QLMk+XBDrxcbqKTKfZo7eGgU+gl9IcM4RGw15IHHN9pZLORU2bvDFTfqL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349445456"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="349445456"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 16:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="678478346"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="678478346"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2023 16:12:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:12:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 16:12:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 16:12:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw4mfV1yXHVap4daj7mQqHk00TkywrRSXQBEeLrpJ/dLe+vFm/gNUaO47EKdeeJPpbn9TUmKUUf2B8H2z3uoG2FKCA0FfAjXrqNFAA6AhnL+RyqVD88M4Z0/QLnvyl40QshDBTyFMnui/dRg4ZBNxvSVu1rABi6n+7XjeSzFgFoSLF9Al3LJm59lJnpHVEhYcLd2UIZ2RkM5KNiw418oMIgNzNe8JXLR/btPil9W7hpmheWHrotehQeXiD8Jz4K73LMuVDw9BI9RnhrNyIozxnKeo8HX5mLBj092H7aMuKRKQZ+6MxSZOpOSJEs1l4bNl+srewS31B6L10DEhEO6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu045tgcuzMDkV6UNsKcC3zihxgEr63s0H/Pl9I3t+4=;
 b=joObGCtBCBt2qjdJ4UOceKcoSGIcS0P0+ZQWZZLj/Z9qhEvPNQ7qORKsaXx+KgVXksJ2NdpoYmzfybJdiF0CmSQZJaXv9VbfJ/iMmO8whx+qExFPMFQ9KzCtKz170rhxRt8/Ir3kwIoIdcdoM7PmzPEDCndGgZlzklUwNqIEP04QC83JEGc9iY9/NmjYqBmv2QHsguBhLRpQlYBEoBLd917lIv/TTJwfM6L4JUcGHRFPlS7b4Q0BcVo7F3hWdrca4IooKbq3+Zn+INSuD8B7N3B+/aSEBi6vlm/NfNT7CeZ8wPXSmUWK8Sw364P6GHo5hyFCFtrwS7y6Ht9wU4sIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM4PR11MB5566.namprd11.prod.outlook.com (2603:10b6:5:39c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 23:12:27 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:12:27 +0000
Message-ID: <6cb18abe-89aa-a8a8-a7e1-8856acaaef64@intel.com>
Date: Mon, 31 Jul 2023 16:12:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next PATCH v1 3/9] netdev-genl: spec: Extend netdev netlink
 spec in YAML for NAPI
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
 <169059162756.3736.16797255590375805440.stgit@anambiarhost.jf.intel.com>
 <20230731123651.45b33c89@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230731123651.45b33c89@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM4PR11MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cbe4af-d3de-44c7-dc09-08db921b9b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1iHqd3wx2AVSXBAo3HKy2yR+ZAWMYuBrgRPEfqu7BSs2g46BdAXffY1JQwJIhqgkj8w9NKrIKFtJsiklrEvWgQKp4vJIAYe/Tmsq0RU66s1nWJCq9sdudntm3k6rS+AauofGxFbqgKuEDpkYs/X4dCFwMJcsue3whZ0Bx3t5RLDgiPDvFWFz/JSJ/J67PWi0FanCIARcBZNlLEybFsHivta4WrqYzh7EiA3gtb9i+0Z8NfTd9bFmvWN7FVXWSq0Z5qf4HtLQlP7pk56Bp5bcAHCFOYjX8mn9NrZ0HmuvdQ0lLL74T8wzBNZknvbwYiuAQiHxvg86l6OdrEJ9hLZ6YbuLxabrgDKOEIhaon5yEiB0oe++C3/yjQ4m1fJ+3vSgUyKu1xcDVgB/cY5hCTspxrhV7SwPLi+JGYRwceZhGM1ZNWREqaWSzICelRfGJDwOKys/f0dt2M6csEX1nz5eVJuPLDmjmPfHyJ0Ysz3vZaBA5ljVMmUUTKe8fc0UPn1Ox7iFYzXTLoH9SK7DniHl5x4OZv+2JibaU/ulWgN1wWNJbrchh5jNCPAhoOIQ4jcJJGuiUSJjGAv2lUYf5kXExuYkb/EmoN0iar1fcwyI9Lzf4hUem5i3fH0rPmjy2difPowF2BHDP+RisHJoHek/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(6506007)(53546011)(107886003)(2906002)(186003)(26005)(6512007)(2616005)(5660300002)(6916009)(66946007)(316002)(66556008)(8676002)(4326008)(66476007)(8936002)(6486002)(6666004)(86362001)(478600001)(31696002)(41300700001)(38100700002)(36756003)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVYV3pkbW9nRmVmMG5GZFpRUXpTVGVUOXV3RVZNQkc3YkU1elBwc1ZOOHlo?=
 =?utf-8?B?MktOUERNREpuZy9uWXhFUVJZSzl3ekRnbU5xN3FHb3dwR2RPcU9IMnlXSVJt?=
 =?utf-8?B?czcrL0ZETnNqWmdiTVlSLzVPMkNCU2ZLSm0xNkM1S1lvNy80Z0NBMHoyQThv?=
 =?utf-8?B?eXVWV3VjZDZObzhvaWhhSDhSTlhJTkxiRXl3eHJZa09TY0xRdWREZHpVQ1Ex?=
 =?utf-8?B?cVplRDU1MTJRWDFkR2IwNG56VkRabEJBWGVMSnZ3dG83RUd4ZDA4ZXJhSE5t?=
 =?utf-8?B?TW50M1lpWFZsbUxsK2NxTExlYzYxTDRjaVIxbkxubks2NkZnWG0xT1lmT3Qz?=
 =?utf-8?B?RzV0Snh3QkloMGpsZEJzdWMvZGE4ZVlQdS9qcS82L3ozWWNJOENrOTFIL2hz?=
 =?utf-8?B?UHNYZTVRU2NwbmpPa1Bkd3NjbVBNdnpPYlJNOEMvWGE3ZUVnY1V2UjNDNEFL?=
 =?utf-8?B?ZWhRUG94RzFSVm16eFRhVktoWlBTQkkzUkhrRnp5cytYZ3FDOVYyOTVRRlZ1?=
 =?utf-8?B?Uk5KM1ZtSys5aHJ4dVpEZ1l5ZExIYVZiVWpYcnNLa1lLclQzVURJcnZiRWpp?=
 =?utf-8?B?K21kd2d5RE9YRWxLZ1YzMlFpL2huNnhJSWF5eldjWElYYWo4anBPVUZwdE1O?=
 =?utf-8?B?bGUrU1JxOXVxRklid2Fab3pER2gvaHZ4bmxtVFcxQkpXSjk1MFZSRU1BdHgv?=
 =?utf-8?B?c0lJT01XYjZWMUFnVWZIdEI2N0JJSU9UR0dnU3JER2NYbkt1eWJvZENsdUVw?=
 =?utf-8?B?L25rUUVsd25ZZXg4NjVTU3VzaHBCV2lzQzVBTnNxREtDMlRONlJMTlFZZkNU?=
 =?utf-8?B?ZXRXMHNCYi9idm1Xc0k2SzJIRGxpNnpqQjIxSkxhZ0lHRCszRWtFeG51SmF4?=
 =?utf-8?B?V0ZwMis4RDU5cHh1N0VtT0k5S3NPZnY4TXVIb0xHZitmRndlK1hFNE1aTjBr?=
 =?utf-8?B?WDdaT214VHQxVTlMUFNBZm1xNUgwMTdYM3dVcDRDQXc2WFFQa1FrbWtEbjk2?=
 =?utf-8?B?ZTJJeUhZa1JMOWgvRGhvWmlPS1JLamtRVUxja2U4MVNRY1ZDWFY5SU1PcVVv?=
 =?utf-8?B?QTJVUXVUMTJadWJ5SHVpMzhabE1hNm1hRkxnaGdBZzFlb3RyZXBvSFRSKzR6?=
 =?utf-8?B?YTgrMDJnTEVZbTBsRXpXZWZKNG9TUEhBM0dYQXZydytvNTlpTFdyUnFPcHoz?=
 =?utf-8?B?WHNJazdNYTRxaGFtS2d6OTZXWXhyNkhxTVlja3Y0Umt4NXFiOTZVUE1kYTFV?=
 =?utf-8?B?ZGFrTEVpcjUzc0JMUDBvNHNVRzBXS3BjdkFTV2ZvckQ3dFBORFFoRmE0TThV?=
 =?utf-8?B?d0RSQVFEd3cxemRxK3h1ZUJjd1dPbHhQaEsrdDBuWTk1QlJENEg0MVdyRjl0?=
 =?utf-8?B?ODZTMG9OTmMzT3BMS2d5clRodjVvakJrN2FHOEJCQzZjamp3dmI5UDIvRTQ2?=
 =?utf-8?B?S0taK2c0bFFBMFVCTG1YcFJKNWRIMWdCQUtBVVpnejBhZjIyUzZZY2xPb3Ba?=
 =?utf-8?B?bk5iQklEYXJDVHVpRXlhVy9oZ1Z1TFNlVVJWZUtSRklBaWNxcTZqRXdwbUdV?=
 =?utf-8?B?VXhIYjROODdtT054MmpuYktXWE52czVwTnFjcmE4ajV4UEF1QTFXWlM3K3g1?=
 =?utf-8?B?OFZRNFNuVWFDZEVvNC9hVGZWTnBUNjBQcU10dW13S0RoVmx1ckRkMjU4NGVo?=
 =?utf-8?B?U0wyK09ITVN3cWp2T0huWXpJaGR6V2ROS1RyNHRUckMwREFnQnFrT0QrczR0?=
 =?utf-8?B?ekdTMzNROVlDay9oSEcrc3pYN2xQWWRxSUFqQUpDb3NJbHNrZDdTYVFRUVNK?=
 =?utf-8?B?TGhUVkhPVUIyTlVSeHluSlhJRmMrczZFTnY3aEJGWXhBV3d3Yk82bXRuR3Vi?=
 =?utf-8?B?OW5BbktFM3RtRGF1b0FIUENIQUJKVUVzY1BRYjhxT0JVU2NyTUZNNTE0bFpt?=
 =?utf-8?B?Z0pNaWVvc01CNm1NbGdjQ3JhbUFoV0txSCs2V2UrQXYwSWRCUmxEUFYyM2Zi?=
 =?utf-8?B?aWhBaDIyNUhvOUg4V1JpSi9WdmZZT01PazQ5ZjVZMVFGVG1zWXJGdThWa2FC?=
 =?utf-8?B?SlN4KzRTQndZOVYrRk5ERm0rZSsybjBzc25tVEVPZEYwR0lUN0M0R3JqM2dw?=
 =?utf-8?B?aFVTcGlUb0pNZ3JKRUp0N1RCc1liOVFuS2pqK0Z2ZlhEc2FhSllPeVUzME5S?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cbe4af-d3de-44c7-dc09-08db921b9b37
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:12:27.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzbPKzleQ6pE2axV8MoMXE8t+/s1uNMTo7W4CjkV06jppKyikLiHirgVez0OYi8wjSIebYa60NqgqwNI7t9VNnDdsucfQXIWlF+C39PhTPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5566
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/31/2023 12:36 PM, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 17:47:07 -0700 Amritha Nambiar wrote:
>> +  -
>> +    name: napi
>> +    attributes:
>> +      -
>> +        name: ifindex
>> +        doc: netdev ifindex
>> +        type: u32
>> +        checks:
>> +          min: 1
>> +      -
>> +        name: napi-info
>> +        doc: napi information such as napi-id, napi queues etc.
>> +        type: nest
>> +        multi-attr: true
>> +        nested-attributes: napi-info-entry
> 
> Every NAPI instance should be dumped as a separate object. We can
> implemented filtered dump to get NAPIs of a single netdev.
> 

Today, the 'do napi-get <ifindex>' will show all the NAPIs for a single 
netdev:
Example: --do napi-get --json='{"ifindex": 6}'

and the 'dump napi-get' will dump all the NAPIs for all the netdevs.
Example: netdev.yaml  --dump napi-get

Are you suggesting that we also dump each NAPI instance individually,
'do napi-get <ifindex> <NAPI_ID>'

Example:
netdev.yaml  --do napi-get --json='{"ifindex": 6, "napi-id": 390}'

[{'ifindex': 6},
  {'napi-info': [{'irq': 296,
                  'napi-id': 390,
                  'pid': 3475,
                  'rx-queues': [5],
                  'tx-queues': [5]}]}]

