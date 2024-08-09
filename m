Return-Path: <netdev+bounces-117129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3700594CD02
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A4428346E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26E1917DD;
	Fri,  9 Aug 2024 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WhDg88kz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22072191489;
	Fri,  9 Aug 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194656; cv=fail; b=XIw+1thxajyp1tE552nTi+AFZBjLwihwomjJlgcBZH6jtS8Ti63Og/FNMr04IX+YRSdYD1LpuHH5l2LbUYC4WqeNhoPPHpFiMVE7VfBT1uIuO/WbrkytDawQNvPC27WarWXyYldEdtu4bqgbRzIVmCKXCqWwDOIIAikS0yQf94E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194656; c=relaxed/simple;
	bh=Kirox3+jd0N3JtElKBijsryC1TcjVagUsF8JV8XEyCU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFL2wk7ThPukzd6DqJYqYzGeW9JEb+nzhorsCvxQ2PABGpBj19Nv69pYDDSf4Hvh/n+PyJCSS/S+gevGGZiF+RxLO7RvPvQKkamxBz+eMR9i2nbz1vxkbF/5Eqh9mv9e/08DoJvgE/6vDMEtlQSkPGQpuA3g0AzJJo7CQ/dIaNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WhDg88kz; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVtb3Q4TQpmK0W992vNCzqn8JdZKrHVKe0k0TTEd7X7kxXLlUuZv9BLxCUt8zkbuq55hx7wfupYl0mASRUc7MVrRt94OPxFhiWw4dvYB/peIu/3dV0VPqaoX0O0Vt5UqnNsPxzp1f1fQG43w4krihS38HjUjfFZFkroY5gZOuITbI8ny/YKUkA0nRidCF86KAI8O1+OaAKznV3XJ6OslRnm8000vRb6N5l1rtQS9trSU9J3ZasTxFD1Cp/9+NlkcqpUsnE0QsM8VnUz/PvMBCSbrUaIIGzdnMOQK3VY9RSkPrOoPzEcZZfQSpyT2dymSqmb4gd5ib7qH/43D2crT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRhGZ+TpW8TbFhzXW9D7dGp4Oa5VbaQ222Pi+lI62xs=;
 b=SmMJLA4QcERwHGLkT8l7AkOGGqpK5chh07XeEPTsaTrOmmEPZtiz385TnoZ8ZnzpfHb19C8jUDwP56C3tYs2m87NwuPpAO0tMWNzA2f17dSrDcRABkmpjjzvte7qzHF5EbPY/0q4A6zhAr6pnVFdnGed1dMfVVsSnknw1SuLVH3htVMCe/w7awUUtJghucK7jGQF3FD4lUaoZWlHUByLCizKdKCpBAvU1Z43X1TCD2zV8iaDi9UA+NuKW2fJWEbabd7uOI6nxJNpl6IXNykKA6+xY1RYqBDW3qgiJZjRj67GANzEYswkn//GiZNmWwV+PLNlYylqrCySMcELWSRw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRhGZ+TpW8TbFhzXW9D7dGp4Oa5VbaQ222Pi+lI62xs=;
 b=WhDg88kzvdgg9+eHuQnaMkP1tAkhmAwtiZUm3LvNNhbminy0UC/4ZbZKJOJWHdQJeFXA7bLRhS7d2Ph1bc8gsmeHPm9VNNXFSMQe44AGBnR6sMk1JwgYhCsEUv9veZQhZS1EbJMtRhH/67Ms9bxaXj8fODlvCrT8GUj1+Le0VPcJpsWXCAdiYbNq2gqveJao/tJo0qTy1AHkcs7HLN0j0cnvdKOUCD5vUOZOXsodIvhoZh44ZN7h0VpwuXjQCQqtGcgLGk22LM6uRSQLbfp8CiS9AdVgQAZIyF/rya/7XWFRQTaKjdlqOJwsLYnhZO0ziziVsVUlBe4MDxwIJTbRcg==
Received: from CH0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:610:cc::11)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 09:10:50 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::65) by CH0PR03CA0066.outlook.office365.com
 (2603:10b6:610:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31 via Frontend
 Transport; Fri, 9 Aug 2024 09:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 09:10:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 02:10:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 02:10:39 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 9 Aug 2024
 02:10:36 -0700
Date: Fri, 9 Aug 2024 12:10:36 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, <targupta@nvidia.com>
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Message-ID: <20240809121036.000057f0.zhiw@nvidia.com>
In-Reply-To: <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-5-alejandro.lucero-palau@amd.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a37edc-ac02-4a99-20b9-08dcb8532a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AqWLmVc+Wjh2beMOxtRT1Dvm+GeTUJdgIup8sKVaDEFQazvwlcu9MrZhdKb1?=
 =?us-ascii?Q?vrFs7lvZpLEXjBHxGMj82sUFV8VHp+7LmR4sQ3SrrQsrpC6B5GvhrSr5N+J3?=
 =?us-ascii?Q?z3KFJlEZjws0quTh5z8dgICqz57bQldkWlZogrcnKJ2n2BXqTNYy923oZn6j?=
 =?us-ascii?Q?Z6VK8+ViLbICQfM4yC5Xl2ivQ+jSnvrkZ0GfVdPaLnkA9qg0rHlKCRioUGCJ?=
 =?us-ascii?Q?C82k/ydXEnx/znJ5EMIqw6irfhFvmaXDh6779ke5TdHAoYwhPg8LWe8bzojR?=
 =?us-ascii?Q?1VgajlvmEwNUv8YKc0KcpVVecaETMMCT0g18j2a/jKK/DNVTBlkSqA2f47qa?=
 =?us-ascii?Q?3/3I4p9MA05oeoE9VWDJPmjebn2GdTwXHhaFxpA631z2DSt25LKq5Ax8IlII?=
 =?us-ascii?Q?V3WpFBsdY1gTjArbLiXxeSevdo3SIqkqNG0oUFl5llHFqpaw/ijYp6BG8hdF?=
 =?us-ascii?Q?n2FX5TWG8vx5UApsPxs61kl73+FezvmFBZFvU2ab2NvjdDIgeGMLePxCPQzm?=
 =?us-ascii?Q?ULSmpZdIKV3gO1pF5PkFClH/XV308mLP3DOb+dfgwkHsj9FG+koQeRQ8TRF3?=
 =?us-ascii?Q?1ZRBDJ9zv9PYBl+SvXQanVNNit36I+D+syMzXRxH3jOk+Kper+ngWs3J8JCN?=
 =?us-ascii?Q?XoBbquSIBE4R4b0IQoFNrOQl/HBLZogB7VCdWN1aF//0+WCLdNXLJA927PQx?=
 =?us-ascii?Q?AW20TYLsHX9uj6PQddSptlxijvQmfXpQ9sVKVowFwkqlAR8vFI++Kejnw6tA?=
 =?us-ascii?Q?O9hdPr2ameNuWDkoJjc6LTRF31aGs9GzDCo9Gqvv+QU9chXIIxLq6B0MZNZa?=
 =?us-ascii?Q?eoNQEQNhVpr1jnipw5jEDZ15Xx7t2CetSdFF5tz5QUKtjEjuaBqGXFKqAitv?=
 =?us-ascii?Q?7xV1wMfTSIG0G8Gl5wcDulA5QGaYoh8JEP5UfJDzoyd3jnNoXTNhVfk5TN9g?=
 =?us-ascii?Q?Fp1eG52F4oCNiZEiNCOdU8BdZVrnKKK/aBZfkzw1dODmaLv9q4fiJHOcujhV?=
 =?us-ascii?Q?014jDYBNweRRsQxO3LpZOUvlGtCN9+77tPkgckD6mJP11ueFr/0ruNrS2PbC?=
 =?us-ascii?Q?4qcRt5uq02C7iHyv3UAD/90tZImJjXsK10/CTuXb4LpxjRFAdkI42Au5tgMe?=
 =?us-ascii?Q?SLxCb3ZtXRouqEj5rmFFfdrcSVf0PZ4wfkO5fLIFi8XsQDRCevsdwPx99AHw?=
 =?us-ascii?Q?upDJzVvWtcnBhABnnrjxLh3VUJUbJuA8E++YyPCneXhfm666jW9mwAzWP7fS?=
 =?us-ascii?Q?BYELq1oISJ6n5VIIHSxiEvx4HqHxlyrmpSlx151WX7GtXgBQsi1ts7z3rb51?=
 =?us-ascii?Q?k5+muzUXE8WtKusEC9+tBhqyzxZZzbGYu0iyfOMGXYrydnNPnMaFPCov3nPW?=
 =?us-ascii?Q?qhV3KD030znYy/I/Lyem9fYss0U6vL2qIBerBB2+BBGoMVp1aQPNK5GAlIqv?=
 =?us-ascii?Q?s9hHlKOgnsnh56Oo7bQe2vWGNHZJoKQT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:10:50.7143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a37edc-ac02-4a99-20b9-08dcb8532a26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

On Mon, 15 Jul 2024 18:28:24 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what a CXL
> accelerator implements.
> 
> Add a new field for keeping device capabilities to be initialised by
> Type2 drivers. Advertise all those capabilities for Type3.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/mbox.c            |  1 +
>  drivers/cxl/core/memdev.c          |  4 +++-
>  drivers/cxl/core/port.c            |  2 +-
>  drivers/cxl/core/regs.c            | 11 ++++++-----
>  drivers/cxl/cxl.h                  |  2 +-
>  drivers/cxl/cxlmem.h               |  4 ++++
>  drivers/cxl/pci.c                  | 15 +++++++++------
>  drivers/net/ethernet/sfc/efx_cxl.c |  3 ++-
>  include/linux/cxl_accel_mem.h      |  5 ++++-
>  9 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..2ba7d36e3f38 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1424,6 +1424,7 @@ struct cxl_memdev_state
> *cxl_memdev_state_create(struct device *dev) mds->cxlds.reg_map.host
> = dev; mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> +	mds->cxlds.capabilities = CXL_DRIVER_CAP_HDM |
> CXL_DRIVER_CAP_MBOX; mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 04c3a0f8bc2e..b4205ecca365 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -616,7 +616,7 @@ static void detach_memdev(struct work_struct
> *work) 
>  static struct lock_class_key cxl_memdev_key;
>  
> -struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev,
> uint8_t caps) {
>  	struct cxl_dev_state *cxlds;
>  
> @@ -631,6 +631,8 @@ struct cxl_dev_state
> *cxl_accel_state_create(struct device *dev) cxlds->ram_res =
> DEFINE_RES_MEM_NAMED(0, 0, "ram"); cxlds->pmem_res =
> DEFINE_RES_MEM_NAMED(0, 0, "pmem"); 
> +	cxlds->capabilities = caps;
> +
>  	return cxlds;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 887ed6e358fb..d66c6349ed2d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device
> *host, struct cxl_register_map *map map->reg_type =
> CXL_REGLOC_RBI_COMPONENT; map->max_size =
> CXL_COMPONENT_REG_BLOCK_SIZE; 
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, 0);
>  }
>  
>  static int cxl_port_setup_regs(struct cxl_port *port,
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e1082e749c69..9d218ebe180d 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -421,7 +421,7 @@ static void cxl_unmap_regblock(struct
> cxl_register_map *map) map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map, uint8_t caps)
>  {

Can we not use uintxx_t? Just like any other one in the
cxl-core. Generally, u{8,16...} are mostly used for kernel
programming, and your previous patches use them nicely.

Let's use u8 for caps. 

>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> @@ -437,11 +437,12 @@ static int cxl_probe_regs(struct
> cxl_register_map *map) case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> +		if (!dev_map->status.valid ||
> +		    ((caps & CXL_DRIVER_CAP_MBOX) &&
> !dev_map->mbox.valid) || !dev_map->memdev.valid) {
>  			dev_err(host, "registers not found:
> %s%s%s\n", !dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> +				((caps & CXL_DRIVER_CAP_MBOX) &&
> !dev_map->mbox.valid) ? "mbox " : "", !dev_map->memdev.valid ?
> "memdev " : ""); return -ENXIO;
>  		}
> @@ -455,7 +456,7 @@ static int cxl_probe_regs(struct cxl_register_map
> *map) return 0;
>  }
>  
> -int cxl_setup_regs(struct cxl_register_map *map)
> +int cxl_setup_regs(struct cxl_register_map *map, uint8_t caps)
>  {
>  	int rc;
>  
> @@ -463,7 +464,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_probe_regs(map);
> +	rc = cxl_probe_regs(map, caps);
>  	cxl_unmap_regblock(map);
>  
>  	return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a6613a6f8923..9973430d975f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -300,7 +300,7 @@ int cxl_find_regblock_instance(struct pci_dev
> *pdev, enum cxl_regloc_type type, struct cxl_register_map *map, int
> index); int cxl_find_regblock(struct pci_dev *pdev, enum
> cxl_regloc_type type, struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map, uint8_t caps);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index af8169ccdbc0..8f2a820bd92d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -405,6 +405,9 @@ struct cxl_dpa_perf {
>  	int qos_class;
>  };
>  
> +#define CXL_DRIVER_CAP_HDM	0x1
> +#define CXL_DRIVER_CAP_MBOX	0x2
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -438,6 +441,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	uint8_t capabilities;
>  };
>  
>  /**
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b34d6259faf4..e2a978312281 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -502,7 +502,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev
> *pdev, }
>  
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum
> cxl_regloc_type type,
> -			      struct cxl_register_map *map)
> +			      struct cxl_register_map *map,
> +			      uint8_t cxl_dev_caps)
>  {
>  	int rc;
>  
> @@ -519,7 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev
> *pdev, enum cxl_regloc_type type, if (rc)
>  		return rc;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, cxl_dev_caps);
>  }
>  
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct
> cxl_dev_state *cxlds) @@ -527,7 +528,8 @@ int
> cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state
> *cxlds) struct cxl_register_map map; int rc;
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
>  	if (rc)
>  		return rc;
>  
> @@ -536,7 +538,7 @@ int cxl_pci_accel_setup_regs(struct pci_dev
> *pdev, struct cxl_dev_state *cxlds) return rc;
>  
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +				&cxlds->reg_map,
> cxlds->capabilities); if (rc)
>  		dev_warn(&pdev->dev, "No component registers
> (%d)\n", rc); 
> @@ -850,7 +852,8 @@ static int cxl_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *id) dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem
> init\n"); 
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
>  	if (rc)
>  		return rc;
>  
> @@ -863,7 +866,7 @@ static int cxl_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>  	 * still be useful for management functions so don't return
> an error. */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +				&cxlds->reg_map,
> cxlds->capabilities); if (rc)
>  		dev_warn(&pdev->dev, "No component registers
> (%d)\n", rc); else if (!cxlds->reg_map.component_map.ras.valid)
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c index 9cefcaf3caca..37d8bfdef517
> 100644 --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -33,7 +33,8 @@ void efx_cxl_init(struct efx_nic *efx)
>  
>  	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability
> found"); 
> -	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev,
> +
> CXL_ACCEL_DRIVER_CAP_HDM); if (IS_ERR(cxl->cxlds)) {
>  		pci_info(pci_dev, "CXL accel device state failed");
>  		return;
> diff --git a/include/linux/cxl_accel_mem.h
> b/include/linux/cxl_accel_mem.h index c7b254edc096..0ba2195b919b
> 100644 --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -12,8 +12,11 @@ enum accel_resource{
>  	CXL_ACCEL_RES_PMEM,
>  };
>  
> +#define CXL_ACCEL_DRIVER_CAP_HDM	0x1
> +#define CXL_ACCEL_DRIVER_CAP_MBOX	0x2
> +
>  typedef struct cxl_dev_state cxl_accel_state;
> -cxl_accel_state *cxl_accel_state_create(struct device *dev);
> +cxl_accel_state *cxl_accel_state_create(struct device *dev, uint8_t
> caps); 
>  void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
>  void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);


