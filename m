Return-Path: <netdev+bounces-59423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC3E81ACBB
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF3B2428C
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 02:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5CF1843;
	Thu, 21 Dec 2023 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BY6Zv4il"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65736846B
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iARWOWdXpWP/RrQpMVXeGctx3eMFbnGtlBaqTw9IBl3nOCJAGfpA4c1S1NsxB29LAZWj8hVAMnepKh6EI+XuX8USp11B3gtZzrq3gejl1exVgjqkAQlAx4W9qyj5XO5Jua6aPJ3cTFR83goGKKrvirtlkntOYVZvxDruzFRre0nAfEy3pPlonOmOzMHZxkCwagXdgdg7zaRtGE34dpR2dP6wa6v+Xl76LYLAOmIB4VcwA3k/6hSCGvpaYckg9nBkYBeToS5E4ae0+szsJsicakxNaL/TL5a17zGHd3317OUx/n6yzMMo1DCTZpFLKMFhLyPktVomzK4uv4aAFCm5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT8Lvaj1L7RjCWxYP09b/UALWhO1rXLoDVow3r+07ZU=;
 b=AIDfi6aWpeRMyMIDMS3xvGqm31goo8R6z1lMshxvkLHWsIdkTBn3k7OlcTDMgIbuO2emd3apG17DqVA9kj3wfNmV5ul+VPgHedn6cu6RONLjEgUvwF0nrXS3Eb7OQP65x8Sls/cczIZZi34GByMLxzW8zI4iHx4JO49ShPNrX3ESenYm3rfwwZ20ItUICG75umz3SeHirgxudL93ZGicc4Vc6/nM0gsSJ2OUGGpx4/uh+ITHX78dqWdel3eHVCtL+LoS+b7RuWIB2z4zzp3vqP5n143K39Xb+ItvUZJAG/ohQKXtm6ItlKVtl5mwIYP2RPc655zO3ht9BzJh+X/CuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT8Lvaj1L7RjCWxYP09b/UALWhO1rXLoDVow3r+07ZU=;
 b=BY6Zv4ilU6HkkdX6VSiadmQNVBdMOwUvuABnmPluD/rWeb9FXVQVSwsra31pzxZnyyZMxCydDUBi5FB4eH8/+cKmwx8yXSfU0h87uSuZY1wG13WqVDRXQEGeCO84TCtRYWTWCTRdWvN9v9rWwGiZ9Hubv+M3sSzzaIAbkNpje/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 02:45:56 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7091.028; Thu, 21 Dec 2023
 02:45:56 +0000
Message-ID: <dc44d1cc-0065-4852-8da6-20a4a719a1f3@amd.com>
Date: Wed, 20 Dec 2023 18:45:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 15/15] net/mlx5: Implement management PF Ethernet
 profile
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Armen Ratner <armeng@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-16-saeed@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231221005721.186607-16-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::10) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ec1a56-1574-4df0-8601-08dc01cef4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nl9aczg0fPcobNxrM8iczrduebYNCpAZ+OVmFPhb5qt/3bEG8shS3kMDgdPo3Bgzylk8ywuN4+V7QkcOnli2abSZZB0ZvS2ADn0YBxXUH9fJ2eozqa2/z+Pnetqyg30SMdbVK9QNxXbNiR6XiBffFdYHJ6V3ttUHZssBHYsPOFXk6tV+yqOFJjgtfuimL1U1+WcmwoFY/D5jdkxr5lpOi5O6L7UzkyYz7yX2ZuNL7Qxv1iyZaNGCjF9lyTIJuzwcZ+rKwNf8G4A0Sj+VLX3OPnZOAQFFHWUCe0BUKBcfaXOHgch5bzE6bZV/jZx/gmwS+HLqjhq7DHg1YUNNGuVSx3VDR7/koXcGyHu2jmx4MtoVe4yn+ENoA5l7xdyz8ycGho5MZICYq8cktuGJCpbyX5FMtrHd20tNP9fwTCL8Fpy7SwbrVhJB6HuCzsj8Ki99J+kupQd2yq2RLF1VBRDs3CK7ygk+Qw5fHw7EfWFXNeIL+NZfK49CfOb6PqpWCOJRlER+C0XjMwvw29I1ENyviS/kWg2bM+NPDZeNqhV5xkUMl1jFgc2wrAew+IB3rzo3IRBR896G+8C5P4s5NMOH/omwBgPJmYcK/W4/tHzC3NdN9pXX+M/OHlZfG6HHCAVO16tylo2zSSZiL41uRIltXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6512007)(2616005)(53546011)(6506007)(83380400001)(26005)(86362001)(4326008)(8676002)(8936002)(2906002)(31696002)(41300700001)(30864003)(5660300002)(36756003)(7416002)(110136005)(54906003)(66476007)(66556008)(316002)(66946007)(478600001)(966005)(6486002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW9Id1UydzFmZ095amN6THlyV1pybzJMZ2lqdzJrL3hTdDdXalNqa29GcmFP?=
 =?utf-8?B?dkFmU1kxNThidEp1ZFpqclp2bFBFWnZzcnJyOVpYMTQ2NGdYdUhGL0loU3Qw?=
 =?utf-8?B?OHYxVUxlcjlQc2NPQ3JkcEYyMG9sandlUC9rTFBoTTE3aG5hQWpXL1J3dHJS?=
 =?utf-8?B?OC9qd3hiSDJHQ1lVZ1FEM3JGb2FERzJtcFpGenFkSnRUMzJtSmpUOGFhZ2dF?=
 =?utf-8?B?Ny9XRlNlanJZSmJoVjhKVFkycmJXcko5d0tsVzRHbENMUnIrN0djaHI1MGo4?=
 =?utf-8?B?ZHJadHAzZGdYdmtEd1ZQWVNXMlNNQWJRSjJZZGJGQXNFVUI1ck5uazh5N2JL?=
 =?utf-8?B?ZHc1RCtWbEU1cy9OWTdLNnNHNzU1ME9DWnYraWZURllhOFphRTNZQWNXVmV6?=
 =?utf-8?B?NEtSWnVXT3hKWDRBbHR1eXphaWIxOVQ4cktaOXJiOFY1Tm1EM0xMSityaEhj?=
 =?utf-8?B?YkZhTUx3L0h2VjVQVkMwSHhBTG1NWmM0QThkc0Nrc0piaWFtNmlHd3ZGQ1Q1?=
 =?utf-8?B?Q0U4K0phZmFxSFg4QkIyUnRrRzF2b2FsMWhLYldHYytzK3dnZlE5QXFaVHIv?=
 =?utf-8?B?eS9zOTdLcTAyK0x4UkpHZkZiRjF2bHhxbkU4Nk9IeXlZSlJCcUVlTmgxZlJB?=
 =?utf-8?B?Q0ZwbzhKUjdZNjhvYTFJdGdkSUZkeXhjamN5bFRKT01scnQ3dmVpYk95MHl2?=
 =?utf-8?B?d2xxT0Q3aDVOUWswV1lyUnJkMkYzZUFNTUpmTU1TMGp0STliREFaK0V0MmY2?=
 =?utf-8?B?THB3OWkyU29PdHdlMU94cFpCYUtOeEtJMU1mS3hjWDBnUDVPYmkySG1zdXRD?=
 =?utf-8?B?M3pmMEtsWWNNWjV2QWlNWmtZWmwxWmp3R1RheVdJQkRDYnVxa0lnZVdoRDAz?=
 =?utf-8?B?N1lZdVVtaTdMT0tHZ2ZmTHllUkl5dzJWSFNMK0YxK2J4bHZUK1VaM1hhZ2lp?=
 =?utf-8?B?eFBCd3hHWmlja1p3NVorcGJiSVUzd1RQL1hVZkwrNjZobkJocGZkMzNwSWdp?=
 =?utf-8?B?dFZWa3RBTFRVRTlnLzBrbEYyZ25RSHhoWlVvK3hTYngxenFETjRkSkgzN1Yw?=
 =?utf-8?B?TVNXL3FKU3pPRTM0WjBpVEhPcERMSDhPcytvNXQyV0lDcjZ3Q2lFVkxNN2Jp?=
 =?utf-8?B?ZkQ1UW11S09pKzhkbEFxMEhBNGROby9MRi9PRzF1TVZxTzk4U2JtcUhMSGxD?=
 =?utf-8?B?V2pIOG5adjl3SXNHNFFpMHlJVDlSNHNDd3FtTk54NmQ1amNWOHNFWW9jYWdK?=
 =?utf-8?B?TXNpbjhOazNYcVB2WVNRNCttbGw0QURqSE9QNndDbHFOUk9PMkxrSUE1K1Fs?=
 =?utf-8?B?UUlJemdRWU01Uk1Rb2tmWE9YVXVBWVRtS05QZmJGVDhoTzZidHdHS2s3bmFC?=
 =?utf-8?B?djJwN3ArbWY4K2E0SjZiUXBPK3pSWVdNdjEyT0NXOEdKZVV4b2FGZUFMVk9J?=
 =?utf-8?B?M1hnTlJaYlpjZlJjRlh2YVNUOFZrMkkwMG1oMlFDVTQ1R0hUaXhGWnpVMFIx?=
 =?utf-8?B?UUxIbHdnQ0VxdVRQRnpVL1plMFJBR3BSa25LTHlVMGhyWXV6RnlXWVdqQ3RG?=
 =?utf-8?B?Z1MzeGNOTmRXRk1RVjd2NHBjUWRJTjhTbU1SQU5KaTVXMTdXTDhjWWNXenF0?=
 =?utf-8?B?SFJiblU1SjBicXIvaE5PN1FITFZwTG9FVGxDS3B6UWVSL2tYL29UTXhncjM1?=
 =?utf-8?B?MWk3UjdkNkdtMjlLQ2NlcUZkTTROR3NGL0hVYnR1WjVCektFQ3BiV3MrUU5a?=
 =?utf-8?B?aCtUZTVoQ3QzOVE4dkpwbFN0eSs5YldtOXpwSlpRSWdIcGhCQnhPanhyZzF1?=
 =?utf-8?B?Uys3VXAzVXViZzQzaDA3bEJCT2JXakljcU5taUc4VnZ4TjUyN0ptQmNFRzlU?=
 =?utf-8?B?ZUtvK3dMc28yNWJPUGNVUGQ1UElzN2N5WDVjTGNjNzJOdWVyVEdNcjlJRjh2?=
 =?utf-8?B?QXJuc05tNGxvemxadXE3T3RybUxHMlduTDdYa2lZbnFxUzI2T1lJTFZvSXZs?=
 =?utf-8?B?MGJZQXVXS1dLVWt1amZZTDNaYVlMT1YvOVVLN2FwTWsvc2htNW8zN2tjNXNq?=
 =?utf-8?B?NmhjczhNYnN3eTFMOGRxZHp2RWNJSmVpR2svZEh6QXA4bVU2dHVBSHZIZ0JK?=
 =?utf-8?Q?sT1hRhN8eC8xggfmqhBtVWEan?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ec1a56-1574-4df0-8601-08dc01cef4c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 02:45:56.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8y5TFySCkAycrSgDQewevnEZpm2YkwO48uHQcV82k8yJJ7uHObAzIejVaOFm9GqTo1A6MTKPnFu8/Dc5p6YTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

On 12/20/2023 4:57 PM, Saeed Mahameed wrote:
> 
> From: Armen Ratner <armeng@nvidia.com>
> 
> Add management PF modules, which introduce support for the structures
> needed to create the resources for the MGMT PF to work.
> Also, add the necessary calls and functions to establish this
> functionality.

Hmmm.... this reminds me of a previous discussion:
https://lore.kernel.org/netdev/20200305140322.2dc86db0@kicinski-fedora-PC1C0HJN/

sln


> 
> Signed-off-by: Armen Ratner <armeng@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Daniel Jurgens <danielj@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/dev.c |   3 +
>   .../net/ethernet/mellanox/mlx5/core/ecpf.c    |   6 +
>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +
>   .../ethernet/mellanox/mlx5/core/en/mgmt_pf.c  | 268 ++++++++++++++++++
>   .../net/ethernet/mellanox/mlx5/core/en_main.c |  24 +-
>   .../net/ethernet/mellanox/mlx5/core/eswitch.c |   2 +-
>   include/linux/mlx5/driver.h                   |   8 +
>   include/linux/mlx5/mlx5_ifc.h                 |  14 +-
>   9 files changed, 323 insertions(+), 8 deletions(-)
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/mgmt_pf.c
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> index 76dc5a9b9648..f36232dead1a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> @@ -29,7 +29,7 @@ mlx5_core-$(CONFIG_MLX5_CORE_EN) += en/rqt.o en/tir.o en/rss.o en/rx_res.o \
>                  en/reporter_tx.o en/reporter_rx.o en/params.o en/xsk/pool.o \
>                  en/xsk/setup.o en/xsk/rx.o en/xsk/tx.o en/devlink.o en/ptp.o \
>                  en/qos.o en/htb.o en/trap.o en/fs_tt_redirect.o en/selq.o \
> -               lib/crypto.o lib/sd.o
> +               en/mgmt_pf.o lib/crypto.o lib/sd.o
> 
>   #
>   # Netdev extra
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> index cf0477f53dc4..aa1b471e13fa 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> @@ -190,6 +190,9 @@ bool mlx5_rdma_supported(struct mlx5_core_dev *dev)
>          if (is_mp_supported(dev))
>                  return false;
> 
> +       if (mlx5_core_is_mgmt_pf(dev))
> +               return false;
> +
>          return true;
>   }
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
> index d000236ddbac..aa397e3ebe6d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
> @@ -75,6 +75,9 @@ int mlx5_ec_init(struct mlx5_core_dev *dev)
>          if (!mlx5_core_is_ecpf(dev))
>                  return 0;
> 
> +       if (mlx5_core_is_mgmt_pf(dev))
> +               return 0;
> +
>          return mlx5_host_pf_init(dev);
>   }
> 
> @@ -85,6 +88,9 @@ void mlx5_ec_cleanup(struct mlx5_core_dev *dev)
>          if (!mlx5_core_is_ecpf(dev))
>                  return;
> 
> +       if (mlx5_core_is_mgmt_pf(dev))
> +               return;
> +
>          mlx5_host_pf_cleanup(dev);
> 
>          err = mlx5_wait_for_pages(dev, &dev->priv.page_counters[MLX5_HOST_PF]);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 84db05fb9389..922b63c25154 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -63,6 +63,7 @@
>   #include "lib/sd.h"
> 
>   extern const struct net_device_ops mlx5e_netdev_ops;
> +extern const struct net_device_ops mlx5e_mgmt_netdev_ops;
>   struct page_pool;
> 
>   #define MLX5E_METADATA_ETHER_TYPE (0x8CE4)
> @@ -1125,6 +1126,7 @@ static inline bool mlx5_tx_swp_supported(struct mlx5_core_dev *mdev)
>   }
> 
>   extern const struct ethtool_ops mlx5e_ethtool_ops;
> +extern const struct mlx5e_profile mlx5e_mgmt_pf_nic_profile;
> 
>   int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn, u32 *mkey);
>   int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises);
> @@ -1230,6 +1232,8 @@ netdev_features_t mlx5e_features_check(struct sk_buff *skb,
>                                         struct net_device *netdev,
>                                         netdev_features_t features);
>   int mlx5e_set_features(struct net_device *netdev, netdev_features_t features);
> +void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv);
> +
>   #ifdef CONFIG_MLX5_ESWITCH
>   int mlx5e_set_vf_mac(struct net_device *dev, int vf, u8 *mac);
>   int mlx5e_set_vf_rate(struct net_device *dev, int vf, int min_tx_rate, int max_tx_rate);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/mgmt_pf.c b/drivers/net/ethernet/mellanox/mlx5/core/en/mgmt_pf.c
> new file mode 100644
> index 000000000000..77b5805895b9
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/mgmt_pf.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +
> +#include <linux/kernel.h>
> +#include "en/params.h"
> +#include "en/health.h"
> +#include "lib/eq.h"
> +#include "en/dcbnl.h"
> +#include "en_accel/ipsec.h"
> +#include "en_accel/en_accel.h"
> +#include "en/trap.h"
> +#include "en/monitor_stats.h"
> +#include "en/hv_vhca_stats.h"
> +#include "en_rep.h"
> +#include "en.h"
> +
> +static int mgmt_pf_async_event(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +       struct mlx5e_priv *priv = container_of(nb, struct mlx5e_priv, events_nb);
> +       struct mlx5_eqe   *eqe = data;
> +
> +       if (event != MLX5_EVENT_TYPE_PORT_CHANGE)
> +               return NOTIFY_DONE;
> +
> +       switch (eqe->sub_type) {
> +       case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
> +       case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> +               queue_work(priv->wq, &priv->update_carrier_work);
> +               break;
> +       default:
> +               return NOTIFY_DONE;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
> +static void mlx5e_mgmt_pf_enable_async_events(struct mlx5e_priv *priv)
> +{
> +       priv->events_nb.notifier_call = mgmt_pf_async_event;
> +       mlx5_notifier_register(priv->mdev, &priv->events_nb);
> +}
> +
> +static void mlx5e_disable_mgmt_pf_async_events(struct mlx5e_priv *priv)
> +{
> +       mlx5_notifier_unregister(priv->mdev, &priv->events_nb);
> +}
> +
> +static void mlx5e_modify_mgmt_pf_admin_state(struct mlx5_core_dev *mdev,
> +                                            enum mlx5_port_status state)
> +{
> +       struct mlx5_eswitch *esw = mdev->priv.eswitch;
> +       int vport_admin_state;
> +
> +       mlx5_set_port_admin_status(mdev, state);
> +
> +       if (state == MLX5_PORT_UP)
> +               vport_admin_state = MLX5_VPORT_ADMIN_STATE_AUTO;
> +       else
> +               vport_admin_state = MLX5_VPORT_ADMIN_STATE_DOWN;
> +
> +       mlx5_eswitch_set_vport_state(esw, MLX5_VPORT_UPLINK, vport_admin_state);
> +}
> +
> +static void mlx5e_build_mgmt_pf_nic_params(struct mlx5e_priv *priv, u16 mtu)
> +{
> +       struct mlx5e_params *params = &priv->channels.params;
> +       struct mlx5_core_dev *mdev = priv->mdev;
> +       u8 rx_cq_period_mode;
> +
> +       params->sw_mtu = mtu;
> +       params->hard_mtu = MLX5E_ETH_HARD_MTU;
> +       params->num_channels = 1;
> +
> +       /* SQ */
> +       params->log_sq_size = is_kdump_kernel() ?
> +               MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE :
> +               MLX5E_PARAMS_DEFAULT_LOG_SQ_SIZE;
> +       MLX5E_SET_PFLAG(params, MLX5E_PFLAG_SKB_TX_MPWQE, mlx5e_tx_mpwqe_supported(mdev));
> +
> +       MLX5E_SET_PFLAG(params, MLX5E_PFLAG_RX_NO_CSUM_COMPLETE, false);
> +
> +       /* RQ */
> +       mlx5e_build_rq_params(mdev, params);
> +
> +       /* CQ moderation params */
> +       rx_cq_period_mode = MLX5_CAP_GEN(mdev, cq_period_start_from_cqe) ?
> +                       MLX5_CQ_PERIOD_MODE_START_FROM_CQE :
> +                       MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
> +       params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
> +       params->tx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
> +       mlx5e_set_rx_cq_mode_params(params, rx_cq_period_mode);
> +       mlx5e_set_tx_cq_mode_params(params, MLX5_CQ_PERIOD_MODE_START_FROM_EQE);
> +
> +       /* TX inline */
> +       mlx5_query_min_inline(mdev, &params->tx_min_inline_mode);
> +}
> +
> +static int mlx5e_mgmt_pf_init(struct mlx5_core_dev *mdev,
> +                             struct net_device *netdev)
> +{
> +       struct mlx5e_priv *priv = netdev_priv(netdev);
> +       struct mlx5e_flow_steering *fs;
> +       int err;
> +
> +       mlx5e_build_mgmt_pf_nic_params(priv, netdev->mtu);
> +
> +       mlx5e_timestamp_init(priv);
> +
> +       fs = mlx5e_fs_init(priv->profile, mdev,
> +                          !test_bit(MLX5E_STATE_DESTROYING, &priv->state),
> +                          priv->dfs_root);
> +       if (!fs) {
> +               err = -ENOMEM;
> +               mlx5_core_err(mdev, "FS initialization failed, %d\n", err);
> +               return err;
> +       }
> +       priv->fs = fs;
> +
> +       mlx5e_health_create_reporters(priv);
> +
> +       return 0;
> +}
> +
> +static void mlx5e_mgmt_pf_cleanup(struct mlx5e_priv *priv)
> +{
> +       mlx5e_health_destroy_reporters(priv);
> +       mlx5e_fs_cleanup(priv->fs);
> +       priv->fs = NULL;
> +}
> +
> +static int mlx5e_mgmt_pf_init_rx(struct mlx5e_priv *priv)
> +{
> +       struct mlx5_core_dev *mdev = priv->mdev;
> +       int err;
> +
> +       priv->rx_res = mlx5e_rx_res_create(mdev, 0, priv->max_nch, priv->drop_rq.rqn,
> +                                          &priv->channels.params.packet_merge,
> +                                          priv->channels.params.num_channels);
> +       if (!priv->rx_res)
> +               return -ENOMEM;
> +
> +       mlx5e_create_q_counters(priv);
> +
> +       err = mlx5e_open_drop_rq(priv, &priv->drop_rq);
> +       if (err) {
> +               mlx5_core_err(mdev, "open drop rq failed, %d\n", err);
> +               goto err_destroy_q_counters;
> +       }
> +
> +       err = mlx5e_create_flow_steering(priv->fs, priv->rx_res, priv->profile,
> +                                        priv->netdev);
> +       if (err) {
> +               mlx5_core_warn(mdev, "create flow steering failed, %d\n", err);
> +               goto err_destroy_rx_res;
> +       }
> +
> +       return 0;
> +
> +err_destroy_rx_res:
> +       mlx5e_rx_res_destroy(priv->rx_res);
> +       priv->rx_res = NULL;
> +       mlx5e_close_drop_rq(&priv->drop_rq);
> +err_destroy_q_counters:
> +       mlx5e_destroy_q_counters(priv);
> +       return err;
> +}
> +
> +static void mlx5e_mgmt_pf_cleanup_rx(struct mlx5e_priv *priv)
> +{
> +       mlx5e_destroy_flow_steering(priv->fs, !!(priv->netdev->hw_features & NETIF_F_NTUPLE),
> +                                   priv->profile);
> +       mlx5e_rx_res_destroy(priv->rx_res);
> +       priv->rx_res = NULL;
> +       mlx5e_close_drop_rq(&priv->drop_rq);
> +       mlx5e_destroy_q_counters(priv);
> +}
> +
> +static int mlx5e_mgmt_pf_init_tx(struct mlx5e_priv *priv)
> +{
> +       return 0;
> +}
> +
> +static void mlx5e_mgmt_pf_cleanup_tx(struct mlx5e_priv *priv)
> +{
> +}
> +
> +static void mlx5e_mgmt_pf_enable(struct mlx5e_priv *priv)
> +{
> +       struct net_device *netdev = priv->netdev;
> +       struct mlx5_core_dev *mdev = priv->mdev;
> +
> +       mlx5e_fs_init_l2_addr(priv->fs, netdev);
> +
> +       /* Marking the link as currently not needed by the Driver */
> +       if (!netif_running(netdev))
> +               mlx5e_modify_mgmt_pf_admin_state(mdev, MLX5_PORT_DOWN);
> +
> +       mlx5e_set_netdev_mtu_boundaries(priv);
> +       mlx5e_set_dev_port_mtu(priv);
> +
> +       mlx5e_mgmt_pf_enable_async_events(priv);
> +       if (mlx5e_monitor_counter_supported(priv))
> +               mlx5e_monitor_counter_init(priv);
> +
> +       mlx5e_hv_vhca_stats_create(priv);
> +       if (netdev->reg_state != NETREG_REGISTERED)
> +               return;
> +       mlx5e_dcbnl_init_app(priv);
> +
> +       mlx5e_nic_set_rx_mode(priv);
> +
> +       rtnl_lock();
> +       if (netif_running(netdev))
> +               mlx5e_open(netdev);
> +       udp_tunnel_nic_reset_ntf(priv->netdev);
> +       netif_device_attach(netdev);
> +       rtnl_unlock();
> +}
> +
> +static void mlx5e_mgmt_pf_disable(struct mlx5e_priv *priv)
> +{
> +       if (priv->netdev->reg_state == NETREG_REGISTERED)
> +               mlx5e_dcbnl_delete_app(priv);
> +
> +       rtnl_lock();
> +       if (netif_running(priv->netdev))
> +               mlx5e_close(priv->netdev);
> +       netif_device_detach(priv->netdev);
> +       rtnl_unlock();
> +
> +       mlx5e_nic_set_rx_mode(priv);
> +
> +       mlx5e_hv_vhca_stats_destroy(priv);
> +       if (mlx5e_monitor_counter_supported(priv))
> +               mlx5e_monitor_counter_cleanup(priv);
> +
> +       mlx5e_disable_mgmt_pf_async_events(priv);
> +       mlx5e_ipsec_cleanup(priv);
> +}
> +
> +static int mlx5e_mgmt_pf_update_rx(struct mlx5e_priv *priv)
> +{
> +       return mlx5e_refresh_tirs(priv, false, false);
> +}
> +
> +static int mlx5e_mgmt_pf_max_nch_limit(struct mlx5_core_dev *mdev)
> +{
> +       return 1;
> +}
> +
> +const struct mlx5e_profile mlx5e_mgmt_pf_nic_profile = {
> +       .init              = mlx5e_mgmt_pf_init,
> +       .cleanup           = mlx5e_mgmt_pf_cleanup,
> +       .init_rx           = mlx5e_mgmt_pf_init_rx,
> +       .cleanup_rx        = mlx5e_mgmt_pf_cleanup_rx,
> +       .init_tx           = mlx5e_mgmt_pf_init_tx,
> +       .cleanup_tx        = mlx5e_mgmt_pf_cleanup_tx,
> +       .enable            = mlx5e_mgmt_pf_enable,
> +       .disable           = mlx5e_mgmt_pf_disable,
> +       .update_rx         = mlx5e_mgmt_pf_update_rx,
> +       .update_stats      = mlx5e_stats_update_ndo_stats,
> +       .update_carrier    = mlx5e_update_carrier,
> +       .rx_handlers       = &mlx5e_rx_handlers_nic,
> +       .max_tc            = 1,
> +       .max_nch_limit     = mlx5e_mgmt_pf_max_nch_limit,
> +       .stats_grps        = mlx5e_nic_stats_grps,
> +       .stats_grps_num    = mlx5e_nic_stats_grps_num
> +};
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index b8f08d64f66b..40626b6108fb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -3799,7 +3799,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
>          stats->tx_errors = stats->tx_aborted_errors + stats->tx_carrier_errors;
>   }
> 
> -static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
> +void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
>   {
>          if (mlx5e_is_uplink_rep(priv))
>                  return; /* no rx mode for uplink rep */
> @@ -5004,6 +5004,15 @@ const struct net_device_ops mlx5e_netdev_ops = {
>   #endif
>   };
> 
> +const struct net_device_ops mlx5e_mgmt_netdev_ops = {
> +       .ndo_open               = mlx5e_open,
> +       .ndo_stop               = mlx5e_close,
> +       .ndo_start_xmit         = mlx5e_xmit,
> +       .ndo_get_stats64        = mlx5e_get_stats,
> +       .ndo_change_mtu         = mlx5e_change_nic_mtu,
> +       .ndo_set_rx_mode        = mlx5e_set_rx_mode,
> +};
> +
>   static u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout)
>   {
>          int i;
> @@ -5143,7 +5152,11 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
> 
>          SET_NETDEV_DEV(netdev, mdev->device);
> 
> -       netdev->netdev_ops = &mlx5e_netdev_ops;
> +       if (mlx5_core_is_mgmt_pf(mdev))
> +               netdev->netdev_ops = &mlx5e_mgmt_netdev_ops;
> +       else
> +               netdev->netdev_ops = &mlx5e_netdev_ops;
> +
>          netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
>          netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
> 
> @@ -6094,13 +6107,18 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
>   static int _mlx5e_probe(struct auxiliary_device *adev)
>   {
>          struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
> -       const struct mlx5e_profile *profile = &mlx5e_nic_profile;
>          struct mlx5_core_dev *mdev = edev->mdev;
> +       const struct mlx5e_profile *profile;
>          struct mlx5e_dev *mlx5e_dev;
>          struct net_device *netdev;
>          struct mlx5e_priv *priv;
>          int err;
> 
> +       if (mlx5_core_is_mgmt_pf(mdev))
> +               profile = &mlx5e_mgmt_pf_nic_profile;
> +       else
> +               profile = &mlx5e_nic_profile;
> +
>          mlx5e_dev = mlx5e_create_devlink(&adev->dev, mdev);
>          if (IS_ERR(mlx5e_dev))
>                  return PTR_ERR(mlx5e_dev);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index 3047d7015c52..3bf419d06d53 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -1665,7 +1665,7 @@ int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *
>          void *hca_caps;
>          int err;
> 
> -       if (!mlx5_core_is_ecpf(dev)) {
> +       if (!mlx5_core_is_ecpf(dev) || mlx5_core_is_mgmt_pf(dev)) {
>                  *max_sfs = 0;
>                  return 0;
>          }
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index cd286b681970..2bba88c67f58 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -1224,6 +1224,14 @@ static inline bool mlx5_core_is_ecpf(const struct mlx5_core_dev *dev)
>          return dev->caps.embedded_cpu;
>   }
> 
> +static inline bool mlx5_core_is_mgmt_pf(const struct mlx5_core_dev *dev)
> +{
> +       if (!MLX5_CAP_GEN_2(dev, local_mng_port_valid))
> +               return false;
> +
> +       return MLX5_CAP_GEN_2(dev, local_mng_port);
> +}
> +
>   static inline bool
>   mlx5_core_is_ecpf_esw_manager(const struct mlx5_core_dev *dev)
>   {
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index bf2d51952e48..586569209254 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -1954,8 +1954,10 @@ enum {
>   struct mlx5_ifc_cmd_hca_cap_2_bits {
>          u8         reserved_at_0[0x80];
> 
> -       u8         migratable[0x1];
> -       u8         reserved_at_81[0x1f];
> +       u8         migratable[0x1];
> +       u8         reserved_at_81[0x19];
> +       u8         local_mng_port[0x1];
> +       u8         reserved_at_9b[0x5];
> 
>          u8         max_reformat_insert_size[0x8];
>          u8         max_reformat_insert_offset[0x8];
> @@ -1973,7 +1975,13 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
> 
>          u8         allowed_object_for_other_vhca_access[0x40];
> 
> -       u8         reserved_at_140[0x60];
> +       u8         reserved_at_140[0x20];
> +
> +       u8         reserved_at_160[0xa];
> +       u8         local_mng_port_valid[0x1];
> +       u8         reserved_at_16b[0x15];
> +
> +       u8         reserved_at_180[0x20];
> 
>          u8         flow_table_type_2_type[0x8];
>          u8         reserved_at_1a8[0x3];
> --
> 2.43.0
> 
> 

