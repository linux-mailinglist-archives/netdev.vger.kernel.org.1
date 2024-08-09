Return-Path: <netdev+bounces-117131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3671B94CD14
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0DB212A5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6003718F2F2;
	Fri,  9 Aug 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fytRWf7q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192F18FDC9;
	Fri,  9 Aug 2024 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194874; cv=fail; b=KyCEW+hIZG2xG6m5teTnq5v9XzGd+kEKykdFFr3xSOttr5KcUTc+2We4nV8PI4laemiT1Tmn6rUHeSYjXu4ot9HukTygg/Jr4QYAtXZQJKY0EUzU9DgEjQOnuQlDVBENIhZ5/jRdObjVwKYj/DbmkJT7/qS80oef4CX20eZJyoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194874; c=relaxed/simple;
	bh=wBII8xr/tnVqryK8us/5wDDidC7mIYCp7g2pc0WfVao=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUy6eubiOgObQGVgHDnfa7gFpO9IwvYc5kUoZ+r8vk8KAm6rWuguCzUzAaNVbRVu0DqgecGPlezJ2gsKcVLdlyZ/A6G1fD47sq/hQ5J0t4E5ukKs9Vaz1VEA/JCLrUa/PpmD66iGZsRy6Bp1M+UKjkxtOZaWOJZ7zp0yaQYmsCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fytRWf7q; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwVh6IooCMSQtMNi3bbao9SL+6oS9/D7m1nUMUB6pRC8PQi1GMB+7q6Kblji0AF9GNvnuVlTtee/p7cJ+DYWYZaWSUl0Ii/GPS5H+eayokBT5d/j3Ie0UAl6WuSxVZxg3Aa0KDQviPJfBdfbjqAh3Nod606ol5Xc8Pu4k+u+TgBv/naq4RXZnZ/WJhZkj3o6KTsNb2vdb6ytV+6vN872Z7DpIYInf6SoNC9m50ovV9QO9LhjdWX/VrM22T7OUWr13t4xp0q88ZjVxiRkEo1fUIUaLa2+qm19J/lPcvUMV2uEz5IJEpHnYYdj7XJP/Lc1t+eggB82T7uiSuZozUlG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxhqqaltTpFG/fkOvgYSHkdFXV1wHTMFyWZwxKzqYB8=;
 b=VfF/oAZJEs5sdZ8wqn2UYdAxlTvzld26waF0kUTekZJaT5pvC/7PXiHDYMemX3gqoGSt3xhQNwLKIX5hElX6sHMbyr3RsFWV2GbdK1NfgpL4/4sAtPRBYN4JaoRvwW7VMgICO0N/qcdoIwD9Uk0eprsGPqUbR1bTq50PRQ+EJSmUyZoKzmCyFLd1p1TaKjbz4nMXL/LhkTGwN53vU/JqVrA3H8xafbsWiSUSLwstS69eUnZXiNVnINc8RLwJLMefI10OJf5oq1qC+r2n0AEgmy0HnaE9crCvYqn945IDqmyrWIUUQBWPt8XJGQhVCG7JF8NcghNyIj5ldx1AiMlh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxhqqaltTpFG/fkOvgYSHkdFXV1wHTMFyWZwxKzqYB8=;
 b=fytRWf7q/wW3v/V3oEGgPFJnPI9ozMRFFdDDCl/LRzJQF0aPU68qvUd/0zE74eYIBPq+KFu6/xfxsFfgNJCnld9XT4Sh3ezFi/WUltSnSicRDMWxx8E6kl2vxHBN0OMx/cJ2qJzaBrkfldM0ttG50yet3ta/ymMxvYHiTH3FJWSkeEc8z+fGRIXM2CAHN9ywlwLOxNkVzc7VJFkkUguRIMevzWwLObA7N3vtPy9mK8bimV0zJ+ANiJsH6h4KfinU21isTLaqnO9QR8VnCIIS20fuoP+q+T7C1UtGgEn45xdLDF7lS1BMSoy5GQyY086wWRpumTvltY4MWEfq0JeQ+Q==
Received: from BN0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:408:e4::28)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 09:14:29 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::46) by BN0PR02CA0023.outlook.office365.com
 (2603:10b6:408:e4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Fri, 9 Aug 2024 09:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 9 Aug 2024 09:14:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 02:14:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 02:14:13 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 9 Aug 2024
 02:14:10 -0700
Date: Fri, 9 Aug 2024 12:14:10 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, <targupta@nvidia.com>
Subject: Re: [PATCH v2 05/15] cxl: fix use of resource_contains
Message-ID: <20240809121410.0000061d.zhiw@nvidia.com>
In-Reply-To: <20240715172835.24757-6-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-6-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e21fce-1401-4194-3237-08dcb853ac64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xLMYv30KsiBWjC1NN+lJ2WWZCFu/a22VUKkCGQ2JPcZWgcdwSTLxIIxUPY0W?=
 =?us-ascii?Q?8Sa8lPZ4fhh/6wT3Od9sVthkBOPLPiq2ju8LlaWBA6hgteEB/xx96kQo0BwT?=
 =?us-ascii?Q?BJl3qukhyMUD0gexrd9SV2nXNLBEQ66HLgEqigvw13lZu9Vp8zOkka4bZfuF?=
 =?us-ascii?Q?Q7TQLdjwI/HhEVseiKDg+AKZ4RAF+Y0xZF0eC3pgVtN6VH5Nnx/FMgQ22tsL?=
 =?us-ascii?Q?J254tAYAjgIcYvDnP++Khc/SLqCESNHjubty/2qGJ0mFbQM4CSYwA8p+/IXX?=
 =?us-ascii?Q?eLP/0o4hSY3jpdc3uyLFeltDyHRznzsFk43qUfj566UBo3GvpwU3g24zwfn5?=
 =?us-ascii?Q?ekKXpdYTwWV62RTLqYTHHEOap4R7olLg0EpW3J8f0E9eyIzIW1pYMOc++aJM?=
 =?us-ascii?Q?yctldnOglBUNG0PJKs60MEZ7M/ocXWBaE8EwlVNCBxTDfFOTK/m3kzo0ZiLi?=
 =?us-ascii?Q?/x7kczliNp/z1J52BFnkz1dvELZyXi3Vjxpt+WpDp1JXwnhr/zSVO+g1HjRT?=
 =?us-ascii?Q?duRy7hXse7EXZ4eb/jFalQzSlnMwW1laqbySG/U35LM0AtYJVv92GSBpDqUb?=
 =?us-ascii?Q?a8aro85rTO0sg+nzGITQ9ylDkW7dyVsPhHo8fDloTFEWBYnxrRd+y4I5lB0f?=
 =?us-ascii?Q?YK7ulCRthxb7ULJPYhj+R6vxID/Jr7QB9t1qJrObRISejTvyH9Nzrnhqvy+N?=
 =?us-ascii?Q?F6MhFaobZw0mfGAYLXBc1i/PSptBRGLugJcT0ZAYM2vRcjEBrb/tLYH2vrWN?=
 =?us-ascii?Q?yI9ul8sSxzQQjQx7a7dmLIa/3fuEqtIHJK+4L99VvmtxOXqE9ojP+o4/HxnG?=
 =?us-ascii?Q?sDe/kHKwY/C4FeFGpq1gYCHLAIjf4tIZQ96xGWNlainNW8ecjNu20V7Onr32?=
 =?us-ascii?Q?nNwZ7uPDkamwxwAy4vegt1SCGg1E4gD/ljA134SLVwB96fBn3nMzPJ5cPRV2?=
 =?us-ascii?Q?XRZtird9WgryJiWBtIzVm8qEDOrnFBLXF1GaKy6+SShEHIhhyRdCDzcu6wxe?=
 =?us-ascii?Q?KQg4LRBPXVQhQ703j4qL+VUrIg+gFnkyZjbrALu+HekvrIltJTTkhWnNMB12?=
 =?us-ascii?Q?+Ey/2C1Hy9COozQ1M6uKmIcGAWhgjgAp8WQD8J0dT2LLIXvu4E99gDwOu+AZ?=
 =?us-ascii?Q?MkCb6YKfcuI7jf9StSy68AWejtOrsZ6bYpbyDyKyFfSo4cy6BQSDXnaBOerj?=
 =?us-ascii?Q?w1V9l10FR1ANyYz8Jlc+EmapXiL81W3U3I9e14ZROeFg95R8C50GvxMVpMaL?=
 =?us-ascii?Q?M2vA3CnPc2dg3ZNoWxYOiJqAp15f6+5Kgt96T0IJSTl3FlFNdj2xz+brWY0T?=
 =?us-ascii?Q?6WxdiEK/LsC0D9IRcllO/rCcBKLj7rSKekoYEWfzArzIhPzkrTx1CgXz0Duo?=
 =?us-ascii?Q?VJpnDl+VxU1X0C7GLvbhhTnYFTlT7OvuEotVfZ5WAW2JJN/KBfJFYQroBCa3?=
 =?us-ascii?Q?cHdk3YZUeNzPsl4rvUuoFZMgbm3Z9lUI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:14:29.1780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e21fce-1401-4194-3237-08dcb853ac64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779

On Mon, 15 Jul 2024 18:28:25 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> For a resource defined with size zero, resource contains will also
> return true.
> 
> Add resource size check before using it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3df10517a327..4af9225d4b59 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct
> cxl_endpoint_decoder *cxled, cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> -	if (resource_contains(&cxlds->pmem_res, res))
> +	if ((resource_size(&cxlds->pmem_res)) &&
> (resource_contains(&cxlds->pmem_res, res))) {
> +		printk("%s: resource_contains CXL_DECODER_PMEM\n",
> __func__); cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	} else if ((resource_size(&cxlds->ram_res)) &&
> (resource_contains(&cxlds->ram_res, res))) {
> +		printk("%s: resource_contains CXL_DECODER_RAM\n",
> __func__); cxled->mode = CXL_DECODER_RAM;
> +	}
>  	else {
>  		dev_warn(dev, "decoder%d.%d: %pr mixed mode not
> supported\n", port->id, cxled->cxld.id, cxled->dpa_res);

Also, please clean up your printks before sending them to stable.

