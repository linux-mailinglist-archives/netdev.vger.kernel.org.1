Return-Path: <netdev+bounces-136759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB49A3007
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A457B218EB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9059137C35;
	Thu, 17 Oct 2024 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MN2UJbP6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDF1D619E;
	Thu, 17 Oct 2024 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201755; cv=fail; b=B5KKfU2Mq6jkveIwDo3y698kXHw711EZxUusK0CDtKbT1qyrvbtRU6HniZdorDEmUx51zr57X+wKmon3e8Bv6IcczwbnJbPsu1OG0DrouxT6kY2W/QJztbGEAyqudLnGVJAbQhCo52JNTHUCg0F7d3wAq89GeAj58t710RNtF30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201755; c=relaxed/simple;
	bh=yeQQs+Ee+sH6L81INx/MZ5OXLgIZcpxrc/hKuYNFKRc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=awXnK+iB0V75cwVvYHT0vzoPgKO8hfb2z0eBDUwIO+J35v9lANMjQTLzKudBvyLIDgeExuGfFmEGQ3jKZxjqPa2V46X8kdP1xvw4GTrn2xMo6AD7WsZE0skCW8iaRAQU0cutYfmPB6DSRaMq3vZmcWtgNrg3+Y6O00Acv2HOYwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MN2UJbP6; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXj+VuYQP+l3YlTeQxUGERUIhBR8ObBpRJAhpyMI1vBg0HOu++x2TQpHmtETURf/FC+o4MBkDN1xsFQY5epignzioNj58uihT0EY+QvmKlV8oShGorCd8NpvOwyDGW1x9iR8yM4slboF7ZSDXdoNcfkqdhEwNe9O0IgHCkoHHB+Rs2PpcAyNCBKcKuJDDxv1l5u5z5oo2rxKYzYOZDfQu4vHLdUIHV0lV5q6oM5fV1byoilPmofFT2FOVEykqdn9NtwSAysnrUbNzc3jrH85dH14RiP0+Xu2kfwmpoCdit/Vys1uHAKf5MLI3npb0rgDaZsWUlewNl8vQAhFdxTtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++QKvql9AdM7XbOf6gSaxeyobNYX2nWl88q2XRAOlWE=;
 b=QuzlIpFPNEWygWfGwucXz7UdzIakTde+Qge0HNyGy7zI1HwrHFxbbqHmJreYGQdTh7XPTIz/KO8cXJ/K95pATy8iCDm6mELbaCxOUwYVnmkzN6xrlZvzYXdCVPMp+Gc6PzmEwKBH0mKQ0WGsVQLrO8oJtZRfY0fTPYpkm/KufWGudf/H+vGxagXR9T4xOMY6A7jjC+pqfvbK4m577j9HOsb4tOzmlzNQ0DEpZIPnpXYCQIrledbOSltxxQb2tkt+O/smyvg1n6LNrQ4hzm8SiInjiCuItMJBiGqPiVhZPPMzWowYZvO/YiqYXWm/dzg4vzbzUqJYfnWNIuWc2BxF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++QKvql9AdM7XbOf6gSaxeyobNYX2nWl88q2XRAOlWE=;
 b=MN2UJbP642l0+Fk7BQttuLK9kQkefTlFfN9b25cYL5bS2ROq4ZnV/vAXdYXEG6cwo5KS+sdAtkuVkmOA47r2oSh6DOTm8XUtsXrhojE+nBclaVjRJnzATNYKQrEnBWYs0XbmnnTMoBI1ONNO15VDWnVukPJU/e2UQWJ6tOE3sME=
Received: from BN0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:e7::7)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 21:49:07 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::2b) by BN0PR03CA0032.outlook.office365.com
 (2603:10b6:408:e7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 21:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 21:49:07 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 16:49:03 -0500
Message-ID: <d5083432-787c-4e33-9d19-67c6a9051ced@amd.com>
Date: Thu, 17 Oct 2024 16:49:01 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v4 05/26] cxl: move pci generic code
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-6-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241017165225.21206-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: ee89849b-a3fc-4428-bf6a-08dceef586ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ujh1RDNwR3E1YUpXUDZuWm9UbmZuRm9vZlV4L21JY1gvcUIxNlFMYk9oT2Vi?=
 =?utf-8?B?TGdpRVFFRVNzZ3Rqc3NrR3REYi9XZGxwYnVPS1F2cUZ4UG5iSGJuRXNjZEJJ?=
 =?utf-8?B?UUszNkJPVnVnRXY1SHZ1TFozS0dKZFZCYmhObUw5MTh3aXN4OFl6UldWOTZC?=
 =?utf-8?B?Y3EyMVBtYlhqK2hrOEVoSk9GNWtKWUIvVGs3Um5jZUpDU04ybCtWK0FLb0xO?=
 =?utf-8?B?cjJ4WmM4cmwyaldyczVQWGZKamVRSDd6aCtCdmxvOG5SMVE3SXNBODBXWERH?=
 =?utf-8?B?N281MklFa00weXkzaVFab2o1bmtkTk9PaU5pVnlrd2xyckJ0Q2VleHhMUHpX?=
 =?utf-8?B?TGlpZ2Y4cVFlR1RxVVR2b0pQZ0hBVWhOODZjM01zNnVnTHlXSUY2M2RaUnFT?=
 =?utf-8?B?bDArQVdoa3lQdWtoMkEyKzl3R1NycXBJTnlaTmRZT3ZjMmg2ZTN6RzVRTXMr?=
 =?utf-8?B?UmdSMGs0Wkk5Tm1DUXorVHp4cks1RE5paUtHa0V0SWZ0UmNMamI1UkttbkNs?=
 =?utf-8?B?R3kra05HNWcybmpValhTazhJYnhmNmRHS2pYVGhBcFJQWWNncTB3QjIwRmVu?=
 =?utf-8?B?WThZL0ViRnJyOUdWUU01NXBaeGZxeVZuVVZIMzNPdnZoWkFydW5PaGRaZEc4?=
 =?utf-8?B?bGloaDJxTXJzeWJVd2VhdFdyUWVsSGdiZTE5QitvK05HQmFvTkVFeTNBS3U4?=
 =?utf-8?B?R0h3eE1hampvUDRXRERlbVRIZlBvMGhjRWN0dVdkVVRUNTFkVzVRMjVBUEtN?=
 =?utf-8?B?STdQZDhEOVYxcytXSzArWjFWNkxuSVJHTEhEY0duRkxPZFNiMjBLWlRlTDlE?=
 =?utf-8?B?cklLK3JPbkFQVmUzNEFvVVluK2FEMm1kZWx4UTE0UlkrL2pwejRESnhzaWVS?=
 =?utf-8?B?aW1uTXozQWlPTDJZNHFINytxSzJ2ZlRKdS9WclFrSFg4aHZUZUwyUE1aVXNo?=
 =?utf-8?B?UmJycDhrZHJMZjhKKzZGa2VNQlE3ZEZFZGFONHRsZVJQdGg5OEJkUXN6K3ZI?=
 =?utf-8?B?ZXpySmYvQ2tnMUZ4bXhXZXRQNGd6OWpsQ1RRVUljSHFaMDJjZmdCcjErUlFS?=
 =?utf-8?B?RjQxWlcvc1RNNnhlS2hqb0Q4a0VRV09CbG5UZi9rcnVvSDY3REd1b2FvSWQ1?=
 =?utf-8?B?aHcwdUJNV3hkanA4d1pZWmdDeW9TNUlJc2poc2p5d3EyMVZHUWJtai9QeTV5?=
 =?utf-8?B?SEltQXZhS1U0SFFxN3c3TTNzTUdkNG1PQnlKQmdKeFpTMXdFVExjVmZ4ZDBG?=
 =?utf-8?B?RXlaUGpaTjRYNzB3VUh4dlFOakMxb1Znb0tEbVNxUElrWHNxSjc5WC9CZlRJ?=
 =?utf-8?B?OTZLMTh5K3ZoTGZTOU5BdXpydW1VVFJ3UFAvU3Z6a0dDSXlrS0NCUUNna2Q3?=
 =?utf-8?B?MmtLKy85NVBXQjh3THFhUm5YdDNVR1k1eTlaVFYxQnhOb1hic2tFd282K2dC?=
 =?utf-8?B?ajdSMVptMHBqalRCbkNCbGt6djVhUkdsaHBFdEovRW9GTmNSNUdlZ2JaVGNo?=
 =?utf-8?B?Q1JqWVFGY1lLelZlcnRMcE5yNXV4S3VlZVBVS3diemljVTdmVmxHY29SM3Rn?=
 =?utf-8?B?Q1dTK05kZUwxaGhPUlR6UkZHeStiU2lValJoNTVtWExva3JnWUtZZzBFSmtn?=
 =?utf-8?B?ZDdCZ29ka1BVTnpNMi9jdEUzNUpITHJ6cm9Ra1hTUmphT3VkRjM5TWtWTmQ1?=
 =?utf-8?B?R1ZBa2ExT2F5Z0NVOTdOd21aR3JHVThJT2kwTHZkbGh3eEQ4SmhwN05PTlVK?=
 =?utf-8?B?KzU4ajVaMjZwV3VVRjBPUURJM1ZlQ2JFdHY4VnM1VFZyOE95M2lzMDNQRHUv?=
 =?utf-8?B?V2gzc1JNNmRiN1NpYkxRTUR0USt4RVZ1OGU5K094NTRISGNaWG14dHl3bURG?=
 =?utf-8?B?MXVYa2N5Znl3Z0ROUXZWNjJxdkJneVdIU1VCT0FheWI4dkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:49:07.7112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee89849b-a3fc-4428-bf6a-08dceef586ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/pci/pci.c in order to be

Wrong path, cxl/pci/pci.c should be cxl/core/pci.c.

> exported and shared with CXL Type2 device initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |  3 ++
>  drivers/cxl/pci.c      | 61 -----------------------------------------
>  3 files changed, 65 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index fa2a5e216dc3..99acc258722d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1079,6 +1079,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>  
> +/*
> + * Assume that any RCIEP that emits the CXL memory expander class code
> + * is an RCD
> + */
> +bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, CXL);
> +
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	*map = (struct cxl_register_map) {
> +		.host = &pdev->dev,
> +		.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> +
> +	put_device(&port->dev);
> +
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map, unsigned long *caps)
> +{
> +	int rc;
> +
> +	rc = cxl_find_regblock(pdev, type, map);
> +
> +	/*
> +	 * If the Register Locator DVSEC does not exist, check if it
> +	 * is an RCH and try to extract the Component Registers from
> +	 * an RCRB.
> +	 */
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> +		rc = cxl_rcrb_get_comp_regs(pdev, map);
> +
> +	if (rc)
> +		return rc;
> +
> +	return cxl_setup_regs(map, caps);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
> +
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
>  			unsigned long *current_caps)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eb59019fe5f3..985cca3c3350 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +bool is_cxl_restricted(struct pci_dev *pdev);
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map, unsigned long *caps);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 89c8ac1a61fd..e9333211e18f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -463,67 +463,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  	return 0;
>  }
>  
> -/*
> - * Assume that any RCIEP that emits the CXL memory expander class code
> - * is an RCD
> - */
> -static bool is_cxl_restricted(struct pci_dev *pdev)
> -{
> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> -}
> -
> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> -				  struct cxl_register_map *map)
> -{
> -	struct cxl_port *port;
> -	struct cxl_dport *dport;
> -	resource_size_t component_reg_phys;
> -
> -	*map = (struct cxl_register_map) {
> -		.host = &pdev->dev,
> -		.resource = CXL_RESOURCE_NONE,
> -	};
> -
> -	port = cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> -
> -	put_device(&port->dev);
> -
> -	if (component_reg_phys == CXL_RESOURCE_NONE)
> -		return -ENXIO;
> -
> -	map->resource = component_reg_phys;
> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> -
> -	return 0;
> -}
> -
> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map,
> -			      unsigned long *caps)
> -{
> -	int rc;
> -
> -	rc = cxl_find_regblock(pdev, type, map);
> -
> -	/*
> -	 * If the Register Locator DVSEC does not exist, check if it
> -	 * is an RCH and try to extract the Component Registers from
> -	 * an RCRB.
> -	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> -		rc = cxl_rcrb_get_comp_regs(pdev, map);
> -
> -	if (rc)
> -		return rc;
> -
> -	return cxl_setup_regs(map, caps);
> -}
> -
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);


