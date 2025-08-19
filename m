Return-Path: <netdev+bounces-214961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F8B2C4A2
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4E55A6E7B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5513469FC;
	Tue, 19 Aug 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="APdQVdDe"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC15345752;
	Tue, 19 Aug 2025 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608396; cv=fail; b=ICM+7UwjeTmJ+fBoOX9ftFH/U6sTzRC9+FjR9/Xd8o6tBWcNbbIoA2U89fR9xiitItPfgVFJsrhz0NEbiuiQSylpxXd6y/MGsQNV5OHOMNisXGRqV3RbiI866we/F/6tPN1cZWMdnFD0mo1YJ/bQABASwSHx+BZZVIiji66W3zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608396; c=relaxed/simple;
	bh=9WfB/zpdK+MdBgpNinUaRZ6ciY0fSG50yv0zX2goQd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyNud2dm7pSiAMlbuXOMnLk5AFTCFnakX0uDMvZQD4I7qhvE3GxeSVloKiLIpuZVnX/DBJ9YxaVQSJnFwijKhJzwztsdZGEJyqoOapsWg7uU0UDSVgbAmmIGGbosV67zroD/E2o004Fl8duZzNihHd7ICvOwhibsaUKbN22zVjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=APdQVdDe; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/GlODwBQM3BhkXKUQFsk0GZsHtSbzN7ChWnj0w+Q78VBhinEcDOw1rgWvIlQopNA2SOyTvdkaqhAnH4+whuF8DQcec1Kk8vwvT05DziTwMvXeyVkQgsT5INH0RXIeleElfvHNtMhsKGdFQ6zU+515HgaVg9aZIJmIfXTNO5cylg8YDkD6bIX6ssQSJxfnEbc4xbvJ7oSHZ2YsuOgh8EIiuMiV5XnEtSHh348kgYTsZTSTt/FLUf+StMz1zXgjWJfVQ/U7L5ZZq6pBKkRylwM3Vss2FGAmlTucxAcOHIfHbFLwaMQ0f++G1DoEEsIldJ5qTFx7Ul8L77lCHghzD2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t29R4jDlvRBr0iCYU4UyTeCniGcNPftse1Y58GAm+cM=;
 b=PU7XOAcrcVGAsf8RHOmg77/+Pk32XHALoxsvB++jqntYQDUn0q2r+7Yn2AvC77Mo9Enp5FbrsuB8uZNH15haJ/NA1gA/iKzvES09X3o9lp4W/ynZcmFWhAIP+OcYAjrvVfF8Gx7L/ls/qbkUYYWzshagaC5zt44DdHSgZV+yL4HNRfCUcXjCFgfGvpJejcxedVw0Cebo1tyvuFP0S2mq9JWuOKUInh7uRWI9j3fFNPkDCVeATsXSnV1lyJrxud+01KT4QA0aqfDiLgPgYgx/+RhRw7jNYXfI86yOmpvmy1/cav+gC105Wdcoq/8yUOX+3Q8E3VuUO7rui3wIzJweLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t29R4jDlvRBr0iCYU4UyTeCniGcNPftse1Y58GAm+cM=;
 b=APdQVdDeuofZRGbWY3h2u1TxMvbtDE52zYOHXqVGFpzyVeQt/FHXZOuKjB9q1Y/IUju5WAi1mA+R7p7RCUH0jmyYhv69nO8MeAHTWZQYGfbQdIV8pKewdt1KM+bfJl5vnaM+BruYdow/Qm5+J6reDNZLjXB5Hy0xNB9VmGJ/MoC+hcQl3Tenh/kTab/+6nZf8NmDe6hks46ipHMpGbRzG/3+h9LB+0na/ysbZJPniM0wIXsDGeQMIu1AheeNjLbZbWFUzb/3j41S82ug6lQ6EpOac2T9T4Y7XXG7IVj0Dt5ZVVHIrAkFhia9BCgeHmDH6CxnhQ6V64/YVstZ0WXSCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 12:59:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:59:30 +0000
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
Subject: [PATCH v4 net-next 11/15] net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync packets
Date: Tue, 19 Aug 2025 20:36:16 +0800
Message-Id: <20250819123620.916637-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bcf68f-84ff-45ed-61d1-08dddf203bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?buKiHsHBF5+iz6t20bbo5hWsiZhIWjUSIRyf/wDWDdSBPOYe1u2Wla1Ie8HP?=
 =?us-ascii?Q?ClM5+KcKn77MW2yFA1U3f2kkXMcN/uj/YEQB8ZHTt+YLSKR8sKyMIaDqaBPl?=
 =?us-ascii?Q?ffIA4vP3/ZBJ39ADU1dA3u4VVQeb6kUHzCJo+ZadcwIx6qzRsmMzHVaERwTG?=
 =?us-ascii?Q?FEHVXXcWCEO0FmO7PPm5B532EddPUJF4Wef5jazZOwsC7XJy3MUP+pPybT0P?=
 =?us-ascii?Q?lacq39EhNLrslDmsraB5Yya+JVSL3k6vniLcVkzvcPnD/fBpdQRiAyMnQclz?=
 =?us-ascii?Q?b80lhIgqvsmqHtyHtGqZDbNaD+puH2I7cPJGeR2RLDbiShSzc9+B6B362cix?=
 =?us-ascii?Q?d90rNlBXzxD+DlcWrk76vsyrYJBz0NmoDcXAL9oiM8fNrF3VYq88G8yMbkEz?=
 =?us-ascii?Q?XEWIiwLJvhlbCAu3ygjr47DoJX+Ltu242QRtJDf/o07NxYLoOB2e01fhEY3U?=
 =?us-ascii?Q?A++g/sJTmSZtakRZGrFv5wvlQ9K9F7sf8oL3fHeb2yjVr31qoMes/LupX0pC?=
 =?us-ascii?Q?32flmQ7F/vKON2FfeYIVzZrW2matoXcY8hNYz5Br+YDoK66/G/luZXt6IvIq?=
 =?us-ascii?Q?Jyfr3FqYNkLF35mqb71ZXTFRlncuBJiq0CvpzYBhuxkALc8Fc7M5/zEJCb7D?=
 =?us-ascii?Q?SlA1zT7w06vCu9x9gpQpVpiI1y8O5dxK/iRSZKpXntp1ruEQgNhjEg07vpga?=
 =?us-ascii?Q?/2XzKelRv/VNzZrCTcPWrahJjdb4XCAd39hjWFE2CGh/y0QzDlPCKCtornIp?=
 =?us-ascii?Q?VJEr4fYhBCayDsBU/+c4gpz25VeaxT4PaG6fm6PA+BK1dhzx31iduGqWiH2h?=
 =?us-ascii?Q?gBF41Yxs10FdyYA4sRUROBmPKi4EAVjRs/Q9WD3d3/hTnTy5S/V8RPNXE1Yt?=
 =?us-ascii?Q?oYggPELJ7hAfpdu30EM15hbSGbJqh+7U8s6G/bKz3DRGbZQo18xU2yFO33lL?=
 =?us-ascii?Q?KUYpx6Op5qGDljub1jBBXCKeCpw3lpAi0U2+grU24hwb/gltE4oPQVcVAHxy?=
 =?us-ascii?Q?N46G9k9+uWa5muae1jKqjOHwQSHotQRXxFcENmpBV7UkcGAXblAV6Zq+ZBuq?=
 =?us-ascii?Q?sAqGnzoez6gQpmOF8JbKiPKkUYADezxNhFzVk/i4PelyB0lDN9v8UreQwW5X?=
 =?us-ascii?Q?qxTPrkEVqExsz43nc90CEZv2NNA+2zD/ENrLYCsJemEb4klXp7dpxIvoXaef?=
 =?us-ascii?Q?9hj0kSLA/BcwIRh1J07nhNUisnwlBpF7acuPcrJBxsGtr6o1yj+9m3BoUeCs?=
 =?us-ascii?Q?2qo4xbI0BVwST8oGsplDaYnaRkCSchxNqsAw6aohI+Pt/mfumJuUgahGKPcq?=
 =?us-ascii?Q?gKpcEM24K/cyoGlVeexMxUNP/yZWAZTs2wUblk/O9hgUBEhNiv20xLdiRBaa?=
 =?us-ascii?Q?6mUQKpcES+JWHYCE8KVU3s02546iNiAPfp6KaY2pbBpXqJivreWHSmz229mh?=
 =?us-ascii?Q?hyzt5prYdD5OLajYlN2TLuHze83/wXBJMBOJnBM70nGihIEQxvwjWn0tQdhz?=
 =?us-ascii?Q?q9zjQPHwR1+HN7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IMohlzqhYdhmO166ZPVqvSR8kAJkxSe/AIsFlnQcDc9ctdDpXyRjnFsI9/ou?=
 =?us-ascii?Q?uWCiUFwCXrJxJM0IUmoUB13h92wBpFrFRTjtkpa5gTOWDDn0KuQ6BdueXUKh?=
 =?us-ascii?Q?20gGFDxuHjwrblGkEohMNDz9FG2Dzak7wYIJgLEUJU4j1SNpcRUxxBbHIN14?=
 =?us-ascii?Q?PynrVshOBRdry/Fd1pXSFk1riyrdGoPUYBPV0EJAgpf2VrlXUniMP2KuPfFs?=
 =?us-ascii?Q?PUPfTfcswlukzR9S7fHISNXpTP4KHnlX2IlX85m8093dJBNuwusR4UlP5I7o?=
 =?us-ascii?Q?CCwIdkiQkNPKP56oxE7KUcX2UQegFIPH1jsW/c0RGblHa7A3a7wn2JTEnXRD?=
 =?us-ascii?Q?A0KCtq/8Ieg7hbl3qpC61xAGZvT7x1j4wmSuxPgdlHG4zyA8cF+h4kcq9Vox?=
 =?us-ascii?Q?DK0jui8QqG3l0tlfWwLlav0CHGCVXyxbDjICOXwKteRp5HPw63Igx8SQkfRG?=
 =?us-ascii?Q?zTuyr0ksHucO1mZyz7n44mm4R+Uvglvq9owtzEacNUYE/Y3WCYe0AnGu6gKI?=
 =?us-ascii?Q?S3r1OPnIPpazmfQ3rtXq0JqLdKxjPQJvW4EU6uz7KT+WglgusYGw1CjgDhnm?=
 =?us-ascii?Q?asA9uYjwWtHMkBqT8knPvfTOvYIU44LWcHUvcwrqAcy1yfWcnW5cQ/1Xqv54?=
 =?us-ascii?Q?IvQhPGj/u7zkkFSY+jBJ1M+LiLcPVl5m2oWJe33Fhkv+HTUsgggVmZY5ZSqr?=
 =?us-ascii?Q?9oB0MyHzfVs1/AZo/2MOzp7PXdonki3QCDC2Bs9QZQXzL2OyUJiFbyZTPJWa?=
 =?us-ascii?Q?R/RGHNxDuEGFsBP+A8QT8oMFM6R3LKOV9Z7kQl1VbJDHbUARA5I9Rdx8JHVx?=
 =?us-ascii?Q?cLEFBbTV9HiVQPClifBAekZvsBnGf+X8dZ89W07kcabRih6634zOmDsHZS6P?=
 =?us-ascii?Q?RnjfR5V+WB2zSRssSkX/lnqifL4zluVqrZ6FYRFCnJlL1LedGjD53loFCImm?=
 =?us-ascii?Q?ATOG9Twy9J0418Ry8PXfegxAKAPV3RbF9I4qfX8V9zYuctNOgxhIE29px09F?=
 =?us-ascii?Q?ayhXrQyJdz8EtZlbyQV+Wj78hYpcQy4GPTgM10hHiP+gSJKgYefSaGld3mxM?=
 =?us-ascii?Q?8xhc7SCMOYscU615w4LJ96SCYygy9mP/BOum3hCpL4Iph3A43ML6B36qkzt8?=
 =?us-ascii?Q?51tJzvF/oJ2rELhXSpHtx1AonbMtY1Ecm6tSr79XCgmjj+JhDqcHWImA2VV6?=
 =?us-ascii?Q?n79psHPODDS56PQkKVOcbLRA73EwUUQsMF+VH/niWb6c1uVPQ7i40L37lyP+?=
 =?us-ascii?Q?qSjd9zrMWWfeEujM5ta5E0PcoQh5w5pRfY/OdwbE79qPxuDXkpZp6hdt68VI?=
 =?us-ascii?Q?e7qKGsgZB8B+fnyFmniFTQs0eOutZm28jpkrFDeGaiYXAph9XRFy6gsq0FHA?=
 =?us-ascii?Q?InNbePzEy5KfjiXwjQqlIVVuCYpNZbi0TyICSrwL/HRGoj+mKhwm39DsxJK7?=
 =?us-ascii?Q?J6NEsEriLdtoZrvcagGlmRC2ORqnmDyuwk7L6owIJin3YZDQspS+U3otzidq?=
 =?us-ascii?Q?yIf5ld92QcLlfsQxBBqIF/EgqW5wx0tSZsdSsh6521N7MZB2ksFWfUry8PyR?=
 =?us-ascii?Q?bZT7MHWIzGwyih28vLwDLISBQu+jOg8C0WoO3xIq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bcf68f-84ff-45ed-61d1-08dddf203bfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:59:29.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3Y8m59qsWCDI6gw6ZKrL9/zG8dy8Nv0TjHc/Ka3fpUsf4PaPz27o+iSBuzKibpuYXmgoe2G3L50cg4wHFxkQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

Move PTP Sync packet processing from enetc_map_tx_buffs() to a new helper
function enetc_update_ptp_sync_msg() to simplify the original function.
Prepare for upcoming ENETC v4 one-step support. There is no functional
change. It is worth mentioning that ENETC_TXBD_TSTAMP is added to replace
0x3fffffff.

Prepare for upcoming ENETC v4 one-step support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2: no changes
v3: Change the subject and improve the commit message
v4: Add ENETC_TXBD_TSTAMP to the commit message
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 2 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 54ccd7c57961..ef002ed2fdb9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
+				     struct sk_buff *skb)
+{
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+	u16 tstamp_off = enetc_cb->origin_tstamp_off;
+	u16 corr_off = enetc_cb->correction_off;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+	__be32 new_sec_l, new_nsec;
+	__be16 new_sec_h;
+	u32 lo, hi, nsec;
+	u8 *data;
+	u64 sec;
+	u32 val;
+
+	lo = enetc_rd_hot(hw, ENETC_SICTR0);
+	hi = enetc_rd_hot(hw, ENETC_SICTR1);
+	sec = (u64)hi << 32 | lo;
+	nsec = do_div(sec, 1000000000);
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanseconds field
+	 *
+	 * In addition, the UDP checksum needs to be updated
+	 * by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong
+	 * checksum when updating the correction field and
+	 * update it to the packet.
+	 */
+
+	data = skb_mac_header(skb);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_nsec = htonl(nsec);
+	if (enetc_cb->udp) {
+		struct udphdr *uh = udp_hdr(skb);
+		__be32 old_sec_l, old_nsec;
+		__be16 old_sec_h;
+
+		old_sec_h = *(__be16 *)(data + tstamp_off);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+
+		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+
+		old_nsec = *(__be32 *)(data + tstamp_off + 6);
+		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+					 new_nsec, false);
+	}
+
+	*(__be16 *)(data + tstamp_off) = new_sec_h;
+	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
+
+	/* Configure single-step register */
+	val = ENETC_PM0_SINGLE_STEP_EN;
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+	if (enetc_cb->udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+
+	return lo & ENETC_TXBD_TSTAMP;
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
@@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u16 tstamp_off = enetc_cb->origin_tstamp_off;
-			u16 corr_off = enetc_cb->correction_off;
-			__be32 new_sec_l, new_nsec;
-			u32 lo, hi, nsec, val;
-			__be16 new_sec_h;
-			u8 *data;
-			u64 sec;
-
-			lo = enetc_rd_hot(hw, ENETC_SICTR0);
-			hi = enetc_rd_hot(hw, ENETC_SICTR1);
-			sec = (u64)hi << 32 | lo;
-			nsec = do_div(sec, 1000000000);
+			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
 
 			/* Configure extension BD */
-			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
+			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
-
-			/* Update originTimestamp field of Sync packet
-			 * - 48 bits seconds field
-			 * - 32 bits nanseconds field
-			 *
-			 * In addition, the UDP checksum needs to be updated
-			 * by software after updating originTimestamp field,
-			 * otherwise the hardware will calculate the wrong
-			 * checksum when updating the correction field and
-			 * update it to the packet.
-			 */
-			data = skb_mac_header(skb);
-			new_sec_h = htons((sec >> 32) & 0xffff);
-			new_sec_l = htonl(sec & 0xffffffff);
-			new_nsec = htonl(nsec);
-			if (enetc_cb->udp) {
-				struct udphdr *uh = udp_hdr(skb);
-				__be32 old_sec_l, old_nsec;
-				__be16 old_sec_h;
-
-				old_sec_h = *(__be16 *)(data + tstamp_off);
-				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
-							 new_sec_h, false);
-
-				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
-				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
-							 new_sec_l, false);
-
-				old_nsec = *(__be32 *)(data + tstamp_off + 6);
-				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
-							 new_nsec, false);
-			}
-
-			*(__be16 *)(data + tstamp_off) = new_sec_h;
-			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
-			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
-
-			/* Configure single-step register */
-			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-			if (enetc_cb->udp)
-				val |= ENETC_PM0_SINGLE_STEP_CH;
-
-			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
-					  val);
 		} else if (do_twostep_tstamp) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 73763e8f4879..377c96325814 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -614,6 +614,7 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_STATS_WIN	BIT(7)
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
+#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
 
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
-- 
2.34.1


