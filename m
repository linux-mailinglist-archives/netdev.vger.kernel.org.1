Return-Path: <netdev+bounces-119455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E006955BA3
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 08:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15B51F21B4D
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840A11CAF;
	Sun, 18 Aug 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SIXlZUwk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622CA921;
	Sun, 18 Aug 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723964125; cv=fail; b=q31W9rpAtSBCZDLax8VW8Mc93GIafINt88ScZa0dVu8qNbcZOic89z6bA9RjpTy/GdTXwg3uoO6B1ENRgnz7avi8KmgUkNGBdfwmQ94Htl8+F0aACR4PiToD5qMi+nhfzZvRFBe+0fPMie3FHjI+H1l4/jsW+47WNZfUfEgDJK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723964125; c=relaxed/simple;
	bh=iI1ZCCd+koFrMOJVj7OIIwtAI7Bo3KpJTo04Zkrppik=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsS8O6hSInJo5IVGSzI9AI6PsP/c4T1NsVGBxBNZNBD6t/iRXA081NxFCFwJg52mQPfr6bI53/HTywibNQHQQ6nm/2hT5VECh4pmeIE++nPXKA9+UbguGLz6S0xccF+CT0KLMjK63wIJ5M6moh5LYk88wa9afB8yMRcCu+oyYIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SIXlZUwk; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9yAYuu5yEvj929JbGGBQ1AuLMpnYPHSEbxQ4qlJZ1e5vl9MyUnaGaHRsWtrdhr1piiN9ch1ijHLaq+EjZOcgKM2+z4AyCQjIsuRnpeX+XoCfaTukujy8JjTAYpnqsh27mqcDUrNDRqqqVZ0fw4CYLUOEKcrvuJjVaMOe9F6bzPAaXVMgtxNgUTuD9nuVnEdccY+cFiB7N1K7LYdfZiLsUHb2wKTRQV0cJrHj7OAxeBR5Vckeehx6TPs3uRCteNOLi7y5cM/Lb4QwpKwK41UzotwYo+VZrAly/Zu6pGk363beE5nneOWg5Q2cHdqNuzMnDqKTe8PO3cr7zHSLhi4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J69ZqN2S1oDqcjD6LjcOdjFL835N3PZgmYgQQf+P9kw=;
 b=qa2mRsaT0BAA/wgRYBcchwyEJBUJcO4UDWlYXXLR2VWFSf/c6WyhPuUrhcWkU1sNOu8apI/zLKLhT3Ie0Ur+6tekuaD1qMigjlmDLP3l9pJxaHdzpJCsYNaxRGnI8K6Aog9FDEZImarUK9nxonpYWwD00mut/Ox5K54d2oWXJKaYAcIEd5HY2BypqYrgVVhOwSUFmA/oMmYlmzFfrvNi3ToCoUlilryPQ4kVyDIYeXI+LGdqsVHq0+ui2CPjpKT2JH9o6NFxrT3JPLJaWEzh2eRdZ26C41eGuCkUP5zZYq8/s/ExW9+f85awMNHI5oWAOUjtn714ju9H5r7EMkvF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J69ZqN2S1oDqcjD6LjcOdjFL835N3PZgmYgQQf+P9kw=;
 b=SIXlZUwkEAqhrkVKiPI/pbNuSd+vWReLPCg2a109MF1AM3DPdIUy15Se4zm8UAhXXmEJzFkloif/5O0jOoEiptNHvUDIdiFsiNXEHTh0C7VaKnjpCQ36YV1QAlHE6ijejy7mLJ98EVasMq8pBVwRLPCB153V3WH4utwiTtRRa572KTAxZZ+YUcXm4CbSUOqQ1xNmVC6mah4dCWYAV1Nn/Fc6Flioe+MN5q4YSH/jjnPZzfA3O03+rgO0RI/shMwM9dJaFu4LDCPDDl/K+JW+okNPdiEwhf6xzrmYQ3TFM6QC8RKiAWolYHVtrU2vVoB/pSAacOBk4a3tNki6EAvmsg==
Received: from DM6PR06CA0069.namprd06.prod.outlook.com (2603:10b6:5:54::46) by
 PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Sun, 18 Aug 2024 06:55:20 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::d) by DM6PR06CA0069.outlook.office365.com
 (2603:10b6:5:54::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Sun, 18 Aug 2024 06:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sun, 18 Aug 2024 06:55:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 Aug
 2024 23:55:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 17 Aug 2024 23:55:18 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sat, 17 Aug
 2024 23:55:15 -0700
Date: Sun, 18 Aug 2024 09:55:15 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Dave Jiang <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	<targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Message-ID: <20240818095515.00004a98.zhiw@nvidia.com>
In-Reply-To: <2482b931-010f-30fe-14cb-2a483b0d8c38@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-5-alejandro.lucero-palau@amd.com>
	<e3ea1b1a-8439-40c6-99bf-4151ecf4d04f@intel.com>
	<7dbcdb5d-3734-8e32-afdc-72d898126a0c@amd.com>
	<20240809132514.00003229.zhiw@nvidia.com>
	<2482b931-010f-30fe-14cb-2a483b0d8c38@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 216b8166-362e-4cad-065e-08dcbf52b932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ui9ZRd38p035tIgl27afoEBK8WJEcczmj77D5XkF1v869CVwhlFsb7vAphf/?=
 =?us-ascii?Q?TQEL+kR+Jc2CKJi29lQItzKz6KXEgRfMbpmnsO+Q9g2xES1S8CtEd2kBQuif?=
 =?us-ascii?Q?cdgtgK2K4CEb1hMelXqWJqSj6416aFVaueKzgIfXlWzs8qfQFUHJh+rEh+7K?=
 =?us-ascii?Q?fa4JzWaNaqKOOJdywakcqfl8ITW96FdjQHPNdYSLcXM5Dj7iPCGHeka0P0hg?=
 =?us-ascii?Q?HvMrrjxHdcZSWCUhAEw6tz5IH+pyYjNnqaovlW+kqBR8Wvhr5LhiTOh7QqFj?=
 =?us-ascii?Q?lWNAnzNkRgpcRq0xTRKO3bDWHoWiiR8y8BCoPDjUU/btw/y9/KuYJJI0HXtt?=
 =?us-ascii?Q?wnO/dwuYMs3d9Ovq2/EkGJQZAdzQSo7RsN+vfMR4zwKNWRmdlgjp9FHOqoPy?=
 =?us-ascii?Q?Bdqq8E9/GnpVHzgsE01e/JrTiw+Ppc/5uffK1sUFLnmFQ0GGyWsK0p7q/Q8c?=
 =?us-ascii?Q?3rzJmLXtvpegBKuqUzU5Gpnp/WkWepgM93poy7ncb2JMbVXAjfg28oDpMvy3?=
 =?us-ascii?Q?ltyTvAw3FlBIEFOg2PeEgjUaJ6DUMH1Zp9mX/pJlalrpfLqxlWvNv/qVvPtb?=
 =?us-ascii?Q?lFIHGu2XzH1Y5OJvzoCWp0OipMXOW60QCyHhPd1ZzGmB9JKlWC5GKVrHJxRZ?=
 =?us-ascii?Q?mhQgD/e8mNUX5US2FPVRPNq3+9fZ7wJZeaV+kfUROODGz0gFO6EGfIWn2wam?=
 =?us-ascii?Q?pV/bgl99ycyc0AE8Q0RnmPEeU5FauiYLMscH+m624nJEOGJ38lQ4/fO2aw0S?=
 =?us-ascii?Q?nSEU8EvBE+InyC20VpdJvSkZ8T5T4Iv9IlequvKjJZ02B3hizlpnEIkM6i7x?=
 =?us-ascii?Q?5Rt7UQAzl9r00uorXuLzgF8GYW5Nc/cdOS3mObPaL93TK/YR101pBCkOuH8o?=
 =?us-ascii?Q?Pvd/z2e3Umz8oDRbu3UpYds+2wS4rVl5E0QmxnH9JJiWrq6S2z5foq4QYv0y?=
 =?us-ascii?Q?jGBjXu4lEBQjf69c7sEc8HzXiUruYlRZYSj7EV/EhOpTHm8pnNdUwujwVyx0?=
 =?us-ascii?Q?h/XOuy1L0eZIRBN3cRKncuA+fcxhxypHsjdOGbSQdWwZSvDY295qHq3YoRGX?=
 =?us-ascii?Q?Z2TZULJhwkGDT4pWONowhEjn4/AKGelTJsYUy5c4wd5K8gQah7cJSdg4tmwc?=
 =?us-ascii?Q?177I/kdLzQCkwDIRkKLV/9dgEbsMz+F7Spv9o3HBMI5+Kvz/CKJHrG6K2pY/?=
 =?us-ascii?Q?rl2DgwnW08zszlcIwi0LJd9fEBimSzVZN3ILKvR/vzzYMmJJvq5W6J8aB9jQ?=
 =?us-ascii?Q?yy8C4Djwf3amuWWrdS+TssYK9up0PIx6aDjLKaqQO5fUIvL6KoUIEO4H91RT?=
 =?us-ascii?Q?LmkDjnesSdmPlA87Pxw7smdNjlFep6lNT0rKAGgRxKY6fK4V95K/JZsQb6ok?=
 =?us-ascii?Q?2jaRKA4r8zK6359TKHh4j05wj4Zv8qApRGE5kR/hn8bTXKCiw86aFzdhb0Bx?=
 =?us-ascii?Q?/43xcPpS6FXii4uMgkF0Z3AG4LY8jeti?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 06:55:19.3492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216b8166-362e-4cad-065e-08dcbf52b932
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136

On Thu, 15 Aug 2024 16:37:21 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> 
> On 8/9/24 11:25, Zhi Wang wrote:
> > On Tue, 23 Jul 2024 14:43:24 +0100
> > Alejandro Lucero Palau <alucerop@amd.com> wrote:
> >
> >> On 7/19/24 20:01, Dave Jiang wrote:
> >>>>    
> >>>> -static int cxl_probe_regs(struct cxl_register_map *map)
> >>>> +static int cxl_probe_regs(struct cxl_register_map *map, uint8_t
> >>>> caps) {
> >>>>    	struct cxl_component_reg_map *comp_map;
> >>>>    	struct cxl_device_reg_map *dev_map;
> >>>> @@ -437,11 +437,12 @@ static int cxl_probe_regs(struct
> >>>> cxl_register_map *map) case CXL_REGLOC_RBI_MEMDEV:
> >>>>    		dev_map = &map->device_map;
> >>>>    		cxl_probe_device_regs(host, base, dev_map);
> >>>> -		if (!dev_map->status.valid ||
> >>>> !dev_map->mbox.valid ||
> >>>> +		if (!dev_map->status.valid ||
> >>>> +		    ((caps & CXL_DRIVER_CAP_MBOX) &&
> >>>> !dev_map->mbox.valid) || !dev_map->memdev.valid) {
> >>>>    			dev_err(host, "registers not found:
> >>>> %s%s%s\n", !dev_map->status.valid ? "status " : "",
> >>>> -				!dev_map->mbox.valid ? "mbox " :
> >>>> "",
> >>>> +				((caps & CXL_DRIVER_CAP_MBOX) &&
> >>>> !dev_map->mbox.valid) ? "mbox " : "",
> >>> According to the r3.1 8.2.8.2.1, the device status registers and
> >>> the primary mailbox registers are both mandatory if regloc id=3
> >>> block is found. So if the type2 device does not implement a
> >>> mailbox then it shouldn't be calling cxl_pci_setup_regs(pdev,
> >>> CXL_REGLOC_RBI_MEMDEV, &map) to begin with from the driver init
> >>> right? If the type2 device defines a regblock with id=3 but
> >>> without a mailbox, then isn't that a spec violation?
> >>>
> >>> DJ
> >>
> >> Right. The code needs to support the possibility of a Type2 having
> >> a mailbox, and if it is not supported, the rest of the dvsec regs
> >> initialization needs to be performed. This is not what the code
> >> does now, so I'll fix this.
> >>
> >>
> >> A wider explanation is, for the RFC I used a test driver based on
> >> QEMU emulating a Type2 which had a CXL Device Register Interface
> >> defined (03h) but not a CXL Device Capability with id 2 for the
> >> primary mailbox register, breaking the spec as you spotted.
> >>
> >>
> > Because SFC driver uses (the 8.2.8.5.1.1 Memory Device Status
> > Register) to determine if the memory media is ready or not (in
> > PATCH 6). That register should be in a regloc id=3 block.
> 
> 
> Right. Note patch 6 calls first cxl_await_media_ready and if it
> returns error, what happens if the register is not found, it sets the
> media ready field since it is required later on.
> 
> Damn it! I realize the code is wrong because the manual setting is
> based on no error. The testing has been a pain until recently with a
> partial emulation, so I had to follow undesired development steps.
> This is better now so v3 will fix some minor bugs like this one.
> 
> I also realize in our case this first call is useless, so I plan to 
> remove it in next version.
> 
> Thanks!
>

Hi Alejandro:

No worries. Let's push forward. :)

For a type-2, I think cxl_await_media_ready() still gives value on
provide a type-2 vendor driver a generic core call to make sure the HDM
region is ready to use. Because judging CXL_RANGE active & valid in
CXL_RANGE_{1,2}_SIZE_LO can be useful to type-2.

I think the problem of cxl_await_media_ready() is: it assumes the
Memory Device Status Register is always present, which is true for
type-3 but not always true for type-2. I think we need:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a663e7566c48..0ba1cedfc0ba 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -203,6 +203,9 @@ int cxl_await_media_ready(struct cxl_dev_state
*cxlds)
                        return rc;
        }

+       if (!cxlds->regs.memdev)
+               return 0;
+
        md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
        if (!CXLMDEV_READY(md_status))
                return -EIO;

Then for the type-2 device, if it doesn't implement regloc=3, it can
still call cxl_await_media_ready() to make sure the media is ready. For
type-2 and type-3 which implements regloc=3, the check can continue.

I think SFC can use this as well, because according to the spec 8.1.3.8
DVSEC CXL Range Registers:

"The DVSEC CXL Range 1 register set must be implemented if
Mem_Capable=1 in the DVSEC CXL Capability register. The DVSEC CXL Range
2 register set must be implemented if (Mem_Capable=1 and HDM_Count=10b
in the DVSEC CXL Capability register)."

So SFC should have this. With the change above maybe you don't need
set_media_ready stuff in the later patch. Just simply call
cxl_await_media_ready(), everything should be fine then.

Thanks,
Zhi.

> 
> > According to the spec paste above, the device that has regloc block
> > id=3 needs to have device status and mailbox.
> >
> > Curious, does the SFC device have to implement the mailbox in this
> > case for spec compliance?
> 
> 
> I think It should, but no status register either in our case.
> 
> 
> > Previously, I always think that "CXL Memory Device" == "CXL Type-3
> > device" in the CXL spec.
> >
> > Now I am little bit confused if a type-2 device that supports
> > cxl.mem == "CXL Memory Device" mentioned in the spec.
> >
> > If the answer == Y, then having regloc id ==3 and mailbox turn
> > mandatory for a type-2 device that support cxl.mem for the spec
> > compliance.
> >
> > If the answer == N, then a type-2 device can use approaches other
> > than Memory Device Status Register to determine the readiness of
> > the memory?
> 
> 
> Right again. Our device is not advertised as a Memory Device but as a 
> ethernet one, so we are not implementing those mandatory ones for a 
> memory device.
> 
> Regarding the readiness of the CXL memory, I have been told this is
> so once some initial negotiation is performed (I do not know the
> details). That is the reason for setting this manually by our driver
> and the accessor added.
> 
> 
> > ZW
> >
> >> Thanks.
> >>
> >>
> 


