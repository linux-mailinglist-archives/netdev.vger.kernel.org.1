Return-Path: <netdev+bounces-275727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE30LIIa1GnHrAcAu9opvQ
	(envelope-from <netdev+bounces-275727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:41:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE03A742D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96944301BC34
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD7B3081D7;
	Mon,  6 Apr 2026 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DhY941wb"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C02512C8;
	Mon,  6 Apr 2026 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508095; cv=fail; b=ufLNQsIoDSrV0/lYkbX42FaUxhEZk0PZh6gMgmBxgGqbcV4cO1XyJlwRAKeh1OOHc3RUSoo6m8U3T2wQIkWgQmrTL3T/t211d7gXAAgE7grJXE2iR7WZ1ceC1y37TFyMDIuBKuCUho/eGShZ6Q4Ek8KHohq+i7zoL/DpGlGDVmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508095; c=relaxed/simple;
	bh=c2t7neGM+DbFaFHS4l5Gu4Uj7tAJ8W917alrefKiEzk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EBmYJaBsTa96Qgyu37xyQcIcW09c5aVu31ljSuWB8nPBmOS9NlgBBjl4l1FT/UrQeWRaVjFV6Xdi7LXD6rtTDOP2ZADKnBFecF7m+x9x5k8hLMZ2X+AeYEmmASgJXZbsqeb3j4QWWHfUa45RAM2g55zPhSFs6p90eqgiiAqdvsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DhY941wb; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk8Lj8enw8cSz8QYpJbJmlqZdEQk3nDmiYyk10xKw0WwIrVleV+JRt2D6OXuAVZA08JgUr7CDXBwm3iKB4jJor8WjeBL/GYOeoYaCEc8cyQ4NBurSDah4HOfUn6RdsRpzS5o/3Xee2QnDhQ09Ot5XqHgawEPnluVT5op2iQycFiRsRcSR8iwDevhwgQgiIgRAtAHX0n9PKBeHLMBbQZ9xrGAyTJOpGrDrlxMlnHUTLf4unn6YUco5yFB09aEYCf5pAZVuGtke66kUg8fdgLZqpcFyGk9hdXfbvAD8YcAVBUurUrF2GmYaJkM9/toSCT3/YZp/DC4GTamlwzHYw+2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7QeIdxbmF0/oxi6vpl060uVZ7A3mqZRFTYeBdqeGEQ=;
 b=xyh67mE0xDPjA7tYuti4AKw4Z0tcZikfcNu0XP2Yzu34mYNNOCpEtkmPvhA4FBQ2wOrzrNWkJTvkygp8mfUd6z6QZk+fP5cCI2ceWILCiS5wE599x2tvAVqeW+e3Lsw/w7igKT0t9+5dMTYbgpzGC8COptP58JmiiN6MYacXqZeK9li0ejfWJ5SHhONEudZg8B9L8J3nqxvrMcVa9krDKSRhMPnh7X7x8X3V9wRe5mF3fMIh+l9kyiQ2BkNwg4SPaUwXlgspyPhX/BBIKEqLqqnsmqIUXlYEGDVuuzgO+OsYlOrEKi0Nm923WyBHlPPSWKclazXG5tjEt2hKxnDkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7QeIdxbmF0/oxi6vpl060uVZ7A3mqZRFTYeBdqeGEQ=;
 b=DhY941wb+2tJ57aatQb0xASxJh2WwBvA+mEO3+VnV23t7Gp44sd0TLRwAr+IS6ukGU/+57DdtA8SrYV2UY4rB+qbTmFXbfM65Erg+8UbAz4vfH5CJ3w5Q6TRjh0RNikfwR8ForgvidRs49CLzlixAqwNGOA9WaU+GC6WKBI2EGq5sI0XjE3KGxXdAihB6lPL4TrDlhlT6vkexkku3Hjs6BIZSY2/m/MCEnluuAoRliD1Y8IR26/pvgj/ErfqItvFhtxz/skArvcm8RRg6Y4ZM+hrkrz38Af1pidw6UfXNtyHKWZbcxGpvJN++R3s5oqFvLxwsbOp33MFz3wyjZx8Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 20:41:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 20:41:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 0/6] Fix short frame transmission in enetc
Date: Mon,  6 Apr 2026 23:41:16 +0300
Message-ID: <20260406204122.167237-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da7a02c-baa5-46af-66cd-08de941ce206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|7416014|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BTN01wXNtNnK/sGkvlC1GRsicADKO/ogrt+qCaeofiPiCm3CEaATWa8v5K6kS9xsnDwXyrD8vVU+AvxccbddmDiP5+lLkeOtdtB/b+OANnkVywhIklK68p/tCe1+WfVnO0MuO/lvp/4eT2ASs2zTKKLC8u+qAEJdtARTpz1gqLF5z7YqXhOf7cFNj/d69oVfA4hr7svzMT//sOxq1WPBml/Yy0DVFt0cKhEx76psSfmizU7WxQGANMCwrflUlDrwyF332i6q2FZH3S3K4PoeDvPFINyllztGyKMtNw/GBQtdiM9l5Cl6PlsCJy1gqrlAjf4v/39hRQnQgS14E4NEE1xu7sV+S12uilcWhCFolW9Kl/vI4rlcGlfCIz73iMG7aokoUwDc5zZ9gzqovoiLm7cRkNDNkIyefBfLPal7wwSlr1hzdw5PXGLYWZ6hLcSCtJEjWo/oQp9qAkFuP/TTMXZL9jxNLxYEPnnVB5uUBmQMDLYWDX8ORHEDkD4HlIbL1Qqh6Mk23yKStiyRV3Z4dLI5gwcojeA67V8ry469rySb6rIXHyenuPVrN4XIausY+lLKrrn6rBsCwBYDl7HPSG6OkCHmmu05TpglfVCLyx2vugNAVCsgh30BAtIPrtHfDkEUkVvdU4CKUl1biEg6SDAOlGhRpeYxoHerpp7Ad1tHbF+FqzCueCMg1epR5k9nCip/HknZADEIRMXj43m6G+d7C7Yp3CsZyZhoxdNLRnGEt0yfBo8ac0ESX2rbN5zA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Ngu+mxzqnLduMDRuZ5Fc5Bmb2DmGcg0anERXZf9/1sthGKMHEXIsoDaV53n?=
 =?us-ascii?Q?joUlSD573AGMfdwFAJ0bdXiB4KpcyaWC94avpL8ZgYw24zFQcIbLwXa+TPHa?=
 =?us-ascii?Q?9Ug047V93cYe2XETfH1+r04O6ZfeCKgbX9nn2EgMZTUQ8FeFLIw/V8sLjLjA?=
 =?us-ascii?Q?HSbEE68fHgguEkFBK36oCJQbKkkrpisON2BuhNJSPO7ve5zJnl5l2TicWj+B?=
 =?us-ascii?Q?2/h6H49W4tWaqqhhbQDwmo3jkhbZmeAlxSqXGVtj3E0JgXfbDAlY3HR47Y4w?=
 =?us-ascii?Q?nOrW0B0AWt/x/hhxv5Grbyr+PjBXU6AO3d9PFzIvTrgDW1d6euGILoN+erlo?=
 =?us-ascii?Q?C8OEDcxFSHeU8TLYzaSBMAUjo5avcp4yxWliOAdCF+UYB/K6u2kg6gWFr3lf?=
 =?us-ascii?Q?rCfwB4bu0Kxeg8x+ppVxkztxx3oV3QZtdAsc1HWGO7XEh4LVsPjFS9te50hB?=
 =?us-ascii?Q?GhE/B1Ho3Y5pX2Ws2F2fCEcuzWKn+JEJVAgdvPze7VRkJsTeZuuApJ1+4eA/?=
 =?us-ascii?Q?tpJ/BX1rCB5MIVTW0hNZSFoeDejugl9tkh2zch1V3G0VdVKNbt2aYpMh75fz?=
 =?us-ascii?Q?uryOXMQjXZIkY00SrFREj4/eVmHXxdvKF7rajwQx2T2ccDzULziqa0t1EMYl?=
 =?us-ascii?Q?RNul4xXCh1ml3WSNUZshxrau9EE2EvtuUgkTrkp+DhvrKKbDTV917K25P6Kg?=
 =?us-ascii?Q?g2g/lJ05uJgWzji5k4wfRIqcy2x66JYMIakoYpQ8nzlBSEIwhuuaZA86Z1Fl?=
 =?us-ascii?Q?J4flJPpjD6f7Z834IoBYFXIAVwhmDHu9BdSVuagHaIqiqa8l3m6ymc1TWim8?=
 =?us-ascii?Q?o17qm8QNLaLKOFDIA+kuLT87ch7oggQLYHd4BzZjTFHqmxwXjZ2ZdpBaubX1?=
 =?us-ascii?Q?Z7H5T2duubB54i/F7b5UikXU/n4fhwuIClTnV/Agu7iyWEhwcptHhkn6hjZG?=
 =?us-ascii?Q?93Bi20iA472kB5ehRZzA8FtO7UDGFPF6sRyPb7VTtZj0rqih0ZdFK6T5IH3l?=
 =?us-ascii?Q?/J228qibfScVG5w4yUVln4TDD8LThNO4Qc4Oa8I/s2m40SmPdYkdnjVTtR1z?=
 =?us-ascii?Q?M1ORjkeQpAvuUeHmOEpVaDtZ/uJKs3qyJ9HAm5os3FnXlAVQIHuok5+MeMap?=
 =?us-ascii?Q?4BzkziuDBmax7e7+fgS/G7pDs5qJ6gXL4F1Xe/pc66mwxnA1E9Ty5/aEaB4l?=
 =?us-ascii?Q?JHyfowpT343X6/lw5Bwew8FU6jbhrte0ivIo5LN3w1E6hKZEUxgSo5m/Yfsv?=
 =?us-ascii?Q?9kZaieT5GHzBzyIoUbdLKmRB4Xpq4PhsUD3C002IZXG8/r4d64qxsL7qgyqc?=
 =?us-ascii?Q?nID2C+FmXSFyB7gxRWr4U6XHN499i8YE7CjYK6DQox9YoNVKehIYuHJEGSOi?=
 =?us-ascii?Q?NW3nDfCxrEhZgHgT/SeaL941AE8KqLw6qRbDFI6I/oOkm2XsMxH6B3EfyFrM?=
 =?us-ascii?Q?woIDijMgpIj/fBKqCiAWu2ZlOddMXT7yGTEL5SBDWcA3/mr2eBO+ILfKHIm4?=
 =?us-ascii?Q?qZsGO7ChdcrWzOtLFwBx3/ojHmOsjlb40sU9QECOBe2lotoU9rHzavSHJJ3P?=
 =?us-ascii?Q?oudDMwYs9KbBLWEopEgDrE4bLPvVHvUkpFREjtvuWYSFs7ghiEhXcItLDh9d?=
 =?us-ascii?Q?2+n8W2eBcN45QJJDaHmaRtvivaUCwFBEIAaKSMqrYeNieKwgfPrRNxQF80AW?=
 =?us-ascii?Q?npaDKGwTmJHY8/kc3HJTJi7jFCSUwuMPNFMEuIWxByHkxJhcN9nj9UpJ8ZqN?=
 =?us-ascii?Q?opigCb2gvhPGCTRmwUvTlFylBvv74/7n0URe2EzrQpwAuc69rLYE170pmTHE?=
X-MS-Exchange-AntiSpam-MessageData-1: aq1AmsquZv5QIQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da7a02c-baa5-46af-66cd-08de941ce206
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 20:41:31.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AzvU1SH+Q6dAc9m1RS27pAh2eflwBmYDlMeEbY68HWnzzu28K3MIy/wxrMlSCSy0jjohhvIW6NzD7iyzpVlVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275727-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EAE03A742D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a belated follow-up to Zefir Kurtisi's report:
https://lore.kernel.org/netdev/20260220132930.2521155-1-zefir.kurtisi@gmail.com/

which is that the ENETC misbehaves when transmitting packets smaller
than 16 octets sans FCS: it sends them but does not update the completed
index in the transmit BD ring. I did find a sentence in the reference
manual explicitly stating these short frames are not supported.

The original series (patches 5, 6) were focused on handling the invalid
frame geometries. However, review pointed out further issues in annex
code. Patches 1-4 handle those.

The main patch is 2/3, which Zefir already tested (in a simpler form)
and confirmed working in the thread from February. The code path should
be identical for his issue, so I've preserved the tag despite the
additions.

v1 at:
https://lore.kernel.org/netdev/20260401172246.1075883-1-vladimir.oltean@nxp.com/

Vladimir Oltean (6):
  net: enetc: increment error counter in enetc_xdp_xmit() on DMA mapping
    errors
  net: enetc: linearize PTP event packets with one-step TX timestamping
  net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()
  net: enetc: fix bogus TX ring consumer index after reinitialization
  net: enetc: pad short frames in software
  net: enetc: pad short XDP frames coming from devmap

 drivers/net/ethernet/freescale/enetc/enetc.c | 38 +++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h |  2 ++
 include/net/xdp.h                            | 23 ++++++++++++
 3 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.43.0


