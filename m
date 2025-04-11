Return-Path: <netdev+bounces-181588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F5A8598D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95E17B65A8
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E09529B231;
	Fri, 11 Apr 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gM/BKUHN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3D238C1D;
	Fri, 11 Apr 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366677; cv=fail; b=IdxHvAeQD1HZle2tacLCxLQudw+KViKVLoEPVVaK38pcbHpg+nGWBnvSAikuJmnTdvRw4NnyI//fGCx5zf1vNOg547nKpLoWVWSuPzea2ATu19LgwIhwGrONhGjgjgKHjpet8Q2NUEOEunwcUgy6jaGwxW329NS82cSj0HNZYgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366677; c=relaxed/simple;
	bh=/9x3UY5lh2gdqa+7bFQZDq17c7K0LwJ6GMDWe6h1oA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cp3Gr/7GTYamlk5n/YZO4EeGPzyt1gFrxCjseFoUUm+JBfz3r2lJbPUZZ+MF2335Y7crcPrm0ErCi9/zkpv2Q4OI7HbOX6sLbsut8R9VA3AiXwAsFXLFaxysUf8V1/hYIFsv6yg30zaTVAHbTxMtu4WPqFbu5WVc7JyoHFvDA+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gM/BKUHN; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB0K/gZ3st0G0Pvg8TcsziN3Pds++8F/8bFziYJ3cDeFrZYzRJwfBfwaLmM4q6kn8UAX9+ZVNr11AmQg4oeQRf5VydsrTJmx4dEmAFQjIBpFyDYA4dXphTsosTqMqOR0SFFChAg2EEGFZjr6pbpNxRd9FUec1ZKzbk0EQo84lWnBnXLAup45at8OQe+FIsnxfYlvgmBXUyb+K9sYuUhlaEMaxQhXcD5skw0olanX0mBP+p6N072h1V4wKqbS9f642fhBHqH3m4wKl1z3gunUSiAfyQpNcIiOSG3kZnpU9MZKyBL8GJ71pbKF/whokjGgtACX7f7Lmt52251P2iAZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2sl1D2ogjKReP0a7bEBu7OPeVSX/joOCaVl4YbJy18=;
 b=lecQ0eMMKdAKiJxGLet2mFz5TpeVnlWNLiy5sedSxKQMyGzJJy/ElBSGU4UByB15ruHqr8OVpDmkA0LF7pDr6mm/I0zgpo0wyXFVf4hkA50hjzzq4lra8yU55fgxav1pO12clP4IDoF5/i7ErPWDCdzt/F0nZkUsgDFfnrv91O/4a7fS9r667L14D2vuoXwbSY437hXnnkhL1Ri4izZ0HxTd4yxbB1i5fDdYwy2kkmk4spCCmPQtR01NrwRy7ESLQnfdRbCKrPXMpRzy9sNI5SO/ytP3+N7gtmk6NSQ+w21D3s+tU/GKrRWNKYRZdsq0yOWJ2n4SM34bBIaBuAz3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2sl1D2ogjKReP0a7bEBu7OPeVSX/joOCaVl4YbJy18=;
 b=gM/BKUHNmpCf8Ws2WSTYQZw+QPTzvQh84hUHplbT/ahPCX18uhfMNwxclgBjtQaEBUuVXCPMu3PlyZQ540YZRod6gYBdzuwoL+o0rNdZz59diLWivnfnfBj9wqHCj6Vhob0LncEG4WxS6c1pUwqVPpnURm4kxVfi4+2blu81A13uGhXP7yrd4L+bNzTyH5HHx6VeotEn0veMvi+QO24ZKi8AgTFrfZqesdz30bcqrvhkTvY0XryVKKn1wgpW3mYxX0bu2IkFQswjRAwuZHAj1n5DV8JUfdJsh3A3uhxfWJg1l9u4X+lKWFmExKvd/RLA090rNDugcH6VDsS4pa9lIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AS8PR04MB8900.eurprd04.prod.outlook.com (2603:10a6:20b:42f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 10:17:50 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%3]) with mapi id 15.20.8606.028; Fri, 11 Apr 2025
 10:17:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 10/14] net: enetc: enable RSS feature by default
Date: Fri, 11 Apr 2025 17:57:48 +0800
Message-Id: <20250411095752.3072696-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411095752.3072696-1-wei.fang@nxp.com>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|AS8PR04MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 391f1660-43cb-43d6-ec9f-08dd78e21b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?liGpxH53sRHIZ3P+mCd0Rg7oxzwyDsM+iUKN06YQjeqZBPvnwNU4af7Wkwjr?=
 =?us-ascii?Q?HB8b+FmO+4SczmdYOp2zZV2T20yRddzjac48aVdLhPK+4lBsFYFsrztIssjG?=
 =?us-ascii?Q?EKl9burK0wTEd96vW9ttgssTbWbRg2zMgDrVhWeSutbfrHNLbzLidod10Qez?=
 =?us-ascii?Q?J08vc+qR0zr3m30p0MOxBI+efD8CitE39S9jaIcBRSm9T9XGxX6VF/8Mpwkk?=
 =?us-ascii?Q?EQ8cTryXI0cUPEL8t9xT8Ho1IV8MuqAVFSMnil4M8Xo9IIPte63iJyB520T1?=
 =?us-ascii?Q?HtZbvLi0YFb38m5Cewvd0hOJ9nEj9Tpih8dpwemAV3ztRFx2gXVgMiq6HNPT?=
 =?us-ascii?Q?BdvNuFifUiaLZDDBP/hSh2ptNetOukChrqoGQPv5NHhyfwqxq0Bs8YHC6u4E?=
 =?us-ascii?Q?bxnTu8L6bml2HjohVTDgViipij55bRVUp1xhCl6Dc2kFMvWVHFIv0jfoEqJ2?=
 =?us-ascii?Q?TrK2JoHiNjdfLRAqyM0CjNXJs+BwA1eANq6gREjIjNus+ud5xwIy2ryDHptb?=
 =?us-ascii?Q?nTjUzRefhbwnJWjv2drWFus90CdmSoIq8wR4+2zmTmUvqYkGcQtFcQCtbOoD?=
 =?us-ascii?Q?aGAzMLwSflH16PMu4W/CzRiF9Ed3CU/8N6CCR3KsEl67n3RtArB5nWySpr9X?=
 =?us-ascii?Q?/xsWTUF0xyYjnvPq7kIA6xSNw7/P2O3tE5zigzfdAygA57tTTr100loPkKz5?=
 =?us-ascii?Q?BdsdVkmUVLbZMeUaudeBC2RPbnQfvg4nFrD/39DKFsGY8QEgEiUrxBbo6jJW?=
 =?us-ascii?Q?biZFEEH5e7TShhQOsG0FEkhI6tKvPm7SkCrQeTG7pnydqK6SaeR64G++0Gk/?=
 =?us-ascii?Q?lw/ukDDhDA/IBT9YOr7uQi1eqn0BXPvFwo6JnbYw02q85oZNlYEHms+TCdwI?=
 =?us-ascii?Q?hkJ5OzLCKnvHEMCNI1q2XSRN/M+pPycS3yk1oUViTqgDUwk4TFX43S62J9I8?=
 =?us-ascii?Q?O5Cro9xDkXPW2gP787KqLryW+rJA+fGfystlZlYvNxiFj+6UyToajfmTJuIq?=
 =?us-ascii?Q?lmxR5iVqR7dTnAtwozLhy6Nq74UhB1dcRcDPbB0FqFn0f+vDPxwfkadTDwpl?=
 =?us-ascii?Q?vON5Ya6g55fs+zhDYNiejUEk7GIyaFJcZpu0+SvPAGhqoSQsyxgNby7V81zw?=
 =?us-ascii?Q?EfAvMli6bcfT0ahJg9NXzn7O6VQyyv+TV0aJ1StizIi1oqoHWP2Sno5eonG9?=
 =?us-ascii?Q?olk3w3CKKXQvvJQKnVHrzAKuni60s5r/O9jTyrgRE2Ch0ibxv3WgxRQGEtAp?=
 =?us-ascii?Q?YLXIi2Sf9XMncxpHmuN0RIrVL2yP5WHbwIGBNphhvxlsp/7U2VXOaZAWrILJ?=
 =?us-ascii?Q?WY8q5y74kAypxOnUP/Nfm5NJJs+M0eA3XlWV5adzt/PS31loi+n0ALjJZwPq?=
 =?us-ascii?Q?AXsN140IAThLLRJOya7O8Y7NmCICXCX3pNN+YD+IyZsdkGjAh/lrJTb8+bAC?=
 =?us-ascii?Q?N2jmfEsUbYxe+ckuu80FsGA3dg7cSQ7D1+FcPpbtfW2/V1CgOt26kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iO0PPqp91PMbMeTLtMaA2q4yUEOqKhmvymh5R5KLf4Kb50Wc+F5QfEacrkLu?=
 =?us-ascii?Q?CmLQJn86XdlnrIlC6u4hM/W1E3piYIz/FC89/cEgf8SdLqVGPNbrpu+blLZy?=
 =?us-ascii?Q?fJeasQgmbhSLPAp4QeXspLfsmqSPHTKa3TyI4A6irA+U0cMnBqkqFUotv9aj?=
 =?us-ascii?Q?eLUTy7c10z3f21N2+04h5Fpk/rdEFsIUPyC4MK2avKMNWNTtKsGRIOWye6fJ?=
 =?us-ascii?Q?tq5Xgz9GbST7wiKtRL7YHP/rPFwNnrBjSMPZGlQOMFdho39RpMimAtvYYGGe?=
 =?us-ascii?Q?G+IEaS5Skznq+lTIEtmzq7Zej2ASxuomA0wTLA0+3xHhhslFezoITArGnUcV?=
 =?us-ascii?Q?vh+j73HMAnsluRzKAMDx7r0pabMGPH2DLbApL2KliZoYheY+E1ahCnrz42QT?=
 =?us-ascii?Q?zYDR4Hz5dqJWbxF2Tb7jf3Ygp92grhgnC0YTywztlAyKxCEaYpnI6K1TUVR6?=
 =?us-ascii?Q?vrELtZpnwLomF9EtHxPjwW4/HNvgs29sX2pZYtfpKQRMHGu+V5vUQmWVJDzj?=
 =?us-ascii?Q?w492ALVd9iAusokrZ4R4DrMNl3MQYmSv9vw6Ow0pxOBkYSsYvw/h24zdgNuw?=
 =?us-ascii?Q?y8hRCWB3tRecUCLQoS31F2DVV7AKHa3i4gWCqFLHoAPt0K3QiglIF+e8KtN2?=
 =?us-ascii?Q?3YpqpuUQBnDOWAQZw4g4gmekQavjIyRb8ibfhSGamJa3783OWCeeTwMbd+iJ?=
 =?us-ascii?Q?w5XDtWEBixUxCqrP3myBxhRkqfyDaWBDA0KmyiS+9CxbOi2wqxw/iGG2eECb?=
 =?us-ascii?Q?K0W9AkE95qPhdHIX99c8t2JMKVbljiX/1GnKYKbptEQ/oGEPv7nAayXV3jLq?=
 =?us-ascii?Q?swqKWEJreitgbm8MhcWjmLXWgbP6bvH0e8YYeLWQaLoCBoQiC9pot7+XXvB8?=
 =?us-ascii?Q?4ebBg2sCAYcVvQ2g1m/sVs+ynKgAv6jPTkoroQmZQvQFqPRLZ8GdgE/uhSgZ?=
 =?us-ascii?Q?JQLrsK8LQ0KJ8PTBiSPECT/5QPm+J1tTSHE8HZmSfX8ClaWlLzcuSZW+00oC?=
 =?us-ascii?Q?23Fvm54loFUiGnTBTF88qv+fKjBuf5F5JHCUNaq0X+AySTsaWyC0NrgpnJcg?=
 =?us-ascii?Q?GRAtcwj2KrmQWyrpJX4LzSLcIUuSLBsxndP+KNs+eji+9P2/UFEhH7kqC1X7?=
 =?us-ascii?Q?O36etn8WR1JOT6yNktW7RMb2GeX1Ck7nILCfIQ1zertD8/MoDrj+U4jXroQb?=
 =?us-ascii?Q?H+/UIc6/w1s6QltfzMvmL7+jzKKbT/X1TIFe53LQs50RVrFlPnhXe5cMw3jW?=
 =?us-ascii?Q?FKZvpi8j9hevav5CZN3i+XodgzGxVg8GqU+9pIoziJdK4dZH8n6zjpAkK1Zn?=
 =?us-ascii?Q?67+zWnEPc8BNJPprAZ7HOypirV73Co8sc1Op1ILRL7a8Ka3kVrygUPnWDB/w?=
 =?us-ascii?Q?l8LLgqtTUOuEk/OGabo9OVTrIHx8aML/wlexXilUSXhO0Vv1nQfotDcINN8b?=
 =?us-ascii?Q?SF5MvJek5aZKOFDPDIMyn+XWTRtvokGyX38UhmBZYc3+qhWRPuChBUAha4Je?=
 =?us-ascii?Q?vTUTx1OFZCYaO7ysQ5sa25CdHPwTKIm/5nVp7hgkqf7xXj68pKVA0eCJJyEh?=
 =?us-ascii?Q?iRFy4IqgxWdXPCQr9qsdzjEgFZ1bKt2a3mUm2Vm2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391f1660-43cb-43d6-ec9f-08dd78e21b3b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:17:47.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shU29D6vNDphJ3aiEjPocDP+jDfSVEvhPCoK2qyXWvIpPVLU3J/4hp6kfO431Acia6LgHSUGMQBBdVn32HfF3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8900

Receive side scaling (RSS) is a network driver technology that enables
the efficient distribution of network receive processing across multiple
CPUs in multiprocessor systems. Therefore, it is better to enable RSS by
default so that the CPU load can be balanced and network performance can
be improved when then network is enabled.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v5 changes:
Just rebase it based on patch 9.
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 31 ++++++++++---------
 .../freescale/enetc/enetc_pf_common.c         |  4 ++-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  4 ++-
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index a389d5089734..d686baeb1aa8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2420,6 +2420,20 @@ static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
 	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
 }
 
+static void enetc_set_rss(struct net_device *ndev, int en)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_hw *hw = &priv->si->hw;
+	u32 reg;
+
+	enetc_wr(hw, ENETC_SIRBGCR, priv->num_rx_rings);
+
+	reg = enetc_rd(hw, ENETC_SIMR);
+	reg &= ~ENETC_SIMR_RSSE;
+	reg |= (en) ? ENETC_SIMR_RSSE : 0;
+	enetc_wr(hw, ENETC_SIMR, reg);
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2440,6 +2454,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 		err = enetc_setup_default_rss_table(si, priv->num_rx_rings);
 		if (err)
 			return err;
+
+		if (priv->ndev->features & NETIF_F_RXHASH)
+			enetc_set_rss(priv->ndev, true);
 	}
 
 	return 0;
@@ -3232,20 +3249,6 @@ struct net_device_stats *enetc_get_stats(struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(enetc_get_stats);
 
-static void enetc_set_rss(struct net_device *ndev, int en)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
-	u32 reg;
-
-	enetc_wr(hw, ENETC_SIRBGCR, priv->num_rx_rings);
-
-	reg = enetc_rd(hw, ENETC_SIMR);
-	reg &= ~ENETC_SIMR_RSSE;
-	reg |= (en) ? ENETC_SIMR_RSSE : 0;
-	enetc_wr(hw, ENETC_SIMR, reg);
-}
-
 static void enetc_enable_rxvlan(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index a302477c4de4..a751862a70b1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -128,8 +128,10 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->hw_features & ENETC_SI_F_LSO)
 		priv->active_offloads |= ENETC_F_LSO;
 
-	if (si->num_rss)
+	if (si->num_rss) {
 		ndev->hw_features |= NETIF_F_RXHASH;
+		ndev->features |= NETIF_F_RXHASH;
+	}
 
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 4fafe4e18a37..f6aed0a1ad1e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -155,8 +155,10 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
-	if (si->num_rss)
+	if (si->num_rss) {
 		ndev->hw_features |= NETIF_F_RXHASH;
+		ndev->features |= NETIF_F_RXHASH;
+	}
 
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
-- 
2.34.1


