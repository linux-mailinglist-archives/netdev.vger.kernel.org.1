Return-Path: <netdev+bounces-225381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5581DB93558
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D78219C00AB
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322083A14;
	Mon, 22 Sep 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YCpBxBxW"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B034BA39;
	Mon, 22 Sep 2025 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575333; cv=fail; b=gU+IRVF6lSVWIsgaN+nD4XAljurLMS9wJkHWYqoMKQWTZCc5ugD7v1m7EzgR/S5pJ/2cBUjFOLLJpTdLfkNbyhHG2+l9qrxvZFlmLEoDzgdxeGeo/XrhAiAWDB+kOE1XJCXx8RoPiVMINh1KyLBbZcIpQLLzumNLmZMhlxhGTag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575333; c=relaxed/simple;
	bh=n4zk7GinlTSMzjMsBSD/bu04NlRetGInC4T2JXWsWhw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=X1OwbVnIJpc7M/apberwW95KCVrT7MJZ45O5ZqX2eS1N9j7HS+Ra1K+QobNkNyuY7f8DDgDwhHHg91UIh9wpGjw9MPYDACcUwR+fCFHrKZSZ9uHgml/Lp6bu5oGSXd3PaMzeaQLxDABHlkrmQjzxpgaZX2vPL/HTvBH5ByYcegI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YCpBxBxW; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJTjnEr35au4iwwxn3G2fmzW1PVBGEn2T++o0r7fFpnSTiVcutnPo06X+D98GxyPvotS60LiCdcgZAV7WCTVTKdve5jACwqRZsDqdJvMDeOCr0t5U1Ss2Z2bYAMMmCMopK/Z4zqkmpFJIrwv/hn+1+3APjbZIK+ZAbZa8yC/xA3LD/FlOdYnLI7s17vNUTS8pWXwvHygCZlxqtMC03PrI0MJ54UnFlf0T2M3M4zBRjicpxBEfYgPQ5ATi8tZjhN3jYqxnUy5EExkI9OEAgK5QdBMcjmErTCrYwCr+NOE2cPvH+oC10XVtHXmrCOokfXOXNX9Q+KnOACMBh3+vzoh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cklk823tIudNWyfc7rcj0pL3Xa8AZFcjx+zBGCB9oJg=;
 b=gM1odIoZBUR5JL56DraEdkpxEQVJ6DhbIC2oKJsl6IM/t+OwPWu6rMIq4qzpxu81AoNGHNbT8j9z3xLXzl6E+4Jrgi+CwyxcHPlxLwkxQVT4NMFEX2MbqIvaQveHWPgUwrmYi0lWkKriOtpJJppfrvl+VxPAiGPedqzcAHz61mFAMPyCVfGYMzaaDrGUjSPS+5N5AxplII+yWi9IEnHUTSAWPTxOYzS2Bz9RTnvn1C3QOG/mPz6/3/YgcF2ie4GH8VIOr0h9CEE5qpdX/Sm0sZAVpkoA+fHy1tkGq7fuHXHHkQApw+0SzB5jdGAwy1tvuXRCIvZoERVUUn/k3ONjbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cklk823tIudNWyfc7rcj0pL3Xa8AZFcjx+zBGCB9oJg=;
 b=YCpBxBxWG+S2jbmHRFqnei6oQOn8Rifg4tD9YrAzzhD9jb9FTue1LRavPqcEJdqezWjuVSnu3bSfc4CHnLPYp3NTiC8DYtVJWj47AfGDiaXzXbe/3DKOGNYU87YIm8OuEVzCduIdNlGXwZTp28wRtXpIIPSlP04MyiktPtiv7Xg=
Received: from DS7PR06CA0003.namprd06.prod.outlook.com (2603:10b6:8:2a::27) by
 DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 21:08:47 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::6c) by DS7PR06CA0003.outlook.office365.com
 (2603:10b6:8:2a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:08:46 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:08:45 -0700
Message-ID: <bead66ee-b4ef-48b6-9164-d9086b6de3ae@amd.com>
Date: Mon, 22 Sep 2025 16:08:44 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 01/20] cxl: Add type2 device basic support
To: <alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DS0PR12MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f790337-024a-494e-05d1-08ddfa1c3853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEk4SU9NSTJwRVlqTFRFOG9iVTN0UVZrMUhiVFJqaWUwOUFjNW5VQmVZcmpM?=
 =?utf-8?B?V3RjelJPY1dlbWxyUDQveGJSNGJEdWVCMmZDS2hLNUZQOGtzOFE4amk3eG5j?=
 =?utf-8?B?M0RZWFZnckY1UGsxTysrWmVUOFFGUFNTVksraHBwOHRvK1NpbWY3a1dzRzFr?=
 =?utf-8?B?OG9JRGtoSnQrcWJ4N2JvTUppOUVjUWZ4a3pxM2pQVGJXNGxhTTR5Z24yRG9u?=
 =?utf-8?B?dDFXMDJoeHQrY05xdWJ2VHVhSzU5WG9NMHhTd1VyM2ljVnRBNko1N0F0dGpa?=
 =?utf-8?B?a1JsZGN4Y0kzbk1YMGZsbjZiUlRWR2tNTUV2ajNldG9aR1FMbkFiUDBaR1F6?=
 =?utf-8?B?eXUxWlRmWGd6cHBnaWtWYnRaWkRmbzRWenUxVWF5QU9ndWhoeVJNbDErdzEz?=
 =?utf-8?B?SXZjMkR1MTlwUFNPWlpzS0VudU5obGw5dnVZSFBBT2tlRWpXazNkSjlqaDFZ?=
 =?utf-8?B?V3hxcDVBdzFGdEE1VDV0L3JNTVpWWUtycmt2QUhCTTJDbTJwTGxrbm5oc3gz?=
 =?utf-8?B?RXB3WlpPNEdRQ0Rua1Y4MVJRSXlERmNITlo2M1FTN1JZbW5zd0wzWVdncU5I?=
 =?utf-8?B?L05POUsyWHpJSHhTWW9lZ09vdy9GbUVyWUhQME1wK3c2UXdkc0c2ek9pbEps?=
 =?utf-8?B?Y1dMRE1JMDd1VVo3ellxYnpESjJRdXZHUk9pYjNybFFYNUJnYkxUQkhEMTNS?=
 =?utf-8?B?RVRuVlFCSEozODVhOGZKdFB1YlVEVUJpT2ZkYXRPSjlMdzVDaXpkVS9VdVN3?=
 =?utf-8?B?aWpPNytsQjVqRDJ5UDVNYyt4TDhia3BVRFRTMWhERG1VQ0lLcEZKK0VZbW5x?=
 =?utf-8?B?cVd3UEozS2c5c2ZzVUFKaHhPajhEUU5reS9lTTRMVitxZHkzNGNxYjlZSDNX?=
 =?utf-8?B?OGdkWVJKbWFEbWQ2WHdMTHlyME0rZks3SkpmMFdoK0Rqb0tudUZVeVdCam80?=
 =?utf-8?B?Z0V2NCtrODRXTFFDai8rZkRoMWlLTmxvWFlnMTI0Qk02WWNiVzV0bVZ1MHFX?=
 =?utf-8?B?eHZiS3Y0eU5FNXpUaXBtVmhOem1ETk9rRGQ2TjZFd0IxWlZ5bkVpek0wTjh0?=
 =?utf-8?B?bThyZ0QxQWVvRU9XZS83M00zWFViZUlOcEdwaFh6L2p6YWtMS1UrZDMrREEr?=
 =?utf-8?B?NlUzSnRBS3ByMFpLS2VvNVlyQVV0NUNndHhwcFZPTVNzbnBPM0ppSDEzTDgr?=
 =?utf-8?B?QWU2Z3plaGN1YlpsOFFVZ0ptUGkvdnBwM2RQbWJLZTFTcElaM3dOUld6VkFY?=
 =?utf-8?B?MG95U2ZqbUxYVkphZ0dQdlhrcGI5MHlobWxKMXlmUU1uUndIZjFWMUVGSzR1?=
 =?utf-8?B?TFcvNS9Ra0xsRURxZ2l3dnRSZTVHMjFQdEk3clVtN2RtNzNEN3drUzRDRkhO?=
 =?utf-8?B?WXN6eHpVSWtpOFk3SXlmMlQzeEFLL28vbE5ndUxRT3pDdVMzTTY1d2xaSFgv?=
 =?utf-8?B?THBTQ1hTQlpBSDVxRmVKUGIyRGtzR0prZ3VwdFBBQ2lNbjJPRW44cnhqUGF0?=
 =?utf-8?B?NjdUVUM3NWFMY1htT2dmbXErd09JMEpvUEc1MThaTFJQR2NnRkQrZ2lCblpI?=
 =?utf-8?B?MHYzdmZQMEdCaHRERGtGdHdhSHQ5SE1EalBFUlZvTStaMHU2R1d1WjFabnk3?=
 =?utf-8?B?SjJqMXl5bVZwbk9KblBRRlorbUNhOFExM3RWYmZuTGdndGk5T2VNd0tDZjFn?=
 =?utf-8?B?blYwVVMweXp6UXJrc0o1OFFFR08vbGJVL1lSRENvN3QrTno3L0tGdjZqdXpN?=
 =?utf-8?B?REc5d0JiK3lOUk4zRS9jVnZPYlFnMWlsMHlCRVJFdjFmZW4rOHA0bUF1NHp6?=
 =?utf-8?B?aW9GRFJwSWM0Tmp0R0lhY2tUSG44dXJKR0t4V3NiNUVnQTBHREtYZjM1bzFs?=
 =?utf-8?B?Nld0WVdLYjRGU083dkF5aExGaG5zZVo5VnVvckttQWFSYkdIRXVGZ2dzUnNm?=
 =?utf-8?B?dmQ4bDJWajFZUXU0TXVLUE1iZTkybmZDYmNTc3NoU2s5VjF3bGZjVzBsWWhR?=
 =?utf-8?B?WGd5dFJ5QTc1UGVkL2UvYnVYbUR6aFlXL3ZhMjYrTzZETFo0d1Y3aDZQY3VV?=
 =?utf-8?Q?amR+ON?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:08:46.6660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f790337-024a-494e-05d1-08ddfa1c3853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

[snip]

> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..5729a93b252a
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_CXL_PCI_H__
> +#define __CXL_CXL_PCI_H__
> +
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
> +#define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)

Terry added definitions for all of these (I think?) under include/uapi/linux/pci_regs.h (patch 7/23 as of v11).
Since that series is a pre-requisite for this one, I'd go replace these definitions with the uapi ones.

With that (and Jonathan's suggestion):
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

