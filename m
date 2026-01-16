Return-Path: <netdev+bounces-250500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE0D2FE8F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D8D3065E12
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1238361DA2;
	Fri, 16 Jan 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="RxPqol2K"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020096.outbound.protection.outlook.com [52.101.69.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C835CBBA
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560518; cv=fail; b=OxmFgUld7raTF0J0PvX/LmEotcAsNoUPpnVKtGkE9cLVFfvgkjaEDs/dTyhtUuIatRxeE/5iho+zKg1jSsqoG6zapwdGZ4X+VDwx4jZ89QXYKksSV/xCq51HOLOaqoiAPGK5+4uSuOtLwryVCk+3O+ebXqFjocg9FeaI4FB5Csg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560518; c=relaxed/simple;
	bh=I8BiX+N1tlBYlkYHNs4pPJSCnISEbcJijx/fhHMrs/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBEqmdKNeE8xCrDX4ygAcXK+oDx7GlipC0nAs7SxD3vs2CGsSEQc19CuxAQL0f8x3VcU+GTwOX/1Jtg53xOsr6UbrcuFOknop1/3+xU5t9KhUY0fl9VyISRHIafkVOm+uU4ZYHcNFPXhqSniXF4aQs2yVbrJwGp+FzDl0Vk8A2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=RxPqol2K; arc=fail smtp.client-ip=52.101.69.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0P1uNttak6rO/8oUTvEhhEc/OTH078JK/A6VvtXjGZkIA3Q9Hnk5BVR9AAAEAHk2Ndpkpkh8EMS9PO468wNMM+EfOZHA9a/eUYZ67aZCRwpcqYWupwgZhPvNA1RnHTJI7Sc3gvQizd5wXiVegO2rZfHsqdDurgXb1PBU5h6IuhSU6P7Q/xvDWMCiRbAIeXzPRvWQg4jb4Y+4efrYA6kVqdl5n493fbAxdi5OJ9xFr8QFQA/S9ECWE329W1X91EXzcNbMtlDrw52q8sz6w1KhAR++a7wmCFhVwGMf0fn3873cqMXfvv2Z1vM2zRCwa6NIiiVb4G1PSgK0jaEjvJogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D78LJVQBhGxcHBCXazPY2eoiQt4eNscEJUdVic/lXHc=;
 b=hQJAK0uRwageaLjdeVC8k2S7e6N8uViU+3IYMe4Vg9TQMzDWev7il1qOF1IyOQSvz1fyhcvxWvI79RloXFPSbuAObdFOSF+iD7mlwcMe1HkcwnB3x643ap+chb7o+RyuoKIX19hqOHX/xYSzChR/nlK1i1BKkHTvOTVHl+yg1Ucen1jaayHESzqa+pri+4whjUpkwDgXRk5r9Fgcq644FBEwyX0FAZG7ZVqkbQ+YNsOKA2FDT9FjCfwyDLya7dTwQPsQOF6CtXTQBnTxOxxH9zXSjwXPB037Wt1F3gcokYbxG1vaCOwAKtPbx8DoBzPTgdyiQJIRwptWcMd8Sltuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D78LJVQBhGxcHBCXazPY2eoiQt4eNscEJUdVic/lXHc=;
 b=RxPqol2KLP1BqifvKYbT9dejqvmdhymqUsVfkA+pl163CRe9C4kRQ6A9AtnYrXSg7MbTnZkFpacytNtW960IirYl5zMtZK6Auv68VFDZIY6h4USMEjV2PT0bwmWq4ei6N0CgCPXGNqKHiI4cjrLANHkUWszoWNCtPohNh7NClZz9QLEJSYiHsc9dNjuygJC8cB2digSHdfy45fRIe9cqu3UVky1YCyXuNkNm67RY4eYg2hCJa/n6BXMKwQPHfq5nAAoKUBiyO4TWqx4KgfdwQFj2fAYb8S89fu1vXapqY/cdIAwJ9tIjNwiEolo3CZ1uoC+oPelYapEOSL/qUMma/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from VI0PR08MB11136.eurprd08.prod.outlook.com
 (2603:10a6:800:253::11) by VI0PR08MB10485.eurprd08.prod.outlook.com
 (2603:10a6:800:1b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Fri, 16 Jan
 2026 10:48:32 +0000
Received: from VI0PR08MB11136.eurprd08.prod.outlook.com
 ([fe80::e3bf:c615:2af2:3093]) by VI0PR08MB11136.eurprd08.prod.outlook.com
 ([fe80::e3bf:c615:2af2:3093%5]) with mapi id 15.20.9499.005; Fri, 16 Jan 2026
 10:48:32 +0000
Message-ID: <aded81ea-2fca-4e5b-a3a1-011ec036b26b@genexis.eu>
Date: Fri, 16 Jan 2026 11:48:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: airoha_eth: increase max mtu to 9220 for DSA jumbo
 frames
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sayantan Nandy <sayantann11@gmail.com>, lorenzo@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, sayantan.nandy@airoha.com, bread.hsu@airoha.com,
 kuldeep.malik@airoha.com, aniket.negi@airoha.com, rajeev.kumar@airoha.com
References: <20260115084837.52307-1-sayantann11@gmail.com>
 <e86cea28-1495-4b1a-83f1-3b0f1899b85f@lunn.ch>
 <c69e5d8d-5f2b-41f5-a8e9-8f34f383f60c@genexis.eu>
 <ce42ade7-acd9-4e6f-8e22-bf7b34261ad9@lunn.ch>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <ce42ade7-acd9-4e6f-8e22-bf7b34261ad9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00011B55.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:19) To VI0PR08MB11136.eurprd08.prod.outlook.com
 (2603:10a6:800:253::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB11136:EE_|VI0PR08MB10485:EE_
X-MS-Office365-Filtering-Correlation-Id: 774ab346-4018-4785-685d-08de54ecca7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1h3KzZuaGJQRnN3Rmd1ZmxSSzkybVJqeUlPMDgwSzNEdHRqalJjL0ZpRVhm?=
 =?utf-8?B?enlDZmVSb1dlZmdaeG4vMjdPU25pTjdOTWlZbnlTUmlkam5lS3owWEFnbVhE?=
 =?utf-8?B?RVY3L1VzVmtCSUdBQkd0SHBsbjQxaGVUemkzVUgxVk5SLzQ5UDh6TStURGxi?=
 =?utf-8?B?aDNLZFVGRjFBcXNsN2c2NkVKYkxTaVR0OVNWVlZibGYzNjBHL2JGWGhEc1lL?=
 =?utf-8?B?NWlaNU05R3UyZVp1aWlVQVc1LzBsN0htQjJUckJaVGZkSXVNVjh6ejJTbTNo?=
 =?utf-8?B?MlFKZHc1NG1KdkV3a1JDVnZvN0FXUEF1cWwva2cvMEFmR1I3TzBHQUlhcDlD?=
 =?utf-8?B?dFordkgrVFphWlBwbGhXQmU0S3RvVVZIKytlT1ZnK2dQRWhmQXpzNHVLTTN3?=
 =?utf-8?B?T3UwN2h0L1AzZmtBMU52L2VIRU5SckR3ZHNObTdIWVlmS1U3QkVXYUNrdG9J?=
 =?utf-8?B?eXNMVnRLc3BLa2RpSmpYRmhJNkNNRkdhNEQ3eVlXSzJpb3V4R29aZUZqS29x?=
 =?utf-8?B?VEovS1J5ZEJZWHUrb0YxZEhPa05DZFJrRXBsMTh2SHFqejVqTVhzUEhndHF3?=
 =?utf-8?B?VUJndDIzcGt4aGthazVsMGZBRkNEVUN3QnlPOTB3UVdSUG8zN2tNa1lra0lU?=
 =?utf-8?B?Sy9MTlZ1RzljVk80cGdvajJKK0tiOUFYbWdJdDRncjBWdzFYUXkxcjg3KytJ?=
 =?utf-8?B?aTFpTkZES2d2VDBncGJ1MjZWeEZZZ3BjRmdoN1Y2SnB1YXhWbnhkcGRWeFV3?=
 =?utf-8?B?eUlvQVlDbnRHdm1PNG1oU1dqVXhwS2pIUjNZYXZjcHp4VS95OG8ybXdYd3Fo?=
 =?utf-8?B?S3VqeHMyaVlZNlJhblVZa1FSQUNjTFAxdktJMEtYWEd2RUZzRi9zS0kzclg2?=
 =?utf-8?B?UUpkemU4ZXV1Y05XR3FhTmZDaU9TOElodS9lQ2IrN2ZQQ1NvblEwblNqMlp0?=
 =?utf-8?B?Z21YaWxMZVdzeVEvOFlkUk0zNWhsRXNsQ042aWZtemxCakwvK3hONFBVaVJI?=
 =?utf-8?B?cDBTdEVxaGI4NFlkZUQ0K0swZ2pUWFhaSlNRSEI4S25hUWt0a3pOeWNoQ1Zo?=
 =?utf-8?B?TXE1UmJ3aWRXOVZzZHhGM2V1djd5czZrN3VUcE1rVGdCU0FNNXJBLzk4MlVx?=
 =?utf-8?B?L3dNd3N5SXlFcWR1RmdqZUVURkJ3VlNVYmZIZHlKN3FkNldRbXZ3aVpEYUhT?=
 =?utf-8?B?UTBYcGNyRm9OZWRKSTVpcHFpUnRtbThObzVoWVo3d2p1Um1TWmdZVjErQmNm?=
 =?utf-8?B?WHdVWkJxeXMxVGc1Nmc1Nkc3WUU3M05kSTdpYVRXdjNlRHgvTXFwTlpLZkNs?=
 =?utf-8?B?THcvVFVuZm5RVVRmMnFERHBSamFsNDlOb2MwNnJJRlJFcXA5djdWY0JOOVZL?=
 =?utf-8?B?aFljTEo3dUJrRmlEU0hKQmZMckJLYVh6KzNUQVhsQTRiQmoxcytjaCsyM2xP?=
 =?utf-8?B?RnVzSlNibHA4MUJDcDBUbm5EbDJ0T0tpTFBpaXRSYW5LVVdEdkNyUGw4aHI2?=
 =?utf-8?B?cUpzcDM1RlV5NUZ2ZXVzSHFIZ0YycjI0MFcxRk0xUUhqeDU2NzZ1K2xkdDNC?=
 =?utf-8?B?V2ZZSnNvUlJiSFl1Z2RnVS92SW9PL0NwV3pvamo5NDhVWHFvZmxqempGaFVI?=
 =?utf-8?B?Q0Y2VlVkRVhZTGU5SzBRN2Rwb1pyWUZGRnJncThmaDZJdktpbWUxMWhTNVVP?=
 =?utf-8?B?alowc2FFY3BOOWVueXJDbk5HWFBwM3E3ckhZeHNqOTE1NnB4SXZjMmF6WHk1?=
 =?utf-8?B?VkhMdW13ZEs4TmdZVktOMGdIQXdOcnowWGZXMk5ZY2lqc3VMZkxFSkhSd1Ev?=
 =?utf-8?B?WCtPcWtlN1IwNUVaeWVlSDNrZnYxSW5RZ2NIcHptT0QrNjVCRU5KMGRpcU9z?=
 =?utf-8?B?TFpQWnRpeTRiakdyT2o3WkhjTHdaNllXOUoyS1FSazFKRlZ4OGNQYXFOQi9h?=
 =?utf-8?B?L0tuUG9FVVQxUHNBVUNHRis5UTB1RFg4L3BlbCs2b2k1NEFnVjUxQ0x0K204?=
 =?utf-8?B?akJ1S3dnbS9PVmlJVjVhWS9VbFNrV2JDcjZ5QldlVHNiUGZER3RraXRNMjZR?=
 =?utf-8?B?bTJTdVU5OEFEOFMxbk5XY0RwZDZrKy9CenZpVFF3TDAxd0Ria3I4dGFNYlZB?=
 =?utf-8?Q?4+/E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11136.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3Z4cm5TRFdWcGgxQmVPeWJWUHErQ1NUTjQ1bjhIczJaWUhyVTZEdGMxaVpZ?=
 =?utf-8?B?SUJpWFpQN0ZTS2dnSS9UWEhIWmRpU29RQjl1UjVvUU9OYXBLdmIvWUoyRmNX?=
 =?utf-8?B?b1ZDZFJaWU5aMTdWKzRKVlU3dUpKREJ5NFZVbmFleUdIUEcreGs1czlJc3RM?=
 =?utf-8?B?YWhNbW1vRGFqZVFONkJSMEd3RUlUb0EyUjVBOVh4eStQZVZEa2Fxc2ZTMTJU?=
 =?utf-8?B?Mmo2VGlKMmhUR3FnZ212SFROdzFITjU0djlWTkZRSC84Nm1YcUZvODNyTDBT?=
 =?utf-8?B?MVZQMmlSSjZVR01TNlUwbUlObE5TM0Fyc3ZoNzZvM1RRckFOTXZXTTlxYkt1?=
 =?utf-8?B?MHBrMlE4TWd1bzFPSjY3cEJ0YkFMQTBmYWtXbHZ5VUY0REpHWDlreER5VUto?=
 =?utf-8?B?TjVDZG9CaUF2cG8rWlY5R0Rpa1FvZWROekVwc2dQV0ZjeS9Yc0sraHFkMXJa?=
 =?utf-8?B?bUJIUG1xYUd3Z3FKNFBSTFlDMnBFU2daSmJwZm9qWCtJdVlHblNJajl0b254?=
 =?utf-8?B?V0lnaEo0UCtXR0ZuTmc4Ynl5NHBRTlZSNzllVll1Tk5nOHFHSkdjQUd1TEc0?=
 =?utf-8?B?ZnpoMUJpNXMxOTlUeU1paHVWRnhwQkt4aXJINmJPTDBYQWhIbENESkhaenNJ?=
 =?utf-8?B?ZzltODlZYnA3bnphemFKWHUybnNGNkVyZHpsbDErOWdoTWZ6NXNwS04zWTVu?=
 =?utf-8?B?MndtMWVxRW1uSmJGdERRYnFSanYrOUFpQmVvS1AzdVU0ZTNXcEx0d3pvUkI2?=
 =?utf-8?B?eTlTOWR5dytJbGtHUklWajcwY1JmREVJTm9qTHJNbjdyb0ViRTI2WDlXR3U4?=
 =?utf-8?B?Y3FIZlZmbkwwZHFQeTRqdTZPQUt3Ymd6YVpoN1NYYlhhaFh0UEJ6SnhQUUlu?=
 =?utf-8?B?ejdhZnU5SVZCaVZNcFFYaUw3NytnQ3dFYlltOU11bGFHVlNBeXRBcnpad2VM?=
 =?utf-8?B?SytJYlhXUEIvaEdBV0hjTzlyRGZycUFHRjh3UXNpdzdHSU8wcmQzYUZENzFK?=
 =?utf-8?B?TlhoTkpic3pGT2dmQlcyUXR1RkY2MTJ3cGhEa1pPVHI3emhIckorR2tpNXNU?=
 =?utf-8?B?eXJvS0cyeGw4Z2tNZ28rYzBvZ2RZOStrZVN6SklsNnF4cERSNUN3Kzl3S1V6?=
 =?utf-8?B?RGlaZXdMNXVmZVN2U244TkVkRXZHVzNjRm9XcUU1bWQrRzdUcWh1M2tDMm5r?=
 =?utf-8?B?c2FhaUk3UjhaV2c3ZXBqQjJVK3BpRXAyWkgyUk9kS0oyU1d3MVB1U1BvL0h1?=
 =?utf-8?B?UGVwYkFHNzYrU3dsN0Nhd0s3THRyUW5TVUFTK0NHUW9aMWpPajlPTmhxUjJm?=
 =?utf-8?B?WFZtQW1wWEV3bVFhQXZwUTMzMGZNeWpDaE9kRllURi9DYzVxNmNPb2pIc3VM?=
 =?utf-8?B?YXUyeUJoRHAvUEkyNXhGejBRZm05NGhaM0QzZkZVNGpiMDhXdVFQSS8vNlMw?=
 =?utf-8?B?MnRrbmdTMWZVTTR0b3NTVytxWlp0TUdEczduUXFOLzFKRlpjT0N2OHpkaWk5?=
 =?utf-8?B?K1N2UjlnMEJWd0xyZTJMUG42dlVyWmlMYnNJM243a242T3RYVjRkMFFxZVM2?=
 =?utf-8?B?OFExOFNwaDgvUHRaTk96OVhTMXF6VjM4Rm93ZnluNWh6RFZlQU9yWlhJUFJM?=
 =?utf-8?B?RVZSMjVERklab1BRWXhtZU1jaS9jVGd1WUE4TTR0ZzU2SXV6Z0YrdlJFNy91?=
 =?utf-8?B?OGgwdXg4N2hVM3cxS2pRcXdPT21qeU55b2I4UXFIVWpGNUdXR1E3eXJjUzBM?=
 =?utf-8?B?bTlFakdZVmxoamoxSEJIK3RFWGlwTHFUanVzNThveWIvUXk0dnVMcTF3bWNF?=
 =?utf-8?B?eUVZVnM0RmtPZ1c5QXBzalZhNHp1aHNQaCt5Skg4WVBUT281elVwdGtid1M5?=
 =?utf-8?B?UkJ4VnIranB0bGhMd2dEb3VZcVBNcHlpeWFUSW9RY2g0cTdWRWRNR05HRnJl?=
 =?utf-8?B?RlNpTnpFdWVwN2owMGtTby85Z2lMellZSmNsMytlVDFHS3RITmh4b1MxWHRx?=
 =?utf-8?B?bFlVdlBIMThpUlBPTWtNRWh4dGVXWjRyem9vR1F6NFY1aUtJWEZNZlA3aUpn?=
 =?utf-8?B?NWJXbW5sdnZDeG9VN2ZxMGJiL3V6N2lYbjl4aXhNV0Nmay9EMFlmb3FSNmZw?=
 =?utf-8?B?VmdNalYyT0xnNnUvcllVYzBkWmVRVk93M2ZZNlhyYWpJZTg1M2Q1VnZwUSsr?=
 =?utf-8?B?S2dEUkJ1NW9PbUp4UnFrbGFMemx1N1RIOEkvNG92YmxNa3haQkR3cDYyL2hO?=
 =?utf-8?B?VHU2VUVHVnh0NmFLWTFPdlhMTzRrMG5JNW9GTFY1Y3lpOS95Smo2ZUhlWkND?=
 =?utf-8?B?ZEw4ci9pSXBlNEhyNyt6WWxsVXFXa1pXdHlQcUR1ZmwwLzJ6UTluQ2NTQ3c3?=
 =?utf-8?Q?VgOTavhk4JtBVwA0=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 774ab346-4018-4785-685d-08de54ecca7d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB11136.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:48:32.1816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bMJElg0B9ZcU99xNF8Li73k8Z4UnYjYbBwOQtDNiylyAF73d7WdSzFUyfiHMBA5akolaMeFk0rSfj6VJLnJTHw6i38fKhwblPGtGKEFQwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10485

Hi.

On 16/01/2026 02:08, Andrew Lunn wrote:
> On Thu, Jan 15, 2026 at 08:10:20PM +0100, Benjamin Larsson wrote:
>> On 15/01/2026 18:41, Andrew Lunn wrote:
>>> On Thu, Jan 15, 2026 at 02:18:37PM +0530, Sayantan Nandy wrote:
>>>> The Industry standard for jumbo frame MTU is 9216 bytes. When using DSA
>>>> sub-system, an extra 4 byte tag is added to each frame. To allow users
>>>> to set the standard 9216-byte MTU via ifconfig,increase AIROHA_MAX_MTU
>>>> to 9220 bytes (9216+4).
>>> What does the hardware actually support? Is 9220 the real limit? 10K?
>>> 16K?
>>>
>>> 	Andrew
>>>
>> Hi, datasheets say 16k and I have observed packet sizes close to that on the
>> previous SoC generation EN7523 on the tx path.
> Can you test 16K?

I probably can but it would take some time (weeks) as I dont have any 
current setup with AN7581.

>
> Does it make any difference to the memory allocation? Some drivers
> allocate receive buffers based on the MAX MTU, not the current MTU, so
> can eat up a lot of memory which is unlikely to be used. We should try
> to avoid that.
>
> Thanks
> 	Andrew

Larger packets will consume more dma descriptors (a larger packet will 
be split into several dma descriptors). So you dont allocate more memory 
to be able to send jumbo frames.

MvH

Benjamin Larsson


