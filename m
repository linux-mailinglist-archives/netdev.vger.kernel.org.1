Return-Path: <netdev+bounces-268956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDvUKox6ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:12:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B94C2B9AF5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A8930B981C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F33B9616;
	Wed, 18 Mar 2026 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pq08zrfi"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C336829D;
	Wed, 18 Mar 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828621; cv=fail; b=CTKNbDYmogri00QywzxUW9VJhNnp8pBp3JUX85Sur/jY7scFcPlFYAQgg1iNTczCAK9VRXf3Qofy//DazGner1yQzGx0ZNePSR5lm83XPcLhnWxUF93BjKGJvB5ybEGTYWkFvRmvkZwHQL1z844Wdk1gd+JlTmmNXk2KjOBJey0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828621; c=relaxed/simple;
	bh=ObM6FYpkvCh5xIPs6V9h4smPGUo5lnvTbd/y1lKDrzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDKmYw7iV/2QPqUWpCCy3C2J9XcaBPriji25WroCHjc6hqyASSLlTpOdFJEE4aMEMy8oaymB38PF6VdXp23WISfkfPQ2SqlROU/7qkyKa2a3inNCZv+1O/t+o5+h84+NRlAVOYuLX6f9QNbpgV7+eDmyfQEHsIStK+uK6PtQTY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pq08zrfi; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWe5du8G9frneD+/ZB7QqdcgOrUyY7+xE/7ibDmjYcyx302ujYBUcpDZH2o/dBc5smgbUpsuvBj1lQAjus2Nyok3jBzeuML1DVClQ7eftCAgxJd64jqlZA/J5tmH0P/JhU/joY/iNTsxqp3RQQEyjdi9u8i2GgBd85MrNgnQz149HQ4mWOYayLmHhhJq7WSX1pmTonILnxy1gDKtnWK54Gp6JXSnlRnhNhd1zaexBML0h3lDuuYMS4rcC+WjIYEZ9OlFMMoyVAKHg1I+zl3SFikiJQy7wQ8s7j3+Gt8kC9pkgY/uynTeSh3VLKw8jsD7dQnzIlL0Cqm28R/k3HIFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60gGia0xzK/uBn0likaysi7bQbeY06FpTFIetChv/8g=;
 b=HpipRVja2H5QXVqGoJ/m1mhOjPWwXna1PmqLqfo+1ozOpYWniRQZuIQmOu7eRMzXIzMm4/SmEb/ayCM0B6UAIMFtc/wONwNwQSlRnqkKGA9JWWpNx6ZEmExKwAxgMXqRdUaCDV0Jx0PCv0g+9uFHPs5RVZCJhMyfibZqWyvswvVUaKymiVpJhax0a8yn0RceyX6YTd8sr8hctEUrZrR3KxNgicU72s6qc/3saH8SFCn8q0SlYfrmTYTR3Ys94NiV+zKeT/7jxSlB+IzBcLkYq4+a7gANErKSlJ5gU+C9PsrmLMd+PipnwvfxKeSLhmbnCe4aBXwf8RhcbNDVY708RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60gGia0xzK/uBn0likaysi7bQbeY06FpTFIetChv/8g=;
 b=Pq08zrfias+NzkKjOl+gjaxwjIabHEAvUN4+t0HRwk49E7IZLAChuSolgN9eF0aJzXAf2OKn17HyUx2ze6lk68Ebp0MQNnI4C2gGwkJZNA4Zw+sf7eHdU4bNqv4fqZzWpdNHCl+HpOWlAaSOuvorZmTu/zwhUay67e2AwPI4L0ecKqgbf+4cFUFLzFQqU6Dne1sSF6qePavkxO5M9nVxifBrXaWeLElcMk30nuPuKHtgbvJGKJDtmvh3U8AvaBRVBbdwUI7qvk+Roaomf8RZSw+VYBANcFxJ7OA94uFIGtwWM/NGrM9bbQq7LTUcT5UYLgPWsf/vF8IPlRbVBy8Yug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AMBPR04MB11744.eurprd04.prod.outlook.com (2603:10a6:20b:6f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 10:09:43 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:10:11 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/3] net: dpaa2-mac: extend APIs related to statistics
Date: Wed, 18 Mar 2026 12:10:03 +0200
Message-Id: <20260318101005.2088897-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318101005.2088897-1-ioana.ciornei@nxp.com>
References: <20260318101005.2088897-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0032.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::15) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AMBPR04MB11744:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cc89cd-4f3f-4cfe-4a42-08de84d68a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nCOF9ervUKoIRnuG0WVkwVkMPjCEl+fw4IA1YKRSb1rpyzCuHogbSMuB6TQRNHuxxX76sCaGXx9oeuYdn9EPZ0SvQzAWNjc9r+hYzHeKn8d07e2OxMOb0fDYWsfEcsF1xZngyEPR8g3BY1yEqVdUO756qGU+i0JfVKJtxfWS5DL8xANErnOUdtlNx0lCu5znc3pMqlHI/Ks342kMDRph0cnHk35vIW0g/sgUozvfw61KaFiqzjwvPaanS2eLCeEglKZNvZxSQzIa1iTbtWCYnDm/YpVK4hHwm98qLExGEAWw1N6Ef0TygwD8l2+Ci7h2Ds9g3lkpDbmSBihxswexflYPQZtMtka7tMrYBNBBmvcDenERB7zxQMczlNJ6P4+PmzTiY8zErsX6hpSiWmc4ZNZGUji8av7bBNHCGGatTxCzsj329MBsol2EdKKwRvTW4BTLcLIaopcOym7hlhcslUOcRE8hTTTlSX+oPHxdji0i4YYux+xe0y9BwniZ1UMP3v0icPpRh9LdN+jGp39aCvYgHnezKke8ziskeNy91s/AOUVBmgjUdmMvsbwyOZO5FTEO9L50SM0htT6GQfig3svcsqvDSqsWElbfMPltiXNuLXKn/b4THn6TvfuVz7e4E/ocTwHu51nn8S8X5H4Po/SkKopatsRcWNzpVLMdbBy3+QAypC1AWypR/rkGLttoPFmgTEWhOeCWLUGBbsFpgtHo8p5swHLD6ua8FZtZjUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7V1d48PZSDQd2+4JuOvYfNLQ1ARqVO5x4agVjZJ1vRD9PKV0GyMLkeWi73p4?=
 =?us-ascii?Q?UZ8EBBeprYa73up+rKpqN0LRkZ30dr0b6cjM3R9OLqfbR/LmW93JYOT3yuDB?=
 =?us-ascii?Q?sQSmfv0+6aseImj7cT2VWcYcfxw0WaJh0xeX/bOuUJE4tpYcDR78DFmG0dQ7?=
 =?us-ascii?Q?aNfF/zEEI8XgWaOiPUfcYuwghgKLEaySBG+8O/9BcQeftmhB/ba+3At8JN7D?=
 =?us-ascii?Q?DYEQaDgEpPpJCxy8RGeevUbqNi0kDld/0ldAouB69IFXSeghAQk71ETytCDg?=
 =?us-ascii?Q?0IW/3cA1txngH0JJ0sWdmizFY19lPTXQCMB01iln6ZYsOyjWjZr9p+x/QtrR?=
 =?us-ascii?Q?sx3Bj9OE9R2YVKdzmJzCpVdYjq7hA1jppnUFuVsBAfJ+o7GHc+t39tRHqV4d?=
 =?us-ascii?Q?jh1HViccy4XN/veD5U6/pHySNHhqcROdD9RtfxLI0xzmS+PYEdsaouGXmA5I?=
 =?us-ascii?Q?Bloj6smW9kl4Skm3oluenBDFlTGdX8Ph1MvKBY2VPHjm/N5stS3IHFpW8LcH?=
 =?us-ascii?Q?lQxnnjHRA4CO3L9fvQEXTyHjOuPZK4t0JXfXzh85AimFdkVkpySITSRND7+P?=
 =?us-ascii?Q?i09bvd3vWF0wSweGXXc09VoOkWZSDUkNEzD6UBLe4cu1Inz2hIhGB7sEnD43?=
 =?us-ascii?Q?nnIYJdrqu69uy5wZkM+HBlkLKAHWIYEbAUykTzA7cScrlPSCCja15C+veYrr?=
 =?us-ascii?Q?YM5xdULvj9EoB8FVP9KDDMzIRUNyHtWYPbQBs5MGImwV0uaC1k4N3z0SwarA?=
 =?us-ascii?Q?4DfOXwVw79SLH+J4hNUPiJv8uXo2LzwL0JnbKMP2QWTrtXGaBYnysqyHfWEG?=
 =?us-ascii?Q?6xNlOErFO4XAlHnosKUQn6CxsLqURv8flqQqiuru1mndi/3H0XRWbjDev1IT?=
 =?us-ascii?Q?Sqd56roeu5UMq+3/FKSabF+zJD1rKW1Gq/tQPgaWEPNY2aKwLoLjgI7gn5wz?=
 =?us-ascii?Q?dMMUQtNc7HihwWnTdgEYQWDTYoIa1yrU/G0JzCMAgoNqQDHe54Yojgp7JJ2A?=
 =?us-ascii?Q?On2WSZBRWWLz2NKx04d02Urd58MVR6jq/ETVW81APNaQhKTfbOYKUPUQ+VT2?=
 =?us-ascii?Q?RlqOrGHu6jmbGrVWetvi+Ko9heOOHciOeXt6tEENriai1Nvj9uZ46nsfeEbT?=
 =?us-ascii?Q?MQsa3lp8UPwhxPdOFnto2Tvr+yM9KgCNvEqXPFFleOZ+6MZTLaREdrxUkXJ4?=
 =?us-ascii?Q?nKQNGLge+NhkLYicXA8cXv8pINwruRlUxhwkvUp1wUOFikl68vlgu3WZr0wz?=
 =?us-ascii?Q?hOUVxfYXr8GI+IhgEIfLUww9Pt5qwX5vOU+S7V9DqG76kVZW/kMUP2n0uKl5?=
 =?us-ascii?Q?pT3bPFBEnbEy21HQ8sT56NB61vtN++64obY6QjzTCxXut/V3AApy5uitCJsy?=
 =?us-ascii?Q?SWx/HJ+HJUBqBtz8GoGsfCb+oYQjaaa1w/KhZhwLxQRq74NZ9RAoeDGRg8eA?=
 =?us-ascii?Q?wyghTkqdvze9TGoK4CvKh/FuGQqNtrF4ywCheQ5mK7Ri4hiZKYXx91eZt4t/?=
 =?us-ascii?Q?aVgOYH9EcSOdGF6hU7cbCJHVGSfYBuRxXC2fJ26PdDaCt14RRL6dsDvkwyXF?=
 =?us-ascii?Q?nvI15PZbdvUBaGBeEuUB+ztvxfEK2vNVuqRur8y0rk8Aj4HCzb2K3TlCxO2M?=
 =?us-ascii?Q?yBV8ClclmQnE75WfxPGEQtO4zLrQ+YlbWSwYbLU9ZBqRacaagE9ISaQKcgk9?=
 =?us-ascii?Q?PoVMmTjB97CPPpLQ8PRi2ngtaVS+THWs2PMtM1mOIbyIY84bVHkLN7M45PIw?=
 =?us-ascii?Q?+wfYEj2gKA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cc89cd-4f3f-4cfe-4a42-08de84d68a4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:10:11.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6Af45ZkThCEKMrgyLN4mw0J9q8D9AYdku0wr5qiYSs0BwqHfQBs/M9aPMVNSqpkXNLujY1FrLsmwOIQIQ3Thg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11744
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268956-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 3B94C2B9AF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend the dpmac_counter_id enum with the newly added counters which can
be interrogated through the MC firmware. Also add the
dpmac_get_statistics() API which can be used to retrieve multiple MAC
counters through a single firmware command.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- limit the documentation entries to 80 chars
Changes in v2:
- none

 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  | 11 ++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  | 31 +++++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  | 94 ++++++++++++++++++-
 3 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
index e9ac2ecef3be..a864a99a0f75 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef _FSL_DPMAC_CMD_H
 #define _FSL_DPMAC_CMD_H
@@ -28,6 +28,8 @@
 
 #define DPMAC_CMDID_SET_PROTOCOL	DPMAC_CMD(0x0c7)
 
+#define DPMAC_CMDID_GET_STATISTICS	DPMAC_CMD(0x0c8)
+
 /* Macros for accessing command fields smaller than 1byte */
 #define DPMAC_MASK(field)        \
 	GENMASK(DPMAC_##field##_SHIFT + DPMAC_##field##_SIZE - 1, \
@@ -82,4 +84,11 @@ struct dpmac_rsp_get_api_version {
 struct dpmac_cmd_set_protocol {
 	u8 eth_if;
 };
+
+struct dpmac_cmd_get_statistics {
+	__le64 iova_cnt;
+	__le64 iova_values;
+	__le32 num_cnt;
+};
+
 #endif /* _FSL_DPMAC_CMD_H */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.c b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
index f440a4c3b70c..efb9864d051f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #include <linux/fsl/mc.h>
 #include "dpmac.h"
@@ -235,3 +235,32 @@ int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+/**
+ * dpmac_get_statistics() - Get MAC statistics
+ * @mc_io:       Pointer to opaque I/O object
+ * @cmd_flags:   Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:       Token of DPMAC object
+ * @iova_cnt:    IOVA containing the requested MAC counters formatted as an
+ *               array of __le32 representing the dpmac_counter_id.
+ * @iova_values: IOVA containing the values for all the requested counters
+ *               formatted as an array of __le64.
+ * @num_cnt:     Number of counters requested
+ *
+ * Return:       '0' on Success; Error code otherwise.
+ */
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt)
+{
+	struct dpmac_cmd_get_statistics *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPMAC_CMDID_GET_STATISTICS,
+					  cmd_flags, token);
+	cmd_params = (struct dpmac_cmd_get_statistics *)cmd.params;
+	cmd_params->iova_cnt = cpu_to_le64(iova_cnt);
+	cmd_params->iova_values = cpu_to_le64(iova_values);
+	cmd_params->num_cnt = cpu_to_le32(num_cnt);
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.h b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
index 17488819ef68..b5276168b869 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef __FSL_DPMAC_H
 #define __FSL_DPMAC_H
@@ -170,6 +170,58 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
  *			      pause frames.
  * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
  *			      pause frames.
+ * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or
+ *			     bad.
+ * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good
+ *			     or bad.
+ * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good
+ *			     or bad.
+ * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good
+ *			      or bad.
+ * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames,
+ *			      good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
+ *				  larger (up to max frame length specified),
+ *				  good or bad.
+ * @DPMAC_CNT_ING_ALL_BYTE: counts bytes received in both good and bad packets
+ * @DPMAC_CNT_ING_FCS_ERR: counts frames received with a CRC-32 error but the
+ *			   frame is otherwise of correct length
+ * @DPMAC_CNT_ING_VLAN_FRAME: counts the received VLAN tagged frames which are
+ *			      valid.
+ * @DPMAC_CNT_ING_UNDERSIZED: counts received frames which were less than 64
+ *			      bytes long and with a good CRC.
+ * @DPMAC_CNT_ING_CONTROL_FRAME: counts received control frames (type 0x8808)
+ *				 but not pause frames.
+ * @DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC: counts the fully dropped frames (not
+ *					   truncated) due to internal errors of
+ *					   the MAC client. Occurs when a
+ *					   receive FIFO overflows.
+ * @DPMAC_CNT_EGR_ALL_BYTE: counts transmitted bytes in both good and bad
+ *			    packets.
+ * @DPMAC_CNT_EGR_FCS_ERR: counts trasmitted frames with a CRC-32 error except
+ *			   for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ *			      are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all trasmitted frames, good or bad.
+ * @DPMAC_CNT_EGR_CONTROL_FRAME: counts transmitted control frames (type
+ *				 0x8808) but not pause frames.
+ * @DPMAC_CNT_ING_PFC0: number of PFC frames received for class 0.
+ * @DPMAC_CNT_ING_PFC1: number of PFC frames received for class 1.
+ * @DPMAC_CNT_ING_PFC2: number of PFC frames received for class 2.
+ * @DPMAC_CNT_ING_PFC3: number of PFC frames received for class 3.
+ * @DPMAC_CNT_ING_PFC4: number of PFC frames received for class 4.
+ * @DPMAC_CNT_ING_PFC5: number of PFC frames received for class 5.
+ * @DPMAC_CNT_ING_PFC6: number of PFC frames received for class 6.
+ * @DPMAC_CNT_ING_PFC7: number of PFC frames received for class 7.
+ * @DPMAC_CNT_EGR_PFC0: number of PFC frames transmitted for class 0.
+ * @DPMAC_CNT_EGR_PFC1: number of PFC frames transmitted for class 1.
+ * @DPMAC_CNT_EGR_PFC2: number of PFC frames transmitted for class 2.
+ * @DPMAC_CNT_EGR_PFC3: number of PFC frames transmitted for class 3.
+ * @DPMAC_CNT_EGR_PFC4: number of PFC frames transmitted for class 4.
+ * @DPMAC_CNT_EGR_PFC5: number of PFC frames transmitted for class 5.
+ * @DPMAC_CNT_EGR_PFC6: number of PFC frames transmitted for class 6.
+ * @DPMAC_CNT_EGR_PFC7: number of PFC frames transmitted for class 7.
  */
 enum dpmac_counter_id {
 	DPMAC_CNT_ING_FRAME_64,
@@ -199,7 +251,41 @@ enum dpmac_counter_id {
 	DPMAC_CNT_EGR_UCAST_FRAME,
 	DPMAC_CNT_EGR_ERR_FRAME,
 	DPMAC_CNT_ING_GOOD_FRAME,
-	DPMAC_CNT_EGR_GOOD_FRAME
+	DPMAC_CNT_EGR_GOOD_FRAME,
+	DPMAC_CNT_EGR_FRAME_64,
+	DPMAC_CNT_EGR_FRAME_127,
+	DPMAC_CNT_EGR_FRAME_255,
+	DPMAC_CNT_EGR_FRAME_511,
+	DPMAC_CNT_EGR_FRAME_1023,
+	DPMAC_CNT_EGR_FRAME_1518,
+	DPMAC_CNT_EGR_FRAME_1519_MAX,
+	DPMAC_CNT_ING_ALL_BYTE,
+	DPMAC_CNT_ING_FCS_ERR,
+	DPMAC_CNT_ING_VLAN_FRAME,
+	DPMAC_CNT_ING_UNDERSIZED,
+	DPMAC_CNT_ING_CONTROL_FRAME,
+	DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC,
+	DPMAC_CNT_EGR_ALL_BYTE,
+	DPMAC_CNT_EGR_FCS_ERR,
+	DPMAC_CNT_EGR_VLAN_FRAME,
+	DPMAC_CNT_EGR_ALL_FRAME,
+	DPMAC_CNT_EGR_CONTROL_FRAME,
+	DPMAC_CNT_ING_PFC0,
+	DPMAC_CNT_ING_PFC1,
+	DPMAC_CNT_ING_PFC2,
+	DPMAC_CNT_ING_PFC3,
+	DPMAC_CNT_ING_PFC4,
+	DPMAC_CNT_ING_PFC5,
+	DPMAC_CNT_ING_PFC6,
+	DPMAC_CNT_ING_PFC7,
+	DPMAC_CNT_EGR_PFC0,
+	DPMAC_CNT_EGR_PFC1,
+	DPMAC_CNT_EGR_PFC2,
+	DPMAC_CNT_EGR_PFC3,
+	DPMAC_CNT_EGR_PFC4,
+	DPMAC_CNT_EGR_PFC5,
+	DPMAC_CNT_EGR_PFC6,
+	DPMAC_CNT_EGR_PFC7,
 };
 
 int dpmac_get_counter(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
@@ -210,4 +296,8 @@ int dpmac_get_api_version(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		       enum dpmac_eth_if protocol);
+
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt);
+
 #endif /* __FSL_DPMAC_H */
-- 
2.25.1


