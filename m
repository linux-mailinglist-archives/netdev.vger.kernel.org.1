Return-Path: <netdev+bounces-121000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C4195B61F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C58D2852A5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5113C90A;
	Thu, 22 Aug 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UC2srTeI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A21C9DE5;
	Thu, 22 Aug 2024 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332366; cv=fail; b=jXH8rsv5/r4u8eghhaMOM6dRkWdHQHExAy9MBRFQAhN2StFLWK5KU3SJNbVBdbwO2AyneZ+5OVQOlqLt5joOeoSC9EL9vaSl88kala/VG66td/MRFlz4ryasShOlhX4okhhDkG3ssWHKQg+WIhBoPGENvsgQ4hCYI3wonYolwAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332366; c=relaxed/simple;
	bh=TqIPz5UWcHKheLpEZaQPCYHpdJHzFxl6oth/dTRt4sw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eU9Wxh5qe5c/YTRJzG7iQ79RAi7WzqBSFB538qZcMrHjvE4ZE4tw9PGFfKAlCyEZwQE2NTKftaLw2wa2fJtq+JOBsE+stuT1zpMhBqL08voFfom4Wz+ij3go+LEQDamvBeG40qa24a5SFq3nqB1j7CK2hLyqDDB9NJELlMpmCAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UC2srTeI; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLKzKYVH3qfB8ZuEVJu3dEN+oSc3LiMdQTMugbBASeAcMpel2EmUvb8HHXfcpKhYjPiK1Rs2liYpn2fBv+kVsdYHBALGYCrlAFper2ZZoXsvh1dSAasvJUFDWX0IDUgyvT/l/S2GO3Wow6G1oXoCtUppuW2GMBbNr8NE9S5I6QtmQlYyQdsPfSeen6j0j1FCKp2Qtwr6IIH1OsZsPuCEnIux0PUaAjbiJ9Jt8MpgQTG5w2eBQWwUyIWhD7aU+6vs9g4JCGpax4ia1CqGzLX2j7etlQW+olwSUqwzGpI3B3JS8XSa4X9GEGz1wPb97KNOlr36kaBzlGQWwzQp5eZXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diPnuMM3rMtq51F+eSIbCsRDYC3T5EAxxGoztnUZEzc=;
 b=YDqrjTTC0m0fGADux7zmDPwxoA+udcfvfOexKQ52V2WK782UZQZlm7kcjtm0HGqEYifL6NoM3AFb2CpqKyhJOV/7Ibplfh5Zr+L/B31vIHWFsPaYzLxk4eXq1xJTUTJAZkDQ1xqyUtgYfytcc4OJ1vsM6h2cbthyRvn/8Mc+uKjHxMIuShI/VF8IdLfFCD+iRkqWtmks946z2X8Jhx4sTq7/NgRtt+05DHmDZzUCDry7fu4VQ8l0hlqmzH/65umX4rbu6rPTHOOuPUGp83OXRf3W1rcUR20dmExLvvz1dAPzviDJFFFj8shKwTCBerc4q59lOX8uUAXqpXACmlGg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diPnuMM3rMtq51F+eSIbCsRDYC3T5EAxxGoztnUZEzc=;
 b=UC2srTeIROUdG/FnhEdXtbF7GEtyWCvWCeaLn/eyNvrvUr2ZP1Mxo9FEA18tv4Vulb4g2eeOI74p8tXBob6W8tIoiHB3v6/G31kRQG6CNE2TrQ4XENHqI/IP557VFruKqrxiZ49brqcyA2dHNkKvh/JWMazmlo3AJbMuphD4sabdjg1cXuB5oXMVWCPnt1v6XrX44hIaykiJMf3ob5NT8AAWwgPYb4lOI13xyS19xvo9zx0kAikyV895WyuL35JzK6LbEhLmCwK7MNxO88y0CKtIARSevViN8toVQCSsB6u/6VHqt5RUVjlgDSit3ZcUtL7CB8O2mN+9HHbVHkCHrQ==
Received: from DM6PR07CA0122.namprd07.prod.outlook.com (2603:10b6:5:330::18)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 13:12:38 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::38) by DM6PR07CA0122.outlook.office365.com
 (2603:10b6:5:330::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 13:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 13:12:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:12:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 Aug 2024 06:12:29 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.126.190.181) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 22 Aug 2024
 06:12:26 -0700
Date: Thu, 22 Aug 2024 16:12:26 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, <targupta@nvidia.com>,
	<zhiwang@kernel.org>
Subject: Re: [PATCH v2 12/15] cxl: allow region creation by type2 drivers
Message-ID: <20240822161226.00001736.zhiw@nvidia.com>
In-Reply-To: <20240715172835.24757-13-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-13-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0e986d-a459-465b-5bbf-08dcc2ac18b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7Yt89c5SpshqHwtJWnG7KWT6MZc7mHZ2S3qVTvdCajLNIqFZPqd9p+4nOVA?=
 =?us-ascii?Q?x7+aRjKt2yq1k/15nYcwWedYjP6WwtBc4WALPa++FVO/zWIcxnzkPR4wLJ49?=
 =?us-ascii?Q?DCMAvIgYyFTcssPZK59UknBnvHPGUPxib+bA719YtgzTfF4rfTN+O6GHsA69?=
 =?us-ascii?Q?sBUsg4Hq3KR2zKyg66PjuDIavMvhuYecQePUDJTooC4bpdMjWMhtGTtWxdGN?=
 =?us-ascii?Q?y+sc13xMH2FVeKXm3qT/Sy5IblYiSpercC/uikdEZyJUs5WKPboUk2mFzlI+?=
 =?us-ascii?Q?EBFuSJoCzXHx7n3VvmlS0+K9664KxCLzfMiViGaweFIY/VMv8UlMJ+3et9CT?=
 =?us-ascii?Q?znTD4Ae4Z07ShC2vluKEjSplo2iHjBHEMbYL/2yNQq2XiKmjWlgcQ37MMRNr?=
 =?us-ascii?Q?IVm8deSsD2Hn49Or+j3omS0d7cvV+3DOKi6PMq5NwiYy9gkg8B184XPmisXZ?=
 =?us-ascii?Q?jVFiuh0Iq7a3zxHjAmmmLrpRZf38mpUI1/S6fJ2e5dUy60OFOXC04mBdT2ZH?=
 =?us-ascii?Q?w8XGhZQdMsuacOqESgYLqkCuvsYRLjP8CRYbfkXBmJVaFWu9y9iwKy1yd6Zu?=
 =?us-ascii?Q?SNig8g2r1JtLghTpiblWHwKjlG+G+wjUZentYneS0AFtI6kfOpC3wO+W8ES6?=
 =?us-ascii?Q?m8HeNrRZO/SFH4U96dzocYct17ve1Sfa5ESSLlOn/ptBigpzxztVbEqZWlRw?=
 =?us-ascii?Q?gr/QwnimW6g4bwAUgNTvA76bdsc2B6nv1b8Jv7Eba6ZCPXvPyhX/iHTlMefi?=
 =?us-ascii?Q?VVNGmo8dNF5NVuRGQuF0+8gZj82kNkhLWKCbmxcPafRdJHkfFbJnmIM1jzUN?=
 =?us-ascii?Q?ZFlavOaQfJMgYQPJPBe0MLMV5oDxXHj+5Tan37x/bOeSxcP9Mssw3rbNVWXx?=
 =?us-ascii?Q?guM1dYTyFYezd9aKQqPYbyfE7HT/Wn7SniDvfJNjdQfHTJzzFGfuu/JttwsG?=
 =?us-ascii?Q?lpn8fWpAWxCfk06BhZVZETV3rnv57VFpuR4Wquk3z+CnAzAsd3Md6Z1P8Mw3?=
 =?us-ascii?Q?R3bo5gkK6w5Tvw9Q9g/sB5u79GTmymNs8v5EuLVEn6j7CN258n08sZ+cRL/p?=
 =?us-ascii?Q?EyRvcCoLDPj901w16sjJxpeqMKssW5HyhHwSLSMiTAiL+f8TMpNtNWiDDiUa?=
 =?us-ascii?Q?DkqtydW548uVkeFWx0ozt+kpXCu8Yv4WuTD1fnEk0oKsTdzHHn48TWvSY/en?=
 =?us-ascii?Q?040ZfsjeaKeY2hHl6eZFiOaHbNhLolAf0wW5D5C5yZpw1BPAtWfhd6zofAKa?=
 =?us-ascii?Q?NwGth9XRvV5MAj7yTCaqBVscKDTAWQ/8c94Ba1UW8UaokuoONc8HSXhk0AQy?=
 =?us-ascii?Q?WRoMAiB5S6zg6YbxshS8HVB2QQVVi/ckg9hKWQ8JbAmR7/ecGmzQggSVZimz?=
 =?us-ascii?Q?qPx+JnnTPgwMJAzUfYkr/2YCWyF9u2bCt0kc1hW1WS/03llXUJQNy4VQIPjo?=
 =?us-ascii?Q?SXg9qYZh805YHbc+trasWvFSNRrn8bBn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:12:38.3194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0e986d-a459-465b-5bbf-08dcc2ac18b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211

On Mon, 15 Jul 2024 18:28:32 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on
> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m84598b534cc5664f5bb31521ba6e41c7bc213758
> Signed-off-by: Alejandro Lucero <alucerop@amd.com> Signed-off-by: Dan
> Williams <dan.j.williams@intel.com> ---
>  drivers/cxl/core/region.c          | 265
> ++++++++++++++++++++++------- drivers/cxl/cxl.h                  |
> 1 + drivers/cxl/cxlmem.h               |   4 +-
>  drivers/net/ethernet/sfc/efx_cxl.c |  15 +-
>  include/linux/cxl_accel_mem.h      |   5 +
>  5 files changed, 231 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5cc71b8868bc..697c8df83a4b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -479,22 +479,14 @@ static ssize_t interleave_ways_show(struct
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
> @@ -509,25 +501,42 @@ static ssize_t interleave_ways_store(struct
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
>  	return len;
>  }
> +
>  static DEVICE_ATTR_RW(interleave_ways);
>  
>  static ssize_t interleave_granularity_show(struct device *dev,
> @@ -547,21 +556,14 @@ static ssize_t
> interleave_granularity_show(struct device *dev, return rc;
>  }
>  
> -static ssize_t interleave_granularity_store(struct device *dev,
> -					    struct device_attribute
> *attr,
> -					    const char *buf, size_t
> len) +static int set_interleave_granularity(struct cxl_region *cxlr,
> int val) {
> -	struct cxl_root_decoder *cxlrd =
> to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd =
> to_cxl_root_decoder(cxlr->dev.parent); struct cxl_decoder *cxld =
> &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	int rc, val;
> +	int rc;
>  	u16 ig;
>  
> -	rc = kstrtoint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = granularity_to_eig(val, &ig);
>  	if (rc)
>  		return rc;
> @@ -577,21 +579,36 @@ static ssize_t
> interleave_granularity_store(struct device *dev, if
> (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
> return -EINVAL; 
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
> +
> +	p->interleave_granularity = val;
> +	return 0;
> +}
> +
> +static ssize_t interleave_granularity_store(struct device *dev,
> +					    struct device_attribute
> *attr,
> +					    const char *buf, size_t
> len) +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc, val;
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
>  	rc = down_write_killable(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
>  
> -	p->interleave_granularity = val;
> -out:
> +	rc = set_interleave_granularity(cxlr, val);
>  	up_write(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  	return len;
>  }
> +
>  static DEVICE_ATTR_RW(interleave_granularity);
>  
>  static ssize_t resource_show(struct device *dev, struct
> device_attribute *attr, @@ -2193,7 +2210,7 @@ static int
> cxl_region_attach(struct cxl_region *cxlr, return 0;
>  }
>  
> -static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> +int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
>  	struct cxl_region *cxlr = cxled->cxld.region;
> @@ -2252,6 +2269,7 @@ static int cxl_region_detach(struct
> cxl_endpoint_decoder *cxled) put_device(&cxlr->dev);
>  	return rc;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_region_detach, CXL);
>  
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
> @@ -2746,6 +2764,14 @@ cxl_find_region_by_name(struct
> cxl_root_decoder *cxlrd, const char *name) return
> to_cxl_region(region_dev); }
>  
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd =
> to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region,
> cxlr); +}
> +
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
> @@ -3353,17 +3379,18 @@ static int match_region_by_range(struct
> device *dev, void *data) return rc;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder
> *cxlrd,
> -					   struct
> cxl_endpoint_decoder *cxled) +static void construct_region_end(void)
> +{
> +	up_write(&cxl_region_rwsem);
> +}
> +
> +static struct cxl_region *construct_region_begin(struct
> cxl_root_decoder *cxlrd,
> +						 struct
> cxl_endpoint_decoder *cxled) {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> -	struct resource *res;
> -	int rc;
> +	int err = 0;
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -3372,8 +3399,7 @@ static struct cxl_region
> *construct_region(struct cxl_root_decoder *cxlrd, } while
> (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY); 
>  	if (IS_ERR(cxlr)) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> +		dev_err(cxlmd->dev.parent,"%s:%s: %s failed assign
> region: %ld\n", dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
>  		return cxlr;
> @@ -3383,23 +3409,47 @@ static struct cxl_region
> *construct_region(struct cxl_root_decoder *cxlrd, p = &cxlr->params;
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s autodiscovery interrupted\n",
> +			"%s:%s: %s region setup interrupted\n",
>  			dev_name(&cxlmd->dev),
> dev_name(&cxled->cxld.dev), __func__);
> -		rc = -EBUSY;
> -		goto err;
> +		err = -EBUSY;
> +	}
> +
> +	if (err) {
> +		construct_region_end();
> +		drop_region(cxlr);
> +		return ERR_PTR(err);
>  	}
> +	return cxlr;
> +}
> +
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder
> *cxlrd,
> +					   struct
> cxl_endpoint_decoder *cxled) +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
>  
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
>  	if (!res) {
>  		rc = -ENOMEM;
> -		goto err;
> +		goto out;
>  	}
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> +
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
> @@ -3412,6 +3462,7 @@ static struct cxl_region
> *construct_region(struct cxl_root_decoder *cxlrd, __func__,
> dev_name(&cxlr->dev)); }
>  
> +	p = &cxlr->params;
>  	p->res = res;
>  	p->interleave_ways = cxled->cxld.interleave_ways;
>  	p->interleave_granularity =
> cxled->cxld.interleave_granularity; @@ -3419,24 +3470,124 @@ static
> struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd, 
>  	rc = sysfs_update_group(&cxlr->dev.kobj,
> get_cxl_region_target_group()); if (rc)
> -		goto err;
> +		goto out;
>  
>  	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig:
> %d\n",
> -		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> __func__,
> -		dev_name(&cxlr->dev), p->res, p->interleave_ways,
> -		p->interleave_granularity);
> +				   dev_name(&cxlmd->dev),
> +				   dev_name(&cxled->cxld.dev),
> __func__,
> +				   dev_name(&cxlr->dev), p->res,
> +				   p->interleave_ways,
> +				   p->interleave_granularity);
>  
>  	/* ...to match put_device() in cxl_add_to_region() */
>  	get_device(&cxlr->dev);
>  	up_write(&cxl_region_rwsem);
> +out:
> +	construct_region_end();
> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
> +	return cxlr;
> +}
> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
> +	struct cxl_region *cxlr;
> +	int rc, i;
> +
> +	/* If interleaving is not supported, why does ways need to
> be at least 1? */
> +	if (ways < 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	cxlr = construct_region_begin(cxlrd, cxled[0]);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	rc = set_interleave_ways(cxlr, ways);
> +	if (rc)
> +		goto out;
> +
> +	rc = set_interleave_granularity(cxlr,
> cxld->interleave_granularity);
> +	if (rc)
> +		goto out;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	for (i = 0; i < ways; i++) {
> +		if (!cxled[i]->dpa_res)
> +			break;
> +		size += resource_size(cxled[i]->dpa_res);
> +	}
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (i < ways)
> +		goto out;
> +
> +	rc = alloc_hpa(cxlr, size);
> +	if (rc)
> +		goto out;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	for (i = 0; i < ways; i++) {
> +		rc = cxl_region_attach(cxlr, cxled[i], i);
> +		if (rc)
> +			break;
> +	}
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		goto out;
>  
> +	p = &cxlr->params;
> +	p->state = CXL_CONFIG_COMMIT;
> +out:
> +	construct_region_end();
> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
>  	return cxlr;
> +}
>  
> -err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport_dev, unregister_region,
> cxlr);
> -	return ERR_PTR(rc);
> +/**
> + * cxl_create_region - Establish a region given an array of endpoint
> decoders
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: array of endpoint decoders with reserved DPA capacity
> + * @ways: size of @cxled array
> + *
> + * Returns a fully formed region in the commit state and attached to
> the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder
> **cxled,
> +				     int ways)
> +{
> +	struct cxl_region *cxlr;
> +
> +	mutex_lock(&cxlrd->range_lock);
> +	cxlr = __construct_new_region(cxlrd, cxled, ways);
> +	mutex_unlock(&cxlrd->range_lock);
> +
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	if (device_attach(&cxlr->dev) <= 0) {
> +		dev_err(&cxlr->dev, "failed to create region\n");
> +		drop_region(cxlr);
> +		return ERR_PTR(-ENODEV);
> +	}
> +	return cxlr;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
>  
>  int cxl_add_to_region(struct cxl_port *root, struct
> cxl_endpoint_decoder *cxled) {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d3fdd2c1e066..1bf3b74ff959 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -905,6 +905,7 @@ void cxl_coordinates_combine(struct
> access_coordinate *out, 
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong'
> version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a0e0795ec064..377bb3cd2d47 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -881,5 +881,7 @@ struct cxl_root_decoder
> *cxl_get_hpa_freespace(struct cxl_port *endpoint, int interleave_ways,
>  					       unsigned long flags,
>  					       resource_size_t *max);
> -
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder
> **cxled,
> +				     int ways);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c index b5626d724b52..4012e3faa298
> 100644 --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -92,8 +92,18 @@ void efx_cxl_init(struct efx_nic *efx)
>  
>  	cxl->cxled = cxl_request_dpa(cxl->endpoint, true,
> EFX_CTPIO_BUFFER_SIZE, EFX_CTPIO_BUFFER_SIZE);
> -	if (IS_ERR(cxl->cxled))
> +	if (IS_ERR(cxl->cxled)) {
>  		pci_info(pci_dev, "CXL accel request DPA failed");
> +		return;
> +	}
> +
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled,
> 1);
> +	if (!cxl->efx_region) {

if (IS_ERR(cxl->efx_region))

> +		pci_info(pci_dev, "CXL accel create region failed");
> +		cxl_dpa_free(cxl->cxled);
> +		return;
> +	}
> +
>  out:
>  	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  }
> @@ -102,6 +112,9 @@ void efx_cxl_exit(struct efx_nic *efx)
>  {
>  	struct efx_cxl *cxl = efx->cxl;
>  
> +	if (cxl->efx_region)
> +		cxl_region_detach(cxl->cxled);
> +
>  	if (cxl->cxled)
>  		cxl_dpa_free(cxl->cxled);
>   
> diff --git a/include/linux/cxl_accel_mem.h
> b/include/linux/cxl_accel_mem.h index d4ecb5bb4fc8..a5f9ffc24509
> 100644 --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -48,4 +48,9 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct
> cxl_port *endpoint, resource_size_t min,
>  					     resource_size_t max);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder
> **cxled,
> +				     int ways);
> +
> +int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
>  #endif


