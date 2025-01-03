Return-Path: <netdev+bounces-154984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09634A008EA
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B0F7A1CB1
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C041F9437;
	Fri,  3 Jan 2025 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HZ/uqRZj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B801C07CF;
	Fri,  3 Jan 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735905016; cv=fail; b=mw46uJDmn0FHn/7vZhMEz0yZocyenxl/lBVeHzcHKuNIm0iIGi28qonVSKzVfY4D59VLXO26a0gFnOyDIWp/0Z6cBTqM111xu0p8oCCWUSPqkZVBqqnsLgM7ZelR9UZsxZbLZ0IwGd30e5k6mnXUb1VyibMv3GnfjaTXGcPrrgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735905016; c=relaxed/simple;
	bh=o+Sl/PaHHQpaNgLv+/rEfT10KzJxmdTzoFLLcc6UZo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CM32Tet11IikljGpXV+9COS8DRO5KzaGvNvmQ3APnVfrPbmUwS6lVDTXpyrZpj+cSgoRiqul8N6uuZECyqefuKb1r7g3fF40QbxTWRgs6DUHlAYgYfWgWcqR/2kb1nzMIe0lXZJcolodAR30IZdD+by9vleTy98iASHp2gyQCPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HZ/uqRZj; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVwpS94CUZpz3sApsbGm1bCHl/WdG/GlgAoZ74PzGdWmNBUUjUrv+SCrXvz20GXWJyDIzEItwgoB4jSwV39J8ZEmuOL3QlkCI0zU0KZQd7KayK7r5kptAafWNg9Tt6FuQyuMLRLJ8NnT8L+KQ+M8dQ5EuCY+4QPIdeMhxjEnmXg1SKlkNA0MVX2lxpDNuXC9WpT1jnz2xJzxP3v0Opq24JV6rZlT79AxfzZE689fWxwNp3OVKsJiIiPqY+WI74pcrhCgGunsLFlgD+WOIXIknVFYntzRJjOOPDgZ+CmiT9m3xPn7kYBKm64NRPuwTv6dEHs+GPM44o4c7RVB5c3v4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kdVcHznSb/ztPY0YSuUN0J4+UM9YTqLp/Ld4ZrOPrI=;
 b=lAWhdu8lmpDzrclQoDOJY/L6ICYeWF60xC89i/2ZfliuA93yVzFij6ha73GF7oQKCPqBU9IGxStKueQ9OFx/nY0GzlU1bENVKD32kMaN3ZtdG6M40+S8kx01A7monELT4sp2C31yOc2fbJ9YncQGUVT494ZYIs4CgLjq4C8kmJYMIhd7LZN0inocSjQ4FoOOcipdXT6MiJfMxOmEVF0/Jhp3nYsxKGzQwBxbuC8mOddJEoqhmWRq9M31D3WUonQPgr3dEuaDZ6FG9xXmYefN3rgs9iY6bcUZdc+9i1BwzobeoUg5iw9yjfjCTG4/vM2gRUV0tkgIVK0MqwCFA2DYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kdVcHznSb/ztPY0YSuUN0J4+UM9YTqLp/Ld4ZrOPrI=;
 b=HZ/uqRZjO+TqniK7OAWiTXmBdORLNSTWoAULqJPG3hJpq+zo/VxAL0HSHHF3GoF218iKMp4UaAJ9kyvz+uuciIU2060NTn8Td/bFBcJR8bvSv6p3dOzssAi0mgqkwQOHk9RyM0tmy9ukbvAT9Lkr68GdEijvixKN+5IRuJMIaaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 11:50:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 11:50:08 +0000
Message-ID: <ad7ed7a4-4cfc-7e68-8d53-772efe542a96@amd.com>
Date: Fri, 3 Jan 2025 11:50:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-4-alejandro.lucero-palau@amd.com>
 <20250102143656.000061c9@huawei.com>
 <ffbca9f2-80fa-530a-9ec1-9f811ee61e38@amd.com>
 <20250103105008.000053bc@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250103105008.000053bc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: d5244688-b522-4e65-6dc6-08dd2becc57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXRKejVoRm5oV3BYMlp6Tkl2by9WYXI4Y0tRS3NFSlJ3ZklCaHo3RXBmSUl4?=
 =?utf-8?B?ZC9FYjRKVDRJQkYrNlFwM0R0eEpLeHZqYmtaVnZUa2NsK1hwMmR0b0FlZ2pt?=
 =?utf-8?B?VnliNjRQeHZXVGh5RE1raWwrVm9ad2tQL1BlOVZlaWtqbDN6RkVKRmszQlpx?=
 =?utf-8?B?SElNdlZVcjhlL0ZTWlNLSkJKM1hTbktQaVV0b1A4WjNxaFBSeWV5MWQyQmFP?=
 =?utf-8?B?TlVyUkoxRmFhWURYMlZMMjBMVWFKRXU5RS9PUHZTVGFsV0FPd25GU0NXNTdl?=
 =?utf-8?B?NWRKUk9BRHhRWXg5cCtaSGE3RDJkZHBpbk8yOEY2UFcwTXpBTzlnVW5PU2Zm?=
 =?utf-8?B?WDRURk4wZU4rUDRZbG9WWXlRQWluTlB3amxnVlUxSzhZNnEwZWNRRmw5WjV5?=
 =?utf-8?B?VTF6b3Z4WkF0OXEzMWErUnE2UCtKUE55ZzdmTGxGTEZEZnNvbzQ3QnZPb0U0?=
 =?utf-8?B?SGhKMWZOamNiZHpxc0hlMnE1dTFxS2NlR0MxbE4rRXhld2ZDd1VFMWo3NkRa?=
 =?utf-8?B?NHI0MEVjaWxGblJMVW9BUWF4V1k2eXVYZ3o2NEhka1BvcDNVYUI0VCtqRU5V?=
 =?utf-8?B?L2dHMC96MkVJM2hJanNEc3pWQnJlSGwyWmdDT1h5ZVoreGR4b0l1RVhUV01T?=
 =?utf-8?B?UGJqYitaVkk2Nmp4MS8vS0RCTGFaeXpVYjNDc1FDMGt4R2tib3NpOFVQbGZj?=
 =?utf-8?B?ckhzandMcENlNlVBU29qOXQ5RUtqa3JHbU1EK3NEd1JVbC9XUVJCS1A2Q0Zu?=
 =?utf-8?B?Qm1LaWUvYWE0KytkTHBWeXQ0NG5xc1hUOGFmYU90azRlSzJzb0x1ZW9qblF1?=
 =?utf-8?B?elQxTmlsQTF6OTc4YnNlN0xWUC8vd29PRGhtRVlwa2paMWdheFArZEE1UDBz?=
 =?utf-8?B?N3paQ2hUQkFPMnh6MUhzTGpwcDFpZWVMSWRiaVUzUlpvVk5Ld2R5ajlrcUl5?=
 =?utf-8?B?U0NiWmJwNVU5Smh5SitCVFpkMWNOUlFhaXdJaGlhNit1KzluTkJDSFZFbm1i?=
 =?utf-8?B?bmt6Mkd3bE5QUmhDVUZzYU1Ga0R3azNPOFVjSUNmeVl5b1dhN2dvMnlSakhk?=
 =?utf-8?B?OHF1eWRVaS9yaEFTSEZhL0hUM0FVVHRxcEtOVXlXdzNmZnl0S1VOTXRRekNs?=
 =?utf-8?B?NHdhVlhIYjBIVjIya1QwWXZiMHBhSmpPMVZpZGQvb3BtaUVOOHJPaGtHRUZy?=
 =?utf-8?B?aDQ4c1hHWVIyZjdlcWNONjVOdTJXTHh0b2JNUmpIc1F2MnArM0I1bWp2MjNF?=
 =?utf-8?B?TkVGQUJGbldzV01tNVhHckJDcFVFQ3pHL2liQ1ZWQURLZVBjSDhUWGRkc213?=
 =?utf-8?B?VEdnc2JEdHNiRXdyZXUxWmR1bURDQy9keWJ0NmpTaFNMYVU0aStGaW5GRmJB?=
 =?utf-8?B?WjM1TUxQR3lRTUY3WHVHaUxYVVFUUm5zVUZaYTBzQzhIdUVBYUxWSmFUZXlH?=
 =?utf-8?B?a2llZ3JReXJvazBVREVXY2ltQjVScjlxS1NxSzByR3dvYnJDRWFqemNMaXV0?=
 =?utf-8?B?b1hOajVOcjcwY1NUdjlOSWdYeDF4YWUrZUZDTWxVWk5CMVRCVm81dlR4WVd5?=
 =?utf-8?B?dzBhWE51MExEM0RjWjZkc3lUbEJvNHpFdEs5V3NMcDVTMEJYRlhjaFdkZit3?=
 =?utf-8?B?UzhmQXJKSDY2cGVlY2hMVGlRWEFzUFMxL2VTYkZRME1NMzl1YUQ4dDU1Q2N0?=
 =?utf-8?B?bE93dVFLajh4NzBhSmxKQ3FqY0JiZkJaQmk3TjQ3dlZTeHNTT1REQ3hLcENL?=
 =?utf-8?B?aFlzSTc1U1FLcEpmakYvM05zcjZNV2V3SnVnZFUrVkZzSjlSUk9JQ3NaUnZw?=
 =?utf-8?B?cHcxbk5uVG5MVzMrUk5qQjZsM2F2ZlEzOXJicjdjLys2SnBnTHllU3ZNRXNk?=
 =?utf-8?Q?Uw3D+2zyvy4hz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1oxK0toM0JzRGxRTzllYzRFeHB4anZtUXp0VjVMYUFscDhvSmlxWDhzL1pI?=
 =?utf-8?B?TmVHZzhuVzREelZBeTBCUVl1UnR0c3B0YjFMVUdScHJ3eW1aWUFsMkdEYllE?=
 =?utf-8?B?aHBLMUtMTTZuUnZWWkppcEhjbXQ3bXU5MmdzQ05Wa3FzWFBxUVdoejcvOHZZ?=
 =?utf-8?B?eUFwVk51S0xzaElPMWV0V2gxTHBpekZVbTA1aVlkdEVIeFhpeURraGZMM2I0?=
 =?utf-8?B?T3gxRFF3RG1VT2RYanY0d2JXVk4vcUwycjdqZDM1RFo5WFljTmZVVjFad1Jv?=
 =?utf-8?B?YmNaSFJ3YlJpMEVSampneGJCUE84N2dzSjJ1Q1hMalBHZUpEZGthZlU5aGdM?=
 =?utf-8?B?a3plbzhOUnpyQUo4NTFjV0FnSzRnT1FrNUNVV05zZmI5T1hoc20xNGRjbnZy?=
 =?utf-8?B?SjIvZ2x1d0g5NVpIREpaaVhBL2ZvRmJ5N2NuREM4UFBBeVJLRFZxcTJ3QVJ5?=
 =?utf-8?B?cmxhelpJc2FQWGVNMG9WVlFkS2VyV1kwcGtNNy9mOVBZam0xRzhLNzF3Z0dV?=
 =?utf-8?B?MmxPZStQa3g4M3RiNjZRZWVMbU5lQVZySXVJTEZKNFFRMTk3UjY4Rm9Fa0t4?=
 =?utf-8?B?aDZnamRIckNQRHhDTmRQV2NTKzMrdnpLVXRHMUNjWkdQU0RqNmtFa3dSL2ZX?=
 =?utf-8?B?TEJDd01WZTdkOS9Semc3ZXRHejhldFA0R2Y2L1MzOHhUYmxCNkF4WmMzNzJU?=
 =?utf-8?B?Zzhrc2p4LzQ2Ky81a0JndHRRS2FiWm85bzNaYUdpUXNRQWhQbkhLcTdRU2dp?=
 =?utf-8?B?a1MxYmNZVS9pTmd3aklWNkFueG01RjhSdVFNeHFTbjVSY0FISEtMQ21ESlAx?=
 =?utf-8?B?ZFhlanEyaStNOVlFS1lPaG9NUHI4dGpQbkpWdEhoYUExL0hobFZYWm50dzY0?=
 =?utf-8?B?OWhKRXFka08zeXlzekxVMlprUThRZFR4NmpmVWNHUEJTaGZqdnNWQkJuWUtD?=
 =?utf-8?B?SXIwV3VaTUEzOUh2QzFuY2NRVU9RWDlmMnBhNmNQTjBhM2l3Z3ZTcDF4REpC?=
 =?utf-8?B?MzhOT2dVS3YxUmlJZERtMUM5RGRjelZEZ3A3dFM1bDkvdTJMdUEzZUNZUCt0?=
 =?utf-8?B?OUpPK3dUVnpHa0Fmak9sN1U3aC9hb2tJb2lZNkNYZEF1NTA4dmFxNDFsN1k2?=
 =?utf-8?B?REM5Z1F2Qk1RZThhRFpnRUJVYm9wU2tVUVBQKzhWdEJvV0N5dUFYa2l5SG5M?=
 =?utf-8?B?OHBxWE5tbU5hZVVLSDkxZWl3TnhVRkVLNkwzRU0zeWE1N25pdm5QNkdXclc1?=
 =?utf-8?B?MnE1ZUxRK3YwVTE4V0J5ZmJWK3hORkl3U3ZIWUs2cWxWci9zdmdyTXA2UUdM?=
 =?utf-8?B?azJwNUE5WGtIQVJCUEw2VFJhZHhTZDgvb2xyZXR2VU95Y2U1MTdEUkFnTTFU?=
 =?utf-8?B?R2o3YW5ZV2lwb3YyYkFLbXA2Zks1WDdxdzZZZlVDZU9pQVFrUU9lL0E1VDJD?=
 =?utf-8?B?ZUdyYkV6TUFDZXB6MVNBSDZPcmN5S0NuTmtSY3FSMHUyVjNHdk9Fc3BlaFZz?=
 =?utf-8?B?MUN5Mm1kYmV2WGRXdVdQaEthemlMcFoybnl5RmVWdFpSbXhTTzJoZnpFb0tZ?=
 =?utf-8?B?M2RqZ3ZtTlN1NE53S0k3VWhmQW0zRzV2ZERTTTNJemRhcndIcXVZcUxzZXE4?=
 =?utf-8?B?SWlzbmRUL1dDZksvdnc3bkgwK3oxc0txYTJEZHprN0pSeWNLTmQ4YmhGTUJH?=
 =?utf-8?B?MVZXVGtuRXM3Z1NwTnBNcFZCNCttdzZhSEFpRnVxSnhmRThrUW93eFQ0dk52?=
 =?utf-8?B?eXRZa0JueWRmbCtyaWt3WlBnRURWNFhiL3k2UzFHckpXR3RFTTBsVFRBb3c5?=
 =?utf-8?B?RWpXMTZZdkxVZCtqS2g0K1Fkb2NDV0UrVDJ5M1RVVDZqVUpRT2JLeGUzMUkz?=
 =?utf-8?B?QlM2WDN6UERSV1NvRVBTWXdRTDlLamdzYksyNExwcnpkTERsT3BlWFlET2hs?=
 =?utf-8?B?WnowL0pMVC9iOUtFN2k2dFh6elpiWnJSYVJUSFM3QjlscVo4TnJVUzUxV09O?=
 =?utf-8?B?dzZlNWZrSTFPQloyY2ovRWt2d1U3ZER0WXpWMkIrNjlzeDBRS0Zoc3cybUV5?=
 =?utf-8?B?cGg3THRGQml3N1o4SWdiM09uK1FmYXBJVktxRkVLQkt2N0s4bkR6TXdZYmxJ?=
 =?utf-8?Q?fLWfBLZPvzG87i4c5se2tGp9J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5244688-b522-4e65-6dc6-08dd2becc57f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 11:50:08.4548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LR056AMdpAj0WcWxx+sFoMyjqY69TIpvoa1CmEAEhFpgglGe+uJYtB4L/cRmSMiQlP47p4hm8rl80qnyW44jbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952


On 1/3/25 10:50, Jonathan Cameron wrote:
> On Fri, 3 Jan 2025 07:20:48 +0000
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 1/2/25 14:36, Jonathan Cameron wrote:
>>> On Mon, 30 Dec 2024 21:44:21 +0000
>>> <alejandro.lucero-palau@amd.com> wrote:
>>>   
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Type2 devices have some Type3 functionalities as optional like an mbox
>>>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>>>> implements.
>>>>
>>>> Add a new field to cxl_dev_state for keeping device capabilities as
>>>> discovered during initialization. Add same field to cxl_port as registers
>>>> discovery is also used during port initialization.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>> Comment in thread on v8.  I don't see a reason to have any specific
>>> bitmap length - just use a final entry in the enum without a value set
>>> to let us know how long it actually is.
>>
>> I could do this but it implies to clear/zeroing the bitmaps with the
>> final entry value and to mask bitmaps with that when comparing them.
> Yes but that is automatic if you use the bitmap functions throughout.
>

Oh, that is true.


>> I tried to avoid the masking, and it led to that use of sizeof and then
>> CXL_MAX_CAPS=64.
> Don't avoid it. You are creating maintenance pain for a bit of unnecessary
> micro optimization.  Just make sure to treat this bitmap as a bitmap
> in all paths and there will be not reason for a reviewer to ever have
> to care what this value is and whether enough bits are zero etc.


I'm afraid I have been in the wrong path regarding the use of the bitmap 
API.

I even initially implemented my own bitmap_subset because I did not 
notice there was one already there, and I think that was the starting 
point of this chain of bad decisions. Because I did implement it poorly 
it led to keep with the wrong assumptions when I was told to use the 
existing one.


Happy to have you pointing this out. I'll fix it.


Thank you!



> Jonathan
>
>
>
>
>>
>>> Using the bit / bitmap functions should work fine without constraining
>>> that to any particular value - also allowing for greater than 64 entries
>>> with no need to fix up call sites etc.
>>>
>>>   
>>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>>> index 59cb35b40c7e..144ae9eb6253 100644
>>>> --- a/drivers/cxl/core/regs.c
>>>> +++ b/drivers/cxl/core/regs.c
>>>> @@ -4,6 +4,7 @@
>>>> +enum cxl_dev_cap {
>>>> +	/* capabilities from Component Registers */
>>>> +	CXL_DEV_CAP_RAS,
>>>> +	CXL_DEV_CAP_HDM,
>>>> +	/* capabilities from Device Registers */
>>>> +	CXL_DEV_CAP_DEV_STATUS,
>>>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>>>> +	CXL_DEV_CAP_MEMDEV,
>>>> +	CXL_MAX_CAPS = 64
>>> As in v8. I'm not seeing any reason for this.  If you need
>>> a bitmap to be a particular number of unsigned longs, then that
>>> code should be fixed. (only exception being compile time constant
>>> bitmaps where this is tricky to do!)
>>>
>>> Obviously I replied with that to v8 after you posted this
>>> so time machines aside no way you could have acted on it yet.
>>>
>>>
>>> Jonathan
>>>   
>>>> +};
>>>> +
>>>>    struct cxl_dev_state;
>>>>    struct device;
>>>>      

