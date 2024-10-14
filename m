Return-Path: <netdev+bounces-135227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D799D053
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04639B2602E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A801AB538;
	Mon, 14 Oct 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ypx3Gp/o"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF8611E;
	Mon, 14 Oct 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918115; cv=fail; b=UhSMwvODY8QRbRNvTLEHbYezlq+2cMj9cls1jzT0hVEWv3YBznEgqx/2PKyRlixo0KDzXH/lWkhJzzCtahp5qmIepEMu74rnXNVTz8HqA1CREHgNkLuTZwjJMPK5Jok9xTD9Wsk3BjGjQpXuNNnRBVPd8GdP+xYIy6/Bv8xGt7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918115; c=relaxed/simple;
	bh=UJkzSxPbi4cz3omZu950ASkRIz29JO8U+fckWELPas0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ciz28dfmrUxhPZBMTo1cS/fyKma4rNDaSMY242BHAISntd9Hifwnn4ip+vGP20gTE1aLLZA9u/0SFuo6hsKkS9QBMSNID1YeaHQF2tYaxdadD1hRooapO7ZOV3mkbvGK79hRA2Ckckk8yLkWb6aOMk2UKj9a9qW+05k2upiJaz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ypx3Gp/o; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdpVddXrzrMMYO2B/nT1Y1m2LF3q6FYgPHsYYyq2+r1a2vV8AH0LeP9UI4qEgcbhj77k5IkbES4mD1ZxTq2gSTjKTqX7u4lSZjHZ/N/eg5v7hNrxVb2Bvmr2QEbMzZm0oHw4B7GCCIj33EqESiRBMUREClG8mw3j3DhCLtfoeqgIoycHxIzgkt7H06tkC+7wU+9cyrSU+sO71MzfSdVIH0Jg5a1z1Wl6KuJsxF7vAgPQ9yeVqkPxHMxv9XKP0R9qxemXREgwtZTCrx2M6s0NJtvsRJB8XIYyNteknEmiPCmV6mKu8lE8Tjim65YhbE3+8MgtX3PLN5Oc5zwpBZwPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG76NfE+lXVxNvruvW+IufHPNeF+Rz57r1p1TxCu8d4=;
 b=n4F6BzeGNqoMy/1wT52kR+Df+Wjj8TT3ebDtSpJI6opDrq0kqs55kdgiQ7dn3x9elG9WblXxJrsksHPf40wdmrwVhAwntObiwv4LOcuG2cpJJVtzN563YdyPTmcHJiWMKwB5IEpsGapkP92/THi0BOsLa/ClxGOE13obwXBCv6fDI0DaYu8bseNgAbReu42t4OZwkF+8yAbO08wAyzT0hv/ow0JFgbz3ZMKlJlr4iLG93woV7c3mYI+ObsVX+M6/aekV/ItMYjoIXWknJMMG8zw801hzMBry0gOnFynPBEaBAYLTDdQrrFFvewOwbc5jZTv/GTP/T+6D9zAeW7CwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG76NfE+lXVxNvruvW+IufHPNeF+Rz57r1p1TxCu8d4=;
 b=Ypx3Gp/o45kpZ5huyo3Uqqx2xe6WpjAwRsPssEi6ku5hwLEqkALsduJIaBxQt7NoZLfQO/l4adv9GebMuHPoO5LpYRgipe5WtQgBGEwRq624EKw4NSm8/zqPWSwTWdNAFxhgnMcFqw2JGEvoONzWMReLMizPULRAiZM6+EGlmdKw7jybflOQYpuAAdSOTcoPptgSOMVVKm9DfR9YRH3aE7EkGWvI12M9hho6NYx8R57anGGNXZR0DGSq8dXG0LX2cizW5Mcp8R7yKr9CSydMwRgPs0V3bPmxPOBoSyJ2McxjShGp5vvBkQDxZk6R+rKWKZbsMJGtPXg1NXU3Au57JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA2PR04MB10188.eurprd04.prod.outlook.com (2603:10a6:102:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:01:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Mon, 14 Oct 2024
 15:01:50 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: systemport: avoid build warnings due to unused I/O helpers
Date: Mon, 14 Oct 2024 18:01:38 +0300
Message-ID: <20241014150139.927423-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR02CA0043.eurprd02.prod.outlook.com
 (2603:10a6:802:14::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA2PR04MB10188:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e0a115-3a6a-4dae-22fe-08dcec6121f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V7b8sH4yoezgECN3M8zHOKEFdQhk+BiGDjGQKRrMnID+vzejZ9mjEnlly6BV?=
 =?us-ascii?Q?uUibKDCyq11RbWHmn1BdlhxRz+QSP2pzCQk2y0t1zVm3EAccymkbmUZaeAcB?=
 =?us-ascii?Q?X1fh+AHX9LoNGItaOjhCu/FG7E5zqEv31n5CZJEkgLMksQfFd402tsc6stLH?=
 =?us-ascii?Q?H3gg9nX3NiyEy4A9AQRQ63sp8O4LIG8Ak38hrp8DxDsYCJ3g3i32zfXyM35+?=
 =?us-ascii?Q?FS40KQ4HTNmMDOZVvy7ZITbZVwRnpebEENo0mAc3nxYJ4CE2seHEABSfajre?=
 =?us-ascii?Q?Bp6zkqtduN9PVyFMENkhDZ6uEz8OXyLSqXKrAFZpjdSJUrk/306K2bFJpoKv?=
 =?us-ascii?Q?pGa7aPMHwi/hQrTGP+rogfhe0cwUddeVZ9tcEosrZl1h54ZLhwoWaPdsX64r?=
 =?us-ascii?Q?3ds8KvJtlN++dyq9yquZXEnlC4oMFcrdxHkL8Z8TSGFlGODgRQBjUJE+Uajv?=
 =?us-ascii?Q?20HNt2a2RLlMorGe0mP+Fhc9YUHAEMFVMMy/8ETbLBdjqMnIQGVpQJKUPGz1?=
 =?us-ascii?Q?OY3mz92MIz7TAw3+WqLohbMwiE7JNr4KvwFJz9xu8C4Vay5kHtWPw8M9lamE?=
 =?us-ascii?Q?U4WsaR1Y2uZyqiaQVvXA6gmSdEUwJA1eiq73QeO+HICnMNPmm9CfXG1rE1+Z?=
 =?us-ascii?Q?p+wHg7RHRCuZQyXbGNr031GTim407q05mNuIPqY4ClmNR72nTyOA3mwJhlZ8?=
 =?us-ascii?Q?6LPHhtKoBdiTbZyjVGykyh/8tSNhykyrL9+t70Hobsn8Mx5HWx9Rc2Eqb+QZ?=
 =?us-ascii?Q?CY2HyuMQF+ntszOAAz5i2wUGinHLEPqFij6jRlQdhTR0O09BHvvVZzYXEhpN?=
 =?us-ascii?Q?MFxPbrEuyJi2dYwPtr8rl8cJi89lH4YRa5WHmiveb6Le0bRkjuog8ropClEP?=
 =?us-ascii?Q?ipmhtQcfEx0eDns7/daynaaOI2LD6hm9cdYJteIBPO3wTetxkbBx+P2e+ZiQ?=
 =?us-ascii?Q?DWwmhtbz3lJLwTbk3BHIE693M5lGYJ5pqdPCUBNqjVugKwjtvGKa9R7RFgag?=
 =?us-ascii?Q?f7Pjwpe83sH2gERsYHqqQ+c8UN64ClgXr5q99VH+TLe1rHC/RDmL9gcdbfBU?=
 =?us-ascii?Q?GsM8KKr2xImE9e+5DaMZUXWapSqLPKiUKyUtJew0bgDg71qoCq5ByskUuAoP?=
 =?us-ascii?Q?m8F4iocZlrfSqB+rdBIMhRsVRcUDNDjLfzM2tSRvHQD9mgexJ9kfqSkU5OoH?=
 =?us-ascii?Q?iszLYztVE/C6S+dglzSOG/vM1m36e4JUwurrIb1eYrtbX4G/yy1SIuihvEbU?=
 =?us-ascii?Q?H8y5r/pv9WipmJHsWwaEXx6iEHM83e7t9FJiY7WVdUJSof5nUhTJ9a8xIScy?=
 =?us-ascii?Q?5UuCK+LbSVgCBWOIEAJQAxaQoUmG+PZAn57qoImK9k/Sbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/0EOeSNkAEXLRAIrWGv9lAD9+5MGzJ5CNXXmf9KNW36ix2GZn2DMUa9KJZup?=
 =?us-ascii?Q?aTvyLYMoCn4VMxBShHttmmkfCjEFcXls+2Nf1v5rMG+Sk8AfoeuqHmGybBBy?=
 =?us-ascii?Q?XKDn+QNFW1J0ppz34H8f0lZcize2JywAZk/i5CRvl0N5OVU712oZoiwGyukn?=
 =?us-ascii?Q?1JRBTOYF0/CmJ4l0mpC6TM4rdFIeMs+6BW4MMxdcHGH4TWuiYmf8JYNrzl0J?=
 =?us-ascii?Q?7u9Neg9mkWarltfcWU8lKgznI9f9bB9yGOGE2hqV7u3VJj6uJ4RQg7G/8M9I?=
 =?us-ascii?Q?jPftS+vFb5tBwyGpUNaDrnPs6vJNGtUohJILN5eJDgZR+WiKv7s1A8j5m3rn?=
 =?us-ascii?Q?wQDB92I9TaI9Jwa1piuChYnWFnfYC9JP2ysF4qnksmPvUbTDDuUj3KMuadtB?=
 =?us-ascii?Q?qkiM5GM83ulFd4hfDqTy3jy5AwBGv8gJnQq7HYthHU3c48563aGxslJp1CSy?=
 =?us-ascii?Q?38uJ+Kyb97zf7Tw3m7NO8AgseRlS8X4O3ex9dZB0mSlVD9OfAavfwHIBe6aQ?=
 =?us-ascii?Q?Mw7TxKs2WXZyeWiXOmgKP60qiFrL9R5/a0tGrQ53Z31LHlGLb9x4a0ZNgkup?=
 =?us-ascii?Q?mXUFu0HsVcvghmqbA95SvOL/8GlIN1SYL2oHdHQWH8cmhEbRAbtEHuA8N8LL?=
 =?us-ascii?Q?S07IJRdT5hUBatU6Tiwc3+3SGgfHtiaB7gJZX4yL1u/dgdD3qtWssYI0NeQr?=
 =?us-ascii?Q?f2aMPFf4jdqCWGwDLmEmpLZahwXbgvee7z5WHzUSO/exo2AeVnOTYl/2brgR?=
 =?us-ascii?Q?1ttKakD2Gl+U333GHXKkGTOjmgQ9rlBc2UgCj4ZGp7DC4XKNQLsIH3/wdcX3?=
 =?us-ascii?Q?f0pZ58Djv5BAjsLT4puC7t9jMfUVaHF3Hek6dUtlac1nqxWD5XYFKG1yLDws?=
 =?us-ascii?Q?u1S+fvcSNZM1st7p9Op7/6nNC3Ar+k7+9GFKl5pt0TJaDqrSsyiFvhCOZP58?=
 =?us-ascii?Q?IF4OfzEYnGyT2/sX9bJWFSRN5+E4h9Isbs9Xq85sOjW8Xm4wuz8nli/bQ9Y+?=
 =?us-ascii?Q?gxWELQRQp1Gg8Lwb9GOaK6t1DNmpUyuyNAciZLMjv4Y0h0Pz09RQwf8q+/YO?=
 =?us-ascii?Q?+njP/SAnnTfpgMegXG1U86lp1v04sOC3ntyWe83k17Yzvr3T7Gcn4MDFJC+Z?=
 =?us-ascii?Q?6MLWCdtn/oh1lu3YuhD9FEJI8yU8omnkxAcuamw2p3pKdNU+pbMT9B8mheNn?=
 =?us-ascii?Q?ieKXyIPQb++gH1Gy8j2P7IfRX1WRDec/jAW9pgyEnvb2kwZzjhkKh9n1Qc8z?=
 =?us-ascii?Q?eiNIB0IfXZnordqXVqYep12pss0hiqdDsAs+DqXVL3RQmAma1/F6ferDeRUj?=
 =?us-ascii?Q?ihflm0OxZnIoxHhmcVK9jynZSKVhSpTpnrrVXG4OiPMuh9XMdoAmcW34my7W?=
 =?us-ascii?Q?vPKw613l1FYf4fDOMHPmEl0aob+aBlYrxYk1KRlngJqS2VyjFBaybPMYZ4jU?=
 =?us-ascii?Q?eW4HUvOoqkILYy1EkRMWru39iVxabh7OdmRb/1B7FQUSqHj3hM+SUKMjBgJH?=
 =?us-ascii?Q?yFjFBr/2zr18iOuttfWhz3ukGSmw5XaR2ZAth0Q1zOV3EC6pS4ZPU6TEqlFL?=
 =?us-ascii?Q?3Lr6aYYhyqDs9DsJ21wKMcATJcV7a7QHZv7OYLXWkR2Dnc5rRPrZL35HiXSz?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e0a115-3a6a-4dae-22fe-08dcec6121f6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:01:50.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDQj57hGjLJUXRlITkRp9vDuuiVIkvdqLiYPjIFhxYekmlie8VsHmPTRzFY4GV+IRuGRSzlE2zgl6rRMqX6hNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10188

A clang-16 W=1 build emits the following (abridged):

warning: unused function 'txchk_readl' [-Wunused-function]
BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

warning: unused function 'txchk_writel' [-Wunused-function]
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

warning: unused function 'tbuf_readl' [-Wunused-function]
BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

warning: unused function 'tbuf_writel' [-Wunused-function]
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

Annotate the functions with the __maybe_unused attribute to tell the
compiler it's fine to do dead code elimination, and suppress the
warnings.

Also, remove the "inline" keyword from C files, since the compiler is
free anyway to inline or not.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index b45ed7cd2921..7d6e2c2ee445 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -29,13 +29,15 @@
 
 /* I/O accessors register helpers */
 #define BCM_SYSPORT_IO_MACRO(name, offset) \
-static inline u32 name##_readl(struct bcm_sysport_priv *priv, u32 off)	\
+static u32 __maybe_unused						\
+name##_readl(struct bcm_sysport_priv *priv, u32 off)			\
 {									\
 	u32 reg = readl_relaxed(priv->base + offset + off);		\
 	return reg;							\
 }									\
-static inline void name##_writel(struct bcm_sysport_priv *priv,		\
-				  u32 val, u32 off)			\
+									\
+static void __maybe_unused						\
+name##_writel(struct bcm_sysport_priv *priv, u32 val, u32 off)		\
 {									\
 	writel_relaxed(val, priv->base + offset + off);			\
 }									\
-- 
2.43.0


