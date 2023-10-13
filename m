Return-Path: <netdev+bounces-40568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E767C7AF0
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665B4282C6A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0F36E;
	Fri, 13 Oct 2023 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fm1xoLwJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6FA29
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:40:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A960D7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 17:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697157634; x=1728693634;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y47Q4nAlhDjF4EgjV04oJ1T0qwHyTjReY1/B/FBZcu4=;
  b=fm1xoLwJKGDVigk9+BBYUbL+ah7duQoipO97FrkT95U7Dd8VOT47ny9r
   gyVTTuQOzQUTUQzshxAoai/aZfhOS6vlzRtSxbJkIzB++lsxfcEhHaVVV
   6tzf//yW3rcX7eYkJioYMQ/wPkQR6VJNpcP429YLF1PnLheK484B6XGJR
   x9kQW+kmH8w0F9mPwX3ofn7fEZYsOvdUVfNTDRBxOeozBGxZBYck/CDYz
   OennfE13PglFKK9pS8qdKVKVAlAovayofhs+rxljA7fe+kMdtFjmmtelu
   0lW5k+3QJyv+mFDZeTbbUjBCrw8IKa2bSZSSMIuvPI5Ly4mmXbxtHyl3a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388938414"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388938414"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 17:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="789649614"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="789649614"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 17:40:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 17:40:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 17:40:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 17:40:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 17:40:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfPD1ZKAxU+oETI32QgKMUhQTF/GmYOEn5DOl2WobLGQIO4QFU32kCiNJ78HjlAON9yC8Rmo4CVOfVdlj7nZWxfRQQQx0hYRYIhYo0o3aUowDR7bEE1YmnXkumhiPHeYwDGF7OmZVhY5EZBIVfzoi1Ni1fcwJ+sgCyNlmLaokiCOsm6RjnoVqqZ3XhbYkVp4z7Jd9rRyOkfdPJyb2r7nZgmOXNdc9MvQMd6aDxlHAv4oaZD5tg5eZCFgrDAkA1uBFsjJfHsSQozwQqLtwVWfpclYJSKKZZnECBAUzuAW5JQ8bN6Npt3dTPUW/U1zoja2Db9fxb/tiBAp1dy+UH/9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxRpRsuBtwPPEIUHiFo1F4Br/HYsDSlPQre13mrm6eI=;
 b=TRr0fUdKb5chcWiS/5bS7DvR7aetGIndrM6rqe1XFqB3otU94EOMaO++SxGPD0/0oNyvpCfNIGgBxNRm2TGAm5ti2ApFuGjDiiBjZO9v7bgChR3Z+dSRzdCWAsKtaRhg+2YA1JyOuNAKJ6fKysrU0BsVBP0SFxWRIHDVJpJUbzL3l2rbmJ05ufnIo+4Kgi6Ufqpq5ORkaNzF/fBG8TU4oXXo3qEP3l0dHrZzmuajHgObJaiZH++FrOfOaCxvGfiebvwKNhmqWlmxTzXSEng+G7dDsDfcpWeRogERaMYFHPtVrK8nby224/OU1KiD3h/ko75F+2r9cxKDqNFIYQ9POA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 00:40:29 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 00:40:28 +0000
Message-ID: <ed960f30-4013-42b3-bb1d-3761e46106d4@intel.com>
Date: Thu, 12 Oct 2023 17:40:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 04/10] netdev-genl: Add netlink framework
 functions for queue
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
 <169658369951.3683.3529038539593903265.stgit@anambiarhost.jf.intel.com>
 <20231010192555.3126ca42@kernel.org>
 <fe26f9b6-ff3d-441d-887d-9f65d44f06d0@intel.com>
 <20231012164853.7882fa86@kernel.org>
 <8c9704c0-532e-4d35-a073-bee771cd78c5@intel.com>
 <20231012173636.68e6eeee@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231012173636.68e6eeee@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0307.namprd04.prod.outlook.com
 (2603:10b6:303:82::12) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|PH7PR11MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: f23e7018-e092-4204-22da-08dbcb84ff40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPCvS+L0pBwB+YR/MhzW0QuVLApE5yWMXdo1OqoL9vXgfmNz8rZLL+WbxELWUIA3GtZ13mTIKuFVNHIsgSgo0XV8B2mWCfUBF88p1+mnBc9MAw2UCosXuSECmtPKdzUMQSB372I98qFakhNvmEaCt4we2j20UzQFRVLCtBfwjk4fiCOgDbtrNDtQW/UQTwixrNAeTLRSzrYpdWxi62k9YvxOQp5uUhn6Zh358OYtHOPrZbkFFZ81oN6h+tXnBnxQTztA5QgHmfqKrSQomtNNFThiRe6kCxKA+B6kPCIYFJGWj6OXWzKmfWxB/vRvBxVZGBRRiN4MBxEqhsq41SlMiTUunyUauCCSQrY5eNOfd84CVGKkOpGF5EtvkT1KmQWUoBU4vh/XXvFysQ7AYfXqp5Xi42CLAjQSAu3WzBBiWq1rn7xaT3PqgqrB6AOT5h0HiQf906nuFdM4DmS2fGL5kYcdFRkebk7IA+HofX6MVTEVJPmMGwrUuxlGX8bE41dBsRbXX84PvKqkmLczX7io2gwA4H5TLv0Pe1erHFfmaqdmMw7mQN081Ho3XhHu9VF5WSdp06dv6ULhtR7qWydVMkJ2N7PchnXzVWu9sCXBM4xiFAgU1lSSet4gfppnY2VsextbKpmrHNAoOJGRSJRlug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(6486002)(4744005)(4326008)(36756003)(478600001)(86362001)(31696002)(6506007)(53546011)(38100700002)(66946007)(82960400001)(8676002)(5660300002)(316002)(66476007)(66556008)(41300700001)(6916009)(8936002)(6666004)(2906002)(26005)(31686004)(2616005)(107886003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0MvVVZDekxPb3FhTnV1MlpxZk01QUNEeTZtWWxNSVFiemdjdDJsSVRKSnpx?=
 =?utf-8?B?bEYzaHdoemRWdTZJUlRIaTBBaHYzenFMMGZWQ2JGRHU1dHo4aVlrRnNpTkNy?=
 =?utf-8?B?SmZ2TUN0bGRzeEhrSnhvL0FRWmU5eTdZYm43dTYyc1A2ZStTSkRPZkMvMTRG?=
 =?utf-8?B?NXVyeW5aM2JWYVdZMDJIbU9JZWc4d2lTUlk1UlhOaVhYdlpLdkRyUmlXVWJV?=
 =?utf-8?B?RFlNeGxxa0hvZnBzeXNVSTVLR01BdGVFKzNzOG9RcGhIdmFGMC91aUsrc29S?=
 =?utf-8?B?R3gzaVdhVUkwMVVvUnEzRGMrdVA2UTkzV3dnKzdXcHRidGV6azhCZDJpdjA2?=
 =?utf-8?B?NFpTYU1oOWdXZHhqUXcrM1VscGZKK2NtOStDY2hlS2tjODhGMTI0UVZuSi82?=
 =?utf-8?B?RnZ1OWJ1dE5vVUtNVUpTUDlvL3FyNWRadUFyTGdZQjNxRy95clRCUVQ0aTdC?=
 =?utf-8?B?akpWbksvZmlUK29zUE1Jei9oZTgzeDUwdllXYjRHWm5FYkNJVTNXN3phWndR?=
 =?utf-8?B?L2NvaGxqYzkzbGlzNm5KU3llWUNoNzZHQkFhaFdIZTJnU0RUd0NMOUhkSklx?=
 =?utf-8?B?SXdtazB0SlNZb3JZRzltbjVsMThQT2UzQmtNNGdEV0toMWlpRDdwWmRGVDJH?=
 =?utf-8?B?VlNuMldmYjQ1S1gybFlYVFMwRHBFL1JmQW1vOXhEalEwQjJ6UU9KL2p5NTBa?=
 =?utf-8?B?cThIN3NHRHRmWUQ5QndaSVhqT0htdFFpZ1Z1ekVsdS9VUkV3VUZQT0U3V3hT?=
 =?utf-8?B?cVFSNFJhNjVISmJWZlA3MEg4TGdmeDl0SEdrL3JLRVRYR1VEQ2lUZnlFUFEy?=
 =?utf-8?B?TTRVKzZsSFVBYk5ySVdlYjN0QXo2elNIc0Ezc0ptSUdMQmladDBtM3dxeGtl?=
 =?utf-8?B?ZXpTVGxnZHNEbjlCanY4MDJuQktZdTA3Z2g3dHgzVStEQWQxTUg4ZGkyVWpo?=
 =?utf-8?B?VzV3UHNRMTR4azhNTVBuYjJFSkU3Tm5GUGxwdzNzdUZyZXNsS1A2YXpRT2cx?=
 =?utf-8?B?clUvRTd3TmFkak43aVZscHUxNW5LS29zbWVjRHZUaWhEalQva0dqWWY5ZWFw?=
 =?utf-8?B?TGI0ZUpHVFRnT3JWVVFwQnl5OGZULzlwSnp2WGlsd09KQUdSNVJpVFQyTnBJ?=
 =?utf-8?B?M1BESkdrWlJsdnZKTVRaOWtRa0NyVU9zZXpvYTIrS3R0OXFFQTR4L2lzUkV2?=
 =?utf-8?B?Y1JpTEhaOW81R0R6TWpkR01LUnZTd0pndDJ0SjA2QVgzTTBiMHloOE1JWXVs?=
 =?utf-8?B?K2pBVnVxS3ZDQm52V2NFWm9mWmlva2xOS3pjOHgzallEcER1dnUxOHBhTEl0?=
 =?utf-8?B?bXpWQVFRMTRzWHprcnJOUHhueWVFanVoT3hjeENtV2F5N2hsOGlYRkVhZVFF?=
 =?utf-8?B?cmtHZ29JVjRvLzR0UnBqaEl0Qmh5a1pSWXE3YVErRlNOeDZwSHl3U25JVU5K?=
 =?utf-8?B?YjZ6NU0rNEV0LzNLMktBS1gzZkVQWnpjdHZ1UWRkTDdrbGZmY0pTb29TMVVI?=
 =?utf-8?B?ZGNibzZxWUxRQUxzQTVZOHJwY0N0QkFRNzNuQmJDbVRaMittUU4xSmZHc0th?=
 =?utf-8?B?NHJUc2E2K3dYTlRyanBIcXNJS3kvK2FPMzQ2Smo0TmVaUlBxczNXdnRockR5?=
 =?utf-8?B?anBXeEl0dFdmQ2V0aFNyZEoyRTFpU0xNU1BZN05JcG0xYUZTV1IwNEtYM1RM?=
 =?utf-8?B?NktrQU5yTEhDQUxGZ0FrWFhNVzBqVENBaER6TWp3MG1VNWZweGtUbmlTT1Zs?=
 =?utf-8?B?dTRHUkpjU3lQM3ZkV29LVloxL0J5YmJtY0lhRnhZWmxhNUJVaXJtZ3ROeGRs?=
 =?utf-8?B?eUUyT25kMmVPam1ZaUF1eVhZZm54VitNVjJBWmtpM1hGL2FMWTQ0OTJSQW1F?=
 =?utf-8?B?MlhDK3hRVkhIaUYzSUZmYjNydmh5bTdBYXRJTUh0bFg4aVJxQlBBL3V5dWEr?=
 =?utf-8?B?V2JJYXNLUXdUNGFOZUNFNWwvREJIeXFzQ21kNlZxRnVHWEdqOEVJbFEvdjhY?=
 =?utf-8?B?S3JKNTN0RHQ1S003UnFoU3ZlV1c5d2xkRXNCN3R6Y1F4ZGVWekNFYUg5TUxF?=
 =?utf-8?B?dklFaTNxMkxGU3YxUEZMU3A0YkpPbGxBYVZYOWlsSWk0NlV3TGRlWTdDZU8z?=
 =?utf-8?B?c3RnMkRBVC85R1RIQWxmb1pGQ1hhbEF5QnhKeEFOZEU3SzB3aUw3ZGIzRlR3?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f23e7018-e092-4204-22da-08dbcb84ff40
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 00:40:28.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9apQjeA1Mf3R/K0gtY+CDCjo+Ej9dAzZbmHdD40+SEnqwfvnxuVuiEQSFZChcsj6UDVu1B1KVxJ6s1oRTzAQLvQkgoV33n4f4yNtNsDufE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/12/2023 5:36 PM, Jakub Kicinski wrote:
> On Thu, 12 Oct 2023 17:24:41 -0700 Nambiar, Amritha wrote:
>> I was thinking your review comment was for the entire
>> 'netdev_nl_queue_validate' function (i.e. if the max queue-id validation
>> can be handled in the policy as a range with max value for queue-id, and
>> since max queue-id was not a constant, but varies within the kernel, ex:
>> netdev->real_num_rx_queues, I was unsure of it...). So, another option I
>> could come up with for the validation was a 'pre_doit' hook instead of
>> netdev_nl_queue_validate().
> 
> real_num can change if we're not holding rtnl_lock, and we can't hold
> the lock in pre :(
> 
I see.

>> If your comment referred to the enum queue-type range alone, I see,
>> since the policy handles the max check for queue-type, I can remove the
>> default case returning EOPNOTSUPP. Correct me if I'm wrong.
> 
> Yup! I only meant the type, you can trust netlink to validate the type.

Got it. Thanks!

