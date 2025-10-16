Return-Path: <netdev+bounces-230086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B1BE3D3B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D1814E2ABF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298933CE89;
	Thu, 16 Oct 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g3xr/ni9"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12621D5CE8;
	Thu, 16 Oct 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623105; cv=fail; b=WH5O6Gnt9QUnRZUAhUeyiid0V/8LT9Li0ZKk52s/rtsuyLrDFRBt2ptMRzFPLcwgif9DF8XOtZMvf4UbQq0+fARhXDGZCFbWmvEKt08hXSXY/W0LYU2OGDeV0fTfcoATsG+DsyXyWHTEFbQHFGXJsM6q/g3WYyhCD6K8uMilQWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623105; c=relaxed/simple;
	bh=aPvHaiKciBAtvNWar4lsDUOg+bKMJursWTkxFShvHuE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lx08A74/qjNaT/8KHGo+b6lEZHiFXobx9JIeGTl9nhv25qJO5suAVVqdw6V+Kh/PWme/Qum64O/TpNPPfLET1PPCuxvaWqkHgd69Dtg9QMGUHr0J4K5xONdgCe/5GBmhyRUg7YXdN02LofvfBdu4IF0/uLLNtVx6ZlSUzbHpsDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g3xr/ni9; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNkc1aVhaLAgwst9vwz49zx/qqTgkgshKVEgl5XnK6EkFKuSLmby5EZCDeSy9+b2J+GYzYaFtVcTEbgvgU18J1aa0UCuBaQomuqkoazFw9WTvvVznSpBcOWiCI30HCpUWX/bkgBQfswpGGMNshS5gtI0pQn8k4C1hBy+Y6O4fpM6jNXuwvJAYh6b7g4IJygPaQKpoHGhgTk2ay2FknaS0MRS56dqpcLR2wEmQEYOUA8z55VWRRcq60ss84qLhjWqDsDhocclcZc9RKCaDKToYXiQO755L5hcE7aV5dMyw2jNodydqGRhxi+9RE5lAS5aEzXoxzHHZTHOt1k74m2fzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/fsU7q9Ok10w+uyazSFw+Krd5jxrgEot+TwdL/Ro6c=;
 b=Bi34fvW2icDx/nof1/51glcGOCW3w8n/f0Y1Tu2ry6XzZVXFvK6i3Mc6rhIcawnX4CtbF707Jyn++uq8j3g+FZo+/BPdE7k3kOtB3pbIadoDZLjKJT9r5kFkWXQUsp2LQ9wgq0SVR4mNfCV6zC/buPQ43lA+lRXITpNX+vu4RcfGyexHTjsQnBPFTvwO3h3Va8defGwneL1RN9+j0eRYP1/4TV+i/h861LYdEntCvH/OGW5Dv9+ahZ5BKSk7qEPinK1Xd35Lw5bUjUCTm9deuXdzdUchVOQ0BSH78Uvk8kzwtIlUCmdbP2iySDnpcJN/eVsam7p8fKslls78ava1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/fsU7q9Ok10w+uyazSFw+Krd5jxrgEot+TwdL/Ro6c=;
 b=g3xr/ni9J063vmPct+zJCZixLdViDn8dWg1YuRHyA4X+sppWOpUERYrbs/sL8sAwO94ICmtTrjfVSn0YJzKkJZeiql/KycryKTHrx3jlzg/pwdWNqJLliKoqaYSRTzksyH+UAL0uE3HzVQW9jOUGyyxBrk6hmdbPzC0rbyd9r+Y2SHKAolxXx8CS7InIjVoYFbshPPm/FfBvqq6RuhqpqUYcmxb1+gxm3tLauP2uKzeHdnlfbxLiWo/+aCW/rdJ2m/UfT6/MKf8vr5WZRqVvHYsFAaG3JNVydVSjvSSMabEx1b5YiKPWKiOX1BDZZWW1V8xSifFUPdB4JUwtOcjP1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AS8PR04MB7624.eurprd04.prod.outlook.com (2603:10a6:20b:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 13:58:20 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 13:58:19 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mathew McBride <matt@traverse.com.au>
Subject: [PATCH net] dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path
Date: Thu, 16 Oct 2025 16:58:07 +0300
Message-Id: <20251016135807.360978-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AS8PR04MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 772ef23b-ade9-44bc-b724-08de0cbc0fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/LnfbR9O8GldtfjhfkEE8+ZDiiHStZBBPpjltnvWHe68jE8OE0oJQ1kEWhpg?=
 =?us-ascii?Q?2RA1bWEQ0paGU5+qjeEmwQgEID+71FjC/SR/ct/luVV3otO4+dn0+Ax601rH?=
 =?us-ascii?Q?V+MjU8ZHSuz+wJS5pfCeSlI9h4vcEilyXfFeRFCRcfTrS7vzKxEBzqiwKT7O?=
 =?us-ascii?Q?awJv0xmCAEyRjB10lDt5LL95gHcYRAB8HbD9lLwKEG7Yxm++QsRv6VuEEEzo?=
 =?us-ascii?Q?RTVuFGZutwuaRgA4LJuFaTDms7HR/K35OxsQCvArLa52lMSsV/8mnErfiUPM?=
 =?us-ascii?Q?Bo6r3s7DsUXHTHaLVzmHpokbkoTibrZ/ECn4rQ+yfodZtXnZzVRIadrEAyR6?=
 =?us-ascii?Q?ICSWAP25JNi/6JoK1WZS65YfRiN1qpglwKSQrwbQz+9TZ6KqNBpQgDZq2khe?=
 =?us-ascii?Q?mI3kfX6+b14lfFcjZVhQPeqYZCmWnZ5V61Dkcx4N5W/HFVUpgooKMiVF3LIj?=
 =?us-ascii?Q?XUK3BqOpnuSnKOI+SZ2Sre3mLSwIe7qx3vmWWyGLUE1OWtoTJwYuXhmet/JO?=
 =?us-ascii?Q?Zp2yEaMN4SbT/06FJul1yO9zh0aA3mj/uc0Jm/+dR+p75wMU5fa7raIVhsza?=
 =?us-ascii?Q?WLtycVQQafh/iQH8DZ0Lxz7vtCczX6BeQsa8praWyKKB4Tp6bbFRSYk99idf?=
 =?us-ascii?Q?FmQsApcim2hz5uL5iVJDZ6YK+npuush1ZHwvzYUVvc28mh+Wwvs4JKOSahOq?=
 =?us-ascii?Q?0vRei01R6/AEpIqAT5Pc+4HTElsr+9fOgsh13nAIrmffhs8Bf6Dj1aD1DKsR?=
 =?us-ascii?Q?EJwLcs46bpXGDq4PPeC4mJb+kdEorzTJRxwe7IER5JLBqdfvVSa0zz7JKAwi?=
 =?us-ascii?Q?oBW1yD4uKXv9Odv9V0PnkuiG0BJv3bOQerRJLLJ3B7vegBmZhtrbzvcU+z1V?=
 =?us-ascii?Q?fzswCoXdo3LbYmscAtw/55eqQR03lxVI8FrbI9NQlR8LDw4AftwHyltChUun?=
 =?us-ascii?Q?GQwn0biVxRyIhSRfn7X6jUO3jAAwNccTrbFyEO3xc806pzvz8c98ZqNOYe5K?=
 =?us-ascii?Q?P+hdgdPvA1HxnRoovXdkMT8uEPgIgR5C1bGcXMOQovNy1KT6KePZ3xV4wZn3?=
 =?us-ascii?Q?EzwYm5SLM2FgOf+u5jr4c/MFeF5BaZ0+BepmqilcFu6S7bqcf3B4K7qxmht7?=
 =?us-ascii?Q?yvPwIHseHTr8652RlrgKLN/UwJ6eYbpigbyWKHaNaFO+J2ysfGCPLUUhFye7?=
 =?us-ascii?Q?JUCNxQie3FgyR1jgb4PbeNIP3yOSjExbyAPG2jIyzsfdgmwIeUFlCpjUOx5K?=
 =?us-ascii?Q?/jiPfpzn8TTndyo58LwAQo+JvpFuyLgIpG4myHRW3ShvVneKojJi4W40mwXA?=
 =?us-ascii?Q?ZoixLtDjyQ93G7GFnmFsO60F9tCwcu9Uu48zlbwST8Kw2NpsVd4q6SxqS9+o?=
 =?us-ascii?Q?lbNetbYRkrsxwY/3N+2LCnqOx1Jtk+l3nEjor2bG+PQFghdICQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1vkZki3cruQUKvdnzXAg5Wl7rcCuJ2piIbdoKVOlaHHh+2cl30xY0OW1otK1?=
 =?us-ascii?Q?YBJdOCUtKj9qkDOwKdMktruVr8HAhwZmM/5JbNPDmD4EOKnDP39ggrMhwLqq?=
 =?us-ascii?Q?9+pRFRpYfrttw8YCPAkLFbPGFKhnviEmjjro59t5TBmI8ASNvpOVdSmnU9bF?=
 =?us-ascii?Q?O0NAUFvrQXPm5QD0qciqVvw1jE60uiuGj9gwwBSxKEWM3dSdI1SaUkT04qH2?=
 =?us-ascii?Q?JmLTCM6PjLOW69lDU/qdBW5R0MqyKHF3v3ciA/qookaJolUpMSGnplRNJsH6?=
 =?us-ascii?Q?yxxspqgefTRslg2MlYS/L6lIN47E91iwsdrKGacO8zniWW1KsYhWn7Vmv6K2?=
 =?us-ascii?Q?h6M5uMc6I3hiUsryozZQKicrmrf7l9QK8MoQspuBKT8JisI3RgBQzq+XhX/v?=
 =?us-ascii?Q?6TumE7EhzH+CpeGbct+zAMRjC5kgydnaSDJbo6QCUzkUaoBRiawUFrF5b4Cs?=
 =?us-ascii?Q?m03Jjz7XPGiSNe8Jkmxgh91gSUhzVuclmdUJmoCqNiSZoU0yTtGfWZ14vjlm?=
 =?us-ascii?Q?98DRSrulKsLIjuaUBK1BSrQUtvnDNHT5D/FIaw0DStcHFcmj/6IC8tRgkUE3?=
 =?us-ascii?Q?rbwURo/iZ4iq4GdXUaXY70HWIIlwPIE3vROma6cJNOcj5aL9bsf+43byD5rO?=
 =?us-ascii?Q?ztrGxuRg7MFL9qUEBfDldmfxr97xuxnGbK5i/VD6UrYkQr0YW2qtV5kQHga+?=
 =?us-ascii?Q?uBdn+3lPpoSvCCIMAOZlYyYSdiEXqussZJIGk+bKGH7L9chtTw6lU0B7yOcQ?=
 =?us-ascii?Q?6L9/+rBfJjwfLrZZC/cjYYyvmMdeSMlN2i9PMV3mp9JEtwGJ/p+5DKndUuJf?=
 =?us-ascii?Q?rFiEhWpzPMfyRKS5QNja9WfcoqToFLpzKiMesY7BtsoGkqDNZvrqpOZI0lmY?=
 =?us-ascii?Q?HBmo7DKV03/dmOCFV//DskdOn3h/3vAMVILqTgAETxb6PGsV5CIIPAc4a2HR?=
 =?us-ascii?Q?4yUFDkwdWsYUyxjWcZQIceATLmESQWJ3GLgCZ/bRqA4YNY3cedQDRValcR2i?=
 =?us-ascii?Q?UjYlyVQAuJbt96iAA38H2TmRDy4qVojcdYU8HLIviCTZXz/9HyqEyUMDqKi7?=
 =?us-ascii?Q?WkWS2I7AVqcQHNhxBCfHxT8TlQ/hJEdBFyHXw5r//ebrCYMTV802KoFuEaSi?=
 =?us-ascii?Q?ufkDwr2wGwi/VmOXA32tjddOyrGvVK1l2QmcOdKWP5Jq2JfZnJU5UptQ5zTy?=
 =?us-ascii?Q?3Up78hZCQ6iUH6NeZ/Q88cL8IoS7vTk2+BBRuVjZM+RMzyfV/kxb5uXp7JYH?=
 =?us-ascii?Q?33leZvUvPzdkvcTWY+VuzVKecVjYRwK5g2MgyciZ4nEODVFqJ9WxI2XcM3Gw?=
 =?us-ascii?Q?0/nyfFo5AWmot3qJm0l44zk5NPEEkBIYJJVFIeK5sWW/hWfOAmV/Mg0gM9rq?=
 =?us-ascii?Q?N/E5/te6S0bW89ljrG92cqpsAfPkqu8rFzSIhUAcjmuGLMfAhGqMyNTLYUGl?=
 =?us-ascii?Q?TuvlWGs2ydlC88sTM24gRH1iAHjw3tFKbo3nkhkHXHERj+yRmTKrHxGhb34d?=
 =?us-ascii?Q?zMbvXm/a9PocvHbR8GRGhtrJOmChYXCiPVBOgn+6bLOQILSr+ZQZDA6Y6DDP?=
 =?us-ascii?Q?5C3mcoA+hgRMpySZwiEzDkWgyvV4saLxlkci/IpS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772ef23b-ade9-44bc-b724-08de0cbc0fb7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:58:19.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mP/LLczm9kmwafMSJqt45AljzmWFlUqRkpLWNZXgDP/ldOE2ROat9XXeK6NYS5c7Ew6J/4ENE7eOANQZvWlcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7624

The blamed commit increased the needed headroom to account for
alignment. This means that the size required to always align a Tx buffer
was added inside the dpaa2_eth_needed_headroom() function. By doing
that, a manual adjustment of the pointer passed to PTR_ALIGN() was no
longer correct since the 'buffer_start' variable was already pointing
to the start of the skb's memory.

The behavior of the dpaa2-eth driver without this patch was to drop
frames on Tx even when the headroom was matching the 128 bytes
necessary. Fix this by removing the manual adjust of 'buffer_start' from
the PTR_MODE call.

Closes: https://lore.kernel.org/netdev/70f0dcd9-1906-4d13-82df-7bbbbe7194c6@app.fastmail.com/T/#u
Fixes: f422abe3f23d ("dpaa2-eth: increase the needed headroom to account for alignment")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Mathew McBride <matt@traverse.com.au>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index c96d1d6ba8fe..18d86badd6ea 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1077,8 +1077,7 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 	dma_addr_t addr;
 
 	buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-	aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
-				  DPAA2_ETH_TX_BUF_ALIGN);
+	aligned_start = PTR_ALIGN(buffer_start, DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
 	else
-- 
2.25.1


