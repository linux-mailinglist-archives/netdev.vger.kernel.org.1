Return-Path: <netdev+bounces-119457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AC5955BE6
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 10:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B2CB20EB8
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8F9168DC;
	Sun, 18 Aug 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyPWo7w1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77229479;
	Sun, 18 Aug 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723968451; cv=fail; b=k1LqSOdr3kI4nl/ZyHSYamKWC+3ktqu7o6C1N2UBBTSo/maELwpRvpRFSfYH2xAZW3CTgy5S7fwwuLjDIb97FUIyq3D4IHpXHaHTG/Z7Gc0zmfL/WSP0LSqlPqNPIOCxnOvECUL/5N94gQyo4Y99weeV5e7JOa59u6JpgABdUuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723968451; c=relaxed/simple;
	bh=NRZeCIkP6f2FvYvlmtKL5xpNvfBez6HDZ15HDFKgVhg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwjSZzEBaCD0Mk9HlKd44xAdEyvZBJ8ZYhttE9mY1CFmHAvsW3ycA/0PaOIJfhrb8OP9LL4RjD7AxQNXfOjEjG5crX1MLaT0Muq2+kReXG7lczKvPMdZ5t33bduYVR61WQGRrgbRgbNzhjjKJwrV0SBDzAkM9reqasXpeEEXFd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyPWo7w1; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT6bLtrtu8Gdk9ob6pKdvH9SbrC6mXyDNnW5Gs9sMLMUOBQdpHo/SdQ34ASjFAAWPDWe19iFs1A4ZmUd30lFb2l7fK+WDVHPGPrkznaR5JwXd5UmQaqidrFocDzN2vrwsf8p4wqJgPtD4urWv55jRXWerhfSmj4W1SbXxaNkGRB3Kb+6CqIdcpSRiV+EzJAyujO2Z/Tpk5hW4FZ4VflN+FZaEsNCpMUiH8mQDgvuoY3/dD1113DCJ/vHNmyymWRIzw1sTjPciSThVqJ8FYaexOWDkQ1LsnChNed6eR8/P+CzqbsKnymyJxjiChfSEwaU+UnyA6c8N6o7iP4NpIe0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKSsjxQchI5RdaQ81ATdRyFKZXvNxB5XI5YhMPguDBk=;
 b=aRe4E/+kTv8NDX9Q73okDXhfckEQNYcoAPBJW0K5QgUQxG5f/dgv1BUY32XckGJkMU8mRMniGP/Zelyof5xoO9uWTgC2bW4A3YJukTqh747Sto0bC157u6GHUsC7YsCXstQ/8YLzCOUG5WpFRB1aGiATTbq6Mwr0nwESzEXS9EhzGQk/9NjYRuoO5qNJDeg3aTtj9aI4NZ9Pb6ZE4+Sl/RiUrtzrG4r3G2VcAAQUqsvcLr+s7s1Uxozpk2yk0LxfuzibLXYwe7XoHjYQN+3KaGVqrdkLPTwFpb7rn/QLo+xYC4+1TLeDvRtDp7AmlcUD8ektgLVOhq52nQeFKUgSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKSsjxQchI5RdaQ81ATdRyFKZXvNxB5XI5YhMPguDBk=;
 b=fyPWo7w1jEd8WeBTynU2JHdS8dvNE4hX6ojbBQLCVtE2OfKJr00yuXti1ZCBOal8ZJMe5QFVQB2r1iV7uNVgVd5p7kkBDNZulm7hrTfl//utlEreDovhJPjml+sgWr5otXXfNmKffHYyYFsEK+BWWDhe6tu3Eu/EH+f7mLO1V69OWT3qG+cdaW1h1GhNUzI0Ih5vipnQ9BWQ91zTjYuFDvLQFe5vq66z65FVqo+Q0++lNfJDDRPVVIWkW+574r3u2j9q3wyg+eCAAaGtsjtNlym1iU/bg99jyzd9OsgeUr6PUCJO/ituA+q5T75bcxCXFzgkH2l/1WsO64t6hX4tZw==
Received: from BL1PR13CA0380.namprd13.prod.outlook.com (2603:10b6:208:2c0::25)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sun, 18 Aug
 2024 08:07:25 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::3d) by BL1PR13CA0380.outlook.office365.com
 (2603:10b6:208:2c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11 via Frontend
 Transport; Sun, 18 Aug 2024 08:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sun, 18 Aug 2024 08:07:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 18 Aug
 2024 01:07:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 18 Aug 2024 01:07:23 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 18 Aug
 2024 01:07:20 -0700
Date: Sun, 18 Aug 2024 11:07:20 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>, <targupta@nvidia.com>, <vsethi@nvidia.com>,
	<zhiwang@kernel.org>
Subject: Re: [PATCH v2 02/15] cxl: add function for type2 cxl regs setup
Message-ID: <20240818110720.00004e16.zhiw@nvidia.com>
In-Reply-To: <20240815174035.00005bb0@Huawei.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-3-alejandro.lucero-palau@amd.com>
	<20240804181529.00004aa9@Huawei.com>
	<5d8f8771-8e43-6559-c510-0b8b26171c05@amd.com>
	<20240815174035.00005bb0@Huawei.com>
Organization: NVIDIA
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 0147fdf9-79ed-4dc5-2f16-08dcbf5ccb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZuYoYkymBcRAGIqDvNcM/opi/p76PYEDe2ZDv9rDEbCe0VFe8Bq9QowuxN+r?=
 =?us-ascii?Q?ZAknL4B4ug6lA75mtqQcBVNOLvCtB9/r6O99yj2/R7fhnIgIwr3BeZWBil5i?=
 =?us-ascii?Q?YpeLGswnPuTPi0up+kdtaw0751dQCJmvG6eX+vTY79BRKE+AeItwARXgPuh1?=
 =?us-ascii?Q?ltKnppl3sOJ0AyWiXlVL1RTrw5Q0B008FPELn4gtEfUB3PZ9coO1PdAL6+wF?=
 =?us-ascii?Q?Qxs5txAH7PMTHW4VhEktdoMIPCUWvr8NREXAyhpf1Shnb6kUHVdSjGAM67Ht?=
 =?us-ascii?Q?gYvHYovZTscgkLUTh4PyZ3+6vObWluuDGNhh9WLOdjJjVWPp9C+wkyUTda8/?=
 =?us-ascii?Q?/F7bslXI3SxB1NJuSdUjFjfrRtN2xDbga/rrp07/F8y3lLRUI6DEx+7mHJkL?=
 =?us-ascii?Q?lT/Zua1Do9e1p6tigH2DzdyK0wfZ2ayMesIDHfxxboZGcxShGBzqKdObqiyM?=
 =?us-ascii?Q?lFEF7jdBF5GWe07pQJbV3udgxBKkIgQzanQPxdlXfKI3Hgfum07hb6ajLkz0?=
 =?us-ascii?Q?scZoGi+DIPAhmipN34JLGBiaQPck0Qprj7i+xAuzqibRVtMmayttNwBOjz6S?=
 =?us-ascii?Q?A0O7w+byJXNu1mM710rJTN2SAqH6ep1RmMKJVWZcmPcQh8SgvVM1QsvMOTV+?=
 =?us-ascii?Q?sKqa498lHP84YqTuHnbnT3l86L51bUZrTAoxOzgQZ+SB84xportjm5PfFNuZ?=
 =?us-ascii?Q?b0HEnaSwPCSWeHSq9joi7sTZhsZ03bCeeOb1xE9cyXIqsinDL3P2BUwFAeu4?=
 =?us-ascii?Q?hQLexe3woeH3zTazprib8vZnQwetlzax0TSFCIrES03vGNhhiepCdWy/FciT?=
 =?us-ascii?Q?81RdRyfxobiVkE74mBygc8/9SYomosJkhOudUxBP4LLQl5NBFyDM2RxEch0L?=
 =?us-ascii?Q?Kx4fOnpsxr44h7rExl2NxZg6OLBOey9fBeQ0OTsMkS0JdBIr6j5zH2YnnVM5?=
 =?us-ascii?Q?luaaLccQoqkN3syW9aT90YCrgBKnGSldPnEzo+mxyDalWAF0r6P5CRKjl098?=
 =?us-ascii?Q?q9pISWrRbYxXVRaaT6WlgcPz5H6ijNCXqj0etohpxSV7oGwKay1rnoJ97coi?=
 =?us-ascii?Q?0XPd9PycQckY/YVu6MSG4Nu+3G0SMb7avkZzUBEknsSKQYSRuvougLE+un4Y?=
 =?us-ascii?Q?rcFVX3DXk2igcYCqAv0/HjsXEvt1dtKpkid1kow7Wd9VDjwlnku+naKvaPld?=
 =?us-ascii?Q?7Gn/MeNcjTjusgdwrXc2xRhK6PTO9ZEH9ewrZU7oxHxee0c29YUNpnXGTdz6?=
 =?us-ascii?Q?9t/cloff66wkixFVqxY5UPQNhvuKwIlin0Dh23XnwNWBOe1u0yu1ug9B/2ci?=
 =?us-ascii?Q?9M8a7stgSfxtytpoWTuY+GBgYkmqcsjvxacVo0aqslYTgwuYkPKdCXZCRYN9?=
 =?us-ascii?Q?YEnu6gfMuQVexp7ZYdAcpAGXIc2CwpyQOd+cOdyX6VqFI0pJojgqHHS8F0lc?=
 =?us-ascii?Q?vvG7jW2J7R2sq2lSjVn400qbZAw04TDw?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 08:07:24.9284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0147fdf9-79ed-4dc5-2f16-08dcbf5ccb78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748

On Thu, 15 Aug 2024 17:40:35 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 14 Aug 2024 08:56:35 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
> 
> > On 8/4/24 18:15, Jonathan Cameron wrote:
> > > On Mon, 15 Jul 2024 18:28:22 +0100
> > > alejandro.lucero-palau@amd.com wrote:
> > >  
> > >> From: Alejandro Lucero <alucerop@amd.com>
> > >>
> > >> Create a new function for a type2 device initialising the opaque
> > >> cxl_dev_state struct regarding cxl regs setup and mapping.
> > >>
> > >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > >> ---
> > >>   drivers/cxl/pci.c                  | 28
> > >> ++++++++++++++++++++++++++++ drivers/net/ethernet/sfc/efx_cxl.c
> > >> |  3 +++ include/linux/cxl_accel_mem.h      |  1 +
> > >>   3 files changed, 32 insertions(+)
> > >>
> > >> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > >> index e53646e9f2fb..b34d6259faf4 100644
> > >> --- a/drivers/cxl/pci.c
> > >> +++ b/drivers/cxl/pci.c
> > >> @@ -11,6 +11,7 @@
> > >>   #include <linux/pci.h>
> > >>   #include <linux/aer.h>
> > >>   #include <linux/io.h>
> > >> +#include <linux/cxl_accel_mem.h>
> > >>   #include "cxlmem.h"
> > >>   #include "cxlpci.h"
> > >>   #include "cxl.h"
> > >> @@ -521,6 +522,33 @@ static int cxl_pci_setup_regs(struct
> > >> pci_dev *pdev, enum cxl_regloc_type type, return
> > >> cxl_setup_regs(map); }
> > >>   
> > >> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct
> > >> cxl_dev_state *cxlds) +{
> > >> +	struct cxl_register_map map;
> > >> +	int rc;
> > >> +
> > >> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV,
> > >> &map);
> > >> +	if (rc)
> > >> +		return rc;
> > >> +
> > >> +	rc = cxl_map_device_regs(&map,
> > >> &cxlds->regs.device_regs);
> > >> +	if (rc)
> > >> +		return rc;
> > >> +
> > >> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> > >> +				&cxlds->reg_map);
> > >> +	if (rc)
> > >> +		dev_warn(&pdev->dev, "No component registers
> > >> (%d)\n", rc);  
> > > Not fatal?  If we think it will happen on real devices, then
> > > dev_warn is too strong.  
> > 
> > 
> > This is more complex than what it seems, and it is not properly
> > handled with the current code.
> > 
> > I will cover it in another patch in more detail, but the fact is
> > those calls to cxl_pci_setup_regs need to be handled better,
> > because Type2 has some of these registers as optional.
> 
> I'd argue you don't have to support all type 2 devices with your
> first code.  Things like optionality of registers can come in when
> a device shows up where they aren't present.
> 
> Jonathan
> 

I think it is more like we need to change those register
probe routines to probe and return the result, but not decide
if the result is fatal or not. Let the caller decide it. E.g. type-3
assumes some registers group must be present, then the caller of type-3
can throw a fatal. While, type-2 just need to remember if the register
group is present or not. A register group is missing might not be fatal
to a type-2.

E.g.

1) moving the judges out of cxl_probe_regs() and wrap them into a
function. e.g. cxl_check_check_device_regs():
        case CXL_REGLOC_RBI_MEMDEV:
                dev_map = &map->device_map;
                cxl_probe_device_regs(host, base, dev_map);

		/* Moving the judeges out of here. */
                if (!dev_map->status.valid ||
                    ((caps & CXL_DRIVER_CAP_MBOX) &&
                !dev_map->mbox.valid) || !dev_map->memdev.valid) {
                        dev_err(host, "registers not found: %s%s%s\n",
                                !dev_map->status.valid ? "status " : "",
                                ((caps & CXL_DRIVER_CAP_MBOX) &&
                !dev_map->mbox.valid) ? "mbox " : "",
                !dev_map->memdev.valid ? "memdev " : ""); return -ENXIO;
                }

2) At the top caller for type-3 cxl_pci_probe():

        rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
                                cxlds->capabilities);
        if (rc)
                return rc;

	/* call cxl_check_device_regs() here, if fail, throw fatal! */

3) At the top caller for type-2 cxl_pci_accel_setup_regs():

	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
                                cxlds->capabilities);
        if (rc)
                return rc;

/* call cxl_check_device_regs() here,
 * if succeed, map the registers
 * if fail, move on, no need to throw fatal.
 */
	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
        if (rc)
                return rc;

With the changes, we can let the CXL core detects what the registers the
device has, maybe the driver even doesn't need to tell the CXL core,
what caps the driver/device has, then we don't need to introduce the
cxlds->capabilities? the CXL core just go to check if a register group's
vaddr mapping is present, then it knows if the device has a
register group or not, after the cxl_pci_accel_setup_regs().

Thanks,
Zhi.

