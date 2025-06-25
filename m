Return-Path: <netdev+bounces-201016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F3AE7DC8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806797AE5A4
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EE129E10D;
	Wed, 25 Jun 2025 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gcsb8u1T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7229E0EA;
	Wed, 25 Jun 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844566; cv=fail; b=V4dqXEtuuhO1U0P2bLW4Ct8mmu6fzre4+Vz64frgYUBm8AJQ9MMC5bEVcQoy2kcYVtSv4EHWJ98GcvzGxUy/PScAzce6FIR7s7WHR1wRWBhKCwwY/C1Eo1EP6C8vH75sEELs4/UtJxXAYkLi3H6T3VAXo1N/TTzv2OeIo4azVYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844566; c=relaxed/simple;
	bh=Cok2c1RwXTH/E1Xjwt1RUFfjNCkL0L7ygoiWHcCsqCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s/IRWehydDxgekX2o44ii+snaTqhsPEJrZqodll8GvxhRbuMIcG7wJ066fKD6b8K+Ojrh8XNKsDDHIVDvYb7jv+sSQ5Pzmze/hRPhcJ1ml/961okYUc9HDQ0+uLSfzJpmxveW/lk9I+FWUlZOGwkMb5TebW+K4gLO/qskakDbT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gcsb8u1T; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li/vllM75WVR9QNrw5qY6y7zS4IJoNgeYnTBxPGo5Kn9yLxEK/zsBIYAm00PS3g0ARXi3EK6vlG/I07nT0nc+XCixFrQCD7F8/3m2RmLluy4LFD529r9HZUQTPbWngALQ7SZO2XTWSNCtCVsrcxnjOCLtTqwMW9paV/UxAz5x5QU6ACaphAftjExW495YQWQu/sOOCpwoeXyjUWAWC7yXZSV5NtYRpLTw5AKkXK/XnjhZBWWkJWcFr9iy3vEsxZufffq2bVGmpRQdhz5pU3XMZUPTB3YaiXdg1uN3udeme9A0JEzDR2/DACLOfItcBNKe/ZNfBZcCVNucYo1+tsylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGN3KavL422GZURhNdkqnKkaM/sRrbQtLjmeDbklsX8=;
 b=rstfzx9xYpld5Z+yqGU1tnnAHmSeWEIbShHH4xPVGrg2Pm46R7QZBJ9P+gBY5AZ1qAsMewMy/5fAoLIb1yFopS5u3eWW/9uZgXau00dhDU/ZbfOVTy3g8BE1Mk6RRqYebaph13IZ7rLPDnb93kQjjZD20YqhIXsqVZC3x96NeX51A85DGLFs8yUccIPqk0GzSSYnLvOxtXYAnjb5i2CNltH/n1wkeIrO4ZjAYKONv3sHHNFAXhkRyUcf2fS+Jc2c/yZzBAVILCpG//ze0KRG0MYKS84TETTp2k3KQ8n1tD9wC65GHzrv3uVG42BF9DktUW0MPFgZgIpldDPY70bxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGN3KavL422GZURhNdkqnKkaM/sRrbQtLjmeDbklsX8=;
 b=gcsb8u1TzPS2eJY8PP2dCrQlsJC/fJhOsVf1vHiTRjhtlxj5xkRnF4lwQRYAeF7Zzl6qVwwVZyOHcHh6fQrR2XK6OE746O2k6k6Kt2UIrMVGfV3rhuUaHJ11NAEiPZOXvPEVKK0/WzfLj0jUOecpRlfSKdQiuypngWyVzso4/88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Wed, 25 Jun
 2025 09:42:42 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 09:42:42 +0000
Message-ID: <ba3d6047-0edd-4830-a5c2-bd7af463b688@amd.com>
Date: Wed, 25 Jun 2025 15:12:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amd-xgbe: read link status twice to avoid
 inconsistencies
To: Andrew Lunn <andrew@lunn.ch>, g@lunn.ch
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
References: <20250514194145.3681817-1-Raju.Rangoju@amd.com>
 <acca227d-c2a9-4fc3-a6fc-3001472370a3@lunn.ch>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <acca227d-c2a9-4fc3-a6fc-3001472370a3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0032.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::13) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ff5da0-17a3-44f7-0617-08ddb3cca12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UExOMk1XY3UzbFBpaUpJZXhBTU5FRkJrblVObStVMXIraENCbVBZd2hSVytS?=
 =?utf-8?B?cEJuUGdpNFN0TEhtMXRQbzQwUG9OWGZYVGJNSFNGZFlDSXUzZzcrbmlPYzNB?=
 =?utf-8?B?MUpzZERjZXJ3M2lvbnVhRmxxekVjRVRzVDFRYmhqNldibjhoa2JCYTY1N3NI?=
 =?utf-8?B?ZVRITUI3YTFnTVU3RllWbjZQZnZYMmZYVXgrSFhXWE9mOFRuSEZJSS82bURh?=
 =?utf-8?B?am9ETXQyVGRzTmZLSnZlSnF1OXRsQkw3aDlWaytLWUpUV0NPYXhIZk1jQ3cv?=
 =?utf-8?B?QTJTcnBrVUo5eHBiRVJwQlJobFpPUUg0SDl4emFuVkVtdVV2U0x1bzdROFV3?=
 =?utf-8?B?bHhsSlJUbjFzVXpBMDJKWFBFZFZ4OHhFQW5GN1RKWVhHU2UzNWh1ZnJBWDZH?=
 =?utf-8?B?bHpFelFCR3gzTkI0dGhXckk0WXZ4TEY4ZUFBKzA4ajVhVE9GVVJ2YnpFdWRx?=
 =?utf-8?B?QWNvSURYUEsrWXBUK1VpVHVOZWdGN2pqSFVNYnVVTU5BTTROdjFhKytZYy8w?=
 =?utf-8?B?VHhqTXA0bzU4Q1pkdHdpWlcxZXY5SHZBMXAzU3UxYWxOOXlPU0lhQXVtUGdU?=
 =?utf-8?B?L3l5WEJybWZsaHJRa1VwWmdnVWM5L2ZtUHZ3VjU1ZDdWdHJ1WW9TQ0NsZUdD?=
 =?utf-8?B?OEg3aE16R2V0RmVwQU1PQk14WkxxbE51N3ZMN1pCSGpLQ2pnR3ZwYlVyQkpV?=
 =?utf-8?B?SHNLY1RXTnhoV0liMHl3bHIxREhGdkdsTzM5NVZZTjNaS0gwSmlLdXdWeE9T?=
 =?utf-8?B?WnZ6OFhmd1R3d2o1MXBTUW94VFZtQlkrTkdzK1c1QnhIcjYwLzV6RU1LM0t1?=
 =?utf-8?B?anJObDNVdnh3TExxbHEyTzZWN1A0cERhdUpsWVBCMkVSWUpTMWRUNGlrK3ND?=
 =?utf-8?B?UHZzdlFyczlRVmYrdjVzQnZ4S1dLR1kwQ3c5SzNWUDJuSllITHVBZjBDZk9V?=
 =?utf-8?B?QmtEUktTQWNaQTFLd0ZHNCtVSE5lK3k5VzMzUzVBQWc0OVRPTDZSSVArNXB2?=
 =?utf-8?B?TkRQS0xJTTJDY1FBR0M3TDdoZHFxTmNWOWNKR3N2NW84cW1TRG9RWlgvREl1?=
 =?utf-8?B?WnpTOWdRK082NDlzZTNWSlowbDRwSW5oNHFielJkenJER3R5MWtQZzFRQ1Yw?=
 =?utf-8?B?NmdNUXZ1TFc5RkJBbVFxSG1iV05JMHdkTkZFTk1rbWdhT05tVVVGQTRxaWE4?=
 =?utf-8?B?WVkrTklLZnZHdWhFNVNyZXFJTWxULzhnamt4bWhXVHpKNlA0OG5uT1pQb2Fs?=
 =?utf-8?B?ZllhNHVwTG04Z3ZVaWl5em5rZHdqa0N4SUcwYndza2liK25zQWltSURYWTZN?=
 =?utf-8?B?QVhpdVcyZnNiSVlGbGVJY05VS0tBVmViVXJnelIwNjBuMEhpTjdYMVBWaDM2?=
 =?utf-8?B?aG4wRC95L2k4Mm9tK3BKMlBQb0llVkh4cjUxaVJwUllJY1hEaExZZHM0S21n?=
 =?utf-8?B?OG9sSitIaEZsRFRzS21NcitHdUo4YVlhQnVCclZxUjREZ25VN0dLalJ1N2ox?=
 =?utf-8?B?Q3hKUjRsZkVIMVA4KytCVHB2djFqMytoYURNTU91U1p0UEJva1hyZzJDTk9B?=
 =?utf-8?B?UjQ0U0thMXNFRHZyeVY2WGh6Q3ZWeFpRWXpYQkk1UisvdDU2dnpDTk1OZ1pE?=
 =?utf-8?B?dDNXMHdya1ZxeC83YlU4VkVtRXBOWndmemN1dlUvWk9oZUMrTnBUTEpjd2U5?=
 =?utf-8?B?dEpHMkZLNmR3Z1FaTUpqMDV0dTVvenNqYnJnclRTNHppNytBOTBEQ3J4MUpV?=
 =?utf-8?B?Ykp2cENVWTE0cThkZXV4bkNlclNzcGs1R0VKWUkzYS9tY0VoQ002QXB6M2Zj?=
 =?utf-8?Q?VBIPeU6de4OnxKhuaaTpfzihegGraa/ELEmho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnB0bmZTckZTWldiZlVBb0xKa09vN3BxS1B2MFM3K1hwdmFnRTI0NHdZOHV3?=
 =?utf-8?B?OWhLbGdRNWdIb0YyQWFFQUVMd211NFZGeE1kaCt1dzE0QlRJM2g1UUluVUFj?=
 =?utf-8?B?b0xTYVNJY0NDYk1laUdBUXg5VkVRWVg0REQrcFEzdTdJeEgzZ0FNdHRrZ2Nz?=
 =?utf-8?B?TmY2aVFSRWEyWDlNQ2R4eTBZbFVMZnNOWXB5Sk9TdFdTbHhSd1VzR0Y4dnJF?=
 =?utf-8?B?ZllmSDNQdUhMbHJoOVRTMDdVTjhsYXErOUcyM3h0NGdIb1NScDdqZkxPNWdC?=
 =?utf-8?B?SXh0b3FsTGFISGtMUTVrNHNQb2poOWpUTTkzQnk5czNrSjdKU1pUVDJsYVY4?=
 =?utf-8?B?RTV6Zk1IM2xzejlScThVQkdyS0VJQ1hNZGl3Zzg0VmYxMkV6ZEFNbzY3YjIz?=
 =?utf-8?B?YXJkQkh6MURZdEIwenBIL2F1K1l5YWFubUpYd2dPZ2phQytXbHQ5TzBtMmpE?=
 =?utf-8?B?TGVCekNvOE43SDZTL3FwdkxnMk5rT2ZnYUZYVERhSEEvUmtJb2poRGRvZ2M0?=
 =?utf-8?B?KzFzYmh5Z2JvUlIrbmtzdnNIYkJZaDJKanpNYnczOTlNeE9CM1UyNHFEN0d3?=
 =?utf-8?B?eGN3dlBDRlFRYnpyMEZRUWdmWDFVeUs3WjdaUUE3L21UMExGaktxaExNK3Z0?=
 =?utf-8?B?YUEwWWpqZmJ3Rmx6R2FBRWRwandsd3RHQ1NEWHFPT0NoKzJlSWtTOEhPbmFZ?=
 =?utf-8?B?dEw3QmhlL1p1WDZqNHRBb3FDZVlnd0Y0aktpYUptOFR6SWhVbGYxMmNPSENO?=
 =?utf-8?B?d3hlOTEwRmt0SDdqdVQxM05tVEJKcVdDMWZMVXUzc2kzZ1ludUlhbWgxcnJ1?=
 =?utf-8?B?TEpXdmhrMjBnOHBjMlcyQlpzenRQaG0rUjBKU0hZeHFxcnVSQVZxcVIzVDBE?=
 =?utf-8?B?c2xGK3AyRy91V1ZJelIyQlQ4bUhFYU9iQ2owOEpRSDVhRjZYSGdyWmlBVWE2?=
 =?utf-8?B?dVVQdWVCalpoYmNaZlpFVm9telFWbmoyek9yY0d6UEZmbVRIZWYxVkxoRmFz?=
 =?utf-8?B?TEluVmprZEQ5YXFWVFJiaHlmR1FKU1VWSTdYZkM5ODZMMzBIM3BCNHQ0UGVz?=
 =?utf-8?B?SEV6UUNNakRWbk55bE1zR3pOcUxSVkk0cEJnTk8zek1zbHhETHUrcHVqODhU?=
 =?utf-8?B?cW5mU3ZoWVJ1Y0p4cG5PWVFUa0w3T1JvQWE4R3ZqWnBzUnV2cUxjRVdSKzBk?=
 =?utf-8?B?QVkxMlhRWWJHNEdKdFJHTWJXTDRSRXNpT3BTeWxkUU1DTTJScmtMNjJ2WVZI?=
 =?utf-8?B?U3JORWRWWDBtcGoxblMzcTZXeGNCYnozaFA2LzZVc1hONWtIbGVweTdIaW41?=
 =?utf-8?B?T2srMGgyWEFTVlV0NTRYMW9IOUlEV3Nsckt5dURud3B4Z1pPRS83QllBYXBJ?=
 =?utf-8?B?ZTNmaFRLYVBvZjYrUlB1emJPMDZNQ2xqa0xIMjlmUXF6KzdxUVhXck9KZ21N?=
 =?utf-8?B?S1ZoaDJYRXJOVkRPWWE4ZitCdUNJZmZwS2NFYXJOaFVHTmQ0Tk9INXhZWUky?=
 =?utf-8?B?ZFRYcFp1eDN3ZHdXOFArdXJSUkZTSmVLUVNSZlB3RmNqdjVjQWxGditCcFY2?=
 =?utf-8?B?Ly9kSnlMbVZnRlJaM2Myamk5M3dEelpJblhWQjhzVGg4ZzV2VUpkSEdIcS9x?=
 =?utf-8?B?TUQyYmIxbHhvRzZLV3J2Uy9JV2ZrWUhOUzF5Y1ZDaWNIaWtLRkZFdWNYSS93?=
 =?utf-8?B?TEpNeS95aXV3ZTBndGQ5YTlISVdBWWdnNUhiVVI2dFgwbUJZOS83cjhZdDFy?=
 =?utf-8?B?MVN0R0V6eUlCcGs2dE9jR2EzZXNxdDI2QlQyQkx0U0NZcWU0Yzlhd0VsRVZC?=
 =?utf-8?B?bW5YdHg2R1o4S0tuZHUyRGZOZTVVbTdCRGZwZmdkeFJBM0VZTG5CU0x2Qzdp?=
 =?utf-8?B?RnZCR3JjZ0l2NnNKd1E2M0tDWGFadVhiSHkyUXBoK2M2dmp0NHhqSmVXbjEz?=
 =?utf-8?B?djJxSGNQakUrdVFkNWhLNGNVYllTUU9qSDFFSGMxczBhR1ZVeHJXMk9hb3dw?=
 =?utf-8?B?TnlNOUdIN2RraFlKWXpKY3pkcG9TeFE5ZzlTY202V21OOTVYVHBTUTdtWWdX?=
 =?utf-8?B?VTEwTEk1UndhZysvREZqN1ZXVFNIMG1WOU9WbGs1aDJVM3paNFR0V1ViWEt3?=
 =?utf-8?Q?36y5hJqenmNS0b22lGgmnR/Rp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ff5da0-17a3-44f7-0617-08ddb3cca12c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 09:42:41.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8F5u/+98y1MpMMDtdL9ALaTvZdi6D0qu/03rgAppPOedmyyLMjhOhPg8X7ls1tLfD7YY7N5wmbveo+7tOS2YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966



On 5/15/2025 5:37 AM, Andrew Lunn wrote:
> On Thu, May 15, 2025 at 01:11:45AM +0530, Raju Rangoju wrote:
>> The link status is latched low, so read the register twice to get the
>> current status and avoid link inconsistencies.
>>
>> As per IEEE 802.3 "Table 22-8 - Status register bit definitions"
>> 1.2  Link Status  1 = link is up    0 = link is down    RO/LL
>>
>> Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
>> index 268399dfcf22..d233e3faa1a9 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
>> @@ -2914,6 +2914,10 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
>>   		}
>>   
>>   		/* check again for the link and adaptation status */
>> +		/* Link status is latched low, so read once to clear
>> +		 * and then read again to get current state
>> +		 */
>> +		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> 
> 
> Since this is not a phylib user, i don't care too much, but:
> 
> https://elixir.bootlin.com/linux/v6.14.6/source/drivers/net/phy/phy_device.c#L2514
> 
> 	/* The link state is latched low so that momentary link
> 	 * drops can be detected. Do not double-read the status
> 	 * in polling mode to detect such short link drops except
> 	 * the link was already down.
> 	 */
> 
> So you don't care about short link drops? You don't want to tell user
> space the link went away and came back? It never happened.

Thanks Andrew for point this out. I'll re-spin v2 addressing these.

> 
> 	Andrew


