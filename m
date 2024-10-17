Return-Path: <netdev+bounces-136761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC769A300B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF15B288E86
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99B1D61A1;
	Thu, 17 Oct 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PLFcC+WM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4251D619E;
	Thu, 17 Oct 2024 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201783; cv=fail; b=cmxyxCbKmPhjvzgz8vJqWJovSMOjcQHsOqWloogaAqmtlwmnK69jrH46UONsYLuvbEtdsyROAS15LWBXoaTFUaPDlO19Bgv3v+7kgMdNHoLORn9xCWx1AYOGy/iziYZIhA5ppL8z/HVKlgHqqNRuVV2yY+Q27vo6X0nmfJSveeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201783; c=relaxed/simple;
	bh=BQILjr3xNwjWYepn7Vm42iggd2pF8I4JCGQvZ4/aSWk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=JdUn8ksODooIH15Mc4PllO4YXPBn6G+HcGRabFCcHZ2AvdGsJ5M8cgFYaMzBleHaUJ+tI8PBCHbUkoiP+0vTYaryDx0LD18jvPlSZshwuhu3vEXNn7QU1+6AjaOPzrNj1NKShNijdlDsQliuh/pReP1E6MVAPfmiShaPvKxEyxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PLFcC+WM; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuOJjq3cZ/oYl9Z2cEdKNArU4VszC/+1V7SaO8655Ggj2EqtpFKRvUl+KduDIctCd8xOzPJAKJc3CTTwSPo+XStpv3gTgdqvMLM6nl6uJNVrE/vZ31Siyu7wENMw/ChZC0pfZLTRPwhzGfVqlTElG4QbSop2/QCQkb3k/v7Mz/NoWBm1t22OoiWlRnJX6lGlkQVyx9zjUb7LnwVB5o9JbvlnyWZV5pD1zuHuT9Bb5j2tPk8r9a5fhnCB76YAJJ70le+iMeQkh2FAp1UQlbCoHByblw6KiO5qW8rmGqNeOj1a58CulPMt52wGEin9IuQPcznzBa3sxep4ymuEKByCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNJRUjMfzY0FVGAPAn5Bvc/iblgK69BQjG59CFaWn4E=;
 b=no5p5VlWl28RQZEAOoODb3uo27frWNNn+wAU6crtaMDczeviMxCbXKBm0F1PurDNRohd6B+HmFYVLB9nkkODy4fLA3wPAqKFHvq01XFgkoefVo9+Yh12HOmIXYcYcxxHw5r5iR6qwnVNF7+7+UlR/9En3Or3aa3zQC0FuZzK/ExW2uC/zDy9HXEgQSFhtnoFGpxbmFvXw04i81KujjDM+BnwwCdHDi6PRl/8Bb/poWZtFWzOB2BfG46DCR9pHlP6cbs25C6a40JTAlmXtDcMbyBN71uloynYwZTvnWxBWIGGIfXjXm4kL4s4nou6TPuEoOaMYJc2AUE10hF9sWlj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNJRUjMfzY0FVGAPAn5Bvc/iblgK69BQjG59CFaWn4E=;
 b=PLFcC+WMPHFTzmAi21WGi4UF7azpIfz69Fdy6HaDWrZmcPmTVciFxf5ZlWVp/ueX9HxRcdv8UsqjTaXsmGvXi3RO/SQ4mAYAfbuU5ChlqJwCO8QcUwfgOnByP0c0LXUuBd7aprU5gDciug5ubDiVgeDkutw9MbRVnkLRbe6m59Q=
Received: from BL1P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::9)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 21:49:35 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::9b) by BL1P221CA0003.outlook.office365.com
 (2603:10b6:208:2c5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 21:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 21:49:34 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 16:49:32 -0500
Message-ID: <4ce8cc04-71fd-424a-9831-86f89fcd7d2f@amd.com>
Date: Thu, 17 Oct 2024 16:49:26 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v4 07/26] sfc: use cxl api for regs setup and checking
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-8-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241017165225.21206-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a7fadd-e289-4215-9d4e-08dceef596fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z29yVDZWZlhMcmY3TW1kUTlVY24rYlp3MkcwQW9RbEs3d25tYlBmUEduT3dO?=
 =?utf-8?B?TXEybzlUaDNZSnRYUVNNRWIzZlhxOVJwVFJka3FtTjExaTU3V04rQ0RVbTBG?=
 =?utf-8?B?bXdla0x2SU80YXJYQ1dPM0xrVWdUTkZIbExjTFc2SW9ldTRxb2xEcVFEZnRj?=
 =?utf-8?B?MHlCZ1phZXZJWS82bUVJMVY4a2g1a1M0andNRGFaU0JhN1I1VUE5Ykptdldu?=
 =?utf-8?B?cFhPNmxzK0I1UjV1WUxPUzF2Q0hLR1pCTTBJaksvZHJDL25VV3B2bVgyTWo1?=
 =?utf-8?B?Z0pSaUZzdUw4cTNzWGFKd1EyVU02NHQvek84Um1EVXV2VU5jT3orbEhhcVpq?=
 =?utf-8?B?ZVdZaVA2MTJDSTBzTmkyOW9pbk1DZkVGbnZXSHpOTitITzU4RnJQdnhLWXRB?=
 =?utf-8?B?ZnFFUmVGS21DU1BDUEpmeDhsbkRhWXFKelRKaGVUVHhEaGg3RUdnK3ZNVmhR?=
 =?utf-8?B?UVlrNGlaeHRXYm4xaGtRN053ZURrd2t1dWExMi93em5IeE9pc21YTmtlN1BD?=
 =?utf-8?B?VThkVTF5c3Z5YXArOUZJUmN6YnYzNmZ1TGVEazh5dXRwbDNpYWkwVFh1cDdp?=
 =?utf-8?B?YTNiVzdoUUY3N3M3a05wUHgvT1lPSTVwTm41MmNjazh4Q3dqRUVXZm5KRzV5?=
 =?utf-8?B?aFNSTy9XZHVjbnJoczhRZ3QvNzNZczQvQkY0RHNqSVV2WEpJY1FrcXFmVlF4?=
 =?utf-8?B?cHkyS0UxT3dwVXVrRVA4ZXEvS3dDeEE2MTRDVXlONERMYXRseDdFT0g1VXR5?=
 =?utf-8?B?UnFIQW1kSEREcFRqUFJRNGhrRDFaY2VJMGpwMk15RmpDZ2tZVHdkbjZyQ1d2?=
 =?utf-8?B?WEsreWt2alBRdFJFY04zVEFNRE1MMzU4TlU4b2JkMEpRV21xcnhWMXJ2NlJ0?=
 =?utf-8?B?Y1VDUGJMNUljU1dsQWJ5cmZlMzYxVjMvYmpTaEVnVVNWTXRCbUxFSWVkRmxE?=
 =?utf-8?B?Z1h3UlJkODR4a0dsVUd5UytMRy9LZlU1WmpFQUpRRG9sS2dhWi9laW84Qmlm?=
 =?utf-8?B?Uld3WlpZbndKTHhQaG1wN3JjTUg4QnRPek5SbXBJM2Fia3JiMS9USDZpQy9s?=
 =?utf-8?B?WHJrMnBYWUdoQ3JnT2gweFg4ci9XdjBML29NYVJHODdSZ3FpNnNxMUU2WWlt?=
 =?utf-8?B?cHZMVDJVS00vMlBHTTVuYTJISkloeld2ZUN2dTFDbnM2UXdMM2VLb1Q4U0F3?=
 =?utf-8?B?NkRwU3FZOElveG9QcGJ5UUhUdDIvdkorSGN1eUF4UHExQk1adVFLZVZyVklM?=
 =?utf-8?B?VURCYUx0TFNGUWxHUVR4SVFCZ2dQWjQ3dk5ySUZESEh0amVvdW1WRkxwWThL?=
 =?utf-8?B?S1Q3NlpYVzVFa1lXTDYzK2M1cG5lQ0Z3Mlg1bThRbEkzWFp4KzliV0Jpbm5m?=
 =?utf-8?B?U0g4VnlrMXNOU3VmU1pDdTJRSVZoTXU2bjZGNFBrazhCUmZSWmtkWm44YXp5?=
 =?utf-8?B?WEwrVE9YRjJKWEd1UzRIOU9WWmVGM1lWVGZaeFJ3cjh6S0I4dUdQUjZkdWJL?=
 =?utf-8?B?QkNXSjZLcTdmdi81RTc5S0NMSFl3L0FHUWhzMGZ0Zm5uVm01V0RRZXNwMUZl?=
 =?utf-8?B?WWJ4NDR1U05uaGc5ZHFvNitlWDZZeGx5cmhncy9pVWF6eFcrRjN3c3FoMlMw?=
 =?utf-8?B?c2F4YytMM0l1UGU0QUZzdGl4YW41ZHhSSUhZYWNPSFJIbEVGSnFPdEpZWGc3?=
 =?utf-8?B?MEswbnRDQ1hjaVRrbHVBQUVrWHNZbE9qSSs0Q1RRYTdML1A3U1JRYWdvWWMw?=
 =?utf-8?B?dmVjcU55OFRQL0tabmRxaTVmMHV3dXg2UHYrenRBZ0Z6WG5uakVHRnlseGNn?=
 =?utf-8?B?eTN2NUk2MnBrM0ozaG9KUExieEoxVlhzMVJsVXkwdmN3UWJCWWp6T09ESFhv?=
 =?utf-8?B?a3dhTU9CcDdBNHBPZTlRZExSTVBVaTljVm1MdndoeHpuK2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:49:34.6678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a7fadd-e289-4215-9d4e-08dceef596fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318

On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index fb3eef339b34..749aa97683fd 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -22,6 +22,8 @@ int efx_cxl_init(struct efx_nic *efx)
>  {
>  #if IS_ENABLED(CONFIG_CXL_BUS)
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct efx_cxl *cxl;
>  	struct resource res;
>  	u16 dvsec;
> @@ -64,6 +66,23 @@ int efx_cxl_init(struct efx_nic *efx)
>  		goto err2;
>  	}
>  
> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		goto err2;
> +	}
> +
> +	bitmap_clear(expected, 0, BITS_PER_TYPE(unsigned long));

In some places you use BITS_PER_TYPE(unsigned long) for the size of the capabilities bitmap,
while in others you use CXL_MAX_CAPS. Right now it isn't an issue since CXL_MAX_CAPS is way
smaller than the size of an unsigned long, but I seem to remember Jonathan suggesting this
for future proofing. So, I would suggest setting CXL_MAX_CAPS = BITS_PER_TYPE(unsigned long)
and using CXL_MAX_CAPS everywhere (or just using CXL_MAX_CAPS as-is). Then, when/if there
are more capabilities we can just increase what CXL_MAX_CAPS is set to.

> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
> +
> +	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
> +		pci_err(pci_dev,
> +			"CXL device capabilities found(%08lx) not as expected(%08lx)",
> +			*found, *expected);
> +		goto err2;
> +	}
> +
>  	efx->cxl = cxl;
>  #endif
>  


