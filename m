Return-Path: <netdev+bounces-280916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLGRJMXR6ml6EQAAu9opvQ
	(envelope-from <netdev+bounces-280916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 04:13:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E46A9458F70
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 04:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7F5C300E153
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAA4253359;
	Fri, 24 Apr 2026 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NflATdKW"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595613AF2;
	Fri, 24 Apr 2026 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776996803; cv=fail; b=UpQ9FSFfKKlXJVdokWoYgkUlts5sitVhsdJ+ZwXebwhLSGAdYuutJPvWvopgbd0z8C0CVWUNroyf1QcqT6YV+C/VPgo4VQtxpPXEVtGVKTZPQ192NKH07R9pw388LOsInarUN95Fl2hUClPYurLcdNOCfbvBhRMYBvR52ssXzbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776996803; c=relaxed/simple;
	bh=Vy9QYHCRULW+BoAzeM1INHmaIi6fZ23aywMruxC2hxU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tdpaqel1ynYNFrEYMK/hqjrp0qUrZ6D8oKPoNE223Wxl/uHWDNvrZiBUvvCrYvl7H9yOCWCLwg/aC+UWYUPxJ6wy4wmFP3KCYTwqEwS2+34gMth43S9YXVyF4cvpzOLh2bgFEVMtgz9FR401Hu0zdcfqyiTaNyHq7qttBxCM6Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NflATdKW; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEz0nsuaZnqXpRuZHNfvqRn7tME2NX9ZPZGQCK034THZM73CXgG6F8SxuH6xXXqJnRjqSjpfPWqQLpMHUZxRWn6d3ICARIwsOD2M2iPtcUUs99zq3nL/3smRu0MVdHMrNsro1oCHqJBm0rVmCG3Jo4CFPO/Q5h+/MPXSi1dhUTaEMKREdSX+HuRviMZvb46j+O3O62ChXfdCIxFyiz1rgWfN1IteZt7V7OJ0Thzp7sUW6FVEUez+tNVTNRZ9WzvZZ9sDMvKSh+7U9Yj/V1Rd8lkYpEqxtQzJu8nx5FnDI17PUAh6YCHoG11KIWdohqsaTKvsD8l+imFNa/A2gL5YpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt4uUcvvEh6VC35PtVcsA8cLprf8djuuGgyiAub6/zg=;
 b=gt89bn+oGkCm/t39TlE94inkuGg+u/aMLPEII66zlXmNMlL1NpEN0SCeQ54GWt6UblKtLHvY+5SMCNLHhNywguNR24Y+GfMP7X/3yJCciZDO/88m8WVAcMK4pXTVEktNSzggwWBo2bM01Y6EBRKbMa9YI47O6LEvgs5WzW0eDc0n7CWl0nAmoCOgSK6MWMunYyghXqqg54acNVmWBUvTHPuXX/9ekpzkMH0HZ7SH7FWCp3+CJpkzgGu9qkYV7Z653IsJFknkdx22W/VzKpjRZJ8/FO/GgQRW8P/oIXH255XVjGW/GHkdtyhyyuXknOKhTAVjHWdZEtTwdvFC0uWEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt4uUcvvEh6VC35PtVcsA8cLprf8djuuGgyiAub6/zg=;
 b=NflATdKWDHPl8Wc77gT9Dr65ltBgFxOFS0k+TxKRSwO8XubNrC61KcWtSPNQsF1Qa/AoxY0QKMKryryyajrqaQNLVcXkoBTqSs9a2ky8kI/33I6jDldIUVIfvIaaRl5N3SQk3sVXazCcwvMgcUX8DfaWtofe+K7W4+if1y9iq/onwk1m2buDX5DT7ZKCxJl1TmzSKA37FanjINoP4uiS50MDAdiA00zgoetH5tKDkE3q+AQ+zcS4+AdQK3bVxMw2M8mAcHvMfg0PXKctFqwVl0Tk41vGfiIEsn+3dPQ+HgHGLUt4HbbypTGB6cpMSj88eh/2RfcSg+hxWOUMCvpsdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by GVXPR04MB12160.eurprd04.prod.outlook.com (2603:10a6:150:316::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 02:13:16 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 02:13:16 +0000
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
Subject: [PATCH net] net: enetc: fix VSI mailbox timeout handling and DMA lifecycle
Date: Fri, 24 Apr 2026 10:15:34 +0800
Message-Id: <20260424021534.2740211-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|GVXPR04MB12160:EE_
X-MS-Office365-Filtering-Correlation-Id: dc735ac3-a0cc-46cc-d04f-08dea1a70b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lNZBe2tFM5vpj0KSwVoKuy7j5Pkc7ZfCZoAnL828bsngmP8zdU1iDVHBbDcTRMmNyFz7Up+XemAI6ok8hYX/h9yyCd5GVUReiQb+UFwwdhf/XhhOaRmGQPGv4d0o1SjuorFkDLcOiXvUloRiv3z9LTqIS8cIJyl9r6IydgP2R4xPx0Ne/zYCMQJedyLZbMHWZgahl/h6TWJeViXGoyTlHT8Ov8ezheKu817G7Kl+J/mFKUnP6ZP1E/BCZK/7MawblESj+VlJjMCauGPA1EA2nGeImVCjn/hpVqHxkakhICcISDymJNuPAEZ5UzvEHCH+B3JeOAzEYwX06Sxt5WF3GD0KrCigmp1OzGQsAoEluuO/dxmjZHjE7ufcHbxe3nVbDRp7zPgyf7GULc6a1N0HK98NTixl92N8gAXqOYmxWTYwwG9WuncB8s4E/ulCAu/6CFBFNV9mGmXLFbVTHZehVGzHDia5pf/fZhRkJ3/q3bfkCYrzQDzUArGIpLLejBtFzbZQydkMI5IwnhyPcOydbI7DvhKL4/HjSHze+T0QWuYhsvhfO5+eOFrzgKTObkA3KT7KNg/rovkkS+RYQkhTWtYOLAxV+3MQc1AiYKVWVeGguZz+nnNnjZRXygaWbyxrT2EtikvtGKq4XtnChwrAtEmRFhRKlSQw0O+mowO4XIyuVNVPaldGnbjFSZy9RS+rXb0uQrdh03Az31YDpv61fCPAseJe8SnP/GCw+BbIRZ6yT+fe79YIwSovwtlp5Q17VHtA1bddDtmmhKIHmY4ffi9CqZy4Zl/HRYrNUlpRcsE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sUcYsRuRE5tETgheOu+0ri0Ej7J6QTIB3GNKoleR83zU6oP07ttviNi67dV+?=
 =?us-ascii?Q?dIo1YKvCsS5wTyzFO0wawvvBXy2EnbPxPKBydPnLSyiqjAKdPvIesQH+vPhW?=
 =?us-ascii?Q?QFsx6NhCX7zCJpdPZazRttaDjM0Bl6wWUGwfr7E9DVrD6BFj0bO4rkIWtaOQ?=
 =?us-ascii?Q?858k4/t0n11s1b+f70fkM5O3w91/k3Yl30/4VWDGmZlZ/OAJda7SMZOabYAP?=
 =?us-ascii?Q?WkR/1KbMlAZYM1JLzq0aK5KyZ2RvUP+17inqvkoNltrOTjZYZwLiZz+cmqdJ?=
 =?us-ascii?Q?0erWNOyG+4NQKvtFa6XquOoq9XLcljDmRvaXXengOeDg7RHP+6E8+MracXQL?=
 =?us-ascii?Q?GnZlZY8SHkVqZDzJgjZtH2//kB/9XDWGyM6OBvc2KPJrbik6Ix/XpWHs9EQx?=
 =?us-ascii?Q?5qwUIEAcXfRyeJtLJ4plXUpNCBd2GvqH4F766CXahwZMiUKG27YTLPnXTvFQ?=
 =?us-ascii?Q?cIXL5lJHe7+lQBUw7cT5fZbo1YypeDSwqP38Oap5MWlfr2HTzZN5QvyPQt1t?=
 =?us-ascii?Q?JlbqYTvi80CxSkny4CcXYEioCetclgfpoaqc3ELsxRupTX7LYujtr4fIYq1M?=
 =?us-ascii?Q?KG+LpHcOiBgjyjimawUgTNBr14srzePptFVmVj7/OGkXXVUjzJpjaG/Ijz83?=
 =?us-ascii?Q?gxt6VDWy/+05HVJ/cAMP0L0E7wa9XyL9h676fzP5XtOrlWOMvEmRUyhJKz2e?=
 =?us-ascii?Q?0kDgQzfK4vaxrXDz+aZixv/wdWDGM8DGz2IAvLov76IAVDuG80ClcRHWftxx?=
 =?us-ascii?Q?mhwd3eWGlDohWt0oq8qe+aPcYz3tlGmej32B79t4YslrZiGVrh7ANIalFtzp?=
 =?us-ascii?Q?pvhBPZvxYBKUlHILy8okn4LJ1R7eBecBglffH88/qUzL70CaF/igonxdbSB5?=
 =?us-ascii?Q?Cs0UGMYMSnq9YeyJh3WNhnWbyWht3yNUsjkGnrnmgdHnDGSe5gk6Kypddtbf?=
 =?us-ascii?Q?xkgBBSqbyqQtp4AOkWmROEjs59lBnYg8cuQmLqAWn1Dt85ygQpnvKQ0ULqZ5?=
 =?us-ascii?Q?1r/d57unhjPLs7riLp0eOfwmyuJzGFX3LHQplXBj74TPt34ZTDUUv9wSRnd+?=
 =?us-ascii?Q?kv7X1t2vbp2Au6V+OJK+XtnLHvUvIXiY5Yn3AfPID2uOmbOJ5OxbPe3y+vTr?=
 =?us-ascii?Q?2SOf+/Jmgp+y7E0nrFoXgzwuTX9sJoigoAifHB91wys7VU997fCq7gwOAT7o?=
 =?us-ascii?Q?HKplH/493hrUBOLQwdlHcINOgrQ/1+cjiMduo9BX8OE/3noVNOJMwucfghxH?=
 =?us-ascii?Q?L8aXlJKNhebAscrDMzd2EX9caSSaVmi2OiY0eIadf3VTTt0rGjGCAdj6X/mU?=
 =?us-ascii?Q?a0wVGva7aoeedn3mkfFxJD2/cTcRchbAS92Pb1okf805FAnALQYnXMrqVoZ6?=
 =?us-ascii?Q?3oQ88eyob1QMrCF//GR1VjOIdDItQhGX1/0oiofTw3SzFY3b/u1M2ST+WZlb?=
 =?us-ascii?Q?Av5q3YS5UVvjKplxXzMZttyBkZouJn9dHr+THqc1rmIJ9epPHnbwRF3OsaDk?=
 =?us-ascii?Q?S5adbsvjjvbN0XOrwg6odNt3pR9a7OCQtUkuZ0ziR2bXqz6B8W3IDoP0Q7Su?=
 =?us-ascii?Q?tX49pXwavlnB7iWdFnknEfIPCtE8MOXSdLrrVENYdItpo80AYOKOipw72Puc?=
 =?us-ascii?Q?EdEEZqKph0gMOoowWHn2j7S2uthmRqgG7XBSImKwpeDFqhPlPOALatB2Egsr?=
 =?us-ascii?Q?0s+dUbvXLlDg1b67QfpTrcaECMgLi8k4Ha7tfQOwZk5gyqOm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc735ac3-a0cc-46cc-d04f-08dea1a70b5c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 02:13:15.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qip390pOzrX29BwUIWTVwn+QCMLa9yka5BEoRHpbrKSdaD7VhOyNiDGLGBs3eJDdkx11AWmMNnYTC0BIdmFm2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12160
X-Rspamd-Queue-Id: E46A9458F70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-280916-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

In the current VSI mailbox implementation, the VSI allocates a DMA buffer
to store the message sent to the PSI. When the PSI receives the message
request from the VSI, the hardware transfers the message from this DMA
buffer to PSI's DMA buffer for processing.

When enetc_msg_vsi_send() times out, two scenarios can occur:

1) Use-after-free: If the hardware hasn't completed DMA transfer when
   the VSI frees the buffer, the hardware may subsequently transfer the
   data from freed memory to PSI's DMA buffer, causing memory corruption.

2) Message race: If PSI hasn't processed the previous message when the
   next message is sent, the VSI may receive the previous message's
   reply, leading to incorrect handling.

To address these issues, implement the following changes:

- Check the mailbox busy status before sending a new message. If the
  mailbox is in busy state, it indicates the previous message is still
  being processed, so return -EBUSY error immediately.

- Add the 'msg' field to struct enetc_si to preserve the DMA buffer
  information. The caller of enetc_msg_vsi_send() no longer frees the
  DMA buffer. Instead, defer freeing until it is safe to do so (when
  mailbox is not busy on next send).

- Add cleanup in enetc_vf_remove() to free the last message buffer.

This ensures the DMA buffer remains valid during hardware transfer and
prevents message reply mismatches.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 41 +++++++++++++++----
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index e663bb5e614e..e691144e8756 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -330,6 +330,7 @@ struct enetc_si {
 	struct workqueue_struct *workqueue;
 	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
+	struct enetc_msg_swbd msg; /* Only valid for VSI */
 };
 
 #define ENETC_SI_ALIGN	32
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 6c4b374bcb0e..7cd05e9bdfe4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -17,11 +17,36 @@ static void enetc_msg_vsi_write_msg(struct enetc_hw *hw,
 	enetc_wr(hw, ENETC_VSIMSGSNDAR0, val);
 }
 
+static void enetc_msg_dma_free(struct device *dev, struct enetc_msg_swbd *msg)
+{
+	if (msg->vaddr) {
+		dma_free_coherent(dev, msg->size, msg->vaddr, msg->dma);
+		msg->vaddr = NULL;
+	}
+}
+
 static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 {
+	struct device *dev = &si->pdev->dev;
 	int timeout = 100;
 	u32 vsimsgsr;
 
+	/* The VSI mailbox may be busy if last message was not yet processed
+	 * by PSI. So need to check the mailbox status before sending.
+	 */
+	vsimsgsr = enetc_rd(&si->hw, ENETC_VSIMSGSR);
+	if (vsimsgsr & ENETC_VSIMSGSR_MB) {
+		/* It is safe to free the DMA buffer here, the caller does
+		 * not access the DMA buffer if enetc_msg_vsi_send() fails.
+		 */
+		enetc_msg_dma_free(dev, msg);
+		dev_err(dev, "VSI mailbox is busy\n");
+		return -EBUSY;
+	}
+
+	/* Free the DMA buffer of the last message */
+	enetc_msg_dma_free(dev, &si->msg);
+	si->msg = *msg;
 	enetc_msg_vsi_write_msg(&si->hw, msg);
 
 	do {
@@ -32,12 +57,15 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 		usleep_range(1000, 2000);
 	} while (--timeout);
 
-	if (!timeout)
+	if (!timeout) {
+		dev_err(dev, "VSI mailbox timeout\n");
+
 		return -ETIMEDOUT;
+	}
 
 	/* check for message delivery error */
 	if (vsimsgsr & ENETC_VSIMSGSR_MS) {
-		dev_err(&si->pdev->dev, "VSI command execute error: %d\n",
+		dev_err(dev, "VSI command execute error: %d\n",
 			ENETC_SIMSGSR_GET_MC(vsimsgsr));
 		return -EIO;
 	}
@@ -50,7 +78,6 @@ static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 {
 	struct enetc_msg_cmd_set_primary_mac *cmd;
 	struct enetc_msg_swbd msg;
-	int err;
 
 	msg.size = ALIGN(sizeof(struct enetc_msg_cmd_set_primary_mac), 64);
 	msg.vaddr = dma_alloc_coherent(priv->dev, msg.size, &msg.dma,
@@ -67,11 +94,7 @@ static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 	memcpy(&cmd->mac, saddr, sizeof(struct sockaddr));
 
 	/* send the command and wait */
-	err = enetc_msg_vsi_send(priv->si, &msg);
-
-	dma_free_coherent(priv->dev, msg.size, msg.vaddr, msg.dma);
-
-	return err;
+	return enetc_msg_vsi_send(priv->si, &msg);
 }
 
 static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
@@ -269,7 +292,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 	enetc_teardown_cbdr(&si->cbd_ring);
 
 	free_netdev(si->ndev);
-
+	enetc_msg_dma_free(&pdev->dev, &si->msg);
 	enetc_pci_remove(pdev);
 }
 
-- 
2.34.1


