Return-Path: <netdev+bounces-29378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343D0782F5D
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1058280EA6
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ECB8C16;
	Mon, 21 Aug 2023 17:26:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42258F44
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:26:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD1AF7
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 10:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUF06z6vISoYDGDZIT141T5Mo7mphTHiHoblmHmkepxAMVeeurM7RzUqM6JoJYk0qg/p0EKdvYQNsfLsZl/D06AxQIJqZSI35Z6nQhSsvdiM1CS416VTDtmxnKpPezX6qgIYQWtWp6GThicF9VjQPoM3Qldfb9f+BxFkbYpd08NNi6M8c5lfFoT9AWLpu8A9ny0G5qsAHZ/auUkUdqig83Yu6oW3GSYloTyzejHMtpHL1pNvRyK0pPd9INxCzVHsj2/V4WHXzTvBC59k1uxyRqlUrCqL5tNjge0QEMkh/uXQHebYLBD3b9xqkypdm5XuKzOyMe+8QpxuWYEc3udxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGC9u8jqHjy9Nm6VJrhjBzO5yA80HsPe6Bs4xJe7hBs=;
 b=A/5RPACbfx5V61pcpT5f4P68OEHXO7bEhK7qR5APxWPoNMXd7MfFWyVnnXZEznNNUHUXAm4nmVmfkK1MsA86ORqwNHN6cUIwMeTUa3xCbrKnlTkFR3jeSpUZsEqWJNH9oFm8eIWN6sKQP6tTKNKgJuUvf3jV7OTolwgmWUti+mSMlkh9dwpZ+64Q5/0bZD0EHUiiVG/r+81jC+MPKs/lbOawzqj5GNqmwFRPYqxJA13L8gEgWA44NelBFqY9geGJfca+xD/1/ULLaKN/wGBWe1Vi9YvRASf4KlnmLr62isBdOm3gRyAAEEYtZZICNdAUSzyk98/ksVG6KnPDn4WRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGC9u8jqHjy9Nm6VJrhjBzO5yA80HsPe6Bs4xJe7hBs=;
 b=STw5Pi7KzsYLTROEjPn0FYVEm+4ws+icwnyTyrFxXvfPDJXCW4l0yD82a7RNQo81X0BdRZ0ukW+03mmiFSD5wGCVUzzyjh/yVBlMlThpBIe5oYvnGDZeLZVNOpNV2NqyBwA95Li+Be+3fTcTNbRWtRGmCpnqB9WCB7IwJ3H9L+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 17:26:44 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 17:26:44 +0000
Message-ID: <46c62232-9a00-4a9f-b1ea-288c53ae47c3@amd.com>
Date: Mon, 21 Aug 2023 10:26:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ionic: Remove unused declarations
To: Yue Haibing <yuehaibing@huawei.com>, brett.creeley@amd.com,
 drivers@pensando.io, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20230821134717.51936-1-yuehaibing@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230821134717.51936-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: d41e7b32-4945-419d-4e8f-08dba26bca19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a640ed5JkhdT2W+HcCF+nLOjRZ+UAc9ATJ9aVfMGVvoxn1/JNqSMokTq1CBshNtMb5Nrdjm1BZ/FsG2uYkdRPckt4OuEdhyfXWgZcFKS+9l0UqCYNt0woix1u0Z9HIyL/yIst2lSV2gbeg9mBvZblE7edr4okNsqGL2vm6RRgbNXP7fLmxAztBO+XeJpJed8dINto+WBHDlwB1/I96NzTS/uKIrMlumh8AmO7MxVm1Hu6bZBVtM9YU4APjD4wM52VGkJ13uTc5Q6lh3jY46lnTcvYyHrxTzE1slnFYWF6Nhxflx6RegFyfya5urg4dc8lmeaK3mO2l99XJIo6pBNmO3FPOQmBbJpCuTHwGpR85Krv3DdQbiCN0vz5YSKr7gU19Gmu+vCABA1GOtLNwtq9WLHWB7zKCs6Q+soVk9nCFfoVozVo0fIFmZg0AMJdC21hM1RsATyYWuYLNWl/bkQRkITKcYbysP6NxRfclZBn58Nn8JhOBXWllnSXdD3m8Dum4MSNiLx3Dkvs7qeAX7ppGF9iwCaW7+7C3ebW91c+sMXXqZ4bF8g8ZF4g6RRrlSIst3aMHtkLRG1HDDTbBOTFXDGBh1XZcMVUGlBGzcD0HnNX8BmkrwCod/NpNwj4YJTrAbBtdkq7OUSbCX4gGj8dQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(83380400001)(53546011)(6506007)(38100700002)(6486002)(5660300002)(26005)(31696002)(86362001)(31686004)(8676002)(8936002)(2616005)(4326008)(6512007)(316002)(66476007)(66556008)(66946007)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0N2UER3V0JtYzNlWnRlN1ZKUDd3THJnb20zaVV2ZUJNalljNEQvOHlBYjRn?=
 =?utf-8?B?QWh2WVZhQUs0eVZWTk44UFFMR0d4SmtWdGp0djlBbnFzS1FFTUlZTUFDY3B3?=
 =?utf-8?B?RlRkQXlVOTNMcGtXVE5aVC9DUWx0a2xZK1doVTcrbnhKSnF4Q1N3QVhPbW9D?=
 =?utf-8?B?ZUp2S1c3UjdpN0dpNjlHR3UwdnpzRUZaTmhXMzVMbkNveUhpYlFUekZGM1Zy?=
 =?utf-8?B?Tjg3Q2IyT3ZJMUgxNVVjSU1tN1RBeDhVMXB0RlpDNE5GMkpxQ1NHR2tyQmtP?=
 =?utf-8?B?Q0RGbW9NNFh3TVNMYmo1bDRvZG1MQys0ODBmMUhxdkxyWEZENjNGdUZ5WWFv?=
 =?utf-8?B?bGxjYlBhTkZoQTNYaDdRVVlwd0NrSndQbjRMeW1PaWNYa0hLQVJrQ2F5YmdE?=
 =?utf-8?B?ZC9QUHEvajdBTHgrdzUwNEhFcDhKcklSVm9kbDZqN2t4RHBsR2hIZ1Z6NXVK?=
 =?utf-8?B?bzlQWVcwNXBJZVE2dnZJL1lxanpHTGpxMEI2RTZ3SWxIUUNHekhFMGM5bHk5?=
 =?utf-8?B?dTB5UW9MNU9tZkpVc2xuczFqb2tLaFhFVDlxTFI2c2lhNnJRMXJrQXVTK2lB?=
 =?utf-8?B?Z1oveXJNSENUNW91ZVQ1Q05sM2JvZy9KdnJ6ZkdqcXI0a2ttR1lDeGVObEdZ?=
 =?utf-8?B?OVRFMWR3SXlMMWdwU3BGWlRKaHJZYW1BSW0rYjEwbUpCUXZBU3FuUnhoZ0VC?=
 =?utf-8?B?OXRSREhZOUtoRnVkaThnVUlETmp3VXd3ZEttZnZFYzU0bExWcHZ4ZmRJQ1c4?=
 =?utf-8?B?TnIxNEFpUDlETmdVckRrQ05CM1lTRm1sVEpLVExCc3pyaCsvR29uaHg2Y0F2?=
 =?utf-8?B?SGVaYjNwT1owOTVaaFJjOXl0d3l2VU5Xak5vQlBUeE95WElDSTVUd1NEU2FU?=
 =?utf-8?B?U3cvRUJmaGNNMTBJMEpRd3djTlhMSWJuZG5nNXFoVDRCY0xUNlpyMUxOd1Vy?=
 =?utf-8?B?NXVlSFQ2NmY0SFVScVdvUjJWeTBQU2dKcHlBOHgyRDVqbmhybGJDY3dvZHNu?=
 =?utf-8?B?ZzR1Skw2Zkl6UjdEMTR0R2ZTZURGcHNmaG5lUVV0N0lKUXl1cjN4aHIvWXdl?=
 =?utf-8?B?VTl2aHJmYjRQQWlHaUd5R1U5RnNhamhNK25jTmFHWExUcUd1cy9CenltaTZ6?=
 =?utf-8?B?Y2gvTjBLdTk3eW1ud0k4ZnhXbU1DSFlLcnNvbVhQSkZyM0k3UTNaaUQ3OGRr?=
 =?utf-8?B?d3E5ZWNDbm1nMVNSSWdFUXhoZUZnY09zS1ZNbXBpd3JjUTFVZk9CMUpTajhu?=
 =?utf-8?B?ZlRyaW4yTko0Vm1ieXFqTzF1ZmFjMWVsd2lySUFMYURiK2dkSUFxQ3p1WmpO?=
 =?utf-8?B?T3NIWStNakNvanJWNDZPcm9JS3luVHBtVGFOUzFQRmlhek0vMUh3RnZWb3pu?=
 =?utf-8?B?TmpJNE9TbHI5UXAwWnBzYkRTZW9yMkVhRENNcVBPbzJVcTZFb0pEY1MwaW1v?=
 =?utf-8?B?bUVMZU9Ob3R1WS9XalNVN2lVcm9YL0xIM1dWRFZGQm5vOXlCdFRtWi9jci85?=
 =?utf-8?B?UU9vRzJZcDgrRjJYR3VjcFBqR0FQYitFc1JzQldEZlFlWHFkcDhqQmJqNmdC?=
 =?utf-8?B?Q25tY29xTmJtdTlPWEhKc0MzN2NmRHc0NDlDZ3JpSVM0bWlpb1FHYWRZazQz?=
 =?utf-8?B?dk5ZMHpUdlFoZW13cHYyVGhaRThldjhobmtGMUkxdHVrNHZDV2hRNUFLSmN5?=
 =?utf-8?B?VGJwdjkwbFRmVHFYcEZKclVmd3RVV05CVkhoNlIvNThuZ1dhQ1VabzJNdXdZ?=
 =?utf-8?B?MGNSOEZWWXFzM3pWbXVEeG9LTmMzaE45dW41TUgvWmZHZldrdGFKWlpTNGk2?=
 =?utf-8?B?SU5sbGt6NmRlSGR3V21jZ2NWQy9zK0REV0VHeE1HdWNnUStHNzVlS3F1OVl0?=
 =?utf-8?B?M1MxZ0lVTk80TXhQdzlLZE8rcnNmVERob3pKSUpaU2lWR3RmajNXcXh4V21x?=
 =?utf-8?B?Y09pMkRCaW9TeERFaWJQaVo5dEVjZmtlZXJYNmpsWjRjTmgyM0JVSkI2TEdL?=
 =?utf-8?B?Mnd6ZU0yUEpodWJ5ZlRBelh3enpkQnIwbkpzZUh2NFM1SlBBam5XckkzUVJh?=
 =?utf-8?B?cTg1eEsrWExBRi9UdGF6VUF1Wm1XQlhJcUZ4ZlBBeFlrZEtjRlJkYmViLzRG?=
 =?utf-8?Q?PcNjAzIgM8fg6gpaejXPHNSKV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41e7b32-4945-419d-4e8f-08dba26bca19
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:26:44.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sakSNT9StH4x9u0FRKl/Hwa6B2CaPI0BrXn3cDE5ikLhfYVp0uo2uW7ePIjfuQ2q4K5UZU1qNLGr76GLXQn3FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/21/2023 6:47 AM, Yue Haibing wrote:
> 
> Commit fbfb8031533c ("ionic: Add hardware init and device commands")
> declared but never implemented ionic_q_rewind()/ionic_set_dma_mask().
> Commit 969f84394604 ("ionic: sync the filters in the work task")
> declared but never implemented ionic_rx_filters_need_sync().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

This should include a "Fixes" tag
sln

> ---
>   drivers/net/ethernet/pensando/ionic/ionic.h           | 1 -
>   drivers/net/ethernet/pensando/ionic/ionic_dev.h       | 1 -
>   drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h | 1 -
>   3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
> index 602f4d45d529..2453a40f6ee8 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic.h
> @@ -81,7 +81,6 @@ int ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_wait);
>   int ionic_dev_cmd_wait_nomsg(struct ionic *ionic, unsigned long max_wait);
>   void ionic_dev_cmd_dev_err_print(struct ionic *ionic, u8 opcode, u8 status,
>                                   int err);
> -int ionic_set_dma_mask(struct ionic *ionic);
>   int ionic_setup(struct ionic *ionic);
> 
>   int ionic_identify(struct ionic *ionic);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> index 0bea208bfba2..6aac98bcb9f4 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> @@ -376,7 +376,6 @@ void ionic_q_cmb_map(struct ionic_queue *q, void __iomem *base, dma_addr_t base_
>   void ionic_q_sg_map(struct ionic_queue *q, void *base, dma_addr_t base_pa);
>   void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, ionic_desc_cb cb,
>                    void *cb_arg);
> -void ionic_q_rewind(struct ionic_queue *q, struct ionic_desc_info *start);
>   void ionic_q_service(struct ionic_queue *q, struct ionic_cq_info *cq_info,
>                       unsigned int stop_index);
>   int ionic_heartbeat_check(struct ionic *ionic);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
> index 87b2666f248b..ee9e99cd1b5e 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
> @@ -43,7 +43,6 @@ struct ionic_rx_filter *ionic_rx_filter_by_addr(struct ionic_lif *lif, const u8
>   struct ionic_rx_filter *ionic_rx_filter_rxsteer(struct ionic_lif *lif);
>   void ionic_rx_filter_sync(struct ionic_lif *lif);
>   int ionic_lif_list_addr(struct ionic_lif *lif, const u8 *addr, bool mode);
> -int ionic_rx_filters_need_sync(struct ionic_lif *lif);
>   int ionic_lif_vlan_add(struct ionic_lif *lif, const u16 vid);
>   int ionic_lif_vlan_del(struct ionic_lif *lif, const u16 vid);
> 
> --
> 2.34.1
> 

