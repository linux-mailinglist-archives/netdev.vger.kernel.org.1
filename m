Return-Path: <netdev+bounces-259226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MlNDix6lWnCRwIAu9opvQ
	(envelope-from <netdev+bounces-259226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:37:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3C154220
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6F3301D69D
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098F5320CDF;
	Wed, 18 Feb 2026 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VLhY3eWH"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4B31B814;
	Wed, 18 Feb 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403790; cv=fail; b=GilW4em7oYUrnlhEFrah36kLqOKWI4UiSX5ArEuDDj6QnZnTavsD2S7iQMfZ9CC3Jvxy6Aj/Szp+VGJjdHJCNNGoQ5R/v1zy2gygk1pq4df1LHei+hN3I5UaRafbsm4Wv9UaCbnYChyIsXTGbVuUGpZit5+ddUtmK7HJDhybyF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403790; c=relaxed/simple;
	bh=gdvel3VacdbwvwwJOwTdxshOqOf5eYPK/9agJcUB8Z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNoFKfFjU89dklXVWwNmKVGPTNc+5a8iwKlHocYZwSipArk8g7o30b1wiu0t8A2qez6K2HIN88SF7GH3ZveZc+yybhqtixEs+ndcjtdjEaK7upx2uJ35y9T+jsoEqcCCkjKiAxZwY6xoVMW1i2n2YekYJu4CyGFE1DKNvfAWGQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VLhY3eWH; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPgPlMiX16d0XW2++LTkOy4eEFCXmdD1tWe2gsBEHqA2tl4SluFqa9zLyLzBpbLuzGDUJaoiMiadksG4CnFslkFXWcSq3lqM8kfzW6KQjKQhfHiQI2kgAKC30rDjnReoA3bPZKblstmb0r8dxNWb9RjxanFcBIDa984P6ff5wkdgzNyv17epZ3CDAWZfDAPNYeu8Ajs86wqRyarLbxnbofRJTSB5UVrRqf4X7gxZXc801LTWhk/mRViTb1+ZVD46tQfuZd4rJ/pNaeBP/UCWeshAxcybJa/VM2irYJd6hh1loMIggW8oS37kkinyoVm+y+RHKqEGjyvZ5lMQ3yw4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlpB0IdsSubPX75+rsLWZY7lPVptQzpa+T2HlkH9JCA=;
 b=WaOMjJMv0gsdssw6ePSrI5ghf8TcCLYR3pOhnvNWoydmXv3He4DWwHASa2ytGEAhUZ8/GohGzaQ3G3snB6tvDN4cPPzqrXKo4KGiyxpOuyilAfeM0iyWJAss0/UUP7X4YrfhwQqhLLH9Dt1VSNAiuzUGuPsVhx/xyuKiDv6pBZHQBu8xfvlhAKezo+dIgghbcWUErkH9geJPSBOEXKswYHCbqEBlR2nARZCs+Oo7nyeHoGznI1ywlOT5M+N0N+5KEGDagpek+ASFH73kfOaAaw6qaXcM9G3lSQm82455yMuUCt+mc8XbEJFF642bqXr3r8F4DPcVcgEI6NGiEl+drQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlpB0IdsSubPX75+rsLWZY7lPVptQzpa+T2HlkH9JCA=;
 b=VLhY3eWHFOLb5z3pV81AYn3vDRRaO8VrM3LJLNPSANCQldvz11mT7B+XL/8iFmBCNldERSoX3+VHUZkmN4gMZW1ZjUq81nTwHi3hSJYKzIQw4crcJ/Ctw2Ow64Ph2p8O97DqlCAmoLStRnT+e1dLCCg8gNgE1l5pkhA+sQuZSx9qOqelKO2NqeknCWkB0Ij2lq+F6XACpvtpk9TysmxpIedehzBE+NR7zp//Zbyy4e0QXsBjJU2wsJ4BrNRrdIsvF5b6PiaVFg2Snc/Ad3W6+QYTiXF4jN+/Y6Ns9qyAB4IPGzK+ddrF6u5CjxtlwTgKuA44PpSlX+o01IRjCSyKfQ==
Received: from DUZPR01CA0239.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::28) by VI0PR10MB8402.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:235::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 08:36:24 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::7) by DUZPR01CA0239.outlook.office365.com
 (2603:10a6:10:4b5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 08:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 18 Feb 2026 08:36:24 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Feb
 2026 09:38:19 +0100
Received: from localhost (10.252.6.190) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Feb
 2026 09:36:23 +0100
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] net: stmmac: restore pinctrl when driver remove.
Date: Wed, 18 Feb 2026 09:36:17 +0100
Message-ID: <20260218083618.67805-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218083618.67805-1-christophe.roullier@foss.st.com>
References: <20260218083618.67805-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|VI0PR10MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e1222c-e389-4718-c8fb-08de6ec8cd30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RRCyv9BD/YqIh3bIZXHKcXDUc22WqpR/qrwfvv8C9Fb0Y6zhkMwZgeKrYLXN?=
 =?us-ascii?Q?vHsXWPergCiAbmjXqpIJiGmUVfI8LcjWT8WbG0ETeEr0cGkHWlvBgWKzIDEo?=
 =?us-ascii?Q?txB7lSHuA46uI0wb7QaKMn/fkWHFr1JU5OXOr80VRR0VMbSKOcpE25dWRAol?=
 =?us-ascii?Q?uf6KQjljuQ8KjXNAPn7KF9xGqXLorXzs94ZqtnoMGLBckerTZyoimLk2S+qu?=
 =?us-ascii?Q?1E1G+u7rFMy5dlSbnJN9OynKHO2eWaF10E22iDoLKezG0SRDREeTqOo/zjqk?=
 =?us-ascii?Q?DFb505g8uAeeOmcWpsuJzuAGV9cFsninNSRFADZBNmXGQBRzGeceBGhO6/kc?=
 =?us-ascii?Q?Mx17u5M+mts7xQnxpk88eHOQSKyltXNZry7j7yM9B8wjslqkLfOV/MvI+t3Q?=
 =?us-ascii?Q?z3ORBRlJhGu4tzeBEfBJqVWvqT+VME1onzlPRz2s0BwUY0A1Hey4Qta3coF+?=
 =?us-ascii?Q?DUhGn6FY7z0k9Gu4VCgiK5aOyKqpf9DqeeY980vDfBrdpk/k+CuGZsfNFSN/?=
 =?us-ascii?Q?MiottQ0Ev1VsmoQl0merTFcd3I05hIvMjgrptDVOsvRMJTcIRv11tDqrjdai?=
 =?us-ascii?Q?WuDH88V2ASqURUfc4vqePMyWLoo35Ic1xxxpqILAop+GdCK/tMUKFzZrVpBe?=
 =?us-ascii?Q?WCoYKQeM/MnldK6E+Buz7NVItfynU6RxJZECoTllHChV9Ys/mD4a4Q9gVZQX?=
 =?us-ascii?Q?1LjRkQnTu2T1lRnPo/6oqv9ydreutfpUcwC+FMUG+7g/Nrfu3qnlg8glOeJd?=
 =?us-ascii?Q?nmruMnL2lIc29hsy6wRLMapPn4znX9sOKSOT/mexVliV7OZJYPcfRS6C0vOu?=
 =?us-ascii?Q?e5uxMEDyjIjU6f57qKVF8p4ymBfqMv9m3UBLMWxF9pPTErlb1ZveOB+Qp2dD?=
 =?us-ascii?Q?QdHlQVW5CI1WH49tOWvpcMNxdFanPGqrX0Zt0BV4iqHnj1ee4SIU+oFyJKqD?=
 =?us-ascii?Q?uSCf1fJox3k8aRf9dsZICMGgzS041mvpM817X0ZKUJCTzDsBKBbuWiKM5UYO?=
 =?us-ascii?Q?ha/OEVUzoZpVlITdrLjic8jAbrXyBB9gB1pOll2H7WHxO8IugVBA3Zq3XyQI?=
 =?us-ascii?Q?21UOwGEbmXltHbUKLZjc3ZOVGbNU5mvVTLUZ5Ud/kvz/IrTfaPHzCHccCYRJ?=
 =?us-ascii?Q?xNiRe2JjhqUNSJquqyJZzZUnJYviXRzQiYK0b9dwQOrsE8KZVdw1rRGckBu9?=
 =?us-ascii?Q?NaKgTgImkbtcgruEiCRalmFtys93mnkv3CEOUoPmRUseC0LwkWDHVUyprs+g?=
 =?us-ascii?Q?2NB/F+RG8n+p30IeDUVfyCBj0vuyv2FfuIRLQOxHAqcN/Do4ttk5Oz7bLLyE?=
 =?us-ascii?Q?PMRRXkvU7JAvgO1R5TINE667PTeFWxuxLMmEBJrT9j7yWgKcNzVhiUre1NsK?=
 =?us-ascii?Q?QFe8X9KQTzwVITvVjbi4Tv/D1h9mCx0IPe4PvrKrpV6niWahrB1UFb6Qh0nT?=
 =?us-ascii?Q?MCb8Nx/t8huJHMqliFUZGrziLxrDRo0D+fozhoF7EeqU+A3lF1BJs0LRD2Vg?=
 =?us-ascii?Q?22dfRAMz+v8uAQmMKAoLlu/kKoL9K1J/jTmWfWP0wFpnHVCqdPRgonx0t7eV?=
 =?us-ascii?Q?pQue1DXIkprCvmJDwNWdaox3kSaO2B6xdaWdNJ9CjUihodETACo3YkGR8rG2?=
 =?us-ascii?Q?wobNAHhMM1pixx0ihnoTB35WodCSWU48aJjs6TTKBSrwPB7slo596+/mU9M9?=
 =?us-ascii?Q?BeYh16NopL5vtwTYjRV5ftqk/2Y=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OrToNUQTNd9BUPlTNo7IlN2CiqyiCmi9AVyb8+8Vds4+M/+JDQ5imMaZ9fRsJzAvTNCd1yzgX5mt7UTaxME8CzWLm5E7YvlcH0I9xDvh8aQp7sYLLqorefVNYfTUMRRg+w2JKFctIit5MJD+gAI3yY0/+YaAcdvSXhvzYxwEE77Bp8/8hUOpHJ0xbm1vK43M1h2YabPnouw2Qp8pq9lVzqbJIpLgy06jDKnZKIqTQXEmJam1+GVWK2liUXhFkmUzvG1Q8dIRCrDKX2BydD0TqwlaUnysSZz4zow3p1y58osGW08cZnUUHiZbAPqnF1GxiqAcI2ST00Z5vnwrS+P7k9fU5CX/9DD0wzpQhVsOqZo2A+uwSbKdAisSuA4MTwNAzPOAmE2GkKvFy25EMPtULOPL/MS2qAtq9CGgU2bk4Izwc+IXgxmbsXzseGm/kUOy
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:36:24.7062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e1222c-e389-4718-c8fb-08de6ec8cd30
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8402
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-259226-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NEQ_ENVFROM(0.00)[christophe.roullier@foss.st.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CAC3C154220
X-Rspamd-Action: no action

when system suspend or unbind, need to set pins
to low power state to save IO power consumption.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 067b17f03cd09..3d4f0e4cb53fb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8071,6 +8071,9 @@ void stmmac_dvr_remove(struct device *dev)
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
 
+	/* Select sleep pin state */
+	pinctrl_pm_select_sleep_state(dev);
+
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 
-- 
2.43.0


