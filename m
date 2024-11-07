Return-Path: <netdev+bounces-142643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9529BFD19
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D000D1F22BBC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42968191F88;
	Thu,  7 Nov 2024 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ESOJtROv"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F787191F66;
	Thu,  7 Nov 2024 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730951644; cv=fail; b=T399nXebwK/bNUQr7PU1yH23eRPYFIDSPAWTVUejRhKeIkKovNafVPhswoyUpLhcJSiPwai12U9xVgESx3yek0zVLJBchomSVbC8JSvi00vbu+0QZCJ9xoPkqEBjjKRfqPOnS545Xd5RChSJjiYsxStgPr8jD8QJov8KVD3CJWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730951644; c=relaxed/simple;
	bh=a2ebia7bMF/ffErsfUldYhdBb68rsVdl4VQOpOkaaNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RmSJZqX0GTIdw4/bqQOQ22L4wo2OMaUZpLpJxTdcqpUVzYRSfYzsd19H5HXkNtAOS+tRRRXr/BudGmMufGE4+PtjtcZAtZ1GADCdBXUoo3Z/r5Layv7HX6E/ZdnqOqVZ8IFdEEhIi3+J8gCTNgnw1NZLlPELAEyd2P4MA3Kq2jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ESOJtROv; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGPoEr0+yM8kV5bAGfJA+KBti2wZfVLmqrbsjyqz0Vr2f4LAa+kpQhG84ht+rnWHRZLLnN7VZa2wai6r1No2aRWgSkNFTKqs/3YC88u+qIf7zsNciPUpLuK+436HlTbHCmHual3pd03mJdtBGaHiEVjOXZ8Aym4B0WSQT5gwzhLNKrJCiIX7mocVkpScBfAR6GPNNcLBoBVYa98wwCtbC3T2ziDQdJk2z+U5FO6n95q1r5MCfLcejDqubyPhANhX1If7wMh34x7nk4OP40R8EyLdqPiM8Od/87USPo9/ZN4HUZ3P0coMcVRpVXxuppSsnNCpiXpRjThbW/sBkwjq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01PeWZU+Qr9nq6iyKy15tvfe4bx9kpMWjHlnP3/HQ0o=;
 b=Iq5lJrbamaEfm4XRG3FHaZfCbYVCUW1jjGG8sGnhX7otDoOgFUPt97AKbuZ03YUbp+eMi6f2f11t1GSxGpbh6lvh+0cIm2r/wpabPVkFCJH05k43l/mVF/AuHrWQ6xD20BE7c6DSThrjNvCo7wUI5B3OLY3o/+Tk+hMoqvrf8mXJucaXrZK9gHUOt0C4LYiE4otKAhNj1ZTBGhkMkqjA0Sj2WC9tjfQ8uEj8Jw06HUY/uU54YYQ/Vm+UfUaSt0XGgenomk+916xVuH4x6RhmCS0ViSRrhzNOYemusZgUGdada3AIgGVbEgG969oaJyUdxYylCOdiopmvrIWiqR6TGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01PeWZU+Qr9nq6iyKy15tvfe4bx9kpMWjHlnP3/HQ0o=;
 b=ESOJtROvsZVqh2Wx2pqBiQ8RW+k/Ex/9xKKrU/ChsjefKd6H/eZg7zi77s04u41E/LaubLzOLxiqm4kCFY0vM9Gqeb0AmLqMhNJ21EqariigkzjrLXJywdtbVg+6n70c1iiRJwp5vR93hN7Tx/IvvzBYLnOkQsg6M4JUeGGVDinxqlLDA+cCbt4QW/n1q1ghQ8bRV+u5GRjLGCoYCNMd+ZFZsxEy+PPaeDnu2/uGjc/djk2G4/qE7/OEIFXr1OgUiYz76Jhnw7Njq/0iah2qMnieMdcRcwbYLlsZSAf4CQ/M9EIRrSDKusOO/kWqr60h9koQsqFsYl7zN0UhC3CFhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 03:53:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 03:53:59 +0000
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
Subject: [PATCH net-next 2/5] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Thu,  7 Nov 2024 11:38:14 +0800
Message-Id: <20241107033817.1654163-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107033817.1654163-1-wei.fang@nxp.com>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fc2303-6919-45fe-ed4a-08dcfedfcf68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EMg5W4n17W3MYHqkcyYb8ZreyEHJCGdGS2IZKTk2V+1jgRxWZYr9QJ5c46NE?=
 =?us-ascii?Q?eELzDoufcdSa5+Ixow5lKiCJPEmalazOl3dQ15wqliNlmxQ1d3qi9fw1jI2g?=
 =?us-ascii?Q?HnrMz2s6usNPMpDxue+qThWjvs6i0jzuhQx0IxjTRlkgWhlu9Y8UG5Rv1gYl?=
 =?us-ascii?Q?D7Sy9cbIB7EVOH4iyYWygHE6CLvxCKr92g5hM3V56xWJ3q3lF+k3mhf/s4Xy?=
 =?us-ascii?Q?GZ1W8erADorcAuNhY8YdjpKRRnJ7U2uHTzFe/YOFxqYZodSSPrVtVT+o7xpm?=
 =?us-ascii?Q?6UfuPkFTOOPecInGq/4pFiS/FrtVE5Mp0oGpJe/qv+Dp5jcc9LIHoSNrnMp4?=
 =?us-ascii?Q?0nbAzdWXEJ6w/fcbR7HLKZTfK7EPedQIxhO5PjnTR3Aj9jK12GqBZDZjCfK9?=
 =?us-ascii?Q?6f04aitU/jQg76VTrIkmLypYiU2dbuPSiUDMRuPN4mN6f9L/rRt5ABuJHItJ?=
 =?us-ascii?Q?FJ4WCzNINDNKepU7udHpyyJvfE541EgCnvXgFA2qJUkjXBTob4XecbDd1yco?=
 =?us-ascii?Q?PGR+QhkU0J+iLmvrWXV4gFOJevKu8Fb+G4ZoXvXiTwTF4heu9tHWLVKbxRJG?=
 =?us-ascii?Q?sytjXHORfyQmdkNzDJm5rbRmpvsNcGSIGb6WnXyvNRRcUpsDhELSvlcoc5y1?=
 =?us-ascii?Q?7abgqLLaJK7zDRYuynVDvMIJWkpRlkMVp2ehp0MR2xYZqADr2I9Chh52dhy7?=
 =?us-ascii?Q?IoCS1btQVSrnCWmLrR5ZBGVuHqm0FVDxQuRc4JxMJL2O50y1Km2wVDJkdun+?=
 =?us-ascii?Q?WOe9aA2HCrNeO5y6ntY/e/SeV5MUVMFE4Gsv+e7qZL83gdXon2z2QUCGyauq?=
 =?us-ascii?Q?e92VkFIfGmF/th0EELwZwQVX9vP5AbxuQrCSLvgJhif6j8pK3iMKCXWz+7CP?=
 =?us-ascii?Q?GnX5j7TA27tSj50ikbE7aTnxBEn15z9vFxK+l9fbqc2mgYmspynwoi+AGNzu?=
 =?us-ascii?Q?iVGeaFX1KZPYZzIyvsuzqFI9gXqFvcA6cGEc5xsXirCOMaWvbXu1amYEIlS4?=
 =?us-ascii?Q?C5aM3PVw0QWjaUu/r+OyoYsTr5VBNOjLySDp5VBNosYKn/T5TmdY3KLNpNz8?=
 =?us-ascii?Q?wDZjA5u7XTuoxxJQbMh1z5wrKyMt85OnsGTl+1iD46yvwTqBMKAh1A/IBy6/?=
 =?us-ascii?Q?UaDhfO8HoOPqDtUUAlNexHNe4YbvfK2C7lKRUWCoPlLURx0D+3kKRmgcHzG7?=
 =?us-ascii?Q?MoWBhzHmqNwCr4+0TN8X33gNquAWwl4Ap0oKt3EQdlWYx7ru3YvBb6ZmoXaT?=
 =?us-ascii?Q?F5EDdZYNbQOOa3JcdFzfRBFWtouIXbqfP7nMhFa8UFFbIYbH6HW9dOvoFbRa?=
 =?us-ascii?Q?/MGceGPwPOZDHf5LT8JmTYh1talmt6EeHdc9KO9518dqAjjwwQIdJzx9NT+J?=
 =?us-ascii?Q?FczpcUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sPDi/3elVKBMM4xIh80E/4d8RkEnjsOwHlaHj9DMT1+7FBwB4GEgcaJkHoCi?=
 =?us-ascii?Q?o5+EBPf0b9RrAqfjhe8gsuQIDDeOEYLOs5LUriKNfVR3pOOb96YWSsftdIrp?=
 =?us-ascii?Q?Db+BjaD/zXTMBFjDJwdAt3uN2/+fhlJFLyD54urF8rJDUI6obBJ2pGdeDtUV?=
 =?us-ascii?Q?AJHYKVsK6JtaYxmeynStP1I1ZvFkzzehuMlyaD5GoxJpiB9PG6bVH1UNIAr9?=
 =?us-ascii?Q?GQVhQSxZ6mAE5ePuMJpx0EguFalDsY/hIn+XkrcK20AvZWJn3MyGp4utPalb?=
 =?us-ascii?Q?vT5e1ckxXALZ5PjPbP0bSyJzs5YGMH0bwZWpCaa5dxlOOV8Bc19HluTA6cEW?=
 =?us-ascii?Q?HH9vDces5T7QA39o8d6+yP1Tqt2F9fNv+hjhm9AmjIDfTwNnmmYysW8INtkV?=
 =?us-ascii?Q?QXdJ/pYNy/c2ykQJ4BCmxQBdHD4a4tUenEJ3NGHbpzrXSEge++ubNPWmMGJX?=
 =?us-ascii?Q?mkyTiMQ7n1itATbWS/olBxw+6Gm0q9ZEvU0oT1n0Qq/vngMHiZwwh6cHsx+4?=
 =?us-ascii?Q?47cndcf5WMd6JFwzzhIYOir2/9dYl1ActdS/1fvPRMUmIcFRnFFwygu2E6vH?=
 =?us-ascii?Q?SDJ25Jlh0z5WGpBJR4oJn7T10p7/rvhDNsLxpQADXcywy05n0KdFj0qwHHWc?=
 =?us-ascii?Q?XadOfR/87eQzhemAGhdGkzQzoR55V7rOvLUXfsZZe/bIRolCjiG907HIrOaz?=
 =?us-ascii?Q?wTOtjezGg+Owo90YreVxy6eK4CvT5eh/394EsVUWRFUbs3mUBBJRorsuMPKA?=
 =?us-ascii?Q?0t2vYyHy4+/1amrGPBtou9JM58b4OevCcNoKo+MMYpapYgfgc69336285CO+?=
 =?us-ascii?Q?1BlUKLrff1hui9t0GmqpGuWzQ4TEm7wNfvIvwJ0uceNAI+jOyjHMIpCalYwF?=
 =?us-ascii?Q?cgMOnetfNkqFL0eUV+SyCSvPThwm7q1Cdqp3MJ80uz5KRLWPDqnJYI9WZ1CB?=
 =?us-ascii?Q?c8bvVHIsfhwo2LKYLRY7su+ro26d5x0xHMMsbIvHTywz+9dB7mRr1sR123Mj?=
 =?us-ascii?Q?ovdcf7yaK2ppjLWBmSoIbcsU5sL2hZux++6paRF2v3rBKsp8OAd06W1H1wO4?=
 =?us-ascii?Q?kguLCGqwPe92OoIs5p7AjZ4k1abqQI6+a/1wqrwK3Gmwswjx/jp70XlpeT5k?=
 =?us-ascii?Q?R5QaoZKDnDjfcwCpKy6ZxXaQJNESTj0KFnfun8VjZbighKLLMKS6xe1Gos1r?=
 =?us-ascii?Q?rYY40WkbHt0uybB4yJ6BwAABHwGbBdz+6o4a2UpIXuSuwqxJpXj0tM87K+pi?=
 =?us-ascii?Q?vsrA8Id9CkqfUGZgBkD6wtJy/SfKd4yCbHoWW2iwG2JEc5M/kdBVUYQ3f92e?=
 =?us-ascii?Q?ps4KAc9evLgbwNSHTJbGpUb3jAxdKE1mdf4TdE11y+JRCvBBrLpCfYpRT4vG?=
 =?us-ascii?Q?IABrnVMiJvQSP8yieHNYUJL+FNPdfwLR6MsCRHdev5lXP8X6JRU90EaNKoFd?=
 =?us-ascii?Q?CCZSIrjgAzj5RatTEVyIBblqGp0PTJ/uGIo2eDLJ0n6NrguHyBgTfUThlqmU?=
 =?us-ascii?Q?8h0pB5yT+Tfa2OW05Rbbhz+sTywI8lXqJpijECytVC1cOnMMZqXt6MK2vxOG?=
 =?us-ascii?Q?fjjltBGAasei/48pqjwkpr89YQKK+6/VRTpO+Zv7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fc2303-6919-45fe-ed4a-08dcfedfcf68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 03:53:59.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ppwWKiQRFWXSjAoyJHIBQGSaOYB/E8gI12dD7RKTFT4Af2k9gOaQrMvMmRTSEcJ4Q4+xgxdsZsdz+PrnVCKfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
Tx checksum offload. The transmit checksum offload is implemented through
the Tx BD. To support Tx checksum offload, software needs to fill some
auxiliary information in Tx BD, such as IP version, IP header offset and
size, whether L4 is UDP or TCP, etc.
Same as Rx checksum offload, Tx checksum offload capability isn't defined
in register, so tx_csum bit is added to struct enetc_drvdata to indicate
whether the device supports Tx checksum offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 52 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 +++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3137b6ee62d3..f98d14841838 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -143,6 +143,26 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
+{
+	if (ip_hdr(skb)->version == 4)
+		return ip_hdr(skb)->protocol == IPPROTO_TCP ||
+		       ip_hdr(skb)->protocol == IPPROTO_UDP;
+	else if (ip_hdr(skb)->version == 6)
+		return ipv6_hdr(skb)->nexthdr == NEXTHDR_TCP ||
+		       ipv6_hdr(skb)->nexthdr == NEXTHDR_UDP;
+	else
+		return false;
+}
+
+static bool enetc_skb_is_tcp(struct sk_buff *skb)
+{
+	if (ip_hdr(skb)->version == 4)
+		return ip_hdr(skb)->protocol == IPPROTO_TCP;
+	else
+		return ipv6_hdr(skb)->nexthdr == NEXTHDR_TCP;
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -160,6 +180,29 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			bool is_ipv6 = ip_hdr(skb)->version == 6;
+			bool is_tcp = enetc_skb_is_tcp(skb);
+
+			temp_bd.l3_start = skb_network_offset(skb);
+			temp_bd.ipcs = is_ipv6 ? 0 : 1;
+			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
+			temp_bd.l3t = is_ipv6 ? 1 : 0;
+			temp_bd.l4t = is_tcp ? ENETC_TXBD_L4T_TCP : ENETC_TXBD_L4T_UDP;
+			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+		} else {
+			if (skb_checksum_help(skb)) {
+				dev_err(tx_ring->dev, "skb_checksum_help() error\n");
+
+				return 0;
+			}
+		}
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -170,7 +213,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -591,7 +633,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -624,11 +666,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			err = skb_checksum_help(skb);
-			if (err)
-				goto drop_packet_err;
-		}
 		enetc_lock_mdio();
 		count = enetc_map_tx_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
@@ -3287,6 +3324,7 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.rx_csum = 1,
+	.tx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 5b65f79e05be..ee11ff97e9ed 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -235,6 +235,7 @@ enum enetc_errata {
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 rx_csum:1;
+	u8 tx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -343,6 +344,7 @@ enum enetc_active_offloads {
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
+	ENETC_F_TXCSUM			= BIT(13),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 4b8fd1879005..590b1412fadf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -558,7 +558,12 @@ union enetc_tx_bd {
 		__le16 frm_len;
 		union {
 			struct {
-				u8 reserved[3];
+				u8 l3_start:7;
+				u8 ipcs:1;
+				u8 l3_hdr_size:7;
+				u8 l3t:1;
+				u8 resv:5;
+				u8 l4t:3;
 				u8 flags;
 			}; /* default layout */
 			__le32 txstart;
@@ -582,10 +587,10 @@ union enetc_tx_bd {
 };
 
 enum enetc_txbd_flags {
-	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
+	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
 	ENETC_TXBD_FLAGS_W = BIT(2),
-	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
+	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
 	ENETC_TXBD_FLAGS_EX = BIT(6),
 	ENETC_TXBD_FLAGS_F = BIT(7)
@@ -594,6 +599,9 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
 
+#define ENETC_TXBD_L4T_UDP	BIT(0)
+#define ENETC_TXBD_L4T_TCP	BIT(1)
+
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
 	u32 temp;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 91e79582a541..3a8a5b6d8c26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -122,6 +122,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->rx_csum)
 		priv->active_offloads |= ENETC_F_RXCSUM;
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


