Return-Path: <netdev+bounces-216361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E967B3351C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BAF189E8CB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F03424EAB2;
	Mon, 25 Aug 2025 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bkUOdka6"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35D2101AE;
	Mon, 25 Aug 2025 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096588; cv=fail; b=hjE4J4uJdeskd9n+oI0TnFtZ3AeDxxwkWTX0cSrUiMrjqk2a4T4+cuX1Eml7+9pNRJyg3ytloFvjvjzz0otH4ruJZWHpP3mt14Gkn+HvnkXd89irTSzXFT2OehIo5bmS4Oz9+k8aMCS7ulgMMVdIPuYWnajcBliEvAQCNVFILKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096588; c=relaxed/simple;
	bh=T6rrJXUm5iJqYV68Ft0uckyDDPXW6nOTTOhI2D94YH4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t8HWHANbX4lhl3SXwbt5RT3RDcSJUPXB6ej0c5vSwc3yzYouJI22D8L/kSW+uSlRgV3knnj6POwVkolP7FCsydHatDdh8kEycP9efdeDsRxp32CeGyoHtK4tRZrftbXefrK94ysjd4H5bSRknOkosCgGSuREI7R8DnGIIYRnqmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bkUOdka6; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcEYuS7y22jC6fMvsCkU0EFWf2LRBbR+1RFylMBb/3pzTVu1fHmFdVmbmqASdyEO6D//lG1yn7kL4wQ6IeCStLXlig1pGFULzE5FYjgmgVNQFSJA5J6jFbcPk6SDl2xQ0WMJHjOp6ga3r10Yut1hZnt6PZZnd4tT74wfaQVM1jR9u0GUqnQOZgsuwtLPYgU1fr4wdpLGp9JtXmYVTZrjmnk2jALAvFe91KDG/Amnpuz49MoL1L5or7UQDJHk2W2/eYo1APSHCcUp7sZZ7Y0095Jel8JcsDnKpkXt88lZXKgQ80Qvm8ZOlUaNc/CV/O9FPIJLjwZU8uLJHiZkFsBlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsjskNQLxvM1oBVQy3D0HFbr9cHfD2s0EPe9NVhAqtY=;
 b=rWU/xTWv95kJCdvuHueH9S2OKxmbjUOR5SZDlf1MzBMa0AjbYDi/J0LERXWViMvAsKR18C/iYXKKzlzAtvnOkwa+mnqauV/ptUU4MeUNLT6DNMjzOK5zlDo7teuca3A5c+nRkHVXQh4CzWslpRi9xTFgdVLiWMzR6impb1+eFi5TVJOY5rW9WHXL6Rnck6E2fNLZEvf2iXPy2c/sJveHuVCZo8+KbqAnvDtTL25kXpixs70uAMCMbLrkXVTjO6+xOiaC7EUJmL5u1kYBm2z352v1TNbS4mDE9r1WKhKhP0JKvZJyTAHbMdhtxvtps1oAZGCgWQYBB44nlHDQJhmLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsjskNQLxvM1oBVQy3D0HFbr9cHfD2s0EPe9NVhAqtY=;
 b=bkUOdka69lzqHD9rsGTshMuxUxFuX6gKcGiJEgjydlHB8lB6kn8sCAIrI5vZdqQ1yrpoWtMci1WAe+zyYwrSIsAS40TAMmJF5wO4kLXrcx9yvYVuEAVxpwN7JQGu0IbwjJoYQxs4UFuBdonVTDNuLFCOEquEp/Bpr2bIJPMWI28n+2UzZp8fp6R0UGdYjTpFUpxOl1VnmVIV4Ijje9B+Pe9y7Mnut7o/h1Ta0VyTnCyPM5Z0z79WCXLPd63sG5InFz0UK9AxMDbBH67rIHet5N0GkPgrMLp1+xpVpFd792DM1IrhiUMlh/3Llz7XA738aLOZ7+JPFR9iD+z8gRK9wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:36:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:36:23 +0000
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
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 net-next 00/15] Add NETC Timer PTP driver and add PTP support for i.MX95
Date: Mon, 25 Aug 2025 12:15:17 +0800
Message-Id: <20250825041532.1067315-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: e565d6ea-85f4-4144-0979-08dde390f1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eabCVNkIa70/h4uruYOP9tqMUw79DLBghCCfE/n+ozkc4mSRTKiTJsfU/587?=
 =?us-ascii?Q?Wm/+/8TeIDCHgYKrnJHWbOj4dcatrS1nRrR1l9gt3TUVsQ9awrSPiUo0HkcE?=
 =?us-ascii?Q?8OaYFj87cKNrRTFWtOADDmeonPq8uCYnjh9BP6K3B8QS6F7S/m8Xu440aZ3N?=
 =?us-ascii?Q?p0lRpHims+u7yAYAcGehHqOvh20XVJUwsjbmrUl4i3L4Mtit+O+a3gNuwF5i?=
 =?us-ascii?Q?BXyHrYamUORJpg5ChDE0Su+TcgfQQEOwizGiZ5qMPssUV7nP8sHQZB4gvsuu?=
 =?us-ascii?Q?VduShLk2vXizBGpnU0PqeuKrYzduREa5n/ua6ZgQzL+LWtzgxz20gNKIJ/Ns?=
 =?us-ascii?Q?JgtjQ01FV3lSVB3QxcNwglEJ/D7ErrIy7L/suI1lNaM2tr6pBeSYnpL0CDw4?=
 =?us-ascii?Q?iEV7kXy9PxJ4mcgIxAKjUFBx7+D40t+OJ66UK98AyskhWvGHX4FyzrgzHLTc?=
 =?us-ascii?Q?+uZ3AzxzOwttpzHWIPwRP/WuW5UTMu5/6FbDcwRsk4D6BgCwFVe7TobnsYUv?=
 =?us-ascii?Q?9H/97TLT5b+ZCUS9gnCeNhxCnHdWlADkPjs9JWkKNtQNMwOHYoPsjeroX03+?=
 =?us-ascii?Q?Pjh0x9D/dbjiTCE7hWzTdh1L0L0z9Wd87lYJ5ClGgl2OYXLsONcjvHpu5NTC?=
 =?us-ascii?Q?QVJCsva974vZ7Uu+fjU3b++570o6Oee6fkCHnlgidJs11MLLoAZHy5JFsGsq?=
 =?us-ascii?Q?lCMKNIgqYQ58asBsCYwr4IMztC9X+PtuYPUOPMICE8Gi5vMzCkOqyFNsNc+X?=
 =?us-ascii?Q?7yXSQJC5FE6/W+cSsgT8k0lcWR6MlsuBsibVINXP0tA4hblzNgW1VBkCW6UJ?=
 =?us-ascii?Q?E7CWB2vrI084fDvj1t86tcAh6j9dNB5ukpBUHEslm/BIqfn0PCjxiPE+xe6G?=
 =?us-ascii?Q?flSPDvBHyeZN4t9Q3vlxxs7nk1qpNliQWnlmpSNnSn/l7y7MdhO7WrSsOES2?=
 =?us-ascii?Q?n44P1KylOF2khj9psC0Jerb8v+vuN7wDHY+jrQP3IFmvRkhbFNb+SK+c7/SN?=
 =?us-ascii?Q?RARtQ/pQYQsxzEv+KGibsdzwIksQji3TvnxbVOVVTG1sWTfYY9vhJDnnoIll?=
 =?us-ascii?Q?LSsgYI3N8a903vQhFMGo2qyG+FP97J0kTAJQiVyB/ZygengVc4wpYReJHkHF?=
 =?us-ascii?Q?QgPpQoiKTndC/TGerMcw3kOzr2v/NW72AUXBibNN1t1QGHfAPdaUE6T+HQw2?=
 =?us-ascii?Q?51vC9PquPxJbfyvW/SvJRpnGBJeeyMHcYrM6+RT3A+meVWqnLGXu0gO+Zydd?=
 =?us-ascii?Q?0DdcR0l4af4T0XZKNjFJPU3moyyWEomzrATdC28Amz3GQGo+FzqMDEtke79i?=
 =?us-ascii?Q?0AAHSwxZqlJtR2f9zx/SHLqlY5QVU8WurByRC6ft9fgUoxvIAhAOddmcle/Y?=
 =?us-ascii?Q?GyfOuiP2SiA+sZzPh3R2N67AyDOBajAvJJHvYK2Q2Rbuf0FgPkjQKBdyffAQ?=
 =?us-ascii?Q?cmpJz4/aZX2mU3lfIglqglJRWme/8///ppzVlyaark4RTH4PaSL0wF0Mv7Hu?=
 =?us-ascii?Q?8Ep7wKLd7YVRCv9htRdNfT8nxlTo3/gyyFT7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Y5bStmaXzbFpkrxwX4tut4eMhhL2cxbVhsJIfcu1SyBKWJJD9gPyBmKCNCf?=
 =?us-ascii?Q?jlc9LidRonWBDoy4yTMIfdn9pmHLDPInKN/vd7bm1MVV6RZKLQ3p/qHuJmKB?=
 =?us-ascii?Q?VvYMUgC2d166PtbXEeHpTHMf8Qs8BPdY7gAskJPCR1CmZDRk8k5EETOmU9zK?=
 =?us-ascii?Q?xb6x7BuNs3u+Uk6RWcYOp7kQQx7FGH/1dU27NPhwzsKdi8s4N2gCv6cCEp6V?=
 =?us-ascii?Q?CH+gsRpUDFuuH3hhTWVkdihNAYS7TEcpdqmZm+V5+NYnv/v9uijAKWRfCsxb?=
 =?us-ascii?Q?nxW/C+koe2lb2nXGwDnv20G74gbYHl0bFWpT2/DiCtI3Go/gmhVdo0ax9c0N?=
 =?us-ascii?Q?wRf4+9oPSsCb7rsiOXhNdeUAxvrZLBpF3E2AQox4+mZ1GVKqeYLwGRUZLy8S?=
 =?us-ascii?Q?w89w79kWwwx2/Tnl8+DOfR1N4rVpqbnaiU01f0gknQY7N24X6bs2qq+63Ovz?=
 =?us-ascii?Q?TtFnyC+GlIKhBc92JPUXcM3zuP9ZhZGz0y4ej/skXRhkHDAzNkk7wP5WvhzE?=
 =?us-ascii?Q?f4B0QbSSVR8v7WYjdf9sFBk/fxNos9CTBCwP6ZVCcd+K/RdUTzUC2y4Kfj0a?=
 =?us-ascii?Q?KyDPdBm92KjLK/62iaYBpsLkeO1X8CQV/STmbSe29uhzzj1ZXhHff2CK0LTm?=
 =?us-ascii?Q?FWU0TG9mbHzdfxQwCr3SHyu45yqbDcJDfZswenDR/37S7+T6l4OnAqErzYjI?=
 =?us-ascii?Q?11EnznbibLSaR4VbQb+S/U2mlXDzgd24zQUyCSFrkgJxfWBnqyZDMzR6BrKj?=
 =?us-ascii?Q?7570pO0U3iHnFTxdYoOtrG3Vw7sGxlDzJw7kNQ/vFUaem9HxdL3q+zbV+9/h?=
 =?us-ascii?Q?FEDUUETwn2Dk9q2qiRQq42lxn5X4W96Wq//IXfmNcPFQQ91WjqBKivpJadV1?=
 =?us-ascii?Q?ZOK5/LpCB8zRY6Lb7TUx3wXQHVU7jVg/g1oD6SlzfgeRue2O7MUupxOV37yb?=
 =?us-ascii?Q?o99U4Beum2zMO9DzlxlJIRZ35gJA02lHHpcAGqPwPcenELXc8zdrYkerr7cC?=
 =?us-ascii?Q?y2502ZSfin9QiVX4FXciEKaEIe1gasuOUhZf9K+WaMmn/DOE7l1h/fZzbozZ?=
 =?us-ascii?Q?jIYGuwtEpMogq4keTk/BlSZkgZPO5AkM+kEzv15E51mwHi+7Z3HcSgcXZFqB?=
 =?us-ascii?Q?vVt4McyqpgDuGDrO2zxoTc3WrXzHlfuAncpTdMq57gCjhAaIDLk5wFWC4bsP?=
 =?us-ascii?Q?ItgkRlJQeaz5iWoHtzcz4EzmuuWKeDf3aLZPoY2j8/r1IuIC1T5/cm9VSf6w?=
 =?us-ascii?Q?HAfGITo6sqdr+fRFvQJ8AiyoyPdIiwd9/0BwabhqvtMnbkIfkWAquRtBWf7Q?=
 =?us-ascii?Q?U2R85XFsyhn+/5EQmNVQ57vuc6qanGMtj0ExETabCCN/b0Zh0+K+rfEURZ3U?=
 =?us-ascii?Q?qdfMVw+Hfx5NqFGnZIfczBsA0Bzq8NgyokgMawjogh8L3tSofyvGqXxc93yT?=
 =?us-ascii?Q?ReI8qGrdA+PVVnsgqM+8ix3ji/vyzpMeLnohTL2UHMND6RL0AWKNXpS01boE?=
 =?us-ascii?Q?bXrvx5UY2qJt5jSwYYhqxW10t311RVGDqyN2hHHuqQWXwnXhoFZ2w6YODt33?=
 =?us-ascii?Q?zoZaPiV4jtQCyiDbl5GAVikIQyex+pgxTUGpoLUN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e565d6ea-85f4-4144-0979-08dde390f1d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:36:23.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vplVC0mdj/E3Dwjp9XrXEFeDE047F6EXLdOVUBvmWpQDDwtDyCv6jSSEj/INaA2m1vlTvkESoAtOweo4nf9lzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

This series adds NETC Timer PTP clock driver, which supports precise
periodic pulse, time capture on external pulse and PTP synchronization.
It also adds PTP support to the enetc v4 driver for i.MX95 and optimizes
the PTP-related code in the enetc driver.

---
v1 link: https://lore.kernel.org/imx/20250711065748.250159-1-wei.fang@nxp.com/
v2 link: https://lore.kernel.org/imx/20250716073111.367382-1-wei.fang@nxp.com/
v3 link: https://lore.kernel.org/imx/20250812094634.489901-1-wei.fang@nxp.com/
v4 link: https://lore.kernel.org/imx/20250819123620.916637-1-wei.fang@nxp.com/
---

F.S. Peng (1):
  ptp: netc: add external trigger stamp support

Wei Fang (14):
  dt-bindings: ptp: add NETC Timer PTP clock
  dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
  ptp: add helpers to get the phc_index by of_node or dev
  ptp: netc: add NETC V4 Timer PTP driver support
  ptp: netc: add PTP_CLK_REQ_PPS support
  ptp: netc: add periodic pulse output support
  ptp: netc: add debugfs support to loop back pulse signal
  MAINTAINERS: add NETC Timer PTP clock driver section
  net: enetc: save the parsed information of PTP packet to skb->cb
  net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync
    packets
  net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
  net: enetc: add PTP synchronization support for ENETC v4
  net: enetc: don't update sync packet checksum if checksum offload is
    used
  arm64: dts: imx95: add standard PCI device compatible string to NETC
    Timer

 .../bindings/net/ethernet-controller.yaml     |    5 +
 .../bindings/net/fsl,fman-dtsec.yaml          |    4 -
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml |   63 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/freescale/imx95.dtsi      |    1 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |    3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  209 ++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |   21 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |    6 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |    3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   91 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |    1 +
 drivers/ptp/Kconfig                           |   11 +
 drivers/ptp/Makefile                          |    1 +
 drivers/ptp/ptp_clock.c                       |   53 +
 drivers/ptp/ptp_netc.c                        | 1110 +++++++++++++++++
 include/linux/ptp_clock_kernel.h              |   22 +
 17 files changed, 1508 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 create mode 100644 drivers/ptp/ptp_netc.c

-- 
2.34.1


