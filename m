Return-Path: <netdev+bounces-239072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B9C6388D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC9B94EDA3F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A602D3A86;
	Mon, 17 Nov 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eys/3KFk"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45765260580;
	Mon, 17 Nov 2025 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374728; cv=fail; b=bPGJGelRHQWfZKzIb17+WCA27IQRJxBKylpboWAQlpKySMD0GkCwRRu0l6flhjamGU/q+T4p35HKWpyOuMsKtoQ8te7BSwFPy1MBaPGQekWjK6fe1lePfNYOLK80wps1WJbcFDFAPniYyqzBdXnP2Oi+CpMDeFArnESvqWM09Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374728; c=relaxed/simple;
	bh=zbIGnPTSrPYfdVjSZ48JwOkbYg0rzxmd4Ffyi0MfO/M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CaXq75leNAk1SwLaURm2hb116xwrmVnYUCGWCvlUqx2R4wVJWrrWtsAgZSWsK0XokYAuIeYzQBaLGIKPXIOjHk0ZtfxjtGOchnhEN2y+xaNALn7vt6Vvt5wkNtXNnwOq2Q97QpNzbZYAEX1XiNEO3NpiiEKMpSj1rdKkzXgveiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eys/3KFk; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2qB/WXAeV2KFxr7QGw9Zc22tay70CEKhEh22YvONc3YNXOZzK73WYjZok9ZOntqYQ5RF3sqZEJIhPVmaASczutFO0UQri8UA055A7kCkPiI+DrSylj20wVjoNCU5Vkx0NXsSnYT246XfdOFNQtqtJ544wc4iltPUiRlhYWjs4KFm6SyiPkQkA5MCboUMzzrq/leybFUyrdkbLP430639lqtE81aKYDRksMwZjw2tGAInxTAhHnEAGfuUTaREgZJVtkx7FO8AYaaH/yR7ksSLxvigOf+HAO2t2cFXiSjEUVsTsG1A/vFWeN7sxU+yFJfdLAx7e5W+JLejwxV87dAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99R81bRaeUSYQHLoS7atw7A3sd2aeX6UrQbTInSaS34=;
 b=cHSkR8L2f5SplpdNZ0KxUKKi1h44hYFe4yei508T3dJZL70kLnaNtWCbvO8G23prjP63+PW1wOBiIDkKRBNMJJKJPHLaPLihvzyztVi6HK0Ws9r7ihUXG9mG7ouqK8Q/0+Spmi2RFEkDyW39hyGG6hUD50Fm/Du6Bc0aDPQK9MSNymaaqQqikJrCQtf84E2+RwhRewKE8ebGfb41w4kXtTL4TaG27L/E7MF0Fakm/MkmlpGCUH99vLlLsp1TcuLVK3lB4Vj38xy4nCmscnasbklixLpCJJN3CeYIuBYTWeeebk/Bt8jbmrZjf7VTaSkd7CkSB8DjxXx9sjPp4YQzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99R81bRaeUSYQHLoS7atw7A3sd2aeX6UrQbTInSaS34=;
 b=eys/3KFkP2twlIIWMJRb9O64B9aQMSFqoU37q44Bz4UXC9hYPemNi1Uxxz4KbW6lcxdYWqCNwfDBEZVIyfe4av0212U8x45NAJNdvGT2Vy5mbS0lA2qwKi4Gbp8O2PIatlO6ZTmxMfSygDWiVL0S5uAvS2YJx8cwtyy7/zFRhG9+3Kdz99+i8VBMO+7xRAeSM702oCP2i0bHFTBJEJ/lLr7T3ivDjFYqr61aoYxLFnh75Szmo5QMPAfWWCu/47Ieyol/Diao9wgZihmqq/SR/ctDof/9DRFaIVXQaHU0bIvTBaIoIeLNKzahPc4+xZJE/9tdI/Uv/rbAn7lSe9crXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 10:18:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:18:42 +0000
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
Subject: [PATCH v2 net-next 0/5] net: fec: do some cleanup for the driver
Date: Mon, 17 Nov 2025 18:19:16 +0800
Message-Id: <20251117101921.1862427-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: 519eb471-50ec-460b-27ec-08de25c2af0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VN/j4fbyp1ciNe0LgZ77CfE7gvMvgeWyc1nLwh1dQW1bXB2VUb1EqKF0WWWh?=
 =?us-ascii?Q?FLVICh2mBT9dV01yIocL6fv8NgfKhU2i9dRymQG848lmelTFMRu50rRNyefP?=
 =?us-ascii?Q?R1qP3gGkIhuctst5i0ibInwJCYqyucYsUr2C9Ok102x7SulkUBAMgn6T1zWh?=
 =?us-ascii?Q?USjkbn+8FGUoJJ362TThQO6nG2q/pcRBsmLz9InGN2FqzrYseOEl3LQ5Hgqc?=
 =?us-ascii?Q?p7wRzT22cP1397/22hOf4R5bzCZl/4wVCF3vQYPl1DiApUBaYHSWrWouPKjm?=
 =?us-ascii?Q?AybHRVk5LTxUUfvw8H5orruNpA8N1ddtjdJwM1B6B/Xq3yEdWqj+5AN8x04T?=
 =?us-ascii?Q?k7/WHDgkJdyoNo1qCSFat1Hmo30KI6T/+eBKp6m9Esvna8DhP8KDru5RVZNu?=
 =?us-ascii?Q?zTKHS05Dxnexv7fjhCTgX6ePCLftrIsOvBi2lxeowfnt/+fMXCZJNZaqzyq7?=
 =?us-ascii?Q?XxOYinBPUZplw4B2xgsGECDeBeht8fKkAa1sWcUORRjq2GLWIUk4hZvTE8qK?=
 =?us-ascii?Q?MRzMw4gNtn4scBj6mv+uMKqtzyxs3hBiAVsHm9eSn2r59bXHrJszAfXVtGeL?=
 =?us-ascii?Q?kqsbfurZGql1VSIWzq3pKB11yIHe2MbSaxnDhj16ahrPP4aTQ8XguTKFNuIP?=
 =?us-ascii?Q?b3jLpVWsAAYnvywmDTCgSfjdHNVxGl9uoxS0N9vEtruOyVq0UADwhzMK0JxK?=
 =?us-ascii?Q?4vMmUX0PvvLucZyDKce2ylW5TLtw7+tNS6Nr4XKx0uuSv12TcATBPLeh5OFu?=
 =?us-ascii?Q?KGg+++xjoTlE2TH9j7oiYzQsz3tOv7joOp91O+XtHJFSOrVqbBhzB60iXCPY?=
 =?us-ascii?Q?KJPfc2o4nIqViDYLBhJPovX05hKtkGZW39ep2OX+hJeAAqkebiQ5QGA8VY3t?=
 =?us-ascii?Q?713iI9rwtlYyFQ7jDp+ehNjUzs/X59qr0O+7+6dUBkBD2H7woQ1tPNJq9SYC?=
 =?us-ascii?Q?5rM8ATlsgJ6A/22180azjH5SkXGHiMF0LlSHZOuaY0yMnZU8RMIN84/ZGPLn?=
 =?us-ascii?Q?fDQYdfLqrpVeRxvfJ8b9iaH1ed+m4O2U6ECqxFwUsBty6bz4JHid0/0PqJQq?=
 =?us-ascii?Q?3IQWqEXE2Vymcj6fH7tmxEw22Hgqt7Oy0waoAFUN48A9SGF5ooriTkgJ/Uc3?=
 =?us-ascii?Q?W/Vb6u7rphIKwoVZ4RhoMLpxsi2qbb16Vwq+XvON1gouGphMm9Fui0Ojbbi9?=
 =?us-ascii?Q?75brhsrMdMiDkqV1mduSrkaLb87skynGjddFwzZ4AgdZziyY32jUzh0cEWd/?=
 =?us-ascii?Q?VZGOOojHp72o9blS+no27rZ/CctZ6/4o5XjlqnKS7LxjDbgeQ4ts+O4AqAKT?=
 =?us-ascii?Q?bdVNGyWVMOjz9hUGa1lfdqAYakOEC/AuB1WDl4bQ3XoDGFVZNLoRjoNg60sv?=
 =?us-ascii?Q?5TWVdgavhFL+1mX0cAOM+lbm2q6o5kymDL3xUPTnofXgT/wPloU7xhqkkHfI?=
 =?us-ascii?Q?4SC6S94s27LfFVgv8TPs722d7bNjUBdy6FtpA/Bf1ejtI+hmVF4iOXimL7Tk?=
 =?us-ascii?Q?T1My5NlBOMMFlmyfH9dOpJAlmwWvS0gJ6Spd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+910yZb4pLprXhR8JB419vd+SZG4cUELbQ4boDDHV/uNy6PhQS+VuKyptZLr?=
 =?us-ascii?Q?PNV6O+FHkFTi7En+iXtg/iqQYGm1fq1RTbTD8nIFqSU+GLCrbSG1R2boFQwn?=
 =?us-ascii?Q?0ZFl/atl6IeysbWV/kXkG5xeWhUcxz3NYMq2WY5fPrg22RfLFceRP7e2+k3Z?=
 =?us-ascii?Q?LPdmte2klKSL9V1FHlRRWc0f8bzXU2COTpciLUrZUq6UAA8D47z3nRbGN44b?=
 =?us-ascii?Q?A2YdG606TZEtvSPSuzWmBAuI198Z2K1FlxAQw9W9JUGfebF8eqdSDaZDGav3?=
 =?us-ascii?Q?PuQqmWBICWj+cIGArGJAZTLv5rkqCOYZR7WB+wrygmmU0slHkEmse2/BU13C?=
 =?us-ascii?Q?2AmMEk4w19blzKsmZGrxbypI1AlPXaLhxfe5fCHhfylOUx7oBWSp91pvoX9t?=
 =?us-ascii?Q?my82rFsVsnOeJL5d3u+K6v+lPUFm7QGR2QjMgONnJn6k7LAH6h8mlfwpT17F?=
 =?us-ascii?Q?CTtkWgHeYB56VCdIOFNITC35E/y6LyCDCZ8+bBe7i/6t0/UW4RT8C0f5UT5c?=
 =?us-ascii?Q?W8sHHpyTI26MJ5OPdZ1atNlKwaGXBo2keT/lk/7eOazLa3kKf+58yCp03+ez?=
 =?us-ascii?Q?4kM8SylTjR9PHrrVAhcyAxpPgEq6RNa5giPGMY69e0qMhXAg+WDjBMKdUEyr?=
 =?us-ascii?Q?G05BiTOXF2nuyVplq6FNg7IyPwFfD3zk8+7+VBlWvkMLgAJz+Om0rxcoKNlk?=
 =?us-ascii?Q?5bWOnptB+kzTR6q3O44MCCJbJt16mRektdrc+yaNi+njrB0tIxSMtzEsgDsC?=
 =?us-ascii?Q?MayKfJLfjwWEnJ7fuKJkagD8k9NIhLS2lMYj0+pQI7aH7nltlb83nSJU8/ev?=
 =?us-ascii?Q?znyI91+YSQAgpLeUEKvZcuKbwaHGcBYn0cpIhIjnk8kwnN95U1tlptABCr+E?=
 =?us-ascii?Q?3CWxznox2S1kuhr6sCFi43uz9wSdrjKtSbsvutizdl4nPyyqpRinwqVXXSEr?=
 =?us-ascii?Q?YmtcpOEW8dgJEwdscHBSniGVTMcp+S6aUgVegjyZSySP+ha0lSNMgZgYsoY3?=
 =?us-ascii?Q?/5AFM//WH9ULnxHuwAijfcmGdIqSogdO4OBW3Nq5lGy+PJNZ0rAUwTUyfVjL?=
 =?us-ascii?Q?S4ykmFvAPy0l0N5Wo8ubmmknMpjOWW7X59ImCsHfZ87Dg6iFoGUv9GOxfIn3?=
 =?us-ascii?Q?6IsDP98wHF5a21CmGaJDoCHRPA/NTglBq7VQdBygz00VYFN2YS9jEX3X/9Ew?=
 =?us-ascii?Q?CJCWWFUgDVHDsQ0wTN8wl762tMfJAbDEITUW7VLuYGq00cTxTveNbnvQfX+k?=
 =?us-ascii?Q?tH4PJJuV5ktwOQ0jczd4daFQ8e0JwuXaVkKAUVuSIcukz+XhvejnhVUIq4vA?=
 =?us-ascii?Q?UJESWiUd5u0C13xZn9Hcs2ie5mwGUlCait/dVSThXxXdYxnParwt9quBwJ8k?=
 =?us-ascii?Q?wH1lSw1le41LhLh6TuhBSa/8KpAPbQxBeLjPredb9xDd+c0gdcU896vDaB83?=
 =?us-ascii?Q?ni98QZFx2xdeSChiqm1wYnnVmRhW/9wbPOwEXENcQ9Dk1L844hm5tY/QC2XE?=
 =?us-ascii?Q?6G3/VNv0MbjBmo4ATjkfQpwlaBNcYVG7ZYQR/EqkLrzyaMv8zpL3ZEGJfrX+?=
 =?us-ascii?Q?JMxqY/Km2hNAuglQHVK/rwdqA/96Kep/mszQhHzk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519eb471-50ec-460b-27ec-08de25c2af0f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:18:42.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dz7WohKsZrKt1GKrV1vKulNxoJWKIznUf3Kr9ou/vrCNroTSVb3yV2x8Cv0DDEN35WP2zDwN/boNj9CEjnl00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885

This patch set removes some unnecessary or invalid code from the FEC
driver. See each patch for details.

---
v2 changes:
1. Improve the commit message
2. Remove the "#ifdef" guard for fec_enet_register_offset_6ul
3. Add a BUILD_BUG_ON() test to ensure that FEC_ENET_XDP_HEADROOM
provides the required alignment.
4. Collect Reviewed-by tag
v1: https://lore.kernel.org/imx/20251111100057.2660101-1-wei.fang@nxp.com/
---

Wei Fang (5):
  net: fec: remove useless conditional preprocessor directives
  net: fec: simplify the conditional preprocessor directives
  net: fec: remove struct fec_enet_priv_txrx_info
  net: fec: remove rx_align from fec_enet_private
  net: fec: remove duplicate macros of the BD status

 drivers/net/ethernet/freescale/fec.h      |  30 +------
 drivers/net/ethernet/freescale/fec_main.c | 101 ++++++++++------------
 2 files changed, 47 insertions(+), 84 deletions(-)

-- 
2.34.1


