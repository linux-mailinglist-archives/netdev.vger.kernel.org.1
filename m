Return-Path: <netdev+bounces-225388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD891B93573
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED3B3B40F4
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406A28505D;
	Mon, 22 Sep 2025 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gUclH/Fx"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D2244660;
	Mon, 22 Sep 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575392; cv=fail; b=cZCvTLeT3wJiIENdGQsRpXPTQJt67aYA/NGkXTIar9FYQKIhe1s9DeRMxGSZ5Uuwr1T0jSd/VU3B3q0p5DTrQ8wSQuEZPV53ZlS3WeOC75zWBnUu1Prvsf8EIXRpM3tw5mOzjbPdR2M2uHSY0qfTNd5mDNOQs3E8RdRlnMp4zbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575392; c=relaxed/simple;
	bh=LR6f4LGorWDU724lhnA164tAHAfBsnwaVuZOMaFHISI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NSHYzceU9SMLhUPpT+zZl0otjm+hSjd/VuOAllH14mkSnXdmxGrqdrVdgYXWjDtBrLR7jAeBMa/zn04ytXfKrmtPYuCn4Gi40tl2Ec95DR8ypyprxw6BJ+WY6dKRT46PlTNFUvwM5AoQiWQDTcd1BYd5nNLobzBfOsa/0wuY7No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gUclH/Fx; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVGrsq5c/zVGFcHoVGeVwlXFNrttB50cksnJIs8ZYmUsYblGfsHuoqjEYPHCMu2bRuWeCkA+8T2OALQy9JRoyAAMOhVcePEGWPClGLQ1BrTVd/729neild2UfxJBbHIttHDIng1WNfhrqE2S8D9Dt0FXNZe0Hk+lxC1JGFRCEeWrAki61/RkrjfM5gpOX9ZMrdcvUsZ2FXfsoFH6+sK1ZTIkVX83H7zXJojSS+3lTxNClwmBYau1Hm3zZp+NUbKm/wZuAN1zy9nVbtVGIi9SxwSeSeesxm4O2x7EzuQMjI+pKYPgFRiW8rwKbvsBgEQBb71Px0KQs2kBZ+6la9+tBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Sf5gsmCLmqHUbE6EvyP3Q1lfTl71iq4WNv5WCox37E=;
 b=fz5OqlGjpfBc1tsl+YIKA/B/EwCVFHACuLMsoN61lzm8ZtcVBnExwx0bqkEJXLi/LtGTp27t+xLWtGFpnpWAwzZPL80lj8inAqtjUOIxXuIMiitB/D/R93ZfAliZuUpdOXi57XcOAgvVI4QdNEPuEW1RIVINpDN384LL59mByzZcCOZVEfNyu36j+iuEqoKUDZhR3eTARZTVF8CSMAN9zX5ozgbNJXZBxhzykwJBS5qRNRb+MpwRAx3ieetZqdx9Npu/q7b/BSGmjDDZPx67OHOoh6Vt2N/xvAAGhimOh7IDAO9SwACrItdqiyyqdc3Lam0gLzKotR1XLjMPN+xLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Sf5gsmCLmqHUbE6EvyP3Q1lfTl71iq4WNv5WCox37E=;
 b=gUclH/FxYC9XTBcTPyCVmJPmbwJAG1GwmtoLCrnAI2GkjATc/eB72k1Sp82oNg2qxDJfFQtRse/SehZanzgMgoxAWu0wpAsS5GcNwoDMvQ1pvmTvV7J0kPJG2VkGTFOa50pI0SsDkFKSxVdzalC+BL9U6szLQxhG290oIhExUWI=
Received: from DS7PR03CA0290.namprd03.prod.outlook.com (2603:10b6:5:3ad::25)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 21:09:47 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::93) by DS7PR03CA0290.outlook.office365.com
 (2603:10b6:5:3ad::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:09:47 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:09:46 -0700
Message-ID: <19928767-6ef6-4c98-b469-6c04148d697b@amd.com>
Date: Mon, 22 Sep 2025 16:09:45 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 16/20] cxl: Allow region creation by type2 drivers
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-17-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-17-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: b39c64a3-93a3-4bdb-0a70-08ddfa1c5c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkdwTkN1WVNzR0V3UnpFSCtxYnVqVXNHTUZScTE5K1RpMFlzOGNuVHZTb2g5?=
 =?utf-8?B?QktESmJDOW8rRTZjUEsyTkY1TllZTWZyczlMczJJWGZ0ekJSelh1cTNGUmpB?=
 =?utf-8?B?SysxU0lKaU5vbkR4U1VCbGxBU0FJZzA1WDdXQ0FkU2cyU0pLTzJGYWhONVk1?=
 =?utf-8?B?eHorMTFERjZoYzJvakl5M1lXUnRnZ2xlTlpzckx0M2pOeWhuOWRiSGt4V2NN?=
 =?utf-8?B?QnlraUNWYjJEVXZPOWJ6ajRZR2p1Rk9RWGErTkx1VzhRRWx0eDBFd1dLbGgz?=
 =?utf-8?B?WXVpVm0wYnQ0WUd4YlhCL2lyaEhZaVU3dkdrZ0Q3SWNRaHhYYnZPbkNhR0Nw?=
 =?utf-8?B?ZHRJS0ZQNnlOWm9KVWdrZTBna1JOMk1KR04yV25VSU9mL0VuK0w1Rm52Vnpt?=
 =?utf-8?B?aE1zYzdhQk1qRk4xcmozVXptN0JGTnNxSmpnd283L1dmb283RlFid0pGTklR?=
 =?utf-8?B?WDdDTVNpWWJNeXVQQnd2ZWhodGVCQ3FSQ2Y3Wk80ZFhwWHBKRFVNWklvWUdn?=
 =?utf-8?B?T2E2amswdFFYeXg2Y3JCTUw1b0VzdjM3NjljSG0xUW8rTTZWVmswWEttM3Ja?=
 =?utf-8?B?VG92eHRBU0w3SGlaQktiVHpTWWRMc01jMlNyNTQ3ZEtudnAxMUNGVVcydEFU?=
 =?utf-8?B?RGJZVTI5UlI5enI1MGdRUmVITHF2Y0NoK2U1RVZQbHRNanVUZ2JpTTY0MFZD?=
 =?utf-8?B?N1pCVURiVTc5MWtpSE9OK3pvVFkvVlJwSGpaTmNVQWM0cTF3eVlhbWZwVzFT?=
 =?utf-8?B?MFkvL0E4a3B4ekhuaWg1azhFby8vTzRJZ0tlcnp0d0Nyb1l0OFBuaHh1THlJ?=
 =?utf-8?B?eG9PeWJWRHhzVnl6b2tXcUpVNG44Nkl2NjZLVkVKSWhoTFYvOG5iSVBXVHV3?=
 =?utf-8?B?RGJiazg2dkJTb2l3OEJyRmR1NHlwLysxSDk3Mlg1bzRmUnZNSzg5RUJRajZF?=
 =?utf-8?B?dmYvRmRNT0wrY2tBczd1S2F0WWxzUWF5L0paMEdLQXNGN1hOS05NL0VVaVNF?=
 =?utf-8?B?aWJIWVh5NXprT09TZFhGS3laK0RhY1VwdkFyak9nVlh0TkhvOVlKOFJUaFo3?=
 =?utf-8?B?SjIwOFAwTjdMTmZlcmJ6MU5pUnRQY0gzM2hvUlAwc2NKalVoaExpTUNPRDRq?=
 =?utf-8?B?ZkVreWUweks4TUpCMXI3TFhJcVZZZ0JTWFYvUTcxTlRUMVR5d1pFSGdpVysz?=
 =?utf-8?B?cTM2UFo3TmV2OFA2RUtlM2MybEovRXBSNjZKODBKT3Zidkg2ZVpxdnpEL2Y0?=
 =?utf-8?B?VEhLdlpiWnZyK2NNa2tpaVhicHc2ajRIRGFqT0JocWtBck0vZk5pT0JJUUxK?=
 =?utf-8?B?TkVoUmlCU0twMFdkeStVTS8rOEsyQmp6d3NKcC9ER0U1MjVWdlFmSW01c0hJ?=
 =?utf-8?B?VkFVVnJPL1ZWNHRBUUorS2oyWno4SkVTWjZCTHI2VTdIOFZqWURuK2M3NmQ3?=
 =?utf-8?B?OHNsSnUrREJSaTRENzFvd1FWM1dVTGIvZlhYOXdMN3dlaDRSdUgyTDl4NmR3?=
 =?utf-8?B?Q3pUSmVFZC9kd3Z6UGZqVmdtdktNMnUvQlJkakZOL2dlUkpuSlMzVlNoNmJ3?=
 =?utf-8?B?YlJhMWZKb3dtaUk1dW4zYWovREVaNjVIQzJlRVFBRFJVUXZ1UFgxK012UWFl?=
 =?utf-8?B?Nm9VTjFGMGVHNWtId29NM2dwck5rWkQ4ckF1MFd3c3RjWTVsYnBwVTNYNFcv?=
 =?utf-8?B?OEoxbjJGc3RDMUhKeEV5SHE0UWsyVXFrYm1KeUtpTG4xVEJuRjhKcFdjdmtm?=
 =?utf-8?B?Z2E1dGdoUjd6WUNtQnY1ZE1EcU1jUUZlaGc4MzB3RUZoK0JYMWttY0tjeGJv?=
 =?utf-8?B?SGRManJWTTJtcXRaaVhjeWZEdXEwTk9XUHc5MFA4eE05ZU50dGN4Wko0ejJQ?=
 =?utf-8?B?bjk2Rkk2WG9Pc2o3MU9WYTFoRktndjhLTkpSQ3QvQVRXMzhVWnpkUmtkaXVV?=
 =?utf-8?B?aDczUHh1Q08rN1JSa1NvOVRPaWRNOTJzZmlTMXMwWk9SVC9oSlRvcWtJR3ZS?=
 =?utf-8?B?cnhFa1VuOFNqTTgvWmM4WGloTzN6MkRzZ0VGb2xDb1ZNR3hhWWdtNjkvTk01?=
 =?utf-8?B?eFoyVUJBcS9GM3ROaUxPLzh2RndvOHF2YkxUUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:09:47.2021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39c64a3-93a3-4bdb-0a70-08ddfa1c5c68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Support an action by the type2 driver to be linked to the created region
> for unwinding the resources allocated properly.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---

[snip]

> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
> +	struct cxl_region *cxlr;
> +	int rc, i;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled[0]);
> +	if (IS_ERR(cxlr))
> +		return cxlr;

I think you can use a cleanup helper here and get rid of the gotos. If you return a return_ptr(cxlr) (or whatever
it's called) you can still return the error without doing the drop_region() cleanup action.


