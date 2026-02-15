Return-Path: <netdev+bounces-258781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1wRMO6DekWnGnQEAu9opvQ
	(envelope-from <netdev+bounces-258781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:56:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E913EE66
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45A473003639
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C200C2D4801;
	Sun, 15 Feb 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jfi3dBbt"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5F1FE45D;
	Sun, 15 Feb 2026 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771167388; cv=fail; b=ZI/zvko2y2GxbPPqKDxY5FfBfXmBcDnnW1/HIEuwvsUz7YdCSQI4EMg4N9BSNcBWASGPxmgpIlsQ6WXGLelMnVyvyzkcXPG21haCQ5+T88Z1lIU53rjwyFHcHwiJ9RhZgsbg6ljEtarnBKSjgBXujlbkRWLAcpLkrYDT8ABM8uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771167388; c=relaxed/simple;
	bh=G1vN3LTsR/NmkmT0FyGnO6fBCQ6OCzBTFekpD/7CRPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bgchDse37EjylSlnYcaNZYtnTMdLaGtqP5OC/aEAwY05k1mJ1yKSQT0VqgEwbco7Vi7TxoI03DbC3bFhLH54ehecxz/Igqp5inYYD6Ggmavqz8wgszmsr6aR2nMAGMYOlDmUDdQfpyruLx0JabyrU92vzgeMVTDcIm9DUDIuA5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jfi3dBbt; arc=fail smtp.client-ip=52.101.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOO4eFjGgeUyv0K8shLXfP1W8lockK67LbxiwdpYqryOJLYoiypggqnYS9YYhZzy3hu+pp1QUyLCjiSg4JKJ9OeDr07yr8AxiBBzv5VUxIbao7QuBmt3O8yzyHpjMUjydlKA39lGADwefR5FEDFzZSzWk8kJ0CF1mW/rfK3k+e5wUHH+Mo+RZZ/iTCoY4y3ZErHa2ScmsMGYyeVOlZtYBDoLdMExTyCmEz8CV0gp5wrQ3i3Ptqdtdwx9OsfTrq+7Jn6aoIx8mnR2OTu4E4VvZyHwMAtu3ASCPUTwjkYAhpr1oam0q7xN/jFZeW1lbsb1XAQXNSXzHUuBowukTM/4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lx5qA6cRKORuOAIubPSTPYg+Fe5uoz4S9hFSKDDzCc=;
 b=Zrf6+l7IAKMrYYaS0yNBQGWKzdseiTYta7gPFIqdB3YXT8ZAcZn8EsLZWcv6nZkkdhQpKfC/OGqHhCOo8+JUc1uxo7/m+GK5d8KNYkC5PJOMRxqfCO6I0fGed3mRWkLRMp3GAJk46vTPQKGKKdba4ijnNYW5OvMnZCcYJdIi3sneyG6shIbT1kc4IQ/tIh8Lh3rVqeRo7pjljLuVV3kfEN3KjPuele7Sj1+Rp7/8xj4wI4PUMMeSMGddQvrGKQ3VhwyllYu18UGpY6n8nzW2tVxF4o7bLnUvUuUyVKL8ehFDm4BzDlPIDqie2JdhwE3TAzr3VQOAX+bD2pBk3VBdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lx5qA6cRKORuOAIubPSTPYg+Fe5uoz4S9hFSKDDzCc=;
 b=jfi3dBbtVswfahiQ4O8HFSlpHt81D+r18WOTNFoPaUEPTpgF8f6j6TCGPtsarq7CLlpCOqX/Y0fCjFnsDrtxSUwdXt3Ge1rY9JrcrJ/AgWC8tSgMGEoSl9OKYFRvCKs7pq43yfo5nLfCgCoFk3LJmWQivJM9hMIoFQAe15KYfYE=
Received: from DS7PR03CA0190.namprd03.prod.outlook.com (2603:10b6:5:3b6::15)
 by MW4PR10MB6488.namprd10.prod.outlook.com (2603:10b6:303:219::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sun, 15 Feb
 2026 14:56:24 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::a8) by DS7PR03CA0190.outlook.office365.com
 (2603:10b6:5:3b6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Sun,
 15 Feb 2026 14:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 14:56:23 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 08:56:23 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 08:56:23 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 08:56:23 -0600
Received: from [10.249.132.38] ([10.249.132.38])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61FEuJZ4329172;
	Sun, 15 Feb 2026 08:56:20 -0600
Message-ID: <8bf32649-ce75-4b62-a735-919d7b826e56@ti.com>
Date: Sun, 15 Feb 2026 20:26:18 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: dp83869: Set auto mdix bit for forced
 100Base-Tx mode
To: Andrew Lunn <andrew@lunn.ch>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <linux@armlinux.org.uk>, <hkallweit1@gmail.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>
References: <20260211131033.2525617-1-m-malladi@ti.com>
 <0a9d0ec8-09c4-4029-8449-8c8f08c6dca0@lunn.ch>
 <a498b310-29f1-4775-aa65-fda027a3124b@ti.com>
 <9a256949-56ee-4d10-949e-c5009852ca44@lunn.ch>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <9a256949-56ee-4d10-949e-c5009852ca44@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MW4PR10MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: c965c0e6-88dc-4f4f-9e2a-08de6ca2634d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGlaR2ZWT0tQYkZROHljQ3JpaVZxRzVwUmM2d0J1eWhxb2w2N1g2cWlWN1ZN?=
 =?utf-8?B?V3BhVytDSUgzdWpUMDRLbks1N1QyL0lDVXFteGh0dzk1d1lMWC9ieE5aUTVs?=
 =?utf-8?B?Tk00aFE1bWFZQ1JQKzR3MjFxSUlIeHJ6eFRCa0RMSHFWOTBXc2h0REVZMjFm?=
 =?utf-8?B?VkYyKzVKWXMxa29rdVExdnhFdk4ybXlKM0pDUjQ3NTFwQTRpNlBEaVJTeGhN?=
 =?utf-8?B?WEhxZ0xSeVB5dHVHeWY2T0pCSDJHMHUzVDQrZVRGMlppczFFT1dGQytJcys5?=
 =?utf-8?B?eDQyKzZFRXQ1VDJIV3VicXhIZEFCd3JHWnVoWU1GUzhmN3pnamp5eEF2Ynlr?=
 =?utf-8?B?TU5INXpMTThnazN1anA5YzEzaUVXY29OSGZFSzJiOEM1OFErdmVVSUlBTDhS?=
 =?utf-8?B?SUp3VHBrZ1drK003R1VYSDBKUmpLdlJSRGxwbkxzbTJCZ01iQ3F1SEtFMG80?=
 =?utf-8?B?OUZYdXdZTUVPbzBMVVcrYzlscEJ0RlBud0FrWHhITWJWdjBPanNtTWJsRjdC?=
 =?utf-8?B?dUlvWkVVL0h3V052ZkdmOHd0L1p5dklKczU5M2VRbDNuWmhOYVF2d1JrNWU2?=
 =?utf-8?B?NGc4WHhTelBaN3NxTys4TmVGdlZocjIxWXN0WEFXZUNqVUk0S3J4NXBHcWc5?=
 =?utf-8?B?RG1mVG1lTmkrbmNSR1ZhamJiS200SUtnYU8vbmFYVVFUOGszWjVBeHE3NUlO?=
 =?utf-8?B?MGwvd094WE5GQTRYOTVvajJVYkhrMWRKL0ozZkh2dmVXOTNFRzZZL1cxcG14?=
 =?utf-8?B?SkdDeWtkQUIwK2V4ZnhvTjVlS1N2U3R4YyszQmJDMk1CeHRlZktTR0ZhKytr?=
 =?utf-8?B?VnMvbzB0QXVXSWlGdVpXMTdsTlRQVlpVQkRRcXZYdmxjS3dUQ28waDgzQ2RB?=
 =?utf-8?B?eE50dHdIcnRscHhtbExYMFIvQ1FnY3ZFMzVoenI0ME1hWi9VM3gvMm5DSElv?=
 =?utf-8?B?Z0V6RnJ0a1NGVmhobEpOYXJIekJKazYrTmlUN3h3NDNkc1hBMVg1VEFoSENX?=
 =?utf-8?B?VUx6cU01RG9zVFRET21HaFJrenBnaXRFdDN2VXJGd0I3Skp1bHBLU3JCWlpD?=
 =?utf-8?B?K09jOXlHYWkycjNoRUtQRGFhSmVOK0JHNjBXOGJzZUdncnBVblNPQ2ZiTW5D?=
 =?utf-8?B?VUw2SCtneDhwMGVVZUplQUlRWnpNRk16cXgvVHR2VUZjeGYyOVhRUlhXYk05?=
 =?utf-8?B?TU8vM1hPU3V5SzlSYzV0S3V3ZGZjdW05T0c3TWY5MjMvK1RIMU1yakZHNllL?=
 =?utf-8?B?bFRldlVjNUdUZ050UElEaVFQZVFzdlQxR0Z0VjBQYU01R3pYczBRelhqSVFB?=
 =?utf-8?B?N2VRclZKek4zbUZ4QXRtdWJaNHY0WUxiNC9VT0YzSlhJaDIxL0QzbG1zK0x1?=
 =?utf-8?B?VDhGZmFQKzFlZXdQY3oxc2hxREE4aXFBTDVBWnBFaW5WeTZmaG5GM3lDVDFR?=
 =?utf-8?B?dUszc2d1aTFjaCtFTlZlMjkvVFo1R3gyNmgrRkRZeWU2b05QREI4eEVva3lF?=
 =?utf-8?B?M3JtOWRwcWVBMDYxc3JVOGZmK3dsaHpvK2xEUGYyemM2VDdJc2xBemQwd1lr?=
 =?utf-8?B?b0tBa0xVUGQ5Z0lYMWplNVdlNVUvWFA1V1U5RldWV1BkTFNjU25lVkZIdER0?=
 =?utf-8?B?NFBLR3NoeUJQRmdkYjN5cTFodkpGdEg4YmExVm5xYmV5eWN1NjVEVTNpRXdI?=
 =?utf-8?B?NzcxZjRXTFY5bkcxakRCLzBCMXpBK3BJOHFFS1hxOEc2YjdhSTdOdG5VdVll?=
 =?utf-8?B?ZUdxWlF1QXVwWmRuRTZpSWxmUloySkRoeE4yclRRMlY3TkU5SU5lQitjQnd1?=
 =?utf-8?B?Zm9yZTlLQWZaTmdkbHBYcU1WbnF1MHB1cU1Ia1p4M0pwMkJGamRNb09qOC9Z?=
 =?utf-8?B?RitOQklMVUV1UytGbS9NTTlXVEV6SVhRK1lxQWtLNEUrWWQ0bHRQTHdRQXpv?=
 =?utf-8?B?aHZqVHN2Y2FsVUZsaGtaWGNUZGNQS25KUEliN2VVSG9wRStqUHN2TUMyTjkv?=
 =?utf-8?B?VGNzaXUvZ01Td0luRmlXUkNicWlLdldnNnkycy9nVC8zWXAzbFp1SytSRllX?=
 =?utf-8?B?eUoyaTltTWZGMU41YS9ybEZXcUR4VnFZcWtHTTRSRjY1S2pZRFJDMGdKbDZv?=
 =?utf-8?B?VTVqNHQzZEFpa1dtZWo4anE4SW9tdFI5YXc2Tk9wTVpUZVNCbEE1TG83YjFF?=
 =?utf-8?B?eGYzNFh0eXltekdSZm9IZ1hYWDI4QXJXdU42MjBqaG1HMDcyWTdzeWRPZ1ly?=
 =?utf-8?B?N3JUeFdQaCtaejBRWFZsNjQ5RWVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dFftAeLnny91PpPP50aknLFOtMOz4t/QXwjdBtbU2Jbx6ZawXYKFxuWCdutpaxQBqS1mW5bSRfhhiwu6sn//pHrlfUPESzR/4uyuh9dZ3D5iABzLvCVxG0JCyGDyIun9kPOFc2AGBRdDdtjK/28QIvG53yuIPFvJ0rkNaI5Gm+ObxAAL8weZyDiZX/vXfjAz3zRYbIFLpfg3oLOKVQ5IQ/gK/1IHUcuUFk++vavd8YPVVP4XzwGrjVZIdsI7H2iVOR94DtOT0dDW3kK2DThWNwxyd9YzCZukZ5BDj817+ciELht44zbsSUN0I71tLao3iGuXi3dsiRG5EMAORISihsYpwWsROfvutAtesHF/99wye2/TKOmGFFQ93Z5eF/8F+80jRMTw1BP22OE+XvPygjJGxBgV49R6SvkS8xBHeDZQFoQY8lkyum8AzRKDsRbV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 14:56:23.8768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c965c0e6-88dc-4f4f-9e2a-08de6ca2634d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6488
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258781-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,vger.kernel.org,ti.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:url,ti.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 781E913EE66
X-Rspamd-Action: no action

Hi Andrew,

On 2/12/2026 6:36 PM, Andrew Lunn wrote:
>>> What about when you change the configuration out of forced 100 Full?
>>> Shouldn't the configuration be returned to how the user wants
>>> auto-MDIX configured? Should you disable robust Auto-MDIX so that
>>> "unreliable Auto-MDIX" is used?
>>
>> This bit is only necessary if link partners are configured to operational
>> modes that not supported by normal Auto MDI/MDIX mode (when one of that link
>> partners are in Forced 100Base-TX), will fix it in v2.
> 
> Does this bit have any effect on normal Auto MDI/MDIX mode? Can this
> bit be set once during probe, rather than for a specific link mode?
> 
> Is there an errata for this behaviour/fix? If there is please
> reference the number/document etc.
> 

I checked with the PHY team and they pointed me to this section of the 
DP83867 datasheet[1]: 7.6.25 Configuration Register 3 (CFG3) and said 
something similar is needed for DP83869 as well. There are a lot of 
similar corner cases which they haven't tested and once done, more 
details w.r.t to the possible errata will be published in the next 
datasheet revision (aimed in the next quarter). I guess it makes more 
sense to post this fix later with the published errata.

[1]: https://www.ti.com/lit/ds/symlink/dp83867ir.pdf

> Since this is a fix, please add a Fixes: tag.
> 
>      Andrew

-- 
Thanks,
Meghana Malladi


