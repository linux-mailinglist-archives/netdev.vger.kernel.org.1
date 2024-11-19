Return-Path: <netdev+bounces-146337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6559D2F1C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C246B282E92
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDEF1D1E63;
	Tue, 19 Nov 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kt27Pn3g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D01D0F56;
	Tue, 19 Nov 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045873; cv=fail; b=jbBzo7H+0hzqNZaKBLhKQLJ8WxC+CrrmFZFlgTAWK2pKq6DRokhQTPftYkE9WkAXKH1q1lTDUeTCrAAPYbhS6EBS5eFKFxcTzecoEXas64WH58KCjFHRh9Lp6T0d6ZbFOmaZWcGFICvtGmDkLTUnWvatuKhOfLBD/g0QPmI/VLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045873; c=relaxed/simple;
	bh=bPf0p+G/NivPwy7Y5eUpvd+hGO/m4aCd2ufHGMmROtY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPU4/9aksFzr8AOWjtPjdscppqe3yYAlyoLz1DAmH6EHR0Y7NHvCWRH7kcz11Fwi43dxpDrxwE/ZWFWvYlQKlh4ZOm+o+U0cKRwHl8zkv3KP5n1aTHbp3FC/M5rlBnkw6H2tX4cg83PfW/BHOrhxyhuMv6WW7R341sBmUYVhX0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kt27Pn3g; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbxMHOClEXeGT8YF7H8yuYEQSqopvlFcXEvhZz2MKZy2fB8qIh6NVBj67/gw517RqQq7jfQ6xcdGd4jDSSBsWp6CrJQqyWq4cH/lOjc1lLp3k4o99YOML33+cfqB29QQ+hiv7/hfZZOtBV28dal696S+sQmnIEvAh7lhM/4x0kI8LNCahx8HHi4/gem/igNP7ePLLMhxfBlHIhZs+AOKuyjQj+4CDoP825724Nh+md6KvT7am35hsOaV3KI7BHD2FXsss8kdJ6ykDKOFKIMWCoIM//anfh3fPj0ShMcHMOotkzN9O/CCCH9qfTjvOz/uHKLS/Be528P2fUkT1LGKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tScUe3170jh51LTgNF5FfxOxNR09u53QRQfLVrF87lM=;
 b=K8ApDcuXoYDTbngvFXHg0w6syGf31wqsVAFpXC5uI/4HDNzE7gjhK1dU0nOt5jw1Txz5iudQy3kzTr/aOizVtUzG8I5WjG4CDgzNOhclrZUogdsJ6xAFeElFTl4ER7SIuJwezdtet9UemigpoLUhYFi1GM68tdLpWdxMw4FbZy6Amy14Wn5nov6i2LXh3dWxYBfK5D8MU175Mo5e0afl36V2dtoGHHZ1Wj2jsUBxl4DqIc+xyiJze8DdkRVsCzHkcFwdi0WmmSXjqCy9dYMu4h6mf6HdBsgjR0y9UzmhknWVuimHWYxXW6AhtqwbOHWTz1WHbxTL2TnmO3b8Zp33cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tScUe3170jh51LTgNF5FfxOxNR09u53QRQfLVrF87lM=;
 b=Kt27Pn3gBNsl2ZSOibeTVX0FG+R/WDWtaOhnv1xW3ushEwfcq6E9OSk0OgDzWMVWhmQu1AB8IWWjPSSUQ4SwedIYtcTAtTsT7bE/nN/XzgjiJmdLdHbW8x4s2x1xecGKeEC62/DgJ5IBktvOoo1MkF1Dhi+DwbrWGJttwRQOS7EBXtbN4MtfSWYrSSHCqzVP0zboxZoKOzZAEyGJr9UYirXU0hzoIDxBRdDW5yfKpM8yIeRx3u7lX+BUb8+/qtxPMmrFL7IiwYdwMDmH9OyyMIfGBgBRQMOeGBeo7FmvJ39l+nPfyPkJ/OSBf/L0RmCWK8Sk6j/SBSCdZ5tc4ZpLjg==
Received: from SA9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::20)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 19:51:07 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::cb) by SA9P223CA0015.outlook.office365.com
 (2603:10b6:806:26::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 19:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 19:51:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 11:50:46 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 11:50:45 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 19 Nov 2024
 11:50:42 -0800
Date: Tue, 19 Nov 2024 21:50:42 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v5 10/27] cxl: harden resource_contains checks to handle
 zero size resources
Message-ID: <20241119215042.0000617b@nvidia.com>
In-Reply-To: <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-11-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 183f3c0d-2384-4e5b-5510-08dd08d3821f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YHR17Dr6TEp6uqK/xDiu6CPlSdx6dLYF74QW+HSJ3whkJCtApeQJnWIltJZV?=
 =?us-ascii?Q?IFwDKFZDV+gdRvicITkVl61WC4x2bT+dbiJbdJ2DzFts3C4bU557QC6iUn8p?=
 =?us-ascii?Q?9ObJ2pBCkvUdiJGeDqF2S+K2dOW5Ht1s9kCOTQyJOXmgcbptigfx5Fl52k3/?=
 =?us-ascii?Q?C+gMCS8dZrfWdiHF9GmIE7XfPhbPGBsfArhp02Y52fD+0FXsFNY+r7UEza7t?=
 =?us-ascii?Q?lt6efb0lwEXGH+ULrCrD1CFfTakd4nyul+6rEOEXekSW1LOlqcdHVPUdwT+f?=
 =?us-ascii?Q?QC6pBwwWh573VJRjJT0MBa/qvmWdLUOKOwlUm5jf19d3N9VQkmJEiT+lTgsI?=
 =?us-ascii?Q?tLoApx5Rl2aAgfc+t/QLsIR2yAdFaq/DeHJufqPzuR/SbDfKNCcI4Rs3TDf0?=
 =?us-ascii?Q?+9sUg6sIxXzq0T/gzSZJoNYmY94NEogruyWgIe02vgG3fnputyVVN2s2p53a?=
 =?us-ascii?Q?VuLHO3xwJ92PPnOreSNcD08/W7MlsoSqH1n3363OnvlOhz0lQ+r1Ww7ocdbl?=
 =?us-ascii?Q?69VO5BLzzNuhXfym81gjLtKX6wScOV9ich9UIo2yzf6+CB+yINI6S+DYZp7V?=
 =?us-ascii?Q?xipianGSXLdgB6LyxNsKSHuhC5I2Q1nqj/yejBli5HvgsoHjPz9xrr3cwFWH?=
 =?us-ascii?Q?e5rOW6dUBhzyC+sdoYeyB1DcuCzQiCtLIo0sGj0V7ySr68jkHx2lY4j1ubUM?=
 =?us-ascii?Q?1slgpI1Ce+Pm7/QEUZ1RzEsClnv6bWJ4OGcy6TOQc5A2KMPuRQ/J/ExFT/Cd?=
 =?us-ascii?Q?bk/gmJ5p2DSlLQaxpF1kNQLn/hDLj5hHpd5lvixFlBaCUWvv61l0tmO9TKd4?=
 =?us-ascii?Q?hpVyevh6CAPt9X7Murk/6YEbEChu7bVroEp6NRsGDE0XKThYoBj3kmBTaQOw?=
 =?us-ascii?Q?CeK71KmDgKcrk08gdOLOmx9KibGBKYKInoli3Jpw9iGmyiYjZ24+nSYGaQoF?=
 =?us-ascii?Q?oPpRFBaY+GlIBZbuemW0Lorm8XAn6TWE1Tq6Plp00X3F1bnykDsbxFi74FVY?=
 =?us-ascii?Q?EJW2QmL8r6vJL2cXVS1NnfLZL7OVSgSVJicuBkyvRHcJm2v8QGyWXAU9NNYK?=
 =?us-ascii?Q?KoieAZCkhVZJ6mKEbMaH6VdHRWI006faVEcWmjEA6Ygj8/la3vNDwyPIA9Wz?=
 =?us-ascii?Q?7z2SsDfTWVSLeAFwfBIL0rwTomLNDTvIypFR1xwC21HOHPH/4d4URLh164JH?=
 =?us-ascii?Q?V0CMkF7gKLpq7rM1dcXE99NyTQufUywqWMLm53EPifhUeIDVMmFteLk6R9pd?=
 =?us-ascii?Q?7yC2cTV/6fcDHZUBWQVXWPtqufGK7EATFpD2WhKVd7CA6x1ZClPNUtOcjQT2?=
 =?us-ascii?Q?L/AOXpItFA7Bq1l7cxOtSe34X19lzHPG9wZWfhHt0U9cURnLKgPNZe1d0Qxp?=
 =?us-ascii?Q?Q5Z2de7CIFXpNNuNutV+cOkT1aQjsWCToe8T7QxGiovZeB/xQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:51:06.9285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183f3c0d-2384-4e5b-5510-08dd08d3821f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141

On Mon, 18 Nov 2024 16:44:17 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> For a resource defined with size zero, resource_contains returns
> always true.
> 
> Add resource size check before using it.
> 

Does this trigger a bug? Looks like this should be with a Fixes: tag?

Z.

> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 223c273c0cd1..c58d6b8f9b58 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct
> cxl_endpoint_decoder *cxled, cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> -	if (resource_contains(&cxlds->pmem_res, res))
> +	if (resource_size(&cxlds->pmem_res) &&
> +	    resource_contains(&cxlds->pmem_res, res)) {
>  		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	} else if (resource_size(&cxlds->ram_res) &&
> +		   resource_contains(&cxlds->ram_res, res)) {
>  		cxled->mode = CXL_DECODER_RAM;
> +	}
>  	else {
>  		dev_warn(dev, "decoder%d.%d: %pr mixed mode not
> supported\n", port->id, cxled->cxld.id, cxled->dpa_res);


