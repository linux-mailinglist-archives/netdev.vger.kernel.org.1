Return-Path: <netdev+bounces-175709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A867A67343
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADF23AFF52
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4637320B1FD;
	Tue, 18 Mar 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bxzIlhVY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A720B7F9
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299065; cv=fail; b=nvYGKMPwbBylN4d3C0WLN/3TlABUtuRiJwsNY+sVZ18q44/Zzs942s73XzZB370T4ayATF7WQ0k7D2JzdJie5vBNAI2LiZjKZcPjMhNZaKyVDI+Jl6kktq+u+Xj4XZwGl9JvCjmrrYEvzESkvVpGqeKnFq1qtFdQA9Wbgw89nsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299065; c=relaxed/simple;
	bh=VAP2Rjh/IleurhkLwsM5WNCbzefJxetcYQv3rbquX8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lB3czGBLJzWo0i5ZCMbMJD12x2Pi6cuntthlZHVkm6lsBtBNE5Eh2vV+85+JJ0WALdGgKapBew8JrQ2TZWKmXCJTLVh0rOeHAZnudYHgnBdlh7HC9MvtOaGr1eoxvJrTP1l4BGw9l6RydtGXtYX7yGlODvUMhxRqtOhQ4WYiaag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bxzIlhVY; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJJgPX8G1S4S/tjJTmeQuBiLukjVaG0PPp+I6WraSz7RCfkfQKqpohKq5m6m/zWHY7OgyTRUUw3uIEW4AnOf1O86lj0rQ2FIVa5iCunkPTV18eyWwxtnVwN51V7U+WTmUhCkvMpCqTZjqxPPR0Uy3KPf6Sq5MEEpGmTAhrwxz7UvYoG0L0UsbewdVqwdQoB70PGkPDcSAq7Zc41DbmpWpjHR+CtLJZfZyJjGFjp9TPy3vMwsVsRdDX63FzoiwfbpEQ74x50O/654k7/NvbkYAbsfiDZMUFU+NPRWLjrNkzTTFggeBO5U0EcB1No594BmRa/CNXNwnQPPzsAAXFjp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU9e8GWltM7STQJLBo1NbWINNWFPwZK60zmmuOEiR/g=;
 b=kinUCetvT4hCnRUepPuuqCmv34MJnwKadVZ8LjqV6wS1emkejhjDYFFTmLxejA8PNx9N4khr4zdllZza8Ycro5foKDugNo93wZxaep5LkItlTcNKBf0D6VPO/DCuOMlSLo6+6kWF9b5wJearJi1uNxxvFjkdz93gJFj8qXlm8y4CyGxW3KCaUz1RYTrBUdXV32HRg2+xm8srFr573eSd8ZoaNb6eg8hzPFCikjnuqRPnov6ZTHL43B2PHVlWFTRFNDt0X+/iWAhcz2IaE4iUDuUyCs5hGD3bPG8DRB/RyXcYlBLURdyIoHTUyPP2JQusLxgFFVI6s83UjP83SkLn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU9e8GWltM7STQJLBo1NbWINNWFPwZK60zmmuOEiR/g=;
 b=bxzIlhVYQcM0qwaMKVF4viRPoWaHJvsD4qIZZyJho+mAVPifmNi/tpKQiKR/iLHC1dKOMKvaDwzhMQprr5in7OsFouTKpPqabXUlrwMHjh9WZIyrpGFAXv4lsg56AqU4ulZ/nN6gIQDtSYtIuY7U1V4qJr8NhGDwiJonuF7v2yrd94ORBYgkDOw/S7OLP8JC2iZqoUs36TZIJ7YiL65j2UX/pApcHrhqZX3nW/kkISlpTp2qU06vxAw4kJnH3DnD4ugX3osyjjEtQDGBPgpssU2y3t3KB4Nfqfsnu5qZBT4iMxUeSfCaezM0vIEmgcHdxZrL/jtlv7c5wiDwNSmtRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9713.eurprd04.prod.outlook.com (2603:10a6:20b:4f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:57:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:57:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 2/3] net: dsa: sja1105: reject other RX filters than HWTSTAMP_FILTER_PTP_V2_L2_EVENT
Date: Tue, 18 Mar 2025 13:57:15 +0200
Message-Id: <20250318115716.2124395-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
References: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d6b636-dcfb-4fa3-b4f1-08dd66140fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PVbpDZ2eWQhknMGOvKbDBASqaY0AroZKSuDkyUf5Jd+mnfEMrO28A233rnV3?=
 =?us-ascii?Q?gaeoJSd9HkAjHzGB2UZDTEVYAgn4hsYpnTL0BfNLlm+TQWHfKVRySpXORtTd?=
 =?us-ascii?Q?d/xivcxT8LeBc4ruffKcdLK+nVBrzvxUrfyyUW3fpId23RDaLJmEgbAW8JPT?=
 =?us-ascii?Q?fAQpAczz3GhmYfBtMYdcFJ9EclNklY/nKH6YtLnI0XIzvwvi/+e8YOfms6hY?=
 =?us-ascii?Q?fKnR2Ed4eTNUGgrzL12pcLBX6dD5v7JfGsKCRxuI0KaV+nwrcAN/qItjedPv?=
 =?us-ascii?Q?RrKD8mT5lYfCmUhIHsELqRAx81xSnmJcOtllBPz2vWKE9OT+cRnKnOYKhm1V?=
 =?us-ascii?Q?L7n4/IWyzjNUW99NrVkP7xlgT3OisP8HH3UuFY7YKEMLyLOorKV7saF6VL+/?=
 =?us-ascii?Q?suL45pv9C8Wl8WmrE0X/l+XdHF9buOQnQb9rYhieHsV9mZV1qdobU3En4q3d?=
 =?us-ascii?Q?tj86sLuwcqcacL3Dt/JFu0+5DtT1AWa+Js7oWE3RRXu8/K8vAfwFQXZ4JFzx?=
 =?us-ascii?Q?izUdFm7QFFuJ9YscJ1vHg9B3v6LjoERVlXpn12dszvpWlKCGT8lZf4TtU+BB?=
 =?us-ascii?Q?YgRyWIVXVevbtp2O1P9rVZuofq5NUeb1vRLkQpmKbb53NxaP3gBgZKXLEJxr?=
 =?us-ascii?Q?LTHPJpeKXBjWvKU7Y9mjgpmGjSxbUfKjExVQ24TgF7RbJuQajqL5wUNEima9?=
 =?us-ascii?Q?rwQo+KI/y1lGfBIU+RCFIuTWibADDX3Pv8zRfZnUWUexXb8WAx+zrbh/8j+R?=
 =?us-ascii?Q?90eQGyP2etOFP59W1ASA7LWevIB82kJngc4uPJJEX/bXqVstLyCpOn92ILvu?=
 =?us-ascii?Q?OF1qVCTJkAFwXkdzQM8cR68tUrEwvaY6wtmP+wfIzD09zysZZEo2YBr/X8H4?=
 =?us-ascii?Q?8M5HQnvcvjkMmQxggPOAPT6QLTVo6uE03aXvEEYT5JW1gI0fZcHRPxGqi8OH?=
 =?us-ascii?Q?qhjRF6CPAX25ERJNeBVzKDHy7HndgMr13OiMZquiAN0KcJLxqA1a5c4q+K8b?=
 =?us-ascii?Q?XvcTNQ71mm4qmQR4dz2X68UeslcJZnfwMH9rd9Tf2HqLViBhPGKe9fUXkxYi?=
 =?us-ascii?Q?dRXObYJl3dsIUnD8pmoLNxxkgTg5AJEL0XemL3IB8o4nac2eaQ0RTxIhGn2H?=
 =?us-ascii?Q?9M+d4to+Z+ttRV2Cr30foSxN4exmjCrnPR+QFsJtt+8Rhcfzh/cMvJUSv5tG?=
 =?us-ascii?Q?ueBg8L9lGVnVbvXEI9ULq5TgPelH/VUjKijyDeeTnVAQLvSeslr8mNrukYIB?=
 =?us-ascii?Q?sag8/eZ8+c/5oSfBAzBhcqa60QHOzf+QQ656I0k6fKWsvaIgU9DS9rP4tyEy?=
 =?us-ascii?Q?W6iwN3m3B6aRNHlXVgGgtlhLro6sPf6AXsi6CPKN4ziUcJa25d3EB6GoEwEb?=
 =?us-ascii?Q?byzgGdsdGQRZTuf5tpiZGKjbzm9Pg6ceYzpcZ9VqUammBynyRuIdIAY9mjeF?=
 =?us-ascii?Q?xMfpMrZUMCN4jatn7AxVVz3d+47YcxrO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeW7OCKv3i16IAf2gMyqZigjJPZ9cJ7s/R1E/FbT66eqsYlPT4rg+j3aclxj?=
 =?us-ascii?Q?oSCXJlrZSUK76UTQF/cYn4Zgr5WPF2i0RztIgJ6qt/tzijbAICdQbfKy/GbV?=
 =?us-ascii?Q?FC9getPwyg54Zq5vXwA1OhxmREPx43FGT8nwgdPfecjz55iDjavjNtUm5PzX?=
 =?us-ascii?Q?kRDzDt6BaYSJhIyvP4G1+PjqJ15JbCG4Ya6t7MFqi77aW3Zgt5tiVbmwoF5z?=
 =?us-ascii?Q?DXNAdBD/+IHhs/RSaDy/CcJ9CVQmyXAB0IZrr0m2acJUZjXa67lJ0jI54vGj?=
 =?us-ascii?Q?sb4Npxer+4BlppH8IuQqEq3erdwrhJgF84Kw02owzUfN8J5qMBOJR71Hl4pC?=
 =?us-ascii?Q?cLAO8D+sj2xdyrXVT3dO+oyFNj+rIGAnndyIhbVjnb5l65wH8ViCXBqmlL0h?=
 =?us-ascii?Q?xnH/OaFpLP8aWDcvhuZjZDGaoEbsYpI78iGi9UzHE6PwcSU3e20VPGBkZNst?=
 =?us-ascii?Q?LzTwWJsWr8KSWwN8aw8o1QXR3NVXryIxaMQ0GRJ+xMadWL/XS8EC4kSZmB5f?=
 =?us-ascii?Q?Q7q1DxZH+ePZ4+EO2dhCw3aSKt5SZTm8wD4hfBhTvBF8ePuaYZHVTqxcgMdh?=
 =?us-ascii?Q?bcE5Nkz0R1EGRbFWH0dXr78lP4VSfH0cx7pU4vzdmc/5vhMkc8qerrkzFlQt?=
 =?us-ascii?Q?b1KDTHmJKmv3yWDLOxv3N7N1Qv0o766HSnCf1Ymz6izpiY/seZV/OPDkj95o?=
 =?us-ascii?Q?ZZYP302b0ndq0aoHf+nqCFUhqmnlUKGhfaK/cOEu3gHNY4zIgHZKcltE5P29?=
 =?us-ascii?Q?vbgQTtAjUTAY1bwmxUECbsMkY7p37USNtJP3gf2IRnf0rwKUFFG3TVCe4aq7?=
 =?us-ascii?Q?eWDx3++lOKqjBtlhUyF4rbJ3X3OBcpWVWJ0JOzodZ+yjvscCIoClDdhfv7Ow?=
 =?us-ascii?Q?KRMrYUiBjG1d2nAqrhmfKMysqjNpaCOUbmaRqO/R745eU2y0SgxSPEnPDYDL?=
 =?us-ascii?Q?hsn8RboWcM4DGu4w/u5B7KAaoCrmCeMCe8EbaMiHyKT103s7XuWS+8PI/Yu8?=
 =?us-ascii?Q?BOgeleL6I2Z8lCCi2ssQtHtf1rb5hVNbvU4D3z7DshJBYVDBHSQkWvseYj7Y?=
 =?us-ascii?Q?HjRlYJpoyNhjYABWxXOCKTw8hZ0JxtgO86+6/4ERrLDVv26iAObXu5sQTzAk?=
 =?us-ascii?Q?kxJXc08Gi5IlBvZwnPkQ7JjuHp3nkV7G9XynyXYS/tHPf3Q4xlj+atrdB4Gz?=
 =?us-ascii?Q?RNLtSNmzAJYJjfenePJwnWgVfNJuXFWFMRxaxl6vj9/NQiKefKwOuv3GIXsz?=
 =?us-ascii?Q?W4Umbte85+t5W3atVLivzFoTWtZUAd0cSGkfn+bmvDAraODLPv0AJ4Ri7Lkj?=
 =?us-ascii?Q?QVDbfbHRdlt19xZwZxrXRtD9SZNBUpEr4QyyP6+JooTddV2wa7oYQuCyhZNL?=
 =?us-ascii?Q?JllyI8IW7/MNViwfDxFuzbbNW6K7P70I645rhcv3PfrLlIxcIzl7T45PUmFa?=
 =?us-ascii?Q?jGxsX2vdvDRfWb8li0EEijbV1gJMOegPuSBCmKGSiDmmXXeg6xfzNlZrxIXo?=
 =?us-ascii?Q?kMK0kSMOGR5La37pVjDe6KLOaIhX3Mf6uH6RYQ0jOIfWQqgxkAcA5JE75Snc?=
 =?us-ascii?Q?ecdPbq6tnqJHDX3M+OyZT+zmlB3Wfs4ziSH6KzjZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d6b636-dcfb-4fa3-b4f1-08dd66140fd4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 11:57:30.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8k2/y+MTKnKF8nJFPGNt1P69ypAK4xi9bK7eSilFuNk5/49zuyFoHBwXfRimVsKBJNlrkJXdHJTPCn2987TbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9713

This is all that we can support timestamping, so we shouldn't accept
anything else. Also see sja1105_hwtstamp_get().

To avoid erroring out in an inconsistent state, operate on copies of
priv->hwts_rx_en and priv->hwts_tx_en, and write them back when nothing
else can fail anymore.

Fixes: a602afd200f5 ("net: dsa: sja1105: Expose PTP timestamping ioctls to userspace")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_ptp.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index a1f4ca6ad888..08b45fdd1d24 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -61,17 +61,21 @@ enum sja1105_ptp_clk_mode {
 int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 {
 	struct sja1105_private *priv = ds->priv;
+	unsigned long hwts_tx_en, hwts_rx_en;
 	struct hwtstamp_config config;
 
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
 		return -EFAULT;
 
+	hwts_tx_en = priv->hwts_tx_en;
+	hwts_rx_en = priv->hwts_rx_en;
+
 	switch (config.tx_type) {
 	case HWTSTAMP_TX_OFF:
-		priv->hwts_tx_en &= ~BIT(port);
+		hwts_tx_en &= ~BIT(port);
 		break;
 	case HWTSTAMP_TX_ON:
-		priv->hwts_tx_en |= BIT(port);
+		hwts_tx_en |= BIT(port);
 		break;
 	default:
 		return -ERANGE;
@@ -79,15 +83,21 @@ int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 
 	switch (config.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
-		priv->hwts_rx_en &= ~BIT(port);
+		hwts_rx_en &= ~BIT(port);
 		break;
-	default:
-		priv->hwts_rx_en |= BIT(port);
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+		hwts_rx_en |= BIT(port);
 		break;
+	default:
+		return -ERANGE;
 	}
 
 	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
 		return -EFAULT;
+
+	priv->hwts_tx_en = hwts_tx_en;
+	priv->hwts_rx_en = hwts_rx_en;
+
 	return 0;
 }
 
-- 
2.34.1


