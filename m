Return-Path: <netdev+bounces-239055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61040C6307A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2B4034986B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810E3246F7;
	Mon, 17 Nov 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="jizN2vai"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13045322768;
	Mon, 17 Nov 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370136; cv=fail; b=NCYBl16EBnN3X6OYinhxP+EvQ0OW1ZJuXEHvHhh/3W/T6N+hQ7EXuAQ3bdQI9agyLTFqkeWQRNAf50jThLVCrnlCzxq9Vxjc+vyin41V8B5iWLRTrKQ94zIHVlfMdKx6qQYYmhdixHJiPymxpQ2tm6euyldzKL7hKiTs+fpO+D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370136; c=relaxed/simple;
	bh=GxR5RcpiizHWdTHygQdc0xX6g5wKgKg/5BpsDkyc4ds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=scpIxA5OQ83VK09kHNoSXXMg8XQzyhXp8g+UYt0DIEPpH5frKrJIP4pvLpwVSczo105p0g5t5Fq9ewpEm7gIqb1otgfMsC+ALDXezqIW4OlBI694H+Vid9oM5HoXWcXPnR0r8qlIY6EuT33KU5jmB45LK4DIHVSr8LwaPPAR2RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=jizN2vai; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz/AeS3dOGrghM5Wy9hSbCmLOJiprLZ50e1jpRh95TsQz0X/5Q041JV779wAWbwy9kGZT4bElptqSBAFliVTvk1fsbqRTYK2Ppq9VODFsCZGu+63CvktiaJqCn4SRhUUTPdh6gSvIFiHrQEs6DkIDLjSdlxpiJQyhgLwIJ9MB1xGxT8NOcUfQSErhbJvyNtfR8LFmKA2P4XlcQi81WTGC1tw2KvfpaGL+ABJhXrA4f3/sWFMbxn3rUBiBOUxqu9AEXv/cYvY5q42WsnIjGHW0P+V8htmc3XNoNeM1xOdKbS2S0NWou6iyyGR+Dw5urr0vKF6tJn9hzbqdE5Vg16x3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/KpDe138Yphn990VjLJCTnBaTu18YPGJTrMNc8BXuk=;
 b=tcbaR6QrrzrdbXHJWxD+e2SlGbRHUjsZkB7nB1c35WJndXloboIsxwY8qG+vG0SsFK9eVq5/xyGyEF8jRoSLwlILlEr48XGJrkltrB9F553CjBCPbi+4Xnn/Qe3Mo+nrq5YHN+MI3GY6CAoNPkANu31VCmiX8iUrNHt3q0iClv+YoU4ccP6poR3kXyd+7Vb+zAjMkmV6PnTOiNyKSpXiC0Tfs/33eUP6Ui3gMGQeJVY0hwrGtxUrRXnL+lsmn0h//U5LuDfSwasyQoQU9zRVkJcHzD+NRikFYQOSsnmG6b2qkNv5Q6EWkib1dT5dwZvDIXglZRelsdQou/u69hdSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/KpDe138Yphn990VjLJCTnBaTu18YPGJTrMNc8BXuk=;
 b=jizN2vaisVNjhITEYM7U5EydXOYgekF+zicjiH0Mu0DtTNf2JXCq5OMJxQvDFBeCQegmTUn8YpWJKuKJ4zqResvNFfiibixl7+o6m5y3JjzKPmAXAXi0F82O9vcAGLJ4SDfsfykq575ifouz3mHOnbiUAYu61vWIvsuXPBVIKio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB7PR02MB4661.eurprd02.prod.outlook.com (2603:10a6:10:57::23)
 by AS8PR02MB9768.eurprd02.prod.outlook.com (2603:10a6:20b:61c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 09:02:07 +0000
Received: from DB7PR02MB4661.eurprd02.prod.outlook.com
 ([fe80::e783:31c6:c373:2ec9]) by DB7PR02MB4661.eurprd02.prod.outlook.com
 ([fe80::e783:31c6:c373:2ec9%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 09:02:07 +0000
Message-ID: <5a7f0105-801d-41d9-850c-03783d76f3e1@axis.com>
Date: Mon, 17 Nov 2025 10:02:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for net-next] if_ether.h: Clarify ethertype validity for
 gsw1xx dsa
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org
References: <20251114135935.2710873-1-peterend@axis.com>
 <3feaff7a-fcec-49d9-a738-fa2e00439b28@lunn.ch>
Content-Language: en-US
From: Peter Enderborg <peterend@axis.com>
In-Reply-To: <3feaff7a-fcec-49d9-a738-fa2e00439b28@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::12) To DB7PR02MB4661.eurprd02.prod.outlook.com
 (2603:10a6:10:57::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR02MB4661:EE_|AS8PR02MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: 6265e74b-dcf6-4ca7-0097-08de25b7fc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFlHUzJrOXRBQ0RpVzROODN6WlRXT1JndVNlaXI3WXlEcUhKbjRPdWsxMFZi?=
 =?utf-8?B?VlEzYWk4OEhSa2dKV2Z6R3J4TEFEZ3J6OExTUkhnUEZTWE1xWTUvTXp3L2tZ?=
 =?utf-8?B?NTR3dWdGUmRsdGRmRnlYVU0ybjlEWFczc0ZYckFwZ1Awd2tSYVk5YkdhOHFk?=
 =?utf-8?B?UXcvOC9vS2VrQ0FyckIwM1BGVUtGcVBOZkUwbC92dzlNYzA0Vm5XVCtFL21X?=
 =?utf-8?B?QXVVbnF4N3JIdVpXTG56aUNpRnNhMVRnVWhBOW05K2NmQ1E3eFQzRnRlbUIx?=
 =?utf-8?B?WFNZWWEzRUVFNENDdjYveUNvcUFVb1M5WlpMdWdRMGxvbGpKZEFVTTRwbHMy?=
 =?utf-8?B?eTdrWHJIU0xuaXFsSEYyZVBQM1dyUnh2TGU5Y25kWUlTYm51bWttaWVPWTdJ?=
 =?utf-8?B?NkQ1SkNRclRKOGpLa3B5YmVaSkpDWXNwbDZMZzNaQzROaTJTRlllbmh5UzZQ?=
 =?utf-8?B?Q3hJUFBlYjZzWllLWnlRV3RlcnNxTEdZQUN0QWhrR2o1RkpYOUlva2RwSHRw?=
 =?utf-8?B?ei8rcDlJWHRoTUZJZjFOTTd1dXZKOGwvZ2dHckIyK3c0SThvQUp3M0JlekxQ?=
 =?utf-8?B?TTlwbEd4U0xyU0x3c2lCeDFZeTFhcThKS1o2NmNFZkptSGtqSU9LbWVDbjJB?=
 =?utf-8?B?VkZRcFpCeHd0OTNMeVFIYm0yUTdxMWYzSEFhWHpsVkZFT3oyZUhaMjlwT0xD?=
 =?utf-8?B?L21ZUmFldm0vSHpZbFRIMlBjc2dIdEtna25kVE9QczlxeEg2Yjd2YlVzSWhE?=
 =?utf-8?B?M0xpZXZsd21DdjZGcVRBWlpGSXNYTlBOVnJNOFE3b0tJenRzczBZZTYxbWNH?=
 =?utf-8?B?dGFzMGpJVC9tV1ZlaHpXUjRLTWFXSWRHcTlqTDdSbURsTStUanBGdjUwY1Jh?=
 =?utf-8?B?KzJLWkpxOHRidmpPVXM0enUxbXc2eUdlM0Z4T2Q0YzBEYlRsZmVqN0RLTWxR?=
 =?utf-8?B?R0lVdFFnWEdweERDL1dldnpWcXBhWHJaZnpoek9WWmxYY1AvUHJXd0lUU3Mz?=
 =?utf-8?B?OTdVNTNHTTI4Z09NNnJSQzZGZTc3Sjk1dWdQM0xHcDByWGxsYW9YdHFBeDc5?=
 =?utf-8?B?UHRlenpaZ3hEaVVlTmZ6RlU5NW1KTnhobXF4bzYxazMvOFdUcEV1YkhjaXAw?=
 =?utf-8?B?Mm13YzE3Zmt4TGo3Tkt5TlN1OFppU0h5clZ2VXozZWZsTStWS1NrWDE3cjB4?=
 =?utf-8?B?VjJ6Njl6YmhJNEN3SlZVb3I5UzlOZ1J1eDdxelJrWlpLRnFxZ1ZqVW93eXJl?=
 =?utf-8?B?K29IYWIzdGc4M0Q1eTBzWDdReHoxNm1Felp2RHAzVlRpbndxTlZNb1RyUVFI?=
 =?utf-8?B?bjhVdjhrVlIvY0c0RVBPUzdCamNFMjdaU1l3OTFwd0JjSDVGVCsySEp4UVlH?=
 =?utf-8?B?aStCb08xeXUvZkluSHhJYW55L1c1WEhCZERVb1VpSDB0TkR2Qm9qTzhRNmlo?=
 =?utf-8?B?ZUV4Z1dSZlRjSEowSTk5TU1mSnY5Ym1RYW1NOGEvVUwyYzVWZzBhQ0FFL1Az?=
 =?utf-8?B?bzAwbEQ3clZOMmxiL2hRVVYrckhscHNBeEF3WGVzUnRBcXJqckh5blZyK2lW?=
 =?utf-8?B?VEZmZDUzQXM3bklZZGZaR1k4SzhmNnc3NlQzaFFNRU53a3E1ck54c0J5andQ?=
 =?utf-8?B?WlFuL2IzTUt6RHYybXkrd05Fb3JibVl3YnJDRE9oR2ZLUUZQaDdzb2NQSWhU?=
 =?utf-8?B?QVViSDFwdGtsNUY5TFpya0hLVkMzc0dwM1loWnpPb3hmVjliaFVvUk5wcDdW?=
 =?utf-8?B?ZjhQTHhPd0JqYmljKzlQSlRlaW03ODNvNFI1anJtQ09vcW82N3RZQm94NjlG?=
 =?utf-8?B?VkwwaHh3SzlIcm5nb21yS1BvbysySW0xSVVhZFlaWnhRdXFGYUlQVUF6b1FS?=
 =?utf-8?B?TWtjYlRYYVFCSkpMeFJkWG9IUldwWVJzTnZmWVN3dnNhaFlFdW56a1lFS3Rp?=
 =?utf-8?Q?NSY3zN12LnTLdY+iWEscH4ce/o1W9qH4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR02MB4661.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnErRHdLWnl6SnZlRkgySys0RUpXOXg3S0lvREhXMmF0b09TbGgybEYxb3Mz?=
 =?utf-8?B?WkpDV2JLcEY0c2szRmNyejdMMGJnT0w3OWlsK25tRm0wanBKZEtUaTd3NkR5?=
 =?utf-8?B?bVpJdkIzOHhZRmkvbmJiWTdiYXovRG8yTG1LQzRQYS9PY0plNGRpOTNYbkpQ?=
 =?utf-8?B?ZXR3M2pqdGppc2pOSG5rbFFsWnJ3Sy9HMXN4UnQ0OFRVS3pQSk5TOTJOY1pZ?=
 =?utf-8?B?N3lrRTk2Q1ZWWVFPMHpVZCtmbVM1NDF3dFU5WlFpT3F4MHpYYS9Yd3lmZUtE?=
 =?utf-8?B?ZHo5bS9td0VHZDVoaTN1dUUyWFlDNCt4L20wNkVVNVVmbGpyWWJvdit0cHEy?=
 =?utf-8?B?V3c4ZHhoSDJ2a2wzNEdqRkRwOThkYVR4clFBUVVUQ0I3RHk0MlJUNlVHRkFK?=
 =?utf-8?B?d0RKT2p1TkYxQjFZNDZZaFNFaHlDNHpxUmRDd251M09QTjBHYk92MGQ5N3dY?=
 =?utf-8?B?cm0rOVYxL21IVE1vNEZmMWJ6SG5RNXY1QklYZFVqMmNVWnNNSk92aWdYRnlC?=
 =?utf-8?B?bGFJcDVYcHNteTh4WitPTU1IZDJ2YXYzcGpWSnFDYkp4YUZZTTZTU1pPc1ZD?=
 =?utf-8?B?QTZ4MXJKTEtwYlUxWE9wNTViOFBSMjR3eERQcTk3NWgwSTBYVkNYSk9LU2NG?=
 =?utf-8?B?S2FVWGRENUlta0x2a0Q5NjgyajFjSlcvVWZwUjBwUk5KejZxcjQrS1dBdU5M?=
 =?utf-8?B?L0dYUlpacGZjeWVZZzlYVGhJaEM0QVZQSm0rVFNxZmNUd0JhQ2pUT1Z2NEVu?=
 =?utf-8?B?MUlraGhpcWUvSU5qQjFza090bWtxQTBWMG11blE3bWl0MDQ0NFl0UndIQnFT?=
 =?utf-8?B?MGF0bDkwOXhZUlFsZEZVMXFyUXVNODR1RkpmT0p2aUgzUWRlOVRSVE1HT3gy?=
 =?utf-8?B?TFVZNmxkRzl5TVo3bDVJOVMyOVJhSUJrYUlqOUFZdUltNkpQVUtoaWFHZkkv?=
 =?utf-8?B?ZXBNbUIyOGhMUmRnMnFWdG5nNm0zc0Noa0c1WUdzUDJSQkxFZnVsMTE5U3h2?=
 =?utf-8?B?bm15NTZNTjRLUTZ5VjhvaStiSzBsNkdydVdqSjRLSnJZS09OSnpsMisxcWxm?=
 =?utf-8?B?Y2ZhdW9vWkJ3U1VzN0FDdzZTSGpORW5xeXlpVVRSTU9UQTM1UnA3UlJYTE43?=
 =?utf-8?B?bU9SMTFuUEFUK0tFTkJ3SzVQaU5ndFpreFBld1JkSjhPRkVjYTJvZmFBTzBy?=
 =?utf-8?B?U3E5bnFqcUFGbGpBbEh2dittWUdQK1M1c3piNTQwai9TazJheS9OZHh3cy9H?=
 =?utf-8?B?d2FSYStTYVhvUnc3VStIWGE4djVJTk0xbEZXb2V5MVRUOWVrWE9NcXFzMVIx?=
 =?utf-8?B?ZVkwVFpoQTRuMVl1M2dyVHJKV2V0WSt3b29FVXlXVHlTN2VXZzQwemNVSGdy?=
 =?utf-8?B?VWRPRWQ5QmxwVnlEUklGczcwQWpxS01qN3ZSa0N4TWtFNGtRSEJIbXh0cGw1?=
 =?utf-8?B?QnNpRlVaZmlPdlZJek04ZkRYR2NEN0Z0WUdnNEYvKythWEZNZVRoeW80Vm5s?=
 =?utf-8?B?bWJZSUdrWVBVYzQ5c04xdit2R1NmTnJHaStMMmgxcSt4MnZjYU5UOUJzRWN6?=
 =?utf-8?B?MDZBTnpVZENJOWFxWVNTUTJlS1BXRVN3Sm1GRGQvM1FTRnFXaXovOVFibjdS?=
 =?utf-8?B?OStQSWwxdWZLNjBZSXNmWjVCOUx2NGZZdWQ1VVdvQ2R2ODJlbnU2ZXVKWHdu?=
 =?utf-8?B?MnFuRHkrZWUzdkdlQm9ZY1g2N1J1azU0K3VKN01OOGpWWSs4UkhNYTJZeGtN?=
 =?utf-8?B?QXl5VHprUHMyY3N0ODNISzFZUUxPVE1CRytZNGxDMFFyZnRPaENLNTAwSUwy?=
 =?utf-8?B?L0gxUG0yTTBsemdkeXFJb0FmbnFZdjJ1NzltWWhYbWtDajR4cWtFeG1hNmMw?=
 =?utf-8?B?NGMzOWtGd2Q3dUZPbkc0UkhkNjRSTkh3bkJZMDJlUjdRUThCZy85d0dkanB5?=
 =?utf-8?B?WUxkM2FSaDFsbWREdld6emZzaUxrWWtiYUNaQjZoYyt4bk41OTkvSDRCaERl?=
 =?utf-8?B?NW1NTVg0NlNMKzF6a1FwYS9aSmxJTEJhTGkyNmNiWitNNWVaWmxSdEoxcVky?=
 =?utf-8?B?ekswQlJ3dXFzK3lPRnZrYVVxdk1oQTdlVENydU5iWmpacEQraHRuMjVoejdq?=
 =?utf-8?Q?kKFYq5T7Gq5xnwBGScOnM88xK?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6265e74b-dcf6-4ca7-0097-08de25b7fc0f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4661.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:02:07.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohZ0fBP+pRyIIOZ/gDxnsXHBvJfKyc0PY3r0JQmkM3t6XtIrzvjwuPBzoDYs6GqpaWp3cGuAuy5iEusa7Tn58A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9768

(resend due to html bounce)
On 11/15/25 21:41, Andrew Lunn wrote:
> On Fri, Nov 14, 2025 at 02:59:36PM +0100, Peter Enderborg wrote:
>> Ref https://standards-oui.ieee.org/ethertype/eth.txt
>>
>>
> Is this actually registered with IANA?

No.

> https://www.iana.org/assignments/ieee-802-numbers/ieee-802-numbers.xhtml
>
> Does not list it. Please keep the "NOT AN OFFICIALLY REGISTERED ID" if
> it is not.

Let med quote  text from your link.

Note

    This page has assignments under the control of the IEEE
    Registration Authority that are of primarily historic interest
    that and have traditionally been on the IANA web pages.
    For allocations under the IANA OUI [RFC9542 <https://www.iana.org/go/rfc9542>], see the "Ethernet
    Numbers" IANA web page.  Contact information for the IEEE
    Registration Authority is as follows:http://standards.ieee.org/develop/regauth

Ethertypes:

Registration Procedure(s)

    Not assigned by IANA. Per [RFC9542 <https://www.iana.org/go/rfc9542>], updates to this registry
    are coordinated with the expert.

Note

    The following list of Ethertypes is contributed unverified
    information from various sources.  See the IEEE Registration
    Authority web pages at [http://standards.ieee.org/develop/regauth]
    for a public list of Ethertypes.

    Another list of Ethertypes is maintained by Michael A. Patton
    and is accessible at:http://www.cavebear.com/archive/cavebear/Ethernet/index.html
         

> 	Andrew

IEEE is the official source to use for ethertype number assignment.

/Peter


