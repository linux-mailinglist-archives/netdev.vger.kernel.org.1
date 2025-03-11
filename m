Return-Path: <netdev+bounces-174009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C83A5D05B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C461896EE1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EBE23817A;
	Tue, 11 Mar 2025 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hviC5OER"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28141EDA20;
	Tue, 11 Mar 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723547; cv=fail; b=H/50+IqaWZmTINNuceIjq9oK/O8Od58Ym1BaYIUu+ET2bxldnxh9aV2U5z2N6qqvbSSGE3cVjYUuLSLhsLieb2YkB0eVIGyhGdnsojKuynwJL1Oy0afX3+LAyWFsBbLZVsfmje4jxs7WJIr8ejeP3HIh+h5oh3wWGQviEg/Wo3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723547; c=relaxed/simple;
	bh=L6l2faqfJia9C3ARHILMCgAxEYlQjnyJS+dK33ounes=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Z2tdSrDtkH1ni5hMG1dmNDxOr4HrPKKEu0cobtJQ2L0erVqLkpghmkoQEhU2i5J2yX1yQGewWnuJefFTKs/ZapgXi1C1EzEKOT4RTHFPFvrIymLDPMdcMaABt5UNU6/8wexdaBChXwXxcYTYKEVoWvsYsDhnsZ8NmZ+R10holXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hviC5OER; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYDWU52Pqb4WXVbJ9cq4yUgzj7IX9sbWgmFo0zAvEB82J6FIyOX/BDVW97uLO9PPyPmUEejrTwcAx6NQwa5tqo77C6Xkzqc46XLwSz+A1+OG/FsPZ4p0+m34fkn6iWJtWK02RKsEatWc5Do47V9A3PIh/pag8PbA3YHIvsqt0JwmAuhRNJ+7mHhSrbNeN5yJT/QyFToXPgjvXvAf9U5vKv6zkXaCziYS5eIeS/RK/MKChj02GBrn2kKz5G+bH78Vis3oMggHb9uNI7rR53cFUQw/BwmE9BfVMI59tDn310StZIVk9NN/tECBBwy1AWwRAZhs9koh3uyqBO7ITsXZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1jPJHtYtMEU5q/E/5HhbsNhBYizQFHGX8rKIm10Eno=;
 b=b7hPei/SVhlepZy3T5PUHzEqreCSGuSVRWrdGiyilMJIzbHy9ak1WIKwV20u3OwkZlsRDsWbZUb5RS5xFnZLjHtcoAnmZTSGsaO6lXx0O8JKmNhpO+amoVT3EqN/rmW3DZQIKgkzsGHJAW2t1jQgwaxeHh6y/J+yJtEvFAwotcj6+RM9YTFh3UdCBvs8iJJ023V3GHMsVHOsbGV9ivBoc+uD08ItICbsEat4254xDJJj1DrIiddXYM644eLA0lUMbryF7BF8LLGlVTTkKEHPkDYET+0PSyQnxq54AFSY3H4eSBrStdUtUCHMVxngFnMZFjjIjOq0EN3xEpHIevgtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1jPJHtYtMEU5q/E/5HhbsNhBYizQFHGX8rKIm10Eno=;
 b=hviC5OER2OBMPAr84alVaGdCxXd72e+4RpM2gpkGZ6BgFAqV/UMfzKOEZoC77FBkiaP2WuCe0M2h7RONWv71rcVLqXbcoKK7p4SuzOf7xKSoKtUCTJcvPsL0Qvs9OXQSQHF66NwOhSj7NOlW50AtgGqTDCsZTbemTCiIlwFpo+w=
Received: from MN0P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::28)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 20:05:41 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::c6) by MN0P222CA0021.outlook.office365.com
 (2603:10b6:208:531::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 20:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:05:41 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:05:39 -0500
Message-ID: <e0ec21cd-bc12-4fb8-b89b-1d293cd9ff96@amd.com>
Date: Tue, 11 Mar 2025 15:05:38 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 05/23] cxl: add function for type2 cxl regs setup
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-6-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6756b7-4b8a-453a-28b6-08dd60d8195f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTBwZEh0SjlqT2Nsblg3OU5HZ0JTMXJUazVaZk9wZWN1NzZ0d3dJdGRiN2Fx?=
 =?utf-8?B?ejJXcHhCSEgvYjlwQ2xRS2xOZTQwZkkvY0FrOVM4YkY2OUF1cXFDbnVFYk9i?=
 =?utf-8?B?SEFQbmVuUDU5S2pTTHd0ZmdXaGRtb21FUkJZUmJCVzlKSjc2ZnJuc2wvc29u?=
 =?utf-8?B?VnI5cXluSzdycHRiWXh5VDZSckxwTnhxY3Rlcy9OZmpicGJkeGMraDkrbXZ1?=
 =?utf-8?B?YW4wNlZ0M1hiTlN4L2xpZWpLRjNRbGVRRFJTdXRrSWRka1cxQmlrcWYwc3pX?=
 =?utf-8?B?aFBrSkJEVFBLZEs1UWtaR0lHY0Z6WGRZVUZmY0xqcEE0N0xjVm1SNHR6c09K?=
 =?utf-8?B?eUprSEZvd1BlbTVwcnZ6aHNTZG11dUExd2FRTDdFamcyb1NMNm1TOFhsU05V?=
 =?utf-8?B?MVF2MkNBU3VmVU5tTG1zVDRuN0ZWL2hsV3IrVlNZcWkzcUJqR2pmZ0w5cU1U?=
 =?utf-8?B?NHNkeExob2dCNkYxeUNxSG1XUjJmbmNyZnZEUEtwL3hocS9MSWpmaElqZ0Vl?=
 =?utf-8?B?NTE2djN0endURjhrbWJ2Q2hKSWhlR2R2alBES0Vkc3dzTEs0OUxWVkF0c3Jk?=
 =?utf-8?B?THhpdXk5cjlNRVdUeEd5cDIxb3ZjbllNOG5kb1BFbzJVc2RZOTVxOSt4YW1H?=
 =?utf-8?B?anZCbGJ2WFozajg2WXhDN2kvREtKalgwL3pJZ2JqN1N1Nkk4QU9VZldvdVMw?=
 =?utf-8?B?Z04ySHdlTTlPNVpjbXQvdFlzQitOS1B4amFIMEZMVkhmUHZHUmQrOVk1Mnhu?=
 =?utf-8?B?QzEzYytYaW1vSEJuZnUvUDJQY2pOd2xEUE16SlFDZm5jZ2lOcVpKa1NPdXYy?=
 =?utf-8?B?Q0kvSHRGbURLSmhIYVhDV2tKdnRkWk9mOGFnVFdRNTArSFl4VmhEVW5rY0p3?=
 =?utf-8?B?TGp5QlZqMVdraWk3YnJIYzVBZXJmZm9BdE9UOWhWc0JMS2NXcHpjTExNTXVt?=
 =?utf-8?B?MXJhUzJHWDhhZXlxN3pZMUg2QUJYTTNsTDhTdUZGR2FyVGxrcldCY3pxTXk3?=
 =?utf-8?B?V1lrcUNlN1ZoVTkxZ2RLekV5Z09HeHMwSE1VajBSc2VFZXB4OW9hVEQ4VnlX?=
 =?utf-8?B?c0JsMUdVMzhweGxzZGpyRDlrcTZjSlU5R1hNYmo1bndaRUNVWTVndUhmcThy?=
 =?utf-8?B?YWpVTVJUdXZkWHFIQ29ZdnV1UXBENXFIdUFuS1JyMjRWbXNKUVdOaGhaY3Y0?=
 =?utf-8?B?eHZNZEZweHd6SHc1WTZ6V1RFanZVQVh5dUVRVUg1QjJNeEU5bTJXSU9mbk50?=
 =?utf-8?B?VTdpRzlmRDZIaVIwK2hXTTF3cDV5NEllYzdZTTQrdGkybVNKTnlDSk5TYXhB?=
 =?utf-8?B?a1F5MnFmczU1dzJ1WDBjVlpJckIzWmFnRDVjNkVFUzJXbUxGdkFVRHRjakFN?=
 =?utf-8?B?dXhyMFNMZUx2OFp5UTdjQ3BMdFlaMk1oaldaWTJuTmRZNlpNam5SUHhuSTg5?=
 =?utf-8?B?NVpLR0h6ZVpncldzZ0xQaExPSWFxdk5CTHF3Q1JCWUVyWTFLT01ONUUwYTIr?=
 =?utf-8?B?by9NWkpzNGxYK3Q3WHpSbElsRnpzQjFaWmsyWGQ5aTZtWUo0ZXh5TW1wR05k?=
 =?utf-8?B?bzJmQytLVXdiYjJqTVVVWFhLMmZXanhuWXVVcC85RUNJNDN0VU1XSlU4Q2pa?=
 =?utf-8?B?Z0YzOFJwZUZzdmZxL3JlMlFsZG1XZDNpUzRGWXhHeEJFTHJvWWhDY1Q0eXNG?=
 =?utf-8?B?QkdDVVVKbnF0MkthVGM0UzFQMDAyS3NXME5FRStLcmtMSVl3Z1FSWU9WQTdu?=
 =?utf-8?B?THV6VS91bDZWbEdCYk1DaVBKSHJzZWc5QTJtV0JQM1lGclJVMjlpalRMeXJp?=
 =?utf-8?B?OVNteVdLbGhlOTVEU3dkVHhzdGIvM1NpZDhTaElnWWdKbEgwcFBsVFdWMW5D?=
 =?utf-8?B?RzBuTncybVNYRSs3U0tkMjNRT0NUSUVzMFAvaHR0STduT3dsZE9HTXRPblVa?=
 =?utf-8?B?M2pVVkZoL0NLcmJVVlBwaGo4cnVaMDRHcU1ibmtzbDc2ajNxZUJDMktURDZM?=
 =?utf-8?Q?4KZBOj4zdPA0V9egb880LUi6DN6tUg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:05:41.0878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6756b7-4b8a-453a-28b6-08dd60d8195f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Export the capabilities found for checking them against the
> expected ones by the driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  5 ++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 05399292209a..e48320e16a4f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1095,6 +1095,58 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>  
> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
> +				     struct cxl_dev_state *cxlds,
> +				     unsigned long *caps)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
> +	/*
> +	 * This call can return -ENODEV if regs not found. This is not an error
> +	 * for Type2 since these regs are not mandatory. If they do exist then
> +	 * mapping them should not fail. If they should exist, it is with driver
> +	 * calling cxl_pci_check_caps where the problem should be found.
> +	 */
> +	if (rc == -ENODEV)
> +		return 0;
> +
> +	if (rc)
> +		return rc;
> +
> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +}

Nitpick: I think this function should be renamed to cxl_pci_accel_setup_memdev_regs(). The way I see it
this function is really just a helper function for cxl_pci_accel_setup_regs(), so the name should
probably match.

My other reason for this is that cxl_pci_probe() is doing almost doing the same thing for memdev register
setup, but with more stringent error checking. The name now makes me think that this function could be
reused there which I don't think is true.

Either way:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

