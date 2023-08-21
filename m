Return-Path: <netdev+bounces-29416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0269B7830FE
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C8D280E94
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFDB11709;
	Mon, 21 Aug 2023 19:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5FBF4E9
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:40:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344FAA1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 12:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coCbIN0mu/1G/w5CJz1k4FlLIUVamcovycMpa0zMqI86VoICLtStGUS5EZaUJh1QIDJBMV7V8pv/gXzDUVEeJSJZ0taBHaSEl0TBc/16GjXC6eexcFVr49zwC38ZnOCzwrl5N1dWSXgUdbzlxr///85SiNiwH391THQDRYHVOGdbatOa2OgrOl6q0k9i4BJEvnHAmbH+XoX+t7giW7uOVty0UcD54j+LKwzR9sJP7kHM5NaN+lIggRbRR8a51G/FvUBAik5DNDaU3HXs1gNHSC4egK1VOufAqRKGfnQvpd2cb72LELRiBB6JCmpoQHiADb07SCcIbkwpB5nl0GsW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgsXryqORJLEJvM6ljuQCE7ymzDWhBntu9hCp++PdFs=;
 b=QI3Le2yIPEO+OAZS2tNKk5t+MaUlK7c1mkhHnO2rDeGOu7QE4Dnfc9SvcR5ZsML/BrrOTU+3/UiWXSiDmxA+VWMxu15luw4Wk7fjrsRX1a1Fk8BDJF8YZpYuAjRWhU9d86xbyMk3/qjdoBncmJEDPYfV3jkJTArv6gjA2m7t0GEai1ZTaYCljJAKPQRZ+Vcoqog79Q27LmsSfQrMmSvPJQ1Rhe7zKDujMr3h+0LmBTazTnUB1iCmJr+LybF/5gpsNaEfCxGEIf7woNVWe67JnBSyEY3FiXbyjq3r0RT4Xd5Cgeio62oS+q3tXnV8vfOq8QPTvPnDNT5q5eKGyPCcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgsXryqORJLEJvM6ljuQCE7ymzDWhBntu9hCp++PdFs=;
 b=XrRG6zjger02NhF/j+9PHQZSDbt62q7k0oGhnqyEwupccW8qeFO6liFz9ybmzRjHDtP2yl7Hb6+vS+uJ2oZue2ZzOkSCqFuMxPvG8KpxeKKiFGB/tqApQe4xK3BpId5cPJ+5inN565D/N/d0daOrDQk6mqq46Nw1MoL2oA0Gxzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:40:18 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:40:18 +0000
Message-ID: <69e9c563-2f07-4e9e-b43a-145839fe2afd@amd.com>
Date: Mon, 21 Aug 2023 12:40:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ionic: Remove unused declarations
From: "Nelson, Shannon" <shannon.nelson@amd.com>
To: netdev@vger.kernel.org
References: <20230821134717.51936-1-yuehaibing@huawei.com>
 <46c62232-9a00-4a9f-b1ea-288c53ae47c3@amd.com>
Content-Language: en-US
In-Reply-To: <46c62232-9a00-4a9f-b1ea-288c53ae47c3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::29) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: df342adc-d85e-4b91-ab4d-08dba27e7343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mWHkJmTkQYsbwUqS3cZcOfa2+3coztTeop2zLjULlT2NjcbEuUb3W51l8snD4YfQc2mYKHtAJDwtQv9DyTfHFcvNoMFhlDztUWh9yn5qqnzyz24kYxDQJce1z5pR0l9opDUgEDvyGXTrclAiIWH21YdD4RuTaWg7vLqPfzsr2gRwSvs/tgyM5y3+Ys3wKdUze6AmBI1C0KziykHv5ZX3jgQzsky9HUi0o904NKZ0+I5EdoA/iwE0EUw/q+NZn6GTCvx23jZOep7gAjq7LyknWSW6Bo7644FcJe+1riTwDrjzUB1enY+4xOm4MxUqnubNvzWNepFTolZTdQiriMT9Rpd5zOYxbs+ut4dbdy3By0kr6+I7MIz6eNjY493wT7yPK2WfJzzInipsXDtNJS7QWnsIUVmH/ZGLUd8wSHxIVAZLdSe9L6jBuDuG+8WFF+xTLyPL/XjZHy+X4eNVUkn0tSWDaOo+Y477H81zDxKwwgxnmNXms8toardaPBr5TWi/HntmRIIJHiw4jpuK7fazdTvKlxOc7gvNBw79unrEo6AiCwt9CEX9twSG4BAt4gqoj3gjKivLwWmK8ogcyjO2diPjDWtoRIH4AofDp+JUnTlhPGqdcBsTQunNmrzHUqO9k+wabVZUGCTmofoqNB8ErQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(36756003)(41300700001)(478600001)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWQ3VVVpeWlQVzVyQnZzR0I2bFBkUnlIUERQbkVlblV6ZmNhSFB4aXkrcWtN?=
 =?utf-8?B?SXoveXZIdjR0YjRFZjZCRDFzOEg3NE9GZzJUcjhsTUlRaXZQc0N4amllemYy?=
 =?utf-8?B?K3Z1SFR6MHdmSEhzZUxRd3dwanA4cEtSUXRqelFRRkU3Z3lGYk82MkdPcmdM?=
 =?utf-8?B?OHcrYmY3R0d3VkNoLzJhbFBTSTk1RjZSOHNsSVM2T2FMTWpqbURSUWo4azVy?=
 =?utf-8?B?MmQ1UWdnamlUUHFJN1MzSEs0a2hiQkJwTDhDSmFPWk1zdmZaK0t3TGN2cndx?=
 =?utf-8?B?LzlldzE4VU10MEhNN0pFeGZ5V2hveW5sYVZBZmZlSnF4MVVLZ2NuUlNOazB3?=
 =?utf-8?B?Z2tOWmQ5MGdIR0ZCWk90ZlNBSU1BYWk5WGtsdlZxcUgra0o4RURqb1dsNGRa?=
 =?utf-8?B?YUt3OXYwQllobDQxRWJsdzJDZ1BUVDc3c1J3VUdBYVNlelFaYm5nbGhXV1A0?=
 =?utf-8?B?R3JkYVZWNC81ejVVYzFoMzAzOVM1bCs1cHJvWDg2cWx1bjVDUW1DdDlFTFQx?=
 =?utf-8?B?RVVtdFRQeTBMU29HOTArT24wS2drL0gwOVNma2pxbG15N1hjakp4SnV6RnpZ?=
 =?utf-8?B?dGN5dHN3U212c3lJRldGNFp1akwxUWlhTW5wWHZrUlU4ZTFZSDIzejJHMFlR?=
 =?utf-8?B?OWZSSEswNWl6WTFwb0g2WVBJMzczYmlONEx2cUl2eDVhQlBQMjhxdUxWK2VG?=
 =?utf-8?B?cVNnVC9PaC9FS2EydXVRUWs3b2d6dzVhQ0NIeTBaV3hDVlJlUUYwZi9LbjRF?=
 =?utf-8?B?dUNscEV0cVNQVWtoU2pIQlhrNXJHQXViRXBnbXYrTGloZWV6MHNEcUpCanp0?=
 =?utf-8?B?M2JYeXYzUGVRQjhHeHBrbzBhOFFtWEdYUEx4Qk56T2U3NllQKzNNdjlQamlS?=
 =?utf-8?B?MUt0bWtqOXo4YkRzTzFaWlZIMm4xZXdab0lZVHVnK25qVU4rZDN4aHI4Rmdj?=
 =?utf-8?B?eEEvSms3OG5yeXgrTWlHZHpFNnJGRkpoK1lYeUU3ZWQxSEtlT3p6WllOTk9w?=
 =?utf-8?B?OXVwbnYrNW94ZDE3MEtVcWZDbDBKV0xCaGNGTTYzMStCaG4ycmFaNkhYWk94?=
 =?utf-8?B?YUkyemlnQ25OdS8yeEdPVi9aWi9kdzJadjV5TUtuUnAzV0xBUlB1eHkvUE1T?=
 =?utf-8?B?K3BpbmMrNDFQZU5vNDFWWWpHTXFRSlQ1d0VXTWtRc3pUd1NacXppZDI1N2g3?=
 =?utf-8?B?ZjQwWG8xUUhEVmxzWmZGYitOMUkyOFBKSVNpaUxkOG9LUUR4aktzSU9VaFAw?=
 =?utf-8?B?djlIQWlESitqNEo0b2w5S0g3dzNZRHhvalFMem5pUVlIRkp3eWFhVUcwK2cx?=
 =?utf-8?B?S2hkd0RnYTlVc1FIajNZTk1PNFJ1c00vV2FseGpNemc5clVIb1BKWHUyMzU3?=
 =?utf-8?B?aXArTmJCcUoyamRkNjdDVVdrRHpMQVJzLzV3emlvVDQ2eTRwNkRHNDR4bWJG?=
 =?utf-8?B?eDlMalAxY2cvT0Fzdk5DT3hMZEIvbWp5N3ZVT3dsY2FHbWlRR2tYK0FMMEhS?=
 =?utf-8?B?K2cyd2lEc3I4ckNRaWlwWXRPWkZKL29naERJNkJucnh4d3NZOFZSWk4yQjM1?=
 =?utf-8?B?ck83SWFWWXpWd2QxaXNyWEhLeHZyWW5sRkljQ3UzMmR5VWlyUXZyMnpXUHQ0?=
 =?utf-8?B?SHMzTU1pbnV1amFvVnJscDFJNHJ4NmxQd3lyc201azZOWWZDS3FnMnUvZWNw?=
 =?utf-8?B?cVkwNEVCcGR0SkcyS0U3Rk4xSXIzQlp3N29DWFYwdlBXVFBoc0MwQ3Rid2JX?=
 =?utf-8?B?WDg1azV3bnZPU0JrY01tR1RWOUptekhmMnlkSVlzaVdsWFRXZm9tbXpWeWR1?=
 =?utf-8?B?RlBSdFZVclFiVFBsZFp3SWE4d0xGZ1J5NGFvWmwxUjlXM2o1VXZ5dWJDSVg2?=
 =?utf-8?B?U0ViOXZsZitoQlN4WmQvK0NiTDljRWVFRGgzOFRjbjZYckJvc2tRTk9CSDlG?=
 =?utf-8?B?bmp5ZzJGajh6dlVKRnNobnQ2cmhLZkhkS3RKTmdaRVg3Y0x2UjdDaVdIaENy?=
 =?utf-8?B?cFFxdWlwQm1vTWg5d2ZMeHNVWEo3bVU2elJZa2NmOHVQK2hNUTdxVjJjeW92?=
 =?utf-8?B?T1dwajNUTUk0Sm01b0kyWGp6YUxGUEtOODhoeXo5bVYycTEvTkNNNHRUdFpQ?=
 =?utf-8?Q?Ex6BUUFsmLt6zy4ON84h5xRk2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df342adc-d85e-4b91-ab4d-08dba27e7343
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:40:18.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjWmGuzb2ztuqS+GANucfU9Or7NmIp2ivAUm8umr2I2252XKygCOXgDUGVuQYPrYvVteJjRdeaIXBFUg4nHDwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/21/2023 10:26 AM, Nelson, Shannon wrote:
> On 8/21/2023 6:47 AM, Yue Haibing wrote:
>>
>> Commit fbfb8031533c ("ionic: Add hardware init and device commands")
>> declared but never implemented ionic_q_rewind()/ionic_set_dma_mask().
>> Commit 969f84394604 ("ionic: sync the filters in the work task")
>> declared but never implemented ionic_rx_filters_need_sync().
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> This should include a "Fixes" tag
> sln

Let's see if I can make the magic work...
pw-bot: changes-requested


> 
>> ---
>>   drivers/net/ethernet/pensando/ionic/ionic.h           | 1 -
>>   drivers/net/ethernet/pensando/ionic/ionic_dev.h       | 1 -
>>   drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h | 1 -
>>   3 files changed, 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h 
>> b/drivers/net/ethernet/pensando/ionic/ionic.h
>> index 602f4d45d529..2453a40f6ee8 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic.h
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic.h
>> @@ -81,7 +81,6 @@ int ionic_dev_cmd_wait(struct ionic *ionic, unsigned 
>> long max_wait);
>>   int ionic_dev_cmd_wait_nomsg(struct ionic *ionic, unsigned long 
>> max_wait);
>>   void ionic_dev_cmd_dev_err_print(struct ionic *ionic, u8 opcode, u8 
>> status,
>>                                   int err);
>> -int ionic_set_dma_mask(struct ionic *ionic);
>>   int ionic_setup(struct ionic *ionic);
>>
>>   int ionic_identify(struct ionic *ionic);
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h 
>> b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
>> index 0bea208bfba2..6aac98bcb9f4 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
>> @@ -376,7 +376,6 @@ void ionic_q_cmb_map(struct ionic_queue *q, void 
>> __iomem *base, dma_addr_t base_
>>   void ionic_q_sg_map(struct ionic_queue *q, void *base, dma_addr_t 
>> base_pa);
>>   void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, 
>> ionic_desc_cb cb,
>>                    void *cb_arg);
>> -void ionic_q_rewind(struct ionic_queue *q, struct ionic_desc_info 
>> *start);
>>   void ionic_q_service(struct ionic_queue *q, struct ionic_cq_info 
>> *cq_info,
>>                       unsigned int stop_index);
>>   int ionic_heartbeat_check(struct ionic *ionic);
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h 
>> b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
>> index 87b2666f248b..ee9e99cd1b5e 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
>> @@ -43,7 +43,6 @@ struct ionic_rx_filter 
>> *ionic_rx_filter_by_addr(struct ionic_lif *lif, const u8
>>   struct ionic_rx_filter *ionic_rx_filter_rxsteer(struct ionic_lif *lif);
>>   void ionic_rx_filter_sync(struct ionic_lif *lif);
>>   int ionic_lif_list_addr(struct ionic_lif *lif, const u8 *addr, bool 
>> mode);
>> -int ionic_rx_filters_need_sync(struct ionic_lif *lif);
>>   int ionic_lif_vlan_add(struct ionic_lif *lif, const u16 vid);
>>   int ionic_lif_vlan_del(struct ionic_lif *lif, const u16 vid);
>>
>> -- 
>> 2.34.1
>>

