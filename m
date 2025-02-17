Return-Path: <netdev+bounces-166967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465EAA38309
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9C317121A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6F37F9;
	Mon, 17 Feb 2025 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M99z4kDs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AFD1E49F;
	Mon, 17 Feb 2025 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795564; cv=fail; b=L0sZhhTtc2AhbfbYg2wu6SCblGHkUptbg0tUzv6kI1quj1zbZCm+cwwlKcLiU3wL5L08YSoFGcCNa2H92CwLWpuT9t1VdSxcWna/48b50SnOLOGMbvoy0qs8cB8gVbsHA3CcXvvLLJCh3XC/S5S6/AZMOEF9HMnyEBS7CbfKzFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795564; c=relaxed/simple;
	bh=oHiP3FvPMPDMbpveVMCEnfvs4LafL8in4X16FXKLsgI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SlYvFFiuPqlahBu9RbYCmd06+frorf35ie0ghoCV3SijgC+ZgmMv2sw5DWx3dQ1Azb/2Ck3bN5DHzkKOi1zzG36XizkHuRTfV0BfmNXsbPYuDQKa4uFQMOvTzUGxgLv1vWE8podiWVVYppe4fNyI/YE9IVpWxbapULxGiSPaHs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M99z4kDs; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTpv1DO0Q3I9dOLdoGBVmmPvzVYpjMFBs3+vS+dSJwqdQW/JwhP8a2YlAY20QXkTD3FNXDa9STMXnD6HCZdBTXQEW5NF2YcotXNHECSJrUFkrdsEFef99f9/iAo+M5lbWNXn1LF+jtwssEg5YeuByer0tYNR62KgGPHdSqujW2HUGFZzPXkqrPtTRC7jI5KjAulNhIDCvqqRgQqmo97tkAgbAmJz2mhHk7sFuKorl/kQo3/iUymS7E5mGB2Omo0tCQtV6dZ83RRsu3jx3Hly+wxRpuS48C42+YCSoluYOVEMEPcr/in6rvVyhLSsG8JeEmHGcgZBW8XJZSNZl+BZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzTkJABKyBMVMd8CxFwgtMD1+c5VVry4Y3AuE2EJIIg=;
 b=uO3Ntek7kSGEfUZ6dOcUa4MfUNQGRdodtHK3Zcd3x/haLbmD0xzdvU+LLvOwj+1t99wdJw4wcOx39dKHpmrZVtQ7P/7urY7yAjC8Zel9yxXAGWFr4D+9eC5qVJuSeD2zK8nmaiZhLedKswTjj6OFZ5JDXUYHqlyLwGVo3XQLuHHd3AodEKDRewn6W1pb9Ny6/G7mzyPPmf17VVtBap4abaV2V8t5b4++7+PdaL7W6gK9M3C7fTQTOcEmpaihUUwTAoGyGHyOjsq3++MExmdOW2MhzTFCrwgwE+5Z8UK/Yz60iMWzFY7aylnJjQldJJTAL4VHSfD+tqTLNQx+zVG+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzTkJABKyBMVMd8CxFwgtMD1+c5VVry4Y3AuE2EJIIg=;
 b=M99z4kDsOWvRhjqJhSicef+oyvGaY3/r13IHFZQNTz5J/wFBbpyvOvfbmEsWNQ74lYLpOAnzbTuokISdUmiMpBUHhAULtrY3MjicKB2mPdF1Ld0pOIcgxZqBc8+86rOmgMAzJSwDEPIi9+HLoWSHc12L3333wYkUSLvCx5OA9oY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 12:32:39 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 12:32:39 +0000
Message-ID: <33aceef3-9e01-4b28-bc3e-7dc11b59a1f6@amd.com>
Date: Mon, 17 Feb 2025 12:32:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-2-alucerop@amd.com>
 <67a50f7fbdfb_2d2c29447@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a50f7fbdfb_2d2c29447@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JN3P275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::19)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 826e7947-ac55-411d-bcf1-08dd4f4f2a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REl0bVhFWXduWnF5aHZTSStOUTh3M1FQa0Rma3JGNldRU2Y1dVByZC9lZkY0?=
 =?utf-8?B?MURML0ViUTAxTUNPNG1PY3FVZUpzcGFyblp6aTFjRkUyYUZHU2lPa3h0bS9U?=
 =?utf-8?B?MGlFbUh2K2hFZ0thRktxeGk2ZDZ2aTliMmZBSytLMFNtMUFOaXNucW9SUXgz?=
 =?utf-8?B?RGQ0Sk96Vk05REVCTjZVaytWcWVXdHN0THBxNndIeE1HOWpyczk1YnIyVnM5?=
 =?utf-8?B?N0dtZ291WitvenNUQTQyWDRRdlljMS8vYnhYbnYyaFc3cmZTclRoMDZiRFRN?=
 =?utf-8?B?RE42YjhicjVSRTVoRjRBNEN4R2RqSG9FNGxFWmNqR3NrNk96U0hNWWhwT0JB?=
 =?utf-8?B?QTVUMG02Qjczc01TbysyUFgrMEdNUnVPS0FabmkzMjFhYVQ2WkxnbUY1RDlu?=
 =?utf-8?B?b0FlYW9sWW41Q1RvdFVscjlDZFlQUkxWNWQ1NG9iVEhvd1o1SHdTU2dHM0Jz?=
 =?utf-8?B?SmpDNTd5Y1JPZjdsQmZyOU1xSmpzYUlVajFKU0VwbGtLbkVSOXZ6aFo0NGZ3?=
 =?utf-8?B?Vi9vRjl5L1d2cmpmckQ3MnVKS0lsUTJJNG1tMnlydlJZN25DNGlVVW5DTU5U?=
 =?utf-8?B?WkY0RTBMYmQzNHlUYjlXVTlvYk9VUFhucTdiK2h5anA0SjcrVVJ0MFVxQ0FB?=
 =?utf-8?B?cFd4ZXhrbU1NMlNSeU9jSHFEUEZlZmYxaUlqbXRXOXNIc0EvemtJeE5IWXEw?=
 =?utf-8?B?OVQzOEY3bGJnMWZyOGowTER3Y1FhTDVVY21PejlGRlVSYnBKSmtjTUxsZndJ?=
 =?utf-8?B?OHRGQS9DVjVOUEU3WVNMUGIwaVNaeE5RQW5FT09Ld003aEY5QUZOdVJUV2t0?=
 =?utf-8?B?TklteVFKK09uRnRoNjZpczIzZjlvQU5VYzRNb1FIY1A4UGxqMy9qUUVXZ2lo?=
 =?utf-8?B?Tmg5V0xJRUYzbEV2THc1K25uT3ZTWFFjMmFwdWRxdVRxYVBqeDR2WG51SURG?=
 =?utf-8?B?QkJ4Vjdvb2o0eUxLd2JMVE5DT0cxOW5GaHpzQ0V3NG9jdnRwUU1XN01UZnV5?=
 =?utf-8?B?R0hSaXd3eC9wTW9VSGFFcUN5a1RTdGdZSlJqa1F6ZHdEMFQ4Yy9Nb29DT2hO?=
 =?utf-8?B?amxvb0lVVmZCdUVXRzQ4RjB2c2lCVUJsaGJKUDlWSnBlRlJGYXNWTTFVbFhu?=
 =?utf-8?B?V2xYLzBXbEdZdkdMUU42eHNPUWlwR3ZjeDRZVXFXOHRtWWp0ME1FYWU5d0JI?=
 =?utf-8?B?NzI4QjJhNEFSK20xQTJ3TW12K3VSdS9rcHVPWVNKdmJmWnJ5SlpvTmZVTitB?=
 =?utf-8?B?Q0R0NzFsbGdUTnBES3Rld2x1TUJhaHZpWkdpTG10N2tKTTZaNHhITDJMZExy?=
 =?utf-8?B?eW1jRXdvNjhLaXVoSGFGcjVMeGtuUXhJREovV0lhQ0E2OVNDbmMvQ1RKZ045?=
 =?utf-8?B?M01ET2xNZnFWb1hVR1g5elNjalNjcWlLT1l3YmozbVJHWUMydW1wcnUydHMx?=
 =?utf-8?B?elNsQjBKWS9YcXlQa0xxZW9oUnNZbHdtcC85TGdqTUo0bThrbUR5TFRLa290?=
 =?utf-8?B?WWc0WnVSaWpBWG9oNmlHclB1TE1sNUFoNVNjN1d2TlNvUXIrTjl4VDZuUlBE?=
 =?utf-8?B?R3daaWswZWdVYmVWQXQwM2FFUzhpbGVydjFzQmlydEhWQXFrbHdEejJZOVZF?=
 =?utf-8?B?LzJENTQ1TUMwOThhY2h1YzMySUdDY2NXbHhRSkt6RWZLSHpLck1Zb3NLaVJ2?=
 =?utf-8?B?OURzYWVDYlB6VUkxU3plQkozNlc5UmtXOHhUK2FtVEp2MFM5WllKVUNXQ1JI?=
 =?utf-8?B?QVhPVU5uMEFmQ0hUcXFVSC8yTGtvbU5wb3FZYlJrd0tnL2M4R2VKZ2duanRu?=
 =?utf-8?B?WWIzL29SQnhsQWR1eHhYRkNmSDZzWHpyN1ZFeEUvNU9wdGNxYjR4S3BsQXc5?=
 =?utf-8?Q?xhpytWip0yn6V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm9EOG5lRVhmVVRid1NoS3NMaVVzMGVmanpSeU1id0wwM3JBM0R0S3BsZ3Ay?=
 =?utf-8?B?VEhHQ09uT1JMNlVCWXNhR21WU2NaNzFqZEpXcWNKRksrbDA2NUg2L1FSV1da?=
 =?utf-8?B?VGUzalFobEFlRFY0Wi83NE5Gcy9hY01LcE90aXlOWExEV2IrcDN0NSszc0ZI?=
 =?utf-8?B?RTh4b3VFMzBDOEtHa1E1MTV1disyRS9PeWRsRG4vVEtDbUVpeFJnQUwrek9F?=
 =?utf-8?B?RytKS2w3NmlCT2psS1BJdXpkRkc0dEZzRzNiTUV4ZEJWUkpJY0RaalJFRzZm?=
 =?utf-8?B?WkVXdnBVMnlSMm1ibm9xNTlnMzAyRyt3b2E3V1A5SitsMkFiMm93YnN2V1Ja?=
 =?utf-8?B?ZVA0L216dldQT0d1WTJrM1hEMTJBOHJzSmYyWkhFMitqL29tYkRWcEo4K2RE?=
 =?utf-8?B?WWhUZnNZeDlMVmpMallNRnJGdXZuOHRRMDdiS1QzZzFwM1pTNnptRGxOaXJn?=
 =?utf-8?B?YTFscFF6NUZEVVAxeWpwZUl4NTM5emFDMm13ZXQreEIvT3VmWHp4RHRObXNY?=
 =?utf-8?B?OHhRaHFCTGtvYmJHSUdlamNQb3FVeU1KMkFEeEp3MHJrczdwRFlXNDQyUURL?=
 =?utf-8?B?ZGVHQmF3c2NKc3czR0gwSEc0OGVhaS9jL2p6ckI5ZS9FL1BwY25NMUtRNTVm?=
 =?utf-8?B?ME9DbWhqeTQ1UXlkMjZIZmlEek4rMUpEY0pCTzVTdHNoek5XbHBaQTVlbTVQ?=
 =?utf-8?B?eHFWbW9Na1NmMi9Fa2wyTUVRMUpCZmh3YTNCeFRYb1hjajg4V1FOU0p3ZXBu?=
 =?utf-8?B?QW04cnExdmZTb1QxMGVIbmFBRUgrK2l3YXA1cWF2Yi9nVGJXaUV2TkowOFBW?=
 =?utf-8?B?L1Nncy9WS0RTTzg0cHh3Y0VJM3pZTGF1Q2FKVmNHSkFQc2lYSkRjSWdFMmdI?=
 =?utf-8?B?VEFiaEdxQjRlbFdDejRvMHpDMlFELzBUZ0pRdUtueXNrOXhYSENKUWJLcmM0?=
 =?utf-8?B?QjJXL01LRWhHR3JBTXhGV01OOEtRNmlvTm13K0pNZUd3MUFwaGxLcEJidysx?=
 =?utf-8?B?cjhXNGpvWVVvQTFING9rRFM3WFNnS3hxZDZhREh3M2E1MzgwMldQWElLKy9W?=
 =?utf-8?B?RDZxejh0NmN4R1NJQThyek5sVG5HWUFlaERZc2FxQ1duL0gzNDFsR3o1c3d4?=
 =?utf-8?B?enJKODU0MXczUEJobWpxL2s0OE0yQnQyelQwSVdCSHlJdE43QTBwamJORnRm?=
 =?utf-8?B?Q2lZbzN6Qko4YVUyY3VvQTRBcmFJN0pPZW1CZ2FsN2ZvRTNDamZkNFZwbDlF?=
 =?utf-8?B?MGhXNUtCRi8xdVVrRmRwa0dvdndjWjJ1THJ2Y1BiTkhvN1FvLzlWV1Q2ekdi?=
 =?utf-8?B?WDRrSkZmL214UERIclZpeEk5WTJCODBkb0RSa1ZlNXU2b01uTTNDZE81b2dh?=
 =?utf-8?B?NjVuVGF2SjgxZ01ZeGVyT285SStTanhwQ1NrdHErajV4ZXljZ3EySGZVMmdw?=
 =?utf-8?B?aXhCWWkzY1ZJSHZEVStYanByM25MZDZxOVJ0MUpCajdjN2RldW9DV3BHQW9E?=
 =?utf-8?B?OTFDRzFVbDZkTFRoLzdUZDdGV0xTVm5GQU5oSUh5WmJwdDZuMHFlUGVxaHJT?=
 =?utf-8?B?Y0NhQ0dHWkg1dVdvc0ZDTDhRSS9KY2trdGcydmRYMXdkY292QUEzQ2gyOHNL?=
 =?utf-8?B?NUx0ZzJ2V21sOGdsbGFyQWxrekthMjRSY0RkdnlEVDJnVUdnVmxhd2dwdFpy?=
 =?utf-8?B?OFNFMHhtOHY1eHVVZHpRdWNndVZBTm1UVm5QeXRsSVp2Q0h3RVVsNWwxOFYx?=
 =?utf-8?B?aUExUHFtdmVIVWgvbGc5Ym5BMCtlUm1WRUQ2YVRycGd1RlBSWjAxZExXa0tu?=
 =?utf-8?B?TXZIZ1FJOWJLbWkrWGtpZGt4NmpjeHVrWTNDZFNvN0Rpc25uSVM5cWVIRDJn?=
 =?utf-8?B?OUpUMHJLOFcvakIwWHkxTGNYeG9tYXk0RWNpTENqZEpodlh0YlVvNWRoNVhT?=
 =?utf-8?B?enl5NkExZndSaFBYQUlmWFN4UTZZa29zK25EMjJqc3pBUzZocnVuYkUvbWdV?=
 =?utf-8?B?RXdXTVluTmF5czlYZ3MxK0FuTHdNL0NaZUFtY1E3ZTYrM21WM1ZIMjVaRS9a?=
 =?utf-8?B?ZDlKeENRR2FlNUtKbEFLdXQxOUQwOFhxM0hXdWQ2aHJwZjY5TTBnWGNVVEp3?=
 =?utf-8?Q?Lrr13LgZ5nH6gO9ZYICK4OkGl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826e7947-ac55-411d-bcf1-08dd4f4f2a41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 12:32:39.3896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awWzDctrIXen+pGTiJeMSwamE2KVFBWTs/HTOZhRfk0b2Eehv+WEP1uzdzyU3FTyQGoWnKvnV6nj7nbI0+wXVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889


On 2/6/25 19:37, Dan Williams wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for Type2 support, change memdev creation making
>> type based on argument.
>>
>> Integrate initialization of dvsec and serial fields in the related
>> cxl_dev_state within same function creating the memdev.
>>
>> Move the code from mbox file to memdev file.
>>
>> Add new header files with type2 required definitions for memdev
>> state creation.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c   | 20 --------------------
>>   drivers/cxl/core/memdev.c | 23 +++++++++++++++++++++++
>>   drivers/cxl/cxlmem.h      | 18 +++---------------
>>   drivers/cxl/cxlpci.h      | 17 +----------------
>>   drivers/cxl/pci.c         | 16 +++++++++-------
>>   include/cxl/cxl.h         | 26 ++++++++++++++++++++++++++
>>   include/cxl/pci.h         | 23 +++++++++++++++++++++++
>>   7 files changed, 85 insertions(+), 58 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 4d22bb731177..96155b8af535 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1435,26 +1435,6 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> -{
>> -	struct cxl_memdev_state *mds;
>> -
>> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> -	if (!mds) {
>> -		dev_err(dev, "No memory available\n");
>> -		return ERR_PTR(-ENOMEM);
>> -	}
>> -
>> -	mutex_init(&mds->event.log_lock);
>> -	mds->cxlds.dev = dev;
>> -	mds->cxlds.reg_map.host = dev;
>> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>> -
>> -	return mds;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
>> -
>>   void __init cxl_mbox_init(void)
>>   {
>>   	struct dentry *mbox_debugfs;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 63c6c681125d..456d505f1bc8 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -632,6 +632,29 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec, enum cxl_devtype type)
>> +{
>> +	struct cxl_memdev_state *mds;
>> +
>> +	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> +	if (!mds) {
>> +		dev_err(dev, "No memory available\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	mutex_init(&mds->event.log_lock);
>> +	mds->cxlds.dev = dev;
>> +	mds->cxlds.reg_map.host = dev;
>> +	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> +	mds->cxlds.cxl_dvsec = dvsec;
>> +	mds->cxlds.serial = serial;
>> +	mds->cxlds.type = type;
>> +
>> +	return mds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
> I was envisioning that accelerators only consider 'struct cxl_dev_state'
> and that 'struct cxl_memdev_state' is exclusively for
> CXL_DEVTYPE_CLASSMEM memory expander use case.


That was the original idea and what I have followed since the RFC, but 
since the patchset has gone through some assumptions which turned wrong, 
I seized the "revolution" for changing this as well.


A type2 is a memdev, and what makes it different is the exposure, so I 
can not see why an accel driver, at least a Type2, should not use a 
cxl_memdev_state struct. This simplifies the type2 support and after 
all, a Type2 could require the exact same things like a type3, like 
mbox, perf, poison, ... .


>   Something roughly like
> the below. Note, this borrows from the fwctl_alloc_device() example
> which captures the spirit of registering a core object wrapped by an end
> driver provided structure).
>
> #define cxl_dev_state_create(parent, serial, dvsec, type, drv_struct, member)  \
>          ({                                                                     \
>                  static_assert(__same_type(struct cxl_dev_state,                \
>                                            ((drv_struct *)NULL)->member));      \
>                  static_assert(offsetof(drv_struct, member) == 0);              \
>                  (drv_struct *)_cxl_dev_state_create(parent, serial, dvsec,     \
>                                                      type, sizeof(drv_struct)); \
>          })


If you prefer the accel driver keeping a struct embedding the core cxl 
object, that is fine. I can not see a reason for not doing it, although 
I can not see a reason either for imposing this.


> struct cxl_memdev_state *cxl_memdev_state_create(parent, serial, dvsec)
> {
>          struct cxl_memdev_state *mds = cxl_dev_state_create(
>                  parent, serial, dvsec, CXL_DEVTYPE_CLASSMEM,
>                  struct cxl_memdev_state, cxlds);
>
>          if (IS_ERR(mds))
>                  return mds;
>          
>          mutex_init(&mds->event.log_lock);
>          mds->cxlds.dev = dev;
>          mds->cxlds.reg_map.host = dev;
>          mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>          mds->cxlds.cxl_dvsec = dvsec;
>          mds->cxlds.serial = serial;
>          mds->cxlds.type = type;
>
>          return mds;
> }
>
> If an accelerator wants to share infrastructure that is currently housed
> in 'struct cxl_memdev_state', then that functionality should first move
> to 'struct cxl_dev_state'.


If you see the full patchset, you will realize the accel driver does not 
use the cxl objects except for doing further initialization with them. 
In other words, we keep the idea of avoiding the accel driver 
manipulating those structs freely, and having an API for accel drivers. 
Using cxl_memdev_struct now implies to change some core functions for 
using that struct as the argument what should not be a problem.


We will need to think about this when type2 cache support comes, which 
will mean type1 support as well. But it is hard to think about what will 
be required then, because it is not clear yet how we should implement 
that support. So for the impending need of having Type2 support for 
CXL.mem, I really think this is all what we need by now.


