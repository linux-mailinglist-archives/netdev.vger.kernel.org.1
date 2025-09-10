Return-Path: <netdev+bounces-221823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1DFB52070
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA6E46659B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C9A2D23A5;
	Wed, 10 Sep 2025 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CudVA/ZK"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09D2D238B;
	Wed, 10 Sep 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530350; cv=fail; b=qCmkY0C8oG+SSjxn2987wtnOKawyThNFnxKx4CXbmJFx257+tY5N4gcZp+GsI9UzTvfvOI0tXdodlpUszHvqLZdDiQdxGNS+Fqi/2ecKjc47IzfEAqf4hRt6QRu4s1utwQRxCA5weND9B2k5zbIp/zDW2PUY2M0bU93ukxbHsVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530350; c=relaxed/simple;
	bh=VvPnIcpjMxeZt8jkaMwNTjV4LlKsSVmh0QObreQbdfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sXhg/9qSOQrSoxY1CXzQJ7l0ZYe3Rwn6+4YXEyW4pBucU3TNUikCCYsZ5XNygjiNqov89Y2BklfMkRu3Blmw2zFkJ+xSqoZc4ImVJ9PBRb1O+OSe3x4h8NDCLjZrazj8ZU2UqevVJpf0fgdpjeN3pC7W48WMMuCFC8wPw367YY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CudVA/ZK; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAfTrmlkWVrJ+vR/oSDCdvvkN3Fd4RxE/LN4OLjFkRhASqJ+8wujwPmn+oD2mpd4yCsguTq+7vU4aWn2Gn8lqidtoLyydeAOzMff3oy8ZSm3EdLaWgwVKRgM8jpNVb5ZpinwcMmQ4EPYgyzExiDufsAHZL9AthtjMwKxr3hqxCGdD3D9molpCEE45TXAebTjdKJevKwUafCb4FRbX3DQTj3MrXa6XFDXLY5cG/aMdViM7tRaYQME/FYE7+Nb7EhatsLFJsN5ekdgZ16lM5KOFHvWLP6eHkv8O3PK3pgByFIRNGwQNKT864LxRqAHsd/Na8/cGBZuRh320+orU3KbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4g396V6Tar2eww9VOD1rWCUsLZH5kTl2qG866MLlv0=;
 b=QnUsbY2t7Rsrg7FfDmX9VENWMJshWx5DllDNr4HevsRZMNG9zdiqVMGNz5K1xkgnL02Ywz04DNY1XxvDQ9W92vEku+Ir7pmEmEJFPSJKCzLkWl7BQ2Aul8Mb1nOYdwVknWmgI67wSyPmGjcA6Aos0LC/qJjkuQLQlA6DXbcLviNI3tw0kmS47pQBrCtDasGjpj0YwxllUaxhB2x5+nHioqpgSSDolhD7jX4tV4O+mk2mWmncBlntnxOmR17AMaw7yjNj3aYu6a+aJrPIwxjHSk8ILNTBa+XS66NHbNhF0ycgz3OZ5DWZg1wt0exRa7ETjTiJRZokP5N4eUf5YZP1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4g396V6Tar2eww9VOD1rWCUsLZH5kTl2qG866MLlv0=;
 b=CudVA/ZK7bOMqnb4Sox7n6MgV6uI/eR43SN+ST6gXGux2fR1Jyma+MuDdQfKxeiQyuwb6v+/8nZZYmOHbG7kaASEz20UGE/uYpaR5U7WdcJCyd7L81rh+gztLOzlswubXnxlyoWSzhn8U5o8cpC/jTf8ZvGVUqUePXC5yDy8DJcJFFjclLkTgo+mXHvJe/8Fc91nexcAwijPUup2VeAcUYvhH4P2N8CoACPJ9/r7xtSwvoto5SbBgsNSQxdCbssFaAWsT6eZ5BdzxJggy3Pn1fXiq3YI3mvIrfZ5SIg0/xa3eKlpRHGqZTVB8UC4sbPx2atjOeVJOEH1jsWw1grboA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB7745.eurprd04.prod.outlook.com (2603:10a6:20b:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 18:52:24 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 18:52:24 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v7 net-next 0/6] net: fec: add the Jumbo frame support
Date: Wed, 10 Sep 2025 13:52:05 -0500
Message-ID: <20250910185211.721341-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132F4.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::39) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM8PR04MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a033f49-0628-49aa-7754-08ddf09b2dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zFTmY2xMefQavoqn2aUuOW31UI4bgwBIQuiaetxvOW9l464xxFOUgv+Zm8fd?=
 =?us-ascii?Q?6PH0JDPbz534NMb93LKsoDcr6oXzs/vCrK0WwnyEF7FGJ/6nbGpWCXKlFAye?=
 =?us-ascii?Q?Fm4UAa2rlBWq/eZOVVm3lu54hbG5hcLGjoonN3NUJzBmvM0bW2bPEzU/zB4J?=
 =?us-ascii?Q?ngEDkxaBnEk5zx3ET2+TFvJKqfgwFHiZrd0L73itCrUw/gP490Tc/T2VqZl+?=
 =?us-ascii?Q?Oz2vlPqxWDVIj9bx1cjM4sgPxQAbIF4LgVzr4I6DVpDW2ZHcONWDp7qNvQyI?=
 =?us-ascii?Q?XkbKAlUTLfhWCJqPGDaiLYovL0L9qktoDuVe0iO7sk1VCUMc3d3Qob4XIyXf?=
 =?us-ascii?Q?6syOUmcF+Y9+p3BlgTFDWFA1//R1iGYOwJSeOWgd0SARMIo1YosCUdx5RGQO?=
 =?us-ascii?Q?5TwoUasjfKkd4O2a79Nnxcp2KrIs1+Gc80sgo6u5Ii3jryg8KwIxFhlvZgsO?=
 =?us-ascii?Q?ZXZ+kuOOAx+kOxxK6g9EXswsTo6kLZS9G9r6j/y5WxbsvwxA/iSfXgAhak3X?=
 =?us-ascii?Q?nP0oW/xLrnvZgCrkmqCHT2WK0fWaZYIOXx7dxWZ6lq709/YfRwEHZH5/vMKe?=
 =?us-ascii?Q?bxVSqKMypYCHNvPLCRymjtbu8IPTfs4YhssDtOlriBVtiUUONrooLS/07um8?=
 =?us-ascii?Q?4F7jALYfR8iqBktn/sI8rGuLAcJBG4YUeE04INP5hb3Nty831bT0djRS89FD?=
 =?us-ascii?Q?CV10BohHYXXMQDdLarFnBLId09Q7qFkduAScoWdiXv6dJi9TTy3o/VC0LduI?=
 =?us-ascii?Q?YBUQ5fmL734WmNcqGev6X9LPW2n30XNco2QG9oA+zYPJsTfTNxHjXmtAGiqF?=
 =?us-ascii?Q?wdxTu1aZkeQHtcYqMb+7XYE3vFW1ld/LFGy7YSy2CWL/rx4fDQXeoWUvqBqk?=
 =?us-ascii?Q?F65O5b5NJg3KxH4wot9X0CtzWtBY/V0VmsyLCIAL3kb5w2TmOqey6HTFH2xY?=
 =?us-ascii?Q?9oRRz6KDu2LZZ8JoLJWQ8vjFKeMUUa5QleMaKZjkLA9iJSxKxPyRRfbU3yh7?=
 =?us-ascii?Q?W0IholZD54Q/8JJvnDjY3bcKMR9/iizP/jDEzEFGs25ZAAQfx+DnhjUJA6ss?=
 =?us-ascii?Q?ePhIQ4nZzDRzehNBBF3QBDP894Lg06hDblQ1WlyNxiosxTsv7SoAibS0EEZG?=
 =?us-ascii?Q?Q7uvzaRgWGGI88cBONmgd1gTGOMXTwxu9WatuvHPUMVG+X+S4HO8KTUc7ZFg?=
 =?us-ascii?Q?cFo/wvKzPqkzoIFDlQKW1SfIZgCuiAH8LERxhd95EPczlWvjWP2SCS85eNRI?=
 =?us-ascii?Q?j151RaSIwR9dqb1exxQ7ln7g5twOgE01QWPmDjTmdQYg9hicPAeCy7rAjd/W?=
 =?us-ascii?Q?S+5BwULry87HhynTyEoFuPe3K26dvlqfkaWgi8Cbr4N/Ju7ZjKrSTjhzTQkl?=
 =?us-ascii?Q?dH/A78lxWNYS0ADmKyrftw7nAGSUpCbDgx4KFqFxS6ZZVectPM63ZEcp7CZn?=
 =?us-ascii?Q?bxrLg8dAGdvY735vO19CV8fNrrD4QrftD/pIehcGwKyWsHOZZor6ZZBH1IIS?=
 =?us-ascii?Q?78BnfszR1LU6oow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eOtblE64v9BPInkrRmEc9bj7r/bJQX2/WB4Z68TZ/o5l7gAOV0wYQnqqr1cu?=
 =?us-ascii?Q?xK4X77Yl4F8lV1LDrYItCLct7oorWrzd7YV8GfsM3K9H7qLzNvLITxeU6tEw?=
 =?us-ascii?Q?jLFWILG/zLPGQmgSS24glAKRQRLalSNV0dQ62ZwWLmBZttXkwLQzNXsTEZ+7?=
 =?us-ascii?Q?CRD/OfQwbMiSMM6ZJ6TSmHtxXCgGif+AXr4kfViR/i3pu1hVyxIDinK5c5x0?=
 =?us-ascii?Q?2alyLfiOyrxuGZN84eaypNTsUhH9pwqkmGjCvv2VWZc+Gor/3f3mseqPcefk?=
 =?us-ascii?Q?xXCJEN7LW4T4tM1xTRpJDOV+o6QRpnbaKzntJ5kH8niBokF4Xq/0c/NuJ2gV?=
 =?us-ascii?Q?HpOHrLCJXvFJcBMaXe+/qtZIR/3Slphyvw3OkyLZr+NyYHe3I6W7DYPjlHdI?=
 =?us-ascii?Q?b/6sts/5Q9I6SX82WtP4wv90g/zYeV9xwjySy4thcyvvWC8JvUvaVbMy9Nh+?=
 =?us-ascii?Q?toVwZRI5SnQFWYlCXS5Ck/GNG4AfUza//ZmytzTqHIN8L873bk9xceSW72MP?=
 =?us-ascii?Q?MH557CY0g60hENFUPKZ0uKX3oCD6MCG1XAUloboKPBlONH94zFczr+y2u8ki?=
 =?us-ascii?Q?dahNuUGBIJWVygS5whmsZNu+kG/hN/bC9Eg0Rsp0kHmBAtFMtRyAl7GINd25?=
 =?us-ascii?Q?akIQwj2GYVsignRj8Ja+MlegaCyN4cNfoHlxXbdUnQdpbHFBB1uXtgWFdN8x?=
 =?us-ascii?Q?MSIJbAp3BWhseoEoXV1SQj7JMxGG/xiDQ6zDQavyk75FNUp+f0Nqaw5ZwqmM?=
 =?us-ascii?Q?NerItZmQr590Jjp2H3wgWu0M7DbDTw/iOoiyKokzgA8DGTZr9/u0oYs7VGmg?=
 =?us-ascii?Q?Fk+vt8tdorJVi0gELW4ImLAC+FHQg4s0bRm++uTS0M8cLPUplF483KGXG2oC?=
 =?us-ascii?Q?2gtEZIlkOlqTUAexp51ktembGbgd2YAIY1kARqAhGsVbukg8fmXI5n5LV9nm?=
 =?us-ascii?Q?ZC8i1GhKC0GOFresGzhLTWKVVezKGKuXBaLLEkqVOnSpUNsSCIzX353psG75?=
 =?us-ascii?Q?h68grft82N7n3QzvXdugChWHGJ1VNeh2YK+6n5zmjrxArbtjkzkL7rZxoLhs?=
 =?us-ascii?Q?0KdfkAUqwroNYcLO9NyI1yRLGbjZNWfRSWfnF4ISf7VV/84mIHzsViE20yaR?=
 =?us-ascii?Q?5cXw87h3oJUBKWxKS2+E0M3u2VBmJUpr2QFMwFFVG5z5fbkKREoGbadEasFS?=
 =?us-ascii?Q?SYOwk7e3UqbZL01UZ/t9AWo2MTnFXUc2Vj4+wZqqI/kxh3z3ZuK4HyPMIfl+?=
 =?us-ascii?Q?+jwU146Gaw7YO37ecnYQLRAA4EKu5H3JnXUrySUCpB89In1xtf3dZZX1zBtM?=
 =?us-ascii?Q?G5+ZH2ti0O5B97uS07Fz8ICA3vuamk1ZngXNF9slh3EeaoZ9105zNPd7sc7b?=
 =?us-ascii?Q?kJxcvdDgxy3fCURekeXYl/yyIM6c4brIEHg+imLyOBZh877966S7G70vAIoA?=
 =?us-ascii?Q?7xgJzXywk13/PyOynujgjLss73hcRgkbegTJ6/MgQX19FWaczsXklJiQtd5Q?=
 =?us-ascii?Q?7mP4kivpu7iEc/hTvP2IdzROL8HsGmEAb+HOqcYm1an84U6DFadiTQur5dAV?=
 =?us-ascii?Q?PgVWxHcYInIEEx/wwP0mNNBqKCe/7I3VlSVPxgFQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a033f49-0628-49aa-7754-08ddf09b2dfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:52:24.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+fRnL6LVFNMMVwi68JM7e5V0j2i08Xda/o2NLm4ijtwXTBzn8G9osmitoNlRwHwwG8qaVD58n4mctQbE7rVSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7745

Changes in v7:
 - replaced #ifdef with if statement per Jakub's suggestion.

Changes in v6:
 - address the comments from Frank and Jakub.
 - only allow changing mtu when the adaptor is not running, simplifying
   the configuration logic.

Changes in v5:
 - move the macro FEC_DRV_RESERVE_SPACE to fec.h
 - improve the comments for patch #0004

Changes in v4:
 - configure the MAX_FL according to the MTU value, and correct the
   comments for patch #3.
 - in change_mtu function, revert to original setting when buffer
   allocation fails in patch #4
 - only enable the FIFO cut-through mode when mtu greater than
   (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN)

Changes in v3:
 - modify the OPT_FRAME_SIZE definition and drop the condition logic
 - address the review comments from Wei Fang

Changes in v2:
 - split the v1 patch per Andrew's feedback.

Shenwei Wang (6):
  net: fec: use a member variable for maximum buffer size
  net: fec: add pagepool_order to support variable page size
  net: fec: update MAX_FL based on the current MTU
  net: fec: add rx_frame_size to support configurable RX length
  net: fec: add change_mtu to support dynamic buffer allocation
  net: fec: enable the Jumbo frame support for i.MX8QM

 drivers/net/ethernet/freescale/fec.h      | 11 +++-
 drivers/net/ethernet/freescale/fec_main.c | 68 ++++++++++++++++++-----
 2 files changed, 64 insertions(+), 15 deletions(-)

--
2.43.0


