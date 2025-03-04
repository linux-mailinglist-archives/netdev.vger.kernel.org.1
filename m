Return-Path: <netdev+bounces-171517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E71A4D516
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 08:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25FE3AAD0A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907F1FCD18;
	Tue,  4 Mar 2025 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AwOoox5Q"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429281FCCEC;
	Tue,  4 Mar 2025 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073997; cv=fail; b=GZ7yeUz4K1stg7q2MnnfY+jr40EYIr81G31TPO8MiKQn5FMngrlkEPcxK6dex8oEsuTOBzuvyb9o+fq3yrurZvPVjP6bAXS6oeW4p9HeD01kOc6+KfbsbxIPpqEdTfkvY39oFpKxIYoNeIoQQdMPw4zdE1lR+ndTy5yt6h6j9uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073997; c=relaxed/simple;
	bh=xzXHdZ1QuO0JGBb7dpIAGEEGGghmF0Bsn0rVx+4uyis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpQXAsT1kHSKEplghMwdJOtHzbtxpyDrn9lv1MqR8rS+Huu+cEz+A4MTDCfHIJjV/pPnaCDmF6IDBk/2h8ohNFrMbiQOphUpqjYbCfVJkgBPbQGQTP6zTYq7ysICk5LTz0pYEOhR1GoYernCDqbOVGRHjijmJkXAMgL7tgtgphI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AwOoox5Q; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6dum6iFasew4DBqBjLQuy9IAyp039nCBKXBXswZKKKpeaC66nqfFuApwRAxmWTd0htZGZqIjZ2hEUMoSylGvmsTA1qmnVmpre4wkggV9MYJC/+nni2pyd/bWqZmddWguNadxoEvXFU6XWc8v/rT+NpFCkq1Q4u052RFrNA9NXaVmB5ddZNDlMEgtzlkI2XIfCbBrUPLqhEI1IjrCjZ5xyKGuG4+DjK1m5d0HkVqfLkv3Wn5zn//LLbaI00B7bIiiS4Ib0bgn7SflE+9QXX1uCziy12TlHfuPNsYQJCh+qPW7RLzNcNps58MpmHW6NjjyN/9JZwZob3ep1I8NW3/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks9GIO6GtrzYt1TbMCQbs5B1G2hnYgLQq4klaXlrlTM=;
 b=U8D6Xz/Qai8zFPd6l6gv6uQvS52dBtrhEbMnvnR4/EVuvptuOo686II8+Klcilrq2JqiZR1mTn9Tm5EcXSoOP6oqKXxvUZI7+VNzQ5AMJ14EYBpP123wMqfRNe8G/ommLlwuh36jXctoWIkykQrnI73b4nqtMWem4LgMDx6shZnG281s7wCCwX1nOmm9jOT74YHkGFyDsESFF4iYr6o2+8keZOnNrvue7ngMnSYXM1rtsPQbyDoKaD3phQYkAyF+IYTmCpod0oamq1fENZ1ciPvneEzgpGDnPhFFFbv/d7JFcAQ9cyOAmlf5G4Y3ZoeliWAFxQJZkFt08PCVQbd4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks9GIO6GtrzYt1TbMCQbs5B1G2hnYgLQq4klaXlrlTM=;
 b=AwOoox5QQSXK3WVcAVgQ5o19ObNzPUcR1+gFLNeW2Y60p1ielNH+4izC2/wkHrtHbSq1evi5jpOQrnYiZvAQ0fxq3VryBIN9mqTID9nQW9ejmWxrhYnKuaqcDhn6zASYH80XrVcRHxLvpwVRWY7LL9foeI9M3hlaPVnIq64Rge1Ndkep7slMyhKmZr+Ok34j0T1694x7LCCL5cI9ikd/R5xnjqZl6Ad7qo2ila0dtzQRAzE9oqMa9ePfrtCO5zyjbgrdU25RFeKUKBvVkWCyFJY8O8v+HvMz1c4ZmupQGI4OyHSDdICzq7jfzI8sz0aQ8iydHvI7jfOzW39kvr2PRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB11171.eurprd04.prod.outlook.com (2603:10a6:800:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 4 Mar
 2025 07:39:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Tue, 4 Mar 2025
 07:39:54 +0000
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
Subject: [PATCH v3 net-next 08/13] net: enetc: enable RSS feature by default
Date: Tue,  4 Mar 2025 15:21:56 +0800
Message-Id: <20250304072201.1332603-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304072201.1332603-1-wei.fang@nxp.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1f3cf9-327d-4b73-8ae5-08dd5aefc110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Hh+/GKkH+RmBD8yXI+EiSBan243w1to5VwuGa6VqfwM8CDLoIiovbRC6lxa?=
 =?us-ascii?Q?3WennC1HjCihtGuSO2nf2fhx4e/ofRevSDnCuBhQFjmADIiDhV2GKQ2Phypp?=
 =?us-ascii?Q?A7E+8tIG/axSk5jQ+9UkpAB4KLOPBVEwhADPZHtnLh/vmvDXBaawZ4Kkl0V8?=
 =?us-ascii?Q?DmZJDDMGhSCESSm+cGntuSp1XByit0fEsIQsXF8oqlY+XO2DVr8DXsO1V182?=
 =?us-ascii?Q?Aofi09LYWCkBmzrgMN/Ewl4+W5WV3A57uosvoAUbqH6oJJv+9+laigXFBryM?=
 =?us-ascii?Q?PkHidya1rvOhmH77GBnT5nm4rF7OawvBbIdZEZNYjvcHVRTvG0ZaLoYg7eEd?=
 =?us-ascii?Q?LrdICrCoTsJIgMHZfL05/y4EjC653NVYVHEw58ZxJi1zgZfrtV7jqKZhNpQ0?=
 =?us-ascii?Q?EBDKYts6hsy91Hxiy+ugKGEH9kwSjXEMmfdz7XWeE9z2HrYrl/4anJKlZ5TO?=
 =?us-ascii?Q?hD8hV/je8kBJwjf51uB8UL924g2LE6Pd4VlT5V7Hqr3TeqiTw/5Rwd2wAFIs?=
 =?us-ascii?Q?/G9dITW9mjZKpknxOpTSqrTO5EXjR6VmIMV2OzDA1dh2bMLTXJdZz3rG5enY?=
 =?us-ascii?Q?T7p85f0OVm0h7XIgX8yPk8aVlqU70SKrKWgWcs6TJ2A+fH3cm/DUo7C/Ygrz?=
 =?us-ascii?Q?8QO4MNSpUocWsllkhdsMam9u9wjiptETx0CbRJ1bCTwvRgo/ibwTpQ+hMTXh?=
 =?us-ascii?Q?QSQesmjFQeK/LtNzXfcwEa3gFLjan2/ud5HY4CKdzlbZCI3ItdLRf4Q32yGj?=
 =?us-ascii?Q?FQ7NFELFQN0Hkk9bgQjkSW+v41JhnXr6HIy3jC6QDKmiUgQJWHStXM/rZYeM?=
 =?us-ascii?Q?yawV8kM3qJLBR3lpAhCPtuOtyy6MsX3zYuXns4w0VfPl6uaHhTcDatJm9Fur?=
 =?us-ascii?Q?vHZEyfrFJFzojQwQTDqnZlH0i9dabqlK4sIYiIbXZThsoItpt9KIDOV6zkvo?=
 =?us-ascii?Q?MPYmLhT3nj+V9MjpM3kyScTTLE1BYf7FJ0TcQjdd3rXiJAHuwuC4fUh37FLQ?=
 =?us-ascii?Q?foPgF+IZyiz2q3F+eA/mCDHuRrpgykWrtait3hXEtgn2XVJEuse17jcYqh+T?=
 =?us-ascii?Q?cy0GfC4FhlH8Rf3u5j5OdlbN2b3zAooLGuEP3Z6BgPpC8Fcs0JswEMwkd+Wd?=
 =?us-ascii?Q?IcLZye8GEppyIu6feis/OpVdERXmY3n2x+4lzTZPKdQ64vk1mH9tqhZzVQEG?=
 =?us-ascii?Q?BfMex4M15JvcnkKBGbeCKIrCvkDcT13AGhhreumxjZkb2z8nVyilzHL9HjKv?=
 =?us-ascii?Q?mN3f2HGToO59akfJlTLOkNmL71aNBJN8zheJazLhFfL6nSWDmzi13HhhpEEK?=
 =?us-ascii?Q?kFY5HTkCX8MCa7uVmW0X3nXML8uzsLqtWQg8aCSdT9AyGzzkOoPy8swZBq2V?=
 =?us-ascii?Q?I5FQKEI7q1e/WEnSBczmkLyW1c008jcZGtQ4OyukLMT8e5Oja5b1oqQK6Y5j?=
 =?us-ascii?Q?DUesxoJfwioxTmMuAM2zJkF+RypcYkNN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hc2SmJ1cr1oFwKow7BIDfPn+zZh2WASOoeLwzL5fF+EiO5ko9GCSyBquBwx?=
 =?us-ascii?Q?+hBePWoz1O31BlOv9tFWu7ERUnJTqSiec2Q9b4ABDoJ1qJzt1TUnjywLeQoM?=
 =?us-ascii?Q?IszU3SpVVZT1wfKMpiEYoFPHwOkR95wSuOfY1uUUkuHV7d1UiS7sjqlX788Z?=
 =?us-ascii?Q?lfm2DeAtdse/ARP/Fil7Ug8ZtHr4z92KiouZZhQfUx9yZGagu/W5IEYF3f0l?=
 =?us-ascii?Q?Aeq69+6qDWzLjRZSlS7MKUzlIka5rx4uaiU7BzArgXJQ7cCB1BCJ6qNJrp27?=
 =?us-ascii?Q?xMVdm/GtZom/pKtfwSKpZ7GUJWf19YJR32V+WcCYjv5lV2ELosuSrZLjAvSK?=
 =?us-ascii?Q?LrRt/e+7vr9dMie5G1aOjzRpK0qqDKpYq6KoYfkmJ94BfDhn7r+HXQl0I632?=
 =?us-ascii?Q?dhu5dL28U7De7mSMdqP92RMf2CZLL+7SGMuANVrk+3qLY3J38U9lT9REWi/2?=
 =?us-ascii?Q?KmRRvtqG5TM0osZirruZrgPGe4hHT08cLD1A/iTFYpReLObm/liHtzvYfiV7?=
 =?us-ascii?Q?7Fs13Ymbn0EYFq+puY2akajy6Op/bF7Ph2EPBmL0+lZQ6yd3V66DYoQTQ2i9?=
 =?us-ascii?Q?xKYIY8Blacr0HQz327vqTf1LSxNXc3/Zmw0NRHiOqLQzZKgSVMOu5gwr/ls+?=
 =?us-ascii?Q?SMfwDamf6EjqlDPVx5+h/nPpbhtNonAAC9DwfQAd0syY3dT194ti00skZI91?=
 =?us-ascii?Q?Hc19ON+cjLgnKmQD9NGH7xzpL7yO9USxd2vV6EkvfDU/G9AtrhNFE2BkpO7w?=
 =?us-ascii?Q?Arua9Igp79CAsXB4BP+Zbp8PwLlPq4N0J5chDqKb36EZEb8Hnpngfd81nZUN?=
 =?us-ascii?Q?DMGe5hPLWqRBpgIssjG2YYxY7Rl0Fogv7I8dg5on/8apuF2nZeIxDy8MeZE5?=
 =?us-ascii?Q?AWKZLjnaAWjPA3bmCVsIGb2Sa/wCSLRI4XIIMuyxK9Lg9bCbOpAScNIBWmNU?=
 =?us-ascii?Q?j2WgSHGwV7LKQvkkCQuzc9fVfyACn0FksLLvMAJV9fI29a4+bvllJAdT4IZb?=
 =?us-ascii?Q?8HpECKoJzufSRe3IwuhqeQpCCX46i/OvV9BN/ZlVcO1uUEiV/HKXJpi6W1XS?=
 =?us-ascii?Q?97FETP3el/6Kr7r91rZflAeijBaHZ8ga1ZpX4OTdhj6y+WEi5sXu7mT24lr7?=
 =?us-ascii?Q?l5G91kfTUgkU9QXcQZ8JlheD2ynXXNzPzz5r+n2cUhCVEfLYI6veqgOBnrht?=
 =?us-ascii?Q?l/aYpM9XrPNFBDaLW5C9Uau+HQTdqTHRT4xyI9/gkOVem7J/U1BJykzI0CUW?=
 =?us-ascii?Q?XXAK3KbEBfHlyeCnAVlB2cgNEEAxCS3SlrAECYFIOEz9kmgLcMjiTej2eL3q?=
 =?us-ascii?Q?s1aiOl5bFOMxTM/32/I4/qhDc6+TtXU2HDk/cf8TT6sCrv8F0fJGCPj6uWlp?=
 =?us-ascii?Q?+OYtQ5GjN+3M3UUDFUKECsi2wNvpfk7yweJDsnMWvZZu2GBx4ApJUaPKYl4p?=
 =?us-ascii?Q?XDdxq2twe6p8+3s/XNkjVzkRxtc2AfvtW0KtTKoGcsQqn5vX1q3Os3IVHIh9?=
 =?us-ascii?Q?QeBvQVik7Y6NrempVOUbKZd5M9qw1CK2H8UuQ+c3VD/UEZpf/niCSXNwY7LP?=
 =?us-ascii?Q?cH+OYn6xA+ihLcBdy0uF/ojpJkxNo+kKqF3Gpt8w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1f3cf9-327d-4b73-8ae5-08dd5aefc110
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:39:54.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXBrvaudCj7Ob7meEq2EvbWP90FxuLuCTcxY33lwUtjJDziUH4KCBBum9YNeNMKIic717MTi+eP+HlnMOOsaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

Receive side scaling (RSS) is a network driver technology that enables
the efficient distribution of network receive processing across multiple
CPUs in multiprocessor systems. Therefore, it is better to enable RSS by
default so that the CPU load can be balanced and network performance can
be improved when then network is enabled.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 35 ++++++++++---------
 .../freescale/enetc/enetc_pf_common.c         |  4 ++-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  4 ++-
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5b5e65ac8fab..8583ac9f7b9e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2420,6 +2420,22 @@ static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
 	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
 }
 
+static int enetc_set_rss(struct net_device *ndev, int en)
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
+
+	return 0;
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2440,6 +2456,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 		err = enetc_setup_default_rss_table(si, priv->num_rx_rings);
 		if (err)
 			return err;
+
+		if (priv->ndev->features & NETIF_F_RXHASH)
+			enetc_set_rss(priv->ndev, true);
 	}
 
 	return 0;
@@ -3232,22 +3251,6 @@ struct net_device_stats *enetc_get_stats(struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(enetc_get_stats);
 
-static int enetc_set_rss(struct net_device *ndev, int en)
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
-
-	return 0;
-}
-
 static void enetc_enable_rxvlan(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index c346e0e3ad37..a737a7f8c79e 100644
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
index 072e5b40a199..3372a9a779a6 100644
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


