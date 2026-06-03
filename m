Return-Path: <netdev+bounces-294787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9teqJ5tAIGoqzQAAu9opvQ
	(envelope-from <netdev+bounces-294787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:56:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC4C638D86
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:56:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=KMXTuiNZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294787-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294787-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AAE8337B1C8
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2CA39734E;
	Wed,  3 Jun 2026 14:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8F3D647C;
	Wed,  3 Jun 2026 14:37:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497428; cv=fail; b=YM8M5y+smzwXGgEl53tzy1fg3J2isBVR0xItZa2InI/sS1ITyI1JpSXp3Bn0qKzjOb2RJVB+GenC064SRZ453wZsHGR7FeDNIeXGDCxzpwcZWgNzXBAb6ZsR2czjploZVj2UVTxVBEDnw8WgVQWTvW5H0irICHlGVn1XJK0LJ8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497428; c=relaxed/simple;
	bh=OnxwrTAnRoy7+/Ln7JGZXcTa9Wm5jpGKiepRC5/jH78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T2C0eJ5H2+BF3nnUDqee74bTLZVae3C23y2ACbCJ+3xx7U/yx0E29X4eL1LXpWaypjC+YTjC+xzKLwoJ8dk+hcSXkbbDsZbxzqJgQmS37Ni/3Zt/htQHkpzcX+K4lMTXhlL+I4gkgdJXi3pQAH6pAF+Z1mx//A9ItJBcwOFfzFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KMXTuiNZ; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUUjX7jurZ4wTfpabGkXPYApS4ns8c7NMwoAjJcFGuEpjSbm9WhWUI7GfY+igfVuwxcdfBvvRaQK46Qrke4IYg3IOCF76ki0fCd0Of7YkEifN7encl+c+1+/As2dQX2EN+7o41su53KbQnpg9r3PPXtNROgnnzf3aGI/nrklkcd2jiMkiUh/bkawV9Dt06ucgKdA28eSgZghKVn6JnAVcknhQhZ5Fu9GJp3b4/xxASgQjPHOlv3KasShoIJR78fW9vcZlwO+HqWti6rZY2Nad18QeJDyOlmwstLjKFUDLVZPpdOap0cfhbQH6TPRl0h/S8zlHi4w9TBfwYcYcRnTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enm/7nSJaBGJiF3CmFc49hUzCqgx8nej0421RAgG8A0=;
 b=FQq+RYsAqtJJIXcMVW/taD29hTiJ1EkabOu7t6DXuUsFVqBD2QDODN/QLD38jbawtlY5ZopuX3lDlZbM4McqtP6Y3QTsGPuML6/q7ObAgACx7KZrAH7yPVLs7UOAWyVi+lvBH+on+SsMxU5bNXKoDNygKTg51hRodSMc6Zi7kTdWjvDrKNrNaE6VsNRvYFpvlpROU2X+bnJ+VflU49bF0uNTnGQtLSGFB5dKC5fznQKtMBDZg55fXbz1oqkgEiWL0Q4Q8WFPQNr1WA5koSWD8q1NVr8hldb57n2hdGZzqnuZ99VRcN60w6txxoLDs+AK52dxr2r0vxqThS1wx2OrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enm/7nSJaBGJiF3CmFc49hUzCqgx8nej0421RAgG8A0=;
 b=KMXTuiNZRo4C0drcpEujt1pqV59QJ1vRfhMQj2dqgZ0JFPlH3utlAHQ5AAj6H7JeCZjpQOYblggmO6jJFBeLC+yZ5wSiszPPVT563KFyYNx3PuxhW9QHr5++VSW7tguGjvTIskJCw8KlUl3mT+sdMtk7tucGrLLvrrJOzhQ6v5/IkATmrTHUAtVkdes7FyKMK5D+K0tfgbb5UL29yo1x/VTYxN7cJy9CqEqJZH/ExC38K+oIEt0VaInIzLQRM1EDZ+C8RmVwadEk0W+xqtBfeYtCr7tQrm2OJ0+kpVHOvs0PsQYeqxCvN+jIZid1nzFhEIeb/ZgUgX2iSKdSDu2Rag==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:37:03 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:37:03 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 10/12] dpaa2-switch: offload port objects on an upper bond device
Date: Wed,  3 Jun 2026 17:36:21 +0300
Message-Id: <20260603143623.3712024-11-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9ed602-0da8-4455-dbce-08dec17d93e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	DcN5AZT8Rai8KaUGKPG1NTu5MCbQKB6G7IqN2QNgmM0rBkYcnni7luUcamIGz/ONg3cfUSAIWIqIgIQ0Nhw8DttE8wKwgubqEZrHdaaOoRymOZU5YSIcKP3kknMURtCzdgkHZS1GFrSkG2olHHrT/ujDjfURx4ZsrN/rg9zbtzepfJtv/RrUsZILmETGSDNydcGecQVljJexfEzhHws6DNgwSndfS9ANH7c23K//bO8sqd41u/3GBLAA/px0N7hm3Ueipd7o1YVLgoGfzGmasTAu36rn7BULlJhs6j+02F6vJEtnf/+6JBCWHIVdSw63cTvXU5PWykerggnX3Ulccl418S/vjIPJ85zzrrfk67QraczPJk0rQYdqmgEPfJoFUSlFme9r+Vb4/SroXo87njmRA0a7wGR7AGLZWxhQ88jQb1AarS7CIoHbSQ4dG9yaS+ZQsaxcaOZgH478gQG2z2M3E0/kN7oWrCqAS3wh6a1CBIVgzFLFZNKmQByhxBrJq6YYaLIEJKVjkak33Uwd0GX6GgfcYh86ZlQpayHxaIjtn0qPMcGq0WZvX47yiiFUrmlYdBYA+tulslvJWR+rfNjJU5rErgtjtm8i0ZdFWr9/joL0Nh9NwLjwO1KWzQ+VzJoPE90IePBsFI/HmuRbm+0PRUX9tkFy8U3mmV0YuiM5+NOzNXJGU2FYaaLo9751
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HlDaqtl6XxQYl9tn+1umxUZYwQjsxFIy6pQ/+Sg5eeobMSUowxAbEtO9MgO6?=
 =?us-ascii?Q?Wv6CY3PQV98fr6h10d3KoIMxNxzJ6Fylvu9D2lYF+a4O6lkeAeFDw5Wc9BCn?=
 =?us-ascii?Q?Vezedf2Nv4lzqfi07LP8wJSHptLbPSFr65092remqNlwQPaSLsEvs5xA9g/c?=
 =?us-ascii?Q?3VsCs4sHP5Uh/hPdyF8psO8CNai5Q+3vHYVyMoR89xDB6h2ErU/GrdHgQjeo?=
 =?us-ascii?Q?sIBBUaQLmYCeV30SWbWL5q7e6T3XymN9Q8JXlhszkazXD1pB29JmEFwOma4g?=
 =?us-ascii?Q?baiG0j3fLjM/SjLq9crdJNapBaVkUTf2JQZSDSUMM7fD/StOPywAeKKRTb5g?=
 =?us-ascii?Q?+NZZQLqSves1/EPLJYextMZp30z8YBkBiB0qNPHiWVqXZXsouifzwA/4gaFM?=
 =?us-ascii?Q?4jiSX+Le+tVI9w3q91ndHJkz5iLXAg0vu3QT3osVYraPDE2p2UoAcT6UE1Ta?=
 =?us-ascii?Q?VUMtVG5FZXX17YyzXpwLdC5hD0iBO6B9jAGqPUyIr/gkElIQA7f6gASZZy7e?=
 =?us-ascii?Q?idq2hHHSsjIO1Y70brhaFYjOo9iTxozzk99dcOf1HD068aAfMmFp1au1dold?=
 =?us-ascii?Q?O0yuWqIAC7APauOmHlL9TsLc4C+O3/qGHtX4jiDUbgYQieWlkIKn30sdxzZH?=
 =?us-ascii?Q?AVplC67iZTS9Eo3myPenmWWiaKR9Y20MPC4b/bzt9tte6v5Z3vcaokiUS5P/?=
 =?us-ascii?Q?N0xto+xGYnzL/ofe0SUQtqaZOSgVMfa4OAcpjcCcCiJn3a24yCGk2T/9qg+z?=
 =?us-ascii?Q?olhAs3G0jEXuVlDVG3XJ7FUYrbuQOkrMb1KSDUUgbfPq+GdhYrdlNs5zQFJ9?=
 =?us-ascii?Q?0/2G0Igjz9gy8dlPghu1pZXEPPgLlnbn3FgNGVoJzQBgVKngIrbbk1IdJTsQ?=
 =?us-ascii?Q?odeicmoj2jjIfYwRAyoY1XvpIkmw+rhp86u92N7t/lzZNW8FjP8a9i5Q+P+F?=
 =?us-ascii?Q?TThn/RMZFZCrd1TW1cz7X0HDuAnv1WUY+3XW9JipThfa/Rr+0rLAesXeqAFc?=
 =?us-ascii?Q?+SRtbdgvhoBUZqzZXaC+SXE+vr4dp8Bnc8NuOrAf1nAOag7YhYJR8QUgaS0g?=
 =?us-ascii?Q?wnabZ9eI9N5IIKjDRqN0sR5pNJF/8hiBbGmY81aD1oGWtZpqMU8hzuR1Qu7W?=
 =?us-ascii?Q?DeF/7FcgGFAR04WtwEEVLDcRDtkwPuod3RnmYDKnP7kwfRCektvwXVBW8OKw?=
 =?us-ascii?Q?IybAnyAVdDzmL3h7Tq/Uh0QAzrnmhSG/Z+KdwOm1I06DAI/jfpdE6mO23Syl?=
 =?us-ascii?Q?qhYdHa9m7oDm+jEgWC9g2uLNp4TaCFQHOZH9QY2FKFJuOTe0J2g/szEZdWGU?=
 =?us-ascii?Q?Tfdc9W6RXLJFWANKYjU1IyMPA5kc10s5p056h4IC4cm8EKBdGFJMWK+fojV8?=
 =?us-ascii?Q?3IrQST9xFrNhlS6eAfUZdnzFmhKjuyzBycu28WQX1eYHNDcxPrmvSHrJgPIf?=
 =?us-ascii?Q?nufqxjuoCyLelfW1erxd/EGebePSMR8z3/Gu4ZH8vnCrQ3o95C+W2NhtnJ0c?=
 =?us-ascii?Q?tWUGuQqx6cxOUBRgsCIvzQjltqYpbjSbzb2JywuWAed39vDrrV0zSD5d9gVN?=
 =?us-ascii?Q?2QIrcS4uq5+0J+9HuBwT6Tf2Q8Q1MFoAx8sTUkFBVAf7oq3qYB4uhkk0d8gO?=
 =?us-ascii?Q?Og9Ts2JAAqLOrLkr2McExi9O51wRD2QKa306y9ZgFT0TPbquydiIWk0hEVVp?=
 =?us-ascii?Q?xbrxBE2c94V1p2a45J+YS9vqGN8+D3r8eexZbYzLL1k7ZKEtpsqEhdqDTa19?=
 =?us-ascii?Q?qUcXof/Jsw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9ed602-0da8-4455-dbce-08dec17d93e8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:37:03.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3i1sLgIcKWi+XhtK16L+AS6ACijZp1GH9IBAjePKuAKcmgJcCUzPpe87HAtMiB2qLBKCu5JHNbxe8RYjKbIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294787-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAC4C638D86

This patch adds support for offloading port objects, VLANs and MDBs,
added on upper bond devices.

First of all, the use of the switchdev_handle_*() replication helpers
is introduced for the SWITCHDEV_PORT_OBJ_ADD/SWITCHDEV_PORT_OBJ_DEL
events. With this change, setting up the 'port_obj_info->handled = true'
is not needed anymore since it's now handled by the new helpers.

In the DPAA2 architecture, there is no difference in adding a FDB or MDB
which points towards a LAG port. Unlike other architectures, we do not
need to populate all the possible destinations which are under the LAG,
we only have to specify a single queueing destination (QDID) which
represents the LAG. This all means that handling of MDBs in bond devices
needs to have refcount mechanism as with the FDBs.
This mechanism is triggered by calling the dpaa2_switch_lag_fdb_add() /
dpaa2_switch_lag_fdb_del() functions which were added in the previous
patch.

Also change how dpaa2_switch_port_mdb_del() behaves in case the
underlying HW operation failed. Since the delete operations cannot be
stopped from a switchdev standpoint, go ahead and ignore the return code
from the dpaa2_switch_*_fdb_del() calls and call dev_mc_del() to at
least keep the SW state consistent.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- Access the port_priv->lag field only through the proper rcu accessors.

Changes in v2:
- In case dev_mc_add() fails, remove the MDB address from HW with the
proper function, dpaa2_switch_lag_fdb_del() or
dpaa2_switch_port_fdb_del(), depending on the LAG offload state.
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 74 +++++++++++--------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index fadebf6a758d..9aba5f348abc 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2096,30 +2096,46 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 				     const struct switchdev_obj_port_mdb *mdb)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_lag *lag;
 	int err;
 
 	/* Check if address is already set on this port */
 	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -EEXIST;
 
-	err = dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
+	lag = rtnl_dereference(port_priv->lag);
+	if (lag)
+		err = dpaa2_switch_lag_fdb_add(lag, mdb->addr, mdb->vid);
+	else
+		err = dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
 	if (err)
 		return err;
 
 	err = dev_mc_add(netdev, mdb->addr);
 	if (err) {
 		netdev_err(netdev, "dev_mc_add err %d\n", err);
-		dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
+		if (lag)
+			dpaa2_switch_lag_fdb_del(lag, mdb->addr, mdb->vid);
+		else
+			dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 	}
 
 	return err;
 }
 
-static int dpaa2_switch_port_obj_add(struct net_device *netdev,
-				     const struct switchdev_obj *obj)
+static int dpaa2_switch_port_obj_add(struct net_device *netdev, const void *ctx,
+				     const struct switchdev_obj *obj,
+				     struct netlink_ext_ack *extack)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
 
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	if (!dpaa2_switch_port_offloads_bridge_port(port_priv, obj->orig_dev))
+		return -EOPNOTSUPP;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		err = dpaa2_switch_port_vlans_add(netdev,
@@ -2215,14 +2231,17 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 				     const struct switchdev_obj_port_mdb *mdb)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_lag *lag;
 	int err;
 
 	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -ENOENT;
 
-	err = dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
-	if (err)
-		return err;
+	lag = rtnl_dereference(port_priv->lag);
+	if (lag)
+		dpaa2_switch_lag_fdb_del(lag, mdb->addr, mdb->vid);
+	else
+		dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 
 	err = dev_mc_del(netdev, mdb->addr);
 	if (err) {
@@ -2233,11 +2252,18 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 	return err;
 }
 
-static int dpaa2_switch_port_obj_del(struct net_device *netdev,
+static int dpaa2_switch_port_obj_del(struct net_device *netdev, const void *ctx,
 				     const struct switchdev_obj *obj)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err;
 
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	if (!dpaa2_switch_port_offloads_bridge_port(port_priv, obj->orig_dev))
+		return -EOPNOTSUPP;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		err = dpaa2_switch_port_vlans_del(netdev, SWITCHDEV_OBJ_PORT_VLAN(obj));
@@ -3128,37 +3154,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 	}
 }
 
-static int dpaa2_switch_port_obj_event(unsigned long event,
-				       struct net_device *netdev,
-				       struct switchdev_notifier_port_obj_info *port_obj_info)
-{
-	int err = -EOPNOTSUPP;
-
-	if (!dpaa2_switch_port_dev_check(netdev))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case SWITCHDEV_PORT_OBJ_ADD:
-		err = dpaa2_switch_port_obj_add(netdev, port_obj_info->obj);
-		break;
-	case SWITCHDEV_PORT_OBJ_DEL:
-		err = dpaa2_switch_port_obj_del(netdev, port_obj_info->obj);
-		break;
-	}
-
-	port_obj_info->handled = true;
-	return notifier_from_errno(err);
-}
-
 static int dpaa2_switch_port_blocking_event(struct notifier_block *nb,
 					    unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
 
 	switch (event) {
 	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add(dev, ptr,
+						    dpaa2_switch_port_dev_check,
+						    dpaa2_switch_port_obj_add);
+		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_OBJ_DEL:
-		return dpaa2_switch_port_obj_event(event, dev, ptr);
+		err = switchdev_handle_port_obj_del(dev, ptr,
+						    dpaa2_switch_port_dev_check,
+						    dpaa2_switch_port_obj_del);
+		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_ATTR_SET:
 		return dpaa2_switch_port_attr_set_event(dev, ptr);
 	}
-- 
2.25.1


