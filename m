Return-Path: <netdev+bounces-127756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178469765BF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC99528214D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002C19E981;
	Thu, 12 Sep 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JOtrUi+G"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FE18BB9E;
	Thu, 12 Sep 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133728; cv=fail; b=hLLvUOaqc6h2uUJyhuZznwuLlhg5P2Pzm6Nyl3SzTSwYpGinOz+hbDmJbu+NBLDTRTNsqBr1/AKFTG17OcsaL4SzcLsftMPby5XeNBeOoXRoObHZycaw6gBjWYbfaWslICqXp8ctHZA5aoVd1FZ6p8GlGbgzzlii1n81Hn+43dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133728; c=relaxed/simple;
	bh=sN6fl8NrCHe1cexpbKykNY9ePgl2re6NqeQA0MNyaYk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iliD0Jtz9wPc7yM5pcRgSUryJWkea2fi+Gm8wJCzvec4Xr8wXsvXcI+pQiiWJTixgVS1V2wC+5HWmcSK2mIzSllgkeG+2zGVwhxbVUdKGPA/VzZKZNKLb+tmg0HU7IXGfjqsArjsoJkjUO5QpAlgHvysaVqJcnNyL0CLUmooGvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JOtrUi+G; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sya3wCVfaD3JQQLao8PXI9dpuRcXWf6PZGPXOlibTe1xfIeP8pJ473wd5m4U3LVaxTU5yxHh0ZnbU25CAkJHIKysOt2xZF0tBovsemN+vVYpnPYPvjlZpKgfir3532TY/kivU5wUt/FA7QVbtZLNlvspqKu+89IQg2+Z7wKSOpBCds2HK1PKOb1a6pNNl46NOBGcqQrz6IKQJbJGvwzO2U9jR6EZi/k1qdmEOTqZOyIBSGf5USPQ6glrtPudZJpvuD8zOg6qwTm8pFeCivfHXrbp6ocFMjN2tJJtAehMBLCLy2sOOiItf2600Q7Uu0g7RNjXpSLJcZArMXctQRhL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aqvKit6HGn6bXussU2yK3csqklTbCNW26SuehwxwrU=;
 b=DxlYiZTRZJG0oc5mbuEnOXftAS8wgBgSMEUzzAO91O8J6APxcLDBpXV8XPimnkKXLks4U/6tt5evnsx1iQeY+0RyIf/vTtCo8bYrT7l7Pr7qhnsKSEEHebjzgltU2ZB+rnvkym3ONUg9pISfkOPe7m+IA506LrgzDoHtblXh7j+vF33HcAoHU083A5EBhE99KQs1lh+Fgmt/Qqti5sluPxfRxGN9y3LfmRzBAm/jGRD0eiIDtn8ttupFWMQlw/zzJB1U/yh3mnhFMC/dxhQ+3lmhGe+L0qkTOEF7DEl9YVYdwTo+56ZCxHQxoI9rSotUbaFMz2M34WPfhzMt1azhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aqvKit6HGn6bXussU2yK3csqklTbCNW26SuehwxwrU=;
 b=JOtrUi+Ggj39Wtpm04iLmS30cPP6U0Qrc5GKKX9M9ohBL46jdqxRJ3fXDH25ydmAc92h3zbOG9BLpsXgLV5f5cjedmc12uv5+DXZuKZr8lWBxIDyKd/mbL9jakvSryJc7WkAotsTxT1LmaY04eP9gsM4LkyZ2WWb3Z9zxsmqIRYKRa7sFrbuJ9uM/50Hqvb3zEkLKp2NiDeH+Vkb3iU2wBBWrV7nniSyixxac+w3XNCtguiIFDVhMz+e9mENm8DUo4Mh8U16afiBpEnpM3mPgef/UGlgpJ3x1CNWKJEdj4n7nlhAIOMmE0lYv3Jqe+rliSxTSMnT74kKGMhhlhKg9Q==
Received: from SJ0PR05CA0202.namprd05.prod.outlook.com (2603:10b6:a03:330::27)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Thu, 12 Sep
 2024 09:35:21 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::fd) by SJ0PR05CA0202.outlook.office365.com
 (2603:10b6:a03:330::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 09:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 09:35:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Sep
 2024 02:35:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Sep
 2024 02:35:10 -0700
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 12 Sep 2024
 02:35:07 -0700
Date: Thu, 12 Sep 2024 12:35:05 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
Message-ID: <20240912123505.00006688.zhiw@nvidia.com>
In-Reply-To: <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-2-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e554cbf-12ff-4d23-357b-08dcd30e38ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GhBeWGaWnadXTVhBzMzUEV1FaA3+x1O6HgQ4h9aJJvXpYLasC3etJ7PG4K+h?=
 =?us-ascii?Q?hI6004xsjLNKRTL12mnp4P/iUkheS/tSLOPA8lLue+5FLn/KniCLKCfSHIOQ?=
 =?us-ascii?Q?dd+z8d8WLOh5YaQJpxrgAwFT8YJg1iU+KpTnNpZomUk1MiZ2FDZMhhqslbWD?=
 =?us-ascii?Q?ra+f3riBwE/o1jUVU+Zcbkkd6okbVbHklJcCqKvuO3hh5817yFzu98xC78hF?=
 =?us-ascii?Q?uHGFTEVsgrLYZg8bmG6GN3WN680sq2fAS8UCbIDvAOaWZrm3Z9t07LKiDUCU?=
 =?us-ascii?Q?eIiRqwl4ttqE7SbxXEydRDmRlEI0Du18atZ+cqlhD7p+mMn3LQhoZDVfuXhP?=
 =?us-ascii?Q?C4/IpEjH0Nv+fDIfllpUlnLeZjjmt0V/gSfTwFr31oqfNQGQOAo05Wqjs2sO?=
 =?us-ascii?Q?nVtl5G/b8JYpNgUXXN+CyvmSJtT6TnlLFlt6/RKHNkpRlYNSLgurFM7bTPjL?=
 =?us-ascii?Q?bVJs9ZFyC8NF7LoihpG6ZIwyRhKnMT9I4JXFoZl+93p6K/Vtkg73u98rUgY+?=
 =?us-ascii?Q?oGhycwTFlVOUZLsJIZeehB5+Nxbd/jI2SeH3UB+EZdcDlwWMSl1oTZil/c3I?=
 =?us-ascii?Q?E/YNtAs2rsnUkbkVpR7eqv3i1kXsV+qP81QIbzza/rl8Lzihpqa7Iw9JjoL0?=
 =?us-ascii?Q?vS61dnAWzSeNr1xdM9LGwBoX26iQcBMF3DP1mvxppkODgC2m/gmJR9fc9V8z?=
 =?us-ascii?Q?WIrEvB5RsQ+67KUGuIWuhFvieYgVVpR1t3GAlBLmkzKHiVkC6FV+Ku6EQw9S?=
 =?us-ascii?Q?jloABbEMkZgmJrtadONWikW0F2jr4jEW1jyCPqW/cbouT4sYcb2/U0EiKCgg?=
 =?us-ascii?Q?B7wlF4L7wzhr1xEujOUs0KwLS+SjzsAJSdpvmFZQV3pB/8CqOShg+HVCdtaM?=
 =?us-ascii?Q?ebNTmsgCCbkpQ1TzE2vdMtiE6a6VCqCHjI0fNyLa4iFARGCTV23G6DIz/2HB?=
 =?us-ascii?Q?jdL/YMdXj0Q6epkMtTvf2OA1WHCSiMSz2ZY4qV2Dy8YcXWZ44Q7im17O8UxY?=
 =?us-ascii?Q?RRTM4wkZ2iFLC7icgADJmzoepiAd3KTtFFq1gacnJLPbBuKdybibtcUIuX3J?=
 =?us-ascii?Q?Arm4ujpdbabXGwtZlCcMn0PI9Y+IUs2lrBJL9xXBwQgJzh+IkHQp/ZkUbclD?=
 =?us-ascii?Q?CxEE8LDOwCGiqpWOJO0JT3E8NfABZWFaJddRne36YyidN1W9Y4bDHS5GUg9h?=
 =?us-ascii?Q?40qwFS+1CSSTCMdKD5ZkxK5gSeTg510c4BOxU7L5sin2PRvuTCoKdnOfsGUZ?=
 =?us-ascii?Q?PHcLljl6ZmTaH66lHjAy5nsgiyo7vEpN+yclBlQTVAQ7vrNlA5xeYPdjXb9f?=
 =?us-ascii?Q?h9R77T7xWR6wzg84lQQCpdobd0rMo22wJqzY/cN/y4oUy3piNqCCH7585eoO?=
 =?us-ascii?Q?182CVRIqhveet8Pr0xWiD2nqu8zlBn0ARkchxvC8cZ40+ZkF77jOqaQgz0BM?=
 =?us-ascii?Q?mKdUbSMegiryS33cKX80AyvhTy0BuRKr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 09:35:21.3424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e554cbf-12ff-4d23-357b-08dcd30e38ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160

On Sat, 7 Sep 2024 09:18:17 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differientiate Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
> 
> Create accessors to cxl_dev_state to be used by accel drivers.
> 
> Add SFC ethernet network driver as the client.

Some thought when working with V2 about the driver initialization
sequence. It seem the initialization sequence for the driver is quite
long (since we do have a lot of stuff to handle) and there has to be a
long error handling coming with it.

Thinking the usual driver initialization sequence is long enough with
error handling sequence, would it be better to lift this efx_cxl_init()
as a initialization wrapper for the driver. 

It can take an init params and handling the initialization and errors by
itself according to the params. (The new efx_cxl_init() just
call the wrapper with params)

Thanks,
Zhi. 
> 
> Based on
> https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c             | 52 ++++++++++++++++
>  drivers/cxl/core/pci.c                |  1 +
>  drivers/cxl/cxlpci.h                  | 16 -----
>  drivers/cxl/pci.c                     | 13 ++--
>  drivers/net/ethernet/sfc/Makefile     |  2 +-
>  drivers/net/ethernet/sfc/efx.c        | 13 ++++
>  drivers/net/ethernet/sfc/efx_cxl.c    | 86
> +++++++++++++++++++++++++++ drivers/net/ethernet/sfc/efx_cxl.h    |
> 29 +++++++++ drivers/net/ethernet/sfc/net_driver.h |  6 ++
>  include/linux/cxl/cxl.h               | 21 +++++++
>  include/linux/cxl/pci.h               | 23 +++++++
>  11 files changed, 241 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/linux/cxl/cxl.h
>  create mode 100644 include/linux/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..10c0a6990f9a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. */
>  
> +#include <linux/cxl/cxl.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/firmware.h>
>  #include <linux/device.h>
> @@ -615,6 +616,25 @@ static void detach_memdev(struct work_struct
> *work) 
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
> +	if (!cxlds)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlds->dev = dev;
> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
> +
> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
> +
> +	return cxlds;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state
> *cxlds, const struct file_operations *fops)
>  {
> @@ -692,6 +712,38 @@ static int cxl_memdev_open(struct inode *inode,
> struct file *file) return 0;
>  }
>  
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> +{
> +	cxlds->cxl_dvsec = dvsec;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, CXL);
> +
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> +{
> +	cxlds->serial = serial;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, CXL);
> +
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource
> res,
> +		     enum cxl_resource type)
> +{
> +	switch (type) {
> +	case CXL_ACCEL_RES_DPA:
> +		cxlds->dpa_res = res;
> +		return 0;
> +	case CXL_ACCEL_RES_RAM:
> +		cxlds->ram_res = res;
> +		return 0;
> +	case CXL_ACCEL_RES_PMEM:
> +		cxlds->pmem_res = res;
> +		return 0;
> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n",
> type);
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file
> *file) {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 51132a575b27..3d6564dbda57 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/cxl/pci.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..eb59019fe5f3 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -14,22 +14,6 @@
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  
> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> -#define CXL_DVSEC_PCIE_DEVICE
> 0 -#define   CXL_DVSEC_CAP_OFFSET		0xA
> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> -
>  #define CXL_DVSEC_RANGE_MAX		2
>  
>  /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4be35dc22202..742a7b2a1be5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -11,6 +11,8 @@
>  #include <linux/pci.h>
>  #include <linux/aer.h>
>  #include <linux/io.h>
> +#include <linux/cxl/cxl.h>
> +#include <linux/cxl/pci.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  #include "cxl.h"
> @@ -795,6 +797,7 @@ static int cxl_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *id) struct cxl_memdev *cxlmd;
>  	int i, rc, pmu_count;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct
> cxl_regs @@ -815,12 +818,14 @@ static int cxl_pci_probe(struct
> pci_dev *pdev, const struct pci_device_id *id) pci_set_drvdata(pdev,
> cxlds); 
>  	cxlds->rcd = is_cxl_restricted(pdev);
> -	cxlds->serial = pci_get_dsn(pdev);
> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> -	if (!cxlds->cxl_dvsec)
> +	cxl_set_serial(cxlds, pci_get_dsn(pdev));
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
>  		dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem
> init\n");
> +	else
> +		cxl_set_dvsec(cxlds, dvsec);
>  
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)
> diff --git a/drivers/net/ethernet/sfc/Makefile
> b/drivers/net/ethernet/sfc/Makefile index 8f446b9bd5ee..e80c713c3b0c
> 100644 --- a/drivers/net/ethernet/sfc/Makefile
> +++ b/drivers/net/ethernet/sfc/Makefile
> @@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o
> efx_channels.o nic.o \ mcdi_functions.o mcdi_filters.o mcdi_mon.o \
>  			   ef100.o ef100_nic.o ef100_netdev.o \
>  			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
> -			   efx_devlink.o
> +			   efx_devlink.o efx_cxl.o
>  sfc-$(CONFIG_SFC_MTD)	+= mtd.o
>  sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o
> ef100_rep.o \ mae.o tc.o tc_bindings.o tc_counters.o \
> diff --git a/drivers/net/ethernet/sfc/efx.c
> b/drivers/net/ethernet/sfc/efx.c index 6f1a01ded7d4..3a7406aa950c
> 100644 --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -33,6 +33,7 @@
>  #include "selftest.h"
>  #include "sriov.h"
>  #include "efx_devlink.h"
> +#include "efx_cxl.h"
>  
>  #include "mcdi_port_common.h"
>  #include "mcdi_pcol.h"
> @@ -899,6 +900,9 @@ static void efx_pci_remove(struct pci_dev
> *pci_dev) efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +
> +	efx_cxl_exit(efx);
> +
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
> @@ -1109,6 +1113,15 @@ static int efx_pci_probe(struct pci_dev
> *pci_dev, if (rc)
>  		goto fail2;
>  
> +	/* A successful cxl initialization implies a CXL region
> created to be
> +	 * used for PIO buffers. If there is no CXL support, or
> initialization
> +	 * fails, efx_cxl_pio_initialised wll be false and legacy
> PIO buffers
> +	 * defined at specific PCI BAR regions will be used.
> +	 */
> +	rc = efx_cxl_init(efx);
> +	if (rc)
> +		pci_err(pci_dev, "CXL initialization failed with
> error %d\n", rc); +
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c new file mode 100644
> index 000000000000..bba36cbbab22
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + *
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> modify it
> + * under the terms of the GNU General Public License version 2 as
> published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#include <linux/cxl/cxl.h>
> +#include <linux/cxl/pci.h>
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	(1024 * 1024 * 256)
> +
> +int efx_cxl_init(struct efx_nic *efx)
> +{
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl;
> +	struct resource res;
> +	u16 dvsec;
> +	int rc;
> +
> +	efx->efx_cxl_pio_initialised = false;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +
> +	if (!dvsec)
> +		return 0;
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	efx->cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
> +	if (!efx->cxl)
> +		return -ENOMEM;
> +
> +	cxl = efx->cxl;
> +
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxl->cxlds)) {
> +		pci_err(pci_dev, "CXL accel device state failed");
> +		kfree(efx->cxl);
> +		return -ENOMEM;
> +	}
> +
> +	cxl_set_dvsec(cxl->cxlds, dvsec);
> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
> +
> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA)) {
> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +
> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM)) {
> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	kfree(cxl->cxlds);
> +	kfree(cxl);
> +	efx->cxl = NULL;
> +
> +	return rc;
> +}
> +
> +void efx_cxl_exit(struct efx_nic *efx)
> +{
> +	if (efx->cxl) {
> +		kfree(efx->cxl->cxlds);
> +		kfree(efx->cxl);
> +	}
> +}
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h
> b/drivers/net/ethernet/sfc/efx_cxl.h new file mode 100644
> index 000000000000..f57fb2afd124
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/****************************************************************************
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> modify it
> + * under the terms of the GNU General Public License version 2 as
> published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#ifndef EFX_CXL_H
> +#define EFX_CXL_H
> +
> +struct efx_nic;
> +struct cxl_dev_state;
> +
> +struct efx_cxl {
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;
> +	void __iomem *ctpio_cxl;
> +};
> +
> +int efx_cxl_init(struct efx_nic *efx);
> +void efx_cxl_exit(struct efx_nic *efx);
> +#endif
> diff --git a/drivers/net/ethernet/sfc/net_driver.h
> b/drivers/net/ethernet/sfc/net_driver.h index
> b85c51cbe7f9..77261de65e63 100644 ---
> a/drivers/net/ethernet/sfc/net_driver.h +++
> b/drivers/net/ethernet/sfc/net_driver.h @@ -817,6 +817,8 @@ enum
> efx_xdp_tx_queues_mode { 
>  struct efx_mae;
>  
> +struct efx_cxl;
> +
>  /**
>   * struct efx_nic - an Efx NIC
>   * @name: Device name (net device name or bus id before net device
> registered) @@ -963,6 +965,8 @@ struct efx_mae;
>   * @tc: state for TC offload (EF100).
>   * @devlink: reference to devlink structure owned by this device
>   * @dl_port: devlink port associated with the PF
> + * @cxl: details of related cxl objects
> + * @efx_cxl_pio_initialised: clx initialization outcome.
>   * @mem_bar: The BAR that is mapped into membase.
>   * @reg_base: Offset from the start of the bar to the function
> control window.
>   * @monitor_work: Hardware monitor workitem
> @@ -1148,6 +1152,8 @@ struct efx_nic {
>  
>  	struct devlink *devlink;
>  	struct devlink_port *dl_port;
> +	struct efx_cxl *cxl;
> +	bool efx_cxl_pio_initialised;
>  	unsigned int mem_bar;
>  	u32 reg_base;
>  
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> new file mode 100644
> index 000000000000..e78eefa82123
> --- /dev/null
> +++ b/include/linux/cxl/cxl.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_H
> +#define __CXL_H
> +
> +#include <linux/device.h>
> +
> +enum cxl_resource {
> +	CXL_ACCEL_RES_DPA,
> +	CXL_ACCEL_RES_RAM,
> +	CXL_ACCEL_RES_PMEM,
> +};
> +
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource
> res,
> +		     enum cxl_resource);
> +#endif
> diff --git a/include/linux/cxl/pci.h b/include/linux/cxl/pci.h
> new file mode 100644
> index 000000000000..c337ae8797e6
> --- /dev/null
> +++ b/include/linux/cxl/pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_ACCEL_PCI_H
> +#define __CXL_ACCEL_PCI_H
> +
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE
> 0 +#define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> +
> +#endif


