Return-Path: <netdev+bounces-146348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B49D2FB8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 21:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC4BB2A8D9
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9421D1305;
	Tue, 19 Nov 2024 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MteUbpLW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B61CBA1A;
	Tue, 19 Nov 2024 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048837; cv=fail; b=E/sROqM7cfNbu4cXpIuZbotHvTDM3tyZiZYEHLyXo35ERZZA3IHI+3axXlQnYLna/1laoranViXVYP6qsHe2hzPXR1sL3rrWz0CgIHTe7EbRCKcu1zNgvLfsfhsLMxewuOE1mnNAIRhIONDDuwPOvrNLBi4ejC1SOl3iVo6oaDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048837; c=relaxed/simple;
	bh=w8V4QhtEWFpHvUIK0/v9LJdl/EJCfeZjwR/xJyjvhIM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZb8CUNsqOws0V6yEx3hotsfOKWsqWOG6irgdXSq5Zt1wiKKfaNFziFFad+L8rMIgMw5tJUl1Exx4WtUwqd/atDjw8w/wzRpoXFI6ROFDZ2mJPI7NE/s4cT0GvXMpNjWXDsKUEfTeiCZJvyjs7S7Mc5vVoi0VUN2ja7gl0aGNPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MteUbpLW; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oT3ZYKAQ6srjFvBHy7g/wufzHY1KG+zT9TYoSOgaTZdrYpevY9DFyH8TExf6uLJFEBrz+nQDvgl+WSfFe9bwU42f/K9zcXgFGQTY8TV0szEaZZlue3Yc4QlYpxrHshWm/LFa9X+xLM4tam94EIRKPzqQhzDtWw/dYwyySuYdPgufjcJw2cjv+a65ghnPbuknk1cRHCOYLr1ZvSK95GRKk01TcHb9RnSnlq+DEbWlk0h5oPzW5/aWX8Ii6U3VzbnQ3ixxdfY7EiE90ysCPgHT2N+77t5oSMghdBy83SXIjNimjR/Oe6OmJC1ZLcW9b1NX+JBEJpjyccb8QbWNXV8CBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TZu2WfEMr46tfKIkxqiO5bi3QMg6H7A+V9uPMyRQ3Y=;
 b=e22gwNVLMPrpvLYx19w5ZmzUOxedf5yF3lf4y/qhXS+ug4NHjqulTutMr5P6CkiLeo4sttlBGKX1SfDAuQCv/IHys3o3DKZIgQpdbIRfmyddei5KY5O2ByUzMNUjWrzCmYmaPeGFzF0ZC6ljY5seyQdin2wb/W1eHyikt941JtYqcVdlRgBzeyvyLqMd0Ra0etiULPoYxn/5x8wlxReajnnSZfpTGoOhQnoQ5Z7iPBpVVwCidJFaKsvOuFDZyJ0iLoSJGHTXCvNbtAndsl6xX+I5KcKhbCl/gUVCI7xjs4wE2KE5aAvYadfD1Md9z/73tkluWZsZqqB09eMhJw78vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TZu2WfEMr46tfKIkxqiO5bi3QMg6H7A+V9uPMyRQ3Y=;
 b=MteUbpLW9uVWKfOtiuPZQ2tspzPNxtguHrr/t5XsC7IrRMokeX0ztBadTSEFQ5bwX0OhF44U/vtwjKmxBMBU91GwbfYZZXvgpBSPzZDva1NvaFwld5pP8KRIuBE8J/JGQ49NEkokNhR22hWH80yIUN2uejJkELx/rZfXHmEGP4ztowUikmUYTQ4JA6sP1T0hYDlbKoZBrr9TcNZGWaPHK22Dui/EBeY7hHZRF6nFBeuVyvELFNZJQluqUKxEhd7tcRM0HV2WsJCmG/fnX+ozAjK0tPie8CVj7iItHCwcCVeM8RbrEw1R5PHk+rLEW8JV8HWnMhfdSh4Al8ZMXzKgzg==
Received: from SN6PR04CA0093.namprd04.prod.outlook.com (2603:10b6:805:f2::34)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 20:40:32 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::81) by SN6PR04CA0093.outlook.office365.com
 (2603:10b6:805:f2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 20:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 20:40:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:40:21 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:40:20 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 19 Nov 2024
 12:40:18 -0800
Date: Tue, 19 Nov 2024 22:40:18 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v5 26/27] cxl: add function for obtaining params from a
 region
Message-ID: <20241119224018.00005f7d@nvidia.com>
In-Reply-To: <20241118164434.7551-27-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-27-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: ca083f30-c737-47e3-d380-08dd08da6951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYoMJyA5HDis2i91J6nAOpInwgAJogeZSNWLHy3w6BkguKPM+hmXWQFmjSyw?=
 =?us-ascii?Q?x01mKPJPYnUa9G3ZZX1TNmKWxaXw0oZu/VxP3jWz9WdE4vu6+EaEFUgps/Z6?=
 =?us-ascii?Q?bodRNPgfzs48oIjIjwjdPzirfFGlJDBBZ61/Ewb66CIniv8oeiv3iYU2t/ih?=
 =?us-ascii?Q?jl+jb/PXxtFMIV1Tl9Hil1JTqathfvxE+GyfRDyKfvyjU7vz3mDkn2XbQXfd?=
 =?us-ascii?Q?QPTwcd1u1vlQlni3zHkF4L4YGv3CW5NFvFk3G3YEKBF08aBUogMV1U9IJ4DZ?=
 =?us-ascii?Q?ZKrVkZEn5mH2Ivt+o2fzxCZOe+hiS17xdR2O3twZYha/VcdIxlL9nIPyTZp2?=
 =?us-ascii?Q?iMFzeD1Kvp/u53x7BPvl344lfpHEGDmxd7blVvK80tiXYJ8nRpeMgIBB02mv?=
 =?us-ascii?Q?6LMEK6q1+DsMFn748tjcVtbnF3z0UMklfW+iK7swSKDZJ8x8xCb6YvnEPXen?=
 =?us-ascii?Q?+QuNaLX7hf0gcdQMczJAeHYMfylhYn7C40Bt9XCVsxTWKsD4B+U6NPreJ7aJ?=
 =?us-ascii?Q?gyYEnmHzoh9Z9du1t52F/qYvgxjp5UXsSJZ0KtYIzoj6B38EDGm5XdgH4Syb?=
 =?us-ascii?Q?5AT8udeXLEMQFjcAKkN5BiE4Eqm4MpSmT0EStdd/zcb39gm2bfcXbKttwD9d?=
 =?us-ascii?Q?GVvj5TE/4nSfQmRNyXuuGd5igNlHhV9g/kHVIpzjKqthQUgZZn/k07Iy8oF3?=
 =?us-ascii?Q?UdXK0x+SFXshzzxdPJD1ViaqD6cpw3JT7M5y01JMV/fA68/OJ8wy6/nXQMKV?=
 =?us-ascii?Q?Aliftf4OB54LKyfc9fgk6sLokoBdBHkNQQlE4X4KGUmYFvc7YT9KtqYqU7yK?=
 =?us-ascii?Q?YSdFYKVzY93o3EuU5Cj/M12xZmqUZXjRIb83cXKOLkqR1h5KdWWQDuvDQUUS?=
 =?us-ascii?Q?M3Es0hG06bngsKCo6PTY4wzcR9PmnDBE5JXMfCC/EHyW99fI8FzZ5a+aMVec?=
 =?us-ascii?Q?xbcqnJxwIXThkFWXpUqHMuPMmuk5LyP49pyriu6QInDRNoDpF0D4Atb4HCFc?=
 =?us-ascii?Q?Z4iGE+A7IxDEVVlpXoOuqvF8QX4m3uh8bM7PJ5s8Z/mGHk4ZgSlnsm9C+X/1?=
 =?us-ascii?Q?VhTEgBmKF0lGulX3RsFGtmyZuFAn4fCRCaIMGAk0Z8wuqZauTdKasKveb9Uz?=
 =?us-ascii?Q?RrekrTxRR8uKHK7Oxi0QujGLWY5aRHUD4/54eEkIlkmLoHAdT8wMffWoho/2?=
 =?us-ascii?Q?UatPcN18GC7Xv7FL4MgLihcXIwnEZ1SMF29Ar0hr2n/DH6JEd+FcTR7MNdLC?=
 =?us-ascii?Q?d4lQAV2K5iNNWPMcVy/TjzJfhc23YUKGdHb+x6FIicaOOgOFyyi8rs/+qRki?=
 =?us-ascii?Q?2tbidAHBls+xgvsvOk/nGyg3uCdTsyH5/PWVVRFDnHT+jESD+YHvsCfndzqN?=
 =?us-ascii?Q?dU6bTt74m8b0FnPgspLRvG0zYQ1+mRVE9FrlJHRD+vLUiiI/KA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:40:31.7778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca083f30-c737-47e3-d380-08dd08da6951
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886

On Mon, 18 Nov 2024 16:44:33 +0000
<alejandro.lucero-palau@amd.com> wrote:

LGTM. Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Add a function for given a opaque cxl region struct returns the params
> to be used for mapping such memory range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  include/cxl/cxl.h         |  2 ++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index eff3ad788077..fa44a60549f7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2663,6 +2663,22 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end)
> +{
> +	if (!region)
> +		return -ENODEV;
> +
> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	*start = region->params.res->start;
> +	*end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_params, CXL);
> +
>  static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>  {
>  	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ee3385db5663..7b46d313e581 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -913,6 +913,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end);
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 2a8ebabfc1dd..f14a3f292ad8 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -77,4 +77,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     bool avoid_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
> +			  resource_size_t *end);
>  #endif


