Return-Path: <netdev+bounces-177498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E5A7057C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901643BC9B0
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1A71DED46;
	Tue, 25 Mar 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="POztQXkr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BD1A316E;
	Tue, 25 Mar 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917577; cv=fail; b=JW4T56XCU5ic+S2l0w6CzjarCIYn6lTkY1tOy2wNEyRi9AhY/OiA2BQy+qW0OOi6+hB8nTO6cthieZuESWEHJFe1VrDWHLmc/xSS+1tbk+lfgJifjne2lYKjVnGTC4cX6FhPEzeXPP2qnfIpGdNm9frx67FOGPXmvIK80pCCUgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917577; c=relaxed/simple;
	bh=siTG1+gNADFp3ZPQHTnm4uh02DcPKYlxMgCXkgILUEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O1AcAvRHgB/9Bb2gVGh1LFPmj9MeTeA42ltZyNlRGWoXLZ+Xy0lK4yaQvRh7U2qGlHrVsVxv6qyoQFCjmftDEnIx7Vfnb+YPLABsyhS/XAwCrX3y9oJJhG/bZe9wttXcswRmXOTR0q6qI9g6NpyHjJKOqDY5QsPV0OiqJtZZJsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=POztQXkr; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak29ZNp1fzjIL5Kn62zMUXV2nArQFNnIEcC/s9eqEEwWNT2kNSIXjP8vCS5u1hX1ijm0cF1W2D/ZZITQFy1Ys6SuHrUOUNWBr9E+FBwUpWt+0+bqLfbyPlcCaCEtdDrun01tBRbHNq3KV8Vc9GQTXtRruvzxlagHLNanAuBE/9uOrRPcBe2PfZFJNg+AS7qtXop3nBtqrkJY25R04eXG2sOhW+YnqWPKa4rkxdjCgdW9h9kvVCKM+/4bAT9wizUGeq6UMXDZztpqH/PuGNHPXW6JwOxqr4+4ZyUnqCBRn2G0BssQqLmDkLGRInXry1dtWQbdu1ahC875hA19X4Pxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfqgUEmjSHrjBz+Kn0FHJvIl5amHgn0dZEnHsfnSoTE=;
 b=GjXIj+3FvlKkH4yZciqKWRwyD31mcb5sbuvF7NpNhx7ldEpZX74b9y0p/jipjldixy2Gvj/5EPrR9fs1toOb0SxSaIWqIMwRlqsN/+obW9Fm2VQMZmzaa/YZ1xS/nrNOP1phFyHJZqpP/42CqEwWOzrY3vpmRvy0APvU6y3ru5Bk3fHtfSypooY+Iv+HrddWGOyBvZag6iaEkP/SadC7eHYd4AC24T30LI6V+UfQYthEan4OQeguNGgOlNY3p10sZHhMnwG4L4zVLeC4mPQVCB24BcxLbUYz0uWLcqEDJu0p4mUiLXumQz8XRHfpL9XrcnkPULgGY3p1Euo+LPJpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfqgUEmjSHrjBz+Kn0FHJvIl5amHgn0dZEnHsfnSoTE=;
 b=POztQXkroWzokeI4SPVNWErIdNhhrZJtpuCC7FZ5edqypKNjNuuyrowkaxGFnayIo5CZN27KhoJffcTCjvbW6InI/hAx01NGGvJ7Le9JE9AAm/kQhH06zPQFXlEDoiB04V5y0zoJatye74kWH1zPT3OOgX67V8EzagDVh8PdXa0=
Received: from SA0PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:d3::18)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:46:13 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::12) by SA0PR11CA0013.outlook.office365.com
 (2603:10b6:806:d3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 15:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 15:46:12 +0000
Received: from [10.236.181.93] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 10:46:06 -0500
Message-ID: <ab4f2017-9e40-4923-8f6e-6514a511dd4c@amd.com>
Date: Tue, 25 Mar 2025 10:46:05 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/23] cxl: define a driver interface for HPA free
 space enumeration
To: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-12-alejandro.lucero-palau@amd.com>
 <34efb2e9-a2fe-4362-a1d3-43b63a4d7c76@amd.com>
 <72025133-8d0e-4ae8-af7a-410c1aaced06@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <72025133-8d0e-4ae8-af7a-410c1aaced06@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4553bc1b-775e-44c4-5f49-08dd6bb42b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0Zmb0pZSzM2enV0VjZFWVY0dVVGOXFJT1JGRlQ2RHlFRGdMZW8wNEV5Wldh?=
 =?utf-8?B?VGErM0ZHWHpndFhQMzBVZ2MwSEFUZkhQelJOVkZMdEN4b1hTc1cwNGVqelp1?=
 =?utf-8?B?RFIzb0c4ZEh2MjRYSWFxRnFla3ZmVVNUNFpCODlBRmJZcllQbHU5QUVhYnQ4?=
 =?utf-8?B?NmZJUXo0c3lHbG8xdmtmVDVQV2RSeTRIVFVjSU1TLzdHTmU1U2lCc2NIM21s?=
 =?utf-8?B?WFZwSDh4N29pT1NvYkJSajJZSnV0SEdDUXdaYkRsaDR0WjRNV1JPVmtaeTk0?=
 =?utf-8?B?SUpTeWFFaDRIZDFrZWFTZjdhUVczWUIxbkY1NlFNZXk2aEprY0pwcVlUU1pR?=
 =?utf-8?B?a01qbmYwV2xjVnlNZFNkdmk2M216MWtRelJrazdyTTZJOTAveUszQjAyOUZ6?=
 =?utf-8?B?VzMrcnNFQk04cjBDZGtvazE3bzUyMUZhM1NzbXYwa1RnaTJjeEY0QjhIQWdL?=
 =?utf-8?B?QzV0NVFoekxFTFdxRXd4QmhoeXE1SXlnM1BmRU1idHA0clpHenRwWTNHN1Vr?=
 =?utf-8?B?Z0RIVmxyU3hWckl1SExDUkttbWU3anRkMHMzTS9iRjQ1Y1JOSDNyRkR2QVhB?=
 =?utf-8?B?R29XbC91TVg2WTcyd1R2dEdoa0ZDa3NaajEvZDY4RlRlNmtJanBMbDhJSHli?=
 =?utf-8?B?U29aV24zVTJNVGJnRHFVYzFYNVErUS9weC90czRTVGU1aGZnNXhYdDFrOUNn?=
 =?utf-8?B?blF6WDM3TkI2MXdTNGtvS0JVR2pYTExvenZtQS9PVmJYZTlUdWxHcE9rODlx?=
 =?utf-8?B?bmRjWjN3aytET3NNaVg3SEZ5U0tGZmFYL2JmdStRMjRnMWU5VlZtTGV5aWpv?=
 =?utf-8?B?anM1eGhBU0JXWGluOXNyaUpYeDUwTDZ5QUx4Ymw1T3NkN29Kamp2b2hELy9Q?=
 =?utf-8?B?c2JlVWZ2RitsY2o5cEFqaytSMHgrdjQ4ZklyZjd4YWFEeXJmdnRLMndJaDFK?=
 =?utf-8?B?YXhSVHA0SlhxN29WS2dFL3RxeE16Q01QZ25McWY0RzEvUWJhbDU5TXNJZ2cr?=
 =?utf-8?B?ckpYOWM0ZlFINFlWdjB2TE5FdmdpdUVaUmNCbmhUNDM0MDhUbm1EMUhBQzd6?=
 =?utf-8?B?R09Ia2ZWNm5RQzVXcDMwdS9ETnpJVDdIa0tXdlFCSlIvQWtwa09TTmQwZXNH?=
 =?utf-8?B?dEcyK0dleHcyVHRKYmFMWGJrRWplbmhtMlRVd3ZGVFdVYnhNZUFWUVZsYnky?=
 =?utf-8?B?aHZ6VVRLOWR2dmpwdXdzQkc0NXVvVWNteEZsQ2lxRk1tUkFIS29rak12SCtm?=
 =?utf-8?B?YjhDcERyRjFERkZUUkF4bHhiZXJNVHpyZmZIWldwelE1dWVtN080UDRoTzJN?=
 =?utf-8?B?ZnJCcDJQN2ExaitZNW5JOHBmTVlDbitHYkhlM2FKTUcyRkgyQTB6aUxNYXV6?=
 =?utf-8?B?YUVtK3RFY1h4UHVxU0o0Z2thZWJHT3hkRnJZSkw3KzgyRitIWGpPTm5VeWdw?=
 =?utf-8?B?OXRwU0FSQTVmNXVYTFFzVFFiaG1hUWtaUi9XanNOYXVIYlI4d3M5RFNlcjZ5?=
 =?utf-8?B?bWpUeGFlNlJMaE9NU1dGMlR0UHI3S2szeFFsZjlhYUU5dng3eis5bHdIVThZ?=
 =?utf-8?B?QkdOd2tHWFVybEROSERad3JYdGVSM1dTaU1sNTlsWDJhUlFwY045a1pncTdi?=
 =?utf-8?B?MmZ1eEgvV3FBZkd5cHAvMjZSMEZDT1dDZWxHaDBHZG1KZUxIaUJPTnFyYzZJ?=
 =?utf-8?B?cVA4Zkh4Tjh1UzZNaFRXQkdFejh3ZVgrVkVNbVhHMU02allQdUtaU1h1S0wv?=
 =?utf-8?B?OS90WGplOVFYcys0M3o0ZUZpcGd2LzRnQysvWTJmd3RLYTE4U09ERVdUUU56?=
 =?utf-8?B?eEpaQXdjWTZ6VW5ZWUN4ZFd2THhzU1M1RVRoc21xYWpYbXR2ZzJaaWxPM1k1?=
 =?utf-8?B?TUlaRVp4bGYzT01BWjFzTWRVNzZMZmNpNThSZVBic2xZaU94cXlhYXYyOUpL?=
 =?utf-8?B?VDFDbks2dGM0cU1XVUdET2hNNldJVHpNdGFGeW84cEROc2puYTQxdEJNdDdR?=
 =?utf-8?Q?ByAF+OQ7ZouFDWQXaudGG4jQ6KK8Po=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:46:12.0105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4553bc1b-775e-44c4-5f49-08dd6bb42b45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586

>>> +
>>> +    for (int i = 0; i < ctx->interleave_ways; i++)
>>> +        for (int j = 0; j < ctx->interleave_ways; j++)
>>> +            if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>>> +                found++;
>>> +                break;
>>> +            }
>> I think kernel coding style requires braces on the above for statements, but I may be wrong here.
> 
> 
> I can not see a specific reference to this case. But, do you mean both for clauses requiring it or just the second one?
> 

I think it should be:

	for (int i = 0; i < ctx->interleave_ways; i++) {
		for (int j = 0 ; j < ctx->interleave_ways; j++) {
			...
		}
	}

But it's a style nit, if whoever is taking the patch doesn't care then I don't really either.

> 

[snip]

>>> +
>>> +/**
>>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>>> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
>>> + *        decoder
>>> + * @interleave_ways: number of entries in @host_bridges
>>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>> Looking below, the HDM-H vs HDM-D[B] flag is called CXL_DECODER_F_TYPE2, so I think
>> it would be good to reference that either here or in include/cxl/cxl.h.
> 
> 
> Well, it is not that but I agree the description requires an update like;
> 
> 
> "flags for selecting RAM vs PMEM, and Type2 device."
> 
> 
> I think because the patch does not define the HDM-* as it is not needed yet, it should not be there.
> 

Sounds good to me.

Thanks,
Ben

