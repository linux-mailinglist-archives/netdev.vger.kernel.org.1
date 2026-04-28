Return-Path: <netdev+bounces-281668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGt7EbZT8Gk7RwEAu9opvQ
	(envelope-from <netdev+bounces-281668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:29:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4663B47E0F0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E82B0300EA9D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0DD346A01;
	Tue, 28 Apr 2026 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M3dtVq5/"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647E2D0610;
	Tue, 28 Apr 2026 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777357744; cv=fail; b=Ru4i/FlBzc2zQa5yjvW70t61ZlcoZ+78tAX23qrY7xOCf3JfbW6Wu+JsvF+i+jyJQrKuUJKcUwD1rdPtwiwtQIeWtQ1bEtcJoRdoTuO8hmc1hAwQmKal7Upcno0KaxZ93ECxu3SjXDGZPI1USL7OyBVHbFR40UDmIKeMnaqHO/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777357744; c=relaxed/simple;
	bh=1AvGWmdgM/9U/ZafRqE+3k5/PO2ZLhnndYoe+k+KBqE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=go3VYZTfxuwySNk0OuHfbJTnMRC5dXs2BKpu19hB8+oQDYY7UbNRpSCcEw0AtslyDTbupnEAhqfjNHMuePyu+kNBCq2+zACXj62yn2lrm9Nh7XEYThCKedCYHc9FKBObtc38Ti+FUXIWwOrj5zgn2lXg5mauwYb/ivvoJKX2rNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M3dtVq5/; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpueGLSYJs6/YCF9O6SZ5Omz877pWIsn2lsrMhXN5JzArOzOu03w3cWexsjt4mCzd7WX+JV6KRfe/sXO28sLwlZJ3XCfjK6bzvc3ZTtzPFIe64NqZfqG3dqKKS/OTVl3Zv8bnAMxOJUUpF3H0sFSd+o6S+bZgXq6cz8TfRx0yOgFOjWOEK6ei5xjO3HNa+Rov6zY8undq2jqLzEXqWg7lvqCnhLbVsqfW9d5jB39tl0TObDzxIlslN7iOaShBbLcuv6rXx81znHWlRIqq0jy1/9rcZpo6BVs7tRtiXyYSF+mCGG1K4+yYGNLTg2Dleu7IKadmeqYf74Le4H/DICNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmYMWQqsh9Q9Yi9KDVrpLjBOLi987WdyIyXtw3trUco=;
 b=m5dDDLBYCwi1PJ6T54aAR1xhLGaOznaz0eOdkXigp1R3b33XOWyJVim1i+maET5i7lEPQ/ndx4nem03BQf3420n40Xt7pn6MxBoox3lrHv8y2ylQpD7Qx44fXt0hXKWZzpIlKJ5nMeS7R14s/8xqjVa/8MHz73iNK3oU+2Klw7AgsGb78rvOXdRur+OUsVqyrXh1ClcNMD/N+NKOizVUlu9NanV4SGQEqWoBkM8MCe9s5Zc3+57VE2dD0fumaDZAofOyRLvot0S9Y1dFMcM7GFEMHbEwsVqfysCXs0SiZjtte1Bfi176j837n8hoFlucN6L1WWxZg4NqxuuAZGai9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmYMWQqsh9Q9Yi9KDVrpLjBOLi987WdyIyXtw3trUco=;
 b=M3dtVq5/341/dCOgZFfBAuKI+eZNWJoMQ+d7x6P4xtQPuwC9zoTG3NRtpwngWLqUS+UjBf0bd0iMVLHM7FEsH3QmjU+xX6/5OLG/E58eF+fHX+ws8ufKTU/QFAcqMReup+NCaizexaCzBEK0QzTUe6NQGhjEPfg/7zUIOPQf0cogi4eW4LQPjtTHwVdRG8eE7QdWEQWYLtO343kbBJyBhV2aBmjhyGCjPjD4Q/DvULR7//G6hEAYuIbmleSuXSBvFedUk1XlzaqIq/UKdH8T0xwfDCQ5q56TqvTViLlXlMZU05Jz6RCxpVAH5rv7l8dB/Jk3V1j7BVf49AX2LRQ5PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DUZPR04MB9747.eurprd04.prod.outlook.com (2603:10a6:10:4b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:28:58 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:28:58 +0000
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
Subject: [PATCH v2 net] net: enetc: fix VSI mailbox timeout handling and DMA lifecycle
Date: Tue, 28 Apr 2026 14:31:11 +0800
Message-Id: <20260428063111.2869408-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0058.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::17) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DUZPR04MB9747:EE_
X-MS-Office365-Filtering-Correlation-Id: b958ed40-f98b-4d3b-3155-08dea4ef6dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xK4gxP3w1sRRcCwb/hsXfWzTljld1syLaE4yIdEFFxvr9BTnLASW7Y+jQJj72grqdgJHiy6RT0dT4ELKdrV+NdJuz8C4Apxq+td3zrraEVqkt7ZpIXmsTb5pJdr4k8H4tCxAkMnAhdNuyPaxZiF11bhKq6vUb7PU0BBkOXmypwdCJKswMyZ0Aw9z6sspXYr9FovVrqSjAsCvrZtWUlF/4aIkk2RQieso3kxjUyf+OO8U2N74vbJyii+qKYiLFjYnmgWYtGsOGI0vBcbY+H5iHP876qvXt4qSgZXOloAM/qTIeGc4JQj4aGfMcBrktF+tfY7A2g0EkJAc9/fDqZtv5dsHdNoHxmDwripDUeWyYHVmIomLF6D6mZkbLlAsZGOZevtIYDFT+f6FkAGB1S0GdNZ7pdWGi37up1xoG/SxeGWeu3od6JJaHsA8DEOrQpEdIMxVZYTYUC05jCZZwVEwO9z4C7Vpsoaheqx6wE0jietA9IYmr1F2AJh0W8tlGgAAkXV58M0LrealUSB/HvAP9T0cjJNtOZycT11ckdKaFewpSgBEE5dixF4MtxWyLsZAIymlck8Xb9xa4yht0YrCHjJpZiTdA099mQr9gRZV8kKHr2nJLCjXjE9MMkGiQVC2w7fNtiCQlcUmvKSvV/Y2vG8KVkXbUkJVxdzW8FYWEGaeD7t9fFYaAH4M5IdC7V51wiiL10aN9S4h8zovzl5mfjJObYgE98g8G9l5NRFKo0CycRdCyfkFOyOIkT7O53txXxtgpeT9qjIKi+bOAhfybpKzR0yNmFc9VR/qYliaMDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Z2P6ouiphgil+MNe1UZWAOwXtxRgHvAlwPgOtezQiMF29Xznx6LRCtw61vd?=
 =?us-ascii?Q?RCTiVo3JpdTa/OjgItSho+91PlgqHxlu7aIbZrc+kX46QHLTuCBbif7ACA6y?=
 =?us-ascii?Q?Vig5/0M30ZYe5vk6GP3irzz+YXyW7SIfIXCMaKJgFwbtcXOThWSEDBtXg3be?=
 =?us-ascii?Q?UfIcZ72ysS8eAzcDi6/pu55xvVozDBySGoRZDQ7OVUJ4jiHonjybRETGR5/b?=
 =?us-ascii?Q?E5wGKRjXIB23PS4vpscitvy4AI3iNyRe4QEHxMSLAU65x4Qev7miXe9l3dnJ?=
 =?us-ascii?Q?geahcfZZJlamr5GeGodRZ/mSBfEIhcosauqPySnYPjrSwsU1GBDuk1FZpOEX?=
 =?us-ascii?Q?8OKPGuoSJSxnUiI6Bkj3oUUHp49RKvFDCIVjjOpF+QcaqZ+EIgtelIx/SUdr?=
 =?us-ascii?Q?ikVNHI9mk5eC2lSjT0Bsfr7jM9cxuJYmWBSfmymSdUzVB2E7jNob8OChfWaY?=
 =?us-ascii?Q?JHlFD4QX6px5rikcYaA81Ctqm4Jx51ZKzB7FMoxx+U/Oibd4nbpH1VsV3JDe?=
 =?us-ascii?Q?YAfklEuNbRQEbUX0JmaooRJIkd/efI3CCfaPIr1kavEBNdK0hvDl2S4iTnJF?=
 =?us-ascii?Q?GeSsdcl9m2rxm+Qijj6OUsgwbzhjR0Vrh/NCXdqAoXaZVnOMA7jAluORPf/4?=
 =?us-ascii?Q?iVXolOXQgutY3/ZWmgeSldeTk6tZFRmYQjg6XmVWsFeGJORMsKKm38mnQp53?=
 =?us-ascii?Q?nWTrUWUJ4B+DccHIp/uXwF8M2DBiKJ5N7JGRFfoVLO/tYM/bBJvRwEEmxCHB?=
 =?us-ascii?Q?91sT4kyd8d215Ls/3E+AbtCzvv+XbW/nh42gHggdWwWqfXEyU5Tfaux7i207?=
 =?us-ascii?Q?xeDO5ZfhKd+ZSq+1WhTHp1jdz4IeWhoXqUUZtMFGSBS7ms0FO/Kv9RAh4Hhc?=
 =?us-ascii?Q?boZma4E7TflQpQ/an4P7LRazwAHSFcJigxWn/tuWFnlcOblFv+CvIXuMIN1+?=
 =?us-ascii?Q?N9K3Suxm8egiVKigtcioL8PqVucS+15UnPphdt6ihNdKEnlVTpAPmDRdWR1k?=
 =?us-ascii?Q?5gdzo093XMZ4E44ezM6iepaB9qyQLf/yXOBGJpTZf3vv7Wcz+kHQ2zwjP0MQ?=
 =?us-ascii?Q?ufPdiioiugLfbNe/oLbRddW5UNOP7KLpn+MmJFfRIjRzJIn5zow3YPSivYxO?=
 =?us-ascii?Q?Aycnt9KaFJecUUODEylogHMHO+0O6Xo1oqRGt7Hrs+kZW2SIXtgQGPm83Aaq?=
 =?us-ascii?Q?uRe363HnK2QArphnpw+VirKLoH62L2YQhw3Utc1vLvYyNh+wWV94oOfBHpkJ?=
 =?us-ascii?Q?WbuFWHTGhvJACH/AY0z8jUqJBTNxazhbFphmos6TJgnVuygV8yrteWniBVSt?=
 =?us-ascii?Q?KWJbhOE/RT9ptGSsShTgQbZude4moLPm4MHE2vtHJUF3bHwT0nQXn4Ds+seR?=
 =?us-ascii?Q?fT6TD/Ee9Hr6P/egcZ3zA4PUWNF4aZrWIAhsWDU7048sud/c29R3i+jnQU6L?=
 =?us-ascii?Q?2MNmxhTdo3RXYhJDj9HgJi9qRj4ndzp2jyjaWSH2sV+3mpHEkml/wpDN2VBP?=
 =?us-ascii?Q?7VWreTTX5L90vGzG93gZTXir05v09vYIA9CzXTMaWJxEMCrNKHvhy7+WClky?=
 =?us-ascii?Q?64yxyel/L4z7KWTj0dg/lO1biFTMFNEBMLdo1RBQYivzEMtpFEzfBJ7QXJRt?=
 =?us-ascii?Q?9IMxC4vlcW7uFgXcyzzR2wU5FzhzfOqJpK/gkHSdj/xwKaghozGk5j2IHa2s?=
 =?us-ascii?Q?N3tMavUHNoe6hl0p5MFHsLfn21gYoQJz0taYjeo/rybznkE3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b958ed40-f98b-4d3b-3155-08dea4ef6dfa
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:28:58.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thKY0pwgQ/vTDwKjND7xvrVHhNu5LuM1RIvZKtYa08JxbAFbBFsviHmzBMbWZBeP+vVXBQTG/n5eW+QNDfb99A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9747
X-Rspamd-Queue-Id: 4663B47E0F0
X-Rspamd-Action: no action
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
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-281668-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

In the current VSI mailbox implementation, the VSI allocates a DMA buffer
to store the message sent to the PSI. When the PSI receives the message
request from the VSI, the hardware copies the message data from this DMA
buffer to PSI's DMA buffer for processing.

When enetc_msg_vsi_send() times out, two scenarios can occur:

1) Use-after-free: If the hardware hasn't completed message copying when
   the VSI frees the buffer, the hardware may subsequently copy the data
   from freed memory to PSI's DMA buffer.

2) Message race: If PSI hasn't processed the previous message when the
   next message is sent, the VSI may receive the previous message's
   reply, leading to incorrect handling.

To address these issues, implement the following changes:

- Check the mailbox busy status before sending a new message. If the
  mailbox is in busy state, it indicates the previous message is still
  being processed, so return an error immediately.

- Add the 'msg' field to struct enetc_si to preserve the DMA buffer
  information. The caller of enetc_msg_vsi_send() no longer frees the
  DMA buffer. Instead, defer freeing until it is safe to do so (when
  mailbox is not busy on next send).

- Add cleanup in enetc_vf_remove() to free the last message buffer.

This ensures the DMA buffer remains valid during message copying and
prevents message reply mismatches.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2:
1. Update commit message
2. Return -EIO instead of -EBUSY when VSIMSGSR_MB bit check fails
3. Move enetc_msg_dma_free() after enetc_pci_remove()
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 41 +++++++++++++++----
 2 files changed, 34 insertions(+), 8 deletions(-)

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
index 6c4b374bcb0e..e8c5adee9743 100644
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
+		return -EIO;
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
@@ -258,6 +281,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 static void enetc_vf_remove(struct pci_dev *pdev)
 {
 	struct enetc_si *si = pci_get_drvdata(pdev);
+	struct enetc_msg_swbd msg = si->msg;
 	struct enetc_ndev_priv *priv;
 
 	priv = netdev_priv(si->ndev);
@@ -271,6 +295,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 	free_netdev(si->ndev);
 
 	enetc_pci_remove(pdev);
+	enetc_msg_dma_free(&pdev->dev, &msg);
 }
 
 static const struct pci_device_id enetc_vf_id_table[] = {
-- 
2.34.1


