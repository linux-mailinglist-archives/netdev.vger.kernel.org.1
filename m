Return-Path: <netdev+bounces-228565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3383BCE425
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5B724E5EC5
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8EB301022;
	Fri, 10 Oct 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZaijfOck"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEE86323;
	Fri, 10 Oct 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121281; cv=fail; b=k2XWyoQls424pNJ6HVbVFO5L9ZKB2a9JVixFnYZJIFC+r1lSzsbBaLkInzoaWAHagxgMZ63gxOsajuvOYBQQvndTV8LNWE6rrp9HC4dSgxdXmHeDdfG4UStg7Uu1Nl01irQMnwkOsft4l8vgbFgBTQIJYLb0r0nrP1x7hoE1LZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121281; c=relaxed/simple;
	bh=OihoiuIIFvJkjTg6W5628oMDJJVbq/Faq1WMRo1LVVs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mniz5fXvc8f3UbPb6rstxffFWrWH6VZuKTvEmlo5Ea9T4gOgn64bs8ULOGBQExwvjN6o+rMc6NXuv69ENcV+lbgdwi3iFvTSes36JwNHqKS++S9mO1bm/bBYCEnrTeJh1eQm5rYdO3+yizWGO9kWZYcy3NVQFMmLw6deBfdiKiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZaijfOck; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czX+h00vRo2i/27qs0dxPAb2Xi2pNMt5YMBavZnEK6asCBFc31lKuGyJIaY6XBU74iUMm2fawNKNq/PSKVA+vH2Vq7JeMnhKo6yD8k/Uw99Cw1/r7yx/a28Zp2jGO2jtFAvaYqmdPPI75ud3wr4AbnX7gS17hr1RrHeZT6MNq7IAjeGM5Z9kVEssAOCfRBYA6sPvhPc0OJAARNDCT235f/irMGzPSvj4beQv7JnDZ9Z8fS1GXuJu95mT0ig2RxS8MqSjeMx0Vxb3duAHUa7LPCQkAWOEkfvKOwA6N9BW/tcQaAqwGqfcGeMJXkkcmdxpyF5fl0hoorzoGu7JZiPb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBnsojTAZqV77+BUyBvdXgACZNfirnrrn/SN6G+HdSI=;
 b=sPspWJ66L9BOpj5lXGNQBzzuKgyKGIoeuZvCbNKiFJNo3R2BDciV64q0SqwioYn/ufq3MXtASKXA1BbLTJgAhDi1Nso3lUTuRW4vCNpJ4Nnnlv7Gu4W6nBRZHP6s7EqhsHy1p4jwEKQUeYEiOQPZY4laaN6gXckS5py+BcPJnmmpd6oDoYvjT3ZhLCe7Le5TvsRntwRANsJWJkWmd9XQ52dSXgeR7v8QOELpo9yjK4mvkR1kWtoKWtkhrdd3Yn4q+xb9EydUlKRxfEM3qoaSgR7gqnMXeq89QjeJoqRFFHtEP/ki3ZdkYLpCmz9W5f6oEtYlrNnMzJZcqmrH7idm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBnsojTAZqV77+BUyBvdXgACZNfirnrrn/SN6G+HdSI=;
 b=ZaijfOckQuZ79uKiQ6a/HcKfjL3zWEyyFZdCI0XS/UyUYVLsacawDY29YYplBdQL0IoZ8qrnrx0mGiF3tTzZJi+8Sa5UCnkTBDoLlFOdaIb3xpPvPKpJgzXXP2E1gi2Cf6gDmYaBGs8ivBnG2eQ+RiHVMqlvwz5PvZQEKXB7X+1836jibVx4UK8FZ2x//KXmCgVz+FgBB8D3JC/lvBF7aZicg+rupPa4eu2LRjZF3aECwx4SpXmy9YPxOP3QphYNPZ7kExB+wGq2CfA41KQ9YvsJlsJo/r2UlvDTbqCujgOXSRcgjFC3ZNz/o8bOpAyh1jjouOgwICLr6Bo2/64t0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB6783.eurprd04.prod.outlook.com (2603:10a6:803:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 18:34:36 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 18:34:36 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
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
Subject: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional clock
Date: Fri, 10 Oct 2025 14:34:17 -0400
Message-Id: <20251010183418.2179063-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:510:174::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: f289a165-331f-4bc6-8ad2-08de082ba9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZH/gCnKhyyfFtrndCXWYKisaOrJnMdZKtIrG9HwDsjSg59ayEqKxHhwS0Btu?=
 =?us-ascii?Q?5yLLLP+Hw4tnA1aCSQNZQrq8AI8qA5iouJ0rgCnEfhLKsSBkb3f8q3ZG/mpx?=
 =?us-ascii?Q?2l/rKERtHAaMnSDkRvWLvHbb8H9QWU+lK2pe44hQiRPjrBnKuratCMtOz7g5?=
 =?us-ascii?Q?PcTWhc1G4Dt1OYzDAmAJOCePw+Ha1wiRVXk8/+oA8vemKlkGAG0YW+J3c4Jq?=
 =?us-ascii?Q?sBotD9I2uguaErYw8k+ymG9RU3ap9MYDxNecNSvMWTNxHqwI1kqt61uUp0g6?=
 =?us-ascii?Q?IrxnDJf2yYwzuGnWoiYA35W4/ivs0xlb9lJ5CQLXgKjKDizWj+4wn0FYxgll?=
 =?us-ascii?Q?4kxwHOyAxb5i/hyGFL/wbqW1mGHv5TUbuUmjG+nB/01EbGvyxHaPM5RhmhaP?=
 =?us-ascii?Q?7lcXUpqkfiJSP/9uHbPeGHP2uC7KDqP7I5S93f8/V/jBTJuxlc9vh7QuHj27?=
 =?us-ascii?Q?iTSOmS0fz2BPktmG4aBHrCd7bnG7Fhx9YoP9qEm7zUc3mOajGWFR4YREGkaV?=
 =?us-ascii?Q?5d3wSxbmMoUcnmVi1dGWSNi6gttyXw7XJfGpeJpMr5xpntTU1Asp5ftZCBp2?=
 =?us-ascii?Q?4o+yFzAAGIrdaM1Gf9C29aDkk2/EoRdbTQKTzdl6LGfHIc5pbcq2flXk52GJ?=
 =?us-ascii?Q?WjRRjxRoVSDK0qTzhqj67EskBaol9UVmGxvpPZ7yi3DQJh4fmyJPlE1Jdf2E?=
 =?us-ascii?Q?Z3DuS+wPZVCmvk7sObWzKEtjnhUyefr6kQOyMZKJVW8IgJOeGFMnqmPDNLy1?=
 =?us-ascii?Q?Pc3iDQq/dgXToTOE5d30dkGhwsUVVwxctVoiZitzwZ/K0Bj3WZqZ5Hr18uTh?=
 =?us-ascii?Q?ofDldwpOuSPsqxn855dTfSTUJ8PszOMTFQbdIv67uVmqLo68xjN70R4PWOPv?=
 =?us-ascii?Q?NjZqxD+ZKLPkEiyl/2eujOqA1ymUD7Mf1cNrFlAhAhNKqmlWdIfTnxIp4SNg?=
 =?us-ascii?Q?V09RRSKVpG73DdnI9QJAEJe4q7zj4WdX2JjG65dsVIds1wCdRXRWyUZ8HQNc?=
 =?us-ascii?Q?JeGwf5tVuAYDFGQ/vn8TBxh6B3hR03wKuZlv3QVjrKbauvugFPlxI0DkCGwL?=
 =?us-ascii?Q?G1Gc9XM9ETQ6j+19KoYHxb6/gFEuz33ceokca1jfD85BWqFXDRlAzNB5Y1G8?=
 =?us-ascii?Q?7AKIZZQfgmABa4jl3sZyvHJ3bdCNUshD5WEjPzf7NVlKZojKW9CrK4HKjWqZ?=
 =?us-ascii?Q?gVl2xpZHJAsJwqip9odEmijB3z5tmmYoDjRlFsvNNT9/28aQ6QRea1J+Uuq/?=
 =?us-ascii?Q?77m5Rzwx8HKPZuaViK21BU1/yYLgFmc9wy3h6zCVvX9LGMO9Hp4/tmwzZdRl?=
 =?us-ascii?Q?EdXHaZO/Jc5FP7ZE/xSbnvWN6sY9jEuKhTXqQN3yr+xeQRqFO0Npx+Zh0rE7?=
 =?us-ascii?Q?Dadh8O9sMveYl7tEDDEke8SMNqN0MEtYybQldpraVVL77xbLjqdKpOnBMWsv?=
 =?us-ascii?Q?jWgW3iP4nAsoQqcc8Q3TWyCVSgvDA9e4v9D7/a/DQABZrRJjBW+PrYNQE1lU?=
 =?us-ascii?Q?RooFERq806Lv/sEAI/bRTQQHbsCZ0UAZefXHkLm6sV5tzx/LSGTAMZgBiA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O8NdcQlySCqMaIrIn9uKrXt5flyP+bjFYLd0w8FCc/uhe7RB7qqajqCP4sH2?=
 =?us-ascii?Q?zp9X4Bae/Odg88BUsmgU2XHyfQDY6HgyAOSsuLDVB8bL72HtWukcHLyz/plJ?=
 =?us-ascii?Q?4lcr9DqGw4i/4/tG9PuOrf/DdzCKvgog/yDzXYAHuF0f1WHqvC2GaqDoOpd/?=
 =?us-ascii?Q?7Tbxep6mBHJrPJWV9UiW231zzM/Ig3XESjyDmgKMF0FQqo0WZf4DleDp1sA9?=
 =?us-ascii?Q?meCg26ROpXiPiy0LY2zBwcIlt/KTJXFM0Yrkes6qG5XkaXUtL4zafvn5xJr1?=
 =?us-ascii?Q?iN00d9n98fSifKwy2NegSG94I/W0pwxo2y7BtK/izAdEkWfJO8I5KLMKlEfB?=
 =?us-ascii?Q?BlhFl3vWNc8cPoA+GIbuTZEXWe6CIEF5IEvzGutDamQ49sL0VYmQ172S71pJ?=
 =?us-ascii?Q?ltYLCT0rwJt56+KqyqpqEqT0mPdJOqE+eDeYw8wdouMDS+DlX67Pvd1HC8+F?=
 =?us-ascii?Q?ewDHBWjEWYAH1WkvsDW19LE+0HOcWeb6I56bTpzk1XeWdSlYSY7Z0BYtTgbE?=
 =?us-ascii?Q?b6cCPg9CUhCiIxISKRmsmZRN8cdiNTiiPcnPlV4pMgWLlHKvmkF1+izDdkNP?=
 =?us-ascii?Q?cz8c677tiz96DA5rc4Wsw63qvpDX76fkEy80M1k3nbzkalCyQ9elaQhj4B1B?=
 =?us-ascii?Q?vQk/ruzDMb8GXcMlh/caWinZO45nQX29IsO0bVtgz9sIkskgik9gSghRxwxK?=
 =?us-ascii?Q?m3n4NrT4x/FCq3eRJH9tW9o7XTe1X8tyMeLJ/zKVEUTF6nBXmTSxRfqHgJ+1?=
 =?us-ascii?Q?aFmkM01X/bJkRZbF/8764sPYW1Vxyow2Dv2EJTkbmrJpSlwUyt6lBBvor2rf?=
 =?us-ascii?Q?yT25+2j0EefBqwm6kbkafoOZKlCm1fy2Bbvy0CGWijDROYsX2C/IWXDtV89Z?=
 =?us-ascii?Q?2KenzN9a1YNbxqAv5WiU4QW7+m3TxmAYW7Yz25XGsAORCp+mNHIiQzzTX8gr?=
 =?us-ascii?Q?dno5eGvu02/uR5uygK6+hwMEirE4BLTsrO140xii/qtTS2nRbkcd28hPmj/t?=
 =?us-ascii?Q?hEj8bLKAIkO6nt0EnuK8RdcJ9kk5Ge4uifaBYP6uOvbt8KKHGjH8Fh4MauKB?=
 =?us-ascii?Q?UcHJCdtIe73DZiQZppi0hmfgmfSkRCC3tf1/Wt1VuSlSCKHeJes175AYqE4y?=
 =?us-ascii?Q?TI86h0HBgtfDzWvlnsDhsqKzO0I0Cc6DFlyRmirOvqGYUwUvg3FCIKUsIuzs?=
 =?us-ascii?Q?AV9cJ9hstudMcv8OY7MNZebNFtvPglirvRScuezNEwP87YmPNH6VMGk4TNoK?=
 =?us-ascii?Q?C9V+6LEZ3iiz20HU5IMPZFE9qQvqCw0vgEyPTaUD5GohYu14HxDx36OWBCi/?=
 =?us-ascii?Q?jc17zJk5NI/gCYyLzFWbI9qXBiFY1CUJmV/M0HWlZlOG8BIwXppg85kDmtM0?=
 =?us-ascii?Q?7eItcDwBT18fxq/IwMFbTsYRve3XLV3JuaeSg0cMQAdNKiOyG8f2BbBb0Zc2?=
 =?us-ascii?Q?xT91rmzqPC8OSt4DV1dB6UhbL5B7ron8NAa+hLOieVlXeeRpObig+pf6CO1D?=
 =?us-ascii?Q?vbgxDtp7ki8Yc8SbJzC9nzhr8zcm7fZpDiz3r/23yCixewvI7jPzt7TcIWlO?=
 =?us-ascii?Q?ZLNVv2y4URU/k4q/IFEg+FEsL0xEzqpAxzg/fya0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f289a165-331f-4bc6-8ad2-08de082ba9d7
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:34:36.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKTK8f1MZ8p/1QTNWoxybRXZJaLjeUJcGRTuM/XBH+GShD1h+mY63EE8PaMulfaeTtQnmL02j04Ej8+ZTfQTqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6783

Add optional clock for OSC_IN and fix the below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dtb: switch@0 (nxp,sja1105q): Unevaluated properties are not allowed ('clocks' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index e9dd914b0734c..607b7fe8d28ee 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -41,6 +41,9 @@ properties:
       therefore discouraged.
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   spi-cpha: true
   spi-cpol: true
 
-- 
2.34.1


