Return-Path: <netdev+bounces-286517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEbIBOyVAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:40:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E13050A394
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C41683043FE3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567C3B6BFF;
	Mon, 11 May 2026 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vi4rKQVB"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E837C106;
	Mon, 11 May 2026 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488504; cv=fail; b=qIvURcm5SoN5heGMTAf1T9Zy96tBDbEs8C+eEqUt36kofND6QW0xAHhiHMqYOajyjd5ENAnW4yfajlHbJFTSzM7Fd1clpLQ0D6YMklYhp1trwd+BdLnAnnt6xIGKQ+d0rQOVi0I+QVJNFbcRkiz2M7t2CqGRnMotxTF7Pu70Tzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488504; c=relaxed/simple;
	bh=Ntk4cJ32N5GIypxy2CyD5aVsRQAZaQqJtvSDtBDjPQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f40yVm7HNRzU5qPZoinAMtqZjAGTIOhKHlMl79McQeCw+/Hz0M9yH4p/uhbzXU0xnKrcgBc+brX8iZuJfsi6qKPPPi92Ll7wKUXjP+tFEx4ZW++WGvIzvBrW3CxEfAuARCkmxIYlhie1e0H0miykHmQOh26pfKb9chmBtnJVGJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vi4rKQVB; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvEGfyk7IylER3S5GmT/RPB1PNM287R6rBSNakGesUjGQePQtqzcETcL66BvpKvo121O/IhNyrBBbXvw4wKZx8Me3DWGjPBbkwmpx63V6CiBUn8oThHEN16HJ9mIjiw9T4TjSD2uYpIt3HPS9ZobGjyf8zRbOll7yfPO+kiMWBjuDK2f3bbcfXKaY2giILMaRTge2FyHDubn/nOom+IZpaOS/iSKp63+PHv6TKVJ8sjnLlL15mxQigHVYxoMGUJnrLrrn5CCxt4RRpVQTduDLNU1HHi8vkTZptjS71hhLOL+h6qrpKbBBrpxlW2Kdi4U4xBpm71dq7g8bLigR4yHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqaO4tMywFHxtueMQoHMOTji3s/FwnhipsAYUyr9Vvk=;
 b=v2AVjcONsx2cU0dkDbTd8f/fV4kGaCbxohp2jAXoEeyiCbcjOttrG1QdwPN+1N6CHWxcyzETnJvU7GP070ZYGtzfF6RdH+AlzPqntvnNvwQ/heB4Movuvuz5Gwo2mjTISsADCOUm8CwvadiSA86WbDA2mt8VtXP/fnBZFb3orzvRR8SMXDnkv6H4L/FgY4u3vfm5YtjHv/5AsY37GTdvVRHqOy4NRDo3yiUl3LRQym3/EIgIq43pYm2ZYm9urWQHwNf5P3LxQOfg99uVWyFHt+eIDE/MbTLM6G9CXQ4USZEZOKdlbrD0p7pRXarZDNqyit7TbuVSl9Yv++bvdvvnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqaO4tMywFHxtueMQoHMOTji3s/FwnhipsAYUyr9Vvk=;
 b=Vi4rKQVBKKlqm/FdaJB74Ah4xSUIwiR6Ke3SuSo7J/KgKcdc8T8mqmUR8vYMacPpYHybyNH3+eDp9k41YvwR1II4mXQCQEt49HWyaMvMyNHNfcKyb+bEOPmS9/LoIw5YK75XC0xdRclk1jGdMV49Y8HXjduXA1FURogM/X8HZdtqrhD1sKhePZBO2+Tyq6qykCopOL3hENQVZIkT6FrYvEBCkZHZjFoA38v1u0OMMERdQ0SwVb8Hd+YK0LTTL4oDpnT1tyBBkzB4dqu0PtOnE8n5rmXiYEZcKEYpFhtQi2KgMhWuG+aCXETuMA5a4SyDaf+pFL3zFkYGw1d6g10rug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:34:45 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:34:45 +0000
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
Subject: [PATCH net-next 02/15] net: enetc: move VF message handlers to enetc_msg.c
Date: Mon, 11 May 2026 16:07:52 +0800
Message-Id: <20260511080805.2052495-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8d10981e-1627-496e-28bc-08deaf3827b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BQs9zE5AAfThuDhi6nu55R57h5p6L3OSyuCrn4xu76rEpzW7E31hTfn+Z9OiaR1qQDe7Ys8SorsWBS5OCdgJLHWeXD7ekfUziqosW4Hi8b5FQZ089g0GYOpekIRe7MwTQji3CYn9UcVCjr0lcTjtQ0wWlub7NOVXpvRQmFn3ZLiT0i589BE4q9Oqu5w4EBt5LuiE/kLN8GFwvXpjQtXQHYKjsTmymB0POlflWfhN3XterDyhlqstU7TaFYkwgw0pDPa2AprCzpfOl471JgUTpQA9NCRi73o2i0fVjPAWUCxslUQCNDRxldYK0pnE9Zy3U6E6QcGvxItBxzhA+gqmzoeBmRsjo44ZyUV01fnh6wz+aa3x5PKztAJzBeGkgWB76op2qgi1ERYpMacsD7tkf0CWRsWGs/Flzui3Rhe6cU2c2X8y3TrEzw4o2QgrEZ472DspJ4j6UOyoj8XRj08sMWNTccdJp12kAI2RcGgnVV59p+DeNAp6q1yOjPzHNjaMH0/8fmfbIB4ybBmuH6VQJLiOGccVVTQR4m/SsOHPBCh2m9myYoWtEqjNNNWlev0GnQc0t9cTrdPCfW79bCW5ArpAp3kqhphn6fBPamYJFY+LN0iNsxC76E8S7C8oQ2XSBdOlvanyOGL0v05dRl4PDzqZb64FIKIbcbGVhPCOnC85Hh17CQc4l01OTMvFigC7Oz7g4PFecuhkjZjXCgWuSGmod+IaZVxITU/M0R3S2+8UFDhYbGFB5tPhM8NBwnBV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Lv7+Tfrv7vjEICE/xko3700MrLgutTUl9qrxuj1Mn8q6885KC+oSKFMhFO8?=
 =?us-ascii?Q?9HOh7E+sYPrd3rnAfarIdMFHEHiGxbXh2b1XmqJ9TIUvLB9eHwo8FrUaRGFS?=
 =?us-ascii?Q?3Ho2VSLNeVp4glqQwTv0PqlTOQiL3BUVfa98VzuAu+68isxnsdAWAWhozgPm?=
 =?us-ascii?Q?JtKCIv7khotjQNvO1VkG3e21Qq1ixheV+eY8HuL4JDn1fJk98UZu4fUmEgET?=
 =?us-ascii?Q?w1vxiTjIsBN0GU4SH0jlPKhqSo7e5aYBtxayk6lRL+hyOcdkbGdyixpdbOfI?=
 =?us-ascii?Q?amJ6x7V3smgsn8uCChtyFs8rB4fo/VsL+r1PKit0+redJUHYzcnR6jngkeLn?=
 =?us-ascii?Q?tDY4OvD+MXICYigzctroC/yqV8P+KSW6FiJ16BIu5BwEd6Id57XKtDjoL8Er?=
 =?us-ascii?Q?qx6sHjpIgIffPiQ8eJncDXW6qTDyWR0dT9dpLiNnUH70qIl2cPohQn5t03//?=
 =?us-ascii?Q?uUPmGK2JM9fD4edqgVEpMAWeCyd5vHJpMltGeuwIfjKM52gzNWxE+te4dbaU?=
 =?us-ascii?Q?TmfrJgyacDRiG/I8V/H6s8Gn/5tdsn8rlQZTDffUCR4hSTRwkdytAGsELvek?=
 =?us-ascii?Q?zQXXzVcqoYkuh8zjlwkflbRs/jeGaLvgEycMnwSDT4WY1QAACvjQbXeUE+B9?=
 =?us-ascii?Q?30o+mexNZHIsan//i4PriI8LolfoimZkk5jZfIQZwgV8ITJgt5zzfM4alxKu?=
 =?us-ascii?Q?XF1+8+VfRQY+85i4BN+JcZoSBGP19u5yMWCo3+xzAWsQkl8WljYBlMcTmyth?=
 =?us-ascii?Q?il1mVeMjOAIsLcZty9hAkkL+su4E2AEleByoiPIC8N9TS/roCVM1vKz86/0S?=
 =?us-ascii?Q?U6G6mp5uTE21SM6QrtyeL9/1wV4Oosbhbaw9N2lpIRgrtS+U5So1sHQtpBL9?=
 =?us-ascii?Q?PXVuAKLKGB62HwbG83wXbKXQxsStnY642TSZwweIIiryQHQMFTEYFz/pEfKO?=
 =?us-ascii?Q?u7YWE08jqh3sEcJW8w5YECmdnYUUjebLubGRn2BaOGul27VWB4hEwwJGypZw?=
 =?us-ascii?Q?fat7qHriNZ37vpPZyzR0CcLVRfOjCavVh0b21ubmL1qH5Ft2MsaYfHV8UDIl?=
 =?us-ascii?Q?gCTzTC0g7JCblBq19TBJWUQjl7v39jCHs9oO7OGlFbQpWoYu4aLOA4GQW/u6?=
 =?us-ascii?Q?BMdlEAqRDwM9+7XCiWVt6Ygod4xlJdYVVJAb8IX7gK3gtu0Xpnv+ymgJBdrV?=
 =?us-ascii?Q?trWdqKs9ERzr2Q0ZCxKm63PMmQwi7ZDPuboeyAwtzcB7UQhRXVpLhsRaAEYx?=
 =?us-ascii?Q?URoIpSGfcm7a2fWHpXZ+18y+Rk9vhVpSLgExXbP+CIL08bUGo4khCmgJqVm2?=
 =?us-ascii?Q?NzRuGsKVltQQxNiPRUf/lC90t9jw/66fw9OekkQYrGz1WgCUowOTQB0a2ttq?=
 =?us-ascii?Q?9COY9tMm0upG2HzxdoEdtxJI/J/Xv4AJYvskNY1nBrPdhcIdH30DM/kpDiL5?=
 =?us-ascii?Q?F+eGo/luxC+e18hF06RnDnBhB9vhVIeTqtuydU51cHqYQvwPFX0xpslEqbqn?=
 =?us-ascii?Q?Cjx58Mezj3f+XsI76023Q5/iCurS1wBWk+eoq+ofZGoNH7JN1Hkyc1DAsKDi?=
 =?us-ascii?Q?9bfm8fqaW0Y2L7uPXtq60h149mS9oGGlH6/E0CdhsgKHf/8rBs0RjBuqzCGL?=
 =?us-ascii?Q?eLwv7w+T9vOyWqL0tT4prM3Z0+WvnkuX2jOoBitmYutpUtEhU/AE33XofeXR?=
 =?us-ascii?Q?kijeUb/E0XfCI4qLuqyd+cFDbt8lBkPRI27Mc56L6ZU4MGHnlqEFKsZ5hjXD?=
 =?us-ascii?Q?vckPnPo83g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d10981e-1627-496e-28bc-08deaf3827b6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:34:45.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujFOlR2cM4OGfnYDoJGnYDP4Hhg/r6+DhQxocTBKPejMMZhdKqAlQHg2Rm4N9RFJDYqF27RWjDCDXxUBWZvRFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: 8E13050A394
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
	TAGGED_FROM(0.00)[bounces-286517-lists,netdev=lfdr.de];
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

Move enetc_msg_pf_set_vf_primary_mac_addr() and enetc_msg_handle_rxmsg()
to enetc_msg.c to consolidate VF mailbox message handling logic.

Make enetc_msg_handle_rxmsg() static since it's only called from
enetc_msg_task() within the same file.

This prepares for integrating enetc_msg.c into the enetc-pf-common
driver to be shared between ENETC v1 and v4 PF drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 47 +++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 47 -------------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 40d22ebe9224..81d1b87055a3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -28,6 +28,53 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Messaging */
+static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
+						int vf_id)
+{
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
+	struct enetc_msg_cmd_set_primary_mac *cmd;
+	struct device *dev = &pf->si->pdev->dev;
+	u16 cmd_id;
+	char *addr;
+
+	cmd = (struct enetc_msg_cmd_set_primary_mac *)msg->vaddr;
+	cmd_id = cmd->header.id;
+	if (cmd_id != ENETC_MSG_CMD_MNG_ADD)
+		return ENETC_MSG_CMD_STATUS_FAIL;
+
+	addr = cmd->mac.sa_data;
+	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC)
+		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
+			 vf_id);
+	else
+		pf->ops->set_si_primary_mac(&pf->si->hw, vf_id + 1, addr);
+
+	return ENETC_MSG_CMD_STATUS_OK;
+}
+
+static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
+{
+	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_msg_cmd_header *cmd_hdr;
+	u16 cmd_type;
+
+	*status = ENETC_MSG_CMD_STATUS_OK;
+	cmd_hdr = (struct enetc_msg_cmd_header *)msg->vaddr;
+	cmd_type = cmd_hdr->type;
+
+	switch (cmd_type) {
+	case ENETC_MSG_CMD_MNG_MAC:
+		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id);
+		break;
+	default:
+		dev_err(dev, "command not supported (cmd_type: 0x%x)\n",
+			cmd_type);
+	}
+}
+
 static void enetc_msg_task(struct work_struct *work)
 {
 	struct enetc_pf *pf = container_of(work, struct enetc_pf, msg_task);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 9063255d8ca5..b1620dc00146 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -476,53 +476,6 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	enetc_port_wr(hw, ENETC_PMR, ENETC_PMR_EN);
 }
 
-/* Messaging */
-static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
-						int vf_id)
-{
-	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
-	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
-	struct enetc_msg_cmd_set_primary_mac *cmd;
-	struct device *dev = &pf->si->pdev->dev;
-	u16 cmd_id;
-	char *addr;
-
-	cmd = (struct enetc_msg_cmd_set_primary_mac *)msg->vaddr;
-	cmd_id = cmd->header.id;
-	if (cmd_id != ENETC_MSG_CMD_MNG_ADD)
-		return ENETC_MSG_CMD_STATUS_FAIL;
-
-	addr = cmd->mac.sa_data;
-	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC)
-		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
-			 vf_id);
-	else
-		pf->ops->set_si_primary_mac(&pf->si->hw, vf_id + 1, addr);
-
-	return ENETC_MSG_CMD_STATUS_OK;
-}
-
-void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
-{
-	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_msg_cmd_header *cmd_hdr;
-	u16 cmd_type;
-
-	*status = ENETC_MSG_CMD_STATUS_OK;
-	cmd_hdr = (struct enetc_msg_cmd_header *)msg->vaddr;
-	cmd_type = cmd_hdr->type;
-
-	switch (cmd_type) {
-	case ENETC_MSG_CMD_MNG_MAC:
-		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id);
-		break;
-	default:
-		dev_err(dev, "command not supported (cmd_type: 0x%x)\n",
-			cmd_type);
-	}
-}
-
 #ifdef CONFIG_PCI_IOV
 static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index ae407e9e9ee7..84f8b58a18f2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -70,4 +70,3 @@ struct enetc_pf {
 
 int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
-void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
-- 
2.34.1


