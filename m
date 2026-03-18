Return-Path: <netdev+bounces-268955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAaDL716ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:13:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4B2B9B28
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FEA830173BF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4B285CA4;
	Wed, 18 Mar 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YjCWk0a3"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916063A1A3B;
	Wed, 18 Mar 2026 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828617; cv=fail; b=LLoYRL8Dz45mVTdWanvwLyf84HPXoHFxvRQZFulGxjSARlEUiTQZyR7rXGUnylAD8t4lKkYlSVgaAva5Lk5GVtkfcQK9sAVvYShrDKa+u9+2CUQ8C9f/FzkKSYYS24pztN3Op91mwRUk9oJGQ5lhFwVvRgeIVIckD7eZZQ7Mi/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828617; c=relaxed/simple;
	bh=jOUKOqzIgIhhlgA6PUdpQF9lG88DHUNAHAgdhYgLzjo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bq7MwWrrLq1NDadcSREMbu3f3htFIUPYzdFAsssjECUvtmvThkXNeYUXB8xTY0tHQ8rmxxfIXY/Gv44Yx3J4MPIonuWgQ7V8a4gLAVQAoJRkBTiI70bQqUtBai9PICQEOlZ6tayNWFpZ2PGvCzLm9+bUhDpzUxFIt1I5kxIJ1zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YjCWk0a3; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVptH6AQdatUWWZmFPpYgV9as1IIpCobmCSUwUo/WUu172w/A0G6O+Av22Z/E8pB3HtuhHRVVLJNsYrMh3brm8t/HZGFE6eKZ3QLTX00RNa+grW1yzAJmtNm/IPnkI5IKfhjUmZmRoPG3ymWvjsLK1jWRF2C1CJ7BD20qjc/bDPwmgOwjruHBlCG+ySFE553ZDitqWNjejlLKbQaZIY91cXhqNCig0NswfYVxzqlz4FIpQYIf7Zo0wJdbjdXul1dUFp9NHV25o7SFjVysXnkT4MhTEe3guqzGCms5YvXe3EZEGtpo6Ws/IA6yer15VSRPashnJokUW7PPY1/TePpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQdWS/gUl+76JRpeaS7ktxcimXEsfOSAnKcjdqOSmcc=;
 b=QqbW4X8IlMA1DGAVostndbEaVkw67emZ8/8TnRnr/4XrBTw+RGNbEaCc9hjXtvjUU0xjfe3/mQkhI2nFcRSM6na/f/YxkUyzAmRsGchfjf2QGM2pqnoSfmBQxF7hgxFXDVPdMci9oFcAOZa9jFJtI6SkCAHArx6Yt2XK6NHsnupO7X0JDcU7kRSafj4dNuv4jbWgqPcDkmx/B44T2frAfjxzdbciZreOsxPM3RXbaUrzTBdbdReYjy/FLppdQGi7jycPo1Ahb92/Pb9YhXsGhyICG0D8bQNVdY/z6Il4xHn9f/l+vxJH4g+HpNon4ahCqLBYqX/QEtJRd8QD5kztdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQdWS/gUl+76JRpeaS7ktxcimXEsfOSAnKcjdqOSmcc=;
 b=YjCWk0a3NN+YGQFI6oFICiFrfejSZSjQwtX8VjGiQa4TUEyUnCTSYLavflhvtpUOygoLeEDAAj4YJJ1eVhMyBUS2q9VLIYiuq77afs3NszMVdOLCWIuIJg8OyyBBO8iFbttVsyyzmUFJb+BcascZZGPEzRqeG6zdT08EPGJDx2JfWGWExNdQYw/AGdAIOowXREmd7YJl2smSJd6M2VCuEtdRb9987BStGsxyZk3OwzKyzAkQGk0UU02T1e+xtTlIrCqqu8ZT1ChzGl3jVbfGMW+TYHCwiKQMA0A2PRs0XNXthorCnQHrnPGZrrHdPNYCS3ZkglkqI1cIqB72bQWa3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AMBPR04MB11744.eurprd04.prod.outlook.com (2603:10a6:20b:6f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 10:09:41 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:10:09 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: dpaa2-mac: export standard statistics
Date: Wed, 18 Mar 2026 12:10:02 +0200
Message-Id: <20260318101005.2088897-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0051.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::10) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AMBPR04MB11744:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d6a35f-da23-4b68-689b-08de84d688f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jR6MC/2+7tKm26VnH1RgP1uIOwR88m4v2uXP4o40gFIxn2w3iRDPocZlmuckzG82UHMHhhvNNlrPpH72l8BnPKaOqwOvxM2Q/R7GPIvy2B74en33xlrWy08tvV8Q31+Tu44zGHXojSCrdDmd5Rcf7jsU1CaLEzMzpb8uGUNZIQujW0HJOZuBazerv9AM/L6bd9CIRLYjNkdlVy58MGHtu51FyBo2vIugVQlqGjNQIeUhETJIcN6fNRyjkLyOxE57eANSd8lc4fTLlazGLwBlxw7m9+OmBQSB/qZlcKrwFIXElVetxCw2g+IqPA8S7c4foMuCTxiYbHqb9AYlneybyJZ5Vc8niD0Yz0qKdx/S4T8/hzSgvsfWBdrYzetxJRXNxOwTiEeg4+jXQ4Hmqan4CJTc7xTXWezwOJ72ID8YuXQ1sXXK1ln/+ibvs86wf8gw9RVE8neASomXlIdv8nqMR1lcQFnnayQskgv5Oel+olbgTAn8LYE8jOrUXWzFoXakePu1sLbFLsH34adURbop2qIxKILNWau/XNWavEwrZcWysPTKTYb+EyOakd7ay5RzcWJi/VcLMwhLwyvhZ4MtCu7UQvMQFhRLJCx+G0llm/4m7hj0PeWwL9L0iJPrIBhUZaTJc2CowIAnsRFRo6rWGHSEm6qKVCOFWbjX8gOVXHtAP0EXi52Bq7pd+dsj2yLETs1cWNGCIwST1aFQIcALpFIfAqmT1ftu17BUfrhF8qk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tNH0hpJS4JTwsECmQB+Fhmf9MoA65HBTqC1X0PkIB5Pvarcxq7iRotf9afq2?=
 =?us-ascii?Q?GlmN6cwuKVIKkUf1OijI/gAk5VkFXhB6KI+lcdM73bzkH9hdhXVYOh7XzS/u?=
 =?us-ascii?Q?zXL4Ys76qBPYSLUisikqYzMFRQwCBHSTZ2H/yTo1l0StnJfJbjm9493s4Low?=
 =?us-ascii?Q?QoQQ1mc7DzPCJrrOLU9vE8xBtDFrJbp01LNfqToEHMT1CdrosGgzvsesvJKG?=
 =?us-ascii?Q?9rcpUqrXklkiiOvwzVYL9DBp82n3LUwT4jYttBvPV5pwSZ543mVOjtfXaviw?=
 =?us-ascii?Q?Cnu+kVZhQi36vz0NpbfWJKH2urI4F+ElcycATJRR/gp/b5Sepp0+LExPzmPm?=
 =?us-ascii?Q?Kh7fKKph1G6pgPQ8KvcOI6wMRkgjhaAHzTQJSh8lxVWZTr0hE1zc3k9qDC55?=
 =?us-ascii?Q?veQW13Kk2Vd6acg7OrLY0752kIUGBcAN0ea+kTwaauPaKlv8NBmptwmzFZIz?=
 =?us-ascii?Q?hm4LJa15dIPNVqvzyyOjvrR6HnporI6xQbBN+DV8/CYP+sUGVxZOelVb8zVU?=
 =?us-ascii?Q?s7CBy91MOkO01GuxdlTKAY6XH9lv4dFpd7lvpDsZXMkbbVpC/P6hgv4NN0KE?=
 =?us-ascii?Q?YoPRgKLwSJhRAEEIAyvQS0xvz0NEqaW9OcSxPF1qXKx9jeAMLaPmLk5iVceJ?=
 =?us-ascii?Q?6qhWWCPiQU4SOu6cRBKp3kfN35qcyCukPbWcHJk2154EpMksh81Y+oYJA2NN?=
 =?us-ascii?Q?3ZmfJ5rTeEVcjnJD7+sUA7JTS4BqVtdbUOsm5kWwrvoJjv50Dg4YXd2G/OCX?=
 =?us-ascii?Q?TvvshRxadpAl83VIPYz8GERW6z6MqYC5yVK3Hv/vHrlsCqmxoOHqKuPPrEMz?=
 =?us-ascii?Q?gED8jbbi3mi07MUDbrDQGwm7oR7kE3dYkZCFULtX0xl60KgoevFdHBTHqsU6?=
 =?us-ascii?Q?UqZqvfE9PMVYjtNbBuWbbmW1W2tyTkF7/pSRhSDUeaircx9LCGpT0ihd57wZ?=
 =?us-ascii?Q?Vju9DkC20zsY8641zUTbZ3OBLGy/e4Z2jpqoDoDVUxgKMQhiky+H5DK83YHv?=
 =?us-ascii?Q?D0038kbiwtivBPEFW42EMR7n/hZB4OilkwJ4qlqQf/WjcjY7QTWy/6sHDvbP?=
 =?us-ascii?Q?X118HlBRcNjmkH4mZ9qX99kt9FngR9UPdEZ8TP0Wfz3FSc+5QpqUdtEsF2Q/?=
 =?us-ascii?Q?gyH/Z0fMyRLYycJoZHScmVOfqk54tgjABiTBYnyiPZfbs+SdAcyFC3ceikf/?=
 =?us-ascii?Q?sx3ae4D3/stZbLascsPbAMabHLMgesfsiZYLJKwyournMLtEN2Mk+G2WCKJM?=
 =?us-ascii?Q?0DX1J24XI9Ni6yz/K6nCK7a2ubiB9ZiquTkD7S3Ga90w/hHIs3P/KdRGT22q?=
 =?us-ascii?Q?5QTfBWwfxP5O5XwxWbLKgfhpRg9vwG/jVVLQbs9CFFWlf3YCys77IZ3z3aD6?=
 =?us-ascii?Q?5GXjU2o6ECclDW4v+VlUYliM+CnRVpL1K3kPZm0UJ4g/UwloAn92hOG+5aJo?=
 =?us-ascii?Q?GBUvw9+btmbORn0Y/zvj7z/rDQ2szgVP+4+iBucE3d0QjJcojC9ZwDl6n7Ve?=
 =?us-ascii?Q?lqsLmNJUfaeCEgUn8AVbpr9tQsnipB2IlwXMj+kCSRztroi5PXFqZBd87A6M?=
 =?us-ascii?Q?sA3uL+PItO+ffJYKmyz+FuGk8SkYieRKm+K8Vv7A+BOtTf5oXdsAzr1ZNK4e?=
 =?us-ascii?Q?UqYEWElpTLySHzWlhcDAcIB1mKcB3bNDRlgUCb2KZRYHq5UIHv/eoH3Jz96r?=
 =?us-ascii?Q?I63P4rX9lPMFtd4K/C7h/tHnksVYwUIu+UR4JiFb+OMih00X58n5IVjdWJI0?=
 =?us-ascii?Q?axgH4SDlRQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d6a35f-da23-4b68-689b-08de84d688f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:10:09.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewseYc+F2YKMkSuq6+DkolKO/J0U5Q//TzsWhlhMkBQXISMKW2ASeXpQx89L3fRTQAxozwjN3IeSKPlW47r5QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11744
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268955-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78C4B2B9B28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set adds support for standard ethtool statistics - rmon,
eth-ctrl, eth-mac and pause - to dpaa2-mac and its users dpaa2-eth and
dpaa2-switch.

The first patch extends the firmware APIs related to MAC counters and
adds dpmac_get_statistics() which can be used to retrieve multiple counter
values through a single firmware call.

This new API is put in use in the second patch by gathering all
previously exported ethtool statistics through a single MC firmware
call. In this patch we are also adding the setup and cleanup
infrastructure which will be also used for the standard ethtool
counters.

The third patch adds the actual suppord for rmon, eth-ctrl, eth-mac and
pause statistics in dpaa2-mac and its users.

Changes in v3:
- 1/3: limit the documentation entries to 80 chars
- 2/3: use dma_alloc_noncoherent() instead of kcalloc + dma_map_single
- 2/3, 3/3: reduce the number of lines that have more than 80 chars

Changes in v2:
- 2/3: fix fallback usecase by using dpaa2_mac_ethtool_stats[i].id
- 2/3: use the __le32/__le64 types for cnt_idx, cnt_values etc

Ioana Ciornei (3):
  net: dpaa2-mac: extend APIs related to statistics
  net: dpaa2-mac: retrieve MAC statistics in one firmware command
  net: dpaa2-mac: export standard statistics

 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  61 ++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 403 ++++++++++++++++--
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  27 +-
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  48 ++-
 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  |  11 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  |  31 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  |  94 +++-
 7 files changed, 632 insertions(+), 43 deletions(-)

-- 
2.25.1


