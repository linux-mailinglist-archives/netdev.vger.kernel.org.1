Return-Path: <netdev+bounces-240965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874FC7CE2E
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 850F64E6351
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5B02F5A18;
	Sat, 22 Nov 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kgtEG0O+"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631102FCC1D
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763810617; cv=fail; b=C5si/GGdp0YtDm2fwDEQ7PyR11PDZ6Rc2m24FVwu+GMpG6RrUzSxHO9pNKMgKrgfDcOeGl79NktkD32BTncWP/BVYCQIaCRoF6xjklAGtbZp2ACVYLfQWlppNnUvd1yaGPO1t77vG065hnDEgI6ZHKQ5Nz1ZwpAOrz+3jw8pAfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763810617; c=relaxed/simple;
	bh=+NduyBWoCNh4URhJgFJN0oSWnOU9s2rwL4YFZAX8q78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r/snXJgRUdk9Db96C4Z8LNQTOheurWHVZpLcs4IAiuNTn6M9Oc9qh9MWE7zR8J8dtxzvGWd4s27MQubVfEoskSlzcLNroUYqDzJ6ncwdGSFpbMs3NPbp9lXXZpz7CB0TQtzkSTvwub8qvhyTCLWUpO9UDnnZCWuMdbnTCXrIddI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kgtEG0O+; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9ajZKs+ScabzWnQmd/nDfikLJgjaIuBH6OSUGluLDq94D3MRQTBTt9mfUn4SXo07GpwEFOq6j55ryOugctNs2X2PSbQmJcW+1acp2tearn1cfB/TEMsxlt8+LlFer9nDfvJV2rwvhrvxuKVbQPQeZ4y51RrEWKWAkb9xD0wzavM+axX6x8FA5PG+i7NQkhC4Hc55CynQxmwg5BBIpb/COUz7y74pHDceF5IQEVVQuDx9fyh+Pepyz0Yk1vskqTkjDYQiLcheqwGB7VmMhr5sxXfLgKnncfqang82o8edGKcblxmxLm+xeCg5vCDSCMykhziVt3b0YF3rJmtfl4GHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8t6bUxLivRuvJ0r3HN6hFmLNqQ8ejctbQxVzLORhkA=;
 b=D3lV9Lq4Mq+/mLfliDdRYK6XGvkic8HSBggT9Ys4GXRrmQXi47tOddV+UKhDx5YAzqXVFykacFtN6EHRfxcsJ8cwYObaVEPKyTOYD7dh5m+NKgf4Had1gPw/CyET1r4P994tQjZ6viM/3cT6tnc7whx088ZT2vZK2yk5uYIr84bWR1lQHDz5R4016J+6NJjA7uUmi6VIGy4OUESE1Ngm3dV3cwfkI4DJHrbvqEieeVisvmGdNShtmv2JfgbPnlSAIfYv9kY9GupShDmJr2ZEGsc60eU+0vlu2GoTKhG1u3gutiXYcQ8mDRyUzmWLenxQxPDQhJsT/BzR+1tt10ypRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8t6bUxLivRuvJ0r3HN6hFmLNqQ8ejctbQxVzLORhkA=;
 b=kgtEG0O+mYfQBT3rhwRGwBCNvs/tQBjYZb+/7tqzYxHpu5RHfknXyO53irLZHQK5itFzLoJYgM4giNVoQifClff0fzCsc4O6Flzvuzh9oCag38QQLJlKnBH8hD7dygyg7ok0UkLvoJm107bhSeg+nLHXEs6e66TEVDARLQoUVVFJvN6sR15xZZPG7SmiLAP6QULyn4I7BFl9ARXrik0uHjKgiuCH4/SarOXqZPnAkZy8wxg0AZL7H2OjXv2EHdQOqJsiP2kBJinR3ZjMoUjdDorxzwN3DZufPqeh2tj12z8jmzdFS0FZwyJcYM4lmwdDCjO/B4ETgtB8+jywhKVUUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 11:23:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 11:23:27 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] net: dsa: append ethtool counters of all hidden ports to conduit
Date: Sat, 22 Nov 2025 13:23:11 +0200
Message-Id: <20251122112311.138784-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122112311.138784-1-vladimir.oltean@nxp.com>
References: <20251122112311.138784-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0031.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a19267-c581-4bd0-a05c-08de29b98ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zrbhSppxOzmpiO2tGAZ71b4mmW/dTHt8XI+6vWaTt0bNObC3IKdsylnpa3hn?=
 =?us-ascii?Q?PGYdQxMekZO0wip+8sq1W5akRFmTAirLIivS0KvJcaRi/AiRZ8Ks1yBnMD0v?=
 =?us-ascii?Q?VbGVxaAeSvFIYu/B0gzFJgnBDkJmdbqlhbreNj6B6rZ/0CUMrv6B80EsYppY?=
 =?us-ascii?Q?8Twcb4TsT9YCW2c8qd3qBoKWg1+q1lMOUNwr0zHDC22RTVm9ZFof6+88n1pJ?=
 =?us-ascii?Q?Y4rH8AKyk4k0WNzfblScvROZMIQvLJkS8+zoejg1P7rCXBiAskod3VJXz/iH?=
 =?us-ascii?Q?HRZO/OQAHeY9ZJW3dBxm9nhsDBrSYzAFJR2BpqQyxsCPG7Tte3F5xFpu6Q3O?=
 =?us-ascii?Q?Eqh2dWNvnwmOUCiTHdH+NGYrv4k0Ov9Bp+2iia3/bKt0mfsZzr/MgvPJN7ja?=
 =?us-ascii?Q?y4XFfpTUAvl0TgzjUCuPKPvw+HCoOlscAw6F0HDZhRcI+CzPzVhOkCjv9/jh?=
 =?us-ascii?Q?VIv4ctQzcvKBDmrmdspQnJYaklphW5emZ4vyZML90dozr6cDwhVlwdfEyHNy?=
 =?us-ascii?Q?OreKCybUod/ADt7fkigry9YE4Tu1kFM3BoksAwM92i2dGzZNTQyKouebjTaH?=
 =?us-ascii?Q?0TsLrGWZSAO2kxFwQJjobHNK8dxxtqoA5a1cwdUjU+OTRXY3p7vgZvBDkRVu?=
 =?us-ascii?Q?y365M8fl6AFDjpuYU7QsqgYQFFh2sFelHBHKgckO4tlCU3+bGI2MPmKtHhWO?=
 =?us-ascii?Q?KO0gMbyyO91Y5OzmToMrazXUpwVim7X/XFzBcgtzf0uz1XaVfGa+l2XiEqlc?=
 =?us-ascii?Q?O1/S4hZKyz5cR+UtzMx/xyNMDGqJzNBF0x12VK3jVGs47ucqL6Q7+QxKGmJV?=
 =?us-ascii?Q?8IvoKlltR3PYGK119JNdyLcgttnebkut3Fqeyht6e+SxFqYTL5j6ObVB0JrU?=
 =?us-ascii?Q?prZRODmBtY8rf4VnsDK7V5d2pSf2R8W+4+a7b3excsgecULegCyacOmAb0xA?=
 =?us-ascii?Q?DnypS1JqP0QaXbO4rVvu7Nfgb9eDCKyx12MZowHqMPipFoxdpNG74E9CTktt?=
 =?us-ascii?Q?f4dgED4sf+JrEijfZVzyBeTxdB+LEjLXWa89K/JPucjFcsjq01NNtBcoRJAQ?=
 =?us-ascii?Q?sANYSLaqGFXclJ26L7ALz/iqMxDjsb0yFsAj9VR2gqnGEgTaKEdRkk4QfmwN?=
 =?us-ascii?Q?h94KHl90iHRkNYSKomXXa0oq54kJ8aNOeONCmkq8eDxEMYrX56qnznXs7ZmR?=
 =?us-ascii?Q?Rxu+7g6OQL7u4rnXwOOnlQWuAaGDzuxgZO4wpLtPk2Vls7BPJqOcSKoqTvY2?=
 =?us-ascii?Q?ZbVVcveGtSaDvox5y/ADmuMOYaMfe8oGOVmWoWS7x6ilSXxb+m5Mjg8+y9dt?=
 =?us-ascii?Q?HX39LYhhNpxDpUyeXGSWp8u/40j9IH1+wt3UwaVzlj+oS7dB4DBdblf7yliQ?=
 =?us-ascii?Q?+OBxQ1AtQ0NTK3SV9UnzK83oEMEQ+nbI7DORbxCiC81uEIyemyc7Uei66vPR?=
 =?us-ascii?Q?zdCjTdDotmfh4XAjFtc4DdjFN9APZl/E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U0tUcxsuWSf2vQsNApA5c/R1g7R9roPAzQ1bfXsqn0qhf+ewY31qkfATuKPm?=
 =?us-ascii?Q?wKpCJtJwDF1QGwedVrJXhqgDhBw2a+jRZ8Pk3uQBNDlXvjmIydQf+JkQ3V6S?=
 =?us-ascii?Q?3OVw1CsxldZ5TGu/f4WL4qugLH44BRqd8weD4tfL2kH/XfsDA2DIKF2tn6GQ?=
 =?us-ascii?Q?CMExoeviMh53yqT0uPe+Pn1Ajoj0uPaAfLI5DrNRbbd4CgUoPxyLS1yh5ng+?=
 =?us-ascii?Q?507Zysxb1FN23ln5MxLHH4q+Xh6nYXmhc1Uox8xK7C2iRFj/gmUr9ZYToUqP?=
 =?us-ascii?Q?wkIen2/XWGrq+WjYyzY4Oc+EU0Fk6fMJIVFhZfnVQvvgYTDhunKnB5TYqkHv?=
 =?us-ascii?Q?pcDtiK2hRE9F3oRNU/I1uQvUiwvM/HrEwbOaXIX5I/mz0MNhLoSnlPkfRO4n?=
 =?us-ascii?Q?o9UlRzBM6rCNbkNY4mNQ+jW8dusJoPHlmU2K7wvksdO6DQqZppSTa1/UK3Jb?=
 =?us-ascii?Q?8Hmp2zEc9pH+ukCjE+aXCHikh44pQfrRPRNVPzREsUOX7mWN/pLLxjQ8Tinj?=
 =?us-ascii?Q?cI4jEWW973So/MiQP0sRLQT0KtQrnuArbVcYA4vqBHgkE7pHL5VGFHSzmzIZ?=
 =?us-ascii?Q?iwZQRumIsjCpJ8fBlMPdcAL5oJMFjj0p5ALkXkkGpnVqyCtgDFA6dmFkOMhI?=
 =?us-ascii?Q?5I1cH8lMFF3ghituG4Zp2eVT5KcDPdRoMNNrJ0r97+MAb/UWVDKpTZPvdcpU?=
 =?us-ascii?Q?Cu2OXAFeZzLilYGp+OCRIVo1iEDpJdHF6PPqz6Tf7ie1uw0GOZdYrZiXYWeq?=
 =?us-ascii?Q?89maF2J1Ut+FHc9eaGxBIqB1nTV7z0mRMmAETzTNLNM23F14x5As1zYuWaCf?=
 =?us-ascii?Q?RcfGxHY8FI261j1Ga+YGXdE/BM7h0X/nb00ur/AYiBnjTwLFNG6nBcdCqWhn?=
 =?us-ascii?Q?/vnfiYULtoLsUkzRTWWSRssTLBI1Bd7zJ3wikX7i43LMto1gCzxYlAoiDqBy?=
 =?us-ascii?Q?2q7PoOD4ZBEq8YZCB4dBCsKgnDRkz7WVW4KQP+iYoxYZigOf9WS4wFkM3bkF?=
 =?us-ascii?Q?KArNJOgN9lWEnd6VfLz5pn4TIa53Sw4Fh5EwllDktEBfXxUliGttPOXRaM4z?=
 =?us-ascii?Q?Un2d4HrG0ylPlQ62j9PU5HDATQrxSe0Vip31qfLZFhC8Slnx7kwc7lHQI4kG?=
 =?us-ascii?Q?YP/A5VQ3otPjUzmCC6OUMf/7iYCwTvaJqrc9pSU5EtMHmjNKTU8lYk8zHoRA?=
 =?us-ascii?Q?xw4Sb76cAN+hTn6In0MRPGQswax0scqcuSbXnko8m0UIK7FCfBXePhVXGoCH?=
 =?us-ascii?Q?olXh35MmN82P/Q1ng49NJugMLa8BqzNb+RwS87OfmhPmHlIg8WKSJuDtVOgt?=
 =?us-ascii?Q?NKr9IlhN8H+NkSjNA5iM8UxJWsIoQnxk/qx9hbGufFxEsVTm+mbzw5TzLw9N?=
 =?us-ascii?Q?U0kt/oDeJSKBtNs6O9TJgBl/eSJUar+Tw7ek2If5eoZEdqCUJFCYaBcz+bl3?=
 =?us-ascii?Q?8W9s+PPuXbLrCnbhqpz/+tWdOqM13JNnDlpJEdO/POFEm6HTuZetDgcUSfg0?=
 =?us-ascii?Q?ARw2py3n7NvvMHQ/NxgrP0BsdBM7LNbzfk2HSFRQelftAD8EjO89emAP8qcW?=
 =?us-ascii?Q?XPjVEOlyuzY4eOMfYimHTL340oHo6c15TD/nwq64vfRyYE6oRuOT2IqBlWNr?=
 =?us-ascii?Q?tZMCtULBJxe9dPMC9jOsgks=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a19267-c581-4bd0-a05c-08de29b98ec8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 11:23:27.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBmagNHM/fQcuqKa8XHeobv0AFJfOjaltB70zeb7rJBs4otGv67JZzf+cUOCVKpJqygYztaYjnHl4oQ0qNzQYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354

Currently there is no way to see packet counters on cascade ports, and
no clarity on how the API for that would look like.

Because it's something that is currently needed, just extend the hack
where ethtool -S on the conduit interface dumps CPU port counters, and
also use it to dump counters of cascade ports.

Note that the "pXX_" naming convention changes to "sXX_pYY", to
distinguish between ports having the same index but belonging to
different switches. This has a slight chance of causing regressions to
existing tooling:

- grepping for "p04_counter_name" still works, but might return more
  than one string now
- grepping for "    p04_counter_name" no longer works

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/conduit.c | 126 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 33 deletions(-)

diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
index c210e3129655..a1b044467bd6 100644
--- a/net/dsa/conduit.c
+++ b/net/dsa/conduit.c
@@ -87,25 +87,51 @@ static void dsa_conduit_get_regs(struct net_device *dev,
 	}
 }
 
+static ssize_t dsa_conduit_append_port_stats(struct dsa_switch *ds, int port,
+					     u64 *data, size_t start)
+{
+	int count;
+
+	if (!ds->ops->get_sset_count)
+		return 0;
+
+	count = ds->ops->get_sset_count(ds, port, ETH_SS_STATS);
+	if (count < 0)
+		return count;
+
+	if (ds->ops->get_ethtool_stats)
+		ds->ops->get_ethtool_stats(ds, port, data + start);
+
+	return count;
+}
+
 static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 					  struct ethtool_stats *stats,
 					  u64 *data)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *dp, *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
-	struct dsa_switch *ds = cpu_dp->ds;
-	int port = cpu_dp->index;
-	int count = 0;
+	struct dsa_switch_tree *dst = cpu_dp->dst;
+	int count, mcount = 0;
 
 	if (ops && ops->get_sset_count && ops->get_ethtool_stats) {
 		netdev_lock_ops(dev);
-		count = ops->get_sset_count(dev, ETH_SS_STATS);
+		mcount = ops->get_sset_count(dev, ETH_SS_STATS);
 		ops->get_ethtool_stats(dev, stats, data);
 		netdev_unlock_ops(dev);
 	}
 
-	if (ds->ops->get_ethtool_stats)
-		ds->ops->get_ethtool_stats(ds, port, data + count);
+	list_for_each_entry(dp, &dst->ports, list) {
+		if (!dsa_port_is_dsa(dp) && !dsa_port_is_cpu(dp))
+			continue;
+
+		count = dsa_conduit_append_port_stats(dp->ds, dp->index,
+						      data, mcount);
+		if (count < 0)
+			return;
+
+		mcount += count;
+	}
 }
 
 static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
@@ -136,11 +162,18 @@ static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
 		ds->ops->get_ethtool_phy_stats(ds, port, data + count);
 }
 
+static void dsa_conduit_append_port_sset_count(struct dsa_switch *ds, int port,
+					       int sset, int *count)
+{
+	if (ds->ops->get_sset_count)
+		*count += ds->ops->get_sset_count(ds, port, sset);
+}
+
 static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *dp, *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
-	struct dsa_switch *ds = cpu_dp->ds;
+	struct dsa_switch_tree *dst = cpu_dp->dst;
 	int count = 0;
 
 	netdev_lock_ops(dev);
@@ -154,26 +187,57 @@ static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 	if (count < 0)
 		count = 0;
 
-	if (ds->ops->get_sset_count)
-		count += ds->ops->get_sset_count(ds, cpu_dp->index, sset);
+	list_for_each_entry(dp, &dst->ports, list) {
+		if (!dsa_port_is_dsa(dp) && !dsa_port_is_cpu(dp))
+			continue;
+
+		dsa_conduit_append_port_sset_count(dp->ds, dp->index, sset,
+						   &count);
+	}
 
 	return count;
 }
 
-static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
-				    u8 *data)
+static ssize_t dsa_conduit_append_port_strings(struct dsa_switch *ds, int port,
+					       u32 stringset, u8 *data,
+					       size_t start)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
-	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
-	struct dsa_switch *ds = cpu_dp->ds;
-	int port = cpu_dp->index;
 	int len = ETH_GSTRING_LEN;
-	int mcount = 0, count, i;
-	u8 pfx[4], *ndata;
+	u8 pfx[8], *ndata;
+	int count, i;
+
+	if (!ds->ops->get_strings)
+		return 0;
 
-	snprintf(pfx, sizeof(pfx), "p%.2d", port);
+	snprintf(pfx, sizeof(pfx), "s%.2d_p%.2d", ds->index, port);
 	/* We do not want to be NULL-terminated, since this is a prefix */
 	pfx[sizeof(pfx) - 1] = '_';
+	ndata = data + start * len;
+	/* This function copies ETH_GSTRINGS_LEN bytes, we will mangle
+	 * the output after to prepend our CPU port prefix we
+	 * constructed earlier
+	 */
+	ds->ops->get_strings(ds, port, stringset, ndata);
+	count = ds->ops->get_sset_count(ds, port, stringset);
+	if (count < 0)
+		return count;
+
+	for (i = 0; i < count; i++) {
+		memmove(ndata + (i * len + sizeof(pfx)),
+			ndata + i * len, len - sizeof(pfx));
+		memcpy(ndata + i * len, pfx, sizeof(pfx));
+	}
+
+	return count;
+}
+
+static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
+				    u8 *data)
+{
+	struct dsa_port *dp, *cpu_dp = dev->dsa_ptr;
+	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
+	struct dsa_switch_tree *dst = cpu_dp->dst;
+	int count, mcount = 0;
 
 	netdev_lock_ops(dev);
 	if (stringset == ETH_SS_PHY_STATS && dev->phydev &&
@@ -191,21 +255,17 @@ static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
 	}
 	netdev_unlock_ops(dev);
 
-	if (ds->ops->get_strings) {
-		ndata = data + mcount * len;
-		/* This function copies ETH_GSTRINGS_LEN bytes, we will mangle
-		 * the output after to prepend our CPU port prefix we
-		 * constructed earlier
-		 */
-		ds->ops->get_strings(ds, port, stringset, ndata);
-		count = ds->ops->get_sset_count(ds, port, stringset);
+	list_for_each_entry(dp, &dst->ports, list) {
+		if (!dsa_port_is_dsa(dp) && !dsa_port_is_cpu(dp))
+			continue;
+
+		count = dsa_conduit_append_port_strings(dp->ds, dp->index,
+							stringset, data,
+							mcount);
 		if (count < 0)
 			return;
-		for (i = 0; i < count; i++) {
-			memmove(ndata + (i * len + sizeof(pfx)),
-				ndata + i * len, len - sizeof(pfx));
-			memcpy(ndata + i * len, pfx, sizeof(pfx));
-		}
+
+		mcount += count;
 	}
 }
 
-- 
2.34.1


