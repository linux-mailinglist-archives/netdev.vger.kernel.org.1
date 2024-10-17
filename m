Return-Path: <netdev+bounces-136760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F959A3008
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3913E1F235AB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D571D61AC;
	Thu, 17 Oct 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F3xQgtaD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6F1D54EF;
	Thu, 17 Oct 2024 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201768; cv=fail; b=BSvaC2YUA3jZ9IvJVO5qmppJnh0WizD7aVaiEpc/oTNRlTQ6edMt4qz5+1RMT+/DgSo1jTpkwn6KKaWt2lhRmxWQze5f+FvHeZ7vK1jnrECWD01/H36pXThFkiguAooWvHjwdvW4f4TGLJloP8Xm3uIWQ5NUKFNzJJwAfWl7eSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201768; c=relaxed/simple;
	bh=czvimGopNhxd1qBCzDPGzEmdX7ESlL9w07VjX+UAC3w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=MKuSHCpeEbCuFvrEJ2Nr+SNWHqC+qASxRi+jRHS1F6+Zv7AyRloFgTY8yqF8CgsFW5idfvE6r25hmmhISZekhdVuRx30EfI8beECFpfO5qnNUcxiPIhTHeidUi3fM1EIIDRlGnhaI0ah1PzPjtEapFQ0jpQrxbDfQyKf82NcvAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F3xQgtaD; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGHNeLg3/QkP7/Shm5WN2enJarv6VoWjJ0k5xQc3LEz7AaT6SD556Y7xNHimfT2lSXJC/ZFKlTyXw3z2lLuZJCiMsu/3+gjIJm0oXNNsk2DanCi/4bx4sx8+dKlL/vE98v5KsAoqXX9K6LqZQ6fCaZPGnVtTnSiIl4ARyryFSM5uc06/Pc0am/XGlBjOLKNyQ/hzVnmKVUKzcTFcHcY8ft2ye5Y2Tl5xz9qrZCBdVRl21YFkmwglzJxqxuMBZJIUZ5/RkDkaEjGx4xuFtZGoZin28hq6KSXDirCYGrfnkd187qVadO4sLAMwhwpRoJKfTdsaYI5sJ0NKDlLv0ZHNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYvyDE8CiGVh52aTJTZ5zGbbN7RlWsMutrm2OwQ+qH8=;
 b=Ygm3uEEbZ6frkwzVbm4lonQEGeCES/7/NDSpfnzv8TpnqMSpL7cf2NqvvcLuq6TV8rAkRQ38hwY+vnJpOyXA47GyZ1PJVoGfu2Af9sqL3H48HJsif4jIwU+lgTdziUTogciHpAZM3SqoageUULzSPSxGyKq28pm2ZwmMUDdo54rEWoxeYyK1jnde3FOjdtnBsThNFwpNb+osk/FYUkOIKhbXN59MO4xp8xumQvmg5omtSqf4TPo70tZL2d6TS+/0wxX5MMKgTFHJNc7Jh29GvqDB4YEFGIBRhrfN4v2/eFEoV9AmSGkqwvda59zsbvoILcGCMlnpYlbeP/rD8RgRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYvyDE8CiGVh52aTJTZ5zGbbN7RlWsMutrm2OwQ+qH8=;
 b=F3xQgtaDV38EjN8ATt5iBnl2k2wzwnCPV8E38fUn8F0DUfSpoZ23ZUMnXHBPid7P+2Pe3N+NtLZ2aYxYxhnJJFZE5f15uHfm4yWvvUrSADl7oHBaSLN4Q+iOxGzFSAkXPotEIhOQMwHxs/dy4nqqizg8FcSRfPJq3L/CbB7Pnpc=
Received: from BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::25)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 21:49:20 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::c3) by BL1P221CA0029.outlook.office365.com
 (2603:10b6:208:2c5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 21:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 21:49:19 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 16:49:17 -0500
Message-ID: <f4a59558-bdfd-4597-87c4-70270e3adb96@amd.com>
Date: Thu, 17 Oct 2024 16:49:11 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v4 06/26] cxl: add function for type2 cxl regs setup
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-7-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241017165225.21206-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3438d8-9f10-461f-57c0-08dceef58e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0RmMmlrMUFEdEltZUdtZEJzckVjZXo4VHpxelliNUZPNzdlM1NuY2dlbjV1?=
 =?utf-8?B?Tmt6ZFNpUEM0d1IyUHRxZWE3M1dPUmVzbWtUSllGTU5mYUZmem5icldJWkk0?=
 =?utf-8?B?Tm9nNWJXclJFOFg0V2ZKZlNibXF6aE1mSFpvVncwdEIrRTJZcVJBRXlUOE9G?=
 =?utf-8?B?RzFpQ1UvSXZjdlowdVR6MmtUbGIwNjdUMlhTeFNpbldDK2QrUUMzNzNncDVQ?=
 =?utf-8?B?eHIyNUswaUNHMHJvSkV5TVlmRmtFNVhNdVJTNWg0MUkyQWE5amVDSVhoTFhH?=
 =?utf-8?B?bEhQSnhQWWx6RVl5VDFWNGRiQ0hZTlV0a3NtWGpmN2p1eldzeGxlalZodGtM?=
 =?utf-8?B?cTZ6Q1lDY0NBbE1JNklhMkhkWkRFK3ZUKy95aDA3NjhvWGJJN216NVVpWjRr?=
 =?utf-8?B?ZUUrcEF4VFc3d3NSRkRVbHhVbGJ2SVh3K1NpSkc3Slllc3RITThiV0w4SE9a?=
 =?utf-8?B?bkhUdmdGcUdHdmZrWTEyWXBEek53RHhZYW5sT3RxOExxdmpJVlA0T0Jma09L?=
 =?utf-8?B?OTh1dEE3eVdxL1pHeTNxVE9hbHQrdkhrY0lxb1AxMERrSkdiNlovVEhPV3hL?=
 =?utf-8?B?eWJnSitKVFA4WktMSzEwaDU3L3B4eGF4dmRpTmlWdDBrUXNGaEdZTG1LYTVJ?=
 =?utf-8?B?UlV0Q1R0NFp1dTFYNk5uU0swK3NhZnozcTRvbkNzZFR4bUZwclBucVkrM1Nt?=
 =?utf-8?B?Y09wRjJJZE5NQUlKMGxUU0JmR0FhUGhVaTJPcjExQ3BwN1VLejh3QzdxQTBq?=
 =?utf-8?B?Wk55SFdtOThpYjBJOEEyTDBQdnIrNWNIRjBoYjBteHVTNDhoOWs0a3R0NVBp?=
 =?utf-8?B?WEUzWU94S2RycFBjZHIxMUc5TGNrMjBJeHZOR1RIc1NTWlV3aVN0ZVRyVDhl?=
 =?utf-8?B?YUJNTnpYamlFRTV5TTREd0pYaTBGN3hwQUgzVHRKbGtCdFptVzZlQVFpSXpX?=
 =?utf-8?B?elJmR21ENnhuNzdjR250enNjNUo0bWdJKzNCYUI1cVgzdlZMSjl0N04yUENj?=
 =?utf-8?B?NEtpSXJYblRmYjg5T1VKbmxPQXlTYThsSmx2NUpjbjdNeGpXb1cvMytMbU1p?=
 =?utf-8?B?SzN3NllXUmZhSEU5OE0vcy9uRlg0MlpwUEpuV0Q5SmdtSUZoZFgyOGE4b3B3?=
 =?utf-8?B?TmdqYXNwRUxYdjFPbHY1eEhwMzlidjlBaXozUi90TmlITi9hemttdVF4elM0?=
 =?utf-8?B?SGVlZ1JjdzZPOURCUEw2VkdObnpWZGlXSFBrcklJYzJPNzgxdmhhQkRuVWVt?=
 =?utf-8?B?b1ZxejZhUzBQVERCR1ZGZHEvbVIyZ080dWlkekxrTTFiN1pGelNUSXBQbFFV?=
 =?utf-8?B?VWI3dE5UM2lPdnNDU3FSM3E2U3BrcU5NYlNWSEdjUHJFWmRBTUhmOFIwejZ5?=
 =?utf-8?B?dXNBVGdXaUdVejFzMjFhTEsvVmtoemxiRlNWUG1CZzdlNXYrNFV2OFpkNGFp?=
 =?utf-8?B?WFhVZ1pVaWphUmE4NjUyUHRObEVPMkIyV0tvWnovbnpNRFUzeWxWcU9JVkxU?=
 =?utf-8?B?WW82OS9pVzdZVGFnZXBTMzFyVHkyZGFSUzN4THNOaE9icW9Gc2JoRlQrTUVx?=
 =?utf-8?B?VDdEZnh2cDJpN0pkellLczJBV3BmSDJXbkZ4bGVyaVN2bGVkcEp1aGJSSlhP?=
 =?utf-8?B?RkdieVdoQ1hKYS93UisvZEpTd1FjOHFjeW5JcEZLVjZxL2xqb0NlWldpVUd0?=
 =?utf-8?B?YXZvaUZXVi9IMENZYXNkblhRWlZTWXlwVXRLR3ZFbGdPaGtsNnhncDNBeXlm?=
 =?utf-8?B?L3lhNXBrRFRHQlM4cmdIam50Ri9kb1ZVNlBUZXdHUFF4WGwzWkxFTmJoMXZF?=
 =?utf-8?B?R2FjRTFjUzRZK0RVNTAwbUZSTGQyN1NFalNHTkpwb3djazJqcXdyZzFGN25r?=
 =?utf-8?B?bDJxaW8ydFpJeUZhTzlQREJrR0F0RVJUbVdpRklIUmQ5UHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:49:19.9179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3438d8-9f10-461f-57c0-08dceef58e34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 47 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/cxl/cxl.h |  2 ++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 99acc258722d..f0f7e8bd4499 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1141,6 +1141,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
>  
> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
> +				     struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
> +	/*
> +	 * This call returning a non-zero value is not considered an error since
> +	 * these regs are not mandatory for Type2. If they do exist then mapping
> +	 * them should not fail.
> +	 */
> +	if (rc)
> +		return 0;
> +
> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +}

I think you can use this function for type 3 device set up in cxl_pci_probe() as well with
a minor change. Instead of

	if (rc)
		return 0;

above, you could do
	
	if (rc) {
		if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
			return rc;
		return 0;
	}

instead and replace the memdev cxl_pci_setup_regs() call in cxl_pci_probe(). 
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +
> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map, cxlds->capabilities);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
> +		return rc;

If you make the modification above, I think this is just a drop-in replacement for
the component register set up code in cxl_pci_probe(). I may be wrong (it's EOD here
and my brain is a little tired), but it could be a nice cleanup if so.

> +
> +	rc = cxl_map_component_regs(&cxlds->reg_map,
> +				    &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
> +
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
>  			unsigned long *current_caps)
>  {
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 78653fa4daa0..2f48ee591259 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -5,6 +5,7 @@
>  #define __CXL_H
>  
>  #include <linux/device.h>
> +#include <linux/pci.h>
>  
>  enum cxl_resource {
>  	CXL_RES_DPA,
> @@ -52,4 +53,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *expected_caps,
>  			unsigned long *current_caps);
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  #endif


