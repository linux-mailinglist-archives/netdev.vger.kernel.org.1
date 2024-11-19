Return-Path: <netdev+bounces-146342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AB09D2F63
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 21:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583D32839D1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A61D0BA7;
	Tue, 19 Nov 2024 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZYd9bRKw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18715853A;
	Tue, 19 Nov 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047677; cv=fail; b=Akuu91Ay9WtRfQDFwb1eY/cTOX0Blm5W67TQfoCHUwGWtjyRoMGt76GUP3M8vArcpwjBy86wOaJf/r3CQcT5up+XQPtLCATujspR2r90UCgrYfbfxanuzFoM+B7WGnCIpgZV4F4RlbcA0j7eqhK3h2aEC7VJPJa1+xcK/A0yxrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047677; c=relaxed/simple;
	bh=9nYLi4oFOuvmak8JDSbRsx6Hseo72BRQz/QtJkPw58w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okd71In4WvOkSPxU2WMs3TCHXke8RxpVt3emNoNfpNCWUPDWvrior3DF8YTeWXX/K2M+YkOJPBm5C3/ZxS/2np5Qhx9KdIK3VEtdSK4Wn+e/nARmRsuQoS9cKAHZyMM243oKIEvzPAfPCouh9pze5unYJgZliZPT1Kr+MjUNTL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZYd9bRKw; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsSZgtl31E5tTZ7eJRiUO9iTcwj0YB/3Afnq/29EWPkr/thE19XXhIwZlsIxH6DB6idoIH44+agkWoI+5F2seVhJ9ZMpa5JdjBcJhB47oZYxKcNMx3tDOzrgJ3VwE+TttEyZua3itAzc88I/lR9JCbQVkPT69c7gKGkeeH/KUsezQv6r5puwumsvC40VvsyEA/AlaE+PZ0EbWTdl/y3eMqjmcrGycFqdtNeLrkSM3Fys8QdFBfZnvMBLy87afnEnraGJFAhySWmjhyh0fAmWYwL4AI+o3/r+XwMMwxgwhReu6kn2NNxeXvziXxZc674YuD9dJHQt5UMByppsDO23BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U8c9oEb7mRedkhSwO9bul/Idr7QEmAlAqRexn/CXBs=;
 b=jwBhh3IjScZRuHFIkZ3hEVFfUbym4aY54ztw5BuQJp+H9oJn9nRKhGrqiMBgXcWZ8QjyDq2r40uyZgaWMQwR8LorpghZ3LrW4DOEQV1iu5G9oRRb4g5pVNhSOA/29D9egv582tTHiK71gac6d5Dge8n8d2CMueVMnRrCvZH1d7U+1XoL4ybl+oeu4/mDCjQ8imZcxNIi0N8KPfivFDo7sewZZAONJN1bBZSZeC2O3Iorwjms7YQ38vmbqBwwSAAAb31kKnWm2adXKVv6+4r08oW3gUux7Koc6i7WPdK/EkCphFZFm/PtV//yUXBpLcXAVTXzT0ii7PZT6rQVL/0DOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U8c9oEb7mRedkhSwO9bul/Idr7QEmAlAqRexn/CXBs=;
 b=ZYd9bRKwHpn3I+YPvxv1Bpd4K41SJVTbSYYnsTTSHie/4jEyiYCnp0N4s00F9pUIgDRYzuKdzJxri89tAEEh+KQxfcTHQNYG97tzOrvsDwOuzRMJRyOv7sq/Q3MYQl8PInzwdZyB6SSi21qjyF0vVYbUTAZWgD/zke5xIuXIGK1A7JcRfoqdtSSKKh01UWwHNns8PcxEEO4SKpfsG8U7iwN8LVNAWL+DcjYvcT2Ric5dKRYkbiQoPu1TgEz5aHVW1zLfKWGn/sMfic7fr/JJ/u5BAO0HOwJ7wrznwm8L5DV50bZVXR6iOGMi+Bf0WBDVcH2H7uTdRFanNsrMNCNcKw==
Received: from CH0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:610:cc::35)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 20:21:12 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::2e) by CH0PR03CA0090.outlook.office365.com
 (2603:10b6:610:cc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 20:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 20:21:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:20:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:20:53 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 19 Nov 2024
 12:20:50 -0800
Date: Tue, 19 Nov 2024 22:20:50 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v5 20/27] cxl/region: factor out interleave ways setup
Message-ID: <20241119222050.00003d71@nvidia.com>
In-Reply-To: <20241118164434.7551-21-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-21-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d9fbc5-9678-4a18-e1fd-08dd08d7b63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nTJmi+tx9/inyhzsgbvq8x2ifOntxDnITdCuuIV7e9EN6z4gh2CgBAix8f0T?=
 =?us-ascii?Q?HfHWz807MVZ9cjc448LHXVTfdTTnv3Sl2aDLvURddEtUzJwYpbM1DKLwy35J?=
 =?us-ascii?Q?PxUpF8zbKHGNi1MvGMSYR5RMyz62jhw9WYIn+WOXKTLmYy0k3mKcHl3xm1mr?=
 =?us-ascii?Q?mv6foqN2NrJJCYMA5cHJXegQLJYDScrqb1AdaoZam3Sj/8i5+0RxDNz6WIP1?=
 =?us-ascii?Q?BnjXIHFqJ/c8CsPYmSQ7M5DPndpR3u7rxpSTh5puFiVSrYQxDbt+q42tRV4v?=
 =?us-ascii?Q?WfmzfTnzVKtV1QEjVJllhDGsFYMx5LofGRyClCytI9Zk9eT2+WHj2Pn8Vc4S?=
 =?us-ascii?Q?RCqfRl1cVa6gl3mBHuCnI0xURx0w0LHeNEuW8vlOSuyKCPNijQ0aohtFmbA5?=
 =?us-ascii?Q?Jx0EDJnstL5S5fAtx1qO/NTCQnVHvHqY5KrnSWoUGz28WJQbBrrmkB8CxW0f?=
 =?us-ascii?Q?XaFQf/3QlZenHHFzmLM5B/+U4Xz8PJjywHB5xZb169prGprkqX6jkYcy9JCs?=
 =?us-ascii?Q?HvYU1f7aY1RnsyBg9nPkrv5SpPSc+JjNcIy41hiZDTvnySHc75g7mr7Mdytc?=
 =?us-ascii?Q?D4hJxukKEmOdwKWuDQOwhM5roR2pXnwWvJvDb1NuTOgTB8i/H6coUcqa3l1X?=
 =?us-ascii?Q?OuH3+MpyDRLip4CTIwHtfLxO1+QNRe7ntJuzKUkGKhGLxE0jpEl8S2TePdBy?=
 =?us-ascii?Q?jkM8w35bMteGyJYnreI3a7a3ToGQfTgHLCSBoDhqVcgiiDCUJq4bXAU9YnWy?=
 =?us-ascii?Q?cBqGCfA4HMkzbMoktcmG6OWnhbNtCWneZ9fSiWwdcOVyTXTFHPKsXsagGcd0?=
 =?us-ascii?Q?wVKTFCC/OnDvwBpOefIAcsvqjsnxTXrD61J0D5Ey7n3CDpV0iNvvVROFZu5l?=
 =?us-ascii?Q?aF4C9fA7k60bVbpWHp3Wag4clIU01+RIrpzhPjcH/8qGbdHxSGCPjmaapJ/n?=
 =?us-ascii?Q?PtEfwrWWX4si88IHfeKDKoAv9c+hDCggEc21zyGyrXDY2kYp9vXkyDd1IbbB?=
 =?us-ascii?Q?WyHKg/vi2WikkcfDmLMGLad0MDzIPi9aPiCyj10qDooxovperTpoSWVi/Kux?=
 =?us-ascii?Q?UAtDg/1uk+IJUk1q81OIAXo9QOtW8Yvog8wSERw21A/AXls/FgGMmxLPEdPZ?=
 =?us-ascii?Q?Cun+T8kGNhPKLdjVpZZeoWU6lBnQIHOqJDRnwyVVLZOT5OyozOTkCWyKqlm2?=
 =?us-ascii?Q?rrOWogSMYPvKMfsjidrEgcXarnS0E660h1V+X2wBLPz0uOoylXvTBEeuQvci?=
 =?us-ascii?Q?tpurmqrX/Oc72hxbIMAgP15PR0FzLijBSe+WrYU65+gzlCatnaYpeInLUn7S?=
 =?us-ascii?Q?K8tEWQ6TtxfPPcUCwAlFstW/kuG9jemf5071bzY+dWPFGTzgzd1r9jGjKQBO?=
 =?us-ascii?Q?OyTZ44+EyvrmWfmXQx5aW6Zsich3e/dqpPIqvN4UQm3JTqQw2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:21:12.3193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d9fbc5-9678-4a18-e1fd-08dd08d7b63c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856

On Mon, 18 Nov 2024 16:44:27 +0000
<alejandro.lucero-palau@amd.com> wrote:

LGTM. Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c | 46
> +++++++++++++++++++++++---------------- 1 file changed, 27
> insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8e2dbd15cfc0..04f82adb763f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -464,22 +464,14 @@ static ssize_t interleave_ways_show(struct
> device *dev, 
>  static const struct attribute_group
> *get_cxl_region_target_group(void); 
> -static ssize_t interleave_ways_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>  {
> -	struct cxl_root_decoder *cxlrd =
> to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd =
> to_cxl_root_decoder(cxlr->dev.parent); struct cxl_decoder *cxld =
> &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	unsigned int val, save;
> -	int rc;
> +	int save, rc;
>  	u8 iw;
>  
> -	rc = kstrtouint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = ways_to_eiw(val, &iw);
>  	if (rc)
>  		return rc;
> @@ -494,20 +486,36 @@ static ssize_t interleave_ways_store(struct
> device *dev, return -EINVAL;
>  	}
>  
> -	rc = down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
>  
>  	save = p->interleave_ways;
>  	p->interleave_ways = val;
>  	rc = sysfs_update_group(&cxlr->dev.kobj,
> get_cxl_region_target_group()); if (rc)
>  		p->interleave_ways = save;
> -out:
> +
> +	return rc;
> +}
> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_write_killable(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = set_interleave_ways(cxlr, val);
>  	up_write(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;


