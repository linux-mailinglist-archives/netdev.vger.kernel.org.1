Return-Path: <netdev+bounces-220100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3C9B44760
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA02E1BC446D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C393283CAA;
	Thu,  4 Sep 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SXAZvTbT"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C828283C9D;
	Thu,  4 Sep 2025 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018141; cv=fail; b=aqNJ2vi+tpejjRMC2vlrbR761qKSKzrosPzeMFtvN8VWrlrElHPLGMSKoZltBWOccmm1DMHNNhWW8bsuBQUybR4SiIHZ6i4EsZMrgG2u7RO7M2MKU6zeqNcMtKlM9QbwYyxULMN1gz2WKQZDQqMUBoueNcwHEaHDPU2tAjl17ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018141; c=relaxed/simple;
	bh=c/n1aGpjf6dO/pwlaa62/ctKgFWnL9iSjBi6YRBBFmg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GI6GYs2Sv7/jENXt4d6JOzwSib/mATXoGfYpis8Gw/5pXL24OTJ7UjqDQ5eNKZTUeVuKuq6fr++eQoRAkjAiFqW+IIj7EXd8T0CfYYdktIzJslCMQv3a8/+1rVDa8J9BG25kpw9i0xZPql4bRnXRNrIpn3wRLlG4XgA7qpeZoDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SXAZvTbT; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYMMxpw3463Vn5LjyBcwS28D6O5uaKGO+IzIrN22XHWc4dvY16SQf5hKGT/lJNkxDY3xAACD28rFYFaQHerW2DQ+SM+2ss2nM/kJojMOVmv7UC1eUCCmtGwa/w9sazgd4vCsVsrYfC8dXbHGWyY44cybqiD/c5gaP7b6LsKI0oFCuVvuf181Qsj8x2AirOpAd6rtIGY6HFRbTTLZqnMJ2oZrxYShAX5sKExzdkAM/HAdgb6NYXDOOxI5YTBDHieu2ZEYPfaMMdDj6EQBGL+La6OgBLRETqBTUnGjLtZQUdXvpal6i8eMQI4Mg/uimeg+eWq2zHkw2BxI3R236QDEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2ddmjDAIA9GxsUaoWECFajxNlDcI5SUiStW/VzyhR0=;
 b=ZJ/6HQco8hIN9+pbBo3dtlLBie1FphV8Np39gVcuJY/EZ4y1X8szPFfEhQGp9E1xX1Z2uppOik3KZM4oA1RP+0CoEqp1dQ4A/CGHtsPSW/uNThxRI77SEFtzPIVn8dkf+/xKh0VmMalxoyT2fi2jZIlqaet6KqFm3kqcPAEkMLv1FLy/cywg52rh/DObBZtJkkS+6iDl67pXgxDM6UiBh8BjKGRysMYV8Hg2pjAk2nqFmkVYX9Jbo2GV2EaA3l+vqGA9j1NYsiAOXhqDztZFKzx5mq+dsqtp6uZEJ2GTpQTDm0d/FYCtMjdrJt24GCCmlz2avoOi5KkVDx0+ZOrkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2ddmjDAIA9GxsUaoWECFajxNlDcI5SUiStW/VzyhR0=;
 b=SXAZvTbTE4398KjGWT8YYOCXrIGEojCxuT1Cu9+6QaMX3zcpK72kP4VkQuAriKDYEnzc1O+4agYAGhXmXdMjzg0NAm3mpZ/L+49cxCft6nCFzzr+0Qfn3Rar9c2eMkeTLR8Pjo4ZMMb6PeHb9zf+MbXDlDeIOGyVnjNN5Z6oKoOAlSH1Y0SbjiRKYlNR1tFoUtsxC8xvEHwN3x/vgU8fdVgZi3a5nEwmIyEFDGTPlM7MaV+flup8GbbFi1fuSqwZhy4mK2kxWEGNN45XRP0e4SLiFQxQqV7R7otwU+j9P7DGJ+384kHUUiYh0IJlQU+/pR7fCS7QbMEhSE+fIWhyAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB10027.eurprd04.prod.outlook.com (2603:10a6:800:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 20:35:35 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 20:35:35 +0000
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
Subject: [PATCH v5 net-next 0/5] net: fec: add the Jumbo frame support
Date: Thu,  4 Sep 2025 15:34:57 -0500
Message-ID: <20250904203502.403058-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::22) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: e1221d60-afbb-43e7-41f5-08ddebf29975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXsMTol5EC+YbgNVkke0I+f/vuqYm+5uAmShcCuyR38nABp1gVlTU+ctYQ3I?=
 =?us-ascii?Q?6Ltov2J4EkYTpyoTK1YVfRlxx8maxOw2MSNQT1yF02Mfy00nP6UBH3L1N6jQ?=
 =?us-ascii?Q?rYb44gQTRA0ex1Yj+8qr3YBLbbOY+eMTyOdXCv6Gzhv9n3m1v2F8V4l5rE3c?=
 =?us-ascii?Q?S47j6TGmRNta2z9+KYmXNOwy5gJYoKHcm/16WvrxueckclniIDfwwiNCrglt?=
 =?us-ascii?Q?1MSxTFi0a+sS793cX7jZxbgVQwfyovVfzVdLHeFVvAKJ1w/oX+jezInRpwzE?=
 =?us-ascii?Q?2MPfN2BO88Vx7F7ph9eljhHQGiwUn5X/vEQGGNDu6UktdmATwBssEtZPn7G2?=
 =?us-ascii?Q?c56umA9dvNJ6IgoV1AgQtOVVXX17E+FrAQKHpDKF0Y38PUSae3H996GtRp/P?=
 =?us-ascii?Q?WrRQGvn1eN5FSFxjL3FFRG9S2kkFMn6zx5DDA/onBVgcBMlwLOukiGn7xHFK?=
 =?us-ascii?Q?wrSolM7C8fKuhN71eQJKq046wYJTL2G5ARFZnQbK68htzf48DZq9Hu+dK6hr?=
 =?us-ascii?Q?CNJuLuQ5dYzCjP0o6reJsFM6ms2ghBbk1vneROVhcMIG7MhYzbIvJnal+Tuc?=
 =?us-ascii?Q?m8dmpE3gbWahnXr5XPIT6UWlfZMXbLyEBtRIXBWhBlFqPPoJ4ZQAvCAjhhJV?=
 =?us-ascii?Q?ufCXnFZJ7dojNYSsLL6Zsy1WwpH3zKypsMt8RMAN5s4DcGxmB0Lhl1xEZdrR?=
 =?us-ascii?Q?BBKu9IYKG7Ml9jXY1rQKXk0d1dA2Y2xUPROgw4kUoz6pQTetfiRX6J6vJjhX?=
 =?us-ascii?Q?pKPnsKF0Gv3geIPEwqn9wL/oWvkR+wiumhxWfwQ3ukJVO4Njh1LVd3wMvHSG?=
 =?us-ascii?Q?ZCmFDqAhVwthWIP2hOkclHtRmDRcfLQxGJVLE5CayVeRdPSUDw7cTHaygJt9?=
 =?us-ascii?Q?YUIHfK/wyWuay2a9fp2PrgTAyl9sk1dAahIfS6NfeEQXHNPGweFclFZl9y/X?=
 =?us-ascii?Q?3OsZL/ZgndFXmBUZV34UYJvmWmHJDQOgtr5aKVOAdvmIPQzGedaFXMUfbN5W?=
 =?us-ascii?Q?Mz6AhUjAl4Ku1bPdXlaNxZ3OAU1EvGVg26YqMktZ/WX+2hJNJ9G8bkPdS88s?=
 =?us-ascii?Q?qHiS8BBrvqoYVE97JRCNO6jbFi8238oDvmrc87p61k2yuF5iUpUmvinpAHzp?=
 =?us-ascii?Q?SBajqOsf1wZW4C9mEcOn5gKiiEjP/Yk+ah++FXcB4iG2rk0FchnnS/Hmy4uH?=
 =?us-ascii?Q?W61KRCTbRu/Vmeu8zIzFsuTjhynngGBIFmsMHyH3tcnJid1B3Retzkt70lPo?=
 =?us-ascii?Q?j7S/uqyZtMB2+FhBiNIRV31ZAvWvAPEpAOiQXMq+8f4aYhFASkIzMBIK26hb?=
 =?us-ascii?Q?r/rAJA5Xwhd3/y0LIQdHRFlN9PTPe9IlurbeKdLJxHJ8CTMWdR0jbnQ6Jiui?=
 =?us-ascii?Q?hUZljBCzoAt0IEG18WOnY4aXkFTm2hxM8+FxJ1onluXtIa1tvP5tPfnsy0Nx?=
 =?us-ascii?Q?FegrH87E6+dIDZ5vVB01ZK2Q8n+7hmebtdEx3UuWKshn4Sy8dinnlu5AlN9d?=
 =?us-ascii?Q?P9i4SubM6oTU7KA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3t5ElP7Jw28XesYya4f17QOzh+uQALdItS4Y4VSQJvgdvTndwvmQdZJwtvqy?=
 =?us-ascii?Q?PIwssQ85OSLfr3wED1I9GlX15pVEDARQ4CPutowJ8XE0V9Gs61iVOjhHG84K?=
 =?us-ascii?Q?+OhJkN8VOvwRR0y359JWa51LbLZhiGO3TiayAFVquAQsZlMGFdgmjEupP1tr?=
 =?us-ascii?Q?RjUspJmqYGq3x7tK8K7NMvZxNDkCyUtpfmwpm1YJZTEuS7FXVsU1vq9ZpP6I?=
 =?us-ascii?Q?jCR7mfD2ApRtWDsSqX8UM8YeruAz198zIzI7e6usTyRiCinAW0gvLXY7gYbY?=
 =?us-ascii?Q?+LdNsBFg/CUukDSVXSfZqHmsPFv2n3pWNMlNgCnBWX4fTq+PC8rBAG/f2LDZ?=
 =?us-ascii?Q?iXJXwyMrEajyfl1xV+QWGfo4rP2zElnzs/PIHkrmFodTe5UQwenUGZpbYy4q?=
 =?us-ascii?Q?9HYfRqkCCzlOgysOlmkSsgRNii5cvNRdjSLjFLfoFk3cj9Dgx76cMId8kq0C?=
 =?us-ascii?Q?W58cvciMNjqxU4J+/nPNI2nG3Z3pXaUyDUu7EJy7T82EOMt7czHQLp8zPb+i?=
 =?us-ascii?Q?UJT6Uu9sSeBxMi6MJsejFpsH4K+I0d/Vqu0b1hhkElAsBbLiwSBfZL0RFUD6?=
 =?us-ascii?Q?4hRqmtd27J3yQzOe9blQ2XQ2cbJoPtDfYQPOHklsORZYnDZa9R8jgUVbIEp/?=
 =?us-ascii?Q?8PohQu2dH/SOCvl50hM2xCRWAXr5OrPcilXapvHnY9IA8jEsf71t+LPVoM2V?=
 =?us-ascii?Q?vvzLNs6Ym0ZpZUQq9/SeTNw5+JUTruOQnJ5n/ahGhwa4Z/n4GJ29Nlnk6rhF?=
 =?us-ascii?Q?aya0T0+z0Q/pP0vmOvIlIgNxtQ25MLEF4GLTUZvxPJ/2YFx2nc2ou5TOzgnh?=
 =?us-ascii?Q?3yP2IWQ+24yvNDWCtqmRjXQy9iQDsJ2A1xIdxuL5WPop0l7lHs6sl7H495la?=
 =?us-ascii?Q?YUSrqLT9kBquXrVzu4oM3vCkJVMkadnl+jzbI2DL8dnnki+q7TgrDDpv1zwq?=
 =?us-ascii?Q?8wTnmxdiMNwT9g53EFYDc0KRBL/bJgxRlpwV8j8fLjjsSvns/yQV8MNdwj/m?=
 =?us-ascii?Q?5zSz457x8ly6fbTzsJdqUdNPnXBOSw8Vn3Ono/mCP5ylGClCU0QvStsjqGfp?=
 =?us-ascii?Q?LCiy60WfEpgL+CzTrKqtd5G7JmChBEEZOGizjcnCQqzsROIPOsxmco2q0LdJ?=
 =?us-ascii?Q?o32HVQQhesBEyZ+dmPfo/HuUXWY/OxtAimt55e2yj9CH8dq39fg9dy+oxF7k?=
 =?us-ascii?Q?PpugDIgQyU/YbltdSgaE2B+zycda46rngMGXaX/K8cz3ooYfP+DrSE+6dcbO?=
 =?us-ascii?Q?SCYNarjOh4XUJNQH2RPfp8EjN14BTL/TpwaBokXqNFtD/ox62ZjDoKdVS13D?=
 =?us-ascii?Q?/KoQM0DbSZ1KV3E9SUtYxYEAbQDO4xQHv+Tg/8fAxYIjWUzvJ+P+Ql3TUqTC?=
 =?us-ascii?Q?aBb1qKSbALsjH/RWe9zfRceFROW9jFtiw5kG2/h1rAsbCtPRFxyuUAfhoH5w?=
 =?us-ascii?Q?MZATXkOP7Ww7GDnAjAsOMXN8pGR9aZAFr4i5Jtt9Mgx7WbSyvHFD/+VRGGX3?=
 =?us-ascii?Q?JnqgRvkPQ/EdDoulAdZAXPo50z74PasDbqX57vd5w/m33KyRQFpB+3fBLYUF?=
 =?us-ascii?Q?iQ80MXO/n/NmKk+a38IX14T9QEo0L9YPZp40RRoO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1221d60-afbb-43e7-41f5-08ddebf29975
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 20:35:34.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsJggma45uwTAmzkqQq12v+7ECJMjfGGuE3b9Kt3u0Nb4s0UTWr7AXVwcQC5XBPSNcA3IQ/PBgGYKdcHGzXBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10027

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

Shenwei Wang (5):
  net: fec: use a member variable for maximum buffer size
  net: fec: add pagepool_order to support variable page size
  net: fec: add rx_frame_size to support configurable RX length
  net: fec: add change_mtu to support dynamic buffer allocation
  net: fec: enable the Jumbo frame support for i.MX8QM

 drivers/net/ethernet/freescale/fec.h      | 11 ++-
 drivers/net/ethernet/freescale/fec_main.c | 95 ++++++++++++++++++++---
 2 files changed, 93 insertions(+), 13 deletions(-)

--
2.43.0


