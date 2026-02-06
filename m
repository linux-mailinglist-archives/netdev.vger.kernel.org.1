Return-Path: <netdev+bounces-257467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MSgG514hWllCAQAu9opvQ
	(envelope-from <netdev+bounces-257467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:14:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA7FA4FD
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4949A301F208
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244A30BF62;
	Fri,  6 Feb 2026 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NcVvwx/G"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAB2459C9
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770354355; cv=fail; b=NxVqlrXbonz/R8kC316gynFSFLk6ORgy0fYbjdKaVrBmG9DUn2j9ox52LPa5Kr0QlgS/AM8lqNpbaQZd3rVkqtJE4R7zRA963YCd8xLW71jv+ucmNR6LIfdhRRJuTz72PxxZS3oVj3EN4R7vRi8EQ984QXch5WEIsPA+pof0wUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770354355; c=relaxed/simple;
	bh=FvR2rLNMw6csxdynDew9yY1G5HpjZ+XV8pDaLBOQngY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e15kVeigknFF8IFJGGlzoPQeoo4fNCzr1AOoT5LYKiCIEOlLlUrriiOypOldKdnNFDd6TLzXpkXIiSHS7uhEPUP9muMBW4zhvXoonsJo5rDoBHNA7kj9sInGt/MmSi7LHbMXz0lXDps79lZOpjc1Cj9WZrjwG3dkZq+avj3/xHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NcVvwx/G; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7F4F5bqtXiE0z0cwluDBGQg4KpJlEKNApgkUjBtzWuldd92YqcaA70NHDhC4C81otjX3TP8JEZaZwymYMqSlVe+4T0XBMvjmSaOXg1IL1UGXIWx8Omr24zwSB9HmZ2EmT+eKjdzvUHjlpl5bA+EYf1Rssm6k0j15vV/TSXE5jFXEgx33ObGw9QFexi0oY3qJ68b+yhXePMBH56Jnj/UPkg9RfEc07HEedP08S5ZYOl9pW2HwFKYr/X1LhXf0ENLDRSYBAisA4K0a5k2TrxaxqNQP4JPvojUHVO8yI6u/kdt6wcneNOZlTdh96FAPU57KYyaakTAaNJAr83bE69xuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSEUKr8r+GEpUfDg24nkd8tNuTgGGehmwCpNWmoPRsM=;
 b=UMbwa8t4/8oSzV3eE8wTnSsMsWHB2IjRgVDlY/CQ16vvOHJ2bKW1dQT30UGj19oDFhSwl0V6atKc4zowY4ImYFQL7J+8d/NwZQoTMoiRqD9LYYRD2Dc/vZlKW/R3KDHbby+NYEgR4XZm74JvFPV+BLhur01tYGcjrPSFRkLRf3vKMoqjDymN0TKWKalqWzjTwvBXPA/V91v452yvH9NyyvzWX/LUNn4JpfIGPVEPB4LcjieUgNu9NIbanxqbj1gRJ8IDWs8N+tuhsexUOG0bwEf9N4sHeCMuVX9jsbinHaKUN8OWH6gX9WrmA2hVi+CEVTkd45FbDSIXXG6mp1T6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSEUKr8r+GEpUfDg24nkd8tNuTgGGehmwCpNWmoPRsM=;
 b=NcVvwx/GEZ9lGuHyIclaVbq1AdIwaYFImEwUocthjf/bJmKxm14s4itlwb+kJyVgXpHbAME9bIvwr+7zjFv4gMj/IhruRqAIBSxYzTrsBWALMdySH9ErgchwkG0u5qp5XyMKyYebX58/BmzUbgAyT6JizOA3skFqw8nDH5InCCM=
Received: from PH8P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::11)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 05:05:51 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:345:cafe::bb) by PH8P220CA0010.outlook.office365.com
 (2603:10b6:510:345::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 05:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.0 via Frontend Transport; Fri, 6 Feb 2026 05:05:50 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 23:05:49 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 23:05:47 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 23:05:47 -0600
Received: from [172.24.231.152] (dhcp-172-24-231-152.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61655hUr556223;
	Thu, 5 Feb 2026 23:05:43 -0600
Message-ID: <30f02e83-8cb4-476d-a8a3-b21eb61f4355@ti.com>
Date: Fri, 6 Feb 2026 10:35:42 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg: Remove dedicated workqueue
 for ndo_set_rx_mode callback
To: Kevin Hao <haokexin@gmail.com>, <netdev@vger.kernel.org>
CC: Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Meghana
 Malladi" <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Himanshu Mittal <h-mittal1@ti.com>,
	Simon Horman <horms@kernel.org>, Byungchul Park <byungchul@sk.com>, "Markus
 Elfring" <elfring@users.sourceforge.net>,
	<linux-arm-kernel@lists.infradead.org>
References: <20260205-icssg-prueth-workqueue-v2-1-cf5cf97efb37@gmail.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20260205-icssg-prueth-workqueue-v2-1-cf5cf97efb37@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef9389d-0faa-42af-3501-08de653d65a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGp1Y0FvcXpLTURIUDJTTTlXQkROOFprL1BzWnRBQUtJQ2tweVpTeVBTTE5R?=
 =?utf-8?B?dzJlb0g3TjBtUnZrdm03Q043SklScHFZc0ZjV3hBZW5LZDJSMzNmRE94Ynov?=
 =?utf-8?B?dk5SbkhpODljSHRqOVpTMUtpL3NKUzlZZGp0WDJWdmF6ZVNHSHpCT2ZzV0RK?=
 =?utf-8?B?eXlDYUFSSmdKVGdscHJORHNJRnRJeFBLU3lQamVWbmYzQm8vdUVtWGZuc0hO?=
 =?utf-8?B?aGt1Tk1Ham1MeFJEMU8vQzFBYUZEMVd6dnlzYlFPS1EwQ3Q5bmNkOHhLOHZn?=
 =?utf-8?B?OVhweWlhaHdBb250MGhvYlJXa3d6Zyt6akFDcnVraEFiS2psbnU2OWhmWWtL?=
 =?utf-8?B?dnlZWUlSbTRmZFlpZlR1akpicTBWTkVpWEo0WmRZblBJckI3NERZNDZBKyto?=
 =?utf-8?B?ZzNjZUZNM0RJZnBtM3pEbWlJV1R2ZllQNUFTQ2o0eW5zRUkwR2xvait2N3Bq?=
 =?utf-8?B?L2VwaGdXbi9IbS9BVnJSeFNrNGxkYnpSNWlpRmV5aTJuc20xM2R1TVMzeXdz?=
 =?utf-8?B?WGlJeUJQQ2lhalNhcGJ5Vms3VWlNWHhYMHFpQ1hja25hckFLWTFqTWp5Wjli?=
 =?utf-8?B?VGhETVlnSCthTXhpd3lGNzBHOXhuUyt5aVdLWkZCMU42NStUZVZoSEV0dWJF?=
 =?utf-8?B?Vkd3VWtBdVI2QUNhdUVkYnl3TTJqd3ZhRFIxUC9sZm9CczZ6V2wwbTVhWFZF?=
 =?utf-8?B?dnhjQUdsRTg1ak5FOG5sYzVtYTcvaEZOZ2tsMHZ1am94cTlEdDNTYk0ySkNR?=
 =?utf-8?B?NUsyNGZYZ1BqamJQUHdIS3F0aUtuOStxTU9hWXIrY1ArL1l2SDlmQVdWYm0r?=
 =?utf-8?B?RWliOHQzcXJJWGFoZTJzTTh5MzJqaUx5K1lycmU4Zkx3RlZmWFVtTUdCVW96?=
 =?utf-8?B?Sm9GbHVKeDZiRVdENU9ZRUxCb3dITmtUSHZCQnF2R1NiRmFWL0hVNGVFTC9X?=
 =?utf-8?B?V2lwTVlKU1o5VTU1dHNqK0E1NGM5aHc5L0JmditvaEkrUGhtZGhEYjdZREkz?=
 =?utf-8?B?VUdkalhzWGlGeHljV2UzUjkvQktxMFc5K3BlV3dIR0VubmhHRDhUUXZhakw2?=
 =?utf-8?B?TXI1UjZEZ2ZmU2t2bjlhKytsQU15UGNIYzhyWncxVEpTVVJzcW9UWnBXNEZt?=
 =?utf-8?B?TG9UeWVoVm1tby9Ubk5sK3BYVlprMTB3Z0pnMUZnT0FDTWd6c2J6WXZvOVFH?=
 =?utf-8?B?VkVoa1JGdk5qdXkrUFpTOE9teU9LNlZrdUZhMStqdEVwaE5jdC9PTlpnL1Aw?=
 =?utf-8?B?T3BSdkxzSHR0U2lmRktlaU9UaGFJQW1IU2xiei9jYmRFUzl4Mm1aTURCdmcy?=
 =?utf-8?B?aXNFTjZIa0tMODIzcTA2ZmRaUXRRd1Q1NjRMRGxwV1NTc0VtdFdIdU53Y2hz?=
 =?utf-8?B?dzVnaXB4bFZ3Riswd2dabm85MExPUnd0UVo4cFIxWDNsWllCaWNLZSs3TFJz?=
 =?utf-8?B?TGRkZUhJdEZKbDhhaVkwL3dpNTBKcWMwSkplN2FjUmxway82M2ZDNzg2YWFq?=
 =?utf-8?B?OXpicm9sYTBCUFUvMW9YZzN4OWl6NGNYenYyQkkyYXQwRzNOVHY2MUZBMXlI?=
 =?utf-8?B?TTI4VzhvQmRHR2h3YW5ybXVhQm5pR1hpd1pWR0NYaExNRFhaSE5kbDZSQzF2?=
 =?utf-8?B?eXNzS3g2VStmV2xReVZFbEhDbTRMWElEMndmQUdXVnJDOHE5eXZGaHpRc3BD?=
 =?utf-8?B?RGk1bU5tak9vUWhIMUZQcjVONkhzMEcyTEZWYUp2VkNGb3ZXekVMcENpUEIy?=
 =?utf-8?B?S3ZSVjR3QjFIb3d6MkJBYXN6dTdia1dES3dXRC9hREZLaExqY05STUIwY1F3?=
 =?utf-8?B?MkU5UkF1S3BKV2lFam5RbUFDcEdoSnBWUis4bEJRaTB0YzcrYzBQSXNBRHFK?=
 =?utf-8?B?NE5WVzRTZkgvOUowRkQ2TWF4c1BIWDJtdUxSaDFWNVFJMVJERWxMaVhsRVMv?=
 =?utf-8?B?L2ZFWTE4dzNTZHVrNkNmN281M1picHdCUnQvWmxYNmIwUStYdWtRQkYyMnpG?=
 =?utf-8?B?UWIzeHAwVTM1aHBNY2k4K1hvTGowM2VZdlRobmJuL204b1I1dVhWQlMwSlZG?=
 =?utf-8?B?ZStaZWZYK2haNG93YVY5UTR0L2VlRW9lVnFReGlWR1g0TVp3V1RuaHFPbHQw?=
 =?utf-8?B?UUl2TXRmaFlSRzdqbjY3SUdETzFpME56VElveDh4bU5nV2RQSXB6UXpWS3Nw?=
 =?utf-8?B?cWtTYVNVaE44ZSsySnE0TTl6V3BVamdRbmNHYVlpeXBsb3UyZXJ6d2xOVUxi?=
 =?utf-8?B?akFFelg2dWZkclluK1ZOQWsrcDZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2yuk48yXPBRxz45LoPKisoCSkm5CCdoD/kMT5eQLIpTf439vpdWi64etGFtMYoBGnFEM24LWbprLqoJtsrk/qPauXd6hd4rNxcHl9AvpuU2Rv/Ly1V3QZU2UM71zaG6bS1PRZ1A55oHI111tur8zwuoZLGeqS1AWXnszsEK6BIGBbSehSC53LT3WlBjWDYKDpoYD9F3wGFqP7TOrInxrL30U+IluCspDYy68cA9mSiDDp80dRZZSJ4/AQgsOZ4S43D4nEI0udxqGnS0HHPDscAOkHEur7ZaVYLA9tizoZY9AAW2OhYA0uEeCfBsEabmx5M71zxM673P/m+SXFzrOS8fwziUg34g2grhCHoV7SsL/PIyk4+v5fYBQND/ch9Tuw5Tz5HIXyzRyOmz16ghQqprEu6zac0sSXixXAno27iUQ6CvNaj6xPvnPyOZPDQkh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 05:05:50.4709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef9389d-0faa-42af-3501-08de653d65a7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7793
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257467-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 98EA7FA4FD
X-Rspamd-Action: no action



On 05/02/26 11:55 am, Kevin Hao wrote:
> Currently, both the icssg-prueth and icssg-prueth-sr1 drivers create
> a dedicated 'emac->cmd_wq' workqueue.
> 
> In the icssg-prueth-sr1 driver, this workqueue is not utilized at all.
> 
> In the icssg-prueth driver, the workqueue is only used to execute the
> actual processing of ndo_set_rx_mode. However, creating a dedicated
> workqueue for such a simple use case is unnecessary. To simplify the
> code, switch to using the system default workqueue instead.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish


