Return-Path: <netdev+bounces-306035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Is1LjwbT2qkagIAu9opvQ
	(envelope-from <netdev+bounces-306035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 05:53:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA9C72C74D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 05:53:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=KbFyMgCt;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306035-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306035-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36688302EA9C
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 03:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A33876B3;
	Thu,  9 Jul 2026 03:53:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9E1FC8;
	Thu,  9 Jul 2026 03:53:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569208; cv=fail; b=t25GF0Jlp8ALonuu+rRjxfVlHqxonwM2/bGLJyNp4itlkWIj12RPDgmHR8KLOjMflp0SiXaO89JQ23C1CFM36aFJeWKY0okzIZqg0VVhEbzlLH91T7G5iMm4hVVYLm5s4LwPwmeHaiDWmItjP7lJBqUqOvn+TQe/uJ9H4r6HKR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569208; c=relaxed/simple;
	bh=EsUVjQE4uOvFi33moTqOVh7RYte75tNMnq4v3EYGnJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FC1HP/kBGQr6U5UOY4/dqkhqxBWr8ENZ3aKk0tWUyYHj4306DMMtoYSeSh8fw8fbVmcD921P3lvK5vm00Epm7i42uvYn0ZEnz4h3QPZH18A6K8BYUHFREou5yB28/9Rh113XKBG6N8huNuuJDh/gQ/SpHDJn8m5aj8p0RFl0eXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KbFyMgCt; arc=fail smtp.client-ip=40.107.208.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrAkAbPhMbSVSSgD+BeX3PyUO7Qbljut0CmeUsjNtrepNhZEQKx83DqedfAypXlD0qbbrP9KdLbGLd+oTCijScosb2S6p/D85jYGxmdzKf56mvXoQmMM89Bgjf1wThsxfXJUusB8lGOkviYszqGGPy2vlfqTLyimJtY1XS8hwbRXCiBMRKq7RiAW84xj4AiOa3uZXzUwbih2KbzHUq7yepTBS3UYuKzlUqKEFTFn4L3mPDYJ+e5lmAndEhGzVBD+sltjcBmuAqCNdzz1LecWAMcKXwZgEu9DwAFOwgQqMMfkXLGmPsV2ftyyXv7mjfz3tu6f197/3m3IJPKR74p14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsUVjQE4uOvFi33moTqOVh7RYte75tNMnq4v3EYGnJY=;
 b=ByTWAUzBamV/ZmKKWv6pPC7tzQ3/Va5AtnyBuSvr1D+uVWELgtlBqOGuQsCsRlH8MkhFfyVdtmxxqWkxwpN6cl21sRrDC/hJGjlqPVYFCML6lk64v2moSIKaYyrMRfLbUJDHXK7LuC6aLHREyqkMlhwXdhiblYSornaZB4i1ehfpPMdNfbhHeN7fpqxFAFPtpK21h995CrPPVDNDiKbZS7aMaOOQgr+KvF1jDgzzbE42grfGIvFUiaHme0tR4KcGoykuwHzf3WwGMY2NU9Z5Y553eIlnooYxppqu227crV9BP81y0v78ORhswHv012pXHkX/3hMeIP3Hpasc/8ONZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsUVjQE4uOvFi33moTqOVh7RYte75tNMnq4v3EYGnJY=;
 b=KbFyMgCt9TvbGUbOqJ67Yw6Yc3+LlwufaSKYR346z2+Fz+bb0fnYUGDSf6XKlF3MDdeiojfDCAYOJUS4I9gpw2PBj7xeN3880uRLcgcO8aD0fKe8odZylmXHHb4HI8aEGwnfYLS7RqnpHVCYbhui2uAlytDojG2TGfp7SrkF1iLxZj+jS+W/zaK+PyKHWGERqsHF/FNp3zNUWuOP0yYYLDqNJ0pu12wTPRL50uUAoYtNgEButmEfBzONw6E9oaXZcGNtkQ1Gc93WLzEJaLzBFjxddJAn9pEsC+sOixboo0xzXkiXTR55/mC9nLTmEI+AeiGxg9U227VcgBS6xqAUFQ==
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 9 Jul
 2026 03:53:18 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::3d) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 9
 Jul 2026 03:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 03:53:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Jul
 2026 20:53:04 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Jul
 2026 20:53:02 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: Russell King <linux@armlinux.org.uk>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Question: net: phy: realtek: RTL8211FS SGMII bridge mode support
Date: Thu, 9 Jul 2026 12:52:42 +0900
Message-ID: <20260709035244.3008436-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: c2571721-9916-40bf-e30a-08dedd6d9c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|1800799024|376014|23010399003|18002099003|56012099006|3023799007|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Ny5sB4YPqKfBWgU4dqo13vrkeHDdgWqv4DWF/yjR8kCGCwz32jdQjIfzjgEmRbkrOlsAp+pxFYgNw33czofwRTdu5ml7m6O3xu2oXVChDZuQO6YEOqxkEscyvsSmigK0pia5BW5cSfzeHjF6+regw9FXvjAhA5LcY7n3ZRihX6lz0yPu26/mMu2cDhovU5CBkCXA+PAuQorxmcR5GZmQYtGsIw5+9PnZTlhbz7tWLX8+LLZOfWrJBMcP66kK68FkJSmO7U35lYAO2LMoaXd7Mc49XkDUmBJgVIzrmuRBmUF6MXXbsOgLZJS/97WOB9VpTxNtTs+0D1vIToT8D+cYFnqKPJ0ar3UykSRqlNfu4bF1Ncaji52txTTRkfDKKMtjTHifIQB+v9EgtVASlDm0KdXO1HdnadwZrH4dgDFMHwq0+KrS9AEeFNltokh7gOdkEj+lmwK66sWdZV9nAjRax088sFQSund9IFvTf2+mQD3kBYgNiPSaSnIt4qCunkcXZe9w/EPEPpdOcM/4zlBgaez/yDpuneSBQQ/3watI0QdzmAkiu4duIT4sS7BtNKuggsV9/1+mPnOIEqQHdPNdwuy19/8HD+jM6jSmAr1Uv0H+ieN3CZbAoUmxeP915fkZeoIbBSOmY1sMzVlsx4HGb0XReSXlvmYO01D7ntfSEVSKcFISVHKejYV8WZDd+/+UAgTxtfvkiK+w3n3l9Fpvpg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(56012099006)(3023799007)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wKCYEv0iUgi01uO1xZXWpmX54EK6KH/bbt99u7kNcIfIrRc+qu4opE5ZyNWHvENYl4i8KefnBgBVSYbdDJfjJARZzQpbyOveHpVSdH8mfTfkSnoUUC/P605qxZFpuB9TCwAt9vQPSAjkyYuPBGbKonD8VlKEeqTCctfMcujLTilviL2jSmqlELRguoFBF8JjD4GQAIZyMoJspJRPAvEu4FxSqz1gBTTGhQLhGupuPj7+ZcQukpvoEVGInvCGKarKVIj11JnMJWNnilx94C6HM0OkUigq9cowyCt1z8dmIPNp7RB1b++FkwWZPULv5+pFnnSKkwP0Q1nTluQWatyH+c5dUS/dxsvJqm2UDznywD26iVXalC036/o7z3IMe41Q/SxYtMEaMWTREGE7tQAF5K+SyZdxgoRin7I3KNv6psIeo1/QQopmkXQz9k43eU+k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:53:17.8565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2571721-9916-40bf-e30a-08dedd6d9c75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jackyhuang@nvidia.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306035-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackyhuang@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EA9C72C74D

Hi,

RTL8211FS is the SGMII-capable variant of RTL8211F. Besides the standard
copper/RGMII mode, it supports hardware-strapped RGMII-to-SGMII bridge mode,
where the MAC side uses RGMII and the line side uses SGMII.

The in-tree realtek driver currently does not handle this mode. RTL8211FS
shares the same PHY ID as RTL8211F (0x001cc916), so the driver binds it
as a standard RTL8211F and follows the existing copper/RGMII path. In
RGMII-to-SGMII bridge mode, this means read_status() does not observe the
SGMII-side link and the link stays down.

We have discussed this with Realtek. They confirmed that the current mode
can be detected from a vendor mode-selection register shared by RTL8211F
variants, and that this case is application-dependent rather than generic
copper PHY behavior.

Our plan is to add RTL8211FS bridge mode support inside the realtek
driver, gated on the detected mode. The driver would only read this
register for detection and would not use it to override the hardware
strapping. For that mode, config_init() would program the SGMII side as
needed, and read_status() would read the SGMII-side link status instead
of relying on the copper path. The existing RTL8211F copper/RGMII behavior
would be left unchanged.

Does this approach sound acceptable for upstream? If you prefer a
different model, or if there is already related work that we should build
on, please let me know.

Thanks,
Jacky C. Huang

