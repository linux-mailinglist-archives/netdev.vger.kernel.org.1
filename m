Return-Path: <netdev+bounces-146849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9A9D64FD
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F2E283097
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7A189510;
	Fri, 22 Nov 2024 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DL86lIl2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A518859E;
	Fri, 22 Nov 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308243; cv=fail; b=BgYTkTVKeJD+oMMkmOQsGTX6a0dN7hpQ9F0MkR5eR0h5BxaGOs74pHBHXGZjlfdFcPS0yBU2PgYCP+tOVN7uBhs/Fr1/BKaE9poOLt/VQKSRTCpIh1XWrQuX6xNsMiaQ4QRhDAvn2Yidd33vxHTqUSYGC6KLT9jCVsIPL+V5EfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308243; c=relaxed/simple;
	bh=4v5rcqzKxaeLihMCAP/q2ldeB20qa9tkFTltrGiUnW8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=gbpOutGjMp85BVUc31mWgh2/1HHxAhC11KDOSL9fcwMH6Zbw9Qvhflr558xRxDE9ITX01RhZ20Iuzd/iuYUUt3C4h6mCeI6xzi2ycQ8Rd7kXKbYh9j72sw78mFWk6Eu4Nss9ufdszry/xAV5MEZ4dxD9IR68hsB4j3cZZUxERVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DL86lIl2; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuADLYp13kQkTA+lxiMji7HCiAmC9OBTHFZssmN1mGrk1gDyWBgJ/6LpnbaI+XJVOFitfQjFGHMHhn/lx2ZeOP7DKNaY4pA7fcBbEiK0U28O8yB52vsFwMdZfiii3KFVJMWCBIKs4fDTSH0RmGEQamCG+rPuzx02x1f8P7rTtephUbYdxFwwioB3O1wRxsIQgITxlFIVpQKmdW84iIFnuGAh7iXysr7+rIS/iytO9kI7cDmeliH9oHog63es1RG5NYl1QIwpaA622ivlLPIBFQpFyBROfbgzUlZp+/3dAlE87kdYJg8R0/qurjvAzqjtc1uOl7vv2U2dYjYe1V3y6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbSAt54ZGAbjB9+JBk/R9QEoKT7TgIwrzOyQ0RH6WgE=;
 b=y9eI5osvQDVn4GjDLHc2kYAb2MdrhpxM8V8zZ7l/Sw/APQiye7hi4/oeBHqoUTygPRL+bfOZxm5LjcnxT+eg1tLTzlWkelPRYgl7oCicFPqtfqvNqZi8J/WWKNeSIo63C+zg2KARMDeN4v3Dhb5rnhwEILISbkJXzcDn9wZlMYAy/9e98szSPshLBVyMrXMpL5F+xqTC9iKyJyPUodIXA6rIiLJTfHFclSHfvmc14tNxEyTdPwdWL6byiHCEyz55YErbFJJjRbe07P+8eMsgWa6MtzzmAEERovDyo5iawDZF+Jb8mRNqBe2icZCsr9KjqLuV98NZcGHFbscrFd5D9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbSAt54ZGAbjB9+JBk/R9QEoKT7TgIwrzOyQ0RH6WgE=;
 b=DL86lIl2qwoEN3RYhi8BDvJUCZn2+hepR1C3mSgof0Hg6z0KtD+nQbEA2ypMUGwwi3kPAr6Q94GpOVQ2sfbt6XxWB1IUra7PBl+BEKMxd1SyrYUht3n5EDQ+6ohpL4F6gybZJYGDFbSdR1HRpaSp6ZYKnSbOu4EMMf5jU5G1NLU=
Received: from BN8PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:d4::28)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 20:43:56 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::89) by BN8PR04CA0054.outlook.office365.com
 (2603:10b6:408:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17 via Frontend
 Transport; Fri, 22 Nov 2024 20:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:43:55 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:43:51 -0600
Message-ID: <79d02ee8-3b7b-4bc0-bee7-1968fffb9582@amd.com>
Date: Fri, 22 Nov 2024 14:43:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 02/27] sfc: add cxl support using new CXL API
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, "Cheatham, Benjamin"
	<bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-3-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c9b9e7-3f75-44e3-9c7c-08dd0b366235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cllGTXU2Y2FrRHc5OU05L0piVm10UVk3TWJYMTg1ODN2OS9hajZNQXZGdVZY?=
 =?utf-8?B?WGh6dE1kQld3VVk4WXVBRVA5UWxtaEhoUTh0RXVSWDdnbnExdmJOMzFqZVZp?=
 =?utf-8?B?c2c4azJNR2xuWllOWnp4R29ucGo2NHI1ZmNtVHVmd0VLdFhwU0svMHpidXJm?=
 =?utf-8?B?VFZUSjJnRTZtUmFmOWQ0VVhaazA2RjVSZ3oyMWt6a1Rtb1dsWitBRmtGZE9T?=
 =?utf-8?B?ejNtYjMwZExwdjZBL2VmWC9OdjFNNURFOWlRekVJWnFvRmV0Z0JoVUhEZHFz?=
 =?utf-8?B?YXFuVjArNDRSc0ZkTkcvK3F1OWRjbnhpY1JUY3B4aWVuQW1jcWRFYlRrUVp2?=
 =?utf-8?B?R0JvRlYweDdpTGhCeDFrRXdud2RIbmErVzRBNFdOcUZyTXhWRWN1bENQY3or?=
 =?utf-8?B?YnpRdERrUE5ibnZYNGtkVy92UGFyWUJQVDlCaFZleUpxZHdOT3YveUpGSGRr?=
 =?utf-8?B?cElBYlpwZFplajM0RjZGVkZkN1FTM3dHbEVwVGtSRmIvSVNocDdDV1NQSEtB?=
 =?utf-8?B?RUdCcnFEdW5VMnhzNmFLZWptcTk5S0RTUll3TGxZM2prSE5MR3R6UG1FRTM4?=
 =?utf-8?B?bWdGbDRCOUlQdFJieVFZWUdFRmp5emtYUmlMVnY3YVN1ejc5YnE4akh0SmV6?=
 =?utf-8?B?dGJZbTV6YkJFM3BoSlVEWnRaZm9LWTdqeExXMDBCRmExMkV3UStOd2ZuL0NI?=
 =?utf-8?B?aDluUWlTNTZsWDBRZDlUQWZpSHZ6bEs4K0o5QzZpRWxjSmkxM3U3aE5Ea3o3?=
 =?utf-8?B?ck5UTTF3MGdqUGFkMEo1Wk14VUkzRSszN2M4TFUrYldaallIOVF1UmszbzVw?=
 =?utf-8?B?elFvQ1FXMXo2TGFXUjBjV210SkFPU1Qvbk8vU1JDRUpoZThxY3dlNlZSRjBn?=
 =?utf-8?B?L0VIMGlGblVSZnNhdG5rUEh4c01kVy9WZ0JwZ1k2MTZraGFvQkQ1YWJUYlRJ?=
 =?utf-8?B?WGcyc3ZiVmpsY3QzazdNMXppOGNuZnVSQ24wUkI3dk9GWVNaMzhJN01lcFpj?=
 =?utf-8?B?U25IYkhocXI2bnN3NWNCV2dXclJoalVFTUtDOGhLL21icHYrbFRoa0drdUFL?=
 =?utf-8?B?WU1UWi9SLzViSUxidFhCUGowQUVyTUZ1M0Y2eVZ4Z2hSZThkcDZ6QXZIakQ3?=
 =?utf-8?B?aURSRm1YV3B1UHhVN21sdkdUeHdKWlBLSitJMzRiMWVIOE4rY2h6UDY0VzFj?=
 =?utf-8?B?OHZjZFVVY3ZHeldNVlFtQlZmYlBSdENWcWFyOHdnN0U4VktDYnRlT1hDY3RH?=
 =?utf-8?B?Q3J4SXRuM0pGTDhNRDVENU9BSnl0RWxmdzVKQ2QxVzluWHIxNjI0M0h0Sk1s?=
 =?utf-8?B?REp3T3BFcGViTC9SZWpUNWV3Y3cyNk1YSmlmNnJQUDV3R1U2ZjdpcUQ0TzYy?=
 =?utf-8?B?d2dFTHlRaUQyM0lhOTJ0K01ucCt1QkpOb2ZETkZuUkE5Z3c1Q2hHRXJobXF5?=
 =?utf-8?B?eFdXaUFsdXJoSTNEUmJvbi9XdjBZdVdSRmdudk5SSE1mY2NjU3I5N2tFeHZ5?=
 =?utf-8?B?ckNhT1l2NTBhYXlYODQyUHJrbEtYRXFDV2Y1UmJpT3JMMGgwRGRIcVIzQlZU?=
 =?utf-8?B?ZXY2RkcrZzFXZGNlYVF0RVM4V1ZvYzJGdWRSM2lsREZpQzJuWmovbUlPMlFT?=
 =?utf-8?B?SXByOGIyV2VjQjNLMys0WmtJMDlrSDVwa0oxL25HNExtYjA3eDZMU0FmS3VK?=
 =?utf-8?B?TkUwNGxqUDE5RlFqWk5oMW41eVArNEpNT1ZQUkxpUVRJQWtpT1VDenNoeU1H?=
 =?utf-8?B?b2RCeDdFZFAyVk5xb3ZnL0x6U0dlME0wYjlkSXkzdVk5eEl4TlJFdXM3RHdB?=
 =?utf-8?B?NDhoQmt3NVI3YkMrc1dyMWpQRjZsQ3NVZklmY0JaNTQ2cjJXN1BUUmQ2VkRy?=
 =?utf-8?B?bnQ5SmpxY3hTOWdWbzk5aGltK3RQK205MjlKVmNYYXMyQWZhd3ZRRjFqWTZ2?=
 =?utf-8?Q?04kl6w0ti6mB1UPEdt9zKdWqktwh1sh6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:43:55.9517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c9b9e7-3f75-44e3-9c7c-08dd0b366235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependable on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  7 +++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 24 +++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 88 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++
>  6 files changed, 157 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 3eb55dcfa8a6..a8bc777baa95 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -65,6 +65,13 @@ config SFC_MCDI_LOGGING
>  	  Driver-Interface) commands and responses, allowing debugging of
>  	  driver/firmware interaction.  The tracing is actually enabled by
>  	  a sysfs file 'mcdi_logging' under the PCI device.
> +config SFC_CXL
> +	bool "Solarflare SFC9100-family CXL support"
> +	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)

If I'm reading this right, you want to make sure that CXL_BUS is not set to 'm' when SFC is built-in. If that's
the case, you can simplify this to "depends on SFC && CXL_BUS && CXL_BUS >= SFC" (or SFC <= CXL_BUS).
I'm pretty sure you could also drop the middle part as well, so it would become "depends on SFC && CXL_BUS >= SFC".
Also, this patch relies on the cxl_mem/cxl_acpi modules, right? If so, I would change the CXL_BUS above to one of
those since they already depend on CXL_BUS IIRC.

> +	default y
> +	help
> +	  This enables CXL support by the driver relying on kernel support
> +	  and hardware support.

I think it would be good here to say what kernel support is being relied on. I'm 99% sure
it's just the CXL driver, so saying it relies on the CXL driver/module(s) would be fine. I
have no clue what hardware is needed for this support, so I can't make a recommendation
there.

>  
>  source "drivers/net/ethernet/sfc/falcon/Kconfig"
>  source "drivers/net/ethernet/sfc/siena/Kconfig"
> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
> index 8f446b9bd5ee..e909cafd5908 100644
> --- a/drivers/net/ethernet/sfc/Makefile
> +++ b/drivers/net/ethernet/sfc/Makefile
> @@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>                             mae.o tc.o tc_bindings.o tc_counters.o \
>                             tc_encap_actions.o tc_conntrack.o
>  
> +sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
>  obj-$(CONFIG_SFC)	+= sfc.o
>  
>  obj-$(CONFIG_SFC_FALCON) += falcon/
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 36b3b57e2055..5f7c910a14a5 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -33,6 +33,9 @@
>  #include "selftest.h"
>  #include "sriov.h"
>  #include "efx_devlink.h"
> +#ifdef CONFIG_SFC_CXL
> +#include "efx_cxl.h"
> +#endif
>  
>  #include "mcdi_port_common.h"
>  #include "mcdi_pcol.h"
> @@ -903,12 +906,17 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +#ifdef CONFIG_SFC_CXL
> +	efx_cxl_exit(probe_data);
> +#endif
> +
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
>  	efx_fini_struct(efx);
>  	free_netdev(efx->net_dev);
> -	probe_data = container_of(efx, struct efx_probe_data, efx);
>  	kfree(probe_data);
>  };
>  
> @@ -1113,6 +1121,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +#ifdef CONFIG_SFC_CXL
> +	/* A successful cxl initialization implies a CXL region created to be
> +	 * used for PIO buffers. If there is no CXL support, or initialization
> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
> +	 * defined at specific PCI BAR regions will be used.
> +	 */
> +	rc = efx_cxl_init(probe_data);
> +	if (rc)
> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> +
> +#endif
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> @@ -1384,3 +1403,6 @@ MODULE_AUTHOR("Solarflare Communications and "
>  MODULE_DESCRIPTION("Solarflare network driver");
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, efx_pci_table);
> +#ifdef CONFIG_SFC_CXL
> +MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
> +#endif
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..99f396028639
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + *
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev;
> +	struct efx_cxl *cxl;
> +	struct resource res;
> +	u16 dvsec;
> +	int rc;
> +
> +	pci_dev = efx->pci_dev;
> +	probe_data->cxl_pio_initialised = false;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		return 0;
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxl->cxlds)) {
> +		pci_err(pci_dev, "CXL accel device state failed");
> +		rc = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	cxl_set_dvsec(cxl->cxlds, dvsec);
> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
> +
> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
> +		rc = -EINVAL;
> +		goto err2;
> +	}
> +
> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
> +		rc = -EINVAL;
> +		goto err2;
> +	}
> +
> +	probe_data->cxl = cxl;
> +
> +	return 0;
> +
> +err2:
> +	kfree(cxl->cxlds);
> +err1:
> +	kfree(cxl);
> +	return rc;
> +
> +}
> +
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{
> +	if (probe_data->cxl) {
> +		kfree(probe_data->cxl->cxlds);
> +		kfree(probe_data->cxl);
> +	}
> +}
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..90fa46bc94db
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/****************************************************************************
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#ifndef EFX_CXL_H
> +#define EFX_CXL_H
> +
> +struct efx_nic;
> +
> +struct efx_cxl {
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_port *endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *efx_region;
> +	void __iomem *ctpio_cxl;
> +};
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data);
> +void efx_cxl_exit(struct efx_probe_data *probe_data);
> +#endif

I know nothing about the /net code so sorry if this is just a style thing, but
you can delete the #ifdef CONFIG_SFC_CXL in efx.c (and elsewhere) if you add stubs
for when CONFIG_SFC_CXL=n. So the above would look like:

#if IS_ENABLED(CONFIG_SFC_CXL) // or #ifdef CONFIG_SFC_CXL
int efx_cxl_init(struct efx_probe_data *probe_data);
void efx_cxl_exit(struct efx_probe_data *probe_data);
#else
static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
#endif

and then you can just #include efx_cxl.h unconditionally.

> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index b85c51cbe7f9..efc6d90380b9 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1160,14 +1160,24 @@ struct efx_nic {
>  	atomic_t n_rx_noskb_drops;
>  };
>  
> +#ifdef CONFIG_SFC_CXL
> +struct efx_cxl;
> +#endif
> +
>  /**
>   * struct efx_probe_data - State after hardware probe
>   * @pci_dev: The PCI device
>   * @efx: Efx NIC details
> + * @cxl: details of related cxl objects
> + * @cxl_pio_initialised: cxl initialization outcome.
>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
>  	struct efx_nic efx;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_cxl *cxl;
> +	bool cxl_pio_initialised;
> +#endif
>  };
>  
>  static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)


