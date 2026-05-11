Return-Path: <netdev+bounces-286523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGQJI4OWAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9C650A405
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34371306D93B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CBA3BADA2;
	Mon, 11 May 2026 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N34mmbwL"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E863BBA1A;
	Mon, 11 May 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488535; cv=fail; b=QJTFOrVaUpXANECt1KtnNv3vDJIYdzD9EOW9ctJzbb0abqXYtms4XKBguG/X1TAu9iE3st9c+BK+rwaDDPPWeJTVIQT+8qHWZVBGZJeSMf5o4lXuK6Zyli3SPGbbVUHh575z5fanP9JgnlcYJ2Hbe1TWtmuY1CLbHDnaY9lqRI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488535; c=relaxed/simple;
	bh=cWrGKjEtIyRhQW5mL1zGuudPTHdIiKwl0H4UVClnclE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBBlQ0nwiJapbd8F2F1kVnXIYb0no+OOyQCaYBIjIxLM+kBTqgnarPc/Afu++WePlGaV1QrHqSrNqSRLRMw2dJUMmggIYrBt68lAIf8TlD+K07muT7jIv+YZustxl1jr9O4vaMZozWfNqDlh/nXjjykHuhhLIcK0B8S/7cVX06s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N34mmbwL; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os6Wc8ffuzS2IbBtPBfDdq75SRPG3ihWtGm2nyJEs776ErjwVKK+pDBdgtqjyPkbjs6Fd2zYlpMUp40stz+G0ukL0hrf8z7FbD5ko6urPkzXxN+4Ig0Uv7AbVZ9YBxTjoM/oOsgyQjSZKkahXZeWUTRskGPXUe3/cTpnQ6yLiaO2BDR3c8OGweffb82iFCAO8n0VKSY9vyYW0xVqQvSGxP81uKo/FaYSWuG4CbvO0fi8fq3F26C6USMlLD/71u0b/7tXpC2VwEabpMzTSv/VhlmQeVsR85mQ15dF4wZh2AMVAPurCEdND9So/trC1fStEkAsB4FxOEKq0a1jRHRBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=876jopHB6utsFA9UFh/LhPQmcYrHsHn3hAN/ZauBWpk=;
 b=NCV4YMP3EuEtXo8E2CM1JS58LIJJ5t49kfk+ygI0ZrjJrIS9ZLEVJM2mVd/3yzmlcmkcuo3aoCXJiqF8rvy3dewvWosFb6/O8tzDtlD7NRaCWOkBSA04nPUU+M2dRQSDzDW7U3q6s5LPmwDnwD701otntnCoZUxLJhkgYgSXnXu392sKkEDbpgVSU/DV3PWyaqvv5UYfPf93+YRL2/1i7h6tQZTxTmt2sgfvwd3i7uvFf+e0JaiOfOsTCa5WjPVmMT2r76AptoY5+xfx7D/qkYvFqAsWNTK6yJLqN/6S/BpDqjVYOnpCiXMyGn7PGc/c8CAeXkpoHHvJc2ycInA/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=876jopHB6utsFA9UFh/LhPQmcYrHsHn3hAN/ZauBWpk=;
 b=N34mmbwLdMegjgpPE6UItGF1DJUuDOudjCprPLeFZQfJXhvnTs/u+qMlDPUXEoFFmYjIIV+dks0JtUD+BRfta7wynXiXvymWBdbONr/F4zDbErIdccNfOY5DmT4UAcLnAHql9lQ72mLF1nvo/0SIKNgDT5iFeLAdlFFcdRHlB+EHvjBLNvrJlwugxLSaC0iGQIe24JrImZ3CQa5RnIS0Kv3X0dKR20ZP+kS36Nsl/vpWf71QqrTPaOLG8GvqHOqlZmQTXFXnhBe2Qc8P6iOR2OgvRDbO16arh+reFy3hIZVBv09LuQz1lOOmPTLLcLRySKvs3Ohf3R7p1Gpa4vzNKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:34:59 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:34:59 +0000
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
Subject: [PATCH net-next 06/15] net: enetc: use read_poll_timeout() for VF mailbox polling
Date: Mon, 11 May 2026 16:07:56 +0800
Message-Id: <20260511080805.2052495-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d96e22-c0d1-482d-1d9f-08deaf383000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b0lAA5dvxUd/DzsoL85uruFFmbyugkfgtMealiBzLFQhVT2PH9kICMGpypX01VAuidNbXVukjt0j6UvWn/B99TGhmShZPrgEJqcJMZs8hk2ic7VXl/G0pqRZroyUtCaqxx3RsPhj1ONwdr35MO5Mk62RIB31HE8Z3xxfho/NX9Te+12l7V3HO+8WinZ/bItjoTWWzM552XtfHwQtr4GFjBFZ7mxLw3gNSyO6mZRsUDe3g3sQYlho8ONri3YX3ntdwa05C1Q8j6rVmzJgSpm2Gk2fuLfRTOhNQMvN3rRLFu9q+3Cw8xZ4TXeZEXIXCVWFhB/Ys7Eajp5dTO4n0TqoJrM6qc6ajW5BiKZILPb59za3pO5lOgzgYURMbrPovB3wpRKyCg8IDGZx5+v8jzGrTmMiiQDLsWXi8DzXDV+eh61i3Cy3O5lBlXc7JYmUdYPSIFszEgiL1gqO8lsCRWyj7QH2etK9lOcCmUwSrDXPQ+KVrdYV7OpOcdemXZ0DLsvNLduyaQ0b5PsqlQyX9CZ+dVVw+f/3LWEB+qpo1EUyUFQ64XlMGlpD1VOJoyASH+JzTTBiH0XaVEP/1SwB9UdYuIAQ4J1hUmo518m13CGfigltz8ygV6CC07XKMss72lR6W8sGFnfCb3gYVyiQZFEeJLj8N6NAQ6JulpioDAObnf4xepO9onxfSh56gGHFRA2TIdm/2H4SX65eXccLPyNow1hOp+6Nle/RqJkjUIXCChb3T0riZ7cUFGSsj3MJcapD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3orKz3jpL5LrsCJ+UmE/A/fpZ9XZyIBOhN3EY7PAQ3fI2IYSNTNJKzzDTaQx?=
 =?us-ascii?Q?Qz1aSS/lX8YyryYih+bKSD/D/DWvkr8CgZEKKZrOWBmNxn9u+JiJN1/KRzXB?=
 =?us-ascii?Q?IF7TtRXNat9q7GnHqfheiAiq300UZoVgipKlpgmRz03IN888ySF9QIUpumSa?=
 =?us-ascii?Q?bqRbaWNhId7PsSlK6yMpXnTIIza15dXZ8CozBJ61a/K1j5V/GFk3Gmcu9/11?=
 =?us-ascii?Q?6nW/TbCteqdOLU6i5swwzImySf1CASapicNafzjIGRkZKGsmnSk+0BJYFQZS?=
 =?us-ascii?Q?mnCycZypFxhNztaJI4xBBbzvJPp99OUJZI6GXRTuhBV1VraOHDayMhy261b9?=
 =?us-ascii?Q?jmaVIf2RrkK/UxZRW4GIiBJU8GPNw3F96MxoFpmnywpeInWU9XZxpSH6GrsD?=
 =?us-ascii?Q?GYndA7wOWgt/Xxt0Gr8X8PSDbsNHQAd9pA5tpBTu6uOkOOzHuZmB5se7aFd3?=
 =?us-ascii?Q?pTKr7el/UDCi4ICJ06eVFPbMLV5vsmMrcuzSuIK+urFML3iJRIDBQzWbyzRs?=
 =?us-ascii?Q?7k1ZUNJM5ywgyY4Q/Tu1kzLgSwCsuSK6gpqWBt1UyXkqDyytZ6mLuXbBjbk1?=
 =?us-ascii?Q?N3BmGqTXcT0yMr+iZhhELpDPRquqMgdtb7N667DYSqFVOJvIF6/oZHzYnHP/?=
 =?us-ascii?Q?jIS1arBt5afqnd43/HEXfP5/7T2MMQtWUF2as5EFQJ2pnbs6XRITRxjxIdJ1?=
 =?us-ascii?Q?R+ic/ISwaDI08afULVWqsjzb+GPTE3cWde+HgoHpsL0rpDwp9S3drcT4/iez?=
 =?us-ascii?Q?fV7qE6UmPsiso85j6j83n09KiitX0jX4UwWUAWLbgWLICf+YNg9lJrxfHqv4?=
 =?us-ascii?Q?AH3JTrSssHArBzyfk+51Ah3vlNPtvjTSPyCjW7evOPC5bU4jSpxEX75KcJUd?=
 =?us-ascii?Q?3/uavs1c9SRsGZtxKDcMtdFhGzgk+MrNdHC+jBW0Ms7uyeBEzvgo320A82Xy?=
 =?us-ascii?Q?PsOIKzyOTZZ5Cp2bmUyB5OPmhCQOpJu5mcEKULaLsT83jII9IMiz/IwEceUN?=
 =?us-ascii?Q?QtG0fE8peTvMuhiUQfDPOKLa/jw6ige0SZ6fYGJtc1Ff5kbtm/QbsSld4ATa?=
 =?us-ascii?Q?LwjzJ82l0s8w9Is++1wnCbt0j7x0+4TPbyh0DDyVHqfnKqubk+Sqxa47nW+B?=
 =?us-ascii?Q?U3VPOdt5iPc4pCOIWbw6zavlGrK7nnhDM856xLlIuX0LXXoAFfLr4LXgVjfs?=
 =?us-ascii?Q?YSPDHDGQ219tUkYpDnJX+ioMGt9gTt4/I26vCRJnjcLqp/iq43B/3n+pGw42?=
 =?us-ascii?Q?NGtY7JR1C0JHQXaKcUpBdWRvM8P4pPkMfqOl2rYrVpDKqqzDbpdxEjxaF99Z?=
 =?us-ascii?Q?ZHqFQY62iXxXmHCmtWx7qdKTJ4J40Dm79aeWynceOS7JdjWMgdNs1xu0XH75?=
 =?us-ascii?Q?HO0xZiJDOKPF5gbOxDqYKI4a2o9LYhvm26h4gKm70Um5Y9McIXV8GUVG2sRX?=
 =?us-ascii?Q?tV6V5k1xGGWmfqchkGb0iiuJ+S0Pm8Xcaqvi/oJVWC4d8vHOVeLoQ/KMXy59?=
 =?us-ascii?Q?dK/3PdaHifvhmPxL5037iDwBJXOr/F0CWdaH5j8pC/eOjXUSMtE7p7rtc0ky?=
 =?us-ascii?Q?Llltm3Moo4lASZqniZXHtS4hYWohlopM9nYFVeKg85HBnpwdNHaWVnQPIRUt?=
 =?us-ascii?Q?xbXyYA00ZLg++Tmc7ez0kKQp15MB1Oy6fPhmW4RXjBHL0ZSTY4gCoQdCMNih?=
 =?us-ascii?Q?97m7ec4MjhV6o+lGTGMxTkL50qDl44j/VQvOwEkn/10iXIaP5e6bn4+rNYMs?=
 =?us-ascii?Q?h/K+k9SWyw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d96e22-c0d1-482d-1d9f-08deaf383000
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:34:59.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf2qlcp2EvdPsXenFFFeQvSOoPuEpQDIrkrKzAYeJQBVpJziOuWH40KtJMRiRZRIYzsh0cj9yyyFZssh5zPt0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: 2E9C650A405
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286523-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Replace the manual do-while polling loop in enetc_msg_vsi_send() with
the standard read_poll_timeout() helper to simplify the code.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_vf.c    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index df8e95cc47d0..669eb939e33c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -28,8 +28,8 @@ static void enetc_msg_dma_free(struct device *dev, struct enetc_msg_swbd *msg)
 static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 {
 	struct device *dev = &si->pdev->dev;
-	int timeout = 100;
 	u32 vsimsgsr;
+	int err;
 
 	/* The VSI mailbox may be busy if last message was not yet processed
 	 * by PSI. So need to check the mailbox status before sending.
@@ -48,19 +48,13 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
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


