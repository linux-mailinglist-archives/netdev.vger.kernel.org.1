Return-Path: <netdev+bounces-136763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F9A9A300E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1865D1C21DD5
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E061D6DBF;
	Thu, 17 Oct 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="adgDmYhb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C91D63DA;
	Thu, 17 Oct 2024 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201804; cv=fail; b=k+dW3aXWLWoYYZwZ+Cg5WAZAxSP3uHjTapZnPtoMdqrQ4OlwHBN5L3i8SrZDLm5npSSfhHT6A4Tnq4L+TfBR45SySpPc5L9FEawxtQZpkuuWu5cQrCCchVd5EriCZCgiSnIorhzSr7BJjhkFAOvfMErLIYj7WNd/+x42Pgr5X+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201804; c=relaxed/simple;
	bh=zvZrtj4I7bAoRfJQ10Uk40Oo7GSa2KzQojLwaETe+Aw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=nxfdOMXhb+r/5kFdrVH5IZDXoaPPIQpyicCHv3QXpb8IhjHVFJibybXSEIEpCMMhqTQrOPplOzofGXiJ9pwkYMgR49jk5psIn7wpMCPgkpob65CoX61MN0CojFcsNJJ0z6F2Vb8PiR4ccQt/b8obk2O0J+F5rBd0nrFl5rWyAqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=adgDmYhb; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss1u6wFjFxZmcheqnkpmmFqaJvmCp+zPjlw8wRJqKYO/TTyL2kYagWDIH6KoJWUgf30CaBcMgO8zzmfYrS56CertjZ0cXKcCj+cx5bqOBGZv9wkR0RddvCn+Mk2brjP1DOF67O3ESwKd8qBbFdEXF95uMzi3qHZtmmrm2990WhxmHtBW/yA1qpgWsKN/BgMk4MUPcg5JJFXGnWsEceJGe273kldJN3rP2w3L1WGRjswLQYTuFDHex3Z/O/iOR7ulcaTRe08rYKSjD1OdgXpn8lAXxMKzTZ6HsEwGIJBNxHbsz/8YSbYYZiI6snuBMRZX99qBaYLyEKNYHddUM0C/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36h9+tjfu9To8aHUR3YxoV43BoYH+c1cwC1FHLOHfEA=;
 b=trKBiA5dJr4VKiPxUFBYzKPnoSKrjULoYamZzdDDje7G1Fk7TQcClQLfWtzkf1Zfm//UuwYOuM+l/RDpbig/nWE38nhbBcg0UNn4Zq9yf23OKOL6zlF1Pc/Cl0pmSSqLEIZo9kGLAAynxJo5FG8aJ2BcZILSqSHQ6EWmu9RzfZTqNQJZqWY7/FD4BQUmz767gxqKkFWBBUamWE21enap0YjJ0ubALRwhVeL+KDKWBvX/FqZIuRHl0B6+DmrcaKDiAQWkursRvNOUJvdyHjFApvSSHDT7CRKHKbABlinf6tCYKIbaGwZTqu3y14Vyl/g+NeB2GSi1/pPLjAda1oigWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36h9+tjfu9To8aHUR3YxoV43BoYH+c1cwC1FHLOHfEA=;
 b=adgDmYhb6R1hg8TOL8W4KjkJWKIR75QUo5SNFNpwrEQteG1ZO8YI/n8uk/V4Qu86Z91U/vm2tIKWEreyw9dvdC0mJscQ1Py/0aKPfXjpojAX6XjZmfG1s8FgsoWPDAmwsYM5Eu5zYhKBLuGnODgpxNooD/UugiJ9/Xc+CUE/tiM=
Received: from BN9PR03CA0533.namprd03.prod.outlook.com (2603:10b6:408:131::28)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 21:49:53 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::53) by BN9PR03CA0533.outlook.office365.com
 (2603:10b6:408:131::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Thu, 17 Oct 2024 21:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 21:49:53 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 16:49:51 -0500
Message-ID: <ae4e2c7c-f0f5-4e83-a1a6-83de2c254015@amd.com>
Date: Thu, 17 Oct 2024 16:49:49 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v4 13/26] cxl: prepare memdev creation for type2
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-14-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241017165225.21206-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6420376d-6ba3-4638-ef75-08dceef5a25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1RiSFdCLzlob1YrOHJWTFBTcjN0T29qRWYrSVozQTdRZ2hIMEUwQmxlYXNu?=
 =?utf-8?B?RVhrV2l5alNNUFRZQ0JOTzU0MGFjdVVZUmhCK1g0MnFVczl6aVh0RHRBYVNH?=
 =?utf-8?B?VGtBOUl3enRxZ0VPYXFTT0lLdGgvNXc1dDlKamZidk5ieDlqWkRQR3hXcWlj?=
 =?utf-8?B?Ni9ZSjJ3ZStha3B4TDI3Y2NVbXc5LzkvZlBnWnlHUGY0MUpYRzMzeEhITW1O?=
 =?utf-8?B?R3JnVzJvZk1CSHJrWnhSeFE4THlHMlhVU2puVkZCbTdpZ3ZMODF5RWlPeXpS?=
 =?utf-8?B?TVgvTkJDanZFVmdRN2YrRSs5dVd4SFl4QnBxM1k0UUJyQnVvTytFWm1Jei8y?=
 =?utf-8?B?cXF5NitiM0k0U1Q5YXFvT2hMRWpxTDBsdXpXV25nTlFIUDFqR0hnaXJFdmxt?=
 =?utf-8?B?WXl4bWQyZmlSWjEwM2QyVnhXdi8ySUk4UmJvRVJRUTFvRTdhMTl0bXUxR0JP?=
 =?utf-8?B?L1doUTIrQ3BVdkZPNzlUdlZBZTN4T3k5cXpSWVUza3FqU3ZjMjNnSUJWODRK?=
 =?utf-8?B?NDkzbS9vUG9LZ01UY1ptRGVVUi9HM0pkNDBFL2hyeXVCUjhVbk9zUCthdFN1?=
 =?utf-8?B?Y3NKS3hFVGFoU1NQdWdRYkZuNGFhbU43YjA0R1NiM05pRkUzeUM3SmZLNmpM?=
 =?utf-8?B?c1dCUnU1L3pkWEc1cjZ1NzBpZk1FRFBoT1ZYeDNEcVFSZEFzbCtNTUk1N3F1?=
 =?utf-8?B?N2k5TVkxK2FmWGpkMHBJL1B5R05CLzNzc0tNek1SU251aFFrQkhVbXhuUWRO?=
 =?utf-8?B?ckJpUEZwNHI1d2RZYzlsc3FkRnk0Q2tPWDdhTGtaOU1xelhFdnZaL2tKdmZC?=
 =?utf-8?B?Wk51aitjQ05kOHVIdEEvVDVCZjBDYm1XOUZ4bWVnRksvVi85UjlyaVUzZ3A1?=
 =?utf-8?B?aEZwcU9IWFZVdmZHdjNlQjhHRFNYaWxSR1JwZFFPVkFOczA1a3dzS1UwcHVp?=
 =?utf-8?B?ZGRTV0FlVi9ZcTVPMmFmTnZOU3RxRVJJVWFOR2tsUVBxcjQyRlVLTTNtRWRt?=
 =?utf-8?B?ZTJrTDYxZ21MeFJmVTQwRTZ0N2xYQkZFUFB2R3FwMjNXcEpQK3BpeUZoTWV4?=
 =?utf-8?B?UGpIalV0dWxURFA0NjlkU2ZRblFXQjR3MDlWWkxsMG1uTzFyL0NmRkVzbUlk?=
 =?utf-8?B?QS9RUkhtUmJPRnU4cHZpTFJKYldWRk50M2RLL254OUZZK29LT3cyNVdSMFJC?=
 =?utf-8?B?aU42c0hIMytpUmRzWUVyWkQwRVhWWG1pV1BWdURJQUJ3dWN1TzZqR0NSRi9j?=
 =?utf-8?B?WXJaLy9FaFIwVmJLQ1F4SkI0Z09QZWE0OVVwREVpck5ueDg5NEp6QVRPVTBH?=
 =?utf-8?B?M0laQnlCMGlMUlVGbkloeVNpazRwb1c5Y0trM09mNEVVT1JPQXpqdkorU3RJ?=
 =?utf-8?B?ZTRmSlFsMFNpV0dQMGRSN01vOVB1dUxuZ1ZyZytWdHlsMWV2bFZsY3hBbFhq?=
 =?utf-8?B?dXhVelUxZnA5TURTblV5dXp6V0ZwK1dNdDFNTUF5L25HT3lWNmJjRGhuWlJi?=
 =?utf-8?B?K3M3V3lSMkFZc1BRMnBvRmFzMDZPVldiS28yMUxYZW9GcUs0ZGxFZFJzbTZU?=
 =?utf-8?B?dUMwTGlzVGN5Yi9CalRickZJSXQ2UXNDbGRkSmpOTFdld01xeldzdnpXZER5?=
 =?utf-8?B?RHFFYnBjQThxdys4dHo4Q0ZySHdNOFpIRStBbkM1S1JETnVGT0RPdGlsZmY1?=
 =?utf-8?B?c1NJbGZrZ0FlbVEvKzNnSDJtR2hVNXBvVnRkMmcrRHR2L0N3QXlLazllMjZR?=
 =?utf-8?B?c1N5NkcvUGE4VzBJTmd4Q0lCb1AxTjlPSXJIelRudVIvTEYxb1c1UGIzczk4?=
 =?utf-8?B?WGpRd2g2QkxDYWpYQnQwQWlJRjJ1VnJkN1gzcFJNUE44LzlRUjlqQVBsZmdr?=
 =?utf-8?B?S0lvSzV1QWVJOHN3L3pTYndrSkp6MEhJYXkrZTkwTkhld2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:49:53.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6420376d-6ba3-4638-ef75-08dceef5a25b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233

On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected.
> 
> Create a new cxl_mem device type with no attributes for Type2.
> 

I agree with the sentiment that type 2 devices shouldn't have the same sysfs files,
but I think they should have *some* sysfs files. I would like to be able to see
these devices show up in something like "cxl list", which this patch would prevent.
I really think that it would be fine to only have the bare minimum though, such as
ram resource size/location, NUMA node, serial, etc.

> Avoid debugfs files relying on existence of clx_memdev_state.
> 
> Make devm_cxl_add_memdev accesible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c | 15 +++++++++++++--
>  drivers/cxl/core/region.c |  3 ++-
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/linux/cxl/cxl.h   |  2 ++
>  4 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 56fddb0d6a85..f168cd42f8a5 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -546,9 +546,17 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_accel_memdev_type = {
> +	.name = "cxl_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_memdev_type ||
> +		dev->type == &cxl_accel_memdev_type);
> +
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>  
> @@ -659,7 +667,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = cxlds->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_accel_memdev_type;
> +	else
> +		dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..7e7761ff9fc4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1941,7 +1941,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> -	cxl_region_perf_data_calculate(cxlr, cxled);
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
> +		cxl_region_perf_data_calculate(cxlr, cxled);
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		int i;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 7de232eaeb17..3a250ddeef35 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -131,12 +131,18 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	/*
> +	 * Avoid poison debugfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (mds) {
> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_inject_fops);
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -222,6 +228,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/*
> +	 * Avoid poison sysfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return 0;
> +
>  	if (a == &dev_attr_trigger_poison_list.attr)
>  		if (!test_bit(CXL_POISON_ENABLED_LIST,
>  			      mds->poison.enabled_cmds))
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index b8ee42b38f68..bbbcf6574246 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  #endif


