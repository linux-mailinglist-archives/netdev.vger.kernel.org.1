Return-Path: <netdev+bounces-117570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD50494E57F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 05:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C94B2196D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA04E13BAEE;
	Mon, 12 Aug 2024 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BBIY8R0H"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FAD13B297;
	Mon, 12 Aug 2024 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723432309; cv=fail; b=OwiTw6RX0EJopfm9HLNOGFlb7PUDSUPw8WfFit5gQ4gvK04z72cC9XmZkXly0M3ATYVeDCPbN1KSe/FoGWKUphIAnI+piW34/6dGhxE7Bb56vBMVVZj6+iRxql479ydVW/NKW8jDUr5hawdS+PontZVD3Ps8RvU3WTA1MbzblIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723432309; c=relaxed/simple;
	bh=dfi58LOIvP0m0lUkBrqjb310TsZKdCa5DBB4pN7k1PU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=f9rv4GZlEFlueS6nPy/PnDK32HvEluKfXit51UbzuxnHNfp1T1wvQKw4bpwZ9wf7KCFUxBe9/aaT0bUyEn2Qf10bI5H4nsC4Izyl0UxDjU/dSxDgj7yUR3IuI5RCsZ0Apr5Hw4B3ms/RHgLqpiwNps2L/HrCaUuea29Qn0sM+g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BBIY8R0H; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThDc8zdYkM/LN+hCBQc6gRZVStIShpjxZyFFJI3ZeW2+rjPJ6ifNLytiyy3uFfXW0EYYb6T0+2sRHdRe+cQRYNHL+LNGOQmHzO8VnMRPlXVF+7Zzzq3CFs9j+W0bTQmoiChBxCJKgqZXtdEgHrpRUMNWyPjnnWUyqgAXUsU7hUMrSqiP6v1LwI00Ithw6sYa3WePEMlFh8BfJ6IdpUp/Jxv5UcYBNmjtb6vtkmFLmt6UQYTKTqjP2W4pvNO0g0QrEJSInwLwNSgEovn9nAsBa4y+IJd89yf2IjPZmDqThxmBBduKXlkPbN/UPojle8TbJOGJY71RHeaQvpCAlyvERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d74w2ZQ0vlh2rrCFkKIBvZhj8d3TGk5qXsj28usj5tE=;
 b=DLHNybzwkYHteKFs4uyDOV6VrzAqBKp4KE+4ExmluGP44fF0A4YYBwwetAbTOO9JY7pQk/lAvhsIwBnHZl1hKXE/nog2D8kCLjo7MfeKXCHfJPS5N7CcKoxbyJcCtqMsWXElI0Jcnkz5ndOSNJRoCo1r9OfNOzbtG/tYQjMa3NUhVWUeOtTgSDxA39GbDZWbxxjNtDiMDEesMFRTSnJZi4ZCH9hYlHu6K5Wbar55584dqSfqxTRuAfgrFrox6Vwl3fF4gLqqknBQQajU5330DDMjSll0Aj4DlTFTOGMzB1SQdlIqVbc8OgEBXjh7nFsEEZpVbZLAo04IJQRY0NJtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d74w2ZQ0vlh2rrCFkKIBvZhj8d3TGk5qXsj28usj5tE=;
 b=BBIY8R0HrUO2o2/Eu7RTX+Ccz3NtM13q4G8sEzNypCF0+ZmSdVAMqlF39phNgN906UOSPONanjy4U6s9bxY2dq4Y9clnf2OHzQ4leZamEP4S65XaMzCH0+XwG038h/3d8gMF8vHXIhTwkKc4jWmb8kJjlhWLQriQvluxKALw0txH/77wp7nxv7M69w156WPixODKK9oR2usnQkdRBXKhvO7xUlJnK0FzfQoqhHb/pZZSa1F+7PjweeBs02Aicg07859lKORh4OCJc4p28AzbLLbEngEUUFbpZK6A/RBXA9UNmOmisz6Dy/z9tD/k0LvjrErnyzSENXGZ0gFE+nnuOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7703.eurprd04.prod.outlook.com (2603:10a6:20b:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 03:11:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 03:11:43 +0000
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
Subject: [PATCH 1/1] dt-bindings: net: mdio: Add negative patten match for child node
Date: Sun, 11 Aug 2024 23:11:14 -0400
Message-Id: <20240812031114.3798487-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPXP152CA0011.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103::23)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 36dcf524-9954-40d7-09f1-08dcba7c7e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sWjMpUJpVaEJzcpV7sqDATM4d5QESlBFS3O+IXWPo6vyV1JPEW7d7CCzGPZz?=
 =?us-ascii?Q?K62mSZrQ0GmLfU/BM8GX90atUrelS0sAkLll3/byoEvEyy0TLmZjLTGEH2bS?=
 =?us-ascii?Q?G//JC37Lspy3sFS4el0DDlsL5u/xcuH8/jLZN26AhpSduwyNcHUW+Mqei8da?=
 =?us-ascii?Q?11n6KK2YihXNfXLCQoQ2kZYcK4XipLS7EFpRvsOp/HhFVo7PX0OJg6wASwuD?=
 =?us-ascii?Q?2jowlINwEwaXOUc2PlT//1QSymmIkoME1xxZvVNMaHZ5vqkBaQp0UqUh87MI?=
 =?us-ascii?Q?PlSUgV4aLQN4Wf4MQp7IoJ1F51TOPvuuRsdqwhLZvP9Dr3HvzmZlr2Pz6osR?=
 =?us-ascii?Q?Vu4l20SoaVCesS4OoVFpFUnJyK8m6DOOr0n0QB1WizflOZrsXUYHY/AN8sEW?=
 =?us-ascii?Q?s9CeAYdETPlpQAt9hGBO1+yUp1Qa5u2cPlzAqC4VXZsweNx+PW1TEOagwyED?=
 =?us-ascii?Q?5/BPGCFSk2v7oTUQOlZbr/7mWqqS3Fyb61hnxsKkRAcSUQS+/tY4NbwutSBG?=
 =?us-ascii?Q?3RRrXoujYKuHOYi+c1HeQBl9EKRd2uMeo3prSUcjEUHJT9ZCR7lAIyhxurFT?=
 =?us-ascii?Q?o309jAPu2MxiD98OghinQHAd1i3Kk6Rx+6zN/GdpcsHsMy4ID6bnwm/xo9Kl?=
 =?us-ascii?Q?ToyLJKjcfce1iQJ1HsyeHr66uxTv8ZxndGfvx/aBeQB/Zo4/M5b4hTQj1gWt?=
 =?us-ascii?Q?PzhMIbE0wS6JMiWzoy3RZd2SEZWOGS4iXyhBLAAdPIYRrA/UklqS7k1FETZe?=
 =?us-ascii?Q?erLQaTPBORBJed9cuRraA8r5LDZHyiiaDl4Quu/WQPZY/Ya8X53yqizw/w3h?=
 =?us-ascii?Q?BJQMVkf4LBjdpVjWQoM1Lnbx1BN1ZbQ7Rj2XXn65k0uOUmdcSaavt13woXuG?=
 =?us-ascii?Q?QDq/O3P9VtHqHIIDA7CdfV4k+9dz2B4U/vxYuLQY3wIXjORss9L1sZM/17vK?=
 =?us-ascii?Q?UWnfH3ndkoTi1gequXPdm7+pnc10dG6sKXeHbHBHIxcgQaLsWi3tzAMqRcZV?=
 =?us-ascii?Q?LrSTx1uFS6ZLUhmSUafrUq//THyMqwmyNRsTpn8dWmIln2hniZFla1354YKC?=
 =?us-ascii?Q?ETxUYNLdGUYsQlYGsarnUP1lRfycqSxIbHAotp4sxbUYqjaa0MjdT3lsmEJG?=
 =?us-ascii?Q?1yh4w4AubsEpTYNY23A8Xxd2f1WEUTJ4I05G5i33wjDVsNZZuyNnc3yjavw/?=
 =?us-ascii?Q?6iGuLAF7Yr3JLlCQdtekEbgBDeWDqUtFzFolOQx0NC9Z/y99BufjJjy/L7I3?=
 =?us-ascii?Q?sThKcZdzo+axfy9Ni1qXQTxngvBMAynfqvHOVJn1iurHfNFcUOBNLke/DG6Y?=
 =?us-ascii?Q?+Zdu5ZPo5xZAtQvDAzSkjlboHAJrJaZfOqLyU6+nKVXCW6CaS5xhTvTfQ2AW?=
 =?us-ascii?Q?2NQkk6+V2eTFh3zq/aJ6f3QM77oeJFfzoWtftxCstO+8pTl+MCU5pCyHDWol?=
 =?us-ascii?Q?aF5OXbjP/oA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LsgrQu+6CyDPcAkmJ1IP9t8+pu0U/sbwl4GdppRugjs+FNQNUQzwBselcnp?=
 =?us-ascii?Q?579DN6vDXXuzeE60mq3Qr7jKUJldE4eeOGFpURjXYCimLDhYMLCDXEzt8wMZ?=
 =?us-ascii?Q?0udky5VKotpTc7w1J7H6F1bUuTkK1AXajT+MEa5x/ehUorOlvAoNS5wPZYyn?=
 =?us-ascii?Q?ou8Y/v3rOc8vRy62wD1ZHLwrAr8CM772QpzTueN13zbTzAv8gzoGe7nmaqjn?=
 =?us-ascii?Q?IKctcH0nP2vNoAaboG0XGKjniLBUeN4NQVm+Btl+DOwjDSAbCuJ0cv2oUKJZ?=
 =?us-ascii?Q?/XPaD1lpwjkd0XLLtbgZhT6raDJuj2eJmcvDOJcxrxrisV5kPXm+0mnJafjh?=
 =?us-ascii?Q?DmLV17gT/SqlrtFLv2ZhPnhAUiZ1SDlEliobwk4cMyC5pIs+ATXYzA/9/ugi?=
 =?us-ascii?Q?JeX2cmNILD6+zHn1hC/vfahK/agjWzkgWa8NrdaRNCq+YDxeZH4mUXwMH5YC?=
 =?us-ascii?Q?YocIP/q+5GTTdHay8qIGa+xgCGxH/wOlQfKgBGCm5L0MPVpuBMrz8mZvubB6?=
 =?us-ascii?Q?Evc5EoD5C2rCeaMl8CrFcIX1RzYfunFXthT13NYGdVjb8lUg/Y0BmZVZ1dTb?=
 =?us-ascii?Q?E33zwyBEEwMf/UsBfWBdXJmxTdvBkaYdZFX6BeTBApCqq7LjrOmBEyUwOcsz?=
 =?us-ascii?Q?er1dSWItLGlNTcyn+bk9gpxcxDfBWaRDJWXmQEOP9MF5Uwj4n6rG3ixU7+tD?=
 =?us-ascii?Q?ima1yAYMmgJnUbrufE3sxdtJzpJWooYBng8RP6O1xOvWJOx8iyVQslb9yu4j?=
 =?us-ascii?Q?qYh4LGWWBlnt8E2fghbZ+/AM5X6oNzM7pKncXkqIUrAuyhVBSI3TJvr+A32F?=
 =?us-ascii?Q?wmRfK6X0ZtaUD9YHZpVGmyc9WU1MTf6OplOg5ivqJiVpLLXvIQGvGlCMUfQI?=
 =?us-ascii?Q?6D7u+gJcIwqprHJ7GorogoJgzPeN3rbeo6syDwRHIow6Ny4TL9V+w6F+Nu+C?=
 =?us-ascii?Q?RV6E4cfGrlEWLDvP6GYnTBsqACjkTj1jn3cPhY+XuEVlZSthCAEob/pYLYeE?=
 =?us-ascii?Q?tba45I72680k81X2uJQ5XkE+h2SrvurYI5ZrS1LAwxFeihku0lAej6xXnX7o?=
 =?us-ascii?Q?y36GOYMePo0trklTHIRgJzCC273LlIdmY+RiyISU+3m8hZtodjNoa8znNPWd?=
 =?us-ascii?Q?PQoeMbCdMRQ6ZQYzIquFfZvbujOmgRhQ4hzP9yuuzeaw3jf2bd0m3zoIg+xa?=
 =?us-ascii?Q?dGqAI7HpA5YilSVLP+YCs9QszDr6buHxH4YcGp/r6Z80/XoIr8n8oij3wcRQ?=
 =?us-ascii?Q?UQMNPtaNPyINr5g5fjgXvrupbehY0wFI82sumawYidFdMNFUxoXRGiSXA1Dp?=
 =?us-ascii?Q?XGXr/r2TP1YU/oTj+OEgxo4o9GQyGE4SdRmvoIK3YES8XeQNX99/kOHo0dXd?=
 =?us-ascii?Q?Gq+iKes0suQwaYNsOIOTmWfoAjE+i/6a0CF0j67GxVs9SKIS0IwGdFUwMsbX?=
 =?us-ascii?Q?gV1e06cuFGClRkW250oUvwzoQis30IcgtAPL5UM7PjdjJej1B/KD+LcPIm33?=
 =?us-ascii?Q?XpwNMv/DQPqvA05HQbKZPOKJuQgPRSNHZZMyNCoOmB5JkqmvlJIHg+Q2TQzq?=
 =?us-ascii?Q?76b9DYzZqNgWmuz8O+zPTdXcxHxobFyRU74yRzyX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dcf524-9954-40d7-09f1-08dcba7c7e2e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 03:11:43.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovopvwSoMaWJF7shxwiVN2UXS2Aq1I+BQkYy3Pxl8HChbDIIDAFaHKwR22AH+KqMGWnuMSnz72qeTYRjRMzF+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7703

mdio.yaml wrong parser mdio controller's address instead phy's address when
mdio-mux exist.

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

Only phy's address is limited to 31 because MDIO bus defination.

But CHECK_DTBS report below warning:

arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
	mdio@20:reg:0:0: 32 is greater than the maximum of 31

The reason is that "mdio@20" match "patternProperties: '@[0-9a-f]+$'" in
mdio.yaml.

Change to '^(?!mdio@).*@[0-9a-f]+$' to avoid match parent's mdio
controller's address.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/mdio.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
index a266ade918ca7..a7def3eb4674d 100644
--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -59,7 +59,7 @@ properties:
     type: boolean
 
 patternProperties:
-  '@[0-9a-f]+$':
+  '^(?!mdio@).*@[0-9a-f]+$':
     type: object
 
     properties:
-- 
2.34.1


