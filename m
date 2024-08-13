Return-Path: <netdev+bounces-118106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F340A950878
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CD6B22DD0
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422419F497;
	Tue, 13 Aug 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kOs9N6DC"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412E1DFD1;
	Tue, 13 Aug 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561599; cv=fail; b=WM3ihjwjvw+BeeegetdghBSyigP818INoJVYE8QBoiANDQyAeEp7UdaHuheVnFPuaqSSdFD/ctj+qynAt7S+/dfwzIRPGX4YGsfk0ffaboTgODB5Td4GmPM7dHZfBHD2dqu7tBQyNzQ3pTzzJlMhBi9FD4y5bzbCZNo1MEqdbHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561599; c=relaxed/simple;
	bh=JoIbXQe2F9Erdn1EBsgjoxl51EGKvKr08NEBB2yuE6U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zziwv7M46iBfULrVWdpISjYAUE4nZwrPRx4+Tbw6rMW502v/wAyvVqA9EABwkjyL4EIWjrqQylRPWxkMDh7ZrA7Uqv6nWZpOpjmfpR8OFSrruH4gBUXhwukT+/JxY7QYXrRSTpbU2q7lfZdx/HX2ueSPK2Wjn5ShbcRDl3jbA34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kOs9N6DC; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2/dL3vllXh6AizGsCrOtRc+PnBtjiq+Sna69H21LOaeJpWkQ4EDP0f9Jqy0nHx/diDJZ+JiOvC7LVNwDZL4CseMeRK+f0qEnKLqd0Qr0RkbXLRGVcjgT7gvGsuB9q25YjavUb6jtAsTOOyfK2sqDeABpL1ax8PFRDZO0rEvgNvJ95lRccK8mHun+b4Ox0igY7H1SEaJxygGj4NsIMqmKRIzeEuQb7fpqFclu13mrP3D0/15fGGRMuvmUPw6BFj4VhR/xvn8GwqSieAQrOOoI0tK8WXSPzoPSu39856n82GgieriKTpwACO5kep/L17giIbWpSvPMWPrBw9OZ+dZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/r6oZiP0nU/U4IAhVPdZ7NoensT7XTFXyGH2vyiKJw=;
 b=l+QcHIVxkZ3xeqV90F0h1pgLb0z19zqQvx6pzudLcZzTWAaLkNlkeA1wkzmLMVAME5U7qCIgxfW3cVpEYUgnZK0Kz3brMPmMCsdpMmA0fvmmUX98Tt/PLK+hgx2rxtRVO4JSvizY66+KQ7iAtsYf8VlJ/qz/TC6OrGkmsosxGRdtr2v4Bl87mLZmjXhuFyqxQ3OXK5/CoiKqIByGco0ARDAzS2e3+hWGtcC8Tq0c7k2nOYiIsfYg3uhbQyWJSs1jvhoULigH8/mvddlXymsfTuMYImx1Wewnl6P3diE83SUZwcBxWbdIh52soGuSqEd+RZWGF038PT6J+hJhi+9iZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/r6oZiP0nU/U4IAhVPdZ7NoensT7XTFXyGH2vyiKJw=;
 b=kOs9N6DC1N2w6g2keNLdkJUXPna79GTW6qvrxc+q/0PRDW4Wzt6JeKVFuFrzdHmuT88CMSKMoFvC0qwwjf9+nBC9QbduNZKuWkE7+7h5zQBGMFFjWKvdB/eostXXCgC2DaAk3GlLr0wiLUgNJPvw38baePNms/x9OB81HTYotjjPFePQfR60t6spoLjJysMYSZcW12k/INbtJP7x6gBCvWNffvdVgKgQtpTfWnYUC/juisgrxi3gfJGaB/n3bMEa1lhZ1JJ4i2J4Yvcpv0gr1rqywFdtF9KafFvMyQpY0PQ1LunqogyxGjOMDMsNd7SLYw1UvQ61AtjZEG8gMdqZrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10233.eurprd04.prod.outlook.com (2603:10a6:150:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:06:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:06:32 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: net: mdio: change nodename match pattern
Date: Tue, 13 Aug 2024 11:06:14 -0400
Message-Id: <20240813150615.3866759-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: eded9e01-677c-4524-9ec3-08dcbba98469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xdulWI66ze2g5yeaTOErV7hnoBZ0uCxfbzKbtmBYThYuon5bsSMhIKVMNYiO?=
 =?us-ascii?Q?7GpfoEWa+nNeKVnJP2faQYWihqcdroWMhbOhQ4lsZCH+Qa8Xru/C/X+fMBdc?=
 =?us-ascii?Q?Yr0pyp8BTQ2HxiM1MS2sqRZwD2qDhTXFUzBOq7JedvK8kpj1fwQJFAVrx+SL?=
 =?us-ascii?Q?+ElB6Hvs++fPYkj3QWj4QNk8bPthp5Ygh5Qkyw6s6dpBvN40ifUAeVejiQXS?=
 =?us-ascii?Q?xqYCiEWxdaSJHkjrwQM6O8f6UZ0fra60+OS19uHw6cCUp5evZ43mbLMESvcg?=
 =?us-ascii?Q?Eb0BnVTiePAa7CwYbZ8P8X9CIHUJ1ZVbRwDo9AmGTf6VL5djtyeQ5hlsbF0d?=
 =?us-ascii?Q?wftnDoYn9SR2NcgqZuc7viCUimPRtklFYMVxmnfT7Skfl7N84xdJy2CBvQc0?=
 =?us-ascii?Q?pLPrRfvMZCZYlH2cgXzA+9W7frpc5bl0wuqd+2Nnj+eUcP+xqfDlQ+OTA4Lq?=
 =?us-ascii?Q?5I7Rm7k0x+chhz4hmLyzN49sKjPwj6ZkKFLWfb4ciG3K+uj27f4ySo/tpzT9?=
 =?us-ascii?Q?zPGrIyygezuyl36IH1qgbz99bN0E2N3T8akiIQlrlNqWCwKEioIGItfXskBs?=
 =?us-ascii?Q?hIEGwf040I9WawJ+mnuX+teAf/psR4zxl3Le8mSqVl5d+Eo0i4Xi2IZ7rM5y?=
 =?us-ascii?Q?kzbwXskLNsU7jFzCDCTGQuuQq4EYJenHmsovIb7MNGiSEBF4NnvTXHLx7Ryy?=
 =?us-ascii?Q?NFZ8fXSV7tTk3GZQShhjePSMaGuRmUXUP97zXCBRrwXEzQXpfnSL0p9LA1ar?=
 =?us-ascii?Q?laPmQx8O4WRCvT8Mnek6GE0+6wBjSbeVtmseWYRRLNsiEBrt2LAgjM0CpCJy?=
 =?us-ascii?Q?goy2+vBdst3XxLG6Qms/irkAC62k0Uv2J5EtMO6DyeMCBojQMx6+AKsRR+nV?=
 =?us-ascii?Q?Sqwe5saaIwg1ddkH/MpOlr16RFZuPcoZwIdwcfFb4Fce+BaRptpnQ7x9mfv2?=
 =?us-ascii?Q?/3Xd50rCJ4RDo9BUr0zONCkITQgd5BfcWKb0L+HB+NGQCCxAaMikviandx9Z?=
 =?us-ascii?Q?Q+8VEmBHvJ/nWmWAkwkXPZTc6mxEuHcCFGtCRQ6UYmIijrqfzqMZHrFM8d67?=
 =?us-ascii?Q?U4oP6JQnbldiaKNY8V7qEsddiFEqRrLCsyEvVOhS+7qisibYg6n15OP7d6pC?=
 =?us-ascii?Q?+T2jOirxwvqTRfzHBwK8zJu6ktPnzJMa1G8+/N7dtzCt8F0CTBNuWjgboz/v?=
 =?us-ascii?Q?dOBb/h6IQqD1LhN7BPzI2jJGjTgbmMGyt/JprlE8jXysGuNbS0CMc4ls2GHu?=
 =?us-ascii?Q?9MNqnR8gcLJWDCE0XwvHpJ4rj3qHEI/kJs64GpoYzGkDLfUls4ttkNx9XHEo?=
 =?us-ascii?Q?1wXpuh8P+OfCl9kFtpXzCp6qw7BAhQtGbYVl0MWwNJgtgC6TxElj1/r1P0GJ?=
 =?us-ascii?Q?bM4vm8dEz/8zSuM2GZNc7ViA5ZZzuPElBVoZNqXTW0fSSEkTAb6N1e7rdjZC?=
 =?us-ascii?Q?iO7kGROj5+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gmC7bsUdpPB8JtFj/9AsK+tp5O9cXoD8qjVfSWKfpU05LBMTuryTNKkTJ7aK?=
 =?us-ascii?Q?NH7G+wuTbh1fhJ0B7F8bBQHTCSRG1/p24wBxbfeINXpnsPkzjgmZ+d7+DpjO?=
 =?us-ascii?Q?YeDsYKpNMY4BiLxdYQd922WzWHt4ojO7p4Pekp1AueS6oj4dwczV2+WazNSO?=
 =?us-ascii?Q?4jO2IFNOfL/fnZdBYiqb/ThkrCeTB0rQIrwzlRTGBF+w2Rsqd/KYm4quIlEZ?=
 =?us-ascii?Q?y9a9PAmqrKOjW//N1kK8FJ3ua8QQVJXFRPQmk+XFkwvc+BAYWtZ6FrCudl8B?=
 =?us-ascii?Q?7f1ASF33RwU2OozZQUjrod30zoRVno49yckP0218xeI5KHANUL0YFKuANro8?=
 =?us-ascii?Q?hjRisxiV4YS84heRiZmUT4bZc5mRPVIl3WeI+ELln3EYhMUlUD84zw6xtxLa?=
 =?us-ascii?Q?SSUFxy46Ur3UcCtsEh6ZvqlcS/L1ON/2OLnCDc5Xzs8GyCzQJR8kzysrIcJa?=
 =?us-ascii?Q?3NGbguIbyDvOnfntAQBpiI1xCBpQw8mITfi5ScMChCtXKZ10YUbTRpNxYqas?=
 =?us-ascii?Q?D4rFr1w35j79QZHqHwchTMHu/yztywbxWgYRAcz/pY5o7UjXfW7RcWEwtpRg?=
 =?us-ascii?Q?mkxePOTYe2H42ZeQQ5cLXhpCWIgtRt9M/TsbADsXqxX8ku45vem9LWdUdtJt?=
 =?us-ascii?Q?I5hVMu+clMowjbmnjKOQwVp5/YTl3FeOq85g4I9RAeKqnGKhxmhLalYWIAWr?=
 =?us-ascii?Q?zPvzdz4g8wQ0xNJVOgw/6V0nfZKQ9Oy0QuLm8Wc9ML0FcG0eclhPxxcDhg64?=
 =?us-ascii?Q?M0JNnS6GbpoaDN8EoTafejKkzaZI5Imk9SsMPSZoI/CZkOdGQL6TvswgLbVo?=
 =?us-ascii?Q?a6+G5uP/ObeBuXS2iJtTNzdkM1JylIeqKnyd+uWwW3yUaiWMDaUMXr2HAyol?=
 =?us-ascii?Q?0wDI6lZBV/zhZV6DHPIppwLiRqBQmBz5QbqOG5WC195ShkpYgdi2tlzMrkls?=
 =?us-ascii?Q?xfcMxBduLvDocf2E73auY+wcbhltPsn5OyH++kwsJZ4C7IyCVIOB/j0XlHF2?=
 =?us-ascii?Q?B06p8W9pf4tkSVI+V+hbR3tHSoF9cCtQ3EyuIKMhk/GPfAMsZ7sZhU58NfV3?=
 =?us-ascii?Q?Ea8BDLHUYo/Ut8mBE4TyWAokRwffbOemxT4kWayB23Yet27gfrHAQP76jPAh?=
 =?us-ascii?Q?kYEyNJK5Fq8M+5JRM6RKY1kHDx+5x4eiDZ4vj2IRzM0YDU6svwOvwb5DSjN4?=
 =?us-ascii?Q?ysAyfDV+RXh7xGnflROQWfbBGZVMrmYu0DSwm4evXxkQz/L1vTQOyosArdwT?=
 =?us-ascii?Q?2rkYJc7bXRRCUYJDKdlKQMNvlShu/VD2uGooX3UKtEnviaEnIw56LUzlAPeZ?=
 =?us-ascii?Q?W0OjZtoWSZkfODRRR8eIvc81QoXA5Ox6/8S4jT9CzUFgrR28G3m0+SLF0fI4?=
 =?us-ascii?Q?M81qv2i3RHix6RKds7CAROnGpzLMYJdlKwZ4FPSWciFD3b3qlDRUGWO4F4Me?=
 =?us-ascii?Q?CXvkUFJ+7YRprZyWy9acuvQ8VzBxuuKG0PnFTm/fU6ACck6m2+5SFCBTd3ge?=
 =?us-ascii?Q?8RyX9m6z3etrTdNRuF7unPl0HiqiatbnxuA1QQC6cHIAhlbjqaifZJdNNge+?=
 =?us-ascii?Q?iTXBQKxL3kKH9Ok5cW7i0gXm/ycOLgcWLAwku8r8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eded9e01-677c-4524-9ec3-08dcbba98469
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:06:32.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db9ZPrWTvCww6ahQTRJUBvYxEzGIKBe8H7e9YZu5poLS8rrKCmyOuMGtWuhbFDPQ4pFHoDlJl8FUMfMC2T6BFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10233

Change mdio.yaml nodename match pattern to
	'^mdio(-(bus|external))?(@.+|-([0-9]+))$'

Fix mdio.yaml wrong parser mdio controller's address instead phy's address
when mdio-mux exist.

For example:
mdio-mux-emi1@54 {
	compatible = "mdio-mux-mmioreg", "mdio-mux";

        mdio@20 {
		reg = <0x20>;
		       ^^^ This is mdio controller register

		ethernet-phy@2 {
			reg = <0x2>;
                              ^^^ This phy's address
		};
	};
};

Only phy's address is limited to 31 because MDIO bus definition.

But CHECK_DTBS report below warning:

arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
	mdio@20:reg:0:0: 32 is greater than the maximum of 31

The reason is that "mdio-mux-emi1@54" match "nodename: '^mdio(@.*)?'" in
mdio.yaml.

Change to '^mdio(-(bus|external))?(@.+|-([0-9]+))$' to avoid wrong match
mdio mux controller's node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- use rob's suggest to fix node name pattern.
---
 Documentation/devicetree/bindings/net/mdio.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
index a266ade918ca7..2ed787e4fbbf2 100644
--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -19,7 +19,7 @@ description:
 
 properties:
   $nodename:
-    pattern: "^mdio(@.*)?"
+    pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))$'
 
   "#address-cells":
     const: 1
-- 
2.34.1


