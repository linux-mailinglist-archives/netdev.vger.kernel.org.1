Return-Path: <netdev+bounces-256672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LSgICEqg2kxigMAu9opvQ
	(envelope-from <netdev+bounces-256672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:14:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D8AE4F57
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08BCD30015B3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031493D413D;
	Wed,  4 Feb 2026 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XsAAYE9e"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A32EE608
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203676; cv=fail; b=qoc1//yDiMKEgYPhrWMKcEVaVy205SGBwQ784vsMZYQwiNQ3o+zew2ybasWHIdQbTp8S4FtSz/j0aMVkQbINX3R9OfDW0ntWPrP5kOXblUfG+JrXI2E31m461L0YRMouGRtj7kH9o50esZrBvpKF/dctCQvlgvoyCogkwWSAkTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203676; c=relaxed/simple;
	bh=u9naKHjnEwC7GgsWtwbwXf/Tr4ZAU8ONdbo0N0KuUTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FeD9MsUHwzqi/nKSSkRKzvqVo0z/yevK4GlZnWcTzgR9liY3QyAjiJ/9pVvTC/1EFTKLra0mXW3eVqprBL3dH0vBP63Hvw5AOj+Ik8zZIcEy5axWIp9dd34tdfvEv6Kkl3cUtygHwXh+dCj52526ereUuMK24fRIJCAvcqY1zc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XsAAYE9e; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRr5NLuk0j4KAIrwgHvlOSCaZrU9qqBNFkQsqd+JSmTm/zH1thnGxziMLBGX4jVMXJPqViVTWLOO0cGSnsmznH4nocCFheG4IotvUdqjeaLXhFwcyZ9fjHP38U+0hZAMYQI9S2ARYUN8dL4BVIuDqoIucC4Y1/oj2/GSxZzetLvZG6nxzmIUXsyKPyD4fgGTnbgK5mWWTpvSLqoTLnUKB9S719PKVXhW9MD1K21G0UeMQIX1SCWBTtJ6a+FhD6X99sje6xzkKdGg/hpUXdobnTVS0tRb8lwsJTAAP2HtmhZrherK5ULn9WXhGDd6j25e4GSdfHJQepryXF37oiFdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt6ZFkn1251f/Ryy35MIEYZJ2ybO7CqyzyHMccNjCC0=;
 b=VGOQE4/7foEW6Oeb4WY6sGssI1CcYrQT1TpP0QfXByy0tNoVqmScIsoAIyy7HMzbN/ykL4t4oX6EmyG34BWRxoqOVRzz1jMic0SryPVO/1oRHJ6KWYSkqfmWSMP6m7i0Q4WZeEPKY6lsXQkHUcv3lfUPYvoypaxSHzRXgRDvXTHOB8ocWnAyIcNBfKfmQXeve4PwXaqDShR48KGfJmXw+1iIPfUdHiO7dP8+8eyt9FbUQC6tMVM5PeqH8g2ZLLzqSjz9tlQyZbx2+Re6nM6Sz4CuFfgXJASWS7TC2pCmIVAXToj4hjuqSvnllvScrg5hPdTPMIC7pykijU+MZ8gfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=users.sourceforge.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt6ZFkn1251f/Ryy35MIEYZJ2ybO7CqyzyHMccNjCC0=;
 b=XsAAYE9ej4RwAEnNSa3Dz1zen+9D62ft1lNmFfXfbJBf2xgPEvGbwz7MLzJ5i+SxTEhwSEKKbpCYyiFjbG53vcM2hmoKoiLrlg3DbyscZoe0OgmQRxg5XPrFOE8ekUfQ8Gp4YeW6LBrTbcItK2v8z/dyhLhTiSMOnXevcKdjHuM=
Received: from DS7PR07CA0013.namprd07.prod.outlook.com (2603:10b6:5:3af::19)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 11:14:30 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::fd) by DS7PR07CA0013.outlook.office365.com
 (2603:10b6:5:3af::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Wed,
 4 Feb 2026 11:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 11:14:29 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 05:14:29 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 05:14:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 05:14:26 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 614BEMuU1440982;
	Wed, 4 Feb 2026 05:14:22 -0600
Message-ID: <583feb00-09a8-4008-ae50-b6f3e3f990ba@ti.com>
Date: Wed, 4 Feb 2026 16:44:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH net-next 0/2] net: ti: icssg: Remove dedicated
 workqueue for ndo_set_rx_mode callback
To: Kevin Hao <haokexin@gmail.com>, <netdev@vger.kernel.org>
CC: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Himanshu Mittal <h-mittal1@ti.com>,
	Simon Horman <horms@kernel.org>, Byungchul Park <byungchul@sk.com>, "Markus
 Elfring" <elfring@users.sourceforge.net>
References: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: d62763c5-09c9-4fad-3f2e-08de63de90f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTFuN2UwV3Bvay9tNXlsYWFwVzlINnhNRGtRUWE1SkZsTXpSNUtLR3VxMURJ?=
 =?utf-8?B?L1JCZTR4M2REWE5SYTJxYTdEQzYxK3k5aFVHUWRGWDhyNzA5dG0rb0hCQkI3?=
 =?utf-8?B?YzJmNkJYdWcxYWRnQ2s1bTRaalduL2lBTGdzMEdUblE1V3dCZW16WVVpQ1NZ?=
 =?utf-8?B?cTc0SWVMbFZnejE3R2VSS05QbVU3RjRKeWhHS1R5enNvejVBNHpYUVBzOFFX?=
 =?utf-8?B?bVVxQkJWRENBNnRqSXEzMEZRdmRkNXV6TzB0YWlOWTZqSDdvZFNoM1V2SnRp?=
 =?utf-8?B?UU40bnp6OEhOSGtybjdJWm4vellXSmtwcUZQWFhoRE5FcVFyVys3L2kzQjRh?=
 =?utf-8?B?WTJRZUpTZWtNb1NjMFQwYkZTNVBleVNqVlBXNE1VUitBcDU0WFZTVkczaDZw?=
 =?utf-8?B?WmtzcDRFcW0zRE9MVUVnb2lPN2JkYVpGbGRiZjM0Z0pzM3lkTXhUcnluaDlY?=
 =?utf-8?B?UmgyMEFWZk9NUWh4NzZWa2U0cWhtektYREZoT25hZGNuOW44cFhSN3ZNSUdG?=
 =?utf-8?B?cDJKODlwVzRNa0lZamZiZkt6V1ZCWE5zd0dnMzZtWkxPZUZ4SFlIMUViUCsv?=
 =?utf-8?B?cDRsUm9XVVNFeE0zeFB0RzMvZDA3cVNDcUNGM3dqOUhsd2Q3ZGNkdU03amVP?=
 =?utf-8?B?YnRoQm9XSG9yVDNYK2dlcml6VURXMG1QT0J0UEFweE5NOTR6V0tod0Rvc2Zs?=
 =?utf-8?B?T1BQMEt5TU5DcEs3Mys1dGdIQWhydTZpQzJ5NWZGNzVkYmhlWHRIc05xWi9j?=
 =?utf-8?B?blNwRlF3TWdHei9YdEpNR3h1M0V1VzNHRFZySS84V0Z6S1JGVmxBUEt2KzVK?=
 =?utf-8?B?Z3dsRjU1QmNJdXhjaWd3WjZaRmlyNVJ5L1BuTmFzQXFFdW5teHk3WDIrcFlp?=
 =?utf-8?B?aEFhSzBvUjZMR3MyU3FDTkY1aEwrKzFvNXF4a1FOVENaV2E5S2JtWjZlbzQ1?=
 =?utf-8?B?aEhiWUlKZnppVUVZWGtYZU82V0pRMHMwbzlhNEszWlJDajlNSVkzcXNucTkw?=
 =?utf-8?B?UWFJOStCc0RkZmFhRER1UXhRYnQ3OG0zWmhJd3A4bm16YnBHZFQreldUNDBF?=
 =?utf-8?B?RVhNcE9mLzlDZW55ZlgweWFHWnJ1c3lyOXkvWEE4RnRhVjE5SWpkNHZZK1gx?=
 =?utf-8?B?cTNiUmRrYVF3UVpGWWFkVVZaVkpMR0duYnQvR0Z5c0dKblp3KytRRzJpVytH?=
 =?utf-8?B?WFgyU2NNWUZ1M2x4WVJia0FHSmRQU0VQaytMUUxXOUhpc3ozVzNOZDY4WkRs?=
 =?utf-8?B?MDNaYTNlbjArUUsrZU40L1dWM1ZnclVpRVFYTG5NcXBZT3VGQUg4Q21Ldzdp?=
 =?utf-8?B?TGpxWEVxK3djUTVLdG1mQUtQc1RFMUJUMW9LZmNjNlpqVW1BUnBRZmdUY2ZC?=
 =?utf-8?B?TU9jNkI1cklLVFpMY0pFRGp5NXZmcGEwTDYxRUZXcmZ1QTNQekJMM2tpUGM5?=
 =?utf-8?B?cjUvUlJvQzJ1TEJLM09OOHV6S1liT0NKVTdmVXVMUjMrZ0MrZmtKVEo5Zzdj?=
 =?utf-8?B?bG9UeTliSE1hRmZKTVZ1K2IrMUR1T0x6NElLUTVrK1k5aC9vUmlFeEprV1JN?=
 =?utf-8?B?T3hvMXRDcjh5aGhwWnBnejFhMko5VTFZbHc5VTNRZ21FOXFPckxIT0FWOU80?=
 =?utf-8?B?dHBSQVRsK2RzWGtLWnpYMXpFVnYwWXBlTEpWei9oKzRpcE1tQjRBUHk1eDJa?=
 =?utf-8?B?R3JGaHhHV3d0dWFEU3pYdlkxWFA5VFJWQjVYY05XcGxpNm90b2x3dG1FU0J3?=
 =?utf-8?B?SmlqMVF0MmlrQkgyZ3IxZmI3bHpNZ0lObzRqckxaTFNXQVJnWEtsbElSN0c4?=
 =?utf-8?B?U1RJZnhKZndXZ2w3SEdPWUFqaUNaMnhxNTB0V2RLeEphOFdlZERpUFZNZ29F?=
 =?utf-8?B?NmFCaVdqTy90bmNaVXV1ZE5lS3V6alV1Tks1ZndBYlIybGhYTkZIWFdjWWJo?=
 =?utf-8?B?ZjJYVzVVQSszTGgvcDdicWdHa1dGbUQ3OVRIRnQ0N2wyK3BDclpPTmhHK2xW?=
 =?utf-8?B?L3RsMzFVWEcxUjBzb3FEQWhtSzZ1SVp1R3F6WW9oUzUvRGNiVUtzb0FzdFdH?=
 =?utf-8?B?TXJDdWRmRVRHNTJpbW1wZ1ozcCs0clJGdGlYN1E5RnRQU1RUSExYVUFXS3lz?=
 =?utf-8?B?S29BT3AyZXIvZ0VCeFo3MFgwZEhNdWhQNEdMZExhZUJndllSM3NqbXIzWllu?=
 =?utf-8?B?L2trMzBkWGI4Zld2S3haN0cyWWFtYkFCbldFT1NRNnVHaGhlcm5ZUzVBRC8y?=
 =?utf-8?B?TmxUOTNpOWtnNUM3Q0JhSDUwRE1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JtCgkni5GujcjkKVVQ1Kt77dn24ZsMYfdMModl2ax67bK/OXK5jgvQqsIM6MUxPqP7+AFSuAAJqK2gIMeapzDB83wsbyxe90EAKBEe+UGqSznWI1L2+HtblnKVsP7dFC4bqtKE4wLbnGrTQMEJm+kQ2LJQYpBkx/YqCnap2x+QXOyd5M3GtmhjXI7EZaBDddHCyNmPjNHCU3RjDv9uAY0roLN2kUmWPeELQ1Mpe6C13q62LdVIJ2hMO5Dt6pXNHJGCyqXq+0s589tGHmwnM8STB4H3GxPUHxoHL5OBaKXNHKQfCIM0cduU0zi0ZXxakqyngPf8sZJ+VzeFeZcvNftXMeuiFqp9Ovjlm88uGHkLJida/zuSuoIkLNJhJ3zi5qRJmHS/uh/NH16NoyD7fRR2aFtzZq9hgJC5/PoInKS4y/ReuW0OKkRC0yQ41uKZvb
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:14:29.8106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d62763c5-09c9-4fad-3f2e-08de63de90f6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256672-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,ti.com:email,ti.com:dkim,ti.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 86D8AE4F57
X-Rspamd-Action: no action

Hi Kevin,

On 2/4/26 08:11, Kevin Hao wrote:
> While addressing an issue in the cpsw driver, I based my fix on the 
> implementation of the emac_ndo_set_rx_mode() function in icssg. During 
> review, Jakub pointed out that the dedicated workqueue for the 
> ndo_set_rx_mode callback might be unnecessary. 
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uxdqXRfPtm1bKoXPFrvrtsCD2dIkXHVJwEzupcwg1k-qY0e_2PUuMdZgJf- 
> SUVShc4kuXcBnqQbeqGz1dHBW-_OSdROPAjSiNpSTmAhDg8nQbc8$>
> ZjQcmQRYFpfptBannerEnd
> 
> While addressing an issue in the cpsw driver, I based my fix on the
> implementation of the emac_ndo_set_rx_mode() function in icssg. During review,
> Jakub pointed out that the dedicated workqueue for the ndo_set_rx_mode
> callback might be unnecessary. I subsequently used the system workqueue for
> this purpose in the cpsw driver, and it performed as expected. Therefore,
> I believe the same approach can be applied to the icssg driver. These two
> patches aim to remove this dedicated workqueue for icssg drivers.
> 

It would be more helpful, if you could provide link to the cpsw fix 
which you have mentioned above.

> Please note: I do not have access to a board that supports the CSSG PRU
> Ethernet controller, so this change has only been build-tested.
> 
> ---
> Cc: MD Danish Anwar <danishanwar@ti.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Meghana Malladi <m-malladi@ti.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Himanshu Mittal <h-mittal1@ti.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Markus Elfring <elfring@users.sourceforge.net>
> 
> ---
> Kevin Hao (2):
>        net: ti: icssg-prueth-sr1: Remove unused workqueue
>        net: ti: icssg-prueth: Use system default workqueue in ndo_set_rx_mode callback
> 
>   drivers/net/ethernet/ti/icssg/icssg_common.c     |  1 -
>   drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 13 ++++---------
>   drivers/net/ethernet/ti/icssg/icssg_prueth.h     |  1 -
>   drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c |  9 +--------
>   4 files changed, 5 insertions(+), 19 deletions(-)
> ---
> base-commit: 5c009020744fe129e4728e71c44a6c7816c9105e
> change-id: 20260203-icssg-prueth-workqueue-f460eba72132
> 
> Best regards,
> -- 
> Kevin Hao <haokexin@gmail.com>
> 

Thanks,
Meghana

