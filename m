Return-Path: <netdev+bounces-256674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OPZMC0sg2kxigMAu9opvQ
	(envelope-from <netdev+bounces-256674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:23:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AECAE507F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BDEB305CF41
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C23E9F6E;
	Wed,  4 Feb 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uKtjUDEo"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6363E9F66;
	Wed,  4 Feb 2026 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203929; cv=fail; b=ks4k0//WqY1xymkqeeIr+d3jMoqd0v6lEFI3rs9DKkUUsKRP1WLrUpISuDBnf4rcq/c2LWv0fnyxw419Wk3RF25A1G+IrMt0GSVcdjpnXnUxKUxn60QYuK5DHXT9pYjpgeEYorMJk9p0Xr/DSLrMSRnsMLDk7S4UwBYZFaIc6Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203929; c=relaxed/simple;
	bh=cmZ/h7/5+oj2FWmaUC39VAArjIzIeXfZNb8T6itSD+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MRLcF+n48/0UlgzhaZyxGFbcHPoEbeAyuP1gPAHDH8zsbiw5qmRGtCyt3yAAHCt+M03w+/DAj8dp8mlYfvSdqqoG4c/FPl2jkSA1P+8A2WV3whJZofEINOfAFrBYjVBYu1QEKjGTYtFmDYZsZ9ot1Ia81qeIHaUGWWVidGmp/Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uKtjUDEo; arc=fail smtp.client-ip=52.101.61.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2TDbLk2UODyS9hTZyWU9I8Y+NhrfrcXlKBkRnse/g5IwvUyXupL1ZuzPafE3U//nbiunSxMezx0rbBKVYv3HKM0PZEmbgNPZrVNZ1Nivi7/fqoD8pxQdMGojph5o90/OUfoTglR/aDCkesg/BH8znBKUKOtW2623QwsUHJkfuYay/S+OSgyARiR85GmwSTlnxO15S+gL6KxOXeA4PBxFnJ1UF10SzL01DDc5zsaK/4TyTeoQXv/cEZdEa+zoGp1ABXfNzNyfI4FhXrLxqAgWmWF4utOcvfUOLzeZxvXGw/zQorwvLQVAA9IYFDQ2/CfZ0j//DzHjxf3eXng3b0e7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPGueOcdCs/n2ABx4XDstga8oG0Bn1IOn2kP1euUCpU=;
 b=XZf6BLq5ha1WDdtYwoDNLPPn4YA9mLlU4tVA9+gRaQSFVLZ3kUjExYbV7IzUDm0Ownn9aPqAfww/q4ydiOvJj+jJREYLmB1k32gL0xKT6DDghmBWUi7FEtIGZZPisyhC2OZe4EO3vYcr+FgMfT+jbhH1zedUZrY6F0h02FvevmR812BnLZll81M89g4Ffh/QnxkMsXTQSWe1vfh3qtnFVRwd2kr7e6/9qo9mQ9QIUoL9FzzPX8ijCK301vKF8heZO2kZNz1MEi5a6aFGVrI0rIMawHRYdYHL44ceSHZg9hhEX7TOsP3KLDSaSbgzsLmzQVXGxZ7Iw2TNzdB/qVpJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPGueOcdCs/n2ABx4XDstga8oG0Bn1IOn2kP1euUCpU=;
 b=uKtjUDEo84Oy2wg32X4/4RG1idi7ageHFN0+FNYdpJPiCHo69giobwTIylk1JoXJx6SNZbR38UqvYnKx/Xj88hALiKOXdjr5rKFRq86HC9nJHPDKx1DGevZPXbcOXVxACddwqWedNBdSXRpD3QgD7XxGmDjkHeKCKoCjQPa3RLY=
Received: from BYAPR08CA0039.namprd08.prod.outlook.com (2603:10b6:a03:117::16)
 by DS0PR10MB8077.namprd10.prod.outlook.com (2603:10b6:8:1f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 11:18:45 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:117:cafe::d1) by BYAPR08CA0039.outlook.office365.com
 (2603:10b6:a03:117::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 11:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 11:18:45 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 05:18:44 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 05:18:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 05:18:44 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 614BIdnP1445698;
	Wed, 4 Feb 2026 05:18:39 -0600
Message-ID: <84dfd44f-56e6-4d1a-a1c3-702988236f3f@ti.com>
Date: Wed, 4 Feb 2026 16:48:38 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add Frame Preemption
 MAC Merge support
To: Simon Horman <horms@kernel.org>
CC: <vadim.fedorenko@linux.dev>, <jacob.e.keller@intel.com>, <afd@ti.com>,
	<pmohan@couthit.com>, <basharath@couthit.com>, <vladimir.oltean@nxp.com>,
	<rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
References: <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-2-m-malladi@ti.com>
 <aWkAXHXHHOD9SDBt@horms.kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <aWkAXHXHHOD9SDBt@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DS0PR10MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f436e9c-ef1e-49dc-9c6c-08de63df293f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHBveUlYaUxIVTE4aUFGVElTYXhBL1lzSnNJdWdDdFE2Wk51K3VZN0NDZkhW?=
 =?utf-8?B?ek5HTThCekhSdWtDdWxaaU55OHJUY3FFQTMwSElZU0Nxbk1OcHRZRUxVbzZR?=
 =?utf-8?B?aUc3R3MreUJLQkxPN3ZGcEJuMjVXd0QrOHdzK2lTNUViM0JJZ2d0a1NjWCtk?=
 =?utf-8?B?eGUxKytzUFNpejZuVkwvS3k4d29XSFRNRFZxT2M3M1RHYTNwMTFya0ZFeWI5?=
 =?utf-8?B?LzlYVjN1N3lQM282WDU1S0R2RWNEUUZlSFEwdGFpZzdrMDBOUitOWk1lM0Vz?=
 =?utf-8?B?SEpCbFlxQ3N4Y2ZqOUFLSkpSL20yS1hiUjJORmJWWXNITUJmZjVNdXdyMzcx?=
 =?utf-8?B?SnRWYit3bFNWOEZ4eW4xNUlIbTErWU5oVHMyZ0JkbkR2RitEb2ZWVFIyZkRS?=
 =?utf-8?B?WWJyR3poNk55L3krWGRKN1pkOGk0WXZBcnd0dXpPWFFlK0o3RnE4OTgycWdn?=
 =?utf-8?B?cmdWQUkyb3kvY1p6eVdxdXl6NFRnQnkzdStqTmgzUk5HQ0oyZytLd0gxVGEw?=
 =?utf-8?B?a3JMeTYrVHk5L2hjUmpPb0dOeUVRdFRLZG0xTm5PTC9KRnEraHJ4a1lPTE9L?=
 =?utf-8?B?cVl5cVg0eHYrSXYrQ0lOR1A5dGU1SlJ4dUdaRzVuUmVza2RabGZ3ck8wZS9M?=
 =?utf-8?B?cDl3elN6L25iL3FFUjRzTzN0TXJxSXhxRnhVOXE2NmIrejFPWXp5TDByS2o0?=
 =?utf-8?B?UjFNeHplL2pObUhNcGhWY1EyQnZpV0k0b29IK01lcUVwVE1Jc0l2ZDZMM20x?=
 =?utf-8?B?RWNSdXlNL2NzaXV0SzJaZ0JQUGs2U1JQSWl5SzJ3TTZkZ3ova1QwS0EvNUNj?=
 =?utf-8?B?blhHYTVwdTlBVmt5TUtMM2c1dmdZdUlJaHl4SGtPWDYvcTB3bm1xdDdQcy9y?=
 =?utf-8?B?cUFqUHJEcnpTbG40RUg1cTNmdlRRbFZ2M3ZmL3k2Y3hCSlRSZXZSazhrN3pT?=
 =?utf-8?B?ZkhnQTFGVndiZTdlNGtoYk52eDJaUjZXU205Y2Fnek9CNldIbEZRdDJqcCtk?=
 =?utf-8?B?Tldncm5UckRiTFgrZ0tFcGVYbWQ4QXFYL2RZaDNNcVI0VWRvK2JlN2RFbkp6?=
 =?utf-8?B?dGtFQU9MK2kvWC9OSHNUc1Z3ajcxRjZoTVpxcnFQaWN6SnZsc0tuV2FMSUEv?=
 =?utf-8?B?UEF1OVRkNEJLb1NESDdWSksvTTc5M1JiTmRUTW5VQ3pUdytlVlhxeUswejl2?=
 =?utf-8?B?T0ZqNFRYMktDZ09KMnRzOTFkR0JCMzY1aW1RMHI5KzRjaVFnMTJDTXljWFZB?=
 =?utf-8?B?cnRIWGh1NlFFOW10cWsreHEzSVF0dEJLRTEvc2FWWjZlVFNLZFl2YTRBaC9p?=
 =?utf-8?B?S2pJdVhIcHM2MzZ3MjRUOHRkVTJobFlvRjNwSVEvdXh3Y1c5VGxjWFJBTm5p?=
 =?utf-8?B?YS9hZzdhaVZxcTZZNE5YRlNTSHdSWU1qQm00eGtCK2xKeHE1d3ZIL0RMVUNm?=
 =?utf-8?B?eWtTT2dZMXc4L0FQaEVYT2k4blU2VVJLek1PRldqUlQxZ2x4V1BydjZuZlZr?=
 =?utf-8?B?VExTU3ZjRWdUcEFua1hYb3d4NWdEdzZFQzkzU0I0a2I4NGVEaVRDMk5WRzc1?=
 =?utf-8?B?dVFUdjBqVFNsaUdCUHRMY2JzZVF1NXBTc1lIbnJaMjNPTnllaEwzKy9TNlpv?=
 =?utf-8?B?UzE3WDEzcFBHQjluV3IzdlRqV3JaWllxcmxwOGVZekVpdGR3UlZlcFgwTWxs?=
 =?utf-8?B?YnFLdEZIcG9TL21NcG0yR1Jwa2w3WmJWU0dHb1RINXVEdHpsTmhFQ0xSdldY?=
 =?utf-8?B?M2gwYndGN2N6VzY1bGEzM3UzZVdWOURiT3VRY2FjZldmcEdkUks3S0VIa3RM?=
 =?utf-8?B?NXdWVUZXTWh4b0JnMjE0S3RWUTdxTlN3Y1NSckFpTDNyYnBHSVlpaXRQb0ts?=
 =?utf-8?B?SDhGckVLZURlWExSL1dVVUxjbzM0ei9kRU9BM2ZlaU1NNllPdHYzYXBsdzJN?=
 =?utf-8?B?VjZlSDRqTmM1b0dyallwcHpqS0s4d1o2bFVOb2NlSmpvNFl3YnB5anRYVW1q?=
 =?utf-8?B?VHNEc0MzT2pIaUM4cU45b1QvV3FtTWdVWGZsTUhYSkZjUDljTXlINFdtRHN5?=
 =?utf-8?B?TlFsbDNKR2JFQVVmaTdQeHB0Wi9veTNyYVVLQWZST3VwSUZGR0Z4dWdUZ28y?=
 =?utf-8?B?ZmE0RFlTcFVFakJkK1ZvWHV1L3h2ZXZBTHdSSUFIbCtaMFkwamJMQVBCTmYr?=
 =?utf-8?B?VUdBUkw5c0U3K2RxS3NIL0ZCUS9CbkNSRkY5Mkt4MHhwMVhJdm9tTkgvbEJW?=
 =?utf-8?B?eHdTTEE5TUExTkRsRStPSGJ1RGRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eWTnpwOS3S8MtOySbkrlhTucym+SHc8icLjeyCyTqS5f6hrgsGd/tWklg5XNrWOMmj8QGg9PwCZz/WuJgut1ZtaqfAHj8983uZmkt+8KAFSk9U7IAKXYKVXhDeDwoZpwjqf1y+El56r62YQNQtb5Oaz0tPzzTbTEV6Ra16HjNkkA0d/mNFHJe+KOMO8OOoKPgN98qdQRkcH6qxee5fyXl9VwRJ7j3uUnkYUZR2BPTsp+RSTkUlXEqUEeXFxLRHxce7lqFw8UazU8itSkQ6rdIbV+LM4zv9yBd7JRoRLEd9wecpRBoFgvhGQ+BN+1JUtQ4sG8SlZSKmViWk0uQwa5PSHPYmCUPeB3fZ2wp8y0+aIxvQqhLS/70p8KkFjp1imm0HB9PZezAFt3p1oad+olWxJ5J5WfWcNRF9p3qPRWNesJVH1rSkjPWsRRG+zO60JX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:18:45.3250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f436e9c-ef1e-49dc-9c6c-08de63df293f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8077
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
	TAGGED_FROM(0.00)[bounces-256674-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
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
X-Rspamd-Queue-Id: 2AECAE507F
X-Rspamd-Action: no action

Hi Simon,

On 1/15/26 20:27, Simon Horman wrote:
> On Wed, Jan 07, 2026 at 06:21:10PM +0530, Meghana Malladi wrote:
>> This patch adds utility functions to configure firmware to enable
>> IET FPE. The highest priority queue is marked as Express queue and
>> lower priority queues as pre-emptable, as the default configuration
>> which will be overwritten by the mqprio tc mask passed by tc qdisc.
>> Driver optionally allow configure the Verify state machine in the
>> firmware to check remote peer capability. If remote fails to respond
>> to Verify command, then FPE is disabled by firmware and TX FPE active
>> status is disabled.
>>
>> This also adds the necessary hooks to enable IET/FPE feature in ICSSG
>> driver. IET/FPE gets configured when Link is up and gets disabled when link
>> goes down or device is stopped.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> 
> ...
> 
>>   /* The buf includes headroom compatible with both skb and xdpf */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> 
> ...
> 
>> +static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
>> +{
>> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth_qos_mqprio *p_mqprio;
>> +	int ret;
>> +
>> +	if (mqprio->qopt.hw == TC_MQPRIO_HW_OFFLOAD_TCS)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!mqprio->qopt.num_tc) {
>> +		netdev_reset_tc(ndev);
>> +		p_mqprio->preemptible_tcs = 0;
> 
> Hi MD & Meghana,
> 
> p_mqprio is dereferenced here.
> But it isn't initialised yet.
> 
> Flagged by Clang 21.1.7 W=1 build for arm64.
> 

Thanks for catching this.
Will include W=1 build test in my checklist before posting in upstream 
from next time :)

>> +		return 0;
>> +	}
>> +
>> +	ret = prueth_mqprio_validate(ndev, mqprio);
>> +	if (ret)
>> +		return ret;
>> +
>> +	p_mqprio = &emac->qos.mqprio;
>> +	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
>> +	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
>> +
>> +	return 0;
>> +}
> 
> ...


