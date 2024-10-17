Return-Path: <netdev+bounces-136762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52739A300C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580621F2351D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC13A1D6DB5;
	Thu, 17 Oct 2024 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yAUUuZkV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A791D63DC;
	Thu, 17 Oct 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201788; cv=fail; b=Fcg15LFQgyNOG9f1I6wMh4JhcNBBbFTGuaXaIIMCwOcjUbbM5O1dOKViFsqQWE4eNg2ibEZJKAa8ekGAWx7pkpm2mp/m++H7oLapAeN6WADRPcNmmyHRqQrzG/rFaL+/++PdWB02AwYX8xGUUUmYZGG+6Olr0Yt0NGozQobhcVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201788; c=relaxed/simple;
	bh=Hy9/hs3dGVVR8FvufdzMgH2sI107VFN1PZyvyOJXMZY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=CjVFDTTUCrSiirjax5XeLZ1HAK3mkQo2EKZAlvQKlVis48P6wBRZ2cZNpSnA4gd5EN0qvpw5KLjln2aZjqaopjUNEnA6O2XzDCkErDShpwjObxSFMP8XBbr2is4DikML6Z+1UDk7AGAINCwO2AFkqd4wXGpf83vqa1zT0oCymV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yAUUuZkV; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNPW95iqkjN6VpbgrTH06MayY3fV5DUv+HgGJsB/6f9naji2jWckICEa6+SfVzPKjrAA1Mp7Zj70zmOgw/l7Ymp1JJwQ/om5k9hIinbWxJ/buBRNaUyPXV2Z9oYa7/yyZX7P7i9RbhE0QanDgGzGPYqt+la1aWHmL2vIRt+FU9XG29/EsqfMeGN9MdcJLdxI5i3h5VpATjY1qdnYQ6fbPJibX6lMvcI4mZjOww+sTFZP/AAUXOAiIIx9YaGggsSdnqrfINVOf/i//fcQSiGlR+K1gte+gkwCeLwG4qRn75p9yLLo56K2xIjyi3+lYvhuMs/zyIl6GzbacxPR5mqvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu839ENpfOaf6POAIVkrWse1O7e0QTPpTSbY6bJRkyI=;
 b=Z70M63QRdwyr2xRp8sEKaONdXfpQnl/8PmZ2bqQKD+ESO3Oleu5xh2ieAXX2lgjbIWZZkSBsibFCvta9p6feEWajk6/+iQCtJR4DnTWBJKug3xwCHEEG0pq+2J2t1GOhp0/E8tLoNaYH3sITL7uAZXgLDDdqzJu86HCgB9J/ZYqtnDrttyaOL/RqcR+5x+gWcoLqeWmEIueAtLXONONXZP2J+n5GcdTx465lyZn3degWhllGL+sVaTIPmc8Ph1ahZuCAiG8eSNpy88H09lsuqJj7p/7cy57DevGQEP3mh5wbzRwFOULzn+KaOo2fmvX9q78gHKxwzdETKWwC+JIi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu839ENpfOaf6POAIVkrWse1O7e0QTPpTSbY6bJRkyI=;
 b=yAUUuZkVgpekB+zohbt89Vb7HaxhucSiwSFaBIuXcE1q6Jd6o8tltfwfcN2VOfx/R2kL8aioOJEuP3BCtXRtBxXCJbRmdqidC/g5G41Rp/GFSZFjZIlLWkr5yxIimTT3E5CJU9Ligge5SddhRnyX2NkRy+oGhCoB9WwQFRZd22I=
Received: from BLAPR03CA0157.namprd03.prod.outlook.com (2603:10b6:208:32f::27)
 by BL4PR12MB9477.namprd12.prod.outlook.com (2603:10b6:208:58d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 21:49:40 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:32f:cafe::25) by BLAPR03CA0157.outlook.office365.com
 (2603:10b6:208:32f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Thu, 17 Oct 2024 21:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 21:49:39 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 16:49:38 -0500
Message-ID: <47168a34-f0f8-457d-8acd-88f0dd3ab914@amd.com>
Date: Thu, 17 Oct 2024 16:49:37 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v4 08/26] cxl: add functions for resource request/release
 by a driver
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-9-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241017165225.21206-9-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|BL4PR12MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c3501f-3be8-47b5-3a47-08dceef59a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVobWVKQXk0S1QreTNweUJJRUtNRWZCckNkNkRZbW5RN0Q0dytxQ0Fpd3J4?=
 =?utf-8?B?VFpnUlZNb3g5eURtUVFRdzZCMmd2QkRhSDkvSHRqY09Tc21qaFJDR2hNTDdF?=
 =?utf-8?B?akZmQURFbnA1RGtVY2R1NU1PN05XSlI4OFpRaFppbCtuVk5xckxQR0pwQ2o5?=
 =?utf-8?B?bm9vRy80K1ZtMVlmamxFM0NycGNIYk45a1lidDZjVjZjYmNRSEprZkZhVlhk?=
 =?utf-8?B?N2c3ZFpldUtUM2tzQ01ZRWYwbmduY2FKcmgra01OZ1JmYnVRWW4waUphRWFn?=
 =?utf-8?B?RjBJWUplcnJqYVlUTXBBVlI4MDEvaDNqS0djVUd3VG45THlVbXl5S29wRkx6?=
 =?utf-8?B?Q09IMytQblorSmtvOUIxMVIwSnYxbmc5ZkJoZjg5Q2ozSytoUzFRbGtZdUJp?=
 =?utf-8?B?N05FL1J1QW1HV3lmOVgxT3REblNKbEkzb2NEbE9mSW5DRnVsZW9QeHczazd3?=
 =?utf-8?B?dkhWeU40aVZwOHlSYmRpZzFoRUNwOW9uYWpXMnY0VDJGSHV2ZmR4S3N1b2FZ?=
 =?utf-8?B?RTB0UGlwNkl0V0IwTVF5SmlHSHRlQnNsSnQ0cXNHN3hiMmc1VmVsUkZGS2xF?=
 =?utf-8?B?QlRYa1dQb1kwSmxMeFU1Zm12dVpoQ2lLTkNoZGRSQm5uRnh4ZENCYmZkM3Fs?=
 =?utf-8?B?NGhONFZkODJsNVUvcXo3NVpyVnBQSVVRRHVkUDRwOTlGR3AzdVR0WnRvMmVq?=
 =?utf-8?B?MnVvMUowSGR0VVR1NWQrTWd3WHNYRHlrTE9RUmhRd1poRG1udUg3OUJPWG9K?=
 =?utf-8?B?SEVxTnUyN1Z3cndlcnQwUmhMZWVzR3M2SzBTRmFUZDBsSG5pU2U4N1BvOVln?=
 =?utf-8?B?YnNDNkJ5S3VoOUthVGdMNmc4MjYrNTZHUDl2L3dndU41RXNmc29iR3BDWFd3?=
 =?utf-8?B?WW1RZUV0OTU5UUJqZVQwdElpaWFwMno4S2JBZGkyWVA5OFI3Y2VrUS9DNjJ3?=
 =?utf-8?B?Y1NBZG9NWnFibnQ3VDY5Mm51MUVxUG44aGdGSE9HZXYwYVlWQ3A5ZTVxRWxk?=
 =?utf-8?B?Q2l1VzFBblQwMTgzWUVXQ0d3UWx2WXJRY280OXNTb2l3ZHRKN3QxcUE5WDZo?=
 =?utf-8?B?QVRwT1g2aVgxZHV5NnBMMEZ2eVFQYU14c3hPVUJ5V2ZpNmRxQWloK1NSUS9N?=
 =?utf-8?B?bnJFWmxBVWxLRzJ6QW4rQkhTU0drTUJqd0hVRlpzcTZ2Z0VQcS9sVml0MVdj?=
 =?utf-8?B?MFltWUFXNlcra21kTEdBWFArdllIUHRvN2RDcTZYTVhXWUhjNGwzVUpNSE9B?=
 =?utf-8?B?Q05mY1k1UDJuY2wwbi9xUmxlU2NRVTI2WXpXNTV3ZWtBT0ZySWFmdzFEZHky?=
 =?utf-8?B?eDY3b0Iwa00vbVE0UDJKR2V0QlhkNTRHbU0yeWFZL0tSNUhWOW5GOGdkRTFQ?=
 =?utf-8?B?SUNjV3ZjUDVlZVczMkNaSUhUR3pBNkJKbC9UVG1GV3AxYW9nM21sV3Z4QXdV?=
 =?utf-8?B?SDVKaURnSDZOS2pCR3R0UE5GbW5sd1NEMkt3L3BDd0tXRmtYUWlXaE9FNHJt?=
 =?utf-8?B?SUlBRHQ3SzNBWnlzY2dYMGFWSmtVRldUNlNoYXZoOWxac0k0M0hDWFByZ1J1?=
 =?utf-8?B?Y2pta2k0RkVRWUNHb3haTGQ4WlZnUy9WcWJPb3dSMTVUWlhXWG9FMVdmcUV1?=
 =?utf-8?B?WFZ3cjdqSHA4Z1ozYTFaK1ArTXFjMG0wczZaSjUxQ2VvblJJN1d3ejNzSDQ2?=
 =?utf-8?B?UUZhejF4T3djd0dYNkF1ZDNWc25ESnJyTUFjTXBURGJZM3R4SXY2VG56R0NR?=
 =?utf-8?B?a1p3QjRtNEJPTjRwVXR3dzlrWllZQ2lWY09RMVdISWNrbks5L0VuVjMvVFln?=
 =?utf-8?B?ODJtK1dvTE5QTlloSmdkdjRqQzRTM3RkMnhmcnpKVkJVZzlKWGJRTi9CL1J6?=
 =?utf-8?B?WjZ4cUMva0JpdlVMT0R2QkNKQ2pEcTJDSUZXWURIL3BKUnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:49:39.9082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c3501f-3be8-47b5-3a47-08dceef59a1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9477

On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create accessors for an accel driver requesting and releasing a resource.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cxl/cxl.h   |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 94b8a7b53c92..4b2641f20128 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,57 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>  
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_RES_RAM:
> +		if (!resource_size(&cxlds->ram_res)) {
> +			dev_err(cxlds->dev,
> +				"resource request for ram with size 0\n");
> +			return -EINVAL;
> +		}
> +
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
> +		break;
> +	case CXL_RES_PMEM:
> +		if (!resource_size(&cxlds->pmem_res)) {
> +			dev_err(cxlds->dev,
> +				"resource request for pmem with size 0\n");
> +			return -EINVAL;
> +		}
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);

It looks like add_dpa_res() in cxl/core/mbox.c already does what you are doing here, minus the enum.
Is there a way that could be reused, or a good reason not too? Even if you don't export the function
outside of the cxl tree, you could reuse that function for the internals of this one.

> +
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_RES_RAM:
> +		rc = release_resource(&cxlds->ram_res);
> +		break;
> +	case CXL_RES_PMEM:
> +		rc = release_resource(&cxlds->pmem_res);
> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
> +

Same thing here, but with cxl_dpa_release() instead of add_dpa_res().

Looking at it some more, it looks like there is also some stuff to do with locking for CXL DPA resources in
that function that you would be skipping with your functions above. Will that be a problem later? I have no
clue, but thought I should ask just in case.

>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 2f48ee591259..6c6d27721067 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -54,4 +54,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *expected_caps,
>  			unsigned long *current_caps);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  #endif


