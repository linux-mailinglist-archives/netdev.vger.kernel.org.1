Return-Path: <netdev+bounces-258369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBw3Oa/+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B60C12805D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D20D830B3E6B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD6533E37A;
	Wed, 11 Feb 2026 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D8LbneDm"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506533A9DE;
	Wed, 11 Feb 2026 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847916; cv=fail; b=KBppLXy7SQy8eenF3P5jreGjlf1KdviJoWygqJNNofznSEFvyeKblaP6oeHL6yjlTGK2hHtBoPa+vyPVoIUBUECApLqVcJk2JLnaI4DzrY30tXID9fZV3GMnT5Yfbc4jCl/cl7PQcKeDexfBu7l13duWUOANNVkozblQcyeM8+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847916; c=relaxed/simple;
	bh=rUiPPx6HMV18Y1n5VV/EVmWyQpxfH07duHJAQs7WLeY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=GyjIWmlgemGwt0pX/Rorz0rPS+cjPmqKZZUCsz6qT9RCn0Mdc3kfk6oFwUMnAE2qqpjPFh8Lkx4te3TKTsjjGkII7ou/BN5EIIZ8tG/nOZufnDHQERxZ5DiwhMUy6MuBSabU9ulOhAgXYoBBt1mXOWPHqEc3p5+ll4ehbcuagcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D8LbneDm; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWrG3xCCAewx24Pw4tIxSaznEofSZrXTM9up+sZVzAnzEbDyLSieXdlldFp7WIp0fCCqtt6oCb9cssjHUZaR1N2RUiaelKLtOpfPdSQ2UNHucidjQN3kjovGrnyzE8pXyK1FGmgv19x+fOKpcma72VvPELQHbEDCk6s/cfE4Yf84UMWjDM7CYEPeCx6Ou8RWTnKSnqYz1KBN/sIP7a+FUjML5UPV3UETYpUIs2ts5KqghpoATA2/r6RcEQY1Dd3fcl2K4y56+5gTptGKN0SeayaE6UDBk+LFdStDrrk7FxGglgyIWAr1PGD8RJSarZzX3EGuiY0eRT/U9XiX7mgR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4uIgPaEwo1kdgrqgt5D2VaAMBbGhqduNwDVOOBnTjQ=;
 b=Uj+a5N/YdT3ZW4YWwqC5W5VKavuNAQ8e9XetuZNGIDALzqaNIOpRRuoN9cWLngurEtwOBBvaSanD9OXnh1HJesaqicZyV0ld43k8N0G9u5szwpmQyuxlU+arwEKdRSpuuqMEYu83EXqsjw2HrrAeArSJ3aAW5sZbpndlREwc+8YiP5rj52oNWKP3bs6EU+Uu3e/uqImXcPycmd4+RMSzo3BH+d8DkRKJ4BGSe6fEZA2tiHvsZOaqvUlSPh6jnW1XSKcO7tMg6dqMdr7U0Xtgdy/JK19o4QW7C69GJnay6jUZzbztspRrblJMfcVaQyYCN/VXXgYdIvZzlTxUkUwY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4uIgPaEwo1kdgrqgt5D2VaAMBbGhqduNwDVOOBnTjQ=;
 b=D8LbneDm4GvLsgl4+Dy4dRMsDQY+81FhGEZDDQuafiIWY8QZ/N1Lu48SQBWzd3RN5AAqxU1cT7p+QleM+pEBuLOUMs51IoPrYRGzyr0w3BvAJ9WP7eEpQqBxseKSFUeENDdplzaHjNOp0n6QcRv0spEUmuf0Fy28DJZPdCuaj+Y=
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 22:11:42 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::1b) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 22:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:11:41 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:11:39 -0600
Message-ID: <fc2763c1-e10e-46a3-988f-59c391e0510d@amd.com>
Date: Wed, 11 Feb 2026 16:11:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 18/22] cxl/region: Factor out interleave granularity
 setup
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-19-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: bac4cf7b-2458-4377-a8d7-08de69ba88f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFhzMUxSa0dwSVFkUWZQOFdGRXdxSFcvUjRiRHlRZUxUdEFxOEZjN3lHOVRC?=
 =?utf-8?B?eHRXNWNiUmlPcndqKzBIbE0xS2hSVWErK0NvTXZhQnpIVnZlbm5INXgvLzMw?=
 =?utf-8?B?MUQ0L2ZsN0lJc2VsMnVPazl2Tk11SC9NTlJOZHQyQ2JZRDkxbWZ5NFVEQTJY?=
 =?utf-8?B?aWpqR0tmYkxiY21UWjJ5QTZqRWVmY3pQcTk0eHFqbGIrNE9hU2ZMVWFrWmFI?=
 =?utf-8?B?Z0taNWgzVkg0MGdLb2tPRFhFMUlyRkZJWUNac0lCa3VURytqSTJHZWY5aDZC?=
 =?utf-8?B?RVQ3c0laSm1mM0JSUXc1Y0xIbGJqcnZZMkNJN0FrUFo2eHpXUU8yb3lrK3Nh?=
 =?utf-8?B?M1BHczhNajRCOUVCWkdCdTQ1T2QvRzRxKzMrT1JaL2xHb0VaaUpPbXVNTkY3?=
 =?utf-8?B?MDBVRmZmZUE4Um1HbEd3YytVaGZQSEtod0QxOWd2N00zNUhTc29qWXdaS2pY?=
 =?utf-8?B?QTJ2L1NBT3Qyc2xUUHVRS09sQ2dmKzdDMVU1Z0hycXZpLzl3S2JYUnZEYTRz?=
 =?utf-8?B?ZXVKZVplSnp0OHRzR29BdkxmZy9xWS9rdWJ6WmZOWFROaUxiWjE1ck5DM3JW?=
 =?utf-8?B?bWY0YjltZEdmQmhTZkZBU1RkbzZYVXRYQ2RlV3hDMDhSbklVdUZjNjVPWTJZ?=
 =?utf-8?B?K0F3QnFVQlZxVHA2WFZmNlRWd2I3d3FPVUo4VkQyWjluRU9jSlQ2a25zS1Rq?=
 =?utf-8?B?SW5kVHd2elNuSmZCS2lhUG9JRElGVFJUdHp2VmJOTnVHSWc1aEVuNU0rNmRS?=
 =?utf-8?B?V3NyL2s0NWZwT2NqaVlyOEV4VmFjQ05qTm85d1grdGQ5WXpWeFFOc2JNUng3?=
 =?utf-8?B?UXY4cFo2YU9ZTFJuaThWYUpIMUZWWCtVT2g5WU41Z2w5U3IyRlo5aGlwdDZn?=
 =?utf-8?B?SHl1Ykl0ejdaMnpqNWZRR1pzbTgvYWVBY1VJTlFWUVlyUUhZOU8xYjhhbzF1?=
 =?utf-8?B?eHdjaWU2aWlyQ1c5R3RJMXYwbStWQW5OM25RdTQ3TW0wdGRMbFBIaDVoWjUv?=
 =?utf-8?B?SGJaVlFHS09JYUZaUlZIWnV0ZnhIc0NFWFVXUWt2UnZFNEtNa3RRWG9zNXc1?=
 =?utf-8?B?RnNYL2J3M0U3MS9STUJYOWdvUmpHVnQrNkY2QkJzQkxFNllBSm5LdDZ2bnIr?=
 =?utf-8?B?dUtyWVdHQTZvYnlpKzltMnQxVlJ5SXEzUE9ORkhoZlFvbkZudHNJZUhtUUVx?=
 =?utf-8?B?RDFGclN5dS9lcFhaMXJnVlBaMDdiYjhLdG56WkFtRmJrdVMxT0poSCtzdmtZ?=
 =?utf-8?B?SHBrVHhXRlZCcy9Pc1JRMTVVSEZLcmFVWVQzMG1KOGFLYklGbEJjeDlzblBa?=
 =?utf-8?B?d2haMUU2emN3R3JkWDI4NWExTHkzazVseEZkRklhbGJGZ2VHMk0rTjdDcnM3?=
 =?utf-8?B?OUhlbU5ERi9pUEUwVGViNmlQY3pDTmxTNGZMREpYeVRVMEd1L1Zpekg1RnV4?=
 =?utf-8?B?RW1VcFljK0hNKytwVEdFbHp5Z2NHV1Rsb0I2UG5vYmNWTWdkZ0x1b1VvQzZ5?=
 =?utf-8?B?SDNhOVdBb1BhZ0cxYzRIZEI3anREYUlBY2FTWXhBVXd5aHFjbGpzZGVGNVFo?=
 =?utf-8?B?c3lqUEFaRWJOS2JySWN4NGx3TU91OXhzSGhjS1F3eEJSQmxubzNwUDA5dVk3?=
 =?utf-8?B?bWQ1d0dtSnFRNktlY2JnUHNCVVVHSzI5aCtYTmhoOC9pSjR3Skg5RXZZQjY2?=
 =?utf-8?B?Mnhhdzd0WnpRbmFEME05Vzhrb2ovc0hxVU9MZTVudmhrN3dwOEVpUkNzRTEy?=
 =?utf-8?B?dWkvZ3M4NHMvd0tISVBnVWdmQUFPTU9xYjBneXhQcFprQm1SN3o5T3BQeStO?=
 =?utf-8?B?b1kybzhMU0dGQ0ROaXdjakgvSmhTb3FHSFFCVitkeFNUcXZMMkpBc3VIUEZQ?=
 =?utf-8?B?WUtHekhLNmpaNkxUcXNLTDRMaXJKQUtZeDFQVFdGN08zVFE3cTkyaHlXRjhJ?=
 =?utf-8?B?YXowWHR4K0tmN0t0L2FNK3lRRUF1OGJ6QjlPVGdoaHJhNm00dkprQThhL3VZ?=
 =?utf-8?B?RzI5Zzd6N3hsUGIrU1J1S2xuaDBYaEFOSnRrOHQzZ25RTURDMmRVaE1jMy92?=
 =?utf-8?Q?oAPnXc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9Au3bTEf1nWNqMl+LxXTDIz1a0LhyOO29w+0dQU0CeQlI2yeMpAVbJrxWfS/zzJH477DSgPb3HsizZB/EHwGneOLgsGGIZRaoP5Oshy1Vn8pH8Y+2lmK1z5NMtaONhsl/M1RD8nmhNd2T9iXEtKZbpBsXSGSIsT3MgDjRfyTHNOwBqk8A/4FjZhrYiPtPQryncNZe9QK/htiSD/ClEIkg8wAtWV0olbqyl+ZqCPca0CRCa0vmSfQ21aF0gYro+f1ntnlm2iN9s2hIwatrq2gQqQbzQCDpzvVshOD2TshJqwRTDMDMLAuxIxkzmJvIiKqmkhzHpVI2PoNiSZ6p6bYNNgecf4ZmBpgPKdLQ6QBZ0TupUxzqucaOwOj89gOxYn+DQ32T3/cSmjSmZtEqwfYEu5IMKHm4JIVIgRa+WCTXWQY7CMOfagIRAEoAMrEHmXE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:11:41.4487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac4cf7b-2458-4377-a8d7-08de69ba88f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,amd.com:mid,amd.com:dkim,amd.com:email,nvidia.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258369-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 4B60C12805D
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices is triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup forinterleave
> granularity.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ece1d3df7cf1..63c2aeb2ee1f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -559,21 +559,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
>  	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
>  }
>  
> -static ssize_t interleave_granularity_store(struct device *dev,
> -					    struct device_attribute *attr,
> -					    const char *buf, size_t len)
> +static int set_interleave_granularity(struct cxl_region *cxlr, int val)

Same thing as last patch. Assuming it's fixed:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	int rc, val;
> +	int rc;
>  	u16 ig;
>  
> -	rc = kstrtoint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = granularity_to_eig(val, &ig);
>  	if (rc)
>  		return rc;
> @@ -589,14 +582,32 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
>  		return -EINVAL;
>  
> -	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> -		return rc;
> -
> +	lockdep_assert_held_write(&cxl_rwsem.region);
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>  		return -EBUSY;
>  
>  	p->interleave_granularity = val;
> +	return 0;
> +}
> +
> +static ssize_t interleave_granularity_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc, val;
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	rc = set_interleave_granularity(cxlr, val);
> +	if (rc)
> +		return rc;
>  
>  	return len;
>  }


