Return-Path: <netdev+bounces-57697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF1813E86
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273EB1C21FC0
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A2804;
	Fri, 15 Dec 2023 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KFqzvKLF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AFD650
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATLJhT9E36XAiy+uor6fJwqXKuLfMim1k4h8UjP5OHhi0tF9+xubwkXrWyxigJJWp2DJpOTye0X8COmaZ+FvfC7nbUFTh+zLOv72CIkNCrwoEyK5jdH4KwhkrbIZjZCxebk77G5lI2YMnUGjzuVEbQWzKBUsZxeIq5agqS0Nhsa1RAstxzqTIJutAfElKxlbzH9/OYy/b+l74GBQmLVGUjkCJU/ui9fe16WyPWyl8YJsFD5PQctjZJYQSWfJlD5inDWc6ejn9wd8Gpe9EEZnOS2Qa4ukDzQBoWW4jTGYccpdt4jrrZTKx+VNrvH7xKanbo7Bj2DrbAha8MB9AEFnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Msb1E8wqlZgKqwLO4wARlPdZESXv7XA0yBxCMhJC14k=;
 b=MbH2v0SbKP+GorLY4f/mmJjwNxGNWxQJA7y3LdVkJZNZ0SCE8t6PJzes/pCMMeR+Af8YkOTlkmswVaQdS2hwL0OdSibUCxkK+BxIrkPzz/kpEfiOLy9jSkuIDZW4Hy86v2iAKIWpP2kDsfHPKwCLRGD3xI7MENaLmDqhIniBsXarYL8xrvdBSRZd9jJSgBainvbWwLMX/1+MELtpKPbW13XTay8RV6ySpCnTV5qlvapfQ8Mb1cg6WXAX9iH/0ruFDdZue05nIeip81JkkWOIVsMLo5rBu6hz8fXvLDgr6e6hMDTwfd5sYY3ehGHcV9mSK1pmlOKRif4HShsIoFRtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Msb1E8wqlZgKqwLO4wARlPdZESXv7XA0yBxCMhJC14k=;
 b=KFqzvKLFYZkUJX44SNzw2goL7HsdyYCjSNzFJvSEhiIVO/HgpSN6aSBK4piXWqvGw7UBZyNQTYN0zOKWgLTCTdH3PbnAXKrZ2PyM0i/A4fucmOxlrTSBE5hG7tr8qxVDV7oZbCqCyIUagXSNAICekoLhEkLbSr2wsxA9+Tb/6tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 00:05:39 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 00:05:39 +0000
Message-ID: <0d1d3002-ff8b-4601-84d5-ee26733af54e@amd.com>
Date: Thu, 14 Dec 2023 16:05:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/7] sfc: debugfs for (nic) RX queues
Content-Language: en-US
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <a5c5491d3d0b58b8f8dff65cb53f892d7b13c32a.1702314695.git.ecree.xilinx@gmail.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <a5c5491d3d0b58b8f8dff65cb53f892d7b13c32a.1702314695.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:302:1::37) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ec3d17-d019-4c69-7408-08dbfd0191ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8IHdavO7ryXZfnjcL1za63QsUxv36mj2qa+vrOjGzrRUHdyDAanbPCBoZ+EyyWiYB5l89W3kw/LNj2XJsk3x9gmZJvTabfgzvSwX3t7z7VJcHMJ+AUJzCxOL1tldTPUQuzTvEfPzN4UJalpLmjmcRQJTLTgTWaxUl3rGdGKWnXbO5er+vEauvoImdSUSiIk8vD6fjnm+DEzs1AXRKZEsrRDKilVCL6Zd0QQOakVwbFZ2ts48TQa2v7M/2ArUkXAEhTTw0cuyTTBu/yiLVWmwV4nyjXRN+KtzQP0J56RXtXG8PB782A8aedh0IMGTqLeyo+QufRW+6pvWBownP66aZyB8LTwyLtSiImcFFchwAjnf3mg9bCSTc2NlT7c7TNBBLACwOfJgIIGjvyFU4wB5g8fyajGy5V1rsHnNx+++l+cHHYjYxGb0BgP5GRDQlTu+AlKQQ61PCt8y90ot8ufjqSPAojYtZE1Ut8c/fAcnVfj7Bd1k5IlnrXqXYiDKJ/Nf2GYRa6/CCtQfD97qLRWfKRP3E2FRxl0Xyz94+iq/rrYoP2DXkhT0PQ1v9sFuvS7R6o0nX222avuryAheZxvvLazy8Yl9y6Sbkw1wWEwjWyP6ZO7kXf7i0ET0PZgRtJCF7tBnoY6gf9H5C4Pbi7Lufg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(8936002)(8676002)(26005)(4326008)(5660300002)(83380400001)(86362001)(6506007)(53546011)(2906002)(6486002)(38100700002)(31696002)(36756003)(478600001)(41300700001)(31686004)(66946007)(66556008)(66476007)(54906003)(6512007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0NoUE1td2p5UmZQTmtkV2xZTU5scENxVU43ZzhFZWJRUUcxMno4UkczU2Nu?=
 =?utf-8?B?bHBKckhVWU9TQ2RjcU9XWTdtb3E5bEExTFoveWg4UmQvNEhIWlRkYWZBK2lo?=
 =?utf-8?B?YXVEZm9yQVFvdzJtYUh6VFludGJPZk93Q0ZwOXNudFFaRVVuMzFVOXV2d3V0?=
 =?utf-8?B?Tzk4VVNUM09pTm1tc0NrMFBzY0RhVDNvQWxmY1BiWmRaeGd0WEJ1N0ZjZUow?=
 =?utf-8?B?WlRQVHFkY294TGs4Ky9IcVU3VWtyb2VNQ3JYajU3SE5YUXlIQUovWEozQzZY?=
 =?utf-8?B?U0ZaS0ZGU0pkSUl3OEdVYU1hcGZoVE5VVGFRbGxLRCtFaSt3R1dQY3BaNU00?=
 =?utf-8?B?cE1QczBDbjk2MG5jb2xja3R5dzJiSktrZ2dkWkNhWENrZW45bzE1NEFQa0pB?=
 =?utf-8?B?ZW9EbnpKZ2JOdmJ5TEkvTDBHUjRJUVR6VkhucWw4M3RxdjE0QmZRU2dTR2Vs?=
 =?utf-8?B?VUtrT3dlNmgwdXduSTJiQ0FTd0xwT3UzWTlOMlFzRllscFVUVUtCb1JlYmw5?=
 =?utf-8?B?NHA5WVNoQ1NibTJSRVVTd3VjQTVGUUpiMExOS3pUakFQdG9jMkJFcG0xMmc1?=
 =?utf-8?B?NlhuZ0ZjVlVuOXJaZG56a2pRYlRXR1BwQllLVzJzQkVEOUNLVElJM2hzazB0?=
 =?utf-8?B?RmkySnhVUUYvUng3Qk5yQWV1d3g0VTVRT2ZhNEUrbzdMRm5oaXBtZ0Y3c2Fj?=
 =?utf-8?B?UUs1RTk1K1JZbmRCT28vaGxadlQrWlprKzZJOEZLU1B4WHQyUHI5bVVQbXFk?=
 =?utf-8?B?NFBDUjU3QzB4VmQwZVkyLzRDYzg3T1lwWERmV2FLclJoWmpqbDVEejhxMk9S?=
 =?utf-8?B?SlgvTkJCUldOQWhDVUVjWmdhTTI3VVEyTHJpc3gxRUorWXR6dVh3aTJVRFd4?=
 =?utf-8?B?RXRCd2xYU2s5OUVZL0JicHk3TEgyRUZ4eXNXaEJLWUxoU1g0T2NzZ0Z2MEJ4?=
 =?utf-8?B?d0o5bVBDeUNWZ2FVdDI0WWJNaFRMSjc1OGhqZDdpNmlNWG40a0tUR29mN3lM?=
 =?utf-8?B?cC9Mb3pvcHNoMmFRREV2bzUyYTRWdzhrQmNZYzR3bE5aa3lPdjFzWllSK09N?=
 =?utf-8?B?blJnQmJ2NTYrL01PMTBqSGZEYmFQVCsxczl1TTFkYWlMMmtvSzJtaWpYdTNK?=
 =?utf-8?B?MkFVeVBrWGU2eUNONVNsc2w3YlhmWWFlZlE2T3h0VTRvTXk3V3E3VFNLN3gz?=
 =?utf-8?B?M0ZyeDUyTkFSMzhrWWUyV0NkRDdBcWUvKy9RZ1pCVEFta25Wd3EvRDlkaGpP?=
 =?utf-8?B?WE1XM2szMWN0ZnFHNHZNcnlWZE11djZlOFBMMG9qNzIwTGY2MnoxNGc2N2Rq?=
 =?utf-8?B?U3NVdDZHb20vMkdUTVhhZ2ZsQ0pQS0dyS2ptb3FYUFRiRkU5eDdObTVkcFpT?=
 =?utf-8?B?b1BURG9LdHhMVVRZT3d1WS9zN1d3bm1TWlFhYUJERGhxbDAzb1J0Q2N0V2hr?=
 =?utf-8?B?NXBiRXp0YVpHQWpoVEZGWE1iVXlNM0lDYW5QL09aOE5MMktldUdVWmFuejdu?=
 =?utf-8?B?djhlWDQrdGZxaUdlNGY1b0k3bUk5YWFqZW1aR2did1hGQkpYL2x4cjZwS0Nk?=
 =?utf-8?B?VVEyN2N3bVF4a2NnclM1dE1sNEZWTkhET0dCWm8yY2VxUTBjSXRRVkg4V2pJ?=
 =?utf-8?B?QXRIQ3RQSG9jM0gzN3NYVXYwUGZMK0c1OTJUOElmWlhYbmFGK0FLSVZWakFH?=
 =?utf-8?B?N25oR2srdGJXT3FPUVIzWUpjbTYybUN4MVpXOVZMYUJ6YW1qaWEvMGR3S2RE?=
 =?utf-8?B?TTN3L1JHSVBIVkg0bTlVdE5SYyt3bXVPdUFZUkE0Tm9LbkhlSFgzV3JxRmZI?=
 =?utf-8?B?c0dJQUI0UVVuV0pRTVFMRTVOU0wwd1FDbE92dFdiL0hvWnYyQWh0RTd3V2kw?=
 =?utf-8?B?dzJCa21NOU43T1dRcW9aZUhUTG10TzhRYmVqM0ZSQmRrM0tScHhwR01tbmc3?=
 =?utf-8?B?R2EzaE44TXV1VTlxOVJJUC9kbk5JRk1PM05DYW1XNTVhYlFBVFV3UndSVGR6?=
 =?utf-8?B?ay9PNE05MEtBQU5aSDFDSHZmSGtqcjhoUjFJZzBIUmJBai92Z0Z2ZUljd3pE?=
 =?utf-8?B?cFFLUmdKUzlvQll2eGxZc0c2Y0hmMHp0dzZFSnZzWHM5Uk5jMmZDRkM0c29l?=
 =?utf-8?Q?hd+hLUPmt4Dvjw8XZzQ9dr7Mw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ec3d17-d019-4c69-7408-08dbfd0191ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 00:05:38.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/EEmz6+R7sElX4reo9d9kzZt+L6e2jWlX0VhO4YcwPXolRWCRfSa8zOFOoFKFUn+0/v6h5x1Y1PHw0B9e6JQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

On 12/11/2023 9:18 AM, edward.cree@amd.com wrote:
> 
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Expose each RX queue's core RXQ association, and the read/write/etc
>   pointers for the descriptor ring.
> Each RXQ dir also symlinks to its owning channel.
> 
> Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>   drivers/net/ethernet/sfc/debugfs.c    | 69 ++++++++++++++++++++++++++-
>   drivers/net/ethernet/sfc/debugfs.h    | 15 ++++++
>   drivers/net/ethernet/sfc/net_driver.h |  6 +++
>   drivers/net/ethernet/sfc/rx_common.c  |  9 ++++
>   4 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/debugfs.c b/drivers/net/ethernet/sfc/debugfs.c
> index b46339249794..43b1d06a985e 100644
> --- a/drivers/net/ethernet/sfc/debugfs.c
> +++ b/drivers/net/ethernet/sfc/debugfs.c
> @@ -78,6 +78,72 @@ void efx_update_debugfs_netdev(struct efx_nic *efx)
>          mutex_unlock(&efx->debugfs_symlink_mutex);
>   }
> 
> +#define EFX_DEBUGFS_RXQ(_type, _name)  \
> +       debugfs_create_##_type(#_name, 0444, rx_queue->debug_dir, &rx_queue->_name)
> +
> +/* Create basic debugfs parameter files for an Efx RXQ */
> +static void efx_init_debugfs_rx_queue_files(struct efx_rx_queue *rx_queue)
> +{
> +       EFX_DEBUGFS_RXQ(u32, core_index); /* actually an int */
> +       /* descriptor ring indices */
> +       EFX_DEBUGFS_RXQ(u32, added_count);
> +       EFX_DEBUGFS_RXQ(u32, notified_count);
> +       EFX_DEBUGFS_RXQ(u32, granted_count);
> +       EFX_DEBUGFS_RXQ(u32, removed_count);
> +}
> +
> +/**
> + * efx_init_debugfs_rx_queue - create debugfs directory for RX queue
> + * @rx_queue:          Efx RX queue
> + *
> + * Create a debugfs directory containing parameter-files for @rx_queue.
> + * The directory must be cleaned up using efx_fini_debugfs_rx_queue(),
> + * even if this function returns an error.
> + *
> + * Return: a negative error code or 0 on success.
> + */
> +int efx_init_debugfs_rx_queue(struct efx_rx_queue *rx_queue)
> +{
> +       struct efx_channel *channel = efx_rx_queue_channel(rx_queue);
> +       char target[EFX_DEBUGFS_NAME_LEN];
> +       char name[EFX_DEBUGFS_NAME_LEN];
> +
> +       if (!rx_queue->efx->debug_queues_dir)
> +               return -ENODEV;
> +       /* Create directory */
> +       if (snprintf(name, sizeof(name), "rx-%d", efx_rx_queue_index(rx_queue))

Adding leading 0's here can be helpful for directory entry sorting

> +           >= sizeof(name))
> +               return -ENAMETOOLONG;
> +       rx_queue->debug_dir = debugfs_create_dir(name,
> +                                                rx_queue->efx->debug_queues_dir);
> +       if (!rx_queue->debug_dir)
> +               return -ENOMEM;
> +
> +       /* Create files */
> +       efx_init_debugfs_rx_queue_files(rx_queue);
> +
> +       /* Create symlink to channel */
> +       if (snprintf(target, sizeof(target), "../../channels/%d",
> +                    channel->channel) >= sizeof(target))
> +               return -ENAMETOOLONG;
> +       if (!debugfs_create_symlink("channel", rx_queue->debug_dir, target))
> +               return -ENOMEM;

If these fail, should you clean up the earlier create_dir()?


> +
> +       return 0;
> +}
> +
> +/**
> + * efx_fini_debugfs_rx_queue - remove debugfs directory for RX queue
> + * @rx_queue:          Efx RX queue
> + *
> + * Remove directory created for @rx_queue by efx_init_debugfs_rx_queue().
> + */
> +void efx_fini_debugfs_rx_queue(struct efx_rx_queue *rx_queue)
> +{
> +       debugfs_remove_recursive(rx_queue->debug_dir);
> +       rx_queue->debug_dir = NULL;
> +}
> +
>   #define EFX_DEBUGFS_CHANNEL(_type, _name)      \
>          debugfs_create_##_type(#_name, 0444, channel->debug_dir, &channel->_name)
> 
> @@ -208,9 +274,10 @@ int efx_init_debugfs_nic(struct efx_nic *efx)
>          if (!efx->debug_dir)
>                  return -ENOMEM;
>          efx_init_debugfs_nic_files(efx);
> -       /* Create channels subdirectory */
> +       /* Create subdirectories */
>          efx->debug_channels_dir = debugfs_create_dir("channels",
>                                                       efx->debug_dir);
> +       efx->debug_queues_dir = debugfs_create_dir("queues", efx->debug_dir);
>          return 0;
>   }
> 
> diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
> index 4af4a03d1b97..53c98a2fb4c9 100644
> --- a/drivers/net/ethernet/sfc/debugfs.h
> +++ b/drivers/net/ethernet/sfc/debugfs.h
> @@ -28,11 +28,20 @@
>    * * "channels/" (&efx_nic.debug_channels_dir).  For each channel, this will
>    *   contain a directory (&efx_channel.debug_dir), whose name is the channel
>    *   index (in decimal).
> + * * "queues/" (&efx_nic.debug_queues_dir).
> + *
> + *   * For each NIC RX queue, this will contain a directory
> + *     (&efx_rx_queue.debug_dir), whose name is "rx-N" where N is the RX queue
> + *     index.  (This may not be the same as the kernel core RX queue index.)
> + *     The directory will contain a symlink to the owning channel.
>    */
> 
>   void efx_fini_debugfs_netdev(struct net_device *net_dev);
>   void efx_update_debugfs_netdev(struct efx_nic *efx);
> 
> +int efx_init_debugfs_rx_queue(struct efx_rx_queue *rx_queue);
> +void efx_fini_debugfs_rx_queue(struct efx_rx_queue *rx_queue);
> +
>   int efx_init_debugfs_channel(struct efx_channel *channel);
>   void efx_fini_debugfs_channel(struct efx_channel *channel);
> 
> @@ -48,6 +57,12 @@ static inline void efx_fini_debugfs_netdev(struct net_device *net_dev) {}
> 
>   static inline void efx_update_debugfs_netdev(struct efx_nic *efx) {}
> 
> +int efx_init_debugfs_rx_queue(struct efx_rx_queue *rx_queue)
> +{
> +       return 0;
> +}
> +void efx_fini_debugfs_rx_queue(struct efx_rx_queue *rx_queue) {}
> +
>   int efx_init_debugfs_channel(struct efx_channel *channel)
>   {
>          return 0;
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 2b92c5461fe3..63eb32670826 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -424,6 +424,10 @@ struct efx_rx_queue {
>          struct work_struct grant_work;
>          /* Statistics to supplement MAC stats */
>          unsigned long rx_packets;
> +#ifdef CONFIG_DEBUG_FS
> +       /** @debug_dir: Queue debugfs directory (under @efx->debug_queues_dir) */
> +       struct dentry *debug_dir;
> +#endif
>          struct xdp_rxq_info xdp_rxq_info;
>          bool xdp_rxq_info_valid;
>   };
> @@ -1150,6 +1154,8 @@ struct efx_nic {
>          struct dentry *debug_dir;
>          /** @debug_channels_dir: contains channel debugfs dirs.  Under @debug_dir */
>          struct dentry *debug_channels_dir;
> +       /** @debug_queues_dir: contains RX/TX queue debugfs dirs.  Under @debug_dir */
> +       struct dentry *debug_queues_dir;
>          /** @debug_symlink: NIC debugfs symlink (``nic_eth%d``) */
>          struct dentry *debug_symlink;
>          /** @debug_interrupt_mode: debugfs details for printing @interrupt_mode */
> diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
> index d2f35ee15eff..7f63f70f082d 100644
> --- a/drivers/net/ethernet/sfc/rx_common.c
> +++ b/drivers/net/ethernet/sfc/rx_common.c
> @@ -14,6 +14,7 @@
>   #include "efx.h"
>   #include "nic.h"
>   #include "rx_common.h"
> +#include "debugfs.h"
> 
>   /* This is the percentage fill level below which new RX descriptors
>    * will be added to the RX descriptor ring.
> @@ -208,6 +209,12 @@ int efx_probe_rx_queue(struct efx_rx_queue *rx_queue)
>          if (!rx_queue->buffer)
>                  return -ENOMEM;
> 
> +       rc = efx_init_debugfs_rx_queue(rx_queue);
> +       if (rc) /* not fatal */
> +               netif_err(efx, drv, efx->net_dev,
> +                         "Failed to create debugfs for RXQ %d, rc=%d\n",
> +                         efx_rx_queue_index(rx_queue), rc);
> +
>          rc = efx_nic_probe_rx(rx_queue);
>          if (rc) {
>                  kfree(rx_queue->buffer);
> @@ -311,6 +318,8 @@ void efx_remove_rx_queue(struct efx_rx_queue *rx_queue)
> 
>          efx_nic_remove_rx(rx_queue);
> 
> +       efx_fini_debugfs_rx_queue(rx_queue);
> +
>          kfree(rx_queue->buffer);
>          rx_queue->buffer = NULL;
>   }
> 

