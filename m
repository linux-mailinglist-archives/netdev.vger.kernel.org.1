Return-Path: <netdev+bounces-217184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BDBB37B0E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89271B67B34
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA57A320389;
	Wed, 27 Aug 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HIhK+2kT"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5C31E109;
	Wed, 27 Aug 2025 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277764; cv=fail; b=DYXtP8UPfMv0b60SkcoJlVIL4edB828ka84ytIb90PvCqc6ZTPZGVKRlC+tzvsEMtW4x192z7BfzRJfGtJxia2zbSclPJ8OfhuPjHHCzyBbrX0lg+E2SNqPrbOYOXdtqzoPd/3uK+ZilMugJVUUPr0+VGVi752rAngNB3JtZNz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277764; c=relaxed/simple;
	bh=CkKuUQo77/6Bsid9gISKPCco9ZCqu6JAyUVn/1OeQVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0UZPY1HOe6GSz9Oj4KsL/ROq1tZtmrM6aCLXuOj2j8Y2zIOOrihryCpuK1UjjZAJ6Jk56eL9p/U5JmeL9q51UJ7tSTIkvnqKenQALpDega1vulsaAdSVwu3fcQ1eswotyZ2EKSNhOMONz4I+zpNQzFfar1rampFW5/Hm07Nizc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HIhK+2kT; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoodQHvA6ZHHvOk3bWDMA6v6yRTOxg0BnrBWdwwGIpP64/TJUlBA/F1kuHvjpfidhLtj2AiMKvU+GPVgXhLYGjGhE+H5IDqByUuIbi387WwmHlIDGGSETSyBlKc5izCsXXmkPcKdyawvv3De4/vDKlcD0/GcAahZTBLJmmsiS0+FbLUs66XjkZTh0ASObG0RkIFHLY0Ai5Z+63ypfk/UTKw+SbbjyHKxGfJv1Xr7wurtMTIttocnbmu/23MmSnjfFYcXMTPisb3S0EyppcAasyIlsjQ1c53Y1Ikp9NzmYw89rn9xrBaLXZvJKcFw1yiVt+wun9mBfdmCq0FcKsJpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6AjQTwpITTpQXwlvr3UsSda5pIcERSr2k2iUIJndF0=;
 b=CZBTbrHkvDenKGyD6i+7E2wfxukXfPmNAgMpYawIN694RIcZYw4O/1r7q70PJZ/HcJ4LNb7BfCPih1viLAwDPmzPVH0ei/15W1flzgSTkgaGotvFm+E+aa6EVmQEbcgfzgr1IXo0sMxPj7X5N5An2FFwsPSYTQAYy3lBz791545Xt7LFvtCk6if2pts9YHM6e/6d6116BB0CuA3NIi9axPlV4m5d7cBvcLYx3aYnif1qMquQ9jfVlohVzCsCB/XQl8I3UTNRE/6u4difcJcJcyMZc9i7QqDhW4mApulCXzaiSWcWMVuyOXdn6Gt4QeC0ujLWqf9Nn0V9YsDBzQLKlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6AjQTwpITTpQXwlvr3UsSda5pIcERSr2k2iUIJndF0=;
 b=HIhK+2kTiozTaCmz0428qHx24a/dIwbfRaC3P5wz/zXulpHnT7Q22+kq/1RXOIimrQZ/O1gWqZ8kRULHOZ8dGmvOGs+txJ5BKcTz2r9H4yCbQ/qkm5lvdWTJO/cXKmQ0S0TBMwI9lkkac6A+AcTO3S+/b1DK2GvH7Vm/QtrRHCbaHk1r7/bd8h1pTH+EhWuNOiWE+JdMaG8JhJPc+G01I81nos4cdzNQg4fybAl9h25JbfEKnXJChn5cVy2Yv4DPge1X9PHGXi/MAgDc1JlUzmnQXNCpbT1bGMY5srZz4rXAjgTLDD7wsyvAGvbl7lkKM5CQL5H9OoWkgP1B++001A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:55:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:59 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 11/17] net: enetc: save the parsed information of PTP packet to skb->cb
Date: Wed, 27 Aug 2025 14:33:26 +0800
Message-Id: <20250827063332.1217664-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 93097dbe-6ecc-47a7-8dd9-08dde536c769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pMYtq8fMWl2qOLV9NODMWNVUay1DAmWYwdrR/GHLagLlPSgC1LK2Q1Z1fIvH?=
 =?us-ascii?Q?6Eqv1MH61BP8cgzBPRRQkhHvcbxZ0Z1hOMtAkLhPQGk+ALp23COhhCSEG5hu?=
 =?us-ascii?Q?W807tQZ1d4kq8IN/UhBkn1BCGvYHaogjkeoonr9GdcMRD0UzxCGARWicsHPf?=
 =?us-ascii?Q?hqadrUAb1y61+FZLBkg4EcFb7LPS7za9qPkkhJ+7kP+gHujPd+8vB0l68Jac?=
 =?us-ascii?Q?zF+CkCKRXRg3yAQ8dMfFkGDUH+QwmJM6teGBCK9wT6xr6OV8axv2iWVluvBJ?=
 =?us-ascii?Q?bhQMiKbLp1gds/kqGPZ8jfVpbsjGGb2Zjc9ify4dHFvmoU6B4vF/hpEUmQr0?=
 =?us-ascii?Q?IT6gCEdoMx1s97+HCrPeebdnptZ1kGJbQfjaRwejuWmvgMWkXwvOZDzc64JJ?=
 =?us-ascii?Q?+0dAlkO6O17Fe0TPpS3KoJVWCmapTKQS++euxjbBEEipzlTFCGRdlE81G/KD?=
 =?us-ascii?Q?z4UsBbNVinVKE1EyXdNm7GY8fLxnbi6UTnJxQvny36nKlVjpx6kAjOuQ4D5Z?=
 =?us-ascii?Q?csIra/67Gqj8oGmDcGqCjoWEShA5xHDSzsAruglZRGfhMC3pUuI+HtKKITPo?=
 =?us-ascii?Q?OmbC3txPoICvqvK8FF3l+/gbmdtuyQPXEhOv6iRKCNM8EXV+HSJXOPK8ySC2?=
 =?us-ascii?Q?NWpBZTWPoDHJbhkm/3sguFQm8pCGIaCeRkTWS0k18dXXBods0N36/sP3eAwL?=
 =?us-ascii?Q?1so8ePdrpPDf15Ov1H1NZWkVLGoV2BzadYK9xUIZKVOK758LRXtx2kuJtfgH?=
 =?us-ascii?Q?7g60pCDA/QFwh011UdCW3PPgkqPa2iv154NFREf14axP9xSBd3POFG29z+Lx?=
 =?us-ascii?Q?b0WhlsWVztPyHkR/z539D5y+zaf/SxFhCibcLxAKrtRazfRag9+eAzPvJCDX?=
 =?us-ascii?Q?fFyEbCltNwRHJseSncjvtVsEXflocu2rdH+Qc76EV7vKO5+oTDR8F3tfCih8?=
 =?us-ascii?Q?6lyHkY+Gyrayu7xf9V45nAImWlftocmsVgO9b3hELz+ZheL4ayiUwqhyiaFT?=
 =?us-ascii?Q?7DPJfPl/fgOGlngjN4AXXVRUKjAUCiCa3LQMRxnNFWWShghCfIIAnUHGNKvp?=
 =?us-ascii?Q?qo40LUV2Xk28SJ7IcBMqbmlSBUuxRJrHjzCnfS5R2Uno6edXbr71UAGl66GJ?=
 =?us-ascii?Q?7q1QR/9iGutDPImznI+Oz26C9RlOrGk7wi2skjfWkCClaZe4zcu9n+iL6a9y?=
 =?us-ascii?Q?+jDOOKosIGrLqM+2oSdPWDzZA+dSd45jbtiQa8KvWHwkLaGA8tuY8uXhRHB/?=
 =?us-ascii?Q?wNsa3uOhvxPPGtVcegx6MBR1SppGDh4/bzIrDvJge067ok7DuH9rrXPvtWAV?=
 =?us-ascii?Q?f/FEEQofYTXemh+rrw7EVWLhSwv8KK8ocry7FeJxh7uBQcop5rlSVDd5GgVG?=
 =?us-ascii?Q?OcKoDKpUG3A+IwnYzjNvhQMLalCm6r2LQ0pM0UIJj/xcFIDCCf/+gebd0ORD?=
 =?us-ascii?Q?GBmecKDhQJfGWomec+gpbEDwJFBaPXrJXP9V1Y32ggd38FDNrWHyjRe+FLdH?=
 =?us-ascii?Q?3lv4wk9/DUN5qJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRhZ5az1rlQTzj7a/lJqTUMA5rmOe2ZhDUpxR7CQHKMcyp8TR63k14HHDp9u?=
 =?us-ascii?Q?AsoR88KEPbn7sY2xo/fR9hwJf/U8BpG1VUTCz9rH6hD/BPK+BzedfitPE5KO?=
 =?us-ascii?Q?lwqNXGE4pAV8oAo8+Ry12TtwM73R4qwCKabbwPyI8q7TNOCxU3ZQ47hhRyp9?=
 =?us-ascii?Q?d0QpHB8D4HmieUT5ITc3i5VEDW+iosNwLKwACz28U9eYCoKD0ta4ssnk6NZm?=
 =?us-ascii?Q?T/OER5Qn4OO0UwVEpSXmiskYJqonLOTKl5Q8vZ/F7wdCFlrbAXGHlr480Ts4?=
 =?us-ascii?Q?hhDN+W791DaST7sucf2oPTZoQ149Bav0y7zKWb9yFJWIEPvh6w75Q8JwsIw/?=
 =?us-ascii?Q?wCkEgqCHIpVnldnja9p7v1MWSMmufCTE+o44B5ucjiXJk+cq8CiCQTf5ElLB?=
 =?us-ascii?Q?uaw4qqn6he9gcKOUZlhs7Aal9e7hDxTTpmxtZTwSQNA2ODfOCurKjLvCd44x?=
 =?us-ascii?Q?SfAif8OU4/Pl8c3kbpHF+ZeKyjmkR8OdXr6fblDxCEtvdSTR6QKJYY2awQza?=
 =?us-ascii?Q?rHGKs02hmacBSIf6SuCG37q1Fp4BmjBN11ZGj8qrGmtykvH6EXgT/vm9LIUu?=
 =?us-ascii?Q?EWmnlzKkiUrdP1DDiidjp3OWcQAU+FB8fQlr747AmvhPv0bTXBolmXzT02Bb?=
 =?us-ascii?Q?RyXFqCutg0EkTqJ041cVKKbFzWxmjJWFGcu6b5ln4XI2yAvgNnqthFWxIcdp?=
 =?us-ascii?Q?rmaNjrMYVQXYIx6hMNDkfOwRFwB8QbSGJ2grEBe/4Oqw9v1FgTlb6i1BEQoC?=
 =?us-ascii?Q?5F1B9TaOycy1ZwnNUzW/ZETVzs5Lyrd1mSXDF4Bi4Ikga32N//NnI7XWgxHb?=
 =?us-ascii?Q?enwrHk8V6omJNusBZrs8m6bxTKq8Qs8aCz7Sd3sBV0ZHH4Qfa7OlF4Rte3yL?=
 =?us-ascii?Q?4JYd6LJhFTpERBx1WVZxargLKzEyxbd5LXUNuY7e5fUXdEfM6rdkRX7yGryv?=
 =?us-ascii?Q?SbI8sIDxMr6fC3qy8My7SFuVlDAD2E5tvyk6oRP0yJDVsaSk+Tgh9sN2QxWm?=
 =?us-ascii?Q?Lm9l8S1IY4F9hhwEVJ0P+9DwYsA+it7DV6xD5Kylc88taIdHJsg7wIHt7UWl?=
 =?us-ascii?Q?sJgPOnazFDhYYM2pOaQrj9wiM6Q/Xo6IrcFsgrhj7hbiBQfTb9HNaTZp5d+I?=
 =?us-ascii?Q?vR8+Zm2USY1C6MURtqzjCRnhlsrgViimPfS7Z+rDOGqXQrVgA5dmfQyC3VcM?=
 =?us-ascii?Q?6j5X4KLgUOsXARNvLKGXbfQIPZHhQaaHmImUxm7nQT/QcOQfp0xnnA7a6kLG?=
 =?us-ascii?Q?upKG9Cab2hIrkYVbYWrDpIEMmujUdvPmWpUh2x2ePEeAbrxo3IG3k2Zgxt4J?=
 =?us-ascii?Q?9T5U1mZK89mukUANpv3UtrQSjVvCCbCGq39//YmIrG4VegouhBjEcLjxMMag?=
 =?us-ascii?Q?Ia+P0RnyVoS2v5SARJuOA3VptrOMKIi3diFrPBQWByKvi5JoTP52DMATK2fK?=
 =?us-ascii?Q?yzydyzW/btuZMqNMWyH7t1irm5NbY56kvzoK2Hiq5uC0QxyR7GqWLZCsrFrf?=
 =?us-ascii?Q?WfazV6IDUJ0f/tk7LkT3USoVWwQoaOMhMEWnnUJa9YHtPvvEA/XMWvqSP+cW?=
 =?us-ascii?Q?AA/jD5WPD8Mc8MDoYAXod8Lpm+oDQCdDT8oKTzIS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93097dbe-6ecc-47a7-8dd9-08dde536c769
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:59.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N55FTBYW7sxdusnb8kNXBXoh3MTsIVgEb9d1kC0/4pjWLutgd0Sksv8nFJRPW5V3NkhiESP9jPPI9CZHXYnnxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

Currently, the Tx PTP packets are parsed twice in the enetc driver, once
in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
and is unnecessary, since the parsed information can be saved to skb->cb
so that enetc_map_tx_buffs() can get the previously parsed data from
skb->cb. Therefore, add struct enetc_skb_cb as the format of the data
in the skb->cb buffer to save the parsed information of PTP packet. Use
saved information in enetc_map_tx_buffs() to avoid parsing data again.

In addition, rename variables offset1 and offset2 in enetc_map_tx_buffs()
to corr_off and tstamp_off for better readability.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2 changes:
1. Add description of offset1 and offset2 being renamed in the commit
message.
v3 changes:
1. Improve the commit message
2. Fix the error the patch, there were two "++" in the patch
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
 drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..54ccd7c57961 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -225,13 +225,12 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
-	u8 msgtype, twostep, udp;
 	union enetc_tx_bd *txbd;
-	u16 offset1, offset2;
 	int i, count = 0;
 	skb_frag_t *frag;
 	unsigned int f;
@@ -280,16 +279,10 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
-		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep, &offset1,
-				    &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep)
-			WARN_ONCE(1, "Bad packet for one-step timestamping\n");
-		else
-			do_onestep_tstamp = true;
-	} else if (skb->cb[0] & ENETC_F_TX_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
+		do_onestep_tstamp = true;
+	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
 		do_twostep_tstamp = true;
-	}
 
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
@@ -333,6 +326,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
+			u16 tstamp_off = enetc_cb->origin_tstamp_off;
+			u16 corr_off = enetc_cb->correction_off;
 			__be32 new_sec_l, new_nsec;
 			u32 lo, hi, nsec, val;
 			__be16 new_sec_h;
@@ -362,32 +357,32 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			new_sec_h = htons((sec >> 32) & 0xffff);
 			new_sec_l = htonl(sec & 0xffffffff);
 			new_nsec = htonl(nsec);
-			if (udp) {
+			if (enetc_cb->udp) {
 				struct udphdr *uh = udp_hdr(skb);
 				__be32 old_sec_l, old_nsec;
 				__be16 old_sec_h;
 
-				old_sec_h = *(__be16 *)(data + offset2);
+				old_sec_h = *(__be16 *)(data + tstamp_off);
 				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
 							 new_sec_h, false);
 
-				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
 				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
 							 new_sec_l, false);
 
-				old_nsec = *(__be32 *)(data + offset2 + 6);
+				old_nsec = *(__be32 *)(data + tstamp_off + 6);
 				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
 							 new_nsec, false);
 			}
 
-			*(__be16 *)(data + offset2) = new_sec_h;
-			*(__be32 *)(data + offset2 + 2) = new_sec_l;
-			*(__be32 *)(data + offset2 + 6) = new_nsec;
+			*(__be16 *)(data + tstamp_off) = new_sec_h;
+			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(offset1);
-			if (udp)
+			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+			if (enetc_cb->udp)
 				val |= ENETC_PM0_SINGLE_STEP_CH;
 
 			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
@@ -938,12 +933,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 				    struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
 	int count;
 
 	/* Queue one-step Sync packet if already locked */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
 					  &priv->flags)) {
 			skb_queue_tail(&priv->tx_skbs, skb);
@@ -1005,24 +1001,29 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 
 netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	u8 udp, msgtype, twostep;
 	u16 offset1, offset2;
 
-	/* Mark tx timestamp type on skb->cb[0] if requires */
+	/* Mark tx timestamp type on enetc_cb->flag if requires */
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK)) {
-		skb->cb[0] = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
-	} else {
-		skb->cb[0] = 0;
-	}
+	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
+		enetc_cb->flag = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
+	else
+		enetc_cb->flag = 0;
 
 	/* Fall back to two-step timestamp if not one-step Sync packet */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
 				    &offset1, &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0)
-			skb->cb[0] = ENETC_F_TX_TSTAMP;
+		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
+			enetc_cb->flag = ENETC_F_TX_TSTAMP;
+		} else {
+			enetc_cb->udp = !!udp;
+			enetc_cb->correction_off = offset1;
+			enetc_cb->origin_tstamp_off = offset2;
+		}
 	}
 
 	return enetc_start_xmit(skb, ndev);
@@ -1214,7 +1215,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 		if (xdp_frame) {
 			xdp_return_frame(xdp_frame);
 		} else if (skb) {
-			if (unlikely(skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
+			struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+
+			if (unlikely(enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
 				/* Start work to release lock for next one-step
 				 * timestamping packet. And send one skb in
 				 * tx_skbs queue if has.
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 62e8ee4d2f04..ce3fed95091b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -54,6 +54,15 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_skb_cb {
+	u8 flag;
+	bool udp;
+	u16 correction_off;
+	u16 origin_tstamp_off;
+};
+
+#define ENETC_SKB_CB(skb) ((struct enetc_skb_cb *)((skb)->cb))
+
 struct enetc_lso_t {
 	bool	ipv6;
 	bool	tcp;
-- 
2.34.1


