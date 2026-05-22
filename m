Return-Path: <netdev+bounces-290738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ1KFxUhEGqjTwYAu9opvQ
	(envelope-from <netdev+bounces-290738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:25:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC205B1211
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 048B730242A8
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FAA3C4572;
	Fri, 22 May 2026 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4VXQ96F"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9103C1F31;
	Fri, 22 May 2026 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441743; cv=fail; b=qUHuAE5XRPNUliYhbJDO1oeYQjYfown83WmwKesbg/VdrnD5wIDjZorkniAzV9adkENrj56htjVImd50WpN5nt3cu7n7LQxKTPzTcY5rxzvt5tI/aoUaKkN1svWGIgLfkeLV/XnD2Qr5NEkpD+9oxw6ImSc9u8C6OTDgMhwn4SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441743; c=relaxed/simple;
	bh=oG5mWpp521udYK5P7pF9sCS718SpDdvU9GiKRVcAt7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iT2rkcTjhgCpViyxeAOhatSzQAKatriZrvnpSEz3ceod0LOhkuznkwk+eBDyIm/sycZauI18AABozCmpCcRuSav5XVa7BeZ3fKgZb4lBhNhsCCjoA++X/UYlVA7oHQD+vsdFc6Pe9C2diUlV3hd8fcv62/mCiNgGOf7BnIdDADE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E4VXQ96F; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNJ0+DJDo5DMFvgYRKMlbtEZbCHys0ARaSbd6FipU88gGMcgaXhlF/OWGIigjNDc/Sd28ym2rmxoDYRKoIw3DL1yB59qznCXQUWIae7PYwi1UqMR3dIvoUWZgq4VQ1Q5folOm5oxpSz+bcKQyfzf6NYC/tqMEK1a88lUBbBmU4O23xSfsSzk4Olbi5Pc8BtZajcBhIBz9r6IsvJp0+w+vt3KUcdGvsvI1aRoIkMmup5AGhYYYNX7klyNmjnjeYuycYng252VcjibiWFUfY6UyV3EODEFqa8TvCIOrk36TL+y3skuNOcCkd17qv/zHY+a3DOPOJ+mp7w6YpPkanrB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FflHzFWCV/0b/BkTKi2uaOiRSOPnOG1D18Uxaqwplyw=;
 b=YlbGu6gZdTzTYJjN9K8g1kdKlvKJLaigFqD+bbmwtCsh29ox/gxho1bUUfar15hmBKxE1FdFv3bcJcf76bpTsy5dK4jXXlpqgei4tV5Y/GGnFWcV8aKod6XvE0VEIRrsQHTtNTms7gqP5lRS3k5PjgDTB3N5jQVSHYYBzBEcLZCgsnSl6s4pOeCZpW+O5uQoolm/3gBWCUtItkSWtgmVYurwCfeyDCPUPlYUdg6TDeuHH960peYNJZeU7+4bBKU4g5erbOg0MXSLV3KTLSGIdFYiWRWL7BgKk2hsfir7Mms9K4GhvqIdif41LQgSoTY7c8acQmcoGOAR7euLtlnufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FflHzFWCV/0b/BkTKi2uaOiRSOPnOG1D18Uxaqwplyw=;
 b=E4VXQ96F8NvH3HDCqHIDuxGlFARwKccas0X7wISh76+S90JQ/z6AZZ3qgSx33lkXkmFX/W1WpuewI3qm0s3vsHZuEhpEdW+Ri5eFYSacMdSq/dzGDnyQYKbhLNnh5sH0So52e81RK7GJ5DC0qBTHvdzXhKFFOpWinAehLVnSkeVps6L4lxc7lB99jFPYHo3p6nlJND6s7+nTTIqeeTGwRNK85vMnNVEZZJAKK0YuC/Kd1g+xEAjbR6+z1zr8v5iRyfYLqoWHgwqtPBjGiQbQ+K5MAa3wWMbQP3amzyGenyX+gFs9XOa+Lc7yoW66kiEMgRkiDa/Sz5r1T5WqJSJgWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 09:22:21 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 05/12] net: enetc: use read_poll_timeout() for VF mailbox polling
Date: Fri, 22 May 2026 17:24:31 +0800
Message-Id: <20260522092438.1264020-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522092438.1264020-1-wei.fang@nxp.com>
References: <20260522092438.1264020-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::6) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA4PR04MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db263cf-6ce7-4d3f-ed70-08deb7e3a040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|19092799006|22082099003|56012099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	ij+3nY5DI3LEbx17BeQMBQcwe2Mstq6Zu+sAzLYxL5ElvEqDFBAjxaXDP2FhACudDBIFIC2cRVapl0IlW7RI6Deo3CrPUMSxGaV4umLsJjo0JLnQp4FeSWqJd6SkP774UZrXETnC7TEAStl7ZIrEpHG17en6ZydvOmB+0CF3arMGd7tONqucZtyk2r9AV7YnC+WNMSECmmiHzMaIEBrntGmQW/Dffwq/GtUv7ZtMtzjNnggosHmLMPMx1+8dCySPRd5K32Zh/kLvBLzHMAqdXdnpluUzckiSgtwP7DdHTSWFkoRCMP2as+W/K9Tpjnay04MuyK4Mrln81l3lDZdlI7aGHlVmGqcO8gUPxqgIH7dZpBY1bdeJH4mg/0fYmMGjWybslnf8I/xgOmVUydERxVQXguzJ8adXf+DyeQZe5yeJy33CeyEkA+o4uTcaQLJ4Fmx/oDVSWZ4xv6+/Ht3rujo6W4Xrj1tdxvwyL93YjesqMo6rDZp9+wwIXpZE+QC2Joor80f2Tu73A0A3vE3rF/N4qH1DZGkT6jP6CWcFwxmqsi9MjQV35lAlg5pjIkMLLejtL6la1YZjhiBZPU2NIm1RFYp3VHS+BrsLAHTQ8s7Z80brLILJASMAB+H2ie49Uotqsxvh7zL6pHWZp8lgzRdb7qdwBuHZl5WD7oHGWKS1UM7KZTTVN1Olx0NDXYUgDoJDxL+n/3c2Jf13glf5gArxy9yxCwhEC3eCDezPVQJaETtiNeOgmsLM0lfKoXy1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N6v2PUrE/XjOEd/UFLc/Q7iD2fbA0ExtY3a++vaCTf+eTqQ+X179JmpIQoCY?=
 =?us-ascii?Q?8OJZx7JHsX5pPyqXXTfdmrgk2dmJExGzcfb8q9x1DQAzwdKzgyVjlqa/0xxU?=
 =?us-ascii?Q?yDAlBttOrZmpwUcKWOvuVMDnYkjreOKLMt4DR4HTFCGxFGesPRwfFPiaD6zK?=
 =?us-ascii?Q?Zr7+vCacxVHs7tr8wAmqNDwVGsyjqa+tIlZ3NTVEkt3FyqH/Rf+xcLeSJwFW?=
 =?us-ascii?Q?X2nyml/ywbagVD6+4KHuqnBdpc+eB5Fd5lyrizYULBe+vB59dOQK5MdEDklh?=
 =?us-ascii?Q?M98znWjef3lyV21rFHk1jFD09q/T52RvrhIwGN9NAqwjA8D3jnUmETmR/4m1?=
 =?us-ascii?Q?kcIOVjNf1Qt6mF6v1oSuFTMrfGUkVd5I9kGPuQ1IrqWNh960baE+78hwKVPb?=
 =?us-ascii?Q?h3x3nTCd4BoN+1E7j6rQyp/zoOBYTSe4JN/pNeB8kMImMMYQzvdJ9MVewnV9?=
 =?us-ascii?Q?pcTR34r4M2ducq6ynKY4dnNOssaX+K3twS9eQYactMaNus3f3Elq+qz/oMtg?=
 =?us-ascii?Q?Kxaz7wQ/ETcsZB+oS4PJ1JhpRJdF6e0qWIyrfEw1L76O2CO63FWw/JS2toVa?=
 =?us-ascii?Q?cEikEK7DGVkfFvxgmxkyTf1NmbHMzMw4bXhOwQm/C0ESuVrWeIPNDLG8QOew?=
 =?us-ascii?Q?JV2s7jezXYZKBI8Arkb0hOeILNCjRk/J1m5LtiLgAPYxYNwHFgFATmW4ysCU?=
 =?us-ascii?Q?yFr4LuaBhmah/3w4gri4cg3DaAwWU5EwXCbWPQgFh6EYpI5x1GSvuVV4EYBp?=
 =?us-ascii?Q?3y9aNjp3G6rj8MmungMNCh/+VvVrRpSgHBBKA7jPMacgV6+TeIoyNSPjj4dZ?=
 =?us-ascii?Q?o0rrMQHccNGd5x8t9B6Ty6EWCK7GBDFfPNtOS9kRza8ddym9Y/RWFOiQnszj?=
 =?us-ascii?Q?zBjW31NTXmVDJ+D34/eqnMgnOcMfjxW/pFCpljfPR709dUe7kIzE+BSG0vGt?=
 =?us-ascii?Q?uhWoIJvGaQ2SJ2J6m5UwMP1Mk46G8/cPpUgeNyBIeoPvoA0ERPQr2IgpCAQt?=
 =?us-ascii?Q?Y7keQAaYKzNN+w2xr4Xoa6TzWKu/1WqDFSLk3+hI3Iy1MzPZVmzdGj3Tb+1B?=
 =?us-ascii?Q?MSHgyWbMYcWOjunSl3OaWiZDdLpr/hVHtIvs1PQL9/oFbk094wZ55VZrahi8?=
 =?us-ascii?Q?Rk/V+DC0b0SnTR6sswxjW+npsS+yKPnSAm2ouSBP2tyyc8b6NL36pToEruvZ?=
 =?us-ascii?Q?rb2465g0Bi0mQSRDzx8h0xKVxGW4O5LuQ+byah75WAt7A/9xmj9xaTKQ+xxT?=
 =?us-ascii?Q?K7XfpE5Jina76EgekpprYXwDkZZ7GxhxfU8lLsUyKLJXLKjj5X5Mlz2F9Cmz?=
 =?us-ascii?Q?qH6L8ow6aZ9ne+nT2cldO0pi0msTtIVyHPrANnSQxEaSzRuE0sh/mFizDsYC?=
 =?us-ascii?Q?BK4igQzdcSOAVxw4SOWQkiF4X7QUV2BbpjrFdkbUGubIcrcxWIrC3tRWyHCH?=
 =?us-ascii?Q?2AQIH5qMg1qDkvv9YFX8zQy2BM/OuMc3rkqABMlCvuRIsxdwM9Y2WwoEyYFq?=
 =?us-ascii?Q?nOBpFMDelqOjlMarPLrix7Il+WjEHpBNu40TQRrG3s8CETcL4wsrIyCMlGW1?=
 =?us-ascii?Q?pjYPNMgrKTR8P0fw1y+u1Futic3wsT3NhfFmcF7TbuBASth2VzA3okmK7mda?=
 =?us-ascii?Q?9VVtCkuq5Xoof2VzJPDpHZAz6utEV20ajaL/taPspuNm5t1FDrs3FX3yqWWg?=
 =?us-ascii?Q?qMu5QGb/RiJpZ45gwVzhUxld2NiSnOHM0eT8uxu3UQRiiVc2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db263cf-6ce7-4d3f-ed70-08deb7e3a040
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:20.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1FdhW2ciXXbpr4mUeB4Fndf8C0n9WF7Mfpx/vfuLNL4mRC5Rr5QmfcvG5EQCOl5mVvZ8psY7crysl0lIralAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-290738-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7EC205B1211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the manual do-while polling loop in enetc_msg_vsi_send() with
the standard read_poll_timeout() helper to simplify the code.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index df8e95cc47d0..9065bdbd02aa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2017-2019 NXP */
 
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include "enetc.h"
 
@@ -28,8 +29,8 @@ static void enetc_msg_dma_free(struct device *dev, struct enetc_msg_swbd *msg)
 static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 {
 	struct device *dev = &si->pdev->dev;
-	int timeout = 100;
 	u32 vsimsgsr;
+	int err;
 
 	/* The VSI mailbox may be busy if last message was not yet processed
 	 * by PSI. So need to check the mailbox status before sending.
@@ -48,19 +49,13 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 	enetc_msg_dma_free(dev, &si->msg);
 	si->msg = *msg;
 	enetc_msg_vsi_write_msg(&si->hw, msg);
-
-	do {
-		vsimsgsr = enetc_rd(&si->hw, ENETC_VSIMSGSR);
-		if (!(vsimsgsr & ENETC_VSIMSGSR_MB))
-			break;
-
-		usleep_range(1000, 2000);
-	} while (--timeout);
-
-	if (!timeout) {
+	err = read_poll_timeout(enetc_rd, vsimsgsr,
+				!(vsimsgsr & ENETC_VSIMSGSR_MB),
+				1000, 200000, false, &si->hw, ENETC_VSIMSGSR);
+	if (err) {
 		dev_err(dev, "VSI mailbox timeout\n");
 
-		return -ETIMEDOUT;
+		return err;
 	}
 
 	/* check for message delivery error */
-- 
2.34.1


