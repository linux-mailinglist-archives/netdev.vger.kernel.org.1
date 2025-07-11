Return-Path: <netdev+bounces-206081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD7B01457
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331501CA12C2
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACDE20D500;
	Fri, 11 Jul 2025 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TfH1yeKG"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE519D07A;
	Fri, 11 Jul 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218282; cv=fail; b=oJg9UdnYVkvAaeJZ0jJC7K8JnZGX7qWgOsfgXI2LncwjX4OYO9ha52wkEl/xwIc48dyHtI4sUN39lbmujM+fW16MGF0BiwQFoceFqq2woi8jt0wOq+pcgm4QTrIGsXyAeerwlvNQPBTgYm3DUo4mf6WIaYrLUIBMwMaBNTwxeMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218282; c=relaxed/simple;
	bh=yYR3vymx4Y2kSier9cDMB5ktTxDJtZ9FcKbJ7TUbLc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OXcwx2Z2nlPy+7H9zYJ/hAa/vfBBqZeUNJhsAEkU90RcvV6Vb98Z6d/tNft8EGaRD/JNhQzvEO57GrKb1QTZutXTqKMr8CiH/Gz0TMysKs0ggueJvRusdhXy7FpqahybBoej9Yc8RFCcrSDAnF+XiOWzH93w3EyHZp9NWm9Ut/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TfH1yeKG; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dctGXQOSkikJOaTAS8fCniIpKvC9sjmDnTGX4cAB8XQ3x4ZEGl30nEY79bHrVlhTVaeUCTjhIA+ZHalxxcbjhsBhk6DSQb1ep6Ty4uCrHUCVngovbtidIIJULIVh7kEz2EyWOV0ntY5tkDtQfJ3mevCWx+8z3wZ3tNAjyGjsV5agFFwR23288G13Q+8tFi2+HMgoJExwNgRZt4Kl4/uBbINuV09tvjgDrQQXkMfOuWeM4Z59yCWq4Nx2hnd1ZrNN+7GDeXgpmyeJiObqhVLLS1V2E1PTwVsj5k4F8/91OnxZfkRSLBVSosomFC1T7pcsnu923SPIEYSd2MXAMrrMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBsUqQOHrqEPqdk7fcW4L7lk7L9rUjph5k1e6As/aS8=;
 b=Vkcx//XI8rZHwrXCt5hHd2JEGo+3tbuy28Izpv52lySCooEsyGuTO/Xqv+2riPN+zsRy9xtUspHcHtPKNKr2lxdn1sM0X96hgN/ChQ5xdOlUStz3LnjGL+HpvVDpfgO+0qU2faO3V3c8qxa85E+HHWrYJeFy/XIMIu7ahXlUAlo5xfShAUooBYu6IxVCQO+XrMdtOw2/2ihiCI7UdmqMQflGEjgsr0wOBP6HxAyAznjHzWHtniRzMa0fJP5S2Fb5WWJwTLc72uvYNmzk9HTEF4ghIWGb9tgRYbHoqRsK9ECTWdQ5gCjFr/HhYS+3at9onBdprG+INaBEmS1yJvKbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBsUqQOHrqEPqdk7fcW4L7lk7L9rUjph5k1e6As/aS8=;
 b=TfH1yeKG/0jzUmQEbY9wPqIpdNIl4MVlUJwoAkawMIkHfxIeKiU772K8nkHaxtA04SirrJGfkllXlKnAREq2/2591SvsQKWrU23jsFNkYMiHcFf25JqF/uPyYqhYJheIKfrS5BIXVBJEgdSrO1DrLk1/Nq8LLQO6sQmPBmbDwB1MQ/QzhXZWikych6t5tqTpip9e4ob1BEwUZj9kORiZhWdllwnFkFf4oyO9FltabGcvLjZubBdMeExve3p9Nygd4PiRExBrZmuoY6dK/fv5Rz7TRYnI8zVfV6v7zzU4lqmQ58CMoqqjT3nazG+SxXgr9vP5O6grh1f57bJoGeU0ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:17:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:17:57 +0000
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
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 08/12] net: enetc: save the parsed information of PTP packet to skb->cb
Date: Fri, 11 Jul 2025 14:57:44 +0800
Message-Id: <20250711065748.250159-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711065748.250159-1-wei.fang@nxp.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11361:EE_
X-MS-Office365-Filtering-Correlation-Id: 54311c00-37d1-4bf0-8183-08ddc04b0f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZQK12ZcF7j4tGwcAAs5/QuceFje622oIEANbVUWe671yFLIfGAJO8oIwWIW?=
 =?us-ascii?Q?osT8XsvRknjtUtI1zwLmMOuxny5JWczWhtNre7FAjUMV0gD1etSWNjscPo3O?=
 =?us-ascii?Q?PIldxdxU42ePO6J/hzR/6P5WQcBenO/F75L5bqJMYiPts8ESq8SxtpxTs3c7?=
 =?us-ascii?Q?fKy1WeMYlV43Q5hklw6R7IYTaHrxMNcsx7Xx/BV6uh8Cl4r4CKfQljLDfQ+r?=
 =?us-ascii?Q?WixuMHUFvC9t8Qn1qUuoAasJoIwJOGEe/KBeqZPNwa7asbG4uO+4q2bumsfY?=
 =?us-ascii?Q?5ic2SHgvIxt/8uNNLtDizsW3OHyGfy3rnn3S5UrPJNerj/oJ+tz1gYCQQa7b?=
 =?us-ascii?Q?GLsvYbVjVGjDyCNPWHqI+exMaB0/DpMW/IbDC/3VyryTPWDDEONGjtGyD8hR?=
 =?us-ascii?Q?+nAev0h3rqe2bOYgR6I1xB+FSAZpp66A1Un1ExODW4xOrRsP+B5qRLmw9orj?=
 =?us-ascii?Q?HiBWf/MvOykFKivjoZyM5KUwYQOvxuQGiP6rxctTvmhbD2ehbjLPMFCKxkZC?=
 =?us-ascii?Q?sawMmX7tuy6vLsznnh6i6/shgfZTP2A9WoA5i3VdY2DVcFG7waZcTQBSusW5?=
 =?us-ascii?Q?UEuA85WDWdQsrFb8bhj96gYHAwxBV64SiQ3MvG74IjbfAU3nWcPWZJ3O+clu?=
 =?us-ascii?Q?iexWCE4U4bIiikvwnx+UVWCBxF3St3GzDqDa3vUMCgfjv0ZLj15jKaAPIlmV?=
 =?us-ascii?Q?taBAAxdFlxOeetbqimv5zE1OpqLLdWFyIxWWLSEbsYai+uqjxnmYuXjB3yrp?=
 =?us-ascii?Q?ifW9hnoA1VZWU4CzXqh/XIVPY9hEdHrWMGRhWyllORrOm4YWoOtdDzQwozEE?=
 =?us-ascii?Q?AqtdJXk1rxyUFsyAOa05v2/MqaguwxZ8Tx+rFlT3prrJOsym8Ld4yH8Br5mR?=
 =?us-ascii?Q?pTjAGSZllTbuW0XbQIf29tXs7P8UVmtb5bts8k19p7TgMJBL+6NjkZ5N2OKE?=
 =?us-ascii?Q?+mCSObFFPtjnYulMHDT12iD7nTilsODdokLF1rYX4hRMxRvftdT5F/GKC/QH?=
 =?us-ascii?Q?iDdy9ISqQ0u0QwiiiZzvMoz+inCTFsxSI/XbdUunlrGfIlGwCKmmf5QQrCJC?=
 =?us-ascii?Q?TTRv/YV6L5l1ULf1trHdrYVy6so9qli6lA5CRASiSQOtq7/9a5d8UDMKP5Bx?=
 =?us-ascii?Q?5mPsoX1UWiDVeB1eA3bMjCgWov3PeCe4e2oDwyMhvMbD8sRphxrud8K4zRc3?=
 =?us-ascii?Q?31nopdo/JAeKrA7F0i5Ia/KS51V4+o82Fm+WUp8mZE5lnNdmf2XGRbNIhdKZ?=
 =?us-ascii?Q?m7cwbVG2fbTPoldbJxXeqEzBNfQ0DypCD9uLxkl4ZZcwZ6nYKwbhq2gpo0qK?=
 =?us-ascii?Q?3i4rUWWVUSWJQDVMWtxY6F4SChhkbogi/gSH1RiL0C+ez4OJ0f1ALXGpLEdR?=
 =?us-ascii?Q?aDkwWhezxJ2hfiDjtCfB64ROcMLH+85PksO6dfMo+dXCv1nKyxIxwQGUgi1g?=
 =?us-ascii?Q?Vytvzq7hIpNwBF3V0K/9y+aGuRSn93MnvWFoJCODnr8+5eIrf0wl6Gr+OCxn?=
 =?us-ascii?Q?Fp78v1fwsk8QNRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3MjjQPHUr25RWIzXoEhEE8uQ2WN6nXprHm+W+OR8gL4GgAV0v31BARvS9huI?=
 =?us-ascii?Q?AGVg4Zwnfc1dDY0a49sm3X16G6pErb4yvIOz0FPGnfz5mHlYLYLWYAPwPVTa?=
 =?us-ascii?Q?xS1b/pNFdCsnYx9VG2WOl3Qi3NsEOBTZEVGnDdt7pYNaZ1nqfcZZBKpTIwjW?=
 =?us-ascii?Q?Bfp9I+MvSqpy5uUxCJ3pP5LI5W5wAGtBZk/0dLlgoXdNy45kGwpPSUNkEIr/?=
 =?us-ascii?Q?78fv8/RQt241PGxNMQFUz2DQ9Ma/GF+3bv9hR/bSpmwMBz1BHGr1obnJopQV?=
 =?us-ascii?Q?YZy8GpCMzYWClfsI+7/ZSroM6g5PZfhLCua11BuAvqVluJ3/ZY+tPLXj2tHA?=
 =?us-ascii?Q?JSTTd6Z0uXqKGje+8eLuzm/w11rh7WIJ7OCF77dz42qNQXg/HBWoCbRQ2sPw?=
 =?us-ascii?Q?3um1uQdqg5ficl1toGOdP0nmkMgEXKPGZBvcKkth1Ng3IOtiKTfOJaipPtyZ?=
 =?us-ascii?Q?lIW1Di9UZxI61pca562wVZCIKz90eAfJY91+2t9VYrKW0rrdw3eT9QLzeCI2?=
 =?us-ascii?Q?R1KSdVTvdm/Xe+qlfzO9FsAySuvZKpPGPJjinbMCRQMkKrXjfX8Dy3kd4Trw?=
 =?us-ascii?Q?+x7/fL9fa5IpNxb6zURK3c0FpZX3c/a224CDbHnrf0UHy0I+rIs1JmwPWHrZ?=
 =?us-ascii?Q?nOyhaz/jsnjp8lt1xJadVj+I4Md5zZOBZwBLg6NZLNgS0fFy5P4ozwL1dF/T?=
 =?us-ascii?Q?c5IXPb28h42JYm3IK7Zk7DWp1DWGiJ0NFbJlBUFwOW1UiZ8x5NbRowsbRA2o?=
 =?us-ascii?Q?SBj3nyQaTco2I+vwkXaZEtZhlt2kpk+NfEhzegjF4yRa7MZbsfoR1+VTmZJ8?=
 =?us-ascii?Q?1tSaF7+oBDG+GCkOscxgvqZSkOHJMYJpqEIHl1kLcok99L7yXMYhDTFkjzp9?=
 =?us-ascii?Q?bAqcTliSB2IOC+RcKMkQOMqCqB8M+kRCfKDl/qfMdh7g6A1IOFhkjvTwNKl5?=
 =?us-ascii?Q?+yK29VLHOp8Ez9G0I7L7LE5KqFO/W6Fh8jdgLi71bL8qBYQzvxRa9X6hYweL?=
 =?us-ascii?Q?4dKbhCAixgWnKnOzD/SpPJTt7sOWqH3osUW0r4IJiPtvMvaxoEyXKoB2XfMU?=
 =?us-ascii?Q?gp8c5UqxC+6R0LLu10xLIIAlH/Y1R+0JEpSjxeOfmb1eOYxv9V2WRTUei1dG?=
 =?us-ascii?Q?+WmQ4MkOrDqfeXtuhOmlyIhKa4ipqMZZEsZS8oln6/U70N9VNkakAAQa/JxW?=
 =?us-ascii?Q?LOPuunhsc7Hodx6qXZ9736irln6z+sYefTJLZGZcaGAMDKJyFfwkFBpZKKe7?=
 =?us-ascii?Q?h9tQHIc5SDUYXyRrh5Ne7jpCNKb6D5nSCDe2wshiD4MtHwXpRxSEV+oFnmwg?=
 =?us-ascii?Q?eZ3UsUwO7GB7TzXNMC2JnMslhsobx4um5koz5j2+feyBkBcradBMm0kvsdJ6?=
 =?us-ascii?Q?a1+2qCIzKk6c9qHCAgqNx4XKWAlBoGQ98twVw06x2YQVP3fVOY2saNkGHZ7E?=
 =?us-ascii?Q?jF5a79qCblW8di1FWJBlpw9EEZcEewFoQDXk05+7w3fbbC0D/by3puWz/u8x?=
 =?us-ascii?Q?klLadZdJRaH9Dq3tKhJyYg/Bgg1ou9DgsV5EpokYBH5AQRXZgXUvN+EkV69H?=
 =?us-ascii?Q?D2HNygNGe4bvbIpKkrvzAF7mE0khPISkK54IA+DG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54311c00-37d1-4bf0-8183-08ddc04b0f6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:57.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxqE+fzYQ86oMjQyCBSWGPcARPO0DLCebYVM187yxWw53zCBagqB6zYmF3wthGUST2Pi7r7Ml3JiaBnPAGjG1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

Currently, the Tx PTP packets are parsed twice in the enetc driver, once
in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
and is unnecessary, since the parsed information can be saved to skb->cb
so that enetc_map_tx_buffs() can get the previously parsed data from
skb->cb. Therefore, we add struct enetc_skb_cb as the format of the data
in the skb->cb buffer to save the parsed information of PTP packet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
 drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..c1373163a096 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -225,13 +225,12 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
-	u8 msgtype, twostep, udp;
 	union enetc_tx_bd *txbd;
-	u16 offset1, offset2;
 	int i, count = 0;
 	skb_frag_t *frag;
 	unsigned int f;
@@ -280,16 +279,10 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
-		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep, &offset1,
-				    &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep)
-			WARN_ONCE(1, "Bad packet for one-step timestamping\n");
-		else
-			do_onestep_tstamp = true;
-	} else if (skb->cb[0] & ENETC_F_TX_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
+		do_onestep_tstamp = true;
+	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
 		do_twostep_tstamp = true;
-	}
 
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
@@ -333,6 +326,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
+			u16 tstamp_off = enetc_cb->origin_tstamp_off;
+			u16 corr_off = enetc_cb->correction_off;
 			__be32 new_sec_l, new_nsec;
 			u32 lo, hi, nsec, val;
 			__be16 new_sec_h;
@@ -362,32 +357,32 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			new_sec_h = htons((sec >> 32) & 0xffff);
 			new_sec_l = htonl(sec & 0xffffffff);
 			new_nsec = htonl(nsec);
-			if (udp) {
+			if (enetc_cb->udp) {
 				struct udphdr *uh = udp_hdr(skb);
 				__be32 old_sec_l, old_nsec;
 				__be16 old_sec_h;
 
-				old_sec_h = *(__be16 *)(data + offset2);
+				old_sec_h = *(__be16 *)(data + tstamp_off);
 				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
 							 new_sec_h, false);
 
-				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
 				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
 							 new_sec_l, false);
 
-				old_nsec = *(__be32 *)(data + offset2 + 6);
+				old_nsec = *(__be32 *)(data + tstamp_off + 6);
 				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
 							 new_nsec, false);
 			}
 
-			*(__be16 *)(data + offset2) = new_sec_h;
-			*(__be32 *)(data + offset2 + 2) = new_sec_l;
-			*(__be32 *)(data + offset2 + 6) = new_nsec;
+			*(__be16 *)(data + tstamp_off) = new_sec_h;
++			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
++			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(offset1);
-			if (udp)
+			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+			if (enetc_cb->udp)
 				val |= ENETC_PM0_SINGLE_STEP_CH;
 
 			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
@@ -938,12 +933,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 				    struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
 	int count;
 
 	/* Queue one-step Sync packet if already locked */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
 					  &priv->flags)) {
 			skb_queue_tail(&priv->tx_skbs, skb);
@@ -1005,24 +1001,29 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 
 netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	u8 udp, msgtype, twostep;
 	u16 offset1, offset2;
 
-	/* Mark tx timestamp type on skb->cb[0] if requires */
+	/* Mark tx timestamp type on enetc_cb->flag if requires */
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK)) {
-		skb->cb[0] = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
-	} else {
-		skb->cb[0] = 0;
-	}
+	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
+		enetc_cb->flag = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
+	else
+		enetc_cb->flag = 0;
 
 	/* Fall back to two-step timestamp if not one-step Sync packet */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
 				    &offset1, &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0)
-			skb->cb[0] = ENETC_F_TX_TSTAMP;
+		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
+			enetc_cb->flag = ENETC_F_TX_TSTAMP;
+		} else {
+			enetc_cb->udp = !!udp;
+			enetc_cb->correction_off = offset1;
+			enetc_cb->origin_tstamp_off = offset2;
+		}
 	}
 
 	return enetc_start_xmit(skb, ndev);
@@ -1214,7 +1215,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 		if (xdp_frame) {
 			xdp_return_frame(xdp_frame);
 		} else if (skb) {
-			if (unlikely(skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
+			struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+
+			if (unlikely(enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
 				/* Start work to release lock for next one-step
 				 * timestamping packet. And send one skb in
 				 * tx_skbs queue if has.
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 62e8ee4d2f04..ce3fed95091b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -54,6 +54,15 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_skb_cb {
+	u8 flag;
+	bool udp;
+	u16 correction_off;
+	u16 origin_tstamp_off;
+};
+
+#define ENETC_SKB_CB(skb) ((struct enetc_skb_cb *)((skb)->cb))
+
 struct enetc_lso_t {
 	bool	ipv6;
 	bool	tcp;
-- 
2.34.1


