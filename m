Return-Path: <netdev+bounces-189761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8CFAB38CA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9595860B73
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC292949FE;
	Mon, 12 May 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MaFEZGB5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9CAD58
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056291; cv=fail; b=f9wTstJ3W3qiAK+BMgBNwf6zDwj+H7l26O+oaQ8yHTWtn5xienz15U4FSa0hJJcAZQzzLbI9DccuKUqQI3L8l1lggsb2if1erV9czGW1g/Lgzh3YZ1BEWwrR3/KxHOAjowUxc8r0oXey/B/wu9DotBmSQjx5wm1RcjQ6+Zog3KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056291; c=relaxed/simple;
	bh=5tTob9pE0y4BGrYe0j42aRuwu3qDrZ4U4v3pjNnnECY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HjIcUYacnNp6w1Fi28SpA2NkfkfeJAO1wxEnlEn3LGToO7uzzKoxWsjVS3rLNt0W2kvknehk8KGdSeQlW8OGYGw84jYMEWP3ztJGL7bA+ZGoSrFPeV7VB4pGvFrsd51GCCmcjnjRalIQSAqodNU7O+8aNRb8WYzYg5xqfxesD4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MaFEZGB5; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+1yICPoiHOEAskNWjC+Mb0iJw4SowRcxloCfrMHg8vswVH29nHrAMK6kl2cBDOByZ32fUkRRW1TWI6JyuWxE1/GD84WhDY0Un5wgPkHZxOWxeOOtTkhbS+5WQ//fIhup5qy6TGZB5xZ/rj4Qn9fBp6aI5vZzHrg4D8UH9NPNRECAimPh6aO8FzY1Ed3IVGRXpw3kRrz0YbSx3jXQ9w2KWOi+f3Oq7v8DB95ZEOLgUg4kcH7FfqWLuPLzZynPDqIfFM8gKy5S6vVX5PHtrKLdPiNwGTCXByurbyFSceavgqUI+lJruQwm5poeAN4vNNCewzrIc6aeGMeBa3nWFT/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMqYM6X7NhbkQ/ykQ9Ndakf5tg+Gzq0Zm1zfqzoBiNc=;
 b=uAJKvfeC+dkyA0KUf34A3TWN3CaTsECXALJw5TDI/JaAPKCkiIDpTuHbDZkExK33zFl/WeNXbUkmYvLHVXv2JR4AvTM2vEj66MAaC2JwJn0ti6yEkc55+kzHa0GPF+m25bXTujybWvYjk69ghxkWU+nCNOyskIsiG2LAAIE1Yz2d98NJspnqeEm1mB1KeZYbQ9bRSrgUgU+STUDPrbSjECTxExHggkaKWbLkjAMR+S0ByUswbjOfAzkjDK4roBGnvWZ3DAEQ1zQcnjaS35jhAWf5Qvpb8lRPsEUHw9VaDcXpuZd51GIL4BqoCa8K1fQL6BFNyftp/BmaU5YFFvlhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMqYM6X7NhbkQ/ykQ9Ndakf5tg+Gzq0Zm1zfqzoBiNc=;
 b=MaFEZGB58HFLqOtebruSUFskuySHvBfubcpTBfoAxwihGLdmYC2hwe1pR4oG/YCZf/IAtM+Mp54dp77/2jZ0+Nnru+KejIqLmwt0CTLGPpxnJDofixbXaJD7Lu04waAUxKxQu0RTTulp1kca0Djg91QQFVsMBGnfiS7ZSpLPb1zdx5FI5sw5ik5xaepVeXjiPBxN18KDxOrNMrGBQH/TqMUD5HkamnLFUIeWzyVTi9oXUqiARtPadURn8E/FoDg76PFbhDJFP/Q4FeQj5MvXOcdjWvdL60Vh2juN5zfzco0xsQ5YoI3L5COGEBR8onqq/9jv4d+bX+rwHcse/fPl8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Mon, 12 May
 2025 13:24:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 13:24:45 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net] net: tsnep: fix timestamping with a stacked DSA driver
Date: Mon, 12 May 2025 16:24:30 +0300
Message-ID: <20250512132430.344473-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0145.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::29) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ee8281-cb88-4ac2-9fa0-08dd91585c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UqN6OcR824Qu6HCJmA2EN+xZdlNuLf6sxTNNV39vjcdBjQL66/p1w392ttTZ?=
 =?us-ascii?Q?5Hcd4IuoEMOII03J4dusHW8ExmZcbPDrTPAUqRioHFop5534m2pSCWKE32g4?=
 =?us-ascii?Q?/bew18IDc6rVp5RRV9xIVBVLVfQv2xHKot1cNAoA6Ca855ki5dkVcKjtY4PD?=
 =?us-ascii?Q?SC+TtRs2ZRapz/eWIgwCsT1Ff0WVHmED79ioL49xqbLulbIfHnlCev+aM7ve?=
 =?us-ascii?Q?pVGoTfCLd7LnIeKDgfyo4z5ufk59VfpekFfeMZqx/ptFe2Dz/kQQIvKW35rI?=
 =?us-ascii?Q?FbZtckmUMfqa6E98iPDFZd6DddE0jhpcUt+N9uukVMv/s26k6O7nmwZEUWn3?=
 =?us-ascii?Q?qyQMA0HluX+22rXfirEcZg6imx6/K8VJjWAjlVfFFRoTsMm6kj5C5DtumUfA?=
 =?us-ascii?Q?Qq7H6RvHh+qlBT/cJME/JlwjRhF3RKhlF7ZSIzs/cftPV2sUEOJtma7ne6VJ?=
 =?us-ascii?Q?WLVkxuYdT5deQg6D0xiWCuWyxE0WfKDPJ+kV8DaDMpV5Cv4t+hupFCrBVhS2?=
 =?us-ascii?Q?WBOk0fNjBExmiF9jfWNw98F7rMw1WvSv8krEhz2qpQI1hcYst269ZN+a24zT?=
 =?us-ascii?Q?G5VW182xyzPx7i756G55U/KRzGiOcdvPR1XqakQAdqsp4/ufEq0afwV8sdik?=
 =?us-ascii?Q?Q4XvaGfFuFhSNQYqdZUwIcXH/JP5zSudbclkCnLOsYzHudMSyvXfEt1tU0CG?=
 =?us-ascii?Q?AwfUcnZ38g0e6tGX/QCi/pSVkgsvBirq2uk2mNmA7YH3S0b9fHi5gUjC6lv4?=
 =?us-ascii?Q?ruWj9HkPn+/nV9C2XGfkVLy47q9hK1wKaqj/+vLSdwwlHmbzOzraKdhfZ1Nz?=
 =?us-ascii?Q?G9ia1AKG/k42frFxDViH+IlMFaU4YCsA4spDCD2HY9YVuuanGI9sUvIKwWyW?=
 =?us-ascii?Q?hwQsZxuRHS3vPuJVIdCFZo9gh/gqm4/VRBIEPxQ6an5TTf4vQiSf/UXIyqhE?=
 =?us-ascii?Q?wSOWWTZU59h3HMh7RgC8LMLGUvVKd3t/GNkf90cGcIvahaGp9Kc4CsABVlCx?=
 =?us-ascii?Q?HfNABJn3GzLyXpqbOPck8mg0lOTaBVPT9Xzos/abuOOnJcROyfJ2y5AoOO5i?=
 =?us-ascii?Q?ejP9tL5FyTFmAtWS5NVzI1d6/hYpHbczq1DFpK5MqZMuSkKxM3e/bMi4Ukqp?=
 =?us-ascii?Q?08WyBP99dXLWIRJpnD4Pdqiw+8pmmkcf1XTiZUtecgXWLqBlPqVM8Ic+1WqX?=
 =?us-ascii?Q?ObMvrjAgGTUnpXa/j3s4GSRKLZv7alZCJP1+Mhf5uz3BcXDWSWrITTvTOgae?=
 =?us-ascii?Q?znaHmz7EUaFZafUqAjOriUUhJAhWmKzjaYgt9nnQGrev3fUOPapVi9ebL92f?=
 =?us-ascii?Q?7qaHHS44W7vFqj9wTQhFD21aXOLZm7c6UvFjQBu/5r4RX3fs7CHymDOL80mH?=
 =?us-ascii?Q?3uwrChRF+wFErcBWjFoY9LNNYIIp4cv9C95ApfVYtkFBUBCKyjV/n+EKQ6rz?=
 =?us-ascii?Q?D0UUDQj8D/egVM6+GCoEv/d0vHh+B00jiwmqwFgxEGBElRmqnVOjnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LXARrKXMvu1poRw2RwiZsEeNJrupu/IKXYMW0e/whH2YaUwqE9HKSbrWuI3R?=
 =?us-ascii?Q?Lizy6+aGpaL7C5KNrCkA2J8jeGmcHq5mqZGSOGIe6mb4bzyKLGzhrt06I9jo?=
 =?us-ascii?Q?evEkWIR9Z8Ec925k971Jw44T8Hrl5StvL0Ieh7YKNw8j9krGu+FVyiQiu0Pa?=
 =?us-ascii?Q?5vXqYna2zXLis81rNUsuAtNGF6O2lB8NE5wrUGMuvz6OqTMy4Z5p5PVPomTf?=
 =?us-ascii?Q?TZbXVenqm/icPl1v3tQdGuQP6VO3BLO5ZEVX63arc3J8k0siX6sk/4msO9cK?=
 =?us-ascii?Q?k2F5onRCKbhIATca0Qy1ciA1FDDeLiaRedTZmZ4awL/qFj/4AshJrNjY2xH/?=
 =?us-ascii?Q?qcxwsruyo8/cYRw6AuRxwXufYU0az2FT2bacFRCauqBLNmqHaAsSC+iqCpAU?=
 =?us-ascii?Q?KhjKd5bhU5m45xYit+eujClKnzWVdjmIs7GGEF7lsKVL3+Sw5kb9e7S7XvP0?=
 =?us-ascii?Q?3mQqRSvkch4IGeU1V5cDuJCogBqL9p6SvlDv1Hfvhrw6yvmPxYgx28ID1pHU?=
 =?us-ascii?Q?LWeZeGfrWhK1vuyVqOPt8xkndJm3LletwgTfONMGBycM7/rM27JIbEv3YVSL?=
 =?us-ascii?Q?O3iNs0CBb1ig5F57kTSNQJ/tbrOzSzZURnSZw8/XiT9t1dQOu4Yc/mNvsvzt?=
 =?us-ascii?Q?cAg3P8a5+BA3PW6vZmsOh9oAA6OTm5d/ARHj6GYhMHBUO5nrSVXIEe+W0vVe?=
 =?us-ascii?Q?/phwCwv6imYBEFVd3YDlGa0Y9uELg9yLlqIJPE8Imgu3dLJKSsw3Nvzr1vUj?=
 =?us-ascii?Q?fh2s7TSRV02YdKx5edxjIeZYRCdJ1sdYBMX/noMOKTuOaLgctS9CMIIq5OjA?=
 =?us-ascii?Q?VPLOpB0keiECtKpBZhlaKcnDBLUaAYWtDHiOYBtQmkc6DfOullcEzScGX99o?=
 =?us-ascii?Q?9b4fyvxOdgWEHQJNZvZ7Pyh6FEu5FKBet39kFO7wvVrxWudJ/UpwHjJ8+2q7?=
 =?us-ascii?Q?y8Ef7fv4eSPCZinaobbBykytfylYZxoKXhwdLJn1Qj2b22cQkqibnLExTlJA?=
 =?us-ascii?Q?teNQza+arjBYVzn8obfe7MI147fFC/joKR6F8L4AGeENXAZjTChk4gqzIK1a?=
 =?us-ascii?Q?y2vIoVNS5scRCfeSnfNzWZFImcbba7ZNZJgLE2F8Wsy2fDRHh56qEj7XcY77?=
 =?us-ascii?Q?yla1hP6xKTVM95NB6Fnb94+/WM4Y9BIs9I8cvtYKIrnvsMY1v+tW6f70U61e?=
 =?us-ascii?Q?+7SbYG2ruHRvjmLCcHpxVcZVzbnsGenUxyaaF2r+p7EPOnZmlIFvuEjglk64?=
 =?us-ascii?Q?rIyqKvVoyICYVdsPUlBKTShzzXpPSNsashH/rwa40swjICAeEi9uK+l6MEX+?=
 =?us-ascii?Q?HxLoH/szwND/zsQpkrHOcnmrSmAVa5vBwx2rYx0pjih7XQvJ+PCDz39xt5FZ?=
 =?us-ascii?Q?gTWhd3LCKhDPz5QqQrgN+l6B7wiDX1LCHvXTnUKEzKOGMmh1GvVwm0JanP6D?=
 =?us-ascii?Q?beI+6HO0XnmHLRGSp8qjXqdc47udjas8QxFibVQFVQD9+F3JInsD23n+z4Si?=
 =?us-ascii?Q?NBCDHsFnxRP3KXorBudIgC2vf2FXXdC7TWlLp3rjSvpnG6g8ShyfwNycjzQZ?=
 =?us-ascii?Q?EN6XVgPu4AxB1IP1RrNjwXMtC6Kr6nj++NCIALMJ2GS1+ek3Mgps8Nmbb28q?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ee8281-cb88-4ac2-9fa0-08dd91585c83
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 13:24:45.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFNmer9YSP8SgghEUtJw07jyAQFVXvn7A/0ntqy2V/Y4UCIURAVk+NJzQVpVtxid0RcNg+y0YL0fYFRZADPp2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

This driver seems susceptible to a form of the bug explained in commit
c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
and in Documentation/networking/timestamping.rst section "Other caveats
for MAC drivers", specifically it timestamps any skb which has
SKBTX_HW_TSTAMP, and does not consider adapter->hwtstamp_config.tx_type.

Evaluate the proper TX timestamping condition only once on the TX
path (in tsnep_netdev_xmit_frame()) and pass it down to
tsnep_xmit_frame_ring() and tsnep_tx_activate() through a bool variable.

Also evaluate it again in the TX confirmation path, in tsnep_tx_poll(),
since I don't know whether TSNEP_DESC_EXTENDED_WRITEBACK_FLAG is a
confounding condition and may be set for other reasons than hardware
timestamping too.

Fixes: 403f69bbdbad ("tsnep: Add TSN endpoint Ethernet MAC driver")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 25 ++++++++++++++--------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 625245b0845c..00eb570e026e 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -377,7 +377,7 @@ static void tsnep_tx_disable(struct tsnep_tx *tx, struct napi_struct *napi)
 }
 
 static void tsnep_tx_activate(struct tsnep_tx *tx, int index, int length,
-			      bool last)
+			      bool last, bool do_tstamp)
 {
 	struct tsnep_tx_entry *entry = &tx->entry[index];
 
@@ -386,8 +386,7 @@ static void tsnep_tx_activate(struct tsnep_tx *tx, int index, int length,
 	if (entry->skb) {
 		entry->properties = length & TSNEP_DESC_LENGTH_MASK;
 		entry->properties |= TSNEP_DESC_INTERRUPT_FLAG;
-		if ((entry->type & TSNEP_TX_TYPE_SKB) &&
-		    (skb_shinfo(entry->skb)->tx_flags & SKBTX_IN_PROGRESS))
+		if (do_tstamp)
 			entry->properties |= TSNEP_DESC_EXTENDED_WRITEBACK_FLAG;
 
 		/* toggle user flag to prevent false acknowledge
@@ -556,7 +555,8 @@ static int tsnep_tx_unmap(struct tsnep_tx *tx, int index, int count)
 }
 
 static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
-					 struct tsnep_tx *tx)
+					 struct tsnep_tx *tx,
+					 bool do_tstamp)
 {
 	int count = 1;
 	struct tsnep_tx_entry *entry;
@@ -591,12 +591,12 @@ static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 	}
 	length = retval;
 
-	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+	if (do_tstamp)
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
 	for (i = 0; i < count; i++)
 		tsnep_tx_activate(tx, (tx->write + i) & TSNEP_RING_MASK, length,
-				  i == count - 1);
+				  i == count - 1, do_tstamp);
 	tx->write = (tx->write + count) & TSNEP_RING_MASK;
 
 	skb_tx_timestamp(skb);
@@ -704,7 +704,7 @@ static bool tsnep_xdp_xmit_frame_ring(struct xdp_frame *xdpf,
 
 	for (i = 0; i < count; i++)
 		tsnep_tx_activate(tx, (tx->write + i) & TSNEP_RING_MASK, length,
-				  i == count - 1);
+				  i == count - 1, false);
 	tx->write = (tx->write + count) & TSNEP_RING_MASK;
 
 	/* descriptor properties shall be valid before hardware is notified */
@@ -775,7 +775,7 @@ static void tsnep_xdp_xmit_frame_ring_zc(struct xdp_desc *xdpd,
 
 	length = tsnep_xdp_tx_map_zc(xdpd, tx);
 
-	tsnep_tx_activate(tx, tx->write, length, true);
+	tsnep_tx_activate(tx, tx->write, length, true, false);
 	tx->write = (tx->write + 1) & TSNEP_RING_MASK;
 }
 
@@ -845,6 +845,7 @@ static bool tsnep_tx_poll(struct tsnep_tx *tx, int napi_budget)
 		length = tsnep_tx_unmap(tx, tx->read, count);
 
 		if ((entry->type & TSNEP_TX_TYPE_SKB) &&
+		    (tx->adapter->hwtstamp_config.tx_type == HWTSTAMP_TX_ON) &&
 		    (skb_shinfo(entry->skb)->tx_flags & SKBTX_IN_PROGRESS) &&
 		    (__le32_to_cpu(entry->desc_wb->properties) &
 		     TSNEP_DESC_EXTENDED_WRITEBACK_FLAG)) {
@@ -2153,11 +2154,17 @@ static netdev_tx_t tsnep_netdev_xmit_frame(struct sk_buff *skb,
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
 	u16 queue_mapping = skb_get_queue_mapping(skb);
+	bool do_tstamp = false;
 
 	if (queue_mapping >= adapter->num_tx_queues)
 		queue_mapping = 0;
 
-	return tsnep_xmit_frame_ring(skb, &adapter->tx[queue_mapping]);
+	if (adapter->hwtstamp_config.tx_type == HWTSTAMP_TX_ON &&
+	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+		do_tstamp = true;
+
+	return tsnep_xmit_frame_ring(skb, &adapter->tx[queue_mapping],
+				     do_tstamp);
 }
 
 static int tsnep_netdev_ioctl(struct net_device *netdev, struct ifreq *ifr,
-- 
2.43.0


