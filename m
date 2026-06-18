Return-Path: <netdev+bounces-300374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Thd2K3m6M2osFgYAu9opvQ
	(envelope-from <netdev+bounces-300374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:29:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A569EE02
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:29:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=OuwJrlGf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300374-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300374-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F35F9309366C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670B3C0A0F;
	Thu, 18 Jun 2026 09:28:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712343C4548;
	Thu, 18 Jun 2026 09:28:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774902; cv=fail; b=h5hcP2ZOUPfoahKnDlntEkCG9h1WtVmnandq8mybzV43GUovYEKP9O00N2L1k93BEXyaFTqufF0jIhauadAUNxxZH4AC77Zm2ZOOmMipySqd9tAWmCGLesOulVWhYj/1rykyHUib+J5OecJYGuvq17N/srcBP0aS8HN5iOqRDxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774902; c=relaxed/simple;
	bh=J1syOXcmuqXcF5+C4VbsLFyysvtLqtdFfPypVze54pU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NdFqkDxB0qTDQmKOm5cIeRxlQsSZTg58F0OfyEh24u9ic2V8fYNWkL4nl7SEPbKYr3m/qTbVfR7W/TMHQA/cbbOOn69AxeoXkfwEg9kyXpw70o4jfGEjAf09UzcOj1DTzgmRntHDyewVkSy0fzPhI9PGlUwd3QpmWf4tA+xy1Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OuwJrlGf; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alf2z0S5gVweOt0sLHsn4Gy3YsbNr3Lrlsz1oH98Jg8CR5cJBF7h56m06dEljd5n/TIiNTc5sU317IY0qHrg/wg7IZSP0/s4o7IiYvWLrdgsGtYOfV/6u2m2avKHlS38AIa8fjaiaH0aAHlTijXeZqprdvnT5ySaBYQu3idgUiotnxGf7IyISuzaISMzrlVyLVIdBk1dJd/ZdUBs+MBPBss5a6rEfJ66tZ5hLIjPnZNtLdpecD7qL1eCQ+OCphtOuSAaWi3Qwtby+oyOpgNTjOilGbyrT7CrG/j/lw1mORjMavcVrXhn0nprdq9x9nWQmoflfFajBvR6vlKYq3BU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG9WPchoEMJSZUz4jgbwsNwl4xKAx1XhB6kCRwg8ITg=;
 b=br1xfiQJIX9ly8DiXjZXT0NASq1GCFs4wrK45WoS5UAlE3AJ0KFhKELvaznbSn2+qphETbki/8ZcIw6Zqo/lC24bliD1p5yWNyycWakllJXZvjJs/tTCbcfc0atDPq/zqT02n8VjDazZVlqilGQxsisfgq/MePSFBwVrGf2UdbL4sQqmkLPc9y9nUhibxNpDHP4nDNcG2JaiqlfL0Xlql85hckppAR7YwThmiSMTM2c8OXK2F6ICL+UElxbJp8nClc4POZ11gKSsttPf++0X7fFsl0inkRqsXpibwzUWNoFspRNXr9Q+qUTh6gfx1odw1q4vh9LX3qh/9PL+/Hdi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG9WPchoEMJSZUz4jgbwsNwl4xKAx1XhB6kCRwg8ITg=;
 b=OuwJrlGfs1uWFxgdBCeA3w0CRUSy4M3Ls/77FWppUcKjfwTdRfy19Fkv47WwaB4kHTojWQ4TVISH7zulNsOc2aIR4Q52F5fUqYm7H8hMLWgkJ+v/dLvJYymWhtBFH3gM5UwdFQGmMp+lg5pN/r3qnyg/ZjFKHa5XODVYMcXrloxQZD8/xPQ6os1zxFZvErnZlHy+fdojT8xVkHCtv3rqXzxxlvk15p6J2kPnTQmV4nwiTR4tbeSErMjwhnBgyO49kZ8wD6v5aso7fWbYu1wLrhCXKI1R/OeiyDm70QpKudNMbNYBkmGC+Q8KoBHPQ/JIzEMcnM7gHp2nabRecxY2QA==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AM9PR04MB8163.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 09:28:18 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 09:28:18 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: f.fainelli@gmail.com,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] dpaa2-switch: reject VLAN uppers while bridged
Date: Thu, 18 Jun 2026 12:28:11 +0300
Message-Id: <20260618092813.432535-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AM9PR04MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c51953-074e-479a-a48b-08decd1bee65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/ZJKCiyHw4SCnznZDwEm+L3nZ32N9AFWIxPnhXfHjThGSEJ3klSWVmxddTTnT307v2yagzXNL0kHyDgnzzPDvDYKLaRES5AU8oPTBEEB3xEmW6fQ75nh3d6RDNS0ryjBhA7BeEMPqbTbmsUyCM1WcHG4+YsDNdc4dEI+lm3VXKRmD6FPDD6Qq3QUWJYfU/Mk9c/ZRAuAcJoWsPgqQM4ZnFkI66upALxWL4Kwqk0JuPf02JxrV3jXn4qLH81NgHZkwI2F84BbSPr0sLDcZZtQ3wjvJmRolJDvNsmNR5Pz51gumM5IRDWz7lE/8nLEDn4D6Biv9YleyE2cY/ealapsSxIU5sn/lkfxdj+C7pk2f59795Gwjg4sCP4d0dgPazTlYL7sugIPqNt6DdQR8RgE7M9pVv3oqvzls7rJFLxIvqKmtDht0UqAA+oVQhloGYUmIk+YAqRZgCGd+YLF/2bg+nI1hCyGm3q2gWoTXK99mDY2xhZl0R/Xi83nuarCWWEYrLyo/ulY9k+zGGQWe/3EWMdBtXoDTd/7byEWU2HwF/ItgpJytdHlmCsR37ShAiUC4HHrlYnBeHGwSDLPhLNwxYC6+Y3V8luBS8B7g4BF8gCWw/ecK3gSCAtaaNYROZSP2NXSuEhLSRsfc/FxOIGdBGnjtTFOti4aUBEjeJC/KFVivtIeUcZgIJ7unAiS4DWg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mwsBFR2vJ6W6z0FYVJlwVPwpnAkNZHoCugXZpkg0M8h1GMVnyIZtPd/x7K2v?=
 =?us-ascii?Q?8Luh9+w/HJAgfBh79DkNHzBdKrM70PVYH3oA4P6uBm8E95+yWaufXBjHsxO/?=
 =?us-ascii?Q?ap44FzBFyJlt0XgWCV0xT7jOETlD+wZ0O9inuEzyzQNPjTjfDRmuYgxvnhzU?=
 =?us-ascii?Q?q+2HLV84OYkElna35pJDAqIq13MewzFpX0/Ut4Me4jr9PDq2WYrDj7erhl/B?=
 =?us-ascii?Q?kNOvqvzOYULv6XhIZvA62LJRkW06wJ63mlz6p269rLEuDnsUGZXcxPzq5Cek?=
 =?us-ascii?Q?l0BbsYQikAgXCYdvGmwA5JXvSvhpJST0UeHQd8SuxYYCSUS8Hi+C3fwZlsUY?=
 =?us-ascii?Q?k5Djkn1I/WWGP6YmpB27RHNP7DSJsg+jyMU9WCUMGv4z2Ej4IHgTonk6Y3QU?=
 =?us-ascii?Q?9t3gmbDsDE3AU51QEhbrU9wWXTgOhCU6rhP9RjMgqtaAJ7O8WQSZ3B9oEFMY?=
 =?us-ascii?Q?IstAawOAS3QyodUSUSW87vVBgfqpcO4PI8AKEIv1hn6lQTDySFIUs1E9qdIs?=
 =?us-ascii?Q?9NboZxgZjtpCzWEjAZIInXg01ZR4Rak03E7rDM3bWvvNChYV64gzqICkS/fA?=
 =?us-ascii?Q?LlZhPnAHZYnsMt7X1LU31Dm/ekUmioTlEG9GBf3clqqlU8Nf7XyMi5A7IoBV?=
 =?us-ascii?Q?XK7Zb5vJPvOhR45gEkBBW+IgkUzv9RVAlW+jI9if2nIBbD0eViLZszQf/mnO?=
 =?us-ascii?Q?GYdFpzd3HLKHMMpF/SuCvFy7GGLQpCg2hE8Hf3AAsfutTQJqAG+ROekN95Di?=
 =?us-ascii?Q?JeRJsUafchj4F25a+iJtHDA570ionTJJvx0KpAu/efEXoEVek6bghD0iijXm?=
 =?us-ascii?Q?DBSMFVcxWNYQGyRjdPrHI66PKmUqawM4t4ci9WlL3ghoc+FMTy4k7YM46xen?=
 =?us-ascii?Q?HgJVE3vEhUbB9HolRIBGn3bOFor45FUMqoAowKz/VLOQjO+F/wUISu36Oi3d?=
 =?us-ascii?Q?p/0dUheC+GuRwxX/fZAZiyMM2C66Q2zI0wUBQbEeAyadyKmAmpfwfEzfjzmt?=
 =?us-ascii?Q?v2EddsJDmwOgRQkKCaFl0UOHFRONsczUf4Ne0FCJnrQmygx5q8EZ/eX18rCe?=
 =?us-ascii?Q?8vh1CtXRGmHYExmim8qE2zcYZoOwRWIlaJCRQAoXtGHuOOHN7W3Snz0Vohg5?=
 =?us-ascii?Q?xweZ3Qypcpc8043iB1zaatcyHICTYs2UPO/4hrVRTkf57uqazMoqHs5iAUlk?=
 =?us-ascii?Q?6F/6YNH2CUp9574M/4BnnAkQJknGlIPV5EKglM3If3BGd5j9BROFigaAI4Ok?=
 =?us-ascii?Q?rdBsOUJOd6zD4dCcLp/mJKPkM7d5yIdnwYsvk+XqQ7biNK6U8QWuWQS6eQ9t?=
 =?us-ascii?Q?aK1LGp0ZrhUbX9lVlLMkzPektB9HOYilz5e0eZmTFrKyo+1Yt8nJi5Q13RUW?=
 =?us-ascii?Q?h+yCVramzFOJWgQPQJuu7dsRRdd6IqJBcG6sCr5ME5sdw4rkLysyujW/LyEC?=
 =?us-ascii?Q?4uyHDaCMobhDT7gWdq3X79ekAee3VL0ESaWd8QNWrOfVnSUNoK/3HcPOkshx?=
 =?us-ascii?Q?42Pxyx27NhfAziXDTkjPJ6z3rrh3Xwolvrf0Cw1MKcjQKf9OFsH3eorTJHq8?=
 =?us-ascii?Q?0P9YGcDE0LhYm9FSlYaUC91cxePjmiVNi06qDc+vB3CfpMUeetlop1+T5ENy?=
 =?us-ascii?Q?O1qLU9o9DKZQpQflTVDjhLi3kB+S7wUtLtZAOMtYedycauI3d8iVjlyGvfuA?=
 =?us-ascii?Q?Lv6kKsl9KhCovg3oLdFefIMZKDXzky728GMgc2Jjh9azS+HabGdw/Z3ABPzB?=
 =?us-ascii?Q?RQtVyU4CJg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c51953-074e-479a-a48b-08decd1bee65
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:28:18.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDrPe4vxeDlQ7hqq+wBcPesRpFoQIpTr1mNZoWakhc7sHtW0vE/Y+fN8wTT+uxnTzwujsDRspnRswmSo4ewTow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300374-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 234A569EE02

The dpaa2-switch driver does not support VLAN uppers on its ports while
they are bridged. The check which should have prevented a port with a
VLAN upper to join bridge was poorly refactored and didn't actually
return an error. Patch 2/2 fixes that.

On the other hand, the driver didn't reject the addition of a VLAN upper
while bridged. Patch 1/2 fixes that.

Changes in v2:
- added patch 1/2

Ioana Ciornei (2):
  dpaa2-switch: do not accept VLAN uppers while bridged
  dpaa2-switch: fix VLAN upper check not rejecting bridge join

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1


