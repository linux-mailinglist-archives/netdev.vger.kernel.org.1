Return-Path: <netdev+bounces-146852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0FC9D6502
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7080728331A
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D3189BA7;
	Fri, 22 Nov 2024 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IuMxF6ig"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90717B428;
	Fri, 22 Nov 2024 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308292; cv=fail; b=SzwKZsFnjZGBODz8bSVARKhQHzuQlH6IQbyba0cJwe8tK6GgnJe1HxcdEeFIfLKcJG8RcSJa10lbz1P7pvy+l0TkE1gARktF3QKleOLCO/TGEDy5U1sIxd2O2T/y1zmxLCQXZLVvOi649oRtTxfKzIRsuLuxWHhzaHJ54bHcLGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308292; c=relaxed/simple;
	bh=0JwP1tmmKwQNLMm2NNNGE5tIRQdsCUSe5BvF/V0Tq+k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=r+YwqIrg3gxnYxyrL5WJizZujkhAkFdudeKBHBPgGmpSYtqWGBLhbheyqaky7tacyOujY1K+x9yTPes/kBziiNmKfBVWxJKRXJya6/P5XBBKBGpwuUHsu2Pcu31taYWTenGe/dN4o/T3gBxShfwfEwnRqNW8uw/dTmpXgXd1g/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IuMxF6ig; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJc9ScCWij4gAnlDWmgQP5c3UrDj/IJ8yRmMg93Y7sJ5XHl9ls4xLSCShx8F5nww6mggGF2lTDXGOG3KmPX1H5BL28RCg874SdvSW9a0B/isN7hceDXy9GaLCCaL9jb2ReVerQeaUvckgltBHoixsWsbqmrZPQXlESYGcCJJkSkRTFwIPB7WviFIACXtHCQ5pzIENc/QNUIw48CqsUA/jXFMd5/z0/Ix6O8UnifHyKEcJUtH/rHy9ISIlp3UBPGi3Cw5Nx9ukeSU9FRav39isx8ucx3yrYaM0A86lRx1sDAynSXA7SbdCmgyWQW8rYXfn0eyh29Ab34RZ8MvtLJGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pvKuOqchA43uFt/xnR6vM93UBD1FhBvl0kvnNaUGsQ=;
 b=tQ/fe4ZwiUv1fxwkNyVsU75PhV0Ka2JkniSeATCjBAS7YA0x0mGPTL6411hkV3SIvUPS8ocBNnRPKidC/qkqlidlJG1sZaoQfoupGn1mr/rgF54gh7VWXuDa5fDAJusYsYSQ2qXq23JfKV8SHP2sl0W2i0rRBU/xDhyME83BYMwc0PLaFYveTf12ghvmjuM3FKGlm/WiPGnGQssXCjt0K4piXB4sVyhrx2cV9CJKUs8XMN35L2Oq8w8N2LP1CEmMP2EZEe2u08EP00fjImSXxNe/rik0nORMMK2v4K8wXEmx5QK/tpm7nKVkyvHNp2rV85BeouSxp1NZ7DsXoilRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pvKuOqchA43uFt/xnR6vM93UBD1FhBvl0kvnNaUGsQ=;
 b=IuMxF6igkuKedph8i/1Q+7Mq986dV9foPSsDcykxBNAevBJyLHjPtBVrH1bAsYuft6gzp4+F+O9Di8r1L28hgNFerWYH0tFTruiv89X3WKZxChJ6/uCO9iuiDRZFdJ61Fj9jmlIXSbu47Pqqnq3HiNIiff6d8mZHKCRxGcvpfxo=
Received: from BN1PR14CA0030.namprd14.prod.outlook.com (2603:10b6:408:e3::35)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.18; Fri, 22 Nov 2024 20:44:45 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:408:e3:cafe::eb) by BN1PR14CA0030.outlook.office365.com
 (2603:10b6:408:e3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Fri, 22 Nov 2024 20:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:44:45 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:44:41 -0600
Message-ID: <84e3cd1b-019d-411a-9acd-f03aac1f1aa5@amd.com>
Date: Fri, 22 Nov 2024 14:44:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 04/27] cxl/pci: add check for validating capabilities
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, "Cheatham, Benjamin"
	<bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-5-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 75084553-6530-46e6-365f-08dd0b367faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGRSQWRtR0ZkR0twT05kQjFQSG94cGJCcm1qa0c2b3YveFhmTzF3TWF2d1BH?=
 =?utf-8?B?N2tRNWwzR2VKY0pPcFBXY25mQWZURHZlRHBPUDRickd2QzVPRjdQRG1TUkRX?=
 =?utf-8?B?aFJHQWdETFhxWVVhWExINWh0eU9ydG9LZkxGbWdhY0JwcnVNbE01NmlGeVl6?=
 =?utf-8?B?V3ZPL1BleTRCazhZOVBhQXM3L0sydGxQdXA2N2NRMG9WczFveFVOME1qbFlu?=
 =?utf-8?B?b21TSlluSks1SllOdWtUTW1XUnVzM0N1MG9MTXEvMGxHQXpwRmtqc3JucTI5?=
 =?utf-8?B?dWoxd21Mc2Z6MEd6Rjdhd2FKRjJ6MUxKaHFKOUJzYjlwT2ZESjE0UUZGbytl?=
 =?utf-8?B?eXl1T3VKaVdodXdLUk05NEt1cDY4REV2cTZoazNOK05lWjgrMElMOTFjbFY3?=
 =?utf-8?B?amorVHU3NWNGU05ka2pXQzYxQS9oc3QxcWJWb0daamVvc3ZEc0lOUkRzYW16?=
 =?utf-8?B?Qm1NOGpPaGE1MDllZ3VzN2dZUDI5L1JVV0htczdOZHFmekxnQThpYVlyVFFN?=
 =?utf-8?B?OEp1WnpRY2pOQjUxZU1uYmc3b1dXb2lTbjZjRDg4OUREczhiRlNJeDdEQjFm?=
 =?utf-8?B?bXRSOG9xVHQ4ZnhZTElLQ0pvd1hiaGVENDNnbHpDSWdsQ1AvcDNhVXkxQkR4?=
 =?utf-8?B?WStCa1B4N2tFenNqMGltQ0h2eFVUenhtWkcxN1o4UkZsQmRteEQ5M3pMQlVq?=
 =?utf-8?B?K1o1R0FLeTdtVGJzOXdsUUxlR0pYMjFsQThxekxJUVdVenJCR3c3NitYOGVv?=
 =?utf-8?B?L0RKT01GTWplZExGaTljUFFBYVhoMVgvRFNhZzU4Ry9VUmFnbkwvR3FKWWVN?=
 =?utf-8?B?cnI3VmlHVnk5L3hRZE5ORU9SNExLa0tRVzlscmRKdVZLZDZvUzduWjl1TG42?=
 =?utf-8?B?RjhhTDhVUVF6UVVibGVYQkcyT0p5UnYwdEtOdXlGZjI1eWJNRVNocDRXZnVI?=
 =?utf-8?B?VXpya1JWUzZ5VHpsbFQ5alRMWUxCMk9aSjM0V2FyWk9pWGtRbmZxZVJ1ZW5S?=
 =?utf-8?B?SGFtM2NoeFJ0QkIrY3h5dTh2N2FTdmNTM2ZVQ3NXcTB6UWF0VkJwRnhXNklI?=
 =?utf-8?B?MkV0ekxsQlpEb0V4d3YvYUZvbEJabjV3NTJRVHpXTUxoZktTVkZSUkt2eW5I?=
 =?utf-8?B?RExqTis2N0MwWFc3dkQ4R1NiWUtYQ0QzQ1c4NkJkMkZ2M1lxYVZaQUFyeHhO?=
 =?utf-8?B?NW03ZW9QNnVydUxZWENHWi9sTkRqekpjMVhLbW1yelV0OHRPbERWZ2FnQ0NK?=
 =?utf-8?B?OVNhV2x6N1g2bzd2Y0NuTm95RExUeFBabUhOcmlZeDhpVUZhZ2k4T0p0c0hG?=
 =?utf-8?B?NjRtc0hNRDRwakI1WndWZHdhL3RuWVUrc2NCZG1CSzQrZk5CU0RRL2hrWFlk?=
 =?utf-8?B?NHhZWHpaamdoalhJTXA0bmdEY1QyeDRJdmRaZWVtSGJNQnNUZDVVVUIxL1JH?=
 =?utf-8?B?T01nTitRY2FxbWZmSDQwaHZCdXV5N1RNcjdtWDRsRHUyZU5Ha01NK1NJaUh6?=
 =?utf-8?B?OVhYQWVtWmJLVlNRUmZ0NktKWjEzVUM5aDAzVWdCRVlwMjJSRVZUalNNRVdj?=
 =?utf-8?B?YitBczNDUGs1c3BUUW1lY1c1WG43K0srSnpLcFd2WVZIRi90WWZMTHlmdjE0?=
 =?utf-8?B?S1JwTFFSeTU5QVk5NGxyZ1ZVTjlkZWJFbFZOWXkrVXJ3SmFVNEtlM0VsdFFC?=
 =?utf-8?B?WXBBTy9TM0VzWGE0T0J2U2IvcHZoeWRRZVM5bTJpQ1JCYzdvdWt5cWhkTFBq?=
 =?utf-8?B?NUhFMmpUWUVNdzRkYS9ua2R1K2tlaDhZMkdVMmJISk5LN3hRbHNvV3AzUFZp?=
 =?utf-8?B?NGtuZHEzQkF5VWxSMXk1bWVEeXd2MFlNOXUyMDc2K3B0RUhiNmZGVENRdXB3?=
 =?utf-8?B?RlFQTkdybXZDZkl2c3p0ZzhnOVB0UUxReDBLMERYMlNHRmlWaldrZG90T1N3?=
 =?utf-8?Q?yBY1WNCcL0Pwqwy3IkV8YIzNZPFoRYNP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:44:45.3698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75084553-6530-46e6-365f-08dd0b367faa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
> 
> Add a function for checking expected capabilities against those found
> during initialization. Allow those mandatory/expected capabilities to
> be a subset of the capabilities found.
> 
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 22 ++++++++++++++++++++++
>  drivers/cxl/core/regs.c |  9 ---------
>  drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
>  include/cxl/cxl.h       |  6 +++++-
>  4 files changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index ff266e91ea71..a1942b7be0bc 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -8,6 +8,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <cxl/cxl.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -1055,3 +1056,24 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
> +			unsigned long *current_caps, bool is_subset)
> +{
> +	DECLARE_BITMAP(subset, CXL_MAX_CAPS);
> +
> +	if (current_caps)
> +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
> +
> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
> +		*cxlds->capabilities, *expected_caps);
> +
> +	/* Checking a minimum of mandatory capabilities? */
> +	if (is_subset) {
> +		bitmap_and(subset, cxlds->capabilities, expected_caps, CXL_MAX_CAPS);
> +		return bitmap_equal(subset, expected_caps, CXL_MAX_CAPS);


It looks like there's a function called bitmap_subset(), does that not do the above? I didn't
look at the function since it's the end of the day when I'm writing this and my brain is tired,
but I'd rather that be used if possible. I also don't think you need this is_subset parameter and
else branch. I don't see anyone using this function where some expected capabilities are optional
and others mandatory. If that's the case then they'd probably split the calls instead.

> +	} else {
> +		return bitmap_equal(cxlds->capabilities, expected_caps, CXL_MAX_CAPS);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 8287ec45b018..3b3965706414 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -444,15 +444,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map, caps);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
>  		dev_dbg(host, "Probing device registers...\n");
>  		break;
>  	default:
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 528d4ca79fd1..5de1473a79da 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -813,6 +813,8 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> @@ -874,6 +876,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +
> +	/*
> +	 * These are the mandatory capabilities for a Type3 device.
> +	 * Only checking capabilities used by current Linux drivers.
> +	 */
> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> +
> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset of those
> +	 * found.
> +	 */
> +	if (!cxl_pci_check_caps(cxlds, expected, found, true)) {
> +		dev_err(&pdev->dev,
> +			"Expected mandatory capabilities not found: (%08lx - %08lx)\n",
> +			*expected, *found);
> +		return -ENXIO;
> +	}
> +
>  	rc = cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index dcc9ec8a0aec..ab243ab8024f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -39,7 +39,7 @@ enum cxl_dev_cap {
>  	CXL_DEV_CAP_DEV_STATUS,
>  	CXL_DEV_CAP_MAILBOX_PRIMARY,
>  	CXL_DEV_CAP_MEMDEV,
> -	CXL_MAX_CAPS = 32
> +	CXL_MAX_CAPS = 64
>  };
>  
>  struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> @@ -48,4 +48,8 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>  void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>  int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  		     enum cxl_resource);
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
> +			unsigned long *expected_caps,
> +			unsigned long *current_caps,
> +			bool is_subset);
>  #endif


