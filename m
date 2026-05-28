Return-Path: <netdev+bounces-292784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFROA3F/GGpBkggAu9opvQ
	(envelope-from <netdev+bounces-292784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:46:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBAD5F5DB2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2960312794F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140A3FF1BB;
	Thu, 28 May 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a9WNSIlh"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A252407583;
	Thu, 28 May 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989709; cv=fail; b=iJpVvUpB9zKJqQwlW/nL+2QzdhGExSwhF7Ys2lZmLRxopxNbWievs9h6DxjL+uWnbrsMmIbBm4LHCyY03miI3FZ88mQHaIMPxGwcXa7x1JfYBMuHS3L/ZACPVbI5e6t7I9/hYSwdGxAo/KLFGimI34BrMusH3/7yZ/oZUHmoT50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989709; c=relaxed/simple;
	bh=vWyg3y9OvFIZosQHFinNhJYy6aIoQ7lsq9Lpinrszno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rM9CrcqgBp5uigJM1v+co5jtIBNrRLauO+WwJLidUfcEUulHFmwA5oD87QwMZQgrcXL+yrM23SNfUNs64PoGh9Y8ZGce+cSZxBndJTMYDD3XZUxOpqFQV1oSMWzuaWkC/dy9VikNz6FK/gtMwiFUjMub9+/GP9Y+fheS66jHLsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a9WNSIlh; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcmhcGVgEbszBXsuSYZVQociGz/7Wu1zfGUSKkKnsjvk0d/qfdh1VbU1cP7XH7+/cGDSgzDfmJAdUKQ/xGzife+zkpN34RXO7aCU3nakeAy7hHOabQ7CFbujuu9Q2B94aIDZrrV3BH2NPBAacPRnSI+POMJKfBLYnD+bjWGOB74CbejF1kUmEFcTbtGrt8LyNADnrRlXSgRfPAyQoBwES08r1Y0bEocGZj0u7cWLgpFJOyGAJT0fWKGsHLQJpQwbGjrJV/l2sZAPBniPVNNzbhxx5ollde+I9nEoKPV7Y86oLu/BQKEuffqKt1mDAcz4hyDsNtsoFbLCukFc2E6ZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8riqTggaE4PC25T/pYWr1SDYOTdqT20DV63Bo9L4iS0=;
 b=OHNhmN4sV6DSqDkZyOdpKU9SPHnXYZY6rke91tX65kKGWzFVnuBLCueYfiKuRr8W73UaHTbh1EwTVEUlqf0qap+EpMl4vK5XCXoqCOn3yTVwimz4jwxV1tuuLpJW0MNif47FNg4EFeJhMw1Nwj2ySKNx35YEZdXrJb6bmh1jASsIyQfv39DPfPpCx0Fak5lzz2d4yXaziPJ7/hQBnsFUZ9hS4Ugz3VGh5Uy+KfMrED8sFn2u7/amTVlleo+0I6hGkwx3XBANSwXqeS4DINmIKKdHK+bzbmZgSemmdc9K/TGDda2WKPxPjOz2Kl0aVloYqZ6xGEmDNX5IFM3EBckvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8riqTggaE4PC25T/pYWr1SDYOTdqT20DV63Bo9L4iS0=;
 b=a9WNSIlhSduaWwFkRDgDN98Ryy2kEamGepukIaZN4f+yoRsSKgdVr8TLj3JHeFLi/ww6SRKmS3BLuSKEVYSYR0k6ztSmkxpIF1XIHj47gCB4kjk3ZFxBe352hUla/6uYnuYyERWDE+ZoGHuTj1QVqGfE93NqQQoC4l58Cp6DtQy750Ht7HcQt5Sc72qrp7MdpUDhNCJZTnAWjC5tzH97JvfqchN9XGKLp2PAu/Owk2iilK1oKq7n/TLywtsZXqf/k76D6zK6aNOye0NfHQq8lZWAULb3gsSKMpfIIHlmj87qtbAHZTy1YDoZm6WH9AgOJQwzgVOYJ1DKY2eE31kKsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DU0PR04MB9657.eurprd04.prod.outlook.com
 (2603:10a6:10:31c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 17:35:04 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 17:35:04 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] dpaa2-switch: rework FDB management on the bridge leave path
Date: Thu, 28 May 2026 20:34:48 +0300
Message-Id: <20260528173452.1953102-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
References: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::14) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DU0PR04MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d6d217-1efa-413d-3157-08debcdf73f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KEY2M8+x5CukSiDMeYOXIC2NBhCMpda4+4YgstqiBNc2ecNukP+P7wxeiwIwKO16KKYy1U++KH+JaSj8XemfmlTFoe16PZl9IuwsVsE1npi9Z3JKRdMlOUZ4jYq7elA3yJasehLGW7LAxFM0euvOoJHczpQtCCwQZD3ZmDGQSWd3GhgttU+vYOtMmUmgkWVrBcu+Ary/leKJcHBsO5IEkKgsm9AfGp6vNzWH0MjwMrxCHxFlvNExnQYGByASoKutleOn/xEH8/LioHCWAVK27qvG6wzmPfGwLUFqDaOZlkBYxk8Dfr5P5W8UlBjivaoc6BkWHFZgY1H8QVpgMciSwCantmQbSYPb+mTxcJvuMDrAKnlp09ZRJhJ+TR2CHWcsdQp6REQb5QfRGNxUALx9SCjTMaf+/kaonCTWWur6e59FnkN8ixUM8ifgL2D5S76wLQa6MvKhTZ2fzg4/aOXKwVooi18CZKVMHhwJwbExLqkgaDak7oEDCWS3Zhxd/o/ceD5XudkbmDquSjxiY7FHRThEASjBB64R3yR0AggZ8Omo8q+0nZwVAlKHKGBGeSZA96+zqzbGjifearrBcqmgvUrBLU3SI+QqsqAy97UeDVauaMYadx9IoB7pTAO31xlq1P+auB4lrD/hGPpemSkrOC9mXTnlK5CCy1+KVZtuuwxDxe4DHVIE0OaES/TnGZJC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m5xFs7p6o+ITXkIycN9k7fBg2hxaNJ3nzAn+16/kOHxeKgHj06zlXUOF1O3q?=
 =?us-ascii?Q?clSqGTPzldSUYUjgBG3tmMdCNo4PmVWaOyjqGKbWPGS81SiFl05GAh+f8Xrv?=
 =?us-ascii?Q?yrxFpyKrKAPFIHcnHfWZ5aQ7NHqGmr9fcD4u9M59lcQTchMmImggZUv6lW+e?=
 =?us-ascii?Q?5Tk9g5aapXYfl2jEkcIaqlVp/BZoECCGepO60DPOVn9nqgTJkrSfMWTig/mS?=
 =?us-ascii?Q?e0zO6dKiACU5fUDa9UyGg3c5G1pVTdMEVZDS4WjiU1Lkip5VG4bY0rc1YaGg?=
 =?us-ascii?Q?8lHWlODelaAqF023+p8GLelOkdStI/q1ci+kzh+3cGetP50i5n5TFB2XFzcA?=
 =?us-ascii?Q?Gf4c0SzqmJg8Yud/c0SsYn/WSG4NSLtEA2vdS4DHjNlcMUFKXbQ3HG1d/CBz?=
 =?us-ascii?Q?TQSggMqTwAw05WE1qR/tLqSLNDwuIQKD/srWsbhC/kjUUR6fCTvYaMYISB/+?=
 =?us-ascii?Q?qXuJw29Gn52WUcCgeejo5ZfJ0bBsYh0i5eGH1WulJW6p/Dt6H+8UdwyNMeOy?=
 =?us-ascii?Q?qyvMyfqZPamxtbO3nV7n4BwVpSpiJ1fToOUU3Q1qP5jtj9RqTU4DP+oM8rQe?=
 =?us-ascii?Q?XzVGr7q14UdlSr0UIghKFIx8ywFgL16MRsyCS63bo91uYOenWOL/Bs1+xDzp?=
 =?us-ascii?Q?ghlCYEcuOI3dvyG4Tmg/hGSBcY1g2c9b+39/8cqrnNSEsY5zLCprv4kfAk+m?=
 =?us-ascii?Q?vWkc/qj1NXVuys/TeK7aH5iwm1HG1rAfar/gebBu28nOoo2LXzPmnk5doz3H?=
 =?us-ascii?Q?idskhZVW81RRogpgLzt1J4IOcO7dYdZ/QmfCERXdDO+4GmhbMucW1QN44H8D?=
 =?us-ascii?Q?nuJ34bN2IDoXj3/Fh4PHSJtwPvGEysYfRUx+b03UpTUwAIo44ljjVcaVY0Ta?=
 =?us-ascii?Q?t+qnn3RsH3ee+FuxlDba8WaD3M5fWIVUnBBHw0VqTDAk/048yjU6e7soiZZr?=
 =?us-ascii?Q?98dOEEnfdAtAdh99MG4rD08oSMof7rC7DNtFTTICq7I8tSwwIMbgoVVWwWs6?=
 =?us-ascii?Q?HrhQOybiu2C/zHjo21NeZ9kFxiMnUm7wHXwCOCBBq56cyJKPaV9d4fhsO/ME?=
 =?us-ascii?Q?DR4XCPm6A6y0LdyTQeEi7uyLkbj0mt9ZvUPqFv7nRmmkGKiIwbNXlfbBud0S?=
 =?us-ascii?Q?fRrScpTxiqmY0+NYwC365GQVKRBPxdapFMuHoP/PFn9PWW9dmmIdXe8JOFpJ?=
 =?us-ascii?Q?KwrzD3fg+7Fi9z1MW4HK69wlXXzFmooH8OJN3Klf5kse6JlqFGXNgaiwFobh?=
 =?us-ascii?Q?usvx0rz1tHq12aqTkeLU9vl+GX6ZDFi4SYz6B4oMkTLBN8NkDKyu+u4zHMWk?=
 =?us-ascii?Q?pT6QwNcZkFIuMFAzwcquYn8hZT1UO7EjQUyFLFl56HewKM5doE76q7DOkcgu?=
 =?us-ascii?Q?A1KWrXH195Oo3vckflJ2zAD+MFFtc7CDUjfUkZ8X+tfkt1DXKNiRYeQ6dKRx?=
 =?us-ascii?Q?6xYTAaC6zYVKtVLv3kbEr7pI9ywky7dszSfCQV0DXDgz2zyIUx6GKNv/JDZb?=
 =?us-ascii?Q?PffeWziP0I6KPK/pUe9LM0pK7Rw9XjsU+uuhg/5LqHyd3/hdL3S1i23YMhnq?=
 =?us-ascii?Q?49uX2rQEiFrNrP15+xMUlHAkuIyfvnPD5DxhEDIfXY5pYwsJSGaNhA8sdeYy?=
 =?us-ascii?Q?gdJP1OQSEIaYGkEk3f0Nt2os/j6TZ0OgEJec/yuUFj4B8WiQeYbeUNgCuuk/?=
 =?us-ascii?Q?b5rcXVGzU5ATu8//2uQKRpaJ0Tmt5OEZkefJNK+R4csvV0L43iw/0KnevwOU?=
 =?us-ascii?Q?L+lNz2/wcA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d6d217-1efa-413d-3157-08debcdf73f2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 17:35:04.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28vguB4ICeybuR+8VXyopoK9u3LFhSq9Uh2SibhYON5BghrmW4VDTKm/k4v3an/jfSVtwrwHK7+4yRBaCA+urA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9657
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
	TAGGED_FROM(0.00)[bounces-292784-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8FBAD5F5DB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On bridge leave, the dpaa2_switch_port_set_fdb() function always
allocates a new FDB for the port which is becoming standalone. In case
no FDB is found, then the port leaving a bridge will continue to use the
current one.

The above logic does not cover the case in which there are multiple
bridges which have ports from the same DPSW instance. In this case, when
the last port leaves bridge #1, it finds an unused FDB to switch to, but
the old FDB is not marked as unused. Since the number of FDBs is equal
to the number of DPSW interfaces, this will eventually lead to multiple
ports sharing the same FDB.

Fix this by changing how we are managing the FDBs on the leave path.
Instead of directly allocating a new FDB, first verify if the current
port is the last one to leave a bridge. If this is the case, then
continue to use the current FDB and only allocate another FDB if there
are other ports remaining in the bridge.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 31 ++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 52c1cb9cb7e0..782fef26b78e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -54,27 +54,44 @@ dpaa2_switch_filter_block_get_unused(struct ethsw_core *ethsw)
 static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				     struct net_device *bridge_dev)
 {
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct ethsw_port_priv *other_port_priv = NULL;
 	struct dpaa2_switch_fdb *fdb;
 	struct net_device *other_dev;
+	bool last_fdb_user = true;
 	struct list_head *iter;
+	int i;
 
 	/* If we leave a bridge (bridge_dev is NULL), find an unused
 	 * FDB and use that.
 	 */
 	if (!bridge_dev) {
-		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
-
-		/* If there is no unused FDB, we must be the last port that
-		 * leaves the last bridge, all the others are standalone. We
-		 * can just keep the FDB that we already have.
-		 */
+		/* First verify if this is the last port to leave this bridge */
+		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+			if (!ethsw->ports[i] || ethsw->ports[i] == port_priv)
+				continue;
+			if (ethsw->ports[i]->fdb == port_priv->fdb) {
+				last_fdb_user = false;
+				break;
+			}
+		}
 
-		if (!fdb) {
+		/* If this is the last user of the FDB, just keep using it. */
+		if (last_fdb_user) {
 			port_priv->fdb->bridge_dev = NULL;
 			return 0;
 		}
 
+		/* Since we are not the last port which leaves a bridge,
+		 * acquire a new FDB and use it. The number of FDBs is sized to
+		 * accommodate all switch ports as standalone, each with its
+		 * private FDB, which means that dpaa2_switch_fdb_get_unused()
+		 * must succeed here. WARN if not.
+		 */
+		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
+		if (WARN_ON(!fdb))
+			return 0;
+
 		port_priv->fdb = fdb;
 		port_priv->fdb->in_use = true;
 		port_priv->fdb->bridge_dev = NULL;
-- 
2.25.1


