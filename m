Return-Path: <netdev+bounces-40709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA97C85DF
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2869AB20985
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75123E540;
	Fri, 13 Oct 2023 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkjKQAVk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA915E95
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:35:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EE6BD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697200527; x=1728736527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8bjKx86cYOgqxMLmZ3ImaHohdOhbI+B4+VSn9ZXM09U=;
  b=MkjKQAVkrFerofXFCzT6wFMizsL5TDXGEowhZj4xiiFDd21/+svx/SB6
   y1OU9s3gdDL70WySiRaHcgzd4wUIaZqO+Hk6O12WJPJL4Z81XgFxXk3ba
   1YxzxlUZ95DVhOvHw+Q0yf53Sih/1nfKKX0a7vvMsol4SJlqSANRscCcE
   ujFcNcANUIclBgsPunCuCLfp6VjoXbFLJ27b0Z1udo0BnafVmWPgQicy9
   vzxyaAqe+lfufTUfuqSnktkY4tNArRPsNNcS8ViojxHXxEu9AWd8Jxb4H
   NuBk8aRkcUy7FPQDYXtJYK4yqCbzn7KXSiHwwz4fmcXpC06iX4mMAICrB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="451643626"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="451643626"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 05:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="825040308"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="825040308"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 05:35:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 05:35:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 05:35:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 05:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWHvl1I4jkEJq9cSWzz4AlMgO93Aahg7/W9Na8ClfxElBMb6+fK/JgcF7fcPnVJbPEQg/qDq06JJ6RFFlaYmv95B8v6UXKBmTAPhXnC/AT28u4DYMbMNPs+9fcxEXLMTrOYjnOsPcX1YAGnotIfDpbEfk3qoP1wKOPwgW4YJViyGJcBWGaceER3H85ULD6o/7q+ZJZbjFCRIxCo1SD5g5EYYmf/yKO5AHuhCejwzy+UuVFfbvkOFBXElteMrXtmTapf/uzgX1HxmkJC4kGeXp5Eyt8Ljmrc0YfwxuFMbti9u/ISgkwt7xWtpmctyl8H/dh93AHmaFm2tkShCBvkFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArPANswO6c3D/N25i2qXowSLIkPOF3gORAte3+NXzsU=;
 b=daqD5D4/nXOm2gkbQnurW8xEeuWCGdLxvIuT/sW/aWU6pMyk+Xj0Ou8Dq3kEgu63MHuR5qhRcwoDXCQ2rOflU/7BF3xz3L0lBs2NZGJH996WYSssP62IJb0oXCaRw8gZU2Caohz91YsiEDc/55yJq5Vyl9Zwxa9cD2EZxA6HYT5hRqsL5vmgeEtRdbnki5/K2gppHYEUf1P3NaPKX2xxcVrdgXxvtSBUclU4U9BSMRK/SOsDzrUnUmEQ7gbheGfu8+exsSkuOWy8r02guXZLhNEC5l7pudHGO6UdXYpAEpNhCAR8LJffb+VsN38Byd4hoPgt95Olfi355Bp+jNKMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 12:35:19 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 12:35:18 +0000
Message-ID: <b8f3eb2e-afaa-48c7-c830-300f888b1f1f@intel.com>
Date: Fri, 13 Oct 2023 14:35:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-next v5] i40e: add restore default speed when changed
 PHY doesn't support it
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
	<jedrzej.jagielski@intel.com>
CC: <netdev@vger.kernel.org>
References: <20231013115245.1517606-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231013115245.1517606-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH8PR11MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: db5ac40b-7c63-41ac-a700-08dbcbe8dbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGBQHYazTuXp+D6uWaJZDl1tStY6W13BVF1l9iuymEN04HJA9TM99X8BOAgbk5IcGZWJnhGOToNmVMJKJ7luZs5xDcbro34qjrAZgerqPLAWOgqfwEmBVS9Mz2Q1sD0frwFYArQUSQ+/sOtmuWsacKu1mh4uS7eZ1c+4kka3/cGMK0QglerD6U+a9sOdlTrRy72e4N3fxyEg4rBOehlCdEPvPPCP+EexHp9Ghfb6cRv4pbbNk760WG2B07UwVBWlD8Spvof+UgB1984pFpj5G3Vmxgm2XEG6d+Z3qU7oVtkTgkZo1pB8qsfm5ECdkWZkhq8htrrC/KPWCeB28sMbwn4wApQywUT9is8n6GZi1Y++s3L60bUF60QOcJcKguc4c6y7IC6Udx6OEYHltP58cI1R6m2TFOtMKPePC2M5SE+47HhNzSIlDbGow/fyVGr6C0q1jYeGnSqaVHvyMrLcwKU1ffFoUY3cE1BRJ7ERXZ/ynNf19frQe32OH337fU57KUbLm9hMDrfDqbki0dX6zf4p6RBM0H+kbYIMqfI9gRSN5Hfkp5pHqthDrafGQTn8MpWPqjHgC5+hPWLPat/e7/U+qfp+VqvFL/tQjNQaX0XILHoZYVkgKS3X99EbHsyEquYxAgaYM9KlZgMKhMcXTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66946007)(66556008)(66476007)(6636002)(316002)(26005)(2616005)(6512007)(41300700001)(6506007)(53546011)(5660300002)(36756003)(6666004)(4326008)(8676002)(8936002)(2906002)(83380400001)(31686004)(478600001)(6486002)(38100700002)(82960400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STIxeS9MU0NSeEE1d0lJSjhHaUhwd2paMW42UDVmcTRmaWhUUGFkdGVLVnhD?=
 =?utf-8?B?eUszUDkzU00ySElSeXhucW9uekpyOUxzYk4yMVRFL3VPRVh5WVo1UTJ5SkdD?=
 =?utf-8?B?Z3d1VVVPS1RLaG5JOWZiSHUrTFF6QklDWWhoYWhLVm9rbEJUK1NhbUJFdjBt?=
 =?utf-8?B?eTRhdENEOEhMbUJ0YUI1T0VwY3pXTzdMZExjejh1NnorSy9LankrT3I3Y1gz?=
 =?utf-8?B?cTFJKzg2b01GcGEwNWtHWW9WK0wrMDhKaFI2ZkQvRXRYcG5OdFcyY1NJYmVM?=
 =?utf-8?B?Q0QwekVVOUgyNWhKTzNFNmVIcHJmYk9pc05ObkpHN1dFN2FnNUdKeVNNZklG?=
 =?utf-8?B?M3FYTElldituN1JXQ0RQVURvSkJTRlMrSCtPWmJzYWV5Mm1KT25BV0I0Vk5Y?=
 =?utf-8?B?eXhjanp1azZrUDVDajhjRUIrd0ZxRjVJc0NhcUF3WVhzVk42dWRjVDZFRGNE?=
 =?utf-8?B?VzJvZ2MyMlk2bGRkakRJUUc0cGhONHFlOWZJZXNtS0E4NjVZT09IMmF4a2pO?=
 =?utf-8?B?Y1dnbWpKd2ZUK2xaTW1SbEF6UlcrY3B6YVhWSVdkOXdZYVNtaHM1dEhseUln?=
 =?utf-8?B?WXVmZzRabXFvcStuOEY5UFpSQkhqcWk0RWFTK2NJY3ppNThnUnozRERUVlJQ?=
 =?utf-8?B?KzZtVXkzaW9VNitIY2xTNE94czVLK2dxUUlraHlDNmRiWnlxRkNoR2JYNDcw?=
 =?utf-8?B?LzQ0eTUwRktYU1NvUTZPVWptYkNZdWJZbUVJa2c2M1NiUFFQcGpkcTZxZXl0?=
 =?utf-8?B?SzA2ZmhacDN3ZmZmOS9ER3dlWHozNkw3TVVBemtaaVRUQVllZ08wNDFIMUY3?=
 =?utf-8?B?VWNnWmhLV1N6VjlWTW1YVyt6MEZjK2xFR01ZZVZLRy9taUZYVG5VeXdqbktW?=
 =?utf-8?B?NG5VaTNUQjZUbi9hK3JPOHpHelAwM3Fib1RCakttc3Ixd253SDlYb2h0REVJ?=
 =?utf-8?B?aG9WREdUT1pDbTJXOFFobEF0VVM4Z1FCWmdlclUyc1JQOGcxOFdvM29FZFNu?=
 =?utf-8?B?cWdEQkd0andqSXFGbktmNDJ3ekhXeEtudlRBK1N6TjRQRW0zWDFCNmszbk1O?=
 =?utf-8?B?anVGUHpwcnFLT0JkWllQWXdDWmhPVGFUOWNIWWJUZkFrZ28xMWxiMHlCSTVp?=
 =?utf-8?B?U1d1REdqY285Mnd4eGNDNjdtOVBMNjhaSVZvdlR5M0VyUTRabjhjSnh6SWpZ?=
 =?utf-8?B?Q0hYaEFxVy9TU3dQT0xoQlJka2UvRlBwSFpjNW5aTVJLNmo3Mm5oc1l0anRF?=
 =?utf-8?B?d2VLV2dVU01BWWR2TlpudU1mR3JJOGQ2V0gyQXFMa1hobWY1YkpqN05yYnlJ?=
 =?utf-8?B?bWswZXRtNVFXSkEyWFQwYnpBT2hKM0xjODZQVXk4Z3lqaWk5czkrR1dGdlZB?=
 =?utf-8?B?dU1YVW05akc5aUtKV0dOaWs0Mk8rZHRKNnNVN0hXQXpwTVhTZTFNeWpwMXlq?=
 =?utf-8?B?SzFjZzVvUlh6R1RGS0NLMlYrWG1LRStuTnVJQ2lpOXkyYkJvNzBaTlhzVUpk?=
 =?utf-8?B?UGtRV3dvek16Mi8rRDNSS0dsd1hYb0tFZmZMMGs3aHVmUjBhQ3VBYmtZbFR0?=
 =?utf-8?B?anhuQkdRVVl1NU9EVlpZeGU0R3QzWE5ZV3RjOXl4N200MjZTMFlCQkNNZktT?=
 =?utf-8?B?MERqZnJ4UmJYUTN1aXpXSmluYWFIMDJvRHcycmFIdWkya3lCYitvZFZCcXlx?=
 =?utf-8?B?N0dpZUdwVFJyYTgxRkd1Y2YyUjVUNEZ3dlorTXFDbXJPenZBb2RCSFpURzVH?=
 =?utf-8?B?c2ZPbUFZL2tnTk9jVE1PUUZGT1E1dHdmN3hBK2VxRUtiaytlYkh1Z3E4SWt3?=
 =?utf-8?B?cE5xc1hVbWdwQUxNL3FFUExzWWFyZC9HRG1uek1rL2VhKzVBNk5KWUVBT3Qr?=
 =?utf-8?B?YVZZTm9OMmk3cnlNd0txa3RQV0pKRzdTUEpBL1VCbFZUQ2JyZHNYeDNMR3Mz?=
 =?utf-8?B?ZGRPQ0d4aUJBbVlzY1BZdzZVQlVCRzh1NmlXQnZhcldNWmx6cGlWSkpHMUl6?=
 =?utf-8?B?cGRMY1YvS0RWaEFrWTcxcmgzVkRTT1UzNkF2WEhBRndid3ovQ2dsM3phVzh5?=
 =?utf-8?B?UWpsMHAzTjRDNm9WNUtiUyt2TVAraVJSSVZqRVhmb3VRbkdOV2pRYkkrUUQ4?=
 =?utf-8?B?NnJ0ZlMxY3Y2azNNOFRTdkt5SmgreHVDc0xweGFuRTQrWlNkTENIem9ka2Rr?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db5ac40b-7c63-41ac-a700-08dbcbe8dbc1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 12:35:18.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13B+4E2cqMQdVpGZoIdurxhpAGM2Q5QCdbA7tHrNiieZ1xmd4Oq9aD+kaqIDTih3o4xgQsj90u8cLxzP+elHlq1i9HdyXJPziFYoha+5pAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 13:52, Aleksandr Loktionov wrote:
> Currently, there was no link after plugging a different type of PHY
> module if user forced previous PHY specific link type/speed before.
> 
> Add reset link speed settings to the default values for PHY module,
> if different PHY module is inserted and currently defined user-specified
> speed is not compatible with this module.
> 
> Co-developed-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1->v2 fixed Reviewed-by tags
> v2->v3 fixed commit messages and tags
> v3->v4 fixed commit message typo
> v4->v5 cc to netdev@vger.kernel.org

good move!,
now you have to focus on the rules more, like those:
do not post next version before 24h of prev one;

more metadata:
I would remove the word 'add' from the Subject line;
You still need to change author to Radoslaw.

> ---
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 65 +++++++++++++++++++--
>   1 file changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index d0d0218..6829720 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -10076,6 +10076,55 @@ static void i40e_reset_subtask(struct i40e_pf *pf)
>   	rtnl_unlock();
>   }
>   
> +/**
> + * i40e_restore_supported_phy_link_speed - Restore default PHY speed
> + * @pf: board private structure
> + *
> + * Set PHY module speeds according to values got from
> + * initial link speed abilites.
> + **/
> +static int i40e_restore_supported_phy_link_speed(struct i40e_pf *pf)
> +{
> +	struct i40e_aq_get_phy_abilities_resp abilities;
> +	struct i40e_aq_set_phy_config config = {0};

just `= {};`

> +	struct i40e_hw *hw = &pf->hw;
> +	int err;
> +
> +	err = i40e_aq_get_phy_capabilities(hw, false, false, &abilities, NULL);
> +	if (err) {
> +		dev_dbg(&pf->pdev->dev, "failed to get phy cap., ret =  %i last_status =  %s\n",
> +			err, i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
> +		return err;
> +	}
> +	config.eee_capability = abilities.eee_capability;
> +	config.phy_type_ext = abilities.phy_type_ext;
> +	config.low_power_ctrl = abilities.d3_lpan;
> +	config.abilities = abilities.abilities;
> +	config.abilities |= I40E_AQ_PHY_ENABLE_AN;
> +	config.phy_type = abilities.phy_type;
> +	config.eeer = abilities.eeer_val;
> +	config.fec_config = abilities.fec_cfg_curr_mod_ext_info &
> +			    I40E_AQ_PHY_FEC_CONFIG_MASK;
> +	err = i40e_aq_get_phy_capabilities(hw, false, true, &abilities, NULL);
> +	if (err) {
> +		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %i last_status =  %s\n",

s/  / /g

(in English: replace double spaces by single ones)

> +			err, i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
> +		return err;
> +	}
> +	config.link_speed = abilities.link_speed;
> +
> +	err = i40e_aq_set_phy_config(hw, &config, NULL);
> +	if (err)
> +		return err;
> +	err = i40e_aq_set_link_restart_an(hw, true, NULL);
> +	if (err)
> +		return err;
> +
> +	pf->hw.phy.link_info.requested_speeds = config.link_speed;
> +
> +	return err;
> +}
> +
>   /**
>    * i40e_handle_link_event - Handle link event
>    * @pf: board private structure
> @@ -10086,6 +10135,7 @@ static void i40e_handle_link_event(struct i40e_pf *pf,
>   {
>   	struct i40e_aqc_get_link_status *status =
>   		(struct i40e_aqc_get_link_status *)&e->desc.params.raw;
> +	int err;
>   
>   	/* Do a new status request to re-enable LSE reporting
>   	 * and load new status information into the hw struct
> @@ -10109,10 +10159,17 @@ static void i40e_handle_link_event(struct i40e_pf *pf,
>   		    (!(status->an_info & I40E_AQ_QUALIFIED_MODULE)) &&
>   		    (!(status->link_info & I40E_AQ_LINK_UP)) &&
>   		    (!(pf->flags & I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED))) {
> -			dev_err(&pf->pdev->dev,
> -				"Rx/Tx is disabled on this device because an unsupported SFP module type was detected.\n");
> -			dev_err(&pf->pdev->dev,
> -				"Refer to the Intel(R) Ethernet Adapters and Devices User Guide for a list of supported modules.\n");
> +			err = i40e_restore_supported_phy_link_speed(pf);
> +			if (err) {
> +				dev_err(&pf->pdev->dev,
> +					"Rx/Tx is disabled on this device because an unsupported SFP module type was detected.\n");
> +				dev_err(&pf->pdev->dev,
> +					"Refer to the Intel(R) Ethernet Adapters and Devices User Guide for a list of supported modules.\n");
> +
> +				return;
> +			}
> +
> +			dev_info(&pf->pdev->dev, "The selected speed is incompatible with the connected media type. Resetting to the default speed setting for the media type.");
>   		}
>   	}
>   }


