Return-Path: <netdev+bounces-258286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGZsCdaJjGmHqgAAu9opvQ
	(envelope-from <netdev+bounces-258286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:53:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F90D124F7A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA259300E72A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055C313E3F;
	Wed, 11 Feb 2026 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vVl2rI62"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABB313E3B;
	Wed, 11 Feb 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818003; cv=fail; b=D2/v2jiQze5ixQZJb4chEvMVpV/jHLkPolUesOzjREJ1Uc0R1m0hKSE+PDRKgcTO5sv7HdkYmUTLe4U0TCJzps+9+NlQYGPY/xWdKcb9Kg9JYV8O0qunhdTffITJAUEDGMOFPA+lUU1s83LwrmbTJTS23llwxctNWfpdC1RVUwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818003; c=relaxed/simple;
	bh=B7ba/UVVwKfVvNklPm0Sy0LLvD2S73WSKq+nd7CYANs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZPO5AqVUxNfIUmGJOEhvnOfdOY7u8wflVQjq7yZs3ocCR87Ui3+j+v5FeQIok1WhANSt2BFIUOh7naAei/4OrAjiIkVmxouVTPPfGLNDnD5C1jmWv7VL5r/4g7IXjK9kyL7C7QB9x+1t6Tfeo24c35nblowy+dLBkoBHOGgLdzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vVl2rI62; arc=fail smtp.client-ip=40.93.194.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3G+7RzKR27FUEkszWc5Uvayz5SMNPF5lK/ndoutgXu9sYGR15DslTsDzxDdPaJgM0FIB+iBYUzdjCS14P3AvUpjG4+8AiGHRJSbjp9PKEh/QKWXe8dsZWUq9b07QOLIVLA2gp2wYXLr3svNfDB9cPs++vHphWedEhhYjU1eIWG7gllOpE35rmr1vUVtPyZMpVmZ315qk2IfcQ+czRJCsRmpPEO5xVEoL0xYayJxHcP6+BPsXiF2kTD7RE5gxhr6RTy3I3t0GikrH9jcSM2mLmDobPIxUUtH0lAthq1yoRix9i1w9iwZYG/XOvGZ4us6VstILHnGipfVN+K2Q0LuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zrgHXfY/4fH+ClhBAjA6HuKhHw8LEnG+ogcGBv/iCw=;
 b=aoGOkkT0FO4ungXTrL+6Peq87yTjxdiwjUgBBCzGYeeSX7CIf0WLwLIcDhAv4DUi6HH0pOJrsXSLbFbHylUXyX1anZmlkk8rZITFwgEU2G0huaXTfzngjWOdYO1pnN3VCcHBZaUiIkxqbccFZLYxq6uf/iJStwR1FZCoE4RTvqcsyzIpRB5yJnJ43KVqfYybFBO7uorZVxmyZ24CRQYTECuyotP4b2QWTg7YOzXNtFNN8bf9HGTSU9f3u/ODVxn/Ou+RE8WNi30SELOr5g8q1f0zadWRqQPLXzNII35alsd17pWo7BC4cAJwDcilpouNVHCtrCQU/XhU4JCLflpOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zrgHXfY/4fH+ClhBAjA6HuKhHw8LEnG+ogcGBv/iCw=;
 b=vVl2rI62AGH9la36bF+bWnhh/FjZL4u0djYotZvoexOpYX+i/+kIG3U8W+q/efgijyqMF1PZw+q/Bo9CtlGTr1f54cJau5gB4x7p92gM6LFOPuNErxMNH89P+Ky/drcOven9rrKs592FiSkfO0iTx5Ua2vqU5JO+r0YerfDCn28=
Received: from CH2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:59::21)
 by DS4PR10MB997551.namprd10.prod.outlook.com (2603:10b6:8:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Wed, 11 Feb
 2026 13:53:19 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::dd) by CH2PR03CA0011.outlook.office365.com
 (2603:10b6:610:59::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 13:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 13:53:18 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 07:53:17 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 07:53:16 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 07:53:16 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61BDrDS71294425;
	Wed, 11 Feb 2026 07:53:13 -0600
Message-ID: <b500116b-afdc-4e5b-af4b-6c1e15116111@ti.com>
Date: Wed, 11 Feb 2026 19:23:12 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: dp83869: Set auto mdix bit for forced
 100Base-Tx mode
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <hkallweit1@gmail.com>, <andrew@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>
References: <20260211131033.2525617-1-m-malladi@ti.com>
 <aYyDkaynWEm-WJdg@shell.armlinux.org.uk>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <aYyDkaynWEm-WJdg@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DS4PR10MB997551:EE_
X-MS-Office365-Filtering-Correlation-Id: 549f74bb-acaf-45be-ef7e-08de6974e93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkFWazNOYlZYdjU5S29OSHBCNWVmU1FkVkh0cU1CaDF1aFY2bmg4RTYreE9l?=
 =?utf-8?B?QndqUlplOXdvL3pvNjdSb1BHVkFVNEUwKzJXUDhONklHR1pUV0RWY3M5QUpj?=
 =?utf-8?B?cjBhb0dXREhxQUtmU010L21BcSswMTZidGpnRUNVd1BXaDkyWm03bUgxTTRw?=
 =?utf-8?B?aWh3emh0c0RPYzdBRUcySy82cml5QkpndVVnR0F0OHExZGJxNnZUL0VWUWxH?=
 =?utf-8?B?MGpFd0V4b3F3d1FkWVFYM1paZTNvZzdiYzNSb1pXRUlrbC9WK3kxVnhCakNQ?=
 =?utf-8?B?NGwrQ3NSSTVOMFdmazRqcHJRa3dRczBMWUxmQWJXZVc5WTZsRDFjUFVqT3Ro?=
 =?utf-8?B?K01GRFE5NGovWHloWlhRRVh3emQ4b0MzajBLMzNZVmNwajY5KzZLL01nTlp4?=
 =?utf-8?B?cjMvc3ZpbGVkc2lPUGFWRStSMDJqRzY0akhSSHpNdENSQ0J3bUN4L3FwMWJz?=
 =?utf-8?B?RGEyMFZtSWY1RnJFT0hvcWFTdTQ1QXFablBkNkh6QnRBZ0N3QXhSd2NkT01i?=
 =?utf-8?B?clN4a3VSZjFVNGd2YkZ6WFNkUldZTnZJT2xIaDFQWng5cFJkUWd3OENUelMr?=
 =?utf-8?B?bzdhZUM5Q3E3eGE4Q1BzZkNPTGM0RmRwR1UxMWNRc3ViTEh3SnhUKzNUaGlF?=
 =?utf-8?B?WW8vcEZCa3hDK1ZFRDNLMENIQzVSaS9weUtTcm1vRWdKaENGQXFTaWJJTDFC?=
 =?utf-8?B?OWlyRkc0cythbm5IaWdwYmVKc01yOVVhY0xkLytnZGozS0MvNE9MUFRlT2hu?=
 =?utf-8?B?M2cwNld0dWxpSk9lSi9DWW9YR2pSVXR4bFZ5Qjh6cC9zV0FQZGd1V0RFRngr?=
 =?utf-8?B?eHl3cXJicjhPc2Zzd0JwUm4xdTlDbkU0QmxtMnZJQllsT05LZ3Z5ZXVyZVk3?=
 =?utf-8?B?SkZmYy9DNWdQcVRpRzBQNFYvaE9PTDFNSHk4TkpQZFVNeEhwakQ0ZS9ITm1h?=
 =?utf-8?B?TFRTQWdNMWM5VzU0MWJmclFnNGdaZHB1OWNTclJuY0cwc2V2TEJiQTBScWNp?=
 =?utf-8?B?SmhFY0lXc3BNalR2aDZILzZFRWVVRS9RRnE5R3ExRXJDSmVJL0U4MURQbjZi?=
 =?utf-8?B?bzBoQ3liaDMrS1Y2UEF0eVp6Q085ZjNTMFg4dVREUU9JUmt0dmpzNklYMWVW?=
 =?utf-8?B?enhtUXFYQ2xrYy9TNkp1bTJWYThJWEFEVHJ1anN4dEhhU2dxOThMREd1NlBL?=
 =?utf-8?B?QkdEVmppdzJQdFZLYS9ETk5sYmtCTUZZWVZ1WGhjd3h4QWdRR2RDRGoweUto?=
 =?utf-8?B?MDJXRnZ3MWVxZmVUVzNndmxodWloSVRDWmlrL3UxdFUrUWgvNnIzYjE0bGY3?=
 =?utf-8?B?ck5mYmpxYmg5dURPVlBoUnRubU12RmIva2lnK3VDQ1g0cmljSlAxV0Q5TDJE?=
 =?utf-8?B?emw0MWpNT3dSaTQwZnZaVmFLdFdCakxDK2ZvVHBoTTN0RVhNbEdoUTBwRHd1?=
 =?utf-8?B?TDZtQWdxc0Q5UVd3amlsQzNRMzd1NXNSM3ZBOCtZNFpNalpiNmZrdEp1WStr?=
 =?utf-8?B?Q3RUOU9XYnZ0WU9iR1FFaUNucXRnRnBzbUNqdUY4SGRjZEllQ1BWWXFhNmhP?=
 =?utf-8?B?RlFoTE00c2dBT3V0cnBHb0w3YXI1dnF5RFlCc3I1dWdKZWZBRzJpQmhmNGw4?=
 =?utf-8?B?TjhxTVNIZTV1aEZrc1pmOVgwMFU1MWZlN2dDRTZhRVdIaGppcnZkSU81VkV4?=
 =?utf-8?B?bUtBdUtqVzRvL250eWMvZGNkYkdaMHdFamNEUTBDMlE4akZOakdiUjdtUFRO?=
 =?utf-8?B?MnY0N28xRWNHN0lxOVNjTTFRaFVuRUMySk1NcENrLzY1MW1zdEI5elIrT21R?=
 =?utf-8?B?bHpEL2ZhTTVmbmFhTWE1amtFb1JlSWg5R3ZXVWFvQWhKSExCeGxvLzdjOXRP?=
 =?utf-8?B?NithMXZFM01FOVlVN1ExSkZpWndScnJDYkZrY2Q1dmNjYjNGT09MbXczUFNj?=
 =?utf-8?B?eklSeFo3NW1VYlNmVVczV1hHRVZmdlpQZzc5aTRxRDR3dlBpR2hCOEs5TWhx?=
 =?utf-8?B?V2dqQWFyS1NTM01OQ1dIWVFhMmVZa3h1cDBlZU5pbVVqMi95bmJtUENJQnRz?=
 =?utf-8?B?QXVQa0JqclY4VjRoQmRDTWI0dko4V2RsbEFKcCt3enFDSW9UT1JqU1hEVUw3?=
 =?utf-8?B?dkJWaHcxOHBhOEl0WHo4L2pDMGhRSWMrb21vNW1qcDB1VlFHcXA1MkVobEp2?=
 =?utf-8?Q?ku9BYaYgjx/JrN6c6R/ZdBc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XAL+tun6pi/JWKBaqki2EIAWWVY1V/qKiao3Vw/AgGXqCK4Du8bJH5j0NhXLBCewvehdF9NsS96EpMPS+lK3Diar4ElGfvCdQbjStPl/SGQ126zEz7RTBjNjSg1a7Int7hZuSuQWMjK3nhARR6KBk2+hMtUbfe0zibMKvvK09lDwS+/ure3YD+A0/8xeA16lO3VsTx/UPPV01RiK8fiEmqy/nQSrj12FefgpFJ1cTkHqJHvyWgZ235kIU8DdKcROLPZgdgWgYBa3bDIJ6vRMjvSOyCu0YyYqB7ZWBfWGygNwrrLFeaWBajmDKxHQOGxqhAZaItW3Zu9iwqq7cfm4IcvnpDq18x449JSnC+JVzqV3XJmiss9dyz0tIGVzEd/zmp+TaOcDT1l46Re2MOvt+A9u+HKl/gSsezbZudWSacJmro5yJkfZ2jp5/2J75mq5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:53:18.2270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549f74bb-acaf-45be-ef7e-08de6974e93b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997551
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258286-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,ti.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:url,ti.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5F90D124F7A
X-Rspamd-Action: no action

Hi Russell,

On 2/11/26 18:56, Russell King (Oracle) wrote:
> On Wed, Feb 11, 2026 at 06:40:32PM +0530, Meghana Malladi wrote:
>> When using DP83869 in force 100Base-Tx mode, the PHY is required
>> to have robust Auto-MDIX feature enabled from register 1Eh.
>> Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.
>>
>> [1]: https://www.ti.com/lit/ds/symlink/dp83869hm.pdf
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>   drivers/net/phy/dp83869.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
>> index 1f381d7b13ff..70d759c45c6a 100644
>> --- a/drivers/net/phy/dp83869.c
>> +++ b/drivers/net/phy/dp83869.c
>> @@ -110,6 +110,7 @@
>>   
>>   /* CFG4 bits */
>>   #define DP83869_INT_OE	BIT(7)
>> +#define DP83869_CFG4_ENABLE_AUTO_MDIX_100FD	BIT(9)
>>   
>>   /* OP MODE */
>>   #define DP83869_OP_MODE_MII			BIT(5)
>> @@ -900,6 +901,23 @@ static int dp83869_phy_reset(struct phy_device *phydev)
>>   	return dp83869_config_init(phydev);
>>   }
>>   
>> +static void dp83869_link_change_notify(struct phy_device *phydev)
>> +{
>> +	int cfg4;
>> +
>> +	/* When using DP83869 in force 100Base-Tx mode, the PHY is required
>> +	 * to have robust Auto-MDIX feature enabled
>> +	 */
>> +	if (phydev->autoneg == AUTONEG_DISABLE &&
>> +	    phydev->speed == SPEED_100 &&
>> +	    phydev->duplex == DUPLEX_FULL) {
>> +		cfg4 = phy_read(phydev, DP83869_CFG4);
>> +		if (cfg4 >= 0) {
>> +			cfg4 |= DP83869_CFG4_ENABLE_AUTO_MDIX_100FD;
>> +			phy_write(phydev, DP83869_CFG4, cfg4);
>> +		}
>> +	}
> 
> Shouldn't this kind of configuration be done via .config_aneg() ?
> 

AFAIK, in case of fixed mode, auto-neg might not be triggered all the 
time. In the phy_ethtool_ksettings_set() function, auto-neg is initiated 
only if the PHY hasn't started. PHY drivers are new to me, please do 
correct me if I am wrong.


