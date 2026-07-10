Return-Path: <netdev+bounces-306587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lg9ZF/oAUWpC9wIAu9opvQ
	(envelope-from <netdev+bounces-306587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:26:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F3473BB7F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:26:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=r+3ouwBM;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306587-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306587-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 694513055E94
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F46345CD0;
	Fri, 10 Jul 2026 14:18:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297B3446C7;
	Fri, 10 Jul 2026 14:18:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693122; cv=fail; b=cMAeviUeuxo9e9OlVb7shcY+UPTxWDrIHGNVByCVJmYJPj+MfAiX+cgXwsYpm/so0ON4KUMD407/GT8R/cOT5fPZAWDRADyKzwTTNxnQoeQQnWil5ka+NDvPgrWUI9R5vRq76yEQKVNtD3AMqi01VXvKrJjv/1JHLioFm1vtHLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693122; c=relaxed/simple;
	bh=yIiyBc+5v6OzzqRq4vbdIqFeVcZDEM/wZtTmuS7zC6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LK+Zzm6hs7dKI5yI0141b9VUR5kbmfSuB17RrPyapbtvZ4Q1BT7kpIb/HNhiModQhjftT6Ak8Tm9fpIFLDgJqZhlE4A47DRxEuHNrikVXoMP6C4ID6CbT5EU1FPvzyne0E3nPg4vklWls/7yM1qB9QkxPixI8EyHBJGLu0H3Tvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+3ouwBM; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBM62ayz/2OpDovSfl28ICHojPvoys2aTqnA7xhPuq8Fvz8NG9WPKSiCpTQFjTKd1IZUlU7G0AN1KTgPagfAyXtbw5B64tlyxpjZljb/AXMj8LgQ1E3qe2hmRfU2sECOizgYu021jvDgGPu0wyEJTsNdJDqlsEmDkoMASbqjvZgzA8utNjOSBGDobK0pKH7xrEWB0HlT4v3C+YsTDjf0419pRNXf7l3neTN6HiGUKxaF+o88Ny8QloM8vmV25bSDtbB7P4TMvHfUVbLdwtIHqrFGkU9FmwcKyuYygBsGKbo9yyG7agxfiJJIfpsn0oeyuNkb+Q2sIDHFPt0PpcHC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVy60BJvJiSu76jKKWhO1wmghR6+d3rmaMuwxtrnMzo=;
 b=kNYqFNIuk8W5ug/VYGmt+MCiII3YOBH7H16V3NIMTuGzuMpif41743yOwM5G6b6kIAOZ7vx44l737PD9fSNcCCxgDhxKDAWtt+ai8pJywr3c7w65Bs8SRVHfLiU+upSZkGTDUsnjpdRM8ZBRDv1s1au0gNDxxDXmqFWxumLPCwImyEpCFQZ7OzSH/nnQAoIHiS3xkv5O0rQXAdNLpJ/mO5KbB924nCNZF9GF7rZqavkLjOQAui2e3xOnOIDxYY/z9Wd59PM6xv+aDhkY1HYwaDs63bftKounvDm2NLrxjdJ5AiCk3pNoqMgHV+NQXasOTkRRWlT7zbEy9h2OdJ0I7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=bootlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVy60BJvJiSu76jKKWhO1wmghR6+d3rmaMuwxtrnMzo=;
 b=r+3ouwBMTWd9qmX6QmOnm9b6ileEVI+iQqh1k9z07U1hYS3XU8cmYg2uWrqPtMSULO/22jMmEbJKDsTDYXeSM9AT6WQ7M3TPyg2FpVrqXSCwgw+Q7sQlpvsbOQ/HGndLnCHr6B7OSEqzDH7kK9oiUvDJg/SeK7oo5PW0DB4x816jHE0HWF2VY4ZfRhttbruvqS+hdgk/2ruVKmPUYklY2N3rKC7xqzkzhKeC5FsvBQ6FM7sWlJkRlGDPm4xB/LkCEuIBvD+vd9TkCITNMioE2rKFM1Nxa2mg/MVAwS6s3f1zt86bAsgVU4Z8f4xWVHZGdoIETtWFaNsYC0xpc2r52Q==
Received: from CY8P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::18)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 14:18:33 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:46:cafe::4) by CY8P220CA0020.outlook.office365.com
 (2603:10b6:930:46::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 14:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 14:18:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 07:18:12 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 07:18:10 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Jacky Huang <jackyhuang@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel
 Golle <daniel@makrotopia.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Question: net: phy: realtek: RTL8211FS SGMII bridge mode support
Date: Fri, 10 Jul 2026 23:17:03 +0900
Message-ID: <20260710141707.3280954-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9d4bab68-6383-4b8d-a9d0-144b348e937c@bootlin.com>
References: <20260709035244.3008436-1-jackyhuang@nvidia.com> <9d4bab68-6383-4b8d-a9d0-144b348e937c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: cd53ae87-fda0-4e2c-a97c-08dede8e1e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JSKQkAx7/OZTGTDEm9x2LXGiWpnCKnuy1UPJbhafLQr9lJ2r7JOA+HiPuZjx4GNEaHva3YIcuwXouNnc4vxduvuac+KQ3c0aqh1Y+dMSyDrkk/QqnTnxkSEstKLB46NY6Q8ADQ4DKBf8iy3C6F2Y1hCl3R1h8sI7vG7fdYDipedRh/VDEz1wTOjZ774fhuM2osNbdaDY4k3qCFrTBPvyhiG0O9zzbTAmBLj2HOm1VkW0fOLT4faSRxcJZcsOguSSYPvfgvmGqmkNFtdF+DhnT+6G1D5sm0Swcks/2wkIYlbJMWeJh0BcC2mddQRjyP8oQatoPTK0bKpEGFiS+WPWTKHaL6bTEhTRq31pEbAv8nmUwCJQCQwtI7un1Dva3kxtejtEJwIVy+MS8naIxrWEP1JX0VrOOKT08k5nDAvauuRLquWFKHaGjbAcaZt82YiFmrOcwmBQENZ5LyW9ZcuuDmDHvBdA/IBb7ScbtrB3WnE24ZplOp+GhxzX9E4q1le6+v5aSos506ZaEp9hE4qg8C/8QAkrRi3ko5zoSoD23TxcZ+PExOal/auVRO2RfUFVc4Sj7vf3TWf/jY7v5d5olIcE9da0Xe2gSYyzyTBt0auj8EChyTtvoiGBm0dDjjpzCh8HLLVSGE3Tzv+jrcKhal4+YVO1bapwLnsEOM84ZPjVnApN30jh3Cas69i6yCRBRxLTzK/2x99zXdcv4Dt1RA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0i2BqcT3KJGSBQxq6MS5PXLnBa7uDAC2Dieh8aKRYCANrmo4jaxedyxKmFoMQ4O/bp5iXLchpC248ezK1dBSxpm7chXZsjeI2nd1CL7IZKJLQHUMLpoJzSl//gtqb/CjVYEiX8vJK4UngzNK18VHe7BAS6LZvNUvV05NEVVvK0+7XESGm9OiCwZncUN8+JB16yrfwNIqVWZ2kNn+hTTv6k8icV1oiQeehBFadWdTgXnovL+EQbI2W+VXo6L4qLj/AJTx4FmGuDFHFiMBlDV2UIccWTb/UDFbrhc/mt1MioQJ6dFQ2s1nwTAICPoJq19bFJyszI9v0Fc9syHoltezqTp0pGR0k9wdnR6IOaqxrUAHOzDHe+DD9bLilFJdrq4NhFMwWXh20mCKOdf1NuduXhdsuJFA4acx95qxVpK+UWh359ZfR5TCr8tECsubzzzl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:18:30.5782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd53ae87-fda0-4e2c-a97c-08dede8e1e3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306587-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nvidia.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,nxp.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:jackyhuang@nvidia.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jackyhuang@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackyhuang@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4F3473BB7F

Hi Maxime,

Thanks for the feedback! I had not considered the SFP or additional PHY case
before.

The hardware we plan to support has the SGMII side permanently connected to
an Ethernet switch.

    MAC - RGMII - RTL8211FS - SGMII - Ethernet switch

The switch is initialized from a configuration EEPROM. There is no SFP or
separate PHY on the SGMII link.

I will take another look at how the SGMII-side status and in-band aneg should
be handled.

In addition, after reviewing the board-level strap design, I found that the
intended mode may not always be selected reliably, so I still need to consider
a strap-override flow.

Thanks again,
Jacky

