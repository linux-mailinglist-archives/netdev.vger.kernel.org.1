Return-Path: <netdev+bounces-50270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22B7F5292
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8064B1C20AC3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 21:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B3E1C69B;
	Wed, 22 Nov 2023 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPa5LCgR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA52F101
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700688510; x=1732224510;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fsaoke3aD1HYVZ4ZNkEbxC6xF07SSIkP4ouvMTdtK/M=;
  b=MPa5LCgRKjxnmUU0ewI2FLN0wBAyQtRVCvoSskERilAgTwNj+xw4A3jc
   1DmxzZxaBXHX153tePK8Ymldr1J7EFmCjVo1P+kHeH4+K0YhztSl29zHn
   IOGChnlOFmhjn2RQZEO+cdZrtpIJEnT2bSYE+Oo/XDRnt8MKjJZwxK/UF
   khINoOZPXu9sy50U3+aNrfYQrdNSQOMLB+8ASo4mwV0/bRUPIep2qvLNL
   oNzLWwACy0fZoKj0bHFb/8jl3dHvBSw9VuctwME4LXomeaFliU2lp4LSQ
   BYmveSGI/u2BendIxxoiUr0F5tZI9a7KVzzHiZ2QlvaizeIIOlLhGxTKt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377178010"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="377178010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 13:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="910979380"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="910979380"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 13:28:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 13:28:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 13:28:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 13:28:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG941wwmfFZ9NYaDDydLIBe8nISC+E+ONaPFUiUOXz79F3882kbC0dal+lUeipBZxS534EQOjEiNn3R08MhLzhBYyiP4AlgHAN6q+nzdzinPYIl7lYW0nl4fqDfQ8Up6889R9HbPuuIpL87cdw9YwltcPRlMue7r6q5WzjmIJZl1oIASaXlEgx+8czLzSpCUGKtb0jkwVt61dbthcKKZBiPm89MkplSGnLzQMTEnJqA5T4mcviRvbB6rtLiap40ycfjll3jmldt10tKX/J+a9CF3o8fEl8+wy4wQfu5xLVfuTSCsef8fFiJTdl9uTq0/vDEqHvDL4DXzBE3y0MfNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgh43TZhNgsdIAzp19y3OAMuEppIlMh4i29mxe7IJIU=;
 b=C7Xdi8KMQ5eGz2b3nUFupgEh8Js6yp61HuY1aWKi6lUAk4qrS1Y9lRS2niI1O3eOsI79gVOVZbrSwqXk8fiIb1i96gYC/W0AGgtNs6Yz7FPVS2j/oIIf9V8p7l3bFZk0Zh95ckWJpNoxtYdf/fNJfl4n8o+yKMMhiXjswrnZm7brCIED6FiHZvcN+ZaKe8IfVerpNJBu8Z3BRhPvVmojgk4JDi/vIFIB8fOGIK5JFZsnEbWFlJxLDOe5vM0eMFcVPdseIhuuwtCJeg4YuIu1B/RZtlLiDiIUMDQOjk6T7lPQt2qturdG49SeWXR3STjquWbKatzBCrI9Cc2uZSg+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CY8PR11MB7729.namprd11.prod.outlook.com (2603:10b6:930:70::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 21:28:22 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 21:28:22 +0000
Message-ID: <8658a9a4-d900-4e87-86a0-78478fa08271@intel.com>
Date: Wed, 22 Nov 2023 13:28:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v8 02/10] net: Add queue and napi association
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sridhar.samudrala@intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
 <170018380870.3767.15478317180336448511.stgit@anambiarhost.jf.intel.com>
 <20231120155436.32ae11c6@kernel.org>
 <68d2b08c-27ae-498e-9ce9-09e88796cd35@intel.com>
 <20231121142207.18ed9f6a@kernel.org>
 <d696c18b-c129-41c1-8a8a-f9273da1f215@intel.com>
 <20231121171500.0068a5bb@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231121171500.0068a5bb@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CY8PR11MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 558d5c80-9c3d-4a96-a36a-08dbeba1f44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6Bw1u/KF7uReXIN5Yt8HkH0mSrBwIf6+qcgEP09W2ABDyUz1+kNgUjbWbilKRhSzKjIt+3wKNIFi1qdze95CEB2wceFjG4ss76jl7eIZtS1z7UEaTHnjA2EfTG0WsIrEfcmPz3kgYTy5n7wnZC6fReBim2OfTRyRWx8wwmmbeO9bWL9kq65QpA5PTJxl0H/t/gHSm3XicvVRZI4ccJuOTVF6IBfebGc1f3LSq0ZTSS1fpSUsKg/qxn+tqHxqeBQNqF2drWMnHWR6/aieRq3aMQCf8cq5+nlgss4X+38IQJsFlo2XgzwhuA2voy7rCVF7rhJOdEG88ISUB82+Px01AyP+PRO+gV4t+O3TCOHYf6rmVwooRJzLb3+5OVHPt5d/rMNja2neQ9AeFOjIUjxvHlMbi8suQNPlnmJzudWanpaivqh/Jox6QGAhY/P7fxgLvZPmIlakkbsNj3HNS++aILQ43cVH3vmB4U4EHajt3qHkozGec3JUE7+iQZi8nJk5TE5r0fh+Fs2DBvbOOAqagi7HIdifz88Ivuwr7ph9WvNIQlvz1+B6PaotIfxyvxHAndmymvY++aZjS9rl3CG9VV/s0OZMJvWLiS7WNrDrLjGljpyVbVU4CCtMfClE89gAQ805CXuKIP+EF5/a23S7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(31686004)(5660300002)(4326008)(8936002)(41300700001)(8676002)(316002)(66556008)(110136005)(66476007)(26005)(86362001)(107886003)(478600001)(6512007)(6486002)(6666004)(53546011)(2616005)(66946007)(6506007)(83380400001)(31696002)(38100700002)(36756003)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ZNTTVWb2k1SGZiNyt4ZjRuYmI4U1VLdHB3dFcydmFLUkZldzVtQk1hdHVI?=
 =?utf-8?B?Zjhmc2ZVR2FFZnJtS0hrOHJLTzhWNStaTkYzWlE2QmNqMXhKRnFCMnpoR3NL?=
 =?utf-8?B?QndPb0E1NWZYQ2xZcW1KZ2V1YmlZYkNTRWIrTm5hRit5TmpBVjF2RE4yYkUw?=
 =?utf-8?B?ekZwdlYwWkVlUnJzdGxvTjVKYUNjZEFwSnlWbEtjWVliZk83RTU0cVVSV2ZF?=
 =?utf-8?B?R3VPK1YvQk82Mk5waVZuMnpJaUU5LzQ0d29qNjgrODBub0pnYm96TDZxNnZn?=
 =?utf-8?B?eEpwYVpPQTVreTFXTFJLYWt4MStvZ3A0eXRLUlNKQzdWcG5jWjdCTW5mQVVw?=
 =?utf-8?B?bFRsMUEyTDJOeFJzU0F1Ri9HVnlFUitFekJVVE5jSU9Gd3Bmd1ZBOWhsUWlS?=
 =?utf-8?B?Q1VlajF0OEpEcTJmOHBUUGV3bXRRbEZqK1lyMTZYb2dERGQ4TWs5WFRzQmdD?=
 =?utf-8?B?L2VmRUEwZG5CT3dUb1ZHNzhyZ1lFSGZBbTZOVmtna3dNU1ZQMld4OFF0L3NM?=
 =?utf-8?B?VFlpUDBvOHdmOHNkdzFoM0JZdTV4VWh6TUNHV1Rld1FhaVMyL3R6OEMxcktF?=
 =?utf-8?B?aURCdHJYRFZMK05DOVljY1dSZEF4UkRBRGxiempyMk9XRFVWaUU2VHYyU3dT?=
 =?utf-8?B?UzlwazhjWHl1ZTZjTjRHNS92Zkx0UDRrS1hzenFLRm9ZcXljbGN6SUg5TEdJ?=
 =?utf-8?B?Y0tBYURmTld6WlQ1Wk9QdlRHd2l6ZjRJaGY5bGpnallQZ2V5bU1XRGcraWpS?=
 =?utf-8?B?NzY3cXNSVUJFcUhocEF0WEt5RTJ2eVFpN3V6Und3bFlMNFBIRDhKM3UzeHRL?=
 =?utf-8?B?OEZ0dnFWQ01EcnBVRDY3bWdEa1BSQmhKbDNkZjF2TkNQcTcxWWdsVkVHZkFN?=
 =?utf-8?B?YjBySHNQZzRyQVg3T1NzclRhOVA1NXB3ckNtNm9NRG5KUU1wcDFoRWorRDdk?=
 =?utf-8?B?QWxRcWxMVkZqenhvQWRXdE9HaEsyNCtibHQyZTNITHY5S3ZjT2Zma3Bva2lC?=
 =?utf-8?B?dVhmQXFPT21BQlVFUTBDZ1AzYUt6d0NWV2dQbUJpNXNjTkRORmt4TStQTjln?=
 =?utf-8?B?Kzhld1JLQ2xPTzB0bHU2TmhYTjBVbm9PUnFwUFBwdTNTb2VKb2ZVcVRLbk9F?=
 =?utf-8?B?ZVRWemRwRGxMQVJZTDdnc1htQ2RmalB4bFhvNmRtVkFTNTVROWg1QTRtbElR?=
 =?utf-8?B?WHRNZTBtK3lmMWhod2hyYXR3UkR6QTNpWkNPWUcxb0FLdUZpMVU2WHBsZkxz?=
 =?utf-8?B?L3VTU2NBcmVaZ1NFY3NmUk1KeG50YWNuUHJlTmtLZEwyOEkwdFd6OUpCWkdy?=
 =?utf-8?B?dHAyQVNWRGFXR3ovczJ4dTZCdktGR0Z1Qk5PWXJXaUdPSXNnaWZmMy9FSG9P?=
 =?utf-8?B?eHJveEduc2ZocldxSlJXL3JnaXBQOUdWRSs2M1hsV0xWMWhtNkN0N3hsREFt?=
 =?utf-8?B?ZlA5ZHZDU0NoaWlNb1Q3SUcrQWd3ZHBJZkRLN25yVFIwQXJ6OVFSSSs0cGRa?=
 =?utf-8?B?eE5FK2s4NjEvN2grZjFqZElRVm9nRWNJeDJ5Q3krL251YUNYdDdHN28wVkJp?=
 =?utf-8?B?MnIwM2xZMmVRSVBMbWcwUDlFQm01UG4yNHBwNytkSHNQZlhJZnh6M3Z1VExH?=
 =?utf-8?B?a3Y5QnZzV3NNYzY5eDkyWUlESy9YdGZaU0NnYjRzOWJLMm5SY2g3VWNJME1I?=
 =?utf-8?B?NlFxUTJTc01xcElCbkJ3VUxsWHlvcml2R3JMQk1iZy9WZFF6U3ZGeWVCRG9N?=
 =?utf-8?B?OGRlYWRxOXltakgvU2JRdnR1MTFjbW1xWEFtUTZJTE01em5CZDVQcTlnck53?=
 =?utf-8?B?dkYxYkNyeVluelk0Y2V4dCt3b3VzYUpvaUxlV2VjZi9BV0dGanNLV0Q4ZHh1?=
 =?utf-8?B?dW0xUVVHdWhlaGduK2FXZlVVRHpnOW1UM0pqaWtwNHZOQlo4bXNiZDVGVkNJ?=
 =?utf-8?B?OHc0cmg5UmwwendlZ2ovYTFqbUZ1dUYxWkp3YS9pRGhPbTJSS3U5TFpLNUsz?=
 =?utf-8?B?TU5wc005eldQTDJLaFpjZnhVQ1FRT0ZPYTR5UTM4a0pKMXhlQjVBRk1ybnh4?=
 =?utf-8?B?TkVVUVBJVTBNMXh6L1dJNGF2TTI3TmM5MUYyOTlXRE9XcGN6dHRZQ0VLOGJP?=
 =?utf-8?B?MFZmUzY0SUxmRm9TSVdoMy9YS1JWQ0ZYMFk3SWJrZFozd0VId2JhWGRnZTJG?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 558d5c80-9c3d-4a96-a36a-08dbeba1f44b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:28:22.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx4VZALlrPcmo6bP38Kyuo3/jF8Fjb6Nc118ZsOSULdHftueDJpbxKBZTTTr/hAcZKcsSartB8Onbwr6wxyo/eczBvLFtErEetFWcwR4c5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7729
X-OriginatorOrg: intel.com

On 11/21/2023 5:15 PM, Jakub Kicinski wrote:
> On Tue, 21 Nov 2023 16:08:07 -0800 Nambiar, Amritha wrote:
>>> To reiterate - the thing I find odd about the current situation is that
>>> we hide the queues if they get disabled by lowering ethtool -L, but we
>>> don't hide them when the entire interface is down. When the entire
>>> interface is down there should be no queues, right?
>>
>> "When the entire interface is down there should be no queues" -
>> currently, 'ethtool --show-channels' reports all the available queues
>> when interface is DOWN
> 
> That's not the same. ethtool -l shows the configuration not
> the instantiated objects. ethtool -a will also show you the
> pause settings even when cable is not plugged in.
> sysfs objects of the queues are still exposed for devices which
> are down, that's true. But again, that's to expose the config.
> 
>>> Differently put - what logic that'd make sense to the user do we apply
>>> when trying to decide if the queue is visible? < real_num_queues is
>>> an implementation detail.
>>>
>>> We can list all the queues, always, too. No preference. I just want to
>>> make sure that the rules are clear and not very dependent on current
>>> implementation and not different driver to driver.
>>
>> I think currently, the queue dump results when the device is down aligns
>> for both APIs (netdev-genl queue-get and ethtool show-channels) for all
>> the drivers. If we decide to NOT show queues/NAPIs (with netdev-genl)
>> when the device is down, the user would see conflicting results, the
>> dump results with netdev-genl APIs would be different from what 'ethtool
>> --show-channels' and 'ps -aef | grep napi' reports.
> 
> We should make the distinction between configuration and state of
> instantiated objects clear before we get too far. Say we support
> setting ring length for a specific queue. Global setting is 512,
> queue X wants 256. How do we remove the override for queue X?
> By setting it to 512? What if we want 512, and the default shifts
> to something else? We'll need an explicit "reset" command.
> 
> I think it may be cleaner to keep queue-get as state of queues,
> and configuration / settings / rules completely separate.
> 
> Am I wrong? Willem?
> 

So, the instantiated netdev objects and their states are more aligned to 
the netdev-level than the actual configuration in the hardware.

WRT to showing queues when the device is down, I see your point, the 
hardware has those queues available, but when the interface is down, 
those queues are not valid at the netdev-level and need not be reported 
to the user. So, it is worth showing no results.
Also, my concern about showing the queues when the device is down, to do 
the user-configuration and then bring up the device, does not hold 
strong, as configuring when the device is up would also need a reset to 
make the updates in the hardware.

Trying to understand this distinction bit more:
So, netdev-genl queue-get shows state of queue objects as reported from 
the netdev level. Now, unless there's the queue-set command changing the 
configuration, the state of queue-objects would match the hardware 
configurations.
When the user changes the configuration with a queue-set command:
- queue-get would report the new updates (as obtained from the netdev).
- The updates would not be reflected in the hardware till a reset is 
issued. At this point, ethtool or others would report the older 
configuration (before reset).
- After reset, the state of queue objects from queue-get would match the 
actual hardware configuration.

I agree, an explicit "reset" user-command would be great. This way all 
the set operations for the netdev objects (queue, NAPI, page pool etc.) 
would stay at the netdev level without needing ndo_op for each, and then 
the "reset" command can trigger the ndo callback and actuate the 
hardware changes.

