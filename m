Return-Path: <netdev+bounces-30530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93219787B77
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 00:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406FD281690
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 22:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D167AD33;
	Thu, 24 Aug 2023 22:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC99A93E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 22:26:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C1C1BEB
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692916007; x=1724452007;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RPPfb/6cFbHAZ26HgthOUNL3CRDMqxJS3bitPTWp/zI=;
  b=AjtM+o7d46f2OMghFFZEicI3+t6FNKrvRdTNdvx+1T9Cp3WnBUe8oLOy
   i082iqpDhrH7GKmBzfMC0uB7AVyIckviWipw8FFHbYYURg+y5UKVGIKTJ
   6312Y0QVvPY8dkZKoKZws2OXfOTk6UXMsFHa6c5J4S7uVSHlaJAdwg0lI
   cw4dBqSV3N55PoC97qEsa9kn08BzBReJdplVumKzcxqC7qmjfxzJY3l3L
   38KY2H6AGmKSqqUMevN69oHAh7IX7sh8gRzfMxGSWdFXCwPn6tgN0540y
   QqlSG8Pv+CpGi9Cx1HTasWU06IO/4H0yykx3gi5S97NnHiRGtnAS1YYoR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="438516754"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="438516754"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 15:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827346667"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827346667"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2023 15:26:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 15:26:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 15:26:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 15:26:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 15:26:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrIjvJDyT1DOd0Tl6nMMfifn997XIYsNgn6x1vQ4+IuixIMPdbjrr3Z+y8MizUGtvzYSimXMBo6aAfCBdvyWj6g7sHqzrtw7AQKDZHQEFNu00SbPlcw+iGS1Z1N4mxPiAw5SAAy/3/QorGfgcJA5nZHC7VQArO7aPOv0ktq2AgnfgvK9bEGXd30lEu1nobU7Et8g14o9BG5MhAFYShyk87ny5cezwFnwjVXcfKGGpVzGmS6IMExrBmyDEzgJs6bV/g2bfsUNY11TZIWYxlPO0zssFussVHzUF4MwoB/UoDfJAlusOndPhhFlcOo6kYqIGTfYteWENo8WdTNE3yqdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArvVZGjjPrkBhh/aZHYKwYSyncetv4Kev/A1q3RJzts=;
 b=HXDD0kdHtlfO4+yQB5suMazx+tKjZYNHfIgDP5BURSRSlbBDzx+rfk7DCGD2nFuaSssBEBbBgLanFtRzf9oqwomDh/lwDMAyxx+DlfQIAxYIM5G7i7FQRGSRM5W+gw3Uri7jwaR1oEmIin2ocRcFnLhZnquL0tIcz0Hxc63Bn8cmaaR4Dv6EYrTHKlhPEdl8JKheWrrUAWre2bCACVCdCCuSQ9yoIDQefnJ0VwvRaebXfxaa28fVJKit/F1SBSROdoH8UttTMeaYtSquVt4lhGbDwZdpOk1jj21Nb5w2xzvLAoObEEWml+1EIgOO0HpAEFJWiDxUbu7U7aXCYADSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by MW4PR11MB7054.namprd11.prod.outlook.com (2603:10b6:303:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:26:43 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 22:26:41 +0000
Message-ID: <bb43b222-eddb-47ea-a36e-84415227439e@intel.com>
Date: Thu, 24 Aug 2023 15:26:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 3/9] netdev-genl: spec: Extend netdev netlink
 spec in YAML for NAPI
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
 <169266032552.10199.11622842596696957776.stgit@anambiarhost.jf.intel.com>
 <20230822173938.67cb148f@kernel.org>
 <d4957350-bdca-4290-819a-aa00434aa814@intel.com>
 <20230823183436.0ebc5a87@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230823183436.0ebc5a87@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|MW4PR11MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: c6de697b-56c3-41e5-2e15-08dba4f1307b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyWlJmwfh1wwBHQ37G/Osr8DY6G1xfYxKvlffhRotVkp/b25TVFxQsK8bnHq6sArYxaMrV3t0A9PWpKViJK+ZRrWrM7XrQl6rbRFOlC1ZFz0wepxIx2NEJZxShiCp6mKQcdaw2PhQB3WYEKpbzUByXCtFkfkhCeD3fgxhf4Fzf/FrkJxO3Rgx5/lxIQmmXq2DbMN2T/jftFVufG+YgtZhWie3iAPHQuf/bYqcBgJo871a/sdZ/czd9jATtG3unEtf0z0SgRNq90DoOx4zRtf72v6Sr8Vnq0Tm1QogG5jXbro3+XHvasBUzTcunnvrMM/Qp8XBQmlZUp1bRVW3UTAjTUJ7Hi/NCL2neTa9zSUkePyrB38laF3b6d/dLPHTp/55ohqbluesc2mvGW6oXwJuj3v6Va6UFD7uR8yHRF/no+kUbO2/ew64nG1/MknNlSsFLgd6n3JSkFDLcL4p1YS72vSokQ88tnoWIk58tgB2/3wQJi8xagKzwJyOvM6Qhm27CdOXh05onzqIgtYDGnG9wkq35V3wBVhu1rTR9BaT25Tb2ARTXzCo0JPa+566jRiCrdCh8GDHJhdTUEC6NFW7UBbbVbhms7ZwV5IEYMN26YYFS1n+YBFiSe9rVAJW5gG4ZCO0D2LfFH8tp4xlkAhww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(107886003)(4326008)(8676002)(8936002)(36756003)(26005)(6666004)(38100700002)(82960400001)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(31686004)(53546011)(41300700001)(6512007)(6506007)(2906002)(86362001)(6486002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1VBU2sxbUM1UGt0MjRLcWpsdWs4MXJwVlRDTVJSczAwTzVydTZYVTZKZG05?=
 =?utf-8?B?OEJzVWJZaFRZT1EvTUNOSUFwdXp5V29wdEVBTGZGemdnVmd4VWJCTyt1Rm00?=
 =?utf-8?B?TGdqUTljdlZMbHBwcmRtalpnWmdDZlA4TTVmWXQwbk1mc3VrbG5lQitzRDFO?=
 =?utf-8?B?djZISTJicWhwemFIQnY2NkZIZlQvVklZZXFLb3lXaGNQT0ltdVB3S1hyTSt2?=
 =?utf-8?B?VEl3Vm1lcWt3UGNmdG5wWkRPUU1QcUhobXFiV3dyUzNiYmNxUGd1cW14UGdK?=
 =?utf-8?B?UmFmUngzbEN6RXBBb01ERUJqZDJMVlNUTi9SOUx1VU94WlRZNndkczVyb3g1?=
 =?utf-8?B?bkZZWm9Uem5HRXpLOWtiUG5ZU1NlWW0wMU5ja2pZL3JyMjRCZ3JZaE42aWcy?=
 =?utf-8?B?bjFoMkdqejA3MXl2Tk4vRFBDQXNHU1czbXV0NnBJaXgwaWlrTVptTEVZcEV1?=
 =?utf-8?B?bXdpWi9LMHBGOUQ3OGppOVVHOHhNMjNxekdCWTRPSlBZK2tjcDgyQmlvMzc5?=
 =?utf-8?B?Yms1bDlsd3ZmUnBYbmNiL3Y0MnlHRkNMaFhpeCt6TTN2Y3A5N1kzdkxjYVJZ?=
 =?utf-8?B?T3NDbklNWHE2YUpoOHQwbldhZXlCLzJORkhMUmhGcWMrOVYwUzJHbWUyMGdX?=
 =?utf-8?B?RzcvZ09DQjJ1b3BweWhQNkRCK2RlTitNQkFPT05JOENNblM2MDlIT0hOZ1ox?=
 =?utf-8?B?VW45eGxrOWRUSHJ0V2srdStlaHZxMnFkdk85ckZnWWFsY3JRZ3U0Y3p3Tnor?=
 =?utf-8?B?Nk9uSVhhUnNkcmdWOUt5bEg1YTB4b01EUmVpVGt1VGVHSGNjc0U3eXJQUTl1?=
 =?utf-8?B?eGNzbU81TU5QbXVyeU0xYzNOeWR4RDZ0L0M1UUxWYkhxOGs1SnpmUDd2cmsy?=
 =?utf-8?B?dGZud2FtZ3RQOGs2VkdjWnlKYkV4bi9hUXI1NnIzcnlZTGVKd3FZdFhqK0Jp?=
 =?utf-8?B?UXJVTUlSclBneDhTdGtJMFExcXlUSG43VjZ1K2N4YWVNRjZsMXg1a2hmaEpu?=
 =?utf-8?B?aCtnOTZjRVpMSnpNajZGUjk4SG8wMTBubDRBc1Vycm9YRVFEWExMblhVWlo1?=
 =?utf-8?B?M0tmOXR6MGtlRnd0M3JpSVdQRjd4NTl5YldVcmxzMm1Wam1uSWtEZWs4cUFh?=
 =?utf-8?B?czlpeEpIeWd1ZnRjVXN0TGlEcnJSOTYwblBuUWJGSURwRlVsOFZ2WlV2UHV3?=
 =?utf-8?B?Q0pwazlTRkpXTEtsNlRlampteUxxT3liemVEQmNJeEZuOWZOVTNBZVozUVpR?=
 =?utf-8?B?TW0vaU93L3NPTElNcko4L3BCZWpSS0ErZllZTWVWY1BuMFg1UW1tai9VdTVO?=
 =?utf-8?B?RGFLNXhRQzVXVUVXelJvSStjNlRkUWpCS0I1VjZ6Rmc2Vm1NdXIyMkFyNW9u?=
 =?utf-8?B?RzZPVURRc0F0YzFKblFIbndiVFBNeUNwbVMrcHVLMDZmNUtrb2tSSFZMQkg2?=
 =?utf-8?B?T3RRUnUxazZqaG9hSHQwdXBLVnZ5TG5iK3Mwdzljb3JtNXIvcDJ0Z291bk9D?=
 =?utf-8?B?R1NWTWdhQjlDZDlYVmhyQzdZT2Npdms4M2JrYXhFUDBVc1RNZ0FrdG5vbW1y?=
 =?utf-8?B?VC9NdlZTNWdVMzdTbVVhVXRCeE5VZUVKTnhmS0VRaE1KT0FuS2JQdzI4NGJI?=
 =?utf-8?B?a2VRVlFEK3paeUs5RUJXR2FuQ1FvTUZ2QVUvRzR5UDF0YW5rOFdHVXhzOGhY?=
 =?utf-8?B?eXlpakRpSitGd3hBNzEyQjVodGtsS0Q5OWIzYVRxMkVMc2FmWlplRHlzV2ZI?=
 =?utf-8?B?ZUtFaWtvdS8vb0NGRnQzNkdiT2p6YmxmdWN0SWVxWGRCcGk4dVJQTkpMZzJH?=
 =?utf-8?B?THl1bFVpek42MXkzeStQaGt1aHFEOGljc0lPR04xNE9MUTNRYm0wQnRUV05F?=
 =?utf-8?B?SVJRL1htSUFYa2NsTWhRMjBuVEREcWVKeHd5MEpzVmF5K3hGcEpkOFVHcWxw?=
 =?utf-8?B?MnVxbUVmelVLR1BWRVIwYUpqYjdBR3pZVWpVdkhGSWh0dnJXRFNoZlA1REFE?=
 =?utf-8?B?eDUyZUttcXdaWFNZbTIzTkxTVDVRalZlNHJzVmJ1QUxtNDhDeUNpTWM0S3hK?=
 =?utf-8?B?NmFhWFdrMzE2RnZKOGIvMWhnR1RnOTVrVGYrbmtuNUNEYWVNaGlacEszUGpO?=
 =?utf-8?B?NkUyOWpTZUhLTHk3a05zV2ZCYWo0cXJsaW8yQkhIeHA4UlZZS2lYTmVYYXU3?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6de697b-56c3-41e5-2e15-08dba4f1307b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:26:41.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrDzHxTZVh+VJ2XWKucWiiQ43Y6KtanoYqPKimrMXhr0ddnZYhd74v7B7h1EM6mnKCoYhTc/9whl/v6iGsaxfkm4s5l8nTKP016WNU4meSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7054
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/23/2023 6:34 PM, Jakub Kicinski wrote:
> On Wed, 23 Aug 2023 17:46:20 -0700 Nambiar, Amritha wrote:
>> Can we have both: "queue-get" (queue object with with NAPI-ID attr) and
>> "napi-get" (NAPI object with "set of queue IDs" as an attribute),
>> something like below (rx-queue is the queue object. rx-queues is the
>> list attr within the NAPI object):
> 
> I think just queue-get is better, the IDs of queues are not unique.
> It's more of an index within a group than and identifier.
> Displaying information about e.g. XDP TX queues within would get messy.

Okay. So, I think we can support napi-get and queue-get commands as below:

--do napi-get --json='{"napi-id": 385}'
{'napi-id': 385, 'ifindex': 12, 'irq': 291, 'pid': 3614}

--do queue-get --json='{"q_index": 0, "q_type": RX}'
{'q_index': 0, 'q_type': RX, 'ifindex': 12, 'napi-id': 385}

As for queue-get, should we have a single queue object with a 'type' 
attribute for RX, TX, XDP etc. or should each of these queue types have 
their own distinct queue objects as they could have different attributes 
within.


