Return-Path: <netdev+bounces-54654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C614D807C3E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 00:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F651F2188F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A6A2E3FE;
	Wed,  6 Dec 2023 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVv/HbbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC40093
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 15:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701904785; x=1733440785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=feFqacbMvwDhGi7Msvnn+tfRPqomjFqihL2aCnaYsdQ=;
  b=FVv/HbbZGxSFjjp1z4nUeNpkygkbfNwn7LUZqYc4QziElaArEkddnZiZ
   E8xrYPVDgldMw6mC40K0v+rYVQOVorpv3irXqk2aabTRcd7/NgYtY3w85
   XKEdvFge7WdW2yeTiOPKWcq/dxR/i9mex7ivxtx6FkclYbQlPY85Q4EEx
   PvOkM//w4x2zCf4VNZdBl/IDObKC/ae5NKwXnDmqPofp6b4z+65VbHici
   hXbucNvohVZL05/xjNPOFtvDGEYukTctWZMo2nCUaDTZ2fnt/JRzJUsEq
   skEfLlTVAK+6qTLePxoXYMYupDooHl6fU7n8Re5w5afb9+oemWjg46Tb+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="384543962"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="384543962"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 15:19:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19483636"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 15:19:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 15:19:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 15:19:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 15:19:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 15:19:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2tqWl228aJf1y2eX4m8jzhFjewmMKA6S2UyTFtEAGa2BFFyqUMJG1UdcctNhPqYCPxTQysr6zBl/O5dO+lwhB1/DsaYbHd8KD/hyDCYdq0HMny+aKremTlrV+wFcNfTRTnyU1uNiEi5VEG1E16gerdh2zzG8cSpYn01oXVOzeNXl0vvN1M4cO4v3UE2RM8jPorG5I4KQ0WdOIEpgfTdoRab0QbN8gwZ+oAKKT5iAn6Uu6LhFY5NBSaMpGzUO6ZYNKrDAWV1o7ZsPubAeg10qbUkBAXrPEIaC6azR4yYtdxHaTlr2/Brz48loAqkS1F5F5keJN14K6nSvZ/DDLhxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofq+5p63Qn4YDwjt1PYgpmjvOl50vffuYcTwjBH3Bx0=;
 b=oUhNIuHlHMgIv333lmdfQD08s7TlYRorFUDJDa3nOPE+86IRL8KyRyiVstviLHi4aUg6O7/21PuRtgTkqxs3gNDMZFS+0+caxgImXw4RUA4rEpfmEtyCwNjJImaanoIBHeqba7LdqUa9GmFJzrqZ7ql6IY+OxZg4/F8AJ4JTZ0ND5IeTuvdNG1kOpqKbNERY5Q7zs15dgMnJBPhsAKas1AeKZkayMPoj6zDoZsSpqy8U3asx7ipmpxn30tm2yroLZGXV1CwvRKsnivsoIC1HBvePu1OtP+Fx5/253widIehbMaaPW1S64GBMVddD2h/YdroImoWgfILTb/OLCRPMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 23:19:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 23:19:38 +0000
Message-ID: <cc284e70-23c9-463a-8ac2-9a4df8e03374@intel.com>
Date: Wed, 6 Dec 2023 15:19:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] drop_monitor: Require 'CAP_SYS_ADMIN' when
 joining "events" group
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<jiri@resnulli.us>, <johannes@sipsolutions.net>, <horms@kernel.org>,
	<andriy.shevchenko@linux.intel.com>, <jhs@mojatatu.com>
References: <20231206213102.1824398-1-idosch@nvidia.com>
 <20231206213102.1824398-3-idosch@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231206213102.1824398-3-idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:302:1::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cff2c36-37cf-46ed-b97c-08dbf6b1d170
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDYoG/IneDZuvolTqEKApjVBnocj43Mw8WJ8Ht9qXBy4tuRSASXSrFFMvcoFQa6Hnat6Cpm1mEfhd0Zv5x382cfMGakIF07ArmiwKiKwB5QC6Yu1VfP8eXMpRwbb4mufet/RhurnZR+h+L8hJddu1aEdH3rsCUvsHYHPStl6d3KggTnerLC2VlxPw17ClXwOeM/s53VYV0u5hzKOiNcgBtka4xo2gB2tyqeqrawBEuSZixrjwM4UNFAO1ajuxhMWhI9z7ok1tyJWPQTnaRqknE5L9E1yRhYaVQZuBszyCM84WLEr6eaYHanZeWrBiqtvxf9joSygga2s1GLqrlgUE6GKK9XOsPBMxoQnfGcO+T5GJYMiHrPHg0mQV/JCfB7aix0lUOK+QBtTyKBVq8hCtUqjGnKsSUyTNNS6g1bYiA41NkSNQQIpZ0xNoFjYQTbEJ0ch9ZiB5Ov6cvwmVpkWQsAj2qILss+c1NyjaVia54coTpTdIqtAe0vHv8epY8h8lM6ZG5CMbwPdPzJTrgYh6H0VFsWsXMhasByG7FgL4LV/zFM/MFRopV0Zk98vh67FwPLciRO2y1bxdCdZukkXydgjnuSRhi4QYNhXclulAosMeqYiiliMamWM5IPZbE7E2fOc5UNLGDOwPtEMoTUE5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(66946007)(66556008)(66476007)(82960400001)(86362001)(36756003)(316002)(38100700002)(31696002)(83380400001)(26005)(2616005)(6512007)(53546011)(6506007)(6486002)(8936002)(2906002)(7416002)(41300700001)(478600001)(8676002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUZWZy9pNVJzd2NMeS9Id1BKaCszKzUxUU9HU3h0YkxqdzNXeG1uQjBhS2Vv?=
 =?utf-8?B?cGxkeWVSNHh5U0dNcWdMTDNZd1RkSWNMWmhSdU9tb05jVUYrYkFYYmNHQmxD?=
 =?utf-8?B?eUlweVZ6ZXBuM2l2NXJVMWxRTGIreXhoSDdmRjNzVmdWelFob2NjdmpPRE9Z?=
 =?utf-8?B?Y213UEcvejVaeVdRZXRaOW92NlM5ZTBDUW41N3VEQ0VwNmtnZm5tM1pHWDMz?=
 =?utf-8?B?NWZTaTI1R3FhSVRLelBjZWtNclR6N3NENzc2V0w2aG5LVDA5QUxVNS9OWklI?=
 =?utf-8?B?Nk1MWW5NZFFVVVg5THhqQlpnSmd5dWxINHhQS0J4VEs2bkhYWlA5YTdjcXc2?=
 =?utf-8?B?eU1uaDVoSU1IMHNXb3FlVXpNaHlsZHRNbFFFa1MzdGc5MzIyWVJYUkp6aEF3?=
 =?utf-8?B?VWlzSUFXVWZCMkcrOHlSa0wySVQ1NE42b0Z5bkRzUG5WNXN3NFRER0dUVDFu?=
 =?utf-8?B?SS9PTG55MFV5ejlaWDBGN0lva1BndlZSOXBpaDUzTk9LNU5xbjlqcVZ0aG9Z?=
 =?utf-8?B?M2t3RFE5VUVqa3MwMTlxdmdEWDNIQmRoVXZDakxFM0g3ZUxNbkRWenEwV2xB?=
 =?utf-8?B?UEpVWjA4a2lMU2pPWWtpWmI1QkxnQ25NNHhvajZPdXc2WElSV3ZkU1RSOTYv?=
 =?utf-8?B?b1FJZHIrdzdtamR3ZEdzdUdDOUtrWHdwWEZIWElwS0hwNksxYk1XMjBrbjFn?=
 =?utf-8?B?VGtnWStBMGYrZnZCK0FyODNKSVR5Ny9vaU5IdlI5d0RhelFZbXhjcUpIM1Nw?=
 =?utf-8?B?cXptTHRnQjBSWXFPRE54cHl6aWc2RW9OVWZTM01yWDlGRmZzazhIT0s5SDk4?=
 =?utf-8?B?eHg4djZtZE9Zb1M4Tzd4TlJjTGVSbnQ3ZWFIRkpqQ2VobElzWUIwWlNsL2M4?=
 =?utf-8?B?NFJaQkp6cGViWXhvb0QyRUl0RGg1MVFTNEUweXJMRS9GeGVCemxOQXVTQ2dJ?=
 =?utf-8?B?Rk5lcnNIa2E2MGR3b1ZSV04wNnhJVHJ0ZGNScDRhbkZOK2RFSGdNbWhvOW12?=
 =?utf-8?B?Z0dzb2RXNFNKclQwQ3Y5TXpOUHlPUnl0c0VGOTFTZ1FMSE8yRkRJdWYyK1hs?=
 =?utf-8?B?eW82RTF5aTV3UTFFRWpBSnR1blpKM1hpV3A1c2hoK0JxMDEvQ0VFUGhSTkEy?=
 =?utf-8?B?ZVVnbG1KeWtOTzlUcFpxcXk4TEdzTnc2c3NrekNjVVRsN3k3MERtamJWRHNM?=
 =?utf-8?B?Ump4cVdCR2xtZzIxTEFQMmU0V09VM0pST044WU1UOE5FMDRQMHZBTThveHRD?=
 =?utf-8?B?SUdHQlZQcXdvY21WNlRjWUdhbmtScEdTWjBrbk9Wb25kUCttR2VncDVYK3Zi?=
 =?utf-8?B?cFFONk85aUNuMXQyaGJaUEFTcmxwRXlGd0JWZldoNE83VGhadHZiZk5CNWdX?=
 =?utf-8?B?K1RqVk1EZnhXenBpa0Q5R2U1cnZ1b01PcHFGSkRDRnRRTkx5dHg0STZUNjd6?=
 =?utf-8?B?dDA4SzB4UHRHOWJwdlNpWDNCbm1jM1dBSm5oaWQ0a3N3KzR5Z1dlQTZZekxS?=
 =?utf-8?B?enJXZkQyWWREY1k2UFRrRTRxbzZDcXpoVUlQQVd0MGlib3BEeDVqWElNdlY3?=
 =?utf-8?B?N2FGSDgzZUcxUWFMaEVBQ2p6N0ZaMHVrV01wdVJ3UVVERmY4dENTWkY5VEVK?=
 =?utf-8?B?N1Fva2FMQ3FOWGlOLzdSdDdMdWdmQ1RFL2VCaHAwKy9tTzR4V0dESHpibUJN?=
 =?utf-8?B?MTNHWmNQR3ErWTFyQlhnSVZWajFMUUdpYkd1M2tSNWRlMlEyNEEyUnEyTVU4?=
 =?utf-8?B?RVc5a1pVRHhUU3lHR2k1b1dsUGRoOTBSR2hZYTZocXlHWXUrRW9CandPZjFE?=
 =?utf-8?B?T0R6U05Dbmc4U0ZNYVZPUGdXQWtzOUFyWm96YjltOHBhWjlLSWNrM1dpYUhu?=
 =?utf-8?B?a3c3c0VyN1k4V2tHMGkxSkh2Wk50VlRvOUhhMjJmZjhpRUVKRmRQRGovWXVS?=
 =?utf-8?B?SjhxcE9sSHhIUmtPOWxNbXk3SW9hN3RIU3NaZzdwRDlpRno4ZGozczM1ejZl?=
 =?utf-8?B?aUlqRHFGNzRZZzZESzZxcFBKT2NIZEJyY2xISHk0V25QV2MwTjVOZFVmejJv?=
 =?utf-8?B?STVSSVhoTE1ybmdtYXc0UFB2UGdjaXFtcW5RcHNYMlMrU2pxUnY2OGhaRmpS?=
 =?utf-8?B?Mmt0NloxM0tQamZ2am9nakh6Mm5VY2FtTFN6L0t3elhOdHZ6a20zQlQydGpD?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cff2c36-37cf-46ed-b97c-08dbf6b1d170
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 23:19:38.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urXKp7jLdQMkRr+YyMN2dmPoNOhzMStHfFwpq8S9d4yPGXQAC/MQwtYVFMDRuOCyTpSJsWzR5v3Plr3YhW6Fx6UNhkcBNG89wBhEx3GOeQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
X-OriginatorOrg: intel.com



On 12/6/2023 1:31 PM, Ido Schimmel wrote:
> The "NET_DM" generic netlink family notifies drop locations over the
> "events" multicast group. This is problematic since by default generic
> netlink allows non-root users to listen to these notifications.
> 
> Fix by adding a new field to the generic netlink multicast group
> structure that when set prevents non-root users or root without the
> 'CAP_SYS_ADMIN' capability (in the user namespace owning the network
> namespace) from joining the group. Set this field for the "events"
> group. Use 'CAP_SYS_ADMIN' rather than 'CAP_NET_ADMIN' because of the
> nature of the information that is shared over this group.
> 
> Note that the capability check in this case will always be performed
> against the initial user namespace since the family is not netns aware
> and only operates in the initial network namespace.
> 
> A new field is added to the structure rather than using the "flags"
> field because the existing field uses uAPI flags and it is inappropriate
> to add a new uAPI flag for an internal kernel check. In net-next we can
> rework the "flags" field to use internal flags and fold the new field
> into it. But for now, in order to reduce the amount of changes, add a
> new field.
> 
> Since the information can only be consumed by root, mark the control
> plane operations that start and stop the tracing as root-only using the
> 'GENL_ADMIN_PERM' flag.
> 

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

