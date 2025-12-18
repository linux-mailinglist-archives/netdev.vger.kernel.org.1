Return-Path: <netdev+bounces-245335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE95CCBB99
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96A2E300718C
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3438321442;
	Thu, 18 Dec 2025 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H5jq6U5D"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489A233134;
	Thu, 18 Dec 2025 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059651; cv=fail; b=o4yqR6BWgDzLElR90Nhg+zjKftHoMrALiDMHB3hckfde8Za1HENe4HEixsojHR57TQgyHjfto0+Dd9dgZZ5llRMA05jtdSnonWEhB4bFb2QEAV8HA5Itob5zwFP9f+3GfPLJ8n+knXlGWeKDR4gCsOTd95obgsHXYKtihkTqEBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059651; c=relaxed/simple;
	bh=pVZ1gmD1NmNMARDHDgGTbKzMoNFvF5mywopf2oO2yLo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfO8zS6y52NRlFuZ0xaSqFs2fnH6qcCU376JMxygExjzuFrrZmF999bgDZ/KUokc5j4O65XsgKjJF8zy0oWexMlQmz7rb9uEYh8qvZK+9GHLetruzO+6SCw4cho7gftzVzTE8APOkcBwNpvdQRBl4qw/n7j8INo9LbBigkyp38I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H5jq6U5D; arc=fail smtp.client-ip=40.93.195.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqvT+5VTVKIu5rGrWx2X0sV2dFw3vAEX80DcIOyWGHkRQQqXicq6FtufPOKVph0KcokdtUtAYsyaqHSW+mBXOgj37ACuhWJYAVtPbpcek6t/SA81DdLzmPtYYk4eAkug5S64c96RooFHj6CdGJbhHpASfhgCDX+bfbiLeHH7ZpR6V0wpLaJl3q94htwpUmWa3abvwsvh/4JLU+KvP33HowxcXdHzQvGNdVL8TqqcSWxlkMkpuJSFalU+MpAd9F2oAd/eqaQfr5twS4rhrVw4IAUIJWQecawKLWbOl1QHBdTxDMWZyFMOr3J+qpfaoUkZbY7Y5o4xZqZxZKPrUCxyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0NZgGeLovQkaWRmyF01s/r8tWrKLWLABX7sG8AE6Lw=;
 b=gwks8PbogNs8EM3TttGt/L9mEG1lsKu8zB9tOejZNX7rfJMvC0GyD6fE/kYLhxYsFQDriDUGT+89JwrZLGZA/xpVw5chv707vldz2jrSq0bZ/NFagI4u7IQNvLGZrIaFlLxUYggsUV9Pt8JeGvccOsVAJDid8prsFAEJxOjIC3Yf/LQPVrZRCPgYqEcLeunGlchtSe0tk2NFpbiBeoJu0GIglfokEl9nl15mP2RXZ46lIj5ejpU0BmVNKM/HTKwIJS8PSWPlVEF0hLcHR4p9fOouYQJsiFXiZa+RAjgkAd2gVpWO5TQwe9G7ckT+YJWKnkS3/U8RpqnPmIgF20IkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0NZgGeLovQkaWRmyF01s/r8tWrKLWLABX7sG8AE6Lw=;
 b=H5jq6U5D28PotvsfLlnYvWmz57qRVfYYb7bsw4N5qAhnVP0hZ63M4uqNluuHk0Gy3UppWqCxBMD/xYR49MXQibBVtrZtJBtBSzYJfyxxQRAosVXdTvPxzaS1qMRwDtJc3+3bk0IEgeb3+Nag+9LpCPtu0t2k5ZXLMqX6jlkqRMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Thu, 18 Dec
 2025 12:07:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 12:07:26 +0000
Message-ID: <c9661180-dd60-4322-a8b5-2e5171bd5b3f@amd.com>
Date: Thu, 18 Dec 2025 12:07:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 13/25] cxl: Export functions for unwinding cxl by
 accelerators
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
 <20251205115248.772945-14-alejandro.lucero-palau@amd.com>
 <20251215135303.00002f63@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251215135303.00002f63@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: c292de42-fe32-4c6f-9d63-08de3e2e027d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkxlQlBuQ2MxRlVaTEZVckFkN0pqM1pZS1AySUgzZEhtVVZEeEFrTGI2SU5H?=
 =?utf-8?B?akdsbnZiQXUvamJ2aHJxK0p4WHNSS3VmaXBXRHBINWlCSmpqTHVxa1JiNEMr?=
 =?utf-8?B?TWhydnlyVDBRMXlMVXpFdmE3RFhEam5IejZkeVhrQVFmNVErOXVqYkV1ODJq?=
 =?utf-8?B?RHo5elAramtLZFJPcSs4TTJBUGlaMmZmUWtoTFZCdVZvamxldE9NUjJ5MGdu?=
 =?utf-8?B?clhnUHoyRG1lQ2o3MTRsWTgvdTMvVjMzOHhkWkdlOWc3ODllYmVxSUkvUFNa?=
 =?utf-8?B?N0RTNGc4cW9JYW8vTFkvbkpDTDVUQlAyUWN3ZThmdjZFVnFuMGlabGU3bTB5?=
 =?utf-8?B?R0MrcWhmWkkwT1h0dHdMRVd4QWdhUnZISUxKc2pmMkd4UW5ZOWVFbDBHZEQ0?=
 =?utf-8?B?NG55RDhML2VJa01BT25CUmRjZFpRRjZzYkNVL2N4KzdMQ1F5NlE3YmZvRllY?=
 =?utf-8?B?RGFja0NIUWZHVlQ5MXh2NG4zdEpSci93RytlSnBDSElnWUFNcm4wT0FaNExw?=
 =?utf-8?B?OFVMNEJUVmp6dEdyZ2JKb0FaNzdYSjkzSjVobzg2bFZPMjNuQ2ZBN3pkdmgx?=
 =?utf-8?B?THBDRC9ycGlhcnJVVHZFSEtFcGVzZ3Q5eG42SklISnJwRXNZb0cycHV5SXcr?=
 =?utf-8?B?MThXZWRSZkZ5YWZ3UzFOcDMzeldMOXZUbTlCUTI5aU5hMUhZempTUmZ2NS9Y?=
 =?utf-8?B?c21jTnhKQUkyc1NpVHRka3NRZWRtQW1FWEVTUWpJdUVtV0xaeUlPMGxsTlBY?=
 =?utf-8?B?NllBTVRZYkRjMUlLeWJsZ0xBQnlMdk9LWHFsL3V3QWdVSUZEWWd1a2RCWCs1?=
 =?utf-8?B?QTRJUEEvTGlDT1RlejdBK1lZOW9RNWt1dVFkWUNVVm5yQmdTTjN2dFlGNEdV?=
 =?utf-8?B?ZDczQTlrREdUM1JUVFpmNnJNT3pPUTNjNHR2SC9DYTREb2RuWC9KdnhIazgx?=
 =?utf-8?B?OFRGT2gva2pGZHg2WTlDRzk4eUNFUjhaR21xZExjRUU3dmo1eCtQdWtCREFF?=
 =?utf-8?B?UU1pS1p3QVJFMU9rVGZxaGJLNnJFZGpleFBLNENySnFlWnhlWDBPWTl0Q2pZ?=
 =?utf-8?B?V0xOYWp3MUE4bVBvTGt0aGY2N284Y1FGSDFEeHA4K0lzMFoveUZJUk9RNm5k?=
 =?utf-8?B?cDcwMWlmamFJbFVLaTdKTTFaUmhPTHJuTU9WeEFQa1J5UkV4UVFoL3JLRDNh?=
 =?utf-8?B?QnN1STdFRkdPQmVJbFJieVEyZjBHT3poYVdYYU1CeGJBOG8yZlRXQlo1NjUy?=
 =?utf-8?B?MUxBQzltd3J6TWNaMnlBenVBZDFsUU1CTEtLZUZSYW4ySzhjTXE0eG1xOTlB?=
 =?utf-8?B?U3JzOFQvNFBxVGNNb2Z2SXB4dFFTbm5MT2wvbm9GSUZhUlpPSWE3Zld4cklq?=
 =?utf-8?B?QUpxOGwwL3JUa0dBelBDZEFKb3p0U2NQUm5hakZYYVRxWGNvSy94dVJDRkpP?=
 =?utf-8?B?RmwwMlBWVmgvdGwvODZhSTdYYjN6RTlwMnVFemozWnV6VUtJRVhTSGEvNldB?=
 =?utf-8?B?QVJEYVdPWUVqVlh0SlZ2TExGeXU2NnRLQW1ZLzJ6bVNmL2hsQndRcWNsYjVU?=
 =?utf-8?B?cjhCSmsxL0RoRlhBaHV5L0d5Vkkra0pMRlc2UXN6WUFMdUc4M253THdxMUha?=
 =?utf-8?B?bXFmcGhscWVONExvUllnMlpkOW1sSFpXSzBWLzFQSWJxaVh3SkNJVXdiNmd1?=
 =?utf-8?B?Q2lUOTNhNStsYTd4OEcvMkptZEVrWFEvNTRua3lvMDhiRnNMWUluODBzRVl3?=
 =?utf-8?B?dS9UZ1M2TXNtdXFaWUJQTlgybTdtTFNwSWdpSmhERXhua1NlOGtNdkNKeFJC?=
 =?utf-8?B?NTFLMld2RjhXdGQzbC9pUk1oQkNqaTNZQWVQbngvQlBMUEFPM3pYKy93ellm?=
 =?utf-8?B?VGcvOGphWklRaVE4cWtYQ1hyMmhUb2Rla05ZNDhKai9TcEdUaHI1eHFIdXZE?=
 =?utf-8?Q?1PF75lc0eRY0FX7rlsnrmMdFEwYweibm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVpVcmVTdXc2OFdHbUVFTGl6eE5IUXhFR3NMY0pYa282amZTUCt3M1grMW56?=
 =?utf-8?B?MEpBZGErbkdJalBhMWtLbEpmTjI0WnpSc3lacStZeUxrdDFiNHZRZmgrQ2ZO?=
 =?utf-8?B?MHo1MktiV1FFRXQzTXJYa3lDN0dSVE0zaEl0NHBWaktLSUJHRjlrNUkyL1pS?=
 =?utf-8?B?WEdzenZsSGMraWJ5WXdCNVFQZzQramw1YlV2WmpsSlMvanhoamZIbStNdWhX?=
 =?utf-8?B?RGY2elp3dkx4eHBFVUxDVUp3eVFIeXZNVkdiVTJna2lPRE1IS2hzRHFCL2dh?=
 =?utf-8?B?S2dXSW1lRnpFTnY1MmdGcDlDYmhPNDUvMkJJUW1zclNXU0d2d201K2oyNDJT?=
 =?utf-8?B?eDAwemNCMlljM3hSaGVVN3pQaUptWEhxRzcySENrY2FuVDlacUFTNm1MK3ZC?=
 =?utf-8?B?RTZjYVhFWnkrNGxMMFJYUHhtQWVCZzV2L3NQVThjUWhXajFMUXgvdUhYQlFV?=
 =?utf-8?B?V1V3d1dwRkVhcjFETjlqSzVTRlpTTUZPVEs5bnF2Vk93dUtiNFF3dzhwV1px?=
 =?utf-8?B?RWFIdjYzMzBhTHFVTDBLTmkvK0JuVnFWUjUzVUg3R2NESERKRHM0NlpPVFFC?=
 =?utf-8?B?WTJQMDJmcExTVnUzUnFoWGhlcFhWd2xjTkZjZWY4OTVVT2hpdnhCU3RuRkpp?=
 =?utf-8?B?MzlzYmorT3lWUzNEdjRoU29IZGJVdGtLSk9jT1Ixc1JzVnc2WmU4VE80QXBz?=
 =?utf-8?B?M1NkeGxtQnpjd3JqQUMrMlRoL3QwMlJhOFVxZUJMMFZDODRldDRpR3RlaHl1?=
 =?utf-8?B?ejg1SnBzMmV5ditGWGo3YUZjaFFzR0tmT2U1MVAxdUlDTDcyV3pubis2b2NW?=
 =?utf-8?B?U3VodlVEZUhCSVlicnZadkxUZGxHMVMzd1p0bjl2c2p3azloSFF1T3d4NDBw?=
 =?utf-8?B?djBSWXJwV2RQNUdzVGE1WjFDbXFhV1J0clQyL2ZDNUFZK1VmMGNha0JMTWpv?=
 =?utf-8?B?OStjVGJNcHBRcFYzOGtiWFBXYnNzTGxWZ1Nkc1BUSzlQbzYzVm9KVU56RWFT?=
 =?utf-8?B?T0U5SXRwQXFVUDczdGd3NCt1eFhDbnFFVG1qYitQbzMwTzd5RUF6UXkycG1K?=
 =?utf-8?B?c3oyTENTNHJyU3d3M0xzSnY1eHhSKzJIeXRUSjVpWXczMmxoTmdhL2J6N3pR?=
 =?utf-8?B?ZVc2RXRqUmt2THREZnB1MmJoN0xXUFZNR01BNXhWQnIyWFlGWU1ONy9HWkRU?=
 =?utf-8?B?b3orQ0ZlZXRqY2RmdXhUUW9SU2t5ZlpiMFo3MlhQMk1EWDJCMVAwYkhYMXB1?=
 =?utf-8?B?M0tvM3hweFpXQmNRYWlLTUp3a094Q1VOZHU1SkhQUjJTS20xb3NHc1dDdThs?=
 =?utf-8?B?ZUVIQmg4N3luc3Y0L2NFVUZHN2M2WS82SlBQa2dBWU5rQnlGZTFHS0dhTkE0?=
 =?utf-8?B?WGpWRGtwVDB1cThVaTE1OUxtbkl3eklBS01xQ3RZazdyazFJNzBOZDJoVmV5?=
 =?utf-8?B?M1hrQ3lwODdvcWlQVjJxNW81Um1yQ0ttVkFqNHl2a0g3WERyL3Z3cjlreHRC?=
 =?utf-8?B?SGluTnQvZGJPdVZKMlpuMDd5NVdUUGtxZDJsZ2hYM2ZHM2p1MExCbDB1SXhN?=
 =?utf-8?B?OU0vMUV6TDhhWENwV1VoNVlJeUx5SVA2dDFRTkZqZDV6UWdnUjFxNEdhQ3Rs?=
 =?utf-8?B?NFpGTFhRZC9JL05XMkJlckNHaHE3cm9UajF1SVNqTFZNdHA5NzJuMTFQUy9H?=
 =?utf-8?B?Qk5oZldEc0pzRXBYS1orOVBFMUZOTnhUYnowcENyZEhQQ2NqTFFjNUt2elM0?=
 =?utf-8?B?c0U0L2taNHAzdWJ6NXFWeU45c0lQVmhJRHZ1RWQzazBCb1lvaDhqZXhpbGo5?=
 =?utf-8?B?elltTUpQQ3FsVUZVK0l0ZkR6MWRQb0RGMkNHdG8rM01IRWJIaW5GMWh3aXEx?=
 =?utf-8?B?OHFwc1FpcWR0Q1NYS1k0NU9DM3A2ZUFlVkdhMTRRNUlEbytOalJDK3ZLYVVX?=
 =?utf-8?B?UkhhbWZ5NVJ2WG1oLzk1cWM4bTVUSHJIekZpV01DRmVMYU1GTTB4ZFlkZ2xF?=
 =?utf-8?B?WU4zUHdxWVhYbGJKUGhuMmlXMldMM0NCMi9kTFZzQ0RucDdRekhPTFREUjhw?=
 =?utf-8?B?Q0tnQXMyTkFtQ3NnZEhFelR6N2NwK3UxNWMxdThNdVJ6UHhLempyd3NpVFo3?=
 =?utf-8?Q?bQsWr1DltGNzb8tacv80bJuBZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c292de42-fe32-4c6f-9d63-08de3e2e027d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 12:07:26.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO6617Y0DSMrss4quzizuwjwiPXSMCB4XGwp0lUVoNDlCmfEabOTCK0jw3LZsgHeAzQEGF4les16XshEMAdn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257


On 12/15/25 13:53, Jonathan Cameron wrote:
> On Fri, 5 Dec 2025 11:52:36 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add unregister_region() and cxl_decoder_detach() to the accelerator
>> driver API for a clean exit.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> In general seems fine but comment on type safety inline.
>
> Jonathan
>
>> ---
>>   drivers/cxl/core/core.h   | 5 -----
>>   drivers/cxl/core/region.c | 4 +++-
>>   include/cxl/cxl.h         | 9 +++++++++
>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 1c1726856139..9a6775845afe 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -15,11 +15,6 @@ extern const struct device_type cxl_pmu_type;
>>   
>>   extern struct attribute_group cxl_base_attribute_group;
>>   
>> -enum cxl_detach_mode {
>> -	DETACH_ONLY,
>> -	DETACH_INVALIDATE,
>> -};
>> -
>>   #ifdef CONFIG_CXL_REGION
>>   extern struct device_attribute dev_attr_create_pmem_region;
>>   extern struct device_attribute dev_attr_create_ram_region;
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 8166a402373e..104caa33b7bb 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2199,6 +2199,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>>   	}
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
>>   
>>   static int __attach_target(struct cxl_region *cxlr,
>>   			   struct cxl_endpoint_decoder *cxled, int pos,
>> @@ -2393,7 +2394,7 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>>   	return container_of(dev, struct cxl_region, dev);
>>   }
>>   
>> -static void unregister_region(void *_cxlr)
>> +void unregister_region(void *_cxlr)
>>   {
>>   	struct cxl_region *cxlr = _cxlr;
>>   	struct cxl_region_params *p = &cxlr->params;
>> @@ -2412,6 +2413,7 @@ static void unregister_region(void *_cxlr)
>>   	cxl_region_iomem_release(cxlr);
>>   	put_device(&cxlr->dev);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(unregister_region, "CXL");
>>   
>>   static struct lock_class_key cxl_region_key;
>>   
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index f02dd817b40f..b8683c75dfde 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -255,4 +255,13 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>>   						       struct cxl_region **cxlr);
>>   struct range;
>>   int cxl_get_region_range(struct cxl_region *region, struct range *range);
>> +enum cxl_detach_mode {
>> +	DETACH_ONLY,
>> +	DETACH_INVALIDATE,
>> +};
>> +
>> +int cxl_decoder_detach(struct cxl_region *cxlr,
>> +		       struct cxl_endpoint_decoder *cxled, int pos,
>> +		       enum cxl_detach_mode mode);
>> +void unregister_region(void *_cxlr);
> I'd wrap this for an exposed interface that isn't going to be used
> as a devm callback so we can make it type safe.  Maybe making the
> existing devm callback the one doing wrapping is cleanest route.


I think it is a good idea. I will think how to do it following your advice.

Thanks


>
>>   #endif /* __CXL_CXL_H__ */

