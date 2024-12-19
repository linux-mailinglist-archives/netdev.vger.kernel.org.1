Return-Path: <netdev+bounces-153234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FF69F747F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74E17A2594
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B2217654;
	Thu, 19 Dec 2024 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BT72cbGv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E8217657;
	Thu, 19 Dec 2024 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588279; cv=fail; b=l1LRRYO/4eKjY0NBTaMX1HuS5fr5QvjqcDsZV/kUcJBFnL4pQx++kCX8+dwX821vC/U6F2xIOCb/uZOXZHH6xqwnbvCowFfeivpRJXzNrW1raimRNb0eN9B8mdBHDKd5shUYbeElGAR/XRLz6BKh7kENEAbqoSfkA4aaZIacyrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588279; c=relaxed/simple;
	bh=JVHuCJTh3mapXNE8qOrMH6XOzlnkglfFDZ5tO3qbhNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uaDhms9gYEE5dBOA2ZRXVkHbFak0dIWeCauxqh8AHdgxVwq2zzwuq84fW0WtsSK7sI8uq8vFYxFVjHxB99wKYvQVWas+B9fVCEG684/Vgto8waoLZcSmJvkZz6jZTgbdFn7WdyQZ54NGw51etGulcYVzPnRyZlojAbDwP2snSKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BT72cbGv; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUGlXlX5hdfoMXXoabw0AqXUNeKT1JB7TjeztwXfnKe3/VHtCVkRV0DamunqCcHGTWOzxqnH4XWPw91d7NpMJuLmWfw/7xyTPn+OxisvTLC+ml3/xqlVsJQe0ALuGhVl7xtftnq7nZPWiFbHJsqd4j0eBVJ5Okrz43fo/8GtCQctpoWC++nkF/B3YiWJ/GnCbPFLHlo2t2ac9Y7U5TcgUgEO3jNduFnq9G97ZHvLLu0sS49Nm2fk+RGXAT3p+GGiWG/BQyHXxYLlb1h/2Zxixy26wW0X/7qidu0Bz2RErqnFIBZpZc1wkhtCi+9V6obC3RZZAyS0L7cPr6YkoL9GVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQUEBw1KAgQkBeQ9Ch8cPDbOxuyMclTX054mfSGyBkA=;
 b=io6nyLNm69m3/ItzkUIeGy3+ttlQDpiN+yZ8Yxw4SbDoz/b6r+bvijo6H1vcC+PTaS9hVsMkHQC5Ton6VGlNUkInCrkmniNWK0dcuqzgZIMIVNK6sWQh56IEDzWC6nqI5ZE0teT72d1WbtS2NDuzuZT5li54zmRqRMYqNsrp2SFPh4fgha5k89FXNZAiLe4Zrt+KzWx05Qm0I80Msbo6Rvw2wbgX61r6W5EVOT1XkRUMoKzGfCVj7N47mBObbBHrvRYZShn1UYkjAJjd8HPUjI71wV7uQZLtT6F0O8oNOkhKQuuKeQYAUKDqC9CmKZkgalJXRYnK3plPDIf0CF/22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQUEBw1KAgQkBeQ9Ch8cPDbOxuyMclTX054mfSGyBkA=;
 b=BT72cbGv/bRwTsiKzmGvOI8D37sJTSx6PkKp1W8OvZ9/sRlHWlMNFrce5dYn/ftU74ZlYl//+6cbH5fxgTmVhyU+bbQO7ntqd5ylCjw4UThSOYIebjt5qyrFamoa8fRbfnbOGbVZKsTBE5UrvSYIai7p+CnUZZc5lbpbLpZ4cQwKQd0UAjczO4AwTcVp2BrRHxyfSaePrZpgRJrGP6aBh2UG4tiiMO0MQJue2J+W8zLRbbAXd0gJrhnwj+X6psIhyV0k4bc/S1ys5qoklZzQF8B+uAvKuzM4y6Q1lhfQabtrL/1tesPlFpKdWbaAa5cyN6lsjklBCER0UZwimuqdTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 06:04:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 06:04:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v9 net-next 3/4] net: enetc: add LSO support for i.MX95 ENETC PF
Date: Thu, 19 Dec 2024 13:47:54 +0800
Message-Id: <20241219054755.1615626-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219054755.1615626-1-wei.fang@nxp.com>
References: <20241219054755.1615626-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0107.apcprd01.prod.exchangelabs.com
 (2603:1096:990:59::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c6bb10-0c3e-40f0-791f-08dd1ff302ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9RhDAfjs1wwGnHPOqhGgrrGEYwp8RSDaUC4lMVY0aKzE4FTVrtcSHDlkAkDq?=
 =?us-ascii?Q?6JqZUky8mZTXiPvVKru8VQLRU/wwyNhornv5l1aTbAi6+oq9r6FRlneXqtji?=
 =?us-ascii?Q?478+O2Cq7n11JyCYW2p+9rd2yugLJWYDfBTSwlgXPmcjlrRLdTI3XD4g3MBe?=
 =?us-ascii?Q?T/xLXI9dTtms45JUwIufA+VkFzAUVZWgCTvc9byQkzLV+sYHf0LHbnRqozHL?=
 =?us-ascii?Q?ylqmhWTrDpYoIOxeNA2eCTgairXMr5kDLZpufQDVDWdB/+ooGrF4LyCOCsYh?=
 =?us-ascii?Q?fR5RkBFcDCQLUIqPUX7oDVLdu1htZIso3tH+ZjagYXNuDGvtc7IMTJW8POas?=
 =?us-ascii?Q?xDKK1UG/YxG6kvLIsYfFBqUHugYFovHvG3XePppldQKeC7JtkdMaais7q3R2?=
 =?us-ascii?Q?GQVcFVNoVdu0WA2eG2Axebdt/e3Ca5mvGZYfTTd9lpOsb7QjLg+MUMEWk6Er?=
 =?us-ascii?Q?Udm6upQLqsZlFYvyBuKVyHj36vt2JhAgEOBHLfrn0Mlj7XkzQ4fK2QuSCUR3?=
 =?us-ascii?Q?bzS/GDZU0RRExTOm8WaDRDI0sLP/PHJohEL3+r8XS/l/ZuZu0TC7RPqzrTKV?=
 =?us-ascii?Q?G7Yryy7KnphNiVe1FQ777mMrBMs7icUXossx6XvRWX8uAkAorpH3tcRJyF0k?=
 =?us-ascii?Q?ouYr8z9MFX6CIy49mHqsU9IMHY9L/T3/1/D3p8qnCKhiOJ/iF3B3/dSSV0vS?=
 =?us-ascii?Q?8bN8Ts+FnNwIgvMTVJAFZIT9uBiLCdy5BJCGN7buL3p8bQLNfToeMU1lNr9s?=
 =?us-ascii?Q?8mYj5f4dV6C3AUpNN66jlx74QXoPncMOfVlGYWWdB69+7xXam+aNx6+m98S2?=
 =?us-ascii?Q?VceRtuZhOhZtzdQ8PmDxoun2oMOyibKhku6z3rmULoJCIzi8yyYNzgOo2iIb?=
 =?us-ascii?Q?pEJ+qNDfZlQctSAojUSgrSOnjiBv4EYmYe/mHf0L/jUReNMvMho/MdrkDVF3?=
 =?us-ascii?Q?aejnaFaognc9sWwuDqkdwrko960DEL+sYvmMZqhukJVCe/RpODqCCI8V+gaU?=
 =?us-ascii?Q?CMSEEyh1RLBrL+Mqg9zDeeagLyFMtx/hfpLJzBwWSNxNDXXvxAk4eRCDsKTY?=
 =?us-ascii?Q?BxXfBbcXP+waz5w0BPGNTli55L94IxiAx/C34SDLNeNK/J54W2KkdfM1kwo9?=
 =?us-ascii?Q?vGv+57x5ABJ1aIuM1Ul+udIm5BgrTZ7QpbOYUIXRlIhJPQ8cNjXqfRAiKruv?=
 =?us-ascii?Q?PsfVAsbkHxjgDe7KD4mAVlJBe91RoOdbwpToUjyB72SmCFOvNoVLo7pp/Qtd?=
 =?us-ascii?Q?mNd5H0UOacH9tBhJcT4GYTJRiYRmVsWJqtkA8ty6FsDqdALHE5p9J6jFNRzp?=
 =?us-ascii?Q?3R1tNNHob1PiCgoLkH5AmHaosSUQEBgpkLxYxrmfT3QMeJn5ycDf9bWQdclp?=
 =?us-ascii?Q?7MjdaP6ccxPgtk1VJ5IkK9mm//qOB5FoeO10Gf8FDD48lf38/azgljqUqgOL?=
 =?us-ascii?Q?bYvbv+7Tt9e/wf1WGuuWx3w1nPLlL/t14FqjZH2bd2XXf9RN5hv7Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Is4MURjjP6kCVT5CdzNaM4Ysqb5ix0DErNCMnuPNtHR6zFLJKq7nAMIJz1Qe?=
 =?us-ascii?Q?rs+jInHRcwAdHztTEFeAbT/eqx7bK9ZhVzKjTlu0K4eX0jL9cu54FFp0m5ZP?=
 =?us-ascii?Q?/PjbN7BP5WtUhIGW99Iq/0Imb65/5cef0qf+ackNKmewc5ACjvUTu7fzFy/X?=
 =?us-ascii?Q?hOUOHDt51DnVW0SBu0Vgwiu0pRnYYbpoy6wVoihhQ2f71knT1wS5xCsCz9z3?=
 =?us-ascii?Q?N7psmp/1WOw25wd4/RmzjExhRUT9P+4vkorrPKpNB/7j9zNXENph/hhrK7n+?=
 =?us-ascii?Q?1Bbj5xRiOWCRBs0PVSF/U3csl6rPzNr7x7FNNHMDcpl7zNcUXmOKKC+7XPfS?=
 =?us-ascii?Q?HKpYdzr6N/uC/up1LuFDJP4xlrvLr0ywKWYqx4UPEikYLsRzZy4ZpNt5v1LZ?=
 =?us-ascii?Q?FtY6rHTTlk8nyFZXNtzRxmdu8eC567rkANpq4ALA9krW5NqP/cZof4JMnOzy?=
 =?us-ascii?Q?mimZoF46J/r/hpTZM/AF/FOUEF/ynrePVqvduuDkTzz8s205fgt8GFL1sChD?=
 =?us-ascii?Q?dlJQvWDfIDyjG3YWZggMqqlbLzuNtQf7dQEj2gN1vHpQriHieUAHRz8/nOmH?=
 =?us-ascii?Q?2ikh+jTt9zqRn0nWZKrFOO17Ka/u7ajTu+eFfXgH76Z2gNSEEOzpbdj3V+N7?=
 =?us-ascii?Q?qaggaqQQCsImn/HR+Jheq+Y9WckYapWqhlL8NsIS94OVNjC30GxLFEV2wvXS?=
 =?us-ascii?Q?yTR/QyRYWbfVrcV91Hm65c450Ln6bSQLMsvExjI45jyvbtKHQyXaXSgbGCt+?=
 =?us-ascii?Q?oYniRV8MyrC4b2g2nX35ucr3O2uguo56yce3vtf5i77T8VkN7BIG1xosYbld?=
 =?us-ascii?Q?etmMDd+F/54fazx4sUtbX8ZLqjYayLVsbRx5ykPpPg9jrPpzOCW/bxifktm3?=
 =?us-ascii?Q?pnNy5ZMoeIGRczDlq7PomuK8KglCoiJN5pkGuTiQT6GxS/KYiJZOK1XLtw+e?=
 =?us-ascii?Q?m5ZeKwNdGWhx3gFrUekicQkZXEOD5QC/f1FIbP3fBFytnzC31qHVU1gW2J3t?=
 =?us-ascii?Q?zMjVa3JjtNmB+9NptSxTbEvn+eFAi67JSLSSHDEo3+Rn6gRIpMXe1BFhceaP?=
 =?us-ascii?Q?ABBTFjow7Ppcswpj1hSrYwXMGyo0lDU/m9DiRwwu6he/asCDOzbuLxlZun3H?=
 =?us-ascii?Q?7aew8zxQ6ETfD9840LdsbEDedTq0FlQbYmcpbabRoAX/g7Z4L+8V/4jzDDk/?=
 =?us-ascii?Q?308qUV2GNIEx0zjk1hyUy2fYgeZ7YKCcn3vAGHDMQNpFsOtln6SIdnxTgYuH?=
 =?us-ascii?Q?CcouiqTGBPdLTHSFd1n8TCwHEInNCPPU/2zBMB2rjPX47nN3yETF7eePCRKd?=
 =?us-ascii?Q?grjxqDyRwyMdLOlH/6eLytQjR8LCA2m2Q0+sAnHi1G3XaY5NOxdpjqdeHg+M?=
 =?us-ascii?Q?XlEhX+fexrOAv958t8htOcno+nAgLG6N/juJinXmXoqzoXvObQp8Ofcl4sEc?=
 =?us-ascii?Q?n7C1qEudoOtbDKCU/uQWI1imFrVFNdFvDMh96vO/6H8HcytH1fzt8nHSd9By?=
 =?us-ascii?Q?pdkjNevbTOvOkLdvEFV8IUBBrLDLS7hMFzeQ4H0u/sEsxbyuj9+rW0ulVOsR?=
 =?us-ascii?Q?qZ3LmaGFbpXmYXbVddiKmIKdgRKYLVKZrrGBlOvv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c6bb10-0c3e-40f0-791f-08dd1ff302ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 06:04:34.5645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgV+J5jkUdBw/krsRlcC79crJ/GBZl/bXx3V08oRC/8PpkoTaSauhyRr2KxncgC8/vXyR13ONXLbnAGmzYupuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032

ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
and UDP transmit units into multiple Ethernet frames. To support LSO,
software needs to fill some auxiliary information in Tx BD, such as LSO
header length, frame length, LSO maximum segment size, etc.

At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
CPU performance before and after applying the patch was compared through
the top command. It can be seen that LSO saves a significant amount of
CPU cycles compared to software TSO.

Before applying the patch:
%Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si

After applying the patch:
%Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
v4: fix a typo
v5: no changes
v6: remove error logs from the datapath
v7: rebase the patch due to the layout change of enetc_tx_bd
v8: rebase the patch due to merge conflicts
v9: 
1. Remove 'inline' from enetc_lso_count_descs()
2. Fix the off-by-one issue in enetc_lso_hw_offload()
3. Add comments for the frm_len and frm_len_ext in enetc_lso_map_hdr()
4. Improve the setting of single bits in txbd
5. Add ENETC_TPID_8021Q to define the CTAG TPID
6. Remove 'unlikely' in the check for dma_mapping_error()
7. Use the new skb_frag_dma_map() with two args.
8. Remove ENETC_1KB_SIZE
9. Add prefix to the bit macros of SILSOSFMR1 register
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 264 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  14 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  23 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  16 +-
 .../freescale/enetc/enetc_pf_common.c         |   3 +
 5 files changed, 310 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 76c33506991b..6a6fc819dfde 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -532,6 +532,230 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 	}
 }
 
+static int enetc_lso_count_descs(const struct sk_buff *skb)
+{
+	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
+	 * for linear area data but not include LSO header, namely
+	 * skb_headlen(skb) - lso_hdr_len (it may be 0, but that's
+	 * okay, we only need to consider the worst case). And 1 BD
+	 * for gap.
+	 */
+	return skb_shinfo(skb)->nr_frags + 4;
+}
+
+static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
+{
+	int hdr_len, tlen;
+
+	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
+	hdr_len = skb_transport_offset(skb) + tlen;
+
+	return hdr_len;
+}
+
+static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
+{
+	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
+	lso->ipv6 = enetc_skb_is_ipv6(skb);
+	lso->tcp = skb_is_gso_tcp(skb);
+	lso->l3_hdr_len = skb_network_header_len(skb);
+	lso->l3_start = skb_network_offset(skb);
+	lso->hdr_len = enetc_lso_get_hdr_len(skb);
+	lso->total_len = skb->len - lso->hdr_len;
+}
+
+static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso)
+{
+	union enetc_tx_bd txbd_tmp, *txbd;
+	struct enetc_tx_swbd *tx_swbd;
+	u16 frm_len, frm_len_ext;
+	u8 flags, e_flags = 0;
+	dma_addr_t addr;
+	char *hdr;
+
+	/* Get the first BD of the LSO BDs chain */
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	/* Prepare LSO header: MAC + IP + TCP/UDP */
+	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
+	memcpy(hdr, skb->data, lso->hdr_len);
+	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
+
+	/* {frm_len_ext, frm_len} indicates the total length of
+	 * large transmit data unit. frm_len contains the 16 least
+	 * significant bits and frm_len_ext contains the 4 most
+	 * significant bits.
+	 */
+	frm_len = lso->total_len & 0xffff;
+	frm_len_ext = (lso->total_len >> 16) & 0xf;
+
+	/* Set the flags of the first BD */
+	flags = ENETC_TXBD_FLAGS_EX | ENETC_TXBD_FLAGS_CSUM_LSO |
+		ENETC_TXBD_FLAGS_LSO | ENETC_TXBD_FLAGS_L4CS;
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	txbd_tmp.addr = cpu_to_le64(addr);
+	txbd_tmp.hdr_len = cpu_to_le16(lso->hdr_len);
+
+	/* first BD needs frm_len and offload flags set */
+	txbd_tmp.frm_len = cpu_to_le16(frm_len);
+	txbd_tmp.flags = flags;
+
+	txbd_tmp.l3_aux0 = FIELD_PREP(ENETC_TX_BD_L3_START, lso->l3_start);
+	/* l3_hdr_size in 32-bits (4 bytes) */
+	txbd_tmp.l3_aux1 = FIELD_PREP(ENETC_TX_BD_L3_HDR_LEN,
+				      lso->l3_hdr_len / 4);
+	if (lso->ipv6)
+		txbd_tmp.l3_aux1 |= ENETC_TX_BD_L3T;
+	else
+		txbd_tmp.l3_aux0 |= ENETC_TX_BD_IPCS;
+
+	txbd_tmp.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T, lso->tcp ?
+				     ENETC_TXBD_L4T_TCP : ENETC_TXBD_L4T_UDP);
+
+	/* For the LSO header we do not set the dma address since
+	 * we do not want it unmapped when we do cleanup. We still
+	 * set len so that we count the bytes sent.
+	 */
+	tx_swbd->len = lso->hdr_len;
+	tx_swbd->do_twostep_tstamp = false;
+	tx_swbd->check_wb = false;
+
+	/* Actually write the header in the BD */
+	*txbd = txbd_tmp;
+
+	/* Get the next BD, and the next BD is extended BD */
+	enetc_bdr_idx_inc(tx_ring, i);
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	if (skb_vlan_tag_present(skb)) {
+		/* Setup the VLAN fields */
+		txbd_tmp.ext.vid = cpu_to_le16(skb_vlan_tag_get(skb));
+		txbd_tmp.ext.tpid = ENETC_TPID_8021Q;
+		e_flags = ENETC_TXBD_E_FLAGS_VLAN_INS;
+	}
+
+	/* Write the BD */
+	txbd_tmp.ext.e_flags = e_flags;
+	txbd_tmp.ext.lso_sg_size = cpu_to_le16(lso->lso_seg_size);
+	txbd_tmp.ext.frm_len_ext = cpu_to_le16(frm_len_ext);
+	*txbd = txbd_tmp;
+}
+
+static int enetc_lso_map_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso, int *count)
+{
+	union enetc_tx_bd txbd_tmp, *txbd = NULL;
+	struct enetc_tx_swbd *tx_swbd;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	u8 flags = 0;
+	int len, f;
+
+	len = skb_headlen(skb) - lso->hdr_len;
+	if (len > 0) {
+		dma = dma_map_single(tx_ring->dev, skb->data + lso->hdr_len,
+				     len, DMA_TO_DEVICE);
+		if (dma_mapping_error(tx_ring->dev, dma))
+			return -ENOMEM;
+
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 0;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	frag = &skb_shinfo(skb)->frags[0];
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++, frag++) {
+		if (txbd)
+			*txbd = txbd_tmp;
+
+		len = skb_frag_size(frag);
+		dma = skb_frag_dma_map(tx_ring->dev, frag);
+		if (dma_mapping_error(tx_ring->dev, dma))
+			return -ENOMEM;
+
+		/* Get the next BD */
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 1;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	/* Last BD needs 'F' bit set */
+	flags |= ENETC_TXBD_FLAGS_F;
+	txbd_tmp.flags = flags;
+	*txbd = txbd_tmp;
+
+	tx_swbd->is_eof = 1;
+	tx_swbd->skb = skb;
+
+	return 0;
+}
+
+static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
+{
+	struct enetc_tx_swbd *tx_swbd;
+	struct enetc_lso_t lso = {0};
+	int err, i, count = 0;
+
+	/* Initialize the LSO handler */
+	enetc_lso_start(skb, &lso);
+	i = tx_ring->next_to_use;
+
+	enetc_lso_map_hdr(tx_ring, skb, &i, &lso);
+	/* First BD and an extend BD */
+	count += 2;
+
+	err = enetc_lso_map_data(tx_ring, skb, &i, &lso, &count);
+	if (err)
+		goto dma_err;
+
+	/* Go to the next BD */
+	enetc_bdr_idx_inc(tx_ring, &i);
+	tx_ring->next_to_use = i;
+	enetc_update_tx_ring_tail(tx_ring);
+
+	return count;
+
+dma_err:
+	do {
+		tx_swbd = &tx_ring->tx_swbd[i];
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	} while (--count);
+
+	return 0;
+}
+
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
@@ -652,14 +876,26 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	tx_ring = priv->tx_ring[skb->queue_mapping];
 
 	if (skb_is_gso(skb)) {
-		if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
-			netif_stop_subqueue(ndev, tx_ring->index);
-			return NETDEV_TX_BUSY;
-		}
+		/* LSO data unit lengths of up to 256KB are supported */
+		if (priv->active_offloads & ENETC_F_LSO &&
+		    (skb->len - enetc_lso_get_hdr_len(skb)) <=
+		    ENETC_LSO_MAX_DATA_LEN) {
+			if (enetc_bd_unused(tx_ring) < enetc_lso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
 
-		enetc_lock_mdio();
-		count = enetc_map_tx_tso_buffs(tx_ring, skb);
-		enetc_unlock_mdio();
+			count = enetc_lso_hw_offload(tx_ring, skb);
+		} else {
+			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
+
+			enetc_lock_mdio();
+			count = enetc_map_tx_tso_buffs(tx_ring, skb);
+			enetc_unlock_mdio();
+		}
 	} else {
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
@@ -1799,6 +2035,9 @@ void enetc_get_si_caps(struct enetc_si *si)
 		rss = enetc_rd(hw, ENETC_SIRSSCAPR);
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
+
+	if (val & ENETC_SIPCAPR0_LSO)
+		si->hw_features |= ENETC_SI_F_LSO;
 }
 EXPORT_SYMBOL_GPL(enetc_get_si_caps);
 
@@ -2095,6 +2334,14 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
 	return 0;
 }
 
+static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
+{
+	enetc_wr(hw, ENETC4_SILSOSFMR0,
+		 SILSOSFMR0_VAL_SET(ENETC4_TCP_NL_SEG_FLAGS_DMASK,
+				    ENETC4_TCP_NL_SEG_FLAGS_DMASK));
+	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2108,6 +2355,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		enetc_set_lso_flags_mask(hw);
+
 	/* TODO: RSS support for i.MX95 will be supported later, and the
 	 * is_enetc_rev1() condition will be removed
 	 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 1e680f0f5123..4ad4eb5c5a74 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -41,6 +41,18 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_lso_t {
+	bool	ipv6;
+	bool	tcp;
+	u8	l3_hdr_len;
+	u8	hdr_len; /* LSO header length */
+	u8	l3_start;
+	u16	lso_seg_size;
+	int	total_len; /* total data length, not include LSO header */
+};
+
+#define ENETC_LSO_MAX_DATA_LEN		SZ_256K
+
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
 #define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
@@ -238,6 +250,7 @@ enum enetc_errata {
 #define ENETC_SI_F_PSFP BIT(0)
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
+#define ENETC_SI_F_LSO	BIT(3)
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -351,6 +364,7 @@ enum enetc_active_offloads {
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_TXCSUM			= BIT(12),
+	ENETC_F_LSO			= BIT(13),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 26b220677448..695cb07c74bc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,29 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 
+/**********************Station interface registers************************/
+/* Station interface LSO segmentation flag mask register 0/1 */
+#define ENETC4_SILSOSFMR0		0x1300
+#define  SILSOSFMR0_TCP_MID_SEG		GENMASK(27, 16)
+#define  SILSOSFMR0_TCP_1ST_SEG		GENMASK(11, 0)
+#define  SILSOSFMR0_VAL_SET(first, mid)	(FIELD_PREP(SILSOSFMR0_TCP_MID_SEG, mid) | \
+					 FIELD_PREP(SILSOSFMR0_TCP_1ST_SEG, first))
+
+#define ENETC4_SILSOSFMR1		0x1304
+#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
+#define   ENETC4_TCP_FLAGS_FIN		BIT(0)
+#define   ENETC4_TCP_FLAGS_SYN		BIT(1)
+#define   ENETC4_TCP_FLAGS_RST		BIT(2)
+#define   ENETC4_TCP_FLAGS_PSH		BIT(3)
+#define   ENETC4_TCP_FLAGS_ACK		BIT(4)
+#define   ENETC4_TCP_FLAGS_URG		BIT(5)
+#define   ENETC4_TCP_FLAGS_ECE		BIT(6)
+#define   ENETC4_TCP_FLAGS_CWR		BIT(7)
+#define   ENETC4_TCP_FLAGS_NS		BIT(8)
+/* According to tso_build_hdr(), clear all special flags for not last packet. */
+#define ENETC4_TCP_NL_SEG_FLAGS_DMASK	(ENETC4_TCP_FLAGS_FIN | \
+					 ENETC4_TCP_FLAGS_RST | ENETC4_TCP_FLAGS_PSH)
+
 /***************************ENETC port registers**************************/
 #define ENETC4_ECAPR0			0x0
 #define  ECAPR0_RFS			BIT(2)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 0e259baf36ee..4098f01479bc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -25,6 +25,7 @@
 #define ENETC_SIPCAPR0	0x20
 #define ENETC_SIPCAPR0_RSS	BIT(8)
 #define ENETC_SIPCAPR0_RFS	BIT(2)
+#define ENETC_SIPCAPR0_LSO	BIT(1)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
 #define ENETC_SIRBGCR	0x38
@@ -554,7 +555,10 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
 union enetc_tx_bd {
 	struct {
 		__le64 addr;
-		__le16 buf_len;
+		union {
+			__le16 buf_len;
+			__le16 hdr_len;	/* For LSO, ENETC 4.1 and later */
+		};
 		__le16 frm_len;
 		union {
 			struct {
@@ -578,13 +582,16 @@ union enetc_tx_bd {
 		__le32 tstamp;
 		__le16 tpid;
 		__le16 vid;
-		u8 reserved[6];
+		__le16 lso_sg_size; /* For ENETC 4.1 and later */
+		__le16 frm_len_ext; /* For ENETC 4.1 and later */
+		u8 reserved[2];
 		u8 e_flags;
 		u8 flags;
 	} ext; /* Tx BD extension */
 	struct {
 		__le32 tstamp;
-		u8 reserved[10];
+		u8 reserved[8];
+		__le16 lso_err_count; /* For ENETC 4.1 and later */
 		u8 status;
 		u8 flags;
 	} wb; /* writeback descriptor */
@@ -593,6 +600,7 @@ union enetc_tx_bd {
 enum enetc_txbd_flags {
 	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
+	ENETC_TXBD_FLAGS_LSO = BIT(1), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_W = BIT(2),
 	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
@@ -663,6 +671,8 @@ union enetc_rx_bd {
 #define ENETC_CBD_FLAGS_SF	BIT(7) /* short format */
 #define ENETC_CBD_STATUS_MASK	0xf
 
+#define ENETC_TPID_8021Q	0
+
 struct enetc_cmd_rfse {
 	u8 smac_h[6];
 	u8 smac_m[6];
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 00b73a948746..31dedc665a16 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -123,6 +123,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->tx_csum)
 		priv->active_offloads |= ENETC_F_TXCSUM;
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		priv->active_offloads |= ENETC_F_LSO;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


