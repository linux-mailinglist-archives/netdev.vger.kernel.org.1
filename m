Return-Path: <netdev+bounces-261006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFgZLmMQn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-261006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:08:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE619934F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADDA6303A3D3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8993D6476;
	Wed, 25 Feb 2026 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d7dvqFnP"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655C3D5240;
	Wed, 25 Feb 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032059; cv=fail; b=CZd38tEFjGpZSFe1q1iA6yUE9beDogqAUopx7RR2ctIh3j8HA6TPNgWzygGAV5/pInJ3DfIJEjv6hf1XZkvH5t9URGnRobBZgMc9Bo0ns4vMJ+ILZs5n6TRfsblq10E4GWBUriWjpaRBC6dK3b2kAle57VKvx7kKR9/bzIEuG+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032059; c=relaxed/simple;
	bh=zTy7mvUdRRL/Q4SiZOBkcG8ZlC9dRfeyghzYwJxRswM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LeQtqiangR2HX+eMo/sUWuz4qOAu0QKNxqPUWoqDFIX65Ta99QrYzumVeyhW7quxlLTRpsv9hIqmhKqo2cMq1joJ6psIl67x7gjmy0Q8O9KHgwYIE21WdTflR2Up6tiPf0uMgVtAdm4K42JicezOeF8swpyIUK5EyYQZpEWpII8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d7dvqFnP; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQg6m7lPmbsffDYvwm2q4Gp2r4wOrhwa7iC+Xeb4Ko0D6ETplQJIbwIeBsCNrv5Bd+8hgYep5NGnAYxWU+kXoOum0ashs9QUNQqauak1zhejOAMa71KWTXoQtC7/HTwPITe0mIMh+UDckznGCZjg4TVwSiNP4Ct/eIgOojmUSRl/gYbAcUyQ6EZyTj8fY9yA9/9eMuv8xq1pm86mWjKntksuzjaOn472Q105EgP10NtAoVNOozzBjm1j9fERnudIR41cMB2C6WQHovTESqNxcRsK9LsN4r1Xd/q1SrcueVqJTStnZ/UEqnbLPYj9IuwhRDK8WOnKR8O4UPxq267Okw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j3VwwWnm+VeJ8i0XYbUBj7ZeuSM3I+4j06Z8lWV48U=;
 b=NVDyyO29PzmxBrvo/1qeiBFBtjffFFD3fD7kSjqOXq2/Us8EGfpA7M5NYcAPktc0cyKgJ7XCxbDSlPdJdpQayWzpdkfkldoqAp55pxpGLlRS5pVJT0o7KtkCOiD4ErI3pPy1PV0inIXrUqyAJT0ti0i1d4MtpONCCCTrpitGZwh7PCiarCoAYoKAC6b62vLYpOaVar1b01zmM2wE7MpJSikV5a4VRK7/M3arfsRlAb3mNpL4ZJAGIlQ2vozsBorDyg55oq7O3d6rdgnHu7qPvU3vZa5mnXUFCfUDT+O03+I3B32V6XYib/uLPK9r74P8/tRNBeRORHGKlu4bcxWmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j3VwwWnm+VeJ8i0XYbUBj7ZeuSM3I+4j06Z8lWV48U=;
 b=d7dvqFnPLdoOxQKTuf3r1kSLl2uIHL+7W3xzsXLN7hX7idAcyRkME9+VAtZadzIesoSTQehqF3oJBeQxk9E2GnXcRH38DZ9+GVH7/ZFgZFyYdbr/+CI/nsv1YmnbSTQatddWWkfQ6V2WfhhBxN8xzH90gPk3n7Nwfdo8guzW7MgjqAs1hOFRy5Y8tbhg8BaQvZ78H1rtG7KT4jDthOxye9WmPwEVvT6yf1npul/skPicBSrJo6/JMEXTQaoJvDuJIkG6rop84IrKlRi3GR1y+kX9OPZFJPq3oPagqDqvlFQGWA0+AR3AxyemGzJ++PuuB1oH48TxG6fqnT6s3jQ7SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:07:35 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:07:34 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 3/5] net: dpaa2-mac: export standard statistics
Date: Wed, 25 Feb 2026 17:06:46 +0200
Message-Id: <20260225150648.1542206-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::12) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: baac6574-a937-40fb-4198-08de747f9b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	oPTlreEghfp3GApmQeDzC3Kb16SI4J7qKI+SGVKuhf7ecbMJg5WJI7KOEMYF0JKV2OxJFhI5XG0PudDdZ+YIH2PI3uKIDQGq8h7Dlo+PeR12DnXj46Obyd//trlRwm1k6KjXaEkeTq/3EsUIC8k2cKvtrY06dU9SUtYiZxn9z4G361OkjQPpBFMvBAu+gFXKzYFWVmJh3rKyfuFw0ota0dyTgp8ieJ6qY4v9zXzxpM9EKjNiJUJ6LPuWc5Y1/6KbzDSgZ+VH2thoGpynp26G0rNKKU5/ifznJDgSY8Eu7ysBOceTiqMqfqjn2A9TgX6oyVwJzHlpzBjVxXNHs3INuaTV6KzzATNW2i0vaRxic0GRt9tzsEd3MA2t+3QTZq/G1KQDGFU9bx9p9qvTrERuaGAuZTFBc410dzXWbZYm9isXUNxXbLgMAG3eJzsY0BiAcgpDl+ptXpL78mlmTY+zme3UgLcdjQl9xH9/rjFuvkABnboNadnNQ6gDbbo3uXKA+aRETGTC2KsQTDdLS1ixLrjBslqDWOzZ4/FoMh8XmePWHsKCBObkDBm/8WEMhTQdv45QtGhAa5t1diAIgV9M+q+vkliZilw1FYZqEttL0Z8Pw9zhnfG8GDQ8ozgRmZK4jiChychZQJom6EcpR1bbK+9xeED+baRJ024qfvTboCdJbU2hHympzgtG70QnK0oGDsOgyE44NgQXPL+0WuCYgX/UHMs2MWorvxrA1POk3Ss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bL151ZEfxe7rEm5MbQuCjOp9M4lhO7uzB00rm5gsO0hQtJXBaz9zMzs74MQw?=
 =?us-ascii?Q?QSWZQjvSxwMMbO7u5bixPyM5bxg+CeNpCf1RQq3cJzEHHz+0egyNjZHY44OW?=
 =?us-ascii?Q?ARTaA8eTL3iav+NTDN9zczKpqerGGZNf8xgHRFKnBclVHGNGOPihtJHqtmMr?=
 =?us-ascii?Q?iZxdXGbbTgo3rFN5vcgtSZ0PCe0S7nc3f8bjTD2hYCkMkNBHSTYx6iWicU7g?=
 =?us-ascii?Q?CNxLiBEjjw+mbByn02/ClLWF7jJfChF4JGyHW6N07NCGxSWVgQNF4hB0OX1n?=
 =?us-ascii?Q?8a852vfkQc19mH11bK6Yo+FxE6lsuAbxp3G47AFAvR8BNh0OTRslUqjG9i4U?=
 =?us-ascii?Q?vwbMzLrI5cjbcv4a0XZ3b9Xtcw47AN1orGD68uqm5Z5RBwEluCc0WIQJK24v?=
 =?us-ascii?Q?F7gYzIcHgFRabPZUq22enaSLSe/Kjcd0FzLrpJuvdq+KE8Gw3kvV0kCNeHKk?=
 =?us-ascii?Q?Zx5WiOE/OaX9T3HtgaSREDmVa4+WqK/ztsIX/MCr5r3m7JKrBevHnUC01FFd?=
 =?us-ascii?Q?+H8laSac8WoPfxO2er4ALP2ccg5AHHPYfImnhR1OM+XxWDDrH9Rq+F82RaeW?=
 =?us-ascii?Q?MvogCGERp+UkXL/6OxjUDg0GdRYhPcaAtiFEkPulpcyAIDXVLR0jt9rAYXv8?=
 =?us-ascii?Q?5wUCX43NAkZXU1e00Z5weUx2YsC1imx58cocNZZpKoMv6qbeIEZk2uPUuXW+?=
 =?us-ascii?Q?xFidr6p2rM5W1wWDJKo2eCC8V0POhyQBvrqEkAyr1u3p73IOjnuiZhP0lrEJ?=
 =?us-ascii?Q?7/PPpzcKa9RbNARE4YcfQFmoe0xBpffiXqgP1La697jPgeFHdFxM+BTBgQOd?=
 =?us-ascii?Q?/d1t4WVKDK3rjHY4nOqCHiE5LDZFZQyDivT13SK6bUVDC/N3J/JQi82Jq5sP?=
 =?us-ascii?Q?lDnYu4Ly08MBV7c1wGhBA4tFof45PrxX8RWmJspBzg8QHETkt5PrMMGwvaqs?=
 =?us-ascii?Q?5uZFmB2lYptwiGtn/WqhtLzjs/aIfBzvEuMSmgi2qJhbeQPqWaLz4B8+xxg/?=
 =?us-ascii?Q?d+8Dt2zPb8yOyv0ezszuozwZgKL6sg2To8E3et3jYZAPJ4QByIFWTPERqUti?=
 =?us-ascii?Q?oZl57sEyQkpNlUu1BS19VmlKCllgS8SRoqaGUMf7DhF4W9m8mg+v+OepIsrC?=
 =?us-ascii?Q?fGuZ9BFAeWFbRmfAQyr/JoFpCSHybvUGKETXa4SsWaowH9iAetFOb1hpbsIY?=
 =?us-ascii?Q?i5WN2yhBnuJCHyTKhRP2cPuonGv73dPgsQ8bpKq9qRgy8SH5/vuO9XX5lLJK?=
 =?us-ascii?Q?0MHw94CQNIMmi8vvi5B10QWojEMBpKBP0qX8K3xZ8pUa9s+adY+RNj1Ga7/p?=
 =?us-ascii?Q?SZuXqPF7nqlPSryOwdUVcQVmXGAe/v1Ztc2FHWQXKohYCIN4bl6Rl7EBAyk8?=
 =?us-ascii?Q?bqtOBTzAPCZM8/AfOUJkReNhO3xmdbWoS00hQjXkV0gao3UTcgkqWsVUP0qd?=
 =?us-ascii?Q?P6tsvxwdLAOgmCWl54lqSWy8n8403DISpsCEDJDP8HgpO14g0gFhbrhmCT9X?=
 =?us-ascii?Q?N8KKjfxsCv5XBCAlKtWulBEN+XTazhlRNdP1SqS2qOo0C22hchqwwkyqjQEu?=
 =?us-ascii?Q?ouCA0Gk21n6h+PLtgjyNDr7Jnuo1zlhLADq4pGBodFtsOgyHGjSwKCFdNTSV?=
 =?us-ascii?Q?AoF+PU2ZrVZK5iNNecL2z0ivmh5TDgK/k4STfh3SNljIpz3PWo47KabWQ0WC?=
 =?us-ascii?Q?DD/2LsFBzzR+PbNave3h04iWCfcOJq0vnuJS5DcRP6rFPIEY7MY98DmLX+Fu?=
 =?us-ascii?Q?AfHGAipxoA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baac6574-a937-40fb-4198-08de747f9b28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:07:34.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4tGXcdNvQmKwl7cRuBrxjA+ZGDkWKnXg5Vwya4c6c2rm/GjfXdhxXSNCW68j2NBjIvTkII1ZxINNcRQbszFzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261006-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79DE619934F
X-Rspamd-Action: no action

Take advantage of all the newly added MAC counters available through the
MC API and export them through the standard statistics structures -
rmon, eth-ctrl, eth-mac and pause.

A new version based feature is added into dpaa2-mac -
DPAA2_MAC_FEATURE_STANDARD_STATS - and based on the two memory zones
needed for gathering the MAC counters are setup for each statistics
group.

The dpmac_counter structure is extended with a new field - size_t offset
- which is being used to instruct the dpaa2_mac_transfer_stats()
function where exactly to store a counter value inside the standard
statistics structure.

The newly added support is used both in the dpaa2-eth driver as well as
the dpaa2-switch one.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  59 +++++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 192 ++++++++++++++++++
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  13 ++
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  45 +++-
 4 files changed, 307 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index baab4f1c908d..6f3b15a404fb 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2022 NXP
+ * Copyright 2016-2022, 2024-2026 NXP
  */
 
 #include <linux/net_tstamp.h>
@@ -938,6 +938,59 @@ static void dpaa2_eth_get_channels(struct net_device *net_dev,
 				   channels->other_count;
 }
 
+static void dpaa2_eth_get_rmon_stats(struct net_device *net_dev,
+				     struct ethtool_rmon_stats *rmon_stats,
+				     const struct ethtool_rmon_hist_range **ranges)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_rmon_stats(priv->mac, rmon_stats, ranges);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
+static void dpaa2_eth_get_pause_stats(struct net_device *net_dev,
+				      struct ethtool_pause_stats *pause_stats)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_pause_stats(priv->mac, pause_stats);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
+static void dpaa2_eth_get_ctrl_stats(struct net_device *net_dev,
+				     struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_ctrl_stats(priv->mac, ctrl_stats);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
+static void dpaa2_eth_get_eth_mac_stats(struct net_device *net_dev,
+					struct ethtool_eth_mac_stats *eth_mac_stats)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	mutex_lock(&priv->mac_lock);
+
+	if (dpaa2_eth_has_mac(priv))
+		dpaa2_mac_get_eth_mac_stats(priv->mac, eth_mac_stats);
+
+	mutex_unlock(&priv->mac_lock);
+}
+
 const struct ethtool_ops dpaa2_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
@@ -962,4 +1015,8 @@ const struct ethtool_ops dpaa2_ethtool_ops = {
 	.get_coalesce = dpaa2_eth_get_coalesce,
 	.set_coalesce = dpaa2_eth_set_coalesce,
 	.get_channels = dpaa2_eth_get_channels,
+	.get_rmon_stats = dpaa2_eth_get_rmon_stats,
+	.get_pause_stats = dpaa2_eth_get_pause_stats,
+	.get_eth_ctrl_stats = dpaa2_eth_get_ctrl_stats,
+	.get_eth_mac_stats = dpaa2_eth_get_eth_mac_stats,
 };
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 63dc597dbd7c..abdac6ce7bc4 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -18,20 +18,43 @@
 #define DPMAC_STATS_BUNDLE_VER_MAJOR		4
 #define DPMAC_STATS_BUNDLE_VER_MINOR		10
 
+#define DPMAC_STANDARD_STATS_VER_MAJOR		4
+#define DPMAC_STANDARD_STATS_VER_MINOR		11
+
 #define DPAA2_MAC_FEATURE_PROTOCOL_CHANGE	BIT(0)
 #define DPAA2_MAC_FEATURE_STATS_BUNDLE		BIT(1)
+#define DPAA2_MAC_FEATURE_STANDARD_STATS	BIT(2)
 
 struct dpmac_counter {
 	enum dpmac_counter_id id;
+	size_t offset;
 	const char *name;
 };
 
+#define DPMAC_COUNTER(counter_id, struct_name, struct_offset)	\
+	{							\
+		.id = counter_id,				\
+		.offset = offsetof(struct_name, struct_offset),	\
+	}
+
 #define DPMAC_UNSTRUCTURED_COUNTER(counter_id, counter_name)	\
 	{							\
 		.id = counter_id,				\
 		.name = counter_name,				\
 	}
 
+#define DPMAC_RMON_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_rmon_stats, struct_offset)
+
+#define DPMAC_PAUSE_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_pause_stats, struct_offset)
+
+#define DPMAC_CTRL_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_eth_ctrl_stats, struct_offset)
+
+#define DPMAC_MAC_COUNTER(counter_id, struct_offset)		\
+	DPMAC_COUNTER(counter_id, struct ethtool_eth_mac_stats, struct_offset)
+
 static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
 	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALL_FRAME,  "[mac] rx all frames"),
 	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_GOOD_FRAME,  "[mac] rx frames ok"),
@@ -65,6 +88,60 @@ static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
 
 #define DPAA2_MAC_NUM_ETHTOOL_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
 
+static const struct dpmac_counter dpaa2_mac_rmon_stats[] = {
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_64, hist[0]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_127, hist[1]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_255, hist[2]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_511, hist[3]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1023, hist[4]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1518, hist[5]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAME_1519_MAX, hist[6]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_64, hist_tx[0]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_127, hist_tx[1]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_255, hist_tx[2]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_511, hist_tx[3]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1023, hist_tx[4]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1518, hist_tx[5]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_FRAME_1519_MAX, hist_tx[6]),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_UNDERSIZED, undersize_pkts),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_OVERSIZED, oversize_pkts),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_FRAG, fragments),
+	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_JABBER, jabbers),
+};
+
+#define DPAA2_MAC_NUM_RMON_STATS	ARRAY_SIZE(dpaa2_mac_rmon_stats)
+
+static const struct dpmac_counter dpaa2_mac_pause_stats[] = {
+	DPMAC_PAUSE_COUNTER(DPMAC_CNT_ING_VALID_PAUSE_FRAME, rx_pause_frames),
+	DPMAC_PAUSE_COUNTER(DPMAC_CNT_EGR_VALID_PAUSE_FRAME, tx_pause_frames),
+};
+
+#define DPAA2_MAC_NUM_PAUSE_STATS	ARRAY_SIZE(dpaa2_mac_pause_stats)
+
+static const struct dpmac_counter dpaa2_mac_eth_ctrl_stats[] = {
+	DPMAC_CTRL_COUNTER(DPMAC_CNT_ING_CONTROL_FRAME, MACControlFramesReceived),
+	DPMAC_CTRL_COUNTER(DPMAC_CNT_EGR_CONTROL_FRAME, MACControlFramesTransmitted),
+};
+
+#define DPAA2_MAC_NUM_ETH_CTRL_STATS	ARRAY_SIZE(dpaa2_mac_eth_ctrl_stats)
+
+static const struct dpmac_counter dpaa2_mac_eth_mac_stats[] = {
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_GOOD_FRAME, FramesTransmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_GOOD_FRAME, FramesReceivedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_FCS_ERR, FrameCheckSequenceErrors),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_ALIGN_ERR, AlignmentErrors),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_ALL_BYTE, OctetsTransmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_ERR_FRAME, FramesLostDueToIntMACXmitError),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_ALL_BYTE, OctetsReceivedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC, FramesLostDueToIntMACRcvError),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_MCAST_FRAME, MulticastFramesXmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_EGR_BCAST_FRAME, BroadcastFramesXmittedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_MCAST_FRAME, MulticastFramesReceivedOK),
+	DPMAC_MAC_COUNTER(DPMAC_CNT_ING_BCAST_FRAME, BroadcastFramesReceivedOK),
+};
+
+#define DPAA2_MAC_NUM_ETH_MAC_STATS		ARRAY_SIZE(dpaa2_mac_eth_mac_stats)
+
 static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
 				  size_t num_stats, const struct dpmac_counter *counters)
 {
@@ -150,6 +227,10 @@ static void dpaa2_mac_detect_features(struct dpaa2_mac *mac)
 	if (dpaa2_mac_cmp_ver(mac, DPMAC_STATS_BUNDLE_VER_MAJOR,
 			      DPMAC_STATS_BUNDLE_VER_MINOR) >= 0)
 		mac->features |= DPAA2_MAC_FEATURE_STATS_BUNDLE;
+
+	if (dpaa2_mac_cmp_ver(mac, DPMAC_STANDARD_STATS_VER_MAJOR,
+			      DPMAC_STANDARD_STATS_VER_MINOR) >= 0)
+		mac->features |= DPAA2_MAC_FEATURE_STANDARD_STATS;
 }
 
 static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
@@ -626,6 +707,20 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 		dpaa2_mac_setup_stats(mac, &mac->ethtool_stats,
 				      DPAA2_MAC_NUM_ETHTOOL_STATS, dpaa2_mac_ethtool_stats);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS) {
+		dpaa2_mac_setup_stats(mac, &mac->rmon_stats,
+				      DPAA2_MAC_NUM_RMON_STATS, dpaa2_mac_rmon_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->pause_stats,
+				      DPAA2_MAC_NUM_PAUSE_STATS, dpaa2_mac_pause_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->eth_ctrl_stats,
+				      DPAA2_MAC_NUM_ETH_CTRL_STATS, dpaa2_mac_eth_ctrl_stats);
+
+		dpaa2_mac_setup_stats(mac, &mac->eth_mac_stats,
+				      DPAA2_MAC_NUM_ETH_MAC_STATS, dpaa2_mac_eth_mac_stats);
+	}
+
 	return 0;
 
 err_close_dpmac:
@@ -640,11 +735,108 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
 		dpaa2_mac_clear_stats(mac, &mac->ethtool_stats, DPAA2_MAC_NUM_ETHTOOL_STATS);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS) {
+		dpaa2_mac_clear_stats(mac, &mac->rmon_stats, DPAA2_MAC_NUM_RMON_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->pause_stats, DPAA2_MAC_NUM_PAUSE_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->eth_ctrl_stats, DPAA2_MAC_NUM_ETH_CTRL_STATS);
+		dpaa2_mac_clear_stats(mac, &mac->eth_mac_stats, DPAA2_MAC_NUM_ETH_MAC_STATS);
+	}
+
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
 
+static void dpaa2_mac_transfer_stats(const struct dpmac_counter *counters,
+				     size_t num_counters, void *s,
+				     u64 *cnt_values)
+{
+	for (size_t i = 0; i < num_counters; i++) {
+		u64 *p = s + counters[i].offset;
+
+		*p = le64_to_cpu(cnt_values[i]);
+	}
+}
+
+static const struct ethtool_rmon_hist_range dpaa2_mac_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, DPAA2_ETH_MFL },
+	{},
+};
+
+static void dpaa2_mac_get_standard_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
+					 size_t num_cnt, const struct dpmac_counter *counters,
+					 void *s)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
+	int err;
+
+	if (!(mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS))
+		return;
+
+	if (!stats->idx_dma_mem || !stats->values_dma_mem)
+		return;
+
+	err = dpmac_get_statistics(mac->mc_io, 0, dpmac_dev->mc_handle,
+				   stats->idx_iova, stats->values_iova,
+				   num_cnt);
+	if (err) {
+		netdev_err(mac->net_dev, "%s: dpmac_get_statistics() = %d\n",
+			   __func__, err);
+		return;
+	}
+
+	dma_sync_single_for_cpu(dev, stats->values_iova, num_cnt * sizeof(u64),
+				DMA_FROM_DEVICE);
+
+	dpaa2_mac_transfer_stats(counters, num_cnt, s, stats->values_dma_mem);
+}
+
+void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac, struct ethtool_rmon_stats *s,
+			      const struct ethtool_rmon_hist_range **ranges)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->rmon_stats, DPAA2_MAC_NUM_RMON_STATS,
+				     dpaa2_mac_rmon_stats, s);
+
+	*ranges = dpaa2_mac_rmon_ranges;
+}
+
+void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac, struct ethtool_pause_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->pause_stats, DPAA2_MAC_NUM_PAUSE_STATS,
+				     dpaa2_mac_pause_stats, s);
+}
+
+void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac, struct ethtool_eth_ctrl_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->eth_ctrl_stats, DPAA2_MAC_NUM_ETH_CTRL_STATS,
+				     dpaa2_mac_eth_ctrl_stats, s);
+}
+
+void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac, struct ethtool_eth_mac_stats *s)
+{
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
+	dpaa2_mac_get_standard_stats(mac, &mac->eth_mac_stats, DPAA2_MAC_NUM_ETH_MAC_STATS,
+				     dpaa2_mac_eth_mac_stats, s);
+}
+
 int dpaa2_mac_get_sset_count(void)
 {
 	return DPAA2_MAC_NUM_ETHTOOL_STATS;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
index 386286209606..eeb632b9da0a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
@@ -36,6 +36,10 @@ struct dpaa2_mac {
 	struct phy *serdes_phy;
 
 	struct dpaa2_mac_stats ethtool_stats;
+	struct dpaa2_mac_stats rmon_stats;
+	struct dpaa2_mac_stats pause_stats;
+	struct dpaa2_mac_stats eth_ctrl_stats;
+	struct dpaa2_mac_stats eth_mac_stats;
 };
 
 static inline bool dpaa2_mac_is_type_phy(struct dpaa2_mac *mac)
@@ -61,6 +65,15 @@ void dpaa2_mac_get_strings(u8 **data);
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data);
 
+void dpaa2_mac_get_rmon_stats(struct dpaa2_mac *mac, struct ethtool_rmon_stats *s,
+			      const struct ethtool_rmon_hist_range **ranges);
+
+void dpaa2_mac_get_pause_stats(struct dpaa2_mac *mac, struct ethtool_pause_stats *s);
+
+void dpaa2_mac_get_ctrl_stats(struct dpaa2_mac *mac, struct ethtool_eth_ctrl_stats *s);
+
+void dpaa2_mac_get_eth_mac_stats(struct dpaa2_mac *mac, struct ethtool_eth_mac_stats *s);
+
 void dpaa2_mac_start(struct dpaa2_mac *mac);
 
 void dpaa2_mac_stop(struct dpaa2_mac *mac);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
index a888f6e6e9b0..3203873fae85 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
@@ -3,7 +3,7 @@
  * DPAA2 Ethernet Switch ethtool support
  *
  * Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2018, 2024-2026 NXP
  *
  */
 
@@ -210,6 +210,46 @@ static void dpaa2_switch_ethtool_get_stats(struct net_device *netdev,
 	mutex_unlock(&port_priv->mac_lock);
 }
 
+static void dpaa2_switch_get_rmon_stats(struct net_device *netdev,
+					struct ethtool_rmon_stats *rmon_stats,
+					const struct ethtool_rmon_hist_range **ranges)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+
+	mutex_lock(&port_priv->mac_lock);
+
+	if (dpaa2_switch_port_has_mac(port_priv))
+		dpaa2_mac_get_rmon_stats(port_priv->mac, rmon_stats, ranges);
+
+	mutex_unlock(&port_priv->mac_lock);
+}
+
+static void dpaa2_switch_get_ctrl_stats(struct net_device *net_dev,
+					struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
+
+	mutex_lock(&port_priv->mac_lock);
+
+	if (dpaa2_switch_port_has_mac(port_priv))
+		dpaa2_mac_get_ctrl_stats(port_priv->mac, ctrl_stats);
+
+	mutex_unlock(&port_priv->mac_lock);
+}
+
+static void dpaa2_switch_get_eth_mac_stats(struct net_device *net_dev,
+					   struct ethtool_eth_mac_stats *eth_mac_stats)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
+
+	mutex_lock(&port_priv->mac_lock);
+
+	if (dpaa2_switch_port_has_mac(port_priv))
+		dpaa2_mac_get_eth_mac_stats(port_priv->mac, eth_mac_stats);
+
+	mutex_unlock(&port_priv->mac_lock);
+}
+
 const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
 	.get_drvinfo		= dpaa2_switch_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -218,4 +258,7 @@ const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
 	.get_strings		= dpaa2_switch_ethtool_get_strings,
 	.get_ethtool_stats	= dpaa2_switch_ethtool_get_stats,
 	.get_sset_count		= dpaa2_switch_ethtool_get_sset_count,
+	.get_rmon_stats		= dpaa2_switch_get_rmon_stats,
+	.get_eth_ctrl_stats	= dpaa2_switch_get_ctrl_stats,
+	.get_eth_mac_stats	= dpaa2_switch_get_eth_mac_stats,
 };
-- 
2.25.1


