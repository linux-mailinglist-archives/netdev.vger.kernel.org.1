Return-Path: <netdev+bounces-136765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CE39A3011
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768361F248AF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A91D63E3;
	Thu, 17 Oct 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hc7pYkdr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF11D6DB7;
	Thu, 17 Oct 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201827; cv=fail; b=ftZiM1zfzEUBF1r0bhfnXJU4hAwnVPhFMMJ9DI/+z6rB/LbODu3Nsr1oQIXBBsseeW6PDuMJJv9GxKNQUUGRtjUfHZKOMqY8KYIxeFJqyWww6W9TiDyq4GvWS5hWSwYsIh1m/vwF/lU+E8zI3PEMbHla+AvG67QiE+aTtAltA6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201827; c=relaxed/simple;
	bh=KDjPJ70nwbRT/Pfo/7nxiwnSQozoEhe8nzys4GuWpQw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Af8lZtSjY2kk/peQI5p4H9CioJwRazVMFYZHFI+1FQNIJuuAUFZ7NcSVJSpGLgbS9RsBXInvqJQ/43yxNDbjvIqBGuO8dEUaxKWY8lIJw9G/6TbDCm+AGBiylTHQUwRudluEFnpL/5BxBe/aQNpHJOH/EWjE8shLba99ECUmol4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hc7pYkdr; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOkaKUlHy0F2z+nFjIZtEkUZUDiD9JH9rpwFxf69jo7/7zUYtyt1sTWdBokPpn1f7x9AvbJqbrtG2mnTha8oiJJHRqXPUHBhq2iviK+Sfp+wt9/xn+LaH6czkze6oi4SyeKzA4BSKS1nvdq4pr/cpPZ0Sn/ABlHHxSUy0UsmCvFJHvA0vU+n/drQPmwNoGU40xY/vdo60Gw0aHd7ic9sZSnlQAMZDWvsH//vg68cko5Ty5zxLySUp2LeBCgrmCV2lSjx97cPeNDRINOQ2owphPHYuz0/oBPM8V4/RHNM76n28IEQo9DOxiJDwyrprAn/J9y+nbirHJ51LYbYzq9JFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8R4uj7EfoXFx3WqFfku1xpc230gb+dvpN6zzLgu3As=;
 b=HVJMWL9PjQnzPDaqFHP3sTRDpWIKuK7JbQxMRIvXzMXS3/ZPj/GReNouJyqEUMa1sYCIMP/6HOd6m1G+34cw0X2uKZQ5T9aVCekyRpaW/QMjbToVZkyZaiylIN0w/BR1YJ8Rw7CBR6NEtQAVNy737vrAle8t4NNe80fPOfJPejGOgwtu1+UF78jcLKSMmar4d/e4B6fwU/B43cDtz7bt/WbRd5Rs+vXHPcMF3Kq4vnMdlX4y4rOeHiZwaZ1NKkdj0+39iFj+2wUnGYGqNCinczbkzX82CiBENNLFPM5oSN4nAUsTvOR2cDnrXxHrZGlPb7RIlaVPRXpZJc72BTIcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8R4uj7EfoXFx3WqFfku1xpc230gb+dvpN6zzLgu3As=;
 b=Hc7pYkdrZJUuj5M1RTo+OPcvDZcTb+Gw4q6IWOu/LuWDnBz72ZBcCkjg+x1a9Zfvdd2SyyCrlgh6lSpk7vO8fiTJDyfa/24vaMXOK0kcnC0/bPiQQXQFwAUCSjCX9oFS2KVagZP3hRaAEqzlGwhw24KqBGqTzZ4EzJ4YDMmcWMM=
Received: from BLAPR03CA0152.namprd03.prod.outlook.com (2603:10b6:208:32f::16)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 21:50:16 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:32f:cafe::a3) by BLAPR03CA0152.outlook.office365.com
 (2603:10b6:208:32f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 21:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 21:50:15 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 16:50:13 -0500
Message-ID: <ae59e9a4-a4f1-4839-977b-b667d927c647@amd.com>
Date: Thu, 17 Oct 2024 16:50:12 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v4 24/26] cxl: preclude device memory to be used for dax
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-25-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241017165225.21206-25-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 955191f1-123d-49c5-c03e-08dceef5af61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVpNSjY2Skt5OWtqaElrbS9wSDdwQ3h0dWFrTEVEOEhhRG56K0FuUG9RQ0hu?=
 =?utf-8?B?NndIeUV0c2tMZmhrLzkzNjQ3bUEwcjUxdVNOMlhKaVpNcitWRlRxOFZseXlB?=
 =?utf-8?B?MG56Vk9hZXJ3MUlnVjZwVzZnTmV0aU5ZNHhKRU91aSs2VXRGWHV1eURENkpa?=
 =?utf-8?B?bGNaRTJLMGY3SkFaZThnVTVqWXRabDNNd1Y0VTNHdlBhcU4vVFJidndTd3dL?=
 =?utf-8?B?cmlkM2NUbnp6eVFJeC9OaXFGbU16dDdJMThQSmoyTTdtd0RhanFNMkY2eWla?=
 =?utf-8?B?RmlpSExvOHh0ekJ4elgxTGE0WVlDV1lUaExWK09yUnZIN0JFRElrVEZJM3Qv?=
 =?utf-8?B?K2lyY0lLUG5FKyswRWhJT0tSZG5nZlpDUXV1clo5NE5jOW44ejJFRGY2N3U5?=
 =?utf-8?B?MFlONnU2K20vcjZrQTdSM1g1VlFwUEFoK0FoNWJqMDlsdGxVWEdzeHZTbE5V?=
 =?utf-8?B?cUtwaGl5SzE1UkZBZGlKSDRZQm9IbzVCcnJMN1dKV2FKVHhvcTBIcUNLYVRp?=
 =?utf-8?B?WGdkZVBUOHNnSkhhdXdKS0xFd0pKWi9ya29FdnlUc3N0MENOSlBLbUFneS9y?=
 =?utf-8?B?eWJYNG44QWcyaUJuSDNicXZveXA0UFBsWFo3TFVjRTRtRW42NHl0eDhpTW9M?=
 =?utf-8?B?ZVR6TGxzbDF6dnkyQkNzcGMzYlNYMWFWVXRPTnA5L0ZiZFVtazd5VTRoanhE?=
 =?utf-8?B?c0Q0bDlkM3d4aTBXNEFSc0JBZllCT21ML1U4Y1RlUXM2UWNBZXBNUGF0Y2M0?=
 =?utf-8?B?VFNNN1RKdlIrREdvVWMyMDRuN3VTWllvN0l6bEtjZ21mWHBFRGFET3E1Qzgv?=
 =?utf-8?B?d2lFQSsvWi9TZTRIWGF4NTZDL3l1c1BtSDlWVnNRcDNTSjkvbGZ2ei9qci85?=
 =?utf-8?B?aTVUZi9HdWY0eGJCaG44ak9vTFhEa2VGTWRCUW5oYXhTVlh0REl4NGU1ajkr?=
 =?utf-8?B?akpmSk1jWXZPN09hUlRJMjYvelJqVU9QQjlkSG94d2NMK1d6d2JTNVZWZ3E5?=
 =?utf-8?B?clR5Y0V3dnIrWWNFT1NCL05HcnBuMDlxQS9VeDBDUDd3ZkJpTndpanVYeWJo?=
 =?utf-8?B?N3RYZGdsSzc1MXRxbGJ6dUlqUHpKM3FFaTRQV2IwS2JRVVc2OGRSempTNlJw?=
 =?utf-8?B?THMweGcrYU5DbDcrOE01UjNCUzBCSmJzZklXdm1zblp0UTFJRFZVYlpJZENX?=
 =?utf-8?B?eE9FNHJKMjE0bjVWWkVld3pQQU9zSTByN3lCdFlCaFpFaERzd0plT2xjREpJ?=
 =?utf-8?B?K3IrSHFYTDZ4MEE5Zis5RkdnN3c3dC9tbkQrWUxONHlabTZ4LzlYZGhUTHdl?=
 =?utf-8?B?T1kxM0d0YUpYVnZuVnBQLzNEbzIxKzFocENpZmpudEJ1V3M1cDloM1J3azdz?=
 =?utf-8?B?S3BwWm04RmE5N2pkYmMzT0ZDeTdjSUp1YlVBSkE5S3V4aWU5bDhlQUJQWTlz?=
 =?utf-8?B?VW12Tmc5ZWQ0SG1ZZXByYThSRDNoTGtXaEZaV2tlYjZNRUJma3dmOEFXY2NZ?=
 =?utf-8?B?ME1FMFN2Q3JURXZWeTRwaU1EeitWQ0JBSzhaT2NrOWljT3BJNndpdit5enpX?=
 =?utf-8?B?b3YyMHk5aEpNUkZqa05USU95ZUJXSzdwSlBSdGU2MnZ2TDRWL2xHTVJWMTl2?=
 =?utf-8?B?NWc0RTEySExtZ3E0UGhyOXpJSEMyWW1PQVVCMzByVlRhOTRqUGtqa0RiQ0ta?=
 =?utf-8?B?TXRRMTZOVzVjSHAxc0NxSmtxUnVBM1lQTmZES1NEZElZYUpSeWo2SHE4RlFy?=
 =?utf-8?B?NzFiUXdsRy9VZ3poek5qcUluaS9jaGNqcFlEZnB0OGlTcHFxTE93eFlweS9n?=
 =?utf-8?B?YS8vTWR3bkdwS20yYUdXSTVmS0ErT1g0OHBBRmlBZ0VvZlh4ZnRhV1l2cEJa?=
 =?utf-8?B?N2VNL2NkajVnL2lWVGNLa3Jsb04xb0lEbUQ4TzBHS2tvc1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:50:15.5491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955191f1-123d-49c5-c03e-08dceef5af61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772

On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses.
> 

I disagree that this is a valid assumption. I don't think that the device memory
should be added as system ram, but I do think there is value in having the
option to have the memory be available as a device-dax region. My reasoning here is:

1) I can think of a possible use case where the memory benefits from being user space
accessible (CXL memory GPU buffers).
2) I think it's really early to say this is the only way we expect these devices to
be used. The flip side of this is that it is early, so we can always change it later
when we start seeing real devices, but I would vote to keep a more flexible structure
early and if no one uses it oh well.

My idea here is that whoever writes the driver indicates whether they want to make
the device memory device-dax mappable, or do it all manually like you are now. I've
been working on a RFC based on v3 of this series that has this (as well as the
"better" solution mentioned in patch 22/26) that I was planning
on sending out in the next week or two, but if the consensus here is that this is
not the direction we want to go I'll probably drop that portion.

Thanks,
Ben

> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 04c270a29e96..7c84d8f89af6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3703,6 +3703,9 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_DECODER_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_DECODER_RAM:
> +		if (cxlr->type != CXL_DECODER_HOSTONLYMEM)
> +			return 0;
> +
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'


