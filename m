Return-Path: <netdev+bounces-246688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B977CF0616
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACC153088157
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2223D2BE647;
	Sat,  3 Jan 2026 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k+jeoPrT"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34C2BDC1C;
	Sat,  3 Jan 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474315; cv=fail; b=dlbOtun3iLV84jj74BjB1fcy7nmxYfE2zwJMMc5PBw22WttsQVIVUYWNsYPTBOIWALV4hViEtSkmMns27+HrUyEebvAEW7ArKJF5APjoIPjq66KRxaSv3nOSKq44Imy5lhco05FEw6tgZIZgBlS2z8/uDUl8mBWY5QBNz/VdMKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474315; c=relaxed/simple;
	bh=7+QKeQypp68HGWwkJKWpSsLBpV4yUF9W6ayh49shW8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LW0JXr4wGL4UnJDAkTYusMxmh3yVNxHeKO2TzS3KZj9jQ7R8of+5m3P6LzFINO/O58kEIIQ3n4letndkfKtlg1eQV7Z58Qanr6PaymVdaSngYa9CC81llnFlQr0QXIuX9yiOr7VgLb3r3c8ElJKCpaNMQEkaYYdkamL1mJvSxKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k+jeoPrT; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0OSDh56qjFcw3mV4Tpi4UbO6MhycRk4xJR3eif3GmMZ+RHtsUjuBoZo2c5QrHHpk2jHEnpiY8Q6AtUHxLrK3bQVxjHfiVZVsT7OHHmAnen9zv2biIzXKDd8hAkDIvgtBw3LAjcl6IhxMXFc5yM+aMjydqdVA8qhTDmLgjHPnZkMBUGB5SLjcKGEl8nf7vI7J4IrQF3jHI+Qw3cqSsQfip0Hh03fdAu65Cb4fz6m3uAAe5qFlVdJHSKRC2cT+ihiL55c9UgahvwvGm+iPr10GjrL1CNqwGffbvNvYba9JV41JfkMr3FMv/fP6YcMEIuvDe5OvdstEGZixtV4znXlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m0y2MM8Ojf7Y7bt/N17hBfFs5mlNQFtFdz2CCNbZ48=;
 b=bA75GuoHd7zzG3pDllyb9D2fZBV3w0NrmqusXFv/GITmcetF8SHHM9ZoDuYXDh4iBKP/FKaCMRxdJTrhOaRvwHueDIKj5uSiw7UN41B8ZcZ2Pm3v25/9/TaMQswCTe9gCaZKqZ/FjDp5OvqZS3Rgn4Y4oTR6GudGt7kPRWKktXguI7wZhpgW3TVpWfCHVjwZUYTsAHOPzjERacKCE3MfW4B0W2cJCpci0VR5tUp3ezX64V3Rl94f/J+wGizhWDhzHlU2iN6r+htTgMpHnCmXEtXiLtro1A9DImnDIBDvNzFPI1itjwat8Vg5hoiOFVByuZBYFFiyN7OIba6OF6nROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m0y2MM8Ojf7Y7bt/N17hBfFs5mlNQFtFdz2CCNbZ48=;
 b=k+jeoPrT08q+WIHlnUT3jzIF6dBejaICbM/Iyyo2ezLxs8uKuxwlFUSv+97Xz31KQHyvAFzJnaMJBjkGKSycsCK1JsI4c1FlTmOnip9/L233zrSBJVvfHDXkdsknRwyQO009TvsnnHGxQ/2n/A/2sEMMsiEmhq0S7H0pSfCH+uIw1pC63xehhzpIO8L7/Zg0kzej0gG6e3Md3FiokRGxDjDBI1Hf8xoCAqcfF4Tdr/TY14WaGAwCnulOJjSynGTouJkm3KxOWqovxabjPhgJq6DzrTuNhRNZKSyiGZs8FBOxdt8dAVJdhMtuisPd441FiW6EZJ0nx/voCTii4ve3Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:05:07 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:05:07 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 net-next 06/10] dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
Date: Sat,  3 Jan 2026 23:03:59 +0200
Message-Id: <20260103210403.438687-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103210403.438687-1-vladimir.oltean@nxp.com>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|AS8PR04MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c47027-7e4d-468e-07df-08de4b0bc587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/yoM1/jWWfgYvd5OtH4n2s+JCdRl1PrO8aXmR1AUWkFRT2WN96YgwFABpkV?=
 =?us-ascii?Q?wLwVjGS7g4YVFfG1SkyEkCR0HOhJSKkmg1oJu0pbFORjaJU9Z2RsEeIDj7VZ?=
 =?us-ascii?Q?TjDEVREcWddQQh8DMqMPa738Akduea2g+vrs8Uijis316nqJeZLwEIRgqC+F?=
 =?us-ascii?Q?Qw5H25MeixQbLVu3011WqfuWWGAuaxR8vm7W1MVf2gYjfwuhI0Haay/WIfBS?=
 =?us-ascii?Q?c07TV4aiWdt3B49DB4k1MN+fIbQP0Pn6QslC6U7ukk8Til7+bNxrDG6k0/wl?=
 =?us-ascii?Q?Y4Fa5+Yd79qJMF3/Ec8Z87eePz+LrvG9B0Q6Cx2n2FLH7C9/+9u72Awf1hiM?=
 =?us-ascii?Q?3kal8YAMuvo6i2ljEQRRphQW3+leBEGrj9ejLTo6/QtIJjdP3sAUp/iKq21e?=
 =?us-ascii?Q?ak0fTkj614FjUTmE1BuYeFEjw/qmXFIKCTxRfIDjV4iMviYmKJkV+SW5iE63?=
 =?us-ascii?Q?CB34CMUAdq/PfoysXdKyLxhmhmBsBBEwXr53x93RQpVT5naxNON+vgVPVfO1?=
 =?us-ascii?Q?8EISg2VHxZY2oZcW8qZCinxtci1OYvddRpcQ4cc4dyCiWtBnHSy++Gv3ujop?=
 =?us-ascii?Q?dkySFPKocA0TEpT1Dodv4fS9Gf1f8hfmcfL+M2A8IGiyaTEcTOHNoSAe78j9?=
 =?us-ascii?Q?Wb+PdPrnAs4ucCumqLiSY4H0ofry7VvGfNxeWAFXhHVo7xRt5DzHjnkMu4Wl?=
 =?us-ascii?Q?wo4opZ7dANgi7UdkCLFVRfzzlkDeEJpZzhN08r+TLFAiBB7zDt0AS4GLp04n?=
 =?us-ascii?Q?X19NkR0M1p8syCI7H/FwJ8nDGQMOy1qTDyrVy9RBLJHtNc6jZ/SX/dt+i9a6?=
 =?us-ascii?Q?xlhuuHyy9hKQq5P+Ff5urYbyqjXdJwrkMQIaP9yZBzI3VCIWtV3WyL8CugOi?=
 =?us-ascii?Q?TjK0+q/ZPAJL8Rnuv0mpYUbYJIpbQPKjxLXcA8Jk7Y+ypH9XP5ajLXQiGHbP?=
 =?us-ascii?Q?HQSGBO/U8L7GjOxeVMKS2rL2d1M9+YkPXnJXo3JQONSKjAE6NSt0MVP0KYG2?=
 =?us-ascii?Q?4ifAKaS59qN803MUQMhSB6hdi1Yfeo55p56Gidows90N/JIiZYXQBCqh8z1H?=
 =?us-ascii?Q?grwU34DxEvib7jTRcputANqS2UpxHSYBoq7TAbDKrh8y/Cwkvc6hJoJx9xKY?=
 =?us-ascii?Q?97RyvLnAin0bpm2eJrWR2yZIOMOc2RdIhWXztJHwKrRwN6Mm94IIc0xF/iBA?=
 =?us-ascii?Q?Jst21YCYxAiYqSfi7Fuah77J46j87cZzsbTkswuiDZDoNhtVsge89ojwWXDL?=
 =?us-ascii?Q?V3fUMlQMvGmNBpQnixzUVCJn/uP2N7P/8EnP6oOgYFCMqCxvgMWYV7xp2rV2?=
 =?us-ascii?Q?SwCvWwg9LybxxCzQBJ/rVg4RAQKJbDEoh0gLqIpQMDiUSNmoGMpTP6DYhNJp?=
 =?us-ascii?Q?Qf6VEvOSksRsqCI/Z8EpsYqWhD1oAQ+NqPesFgungfgtvdCpf9ZpGk7sY05E?=
 =?us-ascii?Q?Le0PFQxzEwTpk7Z4oVgSRNX9K+UvR76jIYqqzyXG8m2GNacowrgO7MtbVZh+?=
 =?us-ascii?Q?7lxIm/3SKMzPxHVlxuJJNd+F7+EtF9Hg+F6Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bGX4gWsq6+aiVtCWfGQaUGuk2nnXxJUHakKWoxMkDpOXGH/p462G9HPqTVEh?=
 =?us-ascii?Q?b9E/DSaDcNIdt8vOPMwUvelb7nhzTJpHUPynGFox1H9HYK1YUCV/5PDhBOiF?=
 =?us-ascii?Q?k0JT4T6gPAGwsKKGVRzk3Citq7SgpSZ24nrzUYtov+cGi/n4+h3Dj+JGtWFP?=
 =?us-ascii?Q?mzN6P+CRE19Z5uQtOy1j+9HLj1rHTkgN1sQZeqM1jeOHAAawPFHk5s7S4++r?=
 =?us-ascii?Q?dU4RDWwNacITQjI9Hf8en2Nz5qbynvAeYagGmtZSdu2hp9YAa4zbwYrgoOKO?=
 =?us-ascii?Q?W0A1PfraQb9sCLl7tx1zqNwoTbyKHyXR2ZpcP6rx17PZvR8sKavQ0HyzvmkA?=
 =?us-ascii?Q?SEkUgWgBJcBHRstvTtl/h0bcPpLmlYurn8f7kWgUUPaM8GdLHgFCSMAU+stV?=
 =?us-ascii?Q?fXc8oJw0js4zzS59RqntL8HB6T586GGVf7nCL+erSFwnsUIPmux0CPyB+q/U?=
 =?us-ascii?Q?skR9VkzDtFspeASL8q99T1OxHCdlC7rjh27SWi0/Bca41At4qVLly/IqDjhk?=
 =?us-ascii?Q?kh1DbA8m/U8UoRrvCQMve5DKTN5G/wTt1wJLYGvg5nlJqOTtNkcR/6NDQyWI?=
 =?us-ascii?Q?Iw5lQBpAzRZRfP3Wge+KvzcN+aMlnD0WyALX2hkkXvPh8xC5YqQJcj4dkVBQ?=
 =?us-ascii?Q?Qc2C4uLk3x5JhGyIXK7Dgjn9ErJ4hSZEtwM8nuC21QAtsck8dcbwO/Pd508v?=
 =?us-ascii?Q?aTLjTKaPEbRG1R4/E5E7V+k4uFlR/T1KXYD1B/cH/QcmKJ53GtbIb/g/7u/e?=
 =?us-ascii?Q?ujMIKxrnKoLYaXB8pERkbAtrQTc4Jp3WpsVpXYt98Qh0XNsZhDyurEeTvdI6?=
 =?us-ascii?Q?tIBCFirQ+FZshUcWmVXQ3c7UX2xDNgQfcSolCE8Z2d8zaMAde5mQFzuvQqQX?=
 =?us-ascii?Q?2/EBy2JOqIlzdTtBGP9bt+zcKk1B1exlzFRBSqc+aen8wE6YnN3XHST9dAR6?=
 =?us-ascii?Q?tyNqX21KnUPXAxsk5FW+sLIXA3btS5clMWnkxjcmOXaMbImQaFGzXQRJimTy?=
 =?us-ascii?Q?vxJsNnZgAcqIFLKTMIkboxfSWEMNDB94IxHWETl6h3TppbaV1TllgCL1LsYL?=
 =?us-ascii?Q?I7TSm8MhlCEJ6ALXQ1yV1lv2b+qa6i4mrqMCrZ8011yikmOobPbXyVFzDtv7?=
 =?us-ascii?Q?KiOX/JXXhD3V9kctk0dotY1h0J7h0/xZSC52o/KYn/WScKPAASRLQzQMnyZR?=
 =?us-ascii?Q?YUBGkZZnIFMvkJ/ZHRW7FO4TLx8811R9fYjpQi6G2vYmqbX5QK7nidGLUaxr?=
 =?us-ascii?Q?4KYgVS+ncXzPoxk54RbcioUiOoi7GCcPzz7jpQplytSCprgmPG0OHRy2uDwm?=
 =?us-ascii?Q?bSXYNa21dfGMghAN2q6HN48djRBopQbgP4CAr0cng8jfJra17ukWeM1+Piek?=
 =?us-ascii?Q?qIQJWzQuNrXMBGMq2OZdLTcVpybh5gHyldHfUxdIkH9229PGdO99Uvw7XtPC?=
 =?us-ascii?Q?FgljhikzQU1dAFMU1crm/3UBI1Ho2CxS6o5s0cwXxg409pPgvSyznAprqECf?=
 =?us-ascii?Q?9dvY2f05+EAVHBXD/Gq4q/wSCI02UjcWca91l+FiIoMBNgXK6Xv1fM5Qa61K?=
 =?us-ascii?Q?J26hsQJmwV6IWp1cqw3h97XP0rv1rds2nS6VRuWv4rcunbwAbiazobpPe3ES?=
 =?us-ascii?Q?wOt8l+xz+bU45zYQWXnmUGtltKrdBOcvySvi3OFm1JplchiDimww5a1JJHJW?=
 =?us-ascii?Q?J3weDeEWGB0skeeOT5kbpU4eEjhCzX3PEfelmy1DzCsoGAL/SC+2DLl3Xvlu?=
 =?us-ascii?Q?HunJxyrQibaFJfEQrUDz8Vmawu02NEI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c47027-7e4d-468e-07df-08de4b0bc587
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:05:07.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAnTyjRwuYTkB3ZH+sLc1kgWOpfiSJqpOZI5kDN3lS74TMY5c4d+0WKlB63UaPZ0r+1YQZRvc4/Sov1kq03FzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Reference the common PHY properties, and update the example to use them.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 .../devicetree/bindings/net/airoha,en8811h.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
index ecb5149ec6b0..0de6e9284fbc 100644
--- a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
@@ -16,6 +16,7 @@ description:
 
 allOf:
   - $ref: ethernet-phy.yaml#
+  - $ref: /schemas/phy/phy-common-props.yaml#
 
 properties:
   compatible:
@@ -30,12 +31,18 @@ properties:
     description:
       Reverse rx polarity of the SERDES. This is the receiving
       side of the lines from the MAC towards the EN881H.
+      This property is deprecated, for details please refer to
+      Documentation/devicetree/bindings/phy/phy-common-props.yaml
+    deprecated: true
 
   airoha,pnswap-tx:
     type: boolean
     description:
       Reverse tx polarity of SERDES. This is the transmitting
       side of the lines from EN8811H towards the MAC.
+      This property is deprecated, for details please refer to
+      Documentation/devicetree/bindings/phy/phy-common-props.yaml
+    deprecated: true
 
 required:
   - reg
@@ -44,6 +51,8 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/phy/phy.h>
+
     mdio {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -51,6 +60,6 @@ examples:
         ethernet-phy@1 {
             compatible = "ethernet-phy-id03a2.a411";
             reg = <1>;
-            airoha,pnswap-rx;
+            rx-polarity = <PHY_POL_INVERT>;
         };
     };
-- 
2.34.1


