Return-Path: <netdev+bounces-146853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68E9D6503
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADF6161873
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5F1DF96C;
	Fri, 22 Nov 2024 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u59hVcrb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28318A933;
	Fri, 22 Nov 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308308; cv=fail; b=PGu2UlvJUyaREa7Ds+WARIK38P25LZqg7eFlGLP6J5lAyWMMaRG26ROeplB0r4ZWwbjpmLlTHxmPOSF+/dE3xmWyZqmGU8f5PPv0lKsU9+F8q3uGLVUHgzcpCHh9aHJK1xY4dUKDUA0MsKvl60Vh496C7ql0SgDA9Y/nV5VCWFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308308; c=relaxed/simple;
	bh=Ek4XrFEq7uoJTKK3A8H1lFlX1akTRnvupYTyDjbX0cs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=jM/4eh7RgNV1JdetdWjFRxzMTVSVQgyZlzdTf2u1uSD8YSmNJu2kGPYq41hh5oUtdSJCR6r8RbRP3QmvF/qLYrA/Xfo/DLBOZz224E5V+JkR5E4Z8UykynW7lRv/r5nm/jzoxcU7FZAjn46kNMxn8E6F3ekmBeYyCKcQkx3hPec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u59hVcrb; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZN3t6fu3fqc3um96R0LavQoohwWuoYV2f8VYIdXG0XKJ9e3xhROIlMnc9Ga9+mZ8xbcqeQEdW+0fGbOs4Dorctj0Enj7b+DqX80NJuCawATilycxjuGN/U0VPvNEzUXW9wkSYVoruGCiurcwwCIUvus2J1ncHpkb+a6DVEBRbf1MbrdzvKJS3dNMJrTCdeHgvjy6AWIHNUsTRq8Avp1InpoSDGNqoW0mCJd6l09WrPXCWbdvDAooiZCl8LT+xc27CdQePRdTa6E/pnFMPT0gEwsknedFM3R3dSpESuEoI17WucUAdlMp1oND7IsjJh5b34SXYe7rvaou8OlHvNl0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ruX6mMIC1D8HeoMdbV0U8EGVAQzZLocxyn9s77mEj4=;
 b=gh/91094vsHjP4kL5HPKN0k3+X0B//XlB78TACYWVHkiZaUqPF1ONGZPOuxua6B/HEyAbzzkPs7ewVk2SxmrqDQ5inXpwHJjB4MlneLtDCGa5icBm+bKPmb4nbnO4kejVL36ZBF+VlghsVj+wa9eL6hAP21Aowdp4S/FRWF6JRDFo4P7jHq6MhH76hFTu/G6iDcsJIQHxZDprrGt7yTh58Mu+V3zsTjf61wSGYDcppPS8gRLj/HQRiRQJ3VWHWkUJ9MAi71cgMgAud74AxKZzNx4UPoEdL1sFNg7abRW3hSFWpEfwO6Aq7iqFgO94RzNZLI6mfipCCF4IXrE+PknIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ruX6mMIC1D8HeoMdbV0U8EGVAQzZLocxyn9s77mEj4=;
 b=u59hVcrbDJj9H+432K8CyJmTSSKJGKtN2SobLZPasVhmcammNM+hG5/MwSOV8NoG1JUgLRCL3fWGWvt3wdfEDBMVJDTQBScZftsTwXWW2oLlfiHskb2/cGYbEDdxMJUY1Fie0IMny8McXOZ/vMOpANbHtkGVXaeqwIReZgvi10Y=
Received: from BN9PR03CA0140.namprd03.prod.outlook.com (2603:10b6:408:fe::25)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Fri, 22 Nov
 2024 20:44:59 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::24) by BN9PR03CA0140.outlook.office365.com
 (2603:10b6:408:fe::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Fri, 22 Nov 2024 20:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:44:59 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:44:56 -0600
Message-ID: <da4869c9-12e1-4efc-b6dd-2bcb95574e60@amd.com>
Date: Fri, 22 Nov 2024 14:44:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 05/27] cxl: move pci generic code
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-6-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 84932925-9478-4e6b-0985-08dd0b368816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1FZaWJMWm5UdzZsa1IwWlFOTGhrK3FKdWRHN0pUVXFxUkpmMExXOU5yRm1F?=
 =?utf-8?B?TnJCZXNmb3REQUlVQWhWUEpJMTRQRTVMYzNkLzhGSkJpQnF3WWxxaHpNQW01?=
 =?utf-8?B?V2xERG03YXdQT1RDcjhHT3BIZjdwbS85MU5rM0VOcUoyMm0zeGdNSWRTQ3lT?=
 =?utf-8?B?SG5MVlZXUGl6TEc1Vm4vZ3Z1eFRDNWYvTzVOZXpQVkd6N213alg4T3JuUWVE?=
 =?utf-8?B?MGRuL2kranpBeW9tRGRjL3RWMXJMZVlrRi93TERUQVpXQ09POHE3SnhmOFV1?=
 =?utf-8?B?V1p0QjFPS2x5d1JXOXZWQmNvNFhVNUJ3N3ZReThqbERjd0lsTmUycnljNUt1?=
 =?utf-8?B?QVlxRFV3T0t2dFN3LzFZVHoxWlNQalJCd3d0VVF2cXJuc2p2c2Rrbjc5MzFI?=
 =?utf-8?B?d1FSTmFBaE1oNkU1UDdBMHR2NU03eGwxaEVFVjFWZEE4RXBkMU4wNkNGVkoy?=
 =?utf-8?B?d0QwblpkSjBvUXM1NzJPVTNOMXVrUG9HVFZUQUZUdkhldnVKckMvZ2x0N0dk?=
 =?utf-8?B?OVViTTk0MnYvOUthOFVXMjFraXFkVWJJR09NdSt0R0grT25kVmdpZTJOdDls?=
 =?utf-8?B?cWczTWVYcGtXNk9odituVlFQbVJ4bnFvM1lkaHBOUEZHZlZCcmVDWXFlQUxB?=
 =?utf-8?B?MXpCY2NyMmdWb08zRlpYRDV6NUF2RU5YanBFNVdUbjgzM2kyeCtsK1krY00y?=
 =?utf-8?B?dk5SR0FWc3lzNUhzUmJ4TVFYSDN0enpxdTh5K2VWenBrSnZ4d3AvdUU0QXJK?=
 =?utf-8?B?T2tGbCtUWitGQ1FaOVZPRVNHcUtsM1RYYkxxY055QkhuUm90N3p0cHMwMWdl?=
 =?utf-8?B?RnV6WDI2V2xZTTJVZlppTHd5WVd3OHdNMm9EQmk5NGJ3dEhPZEFQZlM4STRo?=
 =?utf-8?B?NHdTay80UFh6VDNpZTRqSjliT3pGVzUvNVBrNXpCV1N4V2VCcnVVMDdUWnlh?=
 =?utf-8?B?Z0pRUml1NHBzcjBZSWdmNlhoK2pna2tFamVoSWlxeDRoRXJTUkR1RERCS0dC?=
 =?utf-8?B?QkdMdU9aT1ZySE1QT0VjbWZzZHg5cWtQcFlKQVRiN1gyVkVEMzIzRTdaSDhr?=
 =?utf-8?B?ZWJGaDdHT0hjb3ZNdG1zTmZ4dmY0YldsV3NSeVJGbE92UEllSVRMd0E2bCtD?=
 =?utf-8?B?SGl3TG5pZkpWSnVFclZwZjJYcmU1SXM2aVJBVmxIWEJNQWg4TG1EMHFwemJN?=
 =?utf-8?B?cVZ6clRkaURnaFNpRlZtck5BZ2hoaVd6OVo4ai9xTXFUYXphWmhzMUZPWnRH?=
 =?utf-8?B?MTlnam9id0s3NE9XcVJ4QXM3K1duOHdtS1dsTStiTFJSTHo1OC9UVDgxeWtW?=
 =?utf-8?B?azgzODVxZHRHUWNGYkd6N2wwY0JMQ1Y2WDdEMXFpcXVST2VOQVpPT3ZwVUxm?=
 =?utf-8?B?dG45WnYxQndpM3ZBclA4TEtwcEhPY29jMThDTnJad2ppUlR1aVVJZEo4dWFI?=
 =?utf-8?B?eVVCL2RyUnlxcmkxeVFBa1dvNDg1L3VRdndxc0l0L2xldEsrSmZGclVVa29Q?=
 =?utf-8?B?dS9EMmZrSmZkOGxEU2hoajl4M3l2YUdlYlhqWFg4eFI2ZjQ2ZEdEMXMrcEk3?=
 =?utf-8?B?Ry9HUHAxUmNLOWR6YURTYkFOaWFPY2trUEY4TFMvN0VTK1lSSVVmNXduUE1s?=
 =?utf-8?B?OUZxWXQ4MThjU3ROSHlTUzVwdXpTTUJIUzVISVJNNnJxRGdSTGp1SUkxQUQ5?=
 =?utf-8?B?NFNOWC9TVVV6dGlIL0dOSnU3d3ZFZ2NseUZnZTRqZGRuWUhyRzJsT2c5dG90?=
 =?utf-8?B?UkhyTVZ2QnVuLzZXTmdlUXF6c0xnMlUveFNDcENDVFVZVXVRVXNuV2E1QXVy?=
 =?utf-8?B?K1pvV3Bpa3FqNllpVmJJNUFuTDhDY2NVWTR1ZEJvK1NjM0hyRUU5NU5UUzRI?=
 =?utf-8?B?UExZSU5OTkE5eUJVNVdCdGtwY2ZxU3g1Sld4UXRzYTdBS0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:44:59.4982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84932925-9478-4e6b-0985-08dd0b368816
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
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

LGTM,
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

> ---
>  drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |  3 ++
>  drivers/cxl/pci.c      | 58 ---------------------------------------
>  3 files changed, 65 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a1942b7be0bc..bfc5e96e3cb9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
>  	int speed, bw;
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
> index 5de1473a79da..caa7e101e063 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -467,64 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
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
> -	struct cxl_dport *dport;
> -	resource_size_t component_reg_phys;
> -
> -	*map = (struct cxl_register_map) {
> -		.host = &pdev->dev,
> -		.resource = CXL_RESOURCE_NONE,
> -	};
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
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


