Return-Path: <netdev+bounces-25206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EDD773590
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7FF2815E7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 00:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C2379;
	Tue,  8 Aug 2023 00:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C51191
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 00:52:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA91170B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691455922; x=1722991922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=coh+xCeY/gvkCo/1kYz1rX3EfOSHz4aPudEfECqMRZ8=;
  b=hQaEyMsjFixTKAV76xjeChsjP6depTRi+xMt/rA4mjaH2odHFBzabu4w
   sJOoMvgd++fOYlIpnL3/UDaHMgFs7Fj5RYL44cbN6l2dSHMeD0Zx03z6o
   LwIPtQ+7TSA50S1E9MVai4dlPJVAn0KqYpRger8Dh1aa7DeW3RpgTxz5f
   qpzcuugpJMxpadDU2CmRZa28pU7SrqavDatFjx3CVxsT0mgbW+Uc6bBJq
   bgvH6BSkS70OEwyMb8f6zxijjXVLnNOnMgFo/dxjFfCYYc6yA2gKvRECT
   Nolr3qKBtlXqusHflTdMJl2+TzS0IF32zFoyNcj3NQAbTPTFUYLaSCT4i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373442112"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="373442112"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 17:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977668044"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977668044"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2023 17:52:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 17:52:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 17:52:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 17:52:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 17:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPEV3fq6gKeAYb5+ylyXZvM7R3walqjSuAyHE+6v6kLQ4FwEqY3thQEW6d1GLqiOmaS+p3Tij53jEurSgR9ChaUlXYKMC93Wl9HsglQeZ0LOWV1EH/vjbyYad+QvWelysJiWzebyWujPwEw1QPaQzls0SWbgbGy1F8xh5fPCiJtx090PMDtIF9YKkV0GumsjyPCW1w+uhylwMtKU9Y+XV5AhkY2gJpdTE+UFlq/H9v0IjuTcgh2XOSfnwCi/Xh9P04M8eqQXTVYfzZNN1wUAoaRDDoXPN3f4IGJ1b38P7d5T8wq3urKxvhQWm9tCPDHVwGSowvF4Pv4Gah2y2swDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc6qMuwoJbf6sxn2Sm+Jf9j1pYapGCcZd45EKQ94+48=;
 b=AKwi/1FJoHsrKYkfwY32hYhCH+cgl0d/3ybGhMqG5ISpRqwIraR7Nxuq9clhJKkJxA5XcBxkSQgChuH0DxLBgrYFMU8LFqISSX5R0/iG+1tRDK3Gm9XvQV+Zn8ydnTKfaXv+T1aTjC7Y3x3qSQd1RuyVanzmLEiiYsKvTmgfx9R7iLmAiKQJ6DMwk4UIx3j3XSlRjtP5+AjS67XhRVUVdtz/naR9uLwwuroMIr64ufkYXw+NZFfauWJ2nMFkM5hGUMLRzx+jIOaPD0MezxxbOtl+jg6kSnLfZ50vsgebC3ocauz9b6sdpkJ2jQeDOiSSBIUCC5ZUJulqEF2PN87qrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by PH7PR11MB7478.namprd11.prod.outlook.com (2603:10b6:510:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 00:51:58 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 00:51:57 +0000
Message-ID: <80743724-b249-1525-9511-effdfd903768@intel.com>
Date: Mon, 7 Aug 2023 17:51:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v4 00/15][pull request] Introduce Intel IDPF
 driver
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
CC: <pavan.kumar.linga@intel.com>, <emil.s.tantilov@intel.com>,
	<jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
	<shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
	<decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>
References: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:303:dc::25) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|PH7PR11MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 740033ea-7f86-420d-8ea3-08db97a9aac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdOUxHB/qESp4tQk/3jp3nyHzcwPCKf8rNM9k6CyHpsMc/389WbbIn+YxiMfca7QyqCUSLh51DQ0qS5oiL9yKT4jCysIhTF9N+Y/GFhayl62hGzyvd7QhkGWdBvs0htiQsY/N23gzK7Tc5glIDB7oZv5LvEQFPTUrFZQkLidxtVIQa2k/wucR8YMmTQwqN3sLyKgIWuCFeb5FdQcB0qYX6GKu46E7y2Wm9E1PL9tD1+BPNvuBykotcgLM4HPBBO+7ANWkrAfk26e2WWFhTDwSSW4A3egflcU9t5+tidyWtfJuDjHg7+yuZb2yfDExAI8E8P/qZoWLsd1IW2Fbx2mhJtEgu+1cz19tB4RlJJsqVO0ypXpFNXdoR5a5caBTZmy0yvrY7AnRJZlEXRTwOAnotJlkGV7wMhewXrJPBAuLSHWnu8a++X6UBWe2KlwkJvSdGH9ebn7Ksh7jDG9tgpkpoicXMmOar6CARFBTHP8rCYPKNcrPFicXf6WTyhEur9ojEJWdEZ0XqxqneZjqO0BcclGmtz0w9jBUfDW8WIE1doq2JGqgsds+CpazxXRHy0e6IPLVbLNTeCWI2YWZHeqsWda5SX37ohE8il2ltRuLq5sWKDZis7ZLJm43H6lfy9fV7UrGH2bgLv9gP/ObqaNpi0VkSw3ztCrvc+dYJV7H9VZsTFjeOMxuaLj8LG2a/wx1+ySFUQq62xRgB4F8JY6Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(1800799003)(90011799007)(186006)(90021799007)(451199021)(41300700001)(26005)(2906002)(5660300002)(31686004)(83380400001)(7416002)(8676002)(8936002)(2616005)(86362001)(82960400001)(6506007)(316002)(31696002)(53546011)(6486002)(38100700002)(478600001)(66476007)(66556008)(66946007)(6666004)(966005)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNseHprR3hsYlFveHliODlCMlA2ZHZKcFhXNVRmLzVWT01VRUtYNGdsZndS?=
 =?utf-8?B?d20ySGwxQlZFcmJFMjB1d3NwWXYrUG11cWJBc045R01PWmlNUzR3eDVJNTJ4?=
 =?utf-8?B?d1RSWGxkMXl5b2k5TzV3UWM2K1hYNmM3NDB5U1prN2h1dGJtTEFPWnNqZzJk?=
 =?utf-8?B?S1I5aDNtcjQxa29Uc2Rsa1hLbm05Mzlld2s1Ti9zRTNYdWprazE5MUN1SEli?=
 =?utf-8?B?clMyRDZpYkorWWVRd3d0NlVBVmRXUkkwU1JKcDk4M2hWaHhYTjBZN1VsRStV?=
 =?utf-8?B?UTR1VDZJMHN6Tmxvenhxck0reEJtNXphbzAyTGlUTHFrbDlUZ1BQbmJGa3lL?=
 =?utf-8?B?dlhFNTFJWmFLaUY0clBwdjhYZ1dRMUd2b2FuV1ZFRXVGRkhHeTFPUWFkUjhH?=
 =?utf-8?B?dzc1dS8vVkY3QzcycE4wQ3VzcFVPTFdMcDJPOFlQYVNqcEFxcnFUN0ZmRmRw?=
 =?utf-8?B?MVBPcjRXZEhLNDEzNEQ3WXRtNm9JTnBpSGlGQyt4cC8yM3l3bnRkZjljYVZr?=
 =?utf-8?B?Z2daNG5TMjZhT3V2ZlUwdVdNenp6dkJHWVovQTVsbHduWFQrMzlrclh0V2tI?=
 =?utf-8?B?V2ZueWRpWGVwclVUU2tsdTZCVU9za2h3Z3NDR284WFJVY2ZiVzBjVWcvSHl0?=
 =?utf-8?B?TjU2TW9Ic05jYzZSQ0gzdEdTTjVPODVYbU5ZemlxUy9zc3BGMktsdjBwY1NK?=
 =?utf-8?B?QXk2TUhtcTUwWmlZVTgvc056cFd6Qng0TnF0NDhqSGx2SWhST0NMYU13bVF0?=
 =?utf-8?B?dmpiZk1BNlJ4NnNHVERwNDhHbDdpTjlxN254YXpTd2FjREw0Q2EvdWVEUGwr?=
 =?utf-8?B?RkYzWWtrTTZJSjF5WHRUVUxHZW9nb3p0Nm9IdmRpMlRjbFFWRmdGakxkVFhr?=
 =?utf-8?B?V3RXeVk1YzJaUHNvdGVWY3E3aXRUMFN0cXVDNjhUWWtnKyt1ZjVxRWRkVTl2?=
 =?utf-8?B?R3lPNEFrSmFVK2VoZ3hmclFwYW1Fd3Zub1dndFpMcnRqMmkxVTcrZnk4c2tm?=
 =?utf-8?B?RDBFZ1JLdE1haUNhNis5QjFEOUozY0JYb1U5cmJIN1dCNUFmL3V0Tmdvb3hn?=
 =?utf-8?B?c2ZuRHpHVFVwa3pJNXlBMkNWYTAyMnNPVmJwVm5qT2FkVkNmYnVyYXpFT3JT?=
 =?utf-8?B?RHorRjFiZk5ac2VqalVhamRQUUt5d0tNVy8zTktDcys5T3hDR092V01NMnho?=
 =?utf-8?B?ZU1vcEw3VnNzVnVXMVFyd0o4SGQxUU9mdzdRN1BiNXZyWkpWYkJNVVpsdnRX?=
 =?utf-8?B?d2lMenZ6QkI3WkY1UUZNeVhMcHp5SXZEMUNWdGx3SnBjWjR6YU9TaWJsVElQ?=
 =?utf-8?B?RnU4U2c1OGQ3MDZ4eENINDVyYlMyUjJDK0h0dnJ4NEVxVEFZSXRxeE5FQVNo?=
 =?utf-8?B?dkptN0pxWlRGTDgyY0EwRUNpZjliY0YzcmoyMUZTKzF4RHUwQm1EQ0paeVJ3?=
 =?utf-8?B?N1lGb0RabmlHcFp5bGJaWVlUOUMxRzNkSU1kaFFJaGZiMDJMYklocjVaSW9Z?=
 =?utf-8?B?OXZqVEJZYkVtSUhPcmxHcytnM0p2TW02NEl5a1RFQk1JaXp3eXRzdWlCWWNS?=
 =?utf-8?B?dm5WbnVVQ2UzT2kvaEF6SU16UUMyNkd3UXhZaURvM3JlRGtUSWFTRm5CcHlh?=
 =?utf-8?B?Um0xTy9rY2RMajlWV0duYzQ5ZU9qY0M3UDdqdzZJY1dHazlQalZJR014NVJK?=
 =?utf-8?B?U1djME1vY2lZV1pYTXFWQ01IdmZ4RU0yWUpON0owdkRYeHE1T2Z3bVhOVUNB?=
 =?utf-8?B?eXlDWURPYVNDS2hFQU41UnpuTldmSjFqQW9Nc3NVUFFYWG1wZnU0a2pvOEtS?=
 =?utf-8?B?RHdiUzlMSys4WGYwckpPcXAvdWN6VUtmc3NxVTBKai9iOUxlbmcyZVpjbXBh?=
 =?utf-8?B?Q3E4MktmNGxxR3BycnpzYVNxa2Z0dlUrRlhFZ21zVmU0WUxna05QM3B1dFVF?=
 =?utf-8?B?TUp0d296L29udExOTUw5VC9Lc3ZoQmhLQUUvUjZNREsyd1FmSElHY3FrU2tK?=
 =?utf-8?B?bVJzb3BPYzhTM3Z2MTJWMUFkeCtyQkx0UTBEaWc0RUtPWUhmaEh2VTcyVVJl?=
 =?utf-8?B?OVpOSkFaU0x4Uk50bTFHeVJ2UnJrNlNwZEVjYmhnMHUzYk02TndqV3g1aXl4?=
 =?utf-8?B?QW0wY2JOTklLRTcwMXZzeUZqeDcwSnE5ejdXd2N3MVVUUm5CS3QxSzNXSlFJ?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 740033ea-7f86-420d-8ea3-08db97a9aac5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 00:51:57.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clRLQ19mkI44wofakxAuj9ZbELOUmhnBTuvU1CUtRnfyEjSzKKRcGA9peqxDplIfu3gyUpDRmJQwAeCe1wH3F2SWKWoalf8tmLfPCfdkgD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7478
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/7/2023 5:34 PM, Tony Nguyen wrote:
> Pavan Kumar Linga says:
> 
> This patch series introduces the Intel Infrastructure Data Path Function
> (IDPF) driver. It is used for both physical and virtual functions. Except
> for some of the device operations the rest of the functionality is the
> same for both PF and VF. IDPF uses virtchnl version2 opcodes and
> structures defined in the virtchnl2 header file which helps the driver
> to learn the capabilities and register offsets from the device
> Control Plane (CP) instead of assuming the default values.
> 
> The format of the series follows the driver init flow to interface open.
> To start with, probe gets called and kicks off the driver initialization
> by spawning the 'vc_event_task' work queue which in turn calls the
> 'hard reset' function. As part of that, the mailbox is initialized which
> is used to send/receive the virtchnl messages to/from the CP. Once that is
> done, 'core init' kicks in which requests all the required global resources
> from the CP and spawns the 'init_task' work queue to create the vports.
> 
> Based on the capability information received, the driver creates the said
> number of vports (one or many) where each vport is associated to a netdev.
> Also, each vport has its own resources such as queues, vectors etc.
>  From there, rest of the netdev_ops and data path are added.
> 
> IDPF implements both single queue which is traditional queueing model
> as well as split queue model. In split queue model, it uses separate queue
> for both completion descriptors and buffers which helps to implement
> out-of-order completions. It also helps to implement asymmetric queues,
> for example multiple RX completion queues can be processed by a single
> RX buffer queue and multiple TX buffer queues can be processed by a
> single TX completion queue. In single queue model, same queue is used
> for both descriptor completions as well as buffer completions. It also
> supports features such as generic checksum offload, generic receive
> offload (hardware GRO) etc.
> ---

Looks like I accidentally truncated the revision history :(

It can be found here as the v8-v9 changes:
https://lore.kernel.org/intel-wired-lan/20230804231929.168064-1-pavan.kumar.linga@intel.com/

If you would like it resent with the info here, let me know.

Thanks,
Tony

> v4:
> Patch 1:
>   * s/virtcnl/virtchnl
>   * removed the kernel doc for the error code definitions that don't exist
>   * reworded the summary part in the virtchnl2 header
> Patch 3:
>   * don't set local variable to NULL on error
>   * renamed sq_send_command_out label with err_unlock
>   * don't use __GFP_ZERO in dma_alloc_coherent
> Patch 4:
>   * introduced mailbox workqueue to process mailbox interrupts
> Patch 3, 4, 5, 6, 7, 8, 9, 11, 15:
>   * removed unnecessary variable 0-init
> Patch 3, 5, 7, 8, 9, 15:
>   * removed defensive programming checks wherever applicable
>   * removed IDPF_CAP_FIELD_LAST as it can be treated as defensive
>     programming
> Patch 3, 4, 5, 6, 7:
>   * replaced IDPF_DFLT_MBX_BUF_SIZE with IDPF_CTLQ_MAX_BUF_LEN
> Patch 2 to 15:
>   * add kernel-doc for idpf.h and idpf_txrx.h enums and structures
> Patch 4, 5, 15:
>   * adjusted the destroy sequence of the workqueues as per the alloc
>     sequence
> Patch 4, 5, 9, 15:
>   * scrub unnecessary flags in 'idpf_flags'
>     - IDPF_REMOVE_IN_PROG flag can take care of the cases where
>       IDPF_REL_RES_IN_PROG is used, removed the later one
>     - IDPF_REQ_[TX|RX]_SPLITQ are replaced with struct variables
>     - IDPF_CANCEL_[SERVICE|STATS]_TASK are redundant as the work queue
>       doesn't get rescheduled again after 'cancel_delayed_work_sync'
>     - IDPF_HR_CORE_RESET is removed as there is no set_bit for this flag
>     - IDPF_MB_INTR_TRIGGER is removed as it is not needed anymore with the
>       mailbox workqueue implementation
> Patch 7 to 15:
>   * replaced the custom buffer recycling code with page pool API
>   * switched the header split buffer allocations from using a bunch of
>     pages to using one large chunk of DMA memory
>   * reordered some of the flows in vport_open to support page pool
> Patch 8, 12:
>   * don't suppress the alloc errors by using __GFP_NOWARN
> Patch 9:
>   * removed dyn_ctl_clrpba_m as it is not being used
> Patch 14:
>   * introduced enum idpf_vport_reset_cause instead of using vport flags
>   * introduced page pool stats
> 
> The following are changes since commit 66244337512fbe51a32e7ebc8a5b5c5dc7a5421e:
>    Merge branch 'page_pool-a-couple-of-assorted-optimizations'
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE
> 
> Alan Brady (4):
>    idpf: configure resources for TX queues
>    idpf: configure resources for RX queues
>    idpf: add RX splitq napi poll support
>    idpf: add ethtool callbacks
> 
> Joshua Hay (5):
>    idpf: add controlq init and reset checks
>    idpf: add splitq start_xmit
>    idpf: add TX splitq napi poll support
>    idpf: add singleq start_xmit and napi poll
>    idpf: configure SRIOV and add other ndo_ops
> 
> Pavan Kumar Linga (5):
>    virtchnl: add virtchnl version 2 ops
>    idpf: add core init and interrupt request
>    idpf: add create vport and netdev configuration
>    idpf: add ptypes and MAC filter support
>    idpf: initialize interrupts and enable vport
> 
> Phani Burra (1):
>    idpf: add module register and probe functionality
> 
>   .../device_drivers/ethernet/index.rst         |    1 +
>   .../device_drivers/ethernet/intel/idpf.rst    |  160 +
>   drivers/net/ethernet/intel/Kconfig            |   12 +
>   drivers/net/ethernet/intel/Makefile           |    1 +
>   drivers/net/ethernet/intel/idpf/Makefile      |   18 +
>   drivers/net/ethernet/intel/idpf/idpf.h        |  932 ++++
>   .../net/ethernet/intel/idpf/idpf_controlq.c   |  621 +++
>   .../net/ethernet/intel/idpf/idpf_controlq.h   |  130 +
>   .../ethernet/intel/idpf/idpf_controlq_api.h   |  169 +
>   .../ethernet/intel/idpf/idpf_controlq_setup.c |  171 +
>   drivers/net/ethernet/intel/idpf/idpf_dev.c    |  164 +
>   drivers/net/ethernet/intel/idpf/idpf_devids.h |   10 +
>   .../net/ethernet/intel/idpf/idpf_ethtool.c    | 1363 ++++++
>   .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |  124 +
>   .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  293 ++
>   .../ethernet/intel/idpf/idpf_lan_vf_regs.h    |  128 +
>   drivers/net/ethernet/intel/idpf/idpf_lib.c    | 2357 +++++++++
>   drivers/net/ethernet/intel/idpf/idpf_main.c   |  285 ++
>   drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 +
>   .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 1185 +++++
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 4309 +++++++++++++++++
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 1021 ++++
>   drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  163 +
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 3769 ++++++++++++++
>   drivers/net/ethernet/intel/idpf/virtchnl2.h   | 1266 +++++
>   .../ethernet/intel/idpf/virtchnl2_lan_desc.h  |  448 ++
>   26 files changed, 19120 insertions(+)
>   create mode 100644 Documentation/networking/device_drivers/ethernet/intel/idpf.rst
>   create mode 100644 drivers/net/ethernet/intel/idpf/Makefile
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_dev.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devids.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ethtool.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_vf_regs.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lib.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_main.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_txrx.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_txrx.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>   create mode 100644 drivers/net/ethernet/intel/idpf/virtchnl2.h
>   create mode 100644 drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h
> 

