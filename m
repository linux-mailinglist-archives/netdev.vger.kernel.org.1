Return-Path: <netdev+bounces-127745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3224D976506
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE8DB219E6
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85AF18FDD0;
	Thu, 12 Sep 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bRG53a1V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E47126C16;
	Thu, 12 Sep 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131482; cv=fail; b=MJx16ERkT/6oMuJ9IxZM8ujl9Sa5Q10zulWLHP7vMF3FFb6SwPPJNpv2lR2XWjIgu3HBmRKCGzulH8yaSVI77gOym+p7LbUQiZj+cLTtdNiyh1WhZYdWnV//nGHTQ2NJRAOBqRObF17Opm4BzLuv4/k/OaPP73Ro6Pfay/zbeb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131482; c=relaxed/simple;
	bh=32qh6KFINRGON8kvafzVfhnUhg4LulWVWvH15xBbo6Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlK93FMFxyrMa9qUzyQ6Di6vcWhE6gmLDA//MHyDlLNDKg5rim3AMjYnxnJ5WS6ZHIykMnNcgIl9Su8UVYIcpBkqIMcCeeq3YKhkCcKnnqeb6LGKDKbqMcX7tRx8+glV5cczN1nWgXKDE0uWvn1i45lA01+TJ8MgUPWtgb00XUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bRG53a1V; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avwKCU+Ei9ujI6BXtXbsgXCV5Qr/TJhIGxGAbVs7aV+xPdtx1liGwGHQC6a9vTxXmQWFAVm67aeg2DASDprWmEkhgfiRTU5XxFEDjKedfjWzVXGjsJCw3ysX0v0rNvqZbTewvaXxAO9ozwH33SutqpBVKuTZ8jlTFAqjJSPEH7hgxQcdaGvxNqReiDeab5eQHSrSKvjU7nMRGIEMBwpmPZMtkWStEtBPzcgXoIZ/DpVGUMppjNUNKyazMQq4MXwa0SHlMLY7YJvOoP4YgJjAzKtEEn6BqSx3m77fTuw6XzqGpfUz/E/cN8GvS6571C5jlxbx0ey8OfTXaKkBR3sGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSuBtt+oYFTlScVctwdCTpoxINCy/IiWiZ6dbqyJ2zM=;
 b=gT7VjfH5p5QptXoRMi7gqPttguYCpdR6K5xTodP+AaNy29djC4NsApJm9nhm1/zsrXKH2xwOqcmvychTDVvmVS8sckXuc2/EVzq4cNdj5cLRlVdiUt2+tRWwjD1IvWJ2+9VzGw/ILcVMLaX9u0b6ToWeJnW5cocWuzSskoO79JH3otdJofAcMGRoeP4Zp6dHH1ArQIpnHGqRcUki9Lek0UVRLdbtCehFO4LlMcjvv3NRX1HYMN2/QJsxYZDd6Rsa0kztqYXbEAos22Kv9RvT5smQwXHOp9oQacLvuEiF8068FKHJwBpw6sXk87W3+OaVAI+xTBna/2O6HDwlfp6c+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSuBtt+oYFTlScVctwdCTpoxINCy/IiWiZ6dbqyJ2zM=;
 b=bRG53a1Vhf2d5CrFZKqXURZF6bWpHylkaX9xB4OIzSlh3aVm1mh/mV7t+x7Ud3K+/CMAjRsF0bDUSJSe5juxgp5HlK+OTICJ2NoR2qMwmx48j/lb5HTqU0BDBXGiKvP3zygoCwJS/wlvRJ9MKRhTuhaawd7/y41Sjbkc9rnvPKqfCwuKiIAgvjqSgmBPiepBPa+5Mknkf+KFY+cZPmek0IXP1QMhpzp4Qej8U3mZEa3/JffFADc0SKEu8q6pBpYeqHXJvOsBDy89fWfzHcyQUOiFUXkoI1KyRBNtuIU7+HxUzPG7PU4LecEoo3cluEvFWSHyZ6wCBVs5p/5UyHWr3w==
Received: from BL0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:207:3c::31)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 08:57:55 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::be) by BL0PR02CA0018.outlook.office365.com
 (2603:10b6:207:3c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 08:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 08:57:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Sep
 2024 01:57:53 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Sep
 2024 01:57:52 -0700
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 12 Sep 2024
 01:57:50 -0700
Date: Thu, 12 Sep 2024 11:57:47 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
Message-ID: <20240912115747.000023c3.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 6527d6d0-12e5-4e8d-7eef-08dcd308fdbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0MSPQ0laPy/8QBgVRUCzQgdBnSdHjKfu4c7HSbHxppG/KmzLkZWD6+uQjoQm?=
 =?us-ascii?Q?ZpmGADDEmlqIJpR4PMsQZ6SqZ/ACgIN0I4Lh7tnlCyon3lB5/2Iak2K3whkq?=
 =?us-ascii?Q?GpYSF404N2s8IG12DEKiWec44zII2q84gRgMff5PPZYzik7OBSXXSwwZ1pHg?=
 =?us-ascii?Q?wFBhkjIt1On7OPzGs6LdOXYlmtrNC6WUlW1XTuzx9KDNrA6IAaRTHMbspo3n?=
 =?us-ascii?Q?S1CkdIIBDRQ/DYESi9QYEkU/WNxj1VtjN1bO59mtU1TzCXTAOmJRT8yopUY0?=
 =?us-ascii?Q?ts6LA/kTJ4tkcye3CenQ/cs06rJVaedbV9I3kM46Gjg8D3BRHS+Dzunckgov?=
 =?us-ascii?Q?sMKnQHJ08TRGP6bwQ5GacRlyWxF4EW0cskhqtk4KgCGvXibXf7BvZmrRc8GD?=
 =?us-ascii?Q?B6p5n1TfWdLeziDRSrkyGD524fT5sp9UGiaxVI1ifBCbnXJXJCwlLO1Z98aT?=
 =?us-ascii?Q?VsaRz1pvQSTAQdMIYu/Au7dZ3vp5LZBqE1KRllLUkZZG+Ua8XFyniHSxI8BZ?=
 =?us-ascii?Q?xy1S68TOqhrXUFcJlL4CZNsRtDEYxF+rOObY4VqocrE+nZZ96ZMvaQ82jqAO?=
 =?us-ascii?Q?rO32KZjwJcFC8mdTcF+DDlIZ61zSNUXJs1fCEcUFg87OPGfQmN5RJYc3fRA3?=
 =?us-ascii?Q?dDx/wL3bqhoZZF226/i+6FhZEZADbs6PwZUiTcIJc+OcbpH2m66JUD9UEodw?=
 =?us-ascii?Q?3b7a8K4ghdIdOAzR/PwyQCcDg7H9g6AdND4maGgRCs64JqcaH9HUY8SIy+vB?=
 =?us-ascii?Q?aRYJZWtMxUhMsAscfzTUUoAy7RnsYjoqK69deUJFpGs0jlSg2cYXCx1FvJJ0?=
 =?us-ascii?Q?3NwYAu8pu/jBN7EFHYDNnjsc0Kyq03hWJhqCvtHM+qHlLuxdi8cPAF6IHsUz?=
 =?us-ascii?Q?vdlNZ6WDXMnJhbjSL8oKigqRUcNAFxU5Vizn8Jp/PmNvw6kbXd05cjQWsXfD?=
 =?us-ascii?Q?D6hF5Q1zG1yW8GGuTILOKIRdYGh84qmXic4GhGTueoo8YDmmJViJxBTvyHsT?=
 =?us-ascii?Q?ymuF7ncv/3UgR3gLeSW2oxTViKVFp02uBFteoai7gJLfi86/i9tV70c2Z28T?=
 =?us-ascii?Q?MPpADGBWsWRUIOA17vDBhJA0KabynlRIpNym7faK/VtyAS+UOR6Bz2Ovqosa?=
 =?us-ascii?Q?BI4GrRN1ZNx/YyzC2bd9I/uTfuO208oXFk9XAupBEkaI6XJRlBF2W6LbuGaR?=
 =?us-ascii?Q?B5X9os/kZYX/QTCqx9XA9f+XUb9v2YATYCUa9kekCc3NXULtKoA1McZ/yypz?=
 =?us-ascii?Q?cbczCl3gy0FlJddKP3IVRMrYWrj5U3TZqbAlDni2wCz6v3LWorT7iNbwg6sQ?=
 =?us-ascii?Q?1D1ktsycgy5GCnK1V6rzk1hMe6HbGIB2fEUIFtAi5N8QsJrivFDZyIDFem5I?=
 =?us-ascii?Q?e2XZUnHb7di2r26H0YHyLXkeY+wmlqhOKyM64zqaOLzkYKNmE91vIJCccj5f?=
 =?us-ascii?Q?BAtokLa5ZzkqyY6UltPPq4VYQ88S+psJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:57:54.7858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6527d6d0-12e5-4e8d-7eef-08dcd308fdbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841

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

Use SZ_256M in include/linux/sizes.h

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


