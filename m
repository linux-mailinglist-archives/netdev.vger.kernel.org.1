Return-Path: <netdev+bounces-225386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B874AB9356D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F91162FB8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA325A33A;
	Mon, 22 Sep 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I4w2Xu0j"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987D83A14;
	Mon, 22 Sep 2025 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575377; cv=fail; b=AZLEt2BEoGIzZVi2TQwsps2iq3AS8YrBYyrUiMPme0BBzfE4FiTtg9jlL+waPJLaRABncvNq6enCyLXdZo/3VBjach57y9XGQ3TcqLng6ssfUG/9LiKUWVLNpJ7Use87RDTUz9jHpmP9XKZxu2ncYHszuQeI6UW4jL5hrfRu130=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575377; c=relaxed/simple;
	bh=H3cVwbN8Qdhn8VGp5lYYl2siofX7c7nfuAHSVVD35l0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=cSKzBLC1hNtHOhFUraWKRkQjPko5LD/wXxue0WyjoIkwZHLU6/07BdpXXvuhBS6uZD7dguNMUbstQ74FNvOY32KQVzzkRKInx2VBmTZhSp7J1VjaTwOeqP8QmU+MhJiB/DYaLqgLPNec3jo0yIXMlcWaKXyid/xAZhYlCSUp5R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I4w2Xu0j; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/phywIVSB/yQJ8j0zuKAzm8CgPrRmbkp3RgsYauWLZ6hmwYrcvrQnIDESDjvNPuPICodnrsjWs6ldKy2w6asNJTtHYxIkVmnQhb3cOOZTpxnwOP44mpVfOQVET8DbkyXR55++Q5BO3+JNYsTblGeQxF8yLkB8kJ6NKnXpkLvzUXIb/fag15IhU6q/s6eEkhOrg94bRF3cgBLQC5rE4tJs8sLeXIQCWxzSYyeigYY5/rj20Th89vlK9nbGzbXPPIr0niXK1QoaeGuIsIIU0CzZVNCCHKSRrgmpqsKXg56VAO2sjH6s03xXmKwIMnlBcxdf7EGUbJtwMpZR0srQIyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTB2OiyT/f2KenE0nD8KUNsGhEgX1pvW0r64W16ikuU=;
 b=c0jRxCtYAJ7GDWPkZeAlnb18EAhi2057U4BFdqw8cbKhpxrPNbCc07kzfzish8826N93DxNxj5ZfMwvZ4byN+tbegsJaIiFpuAaLsvc20GtusrI4+ldZowYnyZiFvzxL4wkbNb/99XnsBUthZFHJvz5kR1tPQOVSAXTt9pjE0MPBvobBnD4MVKm/LvNP+K2DbOzGA7ehkZGBVrZYrpTLMsvVIq8IiqnAzncx/TP+lkmYahxZB7th+E+qkweFx+Tpg4HygJU3SnYEj1PrzEXlC7YLxiEZGyTHPteAhTKAvknf2AFhQh4jDQjY76t/ItahnL0N9LH7Jy8UkeUVuO/wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTB2OiyT/f2KenE0nD8KUNsGhEgX1pvW0r64W16ikuU=;
 b=I4w2Xu0jJUrT4iIHeMtqRe9KMXXlzYHYCJFfcBmYP/E4T+we/N2OqzRn3Xh9N6qLhkHUEmPpCcRyYCFm/9/Lp3AEwE0Nk2ZHJMb/QYayCbfikCHqsI/2ww6jfrWGWjyTKE6jj/mncWNyd9Jz+Zeu4c39so8l6gJxZFj0LxcISWU=
Received: from DSZP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::9) by
 SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Mon, 22 Sep 2025 21:09:30 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::ed) by DSZP220CA0008.outlook.office365.com
 (2603:10b6:5:280::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:09:30 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:09:28 -0700
Message-ID: <0a95bc03-883c-4c84-8131-7a09cdb90be2@amd.com>
Date: Mon, 22 Sep 2025 16:09:28 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 11/20] cxl: Define a driver interface for DPA
 allocation
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1d8c9d-2499-43fc-f391-08ddfa1c5248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clZRUGhnRStsQ1QyL0R5TGUyWE9tcFAwdE55dGFmcFVnQ2xYQlJuUUxMS0Ns?=
 =?utf-8?B?ZENoVi81eHZ4Um1RaVNlVmhsT0xCTnY1WlFQOHJ3cUtOMUhnb3pnblY4L2hW?=
 =?utf-8?B?YU1YZmVqVUs0Y3pNYm00bEUybUxFRFd2YS9Fd01TLzdadU5pQ0JSeEpzWWk4?=
 =?utf-8?B?eXB0aXNmYUkzNXJBdlB0Ly9renlvTjVUK2dIMGtaZUhUY3NmV0J2MVFUUE9t?=
 =?utf-8?B?bklBTzZFSzZnU29yNW96ZTRFL1pBWXhuZmdJTzNEUCtCaDhHYzBGcXpHaTFE?=
 =?utf-8?B?NlQyNWg1Z3dEUWpqT3lYdFA4UWFiZ3p5ZUdLVW9SK0FBUU5zWnZTdXM4OGdT?=
 =?utf-8?B?ODY2MWl4R25RL3VPdTdWZmxtK3Y3K3FkZmZ5cSswQnc3QnowUktuZ0dxRk9a?=
 =?utf-8?B?dk1MUk5TMlVJcUk3bVY3MzBoZFl6SnRzUDZtT1lzMWI2SUhxZEFQQkQyb3RY?=
 =?utf-8?B?Vk5pM0duR3BrTXY3RFFhd2MzdkNmTE5EZHZyNnNIVDJNMkJYT1dlcTRvVW9V?=
 =?utf-8?B?eGt5d0ZLdk5NcnNBUzRBcHh4TldWRDZMaDVJVWlvajluS3R6M0JzVFVhZE1T?=
 =?utf-8?B?bHZXZ21VYndnUVlycDFLOFFaZDE0cTYyZ21HMXRIVk5hb0o4dVk5MW1YMERK?=
 =?utf-8?B?clFyd3ZVRWNGSW5uc2pORUNmUlZ1WnZKNUNoNldEYVV5SmZtbUZWeGlZSHRw?=
 =?utf-8?B?ZWRsK0tyZWJKS3FSOTRzaHlUTmVjYytwTkM4R2FDem1MZ2E1SFNyZ2llTnRY?=
 =?utf-8?B?eTdJdXE0b0dVMDl2cU9HdUU2Z1BXakV5cU4yc2VNYW1EbGw2NVBDYVFmZ1hQ?=
 =?utf-8?B?eWtIekF6SFZ6SGgzbCt2VjF6ZmZOKy9XZXoybDNWOUQ1ekw2Smg4WjA1R1Fi?=
 =?utf-8?B?VW9KRGpFNzNQcEJiTm5VckUzV1p2a2s1R3VHbFNqcXpuRjNaeGV4elRkSWNs?=
 =?utf-8?B?Nld6SFVYN2tPTVV6Q2VQdndJL0ZRUklPcnJ0S1JxS3VXTWZlV3EySVNRbGJL?=
 =?utf-8?B?QXNsY1lDQkJUS3dnZFNUTHBNaE1qTW1NcE1mSHA2N3hmUTVoTkZhTldoR0FW?=
 =?utf-8?B?Zjd4ZmZvUWdFZVlodHRRaFMzZkQycnlPYjkwVEdrWXEzNmxad2pCMUdHbURX?=
 =?utf-8?B?ZldyUVJWZ2JrUldNWGFQa29mQTJEbk9QQXdMMTJ1dWluc0lNWTRQUmN2VGpu?=
 =?utf-8?B?Rmowb2V3RmV0OHBERkZsb2pwd3JwN0hDUHREWmdqSTlQMEtXK0o0cUtDTWJD?=
 =?utf-8?B?WmY0dFVuQmNqNlAxOEc4Y2VaWTk1bTdSemhidlY2OFl4ZmtzU2czcllKdWw0?=
 =?utf-8?B?cVl6UGtIazRZTXVydTNFMVpJSDAvL2x2MXZkcSt0cUxUR3h1T0M0NEh1dUJM?=
 =?utf-8?B?Vk5ra3Z2RTZXR0Z4SmZINnVyVnlOYjdqRk90L2RJUGVRN1NvMnRHM04wT3lZ?=
 =?utf-8?B?MGVqc085a25GT005QzdSNmlCU01LWjRyQUk1b2tqNldYOEV2MjBRYmhYbkpV?=
 =?utf-8?B?U1k4dHZqMVBmWDhXREkyMVNKUGVIU1R1Y0hONTh3QndqN0h0Z0RRQzdwY1VT?=
 =?utf-8?B?aWkrUDJtRWgzTGhLMklsWEpjdytSUitJaFlXSXFDcldKZk56Nm0yMVZYMDI5?=
 =?utf-8?B?Z05vQm1PMTFoa0s5aTl6QU04aDJKU1MyK1QzZE00QWJydExraVhlTks5RE90?=
 =?utf-8?B?UnZ2eGhrM3NCTnZaRTg0b2ZJZldDbWNzWDhTYzN2MS9UMVhWSm53Wlh6dW1i?=
 =?utf-8?B?WmxPRWdtYzQxWklLZlF0V09CVFR4RWJlWWxBbElURWNBSElIc1RwcGU5eGRz?=
 =?utf-8?B?MW5IR3RiWjFGdzVKQWVXc1hSYUM0c0I3cndmZVJGNjRBbXZtZ2ZWQTJSUU9U?=
 =?utf-8?B?SkJQWDFyMXpIMmdPMW4vV2dnQzE1c2I5RTJrQ1hOMVFLZVJrWHEzZGxLTFYy?=
 =?utf-8?B?NHNEeFdNMys1ZHZLcyt1OGVMditqZng1QmIwS3VtYWVZSTk3enZydSt5V3JI?=
 =?utf-8?B?WnQ0bFFLRkNYdXp4OXFhTlQySkJNMHA1VTZqSFYvYXJOeWxNWW5CQ2dEenZh?=
 =?utf-8?B?amJNMkVrS09QdkR5b2JobllGbm15YUNSSGR2dz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:09:30.2210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1d8c9d-2499-43fc-f391-08ddfa1c5248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space.
> 
> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
> that tries to allocate the DPA memory the driver requires to operate.The
> memory requested should not be bigger than the max available HPA obtained
> previously with cxl_get_hpa_freespace().
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  1 +
>  include/cxl/cxl.h      |  5 +++
>  3 files changed, 89 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..d1b1d8ab348a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,6 +3,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <cxl/cxl.h>
>  
>  #include "cxlmem.h"
>  #include "core.h"
> @@ -556,6 +557,13 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
>  	return resource_contains(res, &_addr);
>  }
>  
> +/**
> + * cxl_dpa_free - release DPA (Device Physical Address)
> + *
> + * @cxled: endpoint decoder linked to the DPA
> + *
> + * Returns 0 or error.
> + */

Don't think you need this comment; it's not adding anything you can't get by just looking
at the function header.

