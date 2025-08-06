Return-Path: <netdev+bounces-211879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1728AB1C265
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2154116D6D0
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E21F541E;
	Wed,  6 Aug 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nkh09JJU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422C202F71;
	Wed,  6 Aug 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469999; cv=fail; b=jSezDkx5zmxFwz6n7wFe++fURhWLLo5+evDWTT0/OrerPwF6TCxWCQWcW9f6DbNKMz4G752Fx3cNcY85+4iHiXh2zy5wORGyu96s0Vzm2KShIqQbw6L+pQetfLWcNe3aKhlnoXhKQihehG/VIfVOTn5WyEXwMoSGJBGmLbTW4Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469999; c=relaxed/simple;
	bh=SsjI5iNMzgb7ES8tgOZh2HhrXMear/dNKv5tgwKiCXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a9rcimOF11xc7ZxqJcJ8U7L98WtiroGbDKncY+9KCEld7sohyaBY9kzT4jivFfH0OmEdIfTNbFeSJt/lgVJVIM9G15ImilDoPMou/92KEXyuYsscI8PvPjXBb01FEdoe3QoCi7ardlXt2HQUSeENbRu0UMoVXPAbp4AoqqlKMuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nkh09JJU; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7oqknRph0eNGsTbrUe6ezyHclJWIveTesSQkBOPLUcyVnnjydOpo+8NZYLEITVgDr/85Va222iAbHPMNZO2bwRCGLnP9ppYlUbLw36k0FtxJnxg5g6r9iIpwifEDmmUlsE9KlK+hvS8xb11NxIgRYwZntGc8n5/7lZMZrvPuK5ggFXMYQzJlx8Qdr8q/Fg4Bkwx8IXwrWpCietO+MDcMXKUGqETzEhF5gUqTO5x8LLfB+MjOY70cxTFjxnyxw0yNXEed3IYBYIJxKd5NSe/GJtQkRo0S9Ef8naZHLZN4wuCpmTDVbphm1jwkgn3GEVz3sBJHeJ8fgI6ioSuY2JYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3vhadrOXOhxCr5QhjHbHurEqMj7QF5DZxxjoTnve0s=;
 b=PUYC51Gi9Q8SofOUiGM+rhTlAOzd6OsGjMuE34/lNWNg11+ZPf2SznH9lvIKM1qetMwJ4+KfpkkX6huoZkv+YRkZ3ZWq+nz/RO21Nn58hP/V4IuVBelgXrH8xhx+Wv0VK/Vo+JgTA45wKsAe4bFhh8sNLaJTtisnPyWRH7zGqX95yVHPJN7Hwt/JoQLDUq2ys+l0oDtLuHV5NwehTr689muZurynljnGFl2VMJ71OzA91slV8mQo9/l8ObeQFGZNrEF8craMYIgKXlWz7dzFlmP12cUZen5WXXNmGORpb8BxR5Y7kaXgytsCOnLuFix8ZsdHYB6D1BSepOWKmE3ztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3vhadrOXOhxCr5QhjHbHurEqMj7QF5DZxxjoTnve0s=;
 b=Nkh09JJUBUDsRADYIAnYvoVykq/U7UCkg1G6J9/9Z2q+ZWT6H7X67Gi27WqzH/B+8aATR8oWFy8M7PfUPmsYH1CxNKrfO4Hx5BwY0BTzbYF0STMUq3qNMC1jzkGAUegwgAhti2N+jSgx0em7dv2Jm6jeFOhBnWDACVoZj6+0D8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 08:46:35 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 08:46:34 +0000
Message-ID: <3d24d9cf-4b8a-4d70-b222-982f4d71ac89@amd.com>
Date: Wed, 6 Aug 2025 09:46:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 03/22] cxl: Move pci generic code
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Ben Cheatham <benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-4-alejandro.lucero-palau@amd.com>
 <6884080b24add_134cc7100c@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6884080b24add_134cc7100c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0067.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::44) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aeb8f4a-a2ec-4837-8710-08ddd4c5bfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG9oY0txTEN0cUxLdDRKRzBjRFJxWWNqQ3pnb3dmWmFLZm5lUWdGVzh1TEhx?=
 =?utf-8?B?NlpRSXphZEg1ZU5oZFo5RTdCNkZTUkYydXRNbnpZVU5ybHFsYUN4cUhzT3Yx?=
 =?utf-8?B?VXpJUnZVL0c3b20rei9vZGoyeDV4aXVoeUUrZmdlOVA5bGhFeXpQYWVFeUVE?=
 =?utf-8?B?VkRUb1d6V200N25nYm9mZjJOWHFjR3dsRHY5SXlhM1B4TGk5RytlUXJGQ2Vw?=
 =?utf-8?B?WUdWUWU0ekFqcXpadkg0aU5JNndaU0tKWjVBQ0JRaWU4ckNOYmtqdDlSNXBL?=
 =?utf-8?B?V0djUTdyeE9MSCt2Sjl1aEhRNGxrTzBZQ0hPVGFPVFJoZjVVdEQ1elBFOGxx?=
 =?utf-8?B?clVIWUlGR05BTUlzK3VoMGtTVzg5NDhEK2szUXRkZ21YbEdEcVpTbHBHYmFF?=
 =?utf-8?B?NTMwTGtMUUZPenU2eUFVMUZJS1F1amlWRlFjaEVXL3FWckQ3dGVQTnVydTF4?=
 =?utf-8?B?Q0NRNFdxSnJJdWg1R2RORVJodmRIRG5CdE9Uc3BGdGxRMnR4d0RpRWR5MEFz?=
 =?utf-8?B?TVlZS3plaTIwc3NpOGVtR2xpM0hEdWZzUENoTG5OeHRYdEZCbThURVhYdk9L?=
 =?utf-8?B?c2tLV2pHMWJkNXptd0wzcU4rVzJQOW9UNmtIOVRleHNjMWJUbSsyZ3M1cUlt?=
 =?utf-8?B?TFVSMVRKdkIxM0lrWkcrcTJoZUVDbEZhQm5GenJiWUdINkdtWEhSQ3FRelJ4?=
 =?utf-8?B?MXFNbjRWSURFQTZMRTlCb04rWkxTWUhCZ2doTXpMWW51clFrQWFYTmhHWEh2?=
 =?utf-8?B?bTUzM0d6YW01TVRleVJYeUphc0d4eTR6RG55L2VtUmFsWHBFOWYzNmprQlJj?=
 =?utf-8?B?WmZnd3RLWmZMS29zb0tNV0tETlV2R2N2eXgyRGlMNVMvKy8zQ3lGVlRtTmpW?=
 =?utf-8?B?WlRnKzVmbXRnV25uaWszSG8zVkxjOS90em1FMUFzZjRUM0N6R2hxYW1TY003?=
 =?utf-8?B?ZWNuakFScjJQS1VaVTZzWFVlK3JOODZONm5LRnQ2c0RBZFJhd0EvSGtjRkt3?=
 =?utf-8?B?ZlZHU2piclhpbWt0Y05aMGxNOUlNZFFuY0xhSE9WZ3lFVTZ0Q3RFTngrT2lo?=
 =?utf-8?B?WHR2SWlEb0lvbTcvbjZnVlVBVjdoYTVxSmJFV0pEMkRJRkxwcXkrOEZkWVlB?=
 =?utf-8?B?Zkh0bmtBTDRYNUxaRHVMaVI4SU1mU1kvYUZueTNWL0dIVkZtN3ZrOUtJNnV5?=
 =?utf-8?B?d1pvVWFOUnFPYXI2SkJjZGYxZCtxMzhqWlB3OHRNR3hhQmhKZTBmSFV2VjJH?=
 =?utf-8?B?eXhIL1hVMUJ6MGlmOEtNTWdYbzdRYU5OZC9GRzc3T2NLL0ZCeWZsVjNmYzZ6?=
 =?utf-8?B?cU5nZnQ4OHJiNmxTbUViWFU3TEZCekFFbU1pd1JiQVVZaUYwMGxyVW81KzNL?=
 =?utf-8?B?Y3o0TmxsbXFMVDRseHMyRjZieGpaNFZQenhJL2F0Qi9tSFdWWmxNUEhJUXdQ?=
 =?utf-8?B?SGVtR0VQL0Y0RmFXWmJ2elBmZklCM0hzbHM2dUtXeUVMZXpwaTZFaXlqNDAv?=
 =?utf-8?B?S295Ujd6N3pXaHc0ZjdIK3k4eVpOaHppdGxwZ3c4bDZhVHg1eVlwQUZxRzlQ?=
 =?utf-8?B?cE9ad3hSekpqZFAxT3hXTmJYaHM2bFhqL1FlWDJUQ21ReWdlNEhHT2c0ei9S?=
 =?utf-8?B?RkZFQi9RUjFTQ3lhTlVnV0JsYW1WVUlsZXRxWTI1QzVqM05qUEJpQW03cjNs?=
 =?utf-8?B?RXdCeFpYN09oUUUyV0d3cTN5SzAxa1NvTzVEaURkZ2swNGhRZ0NuMVhBd3hX?=
 =?utf-8?B?K0lwN1k3NUtDVXh5bXhqdW1haVpGNWd3UTYrNGg2dm45STJGT2pDaGpPTDFH?=
 =?utf-8?B?QUc2dTlzTVdNQmROcnNEUVg0bmFoR210WTRpK21oUkNNaVJjcXhwVllZc2pC?=
 =?utf-8?B?c2xGVTYxdzd2ZEhoSHJFRU9UaUsveVF6dmhXYzI5NU1BKzNtOWFrdXNDeHBU?=
 =?utf-8?B?YjZrNTFocytKei9KWjlEN2k5WkxhNnkwTU1IeGU0WjFBRXphM0MvRkJpVVNt?=
 =?utf-8?B?R2xoSWpqNjNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1o2eXlVTEwxUmlVdmVyMnZuUkpYNFdLdjRtdDh6MEljUGJLcWhtUmJkejVm?=
 =?utf-8?B?YWRvVTYxL3dOZFAyc0E3bnFTb1Z3Sk8ycndyQW4xQ1dRd0tsMllKZVVwZ2M4?=
 =?utf-8?B?K2FUNFJYS3R4QU1vQ05Bck9wREJ5R3pscXlOL0RiYTIzK3hib3ZlSy9GZEF5?=
 =?utf-8?B?N0tnRFYzckd1cGcxWTQ4U2JJc1BMaE9sTmFZS1RwQW9RVno3OVVPWnhyWXdW?=
 =?utf-8?B?L3VJbytHVWJtOU1GdzVXckRyOHNQT0dzTlNTbHRBU3NndGxwSVM4RWlVdG9G?=
 =?utf-8?B?UUc3OGFZZnp1WjU5Wi9OSVBsc25rSU9FNFVIaE1RV25CakNPSEVlRmZ3M3NS?=
 =?utf-8?B?K1NVUGJMMElENkRZM1lISW5sSnRuWmFEREtyMlFjaFJ0c081bUV3NjNhNXNx?=
 =?utf-8?B?bmthbzVnVy9OZFN0Znc4UUE4MU1jeEtGb2JBcG1CNUZGaHc1ZE5OVXZaYjhm?=
 =?utf-8?B?RHlXcHFSUHBHODRlSjhHZXNHNHgzRHFsajhVcjVJdXlTMW8xMmh2VWpEMU5o?=
 =?utf-8?B?ZFIwOTdnMEtSZS9HaUFXMndJcUZCbU83SUFXQkdzajBSZnN3bzVnSFVZc3Br?=
 =?utf-8?B?V3Qwc1E1ZlY3VVpHYmdReVBKVld0eitvUmhmNW1hcWJoTzFLUk1xeTBkOFUv?=
 =?utf-8?B?bHYwQmNteXRXZksrQ21QaGNraGtIRFJVSTFrMHVjbk1QNVdNYk13ZVplWU9L?=
 =?utf-8?B?TDJqYmEvZWlXdjUvMGNNUXRtUVVuM1FBSUxlMFkzUzRxcVc5a2pCMjlRdGd1?=
 =?utf-8?B?UWEycXl3V0RWcytXdUVsY1g5cU80VXpVUTlHWmJHODlMbDhMZ3h0Ky81b1h3?=
 =?utf-8?B?bUVrM1FzL0FzUFNycm5LNTJiT1BmaVB1dUswRW9EeWJ0cVNPaUxEL2F6UGgw?=
 =?utf-8?B?bFFIV21HRHI4Z0MxWEp5VUE5RlpaT3hsRjRtSFpaWkxrb1FWUTZVRWpMUkgx?=
 =?utf-8?B?RTRCVHd1eFZNOFdObHA3WlJtbFhaUkh1b0w2SDBmcnBBbDE0ZWZGUlZmV0Zp?=
 =?utf-8?B?OTJVTkhUdlZUMzRpdWZ3R216TnhhVHZ4RDZUNTdYQWRQMm5wbll0Y0xweWdH?=
 =?utf-8?B?ZzRLMmkwVHVnZDFhcGw5RitDUElUSHJIbEtZN25HTVczbUx0N3FNOHNsazV3?=
 =?utf-8?B?UlZ0UHVxbzFXVU5OZENKRnhLTGNyN2pHUlc5Q1J5QXRXcDVjckRIZ1BEV2Y0?=
 =?utf-8?B?ZUU1c2d4RVBXcGkvZ3RoaHI3TXdRUkF3WGxQZENJaUVBYS9uMWZJN2JnS0tH?=
 =?utf-8?B?L1RtWkZWL0pBcDdpcFNCRmRURzB4dkhCMHB5M20xNGhFNVlZMFAwcW1PU3dV?=
 =?utf-8?B?OXhRU3hyeHR1K2YwdCtYcE45WU84SXU0LzBmTmRYTFlKUG8xYWpZUFZMemIz?=
 =?utf-8?B?bmhzemxWSWVaR2sxTFhyeFZuTHlCSmRYRUhtVHJyTEcxdTBpRi9zZEcrUm81?=
 =?utf-8?B?KzN1RlZucTJteHlDcTFENGFCYTZnMHgyUG05NWZiUHltMVJGK3N3RmJSYjZp?=
 =?utf-8?B?aEZEMDQyaHBzUUFsY25LWkM1RUhqaWQzVUl6STVkS3U3SENVcTJRZVhPMmh5?=
 =?utf-8?B?dHMveUM3Z2hWNDZSSi9tV3hMTk1pWWYwREZkaVhTUUYvL2ZGYUdXbTQvR2tp?=
 =?utf-8?B?STA3b1FLT041NjBzUHdwdDRENVd6QjB2NmpoMEJmbUxmQ3hnSERWRStPcUpS?=
 =?utf-8?B?bTNKTDRTQmtEeGpjNFZJczhRcWsveHdxVXJETjNuVEhEdC9GQTBHS3FoY3h6?=
 =?utf-8?B?SElLYnpCZW5FM2Q2VXRCZWYyamIwMnFiY2VlSjNER3MzTGw1UzRCYVpHV3Ft?=
 =?utf-8?B?c3BlM1BHcFFkYlNYbmdhMUROemFiNmxPODRkV2NybVZua0g4NWRWM1o1M1Bn?=
 =?utf-8?B?N0xrakd3c3ovL29IRkt4VmxsTXkzbk9SZU1FaFgzaGx1c3RFeXh0Y0lHWVNx?=
 =?utf-8?B?THRhaXFYUUxMVjh2Z2VJVVZVTmNOWThYUHhtdDNWTXRUWDZZQ1B6czBBUEdk?=
 =?utf-8?B?bFE2QXZBRzNTRU14UmhwRmVsM0hVL3BRNnRrVVI0akthSzFHNlFPc2RYcThv?=
 =?utf-8?B?MTFwVVo5ZUhlTE9pL1hSODQ2TWdZVU9YcFB0SUVBaWN5ZEQxQkRZRkVNcEZw?=
 =?utf-8?Q?iWJ6K+jpcWlaiv5dIH0sL+YnB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeb8f4a-a2ec-4837-8710-08ddd4c5bfa0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:46:34.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPY+1Q5CfHkB/lWBSaF7Hpy6TDDqZK6LQs9+Ep+TiJmw/eKBUKQYvL0oJYcm0HF+lt8qv1hEi4zrcMqSY+/6/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991


On 7/25/25 23:41, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
>>
>> Fix cxl mock tests affected by the code move.
> Next time would be nice to have a bit more color commentary on "fixes".
> In this case the code was just deleted to address a compilation problem,
> but that deletion is ok because this function stopped being called back
> in commit 733b57f262b0 ("cxl/pci: Early setup RCH dport component
> registers from RCRB").


Thanks. I'll add this.

>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by still stands, but I question why is_cxl_restricted() needs
> to be promoted to a global scope function. Are there going to be RCD
> type-2 devices that will have Linux drivers?


This was necessary in previous versions where a new accel API function 
required it. It is now gone, so it can be defined as before.

I'll fix it.


Thanks!


