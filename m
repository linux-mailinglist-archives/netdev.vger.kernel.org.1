Return-Path: <netdev+bounces-57696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4DA813E84
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF828B21A92
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 00:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70447170;
	Fri, 15 Dec 2023 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f7T8X2ki"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9DA19B
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLzI5KcR66gPBnlWUlC48JipjhOFXAPZZGOfD8sKUpVcytCWw3s0kaf7uCtfanRBG0r2Vb2IHCe99zW480ux56dlQcnl7c0aHDE/AE+HXvpJKio+0J2w2jMHKPVIcjpHaHZdL5M6mDKO5RJlFHAb9eMLz13r01w4opW1GPnnwgr8cIdEykvq+kDs1CM8VSd621L+cPZmFQqv3BLx9FDVgU5vHmhhyQpx6J3ybyfjRGN6T3p7YnPUyu7+02/j+9FiKuw0Q8yvLBoojcH8HBGtYjffNC0YML0qOB8sFIC++h9n5ROdwIYQrMFTo/bc4h6banNCd9hmxQXWZC3jn2VIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTLVgF0hkVtkUjLhEyrO5z/MahYhL81Th5TvFKBTiTw=;
 b=fYDMxG7Iwza5N0TFmas4P+jLV8Jl2p6RG7/719mluVNpj08LRwiAG4CoH6LzecX5k+5tqkaSE3+PLR00A78bwOInQqafdcmOh8wjLMlSHPaJ9KZSbKWknS9SrRv5Vph/l8+6qLiOHhsC3FbhdXpp0g/isMDN6JQabIV5y6GzYPHz5b4F7DvULxs2OycNO4VzCVyqC2D7jlzTRkaMWiidIZZ1GCdsDoxCIrqEeXFURdzJoXuewbbUo0XKm1o+DVo8jpmzIir7KEE67hxDe7sfn6jihbhQyZysEzJX3lE5HJOPLc3kITs5tlh4yBmfJs7FG9WHU49XmMzEEdgzRHsnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTLVgF0hkVtkUjLhEyrO5z/MahYhL81Th5TvFKBTiTw=;
 b=f7T8X2kirZ6HyWUIngayMW/O1M0sApPsKOkK7h4wzUj/oYJrq/CuMWlfCXuF/MT2wAHPSCommL15lWP0Vg0solycsFa4Otb1+B30ZARPcxrbEFgUxH2hmm/QhYJzMgmgsUmbNRiKciOMUPKcmAK4L9gfNVxHf5ekfUavaCDWfUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 00:05:30 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 00:05:30 +0000
Message-ID: <182a168b-2898-4517-b2b9-8ef93ef72292@amd.com>
Date: Thu, 14 Dec 2023 16:05:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] sfc: initial debugfs implementation
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <9454bbffe8de24c0afcc6b307057e927ffaec6ca.1702314695.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <9454bbffe8de24c0afcc6b307057e927ffaec6ca.1702314695.git.ecree.xilinx@gmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: 498c622d-5bd3-4d52-c1cd-08dbfd018cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MiCQycb+TUX8haHuG+8uQr1CGG5x6TH7zvC3uJf+kv6cNMJum01CF1dvtETRFwH44eKypAIo9FSbrp7DnCr5XupuGcGzIBzyLfFEWuCBHvYO9BVBQ94fweJDQeCLjOIJlLzJobIJq+fC8f7TN2N5fl4hzKTZ+tW4jrZEuRLcJ8Oh14oU/B/4S0IDOXne7KO3zaPFDhy39TviZ580Kga9o4+aK3HVgzaMc1xipAeMWTRF0HccYs1XKh6RTxtiaoz8sXAvnc+Wx5tOPT8ETDkaliYYY9Wmh9p2uylyp3MvADQSP88GI4Ba7YJbwG2EfXMy2cn0BkmmraLDal5szNoLkl+4gwaLBUTty+mb/S36yFYQCQzzcLjoVWLQO0hfG17BTqi+3ZBcvqdmp9LTKdyPQi0eugnYCfsz0gWMGYLgbZLnUZJ/KZxwwFVZqCvvvsy94PZbt1NxO2lXp7LWRCPUuTyzgK1bdjxd/BbgT7+omUwCjitS5/ww8xgzZh/fQ/T/pM/HFnp+q+0J5sEDeJ5ohUfBrbgIdayJVKSKDysIN6wnpT3ikNRaso53QzRNwcKlEIixYSRu27gMoM+TcrphYYb6NBhjxE+1BwOAe2Sf2+zGPQwqqF/2gZlJi2u/ID/dBMZpjZU7msFKPEbZIrL5pwOkzkwuVFwfUaAlH0QDQXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(8936002)(8676002)(26005)(4326008)(5660300002)(83380400001)(86362001)(6506007)(53546011)(2906002)(6666004)(6486002)(38100700002)(31696002)(36756003)(478600001)(41300700001)(31686004)(66946007)(66556008)(66476007)(30864003)(54906003)(6512007)(316002)(2004002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTJyNDg2enUvZjV1M25ERm51T0dLQ0NuUFBBUlFrQTg0OFowbmlEb2pZMXhK?=
 =?utf-8?B?c0lWOUsxd0wwcEZPSTNIR050aWFLZ1FMS2xXcWJ6U3I1ek1nWG5lcndEaTBJ?=
 =?utf-8?B?RnpmM1F6YVY3eW1SWUt2S0VDQ05hUnhZSFdrNnArZ2IzYmJaS21vSE1uRWVj?=
 =?utf-8?B?aC9ZeGdsNEk0M2Nvbnd1TDY0QytaTVZGVzBaZWFIUncyZXNqY01JT1NxdTM0?=
 =?utf-8?B?dFZaL1VLbS9XMFN0MTRYWnhZbEdWemk1N3RhK2RzQXZaU3hBVCs2Q3MyRWVU?=
 =?utf-8?B?MHM0c0VWeXFIaWk2OSthKzB3eHd6bEZLdUdNQTN5RE9HNEhrajl5SExMLzFh?=
 =?utf-8?B?azRBYjVacWFlWVJYSFcxdHdOT0ptVFMwVUhrekxSdFVXd1BUc200K3Q3VWNN?=
 =?utf-8?B?clpCV1daZ3VUVU9tcVcxRkV4MlJ1dERFTGRZa2pXV2NiSzlXYjhDZVpTVkN4?=
 =?utf-8?B?T29GZUp4clBXTi91WjAzUm1YOWovZG9aTk15d25YTVdhOFcyQURibURNZ21o?=
 =?utf-8?B?anlEZGRubHlZeUJrS2pBUWFwelZYMDMyYzlMUksrSDVnOExqYTkzektHRnRl?=
 =?utf-8?B?RmZoVVN3anBxUDNPd2tBNDFXK2VkNFRocWd0NUxMTkwydTJSSURRUlUwY2FR?=
 =?utf-8?B?d3VhUWQ5TEZHRVNKL2NtRHFRclIwYlBEU0lCbmRDTytLODUyNzYvaThKREg4?=
 =?utf-8?B?UTFxejdkWmpnU1pvcDlhTDBsREpBNDNXUk93eXVVU0VlcEUxRGpNZExQMVVy?=
 =?utf-8?B?T1dFWmIwMkcybGM4MUlSZm1BYXFGd08zMjlRcytISWpBT0ZxRlJiUnpuTTBB?=
 =?utf-8?B?V0lpZHNjR29nN3FjT2F0bURCNC9od1ZaK3lDSmFGWGg3T2NOQmpjWmM2Q0Zm?=
 =?utf-8?B?NUUwSm8rU0tQSWgrUmRzWE1YY2NURVoxTXRNODZJT0dxSlBUMTF4UHlTSEdZ?=
 =?utf-8?B?VWlTcFZQNjlraG1WaVVreG04d0dGeGJsTU9FYmFmdXVVOGEyTHp3VWdHRVpx?=
 =?utf-8?B?Yzg5K25tQjFSMkNwUWY1a2JTSHJ4T0RmOUJVM0pKVHNsYVBYakpGcDQwMXI2?=
 =?utf-8?B?UVhXTWlNVm9Rb1lNTjlXTTVZaEcxUDJ4cGxucEdOMTR1OCsyN3FHV3gzcDFO?=
 =?utf-8?B?WkF4eU96M2YwTXpNTml4RWZ3S1pqbzg2NDdWMWo2V0RaeHN4Y2JEeU9QMkZz?=
 =?utf-8?B?VHVML3liRDJQRGNkRlNEaTZTTGpDb3g2OG9JRys4NzZLa1E3aUJGc0hBdVg5?=
 =?utf-8?B?TjlidjBHV3Bheldvb280eHp5NFFuemM0d1BkdXBTbi9BVnlqVlZqR0dVUGhz?=
 =?utf-8?B?djR5UlNqQjFrYVJCWU5nV2JIcG1oUWR4L2pCaXhzWXFoemVZNUtwZ202eXIr?=
 =?utf-8?B?T2d0YlVyWUNGektoak9YN2EwdGF6S0hKYjhOcjRldEZucFJvb04zeW4rWFNT?=
 =?utf-8?B?NExMd08vbXcyVlkzdGxMWlVGQmJRS3Bmbjlib1JqSGJEaGp0YXljZUhpd3Nq?=
 =?utf-8?B?WE9HZFhjQnlGUjZtU3k1TVFyRE5CMUsrKzdScUFVSHRPMnZZbXRueEhKR0JN?=
 =?utf-8?B?WUw2UWZVNitIK2VuYWtrSXAxNlozNHo2WERMQVpKb2w1MWttQVdtR1Z1S25U?=
 =?utf-8?B?ZW8zeHcvNUIwUkx4VkErdXBqVnVORHBlbDFQTzZlWFo2T2UwYnFWRDFhaDY4?=
 =?utf-8?B?c3l3T3dzTksxYkpnMTFpTU0rT1hwRGI0U3dHbFdvSzdNTHpTZnN2dDQ2clV3?=
 =?utf-8?B?L285L1B3YWZwYUhhVEhtaHNDOExZa0huelh5bU1VL3dUWXdTdDVySTF0SnRY?=
 =?utf-8?B?WnBzSE9oZjgvcEFsMUR2SjlVOGVhcnU0b1NSQk5FMG82R3dod0pYd2k4RktF?=
 =?utf-8?B?YWlOZEhwNE5zMmhZSTFkbSt3Qk52bHRxOHhNQjVUSjBzVHZFUFUwNTNQZC9o?=
 =?utf-8?B?YS92K2w4SVJQUlczQU1kd09MS3RuWmlYazFTZ2J3bGVvc3pEdzBjVzlIWitI?=
 =?utf-8?B?d1VURG0xTG83MURqMTNJTjNhdXRFYzhQZFRTTkdDMjEwRzVjR3hyKzAxTUN4?=
 =?utf-8?B?MzNZWXZ6SWtIZEtzT1NzWWk3cWFvZTFGc0ZESitYNVlXbVFMQkhOaGNRU2Jv?=
 =?utf-8?Q?U6myAIVdJ8GGX7K+Iod4JH3AU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498c622d-5bd3-4d52-c1cd-08dbfd018cac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 00:05:30.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXHXtML56yi1I7dattpryBEsFUX8/bCzakLPFE8o7nZcqd8ReXApGvIzY7QTM3ruh+54AyxBlJlDLQFOvtOUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

On 12/11/2023 9:18 AM, edward.cree@amd.com wrote:
> 
> From: Edward Cree <ecree.xilinx@gmail.com>
> 

Hi Ed, a few minor nits I thought I'd call out.
Cheers,
sln

> Just a handful of nodes, including one enum with a string table for
>   pretty printing the values.

It would be nice to have a couple of example paths listed here

> 
> Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>   drivers/net/ethernet/sfc/Makefile       |   1 +
>   drivers/net/ethernet/sfc/debugfs.c      | 234 ++++++++++++++++++++++++
>   drivers/net/ethernet/sfc/debugfs.h      |  56 ++++++
>   drivers/net/ethernet/sfc/ef10.c         |  10 +
>   drivers/net/ethernet/sfc/ef100_netdev.c |   7 +
>   drivers/net/ethernet/sfc/ef100_nic.c    |   8 +
>   drivers/net/ethernet/sfc/efx.c          |  15 +-
>   drivers/net/ethernet/sfc/efx_common.c   |   7 +
>   drivers/net/ethernet/sfc/net_driver.h   |  29 +++
>   9 files changed, 366 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/sfc/debugfs.c
>   create mode 100644 drivers/net/ethernet/sfc/debugfs.h
> 
> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
> index 8f446b9bd5ee..1fbdd04dc2c5 100644
> --- a/drivers/net/ethernet/sfc/Makefile
> +++ b/drivers/net/ethernet/sfc/Makefile
> @@ -12,6 +12,7 @@ sfc-$(CONFIG_SFC_MTD) += mtd.o
>   sfc-$(CONFIG_SFC_SRIOV)        += sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>                              mae.o tc.o tc_bindings.o tc_counters.o \
>                              tc_encap_actions.o tc_conntrack.o
> +sfc-$(CONFIG_DEBUG_FS) += debugfs.o

Just as you are using #ifdef CONFIG_DEBUG_FS in your debugfs.h, you 
could use it in your debugfs.c and simply add the .o file to your sfc-y 
list here.

> 
>   obj-$(CONFIG_SFC)      += sfc.o
> 
> diff --git a/drivers/net/ethernet/sfc/debugfs.c b/drivers/net/ethernet/sfc/debugfs.c
> new file mode 100644
> index 000000000000..cf800addb4ff
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/debugfs.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + * Driver for Solarflare network controllers and boards
> + * Copyright 2023, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#include "debugfs.h"
> +#include <linux/module.h>
> +#include <linux/debugfs.h>
> +#include <linux/dcache.h>
> +#include <linux/seq_file.h>
> +
> +/* Maximum length for a name component or symlink target */
> +#define EFX_DEBUGFS_NAME_LEN 32
> +
> +/* Top-level debug directory ([/sys/kernel]/debug/sfc) */
> +static struct dentry *efx_debug_root;
> +
> +/* "cards" directory ([/sys/kernel]/debug/sfc/cards) */
> +static struct dentry *efx_debug_cards;
> +
> +/**
> + * efx_init_debugfs_netdev - create debugfs sym-link for net device
> + * @net_dev:           Net device
> + *
> + * Create sym-link named after @net_dev to the debugfs directories for the
> + * corresponding NIC.  The sym-link must be cleaned up using
> + * efx_fini_debugfs_netdev().
> + *
> + * Return: a negative error code or 0 on success.
> + */
> +static int efx_init_debugfs_netdev(struct net_device *net_dev)
> +{
> +       struct efx_nic *efx = efx_netdev_priv(net_dev);
> +       char target[EFX_DEBUGFS_NAME_LEN];
> +       char name[EFX_DEBUGFS_NAME_LEN];
> +
> +       if (snprintf(name, sizeof(name), "nic_%s", net_dev->name) >=
> +                       sizeof(name))
> +               return -ENAMETOOLONG;
> +       if (snprintf(target, sizeof(target), "cards/%s", pci_name(efx->pci_dev))
> +           >= sizeof(target))
> +               return -ENAMETOOLONG;
> +       efx->debug_symlink = debugfs_create_symlink(name,
> +                                                   efx_debug_root, target);
> +       if (IS_ERR_OR_NULL(efx->debug_symlink))
> +               return efx->debug_symlink ? PTR_ERR(efx->debug_symlink) :
> +                                           -ENOMEM;
> +
> +       return 0;
> +}
> +
> +/**
> + * efx_fini_debugfs_netdev - remove debugfs sym-link for net device
> + * @net_dev:           Net device
> + *
> + * Remove sym-link created for @net_dev by efx_init_debugfs_netdev().
> + */
> +void efx_fini_debugfs_netdev(struct net_device *net_dev)
> +{
> +       struct efx_nic *efx = efx_netdev_priv(net_dev);
> +
> +       debugfs_remove(efx->debug_symlink);
> +       efx->debug_symlink = NULL;
> +}
> +
> +/* replace debugfs sym-links on net device rename */
> +void efx_update_debugfs_netdev(struct efx_nic *efx)
> +{
> +       mutex_lock(&efx->debugfs_symlink_mutex);
> +       if (efx->debug_symlink)
> +               efx_fini_debugfs_netdev(efx->net_dev);
> +       efx_init_debugfs_netdev(efx->net_dev);
> +       mutex_unlock(&efx->debugfs_symlink_mutex);
> +}

How necessary is this netdev symlink?  This seems like a bunch of extra 
maintenance.

> +
> +static int efx_debugfs_enum_read(struct seq_file *s, void *d)
> +{
> +       struct efx_debugfs_enum_data *data = s->private;
> +       u64 value = 0;
> +       size_t len;
> +
> +       len = min(data->vlen, sizeof(value));
> +#ifdef BIG_ENDIAN
> +       /* If data->value is narrower than u64, we need to copy into the
> +        * far end of value, as that's where the low bits live.
> +        */
> +       memcpy(((void *)&value) + sizeof(value) - len, data->value, len);
> +#else
> +       memcpy(&value, data->value, len);
> +#endif
> +       seq_printf(s, "%#llx => %s\n", value,
> +                  value < data->max ? data->names[value] : "(invalid)");
> +       return 0;
> +}
> +
> +static int efx_debugfs_enum_open(struct inode *inode, struct file *f)
> +{
> +       struct efx_debugfs_enum_data *data = inode->i_private;
> +
> +       return single_open(f, efx_debugfs_enum_read, data);
> +}
> +
> +static const struct file_operations efx_debugfs_enum_ops = {
> +       .owner = THIS_MODULE,
> +       .open = efx_debugfs_enum_open,
> +       .release = single_release,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +};
> +
> +static void efx_debugfs_create_enum(const char *name, umode_t mode,
> +                                   struct dentry *parent,
> +                                   struct efx_debugfs_enum_data *data)
> +{
> +       debugfs_create_file(name, mode, parent, data, &efx_debugfs_enum_ops);
> +}
> +
> +static const char *const efx_interrupt_mode_names[] = {
> +       [EFX_INT_MODE_MSIX]   = "MSI-X",
> +       [EFX_INT_MODE_MSI]    = "MSI",
> +       [EFX_INT_MODE_LEGACY] = "legacy",
> +};
> +
> +#define EFX_DEBUGFS_EFX(_type, _name)  \
> +       debugfs_create_##_type(#_name, 0444, efx->debug_dir, &efx->_name)
> +
> +/* Create basic debugfs parameter files for an Efx NIC */
> +static void efx_init_debugfs_nic_files(struct efx_nic *efx)
> +{
> +       EFX_DEBUGFS_EFX(x32, rx_dma_len);
> +       EFX_DEBUGFS_EFX(x32, rx_buffer_order);
> +       EFX_DEBUGFS_EFX(x32, rx_buffer_truesize);
> +       efx->debug_interrupt_mode.max = ARRAY_SIZE(efx_interrupt_mode_names);
> +       efx->debug_interrupt_mode.names = efx_interrupt_mode_names;
> +       efx->debug_interrupt_mode.vlen = sizeof(efx->interrupt_mode);
> +       efx->debug_interrupt_mode.value = &efx->interrupt_mode;
> +       efx_debugfs_create_enum("interrupt_mode", 0444, efx->debug_dir,
> +                               &efx->debug_interrupt_mode);
> +}
> +
> +/**
> + * efx_init_debugfs_nic - create debugfs directory for NIC
> + * @efx:               Efx NIC
> + *
> + * Create debugfs directory containing parameter-files for @efx.
> + * The directory must be cleaned up using efx_fini_debugfs_nic().
> + *
> + * Return: a negative error code or 0 on success.
> + */
> +int efx_init_debugfs_nic(struct efx_nic *efx)
> +{
> +       /* Create directory */
> +       efx->debug_dir = debugfs_create_dir(pci_name(efx->pci_dev),
> +                                           efx_debug_cards);
> +       if (!efx->debug_dir)
> +               return -ENOMEM;
> +       efx_init_debugfs_nic_files(efx);
> +       return 0;
> +}
> +
> +/**
> + * efx_fini_debugfs_nic - remove debugfs directory for NIC
> + * @efx:               Efx NIC
> + *
> + * Remove debugfs directory created for @efx by efx_init_debugfs_nic().
> + */
> +void efx_fini_debugfs_nic(struct efx_nic *efx)
> +{
> +       debugfs_remove_recursive(efx->debug_dir);
> +       efx->debug_dir = NULL;
> +}
> +
> +/**
> + * efx_init_debugfs - create debugfs directories for sfc driver
> + *
> + * Create debugfs directories "sfc" and "sfc/cards".  This must be
> + * called before any of the other functions that create debugfs
> + * directories.  The directories must be cleaned up using
> + * efx_fini_debugfs().
> + *
> + * Return: a negative error code or 0 on success.
> + */
> +int efx_init_debugfs(void)
> +{
> +       int rc;
> +
> +       /* Create top-level directory */
> +       efx_debug_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +       if (!efx_debug_root) {
> +               pr_err("debugfs_create_dir %s failed.\n", KBUILD_MODNAME);
> +               rc = -ENOMEM;
> +               goto err;
> +       } else if (IS_ERR(efx_debug_root)) {
> +               rc = PTR_ERR(efx_debug_root);
> +               pr_err("debugfs_create_dir %s failed, rc=%d.\n",
> +                      KBUILD_MODNAME, rc);
> +               goto err;
> +       }
> +
> +       /* Create "cards" directory */
> +       efx_debug_cards = debugfs_create_dir("cards", efx_debug_root);
> +       if (!efx_debug_cards) {
> +               pr_err("debugfs_create_dir cards failed.\n");
> +               rc = -ENOMEM;
> +               goto err;
> +       } else if (IS_ERR(efx_debug_cards)) {
> +               rc = PTR_ERR(efx_debug_cards);
> +               pr_err("debugfs_create_dir cards failed, rc=%d.\n", rc);
> +               goto err;
> +       }
> +
> +       return 0;
> +
> +err:
> +       efx_fini_debugfs();
> +       return rc;
> +}
> +
> +/**
> + * efx_fini_debugfs - remove debugfs directories for sfc driver
> + *
> + * Remove directories created by efx_init_debugfs().
> + */
> +void efx_fini_debugfs(void)
> +{
> +       debugfs_remove_recursive(efx_debug_root);
> +       efx_debug_cards = NULL;
> +       efx_debug_root = NULL;
> +}
> diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
> new file mode 100644
> index 000000000000..1fe40fbffa5e
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/debugfs.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/****************************************************************************
> + * Driver for Solarflare network controllers and boards
> + * Copyright 2023, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#ifndef EFX_DEBUGFS_H
> +#define EFX_DEBUGFS_H
> +#include "net_driver.h"
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +/**
> + * DOC: Directory layout for sfc debugfs
> + *
> + * At top level ([/sys/kernel]/debug/sfc) are per-netdev symlinks "nic_$name"
> + * and the "cards" directory.  For each PCI device to which the driver has
> + * bound and created a &struct efx_nic, there is a directory &efx_nic.debug_dir
> + * in "cards" whose name is the PCI address of the device; it is to this
> + * directory that the netdev symlink points.
> + */
> +
> +void efx_fini_debugfs_netdev(struct net_device *net_dev);
> +void efx_update_debugfs_netdev(struct efx_nic *efx);
> +
> +int efx_init_debugfs_nic(struct efx_nic *efx);
> +void efx_fini_debugfs_nic(struct efx_nic *efx);
> +
> +int efx_init_debugfs(void);
> +void efx_fini_debugfs(void);
> +
> +#else /* CONFIG_DEBUG_FS */
> +
> +static inline void efx_fini_debugfs_netdev(struct net_device *net_dev) {}
> +
> +static inline void efx_update_debugfs_netdev(struct efx_nic *efx) {}
> +
> +static inline int efx_init_debugfs_nic(struct efx_nic *efx)
> +{
> +       return 0;
> +}
> +static inline void efx_fini_debugfs_nic(struct efx_nic *efx) {}
> +
> +static inline int efx_init_debugfs(void)
> +{
> +       return 0;
> +}
> +static inline void efx_fini_debugfs(void) {}
> +
> +#endif /* CONFIG_DEBUG_FS */
> +
> +#endif /* EFX_DEBUGFS_H */
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 6dfa062feebc..58e18fc92093 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
> @@ -19,6 +19,7 @@
>   #include "workarounds.h"
>   #include "selftest.h"
>   #include "ef10_sriov.h"
> +#include "debugfs.h"
>   #include <linux/in.h>
>   #include <linux/jhash.h>
>   #include <linux/wait.h>
> @@ -580,6 +581,13 @@ static int efx_ef10_probe(struct efx_nic *efx)
>          if (rc)
>                  goto fail3;
> 
> +       /* Populate debugfs */
> +#ifdef CONFIG_DEBUG_FS
> +       rc = efx_init_debugfs_nic(efx);
> +       if (rc)
> +               pci_err(efx->pci_dev, "failed to init device debugfs\n");
> +#endif

I don't think you need the ifdef here because you have the static 
version defined in debugfs.h

> +
>          rc = device_create_file(&efx->pci_dev->dev,
>                                  &dev_attr_link_control_flag);
>          if (rc)
> @@ -693,6 +701,7 @@ static int efx_ef10_probe(struct efx_nic *efx)
>   fail4:
>          device_remove_file(&efx->pci_dev->dev, &dev_attr_link_control_flag);
>   fail3:
> +       efx_fini_debugfs_nic(efx);
>          efx_mcdi_detach(efx);
> 
>          mutex_lock(&nic_data->udp_tunnels_lock);
> @@ -962,6 +971,7 @@ static void efx_ef10_remove(struct efx_nic *efx)
>          device_remove_file(&efx->pci_dev->dev, &dev_attr_link_control_flag);
> 
>          efx_mcdi_detach(efx);
> +       efx_fini_debugfs_nic(efx);
> 
>          memset(nic_data->udp_tunnels, 0, sizeof(nic_data->udp_tunnels));
>          mutex_lock(&nic_data->udp_tunnels_lock);
> diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
> index 7f7d560cb2b4..e844d57754b7 100644
> --- a/drivers/net/ethernet/sfc/ef100_netdev.c
> +++ b/drivers/net/ethernet/sfc/ef100_netdev.c
> @@ -26,10 +26,12 @@
>   #include "tc_bindings.h"
>   #include "tc_encap_actions.h"
>   #include "efx_devlink.h"
> +#include "debugfs.h"
> 
>   static void ef100_update_name(struct efx_nic *efx)
>   {
>          strcpy(efx->name, efx->net_dev->name);
> +       efx_update_debugfs_netdev(efx);
>   }
> 
>   static int ef100_alloc_vis(struct efx_nic *efx, unsigned int *allocated_vis)
> @@ -405,6 +407,11 @@ void ef100_remove_netdev(struct efx_probe_data *probe_data)
>          ef100_pf_unset_devlink_port(efx);
>          efx_fini_tc(efx);
>   #endif
> +#ifdef CONFIG_DEBUG_FS
> +       mutex_lock(&efx->debugfs_symlink_mutex);
> +       efx_fini_debugfs_netdev(efx->net_dev);
> +       mutex_unlock(&efx->debugfs_symlink_mutex);
> +#endif

Can you do the mutex dance inside of efx_fini_debugfs_netdev() and then 
not need the ifdef here?

> 
>          down_write(&efx->filter_sem);
>          efx_mcdi_filter_table_remove(efx);
> diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
> index 6da06931187d..ad378aa05dc3 100644
> --- a/drivers/net/ethernet/sfc/ef100_nic.c
> +++ b/drivers/net/ethernet/sfc/ef100_nic.c
> @@ -27,6 +27,7 @@
>   #include "tc.h"
>   #include "mae.h"
>   #include "rx_common.h"
> +#include "debugfs.h"
> 
>   #define EF100_MAX_VIS 4096
>   #define EF100_NUM_MCDI_BUFFERS 1
> @@ -1077,6 +1078,12 @@ static int ef100_probe_main(struct efx_nic *efx)
> 
>          /* Post-IO section. */
> 
> +       /* Populate debugfs */
> +#ifdef CONFIG_DEBUG_FS
> +       rc = efx_init_debugfs_nic(efx);
> +       if (rc)
> +               pci_err(efx->pci_dev, "failed to init device debugfs\n");
> +#endif

Shouldn't need the ifdef

>          rc = efx_mcdi_init(efx);
>          if (rc)
>                  goto fail;
> @@ -1213,6 +1220,7 @@ void ef100_remove(struct efx_nic *efx)
> 
>          efx_mcdi_detach(efx);
>          efx_mcdi_fini(efx);
> +       efx_fini_debugfs_nic(efx);
>          if (nic_data)
>                  efx_nic_free_buffer(efx, &nic_data->mcdi_buf);
>          kfree(nic_data);
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 19f4b4d0b851..9266c7b5b4fd 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -33,6 +33,7 @@
>   #include "selftest.h"
>   #include "sriov.h"
>   #include "efx_devlink.h"
> +#include "debugfs.h"
> 
>   #include "mcdi_port_common.h"
>   #include "mcdi_pcol.h"
> @@ -401,6 +402,11 @@ static void efx_remove_all(struct efx_nic *efx)
>   #endif
>          efx_remove_port(efx);
>          efx_remove_nic(efx);
> +#ifdef CONFIG_DEBUG_FS
> +       mutex_lock(&efx->debugfs_symlink_mutex);
> +       efx_fini_debugfs_netdev(efx->net_dev);
> +       mutex_unlock(&efx->debugfs_symlink_mutex);
> +#endif

Same mutex comment

>   }
> 
>   /**************************************************************************
> @@ -667,6 +673,7 @@ static void efx_update_name(struct efx_nic *efx)
>          strcpy(efx->name, efx->net_dev->name);
>          efx_mtd_rename(efx);
>          efx_set_channel_names(efx);
> +       efx_update_debugfs_netdev(efx);
>   }
> 
>   static int efx_netdev_event(struct notifier_block *this,
> @@ -1319,6 +1326,10 @@ static int __init efx_init_module(void)
> 
>          printk(KERN_INFO "Solarflare NET driver\n");
> 
> +       rc = efx_init_debugfs();
> +       if (rc)
> +               goto err_debugfs;
> +
>          rc = register_netdevice_notifier(&efx_netdev_notifier);
>          if (rc)
>                  goto err_notifier;
> @@ -1344,6 +1355,8 @@ static int __init efx_init_module(void)
>    err_reset:
>          unregister_netdevice_notifier(&efx_netdev_notifier);
>    err_notifier:
> +       efx_fini_debugfs();
> + err_debugfs:
>          return rc;
>   }
> 
> @@ -1355,7 +1368,7 @@ static void __exit efx_exit_module(void)
>          pci_unregister_driver(&efx_pci_driver);
>          efx_destroy_reset_workqueue();
>          unregister_netdevice_notifier(&efx_netdev_notifier);
> -
> +       efx_fini_debugfs();
>   }
> 
>   module_init(efx_init_module);
> diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
> index 175bd9cdfdac..7a9d6b6b66e5 100644
> --- a/drivers/net/ethernet/sfc/efx_common.c
> +++ b/drivers/net/ethernet/sfc/efx_common.c
> @@ -1022,6 +1022,9 @@ int efx_init_struct(struct efx_nic *efx, struct pci_dev *pci_dev)
>          INIT_WORK(&efx->mac_work, efx_mac_work);
>          init_waitqueue_head(&efx->flush_wq);
> 
> +#ifdef CONFIG_DEBUG_FS
> +       mutex_init(&efx->debugfs_symlink_mutex);
> +#endif

Can we do this without the ifdefs in the mainline code?
(okay, I'll stop grinding on that one for now)

>          efx->tx_queues_per_channel = 1;
>          efx->rxq_entries = EFX_DEFAULT_DMAQ_SIZE;
>          efx->txq_entries = EFX_DEFAULT_DMAQ_SIZE;
> @@ -1056,6 +1059,10 @@ void efx_fini_struct(struct efx_nic *efx)
> 
>          efx_fini_channels(efx);
> 
> +#ifdef CONFIG_DEBUG_FS
> +       mutex_destroy(&efx->debugfs_symlink_mutex);
> +#endif
> +
>          kfree(efx->vpd_sn);
> 
>          if (efx->workqueue) {
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 27d86e90a3bb..961e2db31c6e 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -107,6 +107,24 @@ struct hwtstamp_config;
> 
>   struct efx_self_tests;
> 
> +/**
> + * struct efx_debugfs_enum_data - information for pretty-printing enums
> + * @value: pointer to the actual enum
> + * @vlen: sizeof the enum
> + * @names: array of names of enumerated values.  May contain some %NULL entries.
> + * @max: number of entries in @names, typically from ARRAY_SIZE()
> + *
> + * Where a driver struct contains an enum member which we wish to expose in
> + * debugfs, we also embed an instance of this struct, which
> + * efx_debugfs_enum_read() uses to pretty-print the value.
> + */
> +struct efx_debugfs_enum_data {
> +       void *value;
> +       size_t vlen;
> +       const char *const *names;
> +       unsigned int max;
> +};
> +
>   /**
>    * struct efx_buffer - A general-purpose DMA buffer
>    * @addr: host base address of the buffer
> @@ -1123,6 +1141,17 @@ struct efx_nic {
>          u32 rps_next_id;
>   #endif
> 
> +#ifdef CONFIG_DEBUG_FS
> +       /** @debug_dir: NIC debugfs directory */
> +       struct dentry *debug_dir;
> +       /** @debug_symlink: NIC debugfs symlink (``nic_eth%d``) */
> +       struct dentry *debug_symlink;
> +       /** @debug_interrupt_mode: debugfs details for printing @interrupt_mode */
> +       struct efx_debugfs_enum_data debug_interrupt_mode;
> +       /** @debugfs_symlink_mutex: protects debugfs @debug_symlink */
> +       struct mutex debugfs_symlink_mutex;
> +#endif
> +
>          atomic_t active_queues;
>          atomic_t rxq_flush_pending;
>          atomic_t rxq_flush_outstanding;
> 

