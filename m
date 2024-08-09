Return-Path: <netdev+bounces-117120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9E694CC5C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308BD1C22DCA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D91175D2C;
	Fri,  9 Aug 2024 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OkL1wKcI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47218DF81;
	Fri,  9 Aug 2024 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192486; cv=fail; b=jpD27Pd/+VrKUHWEoy+B1dRR9vMJDycv9BQmK3bR3VVhhLqI3KFBn0n3hCWEdLRR9lw215kn5Xv8jROlar2pmgoD/FySO4GPFuLEnYkvO3fGV4S65Rk3ZsDjaf0fLeEnQVQRDjBKtZ2cDoeKsZ9n/EDEU4NQggCp0z3PDSntDAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192486; c=relaxed/simple;
	bh=w15ehbYRkqCPZtTt1fPXYvAdegjYXmhjncSw/mcH58s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKNJpa9IByT9wLmqZohSpdRgPIALW+9pjWfYS5L4Cbp7mbIzylsgVZq5XFR0Q0TSbhCuABeSMOQ0Uv8Ook3ENdskFYWERVhEbhT61XxiKOYKpgdkF2N06pVEcxxwK/WDb835xCud2rS6thmZhUdp3ZZZB5+JEOos2a55dMvdkyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OkL1wKcI; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9JA74a0cqUYuLHer7PUcdJPWNvu5deePzn0+il+y8oXXKrKbcB+7cvs48tdagbfDLim8PzQRHELzff4GSK+WLEuKlIeZGfMGbLjldCNgBCwFjysj+7X9QF00tKdiVPLSpcxh5GPmiwoE5xHM0ftYtLk7Ay1y7xuzZJ5Luz6XQDw1HvUC0YxccIAmocS2lEF03kOFlni3qzEd4p3IimbggJgN8v2IeV3A6Nsfo1fFA7SfgHBcBJGfFbuKIU41tyGEQgmefuskNRzxEzqTfedkp6zMe70Wr+uEsK/lbQXYbW+c7zU7XOCq9vmqfdRx5L0KR1jIswrFwdRb7qRGy7xxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhLW3pDq+6bCnzTAz/FTRXVPk6QtK0LH95/HIdEiqko=;
 b=KA9hZvIjnGT5ZsSCsK5tT5FhApLifNpA+Cpo5+f0UoVyMZqeE7jb1wqB/yk9k3nGqQX1VYjp06hDivns17DBa3ydbqiBW2m/j0sqQxewyYrYxj7eDjDThDvMdp4wTF1l7J2EV8yNLDplh+8EJlnqZIDmeM3s4JWR2hKRVhhSW2YdjHxVn8+NBNOu/+f9tpHhgy8At67jN2dLj6wFBLEGlcNTCWIpzb+VP+R747MAsZdp93njsEsmcKFtqep4m7IFl+okyNym+QRk/mHzee/QSciMq/qFWhu9gjKJA6iC9nbdXqrdIIoBZGkwg6OSG9Gc9tIrRViY8wbImub3u6N/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhLW3pDq+6bCnzTAz/FTRXVPk6QtK0LH95/HIdEiqko=;
 b=OkL1wKcImPEka+DOEKaOHaZtsCgPtpRzTyEZaQ3IcCkmLKkZ0MWrak+Zo3/avDdBDkjd01sDX1iEYxVwxcB7ZiwH72/ElWtPAmVk9FMtRpuIZ4+vdLV2W/+oPdnUX4LPpCOmLulp1g4fMu19GJXfvN6W0MOnK++NNV+i/z8t6FNW3aOnPBIOZuNpvLIfbgLqM9AWb4JTY3s0tOGCnV51WejRpZX+P/WxUGiKK78Engxttdc7c0RNQEt5vV10FwL4bnIeM7fFnbioRQi27CAF8CoF7r2xNJenc4EytEuo7CI51UQcrTtsRSGrEkUraNOuYueOGxkvXsgPmkf4SCB5Bg==
Received: from SA1PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:2d3::26)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 08:34:41 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::cb) by SA1PR03CA0010.outlook.office365.com
 (2603:10b6:806:2d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32 via Frontend
 Transport; Fri, 9 Aug 2024 08:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 08:34:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 01:34:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 9 Aug 2024 01:34:31 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 9 Aug
 2024 01:34:29 -0700
Date: Fri, 9 Aug 2024 11:34:28 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, <targupta@nvidia.com>
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Message-ID: <20240809113428.00003f58.zhiw@nvidia.com>
In-Reply-To: <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-2-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a35c6e3-79c6-435d-4c1d-08dcb84e1cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQjAKbxA4oub+6ZOjR8gWw4M1mPBonICiOUhSdP/A5LZjK7Wo008aBpN1J0G?=
 =?us-ascii?Q?wE1nBwDDQrqiUF1+SeBJ4WgvOftUwzDeLcD5xo9a4T+6lrsnoFNplh8QIjla?=
 =?us-ascii?Q?90Q8zsOYWbjlSNNUivKu11xgvCsUm9vrSXrtYaIOwnzBO5efeL54v3xtmoym?=
 =?us-ascii?Q?HtzXWi716cz6Oq7jkip0iyQSUFsBg0gi80sWsODugO0BBhLYr3uYtnLsva/+?=
 =?us-ascii?Q?yEgN3cTtId5fqZIGcMxILUUl3XkWAm3j+EKvQ8CRdA0f/CReqJuNNDFzni19?=
 =?us-ascii?Q?C7USCztsCQArJv37uccSlsHbt1/p5lqlBwZPaESDeeq9aGy1ihjXCU7ShyDM?=
 =?us-ascii?Q?7/qFGCQWq+hKUNmPKUtcyUfCNEnDyhm12/OBxMqTTKdTXuSMSCeYqR38appT?=
 =?us-ascii?Q?l/BiiYJPPNrPcBZZOEcAX6yyvb34o2gJaL4m+Xpgg29FOpmc2bVdY3qPQHz8?=
 =?us-ascii?Q?QaAxxv9oMczlqe+d8VPVEoMTgciaPV5aJwg19ChM6cZMk1bGUJHso2nPQ60I?=
 =?us-ascii?Q?KuiyoxWggjpFM8okZ1kQWyIpGXXZhDf9AkodgEbrd9ZXxovU4y8ezT0o42KC?=
 =?us-ascii?Q?xgsxvx7NtgbmaZlDukXc9mer3s8BPSDijxEAni8AzPSDVK76FvMz2cX3imoB?=
 =?us-ascii?Q?9j3sacslBHY2zG+kCcH7awOJ2po1231cC1urqX19p3OLMjZDYYYoWXJTSVZA?=
 =?us-ascii?Q?SVr1Rl0kT8IsLuoApFYK1fCrXt0vup0KNs2HeXE3VQCFZ2XeBQPi/R0rm1GD?=
 =?us-ascii?Q?SMAisZMMQZLLIs7D/HDjWAd8xwaRdGXhnezwGb8HHCBnXT6QpCMG3Oi+bCgS?=
 =?us-ascii?Q?M/DohgusWCLsycfDBSzyqoDOqEbS6992YPdSibHHuMHza/8wpDj3zWOFoi/Z?=
 =?us-ascii?Q?NZlFCIeMEpFIXjbE/dK2b8yLQajT0yigVAlsfen6K4OYzCtm22tbNuqT8pvN?=
 =?us-ascii?Q?yXYwkKNuyUmIr8sB3cwLX0uNfaHOLhqU5cvxwVJH1W8+TFtQi3XAPgTwbuTR?=
 =?us-ascii?Q?x70ut7WYDtyKecZdEjg9eY6NdN0i0K6gbzeAWfzX9hSan4t1GwVpvCjShbov?=
 =?us-ascii?Q?dIg8IYlBL0hwFXE7PdVHBmhZYTyeX4r665vhI4ElxeuBA1IM/qTG/qdAgG9k?=
 =?us-ascii?Q?bYLVxpEZaSmHfOl2JSK8vs/SGLblCV0whGsNgjmQI/oMK60WqFZu9Gt2TnUF?=
 =?us-ascii?Q?dd0xXczhda31MRObBZEsedyZp9LQ474/bcL4NuJAs4kT2huo6VfQkpu3grub?=
 =?us-ascii?Q?QHhDQBTv8Us73+gP0tGCYdBld9NOTkoSj39bsHAaHKO7b9lIOcQ0dWxcKzbW?=
 =?us-ascii?Q?UWWHXKuUlyVjKo/yq1NRq0SmiZxnv/eBWtEvfVUKEL/BSrakPzoVrTSbsubo?=
 =?us-ascii?Q?xlJAKS7+hIgXWkE19lDToWs/FI8ECWEJQnz5TFfDof9TA44KZ1eDf+AVRv/r?=
 =?us-ascii?Q?xlNCf7uBLEp7GbRSLvZm8WLvSXmlL6o3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 08:34:40.9611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a35c6e3-79c6-435d-4c1d-08dcb84e1cdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012

On Mon, 15 Jul 2024 18:28:21 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differientiate Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
> 
> Create opaque struct to be used by accelerators relying on new access
> functions in following patches.
> 
> Add SFC ethernet network driver as the client.
> 
> Based on
> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c             | 52 ++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/Makefile     |  2 +-
>  drivers/net/ethernet/sfc/efx.c        |  4 ++
>  drivers/net/ethernet/sfc/efx_cxl.c    | 53
> +++++++++++++++++++++++++++ drivers/net/ethernet/sfc/efx_cxl.h    |
> 29 +++++++++++++++ drivers/net/ethernet/sfc/net_driver.h |  4 ++
>  include/linux/cxl_accel_mem.h         | 22 +++++++++++
>  include/linux/cxl_accel_pci.h         | 23 ++++++++++++
>  8 files changed, 188 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/linux/cxl_accel_mem.h
>  create mode 100644 include/linux/cxl_accel_pci.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..61b5d35b49e7 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -8,6 +8,7 @@
>  #include <linux/idr.h>
>  #include <linux/pci.h>
>  #include <cxlmem.h>
> +#include <linux/cxl_accel_mem.h>

Let's keep the header inclusion in an alphabetical order. The same in
efx_cxl.c

>  #include "trace.h"
>  #include "core.h"
>  
> @@ -615,6 +616,25 @@ static void detach_memdev(struct work_struct
> *work) 
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
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
> +
> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> +{
> +	cxlds->cxl_dvsec = dvsec;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_dvsec, CXL);
> +
> +void cxl_accel_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> +{
> +	cxlds->serial= serial;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_serial, CXL);
> +

It would be nice to explain about how the cxl core is using these in
the patch comments, as we just saw the stuff got promoted into the core.

> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct
> resource res,
> +			    enum accel_resource type)
> +{
> +	switch (type) {
> +	case CXL_ACCEL_RES_DPA:
> +		cxlds->dpa_res = res;
> +		return;
> +	case CXL_ACCEL_RES_RAM:
> +		cxlds->ram_res = res;
> +		return;
> +	case CXL_ACCEL_RES_PMEM:
> +		cxlds->pmem_res = res;
> +		return;
> +	default:
> +		dev_err(cxlds->dev, "unkown resource type (%u)\n",
> type);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
> +

I wonder in which situation this error can be triggered.
One can be a newer out-of-tree type-2 driver tries to work on an older
kernel. Other situations should be the coding problem of an in-tree
driver.

I prefer to WARN_ONCE() here.

>  static int cxl_memdev_release_file(struct inode *inode, struct file
> *file) {
>  	struct cxl_memdev *cxlmd =
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
> b/drivers/net/ethernet/sfc/efx.c index e9d9de8e648a..cb3f74d30852
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
> @@ -899,6 +900,7 @@ static void efx_pci_remove(struct pci_dev
> *pci_dev) efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
> @@ -1109,6 +1111,8 @@ static int efx_pci_probe(struct pci_dev
> *pci_dev, if (rc)
>  		goto fail2;
>  
> +	efx_cxl_init(efx);
> +
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c new file mode 100644
> index 000000000000..4554dd7cca76
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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
> +
> +#include <linux/pci.h>
> +#include <linux/cxl_accel_mem.h>
> +#include <linux/cxl_accel_pci.h>
> +

Let's keep them in alphabetical order. :)

> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	(1024*1024*256)
> +
> +void efx_cxl_init(struct efx_nic *efx)
> +{
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl = efx->cxl;
> +	struct resource res;
> +	u16 dvsec;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +
> +	if (!dvsec)
> +		return;
> +
> +	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability
> found"); +
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxl->cxlds)) {
> +		pci_info(pci_dev, "CXL accel device state failed");
> +		return;
> +	}
> +
> +	cxl_accel_set_dvsec(cxl->cxlds, dvsec);
> +	cxl_accel_set_serial(cxl->cxlds, pci_dev->dev.id);
> +
> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
> +	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA);
> +
> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> +	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
> +}
> +
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h
> b/drivers/net/ethernet/sfc/efx_cxl.h new file mode 100644
> index 000000000000..76c6794c20d8
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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
> +#define EFX_CLX_H
> +
> +#include <linux/cxl_accel_mem.h>
> +
> +struct efx_nic;
> +
> +struct efx_cxl {
> +	cxl_accel_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;
> +	void __iomem *ctpio_cxl;
> +};
> +
> +void efx_cxl_init(struct efx_nic *efx);
> +#endif
> diff --git a/drivers/net/ethernet/sfc/net_driver.h
> b/drivers/net/ethernet/sfc/net_driver.h index
> f2dd7feb0e0c..58b7517afea4 100644 ---
> a/drivers/net/ethernet/sfc/net_driver.h +++
> b/drivers/net/ethernet/sfc/net_driver.h @@ -814,6 +814,8 @@ enum
> efx_xdp_tx_queues_mode { 
>  struct efx_mae;
>  
> +struct efx_cxl;
> +
>  /**
>   * struct efx_nic - an Efx NIC
>   * @name: Device name (net device name or bus id before net device
> registered) @@ -962,6 +964,7 @@ struct efx_mae;
>   * @tc: state for TC offload (EF100).
>   * @devlink: reference to devlink structure owned by this device
>   * @dl_port: devlink port associated with the PF
> + * @cxl: details of related cxl objects
>   * @mem_bar: The BAR that is mapped into membase.
>   * @reg_base: Offset from the start of the bar to the function
> control window.
>   * @monitor_work: Hardware monitor workitem
> @@ -1148,6 +1151,7 @@ struct efx_nic {
>  
>  	struct devlink *devlink;
>  	struct devlink_port *dl_port;
> +	struct efx_cxl *cxl;
>  	unsigned int mem_bar;
>  	u32 reg_base;
>  
> diff --git a/include/linux/cxl_accel_mem.h
> b/include/linux/cxl_accel_mem.h new file mode 100644
> index 000000000000..daf46d41f59c
> --- /dev/null
> +++ b/include/linux/cxl_accel_mem.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#include <linux/cdev.h>
> +
> +#ifndef __CXL_ACCEL_MEM_H
> +#define __CXL_ACCEL_MEM_H
> +
> +enum accel_resource{
> +	CXL_ACCEL_RES_DPA,
> +	CXL_ACCEL_RES_RAM,
> +	CXL_ACCEL_RES_PMEM,
> +};
> +
> +typedef struct cxl_dev_state cxl_accel_state;

The case of using typedef in kernel coding is very rare (quite many
of them are still there due to history reason, you can also spot that
there is only one typedef in driver/cxl). Be sure to double check the
coding style bible [1] when deciding to use one. :)

[1] https://www.kernel.org/doc/html/v4.14/process/coding-style.html

> +cxl_accel_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
> +void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct
> resource res,
> +			    enum accel_resource);
> +#endif
> diff --git a/include/linux/cxl_accel_pci.h
> b/include/linux/cxl_accel_pci.h new file mode 100644
> index 000000000000..c337ae8797e6
> --- /dev/null
> +++ b/include/linux/cxl_accel_pci.h
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


