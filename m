Return-Path: <netdev+bounces-236746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993D0C3FA65
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EF73B2A25
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89531A07B;
	Fri,  7 Nov 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TbhluFCP"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCE310782
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513715; cv=fail; b=GKelfnLYfgLaA5sJUkfC2+hXcdNZAeUB3IIw7lbVxzCy2jWG17QXiU6tHe0yEtKPavCgSmTwxGMGV1wFJ/COVK8SxSSbzzmkeV2lXxZDeZWa12vNJbXZx4xjIrLudrjPr6BTt2LOZCC/ti9iOo62r0Y7GSYXQxP5BJzS0PYC/jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513715; c=relaxed/simple;
	bh=mYx8mA5EuIkgBeC+Yjrh5zZfyYFwio25kdgX+kk89/c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FvT8Ni2CR8+2qNOYKjftm994N6s5azNJhKWhmWY6PQrBYtRLNhOMIy9BMUhb6WKETI5BGoEIf1ryUlXH6GW8MKuW37ixE4VxxXkCjiLPi7omE0g4FYwUqj34NnuePk5aelfuAL/jGutHYaNwmw77dPeCqDB+5/XjkWoubRt9ruo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TbhluFCP; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mk/B6leyc3M/ExKktHXxE5i169hkdAK6T83lmoycfaEhYwvYwXc66ktNRytaMbZN/tfSidn5OzCl/48QMOIxae9LS/afhu74rrpcnOb4HSOZSzEQRMboFe8MTfA4GW/BwnzN9NnAyZ3F3EKkrjsA6vbFsI/uIa2dj3s7z6ktr7FEMbhcVxOjP2LkS0TGtp3uJCgnsMbm+RdWd6YN1QjsQJHq9cj70GBeZmm+1xVpY8/Qf4gwWIM+uB8KKbO0482yurKjmY0I71HC0XRWGte/vFvfrPhqxcbJGr+Zqbn7Mr5Ev8kBnqtaZ4jmQp3DJItMGE7cHuujq6QvzG048S0NxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQtIMiN1j2ZnSn10cCQTQWgZ8FKI6toVSSSeTVyXFIk=;
 b=mzA8t+k0ybpuRXb3Fo9kKFgebS3LJkADGw2oaS+jwQC8Vfkd37EaLpkiad7SePOQ2Q1O2vWDGbKgr/ZkauLrECFqfg5hWql+dPQlSUDuLYoT0fuU11bSxW8JDRgjalQqRoOU2+i39/g6uv4f58tp1+NoLUxqQ97sfUUWo99qPgQMyBck2Lk4WMpG0+zUx677q1NA7LQvnAAJpBs5t1lJ1GBirVniyqhtvm+1r23fg+qx61vbdu+Kp22ktJMaiSIoew9fkyVt6jiOvtW4vgmJ5XcNNpqK7GZDA1nuTICfpZcVrRdNaPo9ax8bS5ZxkqYKL09fWV/oxtF9xW5emfCgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQtIMiN1j2ZnSn10cCQTQWgZ8FKI6toVSSSeTVyXFIk=;
 b=TbhluFCP6CEtblc+yBefs9y5ML7HK3F7VHtLU6V6C0xvs5s2l/FLm4nOcRhlFSbIEU1M7dJgIcHQ7+FS6Hd1I0HC5nah/IHfFqw/yoSvM554bTl5p3fU0Gbmx6epIFU7WEx6mj3rbTLGhlMrFciDJcvCmcSQ7pH5pjJ4oNeI3Gof6i9krlJwyXAkpU3UwWR0Qr6Hg8ximnWc6RLeUEYp+JRymjna7dtiG4mX+Iv8xNBSZvvjaIXTkDnuON8p+4lyHwjWpn0qr3ajECR0UUlVhdFWGQ5GAIj6i/2Q/dfJdfbT5XaDFWGr81UDk2tYAbwWDKk6SaZvRl1SuS2LKDGooA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:08:29 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:08:29 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH v2 net-next 0/6] Disable CLKOUT on RTL8211F(D)(I)-VD-CG
Date: Fri,  7 Nov 2025 13:08:11 +0200
Message-Id: <20251107110817.324389-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 694463cd-7513-4cd3-994f-08de1dedfb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|52116014|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ewtgis97jKtLD41yEGHpCSvYXLjO2sr9Rb4LMvuqTjjrrAD29zJqi2QXYm0Q?=
 =?us-ascii?Q?Afx/iy0JHgvwRIlTb5V/GXTgle5Ko+ZInfeGj5SrL3cYXwN+4BvuIZ+QyLpF?=
 =?us-ascii?Q?84K3wdc3FVxaEYl2QhhsLWMD4hNo3LScwDTBJTXToJzx8ymquYuGiTrkVkrt?=
 =?us-ascii?Q?4u3RStm2mK09kLcOQsfNUvvIuaDxJSn+4wfc2stERAcESZeFe9HMiTndmJnl?=
 =?us-ascii?Q?ybYU9kxORsf8E7jFh7KwvCy3nOSX2LwBflOS9Putq9cNnsSQJqQ06lBDfgsf?=
 =?us-ascii?Q?Gn4xdEaHR+Sb5rHExerbYePHt+pWsi5iZWi6/CZXyYDiSFCq7Hh8oV23P35b?=
 =?us-ascii?Q?DGonWorLQ/hVRmP/8B68kxuvLETJ1q82t3gMbaPEy0hTVTEEJLPrIlffviM5?=
 =?us-ascii?Q?g9dSMHFHhFrdeD3+Nj5VMDV4GcWKAygoAOsvHNtMKh77GPXN7/xFPHi0xjDr?=
 =?us-ascii?Q?kKEQQjJLBYQxzju/pjirrqSVGIcg8csB2N8xxjSvQ4ijvdwY7QxcNosQCTHU?=
 =?us-ascii?Q?s3EpUrNI5it3ZLW0cW+TCeZSutCSoiQxtUvOisb/DkSbtViUeIUQG1QBdz5e?=
 =?us-ascii?Q?pe0x9uzkLkvJcjTpjaRbnSCZghzmU+ShpmjaDtuL3X4zUpCvDDSGSZdLtPF+?=
 =?us-ascii?Q?+lpeSE47RBUsAu6+5p9KyxblU12ooil2gWe61pIkgkuls8CYRrIBZgRySd06?=
 =?us-ascii?Q?xXw5poHacjPjNKI7/pq8xuMuAt8bqPiGb6GNv8Ww6fiJgD05k42Y51IuGjKz?=
 =?us-ascii?Q?f6K7mpEwmOtELPAxn/2cB7nqgWFnFocLkm/jk2r8r5mXcLzI7tCjjBc7M4u9?=
 =?us-ascii?Q?s45T1dQD9lpi9JgYniAyayhxPI8dRUI32HdmOibBjfRDFCTa77gaRPUOcbW6?=
 =?us-ascii?Q?q2aFK9cDx3dD9k4BL9pgkR7lKY5fpiEyXSoP9rwMmXy22Gq0loW0BpaK4iyB?=
 =?us-ascii?Q?WYTTf6ybZNy8jrJU8Dne4ZAJqoDdjBd2+ezwRQpr+YwQgiX8Vo3fA5OMA9bi?=
 =?us-ascii?Q?20QV35kMm+RUILOUEo6MCYUAGX1m+6lx54HJU0aQFIWoGJW8DbkLRP7oU4KB?=
 =?us-ascii?Q?LCmpV0MW9l+HKmWyiMhA/ZIS9PCATf99StzEKgjn9GACWf/7WvHulUHJG8Mf?=
 =?us-ascii?Q?6bUV6Hh2G3t3X/lKTaozMI0lQeBoCJjmxStzFpgJnT7nU4sTMIDdfiUw5mRR?=
 =?us-ascii?Q?EViNM6DtJCnHAwuH96Qh65yInKBc5L0sZlBzrfCcqkm6Xq2LUUNfaj7NgVS+?=
 =?us-ascii?Q?9QXVT7JGaRh8CSHORzOeGhg43hyU7GBYIRvI8RpAyN/999oEmMez00OSWmvo?=
 =?us-ascii?Q?5iO7sLL4z8MH6c5J3dl+yZyqSl5F2IDL+ORvVW4oiD8jFOFYVPSFGZ/d51r5?=
 =?us-ascii?Q?Uz9uquxgShims+kWIEIEGcWPdn56E9VwO5bnYryBekq/hQKbiLbIHOaJvIio?=
 =?us-ascii?Q?zAVijnFRdfVfpM7rXmqHrid4HppvcPpQtoI/xaoa1x58rSZfIYIOeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(52116014)(376014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l3doxx4OZGfFQi7+X2SbDQpH52EhEZ1VRo+3vSKJ/CSMTkMeRh8m6Wk07nVy?=
 =?us-ascii?Q?i2YIyQraRmnongM3OE8cWypXRh6PKWKxcVUG/EI87rIr2FXAyjKo4Kv2SBJ3?=
 =?us-ascii?Q?+rS1nPXeKkm53LClXmIX8Wphebe4PmrChUHa22m7YNr6shT8aTCszpULmxDt?=
 =?us-ascii?Q?5O891vXs8RK78UhexPjOy3Ff6jr6KZU7Z912Eovtf8knjQdPfwScAP6854Gz?=
 =?us-ascii?Q?v7fYUFWr9ClT+wLhEAjCbDStmmO1oqMpPnGgrkK3+uhgAinJc4iNVDSq3f/i?=
 =?us-ascii?Q?MaC9wi9w74kr4kepF764f+c3yzsTW9ikKAHran8haS4wBeqNUMA8wQzoY3F+?=
 =?us-ascii?Q?IELt5jjyZCJ7lyfxJ28+ROEAT/8+cUaRVnjl5ZFl8UjDFbI7yfF1GBUeW0P0?=
 =?us-ascii?Q?fbw0ghvQpvr5o/k3WKEugSZrLQfBdZpnkiKbBarcHP1sF9KjOHskVO000XZp?=
 =?us-ascii?Q?QzYnxel3feZ9wP6Z9C3RiQSBVPPHx9CkH6Y3O44Bc2iIAlPGsreFH7835a0G?=
 =?us-ascii?Q?5dw1A7M+jpR1lpKpb9a3ZgXUHpPnmmC3gq3ZF3/UBjdWkL4FIjvk1xtkPjrI?=
 =?us-ascii?Q?V2aaSWMy9P273LPyPPF6EgKoYrbHCGJAsVt22hMvx389zOcj37hxGGRJRApE?=
 =?us-ascii?Q?1pL5T0B/sN38/XcRYlxmfJl8gammqU6A/kdQpdGeWkjRd9FsdR3AO0tCHHWA?=
 =?us-ascii?Q?ZIP8cnxWT9eSaWg2GKbB1BEcCMn4sGGH2Wmof+ROOohBCWZKW4lsKgT4ccuh?=
 =?us-ascii?Q?ukUcElHnRNmgQ0rtWTzuBt/HoJKRqS7Im0U9M/YfRdUxL6DFxNFNVyYrtE0N?=
 =?us-ascii?Q?eYXOhYgB9/cdrna2/FG+SFLsyWDcxys164aN/RkzWq4TmaHy6YNvOak+X8wU?=
 =?us-ascii?Q?Ro4zVV0ji02ti8Q/SPmHaOgjxmmM1ANRst397locdFG5+gltavAUZu8T/YXu?=
 =?us-ascii?Q?nbTADOhhclUUB5224x5ldxtuwiCqAycuRK8xfgfj4lQgSIqUppFqJZHodx8f?=
 =?us-ascii?Q?y7gDZ9Danx4U3C8xH61Eq1yOG1vrcArv8LtHdQc1+IjbpHabxWYWdFp7jbRQ?=
 =?us-ascii?Q?0pHTorECeA0ZYrI07UQzEPjvyFDn7i3nSskdbS5SMvv/d4QrCmOnzEeBq1sl?=
 =?us-ascii?Q?QGq9PNjJ2wtguNuqorhfZiQk3xu/gpLkGpZcBDMwsq4clbBWocjGd3jegkgw?=
 =?us-ascii?Q?e1aPnQqvmU7bkF/NT+mMPPG5d7dtVo4IxsjhiYQN/d0rgrYTpNpBm8lxyuPg?=
 =?us-ascii?Q?yPDHRrkB4WDHW3G9+AS2D1rSISJEQmZrAMO9oWZ6JXOR1sfRANsMogzUEtIl?=
 =?us-ascii?Q?McJ4jxfWLbflSv0ay12mOon8x06ZNlBX2TSbWAfKosR9G6XNQ3zh5fURZTHe?=
 =?us-ascii?Q?skvQvwd2PkJWZ6eAjB3DHIrH2dIRkoV/LqC6PopMZyroEmqymXBj+h9Dfd68?=
 =?us-ascii?Q?1DKaBfUPWQSy+QC4TGSGKPRACa734WQEBgctXz0myYknzZRegzfrmjjnGBm0?=
 =?us-ascii?Q?/WeO4aoXF7CmkOD27lM3h5YGnuMZDEzRkq6Wsq3s+oVAu7z1yxBvInz4L53w?=
 =?us-ascii?Q?QCk7rOuwKg8XHdABh+b0kRB2EjhdulmcsMY1wd++xNMDIAuu2lHFWS9A+YEs?=
 =?us-ascii?Q?H0tP124XNONZjkpHKsveTcA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694463cd-7513-4cd3-994f-08de1dedfb3d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:08:29.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uqr7RN2Tpzg5UtvzmB1J8+Wln85HFFCtFzNJ10onXGUjkJUWw2bq1dz4xrWD8XoIPxZ5RGCHlg3jstH35f/1bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

The Realtek RTL8211F(D)(I)-VD-CG is similar to other RTL8211F models in
that the CLKOUT signal can be turned off - a feature requested to reduce
EMI, and implemented via "realtek,clkout-disable" as documented in
Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml.

It is also dissimilar to said PHY models because it has no PHYCR2
register, and disabling CLKOUT is done through some other register.

The strategy adopted in this 6-patch series is to make the PHY driver
not think in terms of "priv->has_phycr2" and "priv->phycr2", but of more
high-level features ("priv->disable_clk_out") while maintaining behaviour.
Then, the logic is extended for the new PHY.

Very loosely based on previous work from Clark Wang, who took a
different approach, to pretend that the RTL8211FVD_CLKOUT_REG is
actually this PHY's PHYCR2.

v1 at:
https://lore.kernel.org/netdev/20251106111003.37023-1-vladimir.oltean@nxp.com/

Changes since v1:
- Apply Andrew's feedback regarding rtl8211f_config_clk_out() function
  naming
- Revisited the control flow that I was commenting on, and found an
  issue with RGMII delay handling which resulted in me declaring war on
  complex control flow schemes, and more specifically in patches 1/6 and
  6/6 which are new. Patch 1/6 is "probably" a bug fix, so it is at the
  top of the list in case the autosel bot wants to pick it up.

Vladimir Oltean (6):
  net: phy: realtek: create rtl8211f_config_rgmii_delay()
  net: phy: realtek: eliminate priv->phycr2 variable
  net: phy: realtek: eliminate has_phycr2 variable
  net: phy: realtek: allow CLKOUT to be disabled on RTL8211F(D)(I)-VD-CG
  net: phy: realtek: eliminate priv->phycr1 variable
  net: phy: realtek: create rtl8211f_config_phy_eee() helper

 drivers/net/phy/realtek/realtek_main.c | 156 ++++++++++++++++---------
 1 file changed, 101 insertions(+), 55 deletions(-)

-- 
2.34.1


