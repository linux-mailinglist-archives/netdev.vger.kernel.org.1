Return-Path: <netdev+bounces-174007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B7A5D059
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BDF18899AA
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2625F97A;
	Tue, 11 Mar 2025 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JFfTdsSa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB41EDA3D;
	Tue, 11 Mar 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723528; cv=fail; b=lYPxSNMx5Ly2G+YHmEQMVBnWm87MVEbilWxzXYuYrxQcTQd1erqL7fpTBoGkYlwVQHFnO/SgZxzWPgYNmr1RCjasbEaM9CYra5t35F2noBcW7OlNQ4JjQqWCsu8tjfkwGUz5pbWwEJUtxwyqq1bMgn7bUGdQYOGXVQcuyoX/g5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723528; c=relaxed/simple;
	bh=32E4rLkru+olxUwHuy56jFn5AijvnBlzA2OdU6Vq2Mo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=dJo3eQ9K4zCF9DjEQQZ7Fk8dWoaeg7q0D7Rbt6WIYZ+bQ4HSDLqD4Y1y6I3R3BWOkjBKNCjpHvTaci3S2cLVS7wdgR/7c5R+TfPo+tTUkACNbEdtwOQhcsNvaDaT9ttI+qxagpoILIp1/WR3wfBWd5cYkqswrMpWo0TaXbMKurM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JFfTdsSa; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oefC2pGIuhP4tG1UPv4NgbNSJ3Vo/5z9ScdqXY1pUGAX4Axk+byqTS2xGriix5Ti0Wt2u1IjhZ9+xt64kim/Zs5mE+zpF0y71jvjwqGU9FOfXkykItoVM0uatx3C7B6hlYO+VV22r7v2XH+slGGCmKpUB7duN+GE+BkuyVka/pu6BW1q3LL8PwrEcnSnXgFXL3dvG0EcdMqMJgnnYFYuPpxJVh5GflI1hjVk/JchsJjSLSZNLdo1daIV32iAsWsjUGm4yWoohm5n3R8QESsfvA/C9coPeANPjQsii+mxE2zgXd/VNu84rMwliQ+fd8Ly7eDMGXr+8jAh5gZ4tkAsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkncEissyycmxZEHie1nqS2WjVQcl+x7QjWnlvmy4zg=;
 b=rmCS0nynjYN4z5I8NRV36lM/cVq69M4OUUj9iyvieThsTCRRzRT1hO6SNbjGOWi1z4XlLyagKXQZm1yRsMaS2a0+2LfiA9AelPz0IxIFUMhGktOt9DBNXkX0uSAkLyauWhJAq3QHtQe7l0cl0D/lVFKvIGcmlsZIyURh+6RQcWIOYX/m5JtJBHt2ZbzkgeSKmsLpD+j3QLpoeXpsVuRYAMe2/mPQApLlG0ZyPGymWPv+DNJ/9gbAetExDr8hxo9lK379B4DvIK6ZzTPvs/Y1KMDZ72Rqm07tcH/maScDXm+qjrOEvcJGw8nakRsEcLECXvbdKuV4as1p2THHPV4iqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=samsung.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkncEissyycmxZEHie1nqS2WjVQcl+x7QjWnlvmy4zg=;
 b=JFfTdsSaC2nIYt2DFZh920MOmHwPU/VHUEFZNe0WUU8KsM/oq0JaL/Pz0WEaQgEho5euOwfXyfuZxuVzcwetLqfELZ80evGL4/kinH+p8qu6ag7n09y/AO4xvYBW8vid+0vbcDwszW9ogXVEDzX6mjBknC7+v9a4s6VMTd9hhmM=
Received: from MN2PR12CA0010.namprd12.prod.outlook.com (2603:10b6:208:a8::23)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:05:20 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:a8:cafe::a3) by MN2PR12CA0010.outlook.office365.com
 (2603:10b6:208:a8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 20:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:05:19 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:05:18 -0500
Message-ID: <ed05f435-e628-4d91-8584-cd8f120832c0@amd.com>
Date: Tue, 11 Mar 2025 15:05:17 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 03/23] cxl: move pci generic code
To: <alejandro.lucero-palau@amd.com>
CC: Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: f508c9d9-44f3-4ad3-f2c9-08dd60d80c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGowMkx3TDFkaU5PK1FOdjhuQm43L2ptbEJ0VFNoU3dQTHRvRWZFVkh2bHJK?=
 =?utf-8?B?QkpMM2FaTFgyVG81b0dTNjd4MWRpdmg4b1FONWs4OThISXNnMWt6eUFUQkdL?=
 =?utf-8?B?SzBZVVpCMkh2ZzJlS0NIbjc3eGFVVlJsaUZ0c0FvNTRkUFQ1WlZGQXQxYlAx?=
 =?utf-8?B?U1FiTG54OU5jTGpoMll5dEZaWlRKMjFOd1hpYTh3eWZWZVc2M0huQVBZTzZV?=
 =?utf-8?B?SitRSHpvWVVlRlZtbHVESDRpNWtVWFE3Z2JEQ1FpTzdlUllOVWFSaVl3ODBV?=
 =?utf-8?B?bVc4Rllib3NKQXo1NWZpaFFXa3FmL1FMR2hqWUpQZTRCY0ptSnVjekJlT0pw?=
 =?utf-8?B?U2JpREloTWZRcWRqZEVobDczbnZvaFdkU2xMYXNIaENIck15c0pJVHBVWW9k?=
 =?utf-8?B?VmR5MWM1cW5YbURkNzZzRk84eTQxLzhKZDR3SWg4WWVmV1JteXZHaEE4NEJQ?=
 =?utf-8?B?cFBZb0lHUmNJa0NlYVFDNUd2MEhJeDRxbjN1STdWbzg2RUV4MzFvcW91bXkw?=
 =?utf-8?B?R3U0eStveDFzRXlQSkVtMk5Td2RzZjBMRDNONDFNUlcwY2ExdU5HSmFEeE16?=
 =?utf-8?B?SGRlcTVjN0FhWVo1Yi9LcjJ5a1RPTi9jN3g1dWJ2Sll3d2RGdHJpU3ZIMnRh?=
 =?utf-8?B?MzBHKzJVTExXYldUdW9MTG5vUmtJZlBueXd0elZ3SEYzb09ZeG1uN0hoYkdi?=
 =?utf-8?B?Ymdab2plYkVNN3diRy92UWxNUGRSbHBUN3hhcGd1Z2xaR3lzcHFsdDhPcysx?=
 =?utf-8?B?T25LWUsxUEdCMEdtN3hEVGF2WFRQaHZUZEpheXB1cEhQa2RIR1MyaVpOK0M2?=
 =?utf-8?B?c3l0YllZNzExaFZZeFFPVk5KQks4ME44K1B3Mk9xU21wV2NBVUgrRnI5NmdN?=
 =?utf-8?B?RzV6V2M0b0lGcnMzRzYxMkxVcDVZWVUzVEY2d1NIbFN2dVpkYUJhNHU2NlVW?=
 =?utf-8?B?Y1Z2VUJLOUtCNENxSzdZNU9LUFNHejBjZVdaTzFqOCtPV01yd2tla2FiQWNW?=
 =?utf-8?B?bllXUDQxL2lEQnQ4KzNodDRLTXpxSXJGTXd0S3VIMFFMNWM1ajR2RmlhK1lU?=
 =?utf-8?B?TXpVK0JCMUtjd3VrQ2FKa3cyTXNDaEdGajdxdTF6UVUzZzZWMlBSK2x0TExj?=
 =?utf-8?B?UWU3YmpkZ0IxdlVqcG9yLzFFbU5oZ0x3ejh0Z0VrTGdEY0FJMDh3RHd5T1M5?=
 =?utf-8?B?M2NqdVVWL0tveDdTenljcERlaFNmaXNsVXA2ZHpIYlBranJ0TEJ0VWVnK2hY?=
 =?utf-8?B?M1hNT3Z3RGRUQTRzci9NZkZxMDA0OWk2bzdHTFJJUHpiRm8zeWtmMjJaU3JP?=
 =?utf-8?B?M3I0cXBudm5OSXQ1d3RuL0xiZVJTejZhLzJMSzFIUzhydXF4ZFZrZ2RuZHBF?=
 =?utf-8?B?aXVXNkIyUzlCM3dzVjc0OWorSGUwMHdNZHNvdzVESVJhT1E2aTRjUklHN3c4?=
 =?utf-8?B?ejhWYXhQZUdXTUZRRzJqMStvZzNNVU5pdktSaXFYTlFYVHFlZHZwLzU1eTNi?=
 =?utf-8?B?Y1gzMVBqeXh1b0VkN1VXRVk4YWhCcjluZWNiUlJtRm1iZWZRV2N5Y1RUdmo3?=
 =?utf-8?B?ckNmTzdHV1ZHTE9oMU9WNHBZWnF3dVI5UnFpeEZpRkdDQ1BRUUg2cXhyN2ZW?=
 =?utf-8?B?ZlZGdFVyUVVQcS9BQ1lGUjE0bmUyV0d0QzN3dkZ0a05weVBCajNXbDNNdXlZ?=
 =?utf-8?B?MVZmNE5aeEk5czhhNE83bHJZdVU2blBRcmovNS84bU9wcTRvclBrTVVQTnFP?=
 =?utf-8?B?UWtiYmJKOW53SnMrQmIwUHhabUE0NWFGMlc2SDRaWUhOVkVnQjdEQVJZanAw?=
 =?utf-8?B?MlRBVjJtOGN2VUR5d3hZNkRBVTJRR2tKb0p6OExpUFM5ZWhkeE9JVVczVmVn?=
 =?utf-8?B?bWw2cDRGWEg2VlBoNllVd2ZlZ25RYnlTL240dHhPWDhOelYvemNYNVlYM1gz?=
 =?utf-8?B?anZlbkJKNHVHUXhMa0dIakxxK3BNK0trQ1JkMUlsbEloNjhxS0lHV3RNbFht?=
 =?utf-8?Q?bmAM1bz+gomQEEEjHzCOGKeY34mvXg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:05:19.6330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f508c9d9-44f3-4ad3-f2c9-08dd60d80c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

[snip]

> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index ad63560caa2c..e6178aa341b2 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -1,8 +1,21 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  
> -#ifndef __CXL_ACCEL_PCI_H
> -#define __CXL_ACCEL_PCI_H
> +#ifndef __LINUX_CXL_PCI_H
> +#define __LINUX_CXL_PCI_H

Should probably just change this to __LINUX_CXL_PCI_H in the last patch
when creating the file.

With that:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

> +
> +#include <linux/pci.h>
> +
> +/*
> + * Assume that the caller has already validated that @pdev has CXL
> + * capabilities, any RCIEp with CXL capabilities is treated as a
> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
> + * registers in a Root Complex Register Block (RCRB).
> + */
> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
>  
>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>  #define CXL_DVSEC_PCIE_DEVICE					0
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index ef10a896a384..f20df22bddd2 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=cxl_hdm_decode_init
>  ldflags-y += --wrap=cxl_dvsec_rr_decode
>  ldflags-y += --wrap=devm_cxl_add_rch_dport
> -ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index af2594e4f35d..3c6a071fbbe3 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>  
> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
> -						  struct cxl_dport *dport)
> -{
> -	int index;
> -	resource_size_t component_reg_phys;
> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> -
> -	if (ops && ops->is_mock_port(dev))
> -		component_reg_phys = CXL_RESOURCE_NONE;
> -	else
> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
> -	put_cxl_mock_ops(index);
> -
> -	return component_reg_phys;
> -}
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
> -
>  void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  {
>  	int index;


