Return-Path: <netdev+bounces-174008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F33A5D05A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD7F1888342
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0CC23817A;
	Tue, 11 Mar 2025 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jbaoMZAw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118871EDA3D;
	Tue, 11 Mar 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723539; cv=fail; b=GWAB05jvqioYlHflYtJrcc/ccEJ3tKzkn7R1fDJ7h57Ty+dvpygSlS8XuJlDWAxOO2sS0ZK7QdUFHDH59eJBFbboXqB2xm19gEoxnfC6HK/uPl/k9YQ3DlpV7yCITtVzaEL2FPINN6kqmK9N/f/5D8LP/QFWenvFdjhYDrEOfYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723539; c=relaxed/simple;
	bh=kJoydxdKYLZsPxJkTu3+UwMusfPH9yTlQr5Z6oeavFg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=JfKFeuOtRRhEjf+VVtrwBOvsQDDeNMth2e52dv8nJbo4J8sLCq/XVPO3Fp6HZ9PRqyeIRsk2cKDSBU2UufPP3KaFYjMNZm+RlzPxCJRzZVst2Fog1VKY07uA/4y7k++Nlm257BljJUjexB0evIRlv8pNGgUWF2EVnTCZrgheZ/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jbaoMZAw; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfRzqWSEVhIdzOKTic9BqBJDlhQYWZfI32Yp2Dtweus8/5miHZhHApJS7YRwsC1Ws79jvKSLshg8yDpPJVtLnxxjLlN+uCdZtAYQPuDDwnwk0+SAIrR0Mfxp/NUPI3C/u6WYKbcVvbNFNSfPZA6miU2rMoDvTwS/EO5NiAg+GHcyt07Nixd8kqPW8x4CZ1rXhlA9Lb9/axUWYEg7JDpi3/d7MvEhroTpVzUiAxWm2lFz0zfgPW3odOlhcrDkaLEhcwcYdUDd1Ct2n6zhIWxQzmE0keBFLTNog8xhS6THTvEgybv3oG8gOlNe3SJ4Grtfu182/D2/ZFtwdfqAvCskmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08EZo4R/V9DKQhqLCaVrP5magi4/Uvudcb5VY0LUTck=;
 b=KmWgmAQAF6Bh/udsibJsEG85WN/5fr0eLC1naNjaGzli3MVfZpe3D4coepmeLVwG5HU4KxThBTvdzdPeXlibN3L7xB33LT4tyFM3OvkLmkVnfAcq0+obeaATG4V/VMfRLN3rvBMjVIvru2PO0YIXQINIPU8E6cfzWumudy0EHo5hrPOssIwoDYsMLM3UoV6A/jIWJ7K9puoaAepQg/FD3u5QxCOF2Q4mjMG2TlZCu7ooOtf+7MjouateWYvqNaBEbXY0hk9/y/sDWppEWa+yp6jDtJmLGmvmyrMoHfarSHkYK+W1m1+9Ct9EFSVPxQtHTrY4N/wnQVgM3wxIyDHqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08EZo4R/V9DKQhqLCaVrP5magi4/Uvudcb5VY0LUTck=;
 b=jbaoMZAwTau+uM7WeMPYDwSp83Baih9SwXDaJnBStC/O2GmTyitMFkbiT/MuQ/sV/w8MtjIw0zYn+XCATgkS7oHnFd4WVrYz5i7kWzgobU+m7kr1Zx33Mdnw6hfLTahWa48eJ8gMDikFYTHLQgwjWUA4DmJJ+JPGpB73xD9fvAg=
Received: from MN0P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::29)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:05:32 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::e0) by MN0P222CA0022.outlook.office365.com
 (2603:10b6:208:531::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 20:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:05:31 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:05:30 -0500
Message-ID: <8548aa3d-9904-47b8-b5e0-869785c2330d@amd.com>
Date: Tue, 11 Mar 2025 15:05:29 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 04/23] cxl: move register/capability check to driver
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-5-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: cc51a475-b745-43f4-c74a-08dd60d813ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blNJelRsZFlFS3lYY0lmaldpMFRiVW9xSEYyWVptMXpDMDZtNGZnTGNoUXpZ?=
 =?utf-8?B?dXg2eEdEclFGRnhVUjdURFhTbGIvNVV3N3dZQlVzUUk5NHdKQUxiakFSTlNp?=
 =?utf-8?B?Q3VDK2pUeHVQL1RQR2c3TWkyblFJWFVvcWZuanZqZG8vSkRkc2xPM29TcnA4?=
 =?utf-8?B?MU9ucmQ2c1kyNjBHL09wTGdRWG9Zb0JuT2tYS0RUVWNndXl2U2Z1K2tCM1Yw?=
 =?utf-8?B?T2xDbXJjTWpxNWVRTFlIYWZFVlNuQUdEMk0yRUxIaGVqWG1LdysxbUhod3BU?=
 =?utf-8?B?bGdUSVFWUGZLZzJXVENKbmtCU0VYbDRkbG90T2lBeENqZ1ZJWDk0ZHViL0x2?=
 =?utf-8?B?NDU3WGRSVGJybktDV1F6b0g2djBqREJMMlM0eWNuaml3VjB1RVlLcDRsMlpR?=
 =?utf-8?B?VENSOC9BMU1DTW5DVFM3U3lFTmxXOTVRNm9hbnFXeTVwTHhPMERkQjZFRk5w?=
 =?utf-8?B?THR3UEwvaEk2emhWc0lOQm92VXp4U1NCMW92UXk2SFQ3MWs3RzIrekJOUkFL?=
 =?utf-8?B?SVdMSmY5dDJHR3Rmb0dJTmNHQXFsWXhCdFRSNHBUOHFJdkErclV1NlY4ZGND?=
 =?utf-8?B?K3NvUmhoYnJsOGIvVHZCRjhXdStEaSs4N1JCb2pXTVVSbUxPdnJsbUdtVG1W?=
 =?utf-8?B?MTdjSlNYRHhHamovcFJOSTgvMDBmdWlnOFB6a0NZT2cvSEFKTUI1a2Qra295?=
 =?utf-8?B?VWg2aGw3VU5jdXU2L2ZhQ3ZzM3Z4SHRlMnJtZlR2ZXJEQTFWYzJQMXo4WkNx?=
 =?utf-8?B?K051bzlmdVdtU0lWVnVjVjgvRjJML2lYWVkyNEVXU016emlTVCtXZEN0Vkxy?=
 =?utf-8?B?VjdxNVp3MVc0eEdIaTZrL1phc0UzSnFMRGprK0s4eFZqT042a3VaRjRUd1ZW?=
 =?utf-8?B?Nk8xMG1hOE1rTk1SMGNUdEhDdURyWHJwdmFCTkdkZE9aaHQ4QXNielNSRDBJ?=
 =?utf-8?B?NCtucnVaTklpU0FCbHgzTjZJLzdGTHVFV1BoQUs3SlM5QXdxamF5VHV2M01a?=
 =?utf-8?B?aGc1NnFmMjIvdndRNmJYb0thaHBaVHpSa2JNSThEdThWeHBJL0luYUNrYkFV?=
 =?utf-8?B?UFVJZ2NHRDFORlJUdS82YXUyQ2g5T3R2UEFQRStRU1hYYUVObHFjcy8zb2pO?=
 =?utf-8?B?Z3ZuVkVnbm9hdGNkc3RvWnR0Y3RjSmVZTVRpUnZnWHRpWE90QUNHMi92UXdW?=
 =?utf-8?B?eUZvT3pPZUljeFlzdlZONnlEVS9JRjAyZGh2TFBXQitjdE85Z3pXbWdFNUxP?=
 =?utf-8?B?YjIyeG4yQXRPWlczVDJSUmdFZjEvdVRaY3dRZVVOOGdJZU9UQ3Q4WmxvTzVH?=
 =?utf-8?B?eVVWTmlrdEF4cXF1bHl6Mml6MC9xY2haaXp0Q2xJendacDRjUGdXMjYrVllT?=
 =?utf-8?B?d3d5Q2dXMHdxVXJOeXUyZG1OMVJSZGp0KzJTN1B1N0tOWXk2ekNIV1BkbWxt?=
 =?utf-8?B?K0VYOGgvRERUZ0hIMnczVzVDUTEzUElZR2ZOWU5GME5hVndyLzJVZm1sMFVN?=
 =?utf-8?B?eFVldUhRakNDeHdvdm1GVC9yZUV0NEV1akp3dFhPMUdybS9ONkVKWTNHdlph?=
 =?utf-8?B?SndDOFd5bXIxVEgzenNXY0N6NHhnU1VvRnZVSjhFemphM3dEWmhlN2NNVjZG?=
 =?utf-8?B?d1ZWQzFWZTV5NHk0K0NpNGNMVmNyMXRWdU5lTEZxbEIzYmlCbUNRdFptdGFK?=
 =?utf-8?B?cUN3V3ZVNVNaRk0vVi9jdiswTFpxTXJ2d2VEa0NFVU9idTFUWmtmWExrcHRu?=
 =?utf-8?B?d05BNk5Fa0c0SWxiRVV2RUJHdUg4QTNMS2tsSG5RcHRMdEl1cTJIcHdUSTlu?=
 =?utf-8?B?dDFQNk9UOXhKcGpENG5pdDJ4Zm0rbXpRSmhsM05vVzNBdGlSQjN0dGtaZ2M3?=
 =?utf-8?B?MFVFRUF3SHAvVThnNG1xWldIa0FmVWM2a0dEM2ltb3ZaZndlWUI2UEZacmkx?=
 =?utf-8?B?OFo2dzAxc1dSV1ZKUUFxd25uamc5cXFBSnVqNVkvUURtMTFudnBrSEh6OGlH?=
 =?utf-8?Q?PHSAwJ36Lxtr7U/QAQ8FsHurSneNSw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:05:31.9627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc51a475-b745-43f4-c74a-08dd60d813ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 has some mandatory capabilities which are optional for Type2.
> 
> In order to support same register/capability discovery code for both
> types, avoid any assumption about what capabilities should be there, and
> export the capabilities found for the caller doing the capabilities
> check based on the expected ones.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c  |  4 ++--
>  drivers/cxl/core/port.c |  8 ++++----
>  drivers/cxl/core/regs.c | 37 +++++++++++++++++++++----------------
>  drivers/cxl/cxl.h       |  6 +++---
>  drivers/cxl/cxlpci.h    |  2 +-
>  drivers/cxl/pci.c       | 31 ++++++++++++++++++++++++++++---
>  include/cxl/cxl.h       | 20 ++++++++++++++++++++
>  7 files changed, 79 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0b8dc34b8300..05399292209a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1061,7 +1061,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  }
>  
>  int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		       struct cxl_register_map *map)
> +		       struct cxl_register_map *map, unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -1091,7 +1091,7 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		return rc;
>  	}
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6a44b6dad3c7..ede36f7168ed 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -755,7 +755,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  }
>  
>  static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
> -			       resource_size_t component_reg_phys)
> +			       resource_size_t component_reg_phys, unsigned long *caps)
>  {
>  	*map = (struct cxl_register_map) {
>  		.host = host,
> @@ -769,7 +769,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>  	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>  	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  
>  static int cxl_port_setup_regs(struct cxl_port *port,
> @@ -778,7 +778,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>  	if (dev_is_platform(port->uport_dev))
>  		return 0;
>  	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
> -				   component_reg_phys);
> +				   component_reg_phys, NULL);
>  }
>  
>  static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
> @@ -795,7 +795,7 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  	 * NULL.
>  	 */
>  	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
> -				 component_reg_phys);
> +				 component_reg_phys, NULL);

Nit here, but if you just pass in a unsigned long here, and in cxl_port_setup_regs() above, instead of NULL
you can get rid of the null pointer checks in the register probe functions.

>  	dport->reg_map.host = host;
>  	return rc;
>  }
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index be0ae9aca84a..4a3a462bd313 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxl/pci.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
> @@ -30,6 +31,7 @@
>   * @dev: Host device of the @base mapping
>   * @base: Mapping containing the HDM Decoder Capability Header
>   * @map: Map object describing the register block information found
> + * @caps: capabilities to be set when discovered
>   *
>   * See CXL 2.0 8.2.4 Component Register Layout and Definition
>   * See CXL 2.0 8.2.5.5 CXL Device Register Interface
> @@ -37,7 +39,8 @@
>   * Probe for component register information and return it in map object.
>   */
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map)
> +			      struct cxl_component_reg_map *map,
> +			      unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u32 cap_array;
> @@ -85,6 +88,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			decoder_cnt = cxl_hdm_decoder_count(hdr);
>  			length = 0x20 * decoder_cnt + 0x10;
>  			rmap = &map->hdm_decoder;
> +			if (caps)
> +				set_bit(CXL_DEV_CAP_HDM, caps);

With above change, this check and the ones below go away.

>  			break;
>  		}
>  		case CXL_CM_CAP_CAP_ID_RAS:
> @@ -92,6 +97,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  				offset);
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
> +			if (caps)
> +				set_bit(CXL_DEV_CAP_RAS, caps);
>  			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
> @@ -114,11 +121,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
>   * @dev: Host device of the @base mapping
>   * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
>   * @map: Map object describing the register block information found
> + * @caps: capabilities to be set when discovered
>   *
>   * Probe for device register information and return it in map object.
>   */
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map)
> +			   struct cxl_device_reg_map *map, unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u64 cap_array;
> @@ -147,10 +155,14 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>  			rmap = &map->status;
> +			if (caps)
> +				set_bit(CXL_DEV_CAP_DEV_STATUS, caps);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>  			rmap = &map->mbox;
> +			if (caps)
> +				set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, caps);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> @@ -158,6 +170,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>  			rmap = &map->memdev;
> +			if (caps)
> +				set_bit(CXL_DEV_CAP_MEMDEV, caps);
>  			break;
>  		default:
>  			if (cap_id >= 0x8000)
> @@ -434,7 +448,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>  	map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> @@ -444,21 +458,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	switch (map->reg_type) {
>  	case CXL_REGLOC_RBI_COMPONENT:
>  		comp_map = &map->component_map;
> -		cxl_probe_component_regs(host, base, comp_map);
> +		cxl_probe_component_regs(host, base, comp_map, caps);
>  		dev_dbg(host, "Set up component registers\n");
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
> -		cxl_probe_device_regs(host, base, dev_map);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
> +		cxl_probe_device_regs(host, base, dev_map, caps);
>  		dev_dbg(host, "Probing device registers...\n");
>  		break;
>  	default:
> @@ -468,7 +473,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	return 0;
>  }
>  
> -int cxl_setup_regs(struct cxl_register_map *map)
> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -476,7 +481,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_probe_regs(map);
> +	rc = cxl_probe_regs(map, caps);
>  	cxl_unmap_regblock(map);
>  
>  	return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5d608975ca38..4523864eebd2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -202,9 +202,9 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map);
> +			      struct cxl_component_reg_map *map, unsigned long *caps);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map);
> +			   struct cxl_device_reg_map *map, unsigned long *caps);
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> @@ -219,7 +219,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, unsigned int index);
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
>  struct cxl_dport;
>  int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0611d96d76da..e003495295a0 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -115,5 +115,5 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
>  int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		       struct cxl_register_map *map);
> +		       struct cxl_register_map *map, unsigned long *caps);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e8c0efb3a12f..17ac28baa52c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -836,6 +836,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>  	struct cxl_dpa_info range_info = { 0 };
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> @@ -871,7 +873,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	bitmap_zero(expected, CXL_MAX_CAPS);
> +	bitmap_zero(found, CXL_MAX_CAPS);
> +
> +	/*
> +	 * These are the mandatory capabilities for a Type3 device.
> +	 * Only checking capabilities used by current Linux drivers.
> +	 */
> +	set_bit(CXL_DEV_CAP_HDM, expected);
> +	set_bit(CXL_DEV_CAP_DEV_STATUS, expected);
> +	set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, expected);
> +	set_bit(CXL_DEV_CAP_MEMDEV, expected);
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, found);
>  	if (rc)
>  		return rc;
>  
> @@ -883,8 +897,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 * If the component registers can't be found, the cxl_pci driver may
>  	 * still be useful for management functions so don't return an error.
>  	 */
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &cxlds->reg_map,
> +				found);
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  	else if (!cxlds->reg_map.component_map.ras.valid)
> @@ -895,6 +909,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset of those
> +	 * found.
> +	 */
> +	if (!bitmap_subset(expected, found, CXL_MAX_CAPS)) {
> +		dev_err(&pdev->dev,
> +			"Expected mandatory capabilities not found: (%pb - %pb)\n",

I think this will just print the bitmaps, so it would probably be good to highlight which is
the mandatory capabilites map and which is the found. Maybe something like:

"Found capabilities (%pb) are missing mandatory capabilities (%pb)\n"

> +			expected, found);
> +		return -ENXIO;
> +	}
> +
>  	rc = cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 5c6481136f93..02b73c82e5d8 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -25,6 +25,26 @@ enum cxl_devtype {
>  
>  struct device;
>  
> +
> +/* Capabilities as defined for:
> + *
> + *	Component Registers (Table 8-22 CXL 3.1 specification)
> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)

Update to 3.2 spec?

> + *
> + * and currently being used for kernel CXL support.
> + */
> +
> +enum cxl_dev_cap {
> +	/* capabilities from Component Registers */
> +	CXL_DEV_CAP_RAS,
> +	CXL_DEV_CAP_HDM,
> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MEMDEV,
> +	CXL_MAX_CAPS,
> +};
> +
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
>   * without requiring block-type agnostic code to include the prefix.


