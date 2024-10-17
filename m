Return-Path: <netdev+bounces-136758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D215E9A3006
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401E9B2122D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277431D5AAD;
	Thu, 17 Oct 2024 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IIyFwUoa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002901D54EF;
	Thu, 17 Oct 2024 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201742; cv=fail; b=V0dUD01o6XFZC57tTtcPalZ4i8SKb0QGZM0wX84RAvpIFR8sYx0NFKvQAsKZn1WP2HLqwlyfTOnPNbENNLz2j4QBXSkVYWQCnmjXZyRzlQa2oc+mj6yUK86e9hlR9Q8RiuRudk9In52YV35/rySFyMvl47RqH+RMiaM26JWgTaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201742; c=relaxed/simple;
	bh=Q6zyBOyHpg4tXoen9oc9a6nQ2YnSHSrTXAFa4/pQZVc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=EwNgosauHYofn8B9rWlsRaG+J344/TCeQ9EhIzWypjTnHoZjVgheZJOXthdzmQ3rVrlojlhcxYYj3/Rx897Gc+0R20rgeX9uQgdLGOAZviLFMUvKpP1hk9FM9FIoxlH4+3c6LBYFY+D/kMYsOaAjTUm/ZIXinAHP+rk3hdKuBKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IIyFwUoa; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEWLarXs5ZW/23d6cQIMJf2S8JPcWlB/SeNcF6Onjk2awwCqyidNux4HbbDjsf1GObxsxNJEhq6DaQCqlDu7D6hzW/PLj32NCZPQqUHCv1BCDusp11xWHe1Psb8PzHGR2qtQsbfjX6MKnBdMQtqkKRj8FuXmxCRPh5CU9wuuLIDzw4TTKrY1QaxLuw4NLZsydmHQeRrnKU2mWBrUiniNge2nIDoJnUPBE4KudS5rHSwO6lZoCzq/0tE7V5TgV+QfjOowTLpZl49LoIhX/5/R31QRLMx0hmYTaMUN1JaynxA6MkNt/U2SAEbMi6yflQ57gkdHl6/AQxPikY69k2JE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaXQUFamNTCm3mh9TmZNnyVcPFPOOJGBMH5gIZzA1sI=;
 b=RupcQinRu0pk193AbHF68N+6txHEwEZ5ShtfFHNXucbq23zL/ujPlzrOLWjaiOQY85Cvfu9RoUSEKRjl7yJrYUAku/GfGH9aHDqlB3FRz3cZWQDqmu9jABtDuLnKwSTiwozkrMohuA4C079bhSeCM8XpdcrEa49jis4qeGt/tIr76bUMWgFzcjPrCp+J9Cn526qiesgOrOv5NkJJr91flfzRVH28lQKff0aWbG4YaMAmqxIy6JzoiIT2Hl2my18/oyb2NUNE7D3VeaR6iCEhG4yfidkOI8CknleLHUbNbfy7RubTRkw0bm4RPHcjsghlGLxKzN+FhaodSFfcTAAn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaXQUFamNTCm3mh9TmZNnyVcPFPOOJGBMH5gIZzA1sI=;
 b=IIyFwUoa2jlrykdO31HS3SIRAk5xR1ziCbqqrs77ZkEFWa5jcE2zMerVm1ppfr5P+CxUhxKe+0YYkfcFfewePra9dWLAi5tqKwTL+w1d1MtLkrCW1peqieZIxnFgRpPxy1rEcrogPamaAEqqWxBRi4di5vLQI3YJtQKiya+ElN8=
Received: from BN8PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:60::31)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 21:48:50 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:60:cafe::80) by BN8PR12CA0018.outlook.office365.com
 (2603:10b6:408:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 21:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 21:48:50 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 16:48:48 -0500
Message-ID: <01ef15ab-dc8a-4796-8fc5-90c2d4107435@amd.com>
Date: Thu, 17 Oct 2024 16:48:46 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v4 02/26] sfc: add cxl support using new CXL API
Reply-To: <benjamin.cheatham@amd.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-3-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241017165225.21206-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b572397-7e53-4a70-83a6-08dceef57caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkcySjF6SEVKeFVXa3lhcDJscmJHdzR0MFZPeEFxU1JYRHNoNzEzNWZyRWgv?=
 =?utf-8?B?c3hOWlpva0FIODNwQWJLeHNiM3M2blV2ci81endFZ2VWSTRrUk5HQTRxbFlM?=
 =?utf-8?B?UnU0SWxEb0VuRExkWkJGWkJxQmZzeEYxeEtIT2VyTEpKMEFzdy9aellFR1Bs?=
 =?utf-8?B?Y1ljcGhLVUdzY3NSamFMQ2YwVmlsYmpmNUtFSUtoU2hpNWFUcERITzkyKzVk?=
 =?utf-8?B?ekFLUzdPWTJIYWY4YUdmSFRnOXpxQnNEcStYdTZlNzQxTHUybjB6QU1Ha0p5?=
 =?utf-8?B?MGZkSTJRTUhtVldXQkMxZUxwQnhHdkJLQzE5TmhBWUptYzVvWHNrNTJNM0c5?=
 =?utf-8?B?TjZYMUFQanloZWVUV1JNUTN5VXFaREg1d29iT2VHWmRORWM0WVlzMnJ2am85?=
 =?utf-8?B?eUsrN0I0N3BHZU50MVpwOHNxdHNsdG5VaXhFWU5DZ3ZoUURHR3doaVd0K3F6?=
 =?utf-8?B?VlhVWDkzbzFZVmEyejFISWo5b3RmMWpienJENzZ4ck1NTGN2S0x2bE1Cd0Q1?=
 =?utf-8?B?Y0tlYzgrYURqbUNLODBRSGNSSzgvajQxMXNzbHZ1QVJBNm5wTkJNWVZ1TUcy?=
 =?utf-8?B?dWdKQ3FpdFJ0R0JjRG15Q1FyNEVWa3RoUmZSMENRWjMybDBYR2xTbnc3YzEz?=
 =?utf-8?B?bnNabEhnbVZsQ08zbGJiU0MzS3FKR0d0ejNEdHdTUGVnN1pBZy9ndHFLRjg0?=
 =?utf-8?B?SUlzdjFmRys4cDE4R2lLMVhBaTdzRDEwb1RSZnJjL1RJaHd4SHd5QWJrM2Yv?=
 =?utf-8?B?dk45Q3BuVHp6MGZNNVJjemxWSmpsR3dYOFdhZWcwZzFlRkFFaDhzek9nUDBE?=
 =?utf-8?B?QmlDQWUvTXp5czlodlU1Zk5zZ3NUYVgzdXU5MWdBNnpZaWJBZWNOYTliRkZn?=
 =?utf-8?B?NG94Y21vYWZQcnRHUWRkVktUSmdDWDVsemhJc1dlc0JHVVVHYlZQSlovbEx4?=
 =?utf-8?B?cFJESjRzTW5XbmVIWERHdjVRbGRUMW41UC8yN3N3N3V1bGlFbWlJWXZCYnNY?=
 =?utf-8?B?bUVNdkxmdjBwbG9xMHBQZHF3Qkx6cTFmZ050TzlQRVF1dEZkdnl0UEl5c0RU?=
 =?utf-8?B?cUJxVkVFU3BpTFNwcDNyWWh4dkdOMFBLSVRFS2VyTkwwZFZRMkVJdW16UGh6?=
 =?utf-8?B?SysweWVsbGd5TEJuVlZ2aTJqY2diVm9qbzdaUzUwVmcwN0VSVVk5R0pXU0hr?=
 =?utf-8?B?UUl5S2tMaldmTVY3VDZ6bkZ0YzZOMWFnaXluUjVPSlFtbTIrZTRZZDRMVm03?=
 =?utf-8?B?RVFlaUgxaE5kcFlvbXc5eC9TY210MlJvZHRURnpUbEQ3SmpvTG5SYVBISHpp?=
 =?utf-8?B?RjZiL0RqS29hNy9PYmZMYVpWb0d2WEN5OG82UGZKQndxbnNkMUJES1IxQnFy?=
 =?utf-8?B?cTFGUThzaXc1L2ZtS2tuZkdvajVTSmFWUVZsT0Y4QVZuUlFPZWlNMEJQUVZ3?=
 =?utf-8?B?U3k5aTJmVERFcHpaaldzV21aQ3dUOHQ3RldQcnpOSFZVYlVNL1YzT09zcjBq?=
 =?utf-8?B?QXpqRTJxUmlsME9COVR2MjFjcVdybFNXK0E1eWY4eGtjNDlWZEorY2o5VTFG?=
 =?utf-8?B?a2hTTVFEVnRCWHZFRHk5WXRiZS9VaGpCc21FelhmVnh2K2FiVzhnbDcvdUow?=
 =?utf-8?B?YU9SS2pFWFBNWjFRWUhvTTZpc3ZSaVdiZ0hpNE1VU2FxdHl6RG5hUG9vdFdi?=
 =?utf-8?B?WmoyYkpQOWs5elpaNjBOZ2hFNTVjb3A4RFVBTTEyWnQxeS9NY3JyVml2enkv?=
 =?utf-8?B?VFNmMXdhdUt5eGw1SFo1NmtMZ2YyMVVCdkNZelpoaVZ0OXVvUG5MWW01V09F?=
 =?utf-8?B?TGN5UnJjR2d2VTNZc01IczV5RFYzRjRvcGtmOFBmdEQxaU9oL3I0eGRTY3RF?=
 =?utf-8?B?VDVtY3A1WndFamtpNlIwVnIxQU1ZTm1kWWMrVjdzeWcxWGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:48:50.4934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b572397-7e53-4a70-83a6-08dceef57caa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637

Hi Alejandro,

Thanks for sending this out, comments inline (for this patch and more).

On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependable on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  1 +
>  drivers/net/ethernet/sfc/Makefile     |  2 +-
>  drivers/net/ethernet/sfc/efx.c        | 16 +++++
>  drivers/net/ethernet/sfc/efx_cxl.c    | 92 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++
>  drivers/net/ethernet/sfc/net_driver.h |  6 ++
>  6 files changed, 145 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 3eb55dcfa8a6..b308a6f674b2 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -20,6 +20,7 @@ config SFC
>  	tristate "Solarflare SFC9100/EF100-family support"
>  	depends on PCI
>  	depends on PTP_1588_CLOCK_OPTIONAL
> +	depends on CXL_BUS && CXL_BUS=m && m

It seems weird to me that this would be marked as a tristate Kconfig option, but is
required to be set to 'm'. Also, I'm assuming that SFC cards exist without CXL support,
so this would add an unecessary dependency for those cards. So, I'm going to suggest
using a secondary Kconfig symbol like this:

config SFC_CXL
	tristate "Colarflare SFC9100/EF100-family CXL support"
	depends on SFC && m
	depends on CXL_BUS=m
	help
	  CXL support for SFC driver...

And then only compiling efx_cxl.c when that symbol is selected. This would also
require having a stub for efx_cxl_init()/exit() in efx_cxl.h. That *should* have
the same behavior as what you want above, but without requiring CXL to enable the
base SFC driver. I'm no Kconfig wizard, so it would pay to double check the above,
but I don't see a reason why something like it shouldn't be possible.

>  	select MDIO
>  	select CRC32
>  	select NET_DEVLINK
> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
> index 8f446b9bd5ee..e80c713c3b0c 100644
> --- a/drivers/net/ethernet/sfc/Makefile
> +++ b/drivers/net/ethernet/sfc/Makefile
> @@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
>  			   mcdi_functions.o mcdi_filters.o mcdi_mon.o \
>  			   ef100.o ef100_nic.o ef100_netdev.o \
>  			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
> -			   efx_devlink.o
> +			   efx_devlink.o efx_cxl.o

With above suggestion this becomes:

+ sfc-$(CONFIG_SFC_CXL)		+= efx_cxl.o

>  sfc-$(CONFIG_SFC_MTD)	+= mtd.o
>  sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>                             mae.o tc.o tc_bindings.o tc_counters.o \
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 6f1a01ded7d4..cc7cdaccc5ed 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -33,6 +33,7 @@
>  #include "selftest.h"
>  #include "sriov.h"
>  #include "efx_devlink.h"
> +#include "efx_cxl.h"
>  
>  #include "mcdi_port_common.h"
>  #include "mcdi_pcol.h"
> @@ -899,6 +900,9 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +
> +	efx_cxl_exit(efx);
> +
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
> @@ -1109,6 +1113,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +	/* A successful cxl initialization implies a CXL region created to be
> +	 * used for PIO buffers. If there is no CXL support, or initialization
> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
> +	 * defined at specific PCI BAR regions will be used.
> +	 */
> +	rc = efx_cxl_init(efx);
> +	if (rc)
> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> +
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> @@ -1380,3 +1393,6 @@ MODULE_AUTHOR("Solarflare Communications and "
>  MODULE_DESCRIPTION("Solarflare network driver");
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, efx_pci_table);
> +#if IS_ENABLED(CONFIG_CXL_BUS)
> +MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
> +#endif
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..fb3eef339b34
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,92 @@
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
> +#include <linux/cxl/cxl.h>
> +#include <linux/cxl/pci.h>
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +
> +int efx_cxl_init(struct efx_nic *efx)
> +{
> +#if IS_ENABLED(CONFIG_CXL_BUS)

With suggestion above you can drop this #if, since the file won't be
compiled when this is false.

> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl;
> +	struct resource res;
> +	u16 dvsec;
> +	int rc;
> +
> +	efx->efx_cxl_pio_initialised = false;
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
> +	efx->cxl = cxl;
> +#endif
> +
> +	return 0;
> +
> +#if IS_ENABLED(CONFIG_CXL_BUS)

Same here...

> +err2:
> +	kfree(cxl->cxlds);
> +err1:
> +	kfree(cxl);
> +	return rc;
> +
> +#endif
> +}
> +
> +void efx_cxl_exit(struct efx_nic *efx)
> +{
> +#if IS_ENABLED(CONFIG_CXL_BUS)

and here.

> +	if (efx->cxl) {
> +		kfree(efx->cxl->cxlds);
> +		kfree(efx->cxl);
> +	}
> +#endif
> +}
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..f57fb2afd124
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,29 @@
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
> +struct cxl_dev_state;
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
> +int efx_cxl_init(struct efx_nic *efx);
> +void efx_cxl_exit(struct efx_nic *efx);

As mentioned above, you would need a #ifdef block here with stubs for when CONFIG_SFC_CXL isn't enabled.

> +#endif
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index b85c51cbe7f9..77261de65e63 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -817,6 +817,8 @@ enum efx_xdp_tx_queues_mode {
>  
>  struct efx_mae;
>  
> +struct efx_cxl;
> +
>  /**
>   * struct efx_nic - an Efx NIC
>   * @name: Device name (net device name or bus id before net device registered)
> @@ -963,6 +965,8 @@ struct efx_mae;
>   * @tc: state for TC offload (EF100).
>   * @devlink: reference to devlink structure owned by this device
>   * @dl_port: devlink port associated with the PF
> + * @cxl: details of related cxl objects
> + * @efx_cxl_pio_initialised: clx initialization outcome.
>   * @mem_bar: The BAR that is mapped into membase.
>   * @reg_base: Offset from the start of the bar to the function control window.
>   * @monitor_work: Hardware monitor workitem
> @@ -1148,6 +1152,8 @@ struct efx_nic {
>  
>  	struct devlink *devlink;
>  	struct devlink_port *dl_port;
> +	struct efx_cxl *cxl;
> +	bool efx_cxl_pio_initialised;
>  	unsigned int mem_bar;
>  	u32 reg_base;
>  


