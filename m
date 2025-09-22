Return-Path: <netdev+bounces-225382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA415B9355B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812AA19C015B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858883A14;
	Mon, 22 Sep 2025 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FVrg4MYT"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993234BA39;
	Mon, 22 Sep 2025 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575340; cv=fail; b=GRs5nAS7ZZfyWwoZ0MXK/hvWDEj8WrKzgDC5at7R9F96g/oBLsFLhPsZEDdYRBDhXGAQcW13wGUjTlLMRB3d7xqR9BLcUMn4Ml4SVkLYXhwYLc6plCl6CaKlFYjf8e+l27+jH0uOh1kUVWGuoAeTkoVJAydStiK0Ir5GaTPsphY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575340; c=relaxed/simple;
	bh=xhPnUSldtzdHGB7NuvtrbuPJOiPwkUyetdg3JmYY7+w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ZxyR5xvgQoG34TereI+eCuQ65C1+n4KalMCMgSi2uX8UsRqXHav/moB6emUMajW7oN4ewLCQptfyji7m5Hv6wUJtkWOBP2MlgVxVc+eIRGfgw6bbYwCbgiwL7m5WbnC6jIN/JquAEaHj8Ug2ToKL6WZ9tmGrARLRkej6nnEfRuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FVrg4MYT; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+QsTnfE6Ycdt+EREyzTi1Ph+7ergr7sp9wooLehktGmqYeJHIenn64OiGd1yNGcXhouCwvHan9s07KoDpN4mglTUtEeIHJw4r7ZBuegDzSkVhrQxtxuBBQbcFhZhHgk5OnrL+do85VFzAwwD1CfjJlkQ6OC3MmxeffDl4YUm15CUcOa+3DIHX5mje5fZWbtL6xaHXifIeuPC4aj3GXl7voi1W55DsI9ItKomfsfDu3XSr+TUCWsyHd2xqQLOmg75J3ZWiH5xLCQo2nR8/g2x0wwieDkN9Uh9vnbralDL2AZ+PfgCCx1LWBQ1iOqxRHW40stiAAWWoKfa8yrwdse8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rSrwuwNaNpmlyGP2HIiph1HfooQ1oFFlWNYLwzZNhg=;
 b=vIHkpiIW7IfkhENdKjEF9KPmgEl0wi8Kk+Xs74i+vIQMX+DJhKc6L9GsJHk8ttUvd+cbBI/jxkgo/JFzLfA26SDRfzRv6Cbhpj90/zrl/zAo0SRUCe9kChvAVmYKpXyHxbRV2iKXN8Qy6RWZ64ZrjqdE7mQaJRnOK4u7yetHXuUcXCdzbw1ZawqH12jFOZnlSus03Ql/qBin/RxGgQ6c+OQxdCFWjp5b76113w2K7wYAC47wVSbzi7YJjvAWsZHQeU4ib1Qbi3tbmkiZxjKQg8jjPuftgLPVx79i5sE7AbwQtCvY7xAunqV21trKFUE42N6Nyv8C1M1C2bK8R2q9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rSrwuwNaNpmlyGP2HIiph1HfooQ1oFFlWNYLwzZNhg=;
 b=FVrg4MYT9Fv9PwT39MJeGjbd46otDPrltpYRjDMlEmR9W71klqSFccYu+UZBGdKEmJWdIynRqlc9f3zFds/BHxBtHBVVB2TuTCuPpLufDbmV6Ej29f4+Uv9aIK+CinthB8FSbJfA1GK49Tti7RHIzYnfdj/Y2xVNPEM4j7PeVVM=
Received: from DS7P220CA0069.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::35) by
 SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 21:08:56 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::4c) by DS7P220CA0069.outlook.office365.com
 (2603:10b6:8:224::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:08:55 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:08:53 -0700
Message-ID: <1b3fdf9f-079c-41e1-92f0-65ac2944ac00@amd.com>
Date: Mon, 22 Sep 2025 16:08:52 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component
 regs
To: <alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f78ec9-0e74-4ee7-6d3b-08ddfa1c3d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVdtQzRnWExXM3I3a3I5czByRVZVTHppaU9UejFIcUk4WGlqQWdySytxUUg2?=
 =?utf-8?B?emZUbHFkdWZKL0s4NWJlY0dHNjRyZml5V3NaeStxNUE3Z1ZiZU01R2xZeUor?=
 =?utf-8?B?WFM2dEs0d3Niczk1ZEI5cDVkbDlKVzFDQXRudjFCUzNPbHhpNjlrQmJJR09F?=
 =?utf-8?B?eHVpcmlrMWZ4WTBreGNld2pFVzBEVzR5T2tVcU5xUlBPZEs5Nk1GcEdYU2Rw?=
 =?utf-8?B?aGFrcEt0NFprQzhLelA2YWpoZFJ6Yk1WVksyMDY0RzVXU1JBZ2ZoYmJtditj?=
 =?utf-8?B?d0k1Z0JjSWkrNXMvclVMeEEvb1h3Z0dhOXZ3b0FCWW9YOTc3aFJQdlhVR0JS?=
 =?utf-8?B?VXQ0bkt0RWExZ2VRUzFKdTE4REdZMmxqRVN3T0NKeVFpb054NDJCd05pSWVr?=
 =?utf-8?B?TWJyYVRCblp4NEZzUXVucWhhWXNnT0N2RlNYZk5obGsybnpIWlB5VVB5bnNK?=
 =?utf-8?B?SEszTU9MM1ZlUnFZVzVETEdGclZ0TC9VSC9MWFMwS3loaDdpeUt1UUcxNDg0?=
 =?utf-8?B?bGEwVVEyeDRrOXFmcUY2aXAxcktTcXhNUUhSRXkvMDlqTUkvcjJMR2cwSndB?=
 =?utf-8?B?S2lGQVpsNzNVaklMakM4L0JIejQ1bXJ5anAybkUxVmhicmNmMGRCL1FjdWpy?=
 =?utf-8?B?R0lmSDhrWlFpS1hVdVI2dEV0cmpOYlBEMzlsbGZ4OTE0eEQ2ZlRzZEtENUND?=
 =?utf-8?B?YXRiRTM1NXlWMEFrZWczZllNalBqM1lZS1BDcTJqZERMZmNxU1c3Zk1wVk1D?=
 =?utf-8?B?ZFBEa0x5bWNobEQ5LzhIejU5UXNzN2VGbGI2NndFMXhtUjdhZnhSM1BoY2th?=
 =?utf-8?B?cWFBMFkzeHVNYTNXYUM4cHFZL21rSjhhRU1pTEU4SkptWkZHajdKQUhHUDgr?=
 =?utf-8?B?SVllc2NVd3ZlQndaRHF5NDA4K2pXbXl2REZDbWRXeWg0ZlU1OWh1UWFRVWoz?=
 =?utf-8?B?QjZ0c091N1llcHRlQmM0U3RHUGZNZUl2UFNkUkxkL0JkZ0dKVXpMb0s0TitK?=
 =?utf-8?B?bXZPRGhCbXdxaHZiWHE0bkxTOTR3bnJ2b1c0eHc0bW5rOFNXcmFxb2VhdTQx?=
 =?utf-8?B?YmtGV29kaExNZnFVU2JiaUFPTU9wSmNlblgraVNiLzE3NWVPM1dNdlZjQmps?=
 =?utf-8?B?MHE0SFI0a0Ivb1dCRUFJb2VYV3RKWGp5c0dPYTV4dWIwalkwM3dCY2s5QVlz?=
 =?utf-8?B?Y2ZXaE5GSWJZejlnZWc1Qi9sVUp5SEhMZmtEZ2g3eDRORExJQ3RwRnBpWUZp?=
 =?utf-8?B?anhPTTNUSE95a1NSdXU2SUg5Z2QzMnhxYXZkcVk0WGdCT0xzNlIva1V5SHVi?=
 =?utf-8?B?bnlzbEhIbnpuZmxHOEdKNUNTMlpmZHBJcGZpQTZJZWNiL2ZtYlU1WGhiS2tt?=
 =?utf-8?B?RjhXNC9CemdPTngxd2dmYmUvbmtET0tJZU9MRzZUMkhZRldaM2hCRktoMlp4?=
 =?utf-8?B?QndBV2NnSzNoNC9XRkZZWGNJZlFRamNtN2p5d01HRHFWM2FBdmlZQWR0NFVy?=
 =?utf-8?B?WFpTU2o5VWsyVFN2ZjZPbHZqVncyd3JNWndjamtIcEhmeTk4b3l5TG9ZdXB3?=
 =?utf-8?B?MTZFU3Y2dXVuemhKbnFTbm82UUwwL3JZc2ViTS9ENTdSVnZQZ0VrU1lFUzRu?=
 =?utf-8?B?bURnM25Ed3ZtbGVMdGo0TmxwMUthMkRTT2NSTUVCK1RUeGRyVWVnUThrSnJi?=
 =?utf-8?B?cnVWNFp1c1hGYWJGRTVmOUlVbkM4MndTbzI1bU9jd1gzaUFlRmd2d2M4aXJV?=
 =?utf-8?B?WVZ5bVNsR2lzQ0ZNZlI0Z3dHcjRGbTlnMXpqZ0lUT05NbUNGTDJXOElQa3hK?=
 =?utf-8?B?WllwOW5aS1JwTDRFZk1TTllYaHdSL0lhZzlOSldWcXFmY3lBRFZ5UzZDak9U?=
 =?utf-8?B?L3JvcFNYUklFRFNocWxFWmphbU9QUXBJZFIxTWFFQU5xNkF3aUdlaElNeklX?=
 =?utf-8?B?OERSZzNOc1F3WVpUT3dXSTVzUDlHNlVFMzJBYTluOHVlQ1FBVEh0aEJiQWpS?=
 =?utf-8?B?R2VjUFFhUHJ3SnUyc2UzQVFnYmc5c2ZnTDdIdGJLVy9FRlVlUEdpSnNnQlZ0?=
 =?utf-8?Q?LOydkH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:08:55.0508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f78ec9-0e74-4ee7-6d3b-08ddfa1c3d52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Export cxl core functions for a Type2 driver being able to discover and
> map the device component registers.
> 
> Use it in sfc driver cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

[snip]

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 13d448686189..3b9c8cb187a3 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -70,6 +70,10 @@ struct cxl_regs {
>  	);
>  };
>  
> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;
> @@ -223,4 +227,20 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>  		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>  						      sizeof(drv_struct), mbox);	\
>  	})
> +
> +/**
> + * cxl_map_component_regs - map cxl component registers
> + *
> + *
> + * @map: cxl register map to update with the mappings
> + * @regs: cxl component registers to work with
> + * @map_mask: cxl component regs to map
> + *
> + * Returns integer: success (0) or error (-ENOMEM)
> + *
> + * Made public for Type2 driver support.
> + */

Nits: Probably don't need the return code description and I'd prefer
"Public for Type2 driver support" instead (don't need to know that
it used to be private imo).

Either way:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>


