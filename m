Return-Path: <netdev+bounces-206082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51645B01455
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B18170D0F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B320E002;
	Fri, 11 Jul 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iBVBGKhc"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489C1E5B6D;
	Fri, 11 Jul 2025 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218288; cv=fail; b=RvaqinUhYhG9C1DjuAqcakb3Ig3u98WV3S17HMS/BIBRxWcvDVWJlMiqHOImq32ApzK9+LZxnY0BGo/mGALZpIrZHaoxe433xplZTwwOF8z7H9wBwgmA9NKxoR+HqTvrXSPy9gRgop1bcXbk7DMS33QgCQinx+mVbiSIwfxJvvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218288; c=relaxed/simple;
	bh=cLcl0njecwBydV3q417qP+A9KOA0UW4qnICxcdXYz+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kj0zCS/sx6iC5j9oa+dtLnZyUGtFhsE9sNwQuMNPGBq35kEzr5jV1DZIrsqA0McSVqoKC00swGJEeaLgGm5jC4zuqaTQsO4luKfRY6QMxBfTJ4R7cXfYXPStSfMySAvKpInzUYWIW5trxkJdjM7Pzi3k+LUSI9wkaMaAmC9qoUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iBVBGKhc; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMRGoipLpc23zZ9jNJ2j3OLXaWEE4rbD4OmpuxrrUCNBWvYUHLWF2Lhku7lDwUsLupovzAORynli0eT10KRmf2fBWq7SB7CZ89Q4eJIMcmXweCw8ND/ehPTCa+0XILTUZQsxrEfQT2IN/Llbhk9Q1pOUzFvyifopnNSmLZGfWbpr6oYn2ABaORZd769S9G81PXmN+VKmfHYOO/qCSEVissBBrVkgo00Smep2m1M+FTXN/uur3XHnB/bCNIKakIr0foIHzPHaAwaQ98nnDWHXU9EmO8yjP8YZWCwtnepeJFakUjEFSDLtHsZyUSDGGluen7WP7KheWLwiylqsStkJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ1d0o/8FbjGHJD5TksFMyHrmGobsCcF2PQdMx0A5dU=;
 b=QtN60BEKcB7r4KFLxiGdRtidVjwLBCkhKpX8jBPFeYxSbYVZ0T/bxvUalsh3vtafOFyPSfLgYjBve+HfMONvWfRXWJVL0YgdXwkd556Qes1bEuIIZFRvZgBgfrwBb8p8oGYhQVffx2JQV9Socbk50frOtq8hzK019YsT+tnXHzKmRlDLvP40JDvc3FLoAGVGUyJuRECBGMCoftpwRwnanLpV+yHbGGho3AyUDFzj0HXO7pVb9t2InS+drU2Glo/eiFhuHQIcK14T5DiXF2utMM1ekljLY4YVjywK0agnz+B7nTuHZsGTylR+Vz0KuzLkDXYvMuxxJ7yHSX/ISnm8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ1d0o/8FbjGHJD5TksFMyHrmGobsCcF2PQdMx0A5dU=;
 b=iBVBGKhcenRSPevlOEr9Fn4BSYZ4FWNmwTHOnmzrtDlDcOCqFhSn1Y1auUhOP5MI60+CDd5+sRhwByt5NSK7NF/oeZJl0iiRqiHaBB1DE4rk86GrA2bkGogSImqOOeDsd7pweLexih+8O4wbHCTM0Jj9UKCdy0DxezByOxhwTn4mO/D7lb95o8cuW6wD8W91ZDlXEyfpn7Oj4bubvBKNTTiBvH8Cuu44Riv42PPLtdzGohmrFBTIlYVRtqYmq/B0j+dG9P5l2aShB58IISgvhsNphntcePh1ude7/GHU//SbgEtb/b5IA/vLJ4vBczMERWdWSVZKrKkadS6p+DlOGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:18:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:18:03 +0000
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
Subject: [PATCH net-next 09/12] net: enetc: Add enetc_update_ptp_sync_msg() to process PTP sync packet
Date: Fri, 11 Jul 2025 14:57:45 +0800
Message-Id: <20250711065748.250159-10-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: be3c834f-eb3b-4ec2-bcac-08ddc04b12f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/2S4CriVJ1ho/XQIVp9X5Dgzfn6/+j0D9VTRb0sxJXLLTIBmLSwYGhiFa3rc?=
 =?us-ascii?Q?5S6BtYEdxWypfqGgVMRVhJdaE9ULRNKZ48qv0de4SZt30EvLJ0Ujt8mzcjfr?=
 =?us-ascii?Q?ncHcTvkz3oTf8ZROT2FKBo8xwO6VLVMVbD2UZwLq8UAct7yUGcBqbYeKSSVL?=
 =?us-ascii?Q?rwhTDaQYGGYmuv/iV8c4P5O7t57jvTq9bGxd3QirmrExMPyo8606VXtk9CsB?=
 =?us-ascii?Q?KXoldirdlfj8zjX4AmqbNwh0JjjNS2Xkmf+v95hJq1b+a/9/GKNoCzV2l/oP?=
 =?us-ascii?Q?0rXV9LtuYpfSq/GRzZjMCYt/cPUNfdJaFyFN0no1BcY9nwH54dnMLjuKwiK4?=
 =?us-ascii?Q?WfEmQOzAOK1mWOWJJQ9lkp9jnfZJKl0yukrMFj+pf5akZ//PcmMPLPL8NsP9?=
 =?us-ascii?Q?MGadAizGrPfYa8vzL/uT4+dBNYXQ9nnkG54uDoDrmWKgvHhvGSUI3fkTekTY?=
 =?us-ascii?Q?MKY4d8At5jr+99yxk3SDajY58zP2j3kIgbp3M65+bw/HFO5hS0w7OLRDsIfD?=
 =?us-ascii?Q?LvBxLRRW/ahqeTfFoLeB+aI5iUGqnIMJ07M3giRWbaXVMZWJi120Si39fD81?=
 =?us-ascii?Q?47OdEw42yVmvrf1bVXWo8Qjscx34GpOIW5mDA2yTY7Cz1gum+tUjr0VYTN4j?=
 =?us-ascii?Q?wBV8j5vQRFjjQsIk7XhkQv/gTxYLDR69GKt6cytn5l8pD3SEtC6zjb6uYe7u?=
 =?us-ascii?Q?BghCgeiH5dADO4lxzy6VvWHcnCPfhE/PYJk2N5K6E20lLSanrgw2DKHNSSxz?=
 =?us-ascii?Q?Qij+5J2LMd8+coLyYSBNEz9npZ7bdHS2AcpKXS3DSRLCgtHs/g5VW00vHKg+?=
 =?us-ascii?Q?DEdvH0CEOghLBQHuB62roIHB/23Gd8gcfy+bWw0uyTquMwNJW+INnpItjjhJ?=
 =?us-ascii?Q?4f/RThNJIkIJZF4Tfszfdzdyjeujb00knPzghA8GTwz2KfVwKcC2m1OeyZ8I?=
 =?us-ascii?Q?z/o1VCfS1cGXpRSDbpN866eB5g+v7npOBBsE1j8yoCfhOD1/tfIlH3GIh3Kz?=
 =?us-ascii?Q?0ivw843joxcVZG3d59d3acbarJW68BJL36ddMS/rCWr7PoQ3PI6/BlwFx++8?=
 =?us-ascii?Q?jU3yevDbSs68gcxfiBT/Qud+ejuuRDJ7dxmzpvLVSXpLYeS+QU4OsBLe52IS?=
 =?us-ascii?Q?19Lv1F1+m6BXNZc62I18gmVNDOxM7msnm3Zd8q0xPb4iXRgpq2QAHKjsgzin?=
 =?us-ascii?Q?fvrm+so7/TdX0/uXnltTfA3FuYhK8c4KNZX2z0K/8SLVy7P6S/pyCPZAIx7W?=
 =?us-ascii?Q?q7yobZBu4A7xldsg8M04GfCUuktGlL9BAfFBr6Nk78qMc9ymcj+DS1ff9H6F?=
 =?us-ascii?Q?UIxOQHoVIHCP5REhgneuOHaNYU25zhT41/476aatK+sH2MNR+52tlxrqqkau?=
 =?us-ascii?Q?y3sW5SfeBzIidhIfuoLMmqnLAEC3ABc6ePg2L1AwOF+juxAbIYbUC7LX9bJL?=
 =?us-ascii?Q?/CRLGpvJRElAdXcAE0bEOfSLXwrhsaMV5rsThP2MMl+Ei7blkQ+AM0/2vbCX?=
 =?us-ascii?Q?lQtB9Q5OtGUma90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFx7lv8no4lZ6rbwWjytmcBVyKPtUg2lTrxBXTiQZyRK5a+XcSyVfVH7m0DD?=
 =?us-ascii?Q?JUau3qAfGUG6OKPc5uMrlWlH28tqPICpqCLKxAjplkPQ2ZVOFNLPlRGoYsVm?=
 =?us-ascii?Q?2/9DuQ2EhPJK7zGeAMPUkhvZ1vm1ENEncyuKXhZXDdpNN8Q/5zkqH9ybZnqR?=
 =?us-ascii?Q?gblaIFjLIDodZO2dV1Lg/n26nD3cprY40sVFKITapm5ojVpKD/mtY4fd0lls?=
 =?us-ascii?Q?9BiWg/SP+aYupT+qK3TB7vSu7xwNQU8BiKyodSxpXZjO8DQt7V8Lx5X8QOo/?=
 =?us-ascii?Q?OI8fyYCGL/UEIQyS99YE5SkB1Bx5p4xNY+2DGyMVifi8ZSJh4l0U2uvd9okQ?=
 =?us-ascii?Q?pR9rxfdDDohepHQrrRhSCBd5kFocqOkeJ4zS+MPOor+ZbBgZxmVh+EM0+yAG?=
 =?us-ascii?Q?TvA5dp5GB5aIou6/MzTtYS72Bo4DFBJmQSE1HnVy2MZ28CN/yPYs22HRm6ND?=
 =?us-ascii?Q?/VyTGxEGjFuJX3ugNoiSxtcErhezsre9q0jP1DHXsws12O0iLR71yfGFcK25?=
 =?us-ascii?Q?jjiZ4X5IQ7himdYjJEtqbMKTJt4EBDx8TCHbZC2fC+INMKvf1wD4rO4cctyc?=
 =?us-ascii?Q?F9GHIkP+zFtkEG2svz9bUZ+io8BKxrU3Erc5Da2pb9b3UXHbCOFiwz1ndu8q?=
 =?us-ascii?Q?DzoyYIIxWjiab63r7JZc3X9osd/LmKi/kHN510vuhUEUJo3EnGzCSCc5IRoH?=
 =?us-ascii?Q?LP9fIgBJ3re38P4vwogoF2mF/EcIGb6MnmbX+d4wxTiUE94rSPj7W61x/qFM?=
 =?us-ascii?Q?8YZYmRxMTIA6vyh3/e8rs5U5Jg7WCqYK5KdKwPckrm7bkxweIrCv07j+Fb+u?=
 =?us-ascii?Q?gO3/4zgZfZk85hUvJP5JrtAvK0uED0ARbfg66nKW2gWz19wCYjcmWiFgOo4Z?=
 =?us-ascii?Q?gLhRFMvN5xFKYh26UWYLyLV7x0c+9FXd3qg6k51EA0VEI6WsujFhM664WoJ8?=
 =?us-ascii?Q?MabsRrJdFbvNYfSxST0qNUmMS2FpzogmKuUD5S/kGzkOxnRit6p+Pm8Jm8BU?=
 =?us-ascii?Q?jK++oRFSuf31NhZ56/jydrv/TEJsj95vKRCovzX2sEj+xqKXsmE6KqQNQdoh?=
 =?us-ascii?Q?9u5FmLhbp0W13lwgS2JR2jAaY4l25/QxdNVt/N9O5Zf860Mu7+QLksdK+k0T?=
 =?us-ascii?Q?AsljszD6/cGK9a78LHAGDx1DwEXRDlafYo5ztDZTUprh3HteZLQn2ICwO10l?=
 =?us-ascii?Q?ZA03Y9gfz4TblN83QLIz/sAgb2in6RzO+3AYMo9x/N1RLCup3IMX51hqolG5?=
 =?us-ascii?Q?fHSZDHn1NwK+/hwmMYkKA3ySK6iN2zPhDU2masEQ6SPVpV/Ee5zpO1YRY0o9?=
 =?us-ascii?Q?hJYdZ8uOfg6k7WtFdKZSYM8u7XZiUSHCjs1WcZorXPmqN1b4i2UVOg3I3E7V?=
 =?us-ascii?Q?ciyMDVczPn2NSub4ijQyt4PE3kc5cIGQ5AnmDMoqdyBZNKLM5yuHbXJqu4Vn?=
 =?us-ascii?Q?Ey/nYxED1DCo5flDN048RO9BjFJ65NzTFuKaxfRcd9dUcMVtlz8QS3dXil/9?=
 =?us-ascii?Q?D3HXxhTU/ZPtYOdY9WGRqYB9N11bS9Ei0mGIw5/i83iFH1beNx3wnF60A0Lh?=
 =?us-ascii?Q?luqvxOU4NN8hYeKrW9aj4+yg92TFNlX76zrWoe2j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3c834f-eb3b-4ec2-bcac-08ddc04b12f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:18:03.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAq+sOnTmwBaTQBQPDoQczJIK94m4qAq6Ou3tOs2zkTHmkYhfvhtRe1/fnPB1UPvD/v4gf63gJ477lzPVAkkDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

Currently, the PTP Sync packets are processed in enetc_map_tx_buffs(),
which makes the function too long and not concise enough. Secondly,
for the upcoming ENETC v4 one-step support, some appropriate changes
are also needed. Therefore, enetc_update_ptp_sync_msg() is extracted
from enetc_map_tx_buffs() as a helper function to process the PTP Sync
packets.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 2 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c1373163a096..ef002ed2fdb9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
+				     struct sk_buff *skb)
+{
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+	u16 tstamp_off = enetc_cb->origin_tstamp_off;
+	u16 corr_off = enetc_cb->correction_off;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+	__be32 new_sec_l, new_nsec;
+	__be16 new_sec_h;
+	u32 lo, hi, nsec;
+	u8 *data;
+	u64 sec;
+	u32 val;
+
+	lo = enetc_rd_hot(hw, ENETC_SICTR0);
+	hi = enetc_rd_hot(hw, ENETC_SICTR1);
+	sec = (u64)hi << 32 | lo;
+	nsec = do_div(sec, 1000000000);
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanseconds field
+	 *
+	 * In addition, the UDP checksum needs to be updated
+	 * by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong
+	 * checksum when updating the correction field and
+	 * update it to the packet.
+	 */
+
+	data = skb_mac_header(skb);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_nsec = htonl(nsec);
+	if (enetc_cb->udp) {
+		struct udphdr *uh = udp_hdr(skb);
+		__be32 old_sec_l, old_nsec;
+		__be16 old_sec_h;
+
+		old_sec_h = *(__be16 *)(data + tstamp_off);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+
+		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+
+		old_nsec = *(__be32 *)(data + tstamp_off + 6);
+		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+					 new_nsec, false);
+	}
+
+	*(__be16 *)(data + tstamp_off) = new_sec_h;
+	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
+
+	/* Configure single-step register */
+	val = ENETC_PM0_SINGLE_STEP_EN;
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+	if (enetc_cb->udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+
+	return lo & ENETC_TXBD_TSTAMP;
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
@@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u16 tstamp_off = enetc_cb->origin_tstamp_off;
-			u16 corr_off = enetc_cb->correction_off;
-			__be32 new_sec_l, new_nsec;
-			u32 lo, hi, nsec, val;
-			__be16 new_sec_h;
-			u8 *data;
-			u64 sec;
-
-			lo = enetc_rd_hot(hw, ENETC_SICTR0);
-			hi = enetc_rd_hot(hw, ENETC_SICTR1);
-			sec = (u64)hi << 32 | lo;
-			nsec = do_div(sec, 1000000000);
+			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
 
 			/* Configure extension BD */
-			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
+			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
-
-			/* Update originTimestamp field of Sync packet
-			 * - 48 bits seconds field
-			 * - 32 bits nanseconds field
-			 *
-			 * In addition, the UDP checksum needs to be updated
-			 * by software after updating originTimestamp field,
-			 * otherwise the hardware will calculate the wrong
-			 * checksum when updating the correction field and
-			 * update it to the packet.
-			 */
-			data = skb_mac_header(skb);
-			new_sec_h = htons((sec >> 32) & 0xffff);
-			new_sec_l = htonl(sec & 0xffffffff);
-			new_nsec = htonl(nsec);
-			if (enetc_cb->udp) {
-				struct udphdr *uh = udp_hdr(skb);
-				__be32 old_sec_l, old_nsec;
-				__be16 old_sec_h;
-
-				old_sec_h = *(__be16 *)(data + tstamp_off);
-				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
-							 new_sec_h, false);
-
-				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
-				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
-							 new_sec_l, false);
-
-				old_nsec = *(__be32 *)(data + tstamp_off + 6);
-				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
-							 new_nsec, false);
-			}
-
-			*(__be16 *)(data + tstamp_off) = new_sec_h;
-+			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
-+			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
-
-			/* Configure single-step register */
-			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-			if (enetc_cb->udp)
-				val |= ENETC_PM0_SINGLE_STEP_CH;
-
-			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
-					  val);
 		} else if (do_twostep_tstamp) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 73763e8f4879..377c96325814 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -614,6 +614,7 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_STATS_WIN	BIT(7)
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
+#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
 
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
-- 
2.34.1


