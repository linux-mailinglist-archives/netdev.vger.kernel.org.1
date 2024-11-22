Return-Path: <netdev+bounces-146850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7F89D64FE
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBBE283109
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B55A18870F;
	Fri, 22 Nov 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e5cQR9UG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA61DF260;
	Fri, 22 Nov 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308249; cv=fail; b=OdZE+rWQYNLtWESEFEjFM6889owGU9g0l41WbhhYl647GnD4VKpZA9GfH0p3nFhcPjajb3Hry2baDK84JE9hpkiSKk3VKbaRW87UGpj7awAinGYGJfgbpP1ohAjLPSdF3MhOjFPY7EpkrHoNlPlZ/VLQZBaXAkHex0rbMow1nxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308249; c=relaxed/simple;
	bh=yeticJvm9JyRYL1zpTmzHiWE/PTNTzSAMlAOd5UMmwc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=X7uKAsFc9A4bf1pCpLje3yBSi6XRgdoEugSV4VsaR8mRt1tidekVEFLJP8CuO7zsi6kgwpfrHZtMaLlXY1cv/3gsoCBy5cNdpPOWjgNNTAWlFNsyeANj/SHclSLuHOzfikH92m6Pj5xjUlvCPDeIhFWhFqa9el2Kk/8X1zO5m/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e5cQR9UG; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDCcsUxL0DeilL5Mnwx+1tWUGmMG0uY2mkFwKo7pDaHJ5z14KRxqY1J+UcPf4kAiN9eTBF6byVKBfrDY45mr21Qxml6Xx9ybTCjKTx4cXW1xSGJM/F8AZJVf4UCAQNPksqkJH6Y86lrmxas/7ZUHt0Xue+Tf3qURI8BW1+Sv878nka9ZDpJE96LHlAsZg12Pc7HOQejVm6ojjloiR03L6Fokj1cjmhuKzdrG0kYP8hlymtxNLPQNj0hPNx+nelxDvqW8XSLyLMf50kK52kPwZz2f3+/596N15WgFrtLV89RbWuM8BoMlfASeUyl+f1vJEl5Qe/UkdOvSXRE7V0sQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFP+WL0CIksHAKM2dc1rQqSovQmApsyv8zxkSB+5si4=;
 b=Uk25dyRmI23LSiLsCdpaEu6TxrdzRmXv7JqsBwwinfbdunG+RLyXuI4Cpqvno+5UAyVmWXccKBtQQyXTe8HEwvlxH9TY2zbHEPsNs04zY8DhdkODkve+iYcx3CSfmzD5TcDRiuXZcM/wXsG7P6knYRHJ/32taZAc0nlPJnqYGCU5swPq/GfcS2WCx1JPnBdi1wWIyylFeNH1+it6HWSPeEVXPC1BzoEvpXt1cBjzwB8shd+9lUNoPtKSHL7ZZSB+EPCkgUlk2FcYFUDoCvN0ezoEQM+UYAnPpeOHZdED8nGfJz1X0eqS2zUQxs/yn1LJogZkH6UgRKkn4DzXuAUzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFP+WL0CIksHAKM2dc1rQqSovQmApsyv8zxkSB+5si4=;
 b=e5cQR9UGegP3b5X/Kpn3pmorlOzMBVUqM2N9drenie/evTNQIczWehW/kYl8tZqYQWSP0TVrmDEL9IF0icAKZVmXznsPSYK8wL6D9DfFnoDKZ1R1QqoAuH4qR9pskkPEYpKyPbqmQHdsfzClz4nevHtIR2ZTo3u3v32M757hBjE=
Received: from BN9PR03CA0677.namprd03.prod.outlook.com (2603:10b6:408:10e::22)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 20:44:01 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::1d) by BN9PR03CA0677.outlook.office365.com
 (2603:10b6:408:10e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Fri, 22 Nov 2024 20:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:44:01 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:43:58 -0600
Message-ID: <35be71eb-7261-441c-8677-355658fbcb4f@amd.com>
Date: Fri, 22 Nov 2024 14:43:57 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 01/27] cxl: add type2 device basic support
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, "Cheatham, Benjamin"
	<bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 8543039f-6308-4507-11ef-08dd0b36655f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzVLbTh5QTNndDVqSWErRFZiYjRvbkR2eVFESGVRQlM5MHM1WTRBYWJmTHpN?=
 =?utf-8?B?OWhZYkZOMmR0SU0zRnRVZlp3NHVYRC8vVmNsZ1FicmEyRXBwNFQ1MVRUVHlL?=
 =?utf-8?B?N2xZVjhacE5mcjZnUnBPekJKUldWY0syaGdHZ2NHRlhES0NJL25aRk80OWxN?=
 =?utf-8?B?eks3d0ZSN3NmTkxqS0ZqMVZaNXkrWTh4bHM2V1c2RFVVSEdWTWY2UEFzREhB?=
 =?utf-8?B?dUNKakJiQWplL2ROQmZIYm84M2pPb1JoZHdDWUZtWGEwY2wvMDR6OVZ2RHhZ?=
 =?utf-8?B?bG5oWFdmRmxmdXBCbml4SjRiblAzWFpQU2lIMkJaUTJoc2pTZi8vdzZPZVpq?=
 =?utf-8?B?WGNNL0p0UFdubTR1Vk0xN0R4Y050cXljeUx1V1VnS1J4U1FuYm5oRzFuaG9L?=
 =?utf-8?B?NmpzTUh3cGNrWkRTbDd2K1hwU0FIbmxFdUNTYWdwRFpmdUI2ZHF3OURFSnRI?=
 =?utf-8?B?RWk0ZDdFRFQzZDNxMGhncE56bTlqaHB2dnJNMFB1RlpIRjRwOFpzVXNJejI2?=
 =?utf-8?B?WEZ5Y29XTSthQW41clJCMnluQVRCcFhzd21ENWEwVHl0MEFqUkxzMGV2VXYy?=
 =?utf-8?B?WWxJSnQxTE9Ld09xZmtyVUx5OVpYVGIwRGtmQWd6d2pMUWhPM1Y2dVlITGtS?=
 =?utf-8?B?M0l4Zkc4cEQ0cWtuT0I2aUxRb0o4UHZoWHc4SFJGQnJuK0QrZmxEL3ZiVGs5?=
 =?utf-8?B?N3crQWgzdWR1YUhSNExzemFraU1sYytMbXc1amxGakhHTTIvdXhVeHN5Wi9J?=
 =?utf-8?B?YTZxc0xrUUh2MTVxb2JrcFlOWXJrY0toN0hBbU1jUzc5NGdBOWhwSmV0TG1v?=
 =?utf-8?B?SmtNTU0yYlcwMzR2dHNHd3htb3NOVXU2NkNkeGExaGp6SndDYzJSeEphYmha?=
 =?utf-8?B?YzBWTmFXamRPRTd3QmR2NWo5NlN4OFUrTHBJdGVIYyttNlJsMktpN1VkSUdz?=
 =?utf-8?B?d1NxVzlkdExCSFNzdmtBTGFRalVDckpmNWJ4UzIvVkhXZC9xT2ZTRUZKNEVW?=
 =?utf-8?B?VFlwRlVYM1VsVEkvOUgvcTh2MnN2eWNQOEJZUk9hOGlsbytTSEJ5ajY2bk9G?=
 =?utf-8?B?aHlZd0pjMGg2V3h3MlJBZUhUdDlhL0RmRVNqUXZ5eFd4b3dNeHdnR050RjRC?=
 =?utf-8?B?dUlaRERKZG5HcnNDSFNBTW1FRGZvODFLemlKM0JmU0ZrUjljM0txbVJ2dFBs?=
 =?utf-8?B?ZE1FUnhDbVhZYUtqbG5rZmdIK3oyWFJlTzhFWU02bXU4V2piUmxzb21XdFRl?=
 =?utf-8?B?SC84NTRJQWlHOElpK21RakxtRVhDNGxhNTFobjQ1Ky90cS9LZXhnZXFxYW9K?=
 =?utf-8?B?b0g0a3ZxY2VTWjRWY0RKSlErL3VIZ3o0YWpmQkVkZDFqbXJoT0dTQlI2Zi9C?=
 =?utf-8?B?TXA4WExoMXlzMVVrVm1OOTBmVjBLUHJOOUJhYk9IdnNyZzM1bUFiMjdOK1Mw?=
 =?utf-8?B?MkJDZXZnV1ZCenlyVzFqeFc3YnVOYWUxSE9mdTA3bHNVTnl5c0Facnk2amxk?=
 =?utf-8?B?d0krTWdvYnY2c2QzdXhiWFM2SlZ0Zkhxa1BURXh4VnIrZGZ4a0Rma0F3R3l4?=
 =?utf-8?B?T0tDemlaeXhNSTBwRjdrY1ZGTzdqUmxvdkNmeTlhTnp0LzZjR1NYaW50bXVu?=
 =?utf-8?B?NVp6VE5RZnkvWis1OW5zZkNIcE5FVjB2SG5NZGVCaEVkT1ptQlE4dUhFL1Bx?=
 =?utf-8?B?bWpYd1Zmdm9PL1IyU3FTRitER1NrbW5NcmlyRmg0cHJqcmxPb3JDWnV2RUJH?=
 =?utf-8?B?Q3dFMDNLQzd2UVpTbU8vQ21vZEduU2RDaG8zZUZTdzBvb2Q1d2tJMHRqa1BW?=
 =?utf-8?B?Q2RYQWpJemhKRk1Qd29yMGkrWUdaeTZndS9remRQcUw3bnBCdlQ0RkRwTlYv?=
 =?utf-8?B?YkZPWVV5S1MwSmgvSjFXY3N1ZE4xeEY1SmZPV0FrTEhPL1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:44:01.2566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8543039f-6308-4507-11ef-08dd0b36655f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
> 
> Create accessors to cxl_dev_state to be used by accel drivers.
> 
> Based on previous work by Dan Williams [1]
> 
> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c    |  1 +
>  drivers/cxl/cxlpci.h      | 16 ------------
>  drivers/cxl/pci.c         | 13 +++++++---
>  include/cxl/cxl.h         | 21 ++++++++++++++++
>  include/cxl/pci.h         | 23 ++++++++++++++++++
>  6 files changed, 105 insertions(+), 20 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 84fefb76dafa..d083fd13a6dd 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. */
>  
> +#include <cxl/cxl.h>

Pedantic one, you'll want this at the end CXL does reverse christmas tree
for #includes.

>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/firmware.h>
>  #include <linux/device.h>
> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);

Would it be better to use a devm_kzalloc() here? I'd imagine this function
will be called as part of probe a majority of the time so I think the automatic
cleanup would be nice here. If you did that, then I'd also rename the function to
include devm_ as well.

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
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>  	return 0;
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
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource type)
> +{
> +	switch (type) {
> +	case CXL_RES_DPA:
> +		cxlds->dpa_res = res;
> +		return 0;
> +	case CXL_RES_RAM:
> +		cxlds->ram_res = res;
> +		return 0;
> +	case CXL_RES_PMEM:
> +		cxlds->pmem_res = res;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 420e4be85a1f..ff266e91ea71 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <cxl/pci.h>
>  #include <linux/units.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..eb59019fe5f3 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -14,22 +14,6 @@
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  
> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> -#define CXL_DVSEC_PCIE_DEVICE					0
> -#define   CXL_DVSEC_CAP_OFFSET		0xA
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
> index 188412d45e0d..0b910ef52db7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>
>  #include <linux/unaligned.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/moduleparam.h>
> @@ -816,6 +818,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_memdev *cxlmd;
>  	int i, rc, pmu_count;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct cxl_regs
> @@ -836,13 +839,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	pci_set_drvdata(pdev, cxlds);
>  
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
>  			 "Device DVSEC not present, skip CXL.mem init\n");
>  
> +	cxl_set_dvsec(cxlds, dvsec);
> +
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..19e5d883557a
> --- /dev/null
> +++ b/include/cxl/cxl.h

Is cxl.h the right name for this file? I initially thought this was the cxl.h
under drivers/cxl. It looks like it's just type 2 related functions, so maybe
"type2.h", or "accel.h" would be better? If the plan is to expose more CXL
functionality not necessarily related to type 2 devices later I'm fine with it,
and if no one else cares then I'm fine with it.
 
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_H
> +#define __CXL_H
> +
> +#include <linux/ioport.h>
> +
> +enum cxl_resource {
> +	CXL_RES_DPA,
> +	CXL_RES_RAM,
> +	CXL_RES_PMEM,
> +};
> +
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> +
> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> +		     enum cxl_resource);
> +#endif
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..ad63560caa2c
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_ACCEL_PCI_H
> +#define __CXL_ACCEL_PCI_H
> +
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
> +#define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> +
> +#endif


