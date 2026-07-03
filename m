Return-Path: <netdev+bounces-304451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SjjCOlh2R2p6YgAAu9opvQ
	(envelope-from <netdev+bounces-304451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:44:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CECA7003A5
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:44:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=selector1 header.b=RzsegjRm;
	dkim=pass header.d=arm.com header.s=selector1 header.b=RzsegjRm;
	dmarc=pass (policy=none) header.from=arm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304451-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304451-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=3")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F6493075414
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4333F5A8;
	Fri,  3 Jul 2026 08:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13E314B76;
	Fri,  3 Jul 2026 08:23:05 +0000 (UTC)
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066988; cv=fail; b=TxFtQS+pCA9n2Y4TF0nI28UdzmAf/ekrywpw+P2ilTsX4571uxe7n4hhvHHtBRpLt5bRfWz2pfamlzfeELDYI6V3xbMQJFUCzT6WwDC0ZHG6V4yIW0TaHZ+dkpUWUteVWRedqxCLelLAY7xbhHcnKbuRyXLjbxX61BERT1wfQk0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066988; c=relaxed/simple;
	bh=MtjsGF+QkZhVA6MaXTHaQZFIyNA7pXkhEVqGBEysjnE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fkF6G/DCagqZmUYaRFAB81wKYeAENOAAvwgNE7RW1GIrcMaNAvQhgzuX3viMJgJjSN+BVnmrmt/pJKmMaOFGaiiDrrCU1d5J31hNiDhbSKX4y7MOdfEf8RcSXaxim+ImgbxD6pC1TbClgBhIQkUoYOnoCQpiA336ZgMbdcr0K4M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RzsegjRm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RzsegjRm; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tEAKPAEV3UIDdTI5xH50yy0je1J8pMPxFGWHYpZ/34/WL29IZn5RP6fJtjA3rcquorI0fY6qhobzh0iUvbA+n+uqYDNqVpmIr3GoxlNBaZ+7FBbG1Q9Lr+Vs3CfY+mB2rl6PIfAH/ag3VHeJ282zR6oaJyf61TDVGDyW/SvTxp2sPTzfcpfJ7x605OR3A4pNdW7UsRXIyjmPI/clADW9Dq7iw0JoPGovkSxjm3Ai0riMaaRElomSETu9wy53dLL8369e0EcDlz6R2ac7HPWzffVFFF2Xw5ka+5wfFpvueNZ463ekc5peKCAy2hpW/eVK+C940Hb1gnhT90j6Px9prw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VYDx82MjhooGw3leG9UBLZxvh7aZPV+/vgDmEeJnj4=;
 b=FUNNyMjyx83wqtEymNZ20VH0lbX4Wr9x1p+e/BoNilJNLV8JwrxdTtiTf11Tgoql0ux24xUo2iif8RvuYbwWQr0rRih8eSfo9NUUnTfwNL4iUdzWzPKMCxVzjedU/P/HEap0FWv4Vla5/IU1HVjJpxWi4ZLqLIuhcP5JjTJfx6R4Rz5QsNMh26AJFvZK8h3c9XhklVbuCG7lmSTLDi12ohOU9yyyF7bbzQDZv4DzA3QJwWZyLmP31CKMiG5P326MXy2DCXf7daIzJPz0ElPL5aBEXrrRpfpTtXO3jjfgXclr+JvwUgXBxyC2X+AYkgsN1kpLmhmc/0autnYNYukQrg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=pm.waw.pl smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VYDx82MjhooGw3leG9UBLZxvh7aZPV+/vgDmEeJnj4=;
 b=RzsegjRmdqr82SoMPywjEStbGnyzW4ydl+ffse/h2bXj3iyqSyiHLPyCaoauBHlgDml7UYUixpFLy0pEPeKdvaJrlRBGczrQ7ejBNfUhD0mrSv8F8Tu4lXvmc+JJgzrRdH/SOHinNRxgJeZXSogsDF3K0jKZ+97FECboTIRsBDA=
Received: from AM8P189CA0016.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::21)
 by PA4PR08MB5918.eurprd08.prod.outlook.com (2603:10a6:102:e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 08:22:59 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:218:cafe::17) by AM8P189CA0016.outlook.office365.com
 (2603:10a6:20b:218::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 08:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 08:22:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wwnv+AxbyQVfvd+Jd+tXp+z2sGBeghsI44eRjoon+7RxrVp39GYDhYWPcxhOvIQ6pNg44uXuS6gNFP/nXAFxO7M2rdwEf9N9SqIuIdkWvjB1aJx/sOp18NCT0HsdlHrMMX/Dbvzb6SdUXiZmx+q/o89YHtTrUEaCQSEWQtzf41o003Ra4acTJ0otr+0SxIAP+K4WNpwy78Sj0PFjhL7BgCLnZdjWDdPTU9tQ9AROkLo1n/4Fk41D5C/OiJyX/jsNvmvYRFVPj6uldqRCvRJ1+0qz5rNNwTztXlCAc1hNBhrrqkes/YHz7RMHz6kw4bpQRtmBpe4i9pMgMEuctN0Myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VYDx82MjhooGw3leG9UBLZxvh7aZPV+/vgDmEeJnj4=;
 b=XK3i6TSKc7csDUlKr8VEEk6xJBpKJtte1XYHZJw99pkTkIhX7TygRwU78zYBGlzfFmqHVxXmMmjcRj+8+Kp5VQ0NLrzisvW1yf+Uo77p1yON2yh5e8r5kAXfnwlISrkcNlX7z4C81AcE3cp/39+2dgwK62NjDzfoqIaCf2stX8qeA2Qm8MbBq8Le7D9UNY9y0hheyRYu7v8bHNbDyWisYwsLPtQg4YKCT00e+bT+ieVv6JqidUcnQnAlCbYf1j7EtAdCi5siO1Y58oCXKiw8WUY4lbpF2v1HL+Rotfcjw47tLYjmeutAI1RHsEkbCASbPj0aB9UFDjtS4tY7rx+1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VYDx82MjhooGw3leG9UBLZxvh7aZPV+/vgDmEeJnj4=;
 b=RzsegjRmdqr82SoMPywjEStbGnyzW4ydl+ffse/h2bXj3iyqSyiHLPyCaoauBHlgDml7UYUixpFLy0pEPeKdvaJrlRBGczrQ7ejBNfUhD0mrSv8F8Tu4lXvmc+JJgzrRdH/SOHinNRxgJeZXSogsDF3K0jKZ+97FECboTIRsBDA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by DU4PR08MB11008.eurprd08.prod.outlook.com
 (2603:10a6:10:570::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 08:21:55 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 08:21:55 +0000
From: Bence Csokas <bence.csokas@arm.com>
To: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bence Csokas <bence.csokas@arm.com>
Subject: [PATCH] wanxl: Remove pci_map_single_debug()
Date: Fri,  3 Jul 2026 10:21:42 +0200
Message-ID: <20260703-wanxl-cleanup-v1-1-d5deb23fa941@arm.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260427-wanxl-cleanup-7e59607dc4f9
XX-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::12) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10455:EE_|DU4PR08MB11008:EE_|AM1PEPF000252E1:EE_|PA4PR08MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e578c6-4ac1-4198-6207-08ded8dc4af7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 ZRipW5tcTC3yEAeVuXwI+bSbjz2s96VrXdGXxaNYvB7pAen9HUgR2EFegluhFoMrcysfU4bxA36u+pEILLIE9vY3sLbaBLasEBYQ5exFMZuFEmzWf0k4O/hcarqM5H3oZwozWS9QjnTP3f3T658N/1eW5ZdyxV4GxR+3wLfHC0+xoHYNxhgmJPeg6De5Us/1buVxTI/+7IEGkG+cCLeKHixEycEp26Zlk0a73hXvUS9Tpar9vW/949gia2wrTRzEpERugCYGhIzsPLA7GJ3wRb8RhNrg5U60piq46Bsma4yA7qnupkZnzUaZThBcN/Fa+5vZYk8hDwcT5jr9QIXawfHjjDxC06m8eE0rbMBIn2ZTq7ayQth5tFTR/9DucW+m60lYty7G9i9S+kBeynv2T0Xpid8w9CW69HU9ScwhmBwLm6ZJKt3c6Oe4Qm1O69t//DJT05Bv5x5/YunWtS7SLIVyIqPCmdEGDIz7ejBmKhRRQO2SxV0C81XYscdL3+X6s9oicIZR+SJo7T75sZCRzgtcAGxmNE5jGuJMpcNLZ4W/AgMvo7WqV+u509YmnQOYuu3jkpMsDlu04ovqc3rz4eH+npUyg+pmrO2JDyLhxVgHxr5oWQ/kduNyokUT69KllWJj9MsHvdoLlF5+YWkbysr6hwFnXuWs3E9fAoWchvA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10455.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 PaWQHu0GgTtHBcJ3jT7xRIh9U7/HedqHW/Yl1LXC2fkobMc1f1NVjgRk7TvM3GWPhdhtBQmO1ccP5+25z4vjytt9XMAPrxeeXhFNr5+hrnShHSXYpUmSvdpK8jkWAPzNybdpfLpRj7ILuBXVdV+pnOKNHgANJZdjmi/06fLisHEYL4zPeJO+jmwSgj4+g1+/S6C4jUuya4EidScshzZYx94pcgDbBMfPdAGoLO9+GwkRkpd4kgJc7LozSKfD3YEUXghfxXYewXdx4RlysItO/2ZHnO1CKzJyiUSkLWzRJjbc6a9hO8J1fgc3p3geEbsaxycYNMTCdjn9sFtUS+wJ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11008
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a675f594-4557-49bf-519e-08ded8dc2450
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|14060799003|35042699022|1800799024|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	R4JYEGXAxOOKpbpmBfNQPsWZUUnRfgAtlOlL/VISKUCV4AjIiECk2E7URht52Yuk5TLjSBxVI+1ljEyEpZrWsPEhHuV2ZvUwmg6oA+JZZFFyIEvPh76d3ZieEmOtQ5Qkrk38KoGHenRvxYhHG5hgyiXjSahx8qMXtLW7CdmkayGU4eHVMFfcbGCndHYfEd02GvvMYpTngqvPnyLEBSIHwTuwusvSxngG1WQZJVuWD8GpNcAi9ffzW0XShCQeNjfcs333r0uBXJDBsQoYKNoBHaB0HEFFrICe8QTsEu6dEzEtRcsqsuGIK+1EAKvXMwd+iO85OQWd10L9vnWHsBX2P0nEg+qyL4zlnMj7jtka/w25pylMGzffCHK9mMRhlDHX36HfeduVsDlhn7ijh/dkLY5moz4LyTOel0TAlkF6ivsJ0NbpCCaSUjTcXSzDwgj/DVHDq1z0bgqdATKp9ZwRDhdXELyty52hL8EjtnWPNjGwbCyRR9uXKgTXFvtAzdbNfhj8/7BgevCYI/IMafKzgH/4KMWWOPb9ux6HfVL2O+PESX6w9tcafSlJNpjxsm6pkid+suoWzbOyH+Weyl1HwqBMVTbq4VsbXXQq9l/A3G9vPSCIiXv9fcMVXv2wC31XA9W7ob1hsXhgkSpprta2TJhiGv07sitYTcgFXp3QnfNlFv7EWzr642YT0fhKRCc2n55PLW94Pim9DWn8FGXQww==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(14060799003)(35042699022)(1800799024)(36860700016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VXxDi9GkRo2W+ALTyvkFmG4Itvxq/sCFUADayI65I3Gi9/TkKkhKdycY2oY+CS6IzyhwE5ZlEgSQY5CrbjcrmIdebAKtMTQPHldpthY+f355ODmsEcW3GsixchM0TBPk3Gx6JIXwdf6aSwpn2rmaDSGOsoT9XAbSQiWeT1d652Y7Qv3/NAD9GPsF7+7BpBBHgD1eC8iz8+bZICWB0s3ElMPbuOh5Ur36YTyRWR0V+Ed8qa1aMeL20QxxlIXY4mGwnExHfGwIxeG9Zk1zwEavYtmInpi/Uud54eObTt3UeVp6W8KB4dAcxE+fWGysipRxugmewWCCoAbNxh1Ik8fRzcNsApH95j/tzrl+pdXr5CTkA8C2ni55CRlCEMFAuVNq15kcHE+qm0zLKtqTmdtxgGaaC39LjWoxJTmDWKWWvhLwsj5xIKLVV72UwPTCi26t
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:22:59.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e578c6-4ac1-4198-6207-08ded8dc4af7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5918
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304451-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:from_mime,arm.com:email,arm.com:mid,arm.com:dkim,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[bence.csokas@arm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:khc@pm.waw.pl,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bence.csokas@arm.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bence.csokas@arm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CECA7003A5

Since commit 24dd377a76b0 ("wan: wanxl: switch from 'pci_' to 'dma_' API")
this has been dead code anyways. The pci_map_single() function it attempts
to redefine has been removed in 7968778914e5 ("PCI: Remove the deprecated
"pci-dma-compat.h" API").

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 drivers/net/wan/wanxl.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index d4da88c77112..1540ce0a499d 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -88,22 +88,6 @@ static inline port_status_t *get_status(struct port *port)
 	return &port->card->status->port_status[port->node];
 }
 
-#ifdef DEBUG_PCI
-static inline dma_addr_t pci_map_single_debug(struct pci_dev *pdev, void *ptr,
-					      size_t size, int direction)
-{
-	dma_addr_t addr = dma_map_single(&pdev->dev, ptr, size, direction);
-
-	if (addr + size > 0x100000000LL)
-		pr_crit("%s: pci_map_single() returned memory at 0x%llx!\n",
-			pci_name(pdev), (unsigned long long)addr);
-	return addr;
-}
-
-#undef pci_map_single
-#define pci_map_single pci_map_single_debug
-#endif
-
 /* Cable and/or personality module change interrupt service */
 static inline void wanxl_cable_intr(struct port *port)
 {

---
base-commit: 51512e22efe813d8223de27f6fd02a8a48ea2323
change-id: 20260427-wanxl-cleanup-7e59607dc4f9

Best regards,
-- 
Bence Csokas <bence.csokas@arm.com>


