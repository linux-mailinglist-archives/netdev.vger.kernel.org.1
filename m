Return-Path: <netdev+bounces-113779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E17493FE55
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221FF282D22
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60771186E3B;
	Mon, 29 Jul 2024 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TxGQ5HwN"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013038.outbound.protection.outlook.com [52.101.67.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11F85947
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281756; cv=fail; b=usQrqTRwNHD695ua+xUwRXDHwDjBNu6EzwE/IsEvrlmu43FB2fkg+8nj7LI3MhAS+UuSw/FN+6phMXHfBsTkx2kY8cS0Qk7/q619IDFOttmMb/H2Rk/mJOJG541d3SXZ/OFyRZUx2I57QnFUKtzob3FnbQx0qbGwmjfsq49qzv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281756; c=relaxed/simple;
	bh=DNhd2f0C3IFNkpJtJ3K1Dggbblm6bnyJcwakCk+Za+w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WoM5107OcrHwTww8RRUESRSY3nY/2z4XneacDf+gawb9POKtzlPbHW++Wke7+WTl4baxxOEkiZ3eyjkcuwl+Paiav0Yy2ELDWLmyx7nKqDpPv8Zzwahje4rDLBWPlvYRtMOsxgg6K4RZuo8zUFwIU1nJs0nflhMx78iNIjYRcsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TxGQ5HwN; arc=fail smtp.client-ip=52.101.67.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3g9UKq+hsWLJr512JFfKcnkqSzQbCoLzugT2ME7p7vfNUG+TA1laLheTeOAmoDe+sDsYXPpoTHkHjkHreNNsLDrIMMVR7uIXrWHKSGa3bOheyzirFyP3PYe1YzRgwIY9U5qm1mM0X7+iQmllJ+w8LNEjupv0xlyVxM1MgscnFJzUyKcOYHbK10Hpns7dYH4uRPONpMp/qZN1b8Z39WH46GMWdzD8T5x6UxESmxyY9Tx+d2vz1/Ffsco8sVqcTIhnFejmlFu68bWesmwecM/aqElHDVMBCFPf/vI/xyKBpkVQ7goWQrz5Nu+VuXsLT2AnQAdXrMpjSrJ0yeFvdOe7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCR5O3OIdzW1hlWJVQUzhhb5ckHp9QdKFALG8jkyxHQ=;
 b=zF0R6Ae1ZnRNYatb2ADH86o9ueMEBzOcvD2JNfNaAGsRKYtZhqKmU60cqUn+GaMH/QPvV+iGToZtWFaDMhzlH4BfjpnMZZkJoxFKnBB2NB+iwbKi6ghW881hksoJkA2MplV9+CFb8KyCphQy/OSm9WG/reivqR2SLqUWKUf2QM79liw50ELq71YR8YHpxTv1CyPxuB0n5twGNyC0QfcWlqaCXZAFzhRGizuY3DEccMyoZ904fTaef5tpk4LpmMunjLqEcZAYD3woRrzFggVdpii12VvdYrRIRx7fqOHVzqumvuuGCVHl/Qxaj81QmXCmLT3ZtfbAUVfeRe1bNd/BoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCR5O3OIdzW1hlWJVQUzhhb5ckHp9QdKFALG8jkyxHQ=;
 b=TxGQ5HwNA5yv1jRNt4/bSL5MmVfwPGwCCu4bFAH4X6JjG3d46r6HIWxGBdwmG+Rd0V7R5BPlPa03EtFiNfi1a5jAxYk9WYou88XJuun0V5mIY9GYkqYfTZs9BCNpOn6A7v49+C64ikMsR09IbtDfi+H//HdSLPyeqf2i5Re5/dBNIlqzXetRUm1y/vIjLAE3VIg8I7tiML/O5eZO0BRmGokX1b3bDpR20cZH8Y63QpZRfxq2v3VrYT3HU5IbqUBb+pcAG/mixLu54bp0amw8JXQMYa16rP/Hz/0NhnzG94RXuV/BZpVQukzoLVIGJL7hrp5YyTWeMH1/0FmbwB0pmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB7003.eurprd04.prod.outlook.com (2603:10a6:10:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 19:35:50 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 19:35:49 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v2 net-next resent] net: fec: Enable SOC specific rx-usecs coalescence default setting
Date: Mon, 29 Jul 2024 14:35:27 -0500
Message-Id: <20240729193527.376077-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB8PR04MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b81d5e-53a7-4ac8-ac88-08dcb005a68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2dkpvITQsP3jK3YmYsQO3/KDHnpHkF70odrX9xaqB3Hj79LL93SvCT0R66Xx?=
 =?us-ascii?Q?r2VEy4Ldx1wk3hUp/pZ6lhT0gXT6UGZ3TH5hZsUytAKzb59/IJWSJzd9vOjU?=
 =?us-ascii?Q?984k4gsgCXT4IlzXvng6qmnGfsCYsvIkhnlqJFqY6FEbT8zN8UnFjOFX0njt?=
 =?us-ascii?Q?XfBqlWL4WJEsy8dfuE4r9B3vBTZj3DKZF16KttbhGUkiVqDl452S+FZcAxER?=
 =?us-ascii?Q?N4z6GSv3Ady7sUlG9Isfn8TLDMeNdEk/CNIDAAeC+gwHjVehZcd+SxYCFJjB?=
 =?us-ascii?Q?E2/SEPO2Ih44Wuusep8+WFgZh1/k6G0JUsaE6TMnNMNm0FxQ8G7NXWFpss60?=
 =?us-ascii?Q?u1ervUfgRfjEh+T80ovcwylZDwjh9fbOU4OqaeGwLyDLZEWf/BLmfF9rYi8N?=
 =?us-ascii?Q?G7f48nToPy+LNF20SmzBsaWesiQQsjfhkRJVi6PWMjNujxAyqXctuMulnPy5?=
 =?us-ascii?Q?35h11wPvhvdU7eVo43yZTuht/NMLIeoZi3mlJwkJAvGB5URgmfPjS52sIg5j?=
 =?us-ascii?Q?bp63yq6Z9bWotzm15y8U00Yb36Cs53eMrAnjrOyV2a4Uv2Mrc6DsUtH1kLgZ?=
 =?us-ascii?Q?LOkCS+izV9k9EQamcxYZOk8wT+pbczJX0f2My9f65dgwSrlwKiI8ifCPn1Wp?=
 =?us-ascii?Q?nSqjciSeFJoNZj84R/+wve89M71z0zOHO9rNIi788H+g6ZGFCWFHMqLoDgge?=
 =?us-ascii?Q?znUZXzeRwiS+iP6HvzZlkH2zQwT4yOdgen97nLGxFozQlfsUn8ejgErOPw64?=
 =?us-ascii?Q?+03AUZI65rYJvl7TRk8FydmzAaZDa8G2opZy/7BMyuP59Nlyr3k9Iqhb/ZNw?=
 =?us-ascii?Q?yd9xooTuZz+NKeW79IVjD+HGGxIl4669RozfFzYoKeVaZdluFCW/IAErSq8p?=
 =?us-ascii?Q?8vftMG+bgVAvgiehWjVpceqw4lQchx+VJByBhGgRi79SWaO/KkJA5ifBXJdb?=
 =?us-ascii?Q?zVyOc5RefFd4eMAW/lvbTml2iFViDX5OmLLIrZoyS/Nid9tHrJDb3wUWR7mx?=
 =?us-ascii?Q?JiP5RxGYyaKzpTaixDlyRKrRkKHNlVIGYueBa8N/PM4+zF7On0KNLJbLrQJJ?=
 =?us-ascii?Q?c6FYCSWyU3SQR9WVDm4K6j4c50JHJ/jP7V5Vayi4SsR3A2j2D/bHBpD3A3N9?=
 =?us-ascii?Q?fufSCb0VgyThy6VP+pHnxOMK/neuEtGzNyXLjN+KBHZONaBt8W06oo8ff6Av?=
 =?us-ascii?Q?oT3mZppOwLJlKrHMaeDbqGwwZmic5xw/+t7jydmQzoaRxuSOqHCZXrOyTNZj?=
 =?us-ascii?Q?rJvzlEKShDkV8LGTuQCcZpmEbo8N1ADA8s4GmiqeCOnMEGsa4TYJUvbYJFhD?=
 =?us-ascii?Q?Yu+zCPt19YTOtqf1wQSkDcj4YkDEz4rnO1M4EFbWzRfwjAeymW6cZRDc2J59?=
 =?us-ascii?Q?g9oX8FVpOKschhQSg2LeReAgKIeYbDdEN9ONGcG0xb+89hZnYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1ZTCNjnnMUsxnOv7eUViyyUXUY6Zg1TXJyOpEhZvTB+zMfLmM52l+CaEmn9?=
 =?us-ascii?Q?ejel/+P45KdwSb5RyZinLy/Q01gQ51180s2ZCVY3Rh7IDfxop5uBaV1FRYDa?=
 =?us-ascii?Q?rUoQ0unKu8glaaJysqsyqhFI15C1fUnkYjpkeBIJnN5iTT6/BSIdRDQdQqIl?=
 =?us-ascii?Q?jdyPF0KjuccEHlK+rXrWU9a1mr++Fu6Qj//4nZWvUOQKMNhG16mtg8OpB2Rb?=
 =?us-ascii?Q?OxJdvx3YtWQEp3ooGwHlRU0O5PUD7D7OnpSHPWXG+J0CrW+z5c+kNNa4rJSc?=
 =?us-ascii?Q?UxpVM2Sj1qhf5O0hgf6Mbje82e1pW/nrH2ebdzgrjjKpB/ATCiuWoXoEgQC1?=
 =?us-ascii?Q?X0QWtrKxtIgOXxR1guHAXTf/ApR+/PHcfN6ET/N2nJDUFDc5IsF9hpINgcHb?=
 =?us-ascii?Q?Fov2PcGjiKbZcZeEBPYi+v/EuQTxHE7TupXRXnJZAOHAeBnybXA2iJ0SsDu9?=
 =?us-ascii?Q?zsdFnkVOCgs32Ej7HzJJBiB8w5CoVfP3BX3y/HWIGmf4s/4Agu073bEFGE+R?=
 =?us-ascii?Q?VyG82Fi2ZhfdjvWbHyWJQTG6ch5PWCc8AInbdLiFMXXkmxCJ4Qx7TSi0Ha25?=
 =?us-ascii?Q?IYfR70n+7v7D4jImofFr2l5Z0cLgHruB+C6HSOh6OHaR/IGRF8xd5KAkOpqg?=
 =?us-ascii?Q?vnxVvov9T1L+gLXDO5kSN2KVdZIHEa3hCDJzjPzdPOzgBuFGku2Fn/PfZBCO?=
 =?us-ascii?Q?lMETHa/egnfEKNmUMqKF/tYDJ2c5W3XS/LRPv892hXv7R0DpS1zzShXE3iEC?=
 =?us-ascii?Q?xEHaleBhDBrwi00WVavYtDVvDvUkuIY4kFBT09j2at3rSNKLC0tpfNO7Cyc5?=
 =?us-ascii?Q?f9r9Wsa1e27P6FJkZXDDOVC9W401aDbQneU5+U4nzHN6HdtkKCb5S/u+pYE0?=
 =?us-ascii?Q?tU++ESvBaJ0gh7MJEw4EjM4GLw0lenJAwl1BlDWBfD95Gbc/gsyIZ/kaCuuz?=
 =?us-ascii?Q?0lQcPBSDyon5MDLrz4nACXWeNNp3nd89t13wzbQAvMjQ2TW8YWfatryMaOWi?=
 =?us-ascii?Q?XW6Fi1pPew4zKALLqxfWwuSIDUfADMi1q9mSQjivA4DQQ65Y5F+J5yEN57xt?=
 =?us-ascii?Q?UQYMTfavoOOOIaGrzWZ+IyxUYtdYftDZqpToJbttgDr3RTotodkvVy/ynoBS?=
 =?us-ascii?Q?2FZFFsodOM81UWNlhT94rmp1CMFkorlE9LkL9sm4FxnJFNwUuMqRGueKFw5k?=
 =?us-ascii?Q?DFm7kQzuAkBmG27HDB9w9exTrCeWjJ2+xMnOTzGRKwhjc2vO18oyggUp8mDc?=
 =?us-ascii?Q?H+5e+ynELWgP+S2DPiEIb/jRT0nrZxp5l+mrB7Oe+Sncbt4DRLCEfbmRGGuR?=
 =?us-ascii?Q?QEjTvUjKtv33puAlnF5Schipnj2uzVvokCadkQEcA6od1TcR39EMgSd6CEYC?=
 =?us-ascii?Q?8qNVYhX8Rv+CK7BWN7T8WfKld90q6i7VJ3Y5ITIAlyXyrUyinHvrIbKqMisv?=
 =?us-ascii?Q?ZnqRLvT68aIr1nEsZcGKeE+WhX2RR69FdDe8fj/8otRNTdUVp1l6Wfu3PDyn?=
 =?us-ascii?Q?cZfqnI+8QBfpD/s3GZfA/XqQ2S82/ZNelG5bPFyxuL9BiSUvna0Jd/icPNge?=
 =?us-ascii?Q?5g1Vd0v04l9lgMFeCOgL20ifu56V5Zm1StZ6R8it?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b81d5e-53a7-4ac8-ac88-08dcb005a68b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:35:49.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvk7zhV+jOsEk666FbxqmSrEPNiA0f0yf4MsCwxaVBUkXy5JP9aMmDZqo1sT8/PcPBGMpGuakHBV3UwTJ7tEfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7003

The current FEC driver uses a single default rx-usecs coalescence setting
across all SoCs. This approach leads to suboptimal latency on newer, high
performance SoCs such as i.MX8QM and i.MX8M.

For example, the following are the ping result on a i.MX8QXP board:

$ ping 192.168.0.195
PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=1.32 ms
64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=1.31 ms
64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=1.33 ms
64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=1.33 ms

The current default rx-usecs value of 1000us was originally optimized for
CPU-bound systems like i.MX2x and i.MX6x. However, for i.MX8 and later
generations, CPU performance is no longer a limiting factor. Consequently,
the rx-usecs value should be reduced to enhance receive latency.

The following are the ping result with the 100us setting:

$ ping 192.168.0.195
PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=0.554 ms
64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=0.499 ms
64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=0.502 ms
64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=0.486 ms

Performance testing using iperf revealed no noticeable impact on
network throughput or CPU utilization.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
Changes in V2:
- improved the commit comments and removed the fix tag per Andrew's feedback

 drivers/net/ethernet/freescale/fec_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a923cb95cdc6..13c663dbf7b1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -99,6 +99,7 @@ static const u16 fec_enet_vlan_pri_to_queue[8] = {0, 0, 1, 1, 1, 2, 2, 2};

 struct fec_devinfo {
 	u32 quirks;
+	unsigned int rx_time_itr;
 };

 static const struct fec_devinfo fec_imx25_info = {
@@ -159,6 +160,7 @@ static const struct fec_devinfo fec_imx8mq_info = {
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
 		  FEC_QUIRK_HAS_EEE | FEC_QUIRK_WAKEUP_FROM_INT2 |
 		  FEC_QUIRK_HAS_MDIO_C45,
+	.rx_time_itr = 100,
 };

 static const struct fec_devinfo fec_imx8qm_info = {
@@ -169,6 +171,7 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
 		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
+	.rx_time_itr = 100,
 };

 static const struct fec_devinfo fec_s32v234_info = {
@@ -4027,8 +4030,9 @@ static int fec_enet_init(struct net_device *ndev)
 #endif
 	fep->rx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
 	fep->tx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
-	fep->rx_time_itr = FEC_ITR_ICTT_DEFAULT;
 	fep->tx_time_itr = FEC_ITR_ICTT_DEFAULT;
+	if (fep->rx_time_itr == 0)
+		fep->rx_time_itr = FEC_ITR_ICTT_DEFAULT;

 	/* Check mask of the streaming and coherent API */
 	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
@@ -4325,8 +4329,10 @@ fec_probe(struct platform_device *pdev)
 	dev_info = device_get_match_data(&pdev->dev);
 	if (!dev_info)
 		dev_info = (const struct fec_devinfo *)pdev->id_entry->driver_data;
-	if (dev_info)
+	if (dev_info) {
 		fep->quirks = dev_info->quirks;
+		fep->rx_time_itr = dev_info->rx_time_itr;
+	}

 	fep->netdev = ndev;
 	fep->num_rx_queues = num_rx_qs;
--
2.34.1


