Return-Path: <netdev+bounces-212856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BBEB22432
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55036422132
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EFC2ED870;
	Tue, 12 Aug 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kb7L804Y"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699222EBBB7;
	Tue, 12 Aug 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993307; cv=fail; b=coUozMTCcUoFjXy6sBCxHv9Ae34Zy9gmixJn0Y8VkCqAw8f/xOrpLfxycd+5IczCEBhy1OqLO0MPW+ZLHj7mKasZ43+mXeCFK3mMJ1Z8+h6HlEPAOZ++3Z3EemoF255yu1D49tEUvtkelvQTF/2piABxBLLb60n5BEcq2EDzWvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993307; c=relaxed/simple;
	bh=hF5UNdOdmYEvr3YO4bJQXUPYEmdEGigM7FH1BEk/g48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGv6x7lnxFhm8HdLNspOulNOLSOTN3yFxCirxwIVirvHoEMZkeoKBWyUD8MmI+PGa8ew5wQXAoq3LnhYsTlZJ35iw8s4EOomRhw5ikQPms4s54oIe7xYzR9f0fFR/fjWIhL2zAGzaQGcQZo3nS9gHuymOSt9FAE2BzDLGwIQ71Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kb7L804Y; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTBJlcoL6GL2/hwu73W0mrDHY6zwIYn1+KtPSNQACKedShegVtmxCgSsrvKyOmjJZ4ZY0xvx34m8XfC2NA4U/mVPkhpZXNp3hIiLT/oHdp1/+BCQjW/QxJ9vU/mrXzcMO9KhhThGE+fs30ZlL1pfLXnZjqf3yJPfTr38/QL0DOTTevz3hdWmHN8DsgSi4PL2gjbTK3luS8wzZd2kPWvd0qxXDF5gzwEngvhu8SXV3lVmRKF2jA6hdkTaibcpKcWNdPmgJIYncSMkrs1xJu9RLYlh9XVa3/MAv93mJHhz1UsnRd9N6DK5qiBH3kpYeu8h8WdKo11kpp0PVi9afuWviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=QYOFun+e9QPbe08a1QdHbhYgkx592rH/GuB7ol0kIG2Gy4REki3Yk412ixEYBYKnWmP4/pH0btp/jcy/DobSeYdoJnQcTiQrOscLQLfVBhoqYCEkvN4jea3RrbklraMiekTlxNj3iyw3C8J1xuLkujRA+zQ5XLYPm1nwuiWkg6ydIwe/MaWbhQrKgX8oxDxTUK/Dgb/FCK4VaVFMR4AqKUQ2QcEeh1DcHrPX1fEnrPbsM0cNMc4JSJbRkZsh8Tz3B7xDuCS34MhuCtYaeqyoQIKvgyUWiprHFuX8Hhes+AMsSmIz1EM1wlAJLroNLMH9Ky5C6lyEbNswkR0TnPOFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=Kb7L804YFEem4PdEc6TcSV/gl+A0Nq0VShAnAIHH1mJeGDxPWtNzQgrs4j8gwTmhdElTYcsHJGR7r1dScUMylsMNwB+F6r5ytdLPosjtX2Wofouzk3V9m704ieNKHogWsF+2OgmY/zy76a9XvMbCdIp74JVEzH6V049VbAd88UR+QTqBxOzPAstTCWiY32hKfnCsV8tzh16ShQ16eNukCXfc2ZY+3xcOQ5C6bPZDu+CJvPQIB4IeXpKak8q0E7EcUARL/cID3dGoqFqO2KJrPP/Ja8QF8vhYl1F+wCWA/5SrFwH1zZ8jhH+vsGZbze3cYGEutyBGIvBqC7RhBUE+ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:08:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:08:21 +0000
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
Subject: [PATCH v3 net-next 12/15] net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
Date: Tue, 12 Aug 2025 17:46:31 +0800
Message-Id: <20250812094634.489901-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 7455b828-6862-4f80-226f-08ddd9882af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VgClcanXk8fYRWvkCZEQzCeKzfI+ZArCcVeMsLDRO8/LA5ycY0V5Zv/7w0yV?=
 =?us-ascii?Q?7TRn8BDlM53TXJu7heu75ZGGsWrsPvGfqLXnQ5Z++nb1YiK+x7B68vxAZiJc?=
 =?us-ascii?Q?KmAyU2i/pjBYdhTaFwwbTpv4IwRl4weLqhlLOa066wju/PW++x1+MrHlyn5k?=
 =?us-ascii?Q?VSt5sBHSi8X63yrM6bzwYourJrQJdtYqeG00PfQmlcNzWOz/uu4BZ6jqze81?=
 =?us-ascii?Q?5LGov5isdoFJAKuypEAVINDJBqUNNvBiWN9WgSnA20I5w97Evmt/EU8fCFTa?=
 =?us-ascii?Q?EA/UNeus7N917IAS/eGx8BaVsZKGGdwzEypnjdKvDS2BlI17xV/UWJKE6Wm/?=
 =?us-ascii?Q?+XJugqCgs66R6uAUdwt4mj9vLPIJQ+/zyuS9PvZFO2MGu1lB1cdNACKlfG8A?=
 =?us-ascii?Q?s6YuI1Xm8SrkTbDoX+kP9JQJZtFf77G7ifx8nnz1W58+D2Hr92IHed9bKUcG?=
 =?us-ascii?Q?vkPA2G2kn2IfbrAfksboC6VnXaX1IxFDJbsszzEPuE5aU7xdhPWOCcUTjNPB?=
 =?us-ascii?Q?45pPys+DEeeFLyPWGoRY0ZfXHtRI/4dKDgPKakpfcPl18uvbJ+G7redyAKFP?=
 =?us-ascii?Q?41KW+aJlReFtGcDD1L8PZX9WVs32O+NHNJ3hUwXn9OnawQmhWMwLBGUSIgfC?=
 =?us-ascii?Q?AUo7xWv42CcG/uEaI6ufLTRtjqpzsgVsCsc3G7mXnTiiEdKT0SaKdc7tFoAH?=
 =?us-ascii?Q?wFWwBjNgHUSf/mxRIV9F4eqLakUJa+e9CJH2ICPnx8dHVUqzfsKrFgWBRhMz?=
 =?us-ascii?Q?HET80sPg33FZlolcwBzaa/idJA0R6FMM7E7nkuw4RlmlErnAhtyEQjDAm3dN?=
 =?us-ascii?Q?/K/ewaPovUhtwdFFo5NlQYGzlldnolHiVb7iuUAxRXHSZXvIwqXjqZ51UHpm?=
 =?us-ascii?Q?juSTaHA9/QKVJSLBKqogxRnleExRaYNWMCnkk5ieY1FxNaD+lPn1zvr0Hszs?=
 =?us-ascii?Q?2AHTaFMXDZYc8l9tPKoxIRmI6LwOi1YRr2e9hKNAopLqXvw6f7QHou6K/x4r?=
 =?us-ascii?Q?xhiBblPEU+Rgp7J0kR/nbuLhO9pK/+u+VdgP46xV3pBmaUyv/8L3ESlF8s4P?=
 =?us-ascii?Q?KL1swiXn39EqTrOaKlSZAlCvCKIvELndTFjCPSP6VTmmx5DVCkkk2rslCDy3?=
 =?us-ascii?Q?VO63b6hOOhewITqLNQXUS+m5ucCpqaHJdLdmwTYno1onMnAEjKpzb9LOYrGw?=
 =?us-ascii?Q?pym6k5BQs9b8t/ZBc+n9n+SBf1ChVmBPwjzxH3xWyL+FSK8FoyAR4rEw/j23?=
 =?us-ascii?Q?F69ihK/B9Klv0ljVy/lI8Kytpuia13L1rLC4EAxk4hfPK3K5PD3sRj4a5CIM?=
 =?us-ascii?Q?Uu8v4cbJuPvbZNcM6myQZKpY1iQF/MeJp1/xKeXp9uQBMg6hdCBOdvOtTMbo?=
 =?us-ascii?Q?hgWCzrkrVKaWWrKfGoYoIArF2+c+7Yvg/ZJpOa0WgKidJ6z1UCMHIg1+olxZ?=
 =?us-ascii?Q?QAZVeoWk/iv4ppaUSHP3pQ1JqghkKmHh/waWhYxMehS09SOfBYNl1b0o4Q0E?=
 =?us-ascii?Q?e+vxpTO5HKdAR/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YzYrZ9nmTwYfT5f4utmkpxZIQntbhU5aRkp1ZxJMjBt4MbPpBZzcNG4aycDK?=
 =?us-ascii?Q?6nQilaI8uZff1n7KDFz7z0Ni3Sp0sE6XhqA2alFQNABwBQEGbKO1sBQyd0Tz?=
 =?us-ascii?Q?6pm1MEVvZl7i1WemV6Urn47C0gR8czSDxZng3npYyBdt7V8DwFAF2hbMj6aI?=
 =?us-ascii?Q?aB9nicqqVPXeRYbMLLLUkVsEhf2II0sWLUJTwK5ONqPePi3I1G7II4LiWMpY?=
 =?us-ascii?Q?eVHGgQyeT23rsbUWkbBwuJopGpAtQ1LxCZRVAGbhZyhLCmhz7DVwIDNIHTW9?=
 =?us-ascii?Q?yxzeNapHwyQSuoWQ8LIjR2KMqGSShDApMILrzEOHgyR2LqkxhNDTdSNOolm3?=
 =?us-ascii?Q?debXtdQ0JC8cRNdEhzrBuAcmqDtcpZQ72JrdqZC3WpAQckALfwgrKvADYqFP?=
 =?us-ascii?Q?WKzeF4RA+ZM8jPx/lvs4aWKBp263DOQFA5vMyyVL81tFrK2PHRYUm9Gd8Ykx?=
 =?us-ascii?Q?noZTkOF/ayvk3Ae9Rz5bQ4tOfQgqqaqu5yxnL0hHc/vnQyGrrazyIe0UoIvL?=
 =?us-ascii?Q?qjGBSjCPHxfTdZM0wqJ6C2eYAvTurVBZ+zauZVQwJlQ6GMHTZh254Gy+5nHT?=
 =?us-ascii?Q?a38129v5o1xL4EyUcrhxckmUCC1j1LmP9lIn0YuRPAoAHn6cjojkMS3a9dD/?=
 =?us-ascii?Q?rtz9Jxg3H+ooM2Ao45Pm7EX6YB3yz5aZXpNHFvYvI3eiPfIYob0MX+a9p/8w?=
 =?us-ascii?Q?OGwunfD34xyqJcZ9gzbSUyB307ZhgedamNZzSh21B/7K94JLzz5XKsz/LqHD?=
 =?us-ascii?Q?t4BJ2xX1hrI07Fn4XANRWEVR2AmlM2ySEd6OOd7+5+iy4iW+qgRdQkzssYpt?=
 =?us-ascii?Q?+qV8NyGxfh+DBz+SUBEvILRa/q5JIadyMENFV+5C6VWb27YxLfqMSYPn4ma4?=
 =?us-ascii?Q?ILel8kseLky/tATydQhTvmjaVgBOR5ExonLy+nb+43JYz4p/dizaXmK2Bse8?=
 =?us-ascii?Q?7eIIo4x1ajJ2TKOgshlvdJdY/k18G3hBw+8wYUerSAOGaso1aPGvJXxs8VY9?=
 =?us-ascii?Q?iNIPhKeiv2AN1Jj0ZhcxEzSwE/IFHAHYwXBNtgnYIfbMJr6amGb1fACZAIZq?=
 =?us-ascii?Q?SumbOOhFdrsiBiSQH+eNnOCgYMo8bAokyp/KiBKs3EVi4aw1LH4lKD2B9k3D?=
 =?us-ascii?Q?moDh5yCgB8fcZhJ14tbPvS2sh/x3Enf+CYjHArjxhrxZsD532EyWH24Ygp7E?=
 =?us-ascii?Q?OmTSWgy4rgFvZ5I30jgz7tzUyxUmb7jWfRyjGQOdraaMlnNs7WbJIN7X1wN5?=
 =?us-ascii?Q?GlIwPds/h15/+Oz3/DOG80Ll35n+Q/+wLU7zGZdJA1qqXIi1h04pj/0VwR39?=
 =?us-ascii?Q?u53BSyGv6VdtlE1Ukw8WAaDTiRMOUPR3LV/VBb5xt5okJSg8aQdb5f8MXbHi?=
 =?us-ascii?Q?VsuDB4+1aJinsvg+lbdQdP0I1Q83/Z7+tL3tXFjlRMIryXPeNBDem2jCjnRo?=
 =?us-ascii?Q?aJsM5z7tjlYAsi0jFaC1+p7GS1rttsHaY/ULkLv7pssnonLo/Xz5+GL+ScoO?=
 =?us-ascii?Q?uu3rfqHGY7iNOn2u3tPUzCZ940Rg9NXWUOO5BfA66AWoEnnlqCfDmKsucVxW?=
 =?us-ascii?Q?cWAVP5tQSaSlznZWnoZxOVSPPIZN294M9Ptt2i16?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7455b828-6862-4f80-226f-08ddd9882af5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:08:21.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxnWB+55MjHI9nbCWGCytLWgdxPhHeXUXLzmrWXrola7Qo/MM/GiFfK+tRbzfSayZxhX0bNn2J/VEyODgGzMoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

The ENETC_F_RX_TSTAMP flag of priv->active_offloads can only be set when
CONFIG_FSL_ENETC_PTP_CLOCK is enabled. Similarly, rx_ring->ext_en can
only be set when CONFIG_FSL_ENETC_PTP_CLOCK is enabled as well. So it is
safe to remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
 drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index ef002ed2fdb9..4325eb3d9481 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1411,8 +1411,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
 	}
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
-	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
+	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
 		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ce3fed95091b..c65aa7b88122 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -226,7 +226,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
 {
 	int hw_idx = i;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		hw_idx = 2 * i;
 
 	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
@@ -240,7 +240,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
 
 	new_rxbd++;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		new_rxbd++;
 
 	if (unlikely(++new_index == rx_ring->bd_count)) {
-- 
2.34.1


