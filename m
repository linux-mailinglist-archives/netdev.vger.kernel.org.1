Return-Path: <netdev+bounces-143632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDF9C3664
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 03:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F5A1C2166A
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8362614A0A4;
	Mon, 11 Nov 2024 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZbCZu55X"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38121494C3;
	Mon, 11 Nov 2024 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290901; cv=fail; b=nFPXiEWml+7wci5kYskvcSQRhGu1mAqRMsmzTyPk2FscyjWP3lkbpDGeF7m8txjuNzs6POjcCTviG5X7nil/L0hEqKslWjL7/FcFxBLqxsDfgi6Vmi1Op/91H1kLa03dE/PpB4MfY2LomcsF8VNaehL8NX5KG+5nT7s29IVzEPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290901; c=relaxed/simple;
	bh=90OAde0W6CwTPU9ou4o6fXBFZZXHzoDnwTF4TE8wJq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PnE+Qr5cyInGFPLFRBRrpyRGjQLSMw79UjGGIAdah+OHtrG4DENd/vhjvivaLtnmLzUyatqSfcfWxXtDU30OUiBQS1DkvL1HINvmZ5mWByAmXTzLFK8p6IPEpLkfAaeLrWepQyEK8mUiwzDHdLR7Ob4zkmeihGcyR6W2C39Q0SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZbCZu55X; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiTgUaCLxS/+PrICMfiKDBROZCZkhb95U5C4MXGcqcYunvOLq8fSKEhRu3of3RhXMLoKbmCpe3NJfun9cU7nkkT18UjmlLHG0ER3v9m/1yVfFhSh6nU4JI2D8qEochMAG4LD5Azu/xP6R9kHMc+wEMNT2xe60mjeMyDug3Bq4Hne77br8nCQzsLDgv1agoG67lUr3Y1nRyy8srfrmjxwv1O5QrFQZcJVoTuIaKO0rMOjKdLdUYpvTQrzP1AyyQn3u+e0KjA5v1qtzon/Ak79G2gNV8sdFm4lytvZvp2iQiJkYye9Uyvr18jPvNdS43wN94o6Dc/dZYIc6hbiHov3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10DpXboWPMq5+j42RzAkvpoLEvqfUWZfWof2RGfeLkQ=;
 b=R7fCA2rsC0UxI/vCRMmOzoeoJSwu8SU1+ze4z9eX2iVrANL7iJ/VIOhN/yx9dXOyoHs6LNYYIAMZPp0rvEJEWToaJVWS7IM19kSq7+j08CrVa470mDO6PLopkoF40GAfbITn+eCTq0IJyTEAce5hCW6mcNYZlMYKcZlZ8hAOxDjsZosQ6+ALHE3srayWwPxrY6jt/mWmwvH430PVCBYhjgr1mglN5TKhOZHEKWzsx1arjqLRZjyIDcgGU5C1hlrE/37pAQWe3QhsNxJV81Od09kQyjS1T1rZTTPd+M05uHwL3vzKzzwimavYGCSC6bxwO+uu0lzq02BpVI+Ec8oKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10DpXboWPMq5+j42RzAkvpoLEvqfUWZfWof2RGfeLkQ=;
 b=ZbCZu55XyTMYHsm4UfX/WR+W1j4OQ3b4LKSRMb4BTbcEcYoHl/6g/FYJ+DMgyXIShYKds5mSNEdNbFNT1mlK/G5jzYeoWAvC0v2j5v5gdUErCic7ileVzzp/virrdS5UsaNX79vD6SfZtti+AD+iG7bPSt2xSLCeEeMH0lYT0Tkz+VgzqUMhWCkH7vePSZAcHFx4NMarbyGRvzRPt13198b6hIrSeq7DlsixvoH4fDqmAXZBPRT06S1txLWP+0rxBWYvZyL0eG+MGEQubXb+RLsVUM2LZlDK5ChqNyKSWqWPS2UlOYjCS2O0VDjfAFjMbzN094ObvWr6OddUXo16CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7745.eurprd04.prod.outlook.com (2603:10a6:20b:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 02:08:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 02:08:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 4/5] net: enetc: add LSO support for i.MX95 ENETC PF
Date: Mon, 11 Nov 2024 09:52:15 +0800
Message-Id: <20241111015216.1804534-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111015216.1804534-1-wei.fang@nxp.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: cac1f740-f449-4e19-ea99-08dd01f5b45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bxcB9X4VOnR2LYUjYNVv9CMdjakR9UAbe5mmyNX0IwX5NAqR2UUrAfxy2xsJ?=
 =?us-ascii?Q?gzhTzX0Yj9kq5UoAezZ5v0ul3WZrlKuLLzIZcumtuNdmLjOKTbV3Jin8Cj46?=
 =?us-ascii?Q?yBjXIrZYxlu+GuW2QqSqE/4q5RMWPK/EU1aAEny2mRi+M5Cy5v8lorFyiOMd?=
 =?us-ascii?Q?EHPBK2AZYVLx53faz52NCIVlA7oIG+NpFlNN3VwxrzhEca2F8izDyAPLtAXj?=
 =?us-ascii?Q?3nBmVqDcQ/NytBe3bwr1oBTbsPiGVKi68WEon2aM4GGAsHEajqzM8ZYUkpXL?=
 =?us-ascii?Q?XB8u7wLobOr7BXIOfoNGZpXbHGA56nz1vNPtBUI6SUr1iewLz0nnh0CMTYtZ?=
 =?us-ascii?Q?eufIMi2VLaTfwG/AeUrSjvfYIvUpAfINA9GD/VojP11qyF4fhBcewxRtbgGk?=
 =?us-ascii?Q?WFT2eM8egzF/r9hZSJt1XgB7p6IKDgdS9Qx8MC+U3/w43Qe4wrM02fwkOS7g?=
 =?us-ascii?Q?hhaHFoPzuZQ5nNgTZg+8sqry+bt/gJdAWg9XiqgEFba+/rllj+0Xjrqjc8hU?=
 =?us-ascii?Q?gJlBp8em77el8qo5DVgzrNrwYoIMDbCrvFjPWMRqNtHqF78oomc6xxHcRxtb?=
 =?us-ascii?Q?561nH3LwOAEhCvvlHePrqJ9SBeRF3KJw1+oyYbT779DwxG2M53fyD2x/63pk?=
 =?us-ascii?Q?bYFPHvIx8qH10DR5FWLv3b8iluRraqovmIrI1Y+RTmH/L8L/O09fKKiEl35B?=
 =?us-ascii?Q?7ay2XyMxCFRje1j1SMjA4943B9PlAKukNmelBWj1/3gO3FmPa7k+yuO06K5L?=
 =?us-ascii?Q?sCeEPy2Y9M6wG6SBMHYzZRAHDTCjU0DPy1Sovsgk4yPnlWdgBVODkrS52WoI?=
 =?us-ascii?Q?KtSfBVv9ap5iSV2OOexu8ryisyumtfEqlw/FsH97cb29G0HQsJ+OsSfW0+Zx?=
 =?us-ascii?Q?63cNIUEOopA6Vij0C/oAyQKdOFH1i0w7rVgqgMk0+De9fa93rvW7aQe6DGCo?=
 =?us-ascii?Q?0eUgrUaewcVLnLb49xg0CNVUi0TThXR92khAbLvFCicekKskRkObOsmCMDmc?=
 =?us-ascii?Q?o2ULQokFAnuUeo3/qRUNXsTzdCdZM7XcWQnKCaT98l5mt8zkvaxW0pgwLEGt?=
 =?us-ascii?Q?goyjSOlYUPc/o/m1FORo4CH1ejHlEjMEoJSAR3QA3tPGObqVan6AAdfp33Y4?=
 =?us-ascii?Q?Rbi6pvNlPDcGzgjqPRmH5masFY0A6ojnlVB/IrCnRB0SI5cBjGLJKHeIgZKt?=
 =?us-ascii?Q?vblASwbnTNTBS+vUtQkrJGQfwBgYeH7CppalqUZkEphF0vgKyF8oZDriO13D?=
 =?us-ascii?Q?VghIuOsazRyyTI2WrFqVfNA68D7rq52xt1GLPOFl+0JFtaCVbAV6QceHX/4h?=
 =?us-ascii?Q?IN3a1tTGYvzAC82k0HEnwlkxJPC4au7Q9d7hbXaVA/Ik3KCQwtit9gM39wqH?=
 =?us-ascii?Q?fusqkOk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKcC8bVFZg/G92BCIyAVQirqxAxUwRKixGgQV+0Q3iTKKrc8F68KARnFAy3Z?=
 =?us-ascii?Q?tPd7QqOhZ1dHax9giE3XUPfHByk8W/wYsvBJhI9wbesfkI3UMyG7qoaAhDND?=
 =?us-ascii?Q?j1Qpp6AhkUaf4UU4GxFk1hzo0yMUBJUEYMOiirSMGYlKhSCl8GD0l9E5jy5r?=
 =?us-ascii?Q?gCED3K9kSRTzHnfs4z2KwPLQF9rKA2t9blD2e3FLZmpqLxCQwskYhG0dcVao?=
 =?us-ascii?Q?VrCt/uNO0tNW5QE+fCCPMxxdIAbkqihmPLVGT1qIpvx6bOUyoOLwsFL+MsoR?=
 =?us-ascii?Q?K86NhigJkom7KWM2GbpfjbukeTeBbE7sYiYPfZ93868ual7irI6fkh3s58Er?=
 =?us-ascii?Q?i8hZUUceum/Og5p66sYyaQCOHc5h7FHf2WKjbq8S28Xz+UyipJMdQmH5UyzH?=
 =?us-ascii?Q?ee9uwxeHhCWLsJcqJnheoRUSuk/KYY7Y2RS6KFHJ6NYrxXVg7Zv/V/24TlXy?=
 =?us-ascii?Q?ffOu3B9PaGq7l9O//kh0EVmDo8TluW3J+2CdVV3n8V2dbOt504rH4W6khNk3?=
 =?us-ascii?Q?WRqFQfTObUTb6PrRz7qE8TPegXDdkO1ylqoyF0+Vd5oPWn6/ilRskM9T9qEz?=
 =?us-ascii?Q?shQ6xtcVSIO2M0uzaVEyJJHddQwnIRlEt5kkcgSd8qzzvrd17C+l/aGgPs/J?=
 =?us-ascii?Q?UDppyLUHHFkKUAZMW+2DSBMPu/HhFR0UiW63PGV5+m1jBIbUE8+7P7R7Xvf8?=
 =?us-ascii?Q?du+neEXy77V+LszThvzEHChAtJKfE66A5d7dgPaF/7cHDM2QpBUJyvfdsPYo?=
 =?us-ascii?Q?dtp+DDPZnQpaxK7Fb6PERsbPKkkacCsmnBAM9tLsIOSKPbDauHvSOXs11ALI?=
 =?us-ascii?Q?R7sM/Wee2Ev1Xp07fXnxAy5efQrJj9yLBIzMLkAoQmpJgP/C+f2E+o9J0SZh?=
 =?us-ascii?Q?z2cunXRCPL49dfGQFN4e+Js40ySwbfrjEgFAfd9xOjeZHRaZqYhDajKFPyDO?=
 =?us-ascii?Q?eic63l79EXpXpXbmbIV5yqHVii4G62n4Tn4PkErbuQ4o/fRIQOxvO7DNF2NS?=
 =?us-ascii?Q?K0tozW4d1kbCHe5yRJPMxh72Ngvq2c0LRkAz9Wt6E+Nq2RY2gY5Ikmy250Ys?=
 =?us-ascii?Q?e54PpaZtlRxQkwoduu7eV3e+ZX7jrdGpNiKlHB3MePDzYTCj2LGRsgX1vyBx?=
 =?us-ascii?Q?ZCh3NqF9WMEuY1lsSU4YjaG9cfF1R4A9RVya4qj5Rf8j6Ys8hZTF/ZrL97Rh?=
 =?us-ascii?Q?/chPm7FMtiLzPYfX1+HG/4yjjpiuibYMypjLJji3hjDHAL+Z96sjaOEKfD43?=
 =?us-ascii?Q?HLr7+EWUqndht6alyCmkmcrhAmAOSMMtQDPTYF7n8mTgB/9R24/MT2LFpGGz?=
 =?us-ascii?Q?8ftvcfv/ow9M5KiVYPpa053nopifdUFqs4lPEjXjoZ8P7DaQgeSMF3tGJYK9?=
 =?us-ascii?Q?+Bsb9fvSS5XdGxs88OdvVhgVyAYmq6I2F4ancUMRamcAyYz65SmC0FiMOq1X?=
 =?us-ascii?Q?rzjefdN2p+8m9lVr2XijqxsSyY3Mm7NED+kOI2W6bYjHHBbzDLp/yALWHsAv?=
 =?us-ascii?Q?MYQZV1pCgfAMj0lyuh6Fg9zcG9fX+nYBNlT7Em/m2YtNReU3EDfrovIDFA5+?=
 =?us-ascii?Q?vSWuYS90WuYkq5rUW1t+zi+bhdRtq377fTDRVqOU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac1f740-f449-4e19-ea99-08dd01f5b45a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:08:16.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RgG2w8xPKhdsy7O1mET3ME0ZqropKYYe10/Z0aG+AzY5NUzX8e1Ho9Flm7LCp6T/9+GWWTdO5l6yayImHnQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7745

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
---
v2: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 266 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
 .../freescale/enetc/enetc_pf_common.c         |   3 +
 5 files changed, 311 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 87033317ca56..45878b8f9362 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -529,6 +529,233 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 	}
 }
 
+static inline int enetc_lso_count_descs(const struct sk_buff *skb)
+{
+	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
+	 * for linear area data but not include LSO header, namely
+	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
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
+	lso->ipv6 = vlan_get_protocol(skb) == htons(ETH_P_IPV6);
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
+	/* Get the fisrt BD of the LSO BDs chain */
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	/* Prepare LSO header: MAC + IP + TCP/UDP */
+	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
+	memcpy(hdr, skb->data, lso->hdr_len);
+	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
+
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
+	if (lso->tcp)
+		txbd_tmp.l4t = ENETC_TXBD_L4T_TCP;
+	else
+		txbd_tmp.l4t = ENETC_TXBD_L4T_UDP;
+
+	if (lso->ipv6)
+		txbd_tmp.l3t = 1;
+	else
+		txbd_tmp.ipcs = 1;
+
+	/* l3_hdr_size in 32-bits (4 bytes) */
+	txbd_tmp.l3_hdr_size = lso->l3_hdr_len / 4;
+	txbd_tmp.l3_start = lso->l3_start;
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
+		txbd_tmp.ext.tpid = 0; /* < C-TAG */
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
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma))) {
+			netdev_err(tx_ring->ndev, "DMA map error\n");
+			goto dma_err;
+		}
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
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, len,
+				       DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma))) {
+			netdev_err(tx_ring->ndev, "DMA map error\n");
+			goto dma_err;
+		}
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
+
+dma_err:
+	return -ENOMEM;
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
+	} while (count--);
+
+	return 0;
+}
+
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
@@ -649,14 +876,26 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
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
@@ -1802,6 +2041,9 @@ void enetc_get_si_caps(struct enetc_si *si)
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
 
+	if (val & ENETC_SIPCAPR0_LSO)
+		si->hw_features |= ENETC_SI_F_LSO;
+
 	if (val & ENETC_SIPCAPR0_QBV)
 		si->hw_features |= ENETC_SI_F_QBV;
 
@@ -2106,6 +2348,13 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
 	return 0;
 }
 
+static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
+{
+	enetc_wr(hw, ENETC4_SILSOSFMR0,
+		 SILSOSFMR0_VAL_SET(TCP_NL_SEG_FLAGS_DMASK, TCP_NL_SEG_FLAGS_DMASK));
+	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2119,6 +2368,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		enetc_set_lso_flags_mask(hw);
+
 	/* TODO: RSS support for i.MX95 will be supported later, and the
 	 * is_enetc_rev1() condition will be removed
 	 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index a78af4f624e0..0a69f72fe8ec 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -41,6 +41,19 @@ struct enetc_tx_swbd {
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
+#define ENETC_1KB_SIZE			1024
+#define ENETC_LSO_MAX_DATA_LEN		(256 * ENETC_1KB_SIZE)
+
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
 #define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
@@ -238,6 +251,7 @@ enum enetc_errata {
 #define ENETC_SI_F_PSFP BIT(0)
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
+#define ENETC_SI_F_LSO	BIT(3)
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -353,6 +367,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
 	ENETC_F_TXCSUM			= BIT(13),
+	ENETC_F_LSO			= BIT(14),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 26b220677448..cdde8e93a73c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,28 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 
+/**********************Station interface registers************************/
+/* Station interface LSO segmentation flag mask register 0/1 */
+#define ENETC4_SILSOSFMR0		0x1300
+#define  SILSOSFMR0_TCP_MID_SEG		GENMASK(27, 16)
+#define  SILSOSFMR0_TCP_1ST_SEG		GENMASK(11, 0)
+#define  SILSOSFMR0_VAL_SET(first, mid)	((((mid) << 16) & SILSOSFMR0_TCP_MID_SEG) | \
+					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
+
+#define ENETC4_SILSOSFMR1		0x1304
+#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
+#define   TCP_FLAGS_FIN			BIT(0)
+#define   TCP_FLAGS_SYN			BIT(1)
+#define   TCP_FLAGS_RST			BIT(2)
+#define   TCP_FLAGS_PSH			BIT(3)
+#define   TCP_FLAGS_ACK			BIT(4)
+#define   TCP_FLAGS_URG			BIT(5)
+#define   TCP_FLAGS_ECE			BIT(6)
+#define   TCP_FLAGS_CWR			BIT(7)
+#define   TCP_FLAGS_NS			BIT(8)
+/* According to tso_build_hdr(), clear all special flags for not last packet. */
+#define TCP_NL_SEG_FLAGS_DMASK		(TCP_FLAGS_FIN | TCP_FLAGS_RST | TCP_FLAGS_PSH)
+
 /***************************ENETC port registers**************************/
 #define ENETC4_ECAPR0			0x0
 #define  ECAPR0_RFS			BIT(2)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 590b1412fadf..34a3e8f1496e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -28,6 +28,8 @@
 #define ENETC_SIPCAPR0_QBV	BIT(4)
 #define ENETC_SIPCAPR0_QBU	BIT(3)
 #define ENETC_SIPCAPR0_RFS	BIT(2)
+#define ENETC_SIPCAPR0_LSO	BIT(1)
+#define ENETC_SIPCAPR0_RSC	BIT(0)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
 #define ENETC_SIRBGCR	0x38
@@ -554,7 +556,10 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
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
@@ -574,13 +579,16 @@ union enetc_tx_bd {
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
@@ -589,6 +597,7 @@ union enetc_tx_bd {
 enum enetc_txbd_flags {
 	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
+	ENETC_TXBD_FLAGS_LSO = BIT(1), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_W = BIT(2),
 	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 2c4c6af672e7..82a67356abe4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -126,6 +126,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
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


