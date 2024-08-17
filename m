Return-Path: <netdev+bounces-119441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6A95598C
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 22:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2551F1F218A2
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 20:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB314EC55;
	Sat, 17 Aug 2024 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fM7nDrTy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93718824AF;
	Sat, 17 Aug 2024 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723926784; cv=fail; b=gxafnbPL1ymIjmEZnM2WAweJMyrS+30dhebaFfa1Av3D2R57GqHS95LBRNQjauumD+kKB+L+mYfnO/ZukBty2xXd28jGc0wvwbO9HjJCEgRVWXHRimOrxsu5McCV1U+eZz2ZB9/TsQjBs+YFRze/am0pUFxT7JJ7krCPlaUBMIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723926784; c=relaxed/simple;
	bh=rKNlgkhB65A4i/m5FmQnDU87kGKjyxVsMXciYcPtCRA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgSNfsfGMI7a3m1ndH+r5ksfF96jalPyW62ZmBdE33EOOs+mUfuroy6cUF7lQstvLybJ0GdW9esl55J/Aq56VlNZKoNmwVY5tKv8m5ze28gHEf13w77mEYZh6wwswRENwf0D1JaDPGPFjCkhjEs5zQbfzerp93rPiP7f2ef/9lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fM7nDrTy; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDOV1eD2p40WCVxUXIcBIMOTnD5QGJusWh4SPOuOKTiscbLyZtKq/lLpRbkz1etyJW44/yS9rU8AmAn14bVWtAdzj9TRcRb1RkWgt8uMjgyRwCLgasZC5Myix33+Eh6tCF23BzauY9iJvC2vSpHhC6IRZ2nyNKbNSXe+QBnKU0+GLpULDomQLG+kXoTNwi3dhZRexoBNz7YxMQuGGJmuJYpvMQyIh33faKcj5RVs0oc5lYU7KerUNt8M+ui0zzsKUDMCBYJ4nNgoh5Wf7ESmA14Aa9EddA6X4TzYnqmplEaWEs+ScACCJbKmQa8aNT+L+8yPD7vfltgIdRTLvgQeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wtw9uEzAQDQiye/h/kkN4VX/wpwtlJA9/FQkl9sA6o=;
 b=mH/cW4vFiSSniAZnWj3cACwE9IDpvxuh6dV8ZPya6Kx+UJuCMEBXlE2R0GZMIG4b8Kt7xppgLKoBJteezznYxA/oHixfesz1WyXZNn8XDphEFt65Cf+8HN8e6IEzwXVHlRtwM3v+65flU/cKZBDaZ0ONMC3G95pjIEEDfN2wLinqUzIHt4vDqNX/Rjnlo71DDgRwYTGQQ1j/XQDNBa+EN8vg4NtTWeBeDhh2ttjyN8GekFFfe+okmTq+scBTYgAgECKCh4rQzJAjCzQyVezKk9FpXtHACh7mUE4FWft/D4QY7NbcEjTwIj9qtYSwekWAdIbdu3EAWx1dP7wEKXuxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wtw9uEzAQDQiye/h/kkN4VX/wpwtlJA9/FQkl9sA6o=;
 b=fM7nDrTyTTTsyxKA6pPMHkrusY/74WoaWxOJwqI7fATj2ZBOK+qu2kXT6u5+57DDtgiewlPro7YVCuhskvl0EACzv2NBwpJql/xreNB3ueGG6VCxaYH5PpGjovFNCvV1tEfjDeUfm/Hfm8AKZ3PqFQG66gWZRVH4f8mvrVleIQgubdkAHbRrzgSTcrSBsB0bDc5xPoz6pdvBe1weuuCtiU/hF7jMYIA2yrfHai0Ysjt+AOtawMtHIHC2TJtU/wvXK1l76KLRg06/+urSRqcaTwIXgtmxBFMnmHvND09LpPPm6EHDF5HQubnmnZkTvwl4tstjZoOgB4MFbkDymQEwag==
Received: from BYAPR08CA0002.namprd08.prod.outlook.com (2603:10b6:a03:100::15)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sat, 17 Aug
 2024 20:32:57 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::8d) by BYAPR08CA0002.outlook.office365.com
 (2603:10b6:a03:100::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Sat, 17 Aug 2024 20:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 17 Aug 2024 20:32:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 Aug
 2024 13:32:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 17 Aug 2024 13:32:56 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sat, 17 Aug
 2024 13:32:53 -0700
Date: Sat, 17 Aug 2024 23:32:52 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>, <targupta@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Message-ID: <20240817232657.00005266.zhiw@nvidia.com>
In-Reply-To: <8498f6bd-7ad0-5f24-826c-50956f4d9769@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-2-alejandro.lucero-palau@amd.com>
	<20240809113428.00003f58.zhiw@nvidia.com>
	<8498f6bd-7ad0-5f24-826c-50956f4d9769@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: a4697354-d160-4e8b-3b6d-08dcbefbc79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CqRgHpWBvlzlBLuWcGZ6RBuQa+261YMMYkP91Afx6yen+jZmJF9yfEvJN2sX?=
 =?us-ascii?Q?ZUfJA9xplZ7FqDZls3lseM6ZGFBNnvnnqT9CIFqqJwEGOz8fDeTcnC0atQbf?=
 =?us-ascii?Q?eq/MulKYipO+Erwp+lK8xQ1+egQbH1sS83HyijM8NGNS+KLOmj2ERTdlvqjo?=
 =?us-ascii?Q?sVcg0dA2RB3timZ8S3pUSScS18b1ZLBxQERx1tIyEEa8T6dwjGzp5/WbyPYC?=
 =?us-ascii?Q?yzbw5XCHcPzVuikmOQ3wSOetuleO/KWY8ph9nXWlbLCoesrYVvltOrMLyWbk?=
 =?us-ascii?Q?MNmgcwmVNuG9Iq9VfiIdN/qiKtOHggw84jNAWf96PQ4LmzFmwQtNvGAhNlGk?=
 =?us-ascii?Q?F5UZUQm1fFNQImZWfz9+jG/zvVJG/O4BBM2TUJn1CbndR5IFCIO8DRYU/hvH?=
 =?us-ascii?Q?oP6c8VCePwDs/A77HiCl9STBEfLDq2RIQAePXUiJN9KIMEgGMyTrECgabcG+?=
 =?us-ascii?Q?e9b0dKEeEm7y1uvXUvslgfC2M7G2BocjBbEm7DYIycTzuqY1I01fyTaYgHLW?=
 =?us-ascii?Q?9aZmDi13lGw1yKO3bB+NiPy3GJKUOhl9Bn6oVqzA4wosPwoNBn60GDYieRyA?=
 =?us-ascii?Q?GEzG+8fRknhue7vz6yW0gzqiHALIHldnr+ApfsHShIggvcAMwDjpiV/Hmujp?=
 =?us-ascii?Q?7iL7FoBejlPMTgwO9zbOuENjDOdtHg+W7q6TJ78y2laUkw+8kZA+cxd/mceF?=
 =?us-ascii?Q?EHUocU/1bxCWYKupUdTFscbJMplJTz+0BeRalPd+CKn79JxGGhO/nXH/RN69?=
 =?us-ascii?Q?ooyv205kgCvf14fLI6MbF4Fgq3VA/bCVzbLdxaCfqhwqpu5SqQVIV7gv1nfK?=
 =?us-ascii?Q?BWYwDO51qctugjfmTEA3RBOt2NwoWBXthQk9NcQx81ClyyW9UmhkRA0dN1q/?=
 =?us-ascii?Q?jXRrocXA3ALpUYPVD8jQXNP7jvRg5JLi2w3on5sa9Udkt9YzzznKECB7rqaM?=
 =?us-ascii?Q?4MjH32De1lAQSUxhc7M7PcUIR+vf56TponlpWROOLoMcz1B3N19jxpgNmNBp?=
 =?us-ascii?Q?Ud0yjDmPXu/fiYA+ahTUuCG+KaiPFxCm+FKzy7o9drUcHcfOUlKNl5T9aT0P?=
 =?us-ascii?Q?5DHvzwu7u0JOwPUDPhQLUPDS5uHfMauoe01ihuXqxPm9Y2Rn/h5D/wra1sSc?=
 =?us-ascii?Q?9CG1wwT58iUIxIykuYNGriDBaSaRBIKvlTOGOe5k/7+ut2xl/22BEDlc3JPv?=
 =?us-ascii?Q?9+H9DL5nvNfMkYToXSRwxCWKTF4s276LDWMQpOoV5NOjlqCvrUfX/IjB3ARD?=
 =?us-ascii?Q?E7zgUL2mRzBGPL37edWb7IKe6GNzj6/ZHNvsw9EwQs9VODFWuQGyL0g3Oohe?=
 =?us-ascii?Q?x974VH4VYZydHfTH7Q4+2hW2vXZD1DZYR9uOTbFuDciIX6OjWVabyrqcwRWw?=
 =?us-ascii?Q?yStaCo9d/jrUsITKYT/4YvT0H2cae3u2ty5M5C4lGOOnduOQMQxXoiVhNlmf?=
 =?us-ascii?Q?UU7DLF9/w/ru/uy8NYMz8Pcm8fKBLjcx?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 20:32:57.3672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4697354-d160-4e8b-3b6d-08dcbefbc79a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433

On Mon, 12 Aug 2024 12:34:55 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> 
> On 8/9/24 09:34, Zhi Wang wrote:
> > On Mon, 15 Jul 2024 18:28:21 +0100
> > <alejandro.lucero-palau@amd.com> wrote:
> >
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Differientiate Type3, aka memory expanders, from Type2, aka device
> >> accelerators, with a new function for initializing cxl_dev_state.
> >>
> >> Create opaque struct to be used by accelerators relying on new
> >> access functions in following patches.
> >>
> >> Add SFC ethernet network driver as the client.
> >>
> >> Based on
> >> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> >> ---
> >>   drivers/cxl/core/memdev.c             | 52
> >> ++++++++++++++++++++++++++ drivers/net/ethernet/sfc/Makefile     |
> >>  2 +- drivers/net/ethernet/sfc/efx.c        |  4 ++
> >>   drivers/net/ethernet/sfc/efx_cxl.c    | 53
> >> +++++++++++++++++++++++++++ drivers/net/ethernet/sfc/efx_cxl.h    |
> >> 29 +++++++++++++++ drivers/net/ethernet/sfc/net_driver.h |  4 ++
> >>   include/linux/cxl_accel_mem.h         | 22 +++++++++++
> >>   include/linux/cxl_accel_pci.h         | 23 ++++++++++++
> >>   8 files changed, 188 insertions(+), 1 deletion(-)
> >>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
> >>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> >>   create mode 100644 include/linux/cxl_accel_mem.h
> >>   create mode 100644 include/linux/cxl_accel_pci.h
> >>
> >> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> >> index 0277726afd04..61b5d35b49e7 100644
> >> --- a/drivers/cxl/core/memdev.c
> >> +++ b/drivers/cxl/core/memdev.c
> >> @@ -8,6 +8,7 @@
> >>   #include <linux/idr.h>
> >>   #include <linux/pci.h>
> >>   #include <cxlmem.h>
> >> +#include <linux/cxl_accel_mem.h>
> > Let's keep the header inclusion in an alphabetical order. The same
> > in efx_cxl.c
> 
> 
> The headers seem to follow a reverse Christmas tree order here rather 
> than an alphabetical one.
> 
> Should I rearrange them all?
> 

Let's fix them.

> 
> >>   #include "trace.h"
> >>   #include "core.h"
> >>   
> >> @@ -615,6 +616,25 @@ static void detach_memdev(struct work_struct
> >> *work)
> >>   static struct lock_class_key cxl_memdev_key;
> >>   
> >> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> >> +{
> >> +	struct cxl_dev_state *cxlds;
> >> +
> >> +	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> >> +	if (!cxlds)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	cxlds->dev = dev;
> >> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
> >> +
> >> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
> >> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
> >> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
> >> +
> >> +	return cxlds;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> >> +
> >>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state
> >> *cxlds, const struct file_operations *fops)
> >>   {
> >> @@ -692,6 +712,38 @@ static int cxl_memdev_open(struct inode
> >> *inode, struct file *file) return 0;
> >>   }
> >>
> >> +
> >> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> >> +{
> >> +	cxlds->cxl_dvsec = dvsec;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_dvsec, CXL);
> >> +
> >> +void cxl_accel_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> >> +{
> >> +	cxlds->serial= serial;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_serial, CXL);
> >> +
> > It would be nice to explain about how the cxl core is using these in
> > the patch comments, as we just saw the stuff got promoted into the
> > core.
> 
> 
> As far as I can see, it is for info/debugging purposes. I will add
> such explanation in next version.
> 
> 
> >
> >> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct
> >> resource res,
> >> +			    enum accel_resource type)
> >> +{
> >> +	switch (type) {
> >> +	case CXL_ACCEL_RES_DPA:
> >> +		cxlds->dpa_res = res;
> >> +		return;
> >> +	case CXL_ACCEL_RES_RAM:
> >> +		cxlds->ram_res = res;
> >> +		return;
> >> +	case CXL_ACCEL_RES_PMEM:
> >> +		cxlds->pmem_res = res;
> >> +		return;
> >> +	default:
> >> +		dev_err(cxlds->dev, "unkown resource type (%u)\n",
> >> type);
> >> +	}
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
> >> +
> > I wonder in which situation this error can be triggered.
> > One can be a newer out-of-tree type-2 driver tries to work on an
> > older kernel. Other situations should be the coding problem of an
> > in-tree driver.
> 
> 
> I guess that would point to an extension not updating this function.
> 
> 
> > I prefer to WARN_ONCE() here.
> 
> 
> I agree after your previous concern.
> 
> 
> >
> >>   
> >> diff --git a/include/linux/cxl_accel_mem.h
> >> b/include/linux/cxl_accel_mem.h new file mode 100644
> >> index 000000000000..daf46d41f59c
> >> --- /dev/null
> >> +++ b/include/linux/cxl_accel_mem.h
> >> @@ -0,0 +1,22 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> >> +
> >> +#include <linux/cdev.h>
> >> +
> >> +#ifndef __CXL_ACCEL_MEM_H
> >> +#define __CXL_ACCEL_MEM_H
> >> +
> >> +enum accel_resource{
> >> +	CXL_ACCEL_RES_DPA,
> >> +	CXL_ACCEL_RES_RAM,
> >> +	CXL_ACCEL_RES_PMEM,
> >> +};
> >> +
> >> +typedef struct cxl_dev_state cxl_accel_state;
> > The case of using typedef in kernel coding is very rare (quite many
> > of them are still there due to history reason, you can also spot
> > that there is only one typedef in driver/cxl). Be sure to double
> > check the coding style bible [1] when deciding to use one. :)
> >
> > [1] https://www.kernel.org/doc/html/v4.14/process/coding-style.html
> 
> 
> Right.
> 
> I think there is an agreement now in not using typedef but struct 
> cxl_dev_state so problem solved.
> 
> 
> Thanks!
> 
> 
> 


