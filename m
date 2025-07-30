Return-Path: <netdev+bounces-210928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A293AB15898
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 07:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB38F3A36B9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99B1DDC15;
	Wed, 30 Jul 2025 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fq69LCRi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC49249F9
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753854869; cv=fail; b=M9YuIgwvd2JsXIkZ+MdYgwM+8MDBDQTJ4jiWiv06U9o8keJFak75ygv2EDJBRLwdDQA8Rgge3wYrk0qQmR29aHs7T/AzlnviC652foOglhEEy3nKcaQyj53eQmmrzdaIFBG1K8eFeXOMuBcYmcRSDtvc04gb4WZTUR3oGNH0beM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753854869; c=relaxed/simple;
	bh=r2/EMdvSZOnKmai8gw7nNKyS1QLvH7oZCcGFDpQIEBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vBcQWZJ2MbFC7FkZaHLOxQTadkeec0bUHE7yLfr6wKPfwBLscqB/fxJnjBtafRSDF0/b3PUg1GPX3Fy8Lkej2N/VCchdDWG4MULXFNX0Uh4V8gBR5vof0Tf+oS/IgWL9EzgK3pCYOpdP4uGqVyCbbmmibkg8g+/TqFUVN05QJs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fq69LCRi; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2IKIe0LZYBvLmiMYNbiyAa6lABwEctBJe6HT9Vz/6x4t8vLCVkHAk+4xNHGYgTHA4DFO5q2pW4uZQYbROtL9nyg9njvLuTX6baUnyfsGj0hoCeGV1RzgA6vdhKPIjQiNdHzi95bfK9mDz9IXFhJhUMdYfW/JzDqqWC73x2MsmoPcgrYgOpN6G1YS8/U8nv3JtQRP0jQiUXjiiSzYDuwCX3IDKz6p6Af6T9xtVGomsCsimIY4r1xqb7YfIH9fQGW6lzExnfoLfbYZvo6hx5R4TUQO5dvgwG+lbqo9H8aMhMphPiqgwCWvbzN6Bzr32XAviLNrfQjHbgBW4dYb5OaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gou1Ca9FmuQHyVFCY8MA8seevZf6ThkZ9boqFhi+gAg=;
 b=ghfKhPBOLQI5s+fP5B6c7MsRH0mCc/Wp9symddyRozXGIwEdtEkvSNjo5tRSuqncIe5YFGar07Pxn5WoKc+Pd24Leo98b6KfzDWJdUp/WLkoQX5wtgsEvwji2lgb9WQZkOv4sqKAdWL59X4MUnNCOkj8zJdncOEnD7qS/3zXPJIyGhJNtWP7AG6RO/goWAAXJX9TVyczXote2RRw+TwQ1LEKVNTK77o/bhEodXmU5oY/xwgyuxFAx3aC4OzV5Fs7gcChVndTD1/2wNwbmyrXeFxTXlkjj/rjA7LD4PCSgOxjy3tuiPoGjXm8yHOH5OOG5sZ/SE52KbRT3AyTKnqr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gou1Ca9FmuQHyVFCY8MA8seevZf6ThkZ9boqFhi+gAg=;
 b=fq69LCRisFB6fwiAQ3MA/DD/37zW5rnsFMDQJk7vUCp9tJnvJRD3zeyyNIfqi64peJm24E3+IEgSgVNln0oaYPLdxGz9nU0gM529B0M1R8G48MwyFywd+XlsgiiidstJGC57iJZLKvTVE6FB9ZKHPWVrWUeKv8MAijZxCiAOJl7nAnN8gyp6UwBs72hqCWct0/IbZP6A9Nzw1z0x9l+X3w/xQlC6gKHZ5QQ2kamJ65VcQ7cr8nYVJU/g8kV2GFHnynZHFiUlrsvwQ9X2biMvs65ciZ5F4NTUSRJ60By5ncsH1DcsVKRYbSCCnqVE3FzDkvG9MLkL4YcevuFjwAf92A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 05:54:24 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 05:54:23 +0000
Message-ID: <041f79a2-5f96-4427-b0e2-6a159fbec84a@nvidia.com>
Date: Wed, 30 Jul 2025 08:54:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
To: Vadim Fedorenko <vadfed@meta.com>, Andrew Lunn <andrew@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 intel-wired-lan@lists.osuosl.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20250729102354.771859-1-vadfed@meta.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250729102354.771859-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ebcfcd-a22d-40ff-00f7-08ddcf2d88fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkFzTktqVk92aXNOMXRNRlFtVm8wSysrc3FlYWtZMS8rVWdJQVlBZTdybHo0?=
 =?utf-8?B?cWRHZ2tQVE5IcTkzd3hsbDY5UFE1S0tNM2FOWUwzSGF4c3VCUE9ZNkNCWTFK?=
 =?utf-8?B?aHh4Q2RTTGFIYm1kbW1UK0c2T0lvUTd4aFJPSERpZW00Tk5UeDgxYzBQNU5V?=
 =?utf-8?B?Vk1oVFFEc01Wb29mVEwzNFlwNGx6UVQxWmJvVzgrRWNhQTBweFh2TFhsd3ln?=
 =?utf-8?B?LzltRTYvV0NIQVphOGRadjhRb3d4YkFGQVpNNytnSC8rd3lSdmlXeEg5aUc4?=
 =?utf-8?B?K0lmOGhhZkJnNE51QmdadVlQRCtBWWprclBPcm5vSlc5cGs0eFJ3MUxJek93?=
 =?utf-8?B?T3pPNzcrZ2tjZHZuMkwxZ2txTDFTZ0xaUjU1UG1DNTE4ejZhcm9lZi9waE9P?=
 =?utf-8?B?SDB4akx2Z0NrdE5RNTFKcklPUmdLMEgzRGFhQUludWc5blJBQzN6MGI4N2RD?=
 =?utf-8?B?YlBQYmwzTzF6Qmd5VDZXREg2ckVWSHo2Ym1LSE5MRGVQc0E2Z0UrbTN4MUxB?=
 =?utf-8?B?ZDNkdGVlSDdBcUo3SXFkcEJwNFBrZHJyekhpcDlUYnVQeGREWHhZQ3p6SzBD?=
 =?utf-8?B?dncwMm9MTWhuM3dKUk5USnFNZXdDZlZjMWRvQ0g0d0NqdEpqdXNON0MvYjlu?=
 =?utf-8?B?WUlNYjdpaE56WXlESElKUVo3YnNaZ2xnTExzcjRRU1MwQk10OHFSS3N2OVp1?=
 =?utf-8?B?WG8zZ2FpczlaeWZFY3IrbVBzeFFUeVVrQXphdnl2N3h1OGJER2gyMnEwWnNv?=
 =?utf-8?B?NFYvMkl3OUtEclVYdVVzUEx5dlI2djliUUZYdFhNVU9mQk16b3J0a1VyU1N5?=
 =?utf-8?B?cXRpTDRoYXo0akVDNEwwck1HR2RkUVFxMjdtVzFydUtwQ3dBOThQcVdDTGVk?=
 =?utf-8?B?MEZ1OXdhQVlXeGkvaVNQZXp3S3V6VnVFWGhwdDlHNHZLS2dSVE40UEwyVzVF?=
 =?utf-8?B?WUJWdE5LVDlWVVp5YmlEZFg4TzZTSVNyRDkwaGFKWC9tOGFBdDIxcWFqRXBJ?=
 =?utf-8?B?aVg2QVc1bVBvQmZEK1RQYkV1L3FTbG8vVkdmbnJFY0tuak9Cd29QWDJPV0Js?=
 =?utf-8?B?UG1LMCsrYTVUc1FnY0lqVmVyVGtJbnozU0hwbUxqblpOdWFMeUc1QzZnSHhm?=
 =?utf-8?B?clRpS2QzeXBnYmY2WEYvNTVrRjRQR2ZZOWZLeFpGRjhOVlpXUk5JdXZLOHNo?=
 =?utf-8?B?WlFCa01WaDRTeERHZDNDMmRFRWxpei8vd1AvTGc3NlZCMVFiaXo1S1RmazZC?=
 =?utf-8?B?eTJDNDlOTi9LMFFSZi9GNXVkLy8rUVE4TWlpQmd6TDJtblRrRXNHUzhmZHhM?=
 =?utf-8?B?K1lLNWR4M0lZUEVLN3FsajVLT3ZiYTZLaW8xWjBXeTN0RWtvc09vSmFpN0ZK?=
 =?utf-8?B?Uks5dDJTYTZESjlJRWphMHpoNWRMMG00SDlYQStZRHNKQWp6d0lMMkZvcmlH?=
 =?utf-8?B?Q2k1TVVNKzFKVml4MWUzenVoNmlUVys5c0JINWl1cnJUWVprN3QyTmFsSjJC?=
 =?utf-8?B?OFUyTkxGWXlQRVd5aGxMS0c2U3E5U0tKN0w3c0pwZ3VKc2FLcnhnVVcwN3F2?=
 =?utf-8?B?NlJ0NEFtN0ZHL3hmZHhCOUk3amNUSFBhdkcyU3FNb3dtVHZtVU5CQkh0d3A1?=
 =?utf-8?B?a0w1bnRPTEh3aUJNUXhJeGVKNWhUb2Y2S1llazVvSkdKV1RNRzJaNVJJREhh?=
 =?utf-8?B?QkdhejZzVU9uMGpRSFB4d1hZUmlQcmJsemdnWVZBVkE5b2NQNm52Vkh3bWll?=
 =?utf-8?B?Vi8zVWt4RUIwWFJqcGVqR3dyYXRSZG5sMGxWajdpQ05GZnpGWHQ2dUFkS2JC?=
 =?utf-8?B?U29GZjEvSU1aVTkxaThXWkdHaU1sLzBYS0I4N3pPcG1TYVViUU1XcjNQa0FP?=
 =?utf-8?B?c0FGUU4zbHlrQ0NNS1FUZ1VNMzNXWjZkeHZBWGowaEFuYUQ2OVVIbGhaZFNx?=
 =?utf-8?Q?LbXl50uYHQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzZDUzN0Y3RqRDMvNEtmQ1c1aW01dzFCTTRHd2NNUzRsWGNqT3N0MXFPN0s0?=
 =?utf-8?B?bWYyS1JlZnh4Z0VvdVREd3RVL0RZZi9rcGlmcXlMSGcwUE1oNDJYMlpzMjRt?=
 =?utf-8?B?aWhxVjk4MmJJT2tWVDBpeVpmOFNubEd6T0hkbFhJbEJlQzZuV25ETHJSNjB2?=
 =?utf-8?B?WFZQbTR5MzRPcUZNNkVPOXZTMjZ5SS9VaHhWWDVHbVR4VmEvc3dqbG1sN2Q1?=
 =?utf-8?B?dDJVSWgzMklnN3FJeElybFlrZkY4WEUwVUsxMWNyNEZ1bG8zejFaZnYvL01Q?=
 =?utf-8?B?ZEtBTk9Ta2NnUzhJTENUSFgreVJhLzBXZ043MTAwM3dMb2d6ZnVjUVIrR3pv?=
 =?utf-8?B?L2pYQy9vRS96NFlWNU5yRlRsaU1TaXlEUHRUcHRTZHh2ZHhkQWdkMUtnRUFJ?=
 =?utf-8?B?bVdWeWNrVk50dFN2VGdBSFYvOFpwR3p4WkI1MlU5eTFPaksxVGRSZURFU0FC?=
 =?utf-8?B?WS9Wc1hwVUNkb0Zuckhxbjg0T0o5N0FiNExzdkkrTll6VDZaamI5MmRIZlhK?=
 =?utf-8?B?d3UvTTVab0ZHUys1RE5PWFFTbGphN3FWT1dzVDFiWjJGbXFCVjFWV3JjVFFL?=
 =?utf-8?B?ZDZTZktlSm5LK2Nmb3duWjhGa3IyaUR5cVd2cGZrcHJ2MGtGTVBrRTNQZkxZ?=
 =?utf-8?B?Zks3Z3VMdGcyREs4M1BkdEhGamtjTTNyVnVMVFpuTHdiMXlMTGRNODU2Y2pK?=
 =?utf-8?B?UEIwT3VRZUErajNWazhxaTlrWUFsaWZzYzV4dW9pTlR1eXJBWHRld28wbkNF?=
 =?utf-8?B?R0tRS3Q0d29tR3hrWU8vVmxhcnpqcTNZNW1JOFVpZEVEYmU2VzFReFhYNHky?=
 =?utf-8?B?V1NRQ3A5K0VQQUp5U096NkxJa1dKc0NKMEQyYnBYdHVQenJwMkZ6b3BiTHRV?=
 =?utf-8?B?Q1UwTFh2OUZkVGNIZ2R3ZWphb0xqNGxIcHBOTS9vRnJXeUJyZEZQQnNXYWFI?=
 =?utf-8?B?UGJNZkJ4SmczM0FoSHBYLzUveG9WaHlCemJ0THpEQXdjKzZuNHZXZWpsM2s0?=
 =?utf-8?B?LzZpY0pHVkFXMlMyTDFKZ205czFSVG9tOVBNaEV6RmRpNC92cGo4bGJKWUQ3?=
 =?utf-8?B?WWRrdUV3Uk1rMTFLWFBIc0NFc3NjbTB1NitGcmNKVXN2YmhUVE1RbnA2NlAz?=
 =?utf-8?B?cUg5bmQvWVhFU2w0VVVKcVJ6MFl4cG5kVHJVNW53RnJnSStuc0hOcmpiVGcr?=
 =?utf-8?B?K3BveTdIVnZmS1huZ2s4Z3BtZzlrR1JzUXB2L1lTUDNWQnpyblVoNUhRbkxv?=
 =?utf-8?B?Mk5SS3VFVkZWc3BINEZtVVhkTlUrVlUvZHNqaG9TU3NMNi9iTHlzR3RJditM?=
 =?utf-8?B?dXo5b2lCaG9SQW5HTWtVeHVVaGJKdG5HT1pVa1RCRTVRWTNNQUQ5R09JVHNS?=
 =?utf-8?B?b3BlVnZoRUMxL2cwU3FXWU5DSVl5Vk9ORVN4dkY1bElISk1iYVFzK1FyUm1V?=
 =?utf-8?B?WFkzV2ZNWHAzemF2WlBUWFFob3ladDdMbk43Q0Npc3ZiN1ovZ0ZEYUxRTCtT?=
 =?utf-8?B?aGtCVDdBU2VzSjVxV3B4VS9LdGRUcG55bjMvakR0UnBsVUxaTVVINmtYOVlx?=
 =?utf-8?B?bU1sWkY3Qzg5TFpiNDZQZDZnbjFDeHhRVmwyUzNDYkF3Nk1DR2VNMUxpeFBj?=
 =?utf-8?B?NjRacjd3Mi95SHZyekhXTTUrQmE4VzBaNDhhc3dtY3VlZ21vd09oUE5Ybnkv?=
 =?utf-8?B?UlBnd29IQXJwMjFjYThwMkhwK0puYWwxdDEzSEFQVU5SbFFxbkM2SXZSL0ow?=
 =?utf-8?B?UzlKSmRKVjZLUnVSSEYwRVA1N3ljTEhuSEpEeEhsWEh5NXBTM01QcUNpWWUr?=
 =?utf-8?B?Y1F2MFoyZjZOUTRZM1F0dW9rd0xQYmVnSnkxd1Y3ZXpCTm5hUjVwSGsyU1Ex?=
 =?utf-8?B?RHgxL1VRb3B1aDVFT0lzaUJYeTNXVUEyMzZqeHN2VWRiTFhVanFPaVNXWXh3?=
 =?utf-8?B?ZDVMbmZETjJ3Nzh2TTBqNEZZQ2h0dkNOb3o1UWowemJzVnFOV3JJNW42b1hp?=
 =?utf-8?B?TnpjZDRiRHM0eWdjbFhMU2FlcDJ6RmhPU1FNVURoTFBMcE5uczc5d29mYkxQ?=
 =?utf-8?B?RDFoUjVXKzNzZk5vVk5zTGJBeU9vMEpqSDNpdFRKZGtYMW9oaU1DejJjVnVQ?=
 =?utf-8?Q?trNsF0vy0UaOUHTxQ4hTi9/89?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ebcfcd-a22d-40ff-00f7-08ddcf2d88fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 05:54:23.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5dfSuWM2YKGmTrXXX6M7sUTSvCX3dqdzxZ3tLSvZsDQFwCKJHGY6cWQctJ72d8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573

On 29/07/2025 13:23, Vadim Fedorenko wrote:
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> index f631d90c428ac..7257de9ea2f44 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -164,12 +164,25 @@ nsim_set_fecparam(struct net_device *dev, struct ethtool_fecparam *fecparam)
>  	ns->ethtool.fec.active_fec = 1 << (fls(fec) - 1);
>  	return 0;
>  }
> +static const struct ethtool_fec_hist_range netdevsim_fec_ranges[] = {
> +	{  0,  0},
> +	{  1,  3},
> +	{  4,  7},
> +	{ -1, -1}
> +};

The driver-facing API works nicely when the ranges are allocated as
static arrays, but I expect most drivers will need to allocate it
dynamically as the ranges will be queried from the device.
In that case, we need to define who is responsible of freeing the ranges
array.

>  
>  static void
> -nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats)
> +nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats,
> +		   const struct ethtool_fec_hist_range **ranges)
>  {
> +	*ranges = netdevsim_fec_ranges;
> +
>  	fec_stats->corrected_blocks.total = 123;
>  	fec_stats->uncorrectable_blocks.total = 4;
> +
> +	fec_stats->hist[0] = 345;
> +	fec_stats->hist[1] = 12;
> +	fec_stats->hist[2] = 2;
>  }
>  
>  static int nsim_get_ts_info(struct net_device *dev,
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index de5bd76a400ca..9421a5e31af21 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -492,6 +492,17 @@ struct ethtool_pause_stats {
>  };
>  
>  #define ETHTOOL_MAX_LANES	8
> +#define ETHTOOL_FEC_HIST_MAX	18

I suspect we might need to increase this value in the future, so I like
the fact that it's not hardcoded anywhere in the uapi.

