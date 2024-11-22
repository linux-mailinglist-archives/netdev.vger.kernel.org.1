Return-Path: <netdev+bounces-146858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A19D6508
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F97B21468
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF276185B46;
	Fri, 22 Nov 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y+E+XB2A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C08176ADB;
	Fri, 22 Nov 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308367; cv=fail; b=p109skKk1iu4EOmDes6ohT+OHAPMhSXxhR+5Ci2KD0P2PB122s2tfIoOEzNA0P78UQjoJv3qmV++9Gu7j3DL8hKZQYopZ7lfS/RO1LZ+mbg+rVpAfGPhuTaNk2aoXYLjNRHwtolPDNKY4kb+FbgAs21r5+bcFwPg8TNqRJ/2LeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308367; c=relaxed/simple;
	bh=L/hiKWSW6Us9rqNMWSxYBG/3wslox1Y6bzQPm+zRv78=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=L0iCcaJXqZQNZzaU4Rm2VV6oMKX0H/ACBNH4JXmSO3HIAHeI6HDNsPeklNkxJLXXL1/RFGWET5UYUa13gCCiqJ2OaebFfqJ95wKShe6e7z5FFoLWa3yTmY8/hZiHnXlRos/8J6D6kkLISy5q+K3i8i8uOiNDU3SoBVnqOHKaZ8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y+E+XB2A; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ae5W7zGNfSctQ+VT1nRi+yN8+HVkLrXW3REAWMK4l1E9FyLY1bCOHX3tU9vx1Nm12bQvAe7gCp5PDFK6UrjhQs2qZ/MnL/ko2mI/PVibivBg2N4Z1sHsy2Amv8poOcm8iWhmOsaqPpldCv+m++FS4BtYgf7qTd5dR7LxN1Mee15174Dgb0NJQRLQ5viKrblBuPRWUBy9yiFo8KDpq9xqKHzsPp7+p08vvSQvsKN6OKIS6dvnpvJI9dZK2xfHRdYS4G70neiK/PaJuoAFrieYOsieFrYOvvQHyul0EuknTgaaGXEulSx3pPEf8qy3uDhYFXQ6BJTl6c7uEB3sGk6+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJbbx0okxMuLbSwLLJgLDsHjsQvcHgWqQ1UZPUukvS8=;
 b=yjILz4SajUvN99sd4w9xsUGrx5wAZnEMnkMdZbCA6JoyuqF81mgwvHRMu4Al2xejhQ4EfnwXD2GRMO2gFMbHFF/cUZyq4JN3WnZOGBSoMFv98OmKMahUGpOvAgiQzD3LAutvc/v3s3iK7jZ2ynEQD7wJBbCqxRy+0KaDekL3gH4GkMO3J0RxbF33TlHckEAq5Pr1DY2EMpE4SDZryDG2ltHOjxAmVq99Qki7/anFuBUk3UOdnpgMQzCoMHC5fP6ozcYC5AmNlpFr/uKYRWnLIgp+Jc3xHKAuyjhC3mA+rCZHOgv3vPjHqwLb+g0hb5WAFd5igN8IhWOfhefNsB3DNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJbbx0okxMuLbSwLLJgLDsHjsQvcHgWqQ1UZPUukvS8=;
 b=Y+E+XB2AqaknAEKx0mYWq48Y8+Xrl4OTaUPkrlkW2qJxbT1jJWqKjvPQHRAmxpb0RRCJLeZc/bLpNoWuRVVh+1qDSAd08FdFZdeywUXxCbV0e1ka6xMdUR7Sc+fQKvzqtH/CV3TLSflrgBWQZA7qAcY6rI5ZU8KkYp+0g4xsxa0=
Received: from MN0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::33)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.21; Fri, 22 Nov 2024 20:45:57 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52a:cafe::7f) by MN0P221CA0019.outlook.office365.com
 (2603:10b6:208:52a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Fri, 22 Nov 2024 20:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:45:57 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:45:54 -0600
Message-ID: <270c4969-6f1c-4dc3-85e8-fd03fe2b1dd9@amd.com>
Date: Fri, 22 Nov 2024 14:45:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 15/27] cxl: define a driver interface for HPA free
 space enumeration
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-16-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-16-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: f844190f-7cc1-4fb8-a316-08dd0b36aa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2xISUdhT3JESU54cmhZM0JwRTd6MzBDdFluQjBVQ1FGY3ZrQ2dOQzlaVjgv?=
 =?utf-8?B?SnBrZnBOdWY5QUFlU1pkTHlINkllQWFPQk1TTng1eE1oOUVBcWNtVkN2NzJX?=
 =?utf-8?B?cFRZWUM0L21wNjJUL2hSM3E2OGEvWG8wUVh4Vm96aDVHeEREaVhreWJ4ZHN0?=
 =?utf-8?B?dDB4MDdWRHJ2K00rcklCcWpZMlpkSmZKQWFiS0VlTCsvQ0xWQURZeTFuUlo4?=
 =?utf-8?B?VlpZMFRiOGZBSmdHOHh0QlZFczNsZ2dCTXpBaEN1N2tFR3lnZTVCN09FQlNq?=
 =?utf-8?B?SEFpTlFFWWpYSExPM1Z4ZFN6N2dkSGlBY25tRzBiOGdoVEhSUUtpdWFoV25T?=
 =?utf-8?B?ZHFKc0NlVks0c3B6Qlgzd0Rqd3JOWllKanZlazMydDFuR3Zhb1VCQW9IWGNk?=
 =?utf-8?B?Mjd3YnNEaDlyVnd0MEtlc3B0czN5L2U4OXVGMnhUQ0U0Q0RNUFp6SGJwV3hL?=
 =?utf-8?B?bWM1QytieFZHSGdGbU1ET0ZObHloQ0dDRjN1SmJGdHZjWDZIUW1abExiVlpV?=
 =?utf-8?B?U280QzhCR2NSZk9xbEQvbFFLNlNyUi9IcEEvNi84YzUxbGE4REJlL1ZCOXhC?=
 =?utf-8?B?dVhKQi9BSHFBbFF0aExPQldEakxCQUx1UWxiTTBhQjBSOWhIc0lCK0hoclFS?=
 =?utf-8?B?Z3QrcW8yUGxrU3ZaT1BlSnF1V3ljMVhPK2UxODN4R2NBNm4zZktHZ3NHZU00?=
 =?utf-8?B?TEtxSHZsUjJKMjQwdnlXbVQvQVB2RFpubmpXUWhsMmNZb0dDcC9zaXVycmI5?=
 =?utf-8?B?ZUgwT3l6ZkczNzBkenR4SjQ3cHlJY3ZqWjY2dG13bmdiWXpmcWdsNmVveWtq?=
 =?utf-8?B?SU9GT0k5MjhSekRzTWRpU1NTdjV4UHJIbEZTQ3ZZY2hveUc3a29qT1pFR0o3?=
 =?utf-8?B?bW1vbkZOV1V4blVpSTM3eXBFQ2lSMXo0MjZ2TXNraVJWYm9xdXdVUXZvV1Bz?=
 =?utf-8?B?ZGd4c0N2L3BPMXB5TkdzdDF6azJpK1ZFdFJSbXkzM2Z2U1RGOGNuR250cjF4?=
 =?utf-8?B?Y1JrSnJvb1Z4WHFyTkhiTUdkTk8vditnbFYvRTdiRGhiWWFFZ0RlOURpNUw4?=
 =?utf-8?B?bTU3V1VWa09xL0hnUkpZRkJ1TTZSK29kYkh1RGFBaXNIcG5MbmlxeVNWQ3pm?=
 =?utf-8?B?b2x4bG9Bc0tOT21aM0c4VVZocHZFZVowUkhsS2ZENG1QeU9pb3ZnK3RxUzJk?=
 =?utf-8?B?QWtZUUo5YTBZRWl1S045eTI2TXdtaXhsZHp3OHpOYVFuUUhlc0VKeGQ2Q3hl?=
 =?utf-8?B?RkY4bjJNbW1ncGkyd0ViS3NmTnRXcHFJSFFWeVd6VlR4dDFwQnZCUjBUWHA2?=
 =?utf-8?B?dExvK1UvcUZJMHg1UHJuaFozV3pSelBlUHM2U2VUMld4MlpEcS84aHBESmNQ?=
 =?utf-8?B?RE5pWlJ1c2MwNHNrOWFzU2NUNkR4bzFKUkI1RWJMZkIyYXFLWmVIVE1lSFFj?=
 =?utf-8?B?N1RwaVozRGxkRk1LVDZKdkg0VHozdHMraHM5NTNEVmk2YzE0Y20wQWJrcGwr?=
 =?utf-8?B?eXFFM3N6R0tIV0pmMGJzT0drM3BvTWU1S05VUDF2NmN5Qit4bjdhWXZpZXl3?=
 =?utf-8?B?SHo4V2lVU1BOSHBpcytUOERPQ2FiR2tMQ2NEdkRZRTgzL1lMTnpoOVZMUldy?=
 =?utf-8?B?QzcxSmxTZTZpazg1Zk42T2liQndVM082eENRVytTSFVpSzE4RmxiL2dvRFpi?=
 =?utf-8?B?L094eHIwdnlKOUhHWFZ4RmlKSElkRFpDa1VIYnY5T0k4RGFhaERzdzRaMmRH?=
 =?utf-8?B?ZlUveXhVdXEzWjJVR2tReit0c1F0V1ZweGVQQm11NFp0N21NNVRyUU81Nm9V?=
 =?utf-8?B?MEVGT1lRbHhmVENaZXBGaTY2R3hVVm9zcVlQUlBRakhIWWt4NldyR3lTWmlv?=
 =?utf-8?B?a253Tk8wMEJVU0svcEpMZWhYYzA0dFZad3A1dWwrU0VoOEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:45:57.4359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f844190f-7cc1-4fb8-a316-08dd0b36aa9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is create equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c | 141 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |   8 +++
>  3 files changed, 152 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 622e3bb2e04b..d107cc1b4350 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -687,6 +687,147 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device *host_bridge;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
> +			__func__, cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	/* An accelerator can not be part of an interleaved HPA range. */

Someone else can weigh in on this, but I would also specify that this is a kernel/driver restriction,
not a spec one.

> +	if (cxld->interleave_ways != 1) {
> +		dev_dbg(dev, "%s, interleave_ways not matching\n", __func__);
> +		return 0;
> +	}
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
> +		dev_dbg(dev, "%s, host bridge does not match\n", __func__);
> +		return 0;
> +	}

Is this check necessary? I would imagine that there can only be a single
host bridge above our endpoint since there's also no interleaving?

> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max = 0;
> +	res = cxlrd->res->child;
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
> +		__func__, &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +		dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
> +			__func__, &max);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @endpoint: an endpoint that is mapped by the returned decoder
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'

The (@max) part should be (@max_avail_contig), no?

> + * is a point in time snapshot. If by the time the caller goes to use this root
> + * decoder's capacity the capacity is reduced then caller needs to loop and
> + * retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
> + * does not race.
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridge = endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");

This message makes it seem like there's a problem with the endpoint, not the hierarchy (at least to me).
Maybe something like "can't find root port associated with endpoint" or "can't find root port above endpoint" instead?

> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	down_read(&cxl_region_rwsem);
> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +	up_read(&cxl_region_rwsem);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e5f918be6fe4..1e0e797b9303 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -776,6 +776,9 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
> +
> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> +
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
>  bool is_switch_decoder(struct device *dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 5608ed0f5f15..4508b5c186e8 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -7,6 +7,10 @@
>  #include <linux/ioport.h>
>  #include <linux/pci.h>
>  
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
> +
>  enum cxl_resource {
>  	CXL_RES_DPA,
>  	CXL_RES_RAM,
> @@ -59,4 +63,8 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       unsigned long flags,
> +					       resource_size_t *max);
>  #endif


