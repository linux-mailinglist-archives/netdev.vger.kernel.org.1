Return-Path: <netdev+bounces-200568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840FAE61DB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E37172F8D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB793280033;
	Tue, 24 Jun 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M8d+2sFR"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DCA2D;
	Tue, 24 Jun 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760009; cv=fail; b=Iy+2EbixegUvd9BSfczx81vcFjTRGEzuZEBt1s/1J1vlotVQ38QCTK49HpLAL29ZuwQcrg/SM8ZeOkrgzZ9YsexjESLWRynyd3RO5veztdewITSfb19rpGh75/0wczkF5bT9NnZe46dGw+yMG0TDbP8iCqPcbKo1nCVakJYwIQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760009; c=relaxed/simple;
	bh=JmYgpiO1VnthJx7//CvNlj64AB5XtGqVk8AWXLQ7uh0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PXelR/uwppyvK+IAglVFJH3TuqxW7Dqp99cDcJ6JNc7TafNk6XubS/Dqrd/9xksFYSpAY/vesVG05+PWVoEaZCYtFKJljyIgXl1rWmJ1umgalPOs6HjG6yt43XMMIwe5hp6TLKD36Il7oFfm7gZhtYHs2RK5qxsjPiTdMginyv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M8d+2sFR; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwwuiVxBuDHpXZBx+BJhAYmMNZrpuJxg84dvnhxG0FIFnGpyyo7LIrrYF5IDjSCyVNhgzPSlhoAcnnWt6QAPPOreS6kCEccxqOcCpuVAN9WTbVzM+EH+x13bc9IaGDVPWwNKJACtE4k+hRmlQeBZIRsQmTiwLBjADV05d+26NrKHRbEUapzJJM7ynGXPyHEfhGgky9hR7dchQy9k9ikN3uhJkQl7fn1/63eBhgbJ64L3vLN6/HBfZbhPeGjTLOTP6uzsFlHS60Rdd6OcJDTl5C3hbRiqY2JtEcpblo1hsjV0M0HKO12NkDLuT9HAFXWmlSyMLuDwotcEjmkuY5OHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLeHjmtwqg95oWSMNfWLvApLvKHT+C3TCkJdtmOAeTk=;
 b=Nqqeqsc5y9py8T9povVcFTj6V0GliPJJzMiVSihAGYc61uIrD5JdcQluqunbJXNUSt5iKPUI7z4nuUnT5O3Y7wNRuRzmxB16P22tkQ0OZh+F+5vnPU7+6EVJkUVtLEPjd8UFwnVk6+DxVPmTdip5ilo/uscMSH4sZnuGvqF9RHt7PDK8BSYEpJUhQyeVCEe7eKx89RlA48yM+mifhiKFp3P3PbuGw2egMbVtlyk0Brf5uUO1e7WHvIU3akaJ+rBj4ZQxEH90ZXFJiy7WByIXyfsnMGTKLfs8EVMNngs5fif0lnpxoey3je/IbeZgnAt+fNrqIRJL2f1qEpLFNu+PXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLeHjmtwqg95oWSMNfWLvApLvKHT+C3TCkJdtmOAeTk=;
 b=M8d+2sFRVVWZa1IUG72VBvbYSuavLIrTPo8bXG20G2NV6GxykAcKfXA6y9VLTbxHbXfsiRmNtNXzJV0pCY/ggwfz0vPrMKVAbcdJuFEACii65MVDxBaubKmoAsE8Ypdu2ZZQj6Ru+9cjS0u9hQqi9HZAF9kqcYwRtBGFIpqHIEq2oCQT4ezubCBeImiK+D/O/I3ONzbI8X14vwZNJbiyn6DcZ1Lrm8TwqjEQ62tBbK1ya90hgNYz0uQk7fXVx788t6j1vnCKgyfS6b4YsrIN1fpQMqAsyUzrm4LUaTOBSva421/nwr9+rtHeCOOuj2PTP4YT44i0aHklfyKZjr+MoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8636.eurprd04.prod.outlook.com (2603:10a6:20b:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:13:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 10:13:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 0/3] change some statistics to 64-bit
Date: Tue, 24 Jun 2025 18:15:45 +0800
Message-Id: <20250624101548.2669522-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: 117f8171-8d20-43eb-9da4-08ddb307c068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xAU+i0FaEk4ZOPbv1zriamq0TvzsWSkCiWF7W3mexB6elgaRmpK3JzVW+cVH?=
 =?us-ascii?Q?+A0/XnpUgmEICByexvo3qqdPMDoG+R7cjIqtIFowwM1FxEuy0zyg4VhLdOZo?=
 =?us-ascii?Q?1kyjpfCI9v2C9TupiTjdk957pYsxjSVKagaCkr/JsPT5DfaGfOBlxkK66d7m?=
 =?us-ascii?Q?vvhkazmzVGpSpNTrA2AzhKcc0Oa+y9EN2s6HuG34nnsAwu/jja/lQmnq6ytw?=
 =?us-ascii?Q?yHAxe6tsCHys1So8HFneBIVuT+W/bAuY6dMHOQ7qm6Z8Rfn+CYHTk2OEQ6P1?=
 =?us-ascii?Q?Xhyv4Vpvff0OZkWtWtcRTBYn91VBttue4BcDfY0yTXZ57Sdsm6Oemg4bgh/q?=
 =?us-ascii?Q?MxZmhrudjXFLP7rVTarXl4RZDLNdUCZaQZ97GjVbRYBkPNZlCLdF+BgbcSha?=
 =?us-ascii?Q?F/wqHyj0ZtG+AjrysbZqIW4f4XGtcqEpWdBSHZ8DZdLThtLRfZ6aBu6rHGMy?=
 =?us-ascii?Q?kHLzOz//07uClsjDYwff/Oh3zF42JWqv+WhCr0kpdNQKnb36y25Trdp4RAkc?=
 =?us-ascii?Q?5T4JA5spfP7zFQA4E0adYh0v8UuVPKR/xCJLtY3/8AlkP7c19SRrBzRHoqt0?=
 =?us-ascii?Q?K5RxE5aXrf+jN2EVW0xahGFyyvJHA/uLWPIFQYgJftzpU0p5bmqv+74WPYlN?=
 =?us-ascii?Q?xtn4EImK5XLCg5RYBJZ+whYgLkSr/pr9ot8e532Ow9vdXd26Nmms0941yyZw?=
 =?us-ascii?Q?9kKuWkbUDAMvAai2uqS0QDu0eXnhXU+0AIoYNYuwJtk6xkBEpCCE958QBYNk?=
 =?us-ascii?Q?kl0poFACWBoy/In/NrLvcWhCthpKwTdvquM3RAy/3MzXM5FEZ0R7KpTFuZtp?=
 =?us-ascii?Q?QKP2xG9Tk4chXD1Z105I4R+FOS/zTq4pJvt0UabxI9cN2n7jvb11Y/xzs5/s?=
 =?us-ascii?Q?BJOLd0e7E0Ftw0KxOMU+V/zU9FBKrt+iDiYAp2oTcOJADZuQi7nXpjUpSwB9?=
 =?us-ascii?Q?I2b0ltLI3DdKWNTXHJF7eB7Ub/5qFPEChxYWlMtLiOIMyBIPUvLfKjouqGDt?=
 =?us-ascii?Q?C2YlNADVA5E4VCTuhRhId2eepmnWuPdQ2Er7PKTq8gNc6mcYMTRIOyi5tg4t?=
 =?us-ascii?Q?2JqiFewWJxE2kLpXtwVYz63FSMeFDyJ/f/SWZeEgsR4hX51NZ/40cFbm3PuT?=
 =?us-ascii?Q?tPGEdi/wP99dY2ycdH1WxtixxiTaD4k7eJnZZUAoZZ6QrADfCyWdsD8ONusg?=
 =?us-ascii?Q?rHa8GUDv6oa89wBCkMEaRFJh3q59Rtx+/IO4OKR1GMo78JxcRpD87g6U7cYB?=
 =?us-ascii?Q?zdlrMKZ1O2a3rp4Vj8SDE496SeQrQSO25PmurWQivQOVv7mnPFi7I1DQcAv4?=
 =?us-ascii?Q?SP3aCAQLu3iVyrvZmZGgVtlk+fTPuypn1DsMpevE7ul9M24NX71dCy4tTzhZ?=
 =?us-ascii?Q?d4I9mt2z4Eo+QXsbQvPNmUsjBbzqOzNz76sfNXumo6yFgYwU4vLy9n4C2oGO?=
 =?us-ascii?Q?SicAIVVQbrswzJ4HHRRDObCjlq4AKSykHtyWJIMoI8NlVTZvkIy3Qw+mrISJ?=
 =?us-ascii?Q?MI6QS+NbEtQE6Nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TctJ1kc3CKQhDpBD++NSyQxOAk9qEZpjDqERhHO77eY/Db9c//FYnhAjmsdh?=
 =?us-ascii?Q?jVs95xbjqHvbOYMuqC2sX8mNz8qF0v8EB+Fhl+IQtdDkRSXWRwt4P70I9ntN?=
 =?us-ascii?Q?ixE9WXik8anX1gn3ugagEPWBlQxac66dQOsCm5zXHuX4DSd/CubY7ZrWbQBI?=
 =?us-ascii?Q?xBSYFwSE5uyR3lzBOh0r2Vd2ToiTnQnuIbgBEZOdEIp7jEKidPZzYmkD00ym?=
 =?us-ascii?Q?tw1MciZn9ANJEbv9MwnjK471x0BCnF67VdROBC00m/kZ9AXAvgrua1Y5FqJz?=
 =?us-ascii?Q?PX9R/FkLtWaGNDkOeUNhQ3SirfWc7IgrjJSfxSq2rC8xgrGHeBzMfsvqqfOg?=
 =?us-ascii?Q?LEhQTpeCvej276ntSAWoMCWowGjomJ+xf/6hbgyM+nioQtyTkzCDvN68Lx0T?=
 =?us-ascii?Q?c6YO8hJNtjG47uHfzKkG1oIQOF7OjY1Ak+p9GY1Sw4i4vnOBTdvg27Elyk3Q?=
 =?us-ascii?Q?ychUHZVEo3OyFqMsctf49aVn81EDNs7kDkkU749XZDrLWpSWHis+2MSUy161?=
 =?us-ascii?Q?b+7MRVxwxjPvnwgJphR93zgAEHQIZRuyi6Hk/E2uEtsLrwdJrFsXZLaJUwMY?=
 =?us-ascii?Q?Tkm+cV1Xnjrr0p2COhn69AyARgVGsuMEtRysGFzx9FGlR6QbJv3WV4u3ONPF?=
 =?us-ascii?Q?dWGbwm11evjuoVXuhhqXIScICDtTHoUpKSQ2ddvnD2BCEdVWd6SnSgp0x97F?=
 =?us-ascii?Q?GLtqZRO6XUziuK87u6QfPBTSZawcJp/yyGs5HKR8io3aGj9byTQf7K75ruAf?=
 =?us-ascii?Q?tshz4hA75zwgv0UvCfNR6VDjGfdI/zInNj8zNjgyT6x069syaF/B3tqnHlfT?=
 =?us-ascii?Q?xo2uiLRWk09AKcfonknXjRd7/4d9q5lKyVXxlagFfpUhuvBA06ldMPJ5pQku?=
 =?us-ascii?Q?sQlcj9hwlrOmSPQ0G9lvOctKjr7qM5KKbuktOHFN2rs30dcyouGuYFy4O2NW?=
 =?us-ascii?Q?QZZM9kpiNxdqQMPWGJbWzS8kkOm08pq16kBuOWwmA5QvxInaDi4ZO0nRXkxg?=
 =?us-ascii?Q?2fDEOpL45d5m6S3L0J0XfAXGq+fKhAFYBNqbI8hQ7yudZlu4giQTCssQOhXY?=
 =?us-ascii?Q?wdPGPNEa0/6qkgKIbfRLr1lbnTFC0Xrl10aRtHukoYk0u4EV/RlHL2nT5rYH?=
 =?us-ascii?Q?5PVdouXaJLbrZRmvlovpTBxamgqV6uj6xc0QokCWw9lQSYxVH7rgsPaZ7Y7i?=
 =?us-ascii?Q?8N0jY/J5Gy8jWblpcmhcaYAEdHWe6C8kTaO+BnTikhqWOEJB0dXt2OEFVnoq?=
 =?us-ascii?Q?lNimLEaqYDyoSL9GXWLYObJw4FlUSJTxfigoWvuFZlG9Fnci/SGmaVqY2YZg?=
 =?us-ascii?Q?OS1kyB5moSCJFRcFhlZyekvgsSLo3FPppUf4qYsBubwi5tLxOOEt6znNaAux?=
 =?us-ascii?Q?TPPQudTz6WjLyLwTtGVgHbapLnZrVb9lAv7ODfFovSK0NcCc6OIHblSZBz/Y?=
 =?us-ascii?Q?Ozw/PoABcj915ZZuyOyXk93uVtF9a41vDYu7Vtzgede/jybQCFkQ/1QhNMqd?=
 =?us-ascii?Q?Q+hSGO+ZIOxEh278b3+zXI8hLMRBXDxuQxQ8d5o6+bqpu09W7OM6Q68EmmSO?=
 =?us-ascii?Q?f4aqtT6F1EWLDXP1PDK1bDbktfn+PsFgmFGJ40cW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117f8171-8d20-43eb-9da4-08ddb307c068
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:13:23.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHbJj8MZNfxvcnsgf11BwSVdYSmLlxo1oChm7/41vUeorDaBgHC5t4E2OBIsaR5gVieF1sH+c7GJhItWQ0APpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8636

The port MAC counters of ENETC are 64-bit registers and the statistics
of ethtool are also u64 type, so add enetc_port_rd64() helper function
to read 64-bit statistics from these registers, and also change the
statistics of ring to unsigned long type to be consistent with the
statistics type in struct net_device_stats.

---
v1 link: https://lore.kernel.org/imx/20250620102140.2020008-1-wei.fang@nxp.com/
v2 changes:
1. Improve the commit message of patch 1
2. Collect Reviewed-by tags
---

Wei Fang (3):
  net: enetc: change the statistics of ring to unsigned long type
  net: enetc: separate 64-bit counters from enetc_port_counters
  net: enetc: read 64-bit statistics from port MAC counters

 drivers/net/ethernet/freescale/enetc/enetc.h  | 22 ++---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 99 +++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 3 files changed, 68 insertions(+), 54 deletions(-)

-- 
2.34.1


