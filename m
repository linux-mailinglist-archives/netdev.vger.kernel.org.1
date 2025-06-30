Return-Path: <netdev+bounces-202492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D1AEE13B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D11916A889
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2AF28D8E1;
	Mon, 30 Jun 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zT37tkc+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC1528DF16;
	Mon, 30 Jun 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294345; cv=fail; b=nBTEZ4jyndkcN+jshXDgYmnw84g0EZ2rBB5medSzFXMNkf421aYpaPvX7sb6YirfKNLXY5E5e5dTJ6tAtY2ra8B5bRjKSPzA37+IFhCZhA9LhUHBRwFV6nDKhkuOXFWdNTzP1dAqpX7oZbRkSlO/VW8+3vZmDkHCIBgrnkY+P3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294345; c=relaxed/simple;
	bh=MUzAvECoYdQ8QnCkPQa/MoK1XgAokuPacKJD/1F2hQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=omdVA32GUo0zEYIu//7PuW/cKHGToqniUZU1k6plIq12iBGKmwsX6qR3HrtWsVEZo7GNRE8A97oNmqfAVYjBibHQa0fnKVSH3vN87ckyQdNjMdd3+DvWEwlVwTpJAPFfACJy0qyIbqTlXlsLZLMNG7NtWVis6eQqU9ucB9X8Xh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zT37tkc+; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3zrZii5F0ECzNLPyUYRbZ+tSLsl5Nluq+W/CENDW/q+Cx70TG+ABP1j0LpWurwZtAnEAqwJEBGuJ7XCsqgZsOcZZvpf6nZgDKCRr5yy4DifF7lD4cNfbIKiG7Bf96+JUzRT7F5l+Hgbj4lBzwL3d2NFkGW9ut/MOMUMXg9D7zfIo91CllYlFkbrme2rw4ZRmvv7To+G1fm8OIec9iMUGHhGmDu5ivL8FhRao7L+TTwyKZZBJelulRcAI4OgsvfYJgwGAGnlTuYxr6TjCl6MoGiHFBHIwyuBOJBzoPnP6gDkJvb77GUBPbdCjJFswf75SSbf3km5tfEeHyZnY42KQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCho0yWaAl2KfZlSY4KO3/wmaHmLl1OjFJ0zLPxs/Kc=;
 b=F4p/TzFpOsGzojRoze50KKG0Y6BWICqYw/CJr8JLLRf2DXfPxnEfawwU/4tyIDXmvd9aHLSy6hkx6BrT1wHiLgfEld5imhdydNYv0d9Y+9ItoMCsn7LPgyduUdIHLs5Jhw8WMQQi1gAvsipO0Y0scdmBB4B3RzxTy1e2JGK/RMeJVBTd+V2mDokWy+pjfc+tZBU6PcIrhq5xK8isCnTbLTnoJc8cgM7q2LQPbZqPah+HMkHKYsaNMTWJ/lQYF/ifOwPHs+fHJhK9MQI2hclcteIaENYv3ptgFROmPDo96MLQ/cssJXwHS8luP81HYZMB8CUOMFRjF9yrOOltEome6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCho0yWaAl2KfZlSY4KO3/wmaHmLl1OjFJ0zLPxs/Kc=;
 b=zT37tkc+eTqIscFkxPJ7M67yDzueSjv19jELfQ+APCxKzoiSOTIAgpbslxiNoTFczvyPox69tg1nR4fgf6F7x6qIIfa4qX2A35iINHv6xMGkJvkklqFgLO4cRb2x0lMgfwAYRjrtrHl/+d4i3tmJzhcxWChFrhyaXC/mqmnKcqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Mon, 30 Jun
 2025 14:38:58 +0000
Received: from CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476]) by CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476%3]) with mapi id 15.20.8880.015; Mon, 30 Jun 2025
 14:38:58 +0000
Message-ID: <449633df-8c62-46f7-bd16-f0cb33ed9cc9@amd.com>
Date: Mon, 30 Jun 2025 15:38:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 01/22] cxl: Add type2 device basic support
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-2-alejandro.lucero-palau@amd.com>
 <20250625150628.00002255@huawei.com>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250625150628.00002255@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::32) To CH2PR12MB4199.namprd12.prod.outlook.com
 (2603:10b6:610:a7::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 53394cd9-0985-4a0e-ab0f-08ddb7e3d891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkRUTlB3N2YrMGcwRnpNbDlhd1pqbUJsdkplbFoxcE1iM2dkWmh5QmQvU1gr?=
 =?utf-8?B?ZklzWUZ0UnA1dHhYUnNvbmxJRWZUY25ERnY5eDNKZ3lKQkJEZUtqTHNkd3Uy?=
 =?utf-8?B?SkhFNmNHYUNGeVlhT2pWdFNIRnNxUHVITmlHZDg5dnM4YkZNZCswYXJmemM4?=
 =?utf-8?B?QStZNmJVbkhka3h4cmVMSTJESlo1UmxPZ0ROeGVKcGR5WnViWWJDd004NWtx?=
 =?utf-8?B?Qm1MTGxNU3lQc2JJMlZkY1k0dUZKT2RJSHNGRWFPenVxb0tqVEwrMVdsVWNB?=
 =?utf-8?B?bm5YVVVkQmpOK2VtZGM1cDZHZzN3bUhaV3ZzNjRDMXJXRS9OK1NZY0pmSXhj?=
 =?utf-8?B?L3N3QXUwR29jcE1yVk15OC82a2QxT2RnZU5VRkk1bStzT1JxT1o4d2VKV1ln?=
 =?utf-8?B?L2ZFOHhQYTRiMU1jV0hQQjAyZHVXL2hBajgyQzVUZkplQkJZN1JlSWlTdlMw?=
 =?utf-8?B?ZnU1bFh1eUZSTU9FTTJWdHJNV2VaWVZhNmt2MEZSbkgyVlliU2R3cTJoRVF4?=
 =?utf-8?B?bDgrVkxWM0xqQ05Ick4rSW1uYjNlaTJXWmdJTFhxaXFBMitMT0ZleWg0VFV1?=
 =?utf-8?B?RmhXZmJUN0xoOUdkRmdVUVJQZjNORnhtYmlMdVB6Q09IL2xUeFJ3a0VtZENW?=
 =?utf-8?B?aURtaTdNMEJ1b1hCYm9DLzVXZUtEVjB0UmlZbUxGMVpiK3VFTHM1M2FpZ2Zv?=
 =?utf-8?B?bGpuQmd4Wk1DZkRhanZzTkp4eURLeTBDemNqbWsrWjA0M2c4NDQ3NUtsYWlr?=
 =?utf-8?B?d1hOT3J2RjdhZ1lsVjVROVJWcmkzTHhtOTU2QVpOZHZJaENFQ1g4ckhLckNq?=
 =?utf-8?B?Ry9sNzBwUytuTWJkSGFwZUxzb2JTUGVXRWNEZlUxRmNvbEdyaTdKZkJndUFL?=
 =?utf-8?B?ckhwWmt5ejZXUHJIaEhxZGtZK3RvbVVMVVA0Qm9CSTZBUUlINk14WVVXM0lk?=
 =?utf-8?B?WHFWR3ZrcHlncWdqK1BaaEpOQ0pqNnlvTTErMU5lV0ZVQzBaQ3lsN051Mzdh?=
 =?utf-8?B?OC9MRGduNFZjYWF6NTdFeWxpalV1blFhWXoyZFh3VnZqVW40U09NVWJxd3Fx?=
 =?utf-8?B?bm5CcWxlL2JhVHlhSnRNSU9SVjBKQmxDS2UrOW9EakZCc2hMYTBQRmNtWDQ0?=
 =?utf-8?B?S2lFY3JLY0tmTy9JMHlEU084YmN4NWcwTHEraVBMaHBQSjE4OENBTlN2Rkxq?=
 =?utf-8?B?ZWZCM2x3TEJiYWZhU3FzR21Ka0o1YklZWmQvNC9mdHNBVmp6SWJQNTA1UEJF?=
 =?utf-8?B?eHVvYXN4Q3ZVMUg3S2hKOVFSYy9Uck5kZkdFdWFqR2YyNDZQd21mODFOMkJU?=
 =?utf-8?B?VnFaQXJUMzlUOUNESGlBMVJ0aXNYdG1Za2l3eStHUUZmcXJPK2xQdWxRWmlG?=
 =?utf-8?B?aTMxaU1MeHFSYlZtOU1oSWxLN0x6YnJBZlE0dUx3dWF6aDVLbmMrMUVQOXJB?=
 =?utf-8?B?Q3A3T3VnaldJSkRWd3hNYWxyZHpTeFJ3clpwVm1LSTdyak91K3RPWXZZUC9N?=
 =?utf-8?B?S24rL0VDK2M4VXErODhJTmEzb1dnN250Z3NrZllmajR6bUdGQUwwN1JNOGFH?=
 =?utf-8?B?S2k4YkZDM0hxTE04WS9uV1ptWUViK0dZMVZSbHZoS3NKNWV3Uk9Jcld5VzBI?=
 =?utf-8?B?cFA4WnpiQWhwM25qWFcrZXFmTk91TS9wVWtrSzZPKzdGRjhhTEMwN0ZWSjY2?=
 =?utf-8?B?NlUrZCtVa1FUanN4WUQrWG0waGNDczREZkFMbTJKNThGN0ZzOWtPY0hFKzlJ?=
 =?utf-8?B?Yk9sL0lVb25KaE9pelBNZDYrVC92TEU1TW1JMldvSjJlY3VjVHVwcnNrQzhx?=
 =?utf-8?B?eDYwdTNMLy92QzJ2ZnRpVjl3MEYvMUpTMnYvWFpFQldESEVuNmxIVVVOckR1?=
 =?utf-8?B?aDBXV3h0MjRrckR2Q09GYkN4Y3dhY0REOHluZFhWRWk5L2tyK3FkRkpJZzVJ?=
 =?utf-8?Q?ns7NDCSEWCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REhzSWVSajFzQU9RbUZqWTFuNkxtT2RZVmxWdEZOa2tIWWw4THhJNGtxV1RN?=
 =?utf-8?B?bXV6NG9PdHlqUGl1RjlnODBBVlV4V05wNWluVTBYeUNaZ1RpRDFHZlNtMm1q?=
 =?utf-8?B?Sm5laWxyYW9GQzZRK2lKYnhISzRFMmdBL0c5U2dtcmFIWHRPbXhIazZpTWo1?=
 =?utf-8?B?M1BMcmltUVk1NkZpQVNRV0o4OFdVOVJSTkFDWDJZU0k3YmFVNGdpSjNSc1lt?=
 =?utf-8?B?Tk9aWmRQaUozckptUldCSWtndU1vcFVuTkNoQkR1ZlM3bFZseEhhcHhzNDBz?=
 =?utf-8?B?WGFmTWRycXIvWDN4VWo0VnltWU1hQUlOS0llTFIvblpYRXNqZDBNRm5YbE1T?=
 =?utf-8?B?YmVZaU5DUkdmOW5hZlkyVEtMUmhsOHROUHZtdyswRnI0T0hnRzRtWlh0OUoy?=
 =?utf-8?B?Y3FCL25MaUZMeEI0YlA4UGhvazhZRDhVa0hpSVdXenJmV0lHMEVrRmtCNHVV?=
 =?utf-8?B?YlE3QlRPbGk5OHl6aGZQeDlPeFp5R2poVjVpLzdWMzhCMncrYzZzdTgzVjhP?=
 =?utf-8?B?cTRjRFJ6WnBlZm1wejNlSXNCVHNwUG9PaEtrY3RLNnpNTTUyMG1iYXJ3K283?=
 =?utf-8?B?am5aOE1LZ1NCRVlJUzdQUE03SUVzOTIrRFd3SlRhbUg2dllHb2Npd01hc1p0?=
 =?utf-8?B?SnpuTWRYamhOb0tuZ1hScFhUeTFrZWZjZTVGQ1BzWkNqYnJSekJ6bk91b0c0?=
 =?utf-8?B?bVZNenZNSzBpU2NUREczdFhFeFBRUGtyaU83dVFhcmJ5UFYrc1Z6S0tBY2lq?=
 =?utf-8?B?UkZGTTV2bkdDRkN3ZWtRdmVQSGRFbnJrU2Ixc1dNWDBqRTRhMW41V2g2ZVd3?=
 =?utf-8?B?Z0ZkRU1sa0tGaERMTTNEcnJ5UFV4ZnhkL0hSMmk3elJrMUZKNk9jOHlvSXdl?=
 =?utf-8?B?STZTUWVSbElxdkdHOC9VWmgwSVF1K1AxdTNHZUx0VjlJVFk2TlhaRm9KVTg3?=
 =?utf-8?B?SU54dldYcFZlMWtmY0QvS1ByNTlTMTFicWFZZFZXNTNQRHZ4VGlrMmdIRk5X?=
 =?utf-8?B?ZDFOUGYrWG9GYm1LZGVjeVkzYnJrc1d4Vjc3RzBPWEI1M3lTRnBYUDdadnFU?=
 =?utf-8?B?bVg4S2RaM1NvK3ZJQklCb0V1ZXlHbUNUbXJZNHlGQ21od0JneWZZQ0tnN0dB?=
 =?utf-8?B?RUQ1Rks3eDE5NUZCaUJOZlpYZkUzUE1VNHMzMTVxeGRpYUQ0YUpkQ1JtamlF?=
 =?utf-8?B?UVA3S2Z3T3dyQkJ1Vlp5MURvM3pkb21IY21JWjRSU2ZLVFBUV1RUQ1o3Nzhy?=
 =?utf-8?B?aHROMHNqeHNqaGpWNVhYV1NxZlBPWmlRYTdWOXBmUTBUcVBVYURzRXM0T0lS?=
 =?utf-8?B?UXoyZEVqRUFCNTh6dWFmelJlQmpuMmZMWG1PMjJncUlwNytCRDduMVY5UVVj?=
 =?utf-8?B?R3YzSmNUNXdDczNpYVFvYmhFWWovQzJhQlZwRi9wZFoxcHBJVXlMNm9RZlRz?=
 =?utf-8?B?ZlRyOXJ0MEJWSGVIMzVYVjM1MnhVZERDQnVWNDFONUh2QjZIQjFKbHlUTUc0?=
 =?utf-8?B?VUJHM09rY1lZU1loQzA3VFkrdUxQb29SQjEzdUJ3TWtyM2JRZHZWdWtieU9s?=
 =?utf-8?B?ZkxFbXh2RHlUN2EvYTY0NCtSVnJoZE9oUThEMjRKY0RrS0xCeStQakRmZ2Zv?=
 =?utf-8?B?OEhqTXRqK0lDQytwOVZaNVNLQ3ZEWnJrUm04NnRTbGxkS05zU3o5VFR1NHVt?=
 =?utf-8?B?ZXlYa2NWUUg5cUkvdEx4bHBRVFVMcFF6cytnekJ6ZnFNWkF5RHhQQ3NvZWJO?=
 =?utf-8?B?ZzE5dVYrYitBREx6cjQvWEhDUEJibUF4R3EzVGsrSWovZFk3NnQ5RCtkYysr?=
 =?utf-8?B?TjZMc296dGhSVC94Y1NWL0lMc2p6K2NiMzdNUlorUklLMkx2VGFJcUNLRW5Q?=
 =?utf-8?B?MGQ3M3dLbjRZTEhUbTFSeFYwYkphL3FpeFZCWGFYRnM2ZU9wN0Y5cTlhcEN0?=
 =?utf-8?B?bnpjYXlVQ3M3ZHZITnBSTTlCUWViMy85NlZ0b2tJU3hqbHJJbVRncW51RXFT?=
 =?utf-8?B?MERqZ0d6USs5ZmtDalJ0c0w1Q0NiRjBkVk9OMEdXVjBTdFZMeWU2UnB6TDdG?=
 =?utf-8?B?T3R4TlU3b3hZeFlrYmd5TTV5Ky96aGNNa1lHT3lvVDBvem9mSS9oeWx2bms4?=
 =?utf-8?Q?V5p1f5Jd7mgsZ20BPBUTGup1U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53394cd9-0985-4a0e-ab0f-08ddb7e3d891
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:38:58.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/5OSXX+MBqK+dBO5W2VNHFOGmvKPgnu8ZShfkseZ3eV/3bpMR8g1wecNC6xw1JbRpuDQk42/SG9VvEcLOTLSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874


On 6/25/25 15:06, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:34 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alejandro,
>
> A few really minor comments inline.


Hi Jonathan,


>> ---
>>   drivers/cxl/core/mbox.c      |  12 +-
>>   drivers/cxl/core/memdev.c    |  32 +++++
>>   drivers/cxl/core/pci.c       |   1 +
>>   drivers/cxl/core/regs.c      |   1 +
>>   drivers/cxl/cxl.h            |  97 +--------------
>>   drivers/cxl/cxlmem.h         |  85 +------------
>>   drivers/cxl/cxlpci.h         |  21 ----
>>   drivers/cxl/pci.c            |  17 +--
>>   include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>>   include/cxl/pci.h            |  23 ++++
>>   tools/testing/cxl/test/mem.c |   3 +-
>>   11 files changed, 303 insertions(+), 215 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index d72764056ce6..d78f6039f997 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1484,23 +1484,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec)
>>   {
>>   	struct cxl_memdev_state *mds;
>>   	int rc;
>>   
>> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> +	mds = devm_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial,
>> +					dvsec, struct cxl_memdev_state, cxlds,
>> +					true);
>
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 3ec6b906371b..9cc4337cacfb 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -7,6 +7,7 @@
>>   #include <linux/cdev.h>
>>   #include <linux/uuid.h>
>>   #include <linux/node.h>
> Is node still used in here?  If the includes was just for
> struct access_coordinates then that is now gone from this file.


Good catch. It is not needed after the code movement.

I'll remove it.

Thanks!


>> +#include <cxl/cxl.h>
>>   #include <cxl/event.h>
>>   #include <cxl/mailbox.h>
>>   #include "cxl.h"
>> @@ -357,87 +358,6 @@ struct cxl_security_state {
>>   	struct kernfs_node *sanitize_node;
>>   };
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 785aa2af5eaa..0d3c67867965 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -924,19 +927,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   		return rc;
>>   	pci_set_master(pdev);
>>   
>> -	mds = cxl_memdev_state_create(&pdev->dev);
>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>> +		dev_warn(&pdev->dev,
>> +			 "Device DVSEC not present, skip CXL.mem init\n");
> Could use pci_warn(pdev, "..."); Not particularly important.
>
>> +
>> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
> Jonathan
>

