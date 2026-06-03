Return-Path: <netdev+bounces-294782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lnT+Cr0+IGqkzAAAu9opvQ
	(envelope-from <netdev+bounces-294782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:48:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D3638C44
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:48:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=ntuGanYF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294782-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294782-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 425F430B33ED
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D43CFF71;
	Wed,  3 Jun 2026 14:36:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8B383C65;
	Wed,  3 Jun 2026 14:36:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497414; cv=fail; b=JxMNPLHJUBc3ENYdey6QCiFrOmhgtsnqVvO39xktm8Xc1E7mBZR0QQUX8W59DZv8E/JBKdzoXh8d3zN00v5jRhrmKVz8ZNOnn+YjFvl0ZYMFskdyhFixRKoEHJydSdJmnBwZ5eSnuKzjiTUFzzHvbvX1VzEx1CJIlBKfIDREJBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497414; c=relaxed/simple;
	bh=EFPQJQE3OFfanspLYTMneGAs9BIrjtj7G7h4ARbdF6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MvACwqpCDAa/IdOv1NNxtLVL0gIBzZsMYzdVXVMBS9ONsSmy+iiw3A+LNWnD9Lz+ggRKv6BenxJ78fuWIA38Vf20UIrdr7dsVrgINDfEFnWxVtkOf7xRxOwgYUgZu9OP6gjIfkrtqK52Z9voKqqZA7bNrfQl+mjAWRaMS4RXE6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ntuGanYF; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMqz6NKatjbZzU5RYKuQ7e+w2gbjUjvo8QQNpu7lgZ2/ibLmmuQENhEtWil7nEp1oLgJJEltcgVzDb4ZT7D326L2yUvVj9K6BJMm2NCj8JYQ1Zm/Uo8zjmsZLyg4qHyXzUhZN+qgNvg3UfJIwFLYrDoOnms5gcwCemjOWPw/65rUaRzxHGPdnSacO8EuWhsGITjd90MhBh05C5RlH5h7XA8lvExZq4yRwrveXWfbfJ0tLsW47wx47N13HV2eimSailTXFmLknAd8LiJBC9A3kFWq3REX1t12TjaUsgepQbJLd/sb/8+BxWIhfLuUNhCulTXal+9TdT1RzeDTHHg6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSP9wzlL2H7z6mW78Vy0j9seCc/KGOgtuaPQcGSBnOI=;
 b=CaGhlrnIe0/21fRKUQq6vpd8celm5BJMCIgIWVjdKWELPZjc7GOcHTciTf/ArS8w3++g1aMjol12K5y5z1HmswT6DOzfOHjL3lyWTo4FkcC0qblkydjMZn5EQbo6Vg7/eThlb6vsV3W+yZ7QmIDl0jvHWm4FG7c3fvHh2erMO+QiA2roVKuyVIlH4OMw+WarfPCFw6rDt71YKtP7eC/xKNEVfEdYg5G4lDXC4YbsBxxTiLiszlyzg4Mtzjzy8Lm2M5U55VFccG4fLtO3mGzn8ncTxvLnZcMx3w7h2y2KQ46b324LbU3TIQ7fJjpD0tRrOjJTzs70pRU28ZoLNc1ZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSP9wzlL2H7z6mW78Vy0j9seCc/KGOgtuaPQcGSBnOI=;
 b=ntuGanYFaWbCR50DgrDBRH8oVOFcy4uVWQO+fUYLu5PMMJgHmRJBtznbKa1chqkNgIcihNs9g3YJ/8sHOOzeWrbbLTYlCEkn+fx91WD9ukMB4EuUVdm/wXprmJcbvJlaE3+PXS44zWNUDcbwq87E3mWbpJouZkSao5dIJWUledoJJ+jZCEvWdgPJOUnFJFfvr9hwt04bMdVPx+IhwF31W/NmHknSU4mPfmGfrGnaTUL8t37fJSdAI6S3+Sns2G0Hj5YUt2al7SCZVtiYrAEhtK1+9vYo5VJ+dW9oH+yMArAWuc/rdAJyCputdyg7qdzadSGCHU/tVza/tfU/Ur8mBQ==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:36:50 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:36:50 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 05/12] dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
Date: Wed,  3 Jun 2026 17:36:16 +0300
Message-Id: <20260603143623.3712024-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: f156b187-cc8b-4fca-a458-08dec17d8c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	R0d6Ul5NNYxdwZ2EZhfqxGXwei8smFE15Us5d+HmD1Lml4swR1r2RcxUfHTxJXtDpAQ39vFT2tkvw7MqHievOpd1XYEntX+m51QUNIuPuFI2c/MRzT0Dwabzl2w+U2f6riV7MQ8kZGQ4jH/LCQnw1UxAb6WydeaLnExV9kPQDr5bMvc70nO0nTr2+DISb1JeW3LmQa8TPkuN/MlmgIlQD7KRY3qlVWCVLP/HVbEc5I0Htcv0Hmt3S4gol5YLkfpb1x1q28moGgnWbm3smHYbLns5gNbx3PDf5HqDHgLlCjBrnXvkrs0AjMcSL96uIKMHdyWPNlNVl0Xc0lqwuKbYikGZt6v+ZmEox+UKLGIDymDcRbeNQW0Bvkb+xj/cHUi8IIv4NjjtTARV53S5gIeKTlf//o7zMmeELsnNbD+FDeXcmjjFZpxFX18GYJlulD7XadQSvuAO1qda223MZADg7so81qCbcv+QElnVCXGMT69wJ3dewbAjXLwDFFzXUoBfsZf4yvkfTfS5f3NYIo471MUZv/fvSR288lf3mmFVBCQOtXP7/B73SZ7S6spnECoX7VTGIKSVfZdINY50MS3PRHqmi+NzxmOXn02xhaOf/uMaF2Imv6GNf/4YvV0FTynOOqI9N41vmheQlrjHwTg4Alt22W4fqdrKGagxEhy816txXzwHWHHT+1Pu8Cketofo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3zYgzcD7kUm995jqWM/1VkkqyLpEMlDWHSQmPCUjVVV9u6839dP5qTtAIQNS?=
 =?us-ascii?Q?4kpXXgsn6JJoYMYfm73vdPdsfjKwgAncNgjxb4HmYy1sXCA37vrNaD4jGqQz?=
 =?us-ascii?Q?TZBhyNLnZYelrNzD4XN7xG30sVXy3aIxS0RgOhvXHedS90/HvDqVH7eIGvZy?=
 =?us-ascii?Q?ArhfkoEeyDgqlPRPAgO1+wZsvpwyTYKVswisWQMWK1FMPr0TtNBMC7SENr+J?=
 =?us-ascii?Q?KJgYCqSRpO7RMsq47wuaBymNi900fC1owen6BFNNZ6SebCz3VNduaDM8UlfL?=
 =?us-ascii?Q?urjxFNme0bwrxzpLYvPT2rlGlQKoQzRcX7aDEHx1jdLXKfx0TWHpcF8i28tg?=
 =?us-ascii?Q?WO9clZXOltmDQilpasSqmYxH0UOkwJZ1WRvW/jiHw0nY3nEiqG3cvg5g8yuw?=
 =?us-ascii?Q?vU4sl5IYsDIb0ClKYIIKakdtex2VIjOc9PCH5Psm4oWOUKWWrmfmqEy58fGl?=
 =?us-ascii?Q?7N4xrMdo5F+MyAeWNN9h4PKkimKycQ9ZygdMbGhkOSj44tSKuOvs9fOTTmfj?=
 =?us-ascii?Q?F5hmO2tgKi4uxUZJlUtIIiqUn8JbImUJzZuuYqVYvjC9BdgWOPsnleXY4734?=
 =?us-ascii?Q?SD5THg7A49CrvdidoEwglSivvFPHwZc7qHhMWiI3QQ4uFqbw2DspS2qD5KrP?=
 =?us-ascii?Q?BNbbWsxFZxmuVwkjwMKlTWxYzyn0snxGR3NFaYEYCZ9/nDom1GjOYNwfudKn?=
 =?us-ascii?Q?BdIiJzCseDXAkG5JzP7Fozgo1kOFeqvl0MZ6gMSkT8SDbGrD6kYwyZHOI0CK?=
 =?us-ascii?Q?RbfoEF7pcqYLw0aypxhn9BR7xD4UTz4SovQaKkFExwLpFmzrXupX+9NK5HD9?=
 =?us-ascii?Q?Pg83VBldUvenC2huFObm8oMFgOkq6m0NWvEK/MHWH+E5MA9GpAvt6ESmhwgk?=
 =?us-ascii?Q?FM9h102/Idx5w1p/efNP1I3Fcw/oZehvODTNcZ2eBRUE2+m/aPk/AljwQ4ME?=
 =?us-ascii?Q?pdrM/vypQ4pWH08REkXfKQwHMiWwTy1NZ3u8ycnle4g7OkauIHrXWQuhEj1S?=
 =?us-ascii?Q?bIf/vGIH0osrniw+5vDg0GS2FwNIR0uGGbczS5lE4f3wKodq3nvB92cx460h?=
 =?us-ascii?Q?u6SMV9T7mzTEojLgJmxDlTHTUWhDyz+LOGO1sJUfMNhVhnKyTwZazFBNYyEv?=
 =?us-ascii?Q?Sfk5/lzlvMezkFJ3CZXDE6q7grR3dLg/wfZ9jDwzubdEOwKdqnm1PrLKeUym?=
 =?us-ascii?Q?4eMjdELy9iVRZt6/EjJBq2DDSLsibAbdkrtNFFChGt8X4Lj2o/Dv4SBV5ng7?=
 =?us-ascii?Q?7gFVkhwM4rYf/lVzn1G1gWje0N5YbbZjpSihzCI6Vd/97sJzI4/LGPrkJtm3?=
 =?us-ascii?Q?rtPuY296vyWhOKxfPW6PYhNPgVW1AiPAratuWqXdS60oC9Gs7oD2STbrgFK2?=
 =?us-ascii?Q?rDEXjWMiLs10XdWRFHw3JiLQ9EcZcGHu/NXBWL/Sd9KYqJYrSWqsqLrt2aUr?=
 =?us-ascii?Q?udfVI6V6tD2RgMjfVUve0fDJnSnLu26eL7Lwp9iWkALs87QhngqI6LJOGFLD?=
 =?us-ascii?Q?lp3+20HPB3+JGnEFKUg1qG4/p8wJbGZ8zZhSFN7GToyDZ9qCpcYtkAhq+fm5?=
 =?us-ascii?Q?sVP6cRRxWvDvPdgeaBBceh96wFC/m/nKLtId4R5k2IjFrcpK0qknZEBIomiD?=
 =?us-ascii?Q?pyR31IjHgupyq0/Nj5cp8MqC1Xr8bDJLE4mPtR7cWvQTB4e9Mfm8viOfl/i9?=
 =?us-ascii?Q?vKdiDj5Y+B79diIHls327ibdjB7A3Q4BpI9KHfYSE2R9f6ge/WOfv5BNaVtE?=
 =?us-ascii?Q?g8tYw5UsvQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f156b187-cc8b-4fca-a458-08dec17d8c21
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:36:50.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTNw0xe7BhweLCSF77DAfy6ujI0SOgvB/3bexmeHnEvkOqrpqQeCTKD9RYJXpgR4OYFwdC3SicYIDkjpLn4QCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294782-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE3D3638C44

With the addition of offloading support for upper bond devices we have
to let the switchdev framework know if a specific bridge port is
offloaded or not, even if that port is bond device.

For this to happen, create the dpaa2_switch_port_to_bridge_port function
which will determine the bridge port corresponding to a particulat DPAA2
switch interface and use it in the switchdev_bridge_port_offload call.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- Access lag field through rtnl_dereference() so that we adapt to the
__rcu change.
- Check that the brport is non-NULL before calling
switchdev_bridge_port_unoffload() on it.

Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index b851376b8e1b..87cb8270f30e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2105,6 +2105,21 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static struct net_device *
+dpaa2_switch_port_to_bridge_port(struct ethsw_port_priv *port_priv)
+{
+	struct dpaa2_switch_lag *lag;
+
+	if (!port_priv->fdb->bridge_dev)
+		return NULL;
+
+	lag = rtnl_dereference(port_priv->lag);
+	if (lag)
+		return lag->bond_dev;
+
+	return port_priv->netdev;
+}
+
 static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 					 struct net_device *upper_dev,
 					 struct netlink_ext_ack *extack)
@@ -2112,6 +2127,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *brport_dev;
 	bool learn_ena;
 	int err;
 
@@ -2123,7 +2139,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	dpaa2_switch_port_set_fdb(port_priv, upper_dev, true);
 
 	/* Inherit the initial bridge port learning state */
-	learn_ena = br_port_flag_is_set(netdev, BR_LEARNING);
+	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
+	learn_ena = br_port_flag_is_set(brport_dev, BR_LEARNING);
 	err = dpaa2_switch_port_set_learning(port_priv, learn_ena);
 	port_priv->learn_ena = learn_ena;
 
@@ -2137,7 +2154,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		goto err_egress_flood;
 
-	err = switchdev_bridge_port_offload(netdev, netdev, NULL,
+	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
+	err = switchdev_bridge_port_offload(brport_dev, netdev, NULL,
 					    NULL, NULL, false, extack);
 	if (err)
 		goto err_switchdev_offload;
@@ -2172,7 +2190,14 @@ static int dpaa2_switch_port_restore_rxvlan(struct net_device *vdev, int vid, vo
 
 static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
 {
-	switchdev_bridge_port_unoffload(netdev, NULL, NULL, NULL);
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct net_device *brport_dev;
+
+	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
+	if (!brport_dev)
+		return;
+
+	switchdev_bridge_port_unoffload(brport_dev, NULL, NULL, NULL);
 }
 
 static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
-- 
2.25.1


