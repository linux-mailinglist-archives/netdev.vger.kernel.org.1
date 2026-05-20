Return-Path: <netdev+bounces-289784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA2VGmFYDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:44:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB695884E7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 417F83059D42
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097FF33F5A7;
	Wed, 20 May 2026 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kp/yyrUx"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC234B183;
	Wed, 20 May 2026 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259349; cv=fail; b=AZTDu/2hfTlvzQH2+G02RaTRLdwj75dAKZEmVLlZ3HIyTmFNvskT6prfboEh/BJAQqqaqjMHbWshNnz0CkJn1KYaLkL6BR/deu5ubfT7h+dRs+l03yLsVt/DIPZNm6iM6Fhj+/3rdj1RUCuu6hHaRoQ6GSponxyHtG4rXhoQLjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259349; c=relaxed/simple;
	bh=qmlHC8roxEDs/UQ7wsr983jQ/hNZCVq2X6DXhmE3rWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=erIRQZL5RqBiQjCxcYS6PgrSd2zkzVk8B2f/JgiaO9ed86kd3hYglSiVFRkpYGoUmo2sgkW50kvnFqGyhT7rQ77IqyLfnJ8WGyWqXTtCQyxo8DoXUAyj8+9LOVz16Y1UuckLCBjZaVBU+IDjc6sDBk6gYLKwt8zj1Ws54jo0t7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kp/yyrUx; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtnH47psQiC4DFkatDhzSVyiO9zCfidyXP/wMPszlAc22WPEajc4SjI64DJGx90PGYxbNIEBEmxakzT8MwAxSesZOk7/bhuBPID1VIOgkCY91gHKCpozVaVpAfcZhkq2zc3Ob0li0W6GbTD523/1M0uEc7GK1JDsloCnn+ER8upcgxwWWIN9kRzHGq8k8T9iuXO9Y1cXmibgXshOyzUKeqcz33dmIEndsAKDRvFlB0xiDhxzrbyJDemsGYT3RhgmHN53YqNXcr+Mo8Tdmy2mdIHmpuoXL47xVmV4NXt35x5ETrzOe5XXwWMV12YPE/6UgKmzNcLD3Ipn5+tOeIpRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65kKe1KQgTa+itb741njEkZluz07qfT2qSFJL3kWtss=;
 b=MfPHl2w5U5/747jLKuZLOGQ+wtTZcUBk6TFaNqCfhJQCWNZsQLXaYgvbCpPEeJGDNqi71Ob4lZN/V+RGF8ygCOGmnO+T56L+DyNOX6P+LzV7LHBz0sITS7YEHT3uYeBlfuj2ujkg1KiBqVrOfMUpwCXfBJLbZmrmpsRpEZHKCnR5NJliUjkMEDqiM5GUdcYLar57JwzLaJ8QgyF2+nv7YkEWLP1xePqdidYGgDvRrduXl87fmeuKU4uYlr6CIzSyLVt89FZ7amFercfjXkD2/yfwutq5ubnK7AdalLmJTj9mNoUpbnkmgnrlHqk1+2xNsy6vxWmPno8XpAzNKSCN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65kKe1KQgTa+itb741njEkZluz07qfT2qSFJL3kWtss=;
 b=Kp/yyrUxm5XVhUPkMRUtsNTxzSZi6NXhVMXmtu3fb1ByGDNqlHXsJrg2M0ep4eKqzJ8GNfjuPMMbQE9v4Pa3G8rlm2hbXP9K59G7pJe09PzxhMmMoXxO6miRWN1kgCXHU6fJbBIMERAaDzvASWiJjCaiqsjU9YJzGYtcea/NJbg3/WX5AHmCmuXktwo5ZHr93e0uTZKHri3vYTJKcA9Y98EJQ8CxowWvDmif8he91YJ8G8KrX0GpcU0W004TdyrPi6KtRl0jrlgLNKizY0mOJJVxoRkmCSDpTKso3yKsCWpdfSof/Ldl17eqhPVifgSgbr/zey99tV/JaDHknsGYxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:42:25 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:42:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v3 net 6/9] net: enetc: fix DMA write to freed memory in enetc_msg_free_mbx()
Date: Wed, 20 May 2026 14:44:18 +0800
Message-Id: <20260520064421.91569-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520064421.91569-1-wei.fang@nxp.com>
References: <20260520064421.91569-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: e606c6b6-db99-4711-7c72-08deb63af393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|22082099003|18002099003|56012099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	UyGQyZhZ5uzzIYRK2AQS1GfPkCqQvIEQZ6kxXo7bYFB+pexUPvrgpz54Lqvw/naUrbaxKMvq2VHCXicMmwv9kqxt4O3fDBlwscnUp4tc3LKvHy2A+p4BSZ5qgYjptSVLCSSW1UvmCzFpoOy4O4xu4FdqPiVkXyxVQ682zZ1CVaew2afwzLvU4E9RncHBBoQsDitESRbCp5PPRqWgJfaaeq7CJrHN/VuMEE4tuchXUxBbZpatEfDVfL0wiThMyisXNXRcyXGoRoO4SShBOryB2srePN/XZix5HbpTDub3vTgOgpFHHMlg/JlLDe/RDfLYyUKWiSBjYekcTwbuQy/3nDnLRoCm8HYpQjXbkmA/uAtPrqDH74Rl8A7Lnl9LgL8lOnsDKPYh51B7HyQFMCTRNG9FufVEzdyTKQtS2EUGmOjIL9d26nXp2qnklM9Co5N4MVvh8unfii01K0m4M/wWLbuTL2/8uMKCMH5ajHiEwDNRU9MO1Rxa7QDk9SWjAvdZQtCtchMOSkGSfLLDOPbQpfj3+KKqfR/2dI/MT8jrNsmE7ousmYepm12C/FF3RRln3wvszMAhgWsjWPfWzF4IYaJhPfUoJCI+V+djZuLxmme9JfykO9R6dQMg2M4rmTruiiUmHsIQshBLRJ2sq48ww1cLTsdgvmOgcrsnXy1Q9glYHSze8BQhZt6iZrKL8N2yt+YXsf7NMD1NEA3ninCNmGIKaRrgtv8YA2qMPnNZ9remLW4B+ZS9IT6ryhg7MH/a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IBl24retOUmPukeiVf9YviVqrbSdrsiHB01PAUhJbdirOI/37OBs00l7CwuW?=
 =?us-ascii?Q?RNp9REzHm64mKIi0PNIIQnQcvUjVmOu8aTT2osUo/+8IOSvA/duymOnOUnSN?=
 =?us-ascii?Q?WJY0x1JFdmrwRBw/P+1yOIBS+kmW8zLpSIQ872q3iva+rBu22QrKlPRFUb5X?=
 =?us-ascii?Q?cw8ZB53SbBzshuguMWfE+KLncHNZZoOns7FC1bypBP78Z1JcVwIKxO7aIDfD?=
 =?us-ascii?Q?Jc89JIavCXUiRTfLZE5fG7zikEibjYszcqPzu7F9p7J3IerXnf3N+j+1Fkcm?=
 =?us-ascii?Q?dwttU7x+SyXsss/9QEzD/AGh+ijFfDVVWz9mN4MVBwOw1QVIZAfbbp4pmbvH?=
 =?us-ascii?Q?x6iiD1roS/BYpTByN01iKIU3XM+/rJrLTtsmHP75/QsYwUKXcNPqLeEzLHrh?=
 =?us-ascii?Q?gd8gyJxxqa+Oyf94qwQm7LkC3YN01In0Z0cXlTBztPi1gzQ0Ob1lUAGaqJaY?=
 =?us-ascii?Q?JMrkpY4ItWPxwHVTxBm0O7GNDTYKOuKROIIxUYrv4/E7ij/2E5bKorXCOXXT?=
 =?us-ascii?Q?bDG5wZIMzivoDr4wJgMNcQOoHmfl2OMQxthOejQKqo3TWn8/WDcC0DWiPNgx?=
 =?us-ascii?Q?6CG0xJVXHM79J+jlOXTqkTyqD6fXIWQomiAdSTn1xmC/WVbQOafI2OeMcyZ/?=
 =?us-ascii?Q?8s01iC2O3R++5QEZiR96sgk28AXNF1CZ7zLzVHwn1PdenC0l7VTidFVc+Lc+?=
 =?us-ascii?Q?h9fi1HqgePViecp379Zj9GOrBJ1BRTXPGrwGC4AOMdQcNeiFHnex1U0CUBx5?=
 =?us-ascii?Q?6mSeCt0672T6yJptyoAElKAbNfCrVJdK/6ySUQm1WFm0ERUd0htov6x2mojU?=
 =?us-ascii?Q?DVheOwgLecltl9akxjaWqrYR4KTDVTbAIuIoooae1VvU2Ro2WB3k0qDHc8j4?=
 =?us-ascii?Q?/ITf+Slt6jjSHwMgTYOdRx5qVqpaBxT+ZRM3rhr92GvPw42eDEIFHa/9405z?=
 =?us-ascii?Q?+koA/IJfrbMOBZiO8oAoXWErckpwkq4gYbG0iPsRO5KDTRv+pKaQrRca4Aiz?=
 =?us-ascii?Q?bTc0Do9nhC9YleY/UQVqGfVBEnNHC42RpbC0gGM3F1qxfAMzibSjulIJQk6W?=
 =?us-ascii?Q?6rYoIWnyRCJzl6q4R+U6FdU3FEGKEUOoZbVttqophYN2jfaW/T0cL5P2V5XZ?=
 =?us-ascii?Q?yMqLoGHBM1FH191fBqzlVW60NHLpzvOYSiB51kDpcofI75knTAPpAINXxntB?=
 =?us-ascii?Q?vrGjXgS0EL9YBwEGTPhgNwJIug2GeONOzFTWNvyq7eU3mpaRHl+gEtlL8ZeK?=
 =?us-ascii?Q?qqrvUmfEdvj5GQgt6QfXJ44wNAyNSFOJ/m+WirKWBkggC+Rthzx7NmUUjfHr?=
 =?us-ascii?Q?QXPB3ljuQLRiV8ECYellr0qGTAgXp7W6fkpMM6GTlAwChKDDr/NWZcvb/u5H?=
 =?us-ascii?Q?JKbyou9iB1GEeTCi9gDZLorD765fqoS8yHhwJ1mLGrEkL1XCdXuLWDtZfyr1?=
 =?us-ascii?Q?CvubN5NrlnspoYp80ApYpQoBUMXoMK1OL1BMW5p2CFuHBANs0R7C2FVhD5N8?=
 =?us-ascii?Q?tQPlBbIGXS02TrGebRN5yMbSPxfMIbs351vYCClVD8YFcXql9QLZqcHiQbEe?=
 =?us-ascii?Q?URZzQwDN2xxn7h7XxwTdPq7l4uNSXIuEK84L1EZ0erhplwCslS28K0qbSdDv?=
 =?us-ascii?Q?/plPmZNHsXvvff7vtYx7uNN8PK6M8VOXWMxS1wg+Mp3NwX7+xwACEkQ1B2yi?=
 =?us-ascii?Q?ACdfxGAgNtN97rm6LKNmoZiKGeiK7anStgb7WqKA7h3EC7Gg639m5sNjPJqY?=
 =?us-ascii?Q?PcOXA22sRA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e606c6b6-db99-4711-7c72-08deb63af393
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:42:24.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3jwKsQEtvvGwjZziui5THNrDoM8En8ptYwTwKG/cFdGBGjlYwC2thzKnUO37cEtdFTnfE9QoHYewv/cbft+5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289784-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0CB695884E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The teardown sequence in enetc_msg_psi_free() frees the DMA buffer before
clearing the device's DMA address registers. If a VF sends a message or a
pending DMA transfer completes within this window, the hardware will
perform a DMA write into the kernel memory that has already been returned
to the allocator.

The result is silent memory corruption that can affect arbitrary kernel
data structures. Therefore, clear the DMA address registers before the
DMA buffer is freed.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_msg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 40d22ebe9224..b4d7457097e6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -96,12 +96,12 @@ static void enetc_msg_free_mbx(struct enetc_si *si, int idx)
 	struct enetc_hw *hw = &si->hw;
 	struct enetc_msg_swbd *msg;
 
+	enetc_wr(hw, ENETC_PSIVMSGRCVAR0(idx), 0);
+	enetc_wr(hw, ENETC_PSIVMSGRCVAR1(idx), 0);
+
 	msg = &pf->rxmsg[idx];
 	dma_free_coherent(&si->pdev->dev, msg->size, msg->vaddr, msg->dma);
 	memset(msg, 0, sizeof(*msg));
-
-	enetc_wr(hw, ENETC_PSIVMSGRCVAR0(idx), 0);
-	enetc_wr(hw, ENETC_PSIVMSGRCVAR1(idx), 0);
 }
 
 int enetc_msg_psi_init(struct enetc_pf *pf)
-- 
2.34.1


