Return-Path: <netdev+bounces-128110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4E9780D4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41831C21996
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09F51DB548;
	Fri, 13 Sep 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DOfPYcWu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70291DA60D;
	Fri, 13 Sep 2024 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233343; cv=fail; b=RGEeK4ruRzIdm54X/W36WswvtgvUsx1hwh6erdNqIxDbvUoVNbAnJN2LbKzLUWpHPk5HWE9TXh/NqtRuIfBVKsTRua8bV1D4FeOcMq9Kz9JjzTsxqNwvBtyhv0lP/qFffBmpIr01DnpFgt6kTy4WgoTqAmYDD/uucA73Eqo1j5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233343; c=relaxed/simple;
	bh=mBiH27qIQkNOYyjsBYwZe9gydW6vawrMe00CXCyE5AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kuEgn4uCa0IFr3wH9hO99s7eGIdMK7CX5hzw1Iaybs9TGk7oU3RxUKK1gyFQM4TZInH62p6kamgTwYmDSOw8e6buN14hxYZ2wyYSp5DtloJx5zgn4g0TeFFAurM/Fm2gGbjgaxZIN4uZyWhPm7ic2GMWaKYn3nnQEcCA181C/zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DOfPYcWu; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myDiU47NZnfstoNOZaOBwOh34t99tXqRNwKWm4C+6zqXFVW62xonE4Wux/QNRhD3yDlvRAvN0r6SsgYj4Odn6gxzIQ+9iu21LPSU4rmg9yKbnXeugcfZJJeQMoeXhTxnCMQg7wnZ15TagnFaO8CB5s7ZL7m3gGmvEWyaenebN9zCG14guM+FHQbKn64I35NpPG4wruOtDheleZLPvx97WSoi9Tm271Dy7vCFdatoqy/53sBjxXxw/09RFB+CkLS0nyZtZO8guF0pCq4oEqtkTfYddyA+0i560JHNW44rWvirp6AZ8RxyOB7FbxX0AdkguOFg1L5JN6SFiRwWXBJ7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfxJ4Xpgjd1PLn398qFkkTVpKPX7SCSSEO+Cb3FY3xY=;
 b=hI8He/ns12od3ck6eQx3SaxJyu/CwZaAk1PvCiJ6uj1DSDbP7o9QIH6L6udxLYGrqwFMwyDiW1acT5ABDQILBwuCrcx34k7DnCEazssYkvL0fZmhvPytj9NPgtKSrPiBsHgpRXvue3m6sNTEiE45wnfvvLtM7+kqMGnSFGcP18fcoj2yL3g47DAxq9Wz6ZcSHpdj9vnqNhRoVe1AHMUiWlks30bYOfw8XpDOkbrmHl9aout/V48qIQChmrgIFvfin5gD/V/57pMqkzNXy97dnNkxgklaMHmz12+tDzolr1SkzbJ8BG54kRIgmkuWlCPx1rig66Ara6QTVolsJed+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfxJ4Xpgjd1PLn398qFkkTVpKPX7SCSSEO+Cb3FY3xY=;
 b=DOfPYcWuw3smIXUeT1ILOi9gSE4gF/VB/j/E1gzDeLZ43Lx4fSZ1fJM9vQRnbnLHarB0inYAafFgtXc3jDtDftJl4J0qZMxRuSEswlnPEaRgYZ3WD7KxSc8myMOxNOGmKyMNDvEJrHETRioIJBNdWbhOP3RbYN7VYZ9tfAhNh9xKLuVl9rqlGYSQ0H70dtrkv8LFsVX8q64yKqDS99sc0nnx5eVdgc7NXgMsBP2GLA2+lPjxccTaZTKI39nh5GCWD9wYc9Wk0bpQ5rjuxOUoP6HA4uewqJh+wf2SkGx3RjZ9zcBJIT0gZagkfW+NnlBS61v5Hq0rvBu/1FaOpq30MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7519.eurprd04.prod.outlook.com (2603:10a6:102:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 13:15:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 13:15:37 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/4] net: dsa: free routing table on probe failure
Date: Fri, 13 Sep 2024 16:15:04 +0300
Message-Id: <20240913131507.2760966-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
References: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec2d3e5-b48e-4302-925a-08dcd3f6284b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Zc2P7wXr8bQ6CAGwm7sxQm1ahYCyhrWuCAuqYypJKIQiowACSMAr3GoNkoW?=
 =?us-ascii?Q?z1R6ImoLypoQ71LjT1ppb8S0KIM2aY30Dl+6yT4p8EGesW7Kquh8vG+lcDyz?=
 =?us-ascii?Q?EXTlCplfjF9MAJ/GNxvH00dPPn7uNkRTZrEcXTDgQkX8s4FrscBo6Dib+U50?=
 =?us-ascii?Q?pIgnW8rqISDIsfMtMySVTpZLEbZzkVZkoo7MB/TwOa1sLGnA6YNtqgIXEkMw?=
 =?us-ascii?Q?ylX0c8nes1Ewu67w4F3QoPP5WxRV48hObNoAZvqiEHKtgACpsYlcykUn/Qnt?=
 =?us-ascii?Q?/5pLj53gGFs4PEBXo4REAOYJ8RKuE1/r+9FnrNbPTGSF+n8KJljqfJuDsO07?=
 =?us-ascii?Q?oniM3/cz4Hxzik9fN1yKqMPdTLQZLx2B7Y25drUEOU2RPNIHF8pvoLdff4xo?=
 =?us-ascii?Q?Ub68jL+6VQT5v+EY6fWdv+nCHKBigSyxTsRv19B54OAqIRtXs3Ueu/r+yMMv?=
 =?us-ascii?Q?elnEcVhsoMAw1TXJUFsI3egMB2ScBShSvTV5HKrZsRBOZeiNGphnKTwOsw3a?=
 =?us-ascii?Q?QMz3P/5Wa27JL9FwXRZz3VhFXg7g48OiWRbJrAzxlkv8v5VI52/wiY51mfOb?=
 =?us-ascii?Q?hcxErxXG7Ok/9aOBbDbLw4nQ8yVpFQ53OPMCCfYfhxVZ97VSwiPNV/Qs33qX?=
 =?us-ascii?Q?hrbJMIuJpJ4fAMuTXWytJ80JdeiLxZ4kqgvXQWea+/ii7DQYyN2e3uuThQ2H?=
 =?us-ascii?Q?+ET0jwZwagPfxG/20WdjNjfQdxCQZP3mloIWTFqHctldadT+dwdoCbMEZJ44?=
 =?us-ascii?Q?s2W1uCMCn/sR1s5Cgp4BzymdJsfQjw9q0bP3vSOuD8QsV5FEMFbdS6gBgcpa?=
 =?us-ascii?Q?x5/jylvzIqCUg7EdF1PmqehYMQ4ti7fzTZXLsz5l7GPEuyRo9taehCJBYTv9?=
 =?us-ascii?Q?+TZJcg0tohiqifd3r4hKmtXEypNoO559xGu7jwT3ZjizO+V/xy/Sy1RuzEHw?=
 =?us-ascii?Q?VeyjR5fflL747fn9gnaplzga8EGZ55pFrXWvWlJ9R8CbVobUOuHEMFIfUNhI?=
 =?us-ascii?Q?KBnUaQh674zIkwKqZRbFG6OBxWxxVHnlu8LfpvQTrmPhrq+tHBQInJSqU2aM?=
 =?us-ascii?Q?9oQXGdEuI8R/q+ZvH13JyiAtbeix6a1O/yyt4AU68oKELFZWB3rc/xxEg1r6?=
 =?us-ascii?Q?Tam7wuMtALI5qxAiyrPPB0DGhdLgTWB2uvFF19mD1wof+33SDuP+qVRTWyGq?=
 =?us-ascii?Q?iT4twnClqn8TuMM/Hb9wX7zBEGW8GWUxe7H8neZKrA0VkxLudfu1y3HscrKv?=
 =?us-ascii?Q?tfThRV5jX47pbnjHMN9sGFeI7u5pE4faaIuK5SAVlBf9HMJR+um8RRtD6XDI?=
 =?us-ascii?Q?ykk5/XaIhlDw53j76BPJRYycX2j2Iz/daByP2m1nfjnJQdbHb8J+/IrX7jYG?=
 =?us-ascii?Q?Q8JHj4i+rLQHb1F6yLKGP6dX5w6zXFU4II+LS8x0JmjnhU3bwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mp1/9iFW9F+Wr+EWUcmVyhEvIPGZKobKDqSFJQXfK3eZHmks96x8Btrpeofl?=
 =?us-ascii?Q?85ccIO2Ri2qO9xdhkh4gWGWBCJ2YbfADEpKMCyoiO+72RqpGKb+y80IgTKzn?=
 =?us-ascii?Q?zOq5eMHqjHVgni88UTZQMUSjdwF3ANV0H+T4Wkr+9px7Sl0KL1pw9Bg6Rp8E?=
 =?us-ascii?Q?fcwLGLcmMbuEY1EHXO5b0+nKb9iN1dXcAzOvvt82ar5lS/MhbHUIFH5uW+5A?=
 =?us-ascii?Q?XE2qVOS+YxymyaOvfYyZmeD+Lf9nsE2cfM4LQ+1xezbgVi4f1U9pEyYjZ7K/?=
 =?us-ascii?Q?Lg3yqpbCfcBFrPkr2KSYpHyGjiU+0Q/OtcVlBNiUVryXkI3onxrdTrgYWDpB?=
 =?us-ascii?Q?mkzCVFQWxL2ujYN0HXs52z/ypzhPB37pxHPHVZHJefRIj6nOPs0VhTR6djwR?=
 =?us-ascii?Q?5v+ZZcFZoFLtkcK0XCBlQ4ougdWt+ABH5Kck16EWUb53iih6uazznB9osquD?=
 =?us-ascii?Q?V+W1A8+OeTPNm/d13BMd5w1je9UW7kU+5QFpaO6NJ7twrTW3b7UDap4W1u06?=
 =?us-ascii?Q?4jb1Txln/Mwck4hFKyLez81YjYdNiVYCaoAsPMwzeLB6AhwGXAAK6jpKIpVr?=
 =?us-ascii?Q?n6WkeqFg+JvqBk3yfzoP/p+H5bAitMogUqyGySFJZKmWFS9AiSzoaIfT099L?=
 =?us-ascii?Q?YcVsdlFwDX9F7YSMf0nt89FsYu5Coe+5MlEmtWUWKJ6sv1xFIQIW+YPzakzn?=
 =?us-ascii?Q?WyjftNkozlTKNZFz6FMntrm4zhYhG0JzKu7EU6ZqSDPcKT4GhlP9e4AoQKbm?=
 =?us-ascii?Q?K1f/MLQs1NJ5D/VeVQ5W+PdfFwygAaUT+TCtGHBFaIY9SWP3usoZJL5L2x2S?=
 =?us-ascii?Q?hL9voBLghau4vI6Yh4buixW/L2GFayy9LnMC9WGOUzfx47sAK9ZOPOX1lqyY?=
 =?us-ascii?Q?22jOHj0u/TDAAk1Jd6OCPorGIpfzQj2ePklvvoJ2HnkjH3Z1hVQbvIEN84eh?=
 =?us-ascii?Q?UAvi1ySJcZJpxdIGFuPSAFXSZWt+1ogmNuyi6ubcEjh5lpHIb1TikIW1YkUh?=
 =?us-ascii?Q?P+ViqIgQ+QXWto+E/IK3Nl8VBVnXEZeuZTryQG5ZwDE2+lt10g5Tk+zyW81f?=
 =?us-ascii?Q?nqgJDL0qn/A9lL+zBKx3ETgfYtMeUjSKh6Dw/68rLSvIYZXC4B5SGlQf83f9?=
 =?us-ascii?Q?TuxktaLLm+c0k0Sgjv98LtVvRKyav4wdva4jRdTpn8ufukwmXi+QghYo+Hp3?=
 =?us-ascii?Q?mrOqHSGD7fbQY3iZ1etWWDXfYltqXCCaB2/olS+Dx48TrYM/nvwSX53nnkpd?=
 =?us-ascii?Q?07tzveysE+JqC7Gf/TBDA3jZW1/L+5VMZKF4KyoG4TLZmj8pVquWt/J+cyxW?=
 =?us-ascii?Q?7/UpdN7krxUUGcmuZYZCrhOf5SjkA45sqdVukUSIhXDQsATWWoyV37EU+p3k?=
 =?us-ascii?Q?hi3IvvX5+Wu5tb1253ij11gpVa+l+7KlP3C5OxrnRXfOXjjYK22SI5Tr+q2y?=
 =?us-ascii?Q?CuvzW8GJXDbhi48xvFudRqxTJ7MebTBU8kTOBfSuTsB1+OtfSnFsKupxySP4?=
 =?us-ascii?Q?JHyza+C9HaXYTUE5bCQD9+AfR4SYs56LU0NPVg6dZ3ArAwk/WpQboaP4Z1Ct?=
 =?us-ascii?Q?LPlIX88b91EwwMQRbjKqkvFSRRpJf4hBf4XeAm591a2AONQHmYU95dyqTIo6?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec2d3e5-b48e-4302-925a-08dcd3f6284b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:15:37.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkXy0GJbQfTsiIqt2TAmYJwd8jVGDxl1LTqTGYgM2/nICu/PVO+96EsAj9G5xHZwuwUQT09tZVBTW1ctPtFP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7519

If complete = true, it means that we are the last switch of the tree
which is successfully probing, and we should be setting up all switches
from our probe path.

After "complete" becomes true, dsa_tree_setup_cpu_ports() or any
subsequent function may fail. If that happens, the entire tree setup is
in limbo: the first N-1 switches have successfully finished probing
(doing nothing), and switch N failed to probe, ending the tree setup
process before anything is tangible from the user's PoV.

Because the dsa_switch_tree is still technically referenced by the N-1
switches which succeeded in probing but are practically useless, the
memory pointing to "dst" and to the dst->rtable is not actually
"leaked", it is more like "blocked".

However, we could just as well free the dst->rtable, since a subsequent
attempt of switch N to probe, for whatever reason, _will_ trigger issues.

First, dsa_link_touch() left behind references to ports owned by a now
deallocated struct dsa_switch - the one which failed to probe.

Second, the dst->rtable will be regenerated anyway by a subsequent probe
attempt of switch N.

There was no practical problem observed, this is only a result of code
analysis.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..a543ddaefdd8 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -862,6 +862,16 @@ static void dsa_tree_teardown_lags(struct dsa_switch_tree *dst)
 	kfree(dst->lags);
 }
 
+static void dsa_tree_teardown_routing_table(struct dsa_switch_tree *dst)
+{
+	struct dsa_link *dl, *next;
+
+	list_for_each_entry_safe(dl, next, &dst->rtable, list) {
+		list_del(&dl->list);
+		kfree(dl);
+	}
+}
+
 static int dsa_tree_setup(struct dsa_switch_tree *dst)
 {
 	bool complete;
@@ -879,7 +889,7 @@ static int dsa_tree_setup(struct dsa_switch_tree *dst)
 
 	err = dsa_tree_setup_cpu_ports(dst);
 	if (err)
-		return err;
+		goto teardown_rtable;
 
 	err = dsa_tree_setup_switches(dst);
 	if (err)
@@ -911,14 +921,14 @@ static int dsa_tree_setup(struct dsa_switch_tree *dst)
 	dsa_tree_teardown_switches(dst);
 teardown_cpu_ports:
 	dsa_tree_teardown_cpu_ports(dst);
+teardown_rtable:
+	dsa_tree_teardown_routing_table(dst);
 
 	return err;
 }
 
 static void dsa_tree_teardown(struct dsa_switch_tree *dst)
 {
-	struct dsa_link *dl, *next;
-
 	if (!dst->setup)
 		return;
 
@@ -932,10 +942,7 @@ static void dsa_tree_teardown(struct dsa_switch_tree *dst)
 
 	dsa_tree_teardown_cpu_ports(dst);
 
-	list_for_each_entry_safe(dl, next, &dst->rtable, list) {
-		list_del(&dl->list);
-		kfree(dl);
-	}
+	dsa_tree_teardown_routing_table(dst);
 
 	pr_info("DSA: tree %d torn down\n", dst->index);
 
-- 
2.34.1


