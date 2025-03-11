Return-Path: <netdev+bounces-174018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D22A5D06B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D6B3BA118
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1BB215F49;
	Tue, 11 Mar 2025 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V52pHCi3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB29262819;
	Tue, 11 Mar 2025 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723621; cv=fail; b=N4hGzBp5v1azX2FGna1mQMUE/KVxC5MkdO2xCtok0NSk9Uf56dRmmFvSipXFuwOy+B5K5PYHy+3n3n+mg0vNy5fnn0ggjX7nNqOY/osKnVX0Xe88AxaVvwqe5zv70z41eZqLYkseSfxLB847JqZB1QOo5wiW5N9uT5Rv62tun/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723621; c=relaxed/simple;
	bh=MbzShwevOxijtgS5WP49YJN2XQWkl7IfXTS1VEKcGBY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=gUKG5PpHDvaVuUUFf8LOWIgp+R3ZlxVDjJR8q6sCv5FglgnaJMY1BHMuZKcg7do6p8m+NsamsrlPg/nz+3gWldHJB0FgNcBX0UB7ktmTvLUGjkO4PuYd/GvHaCqcYznVYBkzA1h82GNVnHSaGMlfsNFQBdycJOip+xPdp5koFcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V52pHCi3; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmqCbicBcgYUIonVGwR0bFzDbtRM5jZEU886IsuqTIOa4m2Vgof8KHIU/fsfhGLNiYj9z4IWHwyeJCBUye/1twSQxicnCDYPvh4ACsf4rAZQarwtUgIkftFYrobFWL7g8ZhD8lZZKKoTJOg480lG+8EBZ84FXglMDAnCp6FybtnfKIpJMBaBkQMIgDuBH2p+XTScR2IuR+0b63Gi08UdzeBuxNBl42U6I3QQSBiiEqk4t8RS4FejmSll2aPL6NVbkVxwLjg8NZBIhalHSDGzN5QUL5w99du3Skxt6yofcTcDcFvPXeWXKkzW1Qk2dpFb1rA0LE1u46pBehEknsNO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xn29+pFn2DENye0o8vyXty3ufpR+Mg91fUD3sudpe8Q=;
 b=Iz9+ZyU7Qq6ccfg0wkm3gDOxQhKXqV7/hu6msM/q7cqOnzHrjgMJibygJbni4cYOojFr7lZXBUVMXQfEJ+pKPKJJrGG/ri1zFYF60/J2Q0K/1fgWAaC1Bp204/vSZaCkxaMA4Wb8m3s0QqZMTrTrhClvZN90MGfldCtKP3H7tvYg2Nw9IsfEXexbNTTm/RqfWF/GF0mYkk8H5Yns++wH6vK65Aj0MBTHEO3Nru1KHLGNUjq7q1t3wh6b7x8RGkTAx9D6E8T+fpKJFbHV6LbVx582AAghssGzBSVSQ2J6hfHJppzOY4odomfqEOsKGyORjEnxByss9Jt9cGrU376ssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn29+pFn2DENye0o8vyXty3ufpR+Mg91fUD3sudpe8Q=;
 b=V52pHCi3/RgHxPiD4aQoUxdROSzNtPmsBzLG/ODUrgTWOG/BODD4YfPV+E9E4f3XhywcLUhH5uqUXxqIl5rzXIhIl6ZGYmLa/Akf2NLWqhq4deq4zLwE6QfoO1SulAe2wgLOHEXxQEZUR38osFTqlXvoITxTefSO9BzJvEI5W+I=
Received: from MN0P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::26)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:06:54 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::64) by MN0P222CA0024.outlook.office365.com
 (2603:10b6:208:531::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 20:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:06:50 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:06:48 -0500
Message-ID: <c5067d20-1804-4c14-b0cc-3e27b119f67a@amd.com>
Date: Tue, 11 Mar 2025 15:06:47 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 18/23] cxl: allow region creation by type2 drivers
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-19-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 0129f2d8-213c-41fa-9b95-08dd60d842a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlVLK3p5SjZWUExHTW5Rd2pwOEQ0NzlaT1E1RzJxc3hjYmdLM1I0MmhwcDBz?=
 =?utf-8?B?MDF1TG1EdTRRbTh3cWZmVXdZMVl2UlVCTSt5R2ZmNG5WY1RRNGhpSGRsVnpn?=
 =?utf-8?B?aEZDbWRSZFU0YW14aStLVnlQcUdNRGFTUGpDQVl4akVBQVYrZDhlbUQwdCs5?=
 =?utf-8?B?SkIzc2NGYmttM25BZG9nSU9ISlFDQmM2VTNOaEVKSk5naHRsbC9kRHFsdG1o?=
 =?utf-8?B?UEZuV281RkhhWUkzSGxYQUVETUhLQzFTUXh3U25aQno4OUdLNGFPTGxXSlhp?=
 =?utf-8?B?Z0szV3FIejlpeS8yU0N1VVZGMTdXOHJnRkozaVVQMWpReGxWZUQzc1liT3Bh?=
 =?utf-8?B?SmthTDhmT1p4alo3bUNhSzJ0UUdtSyt2V0JjV0puWnM3ME44M3RhNEpIeVVK?=
 =?utf-8?B?VHV5YmozdldSWTZLbUVnQzB4WWVscGhqUWM5K2g0cmRvN3RJM2JYWE04UDBI?=
 =?utf-8?B?bXN3UjNSY1Y3aEUwVkNERk95VlV4cEFwNEdFZW1zZEZrT3R4OEpjVy9hNnBZ?=
 =?utf-8?B?RVV5bGRCdTZNakwrczREbGRWbXZuTWNFQ3l5WW9HOWhzWlRXMXRFQXFPODBH?=
 =?utf-8?B?TmVzVnFCazAvanlISXkwcUZ1YUlzdjRkaElhTmlYSTRlVSsxM1NzMWhkbjh0?=
 =?utf-8?B?c0xUUm82N1NsK0plT3FiT0tKRFpLaURlTk92NUpVMUxNRXUvOUFHS1NoV1hU?=
 =?utf-8?B?NzhlbEhjTlhOQUtlcm9YKzYxT1V3YVc4K0d1SGhSQS85dGd4c0E0K0ptdFRk?=
 =?utf-8?B?MEtKSzlIZGI3L2FLcFViUkp4RmdCNk13OUlCNE9aVjZPV3NlZ3lJS1BETFYv?=
 =?utf-8?B?b1Q3elprZWZvcmNQZ2RaNkVMQVhiVUszRE55UlprUFlIVy9yZmpseHpxWXpM?=
 =?utf-8?B?S2pyYTMyS01LdXVSY3dZSUlVQ1VUYnYxbzR5M1VxOUJmR3VqbnF0d1R0dENS?=
 =?utf-8?B?UlVzNzRwTi93QS9TV2RCanFFR0FIdmVjajlXemV6SGM0MGRjZW55RkRGQ1Nl?=
 =?utf-8?B?L2J6ZkEwaThNT0pkbWM4U3pLZ0FLd2VYNjlkcVJZU2JURG40cW5nRlJsTjlT?=
 =?utf-8?B?R1dJMFlsR1ZaeDNpcVVqL0JjUTVVSmtWUStOUjFNM3RDQ0N2VFVDS1QxaXZq?=
 =?utf-8?B?Q2lWSlFQQ0l0YmphK2ZJVTVmZk4zK2xxa2E3dXd1NWdJWFc3TlIvR0R4QmF5?=
 =?utf-8?B?c2xqNG9HbTVvazFoYllReFpWQWFYTitqZE5UZXcxYjVKaFVBelY3QUJYOFhU?=
 =?utf-8?B?eHF4MUpKbmZqL05aaEsvYTNzQ2c5d245eVpEZHdhelV6QXNaNzgybmxEem91?=
 =?utf-8?B?YUJ6aHp4QW9sQWY0R3A0RFNhSmZpS1phQy8vK2RheFJrYTlnQ2tDSllkUHRT?=
 =?utf-8?B?SUhFaGFodU40cHJlRjU4WEVWa3k3SldIL1BYbUlJK0xKMENnVVJVM1JoMzhv?=
 =?utf-8?B?QWFPaiswdVlKeDR4WFpjVFdhQVJ4M3h2aWJKbk81bjhGN0dnSk4wNEtQMHFX?=
 =?utf-8?B?czc1SXdpc0grT2hTaENVcytvbEJGWlJ0cHZHRGtXOVJVNHpjWlVpODhob1M3?=
 =?utf-8?B?Yms2cVNZM212elpzdEl5VUtxcHFTNjRqN3FGQU5yVnlQcE1xei9uc3VGS1lR?=
 =?utf-8?B?UG03OUNLcWtyNWpHaEFxK0dCYitWMmFHWVYxbytFTy9ZemE0YVErZGpxc1NJ?=
 =?utf-8?B?YXZ5K3ltRmlOcFZ1Y3RYcnR2enh1SGJBekhPTkF6T0l5ZUlpRXN1aDFzbVRr?=
 =?utf-8?B?OVRaeFZmclVpRFd5OHFTWWRpd21GTWg4bkhPK2dmNEhkWVJtNVNOMzljYjBF?=
 =?utf-8?B?QVdTcFdmSk9mckkxeDFFTHBQTzBuVTBMM1paRVd0VktUTER1WmkyY0lZTnY5?=
 =?utf-8?B?MTQvamlUZGZuNGlIT3NicTNpcWdsK3NUempjMkdUcU5VbnZWVVVNYUJDSTNG?=
 =?utf-8?B?KzRUZHE2SDhyYTNxT1psL1pzbUZOQmd5aUtQQ0xNaTN3ci9wVnRhVmZVaWlo?=
 =?utf-8?Q?RDyIWeSLJ1Q3WknYT3Xu1vUA7Tj0h8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:06:50.3230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0129f2d8-213c-41fa-9b95-08dd60d842a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 133 +++++++++++++++++++++++++++++++++++---
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |   4 ++
>  3 files changed, 133 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e24666a419cd..e6fbe00d0623 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2310,6 +2310,17 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	return rc;
>  }
>  
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
> +{
> +	int rc;
> +
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +	cxled->part = -1;
> +	rc = cxl_region_detach(cxled);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
> +
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	down_write(&cxl_region_rwsem);
> @@ -2816,6 +2827,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>  	return to_cxl_region(region_dev);
>  }
>  
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +

Nit: There are a couple of spots in this file that call the above devm_release_action,
I think it would be good to replace those with a call to this function. You
could also get rid of drop_region() and use devm_release_action() instead.

>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)

[snip]

> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoder with reserved DPA capacity
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled, int ways)

Sorry if I'm behind the times, but is it no longer a requirement for accelerator drivers
to have interleaving disabled (i.e. interleave_ways = 1)?


