Return-Path: <netdev+bounces-284905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJa+Malc+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3C4DD190
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE6E730A2410
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89797495510;
	Wed,  6 May 2026 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JeT+Gyxw"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60949252E;
	Wed,  6 May 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080595; cv=fail; b=tGTFwrRgYobTcwT9zT2TRbcuoDXgPY91cvkzF4tiPE/efi/BbpE5GYNobLbNbNCT9qCJCeVmBaWXmNLkGuKPrJ56UwD7m0viXaeFQHoLxQogB9hdZ/2jN+F0vXuqYG+iMvLkzg6N5U49TJnYH6B8TUflxyhXoWloHPO2a6J7KDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080595; c=relaxed/simple;
	bh=Qg+gbsYnD6aZzXMYxpPQpchG5RVpeV4yYylzVgX1Neo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Plrtsu6JNLuhNwHGp8rOKq5c8S/PzWnB+O+OlNnvgiz7uVWxe4BjbcCtgTHIDGovah8EF3CxgChKfavQPA9pcaBlboAptENkMXnxwc+UsQRDhB8uH3dKzZs6QH+0FoQJlNH1upuZI3/kTDIzblHVP4RHqxwWxKOWvYvyJ4Fg89U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JeT+Gyxw; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCC1S0yYnaHXzIFVmAehTf6c6R4PFzSZsftPaLHafF1LsHGBG8X0bFxmv5ehiThO6LaaQm4R4XeRb+62HmPuik5iGk+mkdkn6Fh4rwZVUZJHenbLVm86RS9bmRnSvqZW9taVZ1b5F9yO/dBAy77QPv60kp+T//cJKO2Si8hHM50l1naNZQ9G8o5LA6YIXr8WerEqLOcLk/gprae3OL7d8AntYRvMRpsdq/P4TVwD1w0j1NJQWO1UtBtyTGkGunfEuiXF/dsQoCKpcdg19ayMUYaRP1iFJgDe4pe0VMb7GBbMMi9mYYQRugshwoskVETqlSGsWRV95KnTBbYFRghaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GOBp1/YUzvc/BNdB9Px68EGP1fBwO1VscH2ajhgdxU=;
 b=Otwtz3/ss0jK6cS4m8XbUti9NUWqARFjmKB9+1WW2udXvKchiOHb1Og08YmqeQRTHzNCqLMm9VgewD6eqMxeMNCv+DBxBRf4DXrYqIO0iWjjzKoccfxzLHpSNsH/8U7JkSk4S4TKj4QyPLSovZWdyvG/cT8PTX1uNSS7PlFYTMZ4PURHeQN5GpYQsBfm1PrOma8nIBgvCsYrHG3580zF545J704WnlWebZptPBjZU1eJusJ0ya1kWzmye8fURwRdcTYmOuTSakyKLuJPKCFG27nqJG+Zatw6FwM1LZSSy6ljYEKEjNob475FKsi9X8NtEyMkLjW/XwwFOwG2yYrpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GOBp1/YUzvc/BNdB9Px68EGP1fBwO1VscH2ajhgdxU=;
 b=JeT+Gyxw1YTYk39LOjgqG7AbAAt15VELK74PDIMdZB0iLDNcqFHVw8V5KN1t91r+QtnZId4KI88RigKN/c/72Nz+naT/KYivC2Ujqpo5mccpotHs9W9PYPvgQPUW63y3EooY6uHNlMnbnfE00hZ3MhBKSc8iG76DEAyJAnZ0muiTo6YKkJqClSFHlGPZtp/LdH1Nz0/D2fHuxZd5622hMnb7+xsGiTmXeWGzmkXnx6QaKmUYDJMQlYMO+51M5Kj7xfbgWv2iHhSgkHxTJgzV+owF8lYHrPASXP73tbl2HJ4Kxfb3gRK/8iQV9gyEoUVeL114bH7j0z6E/Ol3hFtyJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PA1PR04MB10626.eurprd04.prod.outlook.com
 (2603:10a6:102:48e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:16:11 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:11 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 06/13] dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
Date: Wed,  6 May 2026 18:15:33 +0300
Message-Id: <20260506151540.1242997-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::12) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PA1PR04MB10626:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a383084-fd74-4341-d694-08deab8267db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zt1M0k5YA+ZC+PUShYMuLtFTPQio5TWD2txQ/AponGVpxKm91hiuM0KNEkvsUZ001yy0colb/aJBWNnpAQW5YqqKG0WgTsXOLPqIjISwJQkKsBYKiW5N7GIlWbllolkg90e5hk8Bw/z10MgFHi/3w3BxVzKYtgAw5+QDvFXHo7GQ6Z6NkrXksr5OXlrr1YMrizgnszRKQ3Ve1aOkcg5r13MQJZs/eF5YTwiTvepbUfKCY4SmI+BLg0L0tczdqpuq3u8prZxynREzkYjsvnCcsIu6bzFZRRThRJci56ufuWjCT+OUoHrfjKNB43o52B2bedBZC+dIzyZqfmkax5nvjYUbgLtEMr/UhXRlkC2ytMRTjUH4kfvYFYW/xlu6ywgz2yOpB2CtePYzERvXWf5cFnQbBK5aeqc1zH6ooCmKnI98kZsaaxRonjcoeHkYzpkAJMxm/L5R7gSKQKKLf29o/HOofeBrtl4e00jyTo5kyj031aEknmLZ/9gHR5jCWND2yMJegVgXAaxIOlvHxWhqs1j7JqLuzpZ85GRq4dzrfZkPF9hdDTbp1g8Q6gkSy1h24auSNndhkEUtVFBUyup8IxYypSC3V3Yb92WLRZmnnc+ztPXsS100F3UE/ySnrD28vYPiEFUjKfFzrVqeHc47wY8LFbz7+OT9eqUHkHAuXNUg34/J1oCDqpvayRulskWH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O43RCO5Yb4GsJQsqB0NeNyClCDoK2aMxuLSjQGoUozWW8AhbHqF31BivcGO9?=
 =?us-ascii?Q?DZofQGdXiki9ofsK7rJoDrNPhAJR/2mfivtJHKIxIDnsxPwvnbJhBIhc/+7e?=
 =?us-ascii?Q?chlaFGIqcByJP6V/EWB8uoTKAvFpWriqjB4DFqVK6KLPjJSEmXuH72Nt92WX?=
 =?us-ascii?Q?S1DDKlUhwSTj2iCru27d8uzFYSiVfZ6dZ3qsFQvHuIJJXOayTsoqEah5mC/a?=
 =?us-ascii?Q?hxdt87yRf5agcQ6MGQGbU8EzUQoAKj9yzkhaeio16i2UFo0P35szpIySrj3Z?=
 =?us-ascii?Q?0wTSmazKmMrDhc1G1z6s0IUWUHGYMECIQnLkXwi3e1eu5FRUzbBWDEQJSv9X?=
 =?us-ascii?Q?A/LdnMs1Ib3PlH1a6f5lwFRQHtAbeYAmHuNiIweby6l21j4RtSfAp5iEn75U?=
 =?us-ascii?Q?Kkl0YrqEVjwy1q6S8Ki1XJJnHKCg80sTef7SvwdnVNVaxnFdCTr7n6oap9Hn?=
 =?us-ascii?Q?fLRC9zeFpTf1a5AaxPjN8I6LMEGTADR49i4CQdqtPNskZ7cu1tzotcOg3pUJ?=
 =?us-ascii?Q?+MW9CX1hYBzmg3053jfEOYBBAMhP7GeCHxtGq2DKthe+CwCVLaFVbrzdgbK0?=
 =?us-ascii?Q?H/fX5QZFTZBT0fy00Did6sxBWj4Y6qCNwVTCWHc5JVf2s8CgG8dYtUMNjYlS?=
 =?us-ascii?Q?xWbhGx96ExFFwJvpSlo/zBJuhalaT//uq4MAPZ5PxGrH/Y1ZEaJ+95AbOByc?=
 =?us-ascii?Q?qG5F7Mr7mmq0jG7JQc2tuA9LNN6iGIAhUjNEmTcnTWdQAvrJ1ruVPmv3bQBP?=
 =?us-ascii?Q?6E95XjCGquy1yZ//rvUIP1k90gw/ab6oiz/IbLgr7mG/7vE+r+MtVpv/wI2S?=
 =?us-ascii?Q?CGIKyNlpCZeznmq1Vm1mGUE3t5EcLmEif4eiVJK6LEiEhN8mL98a84wgiWCf?=
 =?us-ascii?Q?kMkPgCfB2bVb5MFbhtuaTqDR7tagzIHG8rKirrnEEaYcyGjRGDyDb58anSwL?=
 =?us-ascii?Q?IY3ommWn1ZLzk1o/7oQWCH3tlMo3BUnlFVzspeuyLCXUAjuyR63D+IDohO4E?=
 =?us-ascii?Q?1RfSWRRyuFWNYhVXUqhYMXgQm+e0wThIIYj0Wh4QKEcsklOIG+yQcQ1Ve59G?=
 =?us-ascii?Q?lgOQIXTx9ulPgjkm1fnLMuKh9lNpufP8XvjnDD564wdxaYi0Mx0yTvA2/1hM?=
 =?us-ascii?Q?6LMu1SEjWwphPtE5sgGeVWP4upZWC75RvcBWHh+pwy+m394pvfyK5MUes+2N?=
 =?us-ascii?Q?iMtrBqe+xCvuKsP7MWYRTGE+MW3D3TaopXGyEW6PNdiyeSuA/jbl0x/prrcf?=
 =?us-ascii?Q?sFH9DIShLy1lkX3LJkmXO9lIA43piAflnHgw+n0AyokHb4pTExvJ/HIxqwhX?=
 =?us-ascii?Q?QGq/TRYn0btoxzYupfJX4P0yqDBkIr0zLIpVavzlgmc3Dc8bQTpkr7kcO71Z?=
 =?us-ascii?Q?A+iWQhaeZABrt8kmfB+U5dQXW3npLDTQDFIUXRd5zKyZ3OvMtigSoZP0EImr?=
 =?us-ascii?Q?smRcTpoz393Bbf//jq1sUyh76LloNRIwtxiDnPG4zzKAB815bjIZVbb4RBrn?=
 =?us-ascii?Q?izNLUdft59v0gw5dWRwzEX0S0cPNDNOmWjCIvTwY0qil1ovzOXvJAp5Q/l0W?=
 =?us-ascii?Q?moKIxaO6aF/CNeZYliZDpLRFfkXGhapAzLEpX8JdwXiLjIa5ZWGV2AiDI12/?=
 =?us-ascii?Q?uHw11Sls8MqlNOMzypyQVO1P0BEMI04KOrXTDlmftXoGIV0rR1Tb7tJjvDui?=
 =?us-ascii?Q?fcFeX3TCKawm75ZAQf8eDZZCtNYAQYPXciCmEiHq4lKYwiOZAou9vNny/oe8?=
 =?us-ascii?Q?umHZKo3nZw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a383084-fd74-4341-d694-08deab8267db
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:11.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3/5q8zBzBHbqns74m8S+4O8kNakSA85BlMCWhvd2SakdKxRaZyJ0aQJIBxT4kt1ouhUtegB1n8UzjvE8YCqsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10626
X-Rspamd-Queue-Id: 42D3C4DD190
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284905-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Create a separate dpaa2_switch_port_fdb_event() function that will only
handle the FDB related events. With this change, the
dpaa2_switch_port_event() notifier handler can be written in a way that
it's easier to follow.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index aaa22dc15038..476ee8b46921 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2755,9 +2755,8 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 	dev_put(dev);
 }
 
-/* Called under rcu_read_lock() */
-static int dpaa2_switch_port_event(struct notifier_block *nb,
-				   unsigned long event, void *ptr)
+static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
+				       unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
@@ -2765,9 +2764,6 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 
-	if (event == SWITCHDEV_PORT_ATTR_SET)
-		return dpaa2_switch_port_attr_set_event(dev, ptr);
-
 	if (!dpaa2_switch_port_dev_check(dev))
 		return NOTIFY_DONE;
 
@@ -2808,6 +2804,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 	return NOTIFY_BAD;
 }
 
+/* Called under rcu_read_lock() */
+static int dpaa2_switch_port_event(struct notifier_block *nb,
+				   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		return dpaa2_switch_port_attr_set_event(dev, ptr);
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		return dpaa2_switch_port_fdb_event(nb, event, ptr);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int dpaa2_switch_port_obj_event(unsigned long event,
 				       struct net_device *netdev,
 				       struct switchdev_notifier_port_obj_info *port_obj_info)
-- 
2.25.1


