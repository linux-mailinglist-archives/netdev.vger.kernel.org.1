Return-Path: <netdev+bounces-148639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B2B9E2B67
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3055E2836E4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302291FDE01;
	Tue,  3 Dec 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AfWj23R0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962031F76D5;
	Tue,  3 Dec 2024 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252059; cv=fail; b=a6h2pIyrDbVXa94KMxq1VSJ3CSWl2+ybguvsOIKJz0elOrKOLLioosWFVE49xv0PENdyuAoSTvFE6s49XOLyi31O6voqvx71Y/QeyN8dtxuE+CiIezcdEqTn5bjPGrJNgRQ9O7h0INb3+tHVMcGfQ+nqqaLBj2QxgjM2lIe5FQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252059; c=relaxed/simple;
	bh=iCW5gKROvJUrtJoXXnrW5YWMPC1/53FkPi0qfSFnuFs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCp3GAp5hqeR3/GUOh0N3YFHFu9Fm90YOEh14MENgnJvbPVujZkdg+UIKzZ2oGbqkaM4LjQg8yf8z+uLbjfFq4xJSFnoqQYpJqkVvgJn5YPynFSU/EDphag7bDuNjJVcKA09gqEuiajzEHdYrXWUi/EjxqQAVtT/YX/mZp917Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AfWj23R0; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqTEY+5lsqq3cU70Fr1uOD/hPffl6V+bEXTWTU14779HymRNMwzn6QoiStVLll3K/ePYooyxxs9yBDQJ/y88NyNgotgQB0O9UUyVDesMp97pwP60E66XSdPDb7BMibftUPAzRvIQLJCnpx//o7PRP0BlNE3eO/RRovsy6/fYmsTgRdm8Q6isVfBBOHiN6QaLJ9heyAMpSx0OI4DH3WGkHU35EWlEQJHEXOesU+sbz+IxpZINrcPw0FZR9qJTnPiRWjQfU4m2NWV59T+gZ0wPr2xZHwA0s0TsA5GP8UwD7ZT3hKduFapnsZOnx/utHiMYbkQhbAoVvxd90j+DolaB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHYmcuKZPg4GFCWZr711qmTeCcYKlLe0UJz7mSRgnhE=;
 b=ExU5hLEH7+/B3P0YijCxF0pGahFgE2qCTrLtzJCNaqPyBdjRZCmY44i4u3AeMgnXNihSC/SaHycbnqx7i5n/DKZ22+camD/JdvDmlRhqH9lAXUDEzXTKp6O+Hy+uQJFi/WKhIJUv2JvpjYWGIGxxEdYkFbWHASPRfGTAkoN20Uid0MtvojrhjClFfqhC7Zzl/sWw/cekQh+gMZJ4Xxm77owTPYrr6CHrzMRH9eiMcQtslXj+RhMgCL8y32ZktfBJq7e8vaAI7oYgo2H8Js7S4z3V7XKZ4ebnfSDIXGXahh/yqdZc8erW1nsr7JdxDD4mTutVIldGviTEAmBbvDFhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHYmcuKZPg4GFCWZr711qmTeCcYKlLe0UJz7mSRgnhE=;
 b=AfWj23R0NWHTApKlokvYHmG3MZCNDfLNZSvA4pAcEVjdIZ5fW/unc8DNdm88dUFSpWabLJDY1dIm+gzCpm0uSWwNRjbeLPpIuBfZ0FQ8WCXROALjmTs8a6R37RC/KxWHGLyvJpDEVeBIxzsKDfmCmgJWxbNwMCh+WhmzhHeYUCo0AB4C/EOSRGhbg15aFf8BFYGgVeoDNV73AOCkS9mxwIhCjZqo92T5O+pvMFozxrbUvBpxtpGKaJVpomGBBqqCxl3latW25Xgs12puXzkMiLcdh3kyP+VjYtpB4LJsoOlpmbUtYYlvXjPHaRP2EL6EGHRWEDqvGehSZEjp33QnTg==
Received: from SJ0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:33a::17)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 18:54:09 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::ff) by SJ0PR03CA0012.outlook.office365.com
 (2603:10b6:a03:33a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 18:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 18:54:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 10:53:58 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 10:53:58 -0800
Received: from localhost (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec
 2024 10:53:55 -0800
Date: Tue, 3 Dec 2024 20:53:55 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>,
	"Alejandro Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v6 26/28] cxl: add function for obtaining region range
Message-ID: <20241203205355.000079a4@nvidia.com>
In-Reply-To: <20241202171222.62595-27-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
	<20241202171222.62595-27-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9d07e7-d02e-4a39-92f1-08dd13cbdedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kRDUjNi/iuDe2BuE0x4PoZEwdXxP+9N+yPeqQ8nMXl103V74U1VCR3GGCuZw?=
 =?us-ascii?Q?U0HL3HxoQN//47i19bJc4rVt51Ft0RZBH39PlL4CIIagjzAQycpewvpFYnQ6?=
 =?us-ascii?Q?xbSIXBkThlYILTjF4UpzAln4ur9kJkGHBI3IiijJPVJlMWWR3wMmxL26q8bj?=
 =?us-ascii?Q?vi3wuaYhAp+GVv5ptIOTWhkzzj2CvBzkoGbWKYi6Oh6MVeMxph1O1g7mCeV8?=
 =?us-ascii?Q?WAJtBMrTMw7994iDpbqv2PzPHMR1yFcRQHJ/6b3/h1LQD3JTUkve09AA/Y0+?=
 =?us-ascii?Q?I/Z2PXokzvox81Dvc5S5OV4XzRhb63t/Og9Z339oRORRd5XOxIe1+NNCSep3?=
 =?us-ascii?Q?ypocDNWNO8pIFMikdABBuopCkZdz9xutO9N0/qGqnVjb8DOoTiMDf2Vl+zkQ?=
 =?us-ascii?Q?iccH6FNq/g9+ug67LcChlB6F7VOwBaQy1cC7QUnXkSI9BgXGyUW9ty9MigUB?=
 =?us-ascii?Q?w5TY3UQFRkpEGKTvb/mXbHFbnQ6MYs3XtAvhlLqjYux8AqSozuswK4T/cDG8?=
 =?us-ascii?Q?AHcEfeXmObJe15zrEL8LoMyVhRDL6vFTB20JThIfnIW6RaIhy5WtTKJZPg0C?=
 =?us-ascii?Q?hB9+aCaTFsIAQFbc0XpHea6Ch8YAqS7mAZielnuG33mQ0HRTcJTm3DyoTCGc?=
 =?us-ascii?Q?KHX8T7o/Bkr43T9qC4fFBeZEqiNqWwj7UJi+MBLl2duftsqzFFo3TDCg4VYh?=
 =?us-ascii?Q?Ove8/+xWTQfb/EDwfhcDVy+rio9IIu2WqD0xh1Z2WtmwGV3JDoDslu2gGxSY?=
 =?us-ascii?Q?1CTVa9cBu/uM2KFt01lmmL250VbixF6zjycCqIP4HihMXChgMxChzjkN22FW?=
 =?us-ascii?Q?fc2c6/3+EFaP6rjotINdyctugy3pLn2KlqwPwevhTzjWShp5zCUKgXknx/ki?=
 =?us-ascii?Q?dS3GyJ+MGq9NzbalLbtWChRDTlKbcjSLvMd/zqSG2Q+tA1pZoXzBXXvPo+El?=
 =?us-ascii?Q?UDxPDM135pCA5RZ8UsDJqb841eEvfQRuBRf4so5FwF5ewDGSjoompRZHfzsU?=
 =?us-ascii?Q?IbNOhE1x4BQCFhc6jcHepGxB8EObeuPEoHGIXvl5h4KHOyJ1+YwcjxR8bUaI?=
 =?us-ascii?Q?YR6SPmyVB1ofRx4SoEm4e8ERU3X/6/4Uwn4rWWGeAJAW2YuChMlxrj+YhNUu?=
 =?us-ascii?Q?S/Qf4We/8GPmJz+EEq261HqiKryZTpEMuT+gLqo32lTZ13J/8o8Gi71h66Q9?=
 =?us-ascii?Q?Ks6O90zQ/UjbxlJu2wJanSxQVTdA4DyUSszBlYq9lDXKP5XZ6X3NEW3Citvo?=
 =?us-ascii?Q?IWCRLfN9L1BOWpMBUy0VbranKJeiUpURrv5gYr0ToZmXcweK9Wc7nZp2Qq2p?=
 =?us-ascii?Q?bgicS6YMfLRfmwVS/d8Pe7+noAfbGka3Y6WLcyYgaw6PqrEOa/uS0CsJHKXe?=
 =?us-ascii?Q?7bmUzMgqrnjD3/rJUWidVlKtg+O70ciyWbVt0WDCUu9BLKCmw3Tndtg/Crc2?=
 =?us-ascii?Q?uHiIligUs0W/hyz+QLAcCc+n2w5iFTix?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:54:09.4386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9d07e7-d02e-4a39-92f1-08dd13cbdedb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646

On Mon, 2 Dec 2024 17:12:20 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Add a function for getting the cxl region range to be used for mapping
> such memory range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 15 +++++++++++++++
>  drivers/cxl/cxl.h         |  1 +
>  include/cxl/cxl.h         |  1 +
>  3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5cb7991268ce..021e9b373cdd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2667,6 +2667,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
> +{
> +	if (!region)
> +		return -ENODEV;
> +

I am leaning towards having a WARN_ON_ONCE() above.

> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	range->start = region->params.res->start;
> +	range->end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, CXL);
> +
>  static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>  {
>  	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cc9e3d859fa6..32d2bd0520d4 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -920,6 +920,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 14be26358f9c..0ed9e32f25dd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -65,4 +65,5 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     bool no_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>  #endif


