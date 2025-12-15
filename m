Return-Path: <netdev+bounces-244860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18697CC02E6
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 00:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBB4F3011EDC
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80C29AB02;
	Mon, 15 Dec 2025 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t+k5bJ8B"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08121C17D;
	Mon, 15 Dec 2025 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765841956; cv=fail; b=K9MxOHMW40hvlHvuIceGvsWaDiGki5bRcKhPxcCUqwO66a7ufYlGsBdkkmMrHvIXkPZgk0rcAiEweCcgbR3JSde5dDuaRjNhbdTfonqp5Via3WS4nMInmtScvXT7KYlZZoYrt7LzA4LgWyv07YxT0V+4VOnArxCSjduGozIBlMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765841956; c=relaxed/simple;
	bh=25Sym7IF6MScBYaAHAFKatyvAxlUeRggNyt4Q7sPPTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ng3mSfNNinQ/2lz7COPkUHfy7L+HZSPhOMPeTo9iOVuFft2bhtABgCvjufn4+zZipTP48qR+DcSEdph4o2Pe16hgTfPrcAEi/YLzcWBo62aI1zmzoH2OIWLaqcKtsPkKhq5B4x1Fvet2+7X1GuxQ68WvGoULWI0G1kwuChAXzGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t+k5bJ8B; arc=fail smtp.client-ip=52.101.62.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECoa8rmE2fezIV29Dyj4i/SF+2et5aMAcbVPfZtlPkKI957ySmFybopT1taDmbQoRAK291HVj+8O+BI8FPKifm02UaDe+V8qHWNArVY+qHm3htvs6xJQ66suC+TELxi5aQSJWbzYPkbdxcAAF5Y3Wnb2FYDjY2PZ3WA6DQOQee2RV7KqGfYUMmVjY5oXkdBKZEQ53Tv1XjkjeuU3KPbFeX8stnAZLzDsjpc9azAmySZ1yYorEM1c0CO1onujYu+6eKPgt4nI+V4Ag9WYbh2J3hk+Qbq9phZUdvQ2uh8dNvbH5kCHKoxS7YujBzG0KPc+xb6loO7/WvuItwY5yLjhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYPoIrpEQh7xHtgmitmn7SjU8JgLgWPnP9zzB+CMHpw=;
 b=UniEemEtM4QOGjE8CiY05YQ9qT+9NueqtAfOEa8qvukNrDVK5QTN1GPIeZt/W46o7afuK8BreGlaVy0YoBnScfRweSKcIbJIdnJ4Jo7Qu/j2U4Z0aABpSVgaPlerNht/EYhj8tbppwN/FW7PH4ZWXuI/mQvbNXeh+43D85SjIejcP7E16zGXR6XWtCa26KikbjOH4DzsyPcVOr3zOLQ+VjkB/jS1YxmEHCQn69T7oeaf11HOKbVbdebX9DZh+i+XqxZQm6kaCq8fnJnX8m0jjQZZ8WwRGTIl40/x2sBV4g+LmWgbwzBSLEVhisZZ2QRm2bq7r+no9gegxIDLGPkdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYPoIrpEQh7xHtgmitmn7SjU8JgLgWPnP9zzB+CMHpw=;
 b=t+k5bJ8BeixpQ/tpFMaAwtoKr0PeM6S4pWNXp0YlgTFlUqS0uNZBU7zUjLQ+Dk/fwayKkrGmChvSTQYsWM+jWl8T3R2FsnNp2h1jTBb2aeSlQCbG2uE6Qcg/2CVugmgiMmoaz8MuRAQz1h+aHTalgKUUF5FSHKRWUnNha1Y3haE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 23:39:11 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 23:39:11 +0000
Message-ID: <9b7109cf-01d2-4dba-9e7b-7b94094ef4db@amd.com>
Date: Mon, 15 Dec 2025 15:39:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v3 1/3] net: ethernet: mtk_eth_soc: Add register
 definitions for RSS and LRO
To: frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Mason Chang <mason-cw.chang@mediatek.com>
References: <20251214110310.7009-1-linux@fw-web.de>
 <20251214110310.7009-2-linux@fw-web.de>
 <d101cf0e-bf7c-4aa7-a444-f6b61a1854ad@amd.com>
 <033E8AC9-21D6-4707-AE75-37556241CC52@public-files.de>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <033E8AC9-21D6-4707-AE75-37556241CC52@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:510:2da::9) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aed2131-2185-4f94-016a-08de3c3325c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djQ1S1NtTkhPMGtiOXVtUUV4ejM1Q3htTjV6U1JqZWlLV2ZSN2J3Wm1oRWJk?=
 =?utf-8?B?QlZXZFYyaHVBSmFXbGxwazErTFVmTUwzNE0rNDR1bXMrMTFhWHJvSnJrVVRO?=
 =?utf-8?B?TDIwZ3lXektqOVVuYmdRcjhwekVja1BoaENMVWY0SWhjQUNFYnR5MTdTTG9O?=
 =?utf-8?B?bFBkVGZhMFpYSU5YQlBvVFppTFJvQ2NTZGtDazB1TUZ2WEFTQVpaRG5RNTZa?=
 =?utf-8?B?RVd1M2J1a1MxZ0ZaYjljYlBCV3Z4VkJWN0c3eWxwUHJNQ1h4U3VVMXdWTE5N?=
 =?utf-8?B?YUxtekdaQlUwdFRLNzNwNk9Hc1hXWDcvbjZXUEw1NWFVQ1I4NXBialE4ZlpT?=
 =?utf-8?B?NXdRMFFPd0ZkaitReUFtWGJ0OCtxUFRtOGU2WXlMTHVCQnFoZmpkRno4VFJr?=
 =?utf-8?B?UHF4YlVQbnR2S29NUndTRXl5T25Ia296clU0bmZzeW9qYWVpaWQ3eEpwK1hI?=
 =?utf-8?B?Vzh1ZSsrSGdzbVZZVnpnVzc2cjJGWXBGV0tGTHJGLzE3alVydDBSajNPcGdC?=
 =?utf-8?B?Qi9pcHlzdVF4N0thL0haWVZDSWE0ZXJ5OWpUUWJBK3NXNFcxaXJmZk16c0Qw?=
 =?utf-8?B?TU5TNnZ3UkJGUDNwWTQyK1hLWWxKSEI1NG9KZzJpUXlvRjJYWU9zN3BzTzdG?=
 =?utf-8?B?eWlyS0NrUGdhQjd3T2lTM01TQ2x6bmI1QzNkbVZKY2g2anVLeEIxWUJjcDlH?=
 =?utf-8?B?Q3AyckJBSFlLNWttZmE3aTRmYkpTNzZjN0JVQzBxMzRGcVRqc0xjeFVwYVZp?=
 =?utf-8?B?TFlaUmNzMzRlRVZ6Y1c5L0M2UHdZU0huaU5OR1pJOHlmR2lGU1RDazBtMVRy?=
 =?utf-8?B?R2pUV3FVOGt0Y0pDNlduN1dlbjN1bjluZGVBcFdCUlY3WXJnSTdOdmI0a2NZ?=
 =?utf-8?B?TTJkbjlORkg3czFSc3VtcnhhRVV5ejNGb3RiUnNFbE5TWkZZMWQxaXhYR2V2?=
 =?utf-8?B?RS8rdlpONjl5elh2UUl4TjZnbG5TTjJRNlV1Q2pqeVk3ZjNVVXBvU2szTVFW?=
 =?utf-8?B?WFMvTVB6elY3TjU1eGhwajFRZmhDNVFQL2RxV01ScnYvUzlnZnZIbFd1aVl4?=
 =?utf-8?B?VEJIOTZaQlRTNWNFTXRpRXVVaFFOWU9zZkR6U0dtQnIzRkxxb1VqaytiL3FV?=
 =?utf-8?B?M1d4dU1oWVJQMUtIZkZ1aGxHNDVJYm4wb0pwVlFvUGJTKzArZ0ovSi9EL3VZ?=
 =?utf-8?B?TWNxalYzWm9IRXRPb2NvZW9ENVBzK0pqa3B5QlRXTVlOK2k4TmVxVDJmc25D?=
 =?utf-8?B?emh0QmJGUVNWSHlJcnpxaXlkellqQ3daOGRpQmlSTDBybGxzNE1YMndHRmhN?=
 =?utf-8?B?c2VRbnhDQ3hORWxNUG9XeVh2NDhvMzJ0TU5zcWRQS3U1c2xTdE8rNTQxd2lW?=
 =?utf-8?B?SVA1RlcxdkJVdzNsdXQ1OGJManJET3RCQXpURUZpYm5WcFNNM0UyUUZhaG80?=
 =?utf-8?B?YWtHdUR1Zm9BM3grVGFNaDRhcGRUSmtLNWVHVEJlRndCZEZ0eHB4S3BJUlFk?=
 =?utf-8?B?NjBEWGRjZmtiU1VmdDJLM210aWx0UXpxdkpBemJXRjZXdGZkNnVJUzFHTzRj?=
 =?utf-8?B?ZWQ2R1ZVT0l4RTFoaEl1VXhaQ1hQcjlHbVhKTFJCbUtKMmlQL3NlcVZNaU94?=
 =?utf-8?B?WEZ5OHAxRlNHenBDalNUNWNrNmFobHN3azU3M3RMUEVwRXUrN0Q1SDMwRTRi?=
 =?utf-8?B?cTRGVklZdWdFWG9LYStoTml6Z0lOYS9aVTZvN2doQ1JZMS9NcWVBZy8zYWVR?=
 =?utf-8?B?Sy9ZOVV5em1yNDNqM0JjWmhZM3N0c3pzWnYzb0l4WXl1S2V1czc1T1F5a21D?=
 =?utf-8?B?Yy9iMUhMZzVYOTY3UDJUcEVQdStNaE9BRm5SOHNoYUdZbEUvbytJSWNrbTRp?=
 =?utf-8?B?WXNNeVJUYVlsMkdUS1BDMkhhRUJwNnlaYnRPNkV4Wmx5VlYzeWl1bzVEUmVv?=
 =?utf-8?B?K3NkaHl4TXJNb1d6bVNMMldrRU1wT3Y5c0NuSWJmNVlvMTZHWUNFYkpOVFBi?=
 =?utf-8?B?eHc1QVpqTTI5ZUxRREZiRzZYSmxncHBBNHIvallnS0p2T0k5dEdyMU84NmNj?=
 =?utf-8?Q?H0gKrg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXh2UmpxWXA4aXoxTWNBY21CQUllQStrMHplSFdTZXJERXpyMXRwL1RHSHhI?=
 =?utf-8?B?a2VnUzRwQUJlT0RCQVRyMWJRckVRKzBOcm5oYnN5S1pHU0tqSGxYbVZXNWJJ?=
 =?utf-8?B?L2VUL0QwZHVtT3BPZ1FNRkNqWkx5d3BGQWlmQzFpQUhnZlVyQWNqM2RWZ01a?=
 =?utf-8?B?V01CeVVlVFlGdGxlcWQ1alNMakJmZ1FSazZhdlE5TmRKeVBWZmhHK3cwZnhP?=
 =?utf-8?B?L1ZqL2ZDVDh4WnNaUU9WaUVtdWJpQ2FmVjdndHdMMUxPeW9XT2U0bzlzMmtw?=
 =?utf-8?B?bnJvZmhESU1yNWNMa1ZmUmFPNkhCVjZPSEpSTjgxSndvQldubExQaTRQTFFO?=
 =?utf-8?B?TDFVWURoNlF5SUVmbGJxVGNZa2pLWXp0WGtTQVpMV2UvT3d6QkdPcjRDSXdK?=
 =?utf-8?B?cUt2dzlOa0JXeGdRL2c4VEtpK3VLd0RCVElMVzBRSW5EREtWa0dNN1M4OXJ0?=
 =?utf-8?B?OW15a2E3TStaTUZ5K2UwcjZ4dHJoajFVdFg5T01OUXZacFduejRtTVdhUjdI?=
 =?utf-8?B?S3RHNmowdEd0VXRodzJLdmNyQ21KRElXVGF0VThKR0tPWXgyVnJvWlRQeDQ5?=
 =?utf-8?B?VmdVN0preGg4bGx5eGJCbW54UmE1cUZwTnJFeXB5b1dIaGwzMmpiQnhiSUNX?=
 =?utf-8?B?T1ZReit0ajRKc0xNVW1HK0xTaVF1ZFByYU1yRkVyNFdUdXVLK0xRN2RGemRE?=
 =?utf-8?B?ZFVDdXRDOE5jWVI5emNxSmtMZlYxNDZqWWtMUWd1YzBuY0dLd3NyU0QwSE9H?=
 =?utf-8?B?R01ZTDRydmZrZkpkZWlVcnZhU3FFdHFoK3JkbzFvUVJ3RWNkZHJKMmM3ekh0?=
 =?utf-8?B?VjVNQ2dsUE5yVEUyQldXRWxoTkU2MzJZVHBJZVdsZEVJWDFWa3Y5dTBGUXR0?=
 =?utf-8?B?WEdSLzV4Z2h6U3NUK2diLzF0R2ZiUDBFaS9CSCtNOEhmTkJMWVEzamdsQ2Qv?=
 =?utf-8?B?VkMrUmZtSzZqSlFTSzlxc0tXUUFERHZUK25rbFEwRVpid2ZnTGhSbEtYNWFM?=
 =?utf-8?B?NWExN0ZWSm5sZGwvWll2R1ZJa0FSZWNXL2VYVEdaY3BYamVWNTdzV21VVEY3?=
 =?utf-8?B?d2NFK2JuK1JMbGpLbm4vUW15VURMemEvNVloMm1WWng1SlFiVGRGYTdxbmJa?=
 =?utf-8?B?aEhQZjZoS01mWk9ZTmY4dDlQTllHdi9MR1NmbzJVeVd5R1NIRHVjc1hTTkZy?=
 =?utf-8?B?YUdpYm1obFNISGxQdGo4K044Z3NzU1U3am8xb0JmVyt2OUFmdUJJTGd5RFdJ?=
 =?utf-8?B?U1dGNjViWVRkNElWdndQdE9ENm9Cd0dRTk9TVmgyWnlRSm4xOGt4NTdMZ1Fs?=
 =?utf-8?B?Q01WNzM5SklxZlhaYmtnODBxRkJyemdzVmZwcDE4aVc2M0hrVy93M0VuYjhn?=
 =?utf-8?B?MG81K2E4eWluTjFpTWdCa3Q3NzVaSXBRME03bFlqdVVhTDFNNGhSYmo2WVdN?=
 =?utf-8?B?MGN5TTNkSVRZeEVrS2MwWGt1RUthQURoV1hqeUFTaEFrTUhSbldrVVRyeS9m?=
 =?utf-8?B?Z2o4Yk04NTFTUC82bUxzQjJzSzZoUkhRNmJwK09wQWJhdlBvQmtCK1pKcVBv?=
 =?utf-8?B?cXY0OFVJNTZkRngveWw0dVZDZlNlMjRJc0puTWFNVVpCTDJnOC82WXZVR1Iv?=
 =?utf-8?B?aEhJUVRJNXpZUnZnZ1FOTEZWRURycWwrazJEbURkZ21MeTZRMnNDRE93QWk5?=
 =?utf-8?B?bXJnKytZeEhxY1dqbDEya2xSVFZjR1BRTmNvZDdXLzFybjV4RU1MclVFYmo4?=
 =?utf-8?B?bkhoUzNReHNmYTFiU2E2Y05FUC85MjlTRXdQMVhxNDhrNlU1bythSEFYMHYx?=
 =?utf-8?B?QnFqNU53Q1R1MUprNVR2cjZSWlhDdnk2a05OZTVKdFJOUkdXVFo5UDdCQi9R?=
 =?utf-8?B?RWJiZ3JGQVRwdVcrbmRJZkNqNEQrRThueEk1cWNFaVdpamVTUVk1Znl3dkw2?=
 =?utf-8?B?T0w0WDlYVzdMNFJVUTJyQXJuU3V0WWdJOEk0dXNXa1ZwVXRKUzd0MEp5Z2Rq?=
 =?utf-8?B?VDNId1pDbTE4K21KM0c0bTZpZHRpMi9DTFFvTjVMY2pzK29EU094dTd5alow?=
 =?utf-8?B?dWNoUjFoQXQ0dG9NSDZ2Q3BQTFd3NTloVXdNZVRicWxHclNFM3gwWnRyem8y?=
 =?utf-8?Q?dTcYWSoK+l3sbUxHd+vpAtrkC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aed2131-2185-4f94-016a-08de3c3325c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 23:39:10.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQE/tPdC83a44jeThOuIp6ama0CrYH0dOda1v2oZaB64lgyLD/ROSG1PztTmIzodGfxoOcCV6T+0sEHWyCsq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815



On 12/15/2025 11:57 AM, Frank Wunderlich wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Am 15. Dezember 2025 20:28:36 MEZ schrieb "Creeley, Brett" <bcreeley@amd.com>:
>>
>> On 12/14/2025 3:03 AM, Frank Wunderlich wrote:
>>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
>>> index 0168e2fbc619..334625814b97 100644
>>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
>>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
>>> @@ -1143,16 +1143,30 @@ struct mtk_reg_map {
>>>           u32     tx_irq_mask;
>>>           u32     tx_irq_status;
>>>           struct {
>>> -               u32     rx_ptr;         /* rx base pointer */
>>> -               u32     rx_cnt_cfg;     /* rx max count configuration */
>>> -               u32     pcrx_ptr;       /* rx cpu pointer */
>>> -               u32     glo_cfg;        /* global configuration */
>>> -               u32     rst_idx;        /* reset index */
>>> -               u32     delay_irq;      /* delay interrupt */
>>> -               u32     irq_status;     /* interrupt status */
>>> -               u32     irq_mask;       /* interrupt mask */
>>> +               u32     rx_ptr;                 /* rx base pointer */
>>> +               u32     rx_cnt_cfg;             /* rx max count configuration */
>>> +               u32     pcrx_ptr;               /* rx cpu pointer */
>>> +               u32     pdrx_ptr;               /* rx dma pointer */
>>> +               u32     glo_cfg;                /* global configuration */
>>> +               u32     rst_idx;                /* reset index */
>>> +               u32     rx_cfg;                 /* rx dma configuration */
>>> +               u32     delay_irq;              /* delay interrupt */
>>> +               u32     irq_status;             /* interrupt status */
>>> +               u32     irq_mask;               /* interrupt mask */
>> Small nit - is the comment alignment really necessary?
> I could transform it to something like this:
>
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.h#n921>

I think it's okay as is. I was more concerned about the extra noise, but 
it's a pretty minimal change.

Brett

>
>> Thanks,
>>
>> Brett
>
> regards Frank
>


