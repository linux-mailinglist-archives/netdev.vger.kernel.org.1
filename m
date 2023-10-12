Return-Path: <netdev+bounces-40506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A97C78AD
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C517B203CD
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914003F4A7;
	Thu, 12 Oct 2023 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3zfn0pp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69483AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:37:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC6B7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697146653; x=1728682653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wEJKz5T7QojQLweU4Uki5A1W+1zyHz8dnFBA8OK1w+Q=;
  b=d3zfn0ppPlQBVHHrE1HGg0laH8RjySu462KXifYM9IfZ8nFmi6xigIFm
   pEqXjfrTTFj0NXVsNnVk+uJMZeyiPCuBZ2ROfVk/N6Tvt7JiusT9745K8
   iJpk3wacAXdvRhfUnjFA6II4qLVVTNV/Gxp1Gai0YD7KYBRpClyYS/E7g
   TsvrVKC3037ngsw+nl/KVOOuzMcTtaxBzAgbVa246KKt2ctUd0qGGvJYm
   lgwURavoCc/j6BKZffecv7zRU5ahikbELovC1yto8kujb9XSgGFaniJay
   CbZmYx5jHHzG+s4zQ2akYha2b5R04fb+9wpnMsRWNN9b8/XFT1nLMtlAo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="387896913"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="387896913"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="878250712"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="878250712"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:37:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:37:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:37:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:37:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpkWt5QjHagbp+mggqWLBKKYEkARS06zkxRPk1XDzBPEVXJJQHkKW1Ybz4mIi9P7JpdaDSrq8h3vfAssHT46OJEPnnapKnIMDFgwLrA2qvflk8PGEDCGqXRX1PQtqbPxgH+XUW3cKLQJa7Zh2sgGGR8sUQ+LTYSOGcr6L2Ay+8Jv4Ru2UX/Yk/97EJMVjjiW1epjDTwOsybp7YUOkmOkwtvLQWJPnjXmQOYiZEZ4NXPSVarP6GDg56h5VoVPsAA7kZcKvJHTC4rzQ7T74gZZoc6k0jMN5HIPd3poPnupxle/k6q234ciQdQdwdPUpjNf7m8DlplhMmsXMl5iCDob8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0o2BphLlWxc1segq4Q+GiVpzVH9HkW8rkcTC/OB2sU=;
 b=N4sJT7ilxNiE4FOo/n6br3mfrlYbRh0NwHtrwZnFir0SfpeODpla3LRACm6ZKY+BLtboM1tRcjkwfSOvrmDe9d7qMIkJqgmiiu2k77mt/QUnh8YvE1Cfj5N5ocQ6qiLGu8+6urfVGK5ybzSg0orQqgBQYOovarmhXtQC5XwAJzLLA8jH1/SO/mNDLN9SR2RZg0+XxmbpMKtzpKolwwLNDOPg/5EaLoQzSYfqODefH8GjUUWZXkCyLRiTB2A6Gqf23vAgdVF+TpJRUAE3ZyHJE1XbkghQMpjB3GYaq/Rpv67z8yO3YuDwAik6JwKxXZMr9wFcLMDF1MGlTmDmBbw0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 21:37:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:37:23 +0000
Message-ID: <cefa4909-fb7f-4c18-b5ac-0a17bc0b4c69@intel.com>
Date: Thu, 12 Oct 2023 14:37:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 15/15] net/mlx5e: Allow IPsec soft/hard limits in
 bytes
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-16-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-16-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:303:86::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: e9682731-a5a5-42ac-28a4-08dbcb6b6c0a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVkXpk9OVqBOEf+JWSeT8m9Q9JHoR8WiWaZG/fiXz9NScuJEKMdpUpbaBsg78GcNjHD1QjHqAnDNsBkQ+KfGUH6ocVqbGTIFS8ey16XhRizVbPJUZnfBoGLwnPATNNq8zXgUEeL7VqgFGWN2CW18RSvUVgWEhL2iz2pM9PQarLBR01FA4+ZAr+p95AyGJcuVRJBg0MwCrUZhic4vTBP0p0WA6lTd0HZz0ilD7zFyovuxHpBm1mzBEvaUH7UzJecIEm3ZeN4EWN+lxe3+AR8BhY0avOqzbj3abZd+LN0EyUxhjItUhThSn9OINzMd2CYfJDwZ3Cr3aJQ2JQyi0l8Pv8aUbotbP2su5rMsQh61fdp89zsXxKwN5fTXGzHxAiqYyJ+2U3MuGdn5loNQleJqIogbDTZRy9RjaFTX5/D58EKsFNgO7IbLsccWxWcjJdwoZRHdXUKrFJqvIntVRl2jJ9n1OBsaV8oa2pbhmLp6e/3HLzzxchOa+1CUe6/zQ+Y3G4ZbVkBehLUznckuZiG8T3qYp4Vv5DKZfKQHRY2faAJ+ewXTtw8D+2pj2sfGqr2rRfl87OHPRvlMv3uhHy9yVE7Zaor5lyKIvW/WUKjReGu+ns0RgDFi9QWBfrHo8Kk3LK3TH/3yjsfdJFiGuOZn0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(478600001)(6486002)(2616005)(53546011)(31696002)(83380400001)(6506007)(86362001)(66899024)(36756003)(41300700001)(4326008)(8936002)(8676002)(54906003)(316002)(66946007)(31686004)(66556008)(110136005)(66476007)(7416002)(2906002)(6512007)(5660300002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjdYU2tPR1pKRTBWcjFoWGRRbXEzc3dYSUVQMVhjUHY5T0tCazRZc3FBM1ZQ?=
 =?utf-8?B?NUE4eFNWSFd5SUdpM0J0Z0pVMVhoS3FXM2d4RklqdzRZSFZZRW5EdkVPUlRk?=
 =?utf-8?B?aDVaVWdtTTNqY0w2SnJRZ1dobjByNlYxZFNmMTI4aTB3YUIyZUNrNUhsOWxw?=
 =?utf-8?B?czlZZW0yY1ltRHFYNSt3ekh1MnZoaytSVFgrNVMrZTV0SERwRFk4eU8yemNL?=
 =?utf-8?B?VlZtayt6Sy8xM2pYOU13dzhiTzBHbGNDTUpXTkNqR0NUYjlCR1lwS29za2w2?=
 =?utf-8?B?Y0RVMnZ0cWUyb2p3V3pha1VsZ2FoNWJEMDB3Q2tqSjYvaENqZFV4NHh4ZGxG?=
 =?utf-8?B?MkUxU0VsUGNvS3dHU2JxRWZYS2tWQ0tQaDAyNno2eEU5RFdwaDhTb0huSnRP?=
 =?utf-8?B?ZzcrNHEyOEUyTnRad1ExeElFQzBKZnpWV0FXY2lxdytSQmxyL25Hd2xSS2ww?=
 =?utf-8?B?WXluNzg0ZHBxNjFkeDkyUlF4Y3gvNEJCYmc0WDBXc0lHQWdud1lNK0NPdWE2?=
 =?utf-8?B?RUxTTnJDTS9LTEJiNTFhb28rSFZIVldmTmdiNk9tS1IvbHN5OWtxVVRPRXR0?=
 =?utf-8?B?T2NDWmRmMTFzdzFkZDdraUxCbCtsYTdyd0NEc2NMQmUzS1dqSy90bEZQeDlD?=
 =?utf-8?B?Y25zOThwZGltTThIY2Nrc0FZMnc3MnhkaUUybkFnMnBEcER0QkxYVmVndFlq?=
 =?utf-8?B?ZUFKcXdRMzNRdm5vZ1J3NG5BS09xMjdLS29pRWY1YkFLK09leGxleVMxQWtv?=
 =?utf-8?B?Tit1RzQ5aDI5Y0MrQnhkOWhFWE1Vdit2SkZ0aVNKcVJXQTdNQVlBRkl2U05V?=
 =?utf-8?B?SjFjeFpFclhyOWJTTXdmUDdGd0JPZTliYWZGTzZxZGZMV3BINitiSko2dnFC?=
 =?utf-8?B?aGxObjZRSVhjbGZ6Y1ExTHk3SDBKUEFYcnRuR0ZpRjVhbHdQR2hMdThYQmZX?=
 =?utf-8?B?QnpUZVIxaFh3QkhZMUZyVG42bFo0UjA3SDlzdGtaTk16aVVpaGlDRWJ2Q2xx?=
 =?utf-8?B?VGxJdXA0eWFaN3VqOXRCTThPNC9vdVdSdjFMSU9lWVo4b1diZ2Zmb2Zoanc3?=
 =?utf-8?B?OUJDaDFCVzJ0cUpuc2pPUmVHdUxPMGZQK0Q1bW5OdFBuWUVSdzR0Vjk1dHhH?=
 =?utf-8?B?a1B1UTVwaVdGSzAxR2x1ak5ub2pDZ2dLc2d4MmQvWnlyZ2I2cWpIZFdSY0tw?=
 =?utf-8?B?WnNra3ROSDFsVXVVd1hsR2JkVkUxbUFOQ0JqYk5DUStkOGcxV1dFZk1nN3RD?=
 =?utf-8?B?bzlTT296eDErek9LZXhZWmtsUCtEcjV3L0t3eFBWd3JGYS83SFMyckk5ZDVN?=
 =?utf-8?B?bC9rVmE5eHlySDRSaGpIWExaNzZmaW95TDFaSTNzK0orTEFtSGFuc2lkTjd3?=
 =?utf-8?B?S09vOUxRUTRnQ2g0SDNZRTZBZTMrWFd1QW93WE1xclhvNGx3L0c5QlpSNFE1?=
 =?utf-8?B?R1RlNWRlVE1qWnVxYlBFTi9mR3phN2JFYVNwZ2NJVStJZTI3WGd4Sklhd2RR?=
 =?utf-8?B?L0p2WlRqeWdxM3hrR0I4N3ZXdEZ4RHZMZkVhdHBvTHJyeVpueTBiWE0wNG9V?=
 =?utf-8?B?MXlFTkJ2ZXlvenVzMEtBSis5MzZsUFoxWUFYd0lQVEV3c1JhQnU0L1RObnFo?=
 =?utf-8?B?WTJzbGtzdHdtaUJJSVRKTGNWWGhZdFhuQlIxWmVlRm91WkZvS3R3NEZ1cVR6?=
 =?utf-8?B?L2FVcXFvWGc2T0JzNHU3c1FhZWhHRGdlN0doUEVCemZhcDZkTG5CbmUrUDFh?=
 =?utf-8?B?em5nRXV4eDNGMzZxRnJBc1N6TFNVdEtJSmV5Ym5ldGdISUZGUWlMd0lCTTNU?=
 =?utf-8?B?aUt3bTV0ckRUNDEwVGZjVVRaNEs5Zm1UeEZKR1hhbXdwMEdEOGJPci9iZ1pz?=
 =?utf-8?B?YU1PZ3RXUlVKKzR3UUltSnJtclQvQVpsRlArMGIzY2d5U2dvYjkyWVdvclRG?=
 =?utf-8?B?VEZ0THhCVFdlQUsxK2FLMzRFVXpJRE5qQXovakd1UjZoMndCNUZqY28xVVZy?=
 =?utf-8?B?REtDb1VJRmcwOHkzanRJcEM0TFdwUUlRSElrODhmTGhRSURJcGRGMnV0UW9x?=
 =?utf-8?B?bkcrMUpUM20vSk8zNlhlbExOaFlyT3ZmRWRhTjEwREkyTmZaY3d0ZXJyUy9E?=
 =?utf-8?B?YkNMZTBuM2Q0WTM5cCtzdHRzMXdqSDMzN2dwenVyK3pLdkNIR0dxb1g5TmEx?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9682731-a5a5-42ac-28a4-08dbcb6b6c0a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:37:23.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ia+oCUjaZFo2HbRrogo8Hs8cvFveWN/VJ1U8Ed/5k75/8tNWgXE8rezL2zH8k78QGCcjUxcCd3UjiZflXHlaffBSsSVC+DbKrArpgiI+vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Actually the mlx5 code already has needed support to allow users
> to configure soft/hard limits in bytes. It is possible due to the
> situation with TX path, where CX7 devices are missing hardware
> implementation to send events to the software, see commit b2f7b01d36a9
> ("net/mlx5e: Simulate missing IPsec TX limits hardware functionality").
> 
> That software workaround is not limited to TX and works for bytes too.
> So relax the validation logic to not block soft/hard limits in bytes.
> 
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  .../mellanox/mlx5/core/en_accel/ipsec.c       | 23 +++++++++++-------
>  .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 24 +++++++++++--------
>  2 files changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index 7d4ceb9b9c16..257c41870f78 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> @@ -56,7 +56,7 @@ static struct mlx5e_ipsec_pol_entry *to_ipsec_pol_entry(struct xfrm_policy *x)
>  	return (struct mlx5e_ipsec_pol_entry *)x->xdo.offload_handle;
>  }
>  
> -static void mlx5e_ipsec_handle_tx_limit(struct work_struct *_work)
> +static void mlx5e_ipsec_handle_sw_limits(struct work_struct *_work)
>  {
>  	struct mlx5e_ipsec_dwork *dwork =
>  		container_of(_work, struct mlx5e_ipsec_dwork, dwork.work);
> @@ -486,9 +486,15 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
>  			return -EINVAL;
>  		}
>  
> -		if (x->lft.hard_byte_limit != XFRM_INF ||
> -		    x->lft.soft_byte_limit != XFRM_INF) {
> -			NL_SET_ERR_MSG_MOD(extack, "Device doesn't support limits in bytes");
> +		if (x->lft.soft_byte_limit >= x->lft.hard_byte_limit &&
> +		    x->lft.hard_byte_limit != XFRM_INF) {
> +			/* XFRM stack doesn't prevent such configuration :(. */
> +			NL_SET_ERR_MSG_MOD(extack, "Hard byte limit must be greater than soft one");
> +			return -EINVAL;
> +		}
> +

Seems like we should fix that? :D

> +		if (!x->lft.soft_byte_limit || !x->lft.hard_byte_limit) {
> +			NL_SET_ERR_MSG_MOD(extack, "Soft/hard byte limits can't be 0");
>  			return -EINVAL;
>  		}
>  
> @@ -624,11 +630,10 @@ static int mlx5e_ipsec_create_dwork(struct mlx5e_ipsec_sa_entry *sa_entry)
>  	if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
>  		return 0;
>  
> -	if (x->xso.dir != XFRM_DEV_OFFLOAD_OUT)
> -		return 0;
> -
>  	if (x->lft.soft_packet_limit == XFRM_INF &&
> -	    x->lft.hard_packet_limit == XFRM_INF)
> +	    x->lft.hard_packet_limit == XFRM_INF &&
> +	    x->lft.soft_byte_limit == XFRM_INF &&
> +	    x->lft.hard_byte_limit == XFRM_INF)
>  		return 0;
>  
>  	dwork = kzalloc(sizeof(*dwork), GFP_KERNEL);
> @@ -636,7 +641,7 @@ static int mlx5e_ipsec_create_dwork(struct mlx5e_ipsec_sa_entry *sa_entry)
>  		return -ENOMEM;
>  
>  	dwork->sa_entry = sa_entry;
> -	INIT_DELAYED_WORK(&dwork->dwork, mlx5e_ipsec_handle_tx_limit);
> +	INIT_DELAYED_WORK(&dwork->dwork, mlx5e_ipsec_handle_sw_limits);
>  	sa_entry->dwork = dwork;
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
> index 7dba4221993f..eda1cb528deb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
> @@ -1249,15 +1249,17 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
>  	setup_fte_no_frags(spec);
>  	setup_fte_upper_proto_match(spec, &attrs->upspec);
>  
> -	if (rx != ipsec->rx_esw)
> -		err = setup_modify_header(ipsec, attrs->type,
> -					  sa_entry->ipsec_obj_id | BIT(31),
> -					  XFRM_DEV_OFFLOAD_IN, &flow_act);
> -	else
> -		err = mlx5_esw_ipsec_rx_setup_modify_header(sa_entry, &flow_act);
> +	if (!attrs->drop) {
> +		if (rx != ipsec->rx_esw)
> +			err = setup_modify_header(ipsec, attrs->type,
> +						  sa_entry->ipsec_obj_id | BIT(31),
> +						  XFRM_DEV_OFFLOAD_IN, &flow_act);
> +		else
> +			err = mlx5_esw_ipsec_rx_setup_modify_header(sa_entry, &flow_act);
>  
> -	if (err)
> -		goto err_mod_header;
> +		if (err)
> +			goto err_mod_header;
> +	}
>  
>  	switch (attrs->type) {
>  	case XFRM_DEV_OFFLOAD_PACKET:
> @@ -1307,7 +1309,8 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
>  	if (flow_act.pkt_reformat)
>  		mlx5_packet_reformat_dealloc(mdev, flow_act.pkt_reformat);
>  err_pkt_reformat:
> -	mlx5_modify_header_dealloc(mdev, flow_act.modify_hdr);
> +	if (flow_act.modify_hdr)
> +		mlx5_modify_header_dealloc(mdev, flow_act.modify_hdr);
>  err_mod_header:
>  	kvfree(spec);
>  err_alloc:
> @@ -1805,7 +1808,8 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
>  		return;
>  	}
>  
> -	mlx5_modify_header_dealloc(mdev, ipsec_rule->modify_hdr);
> +	if (ipsec_rule->modify_hdr)
> +		mlx5_modify_header_dealloc(mdev, ipsec_rule->modify_hdr);
>  	mlx5_esw_ipsec_rx_id_mapping_remove(sa_entry);
>  	rx_ft_put(sa_entry->ipsec, sa_entry->attrs.family, sa_entry->attrs.type);
>  }

