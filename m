Return-Path: <netdev+bounces-256673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GTVDnIrg2kxigMAu9opvQ
	(envelope-from <netdev+bounces-256673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:20:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2F2E5049
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56984300C03F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F73E9F65;
	Wed,  4 Feb 2026 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rPEft8cf"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E453B95EE;
	Wed,  4 Feb 2026 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203778; cv=fail; b=nn3yyR9PcWDP+UlRxaSMoRlvB3vyjRNk6LGJlFqozheiOsoA9vRdeHnjxYZZWm8bLWnbSiieAGSysySgLgM+NTOgQmiDrNz2WiQpeRWNHvDLxqLdF6U22TDgwrTvcKROrAYUHybVYTC1hPhHEXDz1D/IpTON08rCcK/Pv8zW2h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203778; c=relaxed/simple;
	bh=NCEVN0Lzn6P2e0T2hg0k0DD91FGnE0VYGuS9qibimEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XhlaKXn9aTzv53OMQNH/3V4xl4bUa0xcNyLCgMpTXOt5qnC69F2hi7IZUyymXP0C8V/PPefUy+XOhoLYJISQshdWu7AaToEdAVpNDND826PYAXfhQP6yvLlsPdQSqcU6JO/cmT7h909e/B7a9/Im6LNyTvFcW6/pRXbDRBkbKkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rPEft8cf; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PguOJ2puI4QP03MO1wutCsmv7nhjiRuiMY29wcy0I0ox9vvDBazYrrgRT/TZbeXUmtbP65C4rJIFhsyQtKoUR4ocEW9MDvfgzXxt55s7cKwgLuk6tuLuQs0v2m4HK2vvOYbNagG9mc8poP7DULp05EY8gp6qAPL0g0xdhyuwGa+cD2St6HXkCGmmELCTvdP8VQ8lLvsfulz0MNMDrWdFMPEWJo4xP9BVfe35DPsC++5v8Sz1QxUvnSclvPwEOEib4dc2f5jLaz7FYBQjyrgztbCBwoWQDeF8wHVE0UA4i2GJYj5utyL1lwU5LxE6OLisIiLnh+VSwYNPb08ybQ3gjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2toOSzxOKtQE4KRCG99Mw9TCS61r6sIxZrllB2NpVDM=;
 b=GQmGkn9U8+cI9qqh9n7sHmdDR4l+GwxiNaMenbqsAuDtowOZok5oEbw7rW1dTZss5BKlFkYow7NSwGwc9ih2uoLPfIYS+3iiPIWf4JHifj1UwUJJEdKKmfe2u0y+45PEJ9E77HWDBe2dTYEm9A4N/Su1nXF6T4TdGsb11k47tYj4Kv2dVL6MMzc110aU8qxgu7TMDM2oKSuNv4NLGNpbkayz4uAI7CeNj68OZ1+JAap8GFC/QK67YVxSk07Lih941YtTUaetrMOiTZEzm0qcCknJK+SgZaQOSzE0DtTdKaoigxCeDxzTlVO03D0IR8Kbje+QjuAePVA4TR9zYxPA1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2toOSzxOKtQE4KRCG99Mw9TCS61r6sIxZrllB2NpVDM=;
 b=rPEft8cfa+6+nGMu34a5a8jaPsuQrJ7y3kXkFrfOr16V3W4xGm/y4ryhtqXZdtv7D/KoVc7r642S1/9ZDWHwwy+ivyjOX4dtD+FDFBrHh7wwrT9v3B7uVqSLr76/2au4Z65Xh1h1O/m5k5v7RWNiuAZb9d2eLgYyI/Xe+pF2luI=
Received: from PH8P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::6)
 by CYYPR10MB7608.namprd10.prod.outlook.com (2603:10b6:930:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 11:16:16 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::4) by PH8P221CA0027.outlook.office365.com
 (2603:10b6:510:2d8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 11:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 11:16:15 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 05:16:15 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 05:16:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 05:16:14 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 614BG98q1443277;
	Wed, 4 Feb 2026 05:16:10 -0600
Message-ID: <8a307eaa-2708-4664-aaf8-e3b28d17b7fe@ti.com>
Date: Wed, 4 Feb 2026 16:46:09 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool ops for
 Frame Preemption MAC Merge
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <afd@ti.com>, <pmohan@couthit.com>,
	<basharath@couthit.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-3-m-malladi@ti.com>
 <20260107125111.2372254-3-m-malladi@ti.com>
 <20260112181436.4s5ceywwembn674r@skbuf>
 <931bb43b-fbba-4423-9a20-122602b3b630@ti.com>
 <20260128131409.wesidsk3z7ixptyg@skbuf>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260128131409.wesidsk3z7ixptyg@skbuf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CYYPR10MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: f7121ae0-d883-4f0b-9c60-08de63ded010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHBVNTdQbXZMalJhVHBhaDBONGlFRGE2UEdscDJZTjNlNDkyN3pRZWQxM1k2?=
 =?utf-8?B?OWhDRjZLakxzb2R3ODFnbzR2VjlBV0ZQajJXTGxmazlMb3hPSTZRWjVlR0c1?=
 =?utf-8?B?RFpyd3lQMWtkWHMwRm5vbnpjUUtjTWlrOTRINWRzNkhNMENibWpBNHFYSUZ6?=
 =?utf-8?B?aElvRVZ1cFkvYTgxRkY4Sm9CTzJydFBzNVMvVW1RL1NqODNmUUEyeDV4Q20v?=
 =?utf-8?B?ZjlveHQ0OTdCNlAycVl0ZGxuK3JYeWd1YlZzRW1oM0htTE5SdU5GNUtmcldK?=
 =?utf-8?B?QndGQW1VNG80R1orendCVkF1bTNkNWcwVzN5aW43dDBNZjBuU1IwOHhBakw4?=
 =?utf-8?B?YXRuZGY5akg0djFWM0cvMko3YUhIZXBkYTNYUStqNVJGeVIwcTk0b2d5S3F4?=
 =?utf-8?B?ejFtRHBPVk9oWnhTbStPSG14TElmSFBhRlNUN0pSb1F3RDNqQzEvUWZpcWVX?=
 =?utf-8?B?ZlJDdkxLbm5HOVpKbEhtYzJBR3UwZjAxYUhaQWtkZmxhMjVKUTN0cTBMK202?=
 =?utf-8?B?SmpZSTFnN1piMWFWTXdCSm1OMGVZSWtIdFpzV2tlL2tDQWFkOHFRK2ZVOGtY?=
 =?utf-8?B?UUtQNXQxRk5vVHhld3hsby9sSzJjQUZuWGZiK3NkYUNHVXNIZVlYeC9Qakhl?=
 =?utf-8?B?ekNkNmFlMUtHdk01ZWoydHd5bnhVekRYY3VZZWxLODdnakNkM1Z2QU9DeDJp?=
 =?utf-8?B?bmI5Q1N1Y2tMUmEyTkd2dElySWdRUnlKcFRXcnFIQWh0MGM5MlZiSjM5eHZu?=
 =?utf-8?B?Ulc1b212VGxNb1VmYVZpTlBZRTBlRnFKZ1FUZEMzSkw5WW9zTkNWdVJoSmxF?=
 =?utf-8?B?bkpPMmU2WGppMkRiajlOaElWWkVZSThFSzgyNU91Q1RrSWdhamxGTHMrSnZU?=
 =?utf-8?B?TUZYWGJpRk5udVlFWWRMK0NvaytMZkdaRGFJRlRNZmMwZjROZ291Q1orYnNY?=
 =?utf-8?B?OU12RjlXUHhFc2hOL25zaTlmTnZadHlsTGl0QkFuWnpMSk5TbDFsb1dtK3h2?=
 =?utf-8?B?RWo2cWFmQ1ovTmQyV2xPdm15MGs1VVVSK1JMZmJ2K1hLWStaSUM4NXlvK0I2?=
 =?utf-8?B?Z3VjNTZqZElEN0Z4T3Q3OTJkckZ5SXlFZHRyNDlVWW1VU3A2R3lPTFN0Rmx2?=
 =?utf-8?B?dFh0YVVHZ1FOZXNBZk56TjdaaWh5b0hkaVJ1bHVBeXZGOGZ0Z0JYNjVRRW1D?=
 =?utf-8?B?anFYaFdVK2tGNlovakRnRDUrR1ljaTBJTVhaMjc4Mkt1c3JoU0pmaUJBZXNX?=
 =?utf-8?B?QWlUSXZOeHJqNzg5MWJTMUJmTGFKYkVBaHpFNFRKYXhCTjdjTHp6Z1dvb1JM?=
 =?utf-8?B?cytzRFEwNXVPK1JmWkJ0bElXTnk0YWhOOE0rbjBBNXBPbDgrWGVmYUh2NFl3?=
 =?utf-8?B?MHI2WWx6RFIrQXhrUlUxRmRhSWR4RE1Ub0R5a3dVVGtRZ0s1VGZiaS90Ry9W?=
 =?utf-8?B?b2xKU2xyUWZIWk9BS3dFV2VxTG9hUVRDQk14MXllZ0dacndBL1ZJd1pBcHdk?=
 =?utf-8?B?SnNhb3JDZHp4cnNYK2p6R0lROVRzV0JqeUFtaHFEb2hwVXVlbFR0RWh2ZXZ4?=
 =?utf-8?B?b3hnaS84czNpRVJ3cVJOdTc1WEFXc1o1eHh0bk9SUXRGclBIOUtqUXZYU1pt?=
 =?utf-8?B?KzZlc3RCVFB1MnY1TllQVmc2K213TE5lMWRUU0JqM3ZPZm1wdUU0Z2w4Zmdw?=
 =?utf-8?B?ejhWSHFNWmdpbGJHV3lDT2RWV3NkbTRQbzRGZHhNbHBscWFvVjNFNlNiVzF0?=
 =?utf-8?B?NVR3c2ovdlFSUmt3Sk9rWFY4MGk2TWdIV2Jnb2Ira0FzTnVodkZ2TGYrZ2xn?=
 =?utf-8?B?Z0xXRGd1Q3JXUjFwdmR6NVdvZFh5TkZxZW9ZVGZFZHVsOWdQVFl3ZjMwZXJz?=
 =?utf-8?B?L2dqN2xUamhkMit6bW8yQWtNWktlV0VVdTJoSTJqUjMxMmhIbFZtT0xCRGhP?=
 =?utf-8?B?Rlc0aEtnNVpiV1UxYVBXQ2kzajByM2ZsS1gxeXFaYUVSQlV4RUdrSjB6RHVB?=
 =?utf-8?B?dU1iOEhiOW40eXZoUmw2RGtHZjdlcnVVd1BRMnhxSXRvSFphUW0wZFZmRzZW?=
 =?utf-8?B?ci9iRm9waVRyN25KcTJ6UWVEYjBHbGgva3FuS05oU01aWDl5VGhKSGsyZSsx?=
 =?utf-8?B?MnBSRVkySmdRT3pGZWhLTUN6TkVmTXVsY256RlpJWkZ6MWNzNEtvcFNYaUI5?=
 =?utf-8?B?TzdaWjJiMWFOOGN2VWp3YzNzY2JNcDVESGVLV1Q1VGVyQlJGdkJVQW9FR3ZU?=
 =?utf-8?B?NytyYWl0dnVCaGhrRkhFUERnVXpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xct0ueCFZLRoiyk8ZJIByWMWRbtblTvSfLKKt6IpWnpjVpwI068HevYbWx+GMRTnmcwwixNvB+sEQVKVbNgwPi+FlE5VcpuwKsLGE/qqqjlYg71nJZ0Bh0kmspzIlPQmud+VzUWsWt95M92VLLeCMOfeXl694SKyrezWaIXgX1/ovTieRFG3u+9o0UPyjxBLN3uZwYdrP3KIZgMPBvULScX0d7c+5Q2Wl/gyXXoPVv904+KRWXP/Cjrd2zGOzv53TuXZiEQB/Xs9lSzJmG5X6A0ORNtOdh8VrLprWnfcqDiWbqfnx2rYWtcepMMquPjOXBpTOI2d9lZzx3st3BIUu2WdvQBuVtNkdTm+XVT2JJFASDLfB3xq2Mk0GO40mUPPNbZMJDnljFFnsmdhNtbnokGsNjITDv2OzbxeVvWY0lWOkA/n8UX8hYQVQvhK22FE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:16:15.6911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7121ae0-d883-4f0b-9c60-08de63ded010
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7608
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-256673-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8B2F2E5049
X-Rspamd-Action: no action

Hi Vladimir,

On 1/28/26 18:44, Vladimir Oltean wrote:
> On Wed, Jan 28, 2026 at 06:32:05PM +0530, Malladi, Meghana wrote:
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>>>> index b715af21d23a..ceca6d6ec0f4 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>>>> @@ -294,6 +294,61 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
>>>>    	return 0;
>>>>    }
>>>> +static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
>>>> +{
>>>> +	struct prueth_emac *emac = netdev_priv(ndev);
>>>> +	struct prueth_qos_iet *iet = &emac->qos.iet;
>>>> +	void __iomem *config;
>>>> +
>>>> +	config = emac->dram.va + ICSSG_CONFIG_OFFSET;
>>>> +
>>>> +	state->tx_enabled = iet->fpe_enabled;
>>>
>>> I would expect state->tx_enabled to be returned from
>>> iet->fpe_configured, aka from the same variable in which tx_enabled was
>>> saved in emac_set_mm(). In case it's not clear, ethtool saves state in
>>> the device driver and expects that state to be later returned in the
>>> get() callback.
>>
>> Ok got it, will fix it in v2. I am aware that ethtool saves state in the
>> device driver which will be returned in the get() callback but didn't know
>> that should be the case every time.
> 
> Driver, hardware or firmware. But certainly the state returned in get()
> must have some relationship with the state previously set in set().
> iet->fpe_enabled has no relationship with state->tx_enabled; it
> represents more or less the "tx_active" state.
> 
>>>> +	state->tx_active = readb(config + PRE_EMPTION_ACTIVE_TX) ? true : false;
>>>> +	state->verify_enabled = readb(config + PRE_EMPTION_ENABLE_VERIFY) ? true : false;
>>>> +	state->verify_time = iet->verify_time_ms;
>>>
>>> Why are some values returned from firmware and others from driver memory?
>>
>> Sure, I will store all the values in the driver memory and return from them.
>> But should that be the case all the time ?
> 
> Not necessarily, this implementation is just very inconsistent overall
> and that raised the question whether there's any reason behind it.
> 
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>>>> +		       struct netlink_ext_ack *extack)
>>>> +{
>>>> +	struct prueth_emac *emac = netdev_priv(ndev);
>>>> +	struct prueth_qos_iet *iet = &emac->qos.iet;
>>>> +
>>>> +	if (!cfg->pmac_enabled)
>>>> +		netdev_err(ndev, "preemptible MAC is always enabled");
>>>
>>> missing \n, OR use NL_SET_ERR_MSG_MOD(extack) which doesn't need \n.
>>> Doing the latter is preferable, because the driver still accepts the
>>> command while not modifying its internal state, and ethtool prints the
>>> extack as warning if the return code was 0.
>>> The catch is that openlldp sets pmac_enabled=false on exit, and that
>>> would otherwise generate a noisy netdev_err() in your proposal (but
>>> would be silent with the extack):
>>> https://github.com/intel/openlldp/blob/master/lldp_8023.c#L443-L444
>>>
>>
>> Ok makes sense, thanks for pointing this out.
>>
>>>> +
>>>> +	iet->verify_time_ms = cfg->verify_time;
>>>> +	iet->tx_min_frag_size = cfg->tx_min_frag_size;
>>>> +
>>>> +	iet->fpe_configured = cfg->tx_enabled;
>>>> +	iet->mac_verify_configured = cfg->verify_enabled;
>>>
>>> Changes to the verification parameters should retrigger the verification
>>> state machine, even if the link did not flap. Also, changes to the
>>> ENABLED state should similarly be applied right away.
>>
>> .set_mm() will return -EBUSY if the interfaces are up.
> 
> So it won't work with the openlldp stack?
> tools/testing/selftests/drivers/net/hw/ethtool_mm.sh won't pass either?
> (see h1_create() and h2_create())
> 
> I think adding such limitation will put the icssg in a world of its own,
> technically implementing the same API as other network controllers but
> practically not usable with the same scripts and tools.

Ok got it. Will fix this in v2. Thanks.



