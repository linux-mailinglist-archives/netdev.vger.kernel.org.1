Return-Path: <netdev+bounces-214962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292FFB2C4AF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4554DA05F60
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D633EB1D;
	Tue, 19 Aug 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i1khpfuJ"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0433CE9A;
	Tue, 19 Aug 2025 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608434; cv=fail; b=r1BKReYtvsuHLjMy09u2Q2fFekNhmWfwJxFAAH2rKigx8CRqpmBMM01WqGogRRO1Q6c3fx3RULihl/DJ9IAzlMEO8Kv4EbYKbEAOSCapJUpqXCUhQvWCzYjniq2KYmy/AYumFRwLP4zWF2rfjw3f6KC4KO2q5Z0xZeSWEpvdd0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608434; c=relaxed/simple;
	bh=KIP+xyd8B9f+so2Jk4Vj7CNrRxwOBsk67sAkTItQuzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZNbJi1cKgEUdiEMeBxe3QtncxcExpSc4qSt9anJ9QeJE7DPiOQpNizoPUYJOA7/b9qu6doRB/tzoRt7F1UzV6LlSEvpzI7evHMYBMaL136ukmUgcEoBjV8AO+zajLpvrEUU/sazqY3G3p2mQSojmxvATdB+t26VhbwKgSM5Nnzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i1khpfuJ; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBnaEwWDaKs9riKTACKXmKN8WE6ZZLvzOtU1tOpgkdCuoQ3eJAdCFmzF3JEAZeO20LtLlVK0n8My4FfVPF9qU9IXaW07YDy6jp7pmY0UFxPeKrlIYctez4QBaEYAJjVvLnofBrVGYw3TuUw19At8wuVmhX3OAiS31z8t9m6B0A0YX22rPnj3/y+kjbR5GTKWFWfibC1RucjKd510ztDbsOmDcjY1KYEgBBYuiIdBrVNcFFS8fDDdCw+dfgJzbKUZHE5d1TY/faqqfawlhV0/+ZZFSvJ9BhWO5GHne74SOWkhEr+MNgl9jDLIWvCWQyvbVsmVEc+2DW2HNIbG9CMM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8yKzeGlrlACr+lgQtHhJctScFpqOJEwdMK2pUXiLro=;
 b=hQpdMTleU+LyBQz2XhJh40U+i8RfjFFyjYeFyMuqyNqYeE1XblTrFykgQncWxjlEzSGMn4nNvVEoQ0bG3TATI+HQGYv0oDnfjrU8iimISKsXGlV3NZgI4OQhQcTgsyDT460aFgP161NJFsktuadJahEjU61TIPE9FPq0pRGgM4vX8ko71r/EwRsCR9tzF1pwpM32Z1VkOYdCdZ3zXRIKI+Fd6ZsNHjmfd9bhvE7ICWjc0M8FTAWRLTYLMHiMqZ3RlIk3btiVd5RsexYhg4KsGdraQ3dy4eERLKO6ai+0xH8bGhUUu21oAB6PmYREkVzBqJlgx3FiJg75gDaSgut8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8yKzeGlrlACr+lgQtHhJctScFpqOJEwdMK2pUXiLro=;
 b=i1khpfuJzOuBAHJNsd5rTavz8NAWDcmCgcky4F7bmv7E/NvCq6l+YZbn0Tmac1g9HlqFRxKKZPyVqskVyiTMnwdsedUUPnoCKtNifwkz7WWcuH5MhjFjWhwd/4/Vr5fu6pZOl7m9wIgEn+6HOhy36IusuofybYb/7NJNw+SDHQyUgdiejiIjy17uwIUzZPKVj1OOzB/1GTDbY+Gyk3/HxHh6JTNB2DyF23ziRrm/Mx70UL5qo8ogG6mpGCIIqXOd44XmQhnS/tG3+YoH5/SmttTmjmTK4xqe5Qvgi5r4OhzHJNF+C51N/GJGhIoKLP+6keWx5iZ2PhIlFkZxrnSmWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 12:59:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:59:43 +0000
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
Subject: [PATCH v4 net-next 13/15] net: enetc: add PTP synchronization support for ENETC v4
Date: Tue, 19 Aug 2025 20:36:18 +0800
Message-Id: <20250819123620.916637-14-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 81a15865-eb74-4811-b697-08dddf2043f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nuQ6sPHScbttAqqqY6e7Iyl+KxIIjXTvz8c+6sNN3xbGOdKIixCjczC21OuR?=
 =?us-ascii?Q?CXVQbwd0y3IPuxuWYYvukfwBP2I4gnWarpsAmfHxha4VFOD2iURnWXGhinzA?=
 =?us-ascii?Q?y7kOXOsYxoy4WPAFlrZvVcNan9puu6HmuTmHSyBWZKduW+nz5SuGi5JExhB1?=
 =?us-ascii?Q?3n7aMB7MRnVfhBXTifwixU8g16Rtpo488O+bSfcPRUoRhh+SXUvQ3I/H6FdH?=
 =?us-ascii?Q?vg4dO+dIakx81i8AyJlvnMoQSAQFre0Yr8m9n7z+7pU0wWnw7enigKu0dTaY?=
 =?us-ascii?Q?No+5toVOjCpyV9pbsVolTR43O7JjSRbD/RRpgB8tfMycS2+xUL3bdYkdxDUE?=
 =?us-ascii?Q?VSUMaf2ZGARkXkq1PUdi57imEyalDHo+ZNnxLNACpAldvSX+xPYbIwUyzyDS?=
 =?us-ascii?Q?hpEdUc0u3PX/hfeEPKlGJ4K3EzuBO3pSPhxamR+TSZ4BC30N1qWQDlcEPsmf?=
 =?us-ascii?Q?MxXU3HkUHLoxPBpdEWa7HUbJm52eUYBQyU78aGxvALxatPswgjEnt3YOBzqx?=
 =?us-ascii?Q?cWMVeHn2MIl8AcknycSwumbT9AxC6v900xbb+aeqD5ipOhqZkGLEDZivy4I6?=
 =?us-ascii?Q?nZj3rHYKCmjmCX0y2D9meP8siwdaF3amOtFLuzz3TeYMCPus7qceOPjwMo7y?=
 =?us-ascii?Q?nRkmbhGhke/GopIfsajxfKIHWk+XLytKPcjdg6MtIELnqd+8p6vBGSOoofvF?=
 =?us-ascii?Q?91XvvKtR2Duwv6/RwEUS46egLJMx9Z7u/yk5vl+m6vT9LcoiSzxynkLFB2N5?=
 =?us-ascii?Q?8wW7ClSx5hrQ0531dGBzwV7AaCVRcj2BtOIrcBri5a+SAhoDppMijgQKJfmk?=
 =?us-ascii?Q?rBeWp6MU1WoYbFCOIq0rMBh2VhX7WrjQzsKpBtrSVS4YF8v35iabWfhcsIHP?=
 =?us-ascii?Q?INmWjqSinIoUiMn267SPLolJ14nucem4AJqfpgqYQBOth/RsPbmCh8dEDdXv?=
 =?us-ascii?Q?lWPr7DvfdU7j+sRDd3yibyXxAc77fL7CDICXILa+EcbCFdT0JLkKO05eHnm0?=
 =?us-ascii?Q?BxLWEjc410wKRgCmG4/jvAMLNrKrucOH6nGaYOZTZQFHDsCcOtQAzoRplrLa?=
 =?us-ascii?Q?Pq1JHG+S8IF6W4Mib4MfHZ0Z3i6X7BriI+2ndDP0t1p7Z5dQHedsUOg42OgN?=
 =?us-ascii?Q?UFilJ+ljuzp7OOiq4mFasISAqH7pvGAxb8eqQZxM5FakY9uM+8wvbW2ljS3m?=
 =?us-ascii?Q?D/sszIk6a4DPpnjvRI/+16Abe+cFBWpV2Pfg77az67n2S81GTdS3BqTqxpPV?=
 =?us-ascii?Q?WLoOMNudglOQyFeIiqqrKryC6Cc1PxrC5s0+HH5M8hfxZW5TBUiMYUkEuvKQ?=
 =?us-ascii?Q?6tthQ31yc9gZJyGfS0ATBr2BYPeskCNiYq3U+68qCoy2en8OqeblEK4+H/S8?=
 =?us-ascii?Q?huv2FLgXlFp9p2QwMsWNKgFF8rZGFxTxa4PkXp3ym5zOmbsbR5T+EY4WiE78?=
 =?us-ascii?Q?Hr0lZ7khVWCOExABY87WZ8iYdUaKOUH7Am+vT0zJNCNC/0nmSRyax13vPNVH?=
 =?us-ascii?Q?KMR/2RyrSKYxQys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jU2HdgPHJLRNsiBLMYwTDNAiW9pye4tGfqQCVMo++RaI1x2rKGYu3hzrpxCM?=
 =?us-ascii?Q?T/XjyltRkhOJNpSZQVa5fiDkTfzCFRBWDX4MDTxV3Dhwt/mUOyfvEZJZaYNV?=
 =?us-ascii?Q?LvGe2RrjPNhm2skM59XTe5O3NuAlYOUP0sUvLjdSEHouGAEinHyTTGdhC6vh?=
 =?us-ascii?Q?DI60qM8Bch+hYcoNeFqLHSZyi37EROjOn1ba4tQ7SaTRkT/Q3Q8BmdY0ZPQt?=
 =?us-ascii?Q?5pifraAuwQsokNZ5Gf+HsdZ74rXzoG8EStA3DuAF+PJJpX+GTTCxqgDi5nQD?=
 =?us-ascii?Q?L+fBx0kR8l9ND9N/SHZBeYGbkHHzZAuIky2CkkC8vUDBgWcebnsAd9tuYwd6?=
 =?us-ascii?Q?YDzIM/EuhVSEt7Ygu8M0vMy2rNzo218/gdyESAt9F4CKqrxZRTBKdLzNVwLt?=
 =?us-ascii?Q?J1GtnwJ9wEPKqBnmzase4cC5g6IZKJvpSogKzpS9fe3RBzBCEzvmxsvOiO5J?=
 =?us-ascii?Q?yIcS6fR3OuZfKNrCsPcDZUXHyDTHyVPRvEhZmuyKfG1TqYPuo/XYh91kXToo?=
 =?us-ascii?Q?PxvJRw9XnlzgvCLfPd2/pCnyP7niNFiEZuT85bcI/i2/S/Fc4QWl8usF5Kbi?=
 =?us-ascii?Q?o3xF1IfLV6wfRgZXE4/AJqiuTCsvcKkYa5PXS5nAxkm+3oQSLYCvNvkbjc4l?=
 =?us-ascii?Q?HS752Yj8kYXN+10M6ksDbC+H1uV7xX3gPBKVp/139txtG5B4CumjVOuPj+vI?=
 =?us-ascii?Q?PFsdrq6IBs5ReEw9KwmaSjlaG8XvuPt7Uk981WtmnEafoQdjNGs3uk30BpNp?=
 =?us-ascii?Q?1x6OASQbIWFpZd+lWRsz3LqbePaP/sctjiZkx9cvkz1uTizHwrTDOfHBnyPu?=
 =?us-ascii?Q?etHmYRTTeyCiaKDSS/TJ6WV+/cRRa5DFu4/4KyZOMS7JTrm9PSb3VFFYWVnY?=
 =?us-ascii?Q?FlAbsxfZkvC1T6jTNhoH/ZruS9d7D+MPkJlTnFlrF6usqAjVvgvD6pS3lyQt?=
 =?us-ascii?Q?haKAle7ayJfLI6NNospeWVjadD/10Rxw/cvMj16AeciJNoYr6bxHdK115vB+?=
 =?us-ascii?Q?qQNz2rAY+Xs+cE2cPvhZHclg44cpFWFUQubkDPqsicQ7zvYVkHRkEm3t80Fp?=
 =?us-ascii?Q?2kw+pVOGwZJMMV9ZW0mGFRTqWPMSSlQ8jWtjbVuEsK+Vz0Qxsso/6SN+INsa?=
 =?us-ascii?Q?mR+OhmQmPT9ek3W98TjIS3oBr+b7F+q8P8IeJoip+eI4FAnn/d+FNQ+XJqsP?=
 =?us-ascii?Q?FtTZVgQSzMRfGIhRBjQcnVKqfYT8jxKlwCJ833ySVWOsG6b4D3sKzNPfPvsf?=
 =?us-ascii?Q?+n8mIPdG30115FlqRMdwE19Z7fLTVDE+4fRosxeCrTp9Q+TqgxCxj/MepYy9?=
 =?us-ascii?Q?xH7iWe123c2uUye1p2jikAWlowRihVTsm2nEoH6xtwx0Md1Ibn/FBaTMkBnk?=
 =?us-ascii?Q?5bYkcRpf6RNFHeYwX2w7JFDo6d5lNB6dhnxk/RoqCbimcWXpQ6EIUz+bduCK?=
 =?us-ascii?Q?t8LmziKR9A6Sv/yy2HTSvBLpp4q2kpuGcTSABJRwWvg2szQm4v4rRnoRHfOo?=
 =?us-ascii?Q?T9PzAjOO7vJdMg3UpS96JYeNyxNq+wyai4W/qwMQDsFDB4BBFQC+7snlLYqL?=
 =?us-ascii?Q?chw9Bnm3U7cjAOAlQzi7bmGlFVJ+L7sGmKH0WXcL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a15865-eb74-4811-b697-08dddf2043f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:59:43.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rzdHlCInHGOsq8DvjXjlbV/ZGgdiJuJ5K4Lh5/5Z8l+CigrgzKYV/lUwHzr+Dp9EEDs4L7DHAvcJ0KGXj099g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
mainly as follows.

1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
different from LS1028A. Therefore, enetc_get_ts_info() has been modified
appropriately to be compatible with ENETC v1 and v4.

2. Move sync packet content modification before dma_map_single() to
follow correct DMA usage process, even though the previous sequence
worked due to hardware DMA-coherence support (LS1028A). But For i.MX95
(ENETC v4), it does not support "dma-coherent", so this step is very
necessary. Otherwise, the originTimestamp and correction fields of the
sent packets will still be the values before the modification.

3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
register offset, but also some register fields. Therefore, two helper
functions are added, enetc_set_one_step_ts() for ENETC v1 and
enetc4_set_one_step_ts() for ENETC v4.

4. Since the generic helper functions from ptp_clock are used to get
the PHC index of the PTP clock, so FSL_ENETC_CORE depends on Kconfig
sysbol "PTP_1588_CLOCK_OPTIONAL". But FSL_ENETC_CORE can only be
selected, so add the dependency to FSL_ENETC, FSL_ENETC_VF and
NXP_ENETC4. Perhaps the best approach would be to change FSL_ENETC_CORE
to a visible menu entry. Then make FSL_ENETC, FSL_ENETC_VF, and
NXP_ENETC4 depend on it, but this is not the goal of this patch, so this
may be changed in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
errors.
2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
Timer.
v3 changes:
1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
2. Change "nxp,netc-timer" to "ptp-timer"
v4 changes:
1. Remove enetc4_get_timer_pdev() and enetc4_get_default_timer_pdev(),
and add enetc4_get_phc_index_by_pdev() and enetc4_get_phc_index().
2. Add "PTP_1588_CLOCK_OPTIONAL" dependency, and add the description
of this modification to the commit message.
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 91 ++++++++++++++++---
 6 files changed, 137 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 54b0f0a5a6bb..117038104b69 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -28,6 +28,7 @@ config NXP_NTMP
 
 config FSL_ENETC
 	tristate "ENETC PF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
@@ -45,6 +46,7 @@ config FSL_ENETC
 
 config NXP_ENETC4
 	tristate "ENETC4 PF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
@@ -62,6 +64,7 @@ config NXP_ENETC4
 
 config FSL_ENETC_VF
 	tristate "ENETC VF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 4325eb3d9481..6dbc9cc811a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = ENETC_PM0_SINGLE_STEP_EN;
+
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
+	if (udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	/* The "Correction" field of a packet is updated based on the
+	 * current time and the timestamp provided
+	 */
+	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
+}
+
+static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = PM_SINGLE_STEP_EN;
+
+	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
+	if (udp)
+		val |= PM_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
+}
+
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 				     struct sk_buff *skb)
 {
@@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	u32 lo, hi, nsec;
 	u8 *data;
 	u64 sec;
-	u32 val;
 
 	lo = enetc_rd_hot(hw, ENETC_SICTR0);
 	hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 	/* Configure single-step register */
-	val = ENETC_PM0_SINGLE_STEP_EN;
-	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-	if (enetc_cb->udp)
-		val |= ENETC_PM0_SINGLE_STEP_CH;
-
-	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+	if (is_enetc_rev1(si))
+		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
+	else
+		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
 
 	return lo & ENETC_TXBD_TSTAMP;
 }
@@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	unsigned int f;
 	dma_addr_t dma;
 	u8 flags = 0;
+	u32 tstamp;
 
 	enetc_clear_tx_bd(&temp_bd);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 	}
 
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+		do_onestep_tstamp = true;
+		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
+		do_twostep_tstamp = true;
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
-		do_onestep_tstamp = true;
-	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
-		do_twostep_tstamp = true;
-
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
 	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
@@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
-
 			/* Configure extension BD */
 			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
@@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
@@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index c65aa7b88122..815afdc2ec23 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct enetc_si *si, int size,
 void enetc_reset_ptcmsdur(struct enetc_hw *hw);
 void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
 
+static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
+
+	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
+}
+
 #ifdef CONFIG_FSL_ENETC_QOS
 int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
 int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index aa25b445d301..a8113c9057eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -171,6 +171,12 @@
 /* Port MAC 0/1 Pause Quanta Threshold Register */
 #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
 
+#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0 Interface Mode Control Register */
 #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 38fb81db48c2..2e07b9b746e1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_eth_ioctl		= enetc_ioctl,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 961e76cd8489..6215e9c68fc5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -4,6 +4,9 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/net_tstamp.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/ptp_clock_kernel.h>
+
 #include "enetc.h"
 
 static const u32 enetc_si_regs[] = {
@@ -877,23 +880,54 @@ static int enetc_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int enetc_get_ts_info(struct net_device *ndev,
-			     struct kernel_ethtool_ts_info *info)
+static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
 {
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	int *phc_idx;
-
-	phc_idx = symbol_get(enetc_phc_index);
-	if (phc_idx) {
-		info->phc_index = *phc_idx;
-		symbol_put(enetc_phc_index);
+	struct pci_bus *bus = si->pdev->bus;
+	struct pci_dev *timer_pdev;
+	unsigned int devfn;
+	int phc_index;
+
+	switch (si->revision) {
+	case ENETC_REV_4_1:
+		devfn = PCI_DEVFN(24, 0);
+		break;
+	default:
+		return -1;
 	}
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
-		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+	timer_pdev = pci_get_slot(bus, devfn);
+	if (!timer_pdev)
+		return -1;
 
-		return 0;
-	}
+	phc_index = ptp_clock_index_by_dev(&timer_pdev->dev);
+	pci_dev_put(timer_pdev);
+
+	return phc_index;
+}
+
+static int enetc4_get_phc_index(struct enetc_si *si)
+{
+	struct device_node *np = si->pdev->dev.of_node;
+	struct device_node *timer_np;
+	int phc_index;
+
+	if (!np)
+		return enetc4_get_phc_index_by_pdev(si);
+
+	timer_np = of_parse_phandle(np, "ptp-timer", 0);
+	if (!timer_np)
+		return enetc4_get_phc_index_by_pdev(si);
+
+	phc_index = ptp_clock_index_by_of_node(timer_np);
+	of_node_put(timer_np);
+
+	return phc_index;
+}
+
+static void enetc_get_ts_generic_info(struct net_device *ndev,
+				      struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
@@ -908,6 +942,36 @@ static int enetc_get_ts_info(struct net_device *ndev,
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
+}
+
+static int enetc_get_ts_info(struct net_device *ndev,
+			     struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	int *phc_idx;
+
+	if (!enetc_ptp_clock_is_enabled(si))
+		goto timestamp_tx_sw;
+
+	if (is_enetc_rev1(si)) {
+		phc_idx = symbol_get(enetc_phc_index);
+		if (phc_idx) {
+			info->phc_index = *phc_idx;
+			symbol_put(enetc_phc_index);
+		}
+	} else {
+		info->phc_index = enetc4_get_phc_index(si);
+		if (info->phc_index < 0)
+			goto timestamp_tx_sw;
+	}
+
+	enetc_get_ts_generic_info(ndev, info);
+
+	return 0;
+
+timestamp_tx_sw:
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	return 0;
 }
@@ -1296,6 +1360,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
 	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ts_info = enetc_get_ts_info,
 };
 
 void enetc_set_ethtool_ops(struct net_device *ndev)
-- 
2.34.1


