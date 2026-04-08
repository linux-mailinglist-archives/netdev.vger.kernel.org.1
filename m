Return-Path: <netdev+bounces-276291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGPEFcL01Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:25:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A143B78A8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2380E303D320
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2363612F6;
	Wed,  8 Apr 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yp74WuNj"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C11363095;
	Wed,  8 Apr 2026 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629464; cv=fail; b=quThyzyawcv65mVnlcswf/DrBkoqRpcHMh38nimK89doE3ggoTIhl+H3OiknRUPxIN/q9fg+QrKI5jd9WA+XgF7NxTbruULqo0C0XWmPIfbsCsrkHcFyysq7MiGpRj8M1l6065+j7grYBWZ6JsiKsEOFAUf0dRkajJHI/Ue/ebI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629464; c=relaxed/simple;
	bh=DUb1CGEg4yWLe9CpcX8GiteZZ10N0A30wn0EvdcbHtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AUcxbtPPWtumrcchtvRR0pApb0mIuu68xwa2hTDVBhPP85BzRFzHIm2sgQ3b62DoSmhILLyOyu/gKJcgUm/VdemNORLmmVizjoY7enW4FuH/8i8TbK0zRDpoELTgJALrJEUYYEcogP9OF0Rr5zM2+HMvso/2RCtU3xlTlT9Lc0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yp74WuNj; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm6EEDCcaKTXZOZWvyvf07nSmNRbVwXO7HsuraO079nl06eCyfxXZ9qNhPVEQ0nnsYDYtjhqaIzy4Z4ik8YphBTQyUPyYNera4f33UvZZyo0Wxc8bhX2gQA1L0q2CHTMmbFDA/QIzKDjmEDkItaSWpw0kuQSeo1i8lH2UHE29DUnLXLbrM5iQtlX/S8Ee5OELb44LiJHgf1Xc1UG619vBmv6ZzeseRmQ9es48lFkAW4bZLOvYjcClF/L19nhTfyIABZ6DJ7nTfiZ1Ihrht9bqL3ZCmAl2JbHbFijNM7pGZkDmLU3bLaFj02RdnMCROtGx6RQdINybWEWIGBW3i6jFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLrNIvCbxj6J6pWR4Z0o7/pzzMoQli5BONTwy+slFXk=;
 b=bq0LGwApH+ieb1yhytxfg+s6AJL5+5towu6vdG6VtxXizCUKn24FbjH/jLtgMJNicDxw8jxuqs6dThAhBLEmYU+NA29vzxSmT62ImzlTdKYIK1pBx1ghJSz22DgWQyWqcwYpISAiJu0mjJeh8dSEgdIt0iqtpLZWDwtDzWSJbTACNQeqk8NIc8D+HZXbAFxt/567Bg+0G1y4r7BE3RYibrS/UnAH4e8j47zIJ4iXy3MyQfjs4cYkAQc7iTvNpGJjVy3ZPR2DSt1i45M7+N+7JORb4NlELETOoikLeAnhqlRcUxnJwB2uGhSUYRjXz18zH+Ol/hcfeMCG0RnQXAS9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLrNIvCbxj6J6pWR4Z0o7/pzzMoQli5BONTwy+slFXk=;
 b=Yp74WuNjDvYx07TR8gLC6O7rXK1l568QPfQrB2Kx2L+zVw5AmMnCuuvL7+Qmhtnjv/LD5XJil9NRsDIsu47q5IOS5fcI1eiEyEdtcVa6FM4FWfuXnW9gFVj1gNIk7fY75bj3jBMn2g9t7cOsubGrEQri1frk7kj1GADgxnccZSulLMuBeWeY92UUEyIazs+5gVVfUerQf8ysy6K3xYZDgryXdikCjYO/2claMGRXDiA4b3pcxVCuh0cT8IB29KA8g8/Rs+seQssrDN+UrJ65zYSxElAJYXAFXfT3vNVmr4QGi0f2NLRb4DkLOXvz+m+iKU/egUy3u6s/qtjGx5uPcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PAXPR04MB9024.eurprd04.prod.outlook.com (2603:10a6:102:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 06:24:19 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 06:24:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 1/5] net: enetc: add support for the standardized counters
Date: Wed,  8 Apr 2026 13:58:45 +0800
Message-Id: <20260408055849.1314033-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408055849.1314033-1-wei.fang@nxp.com>
References: <20260408055849.1314033-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::6) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PAXPR04MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d1887d-b5d4-4335-636b-08de9537775b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	so8pSOxoDTuy4CgtWsrutZ8PfnntIF3ePGLyrm2FK9XutJHDRUVNqKW9LaXDP/brcKjFA2eAqqWVGxkX+i0UYEePqcWgorY97avoB6n02j/uK3NrXAoXbV+SQH+eCSD78BSFNbLw1wzZyCYzuJl3nE6P0Peq7aqIvBE/3aw3QLm0tXWRrNlC11B/Z+PaV+/S2CkV8vlZbv/UAmoQEWhcp7BpjnyyhoIa0KR31KCY/W+FZkspSOTYMOeqGYmGB6NsZEtxifDt4b6DEv2H5zOfA0FxNcFFgAKkDAZgVTQWvXu9VZt3oPPGwjiZ14UljwBr2kl3opyV7XWj+l97oUZfuSER3LphE1+6QSl15zdlt0nhwTfN/oHjgeEFLk/gqdD2kif8xEFKzHfLvoySpKeqrPPDtCJp+XqTGERoLgsbkVu8kJSL1qpyDpWDbTfMI5D3IjNQjenTT+BXRjuec3QvKpalEQ4AoV1FjvJThGkPLFAcHyzIIc2uwx3VTIN1/eL4Bw6dIELOjf4O5ALTzfktEIOKgKLDm40eoMUt5hi2Pnr0PdJzy+lTE1vfcZNri80taVxFRhnroCGybR8Su43OrUfKXp+nFjG8DsDK+fDCq0HlmnVSA9crLDj/jVDD/M6fV2fWENADQi9JLvSVK+f8UyH6GZeq3r/KtI3LJdmuG68OgdOJz2fnOZnqEOXB9DOffZ19kh02GyYdJ+r7o8P43Ahp6t8TdYG+e3DfQq8zfbP4uaX2LaXUHCEcCEruZwNYsJPB/Orgy8iAvX8V/uDYb01rvhzWE/3dkaigp+RzMc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TCLCoalMu/6KJWqbnXbLbunEwWdCm42gQ1HvJsqqZxKi2eJSFggRWJawUP0a?=
 =?us-ascii?Q?WlG9cVrSEPCLhQHfNrQkSWifzNIjwRDXeAKng7DFE/CnSvsfyUSDAjxEUD+C?=
 =?us-ascii?Q?En9LjCGr4nUL/H+wiDC/YlixAMP5IKUVIZPg+/SU4Z5DO1Emdi3z2L+jRHfw?=
 =?us-ascii?Q?OYdffujuY2gUaDfkok7p3ufldmBmCTpFBMowQasF8JsIKyDGYYYOENKZCLuq?=
 =?us-ascii?Q?Fv/TWK3/zZ6Zu/TzAIYL3uhHHF58oXiPDpRBcJYa1jE378qLp21lUozlzTrZ?=
 =?us-ascii?Q?p2IW+gRvMfo6HxQ4H274c6Op9Gso6GbKv50EMFUYeOUrByhkkm4Xv1Wqk0qZ?=
 =?us-ascii?Q?buqjTlykbev6NFaNsAOC6s9qytBqxw+aEqRLC64Awg04k9RGt3HDFSJ35+dT?=
 =?us-ascii?Q?DqNTYsb0Z9Y0690drAENJXGajxCRfPtUAqubJD95BNdzYZXVj5j+p4BaK+GY?=
 =?us-ascii?Q?hR6vnPATwkhixG7ylT1nl1Q+1C2lPbAvnDJcv1gHRJxQErHppvSBz1n7Kgtm?=
 =?us-ascii?Q?dixgcYQHRtfUIFWg843rfSwOTcn3vanpAJ/PAflPkyDo3PCt1PngCoG9ChEL?=
 =?us-ascii?Q?c6tf4D6UCkFXvLx9h25E4ypUbGWqXThaxMBGeNn1Sk0/1Nsx31xzQTQmjv5N?=
 =?us-ascii?Q?1al9f+7z+XKaJY7DT/cSOnwZB5kEPmGUxHFDR77UCpW5CkqGxNJHe/g4aPiN?=
 =?us-ascii?Q?5ucAKFY2n+dxbmGbIKXznoKzt8UtKPPjJKRBB64cpSnIr5R7Qc0sw6JkR0J2?=
 =?us-ascii?Q?82wj+O8vRKn4Nolya4O6QMbjywani8kAkn5L3/iBcNGHKTaihZinJry776Qf?=
 =?us-ascii?Q?wWej3Scf2HG7pYcAGGV8bE46EhFM3Wp3EzRbuHMtMtn5xk1ho8YDkZ3PUExB?=
 =?us-ascii?Q?5oteLSAAI0rJVXs/6pMvQT5cZplafILIYWdYykSdjedvr7E2sP3/EikZ0w5C?=
 =?us-ascii?Q?CW+4kKPq408+3KVZRULfxS6zlYrE6CmiggI8nkNnLM53o9F6ouGrOZ0ora6u?=
 =?us-ascii?Q?7GR3RxOqq5Tl7q/4VGqifk/GYTgPUUHoNmIyZZEmPOtLe6/8O8NO/X+lIISI?=
 =?us-ascii?Q?pGLwS++jhTBTSwg1+KVISp0PjCd2El+/OaWD5YY4ypN1PST9eFoojFSc1GjP?=
 =?us-ascii?Q?wIiaNAjSiqBEmoFbx2T+kUe+EO+2IzE85QKJY1wnMxJf9PTe+okJjkPcpq/8?=
 =?us-ascii?Q?an7tWVSfx5cyHtSIRLeNMYLVysgvdsdZ80nxX4wHMRtH49CseKOiF/WkwaRh?=
 =?us-ascii?Q?3sAUrgAFz119GZ463qRh3pumQaHU3x/Op+Eh8csXC5RSWu36035fRm6/Q6Ed?=
 =?us-ascii?Q?InQJT5ig6DfEFJKRoYoXsPQpTEM89VG6peFvZBb9xS3W48P+RErApD9UGy5A?=
 =?us-ascii?Q?V0M3cayMcHK257Aw0QnpddpDfK12VMFr1PQGureg1RAx+b3KvLqIhpNWi50i?=
 =?us-ascii?Q?YUZu7dgxICYPEYRV7SfIDc8q+CUySdeH3OPoDo/KSfUq5eD7Uy58pGouLSig?=
 =?us-ascii?Q?h+0DjzaTkPu0FJ27dwX5zYHzujHYwIRaUYKEOvBLeCzK7i1yrcbjCK36UQoy?=
 =?us-ascii?Q?wXZ1AlGtr06XbvykmSZh+SUSGtPH9DBugvkgpXAjmKarrkfc0iwtWN8Gcqb8?=
 =?us-ascii?Q?zAu1IxkKjCzdVoBpzHU490RUdsbJ0+6WPhDbHeXXY4VTiH+hmBCrKcmjXetP?=
 =?us-ascii?Q?AYd2InHeU1JbxUgUMAdTqvuBtLyDl56v6elalcgm+7PtqLZvgkfXjsziBeYn?=
 =?us-ascii?Q?KOxQRSyWXA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d1887d-b5d4-4335-636b-08de9537775b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:24:19.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiJ8LGOv7A6iLyR/aL5UERpbMheI2OE0OjENi5CgxD6mLNofNyZzNNvOOLDa8x5lONP6oe+S9p1w/twLArOaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9024
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-276291-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: A1A143B78A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ENETC v4 provides 64-bit counters for IEEE 802.3 basic and mandatory
managed objects, the IETF Management Information Database (MIB) package
(RFC2665), and Remote Network Monitoring (RMON) statistics. In addition,
some ENETCs support preemption, so these ENETCs have two MACs: MAC 0 is
the express MAC (eMAC), MAC 1 is the preemptible MAC (pMAC). Both MACs
support these statistics.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |   2 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 120 +++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 141 +++++++++++++++---
 3 files changed, 245 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index aecd40aeef9c..e663bb5e614e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -264,6 +264,8 @@ struct enetc_msg_swbd {
 };
 
 #define ENETC_REV1	0x1
+#define ENETC_REV4	0x4
+
 enum enetc_errata {
 	ENETC_ERR_VLAN_ISOL	= BIT(0),
 	ENETC_ERR_UCMCSWP	= BIT(1),
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 719c88ceb801..392992a646fb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -196,6 +196,126 @@
 #define  PM_SINGLE_STEP_OFFSET_SET(o)	FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
 #define  PM_SINGLE_STEP_EN		BIT(31)
 
+/* Port MAC 0/1 Receive Ethernet Octets Counter */
+#define ENETC4_PM_REOCT(mac)		(0x5100 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Alignment Error Counter Register */
+#define ENETC4_PM_RALN(mac)		(0x5110 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Valid Pause Frame Counter */
+#define ENETC4_PM_RXPF(mac)		(0x5118 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Counter */
+#define ENETC4_PM_RFRM(mac)		(0x5120 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Check Sequence Error Counter */
+#define ENETC4_PM_RFCS(mac)		(0x5128 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Multicast Frame Counter */
+#define ENETC4_PM_RMCA(mac)		(0x5148 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Broadcast Frame Counter */
+#define ENETC4_PM_RBCA(mac)		(0x5150 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Undersized Packet Counter */
+#define ENETC4_PM_RUND(mac)		(0x5168 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive 64-Octet Packet Counter */
+#define ENETC4_PM_R64(mac)		(0x5170 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive 65 to 127-Octet Packet Counter */
+#define ENETC4_PM_R127(mac)		(0x5178 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive 128 to 255-Octet Packet Counter */
+#define ENETC4_PM_R255(mac)		(0x5180 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive 256 to 511-Octet Packet Counter */
+#define ENETC4_PM_R511(mac)		(0x5188 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive 512 to 1023-Octet Packet Counter */
+#define ENETC4_PM_R1023(mac)		(0x5190 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive 1024 to 1522-Octet Packet Counter */
+#define ENETC4_PM_R1522(mac)		(0x5198 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive 1523 to Max-Octet Packet Counter */
+#define ENETC4_PM_R1523X(mac)		(0x51a0 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Oversized Packet Counter */
+#define ENETC4_PM_ROVR(mac)		(0x51a8 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Jabber Packet Counter */
+#define ENETC4_PM_RJBR(mac)		(0x51b0 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Fragment Packet Counter */
+#define ENETC4_PM_RFRG(mac)		(0x51b8 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Control Packet Counter */
+#define ENETC4_PM_RCNP(mac)		(0x51c0 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Not Truncated Packets Counter */
+#define ENETC4_PM_RDRNTP(mac)		(0x51c8 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Ethernet Octets Counter */
+#define ENETC4_PM_TEOCT(mac)		(0x5200 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Valid Pause Frame Counter */
+#define ENETC4_PM_TXPF(mac)		(0x5218 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Counter */
+#define ENETC4_PM_TFRM(mac)		(0x5220 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Error Counter */
+#define ENETC4_PM_TERR(mac)		(0x5238 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Multicast Frame Counter */
+#define ENETC4_PM_TMCA(mac)		(0x5248 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Broadcast Frame Counter */
+#define ENETC4_PM_TBCA(mac)		(0x5250 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Undersized Packet Counter */
+#define ENETC4_PM_TUND(mac)		(0x5268 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit 64-Octet Packet Counter */
+#define ENETC4_PM_T64(mac)		(0x5270 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit 65 to 127-Octet Packet Counter */
+#define ENETC4_PM_T127(mac)		(0x5278 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit 128 to 255-Octet Packet Counter */
+#define ENETC4_PM_T255(mac)		(0x5280 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit 256 to 511-Octet Packet Counter */
+#define ENETC4_PM_T511(mac)		(0x5288 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit 512 to 1023-Octet Packet Counter */
+#define ENETC4_PM_T1023(mac)		(0x5290 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit 1024 to 1522-Octet Packet Counter */
+#define ENETC4_PM_T1522(mac)		(0x5298 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit 1523 to TX_MTU-Octet Packet Counter */
+#define ENETC4_PM_T1523X(mac)		(0x52a0 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Control Packet Counter */
+#define ENETC4_PM_TCNP(mac)		(0x52c0 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Deferred Packet Counter */
+#define ENETC4_PM_TDFR(mac)		(0x52d0 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Multiple Collisions Counter */
+#define ENETC4_PM_TMCOL(mac)		(0x52d8 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Single Collision */
+#define ENETC4_PM_TSCOL(mac)		(0x52e0 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Late Collision Counter */
+#define ENETC4_PM_TLCOL(mac)		(0x52e8 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Excessive Collisions Counter */
+#define ENETC4_PM_TECOL(mac)		(0x52f0 + (mac) * 0x400)
+
 /* Port MAC 0 Interface Mode Control Register */
 #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 7c17acaf7a38..c30a119e9142 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -320,27 +320,38 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 		data[o++] = enetc_port_rd64(hw, enetc_pm_counters[i].reg);
 }
 
-static void enetc_pause_stats(struct enetc_hw *hw, int mac,
+static void enetc_pause_stats(struct enetc_si *si, int mac,
 			      struct ethtool_pause_stats *pause_stats)
 {
-	pause_stats->tx_pause_frames = enetc_port_rd64(hw, ENETC_PM_TXPF(mac));
-	pause_stats->rx_pause_frames = enetc_port_rd64(hw, ENETC_PM_RXPF(mac));
+	struct enetc_hw *hw = &si->hw;
+
+	switch (si->pdev->revision) {
+	case ENETC_REV1:
+		pause_stats->tx_pause_frames = enetc_port_rd64(hw, ENETC_PM_TXPF(mac));
+		pause_stats->rx_pause_frames = enetc_port_rd64(hw, ENETC_PM_RXPF(mac));
+		break;
+	case ENETC_REV4:
+		pause_stats->tx_pause_frames = enetc_port_rd64(hw, ENETC4_PM_TXPF(mac));
+		pause_stats->rx_pause_frames = enetc_port_rd64(hw, ENETC4_PM_RXPF(mac));
+		break;
+	default:
+		break;
+	}
 }
 
 static void enetc_get_pause_stats(struct net_device *ndev,
 				  struct ethtool_pause_stats *pause_stats)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_si *si = priv->si;
 
 	switch (pause_stats->src) {
 	case ETHTOOL_MAC_STATS_SRC_EMAC:
-		enetc_pause_stats(hw, 0, pause_stats);
+		enetc_pause_stats(si, 0, pause_stats);
 		break;
 	case ETHTOOL_MAC_STATS_SRC_PMAC:
 		if (si->hw_features & ENETC_SI_F_QBU)
-			enetc_pause_stats(hw, 1, pause_stats);
+			enetc_pause_stats(si, 1, pause_stats);
 		break;
 	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
 		ethtool_aggregate_pause_stats(ndev, pause_stats);
@@ -371,11 +382,45 @@ static void enetc_mac_stats(struct enetc_hw *hw, int mac,
 	s->BroadcastFramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RBCA(mac));
 }
 
-static void enetc_ctrl_stats(struct enetc_hw *hw, int mac,
+static void enetc4_mac_stats(struct enetc_hw *hw, int mac,
+			     struct ethtool_eth_mac_stats *s)
+{
+	s->FramesTransmittedOK = enetc_port_rd64(hw, ENETC4_PM_TFRM(mac));
+	s->SingleCollisionFrames = enetc_port_rd64(hw, ENETC4_PM_TSCOL(mac));
+	s->MultipleCollisionFrames = enetc_port_rd64(hw, ENETC4_PM_TMCOL(mac));
+	s->FramesReceivedOK = enetc_port_rd64(hw, ENETC4_PM_RFRM(mac));
+	s->FrameCheckSequenceErrors = enetc_port_rd64(hw, ENETC4_PM_RFCS(mac));
+	s->AlignmentErrors = enetc_port_rd64(hw, ENETC4_PM_RALN(mac));
+	s->OctetsTransmittedOK = enetc_port_rd64(hw, ENETC4_PM_TEOCT(mac));
+	s->FramesWithDeferredXmissions = enetc_port_rd64(hw, ENETC4_PM_TDFR(mac));
+	s->LateCollisions = enetc_port_rd64(hw, ENETC4_PM_TLCOL(mac));
+	s->FramesAbortedDueToXSColls = enetc_port_rd64(hw, ENETC4_PM_TECOL(mac));
+	s->FramesLostDueToIntMACXmitError = enetc_port_rd64(hw, ENETC4_PM_TERR(mac));
+	s->OctetsReceivedOK = enetc_port_rd64(hw, ENETC4_PM_REOCT(mac));
+	s->FramesLostDueToIntMACRcvError = enetc_port_rd64(hw, ENETC4_PM_RDRNTP(mac));
+	s->MulticastFramesXmittedOK = enetc_port_rd64(hw, ENETC4_PM_TMCA(mac));
+	s->BroadcastFramesXmittedOK = enetc_port_rd64(hw, ENETC4_PM_TBCA(mac));
+	s->MulticastFramesReceivedOK = enetc_port_rd64(hw, ENETC4_PM_RMCA(mac));
+	s->BroadcastFramesReceivedOK = enetc_port_rd64(hw, ENETC4_PM_RBCA(mac));
+}
+
+static void enetc_ctrl_stats(struct enetc_si *si, int mac,
 			     struct ethtool_eth_ctrl_stats *s)
 {
-	s->MACControlFramesTransmitted = enetc_port_rd64(hw, ENETC_PM_TCNP(mac));
-	s->MACControlFramesReceived = enetc_port_rd64(hw, ENETC_PM_RCNP(mac));
+	struct enetc_hw *hw = &si->hw;
+
+	switch (si->pdev->revision) {
+	case ENETC_REV1:
+		s->MACControlFramesTransmitted = enetc_port_rd64(hw, ENETC_PM_TCNP(mac));
+		s->MACControlFramesReceived = enetc_port_rd64(hw, ENETC_PM_RCNP(mac));
+		break;
+	case ENETC_REV4:
+		s->MACControlFramesTransmitted = enetc_port_rd64(hw, ENETC4_PM_TCNP(mac));
+		s->MACControlFramesReceived = enetc_port_rd64(hw, ENETC4_PM_RCNP(mac));
+		break;
+	default:
+		break;
+	}
 }
 
 static const struct ethtool_rmon_hist_range enetc_rmon_ranges[] = {
@@ -414,20 +459,61 @@ static void enetc_rmon_stats(struct enetc_hw *hw, int mac,
 	s->hist_tx[6] = enetc_port_rd64(hw, ENETC_PM_T1523X(mac));
 }
 
+static void enetc4_rmon_stats(struct enetc_hw *hw, int mac,
+			      struct ethtool_rmon_stats *s)
+{
+	s->undersize_pkts = enetc_port_rd64(hw, ENETC4_PM_RUND(mac));
+	s->oversize_pkts = enetc_port_rd64(hw, ENETC4_PM_ROVR(mac));
+	s->fragments = enetc_port_rd64(hw, ENETC4_PM_RFRG(mac));
+	s->jabbers = enetc_port_rd64(hw, ENETC4_PM_RJBR(mac));
+
+	s->hist[0] = enetc_port_rd64(hw, ENETC4_PM_R64(mac));
+	s->hist[1] = enetc_port_rd64(hw, ENETC4_PM_R127(mac));
+	s->hist[2] = enetc_port_rd64(hw, ENETC4_PM_R255(mac));
+	s->hist[3] = enetc_port_rd64(hw, ENETC4_PM_R511(mac));
+	s->hist[4] = enetc_port_rd64(hw, ENETC4_PM_R1023(mac));
+	s->hist[5] = enetc_port_rd64(hw, ENETC4_PM_R1522(mac));
+	s->hist[6] = enetc_port_rd64(hw, ENETC4_PM_R1523X(mac));
+
+	s->hist_tx[0] = enetc_port_rd64(hw, ENETC4_PM_T64(mac));
+	s->hist_tx[1] = enetc_port_rd64(hw, ENETC4_PM_T127(mac));
+	s->hist_tx[2] = enetc_port_rd64(hw, ENETC4_PM_T255(mac));
+	s->hist_tx[3] = enetc_port_rd64(hw, ENETC4_PM_T511(mac));
+	s->hist_tx[4] = enetc_port_rd64(hw, ENETC4_PM_T1023(mac));
+	s->hist_tx[5] = enetc_port_rd64(hw, ENETC4_PM_T1522(mac));
+	s->hist_tx[6] = enetc_port_rd64(hw, ENETC4_PM_T1523X(mac));
+}
+
+static void enetc_get_mac_stats(struct enetc_si *si, int mac,
+				struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct enetc_hw *hw = &si->hw;
+
+	switch (si->pdev->revision) {
+	case ENETC_REV1:
+		enetc_mac_stats(hw, mac, mac_stats);
+		break;
+	case ENETC_REV4:
+		enetc4_mac_stats(hw, mac, mac_stats);
+		break;
+	default:
+		break;
+	}
+}
+
 static void enetc_get_eth_mac_stats(struct net_device *ndev,
 				    struct ethtool_eth_mac_stats *mac_stats)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_si *si = priv->si;
 
 	switch (mac_stats->src) {
 	case ETHTOOL_MAC_STATS_SRC_EMAC:
-		enetc_mac_stats(hw, 0, mac_stats);
+		enetc_get_mac_stats(si, 0, mac_stats);
 		break;
 	case ETHTOOL_MAC_STATS_SRC_PMAC:
 		if (si->hw_features & ENETC_SI_F_QBU)
-			enetc_mac_stats(hw, 1, mac_stats);
+			enetc_get_mac_stats(si, 1, mac_stats);
 		break;
 	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
 		ethtool_aggregate_mac_stats(ndev, mac_stats);
@@ -481,16 +567,15 @@ static void enetc_get_eth_ctrl_stats(struct net_device *ndev,
 				     struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_si *si = priv->si;
 
 	switch (ctrl_stats->src) {
 	case ETHTOOL_MAC_STATS_SRC_EMAC:
-		enetc_ctrl_stats(hw, 0, ctrl_stats);
+		enetc_ctrl_stats(si, 0, ctrl_stats);
 		break;
 	case ETHTOOL_MAC_STATS_SRC_PMAC:
 		if (si->hw_features & ENETC_SI_F_QBU)
-			enetc_ctrl_stats(hw, 1, ctrl_stats);
+			enetc_ctrl_stats(si, 1, ctrl_stats);
 		break;
 	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
 		ethtool_aggregate_ctrl_stats(ndev, ctrl_stats);
@@ -498,23 +583,39 @@ static void enetc_get_eth_ctrl_stats(struct net_device *ndev,
 	}
 }
 
+static void enetc_get_mac_rmon_stats(struct enetc_si *si, int mac,
+				     struct ethtool_rmon_stats *rmon_stats)
+{
+	struct enetc_hw *hw = &si->hw;
+
+	switch (si->pdev->revision) {
+	case ENETC_REV1:
+		enetc_rmon_stats(hw, mac, rmon_stats);
+		break;
+	case ENETC_REV4:
+		enetc4_rmon_stats(hw, mac, rmon_stats);
+		break;
+	default:
+		break;
+	}
+}
+
 static void enetc_get_rmon_stats(struct net_device *ndev,
 				 struct ethtool_rmon_stats *rmon_stats,
 				 const struct ethtool_rmon_hist_range **ranges)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_si *si = priv->si;
 
 	*ranges = enetc_rmon_ranges;
 
 	switch (rmon_stats->src) {
 	case ETHTOOL_MAC_STATS_SRC_EMAC:
-		enetc_rmon_stats(hw, 0, rmon_stats);
+		enetc_get_mac_rmon_stats(si, 0, rmon_stats);
 		break;
 	case ETHTOOL_MAC_STATS_SRC_PMAC:
 		if (si->hw_features & ENETC_SI_F_QBU)
-			enetc_rmon_stats(hw, 1, rmon_stats);
+			enetc_get_mac_rmon_stats(si, 1, rmon_stats);
 		break;
 	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
 		ethtool_aggregate_rmon_stats(ndev, rmon_stats);
@@ -1398,6 +1499,10 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+	.get_pause_stats = enetc_get_pause_stats,
+	.get_rmon_stats = enetc_get_rmon_stats,
+	.get_eth_ctrl_stats = enetc_get_eth_ctrl_stats,
+	.get_eth_mac_stats = enetc_get_eth_mac_stats,
 	.get_ringparam = enetc_get_ringparam,
 	.get_coalesce = enetc_get_coalesce,
 	.set_coalesce = enetc_set_coalesce,
-- 
2.34.1


