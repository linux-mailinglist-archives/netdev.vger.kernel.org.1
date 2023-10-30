Return-Path: <netdev+bounces-45328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71107DC201
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 22:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F4DB20D26
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 21:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5C81C69D;
	Mon, 30 Oct 2023 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geLeukTn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0223C3
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 21:38:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A409F
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698701907; x=1730237907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WH6FhwM/qnuzjeV5yjIcKanYGRDQAB9w3mZDd20+kqs=;
  b=geLeukTnHd6vv0Imupx8C7gfIK6jJ1NazdboRyFteijodNQfETdDnlOc
   3u5WWUxGjxVY83fJ9QRO+TpX2y04Pl7xVuDYkW1w4mDoMZWUzoRZ8gp2Y
   s854o4XtJLXUTfLNP25n/Wve1XfIxCw9h04z2iL4EgkJSdknKVoUgFGYb
   PAglvN0YXsqjFKKr1g69CNMSy3/jR7JabKb11IzTdWyxdpFXIXOx/bSXN
   8IHqHUYk5BsH0uILXgdEPg5bmSB5hB3exmByUyMjwBhPu3Jjz+XQ737jR
   eCEJSdpayWXkDPbVmsPog3pyHOr2Rd4V00xLKGoDecWY7gBKwEh+0MCm4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="454635899"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="454635899"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1007553851"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="1007553851"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:38:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:38:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:38:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:38:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V14AfxCYfxsoNWTA/Pz04xIFknIi7y9pl6RLmQh+UugOzUwISYT8wOQUfuwQnfHJpp+rfWWQZ+SYyJqpqh+MdS9CLR4bZU4d3kEUYshG21ERrjmroKaI2ArC78F7ZjBPZY7q7QbnsXgpNinO+ER8CnhN1efiyxn/qCVKuT2UuCaAPqUY3Hj01Fi11odYSh0Ra7rmSiIPCXC73Y4IsO1W2jFcL3HXQXapRk5zc7nyXtEtithGF+o0G1qpsAOAo6tcUZJvYdzxXYj/xlxU2pqaclmxzX0N1My0t6FKh50gloQAZ5vrThLN/kie3Mu+RzX/0nP5frqYj67zOR3/3EA6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wooOuqRvmJ606oLE2RxK7S17rBqY0tZ8anuMCbXf74U=;
 b=V1XxY3bVMDGOdQQQ/OU5yrD7h5eNofTbfuZlHx86qNP6E8hREnfbdBYLiH1vfl1hTeCVd93cjEAiaUjbD7NuxrhQ3P5t2Bl3msVHOXW24KUk3VowKxevz7wIn0xWHt/EJIoPBYPF/bcc5NUt9/9HnZzN2/BENzo0ezZ1/0S08owLlUzqzfOqswoWiGe7Y61Fwo/mSC7+6l8VLFfeJjrjULoe/4c4ONEn6T4i0zIIRRDmqEe60yrizcmp+zSqOYd7luQ0mzdncJB5+xozPs5o1ZZH6DMA8D/SQ6b8zPzzA9yznBuDN4Jp4/fto6OGoCxDN3tj57WTBsVhCuccyLYhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 21:38:14 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:38:14 +0000
Message-ID: <b0bc87bc-cc65-4a45-9110-0dbaf6d39211@intel.com>
Date: Mon, 30 Oct 2023 14:38:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] ice: restore timestamp config after reset
Content-Language: en-US
To: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>
CC: Karol Kolacinski <karol.kolacinski@intel.com>
References: <20231028002322.2224777-1-jacob.e.keller@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231028002322.2224777-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:303:87::15) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SN7PR11MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7094485f-9099-4176-0dfc-08dbd990857f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aAC7pZ8YgBmwSNf6cwzwn7Qb5h/6jpy2+wkryNaPzq63Ra+RQCt+0mu0MQ/weYiZLB95piQvZsqmrx2SXYqiQooswvdThwH2IjL+5/Z+HntIaj2LHw/nSc6UaImsjWnfTuqN0AHlapwxJYAIrYSnCO6kR2jbDTVXnWpHJQvKmxJ1SXLe51597P2VZJs72CaVDdwdq3UmE7BZKq5z/hJezzR58DSrvsopALfCaopmHNq2oH0LXtEvS6S1JwFtvWnRQ7iwjXRmf7Y9gX+eMIY9VwWzgL99ZqEFNe7RrlIz5//v3nYncUD3VRa97ju701VTqq3zqpREFfLR62uU0yLGUBHMPZOugDBhJJ7TFIqlHpiOyLVh7pqPbBCr0iABYiOaBP2rciD19XpMXTnRWIoQBCU0A5jJf94x+iVhn6CT7GQb5TB7Pn7IKSwKCfzHKvGTwmF4kofNOMN8f5NjEbWD5rDF9mA07vp3QMUbPEu8x0gfMnEeyD4/zx/ewlAuIbqH0En3o9u+5ynlhDL790qO97lTvOa6LJloJoApT64bKRr3DLJACN9rRrn4JT2CDoodJJm8Gp5Wv2LFiaPzNhEemyiSsrGTEzeiBjK6TrJ3VTdQ34v1CZwWz4lwfUnSD2zx2lOZO+P8miwOPRcYrnBjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(36756003)(86362001)(31696002)(31686004)(107886003)(6486002)(2906002)(6512007)(478600001)(8936002)(4326008)(8676002)(6666004)(41300700001)(6506007)(53546011)(83380400001)(66476007)(66556008)(26005)(5660300002)(2616005)(66946007)(110136005)(316002)(6636002)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1hwL3ZpUEc4c00walJFYVF4bVNaMStjb29jVTVPSjk1YkhVRThnc3RZei9H?=
 =?utf-8?B?SUwwakJLTlVNMGxISDhhVlc0dzk0a3NpQ0dHNUtSU3hYSVVycWdGckVwdHQ0?=
 =?utf-8?B?Sk1YM0srdmpNdnkrOVZmQkxiRWx4ZFQzRHhrMlNxaWZvaUV4UUxjeUxSY2dH?=
 =?utf-8?B?dmVUK3pzbWt1M0N0cjdUKzRHYUlFMU9paXIrMGhYb0hGN0gxY3pLZjBuVnF6?=
 =?utf-8?B?bHNLS3NWeE91dlhISTJITVpPSm4wazZaMWNCVFYwRTNkaE5NMzFXc0dKZWZp?=
 =?utf-8?B?V3l5VXF1aHhHMTlRaFREUHFENGo1cDVnV3k5ZCtJV1lCZzJMSGFrVUs3V256?=
 =?utf-8?B?TUJ0OUk5ekIwTmFkNHE1U2pzZE5hWHNjRkdSRC9JdUJKVVYrUFdrSnFPdXFH?=
 =?utf-8?B?aU9XdnJBM0dRSjZpTGlNOC9nU0ZHUjRjVTcxYVo2WVI0NThMcU1XdkYyeXRt?=
 =?utf-8?B?d2JCUGhSYjRHdWpubEtRVVFGbG1vdllCOEcvbUVKSW9TcWRhbCtZMnhxMC9z?=
 =?utf-8?B?SStjMGJLNi9GRW9IUGNieFA3aTZ2ZFpvanRDZVh2Q3lFM0Y2eTZwZTMzWUYr?=
 =?utf-8?B?b2lmTWRONURXQ2YzYldOdHBJUXVJbnlmM0FHdDJKZGdoN2hhdWxVSFd2RGI3?=
 =?utf-8?B?MVZnYXIyNUxKVG9ybFVPVHNwTFFBcU54R1FvT1ExN0NwMkdqSTdlMElZMEow?=
 =?utf-8?B?dUJxRlNyUVNha0MzaTB5Z0tLUkVZQWpTbUFvb1JQSmZ1aVlVbFh3a0ViQWcz?=
 =?utf-8?B?bnpWaFQ3VGEydWpUVDZ5dGl4NE1iVFhvb3dlb2JBWUtIRG1oNDc1YlBXeXpy?=
 =?utf-8?B?Q2xUbHVobzBPd0k5YzYvb29mNDlCNWJtbGVxZzkvdi9Na05lL2NIMEJkRWhC?=
 =?utf-8?B?MmpuNnRQbFJsNnBMMzZoWFRySjc3dW5ucWNuUFQ4NExZaitaY2hkZG5ZTy93?=
 =?utf-8?B?QVR3bG5EOXc3NlQrdmhFdHkxa0M2Z1dyeWxTQnBYMVJVSTdwK1BDU3Mwb1dH?=
 =?utf-8?B?SnEwSW5HT0kzek41Z2tMK3I2dDlSVStpN0UwMVYyQkpWRDcwaDdUL1VCaktv?=
 =?utf-8?B?bXVGRWkyTGtYbi9xUDBySjlqWVEzK3VDU2dWRGFSWnpqeGlUMGJib3FaeUhF?=
 =?utf-8?B?TElLTWtjaUl4K29kZzFFcDJkc2dUa1ZyN3ZpQlk4NnJDNy95cVkvZWhuakdt?=
 =?utf-8?B?N1JBZXEvcUFlN2ZZWW5pSThoWmF4a3Rtd3lhNW8xTmpVQXFHbzdIdGd3djdh?=
 =?utf-8?B?T0J0bS9TN2xpS1dVODhzYmcwL0Ryci8yekpjMTM5MmxkQnZiRXMxd2xSRXpv?=
 =?utf-8?B?OWQ3cW0yMk5LeUx3MVhCN0luUWJQMWlZakZ3SGNTY1ZpM1BGMTdRTnhWOU9a?=
 =?utf-8?B?NFZrVm13OHF6RTBwRHUxd2dWdnduc1RyVXo4ZlNhTElYVktZckVnNUV2SVIr?=
 =?utf-8?B?ZHFvZG9RamlsWXJaRnNEaTJMT0pWaUc3N1ZHUEVxa3lPQVQyWWM4M05SbGY4?=
 =?utf-8?B?QjZqVzQvZC9iVDh0cWZQWXZoS3V2bU1YaExPMmI3dkRFdjZVVlhVUUFTMnhr?=
 =?utf-8?B?RzRBSGYvbGZ2OEJZQWxaUTlDbWVHOWR2NEtVTFlRVS85ZHMzazJ3QU1GZmpI?=
 =?utf-8?B?eS9nc0hNOEk0TSs5aUx1Z2VOVEJ5OFl6NUJTUTRtZU5CUEhOVmNHWVRnNGJQ?=
 =?utf-8?B?VjdyYU5XOGd3NWQwbExTcElYb2JTaTRFbnhUTEJ2Q2I1N2lWSlF2aTBzc0ZU?=
 =?utf-8?B?cjNWaytSVFpoMlN6RGJpZ2ZUV0lCclNyK1F5MDJPNTZXSHpnM0t3Qmd6REVK?=
 =?utf-8?B?UENTTFMyUnVBQlFJUzAxUzV1NU5TRlVyRm9ZNURlVUZzZVp4UFJPSGZWelpG?=
 =?utf-8?B?ME9sUWJ2cjFtWSsrQmxxdTMvVSt6NUtsR1cwSXdVYnR4UEFmUmkvelVNclJm?=
 =?utf-8?B?M1h0N0tNZ2VOR1RxMnE1MldRWDFFdWJHK3NDRFhqcFE1WmdEMnhFTEp1aEdY?=
 =?utf-8?B?b0hrbk9oOTd0NGx5TUM0WTRsZy9DZGVTVEs5WDZFL0p1bmtVamkwQXp0K25I?=
 =?utf-8?B?ZTRUak9YcTVJa3poNlpKVG1JSlpuWS80eGZKVDMzOFdjek83RkhQMzM0anhW?=
 =?utf-8?B?WkVMVXBBYm8yTkFoR01PMGpuZGdENTN6eHNtMytyMHJrN3NhSEwwOFVPaTAy?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7094485f-9099-4176-0dfc-08dbd990857f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:38:14.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkdNbWqS1SbRGDwXUPdDlXtuwt1CfMee1pCIG9iE3je+94d79X7Q6z19HJzCjf4vIYFkj1/krAB1trshdZamXQDkcOOhy9CjzSK+dwmvCwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-OriginatorOrg: intel.com



On 10/27/2023 5:23 PM, Jacob Keller wrote:
> We recently discovered during internal validation that the ice driver has
> not been properly restoring Tx timestamp configuration after a device reset,
> which resulted in application failures after a device reset.
> 
> It turned out this problem is two-fold. Since the introduction of the PTP
> support, the driver has been clobbering the user space configuration
> settings during reset. Thus after a reset, the driver will not restore
> timestamps, and will report timestamps as disabled if SIOCGHWTSTAMP ioctl is
> issued.
> 
> In addition, the recently merged auxiliary bus support code missed that
> PFINT_TSYN_MSK must be reprogrammed on the clock owner for E822 devices.
> Failure to restore this register configuration results in the driver no
> longer responding to interrupts from other ports. Depending on the traffic
> pattern, this can either result in increased latency responding to
> timestamps on the non-owner ports, or it can result in the driver never
> reporting any timestamps.
> 
> This series fixes both issues, as well as removes a redundant Tx ring field
> since we can rely on the skb flag as the primary detector for a Tx timestamp
> request.
> 
> I opted to send this to net-next, because my primary focus was on fixing the
> E822 issue which was not introduced until the auxiliary bus which isn't in
> the net tree. I do not know if the fix for the overall timestamp
> configuration issue is applicable to net, since we have had a lot of
> refactor going into the driver to support auxiliary bus as well as in
> preparation for new hardware support.
> 
> I'd like to see this merged so that the timestamping issues are fixed in
> 6.6.
> 

Heh, re-reading this now, I meant 6.7 here. The commit with the PTP
auxiliary busy support is in the code headed for 6.7, not in 6.6

Thanks,
Jake

> Jacob Keller (3):
>   ice: remove ptp_tx ring parameter flag
>   ice: unify logic for programming PFINT_TSYN_MSK
>   ice: restore timestamp configuration after device reset
> 
>  drivers/net/ethernet/intel/ice/ice_main.c |  12 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c  | 146 ++++++++++++----------
>  drivers/net/ethernet/intel/ice/ice_ptp.h  |   5 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c |   3 -
>  drivers/net/ethernet/intel/ice/ice_txrx.h |   1 -
>  5 files changed, 84 insertions(+), 83 deletions(-)
> 
> 
> base-commit: 3a04927f8d4b7a4f008f04af41e31173002eb1ea

