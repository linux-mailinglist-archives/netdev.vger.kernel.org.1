Return-Path: <netdev+bounces-30109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9387860B0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0AE1C20CD9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03011FB2D;
	Wed, 23 Aug 2023 19:35:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A472156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:35:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CABE5E;
	Wed, 23 Aug 2023 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819325; x=1724355325;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wkjTX8XZjb34sqp1gKBzioUM7aAqyuKNr8D6B/fwXJg=;
  b=A/qSAjQ4NqD/Xo41cq9+zAe5wByQ4MMp/A1NVPf/uinAgir8x8xj28mj
   ZpPd0mY2yJ1Qf/HsmX9hqUi1ngTI5RK4vkZy2pQsf2TIEGPZxtxPLKbVT
   M4dBK8S02Km0dLOTjmj7Bj2KdlfE4IlU4zkcOh7M8ov12vpPKSS3DqvnW
   gGboAYgHljF93DiiMyHM3SyD0tWIySHCcUZ6BUim3JYNkrGHrQZrGuwiB
   MH0SWOV9sUr/mlrZw4bov9Wx3M0bKEd1kjZnMl4ITu7paYVxBhP23XkFr
   RELc/vsvhGx4XwpwrDjtG1FPRFrad0g4SUl3HFIhYlIgxFqSu5fuyoaoN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405256800"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405256800"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:35:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="910628700"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="910628700"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2023 12:35:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:35:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:35:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:35:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1Zfwxtc9yfym8lvdg6hkULxYEZ8fF59zr0JlmdidjPT1vf0qpjfXVbuIVTaanfLIdoOxzXleTrtFz0NQlLOPLIIIYmGN9Jc/v3Ye8TkrWMTu9Gjal0As+mbPfirXeKcK6NuGtLqligvNM85xJlPf2H7YrzGdcxx+k9sbNR5P/eWe5CweEgenlOX7OgXR7qNvGepxtU+ekvpwrB4M1wc+SfXQeiZiW2RvUmQvQ/PloWSNaYrp9XBa8uaperOyjVO2Fvrkg/wcCt8ydxc3Y5o3GY2Ms2r9LILXswhAWneRiBUlKyocrp0Ge9qBivang0b8+ZXWHDmKrgp6b6Vf9ghCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVzwIJsPDjHn02eFs/GfTVMgBGO5RobSsGyLExCylus=;
 b=gGLuqkzwhdtK8TPmzBs1gDTg7OU2mVcS+/RNc5xuQv1YJ8anHXWXC8qaGhBRoAPmvPrSSn4+LBpGsJUD1hsA5mFYwHAxhYp5DpWfjQC5kTGVtEXyCjsmkqRcLEEbyzSUfhwh41OhnkEtu3b1IcF1DFq+YP54GeRHQtGwbMf+ZQ5SdCzJQgco5kO/5c5W4gF0yT/WHlrUG94sgKcG3LSvpFSrcbCVDx0RzmDwvNHxwCVHnfMV21vZH1LRCGZAOOFvnqCmcniHz7kVjCUsO+ZOiyKmJ1Qc9lQUYF2IivhvM+YIza+6a/x98QbyvAmKRqS7APcGfV3FykGSSZFk8PcKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 19:35:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:35:11 +0000
Message-ID: <56087081-510a-32df-c249-56a2cf138048@intel.com>
Date: Wed, 23 Aug 2023 12:35:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 04/12] doc/netlink: Document the netlink-raw
 schema extensions
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-5-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-5-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2bcb69-c6d7-4c3c-c9b5-08dba41010f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuiB5D0eUWJARas8RC18YjvO/ZAv972JjCscU//RhqGEQA/6xM47dZ5gDZrnQP6IOLADzK/nxDw7OOdHXdM+v1o5WR52R8h81OinxNyLAyOkvc2tg23PcoukfPJjy8R9A1I+nYPY6lwbTjWPwzdxvPizyurzlZsyaG/rMuOewAxYnqrhtCI517jAIkQC+JbGiESG3q7MxIyQHDkzukOEeARDkRAgB3SHHVeZLkm3QEExWBp/SamA5cdMg1I/+PcFuoW9YiI2SNQ0NVR+ete+ZExaGbtQAvc1nDY8f9bE2/a2bMSvFlE26DlrQXE4h6ppZq+VY7LRBEWDEWAdtYIQ18q+OGmaRPFKIl6tdXqB3XoG9tMDtla66Da6AgVsT3fhSdc/fU5izbVfXxi4tvkpD0yGSokARH6HyJW2FnxBqI49I+m8uXNgTCeejHO6xvdCENHfeWzptg1EZ/hKOeMN/8qzqQdWULLVbsPNt+0xKxbB055eVC2ZVJvp+vzucSBbSiN3H2veix+r//WTeu0IC6mVAVGoL6Xe/jx6g7CeIZBmZjmjgXdFWSWW9dQtHsffxdtwtgTCaHopeibX5gloTUnQHRq+QqEGg4/2LABagpiVCn3+ogTvnfF5VJGSOaoB2NbCDIAIc1cqQUSM/x8fg6VEZmz+NwbBEZhKm5VCg9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(1800799009)(186009)(451199024)(82960400001)(478600001)(6486002)(110136005)(6506007)(6512007)(2616005)(2906002)(41300700001)(7416002)(8936002)(26005)(4326008)(86362001)(316002)(5660300002)(53546011)(6636002)(8676002)(66946007)(36756003)(31696002)(66476007)(66556008)(558084003)(38100700002)(921005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJHaUJpejBSMHpSdWdSVitOVnNKKy9lQVplRHR3NFFlcTA5WjFlc0Nzd2Fu?=
 =?utf-8?B?aUlIdjk1MVl0enJvMlFKdDlkbkpwMm1GTkJJTXE0Q0lJTnN2Qk9oa1Z3TkNi?=
 =?utf-8?B?QVpaOUFpUnhabWtIQkFYNDZhekUxU1JqSzZhTjlBNDR0dWtmU28xM1ZBVzE4?=
 =?utf-8?B?UFgzL2xEaWhhc1pjOW1hRFYyL1FwSHJSZHR2V1NtLythMkFPRkVkejZMNDFF?=
 =?utf-8?B?R29zeCszVWRKSDZaQ1ZOdkorRkZaL05IVnViL3REbXhabGszSHJMRzlDTTBM?=
 =?utf-8?B?L2RQckh5Wm0xS09zQUFtRTRud3NCL0F2YTM3eGZxQ01jVm5hWkh6MFNCTGZQ?=
 =?utf-8?B?L0xFbjAxNVFHVE11cm82N2E2SDFnalUwQkhTcWU0RTZxVXFYdVh4U1B5S3Yz?=
 =?utf-8?B?cExVcFVPSzRSQVJWUnN0UVk1cjJYQ3dzS2tGa1lLTWkrbUI2ZmZnM0xjcmkw?=
 =?utf-8?B?TDJwaGFtTGE5Q01zVTFkYzI3MUdkbmVXaDU0NUtIaC9wYzNSa3Btdml5UkRG?=
 =?utf-8?B?cW42STRPc1dOaEd4M3BOejhFc1dkbHVWNTIvdHJzZnJhakpac2JqQVJsMUtM?=
 =?utf-8?B?amM1QkhCUmJaNzVhc3lSK3VBcjY2cWNMMTBKTGdIUDRncnZseHpuZXRoMVJh?=
 =?utf-8?B?RVhvVXl4S21RZlhZK0JsUUhTcXhVVDZ0aDF2NkhqMGFGajlVSXJSLzZJT2hL?=
 =?utf-8?B?NHNneTZCUmFlemJPTG95TDk3dW5FYjFLK2dVVzhSR1Y2d2NSd0h1V3FVYnVi?=
 =?utf-8?B?dEh1M0N5NGRSTGdxbzZQaGZmeHlFYU9XQzFHdFlOTHhlc1l1QVh4QmhLZjdv?=
 =?utf-8?B?aUZuTkFNd2txcEUzOWMwbGJ5MlhQb1FQeW5FYnFhby94U21ENDlLTCtuOHJO?=
 =?utf-8?B?RDB1c25aMXcvM0huU0d5cVUrSWdUcDJCSHhCWGNoM1VpTFdPOENNNVV6SmNi?=
 =?utf-8?B?V3VLalJqRjhuRDlFWmtNMnZNaitxNXJrd0djYUxBZmVqSXEvY1FFQ21kYkg4?=
 =?utf-8?B?VXBTMTZhN0pJU1Y5dWZLeXhhajZIL2ZmMnpaTzUvMkZNYU5raWI5K0puakdr?=
 =?utf-8?B?L3VXVHZEcDBnRHJ0aXRXaXlJcy9wZDhXZjhPT2dlb2JDNjdwRjlmZldNU3pT?=
 =?utf-8?B?Tm5haEljMjVCVkRLb1ZsdUswclR6NDd4MTBXUHJPc2ZHYmN0S1UvZ0NZTXE2?=
 =?utf-8?B?R1dvL2JRaFZ6L0lWWTcvSW1qUmpkMFdSMTE2emxzOWV1Y3NoSkptMDJWZ0Zl?=
 =?utf-8?B?R0pKaFI1WUZHRXdvb1JSdHlWVFEwcFk2RzdtVzV5ZHhxNkNIUEk3RnpsbzdX?=
 =?utf-8?B?Z0pwQ09vMmNXUjcwVldZSWRaNTVOQXFoWFU2VEJJY3Vla0NqUElVYk1XZTRw?=
 =?utf-8?B?YmNoM1Zab01KamFmNHZVMUZ5bjJUdUJFYjBLS0s5WlhFd1RuQUVjNzlLQTBS?=
 =?utf-8?B?eStkdi9pWWVKS2RXWmJmcFV2aUkrYmZIRGJEVElFWSs1RlBCQWdqUEwyVTlX?=
 =?utf-8?B?QjZZeWIxaG1IK1BrWWZkblJFbG9ZN0gwTk5FV3VZRkpkeVVZTWlORFJTNjZ1?=
 =?utf-8?B?anpBbmVLM3ZVaVc5MXh6SGZsdGJxTytMeHptNjlrZXFwVFhoTlpnekVWS0Nq?=
 =?utf-8?B?eWt6dFo3TEEwbHd3L0FwZXY1WWdlYU1UcTNGMDhnQ0NPVWRTY2RWc3JhV2ky?=
 =?utf-8?B?eUFmZUx2K0RCR09XQ1FkbXJ0bHRnVFVWRXk4dXNyaFNDN2tvdmZHOUpWOWZl?=
 =?utf-8?B?dEVXOWh5OHhUbmtOdDFiWjB2STMrWEVGZktva3NCaC9tazQ4OGtIZkdUNjg3?=
 =?utf-8?B?TDhaSjJzb0ZZejRjUGtxOEFjYXZnd0l6MGtScVNkRUd1cmdFY0NzYzVOR2JZ?=
 =?utf-8?B?bUNLOVlydHFSUXo5VU5pUzdwNVdnS29BbmNsUy9PZHVhNllTTTdpWlVMc0s1?=
 =?utf-8?B?RkpTVEhLNzJqUHRzdnBnblNzZ0V5MnlBYUdCMWRJdFV6Um4zK2hpME4wS2lV?=
 =?utf-8?B?Sjh4dzVVeEMzUHBDWXBzYlYxK0dzaDRyVWJ6OUIwd0pmdHZ0NFZmbENNZkNC?=
 =?utf-8?B?QStBQ0ZyWG5iZlY4RjJYZ0haTjllV0lxbVZTQi8xRE05dXgza2Y1dGRXSllH?=
 =?utf-8?B?MHJLMTRWSDJDYkY4V2lNbVFMUC9NWU9YOE5tOGZEUVh5MVY3TWtoa0s2VEw3?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2bcb69-c6d7-4c3c-c9b5-08dba41010f3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:35:11.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHTNxYZuvQGTmiH3ayLxxubV17p65rZAbJxaC6ghrgLD5FYUTyoY3/z3Bxoo5n6jlVLg680asDxdsaW2uA6ldTa8VgflBjFEPnxaSogEPJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> Add a doc page for netlink-raw that describes the schema attributes
> needed for netlink-raw.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

