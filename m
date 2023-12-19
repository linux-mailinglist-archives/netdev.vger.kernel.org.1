Return-Path: <netdev+bounces-58805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A581840F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61FE1F23DCC
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B986125B2;
	Tue, 19 Dec 2023 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igkl+lfd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E8134A3
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702976722; x=1734512722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3OHQqVQhvfKq6mDFNnKV423VfWo/hCaRbxBex1Ge2Ck=;
  b=igkl+lfdE2C9byKonmghLVNufUAHYEu+V8j6V1hEAsPilIx/qrgH5jVW
   WNUANoZzDrgQVYNjMQ7zsmR1N3yDDIvsShV7XT/C1E8+C0yxGH2b8/dGe
   0lDEvZkYF97lI+sVMWTQ7Wqk/ii1i5NP0JO/2d+i7/Ui31OpZuS7ocNNm
   eK0/Ux4UYE+PE3UlpBI1qS5xkSZObozSVjrq5a8JaMu542nTrYCoQDTGl
   2p4d0Cr1jfuADW46LB4kGMHp75smdVd6n4nkeg9I6wLLYE1lUNa/vEC59
   Ame/hvFtBYGEqCIdmVJ/YZ4sdWWs9rg/CBKM7FhMpDwEp5ullqFTd48xW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394505928"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="394505928"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 01:05:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="775898203"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="775898203"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 01:05:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 01:05:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 01:05:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 01:05:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 01:05:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0WtA3uRWJ8jBbwSOsIPq9VrHu8GFgezpzIMM84fH6dlNXai8Tw+rB1upuAuRPsgdqZ0FnYiRWBwGRkifRn0G6WecDfX0aTB14drFC+ZkQIyrPwR3uaBqb8CnQQhXYGPv2r8f8/kKE9um36HkVPmXFggi3+kNFlV6jl9+HYULnfQqIBVx78tlmyavlB6RpXXwrc3XgNK4TjvyithzFZJVLbUi7cqJsQBXiaFGkqpBSwFxBXd13iZqqWU6ONaErzJBRu8RkGApTFtzIs9656Xn+aHq/WGGYKQuPYmRamqjwQqZDcn4dv2kpPiX2GsXO2op4ifOEN2rCYnSShccWulGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BREcSzc3MKRVDJ+bC4+dO70XQhKChlREy0u5bKPuhLI=;
 b=nPgiJb/sU3q7DAtd6ZecHapQuVavBAww42YtsVAgrNGGQ7vG3gdKETy7eFj45tebYYmMyOg2Q+/35w79xI18R3WXDcRJ1ZuxfBpuDX4+b5CKRcz0MubZxRdqrqBcmk8gM+j1W6np1cACJducFAY9WhWcI6Br2/t1WDh4ynQ0ex6Nd2Cv9SPGA+7Uw7x3eBN0JEn9U4ePdeN6js4u6q/svGCyVX6DKBn9scTcIiY6ZjK7X+2GQihL/+bx5vRDzSTLpjPDL+BzCPvdvcRCIfwIS27CeQ6fXOmiEkUVBNxXRtxpYOTMFrKyZ8JdK0Ot58KRk+stQLxhyaoGZpMBdrGGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 09:05:10 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 09:05:10 +0000
Message-ID: <978883c1-ffaa-413f-87f9-1956108f0d60@intel.com>
Date: Tue, 19 Dec 2023 10:04:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/7] Add PFCP filter support
Content-Language: en-US
To: Alexander Potapenko <glider@google.com>, Yury Norov <yury.norov@gmail.com>
CC: Marcin Szycik <marcin.szycik@linux.intel.com>, Jakub Kicinski
	<kuba@kernel.org>, <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <wojciech.drewek@intel.com>,
	<idosch@nvidia.com>, <jesse.brandeburg@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<jiri@resnulli.us>
References: <20231207164911.14330-1-marcin.szycik@linux.intel.com>
 <b3e5ec09-d01b-0cea-69ea-c7406ea3f8b5@intel.com>
 <13f7d3b4-214c-4987-9adc-1c14ae686946@intel.com>
 <aeb76f91-ab1d-b951-f895-d618622b137b@intel.com>
 <539ae7a3-c769-4cf6-b82f-74e05b01f619@linux.intel.com>
 <67e287f5-b126-4049-9f3b-f05bf216c8b9@intel.com>
 <20231215084924.40b47a7e@kernel.org>
 <ff8cfb1e-8a03-4a82-a651-3424bf9787a6@linux.intel.com>
 <1eb475bb-d2ba-4cf3-a2ce-36263b61b5ff@intel.com>
 <ZYBr98sd+XzSfy9v@yury-ThinkPad>
 <CAG_fn=XOguL_++vJk2kFQoxu1msLzFBB5sJiD8Jxr4oUZ7qZ7g@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAG_fn=XOguL_++vJk2kFQoxu1msLzFBB5sJiD8Jxr4oUZ7qZ7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY8PR11MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d9c09c-6949-4f46-2932-08dc00719a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdvOzQOZck+2QBa7Re8yXQQzxKUb9cNWmiyEJzryT4hv+UZhJade85ci/n6i3d2pF9Av+6IAb/OLOaUeOJGF+jbmylj7XdNFSWJRNe6iExqT5GezzD9AUDf6ZWwTU35+I3lSKEneVbvtykW3tuHcKkUW+IZoj/+uK4Xx7YkFhwadQHwz5ppoO8YmjqblkPk5llKMcLsCL+QRemQ4vhiTugNikRfTm+xbVmHgNk6OkFwRiZUNmrSYEEk4Gd8FcgmyA/Xaod0C+bLfCrQBc61Bk9VQZVD7TQJgZb2dSw8Ox6wWWZCMyYapfYKSagWph2+wRYQbGNH+1mHbZ4D43XB0fXyIHlY17cfVkbG8JXBSqfEMNioSiXc5OXihWARziZWSpd1w4AtnhDAcsCANMoUmSNTjUf/KKUbADNbb9UNsrmnuZlhhRPmL5ZasqzGGZJUYs78jvwYdlOiYIY/7S4L6quAZu2frNmOg4qTB1b7glu/8HrZViIZVj5swiPNumYx6Y+kYgb2XPGXtBXdqO0+LdWWtgOaXyAGkqbSV6Ym3S/BBkJ0mqMdh5d6kAma5yqpNvOYw50thVUugTIcEu5nRf+eAZLZo+expOydckOLi/WzaykdSqK51AcVdfCifWi2ONK7C+BP4I0AF6x5kAWiHvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8676002)(5660300002)(2906002)(38100700002)(4326008)(8936002)(6506007)(7416002)(6512007)(6666004)(53546011)(316002)(83380400001)(66556008)(110136005)(66946007)(54906003)(66476007)(478600001)(82960400001)(41300700001)(6486002)(966005)(31686004)(26005)(2616005)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFE1SGMrajloT2JWcFBvKzduM2pEYkt6SXRacWducFdOZWFSbGpyNjJTc1pO?=
 =?utf-8?B?eVBxKytKeWx4eHNBS2thS1NvOUNaY001L2R1bFpYdUg4R3BBR25rRWx2TExQ?=
 =?utf-8?B?VXVEckZ3MW1iS0ZUbFNIYVF0cUxZaHJIS3dzcWY1YWNmcUtFSWUrdnhObENq?=
 =?utf-8?B?aUtyL2tzZUR5Mjh5Ulo3SkhmYVU5QWNnbkFSeWtxVitoZEtxK0lROGJjSWwr?=
 =?utf-8?B?RFhGZFFUZ1NmTmwxK0RVQ0puckowWkh1N1VJRzlvMG9IcG5oNW54bm9mMU1k?=
 =?utf-8?B?bythNHBTWlEzdzhXa1R2dERXMmV5UGpHR29hSTJacmVVMlYzZlVkL3RpYTd3?=
 =?utf-8?B?LzB3eHgxS2xZUitwcDJVK29RMVRUNmxWRmRxWjVzRlJjdm9hc3JPbFg1enEv?=
 =?utf-8?B?aDNaYkFMdzVMQ2tHUTdmVTVkRTIwQnkzYmoveWVZNElQdnk4cm5XeWJwVWxa?=
 =?utf-8?B?MmM5VWRYUFFmNlpUSjdvVXRBQndNcFU1NTRNcXRMSTZKbkNxZ3ZDM2pTTUZm?=
 =?utf-8?B?RURIRlJ0RlZDVlpMMXRlamV2Vzl2aDg0TjUxcndBTEVLN0hZNE55Wmt5OFpl?=
 =?utf-8?B?MXVNLzVUVGJCOERncGkzSWVxS3h6dFJOZHpIdU1EbllpdEYxQWlQdDMwUkdK?=
 =?utf-8?B?SXB0VkIrS3hNU3JuMXVxMFNSeWFhNjhGS3lvb1pXUzliNFpnZ1NwaGFKT0ts?=
 =?utf-8?B?YUlOVXRGeVA2T3F5UVFheDlDNjd0TjVtOUx6bFl4K1MwQmxJMTE2UW53aDNY?=
 =?utf-8?B?b25qamZta1o0ODRUQVR3Zk1aT242L3BncVE2ZERVajBMVG9SMUdLQVVlNkdC?=
 =?utf-8?B?TVBhQS8wSmd3OHNHMzZydWJjc0VUdnBKL0crREVuZEM0dXZXRHloWDAvaC9y?=
 =?utf-8?B?WmlLSzZ1SGV4WU4vK05iUHlpUG9LdXRRekNFTGRvQzhWV2RONEhNekNVTnhS?=
 =?utf-8?B?bDQ3RHdCREZYRGdSVElOZ3RpdVY1eWNKQWdKRE83VWFYZXpIaWpDSWhOajM2?=
 =?utf-8?B?bnI4QnNnb1JCdmVMZjZwektoYm42a1FnYUZiVzZpVHExTXZmbjdoZFRBeDNk?=
 =?utf-8?B?a0F3MzdKcGJ6Y3JpZGpEZ0FhVTZHL1RCdWJ2dS81SmFUMHd5eFFCRkdYaHFZ?=
 =?utf-8?B?WjlYV1BBVzJaRnppV0l1dEdSeFQwdWp0ZXV5Q3doWW1QcXl1SG5iazg4Snlj?=
 =?utf-8?B?TjkyaVRMMmtIK2drQXpqeituM25EK1VqTUVheXBodUJuQ0FhYUlVY2h4OUph?=
 =?utf-8?B?aDJoVktkMGhZZkhWSlhCSUJmMG16cFFQdjVMS2lxbUZ1ZWNJVHlvNFhXcWR4?=
 =?utf-8?B?SEVOeGQ5aWQ4cW5ZUS9RTmkrNmEwLzVhY1hkK1VyMDhZV0tWUFoxZGV4aXRM?=
 =?utf-8?B?N3RmVnRQVzdwaUFCY0hPc0JiSGpSMnRKdy9IZUJsQkx4SkpkSktqU0NFUVV5?=
 =?utf-8?B?YVl2N0o0Y1JRbk12N01kZUM2TWI2MnRPSVNLZm52QUU2QTB0UHVkWGVVQS8y?=
 =?utf-8?B?Q3lBWlMvVmR6b2taeHQvZCtsLzliRTlGZmpIRTljWUpGc3p4TkM5VE5VenRz?=
 =?utf-8?B?ZmhnSWorRi9aYmJTLzA5QWNsenNabEtsK3NZRHVUK3lWU2t0MzlHTlhadTBt?=
 =?utf-8?B?emdHMzNVUG9La0Y5N3ZFdERmSFZQN1ZOSEE4dWFzVWJXenpUQmViUmdPSEdX?=
 =?utf-8?B?aERLblU0NG5kcFdtQWFVN012RWE5Y3pHVWZhS1dlKzlpNHViV2ZxV2hkUlk3?=
 =?utf-8?B?VE5uakE1MTZBTUoxd1VtWC9PbjY0Y1lVajV0K04zN0xxVVRoSU41U094MUhp?=
 =?utf-8?B?a3pIZG95NUthcW51MUJ4aW9obFdxVk94STNaNTZWRmFNbDQ3SzM0TEExZWFR?=
 =?utf-8?B?cE02eVhSQUc1cVBwM21vckpmc2tlMUVJRS9vM2l5Q1NQQXV5WXBGeG9JQ01Z?=
 =?utf-8?B?UnUxUHdmNWg2OFBHL2RKR3VUTGtzck9PNWNkZWZuYmRFY29FQjZEa2NGZkd5?=
 =?utf-8?B?RG9XUnZxTEcrVFg2YnJLUWlOWTNTREJCYmR3bTNiNU5uNG5oRmNCVlhCTCth?=
 =?utf-8?B?L3J4b1hHNXNlMVVlVUdOU0dldnRqbWRhVkdaK2UxaEtGTTgyOWdUNEJyZE51?=
 =?utf-8?B?dVVWMWVqYVgvbWdXSnk2VUwwZ0VxY0t5dnVORWs0R0N0WFpEQ2hmeSs1SzZa?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d9c09c-6949-4f46-2932-08dc00719a19
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 09:05:09.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEYlSeaUQd+/9ViNmTgMDqeVZGKRftBrjtSU9DLD/cqgeDc24po1WHxI7XtbIWv0xFpzL7cKC70s3lJJb+1bnjbL+Xy/i97P9FZnb71bLxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com

From: Alexander Potapenko <glider@google.com>
Date: Mon, 18 Dec 2023 17:16:09 +0100

> On Mon, Dec 18, 2023 at 4:57 PM Yury Norov <yury.norov@gmail.com> wrote:
>>
>> + Alexander Potapenko
>>
>> On Mon, Dec 18, 2023 at 01:47:01PM +0100, Alexander Lobakin wrote:

[...]

>>> Hey Yury,
>>>
>>> Given that PFCP will be resent in the next window...
>>>
>>> Your "boys" tree is in fact self-contained -- those are mostly
>>> optimizations and cleanups, and for the new API -- bitmap_{read,write}()
>>> -- it has internal users (after "bitmap: make bitmap_{get,set}_value8()
>>> use bitmap_{read,write}()"). IOW, I don't see a reason for not merging
>>> it into your main for-next tree (this week :p).
>>> What do you think?
>>
>> I think that there's already enough mess with this patch. Alexander
>> submitted new version of his MTE series together with the patch.
> 
> Yeah, sorry about that. Because the MTE part of the patches was still
> awaiting review, I thought it would be better to land the bitmap API
> separately, but as you pointed out there should be at least one user
> for it, which it wouldn't have in that case.
> 
> I don't have a strong preference about whether to submit the patches
> before or after the end of year - in fact I don't think they are
> urgent enough, and we'd better postpone them till January.
> 
> So unless Alexander has urgent fixes depending on my bitmap patches,
> I'd suggest waiting till they are taken via the arm64 tree.

No, nothing urgent. Sounds good, no need to rush at the end of the dev
cycle.

> 
>> https://lore.kernel.org/lkml/ZXtciaxTKFBiui%2FX@yury-ThinkPad/T/
>>
>> Now you're asking me to merge it separately. I don't want to undercut
>> arm64 folks.
>>
>> Can you guys decide what you want? If you want to move
>> bitmap_read/write() with my branch, I need to send it in -next for
>> testing ASAP. And for that, as I already said, I need at least one
>> active user in current kernel tree. (Yes, bitmap_get_value8() counts.)
>>
>> If you want to move it this way, please resend all the patches
>> together.

[...]

Thanks,
Olek

