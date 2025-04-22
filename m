Return-Path: <netdev+bounces-184501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A900A95E65
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB7F18969F2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 06:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE708230BEF;
	Tue, 22 Apr 2025 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="rrOboXWd"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160422578A;
	Tue, 22 Apr 2025 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303815; cv=fail; b=A0j2WboD8XCaZ6hi2cd021vA1g6zgyAw2polir8N/LCuOixD3MGVy5jZIkxnnkQkeJtn8P2yyAD6FjHdhMnY1Gsj/0QyxAtFOVKbZmWSUgizoBBdytIOZ25x9rCqS8yL1H85UW8x05PLQprQu6nleEUgck9Nd6flguah2A0GFMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303815; c=relaxed/simple;
	bh=gp8R6eFHVJqcRBtt6jBNBr6HxvBVour7lkmvQILVMFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jn4vwaLoMmgmnHKbkQARNUjJeEKurw8REk3KzXab0Kq3iUpP9hFyLDC/SVZ9A+W3OCp21iWVjvjluH5Fs0m/a16wHw9Rgg1GpqQ2mKv6MjnRxaD2nrgLHF/f2ngBsd++ZxyU586fnvm+PUKW1DjDxTijTnlM6Eyw5JGSnXMwAJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=rrOboXWd; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHqPtx+mlw1Ex6ZpZlVwpbz1r9quxhmI7iVwSxFb7tCuRMaPNYo+gAeo4FqPlDULdizRnMJsKEzAL5QqtPClTmxBlLiN/xsJ2VBl8UKtyzPXMT+9TgqURH7ipn1TQSc0X1SV09w4Lv4IpNsbEqNH+O+bfJvWqd7TOrawAexP7X00Jey5sKxQWnbYCIXS9wmz43Z2idw+9PR/7Eiz6QjeVWlFLA70i4RYxbzFFnGjZ1/xqWHL8ZhCIrhA5hASSz/lnLsRlR1wOtJOJCl0Bl07G2V6s6cdDrcNoVr/+Lu2XTliMGP61tiJQTHdJqsALBkh9wuaRemUzXYVvTs3zz3+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHKOC/dlAJLu3UefjiHBDxiBZiV2VUgFoWdyLQLq1/I=;
 b=OejwC2eNXBKS41yYQCelvO1Xn8rRs5VNmnYfcBl9lCEoIkWD9lHpfbtgiZinUivAqwGOOtZ4TPSTWACGNyfJF0Prdf5IpKSwn/SsdbwRvHEYhbtp+8zjerw7SXnAyNOmd+yDQQ2eqVspNq/P1Gag2REiQoLbE1NApSKRWbBGs9F0y9XPulsN1EnnKF/wER/usL4t6veoaXGGugKVsrwZylumc5GvTSaNjsjchVnZxkhUDwvUGGQgCyw9q8XZsT2etxo4TMRgALTTjBsLaavuEn9iH6c8te6sNuDSE/DGDkSOU7MkWHMQoHBtR6jDr2Rtsq2Qp1EXxpfeuYf83hPKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHKOC/dlAJLu3UefjiHBDxiBZiV2VUgFoWdyLQLq1/I=;
 b=rrOboXWdOdz4otnt81PVHFgr0VBloIYfFWReUB/VAqoZuO+rYJvIgV/IpVyPl02V2LmLI8YjMwCEnGZpiEnhuXPVXxvXHYte6N9c91kNaWfeBJBoAQyfx+xAPFvRooz5NjDXWqrlFsKZSnl1lF0yeHeVryk792m0Qo+6XPML8O0=
Received: from DUZPR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::8) by VI1PR06MB6653.eurprd06.prod.outlook.com
 (2603:10a6:800:184::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 06:36:51 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::38) by DUZPR01CA0090.outlook.office365.com
 (2603:10a6:10:46a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 06:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 06:36:50 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Tue, 22 Apr 2025 08:36:50 +0200
From: Johannes Schneider <johannes.schneider@leica-geosystems.com>
To: dmurphy@ti.com
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	michael@walle.cc,
	netdev@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH net] net: dp83822: Fix OF_MDIO config check
Date: Tue, 22 Apr 2025 08:36:38 +0200
Message-Id: <20250422063638.3091321-1-johannes.schneider@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Apr 2025 06:36:50.0557 (UTC) FILETIME=[EDC72AD0:01DBB350]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|VI1PR06MB6653:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 882fc57a-f8e2-4590-fdd6-08dd8168107b
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ScCmo7Qj5vdN/kLRciLhh7p3iYs3ny3lhAn/P4jbe1kSUDilCNHqVUU1tscW?=
 =?us-ascii?Q?jp8rlVZzwPmc6TMzuw8ovjlkuiUuxMiuMuKfYLhLNZK+LEPBPDM7PhHdx7Id?=
 =?us-ascii?Q?CxumzxBsTni/GzEFXsSBnNkaJqo0A0H4wrVdErmvmL0Z854mrYeXNNDpKOvW?=
 =?us-ascii?Q?s11phnBwv+cDePTKKvDx0lpZATz+lUovoG8pzlXvY9udITX4VFQwH1yoqAfD?=
 =?us-ascii?Q?HM/Uv2Vku7E/kl4isGtrQ+m2rcxVngOQxtzf1wqmO71qWS8tgrgTEe6Q4Idt?=
 =?us-ascii?Q?ff4bLn/jtVKXT4mY7JAPZzkrZXANqAxes9HC4yC1KEPWAeLyowOUxktuVtWE?=
 =?us-ascii?Q?XVK+MTYfnQLb6dmz2HPDG7CgLJ45qYG8JEtEvpyTxPDVdM9+fQvIKUP5ZNTN?=
 =?us-ascii?Q?0VEfLOtmfLQTnJ0tOXgpw5P4Q++m7MmFhaoPxoWgPD7u6fxI/tQ/4xq4HC7F?=
 =?us-ascii?Q?ghYTfptJA/sizKVhCDr+O8myEYAG6xGUIw6JALXKSLKyaHXL4lZVV2ZK1YSV?=
 =?us-ascii?Q?OaDsMOJPpq5s41kQIZOMs7vQ2ukFeEOeM5x25z9Ki1sLwrTMaJCyMzMGRa/t?=
 =?us-ascii?Q?CjUnHgXmhBdgbSilm3qBOZxF53LKMzdH+/94xlVVofoUDbwHubZu0WSfRTXe?=
 =?us-ascii?Q?2cf5YnWkjoOHeT7D1Y0w3a7RZaBHlXtZmQC1js9BZ0qQLKWN5BZccl9g+HsP?=
 =?us-ascii?Q?IESZoXAdRLmax1LMiw+PcWmTJ1BWNBO1CC+7lSX0aBfVPlrs8sXlRnZ01zBS?=
 =?us-ascii?Q?LGGregLdcwr0mMcUaHxo0NBTbh1m/hPjx7b62Athvy3aIWHxc6ocf8PQ2VyW?=
 =?us-ascii?Q?q9Oi7MRQBB4oAJzcJBPZNs9yeAZOLVZKF/ax+S/ZgKILae3WxuGLjon+XDxg?=
 =?us-ascii?Q?RcR/XBbyF+ZsDIcVSMWaDCqeXeIGYPtWIu6MIiLxL/mFhHgw8v92jY8I8ozi?=
 =?us-ascii?Q?wIE+RG4G6an7EKKd7mHFpanjXLCgoiSmbN6xPwAXVzakHcXewMhmfzuBKtRB?=
 =?us-ascii?Q?HHhe1HRNKQ2YmDs8RNoderpUCGMIWzvTGTTUCKmpNn2Ml5wLYlHFk3WCQ0Nx?=
 =?us-ascii?Q?HIrVgOXn2KO4CEwLLPyugVrZOgdORJZzuHPagVen2C9g6rHqyhQRKFbNXVKY?=
 =?us-ascii?Q?1eHJ3LC1binI5aLBZVN/qbNa9zTWJvZGAt64ELX41R04RrM/E1MscDKbbGh7?=
 =?us-ascii?Q?TvYvFlN6DioHkZPwD8DGIwgIK9VBN8OCpEMJ37bDBg0kLghx5ZskZ7vFnBlC?=
 =?us-ascii?Q?A+og/ISN+u0IknVS+tLhoXqlK5kf85wajt+qRDoOAhwC0/T9cI9mk5Pmlw/4?=
 =?us-ascii?Q?m1pknI5W+x6XgTajgVoEneAavC0a6nfO+ZNSqEWQhgAIGv58QWHAhQCRf5bM?=
 =?us-ascii?Q?FIzD22D5APskqIKEG9LKjwrvGvSAjjDIKto48+YfrRlwBFd9XlLFxpO1tNEc?=
 =?us-ascii?Q?XxJKxk1iEfc0cEmZOj+YboW3tZ4HhqVZ6gdEiprMWTkq058moXgP8mcomiEN?=
 =?us-ascii?Q?MyrIxEtNil1XjE70mlJijVghtHLZDzKj2cmP?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 06:36:50.8233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882fc57a-f8e2-4590-fdd6-08dd8168107b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6653

When CONFIG_OF_MDIO is set to be a module the code block is not
compiled. Use the IS_ENABLED macro that checks for both built in as
well as module.

Fixes: 5dc39fd ("net: phy: DP83822: Add ability to advertise Fiber connection")
Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 drivers/net/phy/dp83822.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 6599feca1967..f1179881abb4 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -719,7 +719,7 @@ static int dp83822_phy_reset(struct phy_device *phydev)
 	return phydev->drv->config_init(phydev);
 }
 
-#ifdef CONFIG_OF_MDIO
+#if IS_ENABLED(CONFIG_OF_MDIO)
 static int dp83822_of_init_leds(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
-- 
2.34.1


