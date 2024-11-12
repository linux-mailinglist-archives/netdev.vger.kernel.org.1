Return-Path: <netdev+bounces-144018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FCE9C527F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA36B2C74C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD392123D7;
	Tue, 12 Nov 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kCR3TGsY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9240F2123F0;
	Tue, 12 Nov 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403840; cv=fail; b=aisQdvf/8mHUa533jdrBjigOvBB5BM6fKNwbkhNy8GEQlCyjhjaRJ1Q8Vz3gsLxaql0vM+p6EmrvCKYHhT1t0ST3Aeo27HrIK9wTnDJB2UWQp3N7nEmgUeqHOe4JtfFbebDmAAsWmWqkFAJ0vBxkSi1Omm9+TiFONKgGe7wJUwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403840; c=relaxed/simple;
	bh=rnuz9WSThS7kQ/rtN+cQ1pMVPFVVMcvOrGTl22N5Vb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTm6X12xmaLmP6Dn/CqoR/ReGjwKRL1IL3li2b+2ksb737e6shr/UEE3nTR9APEs50Nb6Q7QwIR/JjQ1uNdIBVoW2iyFPKZ7/8j/wia0hEnI+ghdLIT5SK2wZGLg28hdhK8SeNno1KiBX9fead/WDb9ARtLL7zhl02fPGC/nXT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kCR3TGsY; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSU6mZqFCC6N78A4VihEd4o+UGFTlgOkIZlsWVL0e8IBgBt1xZ7nVNTTMaOOZBsg2Ss0yJs+X7MB5mgD975o7oIzusKli99TrSxico9Rk1QDpDYAzct04OrqKfx6j6LYdo3ZQ4z/a/90lyDL6O/dcjya9dUsSTe9iqkanAxm1iSQA7k1cFAtc13/kojms/QOpT5ll2SooVuiZoI5UDpTjMUJNY3g+bJNWtwYU2nM/C1OgWW72aucd1meV5VU6LT8IA5bRnbsAkClX7Wen5e4FxZWqWMzeZWaYv8j3jZVsdTRFujeFA/m0EV7wMIkRickzNfdDPfqfjGs/qf11Q8pCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDEkoZQMNj6A7ah59aru6sKVGKBHceP9SBhJZluznTM=;
 b=MWHpzInN/92/1QOxRAlpZrci1gQLLkfuD4ckXcaGYKRsmhO+gidRnk+QJNTC3LPAVM0A7YiLmxkk+8H0FVTqkoTbwwBOUMGF7CNaMDhe2OEWBISSwm5rodUKfrLwTE5HtPSugVTumcw32MgRdaXXafz7B50DPaN/JO5WbOE+1CjGp6NytQFUZJi6Lb0cwdx9zjt+ANW77ozOdBDvnzhjN34t/liquBtIIUA6mvsyXDeRWWvaZRHaoDBFof6sk7avKh7c7riUzhgw/JdFwbMxvOyVUQ22nN3X9SrnS0CFl7ouWc47weQ6sHD820epjv+iHqcmmWYb4PBw0VY7OIDD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDEkoZQMNj6A7ah59aru6sKVGKBHceP9SBhJZluznTM=;
 b=kCR3TGsYA+GNeRdEpuvF6WWdU0VqTZW0HNsRVAJhh5PFEvxnV20aSQ/DEaJWX1O/kE1MM8J9VBh09z7C4qKWnCKnq2Tg3tt6t9eVol/uhbVLZsKMVT6aRMZrXQuUHqpUA4ooI8l8HTK4T2EqwmPv5k/HzmPdVat9i08QObHB1t6medAAA2FPTh977LkN5IL9xjSdckL4yINUeR/B2cKgiG4EknaLppj1l4IIzGwZurHTfeYJgyJc3JlPkN+uCeQetDh8M6dZ2q2jzc7+mVtGIivH49UIN33ZC3LG67mch64qex0xODq0IlcPGZqsqm/T+d2m5YvmbF4jN6Zo1tN7GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 09:30:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:30:33 +0000
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
Subject: [PATCH v3 net-next 4/5] net: enetc: add LSO support for i.MX95 ENETC PF
Date: Tue, 12 Nov 2024 17:14:46 +0800
Message-Id: <20241112091447.1850899-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112091447.1850899-1-wei.fang@nxp.com>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: d2421ffe-ae30-4e5e-1fb8-08dd02fca802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SKvNJecDiDUErSm7Datpa2G9b0nJ36H4ujSlgjipfELNIspQgNeTwv+We5VC?=
 =?us-ascii?Q?P7TIC4budbbPJIuY7HFZpSB6dhVlMOOGOfoeKErIXb7+KzqNcic/sBLwGQ7t?=
 =?us-ascii?Q?oEpEdT/SJzhiTbi5eLkbf9H0aOXxkc/txTE0eQbgs9gCsmrYqLbtcJAQNAtS?=
 =?us-ascii?Q?NVA9md1jYU5eiRygMPa/YbPpvsznHqN/4nqxJi/JeUfteUQJRwQ7yxDwoYmB?=
 =?us-ascii?Q?KT4kXcoiAhA21evEJiR7k9Erup2xKQCkIoYLK0TJsP6qGRfnLBnkTpf3mZpL?=
 =?us-ascii?Q?9Aw+pY6GDdUqfWkbxKUjZ0EQ15S4QFe8JHRGW3e0vBXxfADN30Dg9EpNrKbp?=
 =?us-ascii?Q?/AP3j3aQN2GAWxrQ/3lMDZ0+HOPupOB5kvfYCwu6vlIEfnxYHZ0TUNepmBc7?=
 =?us-ascii?Q?ztMVjB+UZ6roVFTe0BzYVFp3xW7T0tEocNkVR3PzYROq7MD7ltfxHiGA3Us4?=
 =?us-ascii?Q?bCNV0Ro8kr2dkBGPnb9T7EIf81y4szKkOQ9Nm6tnw53K4pG2XlR0sz+l07km?=
 =?us-ascii?Q?9ojOsIeGxH7fcYEkaeSm55cJuFbAORRfDZRJjWJpUfa1JubW3A+GMgcE863k?=
 =?us-ascii?Q?tOp8ZdZDz+fbfp1yDwszB5pov/v2b9EMLngy9kADVTGT/4VxwlJ4a/x8BvI+?=
 =?us-ascii?Q?CYNr7kTXKC61OVCGRjAp64u9wDpxRvrzS2SCLv7IBUbNGcHWqwnhao5pQdCy?=
 =?us-ascii?Q?olYFEDanvwHc4OUTSUKINFe4X0YSNL1rQafEREVd1SHnl18ZDayptrEk8CAa?=
 =?us-ascii?Q?Gr85VfWEWH0jsRR1zeHrKjLIUZxlX/aWLGxCam0ULhgYfNw8prNQBsAhmo6R?=
 =?us-ascii?Q?r5vz/Uu7n69vKMTU00QLDzVfo5cSZ2sGGShNWAQzxDNjHUex4BbwdoIGz86t?=
 =?us-ascii?Q?NoZ+e9XZPMYLHiV6bMSK10W6SqztRK9JkXdfBO7odh5dawmVUQVaBqGdjufN?=
 =?us-ascii?Q?lUIZy9+8RzxCg7Pj514dCePyISuowz9OGeZ8X4XYRTPEJB6r/fp7VhAftKqB?=
 =?us-ascii?Q?JFkDuHuG8fmpG6q6YRvRj0/fOp/JJ2cmjjOpq3MRO5SPUEC1KU02pReyiq54?=
 =?us-ascii?Q?5C+Qgl9czhoBJc3PSn9u94B3986DqOE6cZD3S+MUSzLij40D+/2NxLaz0no/?=
 =?us-ascii?Q?G1EIuX0wbntq6FBNVK6GMVOJcqnuc11R9Erc3pkAksWbjG3aeX20msvuFz8A?=
 =?us-ascii?Q?neU25xtaRYWQqYwwQMuwe+uTCfdlJEjkOYoqEBKrFK2iqiytmHp5UJKMKFcP?=
 =?us-ascii?Q?nHqEXpCAue6QUexlV8DlzI9pEBk11hpEr6pj5Yn6yonDWCGJXzRaQgbWAVIV?=
 =?us-ascii?Q?s7M13TyRvuWmPpLv/ocwW2QXXdcik1ZbfaHSKZn2CNEW6y4EXCn6LcR/XVeM?=
 =?us-ascii?Q?Ew2eMNY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H8DfxZTJYS3GpHVu03ZThBw43oQo4Di+hr6+XZYS/ZrFHxfT59lpHx8qUeLn?=
 =?us-ascii?Q?vbW6crQ7Io0zEmxeoUSjqMty8i71z/qNcLmQAykPVn7WA4rqy1UWKOg7I+Xa?=
 =?us-ascii?Q?k5S3OE/y4+0Ytd/r6ELtVFg47Kiv0QhZFR0OOksHsCnEjHeVGPbgxwL2mRJH?=
 =?us-ascii?Q?dpY6ULfN1F5JNi/V2s+cle9kNjd4VBe2Ohg4MOiDCp3Rb6hfsQrR8CxUo6I2?=
 =?us-ascii?Q?5NY/pPKBJSuGJGjhtdcnVrlXy+5LBx/77pqOHDiVPcnKJa14fTWzbDKm3xkY?=
 =?us-ascii?Q?LAihV0sczAs8AbHLLKMv4SZP3Iq20LnjhqVhhyYVh1MIZxVda+rY2vKBnh8U?=
 =?us-ascii?Q?J8e76xeGLrDPa1/ekcyiBcdm5xnP3Fz2OIZeOom/FkrTio5tQbgnO23NJejh?=
 =?us-ascii?Q?9tCDBvpv+82ZY2Z5rdantGNNP4ilqdKoBqlShQ2HFqGqjvloe1NK93kasSSZ?=
 =?us-ascii?Q?LIhmfBbkF2KTNzJUeZXOIwYSe90EG5UikAsiF2NhgyhhtEViNs6PTHVtOR9R?=
 =?us-ascii?Q?eItI/XoCnOuhOalgaT3gumn0lHclVixTDEd3YyyiVjSwYzYzS6pjnW6YlyEs?=
 =?us-ascii?Q?BHQ5xM05GamVgezd21zyNciN0ZBdn8XVxisGowrz9r5+mQn6uE/tlATd7cnE?=
 =?us-ascii?Q?dswaKq1QagP+rBZ929Z2PkFleWxjfuVE8uim8VfZ24ptbsM8TgeSkSBn90ST?=
 =?us-ascii?Q?H5oKS3j73mDExNyFwloJm5vNxTTmGRZhXUVc8R93uE4bc6tCbow993sMrUJi?=
 =?us-ascii?Q?TS7I9yyRg/bZTfwCyUQVKTmDGXY8ODtG0/PRwbjNA3/ApkBnU5x7d7dRpZ9/?=
 =?us-ascii?Q?tFUaz3VKGQximqESebQ+cMc7+IsycNwg++q9idqpi5JLbNuiROXNRaeI2FNd?=
 =?us-ascii?Q?QoCRTUfFos9+tJTxzhLD+hZlgn84W+6U8phNbuD4FQwgnUNJQ98dhx5939T3?=
 =?us-ascii?Q?3dSYXds/ViNsQtnPBbBh7h/WUTybeNv5eiRstshXZBvXV0HdpCdSWvxfzM3C?=
 =?us-ascii?Q?Jd+yehMGJvgdpLATIyqdAKan94+FVHxUGK5qb58ycYiFM7E21ABT4ro7oqSC?=
 =?us-ascii?Q?pkLMPBlmNU9rMmWdEz2/RKV+YKFXY3zWcmEqqGZ7zOq00pLUGvkRE9qeoiU7?=
 =?us-ascii?Q?alOAgYZivfsZE7IwedQjvNYTPPt+qxXcpUC21NjcZWfjH1pNffYC7roWoKTh?=
 =?us-ascii?Q?BAXznAG/nBRxcqBCjjN8l6jk5dletLb/KssaKQ7T5OVJHEgjp6VjJIYCYimf?=
 =?us-ascii?Q?dUKh+nci14T86WvhgeWK21BL8rn9Zsws+0ihBUfA2Tz3b40TiC+yHVBIZ1P4?=
 =?us-ascii?Q?d9ClLtVHdMvKkwEekQT4YzXZfz/VoWCxd7AwwauFjbUZNPGegkAgr95TO8nR?=
 =?us-ascii?Q?dSPYO6B6I2mEhjmNPe28bi8EL2HLDCblG4z0CJjtzbket1P5cL1a+jtFJY0F?=
 =?us-ascii?Q?Qe8rctFIQMUxnEexNgMhetCNXa2ShUaVcPtDfu75SGyqlOnyA2avnMr9GrOE?=
 =?us-ascii?Q?IvthyylM/gBVWO4SKQvgym4l8xz2Sr0VSDK3nQqo6dPdW+9nStDPpJhtaqQ0?=
 =?us-ascii?Q?izyoTIPpjvl3S8bTsu2un9AAYo6beltpcChHcK1V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2421ffe-ae30-4e5e-1fb8-08dd02fca802
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:30:33.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5bYI6XpPYm6MWiQvkUNiAF5/ShrFwJ09UCeCg1WXVbWo9m0KL1c/QvKk4dtp9Vg7Sb+yY0fzDEz76DD1g163A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339

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
v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 266 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
 .../freescale/enetc/enetc_pf_common.c         |   3 +
 5 files changed, 311 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 7c6b844c2e96..91428bb99f6d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -527,6 +527,233 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
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
+	lso->ipv6 = enetc_skb_is_ipv6(skb);
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
@@ -647,14 +874,26 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
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
@@ -1800,6 +2039,9 @@ void enetc_get_si_caps(struct enetc_si *si)
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
 
+	if (val & ENETC_SIPCAPR0_LSO)
+		si->hw_features |= ENETC_SI_F_LSO;
+
 	if (val & ENETC_SIPCAPR0_QBV)
 		si->hw_features |= ENETC_SI_F_QBV;
 
@@ -2104,6 +2346,13 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
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
@@ -2117,6 +2366,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
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


