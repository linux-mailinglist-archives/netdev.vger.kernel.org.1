Return-Path: <netdev+bounces-259228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEKRMIx6lWl8RwIAu9opvQ
	(envelope-from <netdev+bounces-259228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:38:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020715425F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990313055E68
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEB1320A02;
	Wed, 18 Feb 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QlypCfow"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E193246E8;
	Wed, 18 Feb 2026 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403797; cv=fail; b=cFdB4PrKOs4DgyK3CRyrm2Dr1IAmllP5dPvhvPnkq8tITODeFnkzzUgX++FWe+FeXvtXp6QlnXSdTuagJTxRtd9jf+0mqex3RzMnVIHaJaw7lk4G2FCvSSoEcy9dy1y747q2YZ/KKKAridr2W4ara3pHIGh1j2neC1vN5dh0CLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403797; c=relaxed/simple;
	bh=NzR+QQCBwwbFfDCUcoPK+0AsH6XcsvcBblvFSEZaR6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrCEfHRRalfLkhB7OiYzz3owVuo4k+rTiqiH7XyrVu0kJ8ype3YMcvDMB8wPzFX7Q8qx3X8VU14geh4AsYv5KeJ5QzshwHs2I5BYn/06DHX0WlD8ZtVEiEqAeMEIiYCo23W1fr2zR7C5zPqSEdRhJU+b5CO0Y8xGogOQbAK9kwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QlypCfow; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnJk/FqlFJ89T731YE2HmOeWRHHgkLDXNagkvPxseOrwXp+OOnDwmha91ctTcnYlSFLGuol3meqAlJCvi2+KBCLBIWggQAV7n9X6ryJWGy1e3m7kUBrKhA+57+5r7RnlYxVON8/vz33me4AVI3optZS+y3xjnOBkt6SP4D9YpAvDxRfrtOoezJZSBEVRsSIJsZsbftW580BEylLSZD0BUh3dIPP3Q+WpuyiHwAgngkMXrZ0LEYoeH8RRrOxWJY3HhXQUqI6uVOu4c62NUP1IdZaCvxAIGno2Fep3cuogH3xmv9cZW5WA4am3UTiAArFSa3CDxmC0/QqlvePVhxl+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdRqN9LmRWbrFSZ+SEujD3fkvb19JlYvgEjll31AiUk=;
 b=jVmQ/JHoj0dqHNWZPMMxBI8dync3PFEHeC7Zh5GnsmUn8yL5+yjQoKIAH+qWKONByrpJm717ng5m4JHVUHnQ3iihcPIzQCbZwFmqy3Spc1C8lxtk1vUblYnXQ8oslyZ6rpAzpbu23/92gs84QJ3E2NQg3pQt5uww43sihuqGnEg84RYVdYUKm65jpAghYMH5JS4QjuVC3eQCN9mJFKh0jeNLwpK6OpvhRzH7ZyLtUnVCPD1iXWJZ05mViGBFXZVuNUqCIXnM74MMJb+SZPSry4SDrwdyBHzkzn8Q5JHkM3d/B+3waznnwfKJVTzzQ/27Cu5KjLoxIv80CsaWXYprzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdRqN9LmRWbrFSZ+SEujD3fkvb19JlYvgEjll31AiUk=;
 b=QlypCfowmw0IY3tw4H5pX5n0Ys7Cv6YMlulle87p0bwwoRZGTXYXt+F4eCHraF0ILiWG3lGY3VqTiXRCIGq5/8Q7+YDg5ZyWhTPfMyug6l8HWXA/jMB+r/HhSlVt6pM3UuB91/c1IYq4SfgO/FzhgYOA1anNPC+BnxsikwoHDldUC8gN8o/ZywgL7XoONsO4qJQAKdZOC1XQwcVqjREeef4OGPjDpVTPEdloxIH7VAlRbY/qxpYsP71Id57MR9zCJTOBgsICg050gI7axFJpwhLyze54AXIAJvixTPzT5x2mn4NiAEtBWs6mSwBd4z7JwdQwL+qtNs/xpbkJ0lV+KA==
Received: from AM6P194CA0066.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::43)
 by AS8PR10MB7400.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:613::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 08:36:28 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:209:84:cafe::f2) by AM6P194CA0066.outlook.office365.com
 (2603:10a6:209:84::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Wed,
 18 Feb 2026 08:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Wed, 18 Feb 2026 08:36:26 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Feb
 2026 09:38:10 +0100
Received: from localhost (10.252.6.190) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Feb
 2026 09:36:24 +0100
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
Subject: [PATCH 3/3] net: stmmac: manage error case during stmmac_dvr_probe
Date: Wed, 18 Feb 2026 09:36:18 +0100
Message-ID: <20260218083618.67805-4-christophe.roullier@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|AS8PR10MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d215441-0562-4c29-69fb-08de6ec8cdf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zv55qgp0aAegee/l9zfzVUiNyT6m+2LqTlpRauEwFhydjf2hhO9MPzNJoOsg?=
 =?us-ascii?Q?uO7MTmmNriC1cndRLGlZ76WPUnSpWBUlCjkP+QxdJfSpSwGpsVinYlYpAx13?=
 =?us-ascii?Q?A2YNllYPUEGlfbUrPQzY7cefwT4+mb40zeB4IE0jE20Dc6D2mjUfU/wwX4PV?=
 =?us-ascii?Q?6JmvJOXOV/tnG8uJ31811UGegWNbpfcnlqJq7eTzwPOkTAaTW6Hr0fJUjrca?=
 =?us-ascii?Q?UodahuW2yAM4ILuqbjBGkwDTMLnL93qRaEMh+M/xxkkwYvKhkNBB2CtbTagF?=
 =?us-ascii?Q?ZzKyyDcd1ZWXj+khP2H22Iu3eERbk7VGv6wURjff4fqjCxUki0M01a/wc9ug?=
 =?us-ascii?Q?THYlS17NFdfbaPnj1D6p7SPflm6ErDCe8wHzL9L5KO70te5crvbpR8LijurF?=
 =?us-ascii?Q?Xt+/O2Wz7GCIE1uOc6Wq3n7C+P7+wfoV4led+7GtBa+GCJdazY4MBedMNFEq?=
 =?us-ascii?Q?eQPlu4nBrVDHvFX/uD4LujB81fpNqSDdvmsF3hMMi0WlcFdxz/NGcRuF0y6i?=
 =?us-ascii?Q?xvkJ/K4vVJbNkzx2Y1yr0ojyWbJRjEgBh1LNJtIa29fWfZlAqaSlU0uTZRek?=
 =?us-ascii?Q?ioroCBA2r1AyK/W3d7BQMvKhqH7FjcMqGvcRP0TKPB7N8BaoQHF3BfKfDB8u?=
 =?us-ascii?Q?uV0rJym/rmglcIVDsAVcZ9pEjymUys39KSpAJxSeMFpLcKOwoo+tgpMzIXfE?=
 =?us-ascii?Q?skGWEdtYNVofxlshI5CvDiGpzt+nP0cEFgmrpHlERtQboROMGalL3YDeOIrM?=
 =?us-ascii?Q?WuMB8hDVlI2LxK70fX2WwpLxYHzzNonHjnU/oV8RIJqIIn5Ed/aPSqpx2Hbk?=
 =?us-ascii?Q?UiwjEJ6eX65bfC6NivHivgJjF1d8IvYmRbCvGRCYeS8hugfLQfoLfhsCjSU7?=
 =?us-ascii?Q?HLyIAPIhm9tDBWFu5dihRkUW4tTNfsdipFyrPIAnSrcz/huE86vseNBNVUc4?=
 =?us-ascii?Q?jMl58zC4l/ynnhJ+W7qhF6v30H3/P/6YfX+bS+l69ciRGs4e2EvNZC0oCkp3?=
 =?us-ascii?Q?TKjj29NZZD2Unf3/Wf12cCwJs5k8S26gZ/87KBhNJQgmbGl1UHJz91NX/ly0?=
 =?us-ascii?Q?FKjLUmcGjF9B9cc7cEBV4hx3LsXx0CLhH97saUMI1exe4AbZ4L7EGEYf0gXG?=
 =?us-ascii?Q?zd5OehanU/s2URZDa6kF2XsHcxUW/6ZD6j/HnA3Pa3V/PueRucgpwMFCEOSl?=
 =?us-ascii?Q?9+iCycmG+aCk/ixHAFqPrt+yoHG7+S2vgHYA6lJHywirx0htMD73sN3LqFex?=
 =?us-ascii?Q?ti40qSmyvunupOlphObMIA0SRGjPfMLH41FCeMwmo54UTeDy+Bajeg26e5QF?=
 =?us-ascii?Q?9pTU++H6NT0OkF5oSoKO+ezagS3PqyPYE+XHe72xLIW8jQLcpymWNDB3n0fQ?=
 =?us-ascii?Q?E39xa0gsN+3X8PNCZl+VYI7LEymklAuNGDSPlR3OYWCqyAK1MgHLfALG2r/B?=
 =?us-ascii?Q?M2W0e143dqYJvnHPx5/9Sl0htCVuEBylnFMWVU4rfmjo4ddK+tleUr3Og0Ej?=
 =?us-ascii?Q?lrcoXd8lQxjRNsb0tFj4pAWZqE95xgxpxolBIpz9uS3sPWdxqvKQRu8Z6ooY?=
 =?us-ascii?Q?Ag5cV/kV7D5SFjyrQV683dpwOvttxg68qNGV/0Xxopi7/eRDGiXKDzdjLt1H?=
 =?us-ascii?Q?l22vvN+9B7KErSV65l9VXNvSGn5DQX90P1ZEN0Sktr2gYMeBfMscQiHEy+TD?=
 =?us-ascii?Q?34aj/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U9H9cl1TDt+8s6IMisbxBDnLTtyrvNscbvUwVP39PVRe47MgpqSDrDW7P5EmOcNgl4/ttgNpw39CMyawWAFmcpzTjXA6CCGqDjkEvWZAm1R5vlWacHH2ZrQFm9iKA9LyyDj5WTou+q1Di4WM2bCs4gIiRNBh7ofjqumd72AjbGepd8DF0BV9DmWz5f5zXpoGETALwNhr3+o4tEkHTFtJHuWPVoUzqyBXmKoMfM9zAhIQXvQAaUpLOJUWwfE55e6Hykcx+sxQE1kIy3egwlOsRrYS3eHvYVoY/at0hBdoQyJViAwlL/JE3OmFx04w6X9uNOkK9zn7d18gzd6h2eqLWTBjgLNL2RVqYInWXJDEdCaUSOWfS6o7BUapj/4T/FU8P3zgk2ODbvLLgCZO/3dxOC0p2xadzZJ6mPxwhQX5sMBAs2xzWR/7QLctIbNn3buK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:36:26.0402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d215441-0562-4c29-69fb-08de6ec8cdf8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7400
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-259228-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NEQ_ENVFROM(0.00)[christophe.roullier@foss.st.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2020715425F
X-Rspamd-Action: no action

In case of error during stmmac_mdio_register, pm_runtime is not
cleaning before exit probe.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3d4f0e4cb53fb..d8eff228f3971 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7999,6 +7999,8 @@ static int __stmmac_dvr_probe(struct device *device,
 error_pcs_setup:
 	stmmac_mdio_unregister(ndev);
 error_mdio_register:
+	pm_runtime_put_sync(device);
+	pm_runtime_disable(device);
 	stmmac_napi_del(ndev);
 error_hw_init:
 	destroy_workqueue(priv->wq);
-- 
2.43.0


