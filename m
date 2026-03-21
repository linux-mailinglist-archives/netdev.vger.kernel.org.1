Return-Path: <netdev+bounces-270136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKqsGGzxvWlkEAMAu9opvQ
	(envelope-from <netdev+bounces-270136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:16:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EF42E2C38
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E583306E3D4
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E222C330D2A;
	Sat, 21 Mar 2026 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TJmGlutt"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DF2FDC57;
	Sat, 21 Mar 2026 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774055705; cv=fail; b=DmAXWeBoBIqomT0mS2XqZVT+VUXerd0SlubSnlzhHbQDco+PAH6KSZTDwmepHpFzsRjSWkAgEq2Vo/MpUDmu6yktp/zlIrvpo5YD2vF7W2KQwDgHsiKJM595nQwk4f5vVRRTjrOSAza0u6hPbc9HjoNfxT4+VXLjN9leeOJNI60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774055705; c=relaxed/simple;
	bh=zs7IJt6vq7msTZAJpW7XfGGpUXlYtHlFwHrDa2lHLSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Be54ZhPruGCaUtN8K6pyRHhpLbTTYmDhwYTq+6zsMZ2XQdmGoXgTgySfpF4kdrvj/wt10TPfpvmAVqZrYRQ2+CULxTXwCM86R23bYubfchXMYV0/LIrtjy6POvwkw5HH2jgHahjVTyYQaEWCBKGmzwCxPYarRIVQQwcr/gnnvNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TJmGlutt; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHLA6tiTVZ5PwEO7HCtslyRoEW6QgUQ0wSawYxDEG4SUE/lrUySHy8L4sK5Z050c8NZkenq6Uf+Y1FdCIMQHZxE3VccoW0X4+HJqiHnwtEd/EcsTPT3WHDmofDlAY7OIIsbBTzoQYlH+gunzaGdB0sx01pOLXsuN/XWBwWjhc+w+ZT1cYTHGEAS3s1eWhOg7miBO6mwUgagfaxueBjWM6QXDhNCw5SPuCaj/1gvYqQPvJ/wNN8Uge0hn7CF7Td2sBqT308yPxaFGQTlSYcGmcj6PLXheH0vO44UwxBfeAoHbBc8zJysUOJ1D9NPg6UralikOzEHUrzhYRRwCUlblCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WEBOjZqXZ8eM81pVrF3UdHZ2SQUfG4MvK9dTGCj99M=;
 b=r/eXCTzbhmI0B5e0VaxTRxQNFm7iScU3IDE0BkoJNEYszyh6JUnJazV6LHqKHc8PJTZ/TWai1LDV8J/D/rmBqCEaSsFHVqmBortx1fVrEGlyuuRqlAZ1rAMudY+U6b8Rzw14CZDx3lY4e2LOBdCT4ANkl5zYiDmeOUYn8Q9BXDNtnttdw0OD5tpoxk6cWf9OsmZ6p+5nSzmxrAq5Ny7wTt4w4apHPT0cWWEef7Aovz+oNV75KQDxN8nrZYC7vBQ8Usz/spcid7/9+zfGf7N4VbU0ui1xa4SOXbyBx3X5llkKcrMY9Ewjl5EmVqW5IAhUnP1rilSWznCHviT2rfV+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WEBOjZqXZ8eM81pVrF3UdHZ2SQUfG4MvK9dTGCj99M=;
 b=TJmGluttl0JnKlg5OUkZKrrNoloFHB1R7eDPbgvXr50r4i9SMrsjytNl2XL/K2nByeLB3QRQH/pdiaFpRZ+YAI4xfS1Uel/oajv2/ecX8RzLf1mNLVnP0YMwpTiNitxs7oUMcVgXWDJbTo1ou8VHRgq96gF9Usgg4lNsgkdhU529zH3gEbrCC9fjzHMIpLJh9Nz0iayV8GIaNweQDxTcOKCwJq72kVd1SATDtuCf2+MRz37qBBd+m1O6OGQj/OeKGJUhMtHH3QSnZU5+SYPO8TgS+g24pjIlaq/ZQ4xRo0fHUqkajniWahTyvLUwjyY7evFHwmhFER7bUZC190XOAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VE1PR04MB7360.eurprd04.prod.outlook.com (2603:10a6:800:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Sat, 21 Mar
 2026 01:14:43 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Sat, 21 Mar 2026
 01:14:43 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy-next 3/3] phy: lynx-28g: implement phy_exit() operation
Date: Sat, 21 Mar 2026 03:14:51 +0200
Message-Id: <20260321011451.1557091-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
References: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VE1PR04MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e70b77-16a8-4d12-5de0-08de86e73beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CalXzBhSGOc9P647MWu1nV5CQzRdluA2/WzfM/fem9C4bS0WjQ/3QeXPCJg9PUpDy8AZBrFavkAFyDhbqG2TPRSmSqTlbj7f9vcTS+xIGz/JenRB1zvD87CF07Wg+s0iaNXIYrsV07yEjkbT8eTmNvfSu2KyaObO25cz+Qt3B2X4lUJ02PVF6zmqetXII4udgpsJuF4sLTqudLtomh9kdALyay3+WDIRi3+Ix6KaM67lYYBzalrpFxzX6oZhx0Ga+23r0saVndouFAc0K80GYr1VqhPvoBW/WxqH/UvB3ZJjtdP3kttVgn5sJmGpmpiOMFyVHWS+Yo/HXLux6FWBS5zebZph5fJrQ6c/fJtoVAJb5NoYfAVRl/Rqu4f+OfRCeZH3KFkm1PzoUVOkjP59FjVMx7uK17EPaxPuo5ms3f0pEpTqaxedlQEv4r1L7aMor2Bq0ksyLdCLA14SotX1XBZtGvKsoXru2wfIaMdLY+DDP5kmMO0AM1arG9baRTqo6BJIIVsz6klk0nKfa06IfORlLGKOTNrMTaQ1DoeN0NNpcRfsgLPYoLhxN1feqQuq8O5lX0aTZhW2AgNyTuQFTh+ymVuh+TPV5Pz9oODEXG9CrMLLJk5+jmILFCc0D6tPFxDIv+qv/kn0ksDtYK9aOVYFKu1GfhUgjD+TQStvkpDbEecvOspk6AjnwYyZ2LE0UoIzj7awBRcnvWQrNbppIgx3avFJPkBWHQ/WR46OREGQcBu7E8EHg3RyizoaABZb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4uq1+BPHZvy3YTeGZ5frtsf4+2XHwRzTgyM2m/fMzS1uhFCKMAdefN1mCqMg?=
 =?us-ascii?Q?7+KjLmFgxknxSv/8a1KVcO4kq6tx0IocFTGsJAlmPASX+qq7lm5+Ii+ZdiQx?=
 =?us-ascii?Q?5PIjqU7hSEF7qSJZpYXZ8sFGN92DCzTxILFsGSlG++B4fsChcYTjn6dSpPdG?=
 =?us-ascii?Q?50bu9DGt82diKMmC73c5UqtmLEC0yY0h+yWnqJxScl3JXbwg5FrB8WG/kslw?=
 =?us-ascii?Q?z07lJgJPZD5eWVU0tVLIaYhITMbwjb/jyPxNPXIMFn/Aa4YNSEgElR2s5oZr?=
 =?us-ascii?Q?5D/35IFz6DlJoIxcyPbtzAKfMAEZhqmSLvUmQryW0eBXBDNqwOhDYQhYLwTs?=
 =?us-ascii?Q?H69JRfX+ynItyxnKvJHLCrRjunj9lE/RdaFjMw1TufiaV29htw/LL8cN9vuv?=
 =?us-ascii?Q?MitnhGlyYde5T/QoqinG3cc3x62CjZ5prZH+1oepBZmYNSIMsojOKUzrxbS9?=
 =?us-ascii?Q?3XUQ7fwPl5urjg+1/cyftrrhQvJyUO49LiB10KMw/rwyJ6Qw4SclnVykfmeH?=
 =?us-ascii?Q?oQcy3bJ05laZFC/DBFoKMqgABz8aAOQYCZQ8jE9hoVQLBqVvnJ8glvTu0Dvi?=
 =?us-ascii?Q?DZRJThGtdjmC/VeAdqqCLcN0tRHYyIphizBHWxB5dd+x2mrbV4CVLJkQbBQn?=
 =?us-ascii?Q?TRlzZIKcxrHaS67K9ud+EZyZX1tvGJVuicXSok2wXwn8TllQne8lsWqYuiJg?=
 =?us-ascii?Q?gkhzlYcTbpbOz9+LQ3ygXQzQ0gkxjhaZx7RrI1ah6rhCDaUtwIeasCwQW5xu?=
 =?us-ascii?Q?7OD3qSKJeZxJF9R5b1f4fVuuqcG7NVnYKKlk6wUl95I9qQnD4DYl8qADMLW2?=
 =?us-ascii?Q?gvHgsQEoW/iGiCxViDFWy4MHsEEk+uxWlnnCmIo4XJijDjbPrPomIhPyG5KP?=
 =?us-ascii?Q?+01+cEcJyREaSTlQwdF+OpO8QmJP/JQQOU3LVA3RWp4p7MFkpMO7qI7g7SAs?=
 =?us-ascii?Q?hHaWINTIHIN8cC6DbJjsDrq5CYJsTU6P9Frsz18xhpLlXK8QJH56qmzL5Bqe?=
 =?us-ascii?Q?CTQvthqAbh3orurYsYTkYVNNdwi4KNvG5FWePRRE7hx4O9zb0fMuorpjIz1q?=
 =?us-ascii?Q?oPdc4rDENFbCOVMGEDJVoSN60S0R1pIobCiSDyXbCx2OKrija6aS+oOGCwNA?=
 =?us-ascii?Q?1eZm62brY4SMz2hG739XDxtt1tNmpxM9YB2HZBo5ZmINnDv8jus8Kz5Wt5CB?=
 =?us-ascii?Q?8hov3xNwbxPoBMzUBMXy3pPCQi8pT09FbVxaGfm295J2ajlSZVUkY5JPHywF?=
 =?us-ascii?Q?cD09ebtsDjIORWIBFU9RzoUvSRIdu3v0JJB0O9yRoN5g1KVcWscEYbcG0VHp?=
 =?us-ascii?Q?3Aze8vrF5gNcB51HAW/aXtc/H7vYf8gpLswrhs89+jjiDuXDu30EDL9eHEWQ?=
 =?us-ascii?Q?gjgyZYokrI6z+yPelQP1GgKKnqGzEhw6aWWeYv+oyfowR+r+xCRuIWRK1e9P?=
 =?us-ascii?Q?p293PhoAILi5npKo9IihSJbEoh8902Uk/thh4Hp8r6TX52drfP1ZNP6N/Pgs?=
 =?us-ascii?Q?f5oKnWTFIDL8GtPCBiediYA2wv1innuXQOazZkxzWxqHM7213oxzD0521sL2?=
 =?us-ascii?Q?Brsn8JMlBCqvgwlh9kKHA5PKkVwD2QWHBYRhERAeswylHBBePxS4YS8+wbBR?=
 =?us-ascii?Q?yfSYqGIc1e2RTWpwnLb5S/EWmyR8lZQlqJbQk3WQ9XKT8z+rjYxGUS7/rlJ2?=
 =?us-ascii?Q?sjnfGWeJSX5Iw+fHXbspMa7dTGk3EKUv02m3UD/5ZjM/VG6wzUV2im/qJm8g?=
 =?us-ascii?Q?MKKRRop8EsxvdUyVPu+0sxjfKjT9gCDVFmyTdIz89oC0W8338CGJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e70b77-16a8-4d12-5de0-08de86e73beb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 01:14:43.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHx8/yDfIxoMNaqBBTZEkkH8g2NxaYW0BXgo0ZdhY8RA+Ddb9pkr0UQqo/zVeux5EEbiQgKnvAy371cuD/NuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7360
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270136-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: D2EF42E2C38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Layerscape, some Lynx SerDes consumers go through the PHY framework
(we call these 'managed' for the sake of this discussion; they are some
Ethernet lanes), and some consumers don't go through the PHY framework
(we call these 'unmanaged'; they are some unconverted Ethernet lanes,
plus all SATA and PCIe controllers).

A lane is initially unmanaged, and becomes managed when phy_init() is
called on it. Similarly, it becomes unmanaged again when phy_exit() is
called.

Managed lanes are supposed to have power management through
phy_power_on() and phy_power_off().

The lynx-28g SerDes driver, when it probes, probes on all lanes, but
needs to be careful to keep the unmanaged lanes powered on, because
those might be in use by consumers unaware that they need to call
phy_init() and phy_power_on(). This also applies after phy_exit() is
called - no guarantee is made about how the port may be used
afterwards - may be DPDK, may be something else which is unaware of
the PHY framework.

Given this state table:

 State  | Consumer calls phy_exit()? | Provider implements phy_exit()?
 -------+----------------------------+--------------------------------
 (a)    | no                         | no
 (b)    | no                         | yes
 (c)    | yes                        | no
 (d)    | yes                        | yes

we are currently in state (a). This has the problem that when the
consumer fails to probe with -EPROBE_DEFER or is otherwise unbound,
the phy->init_count remains elevated and the lane never returns to the
unmanaged state (temporarily or not) as it should. Furthermore, the
second and subsequent phy_init() consumer calls are never passed on to
the provider driver.

We solve the above problem by implementing phy_exit() in the consumer,
and that moves us to state (c). But this creates the problem that a
balanced set of phy_init() and phy_exit() calls from the consumer will
effectively result in multiple lynx_28g_init() calls as seen by the
SerDes and nothing else - as the optional phy_ops :: exit() is not
implemented. But that actually doesn't work - the 28G Lynx SerDes can't
power down a lane which is already powered down; that call sequence
would time out and fail.

So actually we want to be in state (d), where both the provider and the
consumer implement phy_exit(). But we can only do that safely through
intermediary state (b), where the provider implements it first. This
effectively behaves just like (a), except it offers a safe migration
path for the consumer to call phy_exit() as mandated by the Generic PHY
API.

Extra development notes: ignoring the lynx_28g_power_on() error in
lynx_28g_exit() is a deliberate decision. The consumer can't deal with a
teardown path that is not error-free. Ignoring the error is not silent:
lynx_28g_power_on() -> lynx_28g_lane_reset() will print on failure.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Previously submitted as part of larger set:
https://lore.kernel.org/linux-phy/20260114152111.625350-9-vladimir.oltean@nxp.com/

Changes:
- Stop propagating lynx_28g_power_on() error code to lynx_28g_exit().
- Add more detailed explanation in commit message
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index b056951506dc..dd54d82a1e1f 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1113,8 +1113,25 @@ static int lynx_28g_init(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_exit(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+
+	/* The lane returns to the state where it isn't managed by the
+	 * consumer, so we must treat is as if it isn't initialized, and
+	 * always powered on.
+	 */
+	lane->init = false;
+	lane->powered_up = false;
+
+	lynx_28g_power_on(phy);
+
+	return 0;
+}
+
 static const struct phy_ops lynx_28g_ops = {
 	.init		= lynx_28g_init,
+	.exit		= lynx_28g_exit,
 	.power_on	= lynx_28g_power_on,
 	.power_off	= lynx_28g_power_off,
 	.set_mode	= lynx_28g_set_mode,
-- 
2.34.1


