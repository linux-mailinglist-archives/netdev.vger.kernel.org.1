Return-Path: <netdev+bounces-148012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7729DFCB4
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389B8281C03
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BCF1F9F71;
	Mon,  2 Dec 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hOoPTUEF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985E1F941B;
	Mon,  2 Dec 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130111; cv=fail; b=K9hk17ZbE3zHjkXr5GXXjiXilLsKx4L16QGxJP32G0j9oON5m0C/dYq0/sTRWGgN9P8GkO14E0JZPK1126kdArJMxN3Rxx79iDr4v0HnmFngE0yworQq2bB9uumGW2swJ5BLXiCmedXoaWnIQHWQJxNCKyPOzw/x7aGbJxAzRmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130111; c=relaxed/simple;
	bh=r/LXM5DEgDK8nm2aUIVERo9wWUoqH6PCF57ZBLAXtpU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sCvUK2yJyOjzugFZHcvRtnrGKEFQLxNBAJXESLGnYsSsHQScShrYSb9KzBMVMVgcCmgp5kF9swLxh7apHyoQJuiUeR3sf9AtSKiP5+KjEFAy8kUodKAazAfJ7jCnAf/RD+Xi/Q7EQZz1B0AEfMS6uRSmwPhbSz64kmpqlVztZ8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hOoPTUEF; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud6d/yzk6Go5ztu+Zm5dijdVIGqRygu26KXMmaD5vBZPWaZKecSWIe9YvI37k31HWeDUVgFIJkoRDLRffODVV/r10KFMo2eJlhMjJitecVEtUb0T1pqbg6zsOXF5lI+/CnDiEA4gt1u9XkhfzpxOxNOHhAaXLlP8y4nW+84X/dMMMtJCubykODgvDE8GU4kpeGY0uuxJGum3H7ij19XKXHY98591qZkSnUtO0EeANp7lLnEqSPw+xEyDLMWT5y62Eo5UDGhwC6B4ihEO6i1gJ/U2lzutnEUDGdgHrUXDyGExKX9VhS+DSZOG7/LzNXJ5BndOHg2n+0SfS6Yp+VO6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXxdQ4bIaH71hnjp2jOcq3Z9xwcfCfVOT42hIPlRYVk=;
 b=yFH+GVnGB1yJgTQGTCKNaZFwtaZvr9nMt4wfwosQpJ7FmKcEzpb0po4nF7fKboI8Od+QQAw2ou2or3jNi5OmZgZhR73co1hNpsT6esYIBCBdFR/2QizsNJnHioI8xc979+Bsn6Mi7BXQjL5dAL18PMXh3vx0QyjeiP8FPdojGUJ81xKjDNxwTKeBZTFszAigLKs4vnZl0SYAOI7Dyg25vUE2H+X7thTbaI/TeWXVLk38y7ddqhBuuWctZCsewHupDmNnMqhuBcOalrSmYsIy18Zgq5Y6Xl10Yyy+eMozUUvigE2cC64pZ3+bMPaCtyjmis/jmRDpplDo4uzHLglPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXxdQ4bIaH71hnjp2jOcq3Z9xwcfCfVOT42hIPlRYVk=;
 b=hOoPTUEFCIkn8I/jk1Yh5/haDwRqgbdBoEkLWh2GDcKedBHlglXaBQLJbqiyFnxiiSH1LqEusDSNWkppug/qINUNLJzsILdh4NwXzIVJz4g8J0pQwmT0Rks/i+MognBtYNQ5jNAya2af5fsMvsQXtWj2hv5hRMi4DM6HnfC0qG5Cwnf3DdOr8Puw9GrjUdlK15POvYTHDlklVov3ls8QooCwvfEhOTosWVay70x/1d7xd1FHcFQlcefg7Pu1zQQLgrTmxkO7xp7u6XzEHNeCusHhklFeNnvxD6ZfDrvPlspSvjfEbJUeU5Q+NLH0AuhZL0oUtWnZkM7xaJnLe/Tmsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8636.eurprd04.prod.outlook.com (2603:10a6:20b:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 09:01:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 09:01:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com,
	heiko.stuebner@cherry.de,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net] net: phy: micrel: Dynamically control external clock of KSZ PHY
Date: Mon,  2 Dec 2024 16:45:35 +0800
Message-Id: <20241202084535.2520151-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: cc01cbda-1324-4a71-8f1a-08dd12aff20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d4bJNYaaBH1FDzUtOfguQfM66Rdk0bJKcDRMy2VbyIPiuOxzEEEd0c4tR/Dn?=
 =?us-ascii?Q?W9MrW4QcyB9xFNmEcuiagf6mDpPiK6CYSIdY/FS5y1d0hAoKSBECbLy92np8?=
 =?us-ascii?Q?9ql7EY7S8nyMc8GO6yL8481OXdfAsOrLoga5sP0syQt5Zk8rDeSpZNqwf7HE?=
 =?us-ascii?Q?+XRmjFlkcFieH/qHudtDHIBMqyrNL1iKfSnIBlY/z8ri4yAA2UyNwK31L5in?=
 =?us-ascii?Q?kP5oiJ4Ipv8RrsB97uZ9FVIUpfZWBrFGy5VZpP7O0mLVKTZwo0NY3O/UpqKT?=
 =?us-ascii?Q?9gwK6d6NTiYPcC3xkRMzd+wgxJQPi+etqfrFG70YGL1bwys7b2XTad/pDXrZ?=
 =?us-ascii?Q?+Oi51iswWCPVJnw1JLCpYwEnjeNs0pU4xj4vDiOgVRUY9tQ6VX+vKsRWmUWP?=
 =?us-ascii?Q?ylM4JG1Px28fWrQ1FRMrfEdmu3TlWZ00jIUmbvnBp3hZqwwW+QLsFznN5Pyd?=
 =?us-ascii?Q?C94ZGk0sEXUYBaeE/KdeihaSIxvt0q3uS9xXYv+6aN89z3D2xl7oK7DNa041?=
 =?us-ascii?Q?bVpr8FTAiPHp6v22jEgkcKwUqQJKJyBMO2j1PAw6YDWggPVAPaF2+KN2NT//?=
 =?us-ascii?Q?X+SiVsIpdfYpjQDyyztMkD1TC+e/N1U8bekhZZr6cB2DTwuFxMy3VPKpyEtC?=
 =?us-ascii?Q?SDP7XI7rx+kUbVV7nShFNdTXImNuTTqS8GXbTecU03P91GQsQQqWYWy7jYIO?=
 =?us-ascii?Q?11meES54AhYYAyE+/w6fUzD9FwiQkjf68hITlxM2cEnBjq6/6Sn7V6oIkMxC?=
 =?us-ascii?Q?elQtvRBmNkhbzPhspfR+tTRYHLxyvU9tx70dTZdb0O6cOtwGyLvQPUEiOFST?=
 =?us-ascii?Q?YKidOGM252wvR1oAKQN8fXZQwhH/9RpIIxRtJl+/8JwzUqTqBnlWBB8Z6pA/?=
 =?us-ascii?Q?LMG9m9wSrXwXfDAUH00aWJlHtwxyV6MPEwR3Bg0xo9t0F73smX4gir1Jvvhe?=
 =?us-ascii?Q?jW8AzHhokpRl3+NlajGSyNvpDMB7lTcHNz3QNp3ASmyN0j6t2+dTUNcAdVa7?=
 =?us-ascii?Q?3ltPEyqYPj1kLbPCHkBxc3HNs5jqeV6VwCF2/vIWB83TylLq1C+OabohutlJ?=
 =?us-ascii?Q?+FhoBqFGmdkV/gvdCrA8wvsT56mGS6ErARHiUyb4XSL0wn5tt8+UX4zTIaHj?=
 =?us-ascii?Q?LSSkyHFDQ2pOJVwP9XiQuj7KCLGI1jcxg8WDitKEvWi0Q/mYjQpzb8JI8iK1?=
 =?us-ascii?Q?Iy1GWV9I2UUei1oQ9L5SzDzT9NryeOKVgmj5gGGZ8sN6+8EB6pcsTa44rUa7?=
 =?us-ascii?Q?bENVJXSuJVvRIvw8hVSKYqxjEoPwLNpRfe7QvqTHyTThi65dqfWYipGLE1kw?=
 =?us-ascii?Q?BhCiPGK44Fawyz9Oa/XdRF3BNHfI1DPdihKONR+cJM/wT8bK+aHESyY/E/iq?=
 =?us-ascii?Q?hX83Fa+Ydg9a85RisFkwC3CyJjyFnoqxHtBQ35qZylywmaEWvIyNWdV6qhQc?=
 =?us-ascii?Q?Q+xEW6I5q8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vnU9WNZnVlXNzGzc8a07vZx5T3lGMPFXpAERc7BPULmAQoIk6FgBFt4UwVek?=
 =?us-ascii?Q?AB0AXPC7RBLheSbmV//3u+U2h8pxEf0kSpeqLS9anMXKBYZacNnHds1zvHnE?=
 =?us-ascii?Q?WcTUdqunfssUcTHWqUgmWlSk9St6DTjER/QbDgMG5aYwdVFWgFVlzUlkedtO?=
 =?us-ascii?Q?Koy06leetWCmyshZxUXq6N5hRaCIrHxqc2qnyZNAKOCyGgp5i3udW+xSRQ/J?=
 =?us-ascii?Q?iR70PLejN0SWuFOaNFk7fbR2sbRIBoGjrFEiLXhpSbm7Ncvo1y764mzOE9LH?=
 =?us-ascii?Q?5fJJljAh8jpMgnxpI/o3rbU2Rucw6u0la+/30Z0g9qVUQ4/uJx49LjS1FN6I?=
 =?us-ascii?Q?R1Wo3klxvwXywjtp9dhoZ0STNOHZiTv0bd4RcF0PZ878fT2klPaYFp80Yipu?=
 =?us-ascii?Q?1BgG8cW0u0LZLOIqSEsDrUVGpKJWzD3mTv/wEzRIn6fkbiqUOb+KJkvLLaSE?=
 =?us-ascii?Q?egAZNJT1chxwl3+T6sDv5Bfcon+3xl09phYUHWni7xCDOAFYDSzdyQyrVZ5G?=
 =?us-ascii?Q?SyXR2cw3rvpbuaCs5D/MytqbN6sLLo1ZuFk2mcd4VqZsaDuN1ANEfDQaJVW1?=
 =?us-ascii?Q?gZHOZooOhGCok+yuspuNv8RXQ8Ckh3pinpX5W1h9/U3z2RWCD1mXQX3/HwPm?=
 =?us-ascii?Q?/cNmkevTFOKm77mZhpTKILeMG02kXMldUZbT3PnOMu7uEIOsaCnrmEBJO54v?=
 =?us-ascii?Q?OM5YBQht41D5dkPqHY8zHTOsCiLEAwotx0lPKZfeT8l5HHnuWf5DbTR7cg41?=
 =?us-ascii?Q?PEU/X/5TlHiVYIGjpC7i3jMLocrzXHaVUjLwtn/+SEBVqaJ7Qo0ed9deU36f?=
 =?us-ascii?Q?b+Ci0CDH7gOQLhATkRUU5m5mmxD3BTVgwsr8xUVldMfHVnwjjglUTqY2XmQh?=
 =?us-ascii?Q?OJMAmYBdgc8Dcp9dYii5eYcgDA25Ah/X/4PE56XXeF1BAEibOEzKqbrwLjH0?=
 =?us-ascii?Q?SnaHzfae0hgH/+W3E1LVe60yRvqA44uTySg5mySGdjxDtrRTjOOgSYY6l+DR?=
 =?us-ascii?Q?F0wY/Moxy91BB88nI1CrYOSt2U0FkPEorQOUI3y4xgFuTvbj+LyrEujBaWBz?=
 =?us-ascii?Q?n/2xAxiuP2eE+Ap7j9oEBWWR64Zo/a4Jr0ecFEAXqPYt/RwKVmaH8wicTIma?=
 =?us-ascii?Q?fYntHgsBPQWHO8x8W8kWywkRYz3uG2+YJQ8TP+shjOARoMNee2qDqzcTUC73?=
 =?us-ascii?Q?ppV7EYGkRQmZ/mre1zWVs9PnOW3EAuH6oyezO8yS4z2SurzE/4oZrWIn8M9V?=
 =?us-ascii?Q?apbL/SQPc2UrEouz4N8FjkBlTADKOZ9ao/z6gbEPhefA1CE86mIRCLvLz1iy?=
 =?us-ascii?Q?1KZrKPgwSDbHSEm1T30LS52gEh9f2EZ8Wh9Ty4n2w9KCvp3+P2q26ZxGROLN?=
 =?us-ascii?Q?BUxpTAVhPPBuO304WNo4rrxwkp0tL/lNIZ1K5b3dfZa9Zf5ur7kIlbxq/Yx0?=
 =?us-ascii?Q?U3GHEtB7Fna1uup2smjKVPqpUr9cqC4UYjvJYRXyhS7cjAujDYRVwuOj4nz3?=
 =?us-ascii?Q?5N2UlMqA1OeduFN/IL7Zxv4kD+JTTVRXzr6qEY7Y+YwVi1oDfwSBbQJtKgYa?=
 =?us-ascii?Q?9igajS6XNWW/gtUmYql1H0VwFf22fkT4Xh6xGpQA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc01cbda-1324-4a71-8f1a-08dd12aff20b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:01:44.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79jdkNkBRmkGiQHvHl5RqXj85bNuTLUQqFa93J1C//hNHbXH9w6fqn9n911R7HUkujZamBS0iW0uBSrQst4uhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8636

On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
clock sources for two external KSZ PHYs. However, after closing the two
FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
not 0. The root cause is that since the commit 985329462723 ("net: phy:
micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
external clock of KSZ PHY has been enabled when the PHY driver probes,
and it can only be disabled when the PHY driver is removed. This causes
the clock to continue working when the system is suspended or the network
port is down.

To solve this problem, the clock is enabled when phy_driver::resume() is
called, and the clock is disabled when phy_driver::suspend() is called.
Since phy_driver::resume() and phy_driver::suspend() are not called in
pairs, an additional clk_enable flag is added. When phy_driver::suspend()
is called, the clock is disabled only if clk_enable is true. Conversely,
when phy_driver::resume() is called, the clock is enabled if clk_enable
is false.

Fixes: 985329462723 ("net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock")
Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic ethernet-phy clock")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v1 link: https://lore.kernel.org/imx/20241125022906.2140428-1-wei.fang@nxp.com/
v2 changes: only refine the commit message.
---
 drivers/net/phy/micrel.c | 103 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3ef508840674..44577b5d48d5 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -432,10 +432,12 @@ struct kszphy_ptp_priv {
 struct kszphy_priv {
 	struct kszphy_ptp_priv ptp_priv;
 	const struct kszphy_type *type;
+	struct clk *clk;
 	int led_mode;
 	u16 vct_ctrl1000;
 	bool rmii_ref_clk_sel;
 	bool rmii_ref_clk_sel_val;
+	bool clk_enable;
 	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
 };
 
@@ -2050,8 +2052,27 @@ static void kszphy_get_stats(struct phy_device *phydev,
 		data[i] = kszphy_get_stat(phydev, i);
 }
 
+static void kszphy_enable_clk(struct kszphy_priv *priv)
+{
+	if (!priv->clk_enable && priv->clk) {
+		clk_prepare_enable(priv->clk);
+		priv->clk_enable = true;
+	}
+}
+
+static void kszphy_disable_clk(struct kszphy_priv *priv)
+{
+	if (priv->clk_enable && priv->clk) {
+		clk_disable_unprepare(priv->clk);
+		priv->clk_enable = false;
+	}
+}
+
 static int kszphy_suspend(struct phy_device *phydev)
 {
+	struct kszphy_priv *priv = phydev->priv;
+	int ret;
+
 	/* Disable PHY Interrupts */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->interrupts = PHY_INTERRUPT_DISABLED;
@@ -2059,7 +2080,13 @@ static int kszphy_suspend(struct phy_device *phydev)
 			phydev->drv->config_intr(phydev);
 	}
 
-	return genphy_suspend(phydev);
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
 }
 
 static void kszphy_parse_led_mode(struct phy_device *phydev)
@@ -2088,8 +2115,11 @@ static void kszphy_parse_led_mode(struct phy_device *phydev)
 
 static int kszphy_resume(struct phy_device *phydev)
 {
+	struct kszphy_priv *priv = phydev->priv;
 	int ret;
 
+	kszphy_enable_clk(priv);
+
 	genphy_resume(phydev);
 
 	/* After switching from power-down to normal mode, an internal global
@@ -2112,6 +2142,24 @@ static int kszphy_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz8041_resume(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	kszphy_enable_clk(priv);
+
+	return 0;
+}
+
+static int ksz8041_suspend(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
+}
+
 static int ksz9477_resume(struct phy_device *phydev)
 {
 	int ret;
@@ -2150,8 +2198,11 @@ static int ksz9477_resume(struct phy_device *phydev)
 
 static int ksz8061_resume(struct phy_device *phydev)
 {
+	struct kszphy_priv *priv = phydev->priv;
 	int ret;
 
+	kszphy_enable_clk(priv);
+
 	/* This function can be called twice when the Ethernet device is on. */
 	ret = phy_read(phydev, MII_BMCR);
 	if (ret < 0)
@@ -2194,7 +2245,7 @@ static int kszphy_probe(struct phy_device *phydev)
 
 	kszphy_parse_led_mode(phydev);
 
-	clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, "rmii-ref");
+	clk = devm_clk_get_optional(&phydev->mdio.dev, "rmii-ref");
 	/* NOTE: clk may be NULL if building without CONFIG_HAVE_CLK */
 	if (!IS_ERR_OR_NULL(clk)) {
 		unsigned long rate = clk_get_rate(clk);
@@ -2216,11 +2267,14 @@ static int kszphy_probe(struct phy_device *phydev)
 		}
 	} else if (!clk) {
 		/* unnamed clock from the generic ethernet-phy binding */
-		clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
+		clk = devm_clk_get_optional(&phydev->mdio.dev, NULL);
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 	}
 
+	if (!IS_ERR_OR_NULL(clk))
+		priv->clk = clk;
+
 	if (ksz8041_fiber_mode(phydev))
 		phydev->port = PORT_FIBRE;
 
@@ -5290,15 +5344,45 @@ static int lan8841_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan8804_suspend(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+	int ret;
+
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
+}
+
+static int lan8841_resume(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	kszphy_enable_clk(priv);
+
+	return genphy_resume(phydev);
+}
+
 static int lan8841_suspend(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
 	struct kszphy_ptp_priv *ptp_priv = &priv->ptp_priv;
+	int ret;
 
 	if (ptp_priv->ptp_clock)
 		ptp_cancel_worker_sync(ptp_priv->ptp_clock);
 
-	return genphy_suspend(phydev);
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
 }
 
 static struct phy_driver ksphy_driver[] = {
@@ -5358,9 +5442,12 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count = kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	/* No suspend/resume callbacks because of errata DS80000700A,
-	 * receiver error following software power down.
+	/* Because of errata DS80000700A, receiver error following software
+	 * power down. Suspend and resume callbacks only disable and enable
+	 * external rmii reference clock.
 	 */
+	.suspend	= ksz8041_suspend,
+	.resume		= ksz8041_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ8041RNLI,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -5507,7 +5594,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count	= kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	.suspend	= genphy_suspend,
+	.suspend	= lan8804_suspend,
 	.resume		= kszphy_resume,
 	.config_intr	= lan8804_config_intr,
 	.handle_interrupt = lan8804_handle_interrupt,
@@ -5526,7 +5613,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
 	.suspend	= lan8841_suspend,
-	.resume		= genphy_resume,
+	.resume		= lan8841_resume,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-- 
2.34.1


