Return-Path: <netdev+bounces-51030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B647F8BDD
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 15:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E932813AD
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404A24218;
	Sat, 25 Nov 2023 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k8ezOr6C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C1F2
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 06:53:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGM6q4HSBHj0nvNue97EStF0fZ2oL3sdGlwZfJyHtFEiHGcF83oeqpjChwH4wDuSIS8dRnl+HH/aktpwUl1r55fHCxINK92A78vEOEIKUiCdrAG8ZwXv/k6ffz4CCfxEMHB7m8yicghkBgT77qfXyyQFX+IV3UG1U0Hu492WhNa+m8kqHB0eQllofkgXsQ9rTAHA1gS7nQzivGCOrM5rXdkEVFy8wqSOZbnH8pNDJZinGeHCaNhpbQTjAWDH36IkmAlQQsLpK0FWElx6j5DDaPWGoN3eFS8pIr11wK+RUNXWVz5LiIYIWCh8yfA/OIEU1wqsRDV6ZL8Ir94HJ3D+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4jdh6VV/ZzGxGoPbjIhsz4GQOwx7NO1PdJR42tQg3Q=;
 b=aLHpAWrdJOuQdWFSO7GA18EWyUa3mS8ln4AY0kRM1WhNJbKhqFSJr62vo+vkX1ZwwIdzWtynJzHadce3KcY/Gyw8g6W1m9CFOh7S+0ZrlLqBC94i5ks6qT6wiCasFS5lqBNChno/U2NfFw/tJ//xIJws8v//mDqITPu75UxrCgW64V9JgkWxCWvLs1wan0jPzbXpgN3slIrHEEKYaYfdj055pDwBZTAO/3Zg4JScis6/wZYim4xa4KYXtV3mFQXGeDQ+ev9FugCtu5WKBLJC1pu5XJWRxBLfpKW4ssBsx7fm2tu9Sqt9vZvx6lcahP+Wdo4csiv3EvPbtdsAhBdEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4jdh6VV/ZzGxGoPbjIhsz4GQOwx7NO1PdJR42tQg3Q=;
 b=k8ezOr6Cir9KKDTG4FAyXHU2p/pc/iMpSAGdHwS5rcUj9JfvSjOTvujA6hpbeM4hei2k9b1dfj8KKOhPAP+zUHYEEB6O+bBJbJkzo2gJ7hihP969ljrBxNCHM3v0yyDZasi50zhfb+Sy0KXFzvQklgsDCQgR3HWG8m4fwU3qDVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sat, 25 Nov
 2023 14:53:22 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 14:53:22 +0000
Message-ID: <89435045-2413-4cb9-4897-a251f5bd382e@amd.com>
Date: Sat, 25 Nov 2023 08:53:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net 2/3] amd-xgbe: handle the corner-case during tx
 completion
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
 <20231121191435.4049995-3-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20231121191435.4049995-3-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::29) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cd60a7-cc7f-4560-7383-08dbedc64512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R/02/fQksxLcJA8S86nnay2AoRbgIwh5GmMciTXa4xSBy2sb2gKGdSqyUNRKCC6XOTEroneEHkzDOd4LJBkMAQmYb2G2ZudJy36z8RaUeiqkCd856GKStNlk/MgpCXTH7CTuHe8cnqtkmBsiwjKNXnUt62rqQDJswxqR321upbBfjTnaS+su9K7AOxrRvPOaGJh0aj3aaZeiefOOZOZ65p5CEycVAKeUcs6GcMya0Ru9CtMpln6lmaEmWDBWwQhIRHJUgK52JFv9GQfZFH2msZKx53JthaRkp7ba5YNfUEIXc3I7gyZyjvF24sxu8bRla2bJpXi5OtKx5J6+YQkpRal+N26xyYTNmVJCNyEg/X0+zJZUo4hezKa9Pg1MtIgWqzM03hXgsPQ80frm8LICWrEFeQFRVYtdKciU0xxsrP6JWoZ9MuZsSy2qtPssb0NLzXU9mnuVi2Rz6EFxZdNQWCXEyPWVlweHMfnQNS7wWI3fDLcDhJ+//nbXtgDzVqBSGzf1j3Vs4Flf89ap3I+yVslCVcbWyaSfj7vnZ0wZ24BKxyMVB7R6BVb3TYOfog0vO5c8lgSyM7jmBVa2Li9Rl00H+oQmI8xp0/sSKWy2/WbepkMM1Um6H9UcHIPHCiAXYWNIXbAs9tK/LRNIXHhtkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(316002)(66476007)(66556008)(66946007)(478600001)(6486002)(6666004)(5660300002)(41300700001)(36756003)(2906002)(4326008)(8676002)(8936002)(86362001)(31696002)(83380400001)(38100700002)(2616005)(26005)(31686004)(6506007)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFpHTWRtdW8xc21QY0VtclJ5YTgwOXRHam1OYitiSkh3S3RQLzI2SFM3c0h3?=
 =?utf-8?B?YXdhSEllZEJVNTRiU1AwZFRoTisyUUFqZFFGTW1udnVCVmlHQkhpVFhhbXlT?=
 =?utf-8?B?M1RiL2JBSko2WXd3NTdJUm9PbnhOYWVOM0lCU1pVMk1jU0hNRTIyN1ZYS0E0?=
 =?utf-8?B?Z3JvQlRkQlBTK2ZTRHlWSDUwbjRNN2ZxaEJTOHVHOHJheFc1Nll6VVNWNXlB?=
 =?utf-8?B?ODJRTHVtM1BZS2M1WE9wbXFna3hlRTFuSVJlLy8vMjUxbC9nK3JmWUVJdElD?=
 =?utf-8?B?VnFsSnRrR1VyaGo4aGlqNVFMNFd1TnJLUFg2Q0loeHlpbENPUVZKVkRvNzBE?=
 =?utf-8?B?aXV3YVZ6WTIrL0g5dmp3WlFtbG5ndUtodytmUTJsbm1zOVZtdHRZVTRNNjJ2?=
 =?utf-8?B?R2dzNmZ3NTc2YkYza0R5bDdaVFljN25ub2xOamJaeWJoeVpMaHpiVzNDbURD?=
 =?utf-8?B?dlJPUHlHZEwzY3hHZzlUb2lRYkFDclpsOVEzaVdZYkIyZTl6a2gzN1FZVmdy?=
 =?utf-8?B?aGxoeUptODV5L3pHcnFSM0Z0MHBrQjFpV3dTaTRXRThXSHFiaWNRZHcwUm12?=
 =?utf-8?B?MmRGR1A4bThzM1h1TWIrbmJQMXA1THBTSTRVVkRLVzhFKzhGVWVLUjJDeWdX?=
 =?utf-8?B?Q0hXWk1zbHdaTFpVRVhwWFJvbUlZRXgzTW1UTFkxZjNuNU1Ddkthb3NRNGxw?=
 =?utf-8?B?QXBkSUJFbWdEYTEweFArRzV3ejFKc0VtVWZSTmpiS2NUVmx1TjBTeTlzMjZy?=
 =?utf-8?B?NnJyeUlsSkFoVG41M00zMzlVcXlnVUU5MW5PMmtPZFFDMktGOWc1MWNzNStI?=
 =?utf-8?B?WmNRVVFhaUNEbjhzSEZJYzRhVWd1d1lhM2ZqZ0RFUWRHYkVocURJZUhFKzdG?=
 =?utf-8?B?cXBTQ2J1UlpuTzhhRmJKekhqYjl6M2ltaTB0R3o5enY5KzFNK1l4SGVRQUJD?=
 =?utf-8?B?RnNHZ0xTTlpjZkx5ZW1OdHBHMG9JS3pFU3JVRlN5UG1vY3laLytuUFFRQkxu?=
 =?utf-8?B?eWhUWFc3R0NNQ1M3SFJQZmhRNU14WW5qWGlGL3hWR2hCQzg1ZE1VQXp0d3Nj?=
 =?utf-8?B?d3YvUFA1RUh6VDdxNlhYcVoxazc5N1Zmdm42bStDTlVHMkc3MkJZa1gzcHZJ?=
 =?utf-8?B?eUJxaEVXY0lKakF0MTRGR21ka2xVZVRhWC8xamwvdzZ6SGZEa1M1TGkyeTFS?=
 =?utf-8?B?cjlPdEhGbVBMenBrUFd4Q1NrbEVqNm02STN2aXZpM2JtNUxUYXRJN1VoTnNH?=
 =?utf-8?B?SzViSHFhcSsyT0RBMmxRUTNWVWtyNzM4WnZ4d0o3MkNvQ0JBQjJxeDZNNExS?=
 =?utf-8?B?ZFZybHlyL3NQd3FaREpKd0Q5bkoybFNNMW90TUdRSE1sTUZvRzMzM3crejJC?=
 =?utf-8?B?VGJXUUkzbCtMaEtGWHY4SENSMDNYa0hXWVd6elZZNlJnRHBzeDdkQjRrenRF?=
 =?utf-8?B?MWZveGpjMUtVclkxU2puaXRRK1FLWjVHTjJhWXZsemc4amtmMHdlTHIreFRS?=
 =?utf-8?B?RTRLSkNPQW5LT2ttcmJVMUJVNVcvaHp0RzFXS0R0ZEJqUmpFYTFPemhYek5Z?=
 =?utf-8?B?S0hCL1AzaWdkeklEaU9iSXpyZU1yWTJxTjN6UW9IazNZTWc4bmhsNE9kb0c3?=
 =?utf-8?B?eDh6ZlhCWHIrRjFBcG5rOTc3T2lyRGN0R2N1SktMUUxGaUErcEdoZXZ2dktu?=
 =?utf-8?B?dnZxaGo4MER0ZWExeGQyZE5wc2lZeWlvaVFWd2tHb1QrTnBBNFd5Umx6QUNZ?=
 =?utf-8?B?UVJwNDlJdFBKL3cwZDZjNWwxUmwwaHA5WG1uUHV4aWI2OFYrU3FVdkxJKysz?=
 =?utf-8?B?SUJhUW1WV3MzaEoyMFArakl0UW4zMmVISkY3bk1oTGxQdVFXZDZFRFpmNk5J?=
 =?utf-8?B?NXNKbTVDcHNtcWc2alFrbU9aaTRjTFFQMEpmTi8zNWpVT095NVRINmtDaU1B?=
 =?utf-8?B?NStvUjRoTFh5R0dPNGRjb01pdVdYanJvd092dW5iUHdoenZzL1MwbWZweWVq?=
 =?utf-8?B?M01tZHREK3hHK0c2aXRza1pYYThwdEpzbmFlQnNqK1ZaNElxKzNtWmFtTGho?=
 =?utf-8?B?UkZkQnE4YldQdFlWL3BvU3o1MU1VcnhoMjEvanEvK3orTnE3SE5LT01ITzFr?=
 =?utf-8?Q?xpIvr3Jd5XsFGsei01TPtMCVs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cd60a7-cc7f-4560-7383-08dbedc64512
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 14:53:22.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzcKWNVcrK2crB1YDa9d6ozhj/njRGraZWTXww8nIxEuNcIHbErI+mnwOysFnRLbE+rfOwZ5iLhMegvyAdWLAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

On 11/21/23 13:14, Raju Rangoju wrote:
> The existing implementation uses software logic to accumulate tx
> completions until the specified time (1ms) is met and then poll them.
> However, there exists a tiny gap which leads to a race between
> resetting and checking the tx_activate flag. Due to this the tx
> completions are not reported to upper layer and tx queue timeout
> kicks-in restarting the device.
> 
> To address this, introduce a tx cleanup mechanism as part of the
> periodic maintenance process.

This looks to just be a work-around that happens to work (for now) and the 
actual race condition should be fixed.

Thanks,
Tom

> 
> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index 614c0278419b..6b73648b3779 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -682,10 +682,24 @@ static void xgbe_service(struct work_struct *work)
>   static void xgbe_service_timer(struct timer_list *t)
>   {
>   	struct xgbe_prv_data *pdata = from_timer(pdata, t, service_timer);
> +	struct xgbe_channel *channel;
> +	unsigned int i;
>   
>   	queue_work(pdata->dev_workqueue, &pdata->service_work);
>   
>   	mod_timer(&pdata->service_timer, jiffies + HZ);
> +
> +	if (!pdata->tx_usecs)
> +		return;
> +
> +	for (i = 0; i < pdata->channel_count; i++) {
> +		channel = pdata->channel[i];
> +		if (!channel->tx_ring || channel->tx_timer_active)
> +			break;
> +		channel->tx_timer_active = 1;
> +		mod_timer(&channel->tx_timer,
> +			  jiffies + usecs_to_jiffies(pdata->tx_usecs));
> +	}
>   }
>   
>   static void xgbe_init_timers(struct xgbe_prv_data *pdata)

