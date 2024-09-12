Return-Path: <netdev+bounces-127749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D615F976533
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB5F282D74
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD219048D;
	Thu, 12 Sep 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iMIcNEfY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E527189F2D;
	Thu, 12 Sep 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132129; cv=fail; b=UhYjlxtUjQ8+7jhhMT8KL3SgMUVQQxARilwZM1qouYeQaCW04vCjbb3amE9xBv+YzU/1kFyQJk2q40ukpTlpipCcs0VhJ5l0/kS0ACuJg1P8CRFy877r3qB8+dN372Y1k0hJfuqf1EkTcUKaA8dGL/1RqUFhBfo05aNHjRL0eWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132129; c=relaxed/simple;
	bh=X00i05Du1zu7rsUokk0+W7XaO8WWGExs/FSRWDuVp1o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/YlaRu6gOCqqft9zEjMhBeqAhOFrUQEMSDd7lJpOGmEsClfgFC9JNuZ3q3MuriHUnS8m2g0BO6tBiCmobio0XFmqi2BJRj9uOxMC8JqTX1g8ICMsOwQF4Hj7jXJkwAG0JtYtg6PC/bkNeo5Jp8OKFvTeR3spdyrgQ3mT1mxE2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iMIcNEfY; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5K0ReU0QVpr425wjyyQb5CCqjcJ21+rsixUZYSyNBdzsj6nCui/FZD2zdE8DCYTGx7mw3aYG42ZcatfVK5RLOpq7X+nBQTg1FD7Mg1EC2Adq9UHCaq6UBxmSxpWVcJ0QL+Sb6uVpitcmv1MejUkyi/ndnsBz/bLVYlOFxuEad3CC1Uiz4tCG82YXSRL7I70w9xiJ9TyQOkSZrjABweJUKT9siTNcE9+3EUGUu1hSAkJMkfmH4gyBW5AsBU8gnOTUytD0XOspwDSr+kIiGguB8MLb2hvnfDb7bPNEic75qVjOc6lrUsIxWNXMCRY7kteTwS/bmC3D7ySAGjDOWBALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBzTeVTio2cFqfNpVr0Ed4RusBIo4mzxdsDHlAmUnrQ=;
 b=yFBd2++tdZOn+9gOkvvZ4t7jqxGtocrNFiBqjTCZ42dDcu2aEs/G5iDt6s50SwDskl4lUbWAENJkt2DF8EIeehjniY+gCmZhP7oGBgWpahC2EY+wfqQEKf0Ue88ryEGGi44DT1OmdHHtAboFkP4fGRuZT1jFmFJXc4mhas0gJKq0Phxb72HriuSVoWYzwfN7V9/K7UCthQRq9hcrQQQ+vUdC93QLccYByWW0+YqGjt5N1qI9QpPTYQQSeCv5xqdczoBYpiESQjtPm5Mc4a26HbbFt90Nedjf9V837CExKNjibFJKQwvhO/lqLUZfodHJxCJbB9zD5u+npQCcAOWmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBzTeVTio2cFqfNpVr0Ed4RusBIo4mzxdsDHlAmUnrQ=;
 b=iMIcNEfYf3vWwXkzdK0D6ggfrtVoi75BWR3xIyKtYudyx+3Clw5bdU/J01c7iH27WoDf/XyS1xNiiuTyWf/nCJCQUj8y1JLuTQh6MAuooSygGigm7zOG1cS1/fUtBs+gFLo7q9+zIHb7EHGIYiz8OY7z0MeXrqLnQ1UrBNnZ7s8+NeGqiyUCvhEGnMoQfp+o/2L2dSRQktOh+wQ2dGqroGSeZiAKaXRTAcgHfSzbfaehyK13Qsj8i3j/aDd9359d6qxX7Zf+2eVc/vBEtmDxlRIrP5jy4rq95dZaaa4C9wVFU7txdEjsljz/yo4UnyerpFr+sLILZt0s+OsmkZA6Uw==
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 09:08:43 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::1c) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 09:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 09:08:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Sep
 2024 02:08:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Sep 2024 02:08:41 -0700
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 12 Sep
 2024 02:08:38 -0700
Date: Thu, 12 Sep 2024 12:08:36 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: "Li, Ming4" <ming4.li@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
Subject: Re: [PATCH v3 05/20] cxl: add function for type2 cxl regs setup
Message-ID: <20240912120836.00003674.zhiw@nvidia.com>
In-Reply-To: <d33cfda4-2557-fd94-dda6-5265e71ec2e3@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-6-alejandro.lucero-palau@amd.com>
	<68878cc6-addd-47a8-b6c7-9baa141a8b86@intel.com>
	<d33cfda4-2557-fd94-dda6-5265e71ec2e3@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df52340-02a2-499d-98d8-08dcd30a7ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xeY8N2mclCutYbz6hV4lHJeyO1g2KZXr0oQuIIPF+QStsUnBQjhZIrFNh8NX?=
 =?us-ascii?Q?vgHF0p0XoH9A2KQL5CegpL5+2AbKhZqKQxDV9EfBXl5SLmJwXzy9EwTSiNrU?=
 =?us-ascii?Q?iq39ULRjY+ZDyG4fBsUc0bsnrsT3MaXeEiIivzPCMgG4wX70usbwXjm0jBz3?=
 =?us-ascii?Q?RcTpimpjAaIkF18aLEcpwiht/noh9QDbbYHwPn28eodzKPGPZ9iXX/4IvRhd?=
 =?us-ascii?Q?mDcH8OuBYu5v4ZrTwfo5wIBfEp9RHtvEbGjA4E2P2qJEHrenxHDsKEf4FStf?=
 =?us-ascii?Q?6SpatRQllCRyWR4qXPZRbZKPcK7NALwNGHyJvI1yU9pzpUFMX/82FWIHfE5a?=
 =?us-ascii?Q?oFQDZlYZLzLZqUyFkjvoohAkGX/PM1vCnglbOPMji9mCQ4dO4QGQLe8NRi0E?=
 =?us-ascii?Q?w/0jTJUPBcCj0n/IElmIh7jRgdbdUnsfAOHvTSXaEp9+LFN1OzYdpEIiKRuI?=
 =?us-ascii?Q?fzdD/ShovW57cnFdUZgMgQKKPi4p8BOSxsBlnXQlNEbQhU6RaqxEIMkauSuo?=
 =?us-ascii?Q?YVqAZIW33+hZaCnGb2igZgR//e0iSF0TpntC1yGEtYF08JmV+QRXXI4eKV7z?=
 =?us-ascii?Q?Ut7oyyDkCtozwbKGrbw5y+mvU8yEnoocZu/MS0Y9lQI1MR+Z4jtEQ1ciMHqE?=
 =?us-ascii?Q?BfKGfsImlZNkhiIV53jXKEDys1Gt5OcEYjoQznUNyKB/bJZEJ5TIGEYtpiJH?=
 =?us-ascii?Q?tDgrB3zeQFc1NXPNYezZ8YDDt101Cw+ggiNK6pPTycNFDUbmE/tALqvc2Kmn?=
 =?us-ascii?Q?+pV5hVROvvwCUApwT2g7wkycSAzCdv94VH38aLtGKfU4rpwDbzE/iPhy7+1b?=
 =?us-ascii?Q?iKmO1fMSX3jj7nvaRs9jUaRdlWkcj0PQikjQr18nnWIa6+1D4uesqkReSDf9?=
 =?us-ascii?Q?Hp2DeB5ch7OxIdxFPUWxL5qVdm1i8eB7JwjjrXLyUleWknWONb+tcT657+rG?=
 =?us-ascii?Q?puk043rmCtRWAw8wO18Hw8CR8bdJle6SBXM2aK5elqvjw4As1MRJ3KkTMnN9?=
 =?us-ascii?Q?A/hTWFTsY1nvE22qkw0k1sCGAxEinRLoGhVsUiC0NZy5NufSzl3fy1WzGsBy?=
 =?us-ascii?Q?2sSvftdZlddbBsw01GzuJTNHr/5leKGYSClQqg5AbkVAi7aTg2++jGK5JMg6?=
 =?us-ascii?Q?+BcEH+kYtwM0i8tZ/uTb4qXSv8dwI/sYdA9foP3SDa+Ixsp4oLlmqKtOneFQ?=
 =?us-ascii?Q?2VpTF17lFzD6w72V3MFWFA6cCF6TxB3Ik1Ta6gxo2g9mGL9H1NoYMZrAFOnN?=
 =?us-ascii?Q?IwGo8hqas/xBbYtBIAHI/kHgunuSTOh6YZTyqDjW1TCXeBNVjJZxkeNVoe7P?=
 =?us-ascii?Q?yBr0unnRWrpaQRDMoM1s+y0Ic6yV46BpmpTxvg1OIHvk3ScRYRXZROTo7JcB?=
 =?us-ascii?Q?ykGDjCcyj4lc5qS9MxmJUNSO5MvqsaSG0mLVg1N/rPB8xWhR+Z4wefqjs4d3?=
 =?us-ascii?Q?m4kgwpyyKsu9vT1Lnk0k3b+IXy6L4+mM?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 09:08:42.9315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df52340-02a2-499d-98d8-08dcd30a7ffb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

On Tue, 10 Sep 2024 08:24:33 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> 
> On 9/10/24 07:00, Li, Ming4 wrote:
> > On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Create a new function for a type2 device initialising
> >> cxl_dev_state struct regarding cxl regs setup and mapping.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> ---
> >>   drivers/cxl/core/pci.c             | 30
> >> ++++++++++++++++++++++++++++++ drivers/net/ethernet/sfc/efx_cxl.c
> >> |  6 ++++++ include/linux/cxl/cxl.h            |  2 ++
> >>   3 files changed, 38 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index bf57f081ef8f..9afcdd643866 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -1142,6 +1142,36 @@ int cxl_pci_setup_regs(struct pci_dev
> >> *pdev, enum cxl_regloc_type type, }
> >>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
> >>   
> >> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct
> >> cxl_dev_state *cxlds) +{
> >> +	struct cxl_register_map map;
> >> +	int rc;
> >> +
> >> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> >> +				&cxlds->capabilities);
> >> +	if (!rc) {
> >> +		rc = cxl_map_device_regs(&map,
> >> &cxlds->regs.device_regs);
> >> +		if (rc)
> >> +			return rc;
> >> +	}
> >> +
> >> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> >> +				&cxlds->reg_map,
> >> &cxlds->capabilities);
> >> +	if (rc)
> >> +		dev_warn(&pdev->dev, "No component registers
> >> (%d)\n", rc); +
> >> +	if (cxlds->capabilities & BIT(CXL_CM_CAP_CAP_ID_RAS)) {
> >> +		rc = cxl_map_component_regs(&cxlds->reg_map,
> >> +
> >> &cxlds->regs.component,
> >> +
> >> BIT(CXL_CM_CAP_CAP_ID_RAS));
> >> +		if (rc)
> >> +			dev_dbg(&pdev->dev, "Failed to map RAS
> >> capability.\n");
> >> +	}
> >> +
> >> +	return rc;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
> >> +
> > I thought this function should be implemented in efx driver, just
> > like what cxl_pci driver does, because I think it is not a generic
> > setup flow for all CXL type-2 devices.
> >
> 
> The idea here is to have a single function for discovering the 
> registers, both Device and Component registers. If an accel has not
> all of them, as in the sfc case, not a problem with the last changes
> added.
> 
> Keeping with the idea of avoiding an accel driver to manipulate 
> cxl_dev_state, this accessor is created.
>

Agree. Let's keep this function.
 
> 
> >>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32
> >> expected_caps, u32 *current_caps)
> >>   {
> >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> >> b/drivers/net/ethernet/sfc/efx_cxl.c index
> >> bba36cbbab22..fee143e94c1f 100644 ---
> >> a/drivers/net/ethernet/sfc/efx_cxl.c +++
> >> b/drivers/net/ethernet/sfc/efx_cxl.c @@ -66,6 +66,12 @@ int
> >> efx_cxl_init(struct efx_nic *efx) goto err;
> >>   	}
> >>   
> >> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
> >> +	if (rc) {
> >> +		pci_err(pci_dev, "CXL accel setup regs failed");
> >> +		goto err;
> >> +	}
> >> +
> >>   	return 0;
> >>   err:
> >>   	kfree(cxl->cxlds);
> >> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> >> index 4a57bf60403d..f2dcba6cdc22 100644
> >> --- a/include/linux/cxl/cxl.h
> >> +++ b/include/linux/cxl/cxl.h
> >> @@ -5,6 +5,7 @@
> >>   #define __CXL_H
> >>   
> >>   #include <linux/device.h>
> >> +#include <linux/pci.h>
> >>   
> >>   enum cxl_resource {
> >>   	CXL_ACCEL_RES_DPA,
> >> @@ -50,4 +51,5 @@ int cxl_set_resource(struct cxl_dev_state
> >> *cxlds, struct resource res, enum cxl_resource);
> >>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32
> >> expected_caps, u32 *current_caps);
> >> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct
> >> cxl_dev_state *cxlds); #endif
> >
> 


