Return-Path: <netdev+bounces-51656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9297FB9A1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C2028209E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110B34F886;
	Tue, 28 Nov 2023 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiqIYSVa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E62D56
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701172145; x=1732708145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y6O8ZFAjHNxskPQjIdDrXEznTTGn+BbtyVwDY1p5oEY=;
  b=hiqIYSVaOPZWSHtPSNmYZZms5kLw0a5hIBrLoamKBkWGpFNSabL+ZRpy
   l906y+nzxWwbKatU3yJPiMzQJ9IKJWqysAWQVic7qSSmPH7XXnHvKAAfi
   ukgZvmMiPXFt78HjYAlzRq1CEvrdZusuymxGo8pwyEAbn4rizD05dMwUH
   4F/l384XwrFiTSMieW7MKRWtt+mmWMQfv34H3tp0n0JfryIIOFtq3amaI
   VvxPWx0d2BXNXp4F0jys8cYHmHi3cWo2ERxGlTmGu32AWMc5kwiO9OX7F
   5+EdDilBx49+bZLwROuZweFbCJVZ7wfMWpNxYitfLtyTxOb61t2L8cURS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="6104434"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="6104434"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 03:48:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="797566204"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="797566204"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 03:48:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 03:48:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 03:48:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 03:48:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 03:48:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmS9+GkWG5OAHVKKzEEYalxskFGvXho5VwStlBMgB3fqgRA1HkQXBICmAzUjiidCxlQGU2dsyD3bjF0uDoqL1Oh5e51CCqLDoxiw2rTlruMZTDHxmE7Q6xB6AW9z/VHQ/sstG//GdlKDaWJvKUpjOeDqt7GZ5FeBWSHGTNPnH4sJ2LUbCSnWnIpRAC250J2fIqT7PO1BombcyHBHTdkSM3TQpsmfErXmOS0rOJ0SMU8/UJ/5sTlwl73R9Xb5g8bz45BcjNd+q+MGKKbIoIMQOYfHzqcgqWVJvstdjARfsfgUdvDmFMgor2wsE5w4gZHTsu475HPQHrBJYK5iSb4N9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sbJJjUi9jdISMaiVvwZQY9G42544pUFl11uaOCcvqs=;
 b=OK9hnImC/4UAe2uEeuoE91vRAByA+LlXyAJ6EAL872QfNnfW1VxK9nC1lj0Tway3yqB5/mwyHvJxBCu33QXmmguwaMFHac5NGw8THx89ta7pHbhUF1R7xiy/ogK+pQM8klUdHk2P1t9Ho2PBGBFnLj9OkYLE/ovHDboEjSizlHvf/FxwnH8VnBJzCM9rWQpGUhEADr30g7dvtRnYm23uV2C9ezwJzpaLGxlA1SzuCvXqPbO0s4leonZ2bjcMPXxltkfxgIRIhAU43UJPOjykxpGAdD7cwyBc413vkFNCIuTkzJHjLEezQ9udCUmVCVu68uy8xUTBY8ZMgAThzc66fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 11:48:43 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 11:48:42 +0000
Message-ID: <b105a5c0-cf80-6b3d-b566-c52ce00e9284@intel.com>
Date: Tue, 28 Nov 2023 12:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net v2] ice: Fix VF Reset paths when interface in a failed
 over aggregate
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Dave Ertman <david.m.ertman@intel.com>, <carolyn.wyborny@intel.com>,
	<daniel.machon@microchip.com>, <maciej.fijalkowski@intel.com>,
	<jay.vosburgh@canonical.com>, Sujai Buvaneswaran
	<sujai.buvaneswaran@intel.com>
References: <20231127212340.1137657-1-anthony.l.nguyen@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231127212340.1137657-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0370.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::22) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DM4PR11MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: fd94e9e7-4de6-4e7c-739d-08dbf007f85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mN7eVr8eA+Q2pYou3X4UFl4HT8m7uOYwtJaqa4AL9zlFZ94+Uv94oVSnohFhisjhR0cuTVKuQkLruQErfujww7TQTakzhD+Xyn9gYjl9q45fpa5ZmwSk/QJSRm7PdbvBt1hAFp71vOlkMMgrPsrDRwWBYr628t4Hm9yWcr2wSWglwQR8IxSfgU+u6o23r8ZGSdg5j9qwdGFmV9/F6y2TIlsgvehVOxsNgD+ESN44+5KE/rkkh4qJ5apMgywwgmzw3EZMgBJZjx50iXq3fa3isSnBaTM7+DGW1/i7I04jVIv+2XzTlSBnt1HYqyeQ2cXq3hEvl8JcZ5V2CDyhsF8BM/FZ5seMsZXwsnmE5SGooVaRo0CXdeVvvcYLuu0IuoYS6CMJdlu7DEXelv0uxnQ/TMSujIL/IIOqG4R9QSV7NJ0xRyacfzu2MnsnJW9ftlEofgTUkhghctx+mreU4UnItoqcmeBmCZtCXz/PFujmgUWYH6ZDS1HdbR0OTkd2QRvtBwSvPUKhIXinf6dv0vJJml1RklQQpDMR47tV3SFx1bu1FRHl1x61yDhlT+f6BoPND1so4MkIuAXGWd0ihYlhiE2A5OBmBt1n9M6BLhOI9Nk7Spz/AP0Yqt3dKLS1cqWa0ytfLg3OSasHhlApC8GGaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(36756003)(82960400001)(31696002)(86362001)(316002)(66556008)(54906003)(66476007)(8936002)(8676002)(66946007)(6512007)(53546011)(4326008)(6506007)(478600001)(6666004)(6486002)(966005)(5660300002)(2906002)(31686004)(41300700001)(26005)(107886003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01BRmUrc2U4UXVqbHNxY3AwTS9OWjlFcWpCR3FaNmwrVEV3UG1wa0ozTjVP?=
 =?utf-8?B?enlHSVZ4YTh2WUZtcVgycUs0S0w1K2tkSHdjT3pPS1E5RXZGcWZYT2ZlMlpJ?=
 =?utf-8?B?VU45SlkvR3NnaEoxeGtJbTZucDRPQlg2aVdOdTZlck9ZV2JwNU1UL3p4VU5o?=
 =?utf-8?B?blAyQStvbGZWVjVOTFV2NWNONDFydGdGWWZCZGZXdVRXSy9RZXNsMFJWYU1I?=
 =?utf-8?B?NU1EdFdQc1p4U0p1V2pURlp4eStxdWhPVXB3TTkybisxSmpCeGZyL092dkNv?=
 =?utf-8?B?MkY5NXdMaDNBK0FUNWdJdEtPdEFoNXdFek52dWFwbUllQms1Z0VRbFYwMk1l?=
 =?utf-8?B?NDVJajVMUGtEdUJBSWNTVzJCaGRSOTZleXMyMDRLcjR0bzJ2MkpVQkp2SjNw?=
 =?utf-8?B?dHp1SnFtNnllTGg0ZVVCVzRSd0MrYXNNaTdIT0JvT1NJRjAweGxQQU5OMCtJ?=
 =?utf-8?B?M1doYlJnY3I2b05oMUVpZGNaNU1UNW9NUnVXZE1ScHNJWGhLaHZqUG1xU1k1?=
 =?utf-8?B?K1dpTWREaHErb0sveTNuc3ZnWVFnTWJjWUlyZjhtMjJXSmV1d1FUSGE0Wjc1?=
 =?utf-8?B?U3czSVUwODgycHZsclZCK1hUTy9NMmlJUmMwNFZDYXNxMG8wbkVGN3FvVFZI?=
 =?utf-8?B?OFhXRzJKUEE3WGgrVDNvTkdhMFF5Q3dYeXo1V00wSjNLd3Rma0x2K3BIbzhq?=
 =?utf-8?B?MTB6YmZnNmVEV1FxeUg1MTI4M3BTL3MvY3FxeTlLa2syVGxBK0s4SlFUSDVB?=
 =?utf-8?B?T3JGa0FRYVlMbXdaTllQdklLTWZyM3Z0VDlKYVR0ZkFmOVEwekNHN3VVOFdC?=
 =?utf-8?B?YnUvdk5qeWlHajhmQiswWnp1RE5FZHoyMFhZS0ZYQm1FdVo2VTdha1VFbUx3?=
 =?utf-8?B?THk2ZVRhLzRROXo1eXlGaHIvbWZ4cGhBeEpYRUFudFYyVHJXUWFFT04wbmVS?=
 =?utf-8?B?WE1PbElUK0xxY3JqRWxNVUkyN1l0QkppSjN5bkE2SmZPTnJXRitmaTVoeUtQ?=
 =?utf-8?B?ZE9mVW4xRWtEcHBlWklmMXZCd1g4RlVJc1ZiQi8zcXUzcXI0SDBwQmUxbk93?=
 =?utf-8?B?ZHVwR3VtcnlkRGlKRTlVcFhja2ZRR2poZW42ekNkUXRXYlJUZjVqVCtQWUlE?=
 =?utf-8?B?Z3hXZXk5a1d2SG8xdGZhL21QQTc0RGJhR1NSTXkzdTVqaEV0ZnQ4YUt1ZTJt?=
 =?utf-8?B?ZXVtZTlVVnU2dTRaRDE2bmJVakQzVGNIZ2hObmViZ2NGT1JyenFmWEs4a2NJ?=
 =?utf-8?B?dUZPRzZ3bFc4NUpIaXF5YXpWMEJzTE1jRlpnY3lsQS91RlJZT01sRHhPTm11?=
 =?utf-8?B?K3RtYWFTL2dRc21HWlh1RlBtalRPais4S2hnWW9qVU5Ec3pqY0c5TFlEZzRC?=
 =?utf-8?B?dHE0L0VZOHl2UExsSkJXZjZHL3A1N0JQalVVTkdsTUhPSWdLZWRrYkJybEtR?=
 =?utf-8?B?OVlscE1UbVBicWJycHg4S1dBZWlPMXYvUXNvREZOOXVoMURIOVRROE9BR0xX?=
 =?utf-8?B?cjc2ZkJyNXBpdWtETm0yTXBmYWZQc1U1Q1Z2Q3l2dTZ2cjlxeUltREZ1b2cv?=
 =?utf-8?B?OWRtT0ZMdzBHQk95SVd3djBCNEI1VTg4eFZDRitia21FY1VZRlNUTVF1cHlG?=
 =?utf-8?B?Q2l4dWNVRmNNUHIyeEFqMFVGUTY3QU1uUFkrbEVIbW5xYnBCQlo2blhHakY2?=
 =?utf-8?B?Slg0ZnEzc1VEdExTaXhYVGJZQTc2OVFzaWRiK2Y1eElUeUcxcDh6RHE0RWZU?=
 =?utf-8?B?T1hEN0VsUHhTM28xM3RVMjFCTXZZczZ0d1AzWERkSVpTUkxDK05rc1BoUUxF?=
 =?utf-8?B?YjFPSVI5bVNWbk9Ia2dGRXpKcWtKU2hGTXoxREpYQmI0TVh4bGFEejNua1V3?=
 =?utf-8?B?b2tPLy8yTURaYUU3MTIvdW4zNVkwczQ0alRVZWJEK2dRR1V6SlZkWFBxVVZr?=
 =?utf-8?B?YmZkejZXRDNtWlNRc3U4WC9lNDRkTTlRWjl4aUo2VWhZRHdyZmphamFSazd5?=
 =?utf-8?B?WHdkd0FjVXdiNHRJZWNTdzdEczNuVlZQcDQxdEhVcWQwQ0FRZlA2bEkzemNs?=
 =?utf-8?B?MzRUc0JsT01iSGpTZG1WakpzK2hZNm1BTmljWTM1WU55MlNZbDg4ZDM0Qm8r?=
 =?utf-8?B?cEsyeCtlK2xKb3ZxVnJIbE5LNjJJZHRBaHJTS3Q5T0VzZkE3eFNFUllwbzgv?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd94e9e7-4de6-4e7c-739d-08dbf007f85c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 11:48:42.7545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIwtxCHCDTznzket5yjybSEQSQMmRB9qjdIm9+qdG3yhnAh/8So6rx4bmaiqo9pW2ldvvqxmABsy5oGhq74QX5Ebfo6Ib0dHRfGpSVit+bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
X-OriginatorOrg: intel.com

On 11/27/23 22:23, Tony Nguyen wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> There is an error when an interface has the following conditions:
> - PF is in an aggregate (bond)
> - PF has VFs created on it
> - bond is in a state where it is failed-over to the secondary interface
> - A VF reset is issued on one or more of those VFs
> 
> The issue is generated by the originating PF trying to rebuild or
> reconfigure the VF resources.  Since the bond is failed over to the
> secondary interface the queue contexts are in a modified state.
> 
> To fix this issue, have the originating interface reclaim its resources
> prior to the tear-down and rebuild or reconfigure.  Then after the process
> is complete, move the resources back to the currently active interface.
> 
> There are multiple paths that can be used depending on what triggered the
> event, so create a helper function to move the queues and use paired calls
> to the helper (back to origin, process, then move back to active interface)
> under the same lag_mutex lock.
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> - Created helper functions to avoid replicating code

Thanks a lot for that!

> - Changed to use list_for_each_entry_safe()
> 
> v1: https://lore.kernel.org/netdev/20231115211242.1747810-1-anthony.l.nguyen@intel.com/
> 
>   drivers/net/ethernet/intel/ice/ice_lag.c      | 122 +++++++++++-------
>   drivers/net/ethernet/intel/ice/ice_lag.h      |   1 +
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  20 +++
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c |  25 ++++
>   4 files changed, 118 insertions(+), 50 deletions(-)

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

