Return-Path: <netdev+bounces-282267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM3PFe+y8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:27:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D20CF490711
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96C8E300AC13
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879437BE7A;
	Wed, 29 Apr 2026 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="QlB0m0ZO"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3540DFA4;
	Wed, 29 Apr 2026 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447657; cv=fail; b=HThEhtffp/e9dIbJtBxDcp0/6oIB564Eg7Eonm7Bm33q29b8Ld+PCv04K+e2WXZHGXQppiyZqvbkSi2rch9O1/OYKZQFoenkPrjehDzeAEAOSbxBVc3ySLKPYjfHpkvt469BoroxKkk9C8Sa0sbjceoxfZCj/yU7ljRQrzYrsPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447657; c=relaxed/simple;
	bh=knrz86a4MslU84WPnwFYkpQ3OOw2HWwMATY4kj26vHA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CY8ZTRlC/EATeOIQU/gcOLMWm0LNOTTihUFQX4qC2x6phBFIESDtuFF+GBWkSFbn2n1sGN84sErLqA9E67VfWFJSQCmNus5U8c8f6MZhZ2KreuArxdqXQvbC6dgp5tA+tv6QyoFUkkIls20KO3vnwiRenb9McGqQ2uASN1kmUaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=QlB0m0ZO; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOBKvUkTgAC9+PA3KH0xoJZFAGp29jDnhpd1Dk4Ek+DeTTgWsj0D5iYMqcoN2K96M5t7PuSWez9fOb+nIgS2GRIuBwj2CZNThy4GMyRClvmZsELfLfJqVPIJ/FoHm+IENegQov9JB/7gbbNQQdTKGI3Ss6nJ5B+u0CnpPr07ucKNixVH6ELUwWjKugtf6VK/Kk4Ybo+zG+QWj+keEw3xDP+7mLIphGrmPP/9itoNYtffnd/e0CIRVEXRX6LwYG2G19rWCfd+NTJeIdjbpOQxz/mCsCWukAX7a/Gkb9oTVZh5h1OZ/OvzV1mblfpAANtBCVN9bTV/pE3RN66SJeSdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93ygCTUQMUpiydXJT0/eBMFbDmF2ExDQoYN4UoO9chM=;
 b=j+w4Lu6I2NrpG3j/OEyHkKOf7uuRRbbwObqcXTrvfm5U8+F0sRt1WUtRfUMkvK0CtUt6HJEx/WdOW757D5ziKHGYC4R4odB6Gqf9XQmClxalkVGp5Y5EO/v0PKxzaLbB//wTvQlcr/Y0nwR29Scwh4lzhsVjb+rKWN12v+vCiJoQT7OHkxOBmvmYPgVuHG0H2zFo9r/fJV7zQgPqn8JVB0PFXtjCnEkE+E3h/nFVxSB0emvRLZogoBRvsBrqac/APCxYm8IvqFrYastjiGvFI8v+vqJc2tcfhYasFpav5yK8ZMq5R/8djV/tgV/N2JMnXzj7l4P0qE5pC+t/y5sqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93ygCTUQMUpiydXJT0/eBMFbDmF2ExDQoYN4UoO9chM=;
 b=QlB0m0ZO5gr+0IvZdr1LhRTSdD7T7v3kcG0jBrYVtyWtsb9++UOIdih5i+DEk3M3IhV7jKsdX4AJoJF1DTfzTMgSNFywKdZvMK6WwbxrYtLOm8rr2idIA32awU0p9dbsgyBYoVqxMwavBlwjTmHc6cmiV4ERRhKdg95/QFlalOwE6S8mvlUmJo+thxQysvQz9OYtYtsNhoKHY4qNVW+ATxPFZcRTvNI13FEDUtKK/HGIwUugf54JIRr+t87PqCtYEK9VNTxvHVs6HiPGAHLuLpnDv3ncCszgi+7Xcfl25qLAixhr7K/rKxxfas8I8bKMFXVAtQXG9G1+ptlPdXErmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MW5PR03MB6957.namprd03.prod.outlook.com (2603:10b6:303:1a8::14)
 by SJ0PR03MB6455.namprd03.prod.outlook.com (2603:10b6:a03:38d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 07:27:31 +0000
Received: from MW5PR03MB6957.namprd03.prod.outlook.com
 ([fe80::9f7e:ded2:c0ff:f1ee]) by MW5PR03MB6957.namprd03.prod.outlook.com
 ([fe80::9f7e:ded2:c0ff:f1ee%4]) with mapi id 15.20.9846.028; Wed, 29 Apr 2026
 07:27:30 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Add support for TX/RX channel interrupt
Date: Wed, 29 Apr 2026 00:27:28 -0700
Message-ID: <20260429072728.13638-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::17) To MW5PR03MB6957.namprd03.prod.outlook.com
 (2603:10b6:303:1a8::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR03MB6957:EE_|SJ0PR03MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cd4eec-2d34-4ed0-770e-08dea5c0c580
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	xjDVvWKu4ff4/ZqnCkrVUQZSzwzh4V0+Lqn2xLmXSERj0/FE9Swh5VfWwROSs5/Rk1pi1/zCs3yXoEbL2+J2hye98mmG0dLpgXiNEk6cP1Y+NNU20jxXyWa/YoFmyzuuhmVoy4lgZ1uWs7EV+EsgyyfjbQ6vcHzy+EEIr790c59ah0XvyMAvICPR+4k+woR3s23f7H/GbGRbi3WqYuGXURtbTZFGcJCICi9fg44p8klInwx35uCjl7/vEm+9FIrD0+IjiVh6P7OBjYpWQzol+BzDmwH6cUK0CGc1TeieWcZKCP5QMvG23z/F7kV/7BVOt0ky+UhDoEl1yMLA2EmppQkRiYq6KIwJ75VtOl9Jxt1zYjUDP7eNEMwcu3mXLbWmO+xZ2PNlvKQKGfRPmUcmk4zW8jL3Aqo7wgf3VintoXI23Tw1bWl/yQBjZG2pP57zlEEL/xPNA7e8yvB1H91YoC6lfd8eyUhXxiS4RxJojhR9owfJJs9iEeze6kEm9k97HG8uOqTQGRyUR+4EAYDCcBjAjbJSknKMhCSGEX1xjmKUrYq8RUkazcyisHGuiGGPkONhz6QynhvEJGKh8mXtcjiGWGkb1FXc9+gMMPdlCr1qJXcX4JCqDxjK9/+L6dOIoci+r507BIGGjqhjBy+6j7mxTFS8PuzXGddlGBZy23kXK9p6BSf0bbivfQO2nZaQ9Cx5kSuhvcuGDf58sz7uN0Ptz/iucFHKVeb4AaHhWZ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR03MB6957.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cz31wOa+ouiCHpK1Ml/RxABQjysGdx9hzO5hvcZfo8Hln3Wk7CUYJsbQf8Vu?=
 =?us-ascii?Q?Ap5SjbIv9M+1XwhDYgED1VO1bzAzui0Q3puwxgLRJv90mdbwBmXC1NWGCD1y?=
 =?us-ascii?Q?TBXeaooGK2pGbAIit3tJ1uq3RQMzpwov7FplgBIqcVK6sNSfZNCJpwqCELw9?=
 =?us-ascii?Q?ZsskIz7yhmAOfEZV2xR2a14RCAOtsTzxFBHyTkvy3097GJ8YsTAyt+UPrKbG?=
 =?us-ascii?Q?Yk5ERcBGEOFOdvCqRJ1a5LXt7mjActroB2BqB8rNtbZvycDDBjKqNA2EiJ9Z?=
 =?us-ascii?Q?67XwghxI5RAI6QKlYW3A8d0uzHRNb0Rytr26d843f8z8W8txS1AO7yHUC02g?=
 =?us-ascii?Q?Ojt5B5VNRqRXOyy3rM4vm0vxlE3xrkzoMcfAQWbwaulINduUUjAA5GT4VbbM?=
 =?us-ascii?Q?THEHm5M03JZTaCNxaad2kRLTk+20wnj1SM1PveojCrC6txFBvW0IO0nro2fT?=
 =?us-ascii?Q?CymT3QYaKfR4BPMslrzMTEGNYiM1cXRyHcrzICcz/GFB3d9zxpmSrRGaCFMN?=
 =?us-ascii?Q?Oj8DPnOjjiiqb9esYa3n07mgxD8GQBSagN/PcjKxVnhlaVq2uPI9yGiU14Fj?=
 =?us-ascii?Q?GinJPSEpO89UAXTqI2adnAehz8zCxefO66sfbnk7aLYp0j985dy24kRwLfDv?=
 =?us-ascii?Q?jCM4e+H4/puDexvVpfkRBFiEaLHWHDAWG5TKvUVkMqDylM8FcVTbk7otGlEF?=
 =?us-ascii?Q?HXtbv99epU1AegHig7sjPPI8XrglATzpZs6Yva1A3eKk9NGtb8glyXdEIDtU?=
 =?us-ascii?Q?j6QIDLpNFxzSnHsiwLaYTEVBQcnz7fo6yrczatncPkFULF8ZiUoOtt5F7v/5?=
 =?us-ascii?Q?dejLcGTVaKk4ReptVew9SyfPUQ6VCxHrUnW1GGu9wM3GbJEzyWM3M/HeQQ+z?=
 =?us-ascii?Q?TPTlFV6FcQyVMGr8yrods410tVhMw98RCkyAfRAjAJKY7JyHC/ilwspy7bxW?=
 =?us-ascii?Q?ebRJJrbf8p9pnkA38VBnOHKYU0ukHeZM5xXFs+ebSyzmJguLfypfH5hcE+RA?=
 =?us-ascii?Q?EpcQ9tv337KDN305Fi9kbBxM+XKNOflfixdPSssK0zXb+z2cVFXBVNfSJvM4?=
 =?us-ascii?Q?1xp/e4tfpDxt7/N/ipURwSMBciXD5FMw/yZ2rqlSmKJMGe+tVNLw6Oeo5fy+?=
 =?us-ascii?Q?EUDQJf141WKNPQ8RW3yLKZ6Q9UM07Xq5bbBxn232dgAJajGlC+wHvpVQIYZz?=
 =?us-ascii?Q?69JtYqHN86HS5rFAEAhFvWaihQNwCNSzhQGI/9mTRJCyb5lmr5eNw9tl9Nfa?=
 =?us-ascii?Q?6jsxDYGdPfsjUMuEKDrr3nt6lU4X1M5jfqZFJkEM2xAVE/EkqnLbNyuhVLTG?=
 =?us-ascii?Q?Z/2zR8y26u57PV3JVSTRYsRtVkXu3hJIUB8+6eCWcq1MSppB4s6beKFL2ebN?=
 =?us-ascii?Q?ayBHk84aigDto8hNAH2o3YqKiCJ8CMdKhsNnb7yIxpGc8NvlkQsJkG8diU/0?=
 =?us-ascii?Q?77JwJDoutr0q1t76zFDndxr7eVK4Coe/P010xTVSNPPQRtsCRyhytdphk0KX?=
 =?us-ascii?Q?XIIGn7jsNOXzLwj6wdHB6A+4+EzxBN4Uk17brtDVXJAZhJKgkJq8mDF8cQHu?=
 =?us-ascii?Q?Thqw0qTZZ39ENLOTAnKR8uSqmBWxB126OFJmInzOtrgO4eDoi+5qs0DCvqdc?=
 =?us-ascii?Q?34NAOwS8o9yWDw2pf0hN82fED7cCyzis+WvU7YOozLiORQvf9S2U19YwB3Ts?=
 =?us-ascii?Q?N//KNrEp9fmIB8v6pJUzwkyBBWFI3AExMNQUYjLEsjcvRq2q2X/CLU2LXrUN?=
 =?us-ascii?Q?QuVSs5h7dzhTooWl7PnBxbxHOhu7i2v0kXzQdyY6XbcW8TG2pDpy/rm9UJoe?=
X-MS-Exchange-AntiSpam-MessageData-1: //ZPKQeHVIYJEg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cd4eec-2d34-4ed0-770e-08dea5c0c580
X-MS-Exchange-CrossTenant-AuthSource: MW5PR03MB6957.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:27:30.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNzYE8KHgs/UdSMX7TkQpReuqYjeSMsLX4vfFHX5w56xy7rG1vKn0zDE0grXfqjb+tiR0uK4XMGHsOGrsZQ79nqs7wD3+jQBdQMPzPF8vQqZCxqaoHT9Js9jqtRi9QdxHkjU9jC4Zk4uzEgeO7TU7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6455
X-Rspamd-Queue-Id: D20CF490711
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282267-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,altera.com:email,altera.com:dkim,altera.com:mid]

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Enable TX/RX channel interrupt registration for MAC that interrupts CPU
through shared peripheral interrupt (SPI).

Per-channel interrupts and interrupt-names are registered as follows,
e.g. 4 TX and 4 RX channels:
interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
interrupt-names = "dma_tx0",
                  "dma_tx1",
                  "dma_tx2",
                  "dma_tx3",
                  "dma_rx0",
                  "dma_rx1",
                  "dma_rx2",
                  "dma_rx3";

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5cae2aa72906..9a5e20ab25dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -732,6 +732,9 @@ static int stmmac_pltfr_get_irq_array(struct platform_device *pdev,
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
+	char irq_name[9];
+	int i;
+	int irq;
 	int ret;
 
 	memset(stmmac_res, 0, sizeof(*stmmac_res));
@@ -767,6 +770,30 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ sfty not found\n");
 	}
 
+	/* For RX Channel */
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		else if (irq < 0)
+			break;
+
+		stmmac_res->rx_irq[i] = irq;
+	}
+
+	/* For TX Channel */
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "dma_tx%i", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		else if (irq < 0)
+			break;
+
+		stmmac_res->tx_irq[i] = irq;
+	}
+
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	if (IS_ERR(stmmac_res->addr))
-- 
2.43.7


