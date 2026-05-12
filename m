Return-Path: <netdev+bounces-287160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KhVJvwsA2oR1QEAu9opvQ
	(envelope-from <netdev+bounces-287160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:37:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03852521564
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12A213531517
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486C43B1031;
	Tue, 12 May 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oSmTaEFN"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510D3B1021;
	Tue, 12 May 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591795; cv=fail; b=H+Fjh2dKFdt6WPJd6evTSkQ0vX2AQ6Vk5OAu0ArTfM2AO7Bh9uJKVbYdVvovOyVKnjjT67LuDfbjvNjapiC3ev6Ruriral7ShMXh0GYCnCLMObYVdKuu2LiYhR202QOzzvguwQCbvm6TN+8rSqGWArSv76Rw1W0HKTpEfGpo8jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591795; c=relaxed/simple;
	bh=dt/r/j5/0YQisdvPLJJKuhyAmdkJ2POxgXy0a4lO6/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IdCFrma2IW0jadxas2/miFMUbhFDUVz0vy8sRANvpyJsYhsBYwtjXhhK9BNg7AffchBNjgNXB2YnsFh/uPRm0EQjjuUBVKFnhTNaotn/Mah3VU3vJKWzUbbzSkIxNcoQRmJ+krC2NYMP/Oza6bVMDU3QXFU/uP9I0Kz3WpJjZdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oSmTaEFN; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xU0qJ0TzL4acE3ViUqvwRyTN6HvzJkSNLKW8Tkf8JzVdL8kJYboRGVMNfTUpvViIOmB46fB69/uDAFvF/eQigGpLos8xLiY/iyIcKpjW6jgF793OmiRmiACITcUT8MiaUshbwBeHF1sP3TyHIOdXLYmKPoVrDj7n6/TjQm1ARpdYoRpQ7wuLDsyYWbn8TsLTlj/Uoi9yleiMgEJ4+W8vNk0cHJsdwsCtg56tv0uftFb9Y6fwsNV714hhfowffvtl2mB89kCpBwHUrcACdxfOia+jAwYNG2AnmoXSzqSu9/fDEHYMOu2cdpTKZEAqINKT+aNgCwf1rebHK3+WNl8cHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RimPJLzf1dQwKaKcmH91JJnPqUxOX3PoazmmuauukKU=;
 b=iW46BUyAZsC4b6psiyc+p9lv87IbDEF06MdKbIJEhvVZ5ry4LhGoBPMr9xl3F7/qmtZZfiIwOvs4OWWqWCsh7eXuRJuD0zaWu3LD/SWqjUpgRSL0ZJ5+jATFmIQ9evsSbVtZitwXUcGS9l5+vRFCD/Q+q1hiUqmMErZF5R4kJGUKbj2Ts/PkIzKTAvUEA8TdExIPxDOpkhS6mkL/dd6upJl9Zjnbp2MII989BCQLD0/b+D81pFRDJDZCI4N5xJ7uMPL7IhtDrPOyDldo2rMa8YSZFHQBkDxpJ3e4ebI2Rh7a+awjVj4nbYdzlfFoJ4FTUmXIBOITEGbgrvRvX9p2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RimPJLzf1dQwKaKcmH91JJnPqUxOX3PoazmmuauukKU=;
 b=oSmTaEFNvpgNqsbOdm9cJKo3Tnn4BasrSxXQPqDvqUh0iioL4vyVtCGwXVnJZgGcJA+KSv+Z25b70On8K88YlFj2ZQ4nzPClIpUR8xEWZA878wQCBeTLyldMIJ+8NLNmvJ9KJtInLhOlj1ZyQ3gzMrVFLgUtdLAXwAqiUuwadoMI/URS8GUxwej1/RCUQW90aeOOdLJ+XvcDbRO6aA04qm5sSDAJ32n5RRqI2mknTc00STTttVryHsGMe3NBZGqp73PlsPk7GSENAWS4y3aPj5CSCG+X8LBkYyQE2PCc0ePRe9ZSLCGlRyT75VlaXci5QlmEMnXQhanYpf83TR2TpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DU4PR04MB12328.eurprd04.prod.outlook.com
 (2603:10a6:10:629::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 13:16:30 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:30 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 09/13] dpaa2-switch: offload FDBs added on an upper bond device
Date: Tue, 12 May 2026 16:15:50 +0300
Message-Id: <20260512131554.952971-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0051.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::23) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DU4PR04MB12328:EE_
X-MS-Office365-Filtering-Correlation-Id: f07be92c-e35e-413d-1bb4-08deb028ae14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0mUVc7aOHOsjn+dMT0VBHdhlVO8VbhUESHaSc0TLiaoS+FMQlV0/gcDeuXbnuZ0z73iCJLbExf+TK6xAREnS5CpPAZxj6rNOUMc3dNOoKTt6444EA2q1aV77++w3y4QUT/z53ZxTUynRcYXZbc8/+jwiHR7QYU265x9/qakWJaJAPHD05t3ubTqiCygOOIDRPQJ7FlVjYLE9Ml9kbBwxfhsBFIOl6fLQ3qK+NaWNpwZ9TY+j8UKBcjbRUyeEGxo22bE93gwstRpxAdfz7zukloli22vjOX4+LoSXdOxNyJGhW0SpwvLL9viM7cOa7Ov+KhprA8tnluH9P47Br3C6jYuWvAU+mTNOnmmQJEeosJvf305REpdGw28Si2rXvCzA5RnuASVgem3nFZA1Z6EdSuu/8jYf8XbW0NziI2tJFG19xgnongTybFxKoBhOn2fC0rI4aomZ5JFAEjHvelGQ8SXPvnDtVM4Y620dE99XAT2wg6dQfayN/h8ujYM2iRIHqFC4ZiI2tsdHHAqh1wSBDwOuQ+QssEorDFp6unOLj+UgRAKjCj//1x2A46hcHr4PJLFefLNaLOfyB034G2Sm1SlCmVbEyUEKT9V5BdTRg1uUwxkPeLfJzq1kGJt0D3Uw3wxMMzzUvqV5I+2WmD4ae8eDug1wOsqbnhpw7Wmu8mFrYYjLW5qMAjKPJqgkz8VN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fOe5QjsVMvmhbcg63KCX6T408uTmnYtrwFhH//Hcbrk7ekp4XIFi+pyPMqlZ?=
 =?us-ascii?Q?R+nBfZMFxEP1zQD+4cJfM9hmkq1D/PDRyd5vCZw39c9/g9Y/OEEMvTGW/vGt?=
 =?us-ascii?Q?hoqweuNgb3RrrCB3ORaII3h9yHjNj9wSoOGH4iMsaITk4/D1m4k1SuNBSVdd?=
 =?us-ascii?Q?pjDwwFCv1w5qCP0xIVio1dZSbAjAevd3ge9pPIZGl1vUMO6UzSMqJz8s1scd?=
 =?us-ascii?Q?xZHjOu50GGKtwCNw6qEekn32Mm0qqhnf+uc/CtO1lgPTQOlfAF76Gkaw/5yw?=
 =?us-ascii?Q?GGaqYh0pEae+4Re1XU5RN+YCL4GUrIjpYb/G4p9KHt+ezcjqgiu0mDBM6EQ+?=
 =?us-ascii?Q?fAgXJJKEbTulDqzemazC/VJaXy9N2wLUH412hUQg9vhvVJfjpKs/AiCBQfNL?=
 =?us-ascii?Q?HcLuvUTYu09ZppV7thltdYevi8ZEtOKXOQzRIl3hiu1R+rpzMR5Cw7ZR2r9I?=
 =?us-ascii?Q?0x7KAEgvdmoTr0FaKUDTt5mRfEojUWWyc2QktFhHdUqY6emouppwQIFGAL12?=
 =?us-ascii?Q?0QV5o2w1mgcItprj7oBua5+EHNsAZWvXE4HrolPvAyDWX2gyafUnWtqW6qRg?=
 =?us-ascii?Q?b6YBefJJVRqWl/qW5tgY0/e5kqSMFX5caWJPj5FDt8AKE8e+z5TVqIGaIGsy?=
 =?us-ascii?Q?1/sYaNwGzC2/c6t3/0kh8GFSJ82Fuve0KY46jrNIwPeQCYDCcJJ+8a/CSShU?=
 =?us-ascii?Q?P8j/RT5Ub40YLSL4yAVRI6KnPIbNBE0/AIx2ZUFrqRC3ihg4z7EQ5BUYVwnS?=
 =?us-ascii?Q?nmQI2qn8SL1/7VVsmaQWFHf36M40COhmi1+0kexkblhsaL4l3kfvDg9K2ibu?=
 =?us-ascii?Q?rZ3eBuHckn8gB7RZElCY2I1QErdL6Z7vyHSqlRuRFoOqrbsS6fUxzkU62SG3?=
 =?us-ascii?Q?mOyOy+g9Zh0e5CLSaSBisPuxwBPoIajf8EJ3xS0zxze219rB/UGOsDgM/qbS?=
 =?us-ascii?Q?+zortKQ9xZZVeDTiGQAksypksdjCmNg/FOq0UnevCUjN2Y54EQB1iJ98aSU4?=
 =?us-ascii?Q?1I71eXlHesa6m1NGzIuWJK23s+HloOAtP+uGQSXjUchnPhMiXMxkky0swC9G?=
 =?us-ascii?Q?4gr8rQCyjCJjDE3yIzNh9BFmQ0/ADixRS0ik9HXD1A0fcWvxosjNXq4vNb3t?=
 =?us-ascii?Q?LGT+SPy8HBA8yDsW9kCGaZqEmTpPtLjiYrG6cbI3qYwGuTbHOVVdBBHllP2F?=
 =?us-ascii?Q?MO+IzM0Mt+XOtqfEEZsHI4NcnwcTQgmWB43LTMQw0ZyZCZl0kCZRZd2+AjE0?=
 =?us-ascii?Q?JaSV2em2zZ2rn9l7xhv0Cxr3lxp4sQtcrPXsRORUQFrhQu4eez/RifcJVGmc?=
 =?us-ascii?Q?AD8/hHMU0bLWq7lmGlf9FmFhbFT3hb2bAHMGqgqitHbvoiOCGzblRvv0GwvN?=
 =?us-ascii?Q?mwsY7wiHMD+Qi8H7tA3KoJ6Z2N/A70C+GRzGC9u4i0K2537vecoyTJWU1RL/?=
 =?us-ascii?Q?H6HhRAtErzWrIMMjweCZTyAA8/hM5kuPZTBbg5d8by5VMgkCEWZdIeVTDx4m?=
 =?us-ascii?Q?Ms9E6bsjTwLewXYGxWeYMlKOx5BedrdlCxpdko5pxEyDeInecuRrf7AgMHN9?=
 =?us-ascii?Q?gQCkHxsDwpVJswTE7u4QMjsB2YfoNjeP9E4tloce761lxKXQ4j5zsKIBCIMO?=
 =?us-ascii?Q?PZSzgTE2zZC8reemFUCnOVr/XU2j2vYKsEQEYitwH4PE/wpaQEXJChGYNKUk?=
 =?us-ascii?Q?xl3eWeSsFSjgOUDUNhX2DXHmNaj3JWsAes0MdDIvekFGFPXiG97Dt5OQxlq1?=
 =?us-ascii?Q?CtVhoS1V4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07be92c-e35e-413d-1bb4-08deb028ae14
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:30.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qYGNYybdzbnU2d/fPM+HzUn49KaZN7CcUbmj2iHFVejxWOtnjSMteuBXv5R2Podlx8rozAXECyR7mWMJdbJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12328
X-Rspamd-Queue-Id: 03852521564
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-287160-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

This patch adds support for offloading FDB entries added on upper bond
devices.

First of all, the call to switchdev_bridge_port_offload() is updated so
that the notifier blocks needed for FDB events replay are available to
the bridge core.

Using switchdev_handle_*() helpers is also necessary because each FDB
event needs to be fanned out to any DPAA2 switch lower device. This
triggers another change in the return type used by the
dpaa2_switch_port_fdb_event() - from notifier types to regular errno
types.

Handling of the SWITCHDEV_FDB_ADD_TO_DEVICE/SWITCHDEV_FDB_DEL_TO_DEVICE
events is updated so that the newly dpaa2_switch_lag_fdb_add() /
dpaa2_switch_lag_fdb_del() functions are called anytime a port is under
a bond device. This will allow us to manage refcounting on FDB entries
which are added on the upper bond devices.

The DPAA2 switch uses shared-VLAN learning which means that the vid
parameter is not used when adding an FDB entry to HW. The current
behavior when dealing with FDB entries with the same MAC address but
different VLANs is to add the entry to HW every time while removal will
get done on the first 'bridge fdb del' command issued by the user.

The same behavior is kept also for FDBs added on bond devices by keeping
the refcount on the {vid, addr} pair while the HW operation disregards
entirely the vid parameter.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- Update dpaa2_switch_foreign_dev_check() so that we check if between
the switch port and the foreign net_device is an offloaded path. Before
this change we also checked if the foreign_dev was offloaded or not by
the switch port.
- Update the switchdev_bridge_port_unoffload() by passing it the proper
context and the notifier blocks.
- Add dev_hold() and dev_put() calls for orig_dev
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 206 ++++++++++++++++--
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  22 ++
 2 files changed, 208 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index f8aa65463386..46c148a8aec3 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -25,6 +25,9 @@
 
 #define DEFAULT_VLAN_ID			1
 
+static struct notifier_block dpaa2_switch_port_switchdev_nb;
+static struct notifier_block dpaa2_switch_port_switchdev_blocking_nb;
+
 static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
 {
 	return port_priv->fdb->fdb_id;
@@ -62,6 +65,25 @@ dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
+static struct ethsw_port_priv *
+dpaa2_switch_lag_get_primary(struct dpaa2_switch_lag *lag)
+{
+	struct ethsw_core *ethsw = lag->ethsw;
+	struct ethsw_port_priv *port_priv;
+	int i;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		port_priv = ethsw->ports[i];
+		if (!port_priv)
+			continue;
+
+		if (port_priv->lag == lag)
+			return port_priv;
+	}
+
+	return NULL;
+}
+
 static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				      struct net_device *upper_dev,
 				      bool linking)
@@ -573,6 +595,91 @@ static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
 		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
 }
 
+static struct dpaa2_mac_addr *
+dpaa2_switch_mac_addr_find(struct list_head *addr_list,
+			   const unsigned char *addr, u16 vid)
+{
+	struct dpaa2_mac_addr *a;
+
+	list_for_each_entry(a, addr_list, list)
+		if (ether_addr_equal(a->addr, addr) && a->vid == vid)
+			return a;
+
+	return NULL;
+}
+
+static int dpaa2_switch_lag_fdb_add(struct dpaa2_switch_lag *lag,
+				    const unsigned char *addr, u16 vid)
+{
+	struct ethsw_port_priv *port_priv;
+	struct dpaa2_mac_addr *a;
+	int err = 0;
+
+	mutex_lock(&lag->fdb_lock);
+
+	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
+	if (a) {
+		refcount_inc(&a->refcount);
+		goto out;
+	}
+
+	port_priv = dpaa2_switch_lag_get_primary(lag);
+	if (!port_priv) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = dpaa2_switch_port_fdb_add(port_priv, addr);
+	if (err) {
+		kfree(a);
+		goto out;
+	}
+
+	ether_addr_copy(a->addr, addr);
+	a->vid = vid;
+	refcount_set(&a->refcount, 1);
+	list_add_tail(&a->list, &lag->fdbs);
+
+out:
+	mutex_unlock(&lag->fdb_lock);
+
+	return err;
+}
+
+static void dpaa2_switch_lag_fdb_del(struct dpaa2_switch_lag *lag,
+				     const unsigned char *addr, u16 vid)
+{
+	struct ethsw_port_priv *port_priv;
+	struct dpaa2_mac_addr *a;
+
+	mutex_lock(&lag->fdb_lock);
+
+	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
+	if (!a)
+		goto out;
+
+	port_priv = dpaa2_switch_lag_get_primary(lag);
+	if (!port_priv)
+		goto out;
+
+	if (!refcount_dec_and_test(&a->refcount))
+		goto out;
+
+	dpaa2_switch_port_fdb_del(port_priv, addr);
+
+	list_del(&a->list);
+	kfree(a);
+
+out:
+	mutex_unlock(&lag->fdb_lock);
+}
+
 static void dpaa2_switch_port_get_stats(struct net_device *netdev,
 					struct rtnl_link_stats64 *stats)
 {
@@ -1520,6 +1627,32 @@ bool dpaa2_switch_port_dev_check(const struct net_device *netdev)
 	return netdev->netdev_ops == &dpaa2_switch_port_ops;
 }
 
+static bool dpaa2_switch_foreign_dev_check(const struct net_device *dev,
+					   const struct net_device *foreign_dev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port;
+	int i;
+
+	if (netif_is_bridge_master(foreign_dev))
+		if (port_priv->fdb->bridge_dev == foreign_dev)
+			return false;
+
+	if (netif_is_bridge_port(foreign_dev)) {
+		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+			other_port = ethsw->ports[i];
+
+			if (!other_port || !other_port->lag)
+				continue;
+			if (other_port->lag->bond_dev == foreign_dev)
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 {
 	struct fsl_mc_device *dpsw_port_dev, *dpmac_dev;
@@ -2145,8 +2278,10 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 		goto err_egress_flood;
 
 	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
-	err = switchdev_bridge_port_offload(brport_dev, netdev, NULL,
-					    NULL, NULL, false, extack);
+	err = switchdev_bridge_port_offload(brport_dev, netdev, port_priv,
+					    &dpaa2_switch_port_switchdev_nb,
+					    &dpaa2_switch_port_switchdev_blocking_nb,
+					    false, extack);
 	if (err)
 		goto err_switchdev_offload;
 
@@ -2185,7 +2320,9 @@ static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
 
 	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
 
-	switchdev_bridge_port_unoffload(brport_dev, NULL, NULL, NULL);
+	switchdev_bridge_port_unoffload(brport_dev, port_priv,
+					&dpaa2_switch_port_switchdev_nb,
+					&dpaa2_switch_port_switchdev_blocking_nb);
 }
 
 static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
@@ -2785,14 +2922,18 @@ struct ethsw_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
 	struct net_device *dev;
+	struct net_device *orig_dev;
 	unsigned long event;
+	u16 vid;
 };
 
 static void dpaa2_switch_event_work(struct work_struct *work)
 {
 	struct ethsw_switchdev_event_work *switchdev_work =
 		container_of(work, struct ethsw_switchdev_event_work, work);
+	struct net_device *orig_dev = switchdev_work->orig_dev;
 	struct net_device *dev = switchdev_work->dev;
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct switchdev_notifier_fdb_info *fdb_info;
 	int err;
 
@@ -2801,16 +2942,25 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
-						fdb_info->addr);
+		if (port_priv->lag)
+			err = dpaa2_switch_lag_fdb_add(port_priv->lag,
+						       fdb_info->addr,
+						       switchdev_work->vid);
+		else
+			err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
+							fdb_info->addr);
 		if (err)
 			break;
 		fdb_info->offloaded = true;
-		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, dev,
+		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, orig_dev,
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		dpaa2_switch_port_fdb_del(netdev_priv(dev), fdb_info->addr);
+		if (port_priv->lag)
+			dpaa2_switch_lag_fdb_del(port_priv->lag, fdb_info->addr,
+						 switchdev_work->vid);
+		else
+			dpaa2_switch_port_fdb_del(port_priv, fdb_info->addr);
 		break;
 	}
 
@@ -2818,35 +2968,43 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 	kfree(switchdev_work->fdb_info.addr);
 	kfree(switchdev_work);
 	dev_put(dev);
+	dev_put(orig_dev);
 }
 
-static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
-				       unsigned long event, void *ptr)
+static int
+dpaa2_switch_port_fdb_event(struct net_device *dev,
+			    struct net_device *orig_dev,
+			    unsigned long event, const void *ctx,
+			    const struct switchdev_notifier_fdb_info *fdb_info)
 {
-	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct ethsw_switchdev_event_work *switchdev_work;
-	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 
-	if (!dpaa2_switch_port_dev_check(dev))
-		return NOTIFY_DONE;
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	/* For the moment, do nothing with entries towards foreign devices */
+	if (dpaa2_switch_foreign_dev_check(dev, orig_dev))
+		return 0;
 
 	if (!fdb_info->added_by_user || fdb_info->is_local)
-		return NOTIFY_DONE;
+		return 0;
 
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
-		return NOTIFY_BAD;
+		return -ENOMEM;
 
 	INIT_WORK(&switchdev_work->work, dpaa2_switch_event_work);
 	switchdev_work->dev = dev;
 	switchdev_work->event = event;
+	switchdev_work->orig_dev = orig_dev;
+	switchdev_work->vid = fdb_info->vid;
 
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		memcpy(&switchdev_work->fdb_info, ptr,
+		memcpy(&switchdev_work->fdb_info, fdb_info,
 		       sizeof(switchdev_work->fdb_info));
 		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
 		if (!switchdev_work->fdb_info.addr)
@@ -2857,19 +3015,20 @@ static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
 
 		/* Take a reference on the device to avoid being freed. */
 		dev_hold(dev);
+		dev_hold(orig_dev);
 		break;
 	default:
 		kfree(switchdev_work);
-		return NOTIFY_DONE;
+		return 0;
 	}
 
 	queue_work(ethsw->workqueue, &switchdev_work->work);
 
-	return NOTIFY_DONE;
+	return 0;
 
 err_addr_alloc:
 	kfree(switchdev_work);
-	return NOTIFY_BAD;
+	return -ENOMEM;
 }
 
 /* Called under rcu_read_lock() */
@@ -2877,13 +3036,18 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 				   unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
 
 	switch (event) {
 	case SWITCHDEV_PORT_ATTR_SET:
 		return dpaa2_switch_port_attr_set_event(dev, ptr);
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		return dpaa2_switch_port_fdb_event(nb, event, ptr);
+		err = switchdev_handle_fdb_event_to_device(dev, event, ptr,
+							   dpaa2_switch_port_dev_check,
+							   dpaa2_switch_foreign_dev_check,
+							   dpaa2_switch_port_fdb_event);
+		return notifier_from_errno(err);
 	default:
 		return NOTIFY_DONE;
 	}
@@ -3971,6 +4135,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 		ethsw->lags[i].ethsw = ethsw;
 		ethsw->lags[i].id = i + 1;
 		ethsw->lags[i].in_use = 0;
+		mutex_init(&ethsw->lags[i].fdb_lock);
+		INIT_LIST_HEAD(&ethsw->lags[i].fdbs);
 	}
 
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 56debbdefd13..96d780980d77 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -100,6 +100,13 @@ struct dpaa2_switch_fq {
 	u32 fqid;
 };
 
+struct dpaa2_mac_addr {
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	refcount_t refcount;
+	struct list_head list;
+};
+
 struct dpaa2_switch_fdb {
 	struct net_device	*bridge_dev;
 	u16			fdb_id;
@@ -111,6 +118,9 @@ struct dpaa2_switch_lag {
 	struct net_device	*bond_dev;
 	bool			in_use;
 	u8			id;
+	/* Protects the list of fdbs installed on this LAG */
+	struct mutex		fdb_lock;
+	struct list_head	fdbs;
 };
 
 struct dpaa2_switch_acl_entry {
@@ -286,4 +296,16 @@ int dpaa2_switch_block_offload_mirror(struct dpaa2_switch_filter_block *block,
 
 int dpaa2_switch_block_unoffload_mirror(struct dpaa2_switch_filter_block *block,
 					struct ethsw_port_priv *port_priv);
+
+static inline bool
+dpaa2_switch_port_offloads_bridge_port(struct ethsw_port_priv *port_priv,
+				       const struct net_device *dev)
+{
+	if (port_priv->lag && port_priv->lag->bond_dev == dev)
+		return true;
+	if (port_priv->netdev == dev)
+		return true;
+	return false;
+}
+
 #endif	/* __ETHSW_H */
-- 
2.25.1


