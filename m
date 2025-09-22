Return-Path: <netdev+bounces-225390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E8B93597
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BD519C0D0A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B362F5A23;
	Mon, 22 Sep 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5UY2S8vR"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D7288C9D;
	Mon, 22 Sep 2025 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575416; cv=fail; b=GS8/+JsmP5JBvM3h76kmRvfJUCU0mBLL+K1Y2DLIUcVw0fjPKki/JOkwN9pqedHbYPoJGxV3R8iIbtY33yVXlUe6iRuItJ+qXf54UDo+HOrqb3JjjQ2BrlSYvSUq37w0pAd8Lm0bUpb25deaDhDwoOUu/1PE5Mt6K9dKHD+BsZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575416; c=relaxed/simple;
	bh=GEQp4KR4xLcLsj91GZFUgAd6mDQpmAJTJE35aPDe1cI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=DRQqNuVXfxU25wulxpCsqcoVh/1IhBmZl3InYBqBVOl2+1EYA6p31D1QlogQDbKeV1N19hypc5QI0ThlBtZx3wGxa7YZg/Lscs8vHkPq95InPzmO3WfaJENh+GgOF4bKgUYIljC3or4Wn6Si6WeRWXcX+UWCjwTEZasSQgYSkAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5UY2S8vR; arc=fail smtp.client-ip=52.101.46.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HElpcU62Crse8H/ztfdOu5PkNTSKTO6CEMIAG+k2fbGoaR2CZzeZHQ5iHmtgDCWAJvsBcJNXn444keZhKmmhQ7y47uM04mR+9hjHER3NAAsknq3CUcCrmhhjYZCOk4o+eBKMGZG5GFa+MH88ISDjyte1vqK5NAJ/BaanlEI2k4uqRIMns7ZWtyhk8VZLRVMDuBJx+SNH7KG9Xp3oSk8PO/jg3W4cN++XbTCrk3RIoTzWyDdYq2XWNzucpNb40cD608/IVNYM40cfriURp6uwNb/PHw4cL9Z4YFdv34+ZLtaLiGYDtx1EunXCyNeayka15G0fFX1zgt5wMMtRod0hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJVrXZkxanRfRWS5leUS6k9nxM6VXOzBFVfgz+QCOQk=;
 b=syevJUxd92PWutYmySjqGz/IT6P37RfjJCR0GE6Qqlef8uGkDIrTx77VzTvIavKphmQaaRnh4s+fS/5yzxdEZkH6rcACQ/K2sTBJi7kSK+oo7MkhJ2cLEN25pjP2LHbPGShiYOuuLkqvz/bl1jW0yatc4NSrC6SQkUNMs19il7Ny/HKu+htucjJksCDuPI8ca5ZaS2tXnACAmfxB3m78xizTAbORRKM9JcXOJCLew6rxqcgkxamTClcKyzEUPp6dSPkW8d0gzKxSuMPRQ9M4royHwLTopvrDdJ640rH9UA2oQS8AKLZFbpAkEPBb+q2hi+6JQGnNKMvW7OZ9O/VE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=samsung.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJVrXZkxanRfRWS5leUS6k9nxM6VXOzBFVfgz+QCOQk=;
 b=5UY2S8vRgKDai+p+NF0JGhvyyHKOWkmJOrfagZTeJ/xALk9UcrblrJi2IoqKZGtD2JB2UnuwaLXBIA2p928uiSCjb+Mkhh/7zMYezdH3n1etDHIA7VEH1AJ2Xqney8ZweVoGu9cGVR8cxvIxTWErBiZ2NNJLoOeFakfjbhU5SME=
Received: from DM6PR07CA0068.namprd07.prod.outlook.com (2603:10b6:5:74::45) by
 MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 21:10:09 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::7) by DM6PR07CA0068.outlook.office365.com
 (2603:10b6:5:74::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:10:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:10:08 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:10:07 -0700
Message-ID: <57a45831-9a62-4b74-a0bb-d9b0a91c8705@amd.com>
Date: Mon, 22 Sep 2025 16:10:06 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 03/20] cxl: Move pci generic code
To: <alejandro.lucero-palau@amd.com>
CC: Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 52033c4c-6368-4e39-db33-08ddfa1c693f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFo4dmQvUllMVUk3Mkl2MTRTQzVYU2p2S1JudE1neHhqWHU2VVdjc1RPWnlU?=
 =?utf-8?B?REJVWU1kTjZ1dzUvVFkvRGRHR0dzaGlvWjZlRkF2enIxTGpJYmpRbGwzYVZl?=
 =?utf-8?B?SG5MeXMvbUcrWjVRd3RXaGdNYjVaL2gwWGMyczU2djY4SFZFT1M5MDZqaTVB?=
 =?utf-8?B?STZXdnNXQnhWemN0YS9IL1Rhc0d1R3hBY0MrRm9EcFYxSVdWVFRONHpCdTVs?=
 =?utf-8?B?UVBRY2NCcE1jNGR5QW00bGMxYkJvRFlobjhXSnExNlROLzRDbjdyVEpzbERZ?=
 =?utf-8?B?emxTc0JYTjU3SFNBa0tGQjJLNTgrRHpnYW5RTkV1TWZpcDE1ekFGUVY3Rlo1?=
 =?utf-8?B?akxjUzRKU2xKUzVja3pMS3NnMG5qeEVJUnZ3UVhoM0x3cFhNOEhYT1BuNkN2?=
 =?utf-8?B?RklHeisrSzZXWWp0a0N3Rk1LVHJmTHRDaHN0aDU3MUhTL2IxZ2c0Q3VsNmEz?=
 =?utf-8?B?WE1XR1JvdjN1VnZQekNmeCtONWdWaVZYa0UwbUtWR0UwWVhLUEEwZ3FjWWhw?=
 =?utf-8?B?SzYvSThJbk5HQ0QyYnphMVR0VHAvaHNHUDhVTmI3N2JEUS84K2xNUTkwcTZr?=
 =?utf-8?B?eExIV1RmS0xER01MOXArWDVIdVQrY0RwM1g1cUxoN1ZMVU5vRWM4aXVzSVlu?=
 =?utf-8?B?c3R1Z0g4OVM5UXY4RXUyU3VPcXluMXR6MTVLSVpEZFRKUkNpU2dHQW9pRVdC?=
 =?utf-8?B?Z3ZBTnJNMWRvRmovVjNtd3p0VWVwRmV6WVFSUkVHcXlueFZHWThsTGtXVjRW?=
 =?utf-8?B?Und0OExMWWdNeXJQbncvdmVrSVdPSGU5THQvd080cDdFTzdUYlRISXlXLzRE?=
 =?utf-8?B?TC85c21pOFN3U2k3SXlZMWJEd3ZXWjJFUG0wdUE4WjJQamorQk1ySmxMVDJs?=
 =?utf-8?B?MkRCRnF3blJzT1F6bU1Uc2h6eEIyRnpFV2lEVHlXUExmcFhJRWpiclB0Wm9y?=
 =?utf-8?B?RjF6N3dpSHlXSUlqN3NYVVRaYng1SWpPZTE3bVJsT3IrcDVlaUszMkRzQWNk?=
 =?utf-8?B?QldHSHlvY3hoVk1YR0Nsdnl4c0ppbFZSRnZTMU5VNjRzVk5ZMUFkN1hNNW0r?=
 =?utf-8?B?Q1dWdW9LSk9aYmNWbXJRd1NRUmxYS25EZlovakFwd1pOSmt3dW1mUG5jQita?=
 =?utf-8?B?bjh6eDJqZC9CQUNYQVlTVHU3aUZhK205aFJqK1NDQkZHOENpWU82aWRWdUVT?=
 =?utf-8?B?TmdkVDF1OGo4a1h0eWc4UHF0WkdZTUlZNkdoUktuN0RmVzJjb1c4akdWYlox?=
 =?utf-8?B?dEcvRSttQWN5aDlQMXhGcDR3U1JycktkYUpYQVVnelA0VjB1R0JPWE9ENkwr?=
 =?utf-8?B?ZjhxNkQwdUo4aXd0TWdNcEhKYUt3Si9SRE5MMUZvZzJRNjBpb0dBWGZJZUFB?=
 =?utf-8?B?VE9nVVFvZzlHc3pUalJOTVVKenZ1WE1WZmpUczVZZ2tkN0t3bTFocGJhbzV4?=
 =?utf-8?B?dmxiRzRQRllKMG84TWl6cUdDQWVCbitGcGxkd25yME5zR0lwWmd0TE81MmUv?=
 =?utf-8?B?Y0FUL2FkQUZLWWtVdW9JQUFRQ2I2cHByUHJna3hMSUZCZ2FpNXVuSkNEdUJI?=
 =?utf-8?B?bUp6UkNBOE9xNjRPdzVRZEl4ZC95Q1E4dERQcnlERit4OENyam9qTW4xb2s2?=
 =?utf-8?B?dGV0dEdTcVA1WmR3ZEYyVDlJWUEzZVhBL202RG1hN2g1SThrNXl6c3R2bVMv?=
 =?utf-8?B?bUZ3SytLUjZwWEtZVE9GTWJvNVZFSmJqQmVzVEVTUnNBN1FGSkFNS3ZydHpy?=
 =?utf-8?B?Y0l6SG03WXh3SHU2M1UwSldWK2t1R1lBcldLQUFweGRvWW1EYzU4U0oyL2Fy?=
 =?utf-8?B?bjdINnorWGNWWUJnQ1ljOFhxVlliTGlPT3JJamhwU3VYUGZBaFBvelJTK0t0?=
 =?utf-8?B?R052cVN6ejd0cExsZFFtTjM2T0RkTnAyQ2ttNnpvaGdjVUkzQVlDWGw4enNx?=
 =?utf-8?B?UnhSRTBtTjU3ZHVVQm1heGxLL1B6YjlxQ1FnbWVxc2owOUNJMi9mc2lPUXg4?=
 =?utf-8?B?eXRsTFh6U3dFTlRUQnpNQ3V1OWh6UVJkZVVpLzI2ZkEzMnErZEJDN0ZrNW1Q?=
 =?utf-8?Q?+nQA4I?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:10:08.7488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52033c4c-6368-4e39-db33-08ddfa1c693f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.
> 
> Fix cxl mock tests affected by the code move, deleting a function which
> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
> setup RCH dport component registers from RCRB").
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

[snip]

> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index 5729a93b252a..d31e1363e1fd 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -4,6 +4,8 @@
>  #ifndef __CXL_CXL_PCI_H__
>  #define __CXL_CXL_PCI_H__
>  
> +#include <linux/pci.h>
> +

Unrelated change, it looks like this should be in the 1st patch.

>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>  #define CXL_DVSEC_PCIE_DEVICE					0
>  #define   CXL_DVSEC_CAP_OFFSET		0xA

