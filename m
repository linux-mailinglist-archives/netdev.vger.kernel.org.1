Return-Path: <netdev+bounces-239075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A66EBC638B4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE5423829F4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78532936D;
	Mon, 17 Nov 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nYcSyBAp"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCF328B45;
	Mon, 17 Nov 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374737; cv=fail; b=Ki9xEBvcVXlP5MlxEXm9zeL5FQ7dKgCbLuIXlu1Hx9Ar1YDuH7EZ8noyjmTup740T9gjNOyCzb6rwO3W8/d0uouIBf5MF+MyCT5AFd3xyVpKGm57zYDeIY6ZBSm1nq1pPEodrpVF967KnlwsYPSFMA3CcZCL+xrFrDhIyR/JCUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374737; c=relaxed/simple;
	bh=izUaefAYvtFtCCc+ETQqJwMWUzSJXomMpmHzS5RKbEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJsPzLijG6nHq0qWnmcFMfP2a8bxhI61lVNR5PvCkiqGTtjfLMk8bqyxcqwQAobzGeYZwrAY/gtxU7htVpYI+NrDPfWQ+HN/D/WNQSbxfrhtYmjLpOwdESS86lC8iXY9wYa3ibm40+oEjPjoM7OHtQF/06HIRkx+MgBY/MG3UgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nYcSyBAp; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEiVV+uDGvN5/YQ7Ix1CgB4Tk/puLrVpY9oimp+/3FZXlnNCxBAYY9TOXiCbIIvoPMGnlYowCozlU/A1uqfv8tGpUmCPtzt5QPElkYU78QNoUpgmfp00802LS57PZ9UyToWBmYJrqpKOwHSyzpv2BngtnQ+Ev4CefwK1KAX5DSCNI6RCqE7r6KbH97KM7Un2f6AfBMX2l7atmzq2qaw+LYJ1wtCEjFqRl311x2eVG1nEkTOMTS6lWkwnYDol8PKECZGxb/O2wyYrT4GsQAuVJL9YCtpafyQQepG5qusM4oXa9U2v7+otc2QtVF1LV0YhiUmOGeKM23Hgzmj0IhZDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC6hxeuWEVhX2mXBhrQ3xu3O+zwhEHvY0Vh0tf0HZd8=;
 b=GTsZf4sfirUzDZ+useQYIh03xT4zdX/e0d3w03EC2NQuVMOEo79in7HY1rSk9GX5bKxW6QMJRgrpdLgTku4fYKzA4MtEd5K22tYnu9CrHNuAUqNTzN6a3bb44vnFKS0A98Lf0ZRcENKseYvX0suymAsBV8Tb78v+6C2YgufqNmxxWCg5pJP/PBFXAAMryfIQXKah0P2DKtvD46My4YXFuZT0ZGpdGEpaLDY7GmuRYEfCt+DkzQtfYXG6twDEGng2zyhQlmpKazoy70xYTZUuW9xuMVDjUKGK4TxVr+3RTzQZFW8xYUR5d8k5raEKrEI8+Z3l9Z3BF7cSCrOk8ckBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC6hxeuWEVhX2mXBhrQ3xu3O+zwhEHvY0Vh0tf0HZd8=;
 b=nYcSyBApqlRt9pkPOlK6AIEtfbOmZWXGT6U/43XxDU88rBPe01YjXfSyFfhC2YpftDhAPWnDn7OT3dgk94fVUK54JurmyiHCPWFOTKNWvetJ1tQ++o6v6yLgKAlf/AW2ulw48lMgSI3+6DKE7foK2v0ptgZkefitZOkuB5S135acJW4jKfhYExc3VqnVP/z5DEptZgBSmTdu5RcD4CJp/1WJDZmyFx0nfmqHiMg23SLLKEE4dZ+S4Ld68PgefaFDPFYtpmCntpka6QH2Sixpe7nL73svusVQyIgWsCZHWCM7tqhHg+jFAV/bW024UtkXzXEW5e/pvMPSlIabrko1HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8311.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 10:18:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:18:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 3/5] net: fec: remove struct fec_enet_priv_txrx_info
Date: Mon, 17 Nov 2025 18:19:19 +0800
Message-Id: <20251117101921.1862427-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117101921.1862427-1-wei.fang@nxp.com>
References: <20251117101921.1862427-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: a772d713-d05e-4f14-b1fe-08de25c2b5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ilG7fC1j5C5MgVnDTj9RwT0vieXsaub5MDjnt9FpQyhSpVDDkUtwAHEqIpRy?=
 =?us-ascii?Q?lJbpsUwBcryGmp2hiOUqY8866b0dHyetvCjqsKPpmrca5GD8SdVl1sCjP0LK?=
 =?us-ascii?Q?5f9osIwjVId+KG1GpML9/cNEq/0UnLj7tS0E1qWoVRXGiNN0m3QhO7oE8t+I?=
 =?us-ascii?Q?h+aGJ20nrX6jJPJMWzR7Dl+9UeWMjf9cUFuBHk/AGz1Ued7Op38g8t0wnTKf?=
 =?us-ascii?Q?64xsuZXAzy7w18+E3RfsPHPGF8k7vSEYm+tZ+37w3dmwJJ0kU/xs5Pr/KJzx?=
 =?us-ascii?Q?pa6iYc6vyOjOtgUA2SapX1x4ybUYquZ+Kx2hDG2yuaowWUnQIEYgr3dXdyX4?=
 =?us-ascii?Q?cjMbfOIcEyQFfhKh9Idbn+ay6wGYRTGXJeArN4adFk4MYE0TzQxjHXpYi4zD?=
 =?us-ascii?Q?qfSMvivSp3zH4kkQb71VuiYrJdkJ6kQFaEJdskQOGrJe3Z6zAKLL8kBBBm5l?=
 =?us-ascii?Q?BuvroTkjKf3x1Tc5lt4s9Wx78+17IBYiCkPEpPNNLuTozu1eXMyITI6rH+CG?=
 =?us-ascii?Q?9b2uHe2Jj64P0JYAm/iv7vV/WmzXyEmL8vv8Fsi4IDTr0WiuCgXJcJt3EY2A?=
 =?us-ascii?Q?L6X8lN2MBFvZm+4anSW2RhsD38YCHMkeIfs5UV/5gT6ZbNSkmedzZP319dD7?=
 =?us-ascii?Q?U7SnlwZgg6tj9cKTtX/U4LXMUa4vtYJIHBl5QEsgGG9XTX+PYeK8OntwPMTV?=
 =?us-ascii?Q?r/5hynMtgaLLPWKJWvnNNME+oIf28HukUeM15xHcUWHBZvmnkZEwmYmKaqgS?=
 =?us-ascii?Q?trfFq3Rf61a1ICAqt4/xHZKW+7AzRV/+mjHRW8qahougASEbzisFgnqKDFBK?=
 =?us-ascii?Q?pSLWv0SqvSX2K394HQkKZ4tS5UJllnCAB8c5I7SYILkz5e5B/w27J0GwTd2Z?=
 =?us-ascii?Q?Vju5fnNjTyzPrp+7gsR0Z2EEfg1IV/h/GN9zTp/JyEgD2qrA5yvMoqZtIi0k?=
 =?us-ascii?Q?fDUBImgz0Ki/1lmVgpn6StpU5OENN5xIb3eAMEpKPnNKUJdRp84nF3COEonQ?=
 =?us-ascii?Q?gee+3wezeG0aYFZZkEvoQiG8Qd9eU5F4pY+Z6ImLV6RQl0+HfUTYVCNY0lPR?=
 =?us-ascii?Q?3ZzmisaO0TxGuOkP51Rw0uqFPqCcLQVhRaYwCA+JkhxJnQ6/3k1souUC0PxE?=
 =?us-ascii?Q?QRwGcdXzp7rXrCYH/oPue/uGouKgM3WZ91dR5E95LUiNR4Tz4KQj6WZRlBFs?=
 =?us-ascii?Q?4F6y8CbvW42kZKZCK2tCJyMMV1O8hQjmM3MhKCQTQ+y5RcsbHTDBPKyZIcEK?=
 =?us-ascii?Q?lfEpvhXz7LJsui2iUFHevIWMhZNa6yVJeEVf72Rkq1mB9HTehdwW1z2Ay6f4?=
 =?us-ascii?Q?1V9UJpfuQW2vqwOfA4mbntdmLNvcTWFL9C8j82h/Rm1d5HxXwC+PbnA3vzRK?=
 =?us-ascii?Q?0KU9zB5VlMtueQ7d48PcQYQpy1zh/Zgj1iPB8o9Ie5VDWDvdNiqwETjz0dZs?=
 =?us-ascii?Q?wrE2D4h3QoesAYMyOwZMicPrmBx543trs95IVD8lgNl5imhXhyklV5WX90z8?=
 =?us-ascii?Q?YG2YWBpWDGoZmJf5/wBd95Uv07egRcGQRB+a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQfE8H3j5lhOuX7wjcNSmGQTCiH60X1MqtaWVYKEyvmwy7yGieKuGsdbEW8O?=
 =?us-ascii?Q?XAtoTcb65xfIiilhU8Shnl/FiBjYWsbhRG1JtipfC96UKb+ekcOuzSoxoWbV?=
 =?us-ascii?Q?BTSP8GEBdvzFu9MNYZYBKhXpSwi9vbwrc8nl6MReBhgPfcDvpzvB6D5A7ACE?=
 =?us-ascii?Q?lMSmsgNgd5p00mVag8riDerUQse5HFy6AckwFbfNriU8gkrmi6Vv2okAiSO4?=
 =?us-ascii?Q?dyht9VE2EYM9L8UyW46N9T6p4RPsQoj7YXbWlpkikrotkm5MMNA0RhiJ8g01?=
 =?us-ascii?Q?irOpOKLDHQvENVWZ9mD3alJWXNDfFsIf65JQhMXZP4ysXlFPKBT343G9lUY4?=
 =?us-ascii?Q?WiJT/w7oqKa1e3ud1gUIPmHJCix79HJy3Q+hXLBYgwZcnIfZGefj9mkoshdA?=
 =?us-ascii?Q?EQUWtUnSsXM69zZpSBUB0DmX12On5VdK3A3Gf9oaIYC1vb0jfRw3XvvAsEBY?=
 =?us-ascii?Q?1IecxySeKhFTHkZjWoPaKXvnmeFdfVOBzEYFR2xMJ4bR+wG0GxiHHg2vvm6J?=
 =?us-ascii?Q?/aGYDmxwdUNv8MQTEYykHFw9xKQ7883iX0hxJEqhf9dczZvu64beBCLQpRwh?=
 =?us-ascii?Q?XamFyYgLW14s0tyWUOuxIPE+L4QJ1BPO2Dp6UT55j2jJ4L6Dw1f7Jx/mqVxH?=
 =?us-ascii?Q?+igSAikKWXM7eUCrolIVq1jWIjrVnQKtUoTxNP3BXIcdlK7pWduQNmmiPEao?=
 =?us-ascii?Q?NLvEQAlxZCnTwer4FvV6x/fLfEoI43mH4Ak+HlVl3yl6DkVvBMbvGw1PuV2T?=
 =?us-ascii?Q?rsbh3AZj/Hy4tFYnRuaWRQ48iwUgvLgAmzvYg74HcfCcge3wmVYe8hzUPSp0?=
 =?us-ascii?Q?MOlekRGFp5UPE4/DZ67//e7HB4fyqDxBtAPH6gDl3tBAKbCjlQG6a6NBoOlJ?=
 =?us-ascii?Q?zxGGZvEckh0492R+9LTal8JM82tOuM5wu24GAOCRerBV9JCoERI1Vco0bsNi?=
 =?us-ascii?Q?MEXNJwEwazinoP21wy+cx+WzzxXCdWBoRnAT3ysSEZos73LzOqRnMkh7ZIOl?=
 =?us-ascii?Q?uSXWubABK3L8Gcg4841kCPwMtnca2qB7k1dJ+89gW7gOLtqJMHu+VQ3u9wCR?=
 =?us-ascii?Q?70gERoAm8kcgAKJOfDhK8+qzivXBzCke+KG3wiTknuqWwyestT89sZkMNN/x?=
 =?us-ascii?Q?USJqdQQdGtMGg9STHB+uTP+d5f/4q8P03XhNyFPeVQ6JBpwQpS6hJlJOq274?=
 =?us-ascii?Q?IpwOb6GgoJMlpmek3NFSW6yKwO/1DYZfk52ASdbM+1ABuEYg/xi8qi7hyWhC?=
 =?us-ascii?Q?tx0gpimO+c+u9eYg6whZ8nd54snCfTMxdHnRKyd63ZodMHgluVsRqb8nTPB0?=
 =?us-ascii?Q?pCQbZqNvCaei9PcMZUfZ6YhCTzZ1PAPPRnPcQZdBeQN3aOQaLyZEGtnPUiwn?=
 =?us-ascii?Q?efDqNAv1l/Gutoipq7KYJEkqWRfO4tKLU9Miuk1RfKW8+e42b0bgHiqe9GFi?=
 =?us-ascii?Q?UAWxw3ptcpfngLoz6aKxswVlzCwafh2tSLxWTlGTLMqNJz75oxJbZcftpVdl?=
 =?us-ascii?Q?A5l50idIDvnGCDMIBMzH3W2s/yV3IjtNtqfRjTgmmaXYN4YnQ7qkJrve67eO?=
 =?us-ascii?Q?JgfH2p9HSlbiG38wb2UyDuoKPD8dFrmzXjFzuHP/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a772d713-d05e-4f14-b1fe-08de25c2b5bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:18:53.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTq7NILLQneZqhpDvfMGCxjYrN/1p4nYuDDs5ml3FySoZJwbhpyZodseQBzAmCY4MxysS1PbujQTbHEiN4KqNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8311

The struct fec_enet_priv_txrx_info has three members: offset, page and
skb. The offset is only initialized in the driver and is not used, the
skb is never initialized and used in the driver. The both will not be
used in the future. Therefore, replace struct fec_enet_priv_txrx_info
bedirectly with struct page.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  8 +-------
 drivers/net/ethernet/freescale/fec_main.c | 11 +++++------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8e438f6e7ec4..c5bbc2c16a4f 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -528,12 +528,6 @@ struct bufdesc_prop {
 	unsigned char dsize_log2;
 };
 
-struct fec_enet_priv_txrx_info {
-	int	offset;
-	struct	page *page;
-	struct  sk_buff *skb;
-};
-
 enum {
 	RX_XDP_REDIRECT = 0,
 	RX_XDP_PASS,
@@ -573,7 +567,7 @@ struct fec_enet_priv_tx_q {
 
 struct fec_enet_priv_rx_q {
 	struct bufdesc_prop bd;
-	struct  fec_enet_priv_txrx_info rx_skb_info[RX_RING_SIZE];
+	struct page *rx_buf[RX_RING_SIZE];
 
 	/* page_pool */
 	struct page_pool *page_pool;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9cf579a8ac0f..1408e3e6650a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1655,8 +1655,7 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	if (unlikely(!new_page))
 		return -ENOMEM;
 
-	rxq->rx_skb_info[index].page = new_page;
-	rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
+	rxq->rx_buf[index] = new_page;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
@@ -1834,7 +1833,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		ndev->stats.rx_bytes += pkt_len;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_skb_info[index].page;
+		page = rxq->rx_buf[index];
 		cbd_bufaddr = bdp->cbd_bufaddr;
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
@@ -3309,7 +3308,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
 		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_skb_info[i].page, false);
+			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
+						false);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
@@ -3443,8 +3443,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
-		rxq->rx_skb_info[i].page = page;
-		rxq->rx_skb_info[i].offset = FEC_ENET_XDP_HEADROOM;
+		rxq->rx_buf[i] = page;
 		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
 
 		if (fep->bufdesc_ex) {
-- 
2.34.1


