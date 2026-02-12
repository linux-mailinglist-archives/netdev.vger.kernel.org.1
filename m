Return-Path: <netdev+bounces-258411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NSFvG39xjWn42gAAu9opvQ
	(envelope-from <netdev+bounces-258411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 07:21:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8152112A8FB
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 07:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBEAF307DD0F
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 06:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7081F5834;
	Thu, 12 Feb 2026 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FO1dVoQG"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE361A275;
	Thu, 12 Feb 2026 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877308; cv=fail; b=gnApytCx7zoUjf8h9eNK4lx2oqxgKvUJ9rco1e7v2GbGMmyP1vBQOYX8AinciUuHb1pfvLsTRr2eLh5fUC5Jbl+0ogMyUsmEcxLAQeHY5PF5sBaWng4bfKr0kK9vHhTI2VnCgY6X3Sq/J33UdmAu/hEAIa8B0Cxx3MaUMvnZO+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877308; c=relaxed/simple;
	bh=mFWk7DiZLp+Z8Rc2UoG0zs7k0xcNigI1gXUlRJ12Ka4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rS4HzGLbxgu0bDwuQvVOyuXZjM9GUtDtKCZ44ipjC3+pOSb+/5Isn0fXQf6pOj3+ubeLC+UpHL/64OMRPRrW6guwrpK+VFq13UmIKSzTE+lZl/VDEi8849fZEPAdUE1dEXLEy//2HoBEEdl0XplqfcD/A7/i5t3yQyZyor+qCtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FO1dVoQG; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpfgCcYm8gRWHYb2yZPNNiSLcKEveb8B4tgn1xagDf1NFNDpXZAhD2XCNJ1zluJch3tUy/i1SKJid91uRKuq1fyF/TE4J/PDH/i7CtLPPzk6sNP76pFf7AAmaY8dPEHvIoJL6FHiJDuZXJQkzBRfU/RJLYt2rTrgNO8Dv4vzN3QR52JLHNJNg9T84q7tN05oh8qEBM/5dj18PC72ePyQL9wO7NsP4Miht9rOhixAU4mm3I4gTZoEaY/CoIX1o4yvzBFIVPwK51yHDuJ5xrL06NVGR0NMbL7Vr97hpqE/9LdYkv/dmFIqJTJnnZ7Z59IhnDnbiD5u/kwfylt6nvqvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olx38CU4DOMC9OvmoWnxZ3XC0I6dG+p1Q5qD1LxHdhI=;
 b=IugIyEafoe4Y5j84LZSjISs3TCVbt4cXdP2ZhgZyxcWTPFoaXWldHk/5n3Xa7uUwZXT7/zdF96z4FMnNeU+tIzug5f1Wi+auONgZa4tlg4ahmpVa/FayVyMU/f5WV+Km3JmBhKYh5l83HjCMScj8bRxoXKxX4qTluB/7FzRHFImNUp4g4oTmYt8qJdDHCMCKtx0cHJ7iVd7WdCaLVScvBjg/Ngke7y9BsRyj2lo7asKVW0UuqV+HNPOq9iNJxPp6Ht8ljIJwxiPBMGQaGdDZAaKaXZAcbYxgpBUPaCSr7rB4zCfaGzE+FrP72SRThNFxhEPsAECxV+pcmQGtg4drkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olx38CU4DOMC9OvmoWnxZ3XC0I6dG+p1Q5qD1LxHdhI=;
 b=FO1dVoQGCcXEcIjbrkVW2cALQQ0Ix5igBqFvIj3jAevE6HRQCgfVHr/8UEkeeTb9Kefw5P8bDfrfTGBcecbu0U4AzFZPt/lurS4p1tNvKPRHFrpa4w7KqpwyAZ0jTBgGoNBy0dU4dNYujVTNVW0a0tV66l43nj1RGugLiMSe12Q=
Received: from BY3PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:39b::22)
 by MW5PR10MB5849.namprd10.prod.outlook.com (2603:10b6:303:191::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 06:21:42 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::4) by BY3PR05CA0047.outlook.office365.com
 (2603:10b6:a03:39b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 06:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 06:21:42 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 00:21:41 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 00:21:41 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 00:21:41 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61C6LbIw3003734;
	Thu, 12 Feb 2026 00:21:38 -0600
Message-ID: <a498b310-29f1-4775-aa65-fda027a3124b@ti.com>
Date: Thu, 12 Feb 2026 11:51:37 +0530
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
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <0a9d0ec8-09c4-4029-8449-8c8f08c6dca0@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MW5PR10MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be35a5c-243b-42de-3382-08de69fefd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3E3K3d4VmdZTitWK2ZvUHhBbVBtQlBhSXR6Q29WMENaREpyQkpvZ3RHRkx0?=
 =?utf-8?B?dlFKejVrUm9DQUNpMUZUTGJUb1MzaE4zRDZURFhxWGVJYWRiOTgwbXdlVmVv?=
 =?utf-8?B?dWdCWkVqeVFRNGdJT1pYMnZmM0FvcVlqRVM5M3h5SEVyYmo3ZmFOOE91R01z?=
 =?utf-8?B?QjhxUlZVOUNaa2liMzUyUUFoN3VaenJhODExUXBKV01HWVFpRTNMeU02UFFQ?=
 =?utf-8?B?TjEzSHJ0SENNYnBnNGtEd0FlZktlQXhmV0RmMUY1dEsxY1EvbE5ncmVBeGxw?=
 =?utf-8?B?cDdYZ3pMcnRPVnFqSk0xVVRzN2pBYzJEbExPMUJQbGZ6NVUrdEhRakRRcDRw?=
 =?utf-8?B?eGNvNTgybGR2Q3hOc2FEMjdaSFBxZDVSZmtkbEp2QlZOaStMSVpySnJHZXFC?=
 =?utf-8?B?TWE3Q1hIcG5BY0hSMnNBUVgvZU1iZ0NWcUlnNHVCVm9aelVROXhLQ3ZLa002?=
 =?utf-8?B?VVdtSThmNit1cFd2cTMvZXM5ZEhaTEE1SU9tK0NieEZNTDhjOWlFT2tRZGsw?=
 =?utf-8?B?dGZBaGNHSXdpaVM3c2NZV3FMNWdpNFZtalpaeGJtUEhiTk1EOENVQVlHM2hl?=
 =?utf-8?B?bUxLN051RU5ySDh0M2dSUmVYT2d0ZGpqYnE5VkswSmVFaXlqVXFVZjZmdFkz?=
 =?utf-8?B?SnhxRS9teFh6emRrdGNDODlhdWY0Wm1SVHYzM2lIT3hpUUJjbmhjcTk0bkFD?=
 =?utf-8?B?bHNIcG0wa1Y4ZzFBY3hGNXJTRkRNckhiK2YvRTZ4YXNCekhPbUlhY0lLOVVi?=
 =?utf-8?B?TWpNNUxOZk5HcnFoZWhFVFBId0JlMS9Tb1FJaW04SU8yTDlHVmFzRTlsN0dx?=
 =?utf-8?B?Z2N1ZTlFcW5qVDJYelp3S29WTkRoQXhQUDBMTXJYK0tZeGcvRk55bG5RS0dv?=
 =?utf-8?B?MXUwSlRpaDhVSVY1Z3l3S0FTSStXU29DK2xwbWlOWnI3VnpOa1lvM04yYVlu?=
 =?utf-8?B?MFFyZ29PNTJjemdqdGc4dHgwZGN5TldtclFGa0U4SFJpRFF2Y1gyMGprSDFV?=
 =?utf-8?B?Q21WelFkWEMydVp4RkFIdjExUU1HWDJRWmwwRS9uY1ZFTkJCcUd5SGJ0cWVY?=
 =?utf-8?B?ZStzVUhkNjZSTmIycnpaYWtEZmJyaHJxUjNCbW5adThPQzkyVUNja0Q5VnRn?=
 =?utf-8?B?VnU4ZEQzb2w1V1U2RVJDb0JiRlZTUjl0V3ZGTUxjNDBRZ2dBTTBMSUVQSFNW?=
 =?utf-8?B?cjlaM3RpbS9vaTVyWnlLT0doaHBPL2tnTFlNcGxXOTNudnpYN3Vrb2plZDZt?=
 =?utf-8?B?K0w4UFFjdUtWZ1VKWnpyS2RpQW5YNEd5MGs1SStROHpzWlRpL0VzMHFoRkli?=
 =?utf-8?B?empQUndlei84MmR4WENBVE5OVXVaZkRYcVd2N29aaGdlbUFZTUFNS1dBSmd4?=
 =?utf-8?B?Vkxsb21wMUhabVJick5EdUtLOFBqWW41NFdnQWsvVXRZR3c2OW1ZSEZzZnlw?=
 =?utf-8?B?TjhzcUtCY1pPTEtDaGRMUjBXOWZVWldFOGpCNy9BUnliamZyeUpxZVUxQnEz?=
 =?utf-8?B?YVJHdlNuSFVkcjhVZDJqbDRtU0l6ZEt3Z3hKQUtnWXlkMG1zTFVvT0FsVGE4?=
 =?utf-8?B?aFMxR1F0N1BjQUhSYkJvTkhmZG45RXdDbUxZOFpmelRNemI1VEVFais1cWRB?=
 =?utf-8?B?eFluWTN0UitDdE1WSjlEaS9LSzdKYituVmxsR0w4V1Z3Q1dvMm9MM0FTQUND?=
 =?utf-8?B?WDk5WHg3S0tCMDZ6QjFyRGxObjRvNkV0RU9Fa1VDS0VSNmRJRW5GVU5HMHJv?=
 =?utf-8?B?ZnVqZ2RrN3JQY1NEcjlsbmlVbnV6bmxSRlpDYnRmWXlxZGZRaktMNHV4VVVn?=
 =?utf-8?B?alY4RmwwcXlpeGZod1kxbkt3ZlZHMFZFTVJrcmR4M29GSlJXSGYvNWd2ZUp4?=
 =?utf-8?B?Szk3dXB2UVRrcG54RkN0R0krRlRKYnptK3BiSlZ1RE9UMDlYU0ZZTnJyTk5N?=
 =?utf-8?B?ekx3NVZLUXJSK05TSWxUV2VhczhVYkp3R2ZxY0NXK0kzazYxTlJwMFJKK2x3?=
 =?utf-8?B?SnNlakJjRElDZGFsRVFiWDhoSS83VXZyNlZWcHltc2UvVXVmdXFOM3kxaXFH?=
 =?utf-8?B?UDZSVG8zQkZBNWlWdVg2RCtKa29EMUJ4blZSZmM0R2pZTDk1ZHpvQXRSazha?=
 =?utf-8?B?T3dqb2E0ekxGNkNYNjFjNHQ3Wmdsdzdnci9wa3pkbGxBY0E1N3N0cWh6aDNn?=
 =?utf-8?B?ZEl2bHhjdGlucjBiLzdmM0tmSi9GOVduWWhWWWdOSGpUaVNIei9NVnJreFAv?=
 =?utf-8?B?MUVRK1RoNWduNDgyQ0hXZWpWaUxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bVvYiz7NTl5Kj5aSfbgBEr59tflmTXD2x1yM/jmWF+sjn+V0V34tugYa4vWeif5meuEjdws0Q7EVo2OaLU1MGFb1eoMJ0JrBSUrf3IemapBWfpTsg8IKQ6dij4PqXPgn7egcoZq0O7DCoeIsIsdtLaOTWiOtop2mEQI2jPeKoGxcHdV6xsYkqLxRJbx+VIuAEEnPNANm/tUB+X3xwkIvMrla9e9Ee7Qf65NUiTe/hG/p47TRKltZ/8AynH13D4geHvLaMMJ44TTmHsH2NO73wtF0iL5sUDnpEKQpFmXgoUQ1HQtV0Wq42HvJp2g81KKWRPaYgSaSTs2t0nCQ/szQciXI+pCDSwMBbaCy/fAd6281GYy6TFlATcXzDK3s3kG/LTQMJZIpXzqAO/NdlBIs6lyXFazHrybkexiwbhdxlOEdDSRUmZW7DlwBCS9djY+v
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 06:21:42.2910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be35a5c-243b-42de-3382-08de69fefd3b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5849
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258411-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,vger.kernel.org,ti.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 8152112A8FB
X-Rspamd-Action: no action

Hi Andrew,

On 2/11/26 19:42, Andrew Lunn wrote:
> On Wed, Feb 11, 2026 at 06:40:32PM +0530, Meghana Malladi wrote:
>> When using DP83869 in force 100Base-Tx mode, the PHY is required
>> to have robust Auto-MDIX feature enabled from register 1Eh.
>> Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.
> 
> What are the results of not enabling this? How would somebody know
> they need this patch?

This is the fix for 100M full duplex when auto-neg gets disabled, it 
fails to have a link up and this patch fixes it. I will add more 
description to the commit message.

> 
> Is this a bug fix? Should this be back ported to stable?
> 
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
> 
> So forced 100Mbs half duplex does not require robust robust Auto-MDIX?

I haven't tested for half duplex as the issue was raised for full 
duplex. But based on the TRM seems like it is independent of the 
duplexity. Let me locally confirm this and fix it accordingly in v2.

> 
> What about when you change the configuration out of forced 100 Full?
> Shouldn't the configuration be returned to how the user wants
> auto-MDIX configured? Should you disable robust Auto-MDIX so that
> "unreliable Auto-MDIX" is used?

This bit is only necessary if link partners are configured to 
operational modes that not supported by normal Auto MDI/MDIX mode (when 
one of that link partners are in Forced 100Base-TX), will fix it in v2.

> 
> 	    Andrew
> 


