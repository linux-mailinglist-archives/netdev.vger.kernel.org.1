Return-Path: <netdev+bounces-23385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC4876BC30
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BD12812F0
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C911235B9;
	Tue,  1 Aug 2023 18:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E9200AC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:20:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09DB2130
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abmoFKumSVBnyMDjeMZjn7dLuEorXe2yqzncxZy/HOS1+mv0HMySspvZX+XFXwyuuC+6wRhQLWL6s0ZA5jhdee9FWnX/dvnFoL7sX7nkDT30sAeGoX3e/o250jdsKESUHH2lzkLpwRtDJ3tPgyehpvlD8bd1B5VqiG2divITnFDcizW9ujnARnjSnsP0M2Uz8JchI2vaeFB1HrZAvgxh4FFxOj3BlzV2ShunkXHEKCvpOEx5vApS44IUlelhyua0VEuN66S/w6AbbJMi5uEm2NTQZaLadb8xMBXwJIujy4I0Qw7j+3FcbF0eUUBO3auNwYyFnboUVZQ47ZUT0P0sVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmQdLyr4KSjXXxItPjWDrDTapldXca49Zdy4j+qMHaE=;
 b=PVp0VBhincQnQqwP/5qHjyolTA84TbrzIg8wKV77bR0Wgv4al9L3NWhurmuvGjsq95/0Gt1GCVW/pz0sRJixUVnwvrQNj10jxf7fue5Q40GxToVm6IVtyp0MdeZnlWC0ExuNTDfXV3ttCqDbfUx0icee+P5ntCfMsCDpFNVAxhd6xLR/yqblkRMYBzUAbsk871Dfog46jHricJaZk1jDttOHbDTu1+Z2HEjlKj9iBCc000uFUB/y/7bOD0HbDma3Ev52GWZBgVWSiv/BXtuA4jv25BZgpOUHsvPo3ykgf0Ws5J9ECPkcOBS+Xaivak5j3Vj6QFDyn24rQ3yu6v24rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmQdLyr4KSjXXxItPjWDrDTapldXca49Zdy4j+qMHaE=;
 b=sOsdwgDqFjzH3nud81zIrc9j7ykC13ya23mZTOPscGQAHUCR93H2XY9gkeKrsLXgb3VndqLsnVBaDCfPO0LgugNRrX8jycX90iSUieobbA6KNlqOdDytUpKHThLcblejzJc4k4771NgAUUjC6Ia6u78YaTWhJDgcAwE6ML5IkXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 18:20:24 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::6872:1500:b609:f9cf]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::6872:1500:b609:f9cf%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:20:24 +0000
Message-ID: <30cb80f5-c771-f853-9d41-719fa378e4f5@amd.com>
Date: Tue, 1 Aug 2023 11:20:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net v2 1/2] igc: Expose tx-usecs coalesce setting to user
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>,
 Simon Horman <horms@kernel.org>
References: <20230801172742.3625719-1-anthony.l.nguyen@intel.com>
 <20230801172742.3625719-2-anthony.l.nguyen@intel.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20230801172742.3625719-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:510:325::19) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 9948f7a5-72a1-4604-5b6a-08db92bbf922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vbs9+Drc+nyxfeLG3dLZbNiuCVI1sxzG0grXzXuHwIou1yxeY2eRTR8iLc6K1GpA3lee3aE1dxsUESirbjiY+rMDME+352yXpaZMF0a+ZHAe8rDl+YmJfKjwRwpFOFFF7ZUIyayCBXA2Z5LfmmOWSUN19ghvyNiDsIM6pyI5er4kx4CayfJDw8TipLK/arRQZZE3TM92NETATMW2RBj5Th4FT06M51BdjIOHOe9N9lBGRX+/LdgHFBW2hf6qmArvfMkXWOlITdM1bfuqATYVGZrMNYpycUe1mt9ntZCZKSj8dLdCnzGt//0UdjWxHcrur/87XCAoby8hyrQZIphWvga82VkycjMqKM3JDCRkzE9T2R8uJjSMYbX87zRx4nbQVGEF2k7pBua//9zL2TFtOO28iq9P+XY2Dakc9xzXplOe49k+zXSZZCZGtpy6oTW0kyGW2XtFzhtXkLxBd3mdLFl100PuuBY2/jd1nORMpctyfutharDPldGl/HAHp4EInqo8e6/JiN5S05aKDZMpJaoDD30UWKoUf768UBYgS59ONCTT0pxgR4CXMs5JQS7fsttkgutE1h0uuVWuh3Ys4Z9SxDKLiS42pBdUhaZEbPeS4M+B9kQf1oR6q25kCNhjRxVb69YBuOiKrkEqFPDRQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(8676002)(8936002)(31696002)(38100700002)(26005)(41300700001)(2616005)(83380400001)(2906002)(36756003)(6506007)(53546011)(186003)(5660300002)(4326008)(66556008)(66476007)(66946007)(6512007)(7416002)(31686004)(54906003)(478600001)(6486002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW1qMW16STRuYU44S1EwYVFmaVBza0VwVktTNldZZDRMSzg4UGVHaE9HSW9M?=
 =?utf-8?B?bUJiTlVrT0VvNVJyc2xzaUxzZ2xpdVNzaVdaL29wdHdpaElkRWtiU2NrQnJy?=
 =?utf-8?B?VlNTeW4yekhLQmh5bGo4UU9tR2lIdWF6akZGL2ZDcXFxWkN5YmNLMUNJOE5l?=
 =?utf-8?B?UHB6bFJSSm96ZTBVYXN4U3Q4R2FCaGVQazlia2QybDBNc1NOZ2ZKYlhsSm54?=
 =?utf-8?B?T2dwek4xT3A5WXZhZ0IrYyttZXVjamdyU1gycGJBNCtjNmxkK2E1T3Zsd3FL?=
 =?utf-8?B?Q2dVNklPTGZKTEE3WmNNSVJpUm5Zc2NVZkhMR2pmaEhjZGttQWFvbmFEcVA3?=
 =?utf-8?B?ZVo2U0NiTWNOYy9KaC9mSmxjNGpRR290UzBpTmIwQnVMR09rUlpJZnk2azZR?=
 =?utf-8?B?NzlpVlAzSm1Vc0s0aldmbDRhUmxyVC9PUkFwa1VtOXhSU0NJQndySXdmZWxQ?=
 =?utf-8?B?SHdEYWtnOFR6alNEQzhHOUdXc1gwT1hKaWxhSURhdnRhMTk1NE9NUXM1a1ZP?=
 =?utf-8?B?OGlNdVAxdHZ6eGNoRHU3U01POVJlRkpOT3pXRlZLcHdKQ1VhNGJxUXpDUXAx?=
 =?utf-8?B?RVNyeFdVMlptT01kcytmaHFtVFNlZXBJOUg1TzZVK2d5VDZWM0RaRlI2bzhZ?=
 =?utf-8?B?ZDBrdXZpbGdzakxnMlp3ZG1yaUZUSHJrUlJaejdIRUpVMS8wb2lHY0dhMERH?=
 =?utf-8?B?RUJjbmx5ZGxab2FpMWVDNlhNMGNXV3p0aS9CRDZoVTFkMkloTWt0ZXU0RHZH?=
 =?utf-8?B?M1MyZFFtRnpxQk5ZODlGbVhIUWhOU1VZUDVFYlpGWVZOcmdXWndvUVVSNC9m?=
 =?utf-8?B?RUVNaWwyQmZiVnhZU0l4eTIrTis5QmcvcUZLZEdkWndPb1dMeEMrTjRoQ2ZP?=
 =?utf-8?B?REZiSUN3R2lIbEltRXE2cXF0bE1QMnhiV3dnZTBIQmRCNk5KYU9LN2xQWmoz?=
 =?utf-8?B?anluK2IzT3lDeG5CRmlIVmpqK2E5aFBldU5tRGJXc2taSmN4eHdaUjRiK2xs?=
 =?utf-8?B?OVIyOVdlVWJINzRNMU5BSkpBbi81KzRGQkxIdFVycnpici9HTEl4N3RpY2hF?=
 =?utf-8?B?R1FaK2NFNS9ZWXJOeGNKdGx2b1VPOWdTdDNyaWk1VzFmSHZOM0VBbE5TZlVC?=
 =?utf-8?B?Y0MzMS9jV01sZzdkUDRVRnYxdHBJWEo3eXBBSGc2Zk5rTzFYSWRoZHBZMGNW?=
 =?utf-8?B?QkMxSVhDK3RJbmNscTYreTNJaW9NZXQvVFMzTnNBMWR1aDgzeTk3OHBja1Rq?=
 =?utf-8?B?QXNaQkdPT0FGaldzTnlsUHAxSkNac0NmMGdBTE5sQ0JCb0VvSThsd3pUS1FJ?=
 =?utf-8?B?T0Y5VTEyTDRJbDlWZHprZStjc0dtRjNJMjFKY3FUREFxZnlpaWZOYnh1QWgx?=
 =?utf-8?B?L29oZ09ZOURsTXJ2MjZucUJPbHhsc3lUT1NOR2hqWUdZaG5yYmI2cjRlTkxR?=
 =?utf-8?B?MXlET2g1V3J4T0kxUGtjWDFHMWZyelpFR2NKRU5OZkJrZjF4djMrQ3RxQnVm?=
 =?utf-8?B?aVdaUEU2MFVyNDh1OExnUHcrKzJwczhmU0M4RDMxUnN4Z0hCTU51UWFtWS8w?=
 =?utf-8?B?SXVldGRZdS9MaWg1enhDMENEUTlRdXhTelRjeWhTWUJkTDRSL2phRGpyYUgy?=
 =?utf-8?B?aU9MVVFtOCt0RXZaM2cyWk5SSy9STmYwYVBNZjdNZFM0Y3BKcThDN3ppaDAv?=
 =?utf-8?B?cmlYMnlkTWhoOFg3NmVIUllKU09sSFV1SnlrTk1Ic1owUXlZUE1FbkRZN2cz?=
 =?utf-8?B?Z2t2QXZzOUNRUXBQclB1YU92ZWtTZXRydHpVbUJtdVdYTmVkakdJbEtrR1F2?=
 =?utf-8?B?QlB1eUVNU1lTeE93anRzWVVNR2pZZlB2RGxiaW9zOThIZVpmUVorZ2xZRHpv?=
 =?utf-8?B?LzRFRkhFVkVaM2VQSmdMUG5MbEtJbVBxSmZGVnJRMHUwVUx2RzNLTUFXVEpj?=
 =?utf-8?B?Q0RSaGVvWVorWG5RT2d3d1FOSGVKSDA1UVZmb1ZVZnNsaVhMNlpCaE1hQVdo?=
 =?utf-8?B?U25hQ3RNN1luQU12TlFzQ1F3NGNWdkp1a2RFVllURmRKQ1hDeHI5enV2NFFR?=
 =?utf-8?B?NUMxVXhaWWsrRXB2eTcrdDdlQVRVQlAyWXpuUnpOZUZHZjMySkM1NXUrWVNr?=
 =?utf-8?Q?WQeWFoIl2FR95no0oaxBcbwLs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9948f7a5-72a1-4604-5b6a-08db92bbf922
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:20:24.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izJzGc2eFibGRyjjsn8zJs+d00XShjN9CNKhzlfOWVkxjdPrnKvidBjwhG5Elc6C+arnX9IiFUtsF/yuk1DJcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/2023 10:27 AM, Tony Nguyen wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> When users attempt to obtain the coalesce setting using the
> ethtool command, current code always returns 0 for tx-usecs.
> This is because I225/6 always uses a queue pair setting, hence
> tx_coalesce_usecs does not return a value during the
> igc_ethtool_get_coalesce() callback process. The pair queue
> condition checking in igc_ethtool_get_coalesce() is removed by
> this patch so that the user gets information of the value of tx-usecs.
> 
> Even if i225/6 is using queue pair setting, there is no harm in
> notifying the user of the tx-usecs. The implementation of the current
> code may have previously been a copy of the legacy code i210.
> 
> How to test:
> User can get the coalesce value using ethtool command.
> 
> Example command:
> Get: ethtool -c <interface>
> 
> Previous output:
> 
> rx-usecs: 3
> rx-frames: n/a
> rx-usecs-irq: n/a
> rx-frames-irq: n/a
> 
> tx-usecs: 0
> tx-frames: n/a
> tx-usecs-irq: n/a
> tx-frames-irq: n/a
> 
> New output:
> 
> rx-usecs: 3
> rx-frames: n/a
> rx-usecs-irq: n/a
> rx-frames-irq: n/a
> 
> tx-usecs: 3
> tx-frames: n/a
> tx-usecs-irq: n/a
> tx-frames-irq: n/a
> 
> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 93bce729be76..62d925b26f2c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -880,12 +880,10 @@ static int igc_ethtool_get_coalesce(struct net_device *netdev,
>          else
>                  ec->rx_coalesce_usecs = adapter->rx_itr_setting >> 2;
> 
> -       if (!(adapter->flags & IGC_FLAG_QUEUE_PAIRS)) {
> -               if (adapter->tx_itr_setting <= 3)
> -                       ec->tx_coalesce_usecs = adapter->tx_itr_setting;
> -               else
> -                       ec->tx_coalesce_usecs = adapter->tx_itr_setting >> 2;
> -       }
> +       if (adapter->tx_itr_setting <= 3)
> +               ec->tx_coalesce_usecs = adapter->tx_itr_setting;
> +       else
> +               ec->tx_coalesce_usecs = adapter->tx_itr_setting >> 2;
> 
>          return 0;
>   }
> @@ -910,9 +908,6 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
>              ec->tx_coalesce_usecs == 2)
>                  return -EINVAL;
> 
> -       if ((adapter->flags & IGC_FLAG_QUEUE_PAIRS) && ec->tx_coalesce_usecs)
> -               return -EINVAL;
> -

Should this be part of patch 2/2 or is it necessary to remove this for 
the get flow?

>          /* If ITR is disabled, disable DMAC */
>          if (ec->rx_coalesce_usecs == 0) {
>                  if (adapter->flags & IGC_FLAG_DMAC)
> --
> 2.38.1
> 
> 

