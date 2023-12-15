Return-Path: <netdev+bounces-57698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CC8813E87
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5297B283D48
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 00:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC7A4D;
	Fri, 15 Dec 2023 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vAczPK5f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71BA4C
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+2rFPGd+7X+mFrHuGDu1waSpN4splm20YMBBNpzoFtOpFUOFU7h0jKdDrZJK0fZpdq5294hBx4MoBO/XogO3owNiObg9tOomlma5SPqY7sC64Viz/jQevJl423UTjT/vbnrc3Gad1W+aJscgb4HUwlp/hDy8lajQ7ld+hDDnEIXFGD6zjsEW5kmTNlKVgX7pe+9PzANOH5u5XKf7TxkLNK5gizcdo6rLQYBwbb4k9ijnJ7maebXf4u1UuyTMrETWHgocIphZKmW4gpjtDvPynk5WU72J5xh3lka+cyRr9QBcVs5Djq9WQDYh60sGMzYg10c8jIURgpfhVof1myXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l967id/EkKhM0om4/5W6m/zxJcRbLqU9LbkCastmtGg=;
 b=k/Q45THoUtzjeEmlhXY6SGVFDrNA60V2rZbab5ZqsAn5lYT+ULfzrsIae0a4J62C5/EP+ZC40JgroKid/NTLC8F9VP7wcaQz0WnkhTQaEMAqayMFu0HaeoV/OPDI+9MJRjdDxBxy/SPNMf+8LGz27sN190hZ6d6ePl9pKfp6u6wsA8t3J58weYJJKWepA/RFAiYk3H4ueHVNt5nZHMFysbBsfPF1qbkIWIi/3Yj+Bzxjj1u/pd36UAQveq5An2LEs0zm2QNGxtj+zu5HltPUO2Cps8LfHK0d5voDIai4EZAaVk/+mm5o0OcAM3DYBf4oS8xVdLuva8VmeG7Mnv9EQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l967id/EkKhM0om4/5W6m/zxJcRbLqU9LbkCastmtGg=;
 b=vAczPK5f4URyy48dVMqYhC6uReDwfxncw3oHecDPtOISzCj+D6xTVGZvt3hWrQJMa8L82Xh4NraqG0OWf4bMGFEF/NS/llfrG4UE92jHvw8tlaBgzX4gLshKXkdf7FcYMQ1hW/eLS85xPYgZrNuu2Km5PgOvR/lF0PGHcyuu5gA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 00:05:46 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 00:05:46 +0000
Message-ID: <ed7a2ffa-bfc9-4276-8776-89cafa546ef8@amd.com>
Date: Thu, 14 Dec 2023 16:05:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] sfc: add debugfs entries for filter table
 status
Content-Language: en-US
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <fc28d967fbffd53f61a1d42332ee7bc64435df7c.1702314695.git.ecree.xilinx@gmail.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <fc28d967fbffd53f61a1d42332ee7bc64435df7c.1702314695.git.ecree.xilinx@gmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: 72987124-f509-4e02-692f-08dbfd01966f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8iL7q2B0FyH+5wEcby4JkIzHn1qGTDEKJfrtNkYrJ2Uc1zDAYhdiKIA6SAIkfnKo+5BSJpm6HJX58UDKfoG6/c0zxCztIkYcrarFLM7pMcuQRV1DnO7k89KRXkwZerAEV7kqZZ11eM/NYtyDDIFuSt21OhLXFAh2NzfHZuhkQvgLIDYAIrfUZVhd/Txq2xoYxIAscY7jYuBMJ+SEoPqzfLgW+h3i+Aw2jn7wmueDTrPi6nMlrxmlyQ6Al0NJtORTUCG/if+gPJ/fdQ1Mkyl8X0pOpq2MU7LFX3xgm7D52dv/iOeME7UvhCQcSIw/GaRpfXZtVs8NNPyQjqmYP9QJg1psYr/dx87niSQ1h3kayTGkKeVkhR8ehOEUjHu+MD1S9fzuECyN+AxkYcp73a5ARGnBLkqtWOhn2Ld2oBiOrB77DwUKSN9Y8K3gj5yXaq1vjqqx8zHppjfNjf5hXzUc7PFyNXY1CBpqiajB1qOcNFAme+IcfDMLqx93ipr6/pYBZ6cBySniueRVG8HlUUHtjz6C48wM1PndFwQPkwFwYn1cgAvCC0dD5sq80wn7quZo1nX3nmtND/ZELPUWfBqX/WYpIczK0Cm8CzZLOEGB4NZM9ObBJjc1j+bIhLl2GxsXu6n/nEyiYhHKWEvukIykQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(8936002)(8676002)(26005)(4326008)(5660300002)(83380400001)(86362001)(6506007)(53546011)(2906002)(6486002)(38100700002)(31696002)(36756003)(478600001)(41300700001)(31686004)(66946007)(66556008)(66476007)(54906003)(6512007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDdYNUYrcFVENUh5UmVLYkhjeDhNalBrZmRlWUlsL3l3QjN0SW80SkYwOHRx?=
 =?utf-8?B?WWVhZmc1VzFHa1AzV3R2Q1pGL241NHBwalFCQjV4MEt4RkFxUzVBZERWbzhG?=
 =?utf-8?B?R3IxZk9GVzEvZ3lHZ0tTNGgvcXlhOE51MjZoa0NhdlV4UUtYMWg3Tm9ydEEy?=
 =?utf-8?B?eklJU25BVEVVL0tPTW1PTzExcWcya2RRdGpHbEpqNElYQStUdmZLOXZPQkZI?=
 =?utf-8?B?cmRJa080eFNEOGlNSURjU1hKVDlvM09zcktCT1oyWDhUNkNTSmlwbWF3MCts?=
 =?utf-8?B?RW1JVUF1NDVPekU4VzVZaStGOHZCS0g2bzM5TktreWhFRW5WMFpzSG4vbjhi?=
 =?utf-8?B?aFhNWUtwMFVMZy9xM2RrYjBlcURLbGhhVnFXVFFNYVdmcHJFazlianVTS0Vs?=
 =?utf-8?B?NnBZYmVZMmlkMW5ab0l5SVJCeTNjVSswMitkaHY4TmY2bEE3THUvTktzSjZ4?=
 =?utf-8?B?N2lhQWR6RWE2bEVPT1oxSE4rZUhOc2xiVFN2aDN6bHRkUytUc0c3NEFsQ1RG?=
 =?utf-8?B?M2pGSG1ocm4yczFiZFpGQ2hqUnpRWmYrNDhmNzlXZ0F4Z3huZGMzRVNSMFBz?=
 =?utf-8?B?UGFsNUNqSmtRMGlRVm1Zc0puZDRrVGxpdW1rMXNZMzdnTElWa2VveUs2anIx?=
 =?utf-8?B?QU9NY0wzM1RONHIyTHVlOUdxdnVBSUthVVpXdGlCYlJxOWlWTXZ0aXhadXRG?=
 =?utf-8?B?UHJMVjVHTzR5aktmV21QVE9CMjdNWGs1UjZxajBnbllQdXd2UXg5d3hkaVpu?=
 =?utf-8?B?WkJTaGNpWk9Kdk00VE93RFdkYStUYmFSRGVaVFNOcG1CeUxhdHRuLzVGaG5E?=
 =?utf-8?B?ODVNSkpNb2hZd04yTzlxNHlDd3NtUitiZ1RRNDRJUGlpZFE1TDdVSmxuMXRN?=
 =?utf-8?B?K29WUzB5WGU1YmZkbjZWM0JlZlByaWN4eFJOcjNjdHNvcXp4QzgyamtPWnVB?=
 =?utf-8?B?Q1QrTFRYYU5sWjBtT1hObDkyQlZMaCt2a3N6d0ZibVFFeVpUcWpnSmNyRjBE?=
 =?utf-8?B?TG5ndHVsSFd3cGs1eXRUdlQyQUZDVUNlenVuWjgwTVFZZXpCbEtxWVFvYm9M?=
 =?utf-8?B?clVvcjJqSGVocEpnVUM3NHhwU2NENjdxcXZDYXJQakJDZmZaMGt4aXlmT1g5?=
 =?utf-8?B?OXFFT3lrK0N4WDJZQlRGT3FJTXFPZU5uTlJZTkUyZXdVclVCdHgrdjdFL2xT?=
 =?utf-8?B?Y2grODQrTFFJcXZydnlYcmthcThaMUZHSThIMSsxTHlWZGhndVRYOEJOb1ph?=
 =?utf-8?B?S1Z5VVYvNlhFWm1uTU1aUjM3SUtKUnczTWlwSUJ0VkxiTkR5bHFYY2hnUWNP?=
 =?utf-8?B?VGZaRU5aKzBtUjE3Sktja1hmWjJQWUptdWh6TjI2cHZmNE1zWXFmY0R1MEVN?=
 =?utf-8?B?R0l6dUVUbUxrZU9GbHppQTB6cUlDME5vMWJqOWlYbVVMVjlqdUQ5VGtaUWh3?=
 =?utf-8?B?TGtIYVRDb0UrUzBiS0Y1Qk5wNldUdFY3WU9ILzlUWFlhN0RUNGxIbkN2YWxs?=
 =?utf-8?B?cUZwamI1RllSQ3dLUnIzbjUxbS9Gb2JKREEvMFlsSE8wOE02MnB5R2FsM2ZF?=
 =?utf-8?B?K0VRTFZ2SFhJMUZYR2lVRkhUWmVpRlo5Z1VEWlhHaUdtRmhOOWthM0xGVkQr?=
 =?utf-8?B?NWFoS2dDVFRKYTIvSzQwSFkwWG9qdCtwZWF4UkhSL0k3U210Zm9Ka0UxOTB6?=
 =?utf-8?B?bitXbnZmMmFRM3NzTTExekl5bllFbzhMV1hXSEIrSmJrRWw1ZW5QNjl6eWts?=
 =?utf-8?B?cUg3UGRpRG84MVlXQWFBVmlvN1IxQnh0NzcyaStWb1ZFS0ZhNXdZSEpGOHlN?=
 =?utf-8?B?OE56emxkdlNPaFhHL0xSanhybUdMQVdBOEhRa0xseDBRcXk5QXI5Mlo5WlBq?=
 =?utf-8?B?d0JNaE5aczRRVUJxRU1BaDdQMTdhQ2xCeDhyOXZwVG85R3BXZ1FkS3JERDli?=
 =?utf-8?B?Z0NqcTFuK0paaUgwdE9aMzBHbmtyQmQ3RTh1UXUvS0hKS0hsZUQ4Y0M2ZCtJ?=
 =?utf-8?B?TnVIK29ITU0yOU1WbW5LM1NpVTN4cmhPQ05NVmlJOGJtbzZPL2ZDZzVtRGMr?=
 =?utf-8?B?TmRKb1hmUWFSN09xL3lOdGlzMTk2OG1qUmVKNWs4dXE5cnFxMVFWQlVpY2NC?=
 =?utf-8?Q?gBS8AmjRE5yAAS8mkSko8Nkfk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72987124-f509-4e02-692f-08dbfd01966f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 00:05:46.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsM5+zuqr65DWRzOBxJj0fnp+fYTtRIDixb/rnUs1P5RZCu1QBwq3TtOQIO/VtUXN7bNcmnKjqtWUt+rffDTMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

On 12/11/2023 9:18 AM, edward.cree@amd.com wrote:
> 
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Filter table management is complicated by the possibility of overflow
>   kicking us into a promiscuous fallback for either unicast or multicast.
>   Expose the internal flags that drive this.
> Since the table state (efx->filter_state) has a separate, shorter
>   lifetime than struct efx_nic, put its debugfs nodes in a subdirectory
>   (efx->filter_state->debug_dir) so that they can be cleaned up easily
>   before the filter_state is freed.
> 
> Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>   drivers/net/ethernet/sfc/debugfs.h      |  4 ++++
>   drivers/net/ethernet/sfc/mcdi_filters.c | 18 ++++++++++++++++++
>   drivers/net/ethernet/sfc/mcdi_filters.h |  4 ++++
>   3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
> index 3e8d2e2b5bad..7a96f3798cbd 100644
> --- a/drivers/net/ethernet/sfc/debugfs.h
> +++ b/drivers/net/ethernet/sfc/debugfs.h
> @@ -39,6 +39,10 @@
>    *     index.  (This may differ from both the kernel core TX queue index and
>    *     the hardware queue label of the TXQ.)
>    *     The directory will contain a symlink to the owning channel.
> + *
> + * * "filters/" (&efx_mcdi_filter_table.debug_dir).
> + *   This contains parameter files for the NIC receive filter table
> + *   (@efx->filter_state).
>    */
> 
>   void efx_fini_debugfs_netdev(struct net_device *net_dev);
> diff --git a/drivers/net/ethernet/sfc/mcdi_filters.c b/drivers/net/ethernet/sfc/mcdi_filters.c
> index 4ff6586116ee..a4ab45082c8f 100644
> --- a/drivers/net/ethernet/sfc/mcdi_filters.c
> +++ b/drivers/net/ethernet/sfc/mcdi_filters.c
> @@ -1348,6 +1348,20 @@ int efx_mcdi_filter_table_probe(struct efx_nic *efx, bool multicast_chaining)
>          INIT_LIST_HEAD(&table->vlan_list);
>          init_rwsem(&table->lock);
> 
> +#ifdef CONFIG_DEBUG_FS
> +       table->debug_dir = debugfs_create_dir("filters", efx->debug_dir);
> +       debugfs_create_bool("uc_promisc", 0444, table->debug_dir,
> +                           &table->uc_promisc);
> +       debugfs_create_bool("mc_promisc", 0444, table->debug_dir,
> +                           &table->mc_promisc);
> +       debugfs_create_bool("mc_promisc_last", 0444, table->debug_dir,
> +                           &table->mc_promisc_last);
> +       debugfs_create_bool("mc_overflow", 0444, table->debug_dir,
> +                           &table->mc_overflow);
> +       debugfs_create_bool("mc_chaining", 0444, table->debug_dir,
> +                           &table->mc_chaining);
> +#endif

It would be good to continue the practice of using the debugfs_* 
primitives in your debugfs.c and just make a single call here that 
doesn't need the ifdef

> +
>          efx->filter_state = table;
> 
>          return 0;
> @@ -1518,6 +1532,10 @@ void efx_mcdi_filter_table_remove(struct efx_nic *efx)
>                  return;
> 
>          vfree(table->entry);
> +#ifdef CONFIG_DEBUG_FS
> +       /* Remove debugfs entries pointing into @table */
> +       debugfs_remove_recursive(table->debug_dir);
> +#endif
>          kfree(table);
>   }
> 
> diff --git a/drivers/net/ethernet/sfc/mcdi_filters.h b/drivers/net/ethernet/sfc/mcdi_filters.h
> index c0d6558b9fd2..897843ade3ec 100644
> --- a/drivers/net/ethernet/sfc/mcdi_filters.h
> +++ b/drivers/net/ethernet/sfc/mcdi_filters.h
> @@ -91,6 +91,10 @@ struct efx_mcdi_filter_table {
>          bool vlan_filter;
>          /* Entries on the vlan_list are added/removed under filter_sem */
>          struct list_head vlan_list;
> +#ifdef CONFIG_DEBUG_FS
> +       /* filter table debugfs directory */
> +       struct dentry *debug_dir;
> +#endif
>   };
> 
>   int efx_mcdi_filter_table_probe(struct efx_nic *efx, bool multicast_chaining);
> 

