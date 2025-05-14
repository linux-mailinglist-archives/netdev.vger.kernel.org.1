Return-Path: <netdev+bounces-190473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E48AB6E31
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2745C4C153A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02F19D08F;
	Wed, 14 May 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A3KNRO57"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02342260C
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747233186; cv=fail; b=DPxsFIWn/M4TSR+DQhRzQ48+OsuLNYRyPrN87jApopWxj0iuYcCdGXKdonaG/L30zKQMuHuJiHxNXGF2lfCCHKHYBpmA/o1qZOWO9ArF8y7oghYZ1WpxcdlT0lYJrwD2pH3ZtQKKYL3ecXtD/4Uzh4tTOjEDCLQm1NQxqFHmpNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747233186; c=relaxed/simple;
	bh=OEnzNTby/ybYOegObgqPsqTyiSpgwaSZi0C/QoahKoM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SeZ9xY+nzXPOn9teOt6zgg9OpAo/OkgwLHH7+xiKlxT+cN9q9Y32y5zhwftgT1wwoDylAZljlv4nkOXMJsaSTxFEk8Pen5zr+1Ted91FTNoKIir4j1kuwg2GBrgbePi2/XAT/GJ4Vq/i0R74xeAtrCCzelblIj6D7YwxVQwPGFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A3KNRO57; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHbII64SwEmFE+RSj5PSyagzr7Jx5mtRdd3XyOH3VcROa4BKXmOeWYDmkCao/bldZDakrgmgT9Y9qv9w8v0GCZMtnCWyCiY5IKQEtxQ4zAspbLkW/eKLQdnM7s7sZgQlR/uEDbKYDhc4HjR/MxHGPA3MJvU9Zu7BebcGTl6oHMDKqhXZBI8eCZTFLBlIz6dmAeCu4tEQXgSmiuITov7sPLSN3i1iPnpvQI7GmusmjB4kqRFk0cyaaAI+sDvFw7zDp+KIQh0W3q1ZrRDtTgb2KEESMdJi+lqCx+U12iviCG3RrbdteQMXUgArdfjdBV/d9bAOgBx23W36jpvZ24Qq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaxRGIQrP34CUkAlAciKqn87vwhT8jZEGDiR24kHil4=;
 b=M5vYQ+VuZXArsMY7J0CN+iSjFAQj4wdvbxQkmJbQ2Bn+yWs+h+k0vj70kkAmq9ssqG8qfgSfrZfABEVHSomEefa0PZB8jH2QNcfU+vk4+zq7LSuCXVdS0JWYK4syJcr8ZeN8miqWi+9Se88qa+G3m3uQZW7ulywH00/Cbx82YfNcjCgdpERdt/46XIQhqZ756PJZ/Uw7ionobLek0x42LMh2xYebQKcKi/Ov7RFWzy+I1tXq2hA9F7NSw0uDAqcv+0lIQFIF790sX8kBvsw8qoWY6JYvEcNvssPKi4kye7mn0RT85JYsZFVMA17RbOfZ8asRRZD4TlrkmXEnkhtkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaxRGIQrP34CUkAlAciKqn87vwhT8jZEGDiR24kHil4=;
 b=A3KNRO57o8DzE1mxjCqGCI/i/PJ7r6oAGgcEYKmYJ2/t8DO5/Y1K51b8guy1mtmdnwj8KuinTbPPW1NMkRDRpfBY573QtDkJu5OZrnez5bIkOxKlx9Nv2qBDhpF0EzVrd+esV8Dz96co9Enlsiu+Kkd8Asqk7BVQhuVJJU0kDJQwtaJjTUhI0c0dtaBeJ9heWaCC1+JIXiXd8ymSuRlBqb6OkBwYifCCM/0Oap4xsa0I3y2BwiALO+FlJWM1Ob2icRn1ECSAFzoJn8R715rW+w06HcO4DRM14IkrCS3sL/WJQyenOfQucI3FgTGHJys1G7Lt4dS5ysuFwEng5soggQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 14:33:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 14:33:00 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH v2 net-next] net: stmmac: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Wed, 14 May 2025 17:32:49 +0300
Message-ID: <20250514143249.1808377-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::49) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: c588c90a-599f-4a8e-4f3a-08dd92f43a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lW8Wah1IqCApRfz0LU0iQH4OKBwu4Q1cuL+YP9moHQ2gMinRtY/hbQzR9GBB?=
 =?us-ascii?Q?owuiBOUDHelr+so9evQ7Tqd5J7AXpG87SCJjErsna/4N0OWQjauMAw9HenMP?=
 =?us-ascii?Q?V3ZxWRYZE1bO9pdnLtICtu+h67S6goW7T+saw1H0Q+IVEdrHNfWJ6LI2HK2Z?=
 =?us-ascii?Q?y/eFwRkw5Fhukjfh02k6lRCVHInx4p0hmrReeQWUFHwYRxMYRW+9sqdwegOu?=
 =?us-ascii?Q?Uqowy1RrfMNtKEuJkzb+LL3zElxjmRK5MyQCIivy8c6L+fgdnoLI0NPgPtM9?=
 =?us-ascii?Q?jG9vKsEgp2IxBq5NiW6wUWHY0p1X8gDfcN4vwDZ/8hCXgCFtVR4zQl34Use8?=
 =?us-ascii?Q?RASr8n6ndJ8UZSpESC8qGz1UYzYPEg1AP7KKeCcWr27cXUHsdCLphwz7lMC4?=
 =?us-ascii?Q?b90Fzku1wsNHT5eg6UrxXOsY41ehtzFBw6dC191B9SqxdWqsvFW83tFXtArJ?=
 =?us-ascii?Q?zFdSvGsvM1jWrsjnWYNvnBAU2petwreLq7NRMA2P5iCJvpOBrP+9uyYFIJhy?=
 =?us-ascii?Q?4fCYtTDqZ2Qpps7O1if3r0HO7iGSZQPJaDVcszczoQzQj+6ob+w578s4QTZ2?=
 =?us-ascii?Q?H2PDPH0XI+lnb5XOORcglzCGr8MFpowaAsN3tdQq0IwQGu6axHPNYHroHqgZ?=
 =?us-ascii?Q?iueffNlDfo8ZeReYeZeNOpZ2ZpbkHNngq53sFaE9anB2FdNabY2Q8x1eKB11?=
 =?us-ascii?Q?7a/gwavJfpRwcHUTMdyCZbhJNshdhpDsSpc5j2/pRjSO399JSkJSqZiuBdpw?=
 =?us-ascii?Q?Gxgod3LnmWdgKuTJ5mTwQaa9Qow7X2dTk16sOafxM/KBHI4H1Mp3a7pwkmHY?=
 =?us-ascii?Q?hbanQXQ7XpLBErwdde1KrCrHg/tJuQ5QP+U+xidM5hOkDk3/8CIrcIJSO/Q7?=
 =?us-ascii?Q?BypcbPPYQU0q9yAGR9KCp9GhTINh8sHZ727ibnZu9EyVXcOf3v33eq16QTwR?=
 =?us-ascii?Q?2Ik+li7bfO7WEnnsap/G7aHcfw2bJ99ZSa/pGu8OsUXKFlNpLJwsri3TVmtv?=
 =?us-ascii?Q?LbqcZEi0pleTx9CpB59sUGqMO3uE7japjvfaSAmqE7K9zQcJd2HeDmbXd0N1?=
 =?us-ascii?Q?gTJHqRmpe5yqW45jOAQjyhMcblAehxITxKMbpUvNcw71en/EMd1i7gWoPJnX?=
 =?us-ascii?Q?g4zbBkrKjzCM1wQBI6FbgwFvxv1KmJZpRSMcJsHI2w03lSEnbAz2xqkOTniZ?=
 =?us-ascii?Q?QY5wq9AuKYsqohBtw2dISwc7XUMRaobqfz+Q4f2R0mGRSFuwLjFanOSau7uo?=
 =?us-ascii?Q?Hv3f02oLitDfJsQJO0p/sntBREVOuIYD+IfuFIqFcYrO2XW2+Csyi/37ChDf?=
 =?us-ascii?Q?Fpe2QnW1BIf0K2/RLeZLjEjld/9A+RsZ8Zh0i6GH8/Mtn4HDGCcSBhzmqhqu?=
 =?us-ascii?Q?A9sj/Z54rvd74nDSQ9Udf9KPOtTCoyZPMDYjEzYvJXBDWmaJBIKxRscdCBnc?=
 =?us-ascii?Q?T4I1jer43tBD+kK7QYuYod23Ep2Z7DCK18fFA+WBkLPTIhdNHzTtqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AZ0a5aND1fT6wvQlWLCF3CyV72p+AW22JzeAH3zpN4SKBvCQoy1vnO2OWTFd?=
 =?us-ascii?Q?ctNI0DAVC8blF1OctkoZJaC+ZRDatQE59kwuxPxAkeQ18JQgBem8rSTy/4KQ?=
 =?us-ascii?Q?fl7Iu+AvSXfyupolUvMrhBdoRQAy0w2RmHR5lDvraj6R+OBbvuUFyRt1dXQE?=
 =?us-ascii?Q?cO4hFLH/QsbknFOybPXt2vYpRnBO4ozzvbJqdl/XGEAGbZQ8rq310SwZIK2t?=
 =?us-ascii?Q?ERxs8/nxhKb8TjP535kRLa9S6D14GBi4uDSiwYhJNZaSy0+a7tuFiECHFkEm?=
 =?us-ascii?Q?S7+noWLebx3kQaEILStGT5cedwRvQF9DtJEIoEKTQyIwFtT9STK9eKAPOiPd?=
 =?us-ascii?Q?3rCUi6CTL2ETrDcj3jA8hgUMfqd2zJ7zqlJRz9CVdEb9e8VT4DrVCB5D1kdJ?=
 =?us-ascii?Q?0dc15ahx1c8J2cX9XMLg16MlkgAVKng5CZw/fuB3jSgtFB5z1vtH0tMvFtE7?=
 =?us-ascii?Q?HVOT51LIirA+e1Mj6AhRwGJ1pXXSxts6+hMRl4Ayhg4dFny0p+PHduxMVsEw?=
 =?us-ascii?Q?je43wNuQcgG3sryrjBUHB3yT0QjcfWEwwohsCaLKaa1k5PdM8UY+jFR28+oJ?=
 =?us-ascii?Q?9hWRsN9r/7QDN9gBMBopsu0GQFVeWCyCh816GYNMwanzn5rSwgoxrDGykc2R?=
 =?us-ascii?Q?jjEefqlrWHfLfxlJRFV/NXrJ0VQIN4Bmc3KhcLPrLhksCYtE9V9ixILspaBK?=
 =?us-ascii?Q?ebLp613Jj7U/wh0GwbM14C3JNKwLCSyjLeaEzqaVYkOeawK+iBKe0Z+8WfiQ?=
 =?us-ascii?Q?rMQgUBXdR3i/GT2axRtD60bew4o+g9D2bd59wwhrfUa4nNvspwBfHXds9E/S?=
 =?us-ascii?Q?eFO1Hi69ZHb3rQ/5h4OpFqOClTf20i9YT6r2W03zlbAXAKG5ZjRyiKQhT/pI?=
 =?us-ascii?Q?mNF7obp90mwWGF1FYDvWBYUrsGKqsMNWKLrPubFHnT+pPKpkDi4xUvosc3Ty?=
 =?us-ascii?Q?ykpFI1u5SnX3ZZS0dAaURSGNHQGYfVEy7O0X5rtzmlmvr/lXXvWUhtK+LNE1?=
 =?us-ascii?Q?qoBeTX8W4xMFMAa0fw/MjxkaqX9GIYUkX5z8xi/DXY9AUVx04fwWv6JJnHod?=
 =?us-ascii?Q?w3PVfih1KNzTXoE4sYi7csi57QCynklSL9o74NoIBrc0eTC2b23b3OCBjtGt?=
 =?us-ascii?Q?0IIrYKGpcLSPLBB3Zc5+owrGxSs/brqZeCQK3lrJQz8kSjCgiUP1wNrteYSI?=
 =?us-ascii?Q?/d+Yph07I06Er10nYtCe84UjKfsyYuXbfK+BXeaWUHVhiJ9ScrBdWjE6KOCp?=
 =?us-ascii?Q?GTIquL7eIIC8h2ZNNqoiVBp+NISEJlxL+nplBYlAiQCqujlbqgypHvdZwqly?=
 =?us-ascii?Q?ap+CTkidrXeWuL4GOdXkbA3Hs+KPJkdcWbOpGgFNcN3WEjgo4s5J2xDGDri1?=
 =?us-ascii?Q?MxPG5BZRHhfCEQLF/4L+akjv13PDXll0JNDXuOAn0JT6Nf7EN8oClkhus3vs?=
 =?us-ascii?Q?d3LzlVKMEnvUTQ5QY+SCAAO9ZzVNKPdG3i5oL7agvcgz6d5wquaBTPwlN7US?=
 =?us-ascii?Q?ENErzgN0nL7uAEjZBP5QR1upP+EPEyxIQJc9IdKl77eSvVJISBax3RZODc8q?=
 =?us-ascii?Q?5chbjM1o0Q5PJ5gROzSK45+A4P74kbtp4yW5S7APwmSbRNhW3Jff1Ihuw4/0?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c588c90a-599f-4a8e-4f3a-08dd92f43a48
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 14:33:00.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYEvktkVN55GohHCoLlsdfvR+EeEHDUcwfaDsnrj+sl1QR13BhPT9BO0QEhvjpymjZcUk9StpcBO0r7Yi5SYZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6.

It is time to convert the stmmac driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl()
path completely.

The existing timestamping calls are guarded by netif_running(). For
stmmac_hwtstamp_get() that is probably unnecessary, since no hardware
access is performed. But for stmmac_hwtstamp_set() I've preserved it,
since at least some IPs probably need pm_runtime_resume_and_get() to
access registers, which is otherwise called by __stmmac_open().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v1->v2:
- remove \n from extack message
- preserve netif_running() check for stmmac_hwtstamp_set()

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 84 +++++++++----------
 2 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 1686e559f66e..cda09cf5dcca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -301,7 +301,7 @@ struct stmmac_priv {
 	unsigned int mode;
 	unsigned int chain_mode;
 	int extend_desc;
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_ops;
 	unsigned int default_addend;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a19b6f940bf3..3c88c0ed35f8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -568,18 +568,19 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 /**
  *  stmmac_hwtstamp_set - control hardware timestamping.
  *  @dev: device pointer.
- *  @ifr: An IOCTL specific structure, that can contain a pointer to
- *  a proprietary structure used to pass information to the driver.
+ *  @config: the timestamping configuration.
+ *  @extack: netlink extended ack structure for error reporting.
  *  Description:
  *  This function configures the MAC to enable/disable both outgoing(TX)
  *  and incoming(RX) packets time stamping based on user input.
  *  Return Value:
  *  0 on success and an appropriate -ve integer on failure.
  */
-static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
+static int stmmac_hwtstamp_set(struct net_device *dev,
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config config;
 	u32 ptp_v2 = 0;
 	u32 tstamp_all = 0;
 	u32 ptp_over_ipv4_udp = 0;
@@ -590,34 +591,36 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	u32 ts_event_en = 0;
 
 	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
-		netdev_alert(priv->dev, "No support for HW time stamping\n");
+		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
 		priv->hwts_tx_en = 0;
 		priv->hwts_rx_en = 0;
 
 		return -EOPNOTSUPP;
 	}
 
-	if (copy_from_user(&config, ifr->ifr_data,
-			   sizeof(config)))
-		return -EFAULT;
+	if (!netif_running(dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot change timestamping configuration while up");
+		return -ENODEV;
+	}
 
 	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
-		   __func__, config.flags, config.tx_type, config.rx_filter);
+		   __func__, config->flags, config->tx_type, config->rx_filter);
 
-	if (config.tx_type != HWTSTAMP_TX_OFF &&
-	    config.tx_type != HWTSTAMP_TX_ON)
+	if (config->tx_type != HWTSTAMP_TX_OFF &&
+	    config->tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 
 	if (priv->adv_ts) {
-		switch (config.rx_filter) {
+		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
 			/* time stamp no incoming packet at all */
-			config.rx_filter = HWTSTAMP_FILTER_NONE;
+			config->rx_filter = HWTSTAMP_FILTER_NONE;
 			break;
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 			/* PTP v1, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			/* 'xmac' hardware can support Sync, Pdelay_Req and
 			 * Pdelay_resp by setting bit14 and bits17/16 to 01
 			 * This leaves Delay_Req timestamps out.
@@ -631,7 +634,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 			/* PTP v1, UDP, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
 
@@ -641,7 +644,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 			/* PTP v1, UDP, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -652,7 +655,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 			/* PTP v2, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
 			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
@@ -663,7 +666,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 			/* PTP v2, UDP, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -674,7 +677,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 			/* PTP v2, UDP, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
@@ -686,7 +689,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_EVENT:
 			/* PTP v2/802.AS1 any layer, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
 			if (priv->synopsys_id < DWMAC_CORE_4_10)
@@ -698,7 +701,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_SYNC:
 			/* PTP v2/802.AS1, any layer, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -710,7 +713,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 			/* PTP v2/802.AS1, any layer, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
@@ -724,7 +727,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 		case HWTSTAMP_FILTER_NTP_ALL:
 		case HWTSTAMP_FILTER_ALL:
 			/* time stamp any incoming packet */
-			config.rx_filter = HWTSTAMP_FILTER_ALL;
+			config->rx_filter = HWTSTAMP_FILTER_ALL;
 			tstamp_all = PTP_TCR_TSENALL;
 			break;
 
@@ -732,18 +735,18 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 			return -ERANGE;
 		}
 	} else {
-		switch (config.rx_filter) {
+		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
-			config.rx_filter = HWTSTAMP_FILTER_NONE;
+			config->rx_filter = HWTSTAMP_FILTER_NONE;
 			break;
 		default:
 			/* PTP v1, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			break;
 		}
 	}
-	priv->hwts_rx_en = ((config.rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
-	priv->hwts_tx_en = config.tx_type == HWTSTAMP_TX_ON;
+	priv->hwts_rx_en = config->rx_filter != HWTSTAMP_FILTER_NONE;
+	priv->hwts_tx_en = config->tx_type == HWTSTAMP_TX_ON;
 
 	priv->systime_flags = STMMAC_HWTS_ACTIVE;
 
@@ -756,31 +759,30 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
 
-	memcpy(&priv->tstamp_config, &config, sizeof(config));
+	priv->tstamp_config = *config;
 
-	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(config)) ? -EFAULT : 0;
+	return 0;
 }
 
 /**
  *  stmmac_hwtstamp_get - read hardware timestamping.
  *  @dev: device pointer.
- *  @ifr: An IOCTL specific structure, that can contain a pointer to
- *  a proprietary structure used to pass information to the driver.
+ *  @config: the timestamping configuration.
  *  Description:
  *  This function obtain the current hardware timestamping settings
  *  as requested.
  */
-static int stmmac_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+static int stmmac_hwtstamp_get(struct net_device *dev,
+			       struct kernel_hwtstamp_config *config)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config *config = &priv->tstamp_config;
 
 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
 		return -EOPNOTSUPP;
 
-	return copy_to_user(ifr->ifr_data, config,
-			    sizeof(*config)) ? -EFAULT : 0;
+	*config = priv->tstamp_config;
+
+	return 0;
 }
 
 /**
@@ -6228,12 +6230,6 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	case SIOCSMIIREG:
 		ret = phylink_mii_ioctl(priv->phylink, rq, cmd);
 		break;
-	case SIOCSHWTSTAMP:
-		ret = stmmac_hwtstamp_set(dev, rq);
-		break;
-	case SIOCGHWTSTAMP:
-		ret = stmmac_hwtstamp_get(dev, rq);
-		break;
 	default:
 		break;
 	}
@@ -7172,6 +7168,8 @@ static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_bpf = stmmac_bpf,
 	.ndo_xdp_xmit = stmmac_xdp_xmit,
 	.ndo_xsk_wakeup = stmmac_xsk_wakeup,
+	.ndo_hwtstamp_get = stmmac_hwtstamp_get,
+	.ndo_hwtstamp_set = stmmac_hwtstamp_set,
 };
 
 static void stmmac_reset_subtask(struct stmmac_priv *priv)
-- 
2.43.0


