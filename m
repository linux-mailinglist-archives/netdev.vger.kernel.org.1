Return-Path: <netdev+bounces-148635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7289E2CD1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7BDB32E86
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C633A1FAC3B;
	Tue,  3 Dec 2024 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IFrO2Kqk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0511FCD17;
	Tue,  3 Dec 2024 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251312; cv=fail; b=nkB20ht5RTqmKGtvgxYeOnSh374cCM0i71oLpKqfXULWwOOfxpCuK/eBFpbWARMT+rkfPqRQxZJ1gYnhDPr3f+XfIrKZOcAs3j6yz93vblKlIubxB+f6ADbRlg848iMitS6UkbdUPn8KH+X8opQtZVZPkiXnmjd9NvpLAS0AgdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251312; c=relaxed/simple;
	bh=JoR4VBnDaK5E3iKMWS85ADMT/rVQuShmPR2FXAtFHR4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PC4svXsGW+bg3Hx0FJEPIFF+iA/V36i+83zx1VsYJ+ncnmxG7YP/eycAKegr0uMbcIQnCTlSFw3UEJQVogIOcWAvLzzwh2zL4UUVAX2V7EkTofqy3oS29Ev2hDuHqAJgNegUCti+r9loZJ1DmRCbeFgdv+JYmYMWNmrCanCA/Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IFrO2Kqk; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUdxzBaFfMt8Wm4Cns8lg/xmXeIXUFtMqXcjqWZ1mwIxaiFhvRuiUDLrTNLDyoKgFbg5prESbnh4X7I8ti8VN3GlOvYyPdyOCoeKp9qN7zRRjb/Uefjzpm7XTVM+yqhZ0qlCF0QAnOqIP8xrcV0wjsGhlul9h6e/HzveyRLXKMTnW87qwe6pZNid5o4vGUxx5VAtPxMbTnbQEoyI+8ozFE8qAqftc4FDNPCFGc5/04QMgCJgzF++LOQKztshTAGAW1ClYdOeQWkkWPX94aw5GfxmbVP4tLli8+mjEIRfMoa77bbicG2EERYt9qLNi9j4v8MbeRO4YZClUODmiUfONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsK7We3/S91WNITSlw4QSUDWtwwrUSbfYhy/YiiphAY=;
 b=WdcCujm7DkwcAAixgfl+TZ5rhVcm5sMVjJY7IWS3fVOXbRlJFjL8PMZWGkuRQ/AvF3e7MDLVz0azEaposuTAsp6t9AMsAPXvvFLVXyVE152Kknb2Bt15fn4NnfyecuZl0194QmPTRytTzPFZJ49IbFWVzoAWItVkah9yqKYMpYVLvcWNBBH0RHaygenNeT+1lyvKaf7XQtSfgf72ilMMqUUZxmvICEU38g1AmEt9xfYN+rv5Dabl/H9lKfgVwEyhkOJD7KYCG/2GZ1SV3lioY+2nuN+oUu11HHHd7NJDA9ppxeSXCHjuAfPHOWECWib0il6Gho6Ytx9bGwIikOXNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsK7We3/S91WNITSlw4QSUDWtwwrUSbfYhy/YiiphAY=;
 b=IFrO2KqkmgRTI19Td4dCGKbjD/JnYhQOpPG2s+OBg7U2phipz9I1BrnPlNMBgz2rkBfFBNrf8ZWzxssvjQLol7sPFyCjUMF9PUxwuh+68oMVmXjpLEY+cI01wTSaez8o2+eEmjO2wmmo0Yn/o8duugoLD/2igicPfc2HaY4a6iR8C62zs/sIl4Aq795iuiUScmKc6bG4hq95a1xHcZo0WrV17CAanEQxue5LCnaDSYXpzX7UV5dNb25PQHuHVHyRMI12SthCWffXaFxogFPApUjwfmgmocz/scFSf2t2ThHZvCU771/8FMx9Ebk0FRx+B7e9qBT+lfd9NuLb3ehfyQ==
Received: from SJ0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:2c0::10)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 18:41:44 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::eb) by SJ0PR13CA0005.outlook.office365.com
 (2603:10b6:a03:2c0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 18:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 18:41:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 10:41:29 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 10:41:28 -0800
Received: from localhost (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec 2024
 10:41:25 -0800
Date: Tue, 3 Dec 2024 20:41:25 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>,
	"Alejandro Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v6 07/28] sfc: use cxl api for regs setup and checking
Message-ID: <20241203204125.00005b67@nvidia.com>
In-Reply-To: <20241202171222.62595-8-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
	<20241202171222.62595-8-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2eb7ee-56fe-40d6-65b5-08dd13ca229f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wL/fyLi7gDx0OxqESuRzxuH6Q3VmMrQjpEfbXgflFATXcvHzrgdqT/Az0prb?=
 =?us-ascii?Q?hRqyUGQ/TUr3CoQ6CTs5ws9JeHTlrbG8+3y0ePhtSdoZENr+iMnTLDO6kmrJ?=
 =?us-ascii?Q?AeY8DCemqOxKieyHyzdNwBY7eICP28BR/kl/4FNvSsOiwYF+MtMc/wZ0dfve?=
 =?us-ascii?Q?ZFqjC5e7D0+sdlIo5DfGGVFomCkkI/A47okfW0NVuoR9kBjPlz0AuiqbgvCN?=
 =?us-ascii?Q?nXF5dBnsTeYjdwcPb2Wy+ZiiAgEIkdCUI3XAbyWu+b9dO+NPQvr1uAosuklc?=
 =?us-ascii?Q?Isc3IdT3dHZFC0NfxKhwoYKLIHL1pfNs37gmg2qkIVAcCQRIXqFv92lrBRjT?=
 =?us-ascii?Q?oamZLiFAtKIxFIZwWWdl0id8FwlAHgoJgp0ceBjS4sumATJn5LLhMWq0GJ9o?=
 =?us-ascii?Q?qAS1TyIwaioc2EzdWDKbF4BG0r6IY2ni/MQCYTgGf5ivpZkO/zeKzSZRRPtL?=
 =?us-ascii?Q?Oc9lJebJ3navCG8hgvG/+0+x6pDnnqhXlyOs7ZXxUSjcyB/TzmjUMWutHp8j?=
 =?us-ascii?Q?3fsuhRu3G3h3z7/YOy4fMO8luBcO8DVrJ6y9roBnrW5vHDlOwZ1WHzE7ckQv?=
 =?us-ascii?Q?HqZECvTtI6vKdBrvLSqfGaEpJ6JmS+3n6wIU7EFkLdHDbsPhzIqZY6regWrZ?=
 =?us-ascii?Q?ZeINrXRk1IbMrA2VyoOs4NOE+Bn5m3E1iCLriGwbDDtLzFQ40sPs/cAyJlr6?=
 =?us-ascii?Q?84/n1c47ArcoEtYt+VrSmwhu/qzFNQ9iqYnoZSq5xr30+eW8iJv28OU3Dni3?=
 =?us-ascii?Q?kO3ag+SUyQ+qvptl9+EGTYXPIrPrHdRknNMIvkxZN5hY9iSy3iRj6cjM6gJn?=
 =?us-ascii?Q?QLqwgJDE4v8TH65LiTQehk6DMSNM8Xi/qZQYeTPQw7cLXKMNaWUc/kO5M3o4?=
 =?us-ascii?Q?2rHO7Ai9pGdSuxlKr3tRG0BVWCAYqVHkTTbXSSTaOrg9PWZkA9ePYOHeAf3x?=
 =?us-ascii?Q?/TMKdKEFiCL5ghi1MVUTca8TffF0vAm/S6C1gW+b7cdcRxspJPKVtzH1mrIe?=
 =?us-ascii?Q?BeKVM9/o6iPqIcZaZHt1EiPf1vyJkzwOz1vO/n7TJDVwTEovla49zz6GJv3d?=
 =?us-ascii?Q?se9VUHN/ZyVJbpGR9Mndd4+9fJRYmFKWeBBE71ONVwbJWotNeI5eTCSvCkx5?=
 =?us-ascii?Q?fhMEmDo6Lk78rR1cZ0qp9VQ4DsFRTZwtxSZmwSUaEBd9YHpf1zegEgtss0KZ?=
 =?us-ascii?Q?8tiDUhEWfjDmArVdsHBBRFvZFUcK25o7T/arhl4pZ2GkLvs9l70eNPCYJpRn?=
 =?us-ascii?Q?BfI4y42LupwSIepJsemQFmUN2+saY0p2wRpjnddW8sJjLLZxMau36Bqxnvm5?=
 =?us-ascii?Q?vIwdatNaOiIuiNp5zdIsptyK1+MyjqkGbF8KQvDfCAwxaxQj5oq1lJqs//Sg?=
 =?us-ascii?Q?ZROvStJiQ39U061k4E3+nk/qRCls8LZR3rQVTJI/gi3Dw8XFLDnXn6kvYVyu?=
 =?us-ascii?Q?m40v5GftRsY/8cBpXOk+dsJ1MHNQe2HT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:41:44.0577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2eb7ee-56fe-40d6-65b5-08dd13ca229f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901

On Mon, 2 Dec 2024 17:12:01 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 

LGTM. Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
>  include/cxl/cxl.h                  |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 9cfb519e569f..44e1061feba1 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -21,6 +21,8 @@
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct pci_dev *pci_dev;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> @@ -65,6 +67,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err2;
>  	}
>  
> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		goto err2;
> +	}
> +
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
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
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 05f06bfd2c29..18fb01adcf19 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,6 +5,7 @@
>  #define __CXL_H
>  
>  #include <linux/ioport.h>
> +#include <linux/pci.h>
>  
>  enum cxl_resource {
>  	CXL_RES_DPA,
> @@ -40,4 +41,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *expected_caps,
>  			unsigned long *current_caps);
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  #endif


