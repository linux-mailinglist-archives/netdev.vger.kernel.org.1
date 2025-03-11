Return-Path: <netdev+bounces-174006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA4A5D058
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DD61888027
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE95422F169;
	Tue, 11 Mar 2025 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P+mZlUZ2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018F1EDA20;
	Tue, 11 Mar 2025 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723516; cv=fail; b=qLgSedvMvLcH8ffKkksy0Kpf/a7aUofWXvqfWWQJdS9WEbScPlJqUTnkkNU8tihVjCj/zKBO0p7NThJg3bviG5jnTQRPnZW3HxMUtaCJw6Zw6V8dz76Gb+ehMJvRdQiFP0brGbc8Pcy5NPKXpZeO3PSZGIKkJeJoUJ0SjqzBcJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723516; c=relaxed/simple;
	bh=zzQLXJnp+2zJf9j1GW2pi6WsbvVJ97FOwHx4D03rel4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=HYWkEvUn/gy6LXL07XCLhxype81wpZynknXA+c1vKHwUXsz3NnJza9dNPGmFBjQeN/sYarZOpheOn1FB4KJk5H8Loq56e3zCfCVqo/uD9Vv+woB6niZi9WXbNX9bBj2JZW32mM5sUCDb+oKvsq3GeqwtXRXviyDWbjwRE856QjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P+mZlUZ2; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JW3BLX1J6cVvTpG/Ae6DJq2yAVtMMBmWuuycbsqLii5z50dWN+F8lylWjct0aKFBjoNobdTCJZ8DRTqlRuIBX8GaAlkIbqKLipJlUtu7zI7VNa2wqwbimW6bNfRiAxcOdooDesiLMCQpr1kqurIF37U3R+Ibp7aEHa9wG7v6y154OkZHA+igAWa0Pjczpcwlz07imyYGcFgBpPaDQVKqi0OKYul2d4hs2AJcA4Q9Xrs1Lisy07ggAafTCSZplgm/UtM/yj/Ybwayswq5agYGFOcxwd3VX0Vc0fjAHfoZnUuZkWhooN1SW/gm4J5SeSZiMQn7ttjAsvFt4lwyRN+OIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je75xAV1ZL6wEL9aPWDLWa/sTAP1b7By+imt8+gomBA=;
 b=hSr05sfa1gkfzJ+z2gSte2TGQAScnpYUapP//CgEWKAahlrZkL3L9GcIp6qj7/JWvm8jaaAZmpIGp+T+tzhp7rNSPZIH3eFXUOsSv+A/DUvxn0eaZ2NJTcIavu4G+uLFSsAZ9G7qbjj7+CF1DCRnrL+c4/TNVKoFoI/lSLa99krkH5JBL8cDsiesU5uGF/x7Igoh0pUMr9UEd9nd30XuJ8+8s5Qd4MeyG98KOjoL7caF264R8z8ulMPQ6BtusUscMd2rlNiGDIl2ttR/gMlHC3k81HWIOCjem4jhFph/KJolBh3HBLOJN1KG3PrAae9RKsduGb0kKx6e7nkNch7NGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je75xAV1ZL6wEL9aPWDLWa/sTAP1b7By+imt8+gomBA=;
 b=P+mZlUZ2poMOJuvwyP+UG7yjY3CLw6srk1XaJuN4C03HPRQXw8bpssKX5RnxY9SAiKOozPNPgSoUhzR3JhpUNCn1SDIpX6RTRhUhuj5ibMRZdbWJmpTlJs6rMFpgxRBG9+OF0bybIMZWq/NwKLjGKEroAYfy+zfSDKA/nTJUmnU=
Received: from MN0P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::30)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:05:07 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::5) by MN0P222CA0028.outlook.office365.com
 (2603:10b6:208:531::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 20:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:05:06 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:05:05 -0500
Message-ID: <bf26b669-860c-493e-8126-733615f47b13@amd.com>
Date: Tue, 11 Mar 2025 15:05:04 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 01/23] cxl: add type2 device basic support
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 883f18a5-7631-418d-44d1-08dd60d80503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzBlSW1weHJQNldLUkR4MzF1UkMxTHd6d1RMTVlvOHpFRWc0dy8xVGQ1aHVx?=
 =?utf-8?B?V3NRcjNXblc2Y2JRZGpSeG9OOVVyaitwVHpVM0NHWDRzMFJ2ZW90OWFqK3BK?=
 =?utf-8?B?QmFPQW1FNGM0bWJsNmhDMklDb2pQVDJocTl3ZDduTk9CeXhkaDRlWmJxMUhF?=
 =?utf-8?B?blNBaGFGYzVmaTlES01INHpSMnVDUDc3SWxXTzRnOCtRVXpndTBza1E0L0JE?=
 =?utf-8?B?SEVPTUNjQWYrUXo4S1V0WVVUTTZBSWRScTU0UmRhVHBYWmJwcndTdElhZkM0?=
 =?utf-8?B?ZGlXLzNER3lIaXNaY1ZKYXV5WkswbUthS3ROL2w4c21HUVBYMXJMVlRaalZM?=
 =?utf-8?B?emZDNjQ3MENyZElwUlVyMG92dzlldmV0ZDJRL2xobjRncGNuNHNzT0laVzBS?=
 =?utf-8?B?VUk3WkZsY2xGVkoxRmpiTTFGb2lwLysvUitpdzZrelZsaDNWOUU1aWFDZHQz?=
 =?utf-8?B?U05CQnlURllFWFk4Wk43K2tJMXAxOVB2M2hNYTlubmQyQWZpNU5qWWVQWVhn?=
 =?utf-8?B?WGlKVU1BeWZQZitjQ1RrMVd1aExrNmlWUlNlZnduT3VxZmVzMXdXRmJXMDg1?=
 =?utf-8?B?RWx5eXVuZ2oyOWRvNm80TWNBTVpBMkoyRzc2Z2E4VjFncFlGRGZNM3lwa0xt?=
 =?utf-8?B?N3hGeUJFQklaOTR6eVFWOFUwSEc2ZHo2Mm9JdlZBL3RpVlZHK2phM1dBMm8v?=
 =?utf-8?B?Z3IzMkZ3N2kxY2xnOTcyU0RKdGw2UXJIOHI0Nk4wMEFHanBwZU1vM1VkMGdP?=
 =?utf-8?B?NzdXWGJPMzlhNFJlY2NGdENLL3dRbnNJZkFDVDZ1ZlJuYmdWWFhuMTdDWDNE?=
 =?utf-8?B?dmE3dW5aMitqSFFqSXJic21GUHpZUzVsQ0VQbGlMQnVPdG5zMW1UL3hEMGwy?=
 =?utf-8?B?MDN2MXlGWTVDRHQzZWRpaDJCVDdjaVE3RGRjWHkyb3FtUXplN1NXMFhnNEF3?=
 =?utf-8?B?dnhBdTFhc2FYWFNwbXJZRWhBY1NjU2pIc3ZZN2x1NlVnRnBoVUNNenpCRjJ5?=
 =?utf-8?B?Mkk1cnNWQTFWQ0RlQkFnbk5GZXB5c2lHWlpBUHMwSXdwT0xqa3krSW1ZUXRL?=
 =?utf-8?B?UmxOTHhYNFJuN0E5U2U3ekVybnhYdDJmS1RzR09uWUpqY2J5SlBLTUR5b09N?=
 =?utf-8?B?VnRyQklzeTJKd1BhNk4xVzJZb3ZuL3lLYWdTODl2ZVZPVVRIODFUZ2h3Qll5?=
 =?utf-8?B?VkE0SXJ6TmlRS3VEaWlDWWMzalMxd1NsL0NOVU52UVB3QjY1Y1dreTY0YmZy?=
 =?utf-8?B?eU5vYU5iakpwUURNMDdiUGVzWTN2QmZMZGpvajlMemM3YmRaOWZSNzNBdmJK?=
 =?utf-8?B?d2VFK0NiTU1XZC9ON3dHYWN3SDVBQzR5YlhwK096alFWRStLcGlLeEtpaHdI?=
 =?utf-8?B?amhqV3hBS1dkS1ExWUVZQWg5TzFZUXpMVlorcW81eFhSQ05VY05tV0R4SWF1?=
 =?utf-8?B?VkR2M0kzMHdlM0VaeW04N1prenAzcjdZdzVmZDkzUnlNZXpxdEphVWRRNWQy?=
 =?utf-8?B?UG5wNld2dWgveERnOTRDcjlzTGVQQUQ2SVpudWxWYmFxR0NUamVRUnpmTjRL?=
 =?utf-8?B?eGJ6NlVTY3ZZc3NOK29PWUtYYUozazVTNHdJSWttcHo1c2g5dTJyNTV4RlBo?=
 =?utf-8?B?djFCZlJQTm9YYnN5KzJKUzFpODhUTEdMLzRGMkl2L0Z3V0p6Ym85YjU5ZFFH?=
 =?utf-8?B?TnRaL2taZGxKYW9kN1Q5WG50dWV3VDRtUVpUS3JYTlpRWXJZRGdEWU9CanF0?=
 =?utf-8?B?YWN5TDR2b0kzcS9RWWVVMzF6MGpVbWM0Y2FiMkZIYlF1YjdBeTNBazNXM3lE?=
 =?utf-8?B?YnpqTlVGUGZJQnZPdTV5OTF4QjhJSmw0a2I5aEU0SUl0b3NMemtqRlJOcVFM?=
 =?utf-8?B?L3dtSVV1VGlITkpiVGFwUlMwanptSFpxYVlUekxuSk5oenFydit6bVdmOFdy?=
 =?utf-8?B?QVJoWU50ZGtGcVFNWWl6aG9mQnBCQ3VMQnB2RFBwN2RSelVZVytMNWdLYXNt?=
 =?utf-8?Q?eE7NTUT8sz30g88XOw7OeKB2/Wttxw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:05:06.9312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883f18a5-7631-418d-44d1-08dd60d80503
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/mbox.c   |  12 +--
>  drivers/cxl/core/memdev.c |  32 ++++++
>  drivers/cxl/core/pci.c    |   1 +
>  drivers/cxl/core/regs.c   |   1 +
>  drivers/cxl/cxl.h         |  97 +-----------------
>  drivers/cxl/cxlmem.h      |  88 ++--------------
>  drivers/cxl/cxlpci.h      |  21 ----
>  drivers/cxl/pci.c         |  17 ++--
>  include/cxl/cxl.h         | 206 ++++++++++++++++++++++++++++++++++++++
>  include/cxl/pci.h         |  23 +++++
>  10 files changed, 285 insertions(+), 213 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d72764056ce6..20df6f78f148 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1484,23 +1484,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec)
>  {
>  	struct cxl_memdev_state *mds;
>  	int rc;
>  
> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +	mds = (struct cxl_memdev_state *)
> +		_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial, dvsec,
> +				      sizeof(struct cxl_memdev_state), true);

I would use sizeof(*mds) instead of sizeof(struct cxl_memdev_state) above.

What's the reason to not use the cxl_dev_state_create() macro here instead? Based on the commit
message I'm assuming it's because it's meant for accelerator drivers and this is a type 3 driver,
but I'm going to suggest using it here anyway (and maybe amending the commit message).

>  	if (!mds) {
>  		dev_err(dev, "No memory available\n");
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	mutex_init(&mds->event.log_lock);
> -	mds->cxlds.dev = dev;
> -	mds->cxlds.reg_map.host = dev;
> -	mds->cxlds.cxl_mbox.host = dev;
> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  

[snip]

> +/**
> + * struct cxl_dev_state - The driver device state
> + *
> + * cxl_dev_state represents the CXL driver/device state.  It provides an
> + * interface to mailbox commands as well as some cached data about the device.
> + * Currently only memory devices are represented.
> + *
> + * @dev: The device associated with this CXL state
> + * @cxlmd: The device representing the CXL.mem capabilities of @dev
> + * @reg_map: component and ras register mapping parameters
> + * @regs: Parsed register blocks
> + * @cxl_dvsec: Offset to the PCIe device DVSEC
> + * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @media_ready: Indicate whether the device media is usable
> + * @dpa_res: Overall DPA resource tree for the device
> + * @part: DPA partition array
> + * @nr_partitions: Number of DPA partitions
> + * @serial: PCIe Device Serial Number
> + * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @cxl_mbox: CXL mailbox context
> + * @cxlfs: CXL features context
> + */
> +struct cxl_dev_state {
> +	struct device *dev;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_register_map reg_map;
> +	struct cxl_regs regs;
> +	int cxl_dvsec;
> +	bool rcd;
> +	bool media_ready;
> +	struct resource dpa_res;
> +	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> +	unsigned int nr_partitions;
> +	u64 serial;
> +	enum cxl_devtype type;
> +	struct cxl_mailbox cxl_mbox;
> +#ifdef CONFIG_CXL_FEATURES
> +	struct cxl_features_state *cxlfs;
> +#endif
> +};

What happened to the comments for private/public fields for this struct that Dan suggested in
your RFC? If you don't think they're needed that's fine, I'm just curious!

