Return-Path: <netdev+bounces-200816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90388AE7081
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300611BC450B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCCB2E92C1;
	Tue, 24 Jun 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MEg98Rjs"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9654170826;
	Tue, 24 Jun 2025 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796449; cv=fail; b=RLZC2QiXzNqGq2XcLm2xCB9nWPu44eTxfNOeEpU8B2q07sUMEnCln3ZJyM2SyU3V1iEkBOBsrkd97tkdkHsV4CYxuqKv/ksLpPlHN4FonRjM99ynw4ABeP0NsGpJSIo2Tj5MaaFPefT3xaohHOj0rfKlTY4jDO1jQlZ5Jc/RiNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796449; c=relaxed/simple;
	bh=lWpDBwcodwNkKZquPVLz7eU9PKUmO+bh9Q6ZhQpgp8U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nmFzh5ODRWZ9M3qMah99a9GoDMmCNqzXb6xgrBOmzHLQT0txJLY5KLaBWAWt2xFJ4KA4PhVNOvAgw5HXaGPy5h2NJPtzGp7OkrzgTIyrkshKHKcUy+Z5kfVhAw03RbYf3noSIUC8L6yzVM6BfZm1aA5EM3v1lUt/S8DInCgB2I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MEg98Rjs; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqELHlsomaRfjL4ALHPezZM7jzPPQYzmEIPUjgjVIPxVuqWYcNXivEs2mxr0W9XP3sOMnT7uMmxVLygf+WVVZE/3zaWe5hPwFBUOt53GDE7Yb4NKhHvd7V+ufi1Ibsf6C0rzjlEjPX16qGD1Ka4LUzrpOL1LaHLa18J7LlnYE4nFT2WpTtbNtTolr1hmg1MdqVjUEkZxD0GwLgG+9HvdqgQagTMYy40Ez61EWSsN9FGuuKvXKyjUd4Xi1+Vc/bKTwjzoZGWnQytkjqZ7dIkcUDZytTJFNNdmT3Uc4v3udAhYfVB+yN2pq8VvP0yNfIaDx2BQlhizzoyYxpQvyEhx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRoSUubIoCMc9EbcEVZbKcFN8np9PwCuxneqqyLCm3w=;
 b=fo70A0LqLZ6bZfPMfreuGO6MvQQ6nvfl+T3aZ+o6y8Qbk7930j0wTC/fqiuQAmNHBMaFDiGLeq8GMCiMXtU2vbt55XVVOiNO2tbBfYyOUgkksMKlPiec81oowZtMxcee3cMCxwX0zJvoK/ehL2ZKwhSgQyRQijJFJ7xOmYUjVOXrFLv8UF/1SrIj+fv3upiyOaMGqTgquQxGyQNd9MgW9kn6IF27/Y84Opqcd7lHXRrKjShBQeXsE1TZ60arR5EttpoHqZowTzgkIL1jSaUvzU+yTFkI8vJv+cm8ogFiBapuJ+KfqOoPh5f0Cpy0/NHcj1eR/fPULg/Ly7kINPAnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRoSUubIoCMc9EbcEVZbKcFN8np9PwCuxneqqyLCm3w=;
 b=MEg98Rjsy8hYqV74s6cxKDq5fLP3pLVLEaSozwmqLFpJTKVMVmGLo4p26KUeuYGpIrjkCPFYx2Bj8lGfVI/TwNh61qhtbQM6zRW+ZlczDWjV6//TFQblMmMmbwsepmmYAY/pHaeHiCzHId1/ftwwi5vB7qjgprq3TmW9Xc1x9PI6xQJmDs5v8rJorQyq8f2ZSpdPsKbsa2mjo8fGfSsA5s+l0YLrgcO+gHIYoRRq454Wf83YRTF5ZFHQduqD43ZoC543R/uGUuqV4e+wyAfuvO1DD4Mat66RTA0tUxILLJ/NewR7QJZxe4ymPZK9uWS/74ZW3MGZhA4+cKaT7uKhHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9456.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 20:20:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 20:20:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: net: convert lpc-eth.txt yaml format
Date: Tue, 24 Jun 2025 16:20:27 -0400
Message-Id: <20250624202028.2516257-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0022.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6261b8-8ee7-4f2a-539d-08ddb35c998d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w6YkAe5QIUHc+yYXJJKnNVhz2mFVrpA6MkdC3sOZyi8d6ZaJhrQGlmgFKElb?=
 =?us-ascii?Q?KnoL0pOMdKVlt86KabZG5q1r4sojPEhlfS7dj3crW40s4yEzTQ1lxs/PvIMn?=
 =?us-ascii?Q?JtKaDIhl+X4W5ne2OroRrgaCk7Xm3fjWJfO/TXUbrtdpNJi26k92u+M8gAwp?=
 =?us-ascii?Q?o4fDUMH6AKkOJNmDloqswekkOuMhSdnIGbUleX+B30gPKsIZgDkpx4gYUn7X?=
 =?us-ascii?Q?HMIyFmqwbd3iw3cIOC9mkNXQcg9mEobzTabz01u6o8Ado+xbkYpfYUZk+k5d?=
 =?us-ascii?Q?XzmQSQSd0e8eZjbr8m9GLmNEd37n6m2F5zu3JZSG8slh1jeQuyBmL3hBdTot?=
 =?us-ascii?Q?9kAO/9XPlAfvP3xaHg7T//VbZ5izZ+NSUr2ZjWktykvNuMKeETkhfYrMtBlU?=
 =?us-ascii?Q?QFIK0DpqyEZOv3uoyfDlZtXsbhppyn0ClJSVVN9vWgE2j4BHN1B2In+FOQh7?=
 =?us-ascii?Q?iFnKiH+yGuWI2po7wW9vhrvag44hxwzaCjak+TYBgBXohqQtSRFy5VNClgCz?=
 =?us-ascii?Q?EP1MrlGesNCF9svZZc0Tt3ajYnhC5R8XPGsKW591aFZus1L7ZVsZpvYfL/CD?=
 =?us-ascii?Q?TvAtJVJU52OqD5fWlYJJHjO6tBrO48kDAaHLfD46G17TMXGs80tiAXtHW8rT?=
 =?us-ascii?Q?MtLfma3WMeYlN2MlDORx/ufz99C9qDySMOAe54BCdmnM4s8zK5WDjTg2a6py?=
 =?us-ascii?Q?/D1j+p/6k+YKgLP/QU2+sW2rtX6UiD+bYxC59qs9InbEIxPaQ/7l/5c6nx+x?=
 =?us-ascii?Q?WW7GZqjpNQrReXgQrAy7/kjtRoCWurD5XeSXw5uhwcW2rVKpgeoMdz9O1KNe?=
 =?us-ascii?Q?9QTs8TzAGcu7drkeifPzP3epfR8LZqerD++9wajsVaR6YtiXV37PuPf+zIbn?=
 =?us-ascii?Q?Bm7emTZ842yS4NQBbd8fPcHxNSh+17W4MojJKo3P/yp6ql39PrM2GyvrQg6Y?=
 =?us-ascii?Q?ZAp2pXBjx9BtGr6Ftwtpuk/Y9NhMiqbZCMu+E9zvmcdUEmXoaE7XSK42NMVI?=
 =?us-ascii?Q?Ohd1Nve70gr0rpRaCq/kduFI2kcfctv1UoULCjotMccKAh8ZW3zeM/fgwSec?=
 =?us-ascii?Q?EK/O2fxWOtC187Npg0FVmMl0ibrQKbCxEqn6IXaH1UaL4kV72Fm3nCRdnzmM?=
 =?us-ascii?Q?GAqeb4LY/zj9JL2b9jBhn696kJP3oU499o7rlFaH0pTuLDNoMeP7nQW50iEq?=
 =?us-ascii?Q?xVHCqVkJySzM0t4bDmE4/fnp09/O1gtEC2pIR0CHUDY31B23x6aQiOshiC+N?=
 =?us-ascii?Q?xpkb1XXTiZtcEnf+uE0MrbfHjpdbPi6oIOeqALg3iLERazOAubkdyA9H2NXW?=
 =?us-ascii?Q?aEGLlike3fW4BNPxZeomDj//Yh7cJbhMlhwqjTgAdZv2nZh49/ugftAzDLHk?=
 =?us-ascii?Q?ZNEKnqLetzh3rr8jQPcOqlTL/dZ1pY0n0FxlIUif6SdlVs1znVHgU9a/i7VW?=
 =?us-ascii?Q?22N2Q/jnjCalAaH+GaRxJYVrF7Zum/K4l3GNohfUf2MILcAAxbBuPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WPBTl6bU+znNy87/23vYQjVF/VgZhXI1goX2mhuSqZMfunzkPJf5V+5zRPC8?=
 =?us-ascii?Q?Z/uSaUg+z6csL9zOHHDzluwcQ7rHiv+AtW03wmrptvdn8PHJPUtYR5QiWrCD?=
 =?us-ascii?Q?xJFdlhCCbo6dnk52Rqh1i010n9wfj6UUGkPwDPbZ+O/J1XjVYTc8qSefUl1E?=
 =?us-ascii?Q?r5sQOAN9LgfY4C3j3GX2ZMpZbrOU2vvoOny2MFclJ9R//6K8Tbe8ScBfheoI?=
 =?us-ascii?Q?zwpxfyDbgTZ9U9vAwBummZus/hYvkOpatW1334eryEwhm4EvoUE6nRFO6fi4?=
 =?us-ascii?Q?HGNsqYxaIAE1PJJHszGdtks47cAarRA5wbZ1N6fFBuynCiYRpVBhIrpjUuxG?=
 =?us-ascii?Q?cRUQ+FYUPfCt9btqf70Ft4Xz0Vs71F3FUrfA0PSUk1HvO9pOUzETfO+SJtzZ?=
 =?us-ascii?Q?S9q+zABLFuZHTn056lWQA1C9BOOjDfdzkkYIqMHAaSnnhKtJbMW9WcAGSfjr?=
 =?us-ascii?Q?ZZ4b4T0vKu/VPTr98eBdL0shit01V+43ymQqb3k9qlAKamQKZR9lMh+S9CJJ?=
 =?us-ascii?Q?/FxhohOjEqmGIEtiLjV3DNKbdfR7BDuryZJTGxu1EGGvqjxW9WeoU8sbP1zy?=
 =?us-ascii?Q?2WDJ1PDHeweweM7Pnt4Zk/JL8Nsf28wZt9JKDk5FPn8BUoN6j47jBkDVXSGl?=
 =?us-ascii?Q?o6/t8RoauW3Wy2oh8y9dH1jZ0mg3n2LFvavGdsO1ZZPgHDtVFOta1wt5A5C+?=
 =?us-ascii?Q?puXKKldi9snwJOiUT59pRsZlgzWwG0d9lgCAgPrHkdcxiS8eCmbOUA67HOMd?=
 =?us-ascii?Q?DtVX1/zbHdHhmewQOqU30BMQocaUUxJCaCA5sYS6aKu4aKJgOP7Fx1B2DSpt?=
 =?us-ascii?Q?MGrKaXItylnYBawaTEKybnaCmkUPPob+oqPfdWQS6lpW4TJSBDSRsVhXGvEm?=
 =?us-ascii?Q?mv7dS99/DHIEQ9nxef1vKGsJt5eSaePhSONRWCHfV9ZZ4+RGT6PUSgAO7w78?=
 =?us-ascii?Q?D2LI1Xy4T5+zLEQCiBbLvLu1Mbq0185bWQCZSczl5I+V4ZNasjXTCDREwaU3?=
 =?us-ascii?Q?5Abz2eBHW2ocGYRK+byx3cOwsp/A7szznIu904ERufgs64fSBCmxII5nnAJp?=
 =?us-ascii?Q?Ki0p+okiRfw11/Bm9PxB4rcKpwPP3NXOUNdbomqtLyRqkb27pZgovWOgWFKJ?=
 =?us-ascii?Q?dh29Iic0IHvtqo8NtDRSITj+gLKxh13i0f2ZzQIP+B7VFQpqBX3VEkC8el6S?=
 =?us-ascii?Q?8pSiFi8XcaswEKjn5V/H8DzMFlDQhrlm/L1kbpr+0uuKisKqzwZu/0EG5fHu?=
 =?us-ascii?Q?LOlLI8YDollvyhFKjM5QPUsb25X2BGmroi9F6Wz7Pj8xoK+MOncPJBmJFU+r?=
 =?us-ascii?Q?2BSnUwy/O501IQ/Ay8qAMzYFXgbrtI/BWOrnNzO2aozIkXSC4TocH7qOhoH7?=
 =?us-ascii?Q?2VtE/CrK4T5vCfk1I9cqVMV6gk/tox3SSeb/U7Y3N09/xJ1LV4BBCmKUxQik?=
 =?us-ascii?Q?p4CZqvbOdSf4X2kIpcphHO8YapbMoNgOVG2mjlZn6epLcoOOGTtMN0TgmSkg?=
 =?us-ascii?Q?NVITWPl9g+ius1lhjIHfoV0v6ZBtera8Vmlh3zhKyGwEZpJo7fO0VULNHOxu?=
 =?us-ascii?Q?NrAcD4KAS8x7gS+GyQlBGn/YtSBiAJnL7FoOpJpY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6261b8-8ee7-4f2a-539d-08ddb35c998d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 20:20:45.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4e+Jdk0DcGXsx2lj6hN6rRdLu0V7TzsCiAgF4KO+RAUo//HbxP51dWJjXpj8ZU2xlWZlNQtufbZBP9/YJH9Z4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9456

Convert lpc-eth.txt yaml format.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/net/lpc-eth.txt       | 28 -----------
 .../devicetree/bindings/net/nxp,lpc-eth.yaml  | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/lpc-eth.txt
 create mode 100644 Documentation/devicetree/bindings/net/nxp,lpc-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/lpc-eth.txt b/Documentation/devicetree/bindings/net/lpc-eth.txt
deleted file mode 100644
index cfe0e5991d466..0000000000000
--- a/Documentation/devicetree/bindings/net/lpc-eth.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* NXP LPC32xx SoC Ethernet Controller
-
-Required properties:
-- compatible: Should be "nxp,lpc-eth"
-- reg: Address and length of the register set for the device
-- interrupts: Should contain ethernet controller interrupt
-
-Optional properties:
-- phy-mode: See ethernet.txt file in the same directory. If the property is
-  absent, "rmii" is assumed.
-- use-iram: Use LPC32xx internal SRAM (IRAM) for DMA buffering
-
-Optional subnodes:
-- mdio : specifies the mdio bus, used as a container for phy nodes according to
-  phy.txt in the same directory
-
-
-Example:
-
-	mac: ethernet@31060000 {
-		compatible = "nxp,lpc-eth";
-		reg = <0x31060000 0x1000>;
-		interrupt-parent = <&mic>;
-		interrupts = <29 0>;
-
-		phy-mode = "rmii";
-		use-iram;
-	};
diff --git a/Documentation/devicetree/bindings/net/nxp,lpc-eth.yaml b/Documentation/devicetree/bindings/net/nxp,lpc-eth.yaml
new file mode 100644
index 0000000000000..dfe9446a53758
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,lpc-eth.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,lpc-eth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32xx SoC Ethernet Controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    const: nxp,lpc-eth
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  use-iram:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Use LPC32xx internal SRAM (IRAM) for DMA buffering
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@31060000 {
+        compatible = "nxp,lpc-eth";
+        reg = <0x31060000 0x1000>;
+        interrupt-parent = <&mic>;
+        interrupts = <29 0>;
+        phy-mode = "rmii";
+        use-iram;
+    };
-- 
2.34.1


