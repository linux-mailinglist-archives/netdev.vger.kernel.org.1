Return-Path: <netdev+bounces-212859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C2B22452
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D5F1B646F3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE732EFD8F;
	Tue, 12 Aug 2025 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mvmkkYVa"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB422EF67D;
	Tue, 12 Aug 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993325; cv=fail; b=hqI2/qOIt17JZk+Jb54Rm4HtHX8W/PMDlxIVQG6htWB30PySATwFNmrp9Egh+/acDrz6I3qMb6EOgD0CWvnpsLYFf1M4vFolgU1EFYzFUQWspuDN+OGCPjJ44bEt1V90v1K8nR98PbS6IcKf66Rv7PMR7098rm1lcgFDYOqr7Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993325; c=relaxed/simple;
	bh=kG7yXUTz+Q92op4trNC+7350u9SXRuYLIaG7fyW9uf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AS9d/0/sVSixknfBPyUWDTfgWcQ86/FX+fFfLgMYcCRCbF4dQ1k5DuImDqUnB/BkHdjbBnwykI9lv7OZDPBqc/TOLYWNHdO5ViuMBli1RvVbswbCYfpssX8Q+OmdlH/rLfrY22wy7dQhnQdSqikmONsvbqnBppSGrPtegv3uJBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mvmkkYVa; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhMPdacs2nBGRhw8WciwJvRnaCI7xbpycP3y+UoiP9p0h7cRXqJzPlgw5qQUSCErx4mKc+l3zwGjNMLZUpUG8ByEOKr0K3oCAlcy0IzUFV82LJdNIWbgLIYehpX+JeBBMpe8XbFJ6sezqLkdTtSE0ClVZ7G5/5sqpJF5l/GXh1QarxsippF1vpcdd9DZn5UTDsrVL/bU3e2VotY8bW0cRL2KlC+0NreOlr4Fac2TZ/pO1/JUqIGO3OKLRwLYDEYoJ4cdLTu/fgebQtegncPk7HZV22lUgXXu46HoBJ5T39QAFTCboL6LFEQpRUob6aP2MTwCtanBgw5Z3UXPC9k9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YHvY2nwH7r3JHSNqfjCQyRf+qOExakXuQNsF+yP0wo=;
 b=keRGcmJgsEiakGcIG2PLDMieLmp9pK4F5TddOSCOVPlw7kw+8DG2/VNYXI7LTiWITt8bTw8Gv8Cs/q1iCStpdH+HFQQKWX5/SUGslPDiHAEdWq5fnllNtpofdcGvNnLXzndOe4dMiArE7CvwioSqLSCgajXd4yy3mqzx1QkVLTNO3zQ1x5OEMemfT6OEd/es56rUtVAA1cyojyMGy6npadsDKM7+dRs15sfHkT/yd+D0NsiNhua3Xw0uqmigydgIUSc8i0oMdX90e56fct+dyglATJDTraBCTjzX3LwCvXQkkiZvioNlPp3XsZLPMDf4YfniR2/n6lHSRiKUXnRLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YHvY2nwH7r3JHSNqfjCQyRf+qOExakXuQNsF+yP0wo=;
 b=mvmkkYVaf1dJRrse41gCtfEa+ZmVxS2INIpd/gtjEjKavgusg7USPWoSAh2e4BmZ+NEGIwI9RAwmmIPOyRf6++vE5ggQRVXAX2hSynT8rdVTFgn0N9jAfcaql3nKWBbnWX/70ZpoGZAMT6XfcwSPeozoZb2BtVIaqsCvjzRPH2oIIOiKRLZBVlJfXbbe4SR4tt5MXZZTSDMAfHDrwbm6oY+DomdZDmvXVBb5PlKLbDjb8M5ybSMlnYZNNCmJerL4PuISQTdQzaGx6cN5JJiLgBJYSVADmP+FZ6o/XrnaWQAeT8E/e4FjQoNM4QLNdDznEPl6aEq3xbZUl//6YQs0+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 10:08:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:08:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 15/15] arm64: dts: imx95: add standard PCI device compatible string to NETC Timer
Date: Tue, 12 Aug 2025 17:46:34 +0800
Message-Id: <20250812094634.489901-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c18e8f3-8fe8-4bf0-57f4-08ddd98836ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z7wEEuV5LpGYoj159gXHYzvQAKpGqS7IP2mvLLXCGbzohYeh8GVJ+ocAAA8h?=
 =?us-ascii?Q?YCKQ6UW6SJh0KgI02/xMnHrXjnDP+aK7pEgF/jOr7bMNwhFPXsjXWQSY7uVj?=
 =?us-ascii?Q?T1NmAl74SolTJ8hSQRd8p4qvUl+EDZbwyzwzSKPKvCprDvcqKMUWBlpzzFYs?=
 =?us-ascii?Q?mWfGBC7cn3SiXFdif45PNRjK79Vnw+lWMTG6q2KSvu8IWS2kZSDncGdDsJ8Q?=
 =?us-ascii?Q?x0Nj74/86n/Gkd8NHfq19btnyTOKfuVBiOQtnF1N4tc7WQXzCgrmYsgouS32?=
 =?us-ascii?Q?KYtFTBKRaCjWYpjxduCOEcDAOpQJy8dm/xM5ZWboEmjrHB+yJgKJME89ORXL?=
 =?us-ascii?Q?g61KYJyb9HPgasujpR6N7b9eiTb9V4BjK40zPU1nl3xQhrsevGikOxhlKtQi?=
 =?us-ascii?Q?uAHNPUPNvEp/nVCUoFUNbZr2ilKYC2MkqySoGd1zqlRMwJ2vqniA20THF4jr?=
 =?us-ascii?Q?nbkjcYO2atDgdFXGrkkGVvcmOC3rnSo4BVRvc1Y1s3wNYImB09hZqGbbzARl?=
 =?us-ascii?Q?RyYnAOflQDpytnDP+2zEwyNBlTpEKPWbHZspn9e6dopNkdEDj55olN+oOiLS?=
 =?us-ascii?Q?nJ3XYe5V7zV5xrDc5TdSKWwWxf2N+LUEVvlUbVoKohkYdSMT4v+EuUHZ5m6J?=
 =?us-ascii?Q?whLenbJRoa8ITleYfWOjZqasNhRVd9CLF+CW+8FW1cc25TxJoolw/j/hWar2?=
 =?us-ascii?Q?YDMmA+vjFsh5CQOXSauyaYp9IabmXzfNn0sEBNHUwtOtrPFuQu2ek+8hj2pF?=
 =?us-ascii?Q?Xzmq7bjv4WUWDp/qpX/MIRGrJ0luW8yOQl5+iqABNXMYqqYtA7FeDlVtHNI0?=
 =?us-ascii?Q?HeB9eZe1yZeYQhbvD9CoHl01wkNXBw4KEYcGE3VhccnJAEUem4BurEN+c/Gd?=
 =?us-ascii?Q?8gN4d6F0hwqPM/7prVuMO1SY95yXpsNKZUc3qF9Hy2Llzj0iF7RHdB4o8xF3?=
 =?us-ascii?Q?TBDAT+T/85Gz+mu/ja0F/8URUNcj020P0Gzk3eg4FkZiR5ZgJcAhbgUJoycS?=
 =?us-ascii?Q?43dr3wFtHvJJYymfVyAQLfrSdFp0o0cK7FOrn2AVHSOvWPfqS5Ovec+Y2lEY?=
 =?us-ascii?Q?c7+K/5YiuJMNaOcSJIoMA3Lhme7v77GA8IHbFVrZt8R3jfPn1K7IFr/4encX?=
 =?us-ascii?Q?yQS/C8mOQItu07lgb093Ma6AhOZgWl3NPzzIS4+ZbN8cZejsVRJ3UnfeffBI?=
 =?us-ascii?Q?oGJcDh+Um5b0EIWsvV2nJ5VIyHLnUvpqaDP/hUcQcLyMcfqvS4A3gs9Ii7PZ?=
 =?us-ascii?Q?c1Jt1cSAQIhlzWhqPeTQnQTMWPSOnOx/+6delHBRMILczJuc3mOArbQPWsjb?=
 =?us-ascii?Q?SBl+iHoptXgM4cUN9MvFlr/8hl4Ap10yJKYb8+5rZpB5959+OFg1kfrgIVPd?=
 =?us-ascii?Q?Ndy77eFXKcW8sZgc0EcT62BQ6h1oav0M8p1X86+6bG5C7gE6dcvnD+RYnlWF?=
 =?us-ascii?Q?VddX8jCbYfpndRdXYwrn05x/fRtDqeFBfpagj6QpQLEHPwrPhquq73pQ5jQq?=
 =?us-ascii?Q?KqqJ4gDdFTIPG/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Inwgs3FoqjAMDBNEffJIjatoXx11SkAjCkd+3k4WMfqnvPUtIQAv1Ua7Q1I?=
 =?us-ascii?Q?D8VYUxYsfF6DBhgXRd3z4eHrr9nBWUuFihyugllm20mEkcOTY5JgYR9iIvDc?=
 =?us-ascii?Q?i4/rM/NQJyIot3KgK6I2y4zar6Ae4tHgZH56/UFT2V9i75iP4O3EaiMoA8ue?=
 =?us-ascii?Q?/R4xpOpiZvisoD8vxntPPuHjEXd0npyvqbxFeA8HYt5L5mAxWil8kN+YptJY?=
 =?us-ascii?Q?PvOdcQQX7zdABlKUmhCuc4trux0I6z2hM2KWoV9PckypHYqFyN9pJl4FBpEr?=
 =?us-ascii?Q?R/s7l1lcwvq1zBVqvuRVHGFUqu7B97MZ6VNXWvKTEY3iPbKCEzBYU+WCGfwD?=
 =?us-ascii?Q?83d++cyb6JuTU6NEOWzEE0DXD3q/v+heFtsjurIIYr6+zh/GRGNPzBQJB4fW?=
 =?us-ascii?Q?qjWO7h/E+lISC+kF+MP7DNHRa2WNSponhSuWnXxytaPj48seA+rXUbsTTJov?=
 =?us-ascii?Q?iET7cohOvbBFdetWYG/dEJqKS9S2n64mzIxkWW8XVkkw0bTUlPtD41UoUe3J?=
 =?us-ascii?Q?0qVSXfUaXIAEgKo5QRTkoztwBJjc8/NfR5IR8BHQAnsB56Fw0xgHNFYdXPiu?=
 =?us-ascii?Q?jnPwL6DXKw5Oano5wkcvoOuRW4+9IC9XZM+GeZgbX59xrVBgSsxngp7qmQIA?=
 =?us-ascii?Q?KCt2VeClawlThe4BtuZo65LK+avZvfhgRUTOaRzEcmo7zjASQLK5zX5BhjsK?=
 =?us-ascii?Q?vF1jUNLXg6OyDrSi5XpLOvDT44v9SqnpnQRoYOITWKtygrq8ahsW7MmnO6tg?=
 =?us-ascii?Q?n2iwltcw6vEepUTsyrHWnPMKoHacn5VmQRIS1SCYs+Drofh7YDVEHbyYFLwj?=
 =?us-ascii?Q?+OFxu0IqrsldZ0i9Y9/omJDhSs+Z3GVjH7zNN4QfTx5WvdwTTPEIBIzGBFmt?=
 =?us-ascii?Q?CPlmca9Y5KGuNTYiPCcuFLbnmgeXHflxnCyWgARdYuzOoKLuvkyQwSlf4kKT?=
 =?us-ascii?Q?+GQcNHRfnlM09kq0b1fsL21h9Up21tDPAvjTD9guYC5vuLcONUUhTPntNBdK?=
 =?us-ascii?Q?5S7AchWToQ7TI3r46zzv6oKo62ygck1uEx+yC6LnBsA+8ZQ7NC/UwuERuZaT?=
 =?us-ascii?Q?jPy83vRi73kM/DYnvI+1sa/+SbzQJF+x8zwekgIgpCiB2167/Wq5f3Kj4ylQ?=
 =?us-ascii?Q?GYZ7eYfXhrT8py1URqt7VkHIqzagvTQ0RH4k0FoNMQFqWjdb6wkuUl1dGwdZ?=
 =?us-ascii?Q?Tib2S6JmVA98E5n5U3M/HnN5Oktk6+cHgOMpHjUwvV3VufXeJU9sA5rYaRUK?=
 =?us-ascii?Q?PE5OhtqdJcITyhvoI1xtsPPtMmoB3wwvWZ5JkspeBFkXnm4T5sjOHyu0+6nO?=
 =?us-ascii?Q?TdgqFWJeDPKM+fzXtRxg4ItBoFovf3j5FVxqoLW5c6gSoxzzsqgnY/5ZWDKl?=
 =?us-ascii?Q?Ja5tGsV85zqbqM/ipODDbeBznog5FWvPRnspYhrzzmzWyjei7qYTQlQK6iSj?=
 =?us-ascii?Q?60mt1jXjyb5uLJAnFfMvk5d2y3PJIEU0TIaTVSQO4T8teLKXkdCO4yKv7Cge?=
 =?us-ascii?Q?kXhFB/Fqmlzs2K9uSi4qVNLckoMnv1Vd1nuzRrd2cvZdwTpdMTLUmuF3L/Yw?=
 =?us-ascii?Q?E4kHUJe1EB5Y0o6EgVCYeGgULPhSf09u9y3Rj4dX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c18e8f3-8fe8-4bf0-57f4-08ddd98836ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:08:41.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQFmEm/0qmhZwIHruAWQjfu9EnTt66t5UzOckqBCYoaEUDMpzEH1H19Pk8ZxtS5d/1EK/5cFQU2DY8dFkt03hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

PCI devices should have a compatible string based on the vendor and
device IDs. So add this compatible string to NETC Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
new patch
v3 changes:
Since the commit 02b7adb791e1 ("arm64: dts: imx95-19x19-evk: add adc0
flexcan[1,2] i2c[2,3] uart5 spi3 and tpm3") has enabled NETC Timer, so
rebase this patch and change the title and commit message.
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 4ca6a7ea586e..605f14d8fa25 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1948,6 +1948,7 @@ enetc_port2: ethernet@10,0 {
 				};
 
 				netc_timer: ethernet@18,0 {
+					compatible = "pci1131,ee02";
 					reg = <0x00c000 0 0 0 0>;
 					status = "disabled";
 				};
-- 
2.34.1


