Return-Path: <netdev+bounces-117127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE59994CCD3
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A76A1F21EE9
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460AD16F27D;
	Fri,  9 Aug 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GxeEoRf/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CCC8D1;
	Fri,  9 Aug 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194112; cv=fail; b=R6ASNDkE23ZyB6pUcsLmrbtOLxsaTUufBa2LEjfenOujJCdofvaDUsmx/BoP8XaAvg8e//QUYYCEQz5gIYUvjVruxMCtRY12rfQxS0FZAxwCMKXnNhZqaGSddBElfhvbh+PRaKqgirgv0+wUPRwOShyCeJIjfL+DFSbCOxzw41Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194112; c=relaxed/simple;
	bh=Q1atb1MUgpRZ76xqryJrDdGOjmw+wd2hFCfYJUDKnLI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAoo1L6o/rCIQOdUdTtPK+1Zj6qOwhKLmn38ZS3hjRVHtTAAx/C/9xdGI6Zh46o8RyR5GPEWytHKX28rfeesgwHfrCnsLcNnEqxZHLSgAY4+IbedQh4gGry7EqZ2kX8YF9r7ULvyDyr9NQzu8k3uw06jyed2fKtWA47BEO9elNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GxeEoRf/; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw/2NiGeEn7XjEu5Zf2x/WycdnQQcDTkR9gsLABBMskLioCTjjOaC6eNed+B/NZqpjmuSFz2qbjOfaHYwDLcltQwcFM8+FYPxQp/UuXpofm0QYaux6+bmUKPVf18a0Td5F17B4nKy4IwyIR6QrVw8oIRxvK8pk8WAJfpfscx5Ngv6PLy2/4ar+B8tKDeGxXCUzl5H8dY5XPiYc6gYqGy0hgfLZ1DtD2AL28q2CG6PLnFZtTg2oKIi5k+e41VaDTUjKfXwObEDSn35/J81xpI91v2decy33x1TeboXzurA+L9oWxkycTd7S2zxVQKh8iDgiS98DNFiXz1jscVTpwFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaAgOLY4Cu2/FNQ6lSTBBG3PSilSAKvFVTk2s466QzI=;
 b=wsv5cN/kmyO5PSUO+GwgWTVzcCY7vdirqeQQTkjOVp6ZcDeRxotW4J3tf4WEA1vrlYQNpQHmI7TJZkg176U3HkMmYPSQLhNMOtc25FQ6pcDmU4iPURXNAgWqQUv0dR16Ev+bhplKGY36gwSvBCpjskq0LSmwDPxFDLeBuGEJOHzZYy8zFh5YL2f1GgSVIkK5tY/JwIy2n0VXZkBhmjTdb4AbcJlTZKlquMLOMTI/335ICAO2dDOtOqpLR7B32Shm0FtbFUI3YFOPhvX0Iyv5h474KyI51Nl82prDGFo8Le5fh0EMPyhjhW69wrDFDdM5T8reTc8fUGPfnI5TxfL39A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaAgOLY4Cu2/FNQ6lSTBBG3PSilSAKvFVTk2s466QzI=;
 b=GxeEoRf/IPpFR+lYLF92e5IsMmtXlvUV03GMxt2iW/JQen9drcr+fXTanBv8atg2klJeXa7peNdhRRbmKW3xUhRTqzNarwIP53d/hUtYLDjzJNC7UuIlT7OpBaAYo4g+54gZ6sNrKY4MQYmHK0r3cTrCfoUf61xXqeUT7wzoqiCfznQoj0YS80whBy+NQA9FdntFrE8MPQ24GbtZricTrPNUulkqPxv6LMEVmlj5QILCDqZ2MgoWP4Qt1KwDf4Z0U2wNLqxxt0bc2nd66ayq+sYId3lyQ+Vft1a/iuW0I5OSx+RhpZAGifMDSQF82QQgSwtyMEApqHWWA7dizefriQ==
Received: from BN9PR03CA0628.namprd03.prod.outlook.com (2603:10b6:408:106::33)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 09:01:47 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::ac) by BN9PR03CA0628.outlook.office365.com
 (2603:10b6:408:106::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32 via Frontend
 Transport; Fri, 9 Aug 2024 09:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 09:01:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 02:01:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 02:01:28 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 9 Aug 2024
 02:01:25 -0700
Date: Fri, 9 Aug 2024 12:01:25 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, <targupta@nvidia.com>
Subject: Re: [PATCH v2 03/15] cxl: add function for type2 resource request
Message-ID: <20240809120125.000019af.zhiw@nvidia.com>
In-Reply-To: <20240715172835.24757-4-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-4-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 790ab876-b6ba-4128-fe1b-08dcb851e5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z643ar++OQHWcm8qh5sumEBWTXgFryiPbHtkiddL+55NyTNldh3KIF8FmHTG?=
 =?us-ascii?Q?5wzDjpG2YQ1ESkMTSHQU3N0ep3I/jwEBnYkswH/t2QUiBMYsFGUGlfRUaGPw?=
 =?us-ascii?Q?h1mNMJR51tDQtBYMrksUijkdTLPEEw/EIBTC3Tmb5MztF5AE0ItmT4PEmNO8?=
 =?us-ascii?Q?ll1NR8NtgNpdkrVHByBNjqN9n3vAO6vQEmcJPJdYocdjgxyhLRrj2FKDkz2B?=
 =?us-ascii?Q?tz8dg4mRGzRCHWvgm0zj+AsNVxU1crM/kXXA6a1vd3R2Vs5IjMBjCbGCdzQS?=
 =?us-ascii?Q?Elqik9lXsRFgHCy6c5PjxCfzx+Pz9fm4NvP8SSfVxv3PScdXcZNR/HTojqV2?=
 =?us-ascii?Q?L71IpexPnpqQRtjXNDcO6SA5s2epId1k/clWJBINqkOlN0EvcOp+8l8dk60r?=
 =?us-ascii?Q?qVjw4SSbWHgwBrGTFiIHD8HryVL4Uhh2KbjARq7FgJb11o4PgVAGbpJ/Z7s3?=
 =?us-ascii?Q?Yr6H9q5BgrPnhJkxGCFfzygCm9CyOJBGT0PvY908K+RMxUhLyublps933Hp3?=
 =?us-ascii?Q?nOC2rL+uytPyu5yiHdVxfLalMrUyGsiSvnLny2SNqKzQAMiXgoihMjHuMs1e?=
 =?us-ascii?Q?Bn7fOeXMDjZHNdSQ98iekh6puWstCjl3Q3qcTbTofffAbnTmw0Ivvlk22mBc?=
 =?us-ascii?Q?hZqURU1HWyjPxRLlA+LhF+rLP4QKwcT/mmh/5a9062r0vmgPnN7UJ/7d4Zre?=
 =?us-ascii?Q?V5DGo8V5KGbimxX/ixiXPiyO+BwgREmwM4spgDt+DFN2AqPZRUD/d/1St+tq?=
 =?us-ascii?Q?PDN8bA5863p3OOXdRsUXtcBgdkVhadUz1o2CcI5NjjRAu0fGMD7jZLF6KVdn?=
 =?us-ascii?Q?piQqeqtgdoiRH0Wfj2YYRsu2raWXQoQs+x0P/xkjFFUir3++ZkSQx9eJ0Aa0?=
 =?us-ascii?Q?V8d/gaS5ZjGO+aLlxKkaN93fY8f46o1iAapF+1iJbWVMg4HnCWJ4q4QrYoU0?=
 =?us-ascii?Q?a1gGFtJjxz6qnh0xb6+Fx/79gBlpc8AWEWQC7f245uYcRMe61pL/hAqTlQnv?=
 =?us-ascii?Q?VR/78A2SRdsr9Uj1hT3m97ZPj+NbHv8H7ytzyN8YAWKc/+U6pV/FRHnBtUHw?=
 =?us-ascii?Q?k1r5D8lo9CODl8VWJM7/NAD1ASp8/Hzt+Pw2LLEhNQG5eezA07UKwGgDyAnl?=
 =?us-ascii?Q?XvirQLME6vPVcDYzOAP8e6nwNqOypupD37m+WiYcm7ulT2cF8exvcvt/u7pq?=
 =?us-ascii?Q?dEQOba8IK04y/KGVW/X1EWZh9hcoJrJDd8V97izXoXe52pqk7AaAtVa3bR0c?=
 =?us-ascii?Q?IQ1U7OELCrV+FoaMxU2kw3WXEOZYx0Uts3pHIovd9+M601XrzXS9Zz3Ht3s3?=
 =?us-ascii?Q?KnFLdy79Bs52PPj0/29X7DeHVnd5/aitdwCBwS+LLYyc+YsI5Q5XnQmsBuOH?=
 =?us-ascii?Q?X5e8MaIX6zgaAWQVX0m8Gm3OCmT/MioVT3P60Hr/FR+Ofxo4swb+MaNTUTzc?=
 =?us-ascii?Q?Zk8htpqX+Uk1PiiaxNny+tIGOwEWsXWg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:01:46.6628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790ab876-b6ba-4128-fe1b-08dcb851e5e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857

On Mon, 15 Jul 2024 18:28:23 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device requesting a resource
> passing the opaque struct to work with.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c          | 13 +++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++-
>  include/linux/cxl_accel_mem.h      |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 61b5d35b49e7..04c3a0f8bc2e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,19 @@ void cxl_accel_set_resource(struct cxl_dev_state
> *cxlds, struct resource res, }
>  EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
>  
> +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool
> is_ram) +{
> +	int rc;
> +

In PATCH 1, you got the resource type enumeration. Let's use them here
instead of a bool. 

> +	if (is_ram)
> +		rc = request_resource(&cxlds->dpa_res,
> &cxlds->ram_res);
> +	else
> +		rc = request_resource(&cxlds->dpa_res,
> &cxlds->pmem_res); +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file
> *file) {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c index 10c4fb915278..9cefcaf3caca
> 100644 --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -48,8 +48,13 @@ void efx_cxl_init(struct efx_nic *efx)
>  	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>  	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
>  
> -	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds)) {
>  		pci_info(pci_dev, "CXL accel setup regs failed");
> +		return;
> +	}
> +
> +	if (cxl_accel_request_resource(cxl->cxlds, true))
> +		pci_info(pci_dev, "CXL accel resource request
> failed"); }
>  
> 

The guidelines of error reporting from a driver is mostly considered
from the user perspective. If it is an error, shout, let the user know
what happened. Otherwise, we usually don't disturb the user other than
telling them we are loaded and everything works fine.

Please use pci_err() instead. So the user can spot it from a
message folder filtered by error level in a kernel dmesg logger.

> diff --git a/include/linux/cxl_accel_mem.h
> b/include/linux/cxl_accel_mem.h index ca7af4a9cefc..c7b254edc096
> 100644 --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -20,4 +20,5 @@ void cxl_accel_set_serial(cxl_accel_state *cxlds,
> u64 serial); void cxl_accel_set_resource(struct cxl_dev_state *cxlds,
> struct resource res, enum accel_resource);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct
> cxl_dev_state *cxlds); +int cxl_accel_request_resource(struct
> cxl_dev_state *cxlds, bool is_ram); #endif


